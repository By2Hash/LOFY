#!/bin/bash

# Generamos el menú secundario
SUB_OPCION=$(whiptail --title "LOFY - Ingresar Datos" --menu "Selecciona el estado del álbum:" 15 60 4 \
"1" "Albums Terminados" \
"2" "Albums En Progreso" \
"3" "Albums Pendientes" \
"4" "Volver" 3>&1 1>&2 2>&3)

case $SUB_OPCION in 
    1)
        whiptail --msgbox "Has seleccionado: Albums Terminados" 8 45
        # Aquí iría tu código para manejar álbumes terminados
        ;;
    2)
        whiptail --msgbox "Has seleccionado: Albums En Progreso" 8 45
        # Aquí iría tu código para álbumes en progreso
        ;;
    3)
        whiptail --msgbox "Has seleccionado: Albums Pendientes" 8 45
        # Aquí iría tu código para álbumes pendientes
        ;;
    4|"")
        # Si elige Volver o presiona Escape, simplemente termina este script
        # y regresa al bucle del menú principal.
        return 0 
        ;;
esac