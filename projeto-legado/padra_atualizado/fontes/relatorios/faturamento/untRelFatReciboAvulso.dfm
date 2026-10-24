inherited frmRelFatReciboAvulso: TfrmRelFatReciboAvulso
  Left = 290
  Top = 269
  Width = 519
  Height = 518
  Caption = 'Recibo avulso'
  ExplicitWidth = 519
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 513
    TabOrder = 2
    ExplicitTop = 447
    ExplicitWidth = 513
    inherited FlwBotoes: TFlowPanel
      Width = 432
      ExplicitWidth = 432
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 434
      ExplicitLeft = 434
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 513
    TabOrder = 3
    ExplicitTop = 473
    ExplicitWidth = 513
    inherited pnlNomeForm: TPanel
      Left = 342
      ExplicitLeft = 342
    end
    inherited pnlInfo: TPanel
      Width = 342
      ExplicitWidth = 342
    end
  end
  inherited pnlDados: TPanel
    Top = 50
    Width = 513
    Height = 397
    TabOrder = 1
    ExplicitTop = 50
    ExplicitWidth = 513
    ExplicitHeight = 397
    object Label9: TLabel [0]
      Left = 420
      Top = 6
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor do recibo:'
    end
    object Label1: TLabel [1]
      Left = 8
      Top = 6
      Width = 30
      Height = 14
      Caption = 'Nome:'
    end
    object Label2: TLabel [2]
      Left = 8
      Top = 180
      Width = 45
      Height = 14
      Caption = 'Hist'#243'rico:'
    end
    object Label3: TLabel [3]
      Left = 8
      Top = 300
      Width = 100
      Height = 14
      Caption = 'Nome na Assinatura:'
    end
    object Label4: TLabel [4]
      Left = 391
      Top = 300
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do recibo:'
    end
    object Label5: TLabel [5]
      Left = 8
      Top = 343
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade vias:'
    end
    object lblLinhas: TLabel [6]
      Left = 365
      Top = 180
      Width = 131
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linhas: 0/0 Caracteres: 0/0'
    end
    object lblCNPJ_CPF: TLabel [7]
      Left = 8
      Top = 47
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = '1 - CNPJ / 2 - CPF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [8]
      Left = 9
      Top = 91
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [9]
      Left = 9
      Top = 136
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel [10]
      Left = 420
      Top = 91
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 96
      Top = 341
      Width = 142
      Height = 43
      TabOrder = 11
      ExplicitLeft = 96
      ExplicitTop = 341
      ExplicitWidth = 142
      ExplicitHeight = 43
    end
    object edtValRec: TEditFocus
      Tag = 99
      Left = 420
      Top = 20
      Width = 82
      Height = 22
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtNomRec: TEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 409
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 0
      OnChange = edtNomRecChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAssRec: TEditFocus
      Tag = 99
      Left = 8
      Top = 314
      Width = 369
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdVia: TEditFocus
      Tag = 99
      Left = 8
      Top = 357
      Width = 81
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      Text = '2'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object mmfHisRec: TMemoFocus
      Tag = 99
      AlignWithMargins = True
      Left = 8
      Top = 198
      Width = 492
      Height = 92
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ScrollBars = ssVertical
      TabOrder = 7
      OnExit = mmfHisRecExit
      OnKeyUp = mmfHisRecKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object mskDtaRec: TcxDateEdit
      Tag = 99
      Left = 391
      Top = 314
      Anchors = [akLeft, akTop, akRight]
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 9
      Width = 111
    end
    object edtOpcCnpjCpf: TEditFocus
      Tag = 99
      Left = 9
      Top = 63
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 2
      OnChange = edtNomRecChange
      OnExit = edtOpcCnpjCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCnpjCpf: TMaskEditFocus
      Tag = 99
      Left = 53
      Top = 63
      Width = 446
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      Text = ''
      OnExit = edtCnpjCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEndereco: TEditFocus
      Tag = 99
      Left = 9
      Top = 108
      Width = 408
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 4
      OnChange = edtNomRecChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNroEndereco: TEditFocus
      Tag = 99
      Left = 420
      Top = 108
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCidade: TEditFocus
      Tag = 99
      Left = 9
      Top = 152
      Width = 408
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 6
      OnChange = edtNomRecChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCliente: TPanel [3]
    Left = 0
    Top = 0
    Width = 513
    Height = 50
    Align = alTop
    TabOrder = 0
    object lblCliente: TLabel
      Left = 8
      Top = 6
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnChange = edtCodCliChange
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
    object edtNomCli: TEditFocus
      Left = 82
      Top = 22
      Width = 371
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 214
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 208
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 16
    Top = 214
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 272
    Top = 214
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 240
    Top = 214
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 208
    Top = 214
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 176
    Top = 214
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 144
    Top = 214
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 80
    Top = 214
  end
  inherited frxGen: TfrxUserDataSet
    Left = 112
    Top = 214
  end
  inherited frxDesigner: TfrxDesigner
    Left = 336
    Top = 240
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 368
    Top = 240
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 40343.563931203700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo5OnBeforePrint(Sender: TfrxComponent);'
      
        'begin                                                           ' +
        '     '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 400
    Top = 240
    Datasets = <
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 525.354670000000100000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Top = 81.267780000000000000
          Width = 755.906000000000000000
          Height = 374.173470000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 279.685220000000000000
          Top = 376.071120000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 421.425480000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxUser."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 15.118120000000000000
          Top = 297.551330000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 119.401670000000000000
          Width = 699.213050000000000000
          Height = 26.456710000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 26.456710000000000000
          Top = 156.094620000000000000
          Width = 702.992580000000000000
          Height = 120.944872130000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] [frxUser."CGCC' +
              'PF"], [frxUser."CLIEND"][frxUser."CLINRO"][frxUser."CLICID"] a i' +
              'mportancia supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUs' +
              'er."VALREC">)] ( [frxUser."VLREXT"] ), referente [frxUser."HISRE' +
              'C"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Memo24: TfrxMemoView
          Top = 82.267780000000000000
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 154.000000000000000000
          Top = 58.031539999999990000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 81.488250000000010000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Top = 111.724490000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 154.000000000000000000
          Top = 40.133889999999990000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade....:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 154.118120000000000000
          Top = 22.236239999999990000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tel..........:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 154.047241650000000000
          Top = 1.559060000000002000
          Width = 411.968389210000000000
          Height = 18.897650000000000000
          DataField = 'NOMEMP'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMEMP"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 218.472480000000000000
          Top = 22.236239999999990000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo5OnBeforePrint'
          AutoWidth = True
          DataField = 'NUMTEL'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMTEL"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 218.252010000000000000
          Top = 40.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataField = 'NOMCID'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMCID"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 218.252010000000000000
          Top = 58.141732280000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataField = 'NOMEND'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMEND"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 618.709030000000000000
          Top = 40.000000000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'NOMBAI'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMBAI"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 573.354670000000100000
          Top = 40.000000000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 618.961013150000000000
          Top = 60.472480000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'NUMCEP'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMCEP"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 573.606680000000000000
          Top = 59.472480000000000000
          Width = 45.354333150000000000
          Height = 18.897650000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP..:')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Height = 113.385900000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Left = 755.906000000000000000
          Height = 113.385900000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 277.905690000000000000
          Top = 370.055350000000100000
          Width = 457.323130000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object imgImagem: TfrxPictureView
          Left = 4.779530000000000000
          Top = 4.559060000000003000
          Width = 143.622047240000000000
          Height = 71.811070000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo12: TfrxMemoView
          Left = 618.708661420000000000
          Top = 2.000000000000000000
          Width = 124.724409450000000000
          Height = 18.897650000000000000
          DataField = 'NUMCNPJ'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMCNPJ"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 573.354330710000000000
          Top = 2.000000000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
    end
  end
  object frxUser: TfrxUserDataSet
    UserName = 'frxUser'
    OnCheckEOF = frxUserCheckEOF
    OnFirst = frxUserFirst
    OnNext = frxUserNext
    OnPrior = frxUserPrior
    Fields.Strings = (
      'DTAREC'
      'VALREC'
      'NOMREC'
      'NOMASS'
      'HISREC'
      'CIDREC'
      'NROVIA'
      'VLREXT'
      'NOMEMP'
      'NUMTEL'
      'NOMCID'
      'NOMEND'
      'NOMBAI'
      'NUMCEP'
      'CGCCPF'
      'CLICID'
      'CLIEND'
      'CLINRO'
      'NUMCNPJ')
    OnGetValue = frxUserGetValue
    Left = 464
    Top = 240
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 41976.499515034700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '                              '
      'end.')
    Left = 432
    Top = 240
    Datasets = <
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
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 510.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 278.400000000000000000
          Top = 102.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object frxUserVALREC: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 136.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object frxUserNOMASS: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 442.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxUserNROVIA: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 476.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object frxUserCIDREC: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 374.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object frxUserNOMREC: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 187.000000000000000000
          Width = 720.000000000000000000
          Height = 153.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] [frxUser."CGCC' +
              'PF"], [frxUser."CLIEND"][frxUser."CLINRO"][frxUser."CLICID"] a i' +
              'mportancia supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUs' +
              'er."VALREC">)] ( [frxUser."VLREXT"] ), referente [frxUser."HISRE' +
              'C"].')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 501.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 172.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Tel.....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Cidade..:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Endereco:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 68.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMEND"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NUMTEL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMBAI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NUMCEP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CEP...:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 360.000000000000000000
          Top = 433.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NUMCNPJ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CNPJ..:')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
end
