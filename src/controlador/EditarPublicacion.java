package controlador;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clase.Etiqueta;
import clase.Publicacion;
import clase.Usuario;
import modelo.PublicacionModelo;
import modelo.UsuarioModelo;

public class EditarPublicacion extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String idPubli = request.getParameter("id");
		PublicacionModelo publicacionModelo = new PublicacionModelo();
		Publicacion publicacion = publicacionModelo.select(idPubli);

		Usuario usuario = (Usuario) session.getAttribute("iniciado");
		if (usuario != null && usuario.getNombre().equals(publicacion.getUsuario().getNombre())) {

			request.setAttribute("publicacion", publicacion);

			// guardar en variable para enviar

			// redirijir a la pagina con la variable creada
			RequestDispatcher rd = request.getRequestDispatcher("editar_publicacion.jsp");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}

	}
}
