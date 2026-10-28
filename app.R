

ui <- navbarPage(
  title = "PAM_VERDE",
  
  
  # ------------------ Estilo e Tema ------------------
  header = tags$head(
    tags$head(
  tags$style(HTML("
    #filtro_tema_qualitativo .btn {
      border-color: #8054A2 !important;
      color: #8054A2 !important;
      background-color: #ffffff !important;
      margin: 3px;
      border-radius: 6px !important;
    }

    #filtro_tema_qualitativo .btn.active,
    #filtro_tema_qualitativo .btn:active {
      background-color: #8054A2 !important;
      border-color: #8054A2 !important;
      color: #ffffff !important;
    }

    #filtro_tema_qualitativo .btn:hover {
      background-color: #9442d4 !important;
      border-color: #9442d4 !important;
      color: #ffffff !important;
    }
  "))
),

    # Biblioteca para guardar tabelas como imagem PNG
    tags$script(
      src = "https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"
    ),
    
    # Estilos da dashboard
    tags$style(HTML("

      /* =========================
         NAVBAR
      ========================== */
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
         TEXTO DOS KPI
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
         TABELAS TOC
      ========================== */
      table.dataTable {
        font-size: 10px !important;
        border-collapse: collapse !important;
      }

      table.dataTable thead th {
        font-size: 10px !important;
        padding: 5px 4px !important;
        white-space: normal !important;
        overflow-wrap: break-word !important;
        text-align: center !important;
        vertical-align: middle !important;
        line-height: 1.2 !important;
      }

      table.dataTable tbody td {
        font-size: 10px !important;
        padding: 4px 5px !important;
        vertical-align: middle !important;
        line-height: 1.25 !important;
        white-space: normal !important;
        overflow-wrap: break-word !important;
      }

      /* Indicador: texto dentro da própria coluna */
      table.dataTable thead th:nth-child(2),
      table.dataTable tbody td:nth-child(2) {
        text-align: left !important;
        white-space: normal !important;
        overflow-wrap: anywhere !important;
        word-break: normal !important;
        font-size: 14px !important;
        line-height: 1.25 !important;
      }

      /* Valores numéricos */
      table.dataTable thead th:nth-child(n+3),
      table.dataTable tbody td:nth-child(n+3) {
        text-align: center !important;
        font-size: 12px !important;
        font-variant-numeric: tabular-nums;
      }

      /* Estado */
      table.dataTable tbody td:last-child {
        white-space: normal !important;
        overflow-wrap: break-word !important;
        text-align: center !important;
      }

      /* Pesquisa, paginação e controlos */
      .dataTables_wrapper .dataTables_filter,
      .dataTables_wrapper .dataTables_length,
      .dataTables_wrapper .dataTables_info,
      .dataTables_wrapper .dataTables_paginate {
        font-size: 10px !important;
      }

      .dataTables_wrapper {
        width: 100% !important;
        max-width: 100% !important;
      }

      /* =========================
         BOTÕES PNG E FULL SCREEN
      ========================== */
      .toc-botoes-personalizados {
        display: flex !important;
        gap: 8px !important;
        flex-wrap: wrap !important;
        margin: 10px 0 !important;
      }

      .toc-botoes-personalizados button {
        font-size: 12px !important;
        font-weight: bold !important;
        padding: 8px 12px !important;
        border: none !important;
        border-radius: 6px !important;
        cursor: pointer !important;
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

    ")),
    
    # Alternância de idioma PT/EN
    tags$script(src = "i18n/i18n.js")
  ),
  
  
  
  # ==========================================================
  # PÁGINA 1 - INDICADORES_CICLO3
  # ==========================================================
  tabPanel(
    tagList(icon("chart-line"), "Avaliação_Nampula_Beira"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "filtro_cidade",
          "Selecionar Cidade:",
          choices = c("Todas", unique(Pam_Verde_Indicadores$Cidade)),
          selected = "Todas"
        ),
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
            fluidRow(
              column(
                12,
                div(
                  style = "
              background-color:#f5f3f4;
              padding:18px 22px;
              border-radius:8px;
              margin-bottom:20px;
              border-left:5px solid #9442d4;
            ",
                  
                  h4(
                    "Avaliação das Empreendedoras – Nampula e Beira",
                    style = "color:#9442d4; margin-top:0;"
                  ),
                  
                  p(
                    "A avaliação contempla as empreendedoras participantes do programa 
              nas cidades de Nampula e Beira, considerando os dados recolhidos 
              no Baseline e no Endline."
                  ),
                  
                  p(
                    "No Baseline, participaram 49 empreendedoras em Nampula e 36 
              em Beira. No Endline, participaram 30 empreendedoras em Nampula 
              e na Beira a formação ainda esta a decorrer."
                  ),
                  
                  p(
                    "Para a análise da evolução das empreendedoras ao longo do programa, 
              estamos a considerar aquelas que realizaram tanto o Baseline como 
              o Endline. Desta forma, a análise permite comparar os resultados 
              das mesmas participantes nos dois momentos de avaliação."
                  ),
                  
                  p(
                    strong("Nota: "),
                    "os resultados apresentados nas análises comparativas consideram 
              apenas as empreendedoras que possuem informação nos dois momentos 
              de avaliação."
                  )
                )
              )
            ),
            br(),
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
                12,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_servicos")
                ),
                # DT::DTOutput("tabela_novos_servicos_financeiros"),
                br(),
                plotlyOutput("grafico_servicos_financeiros")
              )
            ),
            # fluidRow(
            #   
            # #   column(
            # #     12,
            # #     div(
            # #       style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
            # #       uiOutput("texto_servicos")
            # #     ),
            # #     plotlyOutput("grafico_servicos_financeiros")
            # #   )
            # # ),
            # 
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
              column(6,
                     div(
                       style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                       uiOutput("texto_local_venda")
                     ),
                     div(
                       style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                       DTOutput("tabela_local_venda")
                     )),
              tags$h4(""),
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_formalizacao")
                ),
                plotlyOutput("grafico_formalizacao")
              )
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
                  uiOutput("texto_negociacao_3meses")
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
          
         
          
          # =========================
          # ABA 6
          # =========================
          
          tabPanel(
            "Gênero",
            
            tabsetPanel(
              id = "subtab_genero",
              type = "tabs",
              
              # ==========================================================
              # TAB 1 - CONSCIÊNCIA DE GÊNERO
              # Mantém os gráficos e textos já existentes
              # ==========================================================
              
              tabPanel(
                "Consciência de Gênero",
                
                fluidRow(
                  column(
                    6,
                    div(
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
                      uiOutput("texto_H_Financeiros")
                    ),
                    plotlyOutput("grafico_H_Financeiro_Faci")
                  ),
                  
                  column(
                    6,
                    div(
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
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
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
                      uiOutput("texto_H_Capazes")
                    ),
                    plotlyOutput("grafico_H_Capazes")
                  ),
                  
                  column(
                    6,
                    div(
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
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
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
                      uiOutput("texto_M_Gerir")
                    ),
                    plotlyOutput("grafico_M_Gerir")
                  ),
                  
                  column(
                    6,
                    div(
                      style = "background-color:#f5f3f4; padding:12px;
                     border-radius:6px; margin-bottom:20px;",
                      uiOutput("texto_genero_extra")
                    ),
                    plotlyOutput("grafico_sa")
                  )
                )
              ),
              
              # ==========================================================
              # TAB 2 - DADOS QUALITATIVOS DE GÊNERO
              # Novas análises das perguntas abertas
              # ==========================================================
              
              tabPanel(
                "Qualitativo Gênero",
                
                br(),
                
                # Resumo da análise qualitativa
                
                # ==========================================================
                # AVALIAÇÃO DAS ACTIVIDADES DE GÉNERO — MUVA
                # ==========================================================
                
                fluidRow(
                  column(
                    width = 12,
                    
                    div(
                      style = "
        background-color:#eef4fb;
        border-left:5px solid #8054A2;
        padding:20px;
        border-radius:6px;
        margin-bottom:25px;
      ",
                      
                      # Título principal
                      tags$p(
                        style = "
          margin-top:0;
          margin-bottom:8px;
          color:#8054A2;
          font-size:13px;
          font-weight:600;
          letter-spacing:0.5px;
        ",
                        "AVALIAÇÃO DAS ACTIVIDADES DE GÉNERO · MUVA · CICLO CONCLUÍDO"
                      ),
                      
                      tags$h2(
                        style = "
          margin-top:0;
          margin-bottom:12px;
          color:#333333;
          font-weight:700;
          font-size:26px;
        ",
                        "O que mudou para as participantes"
                      ),
                      
                      tags$p(
                        style = "
          color:#444444;
          font-size:15px;
          line-height:1.7;
          margin-bottom:18px;
        ",
                        paste0(
                          "Resultados de duas perguntas feitas às 60 participantes ",
                          "que concluíram o ciclo: em que medida as actividades ",
                          "ajudaram a compreender as desigualdades entre homens ",
                          "e mulheres, e o que colocaram em prática depois dessas actividades."
                        )
                      ),
                      
                      # Indicadores de contexto
                      fluidRow(
                        column(
                          width = 4,
                          uiOutput("contexto_participantes_genero")
                        ),
                        column(
                          width = 4,
                          uiOutput("contexto_perguntas_genero")
                        ),
                        column(
                          width = 4,
                          uiOutput("contexto_filtros_genero")
                        )
                      )
                    )  
                  )     
                ),       
                
                # ==========================================================
                # RESUMO DA ANÁLISE QUALITATIVA
                # ==========================================================
                
                fluidRow(
                  column(
                    width = 12,
                    
                    div(
                      class = "value-box-container",
                      
                      uiOutput("box_avaliacao_positiva"),
                      uiOutput("box_praticas"),
                      uiOutput("box_casa"),
                      uiOutput("box_autoconfianca")
                    )
                  )
                ),
     
                
                br(),
                
                # Esferas de mudança e temas
                fluidRow(
                  
                  column(
                    6,
                    div(
                      style = "background-color:#f5f3f4; padding:16px;
             border-radius:8px; margin-bottom:20px;",
                      
                      h4(
                        style = "color:#333333; font-weight:700;",
                        ""
                      ),
                      
                      # Legenda com tons de roxo
                      div(
                        style = "display:flex; flex-wrap:wrap; gap:10px;
               margin:12px 0 18px 0; font-size:12px;",
                        
                        div(
                          style = "display:flex; align-items:center; gap:5px;",
                          span(style = "width:12px; height:12px; background:#6A1B9A;
                     display:inline-block; border-radius:3px;"),
                          span("Ajudaram bastante")
                        ),
                        
                        div(
                          style = "display:flex; align-items:center; gap:5px;",
                          span(style = "width:12px; height:12px; background:#7E3FB2;
                     display:inline-block; border-radius:3px;"),
                          span("Moderadamente")
                        ),
                        
                        div(
                          style = "display:flex; align-items:center; gap:5px;",
                          span(style = "width:12px; height:12px; background:#A56BCB;
                     display:inline-block; border-radius:3px;"),
                          span("Ajudaram um pouco")
                        ),
                        
                        div(
                          style = "display:flex; align-items:center; gap:5px;",
                          span(style = "width:12px; height:12px; background:#D8C4E8;
                     display:inline-block; border-radius:3px;"),
                          span("Não ajudaram")
                        )
                      ),
                      
                      plotlyOutput("grafico_esferas_mudanca", height = "330px")
                    )
                  ),
                  
                  # Gráfico 2 — O que colocaram em prática
                  column(
                    width = 6,
                    div(
                      style = "background-color:#f5f3f4; padding:16px;
               border-radius:8px; margin-bottom:20px;",
                      # h4("O que as participantes puseram em prática"),
                      p(
                        style = "font-size:13px; color:#666666; margin-bottom:12px;",
                        tags$em(
                          "Podes dizer algo que colocaste em prática depois de ter tido essas actividades?"
                        )
                      ),
                      plotlyOutput("grafico_praticas_genero", height = "330px"),
                      # p(
                      #   style = "font-size:12px; color:#777777; margin-top:8px;",
                      #   "Esferas de mudança · nº de participantes (de 30). ",
                      #   "Um depoimento pode contar em mais de uma categoria."
                      # )
                    )
                  )
                ),
                
                br(),
                
                # Depoimentos
                fluidRow(
                  column(
                    12,
                    div(
                      style = "background-color:#f5f3f4; padding:20px;
                     border-radius:8px; margin-bottom:20px;",
                      h4("Vozes das participantes"),
                      shinyWidgets::radioGroupButtons(
                        inputId = "filtro_tema_qualitativo",
                        label = "Seleccionar tema:",
                        choices = c(
                          "Todos",
                          "Trabalho doméstico",
                          "Poder interior",
                          "Negociar e fixar preços",
                          "Relações de poder",
                          "Estereótipos ocupacionais",
                          "Tensões",
                          "Tempo"
                        ),
                        selected = "Todos",
                        justified = FALSE,
                        individual = TRUE,
                        status = "primary",
                        size = "sm",
                        checkIcon = list(
                          yes = icon("check"),
                          no = NULL
                        )
                      ),
                      
                      uiOutput("depoimentos_genero")
                #     )
                #   )
                # ),
                # 
                # br(),
                # 
                # # Interpretação crítica
                # fluidRow(
                #   column(
                #     12,
                #     div(
                #       style = "background-color:#f5f3f4; padding:20px;
                #      border-radius:8px; margin-bottom:20px;",
                #       h4("Interpretação crítica e recomendações"),
                #       uiOutput("interpretacao_critica_genero")
                    )
                  )
                )
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
                  uiOutput("texto_conhecimento_ambiental")
                ),
                plotlyOutput("grafico_conhecimento_ambiental")
              ),
              
              column(
                6,
                 div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_impacto_ambiental")
                ),
                plotlyOutput("grafico_impacto_ambiental_negocio")
              )
            ),
            
            br(),
            fluidRow(
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_praticas_sustentaveis")
                ),
                plotlyOutput("grafico_praticas_sustentaveis")
              ),
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_aplica_praticas")
                ),
                plotlyOutput("grafico_aplica_praticas")
              )
            ),
            fluidRow(
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_praticas_sustentaveis_")
                ),
                plotlyOutput("graficoPontuacaoBeira")
              ),

              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:10px;",
                  uiOutput("texto_Pegada")
                ),
                plotlyOutput("graficoPontuacaoNampula"))
              )
            ),
      #     )
      #     )
      #   )
      # ),
  
  # =========================
  # ABA EXERCICIOS PRATICOS
  # =========================
  tabPanel(
    "Resultados dos Exercícios",
    
    # =========================================================
    # CENÁRIO 1
    # =========================================================
    
    fluidRow(
      column(
        12,
        
        div(
          style = "
          background-color:#eef4fb;
          border-left:5px solid #8054A2;
          padding:15px;
          border-radius:6px;
          margin-bottom:25px;
        ",
          
          tags$h4(
            style = "margin-top:0; color:#8054A2;",
            "Exercício 1 – Relações de Poder no Negócio (iPAM_RI.4.2)"
          ),
          
          tags$p(
            strong("Cenário: "),
            "A Joana tem um pequeno negócio de costura. O marido não permite que ela participe numa feira de negócios noutro bairro por considerar que uma mulher casada não deve deslocar-se sozinha. A participante deve identificar o problema, explicar o impacto no negócio e sugerir uma estratégia de resposta."
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 1 E 2
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_poder"),
          
          plotlyOutput(
            "grafico_resultado_poder",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_exercicio_2"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_2",
            height = "450px"
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 3 E 4
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_sugerir"),
          
          plotlyOutput(
            "grafico_resultado_sugerir",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_semelhante"),
          
          plotlyOutput(
            "grafico_resultado_semelhante",
            height = "450px"
          )
        )
      )
    ),
    
    fluidRow(
      
     column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_impacto"),
          
          plotlyOutput(
            "grafico_resultado_impacto",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_res"),
          
          plotlyOutput(
            "grafico_res",
            height = "450px"
          )
        )
      )
    ),
    # =========================================================
    # CENÁRIO 2
    # =========================================================
    
    fluidRow(
      column(
        12,
        
        div(
          style = "
          background-color:#eef4fb;
          border-left:5px solid #8054A2;
          padding:15px;
          border-radius:6px;
          margin-top:20px;
          margin-bottom:30px;
        ",
          
          tags$h4(
            style = "margin-top:0; color:#8054A2;",
            "Cenário 2 – Planeamento de Vendas e Relacionamento com Clientes (iPAM_RI.2.5)"
          ),
          
          tags$h5(
            style = "color:#8054A2;",
            "CENÁRIO — O seu próprio negócio"
          ),
          
          tags$p(
            "Agora vamos fazer um exercício usando o seu próprio negócio. ",
            "Pense no principal produto ou serviço que vende. Responda às perguntas ",
            "com base na sua realidade."
          ),
          
          tags$p(
            "Em alguns períodos, o negócio pode ter mais movimento e, noutros, menos. ",
            "Às vezes pode ser difícil planear vendas, preparar produto suficiente ",
            "ou lidar com clientes insatisfeitos."
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 5 E 6
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_lucro"),
          
          plotlyOutput(
            "grafico_resultado_lucro",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_vendas"),
          
          plotlyOutput(
            "grafico_resultado_vendas",
            height = "450px"
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 7 E 8
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_pico"),
          
          plotlyOutput(
            "grafico_resultado_pico",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_acompanhamento"),
          
          plotlyOutput(
            "grafico_resultado_acompanhamento",
            height = "450px"
          )
        )
      )
    ),
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_insatisfeito"),
          
          plotlyOutput(
            "grafico_resultado_insatisfeito",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_feedback"),
          
          plotlyOutput(
            "grafico_resultado_feedback",
            height = "450px"
          )
        )
      )
    ),
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_adaptacao"),
          
          plotlyOutput(
            "grafico_resultado_adaptacao",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_fee"),
          
          plotlyOutput(
            "grafico_resultado_fee",
            height = "450px"
          )
        )
      )
    ),
    
    # =========================================================
    # CENÁRIO 3 – ROLEPLAY
    # =========================================================
    
    fluidRow(
      column(
        12,
        
        div(
          style = "
          background-color:#eef4fb;
          border-left:5px solid #8054A2;
          padding:15px;
          border-radius:6px;
          margin-top:20px;
          margin-bottom:30px;
        ",
          
          tags$h4(
            style = "margin-top:0; color:#8054A2;",
            "Cenário 3 – Situação de Roleplay"
          ),
          
          tags$h5(
            style = "color:#8054A2;",
            "Diga à participante:"
          ),
          
          tags$p(
            tags$em(
              "'Vou fazer o papel do seu fornecedor principal. ",
              "Imagine que está a fazer a sua encomenda habitual. ",
              "Aja como faria numa situação real.'"
            )
          ),
          
          tags$h5(
            style = "color:#8054A2;",
            "Frase de abertura da inquiridora (como fornecedor):"
          ),
          
          tags$p(
            tags$em(
              "'Olá. Antes de começarmos, preciso de lhe dizer que os preços subiram. ",
              "A partir de hoje o preço por unidade vai aumentar 50%. ",
              "Já avisei todos os meus clientes — é assim para toda a gente.'"
            )
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 9 E 10
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_exercicio_9"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_9",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_exercicio_10"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_10",
            height = "450px"
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 11 E 12
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_exercicio_11"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_11",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:30px;
        ",
          
          uiOutput("texto_resultado_exercicio_12"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_12",
            height = "450px"
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIO 13
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
          background-color:#f5f3f4;
          padding:15px;
          border-left:5px solid #8054A2;
          border-radius:6px;
          margin-bottom:40px;
        ",
          
          uiOutput("texto_resultado_exercicio_13"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_13",
            height = "450px"
          )
        )
      )
    ),
    
    # =========================================================
    # EXERCÍCIOS 13 E 14
    # =========================================================
   
    
    fluidRow(
      column(
        12,
        
        # =======================================================
        # CABEÇALHO DO CENÁRIO
        # =======================================================
        
        div(
          style = "
    background-color:#eef4fb;
    border-left:5px solid #8054A2;
    padding:15px;
    border-radius:6px;
    margin-top:20px;
    margin-bottom:20px;
  ",
          
          tags$h4(
            style = "color:#8054A2;",
            "EXERCÍCIO 4 — Pesquisa de Negócio"
          ),
          
          tags$h5(
            style = "margin-top:0; color:#8054A2;",
            "Planeamento da Pesquisa HCD (iPAM_RI.2.5)"
          )
        ),
        
        
        # =======================================================
        # PARTE A — PLANEAMENTO DA PESQUISA HCD
        # =======================================================
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-radius:6px;
        margin-bottom:20px;
      ",
          
          tags$h5(
            style = "color:#8054A2; margin-top:0;",
            "Parte A — Planeamento da Pesquisa HCD"
          ),
          
          tags$p(
            tags$b("Instrução à participante: "),
            "Durante o programa realizou uma pesquisa HCD sobre o seu negócio. ",
            "Vamos recordar o que investigou e o que aprendeu com essa pesquisa."
          )
        )
      )
    ),
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:30px;
      ",
          
          uiOutput("texto_resultado_exercicio_14"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_14",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:30px;
      ",
          
          uiOutput("texto_resultado_exercicio_15"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_15",
            height = "450px"
          )
        )
      )
    ),
    
    
    # =========================================================
    # EXERCÍCIOS 15 E 16
    # =========================================================
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:40px;
      ",
          
          uiOutput("texto_resultado_exercicio_16"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_16",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:40px;
      ",
          
          uiOutput("texto_resultado_exercicio_17"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_17",
            height = "450px"
          )
        )
      )
    ),
    
    
    # ============================================================
    # PARTE B — FASE 1: ANÁLISE PRÓPRIA (SEM IA)
    # ============================================================
    
    fluidRow(
      
      column(
        12,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:20px;
        border-radius:8px;
        margin-top:20px;
        margin-bottom:20px;
      ",
          
          tags$h4(
            style = "
          color:#8054A2;
          margin-top:0;
          font-weight:bold;
        ",
            "Parte B — Fase 1: Análise Própria (sem IA)"
          ),
          
          tags$p(
            tags$b("Instrução: "),
            "Analise primeiro os dados da pesquisa e identifique, com base nas respostas das clientes, ",
            "o principal problema ou padrão observado. ",
            "Faça a sua análise antes de consultar qualquer resultado produzido por Inteligência Artificial."
          ),
          
          # --------------------------------------------------------
          # FASE 1 — DADOS DE PESQUISA
          # --------------------------------------------------------
          
          div(
            style = "
          background-color:#ffffff;
          border-left:5px solid #8054A2;
          padding:15px;
          border-radius:6px;
          margin-top:15px;
          margin-bottom:20px;
        ",
            
            tags$h5(
              style = "
            color:#8054A2;
            margin-top:0;
            font-weight:bold;
          ",
              "FASE 1 — Dados de pesquisa"
            ),
            
            tags$p(
              style = "margin-bottom:15px;",
              tags$b("Contexto: "),
              "Foram realizadas conversas informais com 3 clientes sobre o seguinte tema:"
            ),
            
            # ------------------------------------------------------
            # PERGUNTA DA PESQUISA
            # ------------------------------------------------------
            
            div(
              style = "
            background-color:#eef4fb;
            padding:15px;
            border-radius:6px;
            margin-bottom:20px;
            text-align:center;
          ",
              
              tags$h5(
                style = "
              color:#8054A2;
              font-weight:bold;
              margin:0;
            ",
                "\"Porque é que algumas clientes perguntam o preço, mas não compram o produto?\""
              )
            ),
            
            # ------------------------------------------------------
            # CLIENTE 1
            # ------------------------------------------------------
            
            div(
              style = "
            background-color:#fafafa;
            border:1px solid #e0e0e0;
            padding:15px;
            border-radius:6px;
            margin-bottom:12px;
          ",
              
              tags$p(
                tags$b(
                  style = "color:#8054A2;",
                  "Cliente 1"
                )
              ),
              
              tags$p(
                style = "margin-bottom:0;",
                "\"O produto está bem, mas é caro para comprar tudo de uma vez. ",
                "Se pudesse comprar menos quantidade, comprava.\""
              )
            ),
            
            # ------------------------------------------------------
            # CLIENTE 2
            # ------------------------------------------------------
            
            div(
              style = "
            background-color:#fafafa;
            border:1px solid #e0e0e0;
            padding:15px;
            border-radius:6px;
            margin-bottom:12px;
          ",
              
              tags$p(
                tags$b(
                  style = "color:#8054A2;",
                  "Cliente 2"
                )
              ),
              
              tags$p(
                style = "margin-bottom:0;",
                "\"Gostaria de pagar em duas vezes mas não sei se é possível. ",
                "Normalmente não pergunto.\""
              )
            ),
            
            # ------------------------------------------------------
            # CLIENTE 3
            # ------------------------------------------------------
            
            div(
              style = "
            background-color:#fafafa;
            border:1px solid #e0e0e0;
            padding:15px;
            border-radius:6px;
            margin-bottom:0;
          ",
              
              tags$p(
                tags$b(
                  style = "color:#8054A2;",
                  "Cliente 3"
                )
              ),
              
              tags$p(
                style = "margin-bottom:0;",
                "\"Às vezes compro menos quantidade do que quero para gastar menos dinheiro de uma vez só.\""
              )
            )
          )
        )
      )
    ),
    
    fluidRow(
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:40px;
      ",
          
          uiOutput("texto_resultado_exercicio_18"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_18",
            height = "450px"
          )
        )
      ),
      
      column(
        6,
        
        div(
          style = "
        background-color:#f5f3f4;
        padding:15px;
        border-left:5px solid #8054A2;
        border-radius:6px;
        margin-bottom:40px;
      ",
          
          uiOutput("texto_resultado_exercicio_19"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_19",
            height = "450px"
          )
        )
      )
    ),
    # fluidRow(
    #   
    #   column(
    #     6,
    #     
    #     div(
    #       style = "
    #     background-color:#f5f3f4;
    #     padding:15px;
    #     border-left:5px solid #8054A2;
    #     border-radius:6px;
    #     margin-bottom:30px;
    #   ",
    #       
    #       uiOutput("texto_resultado_exercicio_20"),
    #       
    #       plotlyOutput(
    #         "grafico_resultado_exercicio_20",
    #         height = "450px"
    #       )
    #     )
    #   ),
    #   
    #   column(
    #     6,
    #     
    #     div(
    #       style = "
    #     background-color:#f5f3f4;
    #     padding:15px;
    #     border-left:5px solid #8054A2;
    #     border-radius:6px;
    #     margin-bottom:30px;
    #   ",
    #       
    #       uiOutput("texto_resultado_exercicio_21"),
    #       
    #       plotlyOutput(
    #         "grafico_resultado_exercicio_21",
    #         height = "450px"
    #       )
    #     )
    #   )
    # ),
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
              "Os gráficos abaixo apresentam uma visão geral do projeto, evidenciando o percurso das empreendedoras desde a seleção até à conclusão da formação. Das 50 empreendedoras selecionadas (100%), 43 iniciaram a formação (86%). Entre as participantes que iniciaram, 30 concluíram a formação com sucesso (70%), enquanto 13 desistiram (30%)."
            ),
            
            fluidRow(
              column(6, plotlyOutput("grafico1")),
              column(6, plotlyOutput("grafico2"))
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
                  choices = c("Todas", unique(Presencas_Colectivas_Nampula$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "mentora_coletiva",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Presencas_Colectivas_Nampula$Pesquisadores)),
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
                  choices = c("Todas", unique(Webinars_Nampula$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_webinar",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Webinars_Nampula$Pesquisadores)),
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
          
          # ==========================================================
          # ABA Feiras_Nampula - MONITORIA
          # ==========================================================
          
          tabPanel(
            tagList(icon("store"), "Feiras_Nampula"),
            
            sidebarLayout(
              
              sidebarPanel(
                
                selectInput(
                  "filtro_monitoria_feira",
                  "Selecione Cidade:",
                  choices = c("Todas"),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_feira",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas"),
                  selected = "Todas"
                )
                
              ),
              
              
              mainPanel(
                
                # div(
                #   class = "value-box-container",
                #   
                #   uiOutput("total_participantes_feira"),
                #   uiOutput("total_sessoes_feira"),
                #   uiOutput("taxa_presenca_feira")
                #   
                # ),
                # 
                # br(),
                
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
          ),
          
          tabPanel(
            "Sessões_Individuais",
            
            sidebarLayout(
              sidebarPanel(
                selectInput(
                  "filtro_monitoria_individual",
                  "Selecione Cidade:",
                  choices = c("Todas", unique(Presencas_Individuais$Cidade)),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_individual",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas", unique(Presencas_Individuais$Pesquisadores)),
                  selected = "Todas"
                )
              ),
              
              mainPanel(
                
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_individual"),
                    plotlyOutput("grafico_individual")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_individual")
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
              choices = c("Todos", unique(Dados_Financeiros_Ciclo_3$Pesquisadores)),
              selected = "Todos"
            ),
            
            selectInput(
              "Nome_Empreendedora",
              "Selecione a Empreendedora:",
              choices = c("Todas", unique(Dados_Financeiros_Ciclo_3$Nome_Empreendedora)),
              selected = "Todas"
            ),
            
            selectInput(
              "Mes",
              "Selecione o Mês:",
              choices = c("Todos", unique(Dados_Financeiros_Ciclo_3$Periodo)),
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
                  uiOutput("vb_aumento_lucro_mes_1_2"),
                  uiOutput("vb_aumento_25_mes_1_2"),
                  uiOutput("vb_aumento_lucro_mes_2_3"),
                  uiOutput("vb_aumento_25_mes_2_3")
                ),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "",
                    div(
                      style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                      uiOutput("leitura_grafico_mensal")
                    ),
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
                br(),
                fluidRow(
                  box(
                    width = 12,
                    title =  "Controlo de Evolução do Lucro Mensal",
                    DTOutput("tabela_controle_lucro")
                  )
                )
              )
            )
          )
        )
      )
    )
  ),
  

  # ==========================================================
  # PÁGINA 3 - MONITORIA_BEIRA_C1
  # ==========================================================
  
  tabPanel(
    tagList(icon("clipboard-check"), "Monitoria_Beira_C1"),
    
    tabsetPanel(
      
      # ======================================================
      # ABA 1 - RESUMO GERAL
      # ======================================================
      
      tabPanel(
        "Resumo Geral",
        
        sidebarLayout(
          
          sidebarPanel(
            
            selectInput(
              "filtro_monitoria_geral_beira",
              "Distrito:",
              choices = c(
                "Todos",
                unique(PERFIL_PAM_VERDE_BEIRA_C3_2026$`Provincia de residencia`)
              ),
              selected = "Todos"
            )
            
          ),
          
          mainPanel(
            
            br(),
            
            tags$h5(
              "Os gráficos abaixo apresentam uma visão geral do projecto na Beira, evidenciando o total de empreendedoras seleccionadas e o seu estado no processo de formação."
            ),
            
            fluidRow(
              column(
                6,
                plotlyOutput("grafico1_beira")
              ),
              
              column(
                6,
                plotlyOutput("grafico2_beira")
              )
            )
            
          )
        )
      ),
      
      
      # ======================================================
      # ABA 2 - PRESENÇAS
      # ======================================================
      
      tabPanel(
        "Presenças",
        
        tabsetPanel(
          
          
          # ==================================================
          # PRESENÇAS COLECTIVAS
          # ==================================================
          
          tabPanel(
            "Presenças Colectivas",
            
            sidebarLayout(
              
              sidebarPanel(
                
                selectInput(
                  "filtro_monitoria_presencas_beira",
                  "Selecione Cidade:",
                  choices = c(
                    "Todas",
                    unique(Presencas_Colectivas_Beira$Cidade)
                  ),
                  selected = "Todas"
                ),
                
                selectInput(
                  "mentora_coletiva_beira",
                  "Selecione Pesquisador(a):",
                  choices = c(
                    "Todas",
                    unique(Presencas_Colectivas_Beira$Pesquisadores)
                  ),
                  selected = "Todas"
                )
                
              ),
              
              
              mainPanel(
                
                div(
                  class = "value-box-container",
                  uiOutput("total_participantes_beira"),
                  uiOutput("total_sessoes_beira"),
                  uiOutput("taxa_presenca_beira")
                ),
                
                br(),
                
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_Pre_Col_beira"),
                    plotlyOutput("grafico_sessoes_col_beira")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_presencas_col_beira")
                
              )
            )
          ),

          # ==================================================
          # WEBINARS BEIRA
          # ==================================================
          
          tabPanel(
            "Webinars",
            
            sidebarLayout(
              
              sidebarPanel(
                
                selectInput(
                  "filtro_monitoria_webinar_beira",
                  "Selecione Cidade:",
                  choices = c("Todas"),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_webinar_beira",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas"),
                  selected = "Todas"
                )
                
              ),
              
              
              mainPanel(
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_webinar_beira"),
                    plotlyOutput("grafico_webinar_beira")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_webinar_beira")
                
              )
            )
          ),
          
          # ==================================================
          # Feiras_Nampula BEIRA
          # ==================================================
          
          tabPanel(
            "Feiras",
            
            sidebarLayout(
              
              sidebarPanel(
                
                selectInput(
                  "filtro_monitoria_feira_beira",
                  "Selecione Cidade:",
                  choices = c("Todas"),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_feira_beira",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas"),
                  selected = "Todas"
                )
                
              ),
              
              
              mainPanel(
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_feira_beira"),
                    plotlyOutput("grafico_feira_beira")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_feira_beira")
                
              )
            )
          ),
          tabPanel(
            "Individual",
            
            sidebarLayout(
              
              sidebarPanel(
                
                selectInput(
                  "filtro_monitoria_individual_beira",
                  "Selecione Cidade:",
                  choices = c("Todas"),
                  selected = "Todas"
                ),
                
                selectInput(
                  "pesquisador_individual_beira",
                  "Selecione Pesquisador(a):",
                  choices = c("Todas"),
                  selected = "Todas"
                )
                
              ),
              
              
              mainPanel(
                fluidRow(
                  column(
                    12,
                    uiOutput("texto_individual_beira"),
                    plotlyOutput("grafico_individual_beira")
                  )
                ),
                
                br(),
                
                DTOutput("tabela_individual_beira")
                
              )
            )
          )
        )
      ),
      
      # ======================================================
      # ABA 3 - DADOS FINANCEIROS
      # ======================================================
      
      tabPanel(
        "Dados Financeiros",
        icon = icon("hand-holding-usd"),
        
        sidebarLayout(
          
          sidebarPanel(
            
            selectInput(
              "Pesquisador_beira",
              "Selecione o Pesquisador:",
              choices = c(
                "Todos",
                unique(Financeiro_Beira$Nome_do_pesquisador)
              )
            ),
            
            selectInput(
              "Nome_Empreendedora_beira",
              "Selecione a Empreendedora:",
              choices = c(
                "Todas",
                unique(Financeiro_Beira$Nome_Empreendedora)
              )
            ),
            
            selectInput(
              "Mes_beira",
              "Selecione o Mês:",
              choices = c(
                "Todos",
                unique(Financeiro_Beira$Periodo)
              )
            )
            
          ),
          
          mainPanel(
            
            tabsetPanel(
              
              tabPanel(
                "Resumo",
                
                div(
                  class = "value-box-container",
                  uiOutput("vb_emp_beira"),
                  uiOutput("vb_lucro_beira"),
                  uiOutput("vb_rendimento_beira"),
                  uiOutput("vb_custos_beira")
                ),
                br(),
                plotlyOutput("cidade_plot_beira")
              ),
              
              tabPanel(
                "Semanal",
                
                plotlyOutput("grafico_financeiro_beira"),
                
                br(),
                
                plotlyOutput("grafico_barras_semanas_beira")
              ),
              
              tabPanel(
                "Mensal",
                
                div(
                  class = "value-box-container",
                  
                  uiOutput("vb_aumento_lucro_mes_1_2_beira"),
                  uiOutput("vb_aumento_25_mes_1_2_beira"),
                  uiOutput("vb_aumento_lucro_mes_2_3_beira"),
                  uiOutput("vb_aumento_25_mes_2_3_beira")
                ),
                
                fluidRow(
                  
                  box(
                    width = 12,
                    title = "",
                    
                    div(
                      style = "
                        background-color:#f5f3f4;
                        padding:12px;
                        border-radius:6px;
                        margin-bottom:20px;
                      ",
                      
                      uiOutput(
                        "leitura_grafico_mensal_beira"
                      )
                    ),
                    
                    plotlyOutput(
                      "grafico_mensal_beira",
                      height = 450
                    )
                  )
                  
                ),
                
                fluidRow(
                  
                  box(
                    width = 12,
                    title = "",
                    
                    plotlyOutput(
                      "grafico_barras_beira"
                    )
                  )
                  
                ),
                
                br(),
                
                fluidRow(
                  
                  box(
                    width = 12,
                    title = "Controlo de Evolução do Lucro Mensal",
                    
                    DTOutput(
                      "tabela_controle_lucro_beira"
                    )
                  )
                  
                )
              )
              
            )
          )
        )
      )
      
    )   
  ),    


# ==========================================================
# PÁGINA 4 - TOC
# ==========================================================

tabPanel(
  
  tagList(
    icon("chart-line"),
    "TOC Nampula"
  ),
  
  fluidPage(
        DTOutput(
          "toc_matriz_indicadores"
        )
    
  )
),

tabPanel(
  
  tagList(
    icon("chart-line"),
    "TOC Beira"
  ),
  
  # ==========================================================
  # BIBLIOTECA PARA CAPTURA DA TABELA EM PNG
  # ==========================================================
  
  # tags$head(
  #   tags$script(
  #     src = "https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"
  #   )
  # ),
  # 
  fluidPage(
        DTOutput("toc_matriz_indicadores_beira")
    
  )
  
),
# ==========================================================
# PÁGINA 5 - ADMIN
# ==========================================================

tabPanel(
  tagList(
    icon("tools"),
    "ADMIN"
  ),
  
  fluidPage(
    # uiOutput("admin_ui")
  )
)

)


# ==========================================================
# SERVER
# ==========================================================

server <- function(input, output, session) {
  
  # ===============================================================
  # 2️⃣ DADOS PERFIL
  # ===============================================================
  
  dados_perfil <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    
    # =============================================================
    # LIMPEZA DOS DADOS
    # =============================================================
    
    df <- df %>%
      mutate(
        ID_Participante = trimws(as.character(ID_Participante)),
        Cidade = trimws(as.character(Cidade)),
        Ciclo = trimws(as.character(Ciclo)),
        Tipo_Avaliacao = trimws(as.character(Tipo_Avaliacao))
      ) %>%
      filter(
        !is.na(ID_Participante),
        ID_Participante != ""
      )
    
    
    # =============================================================
    # FILTRO - CIDADE
    # =============================================================
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # =============================================================
    # FILTRO - CICLO
    # =============================================================
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # =============================================================
    # FILTRO - TIPO DE AVALIAÇÃO
    # =============================================================
    
    if (input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # =============================================================
    # RETORNAR DADOS
    # =============================================================
    
    df
    
  })
  
  
  # ===============================================================
  # 3️⃣ KPI BOXES
  # ===============================================================
  
  output$kpi_boxes <- renderUI({
    
    df <- dados_perfil()
    
    
    # =============================================================
    # LIMPAR E PADRONIZAR ID
    # =============================================================
    
    df <- df %>%
      mutate(
        ID_Participante = trimws(as.character(ID_Participante)),
        Tipo_Avaliacao = trimws(as.character(Tipo_Avaliacao)),
        Cidade = trimws(as.character(Cidade))
      ) %>%
      filter(
        !is.na(ID_Participante),
        ID_Participante != ""
      )
    
    
    # =============================================================
    # TOTAL BASELINE
    # =============================================================
    
    total_baseline <- df %>%
      filter(
        toupper(Tipo_Avaliacao) == "BASELINE"
      ) %>%
      distinct(
        ID_Participante
      ) %>%
      nrow()
    
    
    # =============================================================
    # TOTAL ENDLINE
    # =============================================================
    
    total_endline <- df %>%
      filter(
        toupper(Tipo_Avaliacao) == "ENDLINE"
      ) %>%
      distinct(
        ID_Participante
      ) %>%
      nrow()
    
    
    # =============================================================
    # QUANDO TODAS AS CIDADES ESTÃO SELECIONADAS
    # =============================================================
    
    if (input$filtro_cidade == "Todas") {
      
      
      # ===========================================================
      # TOTAL GERAL
      # ===========================================================
      
      total_geral <- df %>%
        distinct(
          ID_Participante
        ) %>%
        nrow()
      
      
      # ===========================================================
      # TOTAL BEIRA
      # ===========================================================
      
      total_beira <- df %>%
        filter(
          Cidade == "Beira"
        ) %>%
        distinct(
          ID_Participante
        ) %>%
        nrow()
      
      
      # ===========================================================
      # TOTAL NAMPULA
      # ===========================================================
      
      total_nampula <- df %>%
        filter(
          Cidade == "Nampula"
        ) %>%
        distinct(
          ID_Participante
        ) %>%
        nrow()
      
      
      # ===========================================================
      # BOXES
      # ===========================================================
      
      div(
        
        class = "value-box-container",
        
        
        # ---------------------------------------------------------
        # TOTAL
        # ---------------------------------------------------------
        
        div(
          class = "value-box blue",
          
          span(
            class = "value-number",
            total_geral
          ),
          
          span(
            class = "value-title",
            "Total"
          )
        ),
        
        
        # ---------------------------------------------------------
        # BASELINE
        # ---------------------------------------------------------
        
        div(
          class = "value-box green",
          
          span(
            class = "value-number",
            total_baseline
          ),
          
          span(
            class = "value-title",
            "Total Baseline"
          )
        ),
        
        
        # ---------------------------------------------------------
        # ENDLINE
        # ---------------------------------------------------------
        
        div(
          class = "value-box yellow",
          
          span(
            class = "value-number",
            style = "color: white;",
            total_endline
          ),
          
          span(
            class = "value-title",
            style = "color: white;",
            "Total Endline"
          )
        ),
        
        
        # ---------------------------------------------------------
        # BEIRA
        # ---------------------------------------------------------
        
        div(
          class = "value-box purple",
          
          span(
            class = "value-number",
            total_beira
          ),
          
          span(
            class = "value-title",
            "Total Beira"
          )
        ),
        
        
        # ---------------------------------------------------------
        # NAMPULA
        # ---------------------------------------------------------
        
        div(
          class = "value-box orange",
          
          span(
            class = "value-number",
            total_nampula
          ),
          
          span(
            class = "value-title",
            "Total Nampula"
          )
        )
        
      )
      
      
    } else {
      
      
      # ===========================================================
      # TOTAL DA CIDADE
      # ===========================================================
      
      total_cidade <- df %>%
        filter(
          Cidade == input$filtro_cidade
        ) %>%
        distinct(
          ID_Participante
        ) %>%
        nrow()
      
      
      # ===========================================================
      # BOXES
      # ===========================================================
      
      div(
        
        class = "value-box-container",
        
        
        # ---------------------------------------------------------
        # TOTAL DA CIDADE
        # ---------------------------------------------------------
        
        div(
          class = "value-box blue",
          
          span(
            class = "value-number",
            total_cidade
          ),
          
          span(
            class = "value-title",
            paste(
              "Total",
              input$filtro_cidade
            )
          )
        ),
        
        
        # ---------------------------------------------------------
        # BASELINE
        # ---------------------------------------------------------
        
        div(
          class = "value-box green",
          
          span(
            class = "value-number",
            total_baseline
          ),
          
          span(
            class = "value-title",
            "Total Baseline"
          )
        ),
        
        
        # ---------------------------------------------------------
        # ENDLINE
        # ---------------------------------------------------------
        
        div(
          class = "value-box yellow",
          
          span(
            class = "value-number",
            style = "color: white;",
            total_endline
          ),
          
          span(
            class = "value-title",
            style = "color: white;",
            "Total Endline"
          )
        )
        
      )
      
    }
    
  })

  # 
  # # =================================GRÁFICO 1 — PARTICIPANTES POR SEXO==============================

  observe({
    
    cidades <- Pam_Verde_Indicadores %>%
      dplyr::filter(
        !is.na(Cidade),
        Cidade != ""
      ) %>%
      dplyr::distinct(Cidade) %>%
      dplyr::arrange(Cidade) %>%
      dplyr::pull(Cidade)
    
    updateSelectInput(
      session,
      "filtro_cidade",
      choices = c(
        "Todas",
        cidades
      )
    )
  })
  
  # ============================================================
  # CICLO DEPENDENTE DA CIDADE
  # ============================================================
  
  observeEvent(
    input$filtro_cidade,
    {
      
      df <- Pam_Verde_Indicadores
      
      # Se seleccionou uma cidade específica
      if (input$filtro_cidade != "Todas") {
        
        df <- df %>%
          dplyr::filter(
            Cidade == input$filtro_cidade
          )
      }
      
      ciclos <- df %>%
        dplyr::filter(
          !is.na(Ciclo),
          Ciclo != ""
        ) %>%
        dplyr::distinct(Ciclo) %>%
        dplyr::arrange(Ciclo) %>%
        dplyr::pull(Ciclo)
      
      updateSelectInput(
        session,
        "filtro_ciclo",
        choices = c(
          "Todos",
          ciclos
        ),
        selected = "Todos"
      )
      
    },
    ignoreInit = FALSE
  )
  
  
  # ============================================================
  # TIPO DE AVALIAÇÃO DEPENDENTE DA CIDADE + CICLO
  # ============================================================
  
  observe({
    
    req(
      input$filtro_cidade,
      input$filtro_ciclo
    )
    
    df <- Pam_Verde_Indicadores
    
    
    # ----------------------------------------------------------
    # FILTRAR CIDADE
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        dplyr::filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # ----------------------------------------------------------
    # FILTRAR CICLO
    # ----------------------------------------------------------
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # ----------------------------------------------------------
    # OBTER TIPOS DE AVALIAÇÃO DISPONÍVEIS
    # ----------------------------------------------------------
    
    tipos_avaliacao <- df %>%
      dplyr::filter(
        !is.na(Tipo_Avaliacao),
        Tipo_Avaliacao != ""
      ) %>%
      dplyr::distinct(Tipo_Avaliacao) %>%
      dplyr::arrange(Tipo_Avaliacao) %>%
      dplyr::pull(Tipo_Avaliacao)
    
    
    # ----------------------------------------------------------
    # ACTUALIZAR SELECT
    # ----------------------------------------------------------
    
    updateSelectInput(
      session,
      "filtro_tipo_avaliacao",
      choices = c(
        "Todos",
        tipos_avaliacao
      ),
      selected = "Todos"
    )
  })
  
  
  # ============================================================
  # DADOS FILTRADOS
  # ============================================================
  
  dados_filtrados <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    
    # ----------------------------------------------------------
    # CIDADE
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        dplyr::filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # ----------------------------------------------------------
    # CICLO
    # ----------------------------------------------------------
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # ----------------------------------------------------------
    # TIPO DE AVALIAÇÃO
    # ----------------------------------------------------------
    
    if (input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # ----------------------------------------------------------
    # REMOVER DUPLICADOS
    # ----------------------------------------------------------
    
    df %>%
      dplyr::distinct(
        Nome_Participante,
        .keep_all = TRUE
      )
    
  })

  output$grafico_participantes <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    req("Estado_Civil" %in% names(df))
    
    df_resumo <- df %>%
      filter(
        !is.na(Estado_Civil),
        Estado_Civil != ""
      ) %>%
      count(Estado_Civil, name = "Total") %>%
      mutate(
        Percentagem = round(Total / sum(Total) * 100, 1),
        Texto = paste0(
          Total,
          " (",
          Percentagem,
          "%)"
        )
      )
    
    plot_ly(
      data = df_resumo,
      labels = ~Estado_Civil,
      values = ~Total,
      type = "pie",
      hole = 0.55,
      
      # Mostrar n + %
      text = ~Texto,
      textinfo = "text",
      textposition = "inside",
      insidetextorientation = "radial",
      
      marker = list(
        colors = c(
          "#9442d4",
          "#ff7f0e",
          "#5cd6c7",
          "#f9a825",
          "#d62728"
        ),
        line = list(
          color = "white",
          width = 2
        )
      ),
      
      hovertemplate = paste(
        "<b>%{label}</b><br>",
        "Total: %{value}<br>",
        "Percentagem: %{percent}<extra></extra>"
      )
    ) %>%
      layout(
        title = "",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        legend = list(
          orientation = "v"
        )
      )
    
  })
  
  output$texto_estado_civil <- renderUI({
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    resumo <- df %>%
      filter(!is.na(Estado_Civil), Estado_Civil != "") %>%
      count(Estado_Civil) %>%
      mutate(
        perc = round(n / sum(n) * 100, 1)
      ) %>%
      arrange(desc(n))
    
    req(nrow(resumo) > 0)
    
    total <- sum(resumo$n)
    
    principal <- resumo$Estado_Civil[1]
    perc_principal <- resumo$perc[1]
    
    restantes <- resumo %>%
      slice(-1)
    
    texto_restantes <- paste0(
      restantes$Estado_Civil,
      " (",
      restantes$perc,
      "%)",
      collapse = ", "
    )
    
    tags$p(
      
      style = "text-align:justify;margin:0;",
      
      tags$b("Selecione o Seu Estado Civil. "),
      
      "Após a aplicação dos filtros, foram identificadas ",
      
      tags$b(total),
      
      " empreendedoras. A maioria é ",
      
      tags$b(principal),
      
      " (", perc_principal, "%). ",
      
      if (nrow(restantes) > 0)
        paste0("Os restantes estados civis distribuem-se entre ", texto_restantes, ".")
      
    )
    
  })
   
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
      mutate(
        Grupo_Idade = ifelse(
          Idade <= 35,
          "<= 35 Anos",
          "> 35 Anos"
        )
      ) %>%
      group_by(Grupo_Idade) %>%
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      mutate(
        Percentagem = round(
          Total / sum(Total) * 100,
          1
        ),
        
        # Texto apresentado dentro do gráfico
        Texto = paste0(
          Total,
          " (",
          Percentagem,
          "%)"
        ),
        
        # Texto para a legenda
        Grupo_Idade_Label = paste0(
          Grupo_Idade,
          " – ",
          Total,
          " (",
          Percentagem,
          "%)"
        )
      )
    
    plot_ly(
      data = df_resumo,
      
      # Categoria + n + %
      labels = ~Grupo_Idade_Label,
      values = ~Total,
      
      type = "pie",
      hole = 0.55,
      
      # Mostrar n + % dentro da fatia
      text = ~Texto,
      textinfo = "text",
      textposition = "inside",
      insidetextorientation = "radial",
      
      marker = list(
        colors = c(
          "#9442d4",
          "#f77333"
        ),
        line = list(
          color = "#FFFFFF",
          width = 2
        )
      ),
      
      # Informação ao passar o rato
      hovertemplate = paste(
        "<b>%{label}</b><br>",
        "Total: %{value}<br>",
        "Percentagem: %{percent}<extra></extra>"
      )
      
    ) %>%
      layout(
        title = "",
        showlegend = TRUE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        legend = list(
          orientation = "v"
        )
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
      
      tags$b("Data de Nascimento:"),
      
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
    
    # =========================
    # LABELS CURTOS
    # =========================
    
    labels_curto <- c(
      "Prestação de serviços (ornamentação de eventos, microcrédito, salão de cabeleleiro, takeaway etc)" =
        "Prestação de serviços",
      
      "Produção e venda de produtos alimentares (bolos, salgados, comidas, etc :transformação de prod)" =
        "Produção e venda de produtos",
      
      "Compra e venda de produtos não alimentares ( roupa,crédito, etc: sem transformação)" =
        "Compra e venda de produtos não alimentares",
      
      "Produção e venda de produtos não alimentares (Artesanato, etc: Com transformação de prod.)" =
        "Produção e venda de produtos não alimentares"
    )
    
    
    # =========================
    # CORES
    # =========================
    
    cores_setores <- c(
      "Prestação de serviços" = "#9442d4",
      "Produção e venda de produtos" = "#ff7f0e",
      "Produção e venda de produtos não alimentares" = "#5cd6c7",
      "Compra e venda de produtos não alimentares" = "#f9a825"
    )
    
    
    # =========================
    # DADOS FILTRADOS
    # =========================
    
    df <- dados_filtrados()
    
    
    if(nrow(df) == 0){
      
      return(
        plotly_empty() %>%
          layout(
            annotations = list(
              text = "Sem dados disponíveis para os filtros selecionados",
              showarrow = FALSE,
              font = list(size = 16)
            )
          )
      )
    }
    
    
    # =========================
    # RESUMO POR SECTOR
    # =========================
    
    data_summary <- df %>%
      filter(!is.na(Sector)) %>%
      
      group_by(Sector) %>%
      
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      
      mutate(
        Percentual = round(
          N / sum(N) * 100,
          1
        ),
        
        Sector_curto = labels_curto[Sector]
      ) %>%
      
      # ordenar menor para maior %
      arrange(
        Percentual
      ) %>%
      
      # manter ordem no gráfico
      mutate(
        Sector_curto = factor(
          Sector_curto,
          levels = Sector_curto
        )
      )
    
    
    # =========================
    # GRÁFICO
    # =========================
    
    bar_plot <- ggplot(
      data_summary,
      aes(
        x = "",
        y = N,
        fill = Sector_curto,
        text = paste0(
          Sector_curto,
          ": ",
          N,
          " (",
          Percentual,
          "%)"
        )
      )
    ) +
      
      geom_col(
        position = "fill",
        width = 0.6
      ) +
      
      geom_text(
        aes(
          label = paste0(
            N,
            "\n",
            Percentual,
            "%"
          )
        ),
        position = position_fill(
          vjust = 0.5
        ),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      
      scale_y_continuous(
        labels = scales::percent
      ) +
      
      scale_fill_manual(
        values = cores_setores,
        na.value = "grey70"
      ) +
      
      labs(
        x = NULL,
        y = "Percentagem",
        fill = "Sector"
      ) +
      
      theme_stata(
        base_size = 12
      ) +
      
      theme(
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        legend.position = "bottom",
        
        legend.text = element_text(
          size = 7
        ),
        
        legend.title = element_text(
          size = 10
        ),
        
        axis.text.x = element_blank(),
        
        axis.ticks.x = element_blank()
      )
    
    
    # =========================
    # PLOTLY
    # =========================
    
    ggplotly(
      bar_plot,
      tooltip = "text"
    ) %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        margin = list(
          l = 50,
          r = 50,
          t = 20,
          b = 100
        )
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
      
      tags$b("Selecione o Sector de actividade. "),
      
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
      
      tags$b("Ano de criação do negócio."),
      
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
  
  # 
  # 
  # #   # ==========================================================
  # #   # PÁGINA 2 - Companies situation and performance
  # #   # ==========================================================

  
  ############################ USO DE SERVICOS FINANCEIROS
  
  output$grafico_formalizacao <- renderPlotly({
    
    # =========================================================
    # BASE ORIGINAL
    # =========================================================
    df <- Pam_Verde_Indicadores
    
    
    # =========================================================
    # FILTROS
    # =========================================================
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>%
        filter(Tipo_Avaliacao == input$filtro_tipo_avaliacao)
    }
    
    
    # =========================================================
    # REMOVER DADOS VAZIOS
    # =========================================================
    df <- df %>%
      filter(
        !is.na(Negocio_Formalizado),
        !is.na(Tipo_Avaliacao)
      )
    
    
    if (nrow(df) == 0) {
      return(plotly_empty())
    }
    
    
    # =========================================================
    # FREQUÊNCIA
    # =========================================================
    freq_data <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Negocio_Formalizado
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(
          n / sum(n) * 100,
          1
        ),
        
        # Texto dentro da barra
        label = paste0(
          n,
          " (",
          pct,
          "%)"
        )
      ) %>%
      
      ungroup()
    
    
    # =========================================================
    # ORDENAÇÃO
    # =========================================================
    ordem_formalizacao <- freq_data %>%
      
      group_by(
        Negocio_Formalizado
      ) %>%
      
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      
      arrange(total) %>%
      
      pull(
        Negocio_Formalizado
      )
    
    
    freq_data$Negocio_Formalizado <- factor(
      freq_data$Negocio_Formalizado,
      levels = ordem_formalizacao
    )
    
    
    # =========================================================
    # CORES
    # =========================================================
    cores <- c(
      "Não" = "#5cd6c7",
      "Iniciei o processo de formalização" = "#ff7f0e",
      "Sim" = "#9442d4"
    )
    
    
    # =========================================================
    # GRÁFICO
    # =========================================================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~pct,
      
      color = ~Negocio_Formalizado,
      colors = cores,
      
      type = "bar",
      
      
      # =======================================================
      # MOSTRAR n + %
      # =======================================================
      text = ~label,
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
      ),
      
      # =======================================================
      # HOVER
      # =======================================================
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Número: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      customdata = ~n
      
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        
        # =====================================================
        # EIXO Y
        # =====================================================
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        
        
        # =====================================================
        # EIXO X
        # =====================================================
        xaxis = list(
          title = ""
        ),
        
        
        # =====================================================
        # LEGENDA
        # =====================================================
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.25
        ),
        
        
        # =====================================================
        # MARGENS
        # =====================================================
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 120
        ),
        
        
        # =====================================================
        # FUNDO
        # =====================================================
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  # ============================================================
  # TEXTO DINÂMICO – FORMALIZAÇÃO DO NEGÓCIO
  # BASE ORIGINAL: Pam_Verde_Indicadores
  # ============================================================
  
  output$texto_formalizacao <- renderUI({
    
    # ==========================================================
    # 1. BASE ORIGINAL
    # ==========================================================
    
    df <- Pam_Verde_Indicadores
    
    
    # ==========================================================
    # 2. APLICAR FILTROS
    # ==========================================================
    
    # Filtro por cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro por ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # Filtro por tipo de avaliação
    if (input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # ==========================================================
    # 3. REMOVER DADOS VAZIOS
    # ==========================================================
    
    df <- df %>%
      filter(
        !is.na(Negocio_Formalizado),
        !is.na(Tipo_Avaliacao)
      )
    
    
    # ==========================================================
    # 4. VERIFICAR SE EXISTEM DADOS
    # ==========================================================
    
    if (
      nrow(df) == 0
    ) {
      
      return(NULL)
    }
    
    
    # ==========================================================
    # 5. CALCULAR FREQUÊNCIAS E PERCENTAGENS
    # ==========================================================
    
    resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Negocio_Formalizado
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      
      ungroup()
    
    
    # ==========================================================
    # 6. BASELINE
    # ==========================================================
    
    baseline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Baseline"
      ) %>%
      
      select(
        Negocio_Formalizado,
        perc_baseline = perc
      )
    
    
    # ==========================================================
    # 7. ENDLINE
    # ==========================================================
    
    endline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Endline"
      ) %>%
      
      select(
        Negocio_Formalizado,
        perc_endline = perc
      )
    
    
    # ==========================================================
    # 8. COMPARAÇÃO BASELINE × ENDLINE
    # ==========================================================
    
    comparacao <- full_join(
      
      baseline,
      endline,
      
      by =
        "Negocio_Formalizado"
      
    ) %>%
      
      mutate(
        
        perc_baseline =
          replace_na(
            perc_baseline,
            0
          ),
        
        perc_endline =
          replace_na(
            perc_endline,
            0
          ),
        
        variacao =
          perc_endline -
          perc_baseline
      )
    
    
    # ==========================================================
    # 9. TEXTO DINÂMICO
    # ==========================================================
    
    texto_categorias <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          comparacao$Negocio_Formalizado[i]
        
        base <-
          round(
            comparacao$perc_baseline[i],
            1
          )
        
        end <-
          round(
            comparacao$perc_endline[i],
            1
          )
        
        variacao <-
          round(
            comparacao$variacao[i],
            1
          )
        
        
        # ------------------------------------------------------
        # AUMENTO
        # ------------------------------------------------------
        
        if (
          variacao > 0
        ) {
          
          paste0(
            
            categoria,
            
            " aumentou de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (+",
            
            variacao,
            
            " p.p.)"
          )
        }
        
        
        # ------------------------------------------------------
        # REDUÇÃO
        # ------------------------------------------------------
        
        else if (
          variacao < 0
        ) {
          
          paste0(
            
            categoria,
            
            " reduziu de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (",
            
            variacao,
            
            " p.p.)"
          )
        }
        
        
        # ------------------------------------------------------
        # SEM ALTERAÇÃO
        # ------------------------------------------------------
        
        else {
          
          paste0(
            
            categoria,
            
            " manteve-se em ",
            
            end,
            
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    
    # ==========================================================
    # 10. TEXTO FINAL
    # ==========================================================
    
    tags$p(
      
      style =
        "margin:0;text-align:justify;",
      
      tags$b(
        "O seu negócio está formalizado? "
      ),
      
      "(registado oficialmente e com Certificado de Registo Comercial). ",
      
      "A comparação entre o Baseline e o Endline permite observar ",
      
      "a evolução da situação de formalização dos negócios. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  
  # ============================================================
  # NOVA TABELA DE APOIO AO GRÁFICO
  # UTILIZAÇÃO DE SERVIÇOS FINANCEIROS
  # 7 CATEGORIAS — BASELINE VS ENDLINE
  # Independente da tabela do indicador iPAM_RI.7.3
  # ============================================================
  
  dados_grafico_servicos_financeiros <- shiny::reactive({
    
    # ----------------------------------------------------------
    # 1. BASE ORIGINAL
    # ----------------------------------------------------------
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # 2. APLICAR FILTROS
    # ----------------------------------------------------------
    
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) == 1 &&
        input$filtro_cidade != "Todas") {
      
      df <- df %>%
        dplyr::filter(Cidade == input$filtro_cidade)
    }
    
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) == 1 &&
        input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) == 1 &&
        input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    # ----------------------------------------------------------
    # 3. VALIDAR COLUNAS
    # ----------------------------------------------------------
    
    colunas_necessarias <- c(
      "ID_Participante",
      "Tipo_Avaliacao",
      "Uso_Servicos_Financeiros"
    )
    
    if (!all(colunas_necessarias %in% names(df))) {
      return(data.frame())
    }
    
    # ----------------------------------------------------------
    # 4. PREPARAR RESPOSTAS
    # ----------------------------------------------------------
    
    df <- df %>%
      dplyr::mutate(
        ID_Participante = trimws(
          as.character(ID_Participante)
        ),
        Tipo_Avaliacao = trimws(
          as.character(Tipo_Avaliacao)
        ),
        resposta = trimws(
          as.character(Uso_Servicos_Financeiros)
        ),
        Tipo_Avaliacao = dplyr::case_when(
          tolower(Tipo_Avaliacao) == "baseline" ~ "Baseline",
          tolower(Tipo_Avaliacao) == "endline"  ~ "Endline",
          TRUE ~ NA_character_
        )
      ) %>%
      dplyr::filter(
        !is.na(ID_Participante),
        ID_Participante != "",
        !is.na(Tipo_Avaliacao),
        !is.na(resposta),
        resposta != ""
      )
    
    if (nrow(df) == 0) {
      return(data.frame())
    }
    
    # ----------------------------------------------------------
    # 5. CONSOLIDAR POR PARTICIPANTE E AVALIAÇÃO
    # ----------------------------------------------------------
    
    respostas <- df %>%
      dplyr::group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) %>%
      dplyr::summarise(
        resposta = paste(
          unique(resposta),
          collapse = " | "
        ),
        .groups = "drop"
      )
    
    # ----------------------------------------------------------
    # 6. DEFINIR TODAS AS CATEGORIAS
    # ----------------------------------------------------------
    
    opcoes_servicos_grafico <- c(
      "Nenhum destes serviços",
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    )
    
    # ----------------------------------------------------------
    # 7. IDENTIFICAR AS CATEGORIAS SELECCIONADAS
    # ----------------------------------------------------------
    
    dados_longos <- tidyr::crossing(
      respostas,
      servico = opcoes_servicos_grafico
    ) %>%
      dplyr::filter(
        stringr::str_detect(
          resposta,
          stringr::fixed(servico)
        )
      )
    
    # ----------------------------------------------------------
    # 8. NÃO CONTAR "NENHUM" QUANDO EXISTE OUTRO SERVIÇO
    # ----------------------------------------------------------
    
    dados_longos <- dados_longos %>%
      dplyr::group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) %>%
      dplyr::mutate(
        tem_outro_servico = any(
          servico != "Nenhum destes serviços"
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::filter(
        !(
          servico == "Nenhum destes serviços" &
            tem_outro_servico
        )
      ) %>%
      dplyr::distinct(
        ID_Participante,
        Tipo_Avaliacao,
        servico
      )
    
    # ----------------------------------------------------------
    # 9. DENOMINADOR: PARTICIPANTES COM RESPOSTA VÁLIDA
    # ----------------------------------------------------------
    
    denominadores <- respostas %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::summarise(
        total_participantes = dplyr::n_distinct(
          ID_Participante
        ),
        .groups = "drop"
      )
    
    # ----------------------------------------------------------
    # 10. CONTAR PARTICIPANTES POR CATEGORIA
    # ----------------------------------------------------------
    
    frequencias <- dados_longos %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        servico
      ) %>%
      dplyr::summarise(
        n = dplyr::n_distinct(ID_Participante),
        .groups = "drop"
      )
    
    # ----------------------------------------------------------
    # 11. GARANTIR AS 7 CATEGORIAS EM CADA AVALIAÇÃO
    # Mesmo quando uma categoria tem zero respostas
    # ----------------------------------------------------------
    
    resultado <- tidyr::crossing(
      Tipo_Avaliacao = denominadores$Tipo_Avaliacao,
      servico = opcoes_servicos_grafico
    ) %>%
      dplyr::left_join(
        frequencias,
        by = c("Tipo_Avaliacao", "servico")
      ) %>%
      dplyr::left_join(
        denominadores,
        by = "Tipo_Avaliacao"
      ) %>%
      dplyr::mutate(
        n = tidyr::replace_na(n, 0L),
        percent = dplyr::if_else(
          total_participantes > 0,
          100 * n / total_participantes,
          NA_real_
        ),
        percent = round(percent, 1),
        label = paste0(
          n,
          " (",
          format(
            percent,
            nsmall = 1,
            decimal.mark = ","
          ),
          "%)"
        )
      ) %>%
      dplyr::arrange(
        factor(
          servico,
          levels = opcoes_servicos_grafico
        ),
        factor(
          Tipo_Avaliacao,
          levels = c("Baseline", "Endline")
        )
      )
    
    resultado
  })
  
  
  # ============================================================
  # GRÁFICO — TODAS AS CATEGORIAS DE SERVIÇOS FINANCEIROS
  # Fonte: dados_grafico_servicos_financeiros()
  # ============================================================
  
  output$grafico_servicos_financeiros <- plotly::renderPlotly({
    
    freq_data <- dados_grafico_servicos_financeiros()
    
    if (is.null(freq_data) || nrow(freq_data) == 0) {
      return(plotly::plotly_empty())
    }
    
    # Ordenar serviços pela ordem definida na tabela
    ordem_servicos <- c(
      "Nenhum destes serviços",
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    )
    
    freq_data$servico <- factor(
      freq_data$servico,
      levels = ordem_servicos
    )
    
    # Cores das sete categorias
    cores <- c(
      "Nenhum destes serviços" = "#5cd6c7",
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)" = "#f9a825",
      "Crédito ou empréstimo bancário para o negócio" = "#2ca02c",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)" = "#bcbd22",
      "Conta bancária em nome do negócio (conta empresarial)" = "#9442d4",
      "Conta poupança formal ligada ao negócio" = "#ff7f0e",
      "Seguro (de negócio, de equipamento, de saúde...)" = "#d62728"
    )
    
    total_texto <- paste0(
      "Participantes com resposta válida: ",
      paste(
        unique(
          paste0(
            freq_data$Tipo_Avaliacao,
            " = ",
            freq_data$total_participantes
          )
        ),
        collapse = " | "
      )
    )
    
    plotly::plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~percent,
      color = ~servico,
      colors = cores,
      type = "bar",
      text = ~label,
      textposition = "outside",
      cliponaxis = FALSE,
      customdata = ~n,
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      plotly::layout(
        barmode = "group",
        bargap = 0.25,
        bargroupgap = 0.05,
        
        yaxis = list(
          title = "Participantes por categoria (%)",
          range = c(0, 110),
          tickvals = seq(0, 100, 20),
          ticksuffix = "%",
          zeroline = FALSE
        ),
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = c("Baseline", "Endline")
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.30,
          font = list(size = 10)
        ),
        
        margin = list(
          l = 65,
          r = 25,
          t = 55,
          b = 190
        ),
        
        annotations = list(
          list(
            x = 0.5,
            y = 1.12,
            xref = "paper",
            yref = "paper",
            text = total_texto,
            showarrow = FALSE,
            font = list(size = 10)
          )
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        font = list(
          family = "Arial",
          size = 12
        )
      )
  })
  

  # ============================================================
  # TEXTO DINÂMICO — SERVIÇOS FINANCEIROS
  # BASE: Pam_Verde_Indicadores
  # Percentagem de participantes por serviço
  # ============================================================

  output$texto_servicos <- renderUI({

    # ==========================================================
    # 1. BASE ORIGINAL
    # ==========================================================
    df <- Pam_Verde_Indicadores

    # ==========================================================
    # 2. APLICAR FILTROS
    # ==========================================================
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }

    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }

    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>%
        filter(Tipo_Avaliacao == input$filtro_tipo_avaliacao)
    }

    # ==========================================================
    # 3. VALIDAR COLUNAS
    # ==========================================================
    colunas_necessarias <- c(
      "ID_Participante",
      "Tipo_Avaliacao",
      "Uso_Servicos_Financeiros"
    )

    if (!all(colunas_necessarias %in% names(df))) {
      return(
        tags$p(
          "Não foi possível gerar o texto: faltam colunas necessárias na base de dados."
        )
      )
    }

    # ==========================================================
    # 4. PREPARAR RESPOSTAS
    # ==========================================================
    df <- df %>%
      mutate(
        ID_Participante = as.character(ID_Participante),
        Tipo_Avaliacao = trimws(as.character(Tipo_Avaliacao)),
        resposta = trimws(as.character(Uso_Servicos_Financeiros))
      ) %>%
      filter(
        !is.na(ID_Participante),
        ID_Participante != "",
        !is.na(Tipo_Avaliacao),
        Tipo_Avaliacao != "",
        !is.na(resposta),
        resposta != ""
      )

    if (nrow(df) == 0) {
      return(
        tags$p(
          "Não existem respostas válidas para os filtros seleccionados."
        )
      )
    }

    # ==========================================================
    # 5. CONSOLIDAR RESPOSTAS POR PARTICIPANTE E AVALIAÇÃO
    #
    # Evita contar a mesma participante várias vezes
    # no denominador da percentagem.
    # ==========================================================
    respostas <- df %>%
      group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) %>%
      summarise(
        resposta = paste(
          unique(resposta),
          collapse = " | "
        ),
        .groups = "drop"
      )

    # ==========================================================
    # 6. IDENTIFICAR SERVIÇOS
    #
    # Os textos completos são pesquisados sem separar
    # as descrições pelas vírgulas internas.
    # ==========================================================
    opcoes_servicos <- c(
      "Nenhum destes serviços",
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    )

    dados_longos <- tidyr::crossing(
      respostas,
      servico = opcoes_servicos
    ) %>%
      filter(
        stringr::str_detect(
          resposta,
          stringr::fixed(servico)
        )
      )

    # ==========================================================
    # 7. TRATAR "NENHUM DESTES SERVIÇOS"
    # ==========================================================
    dados_longos <- dados_longos %>%
      group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) %>%
      mutate(
        tem_servico = any(
          servico != "Nenhum destes serviços"
        )
      ) %>%
      ungroup() %>%
      filter(
        !(servico == "Nenhum destes serviços" & tem_servico)
      ) %>%
      distinct(
        ID_Participante,
        Tipo_Avaliacao,
        servico
      )

    # ==========================================================
    # 8. DENOMINADOR POR AVALIAÇÃO
    #
    # Uma participante conta uma vez em cada avaliação.
    # ==========================================================
    denominadores <- respostas %>%
      group_by(Tipo_Avaliacao) %>%
      summarise(
        total_participantes = n_distinct(ID_Participante),
        .groups = "drop"
      )

    # ==========================================================
    # 9. FREQUÊNCIAS E PERCENTAGENS POR SERVIÇO
    # ==========================================================
    resumo <- dados_longos %>%
      group_by(
        Tipo_Avaliacao,
        servico
      ) %>%
      summarise(
        n = n_distinct(ID_Participante),
        .groups = "drop"
      ) %>%
      left_join(
        denominadores,
        by = "Tipo_Avaliacao"
      ) %>%
      mutate(
        perc = round(
          100 * n / total_participantes,
          1
        )
      )

    # ==========================================================
    # 10. COMPARAR BASELINE E ENDLINE
    # ==========================================================
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        servico,
        n_baseline = n,
        perc_baseline = perc
      )

    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        servico,
        n_endline = n,
        perc_endline = perc
      )

    comparacao <- full_join(
      baseline,
      endline,
      by = "servico"
    ) %>%
      mutate(
        variacao = perc_endline - perc_baseline
      )

    # ==========================================================
    # 11. CONSTRUIR TEXTO PARA CADA SERVIÇO
    # ==========================================================
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {

        categoria <- comparacao$servico[i]

        base <- comparacao$perc_baseline[i]
        end <- comparacao$perc_endline[i]

        n_base <- comparacao$n_baseline[i]
        n_end <- comparacao$n_endline[i]

        variacao <- comparacao$variacao[i]

        # ------------------------------------------
        # SEM DADOS NUMA DAS AVALIAÇÕES
        # ------------------------------------------
        if (is.na(base) || is.na(end)) {

          return(
            paste0(
              categoria,
              ": não foi possível comparar as duas avaliações por falta de dados numa delas"
            )
          )
        }

        # ------------------------------------------
        # AUMENTO
        # ------------------------------------------
        if (variacao > 0) {

          paste0(
            categoria,
            " passou de ",
            format(base, nsmall = 1, decimal.mark = ","),
            "% (",
            n_base,
            " participantes) no Baseline para ",
            format(end, nsmall = 1, decimal.mark = ","),
            "% (",
            n_end,
            " participantes) no Endline, um aumento de ",
            format(variacao, nsmall = 1, decimal.mark = ","),
            " pontos percentuais"
          )

          # ------------------------------------------
          # REDUÇÃO
          # ------------------------------------------
        } else if (variacao < 0) {

          paste0(
            categoria,
            " passou de ",
            format(base, nsmall = 1, decimal.mark = ","),
            "% (",
            n_base,
            " participantes) no Baseline para ",
            format(end, nsmall = 1, decimal.mark = ","),
            "% (",
            n_end,
            " participantes) no Endline, uma redução de ",
            format(abs(variacao), nsmall = 1, decimal.mark = ","),
            " pontos percentuais"
          )

          # ------------------------------------------
          # SEM ALTERAÇÃO
          # ------------------------------------------
        } else {

          paste0(
            categoria,
            " manteve-se em ",
            format(end, nsmall = 1, decimal.mark = ","),
            "% nas duas avaliações"
          )
        }
      }
    )

    # ==========================================================
    # 12. TEXTO INTRODUTÓRIO
    # ==========================================================
    total_baseline <- denominadores %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      pull(total_participantes)

    total_endline <- denominadores %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      pull(total_participantes)

    if (length(total_baseline) == 0) {
      total_baseline <- NA_integer_
    }

    if (length(total_endline) == 0) {
      total_endline <- NA_integer_
    }

    # ==========================================================
    # 13. TEXTO FINAL
    # ==========================================================
    tags$p(
      style = "margin:0;text-align:justify;",

      tags$b(
        "Utiliza actualmente algum dos seguintes serviços financeiros para o seu negócio?"
      ),

      " A análise apresenta a percentagem de participantes que seleccionou cada serviço em cada avaliação. Como era possível seleccionar mais de um serviço, as percentagens não têm de somar 100%. ",

      if (!is.na(total_baseline)) {
        paste0(
          "No Baseline foram consideradas ",
          total_baseline,
          " participantes com resposta válida"
        )
      } else {
        "Não existem dados válidos do Baseline"
      },

      if (!is.na(total_endline)) {
        paste0(
          " e no Endline ",
          total_endline,
          " participantes com resposta válida"
        )
      } else {
        " e não existem dados válidos do Endline"
      },

      ". ",

      paste(
        texto_categorias,
        collapse = "; "
      ),

      "."
    )
  })

  
  # ============================================================
  # PAM VERDE — UTILIZAÇÃO DE SERVIÇOS FINANCEIROS
  # Indicador TOC: iPAM_RI.7.3
  #
  # Objectivo:
  # Percentagem de empreendedoras que começaram a utilizar
  # pelo menos um serviço financeiro novo entre Baseline e Endline.
  #
  # Regras:
  # - "Nenhum destes serviços" = 0 em todos os serviços.
  # - Resposta ausente = NA, não deve ser convertida em zero.
  # - Só entram no indicador participantes com Baseline e Endline
  #   válidos para os seis serviços.
  # - Novo serviço = Baseline 0 e Endline 1.
  # ============================================================
  
  
  # ------------------------------------------------------------
  # 1. LISTA DOS SERVIÇOS FINANCEIROS
  # ------------------------------------------------------------
  
  servicos_financeiros <- data.frame(
    servico_id = paste0("S", 1:6),
    servico = c(
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    ),
    stringsAsFactors = FALSE
  )
  
  
  # ------------------------------------------------------------
  # 2. FUNÇÃO PARA CRIAR A BASE COM OS SERVIÇOS FINANCEIROS
  # ------------------------------------------------------------
  
  criar_tabela_servicos_financeiros <- function(df) {
    
    # Verificar se existem as colunas necessárias
    colunas_necessarias <- c(
      "ID_Participante",
      "Tipo_Avaliacao",
      "Uso_Servicos_Financeiros"
    )
    
    if (!all(colunas_necessarias %in% names(df))) {
      stop(
        paste(
          "Faltam colunas na base:",
          paste(
            setdiff(colunas_necessarias, names(df)),
            collapse = ", "
          )
        )
      )
    }
    
    # Garantir que os campos são tratados como texto
    df <- df %>%
      dplyr::mutate(
        ID_Participante = as.character(ID_Participante),
        Tipo_Avaliacao = trimws(as.character(Tipo_Avaliacao)),
        resposta = trimws(as.character(Uso_Servicos_Financeiros))
      )
    
    # Uniformizar Baseline e Endline
    df <- df %>%
      dplyr::mutate(
        Tipo_Avaliacao = dplyr::case_when(
          tolower(Tipo_Avaliacao) == "baseline" ~ "Baseline",
          tolower(Tipo_Avaliacao) == "endline"  ~ "Endline",
          TRUE ~ NA_character_
        )
      )
    
    # Remover registos sem identificação ou avaliação reconhecida
    df <- df %>%
      dplyr::filter(
        !is.na(ID_Participante),
        ID_Participante != "",
        !is.na(Tipo_Avaliacao)
      )
    
    # Se não houver registos, devolver uma tabela vazia
    if (nrow(df) == 0) {
      return(data.frame())
    }
    
    # ----------------------------------------------------------
    # 2.1. Consolidar respostas por participante e avaliação
    # ----------------------------------------------------------
    
    respostas <- df %>%
      dplyr::filter(
        !is.na(resposta),
        resposta != ""
      ) %>%
      dplyr::group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) %>%
      dplyr::summarise(
        resposta = paste(unique(resposta), collapse = " | "),
        .groups = "drop"
      )
    
    if (nrow(respostas) == 0) {
      return(data.frame())
    }
    
    # ----------------------------------------------------------
    # 2.2. Criar uma linha por participante, avaliação e serviço
    # ----------------------------------------------------------
    
    dados_binarios <- tidyr::crossing(
      respostas,
      servicos_financeiros
    ) %>%
      dplyr::mutate(
        # Garantir que os textos usados na pesquisa são character
        resposta = as.character(resposta),
        servico = as.character(servico),
        
        # Verificar se a resposta contém o nome do serviço
        utiliza = as.integer(
          vapply(
            seq_len(nrow(dplyr::pick(dplyr::everything()))),
            function(i) {
              grepl(
                servico[i],
                resposta[i],
                fixed = TRUE,
                ignore.case = TRUE
              )
            },
            logical(1)
          )
        )
      ) %>%
      dplyr::select(
        ID_Participante,
        Tipo_Avaliacao,
        servico_id,
        utiliza
      )
    
    # ----------------------------------------------------------
    # 2.3. Organizar os serviços em colunas
    # ----------------------------------------------------------
    
    tabela <- dados_binarios %>%
      tidyr::pivot_wider(
        id_cols = ID_Participante,
        names_from = c(servico_id, Tipo_Avaliacao),
        values_from = utiliza,
        names_glue = "{servico_id}_{tolower(Tipo_Avaliacao)}"
      )
    
    # Garantir que todas as colunas existem
    colunas_baseline <- paste0("S", 1:6, "_baseline")
    colunas_endline  <- paste0("S", 1:6, "_endline")
    
    todas_colunas <- c(colunas_baseline, colunas_endline)
    
    for (col in todas_colunas) {
      if (!col %in% names(tabela)) {
        tabela[[col]] <- NA_integer_
      }
    }
    
    # ----------------------------------------------------------
    # 2.4. Validar a comparação Baseline-Endline
    # ----------------------------------------------------------
    
    tabela$Comparacao_Valida <-
      rowSums(
        is.na(tabela[, colunas_baseline, drop = FALSE])
      ) == 0 &
      rowSums(
        is.na(tabela[, colunas_endline, drop = FALSE])
      ) == 0
    
    # ----------------------------------------------------------
    # 2.5. Calcular novos serviços e serviços deixados de usar
    # ----------------------------------------------------------
    
    tabela$Novos_Servicos <- 0L
    tabela$Servicos_Deixou_Usar <- 0L
    
    for (i in seq_len(6)) {
      
      b <- colunas_baseline[i]
      e <- colunas_endline[i]
      
      novo <- !is.na(tabela[[b]]) &
        !is.na(tabela[[e]]) &
        tabela[[b]] == 0 &
        tabela[[e]] == 1
      
      deixou <- !is.na(tabela[[b]]) &
        !is.na(tabela[[e]]) &
        tabela[[b]] == 1 &
        tabela[[e]] == 0
      
      tabela$Novos_Servicos <-
        tabela$Novos_Servicos + as.integer(novo)
      
      tabela$Servicos_Deixou_Usar <-
        tabela$Servicos_Deixou_Usar + as.integer(deixou)
    }
    
    # Não calcular diferenças quando a comparação não é válida
    tabela$Novos_Servicos[
      !tabela$Comparacao_Valida
    ] <- NA_integer_
    
    tabela$Servicos_Deixou_Usar[
      !tabela$Comparacao_Valida
    ] <- NA_integer_
    
    # ----------------------------------------------------------
    # 2.6. Classificar a evolução da utilização
    # ----------------------------------------------------------
    
    tabela$Aumentou_Uso <- dplyr::case_when(
      !tabela$Comparacao_Valida ~ "Sem comparação",
      tabela$Novos_Servicos > 0 ~ "Sim",
      TRUE ~ "Não"
    )
    
    # ----------------------------------------------------------
    # 2.7. Preparar a tabela final
    # ----------------------------------------------------------
    
    tabela_final <- tabela %>%
      dplyr::select(
        ID_Participante,
        dplyr::all_of(colunas_baseline),
        dplyr::all_of(colunas_endline),
        Novos_Servicos,
        Servicos_Deixou_Usar,
        Aumentou_Uso
      )
    
    names(tabela_final) <- c(
      "ID da Empreendedora",
      paste0("B | ", 1:6),
      paste0("E | ", 1:6),
      "Novos serviços",
      "Serviços que deixou de usar",
      "Aumentou uso?"
    )
    
    tabela_final
  }
  
  
  # ------------------------------------------------------------
  # 3. BASE REACTIVA PARTILHADA
  # ------------------------------------------------------------
  
  tabela_servicos_financeiros <- shiny::reactive({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro por cidade
    if (
      !is.null(input$filtro_cidade) &&
      length(input$filtro_cidade) == 1 &&
      input$filtro_cidade != "Todas"
    ) {
      df <- df %>%
        dplyr::filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro por ciclo
    if (
      !is.null(input$filtro_ciclo) &&
      length(input$filtro_ciclo) == 1 &&
      input$filtro_ciclo != "Todos"
    ) {
      df <- df %>%
        dplyr::filter(Ciclo == input$filtro_ciclo)
    }
    
    criar_tabela_servicos_financeiros(df)
  })
  
  
  # ------------------------------------------------------------
  # 4. MOSTRAR A TABELA NO DASHBOARD
  # ------------------------------------------------------------
  
  output$tabela_novos_servicos_financeiros <- DT::renderDT({
    
    tabela_final <- tabela_servicos_financeiros()
    
    if (nrow(tabela_final) == 0) {
      return(
        DT::datatable(
          data.frame(
            Mensagem = "Não existem respostas válidas para os filtros seleccionados."
          ),
          rownames = FALSE,
          options = list(
            dom = "t"
          )
        )
      )
    }
    
    DT::datatable(
      tabela_final,
      rownames = FALSE,
      filter = "top",
      extensions = "Buttons",
      options = list(
        pageLength = 10,
        scrollX = TRUE,
        autoWidth = FALSE,
        dom = "Bfrtip",
        buttons = c("copy", "csv", "excel"),
        columnDefs = list(
          list(
            targets = 0,
            width = "140px"
          )
        ),
        language = list(
          search = "Pesquisar:",
          lengthMenu = "Mostrar _MENU_ registos",
          info = "A mostrar _START_ a _END_ de _TOTAL_ empreendedoras",
          infoEmpty = "Sem registos",
          zeroRecords = "Nenhuma empreendedora encontrada",
          paginate = list(
            previous = "Anterior",
            `next` = "Seguinte"
          )
        )
      ),
      class = "display compact stripe hover"
    )
  }, server = FALSE)
  
  

  
  # 
  # # ------------------------------------------------------------
  # # 5. CÁLCULO DO INDICADOR TOC iPAM_RI.7.3
  # # ------------------------------------------------------------
  # #
  # # Numerador:
  # # Participantes com pelo menos um novo serviço financeiro.
  # #
  # # Denominador:
  # # Participantes com comparação válida em Baseline e Endline.
  # #
  # # Fórmula:
  # # (Numerador / Denominador) * 100
  # # ------------------------------------------------------------
  # 
  # resultado_indicador_servicos_financeiros <- shiny::reactive({
  #   
  #   tabela_indicador <- tabela_servicos_financeiros()
  #   
  #   if (nrow(tabela_indicador) == 0) {
  #     return(
  #       list(
  #         numerador = 0L,
  #         denominador = 0L,
  #         percentual = NA_real_,
  #         meta = 40,
  #         estado = "Sem dados"
  #       )
  #     )
  #   }
  #   
  #   classificacao <- tabela_indicador[["Aumentou uso?"]]
  #   
  #   # Numerador: participantes que começaram a usar pelo menos
  #   # um serviço financeiro novo
  #   total_sim <- sum(
  #     classificacao == "Sim",
  #     na.rm = TRUE
  #   )
  #   
  #   # Denominador: comparações válidas
  #   total_validos <- sum(
  #     classificacao %in% c("Sim", "Não"),
  #     na.rm = TRUE
  #   )
  #   
  #   percentual <- if (total_validos > 0) {
  #     total_sim / total_validos * 100
  #   } else {
  #     NA_real_
  #   }
  #   
  #   list(
  #     numerador = as.integer(total_sim),
  #     denominador = as.integer(total_validos),
  #     percentual = percentual,
  #     meta = 40,
  #     estado = if (total_validos > 0) {
  #       if (percentual >= 40) "Meta alcançada" else "Abaixo da meta"
  #     } else {
  #       "Sem dados"
  #     }
  #   )
  # })
  # 
  # 
  # # ------------------------------------------------------------
  # # 6. EXEMPLO DE OUTPUT PARA O INDICADOR
  # # ------------------------------------------------------------
  # #
  # # Mantém este output se quiser mostrar o indicador como texto.
  # # Se já tens um valueBox ou outro output, podes usar a mesma
  # # função resultado_indicador_servicos_financeiros() nele.
  # # ------------------------------------------------------------
  # 
  # output$texto_indicador_servicos_financeiros <- shiny::renderText({
  #   
  #   resultado <- resultado_indicador_servicos_financeiros()
  #   
  #   if (is.na(resultado$percentual)) {
  #     return("Sem dados válidos para calcular o indicador.")
  #   }
  #   
  #   paste0(
  #     sprintf("%.1f%%", resultado$percentual),
  #     " (",
  #     resultado$numerador,
  #     "/",
  #     resultado$denominador,
  #     ")"
  #   )
  # })
  # 
  
  #### RETIRAR SALARIO PARA SI
  
  output$grafico_tira_salario <- renderPlotly({
    
    # =========================================================
    # BASE ORIGINAL
    # =========================================================
    df <- Pam_Verde_Indicadores
    
    
    # =========================================================
    # FILTROS
    # =========================================================
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # =========================================================
    # PREPARAÇÃO
    # =========================================================
    df <- df %>%
      filter(
        !is.na(Tira_Salario_Para_Si),
        !is.na(Tipo_Avaliacao)
      )
    
    
    # =========================================================
    # VERIFICAR SE EXISTEM DADOS
    # =========================================================
    if (nrow(df) == 0) {
      return(
        plotly_empty()
      )
    }
    
    
    # =========================================================
    # FREQUÊNCIA E PERCENTAGEM
    # =========================================================
    freq_data <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Tira_Salario_Para_Si
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        pct = round(
          n /
            sum(n) *
            100,
          1
        ),
        
        # Mostrar n + %
        label = paste0(
          n,
          " (",
          pct,
          "%)"
        )
      ) %>%
      
      ungroup()
    
    
    # =========================================================
    # ORDENAR MENOR PARA MAIOR %
    # =========================================================
    ordem_salario <- freq_data %>%
      
      group_by(
        Tira_Salario_Para_Si
      ) %>%
      
      summarise(
        total =
          sum(
            pct,
            na.rm = TRUE
          ),
        
        .groups = "drop"
      ) %>%
      
      arrange(
        total
      ) %>%
      
      pull(
        Tira_Salario_Para_Si
      )
    
    
    freq_data$Tira_Salario_Para_Si <-
      factor(
        freq_data$Tira_Salario_Para_Si,
        levels = ordem_salario
      )
    
    
    # =========================================================
    # CORES
    # =========================================================
    cores <- c(
      
      "Não, não retiro nenhum valor para mim mesma" =
        "#5cd6c7",
      
      "Retiro de forma irregular, conforme o negócio tem dinheiro" =
        "#ff7f0e",
      
      "Sim, retiro um valor fixo todos os meses" =
        "#9442d4"
    )
    
    
    # =========================================================
    # GRÁFICO
    # =========================================================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~Tira_Salario_Para_Si,
      
      colors = cores,
      
      type = "bar",
      
      
      # =======================================================
      # n + %
      # =======================================================
      text = ~label,
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
      ),
      
      
      # =======================================================
      # HOVER
      # =======================================================
      customdata = ~n,
      
      hovertemplate = paste(
        
        "<b>%{x}</b><br>",
        
        "%{fullData.name}<br>",
        
        "Número: %{customdata}<br>",
        
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        # =====================================================
        # BARRAS EMPILHADAS
        # =====================================================
        barmode = "stack",
        
        
        # =====================================================
        # EIXO X
        # =====================================================
        xaxis = list(
          
          title = "",
          
          tickfont = list(
            size = 12
          )
        ),
        
        
        # =====================================================
        # EIXO Y
        # =====================================================
        yaxis = list(
          
          title =
            "Percentagem (%)",
          
          range =
            c(
              0,
              100
            ),
          
          ticksuffix =
            "%"
        ),
        
        
        # =====================================================
        # LEGENDA
        # =====================================================
        legend = list(
          
          orientation =
            "h",
          
          x =
            0.5,
          
          xanchor =
            "center",
          
          y =
            -0.25
        ),
        
        
        # =====================================================
        # MARGENS
        # =====================================================
        margin = list(
          
          l = 60,
          
          r = 20,
          
          t = 20,
          
          b = 130
        ),
        
        
        # =====================================================
        # FUNDO
        # =====================================================
        paper_bgcolor =
          "#f5f3f4",
        
        plot_bgcolor =
          "#f5f3f4"
      )
  })
  
  # ============================================================
  # TEXTO DINÂMICO – RETIRADA DE SALÁRIO
  # BASE ORIGINAL: Pam_Verde_Indicadores
  # ============================================================
  
  output$texto_salario <- renderUI({
    
    # ==========================================================
    # 1. BASE ORIGINAL
    # ==========================================================
    
    df <- Pam_Verde_Indicadores
    
    
    # ==========================================================
    # 2. APLICAR FILTROS
    # ==========================================================
    
    # Filtro por cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro por ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # Filtro por tipo de avaliação
    if (input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # ==========================================================
    # 3. REMOVER DADOS VAZIOS
    # ==========================================================
    
    df <- df %>%
      filter(
        !is.na(Tira_Salario_Para_Si),
        !is.na(Tipo_Avaliacao)
      )
    
    
    # ==========================================================
    # 4. VERIFICAR SE EXISTEM DADOS
    # ==========================================================
    
    if (
      nrow(df) == 0
    ) {
      
      return(NULL)
    }
    
    
    # ==========================================================
    # 5. CALCULAR FREQUÊNCIAS E PERCENTAGENS
    # ==========================================================
    
    resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Tira_Salario_Para_Si
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        perc =
          n /
          sum(n) *
          100
      ) %>%
      
      ungroup()
    
    
    # ==========================================================
    # 6. BASELINE
    # ==========================================================
    
    baseline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Baseline"
      ) %>%
      
      select(
        Tira_Salario_Para_Si,
        perc_baseline = perc
      )
    
    
    # ==========================================================
    # 7. ENDLINE
    # ==========================================================
    
    endline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Endline"
      ) %>%
      
      select(
        Tira_Salario_Para_Si,
        perc_endline = perc
      )
    
    
    # ==========================================================
    # 8. COMPARAÇÃO BASELINE × ENDLINE
    # ==========================================================
    
    comparacao <- full_join(
      
      baseline,
      endline,
      
      by =
        "Tira_Salario_Para_Si"
      
    ) %>%
      
      mutate(
        
        perc_baseline =
          tidyr::replace_na(
            perc_baseline,
            0
          ),
        
        perc_endline =
          tidyr::replace_na(
            perc_endline,
            0
          ),
        
        variacao =
          perc_endline -
          perc_baseline
      )
    
    
    # ==========================================================
    # 9. TEXTO DE CADA CATEGORIA
    # ==========================================================
    
    texto_categorias <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          comparacao$Tira_Salario_Para_Si[i]
        
        base <-
          round(
            comparacao$perc_baseline[i],
            1
          )
        
        end <-
          round(
            comparacao$perc_endline[i],
            1
          )
        
        variacao <-
          round(
            comparacao$variacao[i],
            1
          )
        
        
        # ------------------------------------------------------
        # AUMENTO
        # ------------------------------------------------------
        
        if (
          variacao > 0
        ) {
          
          paste0(
            
            categoria,
            
            " aumentou de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (+",
            
            variacao,
            
            " p.p.)"
          )
        }
        
        
        # ------------------------------------------------------
        # REDUÇÃO
        # ------------------------------------------------------
        
        else if (
          variacao < 0
        ) {
          
          paste0(
            
            categoria,
            
            " reduziu de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (",
            
            variacao,
            
            " p.p.)"
          )
        }
        
        
        # ------------------------------------------------------
        # SEM ALTERAÇÃO
        # ------------------------------------------------------
        
        else {
          
          paste0(
            
            categoria,
            
            " manteve-se em ",
            
            end,
            
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    
    # ==========================================================
    # 10. TEXTO FINAL
    # ==========================================================
    
    tags$p(
      
      style =
        "margin:0;text-align:justify;",
      
      tags$b(
        "Retira regularmente um salário para si mesma?"
      ),
      
      " A comparação entre o Baseline e o Endline permite observar a evolução da prática de retirar um salário do negócio para si própria. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  
  output$grafico_clientes_regulares <- renderPlotly({
    
    # =========================================================
    # BASE ORIGINAL
    # =========================================================
    df <- Pam_Verde_Indicadores
    
    
    # =========================================================
    # FILTROS
    # =========================================================
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    if (input$filtro_tipo_avaliacao != "Todos") {
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # =========================================================
    # PREPARAÇÃO
    # =========================================================
    df <- df %>%
      filter(
        !is.na(Clientes_Regulares_Negocio),
        !is.na(Tipo_Avaliacao)
      )
    
    
    # =========================================================
    # VERIFICAR SE EXISTEM DADOS
    # =========================================================
    if (nrow(df) == 0) {
      return(
        plotly_empty()
      )
    }
    
    
    # =========================================================
    # CRIAR CATEGORIAS
    # =========================================================
    dados_cat <- df %>%
      
      mutate(
        
        categoria = case_when(
          
          Clientes_Regulares_Negocio <= 5 ~
            "0–5",
          
          Clientes_Regulares_Negocio <= 10 ~
            "6–10",
          
          Clientes_Regulares_Negocio <= 20 ~
            "11–20",
          
          TRUE ~
            ">20"
        )
      ) %>%
      
      
      # =======================================================
    # FREQUÊNCIA
    # =======================================================
    count(
      Tipo_Avaliacao,
      categoria,
      name = "n"
    ) %>%
      
      
      # =======================================================
    # PERCENTAGEM
    # =======================================================
    group_by(
      Tipo_Avaliacao
    ) %>%
      
      mutate(
        
        Percent = round(
          100 * n / sum(n),
          1
        ),
        
        
        # =====================================================
        # TEXTO n + %
        # =====================================================
        label = paste0(
          n,
          " (",
          Percent,
          "%)"
        ),
        
        
        # =====================================================
        # TOOLTIP
        # =====================================================
        tooltip = paste0(
          
          "<b>",
          categoria,
          "</b><br>",
          
          "<b>Avaliação:</b> ",
          Tipo_Avaliacao,
          "<br>",
          
          "<b>Número:</b> ",
          n,
          "<br>",
          
          "<b>Percentagem:</b> ",
          Percent,
          "%"
        )
      ) %>%
      
      ungroup()
    
    
    # =========================================================
    # ORDEM DOS FACTORES
    # =========================================================
    dados_cat <- dados_cat %>%
      
      mutate(
        
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c(
            "Baseline",
            "Endline"
          )
        ),
        
        categoria = factor(
          categoria,
          levels = c(
            "0–5",
            "6–10",
            "11–20",
            ">20"
          )
        )
      )
    
    
    # =========================================================
    # CORES
    # =========================================================
    cores <- c(
      
      "0–5" =
        "#5cd6c7",
      
      "6–10" =
        "#ff7f0e",
      
      "11–20" =
        "#F39C12",
      
      ">20" =
        "#9442d4"
    )
    
    
    # =========================================================
    # GRÁFICO GGPLOT
    # =========================================================
    p <- ggplot(
      
      dados_cat,
      
      aes(
        
        x = categoria,
        
        y = Percent,
        
        fill = categoria,
        
        text = tooltip
      )
    ) +
      
      
      # =======================================================
    # BARRAS
    # =======================================================
    geom_col(
      width = 0.7
    ) +
      
      
      # =======================================================
    # LABEL n + %
    # =======================================================
    geom_text(
      
      aes(
        label = label
      ),
      
      vjust = -0.3,
      
      size = 4,
      
      fontface = "bold"
    ) +
      
      
      # =======================================================
    # BASELINE / ENDLINE
    # =======================================================
    facet_wrap(
      
      ~Tipo_Avaliacao,
      
      nrow = 1
    ) +
      
      
      # =======================================================
    # CORES
    # =======================================================
    scale_fill_manual(
      
      values = cores
    ) +
      
      
      # =======================================================
    # EIXO Y
    # =======================================================
    scale_y_continuous(
      
      limits = c(
        0,
        100
      ),
      
      expand =
        expansion(
          mult =
            c(
              0,
              0.08
            )
        )
    ) +
      
      
      # =======================================================
    # LABELS
    # =======================================================
    labs(
      
      title = "",
      
      x = "",
      
      y = ""
    ) +
      
      
      # =======================================================
    # TEMA
    # =======================================================
    theme_stata() +
      
      theme(
        
        legend.position =
          "none",
        
        strip.text =
          element_text(
            size = 13,
            face = "bold"
          ),
        
        plot.background =
          element_rect(
            fill = "#f5f3f4",
            color = NA
          ),
        
        panel.background =
          element_rect(
            fill = "#f5f3f4",
            color = NA
          ),
        
        strip.background =
          element_rect(
            fill = "#f5f3f4",
            color = NA
          )
      )
    
    
    # =========================================================
    # CONVERTER PARA PLOTLY
    # =========================================================
    ggplotly(
      
      p,
      
      tooltip = "text"
      
    ) %>%
      
      layout(
        
        title = "",
        
        
        # =====================================================
        # EIXO X
        # =====================================================
        xaxis = list(
          
          title = "",
          
          tickfont =
            list(
              size = 12
            )
        ),
        
        
        # =====================================================
        # EIXO Y
        # =====================================================
        yaxis = list(
          
          title =
            "Percentagem (%)",
          
          range =
            c(
              0,
              100
            ),
          
          ticksuffix =
            "%"
        ),
        
        
        # =====================================================
        # MARGENS
        # =====================================================
        margin = list(
          
          l = 60,
          
          r = 20,
          
          t = 30,
          
          b = 80
        ),
        
        
        # =====================================================
        # FUNDO
        # =====================================================
        paper_bgcolor =
          "#f5f3f4",
        
        plot_bgcolor =
          "#f5f3f4"
      )
  })
  
   
  
  output$texto_clientes <- renderUI({
    
    # ==========================================================
    # 1. BASE ORIGINAL
    # ==========================================================
    
    df <- Pam_Verde_Indicadores
    
    
    # ==========================================================
    # 2. APLICAR FILTROS
    # ==========================================================
    
    # Filtro por cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro por ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # Filtro por tipo de avaliação
    if (input$filtro_tipo_avaliacao != "Todos") {
      
      df <- df %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
    }
    
    
    # ==========================================================
    # 3. REMOVER DADOS VAZIOS
    # ==========================================================
    
    df <- df %>%
      filter(
        !is.na(Clientes_Regulares_Negocio),
        !is.na(Tipo_Avaliacao)
      )
    
    
    # ==========================================================
    # 4. VERIFICAR SE EXISTEM DADOS
    # ==========================================================
    
    if (
      nrow(df) == 0
    ) {
      
      return(
        tags$p(
          style =
            "margin:0;text-align:justify;",
          
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    
    # ==========================================================
    # 5. CRIAR CATEGORIAS
    # ==========================================================
    
    resumo <- df %>%
      
      mutate(
        
        categoria =
          case_when(
            
            Clientes_Regulares_Negocio <= 5 ~
              "0–5",
            
            Clientes_Regulares_Negocio <= 10 ~
              "6–10",
            
            Clientes_Regulares_Negocio <= 20 ~
              "11–20",
            
            TRUE ~
              ">20"
          )
      ) %>%
      
      count(
        Tipo_Avaliacao,
        categoria,
        name = "n"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        perc =
          round(
            n /
              sum(n) *
              100,
            1
          )
      ) %>%
      
      ungroup()
    
    
    # ==========================================================
    # 6. BASELINE
    # ==========================================================
    
    baseline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Baseline"
      ) %>%
      
      select(
        categoria,
        perc_baseline = perc
      )
    
    
    # ==========================================================
    # 7. ENDLINE
    # ==========================================================
    
    endline <- resumo %>%
      
      filter(
        Tipo_Avaliacao == "Endline"
      ) %>%
      
      select(
        categoria,
        perc_endline = perc
      )
    
    
    # ==========================================================
    # 8. COMPARAÇÃO BASELINE × ENDLINE
    # ==========================================================
    
    comparacao <- full_join(
      
      baseline,
      endline,
      
      by =
        "categoria"
      
    ) %>%
      
      mutate(
        
        perc_baseline =
          tidyr::replace_na(
            perc_baseline,
            0
          ),
        
        perc_endline =
          tidyr::replace_na(
            perc_endline,
            0
          ),
        
        variacao =
          round(
            perc_endline -
              perc_baseline,
            1
          )
      )
    
    
    # ==========================================================
    # 9. ORDENAR CATEGORIAS
    # ==========================================================
    
    ordem_categorias <- c(
      "0–5",
      "6–10",
      "11–20",
      ">20"
    )
    
    comparacao <- comparacao %>%
      
      mutate(
        
        categoria =
          factor(
            categoria,
            levels =
              ordem_categorias
          )
      ) %>%
      
      arrange(
        categoria
      )
    
    
    # ==========================================================
    # 10. CRIAR FRASES
    # ==========================================================
    
    frases <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          as.character(
            comparacao$categoria[i]
          )
        
        base <-
          comparacao$perc_baseline[i]
        
        end <-
          comparacao$perc_endline[i]
        
        var <-
          comparacao$variacao[i]
        
        
        # ------------------------------------------------------
        # AUMENTO
        # ------------------------------------------------------
        
        if (
          var > 0
        ) {
          
          paste0(
            
            "A categoria ",
            
            categoria,
            
            " aumentou de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (+",
            
            var,
            
            " p.p.)."
          )
        }
        
        
        # ------------------------------------------------------
        # REDUÇÃO
        # ------------------------------------------------------
        
        else if (
          var < 0
        ) {
          
          paste0(
            
            "A categoria ",
            
            categoria,
            
            " reduziu de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (",
            
            var,
            
            " p.p.)."
          )
        }
        
        
        # ------------------------------------------------------
        # SEM ALTERAÇÃO
        # ------------------------------------------------------
        
        else {
          
          paste0(
            
            "A categoria ",
            
            categoria,
            
            " manteve-se em ",
            
            end,
            
            "% entre o Baseline e o Endline."
          )
        }
      }
    )
    
    
    # ==========================================================
    # 11. TEXTO FINAL
    # ==========================================================
    
    tags$p(
      
      style =
        "margin:0;text-align:justify;",
      
      tags$b(
        "Quantos clientes regulares tem actualmente no seu negócio?"
      ),
      
      " A comparação entre o Baseline e o Endline mostra a evolução da distribuição dos negócios segundo o número de clientes regulares. ",
      
      paste(
        frases,
        collapse = " "
      )
    )
  })
  
  output$tabela_local_venda <- renderDT({
    
    # ==========================================================
    # 1. BASE ORIGINAL
    # ==========================================================
    
    dados <- Pam_Verde_Indicadores
    
    
    # ==========================================================
    # 2. FILTRO CIDADE
    # ==========================================================
    
    if (input$filtro_cidade != "Todas") {
      
      dados <- dados %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # ==========================================================
    # 3. FILTRO CICLO
    # ==========================================================
    
    if (input$filtro_ciclo != "Todos") {
      
      dados <- dados %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # ==========================================================
    # 4. IDENTIFICAR PARTICIPANTES PAREADOS
    # ==========================================================
    
    ids_pareados <- dados %>%
      
      filter(
        Tipo_Avaliacao %in%
          c("Baseline", "Endline"),
        
        !is.na(Nome_Participante),
        
        Nome_Participante != ""
      ) %>%
      
      distinct(
        Nome_Participante,
        Tipo_Avaliacao
      ) %>%
      
      group_by(
        Nome_Participante
      ) %>%
      
      summarise(
        
        n_avaliacoes =
          n_distinct(
            Tipo_Avaliacao
          ),
        
        .groups = "drop"
      ) %>%
      
      filter(
        n_avaliacoes == 2
      )
    
    
    # ==========================================================
    # 5. SE NÃO EXISTIREM PAREADOS
    # ==========================================================
    
    if (
      nrow(ids_pareados) == 0
    ) {
      
      return(
        datatable(
          data.frame(
            Informação =
              "Não existem participantes com Baseline e Endline."
          ),
          options =
            list(
              dom = "t"
            ),
          rownames = FALSE
        )
      )
    }
    
    
    # ==========================================================
    # 6. TOTAL DE PARTICIPANTES
    # ==========================================================
    
    total_pareados <-
      nrow(ids_pareados)
    
    
    # ==========================================================
    # 7. PREPARAR DADOS
    # ==========================================================
    
    dados_venda <- dados %>%
      
      filter(
        
        Nome_Participante %in%
          ids_pareados$Nome_Participante,
        
        Tipo_Avaliacao %in%
          c("Baseline", "Endline"),
        
        !is.na(Onde_vende),
        
        Onde_vende != ""
      ) %>%
      
      separate_rows(
        Onde_vende,
        sep = ","
      ) %>%
      
      mutate(
        
        Onde_vende =
          trimws(Onde_vende)
      ) %>%
      
      distinct(
        Nome_Participante,
        Tipo_Avaliacao,
        Onde_vende
      )
    
    
    # ==========================================================
    # 8. CONTAGEM
    # ==========================================================
    
    dados_n <- dados_venda %>%
      
      count(
        Onde_vende,
        Tipo_Avaliacao,
        name = "n"
      )
    
    
    # ==========================================================
    # 9. TRANSFORMAR BASELINE / ENDLINE EM COLUNAS
    # ==========================================================
    
    tabela <- dados_n %>%
      
      tidyr::pivot_wider(
        
        names_from =
          Tipo_Avaliacao,
        
        values_from =
          n,
        
        values_fill =
          0
      )
    
    
    # ==========================================================
    # 10. GARANTIR AS DUAS COLUNAS
    # ==========================================================
    
    if (!"Baseline" %in% names(tabela)) {
      tabela$Baseline <- 0
    }
    
    if (!"Endline" %in% names(tabela)) {
      tabela$Endline <- 0
    }
    
    
    # ==========================================================
    # 11. CALCULAR PERCENTAGENS
    # ==========================================================
    
    tabela <- tabela %>%
      
      mutate(
        
        Baseline_Percent =
          round(
            Baseline /
              total_pareados *
              100,
            1
          ),
        
        Endline_Percent =
          round(
            Endline /
              total_pareados *
              100,
            1
          ),
        
        Variacao =
          round(
            Endline_Percent -
              Baseline_Percent,
            1
          )
      )
    
    
    # ==========================================================
    # 12. CRIAR TEXTO N (%)
    # ==========================================================
    
    tabela <- tabela %>%
      
      mutate(
        
        Baseline =
          paste0(
            Baseline,
            " (",
            Baseline_Percent,
            "%)"
          ),
        
        Endline =
          paste0(
            Endline,
            " (",
            Endline_Percent,
            "%)"
          ),
        
        Variacao =
          paste0(
            ifelse(
              Variacao > 0,
              "+",
              ""
            ),
            Variacao,
            " p.p."
          )
      ) %>%
      
      select(
        Onde_vende,
        Baseline,
        Endline,
        Variacao
      ) %>%
      
      rename(
        
        `Local de venda` =
          Onde_vende,
        
        `Baseline` =
          Baseline,
        
        `Endline` =
          Endline,
        
        `Variação` =
          Variacao
      )
    
    
    # ==========================================================
    # 13. TABELA DT
    # ==========================================================
    
    datatable(
      
      tabela,
      
      rownames = FALSE,
      
      class =
        "cell-border stripe hover",
      
      options =
        list(
          
          pageLength = 10,
          
          lengthMenu =
            c(
              5,
              10,
              25,
              50
            ),
          
          searching = FALSE,
          
          ordering = FALSE,
          
          info = TRUE,
          
          autoWidth = TRUE,
          
          dom =
            "t"
        ),
      
      colnames =
        c(
          "Local de venda",
          "Baseline",
          "Endline",
          "Variação"
        )
      
    ) %>%
      
      formatStyle(
        
        "Local de venda",
        
        fontWeight =
          "bold"
      ) %>%
      
      formatStyle(
        
        "Variação",
        
        fontWeight =
          "bold"
      )
  })
 
  output$texto_local_venda <- renderUI({
    
    dados <- Pam_Verde_Indicadores
    
    # ==========================================================
    # FILTROS
    # ==========================================================
    
    if (input$filtro_cidade != "Todas") {
      dados <- dados %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      dados <- dados %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    
    # ==========================================================
    # PARTICIPANTES PAREADOS
    # ==========================================================
    
    ids_pareados <- dados %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Nome_Participante),
        Nome_Participante != ""
      ) %>%
      distinct(
        Nome_Participante,
        Tipo_Avaliacao
      ) %>%
      group_by(Nome_Participante) %>%
      summarise(
        n_avaliacoes = n_distinct(Tipo_Avaliacao),
        .groups = "drop"
      ) %>%
      filter(n_avaliacoes == 2)
    
    
    if (nrow(ids_pareados) == 0) {
      
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem participantes com dados pareados entre o Baseline e o Endline para apresentar uma leitura comparativa."
        )
      )
    }
    
    
    total_pareados <- nrow(ids_pareados)
    
    
    # ==========================================================
    # DADOS DE LOCAL DE VENDA
    # ==========================================================
    
    dados_venda <- dados %>%
      filter(
        Nome_Participante %in% ids_pareados$Nome_Participante,
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Onde_vende),
        Onde_vende != ""
      ) %>%
      separate_rows(
        Onde_vende,
        sep = ","
      ) %>%
      mutate(
        Onde_vende = trimws(Onde_vende)
      ) %>%
      distinct(
        Nome_Participante,
        Tipo_Avaliacao,
        Onde_vende
      )
    
    
    if (nrow(dados_venda) == 0) {
      
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não foram identificados dados válidos sobre os locais de venda para os participantes pareados."
        )
      )
    }
    
    
    # ==========================================================
    # CONTAGEM E PERCENTAGEM
    # ==========================================================
    
    resumo <- dados_venda %>%
      count(
        Onde_vende,
        Tipo_Avaliacao,
        name = "n"
      ) %>%
      tidyr::pivot_wider(
        names_from = Tipo_Avaliacao,
        values_from = n,
        values_fill = 0
      )
    
    
    if (!"Baseline" %in% names(resumo)) {
      resumo$Baseline <- 0
    }
    
    if (!"Endline" %in% names(resumo)) {
      resumo$Endline <- 0
    }
    
    
    resumo <- resumo %>%
      mutate(
        Baseline_pct =
          Baseline / total_pareados * 100,
        
        Endline_pct =
          Endline / total_pareados * 100,
        
        Variacao =
          Endline_pct - Baseline_pct
      )
    
    
    # ==========================================================
    # IDENTIFICAR MAIOR AUMENTO
    # ==========================================================
    
    maior_aumento <- resumo %>%
      filter(Variacao > 0) %>%
      arrange(desc(Variacao)) %>%
      slice(1)
    
    
    # ==========================================================
    # IDENTIFICAR MAIOR REDUÇÃO
    # ==========================================================
    
    maior_reducao <- resumo %>%
      filter(Variacao < 0) %>%
      arrange(Variacao) %>%
      slice(1)
    
    
    # ==========================================================
    # TOTAL DE CANAIS
    # ==========================================================
    
    n_canais <- n_distinct(
      dados_venda$Onde_vende
    )
    
    
    # ==========================================================
    # CONSTRUIR LEITURA
    # ==========================================================
    
    texto <- paste0(
      
      "A tabela apresenta a distribuição dos participantes pareados ",
      "segundo os locais de venda reportados no Baseline e no Endline. ",
      
      "A análise considera ",
      total_pareados,
      " participantes com informação disponível nos dois momentos ",
      "de avaliação e ",
      n_canais,
      " locais de venda identificados."
    )
    
    
    # ==========================================================
    # ADICIONAR MAIOR AUMENTO
    # ==========================================================
    
    if (nrow(maior_aumento) > 0) {
      
      texto <- paste0(
        
        texto,
        
        " Entre os canais apresentados, ",
        
        maior_aumento$Onde_vende,
        
        " registou o maior aumento, passando de ",
        
        round(
          maior_aumento$Baseline_pct,
          1
        ),
        
        "% no Baseline para ",
        
        round(
          maior_aumento$Endline_pct,
          1
        ),
        
        "% no Endline, correspondendo a um aumento de ",
        
        round(
          maior_aumento$Variacao,
          1
        ),
        
        " pontos percentuais."
      )
    }
    
    
    # ==========================================================
    # ADICIONAR MAIOR REDUÇÃO
    # ==========================================================
    
    if (nrow(maior_reducao) > 0) {
      
      texto <- paste0(
        
        texto,
        
        " Por outro lado, ",
        
        maior_reducao$Onde_vende,
        
        " apresentou a maior redução, passando de ",
        
        round(
          maior_reducao$Baseline_pct,
          1
        ),
        
        "% para ",
        
        round(
          maior_reducao$Endline_pct,
          1
        ),
        
        "%, uma variação de ",
        
        round(
          maior_reducao$Variacao,
          1
        ),
        
        " pontos percentuais."
      )
    }
    
    
    # ==========================================================
    # NOTA SOBRE RESPOSTAS MÚLTIPLAS
    # ==========================================================
    
    texto <- paste0(
      
      texto,
      
      " Como os participantes podem indicar mais de um local de venda, ",
      "as percentagens representam a proporção de participantes que ",
      "reportaram cada canal e, por isso, não devem necessariamente ",
      "somar 100%."
    )
    
    
    tags$p(
      style = "margin:0;text-align:justify;",
      texto
    )
  })

  # ##----------------------------------------------------------- 
  # ###################                  3 PAGINA SOFT SKILL
  # ##-----------------------------------------------------------------------------  
  # #################################################
  # # GRAFICO CONFIANÇA
  # #################################################
  # # Dados filtrados reativos
  
  # ============================================================
  # GRÁFICO — TOMADA DE DECISÃO NO NEGÓCIO
  # BASELINE VS ENDLINE
  # ============================================================
  
  output$grafico_triang_empilhado <- renderPlotly({
    
    # ============================================================
    # 1. BASE DE DADOS
    # ============================================================
    
    df <- Pam_Verde_Indicadores
    
    
    # ============================================================
    # 2. FILTRO — CIDADE
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # ============================================================
    # 3. FILTRO — CICLO
    # ============================================================
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # ============================================================
    # 4. VERIFICAR VARIÁVEIS
    # ============================================================
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      "Quem_Toma_Decisoes_Negocio" %in% names(df)
    )
    
    
    # ============================================================
    # 5. MANTER BASELINE E ENDLINE
    # ============================================================
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        ),
        
        !is.na(Tipo_Avaliacao),
        
        !is.na(
          Quem_Toma_Decisoes_Negocio
        ),
        
        Quem_Toma_Decisoes_Negocio != ""
      )
    
    
    # ============================================================
    # 6. VERIFICAR SE EXISTEM DADOS
    # ============================================================
    
    if (nrow(df) == 0) {
      
      return(
        plotly_empty()
      )
    }
    
    
    # ============================================================
    # 7. RESUMO DOS DADOS
    # ============================================================
    
    df_resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Quem_Toma_Decisoes_Negocio
      ) %>%
      
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        Percentagem = round(
          Total /
            sum(Total) *
            100,
          1
        )
        
      ) %>%
      
      ungroup()
    
    
    # ============================================================
    # 8. GARANTIR TODAS AS CATEGORIAS
    #    NOS DOIS MOMENTOS
    # ============================================================
    
    categorias <- unique(
      df_resumo$Quem_Toma_Decisoes_Negocio
    )
    
    
    df_resumo <- df_resumo %>%
      
      tidyr::complete(
        
        Tipo_Avaliacao = c(
          "Baseline",
          "Endline"
        ),
        
        Quem_Toma_Decisoes_Negocio =
          categorias,
        
        fill = list(
          Total = 0,
          Percentagem = 0
        )
      )
    
    
    # ============================================================
    # 9. REORDENAR AS CATEGORIAS
    # ============================================================
    
    # Definir uma única ordem com base no Endline e aplicá-la aos dois momentos.
    ordem_decisao <- df_resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      arrange(Percentagem) %>%
      pull(Quem_Toma_Decisoes_Negocio) %>%
      as.character()
    
    ordem_decisao <- unique(c(
      ordem_decisao,
      as.character(df_resumo$Quem_Toma_Decisoes_Negocio)
    ))
    
    
    df_resumo <- df_resumo %>%
      
      mutate(
        
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c(
            "Baseline",
            "Endline"
          )
        ),
        
        Quem_Toma_Decisoes_Negocio =
          factor(
            Quem_Toma_Decisoes_Negocio,
            levels = ordem_decisao
          )
      )
    
    
    # ============================================================
    # 10. CORES
    # ============================================================
    
    cores <- c(
      
      "Só eu" =
        "#9442d4",
      
      "Eu juntamente com outra pessoa" =
        "#ff7f0e",
      
      "Outra pessoa" =
        "#5cd6c7"
    )
    
    
    # ============================================================
    # 11. CORES PARA EVENTUAIS CATEGORIAS NOVAS
    # ============================================================
    
    categorias_extra <- setdiff(
      
      levels(
        df_resumo$Quem_Toma_Decisoes_Negocio
      ),
      
      names(cores)
    )
    
    
    if (length(categorias_extra) > 0) {
      
      cores_extra <- c(
        
        "#42A5F5",
        "#f9a825",
        "#7E57C2",
        "#26A69A",
        "#EF5350",
        "#8D6E63"
      )
      
      
      cores <- c(
        
        cores,
        
        setNames(
          
          rep(
            cores_extra,
            length.out =
              length(categorias_extra)
          ),
          
          categorias_extra
        )
      )
    }
    
    
    # ============================================================
    # 12. CRIAR RÓTULO
    #    n (percentagem)
    # ============================================================
    
    df_resumo <- df_resumo %>%
      
      mutate(
        
        texto = ifelse(
          
          Percentagem > 0,
          
          paste0(
            Total,
            " (",
            format(
              Percentagem,
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          
          ""
        )
      )
    
    
    # ============================================================
    # 13. GRÁFICO
    # ============================================================
    
    plot_ly(
      
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      
      y = ~Percentagem,
      
      color =
        ~Quem_Toma_Decisoes_Negocio,
      
      colors = cores,
      
      type = "bar",
      
      # ----------------------------------------------------------
      # TEXTO DENTRO DA BARRA
      # ----------------------------------------------------------
      
      text = ~texto,
      
      texttemplate = "%{text}",
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      # ----------------------------------------------------------
      # HOVER
      # ----------------------------------------------------------
      
      customdata = ~Total,
      
      hovertemplate = paste0(
        
        "<b>%{x}</b><br>",
        
        "%{fullData.name}<br>",
        
        "Participantes: %{customdata}<br>",
        
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        # --------------------------------------------------------
        # BARRA EMPILHADA
        # --------------------------------------------------------
        
        barmode = "stack",
        
        
        # --------------------------------------------------------
        # EIXO X
        # --------------------------------------------------------
        
        xaxis = list(
          
          title = "",
          
          categoryorder = "array",
          
          categoryarray = c(
            "Baseline",
            "Endline"
          )
        ),
        
        
        # --------------------------------------------------------
        # EIXO Y
        # --------------------------------------------------------
        
        yaxis = list(
          
          title = "Percentagem (%)",
          
          range = c(
            0,
            100
          ),
          
          tickmode = "array",
          
          tickvals = seq(
            0,
            100,
            20
          ),
          
          ticktext = paste0(
            seq(
              0,
              100,
              20
            ),
            "%"
          )
        ),
        
        
        # --------------------------------------------------------
        # LEGENDA
        # --------------------------------------------------------
        
        legend = list(
          
          orientation = "h",
          
          x = 0.5,
          
          xanchor = "center",
          
          y = -0.30
        ),
        
        
        # --------------------------------------------------------
        # MARGENS
        # --------------------------------------------------------
        
        margin = list(
          
          l = 70,
          
          r = 20,
          
          t = 20,
          
          b = 160
        ),
        
        
        # --------------------------------------------------------
        # FUNDO
        # --------------------------------------------------------
        
        paper_bgcolor =
          "#f5f3f4",
        
        plot_bgcolor =
          "#f5f3f4"
      ) %>%
      
      config(
        
        displayModeBar = TRUE,
        
        displaylogo = FALSE,
        
        responsive = TRUE,
        
        toImageButtonOptions = list(
          
          format = "png",
          
          filename =
            "tomada_decisao_baseline_endline",
          
          height = 800,
          
          width = 1600,
          
          scale = 3
        )
      )
  })
  
  
  # ============================================================
  # LEITURA — TOMADA DE DECISÃO
  # ============================================================
  
  output$texto_decisoes <- renderUI({
    
    # ============================================================
    # 1. BASE DE DADOS
    # ============================================================
    
    df <- Pam_Verde_Indicadores
    
    
    # ============================================================
    # 2. FILTRO — CIDADE
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # ============================================================
    # 3. FILTRO — CICLO
    # ============================================================
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    # ============================================================
    # 4. FILTRAR BASELINE E ENDLINE
    # ============================================================
    
    df <- df %>%
      filter(
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        ),
        
        !is.na(
          Quem_Toma_Decisoes_Negocio
        ),
        
        Quem_Toma_Decisoes_Negocio != "",
        
        !is.na(Tipo_Avaliacao)
      )
    
    
    # ============================================================
    # 5. VERIFICAR DADOS
    # ============================================================
    
    if (nrow(df) == 0) {
      
      return(
        
        tags$p(
          
          style =
            "margin:0;text-align:justify;",
          
          "Não existem dados disponíveis para apresentar a leitura sobre a tomada de decisão."
        )
      )
    }
    
    
    # ============================================================
    # 6. RESUMO
    # ============================================================
    
    resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Quem_Toma_Decisoes_Negocio
      ) %>%
      
      summarise(
        
        n = n(),
        
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        perc =
          n /
          sum(n) *
          100
      ) %>%
      
      ungroup()
    
    
    # ============================================================
    # 7. BASELINE
    # ============================================================
    
    baseline <- resumo %>%
      
      filter(
        Tipo_Avaliacao ==
          "Baseline"
      ) %>%
      
      select(
        
        Quem_Toma_Decisoes_Negocio,
        
        perc_baseline =
          perc
      )
    
    
    # ============================================================
    # 8. ENDLINE
    # ============================================================
    
    endline <- resumo %>%
      
      filter(
        Tipo_Avaliacao ==
          "Endline"
      ) %>%
      
      select(
        
        Quem_Toma_Decisoes_Negocio,
        
        perc_endline =
          perc
      )
    
    
    # ============================================================
    # 9. COMPARAÇÃO
    # ============================================================
    
    comparacao <- full_join(
      
      baseline,
      
      endline,
      
      by =
        "Quem_Toma_Decisoes_Negocio"
      
    ) %>%
      
      mutate(
        
        perc_baseline =
          tidyr::replace_na(
            perc_baseline,
            0
          ),
        
        perc_endline =
          tidyr::replace_na(
            perc_endline,
            0
          ),
        
        variacao =
          perc_endline -
          perc_baseline
      )
    
    
    # ============================================================
    # 10. CRIAR LEITURA DE CADA CATEGORIA
    # ============================================================
    
    texto_categorias <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          comparacao$Quem_Toma_Decisoes_Negocio[i]
        
        base <-
          round(
            comparacao$perc_baseline[i],
            1
          )
        
        end <-
          round(
            comparacao$perc_endline[i],
            1
          )
        
        variacao <-
          round(
            comparacao$variacao[i],
            1
          )
        
        
        # --------------------------------------------------------
        # AUMENTO
        # --------------------------------------------------------
        
        if (variacao > 0) {
          
          paste0(
            
            categoria,
            
            " aumentou de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (+",
            
            variacao,
            
            " p.p.)"
          )
          
          
          # --------------------------------------------------------
          # REDUÇÃO
          # --------------------------------------------------------
          
        } else if (variacao < 0) {
          
          paste0(
            
            categoria,
            
            " reduziu de ",
            
            base,
            
            "% no Baseline para ",
            
            end,
            
            "% no Endline (",
            
            variacao,
            
            " p.p.)"
          )
          
          
          # --------------------------------------------------------
          # SEM ALTERAÇÃO
          # --------------------------------------------------------
          
        } else {
          
          paste0(
            
            categoria,
            
            " manteve-se em ",
            
            end,
            
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    
    # ============================================================
    # 11. TEXTO FINAL
    # ============================================================
    
    texto <- paste(
      
      texto_categorias,
      
      collapse = "; "
    )
    
    
    # ============================================================
    # 12. OUTPUT
    # ============================================================
    
    tags$p(
      
      style =
        "margin:0;text-align:justify;",
      
      tags$b(
        "Quem costuma tomar as principais decisões sobre o seu negócio? "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a distribuição das responsabilidades pela tomada de decisões no negócio. ",
      
      texto,
      
      "."
    )
  })
  
  
  
  output$grafico_negociacao_3meses <- renderPlotly({
    
    # ============================================================
    # BASE DE DADOS
    # ============================================================
    
    df <- Pam_Verde_Indicadores
    
    # ============================================================
    # FILTRO POR CIDADE
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # ============================================================
    # FILTRO POR CICLO
    # ============================================================
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ============================================================
    # VALIDAR VARIÁVEIS
    # ============================================================
    
    req(all(c(
      "Tipo_Avaliacao",
      "Praticou_negociação_nos_últimos_3meses"
    ) %in% colnames(df)))
    
    req(nrow(df) > 0)
    
    
    # ============================================================
    # PREPARAÇÃO DOS DADOS
    # ============================================================
    
    df_resumo <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(Praticou_negociação_nos_últimos_3meses),
        Praticou_negociação_nos_últimos_3meses != ""
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Praticou_negociação_nos_últimos_3meses
      ) %>%
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percent = round(
          Total / sum(Total) * 100,
          1
        )
      ) %>%
      ungroup()
    
    
    if (nrow(df_resumo) == 0) {
      return(plotly_empty())
    }
    
    
    # ============================================================
    # GARANTIR TODAS AS CATEGORIAS
    # ============================================================
    
    categorias <- unique(
      df_resumo$Praticou_negociação_nos_últimos_3meses
    )
    
    df_resumo <- df_resumo %>%
      tidyr::complete(
        Tipo_Avaliacao = c("Baseline", "Endline"),
        Praticou_negociação_nos_últimos_3meses = categorias,
        fill = list(
          Total = 0,
          Percent = 0
        )
      )
    
    
    # ============================================================
    # ORDEM DAS CATEGORIAS
    # ============================================================
    
    # Definir a ordem com base no Endline e mantê-la nos dois momentos.
    ordem_negociacao <- df_resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      arrange(Percent) %>%
      pull(Praticou_negociação_nos_últimos_3meses) %>%
      as.character()
    
    ordem_negociacao <- unique(c(
      ordem_negociacao,
      as.character(df_resumo$Praticou_negociação_nos_últimos_3meses)
    ))
    
    
    df_resumo <- df_resumo %>%
      mutate(
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c("Baseline", "Endline")
        ),
        
        Praticou_negociação_nos_últimos_3meses = factor(
          Praticou_negociação_nos_últimos_3meses,
          levels = ordem_negociacao
        )
      )
    
    
    # ============================================================
    # TEXTO DAS BARRAS: n (%)
    # ============================================================
    
    df_resumo <- df_resumo %>%
      mutate(
        texto = ifelse(
          Percent > 0,
          paste0(
            Total,
            " (",
            format(
              Percent,
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          ""
        )
      )
    
    
    # ============================================================
    # CORES
    # ============================================================
    
    cores <- c(
      "Não tive situações de negociação neste período" = "#69C7BE",
      "Não, aceitei as condições sem negociar" = "#F39C12",
      "Sim, negociei, mas não consegui mudar as condições" = "#F37238",
      "Sim, negociei e consegui um acordo favorável para o meu negócio" = "#9442d4"
    )
    
    
    # ============================================================
    # GRÁFICO
    # ============================================================
    
    plot_ly(
      data = df_resumo,
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      color = ~Praticou_negociação_nos_últimos_3meses,
      colors = cores,
      type = "bar",
      
      text = ~texto,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      customdata = ~Total,
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      layout(
        barmode = "stack",
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = c(
            "Baseline",
            "Endline"
          )
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          tickmode = "array",
          tickvals = seq(0, 100, 20),
          ticktext = paste0(
            seq(0, 100, 20),
            "%"
          )
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.30
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 170
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      ) %>%
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        toImageButtonOptions = list(
          format = "png",
          filename = "negociacao_ultimos_3_meses",
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  })
  
  output$texto_negociacao_3meses <- renderUI({
    
    # ============================================================
    # BASE DE DADOS
    # ============================================================
    
    df <- Pam_Verde_Indicadores
    
    # ============================================================
    # FILTRO POR CIDADE
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # ============================================================
    # FILTRO POR CICLO
    # ============================================================
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ============================================================
    # VALIDAR VARIÁVEIS
    # ============================================================
    
    req(all(c(
      "Tipo_Avaliacao",
      "Praticou_negociação_nos_últimos_3meses"
    ) %in% colnames(df)))
    
    
    # ============================================================
    # FILTRAR DADOS
    # ============================================================
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(Praticou_negociação_nos_últimos_3meses),
        Praticou_negociação_nos_últimos_3meses != ""
      )
    
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    
    # ============================================================
    # RESUMO
    # ============================================================
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        Praticou_negociação_nos_últimos_3meses
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    
    # ============================================================
    # BASELINE
    # ============================================================
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        categoria = Praticou_negociação_nos_últimos_3meses,
        n_baseline = n,
        perc_baseline = perc
      )
    
    
    # ============================================================
    # ENDLINE
    # ============================================================
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        categoria = Praticou_negociação_nos_últimos_3meses,
        n_endline = n,
        perc_endline = perc
      )
    
    
    # ============================================================
    # COMPARAÇÃO
    # ============================================================
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "categoria"
    ) %>%
      mutate(
        n_baseline = tidyr::replace_na(n_baseline, 0),
        n_endline = tidyr::replace_na(n_endline, 0),
        perc_baseline = tidyr::replace_na(perc_baseline, 0),
        perc_endline = tidyr::replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    
    # ============================================================
    # FUNÇÃO PARA FORMATAR VARIAÇÃO
    # ============================================================
    
    formatar_variacao <- function(valor) {
      
      valor <- round(valor, 1)
      
      if (valor > 0) {
        return(paste0("+", valor, " p.p."))
      }
      
      if (valor < 0) {
        return(paste0(valor, " p.p."))
      }
      
      return("sem variação")
    }
    
    
    # ============================================================
    # TEXTO DAS CATEGORIAS
    # ============================================================
    
    textos <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$categoria[i]
        base <- round(comparacao$perc_baseline[i], 1)
        end <- round(comparacao$perc_endline[i], 1)
        variacao <- comparacao$variacao[i]
        
        paste0(
          categoria,
          ": ",
          base,
          "% no Baseline e ",
          end,
          "% no Endline (",
          formatar_variacao(variacao),
          ")"
        )
      }
    )
    
    
    # ============================================================
    # TEXTO FINAL
    # ============================================================
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Nos últimos 3 meses, teve alguma situação em que podia negociar preços, prazos ou condições com fornecedor ou cliente para beneficiar o seu negócio? Por exemplo: pedir desconto, propor outro prazo de pagamento, discutir preço, pedir melhores condições de entrega ou combinar uma forma de pagamento mais favorável. "
      ),
      
      "A comparação entre o Baseline e o Endline permite ",
      "observar mudanças na experiência de negociação dos participantes. ",
      
      paste(
        textos,
        collapse = "; "
      ),
      
      "."
    )
  })
  # 
  # #################### Negociacao_Com_Agregado_Familiar
  # ============================================================
  # FUNÇÃO AUXILIAR — GRÁFICO BASELINE VS ENDLINE
  # ============================================================
  
  gerar_grafico_negociacao <- function(
    df,
    variavel,
    cores
  ) {
    
    # ==========================================================
    # VERIFICAR VARIÁVEIS
    # ==========================================================
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    
    # ==========================================================
    # FILTRAR DADOS
    # ==========================================================
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        ),
        
        !is.na(Tipo_Avaliacao),
        
        !is.na(.data[[variavel]]),
        
        .data[[variavel]] != ""
      )
    
    
    if (nrow(df) == 0) {
      return(
        plotly_empty()
      )
    }
    
    
    # ==========================================================
    # RESUMO
    # ==========================================================
    
    df_resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        .data[[variavel]]
      ) %>%
      
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        Percent = round(
          Total /
            sum(Total) *
            100,
          1
        )
        
      ) %>%
      
      ungroup()
    
    
    # ==========================================================
    # CATEGORIAS DOS DOIS MOMENTOS
    # ==========================================================
    
    categorias <- unique(
      df_resumo[[variavel]]
    )
    
    
    df_resumo <- df_resumo %>%
      
      tidyr::complete(
        
        Tipo_Avaliacao = c(
          "Baseline",
          "Endline"
        ),
        
        !!rlang::sym(variavel) := categorias,
        
        fill = list(
          Total = 0,
          Percent = 0
        )
      )
    
    
    # ==========================================================
    # ORDEM DAS CATEGORIAS
    # ==========================================================
    
    # Ordenar as respostas pela percentagem do Endline.
    # A mesma ordem será aplicada a Baseline e Endline.
    ordem <- df_resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      arrange(Percent) %>%
      pull(.data[[variavel]]) %>%
      as.character()
    
    ordem <- unique(c(
      ordem,
      as.character(df_resumo[[variavel]])
    ))
    
    
    df_resumo <- df_resumo %>%
      
      mutate(
        
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c(
            "Baseline",
            "Endline"
          )
        ),
        
        categoria = factor(
          .data[[variavel]],
          levels = ordem
        )
      )
    
    
    # ==========================================================
    # RÓTULO — n (%)
    # ==========================================================
    
    df_resumo <- df_resumo %>%
      
      mutate(
        
        texto = ifelse(
          
          Percent > 0,
          
          paste0(
            Total,
            " (",
            format(
              Percent,
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          
          ""
        )
      )
    
    
    # ==========================================================
    # GRÁFICO
    # ==========================================================
    
    plot_ly(
      
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      
      y = ~Percent,
      
      color = ~categoria,
      
      colors = cores,
      
      type = "bar",
      
      text = ~texto,
      
      texttemplate = "%{text}",
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      
      customdata = ~Total,
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = c(
            "Baseline",
            "Endline"
          )
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(
            0,
            100
          ),
          tickmode = "array",
          tickvals = seq(
            0,
            100,
            20
          ),
          ticktext = paste0(
            seq(
              0,
              100,
              20
            ),
            "%"
          )
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.30
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 160
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      ) %>%
      
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        
        toImageButtonOptions = list(
          format = "png",
          filename = paste0(
            "negociacao_",
            variavel
          ),
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  }
  
  output$grafico_agregado_familiar <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_grafico_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Com_Agregado_Familiar",
      
      cores = c(
        
        "Não me sinto confiante/ não sei negociar" =
          "#5cd6c7",
        
        "Depende /de certa forma" =
          "#ff7f0e",
        
        "Sim, sinto-me confiante e sei defender a minha posição" =
          "#9442d4"
      )
    )
  })
  
  
  output$grafico_clientes <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_grafico_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Com_Clientes",
      
      cores = c(
        
        "Não me sinto confiante/ não sei negociar" =
          "#5cd6c7",
        
        "Depende /de certa forma" =
          "#ff7f0e",
        
        "Sim, sinto-me confiante e sei defender a minha posição" =
          "#9442d4"
      )
    )
  })
  
  output$grafico_funcionarios <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_grafico_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Pessoas_Com_Quem_Trabalha",
      
      cores = c(
        
        "Não me sinto confiante/ não sei negociar" =
          "#5cd6c7",
        
        "Depende /de certa forma" =
          "#ff7f0e",
        
        "Sim, sinto-me confiante e sei defender a minha posição" =
          "#9442d4"
      )
    )
  })
  
  # ============================================================
  # FUNÇÃO AUXILIAR — LEITURA BASELINE VS ENDLINE
  # ============================================================
  
  gerar_leitura_negociacao <- function(
    df,
    variavel,
    titulo,
    introducao
  ) {
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    
    # ==========================================================
    # FILTRAR DADOS
    # ==========================================================
    
    df <- df %>%
      filter(
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        ),
        
        !is.na(Tipo_Avaliacao),
        
        !is.na(.data[[variavel]]),
        
        .data[[variavel]] != ""
      )
    
    
    if (nrow(df) == 0) {
      
      return(
        tags$p(
          style =
            "margin:0;text-align:justify;",
          
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    
    # ==========================================================
    # RESUMO
    # ==========================================================
    
    resumo <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        .data[[variavel]]
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        perc =
          n /
          sum(n) *
          100
      ) %>%
      
      ungroup()
    
    
    # ==========================================================
    # BASELINE
    # ==========================================================
    
    baseline <- resumo %>%
      
      filter(
        Tipo_Avaliacao ==
          "Baseline"
      ) %>%
      
      select(
        
        categoria =
          .data[[variavel]],
        
        perc_baseline =
          perc
      )
    
    
    # ==========================================================
    # ENDLINE
    # ==========================================================
    
    endline <- resumo %>%
      
      filter(
        Tipo_Avaliacao ==
          "Endline"
      ) %>%
      
      select(
        
        categoria =
          .data[[variavel]],
        
        perc_endline =
          perc
      )
    
    
    # ==========================================================
    # COMPARAÇÃO
    # ==========================================================
    
    comparacao <- full_join(
      
      baseline,
      endline,
      
      by = "categoria"
      
    ) %>%
      
      mutate(
        
        perc_baseline =
          tidyr::replace_na(
            perc_baseline,
            0
          ),
        
        perc_endline =
          tidyr::replace_na(
            perc_endline,
            0
          ),
        
        variacao =
          perc_endline -
          perc_baseline
      )
    
    
    # ==========================================================
    # LEITURA POR CATEGORIA
    # ==========================================================
    
    texto_categorias <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          comparacao$categoria[i]
        
        base <-
          round(
            comparacao$perc_baseline[i],
            1
          )
        
        end <-
          round(
            comparacao$perc_endline[i],
            1
          )
        
        variacao <-
          round(
            comparacao$variacao[i],
            1
          )
        
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            base,
            "% no Baseline para ",
            end,
            "% no Endline (+",
            variacao,
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            base,
            "% no Baseline para ",
            end,
            "% no Endline (",
            variacao,
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            end,
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    
    # ==========================================================
    # TEXTO FINAL
    # ==========================================================
    
    tags$p(
      
      style =
        "margin:0;text-align:justify;",
      
      tags$b(
        paste0(
          titulo,
          ". "
        )
      ),
      
      introducao,
      
      " ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  }
  
  output$texto_agregado <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_leitura_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Com_Agregado_Familiar",
      
      titulo =
        "Negociação com Pessoas do agregado familiar/esfera pessoal (sobre uso de dinheiro do negócio, tempo para trabalhar",
      
      introducao =
        "A comparação entre o Baseline e o Endline permite observar a evolução da confiança e capacidade de negociação dentro do agregado familiar."
    )
  })
  
  output$texto_clientes_neg <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_leitura_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Com_Clientes",
      
      titulo =
        "Negociação comercial com clientes",
      
      introducao =
        "A comparação entre o Baseline e o Endline permite observar a evolução da confiança e capacidade de negociação nas relações comerciais com clientes."
    )
  })
  
  output$texto_funcionarios <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    
    if (input$filtro_cidade != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_cidade
        )
    }
    
    
    if (input$filtro_ciclo != "Todos") {
      
      df <- df %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
    }
    
    
    gerar_leitura_negociacao(
      
      df = df,
      
      variavel =
        "Negociacao_Pessoas_Com_Quem_Trabalha",
      
      titulo =
        "Negociação com Pessoas com quem trabalha (fornecedores, funcionários, parceiros...)",
      
      introducao =
        "A comparação entre o Baseline e o Endline permite observar a evolução da confiança e capacidade de negociação nas relações com as pessoas com quem os participantes trabalham."
    )
  })
  
  # ##----------------------------------------------------------- 
  # ###################                  3 PAGINA Habilidades e Processos
  # ##-----------------------------------------------------------------------------  
  
  # ============================================================
  # FUNÇÃO - GRÁFICO 100% EMPILHADO
  # INDICADORES PAM VERDE
  # ============================================================
  
  gerar_grafico_indicador <- function(
    df,
    variavel,
    ordem_categorias,
    cores,
    nome_download
  ) {
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    # ----------------------------------------------------------
    # LIMPEZA
    # ----------------------------------------------------------
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[variavel]]),
        .data[[variavel]] != ""
      )
    
    if (nrow(df) == 0) {
      return(plotly_empty())
    }
    
    # ----------------------------------------------------------
    # FREQUÊNCIAS E PERCENTAGENS
    # ----------------------------------------------------------
    
    freq_data <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[variavel]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        pct = n / sum(n) * 100
      ) %>%
      ungroup()
    
    # ----------------------------------------------------------
    # GARANTIR TODAS AS CATEGORIAS
    # ----------------------------------------------------------
    
    freq_data <- freq_data %>%
      tidyr::complete(
        Tipo_Avaliacao = c("Baseline", "Endline"),
        categoria = ordem_categorias,
        fill = list(
          n = 0,
          pct = 0
        )
      )
    
    # ----------------------------------------------------------
    # FACTORES E RÓTULOS
    # ----------------------------------------------------------
    
    freq_data <- freq_data %>%
      mutate(
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c("Baseline", "Endline")
        ),
        
        categoria = factor(
          categoria,
          levels = ordem_categorias
        ),
        
        label = ifelse(
          pct > 0,
          paste0(
            n,
            " (",
            format(
              round(pct, 1),
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          ""
        )
      )
    
    # ----------------------------------------------------------
    # GRÁFICO
    # ----------------------------------------------------------
    
    plot_ly(
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~pct,
      
      color = ~categoria,
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#FFFFFF",
        size = 11
      ),
      
      customdata = ~n,
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = c(
            "Baseline",
            "Endline"
          ),
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          tickmode = "array",
          tickvals = seq(0, 100, 20),
          ticktext = paste0(
            seq(0, 100, 20),
            "%"
          )
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.28
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 150
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
        
      ) %>%
      
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        
        toImageButtonOptions = list(
          format = "png",
          filename = nome_download,
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  }
  # ============================================================
  # GRÁFICO - UTILIZAÇÃO DE FERRAMENTAS DE IA
  # ============================================================
  
  ordem_ia <- c(
    "Não, nunca usei e não sei bem o que é",
    "Ouvi falar mas nunca experimentei",
    "Sim, usei pelo menos uma vez",
    "Sim, uso regularmente para o negócio"
  )
  
  cores_ia <- c(
    "Não, nunca usei e não sei bem o que é" = "#69C7BE",
    "Ouvi falar mas nunca experimentei" = "#f9a825",
    "Sim, usei pelo menos uma vez" = "#F77333",
    "Sim, uso regularmente para o negócio" = "#9442d4"
  )
  
  
  output$grafico_uso_ia <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTRO CIDADE
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # ----------------------------------------------------------
    # FILTRO CICLO
    # ----------------------------------------------------------
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ----------------------------------------------------------
    # GRÁFICO
    # ----------------------------------------------------------
    
    gerar_grafico_indicador(
      df = df,
      variavel = "Uso_de_ferramentas_de_IA",
      ordem_categorias = ordem_ia,
      cores = cores_ia,
      nome_download = "utilizacao_ferramentas_IA"
    )
  })
  
  # ============================================================
  # TEXTO - UTILIZAÇÃO DE FERRAMENTAS DE IA
  # ============================================================
  
  output$texto_uso_ia <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTROS
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Uso_de_ferramentas_de_IA"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    # ----------------------------------------------------------
    # PERCENTAGENS
    # ----------------------------------------------------------
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    # ----------------------------------------------------------
    # BASELINE
    # ----------------------------------------------------------
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        categoria,
        perc_baseline = perc
      )
    
    # ----------------------------------------------------------
    # ENDLINE
    # ----------------------------------------------------------
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        categoria,
        perc_endline = perc
      )
    
    # ----------------------------------------------------------
    # COMPARAÇÃO
    # ----------------------------------------------------------
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "categoria"
    ) %>%
      mutate(
        perc_baseline = replace_na(
          perc_baseline,
          0
        ),
        
        perc_endline = replace_na(
          perc_endline,
          0
        ),
        
        variacao = perc_endline - perc_baseline
      )
    
    # ----------------------------------------------------------
    # TEXTO
    # ----------------------------------------------------------
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$categoria[i]
        
        base <- round(
          comparacao$perc_baseline[i],
          1
        )
        
        end <- round(
          comparacao$perc_endline[i],
          1
        )
        
        variacao <- round(
          comparacao$variacao[i],
          1
        )
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(
              base,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Baseline para ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Endline (+",
            format(
              variacao,
              decimal.mark = ",",
              nsmall = 1
            ),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(
              base,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Baseline para ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Endline (",
            format(
              variacao,
              decimal.mark = ",",
              nsmall = 1
            ),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Já utilizou alguma ferramenta de inteligência artificial (ex: ChatGPT, Gemini ou outra) para pesquisar sobre os seus clientes ou obter informações úteis para o negócio? "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução na utilização de ferramentas de inteligência artificial. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  # ============================================================
  # GRÁFICO - CONTROLO DO DINHEIRO
  # ============================================================
  
  ordem_controle <- c(
    "Não",
    "Sim"
  )
  
  cores_controle <- c(
    "Não" = "#69C7BE",
    "Sim" = "#9442d4"
  )
  
  
  output$grafico_control_dinheiro <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_indicador(
      df = df,
      variavel = "Faz controlo do dinheiro que entra e que sai (receitas e despesas)",
      ordem_categorias = ordem_controle,
      cores = cores_controle,
      nome_download = "controlo_dinheiro_receitas_despesas"
    )
  })
  
  # ============================================================
  # TEXTO - CONTROLO DO DINHEIRO
  # ============================================================
  
  output$texto_control_dinheiro <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        categoria,
        perc_baseline = perc
      )
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        categoria,
        perc_endline = perc
      )
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "categoria"
    ) %>%
      mutate(
        perc_baseline = replace_na(perc_baseline, 0),
        perc_endline = replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$categoria[i]
        base <- round(comparacao$perc_baseline[i], 1)
        end <- round(comparacao$perc_endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Faz controlo do dinheiro que entra e que sai (receitas e despesas). "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução no controlo das receitas e despesas. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  # ============================================================
  # GRÁFICO - SEPARAÇÃO DAS CONTAS
  # ============================================================
  
  ordem_contas <- c(
    "Não",
    "Sim"
  )
  
  cores_contas <- c(
    "Não" = "#69C7BE",
    "Sim" = "#9442d4"
  )
  
  
  output$grafico_separacao_contas <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_indicador(
      df = df,
      variavel = "Faz separação das contas pessoais e do negócio",
      ordem_categorias = ordem_contas,
      cores = cores_contas,
      nome_download = "separacao_contas_pessoais_negocio"
    )
  })
  
  # ============================================================
  # TEXTO - SEPARAÇÃO DAS CONTAS
  # ============================================================
  
  output$texto_separacao_contas <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Faz separação das contas pessoais e do negócio"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    comparacao <- resumo %>%
      select(
        Tipo_Avaliacao,
        categoria,
        perc
      ) %>%
      tidyr::pivot_wider(
        names_from = Tipo_Avaliacao,
        values_from = perc,
        values_fill = 0
      ) %>%
      mutate(
        variacao = Endline - Baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$categoria[i]
        base <- round(comparacao$Baseline[i], 1)
        end <- round(comparacao$Endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Faz separação das contas pessoais e do negócio. "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução na separação das contas pessoais e do negócio. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  # ============================================================
  # GRÁFICO - CÁLCULO DO LUCRO
  # ============================================================
  
  ordem_lucro <- c(
    "Não",
    "Sim"
  )
  
  cores_lucro <- c(
    "Não" = "#69C7BE",
    "Sim" = "#9442d4"
  )
  
  
  output$grafico_calcular_Lucro <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_indicador(
      df = df,
      variavel = "Sabe calcular o lucro do negócio  (com base no exercício prático)",
      ordem_categorias = ordem_lucro,
      cores = cores_lucro,
      nome_download = "calculo_lucro_negocio"
    )
  })
  
  # ============================================================
  # TEXTO - CÁLCULO DO LUCRO
  # ============================================================
  
  output$texto_calculo_lucro <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    comparacao <- resumo %>%
      select(
        Tipo_Avaliacao,
        categoria,
        perc
      ) %>%
      tidyr::pivot_wider(
        names_from = Tipo_Avaliacao,
        values_from = perc,
        values_fill = 0
      )
    
    # Garantir as duas colunas
    if (!"Baseline" %in% names(comparacao)) {
      comparacao$Baseline <- 0
    }
    
    if (!"Endline" %in% names(comparacao)) {
      comparacao$Endline <- 0
    }
    
    comparacao <- comparacao %>%
      mutate(
        variacao = Endline - Baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$categoria[i]
        base <- round(comparacao$Baseline[i], 1)
        end <- round(comparacao$Endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Sabe calcular o lucro do negócio  (com base no exercício prático). "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução do conhecimento das participantes sobre o cálculo do lucro do negócio. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })

#################################### CONSCIENCIA DE GENERO
  
  # ============================================================
  # FUNÇÃO — GRÁFICOS DE PERCEÇÃO
  # ============================================================
  
  gerar_grafico_percepcao <- function(df, variavel, cores, nome_download) {
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    # ------------------------------------------------------------
    # ESTRUTURA PADRÃO PARA TODOS OS INDICADORES
    # Ordem fixa das avaliações e das categorias de resposta
    # ------------------------------------------------------------
    
    ordem_avaliacao <- c("Baseline", "Endline")
    ordem_categorias <- c("Discordo", "Depende", "Concordo")
    
    # Filtrar avaliações e respostas válidas
    df <- df %>%
      dplyr::filter(
        Tipo_Avaliacao %in% ordem_avaliacao,
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[variavel]]),
        trimws(as.character(.data[[variavel]])) != ""
      ) %>%
      dplyr::mutate(
        Tipo_Avaliacao = as.character(Tipo_Avaliacao),
        categoria = trimws(as.character(.data[[variavel]]))
      )
    
    if (nrow(df) == 0) {
      return(
        plotly_empty() %>%
          layout(
            annotations = list(
              list(
                text = "Não existem dados disponíveis para este indicador.",
                x = 0.5, y = 0.5,
                xref = "paper", yref = "paper",
                showarrow = FALSE,
                font = list(size = 14, color = "#666666")
              )
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    # Manter as três categorias padronizadas primeiro.
    # Caso existam outras respostas na base, elas não são eliminadas:
    # aparecem depois das três categorias principais.
    categorias_extra <- setdiff(
      unique(df$categoria),
      ordem_categorias
    )
    ordem_final_categorias <- c(
      ordem_categorias,
      sort(categorias_extra)
    )
    
    # Frequências observadas
    freq_observada <- df %>%
      dplyr::count(
        Tipo_Avaliacao,
        categoria,
        name = "n"
      )
    
    # Criar todas as combinações Baseline/Endline x categorias.
    # Categorias ausentes recebem n = 0.
    freq_data <- tidyr::expand_grid(
      Tipo_Avaliacao = ordem_avaliacao,
      categoria = ordem_final_categorias
    ) %>%
      dplyr::left_join(
        freq_observada,
        by = c("Tipo_Avaliacao", "categoria")
      ) %>%
      dplyr::mutate(
        n = tidyr::replace_na(n, 0L)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        total_avaliacao = sum(n),
        pct = dplyr::if_else(
          total_avaliacao > 0,
          round(n / total_avaliacao * 100, 1),
          0
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = ordem_avaliacao
        ),
        categoria = factor(
          categoria,
          levels = ordem_final_categorias
        ),
        label = dplyr::if_else(
          pct > 0,
          paste0(
            n,
            " (",
            format(pct, decimal.mark = ",", nsmall = 1),
            "%)"
          ),
          ""
        )
      )
    
    # Aplicar as cores fixas. Categorias extra recebem uma cor neutra.
    cores_usadas <- cores
    cores_extra <- setdiff(ordem_final_categorias, names(cores_usadas))
    if (length(cores_extra) > 0) {
      cores_usadas <- c(
        cores_usadas,
        stats::setNames(rep("#999999", length(cores_extra)), cores_extra)
      )
    }
    cores_usadas <- cores_usadas[ordem_final_categorias]
    
    plotly::plot_ly(
      data = freq_data,
      x = ~Tipo_Avaliacao,
      y = ~pct,
      color = ~categoria,
      colors = unname(cores_usadas),
      type = "bar",
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(color = "#ffffff", size = 11),
      customdata = ~n,
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      plotly::layout(
        barmode = "stack",
        barnorm = "",
        xaxis = list(
          title = "",
          type = "category",
          categoryorder = "array",
          categoryarray = ordem_avaliacao,
          tickfont = list(size = 12)
        ),
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          tickmode = "array",
          tickvals = seq(0, 100, 20),
          ticktext = paste0(seq(0, 100, 20), "%")
        ),
        legend = list(
          title = list(text = "Resposta"),
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.28,
          traceorder = "normal"
        ),
        margin = list(l = 70, r = 20, t = 20, b = 140),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      ) %>%
      plotly::config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        toImageButtonOptions = list(
          format = "png",
          filename = nome_download,
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  }
  # ============================================================
  # CORES — PERCEÇÕES DE GÉNERO
  # ============================================================
  
  cores_percepcao_genero <- c(
    "Discordo" = "#69C7BE",
    "Depende" = "#ffc107",
    "Concordo" = "#F77333"
  )
  
  output$grafico_H_Financeiro_Faci <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_percepcao(
      df = df,
      variavel = "Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .",
      cores = cores_percepcao_genero,
      nome_download = "homens_acesso_financeiros"
    )
  })
  
  output$grafico_H_Serios <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_percepcao(
      df = df,
      variavel = "Os homens são levados mais a sério como empreendedores.",
      cores = cores_percepcao_genero,
      nome_download = "homens_levados_a_serio"
    )
  })
  
  output$grafico_H_Capazes <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_percepcao(
      df = df,
      variavel = "Homens são mais capazes de negociar do que as mulheres.",
      cores = cores_percepcao_genero,
      nome_download = "homens_capacidade_negociacao"
    )
  })
  
  output$grafico_Obrigacoes_Domesticas <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_percepcao(
      df = df,
      variavel = "Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.",
      cores = cores_percepcao_genero,
      nome_download = "responsabilidades_domesticas"
    )
  })
  
  output$grafico_M_Gerir <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro cidade
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    # Filtro ciclo
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_grafico_percepcao(
      df = df,
      variavel = "Não se espera que as mulheres sejam capazes de gerir um negócio.",
      cores = cores_percepcao_genero,
      nome_download = "mulheres_capacidade_gerir_negocio"
    )
  })
  
  
  # ============================================================
  # FUNÇÃO — TEXTO COMPARATIVO BASELINE VS ENDLINE
  # ============================================================
  
  gerar_texto_percepcao <- function(
    df,
    variavel,
    titulo,
    introducao
  ) {
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    
    # ------------------------------------------------------------
    # Filtrar dados
    # ------------------------------------------------------------
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        ),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[variavel]]),
        .data[[variavel]] != ""
      )
    
    
    if (nrow(df) == 0) {
      
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    
    # ------------------------------------------------------------
    # Frequência
    # ------------------------------------------------------------
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        .data[[variavel]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    
    # ------------------------------------------------------------
    # Baseline
    # ------------------------------------------------------------
    
    baseline <- resumo %>%
      filter(
        Tipo_Avaliacao == "Baseline"
      ) %>%
      select(
        resposta = .data[[variavel]],
        n_baseline = n,
        perc_baseline = perc
      )
    
    
    # ------------------------------------------------------------
    # Endline
    # ------------------------------------------------------------
    
    endline <- resumo %>%
      filter(
        Tipo_Avaliacao == "Endline"
      ) %>%
      select(
        resposta = .data[[variavel]],
        n_endline = n,
        perc_endline = perc
      )
    
    
    # ------------------------------------------------------------
    # Comparação
    # ------------------------------------------------------------
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "resposta"
    ) %>%
      mutate(
        n_baseline = tidyr::replace_na(
          n_baseline,
          0
        ),
        
        n_endline = tidyr::replace_na(
          n_endline,
          0
        ),
        
        perc_baseline = tidyr::replace_na(
          perc_baseline,
          0
        ),
        
        perc_endline = tidyr::replace_na(
          perc_endline,
          0
        ),
        
        variacao = perc_endline - perc_baseline
      )
    
    
    # ------------------------------------------------------------
    # Criar texto de cada categoria
    # ------------------------------------------------------------
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$resposta[i]
        
        base <- round(
          comparacao$perc_baseline[i],
          1
        )
        
        end <- round(
          comparacao$perc_endline[i],
          1
        )
        
        variacao <- round(
          comparacao$variacao[i],
          1
        )
        
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(
              base,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Baseline para ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Endline (+",
            format(
              variacao,
              decimal.mark = ",",
              nsmall = 1
            ),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(
              base,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Baseline para ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% no Endline (",
            format(
              variacao,
              decimal.mark = ",",
              nsmall = 1
            ),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(
              end,
              decimal.mark = ",",
              nsmall = 1
            ),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    
    # ------------------------------------------------------------
    # Resultado
    # ------------------------------------------------------------
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        paste0(
          titulo,
          ". "
        )
      ),
      
      introducao,
      
      " ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  }
  output$texto_H_Financeiros <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_texto_percepcao(
      df = df,
      variavel = "Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .",
      titulo = "Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados",
      introducao = paste0(
        "A comparação entre o Baseline e o Endline permite ",
        "observar a evolução das perceções sobre a facilidade ",
        "dos homens em aceder a produtos financeiros, redes ",
        "ou novos mercados."
      )
    )
  })
  
  output$texto_H_Serios <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_texto_percepcao(
      df = df,
      variavel = "Os homens são levados mais a sério como empreendedores.",
      titulo = "Os homens são levados mais a sério como empreendedores.",
      introducao = paste0(
        "A comparação entre o Baseline e o Endline permite ",
        "observar a evolução das perceções sobre o reconhecimento ",
        "dos homens enquanto empreendedores."
      )
    )
  })
  
  output$texto_H_Capazes <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_texto_percepcao(
      df = df,
      variavel = "Homens são mais capazes de negociar do que as mulheres.",
      titulo = "Homens são mais capazes de negociar do que as mulheres.",
      introducao = paste0(
        "A comparação entre o Baseline e o Endline permite ",
        "observar a evolução das perceções sobre a capacidade ",
        "de negociação de homens e mulheres."
      )
    )
  })
  
  output$texto_Obrigacoes_Domesticas <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_texto_percepcao(
      df = df,
      variavel = "Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.",
      titulo = "Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.",
      introducao = paste0(
        "A comparação entre o Baseline e o Endline permite ",
        "observar a evolução das perceções sobre a distribuição ",
        "das responsabilidades domésticas e o tempo disponível ",
        "das mulheres para o negócio."
      )
    )
  })
  
  
  # ============================================================
  # TEXTO — CAPACIDADE DAS MULHERES PARA GERIR UM NEGÓCIO
  # ============================================================
  
  output$texto_M_Gerir <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    gerar_texto_percepcao(
      df = df,
      variavel = "Não se espera que as mulheres sejam capazes de gerir um negócio.",
      titulo = "Não se espera que as mulheres sejam capazes de gerir um negócio.",
      introducao = paste0(
        "A comparação entre o Baseline e o Endline permite ",
        "observar a evolução das perceções sobre a capacidade ",
        "das mulheres para gerir um negócio."
      )
    )
  })
  
  
  # ============================================================
  # CORES — PERCEÇÕES DE GÉNERO
  # MESMO PADRÃO DOS GRÁFICOS ANTERIORES
  # ============================================================
  
  cores_genero_extra <- c(
    "Ajudaram bastante / mudaram a minha compreensão" = "#F77333",
    "Ajudaram moderadamente" = "#FFC107",
    "Ajudaram um pouco" = "#69C7BE"
  )
  
  
  # ============================================================
  # GRÁFICO — COMPREENSÃO DAS DESIGUALDADES DE GÉNERO
  # APENAS ENDLINE
  # ============================================================
  
  output$grafico_sa <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTROS
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ----------------------------------------------------------
    # VARIÁVEL
    # ----------------------------------------------------------
    
    variavel <- paste0(
      "Até que ponto as actividades ligadas à questão de género ",
      "ajudaram a compreender as desigualdades entre homens e mulheres?"
    )
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    # ----------------------------------------------------------
    # FILTRAR ENDLINE
    # ----------------------------------------------------------
    
    df <- df %>%
      filter(
        Tipo_Avaliacao == "Endline",
        !is.na(.data[[variavel]]),
        trimws(as.character(.data[[variavel]])) != ""
      )
    
    if (nrow(df) == 0) {
      return(
        plotly_empty() %>%
          layout(
            annotations = list(
              list(
                text = "Não existem dados disponíveis para apresentar.",
                x = 0.5,
                y = 0.5,
                xref = "paper",
                yref = "paper",
                showarrow = FALSE,
                font = list(size = 14, color = "#555555")
              )
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    # ----------------------------------------------------------
    # ORDEM FIXA DAS CATEGORIAS
    # ----------------------------------------------------------
    
    ordem <- c(
      "Ajudaram um pouco",
      "Ajudaram moderadamente",
      "Ajudaram bastante / mudaram a minha compreensão"
    )
    
    # ----------------------------------------------------------
    # FREQUÊNCIAS E PERCENTAGENS
    # ----------------------------------------------------------
    
    df_resumo <- df %>%
      count(
        categoria = .data[[variavel]],
        name = "Total"
      ) %>%
      mutate(
        Percent = Total / sum(Total) * 100
      ) %>%
      tidyr::complete(
        categoria = ordem,
        fill = list(
          Total = 0,
          Percent = 0
        )
      ) %>%
      mutate(
        categoria = factor(
          categoria,
          levels = ordem
        ),
        momento = factor(
          "Endline",
          levels = "Endline"
        ),
        texto = ifelse(
          Percent > 0,
          paste0(
            Total,
            " (",
            format(
              round(Percent, 1),
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          ""
        )
      ) %>%
      arrange(categoria)
    
    # ----------------------------------------------------------
    # GRÁFICO
    # ----------------------------------------------------------
    
    plot_ly(
      data = df_resumo,
      x = ~momento,
      y = ~Percent,
      color = ~categoria,
      colors = cores_genero_extra,
      type = "bar",
      text = ~texto,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(
        color = "#ffffff",
        size = 11
      ),
      customdata = ~Total,
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      
      layout(
        barmode = "stack",
        barnorm = "percent",
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = "Endline",
          tickfont = list(size = 12),
          showgrid = FALSE,
          zeroline = FALSE
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          tickmode = "array",
          tickvals = seq(0, 100, 20),
          ticktext = paste0(seq(0, 100, 20), "%"),
          showgrid = TRUE,
          gridcolor = "#e0dce0",
          zeroline = FALSE
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.28,
          font = list(size = 11),
          traceorder = "normal"
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 140
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      ) %>%
      
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        toImageButtonOptions = list(
          format = "png",
          filename = "compreensao_desigualdades_genero_endline",
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  })
  
  
  # ============================================================
  # TEXTO — COMPREENSÃO DAS DESIGUALDADES DE GÉNERO
  # APENAS ENDLINE
  # ============================================================
  
  output$texto_genero_extra <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTROS
    # ----------------------------------------------------------
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ----------------------------------------------------------
    # VARIÁVEL
    # ----------------------------------------------------------
    
    variavel <- paste0(
      "Até que ponto as actividades ligadas à questão de género ",
      "ajudaram a compreender as desigualdades entre homens e mulheres?"
    )
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    # ----------------------------------------------------------
    # FILTRAR ENDLINE
    # ----------------------------------------------------------
    
    df <- df %>%
      filter(
        Tipo_Avaliacao == "Endline",
        !is.na(.data[[variavel]]),
        trimws(as.character(.data[[variavel]])) != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    # ----------------------------------------------------------
    # RESUMO
    # ----------------------------------------------------------
    
    resumo <- df %>%
      count(
        resposta = .data[[variavel]],
        name = "n"
      ) %>%
      mutate(
        percentagem = n / sum(n) * 100
      )
    
    # ----------------------------------------------------------
    # FUNÇÃO PARA OBTER VALORES
    # ----------------------------------------------------------
    
    obter_valor <- function(nome) {
      
      linha <- resumo %>%
        filter(resposta == nome)
      
      if (nrow(linha) == 0) {
        return(list(n = 0, pct = 0))
      }
      
      list(
        n = linha$n[1],
        pct = linha$percentagem[1]
      )
    }
    
    bastante <- obter_valor(
      "Ajudaram bastante / mudaram a minha compreensão"
    )
    
    moderadamente <- obter_valor(
      "Ajudaram moderadamente"
    )
    
    pouco <- obter_valor(
      "Ajudaram um pouco"
    )
    
    formatar_resultado <- function(valor) {
      paste0(
        valor$n,
        " (",
        format(
          round(valor$pct, 1),
          decimal.mark = ",",
          nsmall = 1
        ),
        "%)"
      )
    }
    
    # ----------------------------------------------------------
    # TEXTO ANALÍTICO
    # ----------------------------------------------------------
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        paste0(
          "Até que ponto as actividades ligadas à questão de género ",
          "ajudaram a compreender as desigualdades entre homens e mulheres? "
        )
      ),
      
      paste0(
        "No Endline, ",
        nrow(df),
        " participantes avaliaram a contribuição das actividades ",
        "ligadas à questão de género para a compreensão das ",
        "desigualdades entre homens e mulheres. "
      ),
      
      "A resposta mais frequente foi ",
      
      tags$b(formatar_resultado(bastante)),
      ", que indicaram que as actividades ajudaram bastante ou mudaram a sua compreensão. ",
      
      tags$b(formatar_resultado(moderadamente)),
      " indicaram que ajudaram moderadamente, enquanto ",
      
      tags$b(formatar_resultado(pouco)),
      " indicaram que ajudaram um pouco."
    )
  })
  
  ################################## QUALITATIVO #################################
  
  
  # # ==========================================================
  # # AVALIAÇÃO DE GÉNERO — CICLOS 1 E 3 / ENDLINE
  # # PAM VERDE | META: 60 EMPREENDEDORAS
  # #
  # # Inclui:
  # # 1. Preparação e validação da base
  # # 2. Indicadores de respostas abertas e fechadas
  # # 3. Resumo qualitativo
  # # 4. Quatro cartões KPI
  # # 5. Gráfico de compreensão das desigualdades
  # # 6. Gráfico de práticas e esferas de mudança
  # # 7. Classificação temática dos depoimentos
  # # 8. Cartões individuais de depoimentos
  # #
  # # NOTA:
  # # Os resultados são calculados a partir dos dados disponíveis.
  # # A meta de 60 não é utilizada como denominador artificial.
  # # ==========================================================
  # 
  # 
  # # ==========================================================
  # # 0. PERGUNTAS DA AVALIAÇÃO
  # # ==========================================================
  # 
  # pergunta_fechada <- paste0(
  #   "Até que ponto as actividades ligadas à questão de género ",
  #   "ajudaram a compreender as desigualdades entre homens e mulheres?"
  # )
  # 
  # pergunta_aberta <- paste0(
  #   "Podes dizer algo que colocaste em prática ",
  #   "depois de ter tido essas actividades?"
  # )
  # 
  # pergunta_praticas <-
  #   "Podes dizer algo que colocaste em prática depois de ter tido essas actividades?"
  # 
  # meta_empreendedoras <- 60
  # 
  # 
  # # ==========================================================
  # # 1. IDENTIFICAR A COLUNA DE ID
  # # ==========================================================
  # 
  # colunas_id_possiveis <- c(
  #   "ID_Participante",
  #   "id_participante",
  #   "ID_participante",
  #   "ID",
  #   "id",
  #   "Codigo_Participante",
  #   "Código_Participante",
  #   "ID_MUVA"
  # )
  # 
  # coluna_id_encontrada <- intersect(
  #   colunas_id_possiveis,
  #   names(Pam_Verde_Indicadores)
  # )
  # 
  # if (length(coluna_id_encontrada) == 0) {
  #   stop(
  #     paste0(
  #       "Não foi encontrada uma coluna de identificação em ",
  #       "Pam_Verde_Indicadores. Verifica names(Pam_Verde_Indicadores) ",
  #       "e actualiza colunas_id_possiveis."
  #     )
  #   )
  # }
  # 
  # coluna_id_encontrada <- coluna_id_encontrada[1]
  # 
  # 
  # # ==========================================================
  # # 2. VALIDAR AS COLUNAS OBRIGATÓRIAS
  # # ==========================================================
  # 
  # colunas_obrigatorias <- c(
  #   "Ciclo",
  #   "Tipo_Avaliacao",
  #   pergunta_fechada,
  #   pergunta_aberta
  # )
  # 
  # colunas_em_falta <- setdiff(
  #   colunas_obrigatorias,
  #   names(Pam_Verde_Indicadores)
  # )
  # 
  # if (length(colunas_em_falta) > 0) {
  #   stop(
  #     paste0(
  #       "Faltam as seguintes colunas na base: ",
  #       paste(colunas_em_falta, collapse = "; ")
  #     )
  #   )
  # }
  # 
  # 
  # # ==========================================================
  # # 3. FILTRAR CICLOS 1 E 3 — ENDLINE
  # # ==========================================================
  # 
  # dados_genero_c3 <- Pam_Verde_Indicadores %>%
  #   dplyr::mutate(
  #     ID_Participante = stringr::str_squish(
  #       as.character(.data[[coluna_id_encontrada]])
  #     ),
  #     Ciclo_texto = stringr::str_squish(
  #       as.character(Ciclo)
  #     ),
  #     Tipo_Avaliacao_texto = stringr::str_squish(
  #       as.character(Tipo_Avaliacao)
  #     )
  #   ) %>%
  #   dplyr::filter(
  #     stringr::str_detect(
  #       Ciclo_texto,
  #       stringr::regex(
  #         "^Ciclo\\s*(1|3)\\b",
  #         ignore_case = TRUE
  #       )
  #     ),
  #     stringr::str_detect(
  #       Tipo_Avaliacao_texto,
  #       stringr::regex(
  #         "^Endline$",
  #         ignore_case = TRUE
  #       )
  #     ),
  #     !is.na(ID_Participante),
  #     ID_Participante != ""
  #   )
  # 
  # 
  # # ==========================================================
  # # 4. BASE ÚNICA POR EMPREENDEDORA
  # # ==========================================================
  # # Para os indicadores de participantes, cada ID conta uma vez.
  # # Se houver vários registos por participante, conserva-se o
  # # primeiro registo disponível após o filtro.
  # #
  # # Confirma que a base tem uma única resposta Endline por ID.
  # # Se existirem várias respostas legítimas por ID, é necessário
  # # definir uma regra específica para consolidá-las.
  # 
  # dados_genero_unicos <- dados_genero_c3 %>%
  #   dplyr::distinct(
  #     ID_Participante,
  #     .keep_all = TRUE
  #   )
  # 
  # total_empreendedoras <- dplyr::n_distinct(
  #   dados_genero_unicos$ID_Participante
  # )
  # 
  # total_ciclo_1 <- dados_genero_unicos %>%
  #   dplyr::filter(
  #     stringr::str_detect(
  #       Ciclo_texto,
  #       stringr::regex("^Ciclo\\s*1\\b", ignore_case = TRUE)
  #     )
  #   ) %>%
  #   dplyr::summarise(N = dplyr::n_distinct(ID_Participante)) %>%
  #   dplyr::pull(N)
  # 
  # total_ciclo_3 <- dados_genero_unicos %>%
  #   dplyr::filter(
  #     stringr::str_detect(
  #       Ciclo_texto,
  #       stringr::regex("^Ciclo\\s*3\\b", ignore_case = TRUE)
  #     )
  #   ) %>%
  #   dplyr::summarise(N = dplyr::n_distinct(ID_Participante)) %>%
  #   dplyr::pull(N)
  # 
  # message("========================================")
  # message("AVALIAÇÃO DE GÉNERO — ENDLINE")
  # message("Ciclo 1: ", total_ciclo_1)
  # message("Ciclo 3: ", total_ciclo_3)
  # message("Total de empreendedoras únicas: ", total_empreendedoras)
  # message("Meta de participantes: ", meta_empreendedoras)
  # message("========================================")
  # 
  # if (total_empreendedoras != meta_empreendedoras) {
  #   warning(
  #     paste0(
  #       "A base contém ", total_empreendedoras,
  #       " empreendedoras únicas, em vez da meta de ",
  #       meta_empreendedoras,
  #       ". Os indicadores serão calculados com base nos dados reais."
  #     )
  #   )
  # }
  # 
  # 
  # # ==========================================================
  # # 5. PREPARAR RESPOSTAS ABERTAS
  # # ==========================================================
  # 
  # respostas_genero <- dados_genero_unicos %>%
  #   dplyr::mutate(
  #     resposta_aberta = stringr::str_squish(
  #       as.character(.data[[pergunta_aberta]])
  #     ),
  #     resposta_fechada = stringr::str_squish(
  #       as.character(.data[[pergunta_fechada]])
  #     )
  #   ) %>%
  #   dplyr::filter(
  #     !is.na(resposta_aberta),
  #     resposta_aberta != ""
  #   ) %>%
  #   dplyr::mutate(
  #     texto_busca = stringr::str_to_lower(resposta_aberta),
  #     
  #     menciona_pratica = stringr::str_detect(
  #       texto_busca,
  #       paste(
  #         "passei a",
  #         "comecei",
  #         "agora",
  #         "conversei",
  #         "converso",
  #         "dialoguei",
  #         "divido",
  #         "partilho",
  #         "negociei",
  #         "negocio",
  #         "negociar",
  #         "apliquei",
  #         "pratico",
  #         "mudei",
  #         "decidi",
  #         "falo com",
  #         "expliquei",
  #         "ajudo",
  #         "participo",
  #         "coloquei em prática",
  #         "coloquei em pratica",
  #         "implement",
  #         "repart",
  #         sep = "|"
  #       )
  #     ),
  #     
  #     menciona_casa = stringr::str_detect(
  #       texto_busca,
  #       paste(
  #         "em casa",
  #         "tarefas domésticas",
  #         "tarefas domesticas",
  #         "trabalho doméstico",
  #         "trabalho domestico",
  #         "divisão das tarefas",
  #         "divisao das tarefas",
  #         "responsabilidades domésticas",
  #         "responsabilidades domesticas",
  #         "marido",
  #         "esposo",
  #         "parceiro",
  #         "companheiro",
  #         "família",
  #         "familia",
  #         "filhos",
  #         "ajudar nas tarefas",
  #         "partilhar as tarefas",
  #         "dividir as tarefas",
  #         sep = "|"
  #       )
  #     ),
  #     
  #     menciona_autoconfianca = stringr::str_detect(
  #       texto_busca,
  #       paste(
  #         "confiança",
  #         "confianca",
  #         "confiante",
  #         "acredito em mim",
  #         "acreditar em mim",
  #         "autonomia",
  #         "independente",
  #         "tomar decisões",
  #         "tomar decisoes",
  #         "decidir por mim",
  #         "direitos",
  #         "minha opinião",
  #         "minha opiniao",
  #         "minha voz",
  #         "expressar",
  #         "negociar",
  #         "negociei",
  #         "defender",
  #         "poder de decisão",
  #         "poder de decisao",
  #         "triângulo do poder",
  #         "triangulo do poder",
  #         sep = "|"
  #       )
  #     )
  #   )
  # 
  # 
  # # ==========================================================
  # # 6. INDICADORES DAS RESPOSTAS ABERTAS
  # # ==========================================================
  # 
  # n_participantes <- dplyr::n_distinct(
  #   respostas_genero$ID_Participante
  # )
  # 
  # n_praticas <- sum(
  #   respostas_genero$menciona_pratica,
  #   na.rm = TRUE
  # )
  # 
  # n_casa <- sum(
  #   respostas_genero$menciona_casa,
  #   na.rm = TRUE
  # )
  # 
  # n_autoconfianca <- sum(
  #   respostas_genero$menciona_autoconfianca,
  #   na.rm = TRUE
  # )
  # 
  # 
  # # ==========================================================
  # # 7. RESUMO DA PERGUNTA FECHADA
  # # ==========================================================
  # 
  # dados_fechada <- dados_genero_unicos %>%
  #   dplyr::mutate(
  #     resposta = stringr::str_squish(
  #       as.character(.data[[pergunta_fechada]])
  #     )
  #   ) %>%
  #   dplyr::filter(
  #     !is.na(resposta),
  #     resposta != ""
  #   )
  # 
  # resumo_fechada <- dados_fechada %>%
  #   dplyr::count(
  #     resposta,
  #     name = "N"
  #   ) %>%
  #   dplyr::mutate(
  #     Percentagem = if (sum(N) > 0) {
  #       N / sum(N) * 100
  #     } else {
  #       0
  #     }
  #   )
  # 
  # n_fechadas <- sum(
  #   resumo_fechada$N,
  #   na.rm = TRUE
  # )
  # 
  # n_bastante <- resumo_fechada %>%
  #   dplyr::filter(
  #     resposta == "Ajudaram bastante / mudaram a minha compreensão"
  #   ) %>%
  #   dplyr::summarise(
  #     total = sum(N, na.rm = TRUE)
  #   ) %>%
  #   dplyr::pull(total)
  # 
  # if (length(n_bastante) == 0 || is.na(n_bastante)) {
  #   n_bastante <- 0
  # }
  # 
  # pct_bastante <- if (n_fechadas > 0) {
  #   round(n_bastante / n_fechadas * 100, 1)
  # } else {
  #   0
  # }
  # 
  # 
  # # ==========================================================
  # # 8. RESUMO QUALITATIVO
  # # ==========================================================
  # 
  # output$texto_resumo_qualitativo <- renderUI({
  #   
  #   if (n_participantes == 0) {
  #     return(
  #       tags$p(
  #         style = "color:#777777;",
  #         paste(
  #           "Não existem respostas abertas válidas",
  #           "para analisar nos Ciclos 1 e 3 — Endline."
  #         )
  #       )
  #     )
  #   }
  #   
  #   tags$div(
  #     
  #     tags$p(
  #       style = "font-size:15px; line-height:1.8; color:#444444;",
  #       tags$strong("Compreensão das desigualdades. "),
  #       paste0(
  #         "Entre as participantes com resposta válida à pergunta fechada, ",
  #         n_bastante,
  #         " de ",
  #         n_fechadas,
  #         " (",
  #         format(pct_bastante, nsmall = 1, decimal.mark = ","),
  #         "%) afirmaram que as actividades ajudaram bastante ou mudaram ",
  #         "a sua compreensão das desigualdades entre homens e mulheres."
  #       )
  #     ),
  #     
  #     tags$p(
  #       style = "font-size:15px; line-height:1.8; color:#444444;",
  #       tags$strong("Aplicação prática. "),
  #       paste0(
  #         "Foram identificadas ",
  #         n_praticas,
  #         " respostas com palavras ou expressões associadas à aplicação ",
  #         "de mudanças no quotidiano. A classificação é automática e ",
  #         "deve ser validada através da leitura dos depoimentos."
  #       )
  #     ),
  #     
  #     tags$p(
  #       style = "font-size:15px; line-height:1.8; color:#444444;",
  #       tags$strong("Relações familiares e domésticas. "),
  #       paste0(
  #         n_casa,
  #         " respostas mencionam expressões relacionadas com a família, ",
  #         "o parceiro ou a divisão das tarefas domésticas."
  #       )
  #     ),
  #     
  #     tags$p(
  #       style = "font-size:15px; line-height:1.8; color:#444444;",
  #       tags$strong("Autoconfiança e autonomia. "),
  #       paste0(
  #         n_autoconfianca,
  #         " respostas incluem referências associadas à confiança, ",
  #         "à autonomia, à expressão de opinião ou à negociação."
  #       )
  #     ),
  #     
  #     tags$hr(
  #       style = "border-top:1px solid #ded8e3; margin:18px 0;"
  #     ),
  #     
  #     tags$p(
  #       style = "font-size:12px; color:#777777; line-height:1.6;",
  #       tags$em(
  #         paste0(
  #           "Universo: empreendedoras com avaliação Endline nos Ciclos 1 e 3. ",
  #           "Enquadramento: Triângulo do Poder, Jogo das 24h e ",
  #           "Seja homem, seja mulher. A classificação temática é ",
  #           "automática, baseada em palavras-chave, e requer validação ",
  #           "qualitativa das respostas originais."
  #         )
  #       )
  #     )
  #   )
  # })
  # 
  # 
  # # ==========================================================
  # # 9. KPI 1 — AVALIAÇÃO POSITIVA
  # # ==========================================================
  # 
  # output$box_avaliacao_positiva <- renderUI({
  #   
  #   n_positivas <- resumo_fechada %>%
  #     dplyr::filter(
  #       resposta %in% c(
  #         "Ajudaram bastante / mudaram a minha compreensão",
  #         "Ajudaram moderadamente"
  #       )
  #     ) %>%
  #     dplyr::summarise(
  #       total = sum(N, na.rm = TRUE)
  #     ) %>%
  #     dplyr::pull(total)
  #   
  #   if (length(n_positivas) == 0 || is.na(n_positivas)) {
  #     n_positivas <- 0
  #   }
  #   
  #   total_respostas <- sum(
  #     resumo_fechada$N,
  #     na.rm = TRUE
  #   )
  #   
  #   pct_positiva <- if (total_respostas > 0) {
  #     round(n_positivas / total_respostas * 100, 1)
  #   } else {
  #     0
  #   }
  #   
  #   div(
  #     class = "value-box blue",
  #     
  #     div(
  #       class = "kpi-icon",
  #       style = "font-size:30px;",
  #       icon("check-circle")
  #     ),
  #     
  #     div(
  #       class = "kpi-value",
  #       style = "font-size:30px;font-weight:200;line-height:1.1;",
  #       paste0(
  #         format(pct_positiva, nsmall = 1, decimal.mark = ","),
  #         "%"
  #       )
  #     ),
  #     
  #     div(
  #       class = "kpi-title",
  #       style = "font-size:16px;",
  #       "Avaliação positiva"
  #     ),
  #     
  #     div(
  #       class = "kpi-detail",
  #       style = "font-size:14px;",
  #       paste0(
  #         n_positivas, " de ", total_respostas,
  #         " · Bastante + Moderadamente"
  #       )
  #     )
  #   )
  # })
  # 
  # 
  # # ==========================================================
  # # 10. KPI 2 — AJUDARAM BASTANTE
  # # ==========================================================
  # 
  # output$box_praticas <- renderUI({
  #   
  #   total_bastante <- resumo_fechada %>%
  #     dplyr::filter(
  #       resposta == "Ajudaram bastante / mudaram a minha compreensão"
  #     ) %>%
  #     dplyr::summarise(
  #       total = sum(N, na.rm = TRUE)
  #     ) %>%
  #     dplyr::pull(total)
  #   
  #   if (length(total_bastante) == 0 || is.na(total_bastante)) {
  #     total_bastante <- 0
  #   }
  #   
  #   total_respostas <- sum(
  #     resumo_fechada$N,
  #     na.rm = TRUE
  #   )
  #   
  #   pct_bastante_kpi <- if (total_respostas > 0) {
  #     round(total_bastante / total_respostas * 100, 1)
  #   } else {
  #     0
  #   }
  #   
  #   div(
  #     class = "value-box green",
  #     
  #     div(
  #       class = "kpi-icon",
  #       style = "font-size:30px;",
  #       icon("lightbulb")
  #     ),
  #     
  #     div(
  #       class = "kpi-value",
  #       style = "font-size:30px;font-weight:500;line-height:1.1;",
  #       paste0(
  #         format(pct_bastante_kpi, nsmall = 1, decimal.mark = ","),
  #         "%"
  #       )
  #     ),
  #     
  #     div(
  #       class = "kpi-title",
  #       style = "font-size:16px;",
  #       "Ajudaram bastante"
  #     ),
  #     
  #     div(
  #       class = "kpi-detail",
  #       style = "font-size:14px;",
  #       paste0(
  #         total_bastante, " de ", total_respostas,
  #         " · Mudaram a sua compreensão"
  #       )
  #     )
  #   )
  # })
  # 
  # 
  # # ==========================================================
  # # 11. KPI 3 — PRÁTICA NOVA
  # # ==========================================================
  # 
  # output$box_casa <- renderUI({
  #   
  #   total_praticas <- n_praticas
  #   total_participantes <- n_participantes
  #   
  #   pct_praticas <- if (total_participantes > 0) {
  #     round(total_praticas / total_participantes * 100, 1)
  #   } else {
  #     0
  #   }
  #   
  #   div(
  #     class = "value-box orange",
  #     
  #     div(
  #       class = "kpi-icon",
  #       style = "font-size:30px;",
  #       icon("check-square")
  #     ),
  #     
  #     div(
  #       class = "kpi-value",
  #       style = "font-size:30px;font-weight:500;line-height:1.1;",
  #       paste0(
  #         format(pct_praticas, nsmall = 1, decimal.mark = ","),
  #         "%"
  #       )
  #     ),
  #     
  #     div(
  #       class = "kpi-title",
  #       style = "font-size:16px;",
  #       "Descrevem uma prática nova"
  #     ),
  #     
  #     div(
  #       class = "kpi-detail",
  #       style = "font-size:14px;",
  #       paste0(
  #         total_praticas, " de ", total_participantes,
  #         " participantes com resposta aberta"
  #       )
  #     )
  #   )
  # })
  # 
  # 
  # # ==========================================================
  # # 12. KPI 4 — FAMÍLIA E TAREFAS DOMÉSTICAS
  # # ==========================================================
  # 
  # output$box_autoconfianca <- renderUI({
  #   
  #   total_referencias <- n_casa
  #   total_participantes <- n_participantes
  #   
  #   pct_casa <- if (total_participantes > 0) {
  #     round(total_referencias / total_participantes * 100, 1)
  #   } else {
  #     0
  #   }
  #   
  #   div(
  #     class = "value-box purple",
  #     
  #     div(
  #       class = "kpi-icon",
  #       style = "font-size:30px;",
  #       icon("home")
  #     ),
  #     
  #     div(
  #       class = "kpi-value",
  #       style = "font-size:30px;font-weight:500;line-height:1.1;",
  #       paste0(
  #         format(pct_casa, nsmall = 1, decimal.mark = ","),
  #         "%"
  #       )
  #     ),
  #     
  #     div(
  #       class = "kpi-title",
  #       style = "font-size:15px;line-height:1.4;",
  #       "Referências à família e às tarefas domésticas"
  #     ),
  #     
  #     div(
  #       class = "kpi-detail",
  #       style = "font-size:14px;",
  #       paste0(
  #         total_referencias, " de ", total_participantes,
  #         " participantes com resposta aberta"
  #       )
  #     )
  #   )
  # })
  # 
  # 
  # # ==========================================================
  # # 13. GRÁFICO — COMPREENSÃO DAS DESIGUALDADES
  # # CICLOS 1 E 3 · ENDLINE
  # # ==========================================================
  # 
  # output$grafico_esferas_mudanca <- renderPlotly({
  #   
  #   cor_fundo <- "#e9e3ed"
  #   
  #   ordem_respostas <- c(
  #     "Ajudaram bastante",
  #     "Ajudaram moderadamente",
  #     "Ajudaram um pouco",
  #     "Não ajudaram"
  #   )
  #   
  #   dados_observados <- resumo_fechada %>%
  #     dplyr::mutate(
  #       Resposta_plot = dplyr::case_when(
  #         resposta ==
  #           "Ajudaram bastante / mudaram a minha compreensão" ~
  #           "Ajudaram bastante",
  #         TRUE ~ resposta
  #       )
  #     ) %>%
  #     dplyr::group_by(Resposta_plot) %>%
  #     dplyr::summarise(
  #       N = sum(N, na.rm = TRUE),
  #       .groups = "drop"
  #     )
  #   
  #   dados_grafico <- tibble::tibble(
  #     Resposta_plot = ordem_respostas
  #   ) %>%
  #     dplyr::left_join(
  #       dados_observados,
  #       by = "Resposta_plot"
  #     ) %>%
  #     dplyr::mutate(
  #       N = dplyr::coalesce(N, 0)
  #     )
  #   
  #   total_respostas <- sum(
  #     dados_grafico$N,
  #     na.rm = TRUE
  #   )
  #   
  #   dados_grafico <- dados_grafico %>%
  #     dplyr::mutate(
  #       Percentagem = if (total_respostas > 0) {
  #         N / total_respostas * 100
  #       } else {
  #         0
  #       },
  #       
  #       Cor = dplyr::case_when(
  #         Resposta_plot == "Ajudaram bastante" ~ "#6A1B9A",
  #         Resposta_plot == "Ajudaram moderadamente" ~ "#7E3FB2",
  #         Resposta_plot == "Ajudaram um pouco" ~ "#A56BCB",
  #         Resposta_plot == "Não ajudaram" ~ "#D8C4E8",
  #         TRUE ~ "#D8C4E8"
  #       ),
  #       
  #       label_direita = paste0(
  #         format(
  #           round(Percentagem, 1),
  #           nsmall = 1,
  #           decimal.mark = ","
  #         ),
  #         "%"
  #       ),
  #       
  #       tooltip_txt = paste0(
  #         "<b>", Resposta_plot, "</b>",
  #         "<br>Participantes: ", N,
  #         "<br>Percentagem: ", label_direita
  #       ),
  #       
  #       posicao_label = pmin(
  #         Percentagem + 2,
  #         103
  #       ),
  #       
  #       Resposta_plot = factor(
  #         Resposta_plot,
  #         levels = rev(ordem_respostas)
  #       )
  #     ) %>%
  #     dplyr::arrange(Resposta_plot)
  #   
  #   plot_ly() %>%
  #     
  #     add_bars(
  #       data = dados_grafico,
  #       x = rep(100, nrow(dados_grafico)),
  #       y = ~Resposta_plot,
  #       orientation = "h",
  #       marker = list(
  #         color = cor_fundo,
  #         line = list(width = 0)
  #       ),
  #       width = 0.48,
  #       hoverinfo = "skip",
  #       showlegend = FALSE,
  #       name = "Fundo"
  #     ) %>%
  #     
  #     add_bars(
  #       data = dados_grafico,
  #       x = ~Percentagem,
  #       y = ~Resposta_plot,
  #       orientation = "h",
  #       marker = list(
  #         color = ~Cor,
  #         line = list(width = 0)
  #       ),
  #       width = 0.48,
  #       hoverinfo = "text",
  #       hovertext = ~tooltip_txt,
  #       showlegend = FALSE,
  #       name = "Respostas"
  #     ) %>%
  #     
  #     add_trace(
  #       data = dados_grafico,
  #       x = ~posicao_label,
  #       y = ~Resposta_plot,
  #       type = "scatter",
  #       mode = "text",
  #       text = ~label_direita,
  #       textposition = "middle right",
  #       textfont = list(
  #         color = "#333333",
  #         size = 13,
  #         family = "Arial"
  #       ),
  #       hoverinfo = "skip",
  #       showlegend = FALSE,
  #       inherit = FALSE
  #     ) %>%
  #     
  #     layout(
  #       barmode = "overlay",
  #       paper_bgcolor = "#f5f3f4",
  #       plot_bgcolor = "#f5f3f4",
  #       
  #       margin = list(
  #         l = 155,
  #         r = 65,
  #         t = 20,
  #         b = 25
  #       ),
  #       
  #       bargap = 0.38,
  #       
  #       xaxis = list(
  #         visible = FALSE,
  #         range = c(0, 115),
  #         fixedrange = TRUE,
  #         zeroline = FALSE,
  #         showgrid = FALSE
  #       ),
  #       
  #       yaxis = list(
  #         tickfont = list(
  #           color = "#333333",
  #           size = 12,
  #           family = "Arial"
  #         ),
  #         showgrid = FALSE,
  #         zeroline = FALSE,
  #         categoryorder = "array",
  #         categoryarray = rev(ordem_respostas),
  #         automargin = TRUE,
  #         fixedrange = TRUE
  #       ),
  #       
  #       font = list(
  #         color = "#333333",
  #         family = "Arial"
  #       ),
  #       
  #       hoverlabel = list(
  #         bgcolor = "#ffffff",
  #         bordercolor = "#9442d4",
  #         font = list(
  #           color = "#333333",
  #           size = 12
  #         )
  #       )
  #     ) %>%
  #     
  #     config(
  #       displayModeBar = FALSE,
  #       responsive = TRUE
  #     )
  # })
  # 
  # 
  # # ==========================================================
  # # 14. GRÁFICO — PRÁTICAS COLOCADAS EM PRÁTICA
  # # CICLOS 1 E 3 · ENDLINE
  # # ==========================================================
  # 
  # output$grafico_praticas_genero <- renderPlotly({
  #   
  #   cor_fundo <- "#e9e3ed"
  #   
  #   respostas <- dados_genero_unicos %>%
  #     dplyr::transmute(
  #       ID_Participante,
  #       depoimento = stringr::str_squish(
  #         as.character(.data[[pergunta_praticas]])
  #       )
  #     ) %>%
  #     dplyr::filter(
  #       !is.na(depoimento),
  #       depoimento != ""
  #     ) %>%
  #     dplyr::distinct(ID_Participante, .keep_all = TRUE) %>%
  #     dplyr::mutate(
  #       texto = stringi::stri_trans_general(
  #         stringr::str_to_lower(depoimento),
  #         "Latin-ASCII"
  #       )
  #     )
  #   
  #   total_participantes <- dplyr::n_distinct(
  #     respostas$ID_Participante
  #   )
  #   
  #   padrao_casa <- paste(
  #     "casa", "familia", "marido", "esposo", "parceiro",
  #     "companheiro", "filhos", "tarefas domesticas",
  #     "trabalho domestico", "dividir as tarefas",
  #     "partilhar as tarefas", "redistribu", "responsabilidades",
  #     "ajudar nas tarefas", "divisao das tarefas",
  #     "conversar com a familia",
  #     sep = "|"
  #   )
  #   
  #   padrao_eu <- paste(
  #     "confianca", "confiante", "perder o medo",
  #     "perdi o medo", "sem medo", "coragem",
  #     "acredito em mim", "acreditar em mim",
  #     "capaz", "autonomia", "independente",
  #     "tomar decisoes", "decidir por mim",
  #     "direitos", "minha opiniao", "minha voz",
  #     "expressar", "defender-me", "valorizar-me",
  #     "valorizar a mim", "autoestima",
  #     sep = "|"
  #   )
  #   
  #   padrao_negocio <- paste(
  #     "negocio", "negociar", "negociei", "negocio com",
  #     "preco", "precos", "precificar", "fixar precos",
  #     "clientes", "vender", "vendas", "lucro", "investir",
  #     "investimento", "capital", "poupanca",
  #     "formalizar", "formalizacao", "empreender",
  #     "comprar mercadoria", "gestao", "contabilidade",
  #     "calcular custos", "aumentar os rendimentos",
  #     sep = "|"
  #   )
  #   
  #   padrao_tempo <- paste(
  #     "tempo", "conciliar", "organizacao do tempo",
  #     "gerir o tempo", "gestao do tempo",
  #     "organizar o meu dia", "organizar o dia",
  #     "horario", "rotina", "equilibrar",
  #     "conciliacao", "dividir o tempo",
  #     "tempo para a familia", "tempo para o negocio",
  #     "planear o dia", "planeamento",
  #     sep = "|"
  #   )
  #   
  #   respostas_classificadas <- respostas %>%
  #     dplyr::mutate(
  #       Casa_familia = stringr::str_detect(texto, padrao_casa),
  #       Eu = stringr::str_detect(texto, padrao_eu),
  #       Negocio = stringr::str_detect(texto, padrao_negocio),
  #       Tempo = stringr::str_detect(texto, padrao_tempo)
  #     )
  #   
  #   dados_praticas <- tibble::tibble(
  #     Esfera = c(
  #       "Casa e família",
  #       "Eu",
  #       "Negócio",
  #       "Tempo"
  #     ),
  #     
  #     Descricao = c(
  #       "Redistribuir tarefas, negociar com parceiro ou família",
  #       "Autoconfiança, perder o medo, sentir-se capaz",
  #       "Negociar, fixar preços, investir, formalizar",
  #       "Conciliar o negócio e a família"
  #     ),
  #     
  #     N = c(
  #       sum(respostas_classificadas$Casa_familia, na.rm = TRUE),
  #       sum(respostas_classificadas$Eu, na.rm = TRUE),
  #       sum(respostas_classificadas$Negocio, na.rm = TRUE),
  #       sum(respostas_classificadas$Tempo, na.rm = TRUE)
  #     ),
  #     
  #     Cor = c(
  #       "#6A1B9A",
  #       "#7E3FB2",
  #       "#A56BCB",
  #       "#D8C4E8"
  #     )
  #   ) %>%
  #     dplyr::mutate(
  #       Percentagem = if (total_participantes > 0) {
  #         N / total_participantes * 100
  #       } else {
  #         0
  #       },
  #       
  #       Rotulo = paste0(
  #         N, " de ", total_participantes
  #       ),
  #       
  #       Tooltip = paste0(
  #         "<b>", Esfera, "</b>",
  #         "<br>", Descricao,
  #         "<br>Depoimentos identificados: ", N,
  #         "<br>Participantes com resposta aberta: ",
  #         total_participantes,
  #         "<br>Percentagem: ",
  #         format(
  #           round(Percentagem, 1),
  #           nsmall = 1,
  #           decimal.mark = ","
  #         ),
  #         "%"
  #       ),
  #       
  #       Esfera = factor(
  #         Esfera,
  #         levels = rev(c(
  #           "Casa e família",
  #           "Eu",
  #           "Negócio",
  #           "Tempo"
  #         ))
  #       )
  #     ) %>%
  #     dplyr::arrange(Esfera)
  #   
  #   plot_ly() %>%
  #     
  #     add_bars(
  #       data = dados_praticas,
  #       x = rep(total_participantes, nrow(dados_praticas)),
  #       y = ~Esfera,
  #       orientation = "h",
  #       marker = list(
  #         color = cor_fundo,
  #         line = list(width = 0)
  #       ),
  #       width = 0.48,
  #       hoverinfo = "skip",
  #       showlegend = FALSE,
  #       name = "Total de participantes"
  #     ) %>%
  #     
  #     add_bars(
  #       data = dados_praticas,
  #       x = ~N,
  #       y = ~Esfera,
  #       orientation = "h",
  #       marker = list(
  #         color = ~Cor,
  #         line = list(width = 0)
  #       ),
  #       width = 0.48,
  #       hoverinfo = "text",
  #       hovertext = ~Tooltip,
  #       showlegend = FALSE,
  #       name = "Esferas identificadas"
  #     ) %>%
  #     
  #     add_trace(
  #       data = dados_praticas,
  #       x = ~pmin(N + 0.7, total_participantes + 1),
  #       y = ~Esfera,
  #       type = "scatter",
  #       mode = "text",
  #       text = ~Rotulo,
  #       textposition = "middle right",
  #       textfont = list(
  #         color = "#333333",
  #         size = 12,
  #         family = "Arial"
  #       ),
  #       hoverinfo = "skip",
  #       showlegend = FALSE,
  #       inherit = FALSE
  #     ) %>%
  #     
  #     layout(
  #       barmode = "overlay",
  #       paper_bgcolor = "#f5f3f4",
  #       plot_bgcolor = "#f5f3f4",
  #       
  #       margin = list(
  #         l = 110,
  #         r = 75,
  #         t = 20,
  #         b = 25
  #       ),
  #       
  #       bargap = 0.38,
  #       
  #       xaxis = list(
  #         visible = FALSE,
  #         range = c(
  #           0,
  #           max(total_participantes + 5, 10)
  #         ),
  #         fixedrange = TRUE,
  #         zeroline = FALSE,
  #         showgrid = FALSE
  #       ),
  #       
  #       yaxis = list(
  #         title = "",
  #         tickfont = list(
  #           color = "#333333",
  #           size = 12,
  #           family = "Arial"
  #         ),
  #         showgrid = FALSE,
  #         zeroline = FALSE,
  #         categoryorder = "array",
  #         categoryarray = rev(c(
  #           "Casa e família",
  #           "Eu",
  #           "Negócio",
  #           "Tempo"
  #         )),
  #         automargin = TRUE,
  #         fixedrange = TRUE
  #       ),
  #       
  #       font = list(
  #         color = "#333333",
  #         family = "Arial"
  #       ),
  #       
  #       hoverlabel = list(
  #         bgcolor = "#ffffff",
  #         bordercolor = "#9442d4",
  #         font = list(
  #           color = "#333333",
  #           size = 12
  #         )
  #       )
  #     ) %>%
  #     
  #     config(
  #       displayModeBar = FALSE,
  #       responsive = TRUE
  #     )
  # })
  # 
  # 
  # # ============================================================
  # # 15. CLASSIFICAÇÃO TEMÁTICA DOS DEPOIMENTOS
  # # ============================================================
  # 
  # classificar_tema_genero <- function(texto) {
  #   
  #   if (
  #     length(texto) == 0 ||
  #     is.na(texto) ||
  #     !nzchar(stringr::str_squish(texto))
  #   ) {
  #     return("Tema não classificado")
  #   }
  #   
  #   texto_limpo <- stringi::stri_trans_general(
  #     stringr::str_to_lower(texto),
  #     "Latin-ASCII"
  #   )
  #   
  #   regras_temas <- list(
  #     
  #     "Trabalho doméstico" = paste(
  #       "tarefas domesticas", "trabalho domestico",
  #       "casa", "familia", "filhos", "cozinhar",
  #       "limpar", "lavar", "dividir tarefas",
  #       "redistribuir", "responsabilidades domesticas",
  #       "marido", "esposo", "parceiro", "companheiro",
  #       sep = "|"
  #     ),
  #     
  #     "Poder interior" = paste(
  #       "confianca", "autoconfianca", "autoestima",
  #       "perder o medo", "coragem", "sentir-me capaz",
  #       "acreditar em mim", "acredito em mim",
  #       "me tornei capaz", "autonomia", "independencia",
  #       "tomar decisoes", "minha voz", "minha opiniao",
  #       "direitos",
  #       sep = "|"
  #     ),
  #     
  #     "Negociar e fixar preços" = paste(
  #       "negociar", "negociei", "negociacao",
  #       "fixar precos", "preco", "precos",
  #       "clientes", "vendas", "vender", "lucro",
  #       "investir", "capital", "formalizar", "formalizacao",
  #       sep = "|"
  #     ),
  #     
  #     "Relações de poder" = paste(
  #       "poder de decisao", "tomada de decisao",
  #       "decisao conjunta", "igualdade", "desigualdade",
  #       "respeito", "direitos", "voz na familia",
  #       "ser ouvida", "participar nas decisoes",
  #       "relacao de poder",
  #       sep = "|"
  #     ),
  #     
  #     "Estereótipos ocupacionais" = paste(
  #       "trabalho de homem", "trabalho de mulher",
  #       "profissao de homem", "profissao de mulher",
  #       "actividade de homem", "actividade de mulher",
  #       "atividade de homem", "atividade de mulher",
  #       "homens podem", "mulheres podem",
  #       "mulher nao pode", "homem nao pode",
  #       "estereotipo", "discriminacao no trabalho",
  #       sep = "|"
  #     ),
  #     
  #     "Tensões" = paste(
  #       "conflito", "discussao", "discutir",
  #       "problema", "dificuldade", "discordancia",
  #       "rejeicao", "resistencia", "oposicao",
  #       "nao aceitou", "nao aceitaram",
  #       "briga", "tensao",
  #       sep = "|"
  #     )
  #   )
  #   
  #   temas_encontrados <- names(regras_temas)[
  #     vapply(
  #       regras_temas,
  #       function(padrao) {
  #         stringr::str_detect(texto_limpo, padrao)
  #       },
  #       logical(1)
  #     )
  #   ]
  #   
  #   if (length(temas_encontrados) == 0) {
  #     return("Tema não classificado")
  #   }
  #   
  #   # Mantém o primeiro tema encontrado, tal como na lógica original.
  #   temas_encontrados[1]
  # }
  # 
  # 
  # # ============================================================
  # # 16. PREPARAR OS DEPOIMENTOS POR ID
  # # ============================================================
  # 
  # dados_depoimentos_genero <- dados_genero_unicos %>%
  #   dplyr::transmute(
  #     ID_Participante = as.character(ID_Participante),
  #     Texto_original = as.character(.data[[pergunta_praticas]])
  #   ) %>%
  #   dplyr::mutate(
  #     ID_Participante = stringr::str_squish(ID_Participante),
  #     texto_verificacao = stringr::str_squish(Texto_original)
  #   ) %>%
  #   dplyr::filter(
  #     !is.na(ID_Participante),
  #     ID_Participante != "",
  #     !is.na(Texto_original),
  #     texto_verificacao != ""
  #   ) %>%
  #   dplyr::distinct(
  #     ID_Participante,
  #     .keep_all = TRUE
  #   ) %>%
  #   dplyr::mutate(
  #     Depoimento = Texto_original,
  #     Tema = vapply(
  #       Depoimento,
  #       classificar_tema_genero,
  #       character(1)
  #     )
  #   ) %>%
  #   dplyr::select(
  #     ID_Participante,
  #     Texto_original,
  #     Depoimento,
  #     Tema
  #   )
  # 
  # 
  # # ============================================================
  # # 17. CARTÕES INDIVIDUAIS — VOZES DAS PARTICIPANTES
  # # ============================================================
  # 
  # output$depoimentos_genero <- renderUI({
  #   
  #   dados <- dados_depoimentos_genero
  #   
  #   tema_selecionado <- input$filtro_tema_qualitativo
  #   
  #   if (
  #     is.null(tema_selecionado) ||
  #     length(tema_selecionado) == 0 ||
  #     tema_selecionado == ""
  #   ) {
  #     tema_selecionado <- "Todos"
  #   }
  #   
  #   if (tema_selecionado != "Todos") {
  #     dados <- dados %>%
  #       dplyr::filter(Tema == tema_selecionado)
  #   }
  #   
  #   if (nrow(dados) == 0) {
  #     return(
  #       div(
  #         style = paste(
  #           "background-color:#ffffff;",
  #           "padding:20px;",
  #           "border-radius:8px;",
  #           "text-align:center;",
  #           "color:#777777;"
  #         ),
  #         icon("info-circle"),
  #         p("Não existem depoimentos para o tema seleccionado.")
  #       )
  #     )
  #   }
  #   
  #   cores_temas <- c(
  #     "Trabalho doméstico" = "#6A1B9A",
  #     "Poder interior" = "#7E3FB2",
  #     "Negociar e fixar preços" = "#A56BCB",
  #     "Relações de poder" = "#9442D4",
  #     "Estereótipos ocupacionais" = "#F77333",
  #     "Tensões" = "#42A5F5",
  #     "Tema não classificado" = "#999999"
  #   )
  #   
  #   div(
  #     class = "depoimentos-genero-container",
  #     
  #     div(
  #       style = paste(
  #         "display:flex;",
  #         "justify-content:space-between;",
  #         "align-items:center;",
  #         "flex-wrap:wrap;",
  #         "gap:8px;",
  #         "margin-bottom:15px;"
  #       ),
  #       
  #       tags$strong(
  #         paste(
  #           nrow(dados),
  #           if (nrow(dados) == 1) {
  #             "depoimento encontrado"
  #           } else {
  #             "depoimentos encontrados"
  #           }
  #         ),
  #         style = "color:#444444;"
  #       ),
  #       
  #       span(
  #         style = "font-size:12px;color:#777777;",
  #         tema_selecionado
  #       )
  #     ),
  #     
  #     fluidRow(
  #       lapply(seq_len(nrow(dados)), function(i) {
  #         
  #         registo <- dados[i, ]
  #         
  #         tema <- registo$Tema[[1]]
  #         cor_tema <- unname(cores_temas[tema])
  #         
  #         if (
  #           length(cor_tema) == 0 ||
  #           is.na(cor_tema)
  #         ) {
  #           cor_tema <- "#999999"
  #         }
  #         
  #         column(
  #           width = 6,
  #           
  #           div(
  #             style = paste0(
  #               "background-color:#ffffff;",
  #               "border-left:5px solid ", cor_tema, ";",
  #               "border-radius:8px;",
  #               "padding:16px;",
  #               "margin-bottom:16px;",
  #               "box-shadow:0 2px 6px rgba(0,0,0,0.06);",
  #               "height:auto;"
  #             ),
  #             
  #             span(
  #               style = paste0(
  #                 "display:inline-block;",
  #                 "background-color:", cor_tema, "18;",
  #                 "color:", cor_tema, ";",
  #                 "padding:5px 9px;",
  #                 "border-radius:12px;",
  #                 "font-size:11px;",
  #                 "font-weight:600;",
  #                 "margin-bottom:10px;"
  #               ),
  #               tema
  #             ),
  #             
  #             tags$blockquote(
  #               style = paste(
  #                 "border-left:0;",
  #                 "padding:0;",
  #                 "margin:0 0 14px 0;",
  #                 "font-size:14px;",
  #                 "line-height:1.6;",
  #                 "color:#333333;",
  #                 "font-style:italic;",
  #                 "white-space:pre-wrap;",
  #                 "overflow-wrap:anywhere;"
  #               ),
  #               registo$Depoimento[[1]]
  #             ),
  #             
  #             div(
  #               style = paste(
  #                 "border-top:1px solid #eeeeee;",
  #                 "padding-top:8px;",
  #                 "font-size:11px;",
  #                 "color:#777777;"
  #               ),
  #               
  #               icon("user"),
  #               
  #               span(
  #                 style = "margin-left:5px;",
  #                 paste(
  #                   "ID:",
  #                   registo$ID_Participante[[1]]
  #                 )
  #               )
  #             )
  #           )
  #         )
  #       })
  #     )
  #   )
  # })
  # 
  
  
  # ============================================================
  # PAM VERDE — AVALIAÇÃO DE GÉNERO
  # FILTROS | INDICADORES | GRÁFICOS | DEPOIMENTOS
  # ============================================================
  
  # Dependências:
  # shiny, dplyr, tidyr, tibble, stringr, stringi, plotly
  
  # ------------------------------------------------------------
  # 1. PERGUNTAS
  # Definir uma única vez antes de server()
  # ------------------------------------------------------------
  
  pergunta_fechada <- paste0(
    "Até que ponto as actividades ligadas à questão de género ",
    "ajudaram a compreender as desigualdades entre homens e mulheres?"
  )
  
  pergunta_aberta <- paste0(
    "Podes dizer algo que colocaste em prática ",
    "depois de ter tido essas actividades?"
  )
  
  
  # ============================================================
  # 2. FUNÇÕES AUXILIARES
  # ============================================================
  
  normalizar_texto_genero <- function(x) {
    x <- as.character(x)
    x[is.na(x)] <- ""
    
    x <- stringi::stri_trans_general(x, "Latin-ASCII")
    x <- tolower(x)
    x <- gsub("[^[:alnum:]]+", " ", x)
    x <- gsub("\\s+", " ", x)
    
    trimws(x)
  }
  
  
  detectar_coluna_id_genero <- function(df) {
    
    candidatos <- c(
      "ID_Participante",
      "id_participante",
      "ID_participante",
      "ID",
      "id",
      "Codigo_Participante",
      "Código_Participante",
      "ID_MUVA"
    )
    
    encontrada <- candidatos[candidatos %in% names(df)]
    
    if (length(encontrada) == 0) {
      stop(
        "Não foi encontrada uma coluna de identificação das participantes."
      )
    }
    
    encontrada[1]
  }
  
  
  # ============================================================
  # 3. CLASSIFICAÇÃO DOS DEPOIMENTOS
  # ============================================================
  
  classificar_tema_genero <- function(texto) {
    
    texto <- normalizar_texto_genero(texto)
    
    if (length(texto) == 0 || is.na(texto[1]) || texto[1] == "") {
      return("Tema não classificado")
    }
    
    texto <- texto[1]
    
    regras <- list(
      
      # 1. Trabalho doméstico
      "Trabalho doméstico" = paste(
        "tarefa(s)? domestica(s)?",
        "trabalho domestico",
        "trabalho de casa",
        "dividir.*tarefas",
        "dividimos tarefas",
        "tarefas de casa",
        "dividir trabalhos",
        "escala de actividade",
        "varre o",
        "partilhar.*tarefas",
        "repartir.*tarefas",
        "redistribuir",
        "divisao das tarefas",
        "responsabilidades da casa",
        "ajudar nas tarefas",
        "cuidado dos filhos",
        "cuidar dos filhos",
        "sobrecarregadas",
        "sub carregadas",
        "marido.*tarefas",
        "companheiro.*tarefas",
        "familia.*tarefas",
        sep = "|"
      ),
      
      # 2. Poder interior
      "Poder interior" = paste(
        "confianca",
        "confiante",
        "autoestima",
        "acredito em mim",
        "acreditar em mim",
        "sentir me capaz",
        "sinto me capaz",
        "ser capaz",
        "autonomia",
        "independente",
        "perder o medo",
        "responsabilidades emocionais",
        "coragem",
        "sentia capaz",
        "defender.*posicao",
        "defender.*direitos",
        "expressar.*opiniao",
        "dar.*opiniao",
        "valorizar me",
        "conhecer os meus direitos",
        sep = "|"
      ),
      
      # 3. Negociar e fixar preços
      "Negociar e fixar preços" = paste(
        "negociar",
        "negociacao",
        "fixar.*preco",
        "definir.*preco",
        "preco(s)?",
        "vender",
        "vendas",
        "cliente(s)?",
        "lucro",
        "calcular.*custo",
        "custo(s)?",
        "investir",
        "investimento",
        "capital",
        "poupanca",
        "formalizar",
        "formalizacao",
        "empreender",
        "negocio",
        sep = "|"
      ),
      
      # 4. Relações de poder
      "Relações de poder" = paste(
        "relacao de poder",
        "relacoes de poder",
        "tomar.*decis",
        "decis.*familia",
        "decis.*casal",
        "decis.*marido",
        "decis.*companheiro",
        "poder de decis",
        "igualdade entre homens e mulheres",
        "igualdade de genero",
        "ser respeitada",
        "respeito.*marido",
        "respeito.*mulher",
        "participar.*decis",
        "controlo.*marido",
        "controlo.*companheiro",
        "voz.*familia",
        sep = "|"
      ),
      
      # 5. Estereótipos ocupacionais
      "Estereótipos ocupacionais" = paste(
        "profissao.*de homem",
        "profissao.*de mulher",
        "trabalho.*de homem",
        "trabalho.*de mulher",
        "negocio.*de homem",
        "negocio.*de mulher",
        "actividade.*de homem",
        "actividade.*de mulher",
        "atividade.*de homem",
        "atividade.*de mulher",
        "trabalho masculino",
        "trabalho feminino",
        "homens podem",
        "mulheres podem",
        "mulher também pode ser capaz",
        "homem.*nao pode",
        "mulher.*nao pode",
        sep = "|"
      ),
      
      # 6. Tensões
      "Tensões" = paste(
        "conflito",
        "discussao",
        "discutir",
        "desacordo",
        "discordancia",
        "resistencia",
        "resistiu",
        "nao aceita",
        "nao aceitou",
        "dificuldade.*marido",
        "dificuldade.*familia",
        "oposicao.*familia",
        "oposicao.*marido",
        "problema.*familia",
        "problema.*marido",
        "zanga",
        "tensao",
        sep = "|"
      ),
      
      # 7. Tempo
      "Tempo" = paste(
        "gestao do tempo",
        "organizar.*tempo",
        "organizar.*dia",
        "organizar.*horario",
        "gestao.*horario",
        "horario",
        "rotina",
        "planear.*dia",
        "planeamento",
        "conciliar",
        "conciliacao",
        "equilibrar.*tempo",
        "dividir.*tempo",
        "tempo com a familia",
        "tempo com o negocio",
        "tempo para a familia",
        "tempo para o negocio",
        "administrar.*tempo",
        "gerir.*tempo",
        "organizar.*actividades",
        "organizar.*atividades",
        "equilibrio entre.*familia.*negocio",
        sep = "|"
      )
    )
    
    # A primeira regra que corresponde ao texto determina o tema.
    for (tema in names(regras)) {
      
      if (grepl(
        regras[[tema]],
        texto,
        perl = TRUE
      )) {
        return(tema)
      }
    }
    
    "Tema não classificado"
  }
  
  
  # ============================================================
  # 4. CÓDIGO DENTRO DO SERVER EXISTENTE
  # Não criar um segundo server()
  # ============================================================
  
  # ------------------------------------------------------------
  # 4.1. Base filtrada por Cidade, Ciclo e Endline
  # ------------------------------------------------------------
  
  dados_genero_filtrados <- shiny::reactive({
    
    shiny::req(
      input$filtro_cidade,
      input$filtro_ciclo
    )
    
    df <- Pam_Verde_Indicadores
    
    obrigatorias <- c(
      "Cidade",
      "Ciclo",
      "Tipo_Avaliacao"
    )
    
    em_falta <- setdiff(obrigatorias, names(df))
    
    shiny::validate(
      shiny::need(
        length(em_falta) == 0,
        paste(
          "Colunas em falta:",
          paste(em_falta, collapse = ", ")
        )
      )
    )
    
    coluna_id <- detectar_coluna_id_genero(df)
    
    shiny::validate(
      shiny::need(
        pergunta_fechada %in% names(df),
        "A pergunta fechada não foi encontrada na base."
      ),
      shiny::need(
        pergunta_aberta %in% names(df),
        "A pergunta aberta não foi encontrada na base."
      )
    )
    
    df <- df %>%
      dplyr::mutate(
        ID_Participante = trimws(
          as.character(.data[[coluna_id]])
        ),
        Cidade_filtro = trimws(as.character(Cidade)),
        Ciclo_filtro = trimws(as.character(Ciclo)),
        Tipo_Avaliacao_texto = normalizar_texto_genero(
          Tipo_Avaliacao
        )
      )
    
    # Cidade
    if (!input$filtro_cidade %in% c(
      "Todas", "Todos", "Todas as cidades", ""
    )) {
      
      df <- df %>%
        dplyr::filter(
          Cidade_filtro == input$filtro_cidade
        )
    }
    
    # Ciclo
    if (!input$filtro_ciclo %in% c(
      "Todos", "Todas", "Todos os ciclos", ""
    )) {
      
      df <- df %>%
        dplyr::filter(
          normalizar_texto_genero(Ciclo_filtro) ==
            normalizar_texto_genero(input$filtro_ciclo)
        )
    }
    
    # Endline exclusivamente
    df <- df %>%
      dplyr::filter(
        Tipo_Avaliacao_texto == "endline",
        !is.na(ID_Participante),
        ID_Participante != ""
      ) %>%
      dplyr::distinct()
    
    df
  })
  
  
  # ------------------------------------------------------------
  # 4.2. Respostas abertas e fechadas
  # ------------------------------------------------------------
  
  respostas_genero <- shiny::reactive({
    
    dados_genero_filtrados() %>%
      dplyr::mutate(
        resposta_aberta = trimws(
          as.character(.data[[pergunta_aberta]])
        ),
        resposta_fechada = trimws(
          as.character(.data[[pergunta_fechada]])
        )
      )
  })
  
  
  dados_fechada_genero <- shiny::reactive({
    
    respostas_genero() %>%
      dplyr::filter(
        !is.na(resposta_fechada),
        resposta_fechada != "",
        !tolower(resposta_fechada) %in% c("na", "n/a")
      ) %>%
      dplyr::distinct(
        ID_Participante,
        .keep_all = TRUE
      )
  })
  
  
  dados_abertos_genero <- shiny::reactive({
    
    respostas_genero() %>%
      dplyr::filter(
        !is.na(resposta_aberta),
        resposta_aberta != "",
        !tolower(resposta_aberta) %in% c("na", "n/a")
      ) %>%
      dplyr::mutate(
        texto_norm = normalizar_texto_genero(resposta_aberta)
      ) %>%
      dplyr::filter(texto_norm != "") %>%
      dplyr::distinct(
        ID_Participante,
        .keep_all = TRUE
      )
  })
  
  
  # ============================================================
  # 5. DETECÇÃO DAS DUAS BOXES
  # ============================================================
  
  resumo_boxes_praticas_genero <- shiny::reactive({
    
    df <- dados_abertos_genero()
    
    total <- dplyr::n_distinct(df$ID_Participante)
    
    if (nrow(df) == 0 || total == 0) {
      
      return(
        tibble::tibble(
          Indicador = c("pratica_nova", "familia_tarefas"),
          Total = c(total, total),
          N = c(0L, 0L),
          Percentagem = c(NA_real_, NA_real_)
        )
      )
    }
    
    texto <- df$texto_norm
    
    # ----------------------------------------------------------
    # BOX 1 — PRÁTICA NOVA
    #
    # Inclui verbos de mudança, aplicação, organização,
    # negociação e acções concretas descritas pelas participantes.
    # ----------------------------------------------------------
    
    padrao_pratica <- paste(
      "\\bcomecei\\b",
      "\\bpassei a\\b",
      "\\bagora faco\\b",
      "\\bcoloquei em pratica\\b",
      "\\bpus em pratica\\b",
      "\\bpratiquei\\b",
      "\\bmudei\\b",
      "\\bmudanca(s)?\\b",
      "\\baprendi a\\b",
      "\\bdecidi\\b",
      "\\bimplementei\\b",
      "\\bapliquei\\b",
      "\\badoptei\\b",
      "\\badotei\\b",
      "\\bja consigo\\b",
      "\\bconverso com\\b",
      "\\bfalo com\\b",
      "\\bnegocio com\\b",
      "\\borganizo\\b",
      "\\bcontrolo\\b",
      "\\bpartilho\\b",
      "\\bdivido\\b",
      "\\bajudo\\b",
      "\\bplaneio\\b",
      "\\bplanifico\\b",
      "\\bgerir melhor\\b",
      "\\bgestao do tempo\\b",
      "\\bfixar preco\\b",
      "\\bdefinir preco\\b",
      "\\bcontrolo o dinheiro\\b",
      "\\bseparo o dinheiro\\b",
      "\\banoto as despesas\\b",
      "\\bregisto as despesas\\b",
      sep = "|"
    )
    
    menciona_pratica <- grepl(
      padrao_pratica,
      texto,
      perl = TRUE
    )
    
    # ----------------------------------------------------------
    # BOX 2 — FAMÍLIA E TAREFAS DOMÉSTICAS
    #
    # A pesquisa é feita no texto sem acentos.
    # Inclui referências à família, casa, parceiro e tarefas.
    # ----------------------------------------------------------
    
    padrao_familia <- paste(
      "\\bfamilia\\b",
      "\\bem casa\\b",
      "\\bmarido\\b",
      "\\besposo\\b",
      "\\bcompanheiro\\b",
      "\\bparceiro\\b",
      "\\bfilhos\\b",
      "\\bcriancas\\b",
      "\\btarefa(s)? domestica(s)?\\b",
      "\\btrabalho domestico\\b",
      "\\btrabalho de casa\\b",
      "\\bservico(s)? domestico(s)?\\b",
      "\\bdividir.*tarefas\\b",
      "\\bpartilhar.*tarefas\\b",
      "\\brepartir.*tarefas\\b",
      "\\bdivisao das tarefas\\b",
      "\\bresponsabilidades domesticas\\b",
      "\\bresponsabilidades da casa\\b",
      "\\bajudar em casa\\b",
      "\\bajuda em casa\\b",
      "\\bajudar nas tarefas\\b",
      "\\bcuidar dos filhos\\b",
      "\\bcuidado dos filhos\\b",
      "\\btomar conta dos filhos\\b",
      "\\blimpar a casa\\b",
      "\\bcozinhar\\b",
      "\\blavar a roupa\\b",
      "\\bbuscar agua\\b",
      "\\bconversar com o marido\\b",
      "\\bconversar com a familia\\b",
      "\\bpartilhar as responsabilidades\\b",
      "\\bdividir as responsabilidades\\b",
      sep = "|"
    )
    
    menciona_familia <- grepl(
      padrao_familia,
      texto,
      perl = TRUE
    )
    
    n_praticas <- sum(menciona_pratica, na.rm = TRUE)
    n_familia <- sum(menciona_familia, na.rm = TRUE)
    
    tibble::tibble(
      Indicador = c("pratica_nova", "familia_tarefas"),
      Total = c(total, total),
      N = c(n_praticas, n_familia),
      Percentagem = c(
        n_praticas / total * 100,
        n_familia / total * 100
      )
    )
  })
  
  
  # ============================================================
  # 6. INDICADORES GERAIS
  # ============================================================
  
  resumo_fechada_genero <- shiny::reactive({
    
    df <- dados_fechada_genero()
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem respostas fechadas válidas para os filtros seleccionados."
      )
    )
    
    df %>%
      dplyr::count(
        resposta_fechada,
        name = "N"
      ) %>%
      dplyr::mutate(
        Percentagem = N / sum(N) * 100
      )
  })
  
  
  indicadores_genero <- shiny::reactive({
    
    df <- dados_genero_filtrados()
    fechadas <- dados_fechada_genero()
    abertas <- dados_abertos_genero()
    boxes <- resumo_boxes_praticas_genero()
    
    n_participantes <- dplyr::n_distinct(df$ID_Participante)
    n_fechadas <- nrow(fechadas)
    n_abertas <- nrow(abertas)
    
    bastante <- sum(
      grepl(
        "^Ajudaram bastante",
        fechadas$resposta_fechada,
        ignore.case = TRUE
      ),
      na.rm = TRUE
    )
    
    moderadamente <- sum(
      grepl(
        "^Ajudaram moderadamente",
        fechadas$resposta_fechada,
        ignore.case = TRUE
      ),
      na.rm = TRUE
    )
    
    positivas <- bastante + moderadamente
    
    n_praticas <- boxes$N[boxes$Indicador == "pratica_nova"][1]
    n_casa <- boxes$N[boxes$Indicador == "familia_tarefas"][1]
    
    pct_bastante <- if (n_fechadas > 0) {
      bastante / n_fechadas * 100
    } else {
      NA_real_
    }
    
    pct_positivas <- if (n_fechadas > 0) {
      positivas / n_fechadas * 100
    } else {
      NA_real_
    }
    
    pct_praticas <- if (nrow(abertas) > 0) {
      n_praticas / nrow(abertas) * 100
    } else {
      NA_real_
    }
    
    pct_casa <- if (nrow(abertas) > 0) {
      n_casa / nrow(abertas) * 100
    } else {
      NA_real_
    }
    
    list(
      participantes = n_participantes,
      respostas_fechadas = n_fechadas,
      respostas_abertas = n_abertas,
      bastante = bastante,
      moderadamente = moderadamente,
      positivas = positivas,
      participantes_praticas = n_praticas,
      participantes_casa = n_casa,
      pct_bastante = pct_bastante,
      pct_positivas = pct_positivas,
      pct_praticas = pct_praticas,
      pct_casa = pct_casa
    )
  })
  
  
  # ============================================================
  # 7. CLASSIFICAR OS DEPOIMENTOS
  # ============================================================
  
  dados_depoimentos_genero <- shiny::reactive({
    
    dados_abertos_genero() %>%
      dplyr::transmute(
        ID_Participante = as.character(ID_Participante),
        Depoimento = as.character(resposta_aberta)
      ) %>%
      dplyr::filter(
        !is.na(Depoimento),
        trimws(Depoimento) != ""
      ) %>%
      dplyr::distinct(
        ID_Participante,
        .keep_all = TRUE
      ) %>%
      dplyr::mutate(
        Tema = vapply(
          Depoimento,
          classificar_tema_genero,
          FUN.VALUE = character(1),
          USE.NAMES = FALSE
        )
      )
  })
  
  
  # ============================================================
  # 8. GRÁFICO 1 — COMPREENSÃO DAS DESIGUALDADES
  # ============================================================
  
  output$grafico_esferas_mudanca <- plotly::renderPlotly({
    
    resumo <- resumo_fechada_genero()
    
    ordem <- c(
      "Ajudaram bastante",
      "Ajudaram moderadamente",
      "Ajudaram um pouco",
      "Não ajudaram"
    )
    
    observados <- resumo %>%
      dplyr::mutate(
        Resposta_plot = dplyr::case_when(
          grepl("^Ajudaram bastante", resposta_fechada,
                ignore.case = TRUE) ~ "Ajudaram bastante",
          grepl("^Ajudaram moderadamente", resposta_fechada,
                ignore.case = TRUE) ~ "Ajudaram moderadamente",
          grepl("^Ajudaram um pouco", resposta_fechada,
                ignore.case = TRUE) ~ "Ajudaram um pouco",
          grepl("^N[aã]o ajudaram", resposta_fechada,
                ignore.case = TRUE) ~ "Não ajudaram",
          TRUE ~ NA_character_
        )
      ) %>%
      dplyr::filter(!is.na(Resposta_plot)) %>%
      dplyr::group_by(Resposta_plot) %>%
      dplyr::summarise(N = sum(N), .groups = "drop")
    
    total <- sum(observados$N)
    
    shiny::validate(
      shiny::need(total > 0, "Não existem respostas reconhecidas.")
    )
    
    grafico <- tibble::tibble(
      Resposta_plot = ordem
    ) %>%
      dplyr::left_join(observados, by = "Resposta_plot") %>%
      dplyr::mutate(
        N = tidyr::replace_na(N, 0),
        Percentagem = N / total * 100,
        Cor = dplyr::case_when(
          Resposta_plot == "Ajudaram bastante" ~ "#6A1B9A",
          Resposta_plot == "Ajudaram moderadamente" ~ "#7E3FB2",
          Resposta_plot == "Ajudaram um pouco" ~ "#A56BCB",
          TRUE ~ "#D8C4E8"
        ),
        Rotulo = paste0(format(round(Percentagem, 1), nsmall = 1), "%"),
        Tooltip = paste0(
          Resposta_plot,
          "<br>Respostas: ", N,
          "<br>Percentagem: ", Rotulo
        ),
        Posicao = pmin(Percentagem + 2, 108),
        Resposta_plot = factor(
          Resposta_plot,
          levels = rev(ordem)
        )
      )
    
    plotly::plot_ly() %>%
      plotly::add_bars(
        data = grafico,
        x = rep(100, nrow(grafico)),
        y = ~Resposta_plot,
        orientation = "h",
        marker = list(color = "#e9e3ed", line = list(width = 0)),
        width = 0.48,
        hoverinfo = "skip",
        showlegend = FALSE
      ) %>%
      plotly::add_bars(
        data = grafico,
        x = ~Percentagem,
        y = ~Resposta_plot,
        orientation = "h",
        marker = list(color = ~Cor, line = list(width = 0)),
        width = 0.48,
        hoverinfo = "text",
        hovertext = ~Tooltip,
        showlegend = FALSE
      ) %>%
      plotly::add_trace(
        data = grafico,
        x = ~Posicao,
        y = ~Resposta_plot,
        type = "scatter",
        mode = "text",
        text = ~Rotulo,
        textposition = "middle right",
        textfont = list(color = "#333333", size = 13, family = "Arial"),
        hoverinfo = "skip",
        showlegend = FALSE,
        inherit = FALSE
      ) %>%
      plotly::layout(
        barmode = "overlay",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        margin = list(l = 155, r = 65, t = 20, b = 25),
        bargap = 0.38,
        xaxis = list(
          visible = FALSE,
          range = c(0, 115),
          fixedrange = TRUE,
          zeroline = FALSE,
          showgrid = FALSE
        ),
        yaxis = list(
          title = "",
          tickfont = list(color = "#333333", size = 12, family = "Arial"),
          categoryorder = "array",
          categoryarray = rev(ordem),
          automargin = TRUE,
          fixedrange = TRUE,
          showgrid = FALSE,
          zeroline = FALSE
        ),
        font = list(color = "#333333", family = "Arial"),
        hoverlabel = list(
          bgcolor = "#ffffff",
          bordercolor = "#9442d4",
          font = list(color = "#333333", size = 12)
        )
      ) %>%
      plotly::config(displayModeBar = FALSE, responsive = TRUE)
  })
  
  
  # ============================================================
  # 9. GRÁFICO 2 — PRÁTICAS APLICADAS
  # ============================================================
  
  output$grafico_praticas_genero <- plotly::renderPlotly({
    
    df <- dados_abertos_genero()
    
    total <- dplyr::n_distinct(df$ID_Participante)
    
    shiny::validate(
      shiny::need(total > 0, "Não existem respostas abertas para os filtros.")
    )
    
    texto <- df$texto_norm
    
    padrao_casa <- paste(
      "familia", "casa", "marido", "esposo", "parceiro",
      "companheiro", "filhos", "criancas", "tarefas domesticas",
      "trabalho domestico", "dividir.*tarefas", "partilhar.*tarefas",
      "responsabilidades", "cuidar dos filhos",
      sep = "|"
    )
    
    padrao_eu <- paste(
      "confianca", "confiante", "medo", "coragem",
      "acredito em mim", "capaz", "autonomia", "independente",
      "decisoes", "direitos", "opiniao", "voz", "expressar",
      "defender", "autoestima",
      sep = "|"
    )
    
    padrao_negocio <- paste(
      "negocio", "negociar", "preco", "clientes", "vender",
      "vendas", "lucro", "investir", "capital", "poupanca",
      "formalizar", "empreender", "gestao", "custos",
      "rendimentos",
      sep = "|"
    )
    
    padrao_tempo <- paste(
      "tempo", "conciliar", "horario", "rotina", "equilibrar",
      "planeamento", "planear", "organizar.*dia", "gestao do tempo",
      sep = "|"
    )
    
    dados_praticas <- tibble::tibble(
      Esfera = c("Casa e família", "Eu", "Negócio", "Tempo"),
      Descricao = c(
        "Tarefas domésticas e responsabilidades familiares",
        "Autoconfiança, autonomia e direitos",
        "Negociação, preços e gestão do negócio",
        "Organização do tempo e conciliação"
      ),
      N = c(
        sum(grepl(padrao_casa, texto, perl = TRUE)),
        sum(grepl(padrao_eu, texto, perl = TRUE)),
        sum(grepl(padrao_negocio, texto, perl = TRUE)),
        sum(grepl(padrao_tempo, texto, perl = TRUE))
      ),
      Cor = c("#6A1B9A", "#7E3FB2", "#A56BCB", "#D8C4E8")
    ) %>%
      dplyr::mutate(
        Percentagem = N / total * 100,
        Rotulo = paste0(N, " de ", total),
        Tooltip = paste0(
          Esfera, "<br>", Descricao,
          "<br>Participantes: ", N,
          "<br>Total com resposta aberta: ", total,
          "<br>Percentagem: ", round(Percentagem, 1), "%"
        ),
        Posicao = pmin(N + 0.7, total + 1),
        Esfera = factor(
          Esfera,
          levels = rev(c("Casa e família", "Eu", "Negócio", "Tempo"))
        )
      )
    
    plotly::plot_ly() %>%
      plotly::add_bars(
        data = dados_praticas,
        x = rep(total, nrow(dados_praticas)),
        y = ~Esfera,
        orientation = "h",
        marker = list(color = "#e9e3ed", line = list(width = 0)),
        width = 0.48,
        hoverinfo = "skip",
        showlegend = FALSE
      ) %>%
      plotly::add_bars(
        data = dados_praticas,
        x = ~N,
        y = ~Esfera,
        orientation = "h",
        marker = list(color = ~Cor, line = list(width = 0)),
        width = 0.48,
        hoverinfo = "text",
        hovertext = ~Tooltip,
        showlegend = FALSE
      ) %>%
      plotly::add_trace(
        data = dados_praticas,
        x = ~Posicao,
        y = ~Esfera,
        type = "scatter",
        mode = "text",
        text = ~Rotulo,
        textposition = "middle right",
        textfont = list(color = "#333333", size = 12, family = "Arial"),
        hoverinfo = "skip",
        showlegend = FALSE,
        inherit = FALSE
      ) %>%
      plotly::layout(
        barmode = "overlay",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        margin = list(l = 110, r = 75, t = 20, b = 25),
        bargap = 0.38,
        xaxis = list(
          visible = FALSE,
          range = c(0, max(total + 5, 10)),
          fixedrange = TRUE,
          zeroline = FALSE,
          showgrid = FALSE
        ),
        yaxis = list(
          title = "",
          tickfont = list(color = "#333333", size = 12, family = "Arial"),
          categoryorder = "array",
          categoryarray = rev(c("Casa e família", "Eu", "Negócio", "Tempo")),
          automargin = TRUE,
          fixedrange = TRUE,
          showgrid = FALSE,
          zeroline = FALSE
        ),
        font = list(color = "#333333", family = "Arial"),
        hoverlabel = list(
          bgcolor = "#ffffff",
          bordercolor = "#9442d4",
          font = list(color = "#333333", size = 12)
        )
      ) %>%
      plotly::config(displayModeBar = FALSE, responsive = TRUE)
  })
  
  
  # ============================================================
  # 10. FUNÇÃO PARA CARTÕES KPI
  # ============================================================
  
  criar_kpi_genero <- function(
    valor, titulo, detalhe, icone, cor_classe
  ) {
    
    shiny::div(
      class = paste("value-box", cor_classe),
      shiny::div(
        class = "kpi-icon",
        style = "font-size:30px;",
        shiny::icon(icone)
      ),
      shiny::div(
        class = "kpi-value",
        style = "font-size:30px;font-weight:500;line-height:1.2;",
        valor
      ),
      shiny::div(
        class = "kpi-title",
        style = "font-size:15px;",
        titulo
      ),
      shiny::div(
        class = "kpi-detail",
        style = "font-size:13px;",
        detalhe
      )
    )
  }
  
  
  # ============================================================
  # 11. KPI — AVALIAÇÃO POSITIVA
  # ============================================================
  
  output$box_avaliacao_positiva <- shiny::renderUI({
    
    ind <- indicadores_genero()
    
    valor <- if (is.na(ind$pct_positivas)) {
      "Sem dados"
    } else {
      paste0(
        format(round(ind$pct_positivas, 1), nsmall = 1,
               decimal.mark = ","),
        "%"
      )
    }
    
    criar_kpi_genero(
      valor,
      "Avaliação positiva",
      paste0(
        ind$positivas, " de ", ind$respostas_fechadas,
        " respostas · Bastante + Moderadamente"
      ),
      "check-circle",
      "blue"
    )
  })
  
  
  # ============================================================
  # 12. KPI — AJUDARAM BASTANTE
  # ============================================================
  
  output$box_praticas <- shiny::renderUI({
    
    ind <- indicadores_genero()
    
    valor <- if (is.na(ind$pct_bastante)) {
      "Sem dados"
    } else {
      paste0(
        format(round(ind$pct_bastante, 1), nsmall = 1,
               decimal.mark = ","),
        "%"
      )
    }
    
    criar_kpi_genero(
      valor,
      "Ajudaram bastante",
      paste0(
        ind$bastante, " de ", ind$respostas_fechadas,
        " respostas válidas"
      ),
      "lightbulb",
      "green"
    )
  })
  
  
  # ============================================================
  # 13. KPI — DESCREVEM UMA PRÁTICA NOVA
  # Mantém o ID output$box_casa da aplicação existente
  # ============================================================
  
  output$box_casa <- shiny::renderUI({
    
    boxes <- resumo_boxes_praticas_genero()
    ind <- boxes[boxes$Indicador == "pratica_nova", ]
    
    n <- ind$N[1]
    total <- ind$Total[1]
    pct <- ind$Percentagem[1]
    
    valor <- if (is.na(pct)) {
      "Sem dados"
    } else {
      paste0(
        format(round(pct, 1), nsmall = 1, decimal.mark = ","),
        "%"
      )
    }
    
    criar_kpi_genero(
      valor,
      "Descrevem uma prática nova",
      paste0(
        n, " participantes com menções detectadas de ",
        total, " com resposta aberta"
      ),
      "check-square",
      "orange"
    )
  })
  
  
  # ============================================================
  # 14. KPI — FAMÍLIA E TAREFAS DOMÉSTICAS
  # Mantém o ID output$box_autoconfianca existente
  # ============================================================
  
  output$box_autoconfianca <- shiny::renderUI({
    
    boxes <- resumo_boxes_praticas_genero()
    ind <- boxes[boxes$Indicador == "familia_tarefas", ]
    
    n <- ind$N[1]
    total <- ind$Total[1]
    pct <- ind$Percentagem[1]
    
    valor <- if (is.na(pct)) {
      "Sem dados"
    } else {
      paste0(
        format(round(pct, 1), nsmall = 1, decimal.mark = ","),
        "%"
      )
    }
    
    criar_kpi_genero(
      valor,
      "Família e tarefas domésticas",
      paste0(
        n, " participantes com menções detectadas de ",
        total, " com resposta aberta"
      ),
      "home",
      "purple"
    )
  })
  
  
  # ============================================================
  # 15. DEPOIMENTOS — CARTÕES POR TEMA
  # ============================================================
  
  output$depoimentos_genero <- shiny::renderUI({
    
    dados <- dados_depoimentos_genero()
    
    tema <- input$filtro_tema_qualitativo
    
    if (is.null(tema) || length(tema) == 0) {
      tema <- "Todos"
    }
    
    if (tema[1] != "Todos") {
      dados <- dados %>%
        dplyr::filter(Tema == tema[1])
    }
    
    if (nrow(dados) == 0) {
      return(
        shiny::div(
          style = paste(
            "background:#f5f3f4;padding:20px;",
            "border-radius:8px;color:#666666;"
          ),
          "Não existem depoimentos para os filtros seleccionados."
        )
      )
    }
    
    cores_temas <- c(
      "Trabalho doméstico" = "#8054A2",
      "Poder interior" = "#946AB0",
      "Negociar e fixar preços" = "#B49AC8",
      "Relações de poder" = "#9442D4",
      "Estereótipos ocupacionais" = "#F77333",
      "Tensões" = "#42A5F5",
      "Tempo" = "#5E3370",
      "Tema não classificado" = "#999999"
    )
    
    shiny::tagList(
      shiny::div(
        style = "margin-bottom:15px;color:#444444;",
        shiny::tags$strong(
          paste(
            nrow(dados),
            if (nrow(dados) == 1) {
              "depoimento encontrado"
            } else {
              "depoimentos encontrados"
            }
          )
        )
      ),
      
      shiny::fluidRow(
        lapply(seq_len(nrow(dados)), function(i) {
          
          registo <- dados[i, ]
          
          tema_atual <- as.character(registo$Tema)
          cor_tema <- unname(cores_temas[tema_atual])
          
          if (length(cor_tema) == 0 || is.na(cor_tema)) {
            cor_tema <- "#999999"
          }
          
          shiny::column(
            width = 6,
            
            shiny::div(
              style = paste0(
                "background:#ffffff;",
                "border-left:5px solid ", cor_tema, ";",
                "border-radius:8px;padding:16px;",
                "margin-bottom:16px;",
                "box-shadow:0 2px 6px rgba(0,0,0,0.06);"
              ),
              
              shiny::tags$span(
                style = paste0(
                  "display:inline-block;color:", cor_tema, ";",
                  "font-size:12px;font-weight:600;",
                  "margin-bottom:10px;"
                ),
                tema_atual
              ),
              
              shiny::tags$blockquote(
                style = paste(
                  "border-left:0;padding:0;margin:0 0 14px 0;",
                  "font-size:14px;line-height:1.6;",
                  "color:#333333;font-style:italic;",
                  "white-space:pre-wrap;overflow-wrap:anywhere;"
                ),
                as.character(registo$Depoimento)
              ),
              
              shiny::div(
                style = paste(
                  "border-top:1px solid #eeeeee;",
                  "padding-top:8px;font-size:11px;color:#777777;"
                ),
                shiny::icon("user"),
                shiny::span(
                  style = "margin-left:5px;",
                  paste("ID:", as.character(registo$ID_Participante))
                )
              )
            )
          )
        })
      )
    )
  })
  
  
  # ============================================================
  # FIM DA SECÇÃO DE AVALIAÇÃO DE GÉNERO
  # ============================================================
  
  # ##########################     CONSCIENCIA AMBIENTAL ######################
  # 
  # # ####################Pontuacões##############
  
  
  # ============================================================
  # GRÁFICO: PONTUAÇÃO DA PEGADA DE CARBONO — NAMPULA
  # ============================================================
  
  output$graficoPontuacaoNampula <- renderPlotly({
    
    # DADOS BASE
    df <- Pegada_Carbono
    
    # FILTRO CIDADE
    df <- df %>%
      filter(Cidade == "Nampula")
    
    # FILTRO ANO
    if (!is.null(input$ano_pegada) &&
        input$ano_pegada != "Todos") {
      
      df <- df %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    # FILTRO CICLO
    if (!is.null(input$ciclo_pegada) &&
        input$ciclo_pegada != "Todos") {
      
      df <- df %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    req(nrow(df) > 0)
    
    # RESUMO DOS DADOS
    dados_contagem <- df %>%
      filter(
        !is.na(Status_Pegada),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Status_Pegada
      ) %>%
      summarise(
        num_participantes = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          num_participantes / sum(num_participantes) * 100,
          1
        ),
        label = paste0(
          num_participantes,
          " (",
          Percentagem,
          "%)"
        )
      ) %>%
      ungroup()
    
    # ORDEM DAS CATEGORIAS
    dados_contagem$Status_Pegada <- factor(
      dados_contagem$Status_Pegada,
      levels = c(
        "PEGADA BAIXA",
        "PEGADA MÉDIA",
        "PEGADA ALTA"
      )
    )
    
    # CORES
    cores_pegada <- c(
      "PEGADA BAIXA" = "#8054A2",
      "PEGADA MÉDIA" = "#f39c12",
      "PEGADA ALTA"  = "#F77333"
    )
    
    # GRÁFICO
    p <- ggplot(
      dados_contagem,
      aes(
        x = Status_Pegada,
        y = num_participantes,
        fill = Status_Pegada,
        text = paste0(
          "<b>Cidade:</b> Nampula",
          "<br><b>Status:</b> ", Status_Pegada,
          "<br><b>Participantes:</b> ", num_participantes,
          "<br><b>Percentagem:</b> ", Percentagem, "%",
          "<br><b>Avaliação:</b> ", Tipo_Avaliacao
        )
      )
    ) +
      geom_col(width = 0.65) +
      geom_text(
        aes(label = label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      facet_wrap(~ Tipo_Avaliacao) +
      scale_fill_manual(
        values = cores_pegada,
        drop = FALSE
      ) +
      labs(
        title = "Pegada de Carbono — Nampula",
        x = NULL,
        y = "Número de Participantes"
      ) +
      theme_minimal(base_size = 12) +
      theme(
        legend.position = "none",
        panel.grid = element_blank(),
        
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        strip.text = element_text(
          size = 13,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 11,
          face = "bold"
        ),
        
        axis.text.y = element_text(size = 11),
        
        panel.border = element_rect(
          color = "black",
          fill = NA,
          linewidth = 0.4
        ),
        
        panel.spacing = unit(1, "lines")
      )
    
    # CONVERTER PARA PLOTLY E RODAR AS CATEGORIAS DO EIXO X
    ggplotly(
      p,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        xaxis = list(
          tickangle = -45,
          automargin = TRUE
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 60,
          b = 110
        )
      )
  })
  
  
  # ============================================================
  # GRÁFICO: PONTUAÇÃO DA PEGADA DE CARBONO — BEIRA
  # ============================================================
  
  output$graficoPontuacaoBeira <- renderPlotly({
    
    # DADOS BASE
    df <- Pegada_Carbono
    
    # FILTRO CIDADE
    df <- df %>%
      filter(Cidade == "Beira")
    
    # FILTRO ANO
    if (!is.null(input$ano_pegada) &&
        input$ano_pegada != "Todos") {
      
      df <- df %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    # FILTRO CICLO
    if (!is.null(input$ciclo_pegada) &&
        input$ciclo_pegada != "Todos") {
      
      df <- df %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    req(nrow(df) > 0)
    
    # RESUMO DOS DADOS
    dados_contagem <- df %>%
      filter(
        !is.na(Status_Pegada),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Status_Pegada
      ) %>%
      summarise(
        num_participantes = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          num_participantes / sum(num_participantes) * 100,
          1
        ),
        label = paste0(
          num_participantes,
          " (",
          Percentagem,
          "%)"
        )
      ) %>%
      ungroup()
    
    # ORDEM DAS CATEGORIAS
    dados_contagem$Status_Pegada <- factor(
      dados_contagem$Status_Pegada,
      levels = c(
        "PEGADA BAIXA",
        "PEGADA MÉDIA",
        "PEGADA ALTA"
      )
    )
    
    # CORES
    cores_pegada <- c(
      "PEGADA BAIXA" = "#8054A2",
      "PEGADA MÉDIA" = "#f39c12",
      "PEGADA ALTA"  = "#F77333"
    )
    
    # GRÁFICO
    p <- ggplot(
      dados_contagem,
      aes(
        x = Status_Pegada,
        y = num_participantes,
        fill = Status_Pegada,
        text = paste0(
          "<b>Cidade:</b> Beira",
          "<br><b>Status:</b> ", Status_Pegada,
          "<br><b>Participantes:</b> ", num_participantes,
          "<br><b>Percentagem:</b> ", Percentagem, "%",
          "<br><b>Avaliação:</b> ", Tipo_Avaliacao
        )
      )
    ) +
      geom_col(width = 0.65) +
      geom_text(
        aes(label = label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      facet_wrap(~ Tipo_Avaliacao) +
      scale_fill_manual(
        values = cores_pegada,
        drop = FALSE
      ) +
      labs(
        title = "Pegada de Carbono — Beira",
        x = NULL,
        y = "Número de Participantes"
      ) +
      theme_minimal(base_size = 12) +
      theme(
        legend.position = "none",
        panel.grid = element_blank(),
        
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        strip.text = element_text(
          size = 13,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 11,
          face = "bold"
        ),
        
        axis.text.y = element_text(size = 11),
        
        panel.border = element_rect(
          color = "black",
          fill = NA,
          linewidth = 0.4
        ),
        
        panel.spacing = unit(1, "lines")
      )
    
    # CONVERTER PARA PLOTLY E RODAR AS CATEGORIAS DO EIXO X
    ggplotly(
      p,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        xaxis = list(
          tickangle = -45,
          automargin = TRUE
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 60,
          b = 110
        )
      )
  })
  
  # ============================================================
  # FUNÇÃO - GRÁFICO 100% EMPILHADO
  # ============================================================
  
  gerar_grafico_ambiental <- function(
    df,
    variavel,
    ordem_categorias,
    cores,
    nome_download
  ) {
    
    req(
      "Tipo_Avaliacao" %in% names(df),
      variavel %in% names(df)
    )
    
    # ----------------------------------------------------------
    # Filtrar Baseline e Endline
    # ----------------------------------------------------------
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[variavel]]),
        .data[[variavel]] != ""
      )
    
    if (nrow(df) == 0) {
      return(plotly_empty())
    }
    
    # ----------------------------------------------------------
    # Frequência
    # ----------------------------------------------------------
    
    freq_data <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[variavel]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        pct = n / sum(n) * 100
      ) %>%
      ungroup()
    
    # ----------------------------------------------------------
    # Garantir todas as categorias
    # ----------------------------------------------------------
    
    freq_data <- freq_data %>%
      tidyr::complete(
        Tipo_Avaliacao = c("Baseline", "Endline"),
        categoria = ordem_categorias,
        fill = list(
          n = 0,
          pct = 0
        )
      )
    
    # ----------------------------------------------------------
    # Ordem das categorias
    # ----------------------------------------------------------
    
    freq_data <- freq_data %>%
      mutate(
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c("Baseline", "Endline")
        ),
        categoria = factor(
          categoria,
          levels = ordem_categorias
        ),
        label = ifelse(
          pct > 0,
          paste0(
            n,
            " (",
            format(
              round(pct, 1),
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          ""
        )
      )
    
    # ----------------------------------------------------------
    # Gráfico
    # ----------------------------------------------------------
    
    plot_ly(
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~categoria,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      
      texttemplate = "%{text}",
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#FFFFFF",
        size = 11
      ),
      
      customdata = ~n,
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Participantes: %{customdata}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = c(
            "Baseline",
            "Endline"
          ),
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          tickmode = "array",
          tickvals = seq(0, 100, 20),
          ticktext = paste0(
            seq(0, 100, 20),
            "%"
          )
        ),
        
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.28
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 150
        ),
        
        paper_bgcolor = "#f5f3f4",
        
        plot_bgcolor = "#f5f3f4"
      ) %>%
      
      config(
        displayModeBar = TRUE,
        displaylogo = FALSE,
        responsive = TRUE,
        
        toImageButtonOptions = list(
          format = "png",
          filename = nome_download,
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  }
  
  output$grafico_conhecimento_ambiental <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # Filtros
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    ordem_ambiental <- c(
      "Básico — já ouvi falar, mas não sei muito",
      "Bom — estou ciente dos problemas",
      "Muito bom — compreendo bem e tento manter-me informada"
    )
    
    cores_ambiental <- c(
      "Básico — já ouvi falar, mas não sei muito" = "#69C7BE",
      "Bom — estou ciente dos problemas" = "#f9a825",
      "Muito bom — compreendo bem e tento manter-me informada" = "#8054A2"
    )
    
    gerar_grafico_ambiental(
      df = df,
      variavel = "Nível_de_conhecimento_ambiental",
      ordem_categorias = ordem_ambiental,
      cores = cores_ambiental,
      nome_download = "nivel_conhecimento_ambiental"
    )
  })
  
  output$texto_conhecimento_ambiental <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Nível_de_conhecimento_ambiental"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        resposta = categoria,
        perc_baseline = perc
      )
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        resposta = categoria,
        perc_endline = perc
      )
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "resposta"
    ) %>%
      mutate(
        perc_baseline = replace_na(perc_baseline, 0),
        perc_endline = replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$resposta[i]
        
        base <- round(
          comparacao$perc_baseline[i],
          1
        )
        
        end <- round(
          comparacao$perc_endline[i],
          1
        )
        
        variacao <- round(
          comparacao$variacao[i],
          1
        )
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Como classificaria o seu nível de conhecimento sobre questões ambientais em geral? (poluição, catástrofes naturais, falta de recursos, impacto de actividades...). "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução do nível de conhecimento ambiental das empreendedoras. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  output$grafico_impacto_ambiental_negocio <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    ordem_impacto <- c(
      "Não conheço a relação entre a minha actividade e o impacto ambiental",
      "Basicamente, sei que o que faço pode poluir ou ter impacto",
      "Bom — estou ciente disso e tento reduzi-lo",
      "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental"
    )
    
    cores_impacto <- c(
      "Não conheço a relação entre a minha actividade e o impacto ambiental" = "#69C7BE",
      "Basicamente, sei que o que faço pode poluir ou ter impacto" = "#f9a825",
      "Bom — estou ciente disso e tento reduzi-lo" = "#F37238",
      "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental" = "#8054A2"
    )
    
    gerar_grafico_ambiental(
      df = df,
      variavel = "Em que medida tem consciência do impacto ambiental do seu negócio?",
      ordem_categorias = ordem_impacto,
      cores = cores_impacto,
      nome_download = "consciencia_impacto_ambiental_negocio"
    )
  })
  
  output$texto_impacto_ambiental <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Em que medida tem consciência do impacto ambiental do seu negócio?"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup() %>%
      mutate(
        categoria = if_else(
          grepl(
            "Bom|Muito bom",
            categoria,
            ignore.case = TRUE
          ),
          "Bom ou Muito bom",
          categoria
        )
      ) %>%
      group_by(
        Tipo_Avaliacao,
        categoria
      ) %>%
      summarise(
        perc = sum(perc),
        .groups = "drop"
      )
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        resposta = categoria,
        perc_baseline = perc
      )
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        resposta = categoria,
        perc_endline = perc
      )
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "resposta"
    ) %>%
      mutate(
        perc_baseline = replace_na(perc_baseline, 0),
        perc_endline = replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$resposta[i]
        base <- round(comparacao$perc_baseline[i], 1)
        end <- round(comparacao$perc_endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Em que medida tem consciência do impacto ambiental do seu negócio?. "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução da consciência das participantes sobre o impacto ambiental das suas actividades económicas. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  output$grafico_praticas_sustentaveis <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    ordem_praticas <- c(
      "Não, não consigo identificar nenhuma prática sustentável para o meu negócio",
      "Sim"
    )
    
    cores_praticas <- c(
      "Não, não consigo identificar nenhuma prática sustentável para o meu negócio" = "#69C7BE",
      "Sim" = "#8054A2"
    )
    
    gerar_grafico_ambiental(
      df = df,
      variavel = "Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?",
      ordem_categorias = ordem_praticas,
      cores = cores_praticas,
      nome_download = "identificacao_praticas_sustentaveis"
    )
  })
  
  output$texto_praticas_sustentaveis <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    baseline <- resumo %>%
      filter(Tipo_Avaliacao == "Baseline") %>%
      select(
        resposta = categoria,
        perc_baseline = perc
      )
    
    endline <- resumo %>%
      filter(Tipo_Avaliacao == "Endline") %>%
      select(
        resposta = categoria,
        perc_endline = perc
      )
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "resposta"
    ) %>%
      mutate(
        perc_baseline = replace_na(perc_baseline, 0),
        perc_endline = replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$resposta[i]
        base <- round(comparacao$perc_baseline[i], 1)
        end <- round(comparacao$perc_endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio? "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução da capacidade dos participantes de identificar práticas sustentáveis aplicáveis aos seus negócios. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  output$grafico_aplica_praticas <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    ordem_aplicacao <- c(
      "Ainda não, mas planejo aplicar em breve",
      "Já tentei mas encontrei obstáculos",
      "Sim, já aplico"
    )
    
    cores_aplicacao <- c(
      "Ainda não, mas planejo aplicar em breve" = "#69C7BE",
      "Já tentei mas encontrei obstáculos" = "#f9a825",
      "Sim, já aplico" = "#8054A2"
    )
    
    gerar_grafico_ambiental(
      df = df,
      variavel = "Já aplica esta prática no seu negócio?",
      ordem_categorias = ordem_aplicacao,
      cores = cores_aplicacao,
      nome_download = "aplicacao_praticas_sustentaveis"
    )
  })
  
  output$texto_aplica_praticas <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    var <- "Já aplica esta prática no seu negócio?"
    
    req(var %in% names(df))
    
    df <- df %>%
      filter(
        Tipo_Avaliacao %in% c("Baseline", "Endline"),
        !is.na(Tipo_Avaliacao),
        !is.na(.data[[var]]),
        .data[[var]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        tags$p(
          style = "margin:0;text-align:justify;",
          "Não existem dados disponíveis para apresentar esta análise."
        )
      )
    }
    
    resumo <- df %>%
      group_by(
        Tipo_Avaliacao,
        categoria = .data[[var]]
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        perc = n / sum(n) * 100
      ) %>%
      ungroup()
    
    baseline <- resumo %>%
      filter(
        Tipo_Avaliacao == "Baseline",
        categoria %in% c(
          "Sim, já aplico",
          "Ainda não, mas planejo aplicar em breve"
        )
      ) %>%
      select(
        resposta = categoria,
        perc_baseline = perc
      )
    
    endline <- resumo %>%
      filter(
        Tipo_Avaliacao == "Endline",
        categoria %in% c(
          "Sim, já aplico",
          "Ainda não, mas planejo aplicar em breve"
        )
      ) %>%
      select(
        resposta = categoria,
        perc_endline = perc
      )
    
    comparacao <- full_join(
      baseline,
      endline,
      by = "resposta"
    ) %>%
      mutate(
        perc_baseline = replace_na(perc_baseline, 0),
        perc_endline = replace_na(perc_endline, 0),
        variacao = perc_endline - perc_baseline
      )
    
    texto_categorias <- lapply(
      seq_len(nrow(comparacao)),
      function(i) {
        
        categoria <- comparacao$resposta[i]
        base <- round(comparacao$perc_baseline[i], 1)
        end <- round(comparacao$perc_endline[i], 1)
        variacao <- round(comparacao$variacao[i], 1)
        
        if (variacao > 0) {
          
          paste0(
            categoria,
            " aumentou de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (+",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else if (variacao < 0) {
          
          paste0(
            categoria,
            " reduziu de ",
            format(base, decimal.mark = ",", nsmall = 1),
            "% no Baseline para ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% no Endline (",
            format(variacao, decimal.mark = ",", nsmall = 1),
            " p.p.)"
          )
          
        } else {
          
          paste0(
            categoria,
            " manteve-se em ",
            format(end, decimal.mark = ",", nsmall = 1),
            "% entre o Baseline e o Endline"
          )
        }
      }
    )
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Já aplica esta prática no seu negócio? "
      ),
      
      "A comparação entre o Baseline e o Endline permite observar a evolução na aplicação de práticas sustentáveis nos negócios. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
  
################## EXERCICIOS RESULTADOS
  
  # ============================================================
  # DADOS – EXERCÍCIO 1
  # Reconheceu a relação de poder como problema
  # Filtros: Cidade, Ciclo e Tipo de Avaliação
  # ============================================================
  
  dados_exercicio_1 <- reactive({
    
    # Base original
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTRO: CIDADE
    # ----------------------------------------------------------
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) > 0 &&
        !input$filtro_cidade %in% c("Todas", "Todos", "Todas as cidades", "")) {
      
      df <- df %>%
        filter(
          as.character(Cidade) == as.character(input$filtro_cidade)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: CICLO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) > 0 &&
        !input$filtro_ciclo %in% c("Todos", "Todas", "Todos os ciclos", "")) {
      
      df <- df %>%
        filter(
          as.character(Ciclo) == as.character(input$filtro_ciclo)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: TIPO DE AVALIAÇÃO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) > 0 &&
        !input$filtro_tipo_avaliacao %in% c("Todas", "Todos", "Ambas", "Ambos", "")) {
      
      df <- df %>%
        filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    # ----------------------------------------------------------
    # CÁLCULO DAS FREQUÊNCIAS E PERCENTAGENS
    # ----------------------------------------------------------
    df %>%
      filter(
        !is.na(`Reconheceu a relação de poder como problema`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `Reconheceu a relação de poder como problema`,
        name = "n"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        ),
        Etiqueta = paste0(
          n,
          " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 1
  # ============================================================
  
  output$grafico_resultado_poder <- renderPlotly({
    
    df <- dados_exercicio_1()
    
    # Ordem das categorias
    ordem <- c(
      "Não",
      "Parcialmente",
      "Sim"
    )
    
    df$`Reconheceu a relação de poder como problema` <- factor(
      df$`Reconheceu a relação de poder como problema`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Reconheceu a relação de poder como problema`,
        text = paste0(
          "Avaliação: ", Tipo_Avaliacao,
          "<br>Resposta: ",
          `Reconheceu a relação de poder como problema`,
          "<br>Número de respostas: ", n,
          "<br>Percentagem: ", Percentagem, "%"
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = Etiqueta
        ),
        position = position_stack(
          vjust = 0.5
        ),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      scale_fill_manual(
        values = c(
          "Não" = "#69C7BE",
          "Parcialmente" = "#f9a825",
          "Sim" = "#8054A2"
        ),
        drop = FALSE
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  
  # ============================================================
  # Texto de interpretação
  # ============================================================
  
  output$texto_resultado_poder <- renderUI({
    
    texto <- dados_exercicio_1() %>%
      select(
        Tipo_Avaliacao,
        Resposta = `Reconheceu a relação de poder como problema`,
        Percentagem
      ) %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = Resposta,
        values_from = Percentagem,
        values_fill = list(Percentagem = 0)
      )
    
    baseline <- texto %>% filter(Tipo_Avaliacao == "Baseline")
    endline  <- texto %>% filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Reconheceu a relação de poder como problema:</b> ",
        "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes reconheceram a relação de poder como um problema, ",
        "<b>", baseline$Parcialmente, "%</b> reconheceram parcialmente esta situação e ",
        "<b>", baseline$Não, "%</b> não a identificaram como problemática. ",
        "No <b>Endline</b>, <b>", endline$Sim, "%</b> reconheceram a relação de poder como um problema, ",
        "<b>", endline$Parcialmente, "%</b> reconheceram parcialmente esta situação e ",
        "<b>", endline$Não, "%</b> não a identificaram como problemática."
      )
    )
    
  })
  
  

  # ============================================================
  # EXERCÍCIO 2 — IDENTIFICOU O IMPACTO NO NEGÓCIO
  # Base de dados: Pam_Verde_Indicadores
  # Filtros: Cidade, Ciclo e Tipo de Avaliação
  # ============================================================
  
  
  # ============================================================
  # 1. PREPARAR OS DADOS
  # ============================================================
  
  dados_exercicio_2 <- reactive({
    
    # Utilizar directamente a base de dados
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTRO: CIDADE
    # ----------------------------------------------------------
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) > 0 &&
        !input$filtro_cidade %in% c(
          "Todas", "Todos", "Todas as cidades", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Cidade) ==
            as.character(input$filtro_cidade)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: CICLO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) > 0 &&
        !input$filtro_ciclo %in% c(
          "Todos", "Todas", "Todos os ciclos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Ciclo) ==
            as.character(input$filtro_ciclo)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: TIPO DE AVALIAÇÃO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) > 0 &&
        !input$filtro_tipo_avaliacao %in% c(
          "Todas", "Todos", "Ambas", "Ambos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    # ----------------------------------------------------------
    # CONTAGEM E CÁLCULO DAS PERCENTAGENS
    # ----------------------------------------------------------
    df %>%
      dplyr::filter(
        !is.na(`Identificou o impacto no negócio`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::count(
        Tipo_Avaliacao,
        `Identificou o impacto no negócio`,
        name = "n"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(100 * n / sum(n), 1),
        
        Etiqueta = paste0(
          n,
          " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        ),
        
        Texto_hover = paste0(
          "Avaliação: ", as.character(Tipo_Avaliacao),
          "<br>Resposta: ",
          as.character(`Identificou o impacto no negócio`),
          "<br>Número de respostas: ", as.character(n),
          "<br>Percentagem: ", as.character(Percentagem), "%"
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Texto_hover = as.character(Texto_hover),
        Etiqueta = as.character(Etiqueta)
      )
    
  })
  
  
  # ============================================================
  # 2. GRÁFICO — EXERCÍCIO 2
  # ============================================================
  
  output$grafico_resultado_exercicio_2 <- plotly::renderPlotly({
    
    df <- dados_exercicio_2()
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para os filtros seleccionados."
      )
    )
    
    # Garantir os tipos de dados esperados pelo gráfico
    df$Tipo_Avaliacao <- as.character(df$Tipo_Avaliacao)
    df$`Identificou o impacto no negócio` <-
      as.character(df$`Identificou o impacto no negócio`)
    df$Texto_hover <- as.character(df$Texto_hover)
    df$Etiqueta <- as.character(df$Etiqueta)
    
    g <- ggplot2::ggplot(
      df,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Identificou o impacto no negócio`,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(
        width = 0.65
      ) +
      
      ggplot2::geom_text(
        ggplot2::aes(label = Etiqueta),
        position = ggplot2::position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      ggplot2::scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      ggplot2::scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank()
      )
    
    # Converter para Plotly usando o texto previamente preparado
    p <- plotly::ggplotly(
      g,
      tooltip = "text"
    )
    
    p %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
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
  
  
  # ============================================================
  # 3. TEXTO INTERPRETATIVO — EXERCÍCIO 2
  # ============================================================
  
  output$texto_resultado_exercicio_2 <- shiny::renderUI({
    
    df <- dados_exercicio_2()
    
    if (nrow(df) == 0) {
      return(
        shiny::HTML(
          "Não existem dados para os filtros seleccionados."
        )
      )
    }
    
    texto <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        Resposta = `Identificou o impacto no negócio`,
        Percentagem
      ) %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = Resposta,
        values_from = Percentagem,
        values_fill = list(Percentagem = 0)
      )
    
    # Garantir que as categorias ausentes não provocam erros
    categorias <- c("Sim", "Parcialmente", "Não")
    
    for (categoria in categorias) {
      if (!categoria %in% names(texto)) {
        texto[[categoria]] <- 0
      }
    }
    
    obter_valor <- function(dados, coluna) {
      
      if (nrow(dados) == 0 || !coluna %in% names(dados)) {
        return(0)
      }
      
      valor <- dados[[coluna]][1]
      
      if (is.na(valor)) {
        return(0)
      }
      
      as.numeric(valor)
    }
    
    baseline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Endline")
    
    b_sim <- obter_valor(baseline, "Sim")
    b_parcial <- obter_valor(baseline, "Parcialmente")
    b_nao <- obter_valor(baseline, "Não")
    
    e_sim <- obter_valor(endline, "Sim")
    e_parcial <- obter_valor(endline, "Parcialmente")
    e_nao <- obter_valor(endline, "Não")
    
    shiny::HTML(
      paste0(
        "<b>Identificou o impacto no negócio:</b> ",
        
        "No <b>Baseline</b>, <b>", b_sim,
        "%</b> identificaram o impacto no negócio, ",
        "<b>", b_parcial,
        "%</b> reconheceram parcialmente esse impacto e ",
        "<b>", b_nao,
        "%</b> não identificaram o impacto no negócio. ",
        
        "No <b>Endline</b>, <b>", e_sim,
        "%</b> identificaram o impacto no negócio, ",
        "<b>", e_parcial,
        "%</b> reconheceram parcialmente esse impacto e ",
        "<b>", e_nao,
        "%</b> não identificaram o impacto no negócio."
      )
    )
    
  })
  
  

  # ============================================================
  # EXERCÍCIO 3 — ESTRATÉGIA DE RESPOSTA PARA A JOANA
  # Base: Pam_Verde_Indicadores
  # Filtros: Cidade, Ciclo e Tipo de Avaliação
  # ============================================================
  
  
  # ============================================================
  # 1. PREPARAR OS DADOS
  # ============================================================
  
  dados_exercicio_3 <- reactive({
    
    # Utilizar directamente a base de dados
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTRO: CIDADE
    # ----------------------------------------------------------
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) > 0 &&
        !input$filtro_cidade %in% c(
          "Todas", "Todos", "Todas as cidades", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Cidade) ==
            as.character(input$filtro_cidade)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: CICLO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) > 0 &&
        !input$filtro_ciclo %in% c(
          "Todos", "Todas", "Todos os ciclos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Ciclo) ==
            as.character(input$filtro_ciclo)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: TIPO DE AVALIAÇÃO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) > 0 &&
        !input$filtro_tipo_avaliacao %in% c(
          "Todas", "Todos", "Ambas", "Ambos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    # ----------------------------------------------------------
    # CONTAGEM E CÁLCULO DAS PERCENTAGENS
    # ----------------------------------------------------------
    df %>%
      dplyr::filter(
        !is.na(`Sugeriu uma estratégia de resposta para a Joana`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::count(
        Tipo_Avaliacao,
        `Sugeriu uma estratégia de resposta para a Joana`,
        name = "n"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(100 * n / sum(n), 1),
        
        Etiqueta = paste0(
          n,
          " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        ),
        
        Texto_hover = paste0(
          "Avaliação: ", as.character(Tipo_Avaliacao),
          "<br>Resposta: ",
          as.character(
            `Sugeriu uma estratégia de resposta para a Joana`
          ),
          "<br>Número de respostas: ", as.character(n),
          "<br>Percentagem: ", as.character(Percentagem), "%"
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Texto_hover = as.character(Texto_hover),
        Etiqueta = as.character(Etiqueta)
      )
    
  })
  
  
  # ============================================================
  # 2. GRÁFICO — EXERCÍCIO 3
  # ============================================================
  
  output$grafico_resultado_sugerir <- plotly::renderPlotly({
    
    df <- dados_exercicio_3()
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para os filtros seleccionados."
      )
    )
    
    # Garantir que os campos de texto são character
    df$Tipo_Avaliacao <- as.character(df$Tipo_Avaliacao)
    
    df$`Sugeriu uma estratégia de resposta para a Joana` <-
      as.character(
        df$`Sugeriu uma estratégia de resposta para a Joana`
      )
    
    df$Texto_hover <- as.character(df$Texto_hover)
    df$Etiqueta <- as.character(df$Etiqueta)
    
    g <- ggplot2::ggplot(
      df,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Sugeriu uma estratégia de resposta para a Joana`,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(
        width = 0.65
      ) +
      
      ggplot2::geom_text(
        ggplot2::aes(label = Etiqueta),
        position = ggplot2::position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      ggplot2::scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      ggplot2::scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank()
      )
    
    # Converter para Plotly com texto de tooltip preparado
    p <- plotly::ggplotly(
      g,
      tooltip = "text"
    )
    
    p %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
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
  

  # ============================================================
  # 3. TEXTO INTERPRETATIVO — EXERCÍCIO 3
  # ============================================================

  output$texto_resultado_sugerir <- shiny::renderUI({

    df <- dados_exercicio_3()

    if (nrow(df) == 0) {
      return(
        shiny::HTML(
          "Não existem dados para os filtros seleccionados."
        )
      )
    }

    texto <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        Resposta = `Sugeriu uma estratégia de resposta para a Joana`,
        Percentagem
      ) %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = Resposta,
        values_from = Percentagem,
        values_fill = list(Percentagem = 0)
      )

    # Garantir que as três categorias existem
    categorias <- c("Sim", "Parcialmente", "Não")

    for (categoria in categorias) {
      if (!categoria %in% names(texto)) {
        texto[[categoria]] <- 0
      }
    }

    obter_valor <- function(dados, coluna) {

      if (nrow(dados) == 0 || !coluna %in% names(dados)) {
        return(0)
      }

      valor <- dados[[coluna]][1]

      if (is.na(valor)) {
        return(0)
      }

      as.numeric(valor)
    }

    baseline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Baseline")

    endline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Endline")

    b_sim <- obter_valor(baseline, "Sim")
    b_parcial <- obter_valor(baseline, "Parcialmente")
    b_nao <- obter_valor(baseline, "Não")

    e_sim <- obter_valor(endline, "Sim")
    e_parcial <- obter_valor(endline, "Parcialmente")
    e_nao <- obter_valor(endline, "Não")

    shiny::HTML(
      paste0(
        "<b>Sugeriu uma estratégia de resposta para a Joana:</b> ",

        "No <b>Baseline</b>, <b>", b_sim,
        "%</b> sugeriram uma estratégia de resposta para a Joana, ",
        "<b>", b_parcial,
        "%</b> apresentaram uma sugestão parcial e ",
        "<b>", b_nao,
        "%</b> não sugeriram nenhuma estratégia. ",

        "No <b>Endline</b>, <b>", e_sim,
        "%</b> sugeriram uma estratégia de resposta, ",
        "<b>", e_parcial,
        "%</b> apresentaram uma sugestão parcial e ",
        "<b>", e_nao,
        "%</b> não sugeriram nenhuma estratégia."
      )
    )

  })

  
  # ============================================================
  # GRÁFICO 1 — INDICOU QUE PASSA POR SITUAÇÕES SEMELHANTES
  # Base: Pam_Verde_Indicadores
  # ============================================================
  
  dados_resultado_semelhante <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    # Filtro Cidade
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) > 0 &&
        !input$filtro_cidade %in% c(
          "Todas", "Todos", "Todas as cidades", ""
        )) {
      df <- df %>%
        dplyr::filter(
          as.character(Cidade) ==
            as.character(input$filtro_cidade)
        )
    }
    
    # Filtro Ciclo
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) > 0 &&
        !input$filtro_ciclo %in% c(
          "Todos", "Todas", "Todos os ciclos", ""
        )) {
      df <- df %>%
        dplyr::filter(
          as.character(Ciclo) ==
            as.character(input$filtro_ciclo)
        )
    }
    
    # Filtro Tipo de Avaliação
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) > 0 &&
        !input$filtro_tipo_avaliacao %in% c(
          "Todas", "Todos", "Ambas", "Ambos", ""
        )) {
      df <- df %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    # Contagem e percentagens
    df %>%
      dplyr::filter(
        !is.na(`Indicou que passa por situações semelhantes`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::count(
        Tipo_Avaliacao,
        `Indicou que passa por situações semelhantes`,
        name = "n"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(100 * n / sum(n), 1),
        
        Etiqueta = paste0(
          n, " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        ),
        
        Texto_hover = paste0(
          "Avaliação: ", as.character(Tipo_Avaliacao),
          "<br>Resposta: ",
          as.character(
            `Indicou que passa por situações semelhantes`
          ),
          "<br>Número de respostas: ", n,
          "<br>Percentagem: ", Percentagem, "%"
        )
      ) %>%
      dplyr::ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO
  # ============================================================
  
  output$grafico_resultado_semelhante <- plotly::renderPlotly({
    
    df <- dados_resultado_semelhante()
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para os filtros seleccionados."
      )
    )
    
    df$Texto_hover <- as.character(df$Texto_hover)
    df$Etiqueta <- as.character(df$Etiqueta)
    
    g <- ggplot2::ggplot(
      df,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Indicou que passa por situações semelhantes`,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(width = 0.65) +
      
      ggplot2::geom_text(
        ggplot2::aes(label = Etiqueta),
        position = ggplot2::position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      ggplot2::scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      ggplot2::scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(mult = c(0, 0.02))
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank()
      )
    
    plotly::ggplotly(g, tooltip = "text") %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
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
          l = 60, r = 20, t = 20, b = 120
        ),
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # TEXTO INTERPRETATIVO
  # ============================================================
  
  output$texto_resultado_semelhante <- shiny::renderUI({
    
    df <- dados_resultado_semelhante()
    
    if (nrow(df) == 0) {
      return(shiny::HTML(
        "Não existem dados para os filtros seleccionados."
      ))
    }
    
    resumo <- df %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::summarise(
        Sim = sum(Percentagem[
          `Indicou que passa por situações semelhantes` == "Sim"
        ], na.rm = TRUE),
        
        Parcialmente = sum(Percentagem[
          `Indicou que passa por situações semelhantes` == "Parcialmente"
        ], na.rm = TRUE),
        
        Não = sum(Percentagem[
          `Indicou que passa por situações semelhantes` == "Não"
        ], na.rm = TRUE),
        
        .groups = "drop"
      )
    
    obter <- function(tipo, categoria) {
      linha <- resumo[resumo$Tipo_Avaliacao == tipo, , drop = FALSE]
      
      if (nrow(linha) == 0) return(NA_real_)
      
      as.numeric(linha[[categoria]][1])
    }
    
    formatar <- function(x) {
      if (is.na(x)) return("sem dados")
      paste0(format(round(x, 1), decimal.mark = ",", nsmall = 1), "%")
    }
    
    b_sim <- obter("Baseline", "Sim")
    b_parcial <- obter("Baseline", "Parcialmente")
    b_nao <- obter("Baseline", "Não")
    
    e_sim <- obter("Endline", "Sim")
    e_parcial <- obter("Endline", "Parcialmente")
    e_nao <- obter("Endline", "Não")
    
    shiny::HTML(paste0(
      "<b>Indicou que passa por situações semelhantes:</b> ",
      "No <b>Baseline</b>, ", formatar(b_sim),
      " responderam Sim, ", formatar(b_parcial),
      " responderam Parcialmente e ", formatar(b_nao),
      " responderam Não. ",
      "No <b>Endline</b>, ", formatar(e_sim),
      " responderam Sim, ", formatar(e_parcial),
      " responderam Parcialmente e ", formatar(e_nao),
      " responderam Não."
    ))
  })
  
 
  
  # ============================================================
  # GRÁFICO 2 — TEM ESTRATÉGIA PARA REDUZIR O IMPACTO
  # NO SEU NEGÓCIO
  # Base: Pam_Verde_Indicadores
  # ============================================================
  
  
  # ============================================================
  # 1. PREPARAR OS DADOS
  # ============================================================
  
  dados_resultado_impacto <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    # ----------------------------------------------------------
    # FILTRO: CIDADE
    # ----------------------------------------------------------
    if (!is.null(input$filtro_cidade) &&
        length(input$filtro_cidade) > 0 &&
        !input$filtro_cidade %in% c(
          "Todas", "Todos", "Todas as cidades", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Cidade) ==
            as.character(input$filtro_cidade)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: CICLO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_ciclo) &&
        length(input$filtro_ciclo) > 0 &&
        !input$filtro_ciclo %in% c(
          "Todos", "Todas", "Todos os ciclos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Ciclo) ==
            as.character(input$filtro_ciclo)
        )
    }
    
    # ----------------------------------------------------------
    # FILTRO: TIPO DE AVALIAÇÃO
    # ----------------------------------------------------------
    if (!is.null(input$filtro_tipo_avaliacao) &&
        length(input$filtro_tipo_avaliacao) > 0 &&
        !input$filtro_tipo_avaliacao %in% c(
          "Todas", "Todos", "Ambas", "Ambos", ""
        )) {
      
      df <- df %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    # ----------------------------------------------------------
    # CONTAGEM E PERCENTAGENS
    # ----------------------------------------------------------
    df %>%
      dplyr::filter(
        !is.na(`Tem estratégia para reduzir o impacto no seu negócio`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::count(
        Tipo_Avaliacao,
        `Tem estratégia para reduzir o impacto no seu negócio`,
        name = "n"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(100 * n / sum(n), 1),
        
        Etiqueta = paste0(
          n, " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        ),
        
        Texto_hover = paste0(
          "Avaliação: ", as.character(Tipo_Avaliacao),
          "<br>Resposta: ",
          as.character(
            `Tem estratégia para reduzir o impacto no seu negócio`
          ),
          "<br>Número de respostas: ", n,
          "<br>Percentagem: ", Percentagem, "%"
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Texto_hover = as.character(Texto_hover),
        Etiqueta = as.character(Etiqueta)
      )
    
  })
  
  
  # ============================================================
  # 2. GRÁFICO — IMPACTO NO NEGÓCIO
  # ============================================================
  
  output$grafico_resultado_impacto <- plotly::renderPlotly({
    
    df <- dados_resultado_impacto()
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para os filtros seleccionados."
      )
    )
    
    g <- ggplot2::ggplot(
      df,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Tem estratégia para reduzir o impacto no seu negócio`,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(
        width = 0.65
      ) +
      
      ggplot2::geom_text(
        ggplot2::aes(label = Etiqueta),
        position = ggplot2::position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      ggplot2::scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      ggplot2::scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank()
      )
    
    plotly::ggplotly(
      g,
      tooltip = "text"
    ) %>%
      
      plotly::layout(
        title = "",
        barmode = "stack",
        
        uniformtext = list(
          mode = "show",
          minsize = 10
        ),
        
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
  
  
  # ============================================================
  # 3. TEXTO INTERPRETATIVO — IMPACTO NO NEGÓCIO
  # ============================================================
  
  output$texto_resultado_impacto <- shiny::renderUI({
    
    df <- dados_resultado_impacto()
    
    if (nrow(df) == 0) {
      return(
        shiny::HTML(
          "Não existem dados para os filtros seleccionados."
        )
      )
    }
    
    resumo <- df %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::summarise(
        Sim = sum(
          Percentagem[
            `Tem estratégia para reduzir o impacto no seu negócio` == "Sim"
          ],
          na.rm = TRUE
        ),
        
        Parcialmente = sum(
          Percentagem[
            `Tem estratégia para reduzir o impacto no seu negócio` == "Parcialmente"
          ],
          na.rm = TRUE
        ),
        
        Não = sum(
          Percentagem[
            `Tem estratégia para reduzir o impacto no seu negócio` == "Não"
          ],
          na.rm = TRUE
        ),
        
        .groups = "drop"
      )
    
    obter <- function(tipo, categoria) {
      
      linha <- resumo[
        resumo$Tipo_Avaliacao == tipo,
        ,
        drop = FALSE
      ]
      
      if (nrow(linha) == 0) {
        return(NA_real_)
      }
      
      as.numeric(linha[[categoria]][1])
    }
    
    formatar <- function(x) {
      
      if (is.na(x)) {
        return("sem dados")
      }
      
      paste0(
        format(
          round(x, 1),
          decimal.mark = ",",
          nsmall = 1
        ),
        "%"
      )
    }
    
    b_sim <- obter("Baseline", "Sim")
    b_parcial <- obter("Baseline", "Parcialmente")
    b_nao <- obter("Baseline", "Não")
    
    e_sim <- obter("Endline", "Sim")
    e_parcial <- obter("Endline", "Parcialmente")
    e_nao <- obter("Endline", "Não")
    
    shiny::HTML(
      paste0(
        "<b>Tem estratégia para reduzir o impacto no seu negócio:</b> ",
        
        "No <b>Baseline</b>, ",
        formatar(b_sim),
        " tinham uma estratégia, ",
        formatar(b_parcial),
        " tinham uma estratégia parcial e ",
        formatar(b_nao),
        " não tinham uma estratégia. ",
        
        "No <b>Endline</b>, ",
        formatar(e_sim),
        " tinham uma estratégia, ",
        formatar(e_parcial),
        " tinham uma estratégia parcial e ",
        formatar(e_nao),
        " não tinham uma estratégia."
      )
    )
    
  })
  
  
  
  # ============================================================
  # EXERCÍCIOS 5 A 8 — PAM VERDE
  # Valores absolutos + percentagens
  # Filtros: Cidade, Ciclo e Tipo de Avaliação
  # ============================================================
  
  
  # ============================================================
  # 1. CONFIGURAÇÃO DAS CATEGORIAS E CORES
  # ============================================================
  
  ordem_exercicios <- c(
    "0.Ausente ou fora do tema",
    "1.Vago ou parcial",
    "2.Demonstra claramente"
  )
  
  cores_exercicios <- c(
    "0.Ausente ou fora do tema" = "#69C7BE",
    "1.Vago ou parcial" = "#f9a825",
    "2.Demonstra claramente" = "#8054A2"
  )
  
  
  # ============================================================
  # 2. FUNÇÃO AUXILIAR — APLICAR FILTROS
  # ============================================================
  
  aplicar_filtros_exercicios <- function(base) {
    
    df <- base
    
    # FILTRO CIDADE
    if (
      !is.null(input$filtro_cidade) &&
      length(input$filtro_cidade) == 1 &&
      !is.na(input$filtro_cidade) &&
      input$filtro_cidade != "" &&
      !input$filtro_cidade %in% c(
        "Todas",
        "Todas as cidades",
        "Todos",
        "Todas as cidades"
      )
    ) {
      df <- df %>%
        dplyr::filter(
          as.character(Cidade) == as.character(input$filtro_cidade)
        )
    }
    
    # FILTRO CICLO
    if (
      !is.null(input$filtro_ciclo) &&
      length(input$filtro_ciclo) == 1 &&
      !is.na(input$filtro_ciclo) &&
      input$filtro_ciclo != "" &&
      !input$filtro_ciclo %in% c(
        "Todos",
        "Todos os ciclos",
        "Todas",
        "Todos os ciclos"
      )
    ) {
      df <- df %>%
        dplyr::filter(
          as.character(Ciclo) == as.character(input$filtro_ciclo)
        )
    }
    
    # FILTRO TIPO DE AVALIAÇÃO
    if (
      !is.null(input$filtro_tipo_avaliacao) &&
      length(input$filtro_tipo_avaliacao) == 1 &&
      !is.na(input$filtro_tipo_avaliacao) &&
      input$filtro_tipo_avaliacao != "" &&
      !input$filtro_tipo_avaliacao %in% c(
        "Todas",
        "Ambas",
        "Ambos",
        "Todos",
        "Todas as avaliações"
      )
    ) {
      df <- df %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) ==
            as.character(input$filtro_tipo_avaliacao)
        )
    }
    
    df
  }
  
  
  # ============================================================
  # 3. FUNÇÃO AUXILIAR — PREPARAR DADOS
  # ============================================================
  
  preparar_exercicio <- function(base, variavel) {
    
    df <- aplicar_filtros_exercicios(base)
    
    df %>%
      dplyr::filter(
        !is.na(.data[[variavel]]),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::mutate(
        Categoria = as.character(.data[[variavel]])
      ) %>%
      dplyr::count(
        Tipo_Avaliacao,
        Categoria,
        name = "n"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(n),
        Percentagem = round(
          n / Total * 100,
          1
        ),
        Etiqueta = paste0(
          n,
          " (",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%)"
        ),
        Texto_hover = paste0(
          "Avaliação: ",
          as.character(Tipo_Avaliacao),
          "<br>Categoria: ",
          as.character(Categoria),
          "<br>Valor absoluto: ",
          n,
          "<br>Percentagem: ",
          format(
            Percentagem,
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%",
          "<br>Total da avaliação: ",
          Total
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Categoria = factor(
          Categoria,
          levels = ordem_exercicios
        ),
        Texto_hover = as.character(Texto_hover)
      )
  }
  
  
  # ============================================================
  # 4. FUNÇÃO AUXILIAR — CRIAR GRÁFICOS
  # ============================================================
  
  grafico_exercicio <- function(df) {
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para os filtros seleccionados."
      )
    )
    
    g <- ggplot2::ggplot(
      df,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = Categoria,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(
        width = 0.65
      ) +
      
      # VALOR ABSOLUTO + PERCENTAGEM
      ggplot2::geom_text(
        ggplot2::aes(
          label = Etiqueta
        ),
        position = ggplot2::position_stack(
          vjust = 0.5
        ),
        colour = "black",
        fontface = "bold",
        size = 3.5
      ) +
      
      ggplot2::scale_fill_manual(
        values = cores_exercicios,
        breaks = ordem_exercicios,
        drop = FALSE
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      ggplot2::scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank(),
        axis.text = ggplot2::element_text(
          colour = "black"
        )
      )
    
    plotly::ggplotly(
      g,
      tooltip = "text"
    ) %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  }
  
  
  # ============================================================
  # 5. FUNÇÃO AUXILIAR — TEXTO COM VALORES E PERCENTAGENS
  # ============================================================
  
  texto_exercicio <- function(df, pergunta, descricao) {
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0,
        "Não existem dados para apresentar."
      )
    )
    
    resumo <- df %>%
      dplyr::mutate(
        Categoria = as.character(Categoria)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        Categoria
      ) %>%
      dplyr::summarise(
        n = sum(n),
        Percentagem = sum(Percentagem),
        .groups = "drop"
      )
    
    obter <- function(avaliacao, categoria, campo) {
      
      resultado <- resumo %>%
        dplyr::filter(
          as.character(Tipo_Avaliacao) == avaliacao,
          Categoria == categoria
        )
      
      if (nrow(resultado) == 0) {
        return(
          if (campo == "n") "0" else "0,0"
        )
      }
      
      if (campo == "n") {
        return(as.character(resultado$n[1]))
      }
      
      format(
        resultado$Percentagem[1],
        decimal.mark = ",",
        nsmall = 1,
        trim = TRUE
      )
    }
    
    formatar <- function(avaliacao, categoria) {
      
      paste0(
        obter(avaliacao, categoria, "n"),
        " participantes (",
        obter(avaliacao, categoria, "percentagem"),
        "%)"
      )
    }
    
    # A função obter espera o campo Percentagem
    formatar <- function(avaliacao, categoria) {
      
      paste0(
        obter(avaliacao, categoria, "n"),
        " participantes (",
        obter(avaliacao, categoria, "Percentagem"),
        "%)"
      )
    }
    
    HTML(
      paste0(
        "<b>", pergunta, "</b><br><br>",
        
        "<b>Baseline:</b> ",
        formatar(
          "Baseline",
          ordem_exercicios[3]
        ),
        " demonstraram claramente ",
        descricao,
        "; ",
        formatar(
          "Baseline",
          ordem_exercicios[2]
        ),
        " apresentaram respostas vagas ou parciais; e ",
        formatar(
          "Baseline",
          ordem_exercicios[1]
        ),
        " apresentaram respostas ausentes ou fora do tema.",
        
        "<br><br><b>Endline:</b> ",
        formatar(
          "Endline",
          ordem_exercicios[3]
        ),
        " demonstraram claramente ",
        descricao,
        "; ",
        formatar(
          "Endline",
          ordem_exercicios[2]
        ),
        " apresentaram respostas vagas ou parciais; e ",
        formatar(
          "Endline",
          ordem_exercicios[1]
        ),
        " apresentaram respostas ausentes ou fora do tema."
      )
    )
  }
  
  
  # ============================================================
  # EXERCÍCIO 5 — A1: CÁLCULO DE LUCRO
  # ============================================================
  
  dados_exercicio_5 <- shiny::reactive({
    
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "A1 — Cálculo de lucro"
    )
  })
  
  output$grafico_resultado_lucro <- plotly::renderPlotly({
    
    grafico_exercicio(
      dados_exercicio_5()
    )
  })
  
  output$texto_resultado_lucro <- shiny::renderUI({
    
    texto_exercicio(
      dados_exercicio_5(),
      paste0(
        "Imagine que no mês passado o seu negócio teve: ",
        "Receita total = 10.000 MZN; custo dos produtos vendidos = ",
        "4.000 MZN; custos operacionais = 2.500 MZN. Quanto foi o lucro?"
      ),
      "a capacidade de calcular o lucro"
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 6 — A2: META DE VENDAS
  # ============================================================
  
  dados_exercicio_6 <- shiny::reactive({
    
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "A2 — Meta de vendas"
    )
  })
  
  output$grafico_resultado_vendas <- plotly::renderPlotly({
    
    grafico_exercicio(
      dados_exercicio_6()
    )
  })
  
  output$texto_resultado_vendas <- shiny::renderUI({
    
    texto_exercicio(
      dados_exercicio_6(),
      paste0(
        "Imagine que faz em média 20 produtos por semana e cada um ",
        "custa 150 MZN. Qual seria uma meta de vendas razoável ",
        "para si num mês normal de 4 semanas?"
      ),
      "a capacidade de definir uma meta de vendas"
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 7 — A3: PREPARAÇÃO PARA PICO
  # ============================================================
  
  dados_exercicio_7 <- shiny::reactive({
    
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "A3 — Preparação para pico"
    )
  })
  
  output$grafico_resultado_pico <- plotly::renderPlotly({
    
    grafico_exercicio(
      dados_exercicio_7()
    )
  })
  
  output$texto_resultado_pico <- shiny::renderUI({
    
    texto_exercicio(
      dados_exercicio_7(),
      paste0(
        "No seu negócio, há dias ou períodos em que costuma vender ",
        "mais? O que poderia fazer antes desse período para se preparar?"
      ),
      "a capacidade de preparação para períodos de maior movimento"
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 8 — A4: ACOMPANHAMENTO
  # ============================================================
  
  dados_exercicio_8 <- shiny::reactive({
    
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "A4 — Acompanhamento"
    )
  })
  
  output$grafico_resultado_acompanhamento <- plotly::renderPlotly({
    
    grafico_exercicio(
      dados_exercicio_8()
    )
  })
  
  output$texto_resultado_acompanhamento <- shiny::renderUI({
    
    texto_exercicio(
      dados_exercicio_8(),
      paste0(
        "Como pode acompanhar as suas vendas semanalmente para saber ",
        "se está a atingir a meta? Descreva uma forma simples."
      ),
      "uma forma de acompanhar as vendas"
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 9 — CLIENTE INSATISFEITO
  # Variável: B1 — Cliente insatisfeito
  # ============================================================
  
  dados_cliente_insatisfeito <- reactive({
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "B1 — Cliente insatisfeito"
    )
  })
  
  output$grafico_resultado_insatisfeito <- renderPlotly({
    grafico_exercicio(dados_cliente_insatisfeito())
  })
  
  output$texto_resultado_insatisfeito <- renderUI({
    texto_exercicio(
      dados_cliente_insatisfeito(),
      "Pense num cliente do seu negócio que ficou insatisfeito — por exemplo, porque houve atraso, problema com o produto/serviço ou falha no atendimento. O que faria? O que diria?",
      "Avaliação da capacidade de lidar com clientes insatisfeitos."
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 10 — RECOLHA DE FEEDBACK
  # Variável: B2 — Recolha de feedback
  # ============================================================
  
  dados_recolha_feedback <- reactive({
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "B2 — Recolha de feedback"
    )
  })
  
  output$grafico_resultado_feedback <- renderPlotly({
    grafico_exercicio(dados_recolha_feedback())
  })
  
  output$texto_resultado_feedback <- renderUI({
    texto_exercicio(
      dados_recolha_feedback(),
      "Como poderia saber regularmente o que os seus clientes pensam do seu produto ou serviço? Descreva pelo menos uma forma concreta.",
      "Avaliação da capacidade de recolher feedback dos clientes."
    )
  })
  
  
  # ============================================================
  # EXERCÍCIO 11 — ADAPTAÇÃO
  # Variável: B3 — Adaptação
  # ============================================================
  
  dados_adaptacao <- reactive({
    preparar_exercicio(
      Pam_Verde_Indicadores,
      "B3 — Adaptação"
    )
  })
  
  output$grafico_resultado_adaptacao <- renderPlotly({
    grafico_exercicio(dados_adaptacao())
  })
  
  output$texto_resultado_adaptacao <- renderUI({
    texto_exercicio(
      dados_adaptacao(),
      "Imagine que um cliente lhe pede algo que ainda não oferece, ou uma adaptação no produto/serviço que ainda não faz. O que faria nessa situação?",
      "Avaliação da capacidade de adaptar a resposta às necessidades dos clientes."
    )
  })
  
  
  
  
  
  # ============================================================
  # EXERCÍCIOS 9 A 13 — NEGOCIAÇÃO COM FORNECEDORES
  # Valores absolutos (n) + percentagens (%) nos gráficos,
  # tooltips e textos interpretativos.
  # Filtros: Cidade, Ciclo e Tipo de Avaliação.
  #
  # Substitui os blocos antigos dos exercícios 9 a 13 por este
  # bloco no SERVER do Shiny. Mantém os mesmos IDs de outputs.
  # ============================================================
  

  ordem_resposta <- c("Não", "Sim")
  
  cores_resposta <- c(
    "Sim" = "#8054A2",
    "Não" = "#69C7BE"
  )
  
  exercicios_negociacao <- list(
    exercicio_9 = list(
      variavel = "N1 — Perguntou o motivo do aumento (não aceitou sem questionar)",
      titulo = "Perguntou o motivo do aumento (não aceitou sem questionar)",
      descricao_sim = "perguntaram o motivo do aumento de preço",
      descricao_nao = "não questionaram o aumento"
    ),
    exercicio_10 = list(
      variavel = "N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)",
      titulo = "Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)",
      descricao_sim = "propuseram uma alternativa concreta ao fornecedor",
      descricao_nao = "não apresentaram uma alternativa concreta"
    ),
    exercicio_11 = list(
      variavel = "N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços",
      titulo = "Referiu a possibilidade de procurar outros fornecedores ou comparar preços",
      descricao_sim = "referiram a possibilidade de procurar outros fornecedores ou comparar preços",
      descricao_nao = "não referiram essa possibilidade"
    ),
    exercicio_12 = list(
      variavel = "N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso",
      titulo = "Manteve a sua posição sem ceder imediatamente, com tom respeitoso",
      descricao_sim = "mantiveram a sua posição sem ceder imediatamente, utilizando um tom respeitoso",
      descricao_nao = "não demonstraram este comportamento"
    ),
    exercicio_13 = list(
      variavel = "N5 — Propôs um acordo, solução intermédia ou continuação da negociação",
      titulo = "Propôs um acordo, solução intermédia ou continuação da negociação",
      descricao_sim = "propuseram um acordo, uma solução intermédia ou a continuação da negociação",
      descricao_nao = "não apresentaram este tipo de proposta"
    )
  )
  
  # ------------------------------------------------------------
  # 2. Aplicar os filtros da página
  # ------------------------------------------------------------
  
  aplicar_filtros_negociacao <- function(df) {
    
    # Cidade
    cidade_sel <- input$filtro_cidade
    if (!is.null(cidade_sel) &&
        length(cidade_sel) == 1 &&
        !is.na(cidade_sel) &&
        !cidade_sel %in% c(
          "", "Todas", "Todas as cidades", "Todas as Cidades",
          "Todos", "Todas as localidades"
        ) &&
        "Cidade" %in% names(df)) {
      df <- df %>% filter(as.character(Cidade) == as.character(cidade_sel))
    }
    
    # Ciclo
    ciclo_sel <- input$filtro_ciclo
    if (!is.null(ciclo_sel) &&
        length(ciclo_sel) == 1 &&
        !is.na(ciclo_sel) &&
        !ciclo_sel %in% c(
          "", "Todos", "Todos os ciclos", "Todos os Ciclos",
          "Todas", "Todas as edições"
        ) &&
        "Ciclo" %in% names(df)) {
      df <- df %>% filter(as.character(Ciclo) == as.character(ciclo_sel))
    }
    
    # Tipo de avaliação
    avaliacao_sel <- input$filtro_tipo_avaliacao
    if (!is.null(avaliacao_sel) &&
        length(avaliacao_sel) == 1 &&
        !is.na(avaliacao_sel) &&
        !avaliacao_sel %in% c(
          "", "Todas", "Todas as avaliações", "Todos",
          "Ambas", "Ambos"
        ) &&
        "Tipo_Avaliacao" %in% names(df)) {
      df <- df %>% filter(as.character(Tipo_Avaliacao) == as.character(avaliacao_sel))
    }
    
    df
  }
  
  # ------------------------------------------------------------
  # 3. Preparar os dados: contagem, total e percentagem
  # ------------------------------------------------------------
  
  preparar_dados_negociacao <- function(chave_exercicio) {
    
    definicao <- exercicios_negociacao[[chave_exercicio]]
    variavel <- definicao$variavel
    
    shiny::validate(
      shiny::need(
        variavel %in% names(Pam_Verde_Indicadores),
        paste0("A coluna não foi encontrada na base: ", variavel)
      )
    )
    
    df <- aplicar_filtros_negociacao(Pam_Verde_Indicadores)
    
    df <- df %>%
      mutate(
        Tipo_Avaliacao = as.character(Tipo_Avaliacao),
        Resposta = trimws(as.character(.data[[variavel]]))
      ) %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Resposta),
        Resposta %in% ordem_resposta
      ) %>%
      count(Tipo_Avaliacao, Resposta, name = "n") %>%
      tidyr::complete(
        Tipo_Avaliacao,
        Resposta = ordem_resposta,
        fill = list(n = 0)
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Total = sum(n),
        Percentagem = ifelse(Total > 0, round(n / Total * 100, 1), 0),
        Percentagem_texto = gsub(
          "\\.", ",",
          formatC(Percentagem, format = "f", digits = 1)
        ),
        Etiqueta = ifelse(
          n > 0,
          paste0(n, " (", Percentagem_texto, "%)"),
          ""
        ),
        Texto_hover = paste0(
          "Avaliação: ", Tipo_Avaliacao,
          "<br>Resposta: ", Resposta,
          "<br>Valor absoluto: ", n,
          "<br>Percentagem: ", Percentagem_texto, "%",
          "<br>Total válido na avaliação: ", Total
        )
      ) %>%
      ungroup() %>%
      mutate(
        Resposta = factor(Resposta, levels = ordem_resposta),
        Texto_hover = as.character(Texto_hover)
      )
    
    df
  }
  
  # ------------------------------------------------------------
  # 4. Construir o gráfico com n e percentagem dentro das barras
  # ------------------------------------------------------------
  
  grafico_negociacao <- function(df, titulo_grafico = "") {
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0 && any(df$Total > 0),
        "Não existem respostas válidas para os filtros seleccionados."
      )
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = Resposta,
        text = Texto_hover
      )
    ) +
      geom_col(width = 0.65, na.rm = TRUE) +
      geom_text(
        aes(label = Etiqueta),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.7,
        na.rm = TRUE
      ) +
      scale_fill_manual(
        values = cores_resposta,
        breaks = ordem_resposta,
        drop = FALSE
      ) +
      scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(mult = c(0, 0.02))
      ) +
      labs(
        title = titulo_grafico,
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      theme_stata() +
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank(),
        axis.text = element_text(colour = "black"),
        plot.title = element_text(face = "bold", size = 12)
      )
    
    plotly::ggplotly(g, tooltip = "text") %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(l = 70, r = 30, t = 30, b = 100),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  }
  
  # ------------------------------------------------------------
  # 5. Texto interpretativo com valores absolutos e percentagens
  # ------------------------------------------------------------
  
  texto_negociacao <- function(df, definicao) {
    
    shiny::validate(
      shiny::need(
        nrow(df) > 0 && any(df$Total > 0),
        "Não existem respostas válidas para os filtros seleccionados."
      )
    )
    
    resumos <- df %>%
      mutate(Resposta = as.character(Resposta)) %>%
      select(Tipo_Avaliacao, Resposta, n, Percentagem, Total) %>%
      distinct()
    
    obter_valor <- function(avaliacao, resposta, campo) {
      linha <- resumos %>%
        filter(Tipo_Avaliacao == avaliacao, Resposta == resposta)
      
      if (nrow(linha) == 0 || is.na(linha[[campo]][1])) {
        return(if (campo == "n") "0" else "0,0")
      }
      
      if (campo == "n") {
        return(as.character(linha[[campo]][1]))
      }
      
      gsub(
        "\\.", ",",
        formatC(linha[[campo]][1], format = "f", digits = 1)
      )
    }
    
    avaliacoes <- unique(as.character(df$Tipo_Avaliacao))
    avaliacoes <- avaliacoes[!is.na(avaliacoes)]
    
    blocos <- lapply(avaliacoes, function(avaliacao) {
      total_linha <- resumos %>%
        filter(Tipo_Avaliacao == avaliacao) %>%
        summarise(total = max(Total, na.rm = TRUE)) %>%
        pull(total)
      
      if (length(total_linha) == 0 || !is.finite(total_linha)) {
        total_linha <- 0
      }
      
      sim_n <- obter_valor(avaliacao, "Sim", "n")
      sim_pct <- obter_valor(avaliacao, "Sim", "Percentagem")
      nao_n <- obter_valor(avaliacao, "Não", "n")
      nao_pct <- obter_valor(avaliacao, "Não", "Percentagem")
      
      paste0(
        "<p><b>", htmltools::htmlEscape(avaliacao), "</b> (n válido = ",
        total_linha, "): ",
        "<b>", sim_n, " (", sim_pct, "%)</b> ",
        htmltools::htmlEscape(definicao$descricao_sim), "; ",
        "<b>", nao_n, " (", nao_pct, "%)</b> ",
        htmltools::htmlEscape(definicao$descricao_nao), ".</p>"
      )
    })
    
    htmltools::HTML(
      paste0(
        "<div style='background:#f5f3f4;padding:12px;border-radius:8px;'>",
        "<b>", htmltools::htmlEscape(definicao$titulo), "</b>",
        paste(blocos, collapse = ""),
        "<small>Os valores e as percentagens são recalculados de acordo com os filtros seleccionados.</small>",
        "</div>"
      )
    )
  }
  
  # ------------------------------------------------------------
  # 6. Outputs — Exercícios 9 a 13
  # ------------------------------------------------------------
  
  # EXERCÍCIO 9 — N1
  dados_exercicio_9 <- reactive({
    preparar_dados_negociacao("exercicio_9")
  })
  
  output$grafico_resultado_exercicio_9 <- renderPlotly({
    grafico_negociacao(
      dados_exercicio_9(),
      "Exercício 9 — Perguntou o motivo do aumento"
    )
  })
  
  output$texto_resultado_exercicio_9 <- renderUI({
    texto_negociacao(
      dados_exercicio_9(),
      exercicios_negociacao$exercicio_9
    )
  })
  
  
  # EXERCÍCIO 10 — N2
  dados_exercicio_10 <- reactive({
    preparar_dados_negociacao("exercicio_10")
  })
  
  output$grafico_resultado_exercicio_10 <- renderPlotly({
    grafico_negociacao(
      dados_exercicio_10(),
      "Exercício 10 — Propôs uma alternativa concreta"
    )
  })
  
  output$texto_resultado_exercicio_10 <- renderUI({
    texto_negociacao(
      dados_exercicio_10(),
      exercicios_negociacao$exercicio_10
    )
  })
  
  
  # EXERCÍCIO 11 — N3
  dados_exercicio_11 <- reactive({
    preparar_dados_negociacao("exercicio_11")
  })
  
  output$grafico_resultado_exercicio_11 <- renderPlotly({
    grafico_negociacao(
      dados_exercicio_11(),
      "Exercício 11 — Outros fornecedores ou comparação de preços"
    )
  })
  
  output$texto_resultado_exercicio_11 <- renderUI({
    texto_negociacao(
      dados_exercicio_11(),
      exercicios_negociacao$exercicio_11
    )
  })
  
  
  # EXERCÍCIO 12 — N4
  dados_exercicio_12 <- reactive({
    preparar_dados_negociacao("exercicio_12")
  })
  
  output$grafico_resultado_exercicio_12 <- renderPlotly({
    grafico_negociacao(
      dados_exercicio_12(),
      "Exercício 12 — Manteve a posição com tom respeitoso"
    )
  })
  
  output$texto_resultado_exercicio_12 <- renderUI({
    texto_negociacao(
      dados_exercicio_12(),
      exercicios_negociacao$exercicio_12
    )
  })
  
  
  # EXERCÍCIO 13 — N5
  dados_exercicio_13 <- reactive({
    preparar_dados_negociacao("exercicio_13")
  })
  
  output$grafico_resultado_exercicio_13 <- renderPlotly({
    grafico_negociacao(
      dados_exercicio_13(),
      "Exercício 13 — Propôs um acordo ou solução intermédia"
    )
  })
  
  output$texto_resultado_exercicio_13 <- renderUI({
    texto_negociacao(
      dados_exercicio_13(),
      exercicios_negociacao$exercicio_13
    )
  })
  
  

  # ============================================================
  # DADOS – EXERCÍCIO 14
  # A1 - Problema identificado
  # ============================================================
  
  dados_exercicio_14 <- reactive({
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    Pam_Verde_Indicadores %>%
      dplyr::filter(
        !is.na(`A1  Problema identificado`),
        !is.na(Tipo_Avaliacao),
        Tipo_Avaliacao %in% c("Baseline", "Endline")
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `A1  Problema identificado`
      ) %>%
      dplyr::summarise(
        N = dplyr::n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = round(N / Total * 100, 1)
      ) %>%
      dplyr::ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 14
  # A1 - Problema identificado
  # ============================================================
  
  output$grafico_resultado_exercicio_14 <- renderPlotly({
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df <- dados_exercicio_14()
    
    if (nrow(df) == 0) {
      return(
        plotly::plot_ly() %>%
          plotly::layout(
            title = "Sem dados disponíveis para o Exercício 14",
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    # Completar as categorias para manter a mesma estrutura
    # nas avaliações Baseline e Endline
    df_grafico <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        `A1  Problema identificado`,
        N
      ) %>%
      tidyr::complete(
        Tipo_Avaliacao = c("Baseline", "Endline"),
        `A1  Problema identificado` = ordem,
        fill = list(N = 0)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = dplyr::if_else(
          Total > 0,
          N / Total * 100,
          0
        ),
        Etiqueta = dplyr::if_else(
          N > 0,
          paste0(
            N,
            " (",
            format(
              round(Percentagem, 1),
              decimal.mark = ",",
              nsmall = 1,
              trim = TRUE
            ),
            "%)"
          ),
          ""
        ),
        Texto_hover = paste0(
          "<b>Avaliação:</b> ", Tipo_Avaliacao,
          "<br><b>Categoria:</b> ",
          `A1  Problema identificado`,
          "<br><b>Número de participantes (N):</b> ", N,
          "<br><b>Percentagem:</b> ",
          format(
            round(Percentagem, 1),
            decimal.mark = ",",
            nsmall = 1,
            trim = TRUE
          ),
          "%",
          "<br><b>Total da avaliação:</b> ", Total
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        `A1  Problema identificado` = factor(
          `A1  Problema identificado`,
          levels = ordem
        ),
        Tipo_Avaliacao = factor(
          Tipo_Avaliacao,
          levels = c("Baseline", "Endline")
        )
      )
    
    g <- ggplot2::ggplot(
      df_grafico,
      ggplot2::aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A1  Problema identificado`,
        text = Texto_hover
      )
    ) +
      
      ggplot2::geom_col(
        width = 0.65,
        position = "stack"
      ) +
      
      ggplot2::geom_text(
        ggplot2::aes(label = Etiqueta),
        position = ggplot2::position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.8
      ) +
      
      ggplot2::scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
        ),
        breaks = ordem,
        drop = FALSE
      ) +
      
      ggplot2::scale_x_discrete(
        drop = FALSE
      ) +
      
      ggplot2::scale_y_continuous(
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = ggplot2::expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      ggplot2::coord_cartesian(
        ylim = c(0, 100)
      ) +
      
      ggplot2::labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      theme_stata() +
      
      ggplot2::theme(
        panel.grid.major.x = ggplot2::element_blank(),
        legend.position = "bottom",
        legend.title = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank()
      )
    
    plotly::ggplotly(
      g,
      tooltip = "text"
    ) %>%
      plotly::layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  

  # ============================================================
  # TEXTO – EXERCÍCIO 14
  # A1 - Problema identificado
  # Apenas Endline
  # ============================================================
  
  output$texto_resultado_exercicio_14 <- renderUI({
    
    df <- dados_exercicio_14() %>%
      dplyr::filter(Tipo_Avaliacao == "Endline")
    
    if (nrow(df) == 0) {
      return(
        HTML(
          paste0(
            "<b>Exercício 14:</b> ",
            "Não existem respostas disponíveis no Endline."
          )
        )
      )
    }
    
    obter_valor <- function(categoria) {
      
      resultado <- df %>%
        dplyr::filter(
          `A1  Problema identificado` == categoria
        )
      
      if (nrow(resultado) == 0) {
        return(0)
      }
      
      as.numeric(resultado$Percentagem[1])
    }
    
    formatar_percentagem <- function(valor) {
      format(
        round(valor, 1),
        decimal.mark = ",",
        nsmall = 1,
        trim = TRUE
      )
    }
    
    endline_claro <- obter_valor(
      "2.Demonstra claramente"
    )
    
    endline_vago <- obter_valor(
      "1.Vago ou parcial"
    )
    
    endline_ausente <- obter_valor(
      "0.Ausente ou fora do tema"
    )
    
    HTML(
      paste0(
        "<b>Qual foi o desafio ou problema do seu negócio ",
        "que identificou e decidiu investigar durante a pesquisa HCD?</b><br><br>",
        
        "No <b>Endline</b>, <b>",
        formatar_percentagem(endline_claro),
        "%</b> dos participantes demonstraram claramente ",
        "capacidade de identificar o problema, <b>",
        formatar_percentagem(endline_vago),
        "%</b> apresentaram uma resposta vaga ou parcial e <b>",
        formatar_percentagem(endline_ausente),
        "%</b> apresentaram uma resposta fora do tema."
      )
    )
  })
  
  
  
  # ============================================================
  # DADOS — EXERCÍCIO 15
  # A2 - Fontes entrevistadas/observadas
  # Pergunta aplicada somente no Endline
  # ============================================================
  
  dados_exercicio_15 <- reactive({
    
    Pam_Verde_Indicadores %>%
      dplyr::filter(
        Tipo_Avaliacao == "Endline",
        !is.na(`A2  Fontes entrevistadas/observadas`)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `A2  Fontes entrevistadas/observadas`
      ) %>%
      dplyr::summarise(
        N = dplyr::n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      dplyr::ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 15
  # Valores absolutos (N) + Percentagens (%)
  # Somente Endline
  # ============================================================
  
  output$grafico_resultado_exercicio_15 <- renderPlotly({
    
    coluna_resposta <- "A2  Fontes entrevistadas/observadas"
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    # Obter dados já contabilizados
    df <- dados_exercicio_15() %>%
      dplyr::filter(
        .data[[coluna_resposta]] %in% ordem
      )
    
    if (nrow(df) == 0) {
      return(
        plotly::plotly_empty() %>%
          plotly::layout(
            title = "Não existem respostas disponíveis no Endline"
          )
      )
    }
    
    # Completar categorias sem voltar a contar as linhas
    df_grafico <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        dplyr::all_of(coluna_resposta),
        N
      ) %>%
      tidyr::complete(
        Tipo_Avaliacao,
        !!rlang::sym(coluna_resposta) := ordem,
        fill = list(N = 0)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = dplyr::if_else(
          Total > 0,
          N / Total * 100,
          0
        ),
        Etiqueta = dplyr::if_else(
          N > 0,
          paste0(
            N,
            " (",
            format(
              round(Percentagem, 1),
              decimal.mark = ",",
              nsmall = 1,
              trim = TRUE
            ),
            "%)"
          ),
          ""
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        !!rlang::sym(coluna_resposta) := factor(
          .data[[coluna_resposta]],
          levels = ordem
        )
      )
    
    # Construir gráfico
    g <- ggplot(
      df_grafico,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = .data[[coluna_resposta]],
        text = paste0(
          "Avaliação: ", Tipo_Avaliacao,
          "<br>Categoria: ", .data[[coluna_resposta]],
          "<br>Número de respostas: ", N,
          "<br>Percentagem: ",
          round(Percentagem, 1), "%",
          "<br>Total de respostas: ", Total
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(label = Etiqueta),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.5
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
        ),
        breaks = ordem,
        drop = FALSE
      ) +
      
      scale_y_continuous(
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      coord_cartesian(
        ylim = c(0, 100)
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    # Gráfico interativo
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # TEXTO — EXERCÍCIO 15
  # Somente Endline
  # ============================================================
  
  output$texto_resultado_exercicio_15 <- renderUI({
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    texto <- dados_exercicio_15() %>%
      tidyr::complete(
        Tipo_Avaliacao = "Endline",
        `A2  Fontes entrevistadas/observadas` = ordem,
        fill = list(N = 0, Percentagem = 0)
      ) %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A2  Fontes entrevistadas/observadas`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    if (nrow(dados_exercicio_15()) == 0) {
      return(
        HTML(
          "<b>Exercício 15:</b> Não existem respostas disponíveis no Endline."
        )
      )
    }
    
    obter_valor <- function(categoria) {
      if (!categoria %in% names(texto)) {
        return(0)
      }
      
      as.numeric(texto[[categoria]][1])
    }
    
    p2 <- obter_valor("2.Demonstra claramente")
    p1 <- obter_valor("1.Vago ou parcial")
    p0 <- obter_valor("0.Ausente ou fora do tema")
    
    HTML(
      paste0(
        "<b>Quem são as pessoas que entrevistou ou observou para perceber melhor esse problema? (Ex.: clientes habituais, clientes que deixaram de comprar, fornecedores, concorrentes...)</b><br><br>",
        "No <b>Endline</b>, <b>", p2,
        "%</b> dos participantes demonstraram claramente capacidade de identificar as fontes entrevistadas ou observadas, ",
        "<b>", p1,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>", p0,
        "%</b> apresentaram uma resposta ausente fora do tema."
      )
    )
  })
  

  
  # ============================================================
  # DADOS — EXERCÍCIO 16
  # A3 - Método de recolha utilizado
  # ============================================================
  
  dados_exercicio_16 <- reactive({
    
    Pam_Verde_Indicadores %>%
      dplyr::filter(
        !is.na(
          `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`
        ),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`
      ) %>%
      dplyr::summarise(
        N = dplyr::n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      dplyr::ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 16
  # Valores absolutos (N) + Percentagens (%)
  # ============================================================
  
  output$grafico_resultado_exercicio_16 <- renderPlotly({
    
    coluna_resposta <-
      "A3  Método de recolha utilizado (perguntas, observação ou outros métodos)"
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    # Obter dados já contabilizados
    df <- dados_exercicio_16() %>%
      dplyr::filter(
        .data[[coluna_resposta]] %in% ordem
      )
    
    if (nrow(df) == 0) {
      return(
        plotly::plotly_empty() %>%
          plotly::layout(
            title = "Não existem respostas disponíveis"
          )
      )
    }
    
    # Completar categorias sem voltar a contar as linhas
    df_grafico <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        dplyr::all_of(coluna_resposta),
        N
      ) %>%
      tidyr::complete(
        Tipo_Avaliacao,
        !!rlang::sym(coluna_resposta) := ordem,
        fill = list(N = 0)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = dplyr::if_else(
          Total > 0,
          N / Total * 100,
          0
        ),
        Etiqueta = dplyr::if_else(
          N > 0,
          paste0(
            N,
            " (",
            format(
              round(Percentagem, 1),
              decimal.mark = ",",
              nsmall = 1,
              trim = TRUE
            ),
            "%)"
          ),
          ""
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        !!rlang::sym(coluna_resposta) := factor(
          .data[[coluna_resposta]],
          levels = ordem
        )
      )
    
    # Construir gráfico
    g <- ggplot(
      df_grafico,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = .data[[coluna_resposta]],
        text = paste0(
          "Avaliação: ", Tipo_Avaliacao,
          "<br>Categoria: ", .data[[coluna_resposta]],
          "<br>Número de respostas: ", N,
          "<br>Percentagem: ",
          round(Percentagem, 1), "%",
          "<br>Total de respostas: ", Total
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(label = Etiqueta),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.5
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
        ),
        breaks = ordem,
        drop = FALSE
      ) +
      
      scale_y_continuous(
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      coord_cartesian(
        ylim = c(0, 100)
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    # Gráfico interativo
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        height = 500,
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
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # TEXTO — EXERCÍCIO 16
  # Baseline e Endline
  # ============================================================
  
  output$texto_resultado_exercicio_16 <- renderUI({
    
    texto <- dados_exercicio_16() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    categorias <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    for (categoria in categorias) {
      if (!categoria %in% names(texto)) {
        texto[[categoria]] <- 0
      }
    }
    
    baseline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Endline")
    
    if (nrow(baseline) == 0 && nrow(endline) == 0) {
      return(
        HTML("<b>Exercício 16:</b> Não existem dados disponíveis.")
      )
    }
    
    obter_valor <- function(dados, categoria) {
      if (nrow(dados) == 0) {
        return(0)
      }
      
      as.numeric(dados[[categoria]][1])
    }
    
    b2 <- obter_valor(baseline, "2.Demonstra claramente")
    b1 <- obter_valor(baseline, "1.Vago ou parcial")
    b0 <- obter_valor(baseline, "0.Ausente ou fora do tema")
    
    e2 <- obter_valor(endline, "2.Demonstra claramente")
    e1 <- obter_valor(endline, "1.Vago ou parcial")
    e0 <- obter_valor(endline, "0.Ausente ou fora do tema")
    
    texto_final <- paste0(
      "<b>Que perguntas fez a essas pessoas e que método de recolha de informação utilizou? (Ex.: perguntas directas, observação do comportamento de compra, questionário escrito...)</b><br><br>"
    )
    
    if (nrow(baseline) > 0) {
      texto_final <- paste0(
        texto_final,
        "No <b>Baseline</b>, <b>", b2,
        "%</b> dos participantes demonstraram claramente capacidade de utilizar um método de recolha adequado, enquanto <b>",
        b1,
        "%</b> apresentaram uma resposta vaga ou parcial e <b>",
        b0,
        "%</b> apresentaram uma resposta fora do tema. "
      )
    }
    
    if (nrow(endline) > 0) {
      texto_final <- paste0(
        texto_final,
        "No <b>Endline</b>, <b>", e2,
        "%</b> demonstraram claramente essa capacidade, <b>",
        e1,
        "%</b> apresentaram uma resposta vaga ou parcial e <b>",
        e0,
        "%</b> apresentaram uma resposta fora do tema."
      )
    }
    
    HTML(texto_final)
  })
  
  
  # ============================================================
  # DADOS — EXERCÍCIO 18
  # B1 - Conclusão da análise própria
  # ============================================================
  
  dados_exercicio_18 <- reactive({
    
    Pam_Verde_Indicadores %>%
      dplyr::filter(
        !is.na(`B1  Conclusão da análise própria`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `B1  Conclusão da análise própria`
      ) %>%
      dplyr::summarise(
        N = dplyr::n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      dplyr::ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 18
  # Valores absolutos (N) + Percentagens (%)
  # ============================================================
  
  output$grafico_resultado_exercicio_18 <- renderPlotly({
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    # Obter dados já contabilizados
    df <- dados_exercicio_18() %>%
      dplyr::filter(
        `B1  Conclusão da análise própria` %in% ordem
      )
    
    if (nrow(df) == 0) {
      return(
        plotly::plotly_empty() %>%
          plotly::layout(
            title = "Não existem respostas disponíveis"
          )
      )
    }
    
    # Garantir que todas as categorias aparecem
    df_grafico <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        `B1  Conclusão da análise própria`,
        N
      ) %>%
      tidyr::complete(
        Tipo_Avaliacao,
        `B1  Conclusão da análise própria` = ordem,
        fill = list(N = 0)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = dplyr::if_else(
          Total > 0,
          N / Total * 100,
          0
        ),
        Etiqueta = dplyr::if_else(
          N > 0,
          paste0(
            N,
            " (",
            format(
              round(Percentagem, 1),
              decimal.mark = ",",
              nsmall = 1,
              trim = TRUE
            ),
            "%)"
          ),
          ""
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        `B1  Conclusão da análise própria` = factor(
          `B1  Conclusão da análise própria`,
          levels = ordem
        )
      )
    
    # Construir gráfico
    g <- ggplot(
      df_grafico,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `B1  Conclusão da análise própria`,
        text = paste0(
          "Avaliação: ", Tipo_Avaliacao,
          "<br>Categoria: ", `B1  Conclusão da análise própria`,
          "<br>Número de respostas: ", N,
          "<br>Percentagem: ",
          round(Percentagem, 1), "%",
          "<br>Total de respostas: ", Total
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(label = Etiqueta),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.5
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
        ),
        breaks = ordem,
        drop = FALSE
      ) +
      
      scale_y_continuous(
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(
          mult = c(0, 0.02)
        )
      ) +
      
      coord_cartesian(
        ylim = c(0, 100)
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    # Gráfico interativo
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        height = 500,
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # TEXTO — EXERCÍCIO 18
  # Baseline e Endline
  # ============================================================
  
  output$texto_resultado_exercicio_18 <- renderUI({
    
    texto <- dados_exercicio_18() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `B1  Conclusão da análise própria`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    # Garantir que as colunas existem
    categorias <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    for (categoria in categorias) {
      if (!categoria %in% names(texto)) {
        texto[[categoria]] <- 0
      }
    }
    
    baseline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      dplyr::filter(Tipo_Avaliacao == "Endline")
    
    # Verificar se existem dados
    if (nrow(baseline) == 0 && nrow(endline) == 0) {
      return(
        HTML("<b>Exercício 18:</b> Não existem dados disponíveis.")
      )
    }
    
    # Valores seguros para apresentar
    obter_valor <- function(dados, categoria) {
      if (nrow(dados) == 0) {
        return(0)
      }
      as.numeric(dados[[categoria]][1])
    }
    
    b2 <- obter_valor(baseline, "2.Demonstra claramente")
    b1 <- obter_valor(baseline, "1.Vago ou parcial")
    b0 <- obter_valor(baseline, "0.Ausente ou fora do tema")
    
    e2 <- obter_valor(endline, "2.Demonstra claramente")
    e1 <- obter_valor(endline, "1.Vago ou parcial")
    e0 <- obter_valor(endline, "0.Ausente ou fora do tema")
    
    texto_final <- paste0(
      "<b>Que conclusões tira destas respostas das clientes? O que têm em comum?</b><br><br>"
    )
    
    if (nrow(baseline) > 0) {
      texto_final <- paste0(
        texto_final,
        "No <b>Baseline</b>, <b>", b2,
        "%</b> demonstraram claramente capacidade de concluir a análise própria, ",
        "<b>", b1,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>", b0,
        "%</b> apresentaram uma resposta ausente fora do tema. "
      )
    }
    
    if (nrow(endline) > 0) {
      texto_final <- paste0(
        texto_final,
        "No <b>Endline</b>, <b>", e2,
        "%</b> demonstraram claramente essa capacidade, ",
        "<b>", e1,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>", e0,
        "%</b> apresentaram uma resposta fora do tema."
      )
    }
    
    HTML(texto_final)
  })
  
  
  
  # ============================================================
  # DADOS — EXERCÍCIO 19
  # B2 - Aplicação no negócio
  # ============================================================
  
  dados_exercicio_19 <- reactive({
    
    Pam_Verde_Indicadores %>%
      dplyr::filter(
        !is.na(`B2  Aplicação no negócio`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `B2  Aplicação no negócio`
      ) %>%
      dplyr::summarise(
        N = dplyr::n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      dplyr::ungroup()
    
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 19
  # Apenas Endline
  # Apresenta valores absolutos (N) e percentagens (%)
  # ============================================================
  
  output$grafico_resultado_exercicio_19 <- renderPlotly({
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    # Obter os dados já contabilizados
    df <- dados_exercicio_19() %>%
      dplyr::filter(
        Tipo_Avaliacao == "Endline",
        `B2  Aplicação no negócio` %in% ordem
      )
    
    # Verificar se existem dados
    if (nrow(df) == 0) {
      return(
        plotly::plotly_empty() %>%
          plotly::layout(
            title = "Não existem respostas disponíveis no Endline"
          )
      )
    }
    
    # Completar as três categorias e utilizar a contagem N
    df_grafico <- df %>%
      dplyr::select(
        Tipo_Avaliacao,
        `B2  Aplicação no negócio`,
        N
      ) %>%
      tidyr::complete(
        Tipo_Avaliacao,
        `B2  Aplicação no negócio` = ordem,
        fill = list(N = 0)
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        Total = sum(N),
        Percentagem = dplyr::if_else(
          Total > 0,
          N / Total * 100,
          0
        ),
        Etiqueta = dplyr::if_else(
          N > 0,
          paste0(
            N,
            " (",
            format(
              round(Percentagem, 1),
              decimal.mark = ",",
              nsmall = 1,
              trim = TRUE
            ),
            "%)"
          ),
          ""
        )
      ) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        `B2  Aplicação no negócio` = factor(
          `B2  Aplicação no negócio`,
          levels = ordem
        )
      )
    
    # Construir gráfico
    g <- ggplot(
      df_grafico,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `B2  Aplicação no negócio`,
        text = paste0(
          "Categoria: ", `B2  Aplicação no negócio`,
          "<br>Número de respostas: ", N,
          "<br>Percentagem: ",
          round(Percentagem, 1), "%",
          "<br>Total de respostas: ", Total
        )
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(label = Etiqueta),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 3.5
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
        ),
        breaks = ordem,
        drop = FALSE
      ) +
      
      scale_y_continuous(
        breaks = seq(0, 100, 20),
        labels = function(x) paste0(x, "%"),
        expand = expansion(mult = c(0, 0.02))
      ) +
      
      coord_cartesian(
        ylim = c(0, 100)
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    # Gráfico interativo
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        title = "",
        barmode = "stack",
        height = 500,
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0, 100),
          ticksuffix = "%"
        ),
        legend = list(
          orientation = "h",
          x = 0.5,
          xanchor = "center",
          y = -0.2
        ),
        margin = list(
          l = 70,
          r = 30,
          t = 30,
          b = 140
        ),
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  
  # ============================================================
  # TEXTO — EXERCÍCIO 19
  # LEITURA EXCLUSIVA DO ENDLINE
  # ============================================================
  
  output$texto_resultado_exercicio_19 <- renderUI({
    
    texto <- dados_exercicio_19() %>%
      filter(
        Tipo_Avaliacao == "Endline"
      ) %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `B2  Aplicação no negócio`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    # Verificar se existem dados do Endline
    if (nrow(texto) == 0) {
      return(
        HTML(
          "<b>Exercício 19:</b> Não existem dados disponíveis para o Endline."
        )
      )
    }
    
    # Extrair percentagens com segurança
    demonstrou <- if ("2.Demonstra claramente" %in% names(texto)) {
      texto[["2.Demonstra claramente"]][1]
    } else {
      0
    }
    
    vago <- if ("1.Vago ou parcial" %in% names(texto)) {
      texto[["1.Vago ou parcial"]][1]
    } else {
      0
    }
    
    ausente <- if ("0.Ausente ou fora do tema" %in% names(texto)) {
      texto[["0.Ausente ou fora do tema"]][1]
    } else {
      0
    }
    
    HTML(
      paste0(
        "<b>Como pode usar essas conclusões para melhorar o seu negócio? ",
        "Dê um exemplo concreto.</b><br><br>",
        
        "No <b>Endline</b>, <b>",
        round(demonstrou, 1),
        "%</b> das participantes demonstraram claramente ",
        "capacidade de aplicar a aprendizagem no negócio, ",
        
        "<b>",
        round(vago, 1),
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        round(ausente, 1),
        "%</b> apresentaram uma resposta fora do tema."
      )
    )
  })
  
  
  
  ########################## MONITORIA DAS SESSÕES PAM VERDE
  # ===============================================================
  # DADOS GERAIS
  # ===============================================================
  
  dados_geral <- reactive({
    
    df <- PERFIL_PAM_VERDE_C3_2026
    
    if (input$filtro_monitoria_geral != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Cidade == input$filtro_monitoria_geral
        )
    }
    
    df
  })
  
  
  # ===============================================================
  # GRÁFICO 1
  # SELECIONADAS VS INÍCIO DA FORMAÇÃO
  # ===============================================================
  
  
  output$grafico1 <- renderPlotly({
    
    idioma <- input$idioma %||% "pt"
    
    dados <- dados_geral()
    
    total_selecionadas <- nrow(dados)
    
    total_iniciaram <- dados %>%
      dplyr::filter(
        Status %in% c("Activa", "Desistente")
      ) %>%
      nrow()
    
    # Evitar divisão por zero
    if (total_selecionadas == 0) {
      return(
        plotly::plot_ly() %>%
          plotly::layout(
            annotations = list(
              text = "Sem dados disponíveis",
              x = 0.5,
              y = 0.5,
              showarrow = FALSE
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    grafico_df <- data.frame(
      Categoria = c(
        i18n_tr("Selecionadas", idioma),
        i18n_tr("Iniciaram Formação", idioma)
      ),
      Valor = c(
        total_selecionadas,
        total_iniciaram
      )
    ) %>%
      dplyr::mutate(
        Percentual = Valor / total_selecionadas,
        Label = paste0(
          Valor,
          "\n(",
          scales::percent(Percentual, accuracy = 1),
          ")"
        ),
        Cor = c("#ff7f0e", "#8054A2")
      )
    
    titulo <- i18n_tr(
      "Selecionadas vs Início da Formação",
      idioma
    )
    
    eixo_y <- i18n_tr("Percentagem", idioma)
    
    p <- plotly::plot_ly(
      data = grafico_df,
      x = ~Categoria,
      y = ~Percentual,
      type = "bar",
      marker = list(
        color = grafico_df$Cor
      ),
      text = ~Label,
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(
        color = "white",
        size = 16,
        family = "Arial",
        bold = TRUE
      ),
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "Total: %{customdata[0]}<br>",
        eixo_y, ": %{y:.1%}",
        "<extra></extra>"
      ),
      customdata = matrix(grafico_df$Valor, ncol = 1)
    ) %>%
      plotly::layout(
        title = list(
          text = titulo,
          font = list(size = 18)
        ),
        xaxis = list(
          title = "",
          tickfont = list(size = 13)
        ),
        yaxis = list(
          title = eixo_y,
          tickformat = ".0%",
          range = c(0, 1.05),
          dtick = 0.2
        ),
        showlegend = FALSE,
        bargap = 0.4,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        margin = list(t = 70, b = 70, l = 70, r = 25)
      ) %>%
      plotly::config(
        displaylogo = FALSE,
        responsive = TRUE
      )
    
    p
  })
  
  
  
  output$grafico2 <- renderPlotly({
    
    idioma <- input$idioma %||% "pt"
    
    dados <- dados_geral() %>%
      dplyr::mutate(
        Status = toupper(
          stringr::str_squish(
            trimws(as.character(Status))
          )
        )
      )
    
    dados_iniciaram <- dados %>%
      dplyr::filter(
        Status %in% c(
          "ACTIVA", "ACTIVAS",
          "ATIVA", "ATIVAS",
          "DESISTENTE", "DESISTENTES"
        )
      )
    
    total_concluiu <- dados_iniciaram %>%
      dplyr::filter(
        Status %in% c("ACTIVA", "ACTIVAS", "ATIVA", "ATIVAS")
      ) %>%
      nrow()
    
    total_desistentes <- dados_iniciaram %>%
      dplyr::filter(
        Status %in% c("DESISTENTE", "DESISTENTES")
      ) %>%
      nrow()
    
    total_iniciaram <- total_concluiu + total_desistentes
    
    if (total_iniciaram == 0) {
      return(
        plotly::plot_ly() %>%
          plotly::layout(
            annotations = list(
              text = i18n_tr(
                "Não existem dados de Concluiu a Formação ou Desistentes",
                idioma
              ),
              x = 0.5,
              y = 0.5,
              showarrow = FALSE,
              font = list(size = 15)
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    categorias_pt <- c(
      "Concluiu a Formação",
      "Desistentes"
    )
    
    categorias <- i18n_tr(categorias_pt, idioma)
    
    resumo <- data.frame(
      Categoria = categorias,
      Valor = c(
        total_concluiu,
        total_desistentes
      ),
      Cor = c("#8054A2", "#69C7BE")
    ) %>%
      dplyr::mutate(
        Percentual = Valor / total_iniciaram,
        Label = paste0(
          Valor,
          "\n",
          scales::percent(Percentual, accuracy = 1)
        )
      )
    
    titulo <- i18n_tr(
      "Situação dos Participantes que Iniciaram a Formação",
      idioma
    )
    
    eixo_y <- i18n_tr("Percentagem", idioma)
    texto_total <- i18n_tr("Total", idioma)
    
    p <- plotly::plot_ly(
      data = resumo,
      x = ~Categoria,
      y = ~Percentual,
      type = "bar",
      marker = list(
        color = resumo$Cor
      ),
      text = ~Label,
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(
        color = "white",
        size = 16,
        family = "Arial"
      ),
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        texto_total, ": %{customdata[0]}<br>",
        eixo_y, ": %{y:.1%}",
        "<extra></extra>"
      ),
      customdata = matrix(resumo$Valor, ncol = 1)
    ) %>%
      plotly::layout(
        title = list(
          text = titulo,
          font = list(size = 18)
        ),
        xaxis = list(
          title = "",
          tickfont = list(size = 14)
        ),
        yaxis = list(
          title = eixo_y,
          tickformat = ".0%",
          range = c(0, 1.05),
          dtick = 0.2
        ),
        showlegend = FALSE,
        bargap = 0.35,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        margin = list(t = 75, b = 75, l = 70, r = 25)
      ) %>%
      plotly::config(
        displaylogo = FALSE,
        responsive = TRUE
      )
    
    p
  })
  
  
  
 ################### PRESENCAS NAS SESSÕES
  # ============================================================
  # DADOS FILTRADOS — PRESENÇAS COLECTIVAS
  # ============================================================
  
  dados_filtrados_coletiva <- reactive({
    
    df <- Presencas_Colectivas_Nampula
    
    if (input$filtro_monitoria_presencas != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_monitoria_presencas)
    }
    
    if (input$mentora_coletiva != "Todas") {
      df <- df %>%
        filter(Pesquisadores == input$mentora_coletiva)
    }
    
    df
  })
  
  
  # ============================================================
  # PREPARAÇÃO DOS DADOS PARA O GRÁFICO
  # ============================================================
  
  dados_plot_coletivo <- reactive({
    
    df <- dados_filtrados_coletiva()
    
    previsto <- 43
    
    df <- df %>%
      mutate(
        across(
          starts_with("Sessao_"),
          ~ sapply(., function(x) {
            
            if (is.null(x)) return(NA_character_)
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste0(x, collapse = ", ")
          })
        )
      )
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    df_agg <- df_long %>%
      filter(str_detect(Presenca, "Presente")) %>%
      group_by(Sessoes) %>%
      summarise(
        Count = n(),
        .groups = "drop"
      ) %>%
      mutate(
        Previsto = previsto,
        Percentual = (Count / Previsto) * 100
      ) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = unique(Sessoes)[
            order(
              as.numeric(
                gsub(
                  "Sessao_",
                  "",
                  unique(Sessoes)
                )
              )
            )
          ]
        )
      )
    
    df_agg
  })
  
  
  # ============================================================
  # GRÁFICO — PRESENÇAS POR SESSÃO
  # Letras do eixo X inclinadas em 45 graus
  # ============================================================
  
  output$grafico_sessoes_col <- renderPlotly({
    
    df_agg <- dados_plot_coletivo()
    
    # Verificar se existem dados
    if (nrow(df_agg) == 0) {
      
      return(
        plotly::plot_ly() %>%
          layout(
            title = "Sem dados disponíveis para os filtros seleccionados",
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    previsto <- df_agg$Previsto[1]
    
    limite_y <- max(
      c(df_agg$Count, previsto),
      na.rm = TRUE
    ) + 7
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_col() +
      
      # Linha de referência: total previsto
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        linewidth = 1.2
      ) +
      
      # Valores e percentagens sobre as barras
      geom_text(
        aes(
          label = paste0(
            Count,
            "\n(",
            round(Percentual, 1),
            "%)"
          ),
          text = paste0(
            "Sessão: ", Sessoes,
            "<br>Presenças: ", Count,
            "<br>Percentual: ",
            round(Percentual, 1),
            "%"
          )
        ),
        vjust = -0.3,
        color = "black",
        size = 4,
        fontface = "bold"
      ) +
      
      theme_stata() +
      
      # Inclinar somente os nomes das sessões no eixo X
      theme(
        axis.text.x = element_text(
          angle = 45,
          hjust = 1,
          vjust = 1
        ),
        legend.position = "none"
      ) +
      
      scale_y_continuous(
        limits = c(0, limite_y),
        expand = expansion(
          mult = c(0, 0.05)
        )
      ) +
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão"
      )
    
    # Converter para Plotly
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
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
    
    df <- Webinars_Nampula
    
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
    previsto <- 43
    
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
  

  observe({
    
    cidades <- Feiras_Nampula %>%
      pull(Cidade) %>%
      unique() %>%
      na.omit() %>%
      sort()
    
    updateSelectInput(
      session,
      "filtro_monitoria_feira",
      choices = c("Todas", cidades),
      selected = "Todas"
    )
    
  })
  
  
  # ==========================================================
  # Atualizar pesquisadores conforme cidade
  # ==========================================================
  
  observeEvent(
    input$filtro_monitoria_feira,
    {
      
      if (input$filtro_monitoria_feira == "Todas") {
        
        pesquisadores <- Feiras_Nampula %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      } else {
        
        pesquisadores <- Feiras_Nampula %>%
          filter(
            Cidade == input$filtro_monitoria_feira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      }
      
      updateSelectInput(
        session,
        "pesquisador_feira",
        choices = c("Todas", pesquisadores),
        selected = "Todas"
      )
      
    },
    ignoreInit = FALSE
  )
  
  
  # ==========================================================
  # Dados filtrados
  # ==========================================================
  
  dados_filtrados_feira <- reactive({
    
    df <- Feiras_Nampula
    
    if (input$filtro_monitoria_feira != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_feira
        )
      
    }
    
    if (input$pesquisador_feira != "Todas") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_feira
        )
      
    }
    
    df
    
  })
  
  
  # ==========================================================
  # Preparar dados para o gráfico
  # ==========================================================
  
  dados_plot_feira <- reactive({
    
    df <- dados_filtrados_feira()
    
    previsto <- 43
    
    
    # ----------------------------------------------------------
    # Limpar colunas de sessões
    # ----------------------------------------------------------
    
    df <- df %>%
      mutate(
        across(
          starts_with("Sessao_"),
          ~ sapply(.x, function(x) {
            
            if (is.null(x)) {
              return(NA_character_)
            }
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste(x, collapse = ", ")
            
          })
        )
      )
    
    
    # ----------------------------------------------------------
    # Transformar sessões para formato longo
    # ----------------------------------------------------------
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    
    # ----------------------------------------------------------
    # Agregar presenças
    # ----------------------------------------------------------
    
    df_agg <- df_long %>%
      mutate(
        Presenca = as.character(Presenca)
      ) %>%
      filter(
        !is.na(Presenca),
        str_detect(
          Presenca,
          "Presente"
        )
      ) %>%
      group_by(Sessoes) %>%
      summarise(
        Count = n(),
        .groups = "drop"
      ) %>%
      mutate(
        
        # Número previsto
        Previsto = previsto,
        
        # Percentual em relação ao previsto
        Percentual = round(
          (Count / Previsto) * 100,
          1
        ),
        
        # Número da sessão para ordenar
        Sessao_num = as.numeric(
          gsub(
            "Sessao_",
            "",
            Sessoes
          )
        )
      ) %>%
      arrange(Sessao_num) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = Sessoes
        )
      ) %>%
      select(
        -Sessao_num
      )
    
    
    df_agg
    
  })
  
  
  # ==========================================================
  # Gráfico - Presenças por Sessão
  # ==========================================================
  
  output$grafico_feira <- renderPlotly({
    
    df_agg <- dados_plot_feira()
    
    if (nrow(df_agg) == 0) {
      return(NULL)
    }
    
    
    previsto <- unique(df_agg$Previsto)[1]
    
    
    # Limite superior do eixo Y
    limite_y <- max(
      c(
        df_agg$Count,
        previsto
      ),
      na.rm = TRUE
    ) + 7
    
    
    # ----------------------------------------------------------
    # Gráfico
    # ----------------------------------------------------------
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_col() +
      
      
      # Linha do previsto
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        linewidth = 1.1
      ) +
      
      
      # Valores nas barras
      geom_text(
        aes(
          label = paste0(
            Count,
            "\n(",
            Percentual,
            "%)"
          ),
          text = paste0(
            "<b>",
            Sessoes,
            "</b>",
            "<br>Presenças: ",
            Count,
            "<br>Previsto: ",
            previsto,
            "<br>Percentual: ",
            Percentual,
            "%"
          )
        ),
        vjust = -0.2,
        color = "black",
        size = 4,
        fontface = "bold"
      ) +
      
      
      theme_stata() +
      
      
      scale_y_continuous(
        limits = c(
          0,
          limite_y
        )
      ) +
      
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão - Feiras_Nampula"
      )
    
    
    # ----------------------------------------------------------
    # Plotly
    # ----------------------------------------------------------
    
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ==========================================================
  # Texto automático
  # ==========================================================
  
  output$texto_feira <- renderUI({
    
    df <- dados_plot_feira()
    
    if (nrow(df) == 0) {
      return(NULL)
    }
    
    
    maior <- df %>%
      arrange(
        desc(Count)
      ) %>%
      slice(1)
    
    
    HTML(
      paste0(
        "<b>Resumo:</b> A sessão com maior participação foi ",
        maior$Sessoes,
        " com ",
        maior$Count,
        " participantes (",
        maior$Percentual,
        "% do previsto)."
      )
    )
    
  })
  
  
  # ==========================================================
  # Tabela - Feiras_Nampula
  # ==========================================================
  
  output$tabela_feira <- renderDataTable({
    
    df <- dados_filtrados_feira()
    
    
    # ----------------------------------------------------------
    # Identificar colunas de sessões
    # ----------------------------------------------------------
    
    col_sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    # ----------------------------------------------------------
    # Ordenar sessões numericamente
    # ----------------------------------------------------------
    
    col_sessoes_ordenadas <- col_sessoes[
      order(
        as.numeric(
          gsub(
            "Sessao_",
            "",
            col_sessoes
          )
        )
      )
    ]
    
    
    # ----------------------------------------------------------
    # Colunas fixas
    # ----------------------------------------------------------
    
    col_fixas <- setdiff(
      names(df),
      col_sessoes
    )
    
    
    # ----------------------------------------------------------
    # Reorganizar tabela
    # ----------------------------------------------------------
    
    df <- df[
      ,
      c(
        col_fixas,
        col_sessoes_ordenadas
      )
    ]
    
    
    # ----------------------------------------------------------
    # Formatar sessões
    # ----------------------------------------------------------
    
    df[col_sessoes_ordenadas] <- lapply(
      df[col_sessoes_ordenadas],
      formatar_pontos
    )
    
    
    # ----------------------------------------------------------
    # DataTable
    # ----------------------------------------------------------
    
    datatable(
      df,
      escape = FALSE,
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
    
  })
  
 
  
  # ============================================================
  # SESSÕES INDIVIDUAIS — FILTRAGEM DOS DADOS
  # ============================================================
  
  dados_filtrados_individual <- reactive({
    
    df <- Presencas_Individuais
    
    if (input$filtro_monitoria_individual != "Todas") {
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_individual
        )
    }
    
    if (input$pesquisador_individual != "Todas") {
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_individual
        )
    }
    
    df
  })
  
  
  # ============================================================
  # PREPARAÇÃO DOS DADOS PARA O GRÁFICO
  # ============================================================
  
  dados_plot_individual <- reactive({
    
    df <- dados_filtrados_individual()
    
    # Número previsto de participantes por sessão.
    # ALTERAR 43 se a meta das sessões individuais for diferente.
    previsto <- 43
    
    if (nrow(df) == 0) {
      return(data.frame())
    }
    
    df_agg <- df %>%
      mutate(
        Sessao = trimws(
          as.character(`Nome da Sessão`)
        ),
        Presenca_limpa = trimws(
          as.character(Presença)
        )
      ) %>%
      filter(
        !is.na(Sessao),
        Sessao != ""
      ) %>%
      group_by(Sessao) %>%
      summarise(
        Count = sum(
          tolower(Presenca_limpa) == "presente",
          na.rm = TRUE
        ),
        Ausencias = sum(
          tolower(Presenca_limpa) == "ausente",
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Previsto = previsto,
        Percentual = round(
          (Count / Previsto) * 100,
          1
        ),
        Sessao_num = suppressWarnings(
          as.numeric(
            stringr::str_extract(
              Sessao,
              "\\d+"
            )
          )
        )
      ) %>%
      arrange(
        is.na(Sessao_num),
        Sessao_num,
        Sessao
      ) %>%
      mutate(
        Sessoes = factor(
          Sessao,
          levels = unique(Sessao)
        )
      )
    
    df_agg
  })
  
  
  # ============================================================
  # GRÁFICO — PRESENÇAS POR SESSÃO INDIVIDUAL
  # ============================================================
  
  output$grafico_individual <- renderPlotly({
    
    df_agg <- dados_plot_individual()
    
    if (nrow(df_agg) == 0) {
      
      return(
        plotly::plot_ly() %>%
          layout(
            title = paste(
              "Sem dados disponíveis para",
              "os filtros seleccionados"
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    previsto <- unique(df_agg$Previsto)[1]
    
    limite_y <- max(
      c(
        df_agg$Count,
        previsto
      ),
      na.rm = TRUE
    ) + 7
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_col() +
      
      # Linha de referência do previsto
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        linewidth = 1.2
      ) +
      
      # Valores e percentagens nas barras
      geom_text(
        aes(
          label = paste0(
            Count,
            "\n(",
            round(Percentual, 1),
            "%)"
          ),
          text = paste0(
            "<b>Sessão:</b> ",
            Sessao,
            "<br><b>Presenças:</b> ",
            Count,
            "<br><b>Ausências:</b> ",
            Ausencias,
            "<br><b>Previsto:</b> ",
            Previsto,
            "<br><b>Percentual:</b> ",
            round(Percentual, 1),
            "%"
          )
        ),
        vjust = -0.3,
        color = "black",
        size = 4,
        fontface = "bold"
      ) +
      
      theme_stata() +
      
      # Inclinar os nomes das sessões no eixo X
      theme(
        axis.text.x = element_text(
          angle = 45,
          hjust = 1,
          vjust = 1
        ),
        legend.position = "none"
      ) +
      
      scale_y_continuous(
        limits = c(0, limite_y),
        expand = expansion(
          mult = c(0, 0.05)
        )
      ) +
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão Individual"
      )
    
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # FORMATAR PRESENÇAS COM PONTOS COLORIDOS
  # ============================================================
  
  
  formatar_pontos_individual <- function(x) {
    
    x <- trimws(as.character(x))
    
    x[is.na(x) | x == ""] <- "Ausente"
    
    ifelse(
      tolower(x) == "presente",
      '<span style="color:purple;font-size:30px;">&#9679;</span>',
      
      ifelse(
        tolower(x) == "ausente",
        '<span style="color:red;font-size:30px;">&#9679;</span>',
        htmltools::htmlEscape(x)
      )
    )
  }
  
  
  
  # ============================================================
  # TABELA — SESSÕES INDIVIDUAIS EM FORMATO PIVOT
  # Uma linha por empreendedora
  # ============================================================
  
  output$tabela_individual <- DT::renderDT({
    
    df <- dados_filtrados_individual()
    
    if (nrow(df) == 0) {
      return(
        DT::datatable(
          data.frame(
            Mensagem = "Sem dados para os filtros seleccionados"
          ),
          rownames = FALSE
        )
      )
    }
    
    # ----------------------------------------------------------
    # Seleccionar as colunas necessárias
    # ----------------------------------------------------------
    
    colunas_necessarias <- c(
      "Cidade",
      "Pesquisadores",
      "ID_MUVA",
      "Nome_Empreendedora",
      "Nome da Sessão",
      "Presença"
    )
    
    colunas_em_falta <- setdiff(
      colunas_necessarias,
      names(df)
    )
    
    if (length(colunas_em_falta) > 0) {
      stop(
        paste(
          "Colunas não encontradas na base:",
          paste(colunas_em_falta, collapse = ", ")
        )
      )
    }
    
    df <- df %>%
      select(all_of(colunas_necessarias)) %>%
      mutate(
        across(
          everything(),
          ~ trimws(as.character(.x))
        )
      )
    
    # ----------------------------------------------------------
    # Preparar o nome da sessão
    # ----------------------------------------------------------
    
    df <- df %>%
      filter(
        !is.na(`Nome da Sessão`),
        `Nome da Sessão` != ""
      ) %>%
      mutate(
        Presença = na_if(Presença, "")
      )
    
    # ----------------------------------------------------------
    # Se existirem registos repetidos para a mesma
    # empreendedora e sessão, priorizar Presente.
    # Caso contrário, manter o estado registado.
    # ----------------------------------------------------------
    
    df <- df %>%
      group_by(
        Cidade,
        Pesquisadores,
        ID_MUVA,
        Nome_Empreendedora,
        `Nome da Sessão`
      ) %>%
      summarise(
        Presença = case_when(
          any(
            tolower(Presença) == "presente",
            na.rm = TRUE
          ) ~ "Presente",
          
          any(
            tolower(Presença) == "ausente",
            na.rm = TRUE
          ) ~ "Ausente",
          
          TRUE ~ NA_character_
        ),
        .groups = "drop"
      )
    
    
    # ============================================================
    # PIVOT — CADA SESSÃO PASSA A SER UMA COLUNA
    # Células sem registo serão preenchidas com "Ausente"
    # ============================================================
    
    df_pivot <- df %>%
      tidyr::pivot_wider(
        names_from = `Nome da Sessão`,
        values_from = Presença,
        values_fill = "Ausente"
      )
    
    # Garantir que valores vazios também sejam Ausente
    colunas_fixas <- c(
      "Cidade",
      "Pesquisadores",
      "ID_MUVA",
      "Nome_Empreendedora"
    )
    
    colunas_sessoes <- setdiff(
      names(df_pivot),
      colunas_fixas
    )
    
    df_pivot <- df_pivot %>%
      mutate(
        across(
          all_of(colunas_sessoes),
          ~ ifelse(
            is.na(.) | trimws(.) == "",
            "Ausente",
            .
          )
        )
      )
    
    
    # ----------------------------------------------------------
    # Formatar pontos nas colunas das sessões
    # ----------------------------------------------------------
    
    if (length(colunas_sessoes) > 0) {
      df_pivot[colunas_sessoes] <- lapply(
        df_pivot[colunas_sessoes],
        formatar_pontos_individual
      )
    }
    
    # ----------------------------------------------------------
    # DataTable interactiva
    # ----------------------------------------------------------
    
    DT::datatable(
      df_pivot,
      escape = FALSE,
      rownames = FALSE,
      extensions = "Buttons",
      options = list(
        pageLength = 10,
        lengthMenu = list(
          c(10, 25, 50, 100, -1),
          c("10", "25", "50", "100", "Todos")
        ),
        scrollX = TRUE,
        autoWidth = TRUE,
        dom = "Bfrtip",
        buttons = c(
          "copy",
          "csv",
          "excel"
        ),
        columnDefs = list(
          list(
            className = "dt-center",
            targets = "_all"
          )
        ),
        language = list(
          search = "Pesquisar:",
          lengthMenu = "Mostrar _MENU_ empreendedoras",
          info = "A mostrar _START_ a _END_ de _TOTAL_ empreendedoras",
          infoEmpty = "Sem registos disponíveis",
          zeroRecords = "Nenhum registo encontrado",
          paginate = list(
            previous = "Anterior",
            `next` = "Seguinte"
          )
        )
      )
    )
    
  }, server = TRUE)
  
  
  
  
  
  # ============================================================
  # DADOS FINANCEIROS - NAMPULA
  # ============================================================
  
  
  # ============================================================
  # VALUE BOX
  # ============================================================
  
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
  
  
  # ============================================================
  # ATUALIZAR EMPREENDEDORAS CONFORME PESQUISADOR
  # ============================================================
  
  observeEvent(input$Pesquisador, {
    
    df <- Financeiro_Nampula
    
    if (!is.null(input$Pesquisador) &&
        input$Pesquisador != "Todos") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$Pesquisador
        )
    }
    
    empreendedoras <- df %>%
      select(Nome_Empreendedora) %>%
      distinct() %>%
      arrange(Nome_Empreendedora) %>%
      pull(Nome_Empreendedora)
    
    updateSelectInput(
      session,
      "Nome_Empreendedora",
      choices = c("Todas", empreendedoras),
      selected = "Todas"
    )
    
  })
  
  
  # ============================================================
  # FILTROS FINANCEIROS
  # ============================================================
  
  df_financeiro <- reactive({
    
    df <- Dados_Financeiros_Ciclo_3
    
    # -------------------------
    # PESQUISADOR
    # -------------------------
    
    if (!is.null(input$Pesquisador) &&
        input$Pesquisador != "Todos") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$Pesquisador
        )
    }
    
    
    # -------------------------
    # EMPREENDEDORA
    # -------------------------
    
    if (!is.null(input$Nome_Empreendedora) &&
        input$Nome_Empreendedora != "Todas") {
      
      df <- df %>%
        filter(
          Nome_Empreendedora == input$Nome_Empreendedora
        )
    }
    
    
    # -------------------------
    # PERÍODO
    # -------------------------
    
    if (!is.null(input$Mes) &&
        input$Mes != "Todos") {
      
      df <- df %>%
        filter(
          Periodo == input$Mes
        )
    }
    
    df
  })
  
  
  # ============================================================
  # BOX - EMPREENDEDORAS
  # ============================================================
  
  output$vb_emp <- renderUI({
    
    criar_box(
      n_distinct(
        df_financeiro()$Nome_Empreendedora
      ),
      "Empreendedoras",
      "purple"
    )
    
  })
  
  
  # ============================================================
  # GRÁFICO - LUCRO, RENDIMENTO E CUSTOS
  # ============================================================
  
  output$cidade_plot <- renderPlotly({
    
    df <- df_financeiro()
    
    resumo <- data.frame(
      
      Indicador = c(
        "Lucro",
        "Rendimento",
        "Custos"
      ),
      
      Valor = c(
        
        sum(
          df$Lucro_Semanal,
          na.rm = TRUE
        ),
        
        sum(
          df$Rendimento,
          na.rm = TRUE
        ),
        
        sum(
          df$Custo_Operacional,
          na.rm = TRUE
        ) +
          sum(
            df$Custo_de_produtos_Servicos,
            na.rm = TRUE
          )
      )
      
    )
    
    
    g <- ggplot(
      resumo,
      aes(
        x = Indicador,
        y = Valor,
        fill = Indicador
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = scales::comma(
            round(Valor, 0)
          )
        ),
        vjust = -0.3,
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Lucro" = "#8054A2",
          "Rendimento" = "#f9a825",
          "Custos" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Valores (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(0.05, 0.20)
        )
      ) +
      
      theme_stata(
        base_size = 14
      ) +
      
      theme(
        legend.position = "none",
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        ),
        axis.text = element_text(
          color = "#333333"
        ),
        axis.title = element_text(
          face = "bold"
        )
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ============================================================
  # GRÁFICO - LUCRO POR SEMANA
  # ============================================================
  
  output$grafico_financeiro <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      
      group_by(Semanas) %>%
      
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
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
    
    
    # Evitar erro quando não houver dados
    
    if (nrow(df_plot) == 0) {
      return(NULL)
    }
    
    
    desloc <- max(
      abs(df_plot$Lucro),
      na.rm = TRUE
    ) * 0.08
    
    
    g <- ggplot(
      df_plot,
      aes(
        x = Semanas,
        y = Lucro,
        group = 1
      )
    ) +
      
      geom_area(
        fill = "#8054A2",
        alpha = 0.15
      ) +
      
      geom_line(
        color = "#8054A2",
        linewidth = 1.3
      ) +
      
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      geom_text(
        aes(
          y = Lucro + desloc,
          label = scales::comma(
            round(Lucro, 0)
          )
        ),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(
        x = "",
        y = "Lucro (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(0.05, 0.25)
        )
      ) +
      
      theme_minimal(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        ),
        axis.text = element_text(
          color = "#333333"
        ),
        axis.title = element_text(
          face = "bold"
        )
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ============================================================
  # GRÁFICO - FINANCEIRO POR SEMANA
  # ============================================================
  
  output$grafico_barras_semanas <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      
      group_by(Semanas) %>%
      
      summarise(
        
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        
        Rendimento = sum(
          Rendimento,
          na.rm = TRUE
        ),
        
        Custo_Operacional = sum(
          Custo_Operacional,
          na.rm = TRUE
        ),
        
        Custo_Produto = sum(
          Custo_de_produtos_Servicos,
          na.rm = TRUE
        ),
        
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
        cols = c(
          Lucro,
          Rendimento,
          Custo_Operacional,
          Custo_Produto
        ),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    
    dodge <- position_dodge(
      width = 0.8
    )
    
    
    p <- ggplot(
      df_long,
      aes(
        x = Semanas,
        y = Valor,
        fill = Indicador
      )
    ) +
      
      geom_col(
        position = dodge,
        width = 0.7
      ) +
      
      geom_text(
        aes(
          label = scales::comma(
            round(Valor, 0)
          )
        ),
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
      
      theme_stata(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        )
      )
    
    
    ggplotly(p) %>%
      layout(
        barmode = "group",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ============================================================
  # FILTRO FINANCEIRO PARA OS INDICADORES
  # ============================================================
  
  dados_financeiro_filtrado <- reactive({
    
    df <- Dados_Financeiros_Ciclo_3
    
    if (!is.null(input$Pesquisador) &&
        input$Pesquisador != "Todos") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$Pesquisador
        )
    }
    
    df
  })
  
  
  # ============================================================
  # BOX 1
  # AUMENTO DE LUCRO: 1.º → 2.º MÊS
  # ============================================================
  
  output$vb_aumento_lucro_mes_1_2 <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      group_by(
        Nome_Empreendedora
      ) %>%
      
      mutate(
        lucro_anterior = lag(
          Lucro_Mensal
        ),
        
        aumento =
          Lucro_Mensal > lucro_anterior
      ) %>%
      
      ungroup()
    
    
    valor <- df %>%
      
      filter(
        Periodo == "Segundo Mês",
        !is.na(lucro_anterior)
      ) %>%
      
      summarise(
        total = sum(
          aumento,
          na.rm = TRUE
        )
      ) %>%
      
      pull(total)
    
    
    div(
      class = "value-box blue",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento de Lucro: 1.º → 2.º Mês"
      )
    )
  })
  
  
  # ============================================================
  # BOX 2
  # AUMENTO ≥25%: 1.º → 2.º MÊS
  # ============================================================
  
  output$vb_aumento_25_mes_1_2 <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      group_by(
        Nome_Empreendedora
      ) %>%
      
      mutate(
        
        lucro_anterior = lag(
          Lucro_Mensal
        ),
        
        aumento_pct = ifelse(
          lucro_anterior > 0,
          (
            Lucro_Mensal -
              lucro_anterior
          ) /
            lucro_anterior * 100,
          NA
        ),
        
        aumento_25 =
          aumento_pct >= 25
        
      ) %>%
      
      ungroup()
    
    
    valor <- df %>%
      
      filter(
        Periodo == "Segundo Mês",
        !is.na(aumento_25)
      ) %>%
      
      summarise(
        total = sum(
          aumento_25,
          na.rm = TRUE
        )
      ) %>%
      
      pull(total)
    
    
    div(
      class = "value-box orange",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento ≥25%: 1.º → 2.º Mês"
      )
    )
  })
  
  
  # ============================================================
  # BOX 3
  # AUMENTO DE LUCRO: 2.º → 3.º MÊS
  # ============================================================
  
  output$vb_aumento_lucro_mes_2_3 <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      group_by(
        Nome_Empreendedora
      ) %>%
      
      mutate(
        
        lucro_anterior = lag(
          Lucro_Mensal
        ),
        
        aumento =
          Lucro_Mensal > lucro_anterior
        
      ) %>%
      
      ungroup()
    
    
    valor <- df %>%
      
      filter(
        Periodo == "Terceiro Mês",
        !is.na(lucro_anterior)
      ) %>%
      
      summarise(
        total = sum(
          aumento,
          na.rm = TRUE
        )
      ) %>%
      
      pull(total)
    
    
    div(
      class = "value-box blue",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento de Lucro: 2.º → 3.º Mês"
      )
    )
  })
  
  
  # ============================================================
  # BOX 4
  # AUMENTO ≥25%: 2.º → 3.º MÊS
  # ============================================================
  
  output$vb_aumento_25_mes_2_3 <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      group_by(
        Nome_Empreendedora
      ) %>%
      
      mutate(
        
        lucro_anterior = lag(
          Lucro_Mensal
        ),
        
        aumento_pct = ifelse(
          lucro_anterior > 0,
          (
            Lucro_Mensal -
              lucro_anterior
          ) /
            lucro_anterior * 100,
          NA
        ),
        
        aumento_25 =
          aumento_pct >= 25
        
      ) %>%
      
      ungroup()
    
    
    valor <- df %>%
      
      filter(
        Periodo == "Terceiro Mês",
        !is.na(aumento_25)
      ) %>%
      
      summarise(
        total = sum(
          aumento_25,
          na.rm = TRUE
        )
      ) %>%
      
      pull(total)
    
    
    div(
      class = "value-box orange",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento ≥25%: 2.º → 3.º Mês"
      )
    )
  })
  
  # ============================================================
# GRÁFICO MENSAL DE LUCRO
# ============================================================
  output$grafico_mensal <- renderPlotly({
    
    df_plot <- df_financeiro() %>%
      
      group_by(Periodo) %>%
      
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(Periodo)
    
    
    # Evitar erro quando não houver dados
    
    if (nrow(df_plot) == 0) {
      return(NULL)
    }
    
    
    desloc <- max(
      abs(df_plot$Lucro),
      na.rm = TRUE
    ) * 0.08
    
    
    g <- ggplot(
      df_plot,
      aes(
        x = Periodo,
        y = Lucro,
        group = 1
      )
    ) +
      
      geom_area(
        fill = "#8054A2",
        alpha = 0.15
      ) +
      
      geom_line(
        color = "#8054A2",
        linewidth = 1.3
      ) +
      
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      geom_text(
        aes(
          y = Lucro + desloc,
          label = scales::comma(
            round(Lucro, 0)
          )
        ),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(
        x = "",
        y = "Lucro (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(0.05, 0.25)
        )
      ) +
      
      theme_minimal(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        ),
        axis.text = element_text(
          color = "#333333"
        ),
        axis.title = element_text(
          face = "bold"
        )
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  
  output$grafico_barras <- renderPlotly({
    
    df <- df_financeiro()
    
    req(nrow(df) > 0)
    
    # =========================
    # AGREGAR POR MÊS
    # =========================
    df_plot <- df %>%
      group_by(Periodo) %>%
      summarise(
        Lucro = sum(Lucro_Semanal, na.rm = TRUE),
        Rendimento = sum(Rendimento, na.rm = TRUE),
        Custo_Operacional = sum(Custo_Operacional, na.rm = TRUE),
        Custo_Produtos = sum(
          Custo_de_produtos_Servicos,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Custos = Custo_Operacional + Custo_Produtos,
        
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(Periodo) %>%
      
      select(
        Periodo,
        Lucro,
        Rendimento,
        Custos
      ) %>%
      
      tidyr::pivot_longer(
        cols = c(
          Lucro,
          Rendimento,
          Custos
        ),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    
    # =========================
    # GRÁFICO DE BARRAS
    # =========================
    plot_ly(
      df_plot,
      x = ~Periodo,
      y = ~Valor,
      color = ~Indicador,
      text = ~scales::comma(
        round(Valor, 0)
      ),
      textposition = "outside",
      type = "bar",
      
      colors = c(
        "Lucro" = "#8054A2",
        "Rendimento" = "#f9a825",
        "Custos" = "#69C7BE"
      ),
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        "%{fullData.name}: %{y:,.2f}",
        "<extra></extra>"
      )
    ) %>%
      
      layout(
        
        # =========================
        # TÍTULO
        # =========================
        title = list(
          text = "",
          x = 0.02
        ),
        
        # =========================
        # BARRAS LADO A LADO
        # =========================
        barmode = "group",
        
        # =========================
        # EIXO X
        # =========================
        xaxis = list(
          title = "",
          showgrid = FALSE
        ),
        
        # =========================
        # EIXO Y
        # =========================
        yaxis = list(
          title = "Valor",
          separatethousands = TRUE
        ),
        
        # =========================
        # MESMO FUNDO
        # =========================
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        # =========================
        # LEGENDA
        # =========================
        legend = list(
          orientation = "h",
          x = 0,
          y = 1.1
        ),
        
        # =========================
        # MARGENS
        # =========================
        margin = list(
          l = 70,
          r = 30,
          t = 90,
          b = 60
        )
      )
  })
  
  output$leitura_grafico_mensal <- renderUI({
    
    df <- df_financeiro()
    
    req(nrow(df) > 0)
    
    # ============================================================
    # CALCULAR LUCRO TOTAL POR MÊS
    # ============================================================
    
    df_mensal <- df %>%
      group_by(Periodo) %>%
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      arrange(Periodo)
    
    
    req(nrow(df_mensal) > 0)
    
    
    # ============================================================
    # GARANTIR OS MESES
    # ============================================================
    
    meses <- c(
      "Primeiro Mês",
      "Segundo Mês",
      "Terceiro Mês"
    )
    
    lucro <- setNames(
      rep(NA_real_, length(meses)),
      meses
    )
    
    lucro[as.character(df_mensal$Periodo)] <- df_mensal$Lucro
    
    
    m1 <- lucro["Primeiro Mês"]
    m2 <- lucro["Segundo Mês"]
    m3 <- lucro["Terceiro Mês"]
    
    
    # ============================================================
    # VARIAÇÕES
    # ============================================================
    
    var_1_2 <- if (
      !is.na(m1) &&
      !is.na(m2) &&
      m1 != 0
    ) {
      ((m2 - m1) / abs(m1)) * 100
    } else {
      NA_real_
    }
    
    
    var_2_3 <- if (
      !is.na(m2) &&
      !is.na(m3) &&
      m2 != 0
    ) {
      ((m3 - m2) / abs(m2)) * 100
    } else {
      NA_real_
    }
    
    
    var_1_3 <- if (
      !is.na(m1) &&
      !is.na(m3) &&
      m1 != 0
    ) {
      ((m3 - m1) / abs(m1)) * 100
    } else {
      NA_real_
    }
    
    
    # ============================================================
    # MAIOR E MENOR LUCRO
    # ============================================================
    
    df_valid <- df_mensal %>%
      filter(!is.na(Lucro))
    
    
    maior <- df_valid %>%
      slice_max(
        Lucro,
        n = 1,
        with_ties = FALSE
      )
    
    
    menor <- df_valid %>%
      slice_min(
        Lucro,
        n = 1,
        with_ties = FALSE
      )
    
    
    # ============================================================
    # DETERMINAR TENDÊNCIA
    # ============================================================
    
    tendencia <- "estável"
    
    if (
      !is.na(m1) &&
      !is.na(m2) &&
      !is.na(m3)
    ) {
      
      if (
        m2 > m1 &&
        m3 > m2
      ) {
        tendencia <- "crescimento contínuo"
        
      } else if (
        m2 < m1 &&
        m3 < m2
      ) {
        tendencia <- "redução contínua"
        
      } else if (
        m2 > m1 &&
        m3 < m2
      ) {
        tendencia <- "crescimento inicial seguido de redução"
        
      } else if (
        m2 < m1 &&
        m3 > m2
      ) {
        tendencia <- "redução inicial seguida de recuperação"
      }
    }
    
    
    # ============================================================
    # INTERPRETAÇÃO DA PRIMEIRA VARIAÇÃO
    # ============================================================
    
    leitura_1_2 <- ""
    
    if (!is.na(var_1_2)) {
      
      if (var_1_2 > 0) {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro aumentou ",
          scales::number(
            var_1_2,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_1_2 < 0) {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro reduziu ",
          scales::number(
            abs(var_1_2),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro manteve-se estável."
        )
      }
    }
    
    
    # ============================================================
    # INTERPRETAÇÃO DA SEGUNDA VARIAÇÃO
    # ============================================================
    
    leitura_2_3 <- ""
    
    if (!is.na(var_2_3)) {
      
      if (var_2_3 > 0) {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "registou-se um aumento de ",
          scales::number(
            var_2_3,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_2_3 < 0) {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "registou-se uma redução de ",
          scales::number(
            abs(var_2_3),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "o lucro manteve-se estável."
        )
      }
    }
    
    
    # ============================================================
    # LEITURA DA TENDÊNCIA GERAL
    # ============================================================
    
    leitura_tendencia <- paste0(
      "No período analisado, observa-se uma tendência de ",
      tendencia,
      "."
    )
    
    
    # ============================================================
    # LEITURA DO MAIOR RESULTADO
    # ============================================================
    
    leitura_maior <- paste0(
      "O maior lucro foi registado no ",
      as.character(maior$Periodo),
      ", com ",
      scales::comma(
        round(maior$Lucro, 0)
      ),
      " MT."
    )
    
    
    # ============================================================
    # LEITURA DA EVOLUÇÃO GLOBAL
    # ============================================================
    
    leitura_global <- ""
    
    if (!is.na(var_1_3)) {
      
      if (var_1_3 > 0) {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro acumulou um crescimento de ",
          scales::number(
            var_1_3,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_1_3 < 0) {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro apresentou uma redução acumulada de ",
          scales::number(
            abs(var_1_3),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro manteve o mesmo nível."
        )
      }
    }
    
    
    # ============================================================
    # TEXTO FINAL
    # ============================================================
    
    texto <- paste0(
      "<strong>Dados sobre lucro:</strong> ",
      leitura_tendencia,
      " ",
      leitura_1_2,
      " ",
      leitura_2_3,
      " ",
      leitura_maior,
      " ",
      leitura_global
    )
    
    
    # ============================================================
    # APRESENTAÇÃO
    # ============================================================
    
    div(
      style = paste0(
        "background-color:#f5f3f4;",
        "border-left:5px solid #8054A2;",
        "padding:15px 20px;",
        "margin-top:10px;",
        "margin-bottom:15px;",
        "border-radius:5px;",
        "font-size:15px;",
        "line-height:1.6;",
        "color:#333333;"
      ),
      HTML(texto)
    )
  })
 
  output$tabela_controle_lucro <- renderDT({
    
    # =========================
    # BASE COM FILTROS
    # =========================
    df <- df_financeiro()
    
    req(nrow(df) > 0)
    
    
    # =========================
    # AGREGAR POR PARTICIPANTE E MÊS
    # =========================
    df <- df %>%
      group_by(
        Pesquisadores,
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Semanal, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      
      # =========================
    # ORGANIZAR MESES
    # =========================
    mutate(
      Periodo = factor(
        Periodo,
        levels = c(
          "Primeiro Mês",
          "Segundo Mês",
          "Terceiro Mês"
        )
      )
    ) %>%
      
      arrange(
        Nome_Empreendedora,
        Periodo
      )
    
    
    # =========================
    # TRANSFORMAR MESES EM COLUNAS
    # =========================
    tabela <- df %>%
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    
    # =========================
    # GARANTIR QUE TODAS AS COLUNAS EXISTEM
    # =========================
    for (coluna in c(
      "Primeiro Mês",
      "Segundo Mês",
      "Terceiro Mês"
    )) {
      
      if (!coluna %in% names(tabela)) {
        tabela[[coluna]] <- 0
      }
    }
    
    
    # =========================
    # MÉDIA DE LUCRO POR PARTICIPANTE
    # =========================
    tabela <- tabela %>%
      mutate(
        `Média por Participante` = rowMeans(
          cbind(
            `Primeiro Mês`,
            `Segundo Mês`,
            `Terceiro Mês`
          ),
          na.rm = TRUE
        )
      )
    
    
    # =========================
    # COMPARAÇÃO
    # =========================
    tabela <- tabela %>%
      mutate(
        
        `1º para 2º Mês` = case_when(
          `Segundo Mês` > `Primeiro Mês` ~ "Aumentou",
          `Segundo Mês` == `Primeiro Mês` ~ "Manteve",
          TRUE ~ "Reduziu"
        ),
        
        `2º para 3º Mês` = case_when(
          `Terceiro Mês` > `Segundo Mês` ~ "Aumentou",
          `Terceiro Mês` == `Segundo Mês` ~ "Manteve",
          TRUE ~ "Reduziu"
        ),
        
        Prioridade = case_when(
          `2º para 3º Mês` == "Reduziu" ~ 1,
          `2º para 3º Mês` == "Manteve" ~ 2,
          TRUE ~ 3
        )
      ) %>%
      
      # =========================
    # ORGANIZAR COLUNAS
    # =========================
    select(
      Pesquisadores,
      Nome_Empreendedora,
      `Primeiro Mês`,
      `Segundo Mês`,
      `Terceiro Mês`,
      `Média por Participante`,
      `1º para 2º Mês`,
      `2º para 3º Mês`,
      Prioridade
    ) %>%
      
      arrange(Prioridade) %>%
      
      select(-Prioridade)
    
    
    # =========================
    # TABELA
    # =========================
    datatable(
      tabela,
      rownames = FALSE,
      options = list(
        pageLength = 15,
        scrollX = TRUE
      )
    ) %>%
      
      # =========================
    # FORMATAR VALORES MONETÁRIOS
    # =========================
    formatRound(
      columns = c(
        "Primeiro Mês",
        "Segundo Mês",
        "Terceiro Mês",
        "Média por Participante"
      ),
      digits = 2
    ) %>%
      
      # =========================
    # COR 1º → 2º
    # =========================
    formatStyle(
      "1º para 2º Mês",
      backgroundColor = styleEqual(
        c(
          "Aumentou",
          "Manteve",
          "Reduziu"
        ),
        c(
          "#8054A2",
          "#f9a825",
          "#69C7BE"
        )
      )
    ) %>%
      
      # =========================
    # COR 2º → 3º
    # =========================
    formatStyle(
      "2º para 3º Mês",
      backgroundColor = styleEqual(
        c(
          "Aumentou",
          "Manteve",
          "Reduziu"
        ),
        c(
          "#8054A2",
          "#f9a825",
          "#69C7BE"
        )
      )
    )
  })
  

  #################################### MONITORIA BEIRA
  # ======================================================
  # DADOS GERAIS - BEIRA C3
  # ======================================================
  
  dados_geral_beira <- reactive({
    
    df <- PERFIL_PAM_VERDE_BEIRA_C3_2026
    
    if (input$filtro_monitoria_geral_beira != "Todos") {
      df <- df %>%
        dplyr::filter(
          `Provincia de residencia` == input$filtro_monitoria_geral_beira
        )
    }
    
    df
    
  })
  

  
  # ==========================================================
  # DADOS GERAIS — MONITORIA BEIRA
  # SELECIONADAS VS INÍCIO DA FORMAÇÃO
  # ==========================================================
  
  dados_geral_beira <- reactive({
    
    df <- PERFIL_PAM_VERDE_BEIRA_C3_2026
    
    # Filtro por província de residência
    if (!is.null(input$filtro_monitoria_geral_beira) &&
        input$filtro_monitoria_geral_beira != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          `Provincia de residencia` ==
            input$filtro_monitoria_geral_beira
        )
    }
    
    df
    
  })
  
  

  # ==========================================================
  # DADOS GERAIS — MONITORIA BEIRA
  # ==========================================================
  
  dados_geral_beira <- reactive({
    
    df <- PERFIL_PAM_VERDE_BEIRA_C3_2026
    
    # --------------------------------------------------------
    # FILTRO POR PROVÍNCIA DE RESIDÊNCIA
    # --------------------------------------------------------
    
    if (!is.null(input$filtro_monitoria_geral_beira) &&
        input$filtro_monitoria_geral_beira != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          `Provincia de residencia` ==
            input$filtro_monitoria_geral_beira
        )
    }
    
    df
    
  })
  
  
  
  # ==========================================================
  # DADOS GERAIS — MONITORIA BEIRA
  # ==========================================================
  
  dados_geral_beira <- reactive({
    
    df <- PERFIL_PAM_VERDE_BEIRA_C3_2026
    
    # Filtro por província de residência
    if (!is.null(input$filtro_monitoria_geral_beira) &&
        input$filtro_monitoria_geral_beira != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          `Provincia de residencia` ==
            input$filtro_monitoria_geral_beira
        )
    }
    
    df
    
  })
  
  
  # ==========================================================
  # GRÁFICO 1 — SELECIONADAS VS INÍCIO DA FORMAÇÃO
  # ORDEM: SELECIONADAS | INICIARAM FORMAÇÃO
  # ==========================================================
  
  output$grafico1_beira <- plotly::renderPlotly({
    
    idioma <- input$idioma %||% "pt"
    
    dados <- dados_geral_beira()
    
    # --------------------------------------------------------
    # 1. TOTAL DE PARTICIPANTES SELECIONADAS
    # --------------------------------------------------------
    
    total_selecionadas <- nrow(dados)
    
    # --------------------------------------------------------
    # 2. TOTAL QUE INICIOU A FORMAÇÃO
    # Activa + Desistente
    # --------------------------------------------------------
    
    total_iniciaram <- dados %>%
      dplyr::filter(
        trimws(as.character(Status)) %in%
          c("Activa", "Desistente")
      ) %>%
      nrow()
    
    # --------------------------------------------------------
    # 3. TOTAL QUE NÃO INICIOU
    # --------------------------------------------------------
    
    total_nao_iniciaram <- dados %>%
      dplyr::filter(
        trimws(as.character(Status)) == "Não Iniciou"
      ) %>%
      nrow()
    
    # --------------------------------------------------------
    # 4. CÁLCULO DAS PERCENTAGENS
    # Denominador: total de selecionadas
    # --------------------------------------------------------
    
    percentagem_selecionadas <- if (total_selecionadas > 0) {
      1
    } else {
      0
    }
    
    percentagem_iniciaram <- if (total_selecionadas > 0) {
      total_iniciaram / total_selecionadas
    } else {
      0
    }
    
    # --------------------------------------------------------
    # 5. CATEGORIAS — ORDEM FIXA
    # PRIMEIRA: SELECIONADAS
    # SEGUNDA: INICIARAM FORMAÇÃO
    # --------------------------------------------------------
    
    categoria_selecionadas <- i18n_tr(
      "Selecionadas",
      idioma
    )
    
    categoria_iniciaram <- i18n_tr(
      "Iniciaram Formação",
      idioma
    )
    
    categorias <- c(
      categoria_selecionadas,
      categoria_iniciaram
    )
    
    # --------------------------------------------------------
    # 6. PREPARAR DADOS DO GRÁFICO
    # --------------------------------------------------------
    
    grafico_df <- data.frame(
      Categoria = categorias,
      
      Valor = c(
        total_selecionadas,
        total_iniciaram
      ),
      
      Percentual = c(
        percentagem_selecionadas,
        percentagem_iniciaram
      ),
      
      Cor = c(
        "#ff7f0e",
        "#8054A2"
      ),
      
      stringsAsFactors = FALSE
    )
    
    # Fixar explicitamente a ordem das categorias
    grafico_df$Categoria <- factor(
      grafico_df$Categoria,
      levels = categorias,
      ordered = TRUE
    )
    
    # Rótulos das barras
    grafico_df$Label <- paste0(
      grafico_df$Valor,
      "\n(",
      scales::percent(
        grafico_df$Percentual,
        accuracy = 0.1
      ),
      ")"
    )
    
    # --------------------------------------------------------
    # 7. TÍTULOS E TEXTOS
    # --------------------------------------------------------
    
    titulo <- i18n_tr(
      "Selecionadas vs Início da Formação",
      idioma
    )
    
    eixo_y <- i18n_tr(
      "Percentagem das selecionadas",
      idioma
    )
    
    texto_total <- i18n_tr(
      "Total",
      idioma
    )
    
    texto_sem_dados <- i18n_tr(
      "Sem dados disponíveis",
      idioma
    )
    
    # --------------------------------------------------------
    # 8. VERIFICAR SE EXISTEM DADOS
    # --------------------------------------------------------
    
    if (total_selecionadas == 0) {
      
      return(
        plotly::plot_ly() %>%
          plotly::layout(
            annotations = list(
              list(
                text = texto_sem_dados,
                x = 0.5,
                y = 0.5,
                xref = "paper",
                yref = "paper",
                showarrow = FALSE,
                font = list(size = 16)
              )
            ),
            xaxis = list(visible = FALSE),
            yaxis = list(visible = FALSE),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          ) %>%
          plotly::config(
            displaylogo = FALSE,
            responsive = TRUE
          )
      )
    }
    
    # --------------------------------------------------------
    # 9. CONSTRUIR GRÁFICO
    # --------------------------------------------------------
    
    plotly::plot_ly(
      data = grafico_df,
      
      x = ~Categoria,
      
      y = ~Percentual,
      
      type = "bar",
      
      marker = list(
        color = grafico_df$Cor
      ),
      
      text = ~Label,
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "white",
        size = 16,
        family = "Arial"
      ),
      
      customdata = grafico_df$Valor,
      
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        texto_total,
        ": %{customdata}<br>",
        eixo_y,
        ": %{y:.1%}",
        "<extra></extra>"
      )
      
    ) %>%
      
      plotly::layout(
        
        title = list(
          text = titulo,
          font = list(size = 18)
        ),
        
        # Ordem explícita da esquerda para a direita
        xaxis = list(
          title = "",
          type = "category",
          categoryorder = "array",
          categoryarray = categorias,
          tickfont = list(size = 13)
        ),
        
        # Escala percentual
        yaxis = list(
          title = eixo_y,
          tickformat = ".0%",
          range = c(0, 1.05),
          dtick = 0.2
        ),
        
        showlegend = FALSE,
        
        # Barras lado a lado
        barmode = "group",
        bargap = 0.4,
        
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        margin = list(
          t = 70,
          b = 70,
          l = 70,
          r = 25
        )
      ) %>%
      
      plotly::config(
        displaylogo = FALSE,
        responsive = TRUE
      )
    
  })
  

  
  
  
  output$grafico2_beira <- renderPlotly({
    
    idioma <- input$idioma %||% "pt"
    
    dados <- dados_geral_beira()
    
    total_activas <- sum(
      dados$Status == "Activa",
      na.rm = TRUE
    )
    
    total_desistentes <- sum(
      dados$Status == "Desistente",
      na.rm = TRUE
    )
    
    total_iniciaram <- total_activas + total_desistentes
    
    if (total_iniciaram == 0) {
      return(
        plotly::plot_ly() %>%
          plotly::layout(
            annotations = list(
              text = i18n_tr("Sem dados disponíveis", idioma),
              x = 0.5,
              y = 0.5,
              showarrow = FALSE
            ),
            paper_bgcolor = "#f5f3f4",
            plot_bgcolor = "#f5f3f4"
          )
      )
    }
    
    categorias_pt <- c(
      "Activas",
      "Desistentes"
    )
    
    categorias <- i18n_tr(categorias_pt, idioma)
    
    resumo <- data.frame(
      Categoria = categorias,
      Total = c(
        total_activas,
        total_desistentes
      ),
      Cor = c("#8054A2", "#69C7BE")
    ) %>%
      dplyr::mutate(
        Percentagem = Total / total_iniciaram * 100,
        Label = paste0(
          Total,
          " (",
          round(Percentagem, 1),
          "%)"
        )
      )
    
    titulo <- i18n_tr(
      "Estado das Empreendedoras que Iniciaram a Formação",
      idioma
    )
    
    eixo_y <- i18n_tr(
      "Percentagem de Empreendedoras",
      idioma
    )
    
    texto_total <- i18n_tr("Total", idioma)
    
    plotly::plot_ly(
      data = resumo,
      x = ~Categoria,
      y = ~Percentagem,
      type = "bar",
      marker = list(
        color = resumo$Cor
      ),
      text = ~Label,
      textposition = "inside",
      insidetextanchor = "middle",
      textfont = list(
        color = "black",
        size = 16,
        family = "Arial"
      ),
      customdata = matrix(resumo$Total, ncol = 1),
      hovertemplate = paste0(
        "<b>%{x}</b><br>",
        texto_total, ": %{customdata[0]}<br>",
        eixo_y, ": %{y:.1f}%<extra></extra>"
      )
    ) %>%
      plotly::layout(
        title = list(
          text = titulo,
          font = list(size = 18)
        ),
        xaxis = list(
          title = "",
          tickfont = list(size = 14)
        ),
        yaxis = list(
          title = eixo_y,
          ticksuffix = "%",
          range = c(0, 105),
          dtick = 20
        ),
        showlegend = FALSE,
        bargap = 0.4,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        margin = list(t = 75, b = 75, l = 80, r = 25)
      ) %>%
      plotly::config(
        displaylogo = FALSE,
        responsive = TRUE
      )
    
  })
  

  ########################## PRESENCAS BEIRA
  dados_filtrados_coletiva_beira <- reactive({
    
    df <- Presencas_Colectivas_Beira
    
    if (input$filtro_monitoria_presencas_beira != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_monitoria_presencas_beira)
    }
    
    if (input$mentora_coletiva_beira != "Todas") {
      df <- df %>%
        filter(Pesquisadores == input$mentora_coletiva_beira)
    }
    
    df
  })
  
  
  dados_plot_coletivo_beira <- reactive({
    
    df <- dados_filtrados_coletiva_beira()
    previsto <- 39
    
    df <- df %>%
      mutate(
        across(
          starts_with("Sessao_"),
          ~sapply(., function(x) {
            if (is.null(x)) return(NA)
            if (is.list(x)) x <- unlist(x)
            paste0(x, collapse = ", ")
          })
        )
      )
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    df_agg <- df_long %>%
      filter(str_detect(Presenca, "Presente")) %>%
      group_by(Sessoes) %>%
      summarise(
        Count = n(),
        .groups = "drop"
      ) %>%
      mutate(
        Previsto = previsto,
        Percentual = (Count / Previsto) * 100
      ) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = unique(Sessoes)[
            order(as.numeric(gsub("Sessao_", "", unique(Sessoes))))
          ]
        )
      )
    
    df_agg
  })
  
  
  # Gráfico interactivo — sem legenda
  output$grafico_sessoes_col_beira <- renderPlotly({
    
    df_agg <- dados_plot_coletivo_beira()
    previsto <- df_agg$Previsto[1]
    
    limite_y <- max(c(df_agg$Count, previsto), na.rm = TRUE) + 7
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_bar(stat = "identity") +
      
      geom_hline(
        yintercept = previsto,
        linetype = "dashed",
        color = "purple",
        linewidth = 1.2
      ) +
      
      geom_text(
        aes(
          label = paste0(
            Count,
            "\n(",
            round(Percentual, 1),
            "%)"
          ),
          text = paste0(
            "Sessão: ", Sessoes,
            "<br>Presenças: ", Count,
            "<br>Percentual: ", round(Percentual, 1), "%"
          )
        ),
        vjust = 1.2,
        size = 4,
        fontface = "bold"
      ) +
      
      theme_stata() +
      scale_y_continuous(limits = c(0, limite_y)) +
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão"
      ) +
      
      theme(
        legend.position = "none",
        axis.text.x = element_text(
          angle = 70,
          hjust = 1,
          vjust = 0.5
        )
      )
    
    ggplotly(g, tooltip = "text") %>%
      layout(
        showlegend = FALSE,
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  formatar_pontos <- function(x) {
    
    ifelse(
      is.na(x) | x == "",
      '<span style="color: gray; font-size:40px;">&#9679;</span>',
      ifelse(
        x == "Presente",
        '<span style="color: purple; font-size:40px;">&#9679;</span>',
        '<span style="color:red; font-size:40px;">&#9679;</span>'
      )
    )
    
  }
  
  output$tabela_presencas_col_beira <- renderDataTable({
    
    df <- dados_filtrados_coletiva_beira()
    
    col_sessoes <- grep("^Sessao_\\d+$", names(df), value = TRUE)
    
    col_sessoes_ordenadas <- col_sessoes[
      order(as.numeric(gsub("Sessao_", "", col_sessoes)))
    ]
    
    col_fixas <- setdiff(names(df), col_sessoes)
    
    df <- df[, c(col_fixas, col_sessoes_ordenadas)]
    
    df[col_sessoes_ordenadas] <- lapply(
      df[col_sessoes_ordenadas],
      formatar_pontos
    )
    
    datatable(
      df,
      escape = FALSE,
      options = list(
        pageLength = 10,
        scrollX = TRUE,
        autoWidth = TRUE
      )
    )
    
  })
  
  
  # ==========================================================
  #                 WEBINARS BEIRA
  # ==========================================================

  
  # ==========================================================
  # WEBINARS - BEIRA
  # Estrutura padronizada
  # ==========================================================
  
  
  # ==========================================================
  # Atualizar cidades
  # ==========================================================
  
  observe({
    
    cidades <- Webinars_Beira %>%
      pull(Cidade) %>%
      unique() %>%
      na.omit() %>%
      sort()
    
    updateSelectInput(
      session,
      "filtro_monitoria_webinar_beira",
      choices = c("Todas", cidades),
      selected = "Todas"
    )
    
  })
  
  
  # ==========================================================
  # Atualizar pesquisadores conforme cidade
  # ==========================================================
  
  observeEvent(
    input$filtro_monitoria_webinar_beira,
    {
      
      if (input$filtro_monitoria_webinar_beira == "Todas") {
        
        pesquisadores <- Webinars_Beira %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      } else {
        
        pesquisadores <- Webinars_Beira %>%
          filter(
            Cidade == input$filtro_monitoria_webinar_beira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      }
      
      updateSelectInput(
        session,
        "pesquisador_webinar_beira",
        choices = c("Todas", pesquisadores),
        selected = "Todas"
      )
      
    },
    ignoreInit = FALSE
  )
  
  
  # ==========================================================
  # Dados filtrados
  # ==========================================================
  
  dados_filtrados_webinar_beira <- reactive({
    
    df <- Webinars_Beira
    
    
    # --------------------------------------------------------
    # Filtro por cidade
    # --------------------------------------------------------
    
    if (input$filtro_monitoria_webinar_beira != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_webinar_beira
        )
      
    }
    
    
    # --------------------------------------------------------
    # Filtro por pesquisador
    # --------------------------------------------------------
    
    if (input$pesquisador_webinar_beira != "Todas") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_webinar_beira
        )
      
    }
    
    
    df
    
  })
  
  
  # ==========================================================
  # KPI - PARTICIPANTES
  # ==========================================================
  
  output$total_participantes_web_beira <- renderUI({
    
    df <- dados_filtrados_webinar_beira()
    
    valueBox(
      nrow(df),
      "Participantes",
      icon = icon("users"),
      color = "purple"
    )
    
  })
  
  
  # ==========================================================
  # KPI - SESSÕES
  # ==========================================================
  
  output$total_sessoes_web_beira <- renderUI({
    
    df <- dados_filtrados_webinar_beira()
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    valueBox(
      length(sessoes),
      "Sessões",
      icon = icon("calendar"),
      color = "blue"
    )
    
  })
  
  
  # ==========================================================
  # KPI - TAXA DE PRESENÇA
  # ==========================================================
  
  output$taxa_presenca_web_beira <- renderUI({
    
    df <- dados_filtrados_webinar_beira()
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    # --------------------------------------------------------
    # Evitar erro quando não existem sessões ou participantes
    # --------------------------------------------------------
    
    if (
      length(sessoes) == 0 ||
      nrow(df) == 0
    ) {
      
      return(
        valueBox(
          "0%",
          "Taxa Presença",
          icon = icon("percent"),
          color = "green"
        )
      )
      
    }
    
    
    # --------------------------------------------------------
    # Limpar valores das sessões
    # --------------------------------------------------------
    
    pres <- df %>%
      select(all_of(sessoes)) %>%
      mutate(
        across(
          everything(),
          ~ sapply(.x, function(x) {
            
            if (is.null(x)) {
              return(NA_character_)
            }
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste(x, collapse = ", ")
            
          })
        )
      ) %>%
      unlist() %>%
      as.character() %>%
      str_detect("Presente") %>%
      sum(na.rm = TRUE)
    
    
    # --------------------------------------------------------
    # Total possível de presenças
    # --------------------------------------------------------
    
    total <- nrow(df) * length(sessoes)
    
    
    taxa <- ifelse(
      total > 0,
      round(
        (pres / total) * 100,
        1
      ),
      0
    )
    
    
    valueBox(
      paste0(
        taxa,
        "%"
      ),
      "Taxa Presença",
      icon = icon("percent"),
      color = "green"
    )
    
  })
  
  
  # ==========================================================
  # Preparar dados para o gráfico
  # ==========================================================
  
  dados_plot_webinar_beira <- reactive({
    
    df <- dados_filtrados_webinar_beira()
    
    previsto <- 43
    
    
    # --------------------------------------------------------
    # Verificar se existem dados
    # --------------------------------------------------------
    
    if (nrow(df) == 0) {
      return(
        data.frame()
      )
    }
    
    
    # --------------------------------------------------------
    # Limpar colunas de sessões
    # --------------------------------------------------------
    
    df <- df %>%
      mutate(
        across(
          starts_with("Sessao_"),
          ~ sapply(.x, function(x) {
            
            if (is.null(x)) {
              return(NA_character_)
            }
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste(x, collapse = ", ")
            
          })
        )
      )
    
    
    # --------------------------------------------------------
    # Transformar sessões para formato longo
    # --------------------------------------------------------
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    
    # --------------------------------------------------------
    # Agregar presenças
    # --------------------------------------------------------
    
    df_agg <- df_long %>%
      mutate(
        Presenca = as.character(Presenca)
      ) %>%
      filter(
        !is.na(Presenca),
        str_detect(
          Presenca,
          "Presente"
        )
      ) %>%
      group_by(Sessoes) %>%
      summarise(
        Count = n(),
        .groups = "drop"
      ) %>%
      mutate(
        
        # Número previsto
        Previsto = previsto,
        
        # Percentual em relação ao previsto
        Percentual = round(
          (Count / Previsto) * 100,
          1
        ),
        
        # Número da sessão
        Sessao_num = as.numeric(
          gsub(
            "Sessao_",
            "",
            Sessoes
          )
        )
        
      ) %>%
      arrange(
        Sessao_num
      ) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = Sessoes
        )
      ) %>%
      select(
        -Sessao_num
      )
    
    
    df_agg
    
  })
  
  
  # ==========================================================
  # GRÁFICO - PRESENÇAS POR SESSÃO
  # ==========================================================
  
  output$grafico_webinar_beira <- renderPlotly({
    
    df_agg <- dados_plot_webinar_beira()
    
    
    # --------------------------------------------------------
    # Sem dados
    # --------------------------------------------------------
    
    if (nrow(df_agg) == 0) {
      return(NULL)
    }
    
    
    previsto <- unique(
      df_agg$Previsto
    )[1]
    
    
    # --------------------------------------------------------
    # Limite superior do eixo Y
    # --------------------------------------------------------
    
    limite_y <- max(
      c(
        df_agg$Count,
        previsto
      ),
      na.rm = TRUE
    ) + 7
    
    
    # --------------------------------------------------------
    # Gráfico
    # --------------------------------------------------------
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_col() +
      
      
      # ------------------------------------------------------
    # Linha do previsto
    # ------------------------------------------------------
    
    geom_hline(
      yintercept = previsto,
      linetype = "dashed",
      color = "purple",
      linewidth = 1.1
    ) +
      
      
      # ------------------------------------------------------
    # Valores e percentuais nas barras
    # ------------------------------------------------------
    
    geom_text(
      aes(
        label = paste0(
          Count,
          "\n(",
          Percentual,
          "%)"
        ),
        text = paste0(
          "<b>",
          Sessoes,
          "</b>",
          "<br>Presenças: ",
          Count,
          "<br>Previsto: ",
          previsto,
          "<br>Percentual: ",
          Percentual,
          "%"
        )
      ),
      vjust = -0.2,
      color = "black",
      size = 4,
      fontface = "bold"
    ) +
      
      
      theme_stata() +
      
      
      scale_y_continuous(
        limits = c(
          0,
          limite_y
        )
      ) +
      
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão - Webinars_Beira"
      )
    
    
    # --------------------------------------------------------
    # Plotly
    # --------------------------------------------------------
    
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ==========================================================
  # TEXTO AUTOMÁTICO
  # ==========================================================
  
  output$texto_webinar_beira <- renderUI({
    
    df <- dados_plot_webinar_beira()
    
    
    if (nrow(df) == 0) {
      return(NULL)
    }
    
    
    maior <- df %>%
      arrange(
        desc(Count)
      ) %>%
      slice(1)
    
    
    HTML(
      paste0(
        "<b>Resumo:</b> A sessão com maior participação foi ",
        maior$Sessoes,
        " com ",
        maior$Count,
        " participantes (",
        maior$Percentual,
        "% do previsto)."
      )
    )
    
  })
  
  
  # ==========================================================
  # TABELA - WEBINARS BEIRA
  # ==========================================================
  
  output$tabela_webinar_beira <- renderDataTable({
    
    df <- dados_filtrados_webinar_beira()
    
    
    # --------------------------------------------------------
    # Identificar colunas de sessões
    # --------------------------------------------------------
    
    col_sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    # --------------------------------------------------------
    # Ordenar sessões numericamente
    # --------------------------------------------------------
    
    col_sessoes_ordenadas <- col_sessoes[
      order(
        as.numeric(
          gsub(
            "Sessao_",
            "",
            col_sessoes
          )
        )
      )
    ]
    
    
    # --------------------------------------------------------
    # Colunas fixas
    # --------------------------------------------------------
    
    col_fixas <- setdiff(
      names(df),
      col_sessoes
    )
    
    
    # --------------------------------------------------------
    # Reorganizar tabela
    # --------------------------------------------------------
    
    df <- df[
      ,
      c(
        col_fixas,
        col_sessoes_ordenadas
      )
    ]
    
    
    # --------------------------------------------------------
    # Formatar sessões
    # --------------------------------------------------------
    
    if (length(col_sessoes_ordenadas) > 0) {
      
      df[col_sessoes_ordenadas] <- lapply(
        df[col_sessoes_ordenadas],
        formatar_pontos
      )
      
    }
    
    
    # --------------------------------------------------------
    # DataTable
    # --------------------------------------------------------
    
    datatable(
      df,
      escape = FALSE,
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
    
  })
  
  
  # ==========================================================
  #                 Feiras_Nampula BEIRA
  # ==========================================================

  observe({
    
    cidades <- Feiras_Beira %>%
      pull(Cidade) %>%
      unique() %>%
      na.omit() %>%
      sort()
    
    updateSelectInput(
      session,
      "filtro_monitoria_feira_beira",
      choices = c("Todas", cidades),
      selected = "Todas"
    )
    
  })
  
  
  # ==========================================================
  # Atualizar pesquisadores conforme cidade
  # ==========================================================
  
  observeEvent(
    input$filtro_monitoria_feira_beira,
    {
      
      if (input$filtro_monitoria_feira_beira == "Todas") {
        
        pesquisadores <- Feiras_Beira %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      } else {
        
        pesquisadores <- Feiras_Beira %>%
          filter(
            Cidade == input$filtro_monitoria_feira_beira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          na.omit() %>%
          sort()
        
      }
      
      updateSelectInput(
        session,
        "pesquisador_feira_beira",
        choices = c("Todas", pesquisadores),
        selected = "Todas"
      )
      
    },
    ignoreInit = FALSE
  )
  
  
  # ==========================================================
  # Dados filtrados
  # ==========================================================
  
  dados_filtrados_feira_beira <- reactive({
    
    df <- Feiras_Beira
    
    # --------------------------------------------------------
    # Filtro por cidade
    # --------------------------------------------------------
    
    if (input$filtro_monitoria_feira_beira != "Todas") {
      
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_feira_beira
        )
      
    }
    
    # --------------------------------------------------------
    # Filtro por pesquisador
    # --------------------------------------------------------
    
    if (input$pesquisador_feira_beira != "Todas") {
      
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_feira_beira
        )
      
    }
    
    df
    
  })
  
  
  # ==========================================================
  # KPIs
  # ==========================================================
  
  output$total_participantes_feira_beira <- renderUI({
    
    df <- dados_filtrados_feira_beira()
    
    valueBox(
      nrow(df),
      "Participantes",
      icon = icon("users"),
      color = "purple"
    )
    
  })
  
  
  # ==========================================================
  # Total de sessões
  # ==========================================================
  
  output$total_sessoes_feira_beira <- renderUI({
    
    df <- dados_filtrados_feira_beira()
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    valueBox(
      length(sessoes),
      "Sessões",
      icon = icon("calendar"),
      color = "blue"
    )
    
  })
  
  
  # ==========================================================
  # Taxa geral de presença
  # ==========================================================
  
  output$taxa_presenca_feira_beira <- renderUI({
    
    df <- dados_filtrados_feira_beira()
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    # --------------------------------------------------------
    # Evitar erro quando não existem sessões
    # --------------------------------------------------------
    
    if (length(sessoes) == 0 || nrow(df) == 0) {
      
      return(
        valueBox(
          "0%",
          "Taxa Presença",
          icon = icon("percent"),
          color = "green"
        )
      )
      
    }
    
    
    # --------------------------------------------------------
    # Calcular presenças
    # --------------------------------------------------------
    
    pres <- df %>%
      select(all_of(sessoes)) %>%
      mutate(
        across(
          everything(),
          ~ sapply(.x, function(x) {
            
            if (is.null(x)) {
              return(NA_character_)
            }
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste(x, collapse = ", ")
            
          })
        )
      ) %>%
      unlist() %>%
      as.character() %>%
      str_detect("Presente") %>%
      sum(na.rm = TRUE)
    
    
    # --------------------------------------------------------
    # Total possível de presenças
    # --------------------------------------------------------
    
    total <- nrow(df) * length(sessoes)
    
    
    taxa <- ifelse(
      total > 0,
      round((pres / total) * 100, 1),
      0
    )
    
    
    valueBox(
      paste0(taxa, "%"),
      "Taxa Presença",
      icon = icon("percent"),
      color = "green"
    )
    
  })
  
  
  # ==========================================================
  # Preparar dados para o gráfico
  # ==========================================================
  
  dados_plot_feira_beira <- reactive({
    
    df <- dados_filtrados_feira_beira()
    
    previsto <- 39
    
    
    # --------------------------------------------------------
    # Verificar se existem dados
    # --------------------------------------------------------
    
    if (nrow(df) == 0) {
      return(
        data.frame()
      )
    }
    
    
    # --------------------------------------------------------
    # Limpar colunas de sessões
    # --------------------------------------------------------
    
    df <- df %>%
      mutate(
        across(
          starts_with("Sessao_"),
          ~ sapply(.x, function(x) {
            
            if (is.null(x)) {
              return(NA_character_)
            }
            
            if (is.list(x)) {
              x <- unlist(x)
            }
            
            paste(x, collapse = ", ")
            
          })
        )
      )
    
    
    # --------------------------------------------------------
    # Transformar sessões para formato longo
    # --------------------------------------------------------
    
    df_long <- df %>%
      pivot_longer(
        cols = starts_with("Sessao_"),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    
    # --------------------------------------------------------
    # Agregar presenças
    # --------------------------------------------------------
    
    df_agg <- df_long %>%
      mutate(
        Presenca = as.character(Presenca)
      ) %>%
      filter(
        !is.na(Presenca),
        str_detect(
          Presenca,
          "Presente"
        )
      ) %>%
      group_by(Sessoes) %>%
      summarise(
        Count = n(),
        .groups = "drop"
      ) %>%
      mutate(
        
        # Número previsto
        Previsto = previsto,
        
        # Percentual em relação ao previsto
        Percentual = round(
          (Count / Previsto) * 100,
          1
        ),
        
        # Número da sessão
        Sessao_num = as.numeric(
          gsub(
            "Sessao_",
            "",
            Sessoes
          )
        )
        
      ) %>%
      arrange(
        Sessao_num
      ) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = Sessoes
        )
      ) %>%
      select(
        -Sessao_num
      )
    
    
    df_agg
    
  })
  
  
  # ==========================================================
  # Gráfico - Presenças por Sessão
  # ==========================================================
  
  output$grafico_feira_beira <- renderPlotly({
    
    df_agg <- dados_plot_feira_beira()
    
    # --------------------------------------------------------
    # Sem dados
    # --------------------------------------------------------
    
    if (nrow(df_agg) == 0) {
      return(NULL)
    }
    
    
    previsto <- unique(
      df_agg$Previsto
    )[1]
    
    
    # --------------------------------------------------------
    # Limite superior do eixo Y
    # --------------------------------------------------------
    
    limite_y <- max(
      c(
        df_agg$Count,
        previsto
      ),
      na.rm = TRUE
    ) + 7
    
    
    # --------------------------------------------------------
    # Gráfico
    # --------------------------------------------------------
    
    g <- ggplot(
      df_agg,
      aes(
        x = Sessoes,
        y = Count,
        fill = Sessoes
      )
    ) +
      
      geom_col() +
      
      
      # ------------------------------------------------------
    # Linha do previsto
    # ------------------------------------------------------
    
    geom_hline(
      yintercept = previsto,
      linetype = "dashed",
      color = "purple",
      linewidth = 1.1
    ) +
      
      
      # ------------------------------------------------------
    # Valores nas barras
    # ------------------------------------------------------
    
    geom_text(
      aes(
        label = paste0(
          Count,
          "\n(",
          Percentual,
          "%)"
        ),
        text = paste0(
          "<b>",
          Sessoes,
          "</b>",
          "<br>Presenças: ",
          Count,
          "<br>Previsto: ",
          previsto,
          "<br>Percentual: ",
          Percentual,
          "%"
        )
      ),
      vjust = -0.2,
      color = "black",
      size = 4,
      fontface = "bold"
    ) +
      
      
      theme_stata() +
      
      
      scale_y_continuous(
        limits = c(
          0,
          limite_y
        )
      ) +
      
      
      labs(
        x = "",
        y = "Presenças",
        title = "Presenças por Sessão - Feiras_Beira"
      )
    
    
    # --------------------------------------------------------
    # Plotly
    # --------------------------------------------------------
    
    ggplotly(
      g,
      tooltip = "text"
    ) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  # ==========================================================
  # Texto automático
  # ==========================================================
  
  output$texto_feira_beira <- renderUI({
    
    df <- dados_plot_feira_beira()
    
    if (nrow(df) == 0) {
      return(NULL)
    }
    
    
    maior <- df %>%
      arrange(
        desc(Count)
      ) %>%
      slice(1)
    
    
    HTML(
      paste0(
        "<b>Resumo:</b> A sessão com maior participação foi ",
        maior$Sessoes,
        " com ",
        maior$Count,
        " participantes (",
        maior$Percentual,
        "% do previsto)."
      )
    )
    
  })
  
  
  # ==========================================================
  # Tabela - Feiras_Beira
  # ==========================================================
  
  output$tabela_feira_beira <- renderDataTable({
    
    df <- dados_filtrados_feira_beira()
    
    
    # --------------------------------------------------------
    # Identificar colunas de sessões
    # --------------------------------------------------------
    
    col_sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    # --------------------------------------------------------
    # Ordenar sessões numericamente
    # --------------------------------------------------------
    
    col_sessoes_ordenadas <- col_sessoes[
      order(
        as.numeric(
          gsub(
            "Sessao_",
            "",
            col_sessoes
          )
        )
      )
    ]
    
    
    # --------------------------------------------------------
    # Colunas fixas
    # --------------------------------------------------------
    
    col_fixas <- setdiff(
      names(df),
      col_sessoes
    )
    
    
    # --------------------------------------------------------
    # Reorganizar tabela
    # --------------------------------------------------------
    
    df <- df[
      ,
      c(
        col_fixas,
        col_sessoes_ordenadas
      )
    ]
    
    
    # --------------------------------------------------------
    # Formatar sessões
    # --------------------------------------------------------
    
    if (length(col_sessoes_ordenadas) > 0) {
      
      df[col_sessoes_ordenadas] <- lapply(
        df[col_sessoes_ordenadas],
        formatar_pontos
      )
      
    }
    
    
    # --------------------------------------------------------
    # DataTable
    # --------------------------------------------------------
    
    datatable(
      df,
      escape = FALSE,
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
    
  })
  
  
  # ==========================================================
  # FINANCEIRO BEIRA
  # ==========================================================

  
  observeEvent(
    input$Pesquisador_beira,
    {
      
      df <- Financeiro_Beira
      
      # --------------------------------------------------------
      # FILTRAR PELO PESQUISADOR
      # --------------------------------------------------------
      
      if (
        !is.null(input$Pesquisador_beira) &&
        input$Pesquisador_beira != "Todos"
      ) {
        
        df <- df %>%
          filter(
            Nome_do_pesquisador ==
              input$Pesquisador_beira
          )
        
      }
      
      
      # --------------------------------------------------------
      # LISTA DE EMPREENDEDORAS
      # --------------------------------------------------------
      
      empreendedoras <- df %>%
        filter(
          !is.na(Nome_Empreendedora),
          Nome_Empreendedora != ""
        ) %>%
        distinct(
          Nome_Empreendedora
        ) %>%
        arrange(
          Nome_Empreendedora
        ) %>%
        pull(
          Nome_Empreendedora
        )
      
      
      # --------------------------------------------------------
      # ATUALIZAR SELECT
      # --------------------------------------------------------
      
      updateSelectInput(
        session,
        "Nome_Empreendedora_beira",
        
        choices = c(
          "Todas",
          empreendedoras
        ),
        
        selected = "Todas"
      )
      
    }
  )
  
  
  
  # ==========================================================
  # BASE FINANCEIRA FILTRADA - BEIRA
  # ==========================================================
  
  df_financeiro_beira <- reactive({
    
    df <- Financeiro_Beira
    
    
    # --------------------------------------------------------
    # FILTRO PESQUISADOR
    # --------------------------------------------------------
    
    if (
      !is.null(input$Pesquisador_beira) &&
      input$Pesquisador_beira != "Todos"
    ) {
      
      df <- df %>%
        filter(
          Nome_do_pesquisador ==
            input$Pesquisador_beira
        )
      
    }
    
    
    # --------------------------------------------------------
    # FILTRO EMPREENDEDORA
    # --------------------------------------------------------
    
    if (
      !is.null(input$Nome_Empreendedora_beira) &&
      input$Nome_Empreendedora_beira != "Todas"
    ) {
      
      df <- df %>%
        filter(
          Nome_Empreendedora ==
            input$Nome_Empreendedora_beira
        )
      
    }
    
    
    # --------------------------------------------------------
    # FILTRO PERÍODO
    # --------------------------------------------------------
    
    if (
      !is.null(input$Mes_beira) &&
      input$Mes_beira != "Todos"
    ) {
      
      df <- df %>%
        filter(
          Periodo ==
            input$Mes_beira
        )
      
    }
    
    
    df
    
  })
  
  
  
  # ==========================================================
  # VALUE BOX 1 - EMPREENDEDORAS
  # ==========================================================
  
  output$vb_emp_beira <- renderUI({
    
    df <- df_financeiro_beira()
    
    total_emp <- df %>%
      filter(
        !is.na(Nome_Empreendedora),
        Nome_Empreendedora != ""
      ) %>%
      summarise(
        total = n_distinct(
          Nome_Empreendedora
        )
      ) %>%
      pull(total)
    
    
    div(
      class = "value-box purple",
      
      div(
        class = "value-number",
        
        scales::comma(
          total_emp
        )
        
      ),
      
      div(
        class = "value-title",
        "Empreendedoras"
      )
      
    )
    
  })
  
  
  
  # ==========================================================
  # VALUE BOX 2 - LUCRO
  # ==========================================================
  
  output$vb_lucro_beira <- renderUI({
    
    df <- df_financeiro_beira()
    
    lucro <- sum(
      df$Lucro_Semanal,
      na.rm = TRUE
    )
    
    
    div(
      class = "value-box blue",
      
      div(
        class = "value-number",
        
        scales::comma(
          round(
            lucro,
            0
          )
        )
        
      ),
      
      div(
        class = "value-title",
        "Lucro (MT)"
      )
      
    )
    
  })
  
  
  
  # ==========================================================
  # VALUE BOX 3 - RENDIMENTO
  # ==========================================================
  
  output$vb_rendimento_beira <- renderUI({
    
    df <- df_financeiro_beira()
    
    rendimento <- sum(
      df$Rendimento,
      na.rm = TRUE
    )
    
    
    div(
      class = "value-box green",
      
      div(
        class = "value-number",
        
        scales::comma(
          round(
            rendimento,
            0
          )
        )
        
      ),
      
      div(
        class = "value-title",
        "Rendimento (MT)"
      )
      
    )
    
  })
  
  
  
  # ==========================================================
  # VALUE BOX 4 - CUSTOS
  # ==========================================================
  
  output$vb_custos_beira <- renderUI({
    
    df <- df_financeiro_beira()
    
    
    custo_operacional <- sum(
      df$Custo_Operacional,
      na.rm = TRUE
    )
    
    
    custo_produtos <- sum(
      df$Custo_de_produtos_Servicos,
      na.rm = TRUE
    )
    
    
    custos <- custo_operacional +
      custo_produtos
    
    
    div(
      class = "value-box orange",
      
      div(
        class = "value-number",
        
        scales::comma(
          round(
            custos,
            0
          )
        )
        
      ),
      
      div(
        class = "value-title",
        "Custos (MT)"
      )
      
    )
    
  })
  
  # ==========================================================
  # GRÁFICO - RESUMO FINANCEIRO BEIRA
  # ==========================================================
  
  output$cidade_plot_beira <- renderPlotly({
    
    df <- df_financeiro_beira()
    
    
    # ========================================================
    # RESUMO
    # ========================================================
    
    resumo <- data.frame(
      
      Indicador = as.character(
        c(
          "Lucro",
          "Rendimento",
          "Custos"
        )
      ),
      
      Valor = as.numeric(
        c(
          
          sum(
            df$Lucro_Semanal,
            na.rm = TRUE
          ),
          
          sum(
            df$Rendimento,
            na.rm = TRUE
          ),
          
          sum(
            df$Custo_Operacional,
            na.rm = TRUE
          ) +
            
            sum(
              df$Custo_de_produtos_Servicos,
              na.rm = TRUE
            )
          
        )
      ),
      
      stringsAsFactors = FALSE
      
    )

    g <- ggplot(
      resumo,
      aes(
        x = Indicador,
        y = Valor,
        fill = Indicador
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = scales::comma(
            round(
              Valor,
              0
            )
          )
        ),
        vjust = -0.3,
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Lucro" = "#8054A2",
          "Rendimento" = "#f9a825",
          "Custos" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Valores (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(
            0.05,
            0.20
          )
        )
      ) +
      
      theme_stata(
        base_size = 14
      ) +
      
      theme(
        legend.position = "none",
        
        panel.grid.major.x =
          element_blank(),
        
        panel.grid.minor =
          element_blank(),
        
        panel.grid.major.y =
          element_line(
            color = "#E0E0E0"
          ),
        
        axis.text =
          element_text(
            color = "#333333"
          ),
        
        axis.title =
          element_text(
            face = "bold"
          )
      )
    
    
    # ========================================================
    # PLOTLY
    # ========================================================
    
    ggplotly(
      g,
      tooltip = c(
        "x",
        "y"
      )
    ) %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
    
  })
  
  
  ####################### ABA SEMANAL

  # ============================================================
  # FILTROS FINANCEIROS - BEIRA
  # ============================================================
  
  df_financeiro_beira <- reactive({
    
    dados <- Financeiro_Beira
    
    # ----------------------------------------------------------
    # Filtro Pesquisador
    # ----------------------------------------------------------
    
    if (!is.null(input$Pesquisador_beira) &&
        input$Pesquisador_beira != "Todos") {
      
      dados <- dados %>%
        filter(
          Nome_do_pesquisador == input$Pesquisador_beira
        )
    }
    
    
    # ----------------------------------------------------------
    # Filtro Empreendedora
    # ----------------------------------------------------------
    
    if (!is.null(input$Nome_Empreendedora_beira) &&
        input$Nome_Empreendedora_beira != "Todas") {
      
      dados <- dados %>%
        filter(
          Nome_Empreendedora == input$Nome_Empreendedora_beira
        )
    }
    
    
    # ----------------------------------------------------------
    # Filtro Mês
    # ----------------------------------------------------------
    
    if (!is.null(input$Mes_beira) &&
        input$Mes_beira != "Todos") {
      
      dados <- dados %>%
        filter(
          Periodo == input$Mes_beira
        )
    }
    
    
    dados
  })
  
  
  # ============================================================
  # BASE SEMANAL - BEIRA
  # ============================================================
  
  df_semana_beira <- reactive({
    
    df_financeiro_beira() %>%
      
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
  
  
  # ============================================================
  # GRÁFICO EVOLUÇÃO SEMANAL DO LUCRO - BEIRA
  # ============================================================
  
  output$grafico_financeiro_beira <- renderPlotly({
    
    df_plot <- df_semana_beira() %>%
      
      group_by(Semanas) %>%
      
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      filter(!is.na(Semanas))
    
    
    # Evitar erro sem dados
    
    if (nrow(df_plot) == 0) {
      return(NULL)
    }
    
    
    desloc <- max(
      abs(df_plot$Lucro),
      na.rm = TRUE
    ) * 0.08
    
    
    # Evitar deslocamento igual a zero
    
    if (is.na(desloc) || desloc == 0) {
      desloc <- 1
    }
    
    
    g <- ggplot(
      df_plot,
      aes(
        x = Semanas,
        y = Lucro,
        group = 1
      )
    ) +
      
      geom_area(
        fill = "#8054A2",
        alpha = 0.15
      ) +
      
      geom_line(
        color = "#8054A2",
        linewidth = 1.3
      ) +
      
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      geom_text(
        aes(
          y = Lucro + desloc,
          label = scales::comma(
            round(Lucro, 0)
          )
        ),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(
        x = "",
        y = "Lucro (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(0.05, 0.25)
        )
      ) +
      
      theme_minimal(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        ),
        axis.text = element_text(
          color = "#333333"
        ),
        axis.title = element_text(
          face = "bold"
        )
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # GRÁFICO BARRAS SEMANAIS - BEIRA
  # ============================================================
  
  output$grafico_barras_semanas_beira <- renderPlotly({
    
    df_plot <- df_semana_beira() %>%
      
      group_by(Semanas) %>%
      
      summarise(
        
        # Lucro = Rendimento - custos
        
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        
        # Rendimento bruto
        
        Rendimento = sum(
          Rendimento,
          na.rm = TRUE
        ),
        
        # Custo operacional
        
        Custo_Operacional = sum(
          Custo_Operacional,
          na.rm = TRUE
        ),
        
        # Custo dos produtos/serviços
        
        Custo_Produto = sum(
          Custo_de_produtos_Servicos,
          na.rm = TRUE
        ),
        
        .groups = "drop"
      ) %>%
      
      filter(!is.na(Semanas))
    
    
    df_long <- df_plot %>%
      
      tidyr::pivot_longer(
        cols = c(
          Lucro,
          Rendimento,
          Custo_Operacional,
          Custo_Produto
        ),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    
    dodge <- position_dodge(
      width = 0.8
    )
    
    
    p <- ggplot(
      df_long,
      aes(
        x = Semanas,
        y = Valor,
        fill = Indicador
      )
    ) +
      
      geom_col(
        position = dodge,
        width = 0.7
      ) +
      
      geom_text(
        aes(
          label = scales::comma(
            round(Valor, 0)
          )
        ),
        position = dodge,
        vjust = -0.3,
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
      
      theme_stata(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        )
      )
    
    
    ggplotly(p) %>%
      layout(
        barmode = "group",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # GRÁFICO MENSAL - BEIRA
  # ============================================================
  
  output$grafico_mensal_beira <- renderPlotly({
    
    df_plot <- df_financeiro_beira() %>%
      
      group_by(Periodo) %>%
      
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(Periodo) %>%
      
      filter(!is.na(Periodo))
    
    
    if (nrow(df_plot) == 0) {
      return(NULL)
    }
    
    
    desloc <- max(
      abs(df_plot$Lucro),
      na.rm = TRUE
    ) * 0.08
    
    
    if (is.na(desloc) || desloc == 0) {
      desloc <- 1
    }
    
    
    g <- ggplot(
      df_plot,
      aes(
        x = Periodo,
        y = Lucro,
        group = 1
      )
    ) +
      
      geom_area(
        fill = "#8054A2",
        alpha = 0.15
      ) +
      
      geom_line(
        color = "#8054A2",
        linewidth = 1.3
      ) +
      
      geom_point(
        color = "#8054A2",
        fill = "white",
        shape = 21,
        size = 4,
        stroke = 1.2
      ) +
      
      geom_text(
        aes(
          y = Lucro + desloc,
          label = scales::comma(
            round(Lucro, 0)
          )
        ),
        color = "#8054A2",
        fontface = "bold",
        size = 4
      ) +
      
      labs(
        x = "",
        y = "Lucro (MT)"
      ) +
      
      scale_y_continuous(
        labels = scales::comma,
        expand = expansion(
          mult = c(0.05, 0.25)
        )
      ) +
      
      theme_minimal(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        ),
        axis.text = element_text(
          color = "#333333"
        ),
        axis.title = element_text(
          face = "bold"
        )
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  output$leitura_grafico_mensal_beira <- renderUI({
    
    df <- df_financeiro_beira()
    
    req(nrow(df) > 0)
    
    # ============================================================
    # CALCULAR LUCRO TOTAL POR MÊS
    # ============================================================
    
    df_mensal <- df %>%
      group_by(Periodo) %>%
      summarise(
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      arrange(Periodo)
    
    
    req(nrow(df_mensal) > 0)
    
    
    # ============================================================
    # GARANTIR OS MESES
    # ============================================================
    
    meses <- c(
      "Primeiro Mês",
      "Segundo Mês",
      "Terceiro Mês"
    )
    
    lucro <- setNames(
      rep(NA_real_, length(meses)),
      meses
    )
    
    lucro[as.character(df_mensal$Periodo)] <- df_mensal$Lucro
    
    m1 <- lucro["Primeiro Mês"]
    m2 <- lucro["Segundo Mês"]
    m3 <- lucro["Terceiro Mês"]
    
    
    # ============================================================
    # VARIAÇÕES
    # ============================================================
    
    var_1_2 <- if (
      !is.na(m1) &&
      !is.na(m2) &&
      m1 != 0
    ) {
      ((m2 - m1) / abs(m1)) * 100
    } else {
      NA_real_
    }
    
    
    var_2_3 <- if (
      !is.na(m2) &&
      !is.na(m3) &&
      m2 != 0
    ) {
      ((m3 - m2) / abs(m2)) * 100
    } else {
      NA_real_
    }
    
    
    var_1_3 <- if (
      !is.na(m1) &&
      !is.na(m3) &&
      m1 != 0
    ) {
      ((m3 - m1) / abs(m1)) * 100
    } else {
      NA_real_
    }
    
    
    # ============================================================
    # MAIOR E MENOR LUCRO
    # ============================================================
    
    df_valid <- df_mensal %>%
      filter(!is.na(Lucro))
    
    
    maior <- df_valid %>%
      slice_max(
        Lucro,
        n = 1,
        with_ties = FALSE
      )
    
    
    menor <- df_valid %>%
      slice_min(
        Lucro,
        n = 1,
        with_ties = FALSE
      )
    
    
    # ============================================================
    # DETERMINAR TENDÊNCIA
    # ============================================================
    
    tendencia <- "estável"
    
    if (
      !is.na(m1) &&
      !is.na(m2) &&
      !is.na(m3)
    ) {
      
      if (
        m2 > m1 &&
        m3 > m2
      ) {
        
        tendencia <- "crescimento contínuo"
        
      } else if (
        m2 < m1 &&
        m3 < m2
      ) {
        
        tendencia <- "redução contínua"
        
      } else if (
        m2 > m1 &&
        m3 < m2
      ) {
        
        tendencia <- "crescimento inicial seguido de redução"
        
      } else if (
        m2 < m1 &&
        m3 > m2
      ) {
        
        tendencia <- "redução inicial seguida de recuperação"
      }
    }
    
    
    # ============================================================
    # INTERPRETAÇÃO DA PRIMEIRA VARIAÇÃO
    # ============================================================
    
    leitura_1_2 <- ""
    
    if (!is.na(var_1_2)) {
      
      if (var_1_2 > 0) {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro aumentou ",
          scales::number(
            var_1_2,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_1_2 < 0) {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro reduziu ",
          scales::number(
            abs(var_1_2),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_1_2 <- paste0(
          "Entre o Primeiro e o Segundo Mês, ",
          "o lucro manteve-se estável."
        )
      }
    }
    
    
    # ============================================================
    # INTERPRETAÇÃO DA SEGUNDA VARIAÇÃO
    # ============================================================
    
    leitura_2_3 <- ""
    
    if (!is.na(var_2_3)) {
      
      if (var_2_3 > 0) {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "registou-se um aumento de ",
          scales::number(
            var_2_3,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_2_3 < 0) {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "registou-se uma redução de ",
          scales::number(
            abs(var_2_3),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_2_3 <- paste0(
          "Do Segundo para o Terceiro Mês, ",
          "o lucro manteve-se estável."
        )
      }
    }
    
    
    # ============================================================
    # LEITURA DA TENDÊNCIA GERAL
    # ============================================================
    
    leitura_tendencia <- paste0(
      "No período analisado, observa-se uma tendência de ",
      tendencia,
      "."
    )
    
    
    # ============================================================
    # LEITURA DO MAIOR RESULTADO
    # ============================================================
    
    leitura_maior <- paste0(
      "O maior lucro foi registado no ",
      as.character(maior$Periodo),
      ", com ",
      scales::comma(
        round(maior$Lucro, 0)
      ),
      " MT."
    )
    
    
    # ============================================================
    # LEITURA DO MENOR RESULTADO
    # ============================================================
    
    leitura_menor <- paste0(
      "O menor lucro foi registado no ",
      as.character(menor$Periodo),
      ", com ",
      scales::comma(
        round(menor$Lucro, 0)
      ),
      " MT."
    )
    
    
    # ============================================================
    # LEITURA DA EVOLUÇÃO GLOBAL
    # ============================================================
    
    leitura_global <- ""
    
    if (!is.na(var_1_3)) {
      
      if (var_1_3 > 0) {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro acumulou um crescimento de ",
          scales::number(
            var_1_3,
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else if (var_1_3 < 0) {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro apresentou uma redução acumulada de ",
          scales::number(
            abs(var_1_3),
            accuracy = 0.1,
            decimal.mark = ","
          ),
          "%."
        )
        
      } else {
        
        leitura_global <- paste0(
          "Comparando o Primeiro com o Terceiro Mês, ",
          "o lucro manteve o mesmo nível."
        )
      }
    }
    
    
    # ============================================================
    # TEXTO FINAL
    # ============================================================
    
    texto <- paste0(
      
      "<strong>Dados sobre lucro:</strong> ",
      
      leitura_tendencia,
      " ",
      
      leitura_1_2,
      " ",
      
      leitura_2_3,
      " ",
      
      leitura_maior,
      " ",
      
      leitura_menor,
      " ",
      
      leitura_global
    )
    
    
    # ============================================================
    # APRESENTAÇÃO
    # ============================================================
    
    div(
      
      style = paste0(
        "background-color:#f5f3f4;",
        "border-left:5px solid #8054A2;",
        "padding:15px 20px;",
        "margin-top:10px;",
        "margin-bottom:15px;",
        "border-radius:5px;",
        "font-size:15px;",
        "line-height:1.6;",
        "color:#333333;"
      ),
      
      HTML(texto)
    )
  })
  
  # ============================================================
  # GRÁFICO MENSAL:
  # RENDIMENTO, CUSTOS E LUCRO - BEIRA
  # ============================================================
  
  output$grafico_barras_beira <- renderPlotly({
    
    df_plot <- df_financeiro_beira() %>%
      
      group_by(Periodo) %>%
      
      summarise(
        
        Lucro = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        
        Rendimento = sum(
          Rendimento,
          na.rm = TRUE
        ),
        
        Custo_Operacional = sum(
          Custo_Operacional,
          na.rm = TRUE
        ),
        
        Custo_Produto = sum(
          Custo_de_produtos_Servicos,
          na.rm = TRUE
        ),
        
        .groups = "drop"
      ) %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      arrange(Periodo)
    
    
    df_long <- df_plot %>%
      
      tidyr::pivot_longer(
        cols = c(
          Lucro,
          Rendimento,
          Custo_Operacional,
          Custo_Produto
        ),
        names_to = "Indicador",
        values_to = "Valor"
      )
    
    
    dodge <- position_dodge(
      width = 0.8
    )
    
    
    p <- ggplot(
      df_long,
      aes(
        x = Periodo,
        y = Valor,
        fill = Indicador
      )
    ) +
      
      geom_col(
        position = dodge,
        width = 0.7
      ) +
      
      geom_text(
        aes(
          label = scales::comma(
            round(Valor, 0)
          )
        ),
        position = dodge,
        vjust = -0.3,
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
      
      theme_stata(
        base_size = 14
      ) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(
          color = "#E0E0E0"
        )
      )
    
    
    ggplotly(p) %>%
      layout(
        barmode = "group",
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4"
      )
  })
  
  
  # ============================================================
  # TABELA CONTROLE DO LUCRO - BEIRA
  # ============================================================
  
  output$tabela_controle_lucro_beira <- renderDT({
    
    df <- df_financeiro_beira()
    
    req(nrow(df) > 0)
    
    
    # ----------------------------------------------------------
    # Agregar lucro por empreendedora e mês
    # ----------------------------------------------------------
    
    df <- df %>%
      
      group_by(
        Nome_do_pesquisador,
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      )
    
    
    # ----------------------------------------------------------
    # Transformar meses em colunas
    # ----------------------------------------------------------
    
    tabela <- df %>%
      
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    
    # ----------------------------------------------------------
    # Garantir existência das colunas
    # ----------------------------------------------------------
    
    if (!"Primeiro Mês" %in% names(tabela)) {
      tabela$`Primeiro Mês` <- 0
    }
    
    if (!"Segundo Mês" %in% names(tabela)) {
      tabela$`Segundo Mês` <- 0
    }
    
    if (!"Terceiro Mês" %in% names(tabela)) {
      tabela$`Terceiro Mês` <- 0
    }
    
    
    # ----------------------------------------------------------
    # Média dos três meses
    # ----------------------------------------------------------
    
    tabela <- tabela %>%
      
      mutate(
        `Média por Participante` = rowMeans(
          cbind(
            `Primeiro Mês`,
            `Segundo Mês`,
            `Terceiro Mês`
          ),
          na.rm = TRUE
        )
      )
    
    
    # ----------------------------------------------------------
    # Comparações
    # ----------------------------------------------------------
    
    tabela <- tabela %>%
      
      mutate(
        
        `1º para 2º Mês` = case_when(
          `Segundo Mês` > `Primeiro Mês` ~ "Aumentou",
          `Segundo Mês` == `Primeiro Mês` ~ "Manteve",
          TRUE ~ "Reduziu"
        ),
        
        `2º para 3º Mês` = case_when(
          `Terceiro Mês` > `Segundo Mês` ~ "Aumentou",
          `Terceiro Mês` == `Segundo Mês` ~ "Manteve",
          TRUE ~ "Reduziu"
        ),
        
        Prioridade = case_when(
          `2º para 3º Mês` == "Reduziu" ~ 1,
          `2º para 3º Mês` == "Manteve" ~ 2,
          TRUE ~ 3
        )
      ) %>%
      
      arrange(Prioridade) %>%
      
      select(
        -Prioridade
      )
    
    
    # ----------------------------------------------------------
    # Tabela
    # ----------------------------------------------------------
    
    datatable(
      tabela,
      rownames = FALSE,
      options = list(
        pageLength = 15,
        scrollX = TRUE
      )
    ) %>%
      
      formatRound(
        columns = c(
          "Primeiro Mês",
          "Segundo Mês",
          "Terceiro Mês",
          "Média por Participante"
        ),
        digits = 2
      ) %>%
      
      formatStyle(
        "1º para 2º Mês",
        backgroundColor = styleEqual(
          c(
            "Aumentou",
            "Manteve",
            "Reduziu"
          ),
          c(
            "#8054A2",
            "#f9a825",
            "#69C7BE"
          )
        ),
        color = "white",
        fontWeight = "bold"
      ) %>%
      
      formatStyle(
        "2º para 3º Mês",
        backgroundColor = styleEqual(
          c(
            "Aumentou",
            "Manteve",
            "Reduziu"
          ),
          c(
            "#8054A2",
            "#f9a825",
            "#69C7BE"
          )
        ),
        color = "white",
        fontWeight = "bold"
      )
  })
  
  
  # ============================================================
  # VALUE BOX:
  # PARTICIPANTES COM AUMENTO DE LUCRO
  # ============================================================
  
  output$vb_aumento_lucro_mes_1_2_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    if (!"Primeiro Mês" %in% names(df)) {
      df$`Primeiro Mês` <- 0
    }
    
    if (!"Segundo Mês" %in% names(df)) {
      df$`Segundo Mês` <- 0
    }
    
    valor <- sum(
      df$`Segundo Mês` > df$`Primeiro Mês`,
      na.rm = TRUE
    )
    
    div(
      class = "value-box blue",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumentaram o Lucro: 1º → 2º Mês"
      )
    )
  })
  
  output$vb_aumento_25_mes_1_2_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    if (!"Primeiro Mês" %in% names(df)) {
      df$`Primeiro Mês` <- 0
    }
    
    if (!"Segundo Mês" %in% names(df)) {
      df$`Segundo Mês` <- 0
    }
    
    df <- df %>%
      mutate(
        aumento_pct = case_when(
          `Primeiro Mês` > 0 ~
            (`Segundo Mês` - `Primeiro Mês`) /
            `Primeiro Mês` * 100,
          TRUE ~ NA_real_
        )
      )
    
    valor <- sum(
      df$aumento_pct >= 25,
      na.rm = TRUE
    )
    
    div(
      class = "value-box orange",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento ≥25%: 1º → 2º Mês"
      )
    )
  })
  
  output$vb_aumento_lucro_mes_2_3_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    if (!"Segundo Mês" %in% names(df)) {
      df$`Segundo Mês` <- 0
    }
    
    if (!"Terceiro Mês" %in% names(df)) {
      df$`Terceiro Mês` <- 0
    }
    
    valor <- sum(
      df$`Terceiro Mês` > df$`Segundo Mês`,
      na.rm = TRUE
    )
    
    div(
      class = "value-box blue",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumentaram o Lucro: 2º → 3º Mês"
      )
    )
  })
  
  output$vb_aumento_25_mes_2_3_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(
          Lucro_Semanal,
          na.rm = TRUE
        ),
        .groups = "drop"
      ) %>%
      mutate(
        Periodo = factor(
          Periodo,
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          )
        )
      ) %>%
      tidyr::pivot_wider(
        names_from = Periodo,
        values_from = Lucro_Mensal,
        values_fill = 0
      )
    
    if (!"Segundo Mês" %in% names(df)) {
      df$`Segundo Mês` <- 0
    }
    
    if (!"Terceiro Mês" %in% names(df)) {
      df$`Terceiro Mês` <- 0
    }
    
    df <- df %>%
      mutate(
        aumento_pct = case_when(
          `Segundo Mês` > 0 ~
            (`Terceiro Mês` - `Segundo Mês`) /
            `Segundo Mês` * 100,
          TRUE ~ NA_real_
        )
      )
    
    valor <- sum(
      df$aumento_pct >= 25,
      na.rm = TRUE
    )
    
    div(
      class = "value-box orange",
      
      span(
        class = "value-number",
        format(
          valor,
          big.mark = ","
        )
      ),
      
      span(
        class = "value-title",
        "Aumento ≥25%: 2º → 3º Mês"
      )
    )
  })
  
  
  ################### MATRIZ DOS INDICADORES
  
  # ============================================================
  # PAM VERDE — NAMPULA CICLO 3
  # MATRIZ TOC — 17 INDICADORES
  # ============================================================
  
  output$toc_matriz_indicadores <- DT::renderDT({
    
    # ----------------------------------------------------------
    # 1. FONTES DE DADOS
    # ----------------------------------------------------------
    
    if (!exists("PERFIL_PAM_VERDE_C3_2026")) {
      return(DT::datatable(
        data.frame(Mensagem = "Fonte PERFIL_PAM_VERDE_C3_2026 não encontrada."),
        rownames = FALSE
      ))
    }
    
    if (!exists("PAM_VERDE_TOC_C3")) {
      return(DT::datatable(
        data.frame(Mensagem = "Fonte PAM_VERDE_TOC_C3 não encontrada."),
        rownames = FALSE
      ))
    }
    
    perfil <- PERFIL_PAM_VERDE_C3_2026
    toc <- PAM_VERDE_TOC_C3
    
    if (exists("FINANCEIRO_TOC_NAMPULA")) {
      financeiro <- FINANCEIRO_TOC_NAMPULA
    } else if (exists("Financeiro_Nampula")) {
      financeiro <- Financeiro_Nampula
    } else {
      financeiro <- data.frame()
    }
    
    # ----------------------------------------------------------
    # 2. FUNÇÕES AUXILIARES
    # ----------------------------------------------------------
    
    normalizar <- function(x) {
      trimws(as.character(x))
    }
    
    calcular_percentagem <- function(
    dados, coluna, resposta, tipo
    ) {
      
      if (
        !coluna %in% names(dados) ||
        !"Tipo_Avaliacao" %in% names(dados)
      ) {
        return(NA_real_)
      }
      
      avaliacao <- tolower(normalizar(dados$Tipo_Avaliacao))
      valores <- normalizar(dados[[coluna]])
      
      validos <- !is.na(valores) &
        valores != "" &
        !is.na(avaliacao) &
        avaliacao == tolower(tipo)
      
      if (!any(validos)) return(NA_real_)
      
      100 * sum(valores[validos] %in% resposta) / sum(validos)
    }
    
    calcular_estado_formacao <- function(dados, estados) {
      
      if (!"Status" %in% names(dados)) return(NA_real_)
      
      status <- toupper(normalizar(dados$Status))
      validos <- !is.na(status) & status != ""
      
      if (!any(validos)) return(NA_real_)
      
      100 * sum(status %in% toupper(estados) & validos) /
        sum(validos)
    }
    
    formatar_numero <- function(x, casas = 1) {
      
      if (
        length(x) == 0 ||
        is.na(x) ||
        !is.finite(x)
      ) {
        return("—")
      }
      
      format(
        round(x, casas),
        big.mark = " ",
        decimal.mark = ",",
        nsmall = casas,
        trim = TRUE
      )
    }
    
    # ----------------------------------------------------------
    # 3. INÍCIO DA FORMAÇÃO — iVM1000
    # ----------------------------------------------------------
    
    inicio_formacao_EL <- calcular_estado_formacao(
      perfil,
      c(
        "Activa", "Activas", "Ativa", "Ativas",
        "Desistente", "Desistentes"
      )
    )
    
    # ----------------------------------------------------------
    # 4. CONCLUSÃO DA FORMAÇÃO — iVM1000
    # Numerador: participantes Activas
    # Denominador: Activas + Desistentes
    # ----------------------------------------------------------
    
    conclusao_formacao_EL <- NA_real_
    
    if ("Status" %in% names(perfil)) {
      
      status <- toupper(trimws(as.character(perfil$Status)))
      
      # Identificar participantes activas e desistentes
      activas <- status %in% c(
        "ACTIVA", "ACTIVAS",
        "ATIVA", "ATIVAS"
      )
      
      desistentes <- status %in% c(
        "DESISTENTE", "DESISTENTES"
      )
      
      # Denominador: participantes que iniciaram a formação
      iniciaram <- activas | desistentes
      
      total_iniciaram <- sum(iniciaram, na.rm = TRUE)
      
      # Calcular percentagem de conclusão
      if (total_iniciaram > 0) {
        
        conclusao_formacao_EL <- 100 *
          sum(activas, na.rm = TRUE) /
          total_iniciaram
        
      }
    }
    
    # ----------------------------------------------------------
    # 5. FORMALIZAÇÃO — iPAM_INT1.1
    # ----------------------------------------------------------
    
    formalizacao_BL <- calcular_percentagem(
      toc, "Negocio_Formalizado",
      "Iniciei o processo de formalização", "Baseline"
    )
    
    formalizacao_EL <- calcular_percentagem(
      toc, "Negocio_Formalizado",
      "Iniciei o processo de formalização", "Endline"
    )
    
    # ----------------------------------------------------------
    # 6. SALÁRIO MENSAL — iPAM_RI.2.4
    # ----------------------------------------------------------
    
    salario_BL <- calcular_percentagem(
      toc, "Tira_Salario_Para_Si",
      "Sim, retiro um valor fixo todos os meses", "Baseline"
    )
    
    salario_EL <- calcular_percentagem(
      toc, "Tira_Salario_Para_Si",
      "Sim, retiro um valor fixo todos os meses", "Endline"
    )
    
    # ----------------------------------------------------------
    # 7. TOMADA DE DECISÕES — OS1.1
    # ----------------------------------------------------------
    
    decisoes_BL <- calcular_percentagem(
      toc, "Quem_Toma_Decisoes_Negocio", "Só eu", "Baseline"
    )
    
    decisoes_EL <- calcular_percentagem(
      toc, "Quem_Toma_Decisoes_Negocio", "Só eu", "Endline"
    )
    
    # ----------------------------------------------------------
    # 8. NEGOCIAÇÃO COM CLIENTES — iPAM_RI.2.6
    # ----------------------------------------------------------
    
    resposta_clientes <-
      "Sim, sinto-me confiante e sei defender a minha posição"
    
    negociacao_clientes_BL <- calcular_percentagem(
      toc, "Negociacao_Com_Clientes",
      resposta_clientes, "Baseline"
    )
    
    negociacao_clientes_EL <- calcular_percentagem(
      toc, "Negociacao_Com_Clientes",
      resposta_clientes, "Endline"
    )
    
    # ----------------------------------------------------------
    # 9. NEGOCIAÇÃO NOS ÚLTIMOS 3 MESES — iPAM_RI.5.1
    # ----------------------------------------------------------
    
    coluna_negociacao_3meses <-
      "Praticou_negociação_nos_últimos_3meses"
    
    resposta_3meses <-
      "Sim, negociei e consegui um acordo favorável para o meu negócio"
    
    negociacao_3meses_BL <- calcular_percentagem(
      toc, coluna_negociacao_3meses,
      resposta_3meses, "Baseline"
    )
    
    negociacao_3meses_EL <- calcular_percentagem(
      toc, coluna_negociacao_3meses,
      resposta_3meses, "Endline"
    )
    
    # ----------------------------------------------------------
    # 10. FERRAMENTAS DE IA — iPAM_RI.3.1
    # ----------------------------------------------------------
    
    respostas_ia <- c(
      "Sim, usei pelo menos uma vez",
      "Sim, uso regularmente para o negócio"
    )
    
    uso_ia_BL <- calcular_percentagem(
      toc, "Uso_de_ferramentas_de_IA",
      respostas_ia, "Baseline"
    )
    
    uso_ia_EL <- calcular_percentagem(
      toc, "Uso_de_ferramentas_de_IA",
      respostas_ia, "Endline"
    )
    
    # ----------------------------------------------------------
    # 11. SEPARAÇÃO DAS CONTAS — iPAM_RI.2.2.b
    # ----------------------------------------------------------
    
    coluna_contas <-
      "Faz separação das contas pessoais e do negócio"
    
    contas_BL <- calcular_percentagem(
      toc, coluna_contas, "Sim", "Baseline"
    )
    
    contas_EL <- calcular_percentagem(
      toc, coluna_contas, "Sim", "Endline"
    )
    
    # ----------------------------------------------------------
    # 12. CÁLCULO DO LUCRO — iPAM_RI.4.1
    # ----------------------------------------------------------
    
    coluna_calculo_lucro <-
      "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    
    calculo_lucro_BL <- calcular_percentagem(
      toc, coluna_calculo_lucro, "Sim", "Baseline"
    )
    
    calculo_lucro_EL <- calcular_percentagem(
      toc, coluna_calculo_lucro, "Sim", "Endline"
    )
    
    # ----------------------------------------------------------
    # 13. CONTROLO DO DINHEIRO — iPAM_RI.2.2.a
    # ----------------------------------------------------------
    
    coluna_controlo <-
      "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    
    controlo_BL <- calcular_percentagem(
      toc, coluna_controlo, "Sim", "Baseline"
    )
    
    controlo_EL <- calcular_percentagem(
      toc, coluna_controlo, "Sim", "Endline"
    )
    
    # ----------------------------------------------------------
    # 14. ACTIVIDADES DE GÉNERO — iPAM_RI.4.2
    # ----------------------------------------------------------
    
    coluna_genero <- paste0(
      "Até que ponto as actividades ligadas à questão de género ",
      "ajudaram a compreender as desigualdades entre homens e mulheres?"
    )
    
    genero_EL <- calcular_percentagem(
      toc, coluna_genero,
      "Ajudaram bastante / mudaram a minha compreensão",
      "Endline"
    )
    
    
    # ----------------------------------------------------------
    # 15. NOVOS SERVIÇOS FINANCEIROS — iPAM_RI.7.3
    # BASELINE VS ENDLINE POR EMPREENDEDORA
    # ----------------------------------------------------------
    
    servicos_financeiros_percentual_EL <- NA_real_
    servicos_financeiros_novos <- 0L
    servicos_financeiros_validos <- 0L
    
    # Lista fixa dos serviços financeiros considerados no indicador
    lista_servicos_financeiros <- c(
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    )
    
    # Verificar se existem as colunas necessárias
    colunas_necessarias <- c(
      "ID_Participante",
      "Tipo_Avaliacao",
      "Uso_Servicos_Financeiros"
    )
    
    if (all(colunas_necessarias %in% names(toc))) {
      
      # --------------------------------------------------------
      # 15.1. Preparar as respostas
      # --------------------------------------------------------
      
      servicos <- toc |>
        dplyr::transmute(
          ID = trimws(as.character(ID_Participante)),
          Tipo = tolower(trimws(as.character(Tipo_Avaliacao))),
          Resposta = trimws(as.character(Uso_Servicos_Financeiros))
        ) |>
        dplyr::filter(
          !is.na(ID),
          ID != "",
          Tipo %in% c("baseline", "endline")
        ) |>
        dplyr::group_by(ID, Tipo) |>
        dplyr::summarise(
          Resposta = {
            x <- unique(Resposta[!is.na(Resposta) & trimws(Resposta) != ""])
            if (length(x) == 0) NA_character_ else paste(x, collapse = " | ")
          },
          .groups = "drop"
        )
      
      # --------------------------------------------------------
      # 15.2. Separar Baseline e Endline
      # --------------------------------------------------------
      
      baseline <- servicos |>
        dplyr::filter(Tipo == "baseline") |>
        dplyr::transmute(
          ID,
          Resposta_BL = Resposta
        )
      
      endline <- servicos |>
        dplyr::filter(Tipo == "endline") |>
        dplyr::transmute(
          ID,
          Resposta_EL = Resposta
        )
      
      # Considerar apenas participantes presentes nas duas avaliações
      comparacao <- dplyr::inner_join(
        baseline,
        endline,
        by = "ID"
      )
      
      # --------------------------------------------------------
      # 15.3. Validar as respostas das duas avaliações
      # --------------------------------------------------------
      
      if (nrow(comparacao) > 0) {
        
        comparacao <- comparacao |>
          dplyr::filter(
            !is.na(Resposta_BL),
            trimws(Resposta_BL) != "",
            !is.na(Resposta_EL),
            trimws(Resposta_EL) != ""
          )
        
      }
      
      # --------------------------------------------------------
      # 15.4. Identificar a utilização de cada serviço
      # 1 = utiliza; 0 = não utiliza
      # --------------------------------------------------------
      
      if (nrow(comparacao) > 0) {
        
        for (i in seq_along(lista_servicos_financeiros)) {
          
          servico <- lista_servicos_financeiros[i]
          
          # Verificar cada serviço no Baseline
          comparacao[[paste0("BL_", i)]] <- as.integer(
            grepl(
              servico,
              comparacao$Resposta_BL,
              fixed = TRUE,
              ignore.case = TRUE
            )
          )
          
          # Verificar cada serviço no Endline
          comparacao[[paste0("EL_", i)]] <- as.integer(
            grepl(
              servico,
              comparacao$Resposta_EL,
              fixed = TRUE,
              ignore.case = TRUE
            )
          )
        }
        
        # ------------------------------------------------------
        # 15.5. Contar novos serviços por empreendedora
        # ------------------------------------------------------
        
        colunas_BL <- paste0("BL_", seq_along(lista_servicos_financeiros))
        colunas_EL <- paste0("EL_", seq_along(lista_servicos_financeiros))
        
        # Novo serviço: Baseline = 0 e Endline = 1
        matriz_BL <- as.matrix(comparacao[, colunas_BL, drop = FALSE])
        matriz_EL <- as.matrix(comparacao[, colunas_EL, drop = FALSE])
        
        novos_por_servico <- (matriz_BL == 0L) & (matriz_EL == 1L)
        
        # Número de serviços novos por participante
        comparacao$Novos_Servicos <- rowSums(novos_por_servico)
        
        # Indicador binário: começou a utilizar pelo menos um serviço novo
        comparacao$Novo_Servico <- comparacao$Novos_Servicos > 0
        
        # ------------------------------------------------------
        # 15.6. Calcular o indicador iPAM_RI.7.3
        # ------------------------------------------------------
        
        servicos_financeiros_validos <- nrow(comparacao)
        
        servicos_financeiros_novos <- sum(
          comparacao$Novo_Servico,
          na.rm = TRUE
        )
        
        if (servicos_financeiros_validos > 0) {
          
          servicos_financeiros_percentual_EL <-
            (servicos_financeiros_novos /
               servicos_financeiros_validos) * 100
          
        }
        
      }
    }
    
    
    # ----------------------------------------------------------
    # 16. INDICADORES FINANCEIROS
    # ----------------------------------------------------------
    
    lucro_aumentou_EL <- NA_real_
    lucro_mais_25_EL <- NA_real_
    aumento_medio_lucro_EL <- NA_real_
    saldo_liquido_lucro_EL <- NA_real_
    
    colunas_financeiras <- c(
      "Nome_Empreendedora",
      "Periodo",
      "Lucro_Semanal"
    )
    
    if (
      nrow(financeiro) > 0 &&
      all(colunas_financeiras %in% names(financeiro))
    ) {
      
      financeiro_tratado <- financeiro |>
        dplyr::mutate(
          Nome_Empreendedora = trimws(
            as.character(Nome_Empreendedora)
          ),
          Periodo = trimws(as.character(Periodo)),
          Lucro_Semanal = suppressWarnings(
            as.numeric(as.character(Lucro_Semanal))
          )
        ) |>
        dplyr::filter(
          !is.na(Nome_Empreendedora),
          Nome_Empreendedora != "",
          Periodo %in% c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          ),
          !is.na(Lucro_Semanal)
        )
      
      lucro_periodo <- financeiro_tratado |>
        dplyr::group_by(Nome_Empreendedora, Periodo) |>
        dplyr::summarise(
          Lucro = sum(Lucro_Semanal, na.rm = TRUE),
          .groups = "drop"
        )
      
      comparacao_lucro <- lucro_periodo |>
        tidyr::pivot_wider(
          names_from = Periodo,
          values_from = Lucro
        )
      
      if (all(c("Primeiro Mês", "Terceiro Mês") %in%
              names(comparacao_lucro))) {
        
        comparacao_lucro <- comparacao_lucro |>
          dplyr::filter(
            !is.na(`Primeiro Mês`),
            !is.na(`Terceiro Mês`)
          ) |>
          dplyr::mutate(
            Aumento_Lucro = `Terceiro Mês` - `Primeiro Mês`,
            Percentual_Aumento = dplyr::if_else(
              `Primeiro Mês` > 0,
              Aumento_Lucro / `Primeiro Mês` * 100,
              NA_real_
            )
          )
        
        base_percentual <- comparacao_lucro |>
          dplyr::filter(!is.na(Percentual_Aumento))
        
        if (nrow(base_percentual) > 0) {
          
          lucro_aumentou_EL <- mean(
            base_percentual$Percentual_Aumento > 0
          ) * 100
          
          lucro_mais_25_EL <- mean(
            base_percentual$Percentual_Aumento >= 25
          ) * 100
        }
        
        aumentos <- comparacao_lucro$Aumento_Lucro
        aumentos <- aumentos[!is.na(aumentos)]
        
        if (length(aumentos) > 0) {
          aumento_medio_lucro_EL <- mean(aumentos)
          saldo_liquido_lucro_EL <- sum(aumentos)
        }
      }
    }
    
    # ----------------------------------------------------------
    # 17. MATRIZ COM OS 17 INDICADORES
    # ----------------------------------------------------------
    
    indicadores_toc <- data.frame(
      
      ID_Indicador = c(
        "iVM1000",
        "iVM1000",
        "iPAM_INT1.1",
        "iPAM_RI.2.4",
        "OS1.1",
        "iPAM_RI.2.6",
        "iPAM_RI.5.1",
        "iPAM_RI.3.1",
        "iPAM_RI.2.2.b",
        "iPAM_RI.4.1",
        "iPAM_RI.2.2.a",
        "iPAM_RI.4.2",
        "iPAM_RI.7.3",
        "iPAM_RI.1.1",
        "iPAM_RI.1.2",
        "iPAM_RI.2.1",
        "iPAM_RI.1.3b"
      ),
      
      Indicador = c(
        "Participantes que iniciam a formação",
        "Participantes que completam a formação",
        "Empreendedoras que iniciam o processo de formalização",
        "Empreendedoras que definem um salário mensal para si mesmas",
        "Empreendedoras que tomam sozinhas as principais decisões do negócio",
        "Empreendedoras confiantes na negociação com clientes",
        "Empreendedoras que negociaram e conseguiram acordo favorável nos últimos 3 meses",
        "Empreendedoras que sabem utilizar ferramentas de IA",
        "Separa as contas pessoais das contas do negócio",
        "Sabe calcular o lucro do negócio",
        "Controla o dinheiro que entra e sai",
        "Actividades de género contribuíram para compreender desigualdades",
        "Empreendedoras que passaram a utilizar pelo menos um novo serviço financeiro",
        "Aumentou os lucros durante os 3 meses",
        "Aumentou o lucro em 25% ou mais",
        "Valor médio de aumento do lucro",
        "Saldo líquido do valor adicionado"
      ),
      
      Baseline = c(
        NA_real_, NA_real_,
        formalizacao_BL, salario_BL, decisoes_BL,
        negociacao_clientes_BL, negociacao_3meses_BL,
        uso_ia_BL, contas_BL, calculo_lucro_BL, controlo_BL,
        NA_real_, NA_real_, NA_real_, NA_real_, NA_real_, NA_real_
      ),
      
      Endline = c(
        inicio_formacao_EL,
        conclusao_formacao_EL,
        formalizacao_EL,
        salario_EL,
        decisoes_EL,
        negociacao_clientes_EL,
        negociacao_3meses_EL,
        uso_ia_EL,
        contas_EL,
        calculo_lucro_EL,
        controlo_EL,
        genero_EL,
        servicos_financeiros_percentual_EL,
        lucro_aumentou_EL,
        lucro_mais_25_EL,
        aumento_medio_lucro_EL,
        saldo_liquido_lucro_EL
      ),
      
      Meta_2026 = c(
        85, 80, 10, 50, 100, 70, 70, 80, 80,
        85, 80, 100, 40, 80, 50, 2500, 70000
      ),
      
      stringsAsFactors = FALSE
    )
    
    stopifnot(
      nrow(indicadores_toc) == 17,
      length(indicadores_toc$Baseline) == 17,
      length(indicadores_toc$Endline) == 17,
      length(indicadores_toc$Meta_2026) == 17
    )
    
    # ----------------------------------------------------------
    # 18. UNIDADES, VARIAÇÃO, ALCANCE E ESTADO
    # ----------------------------------------------------------
    
    indicadores_toc$Unidade <- ifelse(
      seq_len(nrow(indicadores_toc)) %in% c(16, 17),
      "MT",
      "%"
    )
    
    indicadores_toc <- indicadores_toc |>
      dplyr::mutate(
        Variação = dplyr::if_else(
          Unidade == "%" &
            !is.na(Baseline) &
            !is.na(Endline),
          Endline - Baseline,
          NA_real_
        ),
        
        Alcance_Numerico = dplyr::if_else(
          !is.na(Endline) &
            !is.na(Meta_2026) &
            Meta_2026 > 0,
          Endline / Meta_2026 * 100,
          NA_real_
        ),
        
        Estado = dplyr::case_when(
          is.na(Endline) ~ "Sem dados",
          is.na(Meta_2026) ~ "Sem meta",
          Endline >= Meta_2026 ~ "Meta alcançada",
          Endline >= Meta_2026 * 0.8 ~ "Próximo da meta",
          Endline >= Meta_2026 * 0.5 ~ "Em progresso",
          TRUE ~ "Abaixo da meta"
        )
      )
    
    # ----------------------------------------------------------
    # 19. FORMATAR VALORES E PREPARAR CÉLULAS VISUAIS
    # Estilo adaptado da matriz TOC de Beira — Ciclo 1
    # ----------------------------------------------------------
    
    formatar_indicador <- function(valor, unidade) {
      if (length(valor) == 0 || is.na(valor) || !is.finite(valor)) {
        return("—")
      }
      if (unidade == "%") {
        return(paste0(formatar_numero(valor, 1), "%"))
      }
      paste0(formatar_numero(valor, 2), " MT")
    }
    
    indicadores_toc$Baseline_Exibicao <- mapply(
      formatar_indicador, indicadores_toc$Baseline, indicadores_toc$Unidade
    )
    indicadores_toc$Endline_Exibicao <- mapply(
      formatar_indicador, indicadores_toc$Endline, indicadores_toc$Unidade
    )
    indicadores_toc$Meta_Exibicao <- mapply(
      formatar_indicador, indicadores_toc$Meta_2026, indicadores_toc$Unidade
    )
    
    indicadores_toc$Variacao_Exibicao <- vapply(
      seq_len(nrow(indicadores_toc)), function(i) {
        valor <- indicadores_toc$Variação[i]
        if (is.na(valor) || !is.finite(valor)) return("—")
        paste0(ifelse(valor > 0, "+", ""), formatar_numero(valor, 1), " p.p.")
      }, character(1)
    )
    
    indicadores_toc$Alcance_Exibicao <- vapply(
      indicadores_toc$Alcance_Numerico, function(x) {
        if (is.na(x) || !is.finite(x)) return("—")
        paste0(formatar_numero(x, 1), "%")
      }, character(1)
    )
    
    # ----------------------------------------------------------
    # 20. BOTÕES VISUAIS PARA VALORES
    # ----------------------------------------------------------
    
    botao_percentual <- function(valor, unidade = "%", texto = NULL) {
      if (is.null(texto)) texto <- formatar_indicador(valor, unidade)
      if (is.na(valor) || !is.finite(valor)) {
        return('<span class="toc-sem-medicao">—</span>')
      }
      
      if (unidade == "%") {
        intensidade <- max(0, min(100, valor)) / 100
        claro <- c(235, 224, 242)
        escuro <- c(128, 84, 162)
        rgb_cor <- round(claro + (escuro - claro) * intensidade)
        fundo <- sprintf("#%02X%02X%02X", rgb_cor[1], rgb_cor[2], rgb_cor[3])
        cor_texto <- if (intensidade >= 0.62) "#FFFFFF" else "#4B315B"
        return(sprintf(
          '<span class="toc-valor-botao" style="background-color:%s;color:%s;" title="%s">%s</span>',
          fundo, cor_texto, htmltools::htmlEscape(texto), htmltools::htmlEscape(texto)
        ))
      }
      
      sprintf('<span class="toc-valor-neutro">%s</span>', htmltools::htmlEscape(texto))
    }
    
    botao_estado <- function(estado) {
      if (is.na(estado) || estado == "") return('<span class="toc-sem-medicao">—</span>')
      estilos <- switch(
        estado,
        "Meta alcançada" = "background:#8054A2;color:#FFFFFF;",
        "Próximo da meta" = "background:#D9C6E5;color:#4B315B;",
        "Em progresso" = "background:#CDB8DB;color:#4B315B;",
        "Abaixo da meta" = "background:#E9DDF0;color:#4B315B;",
        "Sem dados" = "background:#F5F3F4;color:#666666;",
        "Sem meta" = "background:#EEEEEE;color:#666666;",
        "background:#EEEEEE;color:#666666;"
      )
      sprintf('<span class="toc-valor-botao" style="%s">%s</span>', estilos, htmltools::htmlEscape(estado))
    }
    
    tabela_final_toc <- data.frame(
      ID_Indicador = indicadores_toc$ID_Indicador,
      Indicador = indicadores_toc$Indicador,
      Baseline = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(indicadores_toc$Baseline[i], indicadores_toc$Unidade[i], indicadores_toc$Baseline_Exibicao[i])
      }, character(1)),
      Endline = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(indicadores_toc$Endline[i], indicadores_toc$Unidade[i], indicadores_toc$Endline_Exibicao[i])
      }, character(1)),
      Variação = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        valor <- indicadores_toc$Variação[i]
        if (is.na(valor) || !is.finite(valor)) return('<span class="toc-sem-medicao">—</span>')
        botao_percentual(indicadores_toc$Endline[i], indicadores_toc$Unidade[i], indicadores_toc$Variacao_Exibicao[i])
      }, character(1)),
      `Meta 2026` = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(indicadores_toc$Meta_2026[i], indicadores_toc$Unidade[i], indicadores_toc$Meta_Exibicao[i])
      }, character(1)),
      `Alcance da Meta` = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(indicadores_toc$Alcance_Numerico[i], "%", indicadores_toc$Alcance_Exibicao[i])
      }, character(1)),
      Estado = vapply(indicadores_toc$Estado, botao_estado, character(1)),
      check.names = FALSE,
      stringsAsFactors = FALSE
    )
    
    # ----------------------------------------------------------
    # 21. DATATABLE INTERACTIVA
    # ----------------------------------------------------------
    
    widget <- DT::datatable(
      tabela_final_toc,
      rownames = FALSE,
      extensions = c("Buttons", "FixedHeader"),
      options = list(
        pageLength = 17,
        lengthMenu = list(c(15, 16, 17, 25, 50, 100, -1), c("15", "16", "17", "25", "50", "100", "Todos")),
        scrollX = TRUE,
        scrollY = "65vh",
        scrollCollapse = TRUE,
        autoWidth = FALSE,
        fixedHeader = TRUE,
        dom = "Blfrtip",
        buttons = list(
          list(extend = "copy", text = "Copiar"),
          list(extend = "csv", text = "Exportar CSV"),
          list(extend = "excel", text = "Exportar Excel")
        ),
        columnDefs = list(
          list(targets = 0, width = "130px", className = "dt-center"),
          list(targets = 1, width = "420px", className = "dt-left"),
          list(targets = c(2, 3, 4, 5, 6), width = "145px", className = "dt-center"),
          list(targets = 7, width = "160px", className = "dt-center")
        ),
        language = list(
          search = "Pesquisar:",
          lengthMenu = "Mostrar _MENU_ indicadores",
          info = "A mostrar _START_ a _END_ de _TOTAL_ indicadores",
          infoEmpty = "Sem indicadores disponíveis",
          infoFiltered = "(filtrado de _MAX_ indicadores)",
          zeroRecords = "Nenhum indicador encontrado",
          emptyTable = "Sem dados disponíveis",
          paginate = list(first = "Primeiro", last = "Último", `next` = "Seguinte", previous = "Anterior"),
          buttons = list(copy = "Copiar", csv = "Exportar CSV", excel = "Exportar Excel")
        )
      ),
      class = "display compact stripe hover",
      escape = FALSE
    ) |>
      DT::formatStyle(
        columns = names(tabela_final_toc),
        padding = "6px",
        `white-space` = "normal",
        `vertical-align` = "middle"
      )
    
    # ----------------------------------------------------------
    # 22. LEGENDA, BOTÕES PNG E ECRÃ INTEIRO
    # Adaptado da matriz de Beira; mantém os dados de Nampula
    # ----------------------------------------------------------
    
    widget <- htmlwidgets::onRender(widget, htmlwidgets::JS("
      function(el, x) {
        if (!document.getElementById('toc-matriz-botoes-css-nampula')) {
          var style = document.createElement('style');
          style.id = 'toc-matriz-botoes-css-nampula';
          style.textContent =
            '.toc-valor-botao{display:inline-block;min-width:76px;padding:8px 10px;border-radius:5px;text-align:center;font-weight:700;font-size:12px;white-space:nowrap;box-sizing:border-box;}' +
            '.toc-sem-medicao{display:inline-block;min-width:76px;padding:8px 10px;border-radius:5px;text-align:center;background:#F5F3F4;color:#777;font-weight:600;box-sizing:border-box;}' +
            '.toc-valor-neutro{display:inline-block;padding:8px 10px;color:#4B315B;font-weight:600;white-space:nowrap;}';
          document.head.appendChild(style);
        }

        var container = el.parentElement;
        if (!container || container.querySelector('.toc-custom-toolbar-nampula')) return;

        var toolbar = document.createElement('div');
        toolbar.className = 'toc-custom-toolbar-nampula';
        toolbar.style.cssText = 'display:flex;gap:10px;flex-wrap:wrap;margin-bottom:12px;';

        function criarBotao(texto, cor) {
          var btn = document.createElement('button');
          btn.type = 'button';
          btn.textContent = texto;
          btn.style.cssText = 'background:' + cor + ';color:white;border:0;padding:9px 14px;border-radius:5px;cursor:pointer;font-weight:bold;';
          return btn;
        }

        var pngButton = criarBotao('📷 Guardar tabela completa em PNG', '#8054A2');
        var fullButton = criarBotao('⛶ Ecrã inteiro', '#F37238');
        toolbar.appendChild(pngButton);
        toolbar.appendChild(fullButton);

        var legenda = document.createElement('div');
        legenda.style.cssText = 'display:flex;align-items:center;gap:8px;flex-wrap:wrap;margin:0 0 12px 0;font-size:12px;color:#555;';
        var menos = document.createElement('span'); menos.textContent = 'Menos cumprida'; legenda.appendChild(menos);
        var escala = document.createElement('div'); escala.style.cssText = 'display:flex;gap:3px;align-items:center;';
        ['#EBE0F2','#D6C4E2','#B99ACF','#9B75B9','#8054A2'].forEach(function(cor) {
          var q = document.createElement('span');
          q.style.cssText = 'display:inline-block;width:22px;height:12px;border-radius:2px;background:' + cor + ';';
          escala.appendChild(q);
        });
        legenda.appendChild(escala);
        var mais = document.createElement('span'); mais.textContent = 'Mais cumprida'; legenda.appendChild(mais);
        var sem = document.createElement('span'); sem.style.cssText = 'display:inline-block;width:18px;height:12px;border-radius:2px;background:#F5F3F4;border:1px solid #E0DDE0;margin-left:8px;'; legenda.appendChild(sem);
        var textoSem = document.createElement('span'); textoSem.textContent = 'Sem medição'; legenda.appendChild(textoSem);

        container.insertBefore(toolbar, el);
        container.insertBefore(legenda, el);

        function obterTabela() {
          var table = el.querySelector('.dataTables_scrollBody table.dataTable');
          if (!table) table = el.querySelector('table.dataTable');
          return table;
        }

        fullButton.addEventListener('click', function() {
          if (document.fullscreenElement) {
            if (document.exitFullscreen) document.exitFullscreen();
          } else if (container.requestFullscreen) {
            container.requestFullscreen();
          } else {
            alert('O navegador não suporta o modo de ecrã inteiro.');
          }
        });

        pngButton.addEventListener('click', async function() {
          var $ = window.jQuery;
          if (typeof window.html2canvas !== 'function') {
            alert('A biblioteca html2canvas não está carregada. Inclua-a no UI ou verifique a ligação à Internet.');
            return;
          }
          var table = obterTabela();
          if (!table || !$ || !$.fn.DataTable || !$.fn.DataTable.isDataTable(table)) {
            alert('Não foi possível localizar a tabela DataTables para exportação.');
            return;
          }
          var dt = $(table).DataTable();
          var oldLength = dt.page.len();
          var oldPage = dt.page();
          var wrapper = el.querySelector('.dataTables_wrapper') || el;
          var scrollBody = wrapper.querySelector('.dataTables_scrollBody');
          var oldStyle = scrollBody ? scrollBody.getAttribute('style') : null;
          pngButton.disabled = true;
          pngButton.textContent = 'A preparar PNG...';
          try {
            dt.page.len(-1).draw();
            await new Promise(function(resolve) { setTimeout(resolve, 500); });
            if (scrollBody) {
              scrollBody.style.height = 'auto';
              scrollBody.style.maxHeight = 'none';
              scrollBody.style.overflow = 'visible';
            }
            await new Promise(function(resolve) { setTimeout(resolve, 250); });
            var canvas = await window.html2canvas(wrapper, {
              scale: 2, backgroundColor: '#ffffff', useCORS: true, logging: false,
              width: wrapper.scrollWidth, height: wrapper.scrollHeight,
              windowWidth: Math.max(document.documentElement.clientWidth, wrapper.scrollWidth),
              windowHeight: Math.max(document.documentElement.clientHeight, wrapper.scrollHeight),
              onclone: function(doc) {
                var t = doc.querySelector('.toc-custom-toolbar-nampula');
                if (t) t.style.display = 'none';
                var legends = doc.querySelectorAll('div');
                legends.forEach(function(node) {
                  if (node.textContent && node.textContent.indexOf('Sem medição') !== -1 && node.style.display !== 'none') node.style.display = 'none';
                });
                doc.querySelectorAll('.dataTables_scrollBody').forEach(function(body) {
                  body.style.height = 'auto'; body.style.maxHeight = 'none'; body.style.overflow = 'visible';
                });
                doc.querySelectorAll('.dataTables_scroll,.dataTables_wrapper').forEach(function(node) {
                  node.style.height = 'auto'; node.style.maxHeight = 'none'; node.style.overflow = 'visible';
                });
              }
            });
            var link = document.createElement('a');
            link.download = 'Matriz_TOC_PAM_Verde_Nampula_Ciclo3.png';
            link.href = canvas.toDataURL('image/png');
            document.body.appendChild(link); link.click(); link.remove();
          } catch (error) {
            console.error('Erro na exportação PNG da matriz Nampula C3:', error);
            alert('Não foi possível gerar o PNG. Abra F12 > Console para consultar o erro.');
          } finally {
            if (scrollBody) {
              if (oldStyle === null) scrollBody.removeAttribute('style');
              else scrollBody.setAttribute('style', oldStyle);
            }
            dt.page.len(oldLength).draw();
            setTimeout(function() {
              dt.page(oldPage).draw('page');
              pngButton.disabled = false;
              pngButton.textContent = '📷 Guardar tabela completa em PNG';
            }, 300);
          }
        });
      }
    "))
    
    widget
    
  }, server = TRUE)
  
  
  
  
  
  # ============================================================
  # PAM VERDE — BEIRA CICLO 1
  # MATRIZ TOC COMPLETA — 17 INDICADORES
  #
  # FORMAÇÃO: PAM_VERDE_PERFIL_BEIRA_C1
  # GESTÃO / GÉNERO: PAM_VERDE_TOC_BEIRA_C1
  # FINANCEIRO: FINANCEIRO_TOC_BEIRA_C1
  #
  # Requer: dplyr, tidyr, DT
  # ============================================================
  
  output$toc_matriz_indicadores_beira <- DT::renderDT({
    
    # ==========================================================
    # 1. VERIFICAR FONTES
    # ==========================================================
    
    if (!exists("PAM_VERDE_PERFIL_BEIRA_C1")) {
      return(DT::datatable(
        data.frame(Mensagem =
                     "Não foi encontrada a fonte PAM_VERDE_PERFIL_BEIRA_C1."),
        rownames = FALSE
      ))
    }
    
    if (!exists("PAM_VERDE_TOC_BEIRA_C1")) {
      return(DT::datatable(
        data.frame(Mensagem =
                     "Não foi encontrada PAM_VERDE_TOC_BEIRA_C1."),
        rownames = FALSE
      ))
    }
    
    perfil_beira <- PAM_VERDE_PERFIL_BEIRA_C1
    toc_beira <- PAM_VERDE_TOC_BEIRA_C1
    
    if (exists("FINANCEIRO_TOC_BEIRA_C1")) {
      financeiro_beira <- FINANCEIRO_TOC_BEIRA_C1
    } else if (exists("Financeiro_Beira")) {
      financeiro_beira <- Financeiro_Beira
    } else {
      financeiro_beira <- data.frame()
    }
    
    # ==========================================================
    # 2. FUNÇÕES AUXILIARES
    # ==========================================================
    
    normalizar_texto <- function(x) {
      trimws(as.character(x))
    }
    
    calcular_percentagem <- function(
    dados, coluna, resposta, tipo
    ) {
      
      if (
        !coluna %in% names(dados) ||
        !"Tipo_Avaliacao" %in% names(dados)
      ) {
        return(NA_real_)
      }
      
      avaliacao <- tolower(normalizar_texto(
        dados$Tipo_Avaliacao
      ))
      
      valores <- normalizar_texto(dados[[coluna]])
      
      validos <- !is.na(valores) &
        valores != "" &
        !is.na(avaliacao) &
        avaliacao == tolower(tipo)
      
      if (!any(validos)) return(NA_real_)
      
      100 * sum(valores[validos] %in% resposta) /
        sum(validos)
    }
    
    calcular_estado_formacao <- function(
    dados, estados_incluidos
    ) {
      
      if (!"Status" %in% names(dados)) return(NA_real_)
      
      status <- toupper(normalizar_texto(dados$Status))
      validos <- !is.na(status) & status != ""
      
      if (!any(validos)) return(NA_real_)
      
      100 * sum(
        status %in% toupper(estados_incluidos) & validos
      ) / sum(validos)
    }
    
    formatar_numero <- function(x, casas = 1) {
      
      if (
        length(x) == 0 ||
        is.na(x) ||
        !is.finite(x)
      ) {
        return("—")
      }
      
      format(
        round(x, casas),
        big.mark = " ",
        decimal.mark = ",",
        nsmall = casas,
        trim = TRUE
      )
    }
    
    # ==========================================================
    # 3. INDICADOR 1 — INÍCIO DA FORMAÇÃO
    # ==========================================================
    
    inicio_formacao_EL <- calcular_estado_formacao(
      perfil_beira,
      c(
        "Activa", "Activas", "Ativa", "Ativas",
        "Desistente", "Desistentes"
      )
    )
    
    # ==========================================================
    # 4. INDICADOR 2 — CONCLUSÃO DA FORMAÇÃO
    # ==========================================================
    
    conclusao_formacao_EL <- NA_real_
    
    if ("Status" %in% names(perfil_beira)) {
      
      status_perfil <- toupper(
        trimws(as.character(
          normalizar_texto(perfil_beira$Status)
        ))
      )
      
      # Participantes que iniciaram:
      # Activas + Desistentes
      iniciaram <- !is.na(status_perfil) &
        status_perfil %in% c(
          "ACTIVA", "ACTIVAS",
          "ATIVA", "ATIVAS",
          "DESISTENTE", "DESISTENTES"
        )
      
      # Participantes activas, consideradas como concluintes
      activas <- !is.na(status_perfil) &
        status_perfil %in% c(
          "ACTIVA", "ACTIVAS",
          "ATIVA", "ATIVAS"
        )
      
      total_iniciaram <- sum(iniciaram)
      total_activas <- sum(activas)
      
      # Percentagem de conclusão
      if (total_iniciaram > 0) {
        conclusao_formacao_EL <-
          (total_activas / total_iniciaram) * 100
      }
    }
    
    # ==========================================================
    # 5. INDICADOR 3 — FORMALIZAÇÃO
    # ID: iPAM_INT1.1
    # ==========================================================
    
    formalizacao_BL <- calcular_percentagem(
      toc_beira, "Negocio_Formalizado",
      "Iniciei o processo de formalização", "Baseline"
    )
    
    formalizacao_EL <- calcular_percentagem(
      toc_beira, "Negocio_Formalizado",
      "Iniciei o processo de formalização", "Endline"
    )
    
    # ==========================================================
    # 6. INDICADOR 4 — SALÁRIO MENSAL
    # ID: iPAM_RI.2.4
    # ==========================================================
    
    salario_BL <- calcular_percentagem(
      toc_beira, "Tira_Salario_Para_Si",
      "Sim, retiro um valor fixo todos os meses", "Baseline"
    )
    
    salario_EL <- calcular_percentagem(
      toc_beira, "Tira_Salario_Para_Si",
      "Sim, retiro um valor fixo todos os meses", "Endline"
    )
    
    # ==========================================================
    # 7. INDICADOR 5 — TOMADA DE DECISÕES
    # ID: OS1.1
    # ==========================================================
    
    decisoes_BL <- calcular_percentagem(
      toc_beira, "Quem_Toma_Decisoes_Negocio",
      "Só eu", "Baseline"
    )
    
    decisoes_EL <- calcular_percentagem(
      toc_beira, "Quem_Toma_Decisoes_Negocio",
      "Só eu", "Endline"
    )
    
    # ==========================================================
    # 8. INDICADOR 6 — NEGOCIAÇÃO COM CLIENTES
    # ID: iPAM_RI.2.6
    # ==========================================================
    
    resposta_negociacao_clientes <-
      "Sim, sinto-me confiante e sei defender a minha posição"
    
    negociacao_clientes_BL <- calcular_percentagem(
      toc_beira, "Negociacao_Com_Clientes",
      resposta_negociacao_clientes, "Baseline"
    )
    
    negociacao_clientes_EL <- calcular_percentagem(
      toc_beira, "Negociacao_Com_Clientes",
      resposta_negociacao_clientes, "Endline"
    )
    
    # ==========================================================
    # 9. INDICADOR 7 — NEGOCIAÇÃO NOS ÚLTIMOS 3 MESES
    # ID: iPAM_RI.5.1
    # ==========================================================
    
    coluna_negociacao_3meses <-
      "Praticou_negociação_nos_últimos_3meses"
    
    resposta_negociacao_3meses <-
      "Sim, negociei e consegui um acordo favorável para o meu negócio"
    
    negociacao_3meses_BL <- calcular_percentagem(
      toc_beira, coluna_negociacao_3meses,
      resposta_negociacao_3meses, "Baseline"
    )
    
    negociacao_3meses_EL <- calcular_percentagem(
      toc_beira, coluna_negociacao_3meses,
      resposta_negociacao_3meses, "Endline"
    )
    
    # ==========================================================
    # 10. INDICADOR 8 — UTILIZAÇÃO DE FERRAMENTAS DE IA
    # ID: iPAM_RI.3.1
    # ==========================================================
    
    respostas_ia <- c(
      "Sim, usei pelo menos uma vez",
      "Sim, uso regularmente para o negócio"
    )
    
    uso_ia_BL <- calcular_percentagem(
      toc_beira, "Uso_de_ferramentas_de_IA",
      respostas_ia, "Baseline"
    )
    
    uso_ia_EL <- calcular_percentagem(
      toc_beira, "Uso_de_ferramentas_de_IA",
      respostas_ia, "Endline"
    )
    
    # ==========================================================
    # 11. INDICADOR 9 — SEPARAÇÃO DAS CONTAS
    # ID: iPAM_RI.2.2.b
    # ==========================================================
    
    coluna_contas <-
      "Faz separação das contas pessoais e do negócio"
    
    contas_BL <- calcular_percentagem(
      toc_beira, coluna_contas, "Sim", "Baseline"
    )
    
    contas_EL <- calcular_percentagem(
      toc_beira, coluna_contas, "Sim", "Endline"
    )
    
    # ==========================================================
    # 12. INDICADOR 10 — CÁLCULO DO LUCRO
    # ID: iPAM_RI.4.1
    # ==========================================================
    
    coluna_calculo_lucro <-
      "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    
    calculo_lucro_BL <- calcular_percentagem(
      toc_beira, coluna_calculo_lucro, "Sim", "Baseline"
    )
    
    calculo_lucro_EL <- calcular_percentagem(
      toc_beira, coluna_calculo_lucro, "Sim", "Endline"
    )
    
    # ==========================================================
    # 13. INDICADOR 11 — CONTROLO DO DINHEIRO
    # ID: iPAM_RI.2.2.a
    # ==========================================================
    
    coluna_controlo <-
      "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    
    controlo_BL <- calcular_percentagem(
      toc_beira, coluna_controlo, "Sim", "Baseline"
    )
    
    controlo_EL <- calcular_percentagem(
      toc_beira, coluna_controlo, "Sim", "Endline"
    )
    
    # ==========================================================
    # 14. INDICADOR 12 — ACTIVIDADES DE GÉNERO
    # ID: iPAM_RI.4.2
    # ==========================================================
    
    coluna_genero <- paste0(
      "Até que ponto as actividades ligadas à questão de género ",
      "ajudaram a compreender as desigualdades entre homens e mulheres?"
    )
    
    genero_EL <- calcular_percentagem(
      toc_beira, coluna_genero,
      "Ajudaram bastante / mudaram a minha compreensão",
      "Endline"
    )
    
    
    
    # ============================================================
    # PAM VERDE — BEIRA | CICLO 1
    # INDICADOR iPAM_RI.7.3
    # EMPREENDEDORAS QUE PASSARAM A UTILIZAR PELO MENOS
    # UM NOVO SERVIÇO FINANCEIRO
    #
    # Meta 2026: 40%
    #
    # Numerador:
    # Participantes que passaram a utilizar pelo menos um
    # novo serviço financeiro entre Baseline e Endline.
    #
    # Denominador:
    # Participantes com informação válida para os seis serviços
    # nas duas avaliações.
    #
    # Fonte: PAM_VERDE_TOC_BEIRA_C1
    # Requer: dplyr, tidyr, stringr
    # ============================================================
    
    
    # ============================================================
    # 1. VALIDAR A BASE DE ORIGEM
    # ============================================================
    
    if (!exists("PAM_VERDE_TOC_BEIRA_C1")) {
      stop(
        "A base PAM_VERDE_TOC_BEIRA_C1 não foi encontrada."
      )
    }
    
    base_servicos_beira <- PAM_VERDE_TOC_BEIRA_C1
    
    colunas_necessarias <- c(
      "ID_Participante",
      "Tipo_Avaliacao",
      "Uso_Servicos_Financeiros"
    )
    
    colunas_faltantes <- setdiff(
      colunas_necessarias,
      names(base_servicos_beira)
    )
    
    if (length(colunas_faltantes) > 0) {
      stop(
        "Faltam as seguintes colunas na base: ",
        paste(colunas_faltantes, collapse = ", ")
      )
    }
    
    
    # ============================================================
    # 2. LISTA DOS SEIS SERVIÇOS FINANCEIROS
    # ============================================================
    
    lista_servicos_financeiros <- c(
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)",
      "Crédito ou empréstimo bancário para o negócio",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)",
      "Conta bancária em nome do negócio (conta empresarial)",
      "Conta poupança formal ligada ao negócio",
      "Seguro (de negócio, de equipamento, de saúde...)"
    )
    
    
    # ============================================================
    # 3. PREPARAR AS RESPOSTAS
    # ============================================================
    
    respostas_servicos <- base_servicos_beira |>
      dplyr::transmute(
        ID_Participante = stringr::str_squish(
          as.character(ID_Participante)
        ),
        
        Tipo_Avaliacao = stringr::str_to_lower(
          stringr::str_squish(
            as.character(Tipo_Avaliacao)
          )
        ),
        
        Resposta = stringr::str_squish(
          as.character(Uso_Servicos_Financeiros)
        )
      ) |>
      dplyr::filter(
        !is.na(ID_Participante),
        ID_Participante != "",
        Tipo_Avaliacao %in% c("baseline", "endline"),
        !is.na(Resposta),
        Resposta != ""
      ) |>
      dplyr::mutate(
        Tipo_Avaliacao = dplyr::case_when(
          Tipo_Avaliacao == "baseline" ~ "Baseline",
          Tipo_Avaliacao == "endline" ~ "Endline"
        )
      ) |>
      dplyr::group_by(
        ID_Participante,
        Tipo_Avaliacao
      ) |>
      dplyr::summarise(
        Resposta = paste(
          unique(Resposta),
          collapse = " | "
        ),
        .groups = "drop"
      )
    
    
    # ============================================================
    # 4. IDENTIFICAR A UTILIZAÇÃO DE CADA SERVIÇO
    #
    # 1 = utiliza o serviço
    # 0 = não utiliza o serviço
    #
    # ATENÇÃO:
    # Este bloco pressupõe que as respostas contêm os nomes
    # dos serviços tal como aparecem na lista acima.
    # ============================================================
    
    if (nrow(respostas_servicos) == 0) {
      
      stop(
        "Não existem respostas válidas de Baseline e Endline ",
        "na coluna Uso_Servicos_Financeiros."
      )
      
    }
    
    binarios_servicos <- tidyr::crossing(
      respostas_servicos,
      servico = lista_servicos_financeiros
    ) |>
      dplyr::mutate(
        utiliza = as.integer(
          stringr::str_detect(
            stringr::str_to_lower(Resposta),
            stringr::fixed(
              stringr::str_to_lower(servico)
            )
          )
        )
      ) |>
      dplyr::select(
        ID_Participante,
        Tipo_Avaliacao,
        servico,
        utiliza
      ) |>
      tidyr::pivot_wider(
        id_cols = ID_Participante,
        names_from = c(servico, Tipo_Avaliacao),
        values_from = utiliza,
        names_glue = "{servico}_{Tipo_Avaliacao}"
      )
    
    
    # ============================================================
    # 5. DEFINIR AS COLUNAS DE BASELINE E ENDLINE
    # ============================================================
    
    colunas_baseline <- paste0(
      lista_servicos_financeiros,
      "_Baseline"
    )
    
    colunas_endline <- paste0(
      lista_servicos_financeiros,
      "_Endline"
    )
    
    # Garantir que todas as colunas existem
    for (col in c(colunas_baseline, colunas_endline)) {
      
      if (!col %in% names(binarios_servicos)) {
        binarios_servicos[[col]] <- NA_integer_
      }
      
    }
    
    
    # ============================================================
    # 6. SELECCIONAR PARTICIPANTES COMPARÁVEIS
    #
    # Exige informação para os seis serviços em ambas
    # as avaliações.
    # ============================================================
    
    participantes_validos <- binarios_servicos |>
      dplyr::filter(
        dplyr::if_all(
          dplyr::all_of(
            c(colunas_baseline, colunas_endline)
          ),
          ~ !is.na(.x)
        )
      )
    
    
    # ============================================================
    # 7. CALCULAR OS NOVOS SERVIÇOS FINANCEIROS
    # ============================================================
    
    if (nrow(participantes_validos) > 0) {
      
      matriz_baseline <- as.matrix(
        participantes_validos[
          ,
          colunas_baseline,
          drop = FALSE
        ]
      )
      
      matriz_endline <- as.matrix(
        participantes_validos[
          ,
          colunas_endline,
          drop = FALSE
        ]
      )
      
      # Serviços que não utilizava no Baseline,
      # mas passou a utilizar no Endline
      matriz_novos_servicos <-
        matriz_baseline == 0 &
        matriz_endline == 1
      
      # Serviços que deixou de utilizar
      matriz_servicos_deixados <-
        matriz_baseline == 1 &
        matriz_endline == 0
      
      participantes_validos$Novos_Servicos <- as.integer(
        rowSums(matriz_novos_servicos)
      )
      
      participantes_validos$Servicos_Deixou_Usar <- as.integer(
        rowSums(matriz_servicos_deixados)
      )
      
      # Indicador individual:
      # Sim = passou a utilizar pelo menos um serviço novo
      participantes_validos$Aumentou_Uso <- ifelse(
        participantes_validos$Novos_Servicos >= 1,
        "Sim",
        "Não"
      )
      
    } else {
      
      participantes_validos$Novos_Servicos <- integer(0)
      
      participantes_validos$Servicos_Deixou_Usar <- integer(0)
      
      participantes_validos$Aumentou_Uso <- character(0)
      
    }
    
    
    # ============================================================
    # 8. CRIAR A TABELA FINAL DO INDICADOR
    # ============================================================
    
    tabela_servicos_financeiros <- participantes_validos |>
      dplyr::select(
        ID_Participante,
        dplyr::all_of(colunas_baseline),
        dplyr::all_of(colunas_endline),
        Novos_Servicos,
        Servicos_Deixou_Usar,
        Aumentou_Uso
      )
    
    
    # ============================================================
    # 9. CALCULAR O INDICADOR AGREGADO
    # ============================================================
    
    servicos_financeiros_total_validos <- nrow(
      tabela_servicos_financeiros
    )
    
    servicos_financeiros_total_sim <- sum(
      tabela_servicos_financeiros$Aumentou_Uso == "Sim",
      na.rm = TRUE
    )
    
    servicos_financeiros_percentual_EL <- if (
      servicos_financeiros_total_validos > 0
    ) {
      
      servicos_financeiros_total_sim /
        servicos_financeiros_total_validos * 100
      
    } else {
      
      NA_real_
      
    }
    
    
    # ============================================================
    # 10. RESULTADO E DIAGNÓSTICO
    # ============================================================
    
    cat("\n")
    cat("====================================================\n")
    cat("PAM VERDE — BEIRA | CICLO 1\n")
    cat("INDICADOR iPAM_RI.7.3\n")
    cat("Novos serviços financeiros\n")
    cat("====================================================\n")
    
    cat(
      "Participantes com comparação válida: ",
      servicos_financeiros_total_validos,
      "\n",
      sep = ""
    )
    
    cat(
      "Participantes que utilizaram novos serviços: ",
      servicos_financeiros_total_sim,
      "\n",
      sep = ""
    )
    
    cat(
      "Meta 2026: 40%\n"
    )
    
    cat(
      "Resultado: ",
      if (
        is.na(servicos_financeiros_percentual_EL)
      ) {
        "Sem dados suficientes"
      } else {
        paste0(
          round(servicos_financeiros_percentual_EL, 1),
          "%"
        )
      },
      "\n",
      sep = ""
    )
    
    cat("====================================================\n")
    
    
    # ============================================================
    # 11. LIGAR O RESULTADO À MATRIZ TOC
    #
    # Usar estes valores no indicador iPAM_RI.7.3
    # ============================================================
    
    # Endline
    # servicos_financeiros_percentual_EL
    #
    # Numerador
    # servicos_financeiros_total_sim
    #
    # Denominador
    # servicos_financeiros_total_validos
    #
    # Meta
    # 40
    
    
    # ==========================================================
    # 16. INDICADORES FINANCEIROS
    # ==========================================================
    
    lucro_aumentou_EL <- NA_real_
    lucro_mais_25_EL <- NA_real_
    aumento_medio_lucro_EL <- NA_real_
    saldo_liquido_lucro_EL <- NA_real_
    
    colunas_financeiras <- c(
      "Nome_Empreendedora",
      "Periodo",
      "Lucro_Semanal"
    )
    
    if (
      nrow(financeiro_beira) > 0 &&
      all(colunas_financeiras %in% names(financeiro_beira))
    ) {
      
      financeiro_tratado <- financeiro_beira |>
        dplyr::mutate(
          Nome_Empreendedora = trimws(
            as.character(Nome_Empreendedora)
          ),
          Periodo = trimws(as.character(Periodo)),
          Lucro_Semanal = suppressWarnings(
            as.numeric(as.character(Lucro_Semanal))
          )
        ) |>
        dplyr::filter(
          !is.na(Nome_Empreendedora),
          Nome_Empreendedora != "",
          Periodo %in% c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
          ),
          !is.na(Lucro_Semanal)
        )
      
      lucro_periodo <- financeiro_tratado |>
        dplyr::group_by(Nome_Empreendedora, Periodo) |>
        dplyr::summarise(
          Lucro = sum(Lucro_Semanal, na.rm = TRUE),
          .groups = "drop"
        )
      
      lucro_comparacao <- lucro_periodo |>
        tidyr::pivot_wider(
          names_from = Periodo,
          values_from = Lucro
        )
      
      if (
        all(c("Primeiro Mês", "Terceiro Mês") %in%
            names(lucro_comparacao))
      ) {
        
        lucro_comparacao <- lucro_comparacao |>
          dplyr::filter(
            !is.na(`Primeiro Mês`),
            !is.na(`Terceiro Mês`)
          ) |>
          dplyr::mutate(
            Aumento_Lucro =
              `Terceiro Mês` - `Primeiro Mês`,
            Percentual_Aumento = dplyr::if_else(
              `Primeiro Mês` > 0,
              Aumento_Lucro / `Primeiro Mês` * 100,
              NA_real_
            )
          )
        
        base_percentual <- lucro_comparacao |>
          dplyr::filter(!is.na(Percentual_Aumento))
        
        if (nrow(base_percentual) > 0) {
          
          lucro_aumentou_EL <- mean(
            base_percentual$Percentual_Aumento > 0
          ) * 100
          
          lucro_mais_25_EL <- mean(
            base_percentual$Percentual_Aumento >= 25
          ) * 100
        }
        
        aumentos <- lucro_comparacao$Aumento_Lucro
        aumentos <- aumentos[!is.na(aumentos)]
        
        if (length(aumentos) > 0) {
          aumento_medio_lucro_EL <- mean(aumentos)
          saldo_liquido_lucro_EL <- sum(aumentos)
        }
      }
    }
    
    # ==========================================================
    # 17. CONSTRUIR A MATRIZ TOC — 17 INDICADORES
    # ==========================================================
    
    indicadores_toc <- data.frame(
      
      ID_Indicador = c(
        "iVM1000",
        "iVM1000",
        "iPAM_INT1.1",
        "iPAM_RI.2.4",
        "OS1.1",
        "iPAM_RI.2.6",
        "iPAM_RI.5.1",
        "iPAM_RI.3.1",
        "iPAM_RI.2.2.b",
        "iPAM_RI.4.1",
        "iPAM_RI.2.2.a",
        "iPAM_RI.4.2",
        "iPAM_RI.7.3",
        "iPAM_RI.1.1",
        "iPAM_RI.1.2",
        "iPAM_RI.2.1",
        "iPAM_RI.1.3b"
      ),
      
      Indicador = c(
        "Participantes que iniciam a formação",
        "Participantes que completam a formação",
        "Empreendedoras que iniciam o processo de formalização",
        "Empreendedoras que definem um salário mensal para si mesmas",
        "Empreendedoras que tomam sozinhas as principais decisões do negócio",
        "Empreendedoras confiantes na negociação com clientes",
        "Empreendedoras que negociaram e conseguiram acordo favorável nos últimos 3 meses",
        "Empreendedoras que sabem utilizar ferramentas de IA",
        "Separa as contas pessoais das contas do negócio",
        "Sabe calcular o lucro do negócio",
        "Controla o dinheiro que entra e sai",
        "Actividades de género contribuíram para compreender desigualdades",
        "Empreendedoras que passaram a utilizar pelo menos um novo serviço financeiro",
        "Aumentou os lucros durante os 3 meses",
        "Aumentou o lucro em 25% ou mais",
        "Valor médio de aumento do lucro",
        "Saldo líquido do valor adicionado"
      ),
      
      Baseline = c(
        NA_real_,
        NA_real_,
        formalizacao_BL,
        salario_BL,
        decisoes_BL,
        negociacao_clientes_BL,
        negociacao_3meses_BL,
        uso_ia_BL,
        contas_BL,
        calculo_lucro_BL,
        controlo_BL,
        NA_real_,
        NA_real_,
        NA_real_,
        NA_real_,
        NA_real_,
        NA_real_
      ),
      
      Endline = c(
        inicio_formacao_EL,
        conclusao_formacao_EL,
        formalizacao_EL,
        salario_EL,
        decisoes_EL,
        negociacao_clientes_EL,
        negociacao_3meses_EL,
        uso_ia_EL,
        contas_EL,
        calculo_lucro_EL,
        controlo_EL,
        genero_EL,
        servicos_financeiros_percentual_EL,
        lucro_aumentou_EL,
        lucro_mais_25_EL,
        aumento_medio_lucro_EL,
        saldo_liquido_lucro_EL
      ),
      
      Meta_2026 = c(
        85,
        80,
        10,
        50,
        100,
        70,
        70,
        80,
        80,
        85,
        80,
        100,
        40,
        80,
        50,
        2500,
        70000
      ),
      
      stringsAsFactors = FALSE
    )
    
    # Validar os 17 indicadores
    stopifnot(
      length(indicadores_toc$ID_Indicador) == 17,
      length(indicadores_toc$Indicador) == 17,
      length(indicadores_toc$Baseline) == 17,
      length(indicadores_toc$Endline) == 17,
      length(indicadores_toc$Meta_2026) == 17
    )
    
    # ==========================================================
    # 18. DEFINIR UNIDADE DOS INDICADORES
    # Indicadores 15, 16 e 17? Não:
    # Os indicadores financeiros começam na posição 14.
    # 14 e 15 são percentagens; 16 e 17 são valores em MT.
    # ==========================================================
    
    indicadores_toc$Unidade <- ifelse(
      seq_len(nrow(indicadores_toc)) %in% c(16, 17),
      "MT",
      "%"
    )
    
    # ==========================================================
    # 19. VARIAÇÃO, ALCANCE E ESTADO
    # ==========================================================
    
    indicadores_toc <- indicadores_toc |>
      dplyr::mutate(
        
        Variação = dplyr::if_else(
          Unidade == "%" &
            !is.na(Baseline) &
            !is.na(Endline),
          Endline - Baseline,
          NA_real_
        ),
        
        Alcance_Numerico = dplyr::if_else(
          !is.na(Endline) &
            !is.na(Meta_2026) &
            Meta_2026 > 0,
          Endline / Meta_2026 * 100,
          NA_real_
        ),
        
        Estado = dplyr::case_when(
          is.na(Endline) ~ "Sem dados",
          is.na(Meta_2026) ~ "Sem meta",
          Endline >= Meta_2026 ~ "Meta alcançada",
          Endline >= Meta_2026 * 0.8 ~ "Próximo da meta",
          Endline >= Meta_2026 * 0.5 ~ "Em progresso",
          TRUE ~ "Abaixo da meta"
        )
      )
    
    # ==========================================================
    # 20. FORMATAR VALORES
    # ==========================================================
    
    formatar_indicador <- function(valor, unidade) {
      
      if (
        length(valor) == 0 ||
        is.na(valor) ||
        !is.finite(valor)
      ) {
        return("—")
      }
      
      if (unidade == "%") {
        return(paste0(formatar_numero(valor, 1), "%"))
      }
      
      paste0(formatar_numero(valor, 2), " MT")
    }
    
    indicadores_toc$Baseline_Exibicao <- mapply(
      formatar_indicador,
      indicadores_toc$Baseline,
      indicadores_toc$Unidade
    )
    
    indicadores_toc$Endline_Exibicao <- mapply(
      formatar_indicador,
      indicadores_toc$Endline,
      indicadores_toc$Unidade
    )
    
    indicadores_toc$Meta_Exibicao <- mapply(
      formatar_indicador,
      indicadores_toc$Meta_2026,
      indicadores_toc$Unidade
    )
    
    indicadores_toc$Variacao_Exibicao <- vapply(
      seq_len(nrow(indicadores_toc)),
      function(i) {
        
        valor <- indicadores_toc$Variação[i]
        
        if (is.na(valor)) return("—")
        
        paste0(
          ifelse(valor > 0, "+", ""),
          formatar_numero(valor, 1),
          " p.p."
        )
      },
      character(1)
    )
    
    indicadores_toc$Alcance_Exibicao <- vapply(
      indicadores_toc$Alcance_Numerico,
      function(x) {
        
        if (is.na(x) || !is.finite(x)) return("—")
        
        paste0(formatar_numero(x, 1), "%")
      },
      character(1)
    )
    
    # ==========================================================
    # 21. TABELA FINAL — CÉLULAS EM FORMATO DE BOTÃO
    # Roxo mais escuro = valor mais elevado (100% ou mais)
    # Roxo mais claro = valor percentual mais baixo
    # Travessão cinzento = sem medição
    # ==========================================================
    
    botao_percentual <- function(valor, unidade = "%", texto = NULL) {
      
      if (is.null(texto)) {
        texto <- formatar_indicador(valor, unidade)
      }
      
      if (is.na(valor) || !is.finite(valor)) {
        return(
          '<span class="toc-sem-medicao">—</span>'
        )
      }
      
      # Os indicadores percentuais usam uma escala de 0 a 100%.
      # Valores iguais ou superiores a 100% recebem o roxo mais escuro.
      if (unidade == "%") {
        intensidade <- max(0, min(100, valor)) / 100
        
        # Interpolação entre lilás claro e roxo escuro.
        claro <- c(235, 224, 242)
        escuro <- c(128, 84, 162)
        rgb <- round(claro + (escuro - claro) * intensidade)
        
        fundo <- sprintf("#%02X%02X%02X", rgb[1], rgb[2], rgb[3])
        cor_texto <- if (intensidade >= 0.62) "#FFFFFF" else "#4B315B"
        
        return(sprintf(
          paste0(
            '<span class="toc-valor-botao" ',
            'style="background-color:%s;color:%s;" ',
            'title="%s">%s</span>'
          ),
          fundo,
          cor_texto,
          htmltools::htmlEscape(texto),
          htmltools::htmlEscape(texto)
        ))
      }
      
      # Indicadores financeiros em MT não são tratados como percentagens.
      sprintf(
        '<span class="toc-valor-neutro">%s</span>',
        htmltools::htmlEscape(texto)
      )
    }
    
    botao_estado <- function(estado) {
      if (is.na(estado) || estado == "") {
        return('<span class="toc-sem-medicao">—</span>')
      }
      
      estilos <- switch(
        estado,
        "Meta alcançada" = "background:#8054A2;color:#FFFFFF;",
        "Próximo da meta" = "background:#D6C4E2;color:#4B315B;",
        "Em progresso" = "background:#B99ACF;color:#4B315B;",
        "Abaixo da meta" = "background:#EBE0F2;color:#4B315B;",
        "Sem dados" = "background:#F5F3F4;color:#666666;",
        "Sem meta" = "background:#EEEEEE;color:#666666;",
        "background:#EEEEEE;color:#666666;"
      )
      
      sprintf(
        '<span class="toc-valor-botao" style="%s">%s</span>',
        estilos,
        htmltools::htmlEscape(estado)
      )
    }
    
    tabela_final <- data.frame(
      ID_Indicador = indicadores_toc$ID_Indicador,
      Indicador = indicadores_toc$Indicador,
      
      Baseline = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(
          indicadores_toc$Baseline[i],
          indicadores_toc$Unidade[i],
          indicadores_toc$Baseline_Exibicao[i]
        )
      }, character(1)),
      
      Endline = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(
          indicadores_toc$Endline[i],
          indicadores_toc$Unidade[i],
          indicadores_toc$Endline_Exibicao[i]
        )
      }, character(1)),
      
      Variação = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        valor <- indicadores_toc$Variação[i]
        texto <- indicadores_toc$Variacao_Exibicao[i]
        
        if (is.na(valor) || !is.finite(valor)) {
          return('<span class="toc-sem-medicao">—</span>')
        }
        
        # A variação é apresentada como botão, com intensidade baseada
        # no valor final do indicador, sem confundir p.p. com percentagem.
        botao_percentual(
          indicadores_toc$Endline[i],
          indicadores_toc$Unidade[i],
          texto
        )
      }, character(1)),
      
      `Meta 2026` = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        botao_percentual(
          indicadores_toc$Meta_2026[i],
          indicadores_toc$Unidade[i],
          indicadores_toc$Meta_Exibicao[i]
        )
      }, character(1)),
      
      `Alcance da Meta` = vapply(seq_len(nrow(indicadores_toc)), function(i) {
        valor <- indicadores_toc$Alcance_Numerico[i]
        texto <- indicadores_toc$Alcance_Exibicao[i]
        botao_percentual(valor, "%", texto)
      }, character(1)),
      
      Estado = vapply(indicadores_toc$Estado, botao_estado, character(1)),
      check.names = FALSE,
      stringsAsFactors = FALSE
    )
    
    # ==========================================================
    # 22. DATATABLE INTERACTIVA — BEIRA CICLO 1
    # ==========================================================
    
    DT::datatable(
      
      tabela_final,
      
      rownames = FALSE,
      
      extensions = c("Buttons", "FixedHeader"),
      
      options = list(
        
        pageLength = 17,
        
        lengthMenu = list(
          c(15, 16, 17, 25, 50, 100, -1),
          c("15", "16", "17", "25", "50", "100", "Todos")
        ),
        
        scrollX = TRUE,
        scrollY = "65vh",
        scrollCollapse = TRUE,
        autoWidth = FALSE,
        fixedHeader = TRUE,
        
        dom = "Blfrtip",
        
        buttons = list(
          list(extend = "copy", text = "Copiar"),
          list(extend = "csv", text = "Exportar CSV"),
          list(extend = "excel", text = "Exportar Excel")
        ),
        
        columnDefs = list(
          
          list(
            targets = 0,
            width = "130px",
            className = "dt-center"
          ),
          
          list(
            targets = 1,
            width = "420px",
            className = "dt-left"
          ),
          
          list(
            targets = c(2, 3, 4, 5, 6),
            width = "145px",
            className = "dt-center"
          ),
          
          list(
            targets = 7,
            width = "160px",
            className = "dt-center"
          )
        ),
        
        language = list(
          
          search = "Pesquisar:",
          lengthMenu = "Mostrar _MENU_ indicadores",
          info = "A mostrar _START_ a _END_ de _TOTAL_ indicadores",
          infoEmpty = "Sem indicadores disponíveis",
          infoFiltered = "(filtrado de _MAX_ indicadores)",
          zeroRecords = "Nenhum indicador encontrado",
          emptyTable = "Sem dados disponíveis",
          
          paginate = list(
            first = "Primeiro",
            last = "Último",
            `next` = "Seguinte",
            previous = "Anterior"
          ),
          
          buttons = list(
            copy = "Copiar",
            csv = "Exportar CSV",
            excel = "Exportar Excel"
          )
        )
      ),
      
      class = "display compact stripe hover",
      escape = FALSE
      
    ) |>
      
      # --------------------------------------------------------
    # 24. FORMATAÇÃO DAS CÉLULAS
    # --------------------------------------------------------
    
    DT::formatStyle(
      columns = names(tabela_final),
      padding = "6px",
      `white-space` = "normal",
      `vertical-align` = "middle"
    ) |>
      
      
      # --------------------------------------------------------
    # 25. BOTÕES PNG E ECRÃ INTEIRO — BEIRA CICLO 1
    # --------------------------------------------------------
    
    htmlwidgets::onRender(
      htmlwidgets::JS("
        function(el, x) {

          // Estilo dos botões de valores e da legenda da matriz.
          if (!document.getElementById('toc-matriz-botoes-css')) {
            var style = document.createElement('style');
            style.id = 'toc-matriz-botoes-css';
            style.textContent =
              '.toc-valor-botao{' +
              'display:inline-block;min-width:76px;padding:8px 10px;' +
              'border-radius:5px;text-align:center;font-weight:700;' +
              'font-size:12px;white-space:nowrap;box-sizing:border-box;}' +
              '.toc-sem-medicao{' +
              'display:inline-block;min-width:76px;padding:8px 10px;' +
              'border-radius:5px;text-align:center;background:#F5F3F4;' +
              'color:#777;font-weight:600;box-sizing:border-box;}' +
              '.toc-valor-neutro{display:inline-block;padding:8px 10px;' +
              'color:#4B315B;font-weight:600;white-space:nowrap;}';
            document.head.appendChild(style);
          }

          var container = el.parentElement;

          if (!container ||
              container.querySelector('.toc-custom-toolbar')) {
            return;
          }

          // --------------------------------------------------
          // CRIAR BARRA DE BOTÕES
          // --------------------------------------------------

          var toolbar = document.createElement('div');
          toolbar.className = 'toc-custom-toolbar';
          toolbar.style.cssText =
            'display:flex;gap:10px;flex-wrap:wrap;' +
            'margin-bottom:12px;';

          function criarBotao(texto, cor) {
            var btn = document.createElement('button');
            btn.type = 'button';
            btn.textContent = texto;
            btn.style.cssText =
              'background:' + cor + ';color:white;border:0;' +
              'padding:9px 14px;border-radius:5px;' +
              'cursor:pointer;font-weight:bold;';
            return btn;
          }

          var pngButton = criarBotao(
            '📷 Guardar tabela completa em PNG',
            '#8054A2'
          );

          var fullButton = criarBotao(
            '⛶ Ecrã inteiro',
            '#F37238'
          );

          toolbar.appendChild(pngButton);
          toolbar.appendChild(fullButton);

          // Inserir a barra no DOM. Antes, os botões eram criados,
          // mas a barra nunca era adicionada à página.
          container.insertBefore(toolbar, el);

          var legenda = document.createElement('div');
          legenda.style.cssText =
            'display:flex;align-items:center;gap:8px;flex-wrap:wrap;' +
            'margin:0 0 12px 0;font-size:12px;color:#555;';

          var textoMenos = document.createElement('span');
          textoMenos.textContent = 'Menos cumprida';
          legenda.appendChild(textoMenos);

          var escala = document.createElement('div');
          escala.style.cssText = 'display:flex;gap:3px;align-items:center;';
          ['#EBE0F2','#D6C4E2','#B99ACF','#9B75B9','#8054A2']
            .forEach(function(cor) {
              var quadrado = document.createElement('span');
              quadrado.style.cssText =
                'display:inline-block;width:22px;height:12px;' +
                'border-radius:2px;background:' + cor + ';';
              escala.appendChild(quadrado);
            });
          legenda.appendChild(escala);

          var textoMais = document.createElement('span');
          textoMais.textContent = 'Mais cumprida';
          legenda.appendChild(textoMais);

          var semMedicao = document.createElement('span');
          semMedicao.style.cssText =
            'display:inline-block;width:18px;height:12px;' +
            'border-radius:2px;background:#F5F3F4;margin-left:8px;';
          legenda.appendChild(semMedicao);

          var textoSemMedicao = document.createElement('span');
          textoSemMedicao.textContent = 'Sem medição';
          legenda.appendChild(textoSemMedicao);

          container.insertBefore(toolbar, el);
          container.insertBefore(legenda, el);

          // --------------------------------------------------
          // ECRÃ INTEIRO
          // --------------------------------------------------

          fullButton.addEventListener('click', function() {
            if (!document.fullscreenElement) {
              if (container.requestFullscreen) {
                container.requestFullscreen();
              }
            } else if (document.exitFullscreen) {
              document.exitFullscreen();
            }
          });

          // --------------------------------------------------
          // EXPORTAR A MATRIZ COMPLETA EM PNG
          // --------------------------------------------------

          pngButton.addEventListener('click', async function() {

            var $ = window.jQuery;

            if (typeof window.html2canvas !== 'function') {
              alert(
                'A biblioteca html2canvas não está carregada. ' +
                'Verifique a inclusão do script no UI.'
              );
              return;
            }

            // Procurar a tabela real, dentro do corpo DataTables.
            // Com scrollX, o cabeçalho e o corpo podem ter tabelas
            // HTML diferentes.
            var table =
              el.querySelector('.dataTables_scrollBody table.dataTable');

            if (!table) {
              table = el.querySelector('table.dataTable');
            }

            if (!table || !$ || !$.fn.DataTable ||
                !$.fn.DataTable.isDataTable(table)) {
              alert(
                'Não foi possível localizar a tabela DataTables ' +
                'para exportação.'
              );
              return;
            }

            var dt = $(table).DataTable();
            var oldLength = dt.page.len();
            var oldPage = dt.page();

            var wrapper = el.querySelector('.dataTables_wrapper');
            if (!wrapper) {
              wrapper = el;
            }

            var scrollBody =
              wrapper.querySelector('.dataTables_scrollBody');

            var oldScrollHeight =
              scrollBody ? scrollBody.style.height : '';
            var oldScrollMaxHeight =
              scrollBody ? scrollBody.style.maxHeight : '';
            var oldScrollOverflow =
              scrollBody ? scrollBody.style.overflow : '';

            pngButton.disabled = true;
            pngButton.textContent = 'A preparar PNG...';

            try {

              // Mostrar todas as linhas da tabela.
              dt.page.len(-1).draw();

              // Dar tempo ao DataTables para actualizar a tabela.
              await new Promise(function(resolve) {
                setTimeout(resolve, 500);
              });

              // Retirar temporariamente o limite de altura.
              if (scrollBody) {
                scrollBody.style.height = 'auto';
                scrollBody.style.maxHeight = 'none';
                scrollBody.style.overflow = 'visible';
              }

              await new Promise(function(resolve) {
                setTimeout(resolve, 200);
              });

              // Capturar a matriz completa.
              var canvas = await window.html2canvas(wrapper, {
                scale: 2,
                backgroundColor: '#ffffff',
                useCORS: true,
                logging: false,
                width: wrapper.scrollWidth,
                height: wrapper.scrollHeight,
                windowWidth: Math.max(
                  document.documentElement.clientWidth,
                  wrapper.scrollWidth
                ),
                windowHeight: Math.max(
                  document.documentElement.clientHeight,
                  wrapper.scrollHeight
                ),

                onclone: function(doc) {

                  // Esconder os botões na imagem exportada.
                  var clonedToolbar =
                    doc.querySelector('.toc-custom-toolbar');

                  if (clonedToolbar) {
                    clonedToolbar.style.display = 'none';
                  }

                  // Permitir que todas as linhas sejam renderizadas.
                  var clonedBodies =
                    doc.querySelectorAll('.dataTables_scrollBody');

                  clonedBodies.forEach(function(body) {
                    body.style.height = 'auto';
                    body.style.maxHeight = 'none';
                    body.style.overflow = 'visible';
                    body.style.overflowY = 'visible';
                    body.style.overflowX = 'visible';
                  });

                  var clonedScrolls =
                    doc.querySelectorAll('.dataTables_scroll');

                  clonedScrolls.forEach(function(scroll) {
                    scroll.style.height = 'auto';
                    scroll.style.maxHeight = 'none';
                    scroll.style.overflow = 'visible';
                  });

                  var clonedWrappers =
                    doc.querySelectorAll('.dataTables_wrapper');

                  clonedWrappers.forEach(function(w) {
                    w.style.height = 'auto';
                    w.style.maxHeight = 'none';
                    w.style.overflow = 'visible';
                  });
                }
              });

              // Criar o ficheiro PNG.
              var blob = await new Promise(function(resolve) {
                canvas.toBlob(resolve, 'image/png');
              });

              if (!blob) {
                throw new Error(
                  'Não foi possível criar o ficheiro PNG.'
                );
              }

              var url = URL.createObjectURL(blob);
              var link = document.createElement('a');

              link.href = url;
              link.download =
                'Matriz_TOC_PAM_Verde_Beira_Ciclo1.png';

              document.body.appendChild(link);
              link.click();
              link.remove();

              setTimeout(function() {
                URL.revokeObjectURL(url);
              }, 3000);

            } catch (error) {

              console.error(
                'Erro na exportação PNG da matriz Beira C1:',
                error
              );

              alert(
                'Não foi possível gerar o PNG. ' +
                'Abra F12 > Console para consultar o erro.'
              );

            } finally {

              // Restaurar a altura e o comportamento do scroll.
              if (scrollBody) {
                scrollBody.style.height = oldScrollHeight;
                scrollBody.style.maxHeight = oldScrollMaxHeight;
                scrollBody.style.overflow = oldScrollOverflow;
              }

              // Restaurar a paginação original.
              dt.page.len(oldLength).draw();

              setTimeout(function() {
                dt.page(oldPage).draw('page');
                pngButton.disabled = false;
                pngButton.textContent =
                  '📷 Guardar tabela completa em PNG';
              }, 250);
            }
          });
        }
      ")
    )
    
    
  }, server = TRUE)
  
  
  
  
  ########### BOTAO
  # 
  # output$admin_ui <- renderUI({
  #   sidebarLayout(
  #     sidebarPanel(
  #       actionButton("botao_atualizar", "📥 Carregar/Actualizar Dados", class = "btn btn-warning")
  #     ),
  #     mainPanel(
  #       tags$h5("Clique no botão à esquerda para actualizar os dados do sistema."),
  #       verbatimTextOutput("status_atualizacao")
  #     )
  #   )
  # })
  # 
  # # Função principal de atualização
  # atualiza_dados <- function() {
  #   tryCatch({
  #     # Autenticação com Zoho
  #     client_id <- Sys.getenv("CLIENT_ID")
  #     client_secret <- Sys.getenv("CLIENT_SECRET")
  #     refresh_token <- Sys.getenv("REFRESH_TOKEN")
  # 
  #     access_token <- RZohoCreator::refresh_access_token(
  #       client_id, client_secret, refresh_token
  #     )$access_token
  # 
  #     ## 1. Presenças Coletivas
  #     Presencas_colectivas <- RZohoCreator::get_records(
  #       "associacaomuva", "monitoria", "Presen_as_PAM_VERDE_Report", access_token
  #     ) %>%
  #       data.frame()
  # 
  # 
  #     write_xlsx(Presencas_colectivas, "Presencas_colectivas.xlsx")
  # 
  #     # ## 2. Presenças Individuais
  #     # Presencas_Individuais <- RZohoCreator::get_records(
  #     #   "associacaomuva", "monitoria", "Presen_as_Individuais_PAM_Report", access_token
  #     # ) %>%
  #     #   data.frame()
  #     # 
  #     # write_xlsx(Presencas_Individuais, "Presencas_Individuais.xlsx")
  # 
  #     ## 3. Dados Financeiros
  #     Financeiro_Report <- RZohoCreator::get_records(
  #       "associacaomuva", "app-empreendedorismo", "Dados_Financeiros_Report", access_token
  #     )
  # 
  #     write_xlsx(Financeiro_Report, "Financeiro_Report.xlsx")
  # 
  #     # # ## 4. Recursos Humanos
  #     # RH_Empreendedoras <- RZohoCreator::get_records(
  #     #   "associacaomuva", "app-empreendedorismo", "RH_Empreendedoras_Report", access_token
  #     # ) %>%
  #     #   data.frame()
  #     # 
  #     # 
  #     # write_xlsx(RH_Empreendedoras, "RH_Empreendedoras.xlsx")
  # 
  #     ## Retornar os objetos (opcional)
  #     return(list(
  #       # dados = dados,
  #       # Presencas_Individuais = Presencas_Individuais,
  #       Financeiro_Report = Financeiro_Report
  #       # RH_Empreendedoras = RH_Empreendedoras
  #     ))
  #   }, error = function(e) {
  #     message("Erro ao atualizar dados: ", e$message)
  #     return(NULL)
  #   })
  # }
  # #
  # # # Evento ao clicar no botão
  # dados_atualizados <- eventReactive(input$botao_atualizar, {
  #   # Criar log da ação
  #   log_entry <- data.frame(
  #     usuario = "admin",  # como não há mais login, colocar fixo
  #     acao = "Atualizou os dados",
  #     hora = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
  #     stringsAsFactors = FALSE
  #   )
  # 
  #   # Ler e combinar com logs antigos
  #   if (file.exists("log_acoes.xlsx")) {
  #     log_existente <- readxl::read_excel("log_acoes.xlsx")
  #     log_total <- dplyr::bind_rows(log_existente, log_entry)
  #   } else {
  #     log_total <- log_entry
  #   }
  # 
  #   # Salvar o novo log
  #   writexl::write_xlsx(log_total, path = "log_acoes.xlsx")
  # 
  #   # Rodar atualização
  #   atualiza_dados()
  # })
  # 
  # # Mensagem de status
  # output$status_atualizacao <- renderText({
  #   if (input$botao_atualizar > 0) {
  #     if (!is.null(dados_atualizados())) {
  #       paste0(
  #         "✅ Dados actualizados com sucesso em ",
  #         format(Sys.time(), "%d/%m/%Y %H:%M:%S"),
  #         ". Por favor, actualize (refresh) a página no navegador para ver as mudanças."
  #       )
  #     } else {
  #       "⚠️ Erro ao actualizar os dados. Verifique o log."
  #     }
  #   } else {
  #     "⏳ Aguardando actualização..."
  #   }
  # })
  # 
}




# ==========================================================
# RODAR APP
# ==========================================================
shinyApp(ui, server)
