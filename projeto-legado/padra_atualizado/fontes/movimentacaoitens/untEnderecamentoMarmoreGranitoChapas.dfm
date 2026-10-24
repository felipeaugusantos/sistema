inherited frmEnderecamentoMarmoreGranitoChapas: TfrmEnderecamentoMarmoreGranitoChapas
  Width = 1027
  Height = 520
  Caption = 'Defini'#231#245'es das Chapas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1027
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 1021
    ExplicitTop = 447
    ExplicitWidth = 1021
    inherited FlwBotoes: TFlowPanel
      Width = 1017
      ExplicitWidth = 1017
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 109
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
        OnKeyDown = btnConfirmaKeyDown
      end
      object btnReplicaMedidas: TBitBtnLocked
        Left = 109
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F5 ] Replica Medidas'
        TabOrder = 1
        OnClick = btnReplicaMedidasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 941
      ExplicitLeft = 941
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 1021
    ExplicitTop = 475
    ExplicitWidth = 1021
    inherited pnlNomeForm: TPanel
      Left = 850
      ExplicitLeft = 850
    end
    inherited pnlInfo: TPanel
      Width = 850
      ExplicitWidth = 850
    end
  end
  object cxDados: TcxGridCitel [2]
    Left = 0
    Top = 41
    Width = 1021
    Height = 385
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
    end
    object cxgDBDados: TcxGridDBBandedTableView
      OnKeyDown = cxgDBDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxgDBDadosCanFocusRecord
      OnCustomDrawCell = cxgDBDadosCustomDrawCell
      OnEditKeyDown = cxgDBDadosEditKeyDown
      DataController.DataSource = dtsDados
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'PRECO_M2'
          Column = cxgDBDadosPRECO_M2
        end
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'QTD_M2_LIQUIDO'
          Column = cxgDBDadosQTD_M2_LIQUIDO
        end
        item
          Format = '#0.000'
          Kind = skSum
          FieldName = 'VALOR_TOTAL_M2'
          Column = cxgDBDadosVALOR_TOTAL_M2
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Bands = <
        item
        end
        item
          Caption = 'Margem Bruta'
          Width = 210
        end
        item
          Caption = 'Margem L'#237'quida'
          Width = 173
        end
        item
          Width = 940
        end>
      object cxgDBDadosCHAPA: TcxGridDBBandedColumn
        Caption = 'Chapa'
        DataBinding.FieldName = 'CHAPA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Properties.OnValidate = cxgDBDadosCHAPAPropertiesValidate
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDBDadosESTPER: TcxGridDBBandedColumn
        Caption = '% Estimado de Perda'
        DataBinding.FieldName = 'ESTPER'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.MaxValue = 100.000000000000000000
        Width = 114
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgDBDadosMEDIDA_BRUTA_LARGURA: TcxGridDBBandedColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'MEDIDA_BRUTA_LARGURA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDBDadosMEDIDA_BRUTA_ALTURA: TcxGridDBBandedColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'MEDIDA_BRUTA_ALTURA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDBDadosMEDIDA_LIQUIDA_LARGURA: TcxGridDBBandedColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'MEDIDA_LIQUIDA_LARGURA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDBDadosMEDIDA_LIQUIDA_ALTURA: TcxGridDBBandedColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'MEDIDA_LIQUIDA_ALTURA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDBDadosESPESSURA: TcxGridDBBandedColumn
        Caption = 'Espessura(cm)'
        DataBinding.FieldName = 'ESPESSURA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 64
        Width = 71
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgDBDadosPRECO_M2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o M'#178' (R$)'
        DataBinding.FieldName = 'PRECO_M2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 64
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDBDadosQTD_M2_LIQUIDO: TcxGridDBBandedColumn
        Caption = 'Qtd. M'#178' L'#237'quido'
        DataBinding.FieldName = 'QTD_M2_LIQUIDO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 64
        Options.Editing = False
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgDBDadosVALOR_TOTAL_M2: TcxGridDBBandedColumn
        Caption = 'Valor Total M'#178' (R$)'
        DataBinding.FieldName = 'VALOR_TOTAL_M2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 64
        Options.Editing = False
        Width = 95
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgDBDadosETIQUETA: TcxGridDBBandedColumn
        Caption = 'Etiqueta'
        DataBinding.FieldName = 'ETIQUETA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Glyph.SourceDPI = 96
            Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000000C744558745469746C65005072696E743BC83632EA00000267494441
              54785E7D93CB6B135114C6BF99C434A60F05698B1B5716752582E84AAD2822B6
              88B8101F50B45441210BEBC285150591A250A326462AA218F20FB810178A482C
              AD165AD0958216051F68D1966426F3B82FCFDCCC0C71512F7C73EE3DDCEF77EE
              DC87A19442D40C6AB74A332F4CD3EC05745E7FA33982F1CAF0E0D65D34E69127
              897F9B49EA3D7374A376AA901041F2E5D9ED0012A4A5019C0B28092C5A5E58D9
              808244476B0B38135111C4005AB55E7D587D191712928C147579052308908272
              5C03D2E4610064A0C0648E8E5776DF2EBF7D33385CB0BF7C7E0F2915494288C0
              28C0833E69EEE33B1C3E35FA67ECE1CCF4C5DCD33D0012C9E0B33CD3513EB477
              6DD744E54930D4D5852008240CD55807A3B1EB3AB0EC1A8EF4ADDF547A2C4B00
              D66880E0AAAB7B550675CB42329186904A5754A119000125015C38561DAB3B33
              604C75462B303D5F5042229D4AE0E78FEF3878EC4274046150210C686F4BE8B9
              9EC7D00460700832347000378B252C2C542145E0931AA1A4D23BBC72453B4E0F
              1D87C3380138026F03E032D409D2B3A107C5FC95C6A1C8F0084D8A8D0C744602
              B6CB41459B003E47CDE1A8D7194E666FE07FED5EFE2C7C9102F385E60600C3F7
              04AA1643D576B0BFBF0FD981CD284CCDEBCD6402641038BFA31BC5F22C7E2FDA
              A03F81CF1A0013009BFFF5753277E719EE8E3F070FCFDD63244E002E29070DE3
              D4B976BD8C91CB0FF0E9C3E46B10C708EF762BA985D43632F6722E7B628BDE79
              4087F846161E4DE3EAB99DEB0054490EC94E2AA54490085FA3655BD6ABDCFDA9
              6DF1B6A9F8ADC2756B1300BE91C75EEA31F9B94BFDFB00A44866EC44FCB23D92
              DB6CF80BF54A6944F3A08E160000000049454E44AE426082}
            Kind = bkGlyph
          end>
        Properties.ViewStyle = vsButtonsAutoWidth
        Properties.OnButtonClick = cxgDBDadosETIQUETAPropertiesButtonClick
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgDBDadosLOTE: TcxGridDBBandedColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOTE'
        MinWidth = 100
        Options.Editing = False
        Width = 120
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgDBDadosCOMPLEMENTO: TcxGridDBBandedColumn
        Caption = 'Complemento'
        DataBinding.FieldName = 'COMPLEMENTO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Visible = False
        Width = 87
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgDBDadosPERDA: TcxGridDBBandedColumn
        Caption = 'Qtd. M'#178' Perda'
        DataBinding.FieldName = 'PERDA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 74
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgDBDadosLOTE_DIVIDO: TcxGridDBBandedColumn
        DataBinding.FieldName = 'LOTE_DIVIDO'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgDBDadosPRECO_ENTREGA_M2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o M'#178' Entrega (R$)'
        DataBinding.FieldName = 'PRECO_ENTrEGA_M2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 112
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgDBDadosVALOR_TOTAL_ENTREGA_M2: TcxGridDBBandedColumn
        Caption = 'Valor Total Entrega M'#178' (R$)'
        DataBinding.FieldName = 'VALOR_TOTAL_ENTREGA_M2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 147
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDBDados
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1021
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 46
      Height = 15
      Caption = 'Produto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 25
      Top = 22
      Width = 27
      Height = 15
      Caption = 'Lote:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCapQtdChapas: TLabel
      Left = 346
      Top = 22
      Width = 72
      Height = 15
      Caption = 'Qtd. Chapas:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCapQtdEntrada: TLabel
      Left = 558
      Top = 22
      Width = 71
      Height = 15
      Caption = 'Qtd. Entrada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblLote: TLabel
      Left = 58
      Top = 22
      Width = 277
      Height = 14
      AutoSize = False
      Caption = 'lblLote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProduto: TLabel
      Left = 58
      Top = 5
      Width = 813
      Height = 14
      AutoSize = False
      Caption = 'lblProduto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdChapas: TLabel
      Left = 425
      Top = 22
      Width = 108
      Height = 14
      AutoSize = False
      Caption = '0,000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQtdEntrada: TLabel
      Left = 637
      Top = 22
      Width = 112
      Height = 14
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlAcao: TPanel [4]
    Left = 0
    Top = 426
    Width = 1021
    Height = 21
    Align = alBottom
    TabOrder = 4
    object Label5: TLabel
      Left = 2
      Top = 2
      Width = 333
      Height = 14
      Caption = 
        '[Ins] - Para Inclu'#237'r                                        [Del' +
        'ete] - Para excluir'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object pnlLegendaLotePrincipal: TPanel
      Left = 888
      Top = 1
      Width = 132
      Height = 19
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlLegendaLotePrincipal'
      ShowCaption = False
      TabOrder = 0
      Visible = False
      object shpLotePrincipal: TShape
        Left = 0
        Top = 0
        Width = 25
        Height = 19
        Align = alLeft
        Brush.Color = 4227327
      end
      object lblLotePrincipal: TLabel
        AlignWithMargins = True
        Left = 28
        Top = 0
        Width = 75
        Height = 19
        Margins.Top = 0
        Margins.Right = 0
        Align = alLeft
        Caption = 'Lote Principal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 14
      end
    end
  end
  object dtsDados: TDataSource
    Left = 232
    Top = 116
  end
end
