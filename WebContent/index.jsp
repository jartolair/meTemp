<%@page import="modelo.VotoPubliModelo"%>
<%@page import="clase.Usuario"%>
<%@page import="modelo.CatPubliModelo"%>
<%@page import="modelo.MejorPublicacionModelo"%>
<%@page import="modelo.EtiquetaModelo"%>
<%@page import="clase.Categoria"%>
<%@page import="modelo.CategoriaModelo"%>
<%@page import="clase.Etiqueta"%>
<%@page import="clase.EtiquetaPublicacion"%>
<%@page import="clase.VotoPublicacion"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.PublicacionModelo"%>
<%@page import="clase.Publicacion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
    <%
    Usuario usuario = null;
	Object u = session.getAttribute("iniciado");
	if (u != null) {
		usuario = (Usuario) u;
	}
    
    
    
    String o=request.getParameter("opcion");
    String c=request.getParameter("categoria");
    String e=request.getParameter("etiqueta");
    String paginaSTR=request.getParameter("pagina");
    String b=request.getParameter("busqueda");
    
    int pagina=1;
    if(paginaSTR!=null){
    	pagina=Integer.parseInt(paginaSTR);
    	
    }
    
    
    
    
    ArrayList<Publicacion> publicaciones=new ArrayList<Publicacion>();
    PublicacionModelo publicacionModelo=new PublicacionModelo();

	    if (o!=null){
		    publicaciones=publicacionModelo.selectUltimasPublicaciones(pagina);
		}else if(c!=null){
			CategoriaModelo categoriaModelo=new CategoriaModelo();
			Categoria categoria=categoriaModelo.selectCatConPubli(c,pagina);
			publicaciones=categoria.getPublicaciones();
		}else if(e!=null){
			EtiquetaModelo etiquetaModelo=new EtiquetaModelo();
			Etiqueta etiqueta=etiquetaModelo.selectEtiConPubli(e,pagina);
			publicaciones=etiqueta.getPublicaciones();
			
		}else if(b!=null){
	    	if (!b.equals(""))
				publicaciones=publicacionModelo.busquedaDePublicaciones(b,pagina);
		}else{
			MejorPublicacionModelo mejorPublicacionModelo=new MejorPublicacionModelo();
		    publicaciones=mejorPublicacionModelo.selectMejores(pagina);
		}
    
    
    %>
<!DOCTYPE html>
<html lang="en">

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
    <link href="css/style.css" rel="stylesheet">
    
    <script src="js/script.js"></script>

  </head>

  <body>
    <!-- Navigation -->
 <nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp" id="logo"><img src="./imgs/logo1.png" width="70px" /></a>
			</div>
			<ul class="nav navbar-nav">
			 <%if (o==null && c==null && e==null && b==null){%>
				<li class="active"><a href="index.jsp">Mejores</a></li>
				<li><a href="index.jsp?opcion=ultimos">Ultimos</a></li>
			 <%}else if(o!=null) {%>
			 	<li><a href="index.jsp">Mejores</a></li>
				<li class="active"><a href="index.jsp?opcion=ultimos">Ultimos</a></li>
			<%}else{%>
			 	<li><a href="index.jsp">Mejores</a></li>
				<li><a href="index.jsp?opcion=ultimos">Ultimos</a></li>
			<%}%>
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
						<li><a href="Administrador/gestor.jsp">Gestion</a></li>
					<% }%>
					<li><a href="PerfilUsuario?nombre=<%=usuario.getNombre()%>" >Ver perfil</a></li>
					<li><a href="logout.jsp">Cerrar Sesion</a></li>
					<li><a href="nueva_publicacion.jsp" ><span class="glyphicon glyphicon-plus"></span>Añadir publicacion</a></li>
				</ul>
				</li>
				<%
					
						} else {
							out.print(" <li><a href='loginForm.jsp'><span class='glyphicon glyphicon-user'></span> Iniciar Sesion</a></li>");
							out.print(" <li><a href='Administrador/crearUsuario.jsp'><span class='glyphicon glyphicon-user'></span> Registrarse</a></li>");
						}
				%>

			</ul>
		</div>
	</nav>

    <!-- Page Content -->
    <div class="container">

      <div class="row">

        <!-- Blog Entries Column -->
        <div class="col-md-8">

		<%
		if (publicaciones.isEmpty()){
			
			out.print("<h3 style='color: grey;'>Lo siento pero no hay publicaciones :'(</h3>");
		}
		Iterator<Publicacion> i=publicaciones.iterator();
    		while(i.hasNext()){
    			Publicacion publicacion=i.next();
		%>
          <!-- Blog Post -->
          <div class="card mb-4">
            
            <div class="card-body">
              <h2 class="card-title"><%=publicacion.getTitulo()%></h2>
              <div class="text-muted">
              Subido el <%=publicacion.getFecha_subida() %> por <a href="PerfilUsuario?nombre=<%=publicacion.getUsuario().getNombre()%>"><%=publicacion.getUsuario().getNombre() %></a>
            </div>
              <a href="publicacion.jsp?id=<%=publicacion.getId() %>">
              	<img class="card-img-top"  src="./imagenesDePublicaciones/<%=publicacion.getId() %>" alt="Card image cap" width="750px" onerror="this.src='./imagenesDePublicaciones/404meme.jpg';">
              	</a>
              <div class="opciones">
              <span style="color:green;" class="likes" ><%=publicacion.getVotosPositivos().size()%></span>
              
              <%
              VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
              
              if (usuario!=null){
            	  VotoPublicacion votoDeUsuario=votoPubliModelo.selectPorPubliUsuario(publicacion, usuario);
            	  if (votoDeUsuario!=null){
	            	  if (votoDeUsuario.isVoto()){
	            		  %>
	                		<button type="button" class="btn activo utilizable" id="like-<%=publicacion.getId() %>">
	                			<span class="glyphicon glyphicon-thumbs-up"></span>
	                		</button>
	                		<button type="button" class="btn utilizable" id="dislike-<%=publicacion.getId() %>">
	                			<span class="glyphicon glyphicon-thumbs-down"></span>
	                		</button>
	                	<%
	            		  
	            	  }else{
	            		  %>
	              		<button type="button" class="btn utilizable" id="like-<%=publicacion.getId() %>">
	              			<span class="glyphicon glyphicon-thumbs-up"></span>
	              		</button>
	              		<button type="button" class="btn activo utilizable" id="dislike-<%=publicacion.getId() %>">
	              			<span class="glyphicon glyphicon-thumbs-down"></span>
	              		</button>
	              	<%
	            	  }
            	  }else{
            		  %>
                		<button type="button" class="btn utilizable" id="like-<%=publicacion.getId() %>">
                			<span class="glyphicon glyphicon-thumbs-up"></span>
                		</button>
                		<button type="button" class="btn utilizable" id="dislike-<%=publicacion.getId() %>">
                			<span class="glyphicon glyphicon-thumbs-down"></span>
                		</button>
  	           	<%
            	  }
            	  
              }else{
              
              %>
              		<button type="button" class="btn" id="like-<%=publicacion.getId() %>">
              			<span class="glyphicon glyphicon-thumbs-up"></span>
              		</button>
              		<button type="button" class="btn" id="dislike-<%=publicacion.getId() %>">
              			<span class="glyphicon glyphicon-thumbs-down"></span>
              		</button>
	           	<%
	           	}
	           	%>
              	
              	
              	<span style="color:red;" class="dislikes"><%=publicacion.getVotosNegativos().size()%></span>
              	
              </div>
             <p class="card-text etiquetas" >
             <%
             	Iterator<Etiqueta> j=publicacion.getEtiquetas().iterator();
             	while (j.hasNext()){
             		Etiqueta etiqueta=j.next();
             	
             %>
              	<b>
              		<a href="?etiqueta=<%=etiqueta.getNombre()%>">#<%=etiqueta.getNombre()%></a>
              	</b> 
			<%
			}
			%>
			</p>
              
            </div>
            
          </div>
		<%
    		}
		%>


