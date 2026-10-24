inherited frmCadLeadVincularOrcamentos: TfrmCadLeadVincularOrcamentos
  Width = 777
  Height = 355
  Caption = 'Vincular Or'#231'amentos'
  Position = poMainFormCenter
  ExplicitWidth = 777
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 282
    Width = 771
    ExplicitTop = 282
    ExplicitWidth = 771
    inherited FlwBotoes: TFlowPanel
      Width = 767
      ExplicitWidth = 767
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 691
      ExplicitLeft = 691
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    Width = 771
    ExplicitTop = 310
    ExplicitWidth = 771
    inherited pnlNomeForm: TPanel
      Left = 600
      ExplicitLeft = 600
    end
    inherited pnlInfo: TPanel
      Width = 600
      ExplicitWidth = 600
    end
  end
  object cxgOrcamentos: TcxGridCitel [2]
    Left = 0
    Top = 105
    Width = 771
    Height = 177
    Align = alClient
    TabOrder = 3
    TabStop = False
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgOrcamentosDBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgOrcamentosDBTableViewCitel1Column7: TcxGridDBColumn
        Caption = 'Selecionar'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgOrcamentosDBTableViewCitel1Column7PropertiesChange
        Options.FilteringMRUItemsList = False
        Width = 65
      end
      object cxgOrcamentosDBTableViewCitel1Column1: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Options.Editing = False
        Width = 106
      end
      object cxgOrcamentosDBTableViewCitel1Column2: TcxGridDBColumn
        Caption = 'Especie'
        DataBinding.FieldName = 'FGO_ESPDOC'
        Options.Editing = False
        Width = 55
      end
      object cxgOrcamentosDBTableViewCitel1Column6: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FGO_CODEMP'
        Options.Editing = False
        Width = 65
      end
      object cxgOrcamentosDBTableViewCitel1Column3: TcxGridDBColumn
        Caption = 'C'#243'd. cliente'
        DataBinding.FieldName = 'FGO_CODCLI'
        Options.Editing = False
        Width = 75
      end
      object cxgOrcamentosDBTableViewCitel1Column4: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Options.Editing = False
        Width = 245
      end
      object cxgOrcamentosDBTableViewCitel1Column5: TcxGridDBColumn
        Caption = 'Total de Produtos'
        DataBinding.FieldName = 'FGO_TOTPRO'
        Options.Editing = False
        Width = 100
      end
    end
    object cxgOrcamentosLevel1: TcxGridLevel
      GridView = cxgOrcamentosDBTableViewCitel1
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 771
    Height = 105
    Align = alTop
    TabOrder = 2
    DesignSize = (
      771
      105)
    object lblCodCli: TLabel
      Left = 80
      Top = 55
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDtaIni: TLabel
      Left = 16
      Top = 32
      Width = 106
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data do or'#231'amento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAteDtaIniObr: TLabel
      Left = 222
      Top = 32
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label1: TLabel
      Left = 70
      Top = 9
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumDoc: TLabel
      Left = 55
      Top = 79
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 128
      Top = 52
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 4
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
      Left = 212
      Top = 52
      Width = 278
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaOrcIni: TMaskEditFocus
      Tag = 99
      Left = 128
      Top = 29
      Width = 82
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaOrcFim: TMaskEditFocus
      Tag = 99
      Left = 234
      Top = 29
      Width = 82
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnCarrega: TBitBtnLocked
      Left = 598
      Top = 73
      Width = 145
      Height = 26
      Anchors = [akRight, akBottom]
      Caption = 'Carregar'
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
      TabOrder = 8
      WordWrap = True
      OnClick = btnCarregaClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 128
      Top = 6
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
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
      Left = 212
      Top = 6
      Width = 278
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 128
      Top = 75
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akBottom]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 6
      OnExit = edtNumDocExit
      OnKeyPress = edtNumDocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtDesNumDoc: TEditFocus
      Left = 212
      Top = 75
      Width = 278
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
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
    Left = 288
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 232
  end
end
