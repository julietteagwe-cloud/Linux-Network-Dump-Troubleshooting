#!/usr/bin/bash

#-------------------------------------------------

# Script Name  : networkinfo_dump_basic.sh
# Author       : Juliette Joseph-Odogbo
# Date         : 2025-11-08
# Purpose      : Dump basic network information to the screen and save it to a a file
# Tested on    : Ubuntu  server 25.04 LTS,

#----------------------------------------------------------
#---- Set up variables-------------------

NAME="Juliette_Joseph-Odogbo"    # my name to tag the file

DATE="$(date +%Y-%m-%d)"               # current date in YYYY-MM-DD format

PURPOSE="networkinfo_dump"       # purpose tag for the file

OUTDIR="$HOME/net-reports"        # Directory for saving reports

mkdir -p "$OUTDIR"               # Creates the folder if it dies not exist

OUTFILE="$OUTDIR/${PURPOSE}_${DATE}_${NAME}.txt" # output file saved in my home folder whcih include my name, date and purpose for the  file

# =====================================

# HEADER SECTION

# =====================================

# Create the header for the report; >> creates or save output to the file
echo " ======================================================="  >> "$OUTFILE"

echo "NETWORK INFORMATION REPORT"  >>  "$OUTFILE"      # Add  title to the report

echo "Created by: $NAME"  >> "$OUTFILE"               # Add my name

echo "Date: $(date)"  >> "$OUTFILE"                   # Add the current date and time

echo "Hostname: $(hostname)"  >> "$OUTFILE"           # prints the system's  hostname 

echo "File Purpose: $PURPOSE"  >> "$OUTFILE"         # Shows why this file was made


echo  "File saved as:  $OUTFILE" >> "$OUTFILE"       # Prints the full save path

echo "========================================"  >> "$OUTFILE"

echo " "  >> "$OUTFILE"                              # Add a blank line  for spacing

# ============================================

# SYSTEM INFORMATION SECTION

# ============================================

echo " ==== SYSTEM INFORMATION ===="  >>  "$OUTFILE"   # Section tile (print to screen and file)

echo " Command: uname -a"  >> "$OUTFILE"               # Shows which command will run

uname -a  >> "$OUTFILE"                               # Displays kernel, OS, and hardware info

echo  " "  >>  "$OUTFILE"

# ========================================

# OPERATING SYSTEM SECTION

#=========================================

echo "=== OPERATING SYSTEM VERSION  ==="  >> "$OUTFILE"   # Add a section title

echo " Command: cat /etc/os-release" >> "$OUTFILE"        # Shows what command is been run

cat /etc/os-release >> "$OUTFILE"                         # Displays OS name and version

echo " " >> "$OUTFILE"                                    # Blank line for readibity

# =============================================

# NETWORK INTERFACES SECTION

# ===============================================


echo " ==== NETWORK INTERFACES ====="  >> "$OUTFILE"

echo  "Command: ip addr"  >> "$OUTFILE"  # show the command to run

ip addr  >> "$OUTFILE"                   # List all interfaces with the IPV4/IPV4 details

echo " "  >> "$OUTFILE"                   # blank line for readability

# Next, show just the network device name and whether  the network is UP OR DOWN

echo "Command: ip link" >> "$OUTFILE"

# Displays link names, their states (UP/DOWN, MAC address and the MTU size.

ip link  >> "$OUTFILE"

# Leave a blank line for spacing.

echo " " >>  "$OUTFILE"

# short summary version f all interface

echo "Command: ip -br addr #(brief version if my  system supports this)" >> "$OUTFILE"

# Give a simple one-line-per interface list . Sometimes this command does not exixt  on older systems

ip -br addr  >> "$OUTFILE"

# Blank line for spacing

echo " "  >>  "$OUTFILE"

# (Optional) Ubuntu Systems may also have this older command available.

echo "Command: ifconfig  # ( Legacy command, works  if net-tools is installed) " >>  "$OUTFILE"

# shows network interfaces info using  commands  in older Ubuntu versions

# On Ubuntu Server, this command might not work unless I first install the "net-tools' package.

# It is  okay if it shows 'command not found"

ifconfig >>  "$OUTFILE"

#============================================

# ROUTING TABLE AND DEFAULT GATEWAY SECTION

# ==========================================

