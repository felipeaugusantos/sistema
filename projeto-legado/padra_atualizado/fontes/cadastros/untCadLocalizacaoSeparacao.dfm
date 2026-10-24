inherited frmCadLocalizacaoSeparacao: TfrmCadLocalizacaoSeparacao
  Left = 254
  Top = 376
  Width = 535
  Height = 167
  Caption = 'Cadastro de Localiza'#231#227'o de Separa'#231#227'o'
  ExplicitWidth = 535
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 97
    Width = 529
    Height = 25
    TabOrder = 1
    ExplicitTop = 97
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 461
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 21
        Spacing = 2
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 463
      Width = 64
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 453
      ExplicitWidth = 64
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 97
    Visible = False
    ExplicitWidth = 529
    ExplicitHeight = 97
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 65
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 97
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 58
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 42
      Top = 39
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lbl25: TLabel
      Left = 52
      Top = 62
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Formato:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 34
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LSE_DESCRI'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 40
      ParentFont = False
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
      Left = 96
      Top = 11
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LSE_CODIGO'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object cbbFormat: TComboBoxFocus
      Tag = 99
      Left = 96
      Top = 57
      Width = 193
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
      Items.Strings = (
        'Agrupando por Produtos'
        'Agrupando por Cliente + Produtos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 122
    Width = 529
    TabOrder = 3
    ExplicitTop = 122
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 362
      Width = 167
      ExplicitLeft = 362
      ExplicitWidth = 167
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 362
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
