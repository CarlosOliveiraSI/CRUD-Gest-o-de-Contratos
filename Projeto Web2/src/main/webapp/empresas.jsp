<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png"/>

  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet"/>
  
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>

  <title>Gerenciar Empresas</title>

  <style>
    body { font-family: 'Open Sans', sans-serif; background: #eef2f5; margin: 0; padding: 0; }
    .sidebar { position: fixed; top: 0; left: 0; width: 220px; height: 100vh; background: #343a40; padding-top: 20px; }
    .sidebar .brand { text-align: center; margin-bottom: 30px; }
    .sidebar .brand img { max-width: 50px; }
    .sidebar .brand span { color: #fff; font-weight: bold; margin-left: .5rem; }
    .sidebar a { color: #adb5bd; display: block; padding: 10px 20px; text-decoration: none; }
    .sidebar a.active, .sidebar a:hover { background: #495057; color: #fff; }
    .content { margin-left: 220px; padding: 40px; }
    #alert { position: absolute; top: 20px; right: 30px; min-width: 300px; z-index: 1000; }

   
    .table {
      table-layout: fixed;
      width: 100%;
    }
    .table th, .table td {
      width: calc(100% / 3);
      padding: 1rem 1rem;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    .btn-add { margin-bottom: 20px; }
    .btn-add .btn { font-size: 1rem; padding: .5rem 1rem; }
    .icon-btn { margin: 0 0.75rem; }
    .icon-btn i { font-size: 1.1rem; vertical-align: middle; }
  </style>
</head>
<body>

  
  <div class="sidebar">
    <div class="brand">
      <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo"/>
      <span>Gestão de Contratos</span>
    </div>
    <a href="${pageContext.request.contextPath}" class=""><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/empresas" class="active"><i class="bi bi-building me-2"></i>Empresas</a>
    <a href="${pageContext.request.contextPath}/contratos"><i class="bi bi-file-earmark-text me-2"></i>Contratos</a>
  </div>

  
  <div class="content">

    
    <c:if test="${not empty message}">
      <div id="alert" class="alert alert-info alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="mb-0"><i class="bi bi-building me-2"></i>Empresas</h2>
      <!-- Botão de adicionar estilizado -->
      <div class="btn-add">
        <a href="${pageContext.request.contextPath}/empresa/form" class="btn btn-danger">
          <i class="bi bi-plus-lg me-1"></i>Adicionar Empresa
        </a>
      </div>
    </div>

    <div class="card shadow-sm">
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped table-hover mb-0 align-middle">
            <thead class="table-dark">
              <tr>
                <th>Razão Social</th>
                <th>CNPJ</th>
                <th class="text-center">Ações</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="empresa" items="${listaDeEmpresas}">
                <tr>
                  <td>${empresa.razaoSocial}</td>
                  <td>${empresa.cnpj}</td>
                  <td class="text-center">
                    <a class="btn btn-sm btn-outline-info icon-btn" href="${pageContext.request.contextPath}/empresa/update?id=${empresa.id}" title="Editar">
                      <i class="bi bi-pencil"></i>
                    </a>
                    <a class="btn btn-sm btn-outline-danger icon-btn" href="${pageContext.request.contextPath}/empresa/delete?id=${empresa.id}" title="Excluir" onclick="return confirm('Excluir empresa ${empresa.razaoSocial}?');">
                      <i class="bi bi-trash"></i>
                    </a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty listaDeEmpresas}">
                <tr><td colspan="3" class="text-center py-4">Nenhuma empresa cadastrada.</td></tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

  </div>

  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script>
    setTimeout(() => {
      const a = document.querySelector('.alert');
      a && new bootstrap.Alert(a).close();
    }, 3000);
  </script>

</body>
</html>
