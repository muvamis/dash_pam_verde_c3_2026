# ======================================
# 1. Lista e instalação de pacotes
# ======================================
packages <- c(
  "readxl", "RStata", "reticulate", "shiny", "bslib", "ggthemes", "RColorBrewer", 
  "sf", "shinythemes", "lubridate", "jsonlite", "stringr", "readr", "dplyr", 
  "ggrepel", "tidyverse", "shinyjs", "plotly", "ggplot2", "DT", "shinyWidgets", 
  "shinydashboard", "shinycssloaders", "cowplot", "ggmap", "ggspatial", 
  "rmarkdown","fontawesome", "haven", "gridExtra", "scales", 
  "writexl", "openxlsx", "kableExtra", "rlang", "formattable", "glue", "httr2", 
  "dotenv", "RZohoCreator", "purrr"
)

# Instala pacotes que não estão instalados
install_packages <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]
if (length(install_packages) > 0) install.packages(install_packages)

# Carrega os pacotes
lapply(packages, require, character.only = TRUE)


library(lubridate)
# devtools::install_github('muvamis/RZohoCreator')

############### PRESENCAS COLECTIVAS
# carrega as variaveis do ficheiro .env
dotenv::load_dot_env()


PAM_VERDE_BASELINE_2026 <- read_excel("PAM_VERDE_2026_Baseline.xlsx")



Pegada_Carbono <- read_excel("Pegada_Baseline_2026.xlsx")


# ===============================================================
# NOMES DAS EMPREENDEDORAS A EXCLUIR
# ===============================================================

nomes_excluir <- c(
  "AMELIA AFUSSA ANTONIO",
  "AQUILAY JOAO HOVASE",
  "DENISE ISILDA MIGUEL TOCOTA",
  "DULQUIFAL ASSANE SIMBA",
  "FAIZA FERNANDO HENRIQUES",
  "FATIMA SALVADOR AMADE",
  "GLORIA DA CONSTANCIA LOJA",
  "IVANDRA CHALES",
  "MADALENA CARIM MERAGE",
  "MARIAMO DOMINGOS JAIROSSE",
  "KHADYA AMADE SILIMO",
  "NATANIELA DILCIA MASSANGAIE",
  "NGAMO SUMAIL",
  "MARIAMO HANIFA ABACAR CHALE SALIMO",
  "SAMIRA COMBO MUHOLE ASSUMANE",
  "SHEILA RAIMUNDO ANTUNES",
  "SUZANA JOAQUIM VAQUINA",
  "MARAVILHA JANUARIO CARIA",
  "ESTEFANIA SAMUEL BOLACHA",
  "MINDOCA NARCISO MAHLAULE"
)


# ===============================================================
# PAM VERDE - BASELINE 2026
# ===============================================================

PAM_VERDE_BASELINE_2026 <- read_excel(
  "PAM_VERDE_2026_Baseline.xlsx"
) %>%
  mutate(
    `Nomes Das Empreendedoras` = toupper(
      stringr::str_squish(
        trimws(as.character(`Nomes Das Empreendedoras`))
      )
    )
  ) %>%
  filter(
    !`Nomes Das Empreendedoras` %in% nomes_excluir
  )


# ===============================================================
# PEGADA DE CARBONO
# ===============================================================

Pegada_Carbono <- read_excel(
  "Pegada_Baseline_2026.xlsx"
) %>%
  mutate(
    `Nomes das participantes` = toupper(
      stringr::str_squish(
        trimws(as.character(`Nomes das participantes`))
      )
    )
  ) %>%
  filter(
    !`Nomes das participantes` %in% nomes_excluir
  )
# Pam_Verde_Indicadores <- Pam_Verde_Indicadores[, -c(95,96,97,98,99)]  
# 
# Pam_Verde_Indicadores <- Pam_Verde_Indicadores %>%
#   mutate(
#     Data_nasc = as.Date(`Data de nascimento`, format = "%d/%m/%Y"),
#     Idade = floor(interval(Data_nasc, Sys.Date()) / years(1)),
#     Ciclo = "Ciclo_2"
#   )
# 

