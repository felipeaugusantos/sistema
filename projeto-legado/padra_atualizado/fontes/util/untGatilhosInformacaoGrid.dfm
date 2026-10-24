inherited frmGatilhosInformacaoGrid: TfrmGatilhosInformacaoGrid
  Width = 1024
  Height = 665
  Caption = 'Gatilhos de Informa'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 665
  PixelsPerInch = 96
  TextHeight = 14
  object cxgGatilhos: TcxGrid [0]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1012
    Height = 587
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgGatilhosView: TcxGridDBTableView
      OnDblClick = cxgGatilhosViewDblClick
      OnKeyDown = cxgGatilhosViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.DataSource = dtsSpoImp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Total: #,##0 documentos'
          Kind = skCount
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' documentos para exibir>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glVertical
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxgGatilhosViewGAT_CODIGO: TcxGridDBColumn
        DataBinding.FieldName = 'GAT_CODIGO'
        HeaderAlignmentHorz = taCenter
        Width = 41
      end
      object cxgGatilhosViewGAT_DESCRI: TcxGridDBColumn
        Caption = 'T'#237'tulo de Envio'
        DataBinding.FieldName = 'GAT_DESCRI'
        Width = 156
      end
      object cxgGatilhosViewREL_DESCRI: TcxGridDBColumn
        DataBinding.FieldName = 'REL_DESCRI'
        Width = 157
      end
      object cxgGatilhosViewGAT_CODEMP: TcxGridDBColumn
        DataBinding.FieldName = 'GAT_CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 40
      end
      object cxgGatilhosViewOPE_NOMOPE: TcxGridDBColumn
        DataBinding.FieldName = 'OPE_NOMOPE'
        Width = 104
      end
      object cxgGatilhosViewOPE_NUMWPP: TcxGridDBColumn
        DataBinding.FieldName = 'OPE_NUMWPP'
        OnGetDisplayText = cxgGatilhosViewOPE_NUMWPPGetDisplayText
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object cxgGatilhosViewOPE_E_MAIL: TcxGridDBColumn
        DataBinding.FieldName = 'OPE_E_MAIL'
        HeaderAlignmentHorz = taCenter
        Width = 104
      end
      object cxgGatilhosViewGPE_DESCRI: TcxGridDBColumn
        DataBinding.FieldName = 'GPE_DESCRI'
        HeaderAlignmentHorz = taCenter
        Width = 89
      end
      object cxgGatilhosViewGAT_DIAENV: TcxGridDBColumn
        Caption = 'Quando Enviar'
        DataBinding.FieldName = 'GAT_DIAENV'
        HeaderAlignmentHorz = taCenter
        Width = 124
      end
      object cxgGatilhosViewGAT_HORENV: TcxGridDBColumn
        DataBinding.FieldName = 'GAT_HORENV'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object cxgGatilhosViewGAT_FERENV: TcxGridDBColumn
        DataBinding.FieldName = 'GAT_FERENV'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object cxgGatilhosViewGAT_STATUS: TcxGridDBColumn
        DataBinding.FieldName = 'GAT_STATUS'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
    end
    object cxgGatilhosLevel: TcxGridLevel
      GridView = cxgGatilhosView
    end
  end
  inherited pnlBotoes: TPanel
    Top = 593
    Width = 1018
    Height = 27
    TabOrder = 1
    ExplicitTop = 593
    ExplicitWidth = 1018
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Left = 322
      Width = 617
      Height = 23
      ExplicitLeft = 322
      ExplicitWidth = 617
      ExplicitHeight = 23
      object btnCopiarGatilho: TcxButton
        Left = 0
        Top = 0
        Width = 160
        Height = 23
        Align = alLeft
        Caption = '[F3] &Copiar Gatilho '
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = True
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000025744558745469746C6500436F70793B426172733B526962626F6E3B
          5374616E646172643B436C6F6E656D0EDF5B000001B649444154785E7D90318B
          53411446CF7DD94D229AC24A2BC1CADE56248D8A76D65A2B6C6721DA0A82D66A
          A1A58DFD7656168B0B36D6AB85827F40566159F3E6CDBD9F929921210B4E3317
          1EE7BC33D724B17E66B3D9E8F9EBBD0F9DD95C18104842180290109053FAF8E4
          C18D6B5B9C3C9DD07CE7CE65A0C9A9F06A7EF1F6F35560B4149899011D6093C9
          647CE1FC1952EAF9B37000A28266DD3F62C47432C2B303582BE89EBDF954B265
          7CF97EC8C1B79F88AE660702CE9D9D72FBE62526E35364DF10483E7F74FFCA7F
          B39FBEDA27E78C24D210EB02CC73418E6BB6B07207C8C474DC2DB3DD45881305
          960747802464566E00A3CC1572050A11454013903C00080C095001010221897E
          88B5026D3E21832042C8A83308812850CE840721E1B1B18361080484B4064351
          14B1BB2384043E6C1464CFE54314A87A304140CB66BADD11802B00B47AC29254
          2D68FF368450D4820876DF1FF0F5C711B93FDA07721330785058519750E02613
          780A1EEE5CBF381E8F7F0103B06802A2EEE0F4740B54F090210588964D4AE9B0
          EFFBDF8D6B02EFD3F1DEBDC7BB73B15AA299AABD088645C906D814A4772FEFDE
          02B601033879A396BD2EF80B61825062DDA3F2C70000000049454E44AE426082}
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        TabOrder = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnCopiarGatilhoClick
      end
      object btnExcluir: TcxButton
        Left = 160
        Top = 0
        Width = 160
        Height = 23
        Align = alLeft
        Caption = '[F4] &Excluir Gatilho'
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = True
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000023744558745469746C650043616E63656C3B53746F703B457869743B
          426172733B526962626F6E3B4C9696B20000038849444154785E1D906B4C5367
          18C7FF3DBD40CB1A2E32B55C9D598B4CA675D8D13836652E9B0359B67D589665
          3259E644A52571644474CB4CB6ECC23770C4449DD38D2885005E4683AB69C616
          8DA12384264EC8AAAC0C9149A1175ACEE9E939CFDE9EE7E477F2CBFFB924E720
          E6E943CC3B8895D12B00A0FEE3D08167A75A5BBAEEB71D9D081E6B4DA549FBDD
          A3CEEFDD1F3658016818AA98A71FD1915E202DE980A19D741E3EF6E0F8A7FC7F
          673B6979E002C5BC43B4C2581EB8480BE7BA68E6441BEF3B72F03300990C8E1D
          5016554E7B55D6C1ED9543C6C2B5BB739FDF025988838424E4240F10A0D2EAA0
          D26540AD37203CFE17C2C187A3EDBFDE7CF3DAD4748403A06EA8A8E830AC5FB3
          3B7BAB1901B717AE23DFE1CEC5EBEC90A0E0EB71A3CFD981C0B017C6F252180B
          D6BD74BCFA856E003A0CBDFD966DF250532AD4FF038DB734D18557DF21CFB08F
          2E37B5D370ED5E72D7D52BEEF9654CE9F91C1FD392EB0C4D3A0E4BE7F6ECD909
          CFDEFAD381AF4ED0A3D35FD399E272BA3F3D478F971234FD2044BDCE930AF798
          CF2FAED0DF5373CACCFCA92F2970B29DDCAFD7F56B48945E918201C41738945A
          2D581C7461ADA3192AB50AD64F9A010272730CC8D4AA313BE44289D58CF85D3F
          2411504BB28D93845489145E041F9CC1863C09A11BD7E1EFEA86240339463DB2
          B3F59025C0DFD98DD0C83594E6886C360831F408523265D208BC0021B20A35A7
          82B8BC0429C2239A10D812417988007088B14C8A8421EA75A094044A8A48F200
          17E78587629220B370E69F2884EA3750F07E23245946868E43A64EA3B8695F23
          F8EA7A046763EC780AC9640AF155FEB1269AE0BD91AC8CFDF910108E26F15A5B
          33788D1E860CF6CDE7CF225D45FB3F02A0C7CE36076E5CBD84825C3562A20E4B
          097E0CAD051B5FFCA97C9BE4ABAEA05B2FDBE9E6BE0F880F8568FCDB0E1AA9AA
          646C579C654AEF564D15FDB96333FDBCC94A8E751B6A0140DF5168B9E42A7B86
          266AB6D2ED1A1BF559CAC853B58DFCB576F2D7D9D3AE64B777D96862D716EA2F
          2BA76F4CE62B008C1A00C2F9C57F9D8DA2C99212C5E72C85323699F320A77FD2
          72040021DF9885F56BF2204457706F9EC74C4CF2F744169A012430DBF21E00A8
          2B754F98BEC82EEEED7AF2291A306FA451EBD3346633938FF13BF341969D62BD
          CF738AAF6ED6EA4B006882CE77A14ABFD255D2799903606830E4EF28E274070C
          1C67D74255041044C25C9CE43B4149F8B16735F41B8038DB9300E07F6924ECFB
          01D589CC0000000049454E44AE426082}
        ParentShowHint = False
        ShowHint = True
        SpeedButtonOptions.CanBeFocused = False
        TabOrder = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 23
      Align = alRight
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 23
    end
    object btnIncluir: TcxButton
      Left = 2
      Top = 2
      Width = 160
      Height = 23
      Align = alLeft
      Caption = '[F1] &Novo Gatilho'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001B744558745469746C65004164643B506C75733B426172733B526962
        626F6E3B9506332F0000036349444154785E35927D6C535518C69F73EE6DEB64
        63A3AEFB60A3A36E33B8C56581E0D8707E21CC1A43A2A22304FE3001512A86C4
        E900132451FF503367420043B244364C483031465C248B4441C0980C45B4D065
        CDBA4ECAE82AAC5DBBDE8FF3E1BD27F1397973DE9C3CBFF7233964226FC2D543
        A53E0280443E3FD752525AB14323FA06685A3381E492F329C6ADF39954E2F8C9
        C3DBA6018858DE940A9C2C5870C1D51BB6FAF61DBB327860F81A1BFE25297FB8
        3127C7EFE4E5D5745E9EBB9991239766E481937FE4DE1818DB0DC0EB322EABBA
        B63FD5EB7D6CCBBE6F1B83FE9E67BA82E084C0E4123697CAE0D109BC94805B0C
        E7AFCC606A66EEECF75FBCBB753AFAEB2201A0BD3E7861B02914D8DBF34408A9
        AC0D2181D3672E23319D81AB950D016CEBED824E809A722FC62E4CE17A343130
        D4DF73507FB9FFAB551E9F6FCF93EB82B879BB088D52504A14FCC9CE4E95F79D
        B80CD396284A8179C7D3DD1144F29FEC5BE1D73E1BA6BEB2C09BEDCD955A7CCE
        44D1744C1687C9045C05EBFC686F0DAADCB08413D2098E89B4E1BC5779965687
        5ED585D03ACBFDA548E7197EFA711C776EDFC5FF12200A7075F4E85975D7D4FA
        F1F4A635A82C5F02A2956CD46D2EEB1D160B455BC19FEE5E0F4A885A45828071
        81137D1B61DB0C1E5D43E4C8CF5858E4D0A1810BBA5CB76DEEBDB768C1E604AE
        EA6B1F40D9121F0A265385BC0E5457530109404A8010E27805EEE60598CDA15B
        8699C8E7CD4784EEC3F2BA00767C340A4AA9327E79300CE1505BDEFF0E9AA681
        5082150DD5604CA26858282E1693D428E42F6666B3909068EF68C5E6171FC7E6
        17BA611A260C93A9029C713CF7FC3A3C1BEE404B5B2398E0989FCBA190FD774C
        CFA46243B11B4B77ADADF67BB236478E10500AA5D2121D5C48354D3A674108A1
        56114C201E4BB1D9F86FA70880FB1EDD3E34B0A229B4E7E1350FC2E22E2011BF
        16C3FCBD050557562DC3CA964608B8B4C4E49F4924A27F1F193F1DD9AF03B0FE
        1AFDE03D113EDC6431B1A96575089212B4AD6D555F581280D902398343308EC9
        EB49DC9A981A75E043000CA46D09005A49457059DB4BC78E77EDFCDAEAFDF892
        DC3B1295EF7C13977D4E444E45E52BCE5BE7AE338555E10FDF0650EE32B30E4B
        D24C0212A8F210EAAED3D01969BB3FD0BCDDE32BEB06D56AD5D09CCDDA66EE62
        EED6EF43A9AB2331008603ABCEFF019D3AAD15CCD8D2E00000000049454E44AE
        426082}
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.CanBeFocused = False
      TabOrder = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnIncluirClick
    end
    object btnAlterar: TcxButton
      Left = 162
      Top = 2
      Width = 160
      Height = 23
      Align = alLeft
      Caption = '[F2] &Alterar Gatilho'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000020744558745469746C6500456469743B426172733B526962626F6E3B
        5374616E646172643B3013C3DB0000028449444154785E5D515D48145114FEEE
        CE9AA662FE942B1499246108D94B106588D24B461914843DD443500FF590D81F
        F550D443692F86A1A084AB581AD90F124260A4596AB14A96B556AC6192FDA045
        AEB3BBCE9DB9B77BE732BBEA99F9CEB9C39CEF3BDF9C219C731042B496CEB167
        9AA6157170C89045BE53C758A286D177F4C0A69D826700801B2A5C42A4E85069
        2E9CE08B12711EE07DFC6907004DD16202C4B254834119B823C2559297BA092C
        66D9FD4B05603135832D602BBEE348C134B923B0D40175BE3B4A8AED80280191
        2D93D9FDAF6E6C4744A70B05542B63311224513A23CA8D26EAE6BC3400482C3C
        DB6F00A02E47C0A41694650E0680896AC933E1F699886ACCCF636EB419DD97B6
        FC6A3ABEB10A4092E300865A22989CCA17FF46108648288C89170DC84D1B41CE
        E17BF0B7579CBAFE3DE88E3A60A6691319531305D462B920EB3AC69FD7211583
        C8D9530DFAB5067F3E04A045CC93D11D50CA94804CB610E0727184F520023DF5
        58A5F9B07E5F0DC21FABF1A6B907C8F4E0CBCFC9A69880A5044489EE7D6EF61F
        C67BEA904986B0E1602D667D573174A70FD64A0FDA6E0FB77AC782179C25C2B2
        991CC9091A92E25D6086B47D0B19F435F2CA6B31DD7BD19E1C4E4E87D7FBB65D
        90CF0198761C987A48EFBD7CB3BF880358E34900D7032808FA905F598FA9AE4A
        8C3E194638291D775BDFDFEF98089F01F0BBDCB3CC74362D9D2C1748115821B0
        2E6FEB91879D0DD7B83E39C8BB8E65F3F613F9BC6C75FC0300D902EE40DB2EEC
        CF888314588497D5DB00606D4149C58F77034F794BD5797EA538979766C53F02
        902310E76F2C81BFB1187B5335B8B12422212A0BF9F67924ABB0AC6F8646FE0E
        249A531D33A1F96E697B778A464F57F6AA8100FE037C7D7091F11B3976000000
        0049454E44AE426082}
      ParentShowHint = False
      ShowHint = True
      SpeedButtonOptions.CanBeFocused = False
      TabOrder = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnAlterarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 620
    Width = 1018
    TabOrder = 2
    ExplicitTop = 620
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 184
  end
  object qryGatilhos: TUniQuery
    SQL.Strings = (
      'SELECT SQL_NO_CACHE   '
      '  A.GAT_CODEMP,'
      '  A.GAT_CODIGO,'
      '  A.GAT_DESCRI,'
      '  CONCAT(A.GAT_CODREL, '#39' - '#39', B.REL_DESCRI) AS REL_DESCRI,'
      '  D.GPE_DESCRI,'
      '  CONCAT(C.OPE_CODOPE, '#39' - '#39', C.OPE_NOMOPE) AS OPE_NOMOPE,'
      
        '  IF(A.GAT_WPPENV = '#39'S'#39' AND C.OPE_NUMWPP <> '#39#39', C.OPE_NUMWPP, NU' +
        'LL) AS OPE_NUMWPP,  '
      
        '  IF(A.GAT_EMAENV = '#39'S'#39' AND C.OPE_E_MAIL <> '#39#39', C.OPE_E_MAIL, NU' +
        'LL) AS OPE_E_MAIL,'
      'IF(A.GAT_ENVIAR <> '#39'DIAS FIXOS'#39','
      '  TRIM(CONCAT('#39'Toda semana:'#39','
      '              IF(MID(A.GAT_DIASEM, 1, 1) = '#39'S'#39', '#39' Dom'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 2, 1) = '#39'S'#39', '#39' Seg'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 3, 1) = '#39'S'#39', '#39' Ter'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 4, 1) = '#39'S'#39', '#39' Qua'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 5, 1) = '#39'S'#39', '#39' Qui'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 6, 1) = '#39'S'#39', '#39' Sex'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIASEM, 7, 1) = '#39'S'#39', '#39' Sab'#39', '#39#39'))), '
      '  TRIM(CONCAT('#39'Dias fixos:'#39','
      '              IF(MID(A.GAT_DIAMES, 1, 1) = '#39'S'#39', '#39' 01'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 2, 1) = '#39'S'#39', '#39' 02'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 3, 1) = '#39'S'#39', '#39' 03'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 4, 1) = '#39'S'#39', '#39' 04'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 5, 1) = '#39'S'#39', '#39' 05'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 6, 1) = '#39'S'#39', '#39' 06'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 7, 1) = '#39'S'#39', '#39' 07'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 8, 1) = '#39'S'#39', '#39' 08'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 9, 1) = '#39'S'#39', '#39' 09'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 10, 1) = '#39'S'#39','#39' 10'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 11, 1) = '#39'S'#39','#39' 11'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 12, 1) = '#39'S'#39','#39' 12'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 13, 1) = '#39'S'#39','#39' 13'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 14, 1) = '#39'S'#39','#39' 14'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 15, 1) = '#39'S'#39','#39' 15'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 16, 1) = '#39'S'#39','#39' 16'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 17, 1) = '#39'S'#39','#39' 17'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 18, 1) = '#39'S'#39','#39' 18'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 19, 1) = '#39'S'#39','#39' 19'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 20, 1) = '#39'S'#39','#39' 20'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 21, 1) = '#39'S'#39','#39' 21'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 22, 1) = '#39'S'#39','#39' 22'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 23, 1) = '#39'S'#39','#39' 23'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 24, 1) = '#39'S'#39','#39' 24'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 25, 1) = '#39'S'#39','#39' 25'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 26, 1) = '#39'S'#39','#39' 26'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 27, 1) = '#39'S'#39','#39' 27'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 28, 1) = '#39'S'#39','#39' 28'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 29, 1) = '#39'S'#39','#39' 29'#39', '#39#39'),'
      '              IF(MID(A.GAT_DIAMES, 30, 1) = '#39'S'#39','#39' 30'#39', '#39#39'),'
      
        '              IF(MID(A.GAT_DIAMES, 31, 1) = '#39'S'#39','#39' 31'#39', '#39#39')))) AS' +
        ' GAT_DIAENV,'
      '  A.GAT_HORENV,'
      '  IF(A.GAT_FERENV = '#39'S'#39', '#39'Sim'#39', '#39'N'#227'o'#39') AS GAT_FERENV,'
      '  IF(A.GAT_STATUS = '#39'A'#39', '#39'Ativo'#39', '#39'Inativo'#39') AS GAT_STATUS'
      'FROM'
      '  GATINF A'
      '  LEFT JOIN CADREL B'
      '    ON B.REL_CODREL = A.GAT_CODREL'
      '  LEFT JOIN CADOPE C'
      '    ON C.OPE_CODOPE = A.GAT_CODOPE'
      '  LEFT JOIN GATPER D'
      '    ON D.GPE_CODIGO = A.GAT_CODPER'
      'WHERE TRUE'
      'ORDER BY   '
      '  A.GAT_CODIGO;'
      '  ')
    Constraints = <>
    Left = 488
    Top = 128
    object qryGatilhosGAT_CODEMP: TStringField
      Alignment = taCenter
      DisplayLabel = 'Emp.'
      FieldName = 'GAT_CODEMP'
      Size = 3
    end
    object qryGatilhosGAT_CODIGO: TStringField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'GAT_CODIGO'
      Size = 6
    end
    object qryGatilhosGAT_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o do Gatilho'
      FieldName = 'GAT_DESCRI'
      Required = True
      Size = 100
    end
    object qryGatilhosREL_DESCRI: TStringField
      DisplayLabel = 'Nome do Relat'#243'rio'
      FieldName = 'REL_DESCRI'
      ReadOnly = True
      Size = 209
    end
    object qryGatilhosGPE_DESCRI: TStringField
      Alignment = taCenter
      DisplayLabel = 'Per'#237'odo'
      FieldName = 'GPE_DESCRI'
      ReadOnly = True
      Size = 60
    end
    object qryGatilhosOPE_NOMOPE: TStringField
      DisplayLabel = 'Nome do Operador'
      FieldName = 'OPE_NOMOPE'
      ReadOnly = True
      Size = 36
    end
    object qryGatilhosOPE_NUMWPP: TStringField
      Alignment = taCenter
      DisplayLabel = 'WhatsApp'
      FieldName = 'OPE_NUMWPP'
      ReadOnly = True
      Size = 15
    end
    object qryGatilhosOPE_E_MAIL: TStringField
      Alignment = taCenter
      DisplayLabel = 'Email'
      FieldName = 'OPE_E_MAIL'
      ReadOnly = True
      Size = 100
    end
    object qryGatilhosGAT_DIAENV: TStringField
      Alignment = taCenter
      DisplayLabel = 'Quando enviar'
      FieldName = 'GAT_DIAENV'
      Size = 28
    end
    object qryGatilhosGAT_HORENV: TTimeField
      Alignment = taCenter
      DisplayLabel = 'Hor'#225'rio'
      FieldName = 'GAT_HORENV'
    end
    object qryGatilhosGAT_FERENV: TStringField
      Alignment = taCenter
      DisplayLabel = 'Feriados'
      FieldName = 'GAT_FERENV'
      FixedChar = True
      Size = 3
    end
    object qryGatilhosGAT_STATUS: TStringField
      Alignment = taCenter
      DisplayLabel = 'Status'
      FieldName = 'GAT_STATUS'
      FixedChar = True
      Size = 7
    end
  end
  object dtsSpoImp: TDataSource
    DataSet = qryGatilhos
    Left = 488
    Top = 80
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 144
    Top = 400
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
