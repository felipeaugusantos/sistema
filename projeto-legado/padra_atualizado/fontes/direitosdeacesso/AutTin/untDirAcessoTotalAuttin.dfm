inherited frmDirAcessoTotalAutTin: TfrmDirAcessoTotalAutTin
  Width = 900
  Height = 588
  Caption = 'Direito de Acesso Total (AUTTIN)'
  ExplicitWidth = 900
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 514
    Width = 894
    Height = 29
    ExplicitTop = 514
    ExplicitWidth = 894
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Width = 813
      Height = 25
      ExplicitWidth = 813
      ExplicitHeight = 25
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Height = 24
        Align = alLeft
        Caption = '[ F10 ] &Gravar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        ModalResult = 0
        NumGlyphs = 1
        ExplicitWidth = 113
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 815
      Top = 2
      Height = 25
      Align = alRight
      ExplicitLeft = 815
      ExplicitTop = 2
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 543
    Width = 894
    ExplicitTop = 543
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object pnlDirOpe: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 438
    Height = 468
    Align = alClient
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object cxgCadOpe: TcxGridCitel
      AlignWithMargins = True
      Left = 4
      Top = 51
      Width = 430
      Height = 384
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object tbvCadOpe: TcxGridDBTableViewCitel
        OnDblClick = tbvCadOpeDblClick
        OnKeyDown = tbvCadOpeKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = tbvCadOpeCustomDrawCell
        DataController.DataSource = dtsCadOpe
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.OnGetContentStyle = tbvCadOpeStylesGetContentStyle
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object OPE_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'OPE_MARDES'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Images = cxImageList
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
          Properties.ShowDescriptions = False
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          Width = 23
          IsCaptionAssigned = True
        end
        object OPE_CODOPE: TcxGridDBColumn
          AlternateCaption = 'CODOPE'
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'OPE_CODOPE'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          Width = 58
        end
        object OPE_NOMOPE: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'OPE_NOMOPE'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 319
        end
      end
      object cxgCadOpeLevel1: TcxGridLevel
        GridView = tbvCadOpe
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 438
      Width = 436
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      object btnMarOpe: TBitBtnLocked
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 162
        Height = 23
        Align = alLeft
        Caption = '[ ENTER ] &Marcar / Desmarcar'
        TabOrder = 0
        OnClick = btnMarOpeClick
      end
      object btnMarOpeTot: TBitBtnLocked
        AlignWithMargins = True
        Left = 171
        Top = 3
        Width = 110
        Height = 23
        Align = alLeft
        Caption = '[ F4 ] &Marcar Todos'
        TabOrder = 1
        OnClick = btnMarOpeTotClick
      end
      object btnDesOpeTot: TBitBtnLocked
        AlignWithMargins = True
        Left = 287
        Top = 3
        Width = 123
        Height = 23
        Align = alLeft
        Caption = '[ F5 ] &Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesOpeTotClick
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 436
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label1: TLabel
        Left = 4
        Top = 3
        Width = 69
        Height = 14
        Caption = 'Operadores:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlPesqOperador: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 23
      Width = 430
      Height = 25
      Margins.Top = 5
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Ctl3D = True
      ParentBackground = False
      ParentColor = True
      ParentCtl3D = False
      TabOrder = 0
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 430
        Height = 25
        Align = alClient
        ExplicitWidth = 429
        ExplicitHeight = 23
      end
      object Image1: TImage
        AlignWithMargins = True
        Left = 3
        Top = 4
        Width = 22
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF61000000097048597300000EC200000EC2011528
          4A8000000012744558745469746C650046696E643B5365617263683BAD078F62
          0000016A49444154785EA591CD4A02611486BD8A46A789F1278568DFD65DB408
          341A1DB5C69F748CB983C84D942EEC565A0981E6FC383FB60964EA0A0A6951B6
          19086C33703A332048F6CDC617DE8FB3799F73CE774200B096FD67A16DD14CC7
          1B660FFD1EAB1B9E7BD19A990EAD6A159014CD56B26941EA7C0C471D1BB23736
          24C43144AB06B015BD1504F03B27450B326D1BA65F3FB090571F5E4D802D8F80
          A98C0E8800EC64ED4A8F7EE0AF5E3FE6906A18C008EA3D11106F584EF1F60548
          CA759E8139D1666440DD740A5D32806BDB0850C880E89961ED4816BC7DCEFF5D
          2151D7812E05ACE09D8AAD99AEF761D3D9D22762BD7FF9049B25052225B51D78
          46B632BAC07341ACAA43F67A0219342B6818D6BC30448AAA4BF3324F02F862CA
          CADE96A0F79953CDA105348E4D17D52E861180531414974208014056981F4A18
          86302F4398935D8A937912800CE18612951F009597813AEE7F1300C1DAC83D34
          A97CDFD9E00677CB8075BC3EE0171A811CE8F7E0E9CD0000000049454E44AE42
          6082}
      end
      object edtPesqOperador: TEdit
        AlignWithMargins = True
        Left = 29
        Top = 6
        Width = 388
        Height = 13
        Margins.Bottom = 0
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        OnChange = edtPesqOperadorChange
        OnEnter = edtPesqOperadorEnter
        OnExit = edtPesqOperadorExit
        OnKeyDown = edtPesqOperadorKeyDown
      end
    end
  end
  object pnlDirGpo: TPanel [3]
    AlignWithMargins = True
    Left = 447
    Top = 3
    Width = 444
    Height = 468
    Align = alRight
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object cxgCadGpo: TcxGridCitel
      AlignWithMargins = True
      Left = 4
      Top = 51
      Width = 436
      Height = 384
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object tbvCadGpo: TcxGridDBTableViewCitel
        OnDblClick = tbvCadGpoDblClick
        OnKeyDown = tbvCadGpoKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = tbvCadGpoCustomDrawCell
        DataController.DataSource = dtsCadGpo
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.OnGetContentStyle = tbvCadOpeStylesGetContentStyle
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object GPO_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'GPO_MARDES'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Images = cxImageList
          Properties.Items = <
            item
              ImageIndex = 0
              Value = 'S'
            end
            item
              ImageIndex = 1
              Value = 'N'
            end>
          Properties.ShowDescriptions = False
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          Width = 23
          IsCaptionAssigned = True
        end
        object GPO_CODGPO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'GPO_CODGPO'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          Width = 55
        end
        object GPO_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'GPO_DESCRI'
          Options.Editing = False
          Options.Focusing = False
          Options.AutoWidthSizable = False
          Options.Grouping = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 321
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = tbvCadGpo
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 438
      Width = 442
      Height = 29
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      object btnMarGru: TBitBtnLocked
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 162
        Height = 23
        Align = alLeft
        Caption = '[ ENTER ] &Marcar / Desmarcar'
        TabOrder = 0
        OnClick = btnMarGruClick
      end
      object btnMarGruTot: TBitBtnLocked
        AlignWithMargins = True
        Left = 171
        Top = 3
        Width = 110
        Height = 23
        Align = alLeft
        Caption = '[ F7 ] &Marcar Todos'
        TabOrder = 1
        OnClick = btnMarGruTotClick
      end
      object btnDesGruTot: TBitBtnLocked
        AlignWithMargins = True
        Left = 287
        Top = 3
        Width = 120
        Height = 23
        Align = alLeft
        Caption = '[ F8 ] &Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesGruTotClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 442
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object Label2: TLabel
        Left = 5
        Top = 3
        Width = 123
        Height = 14
        Caption = 'Grupo de Operadores:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlPesqGrupo: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 23
      Width = 436
      Height = 25
      Margins.Top = 5
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Ctl3D = True
      ParentBackground = False
      ParentColor = True
      ParentCtl3D = False
      TabOrder = 0
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 436
        Height = 25
        Align = alClient
        ExplicitHeight = 23
      end
      object Image2: TImage
        AlignWithMargins = True
        Left = 3
        Top = 4
        Width = 22
        Height = 17
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF61000000097048597300000EC200000EC2011528
          4A8000000012744558745469746C650046696E643B5365617263683BAD078F62
          0000016A49444154785EA591CD4A02611486BD8A46A789F1278568DFD65DB408
          341A1DB5C69F748CB983C84D942EEC565A0981E6FC383FB60964EA0A0A6951B6
          19086C33703A332048F6CDC617DE8FB3799F73CE774200B096FD67A16DD14CC7
          1B660FFD1EAB1B9E7BD19A990EAD6A159014CD56B26941EA7C0C471D1BB23736
          24C43144AB06B015BD1504F03B27450B326D1BA65F3FB090571F5E4D802D8F80
          A98C0E8800EC64ED4A8F7EE0AF5E3FE6906A18C008EA3D11106F584EF1F60548
          CA759E8139D1666440DD740A5D32806BDB0850C880E89961ED4816BC7DCEFF5D
          2151D7812E05ACE09D8AAD99AEF761D3D9D22762BD7FF9049B25052225B51D78
          46B632BAC07341ACAA43F67A0219342B6818D6BC30448AAA4BF3324F02F862CA
          CADE96A0F79953CDA105348E4D17D52E861180531414974208014056981F4A18
          86302F4398935D8A937912800CE18612951F009597813AEE7F1300C1DAC83D34
          A97CDFD9E00677CB8075BC3EE0171A811CE8F7E0E9CD0000000049454E44AE42
          6082}
      end
      object edtPesqGrupo: TEdit
        AlignWithMargins = True
        Left = 30
        Top = 6
        Width = 388
        Height = 13
        Margins.Bottom = 0
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        OnChange = edtPesqOperadorChange
        OnEnter = edtPesqOperadorEnter
        OnExit = edtPesqOperadorExit
        OnKeyDown = edtPesqOperadorKeyDown
      end
    end
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 474
    Width = 894
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblAltGrd: TLabel
      Left = 12
      Top = 22
      Width = 302
      Height = 14
      Caption = '[ F11 ] Alternar foco entre Operadores e Grupo de Operadores'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 30
      Top = 5
      Width = 94
      Height = 13
      Caption = 'Registros Marcados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object cxImage3: TcxImage
      Left = 4
      Top = 1
      TabStop = False
      Picture.Data = {
        0D546478536D617274496D61676589504E470D0A1A0A0000000D494844520000
        00100000001008060000001FF3FF61000000017352474200AECE1CE900000004
        67414D410000B18F0BFC610500000021744558745469746C65004170706C793B
        4F4B3B436865636B3B426172733B526962626F6E3B6463C868000003A6494441
        54384F4D937D50D3751CC77FA2AB0CCE844EAD331B0339C6C38603EDCE23E808
        65E4248ABA150B27D1648E8D1288A734E681131FB8AC29036CCB8C553320F008
        5C20C822260F4D6C83C538509EDA788807818CFE7AF7FDCDBAEB77F7BAFBDD7D
        3FEFD7E7F3B9FB7EA9C995066AEEA18922DF3AC2FA8C0BEC985C6DA8EE7835A7
        5F69085B507ECBED3FA1E7346495070BC9F963048FF9BFCC94EBCF1BD4D44A3D
        45B9568DEE7052166B5BA63AC8585AB30FAD5615EC4E03E656BB30345303D3D0
        59A89B0528F832B44F54E81748379A7D78EB91800E0BD299CF647C1A3C6C301D
        C3E4721386972A3130AFC29DB95CD817CF6074590BD76A0B1A2D05C8D7716793
        F3FDB824E731B15CE7166C78EF34BBA9CE5C00C7C26574FC7E049D2E09CC2E19
        BAA7E5E89951A067568E66BB18BFCD57A0D5761A8ACF42ACDB777A7AD1CDA9A4
        6C3FFE716D2CEC7F94A3E5BE086D1362DC9A7A1726A7045D4E296E4F4B517475
        2F0E64322139CF8663B11265B509385414904937A7DEFE28A0A6A13B1F37C7D2
        7063544824C9681B4F413B1199A60E435AC646DE27328C8C3BC1976FC30F4387
        D13658823455A099083652C242FF91764701AE0F2741DD128518D946E469C360
        BCF71672AA3828D2E4C035BB04C599445C6E15E1C77BEFE0F6841269A5EC3522
        F0A2DECCF35F363AD261B0C52146EA893EAB15F91732102BF7768727A71FE0FC
        57D9507D1347A613A3DE71103F4DC8917A2A102191DECF52AF65FBDED7F70A60
        B0EE83BA311119C5AFC239B384A6CE0E8C4E2E6260F40E1273B7C338928ADAA1
        787C67E7A376E075883E0EA027D844252858CD658D51B862D98B6B83021457C7
        A2B8428685076B5858F91B87947B70F567210C83B1D0DBA2A1FFF54594DF8CC1
        1B392C0B1178522F8B7788D3CF71F185251215BDBB70CD264056F96EE8EA4B61
        EABF8ED473FE64BDFDB8D2FF023EB744A0FA6E348E5DE2812F795E49048F13A8
        270572DFBB27BEE6A2AA37029A6E2E59E720524A7C1129A5A069DF8FAA3E1E2A
        09DA5F76A3A48E87C40F58362F1FC6D324EB410BD647C46FE52564FACD7FA80B
        228230687AB8644F219A868F424726D3F4EC22F27014EA439094E3BF161EB725
        8AE4189D13EF5394695C464B18E1F15BF71C90F98EA49CDC89A2DA20A8BB4271
        A99B838B660E4E7E1F8C5455005E39CA1CE03D0AD3A3AF73673BC624B4807E89
        1BC8583ED1C9CF15C6499866819C05370A16F84798D697443B4E793EC5D842EA
        18743D9D7367FFFBF95744EF44DBE97BBE99E043F0266C223C41F0F87F7DC798
        84FA070244118F93E074F30000000049454E44AE426082}
      Properties.ReadOnly = False
      Style.BorderStyle = ebsNone
      Style.Color = clWindow
      TabOrder = 0
      Transparent = True
      Height = 22
      Width = 29
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 8
  end
  object dtsCadOpe: TDataSource
    Left = 208
    Top = 221
  end
  object dtsCadGpo: TDataSource
    Left = 624
    Top = 213
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 24969681
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
      end>
  end
  object Styles: TcxStyleRepository
    Left = 80
    Top = 152
    PixelsPerInch = 96
    object cxsFoco: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TextColor = clWhite
    end
    object cxsSemFoco: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TextColor = clNavy
    end
  end
  object tmrPesquisar: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrPesquisarTimer
    Left = 425
    Top = 190
  end
end
