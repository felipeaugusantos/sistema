inherited frmCadGenNfm: TfrmCadGenNfm
  Left = 250
  Top = 249
  Width = 665
  Height = 376
  Caption = 'Cadasro de N'#243'vas F'#243'rmulas'
  ExplicitWidth = 665
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 304
    Width = 659
    TabOrder = 2
    ExplicitTop = 304
    ExplicitWidth = 659
    DesignSize = (
      659
      28)
    inherited btnSair: TBitBtnLocked
      Left = 582
      ExplicitLeft = 582
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 332
    Width = 659
    TabOrder = 3
    ExplicitTop = 332
    ExplicitWidth = 659
    inherited pnlNomeForm: TPanel
      Left = 312
      TabOrder = 1
      ExplicitLeft = 312
    end
    inherited pnlInfo: TPanel
      Width = 312
      TabOrder = 0
      ExplicitWidth = 312
    end
  end
  inherited pgcDados: TPageControl
    Width = 659
    Height = 304
    TabOrder = 0
    ExplicitWidth = 659
    ExplicitHeight = 304
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 651
      ExplicitHeight = 272
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 659
    Height = 304
    Align = alClient
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object lblCodigo: TLabel
      Left = 27
      Top = 107
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object lblVariac: TLabel
      Left = 200
      Top = 107
      Width = 46
      Height = 14
      Caption = 'Varia'#231#227'o:'
    end
    object lblDescricao: TLabel
      Left = 11
      Top = 131
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblMontadora: TLabel
      Left = 9
      Top = 155
      Width = 54
      Height = 14
      Caption = 'Montadora:'
    end
    object lblAnoIni: TLabel
      Left = 11
      Top = 179
      Width = 52
      Height = 14
      Caption = 'Ano Inicial:'
    end
    object lblAnoFin: TLabel
      Left = 128
      Top = 179
      Width = 48
      Height = 14
      Caption = 'Ano Final:'
    end
    object lblVersao: TLabel
      Left = 24
      Top = 203
      Width = 38
      Height = 14
      Caption = 'Vers'#227'o:'
    end
    object lblProduto: TLabel
      Left = 144
      Top = 203
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 657
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas Formulas'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
    end
    object dbeVariac: TDBEditFocus
      Tag = 99
      Left = 256
      Top = 104
      Width = 121
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_VARIAC'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 128
      Width = 305
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_DESCRI'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMontadora: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 152
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODMON'
      TabOrder = 3
      OnKeyPress = dbeCodMontadoraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Left = 72
      Top = 104
      Width = 121
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODIGO'
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoIni: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 176
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_ANOINI'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAnoFin: TDBEditFocus
      Tag = 99
      Left = 176
      Top = 176
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_ANOFIN'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVersao: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 200
      Width = 65
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_VERSAO'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeProduto: TDBEditFocus
      Tag = 99
      Left = 192
      Top = 200
      Width = 185
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_PRODUT'
      TabOrder = 9
      OnKeyPress = dbeProdutoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grpFormulacao: TGroupBox
      Left = 384
      Top = 32
      Width = 265
      Height = 265
      Caption = 'Formula'#231#227'o 900 ml'
      TabOrder = 11
      object lblBase: TLabel
        Left = 13
        Top = 19
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade1: TLabel
        Left = 119
        Top = 19
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblQuantidade2: TLabel
        Left = 119
        Top = 43
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase2: TLabel
        Left = 13
        Top = 43
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblBase3: TLabel
        Left = 13
        Top = 67
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade3: TLabel
        Left = 119
        Top = 67
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase4: TLabel
        Left = 13
        Top = 91
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade4: TLabel
        Left = 119
        Top = 91
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase5: TLabel
        Left = 13
        Top = 115
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade5: TLabel
        Left = 119
        Top = 115
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase6: TLabel
        Left = 13
        Top = 139
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade6: TLabel
        Left = 119
        Top = 139
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase7: TLabel
        Left = 13
        Top = 163
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade7: TLabel
        Left = 119
        Top = 163
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase8: TLabel
        Left = 13
        Top = 187
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade8: TLabel
        Left = 119
        Top = 187
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase9: TLabel
        Left = 13
        Top = 211
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade9: TLabel
        Left = 119
        Top = 211
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase10: TLabel
        Left = 13
        Top = 235
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade10: TLabel
        Left = 119
        Top = 235
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object dbeBase01: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 16
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM01'
        TabOrder = 0
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade01: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 16
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC01'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade02: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 40
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC02'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase02: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 40
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM02'
        TabOrder = 2
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase03: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 64
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM03'
        TabOrder = 4
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade03: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 64
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC03'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase04: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 88
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM04'
        TabOrder = 6
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade04: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 88
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC04'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase05: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 112
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM05'
        TabOrder = 8
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade05: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 112
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC05'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase06: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 136
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM06'
        TabOrder = 10
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade06: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 136
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC06'
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase07: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 160
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM07'
        TabOrder = 12
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade07: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 160
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC07'
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase08: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 184
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM08'
        TabOrder = 14
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade08: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 184
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC08'
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase09: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 208
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM09'
        TabOrder = 16
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade09: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 208
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC09'
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase10: TDBEditFocus
        Tag = 99
        Left = 48
        Top = 232
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM10'
        TabOrder = 18
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade10: TDBEditFocus
        Tag = 99
        Left = 184
        Top = 232
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC10'
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object edtDesMontadora: TEditFocus
      Left = 128
      Top = 152
      Width = 249
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbchkNacional: TDBCheckBox
      Left = 232
      Top = 177
      Width = 73
      Height = 17
      Caption = 'Nacional'
      DataField = 'NFM_NACION'
      TabOrder = 7
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 16
  end
end
