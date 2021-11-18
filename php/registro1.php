<<<<<<< HEAD
 <!DOCTYPE html>
<html lang="en">

<head>

    <title>Conexión a BDD</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
</head>


<body> 

<?php
//definimos las variables que tenemos en la tabla clientes de la base de datos y las que le corresponden en el formulario de registro, usamos el _POST para tomar los datos del registro.html.




    $email = $_POST["email"];
    $password = $_POST["password"];
    $nombre = $_POST["nombre"];
    $apellido = $_POST["apellido"];
    $provincia = $_POST["provincia"];
    $pais = $_POST["pais"];
    $fechaNacimiento = $_POST["fechaNacimiento"];



 //le indicamos que imprima por pantalla los datos ingresados.   

    print "<p>Su eMail es <strong>$email</strong>.</p>\n";
    print "\n";
    print "<p>Su clave es <strong>$password</strong>.</p>\n";
    print "\n";
    print "<p>Su nombre es <strong>$nombre</strong>.</p>\n";
    print "\n";
    print "<p>Su apellido es <strong>$apellido</strong>.</p>\n";
    print "\n";
    print "<p>Su provincia es <strong>$provincia</strong>.</p>\n";
    print "\n";
    print "<p>Su país es <strong>$pais</strong>.</p>\n";
    print "\n";
    print "<p>Su fecha de nacimiento es <strong>$fechaNacimiento</strong>.</p>\n";
    print "\n";


    // con el include, llamamos al archivo donde estan los datos de la base de datos.
    
    include("datosDB.php"); 

//definimos una variable con los datos que pedimos. con el INSERT TO, se agregan los datos a la tabla seleccionada
//con el VALUES declaramos los valores que serán insertados.

    $consulta = "INSERT INTO clientes (email, password, nombre, apellido, provincia, pais, idLocalidad, fechaNacimiento) 
                    VALUES ('$email','$password','$nombre','$apellido','$provincia','$pais', 1, '$fechaNacimiento')";


//la variable resultado nos responderá si se ha agregado o no el nuevo registro
    

    $resultado = mysqli_query($conector, $consulta);


    if ($resultado) {
        echo "Se ha creado un nuevo registro";
    } else {
        echo "Error: " . $consulta . "<br>" . mysqli_error($connection);
    }

  mysqli_close($conector);
?>