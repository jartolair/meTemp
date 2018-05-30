package modelo;

import java.util.ArrayList;
import java.util.Iterator;

import clase.Categoria;
import clase.CategoriaPublicacion;
import clase.Publicacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CatPubliModelo{
	Connection conexion=ConectorDB.conectarDB();
	public ArrayList<Categoria> selectCatPorPublicacion(String idPublicacion){
		PreparedStatement pst;
		ArrayList<Categoria> categorias=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from esta_categorias where publicacion=?");
			pst.setString(1, idPublicacion);
			ResultSet rs=pst.executeQuery();
			CategoriaModelo categoriaModelo=new CategoriaModelo();
			
			while(rs.next()){
				Categoria categoria=categoriaModelo.select(rs.getInt("categoria"));
				categorias.add(categoria);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return categorias;
	}
	
	public ArrayList<Publicacion> selectPubliPorCat(int idCategoria, int pagina){
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from esta_categorias c, publicaciones p where publicacion=p.id and categoria=? ORDER BY fecha_subida desc LIMIT ?,5");
			pst.setInt(1, idCategoria);
			pst.setInt(2, (pagina-1)*5);
			ResultSet rs=pst.executeQuery();
			PublicacionModelo publicacionModelo=new PublicacionModelo();
			
			while(rs.next()){
				Publicacion publicacion=publicacionModelo.select(rs.getString("publicacion"));
				publicaciones.add(publicacion);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return publicaciones;
	}
	
	public ArrayList<Publicacion> selectPubliPorCat(int idCategoria){
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from esta_categorias where categoria=?");
			pst.setInt(1, idCategoria);
			ResultSet rs=pst.executeQuery();
			PublicacionModelo publicacionModelo=new PublicacionModelo();
			
			while(rs.next()){
				Publicacion publicacion=publicacionModelo.select(rs.getString("publicacion"));
				publicaciones.add(publicacion);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return publicaciones;
	}

	public void insert(CategoriaPublicacion categoriaPublicacion) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement pst=conexion.prepareStatement("INSERT INTO esta_categorias(publicacion,categoria) values(?,?)");
			pst.setString(1, categoriaPublicacion.getPublicacion().getId());
			pst.setInt(2, categoriaPublicacion.getCategoria().getId());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void deletePorPublicacion(Publicacion publicacion) {
		// TODO Auto-generated method stub
		try {
			PreparedStatement pst=conexion.prepareStatement("DELETE FROM esta_categorias where publicacion=?");
			pst.setString(1, publicacion.getId());
			pst.execute();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

	
	
	
	
}
