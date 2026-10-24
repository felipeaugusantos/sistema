object frmModuloCotExportacao: TfrmModuloCotExportacao
  Left = 0
  Top = 0
  ClientHeight = 223
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxPDFExport: TfrxPDFExport
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
    Left = 24
    Top = 16
  end
  object frxXLSExport: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = False
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 96
    Top = 16
  end
  object frxReportPDF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39598.687072094900000000
    ReportOptions.LastChange = 44707.615510150460000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<IMAGEM> <> '#39#39') Then'
      '    picLogo.LoadFromFile(<IMAGEM>);'
      'end;'
      ''
      'procedure MDItensOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  //chdMsgLivre.Visible := ((Trim(<frxItens."APLICA">) <> '#39#39') An' +
        'd (<BLNAPLICA> = '#39'T'#39')) Or (<BLNMSGLIV> And (<frxItens."MSGLV1"> ' +
        '<> '#39#39'));'
      'end;'
      ''
      'procedure Memo1OnAfterData(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure Memo20OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  //Memo20.Text := [fRetCodFab(<frxItens."CODITE">)];           '
      'end;'
      ''
      'Begin            '
      'end.')
    OnUserFunction = frxReportPDFUserFunction
    Left = 24
    Top = 144
    Datasets = <
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxDBTitulo
        DataSetName = 'frxTitulo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 6.500000000000000000
      RightMargin = 6.500000000000000000
      TopMargin = 6.500000000000000000
      BottomMargin = 6.500000000000000000
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object RTTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 18.897650000000000000
        Width = 744.567410000000000000
        OnBeforePrint = 'RTTituloOnBeforePrint'
        object picLogo: TfrxPictureView
          Left = 22.677180000000000000
          Top = 2.118120000000001000
          Width = 219.212740000000000000
          Height = 98.267780000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 272.716760000000000000
          Top = 55.590560940000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 272.716760000000000000
          Top = 72.708671180000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 114.267780000000000000
          Width = 744.567410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object dbEmrpesa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.338590000000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 20.456722200000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 305.921460000000000000
          Top = 54.811030939999990000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_FONE01"]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 273.275820000000000000
          Top = 89.826810700000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 305.921460000000000000
          Top = 72.708671180000000000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_F_A_X_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 272.275820000000000000
          Top = 37.574810470000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 90.708720000000000000
        Top = 200.315090000000000000
        Width = 744.567410000000000000
        Child = frxReportPDF.CTituloItens
        object frxParametrosDOCUMENTO: TfrxMemoView
          Align = baCenter
          Left = 224.882035000000000000
          Top = 27.795300000000000000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COTACAO]')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 68.677180000000030000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 105.047310000000000000
          Top = 68.543309529999990000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 251.338745000000000000
          Top = 3.779529999999994000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEPARTAMENTO DE COMPRAS')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 11.338590000000000000
          Top = 48.267760470000010000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMPRADOR:  ')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 105.047310000000000000
          Top = 48.133890000000010000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPRADOR]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MDItens: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 744.567410000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxReportPDF.chdMsgLivre
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object frxItensfrxItens: TfrxMemoView
          Left = -0.220470000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          WordWrap = False
        end
        object mmReferencia: TfrxMemoView
          Left = 168.756030000000000000
          Width = 144.377950310000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."DESITE"] - [frxItens."REFERE"]')
        end
        object mmMarca: TfrxMemoView
          Left = 317.818865910000000000
          Width = 134.551151810000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          WordWrap = False
        end
        object mmoUn: TfrxMemoView
          Left = 457.543599999999900000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 487.000310000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          WordWrap = False
        end
        object mmVlrUn: TfrxMemoView
          Left = 549.590910000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALUNI"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 617.283859999999900000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."IPIENT"]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 53.000000000000000000
          Top = 0.708410000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'Memo20OnBeforePrint'
          DataSet = frxItens
          DataSetName = 'frxItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fRetCodFab(<frxItens."CODITE">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 671.535870000000000000
          Width = 68.031539999999990000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALTOT"]')
          WordWrap = False
        end
      end
      object PFRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.677180000000000000
        ParentFont = False
        Top = 574.488560000000000000
        Width = 744.567410000000000000
        object Memo39: TfrxMemoView
          Left = 489.866420000000000000
          Top = 5.779530000000023000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Align = baWidth
          Top = 1.779530000000022000
          Width = 744.567410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTituloItens: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 54.047244090000000000
        ParentFont = False
        Top = 313.700990000000000000
        Width = 744.567410000000000000
        object Memo7: TfrxMemoView
          Left = 0.779530000000000000
          Top = 31.000000000000000000
          Width = 47.244094488188980000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#243'digo')
        end
        object Memo8: TfrxMemoView
          Left = 168.756030000000100000
          Top = 31.000000000000000000
          Width = 144.377950310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descri'#231#227'o - Refer'#234'ncia')
        end
        object mmoMarca: TfrxMemoView
          Left = 317.818865910000000000
          Top = 31.000000000000000000
          Width = 134.551151810000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Marca')
        end
        object Memo10: TfrxMemoView
          Left = 461.323129999999900000
          Top = 31.000000000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Un.')
        end
        object Memo11: TfrxMemoView
          Left = 490.779839999999900000
          Top = 31.000000000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
        end
        object lblPrecoUni: TfrxMemoView
          Left = 553.370439999999900000
          Top = 31.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 26.000000000000000000
          Width = 744.567410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 49.133858270000020000
          Width = 744.567410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 48.472480000000000000
          Top = 26.779530000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 316.102325589999800000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 456.323129999999900000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 487.338899999999900000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 550.149969999999900000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Top = 2.677180000000021000
          Width = 744.566929130000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 285.354515000000000000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS SOLICITADOS')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 617.283859999999900000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo17: TfrxMemoView
          Left = 621.063389999999900000
          Top = 31.236240000000010000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '% I.P.I.')
        end
        object Memo19: TfrxMemoView
          Left = 51.472480000000000000
          Top = 31.000000000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#243'digo F'#225'brica')
        end
        object Line7: TfrxLineView
          Left = 165.417440000000100000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo3: TfrxMemoView
          Left = 672.756339999999900000
          Top = 30.236240000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
        end
        object Line6: TfrxLineView
          Left = 668.976809999999900000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object chdMsgLivre: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 427.086890000000000000
        Width = 744.567410000000000000
        Stretched = True
        object rdbAplica: TfrxMemoView
          Width = 329.574920310000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Aplica'#231#227'o: [frxItens."APLICA"]')
        end
        object rdbMsgLv1: TfrxMemoView
          Left = 336.378170000000000000
          Width = 407.811189610000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            'Mens. Livre: [frxItens."MSGLV1"]')
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 48.000000000000000000
        Top = 502.677490000000000000
        Width = 744.567410000000000000
        object Memo16: TfrxMemoView
          Left = 507.322820000000000000
          Top = 0.779220000000009300
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."QTDITE">,MDItens)]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2f'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo18: TfrxMemoView
          Left = 588.574830000000000000
          Top = 0.779220000000009300
          Width = 77.795300000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUser."VALUNI">,MDItens)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 673.401670000000000000
          Top = 0.779220000000009300
          Width = 67.354360000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUser."IPIENT">,MDItens)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 412.984230000000000000
          Top = 1.865799999999979000
          Width = 87.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 495.118430000000000000
          Top = 21.897650000000170000
          Width = 87.692950000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object mmoValTotal: TfrxMemoView
          Left = 582.047620000000000000
          Top = 21.897650000000170000
          Width = 158.063080000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 18.897650000000170000
          Width = 744.567410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBTitulo: TfrxDBDataset
    UserName = 'frxTitulo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 24
    Top = 80
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    DataSource = dtsItens
    BCDToCurrency = False
    Left = 96
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 160
    Top = 80
  end
  object frxReportXLS: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39598.687072094900000000
    ReportOptions.LastChange = 40665.635664594900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<IMAGEM> <> '#39#39') Then'
      '    picLogo.LoadFromFile(<IMAGEM>);'
      'end;'
      ''
      ''
      'procedure MDItensOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdMsgLivre.Visible := ((Trim(<frxItens."APLICA">) <> '#39#39') And ' +
        '(<BLNAPLICA> = '#39'T'#39')) Or (<BLNMSGLIV> And (<frxItens."MSGLV1"> <>' +
        ' '#39#39'));'
      'end;'
      ''
      'Begin            '
      '  '
      '          '
      'end.')
    Left = 96
    Top = 144
    Datasets = <
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxDBTitulo
        DataSetName = 'frxTitulo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object RTTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 98.267780000000000000
        Top = 18.897650000000000000
        Width = 737.008350000000000000
        OnBeforePrint = 'RTTituloOnBeforePrint'
        object picLogo: TfrxPictureView
          Width = 211.653680000000000000
          Height = 90.708656540000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 219.212740000000000000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 219.212740000000000000
          Top = 15.121268140000000000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 219.212740000000000000
          Top = 45.363804419999990000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [frxTitulo."EMP_FONE01"]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 219.212740000000000000
          Top = 75.606340700000000000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 219.212740000000000000
          Top = 60.485072560000000000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax: [frxTitulo."EMP_F_A_X_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 219.212740000000000000
          Top = 30.242536280000000000
          Width = 650.079160000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 177.637910000000000000
        Width = 737.008350000000000000
        Child = frxReportXLS.CTituloItens
        object frxParametrosDOCUMENTO: TfrxMemoView
          Align = baCenter
          Left = 221.102505000000000000
          Top = 19.031496059999990000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COTACAO]')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Align = baLeft
          Top = 38.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Align = baLeft
          Left = 86.929190000000000000
          Top = 38.000000000000000000
          Width = 355.275820000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 247.559215000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEPARTAMENTO DE COMPRAS')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 442.205010000000000000
          Top = 38.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMPRADOR:  ')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Left = 529.134199999999900000
          Top = 38.000000000000000000
          Width = 207.874150000000000000
          Height = 15.118110240000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPRADOR]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MDItens: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 737.008350000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        Child = frxReportXLS.chdMsgLivre
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object frxItensfrxItens: TfrxMemoView
          Align = baLeft
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Left = 175.747943620000100000
          Width = 139.464559610000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxItens."DESITE"] - [frxItens."REFERE"]')
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 315.212503230000100000
          Width = 90.708661420000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 405.921164650000100000
          Width = 30.236239999999990000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 436.157404650000200000
          Width = 56.692884090000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 492.850288740000200000
          Width = 75.590543860000010000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALUNI"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 568.440832600000100000
          Width = 45.354303860000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."IPIENT"]')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 613.795136460000100000
          Width = 52.913363860000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."SUBSTI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 49.133890000000000000
          Width = 126.614053620000100000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            '[frxUser."CODFAB"]')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 666.708500320000100000
          Width = 68.031483860000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CTituloItens: TfrxChild
        FillType = ftBrush
        Height = 16.629899290000000000
        Top = 253.228510000000000000
        Width = 737.008350000000000000
        Child = frxReportXLS.Child1
        object Memo4: TfrxMemoView
          Align = baClient
          Width = 737.008350000000000000
          Height = 16.629899290000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS SOLICITADOS')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 291.023810000000000000
        Width = 737.008350000000000000
        object Memo7: TfrxMemoView
          Align = baLeft
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'C'#243'digo')
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 175.747943620000100000
          Width = 139.464559610000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Descri'#231#227'o - Refer'#234'ncia')
        end
        object mmoMarca: TfrxMemoView
          Align = baLeft
          Left = 315.212503230000100000
          Width = 90.708661420000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Marca')
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 405.921164650000100000
          Width = 30.236215590000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Un.')
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 436.157380240000200000
          Width = 56.692893860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
        end
        object lblPrecoUni: TfrxMemoView
          Align = baLeft
          Left = 492.850274100000200000
          Width = 75.590543860000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 568.440817960000300000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '% I.P.I.')
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 869.291900000000000000
          Width = 52.913390710000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '%Subs.')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 49.133890000000000000
          Width = 126.614053620000100000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'C'#243'digo F'#225'brica')
        end
        object Line2: TfrxLineView
          Align = baRight
          Left = 869.291900000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 613.795148670000300000
          Width = 52.913390710000000000
          Height = 15.118120000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '% SUBST')
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 666.708539380000300000
          Width = 68.031510709999990000
          Height = 15.118120000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
        end
      end
      object chdMsgLivre: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 366.614410000000000000
        Width = 737.008350000000000000
        object rdbAplica: TfrxMemoView
          Width = 329.574920310000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Aplica'#231#227'o: [frxItens."APLICA"]')
        end
        object Memo21: TfrxMemoView
          Left = 336.378170000000000000
          Width = 407.811189610000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            'Mens. Livre: [frxItens."MSGLV1"]')
        end
      end
    end
  end
  object frxUser: TfrxUserDataSet
    UserName = 'frxUser'
    Fields.Strings = (
      'VALUNI')
    OnGetValue = frxUserGetValue
    Left = 160
    Top = 144
  end
  object frxReportPDF_P: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44707.410656388900000000
    ReportOptions.LastChange = 44729.395574108800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    If (<IMAGEM> <> '#39#39') Then'
      '    picLogo.LoadFromFile(<IMAGEM>);  '
      'end;'
      ''
      'procedure MDItensOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdMsgLivre.Visible := ((Trim(<frxItens."APLICA">) <> '#39#39') And ' +
        '(<BLNAPLICA> = '#39'T'#39')) Or (<BLNMSGLIV> And (<frxItens."MSGLV1"> <>' +
        ' '#39#39'));  '
      'end;'
      ''
      'begin  '
      'end.')
    OnUserFunction = frxReportPDF_PUserFunction
    Left = 232
    Top = 144
    Datasets = <
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end
      item
        DataSet = frxDBTitulo
        DataSetName = 'frxTitulo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object RTTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'RTTituloOnBeforePrint'
        object picLogo: TfrxPictureView
          Left = 22.677180000000000000
          Top = 2.118120000000001000
          Width = 219.212740000000000000
          Height = 98.267780000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 272.716760000000000000
          Top = 55.590560940000000000
          Width = 30.614173230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 272.716760000000000000
          Top = 72.708671180000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 114.267780000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object dbEmrpesa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 3.338590000000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 272.126160000000000000
          Top = 20.456722200000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 305.921460000000000000
          Top = 54.811030939999990000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_FONE01"]')
          ParentFont = False
          WordWrap = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 273.275820000000000000
          Top = 89.826810700000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_EMAIL_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 305.921460000000000000
          Top = 72.708671180000000000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_F_A_X_"]')
          ParentFont = False
          WordWrap = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 272.275820000000000000
          Top = 37.574810470000000000
          Width = 498.897960000000000000
          Height = 15.118110240000000000
          DataSet = frmQckHTMLCliente.frxEmpresa
          DataSetName = 'frxEmpresa'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxTitulo."EMP_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object HCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 90.708720000000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        Child = frxReportPDF_P.CTituloItens
        object frxParametrosDOCUMENTO: TfrxMemoView
          Align = baCenter
          Left = 376.063235000000000000
          Top = 27.795300000000000000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COTACAO]')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 11.338590000000000000
          Top = 68.677180000000030000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Left = 105.047310000000000000
          Top = 68.543309529999990000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 402.519945000000000000
          Top = 3.779529999999994000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEPARTAMENTO DE COMPRAS')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 11.338590000000000000
          Top = 48.267760470000010000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMPRADOR:  ')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 105.047310000000000000
          Top = 48.133890000000010000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataSetName = 'frxPedido'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPRADOR]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MDItens: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897640240000000000
        ParentFont = False
        Top = 393.071120000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MDItensOnBeforePrint'
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        Stretched = True
        object frxItensfrxItens: TfrxMemoView
          Left = -0.220470000000000000
          Width = 49.133858267716540000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."CODITE"]')
          WordWrap = False
        end
        object mmReferencia: TfrxMemoView
          Left = 168.756030000000000000
          Width = 144.377950310000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."DESITE"] - [frxItens."REFERE"]')
        end
        object mmMarca: TfrxMemoView
          Left = 317.818865910000000000
          Width = 278.173291810000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."DESMAR"]')
          WordWrap = False
        end
        object mmoUn: TfrxMemoView
          Left = 601.165740000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxItens."SIGUNI"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 636.181510000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."QTDITE"]')
          WordWrap = False
        end
        object mmVlrUn: TfrxMemoView
          Left = 697.433520000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALUNI"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 764.906000000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."IPIENT"]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 50.000000000000000000
          Top = 0.708410000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'Memo20OnBeforePrint'
          DataSet = frxItens
          DataSetName = 'frxItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fRetCodFab(<frxItens."CODITE">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 955.000620000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."VALTOT"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 816.378480000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."SUBSTI"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 884.410020000000000000
          Top = 0.559059999999988100
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."FREENT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object PFRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.677180000000000000
        ParentFont = False
        Top = 582.047620000000000000
        Width = 1046.929810000000000000
        object Memo39: TfrxMemoView
          Left = 489.866420000000000000
          Top = 5.779530000000023000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Align = baWidth
          Top = 1.779530000000022000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object CTituloItens: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 57.826774090000000000
        ParentFont = False
        Top = 313.700990000000000000
        Width = 1046.929810000000000000
        object Memo7: TfrxMemoView
          Left = 0.779530000000000000
          Top = 31.000000000000000000
          Width = 49.133858267716540000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#243'digo')
        end
        object Memo8: TfrxMemoView
          Left = 168.756030000000000000
          Top = 31.000000000000000000
          Width = 144.377950310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Descri'#231#227'o - Refer'#234'ncia')
        end
        object mmoMarca: TfrxMemoView
          Left = 317.818865910000000000
          Top = 31.000000000000000000
          Width = 278.173291810000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Marca')
        end
        object Memo10: TfrxMemoView
          Left = 604.945270000000000000
          Top = 31.000000000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Un.')
        end
        object Memo11: TfrxMemoView
          Left = 634.401980000000000000
          Top = 31.000000000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Quant.')
        end
        object lblPrecoUni: TfrxMemoView
          Left = 696.992580000000000000
          Top = 31.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Pre'#231'o Unit.')
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 26.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 49.133858270000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 50.472480000000000000
          Top = 26.779530000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object linMarca: TfrxLineView
          Left = 316.102325590000000000
          Top = 26.779530000000020000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 599.945270000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 630.961040000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 693.772110000000000000
          Top = 26.000000000000000000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Top = 2.677180000000021000
          Width = 1046.929329130000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baCenter
          Left = 436.535715000000000000
          Top = 6.000000000000000000
          Width = 173.858380000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS SOLICITADOS')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 760.906000000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo17: TfrxMemoView
          Left = 764.685530000000000000
          Top = 31.236240000000010000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '% I.P.I.')
        end
        object Memo19: TfrxMemoView
          Left = 51.472480000000000000
          Top = 31.000000000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#243'digo F'#225'brica')
        end
        object Line7: TfrxLineView
          Left = 165.417440000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo3: TfrxMemoView
          Left = 956.221090000000000000
          Top = 30.236240000000010000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total')
        end
        object Line6: TfrxLineView
          Left = 812.598950000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo24: TfrxMemoView
          Left = 816.378480000000000000
          Top = 31.236240000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '% Subst.')
        end
        object Line9: TfrxLineView
          Left = 880.630490000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo26: TfrxMemoView
          Left = 884.410020000000000000
          Top = 31.236240000000010000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Frete')
        end
        object Line10: TfrxLineView
          Left = 948.662030000000000000
          Top = 26.456709999999990000
          Height = 22.677180000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object chdMsgLivre: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 434.645950000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object rdbAplica: TfrxMemoView
          Width = 329.574920310000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Aplica'#231#227'o: [frxItens."APLICA"]')
        end
        object rdbMsgLv1: TfrxMemoView
          Left = 336.378170000000000000
          Width = 407.811189610000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataSet = frxItens
          DataSetName = 'frxItens'
          Frame.Typ = [ftRight]
          Memo.UTF8W = (
            'Mens. Livre: [frxItens."MSGLV1"]')
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 48.000000000000000000
        Top = 510.236550000000000000
        Width = 1046.929810000000000000
        object Memo16: TfrxMemoView
          Left = 507.322820000000000000
          Top = 0.779220000000009300
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxItens."QTDITE">,MDItens)]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2f'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo18: TfrxMemoView
          Left = 588.574830000000000000
          Top = 0.779220000000009300
          Width = 77.795300000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUser."VALUNI">,MDItens)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 673.401670000000000000
          Top = 0.779220000000009300
          Width = 67.354360000000000000
          Height = 15.118120000000000000
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxUser."IPIENT">,MDItens)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 412.984230000000000000
          Top = 1.865799999999979000
          Width = 87.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 495.118430000000000000
          Top = 21.897649999999940000
          Width = 87.692950000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object mmoValTotal: TfrxMemoView
          Left = 582.047620000000000000
          Top = 21.897649999999940000
          Width = 158.063080000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 18.897649999999940000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
