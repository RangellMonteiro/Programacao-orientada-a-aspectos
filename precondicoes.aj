package aspectos;
import contas.Conta;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Aspect;
@Aspect
public aspect precondicoes {
	@Before("execution(public * Conta.creditar(double)) && args(valor) ||"
            + "execution(public * Conta.debitar(double)) && args(valor) ||"
            + "execution(public * Conta.transferir(double)) && args(valor)")
    public void verificarPositivo(double valor) {
        if (valor <= 0) {
            throw new IllegalArgumentException("O valor precisa ser positivo.");
            }
    }
    @Before("target(c) && execution(public * Conta.debitar(Conta, double)) && args(valor)")
    public void verificarSaldoSuficiente(Conta c, double valor) {
        if (valor > c.getSaldo()) {
            throw new IllegalArgumentException("Saldo Insuficiente!.");
            }
    }
}


