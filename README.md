## Скрипт для мониторинга и перезапуска процесса configd

* скрипт здесь /usr/local/bin/configd_monitor.sh
сделать исполняемым 
> sudo chmod +x /usr/local/bin/configd_monitor.sh

* логи здесь /var/log/configd_monitor.log

### Чтобы скрипт запускался при каждом включении Mac и перезапускался каждые 500 сек:

* Создать файл:
```
~/Library/LaunchAgents/com.user.configdmonitor.plist
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
        <string>/usr/local/bin/configd_monitor.sh</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>StartInterval</key>
    <integer>500</integer>
</dict>
</plist>

```

* Загружаем сервис:

```bash
launchctl load ~/Library/LaunchAgents/com.user.configdmonitor.plist
```
* Проверяем, что он работает:

```bash
launchctl list | grep configd
25951   0   com.user.configdmonitor
```
0 - значит ошибок нет

* Отключение при необходимости:

```bash
sudo launchctl unload ~/Library/LaunchAgents/com.user.configdmonitor.plist

```

