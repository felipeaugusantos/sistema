inherited frmCadAjuDet: TfrmCadAjuDet
  Width = 814
  Height = 375
  Caption = 'Cadastro - Ajuste detalhado (Sped fiscal) '
  ExplicitWidth = 814
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 14
  object lblCodAju: TLabel [0]
    Left = 5
    Top = 4
    Width = 58
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'd. Ajuste:'
  end
  object lblDesAju: TLabel [1]
    Left = 89
    Top = 4
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object lblBasIcm: TLabel [2]
    Left = 89
    Top = 43
    Width = 55
    Height = 14
    Alignment = taRightJustify
    Caption = 'Base ICMS:'
  end
  object lblAlqIcm: TLabel [3]
    Left = 173
    Top = 43
    Width = 49
    Height = 14
    Alignment = taRightJustify
    Caption = 'Alq. ICMS:'
  end
  object lblValIcm: TLabel [4]
    Left = 256
    Top = 43
    Width = 55
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor ICMS:'
  end
  object lblOutros: TLabel [5]
    Left = 339
    Top = 43
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'Outros:'
  end
  object Label4: TLabel [6]
    Left = 5
    Top = 43
    Width = 44
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'd. Item'
  end
  inherited pnlBotoes: TPanel
    Top = 305
    Width = 808
    Height = 25
    ExplicitTop = 305
    ExplicitWidth = 808
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 727
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 804
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 100
        Height = 21
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 100
        Width = 100
        Height = 21
        ExplicitLeft = 100
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 200
        Width = 100
        Height = 21
        ExplicitLeft = 200
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 300
        Width = 100
        Height = 21
        ExplicitLeft = 300
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 400
        Width = 100
        Height = 21
        ExplicitLeft = 400
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 500
        Width = 100
        Height = 21
        ExplicitLeft = 500
        ExplicitWidth = 100
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 729
      Height = 21
      Align = alRight
      ExplicitLeft = 729
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object edtCodAju: TDBEditFocus [10]
    Tag = 99
    Left = 5
    Top = 19
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_CD_AJU'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 3
    OnExit = edtCodAjuExit
    OnKeyPress = edtCodAjuKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtBasIcm: TDBEditFocus [11]
    Tag = 99
    Left = 89
    Top = 58
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_BASICM'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 5
    OnExit = edtBasIcmExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtAlqIcm: TDBEditFocus [12]
    Tag = 99
    Left = 173
    Top = 58
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_ALQICM'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 6
    OnExit = edtAlqIcmExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtValIcm: TDBEditFocus [13]
    Tag = 99
    Left = 256
    Top = 58
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_VALICM'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtOutros: TDBEditFocus [14]
    Tag = 99
    Left = 339
    Top = 58
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_OUTROS'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbgrdAjuDet: TDBGridCitel [15]
    Left = 0
    Top = 88
    Width = 808
    Height = 217
    TabStop = False
    Align = alBottom
    DataSource = dtsAjdIcm
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 9
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgrdAjuDetKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'AJD_CD_AJU'
        Title.Caption = 'C'#243'd. Ajuste'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_DESAJU'
        Title.Caption = 'Descri'#231#227'o'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_CODITE'
        Title.Caption = 'C'#243'd. Item'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_BASICM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Base ICMS'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_ALQICM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Alq. ICMS'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_VALICM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor ICMS'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AJD_OUTROS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Outros'
        Width = 100
        Visible = True
      end>
  end
  object edtCodIte: TDBEditFocus [16]
    Tag = 99
    Left = 5
    Top = 58
    Width = 82
    Height = 22
    CharCase = ecUpperCase
    DataField = 'AJD_CODITE'
    DataSource = dtsAjdIcm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 4
    OnKeyPress = edtCodIteKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 330
    Width = 808
    ExplicitTop = 330
    ExplicitWidth = 808
    inherited pnlNomeForm: TPanel
      Left = 632
      Width = 176
      ExplicitLeft = 632
      ExplicitWidth = 176
    end
    inherited pnlInfo: TPanel
      Width = 632
      ExplicitWidth = 632
    end
  end
  object edtDesAju: TEditFocus [18]
    Left = 89
    Top = 19
    Width = 332
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 744
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 808
    Top = 224
  end
  object dtsAjdIcm: TDataSource
    OnDataChange = dtsAjdIcmDataChange
    Left = 531
    Top = 87
  end
end
