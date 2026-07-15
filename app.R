# ==========================================================
# DASHBOARD SHINY – PROJECTO PAM_VERDE
# ==========================================================

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(scales)
library(tidyr)
library(DT)

# ==========================================================
# INTERFACE DE USUÁRIO (UI)
# ==========================================================
ui <- navbarPage(
  title = "PAM_VERDE",
  
  # ------------------ Estilo e Tema ------------------
  header = tags$head(
    tags$style(HTML("

      .navbar {
        background-color: #9442d4;
      }

      .navbar-default .navbar-nav > li > a {
        color: white;
        font-weight: bold;
      }

      .navbar-default .navbar-brand {
        color: white;
        font-weight: bold;
      }

      .tab-content {
        background: #ffffff;
        padding: 15px;
        border-radius: 10px;
      }

      .nav-tabs > li > a {
        color: #6a1b9a;
        font-weight: bold;
      }

      .nav-tabs > li.active > a,
      .nav-tabs > li.active > a:focus,
      .nav-tabs > li.active > a:hover {
        background-color: #9442d4 !important;
        color: white !important;
      }
 /* =========================
       VALUE BOXES (KPIs)
    ========================== */
    .value-box-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      align-items: stretch;
      gap: 15px;
      margin-top: 10px;
    }

    .value-box {
      flex: 1 1 180px;
      max-width: 220px;
      min-width: 160px;

      padding: 16px;
      border-radius: 14px;
      color: white;
      font-weight: bold;
      text-align: center;

      box-shadow: 0 3px 10px rgba(0,0,0,0.15);
      transition: all 0.25s ease-in-out;
    }

    .value-box:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 18px rgba(0,0,0,0.25);
    }

    /* =========================
       CORES
    ========================== */
    .blue   { background-color: #6a1b9a; }
    .green  { background-color: #5cd6c7; }
    .orange { background-color: #f77333; }
    .yellow { background-color: #f9a825; color: #000; }
    .purple { background-color: #004c91; }

    /* =========================
       TEXTO
    ========================== */
    .value-title {
      font-size: 13px;
      margin-top: 6px;
      opacity: 0.95;
    }

    .value-number {
      font-size: 22px;
      font-weight: 800;
    }

    /* =========================
       RESPONSIVO
    ========================== */
    @media (max-width: 768px) {
      .value-box {
        flex: 1 1 45%;
      }
    }

    @media (max-width: 480px) {
      .value-box {
        flex: 1 1 100%;
      }
    }

    "))
  ),
  
  # ==========================================================
  # PÁGINA 1 - INDICADORES_CICLO3
  # ==========================================================
  tabPanel(
    tagList(icon("chart-line"), "Avaliação_Nampula_C3"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "filtro_ciclo",
          "Selecionar Ciclo:",
          choices = c("Todos", unique(Pam_Verde_Indicadores$Ciclo)),
          selected = "Todos"
        ),
        
        selectInput(
          "filtro_tipo_avaliacao",
          "Selecionar Tipo de Avaliação:",
          choices = c("Todos", unique(Pam_Verde_Indicadores$Tipo_Avaliacao)),
          selected = "Todos"
        )
      ),
      
      mainPanel(
        tabsetPanel(
          
          # =========================
          # ABA 1 - VISÃO GERAL
          # =========================
          tabPanel(
            "Visão Geral",
            
            fluidRow(uiOutput("kpi_boxes")),
            
            br(),
            fluidRow(
              column(
                6,
                div(
                  style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_estado_civil")
                ),
           
                plotlyOutput("grafico_participantes")
              ),
              column(
                6,
                div(
                  style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_idade")
                ),

                plotlyOutput("grafico_idade")
              )
            ),
            br(),
            fluidRow(
              column(
                6,
                div(
                  style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_ano")
                ),
    
                plotlyOutput("grafico_Ano_Negocio")
              ),
              column(
                6,
                div(
                  style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_setor")
                ),
               
                plotlyOutput("grafico_setor")
              ))
            ),
            
           
          
          # =========================
          # ABA 2
          # =========================
          tabPanel(
            "Desempenho das Empresas",
            
            fluidRow(uiOutput("kpi_boxes_financas")),
            
            fluidRow(
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_formalizacao")
                ),
                plotlyOutput("grafico_formalizacao")
              ),
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_servicos")
                ),
                plotlyOutput("grafico_servicos_financeiros")
              )
            ),
            br(),
            fluidRow(
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_salario")
                ),
                
                plotlyOutput("grafico_tira_salario")
              ),
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_clientes")
                ),
                
                plotlyOutput("grafico_clientes_regulares")
              )
            ),
            
            br(),
            
            fluidRow(
              tags$h4(""),
              column(6, plotlyOutput("tira")),
              tags$h4(""),
              column(6, plotlyOutput("grafico_salario"))
            )
          ),
          
          # =========================
          # ABA 3
          # =========================
          tabPanel(
            "Agência e Soft Skills",
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_decisoes")
                ),
                plotlyOutput("grafico_triang_empilhado")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_negociacao")
                ),
                plotlyOutput("grafico_negociacao_3meses")
              )
              
            ),
            
            br(),
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_agregado")
                ),
                plotlyOutput("grafico_agregado_familiar")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_clientes_neg")
                ),
                plotlyOutput("grafico_clientes")
              )
              
            ),
            
            br(),
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_funcionarios")
                ),
                plotlyOutput("grafico_funcionarios")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_canais")
                ),
                plotlyOutput("grafico_clientes_")
              )
              
            )
          ),
          # 
          # =========================
          # ABA 4
          # =========================
          tabPanel(
            "Habilidades & Processos",
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_uso_ia")
                ),
                plotlyOutput("grafico_uso_ia")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_separacao_contas")
                ),
                plotlyOutput("grafico_separacao_contas")
              )
              
            ),
            
            br(),
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_calculo_lucro")
                ),
                plotlyOutput("grafico_calcular_Lucro")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_control_dinheiro")
                ),
                plotlyOutput("grafico_control_dinheiro")
              )
              
            )
          ),
          
          # # =========================
          # # ABA 5
          # # =========================
          # tabPanel(
          #   "Posicionamento & Mercado",
          #   
          #   fluidRow(
          #     column(6, plotlyOutput("grafico_canais")),
          #     column(6, plotlyOutput("grafico_Parceria"))
          #   )
          # ),
          
          # =========================
          # ABA 6
          # =========================
          tabPanel(
            "Consciência de Gênero",
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_H_Financeiros")
                ),
                plotlyOutput("grafico_H_Financeiros")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_H_Serios")
                ),
                plotlyOutput("grafico_H_Serios")
              )
            ),
            
            
            br(),
            
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_H_Capazes")
                ),
                plotlyOutput("grafico_H_Capazes")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_Obrigacoes_Domesticas")
                ),
                plotlyOutput("grafico_Obrigacoes_Domesticas")
              )
            ),
            
            
            br(),
            
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_M_Gerir")
                ),
                plotlyOutput("grafico_M_Gerir")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_genero_extra")
                ),
                plotlyOutput("grafico_sa")
              )
            )
          ),
        
 
          # =========================
          # ABA 7
          # =========================
          tabPanel(
            "Consciência Ambiental",
            
            fluidRow(
              column(
                6,
                
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_Pegada")
                ),
                plotlyOutput("graficoPontuacao")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_conhecimento_ambiental")
                ),
                plotlyOutput("grafico_conhecimento_ambiental")
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_impacto_ambiental")
                ),
                plotlyOutput("grafico_impacto_ambiental_negocio")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_praticas_sustentaveis")
                ),
                plotlyOutput("grafico_praticas_sustentaveis"))
              )
            )
          )
          )
        )
      ),
  
  # ==========================================================
  # PÁGINA 2 - MONITORIA_CICLO3
  # ==========================================================
  tabPanel(
    tagList(icon("clipboard-check"), "Monitoria_Nampula_C3"),
    
    tabsetPanel(
      
      # =========================
      # ABA 1 - GERAL (COM SIDEBAR PRÓPRIO)
      # =========================
      tabPanel(
        "Resumo Geral",
        
        sidebarLayout(
          sidebarPanel(
            selectInput(
              "filtro_monitoria_geral",
              "Distrito:",
              choices = c("Todos", unique(PERFIL_PAM_VERDE_C3_2026$Cidade)),
              selected = "Todos"
            )
          ),
          
          mainPanel(
            br(),
            
            tags$h5(
              "Os gráficos abaixo apresentam uma visão geral do projeto, evidenciando o total de empreendedoras selecionadas e o seu estado no processo de formação. Considera-se Activas as empreendedoras que continuam na formação."
            ),
            
            fluidRow(
              column(6, plotOutput("grafico1")),
              column(6, plotOutput("grafico2"))
            )
          )
        )
      ),
      
      # =========================
      # ABA 2 - PRESENÇAS
      # =========================
      tabPanel(
        "Presenças",
        
        tabsetPanel(
          
          tabPanel(
            "Presenças Colectivas",
            
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  "filtro_monitoria_presencas",
                  "Selecione Cidade:",
                  choices = c("Todas", unique(Presencas_Colectivas$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "mentora_coletiva",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Presencas_Colectivas$Pesquisadores)),
                  selected = "Todas"
                )
              ),
              
              mainPanel(
                div(
                  class = "value-box-container",
                  uiOutput("total_participantes"),
                  uiOutput("total_sessoes"),
                  uiOutput("taxa_presenca")
                ),
                
                br(),
                
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_Pre_Col"),
                    plotlyOutput("grafico_sessoes_col")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_presencas_col")
              )
            )
          ),
          
          tabPanel(
            "Webinars",
            
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  "filtro_monitoria_webinar",
                  "Selecione Cidade:",
                  choices = c("Todas", unique(Webinars$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_webinar",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Webinars$Pesquisadores)),
                  selected = "Todas"
                )
              ),
              
              mainPanel(
                div(
                  class = "value-box-container",
                  uiOutput("total_participantes_web"),
                  uiOutput("total_sessoes_web"),
                  uiOutput("taxa_presenca_web")
                ),
                
                br(),
                
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_webinar"),
                    plotlyOutput("grafico_webinar")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_webinar")
              )
            )
          ),
          
          tabPanel(
            "Feiras",
            
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  "filtro_monitoria_feira",
                  "Selecione Cidade:",
                  choices = c("Todas", unique(Feiras$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_feira",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Feiras$Pesquisadores)),
                  selected = "Todas"
                )
              ),
              
              mainPanel(
                div(
                  class = "value-box-container",
                  uiOutput("total_participantes_feira"),
                  uiOutput("total_sessoes_feira"),
                  uiOutput("taxa_presenca_feira")
                ),
                
                br(),
                
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_feira"),
                    plotlyOutput("grafico_feira")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_feira")
              )
            )
          )
        )
      ),
      
      # =========================
      # ABA 3 - GRÁFICOS (SEM SIDEBAR OU FUTURO)
      # =========================
      tabPanel(
        "Dados Financeiros",
        icon = icon("hand-holding-usd"),
        
        sidebarLayout(
          sidebarPanel(
            selectInput(
              "Pesquisador",
              "Selecione o Pesquisador:",
              choices = c("Todos", unique(Financeiro_Report_Agregado$Nome_do_pesquisador)),
              selected = "Todos"
            ),
            
            selectInput(
              "Nome_Empreendedora",
              "Selecione a Empreendedora:",
              choices = c("Todas", unique(Financeiro_Report_Agregado$Nome_Empreendedora)),
              selected = "Todas"
            ),
            
            selectInput(
              "Mes",
              "Selecione o Mês:",
              choices = c("Todos", unique(Financeiro_Report_Agregado$Periodo)),
              selected = "Todos"
            )
          ),
          
          mainPanel(
            tabsetPanel(
              
              # ================= RESUMO =================
              tabPanel(
                "Resumo",
                
                div(
                  class = "value-box-container",
                  uiOutput("vb_emp"),
                  uiOutput("vb_lucro"),
                  uiOutput("vb_rendimento"),
                  uiOutput("vb_custos")
                ),
                
                br(),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    plotlyOutput("cidade_plot")
                  )
                )
              ),
              
              # ================= SEMANAL =================
              tabPanel(
                "Semanal",
                
                # div(
                #   class = "value-box-container",
                #   uiOutput("vb_crescimento_semana"),
                #   uiOutput("vb_aumento_lucro_semana"),
                #   uiOutput("vb_aumento_25_semana")
                # ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    plotlyOutput("grafico_financeiro")
                  )
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    plotlyOutput("grafico_barras_semanas")
                  )
                )
              ),
              
              # ================= MENSAL =================
              tabPanel(
                "Mensal",
                
                div(
                  class = "value-box-container",
                  uiOutput("vb_crescimento_mes"),
                  uiOutput("vb_aumento_lucro_mes"),
                  uiOutput("vb_aumento_25_mes")
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "Desempenho Mensal",
                    plotlyOutput("grafico_mensal", height = 450)
                  )
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    plotlyOutput("grafico_barras")
                  )
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    DTOutput("tabela_financeira")
                  )
                )
              )
            )
          )
        )
      )
    )
  ),
  
  # tabPanel(
  #   tagList(icon("chart-line"), "Avaliação_Beira_C1"),
  #   fluidPage(
  #     uiOutput("ad")
  #   )
  # ),
  # 
  # tabPanel(
  #   tagList(icon("clipboard-check"), "Monitoria_Beira_C1"),
  #   fluidPage(
  #     uiOutput("adrrr")
  #   )
  # ),
  
  tabPanel(
    "ADMIN",
    icon = icon("tools"),
    fluidPage(
      uiOutput("admin_ui")
    )
  ))

