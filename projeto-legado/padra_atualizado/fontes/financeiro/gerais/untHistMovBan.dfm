inherited frmHistMovBan: TfrmHistMovBan
  Width = 938
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Relacionamento de hist'#243'ricos - Movimenta'#231#227'o banc'#225'ria'
  Position = poMainFormCenter
  ExplicitWidth = 938
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 3
    Top = 1
    Width = 207
    Height = 13
    Caption = 'Informe o texto que deseja procurar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 932
    TabOrder = 2
    ExplicitTop = 393
    ExplicitWidth = 932
    inherited FlwBotoes: TFlowPanel
      Width = 928
      TabOrder = 2
      ExplicitLeft = -14
      ExplicitTop = -27
      ExplicitWidth = 928
    end
    inherited btnSair: TBitBtnLocked
      Left = 849
      Width = 0
      Height = 0
      ExplicitLeft = 849
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object cxButton5: TcxButton
      Left = 849
      Top = 3
      Width = 79
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&Sair'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'Blue'
      OptionsImage.ImageIndex = 0
      OptionsImage.Images = imglDiversas16
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = cxButton5Click
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 932
    TabOrder = 3
    ExplicitTop = 377
    ExplicitWidth = 932
    inherited pnlNomeForm: TPanel
      Left = 761
      ExplicitLeft = 761
    end
    inherited pnlInfo: TPanel
      Width = 761
      ExplicitLeft = -6
      ExplicitTop = 3
      ExplicitWidth = 761
    end
  end
  object grdHistBan: TcxGrid [3]
    AlignWithMargins = True
    Left = 0
    Top = 40
    Width = 932
    Height = 337
    Margins.Left = 0
    Margins.Top = 40
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = False
    LookAndFeel.ScrollbarMode = sbmClassic
    LookAndFeel.SkinName = 'Blue'
    object grdHistBanDBTableView1: TcxGridDBTableView
      OnDblClick = grdHistBanDBTableView1DblClick
      OnKeyDown = grdHistBanDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FindPanel.ShowCloseButton = False
      OnCustomDrawCell = grdHistBanDBTableView1CustomDrawCell
      DataController.DataSource = dsMovBan
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle3
      Styles.ContentOdd = cxStyle3
      Styles.Header = cxStyle1
      object grdHistBanDBTableView1Column1: TcxGridDBColumn
        Caption = 'Hist'#243'rico'
        DataBinding.FieldName = 'CTB_HIST01'
        Options.Editing = False
        Width = 900
      end
      object grdHistBanDBTableView1Column2: TcxGridDBColumn
        DataBinding.FieldName = 'EXT_CODPOR'
        Visible = False
      end
    end
    object grdHistBanLevel1: TcxGridLevel
      GridView = grdHistBanDBTableView1
    end
  end
  object edtProcura: TEdit [4]
    Left = 3
    Top = 15
    Width = 358
    Height = 20
    CharCase = ecUpperCase
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    OnKeyPress = edtProcuraKeyPress
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 776
    Top = 64
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 776
    Top = 128
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dsMovBan: TDataSource
    Left = 448
    Top = 88
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 504
    Top = 184
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
  end
  object imglDiversas16: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 7274919
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00088C
          C600088CC600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00088CC60094E7
          F7005ADEEF00088CC600088CC600088CC600088CC600088CC600FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00088CC600A5E7
          F7008CFFFF0084FFFF0084F7FF0084F7FF007BF7FF0063DEFF00088CC600088C
          C600006B0800106B0800FF00FF00FF00FF00FF00FF00FF00FF000894CE0042AD
          D6009CFFFF0073F7FF007BF7FF0042B594002194420021944A00299C4A00218C
          4200007B1000008C0800087B1800FF00FF00FF00FF00FF00FF0021A5D60042AD
          D6009CF7F70073F7FF0084FFFF0031945A0029BD4A0029BD4A0021B5420018AD
          420010A5310008A5180000940800006B0000FF00FF00FF00FF0029A5D6005ADE
          EF0042ADD60084FFFF0084FFFF0031945A0031C6520039D6630029BD4A0021B5
          420021B5420010A5310008A51800008C080000520000FF00FF0029A5D6007BEF
          F70042ADD600A5FFFF0073FFFF0042B5940031AD5A0029AD630029AD6300088C
          C60010A5390018B55200089C210010843100088CC600FF00FF0029A5D6008CF7
          F7006BA5B50042ADD60094F7FF0094F7FF0094FFFF008CFFFF0073F7FF0073F7
          FF0018A5310010942900188442007BEFF70021A5D600FF00FF0029A5D60084F7
          F700DEBDAD0042ADD60042ADD60042ADD60042ADD60042ADD6009CF7FF006BEF
          F700087B180031945A0052CEF70084F7FF004ACEEF00FF00FF0029A5D60084F7
          F700D6C6BD00FFFFF700FFE7D600FFE7BD00DED6B5009CBDB50042ADD60094E7
          F70073D6C60094F7FF006BDEFF0094F7FF0084F7FF00189CD60029A5D60084F7
          F700D6C6BD00FFFFFF00FFEFE700F7E7D600F7E7C600FFDEB500B5C6B50042AD
          D60042ADD60042ADD60042ADD60042ADD60042ADD60031A5D60031A5D60084F7
          F700DECEC600FFFFFF00FFFFF700FFEFE700F7E7D600F7E7C600FFDEB500FFD6
          9C0073A5AD005AEFFF00189CD600FF00FF00FF00FF00FF00FF00299CD6009CF7
          F700E7D6C600FFFFFF00FFFFFF00FFFFF700FFEFE700F7E7D600AD736300AD73
          6300AD736300219CD600219CD600FF00FF00FF00FF00FF00FF00FF00FF00299C
          D600EFD6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D6CE00AD736300DE84
          4200BD5A6300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00E7D6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D6DE00AD736300DE8C
          5200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00DEA58400DEA58400DEA58400DEA58400DEA58400DEA58400AD736300FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000A00000010000000090000000200000000000000000000
          00020000000A000000120000000C000000030000000000000000000000000000
          00020000000F0F0742921D0F7EEF0603347A0000000E00000002000000020000
          000F0804347C1D0F7EF00F084194000000120000000200000000000000000000
          0008120B47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703
          357C1F20A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000
          000C281C8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022
          A6FF3A50D3FF3A50D3FF4C5FD4FF291D8CF10000001000000000000000000000
          0006130F3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415A
          D7FF415AD7FF5B72DEFF484AB8FF130F3C790000000900000000000000000000
          00010000000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64
          DBFF6983E3FF5356C0FF16123F780000000C0000000200000000000000000000
          0000000000010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774
          E2FF565CC6FF1916437A0000000D000000020000000000000000000000000000
          00000000000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383
          E7FF3840B6FF0B0839780000000C000000020000000000000000000000000000
          0001000000071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997
          EEFF7796EDFF414ABCFF0E0C3C730000000A0000000100000000000000000000
          00041818456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7
          F8FF83A3F2FF83A1F1FF5058C4FF121040710000000600000000000000000000
          00065759C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868E
          E1FFB5CCF9FF8DACF4FFA1B8F4FF5758C3EF0000000900000000000000000000
          000331326B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527
          526C8B93E6FFC1D3F9FF949EE9FF303168870000000500000000000000000000
          00010000000431336B825E62CBEC1F204D680000000500000001000000010000
          00052728536B5E62CBEC31326883000000070000000100000000000000000000
          0000000000000000000200000004000000020000000100000000000000000000
          0001000000030000000500000004000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
