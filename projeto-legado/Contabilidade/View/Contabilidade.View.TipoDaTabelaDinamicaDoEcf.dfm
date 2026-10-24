inherited frmTipoDaTabelaDinamicaDoEcf: TfrmTipoDaTabelaDinamicaDoEcf
  Width = 539
  Height = 142
  Caption = 'Tipo da Tabela Din'#226'mica do ECF'
  ExplicitWidth = 539
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 533
    ExplicitTop = 69
    ExplicitWidth = 533
    inherited FlwBotoes: TFlowPanel
      Width = 529
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      ExplicitLeft = 450
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 533
    ExplicitTop = 97
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
    Width = 533
    Height = 69
    TabOrder = 3
    ExplicitWidth = 533
    ExplicitHeight = 69
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 525
      ExplicitHeight = 37
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 533
    Height = 69
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 11
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 31
      Top = 18
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 36
      Width = 457
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ECF_DESCRI'
      DataSource = dtsTabEcf
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 65
      Top = 11
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ECF_CODIGO'
      DataSource = dtsTabEcf
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
  end
  object dtsTabEcf: TDataSource
    Left = 256
    Top = 16
  end
end
