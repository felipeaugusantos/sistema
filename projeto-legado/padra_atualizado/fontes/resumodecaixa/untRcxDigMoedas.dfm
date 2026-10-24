inherited frmRcxDigMoedas: TfrmRcxDigMoedas
  Left = 465
  Top = 285
  Width = 214
  Height = 257
  ActiveControl = edtGuarani
  Caption = 'Especifique os totais '
  ExplicitWidth = 214
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 14
  object Label9: TLabel [0]
    Left = 31
    Top = 26
    Width = 42
    Height = 14
    Alignment = taRightJustify
    Caption = 'Dinheiro:'
  end
  object Label1: TLabel [1]
    Left = 27
    Top = 49
    Width = 47
    Height = 14
    Alignment = taRightJustify
    Caption = 'Guaranie:'
  end
  object Label2: TLabel [2]
    Left = 44
    Top = 72
    Width = 28
    Height = 14
    Alignment = taRightJustify
    Caption = 'Dolar:'
  end
  object Label3: TLabel [3]
    Left = 45
    Top = 95
    Width = 25
    Height = 14
    Alignment = taRightJustify
    Caption = 'Euro:'
  end
  object Label4: TLabel [4]
    Left = 44
    Top = 118
    Width = 27
    Height = 14
    Alignment = taRightJustify
    Caption = 'Peso:'
  end
  object Label5: TLabel [5]
    Left = 47
    Top = 141
    Width = 24
    Height = 14
    Alignment = taRightJustify
    Caption = 'Real:'
  end
  object Label6: TLabel [6]
    Left = 11
    Top = 159
    Width = 63
    Height = 14
    Alignment = taRightJustify
    Caption = 'Total Dig. G$:'
  end
  inherited pnlBotoes: TPanel
    Top = 185
    Width = 208
    ExplicitTop = 185
    ExplicitWidth = 208
    DesignSize = (
      208
      28)
    inherited btnSair: TBitBtnLocked
      Left = 125
      TabOrder = 1
      ExplicitLeft = 125
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 87
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 213
    Width = 208
    ExplicitTop = 213
    ExplicitWidth = 208
    inherited pnlNomeForm: TPanel
      Left = 37
      ExplicitLeft = 37
    end
    inherited pnlInfo: TPanel
      Width = 37
      ExplicitWidth = 37
    end
  end
  object edtDinheiro: TEditFocus [9]
    Tag = 99
    Left = 77
    Top = 16
    Width = 85
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtGuarani: TEditFocus [10]
    Tag = 99
    Left = 77
    Top = 39
    Width = 85
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    TabOrder = 3
    OnExit = edtGuaraniExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtDolar: TEditFocus [11]
    Tag = 99
    Left = 77
    Top = 62
    Width = 85
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    TabOrder = 4
    OnExit = edtDolarExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtEuro: TEditFocus [12]
    Tag = 99
    Left = 77
    Top = 85
    Width = 85
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    TabOrder = 5
    OnExit = edtEuroExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtPeso: TEditFocus [13]
    Tag = 99
    Left = 77
    Top = 108
    Width = 85
    Height = 22
    Alignment = taRightJustify
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
    OnExit = edtPesoExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtReal: TEditFocus [14]
    Tag = 99
    Left = 77
    Top = 131
    Width = 85
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    TabOrder = 7
    OnExit = edtRealExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtTotDig: TEditFocus [15]
    Tag = 99
    Left = 78
    Top = 154
    Width = 85
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 12
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
end
