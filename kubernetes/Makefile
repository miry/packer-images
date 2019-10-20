KUBE_VERSION=v1.17.0-alpha.2
CENTOS_PASSWORD="investigate"

IMAGE_NAME=kube-packer-${KUBE_VERSION}
IMAGE_PATH=output-qemu/${IMAGE_NAME}.qcow2

.PHONY: run
run: ${IMAGE_PATH}
	sudo qemu-system-x86_64 -name ${IMAGE_NAME} \
		-machine type=pc,accel=kvm -smp cpus=4,sockets=4 -m 4096M \
		-netdev user,id=user.0,hostfwd=tcp::4141-:22 -device virtio-net,netdev=user.0 \
		-drive file=${IMAGE_PATH},if=virtio,cache=writeback,discard=ignore,format=qcow2 \
		-display sdl

.PHONE: clean
clean:
	rm -fr output-qemu

.PHONY: build
build: ${IMAGE_PATH}

output-qemu/kube-packer-%.qcow2:
	@echo ${IMAGE_PATH}
	packer build -var version="${KUBE_VERSION}" -var centos_password=${CENTOS_PASSWORD} -only=qemu image.json
