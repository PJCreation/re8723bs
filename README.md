不知道因为什么，现在的debian12.7版本已经不再出现这个问题，我已经转到debian12.7版本了。

# re8723bs
因为，rtl8723bs的缓存溢出问题总是出现，导致rtl8723bs不可用。在之前的版本中它的驱动是独立的，我们可以自己编译驱动[(Patch Site)]([LKML: Tomas Hlavacek: rtl8723bs memory leak](https://lkml.org/lkml/2017/6/12/504))，而后来它的驱动并入linux内核，无法通过自己编译内核修复这个问题，又因为rmmod -> modprobe 可以让它暂时可用([Temporary Solve]([错误 #1720580 “RTL8723bs 错误：错误 sd_recv_rxfifo：alloc recvbuf...”：错误：linux 包：Ubuntu (launchpad.net)](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1720580)))。而rtl8723bs失效的标志是会在系统日志中生成
``$date $time $hostname kernel: rtl8723bs mmc1:0001:1 wlan0: sd_recv_rxfifo: alloc recvbuf FAIL!  ``
这样的一条日志，并且同时出现两次（~~我猜是因为rtl8723bs是包含蓝牙和WiFi两个模块~~），所以用tail检测系统日志内容并计数，既不会重复执行，又能及时重载模块。

为了确保脚本开机时自动启动，可以创建一个systemd服务。这样，服务将以root权限运行。以下是创建服务的步骤：

1. **创建脚本文件**：首先，保存脚本到`/usr/local/bin/re8723bs.sh`。

2. **创建systemd服务文件**：在`/etc/systemd/system/`目录下创建一个名为`re8723bs.service`的文件。

3. **启用和启动服务**：使用以下命令启用并启动服务：

```bash
sudo systemctl enable re8723bs.service
sudo systemctl start re8723bs.service
```

这个服务将在系统启动时自动运行，并且以root用户权限执行，这意味着它有足够的权限来加载和卸载内核模块。