Pam_Verde_Indicadores <- PAM_VERDE_BASELINE_2026 %>%
   rename(Aceita_Participar = `Confirma que compreendeu a informação acima e aceita participar nesta entrevista?`,  
          Data_Entrevista = `Data da entrevista`,  
          Tipo_Avaliacao = `Momento:`,
          Ciclo = `Ciclo do Programa:`,
          ID_Participante = `Codigo Da Participante`,
          Nome_Participante = `Nomes Das Empreendedoras`,
          Data_Nascimento = `Data De Nascimento`,
          Estado_Civil = `Estado Civil:`,
          Cidade = `Cidade De Residência`,
          Nome_Negocio = `Nome Do Negócio (ou descrição do negócio):`,
          Sector = `Sector de actividade`,
          Ano_Negocio = `Ano De Criação Do Negócio:`,
          Negocio_Formalizado = `O seu negócio está formalizado? (registado oficialmente e com Certificado de Registo Comercial)`,
          Uso_Servicos_Financeiros = `Utiliza actualmente algum dos seguintes serviços financeiros para o seu negócio?`,
          Tira_Salario_Para_Si = `Retira regularmente  um salário para si mesma?`,
          Clientes_Regulares_Negocio = `Quantos clientes regulares tem actualmente no seu negócio?`,
          Quem_Toma_Decisoes_Negocio = `Quem costuma tomar as principais decisões sobre o seu negócio?`,
          Negociacao_Pessoas_Com_Quem_Trabalha = `Pessoas com quem trabalha (fornecedores, funcionários, parceiros...)`,
          Negociacao_Com_Clientes = Clientes,
          Negociacao_Com_Agregado_Familiar = `Pessoas do agregado familiar / esfera pessoal (sobre uso de dinheiro do negócio, tempo para trabalhar)`,
          Uso_de_ferramentas_de_IA = `Já utilizou alguma ferramenta de inteligência artificial (ex: ChatGPT, Gemini ou outra) para pesquisar sobre os seus clientes ou obter informações úteis para o negócio?[`,
          Praticou_negociação_nos_últimos_3meses = `Nos últimos 3 meses, teve alguma situação em que podia negociar preços, prazos ou condições com fornecedor ou cliente para beneficiar o seu negócio?`,
          Nível_de_conhecimento_ambiental = `Como classificaria o seu nível de conhecimento sobre questões ambientais em geral? (poluição, catástrofes naturais, falta de recursos, impacto de actividades...)`,
          Onde_vende = `Onde vende actualmente os seus produtos ou serviços?`
   )

Pam_Verde_Indicadores <- Pam_Verde_Indicadores %>%
  filter(Ciclo %in% c("Ciclo 3", "Ciclo 1"))

# table(Pam_Verde_Indicadores$`B2  Aplicação no negócio`)


############## PEGADA DE CARBONO

# =====================================================
# RENOMEAR VARIÁVEIS
# =====================================================

Pegada_Carbono <- Pegada_Carbono %>%
  
  rename(
    
    Aceita_Participar = `Confirma que compreendeu a informação acima e aceita participar nesta entrevista?`,
    
    Data_Entrevista = `Data do registo:`,
    
    Nome_Projeto = `Nome do Projecto`,
    
    Ano_Projeto = `Ano do Projecto`,
    
    Ciclo = `Ciclo do Programa:`,
    
    Tipo_Avaliacao = `Tipo de Avaliação:`,
    
    Nome_Participante = `Nomes das participantes`,
    
    Sector = `Sector de actividade`,
    
    Tipo_Energia = `Que tipo de energia usa no seu negócio?`,
    
    Frequencia_Energia = `Com que frequência utilizas a principal fonte de energia no teu negócio?`,
    
    Desliga_Equipamentos = `Quando terminas de usar equipamentos ou fontes de energia no teu negócio, costumas desligá-los?`,
    
    Depois_Usar_Energia = `Depois de usar energia no teu negócio, o que costumas fazer?`,
    
    Onde_Compra = `Onde compras os produtos para seu negócio?`,
    
    Frequencia_Compras = `Quantas vezes na semana ou no mês compras os produtos para desempenhar vosso negócio?`,
    
    Tipo_Embalagem = `Quando compras as embalagens para entregar teus produtos, que tipo utilizas?`,
    
    Produtos_Embalados = `Quando compras os produtos para desempenhar teu negócio, os levas embora embalados em plásticos?`,
    
    Faz_Entregas = `Faz entregas ou atendimento ao domicílio?`,
    
    Transporte_Baixa_Emissao = `Se sim, quando vais entregar teus produtos/serviços, utilizas meios de deslocação de baixa emissão de carbono (bicicleta, ir de chapa ou ir a pé)?`,
    
    Separar_Lixo = `Separas o lixo orgânico do não orgânico?`,
    
    Compostagem = `Utilizas o lixo orgânico do teu negócio para compostagem?`,
    
    Vende_Compostagem = `Vendes o lixo orgânico do teu negócio para compostagem?`,
    
    Reutiliza_Lixo = `Reutilizas o lixo não orgânico do teu negócio (ex. embalagem)?`,
    
    Reutiliza_Agua = `No seu negócio, com que frequência reutiliza água para realizar alguma actividade?`
    
  )

