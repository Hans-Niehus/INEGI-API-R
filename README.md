# INEGI-API-R
Una funcion de R para hacer llamado a la API del INEGI en la cual la respuesta esté mejor estructurada en cuanto nombres de columnas y sea más fácil llamar a los estados y mediciones.
Esta función está basada en la llamada al API otorgada por el propio INEGI y ligeramente modificada. (https://www.inegi.org.mx/servicios/api_indicadores.html)

Revisar archivo API-INEGI.R

El repositorio contiene un ejemplo, llamando a los indicadores "Pob_total", "Pob_mujeres", "Pob_hombres", "Edad_mediana","Densidad" de los primeros 11 estados que aparecen en el archivo "catalogo-estados.csv".

En la variable API_token reemplaza los tres puntos por la clave otorgada por el INEGI para hacer llamadas a su API, puedes obtener tu token en: https://www.inegi.org.mx/app/desarrolladores/generatoken/Usuarios/token_Verify

