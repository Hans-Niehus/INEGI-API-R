# Cargar paquetes

library(tidyverse)
library(scales)
library(plyr)
library(httr)
library(jsonlite)
library(rjson)

# Funcion INEGI API indicadores y estados variables

INEGI_API <- function(indicadores, indicadores_name = NA, estados, estados_name = NA, API_token){
  
  #Llamado al API
  url <- paste("https://www.inegi.org.mx/app/api/indicadores/desarrolladores/jsonxml/INDICATOR/",
               indicadores,"/es/",estados,"/false/BISE/2.0/",API_token,"?type=json",sep = "")
  respuesta<-GET(url)
  datosGenerales<-content(respuesta,"text")
  flujoDatos<-paste(datosGenerales,collapse = " ")
  
  #Obtención de la lista de observaciones 
  flujoDatos<-fromJSON(flujoDatos)
  flujoDatos<-flujoDatos $Series
  
  # Asignacion de nombres y organizacion de datos
  for (i in 1:length(flujoDatos)){
    obs <- flujoDatos[[i]] $OBSERVATIONS
    datos <- 0
    tiempo <- 0
    geo <- 0
    for (j in 1:length(obs)){
      datos[j] <- if (is.null(obs[[j]]$OBS_VALUE)) NA else obs[[j]]$OBS_VALUE
      tiempo[j] <- obs[[j]] $TIME_PERIOD
      geo[j] <- obs[[j]] $COBER_GEO
    }
    geo <- mapvalues(geo,strsplit(estados,split = ",")[[1]],estados_name)
    assign(indicadores_name[[i]],data.frame(year = as.integer(tiempo),
                                            datos = as.numeric(datos),geo = geo) %>% 
             pivot_wider(names_from = geo,values_from = datos), envir = .GlobalEnv)
  }
}
