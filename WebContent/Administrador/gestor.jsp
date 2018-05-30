<%@page import="clase.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Usuario usuarioA=new Usuario();;
Object u = session.getAttribute("iniciado");
if (u != null) {
	usuarioA = (Usuario) u;
		if (usuarioA.getRol().equals("usuario")){
			response.sendRedirect("../index.jsp");	
		}
}else{
	response.sendRedirect("../index.jsp");	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GESTOR DE USUARIOS Y PUBLICACIONES</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
  .tamanio{
  	width:100%;
  	height:100%;
  
  }
  
  
  
  </style>
</head>
<body>
   <div class="panel panel-primary">
      <div class="panel-heading">GESTOR DE USUARIOS Y PUBLICACIONES</div>
      <div class="panel-body">
      
      <a href="gestorUsuarios.jsp"><button type="button" class="btn btn-primary">Usuarios</button></a>
      <a href="gestorPublicaciones.jsp"><button type="button" class="btn btn-primary" >Publicaciones</button></a>
      
      
      </div>
    </div>
</body>
</html>