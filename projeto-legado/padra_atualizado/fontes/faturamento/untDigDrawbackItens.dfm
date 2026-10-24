inherited frmDigDrawbackItens: TfrmDigDrawbackItens
  Width = 976
  Height = 635
  Caption = 'Digita'#231#227'o do N'#250'mero Drawback dos Itens'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 976
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 559
    Width = 970
    Height = 31
    ExplicitTop = 559
    ExplicitWidth = 970
    ExplicitHeight = 31
    inherited FlwBotoes: TFlowPanel
      Width = 966
      Height = 27
      ExplicitWidth = 966
      ExplicitHeight = 27
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 95
        Height = 25
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnCopiarDrawback: TBitBtnLocked
        Left = 95
        Top = 0
        Width = 248
        Height = 25
        Caption = '[F2]  Copiar Drawback para os demais registros'
        TabOrder = 1
        OnClick = btnCopiarDrawbackClick
      end
      object btnCopiarClaFis: TBitBtnLocked
        Left = 343
        Top = 0
        Width = 248
        Height = 25
        Caption = '[F3]  Copiar CFOP para os demais registros'
        TabOrder = 2
        OnClick = btnCopiarClaFisClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 890
      Top = 6
      ExplicitLeft = 890
      ExplicitTop = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 590
    Width = 970
    ExplicitTop = 590
    ExplicitWidth = 970
    inherited pnlNomeForm: TPanel
      Left = 799
      ExplicitLeft = 799
    end
    inherited pnlInfo: TPanel
      Width = 799
      ExplicitWidth = 799
    end
  end
  object pnlRodape: TPanel [2]
    Left = 0
    Top = 527
    Width = 970
    Height = 32
    Align = alBottom
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 3
    object shpCamObr: TShape
      Left = 8
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = 8454143
      Pen.Mode = pmMask
    end
    object lblCamObr: TLabel
      Left = 29
      Top = 9
      Width = 169
      Height = 14
      Caption = 'Campos obrigat'#243'rios e/ou edit'#225'veis'
    end
  end
  object grdProdutos: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 970
    Height = 527
    Align = alClient
    TabOrder = 2
    object grdProdutosDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdProdutosDBTableViewCustomDrawCell
      DataController.DataSource = dtsProdutos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdProdutosCODITE: TcxGridDBColumn
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 62
      end
      object grdProdutosDESITE: TcxGridDBColumn
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
      end
      object grdProdutosCODUNI: TcxGridDBColumn
        DataBinding.FieldName = 'CODUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 32
      end
      object grdProdutosCLAFIS: TcxGridDBColumn
        DataBinding.FieldName = 'CLAFIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Width = 46
      end
      object grdProdutosCODSIT: TcxGridDBColumn
        Caption = 'CST'
        DataBinding.FieldName = 'CODSIT'
        Options.Editing = False
        Options.Focusing = False
        Width = 40
      end
      object grdProdutosQTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Options.Focusing = False
        Width = 85
      end
      object grdProdutosVLRUNI: TcxGridDBColumn
        DataBinding.FieldName = 'VLRUNI'
        Options.Editing = False
        Options.Focusing = False
        Width = 81
      end
      object grdProdutosVLRTOT: TcxGridDBColumn
        DataBinding.FieldName = 'VLRTOT'
        Options.Editing = False
        Options.Focusing = False
        Width = 73
      end
      object grdProdutosNUMDRW: TcxGridDBColumn
        Caption = 'Drawback'
        DataBinding.FieldName = 'NUMDRW'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 63
      end
    end
    object grdProdutosLevel1: TcxGridLevel
      GridView = grdProdutosDBTableView
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 248
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 72
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsProdutosBeforePost
    Left = 704
    Top = 72
    object cdsProdutosINDICE: TIntegerField
      FieldName = 'INDICE'
    end
    object cdsProdutosCODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsProdutosCODUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'CODUNI'
      Size = 2
    end
    object cdsProdutosAUTINC: TIntegerField
      FieldName = 'AUTINC'
    end
    object cdsProdutosCLAFIS: TStringField
      DisplayLabel = 'CFOP'
      FieldName = 'CLAFIS'
      Size = 4
    end
    object cdsProdutosQTDITE: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Quantidade'
      FieldName = 'QTDITE'
      DisplayFormat = '##0.0000'
      EditFormat = '##0.0000'
    end
    object cdsProdutosVLRUNI: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Vr. Unit'#225'rio'
      FieldName = 'VLRUNI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosVLRTOT: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Vr. Total'
      FieldName = 'VLRTOT'
      EditFormat = '#,##0.00'
    end
    object cdsProdutosNUMDRW: TStringField
      FieldName = 'NUMDRW'
      Size = 11
    end
    object cdsProdutosCODSIT: TStringField
      FieldName = 'CODSIT'
      Size = 5
    end
    object cdsProdutosCSTIPI: TStringField
      FieldName = 'CSTIPI'
      Size = 2
    end
    object cdsProdutosENQIPI: TStringField
      FieldName = 'ENQIPI'
      Size = 3
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 704
    Top = 128
  end
  object imgProduto: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 14680160
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
      end
      item
        Image.Data = {
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
      end>
  end
end
