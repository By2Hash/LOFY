#!/bin/bash

# 1. El usuario elige la categoría
SUB_OPCION=$(whiptail --title "LOFY - Ingresar Datos" --menu "Selecciona el estado del álbum:" 15 60 4 \
"1" "Albums Terminados" \
"2" "Albums En Progreso" \
"3" "Albums Pendientes" \
"4" "Volver" 3>&1 1>&2 2>&3)

# 2. Según la categoría, pedimos el nombre y guardamos
case $SUB_OPCION in 
    1)
        # Pedimos el nombre del álbum
        NOMBRE=$(whiptail --title "Albums Terminados" --inputbox "Escribe el nombre del álbum:" 8 45 3>&1 1>&2 2>&3)
        
        # Si el usuario no presionó Cancelar (el nombre no está vacío)
        if [ ! -z "$NOMBRE" ]; then
            echo "TERMINADO: $NOMBRE" >> lista_albums.txt
            whiptail --msgbox "Álbum '$NOMBRE' guardado con éxito." 8 45
        fi
        ;;
    2)
        NOMBRE=$(whiptail --title "Albums En Progreso" --inputbox "Escribe el nombre del álbum:" 8 45 3>&1 1>&2 2>&3)
        if [ ! -z "$NOMBRE" ]; then
            echo "EN PROGRESO: $NOMBRE" >> lista_albums.txt
            whiptail --msgbox "Álbum '$NOMBRE' guardado." 8 45
        fi
        ;;
    3)
        NOMBRE=$(whiptail --title "Albums Pendientes" --inputbox "Escribe el nombre del álbum:" 8 45 3>&1 1>&2 2>&3)
        if [ ! -z "$NOMBRE" ]; then
            echo "PENDIENTE: $NOMBRE" >> lista_albums.txt
            whiptail --msgbox "Álbum '$NOMBRE' guardado." 8 45
        fi
        ;;
    4|"")
        return 0
        ;;
esac