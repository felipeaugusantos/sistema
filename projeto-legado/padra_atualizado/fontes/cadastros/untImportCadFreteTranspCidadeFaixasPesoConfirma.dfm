inherited frmImportCadFreteTranspCidadeFaixasPesoConfirma: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma
  Width = 1126
  Height = 681
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o de Faixas de Peso'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1126
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 600
    Width = 1110
    ExplicitTop = 600
    ExplicitWidth = 1110
    inherited FlwBotoes: TFlowPanel
      Width = 1029
      ExplicitWidth = 1029
      object btnVisProdNaoImp: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 278
        Height = 22
        Caption = 'Visualizar Relat'#243'rio de Dados n'#227'o Encontrados'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000C000000120000001400000014000000150000
          0015000000140000000D00000003000000000000000000000000000000000000
          00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
          78FFBE8978FF876356C30000000B000000000000000000000000000000030000
          000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
          E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
          42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
          72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
          6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
          76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
          71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
          35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
          78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
          DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
          7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
          32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
          86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
          42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
          8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
          DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
          84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
          E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
          2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
          E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
          0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
          E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
          00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
          EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
          00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
          FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
          000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
          91FFCDA391FF98786BC100000004000000000000000000000000}
        TabOrder = 1
        OnClick = btnVisProdNaoImpClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1031
      Top = 2
      Align = alRight
      ExplicitLeft = 1031
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 626
    Width = 1110
    ExplicitTop = 626
    ExplicitWidth = 1110
    inherited pnlNomeForm: TPanel
      Left = 939
      ExplicitLeft = 939
    end
    inherited pnlInfo: TPanel
      Width = 939
      ExplicitWidth = 939
    end
  end
  object pgcContainer: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1110
    Height = 600
    ActivePage = tbsInclui
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object tbsAltera: TTabSheet
      Caption = 'Frete por Transportadora que ser'#227'o Atualizados'
      OnShow = tbsAlteraShow
      object cxgTransportadora: TcxGrid
        Left = 0
        Top = 0
        Width = 1102
        Height = 540
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfStandard
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgTransportadoraView: TcxGridDBTableView
          OnKeyDown = cxgTransportadoraViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgTransportadoraViewCustomDrawCell
          DataController.DataModeController.GridMode = True
          DataController.DataModeController.SyncMode = False
          DataController.DataSource = dtsDadosUpd
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir o filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhum registro para ser alterado'
          OptionsView.GroupByBox = False
          object cxgTransportadoraViewUpdMARCADO: TcxGridDBColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
          end
          object cxgTransportadoraViewUpdCODTRA: TcxGridDBColumn
            Caption = 'Cod. Transportadora'
            DataBinding.FieldName = 'CODTRA'
            Width = 120
          end
          object cxgTransportadoraViewUpdNOMTRA: TcxGridDBColumn
            Caption = 'Transportadora'
            DataBinding.FieldName = 'NOMTRA'
            Width = 300
          end
          object cxgTransportadoraViewUpdCODCID: TcxGridDBColumn
            Caption = 'Cod. Cidade'
            DataBinding.FieldName = 'CODCID'
            Width = 120
          end
          object cxgTransportadoraViewUpdNOMCID: TcxGridDBColumn
            Caption = 'Cidade'
            DataBinding.FieldName = 'NOMCID'
            Width = 200
          end
          object cxgTransportadoraViewUpdVALPKG: TcxGridDBColumn
            Caption = 'Vl. KG acima '#250'ltima faixa'
            DataBinding.FieldName = 'VALPKG'
            Width = 137
          end
          object cxgTransportadoraViewUpdVALPKG_NOVO: TcxGridDBColumn
            Caption = 'Vl. KG acima '#250'ltima faixa (Novo)'
            DataBinding.FieldName = 'VALPKG_NOVO'
            Width = 169
          end
          object cxgTransportadoraViewUpdPESINI: TcxGridDBColumn
            Caption = 'Peso Inicial'
            DataBinding.FieldName = 'PESINI'
            Width = 150
          end
          object cxgTransportadoraViewUpdPESINI_NOVO: TcxGridDBColumn
            Caption = 'Peso Incial (Novo)'
            DataBinding.FieldName = 'PESINI_NOVO'
            Width = 180
          end
          object cxgTransportadoraViewUpdPESFIN: TcxGridDBColumn
            Caption = 'Peso Final'
            DataBinding.FieldName = 'PESFIN'
            Width = 150
          end
          object cxgTransportadoraViewUpdPESFIN_NOVO: TcxGridDBColumn
            Caption = 'Peso Final (Novo)'
            DataBinding.FieldName = 'PESFIN_NOVO'
            Width = 150
          end
          object cxgTransportadoraViewUpdVALFRE: TcxGridDBColumn
            Caption = 'Valor do Frete'
            DataBinding.FieldName = 'VALFRE'
            Width = 192
          end
          object cxgTransportadoraViewUpdVALFRE_NOVO: TcxGridDBColumn
            Caption = 'Valor do Frete (Novo)'
            DataBinding.FieldName = 'VALFRE_NOVO'
            Width = 210
          end
        end
        object cxgTransportadoraLevel1: TcxGridLevel
          GridView = cxgTransportadoraView
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 540
        Width = 1102
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object btnDesmUpdAll: TBitBtnLocked
          Left = 343
          Top = 5
          Width = 170
          Height = 22
          Caption = '[F3]Desmarcar Todos'
          Glyph.Data = {
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
          TabOrder = 2
          OnClick = btnDesmUpdAllClick
        end
        object btnMarcUpdAll: TBitBtnLocked
          Left = 171
          Top = 5
          Width = 170
          Height = 22
          Caption = '[F2]Marcar Todos'
          Glyph.Data = {
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
          TabOrder = 1
          OnClick = btnMarcUpdAllClick
        end
        object btnMarcarUpd: TBitBtnLocked
          Left = 0
          Top = 5
          Width = 170
          Height = 22
          Caption = '[Espa'#231'o]Marcar/Desmarcar'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000030000000E000000150000000C0000
            0002000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000200000012072B199C136940FF051E127A0000
            000C000000010000000000000000000000000000000000000000000000000000
            0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
            063D000000060000000000000000000000000000000000000000000000000000
            0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
            2BCE000000150000000200000000000000000000000000000000000000000000
            00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
            65FF082B1A8A0000000C00000001000000000000000000000000000000000000
            00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
            9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
            00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
            B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
            0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
            AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
            0000000000030000000600000005000000020000000000000002010302121A63
            44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
            0000000000000000000000000000000000000000000000000000000000020105
            03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000010002010B15573DA5509769FF0822184A00000004000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000100000004000000060000000300000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnMarcarUpdClick
        end
      end
    end
    object tbsInclui: TTabSheet
      Caption = 'Frete por Transportadora que ser'#227'o Inclu'#237'dos'
      ImageIndex = 1
      OnShow = tbsIncluiShow
      object cxgTransportadoraInsert: TcxGrid
        Left = 0
        Top = 0
        Width = 1102
        Height = 540
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfStandard
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgTransportadoraIns: TcxGridDBTableView
          OnKeyDown = cxgTransportadoraInsKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgTransportadoraInsCustomDrawCell
          DataController.DataModeController.GridMode = True
          DataController.DataModeController.SyncMode = False
          DataController.DataSource = dtsDadosIns
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir o filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Nenhum registro para ser inclu'#237'do'
          OptionsView.GroupByBox = False
          object cxgTransportadoraInsMARCADO: TcxGridDBColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
          end
          object cxgTransportadoraInsCODTRA: TcxGridDBColumn
            Caption = 'Cod. Transportadora'
            DataBinding.FieldName = 'CODTRA'
            Width = 120
          end
          object cxgTransportadoraInsNOMTRA: TcxGridDBColumn
            Caption = 'Transportadora'
            DataBinding.FieldName = 'NOMTRA'
            Width = 300
          end
          object cxgTransportadoraInsCODCID: TcxGridDBColumn
            Caption = 'Cod. Cidade'
            DataBinding.FieldName = 'CODCID'
            Width = 120
          end
          object cxgTransportadoraInsNOMCID: TcxGridDBColumn
            Caption = 'Cidade'
            DataBinding.FieldName = 'NOMCID'
            Width = 250
          end
          object cxgTransportadoraInsVALPKG: TcxGridDBColumn
            Caption = 'Vl. KG acima '#250'ltima faixa'
            DataBinding.FieldName = 'VALPKG'
            Width = 134
          end
          object cxgTransportadoraInsPESINI: TcxGridDBColumn
            Caption = 'Peso Inicial'
            DataBinding.FieldName = 'PESINI'
            Width = 150
          end
          object cxgTransportadoraInsPESFIN: TcxGridDBColumn
            Caption = 'Peso Final'
            DataBinding.FieldName = 'PESFIN'
            Width = 150
          end
          object cxgTransportadoraInsVALFRE: TcxGridDBColumn
            Caption = 'Valor do Frete'
            DataBinding.FieldName = 'VALFRE'
            Width = 150
          end
        end
        object cxgTransportadoraLlv: TcxGridLevel
          GridView = cxgTransportadoraIns
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 540
        Width = 1102
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object btnDesmarcarIncAll: TBitBtnLocked
          Left = 343
          Top = 5
          Width = 170
          Height = 22
          Caption = '[F3]Desmarcar Todos'
          Glyph.Data = {
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
          TabOrder = 2
          OnClick = btnDesmarcarIncAllClick
        end
        object btnMarcarIncAll: TBitBtnLocked
          Left = 171
          Top = 5
          Width = 170
          Height = 22
          Caption = '[F2]Marcar Todos'
          Glyph.Data = {
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
          TabOrder = 1
          OnClick = btnMarcarIncAllClick
        end
        object btnMarcarInc: TBitBtnLocked
          Left = 0
          Top = 5
          Width = 170
          Height = 22
          Caption = '[Espa'#231'o]Marcar/Desmarcar'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000030000000E000000150000000C0000
            0002000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000200000012072B199C136940FF051E127A0000
            000C000000010000000000000000000000000000000000000000000000000000
            0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
            063D000000060000000000000000000000000000000000000000000000000000
            0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
            2BCE000000150000000200000000000000000000000000000000000000000000
            00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
            65FF082B1A8A0000000C00000001000000000000000000000000000000000000
            00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
            9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
            00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
            B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
            0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
            AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
            0000000000030000000600000005000000020000000000000002010302121A63
            44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
            0000000000000000000000000000000000000000000000000000000000020105
            03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000010002010B15573DA5509769FF0822184A00000004000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000100000004000000060000000300000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnMarcarIncClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 416
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 416
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 416
  end
  object dtsDadosUpd: TDataSource
    Left = 352
    Top = 168
  end
  object dtsDadosIns: TDataSource
    Left = 424
    Top = 168
  end
  object frxRepNaoImp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44075.403156666670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '     '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '                                                                ' +
        '                                             '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 520
    Top = 416
    Datasets = <
      item
        DataSet = frxRelatorio_Cidade
        DataSetName = 'frxRelatorio_Cidade'
      end
      item
        DataSet = frxRelatorio_Transportadora
        DataSetName = 'frxRelatorio_Transportadora'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.456710000000000000
        ParentFont = False
        Top = 215.433210000000000000
        Width = 748.800000012278100000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxRelatorio_Transportadora
        DataSetName = 'frxRelatorio_Transportadora'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
        object Memo47: TfrxMemoView
          ShiftMode = smDontShift
          Top = 1.000000000000000000
          Width = 132.283518270000000000
          Height = 14.897650000000000000
          Visibility = [vsPreview, vsExport]
          AllowExpressions = False
          DataField = 'CODTRA'
          DataSet = frxRelatorio_Transportadora
          DataSetName = 'frxRelatorio_Transportadora'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_Transportadora."CODTRA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 381.732530000000000000
        Width = 748.800000012278100000
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial Unicode MS'
        Font.Style = [fsBold]
        Height = 21.543314410000000000
        ParentFont = False
        Top = 170.078850000000000000
        Width = 748.800000012278100000
        ReprintOnNewPage = True
        object Memo4: TfrxMemoView
          Width = 746.574830000000000000
          Height = 17.007878900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Transportadora')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 88.763760000000000000
        Top = 18.897650000000000000
        Width = 748.800000012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baLeft
          Top = 2.661410000000000000
          Width = 747.544960000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baLeft
          Top = 27.220470000000000000
          Width = 747.544960000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 633.600000012278100000
          Top = 53.677180000000010000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 681.600000012278100000
          Top = 70.677180000000010000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 556.800000012278100000
          Top = 70.677180000000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Line1: TfrxLineView
        Align = baBottom
        Top = 1088.000000013508000000
        Width = 1088.504640000000000000
        Color = clBlack
        Frame.Typ = [ftTop]
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial Unicode MS'
        Font.Style = [fsBold]
        Height = 21.543314410000000000
        ParentFont = False
        Top = 257.008040000000000000
        Width = 748.800000012278100000
        ReprintOnNewPage = True
        object Memo9: TfrxMemoView
          Width = 748.354360000000000000
          Height = 17.007878900000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.456710000000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 748.800000012278100000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        DataSet = frxRelatorio_Cidade
        DataSetName = 'frxRelatorio_Cidade'
        RowCount = 0
        Stretched = True
        object Memo10: TfrxMemoView
          ShiftMode = smDontShift
          Top = 1.464440000000000000
          Width = 132.283518270000000000
          Height = 14.897650000000000000
          Visibility = [vsPreview, vsExport]
          AllowExpressions = False
          DataField = 'CODCID'
          DataSet = frxRelatorio_Cidade
          DataSetName = 'frxRelatorio_Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio_Cidade."CODCID"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxRelatorio_Transportadora: TfrxDBDataset
    Description = 'Dados da Transportadora'
    UserName = 'frxRelatorio_Transportadora'
    CloseDataSource = False
    DataSource = dtsTranspNaoImportadaRelatorio
    BCDToCurrency = False
    Left = 600
    Top = 192
  end
  object cdsTranspNaoImportadaRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 596
    Top = 240
    object cdsTranspNaoImportadaRelatorioCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 5
    end
  end
  object dtsTranspNaoImportadaRelatorio: TDataSource
    DataSet = cdsTranspNaoImportadaRelatorio
    Left = 594
    Top = 288
  end
  object cdsCidadeNaoImportadaRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 772
    Top = 240
    object cdsCidadeNaoImportadaRelatorioCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
  end
  object dtsCidadeNaoImportadaRelatorio: TDataSource
    DataSet = cdsCidadeNaoImportadaRelatorio
    Left = 770
    Top = 288
  end
  object frxRelatorio_Cidade: TfrxDBDataset
    Description = 'Dados da Cidade'
    UserName = 'frxRelatorio_Cidade'
    CloseDataSource = False
    DataSource = dtsCidadeNaoImportadaRelatorio
    BCDToCurrency = False
    Left = 772
    Top = 196
  end
  object cdsDadosIns: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 176
    object cdsDadosInsMARCADO: TIntegerField
      FieldName = 'MARCADO'
    end
    object cdsDadosInsSEQFRE: TStringField
      FieldName = 'SEQFRE'
    end
    object cdsDadosInsCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 10
    end
    object cdsDadosInsNOMTRA: TStringField
      FieldName = 'NOMTRA'
      Size = 80
    end
    object cdsDadosInsCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsDadosInsNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 80
    end
    object cdsDadosInsPESINI: TFloatField
      FieldName = 'PESINI'
    end
    object cdsDadosInsPESFIN: TFloatField
      FieldName = 'PESFIN'
    end
    object cdsDadosInsVALFRE: TFloatField
      FieldName = 'VALFRE'
    end
    object cdsDadosInsVALPKG: TFloatField
      FieldName = 'VALPKG'
    end
  end
  object cdsDadosUpd: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 224
    object cdsDadosUpdMARCADO: TIntegerField
      FieldName = 'MARCADO'
    end
    object cdsDadosUpdSEQFRE: TStringField
      FieldName = 'SEQFRE'
    end
    object cdsDadosUpdCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 10
    end
    object cdsDadosUpdNOMTRA: TStringField
      FieldName = 'NOMTRA'
      Size = 80
    end
    object cdsDadosUpdCODCID: TStringField
      FieldName = 'CODCID'
      Size = 5
    end
    object cdsDadosUpdNOMCID: TStringField
      FieldName = 'NOMCID'
      Size = 80
    end
    object cdsDadosUpdPESINI: TFloatField
      FieldName = 'PESINI'
    end
    object cdsDadosUpdPESFIN: TFloatField
      FieldName = 'PESFIN'
    end
    object cdsDadosUpdVALFRE: TFloatField
      FieldName = 'VALFRE'
    end
    object cdsDadosUpdVALPKG: TFloatField
      FieldName = 'VALPKG'
    end
    object cdsDadosUpdPESINI_NOVO: TFloatField
      FieldName = 'PESINI_NOVO'
    end
    object cdsDadosUpdPESFIN_NOVO: TFloatField
      FieldName = 'PESFIN_NOVO'
    end
    object cdsDadosUpdVALFRE_NOVO: TFloatField
      FieldName = 'VALFRE_NOVO'
    end
    object cdsDadosUpdVALPKG_NOVO: TFloatField
      FieldName = 'VALPKG_NOVO'
    end
  end
end
