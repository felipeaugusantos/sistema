inherited frmCadFilaAtenderBem: TfrmCadFilaAtenderBem
  Width = 602
  Height = 197
  Caption = 'Cadastro de Fila - Whatsapp'
  ExplicitWidth = 602
  ExplicitHeight = 197
  PixelsPerInch = 96
  TextHeight = 14
  object lblID: TLabel [0]
    Left = 92
    Top = 20
    Width = 12
    Height = 14
    Alignment = taRightJustify
    Caption = 'ID:'
  end
  object lblFila: TLabel [1]
    Left = 85
    Top = 44
    Width = 19
    Height = 14
    Caption = 'Fila:'
  end
  object lblKey: TLabel [2]
    Left = 68
    Top = 68
    Width = 36
    Height = 14
    Caption = 'apiKey:'
  end
  object lblCodEmp: TLabel [3]
    Left = 59
    Top = 94
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 124
    Width = 596
    ExplicitTop = 124
    ExplicitWidth = 596
    inherited FlwBotoes: TFlowPanel
      Width = 592
      ExplicitTop = 2
      ExplicitWidth = 592
    end
    inherited btnSair: TBitBtnLocked
      Left = 515
      ExplicitLeft = 515
    end
  end
  inherited pnlStatus: TPanel
    Top = 152
    Width = 596
    ExplicitTop = 152
    ExplicitWidth = 596
    inherited pnlNomeForm: TPanel
      Left = 249
      ExplicitLeft = 249
    end
    inherited pnlInfo: TPanel
      Width = 249
      ExplicitWidth = 249
    end
  end
  inherited pgcDados: TPageControl
    Left = -1000
    Top = 68
    Align = alNone
    ExplicitLeft = -1000
    ExplicitTop = 68
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbeIDFila: TDBEditFocus [7]
    Tag = 99
    Left = 107
    Top = 17
    Width = 88
    Height = 22
    CharCase = ecUpperCase
    DataField = 'FIL_IDFILA'
    DataSource = dtsCadFila
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object dbeDesFil: TDBEditFocus [8]
    Tag = 99
    Left = 107
    Top = 41
    Width = 414
    Height = 22
    CharCase = ecUpperCase
    DataField = 'FIL_DESFIL'
    DataSource = dtsCadFila
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeKeyApi: TDBEditFocus [9]
    Tag = 99
    Left = 107
    Top = 65
    Width = 414
    Height = 22
    DataField = 'FIL_KEYAPI'
    DataSource = dtsCadFila
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object chkFilPri: TDBCheckBox [10]
    Tag = 99
    Left = 441
    Top = 18
    Width = 80
    Height = 17
    Caption = 'Fila principal'
    DataField = 'FIL_FILPRI'
    DataSource = dtsCadFila
    TabOrder = 4
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object edtNomEmp: TEditFocus [11]
    Left = 171
    Top = 89
    Width = 350
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 8
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object dbeCodEmp: TDBEditFocus [12]
    Tag = 99
    Left = 107
    Top = 89
    Width = 65
    Height = 22
    CharCase = ecUpperCase
    DataField = 'FIL_CODEMP'
    DataSource = dtsCadFila
    MaxLength = 3
    TabOrder = 7
    OnKeyPress = dbeCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object chkFilaApiOficial: TDBCheckBox [13]
    Tag = 99
    Left = 355
    Top = 18
    Width = 80
    Height = 17
    Caption = 'API Oficial'
    DataField = 'FIL_APIOFI'
    DataSource = dtsCadFila
    TabOrder = 9
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 580
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 580
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 576
    Top = 108
  end
  object dtsCadFila: TDataSource
    Left = 576
    Top = 72
  end
end
