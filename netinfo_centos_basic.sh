#!/bin/bash

# =============================================================
# Script Name : netinfo_centos_basic.sh
# Author      : Juliette Joseph Odogbo
# Date        : 2025-11-08
# Purpose     : This script gathers essential system and network information
#               including IP addresses, routing table and DNS settings.
#               Then performs basic connectivity tests. The results are shown
#               on the screen and saved to a dated report file for documentation.
# Server      : CentOS Stream 9
# =============================================================


# ====================== Set Up Variables ======================
# This helps easily identify global configuration values in the script

NAME="Juliette_Joseph-Odogbo"     # my name to tag the file
DATE="$(date +%F)"                # current date in YYYY-MM-DD
PURPOSE="Network_Info_Dump"       # short tag for the filename
OUTDIR="$HOME/net-reports"        # folder for reports

OUTFILE="$OUTDIR/${PURPOSE}_${DATE}_${NAME}.txt"   # output file path including name, date, purpose

# Create the folder if it does not exist
mkdir -p "$OUTDIR"


# ------------------ HEADER SECTION ------------------
# Create the header for the report (creates or overwrites the file)

echo "================ NETWORK INFORMATION REPORT =================" > "$OUTFILE"
echo "Created by: $NAME"      >> "$OUTFILE"
echo "Date: $DATE"            >> "$OUTFILE"
echo "Hostname: $(hostname)"  >> "$OUTFILE"
echo "Purpose: $PURPOSE"      >> "$OUTFILE"
echo "File saved as: $OUTFILE" >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ==================== SYSTEM INFORMATION ====================

echo "========== SYSTEM INFORMATION ==========" >> "$OUTFILE"
echo "Command: uname -a" >> "$OUTFILE"
uname -a >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ---------------- Operating System ---------------- # operating system

echo "========== OPERATING SYSTEM ==========" >> "$OUTFILE"
echo "Command: cat /etc/os-release  # show CentOS version" >> "$OUTFILE"
cat /etc/os-release >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ==================== NETWORK INTERFACES ====================

echo "========== NETWORK INTERFACES ==========" >> "$OUTFILE"
echo "Command: ip addr  # show interfaces and IP addresses" >> "$OUTFILE"
ip addr >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip link  # show interface states" >> "$OUTFILE"
ip link >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: nmcli dev status  # NetworkManager device status" >> "$OUTFILE"
nmcli dev status >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip -br addr  # brief interface summary" >> "$OUTFILE"
ip -br addr >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ifconfig (legacy, if installed)" >> "$OUTFILE"
ifconfig >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ================= DEFAULT NETWORK CONFIGURATION =================

echo "========== DEFAULT NETWORK CONFIGURATION ==========" >> "$OUTFILE"

echo "Command: cat /etc/resolv.conf  # show DNS servers" >> "$OUTFILE"
cat /etc/resolv.conf >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: cat /etc/hosts  # show local hostname mappings" >> "$OUTFILE"
cat /etc/hosts >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: nmcli con show  # show active and saved connections" >> "$OUTFILE"
nmcli con show >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ================= RESTART NETWORK SERVICE =================

echo "========== RESTART NETWORK SERVICE ==========" >> "$OUTFILE"
echo "Command: sudo systemctl restart NetworkManager" >> "$OUTFILE"
echo "NetworkManager restarted successfully." >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip addr  # verify interfaces and IP" >> "$OUTFILE"
ip addr >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ================= ROUTING TABLE & DEFAULT GATEWAY =================

echo "========== ROUTING TABLE AND GATEWAY ==========" >> "$OUTFILE"
echo "Command: ip route" >> "$OUTFILE"
ip route >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip route | grep default  # show default route" >> "$OUTFILE"
ip route | grep default >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ================= STATIC IP CONFIGURATION (REFERENCE ONLY) =================

echo "========== STATIC IP CONFIGURATION (REFERENCE) ==========" >> "$OUTFILE"
echo "Example: nmcli con mod 'enp0s3' ipv4.method.manual ipv4.addresses 10.0.2.20/24 ipv4.gateway 10.0.2.2" >> "$OUTFILE"
echo "Example: sudo systemctl restart NetworkManager" >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip addr show  # show interface configuration" >> "$OUTFILE"
ip addr show >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ip route show  # verify static route" >> "$OUTFILE"
ip route show >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: cat /etc/resolv.conf  # verify DNS" >> "$OUTFILE"
cat /etc/resolv.conf >> "$OUTFILE"
echo "" >> "$OUTFILE"


# ================= INTERNET CONNECTIVITY TEST =================

echo "========== INTERNET CONNECTIVITY TEST ==========" >> "$OUTFILE"

echo "Command: ping -c 3 8.8.8.8 # test raw connectivity" >> "$OUTFILE"
ping -c 3 8.8.8.8 >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Command: ping -c 3 google.com  # test DNS resolution" >> "$OUTFILE"
ping -c 3 google.com >> "$OUTFILE"
echo "" >> "$OUTFILE"

echo "Report saved to: $OUTFILE"
