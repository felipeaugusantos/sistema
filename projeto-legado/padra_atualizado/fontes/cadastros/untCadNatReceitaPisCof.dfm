inherited frmCadNatReceitaPisCof: TfrmCadNatReceitaPisCof
  Left = 379
  Top = 272
  Width = 539
  Height = 203
  Caption = 'Cadastro de Natureza da Receita de PIS e COFINS'
  ExplicitWidth = 539
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 136
    Width = 533
    Height = 22
    BevelInner = bvNone
    TabOrder = 2
    ExplicitTop = 136
    ExplicitWidth = 533
    ExplicitHeight = 22
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 531
      Height = 20
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 531
      ExplicitHeight = 20
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      Top = 1
      Width = 73
      Height = 20
      ExplicitLeft = 452
      ExplicitTop = 1
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 158
    Width = 533
    TabOrder = 3
    ExplicitTop = 158
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 348
      Width = 185
      TabOrder = 1
      ExplicitLeft = 348
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 348
      TabOrder = 0
      ExplicitWidth = 348
    end
  end
  inherited pgcDados: TPageControl
    Width = 533
    Height = 136
    TabOrder = 0
    Visible = False
    ExplicitWidth = 533
    ExplicitHeight = 136
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 104
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 136
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object Label2: TLabel
      Left = 11
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label18: TLabel
      Left = 342
      Top = 66
      Width = 96
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota de PIS (%):'
    end
    object Label6: TLabel
      Left = 320
      Top = 94
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota de COFINS (%):'
    end
    object dbeDesNat: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 35
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NRE_DESNAT'
      DataSource = dtsCadNre
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
      Left = 68
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NRE_CODNAT'
      DataSource = dtsCadNre
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeAlqPis: TDBEditFocus
      Tag = 99
      Left = 440
      Top = 63
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NRE_ALQPIS'
      DataSource = dtsCadNre
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
      TipoTexto = ttNumerico
    end
    object dbeAlqCof: TDBEditFocus
      Tag = 99
      Left = 440
      Top = 91
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NRE_ALQCOF'
      DataSource = dtsCadNre
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 65528
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
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
    Left = 280
  end
  object dtsCadNre: TDataSource
    Left = 344
  end
end
