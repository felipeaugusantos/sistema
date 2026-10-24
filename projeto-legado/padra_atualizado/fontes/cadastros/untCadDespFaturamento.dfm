inherited frmCadDespFaturamento: TfrmCadDespFaturamento
  Height = 166
  Caption = 'Cadastro de Despesas para Faturamento'
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 97
    Height = 25
    ExplicitTop = 97
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Height = 21
      ExplicitTop = 2
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        ExplicitLeft = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 74
        ExplicitLeft = 146
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 220
        Width = 74
        ExplicitLeft = 220
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 294
        Width = 74
        ExplicitLeft = 294
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 368
        Width = 74
        ExplicitLeft = 368
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 499
      Height = 20
      ExplicitLeft = 499
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 97
    ExplicitHeight = 97
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 65
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 97
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 32
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 16
      Top = 41
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 40
      Top = 64
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 37
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DES_DESCRI'
      DataSource = dtsCadDes
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DES_CODIGO'
      DataSource = dtsCadDes
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeValDes: TDBEditFocus
      Tag = 99
      Left = 71
      Top = 60
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DES_VALDES'
      DataSource = dtsCadDes
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 122
    ExplicitTop = 122
    inherited pnlNomeForm: TPanel
      Left = 399
      Width = 186
      ExplicitLeft = 399
      ExplicitWidth = 186
    end
    inherited pnlInfo: TPanel
      Width = 399
      ExplicitWidth = 399
    end
  end
  object dtsCadDes: TDataSource
    Left = 344
  end
end
