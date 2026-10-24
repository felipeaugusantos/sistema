inherited frmCadTiposCotacaoPedidoCompra: TfrmCadTiposCotacaoPedidoCompra
  Height = 150
  Caption = 'Tipos de Cota'#231#227'o de Pedido de Compra'
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 77
    ExplicitTop = 81
    inherited btnSair: TBitBtnLocked
      Left = 497
      Height = 20
      ExplicitLeft = 497
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 77
    ExplicitHeight = 81
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 49
    end
  end
  inherited pnlStatus: TPanel
    Top = 105
    ExplicitTop = 109
  end
  object pnlCentral: TPanel [4]
    Left = 0
    Top = 0
    Width = 585
    Height = 77
    Align = alClient
    Color = 16770261
    TabOrder = 4
    ExplicitHeight = 81
    object lbl2: TLabel
      Left = 37
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lbl3: TLabel
      Left = 53
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDesTct: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 36
      Width = 413
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TCT_DESTCT'
      DataSource = dtsCadTct
      MaxLength = 40
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodTct: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 13
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TCT_CODTCT'
      DataSource = dtsCadTct
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 0
  end
  object dtsCadTct: TDataSource
    Left = 512
  end
end
