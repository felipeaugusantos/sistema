inherited frmCadDescricaoOcorrenciasGia: TfrmCadDescricaoOcorrenciasGia
  Width = 585
  Height = 142
  Caption = 'Cadastro de Descri'#231#227'o de ocorr'#234'ncias GIA'
  ExplicitWidth = 585
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 579
    ExplicitTop = 90
    ExplicitWidth = 579
    inherited FlwBotoes: TFlowPanel
      Width = 575
      ExplicitTop = 2
      ExplicitWidth = 575
    end
    inherited btnSair: TBitBtnLocked
      Left = 496
      ExplicitLeft = 496
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 579
    ExplicitTop = 118
    ExplicitWidth = 579
    inherited pnlNomeForm: TPanel
      Left = 232
      ExplicitLeft = 232
    end
    inherited pnlInfo: TPanel
      Width = 232
      ExplicitWidth = 232
    end
  end
  inherited pgcDados: TPageControl
    Width = 579
    Height = 69
    ActivePage = nil
    ExplicitWidth = 579
    ExplicitHeight = 90
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 571
      ExplicitHeight = 80
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 579
    Height = 69
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 571
    ExplicitHeight = 58
    object Label1: TLabel
      Left = 13
      Top = 11
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object dbeDescricaoOcorrencia: TDBEditFocus
      Left = 13
      Top = 26
      Width = 497
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DOC_DESDOC'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
  end
  object dtsTabela: TDataSource
    Left = 544
    Top = 2
  end
end
