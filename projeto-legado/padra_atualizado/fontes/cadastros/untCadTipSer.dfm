inherited frmCadTipSer: TfrmCadTipSer
  Left = 319
  Top = 465
  Width = 681
  Height = 171
  Caption = 'Cadastro de Tipos de Servi'#231'o'
  ExplicitWidth = 681
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 101
    Width = 675
    Height = 25
    TabOrder = 2
    ExplicitTop = 101
    ExplicitWidth = 675
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 594
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 671
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        Height = 21
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        Height = 21
        ExplicitLeft = 85
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        Height = 21
        ExplicitLeft = 170
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        Height = 21
        ExplicitLeft = 255
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        Height = 21
        ExplicitLeft = 340
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        Height = 21
        ExplicitLeft = 425
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 596
      Height = 21
      Align = alRight
      ExplicitLeft = 596
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 536
    Top = 18
    Width = 73
    Height = 33
    Align = alNone
    TabOrder = 1
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
    Width = 675
    Height = 101
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label2: TLabel
      Left = 34
      Top = 31
      Width = 145
      Height = 14
      Caption = 'Descri'#231#227'o do Tipo de Servi'#231'o:'
    end
    object Label1: TLabel
      Left = 65
      Top = 9
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Tipo de Servi'#231'o:'
    end
    object lbl1: TLabel
      Left = 80
      Top = 53
      Width = 99
      Height = 14
      Caption = 'Cor de Identifica'#231#227'o:'
    end
    object btnCorFun: TSpeedButton
      Left = 295
      Top = 49
      Width = 22
      Height = 22
      Enabled = False
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000003
        33333333777777733333333330CCC03333333333F7777733F3333330330C0330
        33333337337773373333333333303333333333F33337333333F3303333333333
        3033373333333333373333333333333333333F3333333333333F033333333333
        3303733333333333337333333333333333333F3333333333333F033333333333
        3303733333333333FF7333333333333000333FFFFF33333777FF000003333307
        B70377777F333377777F09990333330BBB0377777F333377777F099903333307
        B70377777F3333777773099903333330003377777F3333377733000003333330
        3333777773F3F3F7333333333030303333333333373737333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCorFunClick
    end
    object Label3: TLabel
      Left = 64
      Top = 75
      Width = 115
      Height = 14
      Caption = 'Qtde M'#225'xima de Prisma:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 185
      Top = 27
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TPS_DESCRI'
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
      Left = 185
      Top = 5
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TPS_CODIGO'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeCorIde: TDBEditFocus
      Tag = 99
      Left = 185
      Top = 49
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TPS_CORIDE'
      TabOrder = 2
      OnChange = dbeCorIdeChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdPri: TDBEditFocus
      Tag = 99
      Left = 185
      Top = 71
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TPS_QTDPRI'
      MaxLength = 3
      TabOrder = 3
      OnChange = dbeCorIdeChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 126
    Width = 675
    TabOrder = 3
    ExplicitTop = 126
    ExplicitWidth = 675
    inherited pnlNomeForm: TPanel
      Left = 468
      Width = 207
      TabOrder = 1
      ExplicitLeft = 468
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 468
      TabOrder = 0
      ExplicitWidth = 468
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 4
  end
  object dlgColor: TColorDialog
    Left = 400
    Top = 49
  end
end
