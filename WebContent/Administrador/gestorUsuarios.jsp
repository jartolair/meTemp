<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="modelo.*"%>

<%
	Usuario usuarioA = null;
	Object u = session.getAttribute("iniciado");

	if (u != null) {
		usuarioA = (Usuario) u;
		if (usuarioA.getRol().equals("admin")) {
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lista de Usuarios</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" charset="utf8"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#tabla').DataTable();
	});
</script>

</head>
<body>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="java.util.Iterator"%>
	<%@ page import="clase.*"%>

	<table id="tabla" class="display">
		<thead>
			<tr>
				<th>Usuario</th>
				<th>Contraseña</th>
				<th>Acciones</th>
				<th>Rol</th>
				<th>Imagen Perfil</th>
			</tr>
		</thead>
		<tbody>


			<%
				Usuario usuario = new Usuario();

						UsuarioModelo um = new UsuarioModelo();

						ArrayList<Usuario> usuarios = um.selectAll();

						Iterator<Usuario> i = usuarios.iterator();

						while (i.hasNext()) {
							usuario = i.next();

							out.println("<tr> <td> " + usuario.getNombre() + "</td>");
							out.println("<td>" + usuario.getPassword() + "</td>");
							
							

							out.println("<td><a href='../PerfilUsuario?nombre=" + usuario.getNombre()
									+ "'>Ver</a>   <a href='eliminarUsuario.jsp?nombre=" + usuario.getNombre()
									+ "'>/Eliminar</a> <a href='banearUsuario.jsp?nombre=" + usuario.getNombre()
									+ "'>/Banear</a></td> ");

							out.println("<td>" + usuario.getRol() + "</td>");
							out.println("<td>" + usuario.getImagenPerfil() + "</td>");
						}

						out.println("</tr>");
			%>
		</tbody>
	</table>

	<ul class="pagination">

		<%
			out.print("<li><a href='crearUsuario.jsp' style:'float: left'>Añadir Usuario</a></li>");

				}else{
					response.sendRedirect("../index.jsp");
				}
			}else{
				response.sendRedirect("../loginForm.jsp");
			}
		%>

	</ul>





</body>
</html>