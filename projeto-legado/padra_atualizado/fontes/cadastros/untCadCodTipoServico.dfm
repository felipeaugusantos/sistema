inherited frmCadCodTipoServico: TfrmCadCodTipoServico
  Width = 630
  Height = 201
  Caption = 'Cadastro C'#243'digo do Servi'#231'o '#8211' Anexo I da L.C. Federal N'#186' 116/03'
  ExplicitWidth = 630
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 131
    Width = 624
    Height = 25
    ExplicitTop = 131
    ExplicitWidth = 624
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 620
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 620
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
      Left = 545
      Width = 70
      Height = 20
      ExplicitLeft = 545
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 156
    Width = 624
    ExplicitTop = 156
    ExplicitWidth = 624
    inherited pnlNomeForm: TPanel
      Left = 277
      ExplicitLeft = 277
    end
    inherited pnlInfo: TPanel
      Width = 277
      ExplicitWidth = 277
    end
  end
  inherited pgcDados: TPageControl
    Width = 519
    Height = 0
    Align = alNone
    ExplicitWidth = 519
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 511
      ExplicitHeight = 226
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 624
    Height = 131
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 11
      Top = 37
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 26
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeCdServ: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CDS_CDSERV'
      DataSource = dtsCadCDS
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbedescri: TDBMemoFocus
      Tag = 99
      Left = 65
      Top = 37
      Width = 550
      Height = 83
      DataField = 'CDS_DESCRI'
      DataSource = dtsCadCDS
      ScrollBars = ssVertical
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 0
  end
  object dtsCadCDS: TDataSource
    Left = 344
  end
end
