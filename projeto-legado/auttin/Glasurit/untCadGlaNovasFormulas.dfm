inherited frmCadGlaNovasFormulas: TfrmCadGlaNovasFormulas
  Left = 338
  Top = 192
  Width = 741
  Height = 469
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Glasurit'
  ExplicitWidth = 741
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 396
    Width = 735
    ExplicitTop = 358
    ExplicitWidth = 735
    inherited FlwBotoes: TFlowPanel
      Width = 731
      ExplicitTop = 2
      ExplicitWidth = 731
    end
    inherited btnSair: TBitBtnLocked
      Left = 658
      ExplicitLeft = 658
    end
  end
  inherited pnlStatus: TPanel
    Top = 424
    Width = 735
    ExplicitTop = 386
    ExplicitWidth = 735
    inherited pnlNomeForm: TPanel
      Left = 388
      ExplicitLeft = 388
    end
    inherited pnlInfo: TPanel
      Width = 388
      ExplicitWidth = 388
    end
  end
  inherited pgcDados: TPageControl
    Width = 735
    Height = 396
    ExplicitWidth = 735
    ExplicitHeight = 358
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 727
      ExplicitHeight = 326
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 735
    Height = 396
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 358
    object Label1: TLabel
      Left = 8
      Top = 45
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 8
      Top = 64
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 168
      Top = 45
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label32: TLabel
      Left = 376
      Top = 44
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object lblInformativo: TLabel
      Left = 448
      Top = 91
      Width = 282
      Height = 18
      Alignment = taRightJustify
      Caption = 'CADASTRAR A F'#211'RMULA PARA 1 LITRO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label43: TLabel
      Left = 463
      Top = 64
      Width = 139
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Acr'#233'scimo m'#227'o de obra:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 733
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Glasurit'
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
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 36
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
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
      Left = 68
      Top = 58
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gpbColorantes: TGroupBox
      Left = 1
      Top = 106
      Width = 733
      Height = 289
      Align = alBottom
      Caption = '     Bases      '
      TabOrder = 5
      ExplicitTop = 104
      object Label7: TLabel
        Left = 8
        Top = 31
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 157
        Top = 31
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label9: TLabel
        Left = 8
        Top = 53
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label10: TLabel
        Left = 157
        Top = 53
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label11: TLabel
        Left = 8
        Top = 75
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 157
        Top = 75
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label13: TLabel
        Left = 8
        Top = 97
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label14: TLabel
        Left = 157
        Top = 97
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label15: TLabel
        Left = 8
        Top = 119
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 157
        Top = 119
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label17: TLabel
        Left = 8
        Top = 141
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 157
        Top = 141
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label19: TLabel
        Left = 8
        Top = 163
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 157
        Top = 163
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label21: TLabel
        Left = 8
        Top = 185
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 157
        Top = 185
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label23: TLabel
        Left = 8
        Top = 207
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 157
        Top = 207
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label25: TLabel
        Left = 8
        Top = 229
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 157
        Top = 229
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label3: TLabel
        Left = 370
        Top = 31
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label5: TLabel
        Left = 370
        Top = 53
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label6: TLabel
        Left = 370
        Top = 75
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label27: TLabel
        Left = 370
        Top = 97
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label28: TLabel
        Left = 370
        Top = 119
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label29: TLabel
        Left = 370
        Top = 141
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label30: TLabel
        Left = 370
        Top = 163
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label31: TLabel
        Left = 370
        Top = 185
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label34: TLabel
        Left = 522
        Top = 31
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label35: TLabel
        Left = 522
        Top = 53
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label36: TLabel
        Left = 522
        Top = 75
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label37: TLabel
        Left = 522
        Top = 97
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label38: TLabel
        Left = 522
        Top = 119
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label39: TLabel
        Left = 522
        Top = 141
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label40: TLabel
        Left = 522
        Top = 163
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label41: TLabel
        Left = 522
        Top = 185
        Width = 55
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label55: TLabel
        Left = 264
        Top = 31
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label56: TLabel
        Left = 264
        Top = 53
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label57: TLabel
        Left = 264
        Top = 75
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label58: TLabel
        Left = 264
        Top = 97
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label59: TLabel
        Left = 264
        Top = 119
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label60: TLabel
        Left = 264
        Top = 142
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label61: TLabel
        Left = 264
        Top = 164
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label62: TLabel
        Left = 264
        Top = 186
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label63: TLabel
        Left = 264
        Top = 208
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label64: TLabel
        Left = 264
        Top = 230
        Width = 45
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label33: TLabel
        Left = 627
        Top = 31
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label42: TLabel
        Left = 627
        Top = 53
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label47: TLabel
        Left = 627
        Top = 75
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label48: TLabel
        Left = 627
        Top = 97
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label49: TLabel
        Left = 627
        Top = 119
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label50: TLabel
        Left = 627
        Top = 142
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label51: TLabel
        Left = 627
        Top = 164
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label52: TLabel
        Left = 627
        Top = 185
        Width = 45
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil.:'
      end
      object Label44: TLabel
        Left = 193
        Top = 270
        Width = 300
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cadastrar a f'#243'rmula no volume de 1000ml'
        Color = clTeal
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblVolumeTotal: TLabel
        Left = 206
        Top = 254
        Width = 415
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Color = clTeal
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
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
        Width = 85
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
        Left = 216
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB01'
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        TabOrder = 3
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
        Left = 216
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB02'
        TabOrder = 4
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        TabOrder = 6
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
        Left = 216
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB03'
        TabOrder = 7
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
        TabOrder = 9
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
        Left = 216
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB04'
        TabOrder = 10
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        TabOrder = 12
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
        Left = 216
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB05'
        TabOrder = 13
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        TabOrder = 15
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
        Left = 216
        Top = 132
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB06'
        TabOrder = 16
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
        TabOrder = 18
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
        Left = 216
        Top = 154
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB07'
        TabOrder = 19
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        TabOrder = 21
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
        Left = 216
        Top = 176
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB08'
        TabOrder = 22
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        TabOrder = 24
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
        Left = 216
        Top = 198
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB09'
        TabOrder = 25
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
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
        TabOrder = 27
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
        Left = 216
        Top = 220
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB10'
        TabOrder = 28
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
        Left = 433
        Top = 22
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        TabOrder = 30
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
        Left = 433
        Top = 44
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        TabOrder = 33
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
        Left = 433
        Top = 66
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        TabOrder = 36
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
        Left = 433
        Top = 88
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        TabOrder = 39
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
        Left = 433
        Top = 110
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        TabOrder = 42
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
        Left = 433
        Top = 132
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
        TabOrder = 45
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
        Left = 433
        Top = 154
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
        TabOrder = 48
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
        Left = 433
        Top = 176
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
        TabOrder = 51
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
        Left = 581
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB11'
        TabOrder = 31
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC12: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB12'
        TabOrder = 34
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC13: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB13'
        TabOrder = 37
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC14: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB14'
        TabOrder = 40
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC15: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB15'
        TabOrder = 43
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC16: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 132
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB16'
        TabOrder = 46
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC17: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 154
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB17'
        TabOrder = 49
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC18: TDBEditFocus
        Tag = 99
        Left = 581
        Top = 176
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB18'
        TabOrder = 52
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
        Left = 313
        Top = 22
        Width = 45
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
        Left = 313
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD02'
        TabOrder = 5
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
        Left = 313
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD03'
        TabOrder = 8
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
        Left = 313
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD04'
        TabOrder = 11
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
        Left = 313
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD05'
        TabOrder = 14
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
        Left = 313
        Top = 133
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD06'
        TabOrder = 17
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
        Left = 313
        Top = 155
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD07'
        TabOrder = 20
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
        Left = 313
        Top = 177
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD08'
        TabOrder = 23
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
        Left = 313
        Top = 199
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD09'
        TabOrder = 26
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
        Left = 313
        Top = 221
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD10'
        TabOrder = 29
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
        Left = 677
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD11'
        TabOrder = 32
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
        Left = 677
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD12'
        TabOrder = 35
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
        Left = 677
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD13'
        TabOrder = 38
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
        Left = 677
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD14'
        TabOrder = 41
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
        Left = 677
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD15'
        TabOrder = 44
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD16: TDBEditFocus
        Tag = 99
        Left = 677
        Top = 133
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD16'
        TabOrder = 47
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD17: TDBEditFocus
        Tag = 99
        Left = 677
        Top = 155
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD17'
        TabOrder = 50
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD18: TDBEditFocus
        Tag = 99
        Left = 677
        Top = 177
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD18'
        TabOrder = 53
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnAjustarVolume: TBitBtn
        Left = 497
        Top = 268
        Width = 114
        Height = 20
        Caption = '&Ajustar Volume'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000020000000A0000001000000011000000110000
          0011000000110000001200000012000000110000000B00000003000000000000
          00000000000000000000000000096C4034C1965845FF945646FF935444FF9254
          42FF925242FF915240FF90513EFF8F503DFF67392CC20000000A000000060000
          00090000000A0000000A00000016AD7463FFFCF9F8FFF9F3F1FFCEAFA3FFF9F3
          F1FFF8F3F1FFCDAEA2FFF9F3F1FFF9F3F1FFA56854FF0000000E704A3EBD9A66
          56FF9A6654FF9A6554FFC2A9A1FFB37B6BFFFBF9F8FFF8F4F2FFCFB0A5FFF8F4
          F2FFF8F4F2FFCEB0A4FFF8F4F2FFF9F3F2FFAA6E5CFF0000000EB78877FFF8F2
          EEFFF7EFE9FFF6EFE9FFF0ECE9FFB88575FFD8BEB5FFD0B3A7FFCFB3A7FFD0B3
          A7FFCFB2A7FFCFB2A7FFCFB2A6FFCFB1A6FFAD7564FF0000000DB88979FFF8F3
          EFFFC2917FFFC0917EFFF1EDEBFFBD8B7DFFFBFAFAFFF7F5F5FFD1B4AAFFF8F6
          F5FFF7F6F4FFD0B4A8FFF7F5F4FFF8F5F4FFB37D6DFF0000000CB88A7AFFF9F3
          EFFFCBA190FFC79A89FFF3EFEDFFC39588FFFBFAFAFFFBFAFAFFD9C1B7FFFBFA
          FAFFFBFAFAFFD8C0B7FFFBFAFAFFFBFAFAFFB98675FF0000000ABA8C7CFFF9F4
          F1FFF7EFEBFFF7F0EBFFF6F1EFFFD0B0A5FFC79C8EFFC59A8CFFC6998BFFC497
          89FFC39587FFC19385FFC19184FFBF8F82FF8D695DC300000006BA8D7DFFF9F5
          F2FFC79B8DFFC79B8CFFF7F1EDFFDABFB5FFDEC7C0FFF4F0EEFFA0BED9FFA0BE
          D9FFF4F0EEFFD5BEB6FF0000000F000000070000000500000001BC8D7EFFFAF5
          F2FFD1AB9CFFCDA496FFF7F1ECFFD1A89BFFCDA294FFF7F0EBFF609BCDFF5893
          C9FFF7EFEBFFB78978FF00000006000000000000000000000000BC8F80FFFAF6
          F3FFF7F1ECFFF7F1EDFFF7F0EDFFF7F0ECFFF8F0ECFFF7F0ECFFF7F0EBFFF7F0
          EBFFF8F0EBFFB88A79FF00000006000000000000000000000000BE9081FFFAF6
          F4FFD29857FFE4BC87FFE3BB85FFE3BB85FFE3BA84FFE3B984FFE2B982FFCF92
          52FFF8F1ECFFB98B7BFF00000006000000000000000000000000BF9182FFFAF7
          F4FFE0B277FFF0D4ABFFF2D9B3FFF2DAB4FFF2DAB3FFF2D9B1FFEED2A9FFDEAD
          71FFF7F1ECFFBA8C7BFF00000005000000000000000000000000BF9283FFFAF7
          F5FFE2B071FFE2B071FFE2B070FFE0B070FFE0AF70FFE0AF6EFFE0AF6EFFE0AC
          6CFFF8F1EDFFBB8D7DFF00000005000000000000000000000000C09485FFFCF8
          F6FFFCF8F6FFFBF7F6FFFBF7F5FFFAF7F5FFFBF7F4FFFBF7F4FFFAF7F4FFFAF7
          F4FFFBF7F4FFBC8E7EFF000000040000000000000000000000009B8175BFD1AE
          9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE9EFFD1AE
          9EFFD1AE9EFF9B8175BF00000002000000000000000000000000}
        TabOrder = 54
        OnClick = btnAjustarVolumeClick
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
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBComboBoxFocus
      Tag = 99
      Left = 408
      Top = 36
      Width = 49
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'NFM_LINHA_'
      Items.Strings = (
        '22'
        '55'
        '90'
        '35'
        '30')
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 608
      Top = 58
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
