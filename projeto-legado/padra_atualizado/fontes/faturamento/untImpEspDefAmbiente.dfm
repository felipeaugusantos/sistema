object frmImpEspDefAmbiente: TfrmImpEspDefAmbiente
  Left = 0
  Top = 0
  ClientHeight = 398
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 7
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 55
  end
  object frxDefAmbiente: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 45286.627958750000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '                                                   '
      'end.')
    OnUserFunction = frxDefAmbienteUserFunction
    Left = 49
    Top = 99
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxParcelas
        DataSetName = 'frxParcelas'
      end
      item
        DataSet = frxRodape
        DataSetName = 'frxRodape'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ImpressaoDefAmbiente: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 168.189010550000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.677179999999990000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.888463650000010000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Contato:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.099747299999990000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 101.669291340000100000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.700787400000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 431.307360000000000000
          Top = 80.311030940000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'I.E./R.G:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 431.307360000000000000
          Top = 101.733598240000100000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.622047240000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 83.488250000000000000
          Top = 24.677179999999990000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."CODCLI"] - [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 83.488250000000000000
          Top = 44.888463650000010000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 83.488250000000000000
          Top = 80.099747299999990000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 83.708720000000000000
          Top = 101.669291340000100000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 491.779840000000000000
          Top = 80.311030940000000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 491.779840000000000000
          Top = 101.733598240000100000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAICLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 84.488250000000000000
          Top = 122.834645670000100000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 83.488250000000000000
          Top = 143.622047240000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 431.307360000000000000
          Top = 122.834645670000100000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 491.779840000000000000
          Top = 122.834645669291000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CEPCLi"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 136.063080000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data do Or'#231'amento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 144.944960000000000000
          Top = 3.779529999999994000
          Width = 268.346630000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."DTADOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 431.086890000000000000
          Top = 143.622047240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fax:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 491.559370000000000000
          Top = 143.622047244095000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FAXCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baBottom
          Top = 168.189010550000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 483.779840000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object rlbCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Width = 166.299212600000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object rldValUni: TfrxMemoView
          Left = 546.228346460000000000
          Width = 83.149552600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValTot: TfrxMemoView
          Left = 631.181102362205100000
          Width = 86.929082600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 490.645669290000000000
          Width = 52.913312600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 367.338582680000000000
          Width = 90.708720000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 460.409448820000000000
          Width = 28.346451810000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
        end
        object rlbEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Width = 26.456678270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."ENTRET"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Width = 37.795268270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CLIBUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLote: TfrxMemoView
          Left = 287.354352680000000000
          Top = 0.000014650000025540
          Width = 78.236220470000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."NUMLOT"]')
          ParentFont = False
        end
      end
      object rlbCabEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 125.370130000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildDadosCliente
        PrintChildIfInvisible = True
        object mmoNumPag1: TfrxMemoView
          Left = 639.149970000000000000
          Top = 101.488250000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object imgLogo: TfrxPictureView
          Left = 7.559055120000000000
          Top = 24.220470000000000000
          Width = 230.551330000000000000
          Height = 68.031540000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 276.126160000000000000
          Top = 25.897650000000000000
          Width = 381.732530000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 7.559055120000000000
          Top = 3.779530000000001000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 254.448980000000000000
          Top = 58.913420000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 254.228510000000000000
          Top = 76.149660000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."CEPEMP"]  [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 101.488250000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  [frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baBottom
          Top = 125.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        Condition = 'frxItens."COMPLE"'
        object Memo35: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItens."COMPLE"]')
          ParentFont = False
          WordWrap = False
        end
        object Shape3: TfrxShapeView
          Left = 1.000000000000000000
          Top = 20.677180000000020000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = cl3DLight
        end
        object rllCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Top = 22.677165350000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Top = 22.677165350000000000
          Width = 166.299161340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 367.228510000000000000
          Top = 22.677165350000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 546.221185200000000000
          Top = 22.566943779999970000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit'#225'rio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 631.118835200000000000
          Top = 22.566943779999970000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Sub Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 460.393940000000000000
          Top = 22.677165354330730000
          Width = 28.346451810000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 490.764070000000000000
          Top = 22.677165354330730000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.677180000000020000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ent.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Top = 22.677180000000020000
          Width = 37.795268270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Busca')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLote: TfrxMemoView
          Left = 287.244280000000000000
          Top = 22.677180000000020000
          Width = 78.236220470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Sub. Total R$:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 1.000000000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildProposta: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.566870550000000000
        ParentFont = False
        Top = 793.701300000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildRodape
        PrintChildIfInvisible = True
        object rllDtaProTit: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Validade da Proposta:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaPro: TfrxMemoView
          Left = 169.740157480000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAVAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.251939210000000000
        ParentFont = False
        Top = 842.835190000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildVendedor
        PrintChildIfInvisible = True
        Stretched = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Forma de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 169.708720000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESCPG"] [frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.645688820000030000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Previs'#227'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.102398819999960000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 169.740157480000000000
          Top = 21.645688820000030000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAPRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 169.740157480000000000
          Top = 44.102398819999960000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."ENDENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTotal: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 748.346940000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildProposta
        PrintChildIfInvisible = True
        object Memo27: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral com Frete R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes) + <frxRodape."TOTFRE">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 702.992580000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildTotal
        PrintChildIfInvisible = True
        object Memo59: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Frete R$:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
      end
      object ChildMen002: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 1020.473100000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMensagemDoc
        PrintChildIfInvisible = True
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 2:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN002"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMen001: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 975.118740000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMen002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 1:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN001"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 929.764380000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMen001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."NOMPRO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMensagemDoc: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 23.456710000000000000
        ParentFont = False
        Top = 1065.827460000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem [TIPDOC]:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxRodape."MENDOC"]')
          ParentFont = False
        end
      end
      object FooterTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 566.929500000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildDesconto
        object Memo46: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total dos Produtos R$:')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 626.692923150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDesconto: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildValorGeral
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desconto R$:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."DESESP">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildValorGeral: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 657.638220000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildFrete
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787401570000000000
          Fill.BackColor = clWindow
        end
        object Memo51: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral R$:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779527584000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxCabecalho: TfrxDBDataset
    UserName = 'frxCabecalho'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 49
    Top = 152
  end
  object frxRodape: TfrxDBDataset
    UserName = 'frxRodape'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 49
    Top = 208
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 49
    Top = 264
  end
  object frxDefAmbiente_SemPreco: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 43948.476157627300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxDefAmbiente_SemPrecoUserFunction
    Left = 141
    Top = 75
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxRodape
        DataSetName = 'frxRodape'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ImpressaoDefAmbiente: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 168.189010550000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.677180000000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.888463650000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Contato:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.099747300000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 101.669291340000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.700787400000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 431.307360000000000000
          Top = 80.311030940000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'I.E./R.G:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 431.307360000000000000
          Top = 101.733598240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.622047240000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 83.488250000000000000
          Top = 24.677180000000000000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."CODCLI"] - [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 83.488250000000000000
          Top = 44.888463650000000000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 83.488250000000000000
          Top = 80.099747300000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 83.708720000000000000
          Top = 101.669291340000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 491.779840000000000000
          Top = 80.311030940000000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 491.779840000000000000
          Top = 101.733598240000000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAICLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 84.488250000000000000
          Top = 122.834645670000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 83.488250000000000000
          Top = 143.622047240000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 431.307360000000000000
          Top = 122.834645670000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 491.779840000000000000
          Top = 122.834645669291000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CEPCLi"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 136.063080000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data do Or'#231'amento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 144.944960000000000000
          Top = 3.779529999999990000
          Width = 268.346630000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."DTADOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 431.086890000000000000
          Top = 143.622047240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fax:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 491.559370000000000000
          Top = 143.622047244095000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FAXCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baBottom
          Top = 168.189010550000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 483.779840000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object rlbCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Width = 166.299212600000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 490.645669290000000000
          Width = 52.913312600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 367.338582680000000000
          Width = 90.708720000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 460.409448820000000000
          Width = 28.346451810000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
        end
        object rlbEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Width = 26.456678270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."ENTRET"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Width = 37.795268270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CLIBUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLote: TfrxMemoView
          Left = 287.354352680000000000
          Top = 0.000014650000025540
          Width = 78.236220470000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."NUMLOT"]')
          ParentFont = False
        end
      end
      object rlbCabEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 125.370130000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildDadosCliente
        PrintChildIfInvisible = True
        object mmoNumPag1: TfrxMemoView
          Left = 639.149970000000000000
          Top = 101.488250000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object imgLogo: TfrxPictureView
          Left = 7.559055120000000000
          Top = 24.220470000000000000
          Width = 230.551330000000000000
          Height = 68.031540000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 276.126160000000000000
          Top = 25.897650000000000000
          Width = 381.732530000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 7.559055120000000000
          Top = 3.779530000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 254.448980000000000000
          Top = 58.913420000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 254.228510000000000000
          Top = 76.149660000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."CEPEMP"]  [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 101.488250000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  [frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baBottom
          Top = 125.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        Condition = 'frxItens."COMPLE"'
        object Memo35: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItens."COMPLE"]')
          ParentFont = False
          WordWrap = False
        end
        object Shape3: TfrxShapeView
          Left = 1.000000000000000000
          Top = 20.677180000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = cl3DLight
        end
        object rllCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Top = 22.677165350000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Top = 22.677165350000000000
          Width = 166.299161340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 367.228510000000000000
          Top = 22.677165350000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 460.393940000000000000
          Top = 22.677165354330700000
          Width = 28.346451810000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 490.764070000000000000
          Top = 22.677165354330700000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.677180000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ent.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Top = 22.677180000000000000
          Width = 37.795268270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Busca')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLote: TfrxMemoView
          Left = 287.244280000000000000
          Top = 22.677180000000000000
          Width = 78.236220470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildProposta: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.566870550000000000
        ParentFont = False
        Top = 748.346940000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildRodape
        PrintChildIfInvisible = True
        object rllDtaProTit: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Validade da Proposta:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaPro: TfrxMemoView
          Left = 169.740157480000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAVAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.251939210000000000
        ParentFont = False
        Top = 797.480830000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildVendedor
        PrintChildIfInvisible = True
        Stretched = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Forma de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 169.708720000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESCPG"] [frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.645688820000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Previs'#227'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.102398820000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 169.740157480000000000
          Top = 21.645688820000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAPRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 169.740157480000000000
          Top = 44.102398820000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."ENDENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTotal: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 702.992580000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildProposta
        PrintChildIfInvisible = True
        object Memo27: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral com Frete R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999950000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes) + <frxRodape."TOTFRE">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 657.638220000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildTotal
        PrintChildIfInvisible = True
        object Memo59: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Frete R$:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
      end
      object ChildMen002: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 975.118740000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildMensagemDoc
        PrintChildIfInvisible = True
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 2:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN002"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMen001: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 929.764380000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildMen002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 1:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN001"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 884.410020000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildMen001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."NOMPRO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMensagemDoc: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 23.456710000000000000
        ParentFont = False
        Top = 1020.473100000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem [TIPDOC]:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxRodape."MENDOC"]')
          ParentFont = False
        end
      end
      object FooterTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildDesconto
        object Memo46: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999950000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total dos Produtos R$:')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 626.692923150000000000
          Top = 1.889763779999950000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDesconto: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 566.929500000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildValorGeral
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999950000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desconto R$:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."DESESP">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildValorGeral: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco.ChildFrete
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787401570000000000
          Fill.BackColor = clWindow
        end
        object Memo51: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral R$:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxExportaPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 172
    Top = 160
  end
  object frxParcelas: TfrxDBDataset
    UserName = 'frxParcelas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 129
    Top = 272
  end
  object frxDefAmbiente_SemPreco_Simplificado: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 43948.703724768520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxDefAmbiente_SemPreco_SimplificadoUserFunction
    Left = 301
    Top = 59
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxRodape
        DataSetName = 'frxRodape'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ImpressaoDefAmbiente: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 168.189010550000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.677180000000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.888463650000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Contato:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.099747300000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 101.669291340000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.700787400000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 431.307360000000000000
          Top = 80.311030940000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'I.E./R.G:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 431.307360000000000000
          Top = 101.733598240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.622047240000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 83.488250000000000000
          Top = 24.677180000000000000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."CODCLI"] - [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 83.488250000000000000
          Top = 44.888463650000000000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 83.488250000000000000
          Top = 80.099747300000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 83.708720000000000000
          Top = 101.669291340000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 491.779840000000000000
          Top = 80.311030940000000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 491.779840000000000000
          Top = 101.733598240000000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAICLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 84.488250000000000000
          Top = 122.834645670000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 83.488250000000000000
          Top = 143.622047240000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 431.307360000000000000
          Top = 122.834645670000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 491.779840000000000000
          Top = 122.834645669291000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CEPCLi"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999990000
          Width = 136.063080000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data do Or'#231'amento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 144.944960000000000000
          Top = 3.779529999999990000
          Width = 268.346630000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."DTADOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 431.086890000000000000
          Top = 143.622047240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fax:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 491.559370000000000000
          Top = 143.622047244095000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FAXCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baBottom
          Top = 168.189010550000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 442.205010000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object rlbCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Width = 166.299212600000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 490.645669290000000000
          Width = 52.913312600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 367.338582680000000000
          Width = 90.708720000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 460.409448820000000000
          Width = 28.346451810000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
        end
        object rlbEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Width = 26.456678270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."ENTRET"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Width = 37.795268270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CLIBUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLote: TfrxMemoView
          Left = 287.354352680000000000
          Top = 0.000014650000025540
          Width = 78.236220470000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."NUMLOT"]')
          ParentFont = False
        end
      end
      object rlbCabEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 125.370130000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildDadosCliente
        PrintChildIfInvisible = True
        object mmoNumPag1: TfrxMemoView
          Left = 639.149970000000000000
          Top = 101.488250000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object imgLogo: TfrxPictureView
          Left = 7.559055120000000000
          Top = 24.220470000000000000
          Width = 230.551330000000000000
          Height = 68.031540000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 276.126160000000000000
          Top = 25.897650000000000000
          Width = 381.732530000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 7.559055120000000000
          Top = 3.779530000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 254.448980000000000000
          Top = 58.913420000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 254.228510000000000000
          Top = 76.149660000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."CEPEMP"]  [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 101.488250000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  [frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baBottom
          Top = 125.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildProposta: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.566870550000000000
        ParentFont = False
        Top = 706.772110000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildRodape
        PrintChildIfInvisible = True
        object rllDtaProTit: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Validade da Proposta:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaPro: TfrxMemoView
          Left = 169.740157480000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAVAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.251939210000000000
        ParentFont = False
        Top = 755.906000000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildVendedor
        PrintChildIfInvisible = True
        Stretched = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Forma de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 169.708720000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESCPG"] [frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.645688820000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Previs'#227'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.102398820000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 169.740157480000000000
          Top = 21.645688820000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAPRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 169.740157480000000000
          Top = 44.102398820000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."ENDENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTotal: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 661.417750000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildProposta
        PrintChildIfInvisible = True
        object Memo27: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral com Frete R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999950000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes) + <frxRodape."TOTFRE">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 616.063390000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildTotal
        PrintChildIfInvisible = True
        object Memo59: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Frete R$:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
        object Shape3: TfrxShapeView
          Left = -3.779530000000000000
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = cl3DLight
        end
        object rllCodIte: TfrxMemoView
          Left = 67.779525120000000000
          Top = 5.779515350000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesIte: TfrxMemoView
          Left = 115.031493620000000000
          Top = 5.779515350000000000
          Width = 166.299161340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 362.448980000000000000
          Top = 5.779515350000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 455.614410000000000000
          Top = 5.779515350000000000
          Width = 28.346451810000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 485.984540000000000000
          Top = 5.779515350000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut: TfrxMemoView
          Left = -1.000000000000000000
          Top = 5.779530000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ent.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliBus: TfrxMemoView
          Left = 28.236240000000000000
          Top = 5.779530000000000000
          Width = 37.795268270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Busca')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLote: TfrxMemoView
          Left = 282.464750000000000000
          Top = 5.779530000000000000
          Width = 78.236220470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMen002: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 933.543910000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildMensagemDoc
        PrintChildIfInvisible = True
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 2:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN002"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMen001: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 888.189550000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildMen002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 1:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN001"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 842.835190000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildMen001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."NOMPRO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMensagemDoc: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 23.456710000000000000
        ParentFont = False
        Top = 978.898270000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000021900
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem [TIPDOC]:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000021900
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxRodape."MENDOC"]')
          ParentFont = False
        end
      end
      object FooterTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 480.000310000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildDesconto
        object Memo46: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999950000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total dos Produtos R$:')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 626.692923150000000000
          Top = 1.889763779999950000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDesconto: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 525.354670000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildValorGeral
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999950000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desconto R$:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."DESESP">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildValorGeral: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 570.709030000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente_SemPreco_Simplificado.ChildFrete
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787401570000000000
          Fill.BackColor = clWindow
        end
        object Memo51: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527580000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral R$:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779527580000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTITE">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object frxDefAmbienteSeparacao: TfrxReport
      Version = '5.6.11'
      DotMatrixReport = False
      IniFile = '\Software\Fast Reports'
      PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
      PreviewOptions.Zoom = 1.000000000000000000
      PrintOptions.Printer = 'Default'
      PrintOptions.PrintOnSheet = 0
      ReportOptions.CreateDate = 40324.349252384300000000
      ReportOptions.LastChange = 43536.420968194440000000
      ScriptLanguage = 'PascalScript'
      ScriptText.Strings = (
        'begin'
        '                                                   '
        'end.')
      OnUserFunction = frxDefAmbienteUserFunction
      Left = 249
      Top = 219
      Datasets = <
        item
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
        end
        item
          DataSet = frxItens
          DataSetName = 'frxItens'
        end
        item
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
        end
        item
          DataSet = frxRodape
          DataSetName = 'frxRodape'
        end>
      Variables = <>
      Style = <>
      object Data: TfrxDataPage
        Height = 1000.000000000000000000
        Width = 1000.000000000000000000
      end
      object ImpressaoDefAmbiente: TfrxReportPage
        PaperWidth = 210.000000000000000000
        PaperHeight = 297.000000000000000000
        PaperSize = 9
        LeftMargin = 10.000000000000000000
        RightMargin = 10.000000000000000000
        TopMargin = 10.000000000000000000
        BottomMargin = 10.000000000000000000
        LargeDesignHeight = True
        object ChildDadosCliente: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 168.189010550000000000
          ParentFont = False
          Top = 204.094620000000000000
          Width = 718.110700000000000000
          PrintChildIfInvisible = True
          object Memo3: TfrxMemoView
            Left = 3.779530000000000000
            Top = 24.677179999999990000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            DisplayFormat.DecimalSeparator = ','
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Cliente:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo4: TfrxMemoView
            Left = 3.779530000000000000
            Top = 44.888463650000010000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Contato:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo5: TfrxMemoView
            Left = 3.779530000000000000
            Top = 80.099747299999990000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'CNPJ/CPF:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo6: TfrxMemoView
            Left = 3.779530000000000000
            Top = 101.669291340000100000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Endere'#231'o:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo8: TfrxMemoView
            Left = 3.779530000000000000
            Top = 122.700787400000000000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Cidade:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo11: TfrxMemoView
            Left = 431.307360000000000000
            Top = 80.311030940000000000
            Width = 56.692950000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'I.E./R.G:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo12: TfrxMemoView
            Left = 431.307360000000000000
            Top = 101.733598240000100000
            Width = 56.692950000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Bairro:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo13: TfrxMemoView
            Left = 3.779530000000000000
            Top = 143.622047240000000000
            Width = 75.590600000000000000
            Height = 18.897640240000000000
            DisplayFormat.DecimalSeparator = ','
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Fone:')
            ParentFont = False
            VAlign = vaCenter
          end
          object frxCadSepfrxCadSep1: TfrxMemoView
            Left = 83.488250000000000000
            Top = 24.677179999999990000
            Width = 627.401980000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              '[frxCabecalho."CODCLI"] - [frxCabecalho."NOMCLI"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
            Formats = <
              item
              end
              item
              end>
          end
          object Memo14: TfrxMemoView
            Left = 83.488250000000000000
            Top = 44.888463650000010000
            Width = 627.401980000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."CONCLI"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo15: TfrxMemoView
            Left = 83.488250000000000000
            Top = 80.099747299999990000
            Width = 340.157700000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."CPFCGC"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo16: TfrxMemoView
            Left = 83.708720000000000000
            Top = 101.669291340000100000
            Width = 340.157700000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."ENDCLI"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo18: TfrxMemoView
            Left = 491.779840000000000000
            Top = 80.311030940000000000
            Width = 219.212740000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."RG_IE_"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo20: TfrxMemoView
            Left = 491.779840000000000000
            Top = 101.733598240000100000
            Width = 219.212740000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."BAICLI"]')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo22: TfrxMemoView
            Left = 84.488250000000000000
            Top = 122.834645670000100000
            Width = 340.157700000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."CIDCLI"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo23: TfrxMemoView
            Left = 83.488250000000000000
            Top = 143.622047240000000000
            Width = 340.157700000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."FONCLI"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object qrlConPag: TfrxMemoView
            Left = 431.307360000000000000
            Top = 122.834645670000100000
            Width = 56.692950000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Cep:')
            ParentFont = False
            VAlign = vaCenter
          end
          object qrdConPag: TfrxMemoView
            Left = 491.779840000000000000
            Top = 122.834645669291000000
            Width = 219.212740000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."CEPCLi"]')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo30: TfrxMemoView
            Left = 3.779530000000000000
            Top = 3.779529999999994000
            Width = 136.063080000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Data do Or'#231'amento:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo31: TfrxMemoView
            Left = 144.944960000000000000
            Top = 3.779529999999994000
            Width = 268.346630000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."DTADOC"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo7: TfrxMemoView
            Left = 431.086890000000000000
            Top = 143.622047240000000000
            Width = 56.692950000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Fax:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo9: TfrxMemoView
            Left = 491.559370000000000000
            Top = 143.622047244095000000
            Width = 219.212740000000000000
            Height = 18.897640240000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxCabecalho."FAXCLI"]')
            ParentFont = False
            VAlign = vaCenter
          end
          object Line1: TfrxLineView
            Align = baBottom
            Top = 168.189010550000000000
            Width = 718.110700000000000000
            Color = clBlack
            Frame.Typ = [ftTop]
          end
        end
        object rlbDetalhes: TfrxMasterData
          FillType = ftBrush
          Height = 14.362204720000000000
          Top = 483.779840000000000000
          Width = 718.110700000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          RowCount = 0
          Stretched = True
          object rlbCodIte: TfrxMemoView
            Left = 72.559055120000000000
            Width = 45.354360000000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."CODITE"]')
            ParentFont = False
            WordWrap = False
          end
          object rlbDesIte: TfrxMemoView
            Left = 119.811023620000000000
            Width = 166.299212600000000000
            Height = 13.228346460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."DESITE"]')
            ParentFont = False
          end
          object rldValUni: TfrxMemoView
            Left = 546.228346460000000000
            Width = 83.149552600000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haRight
            Memo.UTF8W = (
              '[frxItens."VALITE"]')
            ParentFont = False
            WordWrap = False
          end
          object rldValTot: TfrxMemoView
            Left = 631.181102360000000000
            Width = 86.929082600000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haRight
            Memo.UTF8W = (
              '[frxItens."TOTRES"]')
            ParentFont = False
            WordWrap = False
          end
          object Memo38: TfrxMemoView
            Left = 490.645669290000000000
            Width = 52.913312600000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haRight
            Memo.UTF8W = (
              '[frxItens."QTDRES"]')
            ParentFont = False
            WordWrap = False
          end
          object Memo40: TfrxMemoView
            Left = 367.338582680000000000
            Width = 90.708720000000000000
            Height = 13.228346460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."DESMAR"]')
            ParentFont = False
          end
          object Memo41: TfrxMemoView
            Left = 460.409448820000000000
            Width = 28.346451810000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."UNIDAD"]')
            ParentFont = False
          end
          object rlbEntFut: TfrxMemoView
            Left = 3.779530000000000000
            Width = 26.456678270000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."ENTRET"]')
            ParentFont = False
            WordWrap = False
          end
          object rlbCliBus: TfrxMemoView
            Left = 33.015770000000000000
            Width = 37.795268270000000000
            Height = 13.228346460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."CLIBUS"]')
            ParentFont = False
            WordWrap = False
          end
          object rlbLote: TfrxMemoView
            Left = 287.354352680000000000
            Top = 0.000014650000025540
            Width = 78.236220470000000000
            Height = 13.228346460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxItens."NUMLOT"]')
            ParentFont = False
          end
        end
        object rlbCabEmpresa: TfrxPageHeader
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Height = 125.370130000000000000
          ParentFont = False
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildDadosCliente
          PrintChildIfInvisible = True
          object mmoNumPag1: TfrxMemoView
            Left = 639.149970000000000000
            Top = 101.488250000000000000
            Width = 71.811070000000000000
            Height = 15.118120000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Pagina: [Page] / [TotalPages#]')
            ParentFont = False
            WordWrap = False
          end
          object imgLogo: TfrxPictureView
            Left = 7.559055120000000000
            Top = 24.220470000000000000
            Width = 230.551330000000000000
            Height = 68.031540000000000000
            Center = True
            KeepAspectRatio = False
            HightQuality = True
            Transparent = False
            TransparentColor = clWhite
          end
          object Memo1: TfrxMemoView
            Left = 276.126160000000000000
            Top = 25.897650000000000000
            Width = 381.732530000000000000
            Height = 30.236240000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haCenter
            Memo.UTF8W = (
              '[TIPDOC]')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo2: TfrxMemoView
            Left = 7.559055120000000000
            Top = 3.779530000000001000
            Width = 230.551330000000000000
            Height = 15.118120000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              '[NUMDOC]')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo24: TfrxMemoView
            Left = 254.448980000000000000
            Top = 58.913420000000000000
            Width = 445.984540000000000000
            Height = 15.118120000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haCenter
            Memo.UTF8W = (
              '[frxCabecalho."ENDEMP"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo25: TfrxMemoView
            Left = 254.228510000000000000
            Top = 76.149660000000000000
            Width = 445.984540000000000000
            Height = 15.118120000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haCenter
            Memo.UTF8W = (
              '[frxCabecalho."CEPEMP"]  [frxCabecalho."CIDEMP"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo26: TfrxMemoView
            Left = 7.559060000000000000
            Top = 101.488250000000000000
            Width = 230.551330000000000000
            Height = 15.118120000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Fone:  [frxCabecalho."FONEMP"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Line3: TfrxLineView
            Align = baBottom
            Top = 125.370130000000000000
            Width = 718.110700000000000000
            Color = clBlack
            Frame.Typ = [ftTop]
          end
        end
        object rlbGrupo: TfrxGroupHeader
          FillType = ftBrush
          Height = 35.905511810000000000
          Top = 423.307360000000000000
          Width = 718.110700000000000000
          Condition = 'frxItens."COMPLE"'
          object Memo35: TfrxMemoView
            Left = 3.779527560000000000
            Top = 1.000000000000000000
            Width = 706.772110000000000000
            Height = 18.897650000000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              '[frxItens."COMPLE"]')
            ParentFont = False
            WordWrap = False
          end
          object Shape3: TfrxShapeView
            Left = 1.000000000000000000
            Top = 20.677180000000020000
            Width = 718.110700000000000000
            Height = 15.118120000000000000
            Fill.BackColor = cl3DLight
          end
          object rllCodIte: TfrxMemoView
            Left = 72.559055120000000000
            Top = 22.677165350000000000
            Width = 45.354360000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'C'#243'digo')
            ParentFont = False
            VAlign = vaCenter
          end
          object rllDesIte: TfrxMemoView
            Left = 119.811023620000000000
            Top = 22.677165350000000000
            Width = 166.299161340000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Descri'#231#227'o')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo54: TfrxMemoView
            Left = 367.228510000000000000
            Top = 22.677165350000000000
            Width = 90.708720000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Marca')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo55: TfrxMemoView
            Left = 546.221185200000000000
            Top = 22.566943779999970000
            Width = 83.149660000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Pre'#231'o Unit'#225'rio')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo56: TfrxMemoView
            Left = 631.118835200000000000
            Top = 22.566943779999970000
            Width = 86.929190000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Sub Total')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo57: TfrxMemoView
            Left = 460.393940000000000000
            Top = 22.677165354330730000
            Width = 28.346451810000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'UN')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo58: TfrxMemoView
            Left = 490.764070000000000000
            Top = 22.677165354330730000
            Width = 52.913420000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Qtde.')
            ParentFont = False
            VAlign = vaCenter
          end
          object rllEntFut: TfrxMemoView
            Left = 3.779530000000000000
            Top = 22.677180000000020000
            Width = 26.456710000000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Ent.')
            ParentFont = False
            VAlign = vaCenter
          end
          object rllCliBus: TfrxMemoView
            Left = 33.015770000000000000
            Top = 22.677180000000020000
            Width = 37.795268270000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Busca')
            ParentFont = False
            VAlign = vaCenter
          end
          object rllLote: TfrxMemoView
            Left = 287.244280000000000000
            Top = 22.677180000000020000
            Width = 78.236220470000000000
            Height = 11.338590000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Memo.UTF8W = (
              'Lote')
            ParentFont = False
            VAlign = vaCenter
          end
        end
        object rlbFooter: TfrxGroupFooter
          FillType = ftBrush
          Height = 20.787401570000000000
          Top = 521.575140000000000000
          Width = 718.110700000000000000
          object Memo36: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779527584000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Sub. Total R$:')
            ParentFont = False
          end
          object Memo39: TfrxMemoView
            Left = 626.645669290000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              '[SUM(<frxItens."TOTRES">, rlbDetalhes)]')
            ParentFont = False
            WordWrap = False
          end
          object Line2: TfrxLineView
            Left = 1.000000000000000000
            Width = 714.331170000000000000
            Color = clBlack
            Frame.Typ = [ftTop]
          end
        end
        object ChildProposta: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 24.566870550000000000
          ParentFont = False
          Top = 793.701300000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildRodape
          PrintChildIfInvisible = True
          object rllDtaProTit: TfrxMemoView
            Left = 3.779530000000000000
            Width = 162.519790000000000000
            Height = 22.677180000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Validade da Proposta:')
            ParentFont = False
            VAlign = vaCenter
          end
          object rllDtaPro: TfrxMemoView
            Left = 169.740157480000000000
            Width = 279.685220000000000000
            Height = 22.677180000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."DTAVAL"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
        end
        object ChildRodape: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 64.251939210000000000
          ParentFont = False
          Top = 842.835190000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildVendedor
          PrintChildIfInvisible = True
          Stretched = True
          object Memo42: TfrxMemoView
            Left = 3.779530000000000000
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Forma de Pagamento:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo43: TfrxMemoView
            Left = 169.708720000000000000
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."DESCPG"] [frxRodape."DESFPG"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo44: TfrxMemoView
            Left = 3.779530000000000000
            Top = 21.645688820000030000
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Previs'#227'o de Entrega:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo45: TfrxMemoView
            Left = 3.779530000000000000
            Top = 44.102398819999960000
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Endere'#231'o de Entrega:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo47: TfrxMemoView
            Left = 169.740157480000000000
            Top = 21.645688820000030000
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."DTAPRE"]')
            ParentFont = False
            WordWrap = False
            VAlign = vaCenter
          end
          object Memo48: TfrxMemoView
            Left = 169.740157480000000000
            Top = 44.102398819999960000
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            StretchMode = smMaxHeight
            DataSetName = 'frxCadSep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."ENDENT"]')
            ParentFont = False
            VAlign = vaCenter
          end
        end
        object ChildTotal: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 20.787401570000000000
          ParentFont = False
          Top = 748.346940000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildProposta
          PrintChildIfInvisible = True
          object Memo27: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779527584000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Valor Geral com Frete R$:')
            ParentFont = False
          end
          object Memo50: TfrxMemoView
            Left = 626.574803150000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              
                '[SUM(<frxItens."TOTRES">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
                ', rlbDetalhes) + <frxRodape."TOTFRE">]')
            ParentFont = False
            WordWrap = False
          end
        end
        object ChildFrete: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 20.787401570000000000
          ParentFont = False
          Top = 702.992580000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildTotal
          PrintChildIfInvisible = True
          object Memo59: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779527584000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Valor Frete R$:')
            ParentFont = False
          end
          object Memo60: TfrxMemoView
            Left = 626.574803150000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              '[frxRodape."TOTFRE"]')
            ParentFont = False
            WordWrap = False
          end
        end
        object Header1: TfrxHeader
          FillType = ftBrush
          Height = 3.779530000000000000
          Top = 396.850650000000000000
          Width = 718.110700000000000000
        end
        object ChildMen002: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 22.677165350000000000
          ParentFont = False
          Top = 1020.473100000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildMensagemDoc
          PrintChildIfInvisible = True
          Stretched = True
          object Memo69: TfrxMemoView
            Left = 3.779530000000000000
            Top = 0.779530000000022500
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Mensagem 2:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo70: TfrxMemoView
            Left = 169.740157480000000000
            Top = 0.779530000000022500
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            StretchMode = smMaxHeight
            DataSetName = 'frxCadSep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."MEN002"]')
            ParentFont = False
            VAlign = vaCenter
          end
        end
        object ChildMen001: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 22.677165350000000000
          ParentFont = False
          Top = 975.118740000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildMen002
          PrintChildIfInvisible = True
          Stretched = True
          object Memo10: TfrxMemoView
            Left = 3.779530000000000000
            Top = 0.779530000000022500
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Mensagem 1:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo17: TfrxMemoView
            Left = 169.740157480000000000
            Top = 0.779530000000022500
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            StretchMode = smMaxHeight
            DataSetName = 'frxCadSep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."MEN001"]')
            ParentFont = False
            VAlign = vaCenter
          end
        end
        object ChildVendedor: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 22.677165350000000000
          ParentFont = False
          Top = 929.764380000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildMen001
          PrintChildIfInvisible = True
          Stretched = True
          object Memo19: TfrxMemoView
            Left = 3.779530000000000000
            Top = 0.779530000000022500
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Vendedor:')
            ParentFont = False
            VAlign = vaCenter
          end
          object Memo21: TfrxMemoView
            Left = 169.740157480000000000
            Top = 0.779530000000022500
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            StretchMode = smMaxHeight
            DataSetName = 'frxCadSep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Memo.UTF8W = (
              '[frxRodape."NOMPRO"]')
            ParentFont = False
            VAlign = vaCenter
          end
        end
        object ChildMensagemDoc: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 23.456710000000000000
          ParentFont = False
          Top = 1065.827460000000000000
          Width = 718.110700000000000000
          PrintChildIfInvisible = True
          Stretched = True
          object Memo34: TfrxMemoView
            Left = 3.779530000000000000
            Top = 0.779530000000022500
            Width = 162.519790000000000000
            Height = 18.897650000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Mensagem [TIPDOC]:')
            ParentFont = False
          end
          object Memo37: TfrxMemoView
            Left = 169.740157480000000000
            Top = 0.779530000000022500
            Width = 540.472790000000000000
            Height = 18.897650000000000000
            StretchMode = smMaxHeight
            DataSetName = 'frxCadSep'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            HAlign = haBlock
            Memo.UTF8W = (
              '[frxRodape."MENDOC"]')
            ParentFont = False
          end
        end
        object FooterTotalProdutos: TfrxFooter
          FillType = ftBrush
          Height = 20.787401570000000000
          Top = 566.929500000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildDesconto
          object Memo46: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779999953000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Total dos Produtos R$:')
            ParentFont = False
          end
          object Memo49: TfrxMemoView
            Left = 626.692923150000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              '[SUM(<frxItens."TOTRES">, rlbDetalhes)]')
            ParentFont = False
            WordWrap = False
          end
        end
        object ChildDesconto: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 20.787401570000000000
          ParentFont = False
          Top = 612.283860000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildValorGeral
          PrintChildIfInvisible = True
          object Memo32: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779999953000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Desconto R$:')
            ParentFont = False
          end
          object Memo33: TfrxMemoView
            Left = 626.645669290000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              '[SUM(<frxItens."DESESP">, rlbDetalhes)]')
            ParentFont = False
            WordWrap = False
          end
        end
        object ChildValorGeral: TfrxChild
          FillType = ftBrush
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Height = 20.787401570000000000
          ParentFont = False
          Top = 657.638220000000000000
          Width = 718.110700000000000000
          Child = frxDefAmbiente.ChildFrete
          PrintChildIfInvisible = True
          object Shape1: TfrxShapeView
            Align = baClient
            Width = 718.110700000000000000
            Height = 20.787401570000000000
            Fill.BackColor = clWindow
          end
          object Memo51: TfrxMemoView
            Left = 443.645669290000000000
            Top = 1.889763779527584000
            Width = 181.417322830000000000
            Height = 17.007876460000000000
            StretchMode = smMaxHeight
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              'Valor Geral R$:')
            ParentFont = False
          end
          object Memo52: TfrxMemoView
            Left = 626.645669290000000000
            Top = 1.889763780000000000
            Width = 90.708612600000000000
            Height = 17.007876460000000000
            DataSet = frxRelatorio
            DataSetName = 'frxRelatorio'
            DisplayFormat.DecimalSeparator = ','
            DisplayFormat.FormatStr = '%2.2n'
            DisplayFormat.Kind = fkNumeric
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HAlign = haRight
            Memo.UTF8W = (
              
                '[SUM(<frxItens."TOTRES">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
                ', rlbDetalhes)]')
            ParentFont = False
            WordWrap = False
          end
        end
      end
    end
  end
  object frxDefAmbienteSeparacao: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 43536.420968194440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '                                                   '
      'end.')
    OnUserFunction = frxDefAmbienteUserFunction
    Left = 281
    Top = 187
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxParcelas
        DataSetName = 'frxParcelas'
      end
      item
        DataSet = frxRodape
        DataSetName = 'frxRodape'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ImpressaoDefAmbiente: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 168.189010550000000000
        ParentFont = False
        Top = 204.094620000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.677179999999990000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.888463650000010000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Contato:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 80.099747300000030000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 101.669291340000100000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 122.700787400000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 431.307360000000000000
          Top = 80.311030939999990000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'I.E./R.G:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 431.307360000000000000
          Top = 101.733598240000100000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.622047240000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 83.488250000000000000
          Top = 24.677179999999990000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."CODCLI"] - [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 83.488250000000000000
          Top = 44.888463650000010000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 83.488250000000000000
          Top = 80.099747300000030000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 83.708720000000000000
          Top = 101.669291340000100000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 491.779840000000000000
          Top = 80.311030939999990000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 491.779840000000000000
          Top = 101.733598240000100000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAICLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 84.488250000000000000
          Top = 122.834645670000100000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 83.488250000000000000
          Top = 143.622047240000000000
          Width = 340.157700000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 431.307360000000000000
          Top = 122.834645670000100000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 491.779840000000000000
          Top = 122.834645669291000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CEPCLi"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 136.063080000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data do Or'#231'amento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 144.944960000000000000
          Top = 3.779529999999994000
          Width = 268.346630000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."DTADOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 431.086890000000000000
          Top = 143.622047240000000000
          Width = 56.692950000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Fax:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 491.559370000000000000
          Top = 143.622047244095000000
          Width = 219.212740000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FAXCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baBottom
          Top = 168.189010550000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 483.779840000000000000
        Width = 718.110700000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object rlbCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Width = 166.299212600000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
        end
        object rldValUni: TfrxMemoView
          Left = 546.228346460000000000
          Width = 83.149552600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValTot: TfrxMemoView
          Left = 631.181102360000000000
          Width = 86.929082600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTRES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 490.645669290000000000
          Width = 52.913312600000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDRES"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 367.338582680000000000
          Width = 90.708720000000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 460.409448820000000000
          Width = 28.346451810000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
        end
        object rlbEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Width = 26.456678270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."ENTRET"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Width = 37.795268270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CLIBUS"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLote: TfrxMemoView
          Left = 287.354352680000000000
          Top = 0.000014650000025540
          Width = 78.236220470000000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."NUMLOT"]')
          ParentFont = False
        end
      end
      object rlbCabEmpresa: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 125.370130000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildDadosCliente
        PrintChildIfInvisible = True
        object mmoNumPag1: TfrxMemoView
          Left = 639.149970000000000000
          Top = 101.488250000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
        object imgLogo: TfrxPictureView
          Left = 7.559055120000000000
          Top = 24.220470000000000000
          Width = 230.551330000000000000
          Height = 68.031540000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 276.126160000000000000
          Top = 25.897650000000000000
          Width = 381.732530000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 7.559055120000000000
          Top = 3.779530000000001000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 254.448980000000000000
          Top = 58.913420000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 254.228510000000000000
          Top = 76.149660000000000000
          Width = 445.984540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."CEPEMP"]  [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 101.488250000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  [frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Align = baBottom
          Top = 125.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        Condition = 'frxItens."COMPLE"'
        object Memo35: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItens."COMPLE"]')
          ParentFont = False
          WordWrap = False
        end
        object Shape3: TfrxShapeView
          Left = 1.000000000000000000
          Top = 20.677180000000020000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Fill.BackColor = cl3DLight
        end
        object rllCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Top = 22.677165350000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesIte: TfrxMemoView
          Left = 119.811023620000000000
          Top = 22.677165350000000000
          Width = 166.299161340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 367.228510000000000000
          Top = 22.677165350000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 546.221185200000000000
          Top = 22.566943779999970000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit'#225'rio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 631.118835200000000000
          Top = 22.566943779999970000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Sub Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 460.393940000000000000
          Top = 22.677165354330730000
          Width = 28.346451810000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 490.764070000000000000
          Top = 22.677165354330730000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.677180000000020000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ent.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliBus: TfrxMemoView
          Left = 33.015770000000000000
          Top = 22.677180000000020000
          Width = 37.795268270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Busca')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLote: TfrxMemoView
          Left = 287.244280000000000000
          Top = 22.677180000000020000
          Width = 78.236220470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Sub. Total R$:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTRES">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Left = 1.000000000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildProposta: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.566870550000000000
        ParentFont = False
        Top = 793.701300000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildRodape
        PrintChildIfInvisible = True
        object rllDtaProTit: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Validade da Proposta:')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaPro: TfrxMemoView
          Left = 169.740157480000000000
          Width = 279.685220000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAVAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.251939210000000000
        ParentFont = False
        Top = 842.835190000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildVendedor
        PrintChildIfInvisible = True
        Stretched = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Forma de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 169.708720000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESCPG"] [frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.645688820000030000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Previs'#227'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.102398819999960000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Endere'#231'o de Entrega:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 169.740157480000000000
          Top = 21.645688820000030000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DTAPRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 169.740157480000000000
          Top = 44.102398819999960000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."ENDENT"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildTotal: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 748.346940000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildProposta
        PrintChildIfInvisible = True
        object Memo27: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral com Frete R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTRES">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes) + <frxRodape."TOTFRE">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildFrete: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 702.992580000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildTotal
        PrintChildIfInvisible = True
        object Memo59: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Frete R$:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 626.574803150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
      end
      object ChildMen002: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 1020.473100000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMensagemDoc
        PrintChildIfInvisible = True
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 2:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN002"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMen001: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 975.118740000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMen002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem 1:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."MEN001"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildVendedor: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 929.764380000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildMen001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."NOMPRO"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildMensagemDoc: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 23.456710000000000000
        ParentFont = False
        Top = 1065.827460000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mensagem [TIPDOC]:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 169.740157480000000000
          Top = 0.779530000000022500
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxCadSep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxRodape."MENDOC"]')
          ParentFont = False
        end
      end
      object FooterTotalProdutos: TfrxFooter
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 566.929500000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildDesconto
        object Memo46: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total dos Produtos R$:')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 626.692923150000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTRES">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildDesconto: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildValorGeral
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desconto R$:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."DESESP">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ChildValorGeral: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 657.638220000000000000
        Width = 718.110700000000000000
        Child = frxDefAmbiente.ChildFrete
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787401570000000000
          Fill.BackColor = clWindow
        end
        object Memo51: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Geral R$:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 626.645669290000000000
          Top = 1.889763779999953000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxItens."TOTRES">, rlbDetalhes) - SUM(<frxItens."DESESP">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxResumo: TfrxDBDataset
    UserName = 'frxResumo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 129
    Top = 216
  end
  object frxDefAmbiente_Referencia: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45146.414351006950000000
    ReportOptions.LastChange = 45146.414351006950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 216
    Top = 288
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_CodigoFabricaMarca: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45146.414416944450000000
    ReportOptions.LastChange = 45146.414416944450000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 312
    Top = 248
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_CodigoFabrica: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45146.414481215280000000
    ReportOptions.LastChange = 45146.414481215280000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 304
    Top = 128
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_ReferenciaMarca: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45146.414557418980000000
    ReportOptions.LastChange = 45146.414557418980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 312
    Datasets = <>
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
    end
  end
  object frxDefAmbiente_CodigoFabrica_FF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45147.657348807870000000
    ReportOptions.LastChange = 45147.657348807870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 160
    Top = 8
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_CodigoFabricaMarca_FF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45147.657458067130000000
    ReportOptions.LastChange = 45147.657458067130000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 16
    Top = 48
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_Referencia_FF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45147.657528321760000000
    ReportOptions.LastChange = 45147.657528321760000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 224
    Top = 48
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDefAmbiente_ReferenciaMarca_FF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45147.657586944440000000
    ReportOptions.LastChange = 45147.657586944440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 344
    Top = 16
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxFaltas: TfrxDBDataset
    UserName = 'frxFaltas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 192
    Top = 232
  end
  object frxItensCortados: TfrxDBDataset
    UserName = 'frxItensCortados'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 249
    Top = 338
  end
  object frxPedidoCortado: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 46101.466847337960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Line> mod 2 = 0) then'
      
        '    shpDetItem.Color := clSilver                                ' +
        '                         '
      '  else'
      '    shpDetItem.Color := clWhite;  '
      'end;'
      ''
      
        'procedure rlbdtItensCortadosOnBeforePrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      '  if (<Line> mod 2 = 0) then'
      
        '    shpDetItensCortados.Color := clSilver                       ' +
        '                        '
      '  else'
      '    shpDetItensCortados.Color := clWhite;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxDefAmbienteUserFunction
    Left = 329
    Top = 307
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxItensCortados
        DataSetName = 'frxItensCortados'
      end
      item
        DataSet = frxParcelas
        DataSetName = 'frxParcelas'
      end
      item
        DataSet = frxRodape
        DataSetName = 'frxRodape'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object ImpressaoDefAmbiente: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.Width = 3.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 175.748070550000000000
        ParentFont = False
        Top = 151.181200000000000000
        Width = 1046.929810000000000000
        PrintChildIfInvisible = True
        object Memo3: TfrxMemoView
          Left = 3.779527560000000000
          Top = 28.220470000000000000
          Width = 52.913420000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 3.779527560000000000
          Top = 96.115517300000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 3.779527560000000000
          Top = 61.669291340000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 3.779527560000000000
          Top = 78.700787400000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Munic'#237'pio:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 515.866420000000000000
          Top = 96.000000000000000000
          Width = 52.913385830000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.E./R.G:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 515.866420000000000000
          Top = 61.606299210000000000
          Width = 52.913385830000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 515.425196850000000000
          Top = 44.976377950000000000
          Width = 52.913385830000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxCadSepfrxCadSep1: TfrxMemoView
          Left = 572.457020000000000000
          Top = 28.346456690000000000
          Width = 272.126018430000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CODCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 139.842519690000000000
          Top = 96.141788430000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 139.842519690000000000
          Top = 61.669291340000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 572.496062990000000000
          Top = 96.000000000000000000
          Width = 472.440944881890000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 572.496062990000000000
          Top = 61.606299210000000000
          Width = 472.440944880000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."BAICLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 139.842519690000000000
          Top = 78.834645670000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 572.496062990000000000
          Top = 44.976377950000000000
          Width = 472.440944881890000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object qrlConPag: TfrxMemoView
          Left = 515.866420000000000000
          Top = 78.614173228346500000
          Width = 52.913385830000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cep:')
          ParentFont = False
          VAlign = vaCenter
        end
        object qrdConPag: TfrxMemoView
          Left = 572.496062990000000000
          Top = 78.614173230000000000
          Width = 472.440944880000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CEPCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 3.779527560000000000
          Top = 146.433210000000000000
          Width = 120.944960000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Forma de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 139.842519690000000000
          Top = 146.567068270000000000
          Width = 366.614173228346000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."CODFPG"] - [frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Left = 3.779527560000000000
          Top = 15.338590000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pedido de Venda [NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 851.008191340000000000
          Top = 113.007874020000000000
          Width = 192.755888430000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."DTADOC"]      [frxCabecalho."HORDOC"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Align = baCenter
          Left = 421.417595000000000000
          Width = 204.094620000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '**IMPRESSO SEM VALIDADE FISCAL**')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 139.842519690000000000
          Top = 28.354360000000000000
          Width = 366.614136610000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 3.779527560000000000
          Top = 44.811070000000000000
          Width = 52.913420000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fantasia:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 139.842519690000000000
          Top = 44.811070000000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."FANSOB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 3.779527560000000000
          Top = 113.078850000000000000
          Width = 132.283550000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Condi'#231#227'o de Pagamento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 139.740157480000000000
          Top = 129.637795280000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."CODCND"] - [frxRodape."DESCPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo52: TfrxMemoView
          Left = 139.842519690000000000
          Top = 113.007874020000000000
          Width = 366.614173230000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CONPA2"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo77: TfrxMemoView
          Left = 515.425480000000000000
          Top = 28.346456690000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo78: TfrxMemoView
          Left = 767.858690000000000000
          Top = 113.007874015748000000
          Width = 79.370095830000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data Emiss'#227'o:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Left = 853.410020000000000000
          Top = 28.346456690000000000
          Width = 158.740118430000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[REIMPRDESC]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.141734720000000000
        Top = 430.866420000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object shpDetItem: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 18.141734720000000000
        end
        object rlbCodIte: TfrxMemoView
          Left = 3.779527559055120000
          Width = 45.354330710000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbDesIte: TfrxMemoView
          Left = 52.913385826771700000
          Width = 313.700787401575000000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"] / [frxItens."REFERE"]')
          ParentFont = False
        end
        object rldValUni: TfrxMemoView
          Left = 642.141732283465000000
          Width = 68.031496062992100000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rldValTot: TfrxMemoView
          Left = 993.259842519685000000
          Width = 49.133858270000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 578.267716535433000000
          Width = 60.472440944881900000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 495.496062992126000000
          Width = 79.370078740157500000
          Height = 13.228346460000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 368.881889763780000000
          Width = 28.346456692913400000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
        end
        object rlbEntFut: TfrxMemoView
          Left = 401.385826771654000000
          Width = 90.708661417322800000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbCliBus: TfrxMemoView
          Left = 786.519685039370000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALIPI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 715.086614173228000000
          Width = 66.897637800000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALRET"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 855.307086614173000000
          Width = 55.559055120000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."VALFCP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 914.267716535433000000
          Width = 74.456692910000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTIMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCabEmpresa: TfrxPageHeader
        FillType = ftBrush
        Frame.Width = 10.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 110.252010000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxPedidoCortado.ChildDadosCliente
        PrintChildIfInvisible = True
        object imgLogo: TfrxPictureView
          Left = 3.559055120000000000
          Top = 21.543290000000000000
          Width = 230.551330000000000000
          Height = 79.370130000000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo24: TfrxMemoView
          Left = 245.669291340000000000
          Top = 16.118120000000000000
          Width = 461.102362200000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 245.669291340000000000
          Top = 31.913420000000000000
          Width = 461.102362200000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CIDEMP"] - CEP: [frxCabecalho."CEPEMP"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo26: TfrxMemoView
          Left = 245.669291340000000000
          Top = 84.370130000000000000
          Width = 234.330562200000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  [frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo1: TfrxMemoView
          Left = 245.669291340000000000
          Width = 461.102660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."NOMEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 245.669291340000000000
          Top = 48.031540000000000000
          Width = 234.330708661417300000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:  [frxCabecalho."CGCEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Line6: TfrxLineView
          Top = 107.504020000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo73: TfrxMemoView
          Left = 969.339210000000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page] / [TotalPages#]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo75: TfrxMemoView
          Left = 525.354330708661400000
          Top = 48.000000000000000000
          Width = 158.740118430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxCabecalho."IE_EMP"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Left = 525.354670000000000000
          Top = 84.283464570000000000
          Width = 181.417298430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fax: [frxCabecalho."EMPFAX"] ')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.007861810000000000
        Top = 389.291590000000000000
        Width = 1046.929810000000000000
        Condition = 'frxItens."CORTPR"'
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 17.007861810000000000
          Fill.BackColor = clSilver
        end
        object rllCodIte: TfrxMemoView
          Left = 3.850335120000000000
          Top = 1.889763780000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDesIte: TfrxMemoView
          Left = 53.102303620000000000
          Top = 1.889763780000000000
          Width = 309.921301340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o / Refer'#234'ncia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 495.409710000000000000
          Top = 1.889763780000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 642.300035200000000000
          Top = 1.889763780000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vlr. Unit.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 993.276535200000000000
          Top = 1.889763780000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlt.Total')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 369.023810000000000000
          Top = 1.889763780000000000
          Width = 28.346451810000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 578.283860000000000000
          Top = 1.889763780000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtd.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllEntFut: TfrxMemoView
          Left = 786.512370000000000000
          Top = 1.889763780000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vlr. Init. IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllCliBus: TfrxMemoView
          Left = 401.307360000000000000
          Top = 1.889763780000000000
          Width = 90.708688270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd. F'#225'brica')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllLote: TfrxMemoView
          Left = 715.110700000000000000
          Top = 1.889763780000000000
          Width = 66.897630470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vlr. Unit. ST')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 855.276130000000000000
          Top = 1.889763780000000000
          Width = 55.559040470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Difal+FCP')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 914.410020000000000000
          Top = 1.889763780000000000
          Width = 74.456690470000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vlr.Unit.+Imp.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Left = 50.913420000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 366.614410000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 399.630180000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 494.118430000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 577.268090000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 641.520100000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 712.331170000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 783.803650000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 853.394250000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 913.646260000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 992.236860000000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 135.000004890000000000
        Top = 472.441250000000000000
        Width = 1046.929810000000000000
        Child = frxPedidoCortado.ChildRodapeDados
        object Memo19: TfrxMemoView
          Left = 3.779527560000000000
          Top = 93.748019290000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 62.811070000000000000
          Top = 93.748019290000000000
          Width = 978.898270000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."CODVEN"] - [frxCabecalho."NOMVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 1.000000000000000000
          Width = 1046.929133858270000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 39.779530000000000000
          Width = 68.031540000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor Bruto:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 189.740260000000000000
          Top = 39.779530000000000000
          Width = 83.149660000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor do Frete:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 60.795300000000000000
          Width = 98.267780000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valores Impostos:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 885.071430000000000000
          Top = 39.779527560000000000
          Width = 83.149660000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Produtos:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 870.677377720000000000
          Top = 60.944881890000000000
          Width = 98.267780000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total(Prod + Imp):')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 79.370130000000000000
          Top = 39.779527560000000000
          Width = 98.267780000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTPRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 272.889920000000000000
          Top = 39.779530000000000000
          Width = 117.165430000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 395.071120000000000000
          Top = 39.779527560000000000
          Width = 480.000310000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESFRE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 968.559680000000000000
          Top = 39.779527560000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTPRO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 968.204936770000000000
          Top = 60.944881890000000000
          Width = 75.590600000000000000
          Height = 18.897640240000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."VLRCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 103.606370000000000000
          Top = 60.944881890000000000
          Width = 752.126470000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'ST: [frxRodape."TOTRET"]  IPI: [frxRodape."TOTIPI"]  FCP: [frxRo' +
              'dape."TOTFCP"]  DIFAL: [frxRodape."TDPORI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end>
        end
        object Line1: TfrxLineView
          Top = 85.133890000000000000
          Width = 1046.929133860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo48: TfrxMemoView
          Left = 3.779530000000000000
          Top = 112.149660000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Digitador:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 62.740157480000000000
          Top = 112.322834650000000000
          Width = 978.898270000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."NOMDIG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Top = 34.015770000000000000
          Width = 1046.929133860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
      object ChildRodapeDados: TfrxChild
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 631.181510000000000000
        Width = 1046.929810000000000000
        object Memo53: TfrxMemoView
          Left = 3.779527560000000000
          Top = 24.236240000000000000
          Width = 1039.370750000000000000
          Height = 49.133880240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DUPALF"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcelas:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbghItensCortados: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 729.449290000000000000
        Width = 1046.929810000000000000
        Condition = 'frxItensCortados."NUMDOC"'
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 34.015770000000000000
          Fill.BackColor = clSilver
        end
        object Memo60: TfrxMemoView
          Align = baCenter
          Left = 432.756185000000000000
          Width = 181.417440000000000000
          Height = 18.897640240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE ITENS CORTADOS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 3.779527560000000000
          Top = 18.897650000000000000
          Width = 86.929031340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Left = 118.944960000000000000
          Top = 18.897637800000000000
          Width = 548.031691340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o / Refer'#234'ncia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 703.992580000000000000
          Top = 18.897637800000000000
          Width = 52.913261340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 807.260360000000000000
          Top = 18.897637800000000000
          Width = 75.590551180000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Unit.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 929.984850000000000000
          Top = 18.897637800000000000
          Width = 75.590441340000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Total')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbdtItensCortados: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 786.142240000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'rlbdtItensCortadosOnBeforePrint'
        DataSet = frxItensCortados
        DataSetName = 'frxItensCortados'
        RowCount = 0
        object shpDetItensCortados: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
        end
        object Memo66: TfrxMemoView
          Left = 3.779527560000000000
          Width = 86.929133858267700000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensCortados."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          Left = 119.055118110236000000
          Width = 548.031496062992000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItensCortados."DESITE"] \ [frxItensCortados."REFERE"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo68: TfrxMemoView
          Left = 704.125984251969000000
          Width = 52.913385830000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensCortados."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 807.307086614173000000
          Width = 75.590551181102400000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensCortados."UNITAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo70: TfrxMemoView
          Left = 930.141732280000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItensCortados."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbgfItensCortados: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 823.937540000000000000
        Width = 1046.929810000000000000
        object Memo71: TfrxMemoView
          Left = 807.307086614173000000
          Width = 75.590551181102400000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Left = 930.141732283465000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItensCortados."TOTITE">, rlbdtItensCortados)]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxServicos: TfrxDBDataset
    UserName = 'frxServicos'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 145
    Top = 344
  end
end
