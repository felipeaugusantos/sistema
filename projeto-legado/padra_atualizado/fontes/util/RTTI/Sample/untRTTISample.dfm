object frmRTTISample: TfrmRTTISample
  Left = 0
  Top = 0
  Caption = 'frmRTTISample'
  ClientHeight = 443
  ClientWidth = 873
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 53
    Width = 32
    Height = 13
    Caption = 'Pedido'
  end
  object Label1: TLabel
    Left = 447
    Top = 53
    Width = 54
    Height = 13
    Caption = 'ItemPedido'
  end
  object ProgressBar: TProgressBar
    Left = 447
    Top = 16
    Width = 417
    Height = 25
    TabOrder = 1
  end
  object mmoPedido: TMemo
    Left = 24
    Top = 72
    Width = 417
    Height = 345
    TabOrder = 2
  end
  object mmoItemPed: TMemo
    Left = 447
    Top = 72
    Width = 417
    Height = 345
    TabOrder = 3
  end
  object btnImportar: TBitBtnLocked
    Left = 24
    Top = 16
    Width = 417
    Height = 25
    Caption = 'Importar'
    ParentDoubleBuffered = True
    TabOrder = 0
    OnClick = btnImportarClick
  end
end
