package model.dao;

import java.util.List;
import model.Empresa;
import model.ModelException;

public interface EmpresaDAO {
   
	void save(Empresa empresa) throws ModelException;
	void update(Empresa empresa) throws ModelException;
	void delete(Empresa empresa) throws ModelException;
	Empresa findById(int id) throws ModelException;

    
	List<Empresa> listAll() throws ModelException;
}