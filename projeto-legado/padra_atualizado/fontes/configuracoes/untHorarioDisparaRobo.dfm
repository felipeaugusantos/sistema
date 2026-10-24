inherited frmHorarioDisparaRobo: TfrmHorarioDisparaRobo
  Width = 252
  Height = 110
  Caption = 'Hor'#225'rio'
  ExplicitWidth = 252
  ExplicitHeight = 110
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 39
    Width = 246
    BevelInner = bvNone
    Color = 16770261
    TabOrder = 1
    ExplicitTop = 39
    ExplicitWidth = 246
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 244
      Height = 24
      Color = 16770261
      ParentBackground = False
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 244
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 167
      Height = 23
      ExplicitLeft = 167
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 65
    Width = 246
    TabOrder = 2
    ExplicitTop = 65
    ExplicitWidth = 246
    inherited pnlNomeForm: TPanel
      Left = 75
      ExplicitLeft = 75
    end
    inherited pnlInfo: TPanel
      Width = 75
      ExplicitWidth = 75
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 246
    Height = 39
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 20
    object Label1: TLabel
      Left = 117
      Top = 11
      Width = 33
      Height = 15
      Caption = 'Final: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 11
      Width = 35
      Height = 15
      Caption = 'Inicial:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object HroInicial: TcxTimeEdit
      Tag = 99
      Left = 44
      Top = 8
      Properties.SpinButtons.Visible = False
      Properties.TimeFormat = tfHourMin
      TabOrder = 0
      Width = 65
    end
    object HroFim: TcxTimeEdit
      Tag = 99
      Left = 149
      Top = 8
      Properties.SpinButtons.Visible = False
      Properties.TimeFormat = tfHourMin
      TabOrder = 1
      Width = 65
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 464
    Top = 128
  end
end
