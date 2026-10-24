inherited frmFatDigCodBarrasProduto: TfrmFatDigCodBarrasProduto
  Width = 368
  Height = 124
  Caption = 'Produto'
  ExplicitWidth = 368
  ExplicitHeight = 124
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 53
    Width = 362
    TabOrder = 1
    ExplicitTop = 53
    ExplicitWidth = 362
    inherited FlwBotoes: TFlowPanel
      Width = 281
      ExplicitTop = 2
      ExplicitWidth = 281
    end
    inherited btnSair: TBitBtnLocked
      Left = 283
      Top = 2
      Align = alRight
      ExplicitLeft = 283
      ExplicitTop = 2
    end
  end
  object pnlCodBarProduto: TPanel [2]
    Left = 0
    Top = 0
    Width = 362
    Height = 53
    Align = alClient
    TabOrder = 0
    object lblCodBarProduto: TLabel
      Left = 8
      Top = 6
      Width = 194
      Height = 14
      Caption = 'Leitura / Digita'#231#227'o do c'#243'digo do Produto:'
    end
    object edtCodBarProduto: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 79
    Width = 362
    TabOrder = 2
    ExplicitTop = 79
    ExplicitWidth = 362
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 176
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 56
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 136
  end
end
