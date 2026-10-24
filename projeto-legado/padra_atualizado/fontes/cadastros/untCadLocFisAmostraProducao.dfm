inherited frmCadLocFisAmostraProducao: TfrmCadLocFisAmostraProducao
  Width = 528
  Height = 144
  Caption = 'Cadastro de localiza'#231#227'o f'#237'sica de amostras de produ'#231#227'o'
  ExplicitWidth = 528
  ExplicitHeight = 144
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 522
    Height = 25
    ExplicitTop = 74
    ExplicitWidth = 522
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 518
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 518
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
        ExplicitLeft = 296
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 368
        Width = 76
        ExplicitLeft = 368
        ExplicitWidth = 76
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 447
      Width = 66
      Height = 20
      ExplicitLeft = 447
      ExplicitWidth = 66
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Left = 663
    Top = 224
    Width = 66
    Height = 33
    Align = alNone
    ExplicitLeft = 663
    ExplicitTop = 224
    ExplicitWidth = 66
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 58
      ExplicitHeight = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 99
    Width = 522
    ExplicitTop = 99
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 302
      Width = 220
      ExplicitLeft = 302
      ExplicitWidth = 220
    end
    inherited pnlInfo: TPanel
      Width = 302
      ExplicitWidth = 302
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 522
    Height = 74
    Align = alClient
    TabOrder = 4
    ExplicitHeight = 71
    object Label2: TLabel
      Left = 48
      Top = 36
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 33
      Width = 381
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOP_DESCRI'
      DataSource = dtsLocOrP
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLocFis: TDBEditFocus
      Tag = 99
      Left = 106
      Top = 10
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOP_LOCFIS'
      DataSource = dtsLocOrP
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 8
  end
  object dtsLocOrP: TDataSource
    Left = 440
  end
end
