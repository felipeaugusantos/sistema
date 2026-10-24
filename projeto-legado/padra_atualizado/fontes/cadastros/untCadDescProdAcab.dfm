inherited frmCadDescProdAcab: TfrmCadDescProdAcab
  Width = 585
  Height = 308
  Caption = 'Cadastro da Descri'#231#227'o do Produto Acabado'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 585
  ExplicitHeight = 308
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 235
    Width = 579
    ExplicitTop = 235
    ExplicitWidth = 579
    DesignSize = (
      579
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 575
    end
    inherited btnSair: TBitBtnLocked
      Left = 496
      TabOrder = 2
      ExplicitLeft = 496
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 101
      Height = 21
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 579
    Height = 235
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 263
      Top = 1
      Height = 233
      ExplicitLeft = 184
      ExplicitTop = 152
      ExplicitHeight = 100
    end
    object Splitter2: TSplitter
      Left = 313
      Top = 1
      Height = 233
      Align = alRight
      ExplicitLeft = 272
      ExplicitTop = 128
      ExplicitHeight = 100
    end
    object pnlEsquerda: TPanel
      Left = 1
      Top = 1
      Width = 262
      Height = 233
      Align = alLeft
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object pnlLegEsq: TPanel
        Left = 1
        Top = 194
        Width = 260
        Height = 38
        Align = alBottom
        BevelInner = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 3
          Width = 140
          Height = 15
          Caption = 'F1 - Move para Cima (Up)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 16
          Top = 20
          Width = 160
          Height = 15
          Caption = 'F2 - Move para Baixo (Down)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object dbgEsquerda: TcxGrid
        Left = 1
        Top = 1
        Width = 260
        Height = 193
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgEsquerdaDBTableView1: TcxGridDBTableView
          OnKeyDown = dbgEsquerdaDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsEsquerda
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object dbgEsquerdaDBTableView1DescricaoCampo: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DescricaoCampo'
            Width = 250
          end
          object dbgEsquerdaDBTableView1TabelaCampo: TcxGridDBColumn
            DataBinding.FieldName = 'TabelaCampo'
            Visible = False
          end
          object dbgEsquerdaDBTableView1Sequencia: TcxGridDBColumn
            DataBinding.FieldName = 'Sequencia'
            Visible = False
          end
        end
        object dbgEsquerdaLevel1: TcxGridLevel
          GridView = dbgEsquerdaDBTableView1
        end
      end
    end
    object pnlCentro: TPanel
      Left = 266
      Top = 1
      Width = 47
      Height = 233
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object btnAddUm: TSpeedButton
        Left = 8
        Top = 66
        Width = 30
        Height = 25
        Caption = '>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAddUmClick
      end
      object btnAddTodos: TSpeedButton
        Left = 8
        Top = 90
        Width = 30
        Height = 25
        Caption = '>>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnAddTodosClick
      end
      object btnDelTodos: TSpeedButton
        Left = 8
        Top = 114
        Width = 30
        Height = 25
        Caption = '<<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnDelTodosClick
      end
      object btnDelUma: TSpeedButton
        Left = 8
        Top = 138
        Width = 30
        Height = 25
        Caption = '<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnDelUmaClick
      end
    end
    object pnlDireita: TPanel
      Left = 316
      Top = 1
      Width = 262
      Height = 233
      Align = alRight
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object dbgDireita: TcxGrid
        Left = 1
        Top = 1
        Width = 260
        Height = 231
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgDireitaDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDireita
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum registro para exibi'#231#227'o>'
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          object dbgDireitaDBTableView1DescricaoCampo: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DescricaoCampo'
            Width = 250
          end
          object dbgDireitaDBTableView1TabelaCampo: TcxGridDBColumn
            DataBinding.FieldName = 'TabelaCampo'
            Visible = False
          end
        end
        object dbgDireitaLevel1: TcxGridLevel
          GridView = dbgDireitaDBTableView1
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 263
    Width = 579
    ExplicitTop = 263
    ExplicitWidth = 579
    inherited pnlNomeForm: TPanel
      Left = 408
      ExplicitLeft = 408
    end
    inherited pnlInfo: TPanel
      Width = 408
      ExplicitWidth = 408
    end
  end
  object dtsEsquerda: TDataSource
    DataSet = cdsEsquerda
    Left = 96
    Top = 32
  end
  object dtsDireita: TDataSource
    DataSet = cdsDireita
    Left = 400
    Top = 40
  end
  object cdsEsquerda: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 32
    object cdsEsquerdaDescricaoCampo: TStringField
      FieldName = 'DescricaoCampo'
      Size = 50
    end
    object cdsEsquerdaTabelaCampo: TStringField
      FieldName = 'TabelaCampo'
      Size = 17
    end
    object cdsEsquerdaSequencia: TIntegerField
      FieldName = 'Sequencia'
    end
  end
  object cdsDireita: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 40
    object cdsDireitaDescricaoCampo: TStringField
      FieldName = 'DescricaoCampo'
      Size = 50
    end
    object cdsDireitaTabelaCampo: TStringField
      FieldName = 'TabelaCampo'
      Size = 17
    end
  end
end
