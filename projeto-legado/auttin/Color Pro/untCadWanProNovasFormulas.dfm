inherited frmCadWanProNovasFormulas: TfrmCadWanProNovasFormulas
  Left = 195
  Top = 110
  Width = 699
  Height = 609
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Color Pro'
  ExplicitWidth = 699
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 541
    Width = 693
    TabOrder = 2
    ExplicitTop = 541
    ExplicitWidth = 693
    inherited btnSair: TBitBtnLocked
      Left = 616
      ExplicitLeft = 616
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 693
    Height = 541
    TabOrder = 0
    ExplicitWidth = 693
    ExplicitHeight = 541
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 685
      ExplicitHeight = 509
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 693
    Height = 541
    Align = alClient
    Color = 16770261
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 8
      Top = 62
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 168
      Top = 40
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label3: TLabel
      Left = 11
      Top = 509
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Diluente:'
    end
    object Label5: TLabel
      Left = 288
      Top = 509
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade (2:1):'
    end
    object Label38: TLabel
      Left = 8
      Top = 85
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Linha:'
    end
    object Label40: TLabel
      Left = 328
      Top = 85
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Alternativa:'
    end
    object Label41: TLabel
      Left = 8
      Top = 107
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Montadora:'
    end
    object Label39: TLabel
      Left = 456
      Top = 509
      Width = 84
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade (4:1):'
    end
    object lbCamada: TLabel
      Left = 344
      Top = 107
      Width = 42
      Height = 14
      Caption = 'Camada:'
    end
    object Label70: TLabel
      Left = 472
      Top = 107
      Width = 118
      Height = 14
      Caption = 'Acr'#233'scimo m'#227'o de obra:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Color Pro'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 36
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
      Left = 68
      Top = 58
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 3
      Top = 131
      Width = 626
      Height = 366
      Caption = '     Bases      '
      TabOrder = 10
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
        Left = 136
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
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
      object Label11: TLabel
        Left = 8
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
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
      object Label15: TLabel
        Left = 8
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label17: TLabel
        Left = 8
        Top = 136
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label19: TLabel
        Left = 8
        Top = 158
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label21: TLabel
        Left = 8
        Top = 180
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label23: TLabel
        Left = 8
        Top = 202
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label25: TLabel
        Left = 8
        Top = 224
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label10: TLabel
        Left = 136
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label12: TLabel
        Left = 136
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label14: TLabel
        Left = 136
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label16: TLabel
        Left = 136
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label28: TLabel
        Left = 288
        Top = 26
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label18: TLabel
        Left = 136
        Top = 136
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label20: TLabel
        Left = 136
        Top = 158
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label22: TLabel
        Left = 136
        Top = 180
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label24: TLabel
        Left = 136
        Top = 202
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label26: TLabel
        Left = 136
        Top = 224
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label6: TLabel
        Left = 288
        Top = 48
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label27: TLabel
        Left = 288
        Top = 70
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label29: TLabel
        Left = 288
        Top = 92
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label30: TLabel
        Left = 288
        Top = 114
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label31: TLabel
        Left = 288
        Top = 136
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label32: TLabel
        Left = 288
        Top = 158
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label33: TLabel
        Left = 288
        Top = 180
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label34: TLabel
        Left = 288
        Top = 202
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label35: TLabel
        Left = 288
        Top = 224
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label36: TLabel
        Left = 456
        Top = 26
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label37: TLabel
        Left = 456
        Top = 48
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label42: TLabel
        Left = 456
        Top = 70
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label43: TLabel
        Left = 456
        Top = 92
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label44: TLabel
        Left = 456
        Top = 114
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label45: TLabel
        Left = 456
        Top = 136
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label46: TLabel
        Left = 456
        Top = 158
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label47: TLabel
        Left = 456
        Top = 180
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label48: TLabel
        Left = 456
        Top = 202
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label49: TLabel
        Left = 456
        Top = 224
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label50: TLabel
        Left = 8
        Top = 246
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label51: TLabel
        Left = 136
        Top = 246
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label52: TLabel
        Left = 288
        Top = 246
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label53: TLabel
        Left = 456
        Top = 246
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label54: TLabel
        Left = 8
        Top = 268
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label55: TLabel
        Left = 136
        Top = 268
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label56: TLabel
        Left = 288
        Top = 268
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label57: TLabel
        Left = 456
        Top = 268
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label58: TLabel
        Left = 8
        Top = 290
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label59: TLabel
        Left = 136
        Top = 290
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label60: TLabel
        Left = 288
        Top = 290
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label61: TLabel
        Left = 456
        Top = 290
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label62: TLabel
        Left = 8
        Top = 312
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label63: TLabel
        Left = 136
        Top = 312
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label64: TLabel
        Left = 288
        Top = 312
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label65: TLabel
        Left = 456
        Top = 312
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object Label66: TLabel
        Left = 8
        Top = 334
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label67: TLabel
        Left = 136
        Top = 334
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label68: TLabel
        Left = 288
        Top = 334
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (2:1):'
      end
      object Label69: TLabel
        Left = 456
        Top = 334
        Width = 81
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dilui. (4:1):'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB01'
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
        Left = 204
        Top = 22
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC01'
        TabOrder = 1
        OnExit = dbeQtdC01Exit
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        TabOrder = 4
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
        Left = 204
        Top = 44
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC02'
        TabOrder = 5
        OnExit = dbeQtdC01Exit
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        TabOrder = 8
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
        Left = 204
        Top = 66
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC03'
        TabOrder = 9
        OnExit = dbeQtdC01Exit
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
        TabOrder = 12
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
        Left = 204
        Top = 88
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC04'
        TabOrder = 13
        OnExit = dbeQtdC01Exit
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        TabOrder = 16
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
        Left = 204
        Top = 110
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC05'
        TabOrder = 17
        OnExit = dbeQtdC01Exit
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
        Top = 132
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        TabOrder = 20
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
        Left = 204
        Top = 132
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC06'
        TabOrder = 21
        OnExit = dbeQtdC01Exit
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
        Top = 154
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
        TabOrder = 24
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
        Left = 204
        Top = 154
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC07'
        TabOrder = 25
        OnExit = dbeQtdC01Exit
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
        Top = 176
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        TabOrder = 28
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
        Left = 204
        Top = 176
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC08'
        TabOrder = 29
        OnExit = dbeQtdC01Exit
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
        Top = 198
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        TabOrder = 32
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
        Left = 204
        Top = 198
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC09'
        TabOrder = 33
        OnExit = dbeQtdC01Exit
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
        Top = 220
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
        TabOrder = 36
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
        Left = 204
        Top = 220
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC10'
        TabOrder = 37
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD01: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 22
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD01'
        TabOrder = 2
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD02: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 44
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD02'
        TabOrder = 6
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD03: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 66
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD03'
        TabOrder = 10
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD04: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 88
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD04'
        TabOrder = 14
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD05: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 110
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD05'
        TabOrder = 18
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD06: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 132
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD06'
        TabOrder = 22
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD07: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 154
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD07'
        TabOrder = 26
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD08: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 176
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD08'
        TabOrder = 30
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD09: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 198
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD09'
        TabOrder = 34
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD10: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 220
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD10'
        TabOrder = 38
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4101: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 22
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4101'
        TabOrder = 3
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4102: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 44
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4102'
        TabOrder = 7
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4103: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 66
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4103'
        TabOrder = 11
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4104: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 88
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4104'
        TabOrder = 15
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4105: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 110
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4105'
        TabOrder = 19
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4106: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 132
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4106'
        TabOrder = 23
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4107: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 154
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4107'
        TabOrder = 27
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4108: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 176
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4108'
        TabOrder = 31
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4109: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 198
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4109'
        TabOrder = 35
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4110: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 220
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4110'
        TabOrder = 39
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 242
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        TabOrder = 40
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
        Left = 204
        Top = 242
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC11'
        TabOrder = 41
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD11: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 242
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD11'
        TabOrder = 42
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4111: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 242
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4111'
        TabOrder = 43
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm12: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 264
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        TabOrder = 44
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
        Left = 204
        Top = 264
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC12'
        TabOrder = 45
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD12: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 264
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD12'
        TabOrder = 46
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4112: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 264
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4112'
        TabOrder = 47
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm13: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 286
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        TabOrder = 48
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
        Left = 204
        Top = 286
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC13'
        TabOrder = 49
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD13: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 286
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD13'
        TabOrder = 50
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4113: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 286
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4113'
        TabOrder = 51
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 308
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        TabOrder = 52
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
        Left = 204
        Top = 308
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC14'
        TabOrder = 53
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD14: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 308
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD14'
        TabOrder = 54
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4114: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 308
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4114'
        TabOrder = 55
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm15: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 330
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        TabOrder = 56
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
        Left = 204
        Top = 330
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDC15'
        TabOrder = 57
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD15: TDBEditFocus
        Tag = 99
        Left = 372
        Top = 330
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD15'
        TabOrder = 58
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQd4115: TDBEditFocus
        Tag = 99
        Left = 540
        Top = 330
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QD4115'
        TabOrder = 59
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 252
      Top = 36
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDil: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 505
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODDIL'
      TabOrder = 11
      OnKeyPress = dbeForm01KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdDil: TDBEditFocus
      Tag = 99
      Left = 375
      Top = 505
      Width = 75
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QTDDIL'
      TabOrder = 12
      OnExit = dbeQtdC01Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeLinha_: TDBEditFocus
      Tag = 99
      Left = 248
      Top = 81
      Width = 45
      Height = 22
      Hint = 'A linha pode ter os valores: (1, 4, 6, 8, 9, 11, 13, 14, 19, 58)'
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_LINHA_'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAltern: TDBEditFocus
      Tag = 99
      Left = 388
      Top = 81
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_ALTERN'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMontad: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 104
      Width = 225
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_MONTAD'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdDi4: TDBEditFocus
      Tag = 99
      Left = 543
      Top = 505
      Width = 75
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_QTDDI4'
      TabOrder = 13
      OnExit = dbeQtdC01Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCamada: TDBEditFocus
      Left = 388
      Top = 103
      Width = 69
      Height = 22
      DataField = 'WAN_CAMADA'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbbLinha: TcxDBComboBox
      Left = 68
      Top = 82
      Properties.Items.Strings = (
        'AUTOBASE PLUS 100:50'
        'WANDABASE HS'
        'WANDALAC'
        'WANDA PU HS'
        'WANDACAR'
        'SINGLE STAGE CONVERTER'
        'AUTOCOAT BT100'
        'AUTOBASE PLUS 100:80'
        'AUTOCOAT BT120'
        'WANDA PU MS'
        'AUTOCOAT BT90'
        'AUTOCOAT BT110'
        'AUTOCOAT BT130 '
        'AUTOWAVE MM'
        'TECH FLEET PU'
        'TECH FLEET EPOXY'
        'TECH FLEET SINTETICO'
        'AUTOBASE PLUS BASELINE 100:80'
        'AUTOBASE PLUS BASELINE 100:50'
        'TECH FLEET LACA')
      Properties.OnChange = cbbLinhaPropertiesChange
      TabOrder = 4
      OnKeyDown = cbbLinhaKeyDown
      Width = 173
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 594
      Top = 103
      Width = 87
      Height = 22
      DataField = 'NFM_ACRMOB'
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
    Top = 569
    Width = 693
    TabOrder = 3
    ExplicitTop = 569
    ExplicitWidth = 693
    inherited pnlNomeForm: TPanel
      Left = 346
      TabOrder = 1
      ExplicitLeft = 346
    end
    inherited pnlInfo: TPanel
      Width = 346
      TabOrder = 0
      ExplicitWidth = 346
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 588
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 556
  end
end
