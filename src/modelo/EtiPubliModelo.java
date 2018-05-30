package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import clase.Categoria;
import clase.Etiqueta;
import clase.EtiquetaPublicacion;
import clase.Publicacion;

public class EtiPubliModelo{
	Connection conexion=ConectorDB.conectarDB();
	public ArrayList<Etiqueta> selectEtiPorPublicacion(String idPublicacion) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		ArrayList<Etiqueta> etiquetas=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from tiene_e where publicacion=?");
			pst.setString(1, idPublicacion);
			ResultSet rs=pst.executeQuery();
			EtiquetaModelo etiquetaModelo=new EtiquetaModelo();
			
			while(rs.next()){
				Etiqueta etiqueta=etiquetaModelo.select(rs.getInt("etiqueta"));
				etiquetas.add(etiqueta);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return etiquetas;

	}
	
	
	public ArrayList<Publicacion> selectPubliPorEti(int idEtiqueta,int pagina){
		PreparedStatement pst;
		ArrayList<Publicacion> publicaciones=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from tiene_e e, publicaciones p where publicacion=p.id and etiqueta=? ORDER BY p.fecha_subida desc LIMIT ?,5");
			pst.setInt(1, idEtiqueta);
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


	public void insert(EtiquetaPublicacion etiquetaPublicacion) {
		// TODO Auto-generated method stub
		try {
			
			PreparedStatement pst=conexion.prepareStatement("INSERT INTO tiene_e(publicacion,etiqueta) values(?,?)");
			pst.setString(1, etiquetaPublicacion.getPublicacion().getId());
			pst.setInt(2, etiquetaPublicacion.getEtiqueta().getId());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void deletePorPublicacion (Publicacion publicacion){
		
		try{
			PreparedStatement pst= conexion.prepareStatement("DELETE FROM tiene_e WHERE publicacion=?");
			pst.setString(1, publicacion.getId());
			pst.execute();
			
		}
		 catch (SQLException e) {
		
				e.printStackTrace();
			}
	}

}
