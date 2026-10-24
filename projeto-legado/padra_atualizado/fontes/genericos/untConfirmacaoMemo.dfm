inherited frmConfirmacaoMemo: TfrmConfirmacaoMemo
  Width = 677
  Height = 402
  Caption = 'Caption'
  Position = poMainFormCenter
  ExplicitWidth = 677
  ExplicitHeight = 402
  PixelsPerInch = 96
  TextHeight = 14
  object lblTitulo: TLabel [0]
    Left = 0
    Top = 0
    Width = 671
    Height = 57
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Titulo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 18
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  inherited pnlBotoes: TPanel
    Top = 326
    Width = 671
    Height = 31
    BevelInner = bvNone
    BorderWidth = 2
    ExplicitTop = 326
    ExplicitWidth = 671
    ExplicitHeight = 31
    inherited FlwBotoes: TFlowPanel
      Left = 185
      Top = 3
      Width = 392
      Height = 25
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 667
      ExplicitHeight = 30
    end
    inherited btnSair: TBitBtnLocked
      Left = 577
      Width = 91
      Height = 25
      Align = alRight
      Caption = 'C&ancelar'
      ParentFont = False
      TabOrder = 3
      ExplicitLeft = 572
      ExplicitTop = 5
      ExplicitWidth = 91
      ExplicitHeight = 26
    end
    object btnSim: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 91
      Height = 25
      Align = alLeft
      Caption = '&Sim'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSimClick
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitHeight = 26
    end
    object btnNao: TBitBtnLocked
      Left = 94
      Top = 3
      Width = 91
      Height = 25
      Align = alLeft
      Caption = '&N'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnSairClick
      ExplicitLeft = 105
      ExplicitTop = 5
      ExplicitHeight = 26
    end
  end
  object memMsg: TMemoFocus [3]
    Left = 0
    Top = 57
    Width = 671
    Height = 269
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 16
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    ExplicitLeft = 8
    ExplicitTop = 38
    ExplicitWidth = 649
    ExplicitHeight = 238
  end
  inherited pnlStatus: TPanel
    Top = 357
    Width = 671
    ExplicitTop = 357
    ExplicitWidth = 671
    inherited pnlNomeForm: TPanel
      Left = 500
      ExplicitLeft = 500
    end
    inherited pnlInfo: TPanel
      Width = 500
      ExplicitWidth = 500
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 48
  end
end
