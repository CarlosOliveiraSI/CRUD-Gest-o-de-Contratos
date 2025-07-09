package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Empresa;
import model.ModelException;

public class MysqlEmpresaDAO implements EmpresaDAO {

	@Override
	public void save(Empresa empresa) throws ModelException {
		String sql = "INSERT INTO empresas (razao_social, cnpj) VALUES (?, ?)";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setString(1, empresa.getRazaoSocial());
			pstm.setString(2, empresa.getCnpj());
			pstm.execute();
			
		} catch (SQLException | ModelException e) { 
			throw new ModelException("Erro ao salvar empresa", e);
		}
	}

	@Override
	public void update(Empresa empresa) throws ModelException {
		String sql = "UPDATE empresas SET razao_social = ?, cnpj = ? WHERE id = ?";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setString(1, empresa.getRazaoSocial());
			pstm.setString(2, empresa.getCnpj());
			pstm.setInt(3, empresa.getId());
			pstm.execute();
			
		} catch (SQLException | ModelException e) { 
			throw new ModelException("Erro ao atualizar empresa", e);
		}
	}

	@Override
	public void delete(Empresa empresa) throws ModelException {
		String sql = "DELETE FROM empresas WHERE id = ?";
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setInt(1, empresa.getId());
			pstm.execute();
			
		} catch (SQLException | ModelException e) { 
			throw new ModelException("Erro ao deletar empresa", e);
		}
	}

	@Override
	public Empresa findById(int id) throws ModelException {
		String sql = "SELECT * FROM empresas WHERE id = ?";
		Empresa empresa = null;
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql)) {
			
			pstm.setInt(1, id);
			
			try (ResultSet rset = pstm.executeQuery()) {
				if (rset.next()) {
					empresa = new Empresa();
					empresa.setId(rset.getInt("id"));
					empresa.setRazaoSocial(rset.getString("razao_social"));
					empresa.setCnpj(rset.getString("cnpj"));
				}
			}
			
		} catch (SQLException | ModelException e) { 
			throw new ModelException("Erro ao buscar empresa por id", e);
		}
		
		return empresa;
	}
	
	@Override
	public List<Empresa> listAll() throws ModelException {
		String sql = "SELECT * FROM empresas ORDER BY razao_social";
		List<Empresa> empresas = new ArrayList<>();
		
		try (Connection conn = MySQLConnectionFactory.getConnection();
			 PreparedStatement pstm = conn.prepareStatement(sql);
			 ResultSet rset = pstm.executeQuery()) {
			
			while (rset.next()) {
				Empresa empresa = new Empresa();
				empresa.setId(rset.getInt("id"));
				empresa.setRazaoSocial(rset.getString("razao_social"));
				empresa.setCnpj(rset.getString("cnpj"));
				empresas.add(empresa);
			}
			
		} catch (SQLException | ModelException e) { 
			throw new ModelException("Erro ao listar empresas", e);
		}
		
		return empresas;
	}
}