library(shiny)
library(DBI)
library(RPostgres)
library(RSQLite)


# Define UI
ui <- fluidPage(
  sliderInput("nrows", "Enter the number of rows to display:",
              min = 1,
              max = 519,
              value = 15),
  tableOutput("tbl")
)

# Define server logic 
server <- function(input, output) {
  output$tbl <- renderTable({
    
    # postgres
    postgres_conn <- dbConnect(RPostgres::Postgres(),dbname = 'BigPictureEconomics', 
                               #  host = '127.0.0.1',
                               port = 5432, 
                               user = 'postgres',
                               password = 'Khannn2499') # Type in your database server password
    postgres_sql="SELECT * FROM gdp_data "
    
    conn=postgres_conn
    str_sql = postgres_sql
    
    
    on.exit(dbDisconnect(conn), add = TRUE)
    dbGetQuery(conn, paste0(str_sql, " LIMIT ", input$nrows, ";"))
  })
}

