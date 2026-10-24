inherited frmCadFormaPagamento: TfrmCadFormaPagamento
  Left = 220
  Top = 405
  Width = 656
  Height = 254
  Caption = 'Cadastro de Formas de Pagamento'
  OnDestroy = FormDestroy
  ExplicitWidth = 656
  ExplicitHeight = 254
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 184
    Width = 650
    Height = 25
    ExplicitTop = 184
    ExplicitWidth = 650
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 646
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 646
      inherited btnIncluir: TBitBtnLocked
        Width = 80
        ExplicitWidth = 80
      end
      inherited btnGravar: TBitBtnLocked
        Left = 80
        Width = 80
        ExplicitLeft = 80
        ExplicitWidth = 80
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 160
        Width = 80
        ExplicitLeft = 160
        ExplicitWidth = 80
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 240
        Width = 80
        ExplicitLeft = 240
        ExplicitWidth = 80
      end
      inherited btnCancela: TBitBtnLocked
        Left = 320
        Width = 80
        ExplicitLeft = 320
        ExplicitWidth = 80
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 400
        Width = 80
        ExplicitLeft = 400
        ExplicitWidth = 80
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 571
      Height = 21
      Align = alRight
      ExplicitLeft = 571
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 650
    Height = 184
    ExplicitWidth = 650
    ExplicitHeight = 181
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 642
      ExplicitHeight = 149
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 650
    Height = 184
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 181
    object Label1: TLabel
      Left = 47
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 31
      Top = 40
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label13: TLabel
      Left = 39
      Top = 63
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label37: TLabel
      Left = 38
      Top = 132
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object ColorLabel2: TColorLabel
      Left = 127
      Top = 132
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label3: TLabel
      Left = 8
      Top = 88
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta Cont'#225'bil:'
    end
    object Label6: TLabel
      Left = 543
      Top = 108
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = '(Vendas a D'#233'bito)'
    end
    object Label5: TLabel
      Left = 543
      Top = 85
      Width = 91
      Height = 14
      Alignment = taRightJustify
      Caption = '(Vendas a Cr'#233'dito)'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 13
      Width = 67
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FPG_CODIGO'
      DataSource = dtsCadFpg
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 36
      Width = 451
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FPG_DESCRI'
      DataSource = dtsCadFpg
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodPor: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 59
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FPG_CODPOR'
      DataSource = dtsCadFpg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnExit = dbeCodPorExit
      OnKeyPress = dbeCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtNomPor: TEditFocus
      Left = 135
      Top = 59
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 128
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FPG_STATUS'
      DataSource = dtsCadFpg
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
      TipoTexto = ttAlfabetico
    end
    object dbeConCon: TDBEditFocus
      Tag = 99
      Left = 86
      Top = 82
      Width = 451
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FPG_CONCON'
      DataSource = dtsCadFpg
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkPorPed: TDBCheckBox
      Left = 294
      Top = 128
      Width = 243
      Height = 26
      Caption = 'Permitir definir o portador no pedido de venda?'
      DataField = 'FPG_PORPED'
      DataSource = dtsCadFpg
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
      Left = 11
      Top = 105
      Width = 529
      Height = 22
      TabOrder = 5
      ExplicitLeft = 11
      ExplicitTop = 105
      ExplicitWidth = 529
      inherited lblPlaContas: TLabel
        Left = 3
        Width = 69
        Height = 14
        Caption = 'Plano Contas: '
        ExplicitLeft = 3
        ExplicitWidth = 69
        ExplicitHeight = 14
      end
      inherited dbeCodCta: TDBEditFocus
        Left = 75
        Height = 22
        DataField = 'FPG_CODCTA'
        DataSource = dtsCadFpg
        OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
        PanelInfo = pnlInfo
        ExplicitLeft = 75
        ExplicitHeight = 22
      end
      inherited edtDesCta: TEditFocus
        Left = 131
        Width = 395
        Height = 22
        ExplicitLeft = 131
        ExplicitWidth = 395
        ExplicitHeight = 22
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 209
    Width = 650
    ExplicitTop = 209
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 472
      Width = 178
      ExplicitLeft = 472
      ExplicitWidth = 178
    end
    inherited pnlInfo: TPanel
      Width = 472
      ExplicitWidth = 303
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
  end
  object dtsCadFpg: TDataSource
    Left = 376
  end
end
