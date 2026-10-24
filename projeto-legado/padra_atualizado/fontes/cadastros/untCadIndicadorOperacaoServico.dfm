inherited frmCadIndicadorOperacaoServico: TfrmCadIndicadorOperacaoServico
  Width = 543
  Height = 231
  Caption = 'Cadastro de Indicador de Opera'#231#245'es Comuns de Servi'#231'o'
  ExplicitWidth = 543
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 158
    Width = 537
    ExplicitTop = 158
    ExplicitWidth = 537
    inherited FlwBotoes: TFlowPanel
      Width = 533
      ExplicitTop = 2
      ExplicitWidth = 533
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 89
        Height = 22
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      ExplicitLeft = 456
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    Width = 537
    ExplicitTop = 186
    ExplicitWidth = 537
    inherited pnlNomeForm: TPanel
      Left = 190
      ExplicitLeft = 190
    end
    inherited pnlInfo: TPanel
      Width = 190
      ExplicitWidth = 190
    end
  end
  inherited pgcDados: TPageControl
    Left = 585
    Top = 258
    Width = 2
    Height = 0
    Align = alNone
    ExplicitLeft = 585
    ExplicitTop = 258
    ExplicitWidth = 2
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 537
    Height = 158
    Align = alClient
    TabOrder = 3
    object Label2: TLabel
      Left = 12
      Top = 13
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 12
      Top = 63
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 30
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      DataField = 'IOP_CODIGO'
      DataSource = dtsDados
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object dbeDescr: TDBMemoFocus
      Tag = 99
      Left = 12
      Top = 81
      Width = 509
      Height = 60
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'IOP_DESCRI'
      DataSource = dtsDados
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object dtsDados: TDataSource
    OnDataChange = dtsDadosDataChange
    Left = 80
    Top = 88
  end
end
