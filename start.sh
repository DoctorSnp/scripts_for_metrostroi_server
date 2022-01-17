#!/bin/bash

# Цветастость
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

###### Карты

# Москва
M_KALIN="gm_metro_kalinin_v2"
M_LDL="gm_metro_mosldl_v1"
M_NEKRAS="gm_metro_nekrasovskaya_line"

# Питер
M_NVL="gm_metronvl"

# Вымышленные
M_CROSS="gm_metro_crossline_c4"
M_B50="gm_metrostroi_b50"
M_B51="gm_metrostroi_b51"
M_NEOORANGE="gm_mus_neoorange_e"
# Имя хоста
HOST_NAME="Synergy_1520"

################## параметры по умолчанию########

DEF_MAP_NAME=$M_KALIN # Калининская 
DEF_PORT=27015
#DEF_COLLECTION_ID=1251806548 # old
DEF_COLLECTION_ID=1951565770 # new

##################################################

MAP_NAME=$DEF_MAP_NAME
PORT=$DEF_PORT
COLLECTION_ID=$DEF_COLLECTION_ID
CHANGED_MAP=""

# печатает информацию по доступным параметрам
function _help {
    echo "${white}использование: $0 параметры [аргументы] ${reset}"
    echo "${yellow}
	-h  			   	печать этой справки
	-c	${green}id_коллекции${yellow}	[$DEF_COLLECTION_ID]
	-p	${green}порт_сервера${yellow}	[$DEF_PORT]
	-m	${green}имя_карты${yellow}		[$DEF_MAP_NAME]  Доступные карты:
	********* Вымышленные линии ********* 
	crossline	- Кросслайн
	b50		- b50
	b51		- b51
	neoorange - Оранжевая
	*********  Московское метро ********* 
	kalin	 	- [Калининская] 
	ldl 	   	- Люблинско-Дмитровская
	nekras		- Некрасовская линия
	*********  Питерское метро ********* 
	nvl			- Невско-Василеостровская
	Можно задавать имя карты как в метрострое, например 
	'${green}$DEF_MAP_NAME${yellow}'
    ${reset}"
}

# получает опции, переданные скрипту сборки
function get_options
{
    local OPTIND
    while getopts "hm:p:c:" opt; do
        case $opt in
            h) # подробный вывод или нет
                _help
                exit 0
                ;;
            m)
                CHANGED_MAP=$OPTARG
                ;;
            p)
                PORT=$OPTARG
                ;;
			c)
				COLLECTION_ID=$OPTARG
				;;
            *)
            echo "${red}Неизвестная опция${reset}"
            _help
            exit 1
            ;;
        esac
    done
}

# переход в каталог со скриптом
self_name=$0
dname=$(dirname $self_name)
cd $dname

# считываем параметры командной строки (если такие были)
get_options "$@"

if [[ $CHANGED_MAP == "ldl" ]] || [[ $CHANGED_MAP == $M_LDL ]]; then
	MAP_NAME=$M_LDL
elif [[ $CHANGED_MAP == "kalin" ]] || [[ $CHANGED_MAP == $M_KALIN ]]; then
	MAP_NAME=$M_KALIN
elif [[ $CHANGED_MAP == "nekras" ]] || [[ $CHANGED_MAP == $M_NEKRAS ]]; then
	MAP_NAME=$M_NEKRAS
elif [[ $CHANGED_MAP == "cross" ]] || [[ $CHANGED_MAP == $M_CROSS ]]; then
	MAP_NAME=$M_CROSS
elif [[ $CHANGED_MAP == "nvl" ]] || [[ $CHANGED_MAP == $M_NVL ]];  then
	MAP_NAME=$M_NVL
elif [[ $CHANGED_MAP == "b50" ]] || [[ $CHANGED_MAP == $M_B50 ]]; then
	MAP_NAME=$M_B50
elif [[ $CHANGED_MAP == "b51" ]] || [[ $CHANGED_MAP == $M_B51 ]]; then
	MAP_NAME=$M_B51
elif [[ $CHANGED_MAP == "neoorange" ]] || [[ $CHANGED_MAP == $M_NEOORANGE ]]; then
	MAP_NAME=$M_NEOORANGE
else
	if [[ $CHANGED_MAP != "" ]]; then 
		echo "${red} Неизвестная карта '$CHANGED_MAP' ${reset}"
		_help
		exit 1
	fi
	MAP_NAME=$DEF_MAP_NAME
fi

echo "Карта:		${yellow} $MAP_NAME  ${reset}"
echo "Коллекция:	${yellow} $COLLECTION_ID ${reset}"
echo "Порт сервера:	${yellow} $PORT  ${reset}"
sleep 2

./srcds_run -debug +port $PORT +clientport 27005 +maxplayers 3 -console \
	   	+host_workshop_collection $COLLECTION_ID +gamemode sandbox	\
		+map $MAP_NAME +ulx adduser proshaevvaleriy \
		superadmin | tee server.log

