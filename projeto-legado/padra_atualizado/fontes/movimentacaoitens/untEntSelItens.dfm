inherited frmEntSelItens: TfrmEntSelItens
  Left = 156
  Top = 97
  Width = 900
  Height = 558
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Itens do(s) pedidos'
  Position = poMainFormCenter
  OnKeyUp = FormKeyUp
  ExplicitWidth = 900
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 388
    Width = 894
    ExplicitTop = 387
    ExplicitWidth = 894
    DesignSize = (
      894
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 890
      ExplicitTop = 2
      ExplicitWidth = 890
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pgcDados: TPageControl
    Top = 32
    Width = 894
    Height = 356
    TabStop = False
    Visible = False
    ExplicitTop = 32
    ExplicitWidth = 894
    ExplicitHeight = 355
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 886
      ExplicitHeight = 323
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 894
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'SELE'#199#195'O DE ITENS DOS PEDIDOS'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  object dbgItens: TDBGridCitel [4]
    Left = 0
    Top = 32
    Width = 894
    Height = 356
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnDblClick = dbgItensDblClick
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ENT_NUMPED'
        ReadOnly = True
        Title.Caption = 'Nro. Pedido'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CODEMP'
        ReadOnly = True
        Title.Caption = 'Emp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CODITE'
        ReadOnly = True
        Title.Caption = 'Item'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_CODFAB'
        Title.Caption = 'C'#243'd. F'#225'b.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o / Refer'#234'ncia'
        Width = 183
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENT_NUMLOT'
        Title.Caption = 'Lote'
        Width = 60
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_CODUNI'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'UN'
        Width = 20
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_UNITAR'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit'#225'rio'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_TOTSUB'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Sub.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_VALIPI'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Total IPI'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Itens'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ENT_TOTGER'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Geral'
        Visible = True
      end>
  end
  object pnlBotoesSelecao: TPanel [5]
    Left = 0
    Top = 487
    Width = 894
    Height = 26
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object btnSairSelecao: TBitBtnLocked
      Left = 781
      Top = 2
      Width = 111
      Height = 22
      Align = alRight
      Caption = '[ ESC ] Sair'
      TabOrder = 1
      OnClick = btnSairSelecaoClick
      ExplicitTop = 24
    end
    object FlwPnlBotoesSelecao: TFlowPanel
      Left = 2
      Top = 2
      Width = 779
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitTop = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 111
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarca: TBitBtnLocked
        Left = 111
        Top = 0
        Width = 111
        Height = 22
        Caption = '[ F9 ] Marca Tudo'
        TabOrder = 1
        OnClick = btnMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 222
        Top = 0
        Width = 111
        Height = 22
        Caption = '[ F8 ] Desmarca Tudo'
        TabOrder = 2
        OnClick = btnDesmarcaClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 333
        Top = 0
        Width = 112
        Height = 22
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 3
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 445
        Top = 0
        Width = 124
        Height = 22
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 4
        OnClick = btnLocProxClick
      end
    end
  end
  object pnlDadosInformativos: TPanel [6]
    Left = 0
    Top = 429
    Width = 894
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 428
    object Label6: TLabel
      Left = 9
      Top = 15
      Width = 101
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Itens Selecionados:'
    end
    object Label21: TLabel
      Left = 618
      Top = 16
      Width = 89
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 235
      Top = 15
      Width = 62
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Itens:'
    end
    object Label4: TLabel
      Left = 504
      Top = 16
      Width = 48
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total IPI:'
    end
    object Label1: TLabel
      Left = 384
      Top = 18
      Width = 48
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Sub:'
    end
    object edtIteSel: TEditFocus
      Left = 114
      Top = 8
      Width = 47
      Height = 22
      TabStop = False
      Alignment = taCenter
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtTotIte: TEditFocus
      Left = 300
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
    object edtTotIpi: TEditFocus
      Left = 555
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotGer: TEditFocus
      Left = 711
      Top = 7
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotSub: TEditFocus
      Left = 435
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [7]
    Left = 0
    Top = 388
    Width = 894
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    ExplicitTop = 387
    object Label3: TLabel
      Left = 9
      Top = 21
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label5: TLabel
      Left = 590
      Top = 21
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object DBEdit1: TDBEdit
      Left = 648
      Top = 13
      Width = 137
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'ENT_REFERE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 64
      Top = 12
      Width = 517
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'ENT_DESITE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 894
    ExplicitTop = 512
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 733
      Width = 161
      ExplicitLeft = 733
      ExplicitWidth = 161
    end
    inherited pnlInfo: TPanel
      Width = 733
      ExplicitWidth = 733
    end
  end
  object Panel2: TPanel [9]
    Left = 0
    Top = 465
    Width = 894
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 9
    ExplicitLeft = -2
    ExplicitTop = 464
    object lblMarca: TLabel
      Left = 9
      Top = 6
      Width = 207
      Height = 14
      Caption = '[ENTER] Marca / Desmarca Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMarcaParc: TLabel
      Left = 235
      Top = 6
      Width = 228
      Height = 14
      Caption = '[ESPA'#199'O] Altera Quantidade/Valor Unit'#225'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 176
    Top = 88
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ENT_NUMSEL;ENT_NUMPED;ENT_SEQPCD'
    Params = <>
    ProviderName = 'dspItens'
    BeforeInsert = cdsItensBeforeInsert
    BeforeEdit = cdsItensBeforeEdit
    Left = 456
    Top = 144
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 488
    Top = 144
  end
  object dspItens: TUniDataSetProvider
    Options = []
    Left = 424
    Top = 144
  end
  object cdsTotais: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Filter = 'ENT_MARDES = '#39'M'#39
    Params = <>
    Left = 456
    Top = 184
  end
end
