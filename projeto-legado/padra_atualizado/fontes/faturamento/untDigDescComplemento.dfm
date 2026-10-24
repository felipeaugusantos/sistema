inherited frmDigDescComplemento: TfrmDigDescComplemento
  Left = 299
  Top = 238
  Width = 480
  Height = 101
  BorderIcons = [biSystemMenu]
  Caption = 'Item de Complemento'
  Position = poMainFormCenter
  ExplicitWidth = 480
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 60
    Width = 474
    ExplicitTop = 57
    ExplicitWidth = 474
    inherited btnSair: TBitBtnLocked
      Left = 279
      ExplicitLeft = 279
    end
  end
  inherited pgcDados: TPageControl
    Width = 474
    Height = 60
    TabOrder = 1
    Visible = False
    ExplicitWidth = 474
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 466
      ExplicitHeight = 25
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 474
    Height = 60
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 57
    object lblDesIte: TLabel
      Left = 13
      Top = 20
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 70
      Top = 15
      Width = 387
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 80
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 60
    Width = 474
    TabOrder = 3
    ExplicitTop = 57
    ExplicitWidth = 474
    inherited pnlNomeForm: TPanel
      Left = 326
      Width = 148
      ExplicitLeft = 326
      ExplicitWidth = 148
    end
    inherited pnlInfo: TPanel
      Width = 326
      ExplicitWidth = 326
    end
  end
end
