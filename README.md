# Port Knocking

Shell Script para enviar um port knocking para um ip e no mínimo 2 portas.

**Pré-requisito**: necessário ter o netcat instalado (nc).

## 1. Instalação

Basta clonar o repositório:
```shell
git clone https://github.com/gutobrutus/port-knocking
```

## 2. Utilização

2.1. Após clonar, acessar o diretório port-knocking:
```shell
cd port-knocking
```

2.2. Executar com o padrão abaixo:
```shell
./portknocking.sh <delay> <host> <porta1> <porta2> [<porta3> <porta4> ...]
```

**Opções**:
- ***delay***: tempo entre o envio de um SYN e outro
- ***host***: Host alvo
- ***porta\<n\>***: número da porta. No mínimo duas portas.

## 3. Exemplos:

3.1. Executar com um delay de 2 segundos contra as portas 5225, 3565, 1000 no host 192.168.0.100:
```shell
./portknocking.sh 2 192.168.0.100 5225 3565 1000
```

3.2. Executar com um delay de 1 segundo contra as portas 13, 3700 no host 192.168.10.10:
```shell
./portknocking.sh 1 192.168.10.10 13 3700
```

## Referência

[ssh-port-knocking](https://goteleport.com/blog/ssh-port-knocking/)