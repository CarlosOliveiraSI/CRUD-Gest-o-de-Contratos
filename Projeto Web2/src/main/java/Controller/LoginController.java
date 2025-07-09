package Controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelException;
import model.Usuario;
import model.dao.DAOFactory;
import model.dao.UsuarioDAO;



@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// 1. Pega a sessão atual, se existir. O 'false' impede de criar uma nova.
		HttpSession session = req.getSession(false);
		
		if (session != null) {
			// 2. Invalida a sessão, removendo todos os atributos (incluindo o usuário logado)
			session.invalidate();
		}
		
		// 3. Redireciona o usuário de volta para a página de login
		ControllerUtil.redirect(resp, req.getContextPath() + "/login.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Ação de Login (chamada pelo formulário, que usa o método POST)
		
		// 1. Pega os dados do formulário
		String login = req.getParameter("login");
		String senha = req.getParameter("senha");

		// 2. Usa o DAO para verificar as credenciais no banco
		UsuarioDAO dao = DAOFactory.createDAO(UsuarioDAO.class);
		Usuario usuario = null;

		try {
			usuario = dao.findByLoginAndPassword(login, senha);
		} catch (ModelException e) {
			// Se der erro no banco, trata aqui
			e.printStackTrace();
		}

		// 3. Verifica o resultado da busca
		if (usuario != null) {
			// SUCESSO! Usuário e senha corretos.
			
			// 4. Pega a sessão do usuário (o 'true' cria uma nova se não existir)
			HttpSession session = req.getSession(true);
			
			// 5. Armazena o objeto 'usuario' na sessão. É assim que o sistema "lembra" do usuário.
			session.setAttribute("usuarioLogado", usuario);
			
			// 6. Redireciona para a página principal (dashboard)
			ControllerUtil.redirect(resp, req.getContextPath() + "/contratos");

		} else {
	
			req.setAttribute("loginError", "Usuário ou senha inválidos.");
			
			
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}
}