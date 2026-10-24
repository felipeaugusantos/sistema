inherited frmTransacaoTef: TfrmTransacaoTef
  Width = 927
  Height = 578
  Caption = 'Consulta Transa'#231#245'es TEF'
  Position = poMainFormCenter
  ExplicitWidth = 927
  ExplicitHeight = 578
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 505
    Width = 921
    ExplicitTop = 505
    ExplicitWidth = 921
    inherited FlwBotoes: TFlowPanel
      Width = 917
      ExplicitWidth = 917
    end
    inherited btnSair: TBitBtnLocked
      Left = 807
      Width = 111
      Caption = '[Esc] &Sair'
      ExplicitLeft = 807
      ExplicitWidth = 111
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 921
    ExplicitTop = 533
    ExplicitWidth = 921
    inherited pnlNomeForm: TPanel
      Left = 749
      Width = 172
      ExplicitLeft = 749
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 749
      ExplicitWidth = 749
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 921
    Height = 505
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlConsulta: TPanel
      Left = 0
      Top = 0
      Width = 921
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        921
        57)
      object pnlFiltros: TFlowPanel
        Left = 0
        Top = 0
        Width = 921
        Height = 45
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        TabStop = True
        object gbTipoBusca: TGroupBox
          Left = 0
          Top = 0
          Width = 221
          Height = 45
          Caption = 'Transa'#231#245'es'
          TabOrder = 0
          object rbTodas: TRadioButton
            Left = 12
            Top = 17
            Width = 53
            Height = 17
            Caption = 'Todas'
            TabOrder = 0
            OnClick = rbTodasClick
            OnKeyPress = rbTodasKeyPress
          end
          object rbPendentes: TRadioButton
            Left = 67
            Top = 17
            Width = 70
            Height = 17
            Caption = 'Pendentes'
            TabOrder = 1
            OnClick = rbTodasClick
            OnKeyPress = rbTodasKeyPress
          end
          object rbEspecifica: TRadioButton
            Left = 143
            Top = 17
            Width = 70
            Height = 17
            Caption = 'Espec'#237'fica'
            TabOrder = 2
            OnClick = rbTodasClick
            OnKeyPress = rbTodasKeyPress
          end
        end
        object pnlDtaIni: TPanel
          Left = 221
          Top = 0
          Width = 107
          Height = 45
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object lblDtaIni: TLabel
            Left = 13
            Top = 0
            Width = 51
            Height = 14
            Caption = 'Data Inicial'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object cxDtInicial: TcxDateEdit
            Left = 13
            Top = 17
            TabOrder = 0
            Width = 85
          end
        end
        object pnlDtafin: TPanel
          Left = 328
          Top = 0
          Width = 106
          Height = 45
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          object lblDtaFin: TLabel
            Left = 13
            Top = 0
            Width = 47
            Height = 14
            Caption = 'Data Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object cxDtFinal: TcxDateEdit
            Left = 13
            Top = 17
            TabOrder = 0
            Width = 85
          end
        end
        object pnlNumNsu: TPanel
          Left = 434
          Top = 0
          Width = 115
          Height = 45
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 3
          object lblNumNsu: TLabel
            Left = 13
            Top = 0
            Width = 21
            Height = 14
            Caption = 'NSU'
          end
          object edtNumNsu: TEditFocus
            Tag = 99
            Left = 13
            Top = 17
            Width = 90
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            OnExit = RemoverFiltro
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlNumAutorizacao: TPanel
          Left = 549
          Top = 0
          Width = 196
          Height = 45
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 4
          object lblFiltroNumAut: TLabel
            Left = 6
            Top = 0
            Width = 59
            Height = 14
            Caption = 'Autoriza'#231#227'o'
          end
          object lblValor: TLabel
            Left = 102
            Top = 0
            Width = 25
            Height = 14
            Caption = 'Valor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtNumAutorizacao: TEditFocus
            Tag = 99
            Left = 6
            Top = 17
            Width = 90
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            OnExit = RemoverFiltro
            OnKeyPress = edtNumAutorizacaoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtVlrTransacao: TEditFocus
            Left = 102
            Top = 17
            Width = 90
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 50
            TabOrder = 1
            Text = '0,00'
            OnExit = RemoverFiltro
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
      end
      object btnConsultar: TcxButton
        Left = 784
        Top = 16
        Width = 127
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = '[F10] &Consultar'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000047744558745469746C6500436F6E646974696F6E616C466F726D6174
          74696E7349636F6E536574547261666669634C6967687473333B436F6E646974
          696F6E616C466F726D617474696E673B4DFCA3D9000002EB49444154785E5D53
          6F48536F143EEF7627685991058549C36CA985454490CD597D8A82FC4384F8A1
          A2B0D035B5BEE497FA90066626044260189893A00F15094EC2922611A39A12A6
          3FB7F99BD3253A3767B9393777DFB7F3BE779A74EECECE3D7F9EE73CEFBD5C70
          F95F084723E86AE3FDFCE2EA26FDD3DAE682AFB75A0C511E795E557FAC04FB12
          3A71F8CCE09833C3CD47060067025C663A945ED3A47FDBF0AC9859BE36B0414F
          1B73CC75F188F93D56DF5EC46E341EEF3E5F99B70B01AA315F27E03C08F0E5BA
          23B9B75A4EF83ADFD5B021EF13F6D155C72CA3D758F7F025D63352C1FA9DB7D9
          E0542B7BDE6B62D50FF4B3A5D70F683989A9311FC8DEBC6DC9A7CB759F0BF30B
          0EA667A44220E402CA647120C6008D89480881B48D5930ED5984BE81819EB6BB
          B6526CC6C8D53B47AFECC9CC68371872617E6902C11484AD81C5BF5242D2B464
          2D58ADA3E0189BBC6A7E68EF90240D29D36569613E3C053295D7865759283220
          4E446E81B0077459BBC1EDF69663DA250190C31B360344681498185206293A41
          350817A4D81391E295B2990251B13CFED624949C4649586C17A66C52404281C8
          84AFF2534D0864C6B6F01D523C2ECF8796425B89860F5001123F854C5145D6D5
          0881700417AED05F3C55C596E9907F6E09C1042895D119B2D3C43D15A4A24645
          4DA8F0FB22105D8E0FF315526831FA7ADC1138B57DE70E04F235CA51D8BFC761
          4CBC4A3510187706617121FA125B2B2AEB2BB7D9EB0DFC3731BE006A2209CC9A
          028C3246BE5D51AF8109D76FF0FC1FE8EBED709AB11457057D91D04FE7E2C541
          DBB4DF311204822404545C8120E1A6226A017662DF6E9B0DB87F046BB11C29AD
          DECF54D8973F757B86866D3EFDB7CFD3EFFB2D1E98F546418E4990A44981F88A
          0433DE08F45B26C1FE69E6C388CD57F0DD3AE3E038CA95D9A71E0B75892F2DF5
          645966E5D98A7DD622634EB0C494C3CE19B383672A74D6C20BDA2AEC6F4ACC91
          2F9E66283266032936E502614C487ED33ACA8992122E29C4A215478F71471083
          75F6070B79B97E3856EEF50000000049454E44AE426082}
        TabOrder = 1
        OnClick = btnConsultarClick
      end
    end
    object GridCitel: TcxGridCitel
      Left = 0
      Top = 57
      Width = 921
      Height = 407
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridCitelTableView: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        FindPanel.DisplayMode = fpdmAlways
        FindPanel.InfoText = 'Digite algo para filtrar na grid'
        FindPanel.ShowClearButton = False
        FindPanel.ShowCloseButton = False
        FindPanel.ShowFindButton = False
        DataController.DataSource = srcTransacoes
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyRecordsToClipboard = False
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.OnGetContentStyle = GridCitelTableViewStylesGetContentStyle
        Bands = <
          item
          end>
        object GridCitelTableViewCODLOJ: TcxGridDBBandedColumn
          Caption = 'C'#243'digo Loja'
          DataBinding.FieldName = 'CODLOJ'
          Width = 87
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridCitelTableViewNUMPDV: TcxGridDBBandedColumn
          Caption = 'Num. PDV'
          DataBinding.FieldName = 'NUMPDV'
          Width = 88
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridCitelTableViewDTAHRA: TcxGridDBBandedColumn
          Caption = 'Data / Hora'
          DataBinding.FieldName = 'DTAHRA'
          Width = 98
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridCitelTableViewNUMNSU: TcxGridDBBandedColumn
          Caption = 'NSU'
          DataBinding.FieldName = 'NUMNSU'
          Width = 113
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object GridCitelTableViewNUMCAR: TcxGridDBBandedColumn
          Caption = 'Num. Car.'
          DataBinding.FieldName = 'NUMCAR'
          Width = 113
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object GridCitelTableViewINFTRN: TcxGridDBBandedColumn
          Caption = 'Info. Transa'#231#227'o'
          DataBinding.FieldName = 'INFTRN'
          Width = 246
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object GridCitelTableViewTIPTRN: TcxGridDBBandedColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TIPTRN'
          Width = 162
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object GridCitelTableViewQTDPAR: TcxGridDBBandedColumn
          Caption = 'Qtd. Parc.'
          DataBinding.FieldName = 'QTDPAR'
          Width = 113
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object GridCitelTableViewVALTRN: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALTRN'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Width = 131
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object GridCitelTableViewNOMRED: TcxGridDBBandedColumn
          Caption = 'Adquirente'
          DataBinding.FieldName = 'NOMRED'
          Width = 177
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object GridCitelTableViewNOMBAN: TcxGridDBBandedColumn
          Caption = 'Bandeira'
          DataBinding.FieldName = 'NOMBAN'
          Width = 203
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object GridCitelTableViewCONTRO: TcxGridDBBandedColumn
          Caption = 'Controle'
          DataBinding.FieldName = 'CONTRO'
          Width = 151
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object GridCitelTableViewNSUHOS: TcxGridDBBandedColumn
          Caption = 'NSU Host'
          DataBinding.FieldName = 'NSUHOS'
          Width = 178
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object GridCitelTableViewCODAUT: TcxGridDBBandedColumn
          Caption = 'Autoriza'#231#227'o'
          DataBinding.FieldName = 'CODAUT'
          Width = 146
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object GridCitelTableViewCODSIT: TcxGridDBBandedColumn
          Caption = 'Cod Sit.'
          DataBinding.FieldName = 'CODSIT'
          Width = 94
          Position.BandIndex = 0
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
        object GridCitelTableViewESTADO: TcxGridDBBandedColumn
          Caption = 'Status'
          DataBinding.FieldName = 'ESTADO'
          Width = 250
          Position.BandIndex = 0
          Position.ColIndex = 15
          Position.RowIndex = 0
        end
        object GridCitelTableViewSEQTRN: TcxGridDBBandedColumn
          Caption = 'Seq.'
          DataBinding.FieldName = 'SEQTRN'
          Visible = False
          Width = 45
          Position.BandIndex = 0
          Position.ColIndex = 16
          Position.RowIndex = 0
        end
      end
      object GridCitelLevel: TcxGridLevel
        GridView = GridCitelTableView
      end
    end
    object pnlAcoes: TPanel
      Left = 0
      Top = 464
      Width = 921
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        921
        41)
      object btnConfirma: TcxButton
        Left = 585
        Top = 10
        Width = 160
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '[F5] Confirmar &Pendente'
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
        OnClick = btnConfirmaClick
      end
      object btnCancela: TcxButton
        Left = 751
        Top = 10
        Width = 160
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = '[F7] Cancelar P&endente'
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
        OnClick = btnCancelaClick
      end
      object btnExportar: TcxButton
        Left = 5
        Top = 10
        Width = 160
        Height = 25
        Caption = '[F9] &Exportar'
        DropDownMenu = PopupMenuExportar
        Kind = cxbkDropDown
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000011744558745469746C65004578706F72743B5361766546D49E310000
          02A849444154785E75935D48145D1CC69F597752C3B24C5E83EAA58B280C5E2A
          56892EB22E22C88BA4ABBC780D0BCA2ECCD0A88B500991288A85C2A8E8830A82
          E0C525FB80B20431B008D74273D12CECA2CD6D5BF755576767E77CFC3B737649
          43FA313F660F67FFCF3C676040440B74A9BC50A05598FBCF2F9FDA5E67068ACB
          B38A0064298DB206133B941EFC012125AE1F7F09858709324E55B5EC5BBB29FF
          9DEF80778F1BDAE36746FB59BD0F43E9D1C9739ACA5C659EB2B0A265E974D80A
          507FB88D8E5EF689AD47CC4B797F19F9EE8C1E3E78C2DF05183B133FA2902450
          BE6B1B5E472E226A0F00A42FF8EBCF2162BDC712F36F74F77E40A0F3E160F433
          AF7603BCD50D7E56EAFB072F9E76E2E6D516907050D3B601574EDE01490E490C
          F15408E19920B864C8C95A86443C1777DB3B925E008694029C7108CE202561D6
          72C0B944D4EA5343FD1092E94121B9FE9D901388C46D4C4FA5900E10028C7325
          0317128280352BB6A0A6F90CD21838565B0A41025230F4F68EE34D772C141F13
          877580105237E09CEB06D39640EDDE7B906A3D339340C30D9F3A7B2146232378
          FE388CB1A1E4AD6F6F65D36C9462BF1A389C4328FFADAAD34F2229414458BF6E
          353808C1C14F78F6E83B56792A30FAE4FE690013ED1F778B7403B73EE328DE5C
          A2872408B393FF23168BA1A070251033D015209414D5C3B6090A6B63A5573436
          77410770B7418A213AFE15FFDD6EC53CF4B12CEB109A5AAF810903C3C3437009
          3DE070D101EE5939635A97D8940D0DB9170130111A194376F662388E03858788
          E602DC41E69ADED4C7A04C403AC2004B39F09AB99042426120C3FC77A0FFD4D8
          31022E094220735712A970068F9D849442A7CE0FE089C978CF40B0AF6C91E9C5
          60F00BB83054558694CD95496838834824C058EA95BB52FEF621E528CDCC7A6E
          6F21A4644A9B8874959FB191A9A729553D740000000049454E44AE426082}
        TabOrder = 2
      end
      object btnImprimirComprovante: TcxButton
        Left = 170
        Top = 10
        Width = 160
        Height = 25
        Caption = '[F6] &Imprimir Comprovante'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000C744558745469746C65005072696E743BC83632EA00000267494441
          54785E7D93CB6B135114C6BF99C434A60F05698B1B5716752582E84AAD2822B6
          88B8101F50B45441210BEBC285150591A250A326462AA218F20FB810178A482C
          AD165AD0958216051F68D1966426F3B82FCFDCCC0C71512F7C73EE3DDCEF77EE
          DC87A19442D40C6AB74A332F4CD3EC05745E7FA33982F1CAF0E0D65D34E69127
          897F9B49EA3D7374A376AA901041F2E5D9ED0012A4A5019C0B28092C5A5E58D9
          808244476B0B38135111C4005AB55E7D587D191712928C147579052308908272
          5C03D2E4610064A0C0648E8E5776DF2EBF7D33385CB0BF7C7E0F2915494288C0
          28C0833E69EEE33B1C3E35FA67ECE1CCF4C5DCD33D0012C9E0B33CD3513EB477
          6DD744E54930D4D5852008240CD55807A3B1EB3AB0EC1A8EF4ADDF547A2C4B00
          D66880E0AAAB7B550675CB42329186904A5754A119000125015C38561DAB3B33
          604C75462B303D5F5042229D4AE0E78FEF3878EC4274046150210C686F4BE8B9
          9EC7D00460700832347000378B252C2C542145E0931AA1A4D23BBC72453B4E0F
          1D87C3380138026F03E032D409D2B3A107C5FC95C6A1C8F0084D8A8D0C744602
          B6CB41459B003E47CDE1A8D7194E666FE07FED5EFE2C7C9102F385E60600C3F7
          04AA1643D576B0BFBF0FD981CD284CCDEBCD6402641038BFA31BC5F22C7E2FDA
          A03F81CF1A0013009BFFF5753277E719EE8E3F070FCFDD63244E002E29070DE3
          D4B976BD8C91CB0FF0E9C3E46B10C708EF762BA985D43632F6722E7B628BDE79
          4087F846161E4DE3EAB99DEB0054490EC94E2AA54490085FA3655BD6ABDCFDA9
          6DF1B6A9F8ADC2756B1300BE91C75EEA31F9B94BFDFB00A44866EC44FCB23D92
          DB6CF80BF54A6944F3A08E160000000049454E44AE426082}
        TabOrder = 3
        OnClick = btnImprimirComprovanteClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 376
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 240
  end
  object srcTransacoes: TDataSource
    AutoEdit = False
    Left = 96
    Top = 240
  end
  object StyleRepository: TcxStyleRepository
    Left = 82
    Top = 377
    PixelsPerInch = 96
    object estiloPendente: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = 33023
    end
    object estiloConfirmada: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clBlue
    end
    object estiloCancelada: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
    object estiloPadrao: TcxStyle
    end
  end
  object PopupMenuExportar: TPopupMenu
    Left = 88
    Top = 312
    object Excel1: TMenuItem
      Caption = 'Excel'
      OnClick = Excel1Click
    end
    object CSV1: TMenuItem
      Caption = 'CSV'
      OnClick = CSV1Click
    end
    object mniPDF: TMenuItem
      Caption = 'PDF'
      OnClick = mniPDFClick
    end
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    Grid = GridCitel
    PopupMenus = <>
    Left = 208
    Top = 376
  end
  object frxRelatorio: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44466.630132476900000000
    ReportOptions.LastChange = 45957.705198854160000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '  '
      'end.          ')
    Left = 784
    Top = 242
    Datasets = <
      item
        DataSet = frxDBRelatorio
        DataSetName = 'frxGerar'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object BandaCabecalho: TfrxReportTitle
        FillType = ftBrush
        Height = 21.086580000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        StartNewPage = True
      end
      object Cabecalho: TfrxHeader
        FillType = ftBrush
        Height = 13.456710000000000000
        Top = 102.047310000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          Left = 3.000000000000000000
          Width = 45.354311180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd.Loja')
          ParentFont = False
        end
        object sep1: TfrxLineView
          Top = 13.456710000000000000
          Width = 1054.488625910000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Left = 49.133890000000000000
          Width = 49.133841180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Num. PDV')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 98.826840000000000000
          Width = 86.929141180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data / Hora')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 184.417440000000000000
          Width = 79.370130000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'NSU')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 264.567100000000000000
          Width = 79.370081180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Num. Cart'#227'o')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 943.882500000000000000
          Width = 90.708671180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Info. Trans.')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 786.803652440000000000
          Width = 37.795251180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Tipo')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 400.630182440000000000
          Width = 49.133890000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd. Parc.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 607.590910000000000000
          Width = 60.472431180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NSU Host')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 668.063390000000000000
          Width = 64.251961180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Autoriza'#231#227'o')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 450.205012440000000000
          Width = 45.354311180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. Sit.')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 495.118430000000000000
          Width = 109.606370000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Status')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 344.937230000000000000
          Width = 56.692901180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 733.890232440000000000
          Width = 52.913371180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Adquirente')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 828.937542440000000000
          Width = 52.913371180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Bandeira')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 885.071432440000000000
          Width = 56.692950000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Controle')
          ParentFont = False
        end
      end
      object Detail: TfrxMasterData
        FillType = ftBrush
        Height = 13.228346460000000000
        Top = 139.842610000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBRelatorio
        DataSetName = 'frxGerar'
        RowCount = 0
        Stretched = True
        object frxCODLOJ: TfrxMemoView
          Left = 3.000000000000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataField = 'CODLOJ'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."CODLOJ"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNUMPDV: TfrxMemoView
          Left = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 13.228346460000000000
          DataField = 'NUMPDV'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."NUMPDV"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDTAHRA: TfrxMemoView
          Left = 97.826840000000000000
          Width = 86.929141180000000000
          Height = 13.228346460000000000
          DataField = 'DTAHRA'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."DTAHRA"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNUMNSU: TfrxMemoView
          Left = 188.535560000000000000
          Width = 75.590600000000000000
          Height = 13.228346460000000000
          DataField = 'NUMNSU'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGerar."NUMNSU"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNUMCAR: TfrxMemoView
          Left = 264.567100000000000000
          Width = 79.370130000000000000
          Height = 13.228346460000000000
          DataField = 'NUMCAR'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGerar."NUMCAR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxVALTRN: TfrxMemoView
          Left = 344.937230000000000000
          Width = 56.692950000000000000
          Height = 13.228346460000000000
          DataField = 'VALTRN'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGerar."VALTRN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxQTDPAR: TfrxMemoView
          Left = 401.630182440000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataField = 'QTDPAR'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."QTDPAR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxCODSIT: TfrxMemoView
          Left = 450.205012440000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          DataField = 'CODSIT'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."CODSIT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxESTADO: TfrxMemoView
          Left = 495.118430000000000000
          Width = 109.606370000000000000
          Height = 13.228346460000000000
          DataField = 'ESTADO'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGerar."ESTADO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxCODAUT: TfrxMemoView
          Left = 668.063390000000000000
          Width = 64.252010000000000000
          Height = 13.228346460000000000
          DataField = 'CODAUT'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGerar."CODAUT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNSUHOS: TfrxMemoView
          Left = 607.590910000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataField = 'NSUHOS'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGerar."NSUHOS"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNOMRED: TfrxMemoView
          Left = 733.890232440000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataField = 'NOMRED'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGerar."NOMRED"]')
          ParentFont = False
          WordWrap = False
        end
        object frxTIPTRN: TfrxMemoView
          Left = 786.803652440000000000
          Width = 37.795300000000000000
          Height = 13.228346456692910000
          DataField = 'TIPTRN'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."TIPTRN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNOMBAN: TfrxMemoView
          Left = 828.937542440000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataField = 'NOMBAN'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGerar."NOMBAN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxCONTRO: TfrxMemoView
          Left = 885.071432440000000000
          Width = 56.692950000000000000
          Height = 13.228346460000000000
          DataField = 'CONTRO'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxGerar."CONTRO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxINFTRN: TfrxMemoView
          Left = 943.102972440000000000
          Width = 102.047310000000000000
          Height = 13.228346460000000000
          DataField = 'INFTRN'
          DataSet = frxDBRelatorio
          DataSetName = 'frxGerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGerar."INFTRN"]')
          ParentFont = False
          WordBreak = True
          WordWrap = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 215.433210000000000000
        Width = 1046.929810000000000000
      end
    end
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software Ltda'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 784
    Top = 178
  end
  object frxDBRelatorio: TfrxDBDataset
    UserName = 'frxGerar'
    CloseDataSource = False
    DataSet = cdsDadosRelatorio
    BCDToCurrency = False
    Left = 672
    Top = 252
  end
  object cdsDadosRelatorio: TUniClientDataSet
    PersistDataPacket.Data = {
      B50100009619E0BD010000001800000011000000000003000000B50106534551
      54524E0400010000000000064454414852410800080000000000064E554D4E53
      55010049000000010005574944544802000200100006434F4E54524F01004900
      000001000557494454480200020010000654495054524E010049000000010005
      574944544802000200200006494E4654524E0100490000000100055749445448
      020002004B000645535441444F01004900000001000557494454480200020028
      000656414C54524E080004000000000006434F44534954010049000000010005
      5749445448020002001000064E4F4D5245440100490000000100055749445448
      020002002000064E4F4D42414E01004900000001000557494454480200020020
      00064E5355484F530100490000000100055749445448020002001000064E554D
      434152010049000000010005574944544802000200140006434F444C4F4A0100
      490000000100055749445448020002001400064E554D50445601004900000001
      0005574944544802000200140006515444504152040001000000000006434F44
      4155540100490000000100055749445448020002001E000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 672
    Top = 180
    object cdsDadosRelatorioSEQTRN: TIntegerField
      FieldName = 'SEQTRN'
    end
    object cdsDadosRelatorioDTAHRA: TDateTimeField
      FieldName = 'DTAHRA'
    end
    object cdsDadosRelatorioNUMNSU: TStringField
      FieldName = 'NUMNSU'
      Size = 16
    end
    object cdsDadosRelatorioCONTRO: TStringField
      FieldName = 'CONTRO'
      Size = 16
    end
    object cdsDadosRelatorioTIPTRN: TStringField
      FieldName = 'TIPTRN'
      Size = 32
    end
    object cdsDadosRelatorioINFTRN: TStringField
      FieldName = 'INFTRN'
      Size = 75
    end
    object cdsDadosRelatorioESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 40
    end
    object cdsDadosRelatorioVALTRN: TFloatField
      FieldName = 'VALTRN'
    end
    object cdsDadosRelatorioCODSIT: TStringField
      FieldName = 'CODSIT'
      Size = 16
    end
    object cdsDadosRelatorioNOMRED: TStringField
      FieldName = 'NOMRED'
      Size = 32
    end
    object cdsDadosRelatorioNOMBAN: TStringField
      FieldName = 'NOMBAN'
      Size = 32
    end
    object cdsDadosRelatorioNSUHOS: TStringField
      FieldName = 'NSUHOS'
      Size = 16
    end
    object cdsDadosRelatorioNUMCAR: TStringField
      FieldName = 'NUMCAR'
    end
    object cdsDadosRelatorioCODLOJ: TStringField
      FieldName = 'CODLOJ'
    end
    object cdsDadosRelatorioNUMPDV: TStringField
      FieldName = 'NUMPDV'
    end
    object cdsDadosRelatorioQTDPAR: TIntegerField
      FieldName = 'QTDPAR'
    end
    object cdsDadosRelatorioCODAUT: TStringField
      FieldName = 'CODAUT'
      Size = 30
    end
  end
end
