package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Contrato;
import model.Empresa; 
import model.ModelException;
import model.dao.ContratoDAO;
import model.dao.DAOFactory;
import model.dao.EmpresaDAO;

@WebServlet(urlPatterns = {
    "/", 
    "/contratos", 
    "/contrato/form", 
    "/contrato/insert", 
    "/contrato/update",
    "/contrato/delete"
})
public class ContratoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 String action = req.getRequestURI();
		 String contextPath = req.getContextPath();
		 
		 if (action.equals(contextPath + "/contrato/form")) {
		     listarEmpresas(req); 
		     req.setAttribute("action", "insert");
		     RequestDispatcher dispatcher = req.getRequestDispatcher("/form-contrato.jsp");
		     dispatcher.forward(req, resp);
		     
		 } else if (action.equals(contextPath + "/contrato/update")) {
		     Contrato contrato = carregarContrato(req);
		     req.setAttribute("contrato", contrato);
		     listarEmpresas(req);
		     req.setAttribute("action", "update");
		     RequestDispatcher dispatcher = req.getRequestDispatcher("/form-contrato.jsp");
		     dispatcher.forward(req, resp);
		     
		 } else { // Este bloco agora trata tanto a rota "/" quanto "/contratos"
		     
		     // A lógica de buscar os dados é a mesma para ambas as rotas
		     listarContratos(req);
		     ControllerUtil.transferSessionMessagesToRequest(req);
		     
		     String targetJsp = null;
		     
		     // Agora, decidimos para qual página encaminhar
		     if (action.equals(contextPath + "/")) {
		         // Se a URL for a raiz do site, encaminha para o index.jsp
		         targetJsp = "/index.jsp";
		     } else {
		         // Para qualquer outra rota (como /contratos), encaminha para contratos.jsp
		         targetJsp = "/contratos.jsp";
		     }
		     
		     RequestDispatcher dispatcher = req.getRequestDispatcher(targetJsp);
		     dispatcher.forward(req, resp);
		 }
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getRequestURI();
	    String contextPath = req.getContextPath();
	    
	    if (action.equals(contextPath + "/contrato/insert")) {
	        inserirContrato(req);
	    } 
	    else if (action.equals(contextPath + "/contrato/update")) {
	        atualizarContrato(req);
	    } 
	    else if (action.equals(contextPath + "/contrato/delete")) {
	        deletarContrato(req);
	    }
	    
	    // Redireciona para a página de listagem principal após qualquer ação de POST
	    ControllerUtil.redirect(resp, contextPath + "/contratos");
	}
	
	private void listarEmpresas(HttpServletRequest req) {
		EmpresaDAO dao = DAOFactory.createDAO(EmpresaDAO.class);
		try {
			List<Empresa> empresas = dao.listAll();
			req.setAttribute("listaDeEmpresas", empresas);
		} catch (ModelException e) {
			e.printStackTrace();
			ControllerUtil.errorMessage(req, e.getMessage());
		}
	}

	private Contrato carregarContrato(HttpServletRequest req) {
		try {
            int id = Integer.parseInt(req.getParameter("id"));
            ContratoDAO dao = DAOFactory.createDAO(ContratoDAO.class);
			return dao.findById(id);
		} catch (ModelException | NumberFormatException e) {
			e.printStackTrace();
			ControllerUtil.errorMessage(req, e.getMessage());
		}
		return null;
	}

	private void listarContratos(HttpServletRequest req) {
		ContratoDAO dao = DAOFactory.createDAO(ContratoDAO.class);
		try {
			List<Contrato> contratos = dao.listAll();
			req.setAttribute("listaDeContratos", contratos);
		} catch (ModelException e) {
			e.printStackTrace();
			ControllerUtil.errorMessage(req, e.getMessage());
		}
	}
	
	private void inserirContrato(HttpServletRequest req) {
	    String numeroContrato = req.getParameter("numeroContrato");
	    String objetoContrato = req.getParameter("objetoContrato");
	    String dataAssinaturaStr = req.getParameter("dataAssinatura");
	    String valorTotalStr = req.getParameter("valorTotal");
	    String empresaIdStr = req.getParameter("empresaId");
	    boolean statusAtivo = req.getParameter("statusAtivo") != null;
	    
	    try {
	        java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dataAssinaturaStr);
	        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	        BigDecimal valorTotal = new BigDecimal(valorTotalStr);
	        int empresaId = Integer.parseInt(empresaIdStr);
	        
	        Empresa empresa = new Empresa();
	        empresa.setId(empresaId);

	        Contrato contrato = new Contrato();
	        contrato.setNumeroContrato(numeroContrato);
	        contrato.setObContrato(objetoContrato);
	        contrato.setDataAssinatura(sqlDate);
	        contrato.setValorTotal(valorTotal);
	        contrato.setStatusAtivo(statusAtivo);
	        contrato.setEmpresa(empresa);

	        ContratoDAO dao = DAOFactory.createDAO(ContratoDAO.class);
	        dao.save(contrato);
	        
	        ControllerUtil.sucessMessage(req, "Contrato '" + contrato.getNumeroContrato() + "' salvo com sucesso.");
	        
	    } catch (ModelException | ParseException | NumberFormatException e) {
	        e.printStackTrace();
	        ControllerUtil.errorMessage(req, "Erro ao salvar contrato: " + e.getMessage());
	    }
	}
	
	private void atualizarContrato(HttpServletRequest req) {
	    try {
            int id = Integer.parseInt(req.getParameter("id"));
            String numeroContrato = req.getParameter("numeroContrato");
            String objetoContrato = req.getParameter("objetoContrato");
            String dataAssinaturaStr = req.getParameter("dataAssinatura");
            String valorTotalStr = req.getParameter("valorTotal");
            String empresaIdStr = req.getParameter("empresaId");
            boolean statusAtivo = req.getParameter("statusAtivo") != null;
            
	        java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dataAssinaturaStr);
	        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	        BigDecimal valorTotal = new BigDecimal(valorTotalStr);
	        int empresaId = Integer.parseInt(empresaIdStr);

	        Empresa empresa = new Empresa();
	        empresa.setId(empresaId);
	        
	        ContratoDAO dao = DAOFactory.createDAO(ContratoDAO.class);
	        Contrato contrato = dao.findById(id); 
	        
	        contrato.setNumeroContrato(numeroContrato);
	        contrato.setObContrato(objetoContrato);
	        contrato.setDataAssinatura(sqlDate);
	        contrato.setValorTotal(valorTotal);
	        contrato.setStatusAtivo(statusAtivo);
	        contrato.setEmpresa(empresa);
	        
	        dao.update(contrato);
	        
	        ControllerUtil.sucessMessage(req, "Contrato '" + contrato.getNumeroContrato() + "' atualizado com sucesso.");
	        
	    } catch (ModelException | ParseException | NumberFormatException e) {
	        e.printStackTrace();
	        ControllerUtil.errorMessage(req, "Erro ao atualizar contrato: " + e.getMessage());
	    }
	}
	
	private void deletarContrato(HttpServletRequest req) {
	    try {
	        int id = Integer.parseInt(req.getParameter("id"));
	        ContratoDAO dao = DAOFactory.createDAO(ContratoDAO.class);
	        Contrato contrato = new Contrato();
	        contrato.setId(id);
	        
	        dao.delete(contrato);
	        
	        ControllerUtil.sucessMessage(req, "Contrato ID " + id + " excluído com sucesso.");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        ControllerUtil.errorMessage(req, "Erro ao excluir contrato.");
	    }
	}
}