# =====================================================
# PONTUAÇÃO - CONSUMO DE ENERGIA
# =====================================================

table(Pegada_Carbono$Tipo_Energia)

Pegada_Carbono <- Pegada_Carbono %>%
  
  mutate(
    
    p_energia_tipo =
      case_when(
        Tipo_Energia %in% c(
          "3.	Painel solar / energia solar",
          "1.	Eletricidade da rede"
        ) ~ 0,
        
        Tipo_Energia %in% c(
          "4.	Gás",
          "7.	Pilhas / baterias"
        ) ~ 1,
        
        TRUE ~ 2
      ),
    
    
    p_desliga =
      case_when(
        Desliga_Equipamentos == "Sempre" ~ 0,
        Desliga_Equipamentos == "Às vezes" ~ 1,
        TRUE ~ 2
      ),
    
    
    Pontuacao_Consumo_Energia =
      p_energia_tipo + p_desliga
  )

# =====================================================
# PONTUAÇÃO - AQUISIÇÃO
# =====================================================

Pegada_Carbono <- Pegada_Carbono %>%
  
  mutate(
    
    p_local_compra =
      case_when(
        Onde_Compra == "Compra dentro do meu bairro." ~ 0,
        Onde_Compra == "Dentro da cidade (mas fora do bairro)" ~ 1,
        TRUE ~ 2
      ),
    
    
    p_embalagem =
      case_when(
        Tipo_Embalagem %in% c(
          "Embalagens reutilizáveis (ex: caixas, sacos de pano, frascos de vidro)",
          "Embalagens biodegradaveis/compostáveis",
          "Embalagens de papel ou cartão"
        ) ~ 0,
        
        Tipo_Embalagem == "Embalagens de plástico" ~ 2,
        
        TRUE ~ 1
      ),
    
    
    p_plastico =
      case_when(
        Produtos_Embalados == "Nunca adquire produtos vendidos em embalagens plásticas." ~ 0,
        
        Produtos_Embalados == "As vezes adquire produtos vendidos em embalagens plásticas." ~ 1,
        
        TRUE ~ 2
      ),
    
    
    Pontuacao_Aquisicao =
      p_local_compra +
      p_embalagem +
      p_plastico
  )

# =====================================================
# PONTUAÇÃO - ENTREGAS
# =====================================================

Pegada_Carbono <- Pegada_Carbono %>%
  
  mutate(
    
    p_entrega =
      case_when(
        
        Transporte_Baixa_Emissao ==
          "Sempre utiliza meios de deslocação que tem baixa emissão de gases" ~ 0,
        
        Transporte_Baixa_Emissao ==
          "As vezes utiliza meios de deslocação que tem baixa emissão de gases" ~ 1,
        
        TRUE ~ 2
      ),
    
    
    Pontuacao_Entregas = p_entrega
  )

# =====================================================
# PONTUAÇÃO - GESTÃO DE RESÍDUOS
# =====================================================

