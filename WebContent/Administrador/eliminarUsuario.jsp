<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    	<%@ page import="java.util.List"%>
	<%@ page import="modelo.*"%>
	<%@ page import="clase.*"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="java.util.Iterator"%>
<%

Usuario usuarioA=new Usuario();;
Object u = session.getAttribute("iniciado");
if (u != null) {
	usuarioA = (Usuario) u;
		
}else{
	response.sendRedirect("../index.jsp");	
}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Eliminar Usuario</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  
  $(document).ready(function(){
	    $("button,a").click(function(){
	        $("div").hide();

	    )};
  
  
  </script>

</head>
<body>
 	<%
	
	String nombre= request.getParameter("nombre");
	
	UsuarioModelo um= new UsuarioModelo();
	Usuario usuario= um.select(nombre);
	
	if(request.getParameter("seguro")!=null){
		
		if(request.getParameter("seguro").equals("yes")){
			
			if (usuarioA.getRol().equals("admin")){
				um.delete(nombre);
				out.print("	<div class='alert alert-success'> <span class='glyphicon glyphicon-ok'></span> <span class='sr-only'></span> USUARIO ELIMINADO</div>");
				
				out.print("<a href='gestorUsuarios.jsp'><button type='button' class='btn btn-info'>Volver atras</button></a>");
			}else if (usuario.getNombre().equals(usuarioA.getNombre())){
				session.removeAttribute("iniciado");
				um.delete(nombre);
				out.print("	<div class='alert alert-success'> <span class='glyphicon glyphicon-ok'></span> <span class='sr-only'></span> USUARIO ELIMINADO</div>");
				
				out.print("<a href='gestorUsuarios.jsp'><button type='button' class='btn btn-info'>Volver atras</button></a>");
			}
			
			out.print("	<div class='alert alert-danger'>NO TIENES PERMISOS PARA ELIMINAR ESTE USUARIO</div>");
			
			out.print("<a href='gestorUsuarios.jsp'><button type='button' class='btn btn-info'>Volver atras</button></a>");
		}
		
	}else{%>
		
		
		<div class="panel panel-primary">
      <div class="panel-heading">¿Estas seguro de eliminar el siguiente usuario?</div>
      <div class="panel-body">
         <%out.print("<div class='panel-body'><b>USUARIO</b>: "+usuario.getNombre()+"</div>"); %>
		
		
		<a class="btn btn-success" href="eliminarUsuario.jsp?seguro=yes&nombre=<%=request.getParameter("nombre")%>">Si, estoy seguro</a>
		<a href="gestorUsuarios.jsp"><button type="button" class="btn btn-danger">No, volver atras</button></a>
		
		
      </div>
    </div>
		
		
	<%}
	
	%>







  

</body>
</html>