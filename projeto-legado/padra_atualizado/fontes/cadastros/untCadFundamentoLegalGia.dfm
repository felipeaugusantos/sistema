inherited frmCadFundamentoLegalGia: TfrmCadFundamentoLegalGia
  Width = 531
  Height = 142
  Caption = 'Cadastro de Fundamento legal GIA'
  ExplicitWidth = 531
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 525
    ExplicitTop = 88
    ExplicitWidth = 525
    inherited FlwBotoes: TFlowPanel
      Width = 521
      ExplicitTop = 2
      ExplicitWidth = 521
    end
    inherited btnSair: TBitBtnLocked
      Left = 442
      ExplicitLeft = 442
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 525
    ExplicitTop = 116
    ExplicitWidth = 525
    inherited pnlNomeForm: TPanel
      Left = 178
      ExplicitLeft = 178
    end
    inherited pnlInfo: TPanel
      Width = 178
      ExplicitWidth = 178
    end
  end
  inherited pgcDados: TPageControl
    Width = 525
    Height = 69
    ActivePage = nil
    ExplicitWidth = 525
    ExplicitHeight = 88
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 517
      ExplicitHeight = 78
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 525
    Height = 69
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 517
    ExplicitHeight = 56
    object Label1: TLabel
      Left = 15
      Top = 12
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object dbeDescricaoFundamentoLegal: TDBEditFocus
      Left = 15
      Top = 27
      Width = 409
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FUL_DESFUL'
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
    Left = 896
  end
  object dtsTabela: TDataSource
    Left = 496
    Top = 2
  end
end