<%
	
	int anteriorPagina=0;
	int proximaPagina=2;
	if(paginaSTR!=null){
		anteriorPagina=pagina-1;
		proximaPagina=pagina+1;
	}

	String extrasLink="";
	if (o!=null){
		extrasLink="opcion="+o+"&&";
	}else if(c!=null){
		extrasLink="categoria="+c+"&&";
	}else if(e!=null){
		extrasLink="etiqueta="+e+"&&";
	}else if(b!=null){
		extrasLink="busqueda="+b+"&&";
	}

%>
          

          <!-- Pagination -->
          <ul class="pagination justify-content-center mb-4">
          <%
          	if(anteriorPagina==0){
		          %>
		          	<li class="page-item disabled">
		          	<a class="page-link" href="?<%=extrasLink%>">&larr; Nuevos </a>
		          <%
          	}else{
          		 %>
               	<li class="page-item">
               	<a class="page-link" href="?<%=extrasLink%>pagina=<%=anteriorPagina%>">&larr; Nuevos </a>
               <%
          	}
          %>
            </li>
            <li class="page-item">
              <a class="page-link" href="?<%=extrasLink%>pagina=<%=proximaPagina%>">Viejos &rarr;</a>
            </li>
          </ul>

        </div>

        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">

          <!-- Search Widget -->
          <div class="card my-4">
            <h5 class="card-header">Buscar</h5>
            <div class="card-body">
              <div class="input-group">
              <form method="get" action="index.jsp">
                <input type="text" class="form-control" name="busqueda">
                <span class="input-group-btn">
                  <input type="submit" class="btn btn-secondary" value="Buscar">
                </span>
               </form>
              </div>
            </div>
          </div>

          <!-- Categories Widget -->
          <div class="card my-4">
            <h5 class="card-header">Categorias</h5>
            <div class="card-body">
              <div class="list-group">
              	<%
              	CategoriaModelo categoriaModelo=new CategoriaModelo();
              	ArrayList<Categoria> categorias=categoriaModelo.selectAllConPublicaciones();
              	Iterator<Categoria> j =categorias.iterator();
              	while (j.hasNext()){
              		Categoria categoria=j.next();
              	%>
				  <a href="index.jsp?categoria=<%=categoria.getNombre() %>" class="list-group-item"><%=categoria.getNombre() %><span class="badge"><%=categoria.getPublicaciones().size() %></span></a>
				 <%} %>
				</div> 
            </div>
          </div>

          

        </div>

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Your Website 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>