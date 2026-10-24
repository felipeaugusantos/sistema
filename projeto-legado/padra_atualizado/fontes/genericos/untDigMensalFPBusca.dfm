inherited frmDigMensalFPBusca: TfrmDigMensalFPBusca
  Left = 233
  Top = 259
  Width = 356
  Height = 98
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 356
  ExplicitHeight = 98
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 53
    Width = 350
    ExplicitTop = 53
    ExplicitWidth = 350
    inherited FlwBotoes: TFlowPanel
      Width = 346
    end
    inherited btnSair: TBitBtnLocked
      Left = 224
      ExplicitLeft = 224
    end
  end
  inherited pgcDados: TPageControl
    Width = 350
    Height = 53
    TabOrder = 1
    Visible = False
    ExplicitWidth = 350
    ExplicitHeight = 53
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 342
      ExplicitHeight = 21
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 350
    Height = 53
    Align = alClient
    Color = 16770261
    TabOrder = 0
    DesignSize = (
      350
      53)
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 215
      Height = 14
      AutoSize = False
      Caption = 'Funcion'#225'rio'
    end
    object edtNomFun: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 336
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
  end
  inherited pnlStatus: TPanel
    Top = 53
    Width = 350
    TabOrder = 3
    ExplicitTop = 53
    ExplicitWidth = 350
    inherited pnlNomeForm: TPanel
      Left = 227
      Width = 123
      ExplicitLeft = 227
      ExplicitWidth = 123
    end
    inherited pnlInfo: TPanel
      Width = 227
      ExplicitWidth = 227
    end
  end
end
