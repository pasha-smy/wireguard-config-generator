#!/bin/bash
#sudo apt install wireguard-tools
#sudo apt install qrencode
server_publickey="GOywaf8e2712oIOP/Y8MxBsurQOcOKh3H+zbKcn6fW0="
server_ip="175.182.221.38"
server_port=50161
routes="10.38.3.0/24"
DNS_1="10.38.1.3"
client_net="10.38.3.0"
client_name=client

clear
read -rp "Enter customer name: " -e -i "$client_name" client_name
read -rp "Enter the number of clients: " -e -i "1" number
start_ip=$(echo "${client_net}" | cut -d"." -f1-3).$(($(echo "${client_net}" | cut -d"." -f4)+2))
read -rp "Enter the start clients ip-address: " -e -i "$start_ip" start_ip
end_ip=$(echo "${start_ip}" | cut -d"." -f1-3).$(($(echo "${start_ip}" | cut -d"." -f4)+$number-1))
read -rp "Enter the end clients ip-address: " -e -i "$end_ip" end_ip
client_net=$(echo "${start_ip}" | cut -d"." -f1-3)".0"
number=$(($(echo "${end_ip}" | cut -d"." -f4)-$(echo "${start_ip}" | cut -d"." -f4)+1))

#DEBUG
echo "Network: " $client_net
echo
echo "Start IP-Address: " $start_ip
echo "[...]"
echo "End IP-Address: " $end_ip
echo
echo "Number of clients: " $number


if [[ $number -lt "2" ]]; then
                read -rp "Generated QR-codes? Y/n: " -e -i "Y" QRcodeGen
        else  
                read -rp "Generated QR-codes? Y/n: " -e -i "n" QRcodeGen
fi

# Generating WireGuard configuration files
echo "/interface wireguard peers" > mikrotik.cfg
for ((i=0; i<$number; i++)); 
    do
# Generate key pair for the client
        Client_PrivetKey=$(wg genkey)
        Client_PublicKey=$(echo "${Client_PrivetKey}" | wg pubkey)
        ip=$(echo "${start_ip}" | cut -d"." -f1-3).$(($(echo "${start_ip}" | cut -d"." -f4)+$i))
# DEBUG
echo "$client_name #$i";
echo  "Client PrivetKey ="  ${Client_PrivetKey}
echo  "Client PublicKey ="  ${Client_PublicKey}
echo "Client IP = " ${ip}
# Create client file and add the server as a peer
echo "[Interface]
PrivateKey = $Client_PrivetKey
Address = ${ip}/24
DNS = $DNS_1

[Peer]
PublicKey = $server_publickey
AllowedIPs = $routes
Endpoint = $server_ip:$server_port" >"$client_name-$i.conf"

        if [[ $QRcodeGen == "Y" ]] || [[ $QRcodeGen == "y" ]]; then
                qrencode -t ansiutf8 -l L <"$client_name-$i.conf"
        fi
# Add peers config on mikrotik config file
echo "add allowed-address=${ip}/32 interface=wireguard1 public-key=\"$Client_PublicKey\" comment="$client_name-$i"" >> mikrotik.cfg
done
