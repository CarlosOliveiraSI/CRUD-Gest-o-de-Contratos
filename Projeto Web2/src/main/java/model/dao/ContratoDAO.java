package model.dao;

import java.util.List;
import model.Contrato;
import model.ModelException;

public interface ContratoDAO {
	
	void save(Contrato contrato) throws ModelException;
	
	void update(Contrato contrato) throws ModelException;
	
	void delete(Contrato contrato) throws ModelException;
	
	Contrato findById(int id) throws ModelException;
	
	List<Contrato> listAll() throws ModelException;
}