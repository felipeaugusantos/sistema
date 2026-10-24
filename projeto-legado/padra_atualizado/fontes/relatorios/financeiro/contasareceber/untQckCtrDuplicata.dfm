object frmQckCtrDuplicata: TfrmQckCtrDuplicata
  Left = 0
  Top = 0
  Caption = 'frmQckCtrDuplicata'
  ClientHeight = 405
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object qryRelCTR: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      
        'SELECT                                                          ' +
        '                                       '
      '  CTR_NUMDUP,'
      '  CTR_PARCEL,'
      '  CTR_ESPDOC,'
      
        '  CONCAT(CTR_CODCLI, '#39' - '#39', CLI_NOMCLI) AS CLIENTE,             ' +
        '                                                                ' +
        '             '
      
        '  IF(CLI_ENDCOB = '#39#39' OR CLI_ENDCOB IS NULL, CLI_ENDERE, CLI_ENDC' +
        'OB) AS CLI_ENDERE,                       '
      
        '  IF(CLI_BAICOB = '#39#39' OR CLI_BAICOB IS NULL, CLI_BAIRRO, CLI_BAIC' +
        'OB) AS CLI_BAIRRO,                     '
      '  CID_NOMCID,'
      '  CLI_FONE01,       '
      '  CONCAT(CTR_CODVEN, '#39' - '#39',  V.OPE_NOMOPE) AS VENDEDOR, '
      '  CTR_DTACAD,'
      '  CTR_VALDUP,'
      '  CTR_DESSUJ,'
      '  CTR_DTAVEN,'
      '  CTR_DESCOB,'
      '  CTR_NOSNUM,'
      '  CONCAT(CTR_CODPOR, '#39' - '#39', P.POR_NOMPOR) AS PORTADOR,     '
      '  CONCAT(CTR_CODEVE, '#39' - '#39', EVE_DESEVE) AS EVENTO,'
      '  CAST(IFNULL(CTR_HIST01, '#39#39') AS CHAR(255)) AS HIST01,'
      '  CTR_HIST02,'
      '  CTR_CODVEL,'
      '  CTR_DTAREC,'
      '  CONCAT(CTR_PORBAI, '#39' - '#39', B.POR_NOMPOR) AS PORBAI,'
      '  CTR_CTABAI,'
      '  CONCAT(CTR_OPEBAI, '#39' - '#39', O.OPE_NOMOPE) AS OPEBAI,'
      '  CTR_SEQBAI,'
      '  CTR_VALORI,'
      '  CTR_VALREC,'
      '  CTR_DOCBAI,'
      '  CTR_HISBAI,'
      '  CTR_DESCON,  '
      '  CLI_CGCCPF,'
      '  CLI_C_G_C_,'
      '  CONCAT(CTR_CTABAI, '#39' - '#39', C.CTA_DESCTA) PLANOCONTA,      '
      '  EMP_NOMEMP'
      
        ' FROM                                                           ' +
        '                                      '
      
        '  CADREC                                                        ' +
        '                                       '
      
        '  JOIN CADCLI        ON CTR_CODCLI = CLI_CODCLI                 ' +
        '                                                                ' +
        '                               '
      
        '  LEFT JOIN CADPOR P ON CTR_CODPOR = P.POR_CODPOR               ' +
        '                                       '
      
        '  LEFT JOIN CADPOR B ON CTR_PORBAI = B.POR_CODPOR               ' +
        '                                       '
      
        '  LEFT JOIN CADEVE   ON CTR_CODEVE =   EVE_CODEVE               ' +
        '                                             '
      
        '  LEFT JOIN CADCID   ON CID_CODCID = IF(CLI_CIDCOB = '#39#39' OR CLI_C' +
        'IDCOB IS NULL, CLI_CODCID, CLI_CIDCOB)  '
      '  LEFT JOIN CADEMP E ON EMP_CODEMP = CTR_CODEMP'
      '  LEFT JOIN CADOPE O ON CTR_OPEBAI = O.OPE_CODOPE'
      '  LEFT JOIN CADOPE V ON CTR_CODVEN = V.OPE_CODOPE '
      '  LEFT JOIN CADCTA C  ON CTR_CTABAI = CTA_CODCTA'
      'WHERE 1 <> 1')
    Constraints = <>
    Left = 183
    Top = 111
    object qryRelCTRCTR_NUMDUP: TStringField
      FieldName = 'CTR_NUMDUP'
      Required = True
      Size = 12
    end
    object qryRelCTRCTR_PARCEL: TStringField
      FieldName = 'CTR_PARCEL'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryRelCTRCTR_ESPDOC: TStringField
      FieldName = 'CTR_ESPDOC'
      Required = True
      FixedChar = True
      Size = 2
    end
    object qryRelCTRCLIENTE: TStringField
      FieldName = 'CLIENTE'
      ReadOnly = True
      Size = 71
    end
    object qryRelCTRCLI_ENDERE: TStringField
      FieldName = 'CLI_ENDERE'
      ReadOnly = True
      Size = 60
    end
    object qryRelCTRCLI_BAIRRO: TStringField
      FieldName = 'CLI_BAIRRO'
      ReadOnly = True
      Size = 60
    end
    object qryRelCTRCID_NOMCID: TStringField
      FieldName = 'CID_NOMCID'
      ReadOnly = True
      Size = 40
    end
    object qryRelCTRCLI_FONE01: TStringField
      FieldName = 'CLI_FONE01'
      ReadOnly = True
      Size = 15
    end
    object qryRelCTRVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      ReadOnly = True
      Size = 36
    end
    object qryRelCTRCTR_DTACAD: TDateField
      FieldName = 'CTR_DTACAD'
      Required = True
    end
    object qryRelCTRCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
    end
    object qryRelCTRCTR_DESSUJ: TFloatField
      FieldName = 'CTR_DESSUJ'
    end
    object qryRelCTRCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
      Required = True
    end
    object qryRelCTRCTR_DESCOB: TFloatField
      FieldName = 'CTR_DESCOB'
    end
    object qryRelCTRCTR_NOSNUM: TStringField
      FieldName = 'CTR_NOSNUM'
      Size = 12
    end
    object qryRelCTRPORTADOR: TStringField
      FieldName = 'PORTADOR'
      ReadOnly = True
      Size = 48
    end
    object qryRelCTREVENTO: TStringField
      FieldName = 'EVENTO'
      ReadOnly = True
      Size = 48
    end
    object qryRelCTRHIST01: TStringField
      FieldName = 'HIST01'
      ReadOnly = True
      Required = True
      Size = 255
    end
    object qryRelCTRCTR_HIST02: TStringField
      FieldName = 'CTR_HIST02'
      Size = 50
    end
    object qryRelCTRCTR_CODVEL: TStringField
      FieldName = 'CTR_CODVEL'
    end
    object qryRelCTRCTR_DTAREC: TDateField
      FieldName = 'CTR_DTAREC'
    end
    object qryRelCTRPORBAI: TStringField
      FieldName = 'PORBAI'
      ReadOnly = True
      Size = 48
    end
    object qryRelCTRCTR_CTABAI: TStringField
      FieldName = 'CTR_CTABAI'
      Size = 7
    end
    object qryRelCTROPEBAI: TStringField
      FieldName = 'OPEBAI'
      ReadOnly = True
      Size = 36
    end
    object qryRelCTRCTR_SEQBAI: TIntegerField
      FieldName = 'CTR_SEQBAI'
      Required = True
    end
    object qryRelCTRCTR_VALORI: TFloatField
      FieldName = 'CTR_VALORI'
    end
    object qryRelCTRCTR_VALREC: TFloatField
      FieldName = 'CTR_VALREC'
    end
    object qryRelCTRCTR_DOCBAI: TStringField
      FieldName = 'CTR_DOCBAI'
      Size = 13
    end
    object qryRelCTRCTR_HISBAI: TStringField
      FieldName = 'CTR_HISBAI'
      Size = 50
    end
    object qryRelCTRCTR_DESCON: TStringField
      FieldName = 'CTR_DESCON'
      FixedChar = True
      Size = 1
    end
    object qryRelCTRCLI_CGCCPF: TLongWordField
      FieldName = 'CLI_CGCCPF'
      ReadOnly = True
    end
    object qryRelCTRCLI_C_G_C_: TStringField
      FieldName = 'CLI_C_G_C_'
      ReadOnly = True
      Size = 18
    end
    object qryRelCTRPLANOCONTA: TStringField
      FieldName = 'PLANOCONTA'
      ReadOnly = True
      Size = 50
    end
    object qryRelCTREMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      ReadOnly = True
      Size = 60
    end
  end
  object frxDBRelCTR: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CTR_NUMDUP=CTR_NUMDUP'
      'CTR_PARCEL=CTR_PARCEL'
      'CTR_ESPDOC=CTR_ESPDOC'
      'CLIENTE=CLIENTE'
      'CLI_ENDERE=CLI_ENDERE'
      'CLI_BAIRRO=CLI_BAIRRO'
      'CID_NOMCID=CID_NOMCID'
      'CLI_FONE01=CLI_FONE01'
      'VENDEDOR=VENDEDOR'
      'CTR_DTACAD=CTR_DTACAD'
      'CTR_VALDUP=CTR_VALDUP'
      'CTR_DESSUJ=CTR_DESSUJ'
      'CTR_DTAVEN=CTR_DTAVEN'
      'CTR_DESCOB=CTR_DESCOB'
      'CTR_NOSNUM=CTR_NOSNUM'
      'PORTADOR=PORTADOR'
      'EVENTO=EVENTO'
      'HIST01=HIST01'
      'CTR_HIST02=CTR_HIST02'
      'CTR_CODVEL=CTR_CODVEL'
      'CTR_DTAREC=CTR_DTAREC'
      'PORBAI=PORBAI'
      'CTR_CTABAI=CTR_CTABAI'
      'OPEBAI=OPEBAI'
      'CTR_SEQBAI=CTR_SEQBAI'
      'CTR_VALORI=CTR_VALORI'
      'CTR_VALREC=CTR_VALREC'
      'CTR_DOCBAI=CTR_DOCBAI'
      'CTR_HISBAI=CTR_HISBAI'
      'CTR_DESCON=CTR_DESCON'
      'CLI_CGCCPF=CLI_CGCCPF'
      'CLI_C_G_C_=CLI_C_G_C_'
      'PLANOCONTA=PLANOCONTA'
      'EMP_NOMEMP=EMP_NOMEMP')
    DataSet = qryRelCTR
    BCDToCurrency = False
    Left = 287
    Top = 111
  end
  object frxRelCTR: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44131.614261909700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo11OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '                                                              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 112
    Top = 79
    Datasets = <
      item
        DataSet = frxDBRelCTR
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object frxReportPage1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      DataSet = frxDBRelCTR
      DataSetName = 'frxDBDataset1'
      object frxPageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 306.141732283464600000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        Child = frxRelCTR.ChildHist01
        Stretched = True
        object Date: TfrxMemoView
          Align = baRight
          Left = 676.460360000000000000
          Top = 25.102350000000000000
          Width = 71.886580000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Top = 45.133889999999990000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baRight
          Left = 623.546940000000000000
          Top = 26.456710000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Top = 66.811070000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Top = 87.708720000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'ENDERECO:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Top = 108.385900000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Top = 148.960730000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TELEFONE:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 128.283550000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CIDADE:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Top = 169.858380000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'CPF/CNPJ:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Top = 189.756030000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 135.086621500000000000
          Top = 46.133889999999990000
          Width = 92.598420310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 250.559150310000000000
          Top = 45.133889999999990000
          Width = 62.513110000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'PARCELA:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 317.260050000000000000
          Top = 45.133889999999990000
          Width = 92.598420310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_PARCEL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 430.645950000000000000
          Top = 43.133890000000000000
          Width = 62.513110000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'ESPECIE:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 497.677490000000000000
          Top = 44.354360000000000000
          Width = 51.023590310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 135.086621500000000000
          Top = 67.811070000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 135.086621500000000000
          Top = 88.267780000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CLI_ENDERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 135.086621500000000000
          Top = 109.385900000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CLI_BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 131.307091500000000000
          Top = 129.063080000000000000
          Width = 597.165325040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CID_NOMCID"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 135.086621500000000000
          Top = 149.960730000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[FONE01]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 135.086621500000000000
          Top = 170.858380000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[CGCCPF]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 135.086621500000000000
          Top = 190.535560000000000000
          Width = 593.385795040000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 215.212740000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DATA DE CADASTRO:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 237.889920000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DATA VENCIMENTO:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Top = 260.567100000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS AO DIA:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 283.244280000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PORTADOR:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 135.086621500000000000
          Top = 216.212740000000000000
          Width = 85.039360310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 135.086621500000000000
          Top = 238.889920000000000000
          Width = 85.039360310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object mmJurosAoDia: TfrxMemoView
          Left = 135.086621500000000000
          Top = 262.567100000000000000
          Width = 107.716540310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[JUROSAODIA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 135.086621500000000000
          Top = 285.244280000000000000
          Width = 330.708810310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."PORTADOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 293.472570310000000000
          Top = 215.212740000000000000
          Width = 51.174520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 460.882190000000000000
          Top = 214.992270000000000000
          Width = 73.851700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 225.551330000000000000
          Top = 237.889920000000000000
          Width = 92.749350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DESP. DE COB.:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 385.291590000000000000
          Top = 237.889920000000000000
          Width = 119.206060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DUP. DESCONTADA:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 574.268090000000000000
          Top = 237.889920000000000000
          Width = 81.410760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 351.275820000000000000
          Top = 215.212740000000000000
          Width = 58.582650310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 322.819110000000000000
          Top = 237.889920000000000000
          Width = 58.582650310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DESCOB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 544.031850000000000000
          Top = 215.212740000000000000
          Width = 58.582650310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DESSUJ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 509.016080000000000000
          Top = 237.889920000000000000
          Width = 58.582650310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[DUPDESCONTADA]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 660.197280000000000000
          Top = 237.889920000000000000
          Width = 81.259830310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 468.441250000000000000
          Top = 283.244280000000000000
          Width = 66.292640000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'EVENTOS:')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 540.252320000000000000
          Top = 283.244280000000000000
          Width = 187.086670310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."EVENTO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxMemoEmpresa: TfrxMemoView
          Align = baCenter
          Left = 173.858380000000000000
          Top = 20.897650000000000000
          Width = 400.630180000000000000
          Height = 15.118120000000000000
          DataSet = frxDBRelCTR
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMPRESA')
          ParentFont = False
          WordWrap = False
        end
        object frxMemoView1: TfrxMemoView
          Align = baLeft
          Top = 2.440940000000001000
          Width = 773.064750000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMA'#199#213'ES DA DUPLICATA')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 653.858690000000000000
        Width = 748.346940000000000000
        object Memo9: TfrxMemoView
          Left = 324.260050000000000000
          Top = 12.338589999999950000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assinatura:')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baRight
          Left = 400.630180000000000000
          Top = 29.118119999999980000
          Width = 347.716760000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildBaixa: TfrxChild
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 461.102660000000000000
        Width = 748.346940000000000000
        object Memo49: TfrxMemoView
          Align = baLeft
          Top = 27.015769999999980000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TIPO DE BAIXA')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Align = baLeft
          Top = 47.692949999999940000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DATA RECEBIMENTO:')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Align = baLeft
          Top = 68.590599999999770000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PORTADOR BAIXA:')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Align = baLeft
          Top = 91.267779999999900000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PLANO DE CONTAS:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Align = baLeft
          Top = 113.299010000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'OPERADOR BAIXA:')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 130.544650000000000000
          Top = 27.015769999999980000
          Width = 221.253370000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[TIPOBAIXA]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 132.283550000000000000
          Top = 48.692949999999940000
          Width = 217.322834650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 132.283550000000000000
          Top = 68.590599999999770000
          Width = 217.322834650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."PORBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 132.283550000000000000
          Top = 91.267779999999900000
          Width = 217.322834650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."PLANOCONTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 132.283550000000000000
          Top = 113.944960000000000000
          Width = 217.322834650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."OPEBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 370.695670000000000000
          Top = 27.015769999999980000
          Width = 130.544650000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'SEQU'#202'NCIA DA BAIXA:')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 377.953000000000000000
          Top = 47.692949999999940000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR ORIGINAL:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 377.953000000000000000
          Top = 68.370129999999790000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR RECEBIDO:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 370.393940000000000000
          Top = 90.047309999999920000
          Width = 130.544650000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DOC. MOV. BANC'#193'RIO:')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 377.953000000000000000
          Top = 112.724490000000100000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.BottomLine.Width = 2.000000000000000000
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'HIST'#211'RICO:')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 506.457020000000000000
          Top = 27.015769999999980000
          Width = 164.409490310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_SEQBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 506.457020000000000000
          Top = 49.692949999999940000
          Width = 164.409490310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_VALORI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo66: TfrxMemoView
          Left = 506.457020000000000000
          Top = 69.590599999999770000
          Width = 164.409490310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          Left = 506.457020000000000000
          Top = 91.488249999999880000
          Width = 164.409490310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_DOCBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 506.457020000000000000
          Top = 112.385900000000000000
          Width = 164.409490310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_HISBAI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo48: TfrxMemoView
          Align = baLeft
          Top = 6.118119999999919000
          Width = 773.064750000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMACOES REFERENTES A BAIXA')
          ParentFont = False
        end
      end
      object ChildHist01: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 347.716760000000000000
        Width = 748.346940000000000000
        Child = frxRelCTR.ChildComplementar
        Stretched = True
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 0.779530000000022500
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'HISTORICO:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 135.086621500000000000
          Top = 0.559059999999988100
          Width = 591.496380310000000000
          Height = 18.897650000000000000
          OnAfterPrint = 'Memo11OnAfterPrint'
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."HIST01"]')
          ParentFont = False
        end
      end
      object ChildComplementar: TfrxChild
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 393.071120000000000000
        Width = 748.346940000000000000
        Child = frxRelCTR.ChildBaixa
        object Memo6: TfrxMemoView
          Align = baLeft
          Top = 19.897650000000000000
          Width = 122.985590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DOC. ANTIGO:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 135.086621500000000000
          Top = 3.559059999999988000
          Width = 591.496380310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_HIST02"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 135.086621500000000000
          Top = 20.677180000000020000
          Width = 168.189020310000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."CTR_CODVEL"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
