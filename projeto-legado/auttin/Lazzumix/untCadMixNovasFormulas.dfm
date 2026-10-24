inherited frmCadMixNovasFormulas: TfrmCadMixNovasFormulas
  Left = 317
  Top = 110
  Width = 791
  Height = 490
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Lazzumix'
  ExplicitWidth = 791
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 422
    Width = 785
    ExplicitTop = 422
    ExplicitWidth = 785
    inherited btnSair: TBitBtnLocked
      Left = 708
      ExplicitLeft = 708
    end
  end
  inherited pnlStatus: TPanel
    Top = 450
    Width = 785
    ExplicitTop = 450
    ExplicitWidth = 785
    inherited pnlNomeForm: TPanel
      Left = 438
      ExplicitLeft = 438
    end
    inherited pnlInfo: TPanel
      Width = 438
      ExplicitWidth = 438
    end
  end
  inherited pgcDados: TPageControl
    Width = 785
    Height = 422
    ExplicitWidth = 785
    ExplicitHeight = 422
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 777
      ExplicitHeight = 390
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 785
    Height = 422
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 56
      Top = 45
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 56
      Top = 67
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label2: TLabel
      Left = 216
      Top = 45
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label34: TLabel
      Left = 8
      Top = 136
      Width = 105
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Volume Concentrado:'
    end
    object Label35: TLabel
      Left = 216
      Top = 136
      Width = 81
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Volume Diluido:'
    end
    object Label37: TLabel
      Left = 304
      Top = 90
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Montadora:'
    end
    object Label36: TLabel
      Left = 56
      Top = 90
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Refer'#234'ncia:'
    end
    object Label38: TLabel
      Left = 56
      Top = 113
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Ano:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 783
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Lazzumix'
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
      Left = 116
      Top = 36
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODNFM'
      DataSource = dtsCadNfm
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
      Left = 116
      Top = 58
      Width = 389
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Top = 168
      Width = 783
      Height = 253
      Align = alBottom
      Caption = '     Bases      '
      TabOrder = 9
      object Label7: TLabel
        Left = 2
        Top = 27
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 01:'
      end
      object Label8: TLabel
        Left = 154
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label9: TLabel
        Left = 2
        Top = 49
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 02:'
      end
      object Label10: TLabel
        Left = 154
        Top = 49
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label11: TLabel
        Left = 2
        Top = 71
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 03:'
      end
      object Label12: TLabel
        Left = 154
        Top = 71
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label13: TLabel
        Left = 2
        Top = 93
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 04:'
      end
      object Label14: TLabel
        Left = 154
        Top = 93
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label15: TLabel
        Left = 2
        Top = 115
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 05:'
      end
      object Label16: TLabel
        Left = 154
        Top = 115
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label17: TLabel
        Left = 2
        Top = 137
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label19: TLabel
        Left = 2
        Top = 160
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label21: TLabel
        Left = 2
        Top = 183
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label23: TLabel
        Left = 2
        Top = 206
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label25: TLabel
        Left = 2
        Top = 229
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label3: TLabel
        Left = 154
        Top = 137
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label5: TLabel
        Left = 154
        Top = 160
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label6: TLabel
        Left = 154
        Top = 183
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label18: TLabel
        Left = 154
        Top = 206
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label20: TLabel
        Left = 154
        Top = 229
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label22: TLabel
        Left = 266
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label24: TLabel
        Left = 266
        Top = 49
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label26: TLabel
        Left = 266
        Top = 71
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label27: TLabel
        Left = 266
        Top = 93
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label28: TLabel
        Left = 266
        Top = 115
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label29: TLabel
        Left = 266
        Top = 137
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label30: TLabel
        Left = 266
        Top = 160
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label31: TLabel
        Left = 266
        Top = 183
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label32: TLabel
        Left = 266
        Top = 206
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label33: TLabel
        Left = 266
        Top = 229
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label39: TLabel
        Left = 400
        Top = 27
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label40: TLabel
        Left = 552
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label41: TLabel
        Left = 400
        Top = 49
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label42: TLabel
        Left = 552
        Top = 49
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label43: TLabel
        Left = 400
        Top = 71
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label44: TLabel
        Left = 552
        Top = 71
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label45: TLabel
        Left = 400
        Top = 93
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label46: TLabel
        Left = 552
        Top = 93
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label47: TLabel
        Left = 400
        Top = 115
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label48: TLabel
        Left = 552
        Top = 115
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label49: TLabel
        Left = 664
        Top = 27
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label50: TLabel
        Left = 664
        Top = 49
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label51: TLabel
        Left = 664
        Top = 71
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label52: TLabel
        Left = 664
        Top = 93
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label53: TLabel
        Left = 664
        Top = 115
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label54: TLabel
        Left = 400
        Top = 137
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 16:'
      end
      object Label55: TLabel
        Left = 552
        Top = 137
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label56: TLabel
        Left = 400
        Top = 160
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 17:'
      end
      object Label57: TLabel
        Left = 552
        Top = 160
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label58: TLabel
        Left = 400
        Top = 183
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 18:'
      end
      object Label59: TLabel
        Left = 552
        Top = 183
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label60: TLabel
        Left = 400
        Top = 206
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 19:'
      end
      object Label61: TLabel
        Left = 552
        Top = 206
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label62: TLabel
        Left = 400
        Top = 229
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 20:'
      end
      object Label63: TLabel
        Left = 552
        Top = 229
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Conc.:'
      end
      object Label64: TLabel
        Left = 664
        Top = 137
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label65: TLabel
        Left = 664
        Top = 160
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label66: TLabel
        Left = 664
        Top = 183
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label67: TLabel
        Left = 664
        Top = 206
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object Label68: TLabel
        Left = 664
        Top = 229
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd. Dil:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 62
        Top = 24
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB01'
        DataSource = dtsCadNfm
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
        Left = 222
        Top = 24
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB01'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 46
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB02'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 68
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
        DataSource = dtsCadNfm
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
      object dbeQtdC03: TDBEditFocus
        Tag = 99
        Left = 222
        Top = 68
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB03'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 90
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 90
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB04'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 112
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
        DataSource = dtsCadNfm
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
      object dbeQtdC05: TDBEditFocus
        Tag = 99
        Left = 222
        Top = 112
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB05'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 134
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 134
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB06'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 157
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
        DataSource = dtsCadNfm
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
      object dbeQtdC07: TDBEditFocus
        Tag = 99
        Left = 222
        Top = 157
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB07'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 180
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 180
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB08'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 203
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 203
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB09'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 62
        Top = 226
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 222
        Top = 226
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB10'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 28
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
        Left = 334
        Top = 24
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD01'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD02'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 68
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD03'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 90
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD04'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 112
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD05'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 134
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD06'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 157
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD07'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 180
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD08'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 203
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD09'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 334
        Top = 226
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD10'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 29
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
        Left = 460
        Top = 24
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB11'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 30
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
        Left = 620
        Top = 24
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB11'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 31
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
        Left = 460
        Top = 46
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB12'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 33
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
        Left = 620
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB12'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 34
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
        Left = 460
        Top = 68
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB13'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 36
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
        Left = 620
        Top = 68
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB13'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 37
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
        Left = 460
        Top = 90
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB14'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 39
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
        Left = 620
        Top = 90
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB14'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 40
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
        Left = 460
        Top = 112
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB15'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 42
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
        Left = 620
        Top = 112
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB15'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 43
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
        Left = 732
        Top = 24
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD11'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 46
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD12'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 68
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD13'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 90
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD14'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 112
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD15'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 44
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm16: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 134
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB16'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 45
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
        Left = 620
        Top = 134
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB16'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 46
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm17: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 157
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB17'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 48
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
        Left = 620
        Top = 157
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB17'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 49
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm18: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 180
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB18'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 51
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
        Left = 620
        Top = 180
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB18'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 52
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm19: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 203
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB19'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 54
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
        Left = 620
        Top = 203
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB19'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 55
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeForm20: TDBEditFocus
        Tag = 99
        Left = 460
        Top = 226
        Width = 85
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB20'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 57
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
        Left = 620
        Top = 226
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB20'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 58
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
        Left = 732
        Top = 134
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD16'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 157
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD17'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 732
        Top = 180
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD18'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 53
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD19: TDBEditFocus
        Tag = 99
        Left = 732
        Top = 203
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD19'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 56
        OnExit = dbeQtdC01Exit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdD20: TDBEditFocus
        Tag = 99
        Left = 732
        Top = 226
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDD20'
        DataSource = dtsCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 300
      Top = 36
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      DataSource = dtsCadNfm
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVolCon: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 127
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_VOLCON'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      OnExit = dbeQtdC01Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVolDil: TDBEditFocus
      Tag = 99
      Left = 300
      Top = 127
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_VOLDIL'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      OnExit = dbeQtdC01Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMontad: TDBEditFocus
      Tag = 99
      Left = 364
      Top = 81
      Width = 141
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_MONTAD'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeRefere: TDBComboBoxFocus
      Tag = 99
      Left = 116
      Top = 81
      Width = 184
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'NFM_REFERE'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Items.Strings = (
        'LAZZULAC'
        'LAZZURIL'
        'LAZZUCRIL'
        'LAZZUDUR'
        'FLEET COLOR   '
        'POLIURETANO'
        'ULTRABASE'
        'LAZZUDUR PU MS'
        'SHERTRUCKMIX')
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeAno: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 104
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_A_N_O_'
      DataSource = dtsCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 24
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 24
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 16
    Top = 80
  end
  object dtsCadNfm: TDataSource
    OnStateChange = dtsCadNfmStateChange
    Left = 680
    Top = 80
  end
end
