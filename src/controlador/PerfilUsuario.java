package controlador;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clase.Publicacion;
import clase.Usuario;
import clase.VotoPublicacion;
import modelo.PublicacionModelo;
import modelo.UsuarioModelo;
import modelo.VotoPubliModelo;

public class PerfilUsuario extends HttpServlet{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		Usuario autor=usuarioModelo.select(request.getParameter("nombre"));
		
		
		String paginaSTR=request.getParameter("pagina");
		int pagina=1;
	    if(paginaSTR!=null){
	    	pagina=Integer.parseInt(paginaSTR);
	    	
	    }
	    
		PublicacionModelo publicacionModelo=new PublicacionModelo();
		ArrayList<Publicacion> publicaciones=publicacionModelo.selectPorAutor(autor,pagina); 
		request.setAttribute("publicaciones", publicaciones);
		request.setAttribute("pagina", pagina);
		request.setAttribute("autor", autor);
		
		
		HttpSession session=request.getSession();
		
		
		Usuario usuarioConectado=(Usuario) session.getAttribute("iniciado");
		boolean esEl=false;
		if (usuarioConectado!=null && autor.getNombre().equals(usuarioConectado.getNombre())){
			esEl=true;
		}
		request.setAttribute("esEl", esEl);
		
		request.setAttribute("usuarioConectado", usuarioConectado);
		//votos
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		ArrayList<VotoPublicacion> votoPublicacionesDeUsuario =new ArrayList<>();
		 if (usuarioConectado!=null){
			 for(Publicacion publicacion :publicaciones){
				 VotoPublicacion votoDeUsuario=votoPubliModelo.selectPorPubliUsuario(publicacion, usuarioConectado);
				 votoPublicacionesDeUsuario.add(votoDeUsuario);
				 
			 }
		 }
		 request.setAttribute("votoPublicaciones", votoPublicacionesDeUsuario);
		
		
		
		
		
		RequestDispatcher rd=request.getRequestDispatcher("perfil_usuario.jsp");
		rd.forward(request, response);
	}
}
