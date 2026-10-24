inherited frmCadSitTributarias: TfrmCadSitTributarias
  Left = 165
  Top = 263
  Width = 1100
  Height = 208
  Caption = 'Cadastro de Situa'#231#245'es Tributarias'
  ExplicitWidth = 1100
  ExplicitHeight = 208
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 138
    Width = 1094
    Height = 25
    TabOrder = 1
    ExplicitTop = 138
    ExplicitWidth = 1094
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 1090
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 1090
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        ExplicitWidth = 85
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        ExplicitLeft = 85
        ExplicitWidth = 85
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        ExplicitLeft = 170
        ExplicitWidth = 85
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        ExplicitLeft = 255
        ExplicitWidth = 85
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        ExplicitLeft = 340
        ExplicitWidth = 85
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        ExplicitLeft = 425
        ExplicitWidth = 85
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1014
      Height = 20
      Align = alRight
      ExplicitLeft = 1014
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 1094
    Height = 138
    Visible = False
    ExplicitWidth = 1094
    ExplicitHeight = 135
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1086
      ExplicitHeight = 103
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1094
    Height = 138
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 135
    object Label1: TLabel
      Left = 37
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 21
      Top = 41
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 24
      Top = 87
      Width = 231
      Height = 14
      Caption = 'CFOPs permitidas para Entrada de Mercadorias:'
    end
    object dbeCodTri: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TRI_CODTRI'
      DataSource = dtsCadTri
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
    object dbeDesc01: TDBEditFocus
      Tag = 99
      Left = 77
      Top = 37
      Width = 414
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TRI_DESC01'
      DataSource = dtsCadTri
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
    object dbeDesc02: TDBEditFocus
      Left = 77
      Top = 60
      Width = 414
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TRI_DESC02'
      DataSource = dtsCadTri
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
    object dbeCFOPSP: TDBEditFocus
      Tag = 99
      Left = 24
      Top = 102
      Width = 1057
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TRI_CFOPSP'
      DataSource = dtsCadTri
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 163
    Width = 1094
    TabOrder = 3
    ExplicitTop = 163
    ExplicitWidth = 1094
    inherited pnlNomeForm: TPanel
      Left = 907
      Width = 187
      ExplicitLeft = 907
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 907
      ExplicitWidth = 907
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 5
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 16
  end
  object dtsCadTri: TDataSource
    Left = 352
    Top = 5
  end
end
