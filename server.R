
library(shiny)
library(e1071)
library(dplyr)

load("D:/1. Bioinformatica/2 cuatri/TFM/Resultados/bayes_model.RData")

oasis_cross_sectional <- 
    readr::read_csv("D:/1. Bioinformatica/2 cuatri/TFM/DATOS/oasis_cross-sectional.csv")
oasis_cross_sectional_narm=na.omit(oasis_cross_sectional)
datos_oasis <- oasis_cross_sectional_narm %>% select(-ID, -Hand, -CDR, -Delay)
datos_oasis$`M/F`=factor(datos_oasis$`M/F`,levels=c("F", "M"),
                                 labels=c(0,1))

datos_oasis = rename(datos_oasis, c("Sex"=`M/F`))

shinyServer(function(input, output) {
    
    output$single_slider_io = renderPrint({
        data_guest <- data.frame(Age=as.numeric(input$slider_input),
                         Sex=as.numeric(input$select_input),
                         Educ=as.numeric(input$select_input_2), 
                         SES=as.numeric(input$select_input_3), 
                         MMSE=as.numeric(input$slider_input_2), 
                         eTIV=as.numeric(input$slider_input_3), 
                         nWBV=as.numeric(input$slider_input_4), 
                         ASF=as.numeric(input$slider_input_5))
        data1=rbind(data_guest, datos_oasis)
        data1$Sex=as.numeric(data1$Sex)
        data2=as.data.frame(scale(data1))
        data_guest=data2[1,]
        predictions=predict(bayes_model, data_guest, type="raw")
        prob_dementia=predictions[2]
        prob_dementia
        if(prob_dementia<0.2) {
            print(paste0("La probabilidad de padecer demencia en fase leve es baja: ", 
                      prob_dementia))
        } else if(prob_dementia<0.7) {
            print(paste0("La probabilidad de padecer demencia en fase leve es moderada: ", 
                         prob_dementia))
        } else { 
            print(paste0("La probabilidad de padecer demencia en fase leve es alta: ", 
                         prob_dementia))
        }
        

    })
    
})
