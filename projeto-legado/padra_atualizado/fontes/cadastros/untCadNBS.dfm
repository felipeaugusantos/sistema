inherited frmCadNBS: TfrmCadNBS
  Width = 539
  Height = 237
  Caption = 'Cadastro de Nomenclatura Brasileira de Servi'#231'os'
  ExplicitWidth = 539
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 164
    Width = 533
    ExplicitTop = 164
    ExplicitWidth = 533
    inherited FlwBotoes: TFlowPanel
      Width = 529
      ExplicitTop = 2
      ExplicitWidth = 529
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
        Width = 76
        Height = 22
        ExplicitWidth = 76
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 364
        Width = 82
        Height = 22
        ExplicitLeft = 364
        ExplicitWidth = 82
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 452
      ExplicitLeft = 452
    end
  end
  inherited pnlStatus: TPanel
    Top = 192
    Width = 533
    ExplicitTop = 192
    ExplicitWidth = 533
    inherited pnlNomeForm: TPanel
      Left = 186
      ExplicitLeft = 186
    end
    inherited pnlInfo: TPanel
      Width = 186
      ExplicitWidth = 186
    end
  end
  inherited pgcDados: TPageControl
    Left = 596
    Top = 176
    Width = 65
    Height = 25
    Align = alNone
    ExplicitLeft = 596
    ExplicitTop = 176
    ExplicitWidth = 65
    ExplicitHeight = 25
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 57
      ExplicitHeight = 15
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 164
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
    object dbeCodNBS: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 30
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NBS_CODIGO'
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
      Width = 500
      Height = 60
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataField = 'NBS_DESCRI'
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
