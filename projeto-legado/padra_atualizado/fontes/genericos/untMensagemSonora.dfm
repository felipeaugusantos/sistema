object frmMensagemSonora: TfrmMensagemSonora
  Left = 299
  Top = 411
  BorderStyle = bsNone
  ClientHeight = 500
  ClientWidth = 585
  Color = clBtnFace
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMensagem: TLabel
    Left = 0
    Top = 0
    Width = 585
    Height = 473
    Align = alClient
    Alignment = taCenter
    Caption = 'Mensagem Aqui'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 221
    ExplicitHeight = 33
  end
  object lblRodape: TLabel
    Left = 0
    Top = 473
    Width = 585
    Height = 27
    Align = alBottom
    Alignment = taCenter
    Caption = 'Pressione [ESPA'#199'O] para continuar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 462
  end
end
