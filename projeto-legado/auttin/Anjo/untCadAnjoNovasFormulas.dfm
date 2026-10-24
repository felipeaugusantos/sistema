inherited frmCadAnjoNovasFormulas: TfrmCadAnjoNovasFormulas
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas f'#243'rmulas - Anjo'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 263
    ExplicitTop = 263
  end
  inherited pnlStatus: TPanel
    Top = 291
    ExplicitTop = 291
  end
  inherited pgcDados: TPageControl
    Height = 263
    ExplicitHeight = 263
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 231
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 263
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo Form.:'
    end
    object Label3: TLabel
      Left = 24
      Top = 60
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base:'
    end
    object Label4: TLabel
      Left = 24
      Top = 83
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 168
      Top = 60
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Prod. Key:'
    end
    object Label6: TLabel
      Left = 368
      Top = 60
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object Label27: TLabel
      Left = 272
      Top = 60
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sub. Key:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Anjo'
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
    object dbeCodNfm: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 28
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODPRO'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 79
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 125
      Width = 583
      Height = 137
      Align = alBottom
      Caption = '     Colorantes      '
      TabOrder = 7
      object Label7: TLabel
        Left = 8
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 120
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label9: TLabel
        Left = 8
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label10: TLabel
        Left = 120
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 8
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 120
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label13: TLabel
        Left = 8
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label14: TLabel
        Left = 120
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label15: TLabel
        Left = 8
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 120
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 280
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 392
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 280
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 392
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 280
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 392
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label23: TLabel
        Left = 280
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 392
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label25: TLabel
        Left = 280
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 392
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label5: TLabel
        Left = 80
        Top = 0
        Width = 229
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Informar a quantidade sempre em Litros'
        Color = clTeal
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL001'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC01: TDBEditFocus
        Tag = 99
        Left = 188
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD001'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL002'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC02: TDBEditFocus
        Tag = 99
        Left = 188
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD002'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL003'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC03: TDBEditFocus
        Tag = 99
        Left = 188
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD003'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL004'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC04: TDBEditFocus
        Tag = 99
        Left = 188
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD004'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL005'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC05: TDBEditFocus
        Tag = 99
        Left = 188
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD005'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm06: TDBEditFocus
        Tag = 99
        Left = 340
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL006'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 10
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC06: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD006'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 340
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL007'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 12
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC07: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD007'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 340
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL008'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 14
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC08: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD008'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 340
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL009'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC09: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD009'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 340
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_COL010'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 18
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC10: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTD010'
        DataSource = dtsAnj_CadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 56
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_BASE__'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnKeyPress = dbeCodBasKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeProKey: TDBEditFocus
      Tag = 99
      Left = 228
      Top = 56
      Width = 32
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_PROKEY'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeUnidad: TDBEditFocus
      Tag = 99
      Left = 428
      Top = 56
      Width = 45
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_UNIDAD'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSubKey: TDBEditFocus
      Tag = 99
      Left = 332
      Top = 56
      Width = 32
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_SUBKEY'
      DataSource = dtsAnj_CadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 8
  end
  object dtsAnj_CadNfm: TDataSource
    DataSet = qryAnj_CadNfm
    Left = 344
    Top = 96
  end
  object qryAnj_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM ADVCOR_CADNFM')
    Left = 384
    Top = 96
    object qryAnj_CadNfmNFM_CODPRO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODPRO'
      Required = True
      Size = 10
    end
    object qryAnj_CadNfmNFM_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_BASE__'
      Size = 2
    end
    object qryAnj_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 50
    end
    object qryAnj_CadNfmNFM_COL001: TStringField
      FieldName = 'NFM_COL001'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL002: TStringField
      FieldName = 'NFM_COL002'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL003: TStringField
      FieldName = 'NFM_COL003'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL004: TStringField
      FieldName = 'NFM_COL004'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL005: TStringField
      FieldName = 'NFM_COL005'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL006: TStringField
      FieldName = 'NFM_COL006'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL007: TStringField
      FieldName = 'NFM_COL007'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL008: TStringField
      FieldName = 'NFM_COL008'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL009: TStringField
      FieldName = 'NFM_COL009'
      Size = 2
    end
    object qryAnj_CadNfmNFM_COL010: TStringField
      FieldName = 'NFM_COL010'
      Size = 2
    end
    object qryAnj_CadNfmNFM_QTD001: TFloatField
      FieldName = 'NFM_QTD001'
    end
    object qryAnj_CadNfmNFM_QTD002: TFloatField
      FieldName = 'NFM_QTD002'
    end
    object qryAnj_CadNfmNFM_QTD003: TFloatField
      FieldName = 'NFM_QTD003'
    end
    object qryAnj_CadNfmNFM_QTD004: TFloatField
      FieldName = 'NFM_QTD004'
    end
    object qryAnj_CadNfmNFM_QTD005: TFloatField
      FieldName = 'NFM_QTD005'
    end
    object qryAnj_CadNfmNFM_QTD006: TFloatField
      FieldName = 'NFM_QTD006'
    end
    object qryAnj_CadNfmNFM_QTD007: TFloatField
      FieldName = 'NFM_QTD007'
    end
    object qryAnj_CadNfmNFM_QTD008: TFloatField
      FieldName = 'NFM_QTD008'
    end
    object qryAnj_CadNfmNFM_QTD009: TFloatField
      FieldName = 'NFM_QTD009'
    end
    object qryAnj_CadNfmNFM_QTD010: TFloatField
      FieldName = 'NFM_QTD010'
    end
    object qryAnj_CadNfmNFM_EMBALA: TFloatField
      DisplayLabel = 'Embalagem'
      FieldName = 'NFM_EMBALA'
    end
    object qryAnj_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryAnj_CadNfmNFM_PROKEY: TStringField
      DisplayLabel = 'Prod. Key'
      FieldName = 'NFM_PROKEY'
      Size = 2
    end
    object qryAnj_CadNfmNFM_SUBKEY: TStringField
      DisplayLabel = 'Sub. Key'
      FieldName = 'NFM_SUBKEY'
      Size = 2
    end
    object qryAnj_CadNfmNFM_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Required = True
      Size = 3
    end
    object qryAnj_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
end
