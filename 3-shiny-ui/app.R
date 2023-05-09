# Install database packages

# install.packages(c("shiny"))

library(shiny)
library(DBI)

# Define UI
ui <- fluidPage(
  tableOutput("tbl")
)

# Define server logic
server <- function(input, output) {
  output$tbl <- renderTable({
    # postgres
    postgres_conn <- dbConnect(RPostgres::Postgres(),dbname = 'BigPictureEconomics', 
                               host = '127.0.0.1', 
                               port = 5432, 
                               user = 'postgres',
                               password = 'Khannn2499')
    postgres_sql="SELECT gdp FROM gdp_data;"
    
    conn=postgres_conn
    str_sql = postgres_sql
    on.exit(dbDisconnect(conn), add = TRUE)
    
    dbGetQuery(conn, str_sql)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)