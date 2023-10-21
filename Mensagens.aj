package aspectos;

import contas.Conta;

public aspect Mensagens {
	//Passo 6
	pointcut pcCreditar2(): 
		call(public * Conta.creditar(..)); //Este pointcut captura chamadas de métodos creditar públicos específicos da classe Conta.
	
	//Passo 7
	pointcut pcCreditar1(): 
		call(public * creditar(..));//Este pointcut captura chamadas de métodos creditar públicos, independentemente da classe a que pertencem.
	
	pointcut pcCreditar3(Conta c): 
		target(c) && call(public * creditar(..));//Este pointcut captura chamadas de métodos creditar públicos e usa target(c) 
	//para restringir apenas às chamadas onde o alvo é uma instância de Conta.
	
	pointcut pcSaldo(Conta c, double valor):
		target(c) && call(public * creditar(double)) && args (valor);
	
	before(): pcCreditar1(){
		System.out.println("Vou creditar!");
	}
	//Passo 9
		//before(Conta C): pcCreditar3(C){
			//System.out.println("Saldo antes de creditar: R$" + C.getSaldo()); //advice (before) para imprimir o saldo da conta antes da execução do método creditar.
		//}
		//after(Conta C): pcCreditar3(C){
			//System.out.println("Saldo após creditar: R$" + C.getSaldo());//advice (after) para imprimir o saldo da conta após a execução do método creditar.
		//}
		//passo 10
		void around(Conta C, double valor): pcSaldo(C,valor){
			System.out.println("Saldo antes de creditar: R$" + C.getSaldo());
			proceed(C,valor);
			System.out.println("Saldo após creditar: R$" + C.getSaldo());
		}
		//Passo 11:
		before(Conta C, double valor): pcSaldo(C,valor){
			System.out.println("Creditar valor: R$" + valor);
		}
}
	

