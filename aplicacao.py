import re
import psycopg
from datetime import datetime

def calculaDuracaoViagem(hora_saida, hora_chegada):

    # Crie um objeto datetime a partir da string
    datetime1 = datetime.strptime(hora_saida, "%d/%m/%Y %H:%M")
    datetime2 = datetime.strptime(hora_chegada, "%d/%m/%Y %H:%M")

    # Agora, você tem um objeto datetime que pode ser convertido para timestamp se necessário
    timestamp1 = datetime.timestamp(datetime1)
    timestamp2 = datetime.timestamp(datetime2)

    # Calcule a diferença em segundos
    diferenca_em_segundos = timestamp2 - timestamp1

    # Converta a diferença para horas e minutos
    diferenca_em_minutos, segundos_restantes = divmod(diferenca_em_segundos, 60)
    diferenca_em_horas, minutos_restantes = divmod(diferenca_em_minutos, 60)

    # Exiba a diferença em formato HH:MM
    formato_hora = '{:02}:{:02}'.format(int(diferenca_em_horas), int(minutos_restantes))
    return(f'{formato_hora}')

#função que verifica se o horário está no formato adequado
def verificarFormatoHorario(entrada_usuario):

    # Padrão de expressão regular para HH:MM
    padrao = re.compile(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$')

    #verifica se a entrada do usuário passada como argumento segue o padrão especificado acima e retorna True em caso airmativo ou False caso contrário
    if padrao.match(entrada_usuario) == None:
        return False
    
    else:
        return True


#função que verifica se a data está no formato adequado
def verificarFormatoData(entrada_usuario):

    # Padrão de expressão regular para DD/MM/YYYY
    padrao = re.compile(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$')

    #verifica se a entrada do usuário passada como argumento segue o padrão especificado acima e retorna True em caso airmativo ou False caso contrário
    if padrao.match(entrada_usuario) == None:
        return False
    
    else:
        return True

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
        while (len(origem) != 12) or (not origem.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            origem = input("Digite o id da colônia de onde deve partir a nave: ")

        destino = input("Digite o id da colônia de destino da viagem: ")
        while (len(destino) != 12) or (not destino.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            destino = input("Digite o id da colônia de destino da viagem: ")

        distancia = input("Digite a distância da rota utilizada na viagem: ")
        while (distancia == "") or (not distancia.isnumeric()) or (len(distancia) > 8):
            print("Parece que você digitou uma distância inválida. Tente novamente.")
            if len(distancia) > 8:
                print("A distância digitada é maior que a permitida para as viagens.")
            distancia = input("Digite a distância da rota utilizada na viagem: ")

        hora_chegada = input("Insira a data e a hora prevista para a chegada da nave à colônia de destino (no formato DD/MM/YYYY hh:mm): ")
        while (not verificarFormatoData(hora_chegada.split()[0])) or (not verificarFormatoHorario(hora_chegada.split()[1])):
            print("Parece que você digitou uma data ou uma hora inválida ou no formato errado. Tente novamente.")
            hora_chegada = input("Insira a data e a hora prevista para a chegada da nave à colônia de destino (no formato DD/MM/YYYY hh:mm): ")

        preco = input("Insira o preço da passagem (utilize '.' como separador decimal se necessário): ")
        while not verificarFormatoPreco(preco):
            print("Parece que você digitou um preço inválido. Tente novamente.")
            preco = input("Insira o preço da passagem (utilize '.' como separador decimal se necessário): ")

        piloto = input("Digite o CPF do piloto responsável pela viagem: ")
        while (len(piloto) != 11) or (not piloto.isnumeric()):
            print("Parece que você digitou um CPF inválido. Tente novamente.")
            piloto = input("Digite o CPF do piloto responsável pela viagem: ")
        
        duracao = calculaDuracaoViagem(data_hora, hora_chegada)

        try:
            #conecta-se à base de dados 
            with psycopg.connect("host=localhost port=5432 dbname=postgres user=briotisk password=123admin connect_timeout=10") as conexao:
            
                #abre um cursor para realizar as operações no banco de dados
                with conexao.cursor() as cur:
                
                    #executa o comando de inserção passando os valores lidos como argumento
                    cur.execute("INSERT INTO VIAGEM VALUES('" + data_hora + ":00', '" + nave + "', " + origem + ", " + destino + ", " + distancia + ", '" + hora_chegada + ":00', " + preco + ", " + piloto + ", '" + duracao + ":00')")

                    #salva as alterações 
                    conexao.commit()

        except Exception as e:
            print(f"Erro na inserção: {e}")
            conexao.rollback()

#função que lê os dados da viagem a ser consultada e realiza a consulta de fato
def consultarViagem():

    #leituras e checagens relativas a cada atributo de interesse da pesquisa
    data_viagem = input("Digite a data da viagem (no formato DD/MM/YYYY): ")
    while not verificarFormatoData(data_viagem):
        print("Parece que você digitou uma data inválida ou no formato errado. Tente novamente.")
        data_viagem = input("Digite a data da viagem: ")

    origem = input("Digite o id da colônia de origem: ")
    while (len(origem) != 12) or (not origem.isnumeric):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            origem = input("Digite o id da colônia de onde deve partir a nave: ")

    destino = input("Digite o id da colônia de destino (opcional): ")
    while ((destino != "") and (len(destino) != 12) or (not destino.isnumeric)):
            print("Parece que você digitou um id de colônia inválido. Tente novamente.")
            destino = input("Digite o id da colônia de onde deve partir a nave: ")
    print("\n")
    
    #verifica se o usuário especificou o destino
    if destino == "":
        #pesquisar todas as viagens que partem da colonia origem na data especificada
        pesquisa = "SELECT * FROM VIAGEM WHERE COLONIA_SAIDA = " + origem + " AND DATE(DATA_HORA) = '" + data_viagem + "'"

    else:
        #pesquisar todas as viagens entre as colônias de origem e destino na data especificada
        pesquisa = "SELECT * FROM VIAGEM WHERE COLONIA_SAIDA = " + origem + " AND DATE(DATA_HORA) = '" + data_viagem + "' AND COLONIA_CHEGADA = " + destino
    
    try:
        #conecta-se à base de dados 
        with psycopg.connect("host=localhost port=5432 dbname=postgres user=briotisk password=123admin connect_timeout=10") as conexao:
    
            #abre um cursor para realizar as operações no banco de dados
            with conexao.cursor() as cur:
            
                #executa um comando
                cur.execute(pesquisa)

                #retorna a lista de tuplas que obedecem à condição de consulta
                list = cur.fetchall()

                #percorre a lista e imprime as tuplas
                if len(list) == 0:

                    if destino == "":
                        print("Ops... parece que não há viagens partindo do destino selecionado na data especificada")

                    else:
                        print("Ops... parece que não viagens entre estas colonias na data especificada")
                else:

                    print(f'Foram encontrados um total de {len(list)} resultados')
                    for record in list:
                        print(f'Horário previsto da partida: {record[0]}')
                        print(f'Nave: {record[1]}')
                        print(f'Colônia de origem: {record[2]}')                        
                        print(f'Colônia de destino: {record[3]}')                        
                        print(f'Distância da viagem: {record[4]}')                        
                        print(f'Horário previsto da chegada {record[5]}')
                        print(f'Preço da passagem: {record[6]}')
                        print(f'Piloto responsável por conduzir a viagem: {record[7]}')
                        print(f'Duração estimada da viagem: {record[8]}')                        
                        print("\n")

                #salva as alterações 
                conexao.commit()

    except Exception as e:
        print(f"Erro na consulta: {e}")
        conexao.rollback()

    

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
    print("\n")

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
