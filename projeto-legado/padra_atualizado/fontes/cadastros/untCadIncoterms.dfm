inherited frmCadIncoterms: TfrmCadIncoterms
  Width = 535
  Height = 414
  Caption = 'Cadastro de Termos Internacionais de Com'#233'rcio'
  OnKeyUp = FormKeyUp
  ExplicitWidth = 535
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 30
    Top = 23
    Width = 36
    Height = 14
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 40
    Top = 51
    Width = 26
    Height = 14
    Caption = 'Sigla:'
  end
  object Label3: TLabel [2]
    Left = 14
    Top = 79
    Width = 52
    Height = 14
    Caption = 'Descri'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 529
    ExplicitTop = 341
    ExplicitWidth = 529
    inherited FlwBotoes: TFlowPanel
      Width = 525
      ExplicitTop = 2
      ExplicitWidth = 525
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 80
        Height = 22
        ExplicitWidth = 80
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 445
      ExplicitLeft = 445
    end
  end
  inherited pnlStatus: TPanel
    Top = 369
    Width = 529
    ExplicitTop = 369
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 368
      Width = 161
      ExplicitLeft = 368
      ExplicitWidth = 161
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
    end
  end
  inherited pgcDados: TPageControl
    Left = 537
    Top = 9
    Width = 105
    Height = 34
    Align = alNone
    Visible = False
    ExplicitLeft = 537
    ExplicitTop = 9
    ExplicitWidth = 105
    ExplicitHeight = 34
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 97
      ExplicitHeight = 2
    end
  end
  object dbeCodTerm: TDBEditFocus [6]
    Tag = 99
    Left = 70
    Top = 20
    Width = 76
    Height = 22
    DataField = 'ICT_CODICT'
    DataSource = dtsTabela
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeSigla: TDBEditFocus [7]
    Tag = 99
    Left = 70
    Top = 48
    Width = 76
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ICT_SIGLA_'
    DataSource = dtsTabela
    MaxLength = 3
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [8]
    Tag = 99
    Left = 70
    Top = 76
    Width = 443
    Height = 22
    CharCase = ecUpperCase
    DataField = 'ICT_DESCRI'
    DataSource = dtsTabela
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object rdgTipo: TDBRadioGroup [9]
    Left = 14
    Top = 103
    Width = 499
    Height = 48
    Caption = ' Tipo '
    Columns = 2
    DataField = 'ICT_TPTERM'
    DataSource = dtsTabela
    Items.Strings = (
      'Mar'#237'timo'
      'A'#233'reo')
    TabOrder = 6
    TabStop = True
    Values.Strings = (
      'M'
      'A')
    OnClick = rdgTipoClick
  end
  object rdgInvoice: TGroupBox [10]
    Left = 14
    Top = 157
    Width = 499
    Height = 97
    Caption = 'Impress'#227'o de Invoice'
    TabOrder = 7
    object chkTarifa: TDBCheckBox
      Tag = 99
      Left = 11
      Top = 29
      Width = 222
      Height = 16
      Caption = 'Tafira do Porto / Aeroporto de Embarque'
      DataField = 'ICT_TARIFA'
      DataSource = dtsTabela
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkSeguro: TDBCheckBox
      Tag = 99
      Left = 11
      Top = 51
      Width = 222
      Height = 16
      Caption = 'Seguro Mar'#237'timo Internacional'
      DataField = 'ICT_SEGURO'
      DataSource = dtsTabela
      TabOrder = 1
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkFrete: TDBCheckBox
      Tag = 99
      Left = 11
      Top = 73
      Width = 222
      Height = 16
      Caption = 'Frete do Oceano'
      DataField = 'ICT_FRETE_'
      DataSource = dtsTabela
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object rdgLeiaute: TGroupBox [11]
    Left = 14
    Top = 260
    Width = 499
    Height = 57
    Caption = 'Layout para Impress'#227'o do Invoice'
    TabOrder = 8
    object Label4: TLabel
      Left = 12
      Top = 23
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object dbeCodLay: TDBEditFocus
      Tag = 99
      Left = 54
      Top = 20
      Width = 47
      Height = 22
      DataField = 'ICT_LAYETI'
      DataSource = dtsTabela
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = dbeCodLayKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomLay: TEditFocus
      Left = 104
      Top = 20
      Width = 385
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 310
    Top = 10
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 278
    Top = 10
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 358
    Top = 10
  end
  object dtsTabela: TDataSource
    OnDataChange = dtsTabelaDataChange
    Left = 246
    Top = 10
  end
end
