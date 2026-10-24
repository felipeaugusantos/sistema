inherited frmFatManutRomaneio: TfrmFatManutRomaneio
  Width = 1100
  Height = 825
  Caption = 'Manuten'#231#227'o de Romaneios'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1100
  ExplicitHeight = 825
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 752
    Width = 1094
    TabOrder = 3
    ExplicitTop = 752
    ExplicitWidth = 1094
    inherited FlwBotoes: TFlowPanel
      Width = 1090
      ExplicitWidth = 1090
      object btnCfgGrid: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 209
        Height = 23
        Align = alLeft
        Caption = 'Salva Configura'#231#245'es Colunas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00080000000D0000000E0000000E0000000F0000000F0000000F0000000F0000
          000F00000010000000100000000F0000000A0000000200000000000000086A48
          3DBF946456FF936355FF936354FF936355FF926355FF926354FF936253FF9262
          53FF916252FF926252FF916252FF68463BC100000009000000000000000AA97B
          6DFFFBF5F2FFF9F2EEFFF9F2EFFFB18474FFD4A795FFD4A794FFD3A795FFAF83
          73FFFBF5F3FFFBF5F2FFFBF5F2FFA67769FF0000000D000000000000000AAB7E
          70FFFBF5F2FFF9F2EEFFF9F2EEFFB28676FFD4A896FFD4A996FFD4A896FFB084
          74FFFBF5F2FFFBF5F2FFFBF5F2FFA87A6BFF0000000D0000000000000009AD81
          72FFD0B4A8FFD0B4A8FFD0B3A8FFB38878FFB38878FFB28777FFB28777FFB286
          77FFD0B2A8FFCFB2A7FFCFB2A7FFAA7D6EFF0000000B0000000000000008AF84
          75FFFBF5F3FFF9F2EEFFF9F2EEFFB5897AFFD6AC99FFD6AC9AFFD6AB99FFB488
          78FFFBF5F2FFFBF5F3FFFBF5F3FFAC8071FF0000000A0000000000000006B186
          78FFFBF5F3FFFBF5F3FFFBF5F2FFB68B7CFFE1C0B1FFE1C0B0FFE1C0B1FFB48A
          7BFFFBF5F2FFFBF5F3FFFBF5F3FFAE8274FF0000000800000000000000039076
          6CC0C29E91FFC29E91FFC29E91FFC29E91FFC19E91FFC19D91FFC19D91FFC19D
          90FFC09D90FFC09D90FFC09C90FF8E746AC20000000500000000000000010000
          0003000000040000000500000005000000050000000500000005000000050000
          0006000000060000000600000006000000040000000100000000000000000000
          00000000000000000000000000004F342CFF0000000000000000000000004F34
          2CFF000000000000000000000000000000000000000000000000000000000000
          0000281B167E000000000000000050352DFF0000000000000000000000005034
          2DFF0000000000000000271A167E000000000000000000000000000000000000
          000053382FFF291B177E0000000053372FFF0000000000000000000000005237
          2EFF00000000281B177E51362DFF000000000000000000000000553A32FF553A
          30FF553931FF553930FF2B1D1981553831FF0000000000000000000000005438
          2FFF2A1C188153382FFF53372FFF53372FFF53372EFF00000000000000000000
          0000583C33FF2C1E1A8100000000573B32FF000000000000000000000000563A
          32FF000000002C1D1981553A31FF000000000000000000000000000000000000
          00002E1F1B810000000000000000593D34FF000000000000000000000000583C
          34FF00000000000000002D1E1981000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnCfgGridClick
      end
      object btnEntEsp: TBitBtnLocked
        Left = 209
        Top = 0
        Width = 200
        Height = 23
        Caption = '[F2] Exibir itens com Entrega Especial'
        TabOrder = 1
        OnClick = btnEntEspClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1014
      ExplicitLeft = 1014
    end
  end
  inherited pnlStatus: TPanel
    Top = 780
    Width = 1094
    TabOrder = 4
    ExplicitTop = 780
    ExplicitWidth = 1094
    inherited pnlNomeForm: TPanel
      Left = 923
      ExplicitLeft = 923
    end
    inherited pnlInfo: TPanel
      Width = 923
      ExplicitWidth = 923
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1094
    Height = 129
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblEmpresa: TLabel
      Left = 15
      Top = 10
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblDtaInin: TLabel
      Left = 6
      Top = 33
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object lblDtaFin: TLabel
      Left = 10
      Top = 56
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object lblRomaneio: TLabel
      Left = 10
      Top = 79
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Romaneio:'
    end
    object lblMotorista: TLabel
      Left = 13
      Top = 102
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motorista:'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 65
      Top = 7
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 131
      Top = 7
      Width = 611
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 65
      Top = 30
      Width = 65
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 65
      Top = 53
      Width = 65
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 65
      Top = 76
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 4
      OnKeyPress = edtNumRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 65
      Top = 99
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 131
      Top = 99
      Width = 610
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 744
      Top = 99
      Width = 85
      Height = 22
      Caption = '&Consultar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 7
      OnClick = btnFiltrarClick
    end
  end
  object pnlRomaneio: TPanel [3]
    Left = 0
    Top = 129
    Width = 624
    Height = 623
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object grdRomaneio: TcxGrid
      Left = 1
      Top = 1
      Width = 622
      Height = 575
      Align = alClient
      TabOrder = 0
      object grdRomaneioDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsRomaneio
        DataController.KeyFieldNames = 'GER_NUMROM'
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ShowEditButtons = gsebAlways
        OptionsView.GroupByBox = False
        object grdRomaneioNUMROM: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'GER_NUMROM'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 107
        end
        object grdRomaneioDTAENT: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'GER_DTAENT'
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.AutoWidthSizable = False
          Width = 74
        end
        object grdRomaneioNOMMOT: TcxGridDBColumn
          Caption = 'Motorista'
          DataBinding.FieldName = 'MOT_NOMMOT'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 244
        end
        object grdRomaneioPESBRU: TcxGridDBColumn
          Caption = 'Peso'
          DataBinding.FieldName = 'GER_PESBRU'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 84
        end
        object grdRomaneioVLRCON: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'GER_VLRCON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 96
        end
        object grdRomaneioBTNMARTOT: TcxGridDBColumn
          DataBinding.FieldName = 'BTNMAR'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000021744558745469746C65004170706C793B4F4B3B436865636B3B4261
                72733B526962626F6E3B6463C8680000037D49444154785E4D8E7F4C94051CC6
                3FEF7B77E02073EA92742577579B684891E62AB6C4526B6013696BC9DC5A0B33
                D0322DA716D3CA94A21A8E96E976AEB654688E409B46B859CC249500E3F81588
                234EE0F875DC1DF7A3BB7BDFF7DBC16AEBD9F3D9BEFF3CCFF7C13555CB58A801
                40014CC5E5696BF638D24FBEF7EDF2D683550F7B0E5666B4969C5A5EBBEBCB65
                2F0209803A116E6438F82377A66A60385007A0E4EFB2A5BC51B1B4AEF4EC5AB9
                D476583A87AA642C7055BA47CE4A43F72752713157F67D93DE54B0DFBE04308D
                867E9E290050725F4BBDB7F8E8B29EAA86B7C4E5BF203DDEE3D23E71585AC6F6
                48E7E4C7D2E777C870A05E7E68DE277B4F668C6EDE6BCF00D4017F350A607EF5
                48DAB99CECBC9CF4343BC3E1264CAA60C282AAA8288A028A30313E852DE509EE
                0C4D72EEF26967CD17FD4F0EDE0A064DF9BBEDEB6CD6C51F3C9DF5382EFF1540
                104014216E500C2ED6DDA4F67C3BEDB79BC9C95EC3E8F8784AD28288BBADC1D3
                6C4E98652A7C2C7D2543816674430304C4885B0755E1CC99EBCC51D750F14E35
                DBCB32E91DF98DCCA5ABE8FCB36733E0500D3132EF9EAB108C7AE9ED1BA6B4AC
                969F2E39896A11CE5F68212529975D5B4A395A59C40B79CF6049D0489AAD81AA
                3C0A9854436741140FE148809AEA16CA8AAEA34C65F1E9E7F524EBEBD99A7F80
                53751FB2707118EB836642311F31C63174497C286BEE6C55D3F48971DF2088C1
                A60D6BF9BAB6849D0547D8FD520D2F3F5F822FD8C7AFCEEF58B16A11FEC82831
                3DC6A87F8868C488745C9D0C9AF5A8D2E51EF15BE72FD248B127E2F5FE8DE3FB
                FDEC28280755E1FDCFB691BF310B6FC48566C4C030F08D458984B40E4057837E
                ADAAA7CB87A0E2090EB2E491594C1A4DD45C2EC779AB0E53B287C4399384A353
                718288A8F4767B09F8F4F380069094BBDD7AB3E474869CB8B1428E5DCB90AAB6
                0DB2E59055B2B621C72EAF93134D99723C8EE3F79572A83A5336EEB439EF9A67
                990FA82A1071F7855EF9E35AC0D3EB0C010A9EF000799B56F1EEDBAFC7BF87D0
                0D411185BEEE30AD8DFE88AB2B501CF0C4FC5706DE34CC0D7F15E9AB53BF6A17
                784ED78C4AB72BF6803DDD82B6B013D5A420064CB875FABB628CB8A21DEEDBA1
                A2D6FAB11B8066480C7EE92F045000737CD6BCA736DFB77F7D616A63EE769BCC
                B0C326CF6E4D6D5B5D70FF47C9732CF700164099CE4D3373FCA76CAB43052CFF
                62065440001D884E130F19FC4FFF00FE20CB5D5DF1FFF30000000049454E44AE
                426082}
              Hint = 'Marcar Todos'
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = grdRomaneioBTNMARTOTPropertiesButtonClick
          Width = 25
          IsCaptionAssigned = True
        end
        object grdRomaneioBTNDESTOT: TcxGridDBColumn
          DataBinding.FieldName = 'BTNDES'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
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
              Hint = 'Desmarcar Todos'
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = grdRomaneioBTNDESTOTPropertiesButtonClick
          Width = 25
          IsCaptionAssigned = True
        end
        object grdRomaneioBTNMOVER: TcxGridDBColumn
          DataBinding.FieldName = 'BTNMOV'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                610000001974455874536F6674776172650041646F626520496D616765526561
                647971C9653C00000012744558745469746C650052696768743B4172726F773B
                8FE10E74000001FE49444154785E65923F6B145114C57F6F76B228582856A631
                85214D88A5AC6096185C54B01024A04110C45A515308113F837F0A0511C1C620
                829585554CA29D410C2944116C64633420D13071E6DD2B97BB33ECE079CCDC99
                CB3BE79D7B66C2B5C7EFE79346A30D8A1218CC7E82FA9B2AD8CD8B62F01EE4C5
                F6E2ECE59393694892F6D989210C5FBB9B74464708BEA7AC75A88BDC79F8FA08
                D0484560BB503E7DFFCD8F8D2DB24CD07E562859A15268361B44234248448568
                972822EA56EBC779F14589182386C448455462EC09104C045FF074FE337FB21C
                87EB21D881EE4005240AD145DC6EE536F0EEE31AB3F71758FDB2EEE4E0D3486F
                84D4947231B220EAC9CF3C78838A3FAB0A53D36D1ECD2D31B67F37E74E8C3190
                2648EC39B0306C8442B4B44591175CBC34C970679C039D36CB1B4D868E4DF061
                B3C9ED276F51A50C9154CC411477201E589E476EDD9C43DD1187A68EB3F26A91
                F1E13D9C3FD3C220A23E82A885281462AA3EDFDD2B47AB9FE0F4F567ACBE78C9
                D5E9160747F641F090A5FA8C3642AE16A4374BA897D6E820F76E9C32324A0055
                ABF511FE9A031F0155679798B97018943EB2AB1B0F77A0E4E642C455556B0E50
                DC76D5F02DA2BD0C542C7561EFAE1D34A292A609FD50FFF8F59E2D77A069F75B
                77E1F9FAAF711CAC2DAF78FAF43BA808553FCBB696803C003B810120E17F04EA
                E897CD81EC1FBEC66EBE2A51FCE50000000049454E44AE426082}
              Hint = 'Mover'
              Kind = bkGlyph
            end>
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = grdRomaneioBTNMOVERPropertiesButtonClick
          Width = 25
          IsCaptionAssigned = True
        end
      end
      object grdRomaneioDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object grdRomaneioDBTableView2: TcxGridDBTableView
        OnDblClick = grdRomaneioDBTableView2DblClick
        OnKeyDown = grdRomaneioDBTableView2KeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        OnCustomDrawCell = grdRomaneioDBTableView2CustomDrawCell
        DataController.DataSource = dtsDocumentos
        DataController.DetailKeyFieldNames = 'GER_NUMROM'
        DataController.KeyFieldNames = 'AUTOINCREM'
        DataController.MasterKeyFieldNames = 'GER_NUMROM'
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.DragDropText = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdRomaneioDETNUMROM: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'GER_NUMROM'
          Visible = False
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 107
        end
        object grdRomaneioDETNOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 243
        end
        object grdRomaneioDETDOCUME: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'GER_DOCUME'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 150
        end
        object grdRomaneioDOCS_FAT: TcxGridDBColumn
          Caption = 'Docs. Faturados'
          DataBinding.FieldName = 'DOCS_FAT'
          Width = 74
        end
        object grdRomaneioDETPESBRU: TcxGridDBColumn
          Caption = 'Peso'
          DataBinding.FieldName = 'GER_PESBRU'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 84
        end
        object grdRomaneioDETVLRCON: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'GER_VLRCON'
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 96
        end
        object grdRomaneioDETMARDES: TcxGridDBColumn
          DataBinding.FieldName = 'GER_MARDES'
          Visible = False
        end
        object grdRomaneioDETCIDENT: TcxGridDBColumn
          Caption = 'Cidade'
          DataBinding.FieldName = 'CIDENT'
          Options.Editing = False
        end
        object grdRomaneioDETCEPENT: TcxGridDBColumn
          Caption = 'Cep'
          DataBinding.FieldName = 'CEPENT'
          Options.Editing = False
          Width = 84
        end
      end
      object grdRomaneioLevel1: TcxGridLevel
        GridView = grdRomaneioDBTableView
        object grdRomaneioLevel2: TcxGridLevel
          GridView = grdRomaneioDBTableView2
        end
      end
    end
    object pnlTotais: TPanel
      Left = 1
      Top = 576
      Width = 622
      Height = 46
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lbltotDocSel: TLabel
        Left = 1
        Top = 25
        Width = 108
        Height = 14
        Caption = 'Total Selecionado: 0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotDoc: TLabel
        Left = 1
        Top = 6
        Width = 128
        Height = 14
        Caption = 'Total de Documentos: 0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotPesSel: TLabel
        Left = 123
        Top = 25
        Width = 172
        Height = 14
        Caption = 'Peso Doc. Selecionado: 0.000,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotValSel: TLabel
        Left = 306
        Top = 25
        Width = 172
        Height = 14
        Caption = 'Valor Doc. Selecionado: 0.000,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object pnlManutancao: TPanel [4]
    Left = 624
    Top = 129
    Width = 470
    Height = 623
    Align = alRight
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grdManutencao: TcxGrid
      Left = 1
      Top = 1
      Width = 468
      Height = 575
      Align = alClient
      TabOrder = 0
      object grdManutencaoDBTableView: TcxGridDBTableView
        OnKeyDown = grdManutencaoDBTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsManut
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdManutencaoMATNUMROM: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'GER_NUMROM'
          Width = 107
        end
        object grdManutencaoMATNOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 243
        end
        object grdManutencaoMATDOCUME: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'GER_DOCUME'
          Width = 150
        end
        object grdManutencaoMATPESBRU: TcxGridDBColumn
          Caption = 'Peso'
          DataBinding.FieldName = 'GER_PESBRU'
          Width = 84
        end
        object grdManutencaoMATVLRCON: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'GER_VLRCON'
          Width = 96
        end
        object grdManutencaoMATMARDES: TcxGridDBColumn
          DataBinding.FieldName = 'GER_MARDES'
          Visible = False
        end
      end
      object grdManutencaoLevel1: TcxGridLevel
        GridView = grdManutencaoDBTableView
      end
    end
    object pnlAcao: TPanel
      Left = 1
      Top = 576
      Width = 468
      Height = 46
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblInformacao: TLabel
        Left = 5
        Top = 3
        Width = 294
        Height = 14
        Caption = 'Aperte delete sobre um documento para remov'#234'-lo da grade.'
      end
      object btnRemover: TBitBtnLocked
        Left = 4
        Top = 20
        Width = 102
        Height = 25
        Caption = '&Remover'
        TabOrder = 0
        OnClick = btnRemoverClick
      end
      object btnGerarNovo: TBitBtnLocked
        Left = 112
        Top = 20
        Width = 102
        Height = 25
        Caption = '&Gerar Novo'
        TabOrder = 1
        OnClick = btnGerarNovoClick
      end
      object btnIncluir: TBitBtnLocked
        Left = 220
        Top = 20
        Width = 102
        Height = 25
        Caption = '&Incluir'
        TabOrder = 2
        OnClick = btnIncluirClick
      end
    end
  end
  object cdsRomaneio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRomaneio'
    Left = 48
    Top = 345
    object cdsRomaneioGER_NUMROM: TStringField
      FieldName = 'GER_NUMROM'
      Size = 6
    end
    object cdsRomaneioGER_DTAENT: TDateField
      FieldName = 'GER_DTAENT'
    end
    object cdsRomaneioMOT_NOMMOT: TStringField
      FieldName = 'MOT_NOMMOT'
      Size = 40
    end
    object cdsRomaneioGER_PESBRU: TFloatField
      FieldName = 'GER_PESBRU'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsRomaneioGER_VLRCON: TFloatField
      FieldName = 'GER_VLRCON'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsRomaneioBTNMAR: TStringField
      FieldName = 'BTNMAR'
      Size = 1
    end
    object cdsRomaneioBTNDES: TStringField
      FieldName = 'BTNDES'
      Size = 1
    end
    object cdsRomaneioBTNMOV: TStringField
      FieldName = 'BTNMOV'
      Size = 1
    end
    object cdsRomaneioGER_EMPROM: TStringField
      FieldName = 'GER_EMPROM'
      Size = 3
    end
    object cdsRomaneioGER_PESLIQ: TFloatField
      FieldName = 'GER_PESLIQ'
    end
  end
  object dtsRomaneio: TDataSource
    DataSet = cdsRomaneio
    Left = 48
    Top = 401
  end
  object dspRomaneio: TUniDataSetProvider
    DataSet = qryRomaneio
    Options = []
    Left = 48
    Top = 297
  end
  object qryRomaneio: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 48
    Top = 241
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 345
    object cdsDocumentosGER_NUMROM: TStringField
      FieldName = 'GER_NUMROM'
      Size = 6
    end
    object cdsDocumentosGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Size = 12
    end
    object cdsDocumentosGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Size = 2
    end
    object cdsDocumentosGER_CODCLI: TStringField
      FieldName = 'GER_CODCLI'
      Size = 8
    end
    object cdsDocumentosCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsDocumentosGER_DOCUME: TStringField
      FieldName = 'GER_DOCUME'
      Size = 15
    end
    object cdsDocumentosGER_PESBRU: TFloatField
      FieldName = 'GER_PESBRU'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsDocumentosGER_VLRCON: TFloatField
      FieldName = 'GER_VLRCON'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsDocumentosGER_MARDES: TStringField
      FieldName = 'GER_MARDES'
      Size = 1
    end
    object cdsDocumentosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDocumentosCEPENT: TStringField
      FieldName = 'CEPENT'
      Size = 9
    end
    object cdsDocumentosCIDENT: TStringField
      FieldName = 'CIDENT'
      Size = 40
    end
    object cdsDocumentosGER_EMPROM: TStringField
      FieldName = 'GER_EMPROM'
      Size = 3
    end
    object cdsDocumentosGER_PESLIQ: TFloatField
      FieldName = 'GER_PESLIQ'
    end
    object cdsDocumentosGER_ENTSAI: TStringField
      FieldName = 'GER_ENTSAI'
      Size = 1
    end
    object cdsDocumentosGER_CODEMP: TStringField
      FieldName = 'GER_CODEMP'
      Size = 3
    end
    object cdsDocumentosDOCS_FAT: TStringField
      FieldName = 'DOCS_FAT'
      Size = 500
    end
    object cdsDocumentosGER_NOMTAB: TStringField
      FieldName = 'GER_NOMTAB'
    end
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 120
    Top = 401
  end
  object cdsManut: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 313
    object cdsManutGER_NUMROM: TStringField
      FieldName = 'GER_NUMROM'
      Size = 6
    end
    object cdsManutGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Size = 12
    end
    object cdsManutGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Size = 2
    end
    object cdsManutGER_CODCLI: TStringField
      FieldName = 'GER_CODCLI'
      Size = 8
    end
    object cdsManutCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsManutGER_DOCUME: TStringField
      FieldName = 'GER_DOCUME'
      Size = 15
    end
    object cdsManutGER_PESBRU: TFloatField
      FieldName = 'GER_PESBRU'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsManutGER_VLRCON: TFloatField
      FieldName = 'GER_VLRCON'
      DisplayFormat = '#,##0.0000'
      EditFormat = '#,##0.0000'
    end
    object cdsManutGER_MARDES: TStringField
      FieldName = 'GER_MARDES'
      Size = 1
    end
    object cdsManutAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsManutCEPENT: TStringField
      FieldName = 'CEPENT'
      Size = 9
    end
    object cdsManutCIDENT: TStringField
      FieldName = 'CIDENT'
      Size = 40
    end
    object cdsManutGER_EMPROM: TStringField
      FieldName = 'GER_EMPROM'
      Size = 3
    end
    object cdsManutGER_PESLIQ: TFloatField
      FieldName = 'GER_PESLIQ'
    end
    object cdsManutGER_ENTSAI: TStringField
      FieldName = 'GER_ENTSAI'
      Size = 1
    end
    object cdsManutGER_CODEMP: TStringField
      FieldName = 'GER_CODEMP'
      Size = 3
    end
  end
  object dtsManut: TDataSource
    DataSet = cdsManut
    Left = 784
    Top = 369
  end
end
