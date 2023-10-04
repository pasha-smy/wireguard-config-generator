# wireguard-config-generator
Configuration generator for new profiles for Wireguard server and client on Mikrotik.<br>
A QR code is also generated for the client in the smartphone.
# Pre installed packages:
sudo apt install wireguard-tools
sudo apt install qrencode
# Variables:
server_publickey="Enter wireguard-server public-key" <br>
aerver_ip="Enter wireguard-server IP"<br>
server_port=50161<br>
routes="10.38.3.0/24"<br>
dns_1="10.38.3.1"<br>
client_NETs="10.38.3.0"<br>
client_name="Enter wireguard-client name"<br>

# Run scripts
.\wg-gen-mikrotik.sh<br>
