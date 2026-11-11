# ImmortalWrt RE-SS-01

专用于 **JDCloud RE-SS-01 (IPQ6000 / qualcommax / ipq60xx)** 的 ImmortalWrt 单机型构建仓库。

## 原则

- 源码：`immortalwrt/immortalwrt`
- 分支：默认 `master`
- 仅编译：`jdcloud_re-ss-01`
- 不引入第三方插件、不精简官方网络/PHY/DSA/驱动
- 保留设备官方默认 Wi-Fi 包 `ipq-wifi-jdcloud_re-ss-01`
- 输出 `sysupgrade.bin`
- 额外用最小镜像定义补丁生成 `factory.bin`
- 构建结束强制校验两个镜像，缺失则任务失败

> 注意：当前 ImmortalWrt 官方 master 的 RE-SS-01 设备定义没有 factory 镜像规则。本仓库仅为该设备补充与同类 eMMC 机型一致的 `EmmcImage + factory.bin` 规则；其余源码保持官方状态。

## 使用

在 Actions 中运行 **Build ImmortalWrt RE-SS-01**，或者推送本仓库配置后自动构建。

刷写前请核对文件名：
- `*jdcloud_re-ss-01*factory.bin`
- `*jdcloud_re-ss-01*sysupgrade.bin`