Pegada_Carbono <- Pegada_Carbono %>%
  
  mutate(
    
    p_separar =
      case_when(
        Separar_Lixo ==
          "Sempre separa o lixo orgânico do lixo não orgânico." ~ 0,
        
        Separar_Lixo ==
          "As vezes separa o lixo orgânico do lixo não orgânico." ~ 1,
        
        TRUE ~ 2
      ),
    
    
    p_compostagem =
      case_when(
        Compostagem ==
          "Sempre utiliza o lixo orgânico para a compostagem." ~ 0,
        
        Compostagem ==
          "As vezes utiliza o lixo orgânico para a compostagem." ~ 1,
        
        TRUE ~ 2
      ),
    
    
    p_reutiliza =
      case_when(
        Reutiliza_Lixo ==
          "Sempre reutiliza o lixo não orgânico dentro do negócio." ~ 0,
        
        Reutiliza_Lixo ==
          "As vezes reutiliza o lixo não orgânico dentro do negócio." ~ 1,
        
        TRUE ~ 2
      ),
    
    
    p_agua =
      case_when(
        Reutiliza_Agua ==
          "Sempre reutiliza agua para desempenhar atividades do negocio." ~ 0,
        
        Reutiliza_Agua ==
          "As vezes reutiliza agua para desempenhar atividades do negocio." ~ 1,
        
        TRUE ~ 2
      ),
    
    
    Pontuacao_Residuos =
      p_separar +
      p_compostagem +
      p_reutiliza +
      p_agua
  )

# =====================================================
# RESULTADO FINAL
# =====================================================

Pegada_Carbono <- Pegada_Carbono %>%
  
  mutate(
    
    Pontuacao_Total =
      
      Pontuacao_Consumo_Energia +
      Pontuacao_Aquisicao +
      Pontuacao_Entregas +
      Pontuacao_Residuos,
    
    
    Status_Pegada =
      case_when(
        
        Pontuacao_Total <= 5 ~
          "PEGADA BAIXA",
        
        Pontuacao_Total <= 10 ~
          "PEGADA MÉDIA",
        
        TRUE ~
          "PEGADA ALTA"
      )
  )

############################# MONITORIA

PERFIL_PAM_VERDE_C3_2026 <- read_excel("EMPREENDEDORAS_PAM_VERDE_C3_2026.xlsx")

PERFIL_PAM_VERDE_C3_2026 <- PERFIL_PAM_VERDE_C3_2026 %>%
  rename(Aceita_Participar = `Confirma que compreendeu a informação acima e aceita participar nesta entrevista?`,  
         Data_Entrevista = `Data da entrevista`,  
         Tipo_Avaliacao = `Momento:`,
         Ciclo = `Ciclo do Programa:`,
         ID_Participante = `Codigo Da Participante`,
         Nome_Participante = `Nomes Das Empreendedoras`,
         Data_Nascimento = `Data De Nascimento`,
         Estado_Civil = `Estado Civil:`,
         Cidade = `Cidade De Residência`,
         Nome_Negocio = `Nome Do Negócio (ou descrição do negócio):`,
         Sector = `Sector de actividade`,
         Ano_Negocio = `Ano De Criação Do Negócio:`,
         Negocio_Formalizado = `O seu negócio está formalizado? (registado oficialmente e com Certificado de Registo Comercial)`,
         Uso_Servicos_Financeiros = `Utiliza actualmente algum dos seguintes serviços financeiros para o seu negócio?`,
         Tira_Salario_Para_Si = `Retira regularmente  um salário para si mesma?`,
         Clientes_Regulares_Negocio = `Quantos clientes regulares tem actualmente no seu negócio?`,
         Quem_Toma_Decisoes_Negocio = `Quem costuma tomar as principais decisões sobre o seu negócio?`,
         Negociacao_Pessoas_Com_Quem_Trabalha = `Pessoas com quem trabalha (fornecedores, funcionários, parceiros...)`,
         Negociacao_Com_Clientes = Clientes,
         Negociacao_Com_Agregado_Familiar = `Pessoas do agregado familiar / esfera pessoal (sobre uso de dinheiro do negócio, tempo para trabalhar)`
         
  )



################################## PRESENCAS COLECTIVAS 
Presencas_Colectivas_Nampula <- read_excel("Presencas_colectivas_Nampula.xlsx")

Webinars_Nampula <- read_excel("Webinars_Nampula.xlsx")

Feiras_Nampula <- read_excel("Feiras_Nampula.xlsx")


# ============================================================
# 1. LEITURA DAS BASES
# ============================================================

Presenca <- read_excel("Presencas_colectivas.xlsx")

