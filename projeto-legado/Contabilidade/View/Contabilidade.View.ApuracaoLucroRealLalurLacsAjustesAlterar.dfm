inherited frmApuracaoLucroRealLalurLacsAjustesAlterar: TfrmApuracaoLucroRealLalurLacsAjustesAlterar
  Width = 627
  Height = 330
  Caption = 'Ajuste Manual'
  ExplicitWidth = 627
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 621
    TabOrder = 6
    ExplicitTop = 259
    ExplicitWidth = 621
    inherited FlwBotoes: TFlowPanel
      Width = 617
      ExplicitWidth = 617
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 541
      ExplicitLeft = 541
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 621
    TabOrder = 9
    ExplicitTop = 285
    ExplicitWidth = 621
    inherited pnlNomeForm: TPanel
      Left = 450
      ExplicitLeft = 450
    end
    inherited pnlInfo: TPanel
      Width = 450
      ExplicitWidth = 450
    end
  end
  object edtARE_DTALAN: TcxDateEdit [2]
    Tag = 99
    Left = 100
    Top = 5
    TabOrder = 0
    Width = 119
  end
  object cxLabel1: TcxLabel [3]
    Left = 62
    Top = 7
    Caption = 'Data: '
  end
  object cxLabel2: TcxLabel [4]
    Left = 8
    Top = 34
    Caption = 'Hist'#243'rico Padr'#227'o:'
  end
  object edtARE_HISPAD: TEditFocus [5]
    Tag = 99
    Left = 100
    Top = 33
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 1
    OnKeyPress = edtARE_HISPADKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object edtDesPad: TEditFocus [6]
    Left = 223
    Top = 33
    Width = 386
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 12
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object cxLabel3: TcxLabel [7]
    Left = 23
    Top = 58
    Caption = 'Complemento:'
  end
  object edtARE_HISTOR: TMemoFocus [8]
    Left = 100
    Top = 61
    Width = 509
    Height = 89
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object cxLabel4: TcxLabel [9]
    Left = 62
    Top = 194
    Caption = 'Valor:'
  end
  object edtARE_VALLAN: TCurrencyEditFocus [10]
    Tag = 99
    Left = 100
    Top = 193
    Properties.DisplayFormat = ' ,0.00;- ,0.00'
    StyleFocused.Color = clInfoBk
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    Width = 121
  end
  object cxLabel5: TcxLabel [11]
    Left = 18
    Top = 156
    Caption = 'Conta Contabil:'
  end
  object edtDesCon: TEditFocus [12]
    Left = 223
    Top = 155
    Width = 386
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 16
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rgARE_TIPLAN: TRadioGroup [13]
    Left = 424
    Top = 183
    Width = 185
    Height = 37
    Caption = 'Tipo'
    Columns = 2
    Enabled = False
    Items.Strings = (
      'Adi'#231#227'o'
      'Exclus'#227'o')
    TabOrder = 7
  end
  object edtARE_CODCON: TMaskEditFocus [14]
    Tag = 99
    Left = 100
    Top = 155
    Width = 121
    Height = 22
    TabOrder = 3
    Text = ''
    OnKeyPress = edtARE_CODCONKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object cxLabel6: TcxLabel [15]
    Left = 10
    Top = 229
    Caption = 'Natureza Ajuste:'
  end
  object edtARE_NATAJU: TEditFocus [16]
    Tag = 99
    Left = 102
    Top = 228
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 8
    OnKeyPress = edtARE_HISPADKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
  end
  object edtDesAju: TEditFocus [17]
    Left = 225
    Top = 228
    Width = 386
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 18
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rgARE_CREDEB: TRadioGroup [18]
    Left = 223
    Top = 183
    Width = 195
    Height = 37
    Caption = 'D/C'
    Columns = 2
    Items.Strings = (
      'Debito'
      'Cr'#233'dito')
    TabOrder = 5
  end
end
