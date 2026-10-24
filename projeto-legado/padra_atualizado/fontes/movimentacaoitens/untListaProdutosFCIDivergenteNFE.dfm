inherited frmListaProdutosFCIDivergenteNFE: TfrmListaProdutosFCIDivergenteNFE
  Width = 1024
  Height = 769
  BorderStyle = bsSizeable
  Caption = 
    'Atualizar Cadastro de Produtos Com NCM Divergente do Informado n' +
    'a Nf-e'
  Padding.Right = 3
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 769
  PixelsPerInch = 96
  TextHeight = 14
  object cxGrid: TcxGrid [0]
    Left = 0
    Top = 0
    Width = 1005
    Height = 596
    Align = alClient
    TabOrder = 3
    LockedStateImageOptions.Text = 'Por favor, aguarde...'
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxbands: TcxGridDBBandedTableView
      OnKeyPress = cxbandsKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxbandsCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir.'
      OptionsView.GroupByHeaderLayout = ghlHorizontal
      Bands = <
        item
          Caption = 'Nota(s) e Produto(s)'
          Width = 273
        end
        item
          Caption = 'Ficha de Conte'#250'do de Importa'#231#227'o'
          Width = 327
        end
        item
          Caption = 'Porcentual (CI)'
        end
        item
          Caption = 'NCM'
          Width = 472
        end
        item
          Caption = 'CEST'
          Width = 415
        end
        item
          Caption = 'C'#243'digo de Barras'
          Width = 648
        end
        item
          Visible = False
          Width = 183
        end
        item
          Caption = 'Fornecedor & Abrevi'#231#227'o ICMS'
        end>
      object cxColNota: TcxGridDBBandedColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NUMNFE'
        GroupIndex = 0
        Options.Editing = False
        Width = 91
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColProduto: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUT'
        Options.Editing = False
        Width = 172
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColSERDOC: TcxGridDBBandedColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERDOC'
        GroupIndex = 1
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColAtuFci: TcxGridDBBandedColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'SELFCI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColAtuFciPropertiesChange
        Options.Filtering = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColFciNota: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o na Nota'
        DataBinding.FieldName = 'NUMFCI_NOTA'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColFciCadIte: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o no Cad. Produtos'
        DataBinding.FieldName = 'NUMFCI_PROD'
        OnCustomDrawCell = cxColFciCadIteCustomDrawCell
        Options.Editing = False
        Width = 153
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColAtuPCI: TcxGridDBBandedColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'SELPCI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColAtuPCIPropertiesChange
        Options.Filtering = False
        Width = 49
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColPCINota: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o na Nota'
        DataBinding.FieldName = 'PERFCI_NOTA'
        Options.Editing = False
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColPCICadIte: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o no Cad. Produtos'
        DataBinding.FieldName = 'PERFCI_PROD'
        OnCustomDrawCell = cxColPCICadIteCustomDrawCell
        Options.Editing = False
        Width = 146
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColAtuNCM: TcxGridDBBandedColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'SELCLAFIS'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColAtuNCMPropertiesChange
        Options.Filtering = False
        Width = 44
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColNCMNota: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o na Nota'
        DataBinding.FieldName = 'CLAIPI_NOTA'
        Options.Editing = False
        Width = 132
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColNCMCadIte: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o no Cad. Produtos'
        DataBinding.FieldName = 'CLAIPI_PROD'
        OnCustomDrawCell = cxColNCMCadIteCustomDrawCell
        Options.Editing = False
        Width = 184
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColAtuCEST: TcxGridDBBandedColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'SELCEST'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColCESTAtuPropertiesChange
        Options.Filtering = False
        Width = 62
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColCESTCadIte: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o no Cad. Produtos'
        DataBinding.FieldName = 'CDCEST_PROD'
        OnCustomDrawCell = cxColCESTCadIteCustomDrawCell
        Options.Editing = False
        Width = 140
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColCodBarProd: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de Barras No Cad. Produto'
        DataBinding.FieldName = 'CODBAR_PROD'
        OnCustomDrawCell = cxColNCMCadIteCustomDrawCell
        Options.Editing = False
        Width = 170
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColCodBarNota: TcxGridDBBandedColumn
        Caption = 'C'#243'digo de Barras da Nota'
        DataBinding.FieldName = 'CODBAR_NOTA'
        Options.Editing = False
        Width = 168
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColIncCodBar: TcxGridDBBandedColumn
        Caption = 'Incluir'
        DataBinding.FieldName = 'SELCODBAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColIncCodBarPropertiesChange
        Width = 45
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColBarPrinc: TcxGridDBBandedColumn
        Caption = 'Principal'
        DataBinding.FieldName = 'CODBAR_PRINC'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxColBarPrincPropertiesChange
        Width = 50
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxColPrincipalCompra: TcxGridDBBandedColumn
        Caption = 'Principal Compra'
        DataBinding.FieldName = 'CODBAR_PRINCOM'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 93
        Position.BandIndex = 5
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxColQtdEmb: TcxGridDBBandedColumn
        Caption = 'Qtd. Embalagem'
        DataBinding.FieldName = 'CODBAR_FATOR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0'
        Properties.OnChange = cxColQtdEmbPropertiesChange
        Width = 122
        Position.BandIndex = 5
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxbandsColumn1: TcxGridDBBandedColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColCODFOR: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        GroupIndex = 2
        Options.Editing = False
        Width = 98
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxColNOMFOR: TcxGridDBBandedColumn
        Caption = 'Nome Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        GroupIndex = 3
        Options.Editing = False
        Width = 250
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxColCODABF: TcxGridDBBandedColumn
        Caption = 'C'#243'digo Abrevia'#231#227'o ICMS'
        DataBinding.FieldName = 'CODABF'
        Options.Editing = False
        Width = 124
        Position.BandIndex = 7
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxColDESABF: TcxGridDBBandedColumn
        Caption = 'Abrevia'#231#227'o ICMS'
        DataBinding.FieldName = 'DESABF'
        Options.Editing = False
        Width = 196
        Position.BandIndex = 7
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxColCDCESTCADASTRADO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CDCEST_CADASTRADO'
        Visible = False
        VisibleForCustomization = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxColCDCESTVALIDO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'CDCEST_NCM_VALIDO'
        Visible = False
        VisibleForCustomization = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxColCESTNovo: TcxGridDBBandedColumn
        Caption = 'Informa'#231#227'o na Nota (Novo C'#243'digo CEST)'
        DataBinding.FieldName = 'CDCEST_NOVO'
        Options.Editing = False
        Width = 203
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxbands
    end
  end
  inherited pnlBotoes: TPanel
    Top = 671
    Width = 1005
    Height = 43
    ExplicitTop = 671
    ExplicitWidth = 1005
    ExplicitHeight = 43
    inherited FlwBotoes: TFlowPanel
      Width = 911
      Height = 39
      ExplicitWidth = 911
      ExplicitHeight = 39
      inherited btnConfirma: TBitBtnLocked
        Width = 73
        Height = 20
        Anchors = [akLeft]
        ExplicitWidth = 73
        ExplicitHeight = 20
      end
      object btnGeraCSV: TBitBtnLocked
        Tag = 1
        Left = 73
        Top = 0
        Width = 106
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F11 ] Exportar CSV'
        TabOrder = 1
        OnClick = btnGeraCSVClick
      end
      object btnMarcarTodosFCI: TBitBtnLocked
        Tag = 1
        Left = 179
        Top = 0
        Width = 117
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F1 ] Marcar Todos FCI'
        TabOrder = 2
        OnClick = btnMarcarTodosFCIClick
      end
      object btnMarcarTodosCI: TBitBtnLocked
        Tag = 1
        Left = 296
        Top = 0
        Width = 124
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F3 ] Marcar Todos % CI'
        TabOrder = 3
        OnClick = btnMarcarTodosCIClick
      end
      object btnMarcarTodosClaIPI: TBitBtnLocked
        Tag = 1
        Left = 420
        Top = 0
        Width = 144
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F5 ] Marcar Todos NCM'
        TabOrder = 4
        OnClick = btnMarcarTodosClaIPIClick
      end
      object btnMarcarTodosCEST: TBitBtnLocked
        Tag = 1
        Left = 564
        Top = 0
        Width = 150
        Height = 20
        Caption = '[ F10 ] Marcar Todos CEST'
        TabOrder = 10
        OnClick = btnMarcarTodosCESTClick
      end
      object btnMarcarTodosCodBarras: TBitBtnLocked
        Tag = 1
        Left = 714
        Top = 0
        Width = 195
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F7 ] Marcar Todos C'#243'digo De Barras'
        TabOrder = 5
        OnClick = btnMarcarTodosCodBarrasClick
      end
      object btnDesmarcarFCI: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 179
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F2 ] Desmarcar Todos  FCI'
        TabOrder = 6
        OnClick = btnDesmarcarFCIClick
      end
      object btnDesmarcarCI: TBitBtnLocked
        Left = 179
        Top = 20
        Width = 241
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F4 ] Desmarcar Todos %CI'
        TabOrder = 7
        OnClick = btnDesmarcarCIClick
      end
      object btnDesmarcarClaIPI: TBitBtnLocked
        Left = 420
        Top = 20
        Width = 144
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F6 ] Desmarcar Todos NCM'
        TabOrder = 8
        OnClick = btnDesmarcarClaIPIClick
      end
      object btnDesmarcarTodosCEST: TBitBtnLocked
        Tag = 1
        Left = 564
        Top = 20
        Width = 150
        Height = 20
        BiDiMode = bdRightToLeftNoAlign
        Caption = '[ F12 ] Desmarcar Todos CEST'
        ParentBiDiMode = False
        TabOrder = 11
        OnClick = btnDesmarcarTodosCESTClick
      end
      object btnDesmarcarTodosCodBarras: TBitBtnLocked
        Left = 714
        Top = 20
        Width = 195
        Height = 20
        Anchors = [akLeft]
        Caption = '[ F8 ] Desmarcar Todos C'#243'digo de Barras'
        TabOrder = 9
        OnClick = btnDesmarcarTodosCodBarrasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 913
      Top = 2
      Width = 90
      Height = 39
      Align = alRight
      ExplicitLeft = 913
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 39
    end
  end
  inherited pnlStatus: TPanel
    Top = 714
    Width = 1005
    ExplicitTop = 714
    ExplicitWidth = 1005
    inherited pnlNomeForm: TPanel
      Left = 834
      ExplicitLeft = 834
    end
    inherited pnlInfo: TPanel
      Width = 834
      ExplicitWidth = 834
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 596
    Width = 1005
    Height = 75
    Align = alBottom
    TabOrder = 2
    object lblDiferenca: TLabel
      Left = 1
      Top = 1
      Width = 386
      Height = 73
      Align = alClient
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 3
      ExplicitHeight = 14
    end
    object lblMsgInformativa: TLabel
      Left = 387
      Top = 1
      Width = 617
      Height = 73
      Margins.Right = 5
      Align = alRight
      Caption = 
        '* Aten'#231#227'o: A combina'#231#227'o selecionada NCM x CEST para ser atualiza' +
        'da no Cadastro de Produto deve possuir v'#237'nculo no Autcom.'
      Color = clMenu
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ExplicitHeight = 14
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 144
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 152
    Top = 96
  end
  object dtsConsulta: TDataSource
    Left = 560
    Top = 136
  end
end
