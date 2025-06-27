<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<%@include file="base-head.jsp"%>
		<title>${not empty empresa.id ? 'Editar' : 'Adicionar'} Empresa</title>
	</head>
	<body>
		<%@include file="nav-menu.jsp"%>
			
		<div id="container" class="container-fluid">
			<h3 class="page-header">${not empty empresa.id ? 'Editar' : 'Adicionar'} Empresa</h3>

			<form action="${pageContext.request.contextPath}/empresa/${action}" method="POST">
				<input type="hidden" value="${empresa.id}" name="id">
				
				<div class="row">
					<div class="form-group col-md-8">
						<label for="razaoSocial">Razão Social</label>
						<input type="text" class="form-control" id="razaoSocial" name="razaoSocial" 
							   placeholder="Nome da empresa" value="${empresa.razaoSocial}"
							   required oninvalid="this.setCustomValidity('Por favor, informe a razão social.')"
							   oninput="setCustomValidity('')">
					</div>

					<div class="form-group col-md-4">
						<label for="cnpj">CNPJ</label>
						<input type="text" class="form-control" id="cnpj" name="cnpj"
							   placeholder="00.000.000/0000-00" value="${empresa.cnpj}"
							   required oninvalid="this.setCustomValidity('Por favor, informe o CNPJ.')"
							   oninput="setCustomValidity('')">
					</div>
				</div>
				
				<hr />
				<div id="actions" class="row pull-right">
					<div class="col-md-12">
						<a href="${pageContext.request.contextPath}/empresas" class="btn btn-default">Cancelar</a>
						<button type="submit" class="btn btn-primary">${not empty empresa.id ? "Alterar" : "Cadastrar"}</button>
					</div>
				</div>
			</form>
		</div>

		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	</body>
</html>