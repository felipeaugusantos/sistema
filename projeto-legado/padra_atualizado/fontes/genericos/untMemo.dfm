object frmMemo: TfrmMemo
  Left = 281
  Top = 258
  BorderStyle = bsNone
  ClientHeight = 550
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cxMemo: TcxMemo
    Left = 0
    Top = 0
    Hint = 'Pressione ESC para sair.'
    Align = alClient
    ParentFont = False
    ParentShowHint = False
    Properties.ReadOnly = True
    ShowHint = True
    Style.BorderColor = clRed
    Style.BorderStyle = ebsThick
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -15
    Style.Font.Name = 'Courier New'
    Style.Font.Style = [fsBold]
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    TabOrder = 0
    OnKeyDown = cxMemoKeyDown
    Height = 550
    Width = 800
  end
end

