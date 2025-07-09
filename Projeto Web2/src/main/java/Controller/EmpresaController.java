package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Empresa;
import model.ModelException;
import model.dao.DAOFactory;
import model.dao.EmpresaDAO;


@WebServlet(urlPatterns = {"/empresas", "/empresa/form", "/empresa/insert", "/empresa/update", "/empresa/delete"})
public class EmpresaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getRequestURI();
		String contextPath = req.getContextPath();

		if (action.equals(contextPath + "/empresa/form")) {
			req.setAttribute("action", "insert");
			ControllerUtil.forward(req, resp, "/form-empresa.jsp");
		} else if (action.equals(contextPath + "/empresa/update")) {
			Empresa empresa = carregarEmpresa(req);
			req.setAttribute("empresa", empresa);
			req.setAttribute("action", "update");
			ControllerUtil.forward(req, resp, "/form-empresa.jsp");
		} else {
			listarEmpresas(req);
			ControllerUtil.transferSessionMessagesToRequest(req);
			ControllerUtil.forward(req, resp, "/empresas.jsp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getRequestURI();
		String contextPath = req.getContextPath();
		
		if (action.equals(contextPath + "/empresa/insert")) {
			inserirEmpresa(req);
		} else if (action.equals(contextPath + "/empresa/update")) {
			atualizarEmpresa(req);
		} else if (action.equals(contextPath + "/empresa/delete")) {
			deletarEmpresa(req);
		}
		
		ControllerUtil.redirect(resp, contextPath + "/empresas");
	}

	private void listarEmpresas(HttpServletRequest req) {
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			List<Empresa> empresas = dao.listAll();
			req.setAttribute("listaDeEmpresas", empresas);
		} catch (ModelException e) {
			ControllerUtil.errorMessage(req, e.getMessage());
			e.printStackTrace();
		}
	}

	private Empresa carregarEmpresa(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			return dao.findById(id);
		} catch (ModelException e) {
			ControllerUtil.errorMessage(req, e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	private void inserirEmpresa(HttpServletRequest req) {
		String razaoSocial = req.getParameter("razaoSocial");
		String cnpj = req.getParameter("cnpj");
		
		Empresa empresa = new Empresa();
		empresa.setRazaoSocial(razaoSocial);
		empresa.setCnpj(cnpj);
		
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			dao.save(empresa);
			ControllerUtil.sucessMessage(req, "Empresa '" + empresa.getRazaoSocial() + "' salva com sucesso.");
		} catch (ModelException e) {
			ControllerUtil.errorMessage(req, e.getMessage());
			e.printStackTrace();
		}
	}

	private void atualizarEmpresa(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		String razaoSocial = req.getParameter("razaoSocial");
		String cnpj = req.getParameter("cnpj");
		
		Empresa empresa = new Empresa();
		empresa.setId(id);
		empresa.setRazaoSocial(razaoSocial);
		empresa.setCnpj(cnpj);
		
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			dao.update(empresa);
			ControllerUtil.sucessMessage(req, "Empresa '" + empresa.getRazaoSocial() + "' atualizada com sucesso.");
		} catch (ModelException e) {
			ControllerUtil.errorMessage(req, e.getMessage());
			e.printStackTrace();
		}
	}

	private void deletarEmpresa(HttpServletRequest req) {
		int id = Integer.parseInt(req.getParameter("id"));
		
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			Empresa empresa = dao.findById(id);
			if (empresa == null) throw new ModelException("Empresa não encontrada.");
			
			dao.delete(empresa);
			ControllerUtil.sucessMessage(req, "Empresa '" + empresa.getRazaoSocial() + "' deletada com sucesso.");
		} catch (ModelException e) {
			ControllerUtil.errorMessage(req, e.getMessage());
			e.printStackTrace();
		}
	}
}