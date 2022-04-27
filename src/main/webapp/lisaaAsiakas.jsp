<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">

<title>Uusi asiakas</title>
</head>
<body>
<form id="tiedot">
 <table>
  <thead>
   <tr>
   	<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
    <th>Etunimi</th>
    <th>Sukunimi</th>
    <th>Puhelin</th>
    <th>Sähköposti</th>
	<th></th>
	
    </tr>
   </thead>
   <tbody>	
   
    <tr>
      <td><input type="text" name="etuNimi" id="etuNimi"></td>
      <td><input type="text" name="sukuNimi" id="sukuNimi"></td>
      <td><input type="text" name="puhelin" id="puhelin"></td>
      <td><input type="text" name="sposti" id="sposti"></td>
      <td><input type="submit" id="tallenna" value="Lisää"></td>
</tr>
</tbody>
</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function() {
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	$("#tiedot").validate({
		rules: {
			etuNimi: {
				required: true,
				minlength: 2
			},
				sukuNimi: {
					required: true,
					minlength: 2
				},
					puhelin: {
						required: true,
						minlength: 6,
						number: true
					},
						sposti: {
							required: true,
							minlength: 5
						}
		},
		messages: {
			etuNimi: {
				required: "Tarvittava tieto",
				minlength: "Liian lyhyt"
				},
			sukuNimi: {
				required: "Tarvittava tieto",
				minlength: "Liian lyhyt"
				},
			puhelin: {
					required: "Tarvittava tieto",
					number: "Ei kelpaa",
					minlength: "Liian lyhyt"
				},
			sposti: {
					required: "Tarvittava tieto",
					minlength: "Liian lyhyt"
				}
		
		},
		
		submitHandler: function(form) {
			lisaaTiedot();
		}
					
	});
});

function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
	      	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
	      }else if(result.response==1){			
	      	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
	      	$("#etuNimi", "#sukuNimi","#puhelin", "#sposti").val("");
			}
	  }});	
	}
	</script>
	</html>
