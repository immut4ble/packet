#!/bin/bash

echo "+-----------------------------------------------+ "
echo "██████╗  █████╗  ██████╗██╗  ██╗███████╗████████╗ "
echo "██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝╚══██╔══╝ "
echo "██████╔╝███████║██║     █████╔╝ █████╗     ██║    "
echo "██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══╝     ██║    "
echo "██║     ██║  ██║╚██████╗██║  ██╗███████╗   ██║    "
echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝    "
echo "		Let us begin.			"
echo "Remember, enumeration is the key to success.	"
echo "Sometimes cewl will get results. Try everything,	" 
echo "ss everything. Google things, look for any name.	"
echo "+-----------------------------------------------+ "

if [  $# -lt 1 ] 
then 
	echo "This script kicks off serveral basic recon"
	echo "tasks, it needs an ip as argument." 
	echo ""
	echo "Useage:"
	echo "$0 123.123.123.123"
	exit 1
fi 

echo "+-----------------------------------------------+ "
echo "nmap fast scan to get our feet on the ground."
nmap --send-ip -F $1 -oN fast.txt
echo "done."

echo "+-----------------------------------------------+ "
echo "nmap service scan to get a little more		"
nmap --send-ip -sV $1 -oN services.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "xprobe2: what that os is?"
xprobe2 $1 > xprobe.txt
cat xprobe.txt | grep running
echo "done"

echo "+-----------------------------------------------+ "
echo "whatweb"
whatweb http://$1 > whatweb.txt
cat whatweb.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "nbtscan"
nbtscan $1 > nbt.txt
cat nbt.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "Enum4linux, not gonna cat this one."
enum4linux $1 > e4l.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "Uniscan.						"
uniscan -u http://$1/ -qw > uniscan.txt
cat uniscan.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "Nikto time, getting a bit heavier.		"
nikto -host $1 -output nikto.txt
echo "done"

echo "+-----------------------------------------------+ "
echo "Generating a cewl wordlist, might be useful	"
cewl -d 5 -w cewl.txt $1
echo "done"

echo "+-----------------------------------------------+ "
echo "SMB nmap script scan, fingers crossed.		"
nmap --send-ip --script=smb-vuln-conficker.nse,smb-vuln-cve2009-3103.nse,smb-vuln-cve-2017-7494.nse,smb-vuln-ms06-025.nse,smb-vuln-ms07-029.nse,smb-vuln-ms08-067.nse,smb-vuln-ms10-054.nse,smb-vuln-ms10-061.nse,smb-vuln-ms17-010.nse,smb-vuln-regsvc-dos.nse $1 -oN smb-nse.txt
echo "done"


echo "+-----------------------------------------------+ "
echo "Thats it for now, start running ss like crazy.    "
echo "+-----------------------------------------------+ "

