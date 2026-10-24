inherited frmManutNumSerieItens: TfrmManutNumSerieItens
  Width = 556
  Height = 568
  Caption = 'Manuten'#231#227'o do n'#250'mero de s'#233'rie dos itens'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 556
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 495
    Width = 550
    ExplicitTop = 495
    ExplicitWidth = 550
    inherited FlwBotoes: TFlowPanel
      Width = 546
      ExplicitWidth = 546
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F10 ] Confirma'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 467
      ExplicitLeft = 467
    end
  end
  inherited pnlStatus: TPanel
    Top = 523
    Width = 550
    ExplicitTop = 523
    ExplicitWidth = 550
    inherited pnlNomeForm: TPanel
      Left = 379
      ExplicitLeft = 379
    end
    inherited pnlInfo: TPanel
      Width = 379
      ExplicitWidth = 379
    end
  end
  object cxGridItens: TcxGrid [2]
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 544
    Height = 407
    Align = alClient
    TabOrder = 2
    object cxGridItensDBTableViewItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridItensDBTableViewItensCustomDrawCell
      OnFocusedRecordChanged = cxGridItensDBTableViewItensFocusedRecordChanged
      DataController.Options = [dcoAssignGroupingValues, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object cxGridItensDBTableViewItensSER_NUMSER: TcxGridDBColumn
        Caption = 'N'#186' de s'#233'rie atual'
        DataBinding.FieldName = 'SER_NUMSER'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 208
      end
      object cxGridItensDBTableViewItensSER_NNVSER: TcxGridDBColumn
        Caption = 'Novo n'#186' de s'#233'rie'
        DataBinding.FieldName = 'SER_NNVSER'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 191
      end
      object cxGridItensDBTableViewItensEDITAR: TcxGridDBColumn
        DataBinding.FieldName = 'EDITAR'
        Visible = False
      end
    end
    object cxGridItensLevel1: TcxGridLevel
      GridView = cxGridItensDBTableViewItens
    end
  end
  object pnlConsulta: TPanel [3]
    Tag = 99
    Left = 0
    Top = 0
    Width = 550
    Height = 41
    Align = alTop
    TabOrder = 3
    TabStop = True
    object lblItem: TLabel
      Left = 17
      Top = 14
      Width = 22
      Height = 14
      Caption = 'Item:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Left = 98
      Top = 11
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnPesquisarNumeros: TBitBtnLocked
      Left = 452
      Top = 11
      Width = 75
      Height = 22
      Caption = '&Pesquisar'
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
      TabOrder = 2
      OnClick = btnPesquisarNumerosClick
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 45
      Top = 11
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 454
    Width = 550
    Height = 41
    Align = alBottom
    TabOrder = 4
    object shpRed: TShape
      Left = 11
      Top = 10
      Width = 17
      Height = 17
      Brush.Color = 8421631
      Pen.Style = psClear
    end
    object lblLegNaoPodeEditar: TLabel
      Left = 34
      Top = 11
      Width = 379
      Height = 14
      Caption = 
        'S'#233'ries j'#225' associadas ao Pedido/Or'#231'amento de Venda n'#227'o podem ser ' +
        'alteradas'
      Color = clBlack
      ParentColor = False
    end
  end
end
