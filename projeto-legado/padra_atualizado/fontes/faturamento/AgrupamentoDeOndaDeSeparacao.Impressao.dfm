inherited frmAgrupamentoDeOndaDeSeparacaoImpressao: TfrmAgrupamentoDeOndaDeSeparacaoImpressao
  Width = 900
  Height = 500
  Caption = 'Impress'#227'o de Remessa de Separa'#231#227'o'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 900
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 894
    TabOrder = 4
    ExplicitTop = 427
    ExplicitWidth = 894
    inherited FlwBotoes: TFlowPanel
      Width = 890
      ExplicitWidth = 890
    end
    inherited btnSair: TBitBtnLocked
      Left = 814
      ExplicitLeft = 814
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 894
    TabOrder = 5
    ExplicitTop = 455
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 544
      Width = 350
      ExplicitLeft = 544
      ExplicitWidth = 350
    end
    inherited pnlInfo: TPanel
      Width = 544
      ExplicitWidth = 544
    end
  end
  object pnlRemessaDeSeparacao: TPanel [2]
    Left = 0
    Top = 0
    Width = 894
    Height = 30
    Align = alTop
    Caption = 'Remessa de Separa'#231#227'o - 000000000000 '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 397
    Width = 894
    Height = 30
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object btnMarcarTodos: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 136
      Height = 22
      Caption = 'Marcar Todos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarcarTodos: TBitBtnLocked
      Left = 150
      Top = 3
      Width = 136
      Height = 22
      Caption = 'Desmarcar Todos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDesmarcarTodosClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 292
      Top = 3
      Width = 136
      Height = 22
      Caption = 'Imprimir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnImprimirClick
    end
  end
  object cxgItens: TcxGrid [4]
    Left = 0
    Top = 30
    Width = 894
    Height = 341
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 367
    object cxgItensView: TcxGridDBTableView
      OnDblClick = cxgItensViewDblClick
      OnKeyPress = cxgItensViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsOndas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'QTDITE'
          Column = cxgItensViewQTDITE
          DisplayText = 'Total'
          VisibleForCustomization = False
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      object cxgItensViewCODITE: TcxGridDBColumn
        Caption = 'SKU'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 100
      end
      object cxgItensViewDESCRI: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'DESCRI'
        Width = 400
      end
      object cxgItensViewLOCFIS: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Width = 200
      end
      object cxgItensViewQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 150
      end
      object cxgItensViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgItensViewSTAIMP: TcxGridDBColumn
        DataBinding.FieldName = 'STAIMP'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlLegendas: TPanel [5]
    Left = 0
    Top = 371
    Width = 894
    Height = 26
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = -2
    ExplicitTop = 342
    object lblItensJaImpressos: TLabel
      Left = 26
      Top = 6
      Width = 126
      Height = 14
      Caption = 'Itens j'#225' impressos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpItensJaImpressos: TShape
      Left = 8
      Top = 7
      Width = 12
      Height = 12
      Brush.Color = clSkyBlue
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 256
  end
  object dtsOndas: TDataSource
    DataSet = cdsOndas
    Left = 424
    Top = 200
  end
  object cdsOndas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOndas'
    Left = 456
    Top = 200
    object cdsOndasMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsOndasCODITE: TStringField
      Alignment = taCenter
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsOndasDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsOndasLOCFIS: TStringField
      FieldName = 'LOCFIS'
    end
    object cdsOndasQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsOndasSTAIMP: TStringField
      FieldName = 'STAIMP'
      Size = 1
    end
  end
  object dspOndas: TUniDataSetProvider
    DataSet = qryOndas
    Options = [poDisableInserts, poDisableDeletes]
    Left = 488
    Top = 200
  end
  object qryOndas: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 520
    Top = 200
  end
end
