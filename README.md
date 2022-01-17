# Дополнения для сервера
## Скрипты для сервера
**start.sh** запускает сервер метростроя (Linux). Скрипту можно передать параметры запуска.
При вызове с параметром **-h** можно получить справку по использованию.

**update_server.sh** - обновляет сервер метростроя.

**install_server.sh** - устанавливает сервер метростроя.

## Для работы аддона тренажёра
1. Библиотеки **gmsv_luasocket_linux.dll** и **gmsv_turbostroi_linux.dll**
   (старая версия) скопировать в папку **ПАПКА_СЕРВЕРА/garrysmod/lua/bin/**
2. Зеркала **mirrors.lua** скопировать в **ПАПКА_СЕРВЕРА/garrysmod/lua/autorun/**

3. Аддоны **trenager** и **falcon** (при желании) скопировать в папку **ПАПКА_СЕРВЕРА/garrysmod/addons/**
Аддонов здесь нет. Они лежат в другом репозитории.

4. В файле  **ПАПКА_СЕРВЕРА/garrysmod/addons/trenager/lua/autorun/tren_share/tren_namespace.lua** выбрать тип состава и порт, на котором будет работать аддон тренажёра
