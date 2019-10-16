## Base Centos Image

1. Create `http/ks.cfg` file. There is a sample `http/ks.cfg.sample`, that specifies setup settings for centos installer, install base packages and creates an user `centos` with `sudo` permissions.
2. Run packer build example for MacOS:

 ```shell
 $ packer build -var centos_password="centos" image.json
 ```

Or use build script to generate `http/ks.cfg` and run packer build

```bash
$ make build
```

This build is based on https://github.com/geerlingguy/packer-centos-6


## Usage

It suppose to be used to build other images. Check current build:

```shell
$ make run
```
