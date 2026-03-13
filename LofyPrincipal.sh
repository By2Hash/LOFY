#!/bin/bash

while true; do
    OPCIONES=$(whiptail --title "LOFY - Sistema de Gestión" --menu "Selecciona una opción" 15 60 4 \
    "1" "Ingresar Albums" \
    "2" "Ver Albums" \
    "3" "Salir" 3>&1 1>&2 2>&3)

    # Si el usuario presiona "Cancel" o Esc, la variable queda vacía. Salimos.
    if [ -z "$OPCIONES" ]; then
        exit 0
    fi

    case $OPCIONES in
        1) 
            if [ -f ./IngresarDatos.sh ]; then
                source ./IngresarDatos.sh
            else
                whiptail --msgbox "Error: IngresarDatos.sh no encontrado." 8 45
            fi
            ;;
        2)
            if [ -f ./VerDatos.sh ]; then
                source ./VerDatos.sh
            else
                whiptail --msgbox "Error: VerDatos.sh no encontrado." 8 45
            fi
            ;;
        3)
            exit 0
            ;;
    esac
done