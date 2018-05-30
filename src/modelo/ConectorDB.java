package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectorDB {
	static Connection con;
	
	public static Connection conectarDB(){
		if (con==null){
			con=conectarseDB(Config.HOST,Config.BBDD, Config.USERNAME, Config.PASSWORD);
		}
		
		return con;
	}

	private static Connection conectarseDB(String host, String bbdd, String username, String password) {
		// TODO Auto-generated method stub
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://" + Config.HOST + "/" + Config.BBDD, Config.USERNAME, Config.PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}
