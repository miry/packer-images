CENTOS_VERSION=1908
IMAGE_NAME=centos-7-packer-${CENTOS_VERSION}
IMAGE_PATH=output-qemu/${IMAGE_NAME}.qcow2

.PHONY: run
run: ${IMAGE_PATH}
	qemu-system-x86_64 -machine type=pc,accel=kvm -smp cpus=4,sockets=4 -m 4096M \
					   -name ${IMAGE_NAME} \
					   -netdev user,id=user.0,hostfwd=tcp::4141-:22 -device virtio-net,netdev=user.0 \
					   -drive file=${IMAGE_PATH},if=virtio,cache=writeback,discard=ignore,format=qcow2 \
					   -display sdl

.PHONY: build
build: ${IMAGE_PATH}

.PHONY: clean
clean:
	rm -fr output-qemu packer-cache

output-qemu/centos-7-packer-%.qcow2:
	@./build.sh
