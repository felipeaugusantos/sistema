inherited frmCadCna: TfrmCadCna
  Width = 550
  Height = 160
  Caption = 
    'Cadastro de Classifica'#231#227'o Nacional de Atividades Econ'#244'micas (CNA' +
    'E)'
  ExplicitWidth = 550
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 90
    Width = 544
    Height = 25
    ExplicitTop = 90
    ExplicitWidth = 544
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 465
      Height = 21
      ExplicitWidth = 540
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 75
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 150
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 225
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 300
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        Height = 21
        Spacing = 2
        ExplicitLeft = 375
        ExplicitWidth = 75
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      Width = 75
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 466
      ExplicitWidth = 75
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 544
    Height = 90
    ExplicitWidth = 544
    ExplicitHeight = 87
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 544
    ExplicitTop = 115
    ExplicitWidth = 544
    inherited pnlNomeForm: TPanel
      Left = 197
      ExplicitLeft = 197
    end
    inherited pnlInfo: TPanel
      Width = 197
      ExplicitWidth = 197
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 544
    Height = 90
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    ExplicitHeight = 87
    object Label1: TLabel
      Left = 28
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 34
      Top = 36
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 41
      Top = 60
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object dbeCodCna: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 8
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNA_CODCNA'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNomCna: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 32
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CNA_NOMCNA'
      DataSource = dtsTabela
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object lkbTipo: TDBLookupComboBoxFocus
      Tag = 99
      Left = 66
      Top = 56
      Width = 150
      Height = 22
      DataField = 'CNA_TIPCNA'
      DataSource = dtsTabela
      KeyField = 'SIGLA'
      ListField = 'DESCRICAO'
      ListSource = dtsTipoCnae
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 4
  end
  object dtsTabela: TDataSource
    Left = 336
    Top = 4
  end
  object cdsTipoCnae: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'SIGLA'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 244
    Top = 4
  end
  object dtsTipoCnae: TDataSource
    DataSet = cdsTipoCnae
    Left = 280
    Top = 4
  end
end
