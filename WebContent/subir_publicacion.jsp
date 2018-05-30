
<%@page import="clase.Usuario"%>
<%@page import="modelo.UsuarioModelo"%>
<%@page import="clase.Etiqueta"%>
<%@page import="modelo.EtiquetaModelo"%>
<%@page import="clase.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.CategoriaModelo"%>
<%@page import="clase.Publicacion"%>
<%@page import="modelo.PublicacionModelo"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>

<%@page import="java.util.List"%>

<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemFactory"%>
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
</head>
<body>
<%
final String carpeta="D:/proyectos de java/Memes/WebContent/imagenesDePublicaciones/";


FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);


//obtener datos
String id=null;
String titulo=null;
ArrayList<Categoria> categorias=new ArrayList();
String etiquetasPara=null;
CategoriaModelo categoriaModelo= new CategoriaModelo();


PublicacionModelo publicacionModelo=new PublicacionModelo();
//req es la HttpServletRequest que recibimos del formulario.
//Los items obtenidos serán cada uno de los campos del formulario,
//tanto campos normales como ficheros subidos.
//RequestContext req=(RequestContext) request;
List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));

//Se recorren todos los items, que son de tipo FileItem
for (Object item : items) {
	FileItem uploaded = (FileItem) item;
	
	// Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
	// subido donde nos interese
	if (!uploaded.isFormField()) {
	   // No es campo de formulario, guardamos el fichero en algún sitio
	   
		String formatoDeArchivo=uploaded.getName();
		
		//cortar direccion hasta sacar formato
		
		formatoDeArchivo=formatoDeArchivo.substring(formatoDeArchivo.lastIndexOf("."));
		
		//buscar nuevo nombre, ultima publicacion+1
		
		Publicacion ultimaPublicacion=publicacionModelo.selectUltimaPublicacion();
		
		//quitar la parte de fromato y sacar id
		String ultimaId=ultimaPublicacion.getId();
		int nuevaId=Integer.parseInt(ultimaId.substring(0,ultimaId.lastIndexOf(".")))+1;
		
		id=(nuevaId+formatoDeArchivo);
		
	   
	   // guardar la publicacion en la base de datos
	   
	   

	   
	 //poner nuevo nombre y subirlo
		
	   File fichero = new File(carpeta, (nuevaId)+formatoDeArchivo);
	   uploaded.write(fichero);
	} else {
	   // es un campo de formulario, podemos obtener clave y valor
	   
	   //cojer los valores que no son imagenes
	   String key = uploaded.getFieldName();
	   
	   
	   if (key.equals("titulo")){
		   titulo=uploaded.getString();
		   
	   }else if(key.equals("etiquetas")){
		   etiquetasPara=uploaded.getString();
		   
		   
	   }else{
		   //ir añadiendo uno por uno al array
			String categoriaTemp=uploaded.getString();
		   // ver si existe
		   
			Categoria categoria =categoriaModelo.selectPorNombre(categoriaTemp);
			if(categoria!=null)
				categorias.add(categoria);
		   
	   }
	   

	   
	   
	   
	   
	}

	   
	   
	   
}
	
	
	
	
	

	
	   
ArrayList<Etiqueta> etiquetas=new ArrayList();
	   //buscar etiquetas
	   if(etiquetasPara!=null){
		   String[] etiquetas1=etiquetasPara.split(", ");
		   EtiquetaModelo etiquetaModelo=new EtiquetaModelo();
		   
		   Etiqueta etiqueta;
			
			for(int i=0;i<etiquetas1.length;i++){
				etiqueta =etiquetaModelo.selectPorNombre(etiquetas1[i]);
				if(etiqueta==null){
					etiqueta= new Etiqueta();
					etiqueta.setNombre(etiquetas1[i]);
					etiquetaModelo.insert(etiqueta);
					etiqueta =etiquetaModelo.selectPorNombre(etiquetas1[i]);
					
				}
				etiquetas.add(etiqueta);
			}
	   }
	   
	   
	   
	   
	   if (id!=null && titulo!=null && usuario!=null){
	   // crear publicacion
	   Publicacion publicacion =new Publicacion();
	   publicacion.setId(id);
	   publicacion.setTitulo(titulo);
	   publicacion.setUsuario(usuario);
	   publicacion.setCategorias(categorias);
	   publicacion.setEtiquetas(etiquetas);
	   
	   
	   publicacionModelo.insertarCompleto(publicacion);
	   
	   
	   
	   
	   
	   
	   %>
	   <h3>Publicacion subida</h3>
	   <a href="index.jsp">Volver</a>
	   
	   <%
	   
	   }else{
		   %>
		   <h3>Falta algun dato</h3>
		   <a href="nueva_publicacion.jsp">Volver a intentar</a>
		   
		   <%
	   }
	   
	}else{
		response.sendRedirect("loginForm.jsp");
	}

      
      %>
      
      
      
</body>
</html>