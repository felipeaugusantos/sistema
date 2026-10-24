object frmDecideDesconto: TfrmDecideDesconto
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Rec'#225'lculo do desconto'
  ClientHeight = 188
  ClientWidth = 762
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 64
    Width = 762
    Height = 124
    Align = alBottom
    ParentColor = True
    TabOrder = 0
    object btnRecalc: TBitBtnLocked
      Left = 3
      Top = 8
      Width = 750
      Height = 25
      Caption = 
        'Recarrega desconto do Cadastro e Recalcular com os descontos do ' +
        'fornecedor do &Item + Desconto Adicional (se houver)'
      TabOrder = 0
      OnClick = btnRecalcClick
    end
    object btnRecalcAdicional: TBitBtnLocked
      Left = 3
      Top = 62
      Width = 750
      Height = 25
      Caption = 'Recalcular como '#250'nico desconto o Desconto &Adicional'
      TabOrder = 2
      OnClick = btnRecalcAdicionalClick
    end
    object btnRecalcDigitado: TBitBtnLocked
      Left = 3
      Top = 35
      Width = 750
      Height = 25
      Caption = 
        'Recalcular com os descontos do fornecedor do &Item + Desconto Ad' +
        'icional (se houver) mantendo o digitado'
      TabOrder = 1
      OnClick = btnRecalcDigitadoClick
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 3
      Top = 90
      Width = 750
      Height = 25
      Caption = 
        'Somar o Desconto Adicional no desconto do fornecedor 1, ap'#243's som' +
        'ar, aplicar os demais descontos progressivos'
      TabOrder = 3
      OnClick = BitBtnLocked1Click
    end
  end
  object mmo1: TMemo
    Left = 0
    Top = 0
    Width = 762
    Height = 64
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '     Deseja recalcular o pre'#231'o do itens e acrescentar somente o ' +
        'desconto adicional sem os descontos do '
      'fornecedor do item?')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    ExplicitTop = 2
    ExplicitHeight = 86
  end
end
