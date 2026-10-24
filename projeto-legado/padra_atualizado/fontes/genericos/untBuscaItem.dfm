inherited frmBuscaItem: TfrmBuscaItem
  Left = 238
  Top = 238
  Width = 603
  Height = 103
  Caption = 'Busca Item'
  Position = poMainFormCenter
  ExplicitWidth = 603
  ExplicitHeight = 103
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 58
    Width = 597
    ExplicitTop = 58
    ExplicitWidth = 597
    inherited FlwBotoes: TFlowPanel
      Width = 593
      ExplicitTop = 2
      ExplicitWidth = 593
    end
  end
  inherited pgcDados: TPageControl
    Width = 597
    Height = 58
    ExplicitWidth = 597
    ExplicitHeight = 58
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 589
      ExplicitHeight = 26
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 597
    Height = 58
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 192
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Descri'#231#227'o'
    end
    object rllItem: TLabel
      Left = 8
      Top = 8
      Width = 73
      Height = 14
      AutoSize = False
      Caption = 'Item'
    end
    object Label3: TLabel
      Left = 448
      Top = 8
      Width = 105
      Height = 14
      AutoSize = False
      Caption = 'Refer'#234'ncia'
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 192
      Top = 21
      Width = 249
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 70
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 448
      Top = 21
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 16
      TabOrder = 2
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
    Top = 58
    Width = 597
    ExplicitTop = 58
    ExplicitWidth = 597
    inherited pnlNomeForm: TPanel
      Left = 426
      ExplicitLeft = 426
    end
    inherited pnlInfo: TPanel
      Width = 426
      ExplicitWidth = 426
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 0
  end
end