# Presenca_Nampula <- read_excel("Presencas_colectivas_Nampula.xlsx")
# 
# 
# # ============================================================
# # 2. PREPARAÇÃO DA BASE DE NAMPULA
# # ============================================================
# 
# Presenca_Nampula <- Presenca_Nampula[, -c(6, 7, 11, 12, 14)]
# 
# Presenca_Nampula <- Presenca_Nampula %>%
#   rename(
#     Pesquisadores    = Control_Facilitador,
#     ID_MUVA          = Nome_Empreendedora.ID_Da_Empreendedoras,
#     Nome_Sessao      = Nome_da_Sess_o.Tema_Sesao,
#     Tipo_Sessao      = Control_Sessao,
#     Cidade           = Control_Cidade,
#     Presença         = Presen_a,
#     Nome_Participante = Nome_Empreendedora.zc_display_value,
#     Status            = Nome_Empreendedora.Status,
#     Ciclo             = Nome_Empreendedora.Ciclo
#   ) %>%
#   filter(Status %in% c("Activa", "Desistente"))
# 
# 
# # ============================================================
# # 3. PREPARAÇÃO DA BASE DA BEIRA
# # ============================================================

Presenca_Beira <- Presenca %>%
  select(-c(6, 7, 11, 12, 14)) %>%
  rename(
    Pesquisadores    = Control_Facilitador,
    ID_MUVA          = Nome_Empreendedora.ID_Da_Empreendedoras,
    Nome_Sessao      = Nome_da_Sess_o.Tema_Sesao,
    Tipo_Sessao      = Control_Sessao,
    Cidade           = Control_Cidade,
    Presença         = Presen_a,
    Nome_Participante = Nome_Empreendedora.zc_display_value,
    Status            = Nome_Empreendedora.Status,
    Ciclo             = Nome_Empreendedora.Ciclo
  ) %>%
  filter(Status %in% c("Activa", "Desistente"))


# ============================================================
# 4. FUNÇÃO PARA PADRONIZAR SESSÕES COLECTIVAS
# ============================================================

padronizar_sessoes <- function(base) {
  
  base %>%
    mutate(
      Nome_Sessao = case_when(
        
        Nome_Sessao == "Sessao1 – Introdução à Abordagem Integrada do Projecto" ~ "Sessao_1",
        Nome_Sessao == "Sessao2 – Modelo de Negócio" ~ "Sessao_2",
        Nome_Sessao == "Sessao3 – Cadeia de suprimentos e Registos financeiros" ~ "Sessao_3",
        Nome_Sessao == "Sessao4 – Poder interno" ~ "Sessao_4",
        Nome_Sessao == "Sessao5 – Meio Ambiente e Negócios" ~ "Sessao_5",
        Nome_Sessao == "Sessao6 – Gestão do tempo" ~ "Sessao_6",
        Nome_Sessao == "Sessao7 – Jornada da Persona e Introdução à HCD" ~ "Sessao_7",
        Nome_Sessao == "Sessao8 – Uso das Ferramentas do HCD e Inteligência artificial" ~ "Sessao_8",
        Nome_Sessao == "Sessao9 – Experiência HCD e IA, Ganhos, Riscos e Uso Responsável da IA?" ~ "Sessao_9",
        Nome_Sessao == "Sessao10 – Revisão de ferramentas e Negociação" ~ "Sessao_10",
        Nome_Sessao == "Sessao11 – Prototipagem" ~ "Sessao_11",
        Nome_Sessao == "Sessao12 – Precificação e Fechamento" ~ "Sessao_12",
        Nome_Sessao == "Sessao13 – Criação 1 de protótipos (parte gráfica de logotipos e flyers) com empreendedoras e facilitadores" ~ "Sessao_13",
        Nome_Sessao == "Sessao14 – Criação 2 de protótipos (parte gráfica de logotipos e flyers) com empreendedoras e facilitadores" ~ "Sessao_14",
        Nome_Sessao == "Sessao15 – Criação 3 de protótipos (parte gráfica de logotipos e flyers) com empreendedoras e facilitadores" ~ "Sessao_15",
        Nome_Sessao == "Sessao16 – Reflexão de como foi o processo de testagem e Aprimoramento do protótipo" ~ "Sessao_16",
        Nome_Sessao == "Sessao17 – Eu empreendedora, agente de mudança e Revisão das ferramentas de negócios" ~ "Sessao_17",
        Nome_Sessao == "Sessao18 – Eu mulher, empreendedora moçambicana e Avaliação da Formação" ~ "Sessao_18",
        
        TRUE ~ Nome_Sessao
      )
    )
}


