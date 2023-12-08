def inserirViagem():
    data_hora = input("Insira a data e a hora da viagem: ")
    nave = input("Insira a placa da nave utilizada na viagem: ")
    origem = input("Digite o nome da colônia de onde partiu a nave: ")
    destino = input("Digite o nome da colônia de destino da viagem: ")
    distancia = input("Digite a distância da rota utilizada na viagem: ")
    hora_chegada = input("Insira a hora prevista para a chegada da nave à colônia de destino: ")
    preco = input("Insira o preço da passagem: ")
    piloto = input("Digite o CPF do piloto responsável pela viagem: ")
    duracao = input("Insira a duração real da viagem: ")
    #chamar a função de inserção do sql 

def consultarViagem():
    print("----")

print("O que deseja fazer?")
print("1 - Cadastrar uma nova viagem")
print("2 - Consultar viagens")

op = int(input(""))

if op == 1:
    inserirViagem()

elif op == 2:
    consultarViagem()

else:
    print("Opção inválida! Encerrando aplicação...")
