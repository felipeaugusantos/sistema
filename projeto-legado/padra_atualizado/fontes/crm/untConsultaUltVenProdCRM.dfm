inherited frmConsultaUltVenProdCRM: TfrmConsultaUltVenProdCRM
  Caption = 'Consulta Ultimas Vendas do Produto'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    ExplicitTop = 429
  end
  inherited pgcDados: TPageControl
    Height = 429
    ExplicitHeight = 429
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 397
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 429
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object dbgUltimasVendas: TcxGrid
      Left = 1
      Top = 1
      Width = 767
      Height = 427
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
      object dbgUltimasVendasDBTableView1: TcxGridDBTableView
        OnDblClick = dbgUltimasVendasDBTableView1DblClick
        OnKeyDown = dbgUltimasVendasDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgUltimasVendasDBTableView1CustomDrawCell
        DataController.DataSource = dtsUltVendas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.PullFocusing = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhuma ocorr'#234'ncia dispon'#237'vel>'
        OptionsView.GroupByBox = False
        object dbgUltimasVendasDBTableView1NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'NUMDOC'
          Width = 84
        end
        object dbgUltimasVendasDBTableView1ESPDOC: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'ESPDOC'
          Width = 53
        end
        object dbgUltimasVendasDBTableView1CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Width = 57
        end
        object dbgUltimasVendasDBTableView1CODITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'CODITE'
          Width = 64
        end
        object dbgUltimasVendasDBTableView1QTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDORI'
          Width = 77
        end
        object dbgUltimasVendasDBTableView1PR_UNITARIO: TcxGridDBColumn
          Caption = 'Valor Unit'#225'rio'
          DataBinding.FieldName = 'PR_UNITARIO'
          Width = 85
        end
        object dbgUltimasVendasDBTableView1PR_TOTAL: TcxGridDBColumn
          Caption = 'Pre'#231'o Total'
          DataBinding.FieldName = 'PR_TOTAL'
          Width = 87
        end
        object dbgUltimasVendasDBTableView1DTA_MOV: TcxGridDBColumn
          Caption = 'Data Mov.'
          DataBinding.FieldName = 'DTA_MOV'
        end
        object dbgUltimasVendasDBTableView1HOR_MOV: TcxGridDBColumn
          Caption = 'Hora Mov.'
          DataBinding.FieldName = 'HOR_MOV'
        end
        object dbgUltimasVendasDBTableView1CLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Width = 360
        end
        object dbgUltimasVendasDBTableView1CODGRU: TcxGridDBColumn
          Caption = 'Grupo'
          DataBinding.FieldName = 'CODGRU'
          Width = 42
        end
        object dbgUltimasVendasDBTableView1VENDEDOR: TcxGridDBColumn
          Caption = 'Vendedor'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 259
        end
      end
      object dbgUltimasVendasLevel1: TcxGridLevel
        GridView = dbgUltimasVendasDBTableView1
      end
    end
  end
  object pnlBotoesInferiores: TPanel [4]
    Left = 0
    Top = 429
    Width = 769
    Height = 31
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 4
    object shpMais12: TShape
      Tag = 66
      Left = 107
      Top = 6
      Width = 27
      Height = 16
      Brush.Color = clRed
      Pen.Color = clWhite
    end
    object Label7: TLabel
      Tag = 66
      Left = 140
      Top = 8
      Width = 157
      Height = 14
      Caption = 'Venda maior que (12 Meses)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpVencida: TShape
      Tag = 66
      Left = 307
      Top = 6
      Width = 27
      Height = 16
      Brush.Color = clPurple
      Pen.Color = clWhite
    end
    object Label11: TLabel
      Tag = 66
      Left = 340
      Top = 8
      Width = 165
      Height = 14
      Caption = 'Produto com Garantia Vencida'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpOk: TShape
      Tag = 66
      Left = 515
      Top = 6
      Width = 27
      Height = 16
      Brush.Color = 4227072
      Pen.Color = clWhite
    end
    object Label1: TLabel
      Tag = 66
      Left = 548
      Top = 8
      Width = 104
      Height = 14
      Caption = 'Produto c/ Garantia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 683
      Top = 2
      Width = 84
      Height = 27
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 0
      OnClick = btnSairBaixaClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 94
      Height = 27
      Align = alLeft
      Caption = '[ F10 ] Confirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  object qryUltVendas: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 296
    Top = 152
  end
  object dspUltVendas: TUniDataSetProvider
    DataSet = qryUltVendas
    Options = []
    Left = 328
    Top = 152
  end
  object dtsUltVendas: TDataSource
    DataSet = cdsUltVendas
    Left = 359
    Top = 152
  end
  object cdsUltVendas: TUniClientDataSet
    Aggregates = <>
    PacketRecords = 100
    Params = <>
    ProviderName = 'dspUltVendas'
    AfterScroll = cdsUltVendasAfterScroll
    Left = 408
    Top = 152
    object cdsUltVendasQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsUltVendasPR_TOTAL: TFloatField
      FieldName = 'PR_TOTAL'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsUltVendasDTA_MOV: TDateField
      FieldName = 'DTA_MOV'
    end
    object cdsUltVendasHOR_MOV: TTimeField
      FieldName = 'HOR_MOV'
    end
    object cdsUltVendasNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 10
    end
    object cdsUltVendasESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 10
    end
    object cdsUltVendasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 10
    end
    object cdsUltVendasCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 100
    end
    object cdsUltVendasCODITE: TStringField
      FieldName = 'CODITE'
      Size = 10
    end
    object cdsUltVendasCODGRU: TStringField
      FieldName = 'CODGRU'
      Size = 10
    end
    object cdsUltVendasPR_UNITARIO: TFloatField
      FieldName = 'PR_UNITARIO'
      DisplayFormat = '###,#0.00'
      EditFormat = '###,#0.00'
    end
    object cdsUltVendasVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      Size = 100
    end
    object cdsUltVendasFORCLI: TStringField
      FieldName = 'FORCLI'
      Size = 8
    end
    object cdsUltVendasTIP_FC: TStringField
      FieldName = 'TIP_FC'
      Size = 1
    end
    object cdsUltVendasSERIE_: TStringField
      FieldName = 'SERIE_'
      Size = 3
    end
    object cdsUltVendasQTDORI: TFloatField
      FieldName = 'QTDORI'
    end
    object cdsUltVendasSEQORI: TStringField
      FieldName = 'SEQORI'
    end
    object cdsUltVendasQTDCNV: TFloatField
      FieldName = 'QTDCNV'
    end
    object cdsUltVendasQTDDEV: TFloatField
      FieldName = 'QTDDEV'
    end
    object cdsUltVendasQTDADE: TFloatField
      FieldName = 'QTDADE'
    end
    object cdsUltVendasQTDFIS: TFloatField
      FieldName = 'QTDFIS'
    end
  end
end
