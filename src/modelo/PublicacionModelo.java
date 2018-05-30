package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import clase.Categoria;
import clase.CategoriaPublicacion;
import clase.Etiqueta;
import clase.EtiquetaPublicacion;
import clase.MejorPublicacion;
import clase.Publicacion;
import clase.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PublicacionModelo{
	Connection conexion=ConectorDB.conectarDB();
	public ArrayList<Publicacion> selectUltimasPublicaciones(int pagina){
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		CatPubliModelo catPubliModelo=new CatPubliModelo();
		EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		
		try {
			pst = conexion.prepareStatement("SELECT * FROM publicaciones ORDER BY fecha_subida desc, id desc LIMIT ?,5");
			pst.setInt(1, (pagina-1)*5);
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				Publicacion publicacion=new Publicacion();
				
				publicacion.setId(rs.getString("id"));
				publicacion.setTitulo(rs.getString("titulo"));
				publicacion.setFecha_subida(rs.getDate("fecha_subida"));
				publicacion.setUsuario(usuarioModelo.select(rs.getString("autor")));
				publicacion.setCategorias(catPubliModelo.selectCatPorPublicacion(rs.getString("id")));
				publicacion.setEtiquetas(etiPubliModelo.selectEtiPorPublicacion(rs.getString("id")));
				publicacion.setVotos(votoPubliModelo.selectPorPublicacion(rs.getString("id")));
				
				publicaciones.add(publicacion);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return publicaciones;
	}
	
	
	public Publicacion select(String id){
		Publicacion publicacion=null;
		
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		CatPubliModelo catPubliModelo=new CatPubliModelo();
		EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		
		try {
			PreparedStatement pst = conexion.prepareStatement("SELECT * FROM publicaciones where id=?");
			pst.setString(1, id);
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				publicacion=new Publicacion();
				
				publicacion.setId(rs.getString("id"));
				publicacion.setTitulo(rs.getString("titulo"));
				publicacion.setFecha_subida(rs.getDate("fecha_subida"));
				publicacion.setUsuario(usuarioModelo.select(rs.getString("autor")));
				publicacion.setCategorias(catPubliModelo.selectCatPorPublicacion(rs.getString("id")));
				publicacion.setEtiquetas(etiPubliModelo.selectEtiPorPublicacion(rs.getString("id")));
				publicacion.setVotos(votoPubliModelo.selectPorPublicacion(rs.getString("id")));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return publicacion;
	}
	
	public ArrayList<Publicacion> buscarNuevosMejoresPubli(int dias){
		/*
		 * select de los publicaciones, que todabia no estan en mejores
		 * 		y que en la fecha limite(dias introducidos) conseguieron mas votos. solo seleccionar 10	
		 */
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		try {
			PreparedStatement pst=conexion.prepareStatement("select id from publicaciones p left join votar_p v on p.id=v.publicacion where p.id not in(select publicacion from mejores_publicaciones) and v.fecha between (current_date() - interval ? day) and current_date group by p.id order by (sum(v.voto)/count(v.voto)) desc limit 5");
			pst.setInt(1, dias);
			ResultSet rs= pst.executeQuery();
			PublicacionModelo publicacionModelo=new PublicacionModelo();
			while(rs.next()){
				Publicacion publicacion=new Publicacion();
				publicacion=publicacionModelo.select(rs.getString("id"));
				
				publicaciones.add(publicacion);
			}
		} catch (SQLException e) { 
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return publicaciones;		
	}
	
	public Publicacion selectUltimaPublicacion(){
		Publicacion publicacion=null;
		
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		CatPubliModelo catPubliModelo=new CatPubliModelo();
		EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		
		try {
			PreparedStatement pst = conexion.prepareStatement("SELECT * FROM publicaciones order by fecha_subida desc limit 1");
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				publicacion=new Publicacion();
				
				publicacion.setId(rs.getString("id"));
				publicacion.setTitulo(rs.getString("titulo"));
				publicacion.setFecha_subida(rs.getDate("fecha_subida"));
				publicacion.setUsuario(usuarioModelo.select(rs.getString("autor")));
				publicacion.setCategorias(catPubliModelo.selectCatPorPublicacion(rs.getString("id")));
				publicacion.setEtiquetas(etiPubliModelo.selectEtiPorPublicacion(rs.getString("id")));
				publicacion.setVotos(votoPubliModelo.selectPorPublicacion(rs.getString("id")));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return publicacion;
	}
	
	public void insertarCompleto(Publicacion publicacion){
		try {
			PreparedStatement pst=conexion.prepareStatement("INSERT INTO publicaciones(id,titulo,fecha_subida,autor) values(?,?,NOW(),?)");
			pst.setString(1, publicacion.getId());
			pst.setString(2, publicacion.getTitulo());
			pst.setString(3, publicacion.getUsuario().getNombre());
			pst.execute();
			
			// categorias
			CatPubliModelo catPubliModelo=new CatPubliModelo();
			CategoriaPublicacion categoriaPublicacion =new CategoriaPublicacion();
			categoriaPublicacion.setPublicacion(publicacion);
			Iterator<Categoria> i=publicacion.getCategorias().iterator();
			
			while(i.hasNext()){
				categoriaPublicacion.setCategoria(i.next());
				catPubliModelo.insert(categoriaPublicacion);
			}
			
			//etiquetas
			EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
			EtiquetaPublicacion etiquetaPublicacion=new EtiquetaPublicacion();
			etiquetaPublicacion.setPublicacion(publicacion);
			
			Iterator<Etiqueta> j=publicacion.getEtiquetas().iterator();
			
			while(j.hasNext()){
				etiquetaPublicacion.setEtiqueta(j.next());
				etiPubliModelo.insert(etiquetaPublicacion);
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<Publicacion> busquedaDePublicaciones(String busqueda,int pagina){
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		CatPubliModelo catPubliModelo=new CatPubliModelo();
		EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		
		busqueda="%"+busqueda+"%";
		PreparedStatement pst;
		try {
			pst = conexion.prepareStatement("SELECT * FROM publicaciones where titulo like ? ORDER BY fecha_subida desc, id desc LIMIT ?,5 ");
			pst.setString(1, busqueda);
			pst.setInt(2, (pagina-1)*5); 
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				Publicacion publicacion=new Publicacion();
				
				publicacion.setId(rs.getString("id"));
				publicacion.setTitulo(rs.getString("titulo"));
				publicacion.setFecha_subida(rs.getDate("fecha_subida"));
				publicacion.setUsuario(usuarioModelo.select(rs.getString("autor")));
				publicacion.setCategorias(catPubliModelo.selectCatPorPublicacion(rs.getString("id")));
				publicacion.setEtiquetas(etiPubliModelo.selectEtiPorPublicacion(rs.getString("id")));
				publicacion.setVotos(votoPubliModelo.selectPorPublicacion(rs.getString("id")));
				
				publicaciones.add(publicacion);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return publicaciones;
		
		
	}


	public ArrayList<Publicacion> selectPorAutor(Usuario autor, int pagina) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		
		UsuarioModelo usuarioModelo=new UsuarioModelo();
		CatPubliModelo catPubliModelo=new CatPubliModelo();
		EtiPubliModelo etiPubliModelo=new EtiPubliModelo();
		VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
		
		try {
			pst = conexion.prepareStatement("SELECT * FROM publicaciones where autor=? ORDER BY fecha_subida desc, id desc LIMIT ?,5");
			pst.setString(1, autor.getNombre());
			pst.setInt(2, (pagina-1)*5);
			ResultSet rs=pst.executeQuery();
			while (rs.next()){
				Publicacion publicacion=new Publicacion();
				
				publicacion.setId(rs.getString("id"));
				publicacion.setTitulo(rs.getString("titulo"));
				publicacion.setFecha_subida(rs.getDate("fecha_subida"));
				publicacion.setUsuario(autor);
				publicacion.setCategorias(catPubliModelo.selectCatPorPublicacion(rs.getString("id")));
				publicacion.setEtiquetas(etiPubliModelo.selectEtiPorPublicacion(rs.getString("id")));
				publicacion.setVotos(votoPubliModelo.selectPorPublicacion(rs.getString("id")));
				
				publicaciones.add(publicacion);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return publicaciones;
	}
	
	public void updateTitulo (Publicacion publicacion){
		
		try {
			PreparedStatement pst = conexion.prepareStatement("UPDATE publicaciones SET titulo=? WHERE id=?");
			pst.setString(1, publicacion.getTitulo());
			pst.setString(2, publicacion.getId());
			pst.execute();
		
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	
	}
	public void delete(Publicacion publicacion){
		
		try {
			PreparedStatement pst = conexion.prepareStatement("DELETE from publicaciones where id=?");
			pst.setString(1, publicacion.getId());
			pst.execute();
		
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
	}
	
	
}
