<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login - Gestor de Contratos</title>

	<!-- Favicon, fontes e Bootstrap local -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Fira+Sans|Open+Sans">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

	<style>
		body {
			background-color: #f8f9fa;
			font-family: 'Open Sans', sans-serif;
		}
		.login-wrapper {
			max-width: 500px;
			margin: 80px auto;
			padding: 30px;
			background-color: #fff;
			border-radius: 8px;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		}
	</style>
</head>
<body>

	<!-- Menu padrão -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}">
				<img height="30" width="30" src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
				<strong>&nbsp;Gestão de Contratos</strong>
			</a>
		</div>
	</nav>

	<!-- Formulário de login -->
	<div class="container">
		<div class="login-wrapper">
			<h3 class="text-center mb-4">Acessar o Sistema</h3>

			<c:if test="${not empty loginError}">
				<div class="alert alert-danger" role="alert">
					${loginError}
				</div>
			</c:if>

			<form action="${pageContext.request.contextPath}/login" method="POST">
				<div class="mb-3">
					<label for="login" class="form-label">Usuário</label>
					<input type="text" name="login" id="login" class="form-control" placeholder="Digite seu login" required autofocus>
				</div>
				<div class="mb-3">
					<label for="senha" class="form-label">Senha</label>
					<input type="password" name="senha" id="senha" class="form-control" placeholder="Digite sua senha" required>
				</div>
				<button type="submit" class="btn btn-danger w-100">Entrar</button>
			</form>
		</div>
	</div>

	<!-- Bootstrap JS local -->
	<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
