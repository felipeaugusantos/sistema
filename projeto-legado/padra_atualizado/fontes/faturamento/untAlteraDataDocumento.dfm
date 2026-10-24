inherited frmAlteraDataDocumento: TfrmAlteraDataDocumento
  Width = 465
  Height = 208
  Caption = 'Altera'#231#227'o da data de entrega'
  ExplicitWidth = 465
  ExplicitHeight = 208
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 50
    Top = 82
    Width = 35
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cliente:'
  end
  object Label18: TLabel [1]
    Left = 28
    Top = 7
    Width = 57
    Height = 14
    Alignment = taRightJustify
    Caption = 'Documento:'
  end
  object Label19: TLabel [2]
    Left = 44
    Top = 32
    Width = 41
    Height = 14
    Alignment = taRightJustify
    Caption = 'Esp'#233'cie:'
  end
  object lblEmpresa: TLabel [3]
    Left = 41
    Top = 58
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
  object lblDatEnt: TLabel [4]
    Left = 6
    Top = 111
    Width = 80
    Height = 14
    Alignment = taRightJustify
    Caption = 'Data da Entrega:'
  end
  inherited pnlBotoes: TPanel
    Top = 137
    Width = 459
    TabOrder = 7
    inherited FlwBotoes: TFlowPanel
      Width = 455
      ExplicitLeft = -2
      ExplicitTop = -2
      ExplicitWidth = 1156
    end
    inherited btnSair: TBitBtnLocked
      Left = 376
    end
  end
  inherited pnlStatus: TPanel
    Top = 163
    Width = 459
    TabOrder = 8
    inherited pnlNomeForm: TPanel
      Left = 288
    end
    inherited pnlInfo: TPanel
      Width = 288
      ExplicitLeft = -296
      ExplicitTop = 632
      ExplicitWidth = 288
    end
  end
  object edtCodCli: TEditFocus [8]
    Tag = 99
    Left = 89
    Top = 78
    Width = 80
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtNomCli: TEditFocus [9]
    Left = 175
    Top = 78
    Width = 275
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNumDoc: TEditFocus [10]
    Tag = 99
    Left = 89
    Top = 3
    Width = 80
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object edtEspDoc: TEditFocus [11]
    Tag = 99
    Left = 89
    Top = 28
    Width = 31
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 2
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 2
    TipoTexto = ttAlfabetico
  end
  object edtCodEmp: TEditFocus [12]
    Tag = 99
    Left = 89
    Top = 53
    Width = 29
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
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesEmp: TEditFocus [13]
    Left = 124
    Top = 53
    Width = 327
    Height = 22
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskDtaEntFut: TMaskEditFocus [14]
    Tag = 99
    Left = 89
    Top = 103
    Width = 61
    Height = 22
    CharCase = ecUpperCase
    EditMask = '99/99/9999'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    ParentFont = False
    TabOrder = 6
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 142
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 152
  end
end
