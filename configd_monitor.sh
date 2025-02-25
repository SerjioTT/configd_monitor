#!/bin/bash
# Порог загрузки CPU, при котором останавливаем `configd`
THRESHOLD=87.0

while true; do
    CPU_LOAD=$(ps -o %cpu= -p $(pgrep configd) | awk '{print $1}' | tr ',' '.')
    # Включить, если нужен монитор в терминал
    echo $CPU_LOAD
    # Проверяем, есть ли данные и превышает ли загрузка порог
    if [[ ! -z "$CPU_LOAD" ]] && (( $(echo "$CPU_LOAD >= $THRESHOLD" | bc -l) )); then
        echo "$(date): Остановка configd (CPU $CPU_LOAD%)" | sudo tee -a /var/log/configd_monitor.log
        sudo launchctl stop com.apple.configd
    fi

    sleep 5  # Проверять каждые N секунд, при 1 не успевает процесс не успевает запуститься
done
