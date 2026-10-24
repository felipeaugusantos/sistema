inherited frmCadEquipamentosInd: TfrmCadEquipamentosInd
  Width = 525
  Height = 155
  Caption = 'Cadastro de Equipamentos'
  ExplicitWidth = 525
  ExplicitHeight = 155
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 85
    Width = 519
    Height = 25
    TabOrder = 1
    ExplicitTop = 85
    ExplicitWidth = 519
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 515
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 515
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      Width = 70
      Height = 20
      ExplicitLeft = 440
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 85
    TabOrder = 3
    ExplicitWidth = 519
    ExplicitHeight = 85
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 53
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 519
    Height = 85
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 30
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 14
      Top = 33
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 6
      Top = 56
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Capacidade:'
    end
    object Label4: TLabel
      Left = 163
      Top = 56
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Custo / hora:'
    end
    object dbeCodEqp: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 6
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQP_CODEQP'
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
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 29
      Width = 442
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQP_DESCRI'
      DataSource = dtsTabela
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
    object dbeCapaci: TDBEditFocus
      Tag = 99
      Left = 68
      Top = 52
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQP_CAPACI'
      DataSource = dtsTabela
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
    object dbeCusHor: TDBEditFocus
      Tag = 99
      Left = 229
      Top = 52
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EQP_CUSHOR'
      DataSource = dtsTabela
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
    Top = 110
    Width = 519
    TabOrder = 2
    ExplicitTop = 110
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 191
      ExplicitLeft = 328
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 345
  end
end
