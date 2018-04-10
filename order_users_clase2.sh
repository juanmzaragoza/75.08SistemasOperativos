## 
# Ejercicio
# ● En /etc/passwd se encuentra la informacion de todos los usuarios del sistema
# ● Cada línea del archivo se compone de: user:X:user_id:group_id:Nombre:home:shell
# ● Ejemplo de línea del /ect/passwd: lalujan:4Mcbn2/PcSwrI:528:501::/home/lalujan:/bin/bash
#
# Se desea listar los nombres e ids de todos los usuarios del sistema ordenados alfabéticamente por nombre
##

cut -f 1,3 -d ":" /etc/passwd | sort