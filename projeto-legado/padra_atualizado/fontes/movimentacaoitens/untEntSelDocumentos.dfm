inherited frmEntSelDocumentos: TfrmEntSelDocumentos
  Left = 165
  Top = 205
  Width = 950
  Height = 600
  Caption = 'Sele'#231#227'o de Documentos'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 950
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 944
    Height = 26
    ExplicitTop = 529
    ExplicitWidth = 944
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 224
      Width = 641
      Height = 22
      TabOrder = 3
      ExplicitTop = 2
      ExplicitWidth = 940
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 865
      Top = 2
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 861
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
      ExplicitTop = 3
    end
    object btnFiltros: TBitBtnLocked
      Left = 113
      Top = 2
      Width = 111
      Height = 22
      Align = alLeft
      Caption = '[ F3 ] Filtros'
      TabOrder = 1
      OnClick = btnFiltrosClick
      ExplicitLeft = 114
      ExplicitTop = 3
    end
  end
  object pnlTitulo: TPanel [2]
    Left = 0
    Top = 0
    Width = 944
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'SELE'#199#195'O DE DOCUMENTOS'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'charter'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object pnlDadosInformativos: TPanel [3]
    Left = 0
    Top = 493
    Width = 944
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitTop = 491
    object Label21: TLabel
      Left = 653
      Top = 15
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 227
      Top = 16
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Itens:'
    end
    object Label4: TLabel
      Left = 520
      Top = 16
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total IPI:'
    end
    object Label1: TLabel
      Left = 370
      Top = 16
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total ICMS.:'
    end
    object dbeTotIte: TDBEdit
      Left = 282
      Top = 7
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTPRO'
      DataSource = dtsDocumentos
      ReadOnly = True
      TabOrder = 0
    end
    object dbeTotIcm: TDBEdit
      Left = 434
      Top = 7
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTICM'
      DataSource = dtsDocumentos
      ReadOnly = True
      TabOrder = 1
    end
    object dbeTotIpi: TDBEdit
      Left = 570
      Top = 7
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTIPI'
      DataSource = dtsDocumentos
      ReadOnly = True
      TabOrder = 2
    end
    object dbeVlrCon: TDBEdit
      Left = 712
      Top = 7
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_VLRCON'
      DataSource = dtsDocumentos
      ReadOnly = True
      TabOrder = 3
    end
  end
  object dbgPedidos: TDBGridCitel [4]
    Left = 0
    Top = 32
    Width = 944
    Height = 428
    Align = alClient
    DataSource = dtsDocumentos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgPedidosDrawColumnCell
    OnKeyDown = dbgPedidosKeyDown
    OnTitleClick = dbgPedidosTitleClick
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Pedido'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODCLI'
        Title.Caption = 'C'#243'd. Cliente'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        Title.Caption = 'Nome Cliente'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CGCCON'
        Title.Caption = 'Cliente/Consumidor'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data Entrada'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_TOTPRO'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tot. Produtos'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tot. Cont'#225'bil'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_TOTICM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tot. ICMS'
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_TOTIPI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Tot. IPI'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODVEN'
        Title.Caption = 'Vendedor'
        Width = 50
        Visible = True
      end>
  end
  object pnlFiltro: TPanel [5]
    Left = 0
    Top = 460
    Width = 944
    Height = 33
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'charter'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    ExplicitTop = 458
    object Label3: TLabel
      Left = 8
      Top = 14
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object Label8: TLabel
      Left = 156
      Top = 13
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 5
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 196
      Top = 5
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 262
      Top = 5
      Width = 252
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 602
      Top = 3
      Width = 90
      Height = 25
      Caption = '&Filtrar'
      TabOrder = 3
      OnClick = btnFiltrarClick
    end
    object btnLimpFiltros: TBitBtnLocked
      Left = 693
      Top = 3
      Width = 90
      Height = 25
      Caption = '&Limpar Filtros'
      TabOrder = 4
      OnClick = btnLimpFiltrosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 944
    ExplicitTop = 555
    ExplicitWidth = 944
    inherited pnlNomeForm: TPanel
      Left = 773
      ExplicitLeft = 773
    end
    inherited pnlInfo: TPanel
      Width = 773
      ExplicitWidth = 773
    end
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 192
    Top = 88
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 288
    Top = 88
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 224
    Top = 88
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspDocumentos'
    Left = 256
    Top = 88
  end
end
