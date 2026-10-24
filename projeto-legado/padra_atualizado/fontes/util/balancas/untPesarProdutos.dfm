inherited frmPesarProdutos: TfrmPesarProdutos
  Width = 470
  Height = 310
  BorderIcons = [biSystemMenu]
  Caption = 'Pesagem/Contagem de Produtos'
  Position = poDesigned
  OnDestroy = FormDestroy
  ExplicitWidth = 470
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 237
    Width = 464
    ExplicitTop = 237
    ExplicitWidth = 464
    object lblBalanca: TLabel [0]
      Left = 180
      Top = 7
      Width = 102
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Desconectado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 156
      Width = 229
      TabOrder = 3
      ExplicitLeft = 156
      ExplicitTop = 2
      ExplicitWidth = 229
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 385
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 385
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnBalanca: TBitBtnLocked
      Left = 79
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Balan'#231'a'
      Enabled = False
      Glyph.Data = {
        26040000424D2604000000000000360000002800000012000000120000000100
        180000000000F0030000130B0000130B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FAFAF9E6E5E6
        EAEBECE8E9E9E8EAEAE5E5E5E3E3E3E2E3E3E3E4E4E2E4E4E2E3E3E8EAEBECEF
        F1E9EDEFEDEFF1ECEDF1E5E5E6FDFDFD0000F5F6F6DDD9D6BFAFAFD0C6C4C1B4
        B3F6FCFDFDFFFFFBFFFFFAFFFFFBFFFFFDFFFFCAB5ABA2846EAD927F9B7F689E
        806ACCC4BFFAFAFB0000FFFFFFDFDFDDCFB4A3D1B8ABCEB8A7C4AA99BC9E8CB8
        9C8AB99A88B69482CBBFB8C1A394B79E8ABB9E8F714623683712D3D1CFFFFFFF
        0000FFFFFFE8EEEF7031136D2B11722E1374331572311476371A6E2E126A2709
        AD8C7CC9B0A3CFBDB1D1BCAF6F431C70401EE9F0F2FFFFFF0000FFFFFFEFF3F4
        B29382B09182AC8D7EAB8D7EB19587AC8F80B39A8CAD9083C7BCB6BFA595B28C
        75B18A769D7359A2836DF1F5F9FFFFFF0000FFFFFFDBDBDB645E5F7675788486
        8C84858B84858A85858D86868D84868C83848A8281897E7D8579787F66656C5F
        5B60F5F4F4FFFFFF0000FFFFFFFFFFFFC7C4C5C3BBBACEC5C6D3CECDDCD7D8E5
        E0E0EBE8E7F0EFEDF3F3F1F7F7F6FAF8F7F9F8F7F1EDEEE8E6E7FFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFC4BFBFC6BEBDCFC9C9D5CFD1DAD5D6E1DBDDE6E3E3
        E8E6E6ECEAEAEDEBEBEDEBEAE2E0E0FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFF0F0EFF2F1F1F3F2F2F3F2F2F4F3F3F6F6F6F6F6F6F6F5F5F5F5
        F5F4F4F4FBFBFBFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000}
      TabOrder = 1
      OnClick = btnBalancaClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Imprimir'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnImprimirClick
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 464
    Height = 165
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lbl5: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 8
      Top = 46
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 8
      Top = 84
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 412
      Top = 46
      Width = 39
      Height = 14
      Caption = 'Unidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 8
      Top = 122
      Width = 89
      Height = 14
      Caption = 'Localiza'#231#227'o F'#237'sica'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 8
      Top = 60
      Width = 400
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtRefere: TEditFocus
      Left = 8
      Top = 98
      Width = 400
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtDesUni: TEditFocus
      Left = 412
      Top = 60
      Width = 36
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtLocFis: TEditFocus
      Left = 8
      Top = 136
      Width = 400
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object rdgTipoLeitura: TRadioGroup
      Left = 79
      Top = 8
      Width = 373
      Height = 36
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Leitura de Dados pela Balan'#231'a'
        'Digita'#231#227'o Manual')
      TabOrder = 5
      OnClick = rdgTipoLeituraClick
    end
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 165
    Width = 464
    Height = 72
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = -1
    ExplicitTop = 166
    object lblInf1: TLabel
      Left = 9
      Top = 8
      Width = 145
      Height = 16
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Peso Kg'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblInf2: TLabel
      Left = 160
      Top = 8
      Width = 143
      Height = 16
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'PMP Kg'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblInf3: TLabel
      Left = 309
      Top = 8
      Width = 143
      Height = 16
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Pe'#231'as'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtInf1: TStaticText
      Left = 9
      Top = 27
      Width = 145
      Height = 35
      Alignment = taRightJustify
      AutoSize = False
      BevelKind = bkTile
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -27
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object edtInf2: TStaticText
      Left = 158
      Top = 27
      Width = 145
      Height = 35
      Alignment = taRightJustify
      AutoSize = False
      BevelKind = bkTile
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -27
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object edtInf3: TStaticText
      Left = 307
      Top = 27
      Width = 145
      Height = 35
      Alignment = taRightJustify
      AutoSize = False
      BevelKind = bkTile
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -27
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object edtInfDig1: TEditFocus
      Tag = 99
      Left = 15
      Top = 34
      Width = 132
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnChange = edtInfDig1Change
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtInfDig2: TEditFocus
      Tag = 99
      Left = 164
      Top = 34
      Width = 132
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Visible = False
      OnChange = edtInfDig2Change
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtInfDig3: TEditFocus
      Tag = 99
      Left = 313
      Top = 34
      Width = 132
      Height = 22
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnChange = edtInfDig3Change
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
      EditFormat = '00000'
    end
  end
  inherited pnlStatus: TPanel
    Top = 265
    Width = 464
    ExplicitTop = 265
    ExplicitWidth = 464
    inherited pnlNomeForm: TPanel
      Left = 293
      ExplicitLeft = 293
    end
    inherited pnlInfo: TPanel
      Width = 293
      ExplicitWidth = 293
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 165
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 8
  end
  object frxEtiqueta: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39533.400137060200000000
    ReportOptions.LastChange = 40969.696496666660000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 255
    Top = 8
    Datasets = <
      item
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Etiqueta: TfrxReportPage
      PaperWidth = 102.000000000000000000
      PaperHeight = 22.000000000000000000
      PaperSize = 256
      TopMargin = -1.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 83.149606300000000000
        Top = 18.897650000000000000
        Width = 385.512060000000000000
        Columns = 3
        ColumnWidth = 132.283464566929000000
        DataSet = frxDataSet
        DataSetName = 'frxDataSet'
        RowCount = 0
        object BarCode1: TfrxBarCodeView
          Left = 26.456692910000000000
          Top = 53.803149610000000000
          Width = 103.000000000000000000
          Height = 30.236220470000000000
          BarType = bcCodeEAN13
          DataField = 'CODBAR'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          Rotation = 0
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object rllDesIte: TfrxMemoView
          Left = 8.440939990000000000
          Top = 4.763760010000000000
          Width = 105.821583340000000000
          Height = 26.230983340000000000
          DataField = 'DESITE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataSet."DESITE"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 29.236220470000000000
          Width = 105.821583340000000000
          Height = 14.892393340000000000
          DataField = 'REFERE'
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataSet."REFERE"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 40.574803150000000000
          Width = 105.821583340000000000
          Height = 14.892393340000000000
          DataSet = frxDataSet
          DataSetName = 'frxDataSet'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSet."QTDITE"] [frxDataSet."DESUNI"]')
          ParentFont = False
        end
      end
    end
  end
  object cdsEtiqueta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 8
    object cdsEtiquetaCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsEtiquetaCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 15
    end
    object cdsEtiquetaDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsEtiquetaREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsEtiquetaLOCFIS: TStringField
      FieldName = 'LOCFIS'
      Size = 14
    end
    object fltfldEtiquetaQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsEtiquetaDESUNI: TStringField
      FieldName = 'DESUNI'
      Size = 15
    end
  end
  object frxDataSet: TfrxDBDataset
    UserName = 'frxDataSet'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODITE=CODITE'
      'CODBAR=CODBAR'
      'DESITE=DESITE'
      'REFERE=REFERE'
      'LOCFIS=LOCFIS'
      'QTDITE=QTDITE'
      'DESUNI=DESUNI')
    DataSet = cdsEtiqueta
    BCDToCurrency = False
    Left = 306
    Top = 8
  end
end
