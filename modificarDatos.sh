#!/bin/bash

# 1. Verificar existencia y contenido
if [ ! -s lista_albums.txt ]; then
    whiptail --msgbox "El archivo está vacío o no existe." 8 45
    return 0
fi

# 2. Crear la lista para el menú de forma segura
# Leemos el archivo y preparamos los argumentos para whiptail
OPCIONES_MENU=()
while IFS= read -r linea || [ -n "$linea" ]; do
    if [ ! -z "$linea" ]; then
        OPCIONES_MENU+=("$linea" "")
    fi
done < lista_albums.txt

# 3. Mostrar el menú
# IMPORTANTE: El 3>&1 1>&2 2>&3 debe estar al final
LINEA_SELECCIONADA=$(whiptail --title "Modificar Álbum" \
--menu "Elige el álbum a editar:" 20 70 10 \
"${OPCIONES_MENU[@]}" 3>&1 1>&2 2>&3)

# Si el usuario presiona Cancel o Esc, volvemos al principal sin cerrar
if [ -z "$LINEA_SELECCIONADA" ]; then
    return 0
fi

# 4. Elegir el nuevo estado
NUEVO_ESTADO=$(whiptail --title "Nuevo Estado" --menu "Cambiar estado a:" 15 60 3 \
"TERMINADO" "Álbum finalizado" \
"EN PROGRESO" "Trabajando en él" \
"PENDIENTE" "Aún en espera" 3>&1 1>&2 2>&3)

if [ -z "$NUEVO_ESTADO" ]; then
    return 0
fi

# 5. Procesar el cambio
# Extraemos el nombre después de los primeros dos puntos (:)
NOMBRE_LIMPIO=$(echo "$LINEA_SELECCIONADA" | cut -d':' -f2-)
NUEVA_LINEA="$NUEVO_ESTADO:$NOMBRE_LIMPIO"

# 6. Reemplazo seguro con sed
# Usamos una variable temporal para evitar errores de escritura
sed -i "s|^$LINEA_SELECCIONADA$|$NUEVA_LINEA|" lista_albums.txt

whiptail --msgbox "Álbum actualizado:\n$NUEVA_LINEA" 10 50