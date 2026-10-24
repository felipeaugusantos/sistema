inherited frmFatDigitalizacaoDocumentos: TfrmFatDigitalizacaoDocumentos
  Width = 1024
  Height = 617
  Caption = 'Digitaliza'#231#227'o de Documentos que ser'#227'o Confirmados'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 617
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 544
    Width = 1018
    TabOrder = 1
    ExplicitTop = 544
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnExcluir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 116
        Height = 24
        Align = alLeft
        Caption = '[ F5 ] Excluir'
        TabOrder = 0
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 898
      Width = 116
      ExplicitLeft = 898
      ExplicitWidth = 116
    end
  end
  inherited pnlStatus: TPanel
    Top = 572
    Width = 1018
    TabOrder = 2
    ExplicitTop = 572
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
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 135
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 77
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 5
        Top = 14
        Width = 112
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#250'mero do Documento:'
      end
      object Label2: TLabel
        Left = 468
        Top = 14
        Width = 41
        Height = 14
        Caption = 'Esp'#233'cie:'
      end
      object Label19: TLabel
        Left = 82
        Top = 60
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblCodEmp: TLabel
        Left = 72
        Top = 37
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 122
        Top = 9
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 511
        Top = 9
        Width = 30
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 122
        Top = 55
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 4
        OnExit = edtCodCliExit
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCli: TEditFocus
        Left = 188
        Top = 55
        Width = 600
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 122
        Top = 32
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
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
        Left = 188
        Top = 32
        Width = 600
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDatas: TPanel
      Left = 1
      Top = 78
      Width = 1016
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label4: TLabel
        Left = 62
        Top = 6
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Inicial:'
      end
      object Label5: TLabel
        Left = 392
        Top = 7
        Width = 103
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da Digitaliza'#231#227'o:'
      end
      object Label6: TLabel
        Left = 202
        Top = 6
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Final:'
      end
      object edtDtaDocIni: TMaskEditFocus
        Tag = 99
        Left = 122
        Top = 2
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
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDtaDig: TMaskEditFocus
        Tag = 99
        Left = 501
        Top = 2
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
      object edtDtaDocFim: TMaskEditFocus
        Tag = 99
        Left = 258
        Top = 2
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
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object chkSomenteDocDig: TCheckBox
        Left = 602
        Top = 6
        Width = 187
        Height = 17
        Caption = 'Somente Documentos Digitalizados'
        TabOrder = 3
        OnClick = chkSomenteDocDigClick
      end
    end
    object pnlConsultar: TPanel
      Left = 1
      Top = 107
      Width = 1016
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        1016
        27)
      object btnFiltrar: TBitBtnLocked
        Left = 834
        Top = 0
        Width = 179
        Height = 22
        Anchors = [akTop, akRight]
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
        TabOrder = 0
        OnClick = btnFiltrarClick
      end
    end
  end
  object grdDados: TcxGridCitel [3]
    Left = 0
    Top = 135
    Width = 1018
    Height = 409
    Align = alClient
    TabOrder = 3
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = grdDadosTvCellClick
      OnCustomDrawCell = grdDadosTvCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosTvGER_DTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'GER_DTAENT'
        Width = 70
      end
      object grdDadosTvGER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
        Width = 87
      end
      object grdDadosTvGER_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'GER_ESPDOC'
        Width = 45
      end
      object grdDadosTvGER_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'GER_CODEMP'
        OnGetDisplayText = grdDadosTvGER_CODEMPGetDisplayText
        Width = 186
      end
      object grdDadosTvGER_CODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'GER_CODCLI'
        OnGetDisplayText = grdDadosTvGER_CODCLIGetDisplayText
        Width = 210
      end
      object grdDadosTvDIG_IMGB64: TcxGridDBColumn
        Caption = 'Imagem'
        DataBinding.FieldName = 'DIG_IMGB64'
        Width = 44
      end
      object grdDadosTvDIG_DTADIG: TcxGridDBColumn
        Caption = 'Data Digitaliza'#231#227'o'
        DataBinding.FieldName = 'DIG_DTADIG'
        Width = 92
      end
      object grdDadosTvNOMEMP: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEMP'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bTrue
      end
      object grdDadosTvNOMCLI: TcxGridDBColumn
        DataBinding.FieldName = 'NOMCLI'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bTrue
      end
      object grdDadosTvDIGITALIZADO: TcxGridDBColumn
        Caption = 'Digitalizado'
        DataBinding.FieldName = 'DIGITALIZADO'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object grdDadosTvDIG_NOMARQ: TcxGridDBColumn
        Caption = 'Arquivo'
        DataBinding.FieldName = 'DIG_NOMARQ'
        Width = 150
      end
      object grdDadosTvBotaoArquivo: TcxGridDBColumn
        OnCustomDrawCell = grdDadosTvBotaoArquivoCustomDrawCell
        Width = 36
      end
    end
    object grdDadosLv: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object dtsDados: TDataSource
    Left = 460
    Top = 292
  end
  object ImageList1: TImageList
    Left = 932
    Top = 404
  end
  object imgList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 27525832
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000080000
          000D0000000E0000000E0000000F0000000F0000000F0000000F000000100000
          0010000000100000001100000011000000100000000B00000003815749BFB478
          65FFB47865FFB47864FFB37764FFB37764FFB37764FFB37663FFB37663FFB276
          63FFB27663FFB27562FFB27562FFB27562FF7F5447C20000000AB67D6AFFFBF6
          F3FFFBF6F3FFFBF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFBF5F1FFFAF5F1FFFAF4
          F1FFFAF4F0FFFAF3EEFFFAF2EEFFFAF2EEFFB47967FF0000000FB87F6DFFFBF7
          F5FF2FB487FF2EB485FF2EB485FF2EB388FF2FB487FF2EB485FF2EB388FF2A9C
          73FF278661FF2B916AFF1D6A4AFFFAF4F1FFB57B69FF0000000FBA8270FFFCF9
          F7FF36BB8FFF36BB8FFF36BA90FF33B187FF278D67FF23815DFF2DA179FF2FA3
          7AFF278561FF2E9770FF23815CFFFBF6F3FFB77E6BFF0000000EBC8573FFFDFA
          F9FF3FC398FF3FC398FF3EC398FF32A27DFF68C8B2FF34AC85FF226C75FF275D
          B9FF26747AFF2B8E69FF278964FFFCF8F5FFB9816EFF0000000DBE8876FFFDFB
          FAFF4FCEA6FF50CFA7FF50CFA7FF40AE8AFF3678B4FF336ABBFF3168B6FF6EC2
          F1FF306BB7FF3066B4FF2D6DAAFFFCF9F7FFBB8471FF0000000CC08B7AFFFEFC
          FBFF5BD5AEFF5BD5AFFF5AD6AEFF50C29EFF437BBFFF8BD5F6FF63A5E4FF73D7
          FCFF569EE1FF66C7F5FF3B74BEFFFDFAF9FFBE8674FF0000000BC28E7DFFFEFD
          FCFF62DBB5FF62DBB5FF5FD6B1FF53AEAFFF528DCCFF6EB1E7FF5B9DD2FF305D
          AAFF4F95CFFF5DA7E5FF4581C7FFFEFBFAFFBF8A77FF0000000AC59280FFFEFE
          FDFFF4DCAFFFF4DCAEFFEBD5A9FF628FD0FF94D5F6FFA9ECFFFF3B76BEFF4390
          D3FF3876BEFF7CDFFFFF74C9F4FFFEFCFBFFC18D7CFF00000009C79584FFFFFE
          FEFFF8E7C6FFF8E6C5FFF3E3C2FFBABEBDFF7CA8D8FF8DC8F1FF6CB6E4FF3A80
          C9FF67B5E4FF85D0F4FF6B9AD1FFFEFDFCFFC3907EFF00000008C99887FFFFFE
          FEFFFBEDD3FFFBEDD3FFFAEDD2FFEDE0C7FF87B2DCFFAAE8FDFF9CD5F6FFAFEF
          FFFF96DAF9FFA7ECFFFF7AA8D7FFFEFEFDFFC69381FF00000007CB9C8AFFFFFF
          FEFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFEFEFFC89785FF000000069C7C6EBED2A7
          95FFD2A795FFD2A694FFD1A694FFD1A594FFD1A593FFD1A593FFD0A492FFD0A4
          92FFD0A391FFCFA290FFCFA190FFCFA18FFF997669C000000003000000010000
          0001000000020000000200000002000000020000000200000003000000030000
          0003000000030000000300000004000000040000000300000001}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000090000
          000E000000100000001000000010000000100000001000000011000000110000
          001100000011000000100000000B00000003000000000000000019427ACA245A
          A5FF255CA7FF255BA7FF245AA6FF2459A6FF2358A5FF2358A4FF2356A4FF2256
          A4FF2255A3FF2154A3FF2153A1FF1C468AE303080F2900000002255DA5FF316B
          AEFF6DA6D5FF86CAF0FF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
          E1FF389BE0FF369AE0FF3498DFFF2C77C1FF10284D8B000000082B68AEFF4984
          BEFF4B8BC5FFB2E3F8FF68BBECFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
          E5FF47A6E4FF44A4E4FF41A2E3FF3A92D6FF1C4885D50000000D2F6FB4FF6CA7
          D2FF3F87C4FFAED9F0FF9AD8F5FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
          EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2D69B1FF040B142F3276B9FF8FC7
          E6FF509FD4FF86BCE0FFC5EFFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
          EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF448BC9FF122D4D81357CBCFFAFE3
          F5FF75C8EDFF59A2D4FFDDF7FDFFDFF8FEFFDDF7FEFFDBF7FEFFD8F5FEFFD4F4
          FDFFD0F2FDFFCCEFFCFFC7EDFBFFC1EBFBFF9ACBE9FF215187CB3882C1FFC7F5
          FEFF97E5FCFF64BAE5FF4D9FD3FF4D9DD2FF4B9BD1FF4A99CFFF4998CFFF4896
          CEFF4694CCFF4592CBFF3073B7FF3072B6FF2F71B5FF2A65A4EA3A88C5FFCDF7
          FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFF89DFFBFF86DEFAFF81DAFAFF7ED8
          F9FF7BD7F9FF79D6F9FF2A6BB0FF000000140000000A000000073D8EC8FFD0F8
          FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFBBF2FDFFD4F9FEFFD5F9FEFFD3F8
          FEFFD1F8FEFFCEF7FDFF3680BFFF0000000800000000000000003F92CBFFD3F9
          FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF4895CBFF3B8CC6FF3B8AC6FF3A89
          C5FF3A88C5FF3A87C3FF2A6391C20000000500000000000000004197CEFFE2FC
          FEFFE2FCFEFFE1FCFEFFD4F3FAFF458FBFEC040A0E1B00000006000000060000
          000600000006000000060000000400000001000000000000000031739ABF429A
          D0FF4299D0FF4299D0FF4297CFFF153244590000000200000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          0003000000030000000400000003000000020000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
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
      end
      item
        Image.Data = {
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
      end>
  end
end
