<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
	<head>
		
		<%@include file="base-head.jsp"%>
		<title>Gerenciar Contratos</title>
	</head>
	<body>
		
		<%@include file="modal.html"%>
		
		<%@include file="nav-menu.jsp"%>
			
		<div id="container" class="container-fluid">
			
			<div id="alert" style="${not empty message ? 'display: block;' : 'display: none;'}" class="alert alert-dismissable ${alertType eq 1 ? 'alert-success' : 'alert-danger'}">
			  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			  ${message}
			</div>
		
	 	 	<div id="top" class="row">
	 			<div class="col-md-3">
			        <h3>Contratos</h3>
			    </div>
			 
			    <div class="col-md-6">
			        <div class="input-group h2">
			           
			            
			        </div>
			    </div>
			 
			    <div class="col-md-3">
			        <a href="${pageContext.request.contextPath}/contrato/form" class="btn btn-danger pull-right h2"><span class="glyphicon glyphicon-plus" /></span>&nbsp;Adicionar Contrato</a>
			    </div>
	     	</div>
	 
	     	<hr />
	     	
	     	<div id="list" class="row">
	     		<div class="table-responsive col-md-12">
			        <table class="table table-striped table-hover" cellspacing="0" cellpadding="0">
			            <thead>
			                <tr>
			                    <th>Número do Contrato</th>
			                    <th>Empresa</th>
			                    <th>Valor</th>
			                    <th>Status</th>
			                    <th class="actions">Ações</th>
			                 </tr>
			            </thead>
			            <tbody>
			            	<c:forEach var="contrato" items="${listaDeContratos}">
								<tr>
				                    <td>${contrato.numeroContrato}</td>
				                    <td>${contrato.empresa.razaoSocial}</td>
				                    <td><fmt:formatNumber value="${contrato.valorTotal}" type="currency" currencySymbol="R$"/></td>
				                    <td>${contrato.statusAtivo ? 'Ativo' : 'Inativo'}</td>				                    
				                    <td class="actions">
				                    	<a class="btn btn-info btn-xs" 
				                           href="${pageContext.request.contextPath}/contrato/update?id=${contrato.id}" >
				                           <span class="glyphicon glyphicon-edit"></span>
				                        </a>
				                        <a class="btn btn-danger btn-xs modal-remove"
				                           contrato-id="${contrato.id}" 
				                           contrato-numero="${contrato.numeroContrato}" data-toggle="modal" 
				                           data-target="#delete-modal"  href="#"><span 
				                           class="glyphicon glyphicon-trash"></span></a>
				                    </td>
				                </tr>
							</c:forEach>
			            </tbody>
			         </table>
			     </div>
	     	</div>
	 
	     	<div id="bottom" class="row">
	     		<div class="col-md-12">
			        <ul class="pagination">
			            <li class="disabled"><a>&lt; Anterior</a></li>
			            <li class="disabled"><a>1</a></li>
			            <li><a href="#">2</a></li>
			            <li><a href="#">3</a></li>
			            <li class="next"><a href="#" rel="next">Próximo &gt;</a></li>
			        </ul>
			    </div>
	     	</div>
		</div>
		
		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
			    setTimeout(function() {
			        $("#alert").slideUp(500);
			    }, 3000);
			    
			    $(".modal-remove").click(function () {
		            var contratoNumero = $(this).attr('contrato-numero');
		            var contratoId = $(this).attr('contrato-id');
		            $(".modal-body #hiddenValue").text("o contrato '"+contratoNumero+"'");
		            $("#id").attr( "value", contratoId);
		            $("#form").attr( "action","contrato/delete");
		        })
			});
		</script>
	</body>
</html>