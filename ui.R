# Create Ui part of Shiny Application
shinyUI(
        pageWithSidebar(
                headerPanel("Heart Disease Prediction"),
                
                sidebarPanel(
                        tags$b("Introduction"),
                        tags$br(),
                        tags$p("Heart Disease Prediction is a Shiny application developed as part of the course project of Coursera Developing Data Products course. It's function is to predict the risk factor of having a heart disease"),
                        tags$br(),
                        tags$b("User Inputs"),
                        tags$br(),
                        tags$li("Input Age, Blood Pressure (mm Hg), Total Cholesterol (mg/dl) and Heart Rate at each corresponding textbox"),
                        tags$li("Select gender (Male or Female) by clicking the correct radio button"),
                        tags$li("Choose the display of the Normal Range of Blood Pressure, the Normal Range of Total Cholesterol and/or the Normal Range of Heart Rate by checking each matching checkbox"),
                        tags$br(),
                        tags$b("Application Outputs"),
                        tags$br(),
                        tags$li("Display the parameters that the user input"),
                        tags$li("Present the calculated predication value"),
                        tags$li("Display the Normal Range of Blood Pressure, the Normal Range of Total Cholesterol and/or the Normal Range of Heart Rate based on use's selection"),
                        tags$br(),
                        tags$b("Data Source"),
                        tags$br(),
                        tags$li("Heart Disease Predication is developed based on the [heart disease cleveland database on UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data) The database contains 303 observations and 14 variables. To simplify the user input process, only 6 variables (Age, Gender, Blood Pressure, Total Cholesterol, Heart Rate and Predication Value) were selected to develop this application."),
                        tags$br(),
                        tags$b("Data Training and Testing"),
                        tags$br(),
                        tags$li("80% of the observations are assigned as the training set and the remaining 20% are assigned as the testing set. The model is trained using random forest with cross validation. The predication accuracy is evaluated using the testing dataset."),
                        tags$br(),
                        numericInput('Age', 'Age', 20, min = 10, max = 150, step = 1),
                        radioButtons('Gender', 'Gender', c("Male"=1, "Female"=0)),
                        numericInput('Blood_Pressure', 'Blood Pressure (mm Hg)', 100, min=60, max=250, step=5),
                        numericInput('Cholesterol','Total Cholesterol (mg/dl)', 200, min = 100, max=300, step=5),
                        numericInput('Heart_Rate', 'Heart Rate', 100, min=80, max=200, step=1),
                        
                        checkboxInput("Details1", "Display Normal Range of Blood Pressure (Top Number)", FALSE),
                        checkboxInput("Details2", "Display Normal Range of Total Cholesterol", FALSE),
                        checkboxInput("Details3", "Display Normal Range of Heart Rate", FALSE),
                        submitButton('Submit')
                ),
                
                mainPanel(
                        h3('Result of Prediction'),
                        h4('You entered Age'),
                        verbatimTextOutput('inputValue1'),
                        h4('You entered Gender'),
                        verbatimTextOutput('inputValue2'),
                        h4('You entered Blood Pressure'),
                        verbatimTextOutput('inputValue3'),
                        h4('You entered Total Cholesterol'),
                        verbatimTextOutput('inputValue4'),
                        h4('You entered Heart Rate'),
                        verbatimTextOutput('inputValue5'),
                        h4('Your Risk Factor of Heart Diseast Is'),
                        verbatimTextOutput("Prediction"),
                        verbatimTextOutput("Details1"),
                        verbatimTextOutput("Details2"),
                        verbatimTextOutput("Details3")
                )
        )       
)

