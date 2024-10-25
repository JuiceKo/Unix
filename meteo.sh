#!/bin/bash

#Requirements

DATE=$(date +"%d-%m")

site_web () {
 echo "argument 1: $1 2: $2"
}

effacement () {
rm -rf temp/download && echo "historique de téléchargement entièrement nettoyé"
}

effacement_analyse () {
rm -rf temp/analyse && echo "historique des analyses entièrement nettoyé"
}

initialisation () {
effacement && effacement_analyse
}

lien () {
[ ! -d /home/toto/Unix/tp/tp1/temp/analyse ] && mkdir -p /home/toto/Unix/tp/tp1/temp/analyse
    echo "$1-$2" >> /home/toto/Unix/tp/tp1/temp/analyse/lien
}

telechargement () {
if [[ ! -d temp ]]; then
    mkdir -p temp/download
elif [[ ! -d temp/download ]]; then
    mkdir temp/download
fi

while [ "$#" -gt 0 ]; do
 case "$1" in
   [0-9]*) cp=$1 && echo $cp;;
   [a-zA-Z]*) ville=$1 && echo $ville;;
   esac
   shift
done

curl https://meteofrance.com/previsions-meteo-france/$ville/$cp >> /home/toto/Unix/tp/tp1/temp/download/$ville-$DATE && lien $ville $cp
}


while [ "$#" -gt 0 ]; do
  case "$1" in
    -i)
      initialisation
      ;;
    -c)
      effacement
      ;;
    -e)
      effacement_analyse
      ;;
    -m)
      telechargement $2 $3
      shift && shift
      ;;
    -s)
      echo "La ville avec l'URL officielle $2"
      shift
      ;;
    -a)
      echo "Analyse de l'ensemble $1"
      ;;
    -w)
      echo "fabrication $1 pour la ville $2 à la date $3"
      shift && shift
      ;;
    -t)
      echo "option -a donnée"
      ;;
    -f)
      site_web $*
      shift
      ;;
    *)
      echo "Option inconnue : $1"
      ;;
  esac
  shift
done
