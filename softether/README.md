## SoftEther

1. Build base centos image `../cento7`
2. Run packer build example for MacOS:

 ```bash
 $ packer build -var fusion_app_path="$HOME/Applications/VMware Fusion.app" softether.json
 ```


# Links:
- https://www.softether.org/5-download
- http://wp.secretnest.info/archives/1529
- https://github.com/rharmonson/richtech/wiki/Installing-SoftEther-VPN-4-on-CentOS-6.5-Minimal-x86_64
- https://www.digitalocean.com/community/tutorials/how-to-setup-a-multi-protocol-vpn-server-using-softether
