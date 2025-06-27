package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.ModelException;
import model.Usuario;

public class MysqlUsuarioDAO implements UsuarioDAO {

    @Override
    public Usuario findByLoginAndPassword(String login, String senha) throws ModelException {
        String sql = "SELECT * FROM usuarios WHERE login = ? AND senha = ?";
        Usuario usuario = null;

        // Lembre-se que em um app real, a senha seria um hash e a comparação seria diferente
        
        try (Connection conn = MySQLConnectionFactory.getConnection();
             PreparedStatement pstm = conn.prepareStatement(sql)) {

            pstm.setString(1, login);
            pstm.setString(2, senha);

            try (ResultSet rset = pstm.executeQuery()) {
                if (rset.next()) {
                    usuario = new Usuario();
                    usuario.setId(rset.getInt("id"));
                    usuario.setNome(rset.getString("nome"));
                    usuario.setLogin(rset.getString("login"));
                    // Por segurança, não preenchemos a senha no objeto que será retornado
                }
            }

        } catch (SQLException | ModelException e) {
            throw new ModelException("Erro ao autenticar usuário", e);
        }

        return usuario; // Retorna o objeto usuario ou null se não encontrou
    }
}