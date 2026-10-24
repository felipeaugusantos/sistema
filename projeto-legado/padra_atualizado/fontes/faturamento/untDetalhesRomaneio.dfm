inherited frmDetalhesRomaneio: TfrmDetalhesRomaneio
  Width = 649
  Height = 677
  Caption = 'Detalhes Romaneio'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 649
  ExplicitHeight = 677
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 604
    Width = 643
    ExplicitTop = 465
    ExplicitWidth = 643
    inherited FlwBotoes: TFlowPanel
      Width = 639
      ExplicitWidth = 639
    end
  end
  inherited pnlStatus: TPanel
    Top = 632
    Width = 643
    ExplicitTop = 493
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 472
      ExplicitLeft = 472
    end
    inherited pnlInfo: TPanel
      Width = 472
      ExplicitWidth = 472
    end
  end
  inherited pgcDados: TPageControl
    Width = 643
    Height = 604
    ExplicitWidth = 643
    ExplicitHeight = 465
    inherited tbsGeral: TTabSheet
      Caption = 'Detalhes da Entrega'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 635
      ExplicitHeight = 433
      object lblOcorrencias: TLabel
        Left = 0
        Top = 0
        Width = 635
        Height = 14
        Align = alTop
        Caption = 'Ocorr'#234'ncias'
        ExplicitWidth = 60
      end
      object lblMensag: TLabel
        Left = 0
        Top = 433
        Width = 635
        Height = 14
        Align = alTop
        Caption = 'Observa'#231#227'o da baixa do romaneio'
        ExplicitWidth = 166
      end
      object Label1: TLabel
        Left = 0
        Top = 297
        Width = 635
        Height = 14
        Align = alTop
        Caption = 'Mensagem adicional'
        ExplicitWidth = 97
      end
      object cxgRomMsg: TcxGridCitel
        Left = 0
        Top = 14
        Width = 635
        Height = 283
        Align = alTop
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgRomMsgDBTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsRomMsg
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
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgRomMsgOCR_TIPOCR: TcxGridDBColumn
            DataBinding.FieldName = 'OCR_TIPOCR'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.Images = cxImageListMsg
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 'S'
              end
              item
                ImageIndex = 1
                Value = 'N'
              end>
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 24
            IsCaptionAssigned = True
          end
          object cxgRomMsgOCR_CODIGO: TcxGridDBColumn
            Caption = 'C'#243'd. Ocorr.'
            DataBinding.FieldName = 'OCR_CODIGO'
            Width = 65
          end
          object cxgRomMsgOCR_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Ocorr'#234'ncia'
            DataBinding.FieldName = 'OCR_DESCRI'
            Options.Editing = False
            Width = 388
          end
          object cxgRomMsgMSG_DTAOCO: TcxGridDBColumn
            Caption = 'Data Ocorr.'
            DataBinding.FieldName = 'MSG_DTAOCO'
            Options.Editing = False
            Width = 74
          end
          object cxgRomMsgMSG_HOROCO: TcxGridDBColumn
            Caption = 'Hora Ocorr.'
            DataBinding.FieldName = 'MSG_HOROCO'
          end
        end
        object cxgRomMsgLevel: TcxGridLevel
          GridView = cxgRomMsgDBTableView
        end
      end
      object mmoMensag: TMemoFocus
        Left = 0
        Top = 311
        Width = 635
        Height = 122
        Align = alTop
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
        ExplicitTop = 305
      end
      object mmoObserv: TMemoFocus
        Left = 0
        Top = 450
        Width = 635
        Height = 122
        Align = alBottom
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
        ExplicitTop = 311
      end
    end
    object tbsFotos: TTabSheet
      Caption = 'Fotos'
      ImageIndex = 1
      ExplicitHeight = 433
      object imgFotoFot: TImage
        Left = 161
        Top = 0
        Width = 474
        Height = 572
        Align = alClient
        Center = True
        Stretch = True
        Visible = False
        ExplicitLeft = 167
        ExplicitTop = 16
        ExplicitWidth = 462
        ExplicitHeight = 462
      end
      object cxgAlbumFot: TcxGrid
        Left = 0
        Top = 0
        Width = 161
        Height = 572
        Align = alLeft
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 433
        object cxgAlbumFotDBLayoutView: TcxGridDBLayoutView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsAlbumFot
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ScrollBars = ssVertical
          OptionsView.CarouselMode.AnimationInterval = 1
          OptionsView.CarouselMode.AutoPitchAngle = True
          OptionsView.CarouselMode.RollAngle = 90.000000000000000000
          OptionsView.ItemPadding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
          OptionsView.ItemPadding.Bottom = 0
          OptionsView.ItemPadding.Left = 0
          OptionsView.ItemPadding.Right = 0
          OptionsView.ItemPadding.Top = 0
          OptionsView.RecordCaption.DisplayMask = 'Produtos em Combo de Venda [RecordIndex] de [RecordCount]'
          OptionsView.RecordCaption.Visible = False
          OptionsView.ViewMode = lvvmSingleColumn
          object cxgAlbumFotDBLayoutViewItem1: TcxGridDBLayoutViewItem
            DataBinding.FieldName = 'IMAGEM'
            PropertiesClassName = 'TcxImageProperties'
            Properties.FitMode = ifmProportionalStretch
            Properties.GraphicClassName = 'TdxSmartImage'
            LayoutItem = cxGridLayoutItem1
            Options.Editing = False
            Options.Focusing = False
            IsCaptionAssigned = True
          end
          object cxgAlbumFotDBLayoutViewGroup_Root: TdxLayoutGroup
            AlignHorz = ahLeft
            AlignVert = avTop
            CaptionOptions.Text = 'Template Card'
            ButtonOptions.Buttons = <>
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            Index = -1
          end
          object cxGridLayoutItem1: TcxGridLayoutItem
            Parent = cxgAlbumFotDBLayoutViewGroup_Root
            AlignHorz = ahCenter
            AlignVert = avCenter
            CaptionOptions.Visible = False
            SizeOptions.Height = 80
            SizeOptions.Width = 80
            Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
            Index = 0
          end
          object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
            Parent = cxgAlbumFotDBLayoutViewGroup_Root
            AlignHorz = ahLeft
            Index = 1
            AutoCreated = True
          end
        end
        object cxgAlbumFotLevel1: TcxGridLevel
          GridView = cxgAlbumFotDBLayoutView
        end
      end
    end
    object tbsAssinatura: TTabSheet
      Caption = 'Assinatura'
      ImageIndex = 2
      ExplicitHeight = 433
      object imgFotoAss: TImage
        Left = 161
        Top = 0
        Width = 474
        Height = 572
        Align = alClient
        Center = True
        Stretch = True
        Visible = False
        ExplicitLeft = 167
        ExplicitTop = 16
        ExplicitWidth = 462
        ExplicitHeight = 462
      end
      object cxgAlbumAss: TcxGrid
        Left = 0
        Top = 0
        Width = 161
        Height = 572
        Align = alLeft
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 433
        object cxGridDBLayoutView1: TcxGridDBLayoutView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsAlbumAss
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ScrollBars = ssVertical
          OptionsView.CarouselMode.AnimationInterval = 1
          OptionsView.CarouselMode.AutoPitchAngle = True
          OptionsView.CarouselMode.RollAngle = 90.000000000000000000
          OptionsView.ItemPadding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
          OptionsView.ItemPadding.Bottom = 0
          OptionsView.ItemPadding.Left = 0
          OptionsView.ItemPadding.Right = 0
          OptionsView.ItemPadding.Top = 0
          OptionsView.RecordCaption.DisplayMask = 'Produtos em Combo de Venda [RecordIndex] de [RecordCount]'
          OptionsView.RecordCaption.Visible = False
          OptionsView.ViewMode = lvvmSingleColumn
          object cxGridDBLayoutViewItem1: TcxGridDBLayoutViewItem
            DataBinding.FieldName = 'IMAGEM'
            PropertiesClassName = 'TcxImageProperties'
            Properties.FitMode = ifmProportionalStretch
            Properties.GraphicClassName = 'TdxSmartImage'
            LayoutItem = cxGridLayoutItem2
            Options.Editing = False
            Options.Focusing = False
            IsCaptionAssigned = True
          end
          object dxLayoutGroup1: TdxLayoutGroup
            AlignHorz = ahLeft
            AlignVert = avTop
            CaptionOptions.Text = 'Template Card'
            ButtonOptions.Buttons = <>
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            Index = -1
          end
          object cxGridLayoutItem2: TcxGridLayoutItem
            Parent = dxLayoutGroup1
            AlignHorz = ahCenter
            AlignVert = avCenter
            CaptionOptions.Visible = False
            SizeOptions.Height = 80
            SizeOptions.Width = 80
            Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
            Index = 0
          end
          object dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup
            Parent = dxLayoutGroup1
            AlignHorz = ahLeft
            Index = 1
            AutoCreated = True
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBLayoutView1
        end
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 604
    Width = 643
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 465
    DesignSize = (
      643
      28)
    object FlowPanel1: TFlowPanel
      Left = 2
      Top = 2
      Width = 639
      Height = 24
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 563
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 332
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 65508
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 12
  end
  object dtsAlbumFot: TDataSource
    Left = 488
  end
  object dtsAlbumAss: TDataSource
    Left = 540
    Top = 65528
  end
  object dtsRomMsg: TDataSource
    Left = 400
    Top = 65532
  end
  object cxImageListMsg: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 11796936
    ImageInfo = <
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
      end
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
      end>
  end
end
