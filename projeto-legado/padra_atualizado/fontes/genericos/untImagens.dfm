inherited frmImagens: TfrmImagens
  Width = 1024
  Height = 650
  Caption = ''
  Position = poScreenCenter
  ExplicitTop = -102
  ExplicitWidth = 1024
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 577
    Width = 1018
    TabOrder = 1
    ExplicitTop = 577
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = -17
      ExplicitWidth = 1014
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 164
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F10 ] Confirmar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnIncluir: TBitBtnLocked
        Left = 164
        Top = 0
        Width = 164
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F1 ] Adicionar Imagem'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000080000
          000D0000000E0000000E0000000F0000000F0000000F0000000F000000100000
          0010000000100000001100000011000000100000000B00000003815749BFB478
          65FFB47865FFB47864FFB37764FFB37764FFB37764FFB37663FFB37663FFB276
          63FFB27663FFB27562FFB27562FFB27562FF7F5447C20000000AB67D6AFFFBF6
          F3FFFBF6F3FFFBF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFBF5F1FFFAF5F1FFFAF4
          F1FFFAF4F0FFFAF3EEFFFAF2EEFFFAF2EEFFB47967FF0000000FB87F6DFFFBF7
          F5FF2FB487FF2EB485FF2EB485FF2EB388FF2FB487FF2EB485FF2EB388FF2A9C
          73FF278661FF2B916AFF1D6A4AFFFAF4F1FFB57B69FF0000000FBA8270FFFCF9
          F7FF36BB8FFF36BB8FFF36BA90FF33B187FF278D67FF23815DFF2DA179FF2FA3
          7AFF278561FF2E9770FF23815CFFFBF6F3FFB77E6BFF0000000EBC8573FFFDFA
          F9FF3FC398FF3FC398FF3EC398FF32A27DFF68C8B2FF34AC85FF226C75FF275D
          B9FF26747AFF2B8E69FF278964FFFCF8F5FFB9816EFF0000000DBE8876FFFDFB
          FAFF4FCEA6FF50CFA7FF50CFA7FF40AE8AFF3678B4FF336ABBFF3168B6FF6EC2
          F1FF306BB7FF3066B4FF2D6DAAFFFCF9F7FFBB8471FF0000000CC08B7AFFFEFC
          FBFF5BD5AEFF5BD5AFFF5AD6AEFF50C29EFF437BBFFF8BD5F6FF63A5E4FF73D7
          FCFF569EE1FF66C7F5FF3B74BEFFFDFAF9FFBE8674FF0000000BC28E7DFFFEFD
          FCFF62DBB5FF62DBB5FF5FD6B1FF53AEAFFF528DCCFF6EB1E7FF5B9DD2FF305D
          AAFF4F95CFFF5DA7E5FF4581C7FFFEFBFAFFBF8A77FF0000000AC59280FFFEFE
          FDFFF4DCAFFFF4DCAEFFEBD5A9FF628FD0FF94D5F6FFA9ECFFFF3B76BEFF4390
          D3FF3876BEFF7CDFFFFF74C9F4FFFEFCFBFFC18D7CFF00000009C79584FFFFFE
          FEFFF8E7C6FFF8E6C5FFF3E3C2FFBABEBDFF7CA8D8FF8DC8F1FF6CB6E4FF3A80
          C9FF67B5E4FF85D0F4FF6B9AD1FFFEFDFCFFC3907EFF00000008C99887FFFFFE
          FEFFFBEDD3FFFBEDD3FFFAEDD2FFEDE0C7FF87B2DCFFAAE8FDFF9CD5F6FFAFEF
          FFFF96DAF9FFA7ECFFFF7AA8D7FFFEFEFDFFC69381FF00000007CB9C8AFFFFFF
          FEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFC89785FF000000069C7C6EBED2A7
          95FFD2A795FFD2A694FFD1A694FFD1A594FFD1A593FFD1A593FFD0A492FFD0A4
          92FFD0A391FFCFA290FFCFA190FFCFA18FFF997669C000000003000000010000
          0001000000020000000200000002000000020000000200000003000000030000
          0003000000030000000300000004000000040000000300000001}
        TabOrder = 1
        OnClick = btnIncluirClick
      end
      object btnEnviaWpp: TBitBtnLocked
        Left = 328
        Top = 0
        Width = 164
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F6 ] Enviar por Whatsapp'
        TabOrder = 2
        OnClick = btnEnviaWppClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      TabOrder = 0
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 605
    Width = 1018
    TabOrder = 2
    ExplicitTop = 605
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object cxgImagens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 554
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgImagensDBL: TcxGridDBLayoutView
      OnKeyDown = cxgImagensDBLKeyDown
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.InfoPanel.DisplayMask = '[RecordIndex] - [RecordCount]'
      Navigator.InfoPanel.Visible = True
      Navigator.Visible = True
      FilterBox.Visible = fvNever
      OnCellDblClick = cxgImagensDBLCellDblClick
      OnEditKeyDown = cxgImagensDBLEditKeyDown
      OnFocusedRecordChanged = cxgImagensDBLFocusedRecordChanged
      DataController.DataSource = dtsImagens
      DataController.KeyFieldNames = 'INDICE'
      DataController.Options = []
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.ItemAddValueItems = False
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.CopyRecordsToClipboard = False
      OptionsBehavior.DragHighlighting = False
      OptionsBehavior.DragOpening = False
      OptionsBehavior.DragScrolling = False
      OptionsBehavior.ExpandRecordOnDblClick = False
      OptionsCustomize.ItemFiltering = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.MaxColumnCount = 3
      OptionsView.MaxRowCount = 2
      OptionsView.MinValueWidth = 10
      OptionsView.RecordCaption.Visible = False
      OptionsView.ViewMode = lvvmMultiRow
      Styles.Content = cxsGroupLayoutView
      Styles.Group = cxsGroupLayoutView
      Styles.RecordBorder = cxsGroupLayoutView
      Styles.Selection = cxsGroupLayoutView
      object cxgImagensDBLIMAGEM: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'IMAGEM'
        PropertiesClassName = 'TcxImageProperties'
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = []
        LayoutItem = cxgImagensDBLLayoutItem1
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.Focusing = False
        Options.IgnoreTimeForFiltering = False
        Options.IncSearch = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
      end
      object cxgImagensDBLCAPPRI: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'CAPPRI'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Properties.PenWidth = 0
        LayoutItem = cxgImagensDBLLayoutItem3
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.Focusing = False
        Options.IgnoreTimeForFiltering = False
        Options.IncSearch = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Styles.Content = cxsCaptionBold
        IsCaptionAssigned = True
      end
      object cxgImagensDBLPRINCI: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'PRINCI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnEditValueChanged = cxgImagensDBLPRINCIPropertiesEditValueChanged
        LayoutItem = cxgImagensDBLLayoutItem2
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        IsCaptionAssigned = True
      end
      object cxgImagensDBLEXCLUIR: TcxGridDBLayoutViewItem
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              0000000000020000000700000007000000040000000700000007000000040000
              0007000000070000000200000000000000000000000000000000000000000000
              0000352A288A614D4AFF6B5955FF7A6865FF786865FF756460FF705D5AFF604D
              49FF5B4743FF3327268700000000000000000000000000000000000000000000
              00005C4843EAAE9E95FFB5A69EFF9C887DFFBEB1AAFFBAACA5FF957F74FFB2A3
              9AFFA99990FF574540E300000000000000000000000000000000000000000000
              000068524CFFD9CBC3FFD1C6BFFF9E8B81FFDFD3CDFFD5CAC3FF968277FFD9CB
              C3FFCCC0B8FF67514BFF00000000000000000000000000000000000000000000
              00006A5550FFD9CBC3FFD1C6BFFFA18E83FFDFD3CDFFD4CAC3FF9A867BFFD9CB
              C3FFCCC0B8FF69544FFF00000000000000000000000000000000000000000000
              00006E5953FFD9CBC3FFD1C6BEFFA49188FFDED3CCFFD4C9C3FF9D897FFFD9CB
              C3FFCCC0B8FF6D5852FF00000000000000000000000000000000000000000000
              0000725C56FFD8CBC3FFD1C5BEFFA6958BFFDED3CCFFD4C9C2FFA08D83FFD8CB
              C3FFCCC0B8FF715B55FF00000000000000000000000000000001000000010000
              0003755F58FFD5C7BFFFCDC1BBFFA6968DFFDACFC8FFD0C5BFFFA19086FFD5C7
              BFFFC8BCB5FF745E57FF00000003000000010000000100000001000000030101
              010874605AFFCDC0B9FFC5BAB3FFA6958DFFD3C8C1FFC8BEB8FFA08F85FFCCBF
              B7FFC0B5AEFF735F59FF01010109010101040000000100000001010101060202
              020E76625BFFC1B6AFFFBAAFA9FFA3948DFFC6BBB5FFBDB3ADFF9E8F87FFC0B4
              ADFFB6ABA4FF76625BFF0202020F010101060000000200000001010101066951
              4BFF6A524CFF6B534DFF6E5751FF725B56FF735D57FF725B56FF6E5751FF6B53
              4DFF6A524CFF69514BFF69514BFF010101060000000200000001000000036B54
              4DFFAB9588FFB29D91FFBFAEA4FFCEC0B9FFD3C8C1FFCEC0B9FFBFAEA4FFB29D
              91FFAB9588FFAA9386FF6B544DFF000000030000000100000000000000014133
              2E97907E78FFB0A39FFFC5BBB8FFD2CAC8FFD6D0CDFFD2CAC8FFC7BEBBFFBAAF
              ABFFAA9D98FF8D7A73FF40322E95000000010000000000000000000000000000
              000055433EC46F5852FF8D7971FF8E7A72FF715B55FF715A54FF8D7971FF8C78
              70FF6E5751FF55433EC400000000000000000000000000000000000000000000
              00000000000001010101725B55FF453836900C0C0C0C0B0B0B0B4236348C725B
              55FF000000000000000000000000000000000000000000000000000000000000
              000000000000010101015A4844C4887570FF8F7D78FF8E7D78FF897671FF5947
              43C40000000000000000000000000000000000000000}
            Kind = bkGlyph
            Width = 27
          end>
        Properties.ClickKey = 46
        Properties.OnButtonClick = cxgImagensDBLEXCLUIRPropertiesButtonClick
        LayoutItem = cxgImagensDBLLayoutItem4
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.IgnoreTimeForFiltering = False
        Options.IncSearch = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.ShowEditButtons = isebAlways
      end
      object cxgImagensDBLINDICE: TcxGridDBLayoutViewItem
        DataBinding.FieldName = 'INDICE'
        Visible = False
        LayoutItem = cxgImagensDBLLayoutItem5
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxgImagensDBLGroup_Root: TdxLayoutGroup
        AlignHorz = ahLeft
        AlignVert = avTop
        CaptionOptions.Text = 'Template Card'
        CaptionOptions.Visible = False
        ButtonOptions.Buttons = <>
        Hidden = True
        ShowBorder = False
        Index = -1
      end
      object cxgImagensDBLLayoutItem1: TcxGridLayoutItem
        Parent = cxgImagensDBLGroup_Root
        AlignHorz = ahLeft
        AlignVert = avTop
        CaptionOptions.Visible = False
        SizeOptions.Height = 179
        SizeOptions.Width = 260
        Index = 0
      end
      object cxgImagensDBLLayoutItem2: TcxGridLayoutItem
        Parent = cxgImagensDBLGroup1
        AlignHorz = ahLeft
        AlignVert = avCenter
        CaptionOptions.AlignHorz = taRightJustify
        CaptionOptions.Visible = False
        CaptionOptions.VisibleElements = [cveText]
        CaptionOptions.Width = 10
        SizeOptions.Height = 10
        SizeOptions.Width = 20
        SizeOptions.MaxHeight = 10
        Index = 0
      end
      object cxgImagensDBLLayoutItem3: TcxGridLayoutItem
        Parent = cxgImagensDBLGroup1
        AlignHorz = ahClient
        CaptionOptions.Visible = False
        SizeOptions.Height = 28
        SizeOptions.Width = 112
        Index = 1
      end
      object cxgImagensDBLGroup1: TdxLayoutAutoCreatedGroup
        Parent = cxgImagensDBLGroup_Root
        LayoutDirection = ldHorizontal
        Index = 1
        AutoCreated = True
      end
      object cxgImagensDBLLayoutItem4: TcxGridLayoutItem
        Parent = cxgImagensDBLGroup1
        AlignHorz = ahRight
        AlignVert = avClient
        CaptionOptions.Visible = False
        CaptionOptions.Width = 10
        SizeOptions.Height = 1
        SizeOptions.Width = 34
        Index = 2
      end
      object cxgImagensDBLLayoutItem5: TcxGridLayoutItem
        Index = -1
      end
    end
    object cxgImagensLVL: TcxGridLevel
      GridView = cxgImagensDBL
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 554
    Width = 1018
    Height = 23
    Align = alBottom
    TabOrder = 3
    object lblDeletar: TLabel
      Left = 148
      Top = 4
      Width = 131
      Height = 14
      Caption = '[ DEL ] - Deletar Imagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 127
      Height = 14
      Caption = '[ F3 ] - Ampliar Imagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
  end
  object dtsImagens: TDataSource
    Left = 384
    Top = 264
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 32
    Top = 8
    PixelsPerInch = 96
    object cxsGroupLayoutView: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object cxsCaptionBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
