<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png" />

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet" />
  <!-- Bootstrap + Icons -->
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />

  <title>${not empty empresa.id ? 'Editar Empresa' : 'Adicionar Empresa'}</title>

  <style>
    body { font-family:'Open Sans',sans-serif; background:#eef2f5; margin:0; padding:0; }
    .sidebar { position:fixed; top:0; left:0; width:220px; height:100vh; background:#343a40; padding-top:20px; }
    .sidebar .brand { text-align:center; margin-bottom:30px; }
    .sidebar .brand img { max-width:50px; }
    .sidebar .brand span { color:#fff; font-weight:bold; margin-left:.5rem; }
    .sidebar a { color:#adb5bd; display:block; padding:10px 20px; text-decoration:none; }
    .sidebar a.active, .sidebar a:hover { background:#495057; color:#fff; }
    .content { margin-left:220px; padding:40px; }
    .form-card { background:#fff; border-radius:.25rem; box-shadow:0 2px 8px rgba(0,0,0,0.1); }
    .form-header { background:#343a40; color:#fff; padding:1rem; border-top-left-radius:.25rem; border-top-right-radius:.25rem; }
    .form-body { padding:1.5rem; }
    .form-footer { padding:1rem 1.5rem; text-align:right; }
    #alert { position:absolute; top:20px; right:30px; min-width:300px; z-index:1000; }
  </style>
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar">
    <div class="brand">
      <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" />
      <span>Gestão de Contratos</span>
    </div>
    <a href="${pageContext.request.contextPath}" ><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/empresas" class="active"><i class="bi bi-building me-2"></i>Empresas</a>
    <a href="${pageContext.request.contextPath}/contratos"><i class="bi bi-file-earmark-text me-2"></i>Contratos</a>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="form-card">
      <div class="form-header">
        <h4 class="mb-0">
          <i class="bi bi-building me-1"></i>
          ${not empty empresa.id ? 'Editar Empresa' : 'Adicionar Empresa'}
        </h4>
      </div>
      <form action="${pageContext.request.contextPath}/empresa/${action}" method="post">
        <input type="hidden" name="id" value="${empresa.id}" />
        <div class="form-body">
          <div class="mb-3">
            <label for="razaoSocial" class="form-label">Razão Social</label>
            <input type="text" id="razaoSocial" name="razaoSocial" class="form-control" placeholder="Nome da empresa"
                   value="${empresa.razaoSocial}" required />
          </div>
          <div class="mb-3">
            <label for="cnpj" class="form-label">CNPJ</label>
            <input type="text" id="cnpj" name="cnpj" class="form-control" placeholder="00.000.000/0000-00"
                   value="${empresa.cnpj}" required />
          </div>
        </div>
        <div class="form-footer">
          <a href="${pageContext.request.contextPath}/empresas" class="btn btn-secondary me-2">Cancelar</a>
          <button type="submit" class="btn btn-primary">
            ${not empty empresa.id ? 'Alterar' : 'Cadastrar'}
          </button>
        </div>
      </form>
    </div>
  </div>

  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
