inherited frmCadFeriado: TfrmCadFeriado
  Left = 251
  Top = 310
  Width = 636
  Height = 150
  Caption = 'Cadastro de Feriados'
  ExplicitWidth = 636
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 80
    Width = 630
    Height = 25
    ExplicitTop = 80
    ExplicitWidth = 630
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 555
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 555
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      object btnHeranca: TBitBtnLocked
        Left = 434
        Top = 0
        Width = 111
        Height = 20
        Caption = '&Heran'#231'a de Feriados'
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 557
      Width = 71
      Height = 21
      Align = alRight
      ExplicitLeft = 557
      ExplicitWidth = 71
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 105
    Width = 630
    ExplicitTop = 105
    ExplicitWidth = 630
    inherited pnlNomeForm: TPanel
      Left = 438
      Width = 192
      ExplicitLeft = 438
      ExplicitWidth = 192
    end
    inherited pnlInfo: TPanel
      Width = 438
      ExplicitWidth = 438
    end
  end
  inherited pgcDados: TPageControl
    Width = 630
    Height = 80
    ExplicitWidth = 630
    ExplicitHeight = 80
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 622
      ExplicitHeight = 48
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 630
    Height = 80
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 42
      Top = 20
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object Label4: TLabel
      Left = 15
      Top = 43
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeDtaFer: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 16
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FER_DTAFER'
      DataSource = dtsCadFer
      TabOrder = 0
      OnExit = dbeDtaFerExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 39
      Width = 547
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FER_DESCRI'
      DataSource = dtsCadFer
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
    Left = 392
    Top = 3
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 3
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 0
  end
  object dtsCadFer: TDataSource
    OnDataChange = dtsCadFerDataChange
    Left = 360
    Top = 3
  end
end
