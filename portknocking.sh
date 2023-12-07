#!/bin/env bash
RED='\033[0;31m'
DARK_GRAY='\033[1;30m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LIGHT_RED='\033[1;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # no color

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
echo -e "${DARK_GREY}                                                                     v0.2.0 ${NC}"
echo -e "${GREEN}         docs/source: https://github.com/gutobrutus/port-knocking    ${NC}"
echo ""

HELP="${CYAN}Modo de uso:${NC}
    ${GREEN}$0 <delay> <host> <porta1> <porta2> [<porta3> <porta4> ...]${NC}
${CYAN}Opções${NC}:
    ${GREEN}- delay: tempo entre o envio de um SYN e outro
    - host: Host alvo
    - porta<n>: número da porta. No mínimo duas portas.${NC}
${CYAN}Exemplo:${NC} 
    ${GREEN}$0 2 192.168.0.10 2300 3252 2525${NC}
"
HEADER="${BLUE}|=========================== Iniciando a execução ============================|${NC}"

valida_host_ip() {
    local ip="$1"
    local ip_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    if [[ ! $ip =~ $ip_regex ]]; then
    # O argumento não atende ao formato básico
        return 1
    fi

    IFS='.' read -r -a octetos <<< "$ip"

    for octeto in "${octetos[@]}"; do
        if ! [[ "$octeto" =~ ^[0-9]+$ ]]; then
        # Octeto não é um número
        return 1
        elif ((octeto < 0 || octeto > 255)); then
        # Octeto fora do intervalo permitido
        return 1
        fi
    done

    # O argumento é um IP válido
    return 0
}

valida_porta() {
    local porta="$1"

    if ! [[ "$porta" =~ ^[0-9]+$ ]]; then
        # A porta não é um número
        return 1
    elif ((porta < 1 || porta > 65535)); then
        # A porta está fora do intervalo permitido
        return 1
    fi

    # A porta é válida
    return 0
}

delay="$1"
host="$2"
portas=("${@:3}")

if ! [[ "$delay" =~ ^[0-9]+$ ]]; then
    echo -e "${HEADER}"
    echo -e "${RED}ERRO:${NC} ${GREEN}O delay deve ser um número inteiro${NC}"
    echo ""
    echo -e "${HELP}"
    echo ""
    exit 1
elif ! valida_host_ip "$host"; then
    echo -e "${HEADER}"
    echo -e "${RED}ERRO:${NC} ${GREEN}Não foi informado um IP de Host válido${NC}"
    echo ""
    echo -e "${HELP}"
    echo ""
    exit 1
elif [ "$#" -lt 4 ]; then 
    echo -e "${HEADER}"
    echo -e "${RED}ERRO:${NC} ${GREEN}faltam argumentos${NC}"
    echo ""
    echo -e "${HELP}"
    echo ""
    exit 1
fi

echo -e "${HEADER}"
for porta in "${portas[@]}"; do
    if ! valida_porta "$porta"; then
        echo -e "${HEADER}"
        echo -e "${RED}ERRO:${NC} ${GREEN}a porta informada $porta é inválida!${NC}"
        echo ""
        echo -e "${HELP}"
        echo ""
        exit 1
    fi
    echo "Enviando segmento TCP com flag SYN -> $host:$porta"
    nc -z -w "$delay" "$host" "$porta"
done

echo "Envio de segmentos TCP com flag SYN finalizado"

echo -e "${BLUE}|============================== Fim da execução ==============================|${NC}"
