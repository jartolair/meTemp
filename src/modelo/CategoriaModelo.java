package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import clase.Categoria;

public class CategoriaModelo{
	Connection conexion=ConectorDB.conectarDB();
	public Categoria select(int id) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		Categoria categoria=null;
		try {
			pst = conexion.prepareStatement("Select * from categorias where id=?");
			pst.setInt(1, id);
			ResultSet rs=pst.executeQuery();
			
			while(rs.next()){
				categoria=new Categoria();
				categoria.setId(id);
				categoria.setNombre(rs.getString("nombre"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return categoria;

	}
	
	public ArrayList<Categoria> selectAll() {
		// TODO Auto-generated method stub
		ArrayList<Categoria> categorias=new ArrayList<>();
		PreparedStatement pst;
		Categoria categoria=null;
		try {
			pst = conexion.prepareStatement("Select * from categorias");
			ResultSet rs=pst.executeQuery();
			
			while(rs.next()){
				categoria=new Categoria();
				categoria.setId(rs.getInt("id"));
				categoria.setNombre(rs.getString("nombre"));
				
				categorias.add(categoria);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return categorias;

	}
	
	public Categoria selectCatConPubli(String nombre, int pagina) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		Categoria categoria=null;
		try {
			pst = conexion.prepareStatement("Select * from categorias where nombre=? ");
			pst.setString(1, nombre);

			ResultSet rs=pst.executeQuery();
			CatPubliModelo catPubliModelo=new CatPubliModelo();
			while(rs.next()){
				categoria=new Categoria();
				categoria.setId(rs.getInt("id"));
				categoria.setNombre(rs.getString("nombre"));
				categoria.setPublicaciones(catPubliModelo.selectPubliPorCat(rs.getInt("id"),pagina));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return categoria;

	}
	public ArrayList<Categoria> selectAllConPublicaciones() {
		// TODO Auto-generated method stub
		ArrayList<Categoria> categorias=new ArrayList<>();
		PreparedStatement pst;
		try {
			pst = conexion.prepareStatement("Select * from categorias order by nombre");
			ResultSet rs=pst.executeQuery();
			CatPubliModelo catPubliModelo=new CatPubliModelo();
			
			while(rs.next()){
				Categoria categoria=new Categoria();
				categoria.setId(rs.getInt("id"));
				categoria.setNombre(rs.getString("nombre"));
				categoria.setPublicaciones(catPubliModelo.selectPubliPorCat(rs.getInt("id")));
				
				categorias.add(categoria);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return categorias;

	}
	
	public ArrayList<Categoria> selectEstos(String[] categorias){
		ArrayList<Categoria> categoriasList=new ArrayList<>();
		
		
		for(int i=0;i<categorias.length;i++){
			Categoria categoria= new Categoria();
			categoria =this.selectPorNombre(categorias[i]);
			if(categoria!=null)
				categoriasList.add(categoria);
		}
		return categoriasList;
	}

	public Categoria selectPorNombre(String nombre) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		Categoria categoria=null;
		try {
			pst = conexion.prepareStatement("Select * from categorias where nombre=?");
			pst.setString(1, nombre);
			ResultSet rs=pst.executeQuery();
			
			while(rs.next()){
				categoria=new Categoria();
				categoria.setId(rs.getInt("id"));
				categoria.setNombre(rs.getString("nombre"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
		return categoria;

	}
}
