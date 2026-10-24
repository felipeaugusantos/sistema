inherited frmRelCadCustosIndustrial: TfrmRelCadCustosIndustrial
  Width = 545
  Height = 431
  Caption = 'Pre'#231'os e Composi'#231#227'o de Produtos Acabados'
  OnDestroy = FormDestroy
  ExplicitWidth = 545
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 539
    ExplicitTop = 360
    ExplicitWidth = 539
    inherited FlwBotoes: TFlowPanel
      Width = 458
      ExplicitWidth = 458
    end
    inherited btnSair: TBitBtnLocked
      Left = 460
      ExplicitLeft = 460
    end
  end
  inherited pnlStatus: TPanel
    Top = 386
    Width = 539
    ExplicitTop = 386
    ExplicitWidth = 539
    inherited pnlNomeForm: TPanel
      Left = 368
      ExplicitLeft = 368
    end
    inherited pnlInfo: TPanel
      Width = 368
      ExplicitWidth = 368
      inherited shpMultSel: TShape
        Left = 349
        Visible = True
        ExplicitLeft = 349
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 539
    Height = 360
    ExplicitWidth = 539
    ExplicitHeight = 360
    inherited gpbDestino: TGroupBox
      Left = 391
      Top = 255
      TabOrder = 2
      ExplicitLeft = 391
      ExplicitTop = 255
    end
    object GroupBox1: TGroupBox
      Left = 11
      Top = 12
      Width = 518
      Height = 129
      Caption = 'Produtos a Granel'
      TabOrder = 0
      object Label7: TLabel
        Left = 47
        Top = 25
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label2: TLabel
        Left = 12
        Top = 48
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label11: TLabel
        Left = 40
        Top = 71
        Width = 40
        Height = 14
        Caption = 'Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 10
        Top = 95
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da Baixa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 151
        Top = 95
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = 'e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 245
        Top = 95
        Width = 154
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 82
        Top = 22
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 135
        Top = 22
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 45
        Width = 52
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 2
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 135
        Top = 45
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodProduto: TEditFocus
        Tag = 99
        Left = 82
        Top = 68
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodProdutoExit
        OnKeyPress = edtCodProdutoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProduto: TEditFocus
        Left = 135
        Top = 68
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 92
        Width = 63
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 6
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 162
        Top = 92
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 7
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtNumOrd: TEditFocus
        Tag = 99
        Left = 403
        Top = 92
        Width = 35
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskDtaCad: TMaskEditFocus
        Tag = 99
        Left = 440
        Top = 92
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 9
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object GroupBox2: TGroupBox
      Left = 11
      Top = 150
      Width = 518
      Height = 103
      Caption = 'Produtos Acabados'
      TabOrder = 1
      object Label3: TLabel
        Left = 47
        Top = 25
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label4: TLabel
        Left = 12
        Top = 48
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label5: TLabel
        Left = 40
        Top = 71
        Width = 40
        Height = 14
        Caption = 'Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodMarAca: TEditFocus
        Tag = 99
        Left = 82
        Top = 22
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnExit = edtCodMarAcaExit
        OnKeyPress = edtCodMarAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarAca: TEditFocus
        Left = 135
        Top = 22
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskLinGruAca: TMaskEditFocus
        Tag = 99
        Left = 82
        Top = 45
        Width = 52
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 2
        Text = ''
        OnExit = mskLinGruAcaExit
        OnKeyPress = mskLinGruAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGruAca: TEditFocus
        Left = 135
        Top = 45
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodProdutoAca: TEditFocus
        Tag = 99
        Left = 82
        Top = 68
        Width = 52
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodProdutoAcaExit
        OnKeyPress = edtCodProdutoAcaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProdutoAca: TEditFocus
        Left = 135
        Top = 68
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object prbProgresso: TProgressBar
      Left = 1
      Top = 343
      Width = 537
      Height = 16
      Align = alBottom
      Smooth = True
      TabOrder = 3
    end
    object CheckBox3: TCheckBox
      Left = 100
      Top = 284
      Width = 97
      Height = 17
      Caption = 'CheckBox3'
      TabOrder = 4
    end
    object GroupBox3: TGroupBox
      Left = 11
      Top = 259
      Width = 374
      Height = 70
      Caption = 'Op'#231#245'es'
      TabOrder = 5
      object chkQbrOrd: TCheckBox
        Left = 12
        Top = 43
        Width = 313
        Height = 17
        Caption = 'Quebrar p'#225'gina por ordem de produ'#231#227'o'
        TabOrder = 0
      end
      object chkExbQtd: TCheckBox
        Left = 12
        Top = 20
        Width = 313
        Height = 17
        Caption = 'Exibir as quantidades utilizadas na ordem de produ'#231#227'o'
        TabOrder = 1
      end
    end
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    DataSource = dtsItens
    Left = 256
    Top = 224
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44956.685696192130000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure GroupHeaderOPOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 204
    Top = 220
    Datasets = <
      item
        DataSet = frxDBCombo
        DataSetName = 'frxDBCombo'
      end
      item
        DataSet = frxDBFormula
        DataSetName = 'frxDBFormula'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
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
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 32.118120000000000000
        ParentFont = False
        Top = 336.378170000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxReportJ.Child3
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo54: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.181099920000008000
          Width = 1024.252630000000000000
          Height = 18.897650000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'PRODUTO ACABADO: [frxRelatorio."CODIGO_PRODUTO_ACABADO"] - [frxR' +
              'elatorio."DESCRICAO_PRODUTO_ACABADO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 631.181510000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 13.220469999999980000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 145.456710000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 78.000000000000000000
          Width = 581.971800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 354.255505000000000000
          Top = 34.000000000000000000
          Width = 338.418800000000000000
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
          Left = 928.403340000000000000
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
          Left = 976.403340000000000000
          Top = 51.000000000000000000
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
          Left = 878.060050000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
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
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 98.000000000000000000
          Width = 584.315090000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 591.421090000000000000
          Top = 77.858267720000000000
          Width = 451.729190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARACA]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 142.842610000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Top = 119.488250000000000000
          Width = 584.315090000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTO]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 591.386210000000000000
          Top = 97.889763780000000000
          Width = 451.729190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PROACA]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 592.386210000000000000
          Top = 119.433070870000000000
          Width = 451.729190000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINACA]')
          ParentFont = False
        end
      end
      object ChildFormula: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 291.023810000000000000
        Width = 1046.929810000000000000
        object SubFormula: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.PagFormula
        end
      end
      object GroupHeaderOP: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 41.574830000000000000
        ParentFont = False
        Top = 226.771800000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'GroupHeaderOPOnBeforePrint'
        Child = frxReportJ.ChildFormula
        Condition = 'frxRelatorio."SEQUENCIAL_ORDEM_PRODUCAO"'
        object mmoOP: TfrxMemoView
          Left = 7.559060000000000000
          Top = 10.779530000000000000
          Width = 355.275820000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'OP [frxRelatorio."CODIGO_ORDEM_PRODUCAO"] - [frxRelatorio."DATA_' +
              'CADASTRO_ORDEM_PRODUCAO"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoDtaBai: TfrxMemoView
          Left = 370.393940000000000000
          Top = 11.338590000000000000
          Width = 275.905484960000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data da Baixa: [frxRelatorio."DATA_BAIXA_ORDEM_PRODUCAO"] ')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 678.213050000000000000
          Top = 25.338590000000000000
          Width = 359.055350000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'OPE. BAIXA: [frxRelatorio."CODIGO_OPEBAIXA"] - [frxRelatorio."NO' +
              'ME_OPEBAIXA"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo55: TfrxMemoView
          Left = 678.535870000000000000
          Top = 2.000000000000000000
          Width = 359.055350000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'OPE. INCLUS'#195'O: [frxRelatorio."CODIGO_OPERADOR"] - [frxRelatorio.' +
              '"NOME_OPERADOR"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupFooterOP: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 47.133890000000000000
        ParentFont = False
        Top = 521.575140000000000000
        Width = 1046.929810000000000000
        object Memo57: TfrxMemoView
          Left = 361.322834650000000000
          Top = 25.677180000000020000
          Width = 90.708661420000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."CUSTO_RELATIVO_PRODUCAO_PRODUTO_ACABADO">,rl' +
              'bDetalhes)]')
        end
        object Memo58: TfrxMemoView
          Left = 32.779530000000000000
          Top = 4.000000000000000000
          Width = 215.433146540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PESO TOTAL DA PRODU'#199#195'O:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 255.874015750000000000
          Top = 4.779530000000022000
          Width = 98.267716540000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."PESO_PRODUZIDO_PRODUTO_ACABADO">,rlbDetalhes' +
              ')]')
        end
        object Memo48: TfrxMemoView
          Left = 32.968460000000000000
          Top = 25.566931569999950000
          Width = 215.433146540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '(5) CUSTO TOTAL DA PRODU'#199#195'O:')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 43.354360000000040000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildProAcaOP: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677180000000000000
        ParentFont = False
        Top = 476.220780000000000000
        Width = 1046.929810000000000000
        PrintChildIfInvisible = True
        object mmoZebra: TfrxMemoView
          Top = 2.425169999999980000
          Width = 1047.307289210000000000
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
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Top = 2.425169999999980000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODIGO_PRODUTO_ACABADO"]')
        end
        object mmoQtdPro: TfrxMemoView
          Left = 146.637795280000000000
          Top = 2.425169999999980000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QUANTIDADE_PRODUZIDA_PRODUTO_ACABADO"]')
        end
        object Memo5: TfrxMemoView
          Left = 62.858380000000000000
          Top = 2.425169999999980000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESO_LITRO_PRODUTO_ACABADO"]')
        end
        object mmoQtdEnv: TfrxMemoView
          Left = 456.756340000000000000
          Top = 2.425169999999980000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QUANTIDADE_ENVASADA_PRODUTO_ACABADO"]')
        end
        object mmoPesAca: TfrxMemoView
          Left = 255.866141730000000000
          Top = 2.425169999999980000
          Width = 98.267709210000010000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PESO_PRODUZIDO_PRODUTO_ACABADO"]')
        end
        object Memo9: TfrxMemoView
          Left = 576.874460000000000000
          Top = 2.425169999999980000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUSTO_FORMULA_UNITARIO_PRODUTO_ACABADO"]')
        end
        object Memo11: TfrxMemoView
          Left = 663.803650000000000000
          Top = 2.425169999999980000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUSTO_COMPOSICAO_PRODUTO_ACABADO"]')
        end
        object Memo12: TfrxMemoView
          Left = 766.780150000000000000
          Top = 2.425169999999980000
          Width = 94.488186540000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECO_COMPRA_PRODUTO_ACABADO"]')
        end
        object Memo24: TfrxMemoView
          Left = 962.267716540000000000
          Top = 2.425169999999980000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoCusTot: TfrxMemoView
          Left = 361.314965510000000000
          Top = 2.425169999999980000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUSTO_RELATIVO_PRODUCAO_PRODUTO_ACABADO"]')
        end
        object Memo70: TfrxMemoView
          Left = 865.512370000000000000
          Top = 1.779530000000022000
          Width = 90.708656540000010000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CUSTO_PRODUTO_ACABADO"]')
        end
      end
      object ChildProAcaOPtIT: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 15.118120000000000000
        ParentFont = False
        Top = 438.425480000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.ChildProAcaOP
        KeepChild = True
        object Shape1: TfrxShapeView
          Top = 1.204700000000003000
          Width = 1046.551166460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Top = 1.204700000000003000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'D.ACA.')
        end
        object Memo17: TfrxMemoView
          Left = 62.732227320000000000
          Top = 1.204700000000003000
          Width = 79.370066540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(3) PESO/LIT.')
        end
        object mmoQtdProTit: TfrxMemoView
          Left = 146.708661420000000000
          Top = 1.204700000000003000
          Width = 102.047246540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(9) QTD. PRODUZ.')
        end
        object mmoQtdEnvTit: TfrxMemoView
          Left = 456.787880000000000000
          Top = 1.204700000000003000
          Width = 113.385836540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. ENVASADO')
        end
        object mmoPesAcaTit: TfrxMemoView
          Left = 255.921267170000000000
          Top = 1.204700000000003000
          Width = 98.267716540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PESO ACABA.')
        end
        object Memo21: TfrxMemoView
          Left = 576.748041260000000000
          Top = 1.204700000000003000
          Width = 83.149596540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNIT.')
        end
        object Memo22: TfrxMemoView
          Left = 663.677165350000000000
          Top = 1.204700000000003000
          Width = 98.267716540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(4)CUSTO COMP.')
        end
        object Memo23: TfrxMemoView
          Left = 766.771653540000000000
          Top = 1.204700000000003000
          Width = 94.488186540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(1) PRE'#199'O FINAL')
        end
        object Memo25: TfrxMemoView
          Left = 962.221090000000000000
          Top = 1.204700000000003000
          Width = 83.149596540000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(12) C. BAIXA')
        end
        object mmoCusTotTit: TfrxMemoView
          Left = 361.252320000000000000
          Top = 1.850340000000017000
          Width = 90.708656540000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO TOTAL')
        end
        object Memo4: TfrxMemoView
          Left = 865.512370000000000000
          Top = 1.000000000000000000
          Width = 90.708656540000010000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(11) CUS. FINAL')
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.ChildProAcaOPtIT
        object SubCombo: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.PagCombo
        end
      end
    end
    object PagCombo: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 124.724490000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBCombo
        DataSetName = 'frxDBCombo'
        RowCount = 0
        object frxDBCombofrxDBCombo: TfrxMemoView
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Memo.UTF8W = (
            '[frxDBCombo."CODIGO_ITEM"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 56.692950000000010000
          Width = 430.866420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Memo.UTF8W = (
            '[frxDBCombo."DESCRICAO_ITEM"]')
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 699.212598430000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCombo."CUSTO_TOTAL"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 596.031496060000000000
          Width = 94.488176770000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCombo."CUSTO_UNITARIO"]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 491.338900000000000000
          Width = 94.488176770000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBCombo."QUANTIDADE"]')
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 41.574803150000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.Child1
        object Memo26: TfrxMemoView
          Left = 7.559055120000000000
          Top = 14.960629920000000000
          Width = 1016.693570000000000000
          Height = 18.897650000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'COMPOSI'#199#195'O: [frxDBCombo."CODIGO_COMPOSICAO"] - [frxDBCombo."DESC' +
              'RICAO_COMPOSICAO"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 3.779530000000001000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.015770000000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 1046.929810000000000000
        object Memo31: TfrxMemoView
          Left = 699.213050000000000000
          Top = 3.779529999999994000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBCombo."CUSTO_TOTAL">,MasterData1)')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 472.661720000000000000
          Top = 3.779529999999994000
          Width = 219.212740000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '(4) TOTAL DA COMPOSI'#199#195'O:')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 1.779529999999994000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 20.897650000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 83.149660000000000000
        Width = 1046.929810000000000000
        object Shape2: TfrxShapeView
          Width = 1046.551166460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo33: TfrxMemoView
          Width = 415.748300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM DA COMPOSI'#199#195'O')
        end
        object Memo34: TfrxMemoView
          Left = 491.338900000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
        end
        object Memo35: TfrxMemoView
          Left = 596.165740000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PRE'#199'O CUSTO')
        end
        object Memo36: TfrxMemoView
          Left = 699.213050000000000000
          Top = 0.779529999999994100
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PRE'#199'O TOTAL')
        end
      end
    end
    object PagFormula: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 264.567100000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBFormula
        DataSetName = 'frxDBFormula'
        RowCount = 0
        object Memo46: TfrxMemoView
          Left = 2.220470000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Memo.UTF8W = (
            '[frxDBFormula."CODIGO_ITEM"]')
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Tag = 8
          Left = 57.913420000000000000
          Width = 430.866420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Memo.UTF8W = (
            '[frxDBFormula."DESCRICAO_ITEM"]')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Tag = 9
          Left = 596.031496060000000000
          Width = 94.488176770000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFormula."CUSTO_UNITARIO"]')
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Tag = 9
          Left = 491.338582680000000000
          Width = 75.590526770000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFormula."QUANTIDADE"]')
          WordWrap = False
          Formats = <
            item
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo51: TfrxMemoView
          Tag = 9
          Left = 699.212598430000000000
          Top = 0.220469999999977500
          Width = 147.401601650000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxDBFormula."TIPO"> = '#39'NORMAL'#39', <frxDBFormula."CUSTO_100K' +
              'G">, '#39'CORRE'#199#195'O'#39')]')
          WordWrap = False
        end
        object mmoCusPro: TfrxMemoView
          Left = 857.574803150000000000
          Width = 170.078754800000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFormula."CUSTO_PRODUCAO"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Tag = 7
          Left = 699.213050000000000000
          Width = 128.503951650000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFormula."QTD_PRODUCAO"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Tag = 9
          Left = 567.709030000000000000
          Width = 18.897576770000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[IIF(<frxDBFormula."TIPO"> = '#39'NORMAL'#39', '#39'%'#39', '#39'KG'#39')]')
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Tag = 7
          Left = 827.716535430000000000
          Width = 18.897581650000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'KG')
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 68.031540000000010000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.ChildProducao
        object Memo37: TfrxMemoView
          Left = 7.559055120000000000
          Top = 13.779530000000000000
          Width = 1031.811690000000000000
          Height = 18.897650000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'FORMULA'#199#195'O: [frxRelatorio."CODIGO_PRODUTO_GRANEL"] -  [frxRelato' +
              'rio."DESCRICAO_PRODUTO_GRANEL"]     COR: [frxRelatorio."CODIGO_C' +
              'OR"] -  [frxRelatorio."DESCRICAO_COR"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 3.779530000000001000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo38: TfrxMemoView
          Left = 22.866110000000000000
          Top = 42.236240000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '(11) Peso Real: ')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 112.133890000000000000
          Top = 42.236240000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."PESO_REAL"]')
          WordWrap = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 1046.929810000000000000
        object Shape3: TfrxShapeView
          Width = 1046.551166460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo41: TfrxMemoView
          Width = 415.748300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo42: TfrxMemoView
          Tag = 9
          Left = 491.338900000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
        end
        object Memo43: TfrxMemoView
          Tag = 9
          Left = 596.165740000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNIT'#193'RIO')
        end
        object Memo45: TfrxMemoView
          Tag = 9
          Left = 699.213050000000000000
          Width = 147.401608980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO DO ITEM (100KG)')
        end
        object mmoCusProTit: TfrxMemoView
          Left = 857.598950000000000000
          Width = 170.078788980000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '(5) CUSTO TOTAL PRODU'#199#195'O')
        end
        object Memo7: TfrxMemoView
          Tag = 7
          Left = 699.213050000000000000
          Width = 147.401608980000000000
          Height = 15.118120000000000000
          Visible = False
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE PRODUZIDA')
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.677180000000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        object Memo52: TfrxMemoView
          Tag = 9
          Left = 699.213050000000000000
          Top = 3.779530000000022000
          Width = 147.401601650000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBFormula."CUSTO_100KG">,MasterData2)')
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Tag = 9
          Left = 472.661720000000000000
          Top = 3.779530000000000000
          Width = 219.212740000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA PRODU'#199'AO:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 1.779530000000022000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 20.897650000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mmoCusProTot: TfrxMemoView
          Left = 857.574803150000000000
          Top = 3.779530000000022000
          Width = 170.078754800000000000
          Height = 15.118120000000000000
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBFormula."CUSTO_PRODUCAO">,MasterData2)')
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Tag = 7
          Left = 699.213050000000000000
          Top = 3.779530000000000000
          Width = 128.503924800000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBFormula."QTD_PRODUCAO">,MasterData2)')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Tag = 7
          Left = 827.717070000000000000
          Top = 3.779530000000000000
          Width = 18.897581650000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxDBCombo
          DataSetName = 'frxDBCombo'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'KG')
          WordWrap = False
        end
      end
      object ChildProducao: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 45.354360000000000000
        ParentFont = False
        Top = 109.606370000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.Child7
        PrintChildIfInvisible = True
        object Memo73: TfrxMemoView
          Left = 646.299630000000000000
          Top = 4.559060000000003000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'PESO TOTAL DA PRODU'#199#195'O (Kg):')
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 850.953310000000000000
          Top = 4.338589999999996000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTAL_PRODUZIDO_KILO">]')
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 18.897650000000000000
          Top = 23.692950000000000000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '(6) TOTAL ENVASADO:')
          WordWrap = False
        end
        object Memo77: TfrxMemoView
          Left = 220.551330000000000000
          Top = 24.252010000000010000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTAL_ENVASADO_KILO">] quilos.')
          WordWrap = False
        end
        object Memo79: TfrxMemoView
          Left = 18.897650000000000000
          Top = 4.236239999999995000
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '(5) CUSTO TOTAL DA PRODU'#199#195'O:')
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 220.551190870000000000
          Top = 4.236239999999995000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CUSTO_TOTAL_PRODUCAO">]')
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 364.834880000000000000
          Top = 24.456710000000020000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."TOTAL_ENVASADO_LITRO">] litros.')
          WordWrap = False
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677180000000000000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ.Child2
        object Memo81: TfrxMemoView
          Left = 18.897650000000000000
          Top = 0.574829999999991500
          Width = 200.315090000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.5f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            
              '(2) CUSTO POR [IIF(<frxRelatorio."KILO_LITRO_GRANEL"> = '#39'K'#39', '#39'QU' +
              'ILO'#39', '#39'LITRO'#39')] PRODUZIDO:')
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 224.330860000000000000
          Top = 1.354360000000014000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxDBFormula
          DataSetName = 'frxDBFormula'
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."KILO_LITRO_GRANEL"> = '#39'K'#39', <frxRelatorio."CU' +
              'STO_KILO">, <frxRelatorio."CUSTO_LITRO">)]')
          WordWrap = False
        end
      end
    end
    object PageFormulas: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 476.220780000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo60: TfrxMemoView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'COMO OS C'#193'LCULOS S'#195'O EFETUADOS')
        end
        object Memo61: TfrxMemoView
          Left = 7.559060000000000000
          Top = 83.149660000000000000
          Width = 1035.591220000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'CUSTO_DA_PRODU'#199'AO_POR_QUILO_LITRO (2) = CUSTO_TOTAL_PRODU'#199#195'O (5)' +
              ' / PESO_LITRAGEM_TOTAL_ENVASADA (6)')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 7.559055120000000000
          Top = 146.236240000000000000
          Width = 328.819110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PESO DO ACABADOS (7)')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 60.472480000000000000
          Top = 216.692950000000000000
          Width = 1024.252630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'PESO (4) = QUANTIDADE_A_PRODUZIR (9) * PESO_LITRO_DA_EMBALAGEM (' +
              '3) * PESO_ESPEC'#205'FICO_REAL (10)')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 26.456710000000000000
          Top = 254.488250000000000000
          Width = 1024.252630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PARA A PRODU'#199#195'O EM KILOS (8)')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 60.472440940000000000
          Top = 287.944960000000000000
          Width = 1024.252630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'PESO (4) = QUANTIDADE_A_PRODUZIR (9) * PESO_LITRO_DA_EMBALAGEM (' +
              '3)')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 26.456710000000000000
          Top = 180.252010000000000000
          Width = 328.819110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PARA PRODU'#199#195'O EM LITROS (8)')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 7.559060000000000000
          Top = 346.551330000000000000
          Width = 1035.591220000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'CUSTO FINAL DO PRODUTO ACABADO (11) = PRE'#199'O_PRODUTO_ACABADO (1) ' +
              '+ IMPOSTOS_DO_CADASTRO_DE_PRODUTOS')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 7.559060000000000000
          Top = 376.787570000000000000
          Width = 1035.591220000000000000
          Height = 22.677180000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'CUSTO FINAL DO PRODUTO ACABADO CALCULADO NA BAIXA DA ORDEM DE PR' +
              'ODU'#199#195'O (12)')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 7.559060000000000000
          Top = 41.574830000000000000
          Width = 1035.591220000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'PRE'#199'O_PRODUTO_ACABADO (1) = CUSTO_DA_PRODU'#199'AO_POR_QUILO_OU_LITRO' +
              ' (2) * PESO_LITRO_DA_EMBALAGEM (3) + PRE'#199'O_COMPOSI'#199#195'O (4)')
          ParentFont = False
        end
      end
    end
  end
  object frxDBCombo: TfrxDBDataset
    UserName = 'frxDBCombo'
    CloseDataSource = False
    DataSource = dtsComposicao
    BCDToCurrency = False
    Left = 336
    Top = 224
  end
  object frxDBFormula: TfrxDBDataset
    UserName = 'frxDBFormula'
    CloseDataSource = False
    DataSource = dtsFormula
    BCDToCurrency = False
    Left = 381
    Top = 229
  end
  object dtsItens: TDataSource
    Left = 144
    Top = 252
  end
  object dtsComposicao: TDataSource
    Left = 236
    Top = 256
  end
  object dtsFormula: TDataSource
    Left = 340
    Top = 184
  end
end
