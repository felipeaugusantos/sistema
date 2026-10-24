object frmPnlBotoesAcoesNovaConsulta: TfrmPnlBotoesAcoesNovaConsulta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'frmPnlBotoesAcoesNovaConsulta'
  ClientHeight = 65
  ClientWidth = 225
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
  object btnExecutaTarefa: TBitBtnLocked
    Left = 0
    Top = 6
    Width = 217
    Height = 23
    Caption = '[ F4 ] Executa Tarefa'
    TabOrder = 0
    Visible = False
  end
  object btnExecutaTarefa2: TBitBtnLocked
    Left = 1
    Top = 35
    Width = 217
    Height = 23
    Caption = '[ F5 ] Executa Tarefa 2'
    TabOrder = 1
    Visible = False
    OnClick = btnExecutaTarefa2Click
  end
end
