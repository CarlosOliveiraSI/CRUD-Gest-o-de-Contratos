<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<nav id="menu" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
		    <span class="sr-only">Toggle navigation</span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		    <span class="icon-bar"></span>
		   </button>
			<a class="navbar-brand" href="${pageContext.request.contextPath}">
		    	<span><img height="40px" width="40px" alt="" src="${pageContext.request.contextPath}/images/G.png"><strong>&nbsp;Gestão de Contratos</strong></span>
		    </a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="${pageContext.request.contextPath}/empresas"><span class="glyphicon glyphicon-pushpin" /><strong>&nbsp;Empresas</strong></a></li>
				<li><a href="${pageContext.request.contextPath}/contratos"><span class="glyphicon glyphicon-file" /><strong>&nbsp;Contratos</strong></a></li>
				
				<c:if test="${not empty sessionScope.usuarioLogado}">
					<li class="dropdown">
						
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">
							<strong><span class="glyphicon glyphicon-user" /></span>&nbsp;Olá, ${sessionScope.usuarioLogado.nome}</strong>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							
							<li>
								<a href="${pageContext.request.contextPath}/logout">
									<span class="glyphicon glyphicon-log-out" /></span>&nbsp;Sair
								</a>
							</li>
						</ul>
					</li>
				</c:if>
				</ul>
		</div>
	</div>
</nav>
<br /><br /><br />