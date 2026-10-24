object frmBannerProdutos: TfrmBannerProdutos
  Left = 0
  Top = 0
  Caption = 'Banner de Produtos'
  ClientHeight = 599
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 759
    Height = 599
    Align = alClient
    TabOrder = 0
    object cxGrid1DBLayoutView1: TcxGridDBLayoutView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsCadPro
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ViewMode = lvvmSingleColumn
      object cxGrid1DBLayoutView1Item1: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'IMAGEM'
        PropertiesClassName = 'TcxImageProperties'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TJPEGImage'
        LayoutItem = cxGridLayoutItem1
        Options.Editing = False
        Options.Focusing = False
        IsCaptionAssigned = True
      end
      object cxGrid1DBLayoutView1Item2: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'DESITE'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.WordWrap = True
        LayoutItem = cxGrid1DBLayoutView1LayoutItem2
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        IsCaptionAssigned = True
      end
      object cxGrid1DBLayoutView1Item3: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'PREVEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        LayoutItem = cxGrid1DBLayoutView1LayoutItem3
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        IsCaptionAssigned = True
      end
      object cxGrid1DBLayoutView1Group_Root: TdxLayoutGroup
        AlignHorz = ahLeft
        AlignVert = avTop
        CaptionOptions.Text = 'Template Card'
        ButtonOptions.Buttons = <>
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        Index = -1
      end
      object cxGrid1DBLayoutView1LayoutItem2: TcxGridLayoutItem
        Parent = dxLayoutAutoCreatedGroup1
        AlignHorz = ahLeft
        AlignVert = avTop
        CaptionOptions.Visible = False
        SizeOptions.Height = 84
        SizeOptions.Width = 200
        Padding.AssignedValues = [lpavLeft, lpavRight]
        Index = 0
      end
      object cxGrid1DBLayoutView1LayoutItem3: TcxGridLayoutItem
        Parent = dxLayoutAutoCreatedGroup1
        AlignHorz = ahClient
        AlignVert = avClient
        CaptionOptions.Visible = False
        SizeOptions.Width = 199
        Index = 1
      end
      object cxGridLayoutItem1: TcxGridLayoutItem
        Parent = cxGrid1DBLayoutView1Group_Root
        AlignHorz = ahLeft
        AlignVert = avTop
        CaptionOptions.Visible = False
        SizeOptions.Height = 119
        Index = 0
      end
      object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
        Parent = cxGrid1DBLayoutView1Group_Root
        AlignHorz = ahLeft
        Index = 1
        AutoCreated = True
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBLayoutView1
    end
  end
  object dtsCadPro: TDataSource
    Left = 200
    Top = 280
  end
end
