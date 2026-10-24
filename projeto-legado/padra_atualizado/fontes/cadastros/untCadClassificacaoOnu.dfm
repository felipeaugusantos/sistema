inherited frmCadClassificacaoOnu: TfrmCadClassificacaoOnu
  Width = 530
  Height = 158
  Caption = 'Cadastro de Classifica'#231#227'o ONU'
  ExplicitWidth = 530
  ExplicitHeight = 158
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 88
    Width = 524
    Height = 25
    ExplicitTop = 88
    ExplicitWidth = 524
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 460
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 520
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        Height = 21
        ExplicitWidth = 73
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 74
        Height = 21
        ExplicitLeft = 73
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 147
        Width = 74
        Height = 21
        ExplicitLeft = 147
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 221
        Width = 74
        Height = 21
        ExplicitLeft = 221
        ExplicitWidth = 74
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 295
        Width = 75
        Height = 21
        ExplicitLeft = 295
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 78
        Height = 21
        ExplicitLeft = 370
        ExplicitWidth = 78
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 462
      Width = 60
      Height = 21
      Align = alRight
      ExplicitLeft = 455
      ExplicitWidth = 60
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 502
    Top = 178
    Width = 80
    Height = 39
    Align = alNone
    ExplicitLeft = 502
    ExplicitTop = 178
    ExplicitWidth = 80
    ExplicitHeight = 39
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 72
      ExplicitHeight = 7
    end
  end
  object pnlCadastro: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 88
    Align = alClient
    ParentColor = True
    TabOrder = 3
    ExplicitLeft = 149
    ExplicitTop = 64
    object Label1: TLabel
      Left = 47
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDesOnu: TLabel
      Left = 6
      Top = 35
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o ONU:'
    end
    object Label2: TLabel
      Left = 22
      Top = 59
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo ONU:'
    end
    object Label3: TLabel
      Left = 179
      Top = 59
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classe de Risco:'
    end
    object Label4: TLabel
      Left = 355
      Top = 59
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Embal.:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ONU_CODONU'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesOnu: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 32
      Width = 426
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ONU_DESCRI'
      DataSource = dtsTabela
      MaxLength = 100
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodOnu: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 56
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ONU_CODIGO'
      DataSource = dtsTabela
      MaxLength = 4
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeClaRis: TDBEditFocus
      Tag = 99
      Left = 264
      Top = 56
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ONU_CLARIS'
      DataSource = dtsTabela
      MaxLength = 4
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeGruEmb: TDBEditFocus
      Tag = 99
      Left = 426
      Top = 56
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ONU_GRUEMB'
      DataSource = dtsTabela
      MaxLength = 4
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 113
    Width = 524
    ExplicitTop = 113
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 180
      ExplicitLeft = 344
      ExplicitWidth = 180
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  object dtsTabela: TDataSource
    Left = 376
    Top = 8
  end
end
