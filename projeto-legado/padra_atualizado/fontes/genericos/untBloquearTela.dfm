object frmBloquearTela: TfrmBloquearTela
  Left = 312
  Top = 277
  BorderStyle = bsNone
  Caption = 'frmBloquearTela'
  ClientHeight = 190
  ClientWidth = 419
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  StyleElements = []
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 419
    Height = 190
    Align = alClient
    Alignment = taCenter
    Caption = 
      'ESTE FORMUL'#193'RIO BLOQUEIA A TELA DO SISTEMA AT'#201' QUE FINALIZE UMA ' +
      'OPERA'#199#195'O.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
    WordWrap = True
    ExplicitWidth = 373
    ExplicitHeight = 26
  end
end
