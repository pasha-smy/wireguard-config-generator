# wireguard-config-generator
Configuration generator for new profiles for Wireguard server and client on Mikrotik.<br>
A QR code is also generated for the client in the smartphone.<br>
<br>
P.S. In the future, it is planned to expand the functionality of the script for servers based on other platforms
# Pre installed packages:
<code>sudo apt install wireguard-tools
sudo apt install qrencode
</code>

# Variables:
<code>server_publickey="Enter wireguard-server public-key"
aerver_ip="Enter wireguard-server IP"
server_port=50161
routes="10.38.3.0/24"
dns_1="10.38.3.1"
client_NETs="10.38.3.0"
client_name="Enter wireguard-client name"
</code>

# Download scripts
<code>cd wgenerator/
git clone https://github.com/graf-alibert/wireguard-config-generator.git
</code>

# Run scripts
<code>cd wireguard-config-generator/
.\wg-gen-mikrotik.sh
</code>
