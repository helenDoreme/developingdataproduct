# Load the required library
library(caret)
library(randomForest)

# Download the data file from heart disease Cleveland database on UCI Machine Learning Repository
#download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data", "processed.cleveland.data")

# Read the data
data<-read.csv("processed.cleveland.data")

# Extract the valuables used for developing shiny application
subsetData<-data[,c(1, 2, 4, 5, 8, 14)]

# Add the column names to each selected column. The column names are stored in a separate file on UCI ML Repo
colnames(subsetData)<- c("Age", "Gender", "Blood_Pressure", "Cholesterol", "Heart_Rate", "Prediction")

# Show the head of the final dataset 
head(subsetData)

# Assign the Gender as a factor variable
subsetData$Gender <- factor(subsetData$Gender)

# Partition the dataset into training and testing sets
inData<-createDataPartition(y=subsetData$Prediction, p=0.8, list=FALSE)
training<-subsetData[inData,]
testing<-subsetData[-inData,]

# Train the training set using random forest method with cross validation
modelrf<- train(Prediction ~ ., method ="rf", data=training, trControl=trainControl(method="cv"), number=5)

# Predict the testing set with the trained random forest model
#predrf<- predict(modelrf, testing)

# Check the accuracy of the prediction 
#confusionMatrix(round(predrf,0), testing$Prediction)

# Use the trained random forest model to predict the heart disease risk value based on the user's input values on the Shiny application
heartDiseastRisk<-function(age, gender, blood, chol, hr) {
        predict(modelrf, data.frame(Age=c(age), Gender=c(gender), Blood_Pressure=c(blood), Cholesterol=c(chol), Heart_Rate=c(hr)))
} 


# Create the Server part of Shiny application 
shinyServer(
        function(input, output) {
                gender <- reactive({
                        switch(input$Gender,
                               "1" = "Male",
                               "0" = "Female")
                })
                reactive({print(input$Gender)})
                output$inputValue1 <- renderPrint({input$Age})
                output$inputValue2 <- renderPrint({gender()})
                output$inputValue3 <- renderPrint({input$Blood_Pressure})
                output$inputValue4 <- renderPrint({input$Cholesterol})
                output$inputValue5 <- renderPrint({input$Heart_Rate})
                output$Prediction <- renderPrint(
                 {heartDiseastRisk(input$Age, input$Gender, input$Blood_Pressure, input$Cholesterol, input$Heart_Rate)})
                
                details1 <- reactive({if (input$Details1) 
                        "Normal Range of Blood Pressure (Top Number): Normal: below 120; Prehypertension: between 120 and 139; hypertension: greater than 140" 
                        else ""})
                output$Details1 <- renderPrint({details1()})
                 
                details2 <- reactive({if (input$Details2) 
                        "Normal Range of Total Cholesterol: less than 200 mg/dl" 
                        else ""})
                output$Details2 <- renderPrint({details2()})

                details3 <- reactive({if (input$Details3) 
                        "Normal Range of Heart Rate: 60 to 100 beats a minute" 
                        else ""})
                output$Details3 <- renderPrint({details3()})
                
        }
        
)