BUILD_DIR := build

.PHONY: all clean run

all: $(BUILD_DIR)/nos.img

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/boot.bin: boot/boot.asm | $(BUILD_DIR)
	nasm -f bin $< -o $@

$(BUILD_DIR)/nos.img: $(BUILD_DIR)/boot.bin
	cp $< $@

run: $(BUILD_DIR)/nos.img
	qemu-system-x86_64 -drive format=raw,file=$(BUILD_DIR)/nos.img

clean:
	rm -rf $(BUILD_DIR)