inherited frmCadFinalidadeAjuste: TfrmCadFinalidadeAjuste
  Width = 538
  Height = 406
  Caption = 'Finalidade do Ajuste de Estoque'
  OnDestroy = FormDestroy
  ExplicitWidth = 538
  ExplicitHeight = 406
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 336
    Width = 532
    Height = 25
    ExplicitTop = 336
    ExplicitWidth = 532
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 451
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 451
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 21
        Align = alLeft
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 453
      Height = 21
      Align = alRight
      ExplicitLeft = 453
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 361
    Width = 532
    ExplicitTop = 361
    ExplicitWidth = 532
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
    end
  end
  inherited pgcDados: TPageControl
    Left = 2077
    Top = 40
    Width = 147
    Height = 33
    Align = alNone
    ExplicitLeft = 2077
    ExplicitTop = 40
    ExplicitWidth = 147
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 139
      ExplicitHeight = 1
    end
  end
  object pagAbas: TPageControl [3]
    Left = 0
    Top = 0
    Width = 532
    Height = 336
    ActivePage = tbsCadastro
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    object tbsCadastro: TTabSheet
      Caption = 'Cadastro'
      object Label1: TLabel
        Left = 26
        Top = 12
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 14
        Top = 36
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object rdgOperacao: TDBRadioGroup
        Left = 70
        Top = 62
        Width = 185
        Height = 67
        Caption = 'Opera'#231#227'o:'
        DataField = 'FAJ_ENTSAI'
        DataSource = dtsTabela
        Enabled = False
        Items.Strings = (
          'Entrada'
          'Sa'#237'da'
          'Ambas')
        TabOrder = 0
        Values.Strings = (
          'E'
          'S'
          'A')
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 9
        Width = 87
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FAJ_CODIGO'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 68
        Top = 34
        Width = 443
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FAJ_DESCRI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object chkObsAdc: TDBCheckBox
        Left = 304
        Top = 68
        Width = 211
        Height = 17
        Caption = 'Solicitar observa'#231#227'o adicional'
        DataField = 'FAJ_OBSADC'
        DataSource = dtsTabela
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object tbsDireitosAcesso: TTabSheet
      Caption = 'Direitos de acesso'
      Enabled = False
      ImageIndex = 1
      object lblDescricaoDireitoAcesso: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 518
        Height = 45
        Align = alTop
        AutoSize = False
        Caption = 'Direito de acesso'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        StyleElements = []
        ExplicitWidth = 406
      end
      object rdgFiltro: TRadioGroup
        AlignWithMargins = True
        Left = 3
        Top = 53
        Width = 518
        Height = 38
        Margins.Top = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Exibir:'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Operadores'
          'Grupos'
          'Todos')
        TabOrder = 0
        OnClick = rdgFiltroClick
      end
      object cxgTemPermissao: TcxGridCitel
        AlignWithMargins = True
        Left = 3
        Top = 125
        Width = 518
        Height = 135
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgTemPermissaoView: TcxGridDBTableViewCitel
          OnKeyDown = cxgTemPermissaoViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsTemPermissao
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ScrollBars = ssNone
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.OnGetContentStyle = cxgTemPermissaoViewStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgTemPermissaoViewtipo: TcxGridDBColumn
            DataBinding.FieldName = 'tipo'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = imgIcones
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 'OPE'
              end
              item
                ImageIndex = 1
                Value = 'GRU'
              end>
            Properties.ShowDescriptions = False
            Options.Focusing = False
            Width = 32
          end
          object cxgTemPermissaoViewcodigo: TcxGridDBColumn
            DataBinding.FieldName = 'codigo'
            Options.Focusing = False
            Width = 28
          end
          object cxgTemPermissaoViewdescricao: TcxGridDBColumn
            DataBinding.FieldName = 'descricao'
            Options.Focusing = False
            Width = 308
          end
        end
        object cxgTemPermissaoLevel: TcxGridLevel
          GridView = cxgTemPermissaoView
        end
      end
      object pnlBotoesDireito: TPanel
        Left = 0
        Top = 263
        Width = 524
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        DesignSize = (
          524
          41)
        object lblRemoverTodos: TLabel
          Left = 3
          Top = 7
          Width = 73
          Height = 14
          Cursor = crHandPoint
          Caption = 'Remover todos'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblRemoverTodosClick
        end
        object btnVerGrupos: TBitBtnLocked
          AlignWithMargins = True
          Left = 281
          Top = 3
          Width = 76
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Ver Grupos'
          TabOrder = 0
          Visible = False
        end
        object btnAdicionar: TBitBtnLocked
          AlignWithMargins = True
          Left = 363
          Top = 3
          Width = 76
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'A&dicionar'
          TabOrder = 1
          OnClick = btnAdicionarClick
        end
        object btnRemover: TBitBtnLocked
          AlignWithMargins = True
          Left = 445
          Top = 3
          Width = 76
          Height = 25
          Hint = 'Marcar/Desmarcar Todos'
          Anchors = [akTop, akRight]
          Caption = '&Remover'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnRemoverClick
        end
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 94
        Width = 518
        Height = 28
        Margins.Bottom = 0
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        StyleElements = []
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 337
          Height = 28
          Align = alClient
          Caption = 'Operadores e grupos com acesso:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlBottom
          StyleElements = []
          ExplicitWidth = 197
          ExplicitHeight = 15
        end
        object cxGroupBox1: TcxGroupBox
          AlignWithMargins = True
          Left = 340
          Top = 5
          Margins.Top = 5
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alRight
          Ctl3D = True
          PanelStyle.Active = True
          ParentBackground = False
          ParentColor = False
          ParentCtl3D = False
          Style.Color = clWhite
          TabOrder = 0
          Height = 23
          Width = 178
          object Image1: TImage
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 22
            Height = 15
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
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
            ExplicitLeft = 2
            ExplicitTop = 2
            ExplicitHeight = 21
          end
          object edtPesquisar: TEdit
            AlignWithMargins = True
            Left = 31
            Top = 5
            Width = 142
            Height = 16
            Margins.Bottom = 0
            Align = alClient
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
            OnChange = edtPesquisarChange
            OnEnter = edtPesquisarEnter
            OnExit = edtPesquisarExit
            OnKeyDown = edtPesquisarKeyDown
          end
        end
      end
    end
  end
  object dtsTabela: TDataSource
    Left = 345
  end
  object imgIcones: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 12451921
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000020202050404040AF545454DF5A5A5AFF525252FF4949
          49FF383838DF262626AF0D0D0D40000000000000000000000000000000000000
          000017171730696969DF7F7F7FFF949494FF969696FF8C8C8CFF7C7C7CFF6B6B
          6BFF595959FF525252FF3F3F3FFF0000000F0000000000000000000000000000
          00007F7F7FEFA3A3A3FF969696FFB6B6B6FF9D9D9DFF989898FF8B8B8BFF7878
          78FF646464FF5E5E5EFF484848FF000000320000000000000000000000000000
          0000999999FFB5B5B5FFABABABFFBCBCBCFFC4C4C4FF9C9C9CFF959595FF8181
          81FF6D6D6DFF646464FF444444FF000000110000000300000000000000000000
          00009F9F9FFFC8C8C8FFC7C7C7FFADADADFFF9F9F9FFA4A4A4FF989898FF8787
          87FF717171FF6B6B6BFF383838E00000000A0000000600000003000000000000
          0000848484CFC0C0C0FFC9C9C9FFA0A0A0FFFFFFFFFFE0E0E0FF999999FF8787
          87FF747474FF5F5F5FFF1D1D1D80000000000000000000000000000000000000
          000026262640969696FFAFAFAFFF97A1A7FFA8DAFBFFD4E8F9FFACACACFF7575
          75FF5C5C5CFF373737CF04040410000000000000000000000000000000000000
          00000000000019191930607587DF82BBE9FF6FB0E6FF327FC5FF3F70A0FF4141
          41FF1B1B1B800000000000000000000000000000000000000000000000000000
          0000000000000C1C293063B4EEFF6EBEF4FF60B0EBFF73B0E6FF1B6AB9FF0C1B
          2850000000000000000000000000000000000000000000000000000000000000
          000000000000254E708095D3FBFF8DD0FBFF7BC7F9FF63B2EDFF286DACFF0919
          2A50000000000000000000000000000000000000000000000000000000000000
          0000000000004D82ACBFC3E6FCFFB4E0FCFF90D1FBFF72C1F5FF3E87C5FF2B48
          66CF000000000000000000000000000000000000000000000000000000000000
          0000000000007CACD3EFE3F4FEFFC9E9FDFF9AD6FBFF77C5F7FF265B92FF3A5E
          83FF000000000000000000000000000000000000000000000000000000000000
          0000000000004476A6FFC1E5FCFFB2DFFCFF8FD1FBFF67AFE4FF285A8FFF4063
          88FF000000000000000000000000000000000000000000000000000000000000
          000000000000537CA8FF74A8D3FF5B98CDFF4C8FCCFF4B85BFFF5585B8FF3F65
          8CFF000000000000000000000000000000000000000000000000000000000000
          000000000000243C55809FC0E4FF90BAE6FF5A8DC4FF2F5A8AFF5783B4FF3459
          81BF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000C1927402E4F739F39618CBF2D5178BF0F2740800205
          0810000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000100000004000000070000000A0000000B0000000D0000000D0000
          000D0000000C0000000A00000007000000020000000000000000000000000000
          0000000000040E38297E134F37B414593DD212583BDB126441FF105D3DFF0D49
          2FDC0A432AD4063521B804251689000000080000000000000000000000000000
          000000000006278A63FF4EBB98FF3CBB90FF2FB586FF2FBF8DFF2DBD8BFF27AE
          7DFF24A878FF209A6CFF0D5535FF0000000C0000000000000000000000000000
          000000000004267B5BD557C09FFF6CDBBCFF65DAB7FF45CBA0FF39C697FF37C4
          95FF3AC396FF36A47EFF0F5136DA000000090000000000000000010101090101
          010E0101011106120E301D5E45A7349875F868CEB1FF6AD1B4FF4BC59EFF42BD
          95FF237F5EFA114732AA040E0A3801010115010101100101010A194737942266
          4ED1286A54D9548F7AF471A392FF679988F93A8870FC40768EFF386E87FF327B
          63FB679988F770A391FF4D8A74F7205E47DB14523BD30D3627983A9275FD6EC6
          ABFF52B795FF46B08DFF47AF8CFF79B5A1FF487591FF7DA4CDFF588BC1FF315F
          81FF7EBAA6FF47AF8CFF3AA17EFF359875FF379878FF1A6B4EFD2F725CBE5EB5
          9AFF84D4BDFF65CBABFF80CFB5FF86BFADFF567EB0FFBDE0F5FF8BC2EBFF345E
          97FF84BAADFF79CBB1FF55BC9BFF5DB89CFF399173FF195540C1010101091838
          2D6339836BD687D0BBFFAEDDD0FF416992FF5C80B0FFCAE8F6FF94C6E9FF375D
          95FF4A6C8BFFACDACDFF78C7AFFF2D745ED7112E25670101010D000000010101
          01060A0C0C2B44708BF67D96B8FF255696FF4F7CB1FF517CAFFF2C5088FF325D
          98FF1E3F79FF7C95B5FF33617CF60A0B0B2E0101010700000001000000000303
          0308273242707097C3FFA7D2F4FF326BAEFF6C9ED1FF5C8CC1FF76A5D3FF5385
          BEFF214784FFA5CEF0FF4676B0FF1822336E0303030A00000000000000000404
          040C354F75C994B8D8FFB4DAF7FF79A2CEFF427BB8F63878BAF13174BBFC3C6D
          A6F885A2C3FFB6DAF6FF5C8FC5FF223A60C20505051100000000000000000404
          040D28528BFA85A7CAFF5D88B5FF7291B8FF6A83A8FC6262636F606060697890
          B5FCA7BFD7FF618BB7FF3A679EFF1F467CFB0606071600000000000000000202
          02072B5996F54778B2FE6197D0FF4E87C6FF275490FF06080B1A020202072B59
          96F54778B2FE6197D0FF4E87C6FF275490FF06080B1A00000000000000000101
          010213263E612C5A93D6326AABF729578DD81529447301010103010101021326
          3E612C5A93D6326AABF729578DD8152944730101010300000000000000000000
          0000000000000000000100000001000000010000000100000000000000000000
          0000000000010000000100000001000000010000000000000000}
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
      TextColor = clWindowText
    end
  end
  object cdsTemPermissao: TUniClientDataSet
    PersistDataPacket.Data = {
      6C0000009619E0BD0100000018000000030000000000030000006C0004746970
      6F010049000000010005574944544802000200030006636F6469676F01004900
      000001000557494454480200020003000964657363726963616F010049000000
      01000557494454480200020064000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'tipo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'codigo'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    IndexFieldNames = 'descricao'
    Params = <>
    StoreDefs = True
    Left = 84
    Top = 233
    object cdsTemPermissaotipo: TStringField
      FieldName = 'tipo'
      Size = 3
    end
    object cdsTemPermissaocodigo: TStringField
      FieldName = 'codigo'
      Size = 3
    end
    object cdsTemPermissaodescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
  end
  object dtsTemPermissao: TDataSource
    DataSet = cdsTemPermissao
    Left = 145
    Top = 230
  end
  object tmrPesquisar: TTimer
    Interval = 200
    Left = 81
    Top = 118
  end
  object tmrSomenteSelecionar: TTimer
    Enabled = False
    Interval = 100
    Left = 80
    Top = 88
  end
end
