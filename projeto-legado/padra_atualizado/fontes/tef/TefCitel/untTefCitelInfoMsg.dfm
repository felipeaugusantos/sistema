inherited frmTefCitelInfoMsg: TfrmTefCitelInfoMsg
  Width = 440
  Height = 217
  AlphaBlendValue = 230
  BorderIcons = []
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 440
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  object lbStatusTef: TLabel [0]
    Left = 11
    Top = 47
    Width = 413
    Height = 65
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  inherited pnlBotoes: TPanel
    Top = 188
    Width = 434
    ExplicitTop = 188
    ExplicitWidth = 434
    inherited FlwBotoes: TFlowPanel
      Width = 430
      ExplicitWidth = 430
    end
  end
  inherited pgcDados: TPageControl
    Left = 602
    Top = 514
    Width = 130
    Height = 76
    Align = alNone
    Visible = False
    ExplicitLeft = 602
    ExplicitTop = 514
    ExplicitWidth = 130
    ExplicitHeight = 76
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 122
      ExplicitHeight = 44
    end
  end
  inherited pnlStatus: TPanel
    Top = 508
    Align = alNone
    Visible = False
    ExplicitTop = 508
    inherited pnlNomeForm: TPanel
      Visible = False
    end
    inherited pnlInfo: TPanel
      Visible = False
    end
  end
  object ListBox1: TListBox [5]
    Left = 159
    Top = 248
    Width = 426
    Height = 209
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ItemHeight = 18
    ParentFont = False
    TabOrder = 4
  end
  object btnEncerraMenu: TBitBtnLocked [6]
    AlignWithMargins = True
    Left = 140
    Top = 140
    Width = 158
    Height = 27
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnEncerraMenuClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 256
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 16
  end
  object dsMsg: TDataSource
    DataSet = CdsMsg
    Left = 376
    Top = 240
  end
  object CdsMsg: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 240
    object CdsMsgMSG: TStringField
      FieldName = 'MSG'
      Size = 300
    end
  end
  object tmrDesabilitaBotao: TTimer
    Interval = 500
    OnTimer = tmrDesabilitaBotaoTimer
    Left = 352
    Top = 136
  end
end
