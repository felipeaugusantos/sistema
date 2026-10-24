inherited frmRelFiscTermoAbert: TfrmRelFiscTermoAbert
  Left = 276
  Top = 266
  Width = 338
  Height = 261
  Caption = 'Relat'#243'rio do Termo de Abertura/Encerramento'
  ExplicitWidth = 338
  ExplicitHeight = 261
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 190
    Width = 332
    Anchors = [akBottom]
    ExplicitTop = 190
    ExplicitWidth = 332
    inherited FlwBotoes: TFlowPanel
      Width = 223
      Align = alLeft
      Anchors = []
      ExplicitWidth = 223
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 253
      ExplicitLeft = 253
    end
  end
  inherited pnlDados: TPanel
    Width = 332
    Height = 190
    ExplicitWidth = 332
    ExplicitHeight = 190
    inherited gpbDestino: TGroupBox
      Top = 133
      TabOrder = 1
      ExplicitTop = 133
    end
    object gpbOpcao: TGroupBox
      Left = 8
      Top = 8
      Width = 137
      Height = 123
      Caption = 'Op'#231#227'o'
      TabOrder = 0
      object rdbEntrada: TRadioButton
        Tag = 99
        Left = 7
        Top = 20
        Width = 66
        Height = 17
        Caption = 'Entrada'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbEntradaClick
      end
      object rdbSaida: TRadioButton
        Tag = 99
        Left = 7
        Top = 44
        Width = 52
        Height = 17
        Caption = 'Sa'#237'da'
        TabOrder = 1
        OnClick = rdbSaidaClick
      end
      object rdbInventario: TRadioButton
        Tag = 99
        Left = 7
        Top = 68
        Width = 100
        Height = 17
        Caption = 'Invent'#225'rio F'#237'sico'
        TabOrder = 2
        OnClick = rdbInventarioClick
      end
      object rdbNota: TRadioButton
        Tag = 99
        Left = 7
        Top = 91
        Width = 78
        Height = 17
        Caption = 'Nota Fiscal'
        TabOrder = 3
        OnClick = rdbNotaClick
      end
    end
    object gpbNota: TGroupBox
      Left = 151
      Top = 8
      Width = 164
      Height = 170
      TabOrder = 3
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 51
        Height = 14
        Caption = 'Nota Inicial'
      end
      object Label2: TLabel
        Left = 8
        Top = 67
        Width = 47
        Height = 14
        Caption = 'Nota Final'
      end
      object Label3: TLabel
        Left = 8
        Top = 118
        Width = 93
        Height = 14
        Caption = 'Data da '#218'ltima Nota'
      end
      object mskDtaUltNot: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 134
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtNotaIni: TEditFocus
        Tag = 99
        Left = 8
        Top = 32
        Width = 116
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNotaFin: TEditFocus
        Tag = 99
        Left = 8
        Top = 83
        Width = 116
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object gpbEntSaiInv: TGroupBox
      Left = 151
      Top = 8
      Width = 164
      Height = 170
      TabOrder = 2
      Visible = False
      object Label4: TLabel
        Left = 8
        Top = 7
        Width = 55
        Height = 14
        Caption = 'Folha Inicial'
      end
      object Label5: TLabel
        Left = 93
        Top = 7
        Width = 51
        Height = 14
        Caption = 'Folha Final'
      end
      object Label6: TLabel
        Left = 8
        Top = 89
        Width = 79
        Height = 14
        Caption = 'N'#250'mero do Livro'
      end
      object Label7: TLabel
        Left = 8
        Top = 47
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
      end
      object Label8: TLabel
        Left = 93
        Top = 47
        Width = 47
        Height = 14
        Caption = 'Data Final'
      end
      object Label9: TLabel
        Left = 9
        Top = 129
        Width = 66
        Height = 14
        Caption = 'Data de Envio'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 60
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 93
        Top = 60
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaEnv: TMaskEditFocus
        Tag = 99
        Left = 9
        Top = 142
        Width = 65
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtFolIni: TEditFocus
        Tag = 99
        Left = 8
        Top = 20
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtFolFin: TEditFocus
        Tag = 99
        Left = 93
        Top = 20
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNroLivro: TEditFocus
        Tag = 99
        Left = 8
        Top = 102
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 216
    Width = 332
    ExplicitTop = 216
    ExplicitWidth = 332
    inherited pnlNomeForm: TPanel
      Left = 161
      ExplicitLeft = 161
    end
    inherited pnlInfo: TPanel
      Width = 161
      ExplicitWidth = 161
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 200
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 304
    Top = 200
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 384
    Top = 232
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 352
    Top = 232
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 320
    Top = 232
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 480
    Top = 200
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 448
    Top = 200
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 384
    Top = 200
  end
  inherited frxGen: TfrxUserDataSet
    Left = 416
    Top = 200
  end
  inherited frxDesigner: TfrxDesigner
    Left = 448
    Top = 232
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 480
    Top = 232
  end
  object frxPaginaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39584.589302604200000000
    ReportOptions.LastChange = 39587.620423888900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure frxPagina1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllAbertura_Livro.Visible   := not blnNotFis;'
      '  rchAbertura_Paginas.Visible := (not blnNotFis);'
      '  rchAbertura_Notas.Visible   := blnNotFis;  '
      'end;'
      ''
      'procedure frxPagina2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllFecha_Livro.Visible   := not blnNotFis;'
      '  rchFecha_Paginas.Visible := not blnNotFis;'
      '  rchFecha_Notas.Visible   := blnNotFis  '
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 240
    Top = 120
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
    object frxPagina1: TfrxDMPPage
      PaperWidth = 200.659870407167000000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.540000000000000000
      RightMargin = 2.540000000000000000
      TopMargin = 4.497916666666670000
      BottomMargin = 4.497916666666670000
      OnBeforePrint = 'frxPagina1OnBeforePrint'
      FontStyle = []
      object rllTopo: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 119.000000000000000000
        Width = 585.600000000000000000
        Height = 51.000000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[TITULO]'
          ''
          '[MODELO]')
        TruncOutboundText = False
      end
      object rllAbertura_Livro: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 204.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          'NUMERO DE ORDEM: [LIVRO]')
        ParentFont = False
        TruncOutboundText = False
      end
      object rllEmpresa: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 969.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          '(ASSINATURA DO CONTRIBUINTE OU SEU REPRESENTANTE LEGAL)')
        ParentFont = False
        WordWrap = False
        TruncOutboundText = False
      end
      object DMPCommand1: TfrxDMPCommand
        Left = 19.200000000000000000
        Top = 17.000000000000000000
        Width = 19.200000000000000000
        Height = 17.000000000000000000
        Command = '#27#64#18#27#80#27#871#272'
      end
      object rllData1: TfrxDMPMemoView
        Left = 67.200000000000000000
        Top = 884.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[DTAASS]')
        ParentFont = False
        WordWrap = False
        TruncOutboundText = False
      end
      object DMPCommand6: TfrxDMPCommand
        Left = 38.400000000000000000
        Top = 1054.000000000000000000
        Width = 19.200000000000000000
        Height = 17.000000000000000000
        Command = '#27#64#18'
      end
      object DMPMemo2: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 306.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = [fsxBold, fsxWide]
        HAlign = haCenter
        Memo.UTF8W = (
          'TERMO DE ABERTURA')
        ParentFont = False
        TruncOutboundText = False
      end
      object rchAbertura_Paginas: TfrxDMPMemoView
        Left = 28.800000000000000000
        Top = 442.000000000000000000
        Width = 681.600000000000000000
        Height = 221.000000000000000000
        FontStyle = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Contem este livro [INTPAG] ([STRPAG]) folhas numeradas eletronic' +
            'amente, do N'#186' [PAGINI] ao N'#186' [PAGFIN] do periodo de [DTAINI] A [' +
            'DTAFIN] e servira para o lancamento das operacoes ou  prestacoes' +
            ' proprias do estabelecimento do contribuinte abaixo identificado' +
            ': '
          ''
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endereco :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Municipio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscricao Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
        TruncOutboundText = False
      end
      object DMPLine1: TfrxDMPLineView
        Left = 43.200000000000000000
        Top = 960.500000000000000000
        Width = 643.200000000000000000
        Color = clBlack
      end
      object rchAbertura_Notas: TfrxDMPMemoView
        Left = 28.800000000000000000
        Top = 442.000000000000000000
        Width = 681.600000000000000000
        Height = 221.000000000000000000
        FontStyle = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Contem este livro [INTPAG] ([STRPAG]) fichas de Nota Fiscal Fatu' +
            'ra, serie [SERIE_], numeradas eletronicamente, do N'#186' [NOTINI] ao' +
            ' N'#186' [NOTFIN], e servira de copiador e registro de duplicatas do ' +
            'contribuinte abaixo identificado:'
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endereco :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Municipio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscricao Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
        TruncOutboundText = False
      end
    end
    object frxPagina2: TfrxDMPPage
      PaperWidth = 200.659870407167000000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      OnBeforePrint = 'frxPagina2OnBeforePrint'
      FontStyle = []
      object DMPCommand2: TfrxDMPCommand
        Left = 19.200000000000000000
        Top = 17.000000000000000000
        Width = 19.200000000000000000
        Height = 17.000000000000000000
        Command = '#27#64#18#27#80#272'
      end
      object DMPCommand8: TfrxDMPCommand
        Left = 48.000000000000000000
        Top = 1037.000000000000000000
        Width = 19.200000000000000000
        Height = 17.000000000000000000
        Command = '#27#64#18'
      end
      object DMPMemo1: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 119.000000000000000000
        Width = 585.600000000000000000
        Height = 51.000000000000000000
        HAlign = haCenter
        Memo.UTF8W = (
          '[TITULO]'
          ''
          '[MODELO]')
        TruncOutboundText = False
      end
      object rllFecha_Livro: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 204.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          'NUMERO DE ORDEM: [LIVRO]')
        ParentFont = False
        TruncOutboundText = False
      end
      object DMPMemo5: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 969.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          '(ASSINATURA DO CONTRIBUINTE OU SEU REPRESENTANTE LEGAL)')
        ParentFont = False
        WordWrap = False
        TruncOutboundText = False
      end
      object DMPMemo6: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 884.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[DTAASS]')
        ParentFont = False
        WordWrap = False
        TruncOutboundText = False
      end
      object DMPMemo7: TfrxDMPMemoView
        Left = 76.800000000000000000
        Top = 306.000000000000000000
        Width = 585.600000000000000000
        Height = 17.000000000000000000
        FontStyle = [fsxBold, fsxWide]
        HAlign = haCenter
        Memo.UTF8W = (
          'TERMO DE ABERTURA')
        ParentFont = False
        TruncOutboundText = False
      end
      object rchFecha_Paginas: TfrxDMPMemoView
        Left = 28.800000000000000000
        Top = 442.000000000000000000
        Width = 681.600000000000000000
        Height = 221.000000000000000000
        FontStyle = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Conteve este livro [INTPAG] ([STRPAG]) folhas numeradas eletroni' +
            'camente, do N'#186' [PAGINI] ao N'#186' [PAGFIN] do periodo de [DTAINI] A ' +
            '[DTAFIN] e serviu para o lancamento das operacoes ou  prestacoes' +
            ' proprias do estabelecimento do contribuinte abaixo identificado' +
            ': '
          ''
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endereco :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Municipio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscricao Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
        TruncOutboundText = False
      end
      object DMPLine2: TfrxDMPLineView
        Left = 43.200000000000000000
        Top = 960.500000000000000000
        Width = 643.200000000000000000
        Color = clBlack
      end
      object rchFecha_Notas: TfrxDMPMemoView
        Left = 28.800000000000000000
        Top = 442.000000000000000000
        Width = 681.600000000000000000
        Height = 221.000000000000000000
        FontStyle = []
        HAlign = haBlock
        Memo.UTF8W = (
          
            'Conteve este livro [INTPAG] ([STRPAG]) fichas de Nota Fiscal Fat' +
            'ura, serie [SERIE_], numeradas eletronicamente, do N'#186' [NOTINI] a' +
            'o N'#186' [NOTFIN], e serviu de copiador e registro de duplicatas do ' +
            'contribuinte abaixo identificado:'
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endereco :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Municipio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscricao Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
        TruncOutboundText = False
      end
    end
  end
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39587.480839178200000000
    ReportOptions.LastChange = 43999.470058275460000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure frxPagina1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllAbertura_Livro.Visible   := not blnNotFis;'
      '  rchAbertura_Paginas.Visible := (not blnNotFis);'
      '  rchAbertura_Notas.Visible := blnNotFis;  '
      ''
      'end;'
      ''
      'procedure frxPagina2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllFecha_Livro.Visible   := not blnNotFis;'
      '  rchFecha_Paginas.Visible := not blnNotFis;'
      '  rchFecha_Notas.Visible   := blnNotFis  '
      '        '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 240
    Top = 160
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
    object frxPagina1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'frxPagina1OnBeforePrint'
      object Memo1: TfrxMemoView
        Left = 105.959386654473600000
        Top = 333.023810000000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'TERMO DE ABERTURA DE LIVRO')
        ParentFont = False
      end
      object rllData1: TfrxMemoView
        Left = 94.377952760000000000
        Top = 712.244590000000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[DTAASS]')
        ParentFont = False
      end
      object rllEmpresa: TfrxMemoView
        Left = 106.021306160000000000
        Top = 866.000620000000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '(ASSINATURA DO CONTRIBUINTE OU SEU REPRESENTANTE LEGAL)')
        ParentFont = False
      end
      object Memo3: TfrxMemoView
        Left = 106.021306160000000000
        Top = 122.084060290000000000
        Width = 529.133858270000000000
        Height = 71.811070000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TITULO]'
          ''
          '[MODELO]')
        ParentFont = False
      end
      object rllAbertura_Livro: TfrxMemoView
        Left = 106.021306160000000000
        Top = 215.433210000000000000
        Width = 529.133858270000000000
        Height = 30.236240000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'N'#218'MERO DE ORDEM: [LIVRO]')
        ParentFont = False
      end
      object Line1: TfrxLineView
        Left = 47.438420294117560000
        Top = 857.202645294117600000
        Width = 646.299630000000000000
        Color = clBlack
        Diagonal = True
      end
      object rchAbertura_Notas: TfrxMemoView
        Left = 17.179681820000000000
        Top = 374.517063640000000000
        Width = 670.007590910000000000
        Height = 319.885675450000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Memo.UTF8W = (
          
            'Cont'#234'm este livro [INTPAG] ([STRPAG]) fichas de Nota Fiscal Fatu' +
            'ra, s'#233'rie [SERIE_], numeradas eletr'#244'nicamente, do N'#186' [NOTINI] ao' +
            ' N'#186' [NOTFIN], e servir'#225' de copiador e registro de duplicatas do ' +
            'contribuinte abaixo identificado:'
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endere'#231'o :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Munic'#237'pio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscri'#231#227'o Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
      end
      object rchAbertura_Paginas: TfrxMemoView
        Left = 17.179681820000000000
        Top = 377.953000000000000000
        Width = 670.007590910000000000
        Height = 313.700990000000000000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Memo.UTF8W = (
          
            'Cont'#234'm este livro [INTPAG] ([STRPAG]) folhas numeradas eletr'#244'nic' +
            'amente, do N'#186' [PAGINI] ao N'#186' [PAGFIN] do per'#237'odo de [DTAINI] A [' +
            'DTAFIN] e servir'#225' para o lan'#231'amento das opera'#231#245'es ou  presta'#231#245'es' +
            ' pr'#243'prias do estabelecimento do contribuinte abaixo identificado' +
            ':'
          ''
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endere'#231'o :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Munic'#237'pio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscri'#231#227'o Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
      end
    end
    object frxPagina2: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'frxPagina2OnBeforePrint'
      object Memo2: TfrxMemoView
        Left = 105.959386650000000000
        Top = 332.325649710000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'TERMO DE ENCERRAMENTO')
        ParentFont = False
      end
      object Memo5: TfrxMemoView
        Left = 105.959386654473600000
        Top = 711.546429710000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[DTAASS]')
        ParentFont = False
      end
      object Memo6: TfrxMemoView
        Left = 105.959386654473600000
        Top = 865.302459710000000000
        Width = 529.133858270000000000
        Height = 18.897650000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '(ASSINATURA DO CONTRIBUINTE OU SEU REPRESENTANTE LEGAL)')
        ParentFont = False
      end
      object Memo7: TfrxMemoView
        Left = 105.959386650000000000
        Top = 121.385900000000000000
        Width = 529.133858270000000000
        Height = 71.811070000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          '[TITULO]'
          ''
          '[MODELO]')
        ParentFont = False
      end
      object rllFecha_Livro: TfrxMemoView
        Left = 105.959386650000000000
        Top = 214.735049710000000000
        Width = 529.133858270000000000
        Height = 71.811070000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8W = (
          'N'#218'MERO DE ORDEM: [LIVRO]')
        ParentFont = False
      end
      object Line2: TfrxLineView
        Left = 47.376500789473610000
        Top = 856.504485000000000000
        Width = 646.299630000000000000
        Color = clBlack
        Diagonal = True
      end
      object rchFecha_Notas: TfrxMemoView
        Left = 13.498321428571430000
        Top = 372.553671428571600000
        Width = 704.612378571428900000
        Height = 315.860721428571600000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Memo.UTF8W = (
          
            'Conteve este livro [INTPAG] ([STRPAG]) fichas de Nota Fiscal Fat' +
            'ura, s'#233'rie [SERIE_], numeradas eletr'#244'nicamente, do N'#186' [NOTINI] a' +
            'o N'#186' [NOTFIN], e serviu de copiador e registro de duplicatas do ' +
            'contribuinte abaixo identificado:'
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endere'#231'o :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Munic'#237'pio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscri'#231#227'o Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
      end
      object rchFecha_Paginas: TfrxMemoView
        Left = 13.498321428571430000
        Top = 372.553671428571600000
        Width = 704.612378571428900000
        Height = 313.161057142857300000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          
            'Conteve este livro [INTPAG] ([STRPAG]) folhas numeradas eletr'#244'ni' +
            'camente, do N'#186' [PAGINI] ao N'#186' [PAGFIN] do per'#237'odo de [DTAINI] A ' +
            '[DTAFIN] e serviu para o lan'#231'amento das opera'#231#245'es ou  presta'#231#245'es' +
            ' pr'#243'prias do estabelecimento do contribuinte abaixo identificado' +
            ': '
          ''
          ''
          'Nome : [frxRelatorio."NOMEMP"]'
          'Endere'#231'o :[frxRelatorio."ENDERE"]'
          'Bairro : [frxRelatorio."BAIRRO"]'
          
            'Munic'#237'pio : [frxRelatorio."NOMCID"]    Estado : [frxRelatorio."E' +
            'STADO"]'
          'Inscri'#231#227'o Estadual : [frxRelatorio."IES"]'
          'Cnpj (MF) : [frxRelatorio."CGC"]')
        ParentFont = False
      end
    end
  end
end
