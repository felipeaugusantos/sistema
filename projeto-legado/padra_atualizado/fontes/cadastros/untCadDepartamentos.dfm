inherited frmCadDepartamentos: TfrmCadDepartamentos
  Left = 319
  Top = 465
  Width = 535
  Height = 263
  Caption = 'Cadastro de Departamentos'
  OnDestroy = FormDestroy
  ExplicitWidth = 535
  ExplicitHeight = 263
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 193
    Width = 529
    Height = 25
    ExplicitTop = 193
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 457
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 459
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 458
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    Visible = False
    ExplicitLeft = 536
    ExplicitTop = 18
    ExplicitWidth = 73
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 65
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 193
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DEP_DESCRI'
      DataSource = dtsTabela
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
      Left = 65
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DEP_CODIGO'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object chkProAca: TDBCheckBox
      Left = 11
      Top = 65
      Width = 107
      Height = 17
      Caption = 'Produto Acabado'
      DataField = 'DEP_PROACA'
      DataSource = dtsTabela
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      Visible = False
    end
    object chkProEmb: TDBCheckBox
      Left = 124
      Top = 65
      Width = 117
      Height = 17
      Caption = 'Produto Embalagem'
      DataField = 'DEP_PROEMB'
      DataSource = dtsTabela
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      Visible = False
    end
    object chkProMaP: TDBCheckBox
      Left = 266
      Top = 65
      Width = 128
      Height = 17
      Caption = 'Produto Mat'#233'ria-Prima'
      DataField = 'DEP_PROMAP'
      DataSource = dtsTabela
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      Visible = False
    end
    object chkProGra: TDBCheckBox
      Left = 409
      Top = 65
      Width = 106
      Height = 17
      Caption = 'Produto A Granel'
      DataField = 'DEP_PROGRA'
      DataSource = dtsTabela
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      Visible = False
    end
    object rdgSABUTI: TRadioGroup
      Left = 11
      Top = 89
      Width = 185
      Height = 90
      Caption = 'Considerar s'#225'bado como dia '#250'til?'
      Items.Strings = (
        'N'#227'o considerar'
        'Considerar dia Integral'
        'Considerar 3/4 do dia'
        'Considerar 1/2 dia')
      TabOrder = 6
    end
    object rdgDOMUTI: TRadioGroup
      Left = 215
      Top = 89
      Width = 185
      Height = 90
      Caption = 'Considerar domingo como dia '#250'til?'
      Items.Strings = (
        'N'#227'o considerar'
        'Considerar dia Integral'
        'Considerar 3/4 do dia'
        'Considerar 1/2 dia')
      TabOrder = 7
    end
  end
  inherited pnlStatus: TPanel
    Top = 218
    Width = 529
    ExplicitTop = 218
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 360
      Width = 169
      ExplicitLeft = 360
      ExplicitWidth = 169
    end
    inherited pnlInfo: TPanel
      Width = 360
      ExplicitWidth = 360
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 0
  end
  object dtsTabela: TDataSource
    AutoEdit = False
    OnStateChange = dtsTabelaStateChange
    OnDataChange = dtsTabelaDataChange
    Left = 376
    Top = 4
  end
end