# Section ttle  for screen amd file

echo "===== ROUTING TABLE AND GATEWAY ======" >>  "$OUTFILE"


# Show the command that is being used

echo "Command : ip route" >> "$OUTFILE"

# Displays the my system's routing table, showing  network trafffic takes.

# Look for the line starting with 'default via' -- that is my server's default gateway.

ip route  >>"$OUTFILE"

# Add a blank line for readability

echo  " "  >>  "$OUTFILE"

# This shows only the default gateway line

echo "Command: ip route | grep default  # to view only the default route"  | tee -a  "$OUTFILE"#

# This filters  only the default gateway from the full list

ip route | grep default  >>  "$OUTFILE"

# Blank line for  readability

echo " "  >> "$OUTFILE"

# check the gateway using NetworkManager  if installed

echo "Command: nmcli dev show | grep -i gateway # ( check using NetworkManager)" >>  "$OUTFILE"

# Displays the gateway line from  NetworkManager's setting (if it exists)

nmcli dev show  | grep -i gateway  >> "$OUTFILE"

# Add a final blank line before the next section

echo  " "  >>  "$OUTFILE"

# ==========================================

# DNS AND NAME RESOLUTION SECTION

#=========================================

# Section title for screen and file

echo "====== DNS AND NAME RESOLUTION  ======" >>  "$OUTFILE"

# Show the  command for checking DNS  settings

echo  "Command: cat /etc/resolv.conf"  >> "$OUTFILE"

# Displays the current DNS Configuration (the server used to translate  names to IPS)

# Common entries inclusde 127.0.0.53 ( system-resolved) or 8.8.8.8 (Google DNS)

cat /etc/resolv.conf   >>  "$OUTFILE"

# Add a blank line for readability

echo " "  >> "$OUTFILE"

# check local hostname mappings

echo "Command : cat  /etc/hosts"  >>  "$OUTFILE"

# Shows local IP to hostname mappings used by mu server system

cat /etc/hosts  >> "$OUTFILE"

# Add a blank line for readability

echo " "  >> "$OUTFILE"

# Check DNS details using NetworkManager

echo "Command: nmcli dev show | grep  -i dns  # NetworkManager check"  >> "$OUTFILE"

# Displays the DNS  addresses that NetworkManager is currently using.

nmcli dev show | grep  -i dns  >> "$OUTFILE"

# Add final blank line

echo " "  >>  "$OUTFILE"

# =============================================

# STATIC IP AND CONNECTIVITY TEST SECTION

# ============================================

# Section title for screen and filw

echo " ======= STATIC IP AND CONNECTIVITY TEST ========"   >> "$OUTFILE"

# Explain purpose

echo "This section checks that my server keeos its static IP address and has internet connectivity"

# Show the command used to display  current IP configuration

echo "Command: ip addr # shows my assigned static IP address"  | tee -a "$OUTFILE"

ip addr  >> "$OUTFILE"

# Blank line for readability

# Display the default gateway to confirm it still exist

echo "Command: ip route  | grep default  # confirm  my gateway is set"  >> "$OUTFILE"

ip route | grep default  >> "$OUTFILE"

# Blank Line for readability

echo " "  >> "$OUTFILE"

# Test basic internet  connectivity (ICMP ping)

echo "Command: ping  -c 4 8.8.8.8  # test raw connectivity to Google DNS" >> "$OUTFILE"

ping  -c 3  8.8.8.8  >> "$OUTFILE"

# Blank line for readability

echo " " >> "$OUTFILE"

# Test name resolution (DNS)

echo "Command: ping -c 3 google.com  # tets DNS resolution and connectivity"  >>  "$OUTFILE"

ping -c 3 google.com  >>"$OUTFILE"

# Blank line for readability

echo " "  >>  "$OUTFILE"

# Check DNS server is active

echo "Command; nmcli dev show | grep -i  # confirm which DNS  servers are used" |  tee -a  "$OUTFILE"

nmcli dev show | grep -i dns  >> "$OUTFILE"

echo "" >> "$OUTFILE"
# Final message

echo "Static IP and connc=ectivity verified  successfully if pings  shows 0%  packet loss."  >>  "$OUTFILE"

echo " "  >> "$OUTFILE"

echo "Report saved to:  $OUTFILE"
