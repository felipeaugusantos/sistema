inherited frmCadAjustIcm: TfrmCadAjustIcm
  Width = 638
  Height = 519
  Caption = 'Ajuste de Icms'
  Position = poScreenCenter
  ExplicitWidth = 638
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  object Label40: TLabel [0]
    Left = 4
    Top = 4
    Width = 51
    Height = 14
    Caption = 'M'#234's / Ano:'
  end
  object Label1: TLabel [1]
    Left = 5
    Top = 90
    Width = 28
    Height = 14
    Caption = 'Valor:'
  end
  object Label7: TLabel [2]
    Left = 3
    Top = 136
    Width = 63
    Height = 14
    Caption = 'Observa'#231#227'o:'
  end
  object lblEmpresa: TLabel [3]
    Left = 4
    Top = 183
    Width = 42
    Height = 14
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [4]
    Left = 4
    Top = 49
    Width = 69
    Height = 14
    Caption = 'C'#243'digo Ajuste:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel [5]
    Left = 192
    Top = 90
    Width = 57
    Height = 14
    Alignment = taRightJustify
    Caption = 'Documento:'
  end
  object Label3: TLabel [6]
    Left = 281
    Top = 90
    Width = 25
    Height = 14
    Alignment = taRightJustify
    Caption = 'S'#233'rie'
  end
  object Label4: TLabel [7]
    Left = 333
    Top = 90
    Width = 18
    Height = 14
    Alignment = taRightJustify
    Caption = 'Esp'
  end
  inherited pnlBotoes: TPanel
    Top = 449
    Width = 632
    Height = 25
    TabOrder = 12
    ExplicitTop = 449
    ExplicitWidth = 632
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 628
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 628
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
      object btnInfAdic: TBitBtnLocked
        Left = 444
        Top = 0
        Width = 93
        Height = 20
        Caption = 'Inf.Adic.(E112)'
        TabOrder = 6
        OnClick = btnInfAdicClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 560
      Width = 70
      Height = 20
      ExplicitLeft = 560
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 474
    Width = 632
    TabOrder = 11
    ExplicitTop = 474
    ExplicitWidth = 632
    inherited pnlNomeForm: TPanel
      Left = 466
      Width = 166
      TabOrder = 1
      ExplicitLeft = 466
      ExplicitWidth = 166
    end
    inherited pnlInfo: TPanel
      Width = 466
      TabOrder = 0
      ExplicitWidth = 466
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    ActivePage = nil
    Align = alNone
    TabOrder = 13
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbgrdAjuIcm: TDBGridCitel [11]
    Left = 0
    Top = 232
    Width = 632
    Height = 217
    Align = alBottom
    DataSource = dtsAjuIcm
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgrdAjuIcmKeyDown
    OnKeyPress = dbgrdAjuIcmKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'AJU_MESANO'
        Title.Caption = 'M'#234's / Ano'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJU_CODAJU'
        Title.Caption = 'C'#243'digo'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJU_VALAJU'
        Title.Caption = 'Valor'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJU_CODEMP'
        Title.Caption = 'Empr.'
        Width = 38
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJU_OBSERV'
        Title.Caption = 'Observa'#231#227'o'
        Width = 194
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJU_NUMNOT'
        Title.Caption = 'Nota Fiscal'
        Width = 109
        Visible = True
      end>
  end
  object edtdbeMesAno: TDBEditFocus [12]
    Tag = 99
    Left = 3
    Top = 19
    Width = 70
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJU_MESANO'
    DataSource = dtsAjuIcm
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttNumerico
  end
  object edtValAju: TDBEditFocus [13]
    Tag = 99
    Left = 4
    Top = 107
    Width = 95
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJU_VALAJU'
    DataSource = dtsAjuIcm
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttNumerico
  end
  object edtObserv: TDBEditFocus [14]
    Tag = 99
    Left = 3
    Top = 152
    Width = 467
    Height = 22
    DataField = 'AJU_OBSERV'
    DataSource = dtsAjuIcm
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    PanelInfo = pnlInfo
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmpresa: TEditFocus [15]
    Tag = 99
    Left = 4
    Top = 197
    Width = 37
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
    TabOrder = 8
    OnExit = edtCodEmpresaExit
    OnKeyPress = edtCodEmpresaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesEmpresa: TEditFocus [16]
    Left = 43
    Top = 197
    Width = 427
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodAju: TEditFocus [17]
    Tag = 99
    Left = 4
    Top = 63
    Width = 95
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
    MaxLength = 10
    ParentFont = False
    TabOrder = 1
    OnExit = edtCodAjuExit
    OnKeyPress = edtCodAjuKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 10
    TipoTexto = ttAlfanumerico
  end
  object edtDesAju: TEditFocus [18]
    Left = 102
    Top = 63
    Width = 368
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 2
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNumDoc: TEditFocus [19]
    Tag = 99
    Left = 193
    Top = 107
    Width = 83
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 12
    TabOrder = 4
    OnExit = edtNumDocExit
    OnKeyPress = edtNumDocKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 12
    TipoTexto = ttAlfanumerico
  end
  object edtSerie: TEditFocus [20]
    Tag = 99
    Left = 278
    Top = 107
    Width = 50
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 5
    OnExit = edtSerieExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtEspDoc: TEditFocus [21]
    Tag = 99
    Left = 329
    Top = 107
    Width = 26
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 2
    TabOrder = 6
    OnExit = edtEspDocExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 2
    TipoTexto = ttAlfabetico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 443
    Top = 7
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 539
    Top = 7
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 475
    Top = 8
  end
  object dtsAjuIcm: TDataSource
    OnStateChange = dtsAjuIcmStateChange
    Left = 405
    Top = 7
  end
  object cdsAdiAju: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 350
    Top = 7
    object cdsAdiAjuAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAdiAjuAJU_CODEMP: TStringField
      FieldName = 'AJU_CODEMP'
      Size = 3
    end
    object cdsAdiAjuAJU_MESANO: TStringField
      FieldName = 'AJU_MESANO'
      Size = 6
    end
    object cdsAdiAjuAJU_NUMDAE: TStringField
      FieldName = 'AJU_NUMDAE'
      Size = 250
    end
    object cdsAdiAjuAJU_NUMPAV: TStringField
      FieldName = 'AJU_NUMPAV'
      Size = 60
    end
    object cdsAdiAjuAJU_INDORI: TStringField
      FieldName = 'AJU_INDORI'
      Size = 1
    end
    object cdsAdiAjuAJU_DESAJU: TStringField
      FieldName = 'AJU_DESAJU'
      Size = 250
    end
    object cdsAdiAjuAJU_COMPLE: TStringField
      FieldName = 'AJU_COMPLE'
      Size = 250
    end
  end
end
