object frmWaitWindow: TfrmWaitWindow
  Left = 370
  Top = 310
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlWait: TPanel
    Left = 0
    Top = 0
    Width = 307
    Height = 100
    Align = alClient
    TabOrder = 0
    object lblTexto: TLabel
      Left = 1
      Top = 1
      Width = 305
      Height = 98
      Align = alClient
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 3
      ExplicitHeight = 16
    end
  end
  object tmrWait: TTimer
    OnTimer = tmrWaitTimer
    Left = 344
    Top = 8
  end
end
