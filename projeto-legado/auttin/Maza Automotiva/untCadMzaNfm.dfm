inherited frmCadMzaNfm: TfrmCadMzaNfm
  Left = 250
  Top = 249
  Width = 525
  Height = 543
  Caption = 'Cadastro de N'#243'vas F'#243'rmulas - Maza Automotiva '
  ExplicitWidth = 525
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 176
    Top = 230
    Width = 3
    Height = 14
  end
  inherited pnlBotoes: TPanel
    Top = 471
    Width = 519
    TabOrder = 2
    ExplicitTop = 471
    ExplicitWidth = 519
    DesignSize = (
      519
      28)
    inherited btnSair: TBitBtnLocked
      Left = 442
      ExplicitLeft = 442
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 224
      TabOrder = 3
      ExplicitLeft = 224
    end
  end
  inherited pnlStatus: TPanel
    Top = 499
    Width = 519
    TabOrder = 3
    ExplicitTop = 499
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 172
      TabOrder = 1
      ExplicitLeft = 172
    end
    inherited pnlInfo: TPanel
      Width = 172
      TabOrder = 0
      ExplicitWidth = 172
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 471
    TabOrder = 0
    ExplicitWidth = 519
    ExplicitHeight = 471
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 439
    end
  end
  object pnlCampos: TPanel [4]
    Left = 0
    Top = 0
    Width = 519
    Height = 471
    Align = alClient
    Color = 16770261
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object lblCodigo: TLabel
      Left = 75
      Top = 36
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object lblVariac: TLabel
      Left = 217
      Top = 36
      Width = 46
      Height = 14
      Caption = 'Varia'#231#227'o:'
    end
    object lblDescricao: TLabel
      Left = 59
      Top = 62
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblMontadora: TLabel
      Left = 57
      Top = 109
      Width = 54
      Height = 14
      Caption = 'Montadora:'
    end
    object lblLinha: TLabel
      Left = 79
      Top = 133
      Width = 32
      Height = 14
      Caption = 'Linha :'
    end
    object Label1: TLabel
      Left = 48
      Top = 86
      Width = 63
      Height = 14
      Caption = 'Observa'#231#227'o:'
    end
    object Label3: TLabel
      Left = 328
      Top = 37
      Width = 84
      Height = 14
      Caption = 'C'#243'digo Universal:'
    end
    object Label14: TLabel
      Left = 46
      Top = 157
      Width = 65
      Height = 14
      Caption = 'Peso da Cor :'
    end
    object Label15: TLabel
      Left = 220
      Top = 160
      Width = 86
      Height = 14
      Caption = 'Peso da F'#243'rmula :'
    end
    object Label16: TLabel
      Left = 6
      Top = 182
      Width = 105
      Height = 14
      Caption = 'Acr'#233'sc. m'#227'o de obra:'
    end
    object dbeVariac: TDBEditFocus
      Tag = 99
      Left = 266
      Top = 33
      Width = 56
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_VARIAC'
      MaxLength = 4
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 57
      Width = 381
      Height = 20
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
    object dbeCodMontadora: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 106
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODMON'
      TabOrder = 5
      OnKeyPress = dbeCodMontadoraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Left = 116
      Top = 33
      Width = 91
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_CODIGO'
      Enabled = False
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 130
      Width = 49
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_LINHA_'
      TabOrder = 6
      OnKeyPress = dbeLinha_KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grpFormulacao: TGroupBox
      Left = 1
      Top = 206
      Width = 517
      Height = 264
      Align = alBottom
      Caption = 'Formula'#231#227'o 900 ml'
      TabOrder = 11
      object lblBase: TLabel
        Left = 10
        Top = 22
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade1: TLabel
        Left = 116
        Top = 22
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblQuantidade2: TLabel
        Left = 116
        Top = 46
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase2: TLabel
        Left = 10
        Top = 46
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblBase3: TLabel
        Left = 10
        Top = 70
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade3: TLabel
        Left = 116
        Top = 70
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase4: TLabel
        Left = 10
        Top = 94
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade4: TLabel
        Left = 116
        Top = 94
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase5: TLabel
        Left = 10
        Top = 118
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade5: TLabel
        Left = 116
        Top = 118
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase6: TLabel
        Left = 10
        Top = 142
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade6: TLabel
        Left = 116
        Top = 142
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase7: TLabel
        Left = 10
        Top = 166
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade7: TLabel
        Left = 116
        Top = 166
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase8: TLabel
        Left = 10
        Top = 190
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade8: TLabel
        Left = 116
        Top = 190
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase9: TLabel
        Left = 10
        Top = 214
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade9: TLabel
        Left = 116
        Top = 214
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object lblBase10: TLabel
        Left = 10
        Top = 238
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object lblQuantidade10: TLabel
        Left = 116
        Top = 238
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label4: TLabel
        Left = 253
        Top = 21
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object Label5: TLabel
        Left = 253
        Top = 46
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object Label6: TLabel
        Left = 253
        Top = 70
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object Label7: TLabel
        Left = 253
        Top = 94
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object Label8: TLabel
        Left = 253
        Top = 118
        Width = 28
        Height = 14
        Caption = 'Base:'
      end
      object Label9: TLabel
        Left = 359
        Top = 22
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label10: TLabel
        Left = 359
        Top = 46
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label11: TLabel
        Left = 359
        Top = 70
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label12: TLabel
        Left = 359
        Top = 94
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object Label13: TLabel
        Left = 359
        Top = 118
        Width = 58
        Height = 14
        Caption = 'Quantidade:'
      end
      object dbeBase01: TDBEditFocus
        Tag = 99
        Left = 45
        Top = 19
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
        Left = 181
        Top = 19
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
        Left = 181
        Top = 43
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
        Left = 45
        Top = 43
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
        Left = 45
        Top = 67
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
        Left = 181
        Top = 67
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
        Left = 45
        Top = 91
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
        Left = 181
        Top = 91
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
        Left = 45
        Top = 115
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
        Left = 181
        Top = 115
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
        Left = 45
        Top = 139
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
        Left = 181
        Top = 139
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
        Left = 45
        Top = 163
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
        Left = 181
        Top = 163
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
        Left = 45
        Top = 187
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
        Left = 181
        Top = 187
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
        Left = 45
        Top = 211
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
        Left = 181
        Top = 211
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
        Left = 45
        Top = 235
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
        Left = 181
        Top = 235
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
      object dbeBase11: TDBEditFocus
        Tag = 99
        Left = 287
        Top = 19
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM11'
        TabOrder = 20
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase12: TDBEditFocus
        Tag = 99
        Left = 287
        Top = 43
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM12'
        TabOrder = 22
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase13: TDBEditFocus
        Tag = 99
        Left = 288
        Top = 66
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM13'
        TabOrder = 24
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase14: TDBEditFocus
        Tag = 99
        Left = 287
        Top = 91
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM14'
        TabOrder = 26
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeBase15: TDBEditFocus
        Tag = 99
        Left = 287
        Top = 115
        Width = 65
        Height = 20
        CharCase = ecUpperCase
        DataField = 'NFM_FORM15'
        TabOrder = 28
        OnKeyPress = dbeBase10KeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade11: TDBEditFocus
        Tag = 99
        Left = 421
        Top = 19
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC11'
        TabOrder = 21
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade12: TDBEditFocus
        Tag = 99
        Left = 421
        Top = 43
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC12'
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade13: TDBEditFocus
        Tag = 99
        Left = 421
        Top = 67
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC13'
        TabOrder = 25
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade14: TDBEditFocus
        Tag = 99
        Left = 421
        Top = 91
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC14'
        TabOrder = 27
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQuantidade15: TDBEditFocus
        Tag = 99
        Left = 421
        Top = 115
        Width = 65
        Height = 20
        DataField = 'NFM_QTDC15'
        TabOrder = 29
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object edtDesMontadora: TEditFocus
      Left = 172
      Top = 106
      Width = 325
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeObserv: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 82
      Width = 381
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_OBSERV'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesLinha_: TEditFocus
      Left = 172
      Top = 130
      Width = 325
      Height = 20
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeUniver: TDBEditFocus
      Tag = 99
      Left = 415
      Top = 33
      Width = 82
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_UNIVER'
      MaxLength = 7
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesCor: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 154
      Width = 91
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_PESCOR'
      Enabled = False
      MaxLength = 10
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePesFor: TDBEditFocus
      Tag = 99
      Left = 311
      Top = 154
      Width = 91
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_PESFOR'
      Enabled = False
      MaxLength = 10
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 116
      Top = 177
      Width = 91
      Height = 20
      CharCase = ecUpperCase
      DataField = 'NFM_ACRMOB'
      Enabled = False
      MaxLength = 10
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 517
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Maza Automotiva'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 13
      ExplicitWidth = 521
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 152
  end
end
