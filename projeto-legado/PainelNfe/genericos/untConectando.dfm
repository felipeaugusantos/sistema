object frmConectando: TfrmConectando
  Left = 312
  Top = 277
  BorderStyle = bsNone
  Caption = 'frmConectando'
  ClientHeight = 238
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 274
    Height = 238
    Align = alClient
    BevelInner = bvRaised
    BorderStyle = bsSingle
    TabOrder = 0
    ExplicitHeight = 135
    object Label1: TLabel
      Left = 2
      Top = 67
      Width = 266
      Height = 26
      Align = alTop
      Alignment = taCenter
      Caption = 'Caso deseje fechar a aplica'#231#227'o clique em abortar.'#13
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 236
    end
    object Label2: TLabel
      Left = 2
      Top = 2
      Width = 266
      Height = 39
      Align = alTop
      Alignment = taCenter
      Caption = #13'N'#227'o foi poss'#237'vel conectar-se com o servidor.'#13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 256
    end
    object lblTentativas: TLabel
      Left = 2
      Top = 41
      Width = 266
      Height = 26
      Align = alTop
      Alignment = taCenter
      Caption = 'Uma nova tentativa ser'#225' executada em 15 segundos.'#13
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 253
    end
    object btnAbortar: TBitBtnLocked
      Left = 86
      Top = 91
      Width = 97
      Height = 25
      Caption = '&Abortar'
      TabOrder = 0
      OnClick = btnAbortarClick
    end
    object memErro: TMemo
      Left = 8
      Top = 122
      Width = 253
      Height = 103
      ReadOnly = True
      TabOrder = 1
    end
  end
  object tmrReconectar: TTimer
    OnTimer = tmrReconectarTimer
    Left = 40
    Top = 96
  end
end
