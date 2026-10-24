inherited frmCadBzaNovasFormulas: TfrmCadBzaNovasFormulas
  Left = 347
  Top = 425
  Width = 659
  Height = 485
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Brasimix Automotiva'
  ExplicitWidth = 659
  ExplicitHeight = 485
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 417
    Width = 653
    ExplicitTop = 417
    ExplicitWidth = 653
    inherited btnSair: TBitBtnLocked
      Left = 576
      ExplicitLeft = 576
    end
  end
  inherited pgcDados: TPageControl
    Width = 653
    Height = 417
    ExplicitWidth = 653
    ExplicitHeight = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 645
      ExplicitHeight = 385
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 653
    Height = 417
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 47
      Top = 32
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo Form.:'
    end
    object Label4: TLabel
      Left = 63
      Top = 83
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 97
      Top = 60
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label2: TLabel
      Left = 173
      Top = 60
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object Label6: TLabel
      Left = 348
      Top = 60
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano:'
    end
    object Label27: TLabel
      Left = 410
      Top = 60
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Universal:'
    end
    object Label48: TLabel
      Left = 5
      Top = 107
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'scimo m'#227'o de obra'
    end
    object Label49: TLabel
      Left = 216
      Top = 33
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 651
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Brasimix Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 7
    end
    object dbeCodNfm: TDBEditFocus
      Tag = 99
      Left = 123
      Top = 28
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      DataSource = dtsBzaCadNfm
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 123
      Top = 79
      Width = 470
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      DataSource = dtsBzaCadNfm
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 152
      Width = 651
      Height = 264
      Align = alBottom
      Caption = '     Pigmentos      '
      TabOrder = 8
      object Label7: TLabel
        Left = 23
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 157
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label9: TLabel
        Left = 23
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label10: TLabel
        Left = 157
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 23
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 157
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label13: TLabel
        Left = 23
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label14: TLabel
        Left = 157
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label15: TLabel
        Left = 23
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 157
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 23
        Top = 136
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 157
        Top = 136
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 23
        Top = 158
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 157
        Top = 158
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 23
        Top = 180
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 157
        Top = 180
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label23: TLabel
        Left = 23
        Top = 202
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 157
        Top = 202
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label25: TLabel
        Left = 23
        Top = 224
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 157
        Top = 224
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label5: TLabel
        Left = 80
        Top = 0
        Width = 283
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Informar a quantidade sempre em rela'#231#227'o a 900ml'
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
      object Label28: TLabel
        Left = 274
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label29: TLabel
        Left = 274
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label30: TLabel
        Left = 274
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label31: TLabel
        Left = 274
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label32: TLabel
        Left = 274
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label33: TLabel
        Left = 274
        Top = 136
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label34: TLabel
        Left = 274
        Top = 158
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label35: TLabel
        Left = 274
        Top = 180
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label36: TLabel
        Left = 274
        Top = 202
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 19:'
      end
      object Label37: TLabel
        Left = 274
        Top = 224
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 20:'
      end
      object Label38: TLabel
        Left = 409
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label39: TLabel
        Left = 409
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label40: TLabel
        Left = 409
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label41: TLabel
        Left = 409
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label42: TLabel
        Left = 409
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label43: TLabel
        Left = 409
        Top = 136
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label44: TLabel
        Left = 409
        Top = 158
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label45: TLabel
        Left = 409
        Top = 180
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label46: TLabel
        Left = 409
        Top = 202
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label47: TLabel
        Left = 409
        Top = 224
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 83
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB01'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB01'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 44
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB02'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 66
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB03'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 88
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB04'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 110
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB05'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 132
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 132
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB06'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 154
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 154
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB07'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 176
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 176
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB08'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 198
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 198
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB09'
        DataSource = dtsBzaCadNfm
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
        Left = 83
        Top = 220
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
        DataSource = dtsBzaCadNfm
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
        Left = 225
        Top = 220
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB10'
        DataSource = dtsBzaCadNfm
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        DataSource = dtsBzaCadNfm
        TabOrder = 20
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 44
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        DataSource = dtsBzaCadNfm
        TabOrder = 22
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 66
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        DataSource = dtsBzaCadNfm
        TabOrder = 24
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 88
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        DataSource = dtsBzaCadNfm
        TabOrder = 26
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 110
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        DataSource = dtsBzaCadNfm
        TabOrder = 28
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 132
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
        DataSource = dtsBzaCadNfm
        TabOrder = 30
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm17: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 154
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
        DataSource = dtsBzaCadNfm
        TabOrder = 32
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm18: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 176
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
        DataSource = dtsBzaCadNfm
        TabOrder = 34
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm19: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 198
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB19'
        DataSource = dtsBzaCadNfm
        TabOrder = 36
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm20: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 220
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB20'
        DataSource = dtsBzaCadNfm
        TabOrder = 38
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC11: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB11'
        DataSource = dtsBzaCadNfm
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC12: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB12'
        DataSource = dtsBzaCadNfm
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB13'
        DataSource = dtsBzaCadNfm
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC14: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB14'
        DataSource = dtsBzaCadNfm
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC15: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB15'
        DataSource = dtsBzaCadNfm
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC16: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 132
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB16'
        DataSource = dtsBzaCadNfm
        TabOrder = 31
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC17: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 154
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB17'
        DataSource = dtsBzaCadNfm
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC18: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 176
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB18'
        DataSource = dtsBzaCadNfm
        TabOrder = 35
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC19: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 198
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB19'
        DataSource = dtsBzaCadNfm
        TabOrder = 37
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC20: TDBEditFocus
        Tag = 99
        Left = 480
        Top = 220
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB20'
        DataSource = dtsBzaCadNfm
        TabOrder = 39
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeMontad: TDBEditFocus
      Tag = 99
      Left = 230
      Top = 56
      Width = 114
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_MONTAD'
      DataSource = dtsBzaCadNfm
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAno: TDBEditFocus
      Tag = 99
      Left = 374
      Top = 56
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_A_N_O_'
      DataSource = dtsBzaCadNfm
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodUni: TDBEditFocus
      Tag = 99
      Left = 486
      Top = 56
      Width = 107
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODUNI'
      DataSource = dtsBzaCadNfm
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipo: TDBComboBox
      Left = 123
      Top = 56
      Width = 45
      Height = 22
      DataField = 'NFM_TIPO__'
      DataSource = dtsBzaCadNfm
      Items.Strings = (
        'EP'
        'LA'
        'LC'
        'PE'
        'PH'
        'SI'
        'PM'
        'PP'
        'PU'
        'SB'
        'SR'
        'ST'
        'ED'
        'EM'
        'PD'
        'PR')
      TabOrder = 1
      OnKeyPress = dbeTipoKeyPress
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 123
      Top = 102
      Width = 107
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      DataSource = dtsBzaCadNfm
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 292
      Top = 28
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      DataSource = dtsBzaCadNfm
      Enabled = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 445
    Width = 653
    ExplicitTop = 445
    ExplicitWidth = 653
    inherited pnlNomeForm: TPanel
      Left = 306
      ExplicitLeft = 306
    end
    inherited pnlInfo: TPanel
      Width = 306
      ExplicitWidth = 306
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 104
  end
  object dtsBzaCadNfm: TDataSource
    OnStateChange = dtsBzaCadNfmStateChange
    Left = 344
    Top = 104
  end
end
