inherited frmDigTempAtendimento: TfrmDigTempAtendimento
  Width = 586
  Height = 118
  Caption = 'Informe a Temperatura do Atendimento'
  ExplicitWidth = 586
  ExplicitHeight = 118
  PixelsPerInch = 96
  TextHeight = 14
  object lblTemperaturaAtend: TLabel [0]
    Left = 9
    Top = 12
    Width = 140
    Height = 14
    Alignment = taRightJustify
    Caption = 'Temperatura do Atendimento:'
  end
  inherited pnlBotoes: TPanel
    Top = 47
    Width = 580
    ExplicitTop = 47
    ExplicitWidth = 580
    inherited FlwBotoes: TFlowPanel
      Width = 576
      ExplicitWidth = 576
    end
    inherited btnSair: TBitBtnLocked
      Left = 497
      ExplicitLeft = 497
    end
  end
  inherited pnlStatus: TPanel
    Top = 73
    Width = 580
    ExplicitTop = 73
    ExplicitWidth = 580
    inherited pnlNomeForm: TPanel
      Left = 409
      ExplicitLeft = 409
    end
    inherited pnlInfo: TPanel
      Width = 409
      ExplicitWidth = 409
    end
  end
  object edtCodigo: TEditFocus [3]
    Tag = 99
    Left = 155
    Top = 8
    Width = 65
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 2
    OnExit = edtCodigoExit
    OnKeyPress = edtCodigoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttAlfanumerico
  end
  object edtDescri: TEditFocus [4]
    Tag = 99
    Left = 223
    Top = 8
    Width = 345
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 16768952
    MaxLength = 87
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 16
  end
end
