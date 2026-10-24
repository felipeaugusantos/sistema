object frmPnlBanner: TfrmPnlBanner
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmPnlBanner'
  ClientHeight = 779
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBanner: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 779
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    Visible = False
    object pnlComVen: TPanel
      Left = 1
      Top = 1
      Width = 283
      Height = 200
      Align = alTop
      Caption = 'pnlComVen'
      Color = 16770261
      Locked = True
      ParentBackground = False
      TabOrder = 0
      Visible = False
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 281
        Height = 198
        ActivePage = tbsComVen
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object tbsComVen: TTabSheet
          Caption = 'Produtos em Combo de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          object cxgComVen: TcxGrid
            Left = 0
            Top = 0
            Width = 273
            Height = 170
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgComVenDBLayoutView: TcxGridDBLayoutView
              Navigator.Buttons.CustomButtons = <>
              OnCellClick = cxgComVenDBLayoutViewCellClick
              DataController.DataSource = dtsComVen
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.CellEndEllipsis = True
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
              Styles.Background = cxStyle1
              object cxgComVenDBLayoutViewItem1: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'IMAGEM'
                PropertiesClassName = 'TcxImageProperties'
                Properties.FitMode = ifmProportionalStretch
                Properties.GraphicClassName = 'TdxSmartImage'
                LayoutItem = cxGridLayoutItem1
                Options.Editing = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxgComVenDBLayoutViewItem2: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'DESITE'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.WordWrap = True
                LayoutItem = cxgComVenDBLayoutViewLayoutItem2
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxgComVenDBLayoutViewItem3: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'PREVEN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                LayoutItem = cxgComVenDBLayoutViewLayoutItem3
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxgComVenDBLayoutViewGroup_Root: TdxLayoutGroup
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Text = 'Template Card'
                ButtonOptions.Buttons = <>
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                Index = -1
              end
              object cxgComVenDBLayoutViewLayoutItem2: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup1
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 44
                SizeOptions.Width = 143
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object cxgComVenDBLayoutViewLayoutItem3: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup1
                AlignHorz = ahClient
                AlignVert = avClient
                CaptionOptions.Visible = False
                SizeOptions.Width = 111
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 1
              end
              object cxGridLayoutItem1: TcxGridLayoutItem
                Parent = cxgComVenDBLayoutViewGroup_Root
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 65
                SizeOptions.Width = 58
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
                Parent = cxgComVenDBLayoutViewGroup_Root
                AlignHorz = ahLeft
                Index = 1
                AutoCreated = True
              end
            end
            object cxgComVenLevel1: TcxGridLevel
              GridView = cxgComVenDBLayoutView
            end
          end
        end
      end
      object chkAniCom: TCheckBox
        Left = 190
        Top = 3
        Width = 83
        Height = 17
        Caption = 'Efeito Aut.'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object pnlPromoc: TPanel
      Left = 1
      Top = 209
      Width = 283
      Height = 195
      Align = alTop
      Color = 16770261
      Locked = True
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object PageControl2: TPageControl
        Left = 1
        Top = 1
        Width = 281
        Height = 193
        ActivePage = TabSheet1
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Produtos em Promo'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          object cxGrid1: TcxGrid
            Left = 0
            Top = 0
            Width = 273
            Height = 165
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgPromocDBLayoutView: TcxGridDBLayoutView
              Navigator.Buttons.CustomButtons = <>
              OnCellClick = cxgPromocDBLayoutViewCellClick
              DataController.DataSource = dtsPromoc
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.CellEndEllipsis = True
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
              Styles.Background = cxStyle1
              object cxGridDBLayoutViewItem1: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'IMAGEM'
                PropertiesClassName = 'TcxImageProperties'
                Properties.FitMode = ifmProportionalStretch
                Properties.GraphicClassName = 'TdxSmartImage'
                LayoutItem = cxGridLayoutItem4
                Options.Editing = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem2: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'DESITE'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.WordWrap = True
                LayoutItem = cxGridLayoutItem2
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem3: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'PREVEN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                LayoutItem = cxGridLayoutItem3
                Options.Editing = False
                Options.Filtering = False
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
                Parent = dxLayoutAutoCreatedGroup2
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 44
                SizeOptions.Width = 143
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object cxGridLayoutItem3: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup2
                AlignHorz = ahClient
                AlignVert = avClient
                CaptionOptions.Visible = False
                SizeOptions.Width = 111
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 1
              end
              object cxGridLayoutItem4: TcxGridLayoutItem
                Parent = dxLayoutGroup1
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 65
                SizeOptions.Width = 58
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
              GridView = cxgPromocDBLayoutView
            end
          end
        end
      end
      object chkAniPro: TCheckBox
        Left = 190
        Top = 3
        Width = 83
        Height = 17
        Caption = 'Efeito Aut.'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object pnlEstrut: TPanel
      Left = 1
      Top = 412
      Width = 283
      Height = 167
      Align = alTop
      Color = 16770261
      Locked = True
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object PageControl3: TPageControl
        Left = 1
        Top = 1
        Width = 281
        Height = 165
        ActivePage = TabSheet2
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object TabSheet2: TTabSheet
          Caption = 'Produtos em Estruturas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          object cxGrid2: TcxGrid
            Left = 0
            Top = 0
            Width = 273
            Height = 137
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgEstrutDBLayoutView: TcxGridDBLayoutView
              Navigator.Buttons.CustomButtons = <>
              OnCellClick = cxgEstrutDBLayoutViewCellClick
              DataController.DataSource = dtsEstrut
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.CellEndEllipsis = True
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
              Styles.Background = cxStyle1
              object cxGridDBLayoutViewItem4: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'IMAGEM'
                PropertiesClassName = 'TcxImageProperties'
                Properties.FitMode = ifmProportionalStretch
                Properties.GraphicClassName = 'TdxSmartImage'
                LayoutItem = cxGridLayoutItem7
                Options.Editing = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem5: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'DESITE'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.WordWrap = True
                LayoutItem = cxGridLayoutItem5
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem6: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'PREVEN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                LayoutItem = cxGridLayoutItem6
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object dxLayoutGroup2: TdxLayoutGroup
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Text = 'Template Card'
                ButtonOptions.Buttons = <>
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                Index = -1
              end
              object cxGridLayoutItem5: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup3
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 44
                SizeOptions.Width = 143
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object cxGridLayoutItem6: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup3
                AlignHorz = ahClient
                AlignVert = avClient
                CaptionOptions.Visible = False
                SizeOptions.Width = 111
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 1
              end
              object cxGridLayoutItem7: TcxGridLayoutItem
                Parent = dxLayoutGroup2
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 65
                SizeOptions.Width = 58
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object dxLayoutAutoCreatedGroup3: TdxLayoutAutoCreatedGroup
                Parent = dxLayoutGroup2
                AlignHorz = ahLeft
                Index = 1
                AutoCreated = True
              end
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxgEstrutDBLayoutView
            end
          end
        end
      end
      object chkAniEst: TCheckBox
        Left = 190
        Top = 2
        Width = 83
        Height = 17
        Caption = 'Efeito Aut.'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object splComVen: TcxSplitter
      Left = 1
      Top = 201
      Width = 283
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salTop
      Control = pnlComVen
      Visible = False
    end
    object splPromoc: TcxSplitter
      Left = 1
      Top = 404
      Width = 283
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salTop
      Control = pnlPromoc
      Visible = False
    end
    object splEstrut: TcxSplitter
      Left = 1
      Top = 579
      Width = 283
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salTop
      Control = pnlEstrut
      Visible = False
    end
    object pnlNovProd: TPanel
      Left = 1
      Top = 587
      Width = 283
      Height = 167
      Align = alTop
      Color = 16770261
      Locked = True
      ParentBackground = False
      TabOrder = 6
      Visible = False
      object PageControl4: TPageControl
        Left = 1
        Top = 1
        Width = 281
        Height = 165
        ActivePage = tbsNovProd
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object tbsNovProd: TTabSheet
          Caption = 'Novos Produtos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          object cxGrid3: TcxGrid
            Left = 0
            Top = 0
            Width = 273
            Height = 137
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxNovProdDBLayoutView1: TcxGridDBLayoutView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsNovProd
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.CellEndEllipsis = True
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
              Styles.Background = cxStyle1
              object cxGridDBLayoutViewItem7: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'IMAGEM'
                PropertiesClassName = 'TcxImageProperties'
                Properties.FitMode = ifmProportionalStretch
                Properties.GraphicClassName = 'TdxSmartImage'
                LayoutItem = cxGridLayoutItem10
                Options.Editing = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem8: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'DESITE'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.WordWrap = True
                LayoutItem = cxGridLayoutItem8
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem10: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'REFERE'
                PropertiesClassName = 'TcxLabelProperties'
                LayoutItem = cxNovProdDBLayoutView1LayoutItem1
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object cxGridDBLayoutViewItem9: TcxGridDBLayoutViewItem
                DataBinding.FieldName = 'PREVEN'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                LayoutItem = cxGridLayoutItem9
                Options.Editing = False
                Options.Filtering = False
                Options.Focusing = False
                IsCaptionAssigned = True
              end
              object dxLayoutGroup3: TdxLayoutGroup
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Text = 'Template Card'
                ButtonOptions.Buttons = <>
                Hidden = True
                ItemIndex = 1
                LayoutDirection = ldHorizontal
                ShowBorder = False
                Index = -1
              end
              object cxGridLayoutItem8: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup4
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 44
                SizeOptions.Width = 143
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object cxGridLayoutItem9: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup4
                AlignHorz = ahClient
                AlignVert = avClient
                CaptionOptions.Visible = False
                SizeOptions.Width = 111
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 2
              end
              object cxGridLayoutItem10: TcxGridLayoutItem
                Parent = dxLayoutGroup3
                AlignHorz = ahLeft
                AlignVert = avTop
                CaptionOptions.Visible = False
                SizeOptions.Height = 77
                SizeOptions.Width = 58
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 0
              end
              object dxLayoutAutoCreatedGroup4: TdxLayoutAutoCreatedGroup
                Parent = dxLayoutGroup3
                AlignHorz = ahLeft
                Index = 1
                AutoCreated = True
              end
              object cxNovProdDBLayoutView1LayoutItem1: TcxGridLayoutItem
                Parent = dxLayoutAutoCreatedGroup4
                AlignHorz = ahLeft
                CaptionOptions.Visible = False
                SizeOptions.Width = 144
                Padding.AssignedValues = [lpavBottom, lpavLeft, lpavRight, lpavTop]
                Index = 1
              end
            end
            object cxGridLevel3: TcxGridLevel
              GridView = cxNovProdDBLayoutView1
            end
          end
        end
      end
      object chkAniNovProd: TCheckBox
        Left = 190
        Top = 2
        Width = 83
        Height = 17
        Caption = 'Efeito Aut.'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
    end
    object splNovProd: TcxSplitter
      Left = 1
      Top = 754
      Width = 283
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salBottom
      Control = pnlNovProd
      Visible = False
    end
  end
  object dtsComVen: TDataSource
    Left = 127
    Top = 116
  end
  object dtsPromoc: TDataSource
    Left = 67
    Top = 276
  end
  object dtsEstrut: TDataSource
    Left = 43
    Top = 520
  end
  object tmrBanner: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrBannerTimer
    Left = 163
    Top = 58
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
  end
  object dtsNovProd: TDataSource
    Left = 83
    Top = 644
  end
end
