inherited frmCadMziNovasFormulasDin: TfrmCadMziNovasFormulasDin
  Left = 301
  Top = 216
  Width = 525
  Height = 476
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Maza Imobili'#225'ria'
  ExplicitWidth = 525
  ExplicitHeight = 476
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 408
    Width = 519
    ExplicitTop = 408
    ExplicitWidth = 519
    inherited btnSair: TBitBtnLocked
      Left = 442
      ExplicitLeft = 442
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 408
    ExplicitWidth = 519
    ExplicitHeight = 408
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 376
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 408
    Align = alClient
    Color = 16770261
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
    object Label4: TLabel
      Left = 24
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 48
      Top = 56
      Width = 33
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base:'
    end
    object Label6: TLabel
      Left = 171
      Top = 56
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object Label27: TLabel
      Left = 24
      Top = 81
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label55: TLabel
      Left = 312
      Top = 56
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 24
      Width = 517
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      ExplicitLeft = 2
      ExplicitTop = 23
    end
    object dbeCodNfm: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 28
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
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
      Left = 84
      Top = 103
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_COLNAM'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 134
      Width = 517
      Height = 273
      Align = alBottom
      Caption = '     Colorantes      '
      TabOrder = 6
      object Label7: TLabel
        Left = 8
        Top = 42
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 01:'
      end
      object Label8: TLabel
        Left = 120
        Top = 42
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label9: TLabel
        Left = 8
        Top = 64
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 02:'
      end
      object Label10: TLabel
        Left = 120
        Top = 64
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 8
        Top = 86
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 03:'
      end
      object Label12: TLabel
        Left = 120
        Top = 86
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label13: TLabel
        Left = 8
        Top = 108
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 04:'
      end
      object Label14: TLabel
        Left = 120
        Top = 108
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label15: TLabel
        Left = 8
        Top = 130
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 05:'
      end
      object Label16: TLabel
        Left = 120
        Top = 130
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 8
        Top = 153
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 06:'
      end
      object Label18: TLabel
        Left = 120
        Top = 153
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 8
        Top = 175
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 07:'
      end
      object Label20: TLabel
        Left = 120
        Top = 175
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 8
        Top = 197
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 08:'
      end
      object Label22: TLabel
        Left = 120
        Top = 197
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label23: TLabel
        Left = 8
        Top = 219
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 09:'
      end
      object Label24: TLabel
        Left = 120
        Top = 219
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label25: TLabel
        Left = 8
        Top = 241
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 10:'
      end
      object Label26: TLabel
        Left = 120
        Top = 241
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl1: TLabel
        Left = 248
        Top = 42
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 11:'
      end
      object lbl2: TLabel
        Left = 360
        Top = 42
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl3: TLabel
        Left = 248
        Top = 64
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 12:'
      end
      object lbl4: TLabel
        Left = 360
        Top = 64
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl5: TLabel
        Left = 248
        Top = 86
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 13:'
      end
      object lbl6: TLabel
        Left = 360
        Top = 86
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl7: TLabel
        Left = 248
        Top = 108
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 14:'
      end
      object lbl8: TLabel
        Left = 360
        Top = 108
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl9: TLabel
        Left = 248
        Top = 130
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 15:'
      end
      object lbl10: TLabel
        Left = 360
        Top = 130
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl11: TLabel
        Left = 248
        Top = 153
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 16:'
      end
      object lbl12: TLabel
        Left = 360
        Top = 153
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl13: TLabel
        Left = 248
        Top = 175
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 17:'
      end
      object lbl14: TLabel
        Left = 360
        Top = 175
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl15: TLabel
        Left = 248
        Top = 197
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 18:'
      end
      object lbl16: TLabel
        Left = 360
        Top = 197
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl17: TLabel
        Left = 248
        Top = 219
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 19:'
      end
      object lbl18: TLabel
        Left = 360
        Top = 219
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object lbl19: TLabel
        Left = 245
        Top = 239
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo 20:'
      end
      object lbl20: TLabel
        Left = 360
        Top = 241
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 38
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC01'
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
        Top = 38
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC01'
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
        Top = 60
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC02'
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
        Top = 60
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC02'
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
        Top = 82
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC03'
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
        Top = 82
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC03'
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
        Top = 104
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC04'
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
        Top = 104
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC04'
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
        Top = 126
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC05'
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
        Top = 126
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC05'
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
        Left = 68
        Top = 149
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC06'
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
        Left = 188
        Top = 149
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC06'
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
        Left = 68
        Top = 171
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC07'
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
        Left = 188
        Top = 171
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC07'
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
        Left = 68
        Top = 193
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC08'
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
        Left = 188
        Top = 193
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC08'
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
        Left = 68
        Top = 215
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC09'
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
        Left = 188
        Top = 215
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC09'
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
        Left = 68
        Top = 237
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC10'
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
        Left = 188
        Top = 237
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC10'
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
        Left = 308
        Top = 38
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC11'
        TabOrder = 20
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
        Left = 428
        Top = 38
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC11'
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 60
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC12'
        TabOrder = 22
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC12: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 60
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC12'
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 82
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC13'
        TabOrder = 24
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 82
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC13'
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 104
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC14'
        TabOrder = 26
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC14: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 104
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC14'
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 126
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC15'
        TabOrder = 28
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC15: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 126
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC15'
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 149
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC16'
        TabOrder = 30
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC16: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 149
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC16'
        TabOrder = 31
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm17: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 171
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC17'
        TabOrder = 32
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC17: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 171
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC17'
        TabOrder = 33
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm18: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 193
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC18'
        TabOrder = 34
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC18: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 193
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC18'
        TabOrder = 35
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm19: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 215
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC19'
        TabOrder = 36
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC19: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 215
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC19'
        TabOrder = 37
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm20: TDBEditFocus
        Tag = 99
        Left = 308
        Top = 237
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODC20'
        TabOrder = 38
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC20: TDBEditFocus
        Tag = 99
        Left = 428
        Top = 237
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC20'
        TabOrder = 39
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 52
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODBAS'
      TabOrder = 1
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidad: TDBEditFocus
      Tag = 99
      Left = 223
      Top = 52
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_CODUNI'
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescProd: TComboBoxFocus
      Left = 84
      Top = 78
      Width = 389
      Height = 22
      Style = csDropDownList
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 517
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Maza Imobili'#225'ria'
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
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 388
      Top = 52
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
    Top = 436
    Width = 519
    ExplicitTop = 436
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 172
      ExplicitLeft = 172
    end
    inherited pnlInfo: TPanel
      Width = 172
      ExplicitWidth = 172
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 0
  end
end
