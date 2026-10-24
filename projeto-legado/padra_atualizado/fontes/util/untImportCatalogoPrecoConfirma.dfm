inherited frmImportCatalogoPrecoConfirma: TfrmImportCatalogoPrecoConfirma
  Width = 831
  Height = 478
  Caption = 'Resumo da situa'#231#227'o de cada produto do arquivo importado'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 831
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 406
    Width = 825
    ExplicitTop = 406
    ExplicitWidth = 825
    inherited btnSair: TBitBtnLocked
      Left = 742
      TabOrder = 1
      ExplicitLeft = 742
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 127
      Height = 22
      Caption = '&Gravar Importa'#231#227'o'
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnRelErr: TBitBtnLocked
      Left = 135
      Top = 3
      Width = 150
      Height = 22
      Caption = '[ F2 ] &Relat'#243'rio Cr'#237'ticas'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnRelErrClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 434
    Width = 825
    ExplicitTop = 434
    ExplicitWidth = 825
    inherited pnlNomeForm: TPanel
      Left = 654
      ExplicitLeft = 654
    end
    inherited pnlInfo: TPanel
      Width = 654
      ExplicitWidth = 654
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 825
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      825
      65)
    object Label1: TLabel
      Left = 25
      Top = 14
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 43
      Top = 40
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Arquivo:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 90
      Top = 11
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 8
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 165
      Top = 11
      Width = 649
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtArquivo: TEditFocus
      Tag = 99
      Left = 90
      Top = 36
      Width = 724
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlGrid: TPanel [4]
    Left = 0
    Top = 65
    Width = 825
    Height = 341
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 4
    object cxgDados: TcxGridCitel
      Left = 0
      Top = 0
      Width = 825
      Height = 341
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDadosTableView1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgDadosTableView1LINEXC: TcxGridDBColumn
          Caption = 'Linha Excel'
          DataBinding.FieldName = 'LINEXC'
          Width = 34
        end
        object cxgDadosTableView1CODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CAT_CODITE'
        end
        object cxgDadosTableView1DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CAT_DESITE'
          Width = 194
        end
        object cxgDadosTableView1CODBAR: TcxGridDBColumn
          Caption = 'C'#243'd Barras'
          DataBinding.FieldName = 'CAT_CODBAR'
          Width = 103
        end
        object cxgDadosTableView1CODFAB: TcxGridDBColumn
          Caption = 'C'#243'd. F'#225'brica'
          DataBinding.FieldName = 'CAT_CODFAB'
          Width = 104
        end
        object cxgDadosTableView1CATATI: TcxGridDBColumn
          Caption = 'Ativo no Cad. Produtos'
          DataBinding.FieldName = 'CATATI'
          Width = 52
        end
        object cxgDadosTableView1NVOCAT: TcxGridDBColumn
          Caption = 'Novo Catalogo'
          DataBinding.FieldName = 'NVOCAT'
          Width = 49
        end
        object cxgDadosTableView1EXCLIN: TcxGridDBColumn
          Caption = 'Exclus'#227'o Fora de Linha'
          DataBinding.FieldName = 'EXCLIN'
          Width = 53
        end
        object cxgDadosTableView1ATPRCT: TcxGridDBColumn
          Caption = 'Atualizar Pre'#231'o Cat'#225'logo'
          DataBinding.FieldName = 'ATPRCT'
          Width = 50
        end
        object cxgDadosTableView1ATPRIT: TcxGridDBColumn
          Caption = 'Atualizar Pre'#231'o Cad. Produtos'
          DataBinding.FieldName = 'ATPRIT'
          Width = 61
        end
      end
      object cxgDadosLevel1: TcxGridLevel
        GridView = cxgDadosTableView1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 624
    Top = 0
  end
  object dtsDados: TDataSource
    Left = 240
    Top = 318
  end
  object frxReportJ_Criticas: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43580.432879213000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure memCriticaOnBeforePrint(Sender: TfrxComponent);'
      
        '  var strCritica : string;                                      ' +
        '     '
      'begin'
      '  strCritica := '#39#39';                           '
      '  if (<frxDBCriticas."SITFOR"> = 1) Then'
      '    strCritica := strCritica + '#39'| FORNECEDOR N'#195'O FOI INFORMADO'#39
      
        '  Else if (<frxDBCriticas."SITFOR"> = 2) Then                   ' +
        '     '
      
        '    strCritica := strCritica + '#39'| FORNCEDOR "'#39' + (<frxDBCriticas' +
        '."CAT_CODFOR">) + '#39'" N'#195'O FOI ENCOTRADO'#39';'
      ''
      '  if (<frxDBCriticas."SITMAR"> = 1) Then'
      
        '    strCritica := strCritica + '#39'| MARCA "'#39' + (<frxDBCriticas."CA' +
        'T_CODMAR">) + '#39'" N'#195'O FOI ENCOTRADA'#39';              '
      '        '
      '  if (<frxDBCriticas."SITUNI"> = 1) Then'
      
        '      strCritica := strCritica + '#39'| UNIDADE "'#39' + (<frxDBCriticas' +
        '."CAT_CODUNI">) + '#39'" N'#195'O FOI ENCOTRADA'#39';           '
      
        '    mmoCritica.Text := strCritica;                              ' +
        '       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 328
    Top = 224
    Datasets = <
      item
        DataSet = frxDbCriticas
        DataSetName = 'frxDBCriticas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 389.291590000000000000
        Width = 1046.929810000000000000
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 96.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
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
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 203.074305000000000000
          Top = 34.000000000000000000
          Width = 640.781200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REL'#193'TORIOS DE ITENS COM INCONSIST'#202'NCIAS')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPagina: TfrxMemoView
          Left = 921.635190000000000000
          Top = 34.015770000000000000
          Width = 115.200000000000000000
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
          Left = 969.414720000000000000
          Top = 58.574830000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
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
          Left = 837.055660000000000000
          Top = 58.574830000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
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
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 16.897650000000000000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Top = 0.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'LINHA')
        end
        object Memo2: TfrxMemoView
          Left = 162.519790000000000000
          Top = 0.779530000000000000
          Width = 464.882190000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
        object Memo5: TfrxMemoView
          Left = 632.063390000000000000
          Top = 0.779530000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'D. BARRAS')
        end
        object Memo6: TfrxMemoView
          Left = 819.378480000000000000
          Top = 0.779530000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'D. FABRICA')
        end
        object Memo3: TfrxMemoView
          Left = 83.149660000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795300000000000000
        ParentFont = False
        Top = 219.212740000000000000
        Width = 1046.929810000000000000
        AllowSplit = True
        DataSet = frxDbCriticas
        DataSetName = 'frxDBCriticas'
        RowCount = 0
        Stretched = True
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmoCodigo: TfrxMemoView
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."LINEXC"]')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 82.370130000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."CAT_CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 163.299320000000000000
          Width = 461.102660000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."CAT_DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 631.181510000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."CAT_CODBAR"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 818.158010000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBcriticas."CAT_CODFAB"]')
          WordWrap = False
        end
        object mmoCritica: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1043.150280000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'memCriticaOnBeforePrint'
          WordWrap = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 317.480520000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object MemoErros: TfrxMemoView
          Top = 11.000000000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDbCriticas: TfrxDBDataset
    UserName = 'frxDBCriticas'
    CloseDataSource = False
    DataSource = dtsCriticas
    BCDToCurrency = False
    Left = 216
    Top = 224
  end
  object dtsCriticas: TDataSource
    Left = 128
    Top = 232
  end
end