# ============================================================
# 5. FUNÇÃO PARA TRANSFORMAR PRESENÇAS EM FORMATO WIDE
# ============================================================

organizar_presencas <- function(base) {
  
  base %>%
    select(
      Cidade,
      ID_MUVA,
      Nome_Participante,
      Nome_Sessao,
      Presença,
      Pesquisadores
    ) %>%
    
    pivot_wider(
      names_from = Nome_Sessao,
      values_from = Presença,
      values_fn = ~ first(.x)
    ) %>%
    
    {
      sessoes <- grep("^Sessao_\\d+$", names(.), value = TRUE)
      
      sessoes <- sessoes[
        order(
          as.numeric(
            gsub("Sessao_", "", sessoes)
          )
        )
      ]
      
      select(
        .,
        Cidade,
        Pesquisadores,
        ID_MUVA,
        Nome_Participante,
        all_of(sessoes)
      )
    }
}


# ============================================================
# 6. PRESENÇAS COLECTIVAS
# ============================================================

Presencas_Colectivas_Base <- bind_rows(
  Presenca_Beira
) %>%
  filter(
    Tipo_Sessao %in% c(
      "Bootcamp 1",
      "Bootcamp 2",
      "Bootcamp 3"
    )
  ) %>%
  padronizar_sessoes()

# 
# # NAMPULA
# Presencas_Colectivas_Nampula <- Presencas_Colectivas_Base %>%
#   filter(Cidade == "Nampula") %>%
#   organizar_presencas()


# BEIRA
Presencas_Colectivas_Beira <- Presencas_Colectivas_Base %>%
  filter(Cidade == "Beira") %>%
  organizar_presencas()


# ============================================================
# 7. WEBINARS
# ============================================================

Webinars_Base <- bind_rows(
  Presenca_Beira
) %>%
  filter(Tipo_Sessao == "Webinar") %>%
  
  mutate(
    Nome_Sessao = case_when(
      
      Nome_Sessao ==
        "Sessao19 – Webinar1 Processo de formalização de negócios" ~
        "Sessao_19",
      
      Nome_Sessao ==
        "Sessao20 – Webinar2 Práticas sustentáveis" ~
        "Sessao_20",
      
      Nome_Sessao ==
        "Sessao21 – Webinar3 Marketing Digital" ~
        "Sessao_21",
      
      TRUE ~ Nome_Sessao
    )
  )


# ============================================================
# 8. ORGANIZAR WEBINARS
# ============================================================

organizar_webinars <- function(base) {
  
  base %>%
    select(
      Cidade,
      Tipo_Sessao,
      Pesquisadores,
      ID_MUVA,
      Nome_Participante,
      Nome_Sessao,
      Presença
    ) %>%
    
    pivot_wider(
      names_from = Nome_Sessao,
      values_from = Presença,
      values_fn = ~ first(.x)
    ) %>%
    
    {
      sessoes <- grep("^Sessao_\\d+$", names(.), value = TRUE)
      
      sessoes <- sessoes[
        order(
          as.numeric(
            gsub("Sessao_", "", sessoes)
          )
        )
      ]
      
      select(
        .,
        Cidade,
        Tipo_Sessao,
        Pesquisadores,
        ID_MUVA,
        Nome_Participante,
        all_of(sessoes)
      )
    }
}


# # NAMPULA
# Webinars_Nampula <- Webinars_Base %>%
#   filter(Cidade == "Nampula") %>%
#   organizar_webinars()


# BEIRA
Webinars_Beira <- Webinars_Base %>%
  filter(Cidade == "Beira") %>%
  organizar_webinars()


# ============================================================
# 9. FEIRAS
# ============================================================

Feiras_Base <- bind_rows(
  # Presenca_Nampula,
  Presenca_Beira
) %>%
  filter(Tipo_Sessao == "Feiras") %>%
  
  mutate(
    Nome_Sessao = case_when(
      
      Nome_Sessao ==
        "Sessao22 – Feira empresarial" ~
        "Sessao_22",
      
      TRUE ~ Nome_Sessao
    )
  )


# ============================================================
# 10. ORGANIZAR FEIRAS
# ============================================================

