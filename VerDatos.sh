#!/bin/bash

if [ -f lista_albums.txt ]; then
    whiptail --title "Mis Álbumes" --textbox lista_albums.txt 15 60
else
    whiptail --msgbox "Aún no has ingresado ningún álbum." 8 45
fi

case $SUBOPCION in 
    1)
        # Mostramos el contenido completo del archivo txt
        whiptail --title "Lista de Álbumes" --textbox albums.txt 15 60
        ;;
    2)
        # Ejemplo rápido de filtrado usando grep
        CAT=$(whiptail --menu "Filtrar por:" 15 60 3 \
        "TERMINADO" "Solo completados" \
        "EN PROGRESO" "Solo en curso" \
        "PENDIENTE" "Solo pendientes" 3>&1 1>&2 2>&3)
        
        if [ ! -z "$CAT" ]; then
            # Filtramos el archivo y lo mandamos a un archivo temporal para mostrarlo
            grep "$CAT" albums.txt > temp.txt
            whiptail --title "Álbumes $CAT" --textbox temp.txt 15 60
            rm temp.txt
        fi
        ;;
    3|"")
        return 0
        ;;
esac