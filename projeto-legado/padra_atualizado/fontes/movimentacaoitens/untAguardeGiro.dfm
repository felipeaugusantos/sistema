object frmAguardeGiro: TfrmAguardeGiro
  Left = 296
  Top = 377
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Pedido de Compras'
  ClientHeight = 65
  ClientWidth = 377
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object prbProgresso: TProgressBar
    Left = 0
    Top = 49
    Width = 377
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object pnlInforma: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 49
    Align = alClient
    Caption = 'Aguarde: Calculando giro de estoque'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
  end
end
