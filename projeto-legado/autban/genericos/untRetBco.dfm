inherited frmRetBco: TfrmRetBco
  Left = 466
  Top = 307
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'frmRetBco'
  ClientHeight = 241
  ClientWidth = 471
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Pitch = fpDefault
  Font.Quality = fqClearType
  Position = poMainFormCenter
  ExplicitWidth = 471
  ExplicitHeight = 241
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 199
    Width = 471
    Height = 26
    TabOrder = 3
    ExplicitTop = 199
    ExplicitWidth = 471
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 374
      Height = 22
      ExplicitWidth = 374
      ExplicitHeight = 22
      object btnGravar: TBitBtnLocked
        Tag = 1
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Font.Quality = fqClearType
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 376
      Top = 2
      Width = 93
      Align = alRight
      ExplicitLeft = 376
      ExplicitTop = 2
      ExplicitWidth = 93
    end
  end
  inherited pnlStatus: TPanel
    Top = 225
    Width = 471
    TabOrder = 2
    ExplicitTop = 225
    ExplicitWidth = 471
    inherited pnlNomeForm: TPanel
      Left = 300
      ExplicitLeft = 300
    end
    inherited pnlInfo: TPanel
      Width = 300
      ExplicitWidth = 300
    end
  end
  object pnlPath: TPanel [2]
    Left = 0
    Top = 0
    Width = 471
    Height = 84
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblPathArquivosRet: TLabel
      Left = 12
      Top = 31
      Width = 151
      Height = 14
      Caption = 'Path para Arquivos de Retorno:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
    end
    object lblCaminhoMsg: TLabel
      Left = 12
      Top = 68
      Width = 121
      Height = 14
      Caption = 'Diret'#243'rio n'#227'o encontrado!'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentColor = False
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 469
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Arquivo de Retorno Banco'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    inline fraPathRetornoBco: TfraDirectoryEditFocus
      Left = 10
      Top = 47
      Width = 447
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 10
      ExplicitTop = 47
      ExplicitWidth = 447
      ExplicitHeight = 24
      inherited edtDirectory: TEditFocus
        Width = 422
        Height = 22
        OnEnter = fraPathRetornoBcoedtDirectoryEnter
        OnExit = fraPathRetornoBcoedtDirectoryExit
        ExplicitWidth = 422
      end
      inherited btnOpenDirectory: TcxButton
        Left = 424
        Height = 24
        ExplicitLeft = 424
        ExplicitHeight = 24
      end
    end
    object edtArqRetornoBco: TFilenameEditFocus
      Tag = 99
      Left = 10
      Top = 46
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000004080FF4060A0FF4060
            A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060
            A0FF4060A0FF4060A0FF004080FF00000000000000004060A0FF4060A0FF80A0
            E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
            E0FF40A0E0FF40A0E0FF4080C0FF002040FF000000004060A0FF4080C0FF4080
            C0FF80E0E0FF80C0E0FF40C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
            E0FF40A0E0FF40A0E0FF40A0E0FF004080FF000000004060C0FF80A0E0FF4080
            C0FF80E0E0FF80E0E0FF80C0E0FF80C0E0FF80C0E0FF40C0E0FF40C0E0FF40C0
            E0FF40C0E0FF40A0E0FF40A0E0FF4060C0FF000000004080C0FF80C0E0FF40A0
            E0FF80C0E0FFF0FBFFFF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0
            E0FF80C0E0FF80C0E0FF80C0E0FF4080C0FF002040FF4080C0FF80E0E0FF80C0
            E0FF40A0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFFF0FBFFFF80C0E0FF406080FF4080C0FFF0FBFFFF80E0
            E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0C0FF40A0C0FF40A0C0FF40A0
            C0FF40A0C0FF4080C0FF4080C0FF4080C0FF4060A0FF4080C0FFF0FBFFFF80E0
            E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0
            E0FF80E0E0FF4060C0FF0000000000000000000000004080C0FFF0FBFFFF80E0
            E0FF80E0E0FF80E0E0FF80E0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
            FFFFF0FBFFFF4080C0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFFF0FBFFFF40A0C0FF4080C0FF4080C0FF4080C0FF4080
            C0FF4080C0FF4060A0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
            FFFFF0FBFFFFF0FBFFFF4080C0FF000000000000000000000000000000000000
            000000000000000000000000000000000000000000004080A0FF40A0E0FF40A0
            E0FF40A0E0FF40A0C0FF004040FF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000}
          Kind = bkGlyph
        end>
      Properties.ReadOnly = True
      Properties.OnChange = edtArqRetornoBcoPropertiesChange
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 447
    end
  end
  object pnlArquivos: TPanel [3]
    Left = 0
    Top = 84
    Width = 471
    Height = 115
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lstArquivo: TFileListBox
      Left = 1
      Top = 1
      Width = 469
      Height = 113
      Align = alClient
      BevelKind = bkSoft
      FileType = [ftReadOnly, ftDirectory, ftNormal]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Mask = 
        '*.txt;*.ret;*.dat;*.rst;*.html;*.bat;*.bar;*.crt;*.rt1;*.rt3;*.c' +
        'ed;*.144;*.R08_;*.R08;*.R02;*.R03;*.R04;*.R05;*.R06;*.R07;*.R09;' +
        '*.R10;*.R11'
      MultiSelect = True
      ParentFont = False
      ParentShowHint = False
      ShowGlyphs = True
      ShowHint = False
      TabOrder = 0
      OnKeyDown = lstArquivoKeyDown
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 122
  end
  object cdsNaoGra: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 96
    object cdsNaoGraNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 50
    end
    object cdsNaoGraDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object cdsNaoGraDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object cdsNaoGraVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object cdsNaoGraVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object cdsNaoGraCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsNaoGraCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsNaoGraESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsNaoGraNUMDUP: TStringField
      FieldName = 'NUMDUP'
    end
  end
  object frxDBNaoGra: TfrxDBDataset
    UserName = 'frxDBNaoGra'
    CloseDataSource = False
    DataSet = cdsNaoGra
    BCDToCurrency = False
    Left = 176
    Top = 96
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 208
    Top = 96
    Datasets = <
      item
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
        RowCount = 0
        object frxDBNaoGraNUMDUP: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBNaoGra."NUMDUP"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraESPDOC: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPDOC'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."ESPDOC"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraCODEMP: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODEMP'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CODEMP"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraCODCLI: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODCLI'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CODCLI"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraDTAVEN: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."DTAVEN"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraDTAPAG: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAPAG'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."DTAPAG"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraNOSNUM: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOSNUM'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."NOSNUM"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraVALDUP: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."VALDUP"]')
          TruncOutboundText = False
        end
        object frxDBNaoGraVALPAG: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."VALPAG"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            'DUPLICATA    ESP EMP')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.CLI.')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PAGAMENTO')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUPLIC.')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR PAGO')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOSSO NUMERO')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39626.441666643500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 240
    Top = 96
    Datasets = <
      item
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
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
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 16.999999999999990000
        ParentFont = False
        Top = 156.000000000000000000
        Width = 718.110700000000000000
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 714.708649210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxDBNaoGraNUMDUP: TfrxMemoView
          Width = 119.055118110236200000
          Height = 15.118120000000000000
          DataField = 'NUMDUP'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."NUMDUP"]')
        end
        object Memo10: TfrxMemoView
          Left = 124.724490000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBNaoGra."ESPDOC"]')
        end
        object Memo11: TfrxMemoView
          Left = 154.960730000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBNaoGra."CODEMP"]')
        end
        object Memo12: TfrxMemoView
          Left = 188.976500000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBNaoGra."CODCLI"]')
        end
        object Memo13: TfrxMemoView
          Left = 249.448980000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."DTAVEN"]')
        end
        object Memo14: TfrxMemoView
          Left = 298.582870000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."DTAPAG"]')
        end
        object Memo15: TfrxMemoView
          Left = 580.157480310000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          DataField = 'NOSNUM'
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBNaoGra."NOSNUM"]')
        end
        object Memo16: TfrxMemoView
          Left = 347.716760000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."VALDUP"]')
        end
        object Memo17: TfrxMemoView
          Left = 464.882190000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."VALPAG"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 192.000000000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 359.584230000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 7.559059999999988000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 120.000000000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo18: TfrxMemoView
          Width = 718.110700000000000000
          Height = 15.874015750000000000
          DataSet = frmProcArqSPC.frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Width = 119.055118110000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'DUPLICATA')
        end
        object Memo2: TfrxMemoView
          Left = 124.724490000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ESP')
        end
        object Memo3: TfrxMemoView
          Left = 154.960730000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMP')
        end
        object Memo4: TfrxMemoView
          Left = 188.976500000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'D.CLI.')
        end
        object Memo5: TfrxMemoView
          Left = 249.448980000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
        end
        object Memo6: TfrxMemoView
          Left = 298.582870000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PAGAMENTO')
        end
        object Memo7: TfrxMemoView
          Left = 347.716760000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUPLICATA')
        end
        object Memo8: TfrxMemoView
          Left = 464.882190000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR PAGO')
        end
        object Memo9: TfrxMemoView
          Left = 580.047620000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOSSO N'#218'MERO')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 84.984230000000000000
        Top = 16.000000000000000000
        Width = 718.110700000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 121.814410000000000000
          Top = 34.000000000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 599.584230000000000000
          Top = 34.000000000000000000
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
          Left = 621.127520000000000000
          Top = 51.000000000000000000
          Width = 93.656710000000000000
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
          Left = 488.768460000000000000
          Top = 51.000000000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000024000
          Top = 3.779530000000001000
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
      end
    end
  end
end
