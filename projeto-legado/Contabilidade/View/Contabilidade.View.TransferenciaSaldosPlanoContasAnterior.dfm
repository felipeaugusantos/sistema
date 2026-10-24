inherited frmTransferenciaSaldosPlanoContasAnterior: TfrmTransferenciaSaldosPlanoContasAnterior
  Left = 578
  Top = 392
  Width = 667
  Height = 300
  Caption = 'Transfer'#234'ncia de Saldos do Plano de Contas Anterior'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 667
  ExplicitHeight = 300
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 227
    Width = 661
    ExplicitTop = 227
    ExplicitWidth = 661
    inherited FlwBotoes: TFlowPanel
      Width = 657
      ExplicitWidth = 657
      object btnExportar: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 75
        Height = 20
        Caption = 'E&xportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnExportarClick
      end
      object btnImportar: TBitBtnLocked
        Left = 507
        Top = 0
        Width = 75
        Height = 20
        Caption = 'I&mportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
          FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
          00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
          F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
          00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
          F033777777777337F73309999990FFF0033377777777FFF77333099999000000
          3333777777777777333333399033333333333337773333333333333903333333
          3333333773333333333333303333333333333337333333333333}
        NumGlyphs = 2
        TabOrder = 7
        OnClick = btnImportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 584
      Height = 20
      ExplicitLeft = 584
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 255
    Width = 661
    ExplicitTop = 255
    ExplicitWidth = 661
    inherited pnlNomeForm: TPanel
      Left = 314
      ExplicitLeft = 314
    end
    inherited pnlInfo: TPanel
      Width = 314
      ExplicitWidth = 314
    end
  end
  inherited pgcDados: TPageControl
    Width = 661
    Height = 227
    TabOrder = 3
    ExplicitWidth = 661
    ExplicitHeight = 227
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 653
      ExplicitHeight = 195
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 661
    Height = 227
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblContaRef: TLabel
      Left = 5
      Top = 78
      Width = 118
      Height = 28
      Alignment = taRightJustify
      Caption = 'Conta Anal'#237'tica do Plano de Contas Anterior:'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 5
      Top = 183
      Width = 118
      Height = 28
      Alignment = taRightJustify
      Caption = 'Conta Anal'#237'tica do Plano de Contas Novo:'
      WordWrap = True
    end
    object Label6: TLabel
      Left = 6
      Top = 148
      Width = 117
      Height = 28
      Alignment = taRightJustify
      Caption = 'Valor do Saldo Inicial do Per'#237'odo:'
      WordWrap = True
    end
    object lblSigRes: TLabel
      Left = 16
      Top = 113
      Width = 107
      Height = 28
      Alignment = taRightJustify
      Caption = 'Indicador da Situa'#231#227'o do Saldo Incial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblAguardandoSN: TColorLabel
      Left = 163
      Top = 120
      Width = 93
      Height = 14
      Caption = '(D)evedor (C)redor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label11: TLabel
      Left = 78
      Top = 49
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 58
      Top = 16
      Width = 65
      Height = 14
      Caption = 'Compet'#234'ncia:'
    end
    object Label1: TLabel
      Left = 234
      Top = 16
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
      Visible = False
    end
    object dbeContaAnterior: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 82
      Width = 248
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_PLAANT'
      DataSource = dtsPlaNco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeContaNovo: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 186
      Width = 157
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_PLANOV'
      DataSource = dtsPlaNco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnKeyPress = dbeContaNovoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDescricaoContaNovo: TEditFocus
      Left = 292
      Top = 186
      Width = 357
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeValorSaldoInicial: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 152
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_VALLAN'
      DataSource = dtsPlaNco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIndicadorSituacao: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 117
      Width = 28
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_INDSIT'
      DataSource = dtsPlaNco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 46
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_CODEMP'
      DataSource = dtsPlaNco
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 194
      Top = 46
      Width = 455
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCompetencia: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 13
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_COMPET'
      DataSource = dtsPlaNco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 273
      Top = 13
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COA_CODIGO'
      DataSource = dtsPlaNco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 316
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 40
  end
  object dtsPlaNco: TDataSource
    Left = 420
    Top = 44
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.xls'
    Filter = 'Arquivo Excel|*.xls'
    Title = 'Selecione um arquivo'
    Left = 432
    Top = 112
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'Arquivo CSV|*.csv'
    Title = 'Informe o arquivo'
    Left = 496
    Top = 112
  end
  object PopImportar: TPopupMenu
    Left = 568
    Top = 96
    object Importar1: TMenuItem
      Caption = 'Importar'
      OnClick = Importar1Click
    end
    object GerarModelo1: TMenuItem
      Caption = 'Gerar Modelo'
      OnClick = GerarModelo1Click
    end
  end
  object PopExclusao: TPopupMenu
    Left = 568
    Top = 144
    object RegistroAtual1: TMenuItem
      Caption = 'Registro Atual'
      OnClick = RegistroAtual1Click
    end
    object odosRegistros1: TMenuItem
      Caption = 'Todos Registros'
      OnClick = odosRegistros1Click
    end
  end
end
