inherited frmVisualizarMapaGoogle: TfrmVisualizarMapaGoogle
  Width = 1102
  Height = 771
  Caption = 'Visualizador de Mapas'
  Color = clWhite
  Ctl3D = False
  OnResize = FormResize
  ExplicitWidth = 1102
  ExplicitHeight = 771
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 722
    Width = 1096
    Height = 0
    Visible = False
    ExplicitTop = 722
    ExplicitWidth = 1096
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 1092
      Visible = False
      ExplicitWidth = 1092
    end
    inherited btnSair: TBitBtnLocked
      Left = 839
      Top = -25
      ExplicitLeft = 839
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 722
    Width = 1096
    Height = 0
    Visible = False
    ExplicitTop = 722
    ExplicitWidth = 1096
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 925
      Height = 0
      Visible = False
      StyleElements = []
      ExplicitLeft = 925
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 925
      Height = 0
      Visible = False
      StyleElements = []
      ExplicitWidth = 925
      ExplicitHeight = 0
    end
    inherited pnlBotoesTrace: TPanel
      Height = 0
      ExplicitHeight = 0
      inherited btnIniciarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1096
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    StyleElements = []
    DesignSize = (
      1096
      100)
    object lblTitulo: TLabel
      Left = 0
      Top = 0
      Width = 1096
      Height = 100
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Mapa de Entregas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = []
      ExplicitWidth = 919
    end
    object lblCarregando: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 70
      Width = 1090
      Height = 30
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Aguarde - Carregando rota efetuada...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = []
      ExplicitTop = 60
      ExplicitWidth = 913
    end
    object imgVoltar: TImage
      Left = 30
      Top = 40
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Hint = 'Voltar'
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000018
        000000180806000000E0773DF80000000473424954080808087C086488000000
        097048597300000EC400000EC401952B0E1B0000001974455874536F66747761
        7265007777772E696E6B73636170652E6F72679BEE3C1A000000E94944415448
        89EDD5BD4E02411486E1072CB4E11AB012C51B315668BC50B5305C82D686443A
        6B012D2C0D3FC5EC26CB666477C2D0F1255BEDE47D33E79C3DCB310DE9B43833
        C02D9678C6678AE0A4E1FD35EE718A339CE32D45D06D808F6A67DADCB8952006
        5F619C43308CC0D742FDA7A982FA9587B88BC09FF09E0AAF0BB2C3AB82011EEC
        6E7A4A7E857E7D94C09B8C70E815CCACD0684AC15818C35C294BB4D5E42BE1AB
        CDDAE4EAAA9817CF6545DC1106E0075FFB0A0E22892DBB39BE0B685572510816
        FB0A60F68FA48FD714C1AE319DE0D1F674256FD3A6FFC14C284B1F7F78114A78
        4CBE6C007ED430543985073F0000000049454E44AE426082}
      Stretch = True
      OnClick = imgVoltarClick
    end
    object imgExpandir: TImage
      Left = 80
      Top = 40
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Hint = 'Ajustar Zoom'
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000018
        000000180806000000E0773DF80000000473424954080808087C086488000000
        097048597300000EC400000EC401952B0E1B0000001974455874536F66747761
        7265007777772E696E6B73636170652E6F72679BEE3C1A0000015E4944415448
        89EDD6BB4A03411406E02F1BABC452834105F1D28A85BD0FE235BE87EF22447D
        1CD12ED612846023180B15B4C804D771664DC4C2C2BFD9DD739F7FE79C991A8E
        B1E82B6E719A90A7D0C15242DE2F32C1E16DC2E055B68B3391E01E5D3C4E119C
        8F9536B08FD65851948C0698C32E9A5326107CC6C107A904DDA068E100B35304
        6F602FF8DEE33C95E0A994642E54334992322D5F28AE63150FB8C60B7A58C37C
        78F6823C8598962E8641B78A87DA4FAA9AC2463D93205EC90A2E239B432C242A
        FF8422250C18E20C77D214BD06DD592EF83FFE0672BB688CA6D16ED9C455A43B
        C2366EE4FBA47217358DDABF8D78280AB276B0C9CEAEDC0AE226BAC07364D3C3
        7AB0D908DFB18DBAD161B1E58382AAF62FE3BBB1D2C1566174122D972A8FA762
        55130DE5A7F01296CBFF60A2D99240E514AE6327BC8FF9AC9C2D19A4E86AF279
        174D4A4B0E315DA086938CC36FDC2A14E8679C7EE356D17F07D1F9642B863E21
        830000000049454E44AE426082}
      Stretch = True
      OnClick = imgExpandirClick
    end
    object geolocalizacao: TTMSFNCGeocoding
      Left = 200
      Top = 13
      Width = 26
      Height = 26
      Visible = True
      GeocodingRequests = <>
    end
    object filtrarRotas: TTMSFNCRouteCalculator
      Left = 200
      Top = 45
      Width = 26
      Height = 26
      Visible = True
      OnCalculateRoute = filtrarRotasCalculateRoute
      Routes = <>
      Options.Polyline.StrokeColor = 12631228
    end
    object routeCalculator: TTMSFNCRouteCalculator
      Left = 240
      Top = 14
      Width = 26
      Height = 26
      Visible = True
      OnCalculateRoute = routeCalculatorCalculateRoute
      Routes = <>
      Options.Polyline.StartMarker = 
        'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads' +
        '/2022/06/transparente.png'
      Options.Polyline.EndMarker = 
        'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads' +
        '/2022/06/transparente.png'
      Options.Polyline.WayPointMarker = 
        'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads' +
        '/2022/06/transparente.png'
      Options.Polyline.AddWayPointMarker = 
        'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads' +
        '/2022/06/transparente.png'
      Options.Polyline.SelectedWayPointMarker = 
        'http://conhecimento.citelsoftware.com.br/blog/wp-content/uploads' +
        '/2022/06/transparente.png'
      Options.Polyline.StrokeColor = 12631228
    end
    object pnlLegendas: TPanel
      Left = 812
      Top = 0
      Width = 284
      Height = 100
      Anchors = [akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 3
      DesignSize = (
        284
        100)
      object recFiltros: TShape
        Left = 0
        Top = 0
        Width = 149
        Height = 100
        Anchors = [akTop, akRight]
        Pen.Color = clWhite
        Pen.Width = 0
      end
      object imgFinalizada: TImage
        Left = 7
        Top = 18
        Width = 22
        Height = 22
        Anchors = [akTop, akRight]
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000016
          0000001608020000004BD6FB6C000000017352474200AECE1CE9000000046741
          4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
          00019849444154384FAD54CB4EC240143D2612510B31D0B0102DA41412E2B7B0
          6007898F2FE0615CEA57185D13C263D706837E90127F40135E9B7A8619A1368D
          5AEBC959CCB4F79C76EEDC7BE1464680C5743AED743AB55ACDB2ACC40AA552A9
          5EAF77BBDDD96CA6823CF05B0C0603C3309004CE63B84BC04E0B72C16D02F97C
          7E381CAAD04F7CB168369B206E763039846BC135E1E656E4C2C24B16D771BE6F
          B7DB4AB0C2C642E8B780471D6E19EF069EB382949172CD877C354E31ACD56A29
          D9DAC2711CF1FD31F527E217D6622FF950FCDD091ED28C1D8D46522B2C168B85
          AEEBB8DA557A9FD24BE552C6653C93C92C974B65C15443035E8FF0960BFEBE97
          F2449363ECA1DFEF2B8B4AA52212CE84FDA8976418137CBA5DAD569585699AE2
          DA98F95016B749168EB2D0340D4E4A58F842BF2183ED34ABEEFF2CC441EEB548
          0711E9BC089FCEB3D8269DE252F7A35DEA7C3EFF5B69B126950561DB76880267
          9BF80A5CA2D16888367B4A07B499D4CB36631F06B69944D46697E8F57A6AE4F0
          8ED4C83908317224D683AF5028B0788862B1C8ED6F075F68B8EE07D319F1F961
          5567F20000000049454E44AE426082}
      end
      object imgNaoIniciada: TImage
        Left = 7
        Top = 60
        Width = 22
        Height = 22
        Anchors = [akTop, akRight]
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000016
          0000001608020000004BD6FB6C000000017352474200AECE1CE9000000046741
          4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
          0001EC49444154384FA5544B4B0251189DC6AD428448410EA2E32C02231ADC8E
          D5529AC052505A6496B3287C94890EFD8C1EB613F1B153DC1BFD8EDE50F41B7C
          6D6EDFCCBD8D3A3E523C9CCD5CCE7798FBDDEF7C149A1B232C9ACD663E9F0F06
          832CCB9A54701C170A850A8542ABD522A23EE82DCAE532C330CB063ACD320DC1
          FDE215800D0F9F66AD169AB6D96C954A8548FF3060118FC7298ABAE7D7D0891F
          5D45D065983015563E4FFC779B6B20482693A44045CF02EA0D14F5B6B783B251
          747EA8B8E80887D9E8ABB8435354229120659A45AD5603FB1F710BC992A28E1C
          0C1463E24359FADAF580B85EAFE35AC5A2D3E998CDE687758ED40F53E7284B37
          2EA7C562E976BBC4025ABD44D3E83480CE0E51A44FAAB1FF10ECD46B2ED20BA5
          52895888A228B356A56123FF7F04F7419C71ACFA7C3E6261B7DB9F3C3C4A1D0F
          49C73375FC28F03038C4C268347E7A057471A4D74DE0E5D1875780A99BC3E262
          D042BD887BAE8B403BAF3966867682EC2A9265ADBD76FEFFA8FD248F1A1878D4
          76BB0DA395DB183F5A3ACAD2AD8B83D182992416806AB53AFD807FEF6EEB071C
          23168B41CCDEB5980DDF488999043904D9889861E0B0E794B00794EE6A6107E2
          B0F313C38E512C1661E5AC18E80CC73C7ADCCF5E01D810A65E3918DAE273381C
          EADE33399D4EF89C76F1CD0C847E0137CBA25E4619F2E40000000049454E44AE
          426082}
      end
      object recRotaEfetuada: TShape
        Left = 149
        Top = 50
        Width = 135
        Height = 50
        Anchors = [akTop, akRight]
        Pen.Color = 15132390
        ExplicitLeft = 784
      end
      object recRotaPlanejada: TShape
        Left = 149
        Top = 0
        Width = 135
        Height = 50
        Anchors = [akTop, akRight]
        Pen.Color = 15132390
        ExplicitLeft = 784
      end
      object imgEmAndamento: TImage
        Left = 7
        Top = 39
        Width = 22
        Height = 22
        Anchors = [akTop, akRight]
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000016
          0000001608020000004BD6FB6C000000017352474200AECE1CE9000000046741
          4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
          0001D949444154384FAD54CB4EC250106DD90A3112A46EAC840289B823EA0FA8
          AC60410804425C29E02305F646E3DBBFB01028C60584356AC457A2FE0C898F52
          58384EDB2B20362AE2C959B4E59C43EEDC99A16060E844489224084224127138
          1C26152E972B1A8DE672B946A341445DE88D1045916559CB089D4830A2307559
          F520C5AC3B1967CC23B4CD662B168B44FA814F11A9548AA2A8FD1D4EAA7B01C2
          002180A04A7C08BFD6BD7BDB76146432196250D18940BFC1405D9FCF02C4007C
          F0B4A0F059A5F68C1F217675368BB2743A4D6CED8872B98CF18FB569C5FF8A86
          7962EE267EC49F20767F398DE24AA5A279958866B369B1588E3659804590F4CC
          DD4401C47637C6AD566BABD5221158EA6113FD26E1F97D6FBAFFDF454580B297
          05D3105D28144884DFEF5F8F334AFD5EE67A0CFA4419845797AC81408044D8ED
          F6D3AC5B297BBB7EDF53296DE8E478121B8744188DC6BB338F72793DD26F08C1
          DBAA07BBEEFF22FE7A90A9CE41B09C7C72ACDF72AE2D339D726A970A835CAA2C
          CBD85A875B7DB4D6DEC604B616F6248940944A25B5C1677ED3E00FB52F0DAE81
          E7799C9F9B8B1FC60CE7507FCC3468C37EB0C3C97F1B760DF97C1E57CEA8995E
          498C15B3EEBE578E86F6E2E3384EDD7B26A7D389AFBF5D7C7D03E01DB6F11902
          F77BA5BB0000000049454E44AE426082}
      end
      object imgRotaEfetuada: TImage
        Left = 157
        Top = 63
        Width = 24
        Height = 24
        Anchors = [akTop, akRight]
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000018
          000000180806000000E0773DF80000000473424954080808087C086488000000
          097048597300000EC400000EC401952B0E1B0000001974455874536F66747761
          7265007777772E696E6B73636170652E6F72679BEE3C1A0000024D4944415448
          89BD964F48545114C67FE73EB598FE631014FDC15A18524E333EA236B5086A93
          10B4681345A845ABA216865BA1360541ABD410DAB40BDA44B4CF621C0D53DAA4
          506E03437450F3BDAF85A3CE7BCD1B47B03E788BF7BE7BBEEF9C7BDE3D5C2306
          FF46AE21F078855CDB506F7624CE97C3899B9F9A2D743D5EC095DC0B7FA29473
          F1C5A1A70B802F6F714B35E245A400BF181B414DA5A896B6DCD9D0EC1A28C1CC
          6645D80F5A48D2483470F2CE84A66E90979C8230ECAA42D7052AAF93141A4A77
          800AE22BF0407713134D220CF65421BEE6DA4A3DF8097CAED2230DEC5E9F8118
          18EAF55BAB51CFB4E5DE605C2CC7256ED146E19F1B246F91712AD39E7B5FA54E
          7AFD064B4D3B57A541222A9EE415181388A9D8B75D8886B542D7EE8131093C03
          A64A1FC39E16B98A88549069CF9F1741E4D734318DD9DB107D8964B6A8493C3A
          4A0784A035D39E1F1FEAC9BE5BCDAF88F4AD81432EA8F9466C3C188CC9E9BE42
          D71C313086919E089A6249070ABDC3C37D99EFD10A026F6F5C7C95B34633451A
          1ECA0A09FBEBC92DEE036206ABF880DC3DBC6027A1BD069069D864856865F615
          13C01C4E9708BC5F58F818385DBAEE6F03A35E286DB2ED40ADE080031F8BCD1A
          D3368983402DB2E3324D9B511F9FDA06D0747B6C6BDDC26C97997596AF7A7D90
          F42898DFD43DF2B279D601D405338D1B250E60669D5E6AEE28FCAF59B439158C
          CDCDB8CB6059430F4A32B90E1492828B4849EA5F7E11F61094DF315F18859273
          0090ED183C26E9234BB7841F667624FFBCE57725F56CC760ADD038623F507021
          2707FBFCD165FE0F4FC7C73FD8DF6E100000000049454E44AE426082}
        ExplicitLeft = 792
      end
      object imgRotaPlanejada: TImage
        Left = 157
        Top = 13
        Width = 24
        Height = 24
        Anchors = [akTop, akRight]
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000018
          000000180806000000E0773DF80000000473424954080808087C086488000000
          097048597300000EC400000EC401952B0E1B0000001974455874536F66747761
          7265007777772E696E6B73636170652E6F72679BEE3C1A000002364944415448
          89BD94CD6B135114C5CFB93114E2078A1683626CA28BBAB00D9820BAD145A1DD
          5810DC8AAE5C2B6E2ADD1674E342F00FE87F200822E25EA54414ACB8EABC8CB3
          2B01A5D02444668E0B13994C33F980EA8159CCFDFADDF72EEF0209F9BE5F72CE
          6D789E3797F4A5C9F3BC79E7DC86EFFBA5A4CF9206494B24AB6676705C8099E5
          4856252D257D0786253AE7AE9BD91D4903612477A3285A07D049AB910A90748D
          E49AA4CC901890BC4D7255D2C0983D5714EBEE3E80D4E23165243D4873A60200
          9C1CA3F8C8D861336800F83C26A00CE0C4440049EF8BC5E2F238D59D732F49DE
          18E41B7645FBA27F0E48BD229257EAF5FADB31EB942706E0CFD016C604A46AE8
          4B8EC903F023613B0660CFEE496AE40C4806929E77017F3F92CF4806A3F2FB4E
          E09C5B24B91C7FF6927600BC26F9251E1B86616066F712CD2C3BE7B68AC5E29B
          3D00E7DC0CC95729BB6706C07CC23668132F925CF03CEF5CA954F2FB00244F21
          7DF7CC4AEA1B78269369A62CB88C999D06D00F88E99DA487008E927CD1B57D22
          D98C0791FCD605B425DD04F093E4530057E3718300C70194CDEC88A42C8002C9
          6A14457DBB86E46100670164CD6C2E8AA29D6E6E9F0800DBDBDB875AADD6AAA4
          9541679E54249F4C4D4DADE5F3F95D038076BB3DBB5FC50140D24AA7D3B900FC
          AF5D44F22B805B242F497A14EBE4AE993553B30144519423B9DEFB27F958D2C7
          300C3781EE0C7A0A82E06218861F00E4007C6F341AE72B95CAAF61805AAD969D
          9E9EDE92740640D3CC2E170A85CD9EFF373B6EDB2E39AC269F0000000049454E
          44AE426082}
        ExplicitLeft = 792
      end
      object lblDistanciaRotaEfetuada: TLabel
        Left = 187
        Top = 75
        Width = 92
        Height = 24
        ParentCustomHint = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = '447 Km'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        StyleElements = []
        ExplicitLeft = 822
      end
      object lblDistanciaRotaPlanejada: TLabel
        Left = 187
        Top = 25
        Width = 92
        Height = 24
        ParentCustomHint = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = '447 Km'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        StyleElements = []
        ExplicitLeft = 822
      end
      object lblTempoRotaEfetuada: TLabel
        Left = 187
        Top = 50
        Width = 92
        Height = 24
        ParentCustomHint = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = '5 h 21 min'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = 13329714
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        Layout = tlBottom
        StyleElements = []
        ExplicitLeft = 822
      end
      object lblTempoRotaPlanejada: TLabel
        Left = 187
        Top = 0
        Width = 92
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '5 h 21 min'
        Font.Charset = ANSI_CHARSET
        Font.Color = 12369088
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        StyleElements = []
        ExplicitLeft = 822
      end
      object cbxEmAndamento: TCheckBox
        Left = 36
        Top = 41
        Width = 104
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Em Andamento'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        StyleElements = []
        OnClick = cbxEmAndamentoClick
      end
      object cbxFinalizada: TCheckBox
        Left = 36
        Top = 20
        Width = 104
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Finalizada'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
        StyleElements = []
        OnClick = cbxFinalizadaClick
      end
      object cbxNaoIniciada: TCheckBox
        Left = 36
        Top = 62
        Width = 104
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'N'#227'o Iniciada'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
        StyleElements = []
        OnClick = cbxNaoIniciadaClick
      end
    end
    object aniAguarde: TActivityIndicator
      Left = 424
      Top = 21
      Anchors = [akLeft, akTop, akRight, akBottom]
      IndicatorSize = aisLarge
      ExplicitWidth = 32
      ExplicitHeight = 32
    end
  end
  object googleMaps: TTMSFNCGoogleMaps [3]
    Left = 0
    Top = 100
    Width = 1096
    Height = 622
    Align = alClient
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 3
    OnMarkerDblClick = googleMapsMarkerDblClick
    OnMarkerMouseEnter = googleMapsMarkerMouseEnter
    OnMarkerMouseLeave = googleMapsMarkerMouseLeave
    OnMapInitialized = googleMapsMapInitialized
    OnGetZoomLevel = googleMapsGetZoomLevel
    APIKey = 'AIzaSyB5SobAyBQzDezXxDronViGxbbb_8KYszo'
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    Options.Locale = 'pt-BR'
    Options.DefaultLatitude = -15.779720000000000000
    Options.DefaultLongitude = -47.929720000000010000
    Options.DefaultZoomLevel = 4.000000000000000000
    Options.BackgroundColor = -1
    Options.DisablePOI = False
    Options.Version = 'quarterly'
    ElementContainers = <>
    HeadLinks = <>
    KMLLayers = <>
    Directions = <>
    Clusters = <>
    OverlayViews = <>
  end
  object pgbMaps: TcxProgressBar [4]
    Left = 0
    Top = 722
    Align = alBottom
    AutoSize = False
    ParentColor = False
    ParentFont = False
    Position = 60.000000000000000000
    Properties.BeginColor = 54056
    Properties.OverloadBeginColor = clWhite
    Properties.PeakValue = 100.000000000000000000
    Properties.SolidTextColor = True
    Style.BorderColor = clFuchsia
    Style.BorderStyle = ebsNone
    Style.Color = clSilver
    Style.Edges = []
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'MS Sans Serif'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = [fsBold]
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = False
    Style.TextColor = clBlack
    Style.TransparentBorder = False
    Style.IsFontAssigned = True
    StyleDisabled.BorderStyle = ebsNone
    StyleDisabled.Color = clBtnShadow
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleDisabled.TextStyle = [fsBold]
    StyleFocused.LookAndFeel.Kind = lfUltraFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.LookAndFeel.Kind = lfUltraFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 4
    Height = 20
    Width = 1096
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 512
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 512
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 512
  end
  object tmrRotas: TTimer
    OnTimer = tmrRotasTimer
    Left = 240
    Top = 48
  end
end
