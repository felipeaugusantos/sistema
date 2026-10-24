inherited frmRelCtrBordero: TfrmRelCtrBordero
  Left = 484
  Top = 228
  Width = 362
  Height = 383
  Caption = 'Relat'#243'rio de Border'#244' para Desconto de T'#237'tulos'
  OnDestroy = FormDestroy
  ExplicitWidth = 362
  ExplicitHeight = 383
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 312
    Width = 356
    ExplicitTop = 312
    ExplicitWidth = 356
    inherited FlwBotoes: TFlowPanel
      Width = 275
      ExplicitWidth = 275
      inherited btnConfigurar: TBitBtnLocked
        Width = 89
        ExplicitWidth = 89
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 277
      ExplicitLeft = 277
    end
  end
  inherited pnlStatus: TPanel
    Top = 338
    Width = 356
    ExplicitTop = 338
    ExplicitWidth = 356
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
      inherited shpMultSel: TShape
        Left = 154
        ExplicitLeft = 154
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 356
    Height = 312
    ExplicitWidth = 356
    ExplicitHeight = 312
    object lbl1: TLabel [0]
      Left = 7
      Top = 97
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
    object lblDtaIni: TLabel [1]
      Left = 120
      Top = 77
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDtaFin: TLabel [2]
      Left = 120
      Top = 117
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel [3]
      Left = 7
      Top = 57
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
    object lblCliente: TLabel [4]
      Left = 8
      Top = 178
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
    object lblEmpresa: TLabel [5]
      Left = 8
      Top = 218
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
    object lblPortador: TLabel [6]
      Left = 8
      Top = 258
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblBanco: TLabel [7]
      Left = 8
      Top = 138
      Width = 82
      Height = 14
      Caption = 'Layout do Banco'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 191
      Top = 8
      Width = 154
      Height = 43
      TabOrder = 1
      ExplicitLeft = 191
      ExplicitTop = 8
      ExplicitWidth = 154
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 107
        Caption = '(V)'#237'deo   (I)mpressora'
        ExplicitTop = 19
        ExplicitWidth = 107
      end
    end
    object grpTipoData: TGroupBox
      Left = 8
      Top = 8
      Width = 177
      Height = 43
      Caption = 'Tipo de Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lbl3: TColorLabel
        Left = 28
        Top = 19
        Width = 126
        Height = 14
        Caption = '(C)adastro   (V)encimento'
        CorDestaque = clRed
      end
      object edtTipoDta: TEditFocus
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
        Text = 'C'
        OnExit = edtTipoDtaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtCodCli: TEditFocus
      Left = 8
      Top = 192
      Width = 69
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
      TabOrder = 6
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 80
      Top = 192
      Width = 265
      Height = 22
      TabStop = False
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 232
      Width = 40
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
      TabOrder = 8
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
    object edtDesEmp: TEditFocus
      Left = 48
      Top = 232
      Width = 297
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 8
      Top = 272
      Width = 40
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 10
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 48
      Top = 272
      Width = 297
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBanco: TEditFocus
      Tag = 99
      Left = 8
      Top = 152
      Width = 40
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
      TabOrder = 4
      OnExit = edtBancoExit
      OnKeyPress = edtBancoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesBanco: TEditFocus
      Left = 48
      Top = 152
      Width = 297
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaIni: TcxDateEdit
      Tag = 99
      Left = 7
      Top = 70
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      TabOrder = 2
      Width = 105
    end
    object edtDtaFin: TcxDateEdit
      Tag = 99
      Left = 7
      Top = 110
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
        79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
        DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
        35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
        BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
        B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
        FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
        30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
        F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
        78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
        16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
        A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
        7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
        48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
        67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
        43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
        F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
        3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
        ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
        49454E44AE426082}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ShowTime = False
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      TabOrder = 3
      Width = 105
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 112
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 488
    Top = 64
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 608
    Top = 112
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 608
    Top = 64
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 608
    Top = 16
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 552
    Top = 112
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 552
    Top = 64
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 304
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 552
    Top = 16
  end
  inherited frxDesigner: TfrxDesigner
    Left = 672
    Top = 64
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 672
    Top = 112
  end
  object frxRelatorioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40269.443597175900000000
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
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 192
    Top = 56
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 436.297634891110800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 323.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 633.600000000000000000
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
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbTitAbe: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 204.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object rllHistorA: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CNPJ/CPF')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'ESP.')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'SACADO')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          TruncOutboundText = False
        end
        object rllCap001: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CIDADE-UF')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        Child = frxRelatorioM.CFiltros
        Stretched = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
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
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 998.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 249.600000000000000000
          Top = 51.000000000000000000
          Width = 758.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rdbDuplicata: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DM')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbSacado: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[(Copy(<frxRelatorio."CLI_NOMCLI">,0,30))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbHistor: TfrxDMPMemoView
          Left = 556.800000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CLI_CGCCPF"> = '#39'1'#39', FormatMaskText('#39'00.000.0' +
              '00/0000-00;0'#39',<frxRelatorio."CLI_C_G_C_">),FormatMaskText('#39'000.0' +
              '00.000-00;0'#39',<frxRelatorio."CLI_C_G_C_">))]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDtaVen: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 748.800000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCID"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object CFiltros: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 119.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 624.000000000000000000
          Top = 17.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILPOR]')
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEMP]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40269.441531932870000000
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
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 248
    Top = 56
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
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
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 343.937230000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 5.820470000000000000
          Top = 5.661409999999989000
          Width = 399.269140000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 387.325850000000000000
          Top = 5.661409999999989000
          Width = 361.776190000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbTitAbe: TfrxHeader
        FillType = ftBrush
        Height = 24.543290000000000000
        Top = 215.433210000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 755.906000000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clScrollBar
        end
        object rllHistorA: TfrxMemoView
          Left = 339.574817800000000000
          Top = 4.661410000000000000
          Width = 103.181102360000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 1.889763780000000000
          Top = 4.661410000000000000
          Width = 123.212598425196900000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 578.842529450000000000
          Top = 4.661410000000000000
          Width = 30.992125980000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESP.')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 130.015774880000000000
          Top = 4.661410000000000000
          Width = 205.984251968503900000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SACADO')
          ParentFont = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 613.370088500000000000
          Top = 4.661410000000000000
          Width = 50.645659530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCTO.')
          ParentFont = False
        end
        object rllCap001: TfrxMemoView
          Left = 666.929133860000000000
          Top = 4.661410000000000000
          Width = 85.417322830000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DUPLICATA')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 446.645681500000000000
          Top = 4.661410000000000000
          Width = 128.503932130000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CIDADE-UF')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 134.133890000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Stretched = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 31.634880000000000000
          Top = 5.661410000000000000
          Width = 692.636240000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 80.768770000000000000
          Top = 26.440940000000000000
          Width = 594.368460000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 633.902040000000000000
          Top = 49.118120000000010000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 613.870500000000000000
          Top = 69.897650000000000000
          Width = 135.231540000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]-[Time]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 128.315245000000000000
          Top = 47.220470000000000000
          Width = 499.275510000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 9.600000000000000000
          Top = 94.488250000000000000
          Width = 374.173250310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILCLI]')
        end
        object Memo12: TfrxMemoView
          Left = 385.889610000000000000
          Top = 94.488250000000000000
          Width = 362.834660310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FILPOR]')
        end
        object Memo56: TfrxMemoView
          Left = 9.600000000000000000
          Top = 113.488250000000000000
          Width = 374.173250310000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FILEMP]')
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 264.567100000000000000
        Width = 755.906000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo3: TfrxMemoView
          Width = 755.906000000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object rdbDuplicata: TfrxMemoView
          Left = 1.889763780000000000
          Top = 1.000000000000000000
          Width = 123.212625280000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 578.842529450000000000
          Top = 1.000000000000000000
          Width = 30.992125980000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DM')
          ParentFont = False
          WordWrap = False
        end
        object rdbSacado: TfrxMemoView
          Left = 130.015774880000000000
          Top = 1.000000000000000000
          Width = 205.984247090000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbHistor: TfrxMemoView
          Left = 339.574817800000000000
          Top = 1.000000000000000000
          Width = 103.181102360000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CLI_CGCCPF"> = '#39'1'#39', FormatMaskText('#39'00.000.0' +
              '00/0000-00;0'#39',<frxRelatorio."CLI_C_G_C_">),FormatMaskText('#39'000.0' +
              '00.000-00;0'#39',<frxRelatorio."CLI_C_G_C_">))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 666.929133860000000000
          Top = 1.000000000000000000
          Width = 85.417322830000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
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
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDtaVen: TfrxMemoView
          Left = 613.370088500000000000
          Top = 1.000000000000000000
          Width = 50.645659530000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 446.645681500000000000
          Top = 1.000000000000000000
          Width = 128.503932130000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxRelatBBJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40288.647943969900000000
    ReportOptions.LastChange = 40291.492884652770000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 192
    Top = 112
    Datasets = <
      item
        DataSet = frxCadEmp
        DataSetName = 'frxCadEmp'
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
    object PagBBrasil: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 160.629923700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Picture1: TfrxPictureView
          Left = 1.779529999999999000
          Top = 1.259740000000001000
          Width = 185.196970000000000000
          Height = 34.015769999999990000
          Picture.Data = {
            0A544A504547496D616765750A0000FFD8FFE000104A46494600010101006000
            600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
            0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
            3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
            3232323232323232323232323232323232323232323232323232323232323232
            32323232323232323232323232FFC0001108001F00B003012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F679
            65904AE03B7DE3DEA37B93146D24931445196666C003EB4E97FD73FF00BC6BCE
            3C676FE209EE8ACE57FB3B394319DB1AFBBE7BFD78F4AFCBF2DC1CF31C73A12A
            FC8AEF56FCF64BABF23A7115BD8D3E651B9D0AF8FB4B6D4BEC9F689447D05C1F
            B99FE78F7FFF005D5FD43C516761716F6FF6869AE2E1942246D9E18F0C4F615E
            7835157D162D3BECD6925A42E4C9752465013E8B8E49F7EA7B8AD3F07D96A2DA
            90B9B6887F6621211EED0160A4FF0007A1FA715F518DC870B87A52C44E528A82
            7A39FC5DB5B5D37BB8DAF6EC7053C6549C94159DFCB6EFF2F33D1FCD93FE7A37
            E7479B27FCF46FCEBCE3C7A226F1269CB7071098D4487D1779CFE950684B145E
            368E2D0A79A4B01CC85B2015C739E99E7A715E4D2E1EAB5300B19EDDABC1CEDC
            AF974E8E5CDBBE9A1D12C6A557D9F2F54B7D7EEB1E9DE6C9FF003D1BF3A3CD93
            FE7A37E75C2DD78CAEA1F13B5AAA45FD9C970B03B95391D8F39F5CFE552EBDE2
            DBBD1FC4A969B6236602349953BB07AE0E6B8E39066B29C29A7ACE3CEBDEE8AD
            A7AEAB43478CA0937D9D8ED7CD93FE7A37E7479B27FCF46FCEB89BCF175D5A49
            ACE12175B5644B7E0F25B3C9E79E952D96B3E20B79E09750B64B8B29ADBCF696
            18C8F2BE52704F4CF1FAD43C933154FDA4A69764E566FDD52B2F3B35F3D10FEB
            749BB25F879D8EC7CD93FE7A37E7479B27FCF46FCEBCF3FE12AD7CE95FDB5B6D
            3EC827F2BC9D8738C75CFE95AFAFF886F6D068DFD9E211FDA1FF003D54B633B3
            1D0FFB5573C8732856851E74DC9C97C4EC9C55DA7E6909632938B95B6B74EFA2
            3ACF364FF9E8DF9D1E6C9FF3D1BF3AE2A3F15DFD85DEA765AAC36ED3DA426446
            872158F181CFAEE154FF00E12BD6ED2D2C754BC5B57B2BA761E52290CA01C75F
            CFD6AA1C3D9A4F692D6DCBEF7C578F32E5F977B03C6D15FAE9B6B6D4F41F364F
            F9E8DF9D1E6C9FF3D1BF3AF36F1C2C0DE30D3D6E9B6DB98A3129F44F31B3FA66
            AB69327D8FC4B76DA14D2CBA7C30BC8C5F3B4E109E4719F9B18AEBA5C395AAE0
            A38A55DA6E0E7669F2EF6E5E6E6DDF456D4CE58E51AAE0E3D6DBEBEB6B1EA5E6
            C9FF003D1BF3A3CD93FE7A37E75E72BE30D7A3D2E2D5244B17B669FC92815831
            38CFAFA77ABBE22F185E69FA92C163146D1A42924C24524A96EDD78E0AFE75CF
            FEADE6BEDA346324DBE6DA5A2E5B5D3FBD7DE5FD7A872B93F2E9DCEE7CD93FE7
            A37E7479B27FCF46FCEB88D4BC5B7ADAF43A769DF658A39111966B9CE0EE5DC3
            91DB903EB5635DD6F57D0ED34F12B5ABDC4D232C8550EDC02318E7DEB9E39266
            2E54A0E694AAABC5393BDACDDDF6D8A78BA5693B691DCEBFCD93FE7A37E7479B
            27FCF46FCEB9BD1F5ABABFF116A961308FC9B56223DAB83F7B1CF35D0D7978CA
            58AC254F65564EF64F46F66AEBF066F4E71A8B9A23E5FF005CFF00EF1AF2FF00
            134D3DCEB6E65BA4D46CEDDB2D6F0315F2C7B8F6EE467DC8AF52962732B9C7F1
            1EF59FA7E876BA6093ECD6E03CA4B48E7966C9CF27D3DABD8CAB18F2DC4D5AF2
            A4E52D92B777ABE6DE3A6D6EE6189A2EB45413B2FEBA753CC6486C8E90DA90D4
            ADE7B946DB15B489B446BEC838CFFE3BD7AD6CF832CB5F6B917AF3BC56521DCE
            B365BCDFA0EDF5FE75D4AF83F495D4BEDC2C97CCEBB33F203EBB7A67F4ADAF29
            FF00BBFAD7AF99F114AAE1A587C3D272E7DDCE2BDD5FCB1495B4EFDF5B5F539A
            8607966A7376B766F5F3679FF8D6DE77F1169F3A59CD710C68A5C47196040724
            8FCAA86CBCB9F128D5EC7469ECEDEDD7795F28AEEDA3A631D4F4C0AF4FF29FFB
            BFAD1E53FF0077F5AE1C367F88A186850FABDF962E17BCB5527AE9B5CD67828C
            A6E7CDBBBFDC7947FC23BAC4DE1996EDB2434DE735B988F9ACD9DB9E99EE4E2B
            4134FB9D7F5473716D34666D302EF9232009571DCFB8FCABD1FCA7FEEFEB4794
            FF00DDFD6B5A9C4F8E9F34BD8DA577CAD26B953B69B6B6E55AB256029AB2E6D3
            AF9FF573C8AD348D4EE347D4D5ECEE3CD430B2AB464160BB81C71CE01AE96D35
            7D4F538EDF49B2B0296FF62F2EE259E361B1B691C1CE3D3B5771E53FF77F5A3C
            A7FEEFEB538CE21AD8BBBAB85BBBDE3BDA2F95476B6BB5D6D663A78254FE19FA
            F9EB73CA7379FF0008B9D07FB3AEFED9F6ADD8F28E36FD7EB5B3E26B3B8B58FC
            3412DA698598C482142E46DF2FFC0D77BE53FF0077F5A3CA7FEEFEB4A7C43887
            5E15A387B24E726B5D5CE3CAFA68BB205828A838B9765F24EE79BCBA5DFF0088
            352D63524B2B8B78A4836C2B32ED6760140183FEE9AA730BBD5342D2B4486C6E
            96E6191BCDDF110AB927073F8D7AA794FF00DDFD68F29FFBBFAD5D3E24C54395
            7D5F485B916BEEDA2E2AFF00CDA3F2D44F01177F7B7DFCF5BFC8F3EF18413FFC
            25DA7DD0B29AE608A38DA411C45810246247A74FE7547EC379A96BF717F65A54
            F636A207C868F667F764631DC9F415E9FE53FF0077F5A3CA7FEEFEB59E1F8871
            3430F0A31C3EB18B85DF36CDDDE9B5CA9E0A339B9396EEFF00D33CA6DB47BA83
            45B1D4BEC32C92DBDD9125BBC44974E08F948E9D47E35663D1F57D6CEB57E14C
            0B393FBA9E23BDD41DCAA33D3A28AF4DF29FFBBFAD1E53FF0077F5ADA7C538E9
            373543DFBE8DA6ECB994AD66BBADF7FB910B2FA6B4E6D3FE058F3385ED2E7408
            2CF54D0F5392EE042893C30608193B4673DB3D0835465B0D65B45D392E6DAE98
            25CB796AC8C59570BF90CE71F8D7AD794FFDDFD68F29FF00BBFAD3A7C4D88A52
            E68619FC4E566E4D26D3BF2E9EEEFD01E02325673E96DBF3EE79FD8DE4BA2F8A
            F58B89B4EBF9639A4210C1016CFCD9CF38AEF15B7286C11919C1A93CA7FEEFEB
            4794FF00DDFD6BC0CCF11531D28CFD8B8C9249BD5DEC925A5B4D8EBA14FD926B
            9AE8FFD9}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 449.764070000000000000
          Top = 0.480210000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Border'#244' para Desconto de T'#237'tulos')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.275510000000000000
          Width = 222.992270000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 226.771800000000000000
          Top = 37.275510000000000000
          Width = 113.385900000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 340.157700000000000000
          Top = 37.275510000000000000
          Width = 113.385900000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 453.543600000000000000
          Top = 37.275510000000000000
          Width = 298.582870000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 67.511750000000000000
          Width = 449.764070000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 453.543600000000000000
          Top = 67.511750000000000000
          Width = 151.181200000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 604.724800000000000000
          Top = 67.511750000000000000
          Width = 147.401670000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 97.747990000000000000
          Width = 449.764070000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 453.543600000000000000
          Top = 97.747990000000000000
          Width = 151.181200000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 604.724800000000000000
          Top = 97.747990000000000000
          Width = 49.133890000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 653.858690000000000000
          Top = 97.747990000000000000
          Width = 98.267780000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 126.322820000000000000
          Width = 748.346940000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Com base no contrato acima indicado, solicitamos proceder ao des' +
              'conto do(s) t'#237'tulo(s) relacionado(s) abaixo, encaminhado por mei' +
              'o eletr'#244'nico.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 7.559060000000000000
          Top = 36.275510000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Contrato')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 230.551330000000000000
          Top = 36.275510000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contrato Nro.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 343.937230000000000000
          Top = 36.275510000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 457.323130000000000000
          Top = 36.275510000000000000
          Width = 75.590599999999970000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome da Ag'#234'ncia')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 7.559060000000000000
          Top = 66.511750000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Descontante')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 7.559060000000000000
          Top = 96.747990000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 457.323130000000000000
          Top = 96.747990000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 457.323130000000000000
          Top = 66.511750000000000000
          Width = 83.149659999999970000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Conta Corrente - DV')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 608.504330000000000000
          Top = 66.511750000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ / MF')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 608.504330000000000000
          Top = 96.747990000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UF')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 657.638220000000000000
          Top = 96.747990000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 143.842610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 5.291338582677165000
          Top = 145.842610000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nr. T'#237'tulo')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 102.047310000000000000
          Top = 143.842610000000000000
          Width = 238.110390000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 340.157700000000000000
          Top = 143.842610000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 434.645950000000000000
          Top = 143.842610000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 551.811380000000000000
          Top = 143.842610000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 593.386210000000000000
          Top = 143.842610000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 653.858690000000000000
          Top = 143.842610000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 105.826840000000000000
          Top = 145.842610000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sacado')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 343.937230000000000000
          Top = 145.842610000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ / CPF / MF')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 438.425480000000000000
          Top = 145.842610000000000000
          Width = 90.708720000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade / UF')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 555.590910000000000000
          Top = 145.842610000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp'#233'cie')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 597.165740000000000000
          Top = 145.842610000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 657.638220000000000000
          Top = 145.842610000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor - R$')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 608.504330000000000000
          Top = 79.370130000000000000
          Width = 139.842610000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxCadEmp."EMP_C_G_C_' +
              '">)]')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 7.559060000000000000
          Top = 79.370130000000000000
          Width = 442.205010000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.606370000000000000
          Width = 442.205010000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 457.323130000000000000
          Top = 109.606370000000000000
          Width = 143.622140000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."CID_NOMCID"]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 608.504330000000000000
          Top = 109.606370000000000000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."CID_ESTADO"]')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 657.638220000000000000
          Top = 109.606370000000000000
          Width = 90.708720000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."EMP_C_E_P_"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 7.559060000000000000
          Top = 49.133890000000010000
          Width = 86.929190000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTACONV]')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 230.551330000000000000
          Top = 49.133890000000010000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODCONV]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 343.937230000000000000
          Top = 49.133890000000010000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODAGEN]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 457.323130000000000000
          Top = 49.133890000000010000
          Width = 291.023810000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMAGEN]')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 457.323130000000000000
          Top = 79.370130000000000000
          Width = 143.622140000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CDCONTA]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo39: TfrxMemoView
          Left = 5.338590000000000000
          Top = 2.000000000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 105.826840000000000000
          Top = 2.000000000000000000
          Width = 230.551330000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 343.937230000000000000
          Top = 2.000000000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CLI_CGCCPF"> = '#39'1'#39', FormatMaskText('#39'00.000.0' +
              '00/0000-00;0'#39',<frxRelatorio."CLI_C_G_C_">),FormatMaskText('#39'000.0' +
              '00.000-00;0'#39',<frxRelatorio."CLI_C_G_C_">))]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 438.425480000000000000
          Top = 2.000000000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCID"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 555.590910000000000000
          Top = 2.000000000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DM')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 597.165740000000000000
          Top = 2.000000000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 657.638220000000000000
          Top = 2.000000000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 302.362400000000000000
        Top = 317.480520000000000000
        Width = 755.906000000000000000
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 0.779529999999965700
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 593.386210000000000000
          Top = 3.779529999999965000
          Width = 60.472480000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 653.858690000000000000
          Top = 3.779529999999965000
          Width = 98.267780000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 597.165740000000000000
          Top = 2.779529999999966000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd. T'#237'tulos')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 657.638220000000000000
          Top = 2.779529999999966000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total - R$')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 597.165740000000000000
          Top = 16.118119999999980000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 657.638220000000000000
          Top = 16.118119999999980000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">,MasterData1)]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 653.858690000000000000
          Top = 34.015769999999970000
          Width = 98.267780000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 551.811380000000000000
          Top = 34.015769999999970000
          Width = 102.047310000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 434.645950000000000000
          Top = 34.015769999999970000
          Width = 117.165430000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 340.157700000000000000
          Top = 34.015769999999970000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 226.771800000000000000
          Top = 34.015769999999970000
          Width = 113.385900000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 113.385900000000000000
          Top = 34.015769999999970000
          Width = 113.385900000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015769999999970000
          Width = 109.606370000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 7.559060000000000000
          Top = 33.015769999999970000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#250'mero do Border'#244)
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 117.165430000000000000
          Top = 33.015769999999970000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor do Border'#244)
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 230.551330000000000000
          Top = 33.015770000000030000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 343.937230000000000000
          Top = 33.015770000000030000
          Width = 79.370129999999970000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data do Desconto')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 438.425480000000000000
          Top = 33.015770000000030000
          Width = 98.267779999999950000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Taxa Nominal Desconto')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 555.590910000000000000
          Top = 33.015770000000030000
          Width = 94.488249999999950000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Taxa Efetiva Desconto')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 657.638220000000000000
          Top = 33.015769999999970000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Al'#237'quota de IOF')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.897650000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Uso do Banco')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 3.779530000000000000
          Top = 63.252009999999990000
          Width = 748.346940000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Declaramos, neste ato, ter pleno conhecimento e concordar com os' +
              ' dados impressos neste border'#244' e o contido nas cl'#225'usulas gerais ' +
              'e especiais que integram o Contrato para Desconto de t'#237'tulos.')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 7.559060000000000000
          Top = 83.149659999999990000
          Width = 332.598640000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 7.559060000000000000
          Top = 95.377952760000030000
          Width = 332.598640000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText('#39'>aa\.aaa\.aaa/aaaa-99;0'#39',<frxCadEmp."EMP_C_G_C_' +
              '">)]')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 423.307360000000000000
          Top = 83.149659999999990000
          Width = 328.819110000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 427.086890000000000000
          Top = 82.149659999999990000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local e Data')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 26.456710000000000000
          Top = 154.842610000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 26.456710000000000000
          Top = 166.181200000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Profiss'#227'o')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 26.456710000000000000
          Top = 177.519790000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 26.456710000000000000
          Top = 188.858380000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Residente em')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 26.456710000000000000
          Top = 200.196970000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Doc. Identidade')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 26.456710000000000000
          Top = 211.535560000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #211'rg'#227'o Emissor')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 26.456710000000000000
          Top = 222.874149999999900000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / MF')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 86.929190000000000000
          Top = 154.842610000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 86.929190000000000000
          Top = 166.181200000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 86.929190000000000000
          Top = 177.519790000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 86.929190000000000000
          Top = 188.858380000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 86.929190000000000000
          Top = 200.196970000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 86.929190000000000000
          Top = 211.535560000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 86.929190000000000000
          Top = 222.874149999999900000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 26.456710000000000000
          Top = 151.063080000000000000
          Width = 332.598640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 26.456710000000000000
          Top = 268.228510000000000000
          Width = 332.598640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo86: TfrxMemoView
          Left = 26.456710000000000000
          Top = 237.992270000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Testemunhas')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 26.456710000000000000
          Top = 272.008040000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 86.929190000000000000
          Top = 272.008040000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 26.456710000000000000
          Top = 283.346630000000100000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / MF')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 86.929190000000000000
          Top = 283.346630000000100000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 396.850650000000000000
          Top = 154.842610000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 396.850650000000000000
          Top = 166.181200000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Profiss'#227'o')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 396.850650000000000000
          Top = 177.519790000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 396.850650000000000000
          Top = 188.858380000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Residente em')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 396.850650000000000000
          Top = 200.196970000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Doc. Identidade')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 396.850650000000000000
          Top = 211.535560000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #211'rg'#227'o Emissor')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 396.850650000000000000
          Top = 222.874150000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / MF')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 457.323130000000000000
          Top = 154.842610000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 457.323130000000000000
          Top = 166.181200000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 457.323130000000000000
          Top = 177.519790000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 457.323130000000000000
          Top = 188.858380000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 457.323130000000000000
          Top = 200.196970000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 457.323130000000000000
          Top = 211.535560000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 457.323130000000000000
          Top = 222.874150000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 396.850650000000000000
          Top = 151.063080000000000000
          Width = 332.598640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 396.850650000000000000
          Top = 268.228510000000000000
          Width = 332.598640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo106: TfrxMemoView
          Left = 396.850650000000000000
          Top = 272.008040000000000000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 457.323130000000000000
          Top = 272.008040000000000000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 396.850650000000000000
          Top = 283.346629999999900000
          Width = 60.472440940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF / MF')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 457.323130000000000000
          Top = 283.346629999999900000
          Width = 7.559020940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ':')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 427.086890000000000000
          Top = 95.488250000000000000
          Width = 321.260050000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCadEmp."CID_NOMCID"], [Date]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 98.267780000000000000
          Top = 154.960730000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSOC1]')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 98.267780000000000000
          Top = 166.299320000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PROFIS1]')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 98.267780000000000000
          Top = 177.637910000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESTCIV1]')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 98.267780000000000000
          Top = 188.976500000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE1]')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 98.267780000000000000
          Top = 200.315090000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUM_RG1]')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 98.267780000000000000
          Top = 211.653679999999900000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ORGEMI1]')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 98.267780000000000000
          Top = 222.992270000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMCPF1]')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 468.661720000000000000
          Top = 154.960730000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMSOC2]')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 468.661720000000000000
          Top = 166.299320000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PROFIS2]')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 468.661720000000000000
          Top = 177.637910000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ESTCIV2]')
          ParentFont = False
        end
        object Memo131: TfrxMemoView
          Left = 468.661720000000000000
          Top = 188.976500000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE2]')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 468.661720000000000000
          Top = 200.315090000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUM_RG2]')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          Left = 468.661720000000000000
          Top = 211.653679999999900000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ORGEMI2]')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 468.661720000000000000
          Top = 222.992270000000000000
          Width = 253.228470940000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMCPF2]')
          ParentFont = False
        end
      end
    end
  end
  object frxCadEmp: TfrxDBDataset
    UserName = 'frxCadEmp'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 304
    Top = 112
  end
end
