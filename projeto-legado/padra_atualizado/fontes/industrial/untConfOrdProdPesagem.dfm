inherited frmConfOrdProdPesagem: TfrmConfOrdProdPesagem
  Width = 703
  Height = 681
  BorderIcons = [biSystemMenu]
  Caption = 'Confer'#234'ncia de Ordem de Produ'#231#227'o - Pesagem'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 703
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 14
  object lblLimparQtde: TLabel [0]
    Left = 0
    Top = 593
    Width = 697
    Height = 16
    Align = alBottom
    Alignment = taCenter
    Caption = 'Pressione a tecla [F5] para limpar a quantidade do item'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 440
  end
  inherited pnlBotoes: TPanel
    Top = 609
    Width = 697
    ExplicitTop = 609
    ExplicitWidth = 697
    inherited btnSair: TBitBtnLocked
      Left = 614
      ExplicitLeft = 614
    end
    object btnConfirmar: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 120
      Height = 22
      Caption = '[ F10 ] Confirma'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000002000000070000000C0000001000000012000000110000
        000E000000080000000200000000000000000000000000000000000000000000
        000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
        3AD20F2F21840001011500000005000000010000000000000000000000000000
        0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
        80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
        0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
        96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
        3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
        99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
        66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
        A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
        8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
        A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
        A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
        4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
        B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
        8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
        BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
        E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
        B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
        76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
        7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
        7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
        46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
        C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
        0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
        DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
        0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
        C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
        000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
        56B00E3226560000000600000002000000000000000000000000}
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
    object btnLimparPesagem: TBitBtnLocked
      Left = 131
      Top = 3
      Width = 150
      Height = 22
      Caption = '[ F11 ] Limpar pesagem'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00020000000900000012000000180000001A0000001A00000018000000100000
        0005000000010000000000000000000000000000000000000000000000020000
        000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
        022800000006000000010000000000000000000000000000000000000008442F
        1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
        2AD80302042A00000006000000010000000000000000000000000000000DB07D
        4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
        7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
        329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
        CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
        000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
        CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
        00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
        D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
        0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
        F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
        000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
        F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
        000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
        F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
        00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
        F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
        000000000000000000000000000000000000000000010000000736457A9FD8F0
        FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
        0000000000000000000000000000000000000000000000000001000000063947
        7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        00053543728E4F63AACD151A2D40000000040000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0001000000030000000400000002000000000000000000000000}
      TabOrder = 2
      OnClick = btnLimparPesagemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 637
    Width = 697
    ExplicitTop = 637
    ExplicitWidth = 697
    inherited pnlNomeForm: TPanel
      Left = 526
      ExplicitLeft = 526
    end
    inherited pnlInfo: TPanel
      Width = 526
      ExplicitWidth = 526
    end
  end
  object grdOrdDet: TcxGridCitel [4]
    Left = 0
    Top = 0
    Width = 697
    Height = 525
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdOrdDetDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdOrdDetDadosCustomDrawCell
      DataController.DataSource = dtsOrdDet
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdOrdDetDadosORD_CODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'ORD_CODITE'
        MinWidth = 75
        Width = 75
      end
      object grdOrdDetDadosORD_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Item'
        DataBinding.FieldName = 'ORD_DESITE'
        MinWidth = 200
        Width = 200
      end
      object grdOrdDetDadosORD_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ORD_REFERE'
        MinWidth = 75
        Width = 75
      end
      object grdOrdDetDadosORD_PESOLI: TcxGridDBColumn
        Caption = 'Qtde. (KG)'
        DataBinding.FieldName = 'ORD_PESOLI'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 75
        Width = 75
      end
      object grdOrdDetDadosORD_QTDECF: TcxGridDBColumn
        Caption = 'Pesagem (KG)'
        DataBinding.FieldName = 'ORD_QTDECF'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 90
        Width = 90
      end
    end
    object grdOrdDetLevel1: TcxGridLevel
      GridView = grdOrdDetDados
    end
  end
  object pnlConferencia: TPanel [5]
    Left = 0
    Top = 525
    Width = 697
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object lblCodBar: TLabel
      Left = 6
      Top = 4
      Width = 149
      Height = 14
      Caption = 'C'#243'digo de Barras (Embalagem)'
    end
    object lblQtdIte: TLabel
      Left = 178
      Top = 4
      Width = 70
      Height = 14
      Caption = 'Pesagem (KG)'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 6
      Top = 19
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 13
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
    object edtQtdIte: TCurrencyEditFocus
      Tag = 99
      Left = 178
      Top = 19
      EditValue = 0.000000000000000000
      Properties.DecimalPlaces = 3
      Properties.DisplayFormat = '0.000;-0.000'
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 121
    end
  end
  object pnlLegenda: TPanel [6]
    Left = 0
    Top = 573
    Width = 697
    Height = 20
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object lblPesTot: TLabel
      Left = 326
      Top = 3
      Width = 69
      Height = 14
      Caption = 'Pesagem Total'
    end
    object shpPesTot: TShape
      Left = 296
      Top = 3
      Width = 25
      Height = 14
      Brush.Color = 9883559
    end
    object lblPesPar: TLabel
      Left = 454
      Top = 3
      Width = 79
      Height = 14
      Caption = 'Pesagem Parcial'
    end
    object shpPesPar: TShape
      Left = 424
      Top = 3
      Width = 25
      Height = 14
      Brush.Color = 13434879
    end
    object shpPesoLimite: TShape
      Left = 552
      Top = 3
      Width = 25
      Height = 14
      Brush.Color = clSkyBlue
    end
    object lblPesoLimite: TLabel
      Left = 582
      Top = 3
      Width = 109
      Height = 14
      Caption = 'Pesagem Dentro Limite'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 496
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 760
    Top = 432
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 688
    Top = 456
  end
  object dtsOrdDet: TDataSource
    Left = 368
    Top = 88
  end
end
