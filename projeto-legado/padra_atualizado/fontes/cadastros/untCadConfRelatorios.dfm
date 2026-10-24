inherited frmCadConfRelatorios: TfrmCadConfRelatorios
  Left = 230
  Top = 226
  Width = 900
  Height = 384
  Caption = 'Impress'#227'o - Filas'
  ExplicitWidth = 900
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 14
  object lblInfCodOpe: TLabel [0]
    AlignWithMargins = True
    Left = 10
    Top = 280
    Width = 874
    Height = 28
    Margins.Left = 10
    Margins.Right = 10
    Align = alBottom
    Caption = 
      '** Ao informar o c'#243'digo do operador ou nome da m'#225'quina a fila de' +
      ' impress'#227'o ser'#225' utilizada somente por esse usu'#225'rio ou m'#225'quina, d' +
      'eixar ambos em branco para utilizar a fila para todos os usu'#225'rio' +
      's/m'#225'quinas.'
    WordWrap = True
    ExplicitLeft = 0
    ExplicitTop = 294
    ExplicitWidth = 891
  end
  inherited pnlBotoes: TPanel
    Top = 308
    Width = 894
    Height = 31
    TabOrder = 1
    ExplicitTop = 308
    ExplicitWidth = 894
    ExplicitHeight = 31
    inherited FlwBotoes: TFlowPanel
      Width = 809
      Height = 27
      ExplicitWidth = 809
      ExplicitHeight = 27
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        Align = alLeft
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Width = 77
        Height = 22
        Align = alLeft
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 221
        Height = 22
        Align = alLeft
        ExplicitLeft = 221
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 293
        Height = 22
        Align = alLeft
        ExplicitLeft = 293
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 76
        Height = 22
        Align = alLeft
        ExplicitLeft = 365
        ExplicitWidth = 76
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      AlignWithMargins = True
      Left = 813
      Top = 3
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alRight
      ExplicitLeft = 813
      ExplicitTop = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 339
    Width = 894
    TabOrder = 3
    ExplicitTop = 339
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 642
      Width = 252
      ExplicitLeft = 642
      ExplicitWidth = 252
    end
    inherited pnlInfo: TPanel
      Width = 642
      ExplicitWidth = 642
    end
  end
  inherited pgcDados: TPageControl
    Left = 8
    Top = 5000
    Width = 908
    Height = 0
    Align = alNone
    Visible = False
    ExplicitLeft = 8
    ExplicitTop = 5000
    ExplicitWidth = 908
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 900
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 894
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object gpbTipo: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 884
      Height = 47
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label1: TLabel
        Left = 53
        Top = 19
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Programa:'
      end
      object dbeNomPro: TDBEditFocus
        Tag = 99
        Left = 106
        Top = 15
        Width = 608
        Height = 22
        DataField = 'REL_NOMPRO'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object cxDados: TcxGrid [5]
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 888
    Height = 231
    Align = alClient
    TabOrder = 4
    object cxDadosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Cancel.Enabled = False
      OnEditKeyDown = cxDadosDBTableView1EditKeyDown
      OnEditKeyPress = cxDadosDBTableView1EditKeyPress
      DataController.DataSource = dtsTabela
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' filas cadastradas para esse programa>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      OptionsView.IndicatorWidth = 20
      object colDescri: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'REL_DESPRO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        SortIndex = 0
        SortOrder = soAscending
        Width = 226
      end
      object colCodOpe: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'REL_CODOPE'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        HeaderGlyph.SourceDPI = 96
        HeaderGlyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C00000012744558745469746C6500557365723B506572736F6E3B
          4CB622650000026449444154785E85916D48D3511487EF5C2E35D34CB79A6654
          2E370D1209C9D536C7B0A52B05C5123228915EA9C8A5CECD49830A2375BA5A66
          A512F68A9845EB15C294FF3E2C091262125A1806852F35A84F95F96B67C61019
          EEC2EF7238E7390F172E03C08C8A485F4C594BD9A98D3C66DE1ABBFFA67E477F
          8F65F778C7814C47D986B0D52CC001307B59B745F952A71430A33CAAE0CD6D13
          C6FB2C18EB3908AE4107BD3C7A345D2828E4F3788105CA55025F36C731FEADCA
          FC0F630E3D2EE73054A4309CC95B8396D20C346E0985343A2427A060CE09BF67
          CAFBDB7D62130C59F1A8DFA7C4C75E1BBE3A2FA22633069230D61C4CC04CCAE5
          EFBA2DA5F8F9D9097C7984DFC39DF833D482CEE36A8818B30515C84258F12B7B
          3580617C735931C99D87A7CF88C692B4E930C632820A28C7B469BDBF461E63DA
          6DC70FAE1683578AA093443EF003C104A270BEA6ADBC00DCD5C3709CCE46B526
          81A0BC50EFB588C75B58B05E1C5F5C61AC19BAA6D7E28925170D8589D89B2E44
          49D921B75622295AF00547D7ADEDBAB35D8BC1F72378CD3D4553D52E98F728D0
          66ABC34BA70B77F377E28897092850AA54156E9B152E9512ED66335C131E98CF
          5971B6DE8E81490F5A0D557065A9400CB1F30582FBCF9E4F0C5C6F457FAA0CD6
          E464A8E5727C9A9AC2A8371A8502CD3219CD400CB1B4E31788C5E2DCEF00DEDE
          E84057FC4ABC484A829DCF8741ADA6504D3D9A11036269C72FC8D5E9EC00C035
          5CC0C3986570A6A6A05F2A457BC4120AD5D4A31931A0433B7E414262A2BAE992
          7DB2365B83CA88C533A615C299F2B8589CFC1FAAA947336288A59DF9BF20F246
          4A3F3927D2C03D626777FF013A059A3A29FA26A10000000049454E44AE426082}
        Width = 74
      end
      object colNomMaq: TcxGridDBColumn
        Caption = 'Nome da M'#225'quina'
        DataBinding.FieldName = 'REL_NOMMAQ'
        PropertiesClassName = 'TcxComboBoxProperties'
        HeaderGlyph.SourceDPI = 96
        HeaderGlyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000B1300000B1301009A9C180000013A49444154388D
          63088E4A6A894ECC7E189B9AFF98140CD2131295D2C40062CC5D7FE47FEBBAF3
          2461909E98C49C070C20D340029EABDE21F0FCBBFF3D3AB6C1F91E9D3BC062C8
          6A407A407A310D002A744FAD05D2B7F18AE134C03DBEE4BFE7BCDBA82E0261A0
          987B4209112EE8DEF3DF23AFE7BFE78AD74806BCFDEF51D00FF4CA4E220C8019
          52B71C11062036508CB830201283F4246795DEA5C880C5EB0FAC6248CD2EBABD
          7CDB912BF105759F48C19945D5EF82C2E33F301496563FFEF8E9D37F7230482F
          434A46FEED672F5E90ACF9D9F317FF9333F26F31F804461B25A464EF8C4FC93A
          06C37EA1311F320BCADF20E3E4CCFCCBC86A407AFC82230C19B081E0E8E4634B
          361CF88F8CD3F32AA661558C0E7C03633C22E3339FA21B109990F9042447D080
          90A8A4053189B94FD1B32F482C3832793EBA7A0075F869253C36C89600000000
          49454E44AE426082}
        Width = 112
      end
      object colNomFil: TcxGridDBColumn
        Caption = 'Fila'
        DataBinding.FieldName = 'REL_NOMFIL'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Selecionar Fila (Ctrl+Enter)'
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              00020000000A0000000F000000110000001100000011000000100000000B0000
              00030000000000000000000000000000000000000000000000090000000E0000
              00168A6559C3BF8D7BFFBF8D7BFFC08D7BFFBF8D7BFFC08D7BFF8A6558C50000
              0019000000100000000A0000000200000000000000007B5143C0A76E5BFFA068
              55FFC2917FFFF7F0ECFFF7EFECFFF7F0EBFFF6EFEBFFF6EFEAFFC2917FFF8757
              46FF8B5948FF623F33C20000000A0000000000000000BB7E6BFFECD9CCFFE3CE
              BEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFF8F1EDFFC49583FFE2CC
              BCFFE6D1C1FFB67764FF0000000E0000000000000000BE8571FFF1E5DAFFEBDA
              CFFF794734FF794734FF784734FF784734FF784734FF784734FF784734FFECDA
              CEFFEBDBCFFFBA7C69FF0000000D0000000000000000C28B78FFF5EEE7FFF2E7
              DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7DDFFF2E7DEFFF2E7
              DDFFF2E5DEFFBD836FFF0000000C0000000000000000C7937FFFFAF4F1FFCDBE
              B9FF72564AFF624338FF614036FF604035FF5F3F34FF5E3E33FF414C3AFF315F
              45FF0D482AFF2F5538FF0621137A0001000300000000CC9986FFFDFAFAFF8062
              56FF745043FF744F43FF744E43FF734E42FF6F4D41FF265034FF13764BFF1AAC
              73FF52E1BAFF19AD73FF13764BFF0C4026C901030209BB9080E9F5EBE6FF7D5C
              4DFF946E5EFFFAF6F3FFF0E6E0FFF0E5DFFF7D9D88FF218058FF28CD90FF27CD
              8FFF035A2AFF28CD90FF27CD8FFF22835AFF092F1C8434292444A68172CC8868
              57FF9B7565FFFBF8F6FFF2E8E3FFF1E8E1FF317654FF30C18DFF32D49BFF33D4
              9BFF57C4A0FF42D9A6FF33D49BFF31C18DFF115837DE00000001000000030000
              000CC59685FFFCFAF9FFF3EBE6FFF4EAE5FF1C744CFF55DDB0FF3EDAA6FF3EDA
              A6FF02451DFF60C4A4FF3EDAA6FF56DDB1FF166E46F900000000000000000000
              0008C89B89FFFDFCFBFFF5EDE8FFF4EDE8FF368B64FF8EDEC4FF4BE1B2FF79EC
              CBFF89F0D4FF013C18FF4BE1B2FF8BDDC3FF176B47DE00000000000000000000
              0006CA9E8DFFFEFDFDFFFEFDFCFFFEFCFCFF91C4ADFF51A986FFACF5E0FF1D63
              41FF013413FF267250FFACF5E0FF57AE8BFF0E412B7B00000000000000000000
              000498786BC1CDA291FFCCA18FFFCCA090FFCAA08EFF49946CFF50AF89FFA7E2
              CFFFCAF8ECFFA7E2CFFF50AE89FF176C49C00002010300000000000000000000
              00010000000300000005000000050000000600000006000201090F432D741A78
              52CC219465FC1A7852CC0F432E72000201030000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000}
            Hint = 'Selecionar Fila (Ctrl+Enter)'
            Kind = bkGlyph
          end>
        Properties.ClearKey = 46
        Properties.ReadOnly = False
        Properties.OnButtonClick = colNomFilPropertiesButtonClick
        HeaderGlyph.SourceDPI = 96
        HeaderGlyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000E744558745469746C65005072696E7465723BE7BF61C5
          0000026749444154785E7D93CB6B135114C6BF99C434A60F05698B1B57167525
          82E84AAD2822B688B8101F50B45441210BEBC285150591A250A326462AA218F2
          0FB810178A482CAD165AD0958216051F68D1966426F3B82FCFDCCC0C71512F7C
          73EE3DDCEF77EEDC87A19442D40C6AB74A332F4CD3EC05745E7FA33982F1CAF0
          E0D65D34E69127897F9B49EA3D7374A376AA901041F2E5D9ED0012A4A5019C0B
          28092C5A5E58D9808244476B0B38135111C4005AB55E7D587D191712928C1475
          790523089082725C03D2E4610064A0C0648E8E5776DF2EBF7D33385CB0BF7C7E
          0F2915494288C028C0833E69EEE33B1C3E35FA67ECE1CCF4C5DCD33D0012C9E0
          B33CD3513EB4776DD744E54930D4D5852008240CD55807A3B1EB3AB0EC1A8EF4
          ADDF547A2C4B00D66880E0AAAB7B550675CB42329186904A5754A11900012501
          5C38561DAB3B33604C75462B303D5F5042229D4AE0E78FEF3878EC4274046150
          210C686F4BE8B99EC7D00460700832347000378B252C2C542145E0931AA1A4D2
          3BBC72453B4E0F1D87C3380138026F03E032D409D2B3A107C5FC95C6A1C8F008
          4D8A8D0C744602B6CB41459B003E47CDE1A8D7194E666FE07FED5EFE2C7C9102
          F385E60600C3F704AA1643D576B0BFBF0FD981CD284CCDEBCD6402641038BFA3
          1BC5F22C7E2FDAA03F81CF1A0013009BFFF5753277E719EE8E3F070FCFDD6324
          4E002E29070DE3D4B976BD8C91CB0FF0E9C3E46B10C708EF762BA985D43632F6
          722E7B628BDE794087F846161E4DE3EAB99DEB0054490EC94E2AA54490085FA3
          655BD6ABDCFDA96DF1B6A9F8ADC2756B1300BE91C75EEA31F9B94BFDFB00A448
          66EC44FCB23D92DB6CF80BF54A6944F3A08E160000000049454E44AE426082}
        HeaderHint = 'Selecionar Fila (Ctrl+Enter)'
        Width = 203
      end
      object colImpPad: TcxGridDBColumn
        Caption = 'Padr'#227'o do Windows'
        DataBinding.FieldName = 'REL_IMPPAD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = colImpPadPropertiesChange
        Width = 113
      end
      object colTipImp: TcxGridDBColumn
        Caption = 'Tipo de Impress'#227'o'
        DataBinding.FieldName = 'REL_IDEIMP'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.CharCase = ecUpperCase
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CODTIP'
        Properties.ListColumns = <
          item
            Caption = 'Selecione Uma Op'#231#227'o'
            FieldName = 'DESCRI'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dtsTipImp
        Width = 138
      end
      object colPergun: TcxGridDBColumn
        Caption = 'Pergunta Tipo'
        DataBinding.FieldName = 'REL_PERGUN'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.CharCase = ecUpperCase
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Sim'
          'N'#227'o')
        Properties.ReadOnly = False
        Visible = False
        Width = 79
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 864
    Top = 320
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 736
    Top = 320
  end
  object dtsTabela: TDataSource
    Left = 824
    Top = 320
  end
  object dtsTipImp: TDataSource
    DataSet = qryTipImp
    Left = 733
    Top = 5
  end
  object qryTipImp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 781
    Top = 5
    object qryTipImpCODTIP: TStringField
      FieldName = 'CODTIP'
      Size = 1
    end
    object qryTipImpDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
  end
end
