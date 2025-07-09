package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import model.ModelException;

public class MySQLConnectionFactory {

    // Nome do Driver atualizado
    private static final String JDBC_DRIVER_NAME = "com.mysql.cj.jdbc.Driver";

    // URL do banco
    private static final String DATABASE_URL = 
        "jdbc:mysql://localhost:3306/crud_manager?useSSL=false&serverTimezone=UTC";

    // Credenciais
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws ModelException {
        try {
            // Carrega o driver JDBC (opcional com JDBC 4+, mas mantido por segurança)
            Class.forName(JDBC_DRIVER_NAME);

            // Cria a conexão com o banco
            return DriverManager.getConnection(DATABASE_URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new ModelException("Driver JDBC não encontrado", e);
        } catch (SQLException e) {
            throw new ModelException("Falha na conexão com o banco de dados", e);
        }
    }
}
