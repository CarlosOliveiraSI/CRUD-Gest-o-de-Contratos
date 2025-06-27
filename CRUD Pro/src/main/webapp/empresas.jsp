<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<%@include file="base-head.jsp"%>
		<title>CRUD Manager - Empresas</title>
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
			        <h3>Empresas</h3>
			    </div>
			 
			    <div class="col-md-6">
			        <div class="input-group h2">
			           
			            
			        </div>
			    </div>
			 
			    <div class="col-md-3">
			        <a href="${pageContext.request.contextPath}/empresa/form" class="btn btn-danger pull-right h2"><span class="glyphicon glyphicon-plus" /></span>&nbsp;Adicionar Empresa</a>
			    </div>
	     	</div>
	 
	     	<hr />
	     	
	     	<div id="list" class="row">
	     		<div class="table-responsive col-md-12">
			        <table class="table table-striped table-hover" cellspacing="0" cellpadding="0">
			            <thead>
			                <tr>
			                   
			                    <th>Razão Social</th>
			                    <th>CNPJ</th>
			                    <th class="actions">Ações</th>
			                 </tr>
			            </thead>
			            <tbody>
			            	
			            	<c:forEach var="empresa" items="${listaDeEmpresas}">
								<tr>
									
				                    <td>${empresa.razaoSocial}</td>
				                    <td>${empresa.cnpj}</td>
				                    
				                    <td class="actions">
				                    	
				                        <a class="btn btn-info btn-xs" 
				                           href="${pageContext.request.contextPath}/empresa/update?id=${empresa.id}" >
				                           <span class="glyphicon glyphicon-edit"></span>
				                        </a>
				                        <a class="btn btn-danger btn-xs modal-remove"
				                           empresa-id="${empresa.id}" 
				                           empresa-nome="${empresa.razaoSocial}" data-toggle="modal" 
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
			    
			    // Script do Modal CORRIGIDO para empresa
			    $(".modal-remove").click(function () {
		            var empresaNome = $(this).attr('empresa-nome');
		            var empresaId = $(this).attr('empresa-id');
		            $(".modal-body #hiddenValue").text("a empresa '"+empresaNome+"'");
		            $("#id").attr( "value", empresaId);
		            $("#form").attr( "action", "empresa/delete");
		        })
			});
		</script>
	</body>
</html>