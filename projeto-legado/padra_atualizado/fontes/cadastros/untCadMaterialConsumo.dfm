inherited frmCadMaterialConsumo: TfrmCadMaterialConsumo
  Width = 544
  Height = 273
  Caption = 'Cadastro de Material de Consumo'
  OnDestroy = FormDestroy
  ExplicitWidth = 544
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 203
    Width = 538
    Height = 25
    ExplicitTop = 203
    ExplicitWidth = 538
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 534
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 534
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        ExplicitWidth = 76
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 76
        ExplicitLeft = 76
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 152
        Width = 76
        ExplicitLeft = 152
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 228
        Width = 76
        ExplicitLeft = 228
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 304
        ExplicitLeft = 304
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 376
        Width = 80
        ExplicitLeft = 376
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 458
      Width = 70
      Height = 20
      ExplicitLeft = 458
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 538
    Height = 203
    ExplicitWidth = 538
    ExplicitHeight = 203
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 530
      ExplicitHeight = 171
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 538
    Height = 203
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 62
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 53
      Top = 41
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 20
      Top = 64
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pre'#231'o de Compra:'
    end
    object ColorLabel4: TColorLabel
      Left = 454
      Top = 62
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label67: TLabel
      Left = 359
      Top = 62
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo:'
    end
    object Label7: TLabel
      Left = 47
      Top = 87
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label8: TLabel
      Left = 16
      Top = 110
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de F'#225'brica:'
    end
    object Label9: TLabel
      Left = 19
      Top = 133
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de Barras:'
    end
    object dbeCodMco: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 10
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_CODMCO'
      DataSource = dtsCadMco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 33
      Width = 422
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_DESCRI'
      DataSource = dtsCadMco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePreCom: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 56
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_PRECOM'
      DataSource = dtsCadMco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMcoAti: TDBEditFocus
      Tag = 99
      Left = 389
      Top = 56
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_MCOATI'
      DataSource = dtsCadMco
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 79
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_CODFOR'
      DataSource = dtsCadMco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 199
      Top = 79
      Width = 329
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFab: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 102
      Width = 218
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_CODFAB'
      DataSource = dtsCadMco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodBar: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 125
      Width = 170
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MCO_CODBAR'
      DataSource = dtsCadMco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    inline fraPlanoDeContasPla: TfraPlanoDeContasDBEditFocus
      Left = 22
      Top = 148
      Width = 512
      Height = 22
      TabOrder = 8
      ExplicitLeft = 22
      ExplicitTop = 148
      ExplicitWidth = 512
      inherited lblPlaContas: TLabel
        Left = 0
        Top = 6
        Width = 84
        Height = 14
        ExplicitLeft = 0
        ExplicitTop = 6
        ExplicitWidth = 84
        ExplicitHeight = 14
      end
      inherited dbeCodCta: TDBEditFocus
        Left = 85
        Width = 92
        Height = 22
        DataField = 'MCO_CODCTA'
        DataSource = dtsCadMco
        OnKeyPress = fraPlanoDeContasPladbeCodCtaKeyPress
        ExplicitLeft = 85
        ExplicitWidth = 92
        ExplicitHeight = 22
      end
      inherited edtDesCta: TEditFocus
        Left = 177
        Width = 329
        Height = 22
        ExplicitLeft = 177
        ExplicitWidth = 329
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContasSec: TfraPlanoDeContasDBEditFocus
      Left = 0
      Top = 171
      Width = 530
      Height = 22
      TabOrder = 9
      ExplicitTop = 171
      ExplicitWidth = 530
      inherited lblPlaContas: TLabel
        Left = 0
        Top = 5
        Width = 106
        Height = 14
        Caption = 'Plano de Contas Sec.:'
        ExplicitLeft = 0
        ExplicitTop = 5
        ExplicitWidth = 106
        ExplicitHeight = 14
      end
      inherited dbeCodCta: TDBEditFocus
        Left = 107
        Width = 92
        Height = 22
        DataField = 'MCO_CODCT2'
        DataSource = dtsCadMco
        OnExit = fraPlanoDeContasSecdbeCodCtaExit
        OnKeyPress = fraPlanoDeContasSecdbeCodCtaKeyPress
        ExplicitLeft = 107
        ExplicitWidth = 92
        ExplicitHeight = 22
      end
      inherited edtDesCta: TEditFocus
        Left = 199
        Width = 329
        Height = 22
        ExplicitLeft = 199
        ExplicitWidth = 329
        ExplicitHeight = 22
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 228
    Width = 538
    ExplicitTop = 228
    ExplicitWidth = 538
    inherited pnlNomeForm: TPanel
      Left = 362
      Width = 176
      ExplicitLeft = 362
      ExplicitWidth = 176
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 65520
  end
  object dtsCadMco: TDataSource
    Left = 368
    Top = 8
  end
end
