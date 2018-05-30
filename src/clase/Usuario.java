package clase;

import java.util.ArrayList;

public class Usuario {
	
	private String nombre;
	private String password;
	private String imagenPerfil;
	private String email;
	private String rol;
	
	private ArrayList <Publicacion> imagenes;
	
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getRol() {
		return rol;
	}
	public void setRol(String rol) {
		this.rol = rol;
	}

	public ArrayList<Publicacion> getImagenes() {
		return imagenes;
	}
	public void setImagenes(ArrayList<Publicacion> imagenes) {
		this.imagenes = imagenes;
	}
	public String getImagenPerfil() {
		return imagenPerfil;
	}
	public void setImagenPerfil(String imagenPerfil) {
		this.imagenPerfil = imagenPerfil;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	
	
	
	
}