organizar_feiras <- function(base) {
  
  base %>%
    select(
      Cidade,
      Tipo_Sessao,
      Pesquisadores,
      ID_MUVA,
      Nome_Participante,
      Nome_Sessao,
      Presença
    ) %>%
    
    pivot_wider(
      names_from = Nome_Sessao,
      values_from = Presença,
      values_fn = ~ first(.x)
    ) %>%
    
    {
      sessoes <- grep("^Sessao_\\d+$", names(.), value = TRUE)
      
      sessoes <- sessoes[
        order(
          as.numeric(
            gsub("Sessao_", "", sessoes)
          )
        )
      ]
      
      select(
        .,
        Cidade,
        Tipo_Sessao,
        Pesquisadores,
        ID_MUVA,
        Nome_Participante,
        all_of(sessoes)
      )
    }
}


# # NAMPULA
# Feiras_Nampula <- Feiras_Base %>%
#   filter(Cidade == "Nampula") %>%
#   organizar_feiras()
# 

# BEIRA
Feiras_Beira <- Feiras_Base %>%
  filter(Cidade == "Beira") %>%
  organizar_feiras()


# ============================================================
# 11. VERIFICAÇÃO FINAL
# ============================================================

# dim(Presencas_Colectivas_Nampula)
dim(Presencas_Colectivas_Beira)

# dim(Webinars_Nampula)
dim(Webinars_Beira)

# dim(Feiras_Nampula)
dim(Feiras_Beira)


# # Número de participantes por cidade
# Presencas_Colectivas_Nampula %>%
#   summarise(
#     Participantes = n_distinct(ID_MUVA)
#   )

Presencas_Colectivas_Beira %>%
  summarise(
    Participantes = n_distinct(ID_MUVA)
  )

# library(writexl)
# 
# write_xlsx(
#   Presencas_Colectivas_Nampula,
#   "Presencas_Colectivas_Nampula.xlsx"
# )
# 
# write_xlsx(
#   Feiras_Nampula,
#   "Feiras_Nampula.xlsx"
# )
# 
# write_xlsx(
#   Webinars_Nampula,
#   "Webinars_Nampula.xlsx"
# )

################ DADOS FINANCEIROS

# =====================================================
# DADOS FICTÍCIOS (substitui o read_excel)
# =====================================================
# 
# set.seed(123)
# 
# Nome_do_Pesquisador <- c("Pesquisador 1", "Pesquisador 2", "Pesquisador 3")
# 
# empreendedoras <- c("Iolanda F", "Silvia J", "Helena A", "Maria K", "João L")
# cidades <- c("Nampula", "Maputo", "Beira")
# setores <- c("Artesanato", "Boleiros", "Costura")
# 
# periodos <- c("Primeiro Mês", "Segundo Mês", "Terceiro Mês")
# semanas <- c("Primeira Semana", "Segunda Semana", "Terceira Semana")
# 
# Projeto <- "PAM VERDE"
# Ano_Projeto <- 2025
# 
# df_base <- expand.grid(
#   Nome_do_Pesquisador = Nome_do_Pesquisador,
#   Nome_Empreendedora = empreendedoras,
#   Cidade = cidades,
#   Setor_Negocio = setores,
#   Periodo = periodos,
#   Semanas = semanas,
#   KEEP.OUT.ATTRS = FALSE,
#   stringsAsFactors = FALSE
# )
# 
# df_ficticio <- df_base %>%
#   mutate(
#     Projeto = Projeto,
#     Ano_Projeto = Ano_Projeto,
#     Rendimento = round(runif(n(), 900, 2500)),
#     Custo_Operacional = round(runif(n(), 120, 900)),
#     Custo_de_produtos_Servicos = round(runif(n(), 60, 600))
#   ) %>%
#   mutate(
#     Lucro_Semanal = Rendimento - Custo_Operacional - Custo_de_produtos_Servicos
#   ) %>%
#   # opcional: evita lucros absurdamente negativos
#   mutate(Lucro_Semanal = ifelse(Lucro_Semanal < -300, -50, Lucro_Semanal))

# Financeiro_Report no formato que seu dashboard usa


library(readxl)
library(dplyr)
library(tidyr)

# ============================================================
# 1. LEITURA DA BASE
# ============================================================

Financeiro_Report <- read_excel("Financeiro_Report.xlsx")


# ============================================================
# 2. REMOÇÃO DE COLUNAS DESNECESSÁRIAS
# ============================================================

