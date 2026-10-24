inherited frmRelFatDocTinta: TfrmRelFatDocTinta
  Width = 339
  Height = 308
  Caption = 'Formula'#231#227'o de documentos - Tinta de m'#225'quina'
  ExplicitWidth = 339
  ExplicitHeight = 308
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 237
    Width = 333
    ExplicitTop = 237
    ExplicitWidth = 333
    inherited FlwBotoes: TFlowPanel
      Width = 252
      ExplicitTop = 2
      ExplicitWidth = 252
    end
    inherited btnSair: TBitBtnLocked
      Left = 254
      ExplicitLeft = 254
    end
  end
  inherited pnlDados: TPanel
    Width = 333
    Height = 227
    ExplicitWidth = 333
    ExplicitHeight = 227
    object Label5: TLabel [0]
      Left = 7
      Top = 7
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [1]
      Left = 7
      Top = 44
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [2]
      Left = 98
      Top = 25
      Width = 75
      Height = 14
      Caption = '(MOVIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [3]
      Left = 98
      Top = 62
      Width = 75
      Height = 14
      Caption = '(MOVIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [4]
      Left = 7
      Top = 121
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [5]
      Left = 7
      Top = 83
      Width = 29
      Height = 14
      Caption = 'Tintas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 163
      TabOrder = 5
      ExplicitTop = 163
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 21
      Width = 86
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
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 58
      Width = 88
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 135
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 73
      Top = 135
      Width = 248
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTintasDisp: TEditFocus
      Tag = 99
      Left = 7
      Top = 96
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtTintasDispKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesTinta: TEditFocus
      Left = 73
      Top = 96
      Width = 248
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbEspecie: TGroupBox
      Left = 175
      Top = 163
      Width = 146
      Height = 45
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 20
        Width = 104
        Height = 14
        Caption = '(P)edido (O)r'#231'amento'
        CorDestaque = clRed
      end
      object edtEspecie: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'P'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  object pbProgresso: TProgressBar [3]
    Left = 0
    Top = 227
    Width = 333
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 263
    Width = 333
    ExplicitTop = 263
    ExplicitWidth = 333
    inherited pnlNomeForm: TPanel
      Left = 162
      ExplicitLeft = 162
    end
    inherited pnlInfo: TPanel
      Width = 162
      ExplicitWidth = 162
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 64
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 176
    Top = 64
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 136
    Top = 120
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 272
    Top = 112
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 240
    Top = 112
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 208
    Top = 112
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 176
    Top = 112
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 240
    Top = 64
  end
  inherited frxGen: TfrxUserDataSet
    Left = 272
    Top = 64
  end
  inherited frxDesigner: TfrxDesigner
    Left = 240
    Top = 160
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 272
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 0
  end
  object cdsFormulacao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 63
    Top = 48
    object cdsFormulacaoNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsFormulacaoESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsFormulacaoCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsFormulacaoNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 100
    end
    object cdsFormulacaoDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsFormulacaoIDEPRO: TStringField
      FieldName = 'IDEPRO'
      Size = 3
    end
    object cdsFormulacaoTINTA: TStringField
      FieldName = 'TINTA'
      Size = 70
    end
    object cdsFormulacaoDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsFormulacaoQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsFormulacaoVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsFormulacaoUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 3
    end
    object cdsFormulacaoVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      Size = 100
    end
  end
  object frxQckJatoTinta: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42720.403845694450000000
    ReportOptions.LastChange = 42720.403845694450000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 96
    Datasets = <
      item
        DataSet = frxGen
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
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 18.897650000000000000
        Width = 778.205227000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 105.638046570000000000
          Top = 3.779530000000000000
          Width = 566.929133860000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
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
          Left = 105.638046570000000000
          Top = 20.779530000000000000
          Width = 566.929133860000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMULA'#199#195'O DE DOCUMENTOS - TINTA DE M'#193'QUINA')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 653.405227000000000000
          Top = 37.779530000000000000
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
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 211.502613500000000000
          Top = 37.779530000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 81.779530000000000000
          Width = 359.055118110000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Top = 100.826840000000000000
          Width = 359.055118110000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TINTA]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Top = 119.944960000000000000
          Width = 359.055118110000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESPECIE]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 219.212740000000000000
        Width = 778.205227000000000000
        object Memo3: TfrxMemoView
          Left = 2.779530000000000000
          Top = 3.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Doc.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 92.826840000000000000
          Top = 3.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 123.063080000000000000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 249.244280000000000000
          Top = 3.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. Ent.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 315.590551181102400000
          Top = 3.000000000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 673.401980000000000000
          Top = 3.000000000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtd.')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 717.976810000000000000
          Top = 3.000000000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.559060000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 1.559060000000000000
          Top = 20.897650000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 264.567100000000000000
        Width = 778.205227000000000000
        Condition = 'frxRelatorio."VENDEDOR"'
        object Memo8: TfrxMemoView
          Left = 27.354360000000000000
          Top = 3.000000000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 94.047310000000000000
          Top = 3.000000000000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 778.205227000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo14: TfrxMemoView
          Left = 2.779530000000000000
          Top = 1.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 92.826840000000000000
          Top = 1.779530000000000000
          Width = 26.456692910000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ESPDOC"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 123.078850000000000000
          Top = 1.779530000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 249.244280000000000000
          Top = 1.779530000000000000
          Width = 60.472448270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 315.512060000000000000
          Top = 1.779530000000000000
          Width = 351.496258270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 673.401980000000000000
          Top = 1.779530000000000000
          Width = 45.354328270000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 717.976810000000000000
          Top = 1.779530000000000000
          Width = 68.031508270000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Width = 778.205227000000000000
        object Memo21: TfrxMemoView
          Left = 617.488560000000000000
          Top = 3.000000000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtd. de F'#243'rmulas:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 718.315400000000000000
          Top = 3.000000000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 2.000000000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 2.220470000000000000
          Top = 20.897650000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 566.929500000000000000
        Width = 778.205227000000000000
        object Memo25: TfrxMemoView
          Align = baRight
          Left = 396.472697000000000000
          Width = 381.732530000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object rllNomeForm: TfrxMemoView
          Width = 397.077180000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 525.354670000000000000
        Width = 778.205227000000000000
        object Memo23: TfrxMemoView
          Left = 654.945270000000000000
          Top = 1.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtd. Total:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 717.976810000000000000
          Top = 1.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 1.015770000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 309.921460000000000000
        Width = 778.205227000000000000
        Condition = 'frxRelatorio."TINTA"'
        object Memo5: TfrxMemoView
          Left = 110.590600000000000000
          Top = 1.779530000000000000
          Width = 275.905690000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."TINTA"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 71.015770000000000000
          Top = 1.779530000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tinta:')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 1.000000000000000000
          Top = 20.897650000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 442.205010000000000000
        Width = 778.205227000000000000
        object Memo26: TfrxMemoView
          Left = 617.488560000000000000
          Top = 3.779530000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtd. de F'#243'rmulas:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 718.315400000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
    end
  end
  object frxQckMatricial: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41703.719305138890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        ' '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 66
    Top = 148
    Datasets = <
      item
        DataSet = frxGen
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 347.979775263061800000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1296.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo50: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."ESPDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object rllQtdTot: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object rllAvu: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          TruncOutboundText = False
        end
        object rllQtd: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object DMPMemo162: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR"]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 595.000000000000000000
        Width = 1296.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo8OnBeforePrint'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1296.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo46: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Documento')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Esp.')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Dta. Ent.')
          TruncOutboundText = False
        end
        object rllDesTot: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Valor')
          TruncOutboundText = False
        end
        object DMPMemo156: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Qtd.')
          TruncOutboundText = False
        end
        object rllDesQtd: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Cliente')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          TruncOutboundText = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1296.000000000000000000
        object DMPMemo9: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Align = baCenter
          Left = 403.200000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMULACAO TINTA DE MAQUINA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Align = baCenter
          Left = 470.400000000000000000
          Top = 51.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[TINTA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[ESPECIE]')
          TruncOutboundText = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 544.000000000000000000
        Width = 1296.000000000000000000
        object DMPMemo54: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. TOTAL:')
          TruncOutboundText = False
        end
        object DMPMemo168: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 323.000000000000000000
        Width = 1296.000000000000000000
        Condition = 'frxRelatorio."TINTA"'
        object rllTitCli: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Tinta :')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."TINTA"]')
          TruncOutboundText = False
        end
      end
      object GroupFooterCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 1296.000000000000000000
        object rllTotCli: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. DE F'#211'RMULAS:')
          TruncOutboundText = False
        end
        object DMPMemo169: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1296.000000000000000000
        Condition = 'frxRelatorio."VENDEDOR"'
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Vendedor :')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 1104.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 1296.000000000000000000
        object DMPMemo6: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. DE F'#211'RMULAS:')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          TruncOutboundText = False
        end
      end
    end
  end
end
