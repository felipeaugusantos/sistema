inherited frmReimpressaoCompInspecao: TfrmReimpressaoCompInspecao
  Width = 890
  Height = 596
  Caption = 'Reimpress'#227'o de Comprovante de Inspe'#231#227'o de Equipamentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 890
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 523
    Width = 884
    TabOrder = 2
    ExplicitTop = 523
    ExplicitWidth = 884
    inherited FlwBotoes: TFlowPanel
      Width = 880
      ExplicitWidth = 880
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] &Imprimir'
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
    inherited btnSair: TBitBtnLocked
      Left = 801
      ExplicitLeft = 801
    end
  end
  inherited pnlStatus: TPanel
    Top = 551
    Width = 884
    TabOrder = 3
    ExplicitTop = 551
    ExplicitWidth = 884
    inherited pnlNomeForm: TPanel
      Left = 713
      ExplicitLeft = 713
    end
    inherited pnlInfo: TPanel
      Width = 713
      ExplicitWidth = 713
    end
  end
  object pnlPeriodo: TPanel [2]
    Left = 0
    Top = 0
    Width = 884
    Height = 60
    Align = alTop
    TabOrder = 0
    object lblDtaInspSai: TLabel
      Left = 17
      Top = 11
      Width = 146
      Height = 14
      Caption = 'Per'#237'odo de Inspe'#231#227'o de Sa'#237'da:'
    end
    object lblDtaInspEnt: TLabel
      Left = 272
      Top = 11
      Width = 156
      Height = 14
      Caption = 'Per'#237'odo de Inspe'#231#227'o de Entrada:'
    end
    object Label1: TLabel
      Left = 106
      Top = 31
      Width = 17
      Height = 14
      Caption = 'At'#233
    end
    object Label2: TLabel
      Left = 361
      Top = 31
      Width = 17
      Height = 14
      Caption = 'At'#233
    end
    object mskDtaIspSaiIni: TMaskEditFocus
      Tag = 99
      Left = 17
      Top = 28
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaIspEntIni: TMaskEditFocus
      Tag = 99
      Left = 272
      Top = 28
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaIspSaiFim: TMaskEditFocus
      Tag = 99
      Left = 129
      Top = 28
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaIspEntFim: TMaskEditFocus
      Tag = 99
      Left = 384
      Top = 28
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlDadosContrato: TPanel [3]
    Left = 0
    Top = 60
    Width = 884
    Height = 85
    Align = alTop
    TabOrder = 1
    DesignSize = (
      884
      85)
    object lblNumCon: TLabel
      Left = 18
      Top = 35
      Width = 44
      Height = 14
      Caption = 'Contrato:'
    end
    object lblCodCli: TLabel
      Left = 26
      Top = 59
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblEmpresa: TLabel
      Left = 17
      Top = 11
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 67
      Top = 31
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      OnKeyPress = edtNumConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 164
      Top = 54
      Width = 533
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 67
      Top = 54
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 67
      Top = 8
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 164
      Top = 8
      Width = 533
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object btnCarrega: TBitBtnLocked
      Left = 713
      Top = 53
      Width = 156
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Carregar Inspe'#231#245'es'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000020000
        000A000000160000001B000000170000000B0000000200000000000000010000
        00060000000B0000000F0000000C0000000600000001000000000000000F2616
        1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
        1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
        70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
        72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
        D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
        D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
        F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
        F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
        E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
        E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
        A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
        CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
        5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
        CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
        3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
        D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
        1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
        E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
        0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
        C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
        0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
        58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
        0000000000010000000400000006000000050000000200000000000000000000
        0001000000010000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 5
      OnClick = btnCarregaClick
    end
  end
  object pnlPrincipal: TPanel [4]
    Left = 0
    Top = 145
    Width = 884
    Height = 378
    Align = alClient
    TabOrder = 4
    object cxGridInspecoes: TcxGridCitel
      Left = 1
      Top = 1
      Width = 882
      Height = 362
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridInspecoesView: TcxGridDBTableViewCitel
        OnKeyDown = cxGridInspecoesViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGridInspecoesViewCellDblClick
        OnCustomDrawCell = cxGridInspecoesViewCustomDrawCell
        DataController.DataSource = dtsInspecoes
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridInspecoesViewEQL_NROCON: TcxGridDBColumn
          Caption = 'Contrato'
          DataBinding.FieldName = 'EQL_NROCON'
          Options.Editing = False
          Width = 159
        end
        object cxGridInspecoesViewCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Options.Editing = False
          Width = 397
        end
        object cxGridInspecoesViewEQD_DESCRI: TcxGridDBColumn
          Caption = 'Equipamento'
          DataBinding.FieldName = 'EQD_DESCRI'
          Options.Editing = False
        end
        object cxGridInspecoesViewEQD_ISPSAI: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de Sa'#237'da'
          DataBinding.FieldName = 'EQD_ISPSAI'
          Options.Editing = False
          Width = 141
        end
        object cxGridInspecoesViewEQD_ISPENT: TcxGridDBColumn
          Caption = 'Inspe'#231#227'o de Entrada'
          DataBinding.FieldName = 'EQD_ISPENT'
          Options.Editing = False
          Width = 153
        end
        object cxGridInspecoesViewEQD_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_MARDES'
          Visible = False
        end
        object cxGridInspecoesViewEQD_SEQEQL: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_SEQEQL'
          Visible = False
        end
      end
      object cxGridInspecoesLevel1: TcxGridLevel
        GridView = cxGridInspecoesView
      end
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 363
      Width = 882
      Height = 14
      Align = alBottom
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object lblMarca: TLabel
        Left = 0
        Top = 0
        Width = 207
        Height = 14
        Align = alLeft
        Caption = '[ENTER] Marca / Desmarca Documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 207
        Top = 0
        Width = 246
        Height = 14
        Align = alLeft
        Caption = ' [Duplo Clique] Marca / Desmarca Documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 736
    Top = 8
  end
  object cdsInspecoes: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQL_NROCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_ISPSAI'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_ISPENT'
        DataType = ftDateTime
      end
      item
        Name = 'CLI_NOMCLI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 236
    object cdsInspecoesEQL_NROCON: TStringField
      FieldName = 'EQL_NROCON'
    end
    object cdsInspecoesEQD_ISPSAI: TDateTimeField
      FieldName = 'EQD_ISPSAI'
    end
    object cdsInspecoesEQD_ISPENT: TDateTimeField
      FieldName = 'EQD_ISPENT'
    end
    object cdsInspecoesCLI_NOMCLI: TStringField
      DisplayWidth = 100
      FieldName = 'CLI_NOMCLI'
      Size = 100
    end
    object cdsInspecoesEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsInspecoesEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsInspecoesEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsInspecoesEQD_DESCRI: TStringField
      FieldName = 'EQD_DESCRI'
      Size = 100
    end
    object cdsInspecoesAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object dtsInspecoes: TUniDataSource
    DataSet = cdsInspecoes
    Left = 120
    Top = 236
  end
end
