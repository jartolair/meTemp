package controlador;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clase.Categoria;
import clase.CategoriaPublicacion;
import clase.Etiqueta;
import clase.EtiquetaPublicacion;
import clase.Publicacion;
import clase.Usuario;
import modelo.CatPubliModelo;
import modelo.CategoriaModelo;
import modelo.EtiPubliModelo;
import modelo.EtiquetaModelo;
import modelo.PublicacionModelo;

public class CambiarPublicacion extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String idPubli = request.getParameter("id");
		String tituloNuevo=request.getParameter("tituloNuevo");
		String categoriasNuevas[]=request.getParameterValues("categoriasNuevas");
		String etiquetasPara =request.getParameter("etiquetas");
		
		
		CategoriaModelo categoriaModelo= new CategoriaModelo();
		EtiquetaModelo etiquetaModelo= new EtiquetaModelo();
		
		PublicacionModelo publicacionModelo = new PublicacionModelo();
		Publicacion publicacion = publicacionModelo.select(idPubli);

		Usuario usuario = (Usuario) session.getAttribute("iniciado");
		

		if (usuario != null ) {
			
			if(usuario.getNombre().equals(publicacion.getUsuario().getNombre())){
			publicacion.setTitulo(tituloNuevo);	
			publicacionModelo.updateTitulo(publicacion);
			
			
			CatPubliModelo catPubliModelo=new CatPubliModelo();
			CategoriaPublicacion categoriaPublicacion =new CategoriaPublicacion();
			
			EtiPubliModelo etiPubliModelo= new EtiPubliModelo();
			EtiquetaPublicacion etiquetaPublicacion= new EtiquetaPublicacion();
			
			
			etiPubliModelo.deletePorPublicacion(publicacion);
			

			//Actualizar etiquetas
			ArrayList<Etiqueta> etiquetas=new ArrayList();
			
			buscarEtiquetas(etiquetasPara, etiquetas);

			   publicacion.setEtiquetas(etiquetas);
			   etiquetaPublicacion.setPublicacion(publicacion);
			   
			   
			   
			   for(Etiqueta etiqueta: etiquetas){
				   etiquetaPublicacion.setEtiqueta(etiqueta);
				   etiPubliModelo.insert(etiquetaPublicacion); 
			   }
			   
			 
			
			catPubliModelo.deletePorPublicacion(publicacion);
			categoriaPublicacion.setPublicacion(publicacion);
			
			
			for (int i =0; i<categoriasNuevas.length;i++){
				
				Categoria cat = categoriaModelo.selectPorNombre(categoriasNuevas[i]);
				categoriaPublicacion.setCategoria(cat);
				catPubliModelo.insert(categoriaPublicacion);

			}
			
			
			

			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}

	}
	
	}

	private void buscarEtiquetas(String etiquetasPara, ArrayList<Etiqueta> etiquetas) {
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
		
	}
	
	
}
