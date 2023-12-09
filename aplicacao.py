import re
import psycopg

#falta evitar SQL injection

#função que verifica se o horário está no formato adequado
def verificarFormatoHorario(entrada_usuario):

    # Padrão de expressão regular para HH:MM
    padrao = re.compile(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$')

    #verifica se a entrada do usuário passada como argumento segue o padrão especificado acima e retorna o resultado da comparação
    return padrao.match(entrada_usuario)

#função que verifica se a data está no formato adequado
def verificarFormatoData(entrada_usuario):

    # Padrão de expressão regular para DD/MM/YYYY
    padrao = re.compile(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$')

    #verifica se a entrada do usuário passada como argumento segue o padrão especificado acima e retorna o resultado da comparação
    return padrao.match(entrada_usuario)

#função que verifica se o preço está no formato adequado
def verificarFormatoPreco(entrada_usuario):

    # Padrão de expressão regular para o preço usando '.' como separador decimal
    padrao = re.compile(r'^\d+(\.\d{1,2})?$')

    #verifica se a entrada do usuário passada como argumento segue o padrão especificado acima e retorna o resultado da comparação
    return padrao.match(entrada_usuario)

#função que lê os dados da viagem a ser inserida e realiza a inserçãod e fato
def inserirViagem():

    #lê o número de viagens que o usuário deseja inserir no banco de dados
    num_viagens = int(input("Digite o número de viagens que você deseja cadastrar: "))

    #loop para cadastro de cada viagem
    for i in range(num_viagens):

        #leituras e checagens relativas a cada atributo de uma viagem
        print("Para a " + str(i+1) + " viagem:")

        data_hora = input("Insira a data e a hora da viagem (no formato DD/MM/YYYY hh:mm): ")
        while (not verificarFormatoData(data_hora.split()[0])) or (not verificarFormatoHorario(data_hora.split()[1])):
            print("Parece que você digitou uma data ou uma hora inválida ou no formato errado. Tente novamente.")
            data_hora = input("Insira a data e a hora da viagem (no formato DD/MM/YYYY hh:mm): ")

        nave = input("Insira a placa da nave utilizada na viagem: ")
        while (len(nave) != 8) or (not nave.isalnum()):
            print("Parece que você digitou uma placa inválida. Tente novamente.")
            nave = input("Insira a placa da nave utilizada na viagem: ")

        origem = input("Digite o id da colônia de onde deve partir a nave: ")
        while (len(origem) != 10) or (not origem.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            origem = input("Digite o id da colônia de onde deve partir a nave: ")

        destino = input("Digite o id da colônia de destino da viagem: ")
        while (len(destino) != 10) or (not destino.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            destino = input("Digite o id da colônia de destino da viagem: ")

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

        preco = input("Insira o preço da passagem (utilize '.' como separador decimal se necessário): ")
        while not verificarFormatoPreco(preco):
            print("Parece que você digitou um preço inválido. Tente novamente.")
            preco = input("Insira o preço da passagem (utilize '.' como separador decimal se necessário): ")

        piloto = input("Digite o CPF do piloto responsável pela viagem: ")
        while (len(piloto) != 11) or (not piloto.isnumeric()):
            print("Parece que você digitou um CPF inválido. Tente novamente.")
            piloto = input("Digite o CPF do piloto responsável pela viagem: ")

        duracao = input("Insira a duração prevista da viagem (no formato hh:mm): ")
        while not verificarFormatoHorario(duracao):
            print("Parece que você digitou a hora no formato errado ou valor inválido. Tente novamente.")
            duracao = input("Insira a duração real da viagem (no formato hh:mm): ")

######################################################
#TRATAR EXCEÇÕES

        #conecta-se à base de dados 
        with psycopg.connect("dbname=test user=postgres") as conexao:
        
            #abre um cursor para realizar as operações no banco de dados
            with conexao.cursor() as cur:
            
                #executa um comando
                cur.execute("INSERT INTO VIAGEM VALUES(TIMESTAMP('%s:00,DD/MM/YYYY HH:MM:SS'), '%s', '%s', '%s', %s, TIME('%s:00,HH:MM:SS'), %s, %s, TIME('%s:00,HH:MM:SS')")

                #retorna a lista de tuplas que obedecem à condição de consulta
                cur.fetchall()

                #percorre a lista e imprime as tuplas
                for record in cur:
                    print(record)

                #salva as alterações 
                conexao.commit()

#função que lê os dados da viagem a ser consultada e realiza a consulta de fato
def consultarViagem():

    #leituras e checagens relativas a cada atributo de interesse da pesquisa
    data_viagem = input("Digite a data da viagem: ")
    while not verificarFormatoData(data_viagem):
        print("Parece que você digitou uma data inválida ou no formato errado. Tente novamente.")
        data_viagem = input("Digite a data da viagem: ")

    origem = input("Digite o id da colônia de origem: ")
    while (len(origem) != 10) or (not origem.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            origem = input("Digite o id da colônia de onde deve partir a nave: ")

    destino = input("Digite o id da colônia de destino (opcional): ")
    while ((destino != "") and (len(destino) != 10) or (not destino.isnumeric)):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            destino = input("Digite o id da colônia de onde deve partir a nave: ")

    #verifica se o usuário especificou o destino
    if destino == "":
        #pesquisar todas as viagens que partem da colonia origem na data especificada
        pesquisa = "SELECT * FROM VIAGEM WHERE ORIGEM = " + origem + " AND DATA_HORA = " + data_viagem
        print(pesquisa)

    else:
        #pesquisar todas as viagens entre as colônias de origem e destino na data especificada
        pesquisa = "SELECT * FROM VIAGEM WHERE COLONIA_SAIDA = " + origem + " AND DATE(DATA_HORA) = " + data_viagem + " AND COLONIA_CHEGADA = " + destino
        print(pesquisa)
    
    #conecta-se à base de dados 
    with psycopg.connect("dbname=test user=postgres") as conexao:
    
        #abre um cursor para realizar as operações no banco de dados
        with conexao.cursor() as cur:
        
            #executa um comando
            cur.execute(pesquisa)

            #retorna a lista de tuplas que obedecem à condição de consulta
            cur.fetchall()

            #percorre a lista e imprime as tuplas
            for record in cur:
                print(record)

            #salva as alterações 
            conexao.commit()

#variável para armazenar a escolha do usuário
op = 0

while(op != 3):

    #impressão do menu
    print("O que deseja fazer?")
    print("1 - Cadastrar uma nova viagem")
    print("2 - Consultar viagens")
    print("3 - Sair")

    #leitura da escolha do usuário
    op = int(input(""))

    #chamada da função relativa à escolha feita pelo usuário
    if op == 1:
        inserirViagem()

    elif op == 2:
        consultarViagem()
    
    elif op == 3:
        break

    else:
        print("Opção inválida! Encerrando aplicação...")
        break
