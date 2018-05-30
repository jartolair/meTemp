$(document).ready(function(){

   $(".opciones > .utilizable").click(function(){
	   var padre=$(this).parent(".opciones");
	   	// ver si esta activo
	   	var classes=$(this).attr('class');
	   	if (classes.indexOf("activo") < 0){
	   		
	   		
	   		//buscar si el otro esta activo
	   		var otroBotonClass=padre.children("button").not(this).attr('class');
	   		
	   					    
		    //sacar informacion
		    var info=$(this).attr('id');
		    
		    var voto=info.substr(0, info.indexOf('-')); 
		    var idPublicacion=info.substr(info.indexOf('-')+1); 

		    
		    //seleccionar los numeros like y dislike
		    var numLikes=padre.children(".likes");
		    var numDislikes=padre.children(".dislikes");

		    
		    //calcular y poner numeros
		    		//like sin anterior voto
		    if ((voto=="like") && (otroBotonClass.indexOf("activo") < 0)){
		    	numLikes.text(parseInt(numLikes.text()) + 1);
		    	
		    		//cambio de dislike a like
		    }else if ((voto=="like") && (otroBotonClass.indexOf("activo") >= 0)){
		    	numLikes.text(parseInt(numLikes.text()) + 1);
		    	numDislikes.text(parseInt(numDislikes.text()) - 1);
		    	
		    	//dislike sin anterior voto
		    }else if ((voto=="dislike") && (otroBotonClass.indexOf("activo") < 0)){
		    	numDislikes.text(parseInt(numDislikes.text()) + 1);
		    	
		    	
		    	//cambio de like a dislike
		    }else if ((voto=="dislike") && (otroBotonClass.indexOf("activo") >= 0)){
		    	numDislikes.text(parseInt(numDislikes.text()) + 1);
		    	numLikes.text(parseInt(numLikes.text()) - 1);
		    }
		    
		    
		  //cambiar classes
		   	$(".opciones > button").attr('class', 'btn');
		    $(this).attr('class', 'btn activo');
		    
		    //enviar info
		    $.post( "VotarPublicacion",  { voto: voto, idPublicacion:idPublicacion });
	   	}

   });
   
   

}); 