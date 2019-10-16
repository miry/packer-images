.PHONY: run
run: output-qemu/centos-7-packer-1908
	qemu-system-x86_64 -machine type=pc,accel=kvm -smp cpus=4,sockets=4 -m 4096M -name centos-7-packer-1908 -netdev user,id=user.0,hostfwd=tcp::4141-:22 -device virtio-net,netdev=user.0 -drive file=output-qemu/centos-7-packer-1908,if=virtio,cache=writeback,discard=ignore,format=qcow2 -display sdl

.PHONY: build
build: output-qemu/centos-7-packer-1908

output-qemu/centos-7-packer-1908:
	build.sh
