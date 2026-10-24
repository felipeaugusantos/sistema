inherited frmCadTiposProjeto: TfrmCadTiposProjeto
  Width = 592
  Height = 147
  Caption = 'Tipos de Projeto'
  ExplicitWidth = 592
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 586
    ExplicitTop = 74
    ExplicitWidth = 586
    inherited FlwBotoes: TFlowPanel
      Width = 582
      ExplicitTop = 2
      ExplicitWidth = 582
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 22
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 22
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 22
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 22
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 22
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 22
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 500
      Width = 78
      ExplicitLeft = 500
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 102
    Width = 586
    ExplicitTop = 102
    ExplicitWidth = 586
    inherited pnlNomeForm: TPanel
      Left = 399
      Width = 187
      ExplicitLeft = 399
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 399
      ExplicitWidth = 399
    end
  end
  inherited pgcDados: TPageControl
    Width = 586
    Height = 74
    Visible = False
    ExplicitWidth = 586
    ExplicitHeight = 74
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 578
      ExplicitHeight = 42
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 586
    Height = 74
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 37
      Top = 38
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object Label1: TLabel
      Left = 50
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeCodTip: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 11
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TIP_CODTIP'
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
    object dbeDesTip: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 34
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TIP_DESTIP'
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
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 528
    Top = 16
  end
  object dtsTabela: TDataSource
    Left = 408
    Top = 16
  end
end
