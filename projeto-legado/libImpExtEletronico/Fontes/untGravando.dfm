object frmGravando: TfrmGravando
  Left = 312
  Top = 277
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmGravando'
  ClientHeight = 149
  ClientWidth = 539
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object imgGravando: TImage
    Left = 0
    Top = 0
    Width = 539
    Height = 132
    Align = alClient
    ExplicitHeight = 128
  end
  object lblGravando: TLabel
    Left = 11
    Top = 10
    Width = 515
    Height = 114
    AutoSize = False
    Caption = 'Aguarde... Gravando.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  object pgbStatus: TProgressBar
    Left = 0
    Top = 132
    Width = 539
    Height = 17
    Align = alBottom
    Smooth = True
    Step = 1
    TabOrder = 0
  end
end
