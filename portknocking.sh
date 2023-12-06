#!/bin/env bash
RED='\033[0;31m'
DARK_GRAY='\033[1;30m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LIGHT_RED='\033[1;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${YELLOW}                      _/_/_/                          _/      "
echo "                     _/    _/    _/_/    _/  _/_/  _/_/_/_/   "
echo "                    _/_/_/    _/    _/  _/_/        _/        "
echo "                   _/        _/    _/  _/          _/         "
echo "                  _/          _/_/    _/            _/_/      "
echo "                                                              "
echo "                                                              "
echo "                                                                               "
echo "     _/    _/                                _/        _/                      "
echo "    _/  _/    _/_/_/      _/_/      _/_/_/  _/  _/        _/_/_/      _/_/_/   "
echo "   _/_/      _/    _/  _/    _/  _/        _/_/      _/  _/    _/  _/    _/    "
echo "  _/  _/    _/    _/  _/    _/  _/        _/  _/    _/  _/    _/  _/    _/     "
echo " _/    _/  _/    _/    _/_/      _/_/_/  _/    _/  _/  _/    _/    _/_/_/      "
echo "                                                                      _/       "
echo -e "                                                                 _/_/  ${NC}"
echo -e "${DARK_GREY}                                                                     v0.1.0 ${NC}"
echo -e "${GREEN}             source: https://github.com/gutobrutus/port-knocking    ${NC}"
echo ""

if [ "$#" -lt 3 ]; then 
    echo -e "${BLUE}|=========================== Iniciando a execução ============================|${NC}"
    echo -e "${RED}ERRO:${NC} falta de argumentos necessários"
    echo ""
    echo -e "${LIGHT_RED}Modo de uso:${NC} ${GREEN}$0 <host> <porta1> <porta2> [<porta3> <porta4> ...]${NC}"
    echo ""
    echo -e "${LIGHT_RED}Exemplo:${NC} 
          ${GREEN}$0 192.168.0.10 2300 3252 2525${NC}"
    echo ""
    exit 1
fi

host="$1"
portas=("${@:2}")
echo -e "${BLUE}|=========================== Iniciando a execução ============================|${NC}"
for porta in "${portas[@]}"; do
    echo "Enviando SYN connect para $host:$porta"
    nc -z -w 1 "$host" "$porta"
done

echo "Envio de SYN connect finalizado"

echo -e "${BLUE}|============================== Fim da execução ==============================|${NC}"
