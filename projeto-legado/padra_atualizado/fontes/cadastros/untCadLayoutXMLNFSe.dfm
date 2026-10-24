inherited frmCadLayoutXMLNFSe: TfrmCadLayoutXMLNFSe
  Left = 578
  Top = 392
  Width = 529
  Height = 198
  Caption = 'Cadastro de Campos Layout XML NFS-e'
  ExplicitWidth = 529
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 128
    Width = 523
    Height = 25
    ExplicitTop = 128
    ExplicitWidth = 523
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 519
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 519
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
      Left = 441
      Width = 73
      Height = 20
      ExplicitLeft = 441
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 153
    Width = 523
    ExplicitTop = 153
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 179
      ExplicitLeft = 344
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 344
      ExplicitWidth = 344
    end
  end
  inherited pgcDados: TPageControl
    Width = 523
    Height = 128
    ExplicitWidth = 523
    ExplicitHeight = 128
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 515
      ExplicitHeight = 96
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 128
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 41
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 57
      Top = 19
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 12
      Top = 61
      Width = 81
      Height = 14
      Caption = 'Campo Cad. Fis.:'
    end
    object Label4: TLabel
      Left = 17
      Top = 104
      Width = 76
      Height = 14
      Caption = 'Tipo  de campo:'
    end
    object Label5: TLabel
      Left = 37
      Top = 82
      Width = 56
      Height = 14
      Caption = 'Obrigat'#243'rio:'
    end
    object dbeDesCam: TDBEditFocus
      Tag = 99
      Left = 94
      Top = 36
      Width = 424
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LAY_DESCAM'
      DataSource = dtsLayCfs
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 120
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodLay: TDBEditFocus
      Tag = 99
      Left = 94
      Top = 15
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LAY_CODLAY'
      DataSource = dtsLayCfs
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeDesCfs: TDBEditFocus
      Tag = 99
      Left = 94
      Top = 57
      Width = 83
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LAY_DESCFS'
      DataSource = dtsLayCfs
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbxSimNao: TDBLookupComboBoxFocus
      Left = 94
      Top = 79
      Width = 145
      Height = 22
      DataField = 'LAY_OBRIGA'
      DataSource = dtsLayCfs
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbxTipoCampo: TDBLookupComboBoxFocus
      Left = 94
      Top = 101
      Width = 145
      Height = 22
      DataField = 'LAY_TIPCAM'
      DataSource = dtsLayCfs
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 308
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 16
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 8
  end
  object dtsLayCfs: TDataSource
    Left = 240
    Top = 20
  end
end
