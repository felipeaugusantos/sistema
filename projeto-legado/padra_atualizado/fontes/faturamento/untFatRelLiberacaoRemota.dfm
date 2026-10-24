inherited frmRelLiberacaoRemota: TfrmRelLiberacaoRemota
  Width = 955
  Height = 484
  BorderStyle = bsSingle
  Caption = 'Log de Libera'#231#227'o Remota'
  Position = poDesigned
  ExplicitLeft = -201
  ExplicitWidth = 955
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 413
    Width = 949
    ExplicitTop = 413
    ExplicitWidth = 713
    inherited FlwBotoes: TFlowPanel
      Width = 945
      ExplicitLeft = 3
      ExplicitTop = 0
      ExplicitWidth = 709
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
      object btnCadCliente: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 114
        Height = 22
        Caption = '[F5] Cad. Cliente'
        TabOrder = 1
        OnClick = btnCadClienteClick
      end
      object btnReimprimir: TBitBtnLocked
        Left = 189
        Top = 0
        Width = 148
        Height = 22
        Caption = '[F6] Reimprimir Documento'
        TabOrder = 2
        OnClick = btnReimprimirClick
      end
      object btnAnalisar: TBitBtnLocked
        Left = 337
        Top = 0
        Width = 198
        Height = 22
        Caption = '[F7] Analisar Solicita'#231#227'o de Libera'#231#227'o'
        TabOrder = 3
        OnClick = btnAnalisarClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 535
        Top = 0
        Width = 74
        Height = 22
        Caption = '[F8] Imprimir'
        TabOrder = 4
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 866
      ExplicitLeft = 866
    end
  end
  inherited pnlStatus: TPanel
    Top = 439
    Width = 949
    ExplicitTop = 439
    ExplicitWidth = 949
    inherited pnlNomeForm: TPanel
      Left = 778
      ExplicitLeft = 778
    end
    inherited pnlInfo: TPanel
      Width = 778
      ExplicitWidth = 778
    end
  end
  object pnlFiltro: TPanel [2]
    Left = 0
    Top = 0
    Width = 949
    Height = 160
    Align = alTop
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 7
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
    end
    object Label3: TLabel
      Left = 79
      Top = 7
      Width = 47
      Height = 14
      Caption = 'Data Final'
    end
    object lblOpe: TLabel
      Left = 155
      Top = 7
      Width = 46
      Height = 14
      Caption = 'Operador'
    end
    object lblNumDoc: TLabel
      Left = 541
      Top = 46
      Width = 69
      Height = 14
      Caption = 'N'#186' Documento'
    end
    object lblEspFat: TLabel
      Left = 624
      Top = 46
      Width = 21
      Height = 14
      Caption = 'Esp.'
    end
    object Label1: TLabel
      Left = 8
      Top = 84
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object Label4: TLabel
      Left = 8
      Top = 46
      Width = 140
      Height = 14
      Caption = 'Palavra Chave na Solicita'#231#227'o'
    end
    object Label5: TLabel
      Left = 661
      Top = 46
      Width = 23
      Height = 14
      Caption = 'Emp.'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
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
      Left = 80
      Top = 22
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnAdicionar: TBitBtnLocked
      Left = 526
      Top = 131
      Width = 85
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 12
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 611
      Top = 131
      Width = 85
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 13
      OnClick = btnCancelaItemClick
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 155
      Top = 22
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 237
      Top = 22
      Width = 459
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 541
      Top = 60
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 624
      Top = 60
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 90
      Top = 99
      Width = 388
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object rdgStatus: TRadioGroup
      Left = 484
      Top = 88
      Width = 212
      Height = 36
      Caption = 'Solicita'#231#227'o'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Liberadas'
        'Negadas'
        'Todas')
      TabOrder = 10
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 99
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 8
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtPalCha: TEditFocus
      Left = 8
      Top = 60
      Width = 529
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
    object rdgOrdena: TRadioGroup
      Left = 8
      Top = 123
      Width = 425
      Height = 34
      Caption = 'Ordernar Por'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Data/Hora da Solicita'#231#227'o'
        'Operador da Solicita'#231#227'o'
        'Cliente')
      TabOrder = 11
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 661
      Top = 60
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  object cxgConsulta: TcxGridCitel [3]
    Left = 0
    Top = 160
    Width = 949
    Height = 253
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 713
    object cxgConsultaView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsul
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgConsultaViewSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
      end
      object cxgConsultaViewDTACAD: TcxGridDBColumn
        Caption = 'Data da Solicita'#231#227'o'
        DataBinding.FieldName = 'DTACAD'
      end
      object cxgConsultaViewNOMOPECAD: TcxGridDBColumn
        Caption = 'Operador da Solicita'#231#227'o'
        DataBinding.FieldName = 'NOMOPECAD'
      end
      object cxgConsultaViewDOCUME: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUME'
      end
      object cxgConsultaViewEMPRES: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPRES'
      end
      object cxgConsultaViewNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
      end
      object cxgConsultaViewTITULO: TcxGridDBColumn
        Caption = 'Assunto'
        DataBinding.FieldName = 'TITULO'
      end
      object cxgConsultaViewNOMVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'NOMVEN'
      end
      object cxgConsultaViewNOMOPELIB: TcxGridDBColumn
        Caption = 'Operador da Libera'#231#227'o / Nega'#231#227'o'
        DataBinding.FieldName = 'NOMOPELIB'
      end
    end
    object cxgConsultaLevel1: TcxGridLevel
      GridView = cxgConsultaView
    end
  end
  object dtsConsul: TDataSource
    Left = 384
    Top = 360
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44392.677341377300000000
    ReportOptions.LastChange = 44392.718149490700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Shape1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if Frac(<Line> / 2) = 0.5 then'
      '    Shape1.Color := clMoneyGreen  '
      '  else'
      
        '    Shape1.Color := clWhite;                                    ' +
        '                 '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 512
    Top = 276
    Datasets = <
      item
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
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
        Height = 41.574830000000000000
        Top = 188.976500000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        object Shape1: TfrxShapeView
          Width = 1050.709340000000000000
          Height = 41.574830000000000000
          OnBeforePrint = 'Shape1OnBeforePrint'
          Fill.BackColor = clWhite
          Fill.ForeColor = clRed
          Frame.Color = clNone
        end
        object Memo1: TfrxMemoView
          Top = 5.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."STATUS"]')
        end
        object Memo2: TfrxMemoView
          Left = 102.047310000000000000
          Top = 5.000000000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."DTACAD"]')
        end
        object Memo3: TfrxMemoView
          Left = 230.551330000000000000
          Top = 5.000000000000000000
          Width = 257.008040000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."NOMOPECAD"]')
        end
        object Memo4: TfrxMemoView
          Left = 491.338900000000000000
          Top = 5.000000000000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."DOCUME"]')
        end
        object Memo5: TfrxMemoView
          Left = 623.622450000000000000
          Top = 5.000000000000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."EMPRES"]')
        end
        object Memo6: TfrxMemoView
          Left = 789.921770000000000000
          Top = 5.000000000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."NOMCLI"]')
        end
        object Memo7: TfrxMemoView
          Top = 24.118120000000000000
          Width = 362.834880000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."TITULO"]')
        end
        object Memo8: TfrxMemoView
          Left = 374.173470000000000000
          Top = 24.118120000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."NOMVEN"]')
        end
        object Memo9: TfrxMemoView
          Left = 668.976810000000000000
          Top = 24.118120000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxDBDataset."NOMOPELIB"]')
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo10: TfrxMemoView
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Status')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 102.047310000000000000
          Top = 56.692950000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data da Solicita'#231#227'o')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 230.551330000000000000
          Top = 56.692950000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador da Solicita'#231#227'o')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 491.338900000000000000
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 623.622450000000000000
          Top = 56.692950000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 789.921770000000000000
          Top = 56.692950000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Top = 79.370130000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assunto')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 374.173470000000000000
          Top = 75.590600000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 668.976810000000000000
          Top = 75.590600000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador da Libera'#231#227'o / Nega'#231#227'o')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 102.047310000000000000
          Width = 1043.150280000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Log de Libera'#231#227'o Remota')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSource = dtsConsul
    BCDToCurrency = False
    Left = 576
    Top = 276
  end
end
