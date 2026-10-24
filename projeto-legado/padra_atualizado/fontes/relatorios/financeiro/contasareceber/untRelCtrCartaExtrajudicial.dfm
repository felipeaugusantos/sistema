inherited frmRelCtrCartaExtrajudicial: TfrmRelCtrCartaExtrajudicial
  Left = 329
  Top = 195
  Width = 329
  Height = 445
  Caption = 'Carta de Notifica'#231#227'o Extrajudicial'
  OnDestroy = FormDestroy
  ExplicitWidth = 329
  ExplicitHeight = 445
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlDados: TPanel [0]
    Width = 323
    Height = 374
    ExplicitWidth = 323
    ExplicitHeight = 374
    object Label1: TLabel [0]
      Left = 8
      Top = 60
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
    object lblEmpresa: TLabel [1]
      Left = 8
      Top = 138
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
    object Label5: TLabel [2]
      Left = 8
      Top = 177
      Width = 208
      Height = 14
      Caption = 'Modelo de carta de notifica'#231#227'o extrajudicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [3]
      Left = 8
      Top = 97
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
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 294
      Width = 307
      Height = 39
      Caption = ' Destino da carta de notifica'#231#227'o extrajudicial '
      TabOrder = 9
      ExplicitLeft = 8
      ExplicitTop = 294
      ExplicitWidth = 307
      ExplicitHeight = 39
      inherited ColorLabel1: TColorLabel
        Left = 38
        Top = 17
        Width = 152
        Caption = '(V)'#237'deo   (I)mpressora   e-(M)ail'
        ExplicitLeft = 38
        ExplicitTop = 17
        ExplicitWidth = 152
      end
      object shpLiberado: TShape [1]
        Left = 8
        Top = 13
        Width = 8
        Height = 22
      end
      inherited edtDestino: TEditFocus
        Left = 16
        Top = 13
        ExplicitLeft = 16
        ExplicitTop = 13
      end
    end
    object edtCliente: TEditFocus
      Left = 8
      Top = 74
      Width = 59
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnExit = edtClienteExit
      OnKeyPress = edtClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 68
      Top = 74
      Width = 247
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 152
      Width = 59
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
      TabOrder = 5
      OnExit = edtEmpresaExit
      OnKeyPress = edtEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 68
      Top = 152
      Width = 247
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbbModelo: TDBLookupComboBoxFocus
      Tag = 99
      Left = 8
      Top = 191
      Width = 307
      Height = 22
      KeyField = 'AUTOINCREM'
      ListField = 'EXJ_NOMEXJ'
      ListSource = dtsModelos
      TabOrder = 7
      OnKeyDown = cbbModeloKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object grp1: TGroupBox
      Left = 8
      Top = 217
      Width = 307
      Height = 76
      Caption = ' Etiquetas de Cliente '
      TabOrder = 8
      object lbl2: TLabel
        Left = 189
        Top = 17
        Width = 67
        Height = 14
        Caption = 'Qtd.Etiquetas:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkImpEti: TCheckBox
        Left = 6
        Top = 17
        Width = 103
        Height = 17
        Caption = 'Imprimir etiqueta'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtQtdEti: TEditFocus
        Tag = 99
        Left = 259
        Top = 13
        Width = 43
        Height = 22
        Alignment = taCenter
        TabOrder = 1
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object pnlEndere: TPanel
        Left = 6
        Top = 38
        Width = 296
        Height = 16
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object rdbEndCob: TRadioButton
          Left = 0
          Top = 1
          Width = 135
          Height = 15
          Caption = 'Endere'#231'o de cobran'#231'a'
          Checked = True
          Color = 16770261
          ParentColor = False
          TabOrder = 0
          TabStop = True
        end
        object rdbEndFat: TRadioButton
          Left = 150
          Top = 0
          Width = 145
          Height = 17
          Caption = 'Endere'#231'o de Faturamento'
          Color = 16770261
          ParentColor = False
          TabOrder = 1
        end
      end
      object pnlTipImp: TPanel
        Left = 6
        Top = 57
        Width = 296
        Height = 16
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object rdbImpLas: TRadioButton
          Left = 1
          Top = -4
          Width = 143
          Height = 18
          Caption = 'Impressora Laser/Argox'
          Checked = True
          Color = 16770261
          ParentColor = False
          TabOrder = 0
          TabStop = True
        end
        object rdbImpMat: TRadioButton
          Left = 150
          Top = 0
          Width = 118
          Height = 17
          Caption = 'Impressora Matricial'
          Color = 16770261
          ParentColor = False
          TabOrder = 1
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 1
      Width = 314
      Height = 59
      Caption = ' Data de Vencimento '
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      object Label12: TLabel
        Left = 4
        Top = 15
        Width = 26
        Height = 14
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 100
        Top = 15
        Width = 22
        Height = 14
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskDtaIni: TcxDateEdit
        Tag = 99
        Left = 4
        Top = 30
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
        TabOrder = 0
        Width = 90
      end
      object mskDtaFin: TcxDateEdit
        Tag = 99
        Left = 100
        Top = 30
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
        TabOrder = 1
        Width = 90
      end
    end
    object edtPortador: TEditFocus
      Left = 8
      Top = 113
      Width = 59
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnExit = edtPortadorExit
      OnKeyPress = edtPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortador: TEditFocus
      Left = 68
      Top = 113
      Width = 247
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rgFormaEnvio: TRadioGroup
      Left = 8
      Top = 334
      Width = 307
      Height = 34
      Caption = ' Gerar carta em '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Word/ODS'
        'PDF')
      TabOrder = 10
    end
  end
  inherited pnlStatus: TPanel
    Top = 400
    Width = 323
    ExplicitTop = 400
    ExplicitWidth = 323
    inherited pnlNomeForm: TPanel
      Left = 152
      ExplicitLeft = 152
    end
    inherited pnlInfo: TPanel
      Width = 152
      ExplicitWidth = 152
    end
  end
  inherited pnlBotoes: TPanel [2]
    Top = 374
    Width = 323
    ExplicitTop = 374
    ExplicitWidth = 323
    inherited FlwBotoes: TFlowPanel
      Width = 242
      ExplicitWidth = 242
    end
    inherited btnSair: TBitBtnLocked
      Left = 244
      ExplicitLeft = 244
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed10CPP
    Left = 392
    Top = 72
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 424
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 360
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 392
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 424
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 456
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 184
    Top = 64
  end
  inherited frxGen: TfrxUserDataSet
    Left = 140
    Top = 64
  end
  inherited frxDesigner: TfrxDesigner
    Left = 392
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 424
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 138
  end
  object frxEmpresa: TfrxDBDataset
    UserName = 'frxEmpresa'
    CloseDataSource = False
    DataSet = qryEmpresa
    BCDToCurrency = False
    Left = 272
    Top = 120
  end
  object qryEmpresa: TUniQuery
    ReadOnly = True
    Constraints = <>
    Left = 228
    Top = 120
  end
  object frxCartaExtrajudicial_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39576.553488044000000000
    ReportOptions.LastChange = 39594.640228101800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxCartaExtrajudicial_MUserFunction
    Left = 96
    Top = 120
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
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
    object Page1: TfrxDMPPage
      PaperWidth = 330.199786745971100000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      FontStyle = []
      object PHTitulo: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo3: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 85.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 68.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 102.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."EMP_F_A_X_"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 38.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CEP : ')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Fone : ')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 102.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FAX : ')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Emitido em : ')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 119.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRemoveAcentoEspecificos(<frxEmpresa."EMPRESA">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRemoveAcentoEspecificos(<frxEmpresa."ENDERECO">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fRemoveAcentoEspecificos(<frxEmpresa."BAIRRO">)]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GHCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 238.000000000000000000
        Width = 1248.000000000000000000
        Child = frxCartaExtrajudicial_M.CCabecalho
        Condition = 'frxRelatorio."CTR_CODCLI"'
        object DMPMemo20: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 34.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            ',')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd '#39'de'#39' mmmm '#39'de'#39' yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PREZADO SENHOR(a) :  ')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 85.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[fRemoveAcentoEspecificos(<frxEmpresa."CIDADE_CARTA">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 136.000000000000000000
          Width = 960.000000000000000000
          Height = 204.000000000000000000
          StretchMode = smActualHeight
          FontStyle = []
          Memo.UTF8W = (
            
              'Na qualidade de jur'#237'dico da empresa {{NOMEMP}}, inscrita no CNPJ' +
              ' sob o n'#176' {{CGCEMP}}, constitu'#237'da atrav'#233's do instrumento de proc' +
              'ura'#231#227'o que fica arquivado em nosso escrit'#243'rio, venho atrav'#233's da ' +
              'presente, NOTIFICAR V.Sa. EXTRAJUDICIALMENTE do inteiro teor, pe' +
              'los motivos de direito a seguir articulados, antes de acion'#225'-los' +
              ' perante a Justi'#231'a:'
            
              'V.Sa. realizou compras de materiais de pintura/constru'#231#227'o estabe' +
              'lecimento da empresa acima citada. As mercadorias, acima mencion' +
              'adas lhe foram devidamente entregues, por'#233'm, n'#227'o identificamos o' +
              ' pagamento das mesmas.'
            
              'A empresa, por diversas vezes efetuou contato telef'#244'nico com V.S' +
              'a. lhe dando ci'#234'ncia dos valores que estavam em atraso, por'#233'm at' +
              #233' a presente o pagamento n'#227'o foi efetuado. '
            
              'Fundado por motivos justos e delineados nas linhas acima, servim' +
              'os da presente para formalizar tais ocorr'#234'ncias e aguardamos no ' +
              'prazo de 48 HORAS (quarenta e oito horas) o seu contato, para qu' +
              'e possamos resolver a quest'#227'o discorrida ainda de forma extrajud' +
              'icial. Caso, n'#227'o haja retorno dentro do referido prazo, ser'#227'o to' +
              'madas todas as medidas judiciais cab'#237'veis. '
            
              'Sendo o que apresentamos no momento, firmamos a presente e, desd' +
              'e j'#225' nos colocamos a disposi'#231#227'o para quaisquer esclarecimentos a' +
              'trav'#233's dos telefones n'#186': {{FONEMP}}.  Caso j'#225' tenha ocorrido a q' +
              'uita'#231#227'o do d'#233'bito, por favor, enviar o comprovante para o e-mail' +
              ' {{EMAILEMP}}.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object CCabecalho: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 595.000000000000000000
        Visible = False
        Width = 1248.000000000000000000
        object DMPMemo29: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TITULO')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENCIMENTO')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR CORRIGIDO')
          TruncOutboundText = False
        end
      end
      object MDContasReceber: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 663.000000000000000000
        Visible = False
        Width = 1248.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo34: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CORRIGIDO"]')
          TruncOutboundText = False
        end
      end
      object GFCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 238.000000000000000000
        Top = 697.000000000000000000
        Width = 1248.000000000000000000
        object Memo1: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_CORRIGIDO">,MDContasReceber,0)]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Certos de sua atencao, agradecemos e aguardamos sua breve comuni' +
              'cacao.')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Align = baCenter
          Left = 460.800000000000000000
          Top = 85.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'Cordialmente.')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 136.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'OBS : Caso ja tenha efetuado o pagamento, queira desconsiderar e' +
              'ste aviso.')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VALOR TOTAL : ')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">,MDContasReceber,0)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxCartaExtrajudicial_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39576.553488044000000000
    ReportOptions.LastChange = 44613.385616226850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Page1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxInformacoes."IMAGEM"> = '#39'S'#39') Then                     ' +
        '          '
      '    Imagem.LoadFromFile(<frxInformacoes."DIRETORIO">);  '
      'end;'
      ''
      'procedure DateOnBeforePrint(Sender: TfrxComponent);'
      '  var'
      '    strMes: string;'
      'begin'
      '  strMes := FormatDateTime('#39'mmmm'#39', nOw);'
      
        '  strMes := UpperCase(strMes[1]) + Copy(strMes, 2, Length(strMes' +
        ') -1);'
      
        '  strMes := FormatDateTime('#39'dd'#39', nOw) + '#39' de '#39' + strMes + '#39' de '#39 +
        ' + FormatDateTime('#39'yyyy'#39', nOw);      '
      
        '  rllDate.Text := strMes;                                       ' +
        '                                    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 96
    Top = 64
    Datasets = <
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxInformacoes
        DataSetName = 'frxInformacoes'
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      OnBeforePrint = 'Page1OnBeforePrint'
      object PHTitulo: TfrxPageHeader
        FillType = ftBrush
        Height = 177.559060000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object Memo2: TfrxMemoView
          Left = 260.740260000000000000
          Top = 36.000000000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."ENDERECO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 298.315090000000000000
          Top = 88.031540000000000000
          Width = 488.087940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 260.740260000000000000
          Top = 52.881880000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."BAIRRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 294.756030000000000000
          Top = 71.000000000000000000
          Width = 491.867470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 294.535560000000000000
          Top = 104.677180000000000000
          Width = 491.867470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_F_A_X_"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 261.392270000000000000
          Top = 71.000000000000000000
          Width = 33.788930000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP : ')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 261.392270000000000000
          Top = 104.677180000000000000
          Width = 33.788930000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FAX : ')
          ParentFont = False
        end
        object Imagem: TfrxPictureView
          Left = 17.007885000000000000
          Top = 18.897650000000000000
          Width = 238.110390000000000000
          Height = 120.944960000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo43: TfrxMemoView
          Left = 262.141930000000000000
          Top = 19.118120000000000000
          Width = 525.883240000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMPRESA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 260.787570000000000000
          Top = 87.944960000000000000
          Width = 37.568460000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone : ')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 260.787570000000000000
          Top = 122.063080000000000000
          Width = 67.804700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em : ')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 328.819110000000000000
          Top = 122.063080000000000000
          Width = 457.851700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          ParentFont = False
        end
      end
      object GHCliente: TfrxGroupHeader
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 257.008040000000000000
        Width = 793.701300000000000000
        Child = frxCartaExtrajudicial_J.CCabecalho
        Condition = 'frxRelatorio."CTR_CODCLI"'
        object Memo19: TfrxMemoView
          Left = 79.464440000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxEmpresa."CIDADE_CARTA"]')
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 386.664440000000000000
          Top = 34.000000000000000000
          Width = 7.861410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            ',')
        end
        object rllDate: TfrxMemoView
          Left = 394.864440000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DateOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd '#39'de'#39' mmmm '#39'de'#39' yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 80.125850000000000000
          Top = 75.000000000000000000
          Width = 157.984230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PREZADO SENHOR (a) :  ')
        end
        object Memo23: TfrxMemoView
          Left = 242.110080000000000000
          Top = 75.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 79.000000000000000000
          Top = 111.991960000000000000
          Width = 686.488250000000000000
          Height = 203.897650000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Na qualidade de jur'#237'dico da empresa {{NOMEMP}}, inscrita no CNPJ' +
              ' sob o n'#176' {{CGCEMP}}, constitu'#237'da atrav'#233's do instrumento de proc' +
              'ura'#231#227'o que fica arquivado em nosso escrit'#243'rio, venho atrav'#233's da ' +
              'presente, NOTIFICAR V.Sa. EXTRAJUDICIALMENTE do inteiro teor, pe' +
              'los motivos de direito a seguir articulados, antes de acion'#225'-los' +
              ' perante a Justi'#231'a:'
            
              'V.Sa. realizou compras de materiais de pintura/constru'#231#227'o estabe' +
              'lecimento da empresa acima citada. As mercadorias, acima mencion' +
              'adas lhe foram devidamente entregues, por'#233'm, n'#227'o identificamos o' +
              ' pagamento das mesmas.'
            
              'A empresa, por diversas vezes efetuou contato telef'#244'nico com V.S' +
              'a. lhe dando ci'#234'ncia dos valores que estavam em atraso, por'#233'm at' +
              #233' a presente o pagamento n'#227'o foi efetuado. '
            
              'Fundado por motivos justos e delineados nas linhas acima, servim' +
              'os da presente para formalizar tais ocorr'#234'ncias e aguardamos no ' +
              'prazo de 48 HORAS (quarenta e oito horas) o seu contato, para qu' +
              'e possamos resolver a quest'#227'o discorrida ainda de forma extrajud' +
              'icial. Caso, n'#227'o haja retorno dentro do referido prazo, ser'#227'o to' +
              'madas todas as medidas judiciais cab'#237'veis. '
            
              'Sendo o que apresentamos no momento, firmamos a presente e, desd' +
              'e j'#225' nos colocamos a disposi'#231#227'o para quaisquer esclarecimentos a' +
              'trav'#233's dos telefones n'#186': {{FONEMP}}.  Caso j'#225' tenha ocorrido a q' +
              'uita'#231#227'o do d'#233'bito, por favor, enviar o comprovante para o e-mail' +
              ' {{EMAILEMP}}.')
          ParentFont = False
        end
      end
      object CCabecalho: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 619.842920000000000000
        Visible = False
        Width = 793.701300000000000000
        object Memo29: TfrxMemoView
          Left = 101.977860000000000000
          Top = 34.000000000000000000
          Width = 187.086614170000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'T'#205'TULO')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 301.711750000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 408.878540000000000000
          Top = 34.000000000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO T'#205'TULO')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 557.887940000000000000
          Top = 34.000000000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR CORRIGIDO')
          ParentFont = False
        end
      end
      object MDContasReceber: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 695.433520000000000000
        Visible = False
        Width = 793.701300000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo34: TfrxMemoView
          Left = 101.977860000000000000
          Width = 187.086614170000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
        end
        object Memo35: TfrxMemoView
          Left = 302.711750000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
        end
        object Memo37: TfrxMemoView
          Left = 411.319480000000000000
          Width = 128.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
        end
        object Memo38: TfrxMemoView
          Left = 557.667470000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CORRIGIDO"]')
        end
      end
      object GFCliente: TfrxGroupFooter
        FillType = ftBrush
        Height = 140.000000000000000000
        Top = 737.008350000000000000
        Width = 793.701300000000000000
        object Memo39: TfrxMemoView
          Align = baCenter
          Left = 132.964070000000000000
          Top = 57.000000000000000000
          Width = 527.773160000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Certos de sua aten'#231#227'o, agradecemos e aguardamos sua breve comuni' +
              'ca'#231#227'o.')
        end
        object Memo40: TfrxMemoView
          Align = baCenter
          Left = 233.650650000000000000
          Top = 78.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'Cordialmente.')
        end
        object Memo41: TfrxMemoView
          Align = baCenter
          Left = 166.375140000000000000
          Top = 101.000000000000000000
          Width = 460.951020000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'OBS : Caso j'#225' tenha efetuado o pagamento, queira desconsiderar e' +
              'ste aviso.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 288.727520000000000000
          Top = 4.779530000000000000
          Width = 109.984230000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL : ')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 557.667470000000000000
          Top = 4.118120000000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_CORRIGIDO">,MDContasReceber,0)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 411.319480000000000000
          Top = 4.324983330000000000
          Width = 132.661410000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDUP">,MDContasReceber,0)]')
          ParentFont = False
        end
      end
    end
  end
  object frxInformacoes: TfrxDBDataset
    UserName = 'frxInformacoes'
    CloseDataSource = False
    DataSet = qryInformacoes
    BCDToCurrency = False
    Left = 228
    Top = 64
  end
  object qryInformacoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 64
    object qryInformacoesIMAGEM: TStringField
      FieldName = 'IMAGEM'
      Size = 1
    end
    object qryInformacoesDIRETORIO: TStringField
      FieldName = 'DIRETORIO'
      Size = 255
    end
  end
  object qryModelos: TUniQuery
    SQL.Strings = (
      'SELECT'
      '  AUTOINCREM,'
      '  EXJ_NOMEXJ,'
      '  EXJ_PATEXJ'
      'FROM'
      '  CAREXJ'
      'WHERE'
      '  EXJ_CODEMP = :CODEMP'
      'ORDER BY'
      '  EXJ_NOMEXJ')
    ReadOnly = True
    Constraints = <>
    Left = 140
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODEMP'
        Value = nil
      end>
    object qryModelosAUTOINCREM: TStringField
      DisplayWidth = 20
      FieldName = 'AUTOINCREM'
    end
    object qryModelosEXJ_NOMEXJ: TStringField
      FieldName = 'EXJ_NOMEXJ'
      Size = 50
    end
    object qryModelosEXJ_PATEXJ: TStringField
      FieldName = 'EXJ_PATEXJ'
      Size = 255
    end
  end
  object dtsModelos: TDataSource
    DataSet = qryModelos
    Left = 184
    Top = 120
  end
end
