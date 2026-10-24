inherited frmCadMotVendasPerdidas: TfrmCadMotVendasPerdidas
  Width = 524
  Height = 170
  Caption = 'Cadastro de Motivos de Vendas Perdidas'
  ExplicitWidth = 524
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 100
    Width = 518
    Height = 25
    ExplicitTop = 100
    ExplicitWidth = 518
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 514
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 514
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 436
      Width = 74
      Height = 20
      ParentFont = False
      ExplicitLeft = 436
      ExplicitWidth = 74
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 518
    Height = 100
    ExplicitWidth = 518
    ExplicitHeight = 100
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 510
      ExplicitHeight = 68
    end
  end
  object pnl1: TPanel [3]
    Left = 0
    Top = 0
    Width = 518
    Height = 100
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object lbl1: TLabel
      Left = 8
      Top = 45
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lbl2: TLabel
      Left = 24
      Top = 22
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeCodMot: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 18
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_CODMOT'
      DataSource = dtsCadMot
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
    object dbeDesMot: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 41
      Width = 445
      Height = 22
      CharCase = ecUpperCase
      DataField = 'MOT_DESMOT'
      DataSource = dtsCadMot
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
    object dbeConPed: TDBCheckBox
      Left = 64
      Top = 72
      Width = 193
      Height = 17
      Caption = 'Considerar para pedido de compra'
      DataField = 'MOT_CONPED'
      DataSource = dtsCadMot
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeInfCon: TDBCheckBox
      Left = 282
      Top = 72
      Width = 130
      Height = 17
      Caption = 'Informar Concorr'#234'ncia'
      DataField = 'MOT_INFCON'
      DataSource = dtsCadMot
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited pnlStatus: TPanel
    Top = 125
    Width = 518
    ExplicitTop = 125
    ExplicitWidth = 518
    inherited pnlNomeForm: TPanel
      Left = 328
      Width = 190
      ExplicitLeft = 328
      ExplicitWidth = 190
    end
    inherited pnlInfo: TPanel
      Width = 328
      ExplicitWidth = 328
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 344
    Top = 8
  end
  object dtsCadMot: TDataSource
    Left = 400
    Top = 7
  end
end
