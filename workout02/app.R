#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(
          titlePanel("Investment Profit app"),
          
          fluidRow(
            column(4,
                   
                     sliderInput("initial_amount",
                                 "Initial Amount",
                                 min = 1,
                                 max = 100000,
                                 step= 10000,
                                 pre = "$", sep = ",",
                                 value = 1000
                                 ),
                     sliderInput('annual_contrib',
                                 'Annual Contribution',
                                 min=0,
                                 max=50000,
                                 pre='$',sep=',',
                                 value=2000)
            ),
            column(4,
                   sliderInput('return_rate','
                    Return Rate (in%)',
                               min=0,max=100,
                               step=2,value=5),
                   sliderInput('growth_rate','Growth Rate (in%)',
                               min=0,max=100,step=2,value=2)
            ),
            column(4,
                   sliderInput('year',
                  'Years',
                               min=0,max=50,
                               step=1,value=10),
                   selectInput('facet','Facet',
                               c('No','Yes'))
            ),
            column(12,textOutput(outputId = "title"
                                )),
            column(12,plotOutput("plot")),
            column(12,textOutput(outputId='table')),
            column(12,tableOutput('balances'))
            
          
            )
)


server <- function(input, output) {
  
  #' @title future value you receive
  #' @description calculate the future value based on time and annual return and present value
  #' @param amount(numeric) present value amount
  #' @param rate(numeric) annual rate of returnn
  #' @param years(numeric) in years
  #' @return fv(numeric)future values
  future_value <- function(amount,rate,years){
    if(!is.numeric(amount)){
      stop("amount must be numeric")
    }else if (!is.numeric(rate)){
      stop("rate must be numeric")
    }else if (!is.numeric(years)){
      stop("years must be numeric")
    }else{
      fv = amount * (1+rate) ^ years
      return(fv)
    }
  }
  
  #' @title future value of annuity
  #' @description calculate the future value of annuity based on contribution, annual rate and time
  #' @param contrib(numeric) contribution (how much deposited at the end of a year)
  #' @param rate(numeric) annual rate of return
  #' @param years(numeric) time in years
  #' @return fva(numeric) future value of annuity
  annuity <- function(contrib,rate,years){
    if(!is.numeric(contrib)){
      stop("contrib must be numeric")
    }else if (!is.numeric(rate)){
      stop("rate must be numeric")
    }else if (!is.numeric(years)){
      stop("years must be numeric")
    }else{
      fva  <- contrib * ( ( 1 + rate ) ^ years - 1) / rate
      return(fva)
    }
  }
  
  #' @title future value of growing annuity
  #' @description calculate the future growing value of annuity based on contribution, annual rate and time
  #' @param contrib(numeric) first contribution (how much deposited at the end of a year1)
  #' @param rate(numeric) annual rate of return
  #' @param growth(numeric) growth rate
  #' @param years(numeric) time in years
  #' @return fvga(numeric) future growing value of annuity
  growing_annuity <- function(contrib,rate,growth,years){
    if(!is.numeric(contrib)){
      stop("contrib must be numeric")
    }else if (!is.numeric(rate)){
      stop("rate must be numeric")
    }else if(!is.numeric(growth)){
      stop("growth must be numeric")
    }else if (!is.numeric(years)){
      stop("years must be numeric")
    }else{
      fvga  <- contrib * ( ( 1 + rate ) ^ years - ( 1 + growth ) ^ years ) / ( rate - growth)
      return(fvga)
    }
  }
  
  #TWO reactive dataframe mode_i and mode_i_full
  mode_i<- reactive( { for (i in 0:input$year){
    mode[i+1,'year'] <- i
    mode[i+1,'no_contrib'] <- future_value(amount=input$initial_amount,rate=input$return_rate/100,years=i)
    mode[i+1,'fixed_contrib']<-future_value(amount=input$initial_amount,rate=input$return_rate/100,years=i)+annuity(contrib=input$annual_contrib,rate=input$return_rate/100,years=i)
    mode[i+1,'growing_contrib']<-future_value(amount=input$initial_amount,rate=input$return_rate/100,years=i)+growing_annuity(contrib=input$annual_contrib,rate=input$return_rate/100,growth=input$growth_rate/100,years=i)
  }
    mode})
  
  mode_i_full <- reactive({ mode_1 <- data.frame()
  mode_1[1:(input$year+1),'value']<-mode_i()[1:(input$year+1),'no_contrib']
  mode_1[1:(input$year+1),'year']<-mode_i()[1:(input$year+1),'year']
  mode_1[1:(input$year+1),'variable']<-'no_contrib'
  mode_1[(input$year+2):(2*input$year+2),'year']<-mode_i()[1:(input$year+1),'year']
  mode_1[(input$year+2):(2*input$year+2),'value']<-mode_i()[1:(input$year+1),'fixed_contrib']
  mode_1[(input$year+2):(2*input$year+2),'variable']<-'fixed_contrib'
  mode_1[(2*input$year+3):(3*input$year+3),'year']<-mode_i()[1:(input$year+1),'year']
  mode_1[(2*input$year+3):(3*input$year+3),'value']<-mode_i()[1:(input$year+1),'growing_contrib']
  mode_1[(2*input$year+3):(3*input$year+3),'variable']<-'growing_contrib'
  mode_1[,'variable']<-factor(mode_1[,'variable'],levels=c('no_contrib','fixed_contrib','growing_contrib'),label=c('no_contrib','fixed_contrib','growing_contrib'))
  mode_1})
  
  #output a title
  output$title <-renderText("Timelines")
  
  #output a plot
  output$plot <- renderPlot({
    if (input$facet=='No'){
    ggplot(mode_i())+
      geom_line(aes(x=year,y=no_contrib,color='red'))+
      geom_point(aes(x=year,y=no_contrib,color='red'))+
      geom_line(aes(x=year,y=fixed_contrib,color='green'))+
      geom_point(aes(x=year,y=fixed_contrib,color='green'))+
      geom_line(aes(x=year,y=growing_contrib,color='blue'))+
      geom_point(aes(x=year,y=growing_contrib,color='blue'))+
      scale_color_identity(labels=factor(c('growing_contrib','fixed_contrib','no_contrib')
      ),guide='legend',name='mode')+
      theme(legend.text=element_text(size=rel(1.2)))+
      scale_x_continuous(breaks=seq(0.0,input$year,by=2.5),limits=c(0,input$year))+
      xlab("year")+
      ylab("value")+
      ggtitle("Three modes of investing")
    }else{
     
      ggplot(mode_i_full(),aes(color=variable))+
        geom_line(aes(x=year,y=value))+
        geom_point(aes(x=year,y=value),size=0.8)+
        geom_ribbon(data=mode_i_full(),aes(x=year,ymin=0,ymax=value,fill=variable),alpha=0.2)+
        facet_grid(.~variable)+
        # scale_color_identity(labels=c('growing_contrib','no_contrib','fixed_contrib'),guide='legend',name='mode')+
        theme(legend.text=element_text(size=rel(1.2)))+
        scale_x_continuous(breaks=seq(0,input$year,by=5),limits=c(0,input$year))+
        xlab("year")+
        ylab("value")+
        ggtitle("The modes of investing")
      
      }
    

  
  },height=400,width=900)
  
  #output a title
  output$table<-renderText('Balances')
  #output a table
  output$balances <- renderTable({
    mode_i()


  },height=200,width=900)
}

# Run the application 
shinyApp(ui = ui, server = server,options=list(height=1080))