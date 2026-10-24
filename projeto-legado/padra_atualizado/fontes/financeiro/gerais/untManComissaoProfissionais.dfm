inherited frmManComissaoProfissionais: TfrmManComissaoProfissionais
  Left = 253
  Top = 249
  Width = 618
  Height = 397
  Caption = 'Manuten'#231#227'o da Comiss'#227'o de Profissionais'
  OnDestroy = FormDestroy
  ExplicitWidth = 618
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 306
    Width = 612
    Height = 46
    TabOrder = 1
    ExplicitTop = 306
    ExplicitWidth = 610
    ExplicitHeight = 46
    inherited FlwBotoes: TFlowPanel
      Width = 608
      Height = 42
      ExplicitTop = 2
      ExplicitWidth = 606
      ExplicitHeight = 42
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        Align = alLeft
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        Align = alLeft
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        Align = alLeft
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 74
        Align = alLeft
        ExplicitLeft = 219
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 293
        Width = 76
        Align = alLeft
        ExplicitLeft = 293
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 369
        Width = 76
        Align = alLeft
        ExplicitLeft = 369
        ExplicitWidth = 76
      end
      object btnCalculo: TBitBtnLocked
        Left = 445
        Top = 0
        Width = 74
        Height = 20
        Align = alLeft
        Caption = '[F3] Baixar'
        Enabled = False
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnCalculoClick
      end
      object btnEstorno: TBitBtnLocked
        Left = 519
        Top = 0
        Width = 74
        Height = 20
        Align = alLeft
        Caption = '[F3] Estorno'
        Enabled = False
        NumGlyphs = 2
        TabOrder = 7
        OnClick = btnEstornoClick
      end
      object btnHistMovDocto: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 148
        Height = 20
        Align = alLeft
        Caption = '&Hist. Documento'
        Enabled = False
        TabOrder = 8
        OnClick = btnHistMovDoctoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 521
      Top = 22
      Width = 74
      Height = 21
      ExplicitLeft = 521
      ExplicitTop = 22
      ExplicitWidth = 74
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 352
    Width = 612
    TabOrder = 3
    ExplicitTop = 352
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 265
      ExplicitLeft = 263
    end
    inherited pnlInfo: TPanel
      Width = 265
      ExplicitWidth = 263
    end
  end
  inherited pgcDados: TPageControl
    Width = 612
    Height = 306
    ExplicitWidth = 610
    ExplicitHeight = 306
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 602
      ExplicitHeight = 274
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 612
    Height = 306
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 610
    object bvlLinha: TBevel
      Left = 2
      Top = 2
      Width = 608
      Height = 53
      Align = alTop
      Shape = bsBottomLine
      ExplicitWidth = 600
    end
    object lblCodigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = dbeCodCom
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDtaCad: TLabel
      Left = 102
      Top = 8
      Width = 84
      Height = 14
      Caption = 'Data de Cadastro'
    end
    object lblCliente: TLabel
      Left = 39
      Top = 94
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      FocusControl = dbeCodCli
    end
    object Label1: TLabel
      Left = 17
      Top = 71
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
      FocusControl = dbeNumDoc
    end
    object Label2: TLabel
      Left = 211
      Top = 71
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
      FocusControl = dbeEspDoc
    end
    object Label3: TLabel
      Left = 288
      Top = 71
      Width = 45
      Height = 14
      Caption = 'Empresa:'
      FocusControl = dbeCodEmp
    end
    object ColorLabel1: TColorLabel
      Left = 110
      Top = 186
      Width = 89
      Height = 14
      Caption = '(C)r'#233'dito / (D)'#233'bito'
      FocusControl = dbeCreDeb
      CorDestaque = clRed
    end
    object Label4: TLabel
      Left = 25
      Top = 117
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr Venda:'
      FocusControl = dbeVrVenda
    end
    object Label5: TLabel
      Left = 35
      Top = 205
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observ:'
      FocusControl = dbeObserv
    end
    object Label6: TLabel
      Left = 15
      Top = 140
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Profissional:'
    end
    object lblQtdPon: TLabel
      Left = 9
      Top = 163
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr Comiss'#227'o:'
      FocusControl = dbeVrComi
    end
    object lblDtaBai: TLabel
      Left = 191
      Top = 8
      Width = 67
      Height = 14
      Caption = 'Data da Baixa'
    end
    object Label7: TLabel
      Left = 280
      Top = 8
      Width = 91
      Height = 14
      Caption = 'Operador da Baixa'
    end
    object shpVlrCom: TShape
      Left = 77
      Top = 159
      Width = 8
      Height = 22
    end
    object dbeCodCom: TDBEditFocus
      Left = 8
      Top = 22
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_CODCOM'
      DataSource = dtsComPro
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 102
      Top = 22
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_DTACAD'
      DataSource = dtsComPro
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 90
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_CODCLI'
      DataSource = dtsComPro
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 157
      Top = 90
      Width = 436
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 67
      Width = 128
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_NUMDOC'
      DataSource = dtsComPro
      Enabled = False
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeEspDoc: TDBEditFocus
      Tag = 99
      Left = 254
      Top = 67
      Width = 30
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_ESPDOC'
      DataSource = dtsComPro
      Enabled = False
      MaxLength = 2
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfabetico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 336
      Top = 67
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_CODEMP'
      DataSource = dtsComPro
      MaxLength = 3
      TabOrder = 4
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 376
      Top = 67
      Width = 217
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCreDeb: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 182
      Width = 29
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_CREDEB'
      DataSource = dtsComPro
      MaxLength = 1
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeVrVenda: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 113
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_VRVEND'
      DataSource = dtsComPro
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeObserv: TDBMemoFocus
      Left = 77
      Top = 205
      Width = 516
      Height = 89
      DataField = 'COM_OBSERV'
      DataSource = dtsComPro
      TabOrder = 10
      OnKeyPress = dbeObservKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeVrComi: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 159
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_VRCOMI'
      DataSource = dtsComPro
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 136
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COM_CODPRO'
      DataSource = dtsComPro
      MaxLength = 8
      TabOrder = 7
      OnChange = dbeCodProChange
      OnExit = dbeCodProExit
      OnKeyPress = dbeCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtProfissional: TEditFocus
      Left = 157
      Top = 136
      Width = 436
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaBai: TDBEditFocus
      Left = 191
      Top = 22
      Width = 87
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'COM_DTABAI'
      DataSource = dtsComPro
      Enabled = False
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeOpeBai: TDBEditFocus
      Tag = 99
      Left = 280
      Top = 22
      Width = 39
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'COM_OPEBAI'
      DataSource = dtsComPro
      Enabled = False
      MaxLength = 3
      TabOrder = 15
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesOperador: TEditFocus
      Left = 320
      Top = 22
      Width = 273
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 504
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 0
  end
  object dtsComPro: TDataSource
    OnStateChange = dtsComProStateChange
    Left = 424
    Top = 136
  end
end
