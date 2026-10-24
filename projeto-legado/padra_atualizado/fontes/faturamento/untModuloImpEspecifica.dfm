object frmModuloImpEspecifica: TfrmModuloImpEspecifica
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 300
  Width = 433
  object frxCabecalho: TfrxDBDataset
    UserName = 'frxCabecalho'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 16
  end
  object frxRodape: TfrxDBDataset
    UserName = 'frxRodape'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 72
  end
  object frxImpressaoDelLama: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40324.349252384300000000
    ReportOptions.LastChange = 41597.552822256900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '                                                   '
      'end.')
    Left = 80
    Top = 16
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
    object ImpressaoDelLama: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ChildDadosCliente: TfrxChild
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 83.488250000000000000
          Top = 44.888463650000010000
          Width = 627.401980000000000000
          Height = 18.897640240000000000
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Width = 245.669291340000000000
          Height = 13.228346460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Width = 83.149552600000010000
          Height = 13.228346460000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
      end
      object rlbCabEmpresa: TfrxPageHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 125.370130000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildDadosCliente
        PrintChildIfInvisible = True
        object mmoNumPag1: TfrxMemoView
          Left = 639.149970000000000000
          Top = 101.488250000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          ShowHint = False
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
          Left = 7.559055118110240000
          Top = 24.220470000000000000
          Width = 230.551330000000000000
          Height = 68.031540000000000000
          ShowHint = False
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
          ShowHint = False
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
          Left = 7.559055118110240000
          Top = 3.779530000000001000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbGrupo: TfrxGroupHeader
        Height = 35.905511810000000000
        Top = 423.307360000000000000
        Width = 718.110700000000000000
        Condition = 'frxItens."ITEVID"'
        object Memo35: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItens."ITEVID"]')
          ParentFont = False
          WordWrap = False
        end
        object Shape3: TfrxShapeView
          Left = 1.000000000000000000
          Top = 20.677180000000020000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          ShowHint = False
          Color = cl3DLight
        end
        object rllCodIte: TfrxMemoView
          Left = 72.559055120000000000
          Top = 22.677165350000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          ShowHint = False
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
          Width = 245.669291340000000000
          Height = 11.338590000000000000
          ShowHint = False
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
          Top = 22.677165354330730000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
      end
      object rlbFooter: TfrxGroupFooter
        Height = 20.787401570000000000
        Top = 521.575140000000000000
        Width = 718.110700000000000000
        object Memo36: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Top = 1.889763779527584000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Align = baClient
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object ChildProposta: TfrxChild
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.566870550000000000
        ParentFont = False
        Top = 793.701300000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildRodape
        PrintChildIfInvisible = True
        object rllDtaProTit: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 22.677180000000000000
          ShowHint = False
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
          ShowHint = False
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 64.251939210000000000
        ParentFont = False
        Top = 842.835190000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildVendedor
        PrintChildIfInvisible = True
        Stretched = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
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
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRodape."DESFPG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.645688820000030000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401574803100000
        ParentFont = False
        Top = 748.346940000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildProposta
        PrintChildIfInvisible = True
        object Memo27: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Top = 1.889763779527584000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 702.992580000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildTotal
        PrintChildIfInvisible = True
        object Memo59: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Top = 1.889763779527584000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
        Height = 3.779530000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
      end
      object ChildMen002: TfrxChild
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 1020.473100000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildMensagemDoc
        PrintChildIfInvisible = True
        Stretched = True
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
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
          ShowHint = False
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 975.118740000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildMen002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
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
          ShowHint = False
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677165350000000000
        ParentFont = False
        Top = 929.764380000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildMen001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
          ShowHint = False
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
        Height = 20.787401570000000000
        Top = 566.929500000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildDesconto
        object Memo46: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 612.283860000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildValorGeral
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779999953000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          Top = 1.889763779527584000
          Width = 90.708612600000000000
          Height = 17.007876460000000000
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787401570000000000
        ParentFont = False
        Top = 657.638220000000000000
        Width = 718.110700000000000000
        Child = frxImpressaoDelLama.ChildFrete
        PrintChildIfInvisible = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 20.787401570000000000
          ShowHint = False
          Color = clWindow
        end
        object Memo51: TfrxMemoView
          Left = 443.645669290000000000
          Top = 1.889763779527584000
          Width = 181.417322830000000000
          Height = 17.007876460000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frmQckHTMLCliente.frxRelatorio
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
          ShowHint = False
          DataSet = frmQckHTMLCliente.frxRelatorio
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
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 136
  end
  object frxImpressaoJvVidrosOR_PD_M: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41779.552893831000000000
    ReportOptions.LastChange = 41782.470287569440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If rlbSumario.Height > Engine.FreeSpace Then'
      '    Engine.NewPage;'
      '  '
      
        '  Engine.CurY := Engine.CurY + Engine.FreeSpace - rlbSumario.Hei' +
        'ght - 1;  '
      'end;'
      ''
      'procedure rlbGrupoFooterOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CDespesasViagem.Visible := rlbDetalhes.DataSet.Eof;           ' +
        '       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxImpressaoJvVidrosOR_PD_MUserFunction
    Left = 80
    Top = 72
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
    object Page1: TfrxDMPPage
      PaperWidth = 358.139768701399400000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        Height = 221.000000000000000000
        Top = 17.000000000000000000
        Width = 1353.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo22: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Endereco: [frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAIEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cidade..: [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cep...: [frxCabecalho."CEPEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estado: [frxCabecalho."ESTEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[frxCabecalho."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cliente..: [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Endereco.: [frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Municipio: [frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'CGC/CPF..: [frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cnd. Pgto: [frxCabecalho."CNDPGT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 119.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Codigo: [frxCabecalho."CODCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 136.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAICLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 153.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'C.E.P.: [frxCabecalho."CEPCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 170.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'IE/RG.: [frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 187.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Fone..: [frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#64#27#67#65#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 96.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#18#27#80#27#87#49'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 374.400000000000000000
          Top = 34.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#87#48#15#27#80'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 1267.200000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#18#27#80#27#87#49'
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 374.400000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#87#48#15#27#80'
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1353.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo8: TfrxDMPMemoView
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'REFERENCIA - DESCRICAO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllComiss1: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'ALTURA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'LARGURA')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'AREA (M2)')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.UNITAR')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.TOTAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        Height = 34.000000000000000000
        Top = 323.000000000000000000
        Width = 1353.600000000000000000
        Condition = 'frxItens."ID_VID"'
        object DMPMemo52: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 921.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."ITEVID"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 17.000000000000000000
        Top = 374.000000000000000000
        Width = 1353.600000000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDLAR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDALT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDMT2"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fFormatFloat(<frxItens."VALITE">)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbGrupoFooter: TfrxGroupFooter
        Height = 68.000000000000000000
        Top = 408.000000000000000000
        Width = 1353.600000000000000000
        OnBeforePrint = 'rlbGrupoFooterOnBeforePrint'
        Child = frxImpressaoJvVidrosOR_PD_M.CDespesasViagem
        object DMPMemo18: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUB-TOTAL:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTGER">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'PARCIAL:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo63: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo64: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'N'#176' DE VEZES:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDVID"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        Height = 221.000000000000000000
        Top = 527.000000000000000000
        Width = 1353.600000000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object DMPMemo37: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL FRETE:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DESCONTO:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRodape."TOTDOC"> + <frxRodape."DESACE">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."TOTFRE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."DESESP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxRodape."TOTDOC"> - <frxRodape."DESESP"> + <frxRodape."TOTFR' +
              'E"> + <frxRodape."DESACE">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 1036.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Vendedor....: [frxRodape."NOMVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 1036.800000000000000000
          Height = 34.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            'Mensagem....: [frxRodape."MENSAG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 1036.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Arquiteto...: [frxRodape."NOMPRO"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 102.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA.: [frxRodape."DTADOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 119.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'HORA.:   [frxRodape."HORDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 153.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."PERCOM"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 153.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEntrega: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          FontStyle = []
          Memo.UTF8W = (
            'End.Entrega.: [frxRodape."ENDENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CDespesasViagem: TfrxChild
        Top = 493.000000000000000000
        Width = 1353.600000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object rllDespesasViagem: TfrxDMPMemoView
          Align = baClient
          Width = 1353.600000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          HAlign = haCenter
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 243
    Top = 196
  end
  object frxImpressaoJvVidrosOR_PD_J: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41779.552893831000000000
    ReportOptions.LastChange = 41899.597778912040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If rlbSumario.Height > Engine.FreeSpace Then'
      '    Engine.NewPage;'
      '  '
      
        '  Engine.CurY := Engine.CurY + Engine.FreeSpace - rlbSumario.Hei' +
        'ght - 1;  '
      'end;'
      ''
      'procedure rlbGrupoFooterOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CDespesasViagem.Visible := rlbDetalhes.DataSet.Eof;           ' +
        '                   '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxImpressaoJvVidrosOR_PD_MUserFunction
    Left = 80
    Top = 128
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
    object Page1: TfrxReportPage
      PaperWidth = 337.800000000000000000
      PaperHeight = 287.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Height = 240.000002440000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1201.134634000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 19.653897000000000000
          Top = 1.000000000000000000
          Width = 1161.826840000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Align = baCenter
          Left = 19.653897000000000000
          Top = 23.000000000000000000
          Width = 1161.826840000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 1.889763780000000000
          Top = 50.000000000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 726.727520000000000000
          Top = 50.000000000000000000
          Width = 328.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAIEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 1.889763780000000000
          Top = 73.000000000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade..: [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 726.727520000000000000
          Top = 73.000000000000000000
          Width = 328.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [frxCabecalho."CEPEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 1062.466110000000000000
          Top = 73.000000000000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estado: [frxCabecalho."ESTEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 1.889763780000000000
          Top = 98.500000000000000000
          Width = 1195.086580000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo30: TfrxMemoView
          Left = 1.889763780000000000
          Top = 101.000000000000000000
          Width = 1193.045640000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 1.889763780000000000
          Top = 129.385826770000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente..: [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 1.889763780000000000
          Top = 151.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o.: [frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 1.889763780000000000
          Top = 173.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 1.889763780000000000
          Top = 195.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC/CPF..: [frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 1.889763780000000000
          Top = 217.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cnd. Pgto: [frxCabecalho."CNDPGT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 726.727520000000000000
          Top = 129.338590000000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxCabecalho."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 726.727520000000000000
          Top = 151.661417320000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAICLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 726.727520000000000000
          Top = 173.700787400000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.: [frxCabecalho."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 726.727520000000000000
          Top = 195.622047240000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE/RG.: [frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 726.727520000000000000
          Top = 217.732283460000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone..: [frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 1062.466110000000000000
          Top = 50.000000000000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        Height = 18.881880000000000000
        Top = 321.260050000000000000
        Width = 1201.134634000000000000
        ReprintOnNewPage = True
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 18.881880000000000000
          ShowHint = False
          Color = clSilver
        end
        object Memo8: TfrxMemoView
          Left = 1.889763780000000000
          Width = 540.774830000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA - DESCRI'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 545.313420000000000000
          Width = 36.661410000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 584.236240000000000000
          Width = 101.820470000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
        end
        object rllComiss1: TfrxMemoView
          Left = 767.200000000000000000
          Width = 75.212605750000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ALTURA')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 689.215770000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'LARGURA')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 844.922820000000000000
          Width = 98.040940000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AREA (M2)')
          ParentFont = False
          WordWrap = False
        end
        object rllValUniTit: TfrxMemoView
          Left = 945.004700000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.UNITAR')
          ParentFont = False
          WordWrap = False
        end
        object rllValTotTit: TfrxMemoView
          Left = 1062.804700000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR.TOTAL')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        Height = 22.661410000000000000
        Top = 362.834880000000000000
        Width = 1201.134634000000000000
        Condition = 'frxItens."ID_VID"'
        object Memo52: TfrxMemoView
          Left = 1.889763780000000000
          Width = 1193.726160000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxItens."ITEVID"]')
          ParentFont = False
          WordWrap = False
        end
        object Line9: TfrxLineView
          Align = baBottom
          Left = 1.800000000000000000
          Top = 22.661410000000000000
          Width = 1195.086580000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 23.433070870000000000
        Top = 408.189240000000000000
        Width = 1201.134634000000000000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 1.889763780000000000
          Top = 1.133858270000000000
          Width = 540.850364410000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 545.370059210000000000
          Top = 1.133858270000000000
          Width = 36.661417320000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbQtdIte: TfrxMemoView
          Left = 584.299193070000000000
          Top = 1.133858270000000000
          Width = 101.669305980000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbLarIte: TfrxMemoView
          Left = 689.307086610000000000
          Top = 1.133858270000000000
          Width = 75.212605750000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDLAR"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbAltIte: TfrxMemoView
          Left = 767.204724410000000000
          Top = 1.133858270000000000
          Width = 75.212605750000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDALT"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbAreIte: TfrxMemoView
          Left = 845.102362200000000000
          Top = 1.133858270000000000
          Width = 97.889763780000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDMT2"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbValUni: TfrxMemoView
          Left = 944.881889760000000000
          Top = 1.133858270000000000
          Width = 115.200000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fFormatFloat(<frxItens."VALITE">)]')
          ParentFont = False
          WordWrap = False
        end
        object rlbValTot: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 1.133858270000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."TOTITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbGrupoFooter: TfrxGroupFooter
        Height = 49.889780870000000000
        Top = 453.543600000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbGrupoFooterOnBeforePrint'
        Child = frxImpressaoJvVidrosOR_PD_J.CDespesasViagem
        object Memo27: TfrxMemoView
          Left = 944.666110000000000000
          Top = 27.905533780000000000
          Width = 115.200000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB-TOTAL:')
          ParentFont = False
          WordWrap = False
        end
        object rlbSubTotIte: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 27.905533780000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
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
            '[SUM(<frxItens."TOTGER">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Left = 1.889763780000000000
          Width = 1197.355104000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo17: TfrxMemoView
          Left = 944.882500000000000000
          Top = 3.779530000000000000
          Width = 115.200000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PARCIAL:')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 1063.019539610000000000
          Top = 3.779530000000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."TOTITE">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 727.217330160000000000
          Top = 27.905533780000000000
          Width = 115.200000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'N'#176' DE VEZES:')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 845.102362200000000000
          Top = 27.905533780000000000
          Width = 97.889763780000000000
          Height = 20.779530000000000000
          ShowHint = False
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
            '[frxItens."QTDVID"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumario: TfrxReportSummary
        Height = 243.677180000000000000
        Top = 589.606680000000000000
        Width = 1201.134634000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object Line4: TfrxLineView
          Left = 1.889763780000000000
          Top = 79.500000000000000000
          Width = 1198.866110000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo37: TfrxMemoView
          Left = 919.861410000000000000
          Top = 2.000000000000000000
          Width = 138.784230000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 919.861410000000000000
          Top = 21.000000000000000000
          Width = 138.784230000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL FRETE:')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 919.861410000000000000
          Top = 41.000000000000000000
          Width = 138.784230000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DESCONTO:')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 919.861410000000000000
          Top = 60.000000000000000000
          Width = 138.784230000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
        end
        object rlbTotDoc: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 2.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
            '[<frxRodape."TOTDOC"> + <frxRodape."DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object rlbTotFre: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 21.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
        object rlbDesEsp: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 41.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
            '[frxRodape."DESESP"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbTotGer: TfrxMemoView
          Left = 1062.803149610000000000
          Top = 60.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
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
            
              '[<frxRodape."TOTDOC"> - <frxRodape."DESESP"> + <frxRodape."TOTFR' +
              'E"> + <frxRodape."DESACE">]')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 1.889763780000000000
          Top = 82.259842520000000000
          Width = 1048.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor....: [frxRodape."NOMVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 1.889763780000000000
          Top = 105.157480310000000000
          Width = 1048.138590000000000000
          Height = 37.779530000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Mensagem....: [frxRodape."MENSAG"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 1.889763780000000000
          Top = 144.661410000000000000
          Width = 1048.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Arquiteto...: [frxRodape."NOMPRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 1053.803149610000000000
          Top = 82.259842520000000000
          Width = 142.866110000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DATA.: [frxRodape."DTADOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 1053.803149610000000000
          Top = 105.000000000000000000
          Width = 142.866110000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'HORA.:     [frxRodape."HORDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbPerCom: TfrxMemoView
          Left = 1053.803149610000000000
          Top = 144.685039370000000000
          Width = 93.959060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRodape."PERCOM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 1151.959060000000000000
          Top = 144.685039370000000000
          Width = 17.159060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '%')
          ParentFont = False
          WordWrap = False
        end
        object rllEntrega: TfrxMemoView
          Left = 1.889763780000000000
          Top = 166.661410000000000000
          Width = 1049.423500000000000000
          Height = 54.779530000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'End.Entrega.: [frxRodape."ENDENT"]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 1.889763780000000000
          Width = 1197.355104000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object Line10: TfrxLineView
        Align = baBottom
        Left = 1.889763780000000000
        Top = 1012.536087000000000000
        Width = 1198.866110000000000000
        ShowHint = False
        Frame.Typ = [ftTop]
      end
      object Line1: TfrxLineView
        Align = baBottom
        Left = 0.377952760000000000
        Top = 1012.536087000000000000
        Width = 1198.866110000000000000
        ShowHint = False
        Frame.Typ = [ftTop]
      end
      object Line2: TfrxLineView
        Align = baBottom
        Left = 1.889763779527559000
        Top = 1012.536087000000000000
        Width = 1198.866110000000000000
        ShowHint = False
        Frame.Typ = [ftTop]
      end
      object CDespesasViagem: TfrxChild
        Height = 1.881880000000000000
        Top = 525.354670000000000000
        Width = 1201.134634000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object rllDespesasViagem: TfrxMemoView
          Align = baClient
          Width = 1201.134634000000000000
          Height = 1.881880000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
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
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    
    Left = 320
    Top = 16
  end
  object frxExportaXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 320
    Top = 72
  end
  object frxExportaODS: TfrxODSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 0.000000000000000000
    DataOnly = False
    PictureType = gpPNG
    Background = True
    Creator = 'FastReport'
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 320
    Top = 136
  end
  object frxImpressaoJvVidrosRQ_M: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41779.552893831000000000
    ReportOptions.LastChange = 42215.451280081020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotEnt: Double;'
      '  fltTotSai: Double;'
      '  fltSaldo : Double;                      '
      '  '
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If rlbSumario.Height > Engine.FreeSpace Then'
      '    Engine.NewPage;'
      '  '
      
        '  Engine.CurY := Engine.CurY + Engine.FreeSpace - rlbSumario.Hei' +
        'ght - 1;  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotEnt := fltTotEnt + IIF(<frxItens."ENTSAI"> = '#39'ENT'#39', <frx' +
        'Itens."TOTITE">, 0);       '
      
        '  fltTotSai := fltTotSai + IIF(<frxItens."ENTSAI"> = '#39'SAI'#39', <frx' +
        'Itens."TOTITE">, 0);'
      '  fltSaldo  := fltTotEnt - fltTotSai;'
      '  '
      
        '  CInfVid.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CInfFer.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CInfAlu.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CObserv.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      'end;'
      ''
      'begin           '
      ' fltTotEnt := 0;       '
      ' fltTotSai := 0;'
      ' fltSaldo  := 0;     '
      'end.')
    OnUserFunction = frxImpressaoJvVidrosOR_PD_MUserFunction
    Left = 80
    Top = 184
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
    object Page1: TfrxDMPPage
      PaperWidth = 358.139768701399400000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        Height = 221.000000000000000000
        Top = 17.000000000000000000
        Width = 1353.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo22: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = True
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Endereco: [frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAIEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cidade..: [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cep...: [frxCabecalho."CEPEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estado: [frxCabecalho."ESTEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[frxCabecalho."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cliente..: [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Endereco.: [frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Municipio: [frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'CGC/CPF..: [frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Cnd. Pgto: [frxCabecalho."CNDPGT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 119.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Codigo: [frxCabecalho."CODCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 136.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAICLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 153.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'C.E.P.: [frxCabecalho."CEPCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 170.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'IE/RG.: [frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 187.000000000000000000
          Width = 460.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Fone..: [frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 51.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#64#27#67#65#15#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 96.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#18#27#80#27#87#49'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 374.400000000000000000
          Top = 34.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#87#48#15#27#80'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 1267.200000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#18#27#80#27#87#49'
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 547.200000000000000000
          Top = 102.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Command = '#27#87#48#15#27#80'
        end
        object DMPMemo17: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1353.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo8: TfrxDMPMemoView
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'REFERENCIA - DESCRICAO')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haCenter
          Memo.UTF8W = (
            'E/S')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1353.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxImpressaoJvVidrosRQ_M.CInfVid
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."ENTSAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbSumario: TfrxReportSummary
        Height = 136.000000000000000000
        Top = 578.000000000000000000
        Width = 1353.600000000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object DMPMemo46: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 864.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            'Digitador...: [frxRodape."NOMDIG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            'EMISSAO: [frxRodape."DTADOC"] [frxRodape."HORDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          FontStyle = []
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 85.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            
              'DATA:___/___/_____   VISTO:_____________________________________' +
              '________')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CInfVid: TfrxChild
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1353.600000000000000000
        Child = frxImpressaoJvVidrosRQ_M.CInfFer
        Stretched = True
        object DMPMemo38: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Memo.UTF8W = (
            'VIDRO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[INFVID]')
          TruncOutboundText = False
        end
      end
      object CInfFer: TfrxChild
        Height = 34.000000000000000000
        Top = 408.000000000000000000
        Width = 1353.600000000000000000
        Child = frxImpressaoJvVidrosRQ_M.CInfAlu
        Stretched = True
        object DMPMemo39: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Memo.UTF8W = (
            'FERRAGENS:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[INFFER]')
          TruncOutboundText = False
        end
      end
      object CInfAlu: TfrxChild
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1353.600000000000000000
        Child = frxImpressaoJvVidrosRQ_M.CObserv
        Stretched = True
        object DMPMemo41: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Memo.UTF8W = (
            'ALUMINIO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 1113.600000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[INFALU]')
          TruncOutboundText = False
        end
      end
      object CObserv: TfrxChild
        Height = 34.000000000000000000
        Top = 510.000000000000000000
        Width = 1353.600000000000000000
        Stretched = True
        object DMPMemo42: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Memo.UTF8W = (
            'OBSERVACOES:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 1084.800000000000000000
          Height = 17.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[OBSERV]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxImpressaoJvVidrosRQ_J: TfrxReport
    Version = '4.15.13'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41779.552893831000000000
    ReportOptions.LastChange = 42033.698700544000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  fltTotEnt: Double;'
      '  fltTotSai: Double;'
      '  fltSaldo : Double;                      '
      '  '
      'procedure rlbSumarioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If rlbSumario.Height > Engine.FreeSpace Then'
      '    Engine.NewPage;'
      '  '
      
        '  Engine.CurY := Engine.CurY + Engine.FreeSpace - rlbSumario.Hei' +
        'ght - 1;  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotEnt := fltTotEnt + IIF(<frxItens."ENTSAI"> = '#39'ENT'#39', <frx' +
        'Itens."TOTITE">, 0);       '
      
        '  fltTotSai := fltTotSai + IIF(<frxItens."ENTSAI"> = '#39'SAI'#39', <frx' +
        'Itens."TOTITE">, 0);'
      '  fltSaldo  := fltTotEnt - fltTotSai;'
      '  '
      
        '  CInfVid.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CInfFer.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CInfAlu.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      
        '  CObserv.Visible := (rlbDetalhes.DataSet.RecNo + 1) = rlbDetalh' +
        'es.DataSet.RecordCount;'
      'end;'
      ''
      'begin           '
      ' fltTotEnt := 0;       '
      ' fltTotSai := 0;'
      ' fltSaldo  := 0;     '
      'end.')
    OnUserFunction = frxImpressaoJvVidrosOR_PD_MUserFunction
    Left = 80
    Top = 240
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
    object Page1: TfrxReportPage
      PaperWidth = 278.000000000000000000
      PaperHeight = 287.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Height = 240.000002440000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 975.118740000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -93.354050000000000000
          Top = 1.000000000000000000
          Width = 1161.826840000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Align = baCenter
          Left = -93.354050000000000000
          Top = 23.000000000000000000
          Width = 1161.826840000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."FONEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Top = 50.000000000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxCabecalho."ENDEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Align = baRight
          Left = 512.580150000000000000
          Top = 50.000000000000000000
          Width = 328.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAIEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Top = 73.000000000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxCabecalho."CIDEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 512.580150000000000000
          Top = 73.000000000000000000
          Width = 328.138590000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [frxCabecalho."CEPEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 840.718740000000000000
          Top = 73.000000000000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estado: [frxCabecalho."ESTEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 98.500000000000000000
          Width = 975.118740000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Top = 101.000000000000000000
          Width = 1075.880210000000000000
          Height = 24.559060000000000000
          ShowHint = False
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxCabecalho."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 127.385826770000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente: [frxCabecalho."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 149.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxCabecalho."ENDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Top = 171.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxCabecalho."CIDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Top = 193.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'CGC/CPF: [frxCabecalho."CPFCGC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 215.779530000000000000
          Width = 715.086580000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Cnd. Pgto: [frxCabecalho."CNDPGT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Align = baRight
          Left = 506.759680000000000000
          Top = 127.338590000000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxCabecalho."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 506.759680000000000000
          Top = 149.661417320000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxCabecalho."BAICLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Align = baRight
          Left = 506.759680000000000000
          Top = 171.700787400000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P: [frxCabecalho."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Align = baRight
          Left = 506.759680000000000000
          Top = 193.622047240000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'IE/RG: [frxCabecalho."RG_IE_"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 506.759680000000000000
          Top = 215.732283460000000000
          Width = 468.359060000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'ArIal'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [frxCabecalho."FONCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Align = baRight
          Left = 840.718740000000000000
          Top = 50.000000000000000000
          Width = 134.400000000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina: [Page]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baBottom
          Top = 240.000002440000000000
          Width = 975.118740000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        Height = 18.881880000000000000
        Top = 321.260050000000000000
        Width = 975.118740000000000000
        ReprintOnNewPage = True
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 975.118740000000000000
          Height = 18.881880000000000000
          ShowHint = False
          Color = clSilver
        end
        object Memo8: TfrxMemoView
          Left = 1.889763780000000000
          Width = 767.546630000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA - DESCRI'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 784.219110000000000000
          Width = 36.661410000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 872.275820000000000000
          Width = 101.820470000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 828.512370000000000000
          Width = 36.661410000000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        Height = 23.433070870000000000
        Top = 362.834880000000000000
        Width = 975.118740000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxImpressaoJvVidrosRQ_J.CInfVid
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 1.889763780000000000
          Top = 1.133858270000000000
          Width = 767.622164410000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 784.275749210000000000
          Top = 1.133858270000000000
          Width = 36.661417320000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object rlbQtdIte: TfrxMemoView
          Left = 872.338773070000000000
          Top = 1.133858270000000000
          Width = 101.669305980000000000
          Height = 20.779530000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 828.569009210000000000
          Top = 1.133858270000000000
          Width = 36.661417320000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxItens."ENTSAI"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbSumario: TfrxReportSummary
        Height = 115.173160000000000000
        Top = 702.992580000000000000
        Width = 975.118740000000000000
        OnBeforePrint = 'rlbSumarioOnBeforePrint'
        object Line4: TfrxLineView
          Left = 1.889763780000000000
          Top = 3.500000000000000000
          Width = 968.314780000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 1.889763780000000000
          Top = 6.259842520000000000
          Width = 598.374520000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRodape."NOMDIG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 604.039079610000000000
          Top = 6.259842520000000000
          Width = 362.078850000000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMISS'#195'O: [frxRodape."DTADOC"] [frxRodape."HORDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 411.968770000000000000
          Top = 70.504020000000000000
          Width = 143.621895910000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          Memo.UTF8W = (
            '         /         /                 ')
          ParentFont = False
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 636.063390000000000000
          Top = 70.504020000000000000
          Width = 328.818865910000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsUnderline]
          Memo.UTF8W = (
            
              '                                                                ' +
              '                       ')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 362.834880000000000000
          Top = 70.504020000000000000
          Width = 45.354115910000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 578.268090000000000000
          Top = 70.504020000000000000
          Width = 52.913175910000000000
          Height = 20.779530000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VISTO:')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Top = 109.519790000000000000
          Width = 968.314780000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object CInfVid: TfrxChild
        Height = 41.574830000000000000
        Top = 408.189240000000000000
        Width = 975.118740000000000000
        Child = frxImpressaoJvVidrosRQ_J.CInfFer
        Stretched = True
        object Memo5: TfrxMemoView
          Left = 1.889763780000000000
          Top = 18.000000000000000000
          Width = 51.855040000000000000
          Height = 20.787401570000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VIDRO:')
          ParentFont = False
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 60.472480000000000000
          Top = 18.000000000000000000
          Width = 892.346654410000000000
          Height = 20.787401570000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INFVID]')
          ParentFont = False
        end
      end
      object CInfFer: TfrxChild
        Height = 41.574830000000000000
        Top = 472.441250000000000000
        Width = 975.118740000000000000
        Child = frxImpressaoJvVidrosRQ_J.CInfAlu
        Stretched = True
        object Memo17: TfrxMemoView
          Left = 1.889763780000000000
          Top = 18.000000000000000000
          Width = 93.429870000000000000
          Height = 20.787401570000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FERRAGENS:')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 102.047310000000000000
          Top = 18.000000000000000000
          Width = 850.771824410000000000
          Height = 20.787401570000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INFFER]')
          ParentFont = False
        end
      end
      object CInfAlu: TfrxChild
        Height = 41.574830000000000000
        Top = 536.693260000000000000
        Width = 975.118740000000000000
        Child = frxImpressaoJvVidrosRQ_J.CObserv
        Stretched = True
        object Memo18: TfrxMemoView
          Left = 1.889763780000000000
          Top = 18.000000000000000000
          Width = 78.311750000000000000
          Height = 20.787401570000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ALUM'#205'NIO:')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 84.960730000000000000
          Top = 18.000000000000000000
          Width = 869.669474410000000000
          Height = 20.787401570000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INFALU]')
          ParentFont = False
        end
      end
      object CObserv: TfrxChild
        Height = 41.574830000000000000
        Top = 600.945270000000000000
        Width = 975.118740000000000000
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 1.889763780000000000
          Top = 18.000000000000000000
          Width = 116.107050000000000000
          Height = 20.787401570000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES:')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 121.960730000000000000
          Top = 18.000000000000000000
          Width = 835.653704410000000000
          Height = 20.787401570000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OBSERV]')
          ParentFont = False
        end
      end
    end
  end
end
