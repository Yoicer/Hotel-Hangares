<?php 

   class vistasModelo{
        protected function obtener_vistas_modelo($vistas){
         $listaBlanca=["login","home","rooms","reservation","contact"];
         if (in_array($vistas , $listaBlanca)) {
            if (is_file("./vistas/contenido/".$vistas."-view.php")) {
               $contenido="./vistas/contenido/".$vistas."-view.php";
            }else{
               $contenido="home";
            }
         }elseif ($vistas=="home") {
            $contenido="home";
         }elseif ($vistas == "home") {
            $contenido="home";
         }else{
            $contenido="home";
         }
         return $contenido;   
        }

   }