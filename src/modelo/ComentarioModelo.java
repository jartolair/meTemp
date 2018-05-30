package modelo;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import clase.Comentario;
import clase.Publicacion;
import clase.Usuario;

public class ComentarioModelo extends ConectorDB {

	public ArrayList<Comentario> selectAllPublicacion(String publicacion) {
		Connection conexion = ConectorDB.conectarDB();

		ArrayList<Comentario> comentarios = new ArrayList();

		try {
			PreparedStatement pst = conexion.prepareStatement(
					"SELECT * FROM comentarios left JOIN votar_c ON comentarios.id = votar_c.comentario where  publicacion=? order by fecha desc ");
			pst.setString(1, publicacion);
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				Comentario comentario = new Comentario();

				comentario.setId(rs.getInt("id"));
				UsuarioModelo um = new UsuarioModelo();
				comentario.setAutor(um.selectPorNombre(rs.getString("autor")));
				comentario.setTexto(rs.getString("texto"));
				comentario.setFecha(rs.getDate("fecha"));
				comentarios.add(comentario);

			}

			return comentarios;

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return null;

	}

	

	public void insert(Comentario comentario) {
		Connection conexion = ConectorDB.conectarDB();
		try {

			PreparedStatement pst = conexion
					.prepareStatement("INSERT INTO comentarios (autor,publicacion,texto, fecha) values(?,?,?,NOW())");

			pst.setString(1, comentario.getAutor().getNombre());
			pst.setString(2, comentario.getPublicacion().getId());
			pst.setString(3, comentario.getTexto());
		

			pst.execute();

		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	public java.sql.Date utilToSqlDate(java.util.Date date) {

		java.util.Date utilDate = date;
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		return sqlDate;

	}


}
