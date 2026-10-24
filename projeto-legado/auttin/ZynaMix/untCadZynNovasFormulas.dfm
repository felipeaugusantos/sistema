inherited frmCadZynNovasFormulas: TfrmCadZynNovasFormulas
  Left = 347
  Top = 425
  Width = 567
  Height = 316
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Novas F'#243'rmulas - Zynamix'
  ExplicitWidth = 567
  ExplicitHeight = 316
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 248
    Width = 561
    ExplicitTop = 248
    ExplicitWidth = 561
    inherited btnSair: TBitBtnLocked
      Left = 484
      ExplicitLeft = 484
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 374
      ExplicitLeft = 374
    end
  end
  inherited pnlStatus: TPanel
    Top = 276
    Width = 561
    ExplicitTop = 276
    ExplicitWidth = 561
    inherited pnlNomeForm: TPanel
      Left = 214
      ExplicitLeft = 214
    end
    inherited pnlInfo: TPanel
      Width = 214
      ExplicitWidth = 214
    end
  end
  inherited pgcDados: TPageControl
    Width = 561
    Height = 248
    ExplicitWidth = 561
    ExplicitHeight = 248
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 553
      ExplicitHeight = 216
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 561
    Height = 248
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
      Top = 83
      Width = 57
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 58
      Top = 60
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label2: TLabel
      Left = 179
      Top = 59
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ve'#237'culo'
    end
    object Label6: TLabel
      Left = 335
      Top = 59
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano:'
    end
    object Label27: TLabel
      Left = 417
      Top = 59
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 559
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Zynamix'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
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
      Top = 79
      Width = 470
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
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
      Top = 110
      Width = 559
      Height = 137
      Align = alBottom
      Caption = '     Pigmentos      '
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
        Left = 136
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
        Left = 136
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
        Left = 136
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
        Left = 136
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
        Left = 136
        Top = 114
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label17: TLabel
        Left = 302
        Top = 26
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 06:'
      end
      object Label18: TLabel
        Left = 438
        Top = 26
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label19: TLabel
        Left = 302
        Top = 48
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 07:'
      end
      object Label20: TLabel
        Left = 438
        Top = 48
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label21: TLabel
        Left = 302
        Top = 70
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 08:'
      end
      object Label22: TLabel
        Left = 438
        Top = 70
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label23: TLabel
        Left = 302
        Top = 92
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 09:'
      end
      object Label24: TLabel
        Left = 438
        Top = 92
        Width = 65
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade:'
      end
      object Label25: TLabel
        Left = 302
        Top = 114
        Width = 57
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Codigo 10:'
      end
      object Label26: TLabel
        Left = 438
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
        Width = 283
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Informar a quantidade sempre em rela'#231#227'o a 1000ml'
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
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB01'
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB02'
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
        Left = 204
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB02'
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB03'
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
        Left = 204
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB03'
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB04'
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
        Left = 204
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB04'
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
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB05'
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
        Left = 204
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB05'
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
        Left = 362
        Top = 22
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB06'
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
        Left = 506
        Top = 22
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB06'
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
        Left = 362
        Top = 44
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB07'
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
        Left = 506
        Top = 44
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB07'
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
        Left = 362
        Top = 66
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB08'
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
        Left = 506
        Top = 66
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB08'
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
        Left = 362
        Top = 88
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB09'
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
        Left = 506
        Top = 88
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB09'
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
        Left = 362
        Top = 110
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_CODB10'
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
        Left = 506
        Top = 110
        Width = 45
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NFM_QTDB10'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeVeicul: TDBEditFocus
      Tag = 99
      Left = 217
      Top = 55
      Width = 114
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_VEICUL'
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
      Left = 361
      Top = 55
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_A_N_O_'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeTipo: TDBEditFocus
      Tag = 99
      Left = 84
      Top = 56
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_TIPO__'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha: TDBEditFocus
      Tag = 99
      Left = 449
      Top = 55
      Width = 72
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NFM_LINHA_'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
  end
end
