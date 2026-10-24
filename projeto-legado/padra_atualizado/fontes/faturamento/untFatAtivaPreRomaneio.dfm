inherited frmFatAtivaPreRomaneio: TfrmFatAtivaPreRomaneio
  Left = 148
  Top = 137
  Width = 915
  Height = 448
  BorderIcons = [biSystemMenu]
  Caption = 'Ativa'#231#227'o de Pr'#233'-Romaneio'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 915
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 374
    Width = 909
    Height = 29
    TabOrder = 3
    ExplicitTop = 374
    ExplicitWidth = 909
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 905
      Height = 25
      ExplicitWidth = 905
      ExplicitHeight = 25
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 169
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Ativar Pr'#233'-Romaneio'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnGerarNovoPreRomaneio: TBitBtnLocked
        Left = 169
        Top = 0
        Width = 174
        Height = 22
        Align = alLeft
        Caption = '[ F2 ] Gerar Novo Pr'#233'-Romaneio'
        TabOrder = 1
        OnClick = btnGerarNovoPreRomaneioClick
      end
      object btnAdicionarNaoEntregues: TBitBtnLocked
        Left = 343
        Top = 0
        Width = 248
        Height = 22
        Align = alLeft
        Caption = '[ F3 ] Adicionar Documento(s) n'#227'o entregue(s)'
        TabOrder = 2
        OnClick = btnAdicionarNaoEntreguesClick
      end
      object btnCancelarAtivacao: TBitBtnLocked
        Left = 591
        Top = 0
        Width = 134
        Height = 22
        Align = alLeft
        Caption = '[ F4 ] Cancelar Ativa'#231#227'o'
        Enabled = False
        TabOrder = 3
        OnClick = btnCancelarAtivacaoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 816
      Width = 90
      ExplicitLeft = 816
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 909
    TabOrder = 2
    ExplicitTop = 403
    ExplicitWidth = 909
    inherited pnlNomeForm: TPanel
      Left = 738
      ExplicitLeft = 738
    end
    inherited pnlInfo: TPanel
      Width = 738
      ExplicitWidth = 738
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 909
    Height = 56
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblRomaneio: TLabel
      Left = 8
      Top = 7
      Width = 47
      Height = 14
      Caption = 'Romaneio'
    end
    object lblAviso: TLabel
      Left = 250
      Top = 22
      Width = 509
      Height = 16
      Alignment = taRightJustify
      Caption = 
        'Este Romaneio j'#225' foi ativado. Ser'#225' permitido reimprimir ou cance' +
        'lar a ativa'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 141
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
  end
  object dbgDocumentos: TDBGridCitel [3]
    Left = 0
    Top = 56
    Width = 909
    Height = 318
    TabStop = False
    Align = alClient
    DataSource = dtsDocumentos
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_ROMIMP'
        Title.Caption = 'Impress.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data Entrada'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 207
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Title.Caption = 'Cidade'
        Width = 161
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODVEN'
        Title.Caption = 'Vend.'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRA_NOMTRA'
        Title.Caption = 'Transportadora'
        Width = 122
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 78
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 583
    Top = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 616
    Top = 320
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 647
    Top = 288
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentos'
    AfterOpen = cdsDocumentosAfterOpen
    Left = 679
    Top = 320
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 647
    Top = 320
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 615
    Top = 288
  end
  object qryItens: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 711
    Top = 288
  end
  object dspItens: TUniDataSetProvider
    DataSet = qryItens
    Options = []
    Left = 743
    Top = 288
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 711
    Top = 320
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 743
    Top = 320
  end
end
