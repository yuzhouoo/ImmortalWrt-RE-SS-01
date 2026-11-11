#!/usr/bin/env bash
set -euo pipefail

FILE="target/linux/qualcommax/image/ipq60xx.mk"

python3 - "$FILE" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
text = path.read_text()

old = """define Device/jdcloud_re-ss-01
	$(call Device/FitImage)
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := RE-SS-01
	SOC := ipq6000
	BLOCKSIZE := 64k
	KERNEL_SIZE := 6144k
	DEVICE_DTS_CONFIG := config@cp03-c2
	DEVICE_PACKAGES := ipq-wifi-jdcloud_re-ss-01
endef
TARGET_DEVICES += jdcloud_re-ss-01
"""

new = """define Device/jdcloud_re-ss-01
	$(call Device/FitImage)
	$(call Device/EmmcImage)
	DEVICE_VENDOR := JDCloud
	DEVICE_MODEL := RE-SS-01
	SOC := ipq6000
	BLOCKSIZE := 64k
	KERNEL_SIZE := 6144k
	DEVICE_DTS_CONFIG := config@cp03-c2
	DEVICE_PACKAGES := ipq-wifi-jdcloud_re-ss-01
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | append-metadata
endef
TARGET_DEVICES += jdcloud_re-ss-01
"""

if old not in text:
    raise SystemExit("RE-SS-01 official device definition changed; refusing to patch blindly")

path.write_text(text.replace(old, new, 1))
print("factory image rule applied")
PY

grep -A12 -B1 'define Device/jdcloud_re-ss-01' "$FILE"
