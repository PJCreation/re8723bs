# re8723bs
为了确保脚本以高效率运行，并且在开机时自动启动，同时避免使用无密码的sudo权限，您可以创建一个systemd服务。这样，服务将以root权限运行，无需修改sudoers文件。以下是创建服务的步骤：

1. **创建脚本文件**：首先，保存脚本到`/usr/local/bin/re8723bs.sh`。

2. **创建systemd服务文件**：在`/etc/systemd/system/`目录下创建一个名为`re8723bs.service`的文件，内容如下：

```ini
[Unit]
Description=Check syslog for specific log entries and reload rtl8723bs module

[Service]
Type=simple
ExecStart=/usr/local/bin/re8723bs.sh
User=root
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
```

3. **启用和启动服务**：使用以下命令启用并启动服务：

```bash
sudo systemctl enable re8723bs.service
sudo systemctl start re8723bs.service
```

这个服务将在系统启动时自动运行，并且以root用户权限执行，这意味着它有足够的权限来加载和卸载内核模块。
