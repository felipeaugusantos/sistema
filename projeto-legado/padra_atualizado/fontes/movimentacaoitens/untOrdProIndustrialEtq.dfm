inherited frmOrdProIndustrialEtq: TfrmOrdProIndustrialEtq
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Impress'#227'o de Etiquetas'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 503
    Width = 1008
    Height = 42
    ExplicitTop = 503
    ExplicitWidth = 1008
    ExplicitHeight = 42
    DesignSize = (
      1008
      42)
    object Shape1: TShape [0]
      Left = 6
      Top = 4
      Width = 10
      Height = 10
      Brush.Color = 16759413
    end
    object Label5: TLabel [1]
      Left = 20
      Top = 2
      Width = 130
      Height = 14
      Caption = 'Registros j'#225' impressos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape2: TShape [2]
      Left = 162
      Top = 4
      Width = 10
      Height = 10
      Brush.Color = clMoneyGreen
    end
    object Label6: TLabel [3]
      Left = 176
      Top = 2
      Width = 202
      Height = 14
      Caption = 'Registros marcados para impress'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Top = 17
      Width = 1004
      Height = 23
      Align = alBottom
      ExplicitTop = 17
      ExplicitWidth = 1004
      ExplicitHeight = 23
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 93
        Height = 22
        Caption = '&Imprime'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
        ParentFont = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 93
        Top = 0
        Width = 151
        Height = 22
        Caption = '[ F5 ] Marca/Desmarca'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 244
        Top = 0
        Width = 122
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 366
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnDesmarcaTodosClick
      end
      object btnCfgLay: TBitBtnLocked
        Left = 507
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F8 ] Configura Layout'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
          1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
          1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
          193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
          11155557F755F777777555000755033305555577755F75F77F55555555503335
          0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
          05555757F75F75557F5505000333555505557F777FF755557F55000000355557
          07557777777F55557F5555000005555707555577777FF5557F55553000075557
          0755557F7777FFF5755555335000005555555577577777555555}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnCfgLayClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 17
      Anchors = [akTop, akRight]
      ExplicitLeft = 929
      ExplicitTop = 17
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object pnlFiltro: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 49
    Align = alTop
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 34
      Top = 21
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Lote:'
    end
    object mskNumLot: TMaskEditFocus
      Tag = 99
      Left = 115
      Top = 14
      Width = 67
      Height = 22
      EditMask = '999999-999;0;_'
      MaxLength = 10
      TabOrder = 0
      Text = ''
      OnExit = mskNumLotExit
      OnKeyPress = mskNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 123
    Width = 1008
    Height = 368
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 55
      end
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'Produto Acabado'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Width = 259
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Width = 47
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'C'#243'digo de Barras'
        DataBinding.FieldName = 'CODBAR'
        Options.Editing = False
        Width = 122
      end
      object cxgItensDTAVAL: TcxGridDBColumn
        Caption = 'Val. Produ'#231#227'o'
        DataBinding.FieldName = 'DTAVAL'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = '!99/0000;1;_'
        Properties.OnValidate = cxgItensDTAVALPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 73
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Val. Item'
        DataBinding.FieldName = 'VALITE'
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Peso / Volume'
        DataBinding.FieldName = 'PESLIT'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 81
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Qtde. Produz.'
        DataBinding.FieldName = 'QTDPRO'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 76
      end
      object cxgItensQTDETI: TcxGridDBColumn
        Caption = 'Qtde.Etiquetas'
        DataBinding.FieldName = 'QTDETI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '0'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Options.Editing = False
      end
      object cxgItensIMPETI: TcxGridDBColumn
        DataBinding.FieldName = 'IMPETI'
        Visible = False
        Options.Editing = False
      end
      object cxgItensDESFAB: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Fabricante'
        DataBinding.FieldName = 'DESFAB'
        Options.Editing = False
        Width = 193
      end
      object cxgItensViewOBSOPI: TcxGridDBColumn
        Caption = 'Observa'#231#227'o'
        DataBinding.FieldName = 'OBSOPI'
        Width = 194
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 49
    Width = 1008
    Height = 74
    Align = alTop
    BevelOuter = bvLowered
    Enabled = False
    ParentColor = True
    TabOrder = 4
    object Label2: TLabel
      Left = 73
      Top = 21
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label3: TLabel
      Left = 14
      Top = 45
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem de Produ'#231#227'o:'
    end
    object Label4: TLabel
      Left = 497
      Top = 45
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Volume:'
    end
    object dbeCodIte: TDBEditFocus
      Left = 115
      Top = 13
      Width = 50
      Height = 22
      Color = 16768952
      DataField = 'CODITE'
      DataSource = dtsGranel
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodOrd: TDBEditFocus
      Left = 115
      Top = 37
      Width = 50
      Height = 22
      Color = 16768952
      DataField = 'CODORD'
      DataSource = dtsGranel
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 166
      Top = 13
      Width = 453
      Height = 22
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsGranel
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Left = 166
      Top = 37
      Width = 71
      Height = 22
      Color = 16768952
      DataField = 'DTACAD'
      DataSource = dtsGranel
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVolume: TDBEditFocus
      Left = 538
      Top = 37
      Width = 81
      Height = 22
      Color = 16768952
      DataField = 'VOLTOT'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object prgProgresso: TProgressBar [5]
    Left = 0
    Top = 491
    Width = 1008
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 5
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 316
    Top = 8
  end
  object dtsGranel: TDataSource
    Left = 632
    Top = 64
  end
end
