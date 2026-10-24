inherited frmCadVeiculos: TfrmCadVeiculos
  Left = 532
  Top = 339
  Height = 480
  Caption = 'Cadastro de Ve'#237'culos'
  OnDestroy = FormDestroy
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 410
    Height = 25
    TabOrder = 3
    ExplicitTop = 410
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 507
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 507
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        ExplicitLeft = 83
        ExplicitWidth = 83
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        ExplicitLeft = 166
        ExplicitWidth = 83
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        ExplicitLeft = 249
        ExplicitWidth = 83
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        ExplicitLeft = 332
        ExplicitWidth = 83
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 80
        ExplicitLeft = 415
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 509
      Width = 74
      Height = 21
      Align = alRight
      ExplicitLeft = 509
      ExplicitWidth = 74
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 435
    TabOrder = 4
    ExplicitTop = 435
    inherited pnlNomeForm: TPanel
      Left = 401
      Width = 184
      ExplicitLeft = 401
      ExplicitWidth = 184
    end
    inherited pnlInfo: TPanel
      Width = 401
      ExplicitWidth = 401
    end
  end
  inherited pgcDados: TPageControl
    Left = 1344
    Top = 728
    Width = 73
    Height = 57
    Align = alNone
    TabOrder = 5
    Visible = False
    ExplicitLeft = 1344
    ExplicitTop = 728
    ExplicitWidth = 73
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 25
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 245
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 53
      Top = 20
      Width = 29
      Height = 14
      Alignment = taRightJustify
      Caption = 'Placa:'
    end
    object lbl3: TLabel
      Left = 46
      Top = 89
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chassi:'
    end
    object lbl4: TLabel
      Left = 317
      Top = 43
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Modelo:'
    end
    object lbl5: TLabel
      Left = 49
      Top = 43
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lbl6: TLabel
      Left = 334
      Top = 66
      Width = 20
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor:'
    end
    object lbl7: TLabel
      Left = 59
      Top = 66
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano:'
    end
    object lblCondut: TLabel
      Left = 307
      Top = 89
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condutor:'
    end
    object lbl9: TLabel
      Left = 13
      Top = 156
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
    end
    object lblCapCar: TLabel
      Left = 204
      Top = 20
      Width = 150
      Height = 14
      Alignment = taRightJustify
      Caption = 'Capacidade de Carga (em KG):'
    end
    object Label3: TLabel
      Left = 15
      Top = 112
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tara (em KG):'
    end
    object lblTipoRodado: TLabel
      Left = 19
      Top = 134
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Rodado:'
    end
    object Label5: TLabel
      Left = 277
      Top = 111
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Carroceria:'
    end
    object lblKMATUA: TLabel
      Left = 309
      Top = 135
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'KM Atual:'
    end
    object dbePlaVei: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 16
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_PLAVEI'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeChassi: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 85
      Width = 209
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CHASSI'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMod: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 39
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CODMOD'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      OnKeyPress = dbeCodModKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodModChamaCadastro
    end
    object dbeCodMar: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 39
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CODMAR'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnKeyPress = dbeCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodMarChamaCadastro
    end
    object dbeCodCor: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 62
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CODCOR'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      OnKeyPress = dbeCodCorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodCorChamaCadastro
    end
    object dbeAnoVei: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 62
      Width = 97
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_ANOVEI'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCondut: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 85
      Width = 209
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CONDUT'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object mmoObserv: TDBMemoFocus
      Left = 88
      Top = 154
      Width = 481
      Height = 89
      DataField = 'VEI_OBSERV'
      DataSource = dtsCadVei
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtDesMod: TEditFocus
      Left = 401
      Top = 39
      Width = 168
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 129
      Top = 39
      Width = 168
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCor: TEditFocus
      Left = 401
      Top = 62
      Width = 168
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkZeroKm: TDBCheckBox
      Tag = 99
      Left = 88
      Top = 1
      Width = 105
      Height = 15
      Caption = 'Ve'#237'culo Zero KM'
      DataField = 'VEI_ZEROKM'
      DataSource = dtsCadVei
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkZeroKmClick
    end
    object dbeCapCar: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 16
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CAPCAR'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnEnter = dbeCapCarEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object chkVeiculoAtivo: TDBCheckBox
      Tag = 99
      Left = 228
      Top = 1
      Width = 93
      Height = 15
      Caption = 'Ve'#237'culo Ativo'
      DataField = 'VEI_STATUS'
      DataSource = dtsCadVei
      TabOrder = 1
      ValueChecked = 'A'
      ValueUnchecked = 'I'
      OnClick = chkZeroKmClick
    end
    object dbeTara: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 108
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_TARAKG'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      OnEnter = dbeCapCarEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object chkReboque: TDBCheckBox
      Tag = 99
      Left = 360
      Top = 1
      Width = 115
      Height = 15
      Caption = 'Reboque'
      DataField = 'VEI_REBOQU'
      DataSource = dtsCadVei
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkReboqueClick
    end
    object cmbTipoRodado: TDBComboBoxFocus
      Tag = 99
      Left = 88
      Top = 131
      Width = 209
      Height = 22
      DataField = 'VEI_TIPROD'
      DataSource = dtsCadVei
      Items.Strings = (
        '01 - Truck'
        '02 - Toco'
        '03 - Cavalo Mec'#226'nico'
        '04 - VAN'
        '05 - Utilit'#225'rio'
        '06 - Outros')
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cmbTipoCarroceria: TDBComboBoxFocus
      Tag = 99
      Left = 360
      Top = 108
      Width = 193
      Height = 22
      DataField = 'VEI_TPCARR'
      DataSource = dtsCadVei
      Items.Strings = (
        '00 - N'#227'o aplic'#225'vel'
        '01 - Aberta'
        '02 - Fechada/Ba'#250
        '03 - Graneleira'
        '04 - Porta Container'
        '05 - Sider')
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeKMATUA: TDBEditFocus
      Tag = 99
      Left = 360
      Top = 131
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_KMATUA'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlDadosBetoneira: TPanel [4]
    Left = 0
    Top = 351
    Width = 585
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 32
      Top = 10
      Width = 49
      Height = 14
      Caption = 'Betoneira:'
    end
    object lblMotorista: TLabel
      Left = 34
      Top = 35
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motorista:'
    end
    object dbeBetone: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 6
      Width = 209
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_BETONE'
      DataSource = dtsCadVei
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMot: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 29
      Width = 74
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_CODMOT'
      DataSource = dtsCadVei
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = dbeCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 161
      Top = 29
      Width = 407
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object gbxIntegracaoQualp: TGroupBox [5]
    Left = 0
    Top = 245
    Width = 585
    Height = 106
    Align = alBottom
    Caption = ' Integra'#231#227'o QUALP '
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 15
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'Participa da Integra'#231#227'o QUALP?'
      WordWrap = True
    end
    object lblLeiLGPDSN: TColorLabel
      Left = 207
      Top = 15
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object pnlControlesIntegracaoQualp: TPanel
      Left = 2
      Top = 30
      Width = 581
      Height = 74
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label4: TLabel
        Left = 4
        Top = 9
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Ve'#237'culo:'
      end
      object Label6: TLabel
        Left = 265
        Top = 9
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade Eixos:'
      end
      object Label7: TLabel
        Left = 24
        Top = 32
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Comb.:'
      end
      object Label8: TLabel
        Left = 274
        Top = 32
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Autonomia Km/L'
      end
      object Label9: TLabel
        Left = 1
        Top = 56
        Width = 79
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tp.Acr'#233'sc.Frete'
      end
      object Label10: TLabel
        Left = 257
        Top = 55
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Acr'#233'scimo no Frete'
      end
      object cmbTipoVeiculo: TDBComboBoxFocus
        Tag = 99
        Left = 86
        Top = 4
        Width = 161
        Height = 22
        DataField = 'VEI_TIPVEI'
        DataSource = dtsCadVei
        Items.Strings = (
          '1 - Caminh'#227'o'
          '2 - '#212'nibus'
          '3 - Carro'
          '4 - Moto')
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeQuantidadeEixo: TDBEditFocus
        Tag = 99
        Left = 358
        Top = 5
        Width = 115
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VEI_QTDEIX'
        DataSource = dtsCadVei
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object cmbTipoCombustivel: TDBComboBoxFocus
        Tag = 99
        Left = 86
        Top = 28
        Width = 161
        Height = 22
        DataField = 'VEI_TIPCMB'
        DataSource = dtsCadVei
        Items.Strings = (
          '1 - Gasolina'
          '2 - Etanol'
          '3 - Diesel'
          '4 - Diesel S10')
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeAutonomiaKml: TDBEditFocus
        Tag = 99
        Left = 358
        Top = 28
        Width = 115
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VEI_AUTKML'
        DataSource = dtsCadVei
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object cmbTipoAcrescimoFrete: TDBComboBoxFocus
        Tag = 99
        Left = 86
        Top = 51
        Width = 161
        Height = 22
        DataField = 'VEI_TIPAFR'
        DataSource = dtsCadVei
        Items.Strings = (
          'V - Valor'
          'P - Percentual')
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeAcrescimoFrete: TDBEditFocus
        Tag = 99
        Left = 358
        Top = 51
        Width = 115
        Height = 22
        CharCase = ecUpperCase
        DataField = 'VEI_ACRFRE'
        DataSource = dtsCadVei
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object dbeParticipaIntegracaoQualP: TDBEditFocus
      Tag = 99
      Left = 165
      Top = 12
      Width = 36
      Height = 22
      CharCase = ecUpperCase
      DataField = 'VEI_PINQLP'
      DataSource = dtsCadVei
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 428
    Top = 204
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 200
  end
  object dtsCadVei: TDataSource
    Left = 388
    Top = 204
  end
end