Financeiro_Report <- Financeiro_Report[, -c(
  7, 8, 13, 15, 17, 27, 28, 29, 30, 35, 36
)]


# ============================================================
# 3. PADRONIZAÇÃO DOS NOMES
# ============================================================

Financeiro_Report <- Financeiro_Report %>%
  rename(
    Projeto = NOME_PROJECTO.PROJECTO_NAME,
    Nome_Empreendedora = Nome_empreendedoras.name_empreendedora,
    Ano_Projeto = ANO_DO_PROJECTO.Ano_do_projecto,
    Setor_Negocio = Sector_do_negocio1.SECTOR_DO_NEGOCIO,
    Cidade = CIDADE.CIDADE,
    Status = Nome_empreendedoras.Status
  )


# ============================================================
# 4. BASE NAMPULA
#    Mantém TODAS as variáveis
# ============================================================

Financeiro_Nampula <- Financeiro_Report %>%
  filter(
    Cidade == "NAMPULA",
    Status == "Activa"
  )


# ============================================================
# 5. BASE BEIRA
#    Mantém TODAS as variáveis
# ============================================================

Financeiro_Beira <- Financeiro_Report %>%
  filter(
    Cidade == "Beira",
    Status == "Activa"
  )


# ============================================================
# 6. TRATAMENTO NUMÉRICO - NAMPULA
# ============================================================

Financeiro_Nampula <- Financeiro_Nampula %>%
  mutate(
    across(
      c(
        Rendimento,
        Custo_Operacional,
        Custo_de_produtos_Servicos
      ),
      ~ as.numeric(.)
    ),
    
    Rendimento = replace_na(Rendimento, 0),
    Custo_Operacional = replace_na(Custo_Operacional, 0),
    Custo_de_produtos_Servicos = replace_na(
      Custo_de_produtos_Servicos,
      0
    ),
    
    Lucro_Semanal =
      Rendimento -
      Custo_Operacional -
      Custo_de_produtos_Servicos,
    
    Periodo = case_when(
      Periodo == "Primeiro Mes de Implementação" ~ "Primeiro Mês",
      Periodo == "Segundo Mes de Implementação" ~ "Segundo Mês",
      Periodo == "Terceiro Mes de Implementação" ~ "Terceiro Mês",
      TRUE ~ Periodo
    )
  )


# ============================================================
# 7. TRATAMENTO NUMÉRICO - BEIRA
# ============================================================

Financeiro_Beira <- Financeiro_Beira %>%
  mutate(
    across(
      c(
        Rendimento,
        Custo_Operacional,
        Custo_de_produtos_Servicos
      ),
      ~ as.numeric(.)
    ),
    
    Rendimento = replace_na(Rendimento, 0),
    Custo_Operacional = replace_na(Custo_Operacional, 0),
    Custo_de_produtos_Servicos = replace_na(
      Custo_de_produtos_Servicos,
      0
    ),
    
    Lucro_Semanal =
      Rendimento -
      Custo_Operacional -
      Custo_de_produtos_Servicos,
    
    Periodo = case_when(
      Periodo == "Primeiro Mes de Implementação" ~ "Primeiro Mês",
      Periodo == "Segundo Mes de Implementação" ~ "Segundo Mês",
      Periodo == "Terceiro Mes de Implementação" ~ "Terceiro Mês",
      TRUE ~ Periodo
    )
  )


############################## BEIRA

PERFIL_PAM_VERDE_BEIRA_C3_2026 <- read_excel("PERFIL_PAM_VERDE_BEIRA_C3_2026.xlsx")

# Presencas_Colectivas_Beira <- read_excel("Presencas_Colectivas_Beira.xlsx")



# ===============================================================
# PAM VERDE - BASE EXCLUSIVA PARA TOC | CICLO 3
# ===============================================================

PAM_VERDE_TOC_C3 <- Pam_Verde_Indicadores %>%
  filter(Ciclo == "Ciclo 3")

FINANCEIRO_TOC_NAMPULA <- Financeiro_Nampula

table(FINANCEIRO_TOC_NAMPULA$Periodo, FINANCEIRO_TOC_NAMPULA$Lucro_Semanal)

# table(PAM_VERDE_TOC_C3$Tipo_Avaliacao, PAM_VERDE_TOC_C3$`Não se espera que as mulheres sejam capazes de gerir um negócio.`)
