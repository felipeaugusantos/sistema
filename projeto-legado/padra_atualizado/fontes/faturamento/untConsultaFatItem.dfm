inherited frmConsultaFatItem: TfrmConsultaFatItem
  Left = 269
  Top = 143
  Width = 1024
  Height = 586
  VertScrollBar.Range = 245
  Caption = 'Consulta Itens'
  ExplicitWidth = 1024
  ExplicitHeight = 586
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Width = 1016
    Height = 85
    OnEnter = dbgConsultaEnter
  end
  inherited pnlBotoes: TPanel
    Top = 506
    Width = 1016
    ExplicitTop = 495
    ExplicitWidth = 1008
    object shpGravCol: TShape [1]
      Left = 86
      Top = 3
      Width = 6
      Height = 22
      Hint = 'Gava'#231#227'o da posi'#231#227'o das colunas ativado.'
      Brush.Color = clMoneyGreen
      Enabled = False
      ParentShowHint = False
      Pen.Color = clMoneyGreen
      ShowHint = True
    end
    inherited btnConfirma: TBitBtnLocked
      Width = 82
      ExplicitWidth = 82
    end
    inherited btnSair: TBitBtnLocked
      Left = 919
      ExplicitLeft = 919
    end
  end
  inherited stbStatus: TStatusBar
    Top = 540
    Width = 1016
    ExplicitTop = 529
    ExplicitWidth = 1008
  end
  inherited Panel1: TPanel
    Top = 371
    Width = 1016
    Height = 135
    ExplicitTop = 371
    ExplicitWidth = 1016
    ExplicitHeight = 135
    inherited lblBuscarPor1: TLabel
      ParentColor = False
    end
    inherited lblChave1: TLabel
      Left = 207
      ExplicitLeft = 207
    end
    inherited lblChave2: TLabel
      Left = 207
      ExplicitLeft = 207
    end
    inherited lblBuscarPor3: TLabel
      Top = 79
      ExplicitTop = 79
    end
    inherited lblChave3: TLabel
      Left = 207
      Top = 79
      ExplicitLeft = 207
      ExplicitTop = 79
    end
    inherited lstIndices: TListBox
      Width = 134
      Height = 118
      Font.Charset = ANSI_CHARSET
      Font.Name = 'Arial'
      ItemHeight = 14
      ParentFont = False
      ExplicitWidth = 134
      ExplicitHeight = 118
    end
    inherited edtFiltro1: TEdit
      Top = 21
      Width = 313
      Font.Charset = ANSI_CHARSET
      Font.Height = -11
      ExplicitTop = 21
      ExplicitWidth = 313
    end
    inherited edtFiltro2: TEdit
      Top = 57
      Width = 313
      Font.Charset = ANSI_CHARSET
      Font.Height = -11
      ExplicitTop = 57
      ExplicitWidth = 313
    end
    inherited edtFiltro3: TEdit
      Top = 93
      Width = 313
      Font.Charset = ANSI_CHARSET
      Font.Height = -11
      ExplicitTop = 93
      ExplicitWidth = 313
    end
    inherited pnlLegendaCadCli: TPanel
      TabOrder = 8
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Left = 472
      Top = 6
      Width = 150
      Caption = '[ F4 ] Composi'#231#227'o do Custo'
      Visible = True
      OnClick = btnExecutaTarefaClick
      ExplicitLeft = 472
      ExplicitTop = 6
      ExplicitWidth = 150
    end
    inherited chkConsContida: TCheckBox
      Top = 118
      TabOrder = 10
      ExplicitTop = 118
    end
    object btnSalvarLayout: TBitBtnLocked
      Left = 472
      Top = 42
      Width = 150
      Height = 23
      Caption = 'Salvar layout da consulta'
      TabOrder = 5
      OnClick = btnSalvarLayoutClick
    end
    object btnRestaurarLayout: TBitBtnLocked
      Left = 472
      Top = 65
      Width = 150
      Height = 23
      Caption = 'Restaurar layout padr'#227'o'
      TabOrder = 6
      OnClick = btnRestaurarLayoutClick
    end
    object cxgLegendas: TcxGrid
      Left = 628
      Top = 6
      Width = 310
      Height = 106
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 7
      OnEnter = cxgLegendasEnter
      OnExit = cxgLegendasExit
      object cxgLegendasView: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Bands = <
          item
            Caption = 'Legendas do Item'
            Width = 293
          end>
        object cxgLegendasViewColumn1: TcxGridDBBandedColumn
          Caption = 'Cor'
          DataBinding.FieldName = 'SIT_CORSIT'
          PropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.ColorComboStyle = cxccsComboList
          Properties.CustomColors = <>
          Properties.NamingConvention = cxncX11
          Properties.PrepareList = cxplX11
          Properties.ShowDescriptions = False
          HeaderAlignmentHorz = taCenter
          Width = 38
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxgLegendasViewColumn2: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'SIT_DESCRI'
          Width = 256
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
      end
      object cxgLegendasLevel1: TcxGridLevel
        GridView = cxgLegendasView
      end
    end
    object chkSaldo: TCheckBox
      Left = 472
      Top = 95
      Width = 150
      Height = 17
      Caption = 'Somente itens com Saldo'
      TabOrder = 9
      OnClick = chkSaldoClick
    end
  end
  object pnlDadosItem: TPanel [4]
    Left = 0
    Top = 85
    Width = 1016
    Height = 229
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 74
    ExplicitWidth = 1008
    object Label3: TLabel
      Left = 40
      Top = 50
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblSalRes: TLabel
      Left = 318
      Top = 46
      Width = 60
      Height = 22
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Saldo Res. Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      WordWrap = True
    end
    object dbeIteAti: TDBText
      Left = 820
      Top = 13
      Width = 42
      Height = 14
      AutoSize = True
      DataField = 'ITE_ITEATI'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPreCus: TLabel
      Left = 559
      Top = 6
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Venda:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 546
      Top = 28
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dias n'#227'o vende:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblMsgLv1: TLabel
      Left = 8
      Top = 94
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Msg. Livre 1:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblMsgLv2: TLabel
      Left = 61
      Top = 116
      Width = 9
      Height = 14
      Alignment = taRightJustify
      Caption = '2:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblValPro: TLabel
      Left = 532
      Top = 71
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Promocional:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 37
      Top = 72
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblAplica: TLabel
      Left = 19
      Top = 17
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aplica'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblSal_Ml: TLabel
      Left = 153
      Top = 50
      Width = 82
      Height = 14
      Caption = 'Saldo Grama/ML:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSalDis: TLabel
      Left = 708
      Top = 6
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo Dispon'#237'vel:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLocFis: TLabel
      Left = 7
      Top = 138
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local. F'#237'sica:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object btnAmpliar: TSpeedButton
      Left = 818
      Top = 66
      Width = 23
      Height = 22
      Hint = 'Ampliar imagem'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAmpliarClick
    end
    object lblPreBoca: TLabel
      Left = 534
      Top = 117
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Boca de Cx:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblComBoca: TLabel
      Left = 526
      Top = 139
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = '% Comiss. Boca Cx:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label6: TLabel
      Left = 449
      Top = 46
      Width = 52
      Height = 22
      AutoSize = False
      Caption = 'Saldo Res. Garantia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label7: TLabel
      Left = 574
      Top = 44
      Width = 52
      Height = 22
      AutoSize = False
      Caption = 'Saldo Entre. Futura '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblTmpGar: TLabel
      Left = 13
      Top = 161
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tempo Gar.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblInfGar: TLabel
      Left = 127
      Top = 161
      Width = 116
      Height = 14
      Alignment = taRightJustify
      Caption = 'Informa'#231#227'o de Garantia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblSalDisCD: TLabel
      Left = 708
      Top = 111
      Width = 111
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo Dispon'#237'vel CD:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblMinPro: TLabel
      Left = 528
      Top = 94
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Min. Promo'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdPec: TLabel
      Left = 898
      Top = 179
      Width = 91
      Height = 11
      Caption = 'Qtde.  : 1,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblComPec: TLabel
      Left = 898
      Top = 191
      Width = 91
      Height = 11
      Caption = 'Compri.: 1,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblLarPec: TLabel
      Left = 898
      Top = 203
      Width = 91
      Height = 11
      Caption = 'Largura: 1,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblEspPec: TLabel
      Left = 898
      Top = 215
      Width = 91
      Height = 11
      Caption = 'Espess.: 1,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnPedSalRes: TBitBtnLocked
      Left = 134
      Top = 181
      Width = 176
      Height = 23
      Caption = '[ F7 ] Docs. de Saldo Reservado'
      TabOrder = 22
      Visible = False
      OnClick = btnPedSalResClick
    end
    object btnSimilares: TBitBtnLocked
      Left = 310
      Top = 181
      Width = 87
      Height = 23
      Caption = '[ F8 ] Similares'
      TabOrder = 23
      Visible = False
      OnClick = btnSimilaresClick
    end
    object btnMostraEstoque: TBitBtnLocked
      Left = 2
      Top = 181
      Width = 134
      Height = 23
      Caption = '[ F6 ] Estoque das Lojas'
      TabOrder = 21
      Visible = False
      OnClick = btnMostraEstoqueClick
    end
    object dbePreVen: TDBEditFocus
      Left = 626
      Top = 2
      Width = 75
      Height = 22
      DataField = 'ITE_PREVE1'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUltVen: TDBEditFocus
      Left = 626
      Top = 24
      Width = 75
      Height = 22
      DataField = 'ULTVEN'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMsgLv1: TDBEditFocus
      Left = 74
      Top = 90
      Width = 406
      Height = 22
      TabStop = False
      Color = 16768952
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMsgLv2: TDBEditFocus
      Left = 74
      Top = 112
      Width = 407
      Height = 22
      TabStop = False
      Color = 16768952
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtValPro: TEditFocus
      Left = 626
      Top = 67
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtSalRes: TEditFocus
      Left = 367
      Top = 46
      Width = 76
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnItensVend: TBitBtnLocked
      Left = 397
      Top = 181
      Width = 106
      Height = 23
      Caption = '[ F9 ] Itens Vendidos'
      TabOrder = 24
      OnClick = btnItensVendClick
    end
    object btnItensComp: TBitBtnLocked
      Left = 503
      Top = 181
      Width = 121
      Height = 23
      Caption = '[ F10 ] Itens Comprados'
      TabOrder = 25
      OnClick = btnItensCompClick
    end
    object dbeMarca: TDBEditFocus
      Left = 74
      Top = 68
      Width = 406
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'MARCA'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAplica: TDBMemoFocus
      Left = 74
      Top = 2
      Width = 407
      Height = 44
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object btnPedComp: TBitBtnLocked
      Left = 624
      Top = 181
      Width = 136
      Height = 23
      Caption = '[ F11 ] Pedidos de Compra'
      TabOrder = 26
      Visible = False
      OnClick = btnPedCompClick
    end
    object btnEntregasPendentes: TBitBtnLocked
      Left = 2
      Top = 204
      Width = 134
      Height = 23
      Caption = '[ F5 ] Entregas Pendentes'
      TabOrder = 28
      Visible = False
      OnClick = btnEntregasPendentesClick
    end
    object edtSalDis: TEditFocus
      Left = 707
      Top = 19
      Width = 105
      Height = 27
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnPedCompGrid: TBitBtnLocked
      Left = 624
      Top = 204
      Width = 136
      Height = 23
      Caption = '[ F12 ] Ped. Compra (Grid)'
      TabOrder = 33
      OnClick = btnPedCompGridClick
    end
    object btnSemelhantes: TBitBtnLocked
      Left = 134
      Top = 204
      Width = 100
      Height = 23
      Caption = '[ F2 ] Semelhantes'
      TabOrder = 29
      OnClick = btnSemelhantesClick
    end
    object pnlImgPro: TPanel
      Left = 707
      Top = 44
      Width = 105
      Height = 67
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 9
      object imgPro: TImage
        Left = 4
        Top = 4
        Width = 93
        Height = 55
        Align = alClient
        Center = True
        IncrementalDisplay = True
        Proportional = True
        Stretch = True
      end
      object lblErrImg: TLabel
        Left = 4
        Top = 4
        Width = 91
        Height = 48
        Align = alClient
        Alignment = taCenter
        Caption = 
          'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
          'to do arquivo!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
      end
    end
    object btnLotIte: TBitBtnLocked
      Left = 234
      Top = 204
      Width = 122
      Height = 23
      Caption = '[ Alt + F6 ] Lotes do Item'
      TabOrder = 30
      OnClick = btnLotIteClick
    end
    object edtPrecoBoca: TEditFocus
      Left = 626
      Top = 113
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtComBoca: TEditFocus
      Left = 626
      Top = 135
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 16
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtSal_ML: TEditFocus
      Left = 235
      Top = 46
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object editSaldos: TEditFocus
      Left = 74
      Top = 46
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnSepIte: TBitBtnLocked
      Left = 356
      Top = 204
      Width = 147
      Height = 23
      Caption = '[ Alt + F5 ] Separa'#231#227'o do Item'
      TabOrder = 31
      OnClick = btnSepIteClick
    end
    object btnEmbalagem: TBitBtnLocked
      Left = 503
      Top = 204
      Width = 121
      Height = 23
      Caption = '[ Alt + F7 ] Embalagem'
      TabOrder = 32
      OnClick = btnEmbalagemClick
    end
    object btnMostraPrecoVenda: TBitBtnLocked
      Left = 760
      Top = 181
      Width = 136
      Height = 23
      Caption = '&Pre'#231'o Venda das Lojas'
      TabOrder = 27
      OnClick = btnMostraPrecoVendaClick
    end
    object edtSalReG: TEditFocus
      Left = 497
      Top = 46
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSalEntFut: TEditFocus
      Left = 626
      Top = 44
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnExiEstrutura: TBitBtnLocked
      Left = 760
      Top = 204
      Width = 136
      Height = 23
      Caption = '[ Alt + F8 ] Exibir Estrutura'
      TabOrder = 34
      Visible = False
      OnClick = btnExiEstruturaClick
    end
    object dbeTmpGar: TDBEditFocus
      Left = 74
      Top = 157
      Width = 50
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeInfGar: TDBEditFocus
      Left = 245
      Top = 157
      Width = 271
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnVendasPerdidas: TBitBtnLocked
      Left = 760
      Top = 157
      Width = 136
      Height = 23
      Caption = '&Vendas Perdidas'
      TabOrder = 20
      OnClick = btnVendasPerdidasClick
    end
    object edtSalDisCD: TEditFocus
      Left = 707
      Top = 124
      Width = 105
      Height = 27
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = 19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 35
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMinPro: TEditFocus
      Left = 626
      Top = 90
      Width = 75
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object chkItePro: TCheckBox
      Left = 523
      Top = 160
      Width = 178
      Height = 17
      Caption = 'Listar apenas itens em promo'#231#227'o?'
      TabOrder = 19
      OnClick = chkIteProClick
    end
    object dbeLocFis: TDBEdit
      Left = 74
      Top = 135
      Width = 406
      Height = 21
      TabStop = False
      Color = 16768952
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 36
    end
    object btnMetragem: TBitBtnLocked
      Left = 895
      Top = 157
      Width = 108
      Height = 23
      Caption = '[ F1 ] Metragem'
      TabOrder = 37
      Visible = False
      OnClick = btnMetragemClick
    end
  end
  object pnlUltCom: TPanel [5]
    Left = 0
    Top = 314
    Width = 1016
    Height = 57
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 303
    ExplicitWidth = 1008
    object grpUltFornecedor: TGroupBox
      Left = 1
      Top = 1
      Width = 1006
      Height = 55
      Align = alClient
      Caption = 'Dados da '#218'ltima Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label10: TLabel
        Left = 9
        Top = 12
        Width = 22
        Height = 14
        Caption = 'Data'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 153
        Top = 12
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 81
        Top = 12
        Width = 52
        Height = 14
        Caption = 'Pr. Compra'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object edtDesForUlt: TEditFocus
        Left = 225
        Top = 27
        Width = 282
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDTAULT: TEditFocus
        Left = 9
        Top = 27
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPREULT: TEditFocus
        Left = 81
        Top = 27
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFORULT: TEditFocus
        Left = 153
        Top = 27
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited Relogio: TTimer
    Left = 488
    Top = 40
  end
  inherited qryConsulta: TUniQuery
    Left = 456
    Top = 40
  end
  inherited dtsConsulta: TDataSource
    AutoEdit = False
    Left = 520
    Top = 40
  end
  object tmrFiltro: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrFiltroTimer
    Left = 488
    Top = 72
  end
end
