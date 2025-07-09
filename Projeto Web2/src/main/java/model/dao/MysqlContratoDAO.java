package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Contrato;
import model.Empresa;
import model.ModelException;

public class MysqlContratoDAO implements ContratoDAO {

	@Override
	public void save(Contrato contrato) throws ModelException {
		String sql = "INSERT INTO contratos (numero_contrato, objeto_contrato, data_assinatura, valor_total, status_ativo, empresa_id) VALUES (?, ?, ?, ?, ?, ?)";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setString(1, contrato.getNumeroContrato());
			pstm.setString(2, contrato.getObjetoContrato());
			pstm.setDate(3, new java.sql.Date(contrato.getDataAssinatura().getTime()));
			pstm.setBigDecimal(4, contrato.getValorTotal());
			pstm.setBoolean(5, contrato.isStatusAtivo());
			pstm.setInt(6, contrato.getEmpresa().getId());
			
			pstm.execute();
			
		} catch (SQLException | ModelException e) {
			throw new ModelException("Erro ao salvar contrato", e);
		}
	}

	@Override
	public void update(Contrato contrato) throws ModelException {
		String sql = "UPDATE contratos SET numero_contrato = ?, objeto_contrato = ?, data_assinatura = ?, valor_total = ?, status_ativo = ?, empresa_id = ? WHERE id = ?";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setString(1, contrato.getNumeroContrato());
			pstm.setString(2, contrato.getObjetoContrato());
			pstm.setDate(3, new java.sql.Date(contrato.getDataAssinatura().getTime()));
			pstm.setBigDecimal(4, contrato.getValorTotal());
			pstm.setBoolean(5, contrato.isStatusAtivo());
			pstm.setInt(6, contrato.getEmpresa().getId());
			pstm.setInt(7, contrato.getId());
			
			pstm.execute();
			
		} catch (SQLException | ModelException e) {
			throw new ModelException("Erro ao atualizar contrato", e);
		}
	}

	@Override
	public void delete(Contrato contrato) throws ModelException {
		String sql = "DELETE FROM contratos WHERE id = ?";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setInt(1, contrato.getId());
			
			pstm.execute();
			
		} catch (SQLException | ModelException e) {
			throw new ModelException("Erro ao deletar contrato", e);
		}
	}

	@Override
	public Contrato findById(int id) throws ModelException {
		String sql = "SELECT c.*, e.razao_social, e.cnpj FROM contratos c JOIN empresas e ON c.empresa_id = e.id WHERE c.id = ?";
		Contrato contrato = null;
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setInt(1, id);
			
			try (ResultSet rset = pstm.executeQuery()) {
				if (rset.next()) {
					Empresa empresa = new Empresa();
					empresa.setId(rset.getInt("empresa_id"));
					empresa.setRazaoSocial(rset.getString("razao_social"));
					empresa.setCnpj(rset.getString("cnpj"));

					contrato = new Contrato();
					contrato.setId(rset.getInt("id"));
					contrato.setNumeroContrato(rset.getString("numero_contrato"));
					contrato.setObjetoContrato(rset.getString("objeto_contrato"));
					contrato.setDataAssinatura(rset.getDate("data_assinatura"));
					contrato.setValorTotal(rset.getBigDecimal("valor_total"));
					contrato.setStatusAtivo(rset.getBoolean("status_ativo"));
					contrato.setEmpresa(empresa);
				}
			}
			
		} catch (SQLException | ModelException e) {
			throw new ModelException("Erro ao buscar contrato por id", e);
		}
		
		return contrato;
	}
	
	@Override
	public List<Contrato> listAll() throws ModelException {
		String sql = "SELECT c.*, e.razao_social, e.cnpj FROM contratos c JOIN empresas e ON c.empresa_id = e.id ORDER BY c.id";
		List<Contrato> contratos = new ArrayList<>();
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql);
			 ResultSet rset = pstm.executeQuery()) {
			
			while (rset.next()) {
				Empresa empresa = new Empresa();
				empresa.setId(rset.getInt("empresa_id"));
				empresa.setRazaoSocial(rset.getString("razao_social"));
				empresa.setCnpj(rset.getString("cnpj"));

				Contrato contrato = new Contrato();
				contrato.setId(rset.getInt("id"));
				contrato.setNumeroContrato(rset.getString("numero_contrato"));
				contrato.setObjetoContrato(rset.getString("objeto_contrato"));
				contrato.setDataAssinatura(rset.getDate("data_assinatura"));
				contrato.setValorTotal(rset.getBigDecimal("valor_total"));
				contrato.setStatusAtivo(rset.getBoolean("status_ativo"));
				contrato.setEmpresa(empresa);
				
				contratos.add(contrato);
			}
			
		} catch (SQLException | ModelException e) {
			throw new ModelException("Erro ao listar contratos", e);
		}
		
		return contratos;
	}
}