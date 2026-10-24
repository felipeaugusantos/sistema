inherited frmDadosExportacao: TfrmDadosExportacao
  Width = 669
  Height = 153
  Caption = 'Dados complementares para Nota de Exporta'#231#227'o'
  ExplicitWidth = 669
  ExplicitHeight = 153
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 36
    Top = 7
    Width = 227
    Height = 14
    Caption = 'UF Embarque ou de Transposi'#231#227'o de Fronteira:'
  end
  object Label4: TLabel [1]
    Left = 8
    Top = 30
    Width = 255
    Height = 14
    Caption = 'Local de Embarque ou de Transposi'#231#227'o de Fronteira:'
  end
  object Label5: TLabel [2]
    Left = 24
    Top = 48
    Width = 239
    Height = 28
    Alignment = taRightJustify
    Caption = 
      'Descri'#231#227'o do Local de Despacho (Informa'#231#227'o do Recinto Alfandegad' +
      'o):'
    WordWrap = True
  end
  inherited pnlBotoes: TPanel
    Top = 82
    Width = 663
    TabOrder = 3
    ExplicitTop = 82
    ExplicitWidth = 663
    inherited FlwBotoes: TFlowPanel
      Width = 659
      ExplicitTop = 2
      ExplicitWidth = 659
    end
    inherited btnSair: TBitBtnLocked
      Left = 580
      ExplicitLeft = 580
    end
  end
  inherited pnlStatus: TPanel
    Top = 108
    Width = 663
    TabOrder = 4
    ExplicitTop = 108
    ExplicitWidth = 663
    inherited pnlNomeForm: TPanel
      Left = 492
      ExplicitLeft = 492
    end
    inherited pnlInfo: TPanel
      Width = 492
      ExplicitWidth = 492
    end
  end
  object edtLoEmba: TEditFocus [6]
    Tag = 99
    Left = 269
    Top = 27
    Width = 384
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 60
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtLocDes: TEditFocus [7]
    Tag = 99
    Left = 269
    Top = 52
    Width = 384
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 60
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object cbbUFEmba: TComboBoxFocus [8]
    Tag = 99
    Left = 269
    Top = 3
    Width = 41
    Height = 22
    Style = csDropDownList
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 0
    Items.Strings = (
      'AC'
      'AL'
      'AM'
      'AP'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MG'
      'MS'
      'MT'
      'PA'
      'PB'
      'PE'
      'PI'
      'PR'
      'RJ'
      'RN'
      'RO'
      'RR'
      'RS'
      'SC'
      'SP'
      'TO'
      'SE')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 0
  end
end
