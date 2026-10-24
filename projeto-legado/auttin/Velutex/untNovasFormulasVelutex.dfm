inherited frmNovasFormulasVelutex: TfrmNovasFormulasVelutex
  Height = 519
  Caption = 'frmNovasFormulasVelutex'
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    TabOrder = 2
    ExplicitTop = 447
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Height = 447
    TabOrder = 0
    ExplicitHeight = 447
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 415
    end
  end
  inherited pnlCentral: TPanel
    Height = 447
    TabOrder = 1
    ExplicitHeight = 447
    inherited lblCodigo: TLabel
      Left = 38
      ExplicitLeft = 38
    end
    object lblCorCod: TLabel [1]
      Left = 18
      Top = 61
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Color Code:'
    end
    object lblCodBas: TLabel [2]
      Left = 10
      Top = 89
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Base:'
    end
    object lblFanDeck: TLabel [3]
      Left = 32
      Top = 117
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cole'#231#227'o:'
    end
    object lblProduto: TLabel [4]
      Left = 34
      Top = 146
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblEmbalagem: TLabel [5]
      Left = 312
      Top = 61
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object lblNota: TLabel [6]
      Left = 329
      Top = 89
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nota:'
    end
    object Label1: TLabel [7]
      Left = 302
      Top = 117
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd.Nome:'
    end
    object Label55: TLabel [8]
      Left = 281
      Top = 33
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    inherited pnlCabecalho: TPanel
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 653
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Cadastro de Novas F'#243'rmulas - Velutex Imobili'#225'ria'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
    end
    inherited dbeCodigo: TDBEditFocus
      Left = 80
      Width = 174
      TabOrder = 1
      ExplicitLeft = 80
      ExplicitWidth = 174
    end
    inherited dbgComponentes: TcxGrid
      Top = 190
      Height = 253
      TabOrder = 5
      ExplicitTop = 190
      ExplicitHeight = 253
    end
    object dbeCorCod: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CORCOD'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODBAS'
      TabOrder = 3
      OnKeyPress = dbeProdutoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeColecao: TDBEditFocus
      Tag = 99
      Left = 80
      Top = 114
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_COLECA'
      TabOrder = 4
      OnExit = dbeColecaoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 30
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    TabOrder = 3
    ExplicitTop = 475
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
  object dbeNota: TDBEditFocus [5]
    Tag = 99
    Left = 360
    Top = 86
    Width = 174
    Height = 22
    CharCase = ecUpperCase
    DataField = 'NFM_NOTA__'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeUnidade: TDBEditFocus [6]
    Tag = 99
    Left = 360
    Top = 58
    Width = 174
    Height = 22
    CharCase = ecUpperCase
    DataField = 'NFM_CODUNI'
    ReadOnly = True
    TabOrder = 6
    OnKeyPress = dbeProdutoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCodNome: TDBEditFocus [7]
    Tag = 99
    Left = 360
    Top = 114
    Width = 174
    Height = 22
    CharCase = ecUpperCase
    DataField = 'NFM_CODNOM'
    TabOrder = 8
    OnExit = dbeCodNomeExit
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeProduto: TDBEditFocus [8]
    Tag = 99
    Left = 80
    Top = 142
    Width = 174
    Height = 22
    CharCase = ecUpperCase
    DataField = 'NFM_PRODUT'
    TabOrder = 5
    OnKeyPress = dbeProdutoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 224
  end
  inherited dtsComponentes: TDataSource
    Left = 104
    Top = 256
  end
end
