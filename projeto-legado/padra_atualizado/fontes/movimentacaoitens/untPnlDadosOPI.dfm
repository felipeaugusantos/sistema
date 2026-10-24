object frmPnlDadosOPI: TfrmPnlDadosOPI
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 44
  ClientWidth = 651
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnBaixarOpi: TBitBtnLocked
    Left = 8
    Top = 8
    Width = 297
    Height = 25
    Caption = '[F4] - Baixa ordem de produ'#231#227'o que n'#227'o ser'#225' produzida'
    TabOrder = 0
    OnClick = btnBaixarOpiClick
  end
end
