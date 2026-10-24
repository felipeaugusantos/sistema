inherited frmCadAtividades: TfrmCadAtividades
  Left = 379
  Top = 272
  Width = 539
  Height = 253
  Caption = 'Cadastro de Atividades'
  ExplicitWidth = 539
  ExplicitHeight = 253
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 533
    Height = 22
    BevelInner = bvNone
    TabOrder = 2
    ExplicitTop = 143
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
  inherited pgcDados: TPageControl
    Width = 533
    Height = 186
    TabOrder = 0
    Visible = False
    ExplicitWidth = 533
    ExplicitHeight = 186
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 154
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 186
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object Label2: TLabel
      Left = 11
      Top = 36
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
    object Label3: TLabel
      Left = 402
      Top = 12
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela de Pre'#231'o:'
    end
    object Label5: TLabel
      Left = 29
      Top = 60
      Width = 33
      Height = 14
      Caption = 'Grupo:'
    end
    object dbeDesAti: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 32
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATI_DESATI'
      DataSource = dtsCadAti
      TabOrder = 2
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
      Top = 8
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATI_CODATI'
      DataSource = dtsCadAti
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeTabPre: TDBEditFocus
      Tag = 99
      Left = 485
      Top = 8
      Width = 30
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATI_TABPRE'
      DataSource = dtsCadAti
      TabOrder = 1
      OnEnter = dbeTabPreEnter
      OnExit = dbeTabPreExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCodGat: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 56
      Width = 36
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ATI_CODGAT'
      DataSource = dtsCadAti
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = dbeCodGatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesGat: TEditFocus
      Left = 103
      Top = 56
      Width = 412
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlRenPre: TPanel
      Left = 2
      Top = 145
      Width = 529
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object Label4: TLabel
        Left = 12
        Top = 8
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Renda Presumida:'
      end
      object dbeRenPre: TDBEditFocus
        Tag = 99
        Left = 101
        Top = 4
        Width = 78
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ATI_RENPRE'
        DataSource = dtsCadAti
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
        TipoTexto = ttNumerico
      end
    end
    object pnlPerCom: TPanel
      Left = 2
      Top = 86
      Width = 529
      Height = 59
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Label18: TLabel
        Left = 28
        Top = 4
        Width = 253
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o para profissionais para itens normais (%):'
      end
      object Label6: TLabel
        Left = 4
        Top = 34
        Width = 277
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o para profissionais para itens em promo'#231#227'o(%):'
      end
      object dbePerCom: TDBEditFocus
        Tag = 99
        Left = 283
        Top = 1
        Width = 78
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ATI_PERCOM'
        DataSource = dtsCadAti
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
        TipoTexto = ttNumerico
      end
      object dbePercentualComissaoEmPromocao: TDBEditFocus
        Tag = 99
        Left = 283
        Top = 31
        Width = 78
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ATI_PERCOP'
        DataSource = dtsCadAti
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 208
    Width = 533
    TabOrder = 3
    ExplicitTop = 186
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
  object dtsCadAti: TDataSource
    Left = 344
  end
end
