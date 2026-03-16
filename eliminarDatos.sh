#!/bin/bash

# 1. Verificar si hay datos
if [ ! -s lista_albums.txt ]; then
    whiptail --msgbox "No hay álbumes para eliminar." 8 45
    return 0
fi

# 2. Cargar los álbumes en un menú
OPCIONES_BORRADO=()
while IFS= read -r linea || [ -n "$linea" ]; do
    if [ ! -z "$linea" ]; then
        OPCIONES_BORRADO+=("$linea" "")
    fi
done < lista_albums.txt

# 3. Seleccionar cuál eliminar
ALBUM_A_ELIMINAR=$(whiptail --title "Eliminar Álbum" \
--menu "Selecciona el álbum que deseas borrar permanentemente:" 20 70 10 \
"${OPCIONES_BORRADO[@]}" 3>&1 1>&2 2>&3)

# Si cancela, salir
if [ -z "$ALBUM_A_ELIMINAR" ]; then
    return 0
fi

# 4. Confirmación de seguridad (¡Muy importante!)
if whiptail --title "Confirmar eliminación" \
--yesno "¿Estás seguro de que quieres eliminar:\n\n$ALBUM_A_ELIMINAR?" 10 60; then
    
    # 5. Borrar la línea exacta usando sed
    # La opción 'd' en sed significa 'delete'
    sed -i "s|^$ALBUM_A_ELIMINAR$||" lista_albums.txt  # Deja línea vacía
    sed -i '/^$/d' lista_albums.txt                    # Limpia líneas vacías

    whiptail --msgbox "El álbum ha sido eliminado correctamente." 8 45
else
    whiptail --msgbox "Operación cancelada." 8 45
fi