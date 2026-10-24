object frmSelIcon: TfrmSelIcon
  Left = 0
  Top = 0
  Caption = 'frmSelIcon'
  ClientHeight = 476
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object webBrowser: TTMSFNCWebBrowser
    Left = 0
    Top = 89
    Width = 635
    Height = 387
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    Color = 15263976
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      635
      89)
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 228
      Height = 33
      Caption = #205'cone Selecionado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 258
      Top = 25
      Width = 256
      Height = 41
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnConfirma: TBitBtnLocked
      Left = 520
      Top = 25
      Width = 75
      Height = 42
      Caption = 'Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 560
    Top = 48
  end
end
