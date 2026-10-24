inherited frmCadControleCreditoFiscais: TfrmCadControleCreditoFiscais
  Width = 708
  Height = 284
  Caption = 'Cadastro - Controle de Cr'#233'ditos Fiscais'
  ExplicitWidth = 708
  ExplicitHeight = 284
  PixelsPerInch = 96
  TextHeight = 14
  object Label40: TLabel [0]
    Left = 4
    Top = 4
    Width = 51
    Height = 14
    Caption = 'M'#234's / Ano:'
  end
  object Label1: TLabel [1]
    Left = 81
    Top = 4
    Width = 90
    Height = 14
    Caption = 'C'#243'd. Aj. Apur 1200'
  end
  object Label2: TLabel [2]
    Left = 269
    Top = 4
    Width = 53
    Height = 14
    Caption = 'Saldo.Cred'
  end
  object Label3: TLabel [3]
    Left = 353
    Top = 4
    Width = 80
    Height = 14
    Caption = 'Cred.Apropriado'
  end
  object Label4: TLabel [4]
    Left = 446
    Top = 4
    Width = 77
    Height = 14
    Caption = 'Cred.Recebidos'
  end
  object Label5: TLabel [5]
    Left = 540
    Top = 4
    Width = 72
    Height = 14
    Caption = 'Cred.Utilizados'
  end
  object Label6: TLabel [6]
    Left = 176
    Top = 4
    Width = 72
    Height = 14
    Caption = 'C'#243'd. Tipo 1210'
  end
  inherited pnlBotoes: TPanel
    Top = 213
    Width = 702
    Height = 26
    ExplicitTop = 213
    ExplicitWidth = 702
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 621
      Height = 22
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 22
        Spacing = 2
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 623
      Align = alRight
      ExplicitLeft = 626
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alCustom
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object edtdbeMesAno: TDBEditFocus [10]
    Tag = 99
    Left = 4
    Top = 18
    Width = 69
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_MESANO'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object edtdbeCodAjuAp: TDBEditFocus [11]
    Tag = 99
    Left = 81
    Top = 18
    Width = 81
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_CODAJU'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object edtdbeSalCred: TDBEditFocus [12]
    Tag = 99
    Left = 269
    Top = 18
    Width = 72
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_SLDCRE'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object edtdbeSalAp: TDBEditFocus [13]
    Tag = 99
    Left = 353
    Top = 18
    Width = 80
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_CREAPR'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object edtdbeCredRec: TDBEditFocus [14]
    Tag = 99
    Left = 446
    Top = 18
    Width = 80
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_CREREC'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object edtdbeCredUti: TDBEditFocus [15]
    Tag = 99
    Left = 540
    Top = 18
    Width = 80
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_CREUTI'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 9
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object dbgrControlCredFisc: TDBGridCitel [16]
    Left = 0
    Top = 48
    Width = 702
    Height = 165
    TabStop = False
    Align = alBottom
    DataSource = dtsControlCredFisc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgrControlCredFiscKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'COC_MESANO'
        Title.Caption = 'M'#234's / Ano'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COC_CODAJU'
        Title.Caption = 'C'#243'd. Aj. Apur 1200'
        Width = 102
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COC_TIPCRE'
        Title.Caption = 'C'#243'd. Tipo 1210'
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COC_SLDCRE'
        Title.Caption = 'Saldo.Cred'
        Width = 116
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'COC_CREAPR'
        Title.Caption = 'Cred.Apropriado'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COC_CREREC'
        Title.Caption = 'Cred.Recebidos'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COC_CREUTI'
        Title.Caption = 'Cred.Utilizados'
        Width = 100
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 239
    Width = 702
    ExplicitTop = 239
    ExplicitWidth = 702
    inherited pnlNomeForm: TPanel
      Left = 355
      ExplicitLeft = 355
    end
    inherited pnlInfo: TPanel
      Width = 355
      ExplicitWidth = 355
    end
  end
  object edtdbeTipCre: TDBEditFocus [18]
    Tag = 99
    Left = 176
    Top = 18
    Width = 81
    Height = 22
    CharCase = ecUpperCase
    DataField = 'COC_TIPCRE'
    DataSource = dtsControlCredFisc
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 4
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 672
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 640
    Top = 176
  end
  object dtsControlCredFisc: TDataSource
    OnStateChange = dtsControlCredFiscStateChange
    Left = 517
    Top = 175
  end
end
