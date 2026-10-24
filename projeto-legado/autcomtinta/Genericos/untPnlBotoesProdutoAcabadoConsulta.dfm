object frmPnlBotoesProdutoAcabadoConsulta: TfrmPnlBotoesProdutoAcabadoConsulta
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmPnlBotoesProdutoAcabadoConsulta'
  ClientHeight = 40
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnEstoqueLojas: TBitBtnLocked
    Left = 0
    Top = 5
    Width = 169
    Height = 23
    Caption = '[ F6 ] Estoque das Lojas'
    TabOrder = 0
    OnClick = btnEstoqueLojasClick
  end
end
