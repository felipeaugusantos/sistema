inherited frmVisualizarCubagemPaletizacaoDosProdutos: TfrmVisualizarCubagemPaletizacaoDosProdutos
  Width = 748
  Height = 381
  Caption = 'Visualizar a cubagem/paletiza'#231#227'o dos produtos'
  Position = poMainFormCenter
  ExplicitWidth = 748
  ExplicitHeight = 381
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 308
    Width = 742
    ExplicitTop = 308
    ExplicitWidth = 742
    inherited FlwBotoes: TFlowPanel
      Width = 738
      ExplicitWidth = 738
      object lblLegendaQtdCaixa: TLabel
        Left = 0
        Top = 0
        Width = 250
        Height = 22
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = '*Qtd.Caixa = Quantidade / M'#250'tiplo de Venda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 662
      ExplicitLeft = 662
    end
  end
  inherited pnlStatus: TPanel
    Top = 336
    Width = 742
    ExplicitTop = 336
    ExplicitWidth = 742
    inherited pnlNomeForm: TPanel
      Left = 492
      Width = 250
      ExplicitLeft = 492
      ExplicitWidth = 250
    end
    inherited pnlInfo: TPanel
      Width = 492
      ExplicitWidth = 492
    end
  end
  object cxgCubagemEPaletizacao: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 742
    Height = 308
    Align = alClient
    TabOrder = 2
    object cxgVisualizarCubagemEPaletizacaoView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dscCUBPAL
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CUB_M3'
          Column = cxgVisualizarCubagemEPaletizacaoViewCUB_M3
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'PESBRU'
          Column = cxgVisualizarCubagemEPaletizacaoViewPESBRU
        end
        item
          Format = 'Total de Produtos: 0'
          Kind = skCount
          FieldName = 'CODITE'
          Column = cxgVisualizarCubagemEPaletizacaoViewDESITE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '  '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgVisualizarCubagemEPaletizacaoViewCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Width = 80
      end
      object cxgVisualizarCubagemEPaletizacaoViewDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Width = 264
      end
      object cxgVisualizarCubagemEPaletizacaoViewSIGUNI: TcxGridDBColumn
        DataBinding.FieldName = 'SIGUNI'
        Width = 39
      end
      object cxgVisualizarCubagemEPaletizacaoViewQTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxgVisualizarCubagemEPaletizacaoViewQTDCXA: TcxGridDBColumn
        DataBinding.FieldName = 'QTDCXA'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
      end
      object cxgVisualizarCubagemEPaletizacaoViewPESBRU: TcxGridDBColumn
        DataBinding.FieldName = 'PESBRU'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgVisualizarCubagemEPaletizacaoViewCUB_M3: TcxGridDBColumn
        DataBinding.FieldName = 'CUB_M3'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxgVisualizarCubagemEPaletizacao: TcxGridLevel
      GridView = cxgVisualizarCubagemEPaletizacaoView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 120
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 104
  end
  object cdsCUBPAL: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 104
    object cdsCUBPALCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsCUBPALDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsCUBPALSIGUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsCUBPALQTDITE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsCUBPALPESBRU: TFloatField
      DisplayLabel = 'Peso Bruto Kgs'
      FieldName = 'PESBRU'
      DisplayFormat = '#,##0.00'
    end
    object cdsCUBPALCUB_M3: TFloatField
      DisplayLabel = 'Cubagem M3'
      FieldName = 'CUB_M3'
      DisplayFormat = '#,####0.0000'
    end
    object cdsCUBPALQTDCXA: TFloatField
      DisplayLabel = 'Qtd. Caixa'
      FieldName = 'QTDCXA'
      DisplayFormat = '#,##0.00'
    end
  end
  object dscCUBPAL: TDataSource
    DataSet = cdsCUBPAL
    Left = 216
    Top = 152
  end
end
