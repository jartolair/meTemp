package clase;

import java.util.Date;

public class VotoPublicacion {
	private Usuario usuario;
	private Publicacion publicacion;
	private boolean voto;
	private Date fecha;
	
	
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public Publicacion getPublicacion() {
		return publicacion;
	}
	public void setPublicacion(Publicacion publicacion) {
		this.publicacion = publicacion;
	}
	public boolean isVoto() {
		return voto;
	}
	public void setVoto(boolean voto) {
		this.voto = voto;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	
	
	
}
