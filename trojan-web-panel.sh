#!/bin/bash
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

change_panel(){
if test -s /etc/systemd/system/trojan-web.service; then
	green " "
	green " "
	green "================================="
	 blue "  Se detectó el servicio del panel de troyano, iniciar la configuración "
	green "================================="
	sleep 2s
	$systemPackage update -y
	$systemPackage -y install nginx unzip curl wget
	systemctl enable nginx
	systemctl stop nginx
if test -s /etc/nginx/nginx.conf; then
	rm -rf /etc/nginx/nginx.conf
  wget -P /etc/nginx https://raw.githubusercontent.com/V2RaySSR/Trojan_panel_web/master/nginx.conf
	green "================================="
	blue "     Introduzca el nombre de dominio vinculado por Trojan "
	green "================================="
	read your_domain
  sed -i "s/localhost/$your_domain/;" /etc/nginx/nginx.conf
	green " "
	green "================================="
	 blue "   Comience a descargar e implementar el código fuente del sitio falso "
	green "================================="
	sleep 2s
	rm -rf /usr/share/nginx/html/*
	cd /usr/share/nginx/html/
	wget https://github.com/V2RaySSR/Trojan/raw/master/web.zip
	unzip web.zip
	green " "
	green "================================="
	blue "       Comience a configurar trojan-web "
	green "================================="
	sleep 2s
  sed -i '/ExecStart/s/trojan web -p 81/trojan web/g' /etc/systemd/system/trojan-web.service
  sed -i '/ExecStart/s/trojan web/trojan web -p 81/g' /etc/systemd/system/trojan-web.service
  systemctl daemon-reload
  systemctl restart trojan-web
  systemctl restart nginx
  green " "
  green " "
  green " "
	green "=================================================================="
	green " "
	 blue "  Descarga del cliente universal WIN / MAC, más introducción a este script "
	 blue "  https://www.v2rayssr.com/trojanpanel.html "
	green " "
	 blue "  Guión AC Telegram Group：https://goii.cc/tg"
	green " "
	 blue "  Disfraz de Site Directory /usr/share/nginx/html "
	 blue "  Dirección de gestión del panel http://$your_domain:81 "
	green "=================================================================="
else
	green "==============================="
	  red "     Nginx no está instalado correctamente, inténtelo de nuevo "
	green "==============================="
	sleep 2s
	exit 1
fi
else
	green "==============================="
	  red "    Trojan Panel Service no detectado "
	green "==============================="
	sleep 2s
	exit 1
fi
}

bbr_boost_sh(){
    $systemPackage install -y wget
    wget -N --no-check-certificate -q -O tcp.sh "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && bash tcp.sh
}

trojan_install(){
    $systemPackage install -y curl
		source <(curl -sL https://git.io/trojan-install)
}

start_menu(){
  clear
	green "=========================================================="
   blue " Este script admite este script: Debian9 + / Ubuntu16.04 + / Centos7 + "
	 blue " Sitio web: www.v2rayssr.com (el acceso nacional está prohibido) "
	 blue " Canal de YouTube: Pozai Share "
	 blue " Está prohibido reproducir este script en cualquier sitio web en China."
	green "=========================================================="
   blue " Introducción: un clic para cambiar el puerto del panel Trojan-Panel y configurar un sitio falso "
	green "=========================================================="
	  red " Antes de ejecutar este script, asegúrese de haber instalado el programa del panel de Jrohy"
	green "=========================================================="
	 blue " 1.  Programa de implementación de gestión multiusuario rojan de TJrohy"
   blue " 2. Cambie el puerto del panel troyano y configure un sitio falso "
   blue " 3. Instale BBRPlus4 en una aceleración "
   blue " 0. Salir de la secuencia de comandos "
    echo
    read -p "Ingrese un número: "num
    case "$num" in
    1)
		trojan_install
		;;
		2)
		change_panel
		;;
		3)
		bbr_boost_sh
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "Introduzca el número correcto "
	sleep 2s
	start_menu
	;;
    esac
}

start_menu
