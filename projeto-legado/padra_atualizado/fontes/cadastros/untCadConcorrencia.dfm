inherited frmCadConcorrencia: TfrmCadConcorrencia
  Width = 523
  Height = 148
  Caption = 'Cadastro de Concorr'#234'ncia'
  ExplicitWidth = 523
  ExplicitHeight = 148
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 75
    Width = 517
    ExplicitTop = 75
    ExplicitWidth = 517
    inherited FlwBotoes: TFlowPanel
      Width = 513
      ExplicitWidth = 513
      inherited btnIncluir: TBitBtnLocked
        Width = 71
        Height = 22
        Align = alLeft
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 71
        Width = 71
        Height = 22
        ExplicitLeft = 71
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 142
        Width = 71
        Height = 22
        ExplicitLeft = 142
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 213
        Width = 71
        Height = 22
        ExplicitLeft = 213
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 284
        Width = 71
        Height = 22
        ExplicitLeft = 284
        ExplicitWidth = 71
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 74
        Height = 22
        ExplicitLeft = 355
        ExplicitWidth = 74
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 431
      Width = 75
      ExplicitLeft = 431
      ExplicitWidth = 75
    end
  end
  inherited pgcDados: TPageControl
    Width = 517
    Height = 75
    ExplicitWidth = 517
    ExplicitHeight = 75
  end
  inherited pnlStatus: TPanel
    Top = 103
    Width = 517
    ExplicitTop = 103
    ExplicitWidth = 517
    inherited pnlNomeForm: TPanel
      Left = 170
      ExplicitLeft = 170
    end
    inherited pnlInfo: TPanel
      Width = 170
      ExplicitWidth = 170
    end
  end
  object pnlGeral: TPanel [4]
    Left = 0
    Top = 0
    Width = 517
    Height = 75
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lblCodConcorrencia: TLabel
      Left = 24
      Top = 22
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDesConcorrencia: TLabel
      Left = 8
      Top = 45
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object edtCodConcorrencia: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 18
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNR_CODCON'
      DataSource = dtsConcorrencia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesConcorrencia: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 41
      Width = 443
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNR_DESCON'
      DataSource = dtsConcorrencia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 70
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
    Left = 384
    Top = 8
  end
  object dtsConcorrencia: TDataSource
    Left = 192
    Top = 8
  end
end
