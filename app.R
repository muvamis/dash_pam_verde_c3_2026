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
              column(6,
                     div(
                       style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                       uiOutput("texto_local_venda")
                     ),
                     plotlyOutput("grafico_local_venda")),
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
          
          uiOutput("texto_resultado_exercicio_1"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_1",
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
          
          uiOutput("texto_resultado_exercicio_3"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_3",
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
          
          uiOutput("texto_resultado_exercicio_4"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_4",
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
          
          uiOutput("texto_resultado_exercicio_5"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_5",
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
          
          uiOutput("texto_resultado_exercicio_6"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_6",
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
          
          uiOutput("texto_resultado_exercicio_7"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_7",
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
          
          uiOutput("texto_resultado_exercicio_8"),
          
          plotlyOutput(
            "grafico_resultado_exercicio_8",
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
          
          # ==========================================================
          # ABA FEIRAS - MONITORIA
          # ==========================================================
          
          tabPanel(
            tagList(icon("store"), "Feiras"),
            
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
                    title = "",
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
                plotOutput("grafico1_beira")
              ),
              
              column(
                6,
                plotOutput("grafico2_beira")
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
                
                div(
                  class = "value-box-container",
                  uiOutput("total_participantes_web_beira"),
                  uiOutput("total_sessoes_web_beira"),
                  uiOutput("taxa_presenca_web_beira")
                ),
                
                br(),
                
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
          # FEIRAS BEIRA
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
                
                # div(
                #   class = "value-box-container",
                #   uiOutput("total_participantes_feira_beira"),
                #   uiOutput("total_sessoes_feira_beira"),
                #   uiOutput("taxa_presenca_feira_beira")
                # ),
                # 
                # br(),
                
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
                unique(Financeiro_Report_Agregado_Beira$Nome_do_pesquisador)
              )
            ),
            
            selectInput(
              "Nome_Empreendedora_beira",
              "Selecione a Empreendedora:",
              choices = c(
                "Todas",
                unique(Financeiro_Report_Agregado_Beira$Nome_Empreendedora)
              )
            ),
            
            selectInput(
              "Mes_beira",
              "Selecione o Mês:",
              choices = c(
                "Todos",
                unique(Financeiro_Report_Agregado_Beira$Periodo)
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
                  
                  uiOutput("vb_aumento_lucro_mes_beira"),
                  uiOutput("vb_aumento_25_mes_beira")
                ),
                
                plotlyOutput("grafico_mensal_beira"),
                
                br(),
                
                plotlyOutput("grafico_barras_beira"),
                
                br(),
                
                DTOutput("tabela_controle_lucro_beira")
              )
              
            )
          )
        )
      )
      
    )
  ),
  
  
  
  # ==========================================================
  # ADMIN
  # ==========================================================
  
  tabPanel(
    "ADMIN",
    icon = icon("tools"),
    
    fluidPage(
      uiOutput("admin_ui")
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
          class = "value-box green",
          
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
  # 
  # 
  # # =================================GRÁFICO 1 — PARTICIPANTES POR SEXO==============================
  # 
  # 
  # ===============================================================
  # DADOS FILTRADOS
  # ===============================================================
  dados_filtrados <- reactive({
    
    df <- Pam_Verde_Indicadores
    
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
    
    df %>%
      distinct(Nome_Participante, .keep_all = TRUE)
    
  })

  output$grafico_participantes <- renderPlotly({
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    req("Estado_Civil" %in% names(df))
    
    df_resumo <- df %>%
      filter(!is.na(Estado_Civil), Estado_Civil != "") %>%
      count(Estado_Civil, name = "Total") %>%
      mutate(
        Percentagem = round(Total / sum(Total) * 100, 1)
      )
    
    plot_ly(
      data = df_resumo,
      labels = ~Estado_Civil,
      values = ~Total,
      type = "pie",
      hole = 0.55,
      textinfo = "percent",
      insidetextorientation = "radial",
      marker = list(
        colors = c("#9442d4", "#ff7f0e", "#5cd6c7", "#f9a825", "#d62728"),
        line = list(color = "white", width = 2)
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
      
      tags$b("Estado civil das empreendedoras. "),
      
      "Após a aplicação dos filtros, foram identificadas ",
      
      tags$b(total),
      
      " empreendedoras. A maioria é ",
      
      tags$b(principal),
      
      " (", perc_principal, "%). ",
      
      if (nrow(restantes) > 0)
        paste0("Os restantes estados civis distribuem-se entre ", texto_restantes, ".")
      
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
  
  # 
  # 
  # #   # ==========================================================
  # #   # PÁGINA 2 - Companies situation and performance
  # #   # ==========================================================

  
  ############################ USO DE SERVICOS FINANCEIROS
  
  output$grafico_formalizacao <- renderPlotly({
    
    df <- dados_filtrados()
    
    
    df <- df %>%
      filter(
        !is.na(Negocio_Formalizado),
        !is.na(Tipo_Avaliacao)
      )
    
    
    if(nrow(df) == 0){
      return(plotly_empty())
    }
    
    
    # Frequência
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
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      ungroup()
    
    
    # Ordenação menor para maior
    ordem_formalizacao <- freq_data %>%
      group_by(Negocio_Formalizado) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Negocio_Formalizado)
    
    
    freq_data$Negocio_Formalizado <- factor(
      freq_data$Negocio_Formalizado,
      levels = ordem_formalizacao
    )
    
    
    # Cores
    cores <- c(
      "Não" = "#5cd6c7",
      "Iniciei o processo de formalização" = "#ff7f0e",
      "Sim" = "#9442d4"
    )
    
    
    # Gráfico
    plot_ly(
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~pct,
      
      color = ~Negocio_Formalizado,
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
      ),
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        barmode = "stack",
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
          ticksuffix = "%"
        ),
        
        xaxis = list(
          title = ""
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
  
  
  output$grafico_servicos_financeiros <- renderPlotly({
    
    df <- dados_filtrados()
    
    
    df <- df %>%
      filter(
        !is.na(Uso_Servicos_Financeiros),
        !is.na(Tipo_Avaliacao)
      ) %>%
      separate_rows(
        Uso_Servicos_Financeiros,
        sep = ",(?=[A-Z])"
      ) %>%
      mutate(
        Uso_Servicos_Financeiros =
          trimws(Uso_Servicos_Financeiros)
      )
    
    
    if(nrow(df) == 0){
      return(plotly_empty())
    }
    
    
    freq_data <- df %>%
      group_by(
        Tipo_Avaliacao,
        Uso_Servicos_Financeiros
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        percent = round(n / sum(n) * 100,1),
        label = paste0(percent,"%")
      ) %>%
      ungroup()
    
    
    # Ordenar menor para maior
    ordem_servicos <- freq_data %>%
      group_by(Uso_Servicos_Financeiros) %>%
      summarise(
        total = sum(percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Uso_Servicos_Financeiros)
    
    
    freq_data$Uso_Servicos_Financeiros <- factor(
      freq_data$Uso_Servicos_Financeiros,
      levels = ordem_servicos
    )
    
    
    # Cores
    cores <- c(
      "Nenhum destes serviços" = "#5cd6c7",
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)" = "#f9a825",
      "Crédito ou empréstimo bancário para o negócio" = "#2ca02c",
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)" = "#bcbd22",
      "Conta bancária em nome do negócio (conta empresarial)" = "#9442d4",
      "Conta poupança formal ligada ao negócio" = "#ff7f0e",
      "Seguro (de negócio, de equipamento, de saúde...)" = "#d62728"
    )
    
    
    plot_ly(
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~percent,
      
      color = ~Uso_Servicos_Financeiros,
      colors = cores,
      
      type = "bar",
      
      text = ~label,
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
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
          ticksuffix = "%"
        ),
        
        xaxis = list(
          title = ""
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
          b = 150
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
    
    # =============================
    # Dados com todos os filtros
    # =============================
    df <- dados_filtrados()
    
    
    # =============================
    # Preparação
    # =============================
    df <- df %>%
      filter(
        !is.na(Tira_Salario_Para_Si),
        !is.na(Tipo_Avaliacao)
      )
    
    
    if(nrow(df) == 0){
      return(plotly_empty())
    }
    
    
    # =============================
    # Frequência e percentagem
    # =============================
    freq_data <- df %>%
      group_by(
        Tipo_Avaliacao,
        Tira_Salario_Para_Si
      ) %>%
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      ungroup()
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_salario <- freq_data %>%
      group_by(Tira_Salario_Para_Si) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Tira_Salario_Para_Si)
    
    
    freq_data$Tira_Salario_Para_Si <- factor(
      freq_data$Tira_Salario_Para_Si,
      levels = ordem_salario
    )
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Não, não retiro nenhum valor para mim mesma" = "#5cd6c7",
      "Retiro de forma irregular, conforme o negócio tem dinheiro" = "#ff7f0e",
      "Sim, retiro um valor fixo todos os meses" = "#9442d4"
    )
    
    
    # =============================
    # Gráfico
    # =============================
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
        
        barmode = "stack",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
          b = 130
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
    
    # =============================
    # Dados com todos os filtros
    # =============================
    df <- dados_filtrados()
    
    
    # =============================
    # Criar categorias
    # =============================
    dados_cat <- df %>%
      filter(!is.na(Clientes_Regulares_Negocio)) %>%
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
    
    
    if(nrow(dados_cat) == 0){
      return(plotly_empty())
    }
    
    
    # =============================
    # Ordem lógica
    # =============================
    dados_cat$categoria <- factor(
      dados_cat$categoria,
      levels = c(
        "0–5",
        "6–10",
        "11–20",
        ">20"
      )
    )
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "0–5"   = "#5cd6c7",
      "6–10"  = "#ff7f0e",
      "11–20" = "#F39C12",
      ">20"   = "#9442d4"
    )
    
    
    # =============================
    # Gráfico
    # =============================
    p <- ggplot(
      dados_cat,
      aes(
        x = categoria,
        y = Percent,
        fill = categoria,
        text = paste0(
          categoria,
          ": ",
          Percent,
          "%"
        )
      )
    ) +
      
      geom_col(
        width = 0.7
      ) +
      
      geom_text(
        aes(
          label = paste0(Percent,"%")
        ),
        vjust = -0.3,
        size = 4,
        fontface = "bold"
      ) +
      
      scale_fill_manual(
        values = cores
      ) +
      
      scale_y_continuous(
        limits = c(0,100)
      ) +
      
      labs(
        title = "",
        x = "",
        y = "Percentagem (%)"
      ) +
      
      theme_minimal() +
      
      theme(
        legend.position = "none",
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        )
      )
    
    
    ggplotly(
      p,
      tooltip = "text"
    ) %>%
      layout(
        
        title = "",
        
        xaxis = list(
          title = "",
          tickfont = list(size = 12)
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
          ticksuffix = "%"
        ),
        
        margin = list(
          l = 60,
          r = 20,
          t = 20,
          b = 80
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Quem_Toma_Decisoes_Negocio"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    # =============================
    # Resumo
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Quem_Toma_Decisoes_Negocio)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Quem_Toma_Decisoes_Negocio
      ) %>%
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          Total / sum(Total) * 100,
          1
        )
      ) %>%
      ungroup()
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_decisao <- df_resumo %>%
      group_by(Quem_Toma_Decisoes_Negocio) %>%
      summarise(
        total = sum(Percentagem),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Quem_Toma_Decisoes_Negocio)
    
    
    df_resumo$Quem_Toma_Decisoes_Negocio <- factor(
      df_resumo$Quem_Toma_Decisoes_Negocio,
      levels = ordem_decisao
    )
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Só eu" = "#9442d4",
      "Eu juntamente com outra pessoa" = "#ff7f0e",
      "Outra pessoa" = "#5cd6c7"
    )
    
    
    # =============================
    # Gráfico
    # =============================
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
          range = c(0,100),
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
          b = 130
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Negociacao_Com_Agregado_Familiar"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Preparação dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Com_Agregado_Familiar)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Negociacao_Com_Agregado_Familiar
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_agregado <- df_resumo %>%
      group_by(Negociacao_Com_Agregado_Familiar) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Negociacao_Com_Agregado_Familiar)
    
    
    df_resumo$Negociacao_Com_Agregado_Familiar <- factor(
      df_resumo$Negociacao_Com_Agregado_Familiar,
      levels = ordem_agregado
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiante e sei defender a minha posição" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
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
        
        xaxis = list(
          title = ""
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
          b = 130
        ),
        
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Negociacao_Com_Clientes"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Preparação dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Com_Clientes)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Negociacao_Com_Clientes
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_clientes <- df_resumo %>%
      group_by(Negociacao_Com_Clientes) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Negociacao_Com_Clientes)
    
    
    df_resumo$Negociacao_Com_Clientes <- factor(
      df_resumo$Negociacao_Com_Clientes,
      levels = ordem_clientes
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiante e sei defender a minha posição" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
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
        
        xaxis = list(
          title = ""
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
          b = 130
        ),
        
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Negociacao_Pessoas_Com_Quem_Trabalha"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Preparação dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Negociacao_Pessoas_Com_Quem_Trabalha)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Negociacao_Pessoas_Com_Quem_Trabalha
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_funcionarios <- df_resumo %>%
      group_by(Negociacao_Pessoas_Com_Quem_Trabalha) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Negociacao_Pessoas_Com_Quem_Trabalha)
    
    
    df_resumo$Negociacao_Pessoas_Com_Quem_Trabalha <- factor(
      df_resumo$Negociacao_Pessoas_Com_Quem_Trabalha,
      levels = ordem_funcionarios
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não me sinto confiante/ não sei negociar" = "#5cd6c7",
      "Depende /de certa forma" = "#ff7f0e",
      "Sim, sinto-me confiante e sei defender a minha posição" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
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
        
        xaxis = list(
          title = ""
        ),
        
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
          b = 130
        ),
        
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Uso_de_ferramentas_de_IA"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Limpeza e resumo
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Uso_de_ferramentas_de_IA),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        Uso_de_ferramentas_de_IA
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
        label = paste0(pct,"%")
      ) %>%
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_ia <- freq_data %>%
      group_by(Uso_de_ferramentas_de_IA) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Uso_de_ferramentas_de_IA)
    
    
    
    freq_data$Uso_de_ferramentas_de_IA <- factor(
      freq_data$Uso_de_ferramentas_de_IA,
      levels = ordem_ia
    )
    
    
    
    # =============================
    # Cores manuais
    # =============================
    cores <- c(
      "Não, nunca usei e não sei bem o que é" = "#69C7BE",
      "Ouvi falar mas nunca experimentei" = "#f39c12",
      "Sim, usei pelo menos uma vez" = "#ff7f0e",
      "Sim, uso regularmente para o negócio" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
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
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
          b = 140
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Faz controlo do dinheiro que entra e que sai (receitas e despesas)"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Resumo
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Faz controlo do dinheiro que entra e que sai (receitas e despesas)`
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_controle <- df_resumo %>%
      group_by(`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`)
    
    
    
    df_resumo$`Faz controlo do dinheiro que entra e que sai (receitas e despesas)` <- factor(
      df_resumo$`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`,
      levels = ordem_controle
    )
    
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Não" = "#69C7BE",
      "Sim" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~`Faz controlo do dinheiro que entra e que sai (receitas e despesas)`,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percent,"%"),
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
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Faz separação das contas pessoais e do negócio"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Resumo dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Faz separação das contas pessoais e do negócio`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Faz separação das contas pessoais e do negócio`
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_contas <- df_resumo %>%
      group_by(`Faz separação das contas pessoais e do negócio`) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Faz separação das contas pessoais e do negócio`)
    
    
    
    df_resumo$`Faz separação das contas pessoais e do negócio` <- factor(
      df_resumo$`Faz separação das contas pessoais e do negócio`,
      levels = ordem_contas
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não" = "#69C7BE",
      "Sim" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~`Faz separação das contas pessoais e do negócio`,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percent,"%"),
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
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Sabe calcular o lucro do negócio  (com base no exercício prático)"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Resumo dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Sabe calcular o lucro do negócio  (com base no exercício prático)`)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `Sabe calcular o lucro do negócio  (com base no exercício prático)`
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_lucro <- df_resumo %>%
      group_by(`Sabe calcular o lucro do negócio  (com base no exercício prático)`) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Sabe calcular o lucro do negócio  (com base no exercício prático)`)
    
    
    
    df_resumo$`Sabe calcular o lucro do negócio  (com base no exercício prático)` <- factor(
      df_resumo$`Sabe calcular o lucro do negócio  (com base no exercício prático)`,
      levels = ordem_lucro
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não" = "#69C7BE",
      "Sim" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~`Sabe calcular o lucro do negócio  (com base no exercício prático)`,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percent,"%"),
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
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Praticou_negociação_nos_últimos_3meses"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Preparação dos dados
    # =============================
    df_resumo <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Praticou_negociação_nos_últimos_3meses)
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
    
    
    
    if(nrow(df_resumo) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_negociacao <- df_resumo %>%
      group_by(Praticou_negociação_nos_últimos_3meses) %>%
      summarise(
        total = sum(Percent),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(Praticou_negociação_nos_últimos_3meses)
    
    
    
    df_resumo$Praticou_negociação_nos_últimos_3meses <- factor(
      df_resumo$Praticou_negociação_nos_últimos_3meses,
      levels = ordem_negociacao
    )
    
    
    
    # =============================
    # Cores fixas
    # =============================
    cores <- c(
      "Não tive situações de negociação neste período" = "#69C7BE",
      "Não, aceitei as condições sem negociar" = "#F39C12",
      "Sim, negociei, mas não consegui mudar as condições" = "#F37238",
      "Sim, negociei e consegui um acordo favorável para o meu negócio" = "#9442d4"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      data = df_resumo,
      
      x = ~Tipo_Avaliacao,
      y = ~Percent,
      
      color = ~Praticou_negociação_nos_últimos_3meses,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(Percent,"%"),
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
          range = c(0,100),
          ticksuffix = "%"
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
  
  
  # ============================================================
  # Dados filtrados para Local de Venda
  # ============================================================
  # ============================================================
  # Dados filtrados
  # ============================================================
  
  dados_local_venda <- reactive({
    
    dados <- Pam_Verde_Indicadores
    
    
    # Filtro Cidade
    if(input$filtro_cidade != "Todas"){
      
      dados <- dados %>%
        filter(
          Cidade == input$filtro_cidade
        )
      
    }
    
    
    # Filtro Ciclo
    if(input$filtro_ciclo != "Todos"){
      
      dados <- dados %>%
        filter(
          Ciclo == input$filtro_ciclo
        )
      
    }
    
    
    # Filtro Tipo Avaliação
    if(input$filtro_tipo_avaliacao != "Todos"){
      
      dados <- dados %>%
        filter(
          Tipo_Avaliacao == input$filtro_tipo_avaliacao
        )
      
    }
    
    
    dados
    
  })
  
  
  
  # ============================================================
  # Função para encurtar nomes dos canais
  # ============================================================
  
  padronizar_canais <- function(x){
    
    case_when(
      
      x == "Loja ou banca própria (física)" ~ 
        "Loja/banca própria",
      
      x == "Venda em casa (clientes que vêm a casa)" ~
        "Venda em casa",
      
      x == "Mercado ou feira" ~
        "Mercado/feira",
      
      x == "Na loja ou banca de outra pessoa (consignação ou parceria)" ~
        "Consignação/parceria",
      
      x == "Entrega ao domicílio (delivery)" ~
        "Delivery",
      
      x == "WhatsApp / WhatsApp Business" ~
        "WhatsApp",
      
      x == "Outro website ou plataforma online" ~
        "Website/plataforma",
      
      TRUE ~ x
      
    )
    
  }
  
  
  
  # ============================================================
  # Cores manuais
  # ============================================================
  
  cores_local_venda <- c(
    
    "WhatsApp" = "#9442d4",
    
    "Mercado/feira" = "#F37238",
    
    "Delivery" = "#F39C12",
    
    "Loja/banca própria" = "#69C7BE",
    
    "Facebook" = "#1877F2",
    
    "Instagram" = "#007793",
    
    "Venda em casa" = "#b8c0ff",
    
    "Consignação/parceria" = "#f15bb5",
    
    "Website/plataforma" = "#70d6ff",
    
    "Outros" = "#757575"
    
  )
  
  
  
  # ============================================================
  # Texto resumo + Top 5
  # ============================================================
  
  output$texto_local_venda <- renderUI({
    
    dados <- dados_local_venda()
    
    
    total <- nrow(dados)
    
    
    top5 <- dados %>%
      
      filter(
        !is.na(Onde_vende),
        Onde_vende != ""
      ) %>%
      
      separate_rows(
        Onde_vende,
        sep = ","
      ) %>%
      
      mutate(
        
        Onde_vende = trimws(Onde_vende),
        
        Onde_vende = padronizar_canais(Onde_vende)
        
      ) %>%
      
      count(
        Onde_vende,
        name = "Total"
      ) %>%
      
      arrange(
        desc(Total)
      ) %>%
      
      slice_head(
        n = 5
      )
    
    
    lista_top5 <- paste0(
      
      top5$Onde_vende,
      
      " (",
      
      top5$Total,
      
      ")"
      
    )
    
    
    div(
      
      HTML(
        
        paste0(
          
          "<b>Locais de venda dos produtos ou serviços</b><br>",
          
          "Total de empreendedoras analisadas: <b>",
          total,
          "</b><br><br>",
          
          "<b>Top 5 canais mais utilizados:</b><br>",
          
          paste(
            lista_top5,
            collapse = " | "
          )
          
        )
        
      )
      
    )
    
    
  })
  
  
  
  # ============================================================
  # Gráfico Local de Venda
  # ============================================================
  
  output$grafico_local_venda <- renderPlotly({
    
    
    dados <- dados_local_venda()
    
    
    
    dados_grafico <- dados %>%
      
      filter(
        
        !is.na(Onde_vende),
        
        Onde_vende != ""
        
      ) %>%
      
      
      separate_rows(
        
        Onde_vende,
        
        sep = ","
        
      ) %>%
      
      
      mutate(
        
        Onde_vende = trimws(Onde_vende),
        
        Onde_vende = padronizar_canais(Onde_vende)
        
      ) %>%
      
      
      count(
        
        Onde_vende,
        
        name = "Total"
        
      ) %>%
      
      
      arrange(
        
        Total
        
      )
    
    
    
    # ============================================================
    # Aplicar cores
    # ============================================================
    
    dados_grafico <- dados_grafico %>%
      
      mutate(
        
        Cor = cores_local_venda[Onde_vende]
        
      )
    
    
    # Cor padrão para categorias sem definição
    
    dados_grafico$Cor[
      is.na(dados_grafico$Cor)
    ] <- "#034EA2"
    
    
    
    # ============================================================
    # Plotly
    # ============================================================
    
    plot_ly(
      
      data = dados_grafico,
      
      x = ~Total,
      
      y = ~reorder(Onde_vende, Total),
      
      type = "bar",
      
      orientation = "h",
      
      text = ~Total,
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        
        color = "white",
        
        size = 13,
        
        family = "Arial"
        
      ),
      
      marker = list(
        
        color = ~Cor
        
      ),
      
      hovertemplate = paste(
        
        "<b>%{y}</b>",
        
        "<br>Número de empreendedoras: %{x}",
        
        "<extra></extra>"
        
      )
      
    ) %>%
      
      
      layout(
        
        title = "",
        
        paper_bgcolor = "#f5f3f4",
        
        plot_bgcolor = "#f5f3f4",
        
        xaxis = list(
          
          title = "Número de empreendedoras"
          
        ),
        
        yaxis = list(
          
          title = "",
          
          automargin = TRUE
          
        ),
        
        margin = list(
          
          l = 220,
          
          r = 40,
          
          t = 30,
          
          b = 50
          
        )
        
      ) %>%
      
      
      config(
        
        displayModeBar = TRUE,
        
        displaylogo = FALSE,
        
        responsive = TRUE,
        
        scrollZoom = TRUE,
        
        toImageButtonOptions = list(
          
          format = "png",
          
          filename = "canais_de_venda",
          
          height = 800,
          
          width = 1400,
          
          scale = 3
          
        )
        
      )
    
    
  })
#################################### CONSCIENCIA DE GENERO
  output$grafico_H_Financeiros <- renderPlotly({
    
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados ."
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100,1),
        label = paste0(pct,"%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data)==0){
      return(plotly_empty())
    }
    
    
    
    # Ordem menor para maior
    ordem_genero <- freq_data %>%
      group_by(`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`) %>%
      summarise(
        total=sum(pct),
        .groups="drop"
      ) %>%
      arrange(total) %>%
      pull(`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`)
    
    
    
    freq_data$`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .` <- factor(
      freq_data$`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`,
      levels = ordem_genero
    )
    
    
    
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~pct,
      
      color = ~`Os homens tem mais facilidade em acessar produtos financeiros, redes ou novos mercados .`,
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      
      textfont = list(
        color="#ffffff",
        size=12
      ),
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      )
      
    ) %>%
      
      layout(
        
        barmode="stack",
        
        xaxis=list(
          title=""
        ),
        
        yaxis=list(
          title="Percentagem (%)",
          range=c(0,100),
          ticksuffix="%"
        ),
        
        legend=list(
          orientation="h",
          x=0.5,
          xanchor="center",
          y=-0.25
        ),
        
        margin=list(
          l=60,
          r=20,
          t=20,
          b=130
        ),
        
        paper_bgcolor="#f5f3f4",
        plot_bgcolor="#f5f3f4"
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Os homens são levados mais a sério como empreendedores."
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Os homens são levados mais a sério como empreendedores.`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Os homens são levados mais a sério como empreendedores.`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct,"%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_serios <- freq_data %>%
      group_by(`Os homens são levados mais a sério como empreendedores.`) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Os homens são levados mais a sério como empreendedores.`)
    
    
    
    freq_data$`Os homens são levados mais a sério como empreendedores.` <- factor(
      freq_data$`Os homens são levados mais a sério como empreendedores.`,
      levels = ordem_serios
    )
    
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Os homens são levados mais a sério como empreendedores.`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Homens são mais capazes de negociar do que as mulheres."
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Homens são mais capazes de negociar do que as mulheres.`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Homens são mais capazes de negociar do que as mulheres.`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct,"%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_capazes <- freq_data %>%
      group_by(`Homens são mais capazes de negociar do que as mulheres.`) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Homens são mais capazes de negociar do que as mulheres.`)
    
    
    
    freq_data$`Homens são mais capazes de negociar do que as mulheres.` <- factor(
      freq_data$`Homens são mais capazes de negociar do que as mulheres.`,
      levels = ordem_capazes
    )
    
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Homens são mais capazes de negociar do que as mulheres.`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens."
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_domesticas <- freq_data %>%
      group_by(`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`)
    
    
    
    freq_data$`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.` <- factor(
      freq_data$`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`,
      levels = ordem_domesticas
    )
    
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Todas as responsabilidades domésticas são obrigação da mulher e, por isso, tem menos tempo para o negócio que homens.`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Não se espera que as mulheres sejam capazes de gerir um negócio."
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Não se espera que as mulheres sejam capazes de gerir um negócio.`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Não se espera que as mulheres sejam capazes de gerir um negócio.`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordenar menor para maior %
    # =============================
    ordem_gerir <- freq_data %>%
      group_by(`Não se espera que as mulheres sejam capazes de gerir um negócio.`) %>%
      summarise(
        total = sum(pct),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(`Não se espera que as mulheres sejam capazes de gerir um negócio.`)
    
    
    
    freq_data$`Não se espera que as mulheres sejam capazes de gerir um negócio.` <- factor(
      freq_data$`Não se espera que as mulheres sejam capazes de gerir um negócio.`,
      levels = ordem_gerir
    )
    
    
    
    # =============================
    # Cores
    # =============================
    cores <- c(
      "Discordo" = "#F77333",
      "Depende" = "#ffc107",
      "Concordo" = "#69C7BE"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Não se espera que as mulheres sejam capazes de gerir um negócio.`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
  
  
  output$graficoPontuacaoNampula <- renderPlotly({
    
    # =========================
    # DADOS BASE
    # =========================
    df <- Pegada_Carbono
    
    # =========================
    # FILTRO CIDADE
    # =========================
    df <- df %>%
      filter(Cidade == "Nampula")
    
    # =========================
    # FILTRO ANO
    # =========================
    if (!is.null(input$ano_pegada) &&
        input$ano_pegada != "Todos") {
      
      df <- df %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    # =========================
    # FILTRO CICLO
    # =========================
    if (!is.null(input$ciclo_pegada) &&
        input$ciclo_pegada != "Todos") {
      
      df <- df %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    req(nrow(df) > 0)
    
    # =========================
    # RESUMO
    # =========================
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
    
    # =========================
    # ORDEM
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
    p <- ggplot(
      dados_contagem,
      aes(
        x = Status_Pegada,
        y = num_participantes,
        fill = Status_Pegada,
        text = paste0(
          "<b>Cidade:</b> Nampula",
          "<br><b>Status:</b> ",
          Status_Pegada,
          "<br><b>Participantes:</b> ",
          num_participantes,
          "<br><b>Percentagem:</b> ",
          Percentagem,
          "%",
          "<br><b>Avaliação:</b> ",
          Tipo_Avaliacao
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(label = label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      
      facet_wrap(
        ~ Tipo_Avaliacao
      ) +
      
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
        
        axis.text.y = element_text(
          size = 11
        ),
        
        panel.border = element_rect(
          color = "black",
          fill = NA,
          linewidth = 0.4
        ),
        
        panel.spacing = unit(
          1,
          "lines"
        )
      )
    
    # =========================
    # PLOTLY
    # =========================
    ggplotly(
      p,
      tooltip = "text"
    ) %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        margin = list(
          l = 60,
          r = 20,
          t = 60,
          b = 80
        )
      )
  })
  
  output$graficoPontuacaoBeira <- renderPlotly({
    
    # =========================
    # DADOS BASE
    # =========================
    df <- Pegada_Carbono
    
    # =========================
    # FILTRO CIDADE
    # =========================
    df <- df %>%
      filter(Cidade == "Beira")
    
    # =========================
    # FILTRO ANO
    # =========================
    if (!is.null(input$ano_pegada) &&
        input$ano_pegada != "Todos") {
      
      df <- df %>%
        filter(Ano_Projeto == as.character(input$ano_pegada))
    }
    
    # =========================
    # FILTRO CICLO
    # =========================
    if (!is.null(input$ciclo_pegada) &&
        input$ciclo_pegada != "Todos") {
      
      df <- df %>%
        filter(Ciclo == input$ciclo_pegada)
    }
    
    req(nrow(df) > 0)
    
    # =========================
    # RESUMO
    # =========================
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
    
    # =========================
    # ORDEM
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
    p <- ggplot(
      dados_contagem,
      aes(
        x = Status_Pegada,
        y = num_participantes,
        fill = Status_Pegada,
        text = paste0(
          "<b>Cidade:</b> Beira",
          "<br><b>Status:</b> ",
          Status_Pegada,
          "<br><b>Participantes:</b> ",
          num_participantes,
          "<br><b>Percentagem:</b> ",
          Percentagem,
          "%",
          "<br><b>Avaliação:</b> ",
          Tipo_Avaliacao
        )
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(label = label),
        position = position_stack(vjust = 0.5),
        color = "white",
        size = 4,
        fontface = "bold"
      ) +
      
      facet_wrap(
        ~ Tipo_Avaliacao
      ) +
      
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
        
        axis.text.y = element_text(
          size = 11
        ),
        
        panel.border = element_rect(
          color = "black",
          fill = NA,
          linewidth = 0.4
        ),
        
        panel.spacing = unit(
          1,
          "lines"
        )
      )
    
    # =========================
    # PLOTLY
    # =========================
    ggplotly(
      p,
      tooltip = "text"
    ) %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor = "#f5f3f4",
        
        margin = list(
          l = 60,
          r = 20,
          t = 60,
          b = 80
        )
      )
  })
 
  
  output$grafico_conhecimento_ambiental <- renderPlotly({
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Nível_de_conhecimento_ambiental"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(Nível_de_conhecimento_ambiental)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        Nível_de_conhecimento_ambiental
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordem lógica
    # =============================
    ordem_ambiental <- c(
      "Básico — já ouvi falar, mas não sei muito",
      "Bom — estou ciente dos problemas",
      "Muito bom — compreendo bem e tento manter-me informada"
    )
    
    
    freq_data$Nível_de_conhecimento_ambiental <- factor(
      freq_data$Nível_de_conhecimento_ambiental,
      levels = ordem_ambiental
    )
    
    
    
    # =============================
    # Cores manuais
    # =============================
    cores <- c(
      "Básico — já ouvi falar, mas não sei muito" = "#69C7BE",
      "Bom — estou ciente dos problemas" = "#f39c12",
      "Muito bom — compreendo bem e tento manter-me informada" = "#8054A2"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~Nível_de_conhecimento_ambiental,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
        "<b>Nível_de_conhecimento_ambiental:</b><br>",
        melhor,
        "% das empreendedoras demonstram um nível elevado de conhecimento ambiental, ",
        "revelando maior consciência sobre problemas ambientais e necessidade de informação."
      )
    )
  })
  
  output$grafico_impacto_ambiental_negocio <- renderPlotly({
    
    # =============================
    # Dados com filtros aplicados
    # =============================
    df <- dados_filtrados()
    
    
    req(all(c(
      "Tipo_Avaliacao",
      "Em que medida tem consciência do impacto ambiental do seu negócio?"
    ) %in% colnames(df)))
    
    
    req(nrow(df) > 0)
    
    
    
    # =============================
    # Frequência + percentagem
    # =============================
    freq_data <- df %>%
      filter(
        !is.na(Tipo_Avaliacao),
        !is.na(`Em que medida tem consciência do impacto ambiental do seu negócio?`)
      ) %>%
      
      group_by(
        Tipo_Avaliacao,
        `Em que medida tem consciência do impacto ambiental do seu negócio?`
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(Tipo_Avaliacao) %>%
      
      mutate(
        pct = round(n / sum(n) * 100, 1),
        label = paste0(pct, "%")
      ) %>%
      
      ungroup()
    
    
    
    if(nrow(freq_data) == 0){
      return(plotly_empty())
    }
    
    
    
    # =============================
    # Ordem lógica
    # =============================
    ordem_impacto <- c(
      "Não conheço a relação entre a minha actividade e o impacto ambiental",
      "Basicamente, sei que o que faço pode poluir ou ter impacto",
      "Bom — estou ciente disso e tento reduzi-lo",
      "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental"
    )
    
    
    freq_data$`Em que medida tem consciência do impacto ambiental do seu negócio?` <- factor(
      freq_data$`Em que medida tem consciência do impacto ambiental do seu negócio?`,
      levels = ordem_impacto
    )
    
    
    
    # =============================
    # Cores manuais
    # =============================
    cores <- c(
      "Não conheço a relação entre a minha actividade e o impacto ambiental" = "#69C7BE",
      "Basicamente, sei que o que faço pode poluir ou ter impacto" = "#f9a825",
      "Bom — estou ciente disso e tento reduzi-lo" = "#F37238",
      "Muito bom — procuro activamente formas de reduzir o meu impacto ambiental" = "#8054A2"
    )
    
    
    
    # =============================
    # Gráfico
    # =============================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Em que medida tem consciência do impacto ambiental do seu negócio?`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~label,
      texttemplate = "%{text}",
      textposition = "inside",
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 12
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
          title = "Percentagem (%)",
          range = c(0,100),
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
        "<b>Em que medida tem consciência do impacto ambiental do seu negócio?:</b><br>",
        consciente,
        "% das participantes demonstram consciência sobre o impacto ambiental ",
        "das suas actividades económicas, indicando reconhecimento da relação entre negócio e ambiente."
      )
    )
  })
  
  output$grafico_praticas_sustentaveis <- renderPlotly({
    
    # =========================
    # BASE COM FILTROS
    # =========================
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    
    # =========================
    # LIMPEZA
    # =========================
    df <- df %>%
      dplyr::filter(
        !is.na(`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`),
        !is.na(Tipo_Avaliacao)
      )
    
    
    req(nrow(df) > 0)
    
    
    # =========================
    # FREQUÊNCIA E PERCENTAGEM
    # =========================
    freq_data <- df %>%
      dplyr::group_by(
        Tipo_Avaliacao,
        `Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`
      ) %>%
      dplyr::summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      dplyr::group_by(Tipo_Avaliacao) %>%
      dplyr::mutate(
        pct = round(n / sum(n) * 100, 1)
      ) %>%
      dplyr::ungroup()
    
    
    # =========================
    # ORDEM DAS CATEGORIAS
    # =========================
    freq_data$`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?` <- factor(
      freq_data$`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`,
      levels = c(
        "Não, não consigo identificar nenhuma prática sustentável para o meu negócio",
        "Sim"
      )
    )
    
    
    # =========================
    # CORES
    # =========================
    cores <- c(
      "Não, não consigo identificar nenhuma prática sustentável para o meu negócio" = "#69C7BE",
      "Sim" = "#8054A2"
    )
    
    
    # =========================
    # GRÁFICO
    # =========================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      y = ~pct,
      
      color = ~`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`,
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(pct, "%"),
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        "<b>%{x}</b><br>",
        "%{fullData.name}<br>",
        "Percentagem: %{y:.1f}%<extra></extra>"
      ),
      
      textfont = list(
        color = "#FFFFFF",
        size = 12
      )
      
    ) %>%
      
      layout(
        
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
          range = c(0,100),
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
  
  
  
  # =====================================================
  # TEXTO INTERPRETATIVO
  # =====================================================
  
  output$texto_praticas_sustentaveis <- renderUI({
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    
    resumo <- df %>%
      filter(
        !is.na(`Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`)
      ) %>%
      count(
        `Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`
      ) %>%
      mutate(
        Percentagem = round(n / sum(n) * 100,1)
      )
    
    
    sim <- resumo %>%
      filter(
        `Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?`
        == "Sim"
      ) %>%
      pull(Percentagem)
    
    
    sim <- ifelse(length(sim)==0,0,sim)
    
    
    HTML(
      paste0(
        "<b>Consegue identificar pelo menos uma prática sustentável aplicável ao seu negócio?:</b><br><br>",
        
        "<b>", sim, "%</b> dos participantes conseguem identificar ",
        "pelo menos uma prática sustentável aplicável ao seu negócio, ",
        "demonstrando maior conhecimento sobre soluções ambientais ",
        "nas suas actividades."
      )
    )
  })
  
  
  # =====================================================
  # GRÁFICO - Aplicação de práticas sustentáveis
  # =====================================================
  
  output$grafico_aplica_praticas <- renderPlotly({
    
    
    # =========================
    # BASE COM FILTROS
    # =========================
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    
    # =========================
    # LIMPEZA
    # =========================
    
    df <- df %>%
      dplyr::filter(
        !is.na(`Já aplica esta prática no seu negócio?`),
        !is.na(Tipo_Avaliacao)
      )
    
    
    req(nrow(df) > 0)
    
    
    # =========================
    # FREQUÊNCIA E PERCENTAGEM
    # =========================
    
    freq_data <- df %>%
      
      dplyr::group_by(
        Tipo_Avaliacao,
        `Já aplica esta prática no seu negócio?`
      ) %>%
      
      dplyr::summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      dplyr::group_by(
        Tipo_Avaliacao
      ) %>%
      
      dplyr::mutate(
        pct = round(n / sum(n) * 100,1)
      ) %>%
      
      dplyr::ungroup()
    
    
    
    # =========================
    # ORDEM DAS CATEGORIAS
    # =========================
    
    freq_data$`Já aplica esta prática no seu negócio?` <- factor(
      
      freq_data$`Já aplica esta prática no seu negócio?`,
      
      levels = c(
        "Ainda não, mas planejo aplicar em breve",
        "Já tentei mas encontrei obstáculos",
        "Sim, já aplico"
      )
      
    )
    
    
    
    # =========================
    # CORES MANUAIS
    # =========================
    
    cores <- c(
      
      "Ainda não, mas planejo aplicar em breve" = "#69C7BE",
      
      "Já tentei mas encontrei obstáculos" = "#F9A825",
      
      "Sim, já aplico" = "#8054A2"
      
    )
    
    
    
    # =========================
    # GRÁFICO
    # =========================
    
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~pct,
      
      color = ~`Já aplica esta prática no seu negócio?`,
      
      colors = cores,
      
      type = "bar",
      
      text = ~paste0(pct,"%"),
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      hovertemplate = paste(
        
        "<b>%{x}</b><br>",
        
        "%{fullData.name}<br>",
        
        "Percentagem: %{y:.1f}%<extra></extra>"
        
      ),
      
      textfont = list(
        color = "#FFFFFF",
        size = 12
      )
      
    ) %>%
      
      layout(
        
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
          range = c(0,100),
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
  
  
  
  
  # =====================================================
  # TEXTO INTERPRETATIVO
  # =====================================================
  
  output$texto_aplica_praticas <- renderUI({
    
    
    df <- dados_filtrados()
    
    req(nrow(df) > 0)
    
    
    resumo <- df %>%
      
      filter(
        !is.na(`Já aplica esta prática no seu negócio?`)
      ) %>%
      
      count(
        `Já aplica esta prática no seu negócio?`
      ) %>%
      
      mutate(
        Percentagem = round(n / sum(n) * 100,1)
      )
    
    
    
    aplica <- resumo %>%
      
      filter(
        `Já aplica esta prática no seu negócio?`
        == "Sim, já aplico"
      ) %>%
      
      pull(Percentagem)
    
    
    aplica <- ifelse(
      length(aplica)==0,
      0,
      aplica
    )
    
    
    
    nao_aplica <- resumo %>%
      
      filter(
        `Já aplica esta prática no seu negócio?`
        == "Ainda não, mas planejo aplicar em breve"
      ) %>%
      
      pull(Percentagem)
    
    
    nao_aplica <- ifelse(
      length(nao_aplica)==0,
      0,
      nao_aplica
    )
    
    
    
    HTML(
      
      paste0(
        
        "<b>Aplicação de práticas sustentáveis no negócio:</b><br><br>",
        
        "<b>", aplica, "%</b> dos participantes já aplicam ",
        "práticas sustentáveis nos seus negócios. ",
        
        "<br><br>",
        
        "<b>", nao_aplica, "%</b> ainda não aplicam, ",
        "mas demonstram intenção de implementar futuramente."
        
      )
      
    )
    
  })
################## EXERCICIOS RESULTADOS
  # ============================================================
  # Dados do Exercício 1
  # ============================================================
  
  dados_exercicio_1 <- reactive({
    
    dados_filtrados() %>%
      count(
        Tipo_Avaliacao,
        `Reconheceu a relação de poder como problema`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(100 * n / sum(n), 1)
      ) %>%
      ungroup()
    
  })
  
  # ============================================================
  # Gráfico
  # ============================================================
  
  output$grafico_resultado_exercicio_1 <- renderPlotly({
    
    df <- dados_exercicio_1()
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Reconheceu a relação de poder como problema`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(label = paste0(Percentagem, "%")),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      scale_y_continuous(
        limits = c(0,100),
        expand = expansion(mult = c(0,0.02))
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank(),
        axis.title.x = element_blank()
      )
    
    ggplotly(g, tooltip = c("x","fill","y")) %>%
      layout(
        title = "",
        barmode = "stack",
        xaxis = list(title = ""),
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
          ticksuffix = "%"
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
  
  # ============================================================
  # Texto de interpretação
  # ============================================================
  
  output$texto_resultado_exercicio_1 <- renderUI({
    
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
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes reconheceram a relação de poder como um problema, ",
        "<b>", baseline$Parcialmente, "%</b> reconheceram parcialmente esta situação e ",
        "<b>", baseline$Não, "%</b> não a identificaram como problemática. ",
        "No <b>Endline</b>, <b>", endline$Sim, "%</b> reconheceram a relação de poder como um problema, ",
        "<b>", endline$Parcialmente, "%</b> reconheceram parcialmente esta situação e ",
        "<b>", endline$Não, "%</b> não a identificaram como problemática."
      )
    )
    
  })
  
  dados_exercicio_2 <- reactive({
    
    dados_filtrados() %>%
      count(
        Tipo_Avaliacao,
        `Identificou o impacto no negócio`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(100 * n / sum(n), 1)
      ) %>%
      ungroup()
    
  })
  
  
  output$grafico_resultado_exercicio_2 <- renderPlotly({
    
    df <- dados_exercicio_2()
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Identificou o impacto no negócio`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(label = paste0(Percentagem, "%")),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      scale_y_continuous(
        limits = c(0,100),
        expand = expansion(mult = c(0,0.02))
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
      tooltip = c("x","fill","y")
    ) %>%
      
      layout(
        
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
          range = c(0,100),
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
  
  output$texto_resultado_exercicio_2 <- renderUI({
    
    texto <- dados_exercicio_2() %>%
      select(
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
    
    baseline <- texto %>% filter(Tipo_Avaliacao == "Baseline")
    endline  <- texto %>% filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes identificaram o impacto no negócio, ",
        "<b>", baseline$Parcialmente, "%</b> reconheceram parcialmente este impacto e ",
        "<b>", baseline$Não, "%</b> não identificaram impactos no negócio. ",
        "No <b>Endline</b>, <b>", endline$Sim, "%</b> identificaram o impacto no negócio, ",
        "<b>", endline$Parcialmente, "%</b> reconheceram parcialmente este impacto e ",
        "<b>", endline$Não, "%</b> não identificaram impactos no negócio."
      )
    )
    
  })
  
  # ============================================================
  # Dados Exercício 3
  # ============================================================
  
  dados_exercicio_3 <- reactive({
    
    dados_filtrados() %>%
      count(
        Tipo_Avaliacao,
        `Sugeriu uma estratégia de resposta para a Joana`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(100 * n / sum(n), 1)
      ) %>%
      ungroup()
    
  })
  
  
  # ============================================================
  # Gráfico Exercício 3
  # ============================================================
  
  output$grafico_resultado_exercicio_3 <- renderPlotly({
    
    df <- dados_exercicio_3()
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Sugeriu uma estratégia de resposta para a Joana`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(label = paste0(Percentagem, "%")),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      scale_y_continuous(
        limits = c(0,100)
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank()
      )
    
    
    ggplotly(
      g,
      tooltip = c("x","fill","y")
    ) %>%
      
      layout(
        barmode = "stack",
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
  # Texto Exercício 3
  # ============================================================
  
  output$texto_resultado_exercicio_3 <- renderUI({
    
    texto <- dados_exercicio_3() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `Sugeriu uma estratégia de resposta para a Joana`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>% filter(Tipo_Avaliacao == "Baseline")
    endline <- texto %>% filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes sugeriram uma estratégia de resposta para a Joana, ",
        "<b>", baseline$Parcialmente, "%</b> apresentaram uma sugestão parcial e ",
        "<b>", baseline$Não, "%</b> não sugeriram nenhuma estratégia. ",
        "No <b>Endline</b>, <b>", endline$Sim, "%</b> sugeriram uma estratégia de resposta, ",
        "<b>", endline$Parcialmente, "%</b> apresentaram uma sugestão parcial e ",
        "<b>", endline$Não, "%</b> não sugeriram uma estratégia."
      )
    )
    
  })
  
  
  
  # ============================================================
# Dados Exercício 4
# ============================================================
  dados_exercicio_4 <- reactive({
    
    dados_filtrados() %>%
      count(
        Tipo_Avaliacao,
        `Sugeriu uma estratégia de resposta para a Joana`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(100 * n / sum(n), 1)
      ) %>%
      ungroup()
    
  })
  
  
  # ============================================================
  # Gráfico Exercício 3
  # ============================================================
  
  output$grafico_resultado_exercicio_3 <- renderPlotly({
    
    df <- dados_exercicio_3()
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `Sugeriu uma estratégia de resposta para a Joana`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(label = paste0(Percentagem, "%")),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Parcialmente" = "#f9a825",
          "Não" = "#69C7BE"
        )
      ) +
      
      labs(
        x = "",
        y = "Percentagem (%)",
        fill = ""
      ) +
      
      scale_y_continuous(
        limits = c(0,100)
      ) +
      
      theme_stata() +
      
      theme(
        panel.grid.major.x = element_blank(),
        legend.position = "bottom",
        legend.title = element_blank()
      )
    
    
    ggplotly(
      g,
      tooltip = c("x","fill","y")
    ) %>%
      
      layout(
        barmode = "stack",
        yaxis = list(
          title = "Percentagem (%)",
          range = c(0,100),
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
  # Texto Exercício 3
  # ============================================================
  
  output$texto_resultado_exercicio_3 <- renderUI({
    
    texto <- dados_exercicio_3() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `Sugeriu uma estratégia de resposta para a Joana`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>% filter(Tipo_Avaliacao == "Baseline")
    endline <- texto %>% filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes sugeriram uma estratégia de resposta para a Joana, ",
        "<b>", baseline$Parcialmente, "%</b> apresentaram uma sugestão parcial e ",
        "<b>", baseline$Não, "%</b> não sugeriram nenhuma estratégia. ",
        "No <b>Endline</b>, <b>", endline$Sim, "%</b> sugeriram uma estratégia de resposta, ",
        "<b>", endline$Parcialmente, "%</b> apresentaram uma sugestão parcial e ",
        "<b>", endline$Não, "%</b> não sugeriram uma estratégia."
      )
    )
    
  })
  
  # =====

# ============================================================
# Gráfico Exercício 4
# ============================================================
# ============================================================
# Dados - Exercício 4
# ============================================================

dados_exercicio_4 <- reactive({

  dados_filtrados() %>%
    mutate(
      `Indicou que passa por situações semelhantes` = trimws(
        `Indicou que passa por situações semelhantes`
      ),
      `Indicou que passa por situações semelhantes` = case_when(
        `Indicou que passa por situações semelhantes` %in% c("Sim", "SIM", "sim") ~ "Sim",
        `Indicou que passa por situações semelhantes` %in% c("Nao", "NAO", "não", "Não", "NÃO") ~ "Não",
        `Indicou que passa por situações semelhantes` == "Parcialmente" ~ "Parcialmente",
        TRUE ~ `Indicou que passa por situações semelhantes`
      )
    ) %>%
    count(
      Tipo_Avaliacao,
      `Indicou que passa por situações semelhantes`
    ) %>%
    group_by(Tipo_Avaliacao) %>%
    mutate(
      Percentagem = round(100 * n / sum(n), 1)
    ) %>%
    ungroup()
})

# ============================================================
# Gráfico - Exercício 4
# (ordem invertida)
# ============================================================

output$grafico_resultado_exercicio_4 <- renderPlotly({

  df <- dados_exercicio_4()

  # Ordem das categorias (ranking) invertida
  ordem <- df %>%
    group_by(`Indicou que passa por situações semelhantes`) %>%
    summarise(
      total = mean(Percentagem, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    arrange(total) %>%   # <- INVERTEI A ORDEM AQUI (era arrange(desc(total)))
    pull(`Indicou que passa por situações semelhantes`)

  df$`Indicou que passa por situações semelhantes` <- factor(
    df$`Indicou que passa por situações semelhantes`,
    levels = ordem
  )

  g <- ggplot(
    df,
    aes(
      x = Tipo_Avaliacao,
      y = Percentagem,
      fill = `Indicou que passa por situações semelhantes`
    )
  ) +
    geom_col(width = 0.65) +
    geom_text(
      aes(label = ifelse(Percentagem > 0, paste0(Percentagem, "%"), "")),
      position = position_stack(vjust = 0.5),
      colour = "black",
      fontface = "bold",
      size = 4
    ) +
    scale_fill_manual(
      values = c(
        "Sim" = "#8054A2",
        "Parcialmente" = "#f9a825",
        "Não" = "#69C7BE"
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
      expand = expansion(mult = c(0, 0.02))
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
    tooltip = c("x", "fill", "y")
  ) %>%
    layout(
      title = "",
      barmode = "stack",
      height = 500,
      xaxis = list(title = "", tickfont = list(size = 12)),
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
      margin = list(l = 70, r = 30, t = 30, b = 140),
      paper_bgcolor = "#f5f3f4",
      plot_bgcolor = "#f5f3f4"
    )
})

# ============================================================
# Texto - Exercício 4
# ============================================================

output$texto_resultado_exercicio_4 <- renderUI({

  texto <- dados_exercicio_4() %>%
    tidyr::pivot_wider(
      id_cols = Tipo_Avaliacao,
      names_from = `Indicou que passa por situações semelhantes`,
      values_from = Percentagem,
      values_fill = 0
    )

  baseline <- texto %>% filter(Tipo_Avaliacao == "Baseline")
  endline  <- texto %>% filter(Tipo_Avaliacao == "Endline")

  HTML(
    paste0(
      "<b>Resumo:</b> ",
      "No <b>Baseline</b>, <b>", baseline$Sim, "%</b> dos participantes indicaram que passam por situações semelhantes, ",
      "<b>", baseline$Parcialmente, "%</b> reconheceram parcialmente situações semelhantes e ",
      "<b>", baseline$Não, "%</b> indicaram não passar por situações semelhantes. ",
      "No <b>Endline</b>, <b>", endline$Sim, "%</b> indicaram que passam por situações semelhantes, ",
      "<b>", endline$Parcialmente, "%</b> reconheceram parcialmente situações semelhantes e ",
      "<b>", endline$Não, "%</b> indicaram não passar por situações semelhantes."
    )
  )
})
  
  # ============================================================
  # DADOS – EXERCÍCIO 5
  # A1 – Cálculo de lucro
  # ============================================================
  
  dados_exercicio_5 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`A1 — Cálculo de lucro`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `A1 — Cálculo de lucro`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 5
  # ============================================================
  
  output$grafico_resultado_exercicio_5 <- renderPlotly({
    
    df <- dados_exercicio_5()
    
    # Ordem das categorias
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A1 — Cálculo de lucro` <- factor(
      df$`A1 — Cálculo de lucro`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A1 — Cálculo de lucro`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(
          vjust = 0.5
        ),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
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
      tooltip = c(
        "x",
        "fill",
        "y"
      )
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
  # TEXTO – EXERCÍCIO 5
  # ============================================================
  
  output$texto_resultado_exercicio_5 <- renderUI({
    
    texto <- dados_exercicio_5() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A1 — Cálculo de lucro`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$`2.Demonstra claramente`,
        "%</b> dos participantes demonstraram claramente a capacidade de calcular o lucro, ",
        
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente a capacidade de calcular o lucro, ",
        
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        endline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema."
      )
    )
  })
  
  # ============================================================
  # DADOS – EXERCÍCIO 6
  # A2 – META DE VENDAS
  # ============================================================
  
  dados_exercicio_6 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`A2 — Meta de vendas`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `A2 — Meta de vendas`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 6
  # ============================================================
  
  output$grafico_resultado_exercicio_6 <- renderPlotly({
    
    df <- dados_exercicio_6()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A2 — Meta de vendas` <- factor(
      df$`A2 — Meta de vendas`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A2 — Meta de vendas`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
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
        expand = expansion(mult = c(0, 0.02))
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 6
  # ============================================================
  
  output$texto_resultado_exercicio_6 <- renderUI({
    
    texto <- dados_exercicio_6() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A2 — Meta de vendas`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>",
        baseline$`2.Demonstra claramente`,
        "%</b> dos participantes demonstraram claramente capacidade de definir uma meta de vendas, ",
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente capacidade de definir uma meta de vendas, ",
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>",
        endline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema."
      )
    )
  })
  
  # ============================================================
  # DADOS – EXERCÍCIO 7
  # A3 – PREPARAÇÃO PARA PICO
  # ============================================================
  
  dados_exercicio_7 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`A3 — Preparação para pico`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `A3 — Preparação para pico`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 7
  # ============================================================
  
  output$grafico_resultado_exercicio_7 <- renderPlotly({
    
    df <- dados_exercicio_7()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A3 — Preparação para pico` <- factor(
      df$`A3 — Preparação para pico`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A3 — Preparação para pico`
      )
    ) +
      
      geom_col(width = 0.65) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
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
        expand = expansion(mult = c(0, 0.02))
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 7
  # ============================================================
  
  output$texto_resultado_exercicio_7 <- renderUI({
    
    texto <- dados_exercicio_7() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A3 — Preparação para pico`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        "No <b>Baseline</b>, <b>",
        baseline$`2.Demonstra claramente`,
        "%</b> dos participantes demonstraram claramente capacidade de preparação para períodos de maior movimento, ",
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente capacidade de preparação para períodos de maior movimento, ",
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        "<b>",
        endline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema."
      )
    )
  })
  
  # ============================================================
  # DADOS – EXERCÍCIO 8
  # A4 – ACOMPANHAMENTO
  # ============================================================
  
  dados_exercicio_8 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`A4 — Acompanhamento`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `A4 — Acompanhamento`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 8
  # ============================================================
  
  output$grafico_resultado_exercicio_8 <- renderPlotly({
    
    df <- dados_exercicio_8()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A4 — Acompanhamento` <- factor(
      df$`A4 — Acompanhamento`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A4 — Acompanhamento`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "0.Ausente ou fora do tema" = "#69C7BE",
          "1.Vago ou parcial" = "#f9a825",
          "2.Demonstra claramente" = "#8054A2"
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 8
  # ============================================================
  
  output$texto_resultado_exercicio_8 <- renderUI({
    
    texto <- dados_exercicio_8() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A4 — Acompanhamento`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$`2.Demonstra claramente`,
        "%</b> dos participantes demonstraram claramente uma forma de acompanhar as suas vendas, ",
        
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente uma forma de acompanhar as suas vendas, ",
        
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        endline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema."
      )
    )
  })
  
  # ============================================================
  # DADOS – EXERCÍCIO 9
  # N1 – PERGUNTOU O MOTIVO DO AUMENTO
  # ============================================================
  
  dados_exercicio_9 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`N1 — Perguntou o motivo do aumento (não aceitou sem questionar)`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `N1 — Perguntou o motivo do aumento (não aceitou sem questionar)`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 9
  # ============================================================
  
  output$grafico_resultado_exercicio_9 <- renderPlotly({
    
    df <- dados_exercicio_9()
    
    ordem <- c(
      "Não",
      "Sim"
    )
    
    df$`N1 — Perguntou o motivo do aumento (não aceitou sem questionar)` <- factor(
      df$`N1 — Perguntou o motivo do aumento (não aceitou sem questionar)`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `N1 — Perguntou o motivo do aumento (não aceitou sem questionar)`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Não" = "#69C7BE"
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
      tooltip = c(
        "x",
        "fill",
        "y"
      )
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
  # TEXTO – EXERCÍCIO 9
  # ============================================================
  
  output$texto_resultado_exercicio_9 <- renderUI({
    
    texto <- dados_exercicio_9() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `N1 — Perguntou o motivo do aumento (não aceitou sem questionar)`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$Sim,
        "%</b> dos participantes perguntaram o motivo do aumento de preço, ",
        
        "enquanto <b>",
        baseline$Não,
        "%</b> não questionaram o aumento. ",
        
        "No <b>Endline</b>, <b>",
        endline$Sim,
        "%</b> perguntaram o motivo do aumento de preço, ",
        
        "enquanto <b>",
        endline$Não,
        "%</b> não questionaram o aumento."
      )
    )
  })
  
  
  # ============================================================
  # DADOS – EXERCÍCIO 10
  # N2 – PROPÔS UMA ALTERNATIVA CONCRETA
  # ============================================================
  
  dados_exercicio_10 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 10
  # ============================================================
  
  output$grafico_resultado_exercicio_10 <- renderPlotly({
    
    df <- dados_exercicio_10()
    
    ordem <- c(
      "Não",
      "Sim"
    )
    
    df$`N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)` <- factor(
      df$`N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Não" = "#69C7BE"
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 10
  # ============================================================
  
  output$texto_resultado_exercicio_10 <- renderUI({
    
    texto <- dados_exercicio_10() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `N2 — Propôs uma alternativa concreta (ex: pagamento à vista, maior quantidade, encomenda antecipada)`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$Sim,
        "%</b> dos participantes propuseram uma alternativa concreta ao fornecedor, ",
        
        "enquanto <b>",
        baseline$Não,
        "%</b> não apresentaram uma alternativa. ",
        
        "No <b>Endline</b>, <b>",
        endline$Sim,
        "%</b> propuseram uma alternativa concreta, ",
        
        "enquanto <b>",
        endline$Não,
        "%</b> não apresentaram uma alternativa."
      )
    )
  })
  
  
  # ============================================================
  # DADOS – EXERCÍCIO 11
  # N3 – PROCURAR OUTROS FORNECEDORES / COMPARAR PREÇOS
  # ============================================================
  
  dados_exercicio_11 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 11
  # ============================================================
  
  output$grafico_resultado_exercicio_11 <- renderPlotly({
    
    df <- dados_exercicio_11()
    
    ordem <- c(
      "Não",
      "Sim"
    )
    
    df$`N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços` <- factor(
      df$`N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Não" = "#69C7BE"
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 11
  # ============================================================
  
  output$texto_resultado_exercicio_11 <- renderUI({
    
    texto <- dados_exercicio_11() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `N3 — Referiu a possibilidade de procurar outros fornecedores ou comparar preços`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$Sim,
        "%</b> dos participantes referiram a possibilidade de procurar outros fornecedores ou comparar preços, ",
        
        "enquanto <b>",
        baseline$Não,
        "%</b> não referiram essa possibilidade. ",
        
        "No <b>Endline</b>, <b>",
        endline$Sim,
        "%</b> referiram a possibilidade de procurar outros fornecedores ou comparar preços, ",
        
        "enquanto <b>",
        endline$Não,
        "%</b> não referiram essa possibilidade."
      )
    )
  })
  
  # ============================================================
  # DADOS – EXERCÍCIO 12
  # N4 – MANTEVE A POSIÇÃO SEM CEDER IMEDIATAMENTE
  # ============================================================
  
  dados_exercicio_12 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 12
  # ============================================================
  
  output$grafico_resultado_exercicio_12 <- renderPlotly({
    
    df <- dados_exercicio_12()
    
    ordem <- c(
      "Não",
      "Sim"
    )
    
    df$`N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso` <- factor(
      df$`N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Não" = "#69C7BE"
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 12
  # ============================================================
  
  output$texto_resultado_exercicio_12 <- renderUI({
    
    texto <- dados_exercicio_12() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `N4 — Manteve a sua posição sem ceder imediatamente, com tom respeitoso`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$Sim,
        "%</b> dos participantes mantiveram a sua posição sem ceder imediatamente, utilizando um tom respeitoso, ",
        
        "enquanto <b>",
        baseline$Não,
        "%</b> não demonstraram este comportamento. ",
        
        "No <b>Endline</b>, <b>",
        endline$Sim,
        "%</b> mantiveram a sua posição sem ceder imediatamente, utilizando um tom respeitoso, ",
        
        "enquanto <b>",
        endline$Não,
        "%</b> não demonstraram este comportamento."
      )
    )
  })
  
  
  # ============================================================
  # DADOS – EXERCÍCIO 13
  # N5 – PROPÔS UM ACORDO / SOLUÇÃO INTERMÉDIA
  # ============================================================
  
  dados_exercicio_13 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`N5 — Propôs um acordo, solução intermédia ou continuação da negociação`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      count(
        Tipo_Avaliacao,
        `N5 — Propôs um acordo, solução intermédia ou continuação da negociação`
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 13
  # ============================================================
  
  output$grafico_resultado_exercicio_13 <- renderPlotly({
    
    df <- dados_exercicio_13()
    
    ordem <- c(
      "Não",
      "Sim"
    )
    
    df$`N5 — Propôs um acordo, solução intermédia ou continuação da negociação` <- factor(
      df$`N5 — Propôs um acordo, solução intermédia ou continuação da negociação`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `N5 — Propôs um acordo, solução intermédia ou continuação da negociação`
      )
    ) +
      
      geom_col(
        width = 0.65
      ) +
      
      geom_text(
        aes(
          label = ifelse(
            Percentagem > 0,
            paste0(Percentagem, "%"),
            ""
          )
        ),
        position = position_stack(vjust = 0.5),
        colour = "black",
        fontface = "bold",
        size = 4
      ) +
      
      scale_fill_manual(
        values = c(
          "Sim" = "#8054A2",
          "Não" = "#69C7BE"
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
      tooltip = c("x", "fill", "y")
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
  # TEXTO – EXERCÍCIO 13
  # ============================================================
  
  output$texto_resultado_exercicio_13 <- renderUI({
    
    texto <- dados_exercicio_13() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `N5 — Propôs um acordo, solução intermédia ou continuação da negociação`,
        values_from = Percentagem,
        values_fill = 0
      )
    
    baseline <- texto %>%
      filter(Tipo_Avaliacao == "Baseline")
    
    endline <- texto %>%
      filter(Tipo_Avaliacao == "Endline")
    
    HTML(
      paste0(
        "<b>Resumo:</b> ",
        
        "No <b>Baseline</b>, <b>",
        baseline$Sim,
        "%</b> dos participantes propuseram um acordo, uma solução intermédia ou a continuação da negociação, ",
        
        "enquanto <b>",
        baseline$Não,
        "%</b> não apresentaram este tipo de proposta. ",
        
        "No <b>Endline</b>, <b>",
        endline$Sim,
        "%</b> propuseram um acordo, uma solução intermédia ou a continuação da negociação, ",
        
        "enquanto <b>",
        endline$Não,
        "%</b> não apresentaram este tipo de proposta."
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
  
  output$grafico1 <- renderPlot({
    
    dados <- dados_geral()
    
    total_selecionadas <- nrow(dados)
    
    total_iniciaram <- dados %>%
      dplyr::filter(
        Status %in% c("Activa", "Desistente")
      ) %>%
      nrow()
    
    
    grafico_df <- data.frame(
      Categoria = c(
        "Selecionadas",
        "Iniciaram Formação"
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
          scales::percent(
            Percentual,
            accuracy = 1
          ),
          ")"
        )
      )
    
    
    grafico_df$Categoria <- factor(
      grafico_df$Categoria,
      levels = c(
        "Selecionadas",
        "Iniciaram Formação"
      )
    )
    
    
    ggplot(
      grafico_df,
      aes(
        x = Categoria,
        y = Percentual,
        fill = Categoria
      )
    ) +
      
      geom_bar(
        stat = "identity",
        width = 0.6
      ) +
      
      # ===========================================================
    # VALORES NO MEIO DAS BARRAS
    # ===========================================================
    
    geom_text(
      aes(
        label = Label
      ),
      position = position_stack(
        vjust = 0.5
      ),
      color = "white",
      size = 6.5,
      fontface = "bold"
    ) +
      
      scale_y_continuous(
        labels = scales::percent_format(
          accuracy = 1
        ),
        limits = c(0, 1),
        expand = expansion(
          mult = c(0, 0.05)
        )
      ) +
      
      scale_fill_manual(
        values = c(
          "Selecionadas" = "#ff7f0e",
          "Iniciaram Formação" = "#8054A2"
        )
      ) +
      
      labs(
        title = "Selecionadas vs Início da Formação",
        x = NULL,
        y = "Percentagem"
      ) +
      
      theme_stata() +
      
      theme(
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 13,
          face = "bold"
        ),
        
        axis.text.y = element_text(
          size = 12
        ),
        
        axis.title.y = element_text(
          size = 13,
          face = "bold"
        ),
        
        legend.position = "none",
        
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        )
      )
  })
  
  

  output$grafico2 <- renderPlot({
    
    dados <- dados_geral()
    
    # ============================================================
    # 1. LIMPAR E PADRONIZAR STATUS
    # ============================================================
    
    dados <- dados %>%
      dplyr::mutate(
        Status = toupper(
          stringr::str_squish(
            trimws(as.character(Status))
          )
        )
      )
    
    # ============================================================
    # 2. IDENTIFICAR OS QUE INICIARAM A FORMAÇÃO
    # ============================================================
    
    dados_iniciaram <- dados %>%
      dplyr::filter(
        Status %in% c(
          "ACTIVA",
          "ACTIVAS",
          "ATIVA",
          "ATIVAS",
          "DESISTENTE",
          "DESISTENTES"
        )
      )
    
    # ============================================================
    # 3. TOTAL POR STATUS
    # ============================================================
    
    total_activas <- dados_iniciaram %>%
      dplyr::filter(
        Status %in% c(
          "ACTIVA",
          "ACTIVAS",
          "ATIVA",
          "ATIVAS"
        )
      ) %>%
      nrow()
    
    total_desistentes <- dados_iniciaram %>%
      dplyr::filter(
        Status %in% c(
          "DESISTENTE",
          "DESISTENTES"
        )
      ) %>%
      nrow()
    
    # ============================================================
    # 4. TOTAL DOS QUE INICIARAM
    # ============================================================
    
    total_iniciaram <- total_activas + total_desistentes
    
    # Evitar divisão por zero
    if (total_iniciaram == 0) {
      return(
        ggplot() +
          annotate(
            "text",
            x = 1,
            y = 1,
            label = "Não existem dados de Activas ou Desistentes",
            size = 6,
            fontface = "bold"
          ) +
          theme_void()
      )
    }
    
    # ============================================================
    # 5. BASE PARA O GRÁFICO
    # ============================================================
    
    resumo <- data.frame(
      Categoria = c(
        "Activas",
        "Desistentes"
      ),
      
      Valor = c(
        total_activas,
        total_desistentes
      )
    ) %>%
      dplyr::mutate(
        
        Percentual = Valor / total_iniciaram,
        
        Label = paste0(
          Valor,
          "\n",
          scales::percent(
            Percentual,
            accuracy = 1
          )
        )
      )
    
    # Ordem das barras
    resumo$Categoria <- factor(
      resumo$Categoria,
      levels = c(
        "Activas",
        "Desistentes"
      )
    )
    
    # ============================================================
    # 6. GRÁFICO — BARRAS LADO A LADO
    # ============================================================
    
    ggplot(
      resumo,
      aes(
        x = Categoria,
        y = Percentual,
        fill = Categoria
      )
    ) +
      
      # Barras lado a lado
      geom_col(
        width = 0.65
      ) +
      
      # Valores no centro das barras
      geom_text(
        aes(
          label = Label
        ),
        position = position_stack(
          vjust = 0.5
        ),
        color = "white",
        size = 6.5,
        fontface = "bold",
        lineheight = 0.9
      ) +
      
      # Eixo Y em percentagem
      scale_y_continuous(
        labels = scales::percent_format(
          accuracy = 1
        ),
        limits = c(0, 1),
        expand = expansion(
          mult = c(0, 0.05)
        )
      ) +
      
      # Cores
      scale_fill_manual(
        values = c(
          "Activas" = "#8054A2",
          "Desistentes" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      # Títulos
      labs(
        title = "Distribuição dos que Iniciaram a Formação",
        x = NULL,
        y = "Percentagem",
        fill = "Status"
      ) +
      
      # Tema
      theme_stata() +
      
      theme(
        
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 14,
          face = "bold"
        ),
        
        axis.text.y = element_text(
          size = 12
        ),
        
        axis.title.y = element_text(
          size = 13,
          face = "bold"
        ),
        
        legend.text = element_text(
          size = 13
        ),
        
        legend.title = element_text(
          size = 13,
          face = "bold"
        ),
        
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        )
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
    previsto <- 43
    
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
  
  # ==========================================================
  # FEIRAS - MONITORIA
  # ==========================================================
  
  
  # ==========================================================
  # Atualizar cidades
  # ==========================================================
  
  observe({
    
    cidades <- Feiras %>%
      pull(Cidade) %>%
      unique() %>%
      sort()
    
    
    updateSelectInput(
      session,
      "filtro_monitoria_feira",
      choices = c("Todas", cidades)
    )
    
  })
  
  
  
  # ==========================================================
  # Atualizar pesquisadores conforme cidade
  # ==========================================================
  
  observeEvent(
    input$filtro_monitoria_feira,
    {
      
      if(input$filtro_monitoria_feira == "Todas"){
        
        pesquisadores <- Feiras %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
      } else {
        
        pesquisadores <- Feiras %>%
          filter(
            Cidade == input$filtro_monitoria_feira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
      }
      
      
      updateSelectInput(
        session,
        "pesquisador_feira",
        choices = c("Todas", pesquisadores),
        selected = "Todas"
      )
      
    }
  )
  
  
  
  # ==========================================================
  # Dados filtrados
  # ==========================================================
  
  dados_filtrados_feira <- reactive({
    
    df <- Feiras
    
    
    if(input$filtro_monitoria_feira != "Todas"){
      
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_feira
        )
      
    }
    
    
    if(input$pesquisador_feira != "Todas"){
      
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_feira
        )
      
    }
    
    
    df
    
  })
  
  
  
  # ==========================================================
  # KPI - Total Participantes
  # ==========================================================
  # 
  # output$total_participantes_feira <- renderUI({
  #   
  #   df <- dados_filtrados_feira()
  #   
  #   total <- nrow(df)
  #   
  #   
  #   valueBox(
  #     value = total,
  #     subtitle = "Participantes",
  #     icon = icon("users"),
  #     color = "purple"
  #   )
  #   
  # })
  # 
  # 
  # 
  # # ==========================================================
  # # KPI - Total Sessões
  # # ==========================================================
  # 
  # output$total_sessoes_feira <- renderUI({
  #   
  #   df <- dados_filtrados_feira()
  #   
  #   sessoes <- grep(
  #     "^Sessao_\\d+$",
  #     names(df),
  #     value = TRUE
  #   )
  #   
  #   
  #   valueBox(
  #     value = length(sessoes),
  #     subtitle = "Sessões",
  #     icon = icon("calendar"),
  #     color = "blue"
  #   )
  #   
  # })
  # 
  # 
  # 
  # # ==========================================================
  # # KPI - Taxa média presença
  # # ==========================================================
  # 
  # output$taxa_presenca_feira <- renderUI({
  #   
  #   df <- dados_filtrados_feira()
  #   
  #   
  #   sessoes <- grep(
  #     "^Sessao_\\d+$",
  #     names(df),
  #     value = TRUE
  #   )
  #   
  #   
  #   total_presencas <- df %>%
  #     select(all_of(sessoes)) %>%
  #     unlist() %>%
  #     as.character() %>%
  #     str_detect("Presente") %>%
  #     sum(
  #       na.rm = TRUE
  #     )
  #   
  #   
  #   total_possivel <- nrow(df) * length(sessoes)
  #   
  #   
  #   taxa <- round(
  #     (total_presencas / total_possivel) * 100,
  #     1
  #   )
  #   
  #   
  #   valueBox(
  #     value = paste0(taxa,"%"),
  #     subtitle = "Taxa de Presença",
  #     icon = icon("percent"),
  #     color = "green"
  #   )
  #   
  # })
  # 
  
  
  # ==========================================================
  # Preparar dados gráfico
  # ==========================================================
  
  dados_plot_feira <- reactive({
    
    df <- dados_filtrados_feira()
    
    
    previsto <- 43
    
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    df_long <- df %>%
      select(all_of(sessoes)) %>%
      pivot_longer(
        cols = everything(),
        names_to = "Sessoes",
        values_to = "Presenca"
      )
    
    
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
        Previsto = previsto,
        Percentual = round(
          Count / Previsto * 100,
          1
        ),
        Ordem = as.numeric(
          gsub(
            "Sessao_",
            "",
            Sessoes
          )
        )
      ) %>%
      arrange(Ordem) %>%
      mutate(
        Sessoes = factor(
          Sessoes,
          levels = Sessoes
        )
      )
    
    
    df_agg
    
  })
  
  
  
  # ==========================================================
  # Gráfico
  # ==========================================================
  
  output$grafico_feira <- renderPlotly({
    
    df <- dados_plot_feira()
    
    
    if(nrow(df)==0){
      return(NULL)
    }
    
    
    g <- ggplot(
      df,
      aes(
        x=Sessoes,
        y=Count,
        fill=Sessoes
      )
    ) +
      
      geom_col() +
      
      geom_hline(
        yintercept = unique(df$Previsto),
        linetype="dashed",
        color="purple"
      ) +
      
      geom_text(
        aes(
          label=paste0(
            Count,
            "\n(",
            Percentual,
            "%)"
          )
        ),
        vjust=-0.3,
        fontface="bold"
      ) +
      
      theme_stata() +
      
      labs(
        title="Presenças por Sessão - Feiras",
        x="",
        y="Presenças"
      )
    
    
    ggplotly(g)
    
  })
  
  
  
  # ==========================================================
  # Texto automático
  # ==========================================================
  
  output$texto_feira <- renderUI({
    
    df <- dados_plot_feira()
    
    if(nrow(df)==0){
      return(NULL)
    }
    
    
    maior <- df %>%
      arrange(desc(Count)) %>%
      slice(1)
    
    
    HTML(
      paste0(
        "<b>Resumo:</b> A sessão com maior participação foi ",
        maior$Sessoes,
        " com ",
        maior$Count,
        " participantes."
      )
    )
    
  })
  
  
  
  # ==========================================================
  # Tabela
  # ==========================================================
  
  output$tabela_feira <- renderDT({
    
    df <- dados_filtrados_feira()
    
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value = TRUE
    )
    
    
    sessoes <- sessoes[
      order(
        as.numeric(
          gsub(
            "Sessao_",
            "",
            sessoes
          )
        )
      )
    ]
    
    
    fixas <- setdiff(
      names(df),
      sessoes
    )
    
    
    df <- df[
      ,
      c(fixas,sessoes)
    ]
    
    
    df[sessoes] <- lapply(
      df[sessoes],
      formatar_pontos
    )
    
    
    datatable(
      df,
      escape = FALSE,
      options=list(
        pageLength=10,
        scrollX=TRUE
      )
    )
    
  })
  
  # # # =========================
  # # # DADOS FINANCEIROS NAMPULA
  # # # =========================
  
  
  
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
  
  
  # =====================================================
  # ATUALIZAR EMPREENDEDORAS CONFORME PESQUISADOR
  # =====================================================
  
  observeEvent(input$Pesquisador, {
    
    df <- Financeiro_Report_Agregado
    
    if (!is.null(input$Pesquisador) &&
        input$Pesquisador != "Todos") {
      
      df <- df %>%
        dplyr::filter(
          Nome_do_pesquisador == input$Pesquisador
        )
    }
    
    
    empreendedoras <- df %>%
      dplyr::select(Nome_Empreendedora) %>%
      dplyr::distinct() %>%
      dplyr::arrange(Nome_Empreendedora) %>%
      dplyr::pull(Nome_Empreendedora)
    
    
    updateSelectInput(
      session,
      "Nome_Empreendedora",
      choices = c("Todas", empreendedoras),
      selected = "Todas"
    )
    
  })
  
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
  
  
  dados_financeiro_filtrado <- reactive({
    
    df <- Financeiro_Report_Agregado
    
    if (input$Pesquisador != "Todos") {
      df <- df %>%
        filter(Nome_do_pesquisador == input$Pesquisador)
    }
    
    df
  })
  
  output$vb_aumento_lucro_mes <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(Nome_Empreendedora, Periodo) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
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
      summarise(
        total = sum(teve_aumento)
      ) %>%
      pull(total)
    
    
    div(
      class = "value-box blue",
      span(
        class = "value-number",
        format(valor, big.mark = ",")
      ),
      span(
        class = "value-title",
        "Participantes com Aumento de Lucro"
      )
    )
  })
  
  
  output$vb_aumento_25_mes <- renderUI({
    
    df <- dados_financeiro_filtrado() %>%
      
      group_by(Nome_Empreendedora, Periodo) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
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
      
      arrange(Nome_Empreendedora, Periodo) %>%
      
      group_by(Nome_Empreendedora) %>%
      mutate(
        lucro_anterior = lag(Lucro_Mensal),
        
        aumento_pct = ifelse(
          lucro_anterior > 0,
          (Lucro_Mensal - lucro_anterior) / lucro_anterior * 100,
          NA
        ),
        
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
      summarise(
        total = sum(teve_aumento_25)
      ) %>%
      pull(total)
    
    
    div(
      class = "value-box orange",
      span(
        class = "value-number",
        format(valor, big.mark = ",")
      ),
      span(
        class = "value-title",
        "Participantes com aumento ≥ 25%"
      )
    )
  })
  
  
  output$tabela_controle_lucro <- renderDT({
    
    # =========================
    # BASE COM FILTROS
    # =========================
    df <- df_financeiro()
    
    req(nrow(df) > 0)
    
    
    # =========================
    # AGREGAR POR MÊS
    # =========================
    df <- df %>%
      group_by(
        Nome_do_pesquisador,
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
        .groups = "drop"
      )
    
    
    # =========================
    # TRANSFORMAR MESES EM COLUNAS
    # =========================
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
        values_fill = list(Lucro_Mensal = 0)
      )
    
    
    # Garantir colunas
    tabela$`Primeiro Mês` <- tabela$`Primeiro Mês` %||% 0
    tabela$`Segundo Mês`  <- tabela$`Segundo Mês` %||% 0
    tabela$`Terceiro Mês` <- tabela$`Terceiro Mês` %||% 0
    
    
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
      
      arrange(Prioridade)
    
    
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
      
      formatStyle(
        "1º para 2º Mês",
        backgroundColor = styleEqual(
          c("Aumentou","Manteve","Reduziu"),
          c("#8054A2","#f9a825","#69C7BE")
        )
      ) %>%
      
      formatStyle(
        "2º para 3º Mês",
        backgroundColor = styleEqual(
          c("Aumentou","Manteve","Reduziu"),
          c("#8054A2","#f9a825","#69C7BE")
        )
      )
  })
  
 
  
  # output$tabela_financeira <- renderDT({
  #   
  #   datatable(
  #     df_financeiro(),
  #     extensions = "Buttons",
  #     options = list(
  #       dom = "Bfrtip",
  #       buttons = c("copy", "csv", "excel"),
  #       pageLength = 15,
  #       scrollX = TRUE
  #     )
  #   )
  # })
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
  

  output$grafico1_beira <- renderPlot({
    
    dados <- dados_geral_beira()
    
    total_selecionadas <- nrow(dados)
    
    total_iniciaram <- dados %>%
      dplyr::filter(
        Status %in% c("Activa", "Desistente")
      ) %>%
      nrow()
    
    
    # =========================
    # RESUMO
    # =========================
    
    grafico_df <- data.frame(
      Categoria = c(
        "Selecionadas",
        "Iniciaram Formação"
      ),
      
      Valor = c(
        total_selecionadas,
        total_iniciaram
      )
    ) %>%
      dplyr::mutate(
        
        # Percentagem em relação às seleccionadas
        Percentual = ifelse(
          total_selecionadas > 0,
          Valor / total_selecionadas,
          0
        ),
        
        Label = paste0(
          Valor,
          "\n(",
          scales::percent(
            Percentual,
            accuracy = 1
          ),
          ")"
        )
      )
    
    
    grafico_df$Categoria <- factor(
      grafico_df$Categoria,
      levels = c(
        "Selecionadas",
        "Iniciaram Formação"
      )
    )
    
    
    # =========================
    # GRÁFICO
    # =========================
    
    ggplot(
      grafico_df,
      aes(
        x = Categoria,
        y = Percentual,
        fill = Categoria
      )
    ) +
      
      geom_col(
        width = 0.6
      ) +
      
      # Valores no centro da barra
      geom_text(
        aes(label = Label),
        position = position_stack(
          vjust = 0.5
        ),
        color = "white",
        size = 6,
        fontface = "bold"
      ) +
      
      # Eixo Y em percentagem
      scale_y_continuous(
        labels = scales::percent_format(
          accuracy = 1
        ),
        limits = c(0, 1),
        expand = expansion(
          mult = c(0, 0.05)
        )
      ) +
      
      scale_fill_manual(
        values = c(
          "Selecionadas" = "#ff7f0e",
          "Iniciaram Formação" = "#8054A2"
        )
      ) +
      
      labs(
        title = "Selecionadas vs Início da Formação - Beira",
        x = NULL,
        y = "Percentagem"
      ) +
      
      theme_stata() +
      
      theme(
        
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 13,
          face = "bold"
        ),
        
        axis.text.y = element_text(
          size = 12
        ),
        
        axis.title.y = element_text(
          size = 13,
          face = "bold"
        ),
        
        legend.position = "none",
        
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        )
      )
    
  })

  
  output$grafico2_beira <- renderPlot({
    
    dados <- dados_geral_beira()
    
    # ============================================================
    # 1. CONTAGEM
    # ============================================================
    
    total_activas <- sum(
      dados$Status == "Activa",
      na.rm = TRUE
    )
    
    total_desistentes <- sum(
      dados$Status == "Desistente",
      na.rm = TRUE
    )
    
    # Total que iniciou a formação
    total_iniciaram <- total_activas + total_desistentes
    
    
    # ============================================================
    # 2. RESUMO
    # ============================================================
    
    resumo <- data.frame(
      Categoria = c(
        "Activas",
        "Desistentes"
      ),
      
      Total = c(
        total_activas,
        total_desistentes
      )
    ) %>%
      dplyr::mutate(
        
        # Percentagem de cada grupo sobre o total
        Percentagem = Total / total_iniciaram * 100,
        
        # Número + percentagem
        Label = paste0(
          Total,
          " (",
          round(Percentagem, 1),
          "%)"
        )
      )
    
    
    # ============================================================
    # 3. ORDEM
    # ============================================================
    
    resumo$Categoria <- factor(
      resumo$Categoria,
      levels = c(
        "Activas",
        "Desistentes"
      )
    )
    
    
    # ============================================================
    # 4. GRÁFICO
    # ============================================================
    
    ggplot(
      resumo,
      aes(
        x = Categoria,
        y = Total,
        fill = Categoria
      )
    ) +
      
      geom_col(
        width = 0.6
      ) +
      
      # ==========================================================
    # NÚMERO + % NO CENTRO DA BARRA
    # ==========================================================
    
    geom_text(
      aes(
        label = Label
      ),
      vjust = 0.5,
      color = "black",
      size = 6,
      fontface = "bold"
    ) +
      
      # ==========================================================
    # CORES
    # ==========================================================
    
    scale_fill_manual(
      values = c(
        "Activas" = "#8054A2",
        "Desistentes" = "#69C7BE"
      )
    ) +
      
      labs(
        title = "Estado das Empreendedoras que Iniciaram a Formação - Beira",
        x = NULL,
        y = "Número de Empreendedoras"
      ) +
      
      theme_stata() +
      
      theme(
        plot.title = element_text(
          size = 16,
          face = "bold"
        ),
        
        axis.text.x = element_text(
          size = 14,
          face = "bold"
        ),
        
        axis.text.y = element_text(
          size = 12,
          face = "bold"
        ),
        
        axis.title.y = element_text(
          size = 13,
          face = "bold"
        ),
        
        legend.position = "none",
        
        panel.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        ),
        
        plot.background = element_rect(
          fill = "#f5f3f4",
          color = NA
        )
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
          levels = unique(Sessoes)[order(as.numeric(gsub("Sessao_", "", unique(Sessoes))))]
        )
      )
    
    df_agg
    
  })
  
  output$grafico_sessoes_col_beira <- renderPlotly({
    
    df_agg <- dados_plot_coletivo_beira()
    previsto <- df_agg$Previsto[1]
    
    limite_y <- max(c(df_agg$Count, previsto)) + 7
    
    g <- ggplot(df_agg,
                aes(x = Sessoes,
                    y = Count,
                    fill = Sessoes)) +
      
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
      )
    
    ggplotly(g, tooltip = "text") %>%
      layout(
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
  
  
  # -------------------------------
  # Atualizar cidades Webinars
  # -------------------------------
  
  observe({
    
    cidades <- Webinars_Beira %>%
      pull(Cidade) %>%
      unique() %>%
      sort()
    
    
    updateSelectInput(
      session,
      "filtro_monitoria_webinar_beira",
      choices = c("Todas", cidades)
    )
    
  })
  
  
  
  # -------------------------------
  # Pesquisador dependente Webinars
  # -------------------------------
  
  observeEvent(
    input$filtro_monitoria_webinar_beira,
    {
      
      
      if(input$filtro_monitoria_webinar_beira == "Todas"){
        
        pesquisadores <- Webinars_Beira %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
        
      } else {
        
        
        pesquisadores <- Webinars_Beira %>%
          filter(
            Cidade == input$filtro_monitoria_webinar_beira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
      }
      
      
      updateSelectInput(
        session,
        "pesquisador_webinar_beira",
        choices = c("Todas", pesquisadores),
        selected = "Todas"
      )
      
    }
  )
  
  
  
  # -------------------------------
  # Dados filtrados Webinars
  # -------------------------------
  
  dados_filtrados_webinar_beira <- reactive({
    
    df <- Webinars_Beira
    
    
    if(input$filtro_monitoria_webinar_beira != "Todas"){
      
      df <- df %>%
        filter(
          Cidade == input$filtro_monitoria_webinar_beira
        )
      
    }
    
    
    if(input$pesquisador_webinar_beira != "Todas"){
      
      df <- df %>%
        filter(
          Pesquisadores == input$pesquisador_webinar_beira
        )
      
    }
    
    
    df
    
  })
  
  
  
  
  # ==========================================================
  # KPIs WEBINARS
  # ==========================================================
  
  
  output$total_participantes_web_beira <- renderUI({
    
    total <- nrow(
      dados_filtrados_webinar_beira()
    )
    
    
    valueBox(
      total,
      "Participantes",
      icon = icon("users"),
      color = "purple"
    )
    
  })
  
  
  
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
      color="blue"
    )
    
    
  })
  
  
  
  output$taxa_presenca_web_beira <- renderUI({
    
    df <- dados_filtrados_webinar_beira()
    
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value=TRUE
    )
    
    
    total <- nrow(df) * length(sessoes)
    
    
    presentes <- df %>%
      select(all_of(sessoes)) %>%
      unlist() %>%
      as.character() %>%
      str_detect("Presente") %>%
      sum(na.rm=TRUE)
    
    
    
    taxa <- round(
      presentes/total*100,
      1
    )
    
    
    valueBox(
      paste0(taxa,"%"),
      "Taxa Presença",
      icon = icon("percent"),
      color="green"
    )
    
    
  })
  
  
  
  
  # ==========================================================
  # GRÁFICO WEBINARS
  # ==========================================================
  
  
  dados_plot_webinar_beira <- reactive({
    
    df <- dados_filtrados_webinar_beira()
    
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value=TRUE
    )
    
    
    df %>%
      select(all_of(sessoes)) %>%
      pivot_longer(
        everything(),
        names_to="Sessao",
        values_to="Presenca"
      ) %>%
      mutate(
        Presenca=as.character(Presenca)
      ) %>%
      filter(
        !is.na(Presenca),
        str_detect(Presenca,"Presente")
      ) %>%
      count(Sessao) %>%
      mutate(
        Ordem=as.numeric(
          gsub("Sessao_","",Sessao)
        )
      ) %>%
      arrange(Ordem) %>%
      mutate(
        Sessao=factor(
          Sessao,
          levels=Sessao
        )
      )
    
  })
  
  
  
  output$grafico_webinar_beira <- renderPlotly({
    
    
    df <- dados_plot_webinar_beira()
    
    
    if(nrow(df)==0)
      return(NULL)
    
    
    
    g <- ggplot(
      df,
      aes(
        Sessao,
        n,
        fill=Sessao
      )
    )+
      
      geom_col()+
      
      geom_text(
        aes(label=n),
        vjust=-0.3,
        fontface="bold"
      )+
      
      theme_stata()+
      
      labs(
        title="Presença por Sessão - Webinars",
        x="",
        y="Participantes"
      )
    
    
    ggplotly(g)
    
    
  })
  
  
  
  # ==========================================================
  # TABELA WEBINARS
  # ==========================================================
  
  
  output$tabela_webinar_beira <- renderDT({
    
    
    df <- dados_filtrados_webinar_beira()
    
    
    sessoes <- grep(
      "^Sessao_\\d+$",
      names(df),
      value=TRUE
    )
    
    
    sessoes <- sessoes[
      order(
        as.numeric(
          gsub("Sessao_","",sessoes)
        )
      )
    ]
    
    
    fixas <- setdiff(
      names(df),
      sessoes
    )
    
    
    df <- df[
      ,
      c(fixas,sessoes)
    ]
    
    
    df[sessoes] <- lapply(
      df[sessoes],
      formatar_pontos
    )
    
    
    datatable(
      df,
      escape=FALSE,
      options=list(
        pageLength=10,
        scrollX=TRUE
      )
    )
    
    
  })
  
  
  
  
  
  
  
  # ==========================================================
  #                 FEIRAS BEIRA
  # ==========================================================
  
  
  observe({
    
    cidades <- Feiras_Beira %>%
      pull(Cidade) %>%
      unique() %>%
      sort()
    
    
    updateSelectInput(
      session,
      "filtro_monitoria_feira_beira",
      choices=c("Todas",cidades)
    )
    
    
  })
  
  
  
  observeEvent(
    input$filtro_monitoria_feira_beira,
    {
      
      
      if(input$filtro_monitoria_feira_beira=="Todas"){
        
        pesquisadores <- Feiras_Beira %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
        
      }else{
        
        
        pesquisadores <- Feiras_Beira %>%
          filter(
            Cidade==input$filtro_monitoria_feira_beira
          ) %>%
          pull(Pesquisadores) %>%
          unique() %>%
          sort()
        
      }
      
      
      
      updateSelectInput(
        session,
        "pesquisador_feira_beira",
        choices=c("Todas",pesquisadores),
        selected="Todas"
      )
      
      
    })
  
  
  
  dados_filtrados_feira_beira <- reactive({
    
    df <- Feiras_Beira
    
    
    if(input$filtro_monitoria_feira_beira!="Todas"){
      
      df <- df %>%
        filter(
          Cidade==input$filtro_monitoria_feira_beira
        )
      
    }
    
    
    if(input$pesquisador_feira_beira!="Todas"){
      
      df <- df %>%
        filter(
          Pesquisadores==input$pesquisador_feira_beira
        )
      
    }
    
    
    df
    
  })
  
  
  
  output$total_participantes_feira_beira <- renderUI({
    
    valueBox(
      nrow(dados_filtrados_feira_beira()),
      "Participantes",
      icon=icon("users"),
      color="purple"
    )
    
  })
  
  
  
  output$total_sessoes_feira_beira <- renderUI({
    
    df<-dados_filtrados_feira_beira()
    
    valueBox(
      length(grep("^Sessao_\\d+$",names(df))),
      "Sessões",
      icon=icon("calendar"),
      color="blue"
    )
    
  })
  
  
  
  output$taxa_presenca_feira_beira <- renderUI({
    
    df<-dados_filtrados_feira_beira()
    
    sessoes<-grep(
      "^Sessao_\\d+$",
      names(df),
      value=TRUE
    )
    
    
    pres <- df %>%
      select(all_of(sessoes)) %>%
      unlist() %>%
      as.character()%>%
      str_detect("Presente")%>%
      sum(na.rm=TRUE)
    
    
    total <- nrow(df)*length(sessoes)
    
    
    valueBox(
      paste0(round(pres/total*100,1),"%"),
      "Taxa Presença",
      icon=icon("percent"),
      color="green"
    )
    
    
  })
  
  
  
  output$grafico_feira_beira <- renderPlotly({
    
    
    df<-dados_filtrados_feira_beira()
    
    
    sessoes<-grep(
      "^Sessao_\\d+$",
      names(df),
      value=TRUE
    )
    
    
    graf<-df%>%
      select(all_of(sessoes))%>%
      pivot_longer(
        everything(),
        names_to="Sessao",
        values_to="Presenca"
      )%>%
      filter(
        str_detect(Presenca,"Presente")
      )%>%
      count(Sessao)
    
    
    
    g<-ggplot(
      graf,
      aes(Sessao,n,fill=Sessao)
    )+
      geom_col()+
      geom_text(
        aes(label=n),
        vjust=-.3
      )+
      theme_stata()
    
    
    ggplotly(g)
    
  })
  
  
  
  output$tabela_feira_beira <- renderDT({
    
    df<-dados_filtrados_feira_beira()
    
    datatable(
      df,
      options=list(
        pageLength=10,
        scrollX=TRUE
      )
      
    )
    
  })
  
  
  # ==========================================================
  # FINANCEIRO BEIRA
  # ==========================================================
  
  
  # ==========================================================
  # FUNÇÃO VALUE BOX
  # ==========================================================
  
  criar_box_beira <- function(valor, titulo, cor){
    
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
  
  
  
  # ==========================================================
  # ATUALIZAR EMPREENDEDORAS PELO PESQUISADOR
  # ==========================================================
  
  observeEvent(
    input$Pesquisador_beira,
    {
      
      df <- Financeiro_Report_Agregado_Beira
      
      
      if(input$Pesquisador_beira != "Todos"){
        
        df <- df %>%
          filter(
            Nome_do_pesquisador == input$Pesquisador_beira
          )
        
      }
      
      
      empreendedoras <- df %>%
        distinct(
          Nome_Empreendedora
        ) %>%
        arrange(
          Nome_Empreendedora
        ) %>%
        pull(
          Nome_Empreendedora
        )
      
      
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
  # BASE FILTRADA
  # ==========================================================
  
  df_financeiro_beira <- reactive({
    
    df <- Financeiro_Report_Agregado_Beira
    
    
    if(
      !is.null(input$Pesquisador_beira) &&
      input$Pesquisador_beira != "Todos"
    ){
      
      df <- df %>%
        filter(
          Nome_do_pesquisador ==
            input$Pesquisador_beira
        )
      
    }
    
    
    if(
      !is.null(input$Nome_Empreendedora_beira) &&
      input$Nome_Empreendedora_beira != "Todas"
    ){
      
      df <- df %>%
        filter(
          Nome_Empreendedora ==
            input$Nome_Empreendedora_beira
        )
      
    }
    
    
    if(
      !is.null(input$Mes_beira) &&
      input$Mes_beira != "Todos"
    ){
      
      df <- df %>%
        filter(
          Periodo ==
            input$Mes_beira
        )
      
    }
    
    
    df
    
  })
  
  
  
  # ==========================================================
  # VALUE BOXES
  # ==========================================================
  
  
  output$vb_emp_beira <- renderUI({
    
    criar_box_beira(
      n_distinct(
        df_financeiro_beira()$Nome_Empreendedora
      ),
      "Empreendedoras",
      "purple"
    )
    
  })
  
  
  
  output$vb_lucro_beira <- renderUI({
    
    criar_box_beira(
      
      scales::comma(
        round(
          sum(
            df_financeiro_beira()$Lucro_Mensal,
            na.rm = TRUE
          )
        )
      ),
      
      "Lucro",
      "blue"
    )
    
  })
  
  
  
  output$vb_rendimento_beira <- renderUI({
    
    criar_box_beira(
      
      scales::comma(
        round(
          sum(
            df_financeiro_beira()$Rendimento_Total,
            na.rm = TRUE
          )
        )
      ),
      
      "Rendimento",
      "green"
    )
    
  })
  
  
  
  output$vb_custos_beira <- renderUI({
    
    criar_box_beira(
      
      scales::comma(
        round(
          sum(
            df_financeiro_beira()$Custo_Operacional_Total,
            na.rm = TRUE
          ) +
            sum(
              df_financeiro_beira()$Custo_Produtos_Total,
              na.rm = TRUE
            )
        )
      ),
      
      "Custos",
      "orange"
    )
    
  })
  
  
  
  # ==========================================================
  # RESUMO FINANCEIRO
  # ==========================================================
  output$cidade_plot_beira <- renderPlotly({
    
    df <- df_financeiro_beira()
    
    resumo <- data.frame(
      
      Indicador = c(
        "Lucro",
        "Rendimento",
        "Custos"
      ),
      
      Valor = c(
        sum(df$Lucro_Mensal, na.rm = TRUE),
        
        sum(df$Rendimento_Total, na.rm = TRUE),
        
        sum(df$Custo_Operacional_Total, na.rm = TRUE) +
          sum(df$Custo_Produtos_Total, na.rm = TRUE)
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
      
      # Valores no centro das barras
      geom_text(
        aes(
          label = scales::comma(round(Valor,0))
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
        expand = expansion(mult = c(0.05,0.20))
      ) +
      
      theme_stata(base_size = 14) +
      
      theme(
        legend.position = "none",
        
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color="#E0E0E0"),
        
        axis.text = element_text(color="#333333"),
        axis.title = element_text(face="bold")
      )
    
    
    ggplotly(g) %>%
      
      layout(
        paper_bgcolor = "#f5f3f4",
        plot_bgcolor  = "#f5f3f4"
      )
    
  })
  
  ####################### ABA SEMANAL
  # ============================================================
  # Dados semanais - Beira
  # ============================================================
  # ============================================================
  # Dados Financeiros Beira com filtros
  # ============================================================
  
  df_financeiro_beira <- reactive({
    
    dados <- Financeiro_Report_Agregado_Beira
    
    # Filtro Pesquisador
    if(input$Pesquisador_beira != "Todos"){
      dados <- dados %>%
        filter(
          Nome_do_pesquisador == input$Pesquisador_beira
        )
    }
    
    # Filtro Empreendedora
    if(input$Nome_Empreendedora_beira != "Todas"){
      dados <- dados %>%
        filter(
          Nome_Empreendedora == input$Nome_Empreendedora_beira
        )
    }
    
    # Filtro Mês
    if(input$Mes_beira != "Todos"){
      dados <- dados %>%
        filter(
          Periodo == input$Mes_beira
        )
    }
    
    dados
  })
  
  
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
  # Gráfico evolução semanal do lucro - Beira
  # ============================================================
  
  output$grafico_financeiro_beira <- renderPlotly({
    
    df_plot <- df_semana_beira() %>%
      group_by(Semanas) %>%
      summarise(
        Lucro = sum(Lucro_Semanal, na.rm = TRUE),
        .groups = "drop"
      )
    
    desloc <- max(df_plot$Lucro, na.rm = TRUE) * 0.08
    
    g <- ggplot(df_plot, aes(x = Semanas, y = Lucro, group = 1)) +
      
      geom_area(fill = "#8054A2", alpha = 0.15) +
      
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
          label = scales::comma(Lucro)
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
        expand = expansion(mult = c(0.05,0.25))
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color="#E0E0E0"),
        axis.text = element_text(color="#333333"),
        axis.title = element_text(face="bold")
      )
    
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor="#f5f3f4",
        plot_bgcolor="#f5f3f4"
      )
  })
  
  
  # ============================================================
  # Gráfico barras semanais - Beira
  # ============================================================
  
  output$grafico_barras_semanas_beira <- renderPlotly({
    
    df_plot <- df_semana_beira() %>%
      group_by(Semanas) %>%
      summarise(
        Lucro = sum(Lucro_Mensal, na.rm = TRUE),
        Rendimento = sum(Rendimento_Total, na.rm = TRUE),
        Custo_Operacional = sum(Custo_Operacional_Total, na.rm = TRUE),
        Custo_Produto = sum(Custo_Produtos_Total, na.rm = TRUE),
        .groups = "drop"
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
    
    
    dodge <- position_dodge(width = 0.8)
    
    
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
          label = scales::comma(round(Valor,0))
        ),
        position = dodge,
        vjust = 0.5,
        color="black",
        fontface="bold",
        size=4
      ) +
      
      scale_fill_manual(
        values=c(
          "Lucro"="#8054A2",
          "Rendimento"="#f9a825",
          "Custo_Operacional"="#69C7BE",
          "Custo_Produto"="#f77333"
        )
      ) +
      
      labs(
        x="",
        y="Valores (MT)",
        fill=""
      ) +
      
      theme_stata(base_size=14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color="#E0E0E0")
      )
    
    
    ggplotly(p) %>%
      layout(
        barmode="group",
        paper_bgcolor="#f5f3f4",
        plot_bgcolor="#f5f3f4"
      )
  })
  
  
  
  # ==========================================================
  # GRÁFICO MENSAL
  # ==========================================================
  
  
  output$grafico_mensal_beira <- renderPlotly({
    
    df_plot <- df_financeiro_beira() %>%
      group_by(Periodo) %>%
      summarise(
        Lucro = sum(Lucro_Mensal, na.rm = TRUE),
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
    
    desloc <- max(df_plot$Lucro, na.rm = TRUE) * 0.07
    
    g <- ggplot(df_plot, aes(x = Periodo, y = Lucro, group = 1)) +
      
      geom_area(fill = "#8054A2", alpha = 0.15) +
      
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
          label = scales::comma(Lucro)
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
        expand = expansion(mult = c(0.05,0.25))
      ) +
      
      theme_minimal(base_size = 14) +
      
      theme(
        panel.grid.major.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(color="#E0E0E0")
      )
    
    ggplotly(g) %>%
      layout(
        paper_bgcolor="#f5f3f4",
        plot_bgcolor="#f5f3f4"
      )
  })
  
  
  output$grafico_barras_beira <- renderPlotly({
    
    df_plot <- df_financeiro_beira() %>%
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
          levels = c(
            "Primeiro Mês",
            "Segundo Mês",
            "Terceiro Mês"
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
    
    dodge <- position_dodge(width = 0.8)
    
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
          label = scales::comma(round(Valor,0))
        ),
        position = dodge,
        vjust = 0.5,
        color="black",
        fontface="bold",
        size=4
      ) +
      
      scale_fill_manual(
        values = c(
          "Lucro"="#8054A2",
          "Rendimento"="#f9a825",
          "Custo_Operacional"="#69C7BE",
          "Custo_Produto"="#f77333"
        )
      ) +
      
      labs(
        x="",
        y="Valores (MT)",
        fill=""
      ) +
      
      theme_stata(base_size=14)
    
    
    ggplotly(p) %>%
      layout(
        barmode="group",
        paper_bgcolor="#f5f3f4",
        plot_bgcolor="#f5f3f4"
      )
  })
  
  # ==========================================================
  # TABELA CONTROLE LUCRO
  # ==========================================================
  output$tabela_controle_lucro_beira <- renderDT({
    
    # =========================
    # BASE COM FILTROS BEIRA
    # =========================
    df <- df_financeiro_beira()
    
    req(nrow(df) > 0)
    
    
    # =========================
    # AGREGAR POR MÊS
    # =========================
    df <- df %>%
      group_by(
        Nome_do_pesquisador,
        Nome_Empreendedora,
        Periodo
      ) %>%
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
        .groups = "drop"
      )
    
    
    # =========================
    # TRANSFORMAR MESES EM COLUNAS
    # =========================
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
        values_fill = list(Lucro_Mensal = 0)
      )
    
    
    # Garantir colunas
    tabela$`Primeiro Mês` <- tabela$`Primeiro Mês` %||% 0
    tabela$`Segundo Mês`  <- tabela$`Segundo Mês` %||% 0
    tabela$`Terceiro Mês` <- tabela$`Terceiro Mês` %||% 0
    
    
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
      
      arrange(Prioridade)
    
    
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
      
      formatStyle(
        "1º para 2º Mês",
        backgroundColor = styleEqual(
          c("Aumentou","Manteve","Reduziu"),
          c("#8054A2","#f9a825","#69C7BE")
        )
      ) %>%
      
      formatStyle(
        "2º para 3º Mês",
        backgroundColor = styleEqual(
          c("Aumentou","Manteve","Reduziu"),
          c("#8054A2","#f9a825","#69C7BE")
        )
      )
  })
  
  output$vb_aumento_lucro_mes_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
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
      summarise(
        total = sum(teve_aumento)
      ) %>%
      pull(total)
    
    
    div(
      class = "value-box blue",
      
      span(
        class = "value-number",
        format(valor, big.mark = ",")
      ),
      
      span(
        class = "value-title",
        "Participantes com Aumento de Lucro"
      )
    )
  })
  
  output$vb_aumento_25_mes_beira <- renderUI({
    
    df <- df_financeiro_beira() %>%
      
      group_by(
        Nome_Empreendedora,
        Periodo
      ) %>%
      
      summarise(
        Lucro_Mensal = sum(Lucro_Mensal, na.rm = TRUE),
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
      
      group_by(Nome_Empreendedora) %>%
      
      mutate(
        lucro_anterior = lag(Lucro_Mensal),
        
        aumento_pct = ifelse(
          lucro_anterior > 0,
          (Lucro_Mensal - lucro_anterior) /
            lucro_anterior * 100,
          NA
        ),
        
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
      summarise(
        total = sum(teve_aumento_25)
      ) %>%
      pull(total)
    
    
    div(
      class = "value-box orange",
      
      span(
        class = "value-number",
        format(valor, big.mark = ",")
      ),
      
      span(
        class = "value-title",
        "Participantes com aumento ≥ 25%"
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
