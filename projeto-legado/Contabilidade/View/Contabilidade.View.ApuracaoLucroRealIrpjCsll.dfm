inherited frmApuracaoLucroRealIrpjCsll: TfrmApuracaoLucroRealIrpjCsll
  Width = 1447
  Height = 690
  Caption = 'Apura'#231#227'o da CSLL e do IRPJ - C'#225'lculo'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 1447
  ExplicitHeight = 690
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 617
    Width = 1441
    TabOrder = 1
    ExplicitTop = 617
    ExplicitWidth = 1441
    inherited FlwBotoes: TFlowPanel
      Width = 1437
      ExplicitWidth = 1437
      object btnFechar: TcxButton
        Left = 0
        Top = 0
        Width = 122
        Height = 22
        Caption = '&Fechar C'#225'lculos'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001D744558745469746C6500436C6F73653B457869743B426172733B52
          6962626F6E3B4603B9E8000002AD49444154785E85934B4C546714C77FF73232
          0C041DC2237644C368F109868D98A0290BDA60E2DE9526921856C3C2A08C2E1A
          A336A64DB48D81A8892D6E241A7CA20B1530261849DA4D47596818082F015118
          0698B973DFB7773EB1333BEE97FFCD3927DFF97DE77B1CE9E3AF17293FF3B30C
          48426B7D9939765A1290337AE1DC4B8F2CD73B0E802306C24CEB9BE7ACFA6206
          86650FECFCE55283079025DBAE2F3D5CB79A94B58E206692C5CF1606933DAF7F
          006451BA69986099A8C3C38C3C7846D791D3BCB97413351A151AFCADD38D8589
          DE7F412A3A426A388AC801D92300A689E36A2A1225129923D8D1C9FC9387FCDD
          D587244BC4037BDC581B91AB97716C93F2AA6D989A004802A0AF28382EF19F3B
          FD34F4F7515852C4E2AE20FFFED10140CDC9101B0ABD54B4FFCEAB1F7F62D3F9
          0AB4643203589E9C469F9926B8BF8AF947DD94B5849072246A5A43E040913F9F
          BC75394C3DEE2658BB9BD4F07BE2E3B35915A83AFAA719766CCDE7C3403F43C8
          6C6D6EC65FE8C391C0B660E8FA359203BD546EF7A34E4C60A49C2C8066602514
          B4D94F98F12596150DDB721043DC84CC4A3A168FA14FA75CA085A17D05885B30
          D280548AE8FB39947D8D048E3661D936DE5C99BC5C8FB0BF3BD684527B88D1D1
          18B6AAE22E9A5D8186954C105B50680C87503D3EF2BDEE9E6FFD0940F9F11380
          8FFA700BBD4FEEB2A94842D73D990A74DDC45C49B2A37A336FDB4E5122AB8C5F
          6FE7CBBDDB7C763571A39D328FCEBB702BDF6F2FC352750C4DCFBC0343750189
          243E3381131BE369DD018A4BD71328CE136730D7D3CDD3CEBFD8B2A518AF99C0
          4C030CFEDF82EBE802602C2CE22DC8676F7500633981E2DE0C1694FAFD6C2C29
          419D8FA12515B06C4C43461080822B6595CF7D927410475A3DF9ACA6B0859FDD
          50C2566C7BF0ECD258A3E846200FF066B5AAB4462B3B800628FF0122CC6063F4
          5F96130000000049454E44AE426082}
        TabOrder = 0
        OnClick = btnFecharClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1361
      ExplicitLeft = 1361
    end
  end
  inherited pnlStatus: TPanel
    Top = 645
    Width = 1441
    TabOrder = 2
    ExplicitTop = 645
    ExplicitWidth = 1441
    inherited pnlNomeForm: TPanel
      Left = 1270
      ExplicitLeft = 1270
    end
    inherited pnlInfo: TPanel
      Width = 1270
      ExplicitWidth = 1270
    end
  end
  object gbFiltroInicial: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 1441
    Height = 60
    Align = alTop
    TabOrder = 0
    object btnAbrir: TcxButton
      Left = 496
      Top = 29
      Width = 129
      Height = 25
      Caption = 'Carregar C'#225'lculos'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000B744558745469746C65004F70656E3B49C97792000002
        8849444154785E7D934F68545718C57FEFCD4B63CBB45D64A3ADD0952D45B40B
        D12E3428044A70530ADDE8AA94820B1BD09D10442D0A0117225D28A5C9AA0B6D
        A14BDB458B055B4C2853D4A869689A2131FFCC4C26C9CCBCCCBCB9F7FBBE4E2E
        1310D11E38F7703F2EE770E07E9199F1324451C4A12FE9EE7E9D736A7C117B70
        19C3A529BE9AF8890CB098FF4794BCC669DFE4F6ED21DEAA57F9D4B78DDED8C9
        C50327102017E5F3F91888003A6A1D6ABD5E8F9E33CCEDFB9CF351CCA0291446
        E84EEE5E3DF86B1C730423C014D2A63FDE7766EC26A0070740141018BD1E0206
        D581582771FCDB8F6CF767C30460F8668DC91F06577E199BF9E0EC77FF947806
        22123BE7726DB5360470893805A9829BC3544910DEFBF8648FB8AFE77E7BFF4D
        3030B3A06A11CED99DFE8B85BE5AADE60012F10A262019917A304F4E53F61C3B
        45F4CA7620025340311346AF0CF402B93F2EF53A5548D44930C03731DF40DB44
        1CA40B98FD05CE612A8004A35A3905C8F70FDD8B0189EE0E1DB60F072EA3EB0F
        28FF5D606D611953421D3503354C0D550DBAF2A48C756AA95829712DA1B1FA94
        6CB1C8FAD33ABB3EB94014C521CDCC817A4C5A04FA8C4069B23A5B64ECFB1B33
        896442756186B5C929F23BF762AD2A1BFFFE8CA960AA604131F52012E6AAC2FC
        C359D6AAFE56E29CB03253245DAEB063DF3B644BE3F8FAEAD643100D06A8EFD4
        F261569E5EE6D17CFA63E2324FA538CDB6AE6D74254263F63ED2A875923DE615
        63CB443011D2F52695D5C6E36BA3A5E9A4B1D1C29696E8D9F32ECDC509B2CA7C
        27B553814DB5700705354AF3752AA9BF05B86423F57FE2ABFB277F2F307967EB
        D304C5009400B370A006CEDBDCF8E2C608D0DA5CA657812EE0459BF9FC3219E0
        80E63747DF1680FF001724CEF504A838340000000049454E44AE426082}
      TabOrder = 2
      OnClick = btnAbrirClick
    end
    object cxLabel1: TcxLabel
      Left = 5
      Top = 10
      Caption = 'Exercicio:'
    end
    object edtExercicio: TEditFocus
      Left = 60
      Top = 6
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object cxLabel7: TcxLabel
      Left = 4
      Top = 32
      Caption = 'Empresa:'
    end
    object edtEmpSel: TEditFocus
      Tag = 99
      Left = 60
      Top = 31
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtEmpSelKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpSel: TEditFocus
      Left = 120
      Top = 31
      Width = 372
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pgCalculos: TcxPageControl [3]
    Left = 0
    Top = 60
    Width = 1441
    Height = 557
    Align = alClient
    TabOrder = 3
    Properties.ActivePage = tsApuracaoReceitasAcrescimos
    Properties.CustomButtons.Buttons = <>
    Properties.Style = 2
    OnPageChanging = pgCalculosPageChanging
    ClientRectBottom = 557
    ClientRectRight = 1441
    ClientRectTop = 26
    object tsApuracaoReceitasAcrescimos: TcxTabSheet
      Caption = '01 - Apura'#231#227'o - Receitas e Acr'#233'scimos'
      ImageIndex = 0
      object pnlApuRecAcrIrpj: TPanel
        Left = 0
        Top = 298
        Width = 1441
        Height = 233
        Align = alBottom
        TabOrder = 0
        object GridCitelApuRecAcrIrpj: TcxGridCitel
          Left = 1
          Top = 1
          Width = 1439
          Height = 199
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCitelApuRecAcrIrpjTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnEditing = GridCitelApuRecAcrIrpjTableViewEditing
            DataController.DataSource = dsApuRecAcrIrpj
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.OnGetContentStyle = GridCitelApuRecAcrIrpjTableViewStylesGetContentStyle
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCitelApuRecAcrIrpjTableViewCODIGO: TcxGridDBColumn
              DataBinding.FieldName = 'CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCitelApuRecAcrIrpjTableViewDESCRI: TcxGridDBColumn
              Caption = 'IRPJ '#8211' Receita Bruta'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Width = 228
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL01: TcxGridDBColumn
              Caption = 'Janeiro'
              DataBinding.FieldName = 'BCAL01'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL02: TcxGridDBColumn
              Caption = 'Fevereiro'
              DataBinding.FieldName = 'BCAL02'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL03: TcxGridDBColumn
              Caption = 'Mar'#231'o'
              DataBinding.FieldName = 'BCAL03'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL04: TcxGridDBColumn
              Caption = 'Abril'
              DataBinding.FieldName = 'BCAL04'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL05: TcxGridDBColumn
              Caption = 'Maio'
              DataBinding.FieldName = 'BCAL05'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL06: TcxGridDBColumn
              Caption = 'Junho'
              DataBinding.FieldName = 'BCAL06'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL07: TcxGridDBColumn
              Caption = 'Julho'
              DataBinding.FieldName = 'BCAL07'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL08: TcxGridDBColumn
              Caption = 'Agosto'
              DataBinding.FieldName = 'BCAL08'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL09: TcxGridDBColumn
              Caption = 'Setembro'
              DataBinding.FieldName = 'BCAL09'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL10: TcxGridDBColumn
              Caption = 'Outubro'
              DataBinding.FieldName = 'BCAL10'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL11: TcxGridDBColumn
              Caption = 'Novembro'
              DataBinding.FieldName = 'BCAL11'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCAL12: TcxGridDBColumn
              Caption = 'Dezembro'
              DataBinding.FieldName = 'BCAL12'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewBCALTT: TcxGridDBColumn
              Caption = 'Total'
              DataBinding.FieldName = 'BCALTT'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Options.Editing = False
              Styles.Content = sltLinhaDestacada
              Width = 95
            end
            object GridCitelApuRecAcrIrpjTableViewPERCEN: TcxGridDBColumn
              DataBinding.FieldName = 'PERCEN'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object GridCitelApuRecAcrIrpjLevel: TcxGridLevel
            GridView = GridCitelApuRecAcrIrpjTableView
          end
        end
        object pnlBotoesApuRecAcr: TPanel
          Left = 1
          Top = 200
          Width = 1439
          Height = 32
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnConfirmarApuRecAcr: TcxButton
            Left = 4
            Top = 3
            Width = 151
            Height = 25
            Caption = 'Confirmar Altera'#231#245'es'
            Enabled = False
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
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
            TabOrder = 0
            OnClick = btnConfirmarApuRecAcrClick
          end
          object btnCancelarApuRecAcr: TcxButton
            Left = 156
            Top = 3
            Width = 151
            Height = 25
            Caption = 'Cancelar Altera'#231#245'es'
            Enabled = False
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
            TabOrder = 1
            OnClick = btnCancelarApuRecAcrClick
          end
        end
      end
      object Splitter: TcxSplitter
        Left = 0
        Top = 290
        Width = 1441
        Height = 8
        HotZoneClassName = 'TcxXPTaskBarStyle'
        AlignSplitter = salBottom
        AutoPosition = False
        DragThreshold = 15
        AutoSnap = True
      end
      object GridCitelApuRecAcrCsll: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1441
        Height = 290
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridCitelApuRecAcrCsllTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridCitelApuRecAcrCsllTableViewEditing
          DataController.DataSource = dsApuRecAcrCsll
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = GridCitelApuRecAcrCsllTableViewStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridCitelApuRecAcrCsllTableViewCODIGO: TcxGridDBColumn
            DataBinding.FieldName = 'CODIGO'
            Visible = False
            VisibleForCustomization = False
          end
          object GridCitelApuRecAcrCsllTableViewDESCRI: TcxGridDBColumn
            Caption = 'CSLL '#8211' Receita Bruta'
            DataBinding.FieldName = 'DESCRI'
            Options.Editing = False
            Width = 228
          end
          object GridCitelApuRecAcrCsllTableViewBCAL01: TcxGridDBColumn
            Caption = 'Janeiro'
            DataBinding.FieldName = 'BCAL01'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL02: TcxGridDBColumn
            Caption = 'Fevereiro'
            DataBinding.FieldName = 'BCAL02'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL03: TcxGridDBColumn
            Caption = 'Mar'#231'o'
            DataBinding.FieldName = 'BCAL03'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL04: TcxGridDBColumn
            Caption = 'Abril'
            DataBinding.FieldName = 'BCAL04'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL05: TcxGridDBColumn
            Caption = 'Maio'
            DataBinding.FieldName = 'BCAL05'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL06: TcxGridDBColumn
            Caption = 'Junho'
            DataBinding.FieldName = 'BCAL06'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL07: TcxGridDBColumn
            Caption = 'Julho'
            DataBinding.FieldName = 'BCAL07'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL08: TcxGridDBColumn
            Caption = 'Agosto'
            DataBinding.FieldName = 'BCAL08'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL09: TcxGridDBColumn
            Caption = 'Setembro'
            DataBinding.FieldName = 'BCAL09'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL10: TcxGridDBColumn
            Caption = 'Outubro'
            DataBinding.FieldName = 'BCAL10'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL11: TcxGridDBColumn
            Caption = 'Novembro'
            DataBinding.FieldName = 'BCAL11'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCAL12: TcxGridDBColumn
            Caption = 'Dezembro'
            DataBinding.FieldName = 'BCAL12'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewBCALTT: TcxGridDBColumn
            Caption = 'Total'
            DataBinding.FieldName = 'BCALTT'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Options.Editing = False
            Styles.Content = sltLinhaDestacada
            Width = 95
          end
          object GridCitelApuRecAcrCsllTableViewPERCEN: TcxGridDBColumn
            DataBinding.FieldName = 'PERCEN'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object GridCitelApuRecAcrCsllLevel: TcxGridLevel
          GridView = GridCitelApuRecAcrCsllTableView
        end
      end
    end
    object tsDeducoesRetencoesCSLL: TcxTabSheet
      Caption = '02 - Dedu'#231#245'es e Reten'#231#245'es da CSLL'
      ImageIndex = 1
      object GridCitelDedRetCsll: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1441
        Height = 499
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridCitelDedRetCsllTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridCitelDedRetCsllTableViewEditing
          DataController.DataSource = dsDedRetCsll
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object GridCitelDedRetCsllLevel: TcxGridLevel
          GridView = GridCitelDedRetCsllTableView
        end
      end
      object pnlBotoesDedRetCsll: TPanel
        Left = 0
        Top = 499
        Width = 1441
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnConfirmarDedRetCsll: TcxButton
          Left = 4
          Top = 3
          Width = 151
          Height = 25
          Caption = 'Confirmar Altera'#231#245'es'
          Enabled = False
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
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
          TabOrder = 0
          OnClick = btnConfirmarDedRetCsllClick
        end
        object btnCancelarDedRetCsll: TcxButton
          Left = 156
          Top = 3
          Width = 151
          Height = 25
          Caption = 'Cancelar Altera'#231#245'es'
          Enabled = False
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
          TabOrder = 1
          OnClick = btnCancelarDedRetCsllClick
        end
      end
    end
    object tsDeducoesRetencoesIRPJ: TcxTabSheet
      Caption = '03 -  Dedu'#231#245'es e Reten'#231#245'es do IRPJ'
      ImageIndex = 2
      object GridCitelDedRetIrpj: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1441
        Height = 499
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridCitelDedRetIrpjTableView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridCitelDedRetCsllTableViewEditing
          DataController.DataSource = dsDedRetIrpj
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
        end
        object GridCitelDedRetIrpjLevel: TcxGridLevel
          GridView = GridCitelDedRetIrpjTableView
        end
      end
      object pnlBotoesDedRetIrpj: TPanel
        Left = 0
        Top = 499
        Width = 1441
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnConfirmarDedRetIrpj: TcxButton
          Left = 4
          Top = 3
          Width = 151
          Height = 25
          Caption = 'Confirmar Altera'#231#245'es'
          Enabled = False
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
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
          TabOrder = 0
          OnClick = btnConfirmarDedRetIrpjClick
        end
        object btnCancelarDedRetIrpj: TcxButton
          Left = 156
          Top = 3
          Width = 151
          Height = 25
          Caption = 'Cancelar Altera'#231#245'es'
          Enabled = False
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
          TabOrder = 1
          OnClick = btnCancelarDedRetIrpjClick
        end
      end
    end
    object tsDemonstrativoApuracao: TcxTabSheet
      Caption = '04 - Demonstrativo da Apura'#231#227'o'
      ImageIndex = 3
      object gbContribuicaoSocial: TcxGroupBox
        Left = 4
        Top = 30
        Caption = 'Contribui'#231#227'o Social'
        TabOrder = 1
        Height = 174
        Width = 405
        object cxLabel2: TcxLabel
          Left = 30
          Top = 35
          Caption = 'Base Calculo da CSLL:'
        end
        object cxLabel3: TcxLabel
          Left = 94
          Top = 62
          Caption = '(=) CSLL:'
        end
        object cxLabel4: TcxLabel
          Left = 9
          Top = 118
          Caption = '(-) Dedu'#231#245'es e Reten'#231#245'es:'
        end
        object cxLabel5: TcxLabel
          Left = 39
          Top = 145
          Caption = '(=) CSLL a Recolher:'
        end
        object cxLabel6: TcxLabel
          Left = 148
          Top = 11
          Caption = 'Lucro Real/Balancete'
        end
        object lblReceitaCsll: TcxLabel
          Left = 278
          Top = 11
          Caption = 'Receita'
        end
        object edtBaseCalculoCsllBal: TcxCalcEdit
          Left = 150
          Top = 31
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 6
          Width = 121
        end
        object edtCsllBal: TcxCalcEdit
          Left = 150
          Top = 61
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 7
          Width = 121
        end
        object edtDeducaoCsllBal: TcxCalcEdit
          Left = 150
          Top = 117
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 8
          Width = 121
        end
        object edtCsllRecolherBal: TcxCalcEdit
          Left = 150
          Top = 144
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 9
          Width = 121
        end
        object edtBaseCalculoCslRec: TcxCalcEdit
          Left = 278
          Top = 31
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 10
          Width = 121
        end
        object edtCsllRec: TcxCalcEdit
          Left = 278
          Top = 61
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 11
          Width = 121
        end
        object edtCsllRecolherRec: TcxCalcEdit
          Left = 278
          Top = 144
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 12
          Width = 121
        end
      end
      object gbImpostoRenda: TcxGroupBox
        Left = 415
        Top = 30
        Caption = 'Imposto de Renda'
        TabOrder = 2
        Height = 174
        Width = 410
        object cxLabel8: TcxLabel
          Left = 23
          Top = 35
          Caption = 'Base de Calculo do IRPJ:'
        end
        object cxLabel9: TcxLabel
          Left = 102
          Top = 62
          Caption = '(=) IRPJ:'
        end
        object cxLabel10: TcxLabel
          Left = 79
          Top = 90
          Caption = '(+) Adicional:'
        end
        object cxLabel11: TcxLabel
          Left = 11
          Top = 118
          Caption = '(-) Dedu'#231#245'es e Reten'#231#245'es:'
        end
        object cxLabel12: TcxLabel
          Left = 47
          Top = 145
          Caption = '(=) IRPJ a Recolher:'
        end
        object edtBaseCalculoIrpjBal: TcxCalcEdit
          Left = 152
          Top = 34
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 5
          Width = 121
        end
        object edtBaseCalculoIrpjRec: TcxCalcEdit
          Left = 282
          Top = 34
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 6
          Width = 121
        end
        object edtIrpjBal: TcxCalcEdit
          Left = 152
          Top = 61
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 7
          Width = 121
        end
        object edtIrpjRec: TcxCalcEdit
          Left = 282
          Top = 61
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 8
          Width = 121
        end
        object edtDeducaoIrpjBal: TcxCalcEdit
          Left = 152
          Top = 117
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 9
          Width = 121
        end
        object edtIrpjRecolherBal: TcxCalcEdit
          Left = 152
          Top = 144
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 10
          Width = 121
        end
        object edtIrpjRecolherRec: TcxCalcEdit
          Left = 282
          Top = 144
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 11
          Width = 121
        end
        object edtAdicionalIrpjBal: TcxCalcEdit
          Left = 152
          Top = 89
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 12
          Width = 121
        end
        object edtAdicionalIrpjRec: TcxCalcEdit
          Left = 282
          Top = 89
          EditValue = 0.000000000000000000
          Enabled = False
          Properties.DisplayFormat = '#,##0.00'
          TabOrder = 13
          Width = 121
        end
        object cxLabel13: TcxLabel
          Left = 152
          Top = 11
          Caption = 'Lucro Real/Balancete'
        end
        object lblReceitaIrpj: TcxLabel
          Left = 282
          Top = 11
          Caption = 'Receita'
        end
      end
      object cxLabel15: TcxLabel
        Left = 592
        Top = 11
        Caption = 'Periodo de Apura'#231#227'o:'
      end
      object edtPeriodo: TcxComboBox
        Left = 702
        Top = 10
        Properties.DropDownListStyle = lsEditFixedList
        Properties.DropDownRows = 12
        Properties.OnEditValueChanged = edtPeriodoPropertiesEditValueChanged
        TabOrder = 0
        Width = 121
      end
    end
    object tsDeterminacaoEstimativasMensais: TcxTabSheet
      Caption = '05 - Determina'#231#227'o das Estimativas Mensais'
      ImageIndex = 4
      object gbAba05Csll: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Caption = 'CSLL'
        TabOrder = 0
        Height = 143
        Width = 1441
        object GridCitelDetEstMenCsll: TcxGridCitel
          Left = 2
          Top = 19
          Width = 1437
          Height = 97
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCitelDetEstMenCsllTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnEditing = GridCitelDedRetCsllTableViewEditing
            DataController.DataSource = dsDetEstMenCsll
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCitelDetEstMenCsllTableViewCODIGO: TcxGridDBColumn
              DataBinding.FieldName = 'CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCitelDetEstMenCsllTableViewDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Width = 272
            end
            object GridCitelDetEstMenCsllTableViewEVLR01: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR01'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR02: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR02'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR03: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR03'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR04: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR04'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR05: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR05'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR06: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR06'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR07: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR07'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR08: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR08'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR09: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR09'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR10: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR10'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR11: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR11'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitelDetEstMenCsllTableViewEVLR12: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR12'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
          end
          object GridCitelDetEstMenCsllLevel: TcxGridLevel
            GridView = GridCitelDetEstMenCsllTableView
          end
        end
        object pnlRecolhimentoCSLL: TPanel
          Left = 2
          Top = 116
          Width = 1437
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnRecolhimentoCSLL: TcxButton
            Left = 0
            Top = 0
            Width = 153
            Height = 25
            Align = alLeft
            Caption = 'Ajuste Recolhimento'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000002D744558745469746C650044423B536F757263653B53746F723B6461
              7461736F757263653B44617461626173653B4564697428F6BA9C000002CB4944
              4154785E85937F48935B1C875F5BD7E59C3F0A6E7F5C1542826B21977185F08F
              CA689933572A3A912B52846228AC5B570B0C6A4C19C950732A0C5774AF190B26
              944DCBED4E3653376992F86366C31F77375CE69C7935AEE8749FCE79D9FEC8B2
              BEF0F9EF3CCFF77CCF97C3900A21E198EB7372FA5592066BA3A4D3AACA19B736
              E4A2AF3E7BDCACCCECFA5B215675CA44B9E4DC6E7A1E00130C2D8EAD29AFC7A9
              97C3FDB215DE8927587519E1FF308815A70E0BF666B84C728CB496C0284FEFA3
              92ED821F6C8DB9C0C63CB03E07ACCDC2FF7112FE9561F897ACD8F2F460735E0F
              DF9C0E46591A2542B70B42FBEBB2E1231DB1F13E20992692096C2EDBF1F18D0E
              5E5B3DBC966B787E434809EE7601F7853213EB0B06F896C788C0830D771BFE73
              48F1CEF41B4695420C57A7C0DD9E0FABFA32257881B7E004DE8FD9635188BF2B
              F0586418EFD2A05B965463BEF52BDAA58714747C2A08335589BE2970FE258577
              E411065B8A31FB341B5BFE69BCD68AD194157B9B15186E9EDE5130A5BD02578F
              0663DA524C3F3EC7C2BE99320C5426A056F823A880F7AC52F855C1E2901CFF9A
              EF62E85E119CBA0C165E7314A1B7FC207A9547512E88A8A382707D45CA1782D5
              99062C4C686127F0E443110BAFD80B61961E80A92A19D244FE1DDA9C15745C3D
              FAB9C063C0F2DB0E0C6B2FC1715FC8C28B16094CA57178762309253FF35484E3
              93EC62B7D05672A47BA0F922662D77B13465C3FAD22B8CF66B6055A6B2B0BBF3
              2C8C2531E8F8E3175C88DFA3264C04850BF6936D062CE1B57989C59A4281FECF
              F302875DD7B45571A50AFA1605FE7F6B83A13806BAB20414C4715B08104D997F
              B4A98C641F8709564860A7BC803D4670EADACCA8AD1B0F6AAEA3FA443CF27F0A
              550761A7E638E3D41C63B2A20806E08B908A8C8E1122627FB22B2CFAB03A3692
              7F3238B3981FC2D0648433CC193EB3A3800E1745B2978E17FCC6E9E47EA23086
              4923A192DFE3B9CC27707A3E75A45EF6F60000000049454E44AE426082}
            TabOrder = 0
            OnClick = btnRecolhimentoCSLLClick
          end
        end
      end
      object gbAba05Irpj: TcxGroupBox
        Left = 0
        Top = 143
        Align = alTop
        Caption = 'IRPJ'
        TabOrder = 1
        Height = 143
        Width = 1441
        object GridCitellDetEstMenIrpj: TcxGridCitel
          Left = 2
          Top = 19
          Width = 1437
          Height = 97
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCitellDetEstMenIrpjTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnEditing = GridCitelDedRetCsllTableViewEditing
            DataController.DataSource = dsDetEstMenIrpj
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCitellDetEstMenIrpjTableViewCODIGO: TcxGridDBColumn
              DataBinding.FieldName = 'CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCitellDetEstMenIrpjTableViewDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Width = 272
            end
            object GridCitellDetEstMenIrpjTableViewEVLR01: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR01'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR02: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR02'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR03: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR03'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR04: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR04'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR05: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR05'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR06: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR06'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR07: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR07'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR08: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR08'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR09: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR09'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR10: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR10'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR11: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR11'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridCitellDetEstMenIrpjTableViewEVLR12: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR12'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
          end
          object GridCitellDetEstMenIrpjLevel: TcxGridLevel
            GridView = GridCitellDetEstMenIrpjTableView
          end
        end
        object pnlRecolhimentoIPRJ: TPanel
          Left = 2
          Top = 116
          Width = 1437
          Height = 25
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnRecolhimentoIRPJ: TcxButton
            Left = 0
            Top = 0
            Width = 153
            Height = 25
            Align = alLeft
            Caption = 'Ajuste Recolhimento'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000002D744558745469746C650044423B536F757263653B53746F723B6461
              7461736F757263653B44617461626173653B4564697428F6BA9C000002CB4944
              4154785E85937F48935B1C875F5BD7E59C3F0A6E7F5C1542826B21977185F08F
              CA689933572A3A912B52846228AC5B570B0C6A4C19C950732A0C5774AF190B26
              944DCBED4E3653376992F86366C31F77375CE69C7935AEE8749FCE79D9FEC8B2
              BEF0F9EF3CCFF77CCF97C3900A21E198EB7372FA5592066BA3A4D3AACA19B736
              E4A2AF3E7BDCACCCECFA5B215675CA44B9E4DC6E7A1E00130C2D8EAD29AFC7A9
              97C3FDB215DE8927587519E1FF308815A70E0BF666B84C728CB496C0284FEFA3
              92ED821F6C8DB9C0C63CB03E07ACCDC2FF7112FE9561F897ACD8F2F460735E0F
              DF9C0E46591A2542B70B42FBEBB2E1231DB1F13E20992692096C2EDBF1F18D0E
              5E5B3DBC966B787E434809EE7601F7853213EB0B06F896C788C0830D771BFE73
              48F1CEF41B4695420C57A7C0DD9E0FABFA32257881B7E004DE8FD9635188BF2B
              F0586418EFD2A05B965463BEF52BDAA58714747C2A08335589BE2970FE258577
              E411065B8A31FB341B5BFE69BCD68AD194157B9B15186E9EDE5130A5BD02578F
              0663DA524C3F3EC7C2BE99320C5426A056F823A880F7AC52F855C1E2901CFF9A
              EF62E85E119CBA0C165E7314A1B7FC207A9547512E88A8A382707D45CA1782D5
              99062C4C686127F0E443110BAFD80B61961E80A92A19D244FE1DDA9C15745C3D
              FAB9C063C0F2DB0E0C6B2FC1715FC8C28B16094CA57178762309253FF35484E3
              93EC62B7D05672A47BA0F922662D77B13465C3FAD22B8CF66B6055A6B2B0BBF3
              2C8C2531E8F8E3175C88DFA3264C04850BF6936D062CE1B57989C59A4281FECF
              F302875DD7B45571A50AFA1605FE7F6B83A13806BAB20414C4715B08104D997F
              B4A98C641F8709564860A7BC803D4670EADACCA8AD1B0F6AAEA3FA443CF27F0A
              550761A7E638E3D41C63B2A20806E08B908A8C8E1122627FB22B2CFAB03A3692
              7F3238B3981FC2D0648433CC193EB3A3800E1745B2978E17FCC6E9E47EA23086
              4923A192DFE3B9CC27707A3E75A45EF6F60000000049454E44AE426082}
            TabOrder = 0
            OnClick = btnRecolhimentoIRPJClick
          end
        end
      end
      object gbAba05Recolhimento: TcxGroupBox
        Left = 0
        Top = 286
        Align = alTop
        Caption = 'Recolhimento'
        TabOrder = 2
        Height = 175
        Width = 1441
        object GridlDetEstMenCsllRecolhimento: TcxGrid
          Left = 2
          Top = 39
          Width = 1437
          Height = 134
          Align = alClient
          TabOrder = 0
          object GridlDetEstMenCsllRecolhimentoTableView: TcxGridDBTableView
            OnKeyDown = GridlDetEstMenCsllRecolhimentoTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnEditing = GridCitelDedRetCsllTableViewEditing
            OnFocusedItemChanged = GridlDetEstMenCsllRecolhimentoTableViewFocusedItemChanged
            DataController.DataSource = dsDetEstMenRecolhimento
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Header = False
            OptionsView.HeaderAutoHeight = True
            Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
            object GridlDetEstMenCsllRecolhimentoTableViewCODIGO: TcxGridDBColumn
              DataBinding.FieldName = 'CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridlDetEstMenCsllRecolhimentoTableViewDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Width = 272
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR01: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR01'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR02: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR02'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR03: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR03'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR04: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR04'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR05: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR05'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR06: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR06'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR07: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR07'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR08: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR08'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR09: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR09'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR10: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR10'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR11: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR11'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
            object GridlDetEstMenCsllRecolhimentoTableViewEVLR12: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR12'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 85
            end
          end
          object GridlDetEstMenCsllRecolhimentoLevel: TcxGridLevel
            GridView = GridlDetEstMenCsllRecolhimentoTableView
          end
        end
        object GridCitelDetEstMenOpcao: TcxGridCitel
          Left = 2
          Top = 19
          Width = 1437
          Height = 20
          Align = alTop
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCitelDetEstMenOpcaoTableView: TcxGridDBTableViewCitel
            OnKeyDown = GridCitelDetEstMenOpcaoTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnEditing = GridCitelDedRetCsllTableViewEditing
            OnFocusedItemChanged = GridCitelDetEstMenOpcaoTableViewFocusedItemChanged
            DataController.DataSource = dsDetEstMenOpcao
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnHorzSizing = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Header = False
            OptionsView.HeaderAutoHeight = True
            Styles.OnGetContentStyle = GridCitelDedRetCsllTableViewStylesGetContentStyle
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCitelDetEstMenOpcaoTableViewCODIGO: TcxGridDBColumn
              DataBinding.FieldName = 'CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCitelDetEstMenOpcaoTableViewDESCRI: TcxGridDBColumn
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Width = 272
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR01: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR01'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR02: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR02'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR03: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR03'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR04: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR04'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR05: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR05'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR06: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR06'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR07: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR07'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR08: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR08'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR09: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR09'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR10: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR10'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR11: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR11'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Receita'
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
            object GridCitelDetEstMenOpcaoTableViewEVLR12: TcxGridDBColumn
              DataBinding.FieldName = 'EVLR12'
              PropertiesClassName = 'TcxComboBoxProperties'
              Properties.Items.Strings = (
                'Balancete')
              Properties.OnEditValueChanged = GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged
              Width = 85
            end
          end
          object GridCitelDetEstMenOpcaoLevel: TcxGridLevel
            GridView = GridCitelDetEstMenOpcaoTableView
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 120
  end
  object dsApuRecAcrCsll: TDataSource
    Left = 680
    Top = 132
  end
  object dsApuRecAcrIrpj: TDataSource
    Left = 680
    Top = 180
  end
  object EstiloRepositorio: TcxStyleRepository
    Left = 680
    Top = 236
    PixelsPerInch = 96
    object sltLinhaDestacada: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dsDedRetCsll: TDataSource
    Left = 680
    Top = 292
  end
  object dsDedRetIrpj: TDataSource
    Left = 680
    Top = 348
  end
  object dsDetEstMenCsll: TDataSource
    Left = 680
    Top = 431
  end
  object dsDetEstMenIrpj: TDataSource
    Left = 681
    Top = 483
  end
  object dsDetEstMenRecolhimento: TDataSource
    Left = 682
    Top = 535
  end
  object dsDetEstMenOpcao: TDataSource
    Left = 802
    Top = 535
  end
end
