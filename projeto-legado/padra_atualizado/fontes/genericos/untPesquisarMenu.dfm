object frmPesquisarMenu: TfrmPesquisarMenu
  Left = 299
  Top = 411
  BorderStyle = bsDialog
  Caption = 'Pesquisar Menus do Sistema'
  ClientHeight = 471
  ClientWidth = 1018
  Color = clWhite
  TransparentColorValue = cl3DLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object lblRodape: TLabel
    Left = 0
    Top = 446
    Width = 1018
    Height = 25
    Align = alBottom
    Alignment = taCenter
    Caption = 'Pressione [ESC] para cancelar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 260
  end
  inline fraPesquisarMenu: TfraPesquisarMenu
    Left = 0
    Top = 0
    Width = 1018
    Height = 446
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1018
    ExplicitHeight = 446
  end
end
