<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<%@include file="base-head.jsp"%>
		<title>Login - Gestor de Contratos</title>
		<style>
			/* Estilo simples para centralizar o formulário na página */
			body {
				background-color: #f8f9fa; /* Um cinza bem claro */
			}
			.login-container {
				max-width: 400px;
				margin: 100px auto;
				padding: 25px;
				background-color: #fff;
				border: 1px solid #ddd;
				border-radius: 8px;
				box-shadow: 0 4px 8px rgba(0,0,0,0.05);
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="login-container">
				<h2 class="text-center">Acessar o Sistema</h2>
				<hr>
				
				<%-- Bloco para exibir mensagem de erro de login, se houver --%>
				<c:if test="${not empty loginError}">
					<div class="alert alert-danger">
						${loginError}
					</div>
				</c:if>

				<%-- O formulário envia os dados para o futuro LoginController --%>
				<form action="${pageContext.request.contextPath}/login" method="POST">
					<div class="form-group">
						<label for="login">Usuário</label>
						<input type="text" name="login" id="login" class="form-control" placeholder="Digite seu login" required autofocus>
					</div>
					<div class="form-group">
						<label for="senha">Senha</label>
						<input type="password" name="senha" id="senha" class="form-control" placeholder="Digite sua senha" required>
					</div>
					<button type="submit" class="btn btn-danger btn-block btn-lg" style="margin-top: 20px;">Entrar</button>
				</form>
			</div>
		</div>
		
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	</body>
</html>