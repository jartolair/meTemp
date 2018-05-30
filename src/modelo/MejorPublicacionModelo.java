package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import clase.Etiqueta;
import clase.MejorPublicacion;
import clase.Publicacion;

public class MejorPublicacionModelo {
	Connection conexion=ConectorDB.conectarDB();
	public ArrayList<Publicacion> selectMejores(int pagina){
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();

		try {
			pst = conexion.prepareStatement("Select * from mejores_publicaciones order by fecha_llegada desc LIMIT ?,5");
			pst.setInt(1, (pagina-1)*5);
			ResultSet rs=pst.executeQuery();
			PublicacionModelo publicacionModelo=new PublicacionModelo();
			
			while(rs.next()){
				Publicacion publicacion=new Publicacion();
				publicacion=publicacionModelo.select(rs.getString("publicacion"));
				
				publicaciones.add(publicacion);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return publicaciones;
		
	}
	
	public void insert(Publicacion publicacion){
		try {
			PreparedStatement pst=conexion.prepareStatement("insert into mejores_publicaciones(publicacion,fecha_llegada) values(?,now())");
			pst.setString(1,publicacion.getId());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
