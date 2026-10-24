inherited frmMsgErroSQL: TfrmMsgErroSQL
  Width = 923
  Height = 561
  Caption = 'Instru'#231#227'o SQL inv'#225'lida'
  ExplicitWidth = 923
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 488
    Width = 917
    ExplicitTop = 488
    ExplicitWidth = 917
    inherited FlwBotoes: TFlowPanel
      Width = 913
    end
    inherited btnSair: TBitBtnLocked
      Left = 834
      Caption = 'Sair'
      ExplicitLeft = 834
    end
  end
  inherited pnlStatus: TPanel
    Top = 516
    Width = 917
    ExplicitTop = 516
    ExplicitWidth = 917
    inherited pnlNomeForm: TPanel
      Left = 746
      ExplicitLeft = 746
    end
    inherited pnlInfo: TPanel
      Width = 746
      ExplicitWidth = 746
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 917
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Instru'#231#227'o SQL inv'#225'lida!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    StyleElements = [seClient, seBorder]
  end
  object mmoErrSQL: TMemoFocus [4]
    Left = 0
    Top = 41
    Width = 917
    Height = 447
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    StyleElements = [seFont, seBorder]
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 176
  end
end
