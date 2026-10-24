object frmInfoExt: TfrmInfoExt
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 117
  ClientWidth = 168
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  StyleElements = [seClient, seBorder]
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object cxGroupBox1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Caption = 'Informa'#231#245'es'
    ParentFont = False
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = [fsBold]
    Style.LookAndFeel.NativeStyle = False
    Style.LookAndFeel.SkinName = 'MoneyTwins'
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.LookAndFeel.SkinName = 'MoneyTwins'
    TabOrder = 0
    DesignSize = (
      168
      111)
    Height = 117
    Width = 168
    object Label1: TLabel
      Left = 14
      Top = 24
      Width = 137
      Height = 13
      Caption = 'Lan'#231'amentos de Cr'#233'dito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      StyleElements = [seClient, seBorder]
    end
    object Label2: TLabel
      Left = 14
      Top = 43
      Width = 133
      Height = 13
      Caption = 'Lan'#231'amentos de D'#233'bito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      StyleElements = [seClient, seBorder]
    end
    object Label3: TLabel
      Left = 14
      Top = 62
      Width = 137
      Height = 13
      Caption = 'Lan'#231'amentos Ignorados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMedGray
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsStrikeOut]
      ParentFont = False
      Transparent = True
      StyleElements = [seClient, seBorder]
    end
    object cxButton5: TcxButton
      Left = 44
      Top = 84
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
  object ApplicationEvents: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 140
  end
  object imglDiversas16: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 524428
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
      end>
  end
end
