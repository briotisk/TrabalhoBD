import re

def verificarFormatoHorario(entrada_usuario):
    # Padrão de expressão regular para HH:MM
    padrao = re.compile(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$')

    if padrao.match(entrada_usuario):
        return True
    else:
        return False

def verificarFormatoData(entrada_usuario):
    # Padrão de expressão regular para HH:MM
    padrao = re.compile(r'^\d{2}/\d{2}/\d{4}$')

    if padrao.match(entrada_usuario):
        return True
    else:
        return False

def inserirViagem():

    num_viagens = int(input("Digite o número de viagens que você deseja cadastrar: "))

    for i in range(num_viagens):

        print("Para a " + str(i+1) + " viagem:")
        data_hora = input("Insira a data e a hora da viagem (no formato DD/MM/YYYY hh:mm): ")
        #checar se está no formato desejado

        nave = input("Insira a placa da nave utilizada na viagem: ")
        while (len(nave) != 8) or (not nave.isalnum()):
            print("Parece que você digitou uma placa inválida. Tente novamente.")
            nave = input("Insira a placa da nave utilizada na viagem: ")

        origem = input("Digite o nome da colônia de onde deve partir a nave: ")
        destino = input("Digite o nome da colônia de destino da viagem: ")

        distancia = input("Digite a distância da rota utilizada na viagem: ")
        while (distancia == "") or (not distancia.isnumeric()) or (len(distancia) > 8):
            print("Parece que você digitou uma distância inválida. Tente novamente.")
            if len(distancia) > 8:
                print("A distância digitada é maior que a permitida para as viagens.")
            distancia = input("Digite a distância da rota utilizada na viagem: ")

        hora_chegada = input("Insira a hora prevista para a chegada da nave à colônia de destino (no formato hh:mm): ")
        while not verificarFormatoHorario(hora_chegada):
            print("Parece que você digitou a hora no formato errado ou valor inválido. Tente novamente.")
            hora_chegada = input("Insira a hora prevista para a chegada da nave à colônia de destino (no formato hh:mm): ")

        preco = input("Insira o preço da passagem (utilize '.' como separador decimal): ")
        piloto = input("Digite o CPF do piloto responsável pela viagem: ")
        while (len(piloto) != 11) or (piloto.isnumeric()):
            print("Parece que você digitou um CPF inválido. Tente novamente.")
            piloto = input("Digite o CPF do piloto responsável pela viagem: ")

        duracao = input("Insira a duração real da viagem (no formato hh:mm): ")
        while not verificarFormatoHorario(duracao):
            print("Parece que você digitou a hora no formato errado ou valor inválido. Tente novamente.")
            duracao = input("Insira a duração real da viagem (no formato hh:mm): ")
            
        #chamar a função de inserção do sql 

def consultarViagem():
    print("----")

op = 0

while(op != 3):

    print("O que deseja fazer?")
    print("1 - Cadastrar uma nova viagem")
    print("2 - Consultar viagens")
    print("3 - Sair")

    op = int(input(""))

    if op == 1:
        inserirViagem()

    elif op == 2:
        consultarViagem()
    
    elif op == 3:
        break

    else:
        print("Opção inválida! Encerrando aplicação...")
        break
