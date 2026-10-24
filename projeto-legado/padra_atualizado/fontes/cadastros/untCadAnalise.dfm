inherited frmCadAnalise: TfrmCadAnalise
  Width = 596
  Height = 246
  Caption = 'Cadastro de An'#225'lises'
  ExplicitWidth = 596
  ExplicitHeight = 246
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 176
    Width = 590
    Height = 25
    ExplicitTop = 417
    ExplicitWidth = 590
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 586
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 586
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 506
      Width = 75
      Height = 20
      ExplicitLeft = 506
      ExplicitWidth = 75
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 201
    Width = 590
    ExplicitTop = 442
    ExplicitWidth = 590
    inherited pnlNomeForm: TPanel
      Left = 243
      ExplicitLeft = 243
    end
    inherited pnlInfo: TPanel
      Width = 243
      ExplicitWidth = 243
    end
  end
  inherited pgcDados: TPageControl
    Width = 590
    Height = 176
    ExplicitWidth = 590
    ExplicitHeight = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 582
      ExplicitHeight = 385
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 590
    Height = 176
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitHeight = 417
    object Label1: TLabel
      Left = 52
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 36
      Top = 33
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblPeriod: TLabel
      Left = 471
      Top = 148
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Periodicidade:'
    end
    object Label6: TLabel
      Left = 12
      Top = 148
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de An'#225'lise:'
    end
    object Label3: TLabel
      Left = 24
      Top = 56
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Amostragem:'
    end
    object Label4: TLabel
      Left = 23
      Top = 79
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Instrumentos:'
    end
    object Label5: TLabel
      Left = 52
      Top = 102
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desvio:'
    end
    object Label7: TLabel
      Left = 231
      Top = 148
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Resultado:'
    end
    object Label8: TLabel
      Left = 54
      Top = 125
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Norma:'
    end
    object dbeCodAna: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 6
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_CODANA'
      DataSource = dtsTabela
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
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 29
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_DESCRI'
      DataSource = dtsTabela
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
    object dbePeriod: TDBEditFocus
      Tag = 99
      Left = 541
      Top = 144
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_PERIOD'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbxTipAna: TComboBoxFocus
      Tag = 99
      Left = 90
      Top = 144
      Width = 112
      Height = 22
      Style = csDropDownList
      TabOrder = 6
      OnClick = cbxTipAnaClick
      Items.Strings = (
        'Aprova'#231#227'o'
        'Acompanhamento')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object DBEditFocus1: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 52
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_AMOSTR'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 75
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_INSTRU'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus3: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 98
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_DESVIO'
      DataSource = dtsTabela
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTipRes: TDBComboBoxFocus
      Tag = 99
      Left = 323
      Top = 144
      Width = 119
      Height = 22
      Style = csDropDownList
      DataField = 'ANA_TIPRES'
      DataSource = dtsTabela
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object DBEditFocus4: TDBEditFocus
      Tag = 99
      Left = 90
      Top = 121
      Width = 490
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ANA_NORMA_'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 8
  end
  object dtsTabela: TDataSource
    Left = 345
  end
end
