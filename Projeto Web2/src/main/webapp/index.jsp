<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png"/>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet"/>
  <!-- Bootstrap + Icons -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <title>Dashboard - Gestor de Contratos</title>

  <style>
    body {
      font-family: 'Open Sans', sans-serif;
      background: #eef2f5;
      margin: 0; padding: 0;
    }
    .sidebar {
      position: fixed; top: 0; left: 0;
      width: 220px; height: 100vh;
      background: #343a40; padding-top: 20px;
    }
    .sidebar .brand {
      text-align: center; margin-bottom: 30px;
    }
    .sidebar .brand img {
      max-width: 50px; vertical-align: middle;
    }
    .sidebar .brand span {
      color: #fff; font-weight: bold; margin-left: 5px;
    }
    .sidebar a {
      display: block; color: #adb5bd;
      padding: 10px 20px; text-decoration: none;
    }
    .sidebar a.active, .sidebar a:hover {
      background: #495057; color: #fff;
    }
    .content {
      margin-left: 220px; padding: 30px;
    }
    #alert {
      position: absolute; top: 20px; right: 30px;
      min-width: 300px; z-index: 1000;
    }
    .dashboard-card {
      background: #fff; border-radius: .25rem;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      padding: 1.5rem; text-align: center;
    }
  </style>
</head>
<body>

  <!-- Sidebar fixa -->
  <div class="sidebar">
    <div class="brand">
      <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
      <span>Gestão de Contratos</span>
    </div>
    <a href="${pageContext.request.contextPath}" class="active"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/empresas"><i class="bi bi-building me-2"></i>Empresas</a>
    <a href="${pageContext.request.contextPath}/contratos"><i class="bi bi-file-earmark-text me-2"></i>Contratos</a>
  </div>

  <!-- Conteúdo principal -->
  <div class="content">

    <!-- Alerta de mensagem -->
    <c:if test="${not empty message}">
      <div id="alert" class="alert alert-info alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <h2 class="mb-4"><i class="bi bi-speedometer2 me-2"></i>Dashboard</h2>

    <!-- Painel de contratos -->
    <div class="row mb-4">
      <div class="col-4">
        <div class="dashboard-card">
          <h1 class="display-4 mb-0">${listaDeContratos.size()}</h1>
          <p class="text-secondary mb-0">Contratos Cadastrados</p>
        </div>
      </div>
    </div>

    <!-- Tabela dentro de card -->
    <div class="card shadow-sm">
      <div class="card-header bg-dark text-white">
        <i class="bi bi-graph-up me-2"></i>Visão Geral dos Contratos
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0 align-middle">
            <thead class="table-dark">
              <tr>
                <th>Nº Contrato</th>
                <th>Empresa</th>
                <th>Valor</th>
                <th>Status</th>
                <th class="text-center">Ações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="contrato" items="${listaDeContratos}">
                <tr>
                  <td>${contrato.numeroContrato}</td>
                  <td>${contrato.empresa.razaoSocial}</td>
                  <td><fmt:formatNumber value="${contrato.valorTotal}" type="currency" currencySymbol="R$"/></td>
                  <td>
                    <span class="badge ${contrato.statusAtivo ? 'bg-success' : 'bg-secondary'}">
                      ${contrato.statusAtivo ? 'Ativo' : 'Inativo'}
                    </span>
                  </td>
                  <td class="text-center">
                    <a class="btn btn-sm btn-outline-info me-1"
                       href="${pageContext.request.contextPath}/contrato/update?id=${contrato.id}">
                      <i class="bi bi-pencil-fill"></i>
                    </a>
                    <a class="btn btn-sm btn-outline-danger"
                       href="${pageContext.request.contextPath}/contrato/delete?id=${contrato.id}"
                       onclick="return confirm('Excluir contrato N° ${contrato.numeroContrato}?');">
                      <i class="bi bi-trash-fill"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty listaDeContratos}">
                <tr>
                  <td colspan="5" class="text-center py-3">Nenhum contrato cadastrado.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </div>

  <!-- Bootstrap JS -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script>
    // Fecha alerta automático
    setTimeout(() => {
      const alertEl = document.querySelector('.alert');
      alertEl && new bootstrap.Alert(alertEl).close();
    }, 3000);
  </script>

</body>
</html>
