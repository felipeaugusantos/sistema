inherited frmCadPagBosch: TfrmCadPagBosch
  Width = 558
  Height = 193
  Caption = 'Tabela de Condi'#231#227'o de Pagamento Bosch'
  ExplicitWidth = 558
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 123
    Width = 552
    Height = 25
    ExplicitTop = 123
    ExplicitWidth = 552
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 478
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 548
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 480
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 479
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 552
    Height = 123
    ExplicitWidth = 552
    ExplicitHeight = 123
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 544
      ExplicitHeight = 91
    end
  end
  inherited pnlStatus: TPanel
    Top = 148
    Width = 552
    ExplicitTop = 148
    ExplicitWidth = 552
    inherited pnlNomeForm: TPanel
      Left = 338
      Width = 214
      ExplicitLeft = 338
      ExplicitWidth = 214
    end
    inherited pnlInfo: TPanel
      Width = 338
      ExplicitWidth = 338
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 552
    Height = 123
    Align = alClient
    TabOrder = 4
    object Label1: TLabel
      Left = 4
      Top = 4
      Width = 72
      Height = 14
      Caption = 'C'#243'digo BOSCH'
    end
    object Label2: TLabel
      Left = 4
      Top = 39
      Width = 202
      Height = 14
      Caption = 'Descri'#231#227'o Condi'#231#227'o de Pagamento Bosch'
    end
    object Label3: TLabel
      Left = 4
      Top = 74
      Width = 207
      Height = 14
      Caption = 'Condi'#231#227'o De Pagamento Referente Autcom'
    end
    object dbeCODCND: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 17
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CND_CODCND'
      DataSource = dtsDados
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDESCRI: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 52
      Width = 215
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CND_DESCRI'
      DataSource = dtsDados
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 4
      Top = 88
      Width = 538
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 2
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 72
  end
  object dtsDados: TDataSource
    Left = 232
  end
end
