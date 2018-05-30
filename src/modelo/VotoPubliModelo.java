package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import clase.Categoria;
import clase.Publicacion;
import clase.Usuario;
import clase.VotoPublicacion;

public class VotoPubliModelo{
	Connection conexion=ConectorDB.conectarDB();
	public ArrayList<VotoPublicacion> selectPorPublicacion(String idPublicacion) {
		// TODO Auto-generated method stub
		
		PreparedStatement pst;
		ArrayList<VotoPublicacion> votos=new ArrayList<>();
		try {
			pst = conexion.prepareStatement("Select * from votar_p where publicacion=?");
			pst.setString(1, idPublicacion);
			ResultSet rs=pst.executeQuery();
			VotoPubliModelo votoPubliModelo=new VotoPubliModelo();
			UsuarioModelo usuarioModelo = new UsuarioModelo();
			while(rs.next()){
				VotoPublicacion votoPublicacion=new VotoPublicacion();
				votoPublicacion.setUsuario(usuarioModelo.select(rs.getString("usuario")));
				votoPublicacion.setVoto(rs.getBoolean("voto"));
				votoPublicacion.setFecha(rs.getDate("fecha"));
				votos.add(votoPublicacion);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return votos;
	}
	public VotoPublicacion selectPorPubliUsuario(Publicacion publicacion, Usuario usuario) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		VotoPublicacion votoPublicacion=null;
		try {
			pst = conexion.prepareStatement("Select * from votar_p where publicacion=? and usuario=?");
			pst.setString(1, publicacion.getId());
			pst.setString(2, usuario.getNombre());
			ResultSet rs=pst.executeQuery();
			while(rs.next()){
				votoPublicacion=new VotoPublicacion();
				votoPublicacion.setPublicacion(publicacion);
				votoPublicacion.setUsuario(usuario);
				votoPublicacion.setVoto(rs.getBoolean("voto"));
				votoPublicacion.setFecha(rs.getDate("fecha"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return votoPublicacion;
	}
	public void insert(VotoPublicacion votoPublicacion) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		try {
			pst = conexion.prepareStatement("Insert into votar_p(usuario,publicacion,voto,fecha) values(?,?,?,now())");
			pst.setString(1, votoPublicacion.getUsuario().getNombre());
			pst.setString(2, votoPublicacion.getPublicacion().getId());
			pst.setBoolean(3, votoPublicacion.isVoto());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void update(VotoPublicacion votoPublicacion) {
		// TODO Auto-generated method stub
		PreparedStatement pst;
		try {
			pst = conexion.prepareStatement("update votar_p set voto=?, fecha=now() where usuario=? and publicacion=?");
			pst.setBoolean(1, votoPublicacion.isVoto());
			
			pst.setString(2, votoPublicacion.getUsuario().getNombre());
			pst.setString(3, votoPublicacion.getPublicacion().getId());
			
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
