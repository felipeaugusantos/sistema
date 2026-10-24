inherited frmCadEnqVsPeriodoApuracaoCat42: TfrmCadEnqVsPeriodoApuracaoCat42
  Width = 264
  Height = 397
  Caption = 'Enquadramento Vs Per'#237'odo Apura'#231#227'o'
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 264
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 324
    Width = 258
    inherited btnSair: TBitBtn
      Left = 201
      Top = 2
      Width = 55
      Height = 24
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 160
      ExplicitTop = 2
      ExplicitWidth = 55
      ExplicitHeight = 24
    end
    object btnEnquadramentoVsPeriodoApuracao: TBitBtn
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = 'Gerar'
      TabOrder = 0
      OnClick = btnEnquadramentoVsPeriodoApuracaoClick
    end
    object btnImprimir: TBitBtn
      Left = 79
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = 'Imprimir'
      Enabled = False
      TabOrder = 2
      OnClick = btnImprimirClick
      ExplicitLeft = 77
      ExplicitTop = -2
    end
  end
  inherited pnlStatus: TPanel
    Top = 352
    Width = 258
    inherited pnlNomeForm: TPanel
      Left = 87
    end
    inherited pnlInfo: TPanel
      Width = 87
      inherited btnShowTrace: TSpeedButton
        Left = 85
      end
      inherited btnHideTrace: TSpeedButton
        Left = 85
      end
    end
  end
  object pnlData: TPanel [2]
    Left = 0
    Top = 0
    Width = 258
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 217
    object Label6: TLabel
      Left = 111
      Top = 6
      Width = 51
      Height = 14
      Caption = 'Data Final'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 11
      Top = 6
      Width = 57
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mskDtaIni: TDateEditFocus
      Left = 11
      Top = 21
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000010744558745469746C650053686F7274446174653B1563
        49AA0000024549444154785E858F4B4815611CC57FDFDC6961E42670D532089F
        58046297D27C54BE6E98216218489B84566D432228085AB5A86DDB82C2ECDA0B
        CB4893308848ED610F888828C8552A5DE77BFCFBE6CEE546167598C36F1673CE
        997F38D59B994C4183730EE78498E26DBD5D6C9BBC4B4CEF55631FF53D7ED22A
        221140182A1A2A0EB48324619C052B3863106BC1DB1A4F6F671C33D9F15D408A
        82422792FF30F7FE4D526093D5382C9E2E61DEA90DA58808802A1688135C1461
        E34593FCBE185B60A12CB6B328AD3DD714CCF69C61475F2DA54E40401479E229
        2214250A150837AFCCC2CCF65F05C638002E5D7D4A7BE3166E3D5CA073773963
        0F5ED3D55441F6FE4BF6B756313AFE82A387EAD1C692A8586000A1CD8745A0A3
        B11C27E24B2AF2EC6AA9C47A66F654E5A9B5FDFD04AD1D4E606CE255B2E81987
        B2F7E6C9B456FBE579BAF7D63072678EA181F45F0A8C01113A7CD80A74365722
        0E322DD5A402457F662B018EC3DDB5381B5157530650A294CA0126D49145801B
        7EA9CB87B29E19BF387A778E819E6D7CB87E9C70E92D228008A502D367D35F23
        EDA69B4FCEB4F8130C020CF6D623220CF6D5038A23FD6952A2F9FEEE19FB4E5D
        0301942444B83D7C70271086CBCBCB5327CE4D3400C515215153DD2602E3D08B
        CFB12B5F504188384DAAA40C6B1C40105E38DDDD06AC0302D6E83CAC1F3D56FD
        D92C7DF2250BC5F570E366AC1100158AC80FC0FB4F29A5B4D50E3139C41A0014
        023A87D51680907FCB7E5B5C99BC3C7CB131B94E207930A8A918FF2B8886463E
        B6174E5400050AA081D59F60347B4CBF5714C50000000049454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.ImeName = 'Portugu'#234's (Brasil ABNT)'
      Properties.MinDate = 2.000000000000000000
      Properties.PostPopupValueOnTab = True
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Width = 95
    end
    object mskDtaFin: TDateEditFocus
      Left = 111
      Top = 21
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000010744558745469746C650053686F7274446174653B1563
        49AA0000024549444154785E858F4B4815611CC57FDFDC6961E42670D532089F
        58046297D27C54BE6E98216218489B84566D432228085AB5A86DDB82C2ECDA0B
        CB4893308848ED610F888828C8552A5DE77BFCFBE6CEE546167598C36F1673CE
        997F38D59B994C4183730EE78498E26DBD5D6C9BBC4B4CEF55631FF53D7ED22A
        221140182A1A2A0EB48324619C052B3863106BC1DB1A4F6F671C33D9F15D408A
        82422792FF30F7FE4D526093D5382C9E2E61DEA90DA58808802A1688135C1461
        E34593FCBE185B60A12CB6B328AD3DD714CCF69C61475F2DA54E40401479E229
        2214250A150837AFCCC2CCF65F05C638002E5D7D4A7BE3166E3D5CA073773963
        0F5ED3D55441F6FE4BF6B756313AFE82A387EAD1C692A8586000A1CD8745A0A3
        B11C27E24B2AF2EC6AA9C47A66F654E5A9B5FDFD04AD1D4E606CE255B2E81987
        B2F7E6C9B456FBE579BAF7D63072678EA181F45F0A8C01113A7CD80A74365722
        0E322DD5A402457F662B018EC3DDB5381B5157530650A294CA0126D49145801B
        7EA9CB87B29E19BF387A778E819E6D7CB87E9C70E92D228008A502D367D35F23
        EDA69B4FCEB4F8130C020CF6D623220CF6D5038A23FD6952A2F9FEEE19FB4E5D
        0301942444B83D7C70271086CBCBCB5327CE4D3400C515215153DD2602E3D08B
        CFB12B5F504188384DAAA40C6B1C40105E38DDDD06AC0302D6E83CAC1F3D56FD
        D92C7DF2250BC5F570E366AC1100158AC80FC0FB4F29A5B4D50E3139C41A0014
        023A87D51680907FCB7E5B5C99BC3C7CB131B94E207930A8A918FF2B8886463E
        B6174E5400050AA081D59F60347B4CBF5714C50000000049454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.ImeName = 'Portugu'#234's (Brasil ABNT)'
      Properties.MinDate = 2.000000000000000000
      Properties.PostPopupValueOnTab = True
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Width = 95
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 49
    Width = 258
    Height = 24
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Enquadramento Vs Per'#237'odo Apura'#231#227'o'
    TabOrder = 3
    ExplicitWidth = 217
  end
  object pnlLista: TPanel [4]
    Left = 0
    Top = 73
    Width = 258
    Height = 251
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitLeft = 48
    ExplicitTop = 112
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbGrdLista_: TDBGrid
      Left = 0
      Top = 0
      Width = 258
      Height = 217
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'CFOP'
          Title.Caption = 'CFOPs'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = 14
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = []
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CST'
          Title.Caption = 'CSTs'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = 14
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = []
          Width = 38
          Visible = True
        end>
    end
    object pnlInformacao: TPanel
      Left = 0
      Top = 234
      Width = 258
      Height = 17
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitTop = 196
      ExplicitWidth = 217
    end
    object pgInformacao: TProgressBar
      Left = 0
      Top = 217
      Width = 258
      Height = 17
      Align = alBottom
      TabOrder = 2
      Visible = False
      ExplicitLeft = 112
      ExplicitTop = 112
      ExplicitWidth = 150
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 40
    Top = 104
  end
  object cdsLista: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 109
    Top = 104
    object cdsListaCFOP: TStringField
      FieldName = 'CFOP'
      Size = 8
    end
    object cdsListaCST: TStringField
      FieldName = 'CST'
      Size = 4
    end
  end
  object dtsLista: TDataSource
    Left = 141
    Top = 101
  end
  object qryLista: TUniQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM CADEMP')
    Constraints = <>
    Left = 173
    Top = 101
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41857.418912731480000000
    ReportOptions.LastChange = 44223.468234027780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    rllZebra.Visible := not rllZebra.Visible;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 76
    Top = 180
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 84.984230000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = -15.722510000000000000
          Top = 21.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 885.542980000000000000
          Top = 21.000000000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 935.281570000000000000
          Top = 38.000000000000000000
          Width = 46.563760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 804.661100000000000000
          Top = 38.000000000000000000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 55.823964999999990000
          Top = 38.000000000000000000
          Width = 606.462770000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 23.697959999999980000
          Top = 52.913420000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = -15.722510000000000000
          Top = 2.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 3.338590000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFOPs')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 90.708720000000000000
          Top = 2.779529999999994000
          Width = 56.692950000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CSTs')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object frxRelatorio_CFOPS: TfrxMemoView
          Left = 3.401574800000000000
          Top = 3.779529999999994000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          DataField = 'CFOP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CFOP"]')
          ParentFont = False
        end
        object frxRelatorio_CSTS: TfrxMemoView
          Left = 90.708720000000000000
          Top = 3.779529999999994000
          Width = 56.692901180000000000
          Height = 18.897650000000000000
          DataField = 'CST'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CST"]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CFOP=CFOP'
      'CST=CST')
    DataSet = cdsLista
    BCDToCurrency = False
    Left = 149
    Top = 187
  end
end
