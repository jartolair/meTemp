<%@page import="clase.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%

    Usuario usuario = null;
    	Object u = session.getAttribute("iniciado");
    	if (u != null) {
    		usuario = (Usuario) u;

    session.removeAttribute("iniciado");
    out.print("<div class='alert alert-info'> <strong>Sesion cerrada correctamente</strong></div>");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logout</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<a href="index.jsp">Volver a la pagina principal</a>

</body>
</html>

<%
    	}else{
    		response.sendRedirect("index.jsp");
    	}
%>
