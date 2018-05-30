<%@page import="clase.Usuario"%>
<%@page import="clase.Publicacion"%>
<%@page import="modelo.PublicacionModelo"%>
<%@page import="java.util.Iterator"%>
<%@page import="modelo.MejorPublicacionModelo"%>
<%@page import="clase.MejorPublicacion"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Usuario usuario=new Usuario();;
Object u = session.getAttribute("iniciado");
if (u != null) {
	usuario = (Usuario) u;
		if (usuario.getRol().equals("usuario")){
			response.sendRedirect("../index.jsp");	
		}
}else{
	response.sendRedirect("../index.jsp");	
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <title>Memes Club</title>

    <!-- Bootstrap core CSS -->


    <!-- Custom styles for this template -->
    <link href="../css/style.css" rel="stylesheet">

  </head>
<body>
	<!-- Navigation -->
	 <nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="../index.jsp" id="logo"><img src="../imgs/logo1.png" width="70px" /></a>
			</div>
			<ul class="nav navbar-nav">
			 	<li><a href="../index.jsp">Mejores</a></li>
				<li><a href="../index.jsp?opcion=ultimos">Ultimos</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">

				<%
					if (u != null) {
							usuario = (Usuario) u;
							
								out.print("<li class='dropdown'>");
								out.print("<a class='dropdown-toggle' data-toggle='dropdown' href='#'>" + usuario.getNombre());
				%>
				<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<%if(usuario.getRol().equals("admin")){
						%>
						<li><a href="gestor.jsp">Gestion</a></li>
					<% }%>
					<li><a href="../logout.jsp">Cerrar Sesion</a></li>
					<li><a href="../nueva_publicacion.jsp" ><span class="glyphicon glyphicon-plus"></span>Añadir publicacion</a></li>
				</ul>
				</li>
				<%
					
						} else {
							out.print(" <li><a href='../loginForm.jsp'><span class='glyphicon glyphicon-user'></span> Iniciar Sesion</a></li>");
							out.print(" <li><a href='crearUsuario.jsp'><span class='glyphicon glyphicon-user'></span> Registrarse</a></li>");
						}
				%>

			</ul>
		</div>
	</nav>
	
	
	<h3>Gestor Publicaciones</h3>
	<a href="?mejores=buscar">
		<button >Buscar Mejores Publicaciones</button>
	</a>
	<%
	PublicacionModelo publicacionModelo=new PublicacionModelo();
	String mejores=request.getParameter("mejores");
		if (mejores!=null){
			if (mejores.equals("buscar")){
				int dias=1;
				if (request.getParameter("alargar")!=null){
					dias=Integer.parseInt(request.getParameter("alargar"));
				}
				
				ArrayList<Publicacion> publicaciones=publicacionModelo.buscarNuevosMejoresPubli(dias);
				dias=dias+1;
				if(publicaciones.size()==0){
					%>
					<div class="alert alert-danger">
						  <strong>Error!</strong> No se encontro ninguna publicacion
					</div>
					<a href="?mejores=buscar&alargar=<%=dias%>">
						<button >Alargar fecha limite</button>
					</a>
					<%
				}else if(publicaciones.size()<5){
					%>
					<div class="alert alert-warning">
						  Solo se encontraron <strong><%=publicaciones.size() %> publicaciones</strong> (tienen que ser 5)
					</div>
					<a href="?mejores=buscar&alargar=<%=dias%>">
						<button >Alargar fecha limite</button>
					</a>
					<%
				}else{
					%>
					<div class="alert alert-success">
					  Se encontraron <strong><%=publicaciones.size() %> publicaciones</strong>
					</div>
					
					<a href="?mejores=subir&alargado=<%=dias%>">
						<button >Subir</button>
					</a>
					<%
				}
				
			}else if(mejores.equals("subir")){
				int dias=Integer.parseInt(request.getParameter("alargado"));
				ArrayList<Publicacion> publicaciones=publicacionModelo.buscarNuevosMejoresPubli(dias);
				MejorPublicacionModelo mejorPublicacionModelo=new MejorPublicacionModelo();
				
				Iterator<Publicacion> i=publicaciones.iterator();
				while(i.hasNext()){
					mejorPublicacionModelo.insert(i.next());
				}
		}
		}
	%>

</body>
</html>