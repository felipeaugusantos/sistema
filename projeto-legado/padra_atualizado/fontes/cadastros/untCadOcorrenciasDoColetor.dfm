inherited frmCadOcorrenciasDoColetor: TfrmCadOcorrenciasDoColetor
  Width = 596
  Height = 201
  Caption = 'Cadastro de Ocorr'#234'ncias do Coletor'
  ExplicitWidth = 596
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 128
    Width = 590
    TabOrder = 3
    ExplicitTop = 128
    ExplicitWidth = 590
    inherited FlwBotoes: TFlowPanel
      Width = 514
      ExplicitTop = 2
      ExplicitWidth = 586
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        Height = 22
        ExplicitWidth = 82
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Height = 22
        ExplicitLeft = 82
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 154
        Height = 22
        ExplicitLeft = 154
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 226
        Width = 82
        Height = 22
        ExplicitLeft = 226
        ExplicitWidth = 82
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 308
        Width = 84
        Height = 22
        ExplicitLeft = 308
        ExplicitWidth = 84
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 392
        Width = 84
        Height = 22
        ExplicitLeft = 392
        ExplicitWidth = 84
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 516
      Width = 72
      Height = 24
      Align = alRight
      ExplicitWidth = 72
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 156
    Width = 590
    TabOrder = 0
    ExplicitTop = 156
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 243
      ExplicitLeft = 243
    end
    inherited pnlInfo: TPanel
      Width = 243
      ExplicitWidth = 243
    end
  end
  inherited pgcDados: TPageControl
    Width = 590
    Height = 128
    ActivePage = nil
    TabOrder = 1
    ExplicitWidth = 590
    ExplicitHeight = 128
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 582
      ExplicitHeight = 118
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 590
    Height = 128
    Align = alClient
    TabOrder = 2
    object lblCODIGO: TLabel
      Left = 53
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDESCRI: TLabel
      Left = 37
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 13
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCC_CODIGO'
      DataSource = dtsCadOcc
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 36
      Width = 413
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCC_DESCRI'
      DataSource = dtsCadOcc
      MaxLength = 100
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object rdgTipoOperacao: TDBRadioGroup
      Left = 37
      Top = 64
      Width = 146
      Height = 45
      Caption = ' Tipo de opera'#231#227'o: '
      DataField = 'OCC_TIPOCO'
      DataSource = dtsCadOcc
      Items.Strings = (
        'Confer'#234'ncia de Sa'#237'da')
      ReadOnly = True
      TabOrder = 0
      Values.Strings = (
        'CN')
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 544
    Top = 0
  end
  object dtsCadOcc: TDataSource
    Left = 400
  end
end
