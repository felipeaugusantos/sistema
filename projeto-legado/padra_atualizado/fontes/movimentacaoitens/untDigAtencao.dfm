inherited frmDigAtencao: TfrmDigAtencao
  Left = 299
  Top = 238
  Width = 356
  Height = 93
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Aten'#231#227'o de'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 50
    Width = 348
    TabOrder = 3
    inherited btnSair: TBitBtn
      Left = 279
    end
  end
  inherited pnlStatus: TPanel
    Top = 50
    Width = 348
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 200
      Width = 148
    end
    inherited pnlInfo: TPanel
      Width = 200
    end
  end
  inherited pgcDados: TPageControl
    Width = 348
    Height = 50
    TabOrder = 1
    Visible = False
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 348
    Height = 50
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Aten'#231#227'o de:'
    end
    object edtAtenca: TEditFocus
      Tag = 99
      Left = 70
      Top = 14
      Width = 261
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
end
