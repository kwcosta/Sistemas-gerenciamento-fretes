
programa {
	
inclua biblioteca Arquivos
inclua biblioteca Texto
funcao inicio(){

	//variaveis de login
	inteiro opcao=0
	cadeia login_novo, senha_novo, login_digitado, senha_digitada, login_salvo, senha_salva
	logico login_efetuado = falso
	//variaveis dos fretes
	inteiro numero_de_fretes = 0
	cadeia notas_fiscais[10]
	cadeia local_do_frete[10]
	inteiro valor_negociado_frete[10]
	cadeia veiculo_frete[10]
	inteiro valores_padrao[10]
	
	faca{
   	
   		escreva("=========================================\n")
    	escreva("             PLANFRETE SYSTEM            \n")
    	escreva("   Gerenciamento e Planejamento de Fretes  \n")
    		escreva("=========================================\n\n")
	se(login_efetuado == falso){	
	escreva("**MENU**:\n")
	escreva("-----------------------------------------------\n")
    escreva("1) Login de usuário\n")
    escreva("2) Cadastrar novo usuário\n")
    escreva("6) Sair do sistema\n")
	}senao{
    escreva("**MENU**:\n")
	escreva("-----------------------------------------------\n")
    escreva("3) Cadastrar novo frete\n")
    escreva("4) Consultar frete por nota fiscal\n")
    escreva("5) Verificar valor com tabela da região\n")
    escreva("6) Sair do sistema\n")
	}
	
	escreva("¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n")	
	escreva("digite a sua opção: ")
	leia(opcao)

	escolha(opcao){

	caso 1:
	se(Arquivos.arquivo_existe("login.txt")==falso){
		escreva("\n[ERRO] Nenhum usuário cadastrado. Por favor, cadastre-se na opção 2.\n")
	}senao{	
		escreva("=========================================\n")
	escreva("               TELA DE LOGIN               ")
		
	escreva("\n Usuário: ")
	leia(login_digitado)
	escreva("\n Senha: ")
	leia(senha_digitada)

	inteiro arquivo = Arquivos.abrir_arquivo("login.txt", Arquivos.MODO_LEITURA)
	login_salvo = Arquivos.ler_linha(arquivo)
	senha_salva = Arquivos.ler_linha(arquivo)
	Arquivos.fechar_arquivo(arquivo)
	se (login_digitado == login_salvo e senha_digitada == senha_salva) {
		escreva("\n[SUCESSO] Login realizado!\n")
		login_efetuado = verdadeiro
	} senao {
		escreva("\n[ERRO] Usuário ou senha incorretos.\n")
		}}
	pare
	
	caso 2:
		
	se (login_efetuado == falso) {
		escreva("=========================================\n")
		escreva("        CADASTRO DE NOVO USUÁRIO         \n")
			escreva("Digite o nome de usuário que deseja salvar: ")
			leia(login_digitado)
			escreva("Digite a senha que deseja salvar: ")
			leia(senha_digitada)

				inteiro arquivo_escrita = Arquivos.abrir_arquivo("login.txt", Arquivos.MODO_ESCRITA)
				Arquivos.escrever_linha(login_digitado, arquivo_escrita)
				Arquivos.escrever_linha(senha_digitada, arquivo_escrita)
				Arquivos.fechar_arquivo(arquivo_escrita)

			escreva("\n[SUCESSO] Usuário cadastrado e salvo!\n")
			} senao {
			escreva("\n[ERRO] Opção inválida. Você já está logado.\n")
			}
			pare
				
	
	caso 3:
	//cadastrar novo ferete
	se(numero_de_fretes >= 10){

			escreva("\n[ERRO] Limite de 10 fretes atingido!\n")
		
	}senao	{
	
	
	
	escreva("=========================================\n")
	escreva("        CADASTRO DE NOVO FRETE         \n")
	escreva("      (Apenas letras maiúsculas)  \n\n")
	escreva("Para cadastro de novos fretes precisamos das seguintos informações:\n\n")

		escreva("Qual a nota fiscal deste frete: ")
		leia(notas_fiscais[numero_de_fretes])
		
		escreva("\n\nPara qual lugar será o frete, digite o ESTADO \n(Estados que a empresa abrange MG, SP, RJ, ES): ")
		leia(local_do_frete[numero_de_fretes])

		escreva("\n\nQual o valor da negociação do seu frete (SOMENTE INTEIROS): ")
		leia(valor_negociado_frete[numero_de_fretes])

		escreva("\n\nQual será o veículo (TRUCK, CARRETA): ")
		leia(veiculo_frete[numero_de_fretes])

	inteiro arq_fretes = Arquivos.abrir_arquivo("fretes.txt", Arquivos.MODO_ACRESCENTAR)
		Arquivos.escrever_linha(notas_fiscais[numero_de_fretes], arq_fretes)
		Arquivos.escrever_linha(veiculo_frete[numero_de_fretes], arq_fretes)
		Arquivos.escrever_linha("" + valor_negociado_frete[numero_de_fretes], arq_fretes)
		Arquivos.fechar_arquivo(arq_fretes)

		numero_de_fretes = numero_de_fretes + 1

		escreva("\n[SUCESSO] Frete cadastrado e salvo!\n")

	escreva("¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\n")
	
	}
	pare
	
	caso 4:
	//consultar frete por nota fiscal
	se(numero_de_fretes == 0){

		escreva("\n[INFO] Nenhum frete cadastrado para consultar. \n")

	}senao{

	cadeia nf_busca
	escreva("=========================================\n")
	escreva("            CONSULTA DE FRETES           \n")

	escreva("Digite a Nota Fiscal do frete que deseja buscar: ")
	leia(nf_busca)

	logico achou = falso

	para(inteiro i = 0; i < numero_de_fretes; i++){

	se(notas_fiscais[i] == nf_busca){

		escreva("\n-- FRETE ENCONTRADO --\n")
		escreva("Nota Fiscal: ",notas_fiscais[i], "\n")
		escreva("Destino (Estado): ",local_do_frete[i], "\n")
		escreva("Veículo: ",veiculo_frete[i], "\n")
		escreva("Valor Negociado: R$ ",valor_negociado_frete[i], "\n")

		achou = verdadeiro
		pare
		
	}
	}
	se (achou == falso){

		escreva("\n[ERRO] Frete com a nota fiscal '", nf_busca, "' não encontrado.\n")
		
	}
	

		
	}
	pare

	caso 5:
	//verificar valor com tabela da região
	se (numero_de_fretes == 0) {

		escreva("\n[INFO] Nenhum frete cadastrado para gerar o relatório.\n")
		
	} senao {

		//comparações para a tabela
		para(inteiro i = 0; i < numero_de_fretes; i++){
			
			cadeia estado = local_do_frete[i]
			cadeia veiculo = veiculo_frete[i]

			cadeia estado_maiusculo = Texto.caixa_alta(estado)
			cadeia veiculo_maiusculo = Texto.caixa_alta(veiculo)

			inteiro valor_calculado = -1

			
			se (estado == "SP" ou estado == "sp") {
				se (veiculo_maiusculo == "TRUCK") { valor_calculado = 1600 } 
				senao se (veiculo_maiusculo == "CARRETA") { valor_calculado = 3000 }
			} senao se (estado == "RJ" ou estado == "rj") {
				se (veiculo_maiusculo == "TRUCK") { valor_calculado = 1700 } 
				senao se (veiculo_maiusculo == "CARRETA") { valor_calculado = 2500 }
			} senao se (estado == "MG" ou estado == "mg") {
				se (veiculo_maiusculo == "TRUCK") { valor_calculado = 1800 } 
				senao se (veiculo_maiusculo == "CARRETA") { valor_calculado = 3500 }
			} senao se (estado == "ES" ou estado == "es") {
				se (veiculo_maiusculo == "TRUCK") { valor_calculado = 1900 } 
				senao se (veiculo_maiusculo == "CARRETA") { valor_calculado = 4000 }
			}
			
			valores_padrao[i] = valor_calculado
		}

		//tabela para comparação
		escreva("=========================================\n")
	escreva("       RELATÓRIO DE ANÁLISE DOS FRETES        \n")

		escreva("+---------------+---------------+-----------------+-------------------+----------------+\n")
		escreva("|  Nota Fiscal  |     Estado    | Tipo de Veículo |  Valor Negociado  |  Valor Padrão  |\n")
		escreva("+---------------+---------------+-----------------+-------------------+----------------+\n")


		para(inteiro i = 0; i < numero_de_fretes; i++) {
			escreva("| ", notas_fiscais[i])
			para(inteiro j=0; j < (16 - 2 - Texto.numero_caracteres(notas_fiscais[i])); j++){ escreva(" ") }
			
			escreva("| ", local_do_frete[i])
			para(inteiro j=0; j < (16 - 2 - Texto.numero_caracteres(local_do_frete[i])); j++){ escreva(" ") }

			escreva("| ", veiculo_frete[i])
			para(inteiro j=0; j < (18 - 2 - Texto.numero_caracteres(veiculo_frete[i])); j++){ escreva(" ") }

			escreva("| ", "R$ " + valor_negociado_frete[i])
			para(inteiro j=0; j < (20 - 2 - (3 + Texto.numero_caracteres("" + valor_negociado_frete[i]))); j++){ escreva(" ") }

			se (valores_padrao[i] == -1) {
				escreva("|      N/A       |") 
			} senao {
				escreva("| ", "R$ " + valores_padrao[i])
				para(inteiro j=0; j < (17 - 2 - (3 + Texto.numero_caracteres("" + valores_padrao[i]))); j++){ escreva(" ") }
				escreva("|")
			}
			
			escreva("\n")
			escreva("+---------------+---------------+-----------------+-------------------+----------------+\n")
		}
		escreva("\nRelatório gerado com sucesso.\n")
	}
	pare
	}

	}
	
	enquanto(opcao!=6)
    
    
  }

	
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4377; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */