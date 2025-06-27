package model.dao;

import model.ModelException;
import model.Usuario;

public interface UsuarioDAO {

   
    Usuario findByLoginAndPassword(String login, String senha) throws ModelException;
}