# wireguard-config-generator
Configuration generator for new profiles for Wireguard server and client on Mikrotik.
A QR code is also generated for the client in the smartphone.
# Pre installed packages:
sudo apt install wireguard-tools
sudo apt install qrencode
# Variables:
server_publickey="Enter wireguard-server public-key"
aerver_ip="Enter wireguard-server IP"
server_port=50161
routes="10.38.3.0/24"
dns_1="10.38.3.1"
client_NETs="10.38.3.0"
client_name="Enter wireguard-client name"

# Run scripts
.\wg-gen-mikrotik.sh
