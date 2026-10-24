inherited frmCfgContele: TfrmCfgContele
  Width = 444
  Height = 230
  Caption = 'Configura'#231#245'es Api Contele'
  ExplicitWidth = 444
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  object lblBaseUrl: TLabel [0]
    Left = 19
    Top = 13
    Width = 84
    Height = 14
    Caption = 'URL do ambiente:'
  end
  object lblApikey: TLabel [1]
    Left = 62
    Top = 38
    Width = 41
    Height = 14
    Caption = 'Api Key:'
  end
  object lblToken: TLabel [2]
    Left = 8
    Top = 65
    Width = 97
    Height = 14
    Caption = 'Token Authorization:'
  end
  inherited pnlBotoes: TPanel
    Top = 159
    Width = 438
    TabOrder = 3
    ExplicitTop = 159
    ExplicitWidth = 438
    inherited FlwBotoes: TFlowPanel
      Width = 434
      ExplicitWidth = 434
    end
    inherited btnSair: TBitBtnLocked
      Left = 355
      ExplicitLeft = 355
    end
  end
  inherited pnlStatus: TPanel
    Top = 185
    Width = 438
    TabOrder = 4
    ExplicitTop = 185
    ExplicitWidth = 438
    inherited pnlNomeForm: TPanel
      Left = 267
      ExplicitLeft = 267
    end
    inherited pnlInfo: TPanel
      Width = 267
      ExplicitWidth = 267
    end
  end
  object edtBaseUrl: TEditFocus [5]
    Left = 106
    Top = 9
    Width = 322
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    Text = 'https://integration.contelege.com.br'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtApiKey: TEditFocus [6]
    Left = 106
    Top = 34
    Width = 322
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mmoTokenAuth: TMemoFocus [7]
    Left = 106
    Top = 59
    Width = 322
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 584
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 96
  end
end
