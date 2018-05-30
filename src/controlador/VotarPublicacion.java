package controlador;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clase.Publicacion;
import clase.Usuario;
import clase.VotoPublicacion;
import modelo.PublicacionModelo;
import modelo.VotoPubliModelo;

public class VotarPublicacion extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response){
		
		HttpSession session=request.getSession();
		Object u=session.getAttribute("iniciado");
		if (u!=null){
			Usuario usuario=(Usuario) u;
			
			
			String idPublicacion=request.getParameter("idPublicacion");
			String voto=request.getParameter("voto");
			
			PublicacionModelo publicacionModelo=new PublicacionModelo();
			Publicacion publicacion=publicacionModelo.select(idPublicacion);
			
			
			VotoPublicacion votoPublicacion=new VotoPublicacion();
			votoPublicacion.setUsuario(usuario);
			votoPublicacion.setPublicacion(publicacion);
			
			if (voto.equals("like")){
				votoPublicacion.setVoto(true);
			}else{
				votoPublicacion.setVoto(false);
			}
			
			
			VotoPubliModelo votoPubliModelo =new VotoPubliModelo();
			VotoPublicacion votoPublicacionVieja =votoPubliModelo.selectPorPubliUsuario(publicacion,usuario);
			
			if (votoPublicacionVieja==null){
				votoPubliModelo.insert(votoPublicacion);
			}else if((votoPublicacionVieja.isVoto() && !votoPublicacion.isVoto()) || (!votoPublicacionVieja.isVoto() && votoPublicacion.isVoto())){
				votoPubliModelo.update(votoPublicacion);
			}
		}
	}	
	

		
		
	

}
