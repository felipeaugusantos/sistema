inherited frmImpEtiDespacho: TfrmImpEtiDespacho
  Left = 370
  Top = 323
  Width = 366
  Height = 416
  BorderIcons = [biSystemMenu]
  Caption = 'Etiquetas - Despacho de Mercadorias'
  Position = poScreenCenter
  ExplicitWidth = 366
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 343
    Width = 360
    TabOrder = 1
    ExplicitTop = 343
    ExplicitWidth = 360
    DesignSize = (
      360
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 356
      TabOrder = 3
      ExplicitWidth = 356
    end
    inherited btnSair: TBitBtnLocked
      Left = 277
      TabOrder = 2
      ExplicitLeft = 277
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnConfigurar: TBitBtnLocked
      Left = 88
      Top = 3
      Width = 85
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F6] &Configurar'
      TabOrder = 1
      OnClick = btnConfigurarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 360
    TabOrder = 2
    ExplicitTop = 371
    ExplicitWidth = 360
    inherited pnlNomeForm: TPanel
      Left = 189
      ExplicitLeft = 189
    end
    inherited pnlInfo: TPanel
      Width = 189
      ExplicitWidth = 189
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 360
    Height = 343
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblEmpresa: TLabel
      Left = 8
      Top = 7
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
    object lblTituloNF: TLabel
      Left = 8
      Top = 47
      Width = 53
      Height = 14
      Caption = 'Chave NFe'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 35
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
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 46
      Top = 22
      Width = 306
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlCliente: TPanel
      Left = 0
      Top = 92
      Width = 360
      Height = 98
      Align = alBottom
      TabOrder = 4
      object Label4: TLabel
        Left = 9
        Top = 51
        Width = 32
        Height = 14
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 8
        Top = 68
        Width = 57
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 68
        Top = 68
        Width = 284
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgTpDestinatario: TRadioGroup
        Left = 8
        Top = 8
        Width = 344
        Height = 41
        Caption = ' Emitir Nota Fiscal Para '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '&Cliente'
          '&Fornecedor')
        TabOrder = 0
        OnClick = rdgTpDestinatarioClick
      end
    end
    object pnlDocumento: TPanel
      Left = 0
      Top = 190
      Width = 360
      Height = 45
      Align = alBottom
      TabOrder = 5
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 69
        Height = 14
        Caption = 'N'#186' Documento'
      end
      object Label2: TLabel
        Left = 100
        Top = 0
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
      end
      object Label3: TLabel
        Left = 150
        Top = 0
        Width = 61
        Height = 14
        Caption = 'Qtd Volumes'
      end
      object lblEtqInicial: TLabel
        Left = 218
        Top = 0
        Width = 45
        Height = 14
        Caption = 'Iniciar em'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 9
        Top = 16
        Width = 84
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 99
        Top = 16
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfabetico
      end
      object edtQtdVol: TEditFocus
        Tag = 99
        Left = 147
        Top = 16
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        MaxLength = 4
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 4
        TipoTexto = ttInteiro
      end
      object edtEtqInicial: TEditFocus
        Tag = 99
        Left = 218
        Top = 16
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 3
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttInteiro
      end
    end
    object pnlTipoEtiq: TPanel
      Left = 0
      Top = 291
      Width = 360
      Height = 52
      Align = alBottom
      TabOrder = 7
      object rdgTipoEtiq: TRadioGroup
        Left = 9
        Top = 1
        Width = 270
        Height = 47
        Caption = ' Tipo de etiqueta '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Etiq. &Despacho'
          'Etiq. &Montagem Caixa'
          'Etiq. &Volume Composto')
        TabOrder = 0
      end
    end
    object chkImpAut: TCheckBox
      Left = 226
      Top = 4
      Width = 126
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Impress'#227'o Autom'#225'tica'
      TabOrder = 0
    end
    object pnlVolumeSepExc: TPanel
      Left = 0
      Top = 235
      Width = 360
      Height = 56
      Align = alBottom
      ParentColor = True
      TabOrder = 6
      object lblQtdVolSepExc: TLabel
        Left = 62
        Top = 8
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vol. Sep. Exclusiva:'
      end
      object lblQtdVolSepNExc: TLabel
        Left = 40
        Top = 31
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vol. Sep. N'#227'o Exclusiva:'
      end
      object edtQtdVolSepExc: TEditFocus
        Left = 160
        Top = 5
        Width = 52
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdVolSepNExc: TEditFocus
        Left = 160
        Top = 28
        Width = 52
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtChave: TEditFocus
      Tag = 99
      Left = 8
      Top = 64
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 46
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = edtChaveChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 46
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 4
  end
  object frxEtiDespacho: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 40562.376002777790000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 4
    Datasets = <
      item
        DataSet = frxDados
        DataSetName = 'frxDados'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 100.000000000000000000
      PaperHeight = 60.000000000000000000
      PaperSize = 256
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 204.094502830000000000
        Top = 18.897650000000000000
        Width = 377.953000000000000000
        Columns = 1
        ColumnGap = 264.566929133858000000
        DataSet = frxDados
        DataSetName = 'frxDados'
        RowCount = 0
        object Memo1: TfrxMemoView
          Left = 13.968460000000000000
          Top = 18.220470000000000000
          Width = 351.496062992126000000
          Height = 26.456700240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDados."NUMDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 107.559060000000000000
          Top = 48.677180000000010000
          Width = 257.007874015748000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDados."NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 13.968460000000000000
          Top = 48.677180000000010000
          Width = 69.921269610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Remetente:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 13.968460000000000000
          Top = 95.031540000000010000
          Width = 88.818919610000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Destinat'#225'rio:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 107.716535430000000000
          Top = 95.252010000000000000
          Width = 257.007874015748000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDados."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 107.716535430000000000
          Top = 115.929190000000000000
          Width = 257.007905750000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDados."CIDCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 107.716535430000000000
          Top = 157.606308980000000000
          Width = 257.008040000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDados."QTDVOL"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 13.984251970000000000
          Top = 157.740260000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Volume:')
          ParentFont = False
        end
      end
    end
  end
  object frxDados: TfrxDBDataset
    UserName = 'frxDados'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 172
    Top = 4
  end
  object cdsCaixas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 237
    Top = 65532
    object cdsCaixasFGC_IMPRIM: TBooleanField
      FieldName = 'FGC_IMPRIM'
    end
    object cdsCaixasFGC_CAI_ID: TStringField
      DisplayLabel = 'ID Caixa'
      FieldName = 'FGC_CAI_ID'
    end
    object cdsCaixasFGO_DTAENT: TDateField
      FieldName = 'FGO_DTAENT'
    end
    object cdsCaixasFGO_NUMDOC: TStringField
      DisplayLabel = 'N'#250'm.Docto'
      DisplayWidth = 30
      FieldName = 'FGO_NUMDOC'
    end
    object cdsCaixasFGO_ESPDOC: TStringField
      DisplayLabel = 'Esp'
      DisplayWidth = 10
      FieldName = 'FGO_ESPDOC'
    end
    object cdsCaixasFGO_CODEMP: TStringField
      DisplayLabel = 'Emp'
      DisplayWidth = 10
      FieldName = 'FGO_CODEMP'
    end
    object cdsCaixasFGC_NUMFAT: TStringField
      DisplayLabel = 'N'#250'm.Fatur.'
      DisplayWidth = 30
      FieldName = 'FGC_NUMFAT'
    end
    object cdsCaixasFGC_TIPFAT: TStringField
      DisplayLabel = 'Esp'
      DisplayWidth = 10
      FieldName = 'FGC_TIPFAT'
    end
    object cdsCaixasFGC_EMPFAT: TStringField
      DisplayLabel = 'Emp'
      DisplayWidth = 10
      FieldName = 'FGC_EMPFAT'
    end
    object cdsCaixasFDO_CODVEN: TStringField
      FieldName = 'FDO_CODVEN'
      Size = 3
    end
    object cdsCaixasFDO_CODVE2: TStringField
      FieldName = 'FDO_CODVE2'
      Size = 3
    end
    object cdsCaixasCLI_BAIRRO: TStringField
      FieldName = 'CLI_BAIRRO'
      Size = 60
    end
    object cdsCaixasCLI_C_E_P_: TStringField
      FieldName = 'CLI_C_E_P_'
      Size = 9
    end
    object cdsCaixasCLI_CODCLI: TStringField
      FieldName = 'CLI_CODCLI'
      Size = 8
    end
    object cdsCaixasCLI_ENDERE: TStringField
      FieldName = 'CLI_ENDERE'
      Size = 60
    end
    object cdsCaixasCLI_ENDNUM: TStringField
      FieldName = 'CLI_ENDNUM'
      Size = 10
    end
    object cdsCaixasCLI_ENDCOM: TStringField
      FieldName = 'CLI_ENDCOM'
      Size = 60
    end
    object cdsCaixasCLI_CODCID: TStringField
      FieldName = 'CLI_CODCID'
      Size = 5
    end
    object cdsCaixasCLI_FANSOB: TStringField
      FieldName = 'CLI_FANSOB'
      Size = 60
    end
    object cdsCaixasFDO_NUMCMP: TStringField
      FieldName = 'FDO_NUMCMP'
      Size = 15
    end
    object cdsCaixasFGO_SEPEXP: TStringField
      FieldName = 'FGO_SEPEXP'
      Size = 3
    end
    object cdsCaixasFGO_OPEEXP: TStringField
      FieldName = 'FGO_OPEEXP'
      Size = 3
    end
    object cdsCaixasREG_DESREG: TStringField
      FieldName = 'REG_DESREG'
      Size = 40
    end
    object cdsCaixasTRA_NOMTRA: TStringField
      FieldName = 'TRA_NOMTRA'
      Size = 40
    end
    object cdsCaixasFGC_FDOINC: TStringField
      FieldName = 'FGC_FDOINC'
    end
    object cdsCaixasFDO_TOTPES: TFloatField
      FieldName = 'FDO_TOTPES'
    end
    object cdsCaixasFGO_PESBRU: TFloatField
      FieldName = 'FGO_PESBRU'
    end
    object cdsCaixasFGO_CODROT: TStringField
      FieldName = 'FGO_CODROT'
      Size = 8
    end
    object cdsCaixasREG_CODREG: TStringField
      FieldName = 'REG_CODREG'
      Size = 8
    end
    object cdsCaixasENDENT: TStringField
      FieldName = 'ENDENT'
      Size = 60
    end
    object cdsCaixasCEPENT: TStringField
      FieldName = 'CEPENT'
      Size = 9
    end
    object cdsCaixasCIDENT: TStringField
      FieldName = 'CIDENT'
      Size = 60
    end
    object cdsCaixasESTENT: TStringField
      FieldName = 'ESTENT'
      Size = 2
    end
    object cdsCaixasBAIENT: TStringField
      FieldName = 'BAIENT'
      Size = 60
    end
  end
  object cdsEtiCaixa: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    IndexFieldNames = 'descricao'
    Params = <>
    Left = 237
    Top = 56
    object fldEtiCaixaid: TStringField
      FieldName = 'id'
    end
    object fldEtiCaixapedido: TStringField
      DisplayLabel = 'Pedido'
      DisplayWidth = 12
      FieldName = 'pedido'
      Size = 12
    end
    object fldEtiCaixacodigo: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
      Size = 6
    end
    object strngfldEtiCaixadescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 100
    end
    object cdsEtiCaixaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      DisplayFormat = '#,##0.000'
    end
    object fldEtiCaixaunidade: TStringField
      DisplayLabel = 'UN'
      FieldName = 'unidade'
      Size = 5
    end
    object cdsEtiCaixapeso: TFloatField
      FieldName = 'peso'
    end
    object cdsEtiCaixaSeqCx: TSmallintField
      FieldName = 'SeqCx'
    end
    object cdsEtiCaixacodfab: TStringField
      FieldName = 'codfab'
      Size = 50
    end
    object cdsEtiCaixafgoinc: TStringField
      FieldName = 'fgoinc'
    end
    object cdsEtiCaixafdoinc: TStringField
      FieldName = 'fdoinc'
    end
    object cdsEtiCaixaCodBar: TStringField
      FieldName = 'CodBar'
      Size = 12
    end
    object cdsEtiCaixaDtaRot: TStringField
      FieldName = 'DtaRot'
      Size = 5
    end
    object cdsEtiCaixaseqCxId: TStringField
      FieldName = 'seqCxId'
    end
    object cdsEtiCaixapestot: TAggregateField
      FieldName = 'pestot'
      Active = True
      DisplayName = ''
      Expression = 'sum( quantidade * peso )'
    end
  end
  object cdsAmbiente: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 56
    object cdsAmbienteAMBIENTE: TStringField
      FieldName = 'AMBIENTE'
      Size = 256
    end
    object cdsAmbienteVOLUME: TIntegerField
      FieldName = 'VOLUME'
    end
  end
end
