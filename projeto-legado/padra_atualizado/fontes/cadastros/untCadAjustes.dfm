inherited frmCadAjustes: TfrmCadAjustes
  Width = 601
  Height = 237
  Caption = 'Cadastro de Ajustes'
  OnDestroy = FormDestroy
  ExplicitWidth = 601
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 183
    Width = 595
    Height = 25
    TabOrder = 1
    ExplicitTop = 127
    ExplicitWidth = 595
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 84
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 84
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 168
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 168
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 252
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 336
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 336
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 420
        Width = 84
        Height = 21
        Spacing = 2
        ExplicitLeft = 420
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 517
      Width = 76
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 517
      ExplicitWidth = 76
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 167
    Width = 595
    TabOrder = 2
    ExplicitTop = 111
    ExplicitWidth = 595
    inherited pnlNomeForm: TPanel
      Left = 433
      Width = 162
      ExplicitLeft = 433
      ExplicitWidth = 162
    end
    inherited pnlInfo: TPanel
      Width = 433
      ExplicitWidth = 433
    end
  end
  inherited pgcDados: TPageControl
    Width = 595
    Height = 167
    TabOrder = 0
    ExplicitWidth = 595
    ExplicitHeight = 111
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 587
      ExplicitHeight = 79
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 595
    Height = 167
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 111
    object Label3: TLabel
      Left = 51
      Top = 63
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label2: TLabel
      Left = 22
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 38
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label6: TLabel
      Left = 35
      Top = 186
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Destino:'
      Visible = False
    end
    object labelEnvApIcms: TLabel
      Left = 306
      Top = 65
      Width = 194
      Height = 14
      Alignment = taRightJustify
      Caption = 'Enviar ao Resumo de Apura'#231#227'o do ICMS'
    end
    object Label4: TLabel
      Left = 282
      Top = 85
      Width = 218
      Height = 14
      Alignment = taRightJustify
      Caption = 'Enviar ao Resumo de Sub-Apura'#231#227'o do ICMS'
    end
    object lblCodSub: TLabel
      Left = 15
      Top = 85
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajuste Sub:'
    end
    object Label5: TLabel
      Left = 26
      Top = 134
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. Obr.'
    end
    object dbeDesAju: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 32
      Width = 502
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_DESAJU'
      DataSource = dtsAjuste
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 7
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_CODAJU'
      DataSource = dtsAjuste
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnChange = dbeCodigoChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object rdgDestino: TDBRadioGroup
      Tag = 99
      Left = 77
      Top = 176
      Width = 185
      Height = 34
      Columns = 2
      DataField = 'AJU_DESTAJ'
      DataSource = dtsAjuste
      Items.Strings = (
        'Bloco C'
        'Bloco E')
      TabOrder = 2
      TabStop = True
      Values.Strings = (
        'C'
        'E')
      Visible = False
    end
    object dblTipAju: TDBLookupComboBoxFocus
      Tag = 99
      Left = 77
      Top = 57
      Width = 185
      Height = 22
      DataField = 'AJU_TIPAJU'
      DataSource = dtsAjuste
      KeyField = 'CODTIP'
      ListField = 'DESTIP'
      ListSource = dtsTipAju
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkEnviaResumoApICMS: TDBCheckBox
      Left = 505
      Top = 64
      Width = 16
      Height = 17
      DataField = 'AJU_ENVAPU'
      DataSource = dtsAjuste
      Enabled = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkEnviaResumoSuICMS: TDBCheckBox
      Left = 505
      Top = 84
      Width = 16
      Height = 17
      DataField = 'AJU_ENVSUB'
      DataSource = dtsAjuste
      Enabled = False
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = chkEnviaResumoSuICMSClick
    end
    object dbeCodSub: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 82
      Width = 108
      Height = 22
      CharCase = ecUpperCase
      DataField = 'AJU_CODSUB'
      DataSource = dtsAjuste
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkInfObr: TDBCheckBox
      Left = 272
      Top = 105
      Width = 246
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Informar C'#243'digo da Obriga'#231#227'o a Recolher'
      DataField = 'AJU_INFOBR'
      DataSource = dtsAjuste
      ParentBiDiMode = False
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dblObrRec: TDBLookupComboBoxFocus
      Tag = 99
      Left = 77
      Top = 130
      Width = 467
      Height = 22
      DataField = 'AJU_OBRREC'
      DataSource = dtsAjuste
      KeyField = 'CODOBR'
      ListField = 'DESOBR'
      ListSource = dtsObrRec
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 8
  end
  object dtsAjuste: TDataSource
    Left = 344
  end
  object dtsTipAju: TDataSource
    Left = 444
    Top = 4
  end
  object dtsObrRec: TDataSource
    Left = 548
    Top = 76
  end
end
