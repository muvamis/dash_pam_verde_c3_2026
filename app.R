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
            
            fluidRow(
              column(
                6,
                tags$h4("Negócios liderados por mulheres"),
                plotlyOutput("grafico_participantes")
              ),
              column(
                6,
                tags$h4("Faixas etárias das empreendedoras"),
                plotlyOutput("grafico_idade")
              )
            ),
            
            fluidRow(
              column(
                6,
                tags$h4("Ano de criação do negócio"),
                plotlyOutput("grafico_Ano_Negocio")
              ),
              column(
                6,
                tags$h4("Sector dos negócios"),
                plotlyOutput("grafico_setor")
              )
            ),
            
            fluidRow(
              column(
                6,
                tags$h4("O seu negócio está formalizado?"),
                plotlyOutput("grafico_formalizacao")
              ),
              column(
                6,
                tags$h4(""),
                plotlyOutput("grafico_servicos_financeiros_")
              )
            )
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
                tags$h4("Retira regularmente um salário para si mesma?"),
                plotlyOutput("grafico_tira_salario")
              ),
              column(
                6,
                tags$h4("Utiliza actualmente algum dos seguintes serviços financeiros para o seu negócio?"),
                plotlyOutput("grafico_servicos_financeiros")
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
              column(6, plotlyOutput("grafico_triang_empilhado")),
              column(6, plotlyOutput("grafico_agregado_familiar"))
            )
          ),
          
          # =========================
          # ABA 4
          # =========================
          tabPanel(
            "Habilidades & Processos",
            
            fluidRow(
              column(6, plotlyOutput("grafico_control_dinheiro")),
              column(6, plotlyOutput("grafico_separacao_contas"))
            ),
            
            br(),
            
            fluidRow(
              tags$h4(""),
              column(6, plotlyOutput("grafico_calcular_Lucro")),
              tags$h4(""),
              column(6, plotlyOutput("grafico_sal"))
            )
          ),
          
          # =========================
          # ABA 5
          # =========================
          tabPanel(
            "Posicionamento & Mercado",
            
            fluidRow(
              column(6, plotlyOutput("grafico_canais")),
              column(6, plotlyOutput("grafico_Parceria"))
            )
          ),
          
          # =========================
          # ABA 6
          # =========================
          tabPanel(
            "Consciência de Gênero",
            
            fluidRow(
              column(6, plotlyOutput("grafico_Dif_Baseline")),
              column(6, plotlyOutput("grafico_Dif_Endline"))
            )
          ),
          
          # =========================
          # ABA 7
          # =========================
          tabPanel(
            "Consciência Ambiental",
            
            fluidRow(
              tags$h4("Pegada de carbono"),
              column(6, plotlyOutput("graficoPontuacao")),
              column(6, plotlyOutput("grafico_Classicacao_Endline"))
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
                
                div(
                  class = "value-box-container",
                  uiOutput("vb_crescimento_semana"),
                  uiOutput("vb_aumento_lucro_semana"),
                  uiOutput("vb_aumento_25_semana")
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "Desempenho Semanal",
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
  
  tabPanel(
    tagList(icon("chart-line"), "Avaliação_Beira_C1"),
    fluidPage(
      uiOutput("ad")
    )
  ),
  
  tabPanel(
    tagList(icon("clipboard-check"), "Monitoria_Beira_C1"),
    fluidPage(
      uiOutput("adrrr")
    )
  ),
  
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
  
  #################### Negociacao_Com_Agregado_Familiar
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
  #################################### Negociacao_Com_Clientes
  
  output$grafico_clientes <- renderPlotly({
    
    df <- dados_filtrados()
    
    req("Negociacao_Com_Clientes" %in% colnames(df))
    req(nrow(df) > 0)
    
    df_resumo <- df %>%
      group_by(Negociacao_Com_Clientes) %>%
      summarise(Total = n(), .groups = "drop") %>%
      mutate(
        Percent = round(Total / sum(Total) * 100, 1),
        label = paste0(Total, " (", Percent, "%)"),
        Negociacao_Com_Clientes = factor(
          Negociacao_Com_Clientes,
          levels = c(
            "Não me sinto confiante/ não sei negociar",
            "Depende /de certa forma",
            "Sim, sinto-me confiantee sei defender a minha posição"
          )
        )
      )
    
    plot_ly(
      data = df_resumo,
      x = ~Negociacao_Com_Clientes,
      y = ~Total,
      type = "bar",
      text = ~label,
      textposition = "auto",
      marker = list(color = "#9442d4")
    ) %>%
      layout(
        title = "Negociação com clientes",
        xaxis = list(title = ""),
        yaxis = list(title = "Número de participantes"),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  # ##----------------------------------------------------------- 
  # ###################                  3 PAGINA Habilidades e Processos
  # ##-----------------------------------------------------------------------------  
  output$grafico_control_dinheiro <- renderPlotly({
    
    df <- Pam_Verde_Indicadores %>%
      count(`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`) %>%
      mutate(
        perc = round(n / sum(n) * 100, 1)
      )
    
    plot_ly(
      df,
      labels = ~`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`,
      values = ~n,
      type = "pie",
      textinfo = "label+value+percent",
      hoverinfo = "label+value+percent",
      marker = list(
        colors = c("#69C7BE", "#F37238")  
      )
    ) %>%
      layout(
        title = "Controlo de receitas e despesas",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  
  output$grafico_separacao_contas <- renderPlotly({
    
    df <- Pam_Verde_Indicadores %>%
      count(`Faz separação das contas pessoais e do negócio`) %>%
      mutate(
        perc = round(n / sum(n) * 100, 1)
      )
    
    plot_ly(
      df,
      labels = ~`Faz separação das contas pessoais e do negócio`,
      values = ~n,
      type = "pie",
      textinfo = "label+value+percent",
      hoverinfo = "label+value+percent",
      marker = list(
        colors = c("#69C7BE", "#F37238")  
      )
    ) %>%
      layout(
        title = "Separação das contas pessoais e do negócio",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$grafico_calcular_Lucro <- renderPlotly({
    
    df <- Pam_Verde_Indicadores %>%
      count(`Sabe calcular o lucro do negócio  (com base no exercício prático)`) %>%
      mutate(
        perc = round(n / sum(n) * 100, 1)
      )
    
    plot_ly(
      df,
      labels = ~`Sabe calcular o lucro do negócio  (com base no exercício prático)`,
      values = ~n,
      type = "pie",
      textinfo = "label+value+percent",
      hoverinfo = "label+value+percent",
      marker = list(
        colors = c("#69C7BE", "#F37238")  
      )
    ) %>%
      layout(
        title = "Sabe calcular o lucro do negócio",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  output$grafico_canais <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # -----------------------------
    # 1. TRATAMENTO (MULTI-RESPOSTA)
    # -----------------------------
    df_canais <- df %>%
      
      separate_rows(
        `Onde vende actualmente os seus produtos ou serviços?`,
        sep = ","
      ) %>%
      
      mutate(
        canal = str_trim(`Onde vende actualmente os seus produtos ou serviços?`)
      ) %>%
      
      filter(!is.na(canal), canal != "")
    
    # -----------------------------
    # 2. FREQUÊNCIAS + %
    # -----------------------------
    freq_data <- df_canais %>%
      count(canal, sort = TRUE) %>%
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(n, " (", pct, "%)")
      )
    
    # -----------------------------
    # 3. GRÁFICO (BARRAS)
    # -----------------------------
    plot_ly(
      freq_data,
      x = ~reorder(canal, n),
      y = ~n,
      type = "bar",
      text = ~label,
      textposition = "outside",
      hoverinfo = "text"
    ) %>%
      
      layout(
        title = "Canais de Venda Utilizados",
        xaxis = list(title = "", tickangle = -30),
        yaxis = list(title = "Número de respostas"),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
 
  # 
  # ##########################PEGADA DE CARBONO######################
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
      "PEGADA MÉDIA" = "#69C7BE",
      "PEGADA ALTA"  = "#F37238"
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
  
  crescimento_semana <- reactive({
    
    df <- df_semana()
    
    df2 <- df %>%
      mutate(
        lucro_anterior = lag(Lucro_Semanal),
        crescimento = (Lucro_Semanal - lucro_anterior) / (abs(lucro_anterior) + 1)
      )
    
    paste0(round(mean(df2$crescimento, na.rm = TRUE) * 100, 1), "%")
  })
  
  
  aumento_lucro_semana <- reactive({
    
    df <- df_semana()
    
    sum(df$Lucro_Semanal > 0, na.rm = TRUE)
  })
  
  
  aumento_25_semana <- reactive({
    
    df <- df_semana()
    
    df2 <- df %>%
      mutate(
        lucro_anterior = lag(Lucro_Semanal),
        crescimento = (Lucro_Semanal - lucro_anterior) / (abs(lucro_anterior) + 1)
      )
    
    sum(df2$crescimento > 0.25, na.rm = TRUE)
  })
  
  
  
  
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
