<%@page import="clase.Usuario"%>
<%@page import="java.util.Iterator"%>
<%@page import="modelo.CategoriaModelo"%>
<%@page import="clase.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
Usuario usuario = null;
	Object u = session.getAttribute("iniciado");
	if (u != null) {
		usuario = (Usuario) u;
	
	
%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  	.categoria{
  		padding:5px;
  	}
  </style>
  </head>
<body>
<%
	CategoriaModelo categoriaModelo=new CategoriaModelo();
	ArrayList<Categoria> categorias=categoriaModelo.selectAll();
%>
<h3>Nueva Publicacion</h3>

	<form action="subir_publicacion.jsp" method="post" enctype="multipart/form-data">
  <div class="form-group row">
    <label for="titulo" class="col-sm-2 col-form-label">Titulo</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="titulo" placeholder="Titulo">
    </div>
  </div>
  <div class="form-group row">
    <label for="imagen" class="col-sm-2 col-form-label">Imagen</label>
    <div class="col-sm-10">
      <input type="File" name="imagen">
    </div>
  </div>
  <div class="form-group row">
    <div class="col-sm-2">Categorias</div>
    <div class="col-sm-10">
      <div class="form-check">
      <table>
      <% 
      	Iterator<Categoria> i=categorias.iterator();
      
    	int cont=0;
      	while(i.hasNext()){
      		Categoria categoria=i.next();
      		cont++;
      		if (cont==1){
      			%><tr><%
      		}
      			%>
	      		<td class="categoria">
	      			<input class="form-check-input" type="checkbox" id="<%=categoria.getId()%>" name="<%=categoria.getNombre()%>" value="<%=categoria.getNombre()%>">
			        <label class="form-check-label" for="<%=categoria.getId()%>">
			          <%=categoria.getNombre() %>
			        </label>
	        	</td>
	        	<%
        	if (cont==4){
      			%></tr><%
      			cont=0;
      		}
      	}
      	
	%>
      
      	</table>
      </div>
    </div>
  </div>
  <div class="form-group row">
    <label for="etiquetas" class="col-sm-2 col-form-label">Etiquetas (opcional)</label>
    <div class="col-sm-10">
      <input type="text" name="etiquetas" class="form-control" placeholder="etiqueta1, etiqueta2, etiqueta3">
      <p style="color:orange;">*Separa las etiquetas por coma y espacio*</p>
    </div>
  </div>
  <div class="form-group row">
    <div class="col-sm-10">
      <input type="submit" value="Subir" name="subir" class="btn btn-primary"><a href="index.jsp" class="btn btn-secondary">Cancelar</a>
    </div>
  </div>
</form>
</body>
</html>
<%
}else{
		response.sendRedirect("loginForm.jsp");
	}
      %>