# ==========================================================
# SERVER
# ==========================================================

server <- function(input, output, session) {
  
  Pam_Verde_Indicadores_reactive <- reactive({
    Pam_Verde_Indicadores
  })


  dados_filtrados <- reactive({
    df <- Pam_Verde_Indicadores

    if (input$filtro_ciclo != "Todos") {
      df <- df %>% filter(Ciclo == input$filtro_ciclo)
    }
    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>% filter(Tipo_Avaliacao == input$filtro_tipo_avaliacao)
    }

    df
  })


  # ===============================================================
  # 3️⃣ KPI BOXES
  # ===============================================================
  output$kpi_boxes <- renderUI({
    df <- Pam_Verde_Indicadores_reactive()

    total_empresas <- n_distinct(df$Nome_Participante)

    if (input$filtro_ciclo == "Todos") {

      Baseline <- n_distinct(df$Nome_Participante[df$Tipo_Avaliacao == "Baseline"])
      Endline <- n_distinct(df$Nome_Participante[df$Tipo_Avaliacao == "Endline"])
      ciclo3 <- n_distinct(df$Nome_Participante[df$Ciclo == "Ciclo 3"])

      div(class = "value-box-container",
          div(class = "value-box blue",
              span(class = "value-number", total_empresas),
              span(class = "value-title", "Negócios apoiados no Total")),
          div(class = "value-box green",
              span(class = "value-number", Baseline),
              span(class = "value-title", "Negócios No Baseline")),
          div(class = "value-box orange",
              span(class = "value-number", Endline),
              span(class = "value-title", "Negócios Endline")),
          div(class = "value-box yellow",
              span(class = "value-number", ciclo3),
              span(class = "value-title", "Negócios apoiados no Ciclo 3"))
      )

    } else {

      total_filtrado <- n_distinct(df$Nome_Participante[df$Ciclo == input$filtro_ciclo])

      div(class = "value-box-container",
          div(class = "value-box blue",
              span(class = "value-number", total_filtrado),
              span(class = "value-title", paste("Negócios apoiados no", input$filtro_ciclo))
          )
      )
    }
  })
  # 
  # 
  # 
  # # =================================GRÁFICO 1 — PARTICIPANTES POR SEXO==============================
  # 
  # 
  dados_filtrados <- reactive({
    df <- Pam_Verde_Indicadores

    if (input$filtro_ciclo != "Todos") {
      df <- df %>% filter(Ciclo == input$filtro_ciclo)
    }

    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>% filter(Tipo_Avaliacao == input$filtro_tipo_avaliacao)
    }

    df <- df %>% distinct(Nome_Participante, .keep_all = TRUE)

    return(df)
  })

  output$grafico_participantes <- renderPlotly({
    
    df <- dados_filtrados()
    
    req("Estado_Civil" %in% colnames(df))
    req(nrow(df) > 0)
    
    df_resumo <- df %>%
      group_by(Estado_Civil) %>%
      summarise(Total = n(), .groups = 'drop') %>%
      mutate(
        Percentagem = round(Total / sum(Total) * 100, 1),
        label = paste0(Estado_Civil, ": ", Percentagem, "%")
      )
    
    plot_ly(
      data = df_resumo,
      labels = ~Estado_Civil,
      values = ~Total,
      type = 'pie',
      textinfo = 'percent',
      insidetextorientation = 'radial',
      hole = 0.55,
      marker = list(
        colors = c('#9442d4', '#ff7f0e', '#1f77b4', '#2ca02c', '#d62728'),
        line = list(color = '#FFFFFF', width = 2)
      )
    ) %>%
      layout(
        title = "",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_estado_civil <- renderUI({
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    resumo <- df %>%
      distinct(Nome_Participante, .keep_all = TRUE) %>%
      count(Estado_Civil) %>%
      mutate(
        perc = round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    total <- sum(resumo$n)
    
    principal <- resumo$Estado_Civil[1]
    perc_principal <- resumo$perc[1]
    
    restantes <- resumo %>%
      slice(-1) %>%
      mutate(txt = paste0(Estado_Civil," (",perc,"%)"))
    
    texto_restantes <- paste(restantes$txt,
                             collapse = ", ")
    
    tags$p(
      
      style="text-align:justify;margin:0;",
      
      tags$b("Estado civil das empreendedoras. "),
      
      "Após aplicação dos filtros, foram identificadas ",
      
      tags$b(total),
      
      " empreendedoras. A maioria é ",
      
      tags$b(principal),
      
      " (",perc_principal,"%). ",
      
      if(nrow(restantes)>0)
        paste0("Os restantes estados civis distribuem-se entre ",texto_restantes,".")
      
    )
    
  })

  # 
  # #   # --- Gráfico 2: Distribuição por IDADE
  output$grafico_idade <- renderPlotly({

    df <- dados_filtrados()

    req("Data_Nascimento" %in% colnames(df))

    df <- df %>%
      mutate(
        Data_nasc = as.Date(`Data_Nascimento`, format = "%Y-%m-%d"),
        Idade = floor(interval(Data_nasc, Sys.Date()) / years(1))
      ) %>%
      filter(!is.na(Idade))

    df_resumo <- df %>%
      mutate(Grupo_Idade = ifelse(Idade <= 35, "<= 35 Anos", "> 35 Anos")) %>%
      group_by(Grupo_Idade) %>%
      summarise(Total = n(), .groups = "drop") %>%
      mutate(Percentagem = round(Total / sum(Total) * 100, 1))

    plot_ly(
      data = df_resumo,
      labels = ~Grupo_Idade,
      values = ~Total,
      type = 'pie',
      textinfo = 'percent',
      insidetextorientation = 'radial',
      hole = 0.55,
      marker = list(
        colors = c('#9442d4', '#f77333'),
        line = list(color = '#FFFFFF', width = 2)
      )
    ) %>%
      layout(
        title = "",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  output$texto_idade <- renderUI({
    
    df <- dados_filtrados()
    
    df <- df %>%
      mutate(
        Data_nasc = as.Date(Data_Nascimento),
        Idade = floor(interval(Data_nasc, Sys.Date())/years(1))
      )
    
    resumo <- df %>%
      mutate(
        Grupo = ifelse(Idade<=35,"até 35 anos","mais de 35 anos")
      ) %>%
      count(Grupo) %>%
      mutate(
        perc = round(n/sum(n)*100,1)
      )
    
    jovens <- resumo %>%
      filter(Grupo=="até 35 anos")
    
    adultos <- resumo %>%
      filter(Grupo=="mais de 35 anos")
    
    tags$p(
      
      style="text-align:justify;margin:0;",
      
      tags$b("Faixa etária. "),
      
      jovens$n,
      
      " empreendedoras (",
      
      jovens$perc,
      
      "%) possuem até 35 anos, enquanto ",
      
      adultos$n,
      
      " (",
      
      adultos$perc,
      
      "%) têm mais de 35 anos."
      
    )
    
  })
  # 
  # 
  # 
  # 
  # #   ################### Distribuicao por grafico_setor
  # #   
  output$grafico_setor <- renderPlotly({

    # ---- Labels curtos
    labels_curto <- c(
      "Prestação de serviços (ornamentação de eventos, microcrédito, salão de cabeleleiro, takeaway etc)" =
        "Prestação de serviços",
      "Produção e venda de produtos alimentares (bolos, salgados, comidas, etc :transformação de prod)" =
        "Produção e venda de produtos",
      "Produção e venda de produtos não alimentares (Artesanato, etc: Com transformação de prod.)" =
        "Produção e venda de produtos não alimentares"
    )

    # ---- Cores
    cores_setores <- c(
      "Prestação de serviços" = "#9442d4",
      "Produção e venda de produtos" = "#ff7f0e",
      "Produção e venda de produtos não alimentares" = "#5cd6c7"
    )

    # ---- Base de dados
    df <- Pam_Verde_Indicadores

    # ---- Filtros
    if (input$filtro_ciclo != "Todos") {
      df <- df %>% filter(Ciclo == input$filtro_ciclo)
    }

    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>% filter(Tipo_Avaliacao == input$filtro_tipo_avaliacao)
    }

    # ---- Resumo dos dados (SEM agrupar por Tipo_Avaliacao)
    data_summary <- df %>%
      distinct(Nome_Participante, .keep_all = TRUE) %>%   # garante 1 linha por participante
      group_by(Sector) %>%
      summarise(N = n(), .groups = "drop") %>%
      mutate(
        Percentual = round(N / sum(N) * 100, 1),
        Sector_curto = labels_curto[Sector]
      )

    # ---- Gráfico 100% empilhado
    bar_plot <- ggplot(
      data_summary,
      aes(
        x = "",                                         # não exibe Tipo_Avaliacao
        y = N,
        fill = Sector_curto,
        text = paste0(Sector_curto, ": ", N, " (", Percentual, "%)")
      )
    ) +
      geom_col(position = "fill", width = 0.6) +
      geom_text(
        aes(label = paste0(N, "\n", Percentual, "%")),
        position = position_fill(vjust = 0.5),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      scale_y_continuous(labels = scales::percent) +
      scale_fill_manual(values = cores_setores) +
      labs(x = NULL, y = "Percentagem") +
      theme_stata(base_size = 12) +
      theme(
        plot.background  = element_rect(fill = "#f5f3f4", color = NA),
        panel.background = element_rect(fill = "#f5f3f4", color = NA),
        legend.position  = "bottom",
        legend.text      = element_text(size = 7),
        legend.title     = element_text(size = 10)
      )

    ggplotly(bar_plot, tooltip = "text") %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4",
        margin = list(l = 50, r = 50, t = 20, b = 80)
      )
  })

  
  output$texto_setor <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      distinct(Nome_Participante,.keep_all=TRUE) %>%
      count(Sector) %>%
      mutate(
        perc=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      
      style="text-align:justify;margin:0;",
      
      tags$b("Sector de actividade. "),
      
      "O sector predominante é ",
      
      tags$b(principal$Sector),
      
      ", representando ",
      
      principal$perc,
      
      "% dos negócios (",
      
      principal$n,
      
      " empreendedoras)."
      
    )
    
  })
  
  # #   
  # #   ####### Gráfico de Distribuição dos Anos das Empresas
  # #   
  output$grafico_Ano_Negocio <- renderPlotly({
    
    df <- dados_filtrados()
    
    req("Ano_Negocio" %in% colnames(df))
    req(nrow(df) > 0)
    
    df_ano <- df %>%
      count(Ano_Negocio) %>%
      arrange(Ano_Negocio)
    
    plot_ly(
      data = df_ano,
      x = ~Ano_Negocio,
      y = ~n,
      type = "bar",
      text = ~paste0(n, " negócios"),
      textposition = "outside",
      marker = list(
        color = '#9442d4'
      )
    ) %>%
      layout(
        title = "",
        xaxis = list(title = "Ano"),
        yaxis = list(title = "Número de negócios"),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  output$texto_ano <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      count(Ano_Negocio) %>%
      arrange(Ano_Negocio)
    
    primeiro <- min(resumo$Ano_Negocio)
    
    ultimo <- max(resumo$Ano_Negocio)
    
    mais_freq <- resumo %>%
      slice_max(n,n=1)
    
    tags$p(
      
      style="text-align:justify;margin:0;",
      
      tags$b("Ano de criação do negócio. "),
      
      "Os negócios foram criados entre ",
      
      primeiro,
      
      " e ",
      
      ultimo,
      
      ". O ano com maior número de negócios é ",
      
      tags$b(mais_freq$Ano_Negocio),
      
      ", com ",
      
      mais_freq$n,
      
      " empreendimentos."
      
    )
    
  })
  
  ##################################### PAGINA 
  
  output$grafico_formalizacao <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- Filtro ciclo
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    df <- df %>%
      dplyr::filter(!is.na(Negocio_Formalizado),
                    !is.na(Tipo_Avaliacao))
    
    # ---- Frequência
    freq_data <- df %>%
      dplyr::group_by(Tipo_Avaliacao, Negocio_Formalizado) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- Cores
    cores <- c(
      "Não" = "#5cd6c7",
      "Iniciei o processo de formalização" = "#ff7f0e",
      "Sim" = "#9442d4"
    )
    
    # ---- Gráfico
    plot_ly(
      freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~Negocio_Formalizado,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hoverinfo = "text",
      textfont = list(color = "#ffffff", size = 12)
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        yaxis = list(title = "Percentagem (%)"),
        xaxis = list(title = ""),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_formalizacao <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      filter(!is.na(Negocio_Formalizado)) %>%
      count(Negocio_Formalizado) %>%
      mutate(
        perc = round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Formalização dos negócios. "),
      
      "Após aplicação dos filtros, verificou-se que a situação predominante é ",
      
      tags$b(principal$Negocio_Formalizado),
      
      ", representando ",
      
      principal$perc,
      
      "% dos negócios (",
      
      principal$n,
      
      ")."
      
    )
    
  })
  
  # 
  # 
  # #   # ==========================================================
  # #   # PÁGINA 2 - Companies situation and performance
  # #   # ==========================================================

  
  ############################ USO DE SERVICOS FINANCEIROS
  
  output$grafico_servicos_financeiros <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # -----------------------------
    # Filtro ciclo
    # -----------------------------
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # -----------------------------
    # Preparação (multi-select)
    # -----------------------------
    df <- df %>%
      dplyr::filter(
        !is.na(Uso_Servicos_Financeiros),
        !is.na(Tipo_Avaliacao)
      ) %>%
      
      tidyr::separate_rows(
        Uso_Servicos_Financeiros,
        sep = ",(?=[A-Z])"
      ) %>%
      
      dplyr::mutate(
        Uso_Servicos_Financeiros = trimws(Uso_Servicos_Financeiros)
      )
    
    # -----------------------------
    # Frequência por grupo
    # -----------------------------
    freq_data <- df %>%
      dplyr::group_by(Tipo_Avaliacao, Uso_Servicos_Financeiros) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        percent = round(n / sum(n) * 100, 1)
      ) %>%
      dplyr::ungroup()
    
    # -----------------------------
    # Cores fixas
    # -----------------------------
    cores <- c(
      "Nenhum destes serviços" = "#5cd6c7",  
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)" = "#f9a825", 
      "Crédito ou empréstimo bancário para o negócio" = "#2ca02c",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)" =  "#bcbd22",
      "Conta bancária em nome do negócio (conta empresarial)" =  "#9442d4", 
      "Conta poupança formal ligada ao negócio" = "#ff7f0e", 
      "Seguro (de negócio, de equipamento, de saúde...)" = "#d62728"
    )
    
    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~percent,
      color = ~Uso_Servicos_Financeiros,
      colors = cores,
      type = "bar",
      
      text = ~percent,
      texttemplate = "%{text}%",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      
      layout(
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem dentro do grupo (%)",
          range = c(0, 100)
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_servicos <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      
      filter(!is.na(Uso_Servicos_Financeiros)) %>%
      
      separate_rows(
        Uso_Servicos_Financeiros,
        sep=",(?=[A-Z])"
      ) %>%
      
      mutate(
        Uso_Servicos_Financeiros=trimws(Uso_Servicos_Financeiros)
      ) %>%
      
      count(Uso_Servicos_Financeiros) %>%
      
      mutate(
        perc=round(n/sum(n)*100,1)
      ) %>%
      
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Serviços financeiros utilizados. "),
      
      "O serviço financeiro mais utilizado é ",
      
      tags$b(principal$Uso_Servicos_Financeiros),
      
      ", referido por ",
      
      principal$perc,
      
      "% das respostas."
      
    )
    
  })
  
  #### RETIRAR SALARIO PARA SI
  
  output$grafico_tira_salario <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- Filtro ciclo
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    df <- df %>%
      dplyr::filter(
        !is.na(Tira_Salario_Para_Si),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- Frequência
    freq_data <- df %>%
      dplyr::group_by(Tipo_Avaliacao, Tira_Salario_Para_Si) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- Cores
    cores <- c(
      "Não, não retiro nenhum valor para mim mesma" = "#5cd6c7",
      "Retiro de forma irregular, conforme o negócio tem dinheiro" = "#ff7f0e",
      "Sim, retiro um valor fixo todos os meses" = "#9442d4"
    )
    
    # ---- Gráfico
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~Tira_Salario_Para_Si,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      textfont = list(
        color = "#ffffff",
        size = 12
      )
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_salario <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      
      filter(!is.na(Tira_Salario_Para_Si)) %>%
      
      count(Tira_Salario_Para_Si) %>%
      
      mutate(
        perc=round(n/sum(n)*100,1)
      ) %>%
      
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Remuneração da empreendedora. "),
      
      "A resposta predominante foi ",
      
      tags$b(principal$Tira_Salario_Para_Si),
      
      ", correspondendo a ",
      
      principal$perc,
      
      "% das participantes."
      
    )
    
  })

  output$grafico_clientes_regulares <- renderPlotly({
    
    dados_cat <- Pam_Verde_Indicadores %>%
      mutate(
        categoria = case_when(
          Clientes_Regulares_Negocio <= 5 ~ "0–5",
          Clientes_Regulares_Negocio <= 10 ~ "6–10",
          Clientes_Regulares_Negocio <= 20 ~ "11–20",
          TRUE ~ ">20"
        )
      ) %>%
      count(categoria) %>%
      mutate(
        Percent = round(100 * n / sum(n), 1)
      )
    
    # garantir ordem lógica
    dados_cat$categoria <- factor(
      dados_cat$categoria,
      levels = c("0–5", "6–10", "11–20", ">20")
    )
    
    p <- ggplot(dados_cat, aes(x = categoria, y = Percent, fill = categoria)) +
      geom_col() +
      geom_text(aes(label = paste0(Percent, "%")), vjust = -0.3, size = 4) +
      
      scale_fill_manual(values = c(
        "0–5"   = "#5cd6c7",
        "6–10"  = "#ff7f0e",
        "11–20" = "#F39C12",
        ">20"   = "#9442d4"
      )) +
      
      labs(
        title = "",
        x = "",
        y = "Percentagem (%)"
      ) +
      
      theme_minimal()
    
    ggplotly(p) %>%
      layout(
        title = "",
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  output$texto_clientes <- renderUI({
    
    df <- dados_filtrados()
    
    resumo <- df %>%
      
      mutate(
        
        categoria=case_when(
          
          Clientes_Regulares_Negocio<=5 ~ "0–5",
          
          Clientes_Regulares_Negocio<=10 ~ "6–10",
          
          Clientes_Regulares_Negocio<=20 ~ "11–20",
          
          TRUE ~ ">20"
          
        )
        
      ) %>%
      
      count(categoria) %>%
      
      mutate(
        perc=round(n/sum(n)*100,1)
      ) %>%
      
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Clientes regulares. "),
      
      "A maior parte dos negócios possui ",
      
      tags$b(principal$categoria),
      
      " clientes regulares, representando ",
      
      principal$perc,
      
      "% das empreendedoras."
      
    )
    
  })
  # ##----------------------------------------------------------- 
  # ###################                  3 PAGINA SOFT SKILL
  # ##-----------------------------------------------------------------------------  
  # #################################################
  # # GRAFICO CONFIANÇA
  # #################################################
  # # Dados filtrados reativos
  output$grafico_triang_empilhado <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Quem_Toma_Decisoes_Negocio"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    # -----------------------------
    # Resumo
    # -----------------------------
    df_resumo <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Quem_Toma_Decisoes_Negocio)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        Quem_Toma_Decisoes_Negocio
      ) %>%
      dplyr::summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(
          Total / sum(Total) * 100,
          1
        )
      ) %>%
      dplyr::ungroup()
    
    # -----------------------------
    # Cores
    # -----------------------------
    cores <- c(
      "Só eu" = "#9442d4",
      "Eu juntamente com outra pessoa" = "#ff7f0e",
      "Outra pessoa" = "#5cd6c7"
    )
    
    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percentagem,
      
      color = ~Quem_Toma_Decisoes_Negocio,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percentagem, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      
      layout(
        barmode = "stack",
        
        xaxis = list(
          title = ""
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100)
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_decisoes <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Quem_Toma_Decisoes_Negocio"
    
    req(var %in% names(df))
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem = round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    principal <- resumo[1,]
    
    tags$p(
      style="margin:0; text-align:justify;",
      
      tags$b("Autonomia na tomada de decisão. "),
      
      "Entre as empreendedoras analisadas, a principal responsabilidade pelas decisões do negócio é atribuída a ",
      
      tags$b(principal[[var]]),
      
      ", representando ",
      
      principal$Percentagem,
      
      "% das respostas. ",
      
      if(principal$Percentagem >= 70){
        "Este resultado indica um elevado nível de autonomia individual na gestão dos negócios."
      } else {
        "Observa-se uma distribuição das decisões entre diferentes intervenientes, indicando a existência de partilha na gestão do negócio."
      }
    )
    
  })
  
  # 
  # #################### Negociacao_Com_Agregado_Familiar
  output$grafico_agregado_familiar <- renderPlotly({

    df <- dados_filtrados()

    req(all(c("Tipo_Avaliacao", "Negociacao_Com_Agregado_Familiar") %in% colnames(df)))
    req(nrow(df) > 0)

    # -----------------------------
    # Preparação
    # -----------------------------
    df_resumo <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Com_Agregado_Familiar)
      ) %>%

      dplyr::group_by(
        Tipo_Avaliacao,
        Negociacao_Com_Agregado_Familiar
      ) %>%

      dplyr::summarise(
        Total = n(),
        .groups = "drop"
      ) %>%

      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      dplyr::ungroup()

    # -----------------------------
    # Cores fixas
    # -----------------------------
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiantee sei defender a minha posição" = "#9442d4"
    )

    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = df_resumo,

      x = ~Tipo_Avaliacao,
      y = ~Percent,

      color = ~Negociacao_Com_Agregado_Familiar,
      colors = cores,

      type = "bar",

      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",

      textfont = list(
        color = "#ffffff",
        size = 11
      ),

      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%

      layout(
        barmode = "stack",

        xaxis = list(title = ""),

        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100)
        ),

        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),

        margin = list(l = 60, r = 20, t = 20, b = 120),

        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  # 
  output$texto_agregado <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Negociacao_Com_Agregado_Familiar"
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    principal <- resumo[1,]
    
    
    tags$p(
      style="margin:0; text-align:justify;",
      
      tags$b("Influência no agregado familiar. "),
      
      "Relativamente à negociação dentro do agregado familiar, a resposta predominante foi ",
      
      tags$b(principal[[var]]),
      
      ", representando ",
      
      principal$Percentagem,
      
      "% das participantes. ",
      
      "Este resultado demonstra o nível de participação das empreendedoras nas decisões relacionadas com o funcionamento e crescimento do negócio."
    )
    
  })
  
  output$texto_negociacao <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Praticou_negociação_nos_últimos_3meses"
    
    req(var %in% names(df))
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem = round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    principal <- resumo[1,]
    
    
    tags$p(
      style="margin:0; text-align:justify;",
      
      tags$b("Competências de negociação. "),
      
      "A maioria das empreendedoras indicou como principal experiência de negociação: ",
      
      tags$b(principal[[var]]),
      
      ", correspondendo a ",
      
      principal$Percentagem,
      
      "% das respostas. ",
      
      "Este indicador permite avaliar a capacidade das participantes em defender condições favoráveis para os seus negócios nas relações comerciais."
    )
    
  })
  # 
  # #################################### Negociacao_Com_Clientes
  # 
  output$grafico_clientes <- renderPlotly({

    df <- dados_filtrados()

    req(all(c("Tipo_Avaliacao", "Negociacao_Com_Clientes") %in% colnames(df)))
    req(nrow(df) > 0)

    # -----------------------------
    # Preparação
    # -----------------------------
    df_resumo <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Com_Clientes)
      ) %>%

      dplyr::group_by(
        Tipo_Avaliacao,
        Negociacao_Com_Clientes
      ) %>%

      dplyr::summarise(
        Total = n(),
        .groups = "drop"
      ) %>%

      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      dplyr::ungroup()

    # -----------------------------
    # Cores fixas
    # -----------------------------
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiantee sei defender a minha posição" = "#9442d4"
    )

    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = df_resumo,

      x = ~Tipo_Avaliacao,
      y = ~Percent,

      color = ~Negociacao_Com_Clientes,
      colors = cores,

      type = "bar",

      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",

      textfont = list(
        color = "#ffffff",
        size = 11
      ),

      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%

      layout(
        barmode = "stack",

        xaxis = list(title = ""),

        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100)
        ),

        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),

        margin = list(l = 60, r = 20, t = 20, b = 120),

        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  # 
  output$texto_clientes_neg <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Negociacao_Com_Clientes"
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    principal <- resumo[1,]
    
    
    tags$p(
      style="margin:0; text-align:justify;",
      
      tags$b("Negociação comercial com clientes. "),
      
      "A resposta mais frequente indica que ",
      
      tags$b(principal[[var]]),
      
      ", representando ",
      
      principal$Percentagem,
      
      "% das empreendedoras analisadas. ",
      
      "Este indicador reflete a capacidade das participantes em gerir relações comerciais e negociar melhores condições de venda."
    )
    
  })
  # 
  output$grafico_funcionarios <- renderPlotly({

    df <- dados_filtrados()

    req(all(c("Tipo_Avaliacao", "Negociacao_Pessoas_Com_Quem_Trabalha") %in% colnames(df)))
    req(nrow(df) > 0)

    # -----------------------------
    # Preparação
    # -----------------------------
    df_resumo <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Pessoas_Com_Quem_Trabalha)
      ) %>%

      dplyr::group_by(
        Tipo_Avaliacao,
        Negociacao_Pessoas_Com_Quem_Trabalha
      ) %>%

      dplyr::summarise(
        Total = n(),
        .groups = "drop"
      ) %>%

      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      dplyr::ungroup()

    # -----------------------------
    # Cores fixas
    # -----------------------------
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiantee sei defender a minha posição" = "#9442d4"
    )

    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = df_resumo,

      x = ~Tipo_Avaliacao,
      y = ~Percent,

      color = ~Negociacao_Pessoas_Com_Quem_Trabalha,
      colors = cores,

      type = "bar",

      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",

      textfont = list(
        color = "#ffffff",
        size = 11
      ),

      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%

      layout(
        barmode = "stack",

        xaxis = list(title = ""),

        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100)
        ),

        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),

        margin = list(l = 60, r = 20, t = 20, b = 120),

        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  # 
  output$texto_funcionarios <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Negociacao_Pessoas_Com_Quem_Trabalha"
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    principal <- resumo[1,]
    
    
    tags$p(
      style="margin:0; text-align:justify;",
      
      tags$b("Gestão das relações de trabalho. "),
      
      "Na interação com colaboradores ou pessoas envolvidas no negócio, a resposta predominante foi ",
      
      tags$b(principal[[var]]),
      
      ", representando ",
      
      principal$Percentagem,
      
      "% das participantes. ",
      
      "O resultado evidencia o nível de liderança e capacidade de gestão das relações internas no negócio."
    )
    
  })
  # 
  # output$texto_canais <- renderUI({
  #   
  #   df <- dados_filtrados()
  #   
  #   var <- "Onde vende actualmente os seus produtos ou serviços?"
  #   
  #   req(var %in% names(df))
  #   
  #   
  #   resumo <- df %>%
  #     filter(!is.na(.data[[var]])) %>%
  #     separate_rows(.data[[var]], sep=",") %>%
  #     mutate(
  #       Canal=str_trim(.data[[var]])
  #     ) %>%
  #     count(Canal) %>%
  #     mutate(
  #       Percentagem=round(n/sum(n)*100,1)
  #     ) %>%
  #     arrange(desc(n))
  #   
  #   
  #   principal <- resumo[1,]
  #   
  #   
  #   tags$p(
  #     style="margin:0; text-align:justify;",
  #     
  #     tags$b("Estratégias de comercialização. "),
  #     
  #     "O principal canal utilizado pelas empreendedoras é ",
  #     
  #     tags$b(principal$Canal),
  #     
  #     ", representando ",
  #     
  #     principal$Percentagem,
  #     
  #     "% das respostas. ",
  #     
  #     "Este indicador permite compreender os mecanismos utilizados pelas participantes para alcançar clientes e gerar receitas."
  #   )
  #   
  # })
  # ##----------------------------------------------------------- 
  # ###################                  3 PAGINA Habilidades e Processos
  # ##-----------------------------------------------------------------------------  
  
  output$grafico_uso_ia <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- Filtro ciclo (opcional)
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- Limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(Uso_de_ferramentas_de_IA),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- Frequência
    freq_data <- df %>%
      dplyr::group_by(Tipo_Avaliacao, Uso_de_ferramentas_de_IA) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- Ordem lógica das categorias IA
    freq_data$Uso_de_ferramentas_de_IA <- factor(
      freq_data$Uso_de_ferramentas_de_IA,
      levels = c(
        "Não, nunca usei e não sei bem o que é",
        "Ouvi falar mas nunca experimentei",
        "Sim, usei pelo menos uma vez",
        "Sim, uso regularmente para o negócio"
      )
    )
    
    # ---- Cores manuais
    cores <- c(
      "Não, nunca usei e não sei bem o que é" = "#69C7BE",
      "Ouvi falar mas nunca experimentei" = "#f39c12",
      "Sim, usei pelo menos uma vez" = "#ff7f0e",
      "Sim, uso regularmente para o negócio" = "#9442d4"
    )
    
    # ---- Gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~Uso_de_ferramentas_de_IA,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      textfont = list(
        color = "#ffffff",
        size = 12
      )
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_uso_ia <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Uso_de_ferramentas_de_IA"
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    principal <- resumo[1,]
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Utilização de ferramentas digitais e inteligência artificial. "),
      
      "A análise indica que a maior parte das empreendedoras encontra-se na categoria ",
      
      tags$b(principal[[var]]),
      
      ", representando ",
      
      principal$Percentagem,
      
      "% das participantes. ",
      
      if(grepl("uso regularmente", principal[[var]], ignore.case = TRUE)){
        
        "Este resultado demonstra uma integração significativa de ferramentas digitais no apoio à gestão dos negócios."
        
      }else{
        
        "Os resultados indicam oportunidade de reforço da literacia digital e sensibilização sobre o potencial da inteligência artificial para melhorar processos empresariais."
        
      }
      
    )
    
  })
  
  
  
  output$grafico_control_dinheiro <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Faz controlo do dinheiro que entra e que sai (receitas e despesas)`
      ) %>%
      summarise(Total = n(), .groups = "drop") %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      ungroup()
    
    cores <- c(
      "Sim" = "#9442d4",
      "Não" = "#69C7BE"
    )
    
    plot_ly(
      data = df_resumo,
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      color = ~`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`,
      colors = cores,
      type = "bar",
      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      textfont = list(color = "white", size = 11)
    ) %>%
      layout(
        barmode = "stack",
        xaxis = list(title = ""),
        yaxis = list(title = "Percentagem (%)", range = c(0, 100)),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        margin = list(l = 60, r = 20, t = 20, b = 120),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  output$texto_control_dinheiro <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      )
    
    
    sim <- resumo %>%
      filter(.data[[var]]=="Sim")
    
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Controlo financeiro do negócio. "),
      
      "O controlo das receitas e despesas é realizado por ",
      
      sim$Percentagem,
      
      "% das empreendedoras analisadas. ",
      
      if(sim$Percentagem >=70){
        
        "Este resultado evidencia adoção de práticas financeiras que contribuem para melhor acompanhamento do desempenho do negócio."
        
      }else{
        
        "Existe espaço para fortalecimento das capacidades de registo e monitoria financeira."
        
      }
      
    )
    
  })
  
  output$grafico_separacao_contas <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Faz separação das contas pessoais e do negócio"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Faz separação das contas pessoais e do negócio`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Faz separação das contas pessoais e do negócio`
      ) %>%
      summarise(Total = n(), .groups = "drop") %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      ungroup()
    
    cores <- c(
      "Sim" = "#9442d4",
      "Não" = "#69C7BE"
    )
    
    
    plot_ly(
      data = df_resumo,
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      color = ~`Faz separação das contas pessoais e do negócio`,
      colors = cores,
      type = "bar",
      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      textfont = list(color = "white", size = 11)
    ) %>%
      layout(
        barmode = "stack",
        xaxis = list(title = ""),
        yaxis = list(title = "Percentagem (%)", range = c(0, 100)),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        margin = list(l = 60, r = 20, t = 20, b = 120),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  output$texto_separacao_contas <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Faz separação das contas pessoais e do negócio"
    
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      ) %>%
      arrange(desc(n))
    
    
    sim <- resumo %>%
      filter(.data[[var]]=="Sim")
    
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Gestão financeira e organização empresarial. "),
      
      "A separação entre recursos pessoais e recursos do negócio é praticada por ",
      
      sim$n,
      
      " empreendedoras, correspondendo a ",
      
      sim$Percentagem,
      
      "% das participantes analisadas. ",
      
      if(sim$Percentagem >= 70){
        
        "Este resultado demonstra boas práticas de gestão financeira e maior controlo dos recursos empresariais."
        
      }else{
        
        "Os resultados indicam uma necessidade de reforçar práticas de organização financeira e gestão separada do negócio."
        
      }
      
    )
    
  })
  output$grafico_calcular_Lucro <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Sabe calcular o lucro do negócio  (com base no exercício prático)`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Sabe calcular o lucro do negócio  (com base no exercício prático)`
      ) %>%
      summarise(Total = n(), .groups = "drop") %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      ungroup()
    
    cores <- c(
      "Sim" = "#9442d4",
      "Não" = "#69C7BE"
    )
    
    plot_ly(
      data = df_resumo,
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      color = ~`Sabe calcular o lucro do negócio  (com base no exercício prático)`,
      colors = cores,
      type = "bar",
      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      textfont = list(color = "white", size = 11)
    ) %>%
      layout(
        barmode = "stack",
        xaxis = list(title = ""),
        yaxis = list(title = "Percentagem (%)", range = c(0, 100)),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        margin = list(l = 60, r = 20, t = 20, b = 120),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  output$texto_calculo_lucro <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    
    
    req(var %in% names(df))
    
    
    resumo <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      )
    
    
    sim <- resumo %>%
      filter(.data[[var]]=="Sim")
    
    
    tags$p(
      
      style="margin:0;text-align:justify;",
      
      tags$b("Conhecimento sobre cálculo do lucro. "),
      
      "Do total de empreendedoras avaliadas, ",
      
      sim$Percentagem,
      
      "% demonstram capacidade de calcular o lucro do negócio. ",
      
      "Este indicador mede uma competência essencial para tomada de decisões financeiras e sustentabilidade empresarial."
      
    )
    
  })
  output$grafico_negociacao_3meses <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Praticou_negociação_nos_últimos_3meses"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    # -----------------------------
    # Preparação
    # -----------------------------
    df_resumo <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Praticou_negociação_nos_últimos_3meses)
      ) %>%
      
      dplyr::group_by(
        Tipo_Avaliacao,
        Praticou_negociação_nos_últimos_3meses
      ) %>%
      
      dplyr::summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      
      dplyr::group_by(Tipo_Avaliacao) %>%
      
      dplyr::mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      
      dplyr::ungroup()
    
    # -----------------------------
    # Cores fixas
    # -----------------------------
    cores <- c(
      "Não tive situações de negociação neste período" = "#69C7BE", 
      "Não, aceitei as condições sem negociar" = "#F39C12",
      "Sim, negociei, mas não consegui mudar as condições" = "#F37238",
      "Sim, negociei e consegui um acordo favorável para o meu negócio" = "#9442d4"
    )
    
    # -----------------------------
    # Gráfico
    # -----------------------------
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~Praticou_negociação_nos_últimos_3meses,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        barmode = "stack",
        
        xaxis = list(title = ""),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100)
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.35
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 170
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  
  output$grafico_canais <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(all(c(
      "Tipo_Avaliacao",
      "Onde vende actualmente os seus produtos ou serviços?"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    #---------------------------------
    # Preparação
    #---------------------------------
    
    df_resumo <- df %>%
      
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Onde vende actualmente os seus produtos ou serviços?`)
      ) %>%
      
      separate_rows(
        `Onde vende actualmente os seus produtos ou serviços?`,
        sep = ","
      ) %>%
      
      mutate(
        Canal = str_trim(`Onde vende actualmente os seus produtos ou serviços?`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        Canal
      ) %>%
      
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        Percent = round(Total / sum(Total) * 100, 1)
      ) %>%
      
      ungroup()
    
    #---------------------------------
    # Gráfico
    #---------------------------------
    
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~Canal,
      
      type = "bar",
      
      text = ~paste0(Percent, "%"),
      texttemplate = "%{text}",
      textposition = "inside",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        xaxis = list(title = ""),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100)
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.35
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 140
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
        
      )
    
  })
  
