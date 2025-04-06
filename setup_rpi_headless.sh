#!/bin/bash

# Load configuration from .env file
ENV_FILE="./.env"



if [[ ! -f "$ENV_FILE" ]]; then
  echo "❌ Missing .env file. Please create one with your network configuration."
  exit 1
fi

source "$ENV_FILE"

# Detect correct mount paths, even when using sudo
REAL_USER=$(logname)
BOOT_PATH="/media/$REAL_USER/bootfs"
ROOT_PATH="/media/$REAL_USER/rootfs"


echo "📁 Verifying mount points..."
if [[ ! -d "$BOOT_PATH" || ! -d "$ROOT_PATH" ]]; then
  echo "❌ Boot or rootfs not mounted in /media/$USER. Please check your SD card."
  exit 1
fi

echo "🔐 Enabling SSH..."
touch "$BOOT_PATH/ssh"

echo "📡 Creating wpa_supplicant.conf..."
cat > "$BOOT_PATH/wpa_supplicant.conf" <<EOF
country=$COUNTRY
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="$SSID"
    psk="$PASSWORD"
    key_mgmt=WPA-PSK
}
EOF

echo "🌐 Adding static IP to dhcpcd.conf..."
cat >> "$ROOT_PATH/etc/dhcpcd.conf" <<EOF

interface wlan0
static ip_address=$STATIC_IP/24
static routers=$ROUTER_IP
static domain_name_servers=$DNS
EOF

echo "📝 Creating boot-visible IP log script..."
mkdir -p "$ROOT_PATH/etc/network/if-up.d"
cat > "$ROOT_PATH/etc/network/if-up.d/save-ip" <<'EOF'
#!/bin/bash
sleep 5
echo "wlan0 IP: $(hostname -I)" > /boot/ip-rpi.log
EOF

chmod +x "$ROOT_PATH/etc/network/if-up.d/save-ip"

echo "✅ Done! You can now eject the SD card and boot your Raspberry Pi headlessly."
