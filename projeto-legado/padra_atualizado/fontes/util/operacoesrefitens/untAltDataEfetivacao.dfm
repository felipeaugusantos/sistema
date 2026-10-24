inherited frmAltDataEfetivacao: TfrmAltDataEfetivacao
  Width = 225
  Height = 139
  Caption = 'Altera'#231#227'o da Data de Efetiva'#231#227'o'
  ExplicitWidth = 225
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 17
    Top = 27
    Width = 122
    Height = 14
    Alignment = taRightJustify
    Caption = 'Nova Data de Efetiva'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 67
    Width = 219
    TabOrder = 1
    inherited btnSair: TBitBtnLocked
      Left = 136
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 219
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 48
    end
    inherited pnlInfo: TPanel
      Width = 48
    end
  end
  object mskDtaPre: TMaskEditFocus [4]
    Tag = 99
    Left = 142
    Top = 23
    Width = 63
    Height = 22
    CharCase = ecUpperCase
    EditMask = '99/99/9999'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 304
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 32
  end
end
