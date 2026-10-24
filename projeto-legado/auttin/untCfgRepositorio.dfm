object frmCfgRepositorio: TfrmCfgRepositorio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 278
  Width = 259
  object cxRepositorio: TcxEditRepository
    Left = 44
    Top = 12
    PixelsPerInch = 96
    object edtValDin: TcxEditRepositoryCurrencyItem
      Properties.DisplayFormat = ',0.00;(,0.00)'
      Properties.EditFormat = '#,##0.00'
      Properties.UseThousandSeparator = True
    end
    object rdgSimNao_S_N: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'SIM'
          Value = 'S'
        end
        item
          Caption = 'N'#195'O'
          Value = 'N'
        end>
      Properties.WordWrap = True
    end
    object rdgLayDef: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Layout espec'#237'fico pelo FR3'
          Value = '1'
        end
        item
          Caption = 'Seguindo o editor de layouts de impress'#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgUSigep: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o Utiliza'
          Value = 'N'
        end
        item
          Caption = 'Utiliza Sigep Web (Web Service)'
          Value = 'S'
        end
        item
          Caption = 'Usar Off Line (Apenas Gera o Arquivo XML)'
          Value = 'O'
        end>
    end
    object rdgCusCad: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'KG'
          Value = '1'
        end
        item
          Caption = 'KG e LT'
          Value = '2'
        end>
    end
    object rdgPrecoAKZ: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Compra'
          Value = 'COM'
        end
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'CUS'
        end
        item
          Caption = 'Pre'#231'o de Venda 1'
          Value = 'VE1'
        end
        item
          Caption = 'Pre'#231'o de Venda 2'
          Value = 'VE2'
        end
        item
          Caption = 'Pre'#231'o de Venda 3'
          Value = 'VE3'
        end
        item
          Caption = 'Pre'#231'o de Venda 4'
          Value = 'VE4'
        end
        item
          Caption = 'Pre'#231'o de Venda 5'
          Value = 'VE5'
        end
        item
          Caption = 'Pre'#231'o de Venda 6'
          Value = 'VE6'
        end
        item
          Caption = 'Pre'#231'o de Venda 7'
          Value = 'VE7'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio de Compra'
          Value = 'MED'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra'
          Value = 'ULT'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra com impostos da entrada'
          Value = 'IMP'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra ( LOTE )'
          Value = 'LOTULT'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra com impostos da entrada ( LOTE )'
          Value = 'LOTIMP'
        end>
    end
    object rdgTravaEmbFechada: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'TRAVAR NO PR'#211'PRIO PRE'#199'O DA EMBALAGEM FECHADA'
          Value = '1'
        end
        item
          Caption = 'APLICAR DESCONTOS PERMITIDOS SOBRE O PRE'#199'O DE EMBALAGEM FECHADA'
          Value = '2'
        end
        item
          Caption = 'N'#195'O UTILIZAR O PRE'#199'O DE EMBALAGEM FECHADA NA TRAVA DE PRE'#199'O'
          Value = '3'
        end
        item
          Caption = 'NENHUM'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgEmpResFin: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Somente das empresas que o operador tem direito de acesso.'
          Value = '1'
        end
        item
          Caption = 'Todas as empresas'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgEmpCCC: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Somente das empresas que o operador tem direito de acesso.'
          Value = '1'
        end
        item
          Caption = 'Todas as empresas'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTCrIcm: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Campo de valor do icms'
          Value = '1'
        end
        item
          Caption = 'Campo de valor dos produtos e campo de total da nota fiscal'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTipDescPon: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Condi'#231#227'o de Pagamento'
          Value = '1'
        end
        item
          Caption = 'Cliente'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgBaiVid: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Ordem de produ'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Requisi'#231#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgEmpF11: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Empresa em Branco'
          Value = '1'
        end
        item
          Caption = 'Empresa Logada'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgImpBol: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'N'#227'o imprimir'
          Value = 'N'
        end
        item
          Caption = 'Perguntar se deseja imprimir'
          Value = 'S'
        end
        item
          Caption = 'Imprimir automaticamente'
          Value = 'A'
        end>
      Properties.WordWrap = True
    end
    object rdgSimNaoPergunda_S_N_P: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'SIM'
          Value = 'S'
        end
        item
          Caption = 'N'#195'O'
          Value = 'N'
        end
        item
          Caption = 'PERGUNTAR'
          Value = 'P'
        end>
      Properties.WordWrap = True
    end
    object rdgProcBaixaEntFut: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Informando a quantidade a baixar manualmente pelo operador'
          Value = '1'
        end
        item
          Caption = 'Escaneando o codigo de barras do produto a baixar'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgSugPrecoDev: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Carregar como sugest'#227'o o valor realizado no documento de venda'
          Value = '1'
        end
        item
          Caption = 
            'Se valor realizado no documento de venda for menor que o pre'#231'o '#224 +
            #160'vista original, carregar como sugest'#227'o o valor realizado no doc' +
            'umento de venda. Se valor realizado no documento de venda for ma' +
            'ior que o pre'#231'o '#224#160'vista original, carregar como sugest'#227'o o pre'#231'o' +
            ' '#224#160'vista original.'
          Value = '2'
        end
        item
          Caption = 
            'Se valor realizado no documento de venda for menor que pre'#231'o '#224#160'v' +
            'ista atual, carregar como sugest'#227'o o valor realizado no document' +
            'o de venda. Se valor realizado no documento de venda for maior q' +
            'ue o pre'#231'o '#224#160'vista atual, carregar como sugest'#227'o o pre'#231'o '#224#160'vista' +
            ' atual seguindo o pre'#231'o de tabela do cadastro do produto ou prom' +
            'o'#231#227'o.'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgSenSep: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pedir a senha do separador e j'#225' definir o mesmo para o pedido'
          Value = 'S'
        end
        item
          Caption = 'Pedir o c'#243'digo do separador e j'#225' definir o mesmo para o pedido'
          Value = 'C'
        end
        item
          Caption = 'N'#227'o solicitar o separador'
          Value = 'N'
        end>
    end
    object rdgCondSugDV: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = #192' Vista'
          Value = '1'
        end
        item
          Caption = 'Condi'#231#227'o de Pagamento do Cliente'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgProcCortePedido: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Gravar Vendas Perdidas (Itens Cortados)'
          Value = '1'
        end
        item
          Caption = 'Gravar Novo Pedido (Itens Cortados)'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgIndContaDebito: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = '1 - Convenente'
          Value = '1'
        end
        item
          Caption = '2 - Contribuinte'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcTravaRemota: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Individual, a cada trava ocorrida'
          Value = '1'
        end
        item
          Caption = 'Coletiva, na Finaliza'#231#227'o da venda'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgNfeImpAvi: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Vencimento da Duplicata'
          Value = 'V'
        end
        item
          Caption = 'Palavra "A VISTA"'
          Value = 'P'
        end>
      Properties.WordWrap = True
    end
    object rdgAnaSin_A_S: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'ANAL'#205'TICO'
          Value = 'A'
        end
        item
          Caption = 'SINT'#201'TICO'
          Value = 'S'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcValorQuantidade: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Valor'
          Value = 'V'
        end
        item
          Caption = 'Quantidade'
          Value = 'Q'
        end>
      Properties.WordWrap = True
    end
    object rdgTipConfMer: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pr'#233'-Nota'
          Value = '1'
        end
        item
          Caption = 'Pedido de Compra'
          Value = '2'
        end
        item
          Caption = 
            'Senha principal com pr'#233'-nota e senha auxiliar com pedido de comp' +
            'ra '
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgIniFin_I_F: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'In'#237'cio'
          Value = 'I'
        end
        item
          Caption = 'Final'
          Value = 'F'
        end>
      Properties.WordWrap = True
    end
    object rdgPesLiq: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Fator para c'#225'lculo do peso l'#237'quido'
          Value = 'FATOR'
        end
        item
          Caption = 'Soma dos pesos l'#237'quido dos produtos'
          Value = 'SOMA'
        end>
      Properties.WordWrap = True
    end
    object spnValInt: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.ValueType = vtInt
    end
    object spnQtdPri: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 999.000000000000000000
      Properties.ValueType = vtInt
    end
    object edtSenha: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.EchoMode = eemPassword
      Properties.LookupItems.Strings = (
        '')
      Properties.MaxLength = 10
      Properties.PasswordChar = '*'
      Properties.ReadOnly = False
    end
    object edtTexto: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object rdgTamFol_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Meia Folha'
          Value = '1'
        end
        item
          Caption = 'Folha Inteira'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdbCarBol_1_a_5: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Solicitar na impress'#227'o'
          Value = ''
        end
        item
          Caption = 'Carteira 1'
          Value = '1'
        end
        item
          Caption = 'Carteira 2'
          Value = '2'
        end
        item
          Caption = 'Carteira 3'
          Value = '3'
        end
        item
          Caption = 'Carteira 4'
          Value = '4'
        end
        item
          Caption = 'Carteira 5'
          Value = '5'
        end>
      Properties.WordWrap = True
    end
    object rdbModImp_1_a_4: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = '40c'
          Value = 1
        end
        item
          Caption = '80c'
          Value = '2'
        end
        item
          Caption = '30c'
          Value = '3'
        end
        item
          Caption = '40cS'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgQtdPro: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'N'#227'o utilizar'
          Value = '1'
        end
        item
          Caption = 'Utilizar apenas um'
          Value = '2'
        end
        item
          Caption = 'Utilizar mais de um'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgTipSen_F_V_U: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Fixa'
          Value = 'F'
        end
        item
          Caption = 'Variavel'
          Value = 'V'
        end
        item
          Caption = 'Usu'#225'rio'
          Value = 'U'
        end>
      Properties.WordWrap = True
    end
    object rdgTipSenPadrao_V_U: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Variavel'
          Value = 'V'
        end
        item
          Caption = 'Usu'#225'rio'
          Value = 'U'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcComMecan: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pelo cadastro de Operadores'
          Value = 'CO'
        end
        item
          Caption = 'Pelo cadastro de Produtos/Servi'#231'os'
          Value = 'CPS'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcComVen: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pelo cadastro de Operadores'
          Value = 'CO'
        end
        item
          Caption = 'Pelo cadastro de Produtos/Servi'#231'os'
          Value = 'CPS'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcAcoServ: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pedido de venda (PD)'
          Value = '1'
        end
        item
          Caption = 'Documento de Venda (NF/NS/MI/FF)'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcComVend: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Vendedor'
          Value = 'V'
        end
        item
          Caption = 'Produto'
          Value = 'P'
        end
        item
          Caption = 'Fornecedor'
          Value = 'F'
        end
        item
          Caption = 
            'Margem ( Faixa de comiss'#227'o cadastrada ), inclusive para produtos' +
            ' em promo'#231#227'o'
          Value = 'M'
        end
        item
          Caption = 'Desconto Geral'
          Value = 'G'
        end
        item
          Caption = 'Faixa de Desconto por Vendedor (Cad.Operadores)'
          Value = 'D'
        end
        item
          Caption = 'Desc. por Comiss'#227'o do Cad. Produtos'
          Value = 'C'
        end
        item
          Caption = 'Percentual por Tabela de Pre'#231'o'
          Value = 'T'
        end
        item
          Caption = 'Regi'#227'o/ Tinta de M'#225'quina/ Demais Produtos'
          Value = 'R'
        end
        item
          Caption = 'Proporcional ao Lucro sobre Margem Bruta'
          Value = 'L'
        end
        item
          Caption = 'Condi'#231#227'o de Pagamento'
          Value = 'O'
        end
        item
          Caption = 'Cliente/Vendedor'
          Value = 'CV'
        end
        item
          Caption = 'Faixa de Desconto por Departamento'
          Value = 'FD'
        end
        item
          Caption = 'Produto, Submetida a Faixas de Desconto'
          Value = 'PD'
        end
        item
          Caption = 'Produto, Proporcional ao Desconto/Acr'#233'scimo'
          Value = 'PP'
        end
        item
          Caption = 'Faixa de Margem por Vendedor (Cad.Operadores)'
          Value = 'MV'
        end
        item
          Caption = 
            'Margem ( Faixa de comiss'#227'o cadastrada ), considerando comiss'#227'o d' +
            'a promo'#231#227'o para produtos nesta situa'#231#227'o'
          Value = 'MP'
        end
        item
          Caption = 
            'Op'#231#227'o de Comissao: ( PRODUTO / LINHA e GRUPO / FORNECEDOR / VEND' +
            'EDOR ).'
          Value = 'SH'
        end
        item
          Caption = 'Proporcional ao Lucro sobre Margem Liquida'
          Value = 'ML'
        end
        item
          Caption = 'Tipo de Atividade'
          Value = 'TA'
        end>
    end
    object rdgTipExp_1_2_3_4_5: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'N'#227'o utilizar expedi'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Faturamento antes da expedi'#231#227'o'
          Value = '2'
        end
        item
          Caption = 'Faturamento depois da expedi'#231#227'o'
          Value = '3'
        end
        item
          Caption = 'Pedido (O pedido n'#227'o ser'#225' faturado)'
          Value = '4'
        end
        item
          Caption = 'Expedi'#231#227'o por Romaneio (O Pedido n'#227'o ser'#225' faturado)'
          Value = '5'
        end>
      Properties.WordWrap = True
    end
    object rdgTipMovIteExp: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Somente itens de Retira'
          Value = 'R'
        end
        item
          Caption = 'Somente Itens de Entrega Imediata'
          Value = 'E'
        end
        item
          Caption = 'Todos os Itens'
          Value = 'T'
        end>
      Properties.WordWrap = True
    end
    object rdgTipMovIteSepPD_OR_VN: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Somente itens de Retira'
          Value = 'R'
        end
        item
          Caption = 'Somente Itens de Entrega Imediata'
          Value = 'E'
        end
        item
          Caption = 'Somente Itens de Entrega Futura'
          Value = 'F'
        end
        item
          Caption = 'Todos os Itens'
          Value = 'T'
        end>
      Properties.WordWrap = True
    end
    object rdgConProd_1_2: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Mostrar somente tabela do cliente.'
          Value = '1'
        end
        item
          Caption = 'Mostrar todas as tabelas dispon'#237'veis.'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcNum_1_a_4: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end
        item
          Caption = 'Tr'#234's'
          Value = '3'
        end
        item
          Caption = 'Quatro'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcNum_1_a_7: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end
        item
          Caption = 'Tr'#234's'
          Value = '3'
        end
        item
          Caption = 'Quatro'
          Value = '4'
        end
        item
          Caption = 'Cinco'
          Value = '5'
        end
        item
          Caption = 'Seis'
          Value = '6'
        end
        item
          Caption = 'Sete'
          Value = '7'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcNum_1_a_7_Vazia: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Nenhuma'
          Value = ''
        end
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end
        item
          Caption = 'Tr'#234's'
          Value = '3'
        end
        item
          Caption = 'Quatro'
          Value = '4'
        end
        item
          Caption = 'Cinco'
          Value = '5'
        end
        item
          Caption = 'Seis'
          Value = '6'
        end
        item
          Caption = 'Sete'
          Value = '7'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcDecImp: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end
        item
          Caption = 'Tr'#234's'
          Value = '3'
        end
        item
          Caption = 'Quatro'
          Value = '4'
        end
        item
          Caption = 'Cinco'
          Value = '5'
        end
        item
          Caption = 'Seis'
          Value = '6'
        end
        item
          Caption = 'Sete'
          Value = '7'
        end
        item
          Caption = 'Oito'
          Value = '8'
        end
        item
          Caption = 'Nove'
          Value = '9'
        end>
      Properties.WordWrap = True
    end
    object rdgTipDta_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Data de Emiss'#227'o '
          Value = '1'
        end
        item
          Caption = 'Data de Confirma'#231#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgPasCai_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 
            'Primeiro receber e liberar pelo caixa [ ALT+L ], depois expedir ' +
            'o documento pela expedi'#231#227'o.'
          Value = '1'
        end
        item
          Caption = 
            'Primeiro faturar pela expedi'#231#227'o, depois realizar o recebimento p' +
            'elo caixa [ F2 ] Recebimento.'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgComFF_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Data de Emiss'#227'o'
          Value = '1'
        end
        item
          Caption = 'Data de Confirma'#231#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTipCon_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Partial Key'
          Value = '1'
        end
        item
          Caption = 'Complete Key'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgAtiIna_A_I: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Ativo'
          Value = 'A'
        end
        item
          Caption = 'Inativo'
          Value = 'I'
        end>
      Properties.WordWrap = True
    end
    object edtCodSeq_Tam_6: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 6
      Properties.OnValidate = edtCodSeq_Tam_6PropertiesValidate
    end
    object cmbItePre: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'COM'
        'CUS'
        'VE1'
        'VE2'
        'VE3'
        'VE4'
        'VE5'
        'VE6'
        'VE7'
        'MED')
    end
    object cmbModBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'FILIZOLA'
        'LUCASTEC'
        'MAGNA'
        'MICHELETTI'
        'NENHUMA'
        'TOLEDO'
        'TOLEDO 2180'
        'URANO')
    end
    object cmbpCoBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'COM13'
        'COM14'
        'COM15'
        'COM16')
    end
    object cmbRatBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600')
    end
    object cmbBitBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '5'
        '6'
        '7'
        '8')
    end
    object cmbParBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'EVEN'
        'MARK'
        'NONE'
        'ODD'
        'SPACE')
    end
    object cmbStoBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'S1'
        'S1,5'
        'S2')
    end
    object cmbHanBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'DTR/DSR'
        'NENHUM'
        'RTS/CTS'
        'XON/XOFF')
    end
    object cmbDigBal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9')
    end
    object cmbOpcSal: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'SALDOS'
        'SALBAL')
    end
    object rdgTipPre_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgCodBar_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'N'#227'o gerar autom'#225'tico '
          Value = '1'
        end
        item
          Caption = 'Gerar autom'#225'tico'
          Value = '2'
        end
        item
          Caption = 'Perguntar se deseja gerar autom'#225'tico'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object mskEspImp: TcxEditRepositoryMaskItem
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        'll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll;0' +
        ';_'
    end
    object rdgTipRel_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Completo'
          Value = '1'
        end
        item
          Caption = 'Resumido'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object chkTabPre_1_a_7: TcxEditRepositoryCheckGroupItem
      Properties.Columns = 3
      Properties.EditValueFormat = cvfStatesString
      Properties.GlyphCount = 7
      Properties.Items = <
        item
          Caption = 'Tabela-1'
        end
        item
          Caption = 'Tabela-2'
        end
        item
          Caption = 'Tabela-3'
        end
        item
          Caption = 'Tabela-4'
        end
        item
          Caption = 'Tabela-5'
        end
        item
          Caption = 'Tabela-6'
        end
        item
          Caption = 'Tabela-7'
        end>
      Properties.WordWrap = True
      Properties.OnEditValueToStates = chkTabPre_1_a_7PropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkTabPre_1_a_7PropertiesStatesToEditValue
    end
    object rdgDtaAgru_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Original da Duplicata Agrupada'
          Value = '1'
        end
        item
          Caption = 'Hoje'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgVerCPF_A_T_N: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Avisa'
          Value = 'A'
        end
        item
          Caption = 'Trava'
          Value = 'T'
        end
        item
          Caption = 'N'#227'o avisa'
          Value = 'N'
        end>
      Properties.WordWrap = True
    end
    object rdgSugPre_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de compra'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de compra c/ desconto rateado'
          Value = '2'
        end
        item
          Caption = 'Pre'#231'o de custo'
          Value = '3'
        end
        item
          Caption = 'Pre'#231'o de compra c/ desconto rateado + Acr'#233'sc. Financeiro'
          Value = '4'
        end
        item
          Caption = 'Em branco'
          Value = '5'
        end
        item
          Caption = 
            'Pre'#231'o de Compra Bruto com os descontos na coluna de desconto por' +
            ' item'
          Value = '7'
        end
        item
          Caption = 'Pre'#231'o de '#250'ltima compra'
          Value = '8'
        end>
      Properties.WordWrap = True
    end
    object rdgModChq_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object mskClaFis: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.LookupItems.Strings = (
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-'
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-'
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-'
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999;0;_')
      Properties.EditMask = 
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
        '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
        '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
        '99-9999;0;_'
    end
    object mskConPag: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.LookupItems.Strings = (
        '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_')
      Properties.EditMask = '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_'
    end
    object rdgOpcAtu_P_M: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Venda'
          Value = 'P'
        end
        item
          Caption = 'Margem Bruta'
          Value = 'M'
        end>
      Properties.WordWrap = True
    end
    object rdgTipPre2_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Unit'#225'rio de Compra'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTipImp_J_M: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Jato de Tinta'
          Value = 'J'
        end
        item
          Caption = 'Matricial'
          Value = 'M'
        end>
      Properties.WordWrap = True
    end
    object rdgTipTin_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Tipo-1'
          Value = '1'
        end
        item
          Caption = 'Tipo-2'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object dtaData: TcxEditRepositoryDateItem
      Properties.ShowTime = False
    end
    object cmbPreAju: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'PREVE1'
        'PREVE2'
        'PREVE3'
        'PREVE4'
        'PREVE5'
        'PREVE6'
        'PREVE7'
        'CLIENTE')
    end
    object cmbPreAjuR: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'VE1'
        'VE2'
        'VE3'
        'VE4'
        'VE5'
        'VE6'
        'VE7'
        'CUS'
        'CUR')
    end
    object cmbPreConfAju: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        'PREVE1'
        'PREVE2'
        'PREVE3'
        'PREVE4'
        'PREVE5'
        'PREVE6'
        'PREVE7'
        'PRECUS'
        'PREMED')
    end
    object rdgOpcTra_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Traval'
          Value = '1'
        end
        item
          Caption = 'Desconto M'#225'ximo '
          Value = '2'
        end
        item
          Caption = 'Margem M'#237'nima por produto'
          Value = '3'
        end
        item
          Caption = 'Margem M'#237'nima por documento'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgMarMinProd: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Margem Bruta'
          Value = 'B'
        end
        item
          Caption = 'Margem L'#237'quida'
          Value = 'L'
        end>
      Properties.WordWrap = True
    end
    object rdgTraVen_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Travar item a item'
          Value = '1'
        end
        item
          Caption = 'Travar no final da venda'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object mskClaFis_L1: TcxEditRepositoryMaskItem
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 'aa-aa-aa-aa-aa-aa-aa-aa-aa-aa-aa-aa;0;_'
    end
    object rdgOpcCfop_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Natureza da Opera'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Descri'#231#227'o'
          Value = '2'
        end>
    end
    object rdgTipFor_A_C: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Avulso'
          Value = 'A'
        end
        item
          Caption = 'Cont'#237'nuo'
          Value = 'C'
        end>
    end
    object edtTexto_Tam3: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
    end
    object edtTexto_Tam20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
      Properties.ValidateOnEnter = True
      Properties.OnValidate = edtTexto_Tam20PropertiesValidate
    end
    object cmbSujPre: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'PRECOM'
        'PRECUS'
        'PREVEN ')
    end
    object rdgOpcRom_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Pedido de Venda'
          Value = '1'
        end
        item
          Caption = 'NF, IF, FF, DL, D1'
          Value = '2'
        end
        item
          Caption = 'NF'
          Value = '3'
        end
        item
          Caption = 'NF, IF, FF, D1 (Inclusive confirmados)'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgTipImp_M_L: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Matricial'
          Value = 'M'
        end
        item
          Caption = 'Laser'
          Value = 'L'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcNum_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgLanBan_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Liberado'
          Value = '1'
        end
        item
          Caption = 'Liberado com senha'
          Value = '2'
        end
        item
          Caption = 'N'#227'o liberado'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgTipImp_M_L_Z_A: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Matricial'
          Value = 'M'
        end
        item
          Caption = 'Laser'
          Value = 'L'
        end
        item
          Caption = 'Zebra'
          Value = 'Z'
        end
        item
          Caption = 'Argox'
          Value = 'A'
        end
        item
          Caption = 'Selecionar no ato da impress'#227'o'
          Value = ''
        end>
      Properties.WordWrap = True
    end
    object rdgTipGar_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'NF / IF'
          Value = '1'
        end
        item
          Caption = 'Todas Esp'#233'cies'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTipAge_1_a_4: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'C'#237'clico com dia de in'#237'cio de ciclo'
          Value = '1'
        end
        item
          Caption = 'C'#237'clico cont'#237'nuo'
          Value = '2'
        end
        item
          Caption = 'Manual'
          Value = '3'
        end
        item
          Caption = 'Autom'#225'tico'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgEmpGer_1_2: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Empresa que est'#225' agrupando'
          Value = '1'
        end
        item
          Caption = 'Empresa das duplicatas selecionadas'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object cmbCor: TcxEditRepositoryColorComboBox
      Properties.CharCase = ecUpperCase
      Properties.CustomColors = <>
      Properties.DefaultDescription = 'Selecione a cor desejada'
    end
    object edtCodSeq_Tam_10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
      Properties.OnValidate = edtCodSeq_Tam_10PropertiesValidate
    end
    object btnPatEnd: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ImeMode = imOpen
      Properties.ImeName = 'Enderecoooo'
      Properties.LookupItems.Strings = (
        'tretertertertre')
    end
    object btnCfgLocFis: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para configurar'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsOnly
    end
    object rdgTipCon: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Antes da Entrada de Mercadorias'
          Value = 'A'
        end
        item
          Caption = 'Depois da Entrada de Mercadorias'
          Value = 'D'
        end>
    end
    object btnPatImg: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D362400000000000036000000280000003000000030000000010020000000
            000000000000C40E0000C40E00000000000000000000FFFFFF00FAFAFAFFFEFE
            FEFFFFFFFF00FFFFFF00FCFCFCFFFFFFFF00FEFEFEFFFAFAFAFFF6F6F6FFF7F7
            F7FFF2F2F2FFF7F7F7FFF9F9F9FFF3F3F3FFF6F6F6FFFBF5FAFFF6F3F5FFF8FA
            FAFFF1F7F2FFF4F8F3FFF6F8F2FFFBF6F3FFFEF9F6FFFCF6F7FFF7F7F7FFF2F5
            F9FFF1F8FBFFF0F5F8FFF1F4F8FFFEF9FBFFF8F5F7FFF2F6F7FFF0F5F6FFF5F7
            F8FFF2F4F5FFF0F8F7FFEEF9F7FFEAF8F4FFEEF7F4FFFFFFFEFFFFFFFEFFFFFD
            FEFFFFFFFF00F4F6F7FFFDFFFFFFFFFDFFFFFFFCFFFFFCFCFCFFFFFFFF00FEFE
            FEFFFFFFFF00F2F2F2FFFFFFFF00F4F4F4FF707070FF3C3C3CFF434343FF4646
            46FF3F3F3FFF3F3F3FFF424242FF3F3F3FFF424242FF443F41FF403D3FFF3A3C
            3CFF3D4240FF414540FF3D3F39FF443F3CFF413C3BFF454041FF3B3B3BFF3A3E
            3FFF3B4043FF3A3E3FFF3D3C3EFF423C3DFF464041FF434141FF3E3E3EFF4641
            42FF454343FF393E3DFF333C39FF404B48FF414845FF828381FFFFFDFCFFFFFE
            FFFFFEFCFCFFFDFFFFFFFCFEFFFFFFFAFFFFFFFDFFFFFDFDFDFFFFFFFF00FBFB
            FBFFFDFDFDFFFFFFFF00FFFFFF00989898FF4C4C4CFFA6A6A6FFB9B9B9FFC0C0
            C0FFBEBEBEFFC0C0C0FFC3C3C3FFC1C1C1FFC2C2C2FFC7C2C4FFC4C1C3FFBEC0
            C0FFC0C5C3FFBFC3BEFFBFC0BCFFCAC6C5FFCBC6C5FFC6C1C2FFC3C3C3FFC2C6
            C7FFBCC0C1FFBDBFBFFFCAC6C5FFCFC3C1FFD0C1BFFFCEC2C0FFCCC0BEFFCCBF
            BDFFC7BEBBFFC5C2BEFFC5C8C6FFBCC3C0FF868B89FF454343FFE1DCDDFFFFFA
            FBFFFFFFFF00FBFFFFFFF5FAF9FFFFFEFFFFFFFEFFFFFFFFFF00FBFBFBFFFFFF
            FF00F7F7F7FFFFFFFF00FFFFFF00707070FF686868FFE5E5E5FFF3F3F3FFE8E8
            E8FFE8E8E8FFEAEAEAFFEBEBEBFFE9E9E9FFE9E9E9FFEFEAECFFE7E5E5FFEAEC
            ECFFE0E5E3FFE1E4E2FFECEDEBFFEBE7E6FFE4DFE0FFEBE9E9FFEAEAEAFFE0E2
            E2FFE6E8E8FFEEEBE7FFECE3DFFFFAE7E2FFFFE7E1FFFFE8E2FFFDE5DFFFFFF0
            EAFFFFEEE9FFF0E5E1FFE8E5E1FFE7EAE8FFDADDDBFF575253FFC4BFC0FFFDFB
            FBFFFFFFFF00F8FDFCFFFBFFFFFFFFFFFF00FFFEFFFFFFFFFF00FCFCFCFFFFFF
            FF00FFFFFF00FAFAFAFFFFFFFF00787878FF6A6A6AFFE9E9E9FFE1E1E1FFB2B2
            B2FFA9A9A9FFA9A9A9FFA6A6A6FFA6A6A6FFA8A8A8FFA6A1A2FFBAB8B8FFEBED
            EDFFC1C6C5FFA0A5A4FFA5A7A7FFA5A3A3FFB3AEB0FFA4A1A3FFA9A7A7FFA9A9
            A9FFE8E7E3FFF1E9E2FFB7A89FFFB79C92FFBA9A8FFFBE9B8EFFB28F82FFBB97
            8DFFB7988FFFC8B6AFFFEDE4E0FFE7E6E2FFEAEBE9FF565152FFC4BFC1FFFFFE
            FFFFFBFDFEFFF7FDFCFFFAFFFFFFF8F8F8FFFFFFFEFFFEFEFEFFFFFFFF00F9F9
            F9FFFFFFFF00FFFFFF00FDFDFDFF707070FF696969FFF1F1F1FFE0E0E0FF9D9D
            9DFF959595FF979797FF949494FF959595FF979797FF9A9596FFA6A4A4FFE5E7
            E7FFAAAFAEFF909594FF9B9D9EFF939092FF969395FF999698FF9B989AFF918F
            8EFFDEDAD5FFE8DED4FFA08A7EFFA78677FFB08876FFB08473FFB88A79FFBD90
            82FFA37D71FFB49B91FFF7EBE5FFE4DFDCFFDBD9D8FF524D4EFFC8C3C5FFFFFE
            FFFFFCFEFFFFFAFFFFFFFAFFFEFFFBFCFAFFFFFFFCFFFDFDFDFFFEFEFEFFFFFF
            FF00FFFFFF00F4F4F4FFFFFFFF00787878FF656565FFE8E8E8FFE0E0E0FF9B9B
            9BFF969696FF9A9A9AFF999999FF9B9B9BFF9A9A9AFF9C9897FFA7A5A4FFEAEC
            ECFFA8ADACFF919596FF97999AFF99989CFF9E9A9FFF9A969BFF9F9C9EFF9593
            92FFE0DAD3FFEFDFD3FFA98F7FFFAF8774FFB98773FFC18D76FFB9846FFFB684
            70FFB08576FFB2968BFFF6E6DFFFE6E2DDFFE7E5E4FF5A5556FFC2BFC1FFFBFA
            FCFFFBFFFFFFFAFFFFFFF7FEFBFFFFFFFCFFFFFFFAFFFEFEFEFFFFFFFF00FAFA
            FAFFFFFFFF00FFFFFF00FFFFFF00727272FF6C6C6CFFE8E8E8FFE7E7E7FFA0A0
            A0FF979797FF959595FF959595FF999999FF979797FF9B9998FFA6A4A3FFE7E9
            E9FFA8ADACFF989C9DFF949599FF9B999FFF979399FF9B9A9EFF979698FF9692
            91FFE3DBD4FFF5E2D5FFAF8F7CFFB0836EFFC48E75FFC28B70FFC18A6FFFBC88
            71FFBC917EFFB09385FFF5E6DDFFECE8E3FFDEDFDDFF514F4FFFC4C1C3FFFFFE
            FFFFF8FDFCFFF9FFFEFFFBFFFCFFFFFFFBFFFFFFFAFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEEEEEEFFDEDEDEFF9F9F
            9FFF979797FF929292FF949494FF9A9A9AFF939393FF959392FFA6A4A3FFE4E6
            E6FFAAACACFF9A9C9DFF98999DFF918F95FF9B979DFF98979BFF949395FF9895
            91FFE3DAD1FFF7E2D3FFAF8E7AFFB8866FFFC2896FFFC38C6DFFC18B6CFFBD8A
            70FFB28772FFB39989FFF5E7DBFFEBE8E0FFE0E1DFFF535254FFC1C0C4FFFDFF
            FFFFFBFFFFFFFAFFFFFFFBFFFCFFFFFFFCFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE8E8E8FFE3E3E3FFC2C2
            C2FFBABABAFFBABABAFFB8B8B8FFBABABAFFBBBBBBFFBEBCBBFFCECFCDFFE7E7
            E7FFD0D2D2FFB4B6B7FFB1B0B4FFB6B2B8FFBFBBC1FFB6B5B9FFB7B6B8FFC5C4
            C0FFECE5DCFFFBE7D6FFB28F7BFFBC8871FFC2886BFFC38D6CFFC08D6CFFBE8C
            70FFB28972FFB39988FFF2E6DAFFE9E7DFFFDDE0DEFF535254FFC1C0C4FFFDFF
            FFFFFDFFFFFFFBFFFFFFFDFFFCFFFFFFFCFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE6E6E6FFEBEBEBFFE2E2
            E2FFE1E1E1FFEAEAEAFFE4E4E4FFDEDEDEFFDEDEDEFFE1DFDEFFE1E2E0FFE7E7
            E7FFE4E6E6FFE1E0E2FFE9E8ECFFE8E4EAFFDFDBE1FFE8E7EBFFDFDEE0FFDEDD
            D9FFEFE8DFFFF1DCCDFFAE8B77FFBB8770FFCB9076FFC18B6CFFBD8C6CFFBD8D
            71FFB08A72FFB29A88FFF0E7DAFFE7E8DFFFDDE1DCFF535353FFC1C0C2FFFDFF
            FFFFFDFFFFFFFBFFFFFFFDFFFCFFFFFFFCFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFECECECFFDEDEDEFFA7A7
            A7FF949494FF949494FF959595FF999999FF9F9F9FFF9F9D9CFFB0B1AFFFEAEA
            EAFFB5B5B5FF99989AFF989597FF9B959AFFA09CA1FF97969AFF97999AFFA2A3
            9FFFE9E4DBFFF5E2D3FFB59481FFB6816CFFC58971FFC08A6CFFBD8C6CFFBB8C
            71FFB08A72FFB29A88FFF0E7D9FFE8E9E0FFDFE3DEFF535353FFC1C0C2FFFFFE
            FFFFFDFFFFFFFBFFFFFFFDFFFEFFFFFFFCFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE9E9E9FFE4E4E4FF9B9B
            9BFF9A9A9AFF979797FF979797FF989898FF959595FF929292FFA0A0A0FFEFEF
            EFFFABABABFF9A9898FFA09B9DFF9A9597FF9B9698FF989799FF949696FF8A8E
            89FFE1DFD5FFF1E0D3FFAD8C7CFFB68271FFC38973FFC18A6FFFBD8B6DFFBC8A
            73FFAF8872FFB19987FFF2E7D9FFEAE8E0FFE1E2DEFF535452FFC1C1C1FFFFFE
            FFFFFDFFFFFFFBFFFFFFFDFFFEFFFFFFFEFFFFFFFCFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE8E8E8FFEBEBEBFF9898
            98FF9D9D9DFF979797FF979797FF9A9A9AFF989898FF979797FFA7A7A7FFE9E9
            E9FFB3B1B1FF999495FF9A9596FF9D9699FF9C9799FF9B9A9CFF9C9E9EFF9296
            91FFDDDBD3FFF3E3D7FFA68778FFBD8A7AFFBF8671FFC38B72FFBF8970FFBB89
            73FFB18774FFB29888FFF4E6DAFFEAE8DEFFE1E1DBFF555352FFC3C1C1FFFFFE
            FFFFFDFFFFFFFBFFFFFFFBFFFFFFFFFFFEFFFFFFFEFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE7E7E7FFE7E7E7FF9999
            99FF979797FF959595FF969696FF989898FF9B9B9BFF959797FFA5A7A7FFE1E1
            E1FFB4B2B2FF989394FF9A9495FFA1999AFF9D9798FF939393FF949795FF8E94
            8FFFDAD8D0FFEEE0D4FFA88B7DFFBB8A7CFFC28875FFC18872FFBF8670FFBB86
            72FFB28675FFB79A8BFFF9E9DDFFECE7DEFFE2DFDAFF575352FFC5C1C0FFFFFF
            FF00FDFFFFFFFAFFFFFFFBFFFFFFFFFFFEFFFFFFFEFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEAEAEAFFE3E3E3FF9E9E
            9EFF939393FF989898FF989898FF939393FF969696FF929495FFA3A2A4FFEEEC
            EBFFB4B1ADFF999493FF9C9796FF9C9798FF949395FF969899FF939896FF9094
            8EFFE4E2DAFFE9E0D7FFA6938CFF9B7C79FFA9837FFFAB8279FFAA8276FFA783
            7BFFA2857EFFB09B93FFF7EBE1FFF2E9E0FFE3DFDAFF555353FFC1C0C4FFFBFF
            FFFFFBFFFFFFFBFFFEFFFDFFFCFFFFFFFEFFFFFFFEFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE8E8E8FFE7E7E7FFD5D5
            D5FFD1D1D1FFCDCDCDFFCDCDCDFFCDCDCDFFCFCED0FFCCCCD2FFD9D5DAFFE9E2
            DFFFEBE4DBFFD3CDC6FFD3D0CBFFC5CACBFFCAD3D7FFC4CDD0FFCAD0CFFFD5D6
            CDFFE7E6DCFFE9E6E2FFDEDCE2FFDADCEEFFD6D7EBFFDFD9E4FFDFDAE3FFD6D9
            E7FFD7DCE5FFE4E4E4FFEBE5DEFFEEE3DBFFECE3DFFF515059FFB8BEC9FFF4FD
            FFFFF6FFFFFFFDFFF9FFFFFFF7FFFFFFFBFFFFFFFCFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE5E5E5FFECECECFFD5D5
            D5FFDBDBDBFFDADADAFFDBDBDBFFDADADAFFDCDBDDFFD8D8DEFFE3DFE4FFEDE7
            E2FFEEE7DEFFE0DAD3FFD8D9D5FFD4DDE0FFC7D2D6FFD2DBDEFFD2D7D5FFE2E0
            D8FFE8E7E3FFDDE4EDFFC2D5F0FFA1C2F3FF9AC3FAFFA5C9F9FF9DC4F1FF97C3
            F2FFA2C9EFFFBFD7EBFFE2EBEFFFEBE4E1FFE8DEDEFF4F505AFFB6BECBFFF4FD
            FFFFF8FFFFFFFFFFF7FFFFFFF5FFFFFFFBFFFFFFFEFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEAEAEAFFE1E1E1FFA0A0
            A0FF979797FF929292FF949494FF949494FF959595FF929495FFAAAAAAFFE7E4
            E0FFB7B4B0FF949291FF969899FF92989FFF949A9FFF969898FF969591FF9996
            91FFD5DBE0FFC6DCF8FF638FC5FF3A7DD2FF2F81E6FF287EE2FF257EE0FF2B83
            E1FF3B86D4FF6DA0D2FFC2E0F9FFE0E5EEFFDFDCDEFF51505AFFBDBEC8FFFDFE
            FFFFFFFFFCFFFFFFF5FFFFFFF5FFFFFFFCFFFFFEFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE9E9E9FFE3E3E3FF9B9B
            9BFF9A9A9AFF989898FF9B9B9BFF989898FF969696FF979999FF9FA2A0FFF3F1
            F0FFB0AEADFF909293FF999CA1FF8C8F97FF929298FF989493FFA7A39EFF9390
            8CFFCCD5E2FFB5D8FFFF4887D1FF2984F1FF0C79F9FF0879FFFF0377FAFF0E7D
            F7FF1D7DE1FF4E92D5FFB6DDFFFFDAE4F5FFE1DFE5FF535059FFC1BFC5FFFFFF
            FF00FFFFFBFFFFFFF7FFFFFFF8FFFFFDFFFFFDFCFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE9E9E9FFE4E4E4FF9C9C
            9CFF989898FF949494FF989898FF9A9A9AFF9E9E9EFF969997FFA1A4A2FFE5E6
            E4FFB2B2B2FF97989CFF8D9095FF9998A1FF9F9BA0FFA29996FF9E9591FF9893
            94FFC9D7E9FFAED9FFFF3E87DBFF0B73EAFF0177FFFF047BFFFF0071FFFF087A
            FDFF2082EEFF5397E0FFB3D9FFFFD4DEF0FFE4E0E6FF555157FFC1C0C4FFFDFF
            FFFFFDFFFCFFFFFFFBFFFBFFFFFFF3FCFFFFEFFBFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFECECECFFE0E0E0FF9E9E
            9EFF989898FF989898FF9B9B9BFF969696FF909292FF939896FFA4A9A7FFE5E6
            E4FFAFB0AEFF989799FF9B9A9EFF98969CFF958F94FF9E9494FFA29B98FF9897
            99FFC2D2E3FFA8D2FFFF4A8EDBFF2281EEFF0E7BFBFF107BFFFF1279FEFF187B
            F5FF277CE0FF5C98DAFFBBDCFFFFDEE5F6FFE3DDE2FF575254FFC3C1C1FFFDFF
            FEFFFBFFFCFFFBFFFCFFF8FFFFFFF1FDFFFFECFCFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFF1F1F1FFDCDCDCFFA3A3
            A3FF959595FF949494FF9A9A9AFF9A9A9AFF979999FF8E9493FFAAAFAEFFEDEE
            EAFFB8B5B1FF979490FFA19D9CFF969395FF9F9C9EFF9E999AFF9C9A9AFF9697
            9BFFCFDCEAFFBAD9FAFF5A8CC1FF4185D2FF317EDAFF317ADCFF3A83E5FF3D84
            DFFF4582CCFF78A1D2FFC5DAF6FFE6E7F1FFE4DCDDFF585253FFC5C1C0FFFFFF
            FCFFFFFFF9FFFFFFF8FFFDFFF9FFF8FFFFFFF4FFFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE6E6E6FFEAEAEAFFDEDE
            DEFFDEDEDEFFD9D9D9FFD8D8D8FFD8D8D8FFD9DBDCFFD7DCDFFFD7DBDCFFEAE8
            E7FFE5E1DCFFE2DCD7FFDEDAD5FFDBD9D9FFD8D7D9FFD9D8DAFFD6D8D9FFD6D9
            DDFFDCE5EEFFD0E3F8FFBAD7F6FFABD4FFFFA1D0FFFFA6CEFFFFA4CCFFFFA1CD
            FFFFA9D0FCFFC4DCF8FFD7E2F0FFE5E1E6FFE9E1E1FF585253FFC3C1C1FFFFFF
            FEFFFFFFFBFFFFFFF8FFFFFFF9FFFDFFFEFFFBFFFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE8E8E8FFECECECFFC7C7
            C7FFC8C8C8FFC5C5C5FFC4C4C4FFC1C1C1FFC1C3C4FFC2C4CCFFCED1D6FFE9E7
            E7FFE0DCD7FFC6C0B9FFC5C2BAFFC4C5C3FFBFC4C3FFBCC1C2FFC0C5C6FFC7CC
            CDFFDCE1E4FFDEE4E9FFC5CED8FFB4C1D1FFB1BECEFFBCC6D0FFB2BEC8FFB2C4
            CFFFB3C5CCFFC7D3D5FFE2E7E5FFEAE5E2FFE8E1DEFF575254FFC1BFC5FFFBFE
            FFFFFBFFFFFFFFFFFF00FFFFFF00FFFDFFFFFFFDFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEBEBEBFFDFDFDFFF9B9B
            9BFF929292FF8F8F8FFF949494FF959595FF959798FF8F9199FFA2A1AAFFE7E4
            E6FFB6B3AFFF989590FFA0A09AFF939792FF919895FF919999FF8F9797FF8E93
            92FFDADDDBFFE3E1E0FF9B9796FF9A9596FF9C9897FF9C978EFF97968CFF939A
            93FF8D958EFFA9B0A9FFE3E5DFFFECE7E4FFE2DDDCFF555156FFBFBEC7FFFBFE
            FFFFFBFEFFFFFFFEFFFFFFFFFF00FFFDFFFFFFFCFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE6E6E6FFE4E4E4FF9F9F
            9FFF9E9E9EFF9A9A9AFF9A9A9AFF969696FF969597FF97969FFFA5A2ABFFEBEA
            EEFFB0B0B0FF989997FF919492FF939A97FF8C9592FF909794FF929996FF9498
            93FFD7D8D4FFE1DEDAFFA29D9CFF9C9796FF9A9594FF9B9796FF959694FF939B
            9BFF8A9696FF9FA9A9FFDAE1E4FFE1E2E6FFE4E0E5FF535157FFC1BFC5FFFDFE
            FFFFFDFFFFFFFFFFFCFFFFFFFBFFFFFFFBFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE9E9E9FFE6E6E6FF9B9B
            9BFF989898FF939393FF969696FF969696FF9A999BFF96949AFFA19FA5FFE7E6
            EAFFACADB1FF949899FF8E9493FF9BA1A0FF979E9BFF979D98FF8E948FFF9293
            8FFFDADBD7FFE3E2DEFF9E9A99FF979293FF9E999AFF9D989AFF97969AFF949B
            9EFF8D989CFF9BA5ACFFDAE2E9FFDDDFE7FFE0E0E6FF535157FFC1C0C4FFFBFF
            FFFFFBFFFFFFFDFFFCFFFFFFFCFFFFFFFBFFFFFFFBFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEBEBEBFFE2E2E2FF9B9B
            9BFF999999FF999999FF9D9D9DFF999999FF969696FF9C999BFFA3A2A4FFEDEC
            F0FFA9AAAEFF8F9296FFA1A6A9FF8F9493FF8D908EFF969793FFA2A39FFF9192
            8EFFD8D9D7FFDCDEDEFF969899FFA0A1A5FF969599FF9C959AFF9C969BFF9394
            98FF888D90FF9CA2A7FFE6EAEFFFE7E7EDFFDDDBE1FF555156FFBFC1C2FFFAFF
            FFFFF6FFFFFFF4FFFFFFF6FFFFFFFAFFFFFFFBFFFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFEBEBEBFFDFDFDFFFA9A9
            A9FF9F9F9FFF9A9A9AFF9C9C9CFF9D9D9DFF9E9E9EFF9B9998FFB4B2B1FFE7E7
            E7FFBBBDBEFF929599FF96999DFF969597FFA4A4A4FF9D9B9AFF9C9A99FF9D9D
            9DFFDEE0E0FFE3E5E5FF9EA2A3FF95999AFF9C9B9DFFA19A9DFFA29C9DFFA09E
            9EFF9FA1A2FFAFB3B4FFDFE2E6FFE5E4E8FFDFDCDEFF575253FFC3C1C1FFFBFF
            FFFFF6FFFFFFF4FFFFFFF4FFFFFFFAFFFFFFFBFEFFFFFFFFFF00FFFFFF00FEFE
            FEFFFFFFFF00FEFEFEFFFFFFFF00757575FF6A6A6AFFE7E7E7FFEAEAEAFFE4E4
            E4FFE7E7E7FFE7E7E7FFE6E6E6FFE7E7E7FFE7E8E6FFE9E9E3FFE9E9E3FFE3E4
            E0FFEAEBE9FFEAEAEAFFE9E8EAFFEFEAEBFFEBE6E7FFEEE9EBFFEAE7E9FFE8E7
            E9FFE3E5E6FFE6E8E8FFE8EBE9FFE5E7E1FFEDEDE7FFEFEBE6FFECE8E3FFE8E8
            E2FFE7EBE5FFE1E6E4FFE2E7E5FFE8E6E6FFE8E3E2FF5C534FFFCAC1BDFFFFFF
            FCFFFFFFFEFFFDFFFFFFFDFFFFFFFFFEFFFFFFFDFFFFFFFEFFFFFFFEFFFFFEFE
            FEFFFFFFFEFFFEFEFEFFFFFFFF00757476FF6A6A6AFFEBECE8FFE1E7DCFFDFE7
            D6FFDAE3CEFFD7E4CCFFD8E5CDFFD8E3CFFFD5E1CBFFD9E5C9FFDCE6C8FFDBE7
            CBFFD5E0C6FFD6DEC7FFDDE5CEFFD9DFC8FFDEE3CEFFDADECBFFE0E6D3FFD8E0
            CFFFD5DFCEFFD7E2CEFFD7E0CBFFDAE5CBFFD9E2C7FFD9E2C8FFDCE5CBFFD7E3
            C7FFD7E5C9FFD8E6CEFFDCE6D5FFEAEBE2FFE4E0DBFF5C534FFFCCC2BBFFFFFF
            FBFFFFFFFCFFFFFFFEFFFFFFFF00FFFCFFFFFFFBFFFFFFFCFFFFFFFEFFFFFFFE
            FDFFFFFFFCFFFFFEFDFFFFFFFF00757478FF6A6B69FFEBF2E5FFC4D3B4FF5269
            35FF415F1EFF446620FF3F631DFF3C5E21FF416225FF43621DFF45631AFF4563
            1AFF45631CFF44621BFF43611AFF44601BFF44601BFF445F1DFF435E1EFF445F
            20FF445E22FF435C22FF435C24FF435C24FF415D22FF3F5F24FF3A5C1FFF4062
            21FF3B5B1AFF435F23FF7C9164FFE8F1DCFFE0E1D8FF585350FFC6C1BEFFFFFF
            FEFFFFFFFCFFFFFFFBFFFFFFFEFFFFFBFFFFFFF9FFFFFFFCFFFFFFFEFFFFFFFE
            FDFFFFFFFBFFFFFEFDFFFFFFFF00757478FF686B69FFE9F1E0FF95A97FFF3C5C
            15FF5F8A2FFF608F2CFF5E902CFF649539FF5D8D34FF639131FF669431FF6896
            33FF6A9835FF6B9936FF6D9B38FF6F9C3BFF719E3DFF729E3FFF739F42FF759F
            47FF77A14AFF78A04EFF7AA151FF7CA355FF7CA357FF75A356FF73A253FF78A6
            54FF84AD5CFF577A30FF466129FFC8D5BDFFE2E6E1FF555352FFC3C1C1FFFFFE
            FFFFFFFFFCFFFFFFF8FFFFFFFBFFFFFDFFFFFFFBFFFFFFFEFFFFFFFEFFFFFEFF
            FBFFFFFFFBFFFFFEFDFFFFFEFFFF757379FF686A6AFFF1FAE6FF84986DFF3D5E
            13FF8EB958FF8FC052FF91C855FF9AD164FF93C95EFF96CE63FF98D065FF9BD4
            67FF9DD669FFA0D96CFFA2DB6EFFA5DE71FFA6DE73FFB1E980FFB3EA83FFB6EC
            89FFBAEF8EFFBEF294FFC2F599FFC6F99FFFC9FAA4FFCBFBADFFD1FFB3FFCBF7
            AAFFD6FFB4FF83A663FF3F5727FFCED8C8FFE6E8E9FF535256FFC1C0C4FFFFFE
            FFFFFFFFFCFFFFFFF5FFFFFFF5FFFFFFFCFFFDFFFFFFFFFFFF00FFFFFEFFFEFF
            FAFFFFFFFBFFFFFEFDFFFFFEFFFF757379FF686A6AFFEBF4E0FF899E71FF3E5E
            11FF86B34CFF8ABE48FF8DC548FF8BC449FF89C64EFF8BC852FF89CA56FF8DCC
            58FF8DCF58FF91D15AFF92D45DFF96D65FFF96D763FF9AD866FF9BDB6AFFA0DD
            6FFFA2E074FFA9E47BFFACE981FFB3ED88FFB7EF90FFBBEE96FFC7F9A5FFC2F0
            9DFFD2FCAFFF84A764FF3F592BFFD5DFD2FFDCDFE3FF515059FFC1BEC7FFFFFE
            FFFFFFFFFEFFFFFFF5FFFDFFF5FFFDFFF9FFFDFFFCFFFFFFFEFFFFFFFCFFFEFF
            FAFFFFFFFBFFFEFFFDFFFFFEFFFF757379FF686A6AFFEAF3DFFF92A878FF4464
            15FF7DAB41FF82B83CFF88C33DFF83BE37FF86C540FF82C546FF80C64AFF84C7
            4CFF85CC4EFF8ACE51FF8BD254FF90D457FF8FD559FF93D65BFF92D75EFF97D9
            62FF98DC67FF9DDE6BFF9FE170FFA6E577FFA8E67AFFABE67DFFB2EA83FFB7EA
            88FFC6F49BFF7DA458FF3C5823FFD0DCCAFFDEE1E5FF515059FFBFBEC8FFFDFC
            FFFFFDFEFFFFFDFFFBFFFDFFF9FFFDFFFEFFFBFFFFFFFFFFFCFFFFFFFCFFFEFF
            FAFFFFFFFBFFFEFFFDFFFFFEFFFF757379FF6A6B69FFE9F2DEFF889C6FFF3F5E
            13FF78A23DFF79AC33FF80B934FF81BA35FF7EBB35FF7DBE3DFF7CBF40FF7EC1
            42FF80C344FF82C544FF84C746FF86C94AFF87CA4BFF8ED152FF8FD154FF90D2
            55FF92D358FF93D35BFF95D55EFF98D763FF99D864FFA6E36DFFA8E370FFAEE6
            76FFB1E37FFF759E49FF446227FFD1DEC8FFE1E6E5FF515157FFBFBEC8FFFDFB
            FFFFFDFCFFFFFDFFFEFFFDFFFCFFFBFFFFFFFBFEFFFFFFFFFCFFFFFFFCFFFEFF
            FAFFFFFFFCFFFEFFFDFFFFFEFFFF757478FF6A6B69FFEFF7E6FF8A9C75FF405D
            18FF6B9137FF6A9729FF6B9E25FF6B9E25FF669C21FF679F22FF66A023FF66A0
            23FF66A023FF66A121FF66A121FF67A222FF67A222FF66A121FF67A124FF67A1
            24FF68A126FF68A126FF68A127FF69A12AFF6AA329FF629E22FF68A127FF6DA1
            2FFF6E9D36FF527B20FF415F1EFFD1E1C2FFD8DFD8FF515353FFC1BFC5FFFFFB
            FFFFFFFBFFFFFDFFFFFFFDFFFFFFFDFDFFFFFDFCFFFFFFFFFEFFFFFFFCFFFEFF
            FBFFFFFFFCFFFEFFFDFFFFFFFF00757476FF6A6B69FFE8EFE0FF929F7FFF4259
            22FF5C7B30FF62862CFF608927FF5D8624FF608D26FF5E8920FF5D8B20FF5F8B
            20FF5D8B20FF5F8C1EFF5C8B1DFF5F8C1EFF5D8C1EFF5F8C1EFF5D8C1EFF608C
            21FF5E8C21FF5F8A21FF5D8B21FF5F8A21FF5D8B21FF5C8D21FF5A8C20FF5786
            20FF5E872BFF4F7321FF445E22FFD5E4C5FFE0E6DBFF535450FFC1C0C2FFFFFC
            FFFFFFFCFFFFFFFFFF00FDFFFFFFFFFDFFFFFDFCFFFFFFFFFF00FEFEFEFFFEFF
            FDFFFFFFFEFFFDFEFCFFFEFEFEFF767676FF686965FFECF3E6FFB3BEA4FF4153
            2AFF38501AFF395414FF415E19FF3E5B16FF3D5B14FF3D5913FF3D5913FF3F5A
            11FF3D5A11FF3F5A11FF3D5A11FF3F5A10FF3D5B10FF405B11FF3E5C11FF405B
            11FF3E5C11FF405B12FF3E5B12FF405B12FF3E5B12FF3D5E14FF35580EFF3B5A
            15FF415C1CFF3C5519FF607243FFE8F0D9FFE3E4DAFF585950FFC8C7C3FFFFFA
            FBFFFFFDFDFFFFFFFBFFFCFEF8FFFEFCFBFFFFFFFF00FBFAFEFFFEFDFFFFFFFF
            FF00FFFFFEFFFFFFFEFFFFFFFEFF707070FF6B6C68FFE3E8DFFFEBF3E2FFC5D3
            B7FFB5C5A3FFABBD96FFA5B98FFFACBE95FFABBD94FFAEBD97FFB0BD97FFB0BD
            97FFB0BE95FFB0BE95FFB0BE95FFB0BE95FFB0BE94FFB0BE95FFB0BE94FFB0BE
            94FFB0BE94FFB0BE95FFB0BE95FFB0BE95FFAEBE95FFADBF96FFADC099FFABBD
            96FFAABC95FFB2C19BFFE1ECCCFFE2E5D6FFE0E1D8FF504E46FFC0BDB8FFFFFF
            FEFFFFFFFEFFFAFBF2FFFFFFF8FFFFFFFBFFFFFEFAFFFFFDFFFFFBFAFEFFFCFB
            FDFFFFFFFF00FFFFFEFFFDFEFCFF787977FF696A68FFE6EAE4FFE8EDE4FFDDE4
            D7FFE4EBDCFFEBF3E2FFE5EFDEFFE3EBDAFFE6EDDEFFE6EBE2FFE6EAE4FFE6EA
            E4FFE6EBE2FFE6EBE2FFE6EBE2FFE6EBE2FFE6ECE1FFE4E9E0FFE4EADFFFE4EA
            DFFFE4EADFFFE4EADFFFE4EADFFFE4EADFFFE4EADFFFE6EBE2FFDDE5DBFFE4E9
            E0FFE9EDE2FFE4E9DAFFEAEDDEFFEDECE8FFE9E5E4FF5D5A55FFC6C3BEFFFEF9
            FAFFFFFEFFFFFFFDF8FFFFFFF9FFFCFBF7FFFFFFFEFFFEFCFFFFFCFBFFFFFFFE
            FFFFFBFBFBFFFFFFFF00FEFFFDFF80817FFF4F504EFFB9BCBAFFD4D7D5FFD8DB
            D9FFD9DDD8FFCACDCBFFD6D9D7FFD1D4D2FFDADCDCFFD4D5D9FFD4D4DAFFD4D4
            DAFFD4D4DAFFD4D5D9FFD4D5D9FFD4D5D9FFD4D5D9FFD5D6DAFFD5D6DAFFD5D7
            D8FFD5D7D8FFD5D7D8FFD5D7D8FFD5D7D8FFD5D6DAFFDADAE0FFD2D1DAFFD9D6
            DFFFD8D7DBFFDDDCD8FFD2D1CDFFDFDADCFF9A9597FF3F3C38FFDCD9D5FFFFFC
            FFFFFFFDFFFFFFFEFDFFFEFDF9FFFFFEFDFFFFFFFF00FCFBFFFFFFFEFFFFFAFC
            FDFFFDFFFFFFF4F6F6FFFDFFFEFFF4F7F5FF5E615FFF3B3B3BFF424143FF4140
            42FF434244FF3D3C40FF49484AFF3C3B3DFF3D3C3EFF3E4040FF3E4040FF3E40
            40FF3E4040FF3E4040FF3E4040FF3E4040FF3E4040FF3F4141FF3F4141FF3F42
            40FF3F4240FF3F4240FF3F4240FF3F4240FF3F4141FF414044FF3A3740FF3E3B
            44FF403E44FF3D3B3AFF403E3DFF3D393EFF4B474CFF807E7EFFF6F4F4FFFFFC
            FFFFFFFCFFFFFFFDFFFFFFFDFFFFFFFDFFFFFFFEFFFFFFFEFFFFF8F7F9FFFDFF
            FFFFFDFFFFFFFDFFFFFFF7FAF8FFF9FCFAFFFAFCFCFFF1F0F2FFE2E1E3FFE4E2
            E8FFE5E3E9FFE8E7EBFFE0DFE3FFE3E2E4FFEDEDEDFFE6E6E6FFE6E7E5FFE6E6
            E6FFE6E7E5FFE6E6E6FFE6E7E5FFE6E6E6FFE6E7E5FFE6E6E6FFE6E7E5FFE6E7
            E5FFE6E7E5FFE6E7E5FFE6E7E3FFE6E7E5FFE6E7E5FFE3E3E3FFEEEDF1FFECEA
            F0FFE3E2E6FFE4E2E1FFF9F8F4FFE2DEE3FFEFEBF0FFFBF9F8FFFFFFFF00FCF7
            FFFFFFFBFFFFFFFDFFFFFFFEFFFFFCFBFDFFFFFEFFFFFDFFFFFFFBFDFDFFFDFF
            FFFFF3F5F5FFFDFFFFFFFDFFFFFFFCFEFEFFFDFFFFFFFEFDFFFFFFFEFFFFFFFD
            FFFFFBFAFEFFFFFEFFFFFFFFFF00FFFFFCFFFBFAF6FFFFFFFF00FFFFFF00FFFE
            FFFFFFFFFF00FFFEFFFFFFFFFF00FFFEFFFFFFFFFF00FFFEFFFFFFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFEFFFFFFFF00FFFFFEFFFFFFFCFFFBFFFAFFF8FA
            FAFFFDFFFEFFFFFFF9FFFCFFF6FFFFFFFF00FCFCFCFFFFFFFCFFFFFFFEFFFFFD
            FFFFFDFDFFFFF7F7F7FFFDFFFCFFFDFFFBFFF8FCF6FFFBFEFCFFFDFFFEFFFBFD
            FDFFFDFFFFFFF9FBFBFFF6F8F8FFFDFFFFFFFBFDFDFFFFFEFFFFFFFEFFFFFBF9
            FFFFFFFEFFFFFCF9FBFFFEFCFBFFFFFFFBFFFFFFFBFFFFFEFFFFFFFEFFFFFFFE
            FFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFE
            FFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFFFEFFFEFFF8FFFDFFF9FFFAFE
            F9FFFDFFFCFFFBFFF4FFFDFFF6FFFFFFFEFFFFFFFEFFFEFFFAFFFFFFFCFFF9FA
            FEFFFDFEFFFFFDFFFEFFF9FEF5FFFDFFF9FFFDFFF8FF}
          Kind = bkEllipsis
        end>
      Properties.ImeMode = imOpen
    end
    object btnOpen_ImpNfi: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Abrir (Configura'#231#245'es - Impressoras n'#227'o fiscais)'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnOpen_CupFis: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Abrir (Configura'#231#245'es - Cupom Fiscal)'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object spnIf_Dly: TcxEditRepositorySpinItem
      Properties.OnValidate = spnIf_DlyPropertiesValidate
    end
    object edtTipDes: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Valor'
          Value = '$'
        end
        item
          Caption = 'Percentual'
          Value = '%'
        end>
    end
    object edtEspSug: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Or'#231'amento'
          Value = 'OR'
        end
        item
          Caption = 'Nota Fiscal'
          Value = 'NF'
        end
        item
          Caption = 'Cupom Fiscal'
          Value = 'IF'
        end
        item
          Caption = 'A DEFINIR'
          Value = 'XX'
        end
        item
          Caption = 'Definida no pedido'
          Value = 'DP'
        end>
    end
    object edtRecRcx: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Linha'
          Value = 'L'
        end
        item
          Caption = 'Coluna'
          Value = 'C'
        end
        item
          Caption = 'Bobina'
          Value = 'B'
        end>
    end
    object edtViaPD: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 10.000000000000000000
      Properties.ValueType = vtInt
    end
    object rdgMarkup: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Margem sobre pre'#231'o de venda bruto'
          Value = '1'
        end
        item
          Caption = 'Margem sobre pre'#231'o de venda l'#237'quido'
          Value = '5'
        end
        item
          Caption = 'Markup - C'#225'lculo Novo'
          Value = '2'
        end
        item
          Caption = 'Markup - C'#225'lculo Antigo'
          Value = '3'
        end
        item
          Caption = 'Markup sobre pre'#231'o de venda l'#237'quido'
          Value = '4'
        end>
    end
    object rdgMoImOp_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '80c'
          Value = '1'
        end
        item
          Caption = '40c'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object btnOpen_Replicacao: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object edtValMaiorZero: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = ',0.00;(,0.00)'
      Properties.EditFormat = '#,##0.00'
      Properties.UseThousandSeparator = True
    end
    object rdgCtpHis: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Fornecedor'
          Value = '1'
        end
        item
          Caption = 'Hist'#243'rico do Contas a Pagar'
          Value = '2'
        end
        item
          Caption = 'Hist'#243'rico digitado'
          Value = '3'
        end>
    end
    object rdgModEmi: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.Items = <
        item
          Caption = 'MODELO 1'
          Value = '1'
        end
        item
          Caption = 'MODELO 2'
          Value = '2'
        end
        item
          Caption = 'MODELO 3'
          Value = '3'
        end
        item
          Caption = 'MODELO 4'
          Value = '4'
        end>
    end
    object rdgModOrd: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'MODELO 1'
          Value = '1'
        end
        item
          Caption = 'MODELO 2'
          Value = '2'
        end
        item
          Caption = 'MODELO 3'
          Value = '3'
        end>
    end
    object rdgTipImp_A: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Argox'
          Value = 'A'
        end>
      Properties.WordWrap = True
    end
    object rdgTipImp_M_L_A: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Matricial'
          Value = 'M'
        end
        item
          Caption = 'Laser'
          Value = 'L'
        end
        item
          Caption = 'Argox'
          Value = 'A'
        end>
      Properties.WordWrap = True
    end
    object rdgTpDcEx_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'No Pedido'
          Value = '1'
        end
        item
          Caption = 'Na Expedi'#231#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object edtValFCusto: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 1
      Properties.MaxValue = 4.000000000000000000
      Properties.MinValue = 1.000000000000000000
    end
    object edtValPer: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MaxValue = True
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#,##0.00 %;(#,##0.00 %)'
      Properties.EditFormat = '#,##0.00 %'
      Properties.UseDisplayFormatWhenEditing = True
    end
    object edtValPer4Dig: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = '#,##0.0000 %;(#,##0.0000 %)'
      Properties.EditFormat = '#,##0.0000 %'
      Properties.UseDisplayFormatWhenEditing = True
    end
    object rdgTrChCa_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Liberada, n'#227'o vinculada aos documentos'
          Value = '1'
        end
        item
          Caption = 'Vinculada aos documentos'
          Value = '2'
        end>
    end
    object rdgTipComPro_1_2_3_4: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pelo Conta Corrente de Profissionais'
          Value = '1'
        end
        item
          Caption = 'Pelo Contas a Receber'
          Value = '2'
        end
        item
          Caption = 'Por quantidade de pontos do cadastro de produtos'
          Value = '3'
        end
        item
          Caption = 
            'Manualmente no cadastro de Comiss'#227'o de Profissionais com op'#231#227'o d' +
            'e "Pontos" ou "Valor"'
          Value = '4'
        end>
      Properties.WordWrap = True
      Properties.OnEditValueChanged = rdgTipComPro_1_2_3_4PropertiesEditValueChanged
    end
    object spnInteger: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 9999.000000000000000000
      Properties.ValueType = vtInt
    end
    object rdgTxJurCndIni: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'no pre'#231'o de venda sugerido'
          Value = '1'
        end
        item
          Caption = 'no pre'#231'o de venda digitado'
          Value = '2'
        end>
    end
    object rdgTaxApl_I_A_: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Inicio'
          Value = 'I'
        end
        item
          Caption = 'Ap'#243's o Prazo'
          Value = 'A'
        end>
    end
    object rdgCpDcBa: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#250'mero da Duplicata'
          Value = '1'
        end
        item
          Caption = 'N'#250'mero do Cheque'
          Value = '2'
        end>
    end
    object rdgRelFluxoCxPrevis: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'do cadastro de previs'#245'es'
          Value = '1'
        end
        item
          Caption = 'da manuten'#231#227'o do contas a pagar'
          Value = '2'
        end>
    end
    object rdgIncItePed: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Seguir ordem alfab'#233'tica de descri'#231#227'o do produto'
          Value = '1'
        end
        item
          Caption = 'Seguir ordem de digita'#231#227'o dos produtos'
          Value = '2'
        end>
    end
    object rdgTipRomaneio: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Romaneio Completo'
          Value = '1'
        end
        item
          Caption = 'Romaneio Simplificado'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object spnMinuto: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 60.000000000000000000
      Properties.ValueType = vtInt
    end
    object spnValIntNeg: TcxEditRepositorySpinItem
      Properties.MaxValue = 9999.000000000000000000
      Properties.MinValue = -9999.000000000000000000
      Properties.ValueType = vtInt
    end
    object rdgMultVenda: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Trava'
          Value = '1'
        end
        item
          Caption = 'N'#227'o Trava'
          Value = '2'
        end
        item
          Caption = 'Somente Avisa'
          Value = '3'
        end
        item
          Caption = 'Solicita Senha'
          Value = '4'
        end>
    end
    object rdgIpPdLF: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Na Libera'#231#227'o'
          Value = 'L'
        end
        item
          Caption = 'No Faturamento'
          Value = 'F'
        end>
    end
    object rdgCupNot: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Cupom + Nota'
          Value = '1'
        end
        item
          Caption = 'Cupom + Cupom'
          Value = '2'
        end>
    end
    object rdgCalSop: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pre'#231'o Compra'
          Value = '1'
        end
        item
          Caption = #218'ltima Compra'
          Value = '2'
        end>
    end
    object rdgTCaSop: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'F'#243'rmula completa de c'#225'lculo da Substitui'#231#227'o, com pre'#231'o escolhido' +
            ' na [CFG_CALSOP], com IPI e FRETE, com aplica'#231#227'o do IVA para con' +
            'sumidor final NAO, parte positiva pela aliquota interna e parte ' +
            'negativa pela aliquota interestadual.'
          Value = '1'
        end
        item
          Caption = 
            'Pre'#231'o escolhido na [CFG_CALSOP], sem IPI e FRETE, com aplica'#231#227'o ' +
            'do IVA e somente parte positiva pela aliquota interna.'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgCliDmp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Cliente do pedido original, mantendo o pedido original e o novo ' +
            'pedido com o mesmo cliente. '
          Value = '1'
        end
        item
          Caption = 
            'Cliente da pr'#243'pria loja, mantendo o cliente no pedido original e' +
            ' a pr'#243'pria loja no novo pedido.'
          Value = '2'
        end>
    end
    object rdgTipoNFConcr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Imprimir produto acabado e simples remessa com dados do cliente ' +
            '(CONCREMASSA)'
          Value = '1'
        end
        item
          Caption = 'Imprimir sub-produtos (FIGUEIREDO)'
          Value = '2'
        end
        item
          Caption = 
            'Imprimir produto acabado e simples remessa com dados da empresa ' +
            '(PRESTCON)'
          Value = '3'
        end
        item
          Caption = 
            'Imprimir produto acabado e simples remessa com dados da empresa ' +
            '- Utiliza pedido de Venda (SECOL)'
          Value = '4'
        end>
    end
    object rdgTipIndGlo: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Igual para todas as empresas'
          Value = '1'
        end
        item
          Caption = 'Uma para cada empresa'
          Value = '2'
        end>
    end
    object btnOpen_ImpChq: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Abrir (Configura'#231#245'es - Impressora de Cheques)'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgNFeMtl: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Quantidade de Pe'#231'as'
          Value = '1'
        end
        item
          Caption = 'Metragem Total'
          Value = '2'
        end>
    end
    object rdgNFETipoItem: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'C'#243'digo de 6 d'#237'gitos'
          Value = '1'
        end
        item
          Caption = 'C'#243'digo de F'#225'brica'
          Value = '2'
        end>
    end
    object rdgImpAut: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Documento de Venda'
          Value = '1'
        end
        item
          Caption = 'Autentica'#231#227'o no Or'#231'amento/Pedido'
          Value = '2'
        end
        item
          Caption = 'Ambos'
          Value = '3'
        end>
    end
    object rdgTbpEft: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pedir tela de tipo de documento'
          Value = '1'
        end
        item
          Caption = 'Vincular esp'#233'cie do documento ao documento original'
          Value = '2'
        end>
    end
    object rdgTipFre_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Emitente'
          Value = '1'
        end
        item
          Caption = 'Destinat'#225'rio'
          Value = '2'
        end
        item
          Caption = 'Terceiros'
          Value = '3'
        end
        item
          Caption = 'Sem Frete'
          Value = '9'
        end>
    end
    object rdgTipoNFS: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Conjugada com a Nota Fiscal de Produtos'
          Value = '1'
        end
        item
          Caption = 'Separada da Nota Fiscal de Produtos'
          Value = '2'
        end>
    end
    object rdgProPre: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Promo'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de Tabela'
          Value = '2'
        end>
    end
    object rdgOrcPed: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Or'#231'amento de Venda'
          Value = '1'
        end
        item
          Caption = 'Pedido de Venda'
          Value = '2'
        end>
    end
    object rdgReplicPrecos: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Somente Empresa Gerencial'
          Value = '1'
        end
        item
          Caption = 'Qualquer Empresa'
          Value = '2'
        end>
    end
    object rdgModCol_0_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o gerar arquivos'
          Value = '0'
        end
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3'
          Value = '3'
        end
        item
          Caption = 'Modelo-4'
          Value = '4'
        end
        item
          Caption = 'Modelo-5'
          Value = '5'
        end
        item
          Caption = 'Modelo-6'
          Value = '6'
        end
        item
          Caption = 'Modelo-7'
          Value = '7'
        end
        item
          Caption = 'Modelo-8'
          Value = '8'
        end
        item
          Caption = 'Modelo-9'
          Value = '9'
        end
        item
          Caption = 'Modelo-10'
          Value = '10'
        end
        item
          Caption = 'Modelo-11'
          Value = '11'
        end
        item
          Caption = 'Modelo-12'
          Value = '12'
        end
        item
          Caption = 'Modelo-13'
          Value = '13'
        end
        item
          Caption = 'Modelo-14'
          Value = '14'
        end>
    end
    object rdgCodTintaNFe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Codigo do produto do cadastro de produtos'
          Value = '1'
        end
        item
          Caption = 'Codigo do produto acabado'
          Value = '2'
        end
        item
          Caption = 'C'#243'digo '#250'nico do tintom'#233'trico'
          Value = '3'
        end>
    end
    object rdgPrecos: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'CUS'
        end
        item
          Caption = 'Pre'#231'o de Venda 1'
          Value = 'VE1'
        end
        item
          Caption = 'Pre'#231'o de Venda 2'
          Value = 'VE2'
        end
        item
          Caption = 'Pre'#231'o de Venda 3'
          Value = 'VE3'
        end
        item
          Caption = 'Pre'#231'o de Venda 4'
          Value = 'VE4'
        end
        item
          Caption = 'Pre'#231'o de Venda 5'
          Value = 'VE5'
        end
        item
          Caption = 'Pre'#231'o de Venda 6'
          Value = 'VE6'
        end
        item
          Caption = 'Pre'#231'o de Venda 7'
          Value = 'VE7'
        end
        item
          Caption = 'Pre'#231'o da '#250'ltima compra'
          Value = 'ULT'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
          Value = 'MED'
        end>
    end
    object rdgPrecosTE: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'CUS'
        end
        item
          Caption = 'Pre'#231'o de Venda 1'
          Value = 'VE1'
        end
        item
          Caption = 'Pre'#231'o de Venda 2'
          Value = 'VE2'
        end
        item
          Caption = 'Pre'#231'o de Venda 3'
          Value = 'VE3'
        end
        item
          Caption = 'Pre'#231'o de Venda 4'
          Value = 'VE4'
        end
        item
          Caption = 'Pre'#231'o de Venda 5'
          Value = 'VE5'
        end
        item
          Caption = 'Pre'#231'o de Venda 6'
          Value = 'VE6'
        end
        item
          Caption = 'Pre'#231'o de Venda 7'
          Value = 'VE7'
        end
        item
          Caption = 'Pre'#231'o da '#250'ltima compra'
          Value = 'ULT'
        end
        item
          Caption = 'Pre'#231'o da '#250'ltima compra + Impostos'
          Value = 'IMP'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
          Value = 'MED'
        end>
    end
    object edtValMaiorZero4Dec: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.0000;(,0.0000)'
      Properties.EditFormat = '#,##0.0000'
      Properties.UseThousandSeparator = True
    end
    object rdgTipDesMax: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Substitutivo'
          Value = '1'
        end
        item
          Caption = 'Complementar'
          Value = '2'
        end>
    end
    object rdgQtdVTrVal_1_2_3_4: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.Items = <
        item
          Caption = '1'
          Value = '1'
        end
        item
          Caption = '2'
          Value = '2'
        end
        item
          Caption = '3'
          Value = '3'
        end
        item
          Caption = '4'
          Value = '4'
        end>
    end
    object rdgExiDoc_V_O: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Vendas'
          Value = 'V'
        end
        item
          Caption = 'Or'#231'amentos/Pedidos/Ordem de Produ'#231#227'o Avulsa'
          Value = 'O'
        end
        item
          Caption = 'Or'#231'amentos'
          Value = 'OR'
        end
        item
          Caption = 'Pedidos'
          Value = 'PD'
        end
        item
          Caption = 'Ordem de Produ'#231#227'o Avulsa'
          Value = 'PA'
        end>
    end
    object rdgVarCupDoc_S_N: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'SIM'
          Value = 'S'
        end
        item
          Caption = 'N'#195'O'
          Value = 'N'
        end>
    end
    object rdgProdAgr_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Trazer direto com a quantidade de principal'
          Value = '1'
        end
        item
          Caption = 'Pedir a quantidade no faturamento'
          Value = '2'
        end>
    end
    object rdgPEMIFF: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Geral'
          Value = '1'
        end
        item
          Caption = 'Por Cliente'
          Value = '2'
        end>
    end
    object rdgColTrf: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '40 colunas'
          Value = '1'
        end
        item
          Caption = '80 colunas'
          Value = '2'
        end>
    end
    object rdgGEmpPd: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Empresa do Pedido/Or'#231'amento'
          Value = '1'
        end
        item
          Caption = 'Empresa do Cadastro de Operador'
          Value = '2'
        end>
    end
    object rdgMoExSi: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o gerar arquivos'
          Value = '0'
        end
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end
        item
          Caption = 'Modelo 3'
          Value = '3'
        end
        item
          Caption = 'Modelo 4 (CSV)'
          Value = '4'
        end
        item
          Caption = 'Modelo 5 (TXT)'
          Value = '5'
        end
        item
          Caption = 'Modelo 6 (XML)'
          Value = '6'
        end
        item
          Caption = 'Modelo 7 (XLS)'
          Value = '7'
        end
        item
          Caption = 'Modelo 8 (XML)'
          Value = '8'
        end>
    end
    object btnOpen_MarcasBosh: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Cadastrar Marcas BOSCH'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object mmoTexto: TcxEditRepositoryMemoItem
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 10
    end
    object cbxModalidades: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
    end
    object rdgLitGal: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Litragem'
          Value = 'L'
        end
        item
          Caption = 'Galonagem'
          Value = 'G'
        end>
    end
    object rdbTipEmp_E_S_A: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Entrada'
          Value = 'E'
        end
        item
          Caption = 'Sa'#237'da'
          Value = 'S'
        end
        item
          Caption = 'Ambos'
          Value = 'A'
        end>
    end
    object rdgPerComPro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'O mesmo para todas tabelas de pre'#231'os'
          Value = '1'
        end
        item
          Caption = 'Um para cada tabela de pre'#231'o'
          Value = '2'
        end>
    end
    object rdgTipVol: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Embalagem'
          Value = '1'
        end
        item
          Caption = 'M'#250'ltiplo de Venda'
          Value = '2'
        end>
    end
    object rdgEntFutItemEstrut: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'O pr'#243'prio produto vendido no documento de venda.'
          Value = '1'
        end
        item
          Caption = 
            'Os sub-produtos vinculados ao produto estrutura vendido no docum' +
            'ento de venda.'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgVendaItemEstrut: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'do Item estrutura'
          Value = '1'
        end
        item
          Caption = 'dos sub-produtos'
          Value = '2'
        end
        item
          Caption = 
            'havendo estoque do item estrutura, do mesmo, n'#227'o havendo estoque' +
            ' dele, dos sub-produtos'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgCmp40C: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Completo'
          Value = '1'
        end
        item
          Caption = 'Simplificado'
          Value = '2'
        end>
    end
    object rdgConEst: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Grava'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Contagem'
          Value = '2'
        end>
    end
    object rdgExcel_Calc: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Excel'
          Value = '1'
        end
        item
          Caption = 'Calc(BrOffice)'
          Value = '2'
        end>
    end
    object rdgTipoTrava_B_C_A: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Bases/Embalagem'
          Value = 'B'
        end
        item
          Caption = 'Componentes'
          Value = 'C'
        end
        item
          Caption = 'Ambos'
          Value = 'A'
        end>
    end
    object rdgSepExp: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Separa'#231#227'o'
          Value = 'E'
        end
        item
          Caption = 'Pedido'
          Value = 'P'
        end>
    end
    object rdgOpcTro: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Apenas Entrada'
          Value = 'E'
        end
        item
          Caption = 'Apenas Sa'#237'da'
          Value = 'S'
        end
        item
          Caption = 'Ambos (E/S)'
          Value = 'A'
        end>
    end
    object rdgClaSub: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Substitu'#237'do Tribut'#225'rio'
          Value = '1'
        end
        item
          Caption = 'Substituto Tribut'#225'rio'
          Value = '2'
        end>
    end
    object rdgIVlIpi: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Nos campos pr'#243'prios'
          Value = 'P'
        end
        item
          Caption = 'Nos dados adicionais'
          Value = 'A'
        end>
    end
    object rdgLayCor: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Coral'
          Value = 'C'
        end
        item
          Caption = 'NeoGrid Modelo 2'
          Value = 'G'
        end
        item
          Caption = 'NeoGrid Modelo 3'
          Value = 'F'
        end
        item
          Caption = 'NeoGrid - Vers'#227'o 3.2'
          Value = 'N'
        end
        item
          Caption = 'NeoGrid - Vers'#227'o 3.2 Sherwin Willians'
          Value = 'S'
        end
        item
          Caption = 'NeoGrid Modelo 4'
          Value = 'H'
        end
        item
          Caption = 'NeoGrid Modelo 5'
          Value = 'I'
        end
        item
          Caption = 'Coral Modelo 2'
          Value = 'D'
        end
        item
          Caption = 'Coral Modelo 3'
          Value = 'E'
        end
        item
          Caption = 'Coral Modelo 4'
          Value = 'B'
        end>
    end
    object rdgPrcRea: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = '1'
        end
        item
          Caption = 'Custo Real'
          Value = '2'
        end>
    end
    object rdgMetGir: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '1 - Giro m'#234's fechado'
          Value = '1'
        end
        item
          Caption = '2 - Giro m'#243'vel'
          Value = '2'
        end>
    end
    object rdgVenRep: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Vendedor'
          Value = '1'
        end
        item
          Caption = 'Representante'
          Value = '2'
        end>
    end
    object rdgPopTin: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Imprimir'
          Value = 'I'
        end
        item
          Caption = 'Gerar'
          Value = 'G'
        end>
    end
    object rdgDivCom: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Cadastro de Diversos'
          Value = '1'
        end
        item
          Caption = 'Cadastro de Atividades'
          Value = '2'
        end>
    end
    object rdgTabPreSugestao: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o utilizar esta configura'#231#227'o'
          Value = '0'
        end
        item
          Caption = 'Tabela de Pre'#231'o 1'
          Value = '1'
        end
        item
          Caption = 'Tabela de Pre'#231'o 2'
          Value = '2'
        end
        item
          Caption = 'Tabela de Pre'#231'o 3'
          Value = '3'
        end
        item
          Caption = 'Tabela de Pre'#231'o 4'
          Value = '4'
        end
        item
          Caption = 'Tabela de Pre'#231'o 5'
          Value = '5'
        end
        item
          Caption = 'Tabela de Pre'#231'o 6'
          Value = '6'
        end
        item
          Caption = 'Tabela de Pre'#231'o 7'
          Value = '7'
        end>
    end
    object rdgFrmPcm: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o final = (Pre'#231'o) + (Pre'#231'o) * (%IPI) * (%Subs.)'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o final = (Pre'#231'o) + (Pre'#231'o) * (%IPI)  +  (Pre'#231'o) * (%Subs.)'
          Value = '2'
        end>
    end
    object rdgNotPMd: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '80C'
          Value = '1'
        end
        item
          Caption = '40C'
          Value = '2'
        end>
    end
    object rdgTipPDE_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Pedidos de Compra'
          Value = '1'
        end
        item
          Caption = 'Pedidos de Transf. Estoque'
          Value = '2'
        end
        item
          Caption = 'Todos os Pedidos'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgCodSen_C_S: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'C'#243'digo'
          Value = 'C'
        end
        item
          Caption = 'Senha'
          Value = 'S'
        end>
      Properties.WordWrap = True
    end
    object rdgCodSen_C_S_B: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'C'#243'digo'
          Value = 'C'
        end
        item
          Caption = 'Senha'
          Value = 'S'
        end
        item
          Caption = 'C'#243'digo de Barras'
          Value = 'B'
        end>
      Properties.WordWrap = True
    end
    object btnPonImp: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar os Pontos de Impress'#227'o'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnFilSep: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar as Filas de impress'#227'o'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnFilBol: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar as Filas de impress'#227'o'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgOrdPdv: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Descri'#231#227'o do Produto'
          Value = '1'
        end
        item
          Caption = 'Unidade + Descri'#231#227'o do Produto'
          Value = '2'
        end
        item
          Caption = 'Digita'#231#227'o dos Produtos'
          Value = '3'
        end
        item
          Caption = 'Localiza'#231#227'o F'#237'sica'
          Value = '4'
        end
        item
          Caption = 'Departamento do Produto + Descri'#231#227'o do Produto'
          Value = '5'
        end
        item
          Caption = 'Itens Retira / Itens Entrega'
          Value = '6'
        end>
    end
    object rdgTipCodBar: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'EAN13'
          Value = '1'
        end
        item
          Caption = 'EAN39'
          Value = '2'
        end>
    end
    object rdgIdeSep: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '1-C'#243'digo de F'#225'brica'
          Value = '1'
        end
        item
          Caption = '2-C'#243'digo de Barras'
          Value = '2'
        end>
    end
    object rdgOrdSep: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1-Descri'#231#227'o do Produto'
          Value = '1'
        end
        item
          Caption = '2-Localiza'#231#227'o F'#237'sica'
          Value = '2'
        end
        item
          Caption = '3-Digita'#231#227'o dos Produtos'
          Value = '3'
        end
        item
          Caption = '4-Departamento do Produto + Descri'#231#227'o do Produto'
          Value = '4'
        end
        item
          Caption = '5-Itens Retira / Itens Entrega'
          Value = '5'
        end>
    end
    object rdgModCoE_0_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o gerar arquivos'
          Value = '0'
        end
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3'
          Value = '3'
        end
        item
          Caption = 'Modelo-4'
          Value = '4'
        end
        item
          Caption = 'Modelo-5'
          Value = '5'
        end
        item
          Caption = 'Modelo-6'
          Value = '6'
        end
        item
          Caption = 'Modelo-7'
          Value = '7'
        end
        item
          Caption = 'Modelo-8'
          Value = '8'
        end
        item
          Caption = 'Modelo-9'
          Value = '9'
        end
        item
          Caption = 'Modelo-10'
          Value = '10'
        end>
    end
    object rdgSugEst_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Trazendo do cadastro do produto principal'
          Value = '1'
        end
        item
          Caption = 'Somando os pre'#231'os de venda dos sub-produtos'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgSugEntMer_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Compra'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de Custo'
          Value = '2'
        end
        item
          Caption = 'Nenhum'
          Value = '3'
        end
        item
          Caption = 'Pre'#231'o de Compra com Desconto Rateado'
          Value = '4'
        end>
    end
    object rdgOrdDoc: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Descri'#231#227'o do Produto'
          Value = '1'
        end
        item
          Caption = 'Digita'#231#227'o dos Produtos'
          Value = '2'
        end
        item
          Caption = 'Unidade + Descri'#231#227'o do Produto'
          Value = '3'
        end
        item
          Caption = 'Departamento do Produto + Descri'#231#227'o do Produto'
          Value = '4'
        end
        item
          Caption = 'Localiza'#231#227'o F'#237'sica'
          Value = '5'
        end
        item
          Caption = 'Itens Retira / Itens Entrega'
          Value = '6'
        end>
    end
    object rdgTipFat: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Nota Fiscal'
          Value = 'A'
        end
        item
          Caption = 'MI / FF'
          Value = 'B'
        end
        item
          Caption = 'Cupom Fiscal'
          Value = 'C'
        end
        item
          Caption = 'Divisivel'
          Value = 'D'
        end>
    end
    object rdgTipFatGar: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Nota Fiscal'
          Value = 'A'
        end
        item
          Caption = 'MI / FF'
          Value = 'B'
        end>
    end
    object rdgTipCtr: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Dt. Recebimento'
          Value = '1'
        end
        item
          Caption = 'Dt. Baixa'
          Value = '2'
        end>
    end
    object chkTabPreSenha: TcxEditRepositoryCheckGroupItem
      Properties.EditValueFormat = cvfStatesString
      Properties.GlyphCount = 7
      Properties.Items = <
        item
          Caption = 'Tabela de Pre'#231'o 1'
        end
        item
          Caption = 'Tabela de Pre'#231'o 2'
        end
        item
          Caption = 'Tabela de Pre'#231'o 3'
        end
        item
          Caption = 'Tabela de Pre'#231'o 4'
        end
        item
          Caption = 'Tabela de Pre'#231'o 5'
        end
        item
          Caption = 'Tabela de Pre'#231'o 6'
        end
        item
          Caption = 'Tabela de Pre'#231'o 7'
        end>
      Properties.OnEditValueToStates = chkTabPreSenhaPropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkTabPreSenhaPropertiesStatesToEditValue
    end
    object edtTexto_Tam80: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 80
      Properties.ValidateOnEnter = True
    end
    object edtTexto_Tam115: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 115
      Properties.ValidateOnEnter = True
    end
    object mskTelefone: TcxEditRepositoryMaskItem
      Properties.CharCase = ecUpperCase
    end
    object rdgHisCtr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Gravar "Ref. ao Faturamento"'
          Value = '1'
        end
        item
          Caption = 'Gravar Nome e C'#243'digo do Cliente'
          Value = '2'
        end
        item
          Caption = 'Mensagens informadas no documento de venda'
          Value = '3'
        end>
    end
    object rdgQtdColunas: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '40 Colunas'
          Value = '40'
        end
        item
          Caption = '80 Colunas'
          Value = '80'
        end>
    end
    object rdgMosMcl: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Documentos Diretos'
          Value = '1'
        end
        item
          Caption = 'Todos os documentos (Diretos+Confirmados)'
          Value = '2'
        end
        item
          Caption = 'Diretos n'#227'o Confirmados + Confirmados'
          Value = '3'
        end>
    end
    object rdgNosNum: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Nosso n'#250'mero'
          Value = '1'
        end
        item
          Caption = 'Nosso n'#250'mero 7D'
          Value = '2'
        end>
    end
    object rdgDcVbVl: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Valor Bruto'
          Value = 'B'
        end
        item
          Caption = 'Valor L'#237'quido'
          Value = 'L'
        end>
    end
    object rdgSeLfCp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Localiza'#231#227'o F'#237'sica'
          Value = 'L'
        end
        item
          Caption = 'Complemento'
          Value = 'C'
        end>
    end
    object rdgTipDex: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Leitor C'#243'digo de Barra'
          Value = '1'
        end
        item
          Caption = 'Manual'
          Value = '2'
        end>
    end
    object rdgAtuNmd: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Compra Digitado'
          Value = 'C'
        end
        item
          Caption = 'Pre'#231'o de Compra Digitado + Outras Despesas'
          Value = 'O'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
          Value = 'M'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra'
          Value = 'U'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra mais Impostos'
          Value = 'I'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra + Outras Despesas'
          Value = 'D'
        end>
    end
    object rdgEmpBai: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Empresa logada'
          Value = 1
        end
        item
          Caption = 'Empresa do documento'
          Value = 2
        end>
    end
    object rdgEmiP40: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'No in'#237'cio do documento'
          Value = 1
        end
        item
          Caption = 'No corpo do documento'
          Value = 2
        end>
    end
    object btnOpen_RomIpr: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = False
      Properties.ViewStyle = vsButtonsOnly
    end
    object rdgModAut: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Normal'
          Value = 1
        end
        item
          Caption = 'Resumida'
          Value = 2
        end>
    end
    object rdgCeaTmn: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Autom'#225'tica'
          Value = '1'
        end
        item
          Caption = 'Manual (Pedido de Venda)'
          Value = '2'
        end>
    end
    object rdgCstSimSub: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '201'
          Value = '201'
        end
        item
          Caption = '202'
          Value = '202'
        end
        item
          Caption = '500'
          Value = '500'
        end>
    end
    object rdgCstSimTri: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = '101'
          Value = '101'
        end
        item
          Caption = '102'
          Value = '102'
        end
        item
          Caption = '103'
          Value = '103'
        end>
    end
    object rdgNtOpNs: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1-No municipio da empresa'
          Value = '1'
        end
        item
          Caption = '2-No municipio do cliente'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgCstSimTriCI: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '101'
          Value = '101'
        end
        item
          Caption = '900'
          Value = '900'
        end>
    end
    object rdgPosNab: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Travar'
          Value = 'T'
        end
        item
          Caption = 'Avisar'
          Value = 'A'
        end>
    end
    object rdgTrvTin: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Das configura'#231#227'o do AutTin'
          Value = '1'
        end
        item
          Caption = 'Igual '#224' trava de produtos n'#227'o tintom'#233'tricos'
          Value = '2'
        end>
    end
    object rdgTipCalOrdPro: TcxEditRepositoryRadioGroupItem
      Properties.DefaultValue = '1'
      Properties.Items = <
        item
          Caption = 
            'Calcular e Baixar a quantidade dos sub-produtos referente a quan' +
            'tidade informada do produto acabado automaticamente'
          Value = '1'
        end
        item
          Caption = 
            'Calcular e Mostrar a quantidade dos sub-produtos que ser'#227'o baixa' +
            'dos para que possa conferir e alterar antes da grava'#231#227'o'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgLotBxaOrdPro: TcxEditRepositoryRadioGroupItem
      Properties.DefaultValue = '1'
      Properties.Items = <
        item
          Caption = 
            'Baixar sempre o estoque do lote Selecionado na Manuten'#231#227'o de Ord' +
            'em de Produ'#231#227'o.'
          Value = '1'
        end
        item
          Caption = 
            'Exibir os produtos com lote para que o operador escolha de qual ' +
            'lote ser'#225' realizada a baixa de estoque.'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgMarVen: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '1-Margem de Lucro'
          Value = '1'
        end
        item
          Caption = '2-Pre'#231'o de Venda'
          Value = '2'
        end>
    end
    object rdgOpSoAb: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'No Pedido'
          Value = '1'
        end
        item
          Caption = 'Na Venda'
          Value = '2'
        end>
    end
    object rdgDpDiDe: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Desconto por Item'
          Value = '1'
        end
        item
          Caption = 'Desconto Especial'
          Value = '2'
        end>
    end
    object rdgModDav: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'N'#227'o usar DAV'
          Value = '1'
        end
        item
          Caption = 'DAV - A5'
          Value = '2'
        end
        item
          Caption = 'DAV - ECF'
          Value = '3'
        end>
    end
    object rdgEspDav: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Escolher antes de Imprimir'
          Value = ''
        end
        item
          Caption = 'Or'#231'amento'
          Value = #39'OR'#39
        end
        item
          Caption = 'Pedido'
          Value = 'PD'
        end>
    end
    object rdgPrF_AE: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Utilizar Tabela Ativa'
          Value = 'A'
        end
        item
          Caption = 'Escolher Tabela'
          Value = 'E'
        end>
    end
    object rdgOriPro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Cadastro de Profissionais (Diversos)'
          Value = '1'
        end
        item
          Caption = 'Cadastro de Produtos'
          Value = '2'
        end
        item
          Caption = 'Faixa de Valor (Faturamento)'
          Value = '3'
        end
        item
          Caption = 'Cadastro de Clientes'
          Value = '4'
        end>
    end
    object rdgTipTef: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Discado'
          Value = 'D'
        end
        item
          Caption = 'Dedicado'
          Value = 'E'
        end>
    end
    object rdgRegEspTri: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Nenhum'
          Value = '0'
        end
        item
          Caption = 'Tributa'#231#227'o no Munic'#237'pio'
          Value = '1'
        end
        item
          Caption = 'Tributa'#231#227'o fora do Munic'#237'pio'
          Value = '2'
        end
        item
          Caption = 'Isen'#231#227'o'
          Value = '3'
        end
        item
          Caption = 'Imune'
          Value = '4'
        end
        item
          Caption = 'Exigibilidade suspensa por decis'#227'o judicial'
          Value = '5'
        end
        item
          Caption = 'Exigibilidade suspensa por procedimento administrativo'
          Value = '6'
        end>
    end
    object rdgEmpSer: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a empresa:'
      Properties.Items = <
        item
          Caption = 'GISS ONLINE'
          Value = 'GISS ONLINE'
        end
        item
          Caption = 'FG+'
          Value = 'FG+'
        end
        item
          Caption = 'PAINEL FISCAL'
          Value = 'PAINEL FISCAL'
        end
        item
          Caption = 'CITEL'
          Value = 'CITEL'
        end
        item
          Caption = 'SIAM'
          Value = 'SIAM'
        end
        item
          Caption = 'PREFEITURA DE JABOTICABAL'
          Value = 'PREFEITURA DE JABOTICABAL'
        end
        item
          Caption = 'PREFEITURA DE LIMEIRA'
          Value = 'PREFEITURA DE LIMEIRA'
        end
        item
          Caption = 'PREFEITURA DE SOROCABA'
          Value = 'PREFEITURA DE SOROCABA'
        end
        item
          Caption = 'PREFEITURA DE PIRACICABA'
          Value = 'PREFEITURA DE PIRACICABA'
        end
        item
          Caption = 'PREFEITURA DE BRASILIA'
          Value = 'PREFEITURA DE BRASILIA'
        end
        item
          Caption = 'PREFEITURA DE SERTAOZINHO'
          Value = 'PREFEITURA DE SERTAOZINHO'
        end>
      Properties.WordWrap = True
    end
    object rdgPedTri: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Total dos produtos + IPI'
          Value = '1'
        end
        item
          Caption = 'Total dos produtos'
          Value = '2'
        end>
    end
    object rdgRazFan: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Raz'#227'o Social'
          Value = 'R'
        end
        item
          Caption = 'Nome Fantasia'
          Value = 'F'
        end>
    end
    object rdgTipImpEti: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Imprimir Etiqueta de Entrega e Etiqueta de Formula'#231#227'o separadas,' +
            ' atrav'#233's da a'#231#227'o do operador'
          Value = '1'
        end
        item
          Caption = 
            'Imprimir Etiqueta de Entrega junto com a Etiqueta de Formula'#231#227'o,' +
            ' automaticamente'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object btnModCartaCob: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar os Modelos'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgFatPre: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end>
      Properties.OnChange = rdgFatPrePropertiesChange
    end
    object rdgProCtr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Manter o Contas a Receber do Cupom Fiscal'
          Value = '1'
        end
        item
          Caption = 
            'Apagar o Contas a Receber do Cupom Fiscal e gravar o da Nota Fis' +
            'cal'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgDiaEnt: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end>
      Properties.OnChange = rdgDiaEntPropertiesChange
    end
    object rdgTraMinCus: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o travar'
          Value = 'N'
        end
        item
          Caption = 'Travar pelo pre'#231'o custo'
          Value = 'C'
        end
        item
          Caption = 'Travar pelo custo real'
          Value = 'R'
        end>
    end
    object rdgOutrasIsentas: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Outras'
          Value = 'O'
        end
        item
          Caption = 'Isentas'
          Value = 'I'
        end>
    end
    object rdgOpcADe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '2-Custo de Produtos e 5-Compras'
          Value = '1'
        end
        item
          Caption = '3-Despesas'
          Value = '2'
        end>
    end
    object mskCnpjrc: TcxEditRepositoryMaskItem
      Properties.EditMask = '>aa\.aaa\.aaa/aaaa-99;0;_'
      Properties.MaxLength = 0
    end
    object mskCodRecEstadual: TcxEditRepositoryMaskItem
      Properties.EditMask = '99999-9;0;_'
      Properties.MaxLength = 0
    end
    object edtARTAtu: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
    end
    object rdgPrecoOSOE: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Custo'
          Value = 'C'
        end
        item
          Caption = 'Venda'
          Value = 'V'
        end>
    end
    object rdgOpc80c: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Endere'#231'o de entrega no cabe'#231'alho'
          Value = '1'
        end
        item
          Caption = 
            'Endere'#231'o de faturamento no cabe'#231'alho e endere'#231'o de entrega no ro' +
            'dap'#233
          Value = '2'
        end>
    end
    object rdgRDG: TcxEditRepositoryRadioGroupItem
      Properties.Items = <>
    end
    object rdgTipSolicAbast: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Manual, exercida pela a'#231#227'o do operador, para realizar cada uma d' +
            'as 3 fases.'
          Value = 'M'
        end
        item
          Caption = 
            'Autom'#225'tica, exercida pelo sistema, realizando as 3 fases no ato ' +
            'da venda ( esta op'#231#227'o n'#227'o pode ser utilizada com replicador )'
          Value = 'A'
        end>
      Properties.WordWrap = True
    end
    object rdgTraPrcPromoc: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Tabela'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de Promo'#231#227'o'
          Value = '2'
        end>
    end
    object rdgModSep: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3'
          Value = '3'
        end
        item
          Caption = 'Modelo-4'
          Value = '4'
        end
        item
          Caption = 'Modelo-5'
          Value = '5'
        end
        item
          Caption = 'Modelo-6'
          Value = '6'
        end
        item
          Caption = 'Modelo-7'
          Value = '7'
        end
        item
          Caption = 'Modelo-8 (Meia Folha)'
          Value = '8'
        end>
    end
    object rdgMLayOP: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3 - Com lote principal para produ'#231#227'o'
          Value = '3'
        end
        item
          Caption = 'Modelo-4'
          Value = '4'
        end
        item
          Caption = 'Modelo-5 (Densidade)'
          Value = '5'
        end
        item
          Caption = 'Modelo-6 (Densidade)'
          Value = '6'
        end
        item
          Caption = 'Modelo-7'
          Value = '7'
        end>
    end
    object rdgTipComPro: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'GERAL'
          Value = 'G'
        end
        item
          Caption = 'POR PROFISSIONAL'
          Value = 'P'
        end>
    end
    object rdgPedFlu_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Data de Entrega'
          Value = '1'
        end
        item
          Caption = 'Data do Pedido'
          Value = '2'
        end
        item
          Caption = 'Data do Faturamento'
          Value = '3'
        end>
    end
    object rdgCalSal: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Saldo estoque + Entrega Futura Pendente ( A / P / F ) - Saldo re' +
            'servado de pedidos'
          Value = '1'
        end
        item
          Caption = 'Saldo estoque - Saldo reservado de pedidos'
          Value = '2'
        end
        item
          Caption = 
            'Saldo estoque + Entrega Futura Pendente ( F ) - Saldo reservado ' +
            'de pedidos'
          Value = '3'
        end
        item
          Caption = 
            'Saldo estoque + Entrega Futura Pendente ( A / P ) - Saldo reserv' +
            'ado de pedidos'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgClaFes: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '108'
          Value = '108'
        end
        item
          Caption = '404'
          Value = '404'
        end>
    end
    object rdgVolRom: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Peso do cadastro de unidades'
          Value = '1'
        end
        item
          Caption = 'Embalagem do cadastro de produtos'
          Value = '2'
        end
        item
          Caption = 'M'#250'ltiplo de vendas do cadastro de produtos'
          Value = '3'
        end
        item
          Caption = 'Volume do Faturamento'
          Value = '4'
        end>
    end
    object rdgLayImpSFM: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Acumulativo ('#250'nico arquivo, ex: "PEDIDOCAB.TXT")'
          Value = '1'
        end
        item
          Caption = 
            'Blocos (arquivos por transmiss'#227'o, ex: "PEDCAB20110826121059.TXT"' +
            ')'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgTipImpRedZ_1_2: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Extrair a mem'#243'ria fiscal da ECF e importar para o AUTCOM.'
          Value = '1'
        end
        item
          Caption = 'Importar para o AUTCOM mediante mem'#243'ria fiscal j'#225' gerada.'
          Value = '2'
        end>
    end
    object rdgDenFin_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1- Sempre, mesmo com a Duplicata vencida'
          Value = '1'
        end
        item
          Caption = '2 - Somente at'#233' o vencimento da Duplicata'
          Value = '2'
        end>
    end
    object rdgPreCusPreVen: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de Venda'
          Value = '2'
        end>
    end
    object btnCfgPais: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para configurar o Pa'#237's'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgDtBaRo: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o solicitar ao operador, gravar automaticamente.'
          Value = '1'
        end
        item
          Caption = 'Solicitar por documento'
          Value = '2'
        end
        item
          Caption = 'Solicitar uma unica vez no final da baixa'
          Value = '3'
        end>
    end
    object rdgTipDesIte: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Cadastro de Produtos'
          Value = '1'
        end
        item
          Caption = 'Informada na Tela do Faturamento'
          Value = '2'
        end>
    end
    object rdgCtlEst: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Por lote'
          Value = '1'
        end
        item
          Caption = 'Por armaz'#233'm'
          Value = '2'
        end>
    end
    object rdgFatPed: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'a palavra IMEDIATO'
          Value = '1'
        end
        item
          Caption = 'a pr'#243'pia Data de Faturamento'
          Value = '2'
        end>
    end
    object rdgCtlTempoEsp: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Controle de Entregadores'
          Value = '1'
        end
        item
          Caption = 'Romaneio'
          Value = '2'
        end>
    end
    object rdgModAcaSfa: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pocket'
          Value = '1'
        end
        item
          Caption = 'Android'
          Value = '2'
        end>
    end
    object rgdTpLtPr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Value = '1'
        end
        item
          Value = '2'
        end>
    end
    object rdgTpLtPr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Somente os itens que tem pre'#231'os divergentes ap'#243's entrada de merc' +
            'adorias '
          Value = '1'
        end
        item
          Caption = 'Todos os itens da entrada de mercadorias'
          Value = '2'
        end>
    end
    object rdgAnaRes: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Contas a Pagar'
          Value = '1'
        end
        item
          Caption = 'Movimenta'#231#227'o Banc'#225'ria'
          Value = '2'
        end>
    end
    object rdgCndEsp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Sempre '#224' vista'
          Value = '1'
        end
        item
          Caption = 'Mantendo a condi'#231#227'o de pagamento do documento original'
          Value = '2'
        end>
    end
    object rdgFreTra: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o utilizar Calculo do Frete.'
          Value = '1'
        end
        item
          Caption = 'Pela Transportadora / Cidade'
          Value = '2'
        end
        item
          Caption = 'Pelo cadastro de produtos, mais adicional pela transportadora.'
          Value = '3'
        end
        item
          Caption = 'Pela transportadora / faixa de faturamento'
          Value = '4'
        end>
    end
    object rdgSugFre: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Carregar o valor calculado no campo do frete.'
          Value = '1'
        end
        item
          Caption = 
            'Apenas informar o valor calculado, deixando o campo do frete vaz' +
            'io'
          Value = '2'
        end>
    end
    object rdgFinMno: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Gerar financeiro somente para o Pedido Faturamento Futuro'
          Value = '1'
        end
        item
          Caption = 
            'Gerar financeiro para o Pedido Faturamento Futuro e para a Nota ' +
            'Fiscal separadamente'
          Value = '2'
        end>
    end
    object btnModCartaDes: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar os Modelos'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = False
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgOpGnre_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Banco do Brasil DDA'
          Value = '1'
        end
        item
          Caption = 'GNRE Online'
          Value = '2'
        end
        item
          Caption = 'GNRE.PE.GOV.BR ( ST,DIFAL,FCP )'
          Value = '3'
        end>
    end
    object btnOpen_DescProdAcab: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Abrir(Configura'#231#245'es - Descri'#231#227'o Produto Acabado)'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnOpen_CodFabrProdAcab: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Abrir(Configura'#231#245'es - C'#243'digo F'#225'brica Produto Acabado)'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object spnDia: TcxEditRepositorySpinItem
      Properties.MaxValue = 31.000000000000000000
      Properties.MinValue = 1.000000000000000000
    end
    object edtValInt: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
    end
    object rdgPDVLBR: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - No percentual de desconto gravado na venda "PORDES".'
          Value = '1'
        end
        item
          Caption = 
            '2 - No percentual de desconto do profissional do cadastro de cli' +
            'entes.'
          Value = '2'
        end>
    end
    object rdgOpImpSfa: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Pedido'
          Value = 'PD'
        end
        item
          Caption = 'Or'#231'amento'
          Value = 'OR'
        end>
    end
    object rdgMarAna: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra'
          Value = '2'
        end>
    end
    object rdgMdAdCf: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = '1-Item a Item'
          Value = '1'
        end
        item
          Caption = '2-No total do cupom'
          Value = '2'
        end>
    end
    object btnCliCRM: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para definir a exibi'#231#227'o dos campos de Clientes'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnForCRM: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para definir a exibi'#231#227'o dos campos de Fornecedores'
          Default = True
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object edtTexto_Url: TcxEditRepositoryTextItem
      Properties.MaxLength = 200
    end
    object rdgNCMAut: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Embalagem da tinta (linhas)'
          Value = '1'
        end
        item
          Caption = 'Produto para venda tinta de maquina'
          Value = '2'
        end>
    end
    object rdgPulMls: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pulsos'
          Value = '1'
        end
        item
          Caption = 'MLs'
          Value = '2'
        end
        item
          Caption = 'On'#231'as'
          Value = '3'
        end>
    end
    object cbxCST: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
    end
    object rdgMontaDesPro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Descri'#231#227'o + Refer'#234'ncia'
          Value = '1'
        end
        item
          Caption = 'Refer'#234'ncia + Descri'#231#227'o'
          Value = '2'
        end>
    end
    object rdgOrdByNfe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Inclus'#227'o'
          Value = 'I'
        end
        item
          Caption = 'Alfab'#233'tica'
          Value = 'A'
        end
        item
          Caption = 'C'#243'digo do Item'
          Value = 'C'
        end
        item
          Caption = 'Unidade + Descri'#231#227'o do Produto'
          Value = 'U'
        end
        item
          Caption = 'Localiza'#231#227'o Fisica'
          Value = 'L'
        end>
    end
    object rdgDtaOcoEst: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Data do dia do estorno'
          Value = '1'
        end
        item
          Caption = 'Data da baixa do documento'
          Value = '2'
        end>
    end
    object rdgCNVEMB: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pelo cadastro de embalagens'
          Value = 'S'
        end
        item
          Caption = 'Pela Tabela de Forma'#231#227'o de Pre'#231'os do Fornecedor'
          Value = 'F'
        end
        item
          Caption = 'N'#227'o utilizar convers'#227'o'
          Value = 'N'
        end>
    end
    object rdgOpcExpTinMaq: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Somente C'#243'digo de Barras da Embalagem (Base)'
          Value = '1'
        end
        item
          Caption = 
            'C'#243'digo de Barras da Embalagem (Base) + C'#243'digo de Barras da F'#243'rmu' +
            'la'
          Value = '2'
        end>
    end
    object rdgOpcIteEst: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'SIM'
          Value = 'S'
        end
        item
          Caption = 'N'#195'O (Carrega Sempre Item Estrutura)'
          Value = 'N'
        end
        item
          Caption = 'N'#195'O (Carrega Sempre Sub-Produtos)'
          Value = 'P'
        end>
    end
    object mskClaFisMax: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
        '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
        '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
        '99-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9' +
        '999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999;0;_'
    end
    object rdgModMkp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end
        item
          Caption = 'Modelo 3'
          Value = '3'
        end>
    end
    object rdgModAbp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgModAbf: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgVenMar: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Alterar Pre'#231'o de Venda'
          Value = '1'
        end
        item
          Caption = 'Alterar Margem de Lucro'
          Value = '2'
        end>
    end
    object rdgTipImp_L_A: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Laser'
          Value = 'L'
        end
        item
          Caption = 'Argox'
          Value = 'A'
        end>
    end
    object rdgItePre: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Compra'
          Value = 'COM'
        end
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'CUS'
        end
        item
          Caption = 'Pre'#231'o de Venda 1'
          Value = 'VE1'
        end
        item
          Caption = 'Pre'#231'o de Venda 2'
          Value = 'VE2'
        end
        item
          Caption = 'Pre'#231'o de Venda 3'
          Value = 'VE3'
        end
        item
          Caption = 'Pre'#231'o de Venda 4'
          Value = 'VE4'
        end
        item
          Caption = 'Pre'#231'o de Venda 5'
          Value = 'VE5'
        end
        item
          Caption = 'Pre'#231'o de Venda 6'
          Value = 'VE6'
        end
        item
          Caption = 'Pre'#231'o de Venda 7'
          Value = 'VE7'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio de Compra'
          Value = 'MED'
        end
        item
          Caption = 'Pre'#231'o '#250'ltima compra menos impostos federais'
          Value = 'ULTFED'
        end
        item
          Caption = 'PRE'#199'O DE ULTIMA COMPRA  '
          Value = 'ULT'
        end
        item
          Caption = 'PRE'#199'O DE ULTIMA COMPRA MAIS IMPOSTOS ENTRADA'
          Value = 'IMPULT'
        end
        item
          Caption = 'PRE'#199'O DE COMPRA L'#205'QUIDO'
          Value = 'PRELIQ'
        end>
    end
    object btnModCartaPro: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar os Modelos'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgNFTintoES: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Em GR/ML, sem converter para embalagens.'
          Value = '1'
        end
        item
          Caption = 'Em embalagens, convertendo a quantidade de GR/ML em embalagens.'
          Value = '2'
        end>
    end
    object rdgOpcGruSep: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Por Localiza'#231#227'o F'#237'sica'
          Value = 'F'
        end
        item
          Caption = 'Por Local de Separa'#231#227'o'
          Value = 'S'
        end>
    end
    object rdgComCtr: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Receber qualquer parcela'
          Value = '1'
        end
        item
          Caption = 'Receber a '#250'ltima parcela'
          Value = '2'
        end>
    end
    object mskClaGar: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999' +
        '-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-999' +
        '9-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-99' +
        '99-9999;0;_'
    end
    object rdgEstFlj: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Transfer'#234'ncia de Produtos Acabados'
          Value = '1'
        end
        item
          Caption = 'Transfer'#234'ncia de Bases / Colorantes'
          Value = '2'
        end>
    end
    object spnDiaZero: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 31.000000000000000000
    end
    object edtTexto_Tam2: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 2
    end
    object edtTexto_Tam8: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 8
    end
    object edtTexto_Tam25: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 25
    end
    object rdgEmpCfgEnt: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'GERAL, seguindo as configura'#231#245'es da empresa logada'
          Value = '1'
        end
        item
          Caption = 
            'EMPRESA, seguindo as configura'#231#245'es da empresa informada na tela ' +
            'de venda por produto.'
          Value = '2'
        end>
    end
    object rdgCat17Filtro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Listar TODAS as vendas para fora do estado'
          Value = '1'
        end
        item
          Caption = 'Listar apenas as vendas para fora do estado TRIBUTADAS'
          Value = '2'
        end>
    end
    object rdgCat17Calculo: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Compra Liquida x Alq. Interna de ST'
          Value = '1'
        end
        item
          Caption = 'ICMS calculado na venda'
          Value = '2'
        end>
    end
    object rdgAlqImpPag: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Utilizar cadastro de abrevia'#231#227'o fiscal'
          Value = '1'
        end
        item
          Caption = 'Utilizar cadastro IBPT'
          Value = '2'
        end>
    end
    object rdgMaMens: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'PRECUS'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra + Imp.'
          Value = 'IMPULT'
        end
        item
          Caption = 'Pre'#231'o de Custo + Imp.'
          Value = 'PRECU2'
        end>
    end
    object rdgSabUti: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o Considerar'
          Value = 0.000000000000000000
        end
        item
          Caption = 'Considerar dia integral'
          Value = 1.000000000000000000
        end
        item
          Caption = 'Considerar 3/4 do dia'
          Value = 0.750000000000000000
        end
        item
          Caption = 'Considerar 1/2 dia'
          Value = 0.500000000000000000
        end>
    end
    object mskClaAlp: TcxEditRepositoryMaskItem
      Properties.EditMask = '999-999-999-999-999-999;0;_'
    end
    object rdgModLib: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3'
          Value = '3'
        end
        item
          Caption = 'Modelo-4'
          Value = '4'
        end
        item
          Caption = 'Modelo-5 (Modelo 1 em A4 - Somente Jato)'
          Value = '5'
        end
        item
          Caption = 'Modelo 6'
          Value = '6'
        end>
    end
    object btnModCartaAnu: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para visualizar os Modelos'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgModelo_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Modelo 01'
          Value = '1'
        end
        item
          Caption = 'Modelo 02'
          Value = '2'
        end
        item
          Caption = 'Modelo 03'
          Value = '3'
        end>
    end
    object rdgImpAju: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'PRECO DE VENDA'
          Value = 'TOTITE'
        end
        item
          Caption = 'PRECO DE CUSTO'
          Value = 'TOTCUS'
        end
        item
          Caption = 'PRECO DE ULT.COMPRA'
          Value = 'TOTULT'
        end
        item
          Caption = 'PRECO DE ULT.COMPRA + IMP.ENTRADA'
          Value = 'IMPULT'
        end
        item
          Caption = 'PRECO MEDIO'
          Value = 'TOTMED'
        end>
    end
    object rdgTipPre: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Or'#231'amento de Transfer'#234'ncia'
          Value = '1'
        end
        item
          Caption = 'Pedido de Transfer'#234'ncia'
          Value = '2'
        end>
    end
    object rdgRatFre: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Proporcional ao valor do item'
          Value = '1'
        end
        item
          Caption = 'Proporcional ao peso do item'
          Value = '2'
        end
        item
          Caption = 'Informar no momento da entrada'
          Value = '3'
        end>
    end
    object rdgTipoConsulta: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Consulta N'#227'o Configuravel'
          Value = '1'
        end
        item
          Caption = 'Consulta Configuravel (Nova)'
          Value = '2'
        end>
    end
    object btnOpen_NFCe: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique para abrir as configura'#231#245'es'
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgVerCPF_A_T_N_L: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 4
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Avisa'
          Value = 'A'
        end
        item
          Caption = 'Trava'
          Value = 'T'
        end
        item
          Caption = 'N'#227'o avisa'
          Value = 'N'
        end
        item
          Caption = 'Trava com Libera'#231#227'o'
          Value = 'L'
        end>
      Properties.WordWrap = True
    end
    object rdgIndCon: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Individual'
          Value = '1'
        end
        item
          Caption = 'Conjugada'
          Value = '2'
        end>
    end
    object rdgTipConLvrFis: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Modelo 1 (Antiga)'
          Value = '1'
        end
        item
          Caption = 'Modelo 2 (Nova) '
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object rdgOpcTraOS_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Traval'
          Value = '1'
        end
        item
          Caption = 'Desconto M'#225'ximo'
          Value = '2'
        end>
      Properties.WordWrap = True
    end
    object edtTime: TcxEditRepositoryTimeItem
    end
    object btnConCliente: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um cliente'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADCLI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConClientePropertiesValidate
    end
    object btnConEmpresa: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma empresa'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADEMP'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConEmpresaPropertiesValidate
    end
    object btnConItem: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um item'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADITE'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConItemPropertiesValidate
    end
    object btnConFornecedor: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um fornecedor'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADFOR'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConFornecedorPropertiesValidate
    end
    object btnConPortador: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um portador'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADPOR'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConPortadorPropertiesValidate
    end
    object btnConPortRcx: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um portador'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADPOR'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConPortRcxPropertiesValidate
    end
    object btnConCta: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um Plano de Contas'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADCTA'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConCtaPropertiesValidate
    end
    object btnConAtividade: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma atividade'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADATI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnConBanco: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um banco'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADBCO'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConBancoPropertiesValidate
    end
    object btnConTransp: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma transportadora'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADTRA'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConTranspPropertiesValidate
    end
    object btnConOperador: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um operador'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADOPE'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConOperadorPropertiesValidate
    end
    object btnConTipCliente: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um tipo de cliente'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'TIPCLG'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConTipClientePropertiesValidate
    end
    object btnConEvento: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um evento'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADEVE'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConEventoPropertiesValidate
    end
    object btnConAte: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um registro'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADATE'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConAtePropertiesValidate
    end
    object btnConFase: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma fase'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADFAS'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConFasePropertiesValidate
    end
    object btnConTipOco: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um tipo de ocorr'#234'ncia'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADTOC'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConTipOcoPropertiesValidate
    end
    object btnConMotVenPerd: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um motivo de vendas perdidas'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'MOTVPD'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConMotVenPerdPropertiesValidate
    end
    object btnConCondicaoPgto: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma condi'#231#227'o de pagamento'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADCND'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConCondicaoPgtoPropertiesValidate
    end
    object btnConFormaPgto: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma forma de pagamento'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADFPG'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConFormaPgtoPropertiesValidate
    end
    object btnConDepartamento: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um departamento'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADDEP'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConDepartamentoPropertiesValidate
    end
    object btnConAbrPis: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma abrevia'#231#227'o'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'PISSAI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConAbrPisPropertiesValidate
    end
    object btnConAbrCof: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma abrevia'#231#227'o'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'COFSAI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConAbrCofPropertiesValidate
    end
    object btnConDiversos: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um registro'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADDIV'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConDiversosPropertiesValidate
    end
    object btnConCidade: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma cidade'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADCID'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConCidadePropertiesValidate
    end
    object btnConMarcas: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma marca'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADMAR'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConMarcasPropertiesValidate
    end
    object btnConUnidade: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar uma unidade'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADUNI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConUnidadePropertiesValidate
    end
    object edtSenha255: TcxEditRepositoryTextItem
      Properties.EchoMode = eemPassword
      Properties.MaxLength = 255
      Properties.PasswordChar = '*'
      Properties.ReadOnly = False
    end
    object rdgCndPra: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Todas as Condi'#231#245'es de Pagamento podem ser praticadas'
          Value = '1'
        end
        item
          Caption = 'Nenhuma Condi'#231#227'o de Pagamento pode ser praticada'
          Value = '2'
        end>
    end
    object spnValInt_Tam_4: TcxEditRepositorySpinItem
      Properties.AssignedValues.MinValue = True
      Properties.MaxValue = 9999.000000000000000000
      Properties.ValueType = vtInt
      Properties.OnValidate = spnValInt_Tam_4PropertiesValidate
    end
    object rdgSaiTsl: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Exibir somente os produtos sem estoque dispon'#237'vel.'
          Value = '1'
        end
        item
          Caption = 
            'Exibir todos os produtos, identificando em vermelho os produtos ' +
            'sem estoque dispon'#237'vel e em azul os produtos com estoque dispon'#237 +
            'vel.'
          Value = '2'
        end>
    end
    object rdgPRBAMB: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'CASO A DUPLICATA POSSUA DESMEMBRAMENTO, GRAVAR UM REGISTRO BANCA' +
            'RIO POR DESMEMBRAMENTO DA DUPLICATA.'
          Value = '1'
        end
        item
          Caption = 
            'CASO A DUPLICATA POSSUA DESMEMBRAMENTO, GRAVAR UM REGISTRO BANCA' +
            'RIO POR DUPLICATA, INDEPENDENTE DO N'#218'MERO DE DESMEMBRAMENTOS.'
          Value = '2'
        end>
    end
    object rdgOpcMetVenVal: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Linha/Grupo'
          Value = 'L'
        end
        item
          Caption = 'Marca'
          Value = 'M'
        end>
    end
    object rdgTipTraCC: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = #192' Vista'
          Value = 'V'
        end
        item
          Caption = 'A Prazo'
          Value = 'P'
        end
        item
          Caption = 'Ambas'
          Value = 'A'
        end>
    end
    object rdgFolhaA4_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Folha A4 com picote no meio'
          Value = '1'
        end
        item
          Caption = 'Folha A4 comum'
          Value = '2'
        end>
    end
    object btnSeqCom: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Clique aqui para alterar a sequ'#234'ncia das comiss'#245'es'
          Default = True
          Hint = 'Clique aqui para alterar a sequ'#234'ncia das comiss'#245'es'
          Kind = bkText
          LeftAlignment = True
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnConOcorrencia: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecione uma ocorr'#234'ncia'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADOCO'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConOcorrenciaPropertiesValidate
    end
    object rdgMetPed: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Metas por Pedido de Compra por Comprador por Empresa'
          Value = '1'
        end
        item
          Caption = 'Metas por Pedido de Compra por Despesas por Empresa'
          Value = '2'
        end
        item
          Caption = 
            'Metas por Pedido de Compra por Comprador Geral para todas as Emp' +
            'resas'
          Value = '3'
        end
        item
          Caption = 
            'Metas por Pedido de Compra por Despesas Geral para todas as Empr' +
            'esas'
          Value = '4'
        end>
    end
    object rdgExiImp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra + Impostos + Impostos de Sa'#237'da'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra + Impostos'
          Value = '2'
        end>
    end
    object rdgNfTeAu: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Nota Fiscal'
          Value = '1'
        end
        item
          Caption = 'Transfer'#234'ncia de Estoque'
          Value = '2'
        end>
    end
    object rdgModGer_1_2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgEmpOriFat: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Faturamento'
          Value = '1'
        end
        item
          Caption = 'Origem'
          Value = '2'
        end>
    end
    object rdgModRin: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo-1'
          Value = '1'
        end
        item
          Caption = 'Modelo-2'
          Value = '2'
        end
        item
          Caption = 'Modelo-3'
          Value = '3'
        end>
    end
    object rdgSMSCRM: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end>
    end
    object rdgModGeracaoArqAcordoRes: TcxEditRepositoryRadioGroupItem
      Properties.DefaultValue = 1
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgEstAju: TcxEditRepositoryRadioGroupItem
      Properties.DefaultValue = 1
      Properties.Items = <
        item
          Caption = 
            'A loja conta os itens em garantia n'#227'o enviados para o fornecedor' +
            ' junto com os itens sem defeito. O Sistema deve considerar somen' +
            'te a contagem digitada.'
          Value = '1'
        end
        item
          Caption = 
            'A loja n'#227'o conta os itens em garantia n'#227'o enviados para o fornec' +
            'edor. O Sistema deve somar o saldo reservado de garantia na cont' +
            'agem digitada.'
          Value = '2'
        end>
    end
    object rdgPromoOpVenda: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Todas as Opera'#231#245'es de Venda'
          Value = '1'
        end
        item
          Caption = 'Somente Opera'#231#245'es de Venda N'#227'o Entrega Futura'
          Value = '2'
        end>
    end
    object btnOpen_SATCFe: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique para abrir as configura'#231#245'es'
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgImpGro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Impress'#227'o laser em papel A4'
          Value = '1'
        end
        item
          Caption = 'Impress'#227'o matricial em formul'#225'rio cont'#237'nuo'
          Value = '2'
        end>
    end
    object btnConLayout: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ImeName = 'LAYETI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConLayoutPropertiesValidate
    end
    object rdgPreEmb: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o fixo, informado na aba de embalagens'
          Value = '1'
        end
        item
          Caption = 
            'Combo com tabelas de pre'#231'o dispon'#237'veis, informando na aba de emb' +
            'alagens'
          Value = '2'
        end>
    end
    object rdgCupEnt: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Cupom + Nota'
          Value = '1'
        end
        item
          Caption = 'Cupom + Cupom'
          Value = '2'
        end>
    end
    object cxInter0_360: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.OnValidate = cxRepositorioCurrencyItem1PropertiesValidate
    end
    object rdgCusCom: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
          Value = 'PRECUS'
        end
        item
          Caption = 'Pre'#231'o de Compra Liquido'
          Value = 'COMLIQ'
        end>
    end
    object rdgTpSped: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Igual para todas as empresas'
          Value = '1'
        end
        item
          Caption = 'Uma para cada empresa'
          Value = '2'
        end>
    end
    object rdgRelSepMerOpc: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - SOMAR os produtos separados do operador.'
          Value = '1'
        end
        item
          Caption = '2 - CONTAR os produtos separados do operador.'
          Value = '2'
        end>
    end
    object cmbRelacionaCliPro: TcxEditRepositoryCheckGroupItem
      Properties.Items = <
        item
          Caption = 'teste'
        end
        item
          Caption = 'srsddsfdsf'
        end
        item
          Caption = 'sdfsffs'
        end>
      Properties.OnEditValueToStates = cmbRelacionaCliProPropertiesEditValueToStates
      Properties.OnStatesToEditValue = cmbRelacionaCliProPropertiesStatesToEditValue
    end
    object rdgImpCai: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Etiqueta de Despacho'
          Value = '1'
        end
        item
          Caption = 'Listagem com caixas e produtos no final da expedi'#231#227'o. '
          Value = '2'
        end>
    end
    object rdgSimNao_S_N_NCSUG: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o, sem sugest'#227'o de peso'
          Value = 'N'
        end
        item
          Caption = 'N'#227'o, com sugest'#227'o de peso'
          Value = 'G'
        end>
    end
    object rdgSeqCai: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Sequencial crescente geral para todas as caixas.'
          Value = '1'
        end
        item
          Caption = 'N'#250'mero do pedido de venda + sequencial de caixas por pedido.'
          Value = '2'
        end>
    end
    object rdgModImpSAT: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = 1
        end
        item
          Caption = 'Modelo 2'
          Value = 2
        end>
    end
    object rdgEspCar: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Cupom Fiscal / NFCe / SAT-CFe'
          Value = '1'
        end
        item
          Caption = 'Nota Fiscal'
          Value = '2'
        end
        item
          Caption = 'Cupom Fiscal / NFCe / SAT-CFe / Nota Fiscal'
          Value = '3'
        end>
    end
    object rdgMdOrIn: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Um'
          Value = '1'
        end
        item
          Caption = 'Dois'
          Value = '2'
        end
        item
          Caption = 'Tr'#234's'
          Value = '3'
        end
        item
          Caption = 'Quatro'
          Value = '4'
        end
        item
          Caption = 'Cinco'
          Value = '5'
        end
        item
          Caption = 'Seis'
          Value = '6'
        end
        item
          Caption = 'Sete'
          Value = '7'
        end
        item
          Caption = 'Oito'
          Value = '8'
        end>
    end
    object rdgLibeTE: TcxEditRepositoryRadioGroupItem
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Imediatamente, a cada produto digitado.'
          Value = '1'
        end
        item
          Caption = 
            'Manualmente, pelo menu UTIL >> OPERA'#199#213'ES REFERENTE A PRODUTOS >>' +
            ' LIBERA'#199#195'O DA PREPARA'#199#195'O DE TRANSFER'#202'NCIA DE ESTOQUE.'
          Value = '2'
        end>
    end
    object rdgTamQrCode: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Pequeno'
          Value = 'P'
        end
        item
          Caption = 'M'#233'dio'
          Value = 'M'
        end
        item
          Caption = 'Grande'
          Value = 'G'
        end>
    end
    object chkTPSPPV: TcxEditRepositoryCheckGroupItem
      Properties.Items = <
        item
          Caption = 'Retira'
        end
        item
          Caption = 'Entrega Imediata'
        end
        item
          Caption = 'Entrega Futura'
        end>
      Properties.OnEditValueToStates = chkTPSPPVPropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkTPSPPVPropertiesStatesToEditValue
    end
    object rdgPreOri: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'PRECOTABELA'
          Value = '1'
        end
        item
          Caption = 'PRECOORIGINAL'
          Value = '2'
        end>
    end
    object btnCliAti: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Adicionar/Remover Atividades'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgTipImp_L_A_Z: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Laser'
          Value = 'L'
        end
        item
          Caption = 'Argox'
          Value = 'A'
        end
        item
          Caption = 'Zebra'
          Value = 'Z'
        end>
    end
    object btnCadProvedorEmail: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Cadastrar os provedores de e-mail'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object edtTexto_Tam255: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 255
      Properties.ValidateOnEnter = True
    end
    object edtCodSeq_Tam_12: TcxEditRepositoryTextItem
      Properties.MaxLength = 12
      Properties.OnValidate = edtCodSeq_Tam_12PropertiesValidate
    end
    object btnConLayOrc: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Seleciona o Formul'#225'rio'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'LAYETI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnConLayPed: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecione o Formul'#225'rio'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'LAYETI'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgImpSepPor: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Faturamento'
          Value = 'F'
        end
        item
          Caption = 'Expedi'#231#227'o'
          Value = 'E'
        end>
    end
    object rdgTipoBaixaOrdemProducaoIndustrial: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - Formula'#231#227'o da estrutura ativa'
          Value = '1'
        end
        item
          Caption = '2 - Formula'#231#227'o usada na inclus'#227'o da Ordem de Produ'#231#227'o'
          Value = '2'
        end>
    end
    object rdgSugestaoTipOrdemProducao: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1-Entrar sempre no c'#225'lculo da An'#225'lise de Produ'#231#227'o'
          Value = '1'
        end
        item
          Caption = 
            '2-Entrar no c'#225'lculo da An'#225'lise de Produ'#231#227'o, somente se tiver Ped' +
            'ido de Venda pendente, independente do Giro de Estoque no per'#237'od' +
            'o [ Produtos de Venda Casada ]'
          Value = '2'
        end>
    end
    object rdgLay_Cp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Meia Folha'
          Value = '1'
        end
        item
          Caption = 'Folha Inteira'
          Value = '2'
        end
        item
          Caption = 'Folha Inteira, com 3 por p'#225'gina.'
          Value = '3'
        end>
    end
    object rdgVenPreDenFor: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Interno'
          Value = 'D'
        end
        item
          Caption = 'Interestadual'
          Value = 'F'
        end>
    end
    object rdgCifFobTablet: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'CIF (Emitente - Empresa)'
          Value = 'CIF'
        end
        item
          Caption = 'FOB (Destinat'#225'rio - Cliente)'
          Value = 'FOB'
        end
        item
          Caption = 'De acordo com enviado pelo Tablet'
          Value = 'TABLET'
        end>
    end
    object opcIMPNSE: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end
        item
          Caption = 'Sim - junto a separa'#231#227'o'
          Value = 'S'
        end
        item
          Caption = 'Sim - Folha separada, outra separa'#231#227'o'
          Value = 'F'
        end>
    end
    object rdgImpOnu: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Imprimir Mensagem ONU:'
      Properties.Items = <
        item
          Caption = 'Nos dados adicionais da NFe'
          Value = 'A'
        end
        item
          Caption = 'Abaixo dos Itens'
          Value = 'I'
        end>
    end
    object rdgTPCOSE: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - Comiss'#227'o geral, cadastrada na configura'#231#227'o [CFG_PCOMSR].'
          Value = '1'
        end
        item
          Caption = '2 - Comiss'#227'o por servi'#231'o, cadastrada no cadastro de servi'#231'os.'
          Value = '2'
        end>
    end
    object rdgApenasRetira: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Por Empresa'
          Value = 'E'
        end
        item
          Caption = 'Igual para Todas'
          Value = 'T'
        end>
    end
    object mskClaDem: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.EditMask = 
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999;0;_'
    end
    object spnDia_1_31: TcxEditRepositorySpinItem
      Properties.MaxValue = 31.000000000000000000
      Properties.MinValue = 1.000000000000000000
    end
    object rdgModRcx: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgDevRom: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o listar nenhum tipo de devolu'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Listar apenas Devolu'#231#245'es (DV/NF)'
          Value = '2'
        end
        item
          Caption = 'Listar apenas Pedidos de Devolu'#231#227'o para Retirada (PR)'
          Value = '3'
        end
        item
          Caption = 'Listar todos os tipos de Devolu'#231#227'o (DV/NF/PR)'
          Value = '4'
        end>
    end
    object rdgModRcm: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Modelo 1'
          Value = '1'
        end
        item
          Caption = 'Modelo 2'
          Value = '2'
        end>
    end
    object rdgMarcadoDesmarcado: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Marcado'
          Value = 'M'
        end
        item
          Caption = 'Desmarcado'
          Value = 'D'
        end>
    end
    object rdgTpDcEn: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#250'mero do Documento'
          Value = '1'
        end
        item
          Caption = 'C'#243'digo de Barras'
          Value = '2'
        end>
    end
    object rdgSfaEst: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Importar apenas os sub-itens rateando neles o valor vindo do Tab' +
            'let/Site'
          Value = 'S'
        end
        item
          Caption = 'Importar apenas o item estrutura'
          Value = 'P'
        end>
    end
    object rdgFreIpi: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Valor total do produto - Desconto Especial'
          Value = '1'
        end
        item
          Caption = 
            'Valor cont'#225'bil do produto ( VR.PRODUTO + IPI + ST + DESP.ACESS'#211'R' +
            'IA - DESCONTO ESPECIAL)'
          Value = '2'
        end>
    end
    object rdgLibCnd: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Exibir somente as condi'#231#245'es de pagamento que est'#227'o satisfazendo ' +
            'as regras. Neste caso, n'#227'o '#233' possivel praticar condi'#231#245'es diferen' +
            'tes das listadas na consulta.'
          Value = '1'
        end
        item
          Caption = 
            'Exibir todas as condi'#231#245'es de pagamento e solicitar senha de libe' +
            'ra'#231#227'o se o vendedor tentar utilizar uma n'#227'o permitida.'
          Value = '2'
        end>
    end
    object chkMarCam: TcxEditRepositoryCheckGroupItem
      Properties.Columns = 2
      Properties.EditValueFormat = cvfStatesString
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
        end
        item
          Caption = 'Margem Bruta'
        end
        item
          Caption = 'Margem L'#237'quida'
        end
        item
          Caption = 'Total Produtos Pre'#231'o Tabela'
        end
        item
          Caption = 'Custo Real'
        end
        item
          Caption = 'Custo Real com Margem Zero'
        end
        item
          Caption = 'Margem Bruta em Valor'
        end
        item
          Caption = 'Margem L'#237'quida em Valor'
        end
        item
          Caption = 'Margem L'#237'quida sem despesa operacional em percentual'
        end
        item
          Caption = 'Margem L'#237'quida sem despesa operacional em valor'
        end>
      Properties.WordWrap = True
      Properties.OnEditValueToStates = chkMarCamPropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkMarCamPropertiesStatesToEditValue
    end
    object rdgCreGar: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - No ato do recebimento do produto em garantia'
          Value = '1'
        end
        item
          Caption = '2 - Ap'#243's libera'#231#227'o pela tela de Libera'#231#227'o de Cr'#233'dito de Garantia'
          Value = '2'
        end>
    end
    object rdgEmpGer_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = '1 - Empresa que est'#225' agrupando'
          Value = '1'
        end
        item
          Caption = 
            '2 - Empresa das duplicatas selecionadas (Se forem selecionadas d' +
            'uplicatas de empresas diferentes, ser'#225' considerada a empresa que' +
            ' est'#225' agrupando)'
          Value = '2'
        end
        item
          Caption = 
            '3 - Empresa das duplicatas selecionadas (Se forem selecionadas d' +
            'uplicatas de empresas diferentes, ser'#225' gerado um agrupamento par' +
            'a cada empresa)'
          Value = '3'
        end
        item
          Caption = '4 - Empresa do cadastro de vendendor utilizado no agrupamento'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgOpeAgr_1_2_3: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Vendedor do cadastro do cliente'
          Value = '1'
        end
        item
          Caption = 'Vendedor informado na rotina de agrupamento'
          Value = '2'
        end
        item
          Caption = 
            'Vendedor das duplicatas agrupadas (havendo mais de um, considera' +
            ' o vendedor da duplicata de maior valor)'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rgbIndGlobal: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultValue = '1'
      Properties.Items = <
        item
          Caption = 'Individual'
          Value = '1'
        end
        item
          Caption = 'Global'
          Value = '2'
        end>
    end
    object rdgUmTeMp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'N'#227'o utilizar importa'#231#227'o multi empresas (O pedido ser'#225' sempre imp' +
            'ortado para a empresa logada no momento da importa'#231#227'o).'
          Value = '1'
        end
        item
          Caption = 
            'Utilizando o conceito de multi lojas, com entrega pelo CD (Os pe' +
            'didos s'#227'o importados com o sequencial da empresa logada, por'#233'm d' +
            'estinado '#224' empresa CD)'
          Value = '2'
        end
        item
          Caption = 
            'Importando os pedidos para sua pr'#243'pria empresa (O pedido ser'#225' im' +
            'portado para a empresa definida no FSPEDIDOCAB.CODIGOEMPRESA. Es' +
            'ta op'#231#227'o somente poder'#225' ser utlizada para clientes que N'#195'O usam ' +
            'replica'#231#227'o.'
          Value = '3'
        end>
      Properties.WordWrap = True
    end
    object rdgEquRea: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'No ato, ao marcar como REALIZADA.'
          Value = '1'
        end
        item
          Caption = 'Posteriormente, na altera'#231#227'o da OS.'
          Value = '2'
        end>
    end
    object rdgModBolAgr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Modelo com 3 partes iguais ( Ficha de Caixa, Recibo do Pagador e' +
            ' Ficha de Compensa'#231#227'o )'
          Value = '1'
        end
        item
          Caption = 
            'Modelo com 2 partes iguais ( Ficha de Caixa e Ficha de Compensa'#231 +
            #227'o ) mais Demonstrativo de agrupamento'
          Value = '2'
        end>
    end
    object edtTexto_Tam4: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 4
    end
    object edtTexto_Tam10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
    end
    object chkBanVen: TcxEditRepositoryCheckGroupItem
      Properties.Columns = 3
      Properties.EditValueFormat = cvfStatesString
      Properties.Items = <
        item
          Caption = 'Combos de Venda'
        end
        item
          Caption = 'Promo'#231#245'es'
        end
        item
          Caption = 'Estruturas'
        end
        item
          Caption = 'Novos Produtos'
        end>
    end
    object mskCrePgc: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999;0;_'
    end
    object rdgConsultaSCPC: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'PHD Risk'
          Value = 'P'
        end
        item
          Caption = 'Boa Vista Servi'#231'os'
          Value = 'B'
        end
        item
          Caption = 'Boa Vista Servi'#231'os - ES'
          Value = 'E'
        end
        item
          Caption = 'Boa Vista Servi'#231'os - ACERTA'
          Value = 'A'
        end>
    end
    object btnEmailAutSaida: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique para Abrir a Configura'#231#227'o'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgSCLNVT: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Ativo'
          Value = 'A'
        end
        item
          Caption = 'Inativo'
          Value = 'I'
        end
        item
          Caption = 'De acordo com o enviado pelo Site/Tablet'
          Value = 'T'
        end>
      Properties.WordWrap = True
    end
    object cxRadioVenCliCon: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Utilizar vendedor da configura'#231#227'o (CFG_VENNOV - Vendedor para no' +
            'vos clientes)'
          Value = '1'
        end
        item
          Caption = 'Utilizar operador logado no sistema'
          Value = '2'
        end>
    end
    object cxRadioRepCliCon: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Utilizar representante da configura'#231#227'o (CFG_REPNOV - Representan' +
            'te para novos clientes)'
          Value = '1'
        end
        item
          Caption = 'Utilizar operador logado no sistema'
          Value = '2'
        end>
    end
    object rdgTipoBaixaControleEntregadores: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Opera'#231#227'o cega - Operador n'#227'o consegue ver os documentos vinculad' +
            'os '#224' entrega'
          Value = '1'
        end
        item
          Caption = 
            'Opera'#231#227'o r'#225'pida - Operador pode ver os documentos vinculado '#224' en' +
            'trega fazer a baixa por entrega (geral)'
          Value = '2'
        end>
    end
    object rdgDefaultExpSite: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Original'
          Value = 'O'
        end
        item
          Caption = 'Sempre "Sim"'
          Value = 'S'
        end
        item
          Caption = 'Sempre "N'#227'o"'
          Value = 'N'
        end>
    end
    object mmoMsgPCG: TcxEditRepositoryMemoItem
      Properties.MaxLength = 210
      Properties.VisibleLineCount = 3
      Properties.WordWrap = False
    end
    object rdgOpeAdi: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Subtrair'
          Value = '-'
        end
        item
          Caption = 'Adicionar'
          Value = '+'
        end>
    end
    object rdgAjuEst_ModoContagem: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Acumular a quantidade informada com a j'#225' digitada anteriormente.' +
            ' '
          Value = '1'
        end
        item
          Caption = 
            'Sobrepor a quantidade informada sobre a quantidade digitada ante' +
            'riormente. '
          Value = '2'
        end>
    end
    object edtTextoSemCase: TcxEditRepositoryTextItem
    end
    object rdgTpspfn: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Imprimir separando por Pedido de Venda, listando todos os produt' +
            'os do pedido.'
          Value = '1'
        end
        item
          Caption = 
            'Imprimir separando por Pedido de Venda e Setor, listando uma sep' +
            'ara'#231#227'o para cada setor diferente.'
          Value = '2'
        end>
    end
    object rdgTipCalcCat158: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Pelas tags <pCredSN> e <vCredICMSSN> da ( DETELE ) do XML da Not' +
            'a de Entrada'
          Value = '0'
        end
        item
          Caption = 'Pela al'#237'quota interna do estado emitente da Nota de Entrada'
          Value = '1'
        end>
    end
    object rdgInfoMedVidro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Largura e Altura'
          Value = '1'
        end
        item
          Caption = 'Largura e Comprimento'
          Value = '2'
        end>
    end
    object rdgConRemBan_C_G: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Carteira'
          Value = 'C'
        end
        item
          Caption = 'Geral'
          Value = 'G'
        end>
      Properties.WordWrap = True
    end
    object rdgAtuAdb: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'N'#227'o atualizar, mantendo o que esta'#180' gravado no Cadastro de Produ' +
            'tos'
          Value = 'N'
        end
        item
          Caption = 
            'Atualizar com o valor informado no Cadastro de  Produtos no ato ' +
            'da Entrada de Mercadorias'
          Value = 'S'
        end
        item
          Caption = 
            'Atualizar com a diferen'#231'a entre al'#237'quota de icms interna do esta' +
            'do de destino e a al'#237'quota de icms praticada pelo fornecedor, no' +
            ' ato da Entrada de Mercadorias '
          Value = 'D'
        end>
    end
    object edtValOci: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ' ,0.0000;( ,0.0000)'
      Properties.EditFormat = '#,####0.0000'
    end
    object rdgClcMFr: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - (FRESUG - TOTFRE)'
          Value = '1'
        end
        item
          Caption = '2 - (TOTFRE - FRESUG)'
          Value = '2'
        end>
    end
    object rdgGnreRateio: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Trazer o valor de cada produto distribu'#237'do proporcionalmente con' +
            'forme pre'#231'o da entrada.'
          Value = '1'
        end
        item
          Caption = 
            'Trazer o valor zero, para que o operador informe conforme c'#225'lcul' +
            'o do IVA.'
          Value = '2'
        end>
    end
    object rdgMesMos: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '3'
          Value = '3'
        end
        item
          Caption = '6'
          Value = '6'
        end
        item
          Caption = '12'
          Value = '12'
        end>
    end
    object rdgMesGir: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Mostrar 12 meses, com os meses escolhidos para giro destacados e' +
            'm vermelho'
          Value = '1'
        end
        item
          Caption = 'Mostrar somente os meses escolhidos para giro'
          Value = '2'
        end>
    end
    object rdgTBETID: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1) Software de Log'#237'stica PROFIT'
          Value = '1'
        end
        item
          Caption = 'Software FUSION DMS'
          Value = '2'
        end>
    end
    object edtTexto_Tam15: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 15
    end
    object btnConCadTpa: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um tipo de atendimento'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADTPA'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConCadTpaPropertiesValidate
    end
    object rdgTipoAltPrecoFranq: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
          Value = '0'
        end
        item
          Caption = 'Pre'#231'o de Custo, Alterando Margem de Lucro'
          Value = '1'
        end
        item
          Caption = 'Pre'#231'o de Venda, Alterando Margem de Lucro'
          Value = '2'
        end>
    end
    object rdgComFra: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Arredondar para cima ( 1.1 | 1.5 | 1.9 | = 2.00)'
          Value = '+'
        end
        item
          Caption = 'Arredondar para baixo ( 1.1 | 1.5 | 1.9 | = 1.00)'
          Value = '-'
        end
        item
          Caption = 
            'Informar, NA BAIXA, que existe itens nessa condi'#231#227'o e solicitar ' +
            'que o usu'#225'rio informe a quantidade correta'
          Value = '?'
        end>
    end
    object chgOpcIteSpo: TcxEditRepositoryCheckGroupItem
      Properties.EditValueFormat = cvfStatesString
      Properties.GlyphCount = 4
      Properties.Items = <
        item
          Caption = 'Or'#231'amento'
        end
        item
          Caption = 'Pedido'
        end
        item
          Caption = 'Venda'
        end
        item
          Caption = 'Outras Sa'#237'das/Entradas'
        end>
      Properties.WordWrap = True
      Properties.OnEditValueToStates = chgOpcIteSpoPropertiesEditValueToStates
      Properties.OnStatesToEditValue = chgOpcIteSpoPropertiesStatesToEditValue
    end
    object rdgLFP012: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Liberado'
          Value = 'L'
        end
        item
          Caption = 'Bloqueado'
          Value = 'B'
        end>
    end
    object rdgImpLib: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'No momento da Importa'#231#227'o'
          Value = 'I'
        end
        item
          Caption = 'No momento da Libera'#231#227'o de Pagamento'
          Value = 'L'
        end>
    end
    object rdgATIMSE: TcxEditRepositoryRadioGroupItem
      Properties.DefaultValue = '1'
      Properties.Items = <
        item
          Caption = 
            '1 - Seguir o valor da configura'#231#227'o '#39'CFG_PEIMSE - Perguntar se im' +
            'prime separa'#231#227'o?'#39'.'
          Value = '1'
        end
        item
          Caption = '2 - Imprimir automaticamente, sem perguntar.'
          Value = '2'
        end
        item
          Caption = '3 - N'#227'o imprimir.'
          Value = '3'
        end>
    end
    object rdgExpPedNomArq: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'PEDIDO_ + data(DDMM)  + Sequencial.'
          Value = '1'
        end
        item
          Caption = 'PEDIDO_ + Empresa + Numero do Pedido.'
          Value = '2'
        end>
    end
    object rdgTipoFolha: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Meia Folha'
          Value = '1'
        end
        item
          Caption = 'Folha Inteira'
          Value = '2'
        end>
    end
    object rdgVALEXP: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Manuten'#231#227'o'
          Value = '1'
        end
        item
          Caption = 'Realizada'
          Value = '2'
        end>
    end
    object rdgPraPagDupMerc: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Cidade do cliente.'
          Value = '1'
        end
        item
          Caption = 'Cidade da empresa.'
          Value = '2'
        end>
    end
    object mskCodOpe: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        'CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-' +
        'CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC-' +
        'CCC-CCC-CCC-CCC-CCC-CCC-CCC-CCC;0;_'
    end
    object rdgAgregadoVenda: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Se for informado um PAI, sugere todos os filhos. Se for informad' +
            'o um FILHO, sugere todos os pais.'
          Value = 1
        end
        item
          Caption = 
            'Se for informado um PAI, sugere todos os filhos. Se for informad' +
            'o um FILHO, n'#227'o sugere nenhum produto.'
          Value = 2
        end>
    end
    object btnPatSnd: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ImeMode = imOpen
    end
    object btnPatArq: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ImeMode = imOpen
    end
    object rdgImpPreNfe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Imprimir o valor l'#237'quido, depois de aplicado desconto em percent' +
            'ual informado pelo vendedor'
          Value = '1'
        end
        item
          Caption = 'Imprimir o valor de tabela, coluna desconto e o valor l'#237'quido'
          Value = '2'
        end>
    end
    object rdgTplRec: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Mapeamento da Classe de Local'
          Value = 'C'
        end
        item
          Caption = 
            'Local de Separa'#231#227'o + Volume Cubico do Cadastro de Embalagens (La' +
            'stro * Camada)'
          Value = 'L'
        end
        item
          Caption = 'N'#227'o Utiliza Coletor'
          Value = 'N'
        end>
    end
    object rdgopcaoEmpresaLibPedCom: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Somente da empresa logada'
          Value = '1'
        end
        item
          Caption = 'De todas as empresas'
          Value = '2'
        end>
    end
    object rdgTipSen_V_U: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Vari'#225'vel'
          Value = 'V'
        end
        item
          Caption = 'Usu'#225'rio'
          Value = 'U'
        end>
      Properties.WordWrap = True
    end
    object rdgVersaoSSL_TLS: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 6
      Properties.Items = <
        item
          Caption = 'SSL vs 2.0'
          Value = 'sslvSSLv2'
        end
        item
          Caption = 'SSL vs 2.3'
          Value = 'sslvSSLv23'
        end
        item
          Caption = 'SSL vs 3.0'
          Value = 'sslvSSLv3'
        end
        item
          Caption = 'TLS vs 1.0'
          Value = 'sslvTLSv1'
        end
        item
          Caption = 'TLS vs 1.1'
          Value = 'sslvTLSv1_1'
        end
        item
          Caption = 'TLS vs 1.2'
          Value = 'sslvTLSv1_2'
        end>
    end
    object rdgMedEmp: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            '1 - Igual para todas as empresas, considerando a soma do estoque' +
            ' de todas as empresas'
          Value = '1'
        end
        item
          Caption = 
            '2 - Individual por empresa, considerando o estoque da empresa de' +
            ' entrada'
          Value = '2'
        end>
    end
    object btnConServico: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecionar um servi'#231'o'
          Default = True
          Kind = bkText
        end>
      Properties.ImeName = 'CADSER'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConServicoPropertiesValidate
    end
    object chkEstados: TcxEditRepositoryCheckGroupItem
      Properties.Columns = 3
      Properties.EditValueFormat = cvfStatesString
      Properties.Items = <
        item
          Caption = 'AC'
        end
        item
          Caption = 'AM'
        end
        item
          Caption = 'RR'
        end
        item
          Caption = 'RO'
        end
        item
          Caption = 'AP'
        end
        item
          Caption = 'PA'
        end
        item
          Caption = 'TO'
        end
        item
          Caption = 'MA'
        end
        item
          Caption = 'PI'
        end
        item
          Caption = 'CE'
        end
        item
          Caption = 'RN'
        end
        item
          Caption = 'PB'
        end
        item
          Caption = 'PE'
        end
        item
          Caption = 'AL'
        end
        item
          Caption = 'SE'
        end
        item
          Caption = 'BA'
        end
        item
          Caption = 'MT'
        end
        item
          Caption = 'GO'
        end
        item
          Caption = 'DF'
        end
        item
          Caption = 'MS'
        end
        item
          Caption = 'MG'
        end
        item
          Caption = 'ES'
        end
        item
          Caption = 'RJ'
        end
        item
          Caption = 'SP'
        end
        item
          Caption = 'PR'
        end
        item
          Caption = 'SC'
        end
        item
          Caption = 'RS'
        end>
      Properties.OnEditValueToStates = chkEstadosPropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkEstadosPropertiesStatesToEditValue
    end
    object rdgTipoVendedor: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'do Vendedor do Pedido'
          Value = '1'
        end
        item
          Caption = 'do Vendedor-2 do Pedido'
          Value = '2'
        end>
    end
    object rdgClienteRede: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Individual, pelo cliente'
          Value = '1'
        end
        item
          Caption = 'Coletivo, pela rede de lojas'
          Value = '2'
        end>
    end
    object btnConRota: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ImeName = 'ENTREG'
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
      Properties.OnValidate = btnConRotaPropertiesValidate
    end
    object rdgCtrHis: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Cliente'
          Value = '1'
        end
        item
          Caption = 'Hist'#243'rico Digitado'
          Value = '2'
        end>
    end
    object rdgSfaDta: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Data/hora que o pedido foi digitado no tablet, considerando camp' +
            'os DATAPEDIDO e HORAFINAL da tabela FSPEDIDOCAB'
          Value = '1'
        end
        item
          Caption = 'Data/hora do momento da importa'#231#227'o.'
          Value = '2'
        end>
    end
    object btnConfigSMS: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Cadastrar os gatilhos de envio de SMS'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object edtSenhaSms: TcxEditRepositoryTextItem
      Properties.EchoMode = eemPassword
      Properties.LookupItems.Strings = (
        '')
      Properties.MaxLength = 25
      Properties.PasswordChar = '*'
      Properties.ReadOnly = False
    end
    object edtUsrSms: TcxEditRepositoryTextItem
    end
    object rdgUndTinES: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'GR'
          Value = 'GR'
        end
        item
          Caption = 'ML'
          Value = 'ML'
        end>
    end
    object rdgPreTinES: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'PRE'#199'O DE VENDA'
          Value = 'PRE'#199'O DE VENDA'
        end
        item
          Caption = 'PRE'#199'O DE CUSTO'
          Value = 'PRE'#199'O DE CUSTO'
        end>
    end
    object rdgLogGru: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Somente para a loja logada'
          Value = '1'
        end
        item
          Caption = 'Para todos as lojas do grupo'
          Value = '2'
        end>
    end
    object rdgZerBri: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1) imprimir o brinde com valor zero.'
          Value = '1'
        end
        item
          Caption = 
            '2) imprimir o brinde com valor determinado pela configura'#231#227'o [CF' +
            'G_SUG_BR]'
          Value = '2'
        end>
    end
    object rdgDataPadrao: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Em branco'
          Value = '1'
        end
        item
          Caption = 'Data Atual'
          Value = '2'
        end>
    end
    object edtDec3Dig: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 3
      Properties.DisplayFormat = ',0.000;-,0.000'
      Properties.EditFormat = '0.000'
    end
    object rdgFreDev: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1) Somente valor da mercadoria'
          Value = '1'
        end
        item
          Caption = '2) Valor cont'#225'bil da nota fiscal'
          Value = '2'
        end>
    end
    object rdgIntegraBV: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Cadastral (Texto)'
          Value = 'cadastral'
        end
        item
          Caption = 'Restritivo (PDF)'
          Value = 'restritivo'
        end
        item
          Caption = 'Empresarial Gold (PDF)'
          Value = 'emp_gold'
        end
        item
          Caption = 'Empresarial Platinum (PDF)'
          Value = 'emp_platinum'
        end>
    end
    object rdgVerNfe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '3.10'
          Value = '3.10'
        end
        item
          Caption = '4.00'
          Value = '4.00'
        end>
    end
    object rdgRegAnt: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1) Permitir utilizar somente pagamentos da empresa logada.'
          Value = '1'
        end
        item
          Caption = '2) Permitir utilizar pagamentos de todas as empresas'
          Value = '2'
        end>
    end
    object rdgOuSaFo: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Emitir nota fiscal diretamente, movimentando estoque e gerando l' +
            'ivro fiscal'
          Value = '1'
        end
        item
          Caption = 
            'Gravar espelho para que seja avaliado pelo fornecedor e posterio' +
            'rmente efetivado em nota fiscal ( a movimenta'#231#227'o de estoque e li' +
            'vro fiscal ocorrer'#225' na efetiva'#231#227'o )'
          Value = '2'
        end>
    end
    object btnFpjAti: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnFpfAti: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object btnOcoFid: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object mskCodEmp: TcxEditRepositoryMaskItem
      Properties.AutoSelect = False
      Properties.CharCase = ecUpperCase
      Properties.EditMask = 
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
        '999-999-999-999-999-999-999-999;0;_'
    end
    object rdgEmpFid: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Apenas da Loja'
          Value = '1'
        end
        item
          Caption = 'Todas as Lojas'
          Value = '2'
        end>
    end
    object rdgRepVen2: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Representante'
          Value = '1'
        end
        item
          Caption = 'Vendedor-2'
          Value = '2'
        end>
    end
    object rdgTipoRedeCard: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.DefaultValue = 'VAN'
      Properties.Items = <
        item
          Caption = 'VAN'
          Value = 'VAN'
        end
        item
          Caption = 'Site (CSV)'
          Value = 'SITE'
        end>
    end
    object rdgSitEmp: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Igual para todas as empresas'
          Value = '1'
        end
        item
          Caption = 'Uma para cada empresa'
          Value = '2'
        end>
    end
    object btnBloFil: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ViewStyle = vsButtonsOnly
    end
    object rdgSimNaoBloFil: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultValue = 'N'
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end>
    end
    object btnEmailAutEntrada: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Clique para Abrir a Configura'#231#227'o'
          Default = True
          Kind = bkText
        end>
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgOriDia: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - Cadastro de Fornecedores'
          Value = '1'
        end
        item
          Caption = '2 - Cadastro de Produtos'
          Value = '2'
        end>
    end
    object btnFpaAti: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgBxOpPa: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end
        item
          Caption = 
            'Sim - N'#227'o Baixando a O.P. at'#233' que a quantidade seja maior ou igu' +
            'al ao total'
          Value = 'S'
        end
        item
          Caption = 'Sim - Baixando a O.P. imediatamente (Independente da Quantidade)'
          Value = 'B'
        end>
    end
    object btnCertificadoDigital: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Caption = 'Certificado Digital'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgConSim: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o utiliza'
          Value = 'N'
        end
        item
          Caption = 'Utiliza Autcom'
          Value = 'S'
        end
        item
          Caption = 'Utiliza Autcom / Coletor'
          Value = 'C'
        end>
    end
    object btnFornecedoresTigre: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Adicionar/Remover Fornecedores'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgEmpresa: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'EMPRESA LOGADA'
          Value = 'EMPRESA LOGADA'
        end
        item
          Caption = 'TODAS AS EMPRESAS'
          Value = 'TODAS AS EMPRESAS'
        end>
    end
    object rdgCestST: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - Apenas para produtos substitu'#237'dos'
          Value = '1'
        end
        item
          Caption = '2 - Todos os produtos'
          Value = '2'
        end>
    end
    object rdgTPNUAU: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '1 - N'#250'mero de Libera'#231#227'o'
          Value = '1'
        end
        item
          Caption = '2 - N'#250'mero do cupom (NSU)'
          Value = '2'
        end>
    end
    object chkGruposF4: TcxEditRepositoryCheckGroupItem
      Properties.Columns = 2
      Properties.EditValueFormat = cvfStatesString
      Properties.Items = <
        item
          Caption = 'Pre'#231'o de Custo'
        end
        item
          Caption = 'Pre'#231'o de Custo Real'
        end
        item
          Caption = 'Pre'#231'o M'#233'dio'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compra'
        end
        item
          Caption = 'Pre'#231'o de '#218'ltima Compa Mais Impostos'
        end
        item
          Caption = 'Quantidade de Venda / Saldo Dispon'#237'vel'
        end
        item
          Caption = 'Margem Ideal'
        end
        item
          Caption = 'CAT17'
        end>
      Properties.WordWrap = True
      Properties.OnEditValueToStates = chkGruposF4PropertiesEditValueToStates
      Properties.OnStatesToEditValue = chkGruposF4PropertiesStatesToEditValue
    end
    object rdgDesmPedOrc: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultValue = 'B'
      Properties.Items = <
        item
          Caption = 'Branco'
          Value = 'B'
        end
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end>
    end
    object btnOpen_TEF: TcxEditRepositoryButtonItem
      Properties.Alignment.Horz = taCenter
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object rdgALPDAD: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.Items = <
        item
          Caption = 'Sim, todos os campos'
          Value = 'S'
        end
        item
          Caption = 
            'Sim, por'#233'm somente reduzindo a quantidade dos produtos ou elimin' +
            'ando algum produto (ser'#225' gerado cr'#233'dito do valor removido)'
          Value = 'N'
        end
        item
          Caption = 'N'#227'o, nenhuma informa'#231#227'o'
          Value = 'T'
        end>
      Properties.WordWrap = True
    end
    object rdgEntEquOS: TcxEditRepositoryRadioGroupItem
      Properties.DefaultCaption = 'Entrada de equipamento:'
      Properties.Items = <
        item
          Caption = 'Anal'#237'tica'
          Value = 'A'
        end
        item
          Caption = 'Sint'#233'tica'
          Value = 'S'
        end>
      Properties.WordWrap = True
    end
    object rdgCat17: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Exibir coluna informativa em separado, com margem de lucro calcu' +
            'lada, deduzindo do custo da ST e ICMS'
          Value = 'S'
        end
        item
          Caption = 
            'Deduzir do custo principal da venda, o valor da ST e o ICMS de c' +
            'r'#233'dito da '#250'ltima nota de entrada'
          Value = 'D'
        end
        item
          Caption = 'N'#227'o utilizar ressarcimento de ICMS'
          Value = 'N'
        end>
    end
    object rdgSisAca: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultValue = 1
      Properties.Items = <
        item
          Caption = 'PROCOD'
          Value = 1
        end
        item
          Caption = 'CFGSIS (por empresa)'
          Value = 2
        end>
    end
    object rdgFonDRE: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = '10'
          Value = '10'
        end
        item
          Caption = '12'
          Value = '12'
        end
        item
          Caption = '14'
          Value = '14'
        end>
    end
    object rdgQtdProdDivergMult: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Trava'
          Value = '1'
        end
        item
          Caption = 'N'#227'o trava'
          Value = '2'
        end
        item
          Caption = 'Somente avisa'
          Value = '3'
        end
        item
          Caption = 'Solicita senha'
          Value = '4'
        end>
      Properties.WordWrap = True
    end
    object rdgModeSSL: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'sslmUnassigned'
          Value = 'sslmUnassigned'
        end
        item
          Caption = 'sslmClient'
          Value = 'sslmClient'
        end
        item
          Caption = 'sslmServer'
          Value = 'sslmServer'
        end
        item
          Caption = 'sslmBoth'
          Value = 'sslmBoth'
        end>
    end
    object rdgTimeZone: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'UTC 2 - Bras'#237'lia Hor'#225'rio de Ver'#227'o / Hor'#225'rio de Fernando de Noron' +
            'ha'
          Value = '-2'
        end
        item
          Caption = 'UTC 3 - Hor'#225'rio de Bras'#237'lia / Sinop Hor'#225'rio de Ver'#227'o'
          Value = '-3'
        end
        item
          Caption = 'UTC 4 - Hor'#225'rio do Amazonas'
          Value = '-4'
        end
        item
          Caption = 'UTC 5 - Hor'#225'rio do Acre'
          Value = '-5'
        end>
    end
    object rdgImpDesOrdPro: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 
            'Para Imob./Indust., a descri'#231#227'o do colorante (COL_DESCRI) e para' +
            ' Autom., a descri'#231#227'o da base (BAS_DESCRI)'
          Value = '1'
        end
        item
          Caption = 
            'Sempre a descri'#231#227'o do cad.produtos (ITE_DESITE) para bases e col' +
            'orantes'
          Value = '2'
        end>
    end
    object rdgUTCSEA: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'N'#227'o Utiliza'
          Value = 'N'
        end
        item
          Caption = 'Utiliza Autcom'
          Value = 'S'
        end
        item
          Caption = 'Utiliza Coletor'
          Value = 'C'
        end>
    end
    object rdgPrecoGeracao: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = 'Cadastro de Base'
          Value = '0'
        end
        item
          Caption = 'Cadastro de Produtos'
          Value = '1'
        end
        item
          Caption = 'Tabela de Cliente'
          Value = '2'
        end>
    end
    object cmbTabelaPrecoCadPro: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
    end
    object rdgUsaProdutoAcabado: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Sim'
          Value = 'S'
        end
        item
          Caption = 'N'#227'o'
          Value = 'N'
        end>
    end
    object cmbTabExportacaoTerceiros: TcxEditRepositoryComboBoxItem
      Properties.CharCase = ecUpperCase
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
    end
    object rdgModoFormulacao: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'Sempre usar para todas as tintas'
          Value = '1'
        end
        item
          Caption = 'Definir individualmente em cada tinta'
          Value = '2'
        end>
    end
    object rdgAcertoAutomotivas: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Fator'
          Value = 'F'
        end
        item
          Caption = 'Valor'
          Value = 'V'
        end>
    end
  end
  object cxHintStyleController1: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaSlideFromRight
    HintStyle.CallOutPosition = cxbpBottomRight
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'MS Sans Serif'
    HintStyle.Font.Style = []
    HintStyle.IconType = cxhiInformation
    Left = 48
    Top = 76
  end
  object cxStyleRepositorio: TcxStyleRepository
    Left = 48
    Top = 144
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
  end
end