#################################### CONSCIENCIA DE GENERO
  output$grafico_H_Financeiros <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    
    # ---- ordem das respostas
    freq_data$`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .` <- factor(
      freq_data$`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`,
      levels = c(
        "Discordo",
        "Depende",
        "Concordo"
      )
    )
    
    
    # ---- cores
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#ffffff",
        size = 12
      )
      
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_H_Financeiros <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados ."
    
    dados <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(percent = round(n/sum(n)*100,1))
    
    concordo <- dados %>%
      filter(.data[[var]]=="Concordo") %>%
      pull(percent)
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Acesso a oportunidades financeiras: "),
      
      paste0(
        concordo,
        "% das empreendedoras concordam que os homens possuem maior facilidade de acesso a produtos financeiros, redes ou novos mercados. ",
        "Este resultado evidencia possíveis barreiras de género no acesso a recursos necessários para o crescimento dos negócios."
      )
    )
  })
  
  output$grafico_H_Serios <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Os homens são levados mais a sério como empreendedores.`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Os homens são levados mais a sério como empreendedores.`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    
    # ---- ordem das respostas
    freq_data$`Os homens são levados mais a sério como empreendedores.` <- factor(
      freq_data$`Os homens são levados mais a sério como empreendedores.`,
      levels = c(
        "Discordo",
        "Depende",
        "Concordo"
      )
    )
    
    
    # ---- cores
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Os homens são levados mais a sério como empreendedores.`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#ffffff",
        size = 12
      )
      
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_H_Serios <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Os homens são levados mais a sério como empreendedores."
    
    dados <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(percent=round(n/sum(n)*100,1))
    
    
    conc <- dados %>%
      filter(.data[[var]]=="Concordo") %>%
      pull(percent)
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Reconhecimento social do empreendedorismo: "),
      
      paste0(
        conc,
        "% das participantes concordam que homens são mais levados a sério como empreendedores, indicando a presença de perceções sociais diferenciadas sobre credibilidade empresarial."
      )
    )
  })
  
  output$grafico_H_Capazes <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Homens são mais capazes de negociar do que as mulheres.`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Homens são mais capazes de negociar do que as mulheres.`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    
    # ---- ordem das respostas
    freq_data$`Homens são mais capazes de negociar do que as mulheres.` <- factor(
      freq_data$`Homens são mais capazes de negociar do que as mulheres.`,
      levels = c(
        "Discordo",
        "Depende",
        "Concordo"
      )
    )
    
    
    # ---- cores
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Homens são mais capazes de negociar do que as mulheres.`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#ffffff",
        size = 12
      )
      
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_H_Capazes <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Homens são mais capazes de negociar do que as mulheres."
    
    dados <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(percent=round(n/sum(n)*100,1))
    
    
    conc <- dados %>%
      filter(.data[[var]]=="Concordo") %>%
      pull(percent)
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Perceção sobre negociação: "),
      
      paste0(
        conc,
        "% acreditam que os homens têm maior capacidade de negociação. ",
        "O indicador permite analisar diferenças percebidas de confiança e poder de negociação no ambiente empresarial."
      )
    )
  })
  
  
  output$grafico_Obrigacoes_Domesticas <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    
    # ---- ordem das respostas
    freq_data$`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.` <- factor(
      freq_data$`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`,
      levels = c(
        "Discordo",
        "Depende",
        "Concordo"
      )
    )
    
    
    # ---- cores
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#ffffff",
        size = 12
      )
      
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_Obrigacoes_Domesticas <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens."
    
    dados <- df %>%
      filter(!is.na(.data[[var]])) %>%
      count(.data[[var]]) %>%
      mutate(percent=round(n/sum(n)*100,1))
    
    
    conc <- dados %>%
      filter(.data[[var]]=="Concordo") %>%
      pull(percent)
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Carga doméstica e participação económica: "),
      
      paste0(
        conc,
        "% concordam que as responsabilidades domésticas reduzem o tempo disponível das mulheres para o negócio. ",
        "Este resultado demonstra como normas familiares podem influenciar o desempenho empresarial."
      )
    )
  })
  
  output$grafico_M_Gerir <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Não se espera que as mulheres sejam capazes de gerir um negócio.`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Não se espera que as mulheres sejam capazes de gerir um negócio.`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    
    # ---- ordem das respostas
    freq_data$`Não se espera que as mulheres sejam capazes de gerir um negócio.` <- factor(
      freq_data$`Não se espera que as mulheres sejam capazes de gerir um negócio.`,
      levels = c(
        "Discordo",
        "Depende",
        "Concordo"
      )
    )
    
    
    # ---- cores
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Não se espera que as mulheres sejam capazes de gerir um negócio.`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#ffffff",
        size = 12
      )
      
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_M_Gerir <- renderUI({
    
    df <- dados_filtrados()
    
    var <- "Não se espera que as mulheres sejam capazes de gerir um negócio."
    
    req(var %in% colnames(df))
    
    dados <- df %>%
      dplyr::filter(
        !is.na(.data[[var]])
      ) %>%
      dplyr::count(.data[[var]]) %>%
      dplyr::mutate(
        percent = round(n / sum(n) * 100, 1)
      )
    
    
    concordo <- dados %>%
      dplyr::filter(.data[[var]] == "Concordo") %>%
      dplyr::pull(percent)
    
    
    if(length(concordo) == 0){
      concordo <- 0
    }
    
    
    tags$p(
      style="margin:0;text-align:justify;",
      
      tags$b("Perceção sobre a capacidade das mulheres para gerir negócios: "),
      
      paste0(
        concordo,
        "% das participantes concordam que existe uma perceção social de que as mulheres não são capazes de gerir um negócio. ",
        "Este indicador permite compreender a influência das normas de género e possíveis barreiras culturais que podem limitar a confiança, autonomia e crescimento das mulheres empreendedoras."
      )
    )
  })
  
  # 
  # ##########################     CONSCIENCIA AMBIENTAL ######################
  # 
  # # ####################Pontuacões##############
  # # 
  output$graficoPontuacao <- renderPlotly({
    # =========================
    # FILTRO BASE
    # =========================
    dados_filtrados <- Pegada_Carbono
    
    if (!is.null(input$cidade_pegada) && input$cidade_pegada != "Todas") {
      dados_filtrados <- dados_filtrados %>%
        filter(Cidade == input$cidade_pegada)
    }
    
    if (!is.null(input$ano_pegada) && input$ano_pegada != "Todos") {
      dados_filtrados <- dados_filtrados %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    if (!is.null(input$ciclo_pegada) && input$ciclo_pegada != "Todos") {
      dados_filtrados <- dados_filtrados %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    # =========================
    # CONTAGEM + PERCENTAGEM
    # =========================
    dados_contagem <- dados_filtrados %>%
      group_by(Status_Pegada, Tipo_Avaliacao) %>%
      summarise(
        num_participantes = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = num_participantes / sum(num_participantes) * 100
      ) %>%
      ungroup()
    
    # =========================
    # ORDEM DAS CATEGORIAS
    # =========================
    dados_contagem$Status_Pegada <- factor(
      dados_contagem$Status_Pegada,
      levels = c(
        "PEGADA BAIXA",
        "PEGADA MÉDIA",
        "PEGADA ALTA"
      )
    )
    
    # =========================
    # CORES
    # =========================
    cores_pegada <- c(
      "PEGADA BAIXA" = "#8054A2",
      "PEGADA MÉDIA" = "#f39c12",
      "PEGADA ALTA"  = "#F77333"
    )
    
    # =========================
    # GRÁFICO
    # =========================
    g <- ggplot(
      dados_contagem,
      aes(
        x = Status_Pegada,
        y = num_participantes,
        fill = Status_Pegada,
        text = paste0(
          "Status: ", Status_Pegada, "<br>",
          "Participantes: ", num_participantes, "<br>",
          "Percentagem: ", round(Percentagem, 1), "%<br>",
          "Avaliação: ", Tipo_Avaliacao
        )
      )
    ) +
      geom_col(width = 0.7) +
      
      geom_text(
        aes(
          label = paste0(
            num_participantes,
            " (",
            round(Percentagem, 1),
            "%)"
          )
        ),
        position = position_stack(vjust = 0.5),
        size = 5,
        color = "white",
        fontface = "bold"
      ) +
      
      facet_wrap(~Tipo_Avaliacao) +
      
      scale_fill_manual(values = cores_pegada) +
      
      theme_minimal(base_size = 12) +
      
      theme(
        legend.position = "none",
        panel.grid = element_blank(),
        strip.text = element_text(size = 12, face = "bold"),
        axis.text.x = element_text(face = "bold"),
        panel.spacing = unit(1, "lines"),
        panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5)
      ) +
      
      labs(
        x = NULL,
        y = "Número de Participantes"
      )
    
    # =========================
    # PLOTLY
    # =========================
    ggplotly(g, tooltip = "text") %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_Pegada <- renderUI({
    
    # =========================
    # FILTRO BASE
    # =========================
    df <- Pegada_Carbono
    
    # Filtro Cidade
    if (!is.null(input$cidade_pegada) &&
        input$cidade_pegada != "Todas") {
      
      df <- df %>%
        filter(Cidade == input$cidade_pegada)
    }
    
    
    # Filtro Ano
    if (!is.null(input$ano_pegada) &&
        input$ano_pegada != "Todos") {
      
      df <- df %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    
    # Filtro Ciclo
    if (!is.null(input$ciclo_pegada) &&
        input$ciclo_pegada != "Todos") {
      
      df <- df %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    
    req(nrow(df) > 0)
    
    
    # =========================
    # RESUMO
    # =========================
    resumo <- df %>%
      filter(!is.na(Status_Pegada)) %>%
      count(Status_Pegada) %>%
      mutate(
        Percentagem = round(n / sum(n) * 100, 1)
      )
    
    
    baixa <- resumo %>%
      filter(Status_Pegada == "PEGADA BAIXA") %>%
      pull(Percentagem)
    
    
    media <- resumo %>%
      filter(Status_Pegada == "PEGADA MÉDIA") %>%
      pull(Percentagem)
    
    
    alta <- resumo %>%
      filter(Status_Pegada == "PEGADA ALTA") %>%
      pull(Percentagem)
    
    
    # Evitar erro quando uma categoria não existe
    baixa <- ifelse(length(baixa)==0,0,baixa)
    media <- ifelse(length(media)==0,0,media)
    alta  <- ifelse(length(alta)==0,0,alta)
    
    
    # =========================
    # TEXTO DINÂMICO
    # =========================
    HTML(
      paste0(
        "<b>Interpretação da Pegada de Carbono:</b><br><br>",
        
        "A distribuição das participantes demonstra que ",
        "<b>", baixa, "%</b>",
        " apresentam uma <b>pegada baixa</b>, ",
        "enquanto <b>", media, "%</b>",
        " apresentam uma pegada média e <b>",
        alta,
        "%</b> apresentam uma pegada elevada.<br><br>"
        
      )
    )
  })
  
  
  output$grafico_conhecimento_ambiental <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(Nível_de_conhecimento_ambiental),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(Tipo_Avaliacao, Nível_de_conhecimento_ambiental) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- ordem lógica
    freq_data$Nível_de_conhecimento_ambiental <- factor(
      freq_data$Nível_de_conhecimento_ambiental,
      levels = c(
        "Básico — já ouvi falar, mas não sei muito",
        "Bom — estou ciente dos problemas",
        "Muito bom — compreendo bem e tento manter-me informada"
      )
    )
    
    # ---- cores manuais (progressão lógica)
    cores <- c(
      "Básico — já ouvi falar, mas não sei muito" = "#69C7BE",
      "Bom — estou ciente dos problemas" = "#f39c12",
      "Muito bom — compreendo bem e tento manter-me informada" = "#8054A2"
    )
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~Nível_de_conhecimento_ambiental,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      textfont = list(
        color = "#ffffff",
        size = 12
      )
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  output$texto_conhecimento_ambiental <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if(input$filtro_ciclo!="Todos"){
      df <- df %>% filter(Ciclo==input$filtro_ciclo)
    }
    
    resumo <- df %>%
      filter(!is.na(Nível_de_conhecimento_ambiental)) %>%
      count(Nível_de_conhecimento_ambiental) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      )
    
    
    melhor <- resumo %>%
      filter(
        Nível_de_conhecimento_ambiental==
          "Muito bom — compreendo bem e tento manter-me informada"
      ) %>%
      pull(Percentagem)
    
    
    HTML(
      paste0(
        "<b>Interpretação:</b><br>",
        melhor,
        "% das empreendedoras demonstram um nível elevado de conhecimento ambiental, ",
        "revelando maior consciência sobre problemas ambientais e necessidade de informação."
      )
    )
  })
  
  output$grafico_impacto_ambiental_negocio <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Em que medida tem consciência do impacto ambiental do seu negócio?`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Em que medida tem consciência do impacto ambiental do seu negócio?`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- ordem lógica
    freq_data$`Em que medida tem consciência do impacto ambiental do seu negócio?` <- factor(
      freq_data$`Em que medida tem consciência do impacto ambiental do seu negócio?`,
      levels = c(
        "Não conheço a relação entre a minha actividade e o impacto ambiental",
        "Basicamente, sei que o que faço pode poluir ou ter impacto",
        "Bom — estou ciente disso e tento reduzi-lo",
        "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental"
      )
    )
    
    # ---- cores manuais (progressão MEL)
    cores <- c(
      "Não conheço a relação entre a minha actividade e o impacto ambiental" = "#69C7BE",
      "Basicamente, sei que o que faço pode poluir ou ter impacto" = "#f9a825",
      "Bom — estou ciente disso e tento reduzi-lo" = "#F37238",
      "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental" = "#8054A2"
    )
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Em que medida tem consciência do impacto ambiental do seu negócio?`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      textfont = list(
        color = "#ffffff",
        size = 12
      )
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_impacto_ambiental <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if(input$filtro_ciclo!="Todos"){
      df <- df %>% filter(Ciclo==input$filtro_ciclo)
    }
    
    
    resumo <- df %>%
      filter(!is.na(`Em que medida tem consciência do impacto ambiental do seu negócio?`)) %>%
      count(`Em que medida tem consciência do impacto ambiental do seu negócio?`) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      )
    
    
    consciente <- resumo %>%
      filter(
        grepl(
          "Bom|Muito bom",
          `Em que medida tem consciência do impacto ambiental do seu negócio?`
        )
      ) %>%
      summarise(
        total=sum(Percentagem)
      ) %>%
      pull(total)
    
    
    HTML(
      paste0(
        "<b>Interpretação:</b><br>",
        consciente,
        "% das participantes demonstram consciência sobre o impacto ambiental ",
        "das suas actividades económicas, indicando reconhecimento da relação entre negócio e ambiente."
      )
    )
  })
  
  output$grafico_praticas_sustentaveis <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    req(input$filtro_ciclo)
    
    # ---- filtro opcional
    if (!is.null(input$filtro_ciclo) &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    # ---- limpeza
    df <- df %>%
      dplyr::filter(
        !is.na(`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`),
        !is.na(Tipo_Avaliacao)
      )
    
    # ---- frequência + percentagem
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`
      ) %>%
      dplyr::summarise(n = n(), .groups = "drop") %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      dplyr::ungroup()
    
    # ---- ordem lógica
    freq_data$`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?` <- factor(
      freq_data$`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`,
      levels = c(
        "Não, não consigo identificar nenhuma prática sustentável para o meu negócio",
        "Sim"
      )
    )
    
    # ---- cores manuais
    cores <- c(
      "Não, não consigo identificar nenhuma prática sustentável para o meu negócio" = "#69C7BE",
      "Sim" = "#8054A2"
    )
    
    # ---- gráfico empilhado
    plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      textfont = list(
        color = "#ffffff",
        size = 12
      )
    ) %>%
      layout(
        title = "",
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$texto_praticas_sustentaveis <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if(input$filtro_ciclo!="Todos"){
      df <- df %>% filter(Ciclo==input$filtro_ciclo)
    }
    
    
    resumo <- df %>%
      filter(!is.na(`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`)) %>%
      count(`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`) %>%
      mutate(
        Percentagem=round(n/sum(n)*100,1)
      )
    
    
    sim <- resumo %>%
      filter(
        `Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`
        =="Sim"
      ) %>%
      pull(Percentagem)
    
    
    HTML(
      paste0(
        "<b>Interpretação:</b><br>",
        sim,
        "% conseguem identificar práticas sustentáveis aplicáveis ao negócio, ",
        "demonstrando potencial para adopção de soluções ambientais nas suas actividades."
      )
    )
  })
 
  ########################## MONITORIA DAS SESSÕES PAM VERDE
  
  dados_geral <- reactive({
    df <- PERFIL_PAM_VERDE_C3_2026
    
    if (input$filtro_monitoria_geral != "Todos") {
      df <- df %>% dplyr::filter(Cidade == input$filtro_monitoria_geral)
    }
    
    df
  })
  
  output$grafico1 <- renderPlot({
    
    dados <- dados_geral()
    
    total_selecionadas <- nrow(dados)
    
    total_iniciaram <- dados %>%
      dplyr::filter(Status %in% c("Activa", "Desistente")) %>%
      nrow()
    
    grafico_df <- data.frame(
      Categoria = c("Selecionadas", "Iniciaram Formação"),
      Valor = c(total_selecionadas, total_iniciaram)
    ) %>%
      dplyr::mutate(
        Percentual = Valor / total_selecionadas,
        Label = paste0(
          Valor,
          "\n(",
          scales::percent(Percentual, accuracy = 1),
          ")"
        )
      )
    
    grafico_df$Categoria <- factor(
      grafico_df$Categoria,
      levels = c("Selecionadas", "Iniciaram Formação")
    )
    
    ggplot(grafico_df, aes(x = Categoria, y = Valor, fill = Categoria)) +
      
      geom_bar(stat = "identity", width = 0.6) +
      
      geom_text(
        aes(label = Label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 5
      ) +
      
      scale_fill_manual(values = c(
        "Selecionadas" = "#ff7f0e",
        "Iniciaram Formação" = "#8054A2"
      )) +
      
      labs(
        title = "Selecionadas vs Início da Formação",
        x = NULL,
        y = "Número de Empreendedoras"
      ) +
      
      theme_stata() +
      
      theme(
        plot.title = element_text(size = 14, face = "bold"),
        legend.position = "none",
        panel.background = element_rect(fill = "#f5f3f4", color = NA),
        plot.background = element_rect(fill = "#f5f3f4", color = NA)
      )
  })
  
  output$baixar_dados <- downloadHandler(
    filename = function() {
      paste0("dados_geral_", Sys.Date(), ".xlsx")
    },
    content = function(file) {
      write_xlsx(dados_geral(), path = file)
    }
  )
  
  output$grafico2 <- renderPlot({
    
    dados <- dados_geral()
    
    total_iniciaram <- dados %>%
      dplyr::filter(Status %in% c("Activa", "Desistente")) %>%
      nrow()
    
    total_activas <- dados %>%
      dplyr::filter(Status == "Activa") %>%
      nrow()
    
    total_desistentes <- dados %>%
      dplyr::filter(Status == "Desistente") %>%
      nrow()
    
    resumo <- data.frame(
      Categoria = c("Activas", "Desistentes"),
      Valor = c(total_activas, total_desistentes)
    ) %>%
      dplyr::mutate(
        Percentual = Valor / total_iniciaram,
        Label = paste0(
          Valor,
          " (",
          scales::percent(Percentual, accuracy = 1),
          ")"
        )
      )
    
    resumo$Categoria <- factor(
      resumo$Categoria,
      levels = c("Activas", "Desistentes")
    )
    
    ggplot(resumo, aes(x = "Iniciaram Formação", y = Valor, fill = Categoria)) +
      
      geom_bar(stat = "identity", width = 0.5) +
      
      geom_text(
        aes(label = Label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 5
      ) +
      
      scale_fill_manual(values = c(
        "Activas" = "#8054A2",
        "Desistentes" =  "#69C7BE"
      )) +
      
      labs(
        title = "Distribuição dos que Iniciaram a Formação",
        x = NULL,
        y = "Número de Empreendedoras",
        fill = "Status"
      ) +
      
      theme_stata() +
      
      theme(
        plot.title = element_text(size = 14, face = "bold"),
        panel.background = element_rect(fill = "#f5f3f4", color = NA),
        plot.background = element_rect(fill = "#f5f3f4", color = NA)
      )
  })
  
 ################### PRESENCAS NAS SESSÕES  
  
  dados_filtrados_coletiva <- reactive({
    
    df <- Presencas_Colectivas
    
    if (input$filtro_monitoria_presencas != "Todas") {
      df <- df %>% filter(Cidade == input$filtro_monitoria_presencas)
    }
    
    if (input$mentora_coletiva != "Todas") {
      df <- df %>% filter(Pesquisadores == input$mentora_coletiva)
    }
    
    df
  })
  
  dados_plot_coletivo <- reactive({
    
    df <- dados_filtrados_coletiva()
    previsto <- 50
    
    df <- df %>%
      mutate(across(starts_with("Sessao_"), ~sapply(., function(x) {
        if (is.null(x)) return(NA)
        if (is.list(x)) x <- unlist(x)
        paste0(x, collapse = ", ")
      })))
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    df_agg <- df_long %>%
      filter(str_detect(Presenca, "Presente")) %>%
      group_by(Sessoes) %>%
      summarise(Count = n(), .groups = "drop") %>%
      mutate(
        Previsto = previsto,
        Percentual = (Count / Previsto) * 100
      ) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = unique(Sessoes)[order(as.numeric(gsub("Sessao_", "", unique(Sessoes))))]
        )
      )
    
    df_agg
  })
  
  
  output$grafico_sessoes_col <- renderPlotly({
    
    df_agg <- dados_plot_coletivo()
    previsto <- df_agg$Previsto[1]
    
    limite_y <- max(c(df_agg$Count, previsto)) + 7
    
    g <- ggplot(df_agg, aes(x = Sessoes, y = Count, fill = Sessoes)) +
      geom_bar(stat = "identity") +
      
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        size = 1.2
      ) +
      
      geom_text(
        aes(
          label = paste0(Count, "\n(", round(Percentual, 1), "%)"),
          text = paste0(
            "Sessão: ", Sessoes,
            "<br>Presenças: ", Count,
            "<br>Percentual: ", round(Percentual, 1), "%"
          )
        ),
        vjust = 1.2,
        color = "black",
        size = 4,
        fontface = "bold"
      ) +
      
      theme_stata() +
      scale_y_continuous(limits = c(0, limite_y)) +
      labs(x = "", y = "Presenças", title = "Presenças por Sessão")
    
    ggplotly(g, tooltip = "text") %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  

  
  formatar_pontos <- function(x) {
    ifelse(is.na(x) | x == "",
           '<span style="color: gray; font-size: 40px;">&#9679;</span>',
           ifelse(x == "Presente",
                  '<span style="color: purple; font-size: 40px;">&#9679;</span>',
                  '<span style="color: red; font-size: 40px;">&#9679;</span>'))
  }
  
  
  output$tabela_presencas_col <- renderDataTable({
    
    df <- dados_filtrados_coletiva()
    
    col_sessoes <- grep("^Sessao_\\d+$", names(df), value = TRUE)
    col_sessoes_ordenadas <- col_sessoes[order(as.numeric(gsub("Sessao_", "", col_sessoes)))]
    
    col_fixas <- setdiff(names(df), col_sessoes)
    df <- df[, c(col_fixas, col_sessoes_ordenadas)]
    
    df[col_sessoes_ordenadas] <- lapply(df[col_sessoes_ordenadas], formatar_pontos)
    
    datatable(df, escape = FALSE, options = list(pageLength = 10))
  })
  
  
  # ==========================================================
  # WEBINARS (aba "Webinars" - Monitoria)
  # ==========================================================
  dados_filtrados_webinar <- reactive({
    
    df <- Webinars
    
    if (input$filtro_monitoria_webinar != "Todas") {
      df <- df %>% filter(Cidade == input$filtro_monitoria_webinar)
    }
    
    if (input$pesquisador_webinar != "Todas") {
      df <- df %>% filter(Pesquisadores == input$pesquisador_webinar)
    }
    
    df
  })
  
  
  dados_plot_webinar <- reactive({
    
    df <- dados_filtrados_webinar()
    previsto <- 50
    
    # garantir limpeza de listas/colunas complexas
    df <- df %>%
      mutate(across(starts_with("Sessao_"), ~ sapply(.x, function(x) {
        
        if (is.null(x)) return(NA_character_)
        if (is.list(x)) x <- unlist(x)
        
        paste(x, collapse = ", ")
        
      })))
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    df_agg <- df_long %>%
      filter(!is.na(Presenca) & str_detect(Presenca, "Presente")) %>%
      group_by(Sessoes) %>%
      summarise(Count = n(), .groups = "drop") %>%
      mutate(
        Previsto = previsto,
        Percentual = (Count / Previsto) * 100
      ) %>%
      mutate(
        Sessao_num = as.numeric(gsub("Sessao_", "", Sessoes))
      ) %>%
      arrange(Sessao_num) %>%
      mutate(
        Sessoes = factor(Sessoes, levels = Sessoes)
      ) %>%
      select(-Sessao_num)
    
    df_agg
  })
  
  
  output$grafico_webinar <- renderPlotly({
    
    df_agg <- dados_plot_webinar()
    previsto <- unique(df_agg$Previsto)[1]
    
    limite_y <- max(c(df_agg$Count, previsto), na.rm = TRUE) + 7
    
    g <- ggplot(df_agg, aes(x = Sessoes, y = Count, fill = Sessoes)) +
      geom_col() +
      
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        linewidth = 1.1
      ) +
      
      geom_text(
        aes(
          label = paste0(Count, "\n(", round(Percentual, 1), "%)"),
          text = paste0(
            "Sessão: ", Sessoes,
            "<br>Presenças: ", Count,
            "<br>Percentual: ", round(Percentual, 1), "%"
          )
        ),
        vjust = -0.2,
        color = "black",
        size = 4,
        fontface = "bold"
      ) +
      
      theme_stata() +
      scale_y_continuous(limits = c(0, limite_y)) +
      labs(x = "", y = "Presenças", title = "Presenças por Sessão (Webinars)")
    
    ggplotly(g, tooltip = "text") %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ==========================================================
  # Tabela (Webinars)
  # ==========================================================
  
  output$tabela_webinar <- renderDataTable({
    
    df <- dados_filtrados_webinar()
    
    col_sessoes <- grep("^Sessao_\\d+$", names(df), value = TRUE)
    col_sessoes_ordenadas <- col_sessoes[order(as.numeric(gsub("Sessao_", "", col_sessoes)))]
    
    col_fixas <- setdiff(names(df), col_sessoes)
    
    df <- df[, c(col_fixas, col_sessoes_ordenadas)]
    
    df[col_sessoes_ordenadas] <- lapply(df[col_sessoes_ordenadas], formatar_pontos)
    
    datatable(df, escape = FALSE, options = list(pageLength = 10))
  })
  
    # # # =========================
    # # # Financeiro
    # # # =========================
  
  criar_box <- function(valor, titulo, cor){
    
    div(
      class = paste("value-box", cor),
      
      div(
        class = "value-number",
        valor
      ),
      
      div(
        class = "value-title",
        titulo
      )
    )
    
  }
  
  df_financeiro <- reactive({
    
    df <- Financeiro_Report_Agregado
    
    # =========================
    # FILTRO PESQUISADOR
    # =========================
    if (!is.null(input$Pesquisador) && input$Pesquisador != "Todos") {
      df <- df %>%
        dplyr::filter(Nome_do_pesquisador == input$Pesquisador)
    }
    
    # =========================
    # FILTRO EMPREENDEDORA
    # =========================
    if (!is.null(input$Nome_Empreendedora) &&
        input$Nome_Empreendedora != "Todas") {
      
      df <- df %>%
        dplyr::filter(Nome_Empreendedora == input$Nome_Empreendedora)
    }
    
    # =========================
    # FILTRO MÊS (PERIODO)
    # =========================
    if (!is.null(input$Mes) && input$Mes != "Todos") {
      df <- df %>%
        dplyr::filter(Periodo == input$Mes)
    }
    
    df
  })
  
  
  output$vb_emp <- renderUI({
    criar_box(
      n_distinct(df_financeiro()$Nome_Empreendedora),
      "Empreendedoras",
      "purple"
    )
  })
  
  # output$vb_lucro <- renderUI({
  #   criar_box(
  #     comma(sum(df_financeiro()$Lucro_Mensal, na.rm = TRUE)),
  #     "Lucro Total",
  #     "green"
  #   )
  # })
  # 
  # output$vb_rendimento <- renderUI({
  #   criar_box(
  #     comma(sum(df_financeiro()$Rendimento_Total, na.rm = TRUE)),
  #     "Rendimento",
  #     "yellow"
  #   )
  # })
  # 
  # output$vb_custos <- renderUI({
  #   
  #   total <- sum(df_financeiro()$Custo_Operacional_Total, na.rm = TRUE) +
  #     sum(df_financeiro()$Custo_Produtos_Total, na.rm = TRUE)
  #   
  #   criar_box(
  #     comma(total),
  #     "Custos",
  #     "orange"
  #   )
  # })
  # 
  
  output$cidade_plot <- renderPlotly({
    
    df <- df_financeiro()
    
    resumo <- data.frame(
      Indicador = c("Lucro", "Rendimento", "Custos"),
      Valor = c(
        sum(df$Lucro_Mensal, na.rm = TRUE),
        sum(df$Rendimento_Total, na.rm = TRUE),
        sum(df$Custo_Operacional_Total, na.rm = TRUE) +
          sum(df$Custo_Produtos_Total, na.rm = TRUE)
      )
    )
    
    g <- ggplot(resumo, aes(x = Indicador, y = Valor, fill = Indicador)) +
      geom_col(width = 0.6) +
      
      # =========================
    # CORES MANUAIS
    # =========================
    scale_fill_manual(values = c(
      "Lucro" = "#8054A2",       
      "Rendimento" = "#f9a825",   
      "Custos" = "#69C7BE"      
    )) +
      
      geom_text(
        aes(label = comma(round(Valor, 0))),
        vjust = -0.3,
        fontface = "bold",
        size = 4
      ) +
      
      theme_minimal() +
      theme(
        legend.position = "none"
      ) +
      labs(
        x = "",
        y = "Total",
        title = "Resumo Financeiro"
      )
    
    ggplotly(g, tooltip = c("x", "y")) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
  })
  
  
  
  
  output$grafico_financeiro <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      group_by(Semanas) %>%
      summarise(
        Lucro = sum(Lucro_Semanal, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      mutate(
        Semanas = factor(
          Semanas,
          levels = c(
            "Primeira Semana",
            "Segunda Semana",
            "Terceira Semana",
            "Quarta Semana",
            "Quinta Semana"
          )
        )
      ) %>%
      arrange(Semanas)
    
    # deslocamento para texto ficar acima dos pontos
    desloc <- max(df_plot$Lucro, na.rm = TRUE) * 0.08
    
    g <- ggplot(df_plot, aes(x = Semanas, y = Lucro, group = 1)) +
      
      geom_area(fill = "#8054A2", alpha = 0.15) +
      
      geom_line(color = "#8054A2", linewidth = 1.3) +
      
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      # VALORES NOS PONTOS (ACIMA)
      geom_text(
        aes(y = Lucro + desloc,
            label = scales::comma(Lucro)),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(x = "", y = "Lucro (MT)") +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(mult = c(0.05, 0.25))
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color = "#E0E0E0"),
        
        axis.text = element_text(color = "#333333"),
        axis.title = element_text(face = "bold")
      )
    
    ggplotly(g, tooltip = "text") %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
  })
  
  output$grafico_barras_semanas <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      group_by(Semanas) %>%
      summarise(
        Lucro = sum(Lucro_Mensal, na.rm = TRUE),
        Rendimento = sum(Rendimento_Total, na.rm = TRUE),
        Custo_Operacional = sum(Custo_Operacional_Total, na.rm = TRUE),
        Custo_Produto = sum(Custo_Produtos_Total, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      mutate(
        Semanas = factor(
          Semanas,
          levels = c(
            "Primeira Semana",
            "Segunda Semana",
            "Terceira Semana",
            "Quarta Semana",
            "Quinta Semana"
          )
        )
      )
    
    df_long <- df_plot %>%
      tidyr::pivot_longer(
        cols = c(Lucro, Rendimento, Custo_Operacional, Custo_Produto),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    dodge <- position_dodge(width = 0.8)
    
    p <- ggplot(df_long, aes(x = Semanas, y = Valor, fill = Indicador)) +
      
      geom_col(position = dodge, width = 0.7) +
      
      # ✔ VALORES NO MEIO DAS BARRAS
      geom_text(
        aes(label = scales::comma(round(Valor, 0))),
        position = dodge,
        vjust = 0.5,
        color = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Lucro" = "#8054A2",
          "Rendimento" = "#f9a825",
          "Custo_Operacional" = "#69C7BE",
          "Custo_Produto" = "#f77333"
        )
      ) +
      
      labs(
        x = "",
        y = "Valores (MT)",
        fill = ""
      ) +
      
      theme_stata(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color = "#E0E0E0")
      )
    
    ggplotly(p) %>%
      
      layout(
        barmode = "group",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
  })
  
  df_semana <- reactive({
    
    Financeiro_Report_Agregado %>%
      mutate(
        Semanas = factor(
          Semanas,
          levels = c(
            "Primeira Semana",
            "Segunda Semana",
            "Terceira Semana",
            "Quarta Semana",
            "Quinta Semana"
          )
        )
      ) %>%
      arrange(Semanas)
  })
  
  # crescimento_semana <- reactive({
  #   
  #   df <- df_semana()
  #   
  #   df2 <- df %>%
  #     mutate(
  #       lucro_anterior = lag(Lucro_Semanal),
  #       crescimento = (Lucro_Semanal - lucro_anterior) / (abs(lucro_anterior) + 1)
  #     )
  #   
  #   paste0(round(mean(df2$crescimento, na.rm = TRUE) * 100, 1), "%")
  # })
  # 
  # 
  # aumento_lucro_semana <- reactive({
  #   
  #   df <- df_semana()
  #   
  #   sum(df$Lucro_Semanal > 0, na.rm = TRUE)
  # })
  # 
  # 
  # aumento_25_semana <- reactive({
  #   
  #   df <- df_semana()
  #   
  #   df2 <- df %>%
  #     mutate(
  #       lucro_anterior = lag(Lucro_Semanal),
  #       crescimento = (Lucro_Semanal - lucro_anterior) / (abs(lucro_anterior) + 1)
  #     )
  #   
  #   sum(df2$crescimento > 0.25, na.rm = TRUE)
  # })
  # 
  
  
  
  output$grafico_mensal <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      group_by(Periodo) %>%
      summarise(Lucro = sum(Lucro_Mensal, na.rm = TRUE), .groups = "drop") %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c("Primeiro Mês", "Segundo Mês", "Terceiro Mês")
        )
      ) %>%
      arrange(Periodo)
    
    desloc <- max(df_plot$Lucro, na.rm = TRUE) * 0.07
    
    g <- ggplot(df_plot, aes(x = Periodo, y = Lucro, group = 1)) +
      
      # ÁREA (igual ao semanal)
      geom_area(fill = "#8054A2", alpha = 0.15) +
      
      # LINHA
      geom_line(color = "#8054A2", linewidth = 1.3) +
      
      # PONTOS
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      # VALORES ACIMA DOS PONTOS
      geom_text(
        aes(y = Lucro + desloc,
            label = scales::comma(Lucro)),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(x = "", y = "Lucro (MT)") +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(mult = c(0.05, 0.25))
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color = "#E0E0E0")
      )
    
    ggplotly(g, tooltip = "text") %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
  })
  
  output$grafico_barras <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      group_by(Periodo) %>%
      summarise(
        Lucro = sum(Lucro_Mensal, na.rm = TRUE),
        Rendimento = sum(Rendimento_Total, na.rm = TRUE),
        Custo_Operacional = sum(Custo_Operacional_Total, na.rm = TRUE),
        Custo_Produto = sum(Custo_Produtos_Total, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c("Primeiro Mês", "Segundo Mês", "Terceiro Mês")
        )
      )
    
    df_long <- df_plot %>%
      tidyr::pivot_longer(
        cols = c(Lucro, Rendimento, Custo_Operacional, Custo_Produto),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    dodge <- position_dodge(width = 0.8)
    
    p <- ggplot(df_long, aes(x = Periodo, y = Valor, fill = Indicador)) +
      
      geom_col(position = dodge, width = 0.7) +
      
      # ✔ VALORES CENTRADOS NAS BARRAS
      geom_text(
        aes(label = scales::comma(round(Valor, 0))),
        position = dodge,
        vjust = 0.5,
        color = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Lucro" = "#8054A2",
          "Rendimento" = "#f9a825",
          "Custo_Operacional" = "#69C7BE",
          "Custo_Produto" = "#f77333"
        )
      ) +
      
      labs(
        x = "",
        y = "Valores (MT)",
        fill = ""
      ) +
      
      theme_stata(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color = "#E0E0E0")
      )
    
    ggplotly(p) %>%
      
      layout(
        barmode = "group",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
  })
  
  
  output$vb_aumento_lucro_semana <- renderUI({
    
    df <- Financeiro_Report_Agregado %>%
      mutate(
        Semanas = factor(
          Semanas,
          levels = c(
            "Primeira Semana",
            "Segunda Semana",
            "Terceira Semana",
            "Quarta Semana",
            "Quinta Semana"
          )
        )
      ) %>%
      arrange(Nome_Empreendedora, Semanas) %>%
      
      group_by(Nome_Empreendedora) %>%
      
      mutate(
        lucro_anterior = lag(Lucro_Semanal),
        aumento = Lucro_Semanal > lucro_anterior
      ) %>%
      
      ungroup()
    
    valor <- df %>%
      filter(!is.na(lucro_anterior)) %>%
      summarise(total = sum(aumento, na.rm = TRUE)) %>%
      pull(total)
    
    div(
      class = "value-box blue",
      
      span(class = "value-number", valor),
      span(class = "value-title", "Participantes com Aumento de Lucro")
    )
  })
  
  output$vb_aumento_25_semana <- renderUI({
    
    df <- Financeiro_Report_Agregado %>%
      
      # 1. garantir nível SEMANAL por participante
      group_by(Nome_Empreendedora, Semanas) %>%
      summarise(
        Lucro_Semanal = sum(Lucro_Semanal, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      
      # 2. ordem correta das semanas
      mutate(
        Semanas = factor(
          Semanas,
          levels = c(
            "Primeira Semana",
            "Segunda Semana",
            "Terceira Semana",
            "Quarta Semana",
            "Quinta Semana"
          )
        )
      ) %>%
      arrange(Nome_Empreendedora, Semanas) %>%
      
      # 3. cálculo por participante
      group_by(Nome_Empreendedora) %>%
      mutate(
        lucro_anterior = lag(Lucro_Semanal),
        
        crescimento_pct = (Lucro_Semanal - lucro_anterior) /
          abs(lucro_anterior) * 100,
        
        aumento_25 = crescimento_pct >= 25
      ) %>%
      ungroup()
    
    # 4. PARTICIPANTES ÚNICAS com pelo menos 1 aumento ≥ 25%
    valor <- df %>%
      filter(!is.na(aumento_25)) %>%
      group_by(Nome_Empreendedora) %>%
      summarise(
        teve_aumento_25 = any(aumento_25, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      summarise(total = sum(teve_aumento_25)) %>%
      pull(total)
    
    # 5. garantir valor limpo para UI
    valor <- as.numeric(valor)
    
    div(
      class = "value-box orange",
      span(class = "value-number", format(valor, big.mark = ",")),
      span(class = "value-title", "Participantes com aumento ≥ 25% (Semanal)")
    )
  })
  
  output$vb_aumento_lucro_mes <- renderUI({
    
    df <- Financeiro_Report_Agregado %>%
      group_by(Nome_Empreendedora, Periodo) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c("Primeiro Mês", "Segundo Mês", "Terceiro Mês")
        )
      ) %>%
      arrange(Nome_Empreendedora, Periodo) %>%
      group_by(Nome_Empreendedora) %>%
      mutate(
        lucro_anterior = lag(Lucro_Mensal),
        aumento = Lucro_Mensal > lucro_anterior
      ) %>%
      ungroup()
    
    valor <- df %>%
      filter(!is.na(lucro_anterior)) %>%
      group_by(Nome_Empreendedora) %>%
      summarise(
        teve_aumento = any(aumento, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      summarise(total = sum(teve_aumento)) %>%
      pull(total)
    
    div(
      class = "value-box blue",
      span(class = "value-number", valor),
      span(class = "value-title", "Participantes com Aumento de Lucro")
    )
  })
  
  
  output$vb_aumento_25_mes <- renderUI({
    
    df <- Financeiro_Report_Agregado %>%
      
      # 1. garantir nível mensal (evita problema de semanas)
      group_by(Nome_Empreendedora, Periodo) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      
      # 2. ordenar meses corretamente
      mutate(
        Periodo = factor(
          Periodo,
          levels = c("Primeiro Mês", "Segundo Mês", "Terceiro Mês")
        )
      ) %>%
      arrange(Nome_Empreendedora, Periodo) %>%
      
      group_by(Nome_Empreendedora) %>%
      mutate(
        lucro_anterior = lag(Lucro_Mensal),
        aumento_pct = (Lucro_Mensal - lucro_anterior) / lucro_anterior * 100,
        aumento_25 = aumento_pct >= 25
      ) %>%
      ungroup()
    
    valor <- df %>%
      filter(!is.na(aumento_25)) %>%
      group_by(Nome_Empreendedora) %>%
      summarise(
        teve_aumento_25 = any(aumento_25, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      summarise(total = sum(teve_aumento_25)) %>%
      pull(total)
    
    div(
      class = "value-box orange",
      span(class = "value-number", valor),
      span(class = "value-title", "Participantes com aumento ≥ 25%")
    )
  })
  
  output$tabela_financeira <- renderDT({
    
    datatable(
      df_financeiro(),
      extensions = "Buttons",
      options = list(
        dom = "Bfrtip",
        buttons = c("copy", "csv", "excel"),
        pageLength = 15,
        scrollX = TRUE
      )
    )
  })
    
  ########### BOTAO
  # # Painel de atualização de dados (sem login)
  output$admin_ui <- renderUI({
    sidebarLayout(
      sidebarPanel(
        actionButton("botao_atualizar", "📥 Carregar/Actualizar Dados", class = "btn btn-warning")
      ),
      mainPanel(
        tags$h5("Clique no botão à esquerda para actualizar os dados do sistema."),
        verbatimTextOutput("status_atualizacao")
      )
    )
  })

  # Função principal de atualização
  atualiza_dados <- function() {
    tryCatch({
      # Autenticação com Zoho
      client_id <- Sys.getenv("CLIENT_ID")
      client_secret <- Sys.getenv("CLIENT_SECRET")
      refresh_token <- Sys.getenv("REFRESH_TOKEN")

      access_token <- RZohoCreator::refresh_access_token(
        client_id, client_secret, refresh_token
      )$access_token

      ## 1. Presenças Coletivas
      Presencas_colectivas <- RZohoCreator::get_records(
        "associacaomuva", "monitoria", "Presen_as_PAM_VERDE_Report", access_token
      ) %>%
        data.frame()


      write_xlsx(Presencas_colectivas, "Presencas_colectivas.xlsx")

      # ## 2. Presenças Individuais
      # Presencas_Individuais <- RZohoCreator::get_records(
      #   "associacaomuva", "monitoria", "Presen_as_Individuais_PAM_Report", access_token
      # ) %>%
      #   data.frame()
      # 
      # write_xlsx(Presencas_Individuais, "Presencas_Individuais.xlsx")

      ## 3. Dados Financeiros
      Financeiro_Report <- RZohoCreator::get_records(
        "associacaomuva", "app-empreendedorismo", "Dados_Financeiros_Report", access_token
      )

      write_xlsx(Financeiro_Report, "Financeiro_Report.xlsx")

      # # ## 4. Recursos Humanos
      # RH_Empreendedoras <- RZohoCreator::get_records(
      #   "associacaomuva", "app-empreendedorismo", "RH_Empreendedoras_Report", access_token
      # ) %>%
      #   data.frame()
      # 
      # 
      # write_xlsx(RH_Empreendedoras, "RH_Empreendedoras.xlsx")

      ## Retornar os objetos (opcional)
      return(list(
        # dados = dados,
        # Presencas_Individuais = Presencas_Individuais,
        Financeiro_Report = Financeiro_Report
        # RH_Empreendedoras = RH_Empreendedoras
      ))
    }, error = function(e) {
      message("Erro ao atualizar dados: ", e$message)
      return(NULL)
    })
  }
  #
  # # Evento ao clicar no botão
  dados_atualizados <- eventReactive(input$botao_atualizar, {
    # Criar log da ação
    log_entry <- data.frame(
      usuario = "admin",  # como não há mais login, colocar fixo
      acao = "Atualizou os dados",
      hora = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
      stringsAsFactors = FALSE
    )

    # Ler e combinar com logs antigos
    if (file.exists("log_acoes.xlsx")) {
      log_existente <- readxl::read_excel("log_acoes.xlsx")
      log_total <- dplyr::bind_rows(log_existente, log_entry)
    } else {
      log_total <- log_entry
    }

    # Salvar o novo log
    writexl::write_xlsx(log_total, path = "log_acoes.xlsx")

    # Rodar atualização
    atualiza_dados()
  })

  # Mensagem de status
  output$status_atualizacao <- renderText({
    if (input$botao_atualizar > 0) {
      if (!is.null(dados_atualizados())) {
        paste0(
          "✅ Dados actualizados com sucesso em ",
          format(Sys.time(), "%d/%m/%Y %H:%M:%S"),
          ". Por favor, actualize (refresh) a página no navegador para ver as mudanças."
        )
      } else {
        "⚠️ Erro ao actualizar os dados. Verifique o log."
      }
    } else {
      "⏳ Aguardando actualização..."
    }
  })
  
}




# ==========================================================
# RODAR APP
# ==========================================================
shinyApp(ui, server)
