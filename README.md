## Скрипт для мониторинга и перезапуска процесса configd

* скрипт здесь /usr/local/bin/monitor_configd.sh
сделать исполняемым 
> sudo chmod +x /usr/local/bin/monitor_configd.sh

* логи здесь /var/log/configd_monitor.log

### Чтобы скрипт запускался при каждом включении Mac:

* Создаем LaunchDaemon:
```
sudo nano /Library/LaunchDaemons/com.user.configdmonitor.plist
```

* Вставляем в него:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.configdmonitor</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/monitor_configd.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

* Загружаем сервис:

```bash
sudo launchctl load /Library/LaunchDaemons/com.user.configdmonitor.plist
```
* Проверяем, что он работает:

```bash
launchctl list | grep configdmonitor
```

* Отключение при необходимости:

```bash
sudo launchctl unload /Library/LaunchDaemons/com.user.configdmonitor.plist
```

