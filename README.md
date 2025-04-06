# 🚀 Getting Started with Raspberry Pi and remote control

This guide will walk you through the initial setup of your Raspberry Pi, including flashing the OS, booting for the first time, and connecting remotely via **SSH** or **VNC**.

Special goal: Complete headless setup of the Raspberry Pi, without ever needing a mouse, keyboard or monitor 🧠⚡ (See 3.2)

---

## 📦 What You’ll Need

- Raspberry Pi (any model)
- microSD card (at least 16GB recommended)
- microSD card reader
- Power supply for your Pi
- Monitor, keyboard, and mouse (optional for headless setup)
- Internet connection (Ethernet or Wi-Fi)

---

## 🖥️ Step 1: Download and Flash Raspberry Pi OS

1. **Download the Raspberry Pi Imager**  
   👉 [https://www.raspberrypi.com/software/](https://www.raspberrypi.com/software/)

2. **Install and launch the Imager**

3. **Choose OS**  
   Select **Raspberry Pi OS (32-bit)** or another preferred version.

4. **Choose Storage**  
   Select your microSD card.

5. **(Optional) Enable Headless Setup**  
   Before writing, click the gear icon (⚙️) and:
   - Enable **SSH**
   - Set hostname
   - Configure **Wi-Fi**
   - Set username & password
   - Configure wireless (SSID and password)
   - Time zone
   - Keyboard layout

6. **Write the image** to the microSD card and wait for it to finish.

---

## ⚡ Step 2: First Boot

1. Insert the microSD card into your Raspberry Pi.
2. Plug in the power to boot it up.
3. If you didn’t set up Wi-Fi or SSH during flashing, connect a monitor, keyboard, and mouse to configure manually.

---

## 🔗 Step 3: Find Your Pi’s IP Address
We'll now present two ways to find yout raspberry pi IP. If you already know the IP, skip to setp 4. Method 1 is using a monitor, keyboard and mouse, see step 3.1 . To find it **without** these peripherals, go to step 3.2

3.1 Using monitor, keyboard, and mouse
You can find your Pi's IP address by:

- Checking your router’s admin page  
- Using a tool like [Angry IP Scanner](https://angryip.org/)  
- Or, if you have access to the Pi, running:

```bash
hostname -I
```
<details>
<summary>3.2 The hardcore way, without a monitor, mouse, or keyboard. 😎</summary>

(*Note: this way only works if you have completed step 2.1 !!!*)

A **cooler way** that doesn't require using an interface (plugging HDMI cables into your Raspberry Pi and all that boring stuff) is if you're connected to the same Wi-Fi network as the Raspberry Pi, you can use the following command to scan all the devices connected to the network and find out the IP address of your Raspberry Pi.

After you have created the card with Debian (I haven't tested it for other linux distributions), remove the memory card and reinsert it into your computer (don't do this on the raspberry pi yet). 

- Clone the `.env.example` afile and rename it to `.env`
- Enter the real network credentials and username of your machine (not raspberry's).

```
.
├── setup_rpi_headless.sh   # Main setup script
 ── .env.example            # Config file example
└── .env                    # Config file with credentials (creat it!)

```

```sh
sudo ./setup_rpi_headless.sh
```
Expected response:

![image](https://github.com/user-attachments/assets/6833cfd7-b358-4d0a-b56e-aba073ff3210)

Reinsert the memory card into the raspberry pi. Wait a few minutes and then try step 4. 

</details>

<details>
<summary>3.3 Scanning the wifi network  (Optional) </summary>
```sh
ip a
```
Look for the Wi-Fi network interface (usually named wlan0 or wlp...) and look for a line similar to:
```
inet 192.168.0.105/24

```
Using nmap to scan others devices in your network
```sh
sudo apt install nmap
```
```
nmap -sn 192.168.0.105/24 (use your informations)
```
This command will list all connected devices along with their respective IP addresses and, if possible, hostnames. Example output:

```
Nmap scan report for raspberrypi.local (192.168.0.101)
Host is up (0.0050s latency).
MAC Address: B8:27:EB:XX:XX:XX (Raspberry Pi Foundation)

Nmap scan report for 192.168.0.105
Host is up.
MAC Address: XX:XX:XX:XX:XX:XX (Intel Corporation)
```
Voilà! Identify the IP address f the raspberry pi and use it in step 4. 
</details>


## 🔐 Step 4: Connect via SSH

From another computer (Linux/macOS/Windows PowerShell), run:
```sh
ssh pi@<IP_ADDRESS>

```
Default credentials (if not changed):

- Username: pi

- Password: raspberry


## 🖥️ Step 5: Access via VNC (Remote Desktop)
1. On the Raspberry Pi, enable the VNC Server:
```sh
sudo raspi-config
```

Navigate to `Interface Options > VNC > Enable`

2. Install VNC Viewer on your main computer, use  https://www.realvnc.com/en/connect/download/viewer/
3. Open VNC Viewer and connect to:
```sh
<IP_ADDRESS>:1
```
   



