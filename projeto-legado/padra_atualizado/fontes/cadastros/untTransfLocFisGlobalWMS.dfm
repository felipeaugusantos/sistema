inherited frmTransfLocFisGlobalWMS: TfrmTransfLocFisGlobalWMS
  Width = 844
  Height = 449
  Caption = 'Transfer'#234'ncia Global de Localiza'#231#227'o F'#237'sica'
  OnDestroy = FormDestroy
  ExplicitWidth = 844
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 378
    Width = 838
    TabOrder = 1
    ExplicitTop = 378
    ExplicitWidth = 838
    inherited FlwBotoes: TFlowPanel
      Width = 834
      ExplicitTop = 2
      ExplicitWidth = 834
      inherited btnConfirma: TBitBtnLocked
        Width = 98
        Align = alLeft
        ModalResult = 0
        ExplicitWidth = 98
      end
      object btnExpAut: TBitBtnLocked
        Left = 98
        Top = 0
        Width = 174
        Height = 22
        Align = alLeft
        Caption = '[F7] Confer'#234'ncia "Autom'#225'tica"'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnExpAutClick
      end
      object btnQuantidade: TBitBtnLocked
        Left = 272
        Top = 0
        Width = 155
        Height = 22
        Align = alLeft
        Caption = '[F6] Quantidade'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          CCCCCC6060400000FF0000FF0000C000007C606050CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CCCCCC6060400000FF0000FF0000C000
          007C606050CCCCCCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC5A5A3A0000FF0000FF0000CC000086545444CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C69A9A9A2626068B8B6B5E5E461A
          1A0ADEDEDEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC7E7E7EC5C5C5FFFFFFF9F9F9282828DADADAC0C0C0CCBCBCC6BEBEC0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6828282BBBBBBFFFFFFFFFFFFFFFFFFB6
          B6B6404040D8C8C83CEBEB94CCCCCCBCBCC0C0C0C0C0C0C0C0C0C0C0C0CACACA
          4E4E4EFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2A2A2ADAD2D2A0C8C81CFFFFA0C8
          C8D8B8B8C0C0C0C0C0C0C0C0C0D4D4D45A5A5AFFFFFFDBDBDBFFFFFFFFFFFFFF
          FFFF5454549A8A8A4CEBEB86EDED00FFFF18F7F7E4B4B4C0C0C0CCCCCC303030
          FFFFFFFFFFFF787878FFFFFFFFFFFFFFFFFFCECECE484040A6D6D674F3F346FF
          FF00FFFF18F7F7D2CACAD4D4D48080807070704C4C4CF5F5F5FFFFFFFFFFFFFF
          FFFFC4C4C45444445AF1F164DBDB7CD3D300FFFF00FFFFDB0C0C4848484A4A4A
          949494787878CBCBCBFFFFFFC3C3C3383838D8D8D854444460EFEF22F1F100FF
          FF00FFFF00FFFFAC9C9CCCCCCCCCCCCCCECECE808080181818D0D0D078787824
          2424DCDCDC4E4646A6D6D680EFEF4CFFFF00FFFFA8C8C8CAC2C2C0C0C0C0C0C0
          C8C8C8808080282828D8D8D8808080282828E8E8E848383858EFEF32FFFF0EF5
          F5A2CACACCBCBCC0C0C0C0C0C0C0C0C0C8C8C88282822C2C2CD8D8D888888832
          3232404040DED6D69ACACA5EFDFDDCB4B4C6BEBEC0C0C0C0C0C0C0C0C0C0C0C0
          CACACA646464000000F0F0F0161616383838DADADACCBCBC36EDEDD6B6B6C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CACACAE0E0E03C3C3CDCDCDCCE
          CECEC0C0C0C0C0C0CCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        TabOrder = 2
        OnClick = btnQuantidadeClick
      end
      object btnNovLocFis: TBitBtnLocked
        Left = 427
        Top = 0
        Width = 155
        Height = 22
        Align = alLeft
        Caption = '[F8] Nova Localiza'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000000F00000010000000100000
          00100000001100000011000000100000000B0000000300000000000000000000
          0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
          BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
          000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
          E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
          000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
          C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
          000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
          E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
          000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
          77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
          000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
          4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
          00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
          9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
          00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
          B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
          00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
          C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
          0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
          6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
          0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
          D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
          00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
          A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
          00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
          AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
          00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
          64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
          00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
          1B44000000060000000600000006000000040000000100000000}
        TabOrder = 3
        OnClick = btnNovLocFisClick
      end
      object btnLimpaConf: TBitBtnLocked
        Left = 582
        Top = 0
        Width = 155
        Height = 22
        Align = alLeft
        Caption = '[F9] Limpar confer'#234'ncia'
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
        TabOrder = 4
        OnClick = btnLimpaConfClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 749
      Top = 2
      Width = 87
      ExplicitLeft = 749
      ExplicitTop = 2
      ExplicitWidth = 87
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 838
    TabOrder = 2
    ExplicitTop = 404
    ExplicitWidth = 838
    inherited pnlNomeForm: TPanel
      Left = 636
      Width = 202
      ExplicitLeft = 636
      ExplicitWidth = 202
    end
    inherited pnlInfo: TPanel
      Width = 636
      ExplicitWidth = 636
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 838
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblLocFis: TLabel
      Left = 8
      Top = 8
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object edtLocFis: TEditFocus
      Tag = 99
      Left = 102
      Top = 5
      Width = 134
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 0
      OnKeyPress = edtLocFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgDados: TcxGridCitel [4]
    Left = 0
    Top = 32
    Width = 838
    Height = 319
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDadosTableViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHiding = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object ColumnCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 50
      end
      object ColumnDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 187
      end
      object ColumnNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Width = 68
      end
      object ColumnDESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Options.Editing = False
        Options.Focusing = False
        Width = 102
      end
      object ColumnSIGUNI: TcxGridDBColumn
        Caption = 'UN.'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 36
      end
      object ColumnDTAVAL: TcxGridDBColumn
        Caption = 'Validade'
        DataBinding.FieldName = 'DTAVAL'
        Options.Editing = False
        Options.Focusing = False
        Width = 67
      end
      object ColumnSALATU: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'SALATU'
        Options.Editing = False
        Options.Focusing = False
        Width = 63
      end
      object ColumnLOCNOV: TcxGridDBColumn
        Caption = 'Nova Localiza'#231#227'o'
        DataBinding.FieldName = 'LOCNOV'
        Options.Editing = False
        Options.Focusing = False
        Width = 157
      end
      object ColumnSALNOV: TcxGridDBColumn
        Caption = 'Qtde. Transf.'
        DataBinding.FieldName = 'SALNOV'
        Options.Editing = False
        Options.Focusing = False
        Width = 91
      end
    end
    object cxgDadosLevel: TcxGridLevel
      GridView = cxgDadosTableView
    end
  end
  object pnlRodape: TPanel [5]
    Left = 0
    Top = 351
    Width = 838
    Height = 27
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object lblCodBar: TLabel
      Left = 6
      Top = 6
      Width = 152
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de Barras (Embalagem):'
    end
    object lblQtde: TLabel
      Left = 291
      Top = 6
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 158
      Top = 2
      Width = 130
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 350
      Top = 2
      Width = 73
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      Text = '1,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 740
    Top = 340
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 716
    Top = 340
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 692
    Top = 340
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42089.714725266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 368
    Top = 256
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDataset
        DataSetName = 'frxDBDataset'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 718.488179210000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 52.913420000000000000
          Width = 166.299320000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 222.992270000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."NUMLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 302.362400000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 400.630180000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."SIGUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 430.866420000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."LOCATU"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 535.913730000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset."LOCNOV"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 648.299630000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset."SALNOV"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 363.363760000000000000
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 717.732056460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo1: TfrxMemoView
          Left = 52.913420000000000000
          Width = 166.299320000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
        object Memo2: TfrxMemoView
          Left = 302.362400000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'MARCA')
        end
        object Memo3: TfrxMemoView
          Left = 400.630180000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'UN')
        end
        object Memo4: TfrxMemoView
          Left = 222.992270000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'LOTE')
        end
        object Memo5: TfrxMemoView
          Left = 430.866420000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'LOC. ORIGEM')
        end
        object Memo6: TfrxMemoView
          Left = 535.913730000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'LOC. DESTINO')
        end
        object Memo7: TfrxMemoView
          Left = 648.299630000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. MOV.')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 73.645640000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 1.881879999999999000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 189.845950000000000000
          Top = 18.881880000000000000
          Width = 338.418800000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'TRANSFER'#202'NCIA DE LOCALIZA'#199#195'O F'#205'SICA')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 599.584230000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 647.584230000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 553.020470000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 69.811070000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 464
    Top = 240
  end
end
