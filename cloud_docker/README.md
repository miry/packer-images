## CloudDocker

1. Build base centos image `../cento7`
2. Get the cloud docker token:
 - Go the https://cloud.docker.com
 - Add a new node via [Bring your own Node](https://cloud.docker.com/app/miry/nodecluster/list/1)
 - Copy the token from the command `curl -Ls https://get.cloud.docker.com/ | sudo -H sh -s <token>`
3. Run packer build example for MacOS:

 ```bash
 $ packer build -var cloud_docker_token="<put token here>" -var fusion_app_path="$HOME/Applications/VMware Fusion.app" cloud_docker.json
 ```

# Links:
- https://cloud.docker.com
