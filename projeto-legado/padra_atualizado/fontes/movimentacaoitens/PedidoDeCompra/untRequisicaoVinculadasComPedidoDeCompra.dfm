inherited frmRequisicaoVinculadasComPedidoDeCompra: TfrmRequisicaoVinculadasComPedidoDeCompra
  Width = 1342
  Height = 768
  Caption = 'Manuten'#231#227'o de Requisi'#231#245'es x Pedido de Compra'
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1342
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1336
    ExplicitTop = 695
    ExplicitWidth = 1336
    inherited FlwBotoes: TFlowPanel
      Width = 1332
      ExplicitWidth = 1332
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 343
        Height = 22
        Caption = '[F2] Marca / Desmarca (Remover Vinculos com Pedido de compra)'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 456
        Top = 0
        Width = 96
        Height = 22
        Caption = '[F3] Marca todas'
        TabOrder = 2
        OnClick = btnMarTodosClick
      end
      object btnDesTodos: TBitBtnLocked
        Left = 552
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F4] Desmarca todas'
        TabOrder = 3
        OnClick = btnDesTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1253
      ExplicitLeft = 1253
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1336
    ExplicitTop = 723
    ExplicitWidth = 1336
    inherited pnlNomeForm: TPanel
      Left = 1056
      Width = 280
      ExplicitLeft = 1056
      ExplicitWidth = 280
    end
    inherited pnlInfo: TPanel
      Width = 1056
      ExplicitWidth = 1056
    end
  end
  object cxDados: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1336
    Height = 664
    Align = alClient
    TabOrder = 2
    object cxgDados: TcxGridDBBandedTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDadosCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          Caption = 'Requisi'#231#227'o'
          Width = 1032
        end
        item
          Caption = 'Pedido Compra'
          Width = 450
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxgDadosMARCADO: TcxGridDBBandedColumn
        Caption = 'Sel'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 28
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDadosRCD_CODIGO: TcxGridDBBandedColumn
        Caption = 'Requisi'#231#227'o'
        DataBinding.FieldName = 'RCD_CODIGO'
        Options.Editing = False
        Width = 67
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDadosRCD_EMPRESA: TcxGridDBBandedColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'RCD_EMPRESA'
        Options.Editing = False
        Width = 171
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgDadosVENDEDOR: TcxGridDBBandedColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDEDOR'
        Options.Editing = False
        Width = 146
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgDadosCLIENTE: TcxGridDBBandedColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Options.Editing = False
        Width = 147
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgDadosRCD_CODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'RCD_CODITE'
        Options.Editing = False
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgDadosITE_DESITE: TcxGridDBBandedColumn
        Caption = 'Decri'#231#227'o Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 144
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgDadosPEDVEN: TcxGridDBBandedColumn
        Caption = 'Pedido de Venda'
        DataBinding.FieldName = 'PEDVEN'
        Options.Editing = False
        Width = 172
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgDadosQTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd. Requisi'#231#227'o'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 92
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgDadosPCG_NUMPED: TcxGridDBBandedColumn
        Caption = 'Num. Pedido'
        DataBinding.FieldName = 'PCG_NUMPED'
        Options.Editing = False
        Width = 34
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDadosPCG_CODEMP: TcxGridDBBandedColumn
        Caption = 'Emp. Ped.'
        DataBinding.FieldName = 'PCG_CODEMP'
        Options.Editing = False
        Width = 33
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDadosPCD_DTAENT: TcxGridDBBandedColumn
        Caption = 'Dta. Entrega'
        DataBinding.FieldName = 'PCD_DTAENT'
        Options.Editing = False
        Width = 34
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgDadosPCD_QTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd. Pedido'
        DataBinding.FieldName = 'PCD_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 33
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgDadosFORNEC: TcxGridDBBandedColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Options.Editing = False
        Width = 200
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 664
    Width = 1336
    Height = 31
    Align = alBottom
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 15
      Width = 1334
      Height = 14
      Align = alTop
      Caption = 
        '         Caso queira atualizar as quantidades do Pedido de Compr' +
        'a, o desv'#237'nculo deve ser feito atrav'#233's da rotina de Pedido de Co' +
        'mpras.     '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 749
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 1334
      Height = 14
      Align = alTop
      Caption = 
        '   Aten'#231#227'o: Ao desvincular Requisi'#231#227'o do Pedido de Compra por es' +
        'sa rotina, as quantidades do Pedido de Compra ser'#227'o mantidas. '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 721
    end
  end
  object dtsDados: TDataSource
    Left = 400
    Top = 216
  end
end
