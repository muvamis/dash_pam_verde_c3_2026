

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
                     div(
                       style = "background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                       DTOutput("tabela_local_venda")
                     )),
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
            "Consciência de Gênero",
            
            fluidRow(
              
              column(
                6,
                div(
                  style="background-color:#f5f3f4; padding:12px; border-radius:6px; margin-bottom:20px;",
                  uiOutput("texto_H_Financeiros")
                ),
                plotlyOutput("grafico_H_Financeiro_Faci")
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
    "PROGRESSO DA TOC"
  ),
  
  fluidPage(
    
    # ==========================================================
    # LEGENDA DOS ESTADOS
    # ==========================================================
    
    fluidRow(
      
      box(
        width = 12,
        title = "Matriz de Indicadores do TOC",
        
        div(
          style = "
            display:flex;
            flex-wrap:wrap;
            align-items:center;
            gap:18px;
            padding:5px 5px 15px 5px;
            font-size:14px;
          ",
          
          # Meta atingida
          div(
            style = "display:flex; align-items:center;",
            
            span(
              style = "
                display:inline-block;
                width:14px;
                height:14px;
                background:#28a745;
                border-radius:50%;
                margin-right:7px;
              "
            ),
            
            tags$span(
              "Meta atingida"
            )
          ),
          
          # Próximo da meta
          div(
            style = "display:flex; align-items:center;",
            
            span(
              style = "
                display:inline-block;
                width:14px;
                height:14px;
                background:#ffc107;
                border-radius:50%;
                margin-right:7px;
              "
            ),
            
            tags$span(
              "Próximo da meta"
            )
          ),
          
          # Em progresso
          div(
            style = "display:flex; align-items:center;",
            
            span(
              style = "
                display:inline-block;
                width:14px;
                height:14px;
                background:#F77333;
                border-radius:50%;
                margin-right:7px;
              "
            ),
            
            tags$span(
              "Em progresso"
            )
          ),
          
          # Abaixo da meta
          div(
            style = "display:flex; align-items:center;",
            
            span(
              style = "
                display:inline-block;
                width:14px;
                height:14px;
                background:#dc3545;
                border-radius:50%;
                margin-right:7px;
              "
            ),
            
            tags$span(
              "Abaixo da meta"
            )
          ),
          
          # Sem dados
          div(
            style = "display:flex; align-items:center;",
            
            span(
              style = "
                display:inline-block;
                width:14px;
                height:14px;
                background:#adb5bd;
                border-radius:50%;
                margin-right:7px;
              "
            ),
            
            tags$span(
              "Sem dados"
            )
          )
        ),
        
        
        # ======================================================
        # TABELA
        # ======================================================
        
        DTOutput(
          "toc_matriz_indicadores"
        )
        
      )
      
    )
    
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
  
  
  output$grafico_servicos_financeiros <- renderPlotly({
    
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
    # FILTRAR DADOS VÁLIDOS
    # =========================================================
    df <- df %>%
      filter(
        !is.na(Uso_Servicos_Financeiros),
        !is.na(Tipo_Avaliacao)
      ) %>%
      
      # =======================================================
    # SEPARAR RESPOSTAS MÚLTIPLAS
    # =======================================================
    separate_rows(
      Uso_Servicos_Financeiros,
      sep = ",(?=[A-Z])"
    ) %>%
      
      mutate(
        Uso_Servicos_Financeiros =
          trimws(
            Uso_Servicos_Financeiros
          )
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
    # FREQUÊNCIA
    # =========================================================
    freq_data <- df %>%
      
      group_by(
        Tipo_Avaliacao,
        Uso_Servicos_Financeiros
      ) %>%
      
      summarise(
        n = n(),
        .groups = "drop"
      ) %>%
      
      group_by(
        Tipo_Avaliacao
      ) %>%
      
      mutate(
        
        # Percentagem
        percent = round(
          n /
            sum(n) *
            100,
          1
        ),
        
        # Texto dentro da barra
        label = paste0(
          n,
          " (",
          percent,
          "%)"
        )
      ) %>%
      
      ungroup()
    
    
    # =========================================================
    # ORDENAR SERVIÇOS
    # =========================================================
    ordem_servicos <- freq_data %>%
      
      group_by(
        Uso_Servicos_Financeiros
      ) %>%
      
      summarise(
        total =
          sum(
            percent,
            na.rm = TRUE
          ),
        
        .groups = "drop"
      ) %>%
      
      arrange(
        total
      ) %>%
      
      pull(
        Uso_Servicos_Financeiros
      )
    
    
    freq_data$Uso_Servicos_Financeiros <-
      factor(
        freq_data$Uso_Servicos_Financeiros,
        levels = ordem_servicos
      )
    
    
    # =========================================================
    # CORES
    # =========================================================
    cores <- c(
      
      "Nenhum destes serviços" =
        "#5cd6c7",
      
      "Carteira móvel (M-Pesa, e-Mola, Mkesh)" =
        "#f9a825",
      
      "Crédito ou empréstimo bancário para o negócio" =
        "#2ca02c",
      
      "Microcrédito (ex: GAPI, FDC, IMF, cooperativa de crédito...)" =
        "#bcbd22",
      
      "Conta bancária em nome do negócio (conta empresarial)" =
        "#9442d4",
      
      "Conta poupança formal ligada ao negócio" =
        "#ff7f0e",
      
      "Seguro (de negócio, de equipamento, de saúde...)" =
        "#d62728"
    )
    
    
    # =========================================================
    # GRÁFICO
    # =========================================================
    plot_ly(
      
      data = freq_data,
      
      x = ~Tipo_Avaliacao,
      
      y = ~percent,
      
      color = ~Uso_Servicos_Financeiros,
      
      colors = cores,
      
      type = "bar",
      
      
      # =======================================================
      # LABEL: n + %
      # =======================================================
      text = ~label,
      
      textposition = "inside",
      
      insidetextanchor = "middle",
      
      textfont = list(
        color = "#ffffff",
        size = 11
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
        # EIXO X
        # =====================================================
        xaxis = list(
          title = ""
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
          
          b = 150
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
  # TEXTO DINÂMICO – SERVIÇOS FINANCEIROS
  # BASE ORIGINAL: Pam_Verde_Indicadores
  # ============================================================
  
  output$texto_servicos <- renderUI({
    
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
    # 3. PREPARAR DADOS
    # ==========================================================
    
    df <- df %>%
      filter(
        !is.na(Uso_Servicos_Financeiros),
        !is.na(Tipo_Avaliacao)
      ) %>%
      
      # Separar respostas múltiplas
      separate_rows(
        Uso_Servicos_Financeiros,
        sep = ",(?=[A-Z])"
      ) %>%
      
      mutate(
        Uso_Servicos_Financeiros =
          trimws(
            Uso_Servicos_Financeiros
          )
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
        Uso_Servicos_Financeiros
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
        Uso_Servicos_Financeiros,
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
        Uso_Servicos_Financeiros,
        perc_endline = perc
      )
    
    
    # ==========================================================
    # 8. COMPARAÇÃO BASELINE × ENDLINE
    # ==========================================================
    
    comparacao <- full_join(
      
      baseline,
      endline,
      
      by =
        "Uso_Servicos_Financeiros"
      
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
    # 9. TEXTO DE CADA SERVIÇO
    # ==========================================================
    
    texto_categorias <- lapply(
      
      seq_len(
        nrow(comparacao)
      ),
      
      function(i) {
        
        categoria <-
          comparacao$Uso_Servicos_Financeiros[i]
        
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
        "Utiliza actualmente algum dos seguintes serviços financeiros para o seu negócio?"
      ),
      
      " A comparação entre o Baseline e o Endline permite observar a evolução do uso dos serviços financeiros. ",
      
      paste(
        texto_categorias,
        collapse = "; "
      ),
      
      "."
    )
  })
  
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
    
    ordem_decisao <- df_resumo %>%
      
      group_by(
        Quem_Toma_Decisoes_Negocio
      ) %>%
      
      summarise(
        
        total = sum(
          Percentagem,
          na.rm = TRUE
        ),
        
        .groups = "drop"
      ) %>%
      
      arrange(total) %>%
      
      pull(
        Quem_Toma_Decisoes_Negocio
      )
    
    
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
          
          y = -0.25
        ),
        
        
        # --------------------------------------------------------
        # MARGENS
        # --------------------------------------------------------
        
        margin = list(
          
          l = 70,
          
          r = 20,
          
          t = 20,
          
          b = 130
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
    
    ordem_negociacao <- df_resumo %>%
      group_by(
        Praticou_negociação_nos_últimos_3meses
      ) %>%
      summarise(
        total = sum(Percent, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(
        Praticou_negociação_nos_últimos_3meses
      )
    
    
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
    
    ordem <- df_resumo %>%
      
      group_by(
        .data[[variavel]]
      ) %>%
      
      summarise(
        
        total = sum(
          Percent,
          na.rm = TRUE
        ),
        
        .groups = "drop"
      ) %>%
      
      arrange(total) %>%
      
      pull(
        .data[[variavel]]
      )
    
    
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
          y = -0.25
        ),
        
        margin = list(
          l = 70,
          r = 20,
          t = 20,
          b = 130
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
    # Filtrar Baseline e Endline
    # ------------------------------------------------------------
    
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
    
    
    # ------------------------------------------------------------
    # Frequência e percentagem
    # ------------------------------------------------------------
    
    freq_data <- df %>%
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
        pct = round(
          n / sum(n) * 100,
          1
        )
      ) %>%
      ungroup()
    
    
    # ------------------------------------------------------------
    # Garantir todas as categorias nos dois momentos
    # ------------------------------------------------------------
    
    categorias <- unique(
      freq_data[[variavel]]
    )
    
    freq_data <- freq_data %>%
      tidyr::complete(
        Tipo_Avaliacao = c(
          "Baseline",
          "Endline"
        ),
        !!rlang::sym(variavel) := categorias,
        fill = list(
          n = 0,
          pct = 0
        )
      )
    
    
    # ------------------------------------------------------------
    # Ordenar categorias pela percentagem
    # ------------------------------------------------------------
    
    ordem <- freq_data %>%
      group_by(.data[[variavel]]) %>%
      summarise(
        total = sum(pct, na.rm = TRUE),
        .groups = "drop"
      ) %>%
      arrange(total) %>%
      pull(.data[[variavel]])
    
    
    # ------------------------------------------------------------
    # Factor
    # ------------------------------------------------------------
    
    freq_data <- freq_data %>%
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
    
    
    # ------------------------------------------------------------
    # Texto dentro das barras
    # n (percentagem)
    # ------------------------------------------------------------
    
    freq_data <- freq_data %>%
      mutate(
        label = ifelse(
          pct > 0,
          paste0(
            n,
            " (",
            format(
              pct,
              decimal.mark = ",",
              nsmall = 1
            ),
            "%)"
          ),
          ""
        )
      )
    
    
    # ------------------------------------------------------------
    # Gráfico
    # ------------------------------------------------------------
    
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
        color = "#ffffff",
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
    "Concordo" = "#F77333",
    "Depende" = "#ffc107",
    "Discordo" = "#69C7BE"
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

  
  output$grafico_sa <- renderPlotly({
    
    df <- Pam_Verde_Indicadores
    
    # ============================================================
    # FILTROS
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ============================================================
    # VARIÁVEL
    # ============================================================
    
    variavel <- "Até que ponto as actividades ligadas à questão de género ajudaram a compreender as desigualdades entre homens e mulheres?"
    
    req(variavel %in% names(df))
    
    # ============================================================
    # APENAS ENDLINE
    # ============================================================
    
    df <- df %>%
      filter(
        Tipo_Avaliacao == "Endline",
        !is.na(.data[[variavel]]),
        .data[[variavel]] != ""
      )
    
    if (nrow(df) == 0) {
      return(
        plotly_empty()
      )
    }
    
    # ============================================================
    # RESUMO
    # ============================================================
    
    df_resumo <- df %>%
      group_by(.data[[variavel]]) %>%
      summarise(
        Total = n(),
        .groups = "drop"
      ) %>%
      mutate(
        Percent = Total / sum(Total) * 100
      )
    
    # ============================================================
    # ORDEM DAS CATEGORIAS
    # ============================================================
    
    ordem <- c(
      "Ajudaram um pouco",
      "Ajudaram moderadamente",
      "Ajudaram bastante / mudaram a minha compreensão"
    )
    
    # Garantir categorias mesmo que alguma não exista
    df_resumo <- df_resumo %>%
      rename(categoria = .data[[variavel]]) %>%
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
        )
      )
    
    # ============================================================
    # TEXTO DENTRO DA BARRA
    # ============================================================
    
    df_resumo <- df_resumo %>%
      mutate(
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
      )
    
    # ============================================================
    # CORES
    # ============================================================
    
    cores_genero_extra <- c(
      "Ajudaram bastante / mudaram a minha compreensão" = "#F77333",
      "Ajudaram moderadamente" = "#ffc107",
      "Ajudaram um pouco" = "#69C7BE"
    )
   
    # ============================================================
    # GRÁFICO
    # ============================================================
    
    plot_ly(
      data = df_resumo,
      x = "Endline",
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
        "<b>Endline</b><br>",
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
          categoryarray = "Endline",
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
          y = -0.30
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
          filename = "compreensao_desigualdades_genero_endline",
          height = 800,
          width = 1600,
          scale = 3
        )
      )
  })
  
  output$texto_genero_extra <- renderUI({
    
    df <- Pam_Verde_Indicadores
    
    # ============================================================
    # FILTROS
    # ============================================================
    
    if (input$filtro_cidade != "Todas") {
      df <- df %>%
        filter(Cidade == input$filtro_cidade)
    }
    
    if (input$filtro_ciclo != "Todos") {
      df <- df %>%
        filter(Ciclo == input$filtro_ciclo)
    }
    
    # ============================================================
    # VARIÁVEL
    # ============================================================
    
    variavel <- "Até que ponto as actividades ligadas à questão de género ajudaram a compreender as desigualdades entre homens e mulheres?"
    
    req(variavel %in% names(df))
    
    # ============================================================
    # APENAS ENDLINE
    # ============================================================
    
    df <- df %>%
      filter(
        Tipo_Avaliacao == "Endline",
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
    
    # ============================================================
    # RESUMO
    # ============================================================
    
    resumo <- df %>%
      count(
        resposta = .data[[variavel]],
        name = "n"
      ) %>%
      mutate(
        percentagem = n / sum(n) * 100
      )
    
    # Função para obter valores
    obter_valor <- function(nome) {
      
      linha <- resumo %>%
        filter(resposta == nome)
      
      if (nrow(linha) == 0) {
        return(
          list(
            n = 0,
            pct = 0
          )
        )
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
    
    # ============================================================
    # TEXTO
    # ============================================================
    
    tags$p(
      style = "margin:0;text-align:justify;",
      
      tags$b(
        "Compreensão das desigualdades de género. "
      ),
      
      "No Endline, os participantes avaliaram até que ponto as actividades ligadas à questão de género contribuíram para a compreensão das desigualdades entre homens e mulheres. ",
      
      "A maioria, ",
      tags$b(
        paste0(
          bastante$n,
          " (",
          format(
            round(bastante$pct, 1),
            decimal.mark = ",",
            nsmall = 1
          ),
          "%)"
        )
      ),
      ", indicou que as actividades ajudaram bastante ou mudaram a sua compreensão. ",
      
      tags$b(
        paste0(
          moderadamente$n,
          " (",
          format(
            round(moderadamente$pct, 1),
            decimal.mark = ",",
            nsmall = 1
          ),
          "%)"
        )
      ),
      " indicaram que ajudaram moderadamente, enquanto ",
      tags$b(
        paste0(
          pouco$n,
          " (",
          format(
            round(pouco$pct, 1),
            decimal.mark = ",",
            nsmall = 1
          ),
          "%)"
        )
      ),
      " indicaram que ajudaram um pouco."
    )
  })
  
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
  

  # ============================================================
  # DADOS – EXERCÍCIO 14
  # A1 - Problema identificado
  # ============================================================
  
  dados_exercicio_14 <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    df %>%
      filter(
        !is.na(`A1  Problema identificado`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `A1  Problema identificado`
      ) %>%
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  
 
  
  output$grafico_resultado_exercicio_14 <- renderPlotly({
    
    df <- dados_exercicio_14()
    
    # Ordem das categorias
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A1  Problema identificado` <- factor(
      df$`A1  Problema identificado`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A1  Problema identificado`
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
  # TEXTO – EXERCÍCIO 14
  # ============================================================
  
  output$texto_resultado_exercicio_14 <- renderUI({
    
    texto <- dados_exercicio_14() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A1  Problema identificado`,
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
        "%</b> dos participantes demonstraram claramente capacidade ",
        "de identificar o problema, enquanto <b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e <b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente essa capacidade, ",
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
  # GRÁFICO – EXERCÍCIO 15
  # A2 - Fontes entrevistadas/observadas
  # ============================================================
  # ============================================================
  # DADOS – EXERCÍCIO 15
  # A2 - Fontes entrevistadas/observadas
  # ============================================================
  
  dados_exercicio_15 <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    df %>%
      filter(
        !is.na(`A2  Fontes entrevistadas/observadas`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `A2  Fontes entrevistadas/observadas`
      ) %>%
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  output$grafico_resultado_exercicio_15 <- renderPlotly({
    
    df <- dados_exercicio_15()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A2  Fontes entrevistadas/observadas` <- factor(
      df$`A2  Fontes entrevistadas/observadas`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A2  Fontes entrevistadas/observadas`
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
  # TEXTO – EXERCÍCIO 15
  # ============================================================
  
  output$texto_resultado_exercicio_15 <- renderUI({
    
    texto <- dados_exercicio_15() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A2  Fontes entrevistadas/observadas`,
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
        "%</b> dos participantes demonstraram claramente capacidade ",
        "de identificar as fontes entrevistadas ou observadas, enquanto ",
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente essa capacidade e ",
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial."
      )
    )
  })
  
  # ============================================================
  # GRÁFICO – EXERCÍCIO 16
  # A3 - Método de recolha utilizado
  # ============================================================
  
  
  # ============================================================
  # DADOS – EXERCÍCIO 16
  # A3 - Método de recolha utilizado
  # ============================================================
  
  dados_exercicio_16 <- reactive({
    
    df <- Pam_Verde_Indicadores
    
    df %>%
      filter(
        !is.na(
          `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`
        ),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`
      ) %>%
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  
  output$grafico_resultado_exercicio_16 <- renderPlotly({
    
    df <- dados_exercicio_16()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`A3  Método de recolha utilizado (perguntas, observação ou outros métodos)` <- factor(
      df$`A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`
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
  # TEXTO – EXERCÍCIO 16
  # ============================================================
  
  output$texto_resultado_exercicio_16 <- renderUI({
    
    texto <- dados_exercicio_16() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `A3  Método de recolha utilizado (perguntas, observação ou outros métodos)`,
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
        "%</b> dos participantes demonstraram claramente capacidade ",
        "de utilizar um método de recolha adequado, enquanto <b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente essa capacidade e ",
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial."
      )
    )
  })
  # ============================================================
  # DADOS — EXERCÍCIO 18
  # B1 - Conclusão da análise própria
  # ============================================================
  
  dados_exercicio_18 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`B1  Conclusão da análise própria`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `B1  Conclusão da análise própria`
      ) %>%
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 18
  # ============================================================
  
  output$grafico_resultado_exercicio_18 <- renderPlotly({
    
    df <- dados_exercicio_18()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`B1  Conclusão da análise própria` <- factor(
      df$`B1  Conclusão da análise própria`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `B1  Conclusão da análise própria`
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
  # ============================================================
  
  output$texto_resultado_exercicio_18 <- renderUI({
    
    texto <- dados_exercicio_18() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `B1  Conclusão da análise própria`,
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
        "%</b> demonstraram claramente capacidade de concluir a análise própria, ",
        
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente essa capacidade, ",
        
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
  # DADOS — EXERCÍCIO 19
  # B2 - Aplicação no negócio
  # ============================================================
  
  dados_exercicio_19 <- reactive({
    
    Pam_Verde_Indicadores %>%
      filter(
        !is.na(`B2  Aplicação no negócio`),
        !is.na(Tipo_Avaliacao)
      ) %>%
      group_by(
        Tipo_Avaliacao,
        `B2  Aplicação no negócio`
      ) %>%
      summarise(
        N = n(),
        .groups = "drop"
      ) %>%
      group_by(Tipo_Avaliacao) %>%
      mutate(
        Percentagem = round(
          N / sum(N) * 100,
          1
        )
      ) %>%
      ungroup()
  })
  
  
  # ============================================================
  # GRÁFICO — EXERCÍCIO 19
  # ============================================================
  
  output$grafico_resultado_exercicio_19 <- renderPlotly({
    
    df <- dados_exercicio_19()
    
    ordem <- c(
      "0.Ausente ou fora do tema",
      "1.Vago ou parcial",
      "2.Demonstra claramente"
    )
    
    df$`B2  Aplicação no negócio` <- factor(
      df$`B2  Aplicação no negócio`,
      levels = ordem
    )
    
    g <- ggplot(
      df,
      aes(
        x = Tipo_Avaliacao,
        y = Percentagem,
        fill = `B2  Aplicação no negócio`
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
  # ============================================================
  
  output$texto_resultado_exercicio_19 <- renderUI({
    
    texto <- dados_exercicio_19() %>%
      tidyr::pivot_wider(
        id_cols = Tipo_Avaliacao,
        names_from = `B2  Aplicação no negócio`,
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
        "%</b> demonstraram claramente capacidade de aplicar a aprendizagem no negócio, ",
        
        "<b>",
        baseline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        baseline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema. ",
        
        "No <b>Endline</b>, <b>",
        endline$`2.Demonstra claramente`,
        "%</b> demonstraram claramente essa capacidade, ",
        
        "<b>",
        endline$`1.Vago ou parcial`,
        "%</b> apresentaram uma resposta vaga ou parcial e ",
        
        "<b>",
        endline$`0.Ausente ou fora do tema`,
        "%</b> apresentaram uma resposta ausente ou fora do tema."
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
    
    total_concluiu <- dados_iniciaram %>%
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
    
    total_iniciaram <- total_concluiu + total_desistentes
    
    # Evitar divisão por zero
    if (total_iniciaram == 0) {
      return(
        ggplot() +
          annotate(
            "text",
            x = 1,
            y = 1,
            label = "Não existem dados de Concluiu a Formação ou Desistentes",
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
        "Concluiu a Formação",
        "Desistentes"
      ),
      
      Valor = c(
        total_concluiu,
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
        "Concluiu a Formação",
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
          "Concluiu a Formação" = "#8054A2",
          "Desistentes" = "#69C7BE"
        ),
        drop = FALSE
      ) +
      
      # Títulos
      labs(
        title = "Situação dos Participantes que Iniciaram a Formação",
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
    
    df <- Presencas_Colectivas_Nampula
    
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
        y = Percentagem,
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
      
      # ==========================================================
    # APENAS EIXO Y EM PERCENTAGEM
    # ==========================================================
    
    scale_y_continuous(
      limits = c(0, 100),
      labels = function(x) paste0(x, "%")
    ) +
      
      labs(
        title = "Estado das Empreendedoras que Iniciaram a Formação - Beira",
        x = NULL,
        y = "Percentagem de Empreendedoras"
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
  
  # ==========================================================
  # FEIRAS - BEIRA
  # Estrutura igual à Feiras_Nampula
  # ==========================================================
  
  
  # ==========================================================
  # Atualizar cidades
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
  # MATRIZ DE INDICADORES TOC - PAM VERDE CICLO 3
  #
  # VERSÃO AJUSTADA
  #
  # PRINCIPAIS CORRECÇÕES:
  #
  # 1. BASELINE e ENDLINE são calculados separadamente.
  # 2. Endline NÃO mistura dados de Baseline.
  # 3. A tabela apresenta:
  #       ID_Indicador
  #       Indicador
  #       Baseline
  #       Endline
  #       Variação
  #       Meta 2026
  #       Alcance da Meta
  #       Estado
  #
  # 4. Alcance da Meta é calculado somente com o Endline.
  # 5. Variação para indicadores percentuais:
  #       Endline - Baseline
  #
  # ============================================================
  
  
  output$toc_matriz_indicadores <- renderDT({
    
    
    # ==========================================================
    # 1. BASE PRINCIPAL DO TOC
    # ==========================================================
    
    df_toc_pam_verde <-
      PAM_VERDE_TOC_C3
    
    
    
    # ==========================================================
    # 2. BASE ESPECÍFICA PARA MONITORIA DA FORMAÇÃO
    # ==========================================================
    
    df_conclusao_formacao_pam_verde <-
      PERFIL_PAM_VERDE_C3_2026 %>%
      
      dplyr::mutate(
        
        Status_Padrao_PAM =
          toupper(
            stringr::str_squish(
              trimws(
                as.character(Status)
              )
            )
          )
      )
    
    
    
    # ==========================================================
    # 3. PARTICIPANTES QUE INICIARAM A FORMAÇÃO
    #
    # ACTIVA / ATIVA / DESISTENTE = iniciou
    #
    # Este indicador é de monitoria da formação e não possui
    # Baseline/Endline tradicional.
    # ==========================================================
    
    resultado_inicio_formacao_pam_verde <-
      df_conclusao_formacao_pam_verde %>%
      
      dplyr::summarise(
        
        Total_Selecionadas =
          dplyr::n(),
        
        Total_Iniciaram =
          sum(
            Status_Padrao_PAM %in% c(
              "ACTIVA",
              "ACTIVAS",
              "ATIVA",
              "ATIVAS",
              "DESISTENTE",
              "DESISTENTES"
            ),
            na.rm = TRUE
          ),
        
        Percentagem_Iniciaram =
          dplyr::case_when(
            
            Total_Selecionadas > 0 ~
              
              (
                Total_Iniciaram /
                  Total_Selecionadas
              ) * 100,
            
            TRUE ~
              NA_real_
          )
      )
    
    
    
    inicio_formacao_EL <-
      resultado_inicio_formacao_pam_verde$
      Percentagem_Iniciaram
    
    if (
      length(inicio_formacao_EL) == 0 ||
      is.na(inicio_formacao_EL)
    ) {
      
      inicio_formacao_EL <-
        NA_real_
      
    }
    
    
    
    # ==========================================================
    # 4. PARTICIPANTES QUE TERMINARAM A FORMAÇÃO
    #
    # Iniciaram:
    #   ACTIVA / ATIVA / DESISTENTE
    #
    # Terminaram:
    #   ACTIVA / ATIVA
    # ==========================================================
    
    resultado_conclusao_formacao_pam_verde <-
      df_conclusao_formacao_pam_verde %>%
      
      dplyr::filter(
        Status_Padrao_PAM %in% c(
          "ACTIVA",
          "ACTIVAS",
          "ATIVA",
          "ATIVAS",
          "DESISTENTE",
          "DESISTENTES"
        )
      ) %>%
      
      dplyr::summarise(
        
        Total_Iniciaram =
          dplyr::n(),
        
        N_Terminaram =
          sum(
            Status_Padrao_PAM %in% c(
              "ACTIVA",
              "ACTIVAS",
              "ATIVA",
              "ATIVAS"
            ),
            na.rm = TRUE
          ),
        
        Percentagem_Terminaram =
          dplyr::case_when(
            
            Total_Iniciaram > 0 ~
              
              (
                N_Terminaram /
                  Total_Iniciaram
              ) * 100,
            
            TRUE ~
              NA_real_
          )
      )
    
    
    
    conclusao_formacao_EL <-
      resultado_conclusao_formacao_pam_verde$
      Percentagem_Terminaram
    
    if (
      length(conclusao_formacao_EL) == 0 ||
      is.na(conclusao_formacao_EL)
    ) {
      
      conclusao_formacao_EL <-
        NA_real_
      
    }
    
    
    
    # ==========================================================
    # 5. FORMALIZAÇÃO DO NEGÓCIO
    #
    # ID:
    # iPAM_INT1.1
    # ==========================================================
    
    formalizacao <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Negocio_Formalizado
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    formalizacao_BL <-
      formalizacao %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    formalizacao_n_BL <-
      formalizacao_BL %>%
      dplyr::filter(
        Negocio_Formalizado %in% c(
          # "Sim",
          "Iniciei o processo de formalização"
        )
      ) %>%
      nrow()
    
    
    formalizacao_total_BL <-
      nrow(
        formalizacao_BL
      )
    
    
    formalizacao_percentual_BL <-
      dplyr::if_else(
        
        formalizacao_total_BL > 0,
        
        (
          formalizacao_n_BL /
            formalizacao_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    formalizacao_EL <-
      formalizacao %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    formalizacao_n_EL <-
      formalizacao_EL %>%
      
      dplyr::filter(
        
        Negocio_Formalizado %in% c(
          # "Sim",
          "Iniciei o processo de formalização"
        )
      ) %>%
      nrow()
    
    
    formalizacao_total_EL <-
      nrow(
        formalizacao_EL
      )
    
    
    formalizacao_percentual_EL <-
      dplyr::if_else(
        
        formalizacao_total_EL > 0,
        
        (
          formalizacao_n_EL /
            formalizacao_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 6. SALÁRIO MENSAL PARA SI MESMA
    #
    # ID:
    # iPAM_RI.2.4
    # ==========================================================
    
    salario <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Tira_Salario_Para_Si
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    salario_BL <-
      salario %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    salario_total_BL <-
      salario_BL %>%
      
      dplyr::filter(
        
        Tira_Salario_Para_Si !=
          "Não, não retiro nenhum valor para mim mesma"
        
      ) %>%
      
      nrow()
    
    
    salario_n_BL <-
      salario_BL %>%
      
      dplyr::filter(
        
        Tira_Salario_Para_Si ==
          "Sim, retiro um valor fixo todos os meses"
        
      ) %>%
      
      nrow()
    
    
    salario_percentual_BL <-
      dplyr::if_else(
        
        salario_total_BL > 0,
        
        (
          salario_n_BL /
            salario_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    salario_EL <-
      salario %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    salario_total_EL <-
      salario_EL %>%
      
      dplyr::filter(
        
        Tira_Salario_Para_Si !=
          "Não, não retiro nenhum valor para mim mesma"
        
      ) %>%
      
      nrow()
    
    
    salario_n_EL <-
      salario_EL %>%
      
      dplyr::filter(
        
        Tira_Salario_Para_Si ==
          "Sim, retiro um valor fixo todos os meses"
        
      ) %>%
      
      nrow()
    
    
    salario_percentual_EL <-
      dplyr::if_else(
        
        salario_total_EL > 0,
        
        (
          salario_n_EL /
            salario_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 7. TOMADA DE DECISÕES
    #
    # Pergunta:
    # Quem_Toma_Decisoes_Negocio
    #
    # Resposta considerada:
    # "Só eu"
    # ==========================================================
    
    decisoes <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Quem_Toma_Decisoes_Negocio
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    decisoes_BL <-
      decisoes %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    decisoes_n_BL <-
      decisoes_BL %>%
      
      dplyr::filter(
        
        Quem_Toma_Decisoes_Negocio ==
          "Só eu"
        
      ) %>%
      
      nrow()
    
    
    decisoes_total_BL <-
      nrow(
        decisoes_BL
      )
    
    
    decisoes_percentual_BL <-
      dplyr::if_else(
        
        decisoes_total_BL > 0,
        
        (
          decisoes_n_BL /
            decisoes_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    decisoes_EL <-
      decisoes %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    decisoes_n_EL <-
      decisoes_EL %>%
      
      dplyr::filter(
        
        Quem_Toma_Decisoes_Negocio ==
          "Só eu"
        
      ) %>%
      
      nrow()
    
    
    decisoes_total_EL <-
      nrow(
        decisoes_EL
      )
    
    
    decisoes_percentual_EL <-
      dplyr::if_else(
        
        decisoes_total_EL > 0,
        
        (
          decisoes_n_EL /
            decisoes_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 8. CONFIANÇA NA NEGOCIAÇÃO COM CLIENTES
    #
    # ID:
    # iPAM_RI.2.6
    #
    # Resposta considerada:
    # "Sim, sinto-me confiante e sei defender a minha posição"
    #
    # IMPORTANTE:
    # Baseline e Endline são calculados separadamente.
    # ==========================================================
    
    negociacao_clientes <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Negociacao_Com_Clientes
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    negociacao_clientes_BL <-
      negociacao_clientes %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    negociacao_clientes_confiante_BL <-
      negociacao_clientes_BL %>%
      
      dplyr::filter(
        
        Negociacao_Com_Clientes ==
          "Sim, sinto-me confiante e sei defender a minha posição"
        
      ) %>%
      
      nrow()
    
    
    negociacao_clientes_total_BL <-
      nrow(
        negociacao_clientes_BL
      )
    
    
    negociacao_clientes_percentual_BL <-
      dplyr::if_else(
        
        negociacao_clientes_total_BL > 0,
        
        (
          negociacao_clientes_confiante_BL /
            negociacao_clientes_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    negociacao_clientes_EL <-
      negociacao_clientes %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    negociacao_clientes_confiante_EL <-
      negociacao_clientes_EL %>%
      
      dplyr::filter(
        
        Negociacao_Com_Clientes ==
          "Sim, sinto-me confiante e sei defender a minha posição"
        
      ) %>%
      
      nrow()
    
    
    negociacao_clientes_total_EL <-
      nrow(
        negociacao_clientes_EL
      )
    
    
    negociacao_clientes_percentual_EL <-
      dplyr::if_else(
        
        negociacao_clientes_total_EL > 0,
        
        (
          negociacao_clientes_confiante_EL /
            negociacao_clientes_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 9. NEGOCIAÇÃO NOS ÚLTIMOS 3 MESES
    #
    # ID:
    # iPAM_RI.5.1
    #
    # Resposta:
    # "Sim, negociei e consegui um acordo favorável
    #  para o meu negócio"
    # ==========================================================
    
    negociacao_3meses <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Praticou_negociação_nos_últimos_3meses
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    negociacao_3meses_BL <-
      negociacao_3meses %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    negociacao_3meses_n_BL <-
      negociacao_3meses_BL %>%
      
      dplyr::filter(
        
        Praticou_negociação_nos_últimos_3meses ==
          "Sim, negociei e consegui um acordo favorável para o meu negócio"
        
      ) %>%
      
      nrow()
    
    
    negociacao_3meses_total_BL <-
      nrow(
        negociacao_3meses_BL
      )
    
    
    negociacao_3meses_percentual_BL <-
      dplyr::if_else(
        
        negociacao_3meses_total_BL > 0,
        
        (
          negociacao_3meses_n_BL /
            negociacao_3meses_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    negociacao_3meses_EL <-
      negociacao_3meses %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    negociacao_3meses_n_EL <-
      negociacao_3meses_EL %>%
      
      dplyr::filter(
        
        Praticou_negociação_nos_últimos_3meses ==
          "Sim, negociei e consegui um acordo favorável para o meu negócio"
        
      ) %>%
      
      nrow()
    
    
    negociacao_3meses_total_EL <-
      nrow(
        negociacao_3meses_EL
      )
    
    
    negociacao_3meses_percentual_EL <-
      dplyr::if_else(
        
        negociacao_3meses_total_EL > 0,
        
        (
          negociacao_3meses_n_EL /
            negociacao_3meses_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 10. UTILIZAÇÃO DE FERRAMENTAS DE IA
    #
    # Mede utilização geral de IA.
    #
    # Não atribuímos automaticamente iPAM_RI.3.1 porque esse
    # ID refere-se especificamente à utilização da ferramenta HCD.
    # ==========================================================
    
    uso_ia <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          Uso_de_ferramentas_de_IA
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    uso_ia_BL <-
      uso_ia %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    uso_ia_n_BL <-
      uso_ia_BL %>%
      
      dplyr::filter(
        
        Uso_de_ferramentas_de_IA %in% c(
          
          "Sim, usei pelo menos uma vez",
          
          "Sim, uso regularmente para o negócio"
          
        )
        
      ) %>%
      
      nrow()
    
    
    uso_ia_total_BL <-
      nrow(
        uso_ia_BL
      )
    
    
    uso_ia_percentual_BL <-
      dplyr::if_else(
        
        uso_ia_total_BL > 0,
        
        (
          uso_ia_n_BL /
            uso_ia_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    uso_ia_EL <-
      uso_ia %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    uso_ia_n_EL <-
      uso_ia_EL %>%
      
      dplyr::filter(
        
        Uso_de_ferramentas_de_IA %in% c(
          
          "Sim, usei pelo menos uma vez",
          
          "Sim, uso regularmente para o negócio"
          
        )
        
      ) %>%
      
      nrow()
    
    
    uso_ia_total_EL <-
      nrow(
        uso_ia_EL
      )
    
    
    uso_ia_percentual_EL <-
      dplyr::if_else(
        
        uso_ia_total_EL > 0,
        
        (
          uso_ia_n_EL /
            uso_ia_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 11. SEPARAÇÃO DAS CONTAS PESSOAIS E DO NEGÓCIO
    # ==========================================================
    
    contas <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          `Faz separação das contas pessoais e do negócio`
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    contas_BL <-
      contas %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    contas_n_BL <-
      contas_BL %>%
      
      dplyr::filter(
        
        `Faz separação das contas pessoais e do negócio` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    contas_total_BL <-
      nrow(
        contas_BL
      )
    
    
    contas_percentual_BL <-
      dplyr::if_else(
        
        contas_total_BL > 0,
        
        (
          contas_n_BL /
            contas_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    contas_EL <-
      contas %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    contas_n_EL <-
      contas_EL %>%
      
      dplyr::filter(
        
        `Faz separação das contas pessoais e do negócio` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    contas_total_EL <-
      nrow(
        contas_EL
      )
    
    
    contas_percentual_EL <-
      dplyr::if_else(
        
        contas_total_EL > 0,
        
        (
          contas_n_EL /
            contas_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 12. SABEM CALCULAR O LUCRO
    #
    # ID:
    # iPAM_RI.4.1
    # ==========================================================
    
    calculo_lucro <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          `Sabe calcular o lucro do negócio  (com base no exercício prático)`
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    calculo_lucro_BL <-
      calculo_lucro %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    calculo_lucro_n_BL <-
      calculo_lucro_BL %>%
      
      dplyr::filter(
        
        `Sabe calcular o lucro do negócio  (com base no exercício prático)` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    calculo_lucro_total_BL <-
      nrow(
        calculo_lucro_BL
      )
    
    
    calculo_lucro_percentual_BL <-
      dplyr::if_else(
        
        calculo_lucro_total_BL > 0,
        
        (
          calculo_lucro_n_BL /
            calculo_lucro_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    calculo_lucro_EL <-
      calculo_lucro %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    calculo_lucro_n_EL <-
      calculo_lucro_EL %>%
      
      dplyr::filter(
        
        `Sabe calcular o lucro do negócio  (com base no exercício prático)` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    calculo_lucro_total_EL <-
      nrow(
        calculo_lucro_EL
      )
    
    
    calculo_lucro_percentual_EL <-
      dplyr::if_else(
        
        calculo_lucro_total_EL > 0,
        
        (
          calculo_lucro_n_EL /
            calculo_lucro_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 13. CONTROLO DO DINHEIRO QUE ENTRA E SAI
    # ==========================================================
    
    controlo_dinheiro <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        !is.na(
          `Faz controlo do dinheiro que entra e que sai (receitas e despesas)`
        ),
        
        Tipo_Avaliacao %in% c(
          "Baseline",
          "Endline"
        )
      )
    
    
    
    # -------------------------
    # BASELINE
    # -------------------------
    
    controlo_dinheiro_BL <-
      controlo_dinheiro %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Baseline"
      )
    
    
    controlo_dinheiro_n_BL <-
      controlo_dinheiro_BL %>%
      
      dplyr::filter(
        
        `Faz controlo do dinheiro que entra e que sai (receitas e despesas)` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    controlo_dinheiro_total_BL <-
      nrow(
        controlo_dinheiro_BL
      )
    
    
    controlo_dinheiro_percentual_BL <-
      dplyr::if_else(
        
        controlo_dinheiro_total_BL > 0,
        
        (
          controlo_dinheiro_n_BL /
            controlo_dinheiro_total_BL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # -------------------------
    # ENDLINE
    # -------------------------
    
    controlo_dinheiro_EL <-
      controlo_dinheiro %>%
      
      dplyr::filter(
        Tipo_Avaliacao == "Endline"
      )
    
    
    controlo_dinheiro_n_EL <-
      controlo_dinheiro_EL %>%
      
      dplyr::filter(
        
        `Faz controlo do dinheiro que entra e que sai (receitas e despesas)` ==
          "Sim"
        
      ) %>%
      
      nrow()
    
    
    controlo_dinheiro_total_EL <-
      nrow(
        controlo_dinheiro_EL
      )
    
    
    controlo_dinheiro_percentual_EL <-
      dplyr::if_else(
        
        controlo_dinheiro_total_EL > 0,
        
        (
          controlo_dinheiro_n_EL /
            controlo_dinheiro_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    
    # ==========================================================
    # 14. ACTIVIDADES DE GÉNERO
    #
    # APENAS ENDLINE
    #
    # Não existe Baseline equivalente nesta pergunta.
    # ==========================================================
    
    genero <-
      df_toc_pam_verde %>%
      
      dplyr::filter(
        
        Tipo_Avaliacao == "Endline",
        
        !is.na(
          `Até que ponto as actividades ligadas à questão de género ajudaram a compreender as desigualdades entre homens e mulheres?`
        )
      )
    
    
    genero_n_EL <-
      genero %>%
      
      dplyr::filter(
        
        `Até que ponto as actividades ligadas à questão de género ajudaram a compreender as desigualdades entre homens e mulheres?` ==
          
          "Ajudaram bastante / mudaram a minha compreensão"
        
      ) %>%
      
      nrow()
    
    
    genero_total_EL <-
      nrow(
        genero
      )
    
    
    genero_percentual_EL <-
      dplyr::if_else(
        
        genero_total_EL > 0,
        
        (
          genero_n_EL /
            genero_total_EL
        ) * 100,
        
        NA_real_
      )
    
    
    
    # ==========================================================
    # 15. RESULTADOS FINANCEIROS
    #
    # Fonte:
    # FINANCEIRO_TOC_NAMPULA
    #
    # Não existe Baseline/Endline convencional.
    # O cálculo é feito a partir dos 3 meses.
    # ==========================================================
    
    financeiro_pam_verde <-
      FINANCEIRO_TOC_NAMPULA %>%
      
      dplyr::filter(
        
        Periodo %in% c(
          "Primeiro Mês",
          "Segundo Mês",
          "Terceiro Mês"
        ),
        
        !is.na(
          Nome_Empreendedora
        ),
        
        !is.na(
          Lucro_Semanal
        )
        
      ) %>%
      
      dplyr::group_by(
        
        Nome_Empreendedora,
        Periodo
        
      ) %>%
      
      dplyr::summarise(
        
        Lucro =
          sum(
            Lucro_Semanal,
            na.rm = TRUE
          ),
        
        .groups = "drop"
        
      ) %>%
      
      tidyr::pivot_wider(
        
        names_from =
          Periodo,
        
        values_from =
          Lucro,
        
        values_fill = 0
        
      )
    
    
    
    # ==========================================================
    # 16. AUMENTO DO LUCRO
    # ==========================================================
    
    if (
      
      nrow(
        financeiro_pam_verde
      ) > 0 &&
      
      all(
        c(
          "Primeiro Mês",
          "Terceiro Mês"
        ) %in%
        names(
          financeiro_pam_verde
        )
      )
      
    ) {
      
      financeiro_pam_verde <-
        financeiro_pam_verde %>%
        
        dplyr::mutate(
          
          Aumento_Lucro =
            
            `Terceiro Mês` -
            `Primeiro Mês`,
          
          Percentual_Aumento =
            
            dplyr::if_else(
              
              `Primeiro Mês` > 0,
              
              (
                Aumento_Lucro /
                  `Primeiro Mês`
              ) * 100,
              
              NA_real_
            )
        )
      
    } else {
      
      financeiro_pam_verde$Aumento_Lucro <-
        numeric(
          nrow(
            financeiro_pam_verde
          )
        )
      
      financeiro_pam_verde$Percentual_Aumento <-
        numeric(
          nrow(
            financeiro_pam_verde
          )
        )
    }
    
    
    
    # ==========================================================
    # 17. % QUE AUMENTARAM O LUCRO
    #
    # ID:
    # iPAM_RI.1.1
    # ==========================================================
    
    lucro_aumentou_EL <-
      
      ifelse(
        
        nrow(
          financeiro_pam_verde
        ) > 0,
        
        mean(
          financeiro_pam_verde$
            Percentual_Aumento > 0,
          na.rm = TRUE
        ) * 100,
        
        NA_real_
      )
    
    
    if (
      is.nan(
        lucro_aumentou_EL
      )
    ) {
      
      lucro_aumentou_EL <-
        NA_real_
      
    }
    
    
    
    # ==========================================================
    # 18. % QUE AUMENTARAM O LUCRO EM 25% OU MAIS
    #
    # ID:
    # iPAM_RI.1.2
    # ==========================================================
    
    lucro_mais_25_EL <-
      
      ifelse(
        
        nrow(
          financeiro_pam_verde
        ) > 0,
        
        mean(
          financeiro_pam_verde$
            Percentual_Aumento >= 25,
          na.rm = TRUE
        ) * 100,
        
        NA_real_
      )
    
    
    if (
      is.nan(
        lucro_mais_25_EL
      )
    ) {
      
      lucro_mais_25_EL <-
        NA_real_
      
    }
    
    
    
    # ==========================================================
    # 19. VALOR MÉDIO DO AUMENTO DO LUCRO
    #
    # Mantido como valor financeiro.
    # ==========================================================
    
    aumento_medio_lucro_EL <-
      
      ifelse(
        
        nrow(
          financeiro_pam_verde
        ) > 0,
        
        mean(
          financeiro_pam_verde$
            Aumento_Lucro,
          na.rm = TRUE
        ),
        
        NA_real_
      )
    
    
    if (
      is.nan(
        aumento_medio_lucro_EL
      )
    ) {
      
      aumento_medio_lucro_EL <-
        NA_real_
      
    }
    
    
    
    # ==========================================================
    # 20. SALDO LÍQUIDO DO VALOR ADICIONADO
    # ==========================================================
    
    saldo_liquido_lucro_EL <-
      
      ifelse(
        
        nrow(
          financeiro_pam_verde
        ) > 0,
        
        sum(
          financeiro_pam_verde$
            Aumento_Lucro,
          na.rm = TRUE
        ),
        
        NA_real_
      )
    
    
    
    # ==========================================================
    # 21. MATRIZ DE INDICADORES
    # ==========================================================
    
    indicadores_toc <-
      
      data.frame(
        
        
        # ========================================================
        # ID
        # ========================================================
        
        ID_Indicador = c(
          
          "iVM1000",
          "iVM1000",
          
          "iPAM_INT1.1",
          "iPAM_RI.2.4",
          "OS1.1",
          "iPAM_RI.2.6",
          "iPAM_RI.5.1",
          "iPAM_RI.3.1",
          "iPAM_RI.2.2",
          "iPAM_RI.4.1",
          "iPAM_RI.2.2",
          
          "iPAM_RI.4.2",
          
          "iPAM_RI.1.1",
          "iPAM_RI.1.2",
          "iPAM_RI.2.1",
          "iPAM_RI.1.3b"
          
        ),
        
        
        
        # ========================================================
        # INDICADOR
        # ========================================================
        
        Indicador = c(
          
          # Formação
          
          "% de participantes que iniciam a formação",
          
          "% de participantes que completam a formação",
          
          
          # Gestão
          
          "% de empreendedoras que iniciam o processo de formalização",
          
          "% de empreendedoras que definem um salário mensal para si mesmas",
          
          "% de empreendedoras que tomam sozinhas as principais decisões no negócio",
          
          "% de empreendedoras confiantes na negociação com clientes",
          
          "% participantes com maior poder de negociação em oportunidades económicas",
          
          "% de empreendedoras que sabem utilizar ferramentas de IA",
          
          "% de empreendedoras que fazem separação das contas pessoais e do negócio",
          
          "% de empreendedoras que sabem calcular o lucro",
          
          "% de empreendedoras que fazem controlo do dinheiro que entra e sai",
          
          
          # Género
          
          "% de empreendedoras que consideram que as actividades de género ajudaram bastante / mudaram a sua compreensão",
          
          
          # Financeiro
          
          "% de empreendedoras que aumentaram os seus lucros durante os 3 meses",
          
          "% de empreendedoras que aumentaram o lucro em 25% ou mais",
          
          "Valor médio de aumento do lucro por empreendedora",
          
          "Saldo líquido do valor adicionado ao final dos 3 meses"
          
        ),
        
        
        
        # ========================================================
        # BASELINE
        # ========================================================
        
        Baseline = c(
          
          # Formação
          
          NA_real_,
          NA_real_,
          
          # Gestão
          
          formalizacao_percentual_BL,
          salario_percentual_BL,
          decisoes_percentual_BL,
          negociacao_clientes_percentual_BL,
          negociacao_3meses_percentual_BL,
          uso_ia_percentual_BL,
          contas_percentual_BL,
          calculo_lucro_percentual_BL,
          controlo_dinheiro_percentual_BL,
          
          # Género
          
          NA_real_,
          
          # Financeiro
          
          NA_real_,
          NA_real_,
          NA_real_,
          NA_real_
          
        ),
        
        
        
        # ========================================================
        # ENDLINE
        # ========================================================
        
        Endline = c(
          
          # Formação
          
          inicio_formacao_EL,
          conclusao_formacao_EL,
          
          # Gestão
          
          formalizacao_percentual_EL,
          salario_percentual_EL,
          decisoes_percentual_EL,
          negociacao_clientes_percentual_EL,
          negociacao_3meses_percentual_EL,
          uso_ia_percentual_EL,
          contas_percentual_EL,
          calculo_lucro_percentual_EL,
          controlo_dinheiro_percentual_EL,
          
          # Género
          
          genero_percentual_EL,
          
          # Financeiro
          
          lucro_aumentou_EL,
          lucro_mais_25_EL,
          aumento_medio_lucro_EL,
          saldo_liquido_lucro_EL
          
        ),
        
        
        
        # ========================================================
        # META 2026
        # ========================================================
        
        Meta_2026 = c(
          
          # Formação
          
          85,
          80,
          
          # Gestão
          
          10,
          50,
          100,
          70,
          70,
          80,
          80,
          85,
          80,
          
          # Género
          
          100,
          
          # Financeiro
          
          80,
          50,
          2500,
          70000
          
        ),
        
        
        stringsAsFactors = FALSE
        
      )
    
    
    
    
    # ==========================================================
    # 22. TIPO DE INDICADOR
    # ==========================================================
    
    indicadores_toc$Tipo_Indicador <-
      
      dplyr::case_when(
        
        grepl(
          "Valor médio|Saldo líquido",
          indicadores_toc$Indicador
        ) ~
          "MT",
        
        TRUE ~
          "%"
      )
    
    
    
    
    # ==========================================================
    # 23. VARIAÇÃO BASELINE → ENDLINE
    #
    # Para indicadores percentuais:
    #
    # Variação = Endline - Baseline
    #
    # Resultado apresentado em pontos percentuais.
    #
    # Para indicadores sem Baseline:
    # "NA"
    # ==========================================================
    
    indicadores_toc$Variacao_Numerica <-
      
      dplyr::case_when(
        
        indicadores_toc$Tipo_Indicador == "%" &
          
          !is.na(
            indicadores_toc$Baseline
          ) &
          
          !is.na(
            indicadores_toc$Endline
          ) ~
          
          indicadores_toc$Endline -
          indicadores_toc$Baseline,
        
        indicadores_toc$Tipo_Indicador == "MT" &
          
          !is.na(
            indicadores_toc$Baseline
          ) &
          
          !is.na(
            indicadores_toc$Endline
          ) ~
          
          indicadores_toc$Endline -
          indicadores_toc$Baseline,
        
        TRUE ~
          NA_real_
      )
    
    
    
    
    # ==========================================================
    # 24. ALCANCE DA META
    #
    # IMPORTANTE:
    #
    # O alcance é calculado exclusivamente sobre o ENDLINE.
    #
    # Não utilizamos o Baseline neste cálculo.
    # ==========================================================
    
    indicadores_toc$Alcance_Numerico <-
      
      dplyr::case_when(
        
        !is.na(
          indicadores_toc$Endline
        ) &
          
          !is.na(
            indicadores_toc$Meta_2026
          ) &
          
          indicadores_toc$Meta_2026 > 0 ~
          
          (
            indicadores_toc$Endline /
              indicadores_toc$Meta_2026
          ) * 100,
        
        TRUE ~
          NA_real_
      )
    
    
    
    
    # ==========================================================
    # 25. LIMITE DA BARRA DE PROGRESSO
    # ==========================================================
    
    indicadores_toc$Alcance_Barra <-
      
      dplyr::if_else(
        
        is.na(
          indicadores_toc$Alcance_Numerico
        ),
        
        NA_real_,
        
        pmin(
          indicadores_toc$Alcance_Numerico,
          100
        )
      )
    
    
    
    
    # ==========================================================
    # 26. ESTADO DO INDICADOR
    # ==========================================================
    
    indicadores_toc$Estado <-
      
      dplyr::case_when(
        
        is.na(
          indicadores_toc$Alcance_Numerico
        ) ~
          
          "⚪ Sem dados",
        
        indicadores_toc$Alcance_Numerico >= 100 ~
          
          "🟢 Meta atingida",
        
        indicadores_toc$Alcance_Numerico >= 80 ~
          
          "🟡 Próximo da meta",
        
        indicadores_toc$Alcance_Numerico >= 50 ~
          
          "🟠 Em progresso",
        
        TRUE ~
          
          "🔴 Abaixo da meta"
      )
    
    
    
    
    # ==========================================================
    # 27. BARRA DE PROGRESSO
    # ==========================================================
    
    indicadores_toc$Alcance <-
      
      dplyr::case_when(
        
        is.na(
          indicadores_toc$Alcance_Barra
        ) ~
          
          "—",
        
        TRUE ~
          
          paste0(
            
            '<div style="
            width:160px;
            background:#e9e9e9;
            border-radius:10px;
            height:22px;
            overflow:hidden;
          ">
          
            <div style="
              width:',
            
            indicadores_toc$Alcance_Barra,
            
            '%;
              background:#9442d4;
              height:22px;
              border-radius:10px;
              text-align:center;
              color:white;
              font-size:12px;
              line-height:22px;
            ">',
            
            round(
              indicadores_toc$Alcance_Numerico,
              1
            ),
            
            '%</div>
          
          </div>'
          )
      )
    
    
    
    
    # ==========================================================
    # 28. FUNÇÃO PARA FORMATAR VALORES
    # ==========================================================
    
    formatar_valor <-
      function(
    valor,
    tipo
      ) {
        
        if (
          is.na(valor)
        ) {
          
          return("—")
          
        }
        
        
        if (
          tipo == "%"
        ) {
          
          return(
            
            paste0(
              
              round(
                valor,
                1
              ),
              
              "%"
            )
          )
          
        } else {
          
          return(
            
            paste0(
              
              scales::comma(
                round(
                  valor,
                  0
                )
              ),
              
              " MT"
            )
          )
        }
      }
    
    
    
    
    # ==========================================================
    # 29. BASELINE FORMATADO
    # ==========================================================
    
    indicadores_toc$Baseline_Formatado <-
      
      mapply(
        
        formatar_valor,
        
        indicadores_toc$Baseline,
        
        indicadores_toc$Tipo_Indicador
        
      )
    
    
    
    
    # ==========================================================
    # 30. ENDLINE FORMATADO
    # ==========================================================
    
    indicadores_toc$Endline_Formatado <-
      
      mapply(
        
        formatar_valor,
        
        indicadores_toc$Endline,
        
        indicadores_toc$Tipo_Indicador
        
      )
    
    
    
    
    # ==========================================================
    # 31. VARIAÇÃO FORMATADA
    #
    # Percentuais:
    # +37,5 p.p.
    #
    # Valores monetários:
    # +2 500 MT
    # ==========================================================
    
    indicadores_toc$Variacao_Formatada <-
      
      mapply(
        
        function(
    valor,
    tipo
        ) {
          
          if (
            is.na(valor)
          ) {
            
            return("—")
            
          }
          
          
          if (
            tipo == "%"
          ) {
            
            sinal <-
              ifelse(
                valor > 0,
                "+",
                ""
              )
            
            return(
              
              paste0(
                
                sinal,
                
                round(
                  valor,
                  1
                ),
                
                " p.p."
              )
            )
            
          } else {
            
            sinal <-
              ifelse(
                valor > 0,
                "+",
                ""
              )
            
            return(
              
              paste0(
                
                sinal,
                
                scales::comma(
                  round(
                    valor,
                    0
                  )
                ),
                
                " MT"
              )
            )
          }
        },
    
    indicadores_toc$Variacao_Numerica,
    
    indicadores_toc$Tipo_Indicador
    
      )
    
    
    
    
    # ==========================================================
    # 32. META FORMATADA
    # ==========================================================
    
    indicadores_toc$Meta_Formatada <-
      
      mapply(
        
        formatar_valor,
        
        indicadores_toc$Meta_2026,
        
        indicadores_toc$Tipo_Indicador
        
      )
    
    
    
    
    # ==========================================================
    # 33. ID COM HTML
    # ==========================================================
    
    indicadores_toc$ID_Indicador_HTML <-
      
      dplyr::if_else(
        
        is.na(
          indicadores_toc$ID_Indicador
        ) |
          
          indicadores_toc$ID_Indicador == "",
        
        '<span style="
        color:#999999;
        font-style:italic;
      ">Não definido</span>',
        
        paste0(
          
          '<span style="
          font-weight:600;
          color:#9442d4;
        ">',
          
          indicadores_toc$ID_Indicador,
          
          '</span>'
          
        )
      )
    
    
    
    
    # ==========================================================
    # 34. INDICADOR COM HTML
    # ==========================================================
    
    indicadores_toc$Indicador_HTML <-
      
      paste0(
        
        '<div style="
        white-space:normal;
        line-height:1.4;
        padding:4px 0;
      ">',
        
        indicadores_toc$Indicador,
        
        '</div>'
        
      )
    
    
    
    
    # ==========================================================
    # 35. TABELA FINAL
    # ==========================================================
    
    tabela_final_toc <-
      
      indicadores_toc %>%
      
      dplyr::select(
        
        ID_Indicador_HTML,
        
        Indicador_HTML,
        
        Baseline_Formatado,
        
        Endline_Formatado,
        
        Variacao_Formatada,
        
        Meta_Formatada,
        
        Alcance,
        
        Estado
        
      ) %>%
      
      dplyr::rename(
        
        `ID_Indicador` =
          ID_Indicador_HTML,
        
        `Indicador` =
          Indicador_HTML,
        
        `Baseline` =
          Baseline_Formatado,
        
        `Endline` =
          Endline_Formatado,
        
        `Variação` =
          Variacao_Formatada,
        
        `Meta 2026` =
          Meta_Formatada,
        
        `Alcance da Meta` =
          Alcance,
        
        `Estado` =
          Estado
        
      )
    
    
    
    
    # ==========================================================
    # 36. DATATABLE
    # ==========================================================
    
    DT::datatable(
      
      tabela_final_toc,
      
      rownames = FALSE,
      
      escape = FALSE,
      
      extensions = c(
        "Responsive"
      ),
      
      options = list(
        
        pageLength = 15,
        
        scrollX = TRUE,
        
        scrollY = "600px",
        
        scrollCollapse = TRUE,
        
        autoWidth = FALSE,
        
        dom = "tip",
        
        columnDefs = list(
          
          
          # ------------------------------------------------------
          # ID
          # ------------------------------------------------------
          
          list(
            width = "125px",
            targets = 0
          ),
          
          
          # ------------------------------------------------------
          # INDICADOR
          # ------------------------------------------------------
          
          list(
            width = "390px",
            targets = 1
          ),
          
          
          # ------------------------------------------------------
          # BASELINE
          # ------------------------------------------------------
          
          list(
            width = "100px",
            targets = 2
          ),
          
          
          # ------------------------------------------------------
          # ENDLINE
          # ------------------------------------------------------
          
          list(
            width = "100px",
            targets = 3
          ),
          
          
          # ------------------------------------------------------
          # VARIAÇÃO
          # ------------------------------------------------------
          
          list(
            width = "110px",
            targets = 4
          ),
          
          
          # ------------------------------------------------------
          # META
          # ------------------------------------------------------
          
          list(
            width = "100px",
            targets = 5
          ),
          
          
          # ------------------------------------------------------
          # ALCANCE
          # ------------------------------------------------------
          
          list(
            width = "180px",
            targets = 6
          ),
          
          
          # ------------------------------------------------------
          # ESTADO
          # ------------------------------------------------------
          
          list(
            width = "145px",
            targets = 7
          )
          
        )
      )
      
    ) %>%
      
      
      # ==========================================================
    # FORMATAÇÃO ID
    # ==========================================================
    
    DT::formatStyle(
      
      "ID_Indicador",
      
      `white-space` =
        "normal",
      
      `vertical-align` =
        "middle"
      
    ) %>%
      
      
      # ==========================================================
    # FORMATAÇÃO INDICADOR
    # ==========================================================
    
    DT::formatStyle(
      
      "Indicador",
      
      `white-space` =
        "normal",
      
      `vertical-align` =
        "middle"
      
    ) %>%
      
      
      # ==========================================================
    # ALINHAMENTO
    # ==========================================================
    
    DT::formatStyle(
      
      columns = c(
        
        "ID_Indicador",
        
        "Baseline",
        
        "Endline",
        
        "Variação",
        
        "Meta 2026",
        
        "Alcance da Meta",
        
        "Estado"
        
      ),
      
      `text-align` =
        "center",
      
      `vertical-align` =
        "middle"
      
    )
    
    
  })
  
  
 
  ########### BOTAO
  
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
