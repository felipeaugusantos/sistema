inherited frmAltPrecoIndividual: TfrmAltPrecoIndividual
  Left = 186
  Top = 106
  Width = 909
  Height = 753
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o de Pre'#231'o Individual'
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 909
  ExplicitHeight = 753
  PixelsPerInch = 96
  TextHeight = 14
  object pnlProdutos: TPanel [0]
    Left = 0
    Top = 240
    Width = 893
    Height = 429
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object pnlRodape: TPanel
      Left = 1
      Top = 376
      Width = 891
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object Label10: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
      end
      object Label11: TLabel
        Left = 65
        Top = 8
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
      end
      object Label12: TLabel
        Left = 485
        Top = 8
        Width = 53
        Height = 14
        Caption = 'Refer'#234'ncia'
      end
      object Label13: TLabel
        Left = 611
        Top = 8
        Width = 39
        Height = 14
        Caption = 'Unidade'
      end
      object Label14: TLabel
        Left = 701
        Top = 10
        Width = 77
        Height = 14
        Caption = #218'ltima Alt. Pre'#231'o'
      end
      object dbeCodIte: TDBEditFocus
        Left = 8
        Top = 24
        Width = 56
        Height = 22
        TabStop = False
        DataField = 'ITE_CODITE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesIte: TDBEditFocus
        Left = 65
        Top = 24
        Width = 419
        Height = 22
        TabStop = False
        DataField = 'ITE_DESITE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeRefere: TDBEditFocus
        Left = 485
        Top = 24
        Width = 125
        Height = 22
        TabStop = False
        DataField = 'ITE_REFERE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeUnidad: TDBEditFocus
        Left = 611
        Top = 24
        Width = 89
        Height = 22
        TabStop = False
        DataField = 'ITE_DESUNI'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAltPre: TDBEditFocus
        Left = 701
        Top = 24
        Width = 89
        Height = 22
        TabStop = False
        DataField = 'ITE_ALTPRE'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clWindow
        Requerido = True
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlAviso: TPanel
      Left = 1
      Top = 361
      Width = 891
      Height = 15
      Align = alBottom
      Caption = 
        'Para editar o valor do Campo Aplica'#231#227'o '#233' preciso apertar a tecla' +
        ' enter sobre o campo ou duplo clique do mouse.'
      ParentColor = True
      TabOrder = 1
      Visible = False
    end
    object cxgTiposAlt: TcxGrid
      Left = 1
      Top = 1
      Width = 891
      Height = 360
      Align = alClient
      TabOrder = 2
      OnEnter = cxgTiposAltEnter
      OnExit = cxgTiposAltExit
      ExplicitTop = 182
      ExplicitHeight = 179
      object cxvTiposAlt: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxvTiposAltCustomDrawCell
        OnEditKeyPress = cxvTiposAltEditKeyPress
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsView.NoDataToDisplayInfoText = '<Nenhum registro encontrado>'
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            FixedKind = fkLeft
            Width = 354
          end
          item
            Width = 114
          end>
      end
      object cxgTiposAltLevel1: TcxGridLevel
        GridView = cxvTiposAlt
      end
    end
  end
  object pnlFiltro2: TPanel [1]
    Left = 568
    Top = 80
    Width = 893
    Height = 429
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lbl6: TLabel
      Left = 1
      Top = 1
      Width = 891
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Campos Visualizados'
      Color = 16757606
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      ExplicitTop = 0
      ExplicitWidth = 796
    end
    object chkMinTb1: TCheckBox
      Tag = 90
      Left = 7
      Top = 25
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 1'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkMinTb2: TCheckBox
      Tag = 90
      Left = 7
      Top = 43
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 2'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkMinTb3: TCheckBox
      Tag = 90
      Left = 7
      Top = 61
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 3'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkMinTb4: TCheckBox
      Tag = 90
      Left = 7
      Top = 79
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 4'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chkMinTb5: TCheckBox
      Tag = 90
      Left = 7
      Top = 97
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 5'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chkMinTb6: TCheckBox
      Tag = 90
      Left = 7
      Top = 115
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 6'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkMinTb7: TCheckBox
      Tag = 90
      Left = 7
      Top = 133
      Width = 148
      Height = 17
      Caption = 'Qtde.M'#237'nima Tab.Pre'#231'o 7'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkUniCom: TCheckBox
      Tag = 90
      Left = 7
      Top = 151
      Width = 148
      Height = 17
      Caption = 'Unidade de Compra'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object chkPreMed: TCheckBox
      Tag = 90
      Left = 7
      Top = 205
      Width = 177
      Height = 18
      Caption = 'Pre'#231'o M'#233'dio'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object chkDtaAlt: TCheckBox
      Tag = 90
      Left = 7
      Top = 223
      Width = 198
      Height = 17
      Caption = 'Data da '#218'ltima Altera'#231#227'o de Pre'#231'o'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object chkPr1Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 25
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 1 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 20
    end
    object chkPr2Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 43
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 2 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 21
    end
    object chkPr3Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 61
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 3 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 22
    end
    object chkPr4Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 79
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 4 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 23
    end
    object chkPr5Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 97
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 5 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 24
    end
    object chkPr6Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 115
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 6 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 25
    end
    object chkPr7Ant: TCheckBox
      Tag = 90
      Left = 240
      Top = 133
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 7 Anterior'
      Checked = True
      State = cbChecked
      TabOrder = 26
    end
    object chkPrdGru: TCheckBox
      Tag = 90
      Left = 240
      Top = 151
      Width = 177
      Height = 17
      Caption = 'Grupo de Produto'
      Checked = True
      State = cbChecked
      TabOrder = 27
    end
    object chkImpLis: TCheckBox
      Tag = 90
      Left = 7
      Top = 241
      Width = 177
      Height = 17
      Caption = 'Imprime Lista'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object chkAtiCom: TCheckBox
      Tag = 90
      Left = 240
      Top = 171
      Width = 198
      Height = 17
      Caption = 'Ativo Compras'
      Checked = True
      State = cbChecked
      TabOrder = 28
    end
    object chkNotEsp: TCheckBox
      Tag = 90
      Left = 240
      Top = 205
      Width = 177
      Height = 17
      Caption = 'Divis'#237'vel'
      Checked = True
      State = cbChecked
      TabOrder = 30
    end
    object chkUsaBon: TCheckBox
      Tag = 90
      Left = 240
      Top = 187
      Width = 155
      Height = 17
      Caption = 'Usa Bonifica'#231#227'o?'
      Checked = True
      State = cbChecked
      TabOrder = 29
    end
    object chkCodDic: TCheckBox
      Tag = 90
      Left = 7
      Top = 259
      Width = 177
      Height = 17
      Caption = 'C'#243'digo DIC'
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
    object chkPRapel: TCheckBox
      Tag = 90
      Left = 240
      Top = 223
      Width = 165
      Height = 17
      Caption = 'Desconto Refer'#234'nte Rapel'
      Checked = True
      State = cbChecked
      TabOrder = 31
    end
    object chkImpEti: TCheckBox
      Tag = 90
      Left = 7
      Top = 277
      Width = 227
      Height = 17
      Caption = 'Imprimir Etiqueta na Entrada de Mercadoria'
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object chkCodGru: TCheckBox
      Tag = 90
      Left = 240
      Top = 241
      Width = 165
      Height = 17
      Caption = 'Linha/Grupo'
      Checked = True
      State = cbChecked
      TabOrder = 32
    end
    object chkTipFre: TCheckBox
      Tag = 90
      Left = 7
      Top = 295
      Width = 165
      Height = 17
      Caption = 'Tipo de Frete'
      Checked = True
      State = cbChecked
      TabOrder = 15
    end
    object chkVlcFre: TCheckBox
      Tag = 90
      Left = 240
      Top = 259
      Width = 165
      Height = 17
      Caption = 'Frete de Sa'#237'da'
      Checked = True
      State = cbChecked
      TabOrder = 33
    end
    object chkReaEnd: TCheckBox
      Tag = 90
      Left = 507
      Top = 43
      Width = 206
      Height = 17
      Caption = 'Realizar endere'#231'amento do produto'
      Checked = True
      State = cbChecked
      TabOrder = 41
    end
    object chkRastre: TCheckBox
      Tag = 90
      Left = 507
      Top = 61
      Width = 280
      Height = 17
      Caption = 'Utilizar Controle de Rastreabilidade do produto'
      Checked = True
      State = cbChecked
      TabOrder = 42
    end
    object chkFATCMP: TCheckBox
      Tag = 90
      Left = 507
      Top = 79
      Width = 253
      Height = 17
      Caption = 'Fator de convers'#227'o madeira de M'#179' para Pe'#231'as'
      Checked = True
      State = cbChecked
      TabOrder = 43
    end
    object chkExcIpi: TCheckBox
      Tag = 90
      Left = 7
      Top = 314
      Width = 155
      Height = 17
      Caption = 'C'#243'digo EX IPI'
      Checked = True
      State = cbChecked
      TabOrder = 16
    end
    object chkDensid: TCheckBox
      Tag = 90
      Left = 7
      Top = 333
      Width = 155
      Height = 17
      Caption = 'Densidade'
      Checked = True
      State = cbChecked
      TabOrder = 17
    end
    object chkAlMaVi: TCheckBox
      Tag = 90
      Left = 507
      Top = 151
      Width = 206
      Height = 17
      Caption = 'Altura M'#225'xima (Venda Parcial)'
      Checked = True
      State = cbChecked
      TabOrder = 47
    end
    object chkLaMaVi: TCheckBox
      Tag = 90
      Left = 507
      Top = 133
      Width = 206
      Height = 17
      Caption = 'Largura M'#225'xima (Venda Parcial)'
      Checked = True
      State = cbChecked
      TabOrder = 46
    end
    object chkAltVid: TCheckBox
      Tag = 90
      Left = 507
      Top = 115
      Width = 206
      Height = 17
      Caption = 'Altura'
      Checked = True
      State = cbChecked
      TabOrder = 45
    end
    object chkLarVid: TCheckBox
      Tag = 90
      Left = 507
      Top = 97
      Width = 206
      Height = 17
      Caption = 'Largura'
      Checked = True
      State = cbChecked
      TabOrder = 44
    end
    object chkMarId1: TCheckBox
      Tag = 90
      Left = 507
      Top = 169
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 1'
      Checked = True
      State = cbChecked
      TabOrder = 48
    end
    object chkMarId2: TCheckBox
      Tag = 90
      Left = 507
      Top = 187
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 2'
      Checked = True
      State = cbChecked
      TabOrder = 49
    end
    object chkMarId3: TCheckBox
      Tag = 90
      Left = 507
      Top = 205
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 3'
      Checked = True
      State = cbChecked
      TabOrder = 50
    end
    object chkMarId4: TCheckBox
      Tag = 90
      Left = 507
      Top = 223
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 4'
      Checked = True
      State = cbChecked
      TabOrder = 51
    end
    object chkMarId5: TCheckBox
      Tag = 90
      Left = 507
      Top = 241
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 5'
      Checked = True
      State = cbChecked
      TabOrder = 52
    end
    object chkMarId6: TCheckBox
      Tag = 90
      Left = 507
      Top = 259
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 6'
      Checked = True
      State = cbChecked
      TabOrder = 53
    end
    object chkMarId7: TCheckBox
      Tag = 90
      Left = 507
      Top = 277
      Width = 148
      Height = 17
      Caption = 'Margem Ideal 7'
      Checked = True
      State = cbChecked
      TabOrder = 54
    end
    object chkPEFUTP: TCheckBox
      Tag = 90
      Left = 240
      Top = 277
      Width = 250
      Height = 17
      Caption = 'Perm. Ent. Futura Status "Previs'#227'o de Entrega"?'
      Checked = True
      State = cbChecked
      TabOrder = 34
    end
    object chkPEFFPR: TCheckBox
      Tag = 90
      Left = 507
      Top = 25
      Width = 250
      Height = 17
      Caption = 'Perm. Ent. Futura Status "Falta de Produto"?'
      Checked = True
      State = cbChecked
      TabOrder = 40
    end
    object chkPEEFUT: TCheckBox
      Tag = 90
      Left = 240
      Top = 297
      Width = 250
      Height = 17
      Caption = 'Perm. Ent. Futura Status "Aguardando Cliente"?'
      Checked = True
      State = cbChecked
      TabOrder = 35
    end
    object chkGruCmp: TCheckBox
      Tag = 90
      Left = 507
      Top = 297
      Width = 148
      Height = 17
      Caption = 'Grupo de Compra'
      Checked = True
      State = cbChecked
      TabOrder = 55
    end
    object chkRecDev: TCheckBox
      Tag = 90
      Left = 240
      Top = 316
      Width = 177
      Height = 17
      Caption = 'Permite Receber Devolu'#231#227'o?'
      Checked = True
      State = cbChecked
      TabOrder = 36
    end
    object chkUniTri: TCheckBox
      Tag = 90
      Left = 7
      Top = 169
      Width = 148
      Height = 17
      Caption = 'Unidade Tribut'#225'ria'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object chkFatUTr: TCheckBox
      Tag = 90
      Left = 7
      Top = 187
      Width = 207
      Height = 17
      Caption = 'Fator de Convers'#227'o Unidade Tribut'#225'ria'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkAplica: TCheckBox
      Tag = 90
      Left = 7
      Top = 351
      Width = 155
      Height = 17
      Caption = 'Aplica'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object chkPraMin: TCheckBox
      Tag = 90
      Left = 240
      Top = 333
      Width = 250
      Height = 17
      Caption = 'Prazo m'#233'dio m'#237'nimo para c'#225'lculo de juros'
      Checked = True
      State = cbChecked
      TabOrder = 37
    end
    object chkNvlCri: TCheckBox
      Tag = 90
      Left = 508
      Top = 314
      Width = 165
      Height = 17
      Caption = 'N'#237'vel de Criticidade Geral'
      Checked = True
      State = cbChecked
      TabOrder = 56
    end
    object chkNivCri: TCheckBox
      Tag = 90
      Left = 508
      Top = 333
      Width = 112
      Height = 17
      Caption = 'N'#237'vel de Criticidade'
      Checked = True
      State = cbChecked
      TabOrder = 57
    end
    object chkObrBar: TCheckBox
      Tag = 90
      Left = 240
      Top = 351
      Width = 267
      Height = 17
      Caption = 'Obrigat'#243'rio o C'#243'digo Barras na Entrada Simplificada'
      Checked = True
      State = cbChecked
      TabOrder = 38
    end
    object chkDesCnd: TCheckBox
      Tag = 90
      Left = 7
      Top = 369
      Width = 214
      Height = 17
      Caption = 'Aplicar desconto da condi'#231#227'o de pagto?'
      Checked = True
      State = cbChecked
      TabOrder = 19
    end
    object chkFatCom: TCheckBox
      Tag = 90
      Left = 240
      Top = 369
      Width = 267
      Height = 17
      Caption = 'Digitar complemento do produto'
      Checked = True
      State = cbChecked
      TabOrder = 39
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 630
    Top = 102
    Width = 893
    Height = 429
    ParentBackground = False
    ParentColor = True
    TabOrder = 1
    TabStop = True
    object lbl5: TLabel
      Left = 1
      Top = 1
      Width = 891
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Campos Visualizados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 937
    end
    object chkMarBr7: TCheckBox
      Tag = 90
      Left = 611
      Top = 14
      Width = 109
      Height = 17
      Caption = 'Margem Bruta 7'
      Checked = True
      State = cbChecked
      TabOrder = 89
    end
    object chkInflam: TCheckBox
      Tag = 90
      Left = 314
      Top = 284
      Width = 155
      Height = 17
      Caption = 'Produto Inflam'#225'vel?'
      Checked = True
      State = cbChecked
      TabOrder = 60
    end
    object chkNvlGir: TCheckBox
      Tag = 90
      Left = 314
      Top = 338
      Width = 143
      Height = 17
      Caption = 'N'#237'vel Giro Estoque Geral'
      Checked = True
      State = cbChecked
      TabOrder = 63
    end
    object chkCodFor: TCheckBox
      Tag = 90
      Left = 6
      Top = 266
      Width = 131
      Height = 17
      Caption = 'Fornecedor'
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object chkCodMar: TCheckBox
      Tag = 90
      Left = 6
      Top = 248
      Width = 94
      Height = 17
      Caption = 'Marca'
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
    object chkCodUni: TCheckBox
      Tag = 90
      Left = 6
      Top = 230
      Width = 131
      Height = 17
      Caption = 'Unidade'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object chkCODITE: TCheckBox
      Tag = 90
      Left = 6
      Top = 15
      Width = 109
      Height = 17
      Caption = 'C'#243'digo do Item'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkDesIte: TCheckBox
      Tag = 90
      Left = 6
      Top = 32
      Width = 103
      Height = 17
      Caption = 'Descri'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkRefere: TCheckBox
      Tag = 90
      Left = 6
      Top = 50
      Width = 169
      Height = 17
      Caption = 'Refer'#234'ncia'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkPreCom: TCheckBox
      Tag = 90
      Left = 182
      Top = 14
      Width = 120
      Height = 17
      Caption = 'Pre'#231'o de Compra'
      Checked = True
      State = cbChecked
      TabOrder = 23
    end
    object chkDesF01: TCheckBox
      Tag = 90
      Left = 182
      Top = 50
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 1'
      Checked = True
      State = cbChecked
      TabOrder = 25
    end
    object chkDesF02: TCheckBox
      Tag = 90
      Left = 182
      Top = 68
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 2'
      Checked = True
      State = cbChecked
      TabOrder = 26
    end
    object chkDesF03: TCheckBox
      Tag = 90
      Left = 182
      Top = 86
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 3'
      Checked = True
      State = cbChecked
      TabOrder = 27
    end
    object chkDesF04: TCheckBox
      Tag = 90
      Left = 182
      Top = 104
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 4'
      Checked = True
      State = cbChecked
      TabOrder = 28
    end
    object chkDesF05: TCheckBox
      Tag = 90
      Left = 182
      Top = 122
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 5'
      Checked = True
      State = cbChecked
      TabOrder = 29
    end
    object chkDesF06: TCheckBox
      Tag = 90
      Left = 182
      Top = 140
      Width = 120
      Height = 17
      Caption = 'Desc. Fornec. 6'
      Checked = True
      State = cbChecked
      TabOrder = 30
    end
    object chkIcmEnt: TCheckBox
      Tag = 90
      Left = 182
      Top = 176
      Width = 120
      Height = 17
      Caption = 'Icms de Entrada'
      Checked = True
      State = cbChecked
      TabOrder = 32
    end
    object chkIpient: TCheckBox
      Tag = 90
      Left = 182
      Top = 212
      Width = 120
      Height = 17
      Caption = 'Ipi de Entrada'
      Checked = True
      State = cbChecked
      TabOrder = 34
    end
    object chkFreEnt: TCheckBox
      Tag = 90
      Left = 182
      Top = 230
      Width = 120
      Height = 17
      Caption = 'Frete'
      Checked = True
      State = cbChecked
      TabOrder = 35
    end
    object chkAcrFin: TCheckBox
      Tag = 90
      Left = 182
      Top = 266
      Width = 120
      Height = 17
      Caption = 'Acr'#233's. Financeiro'
      Checked = True
      State = cbChecked
      TabOrder = 37
    end
    object chkSubsti: TCheckBox
      Tag = 90
      Left = 182
      Top = 284
      Width = 120
      Height = 17
      Caption = 'Substitui'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 38
    end
    object chkPreCus: TCheckBox
      Tag = 90
      Left = 182
      Top = 302
      Width = 120
      Height = 17
      Caption = 'Pre'#231'o de Custo'
      Checked = True
      State = cbChecked
      TabOrder = 39
    end
    object chkIcmSai: TCheckBox
      Tag = 90
      Left = 314
      Top = 68
      Width = 155
      Height = 17
      Caption = 'Icms Sa'#237'da'
      Checked = True
      State = cbChecked
      TabOrder = 48
    end
    object chkDesMax: TCheckBox
      Tag = 90
      Left = 611
      Top = 284
      Width = 177
      Height = 17
      Caption = 'Desconto M'#225'ximo Vendedor'
      Checked = True
      State = cbChecked
      TabOrder = 104
    end
    object chkMarBr1: TCheckBox
      Tag = 90
      Left = 484
      Top = 15
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 1'
      Checked = True
      State = cbChecked
      TabOrder = 68
    end
    object chkPreVe1: TCheckBox
      Tag = 90
      Left = 484
      Top = 50
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 1'
      Checked = True
      State = cbChecked
      TabOrder = 70
    end
    object chkMarBr2: TCheckBox
      Tag = 90
      Left = 484
      Top = 68
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 2'
      Checked = True
      State = cbChecked
      TabOrder = 71
    end
    object chkPreVe2: TCheckBox
      Tag = 90
      Left = 484
      Top = 104
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 2'
      Checked = True
      State = cbChecked
      TabOrder = 73
    end
    object chkMarBr3: TCheckBox
      Tag = 90
      Left = 484
      Top = 122
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 3'
      Checked = True
      State = cbChecked
      TabOrder = 74
    end
    object chkPreVe3: TCheckBox
      Tag = 90
      Left = 484
      Top = 158
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 3'
      Checked = True
      State = cbChecked
      TabOrder = 76
    end
    object chkMarMin: TCheckBox
      Tag = 90
      Left = 611
      Top = 338
      Width = 155
      Height = 17
      Caption = 'Margem M'#237'nima Vendedor'
      Checked = True
      State = cbChecked
      TabOrder = 107
    end
    object chkDesOpe: TCheckBox
      Tag = 90
      Left = 314
      Top = 32
      Width = 155
      Height = 17
      Caption = 'Despesas Operacionais'
      Checked = True
      State = cbChecked
      TabOrder = 46
    end
    object ChkCodAbf: TCheckBox
      Tag = 90
      Left = 6
      Top = 104
      Width = 169
      Height = 17
      Caption = 'Abrevia'#231#227'o Fiscal'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkIteAti: TCheckBox
      Tag = 90
      Left = 6
      Top = 68
      Width = 169
      Height = 17
      Caption = 'Ativo / Inativo'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object ChkClaIpi: TCheckBox
      Tag = 90
      Left = 6
      Top = 176
      Width = 169
      Height = 17
      Caption = 'NCM / Classifica'#231#227'o do IPI'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkImpFed: TCheckBox
      Tag = 90
      Left = 314
      Top = 122
      Width = 155
      Height = 17
      Caption = 'Impostos Federais (+)'
      Checked = True
      State = cbChecked
      TabOrder = 51
    end
    object chkLocFis: TCheckBox
      Tag = 90
      Left = 611
      Top = 158
      Width = 177
      Height = 17
      Caption = 'Localiza'#231#227'o F'#237'sica'
      Checked = True
      State = cbChecked
      TabOrder = 97
    end
    object chkMarBr4: TCheckBox
      Tag = 90
      Left = 484
      Top = 176
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 4'
      Checked = True
      State = cbChecked
      TabOrder = 77
    end
    object chkPreVe4: TCheckBox
      Tag = 90
      Left = 484
      Top = 212
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 4'
      Checked = True
      State = cbChecked
      TabOrder = 79
    end
    object chkDesMGe: TCheckBox
      Tag = 90
      Left = 611
      Top = 320
      Width = 177
      Height = 17
      Caption = 'Desconto M'#225'ximo Gerente'
      Checked = True
      State = cbChecked
      TabOrder = 106
    end
    object chkMltCom: TCheckBox
      Tag = 90
      Left = 314
      Top = 140
      Width = 155
      Height = 17
      Caption = 'M'#250'ltiplo para Compra'
      Checked = True
      State = cbChecked
      TabOrder = 52
    end
    object chkCodFab: TCheckBox
      Tag = 90
      Left = 314
      Top = 176
      Width = 155
      Height = 17
      Caption = 'C'#243'digo de f'#225'brica'
      Checked = True
      State = cbChecked
      TabOrder = 54
    end
    object chkMarBr5: TCheckBox
      Tag = 90
      Left = 484
      Top = 230
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 5'
      Checked = True
      State = cbChecked
      TabOrder = 80
    end
    object chkPreVe5: TCheckBox
      Tag = 90
      Left = 484
      Top = 266
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 5'
      Checked = True
      State = cbChecked
      TabOrder = 82
    end
    object chkMarBr6: TCheckBox
      Tag = 90
      Left = 484
      Top = 284
      Width = 124
      Height = 17
      Caption = 'Margem Bruta 6'
      Checked = True
      State = cbChecked
      TabOrder = 83
    end
    object chkPreVe6: TCheckBox
      Tag = 90
      Left = 484
      Top = 320
      Width = 124
      Height = 17
      Caption = 'Pre'#231'o de Venda 6'
      Checked = True
      State = cbChecked
      TabOrder = 85
    end
    object chkQtpPro: TCheckBox
      Tag = 90
      Left = 314
      Top = 302
      Width = 155
      Height = 17
      Caption = 'Qtd Pontos p/ Profissionais'
      Checked = True
      State = cbChecked
      TabOrder = 61
    end
    object chkCprCen: TCheckBox
      Tag = 90
      Left = 314
      Top = 194
      Width = 155
      Height = 17
      Caption = 'Compra centralizada'
      Checked = True
      State = cbChecked
      TabOrder = 55
    end
    object chkValFre: TCheckBox
      Tag = 90
      Left = 182
      Top = 248
      Width = 120
      Height = 17
      Caption = 'Valor Frete'
      Checked = True
      State = cbChecked
      TabOrder = 36
    end
    object chkPreVe7: TCheckBox
      Tag = 90
      Left = 611
      Top = 50
      Width = 177
      Height = 17
      Caption = 'Pre'#231'o de Venda 7'
      Checked = True
      State = cbChecked
      TabOrder = 91
    end
    object chkDesAdb: TCheckBox
      Tag = 90
      Left = 314
      Top = 104
      Width = 164
      Height = 17
      Caption = 'Desc.Adicional (Boleto)'
      Checked = True
      State = cbChecked
      TabOrder = 50
    end
    object chkPreLiq: TCheckBox
      Tag = 90
      Left = 182
      Top = 158
      Width = 120
      Height = 17
      Caption = 'Pre'#231'o Compra L'#237'q.'
      Checked = True
      State = cbChecked
      TabOrder = 31
    end
    object chkSubFed: TCheckBox
      Tag = 90
      Left = 182
      Top = 194
      Width = 120
      Height = 17
      Caption = 'Imp. Federais (-)'
      Checked = True
      State = cbChecked
      TabOrder = 33
    end
    object chkOutVal: TCheckBox
      Tag = 90
      Left = 314
      Top = 50
      Width = 155
      Height = 17
      Caption = 'Outros Valores'
      Checked = True
      State = cbChecked
      TabOrder = 47
    end
    object chkComTb1: TCheckBox
      Tag = 90
      Left = 484
      Top = 32
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 1'
      Checked = True
      State = cbChecked
      TabOrder = 69
    end
    object chkComTb2: TCheckBox
      Tag = 90
      Left = 484
      Top = 86
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 2'
      Checked = True
      State = cbChecked
      TabOrder = 72
    end
    object chkComTb3: TCheckBox
      Tag = 90
      Left = 484
      Top = 140
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 3'
      Checked = True
      State = cbChecked
      TabOrder = 75
    end
    object chkComTb4: TCheckBox
      Tag = 90
      Left = 484
      Top = 194
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 4'
      Checked = True
      State = cbChecked
      TabOrder = 78
    end
    object chkComTb5: TCheckBox
      Tag = 90
      Left = 484
      Top = 248
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 5'
      Checked = True
      State = cbChecked
      TabOrder = 81
    end
    object chkComTb6: TCheckBox
      Tag = 90
      Left = 484
      Top = 302
      Width = 124
      Height = 17
      Caption = 'Comiss'#227'o Tab. 6'
      Checked = True
      State = cbChecked
      TabOrder = 84
    end
    object chkComTb7: TCheckBox
      Tag = 90
      Left = 611
      Top = 32
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Tab. 7'
      Checked = True
      State = cbChecked
      TabOrder = 90
    end
    object chkTmpGar: TCheckBox
      Tag = 90
      Left = 314
      Top = 230
      Width = 155
      Height = 17
      Caption = 'Tempo de Garantia'
      Checked = True
      State = cbChecked
      TabOrder = 57
    end
    object chkPesoIt: TCheckBox
      Tag = 90
      Left = 314
      Top = 248
      Width = 155
      Height = 17
      Caption = 'Peso Bruto'
      Checked = True
      State = cbChecked
      TabOrder = 58
    end
    object chkDiaFor: TCheckBox
      Tag = 90
      Left = 6
      Top = 302
      Width = 169
      Height = 17
      Caption = 'Dias p/ entrega do Fornecedor'
      Checked = True
      State = cbChecked
      TabOrder = 16
    end
    object chkComVar: TCheckBox
      Tag = 90
      Left = 611
      Top = 68
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Vendedor Interno'
      Checked = True
      State = cbChecked
      TabOrder = 92
    end
    object chkComAta: TCheckBox
      Tag = 90
      Left = 611
      Top = 86
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Repres. Ext. Loja'
      Checked = True
      State = cbChecked
      TabOrder = 93
    end
    object chkTamLcF: TCheckBox
      Tag = 90
      Left = 611
      Top = 176
      Width = 177
      Height = 17
      Caption = 'Capacidade Localiza'#231#227'o F'#237'sica'
      Checked = True
      State = cbChecked
      TabOrder = 98
    end
    object chkComPro: TCheckBox
      Tag = 90
      Left = 611
      Top = 140
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Profiss.'
      Checked = True
      State = cbChecked
      TabOrder = 96
    end
    object chkLocSup: TCheckBox
      Tag = 90
      Left = 611
      Top = 194
      Width = 177
      Height = 17
      Caption = 'Localiza'#231#227'o Super Estoque'
      Checked = True
      State = cbChecked
      TabOrder = 99
    end
    object chkTamLcS: TCheckBox
      Tag = 90
      Left = 611
      Top = 212
      Width = 177
      Height = 17
      Caption = 'Capacidade Loc. Super Estoque'
      Checked = True
      State = cbChecked
      TabOrder = 100
    end
    object chkCodDep: TCheckBox
      Tag = 90
      Left = 6
      Top = 284
      Width = 107
      Height = 17
      Caption = 'Departamento'
      Checked = True
      State = cbChecked
      TabOrder = 15
    end
    object chkAbfPis: TCheckBox
      Tag = 90
      Left = 6
      Top = 122
      Width = 169
      Height = 17
      Caption = 'Abrevia'#231#227'o PIS'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkAbfCof: TCheckBox
      Tag = 90
      Left = 6
      Top = 140
      Width = 126
      Height = 17
      Caption = 'Abrevia'#231#227'o COFINS'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object chkAbfIpi: TCheckBox
      Tag = 90
      Left = 6
      Top = 158
      Width = 169
      Height = 17
      Caption = 'Abrevia'#231#227'o IPI'
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object chkIPISai: TCheckBox
      Tag = 90
      Left = 314
      Top = 86
      Width = 155
      Height = 17
      Caption = 'IPI Sa'#237'da'
      Checked = True
      State = cbChecked
      TabOrder = 49
    end
    object chkSaldos: TCheckBox
      Tag = 80
      Left = 6
      Top = 86
      Width = 59
      Height = 17
      Caption = 'Saldos'
      TabOrder = 4
    end
    object chkMltVen: TCheckBox
      Tag = 90
      Left = 314
      Top = 158
      Width = 155
      Height = 17
      Caption = 'M'#250'ltiplo para Venda'
      Checked = True
      State = cbChecked
      TabOrder = 53
    end
    object chkAcoObj: TCheckBox
      Tag = 90
      Left = 182
      Top = 338
      Width = 120
      Height = 17
      Caption = 'Acordo de Objetivos'
      Checked = True
      State = cbChecked
      TabOrder = 41
    end
    object chkEstMin: TCheckBox
      Tag = 90
      Left = 611
      Top = 248
      Width = 177
      Height = 17
      Caption = 'Estoque M'#237'nimo'
      Checked = True
      State = cbChecked
      TabOrder = 102
    end
    object chkEstMax: TCheckBox
      Tag = 90
      Left = 611
      Top = 266
      Width = 177
      Height = 17
      Caption = 'Estoque M'#225'ximo'
      Checked = True
      State = cbChecked
      TabOrder = 103
    end
    object chkAbaMlt: TCheckBox
      Tag = 90
      Left = 314
      Top = 212
      Width = 165
      Height = 17
      Caption = 'Nas Filiais, Abast. M'#250'lt. Compr.'
      Checked = True
      State = cbChecked
      TabOrder = 56
    end
    object chkObrCpf: TCheckBox
      Tag = 90
      Left = 6
      Top = 320
      Width = 169
      Height = 17
      Caption = 'Venda  c/ obrigat. CPF/CNPJ?'
      Checked = True
      State = cbChecked
      TabOrder = 17
    end
    object chkSitPro: TCheckBox
      Tag = 90
      Left = 6
      Top = 355
      Width = 169
      Height = 17
      Caption = 'Situa'#231#227'o do Produto'
      Checked = True
      State = cbChecked
      TabOrder = 19
    end
    object chkCodMon: TCheckBox
      Tag = 90
      Left = 314
      Top = 15
      Width = 166
      Height = 17
      Caption = 'Montadora'
      Checked = True
      State = cbChecked
      TabOrder = 45
    end
    object chkValObr: TCheckBox
      Tag = 90
      Left = 182
      Top = 356
      Width = 120
      Height = 17
      Caption = 'Validade Obrigat'#243'ria'
      Checked = True
      State = cbChecked
      TabOrder = 42
    end
    object chkObrNfe: TCheckBox
      Tag = 90
      Left = 314
      Top = 320
      Width = 166
      Height = 17
      Caption = 'Venda  c/ obrigat. NFe?'
      Checked = True
      State = cbChecked
      TabOrder = 62
    end
    object chkMarMSG: TCheckBox
      Tag = 90
      Left = 611
      Top = 356
      Width = 155
      Height = 17
      Caption = 'Margem M'#237'nima Sub Gerente'
      Checked = True
      State = cbChecked
      TabOrder = 108
    end
    object chkMarMGe: TCheckBox
      Tag = 90
      Left = 611
      Top = 374
      Width = 155
      Height = 17
      Caption = 'Margem M'#237'nima Gerente'
      Checked = True
      State = cbChecked
      TabOrder = 109
    end
    object chkComDis: TCheckBox
      Tag = 90
      Left = 611
      Top = 104
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Repres. Ext. Distrib.'
      Checked = True
      State = cbChecked
      TabOrder = 94
    end
    object chkPesLiq: TCheckBox
      Tag = 90
      Left = 314
      Top = 266
      Width = 155
      Height = 17
      Caption = 'Peso Liquido'
      Checked = True
      State = cbChecked
      TabOrder = 59
    end
    object chkTipPro: TCheckBox
      Tag = 90
      Left = 182
      Top = 374
      Width = 169
      Height = 17
      Caption = 'Tipo de produto (SPED)'
      Checked = True
      State = cbChecked
      TabOrder = 43
    end
    object chkObrIba: TCheckBox
      Tag = 90
      Left = 6
      Top = 338
      Width = 169
      Height = 17
      Caption = 'Venda  c/ obrigat. c'#243'd. IBAMA?'
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object chkPer_CI: TCheckBox
      Tag = 90
      Left = 6
      Top = 194
      Width = 149
      Height = 17
      Caption = 'Percentual (CI)'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object chkNumFCI: TCheckBox
      Tag = 90
      Left = 6
      Top = 212
      Width = 149
      Height = 17
      Caption = 'N'#186' Ficha (FCI)'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object chkImpUlt: TCheckBox
      Tag = 90
      Left = 182
      Top = 32
      Width = 120
      Height = 17
      Caption = 'Pre'#231'o '#218'lt.Compr.+Imp.'
      Checked = True
      State = cbChecked
      TabOrder = 24
    end
    object chkProEmb: TCheckBox
      Tag = 90
      Left = 314
      Top = 356
      Width = 177
      Height = 17
      Caption = 'Produto embalagem'
      Checked = True
      State = cbChecked
      TabOrder = 64
    end
    object chkInfGar: TCheckBox
      Tag = 90
      Left = 484
      Top = 338
      Width = 121
      Height = 17
      Caption = 'Informa'#231#227'o Garantia'
      Checked = True
      State = cbChecked
      TabOrder = 86
    end
    object chkMesGir: TCheckBox
      Tag = 90
      Left = 484
      Top = 356
      Width = 125
      Height = 17
      Caption = 'Qtd. Meses p/ Inativar'
      Checked = True
      State = cbChecked
      TabOrder = 87
    end
    object chkCodLse: TCheckBox
      Tag = 90
      Left = 611
      Top = 230
      Width = 170
      Height = 17
      Caption = 'Localiza'#231#227'o de Separa'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 101
    end
    object chkDesMSu: TCheckBox
      Tag = 90
      Left = 611
      Top = 302
      Width = 177
      Height = 17
      Caption = 'Desconto M'#225'ximo Sub-Gerente'
      Checked = True
      State = cbChecked
      TabOrder = 105
    end
    object chkCdCest: TCheckBox
      Tag = 90
      Left = 611
      Top = 392
      Width = 155
      Height = 17
      Caption = 'C'#243'digo CEST'
      Checked = True
      State = cbChecked
      TabOrder = 110
    end
    object chkDtaVal: TCheckBox
      Tag = 90
      Left = 6
      Top = 374
      Width = 169
      Height = 17
      Caption = 'Dt.Val. de pre'#231'o da tab. do forn.'
      Checked = True
      State = cbChecked
      TabOrder = 20
    end
    object chkCodOnu: TCheckBox
      Tag = 90
      Left = 182
      Top = 392
      Width = 120
      Height = 17
      Caption = 'Classifica'#231#227'o ONU'
      Checked = True
      State = cbChecked
      TabOrder = 44
    end
    object chkUsaFle: TCheckBox
      Tag = 90
      Left = 314
      Top = 374
      Width = 120
      Height = 17
      Caption = 'Gerar Flex?'
      Checked = True
      State = cbChecked
      TabOrder = 65
    end
    object chkCusRea: TCheckBox
      Tag = 90
      Left = 182
      Top = 320
      Width = 120
      Height = 17
      Caption = 'Pre'#231'o de Custo Real'
      Checked = True
      State = cbChecked
      TabOrder = 40
    end
    object chkUtiAmp: TCheckBox
      Tag = 90
      Left = 314
      Top = 392
      Width = 166
      Height = 17
      Caption = 'Aplica legisla'#231#227'o AMPARA?'
      Checked = True
      State = cbChecked
      TabOrder = 66
    end
    object chkOrdSer: TCheckBox
      Tag = 90
      Left = 7
      Top = 392
      Width = 155
      Height = 17
      Caption = 'Ordem de Servi'#231'o'
      Checked = True
      State = cbChecked
      TabOrder = 21
    end
    object chkLotePD: TCheckBox
      Tag = 90
      Left = 484
      Top = 374
      Width = 121
      Height = 32
      Caption = 'Obrigar definir lote (WMS) em PD?'
      Checked = True
      State = cbChecked
      TabOrder = 88
      Visible = False
      WordWrap = True
    end
    object chkPesObr: TCheckBox
      Tag = 90
      Left = 7
      Top = 410
      Width = 207
      Height = 17
      Caption = 'Controlar pesagem obrigat'#243'ria (Sa'#237'da)?'
      Checked = True
      State = cbChecked
      TabOrder = 22
    end
    object chkCpesOb: TCheckBox
      Tag = 90
      Left = 314
      Top = 410
      Width = 216
      Height = 17
      Caption = 'Controlar pesagem obrigat'#243'ria (Entrada)?'
      Checked = True
      State = cbChecked
      TabOrder = 67
    end
    object chkComDig: TCheckBox
      Tag = 90
      Left = 611
      Top = 122
      Width = 177
      Height = 17
      Caption = 'Comiss'#227'o Digitador'
      Checked = True
      State = cbChecked
      TabOrder = 95
    end
    object chkClaCrm: TCheckBox
      Tag = 90
      Left = 611
      Top = 408
      Width = 185
      Height = 17
      Caption = 'Classif. Oferta de Consum'#237'veis'
      Checked = True
      State = cbChecked
      TabOrder = 111
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 893
    Height = 240
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 28
      Top = 32
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 272
      Top = 32
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label4: TLabel
      Left = 440
      Top = 32
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label6: TLabel
      Left = 47
      Top = 56
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblFornec: TLabel
      Left = 21
      Top = 102
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label7: TLabel
      Left = 266
      Top = 56
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Abrev. Fiscal:'
    end
    object Label9: TLabel
      Left = 577
      Top = 147
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo?:'
    end
    object ColorLabel1: TColorLabel
      Left = 658
      Top = 146
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object lbl1: TLabel
      Left = 544
      Top = 101
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classif. do IPI:'
    end
    object lbl2: TLabel
      Left = 830
      Top = 246
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lbl4: TLabel
      Left = 15
      Top = 79
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc. Entrada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEspecie: TLabel
      Left = 173
      Top = 79
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSerie: TLabel
      Left = 250
      Top = 79
      Width = 28
      Height = 14
      Caption = 'S'#233'rie:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 307
      Top = 79
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblOrdem: TLabel
      Left = 393
      Top = 125
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Orderm:'
      Enabled = False
    end
    object Label167: TLabel
      Left = 7
      Top = 125
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Produto:'
    end
    object Label1: TLabel
      Left = 7
      Top = 147
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Compra:'
    end
    object Label50: TLabel
      Left = 556
      Top = 169
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Incide PIS?:'
    end
    object ColorLabel2: TColorLabel
      Left = 658
      Top = 169
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 6
      Top = 194
      Width = 74
      Height = 14
      Caption = 'Depto. Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl50: TLabel
      Left = 543
      Top = 124
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo EX IPI:'
    end
    object lblMarIde: TLabel
      Left = 366
      Top = 147
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Margem Ideal:'
    end
    object lblTabPrc: TLabel
      Left = 367
      Top = 171
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Pre'#231'o:'
    end
    object lblCodGpr: TLabel
      Left = 16
      Top = 170
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Pre'#231'o:'
    end
    object pnlCadMon: TPanel
      Left = 2
      Top = 213
      Width = 534
      Height = 25
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 18
      object lbl3: TLabel
        Left = 24
        Top = 3
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Montadora:'
      end
      object edtCodMon: TEditFocus
        Tag = 99
        Left = 80
        Top = 0
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodMonExit
        OnKeyPress = edtCodMonKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesMon: TEditFocus
        Left = 150
        Top = 0
        Width = 369
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 5
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 82
      Top = 28
      Width = 185
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 330
      Top = 28
      Width = 104
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodUni: TEditFocus
      Tag = 99
      Left = 485
      Top = 28
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 3
      OnExit = edtCodUniExit
      OnKeyPress = edtCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 82
      Top = 51
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 4
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 82
      Top = 98
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 10
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesGru: TEditFocus
      Left = 131
      Top = 5
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 25
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 135
      Top = 51
      Width = 131
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 26
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 152
      Top = 98
      Width = 369
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgTipAlt: TRadioGroup
      Left = 537
      Top = 2
      Width = 247
      Height = 72
      Caption = 'Tipo de Altera'#231#227'o'
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
        'Pre'#231'o de Custo, Alterando Margem de Lucro'
        'Pre'#231'o de Venda, Alterando Margem de Lucro')
      TabOrder = 19
    end
    object chkArrMai: TCheckBox
      Left = 587
      Top = 78
      Width = 191
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Arredonda '#250'ltima casa decimal'
      ParentBiDiMode = False
      TabOrder = 20
    end
    object edtCodAbr: TEditFocus
      Tag = 99
      Left = 334
      Top = 52
      Width = 32
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnExit = edtCodAbrExit
      OnKeyPress = edtCodAbrKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAbr: TEditFocus
      Left = 367
      Top = 52
      Width = 154
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 27
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 614
      Top = 143
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 23
      Text = 'T'
      OnKeyPress = edtStatusKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtClaIpi: TEditFocus
      Tag = 99
      Left = 614
      Top = 97
      Width = 167
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtDocumento: TEditFocus
      Left = 82
      Top = 75
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 6
      OnExit = edtDocumentoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 217
      Top = 75
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 7
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Left = 280
      Top = 75
      Width = 24
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 355
      Top = 75
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 9
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 392
      Top = 75
      Width = 129
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 28
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxOrdem: TComboBoxFocus
      Left = 434
      Top = 121
      Width = 87
      Height = 22
      Style = csDropDownList
      Enabled = False
      ItemIndex = 0
      TabOrder = 12
      Text = 'Alfab'#233'tica'
      Items.Strings = (
        'Alfab'#233'tica'
        'Digita'#231#227'o')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 82
      Top = 121
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 11
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrdPro: TEditFocus
      Left = 152
      Top = 121
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 30
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 82
      Top = 144
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 13
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 152
      Top = 144
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 31
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtIncPis: TEditFocus
      Tag = 99
      Left = 614
      Top = 166
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 24
      Text = 'T'
      OnExit = edtIncPisExit
      OnKeyPress = edtStatusKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 82
      Top = 190
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 17
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesDep: TEditFocus
      Left = 152
      Top = 190
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 32
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtExcIpi: TEditFocus
      Tag = 99
      Left = 614
      Top = 120
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 22
      OnExit = edtExcIpiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object cbxMarIde: TComboBoxFocus
      Left = 434
      Top = 144
      Width = 87
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 14
      Text = 'Nenhum'
      OnChange = cbxMarIdeChange
      Items.Strings = (
        'Nenhum'
        'Maior ou Igual'
        'Menor ou Igual'
        'Maior'
        'Menor'
        'Igual')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbxTabPrc: TComboBoxFocus
      Left = 434
      Top = 167
      Width = 87
      Height = 22
      Style = csDropDownList
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkPenRec: TCheckBox
      Left = 522
      Top = 188
      Width = 288
      Height = 24
      Caption = 
        'Exibir somente produtos com pend'#234'ncia de rec'#225'lculo de pre'#231'o devi' +
        'do '#224' altera'#231#227'o de abrevi'#231#227'o fiscal'
      TabOrder = 33
      WordWrap = True
    end
    object edtCodGpr: TEditFocus
      Tag = 99
      Left = 82
      Top = 167
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 15
      OnExit = edtCodGprExit
      OnKeyPress = edtCodGprKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesGpr: TEditFocus
      Left = 152
      Top = 167
      Width = 212
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 34
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlBotoes: TPanel
    Top = 678
    Width = 893
    Height = 23
    TabOrder = 7
    ExplicitTop = 678
    ExplicitWidth = 893
    ExplicitHeight = 23
    DesignSize = (
      893
      23)
    inherited btnSair: TBitBtnLocked
      Left = 821
      Top = 2
      Width = 68
      Height = 19
      Caption = '[ Esc ] Sair'
      Glyph.Data = {00000000}
      ParentBiDiMode = False
      TabOrder = 5
      ExplicitLeft = 821
      ExplicitTop = 2
      ExplicitWidth = 68
      ExplicitHeight = 19
    end
    object pnlBusca: TPanel
      Left = 420
      Top = 2
      Width = 210
      Height = 19
      BevelOuter = bvNone
      Color = clGray
      TabOrder = 4
      object btnLocProx: TBitBtnLocked
        Left = -5
        Top = 0
        Width = 114
        Height = 19
        Caption = '[F6] Localiza Pr'#243'xima'
        TabOrder = 0
        OnClick = btnLocProxClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 109
        Top = 0
        Width = 90
        Height = 19
        Caption = '[F5] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniBusClick
      end
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 98
      Height = 19
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaAltClick
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 203
      Top = 2
      Width = 120
      Height = 19
      Caption = ' [F3] Desmarcar Todos'
      TabOrder = 2
      TabStop = False
      OnClick = btnDesmarcarClick
    end
    object btnMarcar: TBitBtnLocked
      Left = 99
      Top = 2
      Width = 101
      Height = 19
      Caption = '[F2] Marcar Todos'
      TabOrder = 1
      TabStop = False
      OnClick = btnMarcarClick
    end
    object btnProPag: TBitBtnLocked
      Left = 320
      Top = 2
      Width = 97
      Height = 19
      Caption = '[F4] Pr'#243'x.P'#225'gina'
      TabOrder = 3
      TabStop = False
      OnClick = btnProPagClick
    end
    object btnExcel: TBitBtnLocked
      Left = 618
      Top = 2
      Width = 88
      Height = 19
      BiDiMode = bdLeftToRight
      Caption = '[F7] Exp. Excel'
      ParentBiDiMode = False
      TabOrder = 6
      Visible = False
      OnClick = btnExcelClick
    end
    object btnEstLoj: TBitBtnLocked
      Left = 199
      Top = 2
      Width = 120
      Height = 19
      Caption = ' [F3] Estoque das Lojas'
      TabOrder = 7
      TabStop = False
      Visible = False
      OnClick = btnEstLojClick
    end
    object btnLimpaFiltros: TBitBtnLocked
      Left = 707
      Top = 2
      Width = 108
      Height = 19
      BiDiMode = bdLeftToRight
      Caption = '[F8] Limpa Filtros'
      ParentBiDiMode = False
      TabOrder = 8
      OnClick = btnLimpaFiltrosClick
    end
  end
  object pgbStatus: TProgressBar [6]
    Left = 0
    Top = 669
    Width = 893
    Height = 9
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 701
    Width = 893
    Height = 13
    TabOrder = 4
    ExplicitTop = 701
    ExplicitWidth = 893
    ExplicitHeight = 13
    inherited pnlNomeForm: TPanel
      Left = 722
      Height = 13
      ExplicitLeft = 722
      ExplicitHeight = 13
    end
    inherited pnlInfo: TPanel
      Width = 722
      Height = 13
      ExplicitWidth = 722
      ExplicitHeight = 13
      object shpMultSel: TShape
        Left = 704
        Top = 2
        Width = 16
        Height = 9
        Hint = 'As consultas desta tela possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 350
        ExplicitTop = -1
        ExplicitHeight = 14
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 712
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 264
  end
  object cdsDuplic: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 808
    Top = 208
    object qryDuplicCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object qryDuplicCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object qryDuplicCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object qryDuplicDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object qryDuplicCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 35
    end
    object qryDuplicCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object qryDuplicBAREMB: TStringField
      FieldName = 'BAREMB'
      Size = 15
    end
    object qryDuplicORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 1
    end
    object cdsDuplicITEAGR: TStringField
      FieldName = 'ITEAGR'
      Size = 100
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 396
    Top = 523
    PixelsPerInch = 96
    object cxeString16: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 16
    end
    object cxeString20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
    end
    object cxeString02: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 2
    end
    object cxeString03: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 3
    end
    object cxeString05: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 5
    end
    object cxeString06: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 6
    end
    object cxeString07: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 7
    end
    object cxeString08: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 8
    end
    object cxeString10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
    end
    object cxeString25: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 25
    end
    object cxeString30: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 30
    end
    object cxeString50: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 50
    end
    object cxeString70: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 70
    end
    object cxeString80: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 80
    end
    object cxeString255: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 255
    end
    object cxeLocFis: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSup: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeTamLcf: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeLocSep: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
    end
    object cxeDate: TcxEditRepositoryDateItem
    end
    object cxeInt03: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 3
    end
    object cxeInt11: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
      Properties.MaxLength = 11
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbClaCRM: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbNivGir: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'A'
        'B'
        'C')
    end
    object cmbNivCri: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'X'
        'Y'
        'Z')
    end
    object cmbFrePFU: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeMemo: TcxEditRepositoryMemoItem
      Properties.CharCase = ecUpperCase
      Properties.ScrollBars = ssBoth
      Properties.VisibleLineCount = 5
    end
    object cxeMasFat: TcxEditRepositoryTextItem
    end
    object cxeDecUni: TcxEditRepositoryTextItem
    end
    object cxeDec05: TcxEditRepositoryTextItem
    end
    object cxeDec06: TcxEditRepositoryTextItem
    end
    object cxeMasVal: TcxEditRepositoryTextItem
    end
    object cxeMasPer: TcxEditRepositoryTextItem
    end
    object cxeMasMar: TcxEditRepositoryTextItem
    end
    object cxeMasInt: TcxEditRepositoryTextItem
    end
    object cmbTipPro: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cxeConsTam8: TcxEditRepositoryTextItem
      Properties.MaxLength = 8
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam6: TcxEditRepositoryTextItem
      Properties.MaxLength = 6
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam5: TcxEditRepositoryTextItem
      Properties.MaxLength = 5
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam3: TcxEditRepositoryTextItem
      Properties.MaxLength = 3
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam4: TcxEditRepositoryTextItem
      Properties.MaxLength = 4
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeConsTam2: TcxEditRepositoryTextItem
      Properties.MaxLength = 2
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeClassfIPI: TcxEditRepositoryTextItem
    end
    object cxeConsTam7: TcxEditRepositoryTextItem
      Properties.MaxLength = 7
      Properties.OnValidate = cxeConsTam2PropertiesValidate
    end
    object cxeFatCom: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = '#,###0.0000;-#,###0.0000'
      Properties.OnValidate = cxeFatComPropertiesValidate
    end
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 72
    Top = 536
    PixelsPerInch = 96
    object cxsCorAzul: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsCombo: TcxStyle
      AssignedValues = [svColor]
      Color = 10801663
    end
    object cxsAltera: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsConsulta: TcxStyle
      AssignedValues = [svColor]
      Color = 11206613
    end
  end
end
