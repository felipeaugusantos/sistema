object frmPnlPesqCadRec: TfrmPnlPesqCadRec
  Left = 0
  Top = 0
  Align = alBottom
  BorderStyle = bsNone
  Caption = 'frmPnlPesqCadRec'
  ClientHeight = 57
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnDupAgrup: TBitBtnLocked
    Left = 10
    Top = 10
    Width = 167
    Height = 25
    Caption = '[ F9 ] - Duplicatas Agrupadas'
    TabOrder = 0
    OnClick = btnDupAgrupClick
  end
  object btnConsultarAdiantamentos: TBitBtnLocked
    Left = 179
    Top = 10
    Width = 102
    Height = 25
    Caption = '[F6] Adiantamento'
    TabOrder = 1
    OnClick = btnConsultarAdiantamentosClick
  end
end
