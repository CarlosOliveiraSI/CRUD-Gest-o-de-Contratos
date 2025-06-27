package model;

import java.math.BigDecimal;
import java.sql.Date;

public class Contrato {
	
	private int id;
	private String numeroContrato;
	private String obContrato;
	private Date dataAssinatura;
	private BigDecimal valorTotal;
	private boolean statusAtivo;
	private Empresa empresa;
	
	
	public Empresa getEmpresa() {
		return empresa;
	}
	public void setEmpresa(Empresa empresa) {
		this.empresa = empresa;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
	}
	public String getObContrato() {
		return obContrato;
	}
	public void setObContrato(String obContrato) {
		this.obContrato = obContrato;
	}
	public Date getDataAssinatura() {
		return dataAssinatura;
	}
	public void setDataAssinatura(Date dataAssinatura) {
		this.dataAssinatura = dataAssinatura;
	}
	public BigDecimal getValorTotal() {
		return valorTotal;
	}
	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}
	public boolean isStatusAtivo() {
		return statusAtivo;
	}
	public void setStatusAtivo(boolean statusAtivo) {
		this.statusAtivo = statusAtivo;
	}
	
}
