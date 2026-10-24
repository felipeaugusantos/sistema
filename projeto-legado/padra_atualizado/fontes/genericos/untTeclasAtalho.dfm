object frmTeclasAtalho: TfrmTeclasAtalho
  Left = 284
  Top = 281
  BorderStyle = bsNone
  ClientHeight = 87
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 87
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    Enabled = False
    TabOrder = 0
    object cxMemo: TcxMemo
      Left = 0
      Top = 0
      Hint = 'Pressione ESC para sair.'
      Align = alClient
      Lines.Strings = (
        ''
        '  [Ctrl + F2] : Relacionamento de Similaridade'
        '  [Ctrl + F3] : Relacionamento de Semelhan'#231'a')
      ParentFont = False
      ParentShowHint = False
      Properties.ReadOnly = True
      ShowHint = True
      Style.BorderColor = clRed
      Style.BorderStyle = ebsFlat
      Style.Color = clInfoBk
      Style.Edges = []
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlue
      Style.Font.Height = -15
      Style.Font.Name = 'Times New Roman'
      Style.Font.Style = [fsBold]
      Style.TransparentBorder = True
      Style.IsFontAssigned = True
      TabOrder = 0
      Height = 87
      Width = 321
    end
  end
end
