inherited frmCadDacNovasFormulas: TfrmCadDacNovasFormulas
  Left = 289
  Top = 201
  Width = 704
  Height = 327
  BorderStyle = bsNone
  Caption = 'Cadastro de Novas F'#243'rmulas'
  ExplicitWidth = 704
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 283
    Width = 704
    TabOrder = 2
    ExplicitTop = 283
    ExplicitWidth = 704
    DesignSize = (
      704
      28)
    inherited btnSair: TBitBtnLocked
      Left = 621
      ExplicitLeft = 621
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pgcDados: TPageControl
    Width = 704
    Height = 283
    TabOrder = 0
    ExplicitWidth = 704
    ExplicitHeight = 283
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 696
      ExplicitHeight = 251
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 704
    Height = 283
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
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
      Top = 58
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'digo:'
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
      Left = 152
      Top = 58
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Base:'
    end
    object Label6: TLabel
      Left = 256
      Top = 58
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 702
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Dacar'
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
      DataField = 'NFM_CODNFM'
      DataSource = dtsDacCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 85
      Top = 78
      Width = 309
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      DataSource = dtsDacCadNfm
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
      Top = 133
      Width = 702
      Height = 149
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
        Left = 124
        Top = 26
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
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
        Left = 124
        Top = 48
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
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
        Left = 124
        Top = 70
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
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
        Left = 124
        Top = 92
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
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
        Left = 124
        Top = 114
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label17: TLabel
        Left = 236
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 351
        Top = 26
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label19: TLabel
        Left = 236
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 351
        Top = 48
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label21: TLabel
        Left = 236
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 351
        Top = 70
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label23: TLabel
        Left = 236
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 351
        Top = 92
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label25: TLabel
        Left = 236
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 351
        Top = 114
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
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
        FocusControl = btnAlterar
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label27: TLabel
        Left = 465
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 11:'
      end
      object Label28: TLabel
        Left = 465
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 12:'
      end
      object Label29: TLabel
        Left = 465
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 13:'
      end
      object Label30: TLabel
        Left = 465
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 14:'
      end
      object Label31: TLabel
        Left = 465
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 15:'
      end
      object Label32: TLabel
        Left = 580
        Top = 26
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label33: TLabel
        Left = 580
        Top = 48
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label34: TLabel
        Left = 580
        Top = 70
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label35: TLabel
        Left = 580
        Top = 92
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object Label36: TLabel
        Left = 580
        Top = 114
        Width = 23
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Qtd.:'
      end
      object dbeForm01: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM01'
        DataSource = dtsDacCadNfm
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
      object dbeForm02: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM02'
        DataSource = dtsDacCadNfm
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
      object dbeForm03: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM03'
        DataSource = dtsDacCadNfm
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
      object dbeForm04: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM04'
        DataSource = dtsDacCadNfm
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
      object dbeForm05: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM05'
        DataSource = dtsDacCadNfm
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
      object dbeForm06: TDBEditFocus
        Tag = 99
        Left = 296
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM06'
        DataSource = dtsDacCadNfm
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
      object dbeForm07: TDBEditFocus
        Tag = 99
        Left = 296
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM07'
        DataSource = dtsDacCadNfm
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
      object dbeForm08: TDBEditFocus
        Tag = 99
        Left = 296
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM08'
        DataSource = dtsDacCadNfm
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
      object dbeForm09: TDBEditFocus
        Tag = 99
        Left = 296
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM09'
        DataSource = dtsDacCadNfm
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
      object dbeForm10: TDBEditFocus
        Tag = 99
        Left = 296
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM10'
        DataSource = dtsDacCadNfm
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
      object dbeForm11: TDBEditFocus
        Tag = 99
        Left = 525
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM11'
        DataSource = dtsDacCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 525
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM12'
        DataSource = dtsDacCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 525
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM13'
        DataSource = dtsDacCadNfm
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
      object dbeForm14: TDBEditFocus
        Tag = 99
        Left = 525
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM14'
        DataSource = dtsDacCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 525
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_FORM15'
        DataSource = dtsDacCadNfm
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 28
        OnKeyPress = dbeForm01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC01: TEditFocus
        Tag = 99
        Left = 150
        Top = 22
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdC02: TEditFocus
        Tag = 99
        Left = 150
        Top = 44
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC03: TEditFocus
        Tag = 99
        Left = 150
        Top = 66
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC04: TEditFocus
        Tag = 99
        Left = 150
        Top = 88
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC05: TEditFocus
        Tag = 99
        Left = 150
        Top = 110
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC06: TEditFocus
        Tag = 99
        Left = 377
        Top = 22
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 11
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC07: TEditFocus
        Tag = 99
        Left = 377
        Top = 44
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC08: TEditFocus
        Tag = 99
        Left = 377
        Top = 66
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 15
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC09: TEditFocus
        Tag = 99
        Left = 377
        Top = 88
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 17
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC10: TEditFocus
        Tag = 99
        Left = 377
        Top = 110
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 19
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC11: TEditFocus
        Tag = 99
        Left = 606
        Top = 22
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 21
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC12: TEditFocus
        Tag = 99
        Left = 606
        Top = 44
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 23
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC13: TEditFocus
        Tag = 99
        Left = 606
        Top = 66
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 25
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC14: TEditFocus
        Tag = 99
        Left = 606
        Top = 88
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 27
        OnExit = dbeQtdC01Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object dbeQtdC15: TEditFocus
        Tag = 99
        Left = 606
        Top = 110
        Width = 75
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 29
        OnExit = dbeQtdC15Exit
        OnKeyPress = dbeQtdC01KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 54
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_CODPRO'
      DataSource = dtsDacCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBase: TDBEditFocus
      Tag = 99
      Left = 212
      Top = 54
      Width = 32
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_BASE__'
      DataSource = dtsDacCadNfm
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidad: TDBEditFocus
      Tag = 99
      Left = 316
      Top = 54
      Width = 45
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_UNIDAD'
      DataSource = dtsDacCadNfm
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object rgbOpcao: TDBRadioGroup
      Left = 400
      Top = 38
      Width = 184
      Height = 62
      Caption = 'Tipo Medida'
      Columns = 2
      DataField = 'NFM_TIPMED'
      DataSource = dtsDacCadNfm
      Items.Strings = (
        'ML'
        'On'#231'as')
      TabOrder = 5
      Values.Strings = (
        'M'
        'O')
      OnChange = rgbOpcaoChange
    end
  end
  inherited pnlStatus: TPanel
    Top = 311
    Width = 704
    TabOrder = 3
    ExplicitTop = 311
    ExplicitWidth = 704
    inherited pnlNomeForm: TPanel
      Left = 357
      TabOrder = 1
      ExplicitLeft = 357
    end
    inherited pnlInfo: TPanel
      Width = 357
      TabOrder = 0
      ExplicitWidth = 357
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 628
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 540
    Top = 40
  end
  object dtsDacCadNfm: TDataSource
    Left = 584
    Top = 40
  end
end
