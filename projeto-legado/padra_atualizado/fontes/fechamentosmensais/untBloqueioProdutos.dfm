object frmBloqueioProdutos: TfrmBloqueioProdutos
  Left = 422
  Top = 467
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Bloqueio de Clientes'
  ClientHeight = 55
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 381
    Height = 55
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Shape1: TShape
      Left = 1
      Top = 1
      Width = 379
      Height = 53
      Align = alClient
      Brush.Color = 16770261
    end
    object lblInformacao: TLabel
      Left = 8
      Top = 9
      Width = 260
      Height = 15
      Caption = 'Bloqueando produtos para compra. Aguarde...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pgbProgresso: TcxProgressBar
      Left = 8
      Top = 25
      AutoSize = False
      ParentColor = False
      ParentFont = False
      Properties.BarStyle = cxbsGradient
      Properties.EndColor = clBlue
      Style.BorderStyle = ebsUltraFlat
      Style.Color = clWhite
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -4
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.Shadow = True
      Style.IsFontAssigned = True
      TabOrder = 0
      Height = 24
      Width = 360
    end
  end
  object tmrClose: TTimer
    OnTimer = tmrCloseTimer
    Left = 352
  end
end
