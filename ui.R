
library(shiny)

shinyUI(fluidPage(

    titlePanel("Introduce tus datos"),

    sidebarLayout(
        sidebarPanel(
            numericInput("slider_input",
                        "Edad",
                        min = 1,
                        max = 100,
                        value = 60),
            selectInput("select_input", label = "Sexo", 
                        choices = list("Hombre" = 1, "Mujer" = 2), 
                        selected = 1),
            selectInput("select_input_2", label = "Estatus socioeconomico", 
                        choices = list("bajo" = 1, "media bajo" = 2, 
                                       "medio" = 3, "media alto" = 4,
                                       "alto" = 5), 
                        selected = 1),
            selectInput("select_input_3", label = "Nivel de estudios", 
                        choices = list("ESO" = 1, "Bachiller" = 2, 
                                       "FP" = 3, "Grado" = 4, "Master" = 5), 
                        selected = 1),
            sliderInput("slider_input_2",
                        "Puntuacion en el MMSE",
                        min = 0,
                        max = 30,
                        value = 27, post = " puntos"),
            sliderInput("slider_input_3",
                        "eTIV",
                        min = 1000,
                        max = 2000,
                        value = 1500),
            sliderInput("slider_input_4",
                        "nWBV",
                        min = 0.00,
                        max = 1.00,
                        value = 0.50),
            sliderInput("slider_input_5",
                        "ASF",
                        min = 0.0,
                        max = 1.5,
                        value = 1, post = " puntos"),
        ),

        mainPanel(
            h1("Probabilidad de tener demencia"),
            textOutput("single_slider_io")
        )
    )
))
