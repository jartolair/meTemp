<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  <%
Object u = session.getAttribute("iniciado");
if (u != null) {
	response.sendRedirect("index.jsp");	
	
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<style>
.panel-heading {
    padding: 5px 15px;
}

.panel-footer {
	padding: 1px 15px;
	color: #A0A0A0;
}

.profile-img {
	width: 96px;
	height: 96px;
	margin: 0 auto 10px;
	display: block;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	border-radius: 50%;
}</style>
<body>

<%  String idPub= request.getParameter("idPub");


	if(request.getParameter("error")!=null&& request.getParameter("error").equals("true")){
		out.print("	<div class='alert alert-danger'> <span class='glyphicon glyphicon-exclamation-sign'></span> <span class='sr-only'>Error:</span> Usuario o contraseña incorrectos </div>");
		
	}

%>


<!------ Include the above in your HEAD tag ---------->

    <div class="container" style="margin-top:40px">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Inicia Sesion para continuar</strong>
					</div>
					<div class="panel-body">
						<form role="form" action="login.jsp?idPub=<%=idPub%>" method="POST">
							<fieldset>
								<div class="row">
									<div class="center-block">
										<img class="profile-img"
											src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120" alt="">
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-10  col-md-offset-1 ">
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-user"></i>
												</span> 
												<input class="form-control" placeholder="Usuario" id="usuario" name="usuario" type="text" >
											</div>
										</div>
										<div class="form-group" >
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-lock"></i>
												</span>
												<input class="form-control" placeholder="Contraseña" id="password" name="password" type="password" value="">
											</div>
										</div>
										<div class="form-group">
											<input type="submit"  class="btn btn-lg btn-primary btn-block" name="entrar" value="Iniciar Sesión">
										</div>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
					<div class="panel-footer ">
						¿No tienes una cuenta? <a href="Administrador/crearUsuario.jsp" onClick=""> Registrate aqui! </a>
					</div>
                </div>
			</div>
		</div>
	</div>
</body>
</html>