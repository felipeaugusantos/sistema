inherited frmCadEtiquetaVolumeEtiquetaDespacho: TfrmCadEtiquetaVolumeEtiquetaDespacho
  Width = 667
  Height = 140
  Caption = 'Cadastro de esp'#233'cie de volumes  para etiqueta de despacho'
  ExplicitWidth = 667
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 67
    Width = 661
    TabOrder = 1
    ExplicitTop = 67
    ExplicitWidth = 661
    inherited FlwBotoes: TFlowPanel
      Width = 657
      ExplicitWidth = 657
    end
    inherited btnSair: TBitBtnLocked
      Left = 580
      ExplicitLeft = 580
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 661
    TabOrder = 2
    ExplicitTop = 95
    ExplicitWidth = 661
    inherited pnlNomeForm: TPanel
      Left = 314
      ExplicitLeft = 314
    end
    inherited pnlInfo: TPanel
      Width = 314
      ExplicitWidth = 314
    end
  end
  inherited pgcDados: TPageControl
    Width = 661
    Height = 67
    TabOrder = 3
    ExplicitWidth = 661
    ExplicitHeight = 67
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 653
      ExplicitHeight = 35
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 661
    Height = 67
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblDescricao: TLabel
      Left = 23
      Top = 28
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblSigla: TLabel
      Left = 479
      Top = 28
      Width = 26
      Height = 14
      Caption = 'Sigla:'
    end
    object edtDescricao: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 25
      Width = 384
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EED_DESCRI'
      DataSource = dtsEtiqueta
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtSigla: TDBEditFocus
      Tag = 99
      Left = 511
      Top = 25
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EED_SIGLA_'
      DataSource = dtsEtiqueta
      MaxLength = 10
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
    Top = 224
  end
  object dtsEtiqueta: TDataSource
    Left = 296
    Top = 16
  end
end
