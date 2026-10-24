inherited frmRelCopiaCheque: TfrmRelCopiaCheque
  Left = 397
  Top = 223
  Width = 331
  Height = 394
  Caption = 'Relat'#243'rio de C'#243'pias de Cheque'
  OnClose = FormClose
  ExplicitWidth = 331
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 321
    Width = 325
    ExplicitTop = 321
    ExplicitWidth = 325
    inherited btnSair: TBitBtnLocked
      Left = 242
      ExplicitLeft = 242
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlDados: TPanel
    Width = 325
    Height = 321
    ExplicitWidth = 325
    ExplicitHeight = 321
    object Label1: TLabel [0]
      Left = 8
      Top = 9
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
    object Label2: TLabel [1]
      Left = 95
      Top = 9
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
    object lblNumAge: TLabel [2]
      Left = 8
      Top = 130
      Width = 40
      Height = 14
      Caption = 'Ag'#234'ncia'
    end
    object Label3: TLabel [3]
      Left = 8
      Top = 210
      Width = 77
      Height = 14
      Caption = 'N'#250'mero Cheque'
    end
    object lblBanco: TLabel [4]
      Left = 8
      Top = 90
      Width = 31
      Height = 14
      Caption = 'Banco'
    end
    object Label4: TLabel [5]
      Left = 8
      Top = 170
      Width = 73
      Height = 14
      Caption = 'Conta Corrente'
    end
    object Label5: TLabel [6]
      Left = 8
      Top = 52
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    inherited gpbDestino: TGroupBox
      Top = 258
      Height = 52
      TabOrder = 7
      ExplicitTop = 258
      ExplicitHeight = 52
    end
    object edtNumAge: TEditFocus
      Tag = 99
      Left = 8
      Top = 146
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
    object edtNumChq: TEditFocus
      Tag = 99
      Left = 8
      Top = 226
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 8
      Top = 106
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomBco: TEditFocus
      Left = 74
      Top = 106
      Width = 240
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConCor: TEditFocus
      Tag = 99
      Left = 8
      Top = 186
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 5
      NormalColor = clWindow
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
      Top = 67
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
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
      Left = 74
      Top = 67
      Width = 240
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkMeiaFolha: TCheckBox
      Left = 149
      Top = 293
      Width = 159
      Height = 17
      Caption = 'Impress'#227'o em meia folha'
      TabOrder = 12
    end
    object chkNovaPagina: TCheckBox
      Left = 149
      Top = 276
      Width = 169
      Height = 17
      Caption = 'Imprimir um cheque por p'#225'gina'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object chkAssinatura: TCheckBox
      Left = 149
      Top = 259
      Width = 170
      Height = 17
      Caption = 'Imprimir linha para assinatura'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 7
      Top = 23
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
      TabOrder = 0
      Width = 82
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 95
      Top = 23
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
      TabOrder = 1
      Width = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 349
    Width = 325
    ExplicitTop = 349
    ExplicitWidth = 325
    inherited pnlNomeForm: TPanel
      Left = 154
      ExplicitLeft = 154
    end
    inherited pnlInfo: TPanel
      Width = 154
      ExplicitWidth = 154
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 336
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 400
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 368
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 336
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 496
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 464
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 400
  end
  inherited frxGen: TfrxUserDataSet
    Left = 432
  end
  inherited frxDesigner: TfrxDesigner
    Left = 464
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 496
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 24
  end
  object frxImpCopiaCheque_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39585.352479375000000000
    ReportOptions.LastChange = 40319.647917743050000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MDDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<FrxRelatorio."EMI_NUMDUP"> = '#39#39') Then'
      '  Begin'
      '    lblDuplicata.Visible  := False;'
      '    dbeDuplicata.Visible  := False;'
      '    lblFornecedor.Visible := False;'
      '    dbeFornecedor.Visible := False;'
      '    //lblPortador.Visible   := False;'
      '    //dbePortador.Visible   := False;'
      '    lblValor.Visible      := False;'
      
        '    dbeValor.Visible      := False;                             ' +
        '     '
      '  End'
      '  Else'
      '  Begin'
      '    lblDuplicata.Visible  := True;'
      '    dbeDuplicata.Visible  := True;'
      '    lblFornecedor.Visible := True;'
      '    dbeFornecedor.Visible := True;'
      '    //lblPortador.Visible   := True;'
      '    //dbePortador.Visible   := True;'
      '    lblValor.Visible      := True;'
      '    dbeValor.Visible      := True;  '
      '  End;            '
      'end;'
      ''
      'procedure GHDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<FrxRelatorio."EMI_BOMPAR"> = '#39#39') Then'
      '  Begin              '
      '    dbeBomPar.Visible := False;'
      '    lblBomPara.Visible := False;'
      '  End                '
      '  Else'
      '  Begin              '
      '    dbeBomPar.Visible := True;'
      '    lblBomPara.Visible := True;'
      '  End;                  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxImpCopiaCheque_MUserFunction
    Left = 208
    Top = 24
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
    object pCopiaCheque: TfrxDMPPage
      PaperWidth = 304.799803150127100000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      OnBeforePrint = 'Page1OnBeforePrint'
      FontStyle = []
      object GHDuplicatas: TfrxGroupHeader
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 17.000000000000000000
        Width = 1152.000000000000000000
        OnBeforePrint = 'GHDuplicatasOnBeforePrint'
        Condition = 'frxRelatorio."CHAVE"'
        object DMPMemo1: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 255.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 255.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUMERO DO CHEQUE : ')
          TruncOutboundText = False
        end
        object FrxRelatorioVALOR_CHEQUE: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_VALBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."EMI_VALBAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxRelatorioEXTENSO_CHEQUE: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 34.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRetExtensoNumero(<FrxRelatorio."EMI_VALBAI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxRelatorioCIDADE_CHEQUE: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 136.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxRelatorio."CID_NOMCID"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxRelatorioDATA_CHEQUE: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 136.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd              mmmm             yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_DTABAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object cmdImpressao: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#33#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 68.000000000000000000
          Width = 931.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRetExtensoNumero2(<FrxRelatorio."EMI_VALBAI">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 272.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGENCIA        : ')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 289.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONTA CORRENTE : ')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 272.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 289.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 255.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BANCO            : ')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 255.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CODBCO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object dbeBOMPAR: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 204.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."EMI_BOMPAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 102.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_FAVORE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblBomPara: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 204.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'Bom Para:')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 272.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CODPOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 272.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PORTADOR         : ')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 289.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NOMEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 289.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA          : ')
          TruncOutboundText = False
        end
      end
      object MDDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1152.000000000000000000
        OnBeforePrint = 'MDDuplicatasOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPCommand3: TfrxDMPCommand
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object lblDuplicata: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DP: ')
          TruncOutboundText = False
        end
        object dbeDuplicata: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblValor: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR: ')
          TruncOutboundText = False
        end
        object dbeValor: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_VALBAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object lblFornecedor: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORN: ')
          TruncOutboundText = False
        end
        object dbeFornecedor: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FrxRelatorio."FOR_NOMFOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 1132.800000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#77'
        end
      end
      object GFDuplicatas: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 374.000000000000000000
        Width = 1152.000000000000000000
        object DMPMemo5: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 51.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxImpCopiaCheque_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39585.352479375000000000
    ReportOptions.LastChange = 39763.673663726850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MDDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<FrxRelatorio."EMI_NUMDUP"> = '#39#39') Then'
      '  Begin'
      '    lblDuplicata.Visible  := False;'
      '    dbeDuplicata.Visible  := False;'
      '    lblFornecedor.Visible := False;'
      '    dbeFornecedor.Visible := False;'
      '    //lblPortador.Visible   := False;'
      '    //dbePortador.Visible   := False;'
      '    lblValor.Visible      := False;'
      
        '    dbeValor.Visible      := False;                             ' +
        '     '
      '  End'
      '  Else'
      '  Begin'
      '    lblDuplicata.Visible  := True;'
      '    dbeDuplicata.Visible  := True;'
      '    lblFornecedor.Visible := True;'
      '    dbeFornecedor.Visible := True;'
      '    //lblPortador.Visible   := True;'
      '    //dbePortador.Visible   := True;'
      '    lblValor.Visible      := True;'
      '    dbeValor.Visible      := True;  '
      '  End;            '
      'end;'
      ''
      'procedure GHDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<FrxRelatorio."EMI_BOMPAR"> = '#39#39') Then'
      '  Begin              '
      '    dbeBomPar.Visible := False;'
      '    lblBomPar.Visible := False;'
      '  End                '
      '  Else'
      '  Begin              '
      '    dbeBomPar.Visible := True;'
      '    lblBomPar.Visible := True;'
      '  End;                  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxImpCopiaCheque_JUserFunction
    Left = 248
    Top = 24
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
    object pCopiaCheque: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.400000000000000000
      PaperSize = 256
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object GHDuplicatas: TfrxGroupHeader
        FillType = ftBrush
        Height = 305.984230000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'GHDuplicatasOnBeforePrint'
        Condition = 'frxRelatorio."CHAVE"'
        object Memo1: TfrxMemoView
          Left = 190.563760000000000000
          Top = 268.677180000000000000
          Width = 261.845640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CODPOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 38.400000000000000000
          Top = 268.677180000000000000
          Width = 152.163760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PORTADOR         :')
          ParentFont = False
        end
        object FrxRelatorioVALOR_CHEQUE: TfrxMemoView
          Left = 585.524180000000000000
          Top = 4.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_VALBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."EMI_VALBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object FrxRelatorioEXTENSO_CHEQUE: TfrxMemoView
          Left = 144.000000000000000000
          Top = 38.000000000000000000
          Width = 588.396660000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[fRetExtensoNumero(<FrxRelatorio."EMI_VALBAI">)]')
          ParentFont = False
          WordWrap = False
        end
        object FrxRelatorioCIDADE_CHEQUE: TfrxMemoView
          Left = 97.058070000000000000
          Top = 128.661410000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxRelatorio."CID_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object FrxRelatorioDATA_CHEQUE: TfrxMemoView
          Left = 423.458070000000000000
          Top = 128.661410000000000000
          Width = 344.163760000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd              mmmm             yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_DTABAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 38.400000000000000000
          Top = 72.000000000000000000
          Width = 659.073840000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[fRetExtensoNumero2(<FrxRelatorio."EMI_VALBAI">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 38.574830000000000000
          Top = 98.606370000000000000
          Width = 329.272480000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_FAVORE"]')
          ParentFont = False
          WordWrap = False
        end
        object dbeBomPar: TfrxMemoView
          Left = 634.961040000000000000
          Top = 191.551181100000000000
          Width = 102.273840000000000000
          Height = 17.007874020000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_BOMPAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 483.779840000000000000
          Top = 252.023810000000000000
          Width = 103.029870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'BANCO            : ')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 483.779840000000000000
          Top = 268.677180000000000000
          Width = 103.029870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'AG'#202'NCIA    : ')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 483.779840000000000000
          Top = 285.819110000000000000
          Width = 103.029870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CONTA COR. : ')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 587.606680000000000000
          Top = 252.023810000000000000
          Width = 205.152690000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CODBCO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 585.827150000000000000
          Top = 268.677180000000000000
          Width = 208.932220000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 585.827150000000000000
          Top = 285.819110000000000000
          Width = 208.932220000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object lblBomPar: TfrxMemoView
          Left = 532.913730000000000000
          Top = 191.551181100000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Bom Para:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 189.959060000000000000
          Top = 252.023810000000000000
          Width = 261.845640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 37.795300000000000000
          Top = 252.023810000000000000
          Width = 152.163760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'NUMERO DO CHEQUE : ')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 189.959060000000000000
          Top = 285.819110000000000000
          Width = 261.845640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMI_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 37.795300000000000000
          Top = 285.819110000000000000
          Width = 152.163760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA          :')
          ParentFont = False
        end
      end
      object MDDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 347.716760000000000000
        Width = 793.701300000000000000
        OnBeforePrint = 'MDDuplicatasOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object lblDuplicata: TfrxMemoView
          Left = 38.400000000000000000
          Width = 23.281880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DP: ')
          ParentFont = False
        end
        object dbeDuplicata: TfrxMemoView
          Left = 64.020470000000000000
          Width = 124.875510000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object lblValor: TfrxMemoView
          Left = 198.716450000000000000
          Width = 23.281880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VR: ')
          ParentFont = False
        end
        object dbeValor: TfrxMemoView
          Left = 223.895980000000000000
          Width = 96.907050000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxRelatorio."EMI_VALBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object lblFornecedor: TfrxMemoView
          Left = 329.807730000000000000
          Width = 31.143290000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'FOR: ')
          ParentFont = False
        end
        object dbeFornecedor: TfrxMemoView
          Left = 364.746320000000000000
          Width = 422.173160000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[FrxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GFDuplicatas: TfrxGroupFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 389.291590000000000000
        Width = 793.701300000000000000
        object Memo5: TfrxMemoView
          Left = 37.795300000000000000
          Top = 30.236240000000000000
          Width = 303.344960000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
      end
    end
  end
end
