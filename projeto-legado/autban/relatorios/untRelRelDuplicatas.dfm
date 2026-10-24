inherited frmRelRelDuplicatas: TfrmRelRelDuplicatas
  Left = 236
  Top = 212
  Width = 434
  Height = 161
  BorderStyle = bsNone
  Caption = 'frmRelRelDuplicatas'
  Position = poMainFormCenter
  ExplicitWidth = 434
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 434
    ExplicitTop = 119
    ExplicitWidth = 434
    inherited FlwBotoes: TFlowPanel
      Width = 353
      ExplicitWidth = 353
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Width = 81
        Align = alLeft
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 355
      ExplicitLeft = 355
    end
  end
  inherited pnlStatus: TPanel
    Top = 145
    Width = 434
    ExplicitTop = 145
    ExplicitWidth = 434
    inherited pnlNomeForm: TPanel
      Left = 283
      Width = 151
      ExplicitLeft = 283
      ExplicitWidth = 151
    end
    inherited pnlInfo: TPanel
      Width = 283
      ExplicitWidth = 283
    end
  end
  inherited pnlDados: TPanel
    Width = 434
    Height = 119
    BevelOuter = bvNone
    ExplicitWidth = 434
    ExplicitHeight = 119
    inherited gpbDestino: TGroupBox
      Enabled = False
      TabOrder = 1
      Visible = False
    end
    object pnlFundo: TPanel
      Left = 0
      Top = 0
      Width = 434
      Height = 119
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label5: TLabel
        Left = 24
        Top = 37
        Width = 35
        Height = 14
        Caption = 'Cliente:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 14
        Top = 57
        Width = 45
        Height = 14
        Caption = 'Empresa:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object pnlTopo: TPanel
        Left = 2
        Top = 2
        Width = 430
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Relat'#243'rio de Duplicatas'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 17
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object edtCliente: TEditFocus
        Tag = 99
        Left = 62
        Top = 35
        Width = 57
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnExit = edtClienteExit
        OnKeyPress = edtClienteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 62
        Top = 55
        Width = 57
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        OnExit = edtEmpresaExit
        OnKeyPress = edtEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCliente: TEdit
        Left = 120
        Top = 35
        Width = 309
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 3
      end
      object edtDesEmpresa: TEdit
        Left = 120
        Top = 55
        Width = 309
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 4
      end
      object ckbQbrEmp: TCheckBox
        Left = 14
        Top = 83
        Width = 131
        Height = 17
        Caption = 'Quebrar por Empresa'
        TabOrder = 5
      end
      object rdgOrdem: TRadioGroup
        Left = 142
        Top = 76
        Width = 199
        Height = 34
        Caption = 'Ordernar por'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'N'#186' Duplicata'
          'Cliente')
        TabOrder = 6
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 8
  end
  inherited frxDesigner: TfrxDesigner
    Left = 72
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 104
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 40
  end
  object qryDuplicatasSPC: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      '    CONCAT(CBI_NUMDUP, CBI_PARCEL) AS NUMDUP,'
      '    CBI_ESPDOC AS ESPDOC,'
      '    CBI_CODEMP AS CODEMP,'
      '    CBI_NOSNUM AS NOSNUM,'
      '    CBI_CODCLI AS CODCLI,'
      '    CLI_NOMCLI AS NOMCLI,'
      '    CLI_C_E_P_ AS C_E_P_,'
      '    CBI_DTACAD AS DTACAD,'
      '    CBI_DTAVEN AS DTAVEN,'
      '    CBI_CARTEI AS CARTEI,'
      
        '    ((IFNULL(CBI_VALDUP,0) * IFNULL(CBI_PORCEN,0)) /100) AS PORC' +
        'EN,'
      '    CBI_VALDUP AS VALDUP,'
      '    CBI_CODOCO AS CODOCO'
      '  , CBI_STSSER AS STATUS'
      '  , CBI_MOTSPC AS MOTIVOSPC'
      '  FROM'
      '    CADCBI'
      '    JOIN CADCLI ON CLI_CODCLI = CBI_CODCLI')
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 384
    Top = 48
    object qryDuplicatasSPCNUMDUP: TStringField
      FieldName = 'NUMDUP'
      OnGetText = qryDuplicatasSPCNUMDUPGetText
      Size = 15
    end
    object qryDuplicatasSPCESPDOC: TStringField
      FieldName = 'ESPDOC'
      Required = True
      FixedChar = True
      Size = 2
    end
    object qryDuplicatasSPCCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDuplicatasSPCNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryDuplicatasSPCCODCLI: TStringField
      FieldName = 'CODCLI'
      Required = True
      Size = 8
    end
    object qryDuplicatasSPCNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object qryDuplicatasSPCC_E_P_: TStringField
      FieldName = 'C_E_P_'
      Size = 9
    end
    object qryDuplicatasSPCDTACAD: TDateField
      FieldName = 'DTACAD'
    end
    object qryDuplicatasSPCDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryDuplicatasSPCCARTEI: TStringField
      FieldName = 'CARTEI'
      Size = 30
    end
    object qryDuplicatasSPCPORCEN: TFloatField
      FieldName = 'PORCEN'
    end
    object qryDuplicatasSPCVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryDuplicatasSPCCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 5
    end
    object qryDuplicatasSPCSTATUS: TStringField
      FieldName = 'STATUS'
      OnGetText = qryDuplicatasSPCSTATUSGetText
      FixedChar = True
      Size = 1
    end
    object qryDuplicatasSPCMOTIVOSPC: TStringField
      FieldName = 'MOTIVOSPC'
      Size = 3
    end
  end
  object frxDBDatasetSPC: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'ESPDOC=ESPDOC'
      'CODEMP=CODEMP'
      'NOSNUM=NOSNUM'
      'CODCLI=CODCLI'
      'NOMCLI=NOMCLI'
      'C_E_P_=C_E_P_'
      'DTACAD=DTACAD'
      'DTAVEN=DTAVEN'
      'CARTEI=CARTEI'
      'PORCEN=PORCEN'
      'VALDUP=VALDUP'
      'CODOCO=CODOCO'
      'STATUS=STATUS'
      'MOTIVOSPC=MOTIVOSPC')
    DataSet = qryDuplicatasSPC
    BCDToCurrency = False
    Left = 320
    Top = 56
  end
  object frxDuplicatasSPC: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44120.585101724540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 256
    Top = 56
    Datasets = <
      item
        DataSet = frxDBDatasetSPC
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 53.015770000000000000
        Top = 320.000000000000000000
        Width = 774.803650000000000000
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 438.501300000000000000
          Top = 4.779530000000022000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = -3.220470000000000000
          Width = 778.583180000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 676.535870000000000000
          Top = 5.559059999999988000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."VALDUP">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 423.383180000000000000
          Top = 34.015769999999970000
          Width = 351.420470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS:  [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.779530000000000000
          Top = 30.236240000000010000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.015769999999970000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 567.005320000000000000
          Top = 4.779530000000022000
          Width = 109.530550000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baRight
          Left = 483.855660000000000000
          Top = 4.779530000000022000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Duplicatas:')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 244.000000000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDatasetSPC
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 778.960659210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = cl3DLight
        end
        object frxDBDataset1CODEMP: TfrxMemoView
          Left = 116.504020000000000000
          Top = 1.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1CODFOR: TfrxMemoView
          Left = 145.401670000000000000
          Top = 1.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTACAD: TfrxMemoView
          Left = 435.866420000000000000
          Top = 1.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'DTACAD'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTAVEN: TfrxMemoView
          Left = 508.016080000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALDUP: TfrxMemoView
          Left = 584.827150000000000000
          Top = 1.000000000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NUMDUP: TfrxMemoView
          Left = 2.000000000000000000
          Top = 0.559059999999988100
          Width = 111.496070310000000000
          Height = 15.118120000000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALTOT: TfrxMemoView
          Left = 689.315400000000000000
          Top = 1.220470000000006000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataField = 'STATUS'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."STATUS"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NOMFOR: TfrxMemoView
          Left = 200.315090000000000000
          Top = 1.000000000000000000
          Width = 204.094620000000000000
          Height = 15.118120000000000000
          DataField = 'NOMCLI'
          DataSet = frxDBDatasetSPC
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 15.874015750000000000
        ParentFont = False
        Top = 208.000000000000000000
        Width = 774.803650000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 2.779530000000000000
          Top = 2.000000000000000000
          Width = 111.496058110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'No. DUPLICATA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 117.283550000000000000
          Top = 2.000000000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 144.740260000000000000
          Top = 2.000000000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 435.866420000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DATA CAD.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 509.913730000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DATA VEN.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 583.827150000000000000
          Top = 2.000000000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUPLICATA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 687.874460000000000000
          Top = 2.000000000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 199.196970000000000000
          Top = 2.000000000000000000
          Width = 204.094620000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 130.338590000000000000
        Top = 16.000000000000000000
        Width = 774.803650000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 186.066420000000000000
          Top = 23.440940000000000000
          Width = 402.670810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE DUPLICATAS PARA REMESSA')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 689.839890000000000000
          Top = 3.984230000000000000
          Width = 84.963760000000000000
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
        object Date: TfrxMemoView
          Left = 681.630490000000000000
          Top = 25.543290000000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 128.504020000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 187.011380000000000000
          Top = 3.779530000000001000
          Width = 400.780890000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Top = 79.370130000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Top = 99.047310000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 625.842920000000000000
          Top = 26.677180000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
      end
    end
  end
  object qryDuplicatas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      #9
      'SELECT'
      '    CONCAT(CBI_NUMDUP, CBI_PARCEL) AS NUMDUP,'
      '    CBI_ESPDOC AS ESPDOC,'
      '    CBI_CODEMP AS CODEMP,'
      '    CBI_NOSNUM AS NOSNUM,'
      '    CBI_CODCLI AS CODCLI,'
      '    CLI_NOMCLI AS NOMCLI,'
      '    CLI_C_E_P_ AS C_E_P_,'
      '    CBI_DTACAD AS DTACAD,'
      '    CBI_DTAVEN AS DTAVEN,'
      '    CBI_CARTEI AS CARTEI,'
      
        '    ((IFNULL(CBI_VALDUP,0) * IFNULL(CBI_PORCEN,0)) /100) AS PORC' +
        'EN,'
      '    CBI_VALDUP AS VALDUP,'
      '    CBI_CODOCO AS CODOCO'
      '  FROM'
      '    CADCBI'
      '    JOIN CADCLI ON CLI_CODCLI = CBI_CODCLI'#9)
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 384
    Top = 88
    object qryDuplicatasNUMDUP: TStringField
      FieldName = 'NUMDUP'
      OnGetText = qryDuplicatasNUMDUPGetText
      Size = 15
    end
    object qryDuplicatasESPDOC: TStringField
      FieldName = 'ESPDOC'
      Required = True
      FixedChar = True
      Size = 2
    end
    object qryDuplicatasCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDuplicatasNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryDuplicatasCODCLI: TStringField
      FieldName = 'CODCLI'
      Required = True
      Size = 8
    end
    object qryDuplicatasNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object qryDuplicatasC_E_P_: TStringField
      FieldName = 'C_E_P_'
      Size = 9
    end
    object qryDuplicatasDTACAD: TDateField
      FieldName = 'DTACAD'
    end
    object qryDuplicatasDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryDuplicatasCARTEI: TStringField
      FieldName = 'CARTEI'
      Size = 30
    end
    object qryDuplicatasPORCEN: TFloatField
      FieldName = 'PORCEN'
    end
    object qryDuplicatasVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryDuplicatasCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 5
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'ESPDOC=ESPDOC'
      'CODEMP=CODEMP'
      'NOSNUM=NOSNUM'
      'CODCLI=CODCLI'
      'NOMCLI=NOMCLI'
      'C_E_P_=C_E_P_'
      'DTACAD=DTACAD'
      'DTAVEN=DTAVEN'
      'CARTEI=CARTEI'
      'PORCEN=PORCEN'
      'VALDUP=VALDUP'
      'CODOCO=CODOCO')
    DataSet = qryDuplicatas
    BCDToCurrency = False
    Left = 328
    Top = 88
  end
  object frxDuplicatas: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44120.631044502300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 256
    Top = 88
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 3.968750000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 53.015770000000000000
        Top = 428.000000000000000000
        Width = 769.252465312500000000
        object Memo11: TfrxMemoView
          Align = baRight
          Left = 432.950115312500000000
          Top = 4.779530000000020000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Width = 768.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 670.984685312500000000
          Top = 5.559059999999990000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."VALDUP">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 417.831995312500000000
          Top = 34.015770000000000000
          Width = 351.420470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS:  [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 30.236240000000000000
          Width = 768.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.015770000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 584.131315312500000000
          Top = 4.779530000000020000
          Width = 86.853370000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baRight
          Left = 489.643065312500000000
          Top = 4.779530000000020000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Duplicatas:')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 296.000000000000000000
        Width = 769.252465312500000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 768.000000000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = cl3DLight
        end
        object frxDBDataset1CODEMP: TfrxMemoView
          Left = 121.063080000000000000
          Top = 1.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'CODEMP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1CODFOR: TfrxMemoView
          Left = 256.669450000000000000
          Top = 1.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CODCLI'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTACAD: TfrxMemoView
          Left = 478.220780000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'DTACAD'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTAVEN: TfrxMemoView
          Left = 536.811380000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALDUP: TfrxMemoView
          Left = 692.210000000000000000
          Top = 1.000000000000000000
          Width = 71.810000000000000000
          Height = 15.118120000000000000
          DataField = 'VALDUP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALTOT: TfrxMemoView
          Left = 596.386210000000000000
          Top = 1.220470000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'CARTEI'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset1."CARTEI"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NOMFOR: TfrxMemoView
          Left = 310.700990000000000000
          Top = 1.000000000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DataField = 'NOMCLI'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 421.748300000000000000
          Top = 1.000000000000000000
          Width = 54.000000000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."C_E_P_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 150.181200000000000000
          Top = 1.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'CODOCO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODOCO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 177.417440000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NUMDUP: TfrxMemoView
          Left = 0.999999999999999000
          Top = 0.559060000000000000
          Width = 119.055130310000000000
          Height = 15.118120000000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 145.456710000000000000
        Top = 16.000000000000000000
        Width = 769.252465312500000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 183.290827656250000000
          Top = 23.440940000000000000
          Width = 402.670810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE DUPLICATAS PARA REMESSA')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 684.288705312500000000
          Top = 3.984230000000000000
          Width = 84.963760000000000000
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
        object Date: TfrxMemoView
          Left = 677.630490000000000000
          Top = 25.543290000000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 144.000000000000000000
          Width = 768.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 184.235787656250000000
          Top = 3.779530000000000000
          Width = 400.780890000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Top = 109.559060000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Top = 128.456710000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 625.842920000000000000
          Top = 26.677180000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 91.488250000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[BANCO]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 18.897650000000000000
        Top = 256.000000000000000000
        Visible = False
        Width = 769.252465312500000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'true = true'
        object Memo26: TfrxMemoView
          Left = 257.228510000000000000
          Top = 2.559060000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 309.803340000000000000
          Top = 2.559060000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 422.189240000000000000
          Top = 2.559060000000000000
          Width = 54.000000000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 178.637910000000000000
          Top = 2.559060000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 3.559060000000000000
          Width = 119.055118110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'No. DUPLICATA')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 121.063080000000000000
          Top = 3.559060000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 478.441250000000000000
          Top = 2.559060000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT. CAD.')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 535.929500000000000000
          Top = 2.559060000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT. VEN.')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 693.213050000000000000
          Top = 2.559060000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUP.')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 593.945270000000000000
          Top = 2.559060000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CARTEIRA')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 150.063080000000000000
          Top = 3.338590000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'OCO')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 332.000000000000000000
        Width = 769.252465312500000000
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 455.627295312500000000
          Top = 3.779530000000020000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 670.984685312500000000
          Top = 4.559060000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."VALDUP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 584.131315312500000000
          Top = 3.779530000000000000
          Width = 86.853370000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baRight
          Left = 500.981655312500000000
          Top = 3.779530000000020000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Duplicatas:')
          ParentFont = False
        end
      end
      object HeaderFixo: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 15.118120000000000000
        Top = 220.000000000000000000
        Width = 769.252465312500000000
        object Memo8: TfrxMemoView
          Left = 257.228510000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 309.803340000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 422.189240000000000000
          Width = 54.000000000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 178.637910000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Top = 1.000000000000000000
          Width = 119.055118110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'No. DUPLICATA')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 121.063080000000000000
          Top = 1.000000000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 478.441250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT. CAD.')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 535.929500000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT. VEN.')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 693.213050000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUP.')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 593.945270000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CARTEIRA')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 150.063080000000000000
          Top = 0.779530000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'OCO')
          ParentFont = False
        end
      end
    end
  end
end
