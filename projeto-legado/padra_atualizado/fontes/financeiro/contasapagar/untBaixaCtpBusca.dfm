inherited frmBaixaCtpBusca: TfrmBaixaCtpBusca
  Left = 297
  Top = 197
  Width = 330
  Height = 101
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 330
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 56
    Width = 324
    ExplicitTop = 56
    ExplicitWidth = 221
    inherited FlwBotoes: TFlowPanel
      Width = 320
    end
    inherited btnSair: TBitBtnLocked
      Left = 196
      ExplicitLeft = 196
    end
  end
  inherited pgcDados: TPageControl
    Width = 324
    Height = 56
    TabOrder = 1
    Visible = False
    ExplicitWidth = 221
    ExplicitHeight = 56
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 324
    Height = 56
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 221
    object Label1: TLabel
      Left = 15
      Top = 9
      Width = 44
      Height = 14
      Caption = 'Duplicata'
    end
    object Label2: TLabel
      Left = 114
      Top = 9
      Width = 87
      Height = 14
      Caption = 'Documento Antigo'
    end
    object Label3: TLabel
      Left = 216
      Top = 9
      Width = 42
      Height = 14
      Caption = 'Vr. T'#237'tulo'
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 15
      Top = 23
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVel: TEditFocus
      Tag = 99
      Left = 114
      Top = 23
      Width = 92
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorTitulo: TCurrencyEditFocus
      Tag = 99
      Left = 216
      Top = 23
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 92
    end
  end
  inherited pnlStatus: TPanel
    Top = 56
    Width = 324
    TabOrder = 3
    ExplicitTop = 56
    ExplicitWidth = 221
    inherited pnlNomeForm: TPanel
      Left = 203
      Width = 121
      ExplicitLeft = 100
      ExplicitWidth = 121
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 100
    end
  end
end
