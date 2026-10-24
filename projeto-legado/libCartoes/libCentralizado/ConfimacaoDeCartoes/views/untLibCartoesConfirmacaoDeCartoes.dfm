inherited frmLibCartoesConfirmacaoDeCartoes: TfrmLibCartoesConfirmacaoDeCartoes
  Width = 1000
  Height = 730
  Caption = 'Confirma'#231#227'o de Cart'#245'es'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1000
  ExplicitHeight = 730
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 657
    Width = 994
    Height = 0
    Visible = False
    ExplicitTop = 657
    ExplicitWidth = 994
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 990
      Height = 6
      ExplicitWidth = 990
      ExplicitHeight = 6
    end
    inherited btnSair: TBitBtnLocked
      Left = 1086
      Top = -25
      ExplicitLeft = 1086
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 685
    Width = 994
    ExplicitTop = 685
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 823
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 657
    Width = 994
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = []
    Font.Quality = fqClearType
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      994
      28)
    object cxBtnSair: TBitBtnLocked
      Left = 913
      Top = 2
      Width = 79
      Height = 24
      Align = alRight
      Caption = '&Sair'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
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
      ParentFont = False
      TabOrder = 1
      OnClick = cxBtnSairClick
    end
    object FlowPanel1: TFlowPanel
      Left = 2
      Top = 2
      Width = 1125
      Height = 0
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    object BitBtnLocked1: TBitBtnLocked
      Left = 190
      Top = 3
      Width = 0
      Height = 0
      Anchors = [akRight, akBottom]
      Caption = '&Sair'
      Enabled = False
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
      TabOrder = 2
      Visible = False
    end
    object Panel4: TPanel
      Left = 137
      Top = 3
      Width = 2
      Height = 21
      Color = 16770261
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object btnConciliacao: TBitBtnLocked
      AlignWithMargins = True
      Left = 5
      Top = 2
      Width = 130
      Height = 24
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '[ F9 ] Concilia'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 4
      OnClick = btnConciliacaoClick
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 994
    Height = 657
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grpOpcoes: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 25
      Align = alTop
      PanelStyle.Active = True
      ParentBackground = False
      ParentFont = False
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = ''
      Style.Shadow = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = ''
      TabOrder = 0
      DesignSize = (
        988
        150)
      Height = 150
      Width = 988
      object gpbLanPendentes: TcxGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 2
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Lan'#231'amentos Pendentes'
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        Style.Color = 16770261
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.Font.Quality = fqClearType
        Style.LookAndFeel.NativeStyle = True
        Style.LookAndFeel.SkinName = ''
        Style.TextColor = clBtnText
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.SkinName = ''
        TabOrder = 1
        Height = 141
        Width = 618
        object grdPendOperadora: TcxDBVerticalGrid
          AlignWithMargins = True
          Left = 4
          Top = 19
          Width = 610
          Height = 118
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 2
          BorderStyle = cxcbsNone
          Align = alClient
          LayoutStyle = lsMultiRecordView
          LookAndFeel.NativeStyle = True
          LookAndFeel.ScrollbarMode = sbmClassic
          LookAndFeel.SkinName = 'blue'
          OptionsView.CellAutoHeight = True
          OptionsView.ScrollBars = ssHorizontal
          OptionsView.AutoScaleBands = False
          OptionsView.BandsInterval = 1
          OptionsView.PaintStyle = psDelphi
          OptionsView.ShowButtons = False
          OptionsView.ShowHeaders = False
          OptionsView.GridLines = vglNone
          OptionsView.ValueWidth = 125
          OptionsBehavior.AlwaysShowEditor = False
          OptionsBehavior.CellHints = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.CancelOnExit = False
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Background = cxStyle8
          Styles.OnGetContentStyle = grdPendOperadoraStylesGetContentStyle
          Styles.ContentEven = cxStyle8
          Styles.ContentOdd = cxStyle8
          TabOrder = 0
          OnDblClick = grdPendOperadoraDblClick
          Version = 1
          object grdPendOperadoraDBEditorRow1: TcxDBEditorRow
            Options.CanAutoHeight = False
            Options.CanMovedToCustomizationForm = False
            Options.CanResized = False
            Options.Focusing = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Options.TabStop = False
            Height = 17
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object grdPendOperadoraIMGCON: TcxDBEditorRow
            Options.CanAutoHeight = False
            Options.CanResized = False
            Options.Focusing = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Options.TabStop = False
            Expanded = False
            Height = 17
            Properties.EditPropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.EditProperties.Images = imglPendentes
            Properties.EditProperties.Items = <
              item
                ImageIndex = 0
                Value = 'REDECARD'
              end
              item
                ImageIndex = 1
                Value = 'PAGAR.ME'
              end>
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ShowDescriptions = False
            Properties.DataBinding.FieldName = 'IMGCON'
            Properties.Options.Editing = False
            Properties.Options.Filtering = False
            Properties.Options.IncSearch = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object grdPendOperadoraNOMCON: TcxDBEditorRow
            Options.CanAutoHeight = False
            Options.CanResized = False
            Options.Focusing = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Options.TabStop = False
            Height = 17
            Properties.EditPropertiesClassName = 'TcxTextEditProperties'
            Properties.EditProperties.Alignment.Horz = taCenter
            Properties.EditProperties.ReadOnly = True
            Properties.DataBinding.FieldName = 'NOMCON'
            Styles.Content = cxStyle2
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object grdPendOperadoraQtdPendentes: TcxDBEditorRow
            Options.CanAutoHeight = False
            Options.CanMovedToCustomizationForm = False
            Options.CanResized = False
            Options.Focusing = False
            Options.Moving = False
            Options.TabStop = False
            Height = 17
            Properties.EditPropertiesClassName = 'TcxTextEditProperties'
            Properties.EditProperties.Alignment.Horz = taCenter
            Properties.EditProperties.ReadOnly = True
            Properties.DataBinding.FieldName = 'QTDREG'
            Properties.Options.Filtering = False
            Properties.Options.IncSearch = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object grdPendOperadoraMarcado: TcxDBEditorRow
            Options.CanAutoHeight = False
            Options.CanMovedToCustomizationForm = False
            Options.CanResized = False
            Options.Focusing = False
            Options.Moving = False
            Options.ShowExpandButton = False
            Options.ShowInCustomizationForm = False
            Options.TabStop = False
            Properties.DataBinding.FieldName = 'MARCADO'
            Visible = False
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
        end
      end
      object btnAtualizarPendentes: TcxButton
        AlignWithMargins = True
        Left = 604
        Top = 5
        Width = 24
        Height = 17
        Hint = 'Atualiza os registros pendentes'
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        ParentCustomHint = False
        Anchors = [akTop, akRight]
        LookAndFeel.NativeStyle = False
        LookAndFeel.SkinName = 'Blue'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000001000000040000
          00040000000500000006000000090000000B0000000B0000000B000000090000
          0006000000030000000100000000000000000000000000000003000000090000
          000B0000000D0000001000000014000000160000001700000016000000140000
          000F0000000A0000000500000002000000000000000000000006102F22870000
          0015000000180A1F1663143A29A71B5039DC1F5E43FB1B5039DC143A29A70A1E
          1662000000120000000B00000005000000010000000000000008236449FF1336
          28981336289A236348FC52AB8FFF74CEB9FF88E4D3FF76D0BCFF56AD93FF2363
          48FC13362897030907270000000A00000002000000010000000926694EFF4BA2
          83FF4BA283FF6ED0B2FF64B399FF4A8D76FF2C6E54FF4F8F79FF78BBA8FF87DB
          C4FF4C9F82FF15392A960000000F0000000400000001000000082A6F53FF91E1
          C9FF91E1C9FF6DB79DFF1A4534A70C1F1751020403130C1F174D1A4533A469A6
          90FF97DFCAFF2A6E52FC0E241B5E0000000500000001000000072F775BFFCFF3
          E8FFCFF3E8FF81B7A3FF183D2F8B0000000A0000000500000006010302111D4A
          39A695C5B4FF91C3B1FF1D4938A3000000060000000100000006378466FF3784
          66FF378466FF378466FF378466FF1C42338200000004000000060000000B0F25
          1C53378466FF378466FF2E6F55DA000000060000000200000006000000110000
          001700000017000000120000000A00000006000000050000000A000000110000
          00180000001C0000001A000000140000000700000002000000051B5039DA205F
          44FF205F44FF091A13570000000E0000000900000009102F2286205F44FF205F
          44FF205F44FF205F44FF205F44FF000000080000000300000004163D2CA25AAF
          97FF4DA98AFF163F2DAA0103021D00000012000000120000001512332691419A
          7BFF60CFACFF60CFACFF236449FF0000000900000003000000020C2219592668
          4DFC8EDEC9FF4D9B80FF184131AA0B1D165B020403240B1D165B184131AA5DAF
          94FF8CE0C9FF8BE0C8FF26694EFF00000008000000030000000100000005173C
          2D907AB19EFFAFE7D7FF77BAA3FF498F75FF2E7458FF498F75FF77BAA3FFAFE7
          D7FF7FB6A3FF7EB6A3FF2A6F53FF00000006000000020000000000000002040B
          081C194132902E765AFC97C4B4FFB9E0D4FFCEF1E6FFB9E0D4FF97C4B4FF2E76
          5AFC1A413191194132902F775BFF000000030000000100000000000000000000
          000100000003122A215622503E9F2F6F56D9368164FA2F6F56D922503E9F122A
          215600000005000000041B423381000000010000000100000000000000000000
          0000000000010000000100000002000000030000000400000003000000020000
          00010000000100000001000000010000000000000000}
        ParentShowHint = False
        ShowHint = False
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        SpeedButtonOptions.Transparent = True
        TabOrder = 0
        OnClick = btnAtualizarPendentesClick
      end
      object gpbPontoVendas: TcxGroupBox
        AlignWithMargins = True
        Left = 626
        Top = 2
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        Caption = 'Pontos de Vendas'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.Font.Quality = fqClearType
        Style.LookAndFeel.NativeStyle = True
        Style.LookAndFeel.SkinName = ''
        Style.TextColor = clBtnText
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.SkinName = ''
        TabOrder = 2
        Height = 141
        Width = 355
        object cxGridPontosDeVenda: TcxGrid
          AlignWithMargins = True
          Left = 4
          Top = 19
          Width = 347
          Height = 118
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Font.Quality = fqClearType
          ParentFont = False
          TabOrder = 0
          LockedStateImageOptions.AssignedValues = [lsiavFont]
          LockedStateImageOptions.Font.Charset = ANSI_CHARSET
          LockedStateImageOptions.Font.Color = clBlack
          LockedStateImageOptions.Font.Height = 14
          LockedStateImageOptions.Font.Name = 'Arial'
          LockedStateImageOptions.Font.Pitch = fpVariable
          LockedStateImageOptions.Font.Style = []
          LockedStateImageOptions.Font.Quality = fqClearType
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridDBTableViewResumoBandeira: TcxGridDBTableView
            DragMode = dmAutomatic
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = cxGridDBTableViewResumoBandeiraCustomDrawCell
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = 'Total: #'
                Kind = skCount
              end>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skSum
                Column = cxGridDBTableViewResumoBandeiraTOTAL_LIQUIDO
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.DragHighlighting = False
            OptionsBehavior.DragScrolling = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
            OptionsView.GroupByBox = False
            Styles.Content = cxStyle12
            Styles.Group = cxStyle11
            object cxGridDBTableViewResumoBandeiraESTABELECIMENTO: TcxGridDBColumn
              Caption = 'Ponto de venda'
              DataBinding.FieldName = 'ESTABELECIMENTO'
              Visible = False
              Width = 95
            end
            object cxGridDBTableViewResumoBandeiraLOGO: TcxGridDBColumn
              Caption = 'Bandeira'
              DataBinding.FieldName = 'LOGO'
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.Images = imgLogoBandeiras
              Properties.Items = <
                item
                  Description = 'MASTERCARD'
                  ImageIndex = 0
                  Value = 'MASTERCARD'
                end
                item
                  Description = 'MAESTRO'
                  ImageIndex = 1
                  Value = 'MAESTRO'
                end
                item
                  Description = 'VISA'
                  ImageIndex = 2
                  Value = 'VISA'
                end
                item
                  Description = 'AMERICAN EXPRESS'
                  ImageIndex = 3
                  Value = 'AMERICAN EXPRESS'
                end
                item
                  Description = 'DINERS'
                  ImageIndex = 4
                  Value = 'DINERS'
                end
                item
                  Description = 'ELO'
                  ImageIndex = 5
                  Value = 'ELO'
                end
                item
                  Description = 'HIPERCARD'
                  ImageIndex = 6
                  Value = 'HIPERCARD'
                end
                item
                  Description = 'OUTROS'
                  ImageIndex = 7
                  Value = 'OUTROS'
                end
                item
                  Description = 'BOLETO'
                  ImageIndex = 8
                  Value = 'BOLETO'
                end
                item
                  Description = 'PIX'
                  ImageIndex = 9
                  Value = 'PIX'
                end>
              Styles.Content = cxStyle16
              Width = 221
            end
            object cxGridDBTableViewResumoBandeiraQUANTIDADE: TcxGridDBColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              Styles.Content = cxStyle13
            end
            object cxGridDBTableViewResumoBandeiraTOTAL_BRUTO: TcxGridDBColumn
              Caption = 'Total Bruto'
              DataBinding.FieldName = 'TOTAL_BRUTO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Styles.Content = cxStyle13
              Width = 110
            end
            object cxGridDBTableViewResumoBandeiraTOTAL_TAXA: TcxGridDBColumn
              Caption = 'Total Taxa'
              DataBinding.FieldName = 'TOTAL_TAXA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Styles.Content = cxStyle14
              Width = 110
            end
            object cxGridDBTableViewResumoBandeiraTOTAL_LIQUIDO: TcxGridDBColumn
              Caption = 'Total Liquido'
              DataBinding.FieldName = 'TOTAL_LIQUIDO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = ',0.00;-,0.00'
              Styles.Content = cxStyle15
              Width = 110
            end
          end
          object cxGridLevel4: TcxGridLevel
            GridView = cxGridDBTableViewResumoBandeira
          end
        end
      end
    end
    object grpExtrato: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 181
      Align = alClient
      PanelStyle.Active = True
      Style.BorderColor = clNavy
      Style.BorderStyle = ebsUltraFlat
      Style.LookAndFeel.NativeStyle = False
      Style.LookAndFeel.SkinName = ''
      Style.Shadow = True
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.SkinName = ''
      TabOrder = 1
      Height = 473
      Width = 988
      object dxDockSite1: TdxDockSite
        Left = 2
        Top = 2
        Width = 981
        Height = 432
        AllowDockClients = [dtLeft, dtRight, dtBottom]
        Align = alClient
        DockingType = 5
        OriginalWidth = 981
        OriginalHeight = 432
        object dxLayoutDockSite3: TdxLayoutDockSite
          Left = 0
          Top = 0
          Width = 624
          Height = 432
          DockingType = 0
          OriginalWidth = 300
          OriginalHeight = 200
          object dxLayoutDockSite1: TdxLayoutDockSite
            Left = 0
            Top = 0
            Width = 624
            Height = 432
            DockingType = 0
            OriginalWidth = 300
            OriginalHeight = 200
          end
          object dckpnlExtrato: TdxDockPanel
            Left = 0
            Top = 0
            Width = 624
            Height = 432
            AllowDockClients = [dtBottom]
            AllowFloating = False
            AutoHide = False
            Caption = 'Extrato Banc'#225'rio'
            CaptionButtons = []
            CustomCaptionButtons.Buttons = <>
            ShowCaption = False
            TabsProperties.CustomButtons.Buttons = <>
            TabsProperties.Style = 6
            DockingType = 0
            OriginalWidth = 347
            OriginalHeight = 446
            object cxGroupBox4: TcxGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 3
              Align = alClient
              PanelStyle.Active = True
              ParentBackground = False
              ParentColor = False
              Style.BorderColor = clNavy
              Style.BorderStyle = ebsNone
              Style.Color = 16770261
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 0
              DesignSize = (
                614
                422)
              Height = 422
              Width = 614
              object Panel7: TPanel
                Left = 2
                Top = 2
                Width = 610
                Height = 25
                Align = alTop
                BevelOuter = bvNone
                Color = 9526278
                Ctl3D = False
                ParentBackground = False
                ParentCtl3D = False
                TabOrder = 1
                StyleElements = []
                object Label16: TLabel
                  Left = 74
                  Top = 0
                  Width = 409
                  Height = 25
                  Margins.Left = 0
                  Margins.Top = 0
                  Margins.Right = 80
                  Align = alClient
                  Alignment = taCenter
                  Caption = 'Extrato de cart'#245'es'
                  Color = clActiveCaption
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWhite
                  Font.Height = -13
                  Font.Name = 'Tahoma'
                  Font.Pitch = fpVariable
                  Font.Style = [fsBold]
                  Font.Quality = fqClearType
                  ParentColor = False
                  ParentFont = False
                  Layout = tlCenter
                  StyleElements = []
                  ExplicitWidth = 122
                  ExplicitHeight = 16
                end
                object btnConfigPainel: TcxButton
                  AlignWithMargins = True
                  Left = 1
                  Top = 1
                  Width = 35
                  Height = 23
                  Hint = 'Op'#231#245'es'
                  Margins.Left = 1
                  Margins.Top = 1
                  Margins.Right = 1
                  Margins.Bottom = 1
                  ParentCustomHint = False
                  Align = alLeft
                  DropDownMenu = mmnConfigPaineis
                  Kind = cxbkOfficeDropDown
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    424D360400000000000036000000280000001000000010000000010020000000
                    000000000000C40E0000C40E00000000000000000000000000030000000B0000
                    00110000000B0000000200000000000000000000000000000000000000020000
                    000A000000100000000C0000000300000000000000000000000A171D50A52932
                    8BFF14194595000000100000000200000000000000000000000300000010362A
                    2699685149FF4A3D38AD0000000B00000000000000000000000D273486F15DB8
                    EAFF255EA0FF06082E9C0000001000000002000000030000000F261611A3A28B
                    7FFFE8DAD0FF7B655DFD0000000E000000000000000000000007151D468BB8DF
                    F0FF64C4F1FF2B69ABFF060B339B0000001100000010281812A1987E72FFE1CD
                    C1FFB8A79EFF43383498000000080000000000000000000000010000000B1824
                    5397BAE2F2FF6BC9F3FF2F6FB1FF070E389F221510B29A8175FFE2D1C4FFBFAF
                    A6FF4A3F399F0000000C00000002000000000000000000000000000000010000
                    000B18285797BCE4F3FF74CFF3FF3676B7FF2A2E57FF9E938CFFBFB0A8FF4D41
                    3B9E0000000B0000000200000000000000000000000000000001000000040000
                    0009000000151A2E5B9BBDE5F4FF7CD3F5FF3C7FBFFF313B68FF403732AE0000
                    000B0000000200000002000000080000000C00000006000000062B25225D6A5A
                    52CC867168FF4D362DEA606E97FFBEE7F5FF85DAF7FF4284C3FF0D1C49930000
                    000800000000000000083D322A90796254FF231D195E2C2522589A867CFFD5CA
                    C2FFEEE4DDFFE4D3C9FFDCCCC2FF6E81ABFFBDE7F5FF9FE0F6FF1F449CFA0102
                    041A0000000D16120F418F7B6FFFF9F7F6FF9B806DFF7A6960D6A6958BFF927C
                    71FFAC9B91FFEFE6DFFFE4D6CCFF7D6A61EB1A355D893365B4EFE1D3CDFF7F68
                    59FF7F6759FF7E6759FF958175FFAF998AFF4E41388B9F8E84F94C43407F0000
                    000940363180A19086FFE8DBD2FF8D796FF90000000A0000000DB19889FFE8DF
                    D9FFE5DBD5FFF1ECE9FFA78E7DFF191513360000000600000003000000020000
                    0002060504147D685DFFDCD1CBFF7B6A62D40000000500000009B59D8FFFEAE2
                    DDFFF4EFECFFCABFB7FF4A3E3787000000050000000000000000000000000000
                    0002382D287F89746CFFB1A098FF37322E58000000053A2F2887AD9E95FFF6F3
                    F0FFCCC0B9FF4C40398600000005000000010000000000000000000000000000
                    0002AC9B92F9887A73C8312C2A4C000000053A2E2786B9AEA7FFFFFFFFFFCEC2
                    BBFF4E423A840000000400000001000000000000000000000000000000000000
                    0000000000010000000100000001C0A89CFFC0A89CFFC0A89CFFBFA79BFF4F43
                    3C82000000030000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000010000000200000002000000020000
                    00010000000000000000000000000000000000000000}
                  OptionsImage.Images = imglDiversas16
                  ParentShowHint = False
                  ShowHint = False
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 0
                end
                object btnPrintExtBan: TcxButton
                  AlignWithMargins = True
                  Left = 40
                  Top = 3
                  Width = 31
                  Height = 19
                  Hint = 'Relat'#243'rio do extrato banc'#225'rio.'
                  Align = alLeft
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000001B744558745469746C65005072696E74507265766965773B50726576
                    6965773B2D72FAAE000000DB49444154785EB592310AC2401045BDC61E2A95A9
                    BC86A58520E93C825606EC050B412CAC144F60612176DA080A168219E7C11AC2
                    6EDC0D88039F0CB37FDE4C926D8948A92CCBA489AA3D1E20127F00686169576B
                    0A28BDF492C80F00F10011850122D248165038004F18FAC960D1EE8E37C7CE70
                    F542E4D438C31302E4187B93DD75BA3EC8E97247424ECD42F2102055D38C0637
                    A8B1091E0F5009C3CA4CBD3D9EB2DD9F11B950E34CFD06C0DC05E8641405C46E
                    62F4153C80B3C1B78FC81980913E831B14AADADF689B01250EA0F62EE4AA5465
                    3E3E26D30CE40D705DEA2D89E5770D0000000049454E44AE426082}
                  ParentShowHint = False
                  ShowHint = True
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 1
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  ParentFont = False
                  OnClick = btnPrintExtBanClick
                end
                object btnImportarVendas: TcxButton
                  AlignWithMargins = True
                  Left = 485
                  Top = 2
                  Width = 123
                  Height = 21
                  Margins.Left = 2
                  Margins.Top = 2
                  Margins.Right = 2
                  Margins.Bottom = 2
                  Align = alRight
                  Caption = '&Importar Vendas'
                  Colors.DefaultText = clWindow
                  LookAndFeel.Kind = lfFlat
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000001974455874536F6674776172650041646F626520496D616765526561
                    647971C9653C00000021744558745469746C65004472696C6C3B446F776E3B43
                    686172743B46616C6C3B4172726F7797222E710000009549444154785EEDD0B1
                    09C3400C85E104B2C6910DDC7B08ADE1325CE5F4592223A47577EEB24F96509E
                    401C8AF0C3491FC30FE2B03EB83BA86A4F6EAB5550450DBDBCE667C5FFE93B19
                    38A20B52D282460644E88A2674B67C7E06A4EC015BE81090DA81F971570B9FCD
                    B98C4C0EB49F005B6251208027004200F90062F90A1B88D8F9B7404684BD419F
                    59617917E07180637F80F706F140A281AC2C9ACE0000000049454E44AE426082}
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 2
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWhite
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = [fsBold]
                  Font.Quality = fqClearType
                  ParentFont = False
                  OnClick = btnImportarVendasClick
                end
              end
              object gbPeriodoExtrato: TcxGroupBox
                Left = 2
                Top = 27
                Align = alTop
                PanelStyle.Active = True
                Style.BorderStyle = ebsNone
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = 'MoneyTwins'
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = 'MoneyTwins'
                TabOrder = 2
                Height = 29
                Width = 610
                object Label14: TLabel
                  Left = 3
                  Top = 3
                  Width = 46
                  Height = 23
                  Align = alLeft
                  Alignment = taRightJustify
                  AutoSize = False
                  Caption = 'Per'#237'odo:'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                end
                object Label15: TLabel
                  Left = 139
                  Top = 3
                  Width = 13
                  Height = 23
                  Align = alLeft
                  Alignment = taCenter
                  AutoSize = False
                  Caption = #224
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  Transparent = True
                  Layout = tlCenter
                  ExplicitLeft = 132
                end
                object dtaIniExt: TcxDateEdit
                  Tag = 99
                  Left = 49
                  Top = 3
                  Align = alLeft
                  ParentFont = False
                  Properties.ButtonGlyph.SourceDPI = 96
                  Properties.ButtonGlyph.Data = {
                    424D360400000000000036000000280000001000000010000000010020000000
                    000000000000C40E0000C40E00000000000000000000000000020000000A0000
                    0010000000110000001100000011000000120000001200000012000000120000
                    00120000001300000013000000120000000C000000030000000A81594CC2B47C
                    69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
                    67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
                    F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
                    E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
                    F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
                    83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
                    F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
                    D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
                    F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
                    86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
                    FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
                    D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
                    FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
                    8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
                    FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
                    DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
                    FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
                    91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
                    FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
                    F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
                    ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
                    DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
                    EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
                    DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
                    EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
                    E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
                    C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
                    B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
                    0006000000060000000600000007000000070000000700000007000000070000
                    00070000000800000008000000070000000500000001}
                  Properties.ClearKey = 46
                  Properties.DateButtons = []
                  Properties.InputKind = ikRegExpr
                  Properties.MinDate = 2.000000000000000000
                  Properties.SaveTime = False
                  Properties.ShowOnlyValidDates = True
                  Properties.ShowTime = False
                  Properties.ValidateOnEnter = False
                  Properties.ValidationOptions = []
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -11
                  Style.Font.Name = 'Tahoma'
                  Style.Font.Pitch = fpVariable
                  Style.Font.Style = []
                  Style.Font.Quality = fqClearType
                  Style.IsFontAssigned = True
                  StyleFocused.Color = clInfoBk
                  TabOrder = 0
                  Width = 90
                end
                object dtaFinExt: TcxDateEdit
                  Tag = 99
                  Left = 152
                  Top = 3
                  Align = alLeft
                  ParentFont = False
                  Properties.ButtonGlyph.SourceDPI = 96
                  Properties.ButtonGlyph.Data = {
                    424D360400000000000036000000280000001000000010000000010020000000
                    000000000000C40E0000C40E00000000000000000000000000020000000A0000
                    0010000000110000001100000011000000120000001200000012000000120000
                    00120000001300000013000000120000000C000000030000000A81594CC2B47C
                    69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
                    67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
                    F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
                    E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
                    F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
                    83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
                    F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
                    D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
                    F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
                    86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
                    FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
                    D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
                    FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
                    8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
                    FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
                    DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
                    FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
                    91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
                    FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
                    F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
                    ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
                    DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
                    EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
                    DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
                    EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
                    E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
                    C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
                    B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
                    0006000000060000000600000007000000070000000700000007000000070000
                    00070000000800000008000000070000000500000001}
                  Properties.ClearKey = 46
                  Properties.DateButtons = []
                  Properties.InputKind = ikRegExpr
                  Properties.MinDate = 2.000000000000000000
                  Properties.SaveTime = False
                  Properties.ShowOnlyValidDates = True
                  Properties.ShowTime = False
                  Properties.ValidateOnEnter = False
                  Properties.ValidationOptions = []
                  Style.Font.Charset = DEFAULT_CHARSET
                  Style.Font.Color = clWindowText
                  Style.Font.Height = -11
                  Style.Font.Name = 'Tahoma'
                  Style.Font.Pitch = fpVariable
                  Style.Font.Style = []
                  Style.Font.Quality = fqClearType
                  Style.IsFontAssigned = True
                  StyleFocused.Color = clInfoBk
                  TabOrder = 1
                  Width = 90
                end
                object btnCarregar: TcxButton
                  Left = 242
                  Top = 3
                  Width = 111
                  Height = 23
                  Align = alLeft
                  BiDiMode = bdLeftToRight
                  Caption = '&Carregar'
                  Colors.DefaultText = clBtnText
                  LookAndFeel.Kind = lfUltraFlat
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    6100000023744558745469746C6500436F6E766572743B5265706561743B4172
                    726F773B45786368616E6765762368D20000032A49444154785E6D53694C5467
                    147D8330B21697B20D90B24C0483ED4075001FCB94B1044424D646238B457170
                    196618360B3874405B96010B418AD461699125085202DABA0C830BAB92F00344
                    88C4000D0442F901F8C78926A7EF23F32824BDC9C9FBBE77EE39F7BE7BF32812
                    3FFE194A5DBB1F4A5DEDFA9ACAEB3A44E512741E2294C90F1D21C8BA237A109F
                    EFE345EE0C38D9ADA2751D006A3D541D21D49A7E902224032306C68664CBCC3B
                    C17831A3414167D4FBA45B7E6A9F309E8D81E76C1864B5065344187B55C093D7
                    F84B537EA7DBD36ED3D3A90D011F526FD39859A9C3FCEA7D34F427435E1B301B
                    7DED8B185260C38088132B842149D57E5D37B5E7F078AC18AF175AB0F0EE3146
                    E71A31BEA4C6C06C26746F2FA37B220FDFE47B10A5396BC0892B1408641AFA69
                    EBD0153C99284141CB499C2EDC8FD0741748AB6868DF48F1DBD011486F7AC337
                    DE767EEFD19DF18C8ECB1A6CFBEEBAA0A8FCAF5834F7CA1197BF7F29F0A253B9
                    30D6216CB78B99D3D1DC3DC86A3A80C0447BFD9E48EBF21D2E5C7B22DE3C0393
                    98A2CF47EAFA629150EA8D83124715439A1263D26684920FF7C3564FEC7CCC0E
                    327732C09D0CAC08CF1A708FE4F0F5114A77445CE1635FB88D1B439A19C02526
                    0C2CE863E73D14B7FA91FC6B1FA273BBF4C48435303254B460601D79E1A72F65
                    15DDDA14CD20612D0D2BB38CCE6928286C1F45AD6E12AE5FA58F93DC8D219224
                    6FF1091B89BAF37A76FD90BE7D6401D28A67B073F5E2472695469D5236693234
                    BDCBE50F277052D50647BFC4AACD5B308E5135464B6FF4FC5DA59D826EFA1D9A
                    5FAD20A3660009255AA4302DABFF1843F5F3199C297E007771C6F02ECFC860A2
                    630D4C253FEB70EFD532EE4EAEA2F2E53F281B5842E3F0021E4DADA1AE771619
                    B5FD0853D4C33940DEF3A9D7B7C78966CB16C40965F1C7BE6F9B97D70C43FD74
                    11EA678B0857B44070BCF8E3DEC3B9732EA2B4473CE159E5279F057A3082ED44
                    4C849B67C0E579063988CEDCF8252AAB439FD23C0EF1A526C2BAB16B6357DB31
                    B14AD909655B7FA6505933BB0D734F9124803E5DD91B24A927EC0E57B1927216
                    65523C3A9DB2F75750B6BE72CA76AB018B8D6E4C0C15AD0DE7FF0DD6E05FDF42
                    745F4BE48E490000000049454E44AE426082}
                  OptionsImage.ImageIndex = 16
                  OptionsImage.Images = imglDiversas16
                  ParentBiDiMode = False
                  PopupAlignment = paCenter
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 2
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  OnClick = btnCarregarClick
                end
              end
              object grdExtratoVendas: TcxGrid
                AlignWithMargins = True
                Left = 2
                Top = 56
                Width = 610
                Height = 302
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alClient
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                TabOrder = 0
                LockedStateImageOptions.AssignedValues = [lsiavFont]
                LockedStateImageOptions.Font.Charset = ANSI_CHARSET
                LockedStateImageOptions.Font.Color = clBlack
                LockedStateImageOptions.Font.Height = 14
                LockedStateImageOptions.Font.Name = 'Arial'
                LockedStateImageOptions.Font.Pitch = fpVariable
                LockedStateImageOptions.Font.Style = []
                LockedStateImageOptions.Font.Quality = fqClearType
                LookAndFeel.ScrollbarMode = sbmClassic
                object grdExtratoVendasDBTableView: TcxGridDBTableView
                  DragMode = dmAutomatic
                  Navigator.Buttons.CustomButtons = <>
                  OnCustomDrawCell = grdExtratoVendasDBTableViewCustomDrawCell
                  DataController.KeyFieldNames = 'AUTOINCREM'
                  DataController.Summary.DefaultGroupSummaryItems = <
                    item
                      Format = 'Total: #'
                      Kind = skCount
                      Column = grdExtratoVendasDBTableViewEXT_STATUS
                    end>
                  DataController.Summary.FooterSummaryItems = <
                    item
                      Format = ',0.00;-,0.00'
                      Kind = skSum
                      Column = grdExtratoVendasDBTableViewEXT_VALLIQ
                    end
                    item
                      Format = ',0.00;-,0.00'
                      Kind = skSum
                      Column = grdExtratoVendasDBTableViewEXT_VALTAX
                    end
                    item
                      Format = ',0.00;-,0.00'
                      Kind = skSum
                      Column = grdExtratoVendasDBTableViewEXT_VALBRU
                    end>
                  DataController.Summary.SummaryGroups = <>
                  OptionsBehavior.DragHighlighting = False
                  OptionsBehavior.DragScrolling = False
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsSelection.CellSelect = False
                  OptionsSelection.InvertSelect = False
                  OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
                  OptionsView.Footer = True
                  OptionsView.GroupByBox = False
                  Styles.Content = cxStyle13
                  Styles.Footer = cxStyle13
                  object grdExtratoVendasDBTableViewEXT_STATUS: TcxGridDBColumn
                    DataBinding.FieldName = 'EXT_STATUS'
                    PropertiesClassName = 'TcxImageComboBoxProperties'
                    Properties.Alignment.Horz = taCenter
                    Properties.Images = imglDiversas16
                    Properties.Items = <
                      item
                        Description = 'Com lan'#231'amentos similares'
                        ImageIndex = 2
                        Value = 'S'
                      end
                      item
                        Description = 'Lan'#231'amentos Confirmados'
                        ImageIndex = 0
                        Value = 'R'
                      end
                      item
                        Description = 'Lan'#231'amentos n'#227'o Confirmados'
                        ImageIndex = 1
                        Value = 'N'
                      end
                      item
                        Description = 'Lan'#231'amentos Ignorados'
                        Value = 'I'
                      end
                      item
                        Description = 'Lan'#231'amentos com divergencia na taxa'
                        ImageIndex = 29
                        Value = 'T'
                      end
                      item
                        Description = 'Lan'#231'amentos com divergencia no valor bruto'
                        ImageIndex = 31
                        Value = 'B'
                      end
                      item
                        Description = 'Lan'#231'amentos Confirmados'
                        ImageIndex = 32
                        Value = 'C'
                      end>
                    Properties.ReadOnly = True
                    HeaderAlignmentHorz = taCenter
                    MinWidth = 25
                    Options.Editing = False
                    Options.HorzSizing = False
                    Width = 25
                    IsCaptionAssigned = True
                  end
                  object grdExtratoVendasDBTableViewEXT_NUM_PV: TcxGridDBColumn
                    Caption = 'Estabelecimento'
                    DataBinding.FieldName = 'EXT_NUM_PV'
                    PropertiesClassName = 'TcxTextEditProperties'
                    Properties.Alignment.Horz = taCenter
                    HeaderAlignmentHorz = taCenter
                    Width = 88
                  end
                  object grdExtratoVendasDBTableViewEXT_CODAUT: TcxGridDBColumn
                    Caption = 'Libera'#231#227'o'
                    DataBinding.FieldName = 'EXT_CODAUT'
                    PropertiesClassName = 'TcxTextEditProperties'
                  end
                  object grdExtratoVendasDBTableViewEXT_NUMNSU: TcxGridDBColumn
                    Caption = 'NSU'
                    DataBinding.FieldName = 'EXT_NUMNSU'
                    PropertiesClassName = 'TcxTextEditProperties'
                  end
                  object grdExtratoVendasDBTableViewEXT_PARCEL: TcxGridDBColumn
                    Caption = 'Parcela'
                    DataBinding.FieldName = 'EXT_PARCEL'
                    PropertiesClassName = 'TcxTextEditProperties'
                    Properties.Alignment.Horz = taCenter
                    Properties.AutoSelect = False
                    HeaderAlignmentHorz = taCenter
                  end
                  object grdExtratoVendasDBTableViewEXT_DTAVEN: TcxGridDBColumn
                    Caption = 'Vencimento'
                    DataBinding.FieldName = 'EXT_DTAVEN'
                    PropertiesClassName = 'TcxDateEditProperties'
                    Properties.Alignment.Horz = taCenter
                    HeaderAlignmentHorz = taCenter
                  end
                  object grdExtratoVendasDBTableViewEXT_DTACUP: TcxGridDBColumn
                    Caption = 'Transa'#231#227'o'
                    DataBinding.FieldName = 'EXT_DTACUP'
                    PropertiesClassName = 'TcxDateEditProperties'
                    Properties.Alignment.Horz = taCenter
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                    Width = 92
                  end
                  object grdExtratoVendasDBTableViewEXT_VALBRU: TcxGridDBColumn
                    Caption = 'Vlr. s/ Taxa'
                    DataBinding.FieldName = 'EXT_VALBRU'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.Alignment.Horz = taRightJustify
                    Properties.DisplayFormat = ',0.00;-,0.00'
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                    Width = 94
                  end
                  object grdExtratoVendasDBTableViewAUTOINCREM: TcxGridDBColumn
                    DataBinding.FieldName = 'AUTOINCREM'
                    Visible = False
                    IsCaptionAssigned = True
                  end
                  object grdExtratoVendasDBTableViewEXT_ARQIMP: TcxGridDBColumn
                    DataBinding.FieldName = 'EXT_ARQIMP'
                    Visible = False
                  end
                  object grdExtratoVendasDBTableViewEXT_VALTAX: TcxGridDBColumn
                    Caption = 'Vlr. Taxa'
                    DataBinding.FieldName = 'EXT_VALTAX'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.DisplayFormat = ',0.00;-,0.00'
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                  end
                  object grdExtratoVendasDBTableViewEXT_VALLIQ: TcxGridDBColumn
                    Caption = 'Vlr. Liq.'
                    DataBinding.FieldName = 'EXT_VALLIQ'
                    PropertiesClassName = 'TcxCurrencyEditProperties'
                    Properties.DisplayFormat = ',0.00;-,0.00'
                    HeaderAlignmentHorz = taCenter
                    Options.Editing = False
                  end
                end
                object grdExtratoVendasLevel1: TcxGridLevel
                  GridView = grdExtratoVendasDBTableView
                end
              end
              object Panel3: TPanel
                Left = 3
                Top = 389
                Width = 608
                Height = 32
                Anchors = [akBottom]
                BevelOuter = bvNone
                BorderStyle = bsSingle
                Color = clWhite
                Ctl3D = False
                ParentBackground = False
                ParentCtl3D = False
                TabOrder = 3
                StyleElements = []
                object Image2: TImage
                  Left = 31
                  Top = 6
                  Width = 18
                  Height = 18
                  Center = True
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                    0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                    4D410000B18F0BFC610500000023744558745469746C650043616E63656C3B53
                    746F703B457869743B426172733B526962626F6E3B4C9696B20000039A494441
                    54384F25937F5093751CC7BF08A6D8A4BAD24E625D601B220E866C6DA01E63C6
                    84C12CF8232C4FBD32135046C7717990245E144EEE34032EEE883A301164FCB0
                    84399D79594917C3C680720B04F921C2F66CC006DB91DEBBEFF3F0BD7B3DF7BE
                    CFE7F37E3FDFEF73CF97784CADC473BB8378EF5C257405FE967B44642B2AA87A
                    70A2D0325E5CF48485D57F176A6B0C1F1C14D399204A80C7A4270BC6164203F4
                    AC3180B2DAAACD2B1EFDF413FFECB75FC3DDDE00CFED4E7829EEF646CCD45761
                    ECE409BFF9D8D1523ABB96B28A0BA02B402B97F1868EE799C62BCAE0B9D58EF9
                    EE8B98EBA887ABA506AEE61AB8DBEA30F75323E8CB3071F6730C1CCFFD451329
                    7C810D610382CC1F1EFE66B4BC941A2FC152948FBA70118C999970369E83B3E1
                    1C6E666571354BE1312E68ECCB32FC71F8FDCBD4BB967466654AADB9394F18FD
                    77B857908306D53B30759BD19C53826E75060CE91A4E9BBA7AB99E39FF23B8AE
                    D4C19A9FF7B43E353589983234B5235F9CC4E3DA0AD4F1A3F0C03E05876B09F6
                    51062DDAD31CF7A99E767A316C9BE266A6ABCB3172BA0486B4743DB9B9473D6C
                    3FFA2E46B4FB7143F316FED49D8777E93F38E77DB03D64601B63303BE7C3C2E2
                    32D7336AF662382F1BB623D9B8A14A7B48AE2B54CBFF64A760E8ED1DB01FA25B
                    DEBD1B3DBA0B9871FB304377F2D84D617CF8BDE22B18944ADC3F9086C18C040C
                    6625C1A048592657E549CB96D43730A09661686F22AE49B6C378EA2CDDF2121E
                    391731E5F0529670BD54876BF1DB31902E87758F14FD2A09582F6912CBC77A95
                    2B85AED86D68FBB80C03FF3A3039EB05B3E00333EFC7F88C17FDF659E80B4EA1
                    2B261A9637E3D0AB10A3295636456A85E2EF4D3B64B028C5B8142E8473DA8949
                    C7225C0B7EF45FA8E65809F1C0F1C8C9CDFC9514839F1325A816C47692A2D088
                    5D17A3E29E9A776EC35DA51CB70E1C829F61704F5709A32C9E22E1345B637B77
                    9365E84B8CC60F5BC4C87FF93535FB230557BE22BC7C25722B2CC9B1E84996A2
                    551809932C8E7E1739776656B3B51E851416450CF4915138B349C05E9EF56CC0
                    AAAD6BD66DA8DCB8B9AF294200F32E113525A03F4582BE8428CA167AE6780CAA
                    13D0B75384E6CD029CD9186115AD79964FBD8164A2E03D362430FE19DEA6B2E7
                    F82D551BC2D12E88C01DF1EBE895D240CAAF5477D05A35ED7DF63CFFC7E8D5C1
                    AF524FD0B8761F21EC83132B17837770DD4BAA125E686B7948D8842E840F5D48
                    18CAD7874D16F342DBF607BFA8A1332194C015DF3EF23F759146D7DCAFD62A00
                    00000049454E44AE426082}
                end
                object Label9: TLabel
                  Left = 52
                  Top = 8
                  Width = 83
                  Height = 14
                  Alignment = taCenter
                  Caption = 'N'#227'o Confirmados'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Image3: TImage
                  Left = 148
                  Top = 6
                  Width = 18
                  Height = 18
                  Center = True
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                    0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                    4D410000B18F0BFC610500000026744558745469746C650046696E643B426172
                    733B526962626F6E3B5374616E646172643B536561726368BB659C08000002EE
                    49444154384FA5937B48935118C63FED629A20F44737490A455103B11BCD4B92
                    468C2E68680D5B6EDA6A586EA533B3A576312F9915A25DC8D142ADC4999B6CB5
                    99549465609769B6722B534BB3B5522CA3A9154FEF671905FE51F4C28FEF7CCF
                    73DEF39DF37EEF6100FC17BF87033191984C4C221C89B160BD31FE0CF9B12BEC
                    C37153D2114F59BEDA9056A01DD991A3BA1A25C8F0217D625A7EB5C7BEA27A5D
                    6671FDB0FCB85E27C92CF720DD41965FCBE6318CECF0E8C04992ADBA7BE7C10B
                    98DB7BA1AC6A80E4A06A9874D7CCE2BAA1A6475D78D6F916A7CF5F4372AEBA81
                    F40992FDD56CDE6838C624E42E3F545207EBBB4134345950505205B1FC227B40
                    EFDD8597D1FD6600960E1BCE555E8724EB22E2524E72C8FB751C27FECE53E76B
                    0C2DE8ECEE87E1D613487697202C3A1B8B57A6226A6B312C5DEF61EE78870BB5
                    7790B847017EB2E22CE5B1F5A24F0444CC894FAB18323DB7C2D8D60B95E12104
                    4985085A93850DC23CAC1616C2687E0B53BB0D97AE36439A71063CA9C21E101C
                    339DD21D98B5C2C2F20ACD3DF47FB4E3CBD76F78D665C3DE1C251673D3B16499
                    182B6273D16CB1A26FC08EE191AF309A3AC1131FC1D2D5A9A5B4C02426527462
                    A8C7FA81B6D78A68890A957A13EA6F3E4440780AE6FAAE41E8BA03E826BFACE6
                    312213D528D39AA0D13762E10AA99D167066B8FCA22F9F3E0F812F5343AC7903
                    C17E2D15738076B08B2D22777D522906C9DF90ACC5168D15B1FBF4542B1BFC42
                    4423E44F65C262723A1EB57543A9368227D740A96BC1EDA636F8062574D104F7
                    5582A3E6D6B65750D4B4203A5D87526D2B1AEF3F85E7029E857C17667E88509A
                    7CA002D71B4D78F9BA0F861BCD10A51461B677783A4D70E3705344B28365B871
                    D7841E6B3FEAE87871DBF330CB3B229E7CB6631937AFC018997F68A2D92F741B
                    BC166DB4CCF40A4B237D1A318198E2CF116CF60FDED2ECC349C0BCC0F52DB37C
                    2244A43B13A3BDC0F6BC0BC1FE16776206319518BB0BEC24F67EB09A1BE1FAF3
                    FD47238D77C3FE8571C5BF07CC77AD470A5EC408E8E90000000049454E44AE42
                    6082}
                end
                object Label10: TLabel
                  Left = 169
                  Top = 8
                  Width = 43
                  Height = 14
                  Alignment = taCenter
                  Caption = 'Similares'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label2: TLabel
                  Left = 383
                  Top = 8
                  Width = 97
                  Height = 14
                  Alignment = taCenter
                  Caption = 'Vlr. Taxa Divergente'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Image4: TImage
                  Left = 362
                  Top = 6
                  Width = 18
                  Height = 18
                  Center = True
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                    0000001008060000001FF3FF6100000030744558745469746C6500436C656172
                    3B45726173653B52656D6F76653B426172733B526962626F6E3B466F726D6174
                    74696E673B9B846D96000002F849444154785E8DD27F6855751CC7E1D7399EDD
                    192A4C45A752D46EBADC86CE0C56518B50B73551291D49D0482C98656898CC5F
                    15655941CA656D7369AB2490F5431C543396DBEE8499B8C66D4EE71CFD2189DE
                    9B26F3D7EEB67BCF39DF776C5C68D23F3DF0FEEFCD870F1F3ED6E11F7BC29665
                    3F0D2009014848C2081008617CBF7D7DD9234B2519C6FBF24844FFC7C16F7E13
                    E048627C1CD7F300F8BAB18BC65FCEF15CF102D6AE78180021002C20D5FB0F3B
                    99F400683AD14BED7BAB690A9F47C6D0D2D1C7EA8ACF90846FC01DEB615DACDC
                    40F7F3A563F9BDAC0467748004CB9FCAA562E7779495E673FC641FB587DAD8BC
                    7E19C6082432A74F06B0839F1CB0019D5EB5549E31F0715D9B8C314AB8BE46FD
                    D47A56CB5E0CE958DB590D255CDD8A27141F76D57EEA0F453694EF39BF719D9A
                    8B9F7C1F7000CB763D1F0946121E8DCD67081D6CE6CD978B98989EC68AF210E1
                    9317900C81AE16662ECCDB9955BE967B0B9F78ABE1F1C5BB01C771932E46E01B
                    F1697D33951B9753F868366B5EA9A6A1B6829FDB7B88357ECB1CFF6F32B21FC2
                    BB7E95070A163162077654DF1EB2533710C688F0F7950C0E27194EFABCF6D212
                    7E381E617EAC1B92D7999A3317FFD60002ECB959389123CCC998BACDDAB2FBA8
                    3EDCBE8ADB8349045802C7B10838D0792CCCEC9E5666CE0F4232011269B9F9F4
                    BFB3976B83773877F5AF9055FE7A7DAB6D4F5822401239F366F1E0FDD3E88DC6
                    71666452148812FCB313CB82C0C2C5F4BF5BC5E59B034462576AF6C4A2DB2D20
                    004CE05F81955B1B3ECA5B94F36A3098896B20F7D269F2A743FF07FBB938708D
                    5FA397F6D7DC18D8060CDDF596CFEE6A02B8A764CB51854E5CD1BEF0E5B11CEE
                    8E69D3A62FF4D5BC055A3769F201600A60BF90968ECD38FD672E0098BECE5355
                    1D2D5D245C9F6993605F553B2D518F9A785AFDA1F8602510EF78ACD8DCF13CEE
                    DAE0BEC2B7016C60CAEC8237AAF3D6D4297B6595B28AF66A56C1D6CF810CC02E
                    B56C4AB028C2C292440A33F237E3FB2E377AEB6C201D9898BA8F014646F30CB6
                    F11129FC03F994B9D32092AD6E0000000049454E44AE426082}
                end
                object Image5: TImage
                  Left = 226
                  Top = 6
                  Width = 20
                  Height = 18
                  Center = True
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                    0000001008060000001FF3FF610000000F744558745469746C6500416E616C79
                    7369733BC35957A30000009549444154785E9592C10D80200C45DDC915B87274
                    0546D0BB2736304EE00A5EB9BB53854469E52B5892973484FF280D1D115519B7
                    C5462871D5692F67146196A000838F300B51D2BA19058CAD09E80F1A814F6804
                    12276A0F023BEFF485080E1173D50708705129E88BDB511042C814022F442642
                    AA0EF210F909ABAE031EE4C4025D074E8A5A334001FE03FD0C24AA7F900EB438
                    013E5CBCDC323506DA0000000049454E44AE426082}
                end
                object Label3: TLabel
                  Left = 247
                  Top = 8
                  Width = 100
                  Height = 14
                  Alignment = taCenter
                  Caption = 'Vlr. Bruto Divergente'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Label4: TLabel
                  Left = 511
                  Top = 8
                  Width = 61
                  Height = 14
                  Alignment = taCenter
                  Caption = 'Confirmados'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                end
                object Image6: TImage
                  Left = 493
                  Top = 6
                  Width = 18
                  Height = 18
                  Center = True
                  Picture.Data = {
                    0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                    0000001008060000001FF3FF610000001974455874536F667477617265004164
                    6F626520496D616765526561647971C9653C0000000B744558745469746C6500
                    5461736B3BD380CA7C0000020249444154785E9D914F6B534114C58F347FDAD4
                    45ED2266AB2520342EB208AF7519057551A16627D8859F2156175D772514311F
                    C0168CDA45105D34096D37A5942AC58DD8E09F45160AD56015ED9BBC99B977E4
                    4D1E8F96F740F0C0708799B987DF3D9330C6E0B86AB51ABCBE07D9972F852766
                    8414F0847C25847B434A85E5E5C738AE0402DD7DD4DE20E632D179301863F235
                    A6A61DB8AE8B76AB3D2373570C11E3D6BD2720E2CDE70F6E5F3E61E0375F9ABE
                    808F1B4F218480333568768F5C148B456C6DBD80521A859B55BC7BD329470898
                    08E3E3A7E1380ED6D65A6835DB10D285140A527A504AA152A9E0EB8F2F20A6E8
                    0844068A0DAE96CBC866B3E8743A48269376A55229A4D3699CDDDFC7E7912C58
                    1FC6183041E98173A150B00DDD6ED7AFD6E0A8D1002626F02733164FC03E81E6
                    F0229FCF2393C9A0D7EBE1E7EA2ADCDD5DE41717E1D5F7C0C451034D04A90617
                    EF979670B0BD8D8BF3F3D0EBEBF8B6B28252BD8E534343F0144133C71348A5C3
                    40BFEFEC60737616BECECDCD21572AD9BD5404134740C4F0028242B51A928CE4
                    72282E2C20313C1C1830884D1C0159BC40A1C999C949244647C373A9C9D2C666
                    D01F8C10310914BE63139B01C3931AFF92D28CF80C98D13B38C4FD677B76144F
                    920D4C06BFA388A0C9A0FFEB37D82096A0F9E9ED876BCC6C69C85613EC8DC536
                    FE191B7F3523068D8777AEE33FF4174D5C4C9E43C2773A0000000049454E44AE
                    426082}
                end
              end
              object cxGroupBox5: TcxGroupBox
                AlignWithMargins = True
                Left = 2
                Top = 358
                Margins.Left = 0
                Margins.Top = 0
                Margins.Right = 0
                Margins.Bottom = 30
                Align = alBottom
                PanelStyle.Active = True
                ParentBackground = False
                ParentColor = False
                Style.BorderStyle = ebs3D
                Style.Color = 16770261
                Style.LookAndFeel.Kind = lfUltraFlat
                Style.LookAndFeel.NativeStyle = False
                Style.LookAndFeel.SkinName = 'MoneyTwins'
                StyleDisabled.LookAndFeel.Kind = lfUltraFlat
                StyleDisabled.LookAndFeel.NativeStyle = False
                StyleDisabled.LookAndFeel.SkinName = 'MoneyTwins'
                TabOrder = 4
                Height = 32
                Width = 610
                object btnIncluirLancamento: TcxButton
                  Left = 464
                  Top = 3
                  Width = 143
                  Height = 26
                  Align = alRight
                  BiDiMode = bdLeftToRight
                  Caption = '[F6] Incluir Lan'#231'amento'
                  Colors.DefaultText = clBtnText
                  LookAndFeel.Kind = lfUltraFlat
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.ImageIndex = 16
                  OptionsImage.Images = imglDiversas16
                  ParentBiDiMode = False
                  PopupAlignment = paCenter
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 0
                  TabStop = False
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  OnClick = btnIncluirLancamentoClick
                end
                object btnRecomporLancamento: TcxButton
                  Left = 160
                  Top = 3
                  Width = 175
                  Height = 26
                  Align = alLeft
                  BiDiMode = bdLeftToRight
                  Caption = '[ F12 ] Recompor Lan'#231'amento'
                  Colors.DefaultText = clBtnText
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000001974455874536F6674776172650041646F626520496D616765526561
                    647971C9653C00000013744558745469746C65005461626C653B466F726D6174
                    3BEEACCAE3000002DF49444154785E7591594C935914C72FE2509779124D9CF0
                    60820F46CD1012F5C9C9BC18084A5CDE940132435892D2D216D24CC409189851
                    16037521A89416D3A2109165986929455BB074015A908417DAAF04C24E176861
                    C6C2CBDFFBDD984A66F04B7E39E77E39F777CF3D9794A8C6CCC56A278A554EC8
                    9A9D902AC720691A45D1B3118829F41F5D8F0C1242620190FF42F8E27EF73A0C
                    EE20D4460F1F194A833B9A8B9E3A4005DFEC291036D85991767C15155A178D2B
                    8C728D135AD70AFAA683C87F34CC0BE2F614E42A86A1D07950DC3201A97A0212
                    D56794E310378DA3A6C78D9F1FBCE705823D050AB503E1AD6D04362278FED206
                    FFC647B0BCD50A3F8DA1CD6D543DB57C5D50D3644530BCCD8ADFD938F8D6232C
                    E7E602088423D8FA7707263BC70B0E536229FB192C27FBC8EF4F8630BB18824A
                    FF109EB920061D5EF8A8E0DEAB02CC2C2F617E75136DBD13A86A784B19C0BD27
                    94C746FCF1C8880A45DF2029AF37B113250D29501B6A31E99D6282EB65092850
                    9C47FFD89F6C1DA05D86FED9C13B2B87308DE1AD1DDCADD383DCAE196002595D
                    1614FA74E4D59F416EFD695CBBF31D861644F8557D01152F7230B3B4081FBBA6
                    979F11939456F782C82A7A4D16D73CDA0C1AE4D59E85DD2F86CD2784DD27816E
                    E12ACCCBD9505AAEE097EAEFF1B7AD0B26DB0CBDD20718873D90577681F0D3A5
                    1C8E8D8BF9F654FAA1FB19952750D99D0CEDD40FE8F0FE8876EE22CADA9370EE
                    4602343DAD7C07D1D79196BF067B0ADA1A39992A2089A98298C4144156E22541
                    E765F951348E2621457404B7A4D7313DBBC0AEF0D6CAB118A2331096BEFA22B8
                    2C3F46747337886EF62ADFD581B49278245F3B0E4D772BDB30E55943DB5F93D0
                    748E535CD09BA79127D7EE12941C2569C53CF1BCE0E06FCF33A3A71A2D1CD682
                    1F192FDE38698C609DBE4A8EAC252AD80D13981D1CFCA10856E9A6960E272F88
                    E63432B2C42A26F81FF48BCB2C7C66CA2E52235BAC668599229E66C64F85CDC8
                    102A7133BFD1F409DC5CBF33F286EC240000000049454E44AE426082}
                  OptionsImage.ImageIndex = 16
                  OptionsImage.Images = imglDiversas16
                  ParentBiDiMode = False
                  PopupAlignment = paCenter
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 1
                  TabStop = False
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  OnClick = btnRecomporLancamentoClick
                end
                object btnIgnorarLancamento: TcxButton
                  Left = 3
                  Top = 3
                  Width = 157
                  Height = 26
                  Align = alLeft
                  BiDiMode = bdLeftToRight
                  Caption = '[ F11 ] Ignorar Lan'#231'amento'
                  Colors.DefaultText = clBtnText
                  LookAndFeel.NativeStyle = False
                  LookAndFeel.SkinName = 'MoneyTwins'
                  OptionsImage.Glyph.SourceDPI = 96
                  OptionsImage.Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000002D744558745469746C6500436C69703B52656D6F76653B4572617365
                    3B426172733B526962626F6E3B4375743B536C696365DB9F6A05000002A44944
                    4154785E5D926F48956718C67FCF7BDEB39DDCB4E89F734279449CE06C86B50F
                    4D2DB3F521FA26B20FD634ECFF1CB40F8D10668D40B118FB32FBA8B42FF92D68
                    8C0C561EB5CC4E36B4321966356814C36AD33CD3F33E7FC6FBF070C82EDE1BEE
                    FBE2E1BAAFEBE615C7CE56F6E3896D183018EC67B0B08C9D0DF1951D00E89070
                    EFA45603BE816D071B9A00FB10236C8330A0D1606728CBABE66D74745DDDEA2B
                    A5492DCEF06466140308116E15B8FD0860E8B767B47FDD845307C0F73D94D6F8
                    5A1BA40E504639D7B6324E4020A576B1344AD986882708975B07CA0468A333E1
                    8D13C24D959FAFB5F1A4945C4F3EE4D6D853BE3DB21D25357EA82E651AAD95BB
                    0D9928B87EF8CA2C3B8B020646FE606369018343E336A6D22A8C103A48DB0899
                    8CD83BD8CEF7627844B97AFD019B361472FC640F9D6D7BF03CE11C284DA09C83
                    0C04A08978CB304194BCBC2D5494C5F9FECC05F6EFA92167793686D081C10F55
                    940E589353E02284DB2122DE41C9081313B97C51DBCC2F7DB72829CCA5A2BC98
                    68D4476BD04A23EA8F7D7CCD8B881AFB0FB803C46259D6BA5E28A7F5AB565EBE
                    9AE5F877DD54566D0213652190602008161300EF0259C07BAE7280DCBA7D9D5D
                    9353CFCCF3BFFF3555BB4ECCADCADFFC19B002C876F53E10C31863EBC04F2300
                    DE8EFD1D255FB65F7EB4F76CC29C3C9F34CDDF9C33655B0FB735FED0FF6BC399
                    C462DDA9BE2B3B5ABA0B01517DB4179FA5F03F2CAAE82B2F2D58FF51511EC363
                    7F3235E7BFD8B8BBBEF693E2FC6AC7ED4CFE33FB335013A483C063298C12FEEA
                    C2F85A4EFF78910FE2EB209A95A3B4A878934BA7E5A7802FA52423100E80F96F
                    3EF5FBE8FDBF683C58C7D8F8340BF3F37753AF5F8F2DE152A9711C3202C1A204
                    D0CFA7EF1DBD79633CD1DB73897BC3B707671E8F1E7E3A996C59CADD39040400
                    FF03684A7C5CB62E86940000000049454E44AE426082}
                  OptionsImage.ImageIndex = 16
                  OptionsImage.Images = imglDiversas16
                  ParentBiDiMode = False
                  PopupAlignment = paCenter
                  SpeedButtonOptions.CanBeFocused = False
                  SpeedButtonOptions.Flat = True
                  SpeedButtonOptions.Transparent = True
                  TabOrder = 2
                  TabStop = False
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  Font.Quality = fqClearType
                  ParentFont = False
                  OnClick = btnIgnorarLancamentoClick
                end
              end
            end
          end
        end
        object dxVertContainerDockSite1: TdxVertContainerDockSite
          Left = 624
          Top = 0
          Width = 357
          Height = 432
          ActiveChildIndex = -1
          AllowFloating = True
          OnCanResize = dxVertContainerDockSite1CanResize
          AutoHide = False
          CustomCaptionButtons.Buttons = <>
          DockingType = 3
          OriginalWidth = 357
          OriginalHeight = 140
          object dckpnlPendentes: TdxDockPanel
            Left = 0
            Top = 0
            Width = 357
            Height = 249
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBtnText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ManagerColor = False
            ManagerFont = False
            AllowDock = [dtLeft, dtRight, dtBottom]
            AllowDockClients = [dtBottom]
            AllowFloating = False
            AutoHide = False
            Caption = ' Lan'#231'amentos Pendentes'
            CaptionButtons = [cbHide]
            CustomCaptionButtons.Buttons = <>
            TabsProperties.CustomButtons.Buttons = <>
            DockingType = 2
            OriginalWidth = 357
            OriginalHeight = 249
            object gbPeriodoLanPen: TcxGroupBox
              Left = 0
              Top = 0
              Align = alTop
              PanelStyle.Active = True
              ParentBackground = False
              ParentColor = False
              Style.BorderStyle = ebsNone
              Style.Color = 16770261
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 1
              Height = 33
              Width = 353
              object Label12: TLabel
                AlignWithMargins = True
                Left = 2
                Top = 5
                Width = 47
                Height = 26
                Margins.Left = 0
                Margins.Right = 0
                Align = alLeft
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Per'#237'odo:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ExplicitHeight = 25
              end
              object Label13: TLabel
                AlignWithMargins = True
                Left = 139
                Top = 5
                Width = 15
                Height = 26
                Margins.Left = 0
                Margins.Right = 0
                Align = alLeft
                Alignment = taCenter
                AutoSize = False
                Caption = #224
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ExplicitLeft = 137
                ExplicitTop = 19
                ExplicitHeight = 28
              end
              object mskDtaIniPen: TcxDateEdit
                Tag = 99
                AlignWithMargins = True
                Left = 49
                Top = 5
                Margins.Left = 0
                Margins.Right = 0
                Align = alLeft
                ParentFont = False
                Properties.ButtonGlyph.SourceDPI = 96
                Properties.ButtonGlyph.Data = {
                  424D360400000000000036000000280000001000000010000000010020000000
                  000000000000C40E0000C40E00000000000000000000000000020000000A0000
                  0010000000110000001100000011000000120000001200000012000000120000
                  00120000001300000013000000120000000C000000030000000A81594CC2B47C
                  69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
                  67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
                  F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
                  E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
                  F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
                  83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
                  F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
                  D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
                  F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
                  86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
                  FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
                  D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
                  FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
                  8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
                  FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
                  DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
                  FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
                  91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
                  FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
                  F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
                  ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
                  DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
                  EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
                  DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
                  EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
                  E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
                  C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
                  B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
                  0006000000060000000600000007000000070000000700000007000000070000
                  00070000000800000008000000070000000500000001}
                Properties.ClearKey = 46
                Properties.DateButtons = []
                Properties.MinDate = 2.000000000000000000
                Properties.SaveTime = False
                Properties.ShowTime = False
                Properties.ValidateOnEnter = False
                Properties.ValidationOptions = []
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'Tahoma'
                Style.Font.Style = []
                Style.Font.Quality = fqClearType
                Style.IsFontAssigned = True
                StyleFocused.Color = clInfoBk
                TabOrder = 0
                Width = 90
              end
              object mskDtaFinPen: TcxDateEdit
                Tag = 99
                AlignWithMargins = True
                Left = 154
                Top = 5
                Margins.Left = 0
                Margins.Right = 0
                Align = alLeft
                ParentFont = False
                Properties.ButtonGlyph.SourceDPI = 96
                Properties.ButtonGlyph.Data = {
                  424D360400000000000036000000280000001000000010000000010020000000
                  000000000000C40E0000C40E00000000000000000000000000020000000A0000
                  0010000000110000001100000011000000120000001200000012000000120000
                  00120000001300000013000000120000000C000000030000000A81594CC2B47C
                  69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
                  67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
                  F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
                  E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
                  F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
                  83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
                  F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
                  D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
                  F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
                  86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
                  FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
                  D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
                  FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
                  8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
                  FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
                  DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
                  FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
                  91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
                  FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
                  F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
                  ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
                  DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
                  EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
                  DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
                  EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
                  E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
                  C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
                  B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
                  0006000000060000000600000007000000070000000700000007000000070000
                  00070000000800000008000000070000000500000001}
                Properties.ClearKey = 46
                Properties.DateButtons = []
                Properties.MinDate = 2.000000000000000000
                Properties.SaveTime = False
                Properties.ShowTime = False
                Properties.ValidateOnEnter = False
                Properties.ValidationOptions = []
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'Tahoma'
                Style.Font.Style = []
                Style.Font.Quality = fqClearType
                Style.IsFontAssigned = True
                StyleFocused.Color = clInfoBk
                TabOrder = 1
                Width = 90
              end
              object chkLancSimilares: TcxCheckBox
                AlignWithMargins = True
                Left = 249
                Top = 5
                Margins.Left = 5
                Align = alLeft
                Caption = 'Lan'#231'amentos similares'
                ParentFont = False
                Style.Font.Charset = DEFAULT_CHARSET
                Style.Font.Color = clWindowText
                Style.Font.Height = -11
                Style.Font.Name = 'Tahoma'
                Style.Font.Style = []
                Style.Font.Quality = fqClearType
                Style.IsFontAssigned = True
                TabOrder = 2
                Transparent = True
              end
              object btnPesqPend: TcxButton
                Left = 382
                Top = 2
                Width = 75
                Height = 29
                Align = alLeft
                BiDiMode = bdLeftToRight
                Caption = '&Pesquisar'
                Colors.DefaultText = clBtnText
                LookAndFeel.Kind = lfUltraFlat
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'MoneyTwins'
                OptionsImage.Glyph.SourceDPI = 96
                OptionsImage.Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  6100000023744558745469746C6500436F6E766572743B5265706561743B4172
                  726F773B45786368616E6765762368D20000032A49444154785E6D53694C5467
                  147D8330B21697B20D90B24C0483ED4075001FCB94B1044424D646238B457170
                  196618360B3874405B96010B418AD461699125085202DABA0C830BAB92F00344
                  88C4000D0442F901F8C78926A7EF23F32824BDC9C9FBBE77EE39F7BE7BF32812
                  3FFE194A5DBB1F4A5DEDFA9ACAEB3A44E512741E2294C90F1D21C8BA237A109F
                  EFE345EE0C38D9ADA2751D006A3D541D21D49A7E902224032306C68664CBCC3B
                  C17831A3414167D4FBA45B7E6A9F309E8D81E76C1864B5065344187B55C093D7
                  F84B537EA7DBD36ED3D3A90D011F526FD39859A9C3FCEA7D34F427435E1B301B
                  7DED8B185260C38088132B842149D57E5D37B5E7F078AC18AF175AB0F0EE3146
                  E71A31BEA4C6C06C26746F2FA37B220FDFE47B10A5396BC0892B1408641AFA69
                  EBD0153C99284141CB499C2EDC8FD0741748AB6868DF48F1DBD011486F7AC337
                  DE767EEFD19DF18C8ECB1A6CFBEEBAA0A8FCAF5834F7CA1197BF7F29F0A253B9
                  30D6216CB78B99D3D1DC3DC86A3A80C0447BFD9E48EBF21D2E5C7B22DE3C0393
                  98A2CF47EAFA629150EA8D83124715439A1263D26684920FF7C3564FEC7CCC0E
                  327732C09D0CAC08CF1A708FE4F0F5114A77445CE1635FB88D1B439A19C02526
                  0C2CE863E73D14B7FA91FC6B1FA273BBF4C48435303254B460601D79E1A72F65
                  15DDDA14CD20612D0D2BB38CCE6928286C1F45AD6E12AE5FA58F93DC8D219224
                  6FF1091B89BAF37A76FD90BE7D6401D28A67B073F5E2472695469D5236693234
                  BDCBE50F277052D50647BFC4AACD5B308E5135464B6FF4FC5DA59D826EFA1D9A
                  5FAD20A3660009255AA4302DABFF1843F5F3199C297E007771C6F02ECFC860A2
                  630D4C253FEB70EFD532EE4EAEA2F2E53F281B5842E3F0021E4DADA1AE771619
                  B5FD0853D4C33940DEF3A9D7B7C78966CB16C40965F1C7BE6F9B97D70C43FD74
                  11EA678B0857B44070BCF8E3DEC3B9732EA2B4473CE159E5279F057A3082ED44
                  4C849B67C0E579063988CEDCF8252AAB439FD23C0EF1A526C2BAB16B6357DB31
                  B14AD909655B7FA6505933BB0D734F9124803E5DD91B24A927EC0E57B1927216
                  65523C3A9DB2F75750B6BE72CA76AB018B8D6E4C0C15AD0DE7FF0DD6E05FDF42
                  745F4BE48E490000000049454E44AE426082}
                OptionsImage.ImageIndex = 16
                OptionsImage.Images = imglDiversas16
                ParentBiDiMode = False
                PopupAlignment = paCenter
                SpeedButtonOptions.CanBeFocused = False
                SpeedButtonOptions.Flat = True
                SpeedButtonOptions.Transparent = True
                TabOrder = 3
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                OnClick = btnPesqPendClick
              end
            end
            object gbLancPendenteRodape: TcxGroupBox
              Left = 0
              Top = 191
              Align = alBottom
              PanelStyle.Active = True
              ParentBackground = False
              ParentColor = False
              Style.BorderStyle = ebsNone
              Style.Color = 16770261
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 0
              Height = 30
              Width = 353
              object btnVincular: TcxButton
                Left = 2
                Top = 2
                Width = 143
                Height = 26
                Align = alLeft
                BiDiMode = bdLeftToRight
                Caption = 'Vincular Lan'#231'amentos'
                Colors.DefaultText = clBtnText
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'MoneyTwins'
                OptionsImage.ImageIndex = 16
                OptionsImage.Images = imglDiversas16
                ParentBiDiMode = False
                PopupAlignment = paCenter
                SpeedButtonOptions.CanBeFocused = False
                SpeedButtonOptions.Flat = True
                SpeedButtonOptions.Transparent = True
                TabOrder = 0
                TabStop = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                OnClick = btnVincularClick
              end
              object btnAlterarCartao: TcxButton
                Left = 208
                Top = 2
                Width = 143
                Height = 26
                Align = alRight
                BiDiMode = bdLeftToRight
                Caption = '[F7] Alterar Lan'#231'amento'
                Colors.DefaultText = clBtnText
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'MoneyTwins'
                OptionsImage.ImageIndex = 16
                OptionsImage.Images = imglDiversas16
                ParentBiDiMode = False
                PopupAlignment = paCenter
                SpeedButtonOptions.CanBeFocused = False
                SpeedButtonOptions.Flat = True
                SpeedButtonOptions.Transparent = True
                TabOrder = 1
                TabStop = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                OnClick = btnAlterarCartaoClick
              end
            end
            object cxGrid1: TcxGrid
              AlignWithMargins = True
              Left = 0
              Top = 33
              Width = 353
              Height = 158
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              TabOrder = 2
              LockedStateImageOptions.AssignedValues = [lsiavFont]
              LockedStateImageOptions.Font.Charset = ANSI_CHARSET
              LockedStateImageOptions.Font.Color = clBlack
              LockedStateImageOptions.Font.Height = 14
              LockedStateImageOptions.Font.Name = 'Arial'
              LockedStateImageOptions.Font.Pitch = fpVariable
              LockedStateImageOptions.Font.Style = []
              LockedStateImageOptions.Font.Quality = fqClearType
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxGridDBTableViewMOVCAR: TcxGridDBTableView
                DragMode = dmAutomatic
                Navigator.Buttons.CustomButtons = <>
                OnCustomDrawCell = cxGridDBTableViewMOVCARCustomDrawCell
                DataController.Summary.DefaultGroupSummaryItems = <
                  item
                    Format = 'Total: #'
                    Kind = skCount
                  end>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.DragHighlighting = False
                OptionsBehavior.DragScrolling = False
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsSelection.MultiSelect = True
                OptionsSelection.InvertSelect = False
                OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
                OptionsView.GroupByBox = False
                Styles.Content = cxStyle13
                object cxGridDBTableViewMOVCAR_MCA_NUMCCD: TcxGridDBColumn
                  Caption = 'Libera'#231#227'o'
                  DataBinding.FieldName = 'MCA_NUMCCD'
                end
                object cxGridDBTableViewMOVCAR_MCA_NUMNSU: TcxGridDBColumn
                  Caption = 'NSU'
                  DataBinding.FieldName = 'MCA_NUMNSU'
                end
                object cxGridDBTableViewMOVCAR_MCA_PARCEL: TcxGridDBColumn
                  Caption = 'Parcela'
                  DataBinding.FieldName = 'MCA_PARCEL'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.Alignment.Horz = taCenter
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableViewMOVCAR_MCA_NUMCUP: TcxGridDBColumn
                  Caption = 'Transa'#231#227'o'
                  DataBinding.FieldName = 'MCA_DTACUP'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.Alignment.Horz = taCenter
                  HeaderAlignmentHorz = taCenter
                  Options.Editing = False
                  Width = 92
                end
                object cxGridDBTableViewMOVCAR_MCA_VALSTA: TcxGridDBColumn
                  Caption = 'Vlr. s/ Taxa'
                  DataBinding.FieldName = 'MCA_VALSTA'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.Alignment.Horz = taRightJustify
                  Properties.DisplayFormat = ',0.00;-R$ ,0.00'
                  Options.Editing = False
                  Width = 94
                end
                object cxGridDBTableViewMOVCAR_MCA_VALTAX: TcxGridDBColumn
                  Caption = 'Vlr. Taxa'
                  DataBinding.FieldName = 'MCA_VALTAX'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                end
                object cxGridDBTableViewMOVCAR_MCA_VALDUP: TcxGridDBColumn
                  Caption = 'Vlr. Liq.'
                  DataBinding.FieldName = 'MCA_VALDUP'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                end
              end
              object cxGridLevel1: TcxGridLevel
                GridView = cxGridDBTableViewMOVCAR
              end
            end
          end
          object dckpnlConcil: TdxDockPanel
            Left = 0
            Top = 249
            Width = 357
            Height = 183
            AllowDock = [dtLeft, dtRight, dtBottom]
            AllowDockClients = [dtBottom]
            AllowFloating = False
            AutoHide = False
            Caption = ' Detalhamento dos lan'#231'amentos confirmados'
            CaptionButtons = [cbHide]
            CustomCaptionButtons.Buttons = <>
            TabsProperties.CustomButtons.Buttons = <>
            DockingType = 2
            OriginalWidth = 357
            OriginalHeight = 183
            object gbLanVinculados: TcxGroupBox
              Left = 0
              Top = 125
              Align = alBottom
              PanelStyle.Active = True
              ParentBackground = False
              ParentColor = False
              Style.BorderStyle = ebsNone
              Style.Color = 16770261
              Style.LookAndFeel.NativeStyle = False
              Style.LookAndFeel.SkinName = ''
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleDisabled.LookAndFeel.SkinName = ''
              TabOrder = 0
              Height = 30
              Width = 353
              object btnDesvincular: TcxButton
                Left = 2
                Top = 2
                Width = 159
                Height = 26
                Align = alLeft
                Caption = 'Desvincular Lan'#231'amentos'
                Colors.DefaultText = clBtnText
                LookAndFeel.NativeStyle = False
                LookAndFeel.SkinName = 'Blue'
                OptionsImage.ImageIndex = 15
                OptionsImage.Images = imglDiversas16
                SpeedButtonOptions.CanBeFocused = False
                SpeedButtonOptions.Flat = True
                SpeedButtonOptions.Transparent = True
                TabOrder = 0
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                Font.Quality = fqClearType
                ParentFont = False
                OnClick = btnDesvincularClick
              end
            end
            object cxGrid2: TcxGrid
              AlignWithMargins = True
              Left = 0
              Top = 0
              Width = 353
              Height = 125
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Font.Quality = fqClearType
              ParentFont = False
              TabOrder = 1
              LockedStateImageOptions.AssignedValues = [lsiavFont]
              LockedStateImageOptions.Font.Charset = ANSI_CHARSET
              LockedStateImageOptions.Font.Color = clBlack
              LockedStateImageOptions.Font.Height = 14
              LockedStateImageOptions.Font.Name = 'Arial'
              LockedStateImageOptions.Font.Pitch = fpVariable
              LockedStateImageOptions.Font.Style = []
              LockedStateImageOptions.Font.Quality = fqClearType
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxGridDBTableViewMOVCAR_Confirmado: TcxGridDBTableView
                DragMode = dmAutomatic
                Navigator.Buttons.CustomButtons = <>
                OnCustomDrawCell = cxGridDBTableViewMOVCAR_ConfirmadoCustomDrawCell
                DataController.KeyFieldNames = 'AUTOINCREM'
                DataController.Summary.DefaultGroupSummaryItems = <
                  item
                    Format = 'Total: #'
                    Kind = skCount
                  end>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsBehavior.DragHighlighting = False
                OptionsBehavior.DragScrolling = False
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsSelection.MultiSelect = True
                OptionsSelection.InvertSelect = False
                OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
                OptionsView.GroupByBox = False
                Styles.Content = cxStyle13
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_NUMCCD: TcxGridDBColumn
                  Caption = 'Libera'#231#227'o'
                  DataBinding.FieldName = 'MCA_NUMCCD'
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_NUMNSU: TcxGridDBColumn
                  Caption = 'NSU'
                  DataBinding.FieldName = 'MCA_NUMNSU'
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_PARCEL: TcxGridDBColumn
                  Caption = 'Parcela'
                  DataBinding.FieldName = 'MCA_PARCEL'
                  HeaderAlignmentHorz = taCenter
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_DTACUP: TcxGridDBColumn
                  Caption = 'Transa'#231#227'o'
                  DataBinding.FieldName = 'MCA_DTACUP'
                  PropertiesClassName = 'TcxTextEditProperties'
                  Properties.Alignment.Horz = taCenter
                  HeaderAlignmentHorz = taCenter
                  Options.Editing = False
                  Width = 92
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_VALSTA: TcxGridDBColumn
                  Caption = 'Vlr. s/ Taxa'
                  DataBinding.FieldName = 'MCA_VALSTA'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.Alignment.Horz = taRightJustify
                  Properties.DisplayFormat = ',0.00;-,0.00'
                  Options.Editing = False
                  Width = 94
                end
                object cxGridDBColumn19: TcxGridDBColumn
                  DataBinding.FieldName = 'AUTOINCREM'
                  Visible = False
                  IsCaptionAssigned = True
                end
                object cxGridDBColumn20: TcxGridDBColumn
                  DataBinding.FieldName = 'EXT_ARQIMP'
                  Visible = False
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_VALTAX: TcxGridDBColumn
                  Caption = 'Vlr. Taxa'
                  DataBinding.FieldName = 'MCA_VALTAX'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                end
                object cxGridDBTableViewMOVCAR_Confirmado_MCA_VALDUP: TcxGridDBColumn
                  Caption = 'Vlr. Liq.'
                  DataBinding.FieldName = 'MCA_VALDUP'
                  PropertiesClassName = 'TcxCurrencyEditProperties'
                  Properties.DisplayFormat = ',0.00;-,0.00'
                end
              end
              object cxGridLevel2: TcxGridLevel
                GridView = cxGridDBTableViewMOVCAR_Confirmado
              end
            end
          end
        end
      end
      object grpTotais: TcxGroupBox
        Left = 2
        Top = 434
        Align = alBottom
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.NativeStyle = False
        Style.LookAndFeel.SkinName = 'MoneyTwins'
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleDisabled.LookAndFeel.SkinName = 'MoneyTwins'
        TabOrder = 1
        Height = 34
        Width = 981
        object Panel9: TPanel
          Left = 3
          Top = 3
          Width = 975
          Height = 34
          Align = alTop
          BevelOuter = bvNone
          Color = 9526278
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 0
          StyleElements = []
          object Label7: TLabel
            AlignWithMargins = True
            Left = 70
            Top = 0
            Width = 829
            Height = 34
            Margins.Left = 70
            Margins.Top = 0
            Margins.Right = 0
            Align = alClient
            Alignment = taCenter
            Caption = 'Totais'
            Color = clBackground
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            Font.Quality = fqClearType
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            StyleElements = []
            ExplicitWidth = 39
            ExplicitHeight = 16
          end
          object btnExpand: TcxButton
            AlignWithMargins = True
            Left = 901
            Top = 2
            Width = 72
            Height = 28
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 4
            Align = alRight
            Caption = '&Exibir'
            Colors.Default = clNavy
            Colors.DefaultText = 4381613
            Colors.Normal = clNavy
            Colors.NormalText = 4381613
            Colors.Hot = clNavy
            Colors.HotText = 4381613
            Colors.Pressed = clNavy
            Colors.PressedText = 4381613
            Colors.Disabled = clNavy
            Colors.DisabledText = 4381613
            LookAndFeel.Kind = lfOffice11
            LookAndFeel.NativeStyle = False
            LookAndFeel.SkinName = ''
            OptionsImage.ImageIndex = 25
            OptionsImage.Images = imglDiversas16
            SpeedButtonOptions.CanBeFocused = False
            SpeedButtonOptions.Transparent = True
            TabOrder = 0
            TabStop = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            Font.Quality = fqClearType
            ParentFont = False
            OnClick = btnExpandClick
          end
        end
        object grdTotais: TcxGrid
          Left = 3
          Top = 37
          Width = 975
          Height = 80
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Pitch = fpVariable
          Font.Style = []
          Font.Quality = fqClearType
          ParentFont = False
          TabOrder = 1
          LookAndFeel.NativeStyle = True
          LookAndFeel.SkinName = ''
          object grdTotaisDBBandedTableViewCitelTotalizadorStatus: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            OnCustomDrawCell = grdTotaisDBBandedTableViewCitelTotalizadorStatusCustomDrawCell
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.CellHints = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHidingOnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsCustomize.BandHiding = True
            OptionsCustomize.BandSizing = False
            OptionsCustomize.BandsQuickCustomization = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ScrollBars = ssHorizontal
            OptionsView.GroupByBox = False
            Bands = <
              item
                Caption = 'Confirmados'
                Options.HoldOwnColumnsOnly = True
                Width = 180
              end
              item
                Caption = 'Lan'#231'amentos Similares'
                Options.HoldOwnColumnsOnly = True
                Width = 180
              end
              item
                Caption = 'N'#227'o Confirmados'
                Options.HoldOwnColumnsOnly = True
                Width = 180
              end
              item
                Caption = 'Ignorados'
                Options.HoldOwnColumnsOnly = True
                Width = 180
              end
              item
                Caption = 'Taxa Divergente'
                Width = 180
              end
              item
                Caption = 'Valor Bruto Divergente'
                Width = 180
              end
              item
                Caption = 'Total Extrato'
                Options.HoldOwnColumnsOnly = True
                Width = 180
              end>
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn1: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_ConfirmadoS'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = -1
              Position.ColIndex = -1
              Position.RowIndex = -1
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn2: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_ConfirmadoS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = -1
              Position.ColIndex = -1
              Position.RowIndex = -1
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn3: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_SIMILARES'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = 1
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn4: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_SIMILARES'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = 1
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn5: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_NAO_CONFIRMADOS'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = 2
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn6: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_NAO_CONFIRMADOS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = 2
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn7: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_IGNORADOS'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = 3
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn8: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_IGNORADOS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = 3
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn9: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_EXTRATO'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = 6
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn10: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_EXTRATO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = 6
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn11: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_CONFIRMADOS'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 75
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 75
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn12: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_CONFIRMADOS'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              MinWidth = 105
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.AutoWidthSizable = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 105
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn13: TcxGridDBBandedColumn
              Caption = 'Saldo Final'
              DataBinding.FieldName = 'Saldo_Total'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taCenter
              Properties.ReadOnly = True
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Filtering = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 210
              Position.BandIndex = -1
              Position.ColIndex = -1
              Position.RowIndex = -1
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn14: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_DIV_TAXA'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 75
              Position.BandIndex = 4
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn15: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_DIV_TAXA'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              Width = 105
              Position.BandIndex = 4
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn16: TcxGridDBBandedColumn
              Caption = 'Quantidade'
              DataBinding.FieldName = 'QUANTIDADE_DIV_BRUTO'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 75
              Position.BandIndex = 5
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn17: TcxGridDBBandedColumn
              Caption = 'Total'
              DataBinding.FieldName = 'TOTAL_DIV_BRUTO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              HeaderAlignmentHorz = taCenter
              Width = 105
              Position.BandIndex = 5
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
          end
          object grdTotaisLevel1: TcxGridLevel
            GridView = grdTotaisDBBandedTableViewCitelTotalizadorStatus
          end
        end
      end
    end
    object pnlCaption: TPanel
      Left = 0
      Top = 0
      Width = 994
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Color = 9526278
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 2
      StyleElements = []
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 154
        Height = 19
        Align = alLeft
        Caption = 'Confirma'#231#227'o de cart'#245'es'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
        Layout = tlCenter
        StyleElements = []
        ExplicitHeight = 16
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 264
  end
  object PopupMenu1: TPopupMenu
    Left = 578
    Top = 268
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
    end
    object MenuItem2: TMenuItem
      Caption = 'Iniciar SQL Trace'
    end
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 542
    Top = 332
  end
  object imglDiversas16: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 27000890
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
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          000A000000160000001B000000170000000B0000000200000000000000010000
          00060000000B0000000F0000000C0000000600000001000000000000000F2616
          1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
          1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
          70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
          72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
          D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
          D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
          F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
          F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
          E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
          E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
          A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
          CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
          5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
          CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
          3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
          D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
          1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
          E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
          0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
          C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
          0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
          58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
          0000000000010000000400000006000000050000000200000000000000000000
          0001000000010000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFF7674D8FF3737D1FF3334CDFF3131CBFF2F2FC9FF2B2BC5FF2929
          C4FF2626C2FF2425BFFF2222BCFF2020BBFF1E1EB8FF14147CAD0000000BB079
          66FFFDFBFBFF3C3DD3FFFAF6F6FF3636D0FF3233CCFF3030CAFFF8F2F1FFF7F2
          EFFF6B69D1FF2526C2FFF6EEEBFF2121BCFF1F1FBBFF1D1EB9FF0000000AB37C
          69FFFEFCFBFF3E3ED4FFFBF7F6FF3738D2FF3536D0FF3232CCFFF8F4F2FF2D2E
          C7FFF7F2EFFF2728C2FFF6F0ECFF2223BDFF2121BCFF1E1EB9FF00000009B67F
          6CFFFEFDFCFF4040D7FFFBF8F7FFFBF7F6FF7574DCFF3435CDFFF9F5F2FF2F2F
          CAFFF8F3F0FF292AC4FFF6F1EEFFF6EFECFF2222BDFF2020BBFF00000009B983
          71FFFEFDFCFF4042D9FFFCF8F8FF3C3CD3FFFBF7F6FF3637D0FFFAF5F3FF3030
          CAFFF8F3F1FF2B2BC5FFF7F1EFFF2526C2FF2323BFFF2121BCFF00000008BC88
          77FFFEFEFDFF4243D9FFFBFAF9FFFCF8F8FF7878DFFF3838D2FFFAF7F5FFFAF5
          F4FF706FD7FF2D2EC7FFF8F2F0FFF7F2EFFFF6F0EDFF2222BDFF00000007BF8C
          7AFFFEFEFDFF7F7DE1FF4242D8FF4040D7FF3D3ED4FF3A3AD3FF3737D0FF3435
          CDFF3132CBFF2F2FC9FF2B2CC7FF292AC4FF2727C2FF181982AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
          2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
          66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
          F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
          69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
          F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
          6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
          F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
          71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
          F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
          77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
          F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
          7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
          32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000945D00FF945D00FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000945D00FFC08C00FFC08C00FF945D
          00FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000945D00FFDAA400FFCF9900FFCF9900FFDAA4
          00FF945D00FF0000000000000000000000000000000000000000000000000000
          00000000000000000000945D00FFE8AE00FFE8AE00FFE4AA00FFE4AA00FFE8AE
          00FFE8AE00FF945D00FF00000000000000000000000000000000000000000000
          000000000000945D00FFE9AF00FFE9AF00FFE9AF00FFE9AF00FFE9AF00FFE9AF
          00FFE9AF00FFE9AF00FF945D00FF000000000000000000000000000000000000
          000000000000684100B3945D00FF945D00FF945D00FF945D00FF945D00FF945D
          00FF945D00FF945D00FF684100B3000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000684100B3945D00FF945D00FF945D00FF945D00FF945D00FF945D
          00FF945D00FF945D00FF684100B3000000000000000000000000000000000000
          000000000000945D00FFC79500FFC79500FFC79500FFBB8800FFBB8800FFC795
          00FFC79500FFC79500FF945D00FF000000000000000000000000000000000000
          00000000000000000000945D00FFD49F00FFD49F00FFCA9500FFCA9500FFD49F
          00FFD49F00FF945D00FF00000000000000000000000000000000000000000000
          0000000000000000000000000000945D00FFE1A900FFDEA600FFDEA600FFE1A9
          00FF945D00FF0000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000945D00FFE9AF00FFE9AF00FF945D
          00FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000945D00FF945D00FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
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
          000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
          00000000000100000004000000090000000D0000000F0000000F0000000C0000
          00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
          0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
          1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
          02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
          50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
          3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
          C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
          7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
          88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
          C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
          87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
          F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
          A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
          FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
          A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
          F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
          92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
          D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
          6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
          A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
          84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
          4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
          F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
          020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
          A2FC62504B900404031000000002000000000000000000000000000000000000
          000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
          1F3E000000060000000100000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000060000
          000A0000000A0000000A0000000A0000000B0000000B0000000B0000000B0000
          000B0000000B0000000B0000000B0000000B00000007000000027E5D52BDAF82
          72FFAF8272FFAE8172FFAE8072FFAE8071FFAE8071FFAE8070FFAD8070FFAD7F
          70FFAD7F70FFAC7F6FFFAC7F6FFFAD7E6FFF7C5B4FBE00000007B28577FFFCF8
          F6FFFCF8F5FFFBF7F6FFFBF7F5FFFBF7F5FFFBF7F5FFFBF6F4FFFBF6F4FFFBF6
          F3FFFBF6F3FFFBF6F3FFFAF5F2FFFAF5F2FFAE8072FF0000000AB5897AFFFCF9
          F7FFC59062FFC59062FFC58F61FFC58E60FFC48F60FFC58E60FFC48E5FFFC48D
          5FFFC48D5EFFC48C5EFFC48C5DFFFBF6F3FFB18475FF0000000AB68C7EFFFDFA
          F8FFCD9F75FFECD5B5FFE5C59CFFE5C49CFFE5C39BFFE4C49AFFE4C299FFE5C3
          9AFFE4C298FFE4C298FFC48E5FFFFBF7F5FFB28778FF00000009B98F81FFFDFB
          F9FFCEA178FFCEA177FFCEA077FFCDA077FFCEA077FFCEA077FFCDA076FFCDA0
          76FFCDA075FFCD9F75FFC69062FFFBF7F6FFB58A7CFF00000009BB9385FFFDFB
          FAFFF7F0EBFFF8EFEBFFF8F0EBFFF7EFEBFFF7EFEBFFF7F0EBFFF8EFEBFFF7EF
          EAFFF8EFEAFFF7EFEAFFF8EFEBFFFCF9F7FFB88E7FFF00000008BE9688FFFEFC
          FBFFCA9B6FFFCA9A6EFFCA996DFFCA996DFFCA986BFFC9976BFFC9966AFFC997
          6AFFC89569FFC99568FFC89568FFFCF9F8FFBA9183FF00000007C0998BFFFEFC
          FCFFD2A880FFF1E0C8FFE9CEAAFFE9CEA9FFE8CDA9FFE9CCA8FFE9CCA7FFE8CB
          A6FFE8CBA6FFE8CBA5FFCA976BFFFDFAF9FFBD9587FF00000007C29C8EFFFEFD
          FCFFD2A982FFD3A982FFD2AA82FFD2A981FFD2A881FFD2A881FFD2A981FFD1A8
          80FFD1A880FFD2A780FFCB9A6FFFFDFBFAFFC0978AFF00000006C49E91FFFEFE
          FDFFF9F0EDFFF8F1EDFFF9F0EDFFF9F0EDFFF8F1EDFFF8F0EDFFF8F1ECFFF8F0
          EDFFF8F0ECFFF8F0ECFFF8F0ECFFFDFCFBFFC29B8DFF00000006C6A093FFFFFE
          FEFFD1A77EFFD1A67DFFD1A67CFFD1A57BFFD0A57BFFCFA47AFFCFA379FFCFA2
          78FFCFA177FFCEA176FFCEA176FFFEFCFBFFC49E90FF00000005C7A396FFFFFE
          FEFFD6B18AFFF5E9D6FFEDD8B8FFEDD8B8FFEDD7B7FFECD7B6FFECD6B5FFECD5
          B5FFECD5B5FFECD4B3FFD0A479FFFEFDFCFFC5A093FF00000005C8A497FFFFFF
          FFFFD7B38DFFD7B38CFFD7B28CFFD8B18CFFD7B28BFFD7B28BFFD6B18AFFD7B1
          8AFFD6B18AFFD7B08AFFD1A77EFFFEFDFDFFC7A295FF00000004CAA699FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFEFEFFC8A497FF00000003967C72BECAA7
          9AFFCAA79AFFCAA79AFFCAA79AFFCAA79AFFCAA699FFCAA699FFCAA699FFCAA6
          99FFCAA699FFCAA699FFCAA699FFCAA699FF967B70BF00000002}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000110E282D362D80924F42B9D55C4AD6F6594CD5F54F41
          B9D3352C7E8F100D252A00000000000000000000000000000000000000000000
          000003020708382E83955F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4F
          E0FF5F4FE0FF5F4FDDFE362D7E90030206070000000000000000000000000303
          0809463AA8BF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4F
          E0FF5F4FE0FF5F4FE0FF5F4FE0FF453AA3BA030206070000000000000000392E
          86985F4FE0FFB5BAB3FFC1C6A5FFAFB594FFAFB594FFAFB594FFAFB594FFAFB5
          94FFAFB594FFAFB594FF9697A8FF5F4FE0FF352D7F9100000000120F2A305F4F
          E0FF5F4FE0FFCDD6AFFFE2EBB7FFD4E095FFCAD97DFFCAD97DFFCAD97DFFCAD9
          7DFFCAD97DFFCAD97DFFADB493FF5F4FE0FF5F4FDDFE100D252A382F85975F4F
          E0FF5F4FE0FFCAD3AAFFE1E9B1FFE2E8B0FFD0DB8BFFC8D479FFC8D479FFC8D4
          79FFC8D479FFC8D479FFAAB191FF5F4FE0FF5F4FE0FF352C7E8F5142BFD95F4F
          E0FF5F4FE0FFB4B5C0FFADC145FF9EB428FF9DB427FFBBCA6BFFB6C661FF97AB
          2FFF97AB2FFFA6B947FF8B86C1FF5F4FE0FF5F4FE0FF4F41B9D35B4BDCFA5F4F
          E0FF5F4FE0FF6555DEFFC1D070FF9EB527FF98B117FFD4DEA0FFC2D077FF8196
          0DFF889D19FFB0BE6DFF6151DFFF5F4FE0FF5F4FE0FF594CD5F55B4BDCFA5F4F
          E0FF5F4FE0FF5F4FE0FF8881CEFF7BC1DFFF87B6D5FFA09FC1FF9E9BC1FF7F84
          C9FF827BC4FF7469D1FF5F4FE0FF5F4FE0FF5F4FE0FF5C4AD6F65244C0DB5F4F
          E0FF5F4FE0FF5F4FE0FF5F4FE0FF5F5BE2FF59C5F6FF5C82EAFF5C84EAFF58DA
          FAFF5D79E8FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF4F42B9D5382F86995F4F
          E0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F5BE2FF59C6F6FF59C4F6FF5D6C
          E5FF59CAF7FF5AAFF1FF5E5EE3FF5F4FE0FF5F4FE0FF362D809213102D335F4F
          E0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5E5BE3FF5E59E2FF5F4F
          E0FF5C9CEEFF58E1FBFF5C85EAFF5F4FE0FF5F4FE0FF110E282D000000003A31
          8A9D5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4F
          E0FF5F50E0FF5E6EE6FF5D72E6FF5F4FE0FF382E839500000000000000000403
          090A493CABC35F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4F
          E0FF5F4FE0FF5F4FE0FF5F4FE0FF463AA8BF0302070800000000000000000000
          00000403090A3A318A9D5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4FE0FF5F4F
          E0FF5F4FE0FF5F4FE0FF392E8698030308090000000000000000000000000000
          0000000000000000000013102D33382F86995244C0DB5B4BDCFA5B4BDCFA5142
          BFD9382F8597120F2A3000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000021281230677D389693B450D8ABCD5DF9ABCD5DF994B3
          4ED7667A37942026112E00000000000000000000000000000000000000000000
          000006070309687F3899AFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFACD15FFE667A3794050703080000000000000000000000000607
          030984A048C0AFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFAFD45FFFAFD45FFF829C46BD050603070000000000000000687F
          3899AFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFF647936920000000021281230AFD4
          5FFFAFD45FFFAFD45FFF8B8A63FFA1968BFFA0958AFFA0958BFFA0958AFFA095
          8BFF9E9386FF939E5DFFAFD45FFFAFD45FFFACD15FFE1D23102A687E3897AFD4
          5FFFAFD45FFFAFD45FFF988F7CFFC0B7A9FFC0B6A8FFC0B6A8FFC0B6A8FFBAAF
          A1FFB8AEA0FF8B8C61FFAFD45FFFAFD45FFFAFD45FFF6277358F95B451D9AFD4
          5FFFAFD45FFFAFD45FFF9A927FFFC1B7A9FFC0B6A8FFC0B6A8FFA09588FFAFA8
          A3FFC8C3BFFF958F7BFFAFD45FFFAFD45FFFAFD45FFF91AF4FD3ACD05BFAAFD4
          5FFFAFD45FFFAFD45FFF958D78FFC0B7A9FFC0B6A8FFC0B6A8FF9C9084FFB3AD
          A9FFD8D4D3FF9B9683FFAFD45FFFAFD45FFFAFD45FFFA6CC59F5ACD05BFAAFD4
          5FFFAFD45FFFAFD45FFF9A927FFFC1B7A9FFC0B6A8FFC0B6A8FFC0B6A8FFB0A5
          97FFB4A99DFF88895EFFAFD45FFFAFD45FFFAFD45FFFA9CD5CF695B452DBAFD4
          5FFFAFD45FFFAFD45FFF8B8866FFA69B90FFA89D92FFA59A8FFFA89D92FFA59A
          8FFFA89D90FF8F995DFFAFD45FFFAFD45FFFAFD45FFF91AF4FD5687F3899AFD4
          5FFFAFD45FFFAFD45FFFAED35FFF9BB05AFF828655FF7F8054FF7F8054FF8890
          56FFAACB5EFFAFD45FFFAFD45FFFAFD45FFFAFD45FFF64793692232A1333AFD4
          5FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFABCE5EFF92A259FF756F52FF909D
          58FFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFF1F25112D000000006C83
          3A9DAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFF677D389600000000000000000708
          040A86A149C3AFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFAFD45FFFAFD45FFF829F46BF0607030900000000000000000000
          00000708040A6C833A9DAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD45FFFAFD4
          5FFFAFD45FFFAFD45FFF687F3899060703090000000000000000000000000000
          00000000000000000000222A1332687F389995B452DBACD05BFAACD05BFA96B4
          50DA687E38972128123000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000303030700000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003B362D8B00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000090806186C6655FC09080618000000000000000000000000000000000F0E
          0910504D3156514E3058514E3058514E3058514E3058514E3058514E3058514E
          3058515868A14B77FFFF505968A4504D30593B39234000000000000000009D94
          65B1D6CD9BFFD5CC9CFFD8CF9EFFE6DEA9FFD8CF9EFFD8CF9EFFE5DEA9FFF2EB
          B3FFABB1B1FF4B77FFFFA2A9AAFFEEE7B0FFACA673B80000000000000000B0A4
          40E2DED37CFFE6DD9FFFF2EBB3FFF2EBB3FFDED7A3FFD8CF9EFFD8CF9EFFD8CF
          9EFF9DA1A5FF4B77FFFF969BA0FFEEE7B0FFACA673B80000000000000000C5B1
          1AF2D4BC00FFE2D67FFFD5CC9BFFE6DFAAFFF2EBB3FFF2EBB3FFF2EBB3FFF2EB
          B3FFABB1B1FF4B77FFFFA2A9AAFFEEE7B0FFACA673B80000000000000000C9B5
          19EFD4BC00FFE2D67FFFD7CD9DFFCBC294FFD2C899FFD8CF9EFFD8CF9EFFD8CF
          9EFF9DA1A5FF4B77FFFF8F949BFFEEE7B0FFACA673B80000000000000000C9B5
          19EFD4BC00FFE2D67FFFC1B78BFFE5DDA8FFCBC294FFD8CF9EFFD8CF9EFFD8CF
          9EFF9DA1A5FF4B77FFFF8C9098FFEEE7B0FFACA673B80000000000000000C9B5
          19EFD4BC00FFE2D67FFFD7CE9DFFE8E1ABFFF2EBB3FFF2EBB3FFF2EBB3FFF2EB
          B3FFA6ACAAFF5170D0FF919599FFEEE7B0FFACA673B80000000000000000C9B5
          19EFD4BC00FFD4C974FFD8CF9EFFD8CF9EFFD8CF9EFFE5DEA9FFD8CF9EFFE5DE
          A9FFABB1B1FF4B77FFFF8B9098FFEEE7B0FFACA673B80000000000000000AF9C
          09D0D4BC00FF72692482514E3058514E3058514E3058514E3058514E3058514E
          3058515868A14B77FFFF525B6BC1514E30583B39234000000000000000007466
          008BD4BC00FF352F004000000000000000000000000000000000000000000000
          0000242D4D704B77FFFF363D5AA0000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000242D4D704B77FFFF363D5AA0000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00001E2848624870E5F62E324383000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000001D08
          1D334F16518D4814498048144980481449804814498048144980481449804814
          49804814498048144980481449805016518E1B071B300000000000000000280B
          29484713487F4211447642114476421144764211447642114476421144764211
          447642114476421144764211447649144A81260A274400000000000000000702
          070D5A185CA158185A9E58185A9F59185A9F57175A9D58185A9F58185A9F5717
          5A9D59185A9F58185A9F58185A9E59185A9F0702070C00000000000000000000
          00000F040F1A5B195BA1621862AD601962AB3E113F6E52165293521652933D11
          3F6D5B185EA452145291561756990E040E190000000000000000000000000000
          0000000000002D0C2E50240A25403A103C680000000048144980481449800000
          00003D113E6C2209223D2B0C2C4C000000000000000000000000000000000000
          0000000000002D0C2E50240A25403A103C680000000048144980481449800000
          00003D113E6C2209223D2B0C2C4C000000000000000000000000000000000000
          0000000000002D0C2E50240A25403A103C680000000048144980481449800000
          00003D113E6C2209223D2B0C2C4C000000000000000000000000000000000000
          0000000000003F113F6F350E365F4613487D1A071A2E4614487D4614487D1907
          192C48144A813410365E3C103E6C000000000000000000000000000000001105
          121F6F1F73C85E1A60A75A185BA05F1A5FA955175697502B6EAB4C3477B05517
          56975F1A61A95A185BA05E195FA76F1F73C81004111D00000000000000000000
          00001807192B51155290090209100000000001212C2C0B322847123214490230
          4040000000000602060A4F15508C1A071B2F0000000000000000000000000000
          0000000000000A030A11511552901806182A023041410F1F0030162D00450231
          42420F040F1B521654930D040D17000000000000000000000000000000000000
          0000000000000000000002000203441345792A1D42610A42435B134B376B1A29
          46594C154E880401050800000000000000000000000000000000000000000000
          0000000000000000000000000000000000002F0D305343124477300D31563E11
          406F010001010000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000019071A2D2A0B2B4B0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000003000000080000000C0000
          000E0000000D0000000800000003000000010000000000000000000000020000
          000A00000010000000110000001300000018050E0A3F16412DAC216043EC256A
          48FF216141ED163F2BAC050E09390000000900000001000000000000000A7B50
          43C2AB705CFFAB6F5AFFC29A8CFFA2A191FF307554FF2D9D71FF24BA82FF23CB
          8EFF23BA82FF25986BFF2C7050FD0A1E145C00000006000000000000000EAD73
          5FFFFDFBF9FFFAF4F2FFDCE4DEFF388260FF40C397FF28CD92FF40956DFF487E
          5DFF3F946CFF26CD91FF27BA84FF297150F5050F0A2F000000030000000EB077
          62FFFDFBFAFFF6EFEBFF80AD96FF54B593FF36D29CFF2ECE95FF4A8362FFFFFF
          FFFF4A8161FF2CD096FF2CCF95FF31A87AFF1B4833A1000000060000000CB079
          66FFFDFBFBFFF7F2EFFF499371FF6CDBBBFF469D76FF4D8865FF4D8765FFF6F1
          EBFF4D8665FF4D8664FF459B73FF33C892FF2B7453E7000000080000000BB37C
          69FFFEFCFBFFF8F4F1FF3C926DFF81E9CCFF508C6AFFEADBD3FFF8F3EFFFF9F3
          EFFFF8F3EFFFFFFFFFFF4E8968FF3FD5A3FF348662FA000000080000000AB67F
          6CFFFEFDFCFFF8F3F1FF4FA07DFFB1E9D8FF6CA98CFF528F6EFF528F6DFFFAF5
          F3FF528F6CFF518E6BFF5EA583FF76DCBBFF338260E70000000700000009B983
          71FFFEFDFCFFFAF5F2FF8CC2AAFF94CBB5FFE2FAF5FFC5F5E9FF539371FFECDE
          D8FF539270FFABF0DDFFB0F1DEFF84C6ADFF2358419A0000000400000007BC88
          77FFFEFEFDFFFBF4F0FFE4ECE6FF4EAA84FFC8E7DBFFEEFDFAFF7AB095FF5696
          74FF74AF94FFD9F9F2FFBEE5D8FF3E9873F208130E250000000100000006BF8C
          7AFFFEFEFDFFFBF6F1FFFBF6F4FFC9E2D5FF4FAD85FF93CEB7FFD2ECE3FFF3FC
          FBFFD2ECE3FF92CDB6FF4DA881FF122D2251000000020000000000000005C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFAF7F4FFE5EEE7FF90CAB1FF5BB48FFF46AB
          82FF5BB48EFF8EC9B1FFC9BDB1FF00000008000000000000000000000004C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFBF6F3FFFCF8F6FFFCF7F6FFFCF9
          F7FFFBF8F5FFFCFBFAFFC49587FF00000005000000000000000000000003C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF00000004000000000000000000000002C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000030000000000000000000000019774
          67BECA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927063BF000000020000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000010000
          00060000000A0000000B0000000B0000000B0000000B0000000E0B082C552519
          99EB110A58A70100031F100855A5160C7EEA0603244F00000004000000068057
          4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFE4D4CFFF4235B5FF6F85
          EAFF4150CBFF372DA0FF3B48C9FF5C74E4FF180E82E70000000700000008B57D
          6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFF9F7F6FF7B76CCFF7780
          DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F0000000500000008B67F
          6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD9B18BFFE5D8D0FF4B44
          B9FF6A85EBFF7494F2FF6079E7FF262094E4010104130000000200000008B882
          6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFEDDBCAFF7D77CAFF6B7E
          E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA00000000400000007BA84
          73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAE7FFFF2E6DAFF615FD5FFB1C3
          F6FF8D99EAFF5F5DD2FF8995E7FFA6B8F3FF3B35AEE30000000400000007BB87
          76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFFAF5F3FFCECDEEFF6564
          DEFF9291E2FFF2F1F4FF8982D4FF4340BCE6121233460000000200000006BD8A
          78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA191FFE0C7BDFFEFE4
          E0FFE6D5CEFFFCFAF8FFE4D0CAFF0000000B000000020000000000000006BF8D
          7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
          EEFFF9F1EEFFFDFBF9FFBD8978FF00000008000000000000000000000005C190
          7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
          92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
          81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
          F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
          84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
          96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
          87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
          F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
          8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
          9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
          8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
          74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
          99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000010000
          00060000000A0000000B0000000B0000000B0000000B0000000B0000000C0000
          000C0000000C0000000B00000007000000020000000000000000000000068057
          4CBDB37B69FFB37A68FFB37A68FFB27968FFB27968FFB27A68FFB27968FFB379
          68FFF0E5E2FF659B84FF297758FF1E563EB9000000000000000000000008B57D
          6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF5F2FFFBF5F2FFFBF8F5FFFEFD
          FCFFFFFEFEFF2C7D5EFF2AC592FF2C7C5DFF000000000000000000000008B67F
          6DFFFCF8F5FFD49F70FFD49E6FFFD19D6FFFD29D6EFFD19C6CFFF6ECE3FF6AA4
          8CFF2F8363FF2F8262FF3BCB9DFF2E8061FF2E7F61FF205A45B700000008B882
          6FFFFCF9F6FFDAAC7DFFDBAB7DFFDAAB7CFFDAAB7CFFD9AB7CFFFBF7F2FF338B
          6AFF9BEAD7FF50D2ABFF4DD2A9FF4CD1A8FF48D0A5FF318466FF00000007BA84
          73FFFDF9F8FFDDAF7EFFDDAF7EFFDDAD7EFFDDAD7EFFDBAD7EFFF8F0E7FF69AA
          91FF358E6EFF368E6DFF63D9B6FF348C6CFF348B6BFF26664FBD00000007BB87
          76FFFDFBF9FFF8F1EBFFF8F1ECFFF8F0ECFFF8F1EBFFF8F0EBFFFAF3EFFFFDFA
          F9FFFEFEFDFF389473FF9BEAD7FF379271FF000000000000000000000006BD8A
          78FFFDFBFAFFCDA493FFCCA393FFCCA292FFCCA291FFCBA090FFCBA08FFFCA9F
          8FFFF4EBE8FF6EB39BFF3B9877FF2B6F58BF000000000000000000000006BF8D
          7BFFFEFCFBFFFAF3EEFFFAF2EFFFF9F2EFFFFAF2EEFFF9F2EEFFFAF2EEFFFAF2
          EEFFFAF4F2FFFEFEFDFFF9F3F2FF00000008000000000000000000000005C190
          7EFFFEFDFCFFCEA898FFCEA796FFCEA695FFCDA594FFCDA493FFCCA393FFCCA2
          92FFC39685FFFDFBFAFFBF8D7BFF00000007000000000000000000000005C393
          81FFFEFDFDFFFBF4F2FFFAF5F2FFFAF5F1FFFAF5F1FFFBF5F1FFFBF4F1FFFAF4
          F1FFFAF4F0FFFEFCFBFFC18F7EFF00000007000000000000000000000004C596
          84FFFEFEFEFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA897FFCEA7
          96FFC59B89FFFEFDFCFFC39381FF00000006000000000000000000000004C698
          87FFFFFEFEFFFCF7F5FFFBF6F5FFFBF7F5FFFCF6F4FFFBF7F4FFFBF7F4FFFBF6
          F4FFFBF6F4FFFEFDFDFFC59684FF00000006000000000000000000000003C99B
          8AFFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD9CFFD0AB
          9BFFC89F8FFFFFFEFEFFC79887FF00000005000000000000000000000003CA9E
          8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000029B7F
          74BFD0AB9CFFD0AB9CFFD0AA9CFFD0AA9BFFCFA99BFFCFA99AFFCFA999FFCFA8
          99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000030000
          000B000000110000000B00000002000000000000000000000000000000000000
          00020000000A000000100000000C0000000300000000000000000000000A171D
          50A529328BFF1419459500000010000000020000000000000000000000030000
          0010362A2699685149FF4A3D38AD0000000B00000000000000000000000D2734
          86F15DB8EAFF255EA0FF06082E9C0000001000000002000000030000000F2616
          11A3A28B7FFFE8DAD0FF7B655DFD0000000E000000000000000000000007151D
          468BB8DFF0FF64C4F1FF2B69ABFF060B339B0000001100000010281812A1987E
          72FFE1CDC1FFB8A79EFF43383498000000080000000000000000000000010000
          000B18245397BAE2F2FF6BC9F3FF2F6FB1FF070E389F221510B29A8175FFE2D1
          C4FFBFAFA6FF4A3F399F0000000C000000020000000000000000000000000000
          00010000000B18285797BCE4F3FF74CFF3FF3676B7FF2A2E57FF9E938CFFBFB0
          A8FF4D413B9E0000000B00000002000000000000000000000000000000010000
          000400000009000000151A2E5B9BBDE5F4FF7CD3F5FF3C7FBFFF313B68FF4037
          32AE0000000B0000000200000002000000080000000C00000006000000062B25
          225D6A5A52CC867168FF4D362DEA606E97FFBEE7F5FF85DAF7FF4284C3FF0D1C
          49930000000800000000000000083D322A90796254FF231D195E2C2522589A86
          7CFFD5CAC2FFEEE4DDFFE4D3C9FFDCCCC2FF6E81ABFFBDE7F5FF9FE0F6FF1F44
          9CFA0102041A0000000D16120F418F7B6FFFF9F7F6FF9B806DFF7A6960D6A695
          8BFF927C71FFAC9B91FFEFE6DFFFE4D6CCFF7D6A61EB1A355D893365B4EFE1D3
          CDFF7F6859FF7F6759FF7E6759FF958175FFAF998AFF4E41388B9F8E84F94C43
          407F0000000940363180A19086FFE8DBD2FF8D796FF90000000A0000000DB198
          89FFE8DFD9FFE5DBD5FFF1ECE9FFA78E7DFF1915133600000006000000030000
          000200000002060504147D685DFFDCD1CBFF7B6A62D40000000500000009B59D
          8FFFEAE2DDFFF4EFECFFCABFB7FF4A3E37870000000500000000000000000000
          000000000002382D287F89746CFFB1A098FF37322E58000000053A2F2887AD9E
          95FFF6F3F0FFCCC0B9FF4C403986000000050000000100000000000000000000
          000000000002AC9B92F9887A73C8312C2A4C000000053A2E2786B9AEA7FFFFFF
          FFFFCEC2BBFF4E423A8400000004000000010000000000000000000000000000
          000000000000000000010000000100000001C0A89CFFC0A89CFFC0A89CFFBFA7
          9BFF4F433C820000000300000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000020000
          0002000000010000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001100000011000000110000
          0011000000100000000B00000003000000000000000000000000000000094633
          2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FF593E
          37FF5C4037FF3B2823C20000000A0000000000000000000000000000000D6F53
          47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFF5F44
          3CFF694C42FF553A32FF0000000E0000000000000000000000000000000C7357
          4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FF644A
          41FF72544AFF583D34FF01010116020202100101010B000000030000000B785C
          4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFF6A50
          46FF73554BFF5B4037FF2B201E786C534BFF483832C20101010A0000000A7C60
          50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F56
          4BFF74584EFF5E4339FF352A2678785E55FF664D46FF0101010E000000097F63
          54FFA78E7DFF977A6AFF967969FF957967FF84695CFF785D53FF775C51FF775C
          51FF775A50FF62463CFF362A277780655CFF685048FF0101010E000000088367
          57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF594139FF5840
          37FF795C52FF654A3FFF372C287781665DFF6B534BFF0101010D00000007866A
          59FFAF9788FF674E44FFF3EAE4FFE7D5C8FFE7D4C6FFE6D3C5FFE6D3C5FF5B43
          3AFF7A5F54FF694E42FF382D297682685FFF6E554CFF0101010C00000006886D
          5CFFB39C8CFF6B5248FFF4ECE6FFE9D9CDFFE8D7CAFFE7D5C8FFE6D4C6FF5E46
          3EFF7C6156FF6C5145FF382E2A75846A61FF71584FFF0101010B000000058B70
          5EFFB7A091FF70564DFFF6EFEAFFF5EDE8FFF4ECE6FFF4EBE4FFF3EAE3FF634A
          41FF7E6358FF715549FF3A302B75866C63FF745C52FF0101010A000000036954
          47C08C715FFF755A50FF8D766CFF897369FF856D65FF81695FFF7C645BFF674D
          45FF775B4DFF644E43DC3B312C73876F65FF785F55FF01010109000000010000
          0002000000040000000740362F73514842734B4139744A4038744A3F3874493E
          3774463B35743C322E733D322E72897067FF7A6257FF01010108000000000000
          00000000000000000005967E6EFFBEA99CFFAE9685FFAD9584FFAC9583FFAB92
          83FFAA9182FF947B70FF8C7369FF8B7268FF7F665BFF01010107000000000000
          00000000000000000003725F53C0977F6FFF967D6EFF957C6DFF947A6BFF9279
          6AFF907868FF8E7667FF8C7365FF846B5EFF614E46C100000004000000000000
          0000000000000000000100000002000000040000000400000004000000040000
          0005000000050000000500000005000000050000000300000001}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001100000011000000110000
          001100000011000000100000000B000000030000000000000000000000094633
          2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FFA764
          36FF583D36FF5B3E37FF3B2821C20000000A00000000000000000000000D6F53
          47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFFD4A5
          6AFF5D413AFF684B41FF543931FF0000000E00000000000000000000000C7357
          4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FFF6EE
          E8FF62473FFF715348FF573B33FF0000000F00000000000000000000000B785C
          4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFFF6EF
          EAFF684E44FF72554BFF593E35FF0000000E00000000000000000000000A7C60
          50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFF1F1
          F1FF89756EFF8A7269FF5F443BFF0000000C0000000000000000000000097F63
          54FFA78E7DFF977A6AFF967969FF957967FF84695CFF705548FF8F7B73FF0B67
          37FF295D3CFF81746BFF806C63FF0000000C0000000000000000000000088367
          57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF776761FF0A67
          37FF2AAF7FFF106137FF5B6352FF00000016000000030000000000000007866A
          59FFAF9788FF674E44FFF3EAE4FFE8D9CEFFE9DFD7FFE5DBD5FFD8CFC9FF0B6A
          3BFF4EDCB2FF27C48DFF0C7746FF022E179C000201190000000500000006886D
          5CFFB39C8CFF6B5248FFF4ECE6FFEBE3DCFF47916BFF046B38FF046B38FF056B
          38FF3AD7A5FF37D6A2FF32D3A0FF199966FF044A26D5000D063A000000058B70
          5EFFB7A091FF70564DFFF6EFEAFFEBE4DFFF167E4EFF84EDD1FF52E1B6FF4DDF
          B3FF48DDAFFF44DBACFF3FD9A9FF3AD7A6FF32BE8EFF0F6A3FF6000000048E72
          60FFBBA595FF755A50FFF7F1ECFFF1EEEBFF188252FFB8F7E7FFB4F5E6FFAFF4
          E4FF85EDD2FF52E1B7FF4DDFB3FF5DE2BBFF66D0AEFF16794CF6000000026A56
          49BF8F7361FF795E54FF765D52FFAFA19CFF3B8963FF0D814DFF0D804DFF0D80
          4CFF95F1DAFF65E7C2FF83ECCFFF57B28FFF065932D2010E0832000000010000
          000200000003000000030000000300000005000000090000000C000000140D7B
          4BF2AEF6E5FF94E5CEFF339167FD033A1F910001010F00000003000000000000
          0000000000000000000000000000000000000000000000000000000000070F7F
          4EF287CBB3FF106D42E6011C0F4C000000060000000100000000000000000000
          0000000000000000000000000000000000000000000000000000000000051081
          52F1034B2AAE0007041700000003000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000B07E55FFB07E
          55FFB07E55FFB07E55FFB07E55FFB07E55FFB07E55FFB07E55FFB07E55FFB07E
          55FFB07E55FFB07E55FFB07E55FFB07E55FF0000000000000000B28056FFFFFF
          FEFFFFF8F3FFFFF7F1FFFFF6EEFFFFF5EDFFFFFEFBFF8EAF82FF429B4EFFFFF6
          EBFFFFEFE1FFFFEDE0FFFFF8ECFFB07E55FF0000000000000000B48257FFFFFA
          F6FFFEF2EBFFFEF1E8FFFFF2EAFFFFF1E9FF569051FF96DBA7FF429B4EFFFFF2
          EAFFFFECDFFFFFE9DBFFFFF4E9FFB07E55FF0000000000000000B78458FFFFFB
          F7FFFEF3EDFFFFF9F6FFDCDCC9FF45924BFF9BE5AAFF9FEAADFF5FB26BFF419B
          50FF419B50FF3F994EFF3D974CFF409C50FF4D9F5AFF429B4EFFB98759FFFFFC
          F9FFFFF9F6FF93B38BFF57A663FFACF3BAFF88E293FF79D987FF7CDA8CFF77D5
          88FF6CCE7FFF62C675FF57BF6DFF4EB765FF8CDBA1FF429B4EFFBC895AFFFFFC
          F8FFFFFAF7FF93B48CFF57A662FFACF3BAFF88E395FF7BDC88FF80DD8EFF7AD9
          8AFF70D181FF65C879FF5AC16FFF51B967FF8DDCA2FF429B4EFFBE8B5BFFFFFC
          F8FFFEF5EFFFFFFCFAFFDCDFCFFF45924BFF9DE5ACFFA3EEB1FF61B26DFF449B
          50FF439B51FF429B4EFF3F994EFF429D50FF4D9E58FF429B4EFFC08D5CFFFFFB
          F8FFFEF5EFFFFEF6F0FFFFF8F4FFFFF8F5FF579354FF97DBA7FF429B4EFFFFFB
          FAFFFFF5EDFFFFF2EAFFFFFAF4FFB07E55FF0000000000000000C3905EFFFFFB
          F8FFFEF5EFFFFEF6F0FFFEF6F0FFFFF6F1FFFFFFFFFF8AAD82FF429B4EFFFFF7
          F1FFFEEFE7FFFEEEE3FFFFF4ECFFB07E55FF0000000000000000C5925FFFFFFB
          F8FFFEF5EFFFFEF6F0FFFEF6F0FFFEF6F0FFFEF6F0FFFFFAF6FFFFF8F3FFFEF3
          ECFFFEF2E8FFFEEFE6FFFFF7EEFFB07E55FF0000000000000000C89460FFFFFB
          F8FFFEF5EFFFFEF6F0FFFEF6F0FFFEF6F0FFFEF6F0FFFEF6F0FFFEF5EFFFFEF4
          EEFFFEF3ECFFFEF1E8FFFFF7F2FFB07E55FF0000000000000000CA9661FFFFFC
          FBFFFEF7F2FFFEF7F3FFFEF8F3FFFEF8F4FFFFF8F4FFFFF8F5FFFFF9F5FFFFF8
          F4FFFFF7F3FFFFF5F0FFFFFBF9FFB07E55FF0000000000000000CC9962FFFFFC
          FBFFF7E5CAFFF6E3C7FFF5DDC2FFF4DABDFFF1D5B7FFF2D2B3FFF0D0B1FFF0D1
          B2FFF0CFB1FFF0D0AFFFFFFCFBFFB07E55FF0000000000000000CF9B63FFFFFC
          FBFFEFD4A3FFEDCE9AFFEBC590FFE9BB85FFE5B37CFFE5AC73FFE3A86EFFE4A8
          6EFFE4A96EFFE4A96FFFFFFCFBFFB07E55FF0000000000000000D19D64FFFFFC
          FBFFFFFCFBFFFFFCFBFFFFFCFBFFFFFCFBFFFFFCFBFFFFFCFBFFFFFCFBFFFFFC
          FBFFFFFCFBFFFFFCFBFFFFFCFBFFB07E55FF0000000000000000D4A168FFD19D
          64FFCE9A63FFCB9862FFC89560FFC6925FFFC3905EFFC08D5CFFBD8B5BFFBB88
          5AFFB88558FFB58357FFB28056FFB3835CFF0000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000100000002000000080000000C0000000F0000000F0000000D0000
          0007000000040000000700000007000000020000000000000000000000000000
          0001000000050204031C102F2291184A34D31E5C41FF1E5B40FF184732D2112F
          227D0000000E14382995072C1B95000000090000000100000000000000010000
          00080A1C145722674CE723966DFF23B481FF24CA92FF39CF9DFF37886AFF0C21
          185D06100C392A7B5CFB146744FB020C08370000000400000000000000060D25
          1C652E8867FF28B586FF3BDAA8FF59E0B7FF6FE5C2FF5FC6A6FF1F533FBF0000
          00161E523DBF27B786FF1EB07DFF0C3E28BF0000000C00000001040A08223080
          62F62BBA8BFF42DDADFF65CEADFF53AB8EFF3A8B6EFF2F7D60FA07120D360E24
          1B5D2F9671FF28D59EFF28D59EFF1D805AFF051B125C00000005194434903CAC
          88FF2DDAA5FF5ECFAEFF45987CF914362A750409072002050415010302162B73
          57E12ACC98FF29D8A1FF2AD7A0FF26C592FF145438E00001010F2A7258D438C7
          9BFF30DDA9FF5CB699FF194133810000000700000001000000061941328460B8
          9CFF83ECCFFF2BDAA5FF34DBA8FF88EDD0FF479D7FFF0B2A1C77358C6DF250DF
          B6FF61E8C2FF3F9475FF040A081E00000002000000000205040F36896CF4378F
          70FF419A7BFF30DCA8FF38D7A7FF358A6BFF34886AFF317E61EF3B997AFA98ED
          D8FF8DF1D8FF398E6DFF040B0820000000010000000000000002000000070205
          04193F9675FF43E2B3FF4DDAB1FF1D6749F20000000F0000000734856AD398E1
          CFFF9AF4DEFF57A98BFF11382681000000060000000100000001000000051237
          287659B092FF8BF1D7FF6ECEB2FF1E6047D400000006000000002359478A81CF
          BAFFB4F9EAFF82D3BCFF3A8767FB0E352383030C0823030C08230E3222753D8E
          6EF984DFC7FFAAF6E5FF6FB8A0FF1642328C0000000300000000050D0A1855B2
          95F5A5E5D5FFBCFAEDFF94E5D0FF56A386FF2D7B59FF2D7B59FF54A386FF85D4
          BDFFB5F8EAFF9ADAC9FF419477F5030A0719000000010000000000000002173A
          2F5669C6AAFFAAE7D9FFCBFDF3FFC1FBEFFFBAF9ECFFB8F9EBFFBEFBEEFFC7FC
          F2FFA6E5D5FF5CB096FF12302657000000020000000000000000000000000000
          0002122E264453AB90E38AD7C2FFB2EADDFFCEF9F1FFCEF9F1FFB1EADCFF87D4
          BFFF50A78CE40F29204400000002000000000000000000000000000000000000
          0000000000010409070F255D4C813A9076C849B896FC49B795FC399075C8255B
          4A82030907100000000100000000000000000000000000000000000000000000
          0000000000000000000000000001000000020000000200000002000000020000
          0001000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000001000000020000000400000007000000080000000A0000
          000B0000000B0000000A00000008000000060000000400000002000000000000
          000000000000000000010000000305100C331F5D43FF05100C390F2C20831847
          33CA1E5940F8184833C90F2C2082040C08290000000700000004000000000000
          000000000000000000020000000414392A9A4EA78CFF2A7055FF40977AFF53B7
          99FF60CEAFFF53B799FF41987BFF2C7157FF0817114300000005000000020000
          000400000005000000080000000B26694EFF80DBC0FF62C4A3FF76D7B9FF8CE0
          C9FF9DE8D6FF97E5D1FF83DDC3FF60B397FF34795FFF050D0A25000000060000
          000B0000000F00000012000000152B7055FFADE9D6FF9AE4CDFF99DCC7FF639F
          89FF35785EFF6BA18DFF9DD2C0FFA9E8D4FF6FAC96FF1536297E64483F9BA97A
          6AFFA97A6AFFA87A6AFFA77969FF358063FFD8F6EDFFD3F4EAFFD5F5EBFF98C6
          B5FF368064FF142F256474AC98FFD7F5ECFFB5DCCFFF29634DC7AA7B6BFFFEFD
          FCFFFBF6F4FFFBF6F4FFF9F4F2FF2F5E4CA43C8C6EFF3C8C6EFF3C8C6EFF2352
          41990B19133200000007235241993C8C6EFF2E6C55C816332860AB7D6DFFFBF6
          F4FFE4C191FFE4C191FFF5ECE7FF0605050B0000000700000009000000090000
          0008000000090000000A0000000B0000000B0000000900000006AC7E6FFFFBF6
          F4FFE4C191FFE3C090FFF4EBE6FF1D332973184733C81F5C42FF1236279B0000
          000D05100C391236279C1F5C42FF1F5C42FF1F5C42FF12362799AD8071FFFBF6
          F4FFE4C191FFE3C090FFF4EBE6FF31624CDE64C3ADFF63D2B3FF3C8C71FF0D25
          1B6A226348FF4FA88EFF5CCDABFF55C8A3FF64D3B5FF226247FFAF8273FFFBF6
          F4FFE4C191FFE4C191FFF5ECE7FF809D8DEF66A994FF90E2CCFF6BC2A6FF4693
          77FF2B7055FF469378FF73CFB3FF7BD9BDFF8ADFC8FF26694EFFB08475FFFBF6
          F4FFF7EEE9FFF7EEE9FFF6EDE8FFDADBD3FF428168FF94C4B3FFB7ECDBFFA6E7
          D3FFA0E6D0FFA6E7D3FFB5EBDAFFA8DBCAFFC3EFE1FF2B7055FFB28778FFFBF6
          F4FFE4C191FFE4C191FFF6EDE8FFF5ECE7FFC6D1C6FF4B8F75FF87B9A7FFB4DC
          CEFFD1F2E7FFB4DCCEFF87B9A7FF4B9075FF9AC7B7FF1F4B3A98B58B7DFFFBF6
          F4FFE4C191FFE4C191FFF7EEE9FFF6EDE8FFF6EDE8FFDDDFD7FF9BBDACFF65A1
          88FF418F72FF568B71FF1D4435800B1913303D8C6FFF0B19132FB88F81FFFEFD
          FCFFFBF6F4FFFBF6F4FFFBF6F4FFFBF6F4FFFBF6F4FFFAF5F3FFFAF5F3FFFAF5
          F3FFFCFBFAFFB78E80FF000000030000000100010002000000006E564E97BA92
          84FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA9284FFBA92
          84FFBA9284FF6E564E9700000001000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000030000000B00000013000000190000001A0000
          00140000000B0000000300000000000000000000000000000000000000000000
          000000000000000000060402011C4827118B7C431ED2A65927FFA55927FF7E44
          1ED442230F7B0100000F0000000E000000070000000000000000000000000000
          000000000005120A05348A4F26DDC58A53FFDCB37CFFEFD298FFEFD198FFB676
          43FF2E1A0C62100904398F5127E10E05013A0000000600000000000000000000
          0002040201198D552BDCD1A169FFF1D6A5FFCE9E6EFFC08656FFBD8251FF613A
          1DA6000000227D4B26CBE2B97BFF5F290FCF0101001900000003000000000000
          00074C2F1B82C99765FFECD2A3FFB98154FB5238238A120C07300F0A06270201
          01194C2F1B88CE9D66FFF6DC9BFFBA8657FF3F1C0C910000000D000000000000
          000A8C5B36D0E3C598FFCB9D75FF573B258C0000000C00000003000000062014
          0C43BD875AFBF8E5BCFFF8DFA5FFF7E4BAFFA16540FC1C0E074C000000080000
          0014B37A4BFAF5E6BDFFBC8356FF0D0704300000000C00000003000000079666
          3FD5B87D4DFFBB8153FFF2D9A1FFB87D4DFFB87C4DFF9C6941DE845331D3A263
          3BFFBB8557FFF6E7BFFFBF8B5EFFA06238FF87522FDC00000006000000020000
          000B0D08042FA1653CFFF4DEAEFFB68155FA000000180000000A1F170F34C79D
          75FBFBF5DCFFFCF3CCFFFAF4DAFFB3855FFB21150C4100000004000000020000
          0009492C1886BA8B5EFFE7CEA7FF926B48CB0000000900000000000000045540
          2D77DDC1A2FFFDF7D9FFD4B598FF5037227F0202010C0D08041F110A05274B2D
          1986A1683EFAF3E4C3FFD8B692FF533F2C780000000400000000000000000000
          00058F6F50BCEFE1CDFF886343C20202010D58382091A3693CFFA66F43FFBE94
          6DFFF4E9D1FFE3CAADFFA47E5BD60504030E0000000100000000000000000000
          0001130F0B1DAB8863DA18130E242C1E1248B78B63FDF8F3E2FFF9F3E4FFEDDE
          C7FFDCC1A1FFA3815ED215110C22000000020000000000000000000000000000
          000000000001000000010101000342301E629A7B5CC2C6A078F9C6A078F9997B
          5DC3564634710504030A00000001000000000000000000000000000000000000
          0000000000000000000000000000000000010000000200000002000000020000
          0002000000010000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000705120D39113D2A9E19593EDD1F6A49FF1E6A48FF1B5D
          3EE313422EAB0717104900000009000000020000000000000000000000000000
          000201020210113C299D20724EFF229A6DFF22B481FF2FCC97FF2FCD99FF23B5
          81FF229C6FFF20724FFF154831B5010503190000000300000000000000010102
          020E174E36C0218A61FF25C58EFF26C992FF29CC97FF2EB083FF2DAF82FF2ACC
          95FF27CA93FF25C18BFF218860FF19593CD5020503180000000200000005113C
          2995238A63FF27C993FF26CA94FF27CB95FF3AC79AFF298058FF287D56FF3BC7
          9AFF29CB95FF27CB95FF29CB95FF238F66FF144731AF00000009040F0B2D2176
          53FA2BC693FF29CB95FF2BCC97FF3ED4A6FF197F54FFC3D7CCFFC6DACFFF1A7D
          52FF41D5A6FF2DCE99FF2ACB96FF2DC996FF247C58FF07191147113A288F2DA1
          78FF2ECD98FF32CF9BFF3FD5A7FF2F9E74FF80AD96FFF7F2EDFFF8F1ECFF82AE
          98FF2E9C73FF41D7A8FF35D1A0FF30CF9BFF30A67DFF154933AF195A3ECA35C1
          93FF38D2A2FF3ED5A5FF46C098FF3B7E5CFFF8F6F3FFF7EFEAFFF8F0EBFFF8F6
          F3FF3E7F5EFF47C098FF3FD8A9FF3BD4A4FF36C395FF1C694AE51C6B4AE946D1
          A4FF40D6A8FF53D9B0FF1A6E46FFDDE6E0FFF8F2EEFFF8F4F0FFF9F4F0FFF8F3
          F0FFDDE6E0FF1D6F48FF55D8B1FF43D9AAFF49D5ABFF207853FA1D6B4BE35CD8
          B3FF45D9ACFF27865FFF95AC9BFFE1D4CEFFE1D4CEFFF9F6F3FFFAF7F4FFE2D6
          D1FFE1D5D0FF98AD9DFF26835DFF48DBAFFF62DFBBFF227D59FC195E43C367D0
          B1FF50DEB2FF0C6D40FF0C7042FF0B7244FF0B7444FFFAF8F6FFFBF9F6FF0B73
          43FF0C7042FF0C6D41FF0B6B3DFF52E0B5FF6CD7B7FF1F7050DF113C2B7D5BB7
          98FF61E3BEFF54E1B9FF57E3BCFF5AE4BFFF0C7043FFFBF9F6FFFCFBF9FF0C70
          42FF5DE7BFFF5AE5BFFF58E3BBFF63E4C0FF65C1A5FF164F399E040E0A1F2C89
          67F58CE8CEFF5BE3BDFF5DE5BFFF5FE8C1FF0C6D40FFE3D7D2FFE3D8D4FF0B6B
          3FFF61E9C5FF5FE8C1FF5FE5BFFF91EBD4FF2F9670FC07181236000000021242
          307C4CAE8CFF97F0DAFF67E8C4FF62EAC4FF248A61FF0C693DFF0D683DFF268D
          64FF67EAC8FF6EECC9FF9EF3DCFF52B493FF16543D9A00000005000000000002
          0105195D44A550B393FFA3EDDAFF95F2D9FF86EFD6FF78EED0FF79EFD1FF87F0
          D7FF96F2DDFFA0ECD8FF4CB592FF1C6C4FB80103030C00000001000000000000
          000000000002124633782F9F77F76AC9ACFF89DEC6FFA7EDDBFFA9F0DEFF8CE1
          C9FF6DCEAFFF30A67DF916563F8F010201080000000100000000000000000000
          00000000000000000001040F0B1B144E3A7E207F5FC226926DDA269670DF2185
          63C816543F850617112900000003000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000705120D39113D2A9E19593EDD1F6A49FF1E6A48FF1B5D
          3EE313422EAB0717104900000009000000020000000000000000000000000000
          000201020210113C299D20724EFF229A6DFF22B481FF24C78FFF24C890FF23B5
          81FF229C6FFF20724FFF154831B5010503190000000300000000000000010102
          020E174E36C0218A61FF25C58EFF26C992FF3CD4A6FF45D7ABFF45D7ACFF3CD3
          A3FF27CA93FF25C18BFF218860FF19593CD5020503180000000200000005113C
          2995238A63FF27C993FF26CA94FF27CB95FF1D9967FF0D8450FF0D824EFF1E98
          68FF29CB95FF27CB95FF29CB95FF238F66FF144731AF00000009040F0B2D2176
          53FA2BC693FF29CB95FF2BCC97FF2FCF9BFF0C804EFFFFFFFFFFFFFFFFFF0D7E
          4CFF32D09CFF2DCE99FF2ACB96FF2DC996FF247C58FF07191147113A288F2DA1
          78FF2ECD98FF53DBB2FF59DEB8FF5ADFB8FF0D7F4DFFF5EDE7FFF6EDE7FF0D7D
          4BFF5BE0B9FF5ADFB8FF56DDB6FF30CF9BFF30A67DFF154933AF195A3ECA35C1
          93FF38D2A2FF0C7345FF0C7849FF0D7B4AFF0C7C4BFFF7EFEAFFF8F0EBFF0D7B
          4AFF0C7748FF0C7444FF0C6F43FF3BD4A4FF36C395FF1C694AE51C6B4AE946D1
          A4FF40D6A8FF1E8D62FF99B4A3FFFCFBFBFFFFFFFFFFF8F4F0FFF9F4F0FFFFFF
          FFFFFCFBFBFF9BB7A6FF1F8F63FF43D9AAFF49D5ABFF207853FA1D6B4BE35CD8
          B3FF45D9ACFF46D5A9FF1D774EFFCACAC1FFF8F3EFFFF9F6F3FFFAF7F4FFF9F6
          F2FFCACCC3FF207B52FF47D6ABFF48DBAFFF62DFBBFF227D59FC195E43C367D0
          B1FF50DEB2FF4EDEB3FF42C39BFF3A7B5AFFEBE3DEFFFAF8F6FFFBF9F6FFECE7
          E3FF3D7E5DFF43C49CFF52E0B7FF52E0B5FF6CD7B7FF1F7050DF113C2B7D5BB7
          98FF61E3BEFF54E1B9FF57E3BCFF32A07AFF759983FFF5F2EEFFF6F4F1FF789D
          86FF33A179FF5AE5BFFF58E3BBFF63E4C0FF65C1A5FF164F399E040E0A1F2C89
          67F58CE8CEFF5BE3BDFF5DE5BFFF5EE6BFFF227B56FFB1BCB0FFB4BFB3FF217A
          56FF60E7C3FF5FE8C1FF5FE5BFFF91EBD4FF2F9670FC07181236000000021242
          307C4CAE8CFF97F0DAFF67E8C4FF62EAC4FF5BD7B4FF2B6D4BFF2A6B4AFF5DD9
          B7FF67EAC8FF6EECC9FF9EF3DCFF52B493FF16543D9A00000005000000000002
          0105195D44A550B393FFA3EDDAFF95F2D9FF86EFD6FF50B795FF51B595FF87F0
          D7FF96F2DDFFA0ECD8FF4CB592FF1C6C4FB80103030C00000001000000000000
          000000000002124633782F9F77F76AC9ACFF89DEC6FFA7EDDBFFA9F0DEFF8CE1
          C9FF6DCEAFFF30A67DF916563F8F010201080000000100000000000000000000
          00000000000000000001040F0B1B144E3A7E207F5FC226926DDA269670DF2185
          63C816543F850617112900000003000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000D152E3027419096355BCFD83D68ECF93A67EBF92E57
          CDD71F3B8C9409122C2E00000000000000000000000000000000000000000000
          0000030409092B4492994570F5FF416CF4FF3C69F4FF3C69F3FF3D6AF4FF3D6A
          F3FF3867F3FF3463F2FF1D398D95010308080000000000000000000000000304
          09093658B9C14571F5FF3966F3FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF406DF4FF3362F2FF2246B5BF0103080800000000000000002E47
          94994872F5FF3362F3FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4670F4FF3160F2FF1A368D95000000000F172E304C76
          F6FF3665F2FF2F5FF2FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4A74F5FF426EF5FF2D5DF1FF08102B2E2E4893984671
          F5FF2C5DF1FF2F5FF2FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4A74F5FF4D76F6FF3261F2FF18358C944467D1DA3B68
          F4FF2C5DF1FF2F5FF2FF3261F2FF3766F3FF3866F3FF3D69F3FF406CF4FF416D
          F4FF4671F4FF4772F5FF4A74F5FF4D76F6FF3D6AF3FF234DCAD74B76EFFA3564
          F3FF2C5DF1FF2F5FF2FFA3B8F9FFF5F6FBFF5274D8FFDDE3F5FFD9DFF0FF6387
          F6FFF6F7FCFF9FAFDCFF4A74F5FF4D76F6FF426FF4FF2759E9F94B76EFFA3564
          F3FF2C5DF1FF2F5FF2FFA6BAF9FFF7F8FCFF577BE7FFE0E6F9FFDDE3F5FF6488
          F6FFF9FAFDFFA6B6E8FF4A74F5FF4D76F6FF426FF4FF2759E9F94465D2DB3A68
          F3FF2C5DF1FF2F5FF2FF3362F2FF3967F3FF3866F3FF3D6AF3FF406DF4FF416D
          F4FF4872F4FF4873F5FF4A74F5FF4D76F6FF3D6AF3FF244BCAD82F4794994571
          F5FF2C5DF1FF2F5FF2FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4A74F5FF4D76F6FF3362F2FF19368E960F1830324C76
          F6FF3664F2FF2F5FF2FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4A74F5FF436EF5FF2D5DF1FF08112D30000000002F49
          979D4872F5FF3362F2FF3261F2FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF4772F5FF4671F4FF3161F2FF1B37909800000000000000000305
          0A0A3959BBC34571F5FF3866F3FF3564F3FF3866F3FF3B68F3FF3E6BF4FF416D
          F4FF446FF4FF416DF4FF3462F2FF2448B6C10203090900000000000000000000
          000003050A0A2C46979D4570F5FF406CF4FF3C69F3FF3C69F3FF3D6AF4FF3D6A
          F3FF3967F3FF3463F2FF1D3A9199020309090000000000000000000000000000
          000000000000000000000E16303228419299375DD2DB3D68EDFA3A67ECFA3156
          D0DA203C91980A132E3000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000B0B0B29303030AA1616164300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000B0B0B29424242E8535353FF313131AF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000B0B0B29424242E8535353FF414141EB0C0C0C2D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000B0B
          0B29424242E8535353FF414141EB0C0C0C2E0000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B0B0B294242
          42E8535353FF414141EB0C0C0C2E000000000000000000000000000000000000
          0000000000000303030C1414144E1919195F0D0D0D3101010103464646C35353
          53FF414141EB0C0C0C2E00000000000000000000000000000000000000000000
          000015151550664D2EF2A9691CFFB7701CFF915E22FF453D37CED0D0D0FF4444
          44C40C0C0C2E0000000000000000000000000000000000000000000000000D0D
          0D317A5529FCE98F22FFF6A23CFFF9A743FFF19B33FFCA7A1AFF453D37CE0101
          010300000000000000000000000000000000000000000000000000000000312D
          29A8DD8F30FFFBB156FFFFAF4EFFFFAF4EFFFFAF4EFFF19B33FF915E22FF0D0D
          0D31000000000000000000000000000000000000000000000000000000005643
          2CDBEFAD5DFFFFC175FFFFAF4EFFFFAF4EFFFFAF4EFFF9A743FFB7701CFF1919
          195F000000000000000000000000000000000000000000000000000000004439
          2DC9EDA650FFFFC279FFFFAF4EFFFFAF4EFFFFAF4EFFF6A23CFFA9691CFF1414
          144E000000000000000000000000000000000000000000000000000000001C1C
          1D6DAF6C1BFFF6BB75FFFFCB8BFFFFB75FFFFBAA47FFE98F22FF664D2EF20303
          030C000000000000000000000000000000000000000000000000000000000101
          01053B352CBDAF6C1BFFEB9E40FFEFAD5DFFDA841BFF7A5529FC151515500000
          0000000000000000000000000000000000000000000000000000000000000000
          0000010101051C1C1D6D44392DC956432CDB312D29A80D0D0D31000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00030000000C000000170000001A0000001A0000001B0000001B0000001C0000
          001C000000190000000E00000003000000000000000000000000000000000000
          000C8D5127E2A25B2CFFA0592AFF9D5728FF9C5526FF995424FF985223FF9650
          22FF944E20FF7F431AE400000016000000030000000000000000000000000000
          0013A86031FFCA8850FFC2773CFFBE7339FFB86E36FFB76D33FFBA6E33FFBA6E
          32FFB96D31FF954F21FF4F2910A0000000160000000300000000000000000000
          0014AC6434FFD1905AFFC67D43FFBE733CFFE3CFC2FFCFA78BFFBA6F37FFBE73
          38FFBC7035FF985223FF9A7151FF4F2B109E0000000D00000000000000000000
          0013AE6837FFD69964FFCA834AFFC07740FFEEE4DDFFE4D2C5FFBC723BFFC177
          3EFFC1763BFF9B5526FF968C80FF9F5624FF0000001700000000000000000000
          0012B36A39FFDCA16EFFD08951FFC88149FFC28151FFC6926DFFC99169FFC47B
          42FFC67C41FF9E5829FF9A9085FFA35A26FF0000001800000000000000000000
          0011B56E3CFFE1A978FFD79059FFD08953FFC7875AFFFAF8F7FFE3CCBDFFC57C
          46FFCB8349FFA25C2CFFA0978AFFA55D29FF0000001700000000000000000000
          000FB9703FFFE6B080FFDC9860FFD18A54FFE6D1C2FFFBFAF9FFF4EEEAFFC780
          4AFFD18951FFA65F2FFFA79E93FFA8602DFF0000001600000000000000000000
          000EBC7341FFEAB688FFE09D66FFD18A56FFFBF9F7FFFCFBFBFFF8F5F3FFCC85
          50FFD58F58FFA96232FFAFA69DFFAB6330FF0000001400000000000000000000
          000DBE7543FFEDB98DFFE4A16BFFD6915BFFF3E7E0FFFDFDFDFFECD8CCFFD48F
          5AFFDB975FFFAD6535FFB7AFA5FFAF6632FF0000001300000000000000000000
          000BC07745FFEFBE91FFE8A670FFDE9B66FFDEB191FFF8F0EBFFD89C70FFDF9B
          65FFE09D66FFB06938FFBEB7AFFFB36B37FF0000001200000000000000000000
          000AC17846FFF2C095FFF0BE91FFEBB688FFE4AC7DFFE2A878FFE8AD7DFFE8AF
          7EFFE8AC7AFFB46C3BFFC5BEB7FFB66F3AFF0000001000000000000000000000
          0008C37A48FFC17846FFC17846FFC07745FFBF7644FFBE7543FFBC7342FFBA72
          41FFB9713FFFBC845EFFCBC4BDFFBB713DFF0000000F00000000000000000000
          000464412787E4C0A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFE7E4E1FFCFC9C3FFBD7540FF0000000C00000000000000000000
          00010000000664412787CB834EFFCB834DFFC9814BFFC9814BFFC7804AFFC67E
          49FFC57D48FFC37C47FFC27A45FF5F3C228B0000000600000000000000000000
          0000000000010000000300000006000000070000000800000008000000090000
          00090000000A0000000A00000009000000050000000100000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000020000000900000011000000140000
          00120000000A0000000200000000000000000000000000000000000000000000
          00000000000000000000000000020000000D411F0E9397532BFF914D26FF8C45
          21FF47210F9B0000001000000002000000000000000000000000000000000000
          000000000000000000000000000742221190B17D53FFE1BA86FFE4CA9FFFA761
          32FF99542AFF1E101F9B0000000F000000020000000000000000000000000000
          0000000000000000000000000009AE7247FFE5C18FFFE4BF8DFFE4BF8DFFE7D0
          A5FF9D6E6EFF2D259FFF07073A990000000D0000000200000000000000060000
          000900000009000000090000000F62442D96D0A478FFE7C69AFFE7C495FFB0A6
          BFFFB0B9EEFF463DC7FF302BA6FF0B0A3F950000000C00000002745045BD9F6E
          5FFF9F6E5EFF9E6D5DFFB69286FFC8B1A9FFBD977EFFD4AC82FFBAB2C7FF8493
          E9FF8494EAFFB6C2F0FF4742C9FF3532ADFF0F0E47930000000BAE8272FFFCFA
          F8FFF6EEEAFFF6EEE9FFF6EDEAFFF7F1EEFFF7F5F4FFB6ABBEFF737DD7FF95A5
          EDFF8E9FEDFF8D9EEDFFBCC8F2FF4846CBFF3B3AB5FF13134C8EB28778FFFDFB
          FAFFF7F0ECFFFFFFFFFFF9F6F3FFF7F0EBFFCFB9B1FFBFA69BFF8F8DC3FF7B87
          DBFF9FB0F1FF97AAF1FF97AAF0FFC1CEF5FF5353D1FF393BADFFB68D7EFFFEFC
          FBFFF8F2EEFF895440FFD3BFB6FFFAF6F4FF8D5A47FFF1EBE9FFC3ABA0FFA2A5
          DBFF8290E0FFA9B9F4FFA0B4F3FFA7B9F5FF7D85CDFF15174E88BB9383FFFEFD
          FDFFF9F4F1FFD0B8AEFF8C5743FFD4BFB7FFD8C5BEFF8A5642FFD1BAB0FFF9F6
          F4FF9793C6FF8896E4FFB7C8F7FF7783D5FF1A1E588600000005BE9788FFFEFE
          FEFFFDFBF9FFFFFFFFFFD3BDB4FF8F5C44FFD3BEB6FFFBF9F6FFF9F5F1FFFBF7
          F5FFDBC7C0FF31366B85606BD6FF1F245F830000000400000001C29C8DFFFFFE
          FEFFCAADA0FF9B634CFFCAACA0FFD2BDB2FF905D47FFD4BFB6FFFAF7F4FFFAF6
          F4FFCFB1A7FF0000000700000002000000010000000000000000C6A293FFFFFF
          FFFFA06F56FFF1E9E5FFA26D56FFFBF8F7FFD4BEB4FF946149FFFBF9F6FFFCF8
          F5FFC39E90FF0000000500000000000000000000000000000000CAA899FFFFFF
          FFFFCBAEA1FF9F6850FFCCAEA1FFFDFAF8FFFDFAF8FFFCFAF7FFFCFAF7FFFCFA
          F8FFC7A495FF0000000400000000000000000000000000000000CEAC9EFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCBA89AFF00000004000000000000000000000000000000009D867CBFD4B4
          A6FFD4B4A6FFD3B3A5FFD3B3A4FFD2B2A4FFD1B1A3FFD1B0A1FFD1AFA1FFD0AF
          A0FF9A8176BF0000000200000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000B8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000B8824DFFB882
          4DFF00000000000000001C3F52594FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF1C3F
          5259000000000000000000000000000000000000000000000000B8824DFFB882
          4DFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5
          EAFF1C3F52590000000000000000000000000000000000000000B8824DFFB882
          4DFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5
          EAFF4FB5EAFF4FB5EAFF1C3F5259000000000000000000000000B8824DFFB882
          4DFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5
          EAFF4FB5EAFF4FB5EAFF4FB5EAFF00000000828282FF00000000B8824DFFB882
          4DFF4FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF1C3F52591C3F5259000000000000
          000000000000000000000000000000000000828282FF00000000B8824DFFB882
          4DFF000000001C3F52594FB5EAFF4FB5EAFF4FB5EAFF4FB5EAFF1C3F52595656
          56A6848484FF848484FF848484FF848484FF828282FF00000000B8824DFFB882
          4DFF000000000000000000000000000000000000000000000000000000005656
          56A6848484FF848484FF848484FF848484FF828282FF00000000000000000000
          0000000000000000000000000000828282FF828282FF828282FF828282FF8484
          84FF848484FF848484FF848484FF848484FF828282FF00000000000000000000
          0000000000000000000000000000828282FF848484FF848484FF848484FF8484
          84FF848484FF000000000000000000000000828282FF00000000000000000000
          0000000000000000000000000000828282FF848484FF848484FF848484FF8484
          84FF848484FF000000000000000000000000828282FF00000000000000000000
          0000000000000000000000000000828282FF828282FF828282FF828282FF8282
          82FF828282FF828282FF828282FF828282FF828282FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000828282FF828282FF828282FF828282FF8282
          82FF828282FF828282FF828282FF828282FF828282FF00000000000000000000
          0000000000000000000000000000828282FF828282FF828282FF828282FF8282
          82FF828282FF828282FF828282FF828282FF828282FF00000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000B8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF00000000000000000000
          0000000000000000000000000000000000000000000000000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF97A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF5159
          3F8851593F8897A776FF97A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF000000003C432F660000
          0000000000003C432F6697A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFB8824DFF00000000000000003C43
          2F66464E3777000000005B64479997A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF5159
          3F88282D1F44000000005B64479997A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFB8824DFF0000000051593F880000
          000000000000282D1F4497A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF00000000000000001E21
          183351593F8897A776FF97A776FF97A776FF97A776FF00000000B8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF00000000000000003238
          2755282D1F440000000079865ECC97A776FF97A776FF00000000000000000000
          00000000000000000000000000000000000000000000000000003C432F660000
          00000000000051593F8897A776FF97A776FF97A776FF00000000000000000000
          000000000000000000000000000097A776FF97A776FF97A776FF97A776FF5159
          3F8851593F8897A776FF97A776FF97A776FF97A776FF00000000000000000000
          000000000000000000000000000097A776FF97A776FF97A776FF97A776FF97A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF00000000000000000000
          00000000000000000000000000002E32244D97A776FF97A776FF97A776FF0000
          00000000000097A776FF97A776FF97A776FF2E32244D00000000000000000000
          0000000000000000000000000000000000002E32244D97A776FF97A776FF0000
          00000000000097A776FF97A776FF2E32244D0000000000000000000000000000
          000000000000000000000000000000000000000000002E32244D97A776FF97A7
          76FF97A776FF97A776FF2E32244D000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002E32244D97A7
          76FF97A776FF2E32244D00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000714F3AB79B6A4DFF99684BFF976549FF956346FF946044FF925D42FF915B
          3FFF8F5A3DFF8D583CFF8C563AFF643C28B70000000000000000000000000000
          00009F7153FFC19B71FFCCA777FFC9A270FFC69C69FFC39763FFC0945DFFBE8F
          57FFBB8C52FFBA894EFFAC7946FF8D563AFF0000000000000000000000000000
          0000A17356FFD2B285FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB9884EFF8D573CFF0000000000000000000000000000
          0000A37658FFD6B88CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFBB8C53FF8F5A3DFF0000000000000000000000000000
          0000A6795CFFDABD94FFFFFFFFFFFFFFFFFFFFFFFFFF8B8BD3FFB6B6E4FFFFFF
          FFFFFFFFFFFFFFFFFFFFBE8F57FF915B3FFF0000000000000000000000000000
          0000A97C5EFFDDC29BFFFFFFFFFFFFFFFFFF8B8BD3FF1A1AA9FF3232B2FFF4F4
          FBFFFFFFFFFFFFFFFFFFC1935DFF925E41FF0000000000000000000000000000
          0000AB7F61FFDFC7A2FFFFFFFFFF8B8BD3FF1A1AA9FF1A1AA9FF1A1AA9FF7878
          CAFFF7F7F7FFFFFFFFFFC39863FF936044FF0000000000000000000000000000
          0000AC8263FFE3CCA8FFFFFFFFFF8E8ED5FF5353BEFFC9C9EBFF8585CCFF1C1C
          AAFFC2C2DFFFFFFFFFFFC69D69FF956345FF0000000000000000000000000000
          0000AF8567FFE5D1AEFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4FFD0D0D0FF7A7A
          C0FF3F3FB3FFFCFCFEFFC9A270FF976549FF0000000000000000000000000000
          0000B08869FFE7D5B3FFFFFFFFFFFFFFFFFFDADADAFFBBBBBBFFC2C2C2FFC8C8
          C8FF7676BDFF9999D9FFCCA777FF99684BFF0000000000000000000000000000
          0000B38A6CFFEAD9B8FFFFFFFFFFD3D3D3FFABABABFFB0B0B0FFB5B5B5FFBBBB
          BBFFC2C2C2FF9999D9FFBC9D83FF9C6A4EFF0000000000000000000000000000
          0000B48D6FFFEBDBBDFFBDBDBDFF767474FF6E6D6DFF646764FF5F5E5EFF5858
          58FF535353FFA6A6A6FFAD948CFF9D6E50FF0000000000000000000000000000
          0000B79071FFDFC9ABFF868686FF7D7D7DFFB4B5B4FFAAABAAFFA0A0A0FF9595
          95FF585858FF545353FFC8A57FFFA07053FF0000000000000000000000000000
          0000896C56BDB79071FFB58D6EFFB38B6CFF7D7D7CFFB4B5B4FFAAABAAFF6464
          64FFA87C5EFFA6795BFFA47659FF785540BD0000000000000000000000000000
          0000000000000000000000000000000000005E5B5EB27D7C7DFF747674FF4D4C
          4CB2000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000B8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF00000000000000000000
          0000000000000000000000000000000000000000000000000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF97A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF5159
          3F8851593F8897A776FF97A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF000000003C432F660000
          0000000000003C432F6697A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFB8824DFF00000000000000003C43
          2F66464E3777000000005B64479997A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF0000000097A776FF5159
          3F88282D1F44000000005B64479997A776FF97A776FF00000000B8824DFFFFFF
          FFFFC1C1C1FFC1C1C1FFC1C1C1FFFFFFFFFFB8824DFF0000000051593F880000
          000000000000282D1F4497A776FF97A776FF97A776FF00000000B8824DFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8824DFF00000000000000001E21
          183351593F8897A776FF97A776FF97A776FF97A776FF00000000B8824DFFB882
          4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF00000000000000003238
          2755282D1F440000000079865ECC97A776FF97A776FF00000000000000000000
          00000000000000000000000000000000000000000000000000003C432F660000
          00000000000051593F8897A776FF97A776FF97A776FF00000000000000000000
          000000000000000000000000000097A776FF97A776FF97A776FF97A776FF5159
          3F8851593F8897A776FF97A776FF97A776FF97A776FF00000000000000000000
          000000000000000000000000000097A776FF97A776FF97A776FF97A776FF97A7
          76FF97A776FF97A776FF97A776FF97A776FF97A776FF00000000000000000000
          00000000000000000000000000002E32244D97A776FF97A776FF97A776FF0000
          00000000000097A776FF97A776FF97A776FF2E32244D00000000000000000000
          0000000000000000000000000000000000002E32244D97A776FF97A776FF0000
          00000000000097A776FF97A776FF2E32244D0000000000000000000000000000
          000000000000000000000000000000000000000000002E32244D97A776FF97A7
          76FF97A776FF97A776FF2E32244D000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002E32244D97A7
          76FF97A776FF2E32244D00000000000000000000000000000000}
      end>
  end
  object imglPendentes: TcxImageList
    SourceDPI = 96
    Height = 64
    Width = 64
    FormatVersion = 1
    DesignInfo = 4522240
    ImageInfo = <
      item
        Image.Data = {
          36400000424D3640000000000000360000002800000040000000400000000100
          2000000000000040000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000B17180029555B013D
          7E880151A7B4015DC1D00166D3E3016EE5F70273EDFF0576EFFF0779F0FF0779
          F0FF0779F0FF0779F0FF0779F0FF0678F0FF0678F0FF0678F0FF0678F0FF0678
          F0FF0678EFFF0678EFFF0677EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577F0FF0577F0FF0577F0FF0676F0FF0676F0FF0576F0FF0576F0FF0576
          EFFF0576EFFF0577EFFF0577EFFF0577EFFF0576EFFF0576EFFF0475EEFF0374
          EEFF0270E6F70267D3E3025EC2D00252AAB6023F828B012B585E000B17180000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000070F10013E818B016DE4F60272EDFF0273
          EDFF0273EDFF0273EDFF0273EDFF0475EEFF0679F0FF0779F0FF0779F0FF0779
          F0FF0779F0FF0779F0FF0779F0FF0779F0FF0678F0FF0678F0FF0678F0FF0678
          F0FF0678EFFF0678EFFF0677EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0577F0FF0576F0FF0576F0FF0576F0FF0576EFFF0576
          EFFF0576EFFF0576EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0374EEFF0374EEFF0374EEFF0374EEFF0474EEFF0475EEFF0370E5F60240
          838C000913140000000000000000000000000000000000000000000000000000
          00000000000000000000002044490169DCED0272EDFF0272EDFF0272EDFF0272
          EDFF0272EDFF0273EDFF0677F0FF077AF1FF077AF0FF077AF0FF0779F0FF0779
          F0FF0779F0FF0779F0FF0779F0FF0779F0FF0678F0FF0678F0FF0678F0FF0678
          F0FF0678EFFF0678EFFF0677EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576F0FF0576F0FF0476EFFF0576
          EFFF0576EFFF0576EFFF0576EFFF0576EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0475EFFF0374EEFF0374EEFF0374EEFF0474EEFF0475EEFF0475
          EEFF036CDEED0121454900000000000000000000000000000000000000000000
          00000000000000346C740272EDFF0272EDFF0272EDFF0272EDFF0272EDFF0271
          EDFF0474EEFF0878F1FF0879F1FF0779F1FF0779F0FF0779F0FF0779F0FF0779
          F0FF0779F0FF0779F0FF0779F0FF0779F0FF0678F0FF0678F0FF0678F0FF0678
          F0FF0678EFFF0678EFFF0677EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476
          EFFF0476EFFF0576EFFF0576EFFF0575EFFF0575EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0476EFFF0374EEFF0374EEFF0374EEFF0474EEFF0475
          EEFF0475EEFF0475EFFF01356D74000000000000000000000000000000000000
          0000002B5A610272EDFF0272EDFF0272EDFF0272EDFF0272EDFF0271EDFF0575
          EFFF087AF1FF0879F1FF0879F1FF0879F1FF0779F1FF0779F0FF0779F0FF0779
          F0FF0778F0FF0778F0FF0778F0FF0779F0FF0778F0FF0678F0FF0678F0FF0678
          F0FF0678F0FF0678EFFF0678EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476EEFF0476
          EEFF0476EEFF0476EFFF0476EFFF0575EFFF0575EFFF0575EFFF0575EFFF0576
          EFFF0576EFFF0576EFFF0476EFFF0476EFFF0374EEFF0374EEFF0374EEFF0474
          EEFF0475EEFF0475EEFF0475EFFF012A565C0000000000000000000000000008
          1112016DE3F50272EDFF0272EDFF0272EDFF0272EDFF0272EDFF0576EFFF087B
          F1FF087AF1FF087AF1FF0879F1FF0879F1FF0879F1FF0779F1FF0779F0FF0779
          F0FF0778F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678F0FF0678F0FF0678
          F0FF0678F0FF0678EFFF0678EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476EEFF0476
          EEFF0476EEFF0476EEFF0475EEFF0475EFFF0475EFFF0575EFFF0575EFFF0575
          EFFF0575EFFF0476EFFF0476EFFF0476EFFF0476EFFF0375EEFF0374EEFF0374
          EEFF0474EEFF0475EEFF0475EFFF0371E6F60008101100000000000000000035
          70780272EDFF0272EDFF0272EDFF0272EDFF0272EDFF0677EFFF087BF1FF087A
          F1FF087AF1FF087AF1FF087AF1FF0879F1FF0879F1FF0779F1FF0779F0FF0779
          F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678F0FF0678F0FF0677
          F0FF0677F0FF0677EFFF0677EFFF0677EFFF0577EFFF0577EFFF0577EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476EEFF0476
          EEFF0476EEFF0476EEFF0475EEFF0475EEFF0475EEFF0475EFFF0475EFFF0575
          EFFF0475EFFF0475EFFF0476EFFF0476EFFF0476EFFF0476EFFF0375EEFF0374
          EEFF0374EEFF0475EEFF0475EEFF0475EFFF0137707800000000000204040165
          D3E30272EDFF0272EDFF0272EDFF0271EDFF0677EFFF097BF1FF087AF1FF087A
          F1FF087AF1FF087AF1FF087AF1FF0879F1FF0879F1FF0879F1FF0779F1FF0779
          F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678F0FF0677
          F0FF0677F0FF0677EFFF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0577
          EFFF0577EFFF0577EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476EEFF0476
          EEFF0476EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475
          EFFF0475EFFF0475EFFF0475EFFF0475EFFF0476EFFF0476EFFF0476EFFF0375
          EEFF0374EEFF0374EEFF0475EEFF0475EEFF0368D5E400020404001C3C400272
          EDFF0272EDFF0272EDFF0171EDFF0576EFFF0A7BF1FF097AF1FF087AF1FF087A
          F1FF087AF1FF087AF1FF087AF1FF087AF1FF0879F1FF0879F1FF0879F1FF0779
          F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678F0FF0677
          F0FF0677F0FF0677EFFF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0576EFFF0576EFFF0476EFFF0476EEFF0476EEFF0476
          EEFF0476EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475
          EEFF0375EEFF0375EFFF0375EFFF0475EFFF0475EFFF0475EFFF0476EFFF0476
          EFFF0374EEFF0374EEFF0374EEFF0475EEFF0475EEFF011D3C40003570780272
          EDFF0272EDFF0271EDFF0475EEFF097BF1FF097BF1FF097BF1FF097AF1FF087A
          F1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF0879F1FF0879F1FF0779
          F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678F0FF0678
          F0FF0677F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0575EFFF0575EFFF0475EFFF0475EEFF0475EEFF0476
          EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475EEFF0475
          EEFF0375EEFF0375EEFF0375EEFF0375EFFF0375EFFF0475EFFF0475EFFF0475
          EFFF0475EFFF0374EEFF0374EEFF0374EEFF0475EEFF01377078014EA3B00272
          EDFF0272EDFF0373EEFF097BF2FF097BF2FF097BF1FF097BF1FF097BF1FF097A
          F1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF0879F1FF0879
          F1FF0779F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678
          F0FF0677F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0575EFFF0575EFFF0475EFFF0475EEFF0475EEFF0475
          EEFF0475EEFF0474EEFF0474EEFF0475EEFF0475EEFF0475EEFF0475EEFF0375
          EEFF0375EEFF0375EEFF0375EEFF0375EEFF0375EEFF0375EFFF0375EFFF0475
          EFFF0475EFFF0475EFFF0374EEFF0374EEFF0374EEFF0250A4B00160C8D80272
          EDFF0272EDFF0779F1FF097BF2FF097BF2FF097BF2FF097BF1FF097BF1FF097B
          F1FF097AF1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF0879
          F1FF0879F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778F0FF0778F0FF0678
          F0FF0677F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0575EFFF0475EFFF0475EEFF0475EEFF0475EEFF0475
          EEFF0474EEFF0474EEFF0474EEFF0474EEFF0474EEFF0474EEFF0374EEFF0375
          EEFF0375EEFF0375EEFF0375EEFF0375EEFF0375EEFF0375EEFF0375EEFF0374
          EEFF0374EFFF0474EFFF0474EFFF0374EEFF0374EEFF0262C9D80167D7E80171
          EDFF0576EFFF0A7DF2FF097BF2FF097BF2FF097BF2FF097BF2FF097BF1FF097B
          F1FF097BF1FF097AF1FF087AF1FF087AF1FF087AF1FF087AF1FF087AF1FF0879
          F1FF0879F1FF0779F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778F0FF0678
          F0FF0678F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0576EFFF0575EFFF0475EFFF0475EEFF0475EEFF0475EEFF0475
          EEFF0474EEFF0474EEFF0474EEFF0474EEFF0474EEFF0374EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0374EEFF0375EEFF0375EEFF0375EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0374EFFF0373EEFF0374EEFF0269D8E8016EE6F80373
          EDFF0A7CF2FF0A7CF2FF097CF2FF097CF2FF097BF2FF097BF2FF097BF2FF097B
          F1FF097BF1FF097BF1FF097AF1FF087AF1FF087AF1FF087AF1FF087AF1FF087A
          F1FF0879F1FF0879F1FF0779F1FF0779F0FF0778F0FF0778F0FF0778F0FF0778
          F0FF0678F0FF0677F0FF0677EFFF0677EFFF0677EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0575EFFF0575EFFF0475EFFF0475EEFF0475EEFF0475EEFF0474
          EEFF0474EEFF0474EEFF0474EEFF0474EEFF0374EEFF0374EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0374EEFF0374EEFF0374EEFF0373EEFF0373EEFF0374
          EEFF0374EEFF0374EEFF0374EEFF0374EEFF0273EEFF026FE7F80171EDFF0778
          F0FF0B7DF2FF0A7CF2FF0A7CF2FF0A7CF2FF097CF2FF097BF2FF097BF2FF097B
          F2FF097BF2FF097BF1FF097BF1FF097BF1FF087AF1FF087AF1FF087AF1FF087A
          F1FF087AF1FF0879F1FF0879F1FF0779F0FF0779F0FF0778F0FF0778F0FF0778
          F0FF0678F0FF0677F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0575EFFF0575EFFF0475EEFF0475EEFF0475EEFF0475EEFF0474
          EEFF0474EEFF0474EEFF0474EEFF0374EEFF0374EEFF0374EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0374EEFF0374EEFF0373EEFF0373EEFF0373EEFF0373
          EEFF0373EEFF0373EEFF0373EEFF0374EEFF0273EDFF0273EDFF0374EEFF0A7C
          F2FF0A7CF2FF0A7CF2FF0A7CF2FF0A7CF2FF0A7CF2FF0A7CF2FF097CF2FF097B
          F2FF097BF2FF097BF2FF097BF1FF097BF1FF097BF1FF097AF1FF087AF1FF087A
          F1FF087AF1FF087AF1FF0879F1FF0879F1FF0779F0FF0779F0FF0778F0FF0778
          F0FF0678F0FF0677F0FF0677F0FF0677EFFF0677EFFF0576EFFF0576EFFF0576
          EFFF0576EFFF0575EFFF0475EFFF0475EEFF0475EEFF0475EEFF0474EEFF0474
          EEFF0474EEFF0474EEFF0474EEFF0374EEFF0374EEFF0374EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0373EEFF0373EEFF0373EEFF0373EEFF0373EEFF0373
          EEFF0373EEFF0373EEFF0373EEFF0373EEFF0373EEFF0272EDFF0779F0FF0A7E
          F2FF0A7DF2FF0A7CF2FF097CF2FF097CF2FF097CF2FF097CF2FF097CF2FF097C
          F2FF097BF2FF097BF2FF097BF2FF087BF1FF087BF1FF087BF1FF087AF1FF087A
          F1FF077AF1FF077AF1FF077AF1FF0779F1FF0779F1FF0779F0FF0678F0FF0678
          F0FF0678F0FF0678F0FF0577F0FF0577EFFF0577EFFF0476EFFF0476EFFF0476
          EFFF0476EFFF0475EFFF0475EFFF0375EEFF0375EEFF0375EEFF0374EEFF0374
          EEFF0374EEFF0374EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274
          EEFF0274EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273
          EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0272EDFF0A7DF3FF0A7D
          F2FF0A7DF2FF0A7DF2FF0A7DF2FF097CF2FF097CF2FF097CF2FF097CF2FF097C
          F2FF097CF2FF097CF2FF097BF2FF087BF2FF087BF1FF087BF1FF087BF1FF087A
          F1FF087AF1FF077AF1FF077AF1FF0779F1FF0779F1FF0779F0FF0679F0FF0678
          F0FF0678F0FF0578F0FF0577F0FF0577EFFF0577EFFF0476EFFF0476EFFF0476
          EFFF0476EFFF0475EFFF0375EEFF0375EEFF0375EEFF0374EEFF0374EEFF0374
          EEFF0374EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274
          EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273EEFF0273
          EEFF0273EEFF0273EEFF0272EEFF0272EEFF0272EEFF0272EEFF0A7DF3FF0A7D
          F3FF0A7DF3FF0A7DF2FF0A7DF2FF0A7DF2FF0A7DF2FF097CF2FF097CF2FF097C
          F2FF097CF2FF097CF2FF097CF2FF097BF2FF097BF2FF087BF2FF087BF1FF087B
          F1FF087AF1FF087AF1FF077AF1FF077AF1FF0779F1FF0779F1FF0679F0FF0678
          F0FF0678F0FF0678F0FF0577F0FF0577EFFF0577EFFF0476EFFF0476EFFF0476
          EFFF0475EFFF0475EFFF0375EEFF0375EEFF0375EEFF0374EEFF0374EEFF0374
          EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274EEFF0274EEFF0273EEFF0273
          EEFF0273EEFF0273EEFF0272EEFF0272EEFF0272EEFF0272EEFF0272EEFF0272
          EEFF0272EEFF0272EEFF0272EEFF0272EEFF0272EDFF0272EDFF0A7DF3FF0A7D
          F3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF2FF0A7DF2FF0A7DF2FF0A7DF2FF097C
          F2FF097CF2FF097CF2FF097CF2FF097CF2FF097CF2FF097BF2FF087BF2FF087B
          F1FF087BF1FF087AF1FF087AF1FF077AF1FF077AF1FF0779F1FF0779F1FF0679
          F0FF0678F0FF0678F0FF0578F0FF0577F0FF0577EFFF0476EFFF0476EFFF0476
          EFFF0475EFFF0475EFFF0375EEFF0375EEFF0374EEFF0374EEFF0374EEFF0274
          EEFF0274EEFF0274EEFF0273EEFF0274EEFF0274EEFF0272EEFF0274EEFF0273
          EEFF0273EEFF0274EEFF0273EEFF0272EEFF0274EEFF0274EEFF0273EEFF0272
          EEFF0272EEFF0272EEFF0272EDFF0272EDFF0272EDFF0272EDFF0A7EF3FF0A7E
          F3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF2FF0A7D
          F2FF0A7DF2FF097CF2FF097CF2FF097CF2FF097CF2FF097CF2FF097BF2FF097B
          F2FF087BF1FF087BF1FF087AF1FF087AF1FF077AF1FF077AF1FF0779F1FF0779
          F0FF0678F0FF0678F0FF0578F0FF0577F0FF0577EFFF0476EFFF0476EFFF0476
          EFFF0475EFFF0375EEFF0375EEFF0374EEFF0373EEFF0373EEFF0373EEFF0273
          EEFF0273EEFF0273EEFF0274EEFF026FEEFF026CEDFF0273EEFF0269EDFF026C
          EDFF026CEDFF0268EDFF026BEDFF0271EEFF0269EDFF0268EDFF026DEDFF0272
          EEFF0272EDFF0272EDFF0272EDFF0272EDFF0172EDFF0171EDFF0B7EF3FF0B7E
          F3FF0A7EF3FF0A7EF3FF0A7EF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7D
          F3FF0A7DF2FF0A7DF2FF0A7DF2FF097CF2FF097CF2FF097CF2FF097CF2FF097C
          F2FF097BF2FF087BF2FF087BF1FF087AF1FF087AF1FF077AF1FF0779F1FF0779
          F1FF0679F0FF0678F0FF0678F0FF0577F0FF0576EFFF0475EFFF0475EFFF0475
          EFFF0474EFFF0374EEFF0374EEFF0373EEFF0373EEFF0373EEFF0273EEFF0273
          EEFF0273EEFF0274EEFF026FEEFF0283F0FF0292F2FF026DEDFF01A3F4FF0292
          F2FF0292F2FF01A8F5FF0295F2FF0275EEFF01A3F4FF01A4F4FF028FF1FF0270
          EDFF0272EDFF0272EDFF0272EDFF0172EDFF0171EDFF0270EDFF0B7EF3FF0B7E
          F3FF0B7EF3FF0B7EF3FF0B7EF3FF0A7EF3FF0A7EF3FF0A7EF3FF0A7DF3FF0A7D
          F3FF0A7DF3FF0A7DF3FF0A7DF2FF0A7DF2FF0A7DF2FF097CF2FF097CF2FF097C
          F2FF097CF2FF097BF2FF087BF2FF087AF1FF087AF1FF087AF1FF0779F1FF0779
          F1FF0778F0FF0678F0FF0677F0FF0577F0FF0576EFFF0475EFFF0475EFFF0475
          EFFF0474EFFF0374EEFF0374EEFF0373EEFF0373EEFF0273EEFF0273EEFF0273
          EEFF0273EEFF0274EEFF0267EDFF01A7F4FF01D0F9FF028AF1FF00ECFDFF019F
          F4FF00EAFDFF01AAF5FF00E1FBFF01ADF5FF00DDFBFF01C3F7FF00DDFBFF0269
          ECFF0274EDFF0272EDFF0172ECFF0171ECFF0270ECFF026FECFF0B7EF3FF0B7E
          F3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0A80F3FF0A80
          F3FF0A7EF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7CF2FF0A7CF2FF0A7CF2FF097C
          F2FF097BF2FF097BF2FF097BF2FF097BF2FF087AF1FF087AF1FF0879F1FF0779
          F1FF0779F1FF0678F0FF0677F0FF0577F0FF0576EFFF0475EFFF0475EFFF0474
          EFFF0374EEFF0374EEFF0373EEFF0373EEFF0273EEFF0273EEFF0273EEFF0273
          EEFF0272EEFF0274EEFF0268EDFF01A4F4FF01C6F8FF0292F2FF01C7F8FF025E
          EBFF01B8F6FF01B6F6FF01D7FAFF01C1F7FF01AFF5FF0281EFFF01D6FAFF026A
          EBFF0173ECFF0172ECFF0171ECFF0170ECFF026FECFF026EECFF0B7FF3FF0B7F
          F3FF0B7FF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7DF3FF0C75F2FF0C74
          F2FF0B7AF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7CF3FF0A7CF3FF0A7C
          F2FF0A7CF2FF097CF2FF097BF2FF097BF2FF097BF2FF087AF1FF087AF1FF0879
          F1FF0779F1FF0778F1FF0678F0FF0678F0FF0578F0FF0577EFFF0477EFFF0476
          EFFF0374EEFF0373EEFF0373EEFF0273EEFF0273EEFF0273EEFF0273EEFF0272
          EEFF0272EEFF0274EEFF0268EDFF01A3F4FF01C9F8FF01AFF5FF00ECFDFF0285
          EFFF0199F2FF01CBF8FF01D1F9FF01B8F6FF01BAF6FF0287EFFF00DEFBFF016A
          EBFF0174ECFF0171ECFF0170ECFF026FECFF026FECFF036DECFF0B7EF3FF0B7E
          F3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7DF3FF0B83F3FF07ABF7FF07B0
          F8FF0A8AF4FF0B7BF3FF0B7EF3FF0B7DF3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7D
          F3FF0A7CF3FF0A7CF2FF0A7CF2FF097CF2FF097BF2FF097BF2FF087AF2FF087A
          F1FF0879F1FF077AF1FF067AF0FF0674F0FF0570EFFF056FEEFF046EEEFF046E
          EEFF0373EEFF0375EEFF0273EEFF0273EEFF0273EEFF0272EEFF0272EEFF0272
          EEFF0272EEFF0274EEFF0267EDFF01A7F4FF01D0F9FF01AFF5FF00EEFDFF0280
          EFFF0296F1FF01B4F5FF027FEEFF0281EEFF0293F0FF018FF0FF018EF0FF0170
          ECFF0172ECFF0170ECFF0270ECFF026FECFF026EECFF036DECFF0C7FF4FF0C7E
          F4FF0C7EF4FF0C7EF4FF0B7EF3FF0B7FF3FF0C78F3FF0998F5FF00FFFFFF00FF
          FFFF06B3F8FF0C75F2FF0B80F3FF0B7EF3FF0B7EF3FF0B7DF3FF0B7DF3FF0B7D
          F3FF0A7DF3FF0A7DF3FF0A7DF3FF0A7DF2FF0A7CF2FF097CF2FF097BF2FF097B
          F2FF087BF1FF0876F1FF0772F0FF0684F1FF0493F3FF0396F3FF0395F3FF0390
          F2FF0377EEFF036AEDFF0274EEFF0273EEFF0272EEFF0272EEFF0272EEFF0272
          EEFF0272EEFF0273EDFF026EEDFF0287F0FF0197F2FF0276EEFF028AF0FF026B
          EBFF026DEBFF0266EAFF0270ECFF026DEBFF0176ECFF00CBF8FF017DEDFF016E
          ECFF0171ECFF0170ECFF016FECFF016EECFF026DECFF026DECFF0C7FF4FF0C7F
          F4FF0C7FF4FF0C7FF4FF0C7FF4FF0C80F4FF0D79F4FF0A98F6FF00FEFFFF00FF
          FFFF07B1F8FF0C75F3FF0B80F3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7EF3FF0B7E
          F3FF0B7FF3FF0B7FF3FF0B7DF3FF0A7CF3FF0A7CF3FF0A7BF2FF0A7BF2FF097C
          F2FF0976F1FF0788F3FF02D6FBFF00F8FEFF00FFFFFF00FFFFFF00FFFFFF00FF
          FFFF00F0FDFF01AAF5FF026CEDFF0273EEFF0272EEFF0272EEFF0272EEFF0272
          EDFF0273EDFF0274EDFF0273EDFF026EEDFF026BECFF0270ECFF026CEBFF0273
          ECFF0272ECFF0274ECFF0172ECFF0073ECFF006FECFF0072ECFF0078EDFF006F
          ECFF0170ECFF016FECFF016EECFF026EECFF026DECFF036DECFF0C7FF4FF0C7F
          F4FF0C7FF4FF0C7FF4FF0C7FF4FF0C80F4FF0D79F4FF0A98F6FF00FFFFFF00FF
          FFFF07B2F8FF0D76F3FF0C81F4FF0C7FF4FF0C7FF4FF0C7EF4FF0B7FF4FF0B7F
          F3FF0C76F3FF0C77F2FF0B7EF3FF0B80F3FF0B80F3FF0A80F3FF0A80F3FF0A7E
          F3FF0984F3FF01EDFDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
          FFFF00FFFFFF00FFFFFF01AEF5FF0269EDFF0274EEFF0272EDFF0272EDFF0274
          EDFF026CECFF0269ECFF0270EDFF0276EDFF0276EDFF0175ECFF0176ECFF0175
          ECFF0175ECFF0075ECFF0075ECFF0075ECFF0075ECFF0073ECFF006EECFF0170
          ECFF016FECFF016FECFF026EECFF026DECFF026DECFF036CECFF0C80F4FF0C80
          F4FF0C80F4FF0C80F4FF0C80F4FF0C81F4FF0C7AF4FF0A99F6FF00FFFFFF00FF
          FFFF07B2F8FF0D77F3FF0C81F4FF0C7FF4FF0C7FF4FF0C80F4FF0C7EF4FF0C7B
          F4FF08AAF8FF04D8FCFF02E9FDFF02ECFDFF02ECFDFF02ECFDFF02ECFDFF02EB
          FDFF01F3FEFF00FFFFFF00FFFFFF02DBFBFF059DF5FF0497F3FF0393F2FF01A8
          F5FF00F5FEFF00FFFFFF00F6FEFF027BEEFF0270EDFF0273EDFF0273EDFF016A
          ECFF018FF1FF01C9F8FF00E3FBFF00EAFCFF00EAFCFF00EAFCFF00EAFCFF00EA
          FCFF00EAFCFF00EAFCFF00EAFCFF00EAFCFF00E8FCFF00F2FDFF00BEF6FF0168
          EBFF0170ECFF016EECFF026DECFF026DECFF036CECFF036BECFF0D80F4FF0D80
          F4FF0D80F4FF0D80F4FF0D80F4FF0D81F4FF0D7BF4FF0A99F6FF00FFFFFF00FF
          FFFF07B6F9FF0D77F3FF0C83F4FF0C80F4FF0C81F4FF0C80F4FF0C7FF4FF04D5
          FBFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
          FFFF00FFFFFF00FFFFFF01FAFFFF0A87F4FF0A72F1FF0672F0FF026EEDFF0260
          EBFF01BAF6FF00FFFFFF00FFFFFF0196F2FF016BECFF0176EEFF016AECFF00AF
          F5FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
          FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEFBFF0166
          EBFF016FECFF026DECFF026CECFF026CECFF036CECFF036BECFF0D80F4FF0D80
          F4FF0D80F4FF0D80F4FF0D80F4FF0D81F4FF0E7AF3FF0A99F6FF00FFFFFF00FF
          FFFF04DDFCFF0E76F3FF0E7BF4FF0D7EF4FF0D7FF4FF0E76F3FF06C2FAFF00FF
          FFFF00FFFFFF02EBFDFF06C8FBFF06C4FAFF06C4FAFF06C7FBFF06C9FBFF06C2
          FAFF03E6FDFF00FFFFFF01F6FEFF0E87F5FF1180F6FF0F80F5FF036DEDFF0362
          EBFF01A9F4FF00FFFFFF00FFFFFF0196F2FF0266ECFF0268ECFF0192F1FF00FF
          FFFF00FFFFFF00F4FEFF00C8F8FF00BCF6FF00BDF6FF00BFF6FF00C2F7FF00C0
          F7FF00BFF7FF00BFF7FF00BFF7FF00BFF7FF00BDF6FF00C4F7FF019FF2FF0169
          EBFF016EECFF026CECFF026CECFF036CECFF036CECFF036BECFF0D80F4FF0D80
          F4FF0D80F4FF0D81F5FF0D81F5FF0D82F5FF0D7BF4FF0A9AF7FF00FFFFFF00FE
          FFFF00FFFFFF05CCFBFF0B94F6FF0C8CF6FF0C8AF6FF0C90F6FF01F4FEFF00FF
          FFFF02ECFDFF0C90F6FF0E81F5FF0E83F5FF0E81F5FF0F77F4FF1074F4FF1071
          F4FF09AFF9FF00FFFFFF00FFFFFF07CEFCFF1397FAFF1390F9FF0475EDFF056B
          ECFF02B1F5FF00FFFFFF00FFFFFF029EF3FF0273EDFF0273EDFF01D3F9FF00FF
          FFFF00FBFFFF019BF2FF016FECFF0173ECFF0072ECFF0069EBFF005EE9FF0066
          EBFF0067EBFF0066EBFF0066EBFF0066EBFF0065EBFF0164EBFF0168EBFF016E
          ECFF016DECFF026CECFF026CECFF036CECFF036BECFF046AECFF0D81F5FF0D81
          F5FF0D81F5FF0D81F5FF0D81F5FF0D82F5FF0E7CF5FF0B9AF7FF00FFFFFF00FD
          FFFF00FFFFFF00FFFFFF00FEFFFF01F6FEFF01F5FEFF01F7FEFF00FFFFFF00FF
          FFFF01F9FEFF01F3FEFF01F8FEFF01F7FEFF01F6FEFF02EBFDFF0AB2F9FF1080
          F6FF1089F7FF03ECFEFF00FFFFFF00FFFFFF01FCFFFF02F5FFFF01F3FEFF01F2
          FDFF00F8FEFF00FFFFFF00FFFFFF00F6FEFF00F3FDFF00F4FEFF00FDFFFF00FF
          FFFF00FCFFFF00F0FDFF00F6FEFF00F6FEFF00F6FEFF00EFFDFF00BFF6FF0074
          ECFF0071ECFF0073ECFF0072ECFF0072ECFF0071ECFF0171ECFF0170ECFF016D
          ECFF026DECFF026CECFF026CECFF036CECFF036BECFF046AECFF0E81F5FF0E81
          F5FF0E81F5FF0E81F5FF0E81F5FF0E82F5FF0F7BF5FF0B9BF7FF00FFFFFF00FF
          FFFF05D3FBFF02EDFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FE
          FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0CA9
          F9FF137CF7FF1196F9FF05E1FDFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
          FFFF00FFFFFF00FEFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FE
          FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0
          F7FF0067EBFF0072ECFF0070ECFF0070ECFF006FECFF016FECFF016EECFF016E
          ECFF026DECFF026CECFF026CECFF036CECFF036BECFF0469ECFF0E81F5FF0E81
          F5FF0E81F5FF0E81F5FF0E82F5FF0E82F5FF0E81F5FF0D88F5FF0B9FF7FF0AA1
          F7FF0E86F5FF0E87F5FF0AA8F8FF09B4F9FF09B2F9FF08BCFAFF00FCFFFF00FF
          FFFF04E2FDFF0BAAF9FF0AB4FAFF0AB1FAFF09C1FBFF01FAFFFF00FFFFFF07D3
          FCFF1481F8FF1488F9FF1687F9FF13A1FBFF11BAFEFF0FB4FBFF0897F2FF0893
          F2FF04C6F8FF00FFFFFF00FEFFFF03B2F5FF03A0F3FF03A1F3FF01E9FCFF00FF
          FFFF00F3FDFF01A3F3FF00A4F3FF00A7F3FF00A9F3FF00EBFCFF00FFFFFF00EE
          FDFF0073ECFF006FECFF0070ECFF0070ECFF006FECFF016FECFF016EECFF016D
          ECFF026DECFF026CECFF026CECFF036BECFF0369ECFF0468ECFF0E82F5FF0E82
          F5FF0E82F5FF0E82F5FF0E82F5FF0E82F5FF0E82F5FF0F81F5FF0F7CF5FF107C
          F5FF0F82F6FF0F81F6FF107BF5FF107BF5FF107BF5FF1178F5FF04E2FDFF00FF
          FFFF02F3FEFF0CA3F8FF1184F7FF1182F7FF0F95F8FF01F7FFFF00FFFFFF07D7
          FDFF1582F9FF158DFAFF168DFAFF1989FBFF1D8EFEFF1B7BF9FF0F46E8FF0F3E
          E7FF0799F2FF00FFFFFF00FDFFFF0675EDFF0757E9FF0653E8FF02B0F5FF00FF
          FFFF00FDFFFF01AEF4FF0170ECFF0070ECFF006EECFF00DBFAFF00FFFFFF00EF
          FDFF0076EDFF006EECFF0071ECFF0070ECFF006FECFF016FECFF016EECFF016D
          ECFF026DECFF026CECFF026CECFF036AECFF0369ECFF0468ECFF0E82F5FF0E82
          F5FF0E82F5FF0F82F5FF0F82F5FF0F82F5FF0F83F6FF0F83F6FF0F84F6FF0F84
          F6FF0F83F6FF0F84F6FF0F85F6FF0F85F6FF0F87F6FF1080F6FF0D9DF8FF00FF
          FFFF00FFFFFF00FFFFFF01F8FFFF01F5FEFF01FCFFFF00FEFFFF00FFFFFF0BBD
          FCFF1682F9FF168EFAFF178EFBFF1990FCFF1C98FEFF1A85F9FF0E54EAFF0E4C
          E9FF07A1F3FF00FFFFFF00FDFFFF077EEFFF0760EBFF0567EBFF056BECFF01E5
          FCFF00FFFFFF00FFFFFF00FAFEFF00F3FDFF00F8FEFF00FEFFFF00FFFFFF00D8
          FAFF0069EBFF0071ECFF0070ECFF0070ECFF006FECFF016FECFF016EECFF016E
          ECFF026DECFF026CECFF026BECFF036AECFF0369ECFF0467ECFF0F82F5FF0F82
          F5FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF0F83
          F6FF1084F6FF1084F6FF1084F6FF1084F6FF1084F6FF1086F7FF127FF7FF0DA1
          F9FF03EBFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF06DAFDFF158B
          F9FF168BFAFF178DFAFF188FFBFF1A90FCFF1C97FFFF1A83F9FF0E50EAFF0F48
          E9FF079FF3FF00FFFFFF00FDFFFF077AEEFF085BEAFF0666EBFF0661EAFF0472
          ECFF01D1F9FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECFCFF0085
          EFFF006BEBFF0071ECFF0070ECFF0070ECFF006FECFF016FECFF016FECFF016E
          ECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0467ECFF0F83F6FF0F83
          F6FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF0F83F6FF1084F6FF1084F6FF1084
          F6FF1084F6FF1084F6FF1084F6FF1085F7FF1185F7FF1185F7FF1187F7FF1280
          F7FF1286F7FF0EA4FAFF0BB7FBFF0BBAFBFF0CB8FBFF0FA5FAFF1587F9FF168A
          F9FF168DFAFF188EFBFF198FFCFF1A90FCFF1D97FFFF1A83F9FF0E50E9FF0F48
          E9FF079DF3FF00FFFFFF00FBFEFF0779EEFF085AEAFF0763EBFF0665EBFF0563
          EBFF0560EAFF0383EFFF02A2F3FF01AAF4FF01AAF4FF009BF2FF0074EDFF006B
          EBFF0071ECFF0070ECFF0070ECFF0070ECFF0070ECFF006FECFF016FECFF016E
          ECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0468ECFF0F83F6FF0F83
          F6FF0F83F6FF0F83F6FF1084F6FF1084F6FF1084F6FF1084F6FF1084F6FF1084
          F6FF1084F6FF1085F7FF1185F7FF1185F7FF1186F7FF1186F7FF1286F7FF1288
          F8FF1287F8FF1481F8FF1480F8FF1580F8FF1581F9FF1684F9FF158BF9FF168C
          FAFF178DFAFF188EFBFF1990FCFF1A91FDFF1D98FFFF1A83F9FF0E51EAFF0F47
          E9FF07A4F4FF00FFFFFF00FFFFFF087BEFFF0958EAFF0763EBFF0663EBFF0566
          EBFF0567EBFF0462EBFF0360EBFF0261EBFF0163EBFF0067EBFF006FECFF0071
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006FECFF016FECFF016E
          ECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0468ECFF0F83F6FF0F83
          F6FF1084F6FF1084F6FF1084F6FF1084F6FF1084F6FF1084F6FF1085F7FF1085
          F7FF1185F7FF1185F7FF1185F7FF1186F7FF1186F7FF1286F7FF1287F8FF1287
          F8FF1388F8FF138AF8FF138BF9FF148BF9FF148CF9FF158CF9FF168CFAFF178D
          FAFF188EFBFF198FFBFF1A91FCFF1B91FDFF1D98FFFF1A83F9FF0E4FE9FF0E4D
          E9FF0981EFFF04C2F8FF04BAF7FF086DEDFF095BEBFF0762EBFF0763EBFF0664
          EBFF0566EBFF0468EBFF036BECFF036DECFF026FECFF0170ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006FECFF016FECFF016E
          ECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0468ECFF1084F6FF1084
          F6FF1084F6FF1084F6FF1084F6FF1084F6FF1085F7FF1085F7FF1185F7FF1185
          F7FF1185F7FF1186F7FF1186F7FF1286F7FF1287F8FF1287F8FF1387F8FF1388
          F8FF1388F8FF1489F8FF1489F9FF148AF9FF158AF9FF168BF9FF168CFAFF178D
          FBFF188EFBFF1990FCFF1A91FCFF1B92FDFF1D98FFFF1A83F9FF0E4DE9FF0E55
          EAFF0D51EAFF0C4CEAFF0B4FEAFF095BEBFF085FEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0467EBFF0468ECFF036AECFF026CECFF016DECFF006FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF016FECFF016E
          ECFF016EECFF026DECFF026BECFF036AECFF0369ECFF0468ECFF0F84F6FF1084
          F6FF1084F6FF1084F6FF1085F7FF1085F7FF1185F7FF1185F7FF1185F7FF1186
          F7FF1186F7FF1286F7FF1286F7FF1287F8FF1287F8FF1387F8FF1388F8FF1388
          F8FF1489F8FF1489F9FF148AF9FF158AF9FF158BF9FF168CFAFF178DFAFF188E
          FBFF188FFBFF1990FCFF1A91FDFF1B92FDFF1D98FFFF1A83FAFF0E4EE9FF0E54
          EAFF0C57EAFF0B5BEBFF0A5DEBFF095DEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0566EBFF0468ECFF0369ECFF026BECFF026DECFF016FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006FECFF016F
          ECFF016EECFF026DECFF026CECFF036BECFF036AECFF0469ECFF1084F6FF1084
          F6FF1085F7FF1185F7FF1185F7FF1185F7FF1185F7FF1186F7FF1186F7FF1186
          F7FF1286F7FF1287F8FF1287F8FF1287F8FF1388F8FF1388F8FF1388F8FF1489
          F8FF1489F9FF148AF9FF158AF9FF158BF9FF168CFAFF168CFAFF178DFBFF188E
          FBFF198FFCFF1A90FCFF1B92FDFF1B92FDFF1E98FFFF1A83FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0566EBFF0468ECFF0369ECFF036BECFF026CECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006FECFF016F
          ECFF016EECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0C7FF4FF1185
          F7FF1185F7FF1185F7FF1185F7FF1186F7FF1186F7FF1186F7FF1286F7FF1286
          F7FF1287F8FF1287F8FF1387F8FF1388F8FF1388F8FF1389F8FF1489F8FF1489
          F9FF148AF9FF158AF9FF158BF9FF168CFAFF168CFAFF178DFAFF188EFBFF188F
          FBFF1990FCFF1A91FCFF1B92FDFF1C92FDFF1E99FFFF1A83FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0566EBFF0468ECFF0369ECFF036BECFF026CECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF016F
          ECFF016EECFF016DECFF026CECFF026BECFF036AECFF0369ECFF0475EFFF1085
          F6FF1185F7FF1186F7FF1186F7FF1186F7FF1286F7FF1286F7FF1287F8FF1287
          F8FF1287F8FF1387F8FF1388F8FF1388F8FF1389F8FF1489F8FF1489F9FF148A
          F9FF158AF9FF158BF9FF168BF9FF168CFAFF178DFAFF178DFBFF188EFBFF198F
          FBFF1990FCFF1A91FCFF1B92FDFF1C93FEFF1E99FFFF1A84FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0466EBFF0468ECFF0369ECFF036BECFF026CECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006F
          ECFF016EECFF016DECFF026CECFF026BECFF036AECFF0369ECFF006FEBFF0C7F
          F4FF1287F8FF1186F7FF1186F7FF1286F7FF1286F7FF1287F8FF1287F8FF1287
          F8FF1388F8FF1388F8FF1388F8FF1489F8FF1489F8FF1489F9FF148AF9FF158A
          F9FF158BF9FF158BF9FF168CFAFF168CFAFF178DFAFF188EFBFF188FFBFF1990
          FCFF1A90FCFF1A91FDFF1B92FDFF1C93FEFF1E99FFFF1A84FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0565EBFF0466EBFF0468ECFF0369ECFF026BECFF026CECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006F
          ECFF016FECFF016EECFF026DECFF026CECFF036BECFF036AECFF006FECFF0374
          EEFF1186F7FF1286F7FF1286F7FF1287F8FF1287F8FF1287F8FF1387F8FF1388
          F8FF1388F8FF1388F8FF1489F8FF1489F8FF1489F9FF148AF9FF158AF9FF158A
          F9FF158BF9FF168CFAFF168CFAFF178DFAFF178DFBFF188EFBFF188FFBFF1990
          FCFF1A91FCFF1A92FDFF1B93FDFF1C93FEFF1E99FFFF1A84FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0663
          EBFF0565EBFF0466EBFF0468ECFF0369ECFF026BECFF026CECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF016FECFF016EECFF016DECFF026CECFF026BECFF036AECFF0070ECFF006E
          EBFF0A7CF2FF1388F8FF1287F8FF1287F8FF1287F7FF1387F8FF1388F8FF1388
          F8FF1388F8FF1489F8FF1489F8FF1489F9FF148AF9FF158AF9FF158AF9FF158B
          F9FF168BFAFF168CFAFF178DFAFF178DFAFF178EFBFF188FFBFF198FFCFF1990
          FCFF1A91FCFF1B92FDFF1B93FDFF1C93FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0663
          EBFF0565EBFF0466EBFF0468ECFF0369ECFF026BECFF026DECFF016EECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF016FECFF016EECFF016DECFF026CECFF026BECFF036AECFF006CE5F80070
          ECFF0070ECFF1084F6FF1388F8FF1287F7FF1387F8FF1388F8FF1388F8FF1388
          F8FF1489F8FF1489F8FF1489F9FF148AF9FF158AF9FF158AF9FF158BF9FF168B
          F9FF168CFAFF168CFAFF178DFAFF178EFBFF188EFBFF188FFBFF1990FCFF1A90
          FCFF1A91FDFF1B92FDFF1C93FEFF1C93FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0663
          EBFF0565EBFF0566EBFF0468ECFF0369ECFF026BECFF026DECFF016FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF006FECFF016EECFF016DECFF026DECFF026BECFF0267E5F80065D6E80070
          ECFF006FEBFF0475EEFF1388F8FF1388F8FF1388F8FF1388F8FF1388F8FF1489
          F8FF1489F8FF1489F9FF148AF9FF158AF9FF158AF9FF158BF9FF158BF9FF168C
          FAFF168CFAFF168DFAFF178DFBFF178EFBFF188EFBFF188FFBFF1990FCFF1A91
          FCFF1A92FDFF1B92FDFF1C93FEFF1C94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF0860EBFF0762EBFF0663
          EBFF0565EBFF0566EBFF0468ECFF036AECFF026BECFF026DECFF016FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF016FECFF016EECFF026DECFF026CECFF0161D6E80062CFE00070
          ECFF0070ECFF006EEBFF087AF2FF148AF9FF1388F8FF1389F8FF1489F8FF1489
          F8FF1489F9FF148AF9FF158AF9FF158AF9FF158BF9FF158BF9FF168CFAFF168C
          FAFF168CFAFF178DFAFF178EFBFF188EFBFF188FFBFF198FFCFF1990FCFF1A91
          FCFF1A92FDFF1B92FDFF1C93FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0566EBFF0468ECFF036AECFF026BECFF016DECFF006FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF016FECFF016EECFF016DECFF026CECFF015AC8D80054B1C00070
          ECFF0070ECFF0070ECFF006FEBFF0C7FF4FF158BF9FF1489F8FF1489F8FF1489
          F9FF148AF9FF148AF9FF158AF9FF158BF9FF158BF9FF168BFAFF168CFAFF168C
          FAFF178DFAFF178DFBFF178EFBFF188EFBFF188FFBFF1990FCFF1A90FCFF1A91
          FCFF1B92FDFF1B93FDFF1C93FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0567EBFF0468ECFF036AECFF026BECFF016DECFF006FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF006FECFF016EECFF016DECFF026CECFF014EAAB8003B7E880070
          ECFF0070ECFF0070ECFF0070ECFF006FECFF0F82F5FF168BF9FF1489F8FF148A
          F9FF148AF9FF158AF9FF158AF9FF158BF9FF158BF9FF168CFAFF168CFAFF168D
          FAFF178DFAFF178EFBFF188EFBFF188FFBFF198FFCFF1990FCFF1A91FCFF1A91
          FDFF1B92FDFF1B93FDFF1C94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0567EBFF0468ECFF036AECFF026CECFF016DECFF006FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF016FECFF016EECFF026DECFF0136768000234A500070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0F83F6FF158CFAFF148A
          F9FF158AF9FF158AF9FF158BF9FF158BF9FF168CFAFF168CFAFF168CFAFF178D
          FAFF178DFBFF178EFBFF188EFBFF188FFBFF1990FCFF1990FCFF1A91FCFF1A91
          FDFF1B92FDFF1C93FDFF1C94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0567EBFF0468ECFF036AECFF026CECFF016EECFF006FECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF006FECFF016EECFF016DECFF001E4348000409090068
          DCEE0070ECFF0070ECFF0070ECFF0070ECFF006FECFF0070ECFF0F83F5FF178C
          FAFF158AF9FF158BF9FF158BF9FF158BFAFF168CFAFF168CFAFF168DFAFF178D
          FAFF178EFBFF188EFBFF188FFBFF188FFBFF1990FCFF1A90FCFF1A91FCFF1A92
          FDFF1B92FDFF1C93FEFF1C94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0567EBFF0468ECFF036AECFF026CECFF016EECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF016FECFF0066DCEE00040909000000000038
          76800070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0D81
          F4FF178DFAFF158BF9FF158BF9FF168CFAFF168CFAFF168CFAFF178DFAFF178D
          FBFF178EFBFF188EFBFF188FFBFF198FFCFF1990FCFF1A90FCFF1A91FDFF1B92
          FDFF1B92FDFF1C93FEFF1C94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0567EBFF0468ECFF036AECFF026CECFF016EECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF016FECFF003776800000000000000000000E
          1D1F0065D6E80070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF006F
          EBFF097CF2FF168CFAFF178DFBFF168BFAFF168CFAFF168DFAFF178DFAFF178E
          FBFF188EFBFF188FFBFF188FFBFF1990FCFF1990FCFF1A91FCFF1A91FDFF1B92
          FDFF1B92FDFF1C93FEFF1C94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0E54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0467EBFF0468ECFF036AECFF026CECFF016EECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0065D6E8000D1D1F00000000000000000000
          0000001C3B40006FEAFD0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0071
          ECFF006FEBFF0577EFFF1388F8FF188EFBFF168DFAFF178DFAFF178DFBFF178E
          FBFF188EFBFF188FFBFF198FFCFF1990FCFF1990FCFF1A91FCFF1A91FDFF1B92
          FDFF1B93FDFF1C93FEFF1D94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF085FEBFF0761EBFF0663
          EBFF0565EBFF0467EBFF0469ECFF036AECFF026CECFF016EECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF006FEAFD001C3B400000000000000000000000000000
          00000000010100357079006EE9FC0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0071ECFF0070EBFF0071ECFF0C80F4FF178DFAFF188FFCFF178EFBFF188E
          FBFF188FFBFF188FFBFF198FFCFF1990FCFF1A90FCFF1A91FCFF1A92FDFF1B92
          FDFF1B93FDFF1C93FEFF1D94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF0A5CEBFF095EEBFF0860EBFF0762EBFF0664
          EBFF0566EBFF0467EBFF0369ECFF026BECFF026DECFF016FECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF006EE9FC00346F78000001010000000000000000000000000000
          00000000000000000000001C3B3F0065D5E70070ECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0071ECFF0071ECFF006FEBFF0476EEFF1085F7FF188FFCFF1A90
          FCFF188FFBFF188FFBFF1990FCFF1990FCFF1A91FCFF1A91FDFF1B92FDFF1B92
          FDFF1C93FDFF1C94FEFF1D94FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF085EEBFF0760EBFF0762EBFF0664
          EBFF0566EBFF0468ECFF036AECFF026CECFF016EECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070
          ECFF0068DBED001C3B3F00000000000000000000000000000000000000000000
          000000000000000000000000000000060C0D0030656D005EC7D70070ECFF0070
          ECFF0070ECFF0070ECFF0071ECFF0072ECFF0070EBFF0070EBFF0577EFFF1085
          F6FF188FFBFF1A91FDFF1990FCFF1990FCFF1A91FCFF1A91FDFF1B92FDFF1B92
          FDFF1C93FEFF1C94FEFF1D95FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5AEBFF095CEBFF085FEBFF0761EBFF0663EBFF0565
          EBFF0467EBFF0369ECFF036BECFF026DECFF016FECFF0070ECFF0070ECFF0070
          ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF0070ECFF005EC7D70030
          656D00070F100000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000112528002F
          636B004CA0AD005BBFCF0063D1E2006DE3F60071ECFF0071ECFF006FEBFF006E
          EBFF0475EFFF0E82F5FF178DFBFF1A91FCFF1A91FCFF1A91FDFF1B92FDFF1B92
          FDFF1C93FEFF1C94FEFF1D95FEFF1D94FEFF1E99FFFF1A84FAFF0E4EE9FF0D54
          EAFF0C56EAFF0B58EBFF0A5BEBFF095EEBFF0760EBFF0662EBFF0664EBFF0566
          EBFF0468ECFF036AECFF026CECFF016EECFF006FECFF0070ECFF0070ECFF0070
          ECFF006CE3F60063D1E2005BBFCF004DA3B00031676F0013282B000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36400000424D3640000000000000360000002800000040000000400000000100
          2000000000000040000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000B071100321F4F0061
          3C97008251CC00975DEC00A164FC00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF009E62F700915AE3008050C9005B388E002D1C47000B07110000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000006040900382358007A4CBF009B60F200A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF009A5FF100794BBE0038
          2358000604090000000000000000000000000000000000000000000000000000
          0000000000000000000000160D22006840A2009E62F700A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF009E
          62F7006740A100160D2200000000000000000000000000000000000000000000
          000000000000001D122E007D4EC400A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF007D4EC4001D122D000000000000000000000000000000000000
          000000170E24007F4FC700A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF007F4FC700170E240000000000000000000000000007
          040B006941A500A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF006941A50006040A0000000000000000003B
          245C009F63F900A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF009F62F8003A245B00000000000D0814007B
          4CC100A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF007B4CC0000C071300362154009C
          61F400A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF009B60F200311E4C00663F9F00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00603B96008754D300A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF008452CF00995FEF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00935BE600A164FC00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF009F62F800A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A364FF00A263FF00A2
          63FF00A263FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A264FF00A264FF13A96EFF2FB27EFF39B6
          85FF39B685FF2CB17CFF0FA76CFF00A263FF00A264FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A264FF2BB17CFF87D2B3FFCCEBDEFFEAF7F1FFF2FA
          F6FFF2FAF6FFE8F6F0FFC5E9DAFF79CDABFF20AD76FF00A263FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A364FF06A467FF65C6A0FFDEF2EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD2EEE2FF54BF95FF02A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF05A467FF7CCEACFFF7FCF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF8F4FF64C59EFF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A2
          63FF5CC299FFF5FBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF7F1FF44BA
          8BFF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FF1EAC
          75FFD2EEE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDE6
          D5FF11A86DFF00A364FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF6CC8
          A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FC
          FAFF50BE93FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF07A568FFB2E2
          CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF95D7BCFF00A264FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A364FF00A162FF00A162FF00A162FF00A162FF00A162FF00A162FF00A1
          62FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A364FF17AA71FFD5EF
          E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFBEE6D5FF0BA66AFF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          64FF1CAB73FF55BF94FF57BF95FF56BF95FF56BF95FF56BF95FF56BF95FF57BF
          95FF50BD91FF11A86DFF00A364FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FF20AC75FFDFF2
          EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFCDEBDEFF13A86EFF00A364FF00A365FF00A365FF00A365FF00A365FF00A1
          62FF4FBD91FFF8FCF9FFFDFEFDFFFCFEFDFFFCFEFDFFFCFEFDFFFCFEFDFFFEFE
          FEFFEAF6F0FF31B27EFF00A263FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FF1DAC74FFDDF1
          E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC9EADCFF10A86CFF00A365FF00A365FF00A365FF00A365FF00A365FF00A1
          62FF50BE92FFFBFDFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFECF7F2FF31B27FFF00A263FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF0FA86DFFC7EA
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFADE0CBFF04A466FF00A365FF00A365FF00A365FF00A365FF00A365FF00A1
          62FF5DC39BFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE6F5EFFF2AB07BFF00A264FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A364FF92D6
          BAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF74CBA8FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A2
          63FF7CCEACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFD9F1E7FF1AAB73FF00A264FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF41B9
          8AFFF1F9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3F4
          EDFF2CB17DFF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF03A3
          66FFA4DDC6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFC5E9DAFF0EA76CFF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF06A5
          68FF9DDAC1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF82D0
          B1FF01A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FF19AB
          72FFD5EFE4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFA4DDC6FF03A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A2
          64FF21AE77FFC7EADBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB3E2CEFF15A9
          70FF00A264FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF4EBD
          91FFF7FCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF77CCA9FF00A262FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A263FF2FB27EFFBFE7D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFAEE0CBFF1FAD76FF00A2
          64FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF04A466FFA1DB
          C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FA
          F7FF41B989FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A263FF19AB72FF84D1B2FFDFF3EAFFFEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFCFDFDFFD6EFE5FF74CBA8FF11A86DFF00A264FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B584FFEAF7
          F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEEC
          E0FF15A96FFF00A364FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A264FF01A365FF26AF7AFF62C59DFF94D6BBFFAADF
          C9FFA9DEC8FF8ED4B8FF59C198FF1EAC75FF00A264FF00A364FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF08A569FFA6DDC7FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8CD4
          B7FF00A264FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A264FF00A162FF00A264FF02A3
          65FF02A364FF00A263FF00A162FF00A264FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A263FF60C49CFFF7FCFAFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEF9F4FF3BB7
          87FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A263FF3BB786FFE0F3EBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABDFCAFF07A5
          68FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A263FF2FB380FFCDECE0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2FAF7FF48BB8DFF00A2
          63FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A263FF3DB787FFCFEDE1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA0DBC3FF06A568FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A2
          63FF0AA669FF64C69FFFE1F4ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDF2E9FF2DB27EFF00A263FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A264FF00A162FF05A467FF3DB7
          86FFAADFC9FFF8FCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FCFAFF64C59FFF00A263FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          64FF00A162FF00A162FF00A263FF05A467FF1EAC74FF56C096FFA7DEC7FFEDF8
          F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF93D6BBFF07A568FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A364FF12A9
          6FFF55C197FF6BC7A2FF87D2B4FFAEE1CCFFDBF1E7FFF9FDFBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFAEE0CCFF14A970FF00A264FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B4
          82FFF0F9F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB7E3D0FF1EAC75FF00A263FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B5
          83FFF1FAF6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFAEE0CBFF1EAC75FF00A263FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B5
          83FFF1F9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FCF9FF90D6
          BAFF13A96FFF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B5
          83FFF1F9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBF1E8FF61C49DFF06A5
          67FF00A264FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B5
          83FFF1F9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F9F5FF9CDAC1FF2BB17CFF00A263FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF37B5
          83FFF1F9F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFECF7F2FFA5DDC7FF42B98AFF05A467FF00A263FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF38B5
          83FFF3FAF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F9F5FFC8EA
          DCFF84D1B2FF37B583FF05A467FF00A263FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A263FF30B2
          7FFFD3EDE2FFDCF2E9FFD1EEE2FFBDE6D5FF9BD9C0FF6DC8A4FF3AB685FF11A8
          6EFF00A264FF00A263FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FD00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF07A5
          68FF1EAC75FF1CAC73FF13A96FFF0BA66AFF01A364FF00A162FF00A263FF00A3
          64FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A264FD00995FF000A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A264FF00A264FF00A364FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00995FF0008854D400A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF008653D200663FA000A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00643E9D00362154009C
          61F400A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF009C61F400362154000D0814007B
          4CC100A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF007B4CC0000C071300000000003A
          245A009F62F800A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF009F62F80039235900000000000000000006
          040A006941A400A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF006841A30006040A00000000000000000000
          000000160E23007E4EC500A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF007E4EC500160E230000000000000000000000000000
          000000000000001D122E007D4EC400A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF007D4DC3001D122D000000000000000000000000000000000000
          0000000000000000000000160D22006941A4009D61F600A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF009D
          61F6006841A300150D2100000000000000000000000000000000000000000000
          0000000000000000000000000000000603090036215400784ABB009B60F300A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF009B60F300784ABB0036
          2154000604090000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000B071100321F4F0064
          3E9D008955D600995FEF00A164FC00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A365FF00A3
          65FF00A365FF00A164FC00995FEF008955D600643E9C00321F4F000B07110000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 470
    Top = 324
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
    end
    object cxStyle3: TcxStyle
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor]
      Color = 16770263
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clNavy
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clNavy
      TextColor = clWhite
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Font.Quality = fqClearType
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Font.Quality = fqClearType
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clNavy
      TextColor = clWhite
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
      TextColor = clRed
    end
    object cxStyle15: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
      TextColor = clGreen
    end
    object cxStyle16: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
    end
    object cxStyle17: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconSize = cxisSmall
    HintStyle.IconType = cxhiInformation
    HintStyle.Rounded = True
    Left = 514
    Top = 268
  end
  object dxDockingManager: TdxDockingManager
    AutoHideMovingSize = 500
    Color = clBtnFace
    DefaultHorizContainerSiteProperties.CaptionButtons = []
    DefaultHorizContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultHorizContainerSiteProperties.Dockable = True
    DefaultHorizContainerSiteProperties.ImageIndex = -1
    DefaultHorizContainerSiteProperties.ShowCaption = False
    DefaultVertContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultVertContainerSiteProperties.Dockable = True
    DefaultVertContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.AllowFloating = False
    DefaultTabContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultTabContainerSiteProperties.Dockable = True
    DefaultTabContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.ShowCaption = False
    DefaultTabContainerSiteProperties.TabsProperties.CustomButtons.Buttons = <>
    DefaultTabContainerSiteProperties.TabsProperties.NavigatorPosition = npLeftBottom
    DockStyle = dsVS2005
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = 'MoneyTwins'
    Left = 534
    Top = 404
    PixelsPerInch = 96
  end
  object AdvMenuStyler1: TAdvMenuStyler
    AntiAlias = aaClearType
    Background.Position = bpCenter
    SelectedItem.Font.Charset = DEFAULT_CHARSET
    SelectedItem.Font.Color = clWindowText
    SelectedItem.Font.Height = -13
    SelectedItem.Font.Name = 'Segoe UI'
    SelectedItem.Font.Style = []
    SelectedItem.NotesFont.Charset = DEFAULT_CHARSET
    SelectedItem.NotesFont.Color = clWindowText
    SelectedItem.NotesFont.Height = -11
    SelectedItem.NotesFont.Name = 'Segoe UI'
    SelectedItem.NotesFont.Style = []
    RootItem.Font.Charset = DEFAULT_CHARSET
    RootItem.Font.Color = clWindowText
    RootItem.Font.Height = -13
    RootItem.Font.Name = 'Segoe UI'
    RootItem.Font.Style = []
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.Image.Position = bpCenter
    SideBar.Background.Position = bpCenter
    SideBar.SplitterColorTo = clBlack
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clGray
    NotesFont.Height = -11
    NotesFont.Name = 'Segoe UI'
    NotesFont.Style = []
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Segoe UI'
    ButtonAppearance.CaptionFont.Style = []
    Left = 142
    Top = 268
  end
  object svdConfigPanel: TSaveDialog
    Filter = 'Ini Files (*.ini)|*.ini'
    Left = 48
    Top = 270
  end
  object mmnConfigPaineis: TAdvPopupMenu
    Alignment = paCenter
    BiDiMode = bdLeftToRight
    Images = imglDiversas16
    MenuAnimation = [maLeftToRight, maRightToLeft, maTopToBottom, maBottomToTop]
    ParentBiDiMode = False
    TrackButton = tbLeftButton
    Version = '2.5.5.1'
    Left = 132
    Top = 414
    object ConfiguraesdosPainis1: TMenuItem
      Caption = '&Configura'#231#245'es dos Pain'#233'is'
      ImageIndex = 17
      object mnuSalvarLayout: TMenuItem
        Caption = '&Salvar Layout'
        ImageIndex = 18
        OnClick = mnuSalvarLayoutClick
      end
      object mnuExportarLayout: TMenuItem
        Caption = '&Exportar Layout'
        ImageIndex = 19
        OnClick = mnuExportarLayoutClick
      end
      object mnuImportarLayout: TMenuItem
        Caption = '&Importar Layout'
        ImageIndex = 20
        OnClick = mnuImportarLayoutClick
      end
      object mnuRedefinirLayout: TMenuItem
        Caption = '&Redefinir Configura'#231#245'es'
        ImageIndex = 21
        OnClick = mnuRedefinirLayoutClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
  end
  object AdvPopupMenuImpVendas: TAdvPopupMenu
    Version = '2.5.5.1'
    Left = 112
    Top = 56
    object mnuRedeCardOnline: TMenuItem
      Bitmap.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFFFF7FBE
        FFFF2F95FFFF007EFFFF007EFFFF007EFFFF007EFFFF007EFFFF007EFFFF007E
        FFFF007EFFFF007EFFFF007EFFFF2F95FFFF7FBEFFFFFFFFFFFF7FBEFFFF007E
        FFFF007EFFFF007EFFFF007EFFFF007DFFFF007DFFFF007CFFFF007CFFFF007C
        FFFF007CFFFF007CFFFF007CFFFF007AFFFF007AFFFF7FBCFFFF2F95FFFF007D
        FFFF007DFFFF007DFFFF007AFFFF007CFFFF0086FFFF008FFFFF008FFFFF008F
        FFFF008FFFFF008FFFFF008FFFFF008FFFFF008FFFFF2FA3FFFF007CFFFF007C
        FFFF007CFFFF007AFFFF008AFFFF00BAFFFF00DCFFFF00E7FFFF00E8FFFF00E8
        FFFF00E8FFFF00E8FFFF00E8FFFF00E8FFFF00E8FFFF00E8FFFF007AFFFF007A
        FFFF007AFFFF008AFFFF05D4FAFF00F6FFFF00F6FFFF00F3FFFF00F2FFFF00F2
        FFFF00F2FFFF00F2FFFF00F2FFFF00F2FFFF00F2FFFF00F2FFFF0075FFFF0075
        FFFF0075FFFF00BEFFFF00F2FFFF00E8FFFF00C5FFFF00A3FFFF009EFFFF009E
        FFFF00A3FFFF00A3FFFF00A3FFFF00A3FFFF00A3FFFF00A3FFFF00A3FFFF00A3
        FFFF00AAFFFF05D4FAFF00E2FFFF04D1FBFF00AAFFFF009EFFFF009EFFFF009E
        FFFF008AFFFF0075FFFF0072FFFF0072FFFF0072FFFF0072FFFF00F2FFFF00F2
        FFFF00F3FFFF00F2FFFF00F2FFFF00F2FFFF00F2FFFF00F3FFFF00F3FFFF00F2
        FFFF00E8FFFF00BAFFFF007AFFFF0072FFFF0072FFFF0072FFFF00E7FFFF00E7
        FFFF00E8FFFF01ECFDFF01ECFDFF00E8FFFF00E7FFFF00E7FFFF00E7FFFF01EC
        FDFF00F3FFFF00F2FFFF009EFFFF006DFFFF0072FFFF0072FFFF0086FFFF0086
        FFFF008AFFFF04D1FBFF05E3FAFF00CCFFFF008AFFFF007EFFFF007EFFFF009E
        FFFF01ECFDFF00F6FFFF00B1FFFF006DFFFF006DFFFF006DFFFF006DFFFF006D
        FFFF006DFFFF00B5FFFF00F3FFFF01ECFDFF00C5FFFF00AAFFFF00AAFFFF00BE
        FFFF01ECFDFF00F3FFFF00AAFFFF006BFFFF006DFFFF006DFFFF006DFFFF006D
        FFFF006BFFFF007AFFFF00C5FFFF00F3FFFF00F6FFFF00F6FFFF00F6FFFF00F6
        FFFF00F6FFFF00E2FFFF0086FFFF006BFFFF006DFFFF006DFFFF006DFFFF006D
        FFFF006BFFFF006BFFFF0075FFFF00A3FFFF00CCFFFF00DCFFFF00DCFFFF00DC
        FFFF00C5FFFF008FFFFF006BFFFF006BFFFF006BFFFF006BFFFF2F86FFFF006B
        FFFF006BFFFF006BFFFF006BFFFF006AFFFF006DFFFF0075FFFF0075FFFF0075
        FFFF006DFFFF006AFFFF006BFFFF006BFFFF006BFFFF3086FFFF7FB4FFFF006B
        FFFF006BFFFF006AFFFF006AFFFF006AFFFF006AFFFF006AFFFF006AFFFF006A
        FFFF006AFFFF006AFFFF006AFFFF006AFFFF006AFFFF7FB4FFFFFFFFFFFF7FB4
        FFFF3086FFFF006AFFFF006AFFFF006AFFFF006AFFFF006AFFFF006AFFFF006A
        FFFF006AFFFF006AFFFF006AFFFF3086FFFF80B5FFFFFFFFFFFF}
      Caption = 'RedeCard Online'
      OnClick = mnuRedeCardOnlineClick
    end
    object mnuPagarMe: TMenuItem
      Bitmap.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFDFFFCFEFDFFFEFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFEFFFEFFFEFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFEFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFEFEFEFFFFFFFFFFFFFFFFFFCCEDE0FFC6EADDFFFFFFFFFFFFFFFFFFFDFE
        FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
        FEFFFFFFFFFFF5FCF9FF47BD90FF00A060FF00A05FFF32B583FFE6F6F0FFFFFF
        FFFFFDFEFEFFFDFEFEFFFBFEFDFFFBFEFDFFFEFFFFFFFFFFFFFFFFFFFFFFFBFE
        FDFFFFFFFFFF70CBA8FF009954FF05A568FF05A568FF009A56FF4DBF94FFFFFF
        FFFFFBFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFEFF
        FEFFFFFFFFFF30B482FF00A061FF03A467FF01A466FF00A263FF18AC74FFF4FB
        F8FFFFFFFFFFD1EEE3FF9FDDC5FFA6DFC9FFEFF9F5FFFFFFFFFFFFFFFFFFFCFE
        FDFFFFFFFFFF4FC095FF009C59FF08A66AFF08A66AFF009E5CFF30B482FFFFFF
        FFFFFFFFFFFF6DCAA7FF00964FFF009E5DFFD4EFE5FFFFFFFFFFFFFFFFFFFDFE
        FEFFFFFFFFFFD4EFE5FF0CA76CFF009C59FF009C5AFF00A263FFBBE6D6FFFFFF
        FFFFFFFFFFFF4ABE91FF009E5CFF15AB72FFEDF8F4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFDFEFEFFFFFFFFFFE3F5EEFF85D3B5FF7ED0B1FFD5F0E6FFFFFFFFFFFFFF
        FFFFD5F0E6FF02A466FF009E5DFF40BA8BFFFFFFFFFFFDFEFEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFCFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF34B684FF00A161FF009D5CFFA6DFC9FFFFFFFFFFFBFEFDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFDFEFEFFFBFEFDFFFFFFFFFFFFFFFFFFCDEDE1FF31B5
        82FF00A161FF009D5CFF41BA8CFFFFFFFFFFFEFFFEFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFEFFFFFFFFFFFFFFF9FDFCFF73CDABFF37B786FF00A365FF00A1
        61FF009D5BFF20AF79FFECF8F4FFFFFFFFFFFDFEFEFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFEFFFEFFFFFFFFFFF4FBF9FF08A66AFF009A56FF009E5DFF009E
        5DFF48BD90FFEEF9F5FFFFFFFFFFFCFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFEFFFFFFFFFFFFFFF6FCF9FF26B17CFF16AB73FF50C095FFB2E3
        D0FFFFFFFFFFFFFFFFFFFCFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFFE9F7F2FFF5FCF9FFFFFFFFFFFFFF
        FFFFFDFEFEFFFDFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFEFDFFFBFE
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Pagar.Me'
      Hint = 'PAGAR.ME'
      OnClick = ImportarVendas
    end
  end
  object imgLogoBandeiras: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 4981274
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000012114448342DC5D4362DD8EF2A24CEFA2D26C9ED0F0D373F02131D1E0F73
          B1B61794E7EE0C8CF3F70887EEF1054E81840000000000000000000000002623
          919B3529E5FE3527E5FF3326E2FF251FCBFF251FCBFF2620CBFE2D6CE7FC1C98
          F7FF1C98F7FF098AFCFF0085FFFF0085FFFF0978CDD100000000121144483529
          E5FE3527E5FF3527E5FF3326E2FF251FCBFF251FCBFF2F3AD9FD2F44DEFF2193
          F5FF1C98F7FF098AFCFF0085FFFF0085FFFF0085FFFF054E81845D5BC4D28683
          E7FF8683E7FFB1AFE7FF9795E6FF8B8AD3FFAAA9D9FEC0C0E2FF9999DDFF6F86
          E8FFBBCFF0FFA4BEF3FF9BB7F9FF75A2FCFFB8C9F4FF4090F0F48180E0F1E2E2
          E5FFE3E3E4FFDDDCE7FFD1D0E7FFD5D5E2FFCFCFE4FFD3D3E3FFD7D7E5FFCDCF
          E9FF96BDF3FFD5DDECFFE0E4ECFFD2D9F0FFD9DFEDFFABC1F2FD4443B9BFDDDC
          EEFFE7E7E6FFAAA9E8FFB4B2E9FFC9C9DFFFD3D3E8FEC2C2E3FFA4A4E1FFC4C6
          E7FFD6DFEBFF98B8F7FFB5C8F6FFB4C7F7FFD1DAEEFFC1D0F1FD252577774B49
          FAFF372BE7FF3527E5FF3326E2FF251FCBFF2620CBFE2D4EE0FF2E46DFFF297B
          EFFF1C98F7FF098AFCFF0085FFFF0085FFFF0085FFFF0984E6E9020207074545
          DDDE4B49FAFF372BE7FF3326E2FF251FCBFF251FCBFF2C2ED2FB2D5FE4FF189E
          F9FF1C98F7FF098AFCFF0085FFFF0085FFFF0286FCFE02253E3F000000000C0C
          27273D3DC5C64B49FAFF352AE3FF251FCBFF251FCBFF2D27CBF100709D9E02B5
          FEFF189EF9FF098AFCFF0085FFFF0487FBFD054E818400000000000000000000
          00000000000013133F3F2A29959D2824ADC91917677500000000000000000021
          2F2F025375770B7ED4D7065D9C9F000D15150000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00003F2D0048B88500D4CD8B00F7CC8800FABF8200E72A1E0032050113153B11
          BDD8440FD4FA4311D6F9331ACFDB190C5D620000000000000000000000008761
          019BDB9B00FED59100FFCC8401FFCC8401FFCC8401FFCD8601FE5321CEFA4A08
          D1FF4A08D1FF4A08D1FF420FDAFF2D1BEDFF2A15A5AE000000003F2D0048DB9B
          00FEDB9A00FFCC8401FFCC8401FFCC8401FFCC8401FF804AC4FF8745A1FE4A09
          D0FE4A08D1FF4A08D1FF4A08D1FF3716E4FF2D1BEDFF190C5D62B38001CDDEA1
          31FFDEAB6DFFD5A273FFD3A273FFD2A374FFBC888FFF9281D6FFA279A7FF7C66
          CEFE7B6AD3FF7562D2FF7763D7FF928AE7FF5F59EFFF341AD8E5CF9400EEDEA1
          31FFF3E6DBFFEDDED4FFE5DACDFFE1D7C9FFDBC4ADFFDECFBEFFC59D83FFC6BC
          CBFDC2BED8FFC2BED8FFC9C5ECFFC1BCECFFA2A0F3FF331DE8F8A57A02BDDC9D
          00FFF6EBE4FFE7D1C1FFE9E4DAFFD7B99CFFD2A67DFFD9BDA1FFC5997BFFB2A0
          C0FCC2BED8FFA69FD5FFAEA7DDFFC4C0EEFF6B66F0FF411ED5DB694E0277E0A6
          05FFD79500FFCC8401FFCC8401FFCC8401FFAE6E8DFF6334D4FF8D4899FF4F13
          CEFE4A08D1FF4A08D1FF4A08D1FF3E13E0FF4D25FAFF30168D8E06040007C493
          05DEDFA405FFCC8601FFCC8401FFCC8401FFCC8401FF7241CBFF7034BBFE4A08
          D1FF4A08D1FF4A08D1FF4909D1FF4C21F3FF4E23E5E607031717000000002219
          0027AF8304C6DB9E04FFCD8501FFCC8401FFCC8401FFC4834BF94918D1F64A08
          D1FF4A08D1FF4A08D1FF4C1DEBFF4722D5D61208363700000000000000000000
          0000000000003829013F976B02B4B87F00DF6E4D008400000000000000001B08
          5A643611B7CF3813AEC3170B4647020007070000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000160906256E2D1FCF411B1270000000004B1F14931308061E592418B66528
          19D63C19116B26100B40451B128400000000180A072C451B1284000000000000
          0000562417AB431104FF612316F6000000007F3223F9652B1EA4642518F16527
          1ADF632316FE612A1C985E2113FE65271ADF612316F65C2113FA000000000000
          000065271AEF5E2E34F36D271CFF37181056843828D7803526D400000000692D
          1EA5893529FE60291D9B833827DE612518E2591F12F967291CDB000000000000
          00004B3451FD2766A1BB883A29DB803526D46C2E20AA8B392AF254251A7D8B38
          28FD55251986000000003D1B1258853426FB782F21FB55251986021522241E77
          BDCC2189DEFA02243234421E145F8B3828FE56261A808B3828FD1409061E8E38
          2AFB8B3929EE803526D4000000008F3E2CE4883528FF1308061E00283637002E
          3F3F00171F1F0000000000000000000000000B05030F461E146F000000000000
          0000371810561C0C082C00000000050201073818105600000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000F0F0F1F1F1F
          1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F
          1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1717172F5F5F5FBE8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF5F5F5FBE8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF5F5F5FBE8080
          80FF808080FF808080FFAAAAAAFFAAAAAAFF989898FF939393FF8D8D8DFF8787
          87FFA1A1A1FFA6A6A6FFA7A7A7FFA1A1A1FFACACACFF808080FF5F5F5FBE8080
          80FF808080FF808080FFD3D3D3FFC2C2C2FFCFCFCFFFCFCFCFFFCDCDCDFFC9C9
          C9FFCDCDCDFFC3C3C3FFC2C2C2FFBBBBBBFFC5C5C5FF808080FF5F5F5FBE8080
          80FF808080FF808080FFAEAEAEFFA6A6A6FF939393FFADADADFFA1A1A1FFA5A5
          A5FFA1A1A1FFA5A5A5FF9D9D9DFF9D9D9DFFA7A7A7FF808080FF5F5F5FBEAAAA
          AAFFB2B2B2FFB1B1B1FFADADADFFB8B8B8FFAAAAAAFFA1A1A1FFAAAAAAFFB0B0
          B0FFB8B8B8FFB1B1B1FFAFAFAFFFB5B5B5FF808080FF808080FF5F5F5FBEC0C0
          C0FFC8C8C8FFD9D9D9FFCFCFCFFFD4D4D4FFBDBDBDFFD8D8D8FFC9C9C9FFD6D6
          D6FFC2C2C2FFD6D6D6FFD1D1D1FFCACACAFF808080FF808080FF5F5F5FBE8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF5F5F5FBE8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF5B5B5BB68080
          80FF808080FF808080FF808080FF808080FF808080FF808080FF808080FF8080
          80FF808080FF808080FF808080FF808080FF808080FF777777EE0B0B0B171F1F
          1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F
          1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F1F1F1F3F0F0F0F1F000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000904000F3F2000676231009E7F4100CE844300D66735
          00A6492500770E07001700000000000000000000000000000000000000000000
          00000000000022110037894700DE9E5100FF9E5100FF9E5100FF9E5100FF9E51
          00FF9E5100FF924C00EE3A1E005F000000000000000000000000000000000000
          00003F2000679E5100FF9E5100FF9E5100FF9E5100FF9E5100FF9E5100FF9E51
          00FF9E5100FF9E5100FF9E5100FF5D3000960000000000000000000000001D0E
          002F974D00F69E5100FF9E5100FF9E5100FF9E5100FF9E5100FF9E5100FF9E51
          00FF9E5100FF9E5100FF9E5100FF9E5100FF351B005700000000040200077F41
          00CEA25D31FFA25D31FFA66846FFAA7155FFAA7155FFA66746FFA66746FFA667
          46FFA66846FFA66846FFAA7155FFA66846FF924C00EE0E0700171D0E002F9E51
          00FFB2836DFFCAAFA5FFC6A99EFFC9ADA3FFC3A498FFC09D8FFFC3A397FFC8AD
          A1FFB48875FFC5A89DFFBE9A8BFFB99180FF9E5100FF3F2000673F2000679E51
          00FFB68B77FFAE7A62FFBB9686FFC09E90FFCCB4AAFFBC9686FFB2836DFFB283
          6DFFAA7255FFBB9585FFC7AA9EFFB99180FF9E5100FF5D3000966231009E9E51
          00FFB99180FFB68B77FFB48875FFAA7255FFA66846FFAA7255FFAA7255FFB68B
          77FFAA7255FFBB9585FFB88F7CFFA66846FF9E5100FF7F4100CE582D008E9E51
          00FF9E5100FF9E5100FF9E5100FFA25D31FFCAB1A7FFBC9686FFD8C6C0FFE6DC
          D8FFB99180FF9E5100FF9E5100FF9E5100FF9E5100FF763C00BE351B00579E51
          00FF9E5100FF9E5100FF9E5100FFC5A79BFFCAAFA5FFAD7A62FFDECFCAFFE3D8
          D4FFF0EAE8FF9E5100FF9E5100FF9E5100FF9E5100FF532B0086180C00279E51
          00FF9E5100FF9E5100FF9E5100FFC4A69BFFDBCBC5FFAD7A62FFF1EAE9FFD5C2
          BBFFF9F7F7FF9E5100FF9E5100FF9E5100FF9E5100FF3019004F000000006231
          009E9E5100FF9E5100FF9E5100FFAE7961FFBC9686FFA56846FFC09E91FFF6F2
          F0FFD3BEB6FF9E5100FF9E5100FF9E5100FF7A3F00C604020007000000000904
          000F894700DE9E5100FF9E5100FF9E5100FFA66846FFC6A99DFFCFB9B0FFAE7A
          62FF9E5100FF9E5100FF9E5100FF974D00F6180C002700000000000000000000
          00001D0E002F894700DE9E5100FF9E5100FF9E5100FF9E5100FF9E5100FF9E51
          00FF9E5100FF9E5100FF924C00EE351B00570000000000000000000000000000
          0000000000000904000F6231009E9E5100FF9E5100FF9E5100FF9E5100FF9E51
          00FF9E5100FF713A00B60E070017000000000000000000000000000000000000
          00000000000000000000000000000E0700172B1600474E28007F4E28007F3019
          004F1309001F0000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF172DB3FF172EB8FF020941FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF8A6200FF1328A3FF213EEBFF1A32C5FF000000FF000000FFC5C5C5FFB0B0
          B0FF626262FFA5A5A5FF6D6D6DFFCECECEFF464646FF000000FF000000FF5F41
          00FFDBA100FF000000FF05115CFF213DE6FF030E4DFF989898FFAAAAAAFF9090
          90FFA5A5A5FF909090FFC0C0C0FFAAAAAAFFB0B0B0FF000000FF000000FF8A62
          00FFBC8900FF000000FF000000FF0E1E86FF020941FFBCBCBCFFD7D7D7FFC0C0
          C0FFAAAAAAFF989898FFB0B0B0FF000000FF808080FF000000FF000000FF8A62
          00FFC38E00FF000000FF000000FF00A1AAFF005155FF898989FFC0C0C0FFE4E4
          E4FFB6B6B6FF626262FFB6B6B6FFB6B6B6FFA5A5A5FF000000FF000000FF5F41
          00FFD89E00FF000000FF006F77FF00EAF7FF003131FF000000FFB6B6B6FFA5A5
          A5FFA5A5A5FF626262FF6D6D6DFFC0C0C0FF313131FF000000FF000000FF0000
          00FF7D5900FF00BFC9FF00F1FFFF00BFC9FF000000FF000000FF000000FF0000
          00FF909090FF555555FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF00ACB6FF00B1BCFF003131FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
          00FF000000FF000000FF000000FF000000FF000000FF000000FF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5A58
          BBFF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF3835B5FFB7B7DBFFFFFFFFFFFFFFFFFFFFFFFFFF8B8A
          C9FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FFFBFBFDFFFFFFFFFFFFFFFFFFA0A0
          D1FF1A12B3FF1A12B3FF6664BFFF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FFEDEDF5FFFFFFFFFFFFFFFFFFBCBC
          DDFF706FC2FF706FC2FFA0A0D1FFA0A0D1FF8382C7FF7A79C4FF706FC2FF8B8A
          C9FFA0A0D1FF8382C7FF8B8AC9FF7A79C4FFDDDCECFFFFFFFFFFFFFFFFFFCBCB
          E4FFA0A0D1FF9A99CFFFA0A0D1FF8B8AC9FFC6C6E1FF8B8AC9FFC6C6E1FF3835
          B5FFBCBCDDFFB7B7DBFFA0A0D1FF9A99CFFFC6C6E1FFFFFFFFFFFFFFFFFFE5E5
          F1FFACACD6FFC6C6E1FFA0A0D1FFACACD6FFA6A6D4FF9A99CFFFBCBCDDFF9A99
          CFFF7A79C4FFACACD6FFA6A6D4FFB2B2D9FFB2B2D9FFFFFFFFFFFFFFFFFFF4F4
          F9FF8B8AC9FF5A58BBFFA0A0D1FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF1A12B3FF8B8AC9FF9A99CFFFFFFFFFFFFFFFFFFFFFFF
          FFFF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF706FC2FFFFFFFFFFFFFFFFFFFFFF
          FFFF8382C7FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF1A12
          B3FF1A12B3FF1A12B3FF1A12B3FF1A12B3FF3835B5FFFFFFFFFFFFFFFFFFFFFF
          FFFFE9E9F3FFA0A0D1FF8B8AC9FF8B8AC9FF8B8AC9FF8B8AC9FF8B8AC9FF8B8A
          C9FF8B8AC9FF8B8AC9FF8B8AC9FF8B8AC9FF8B8AC9FFFBFBFDFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000956D
          3C9AF2B363FCF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B5
          64FFF6B564FFF6B564FFF6B564FFF2B363FC946D3C990000000000000000F2B3
          63FCF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B5
          64FFF6B564FFF6B564FFF6B564FFF6B564FFF2B363FC0000000000000000F6B5
          64FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B5
          64FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FF0000000000000000F6B5
          64FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B5
          64FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FF0000000000000000F8CA
          8FFFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2
          E3FFFDF2E3FFFDF2E3FFFDF2E3FFFDF2E3FFF8CA8FFF0000000000000000F8C2
          80FFFBDEB9FFFBDEB9FFFBDEB9FFFBDEB9FFFBDEB9FFFBDEB9FFFBDEB9FFFBDE
          B9FFFBDEB9FFFBDEB9FFFBDEB9FFFBDEB9FFF8C280FF0000000000000000866C
          46FF866C46FF866C46FF866C46FF866C46FF866C46FF866C46FF866C46FF866C
          46FF866C46FF866C46FF866C46FF866C46FF866C46FF00000000000000004F47
          37FF4F4737FF4F4737FF4F4737FF4F4737FF4F4737FF4F4737FF4F4737FF4F47
          37FF4F4737FF4F4737FF4F4737FF4F4737FF4F4737FF0000000000000000BC8F
          53FDBE9155FFBE9155FFBE9155FFBE9155FFBE9155FFBE9155FFBE9155FFBE91
          55FFBE9155FFBE9155FFBE9155FFBE9155FFBC8F53FD0000000000000000966F
          3D9CF2B363FCF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B564FFF6B5
          64FFF6B564FFF6B564FFF6B564FFF2B363FC966D3D9B00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000009F9F9DB9E8E8
          E7F2E5E3E2F1E4E3E1F1E4E3E1F1E4E3E1F1E4E3E2F1E4E3E1F1E4E3E1F1E4E3
          E2F1E4E3E1F1E4E3E1F1E4E3E1F1E4E3E2F1E8E8E7F2A09F9DB9E0DFDDFAFFFF
          FEFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFF
          FDFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFDFFE0DFDDFADCDAD8F1DDDB
          D9FF8F8F8DFFABAAA9FFBCBBB9FFBAB9B7FFAFAEACFFC4C3C1FFB2B1AFFFB5B4
          B3FFC1C0BEFFB0AFADFFACABAAFFBDBCBAFFE0DFDCFFDAD9D7F1DCDBD9F1CCCA
          C8FF4C4B4AFF9D9B9AFF7F7F7DFF989694FFA2A09FFF767573FF6F6E6CFF8282
          81FF878685FF8B8A88FFA9A8A6FF7B7A79FFD6D4D1FFDBD9D7F1DCDBD8F1CFCD
          CBFF5C5B5AFF8F8E8CFFA4A3A1FFD6D5D3FFC8C6C4FFAFADABFFC8C6C4FFCBCA
          C7FFA19F9EFFC8C7C5FFC5C3C1FFB9B8B6FFCFCDCBFFDBD9D7F1E7E7E6F1DAD9
          D8FF5E5D5DFF666666FF90908FFF969696FF9B9A9AFF9C9C9BFFAFAFAEFFA1A0
          A0FF979796FF868685FFABABAAFF949493FFDCDBDAFFE6E5E4F1E8E7E6F1DBDA
          D9FF434343FF50504FFF656564FF3B3B3BFF404040FF757474FF6C6C6CFF4A4A
          49FF535352FF252525FF5A5959FF696868FFDEDEDDFFE6E5E4F1E3E2E1F1E4E3
          E2FF7C7B7AFF848383FF959594FF7D7D7CFF80807FFFA09F9EFF9D9C9CFF8786
          85FF8B8A8AFF6E6E6DFF919090FF989796FFE6E6E5FFE2E1E0F1E1E1E0FAFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E1E0FA9F9F9DB9E8E7
          E6F2E4E3E2F1E4E3E2F1E4E3E2F1E4E3E2F1E4E3E2F1E4E3E1F1E4E3E2F1E4E3
          E2F1E4E3E2F1E4E3E2F1E4E3E2F1E4E3E2F1E8E7E6F29F9F9DB9000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000001315001C1315001C0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000002020003484F006A929F00D6929F00D6484F
          006A020200030000000000000000000000000000000000000000000000000000
          00000000000000000000020200034E540072A7B600F5AEBD00FFAEBD00FFA7B6
          00F54E5400720202000300000000000000000000000000000000000000000000
          000000000000010100014A51006DA9B700F7AEBD00FFAEBD00FFAEBD00FFAEBD
          00FFA9B700F74C52006F01010001000000000000000000000000000000000000
          000003030004232600334E5400727A8500B3ADBC00FDAEBD00FFAEBD00FFAEBD
          00FF869200C55057007522250032030300040000000000000000000000000202
          00034D5400719EAC00E89AA700E15B6300856F7900A3ADBC00FEAEBD00FF7F8A
          00BA52590078939F00D79EAC00E84D540071020200030000000000000000484F
          006AA7B600F5AEBD00FFAEBD00FFA7B600F55D6500886E7700A17B8500B4535A
          00799EAC00E8AEBD00FFAEBD00FFA7B600F5484F006A000000001315001C929F
          00D6AEBD00FFAEBD00FFAEBD00FFAEBD00FFA7B600F5666E00955B6300869FAD
          00E9AEBD00FFAEBD00FFAEBD00FFAEBD00FF929F00D61315001C1315001C929F
          00D6AEBD00FFAEBD00FFAEBD00FFAEBD00FFA7B600F5666E00955B6300869FAD
          00E9AEBD00FFAEBD00FFAEBD00FFAEBD00FF929F00D61315001C00000000484F
          006AA7B600F5AEBD00FFAEBD00FFA7B600F55D6500886E7700A17B8500B4535A
          00799EAC00E8AEBD00FFAEBD00FFA7B600F5484F006A00000000000000000202
          00034D5400719EAC00E89AA700E15B6300856F7900A3ADBC00FEAEBD00FF7F8A
          00BA52590078939F00D79EAC00E84D5400710202000300000000000000000000
          000003030004232600334E5400727A8500B3ADBC00FDAEBD00FFAEBD00FFAEBD
          00FF869200C55057007522250032030300040000000000000000000000000000
          000000000000010100014A51006DA9B700F7AEBD00FFAEBD00FFAEBD00FFAEBD
          00FFA9B700F74C52006F01010001000000000000000000000000000000000000
          00000000000000000000020200034E540072A7B600F5AEBD00FFAEBD00FFA7B6
          00F54E5400720202000300000000000000000000000000000000000000000000
          000000000000000000000000000002020003484F006A929F00D6929F00D6484F
          006A020200030000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000001315001C1315001C0000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 816
    Top = 8
    PixelsPerInch = 96
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 9526278
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Font.Quality = fqClearType
      TextColor = clWindow
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
    end
  end
  object cxStyleRepository3: TcxStyleRepository
    Left = 768
    Top = 8
    PixelsPerInch = 96
    object cxStyle13: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
    end
  end
  object tmrCarregaCartaoParaVincular: TTimer
    Enabled = False
    Interval = 400
    OnTimer = tmrCarregaCartaoParaVincularTimer
    Left = 392
    Top = 271
  end
end
