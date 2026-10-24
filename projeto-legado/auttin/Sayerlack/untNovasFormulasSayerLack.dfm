inherited frmNovasFormulasSayerLack: TfrmNovasFormulasSayerLack
  Height = 528
  Caption = 'frmNovasFormulasSayerLack'
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 456
    TabOrder = 2
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Height = 456
    TabOrder = 0
  end
  inherited pnlCentral: TPanel
    Height = 456
    TabOrder = 1
    inherited lblCodigo: TLabel
      Left = 35
      ExplicitLeft = 35
    end
    object lblCodigoBase: TLabel [1]
      Left = 7
      Top = 89
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Base:'
    end
    object lblBase: TLabel [2]
      Left = 43
      Top = 117
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base:'
    end
    object lblProduto: TLabel [3]
      Left = 424
      Top = 61
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblEmbalagem: TLabel [4]
      Left = 407
      Top = 89
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object Label1: TLabel [5]
      Left = 19
      Top = 61
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label55: TLabel [6]
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
        Caption = 'Cadastro de Novas F'#243'rmulas - Sayerlack'
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
      Left = 77
      Width = 174
      TabOrder = 1
      ExplicitLeft = 77
      ExplicitWidth = 174
    end
    inherited dbgComponentes: TcxGrid
      Top = 152
      Height = 300
      TabOrder = 7
      ExplicitTop = 117
      ExplicitHeight = 300
    end
    object dbeCodigoBase: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODBAS'
      TabOrder = 3
      OnKeyPress = dbeCodigoBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 114
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_BASE__'
      TabOrder = 4
      OnKeyPress = dbeCodigoBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProduto: TDBEditFocus
      Tag = 99
      Left = 470
      Top = 58
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_PRODUT'
      TabOrder = 5
      OnKeyPress = dbeCodigoBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 470
      Top = 86
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESEMB'
      TabOrder = 6
      OnKeyPress = dbeCodigoBaseKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 58
      Width = 317
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      Enabled = False
      TabOrder = 2
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
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 484
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      TabOrder = 1
    end
    inherited pnlInfo: TPanel
      TabOrder = 0
    end
  end
end
