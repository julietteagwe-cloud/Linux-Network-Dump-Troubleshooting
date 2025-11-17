#!/usr/bin/bash

# ============================================================
# Script Name : Tips for Troubleshooting Network Problems
# Author      : Juliette Joseph
# Purpose     : Interactive network troubleshooting for Ubuntu and CentOS someone else can follow along
# Date        : 11/15/2025
# Course      : Linux Administration.
# ============================================================

# Ask which server the user is on (Ubuntu or CentOS)

echo "Which server are you using?"
echo "1) Ubuntu"
echo "2) CentOS"

read -p "Enter 1 or 2: " choice

echo

# -------- Ubuntu Section ----------
if [ "$choice" = "1" ]; then

    echo "You selected: Ubuntu"
    echo "Basic network checks will run now."
    echo

    # 1) Show IP addresses
    echo "Command: ip addr"
    ip addr
    echo
    echo "Tip: If no 'inet' line is shown, enable DHCP or set a static IP in /etc/netplan."
    echo

    # 2) Test raw Internet reachability (no DNS involved)
    echo "Command: ping -c 3 8.8.8.8"
    if ping -c 3 8.8.8.8; then
        echo "Result: Internet reachability is ok (ICMP to 8.8.8.8 works)."
    else
        echo "Result: Internet Connectivity FAILED!"
        echo "Try: check virtual machine adapter, 'ip route' for a default gateway, or:"
        echo "      sudo netplan apply"
        echo "      sudo systemctl restart NetworkManager"
    fi
    echo

    # 3) Test DNS resolution
    echo "Command: ping -c 3 google.com"
    if ping -c 3 google.com; then
        echo "Result: DNS looks ok (google.com resolves and replies)."
    else
        echo "Result: DNS FAILED"
        echo "Check /etc/resolv.conf for 'nameserver 8.8.8.8' or your local DNS."
    fi
    echo

    # 4) Show default gateway and route table
    echo "Command: ip route"
    ip route
    echo "Tip: You should see 'default via <gateway-ip>'"
    echo

    # 5) Quick traceroute
    if command -v traceroute; then
        echo "Command: traceroute -m 5 google.com"
        traceroute -m 5 google.com
    else
        echo "Traceroute is not installed. To install: sudo apt install traceroute"
    fi

# -------- CentOS Section ----------
elif [ "$choice" = "2" ]; then

    echo "You selected: CentOS"
    echo "Basic network checks will run now."
    echo

    # 1) Show IP addresses
    echo "Command: ip addr"
    ip addr
    echo "Tip: If no IP address is shown, verify your interface config is UP, use DHCP or static with nmcli or ifcfg files."
    echo

    # 2) Test raw Internet reachability
    echo "Command: ping -c 3 8.8.8.8"
    if ping -c 3 8.8.8.8; then
        echo "Result: Internet reachability is ok (ICMP to 8.8.8.8 works)."
    else
        echo "Result: Internet reachability FAILED!"
        echo "Try: check VM adapter, 'ip route' for a default gateway, or:"
        echo "      sudo systemctl restart NetworkManager"
    fi
    echo

    # 3) Test DNS Resolution
    echo "Command: ping -c 3 google.com"
    if ping -c 3 google.com; then
        echo "Result: DNS looks ok (google.com resolves and replies)."
    else
        echo "Result: DNS FAILED."
        echo "Check /etc/resolv.conf for 'nameserver 8.8.8.8' or your local DNS."
        echo "Common DNS Servers: 8.8.8.8 (Google), 1.1.1.1 (Cloudflare)"
    fi
    echo

    # 4) Show default gateway and route
    echo "Command: ip route"
    ip route
    echo "Tip: You should see 'default via <gateway-ip>'"
    echo

    # 5) Quick traceroute
    if command -v traceroute; then
        echo "Command: traceroute -m 5 google.com"
        traceroute -m 5 google.com
    else
        echo "Traceroute is not installed. To install: sudo dnf install traceroute"
    fi

# -------- Invalid choice ----------
else
    echo "Invalid choice. Please run the script again and enter 1 for Ubuntu or 2 for CentOS."
fi
