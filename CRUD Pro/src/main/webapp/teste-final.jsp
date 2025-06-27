<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Imports necessários para o código Java --%>
<%@ page import="java.util.List, java.util.ArrayList, model.Contrato, model.dao.ContratoDAO, model.dao.DAOFactory, model.ModelException" %>
<%@ page import="model.dao.MysqlContratoDAO" %> <%-- <<< ADICIONE ESTE NOVO IMPORT --%>

<%-- Import da biblioteca de tags JSTL --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Contrato> listaDeContratos = null;
    String erro = null;

    try {
        // ======================================================================
        //   MUDANÇA PRINCIPAL AQUI: Ignorando a Factory e a Interface
        // ======================================================================
        MysqlContratoDAO dao = new MysqlContratoDAO();
        listaDeContratos = dao.listAll();
        // ======================================================================

    } catch (Exception e) {
        e.printStackTrace();
        erro = "Ocorreu um erro ao tentar buscar os dados: " + e.getMessage();
    }
    
    request.setAttribute("lista", listaDeContratos);
    request.setAttribute("erroMsg", erro);
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teste Final de Listagem</title>
</head>
<body>

    <h1>Teste Final e Definitivo</h1>

    <%-- Se a variável 'erro' não for nula, exibe a mensagem de erro --%>
    <c:if test="${not empty erroMsg}">
        <h2 style="color: red;">Ocorreu um Erro:</h2>
        <p><c:out value="${erroMsg}" /></p>
    </c:if>

    <p><b>A JSTL está funcionando?</b> <c:out value="'Sim, a JSTL processou esta tag.'" /></p>
    <p><b>A lista foi recebida?</b> ${empty lista ? "Não, a lista é nula ou vazia." : "Sim, a lista foi recebida."}</p>
    <p><b>Tamanho da lista:</b> ${lista.size()}</p>
    
    <hr>

    <h3>Tabela de Resultados</h3>
    <table border="1">
        <thead>
            <tr>
                <th>ID do Contrato</th>
                <th>Número do Contrato</th>
                <th>Nome da Empresa</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${lista}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.numeroContrato}</td>
                    <td>${item.empresa.razaoSocial}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>