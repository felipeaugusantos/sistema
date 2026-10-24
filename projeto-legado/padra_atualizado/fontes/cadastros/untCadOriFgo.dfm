inherited frmCadOriFgo: TfrmCadOriFgo
  Left = 292
  Top = 337
  Width = 599
  Height = 209
  Caption = 'Cadastro de Origem dos Pedidos de Venda'
  ExplicitWidth = 599
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 129
    Top = 15
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 113
    Top = 39
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object LabelCgc1: TLabelCgc [2]
    Left = 54
    Top = 63
    Width = 111
    Height = 14
    Alignment = taRightJustify
    Caption = 'CNPJ do Intermediador:'
    Pais = opcBrasil
  end
  object lblNomFan: TLabel [3]
    Left = 16
    Top = 87
    Width = 149
    Height = 14
    Alignment = taRightJustify
    Caption = 'Raz'#227'o Social do Intermediador:'
  end
  object Label29: TLabel [4]
    Left = 7
    Top = 111
    Width = 159
    Height = 14
    Alignment = taRightJustify
    Caption = 'Permite Cancelamento do Pedido:'
  end
  object ColorLabel4: TColorLabel [5]
    Left = 207
    Top = 110
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  inherited pnlBotoes: TPanel
    Top = 139
    Width = 593
    Height = 25
    ExplicitTop = 139
    ExplicitWidth = 570
    ExplicitHeight = 25
    DesignSize = (
      593
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 589
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 566
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        ExplicitLeft = 75
        ExplicitWidth = 75
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        ExplicitLeft = 150
        ExplicitWidth = 75
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        ExplicitLeft = 225
        ExplicitWidth = 75
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        ExplicitLeft = 300
        ExplicitWidth = 75
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        ExplicitLeft = 375
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 518
      Width = 72
      Height = 20
      ExplicitLeft = 495
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  object dbeCodOri: TDBEditFocus [7]
    Left = 169
    Top = 10
    Width = 121
    Height = 22
    TabStop = False
    CharCase = ecUpperCase
    DataField = 'ORI_CODORI'
    Enabled = False
    ReadOnly = True
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDesOri: TDBEditFocus [8]
    Tag = 99
    Left = 169
    Top = 34
    Width = 392
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ORI_DESORI'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeC_G_C_: TDBEditCgcCpf [9]
    Tag = 99
    Left = 169
    Top = 58
    Width = 187
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ORI_C_G_C_'
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
    Tipo = C_G_C_
  end
  object dbeIdenti: TDBEditFocus [10]
    Tag = 99
    Left = 169
    Top = 82
    Width = 392
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ORI_IDENTI'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeCanOri: TDBEditFocus [11]
    Tag = 99
    Left = 169
    Top = 106
    Width = 36
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ORI_CANORI'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfabetico
  end
  inherited pnlStatus: TPanel
    Top = 164
    Width = 593
    ExplicitTop = 164
    ExplicitWidth = 570
    inherited pnlNomeForm: TPanel
      Left = 394
      Width = 199
      ExplicitLeft = 371
      ExplicitWidth = 199
    end
    inherited pnlInfo: TPanel
      Width = 394
      ExplicitWidth = 371
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 384
    Top = 0
  end
end
