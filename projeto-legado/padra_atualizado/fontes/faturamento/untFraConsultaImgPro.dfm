object fraConsultaImgPro: TfraConsultaImgPro
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlImgPro: TPanel
    Left = 0
    Top = 0
    Width = 144
    Height = 101
    BevelInner = bvLowered
    BorderWidth = 2
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object imgPro: TImage
      Left = 4
      Top = 4
      Width = 132
      Height = 89
      Align = alClient
      Center = True
      IncrementalDisplay = True
      Proportional = True
      Stretch = True
    end
    object lblErrImg: TLabel
      Left = 4
      Top = 4
      Width = 132
      Height = 89
      Align = alClient
      Alignment = taCenter
      Caption = 
        'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
        'to do arquivo!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      Visible = False
      WordWrap = True
      ExplicitWidth = 335
      ExplicitHeight = 12
    end
  end
end
