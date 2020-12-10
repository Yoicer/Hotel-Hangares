<?php  
require_once "./nucleo/configGeneral.php";
  require_once "./controladores/vistasControlador.php";

  $plantilla= new vistasControlador();
  $plantilla->getPlantilla_Controlador();