inherited frmEntFreConGridIdentificaDocumento: TfrmEntFreConGridIdentificaDocumento
  Width = 1088
  Height = 548
  BorderStyle = bsSizeable
  Caption = 
    'Situa'#231#227'o dos documentos que ser'#227'o importados. Digite o documento' +
    ' de venda relacionado.'
  OnDestroy = FormDestroy
  ExplicitWidth = 1088
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 467
    Width = 1072
    ExplicitTop = 467
    ExplicitWidth = 1072
    inherited FlwBotoes: TFlowPanel
      Width = 991
      ExplicitWidth = 991
    end
    inherited btnSair: TBitBtnLocked
      Left = 993
      Top = 2
      Align = alRight
      ExplicitLeft = 993
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 493
    Width = 1072
    ExplicitTop = 493
    ExplicitWidth = 1072
    inherited pnlNomeForm: TPanel
      Left = 901
      ExplicitLeft = 901
    end
    inherited pnlInfo: TPanel
      Width = 901
      ExplicitWidth = 901
    end
  end
  object cxDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1072
    Height = 319
    Align = alClient
    TabOrder = 2
    OnExit = cxDadosExit
    object cxDadosBandTbl: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxDadosBandTblCustomDrawCell
      OnEditKeyPress = cxDadosBandTblEditKeyPress
      DataController.DataSource = dtsDados
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'CT-e'
          Width = 283
        end
        item
          Caption = 'NF-e'
          Width = 358
        end
        item
          Caption = 'Documento de Venda'
          Width = 428
        end>
      object cxDadosCTE: TcxGridDBBandedColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'CTE_ACESSO'
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxDadosNFE_CNPJ__: TcxGridDBBandedColumn
        Caption = 'Cnpj.'
        DataBinding.FieldName = 'NFE_CNPJ__'
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxDadosNFE_NUMDOC: TcxGridDBBandedColumn
        Caption = 'N'#250'mero Documento'
        DataBinding.FieldName = 'NFE_NUMDOC'
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxDadosNFE_SERIE: TcxGridDBBandedColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'NFE_SERIE_'
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxDadosFIS_CODEMP: TcxGridDBBandedColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FIS_CODEMP'
        Options.AutoWidthSizable = False
        Width = 60
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxDadosFIS_ESPECIE: TcxGridDBBandedColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'FIS_ESPDOC'
        Options.AutoWidthSizable = False
        Width = 51
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxDadosFIS_NUMDOC: TcxGridDBBandedColumn
        Caption = 'N'#250'mero do Documento'
        DataBinding.FieldName = 'FIS_NUMDOC'
        Options.AutoWidthSizable = False
        Width = 120
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxDadosMov_SeqGer: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MOV_GERSEQ'
        Visible = False
        MinWidth = 0
        Options.Editing = False
        Width = 0
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxDadosDuplicado: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ENT_DUPLIC'
        Visible = False
        MinWidth = 0
        Options.Editing = False
        Width = 0
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxDadosFIS_TIP_FC: TcxGridDBBandedColumn
        Caption = 'C / F'
        DataBinding.FieldName = 'FIS_TIP_FC'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'F'
          'C')
        Width = 36
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxDadosFIS_FORCLI: TcxGridDBBandedColumn
        Caption = 'Cliente / Fornecedor'
        DataBinding.FieldName = 'FIS_FORCLI'
        Width = 111
        Position.BandIndex = 2
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxDadosFIS_SERIE_: TcxGridDBBandedColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'FIS_SERIE_'
        Width = 50
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxDadosDUP_RECTNF: TcxGridDBBandedColumn
        DataBinding.FieldName = 'DUP_RECTNF'
        Visible = False
        MinWidth = 0
        Width = 0
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxDadosFIS_HISTOR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'FIS_HISTOR'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosBandTbl
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 384
    Width = 1072
    Height = 83
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      1072
      83)
    object shpDuplicados: TShape
      Left = 1
      Top = 62
      Width = 15
      Height = 15
      Brush.Color = clRed
    end
    object lblDuplicados: TLabel
      Left = 18
      Top = 63
      Width = 255
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Documento de Venda vinculado em mais de um NF-e.'
    end
    object lblLegComVinculo: TLabel
      Left = 19
      Top = 25
      Width = 219
      Height = 14
      Caption = 'NF-e vinculado com um documento de venda.'
    end
    object Shape2: TShape
      Left = 1
      Top = 24
      Width = 15
      Height = 15
      Brush.Color = clMoneyGreen
    end
    object lblLegSemVinculo: TLabel
      Left = 19
      Top = 6
      Width = 213
      Height = 14
      Caption = 'NF-e sem vinculo com documento de venda.'
    end
    object Shape1: TShape
      Left = 1
      Top = 5
      Width = 15
      Height = 15
    end
    object lblLegJaVincu: TLabel
      Left = 18
      Top = 44
      Width = 439
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      Caption = 
        'Documento de Venda vinculado em mais de um NF-e. P'#243'rem realizada' +
        ' em outra importa'#231#227'o.'
    end
    object Shape3: TShape
      Left = 1
      Top = 43
      Width = 15
      Height = 15
      Brush.Color = clAqua
    end
    object lblDocumentoVendaCancelado: TLabel
      Left = 322
      Top = 6
      Width = 252
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      Caption = 'NF-e vinculada com documento de venda cancelado'
    end
    object shpVendaCancelada: TShape
      Left = 301
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = 33023
    end
  end
  object pnlDup: TPanel [4]
    Left = 0
    Top = 319
    Width = 1072
    Height = 65
    Align = alBottom
    Alignment = taLeftJustify
    Caption = 'pnlDup'
    TabOrder = 4
    Visible = False
    object memDup: TMemo
      Left = 1
      Top = 1
      Width = 1070
      Height = 63
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 144
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 144
  end
  object dtsDados: TDataSource
    OnUpdateData = dtsDadosUpdateData
    Left = 424
    Top = 88
  end
end
