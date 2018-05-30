package clase;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

public class Publicacion {
	
	private String id;
	private String titulo;
	private Date fecha_subida;
	private Usuario usuario;
	
	private ArrayList <Categoria> categorias;
	private ArrayList <Etiqueta> etiquetas;
	private ArrayList<VotoPublicacion>  votos;
	
	
	public ArrayList<VotoPublicacion> getVotosPositivos(){
		ArrayList<VotoPublicacion> votosPositivos=new ArrayList<>();
		Iterator<VotoPublicacion> i=this.votos.iterator();
		while(i.hasNext()){
			VotoPublicacion voto=i.next();
			if (voto.isVoto()){
				
				votosPositivos.add(voto);
			}
		}
		
		return votosPositivos;
	}
	public ArrayList<VotoPublicacion> getVotosNegativos(){
		ArrayList<VotoPublicacion> votosNegativos=new ArrayList<>();
		Iterator<VotoPublicacion> i=this.votos.iterator();
		while(i.hasNext()){
			VotoPublicacion voto=i.next();
			if (!voto.isVoto()){
				votosNegativos.add(voto);
			}
		}
		return votosNegativos;
	}
	
	
	public ArrayList<VotoPublicacion> getVotos() {
		return votos;
	}
	public void setVotos(ArrayList<VotoPublicacion> votos) {
		this.votos = votos;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public Date getFecha_subida() {
		return fecha_subida;
	}
	public void setFecha_subida(Date fecha_subida) {
		this.fecha_subida = fecha_subida;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public ArrayList<Categoria> getCategorias() {
		return categorias;
	}
	public void setCategorias(ArrayList<Categoria> categorias) {
		this.categorias = categorias;
	}
	public ArrayList<Etiqueta> getEtiquetas() {
		return etiquetas;
	}
	public void setEtiquetas(ArrayList<Etiqueta> etiquetas) {
		this.etiquetas = etiquetas;
	}
	
	public boolean tieneCategoria(Categoria categoria){
		for (Categoria c:this.getCategorias()){
			if (c.getId()==categoria.getId()){
				return true;
			}
		}
		return false;
	}
	

}
