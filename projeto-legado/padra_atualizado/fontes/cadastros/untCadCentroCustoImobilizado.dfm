inherited frmCadCentroCustoImobilizado: TfrmCadCentroCustoImobilizado
  Width = 533
  Height = 167
  Caption = 'Centro de Custo para Imobilizado'
  ExplicitWidth = 533
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 94
    Width = 527
    ExplicitTop = 94
    ExplicitWidth = 527
    inherited FlwBotoes: TFlowPanel
      Width = 523
      ExplicitTop = 2
      ExplicitWidth = 523
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        Height = 22
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        Height = 22
        ExplicitLeft = 74
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        Height = 22
        ExplicitLeft = 148
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        Height = 22
        ExplicitLeft = 222
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        Height = 22
        ExplicitLeft = 296
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        Height = 22
        ExplicitLeft = 370
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 446
      ExplicitLeft = 446
    end
  end
  inherited pgcDados: TPageControl
    Width = 527
    Height = 94
    ExplicitWidth = 527
    ExplicitHeight = 94
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 519
      ExplicitHeight = 62
    end
  end
  inherited pnlStatus: TPanel
    Top = 122
    Width = 527
    ExplicitTop = 122
    ExplicitWidth = 527
    inherited pnlNomeForm: TPanel
      Left = 180
      ExplicitLeft = 180
    end
    inherited pnlInfo: TPanel
      Width = 180
      ExplicitWidth = 180
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 527
    Height = 94
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object labelDescricao: TLabel
      Left = 146
      Top = 11
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Centro de custo:'
    end
    object labelCodigo: TLabel
      Left = 46
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object labelValidoContribIPI: TLabel
      Left = 46
      Top = 60
      Width = 131
      Height = 14
      Alignment = taRightJustify
      Caption = 'V'#225'lido para Contribuinte IPI:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object labelSN: TLabel
      Left = 207
      Top = 60
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = '(S/N)'
    end
    object dbeContribIPI: TDBEditFocus
      Tag = 99
      Left = 183
      Top = 57
      Width = 18
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SPE_CONIPI'
      DataSource = dtsCentroCusto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
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
      Left = 146
      Top = 24
      Width = 326
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SPE_DESCRI'
      DataSource = dtsCentroCusto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
      Left = 46
      Top = 24
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SPE_CODIGO'
      DataSource = dtsCentroCusto
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
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 720
    Top = 24
  end
  object dtsCentroCusto: TDataSource
    Left = 672
    Top = 24
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpLeftBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 839
    Top = 24
  end
end
