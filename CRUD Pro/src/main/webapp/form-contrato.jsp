<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
	<head>
		
		<%@include file="base-head.jsp"%>
		<title>${not empty contrato.id ? 'Editar' : 'Adicionar'} Contrato</title>
	</head>
	<body>
		
		<%@include file="nav-menu.jsp"%>
			
		<div id="container" class="container-fluid">
			
			<h3 class="page-header">${not empty contrato.id ? 'Editar' : 'Adicionar'} Contrato</h3>

			
			<form action="${pageContext.request.contextPath}/contrato/${action}" method="POST">
				
				<input type="hidden" value="${contrato.id}" name="id">
				
				<div class="row">
					<div class="form-group col-md-8">
						<label for="numeroContrato">Número do Contrato</label>
						<input type="text" class="form-control" id="numeroContrato" name="numeroContrato" 
							   placeholder="Ex: CT-2025-001" value="${contrato.numeroContrato}"
							   required oninvalid="this.setCustomValidity('Por favor, informe o número do contrato.')"
							   oninput="setCustomValidity('')">
					</div>

					<div class="form-group col-md-4">
						<label for="dataAssinatura">Data da Assinatura</label>
						<fmt:formatDate value="${contrato.dataAssinatura}" pattern="yyyy-MM-dd" var="formattedDate" />
						<input type="date" class="form-control" id="dataAssinatura" name="dataAssinatura"
							   value="${formattedDate}"
							   required oninvalid="this.setCustomValidity('Por favor, informe a data.')"
							   oninput="setCustomValidity('')">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label for="objetoContrato">Objeto do Contrato</label>
						<textarea class="form-control" id="objetoContrato" name="objetoContrato" rows="3"
								  required oninvalid="this.setCustomValidity('Por favor, descreva o objeto do contrato.')"
							   	  oninput="setCustomValidity('')">${contrato.objetoContrato}</textarea>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label for="empresaId">Empresa</label>
						
						<select id="empresaId" name="empresaId" class="form-control selectpicker"
								required oninvalid="this.setCustomValidity('Por favor, selecione uma empresa.')"
							    oninput="setCustomValidity('')">
							<option value="" disabled ${empty contrato.empresa ? 'selected' : ''}>Selecione uma empresa</option>
							<c:forEach var="empresa" items="${listaDeEmpresas}">
								<option value="${empresa.id}" ${contrato.empresa.id == empresa.id ? 'selected' : ''}>
									${empresa.razaoSocial}
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group col-md-4">
						<label for="valorTotal">Valor Total (R$)</label>
						<input type="number" class="form-control" id="valorTotal" name="valorTotal"
							   value="${contrato.valorTotal}" step="0.01" min="0" placeholder="Ex: 1500.50"
							   required oninvalid="this.setCustomValidity('Por favor, informe um valor.')"
							   oninput="setCustomValidity('')">
					</div>
					<div class="form-group col-md-2" style="padding-top: 25px;">
						<div class="checkbox">
							<label>
								<input type="checkbox" id="statusAtivo" name="statusAtivo" value="true" ${contrato.statusAtivo ? 'checked' : ''}>
								<strong>Contrato Ativo</strong>
							</label>
						</div>
					</div>
				</div>
				
				<hr />

				
				<div id="actions" class="row pull-right">
					<div class="col-md-12">
						<a href="${pageContext.request.contextPath}/contratos" class="btn btn-default">Cancelar</a>
						<button type="submit" class="btn btn-primary">${not empty contrato.id ? "Alterar Contrato" : "Cadastrar Contrato"}</button>
					</div>
				</div>
			</form>
		</div>

		
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>