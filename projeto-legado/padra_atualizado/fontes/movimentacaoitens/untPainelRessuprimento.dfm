inherited frmPainelRessuprimento: TfrmPainelRessuprimento
  Width = 877
  Height = 467
  Align = alClient
  Caption = 'Painel de ressuprimento'
  OnDestroy = FormDestroy
  ExplicitWidth = 877
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 396
    Width = 871
    ExplicitTop = 396
    ExplicitWidth = 871
    inherited FlwBotoes: TFlowPanel
      Width = 867
      ExplicitWidth = 867
      inherited btnConfirma: TBitBtnLocked
        Width = 150
        Caption = '[F10] Ativar selecionados'
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
        ModalResult = 0
        NumGlyphs = 1
        ExplicitWidth = 150
      end
      object btnDesativarSelecionados: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 177
        Height = 22
        Caption = '[F9] Desativar selecionados'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000001000000030000
          0007000000060000000300000006000000080000000400000001000000000000
          00000000000000000000000000000000000000000000000000030B082C4D2619
          99EA110A58A2010003160F0855A3160C7EEA0603244F00000004000000000000
          0001000000060000000A0000000B0000000B0000000B000000112E23A2EA6F85
          EAFF4150CBFF1F1689E63B48C9FF5C74E4FF180E82E700000007000000000000
          000680574CBDB37B69FFB37A68FFB37A68FFB27968FFDCC6BEFF756BC0FF7780
          DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F00000005000000000000
          0008B57D6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFAF5F3FFEFECEFFF4D46
          BDFF6A85EBFF7494F2FF6079E7FF262094E40101041300000002000000000000
          0008B67F6DFFFCF8F5FFF8EFECFFF7EEEAFFF7EEEAFFF9F5F3FF807DD4FF6B7E
          E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA000000004000000000000
          0008B8826FFFFCF9F6FFCDA493FFCCA393FFCCA393FFEEE3DFFF615ED6FFB1C3
          F6FF8D99EAFF5F5DD2FF8995E7FFA6B8F3FF3B35AEE300000004000000000000
          0007BA8473FFFDF9F8FFF8F1EEFFF8F0EDFFF8F0ECFFFAF5F3FFCECDEEFF6564
          DEFF9291E2FFF2F1F3FF8982D3FF4340BCE71212334600000002000000000000
          0007BB8776FFFDFBF9FFCEA898FFCEA796FFCEA695FFCDA695FFE1CAC0FFEFE5
          E1FFE7D6D0FFFCF9F8FFE3CFC9FF0000000C0000000200000000000000000000
          0006BD8A78FFFDFBFAFFF9F2F0FFF9F2F0FFF8F2EFFFF9F1EFFFF8F1EEFFF9F1
          EEFFF8F0EDFFFDFAF8FFBB8675FF000000080000000000000000000000000000
          0006BF8D7BFFFEFCFBFFD1AE9DFFD0AC9CFFD0AB9BFFCFAA99FFCEA999FFCEA8
          97FFC69C8AFFFDFBF9FFBD8978FF000000080000000000000000000000000000
          0005C39381FFFEFDFDFFFBF6F4FFFBF5F4FFFBF4F2FFFAF4F2FFFAF4F1FFF9F3
          F1FFFAF3F1FFFEFCFBFFC18F7EFF000000070000000000000000000000000000
          0004C69887FFFFFEFEFFD5B2A3FFD4B2A2FFD4B1A0FFD3AF9FFFD2AD9DFFD1AD
          9CFFC9A090FFFEFDFDFFC59684FF000000060000000000000000000000000000
          0003C99B8AFFFFFEFEFFFBF7F6FFFCF7F6FFFCF6F5FFFBF6F5FFFCF6F5FFFBF5
          F5FFFBF6F4FFFFFEFEFFC79887FF000000050000000000000000000000000000
          0003CA9E8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000000000
          00029B7F74BFD0AB9CFFD0AB9CFFD0AA9CFFCFA99BFFCFA99AFFCFA999FFCFA8
          99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
        TabOrder = 4
        OnClick = btnDesativarSelecionadosClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 327
        Top = 0
        Width = 145
        Height = 22
        Caption = '[SPACE] Marcar/Desmarca'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 472
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F2] Marcar todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000A0000000F0000001000000010000000100000001000000011000000110000
          0011000000110000001100000011000000100000000A0000000200000009845E
          4FC1B6836EFFB7826DFFB5816DFFB5806CFFB5806CFFB4806CFFB47E6BFFB47E
          6AFFB37D69FFB37D68FFB27D69FFB27C68FF80584AC20000000A0000000EBC8B
          76FFF8F2EDFFF6EFEBFFF6EEEAFFF6EFEAFFF6EFEAFFF6EEE9FFF6EEE9FFF5EE
          E9FFF6EDE8FFF5EEE8FFF5EDE8FFF6EFEBFFBB8774FF0000000E0000000EBE8D
          79FFF8F3EFFFF5EEE9FFF6EEE9FFF5EEEBFFF4F0ECFFEBE8E5FFEEE9E8FFF5EF
          EAFFF5ECE7FFF4ECE6FFF4EBE6FFF6F0ECFFBD8A76FF0000000F0000000DC08F
          7CFFFAF3F1FFF7EFEAFFF6F0EBFFF2EEECFFCEBDB2FFA36442FFB08C7AFFEBE8
          E5FFF5EEE9FFF5EDE7FFF5ECE7FFF7F1EDFFBD8B78FF0000000E0000000CC291
          7EFFFAF5F3FFF8F1EDFFF5F1EFFFD3C2B8FFB57E59FFE2BD8BFFAB724DFFC7B5
          ABFFF1EDEBFFF5EEE9FFF5EEE9FFF8F3EDFFBF8E7BFF0000000D0000000CC395
          81FFFBF8F4FFF6F3F1FFD9C8BFFFB9845EFFE4C18FFFE6C393FFDCB687FFA36D
          4FFFDDD6D2FFF6F0EDFFF6EFEAFFF9F3EFFFC0907DFF0000000D0000000BC597
          85FFFAF7F5FFE1D1C7FFBE8D6AFFEACCA5FFF1DEBFFFF5E4CAFFEBCCA1FFCEA2
          76FFAB7F6AFFE8E6E3FFF6F2EEFFF9F3F1FFC29380FF0000000C0000000AC69A
          88FFFBF9F7FFDBC5B8FFC99F81FFE4CCB4FFCAA082FFB98463FFEAD5BBFFEBCE
          A4FFC4936BFFB89786FFEEEAE8FFF8F3F0FFC39683FF0000000B0000000AC89D
          8BFFFCFAF8FFFAF7F6FFD9C3B4FFC1957BFFD4BDAFFFDED3CDFFBC8E71FFEBD7
          BEFFEED3ADFFBB8661FFC4AEA2FFF0ECE9FFC49885FF0000000A00000009CAA0
          8EFFFBFAF8FFFCF9F6FFFAF7F6FFF8F5F3FFF9F6F4FFF8F6F4FFE8DFDAFFBC8E
          71FFE5CDB5FFF1DEBDFFBA8562FFE9E6E3FFC59A88FF0000000A00000008CCA3
          91FFFCFBFAFFFCF8F5FFFCF8F5FFFBF7F4FFFBF7F4FFFAF6F5FFFAF7F6FFEBE5
          E1FFC0967BFFC5987AFFD1C3BAFFF1EFECFFC99E8CFF0000000900000007CDA5
          93FFFDFBFAFFFCF9F7FFFCF9F7FFFCF8F6FFFBF9F5FFFBF8F5FFFBF8F5FFFAF8
          F6FFF4F2F1FFEEECEBFFF4F2F0FFFAF7F6FFCBA18FFF0000000800000006CEA7
          96FFFDFBFAFFFEFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFB
          F9FFFCFBFBFFFAF9F8FFFBFAF8FFFCFAF8FFCCA391FF00000007000000049A7E
          71C1CFA998FFCFA898FFCFA997FFCFA997FFCFA897FFCEA796FFCFA796FFCFA8
          96FFCFA796FFCEA696FFCEA794FFCEA694FF987B6FC100000005000000010000
          0004000000050000000600000006000000060000000600000006000000060000
          0006000000060000000600000006000000060000000400000001}
        TabOrder = 2
        OnClick = btnMarTodosClick
      end
      object btnDesmarTodos: TBitBtnLocked
        Left = 606
        Top = 0
        Width = 134
        Height = 22
        Caption = '[F3] Desmarcar todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000002000000090000000B000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000020000000E542F18A08A491EDD000000000000
          0000000000000000000000000000000000010000000500000008000000030000
          000000000000000000030000000E553019A0C79A6AFF975125EC000000000000
          0000000000000000000000000002000000092D180B63A06136EC0000000A0000
          0004000000091009052C683C1FBAC69561FFDFC295FF7D4824C8000000000000
          000000000001000000040F09042762371BB7B07A4AFFB27243FF140C07362D1B
          0F5B5C371EA69D643BF9D2A66FFFEECD94FFCCA37AFF472B177B000000000000
          0002000000073922126B996239F3D7AE77FFF3D597FFB57A4CFFA66D42FFB47F
          51FFCEA26EFFEECC90FFEFCD92FFEEDEB6FFA36C43E90805031A00000002150E
          0829764B2CBFC19262FFF2D49AFFF5DA9FFFF6DA9DFFF4D79DFFF4D79CFFF4D6
          9AFFF3D59AFFF3D89FFFF5ECC5FFCAA177FF3825175E0000000500000003B185
          5DEBEADDBCFFFBF7D4FFFCF3CCFFFCF3CEFFFCF2CAFFFAECC0FFF8E6B6FFF6E3
          B2FFF6ECC3FFF1EBCAFFCDA981FF5139257D0000000800000001000000011C16
          0F2A947251C4DABE99FFFAF7D8FFFDFAD9FFFDF7D4FFFDFDE1FFF5EFD0FFEADB
          BAFFD6B892FFAE825CE83D2D1F5E000000070000000100000000000000000000
          0001000000054D3D2C6AC19D78F2ECDFBDFFFEFDDFFFB48359FFAB845EE18A6A
          4CBB4E3C2A700705041300000004000000010000000000000000000000000000
          0000000000000000000315110D21896E51B3DABF9AFFBC8D64FF0000000B0000
          0005000000030000000100000000000000000000000000000000000000000000
          0000000000000000000000000001000000044336285BB08865E80706040E0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000200000003000000010000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnDesmarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 788
      ExplicitLeft = 788
    end
  end
  inherited pnlStatus: TPanel
    Top = 422
    Width = 871
    ExplicitTop = 422
    ExplicitWidth = 871
    inherited pnlNomeForm: TPanel
      Left = 700
      ExplicitLeft = 700
    end
    inherited pnlInfo: TPanel
      Width = 700
      ExplicitWidth = 700
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 871
    Height = 368
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableView
      OnDblClick = cxgItensViewDblClick
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      OnFocusedRecordChanged = cxgItensViewFocusedRecordChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          Caption = 'Dados do item'
          Styles.Header = styDadosItem
          Width = 302
        end
        item
          Caption = 'Localiza'#231#227'o f'#237'sica de origem'
          Styles.Header = styLocOri
          Width = 501
        end
        item
          Caption = 'Localiza'#231#227'o f'#237'sica de destino'
          Styles.Header = styLocDes
          Width = 1000
        end>
      object cxgItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Styles.Content = styDadosItem
        Width = 47
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Styles.Content = styDadosItem
        Width = 103
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensLOCORI: TcxGridDBBandedColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'ITE_LOCORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Options.Editing = False
        Styles.Content = styLocOri
        Width = 74
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensITE_LOCDES: TcxGridDBBandedColumn
        Caption = 'Loc. F'#236'sica'
        DataBinding.FieldName = 'ITE_LOCDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 154
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensLARG_: TcxGridDBBandedColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'ITE_LARG_'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 60
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensCODUNI: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ITE_CODUNI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styDadosItem
        Width = 50
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewQTDTRF: TcxGridDBBandedColumn
        Caption = 'Qtd. a transferir'
        DataBinding.FieldName = 'ITE_QTDTRF'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styQtdTransf
        Width = 76
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensViewMETCUB: TcxGridDBBandedColumn
        Caption = 'Capacidade (M'#179' )'
        DataBinding.FieldName = 'ITE_METCUB'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocOri
        Width = 47
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewALTU_: TcxGridDBBandedColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'ITE_ALTU_'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 61
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensViewPROF_: TcxGridDBBandedColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'ITE_PROF_'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 88
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewCUBDES: TcxGridDBBandedColumn
        Caption = 'Capacidade (M'#179' )'
        DataBinding.FieldName = 'ITE_CUBDES'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 81
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensViewPRDDIF: TcxGridDBBandedColumn
        Caption = 'Aceita Prd. diferente?'
        DataBinding.FieldName = 'ITE_PRDDIF'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 91
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensViewTXAOCU: TcxGridDBBandedColumn
        Caption = 'Taxa de ocup.'
        DataBinding.FieldName = 'ITE_TXAOCU'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensViewEXCESS: TcxGridDBBandedColumn
        Caption = 'Excesso?'
        DataBinding.FieldName = 'ITE_EXCESS'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 62
        Position.BandIndex = 2
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensViewLOCSAL: TcxGridDBBandedColumn
        Caption = 'Em estoque deste prod.'
        DataBinding.FieldName = 'ITE_LOCSAL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 78
        Position.BandIndex = 2
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensViewCUBATU: TcxGridDBBandedColumn
        Caption = 'Em estoque deste prod. (M'#179')'
        DataBinding.FieldName = 'ITE_CUBATU'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.Content = styLocDes
        Width = 92
        Position.BandIndex = 2
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensViewSELECIONADO: TcxGridDBBandedColumn
        Caption = 'Selecionado?'
        DataBinding.FieldName = 'SELECIONADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Visible = False
        Width = 74
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensViewSALOPD: TcxGridDBBandedColumn
        Caption = 'Em estoque outros prod.'
        DataBinding.FieldName = 'ITE_SALOPD'
        Styles.Content = styLocDes
        Width = 73
        Position.BandIndex = 2
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensViewCUBOPD: TcxGridDBBandedColumn
        Caption = 'Em estoque outros prod. (M'#179')'
        DataBinding.FieldName = 'ITE_CUBOPD'
        Styles.Content = styLocDes
        Width = 96
        Position.BandIndex = 2
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlLegenda: TPanel [3]
    Left = 0
    Top = 368
    Width = 871
    Height = 28
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = 8026746
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    object lblLegendaShift: TLabel
      Left = 0
      Top = 15
      Width = 871
      Height = 13
      Align = alBottom
      Caption = '  Pressione a tecla SHIFT para selecionar um ou mais registros'
      ExplicitWidth = 350
    end
    object prgProgresso: TProgressBar
      Left = 0
      Top = 0
      Width = 871
      Height = 16
      Align = alTop
      Smooth = True
      TabOrder = 0
      Visible = False
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 96
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 184
    Top = 216
    PixelsPerInch = 96
    object styLocOri: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16763025
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styLocDes: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 8563455
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styDadosItem: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object styQtdTransf: TcxStyle
      AssignedValues = [svColor]
      Color = 8454143
    end
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 488
    Top = 152
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensLOTORI: TStringField
      FieldName = 'LOTORI'
    end
    object cdsItensLOTDES: TStringField
      FieldName = 'LOTDES'
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsItensSALORI: TFloatField
      FieldName = 'SALORI'
    end
    object cdsItensSALDES: TFloatField
      FieldName = 'SALDES'
    end
    object cdsItensMAXORI: TFloatField
      FieldName = 'MAXORI'
    end
    object cdsItensMAXDES: TFloatField
      FieldName = 'MAXDES'
    end
    object cdsItensREPORI: TFloatField
      FieldName = 'REPORI'
    end
    object cdsItensREPDES: TFloatField
      FieldName = 'REPDES'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensLOCORI: TStringField
      FieldName = 'LOCORI'
    end
    object cdsItensLOCDES: TStringField
      FieldName = 'LOCDES'
    end
    object cdsItensDESLFO: TStringField
      FieldName = 'DESLFO'
      Size = 50
    end
    object cdsItensDESLFD: TStringField
      FieldName = 'DESLFD'
      Size = 50
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensDTAVAL: TDateField
      FieldName = 'DTAVAL'
    end
    object cdsItensSALORIRES: TFloatField
      FieldName = 'SALORIRES'
    end
    object cdsItensSALORIDIS: TFloatField
      FieldName = 'SALORIDIS'
    end
    object cdsItensSALDESRES: TFloatField
      FieldName = 'SALDESRES'
    end
    object cdsItensSALDESDIS: TFloatField
      FieldName = 'SALDESDIS'
    end
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensORIPIC: TStringField
      FieldName = 'ORIPIC'
      Size = 1
    end
    object cdsItensDESPIC: TStringField
      FieldName = 'DESPIC'
      Size = 1
    end
    object cdsItensQTDDIF: TFloatField
      FieldName = 'QTDDIF'
    end
    object cdsItensOPEDES: TStringField
      FieldName = 'OPEDES'
      Size = 3
    end
    object cdsItensNOMOPEDES: TStringField
      FieldName = 'NOMOPEDES'
      Size = 60
    end
  end
  object dtsTransf: TDataSource
    DataSet = cdsItens
    Left = 552
    Top = 152
  end
  object dtsItensClasse: TDataSource
    DataSet = cdsItens
    Left = 496
    Top = 216
  end
end
