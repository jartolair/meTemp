package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.mindrot.jbcrypt.BCrypt;

import clase.Usuario;

public class UsuarioModelo {
	Connection conexion = ConectorDB.conectarDB();

	public ArrayList<Usuario> selectAll() {

		ArrayList<Usuario> usuarios = new ArrayList();

		try {
			PreparedStatement pst;
			pst = conexion.prepareStatement("SELECT * from usuarios");
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {

				Usuario usuario = new Usuario();

				usuario.setNombre(rs.getString("nombre"));
				usuario.setPassword(rs.getString("contrasena"));
				usuario.setRol(rs.getString("rol"));
				usuario.setEmail(rs.getString("email"));
				usuario.setImagenPerfil(rs.getString("imagen"));

				usuarios.add(usuario);

			}
			return usuarios;

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return null;

	}

	public Usuario select(String nombre) {

		try {
			PreparedStatement pst = conexion.prepareStatement("select * from usuarios where nombre =?");
			pst.setString(1, nombre);
			ResultSet rs = pst.executeQuery();

			Usuario usuario = null;
			while (rs.next()) {

				usuario = new Usuario();

				usuario.setNombre(rs.getString("nombre"));
				usuario.setPassword(rs.getString("contrasena"));
				usuario.setImagenPerfil(rs.getString("imagen"));
				usuario.setEmail(rs.getString("email"));
				usuario.setRol(rs.getString("rol"));

			}

			return usuario;

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return null;

	}

	public Usuario selectPorEmail(String email) {

		try {
			PreparedStatement pst = conexion.prepareStatement("select * from usuarios where email =?");
			pst.setString(1, email);
			ResultSet rs = pst.executeQuery();

			Usuario usuario = null;
			while (rs.next()) {

				usuario = new Usuario();

				usuario.setNombre(rs.getString("nombre"));
				usuario.setPassword(rs.getString("contrasena"));
				usuario.setImagenPerfil(rs.getString("imagen"));
				usuario.setEmail(rs.getString("email"));
				usuario.setRol(rs.getString("rol"));

			}

			return usuario;

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return null;

	}

	public void insert(Usuario usuario) {
		try {
			PreparedStatement pst = conexion
					.prepareStatement("INSERT INTO usuarios (nombre,contrasena,imagen,rol, email) values(?,?,?,?,?)");
			pst.setString(1, usuario.getNombre());
			pst.setString(2, usuario.getPassword());
			pst.setString(3, usuario.getImagenPerfil());
			pst.setString(4, usuario.getRol());
			pst.setString(5, usuario.getEmail());

			pst.execute();

		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	public void delete(String nombre) {

		try {
			PreparedStatement pst = conexion.prepareStatement("DELETE from usuarios WHERE nombre=?");
			pst.setString(1, nombre);
			pst.execute();

		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

	public void update(Usuario usuario) {
		try {
			PreparedStatement pst = conexion
					.prepareStatement("UPDATE usuarios SET contrasena=?,imagen=?, rol=?, email=? WHERE nombre=?");

			pst.setString(1, usuario.getPassword());
			pst.setString(2, usuario.getImagenPerfil());
			pst.setString(3, usuario.getRol());
			pst.setString(4, usuario.getNombre());
			pst.setString(5, usuario.getEmail());

			pst.execute();

		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	public Usuario selectPorNombre(String nombre) {

		try {
			PreparedStatement pst = conexion.prepareStatement("select * from usuarios where nombre =?");
			pst.setString(1, nombre);
			ResultSet rs = pst.executeQuery();

			Usuario usuario = null;
			while (rs.next()) {

				usuario = new Usuario();

				usuario.setNombre(rs.getString("nombre"));
				usuario.setPassword(rs.getString("contrasena"));
				usuario.setImagenPerfil(rs.getString("imagen"));
				usuario.setEmail(rs.getString("email"));
				usuario.setRol(rs.getString("rol"));

			}

			return usuario;

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return null;
	}
	
	public Usuario get(String nombre, String password){
		Connection conexion=ConectorDB.conectarDB();
		PreparedStatement pst;
		try {
			pst = conexion.prepareStatement("select * from usuarios where nombre=?");
		
			pst.setString(1, nombre);
			
			ResultSet rs= pst.executeQuery();
			
			while(rs.next()){
				if (BCrypt.checkpw(password,rs.getString("contrasena"))){
					Usuario usuario= new Usuario();
					usuario.setNombre(rs.getString("nombre"));
					usuario.setEmail(rs.getString("email"));
					usuario.setImagenPerfil(rs.getString("imagen"));
					usuario.setRol(rs.getString("rol"));
					
					return usuario;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
		
		
	}
	
}
