inherited frmEnvioConfirmacaoSefaz: TfrmEnvioConfirmacaoSefaz
  Width = 919
  Height = 488
  Caption = 'Envio de Confirma'#231#227'o de Opera'#231#227'o de Entrada para SEFAZ'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 919
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 415
    Width = 913
    ExplicitTop = 415
    ExplicitWidth = 822
    inherited FlwBotoes: TFlowPanel
      Width = 909
      ExplicitTop = 2
      ExplicitWidth = 818
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 133
        Height = 23
        Caption = '[ F10 ] Confirma Envio'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 833
      ExplicitLeft = 742
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 913
    ExplicitTop = 443
    ExplicitWidth = 822
    inherited pnlNomeForm: TPanel
      Left = 742
      ExplicitLeft = 651
    end
    inherited pnlInfo: TPanel
      Width = 742
      ExplicitWidth = 651
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 913
    Height = 415
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlContainer'
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 822
    object pnlFiltros: TPanel
      Left = 0
      Top = 0
      Width = 913
      Height = 43
      Align = alTop
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 822
      object Label8: TLabel
        Left = 6
        Top = 21
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 587
        Top = 21
        Width = 87
        Height = 14
        Caption = 'Data Entrada Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 427
        Top = 21
        Width = 91
        Height = 14
        Caption = 'Data Entrada Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtForNot: TEditFocus
        Tag = 99
        Left = 64
        Top = 13
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtForNotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForNot: TEditFocus
        Left = 121
        Top = 13
        Width = 296
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaEntIni: TMaskEditFocus
        Tag = 99
        Left = 520
        Top = 13
        Width = 61
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaEntFin: TMaskEditFocus
        Tag = 99
        Left = 677
        Top = 13
        Width = 62
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object btnFiltra: TBitBtnLocked
        Left = 743
        Top = 13
        Width = 75
        Height = 22
        Caption = 'Filtrar'
        TabOrder = 4
        OnClick = btnFiltraClick
      end
    end
    object cxDocs: TcxGridCitel
      Left = 0
      Top = 43
      Width = 913
      Height = 327
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 822
      ExplicitHeight = 355
      object cxgDocs: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgDocsDTAENT: TcxGridDBColumn
          Caption = 'Dta. Entrada'
          DataBinding.FieldName = 'DTAENT'
          Width = 68
        end
        object cxgDocsDTADOC: TcxGridDBColumn
          Caption = 'Dta. Doc.'
          DataBinding.FieldName = 'DTADOC'
          Width = 59
        end
        object cxgDocsNUMDOC: TcxGridDBColumn
          Caption = 'Num. Doc.'
          DataBinding.FieldName = 'NUMDOC'
          Width = 120
        end
        object cxgDocsColumn1: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'ESPDOC'
          Width = 49
        end
        object cxgDocsColumn2: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Width = 60
        end
        object cxgDocsSERIE_: TcxGridDBColumn
          Caption = 'S'#233'rie'
          DataBinding.FieldName = 'SERIE_'
          Width = 36
        end
        object cxgDocsCODFOR: TcxGridDBColumn
          Caption = 'Fornecedor'
          DataBinding.FieldName = 'CODFOR'
          MinWidth = 64
        end
        object cxgDocsRAZSOC: TcxGridDBColumn
          Caption = 'Raz'#227'o Social'
          DataBinding.FieldName = 'RAZSOC'
          Width = 292
        end
        object cxgDocsCLAFIS: TcxGridDBColumn
          Caption = 'CFOP'
          DataBinding.FieldName = 'CLAFIS'
          Width = 39
        end
        object cxgDocsVLRCON: TcxGridDBColumn
          Caption = 'Valor Contabil'
          DataBinding.FieldName = 'VLRCON'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 104
        end
      end
      object cxlDocs: TcxGridLevel
        GridView = cxgDocs
      end
    end
    object pnlErros: TPanel
      Left = 0
      Top = 370
      Width = 913
      Height = 45
      Align = alBottom
      ParentColor = True
      TabOrder = 2
      Visible = False
      ExplicitWidth = 932
      object memErro: TMemo
        Left = 1
        Top = 1
        Width = 911
        Height = 43
        Align = alClient
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitWidth = 930
        ExplicitHeight = 30
      end
    end
  end
  object dtsDados: TDataSource
    Left = 400
    Top = 232
  end
end
