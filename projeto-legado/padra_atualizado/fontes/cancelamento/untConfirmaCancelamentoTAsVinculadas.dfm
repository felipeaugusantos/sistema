inherited frmConfirmaCancelamentoTAsVinculadas: TfrmConfirmaCancelamentoTAsVinculadas
  Width = 867
  Height = 444
  BorderIcons = []
  Caption = ''
  ExplicitWidth = 867
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 14
  object lblAviso: TLabel [0]
    Left = 0
    Top = 359
    Width = 861
    Height = 14
    Align = alBottom
    Caption = 'lblAviso'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 38
  end
  object Splitter1: TSplitter [1]
    Left = 0
    Top = 221
    Width = 861
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 36
    ExplicitWidth = 188
  end
  inherited pnlBotoes: TPanel
    Top = 373
    Width = 861
    ExplicitTop = 373
    ExplicitWidth = 861
    inherited FlwBotoes: TFlowPanel
      Width = 857
      ExplicitWidth = 857
    end
    inherited btnSair: TBitBtnLocked
      Left = 778
      ExplicitLeft = 778
    end
  end
  inherited pnlStatus: TPanel
    Top = 399
    Width = 861
    Visible = False
    ExplicitTop = 399
    ExplicitWidth = 861
    inherited pnlNomeForm: TPanel
      Left = 690
      ExplicitLeft = 690
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  object cxgDocumentos: TcxGridCitel [4]
    Left = 0
    Top = 36
    Width = 861
    Height = 185
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosDBTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDocumentos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDocumentosDBTBVDOCUMENTO: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUMENTO'
        Visible = False
        GroupIndex = 0
        Width = 146
      end
      object cxgDocumentosDBTBVPRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUTO'
        Width = 312
      end
      object cxgDocumentosDBTBVDET_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'DET_NUMLOT'
        Width = 113
      end
      object cxgDocumentosDBTBVDET_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'DET_QTDITE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 72
      end
      object cxgDocumentosDBTBVENTSAI: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'ENTSAI'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 82
      end
      object cxgDocumentosDBTBVCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Width = 248
      end
    end
    object cxgDocumentosLVL: TcxGridLevel
      GridView = cxgDocumentosDBTBV
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 0
    Width = 861
    Height = 36
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblMensagem: TLabel
      Left = 1
      Top = 1
      Width = 859
      Height = 34
      Align = alClient
      Caption = 
        '  A(s) transfer'#234'ncia(s) de estoque listadas abaixo est'#227'o vincula' +
        'das ao documento e ser'#227'o exclu'#237'das!'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 569
      ExplicitHeight = 15
    end
  end
  object pnlLotesFaturados: TPanel [6]
    Left = 0
    Top = 224
    Width = 861
    Height = 135
    Align = alBottom
    Caption = 'pnlLotesFaturados'
    TabOrder = 4
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 859
      Height = 14
      Align = alTop
      Caption = 
        'Lotes que n'#227'o ser'#227'o excluidos pois eles j'#225' tem movimenta'#231#227'o de f' +
        'aturamento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 374
    end
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 16
      Width = 859
      Height = 118
      Align = alBottom
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsFaturamentos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridDBColumn2: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'ITEM'
          Width = 312
        end
        object cxGridDBColumn3: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'LOT_NUMLOT'
          Width = 113
        end
        object cxGridDBColumn6: TcxGridDBColumn
          Caption = 'Faturamento'
          DataBinding.FieldName = 'DOCUME'
          Width = 248
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableViewCitel1
      end
    end
  end
  object dtsDocumentos: TDataSource
    Left = 436
    Top = 208
  end
  object dtsFaturamentos: TDataSource
    Left = 332
    Top = 200
  end
end
