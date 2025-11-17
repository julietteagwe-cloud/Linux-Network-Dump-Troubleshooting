#!/usr/bin/bash

#-------------------------------------------------

# Script Name  : networkinfo_dump_basic.sh
# Author       : Juliette Joseph-Odogbo
# Date         : 2025-11-17
# Purpose      : This script gathers essential system and network information for Ubuntu and Centos servers
# Tested on    : Ubuntu  server 25.04 LTS and CentOS

#----------------------------------------------------------
#---- Set up variables-------------------

NAME="Juliette_Joseph-Odogbo"    # my name to tag the file

DATE="$(date +%Y-%m-%d)"               # current date in YYYY-MM-DD format

PURPOSE="networkinfo_dump"       # purpose tag for the file

OUTDIR="$HOME/net-reports"        # Directory for saving reports
HOSTNAME="$(hostname)" # automatically detect the system name
mkdir -p "$OUTDIR"               # Creates the folder if it does not exist

OUTFILE="$OUTDIR/${PURPOSE}_${DATE}_${NAME}.txt" # output file saved in my home folder whcih include my name, date and purpose for the  file

# =====================================

# HEADER SECTION

# ====================================
# This section print basic information 
echo " ======================================================="  >> "$OUTFILE"
echo "Created by : $NAME"
echo "HOSTNAME : "$HOSTNAME"
echo "Saving clean report to $OUTFILE"
echo " "
# Write dome header to the output 
{
echo "NETWORK INFORMATION REPORT"  >>  "$OUTFILE"      # Add  title to the report

echo "Created by: $NAME"  >> "$OUTFILE"               # Add my name

echo "Date: $(date)"  >> "$OUTFILE"                   # Add the current date and time

echo "Hostname: $(hostname)"  >> "$OUTFILE"           # prints the system's  hostname 

echo "File Purpose: $PURPOSE"  >> "$OUTFILE"         # Shows why this file was made

echo  "File saved as:  $OUTFILE" >> "$OUTFILE"       # Prints the full save path

echo "========================================" 

echo " "
} >> "$OUTFILE"                             # Add a blank line  for spacing

# ============================================

# SYSTEM INFORMATION SECTION
# uname -a dhows kernel version, OS version and architecture
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
# show network card, their IP addreesses and link state 
# works on both ubuntu and centos

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


# (Optional: infconfig only if installed- may not exist on both servers.

if command -v ifconfig  >/dev/null 2>&1;then
   echo "Command : ifconfig ( Legacy command, works  if net-tools is installed)" >>  "$OUTFILE"
   ifconfig >> "$OUTFILE"

   echo " " >>  "$OUTFILE"
fi

#============================================

# ROUTING TABLE AND DEFAULT GATEWAY SECTION

# shows network routing information and default gateway

#==========================================


echo "===== ROUTING TABLE AND GATEWAY ======" >>  "$OUTFILE"

# ip routes works on both Ubuntu and CentOS

 if command -v ip  >/dev/null 2>&1; then  

   echo "Command: ip route" >> "$OUTFILE"

   ip route  >>"$OUTFILE"

# Add a blank line for readability

  echo  " "  >>  "$OUTFILE"
else

  echo :Ip route command not available" >> "$OUTFILE"
  echo " " >> "$OUTFILE"
fi 

# Default Gateway only
if command  -v ip >dev/null 2&1; then

   echo "Command: ip route | grep default" >> "$OUTFILE"
   ip route | grep default >> "$OUTFILE" 2>/dev/null 
   echo " " >> "$OUTFILE   
fi 

# NetworkManager gateway (onlu if nmcli exists)

if command  -v nmcli >dev/null 2>&1; then

# Displays the gateway line from  NetworkManager's setting (if it exists)

   echo "Command: nmcli dev show  | grep -i gateway"  >> "$OUTFILE"

   nmcli dev show | grep -i gateway >> "$OUTFILE"

   echo  " "  >>  "$OUTFILE"
else

   echo "nmcli not installed on this system" >> "$OUTFILE"
   echo " " "$OUTFILE"
fi

# ==========================================

# DNS AND NAME RESOLUTION SECTION

# shows DNS settings and local hostna,e mappings on either ubuntu or centos
#=========================================



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

 # Optional: DNS Info from NetworkManager if nmcli is installed 

if command  -v nmcli  >/dev/null 2>&1;then

# Displays the DNS  addresses that NetworkManager is currently using.

   echo "Command: nmcli dev show | grep  -i dns"  >> "$OUTFILE"

   nmcli dev show | grep -l dns >> "$OUTFILE"

   echo " " >> "$OUTFILE"
   
else

   echo "nmcli is not installed on this system (skeipping NetworkManager DNS details)." >> "$OUTFILE"
   echo " " >> "$OUTFILE"
fi
# =============================================

#   CONNECTIVITY TEST SECTION

# ============================================
# This section checks basic network connectivity to verify 
# that the server can reach the internet and resolve domain names

echo " =======  CONNECTIVITY TEST ========"   >> "$OUTFILE"
#-------------------Test1: Ping External IP--------------
echo "Command: ping  -c 4 8.8.8.8  # test raw connectivity to Google DNS" >> "$OUTFILE"

ping  -c 3  8.8.8.8  >> "$OUTFILE"

echo " " >> "$OUTFILE"

#--------Test2: Test name resolution (DNS)

echo "Command: ping -c 3 google.com    >>  "$OUTFILE"

ping -c 3 google.com  >>"$OUTFILE"

echo " "  >>  "$OUTFILE"

#------------------Test3: tracerout (only if installed)---------
if command -v tracreoute >/dev/null 2>&1; then 

   echo "Command: traceroute google.com: >> "$OUTFILE"
   traceroute google.com >> "$OUTFILE"
   echo " " "$OUTFILE"

else
    echo "Traceroute is not installed on this system." >> "$OUTFILE"
    echo "To install on Ubuntu: sudo apt install traceroute"" >> "$OUTFILE"
    echo "To install on CentOS: sudo dnf install traceroute" >> "$OUTFILE"
    echo "" >> "$OUTFILE"
fi
echo"-----------------------END OF CONNECTIVITY TEST ------------" >> "$OUTFILE"
echo "Report saved to: "$OUTFILE
echo "Report saved to:  $OUTFILE"
