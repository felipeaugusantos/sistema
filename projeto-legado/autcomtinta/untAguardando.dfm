object frmAguardando: TfrmAguardando
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Aguardando'
  ClientHeight = 144
  ClientWidth = 513
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblTexto: TLabel
    Left = 0
    Top = 0
    Width = 513
    Height = 144
    Align = alClient
    Alignment = taCenter
    AutoSize = False
    Caption = 'TEXTO DE AGUARDE AQUI! PODE SER GRANDE!!!!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitLeft = 5
    ExplicitTop = 3
    ExplicitWidth = 500
    ExplicitHeight = 96
  end
  object tmrFechar: TTimer
    Interval = 100
    OnTimer = tmrFecharTimer
    Left = 240
    Top = 56
  end
end
