## Base Centos 7 VMware Image

1. Create `http/ks.cfg` file. There is sample `http/ks.cfg.sample` that contain base packages and sample user `centos` with `sudo` permissions.
2. Run packer build example for MacOS:

 ```bash
 $ packer build -var fusion_app_path="$HOME/Applications/VMware Fusion.app" centos7.json
 ```

Or use build script to generate `http/ks.cfg` and run packer build

```bash
$ ./build.sh
```

This build is based on https://github.com/geerlingguy/packer-centos-6
