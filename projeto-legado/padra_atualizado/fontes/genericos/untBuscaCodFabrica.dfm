inherited FrmBuscaCodFabrica: TFrmBuscaCodFabrica
  Left = 425
  Top = 226
  Width = 352
  Height = 101
  Caption = ''
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 352
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 175
    Align = alNone
    ExplicitTop = 175
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 346
    Height = 57
    Align = alClient
    Color = 16770261
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 65
      Height = 14
      AutoSize = False
      Caption = 'C'#243'd. F'#225'brica:'
    end
    object edtCodFab: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 329
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    Top = 57
    Width = 346
    ExplicitTop = 57
    ExplicitWidth = 346
    inherited pnlNomeForm: TPanel
      Left = 175
      ExplicitLeft = 175
    end
    inherited pnlInfo: TPanel
      Width = 175
      ExplicitWidth = 175
    end
  end
end
