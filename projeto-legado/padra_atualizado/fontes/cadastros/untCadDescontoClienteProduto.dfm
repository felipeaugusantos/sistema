inherited frmCadDescontoClienteProduto: TfrmCadDescontoClienteProduto
  Top = 241
  Width = 699
  Height = 495
  Caption = 'Cadastro de Desconto Cliente / Produtos'
  ExplicitWidth = 699
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 164
    Width = 683
    TabOrder = 3
    ExplicitTop = 164
    ExplicitWidth = 683
    inherited FlwBotoes: TFlowPanel
      Left = 340
      Width = 271
      Align = alLeft
      ExplicitLeft = 340
      ExplicitWidth = 271
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 93
        Align = alLeft
        ExplicitWidth = 93
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 93
        Width = 78
        Align = alLeft
        ExplicitLeft = 93
        ExplicitWidth = 78
      end
      object btnImpABC: TBitBtnLocked
        Left = 171
        Top = 0
        Width = 99
        Height = 24
        Align = alLeft
        Caption = '[F7] Curva ABC'
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
          A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
          ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
          A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
          A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
          B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
          A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
          A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
          C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
          A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
          A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
          BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
          A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
          A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
          D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
          9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
          AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
          DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
          9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
          A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
          B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
          FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
          FFFFFFFFFFFFFF000000}
        TabOrder = 2
        OnClick = btnImpABCClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 611
      Width = 70
      ExplicitLeft = 611
      ExplicitWidth = 70
    end
    inherited btnCancela: TBitBtnLocked
      Left = 265
      Width = 75
      ExplicitLeft = 265
      ExplicitWidth = 75
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 197
      Width = 68
      Font.Height = 15
      ParentFont = False
      ExplicitLeft = 197
      ExplicitWidth = 68
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 128
      Width = 69
      ExplicitLeft = 128
      ExplicitWidth = 69
    end
    inherited btnGravar: TBitBtnLocked
      Left = 65
      Width = 63
      ExplicitLeft = 65
      ExplicitWidth = 63
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      Width = 63
      ExplicitLeft = 2
      ExplicitWidth = 63
    end
  end
  inherited pnlStatus: TPanel
    Top = 440
    Width = 683
    TabOrder = 7
    ExplicitTop = 440
    ExplicitWidth = 683
    inherited pnlNomeForm: TPanel
      Left = 512
      ExplicitLeft = 512
    end
    inherited pnlInfo: TPanel
      Width = 512
      ExplicitWidth = 512
    end
  end
  inherited pnlHeader: TPanel
    Top = 37
    Width = 683
    Height = 87
    TabOrder = 1
    ExplicitTop = 37
    ExplicitWidth = 683
    ExplicitHeight = 87
    inherited lblInf: TLabel
      Left = 731
      Top = 97
      ExplicitLeft = 731
      ExplicitTop = 97
    end
    object Label24: TLabel [1]
      Left = 30
      Top = 12
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label5: TLabel [2]
      Left = 21
      Top = 35
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object lbl1: TLabel [3]
      Left = 144
      Top = 35
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lbl2: TLabel [4]
      Left = 547
      Top = 12
      Width = 17
      Height = 14
      Alignment = taRightJustify
      Caption = 'UN:'
    end
    object Label2: TLabel [5]
      Left = 6
      Top = 58
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
    inherited pgcDados: TPageControl
      Left = 656
      Top = 262
      Height = 11
      ExplicitLeft = 656
      ExplicitTop = 262
      ExplicitHeight = 11
      inherited tbsGeral: TTabSheet
        Caption = 'Digita'#231#227'o:'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 1
      end
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 6
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PDS_CODITE'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbePerDes: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 29
      Width = 70
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PDS_PERDES'
      DataSource = dtsConsulta
      TabOrder = 2
      OnKeyPress = dbePerDesKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 142
      Top = 6
      Width = 401
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'ITE_DESITE'
      DataSource = dtsConsulta
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSigUni: TDBEditFocus
      Left = 566
      Top = 6
      Width = 59
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'UNI_SIGUNI'
      DataSource = dtsConsulta
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object mskLinGru: TMaskEditFocus
      Left = 72
      Top = 52
      Width = 70
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 5
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 142
      Top = 52
      Width = 401
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 412
    Width = 683
    Height = 0
    TabOrder = 5
    ExplicitTop = 412
    ExplicitWidth = 683
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 162
    Width = 0
    Height = 0
    Align = alNone
    DataSource = nil
    TabOrder = 4
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PDS_CODITE'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_SIGUNI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PDS_PERDES'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 124
    Width = 683
    TabOrder = 2
    ExplicitTop = 124
    ExplicitWidth = 683
    inherited edtData: TMaskEditFocus
      ParentCtl3D = False
    end
    inherited edtNumero: TEditFocus
      ParentCtl3D = False
    end
    inherited edtString: TEditFocus
      ParentCtl3D = False
    end
    inherited edtValor: TEditFocus
      ParentCtl3D = False
    end
  end
  inherited pnlInfBotoes: TPanel
    Top = 412
    Width = 683
    Height = 28
    TabOrder = 6
    ExplicitTop = 412
    ExplicitWidth = 683
    ExplicitHeight = 28
    inherited Label1: TLabel
      Width = 536
      Height = 14
      Align = alNone
      Caption = 
        '[F2] Posiciona sobre a grade de registros     [ F3 ] Ordenar reg' +
        'istros pr'#243'xima coluna    [ F5 ] Pesquisar registros'
      Visible = False
      ExplicitWidth = 536
    end
    object btnAlteracaoGlobal: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 175
      Height = 24
      Align = alLeft
      Caption = '[F2] Altera'#231#227'o Global de Desconto'
      TabOrder = 0
      OnClick = btnAlteracaoGlobalClick
    end
    object btnExclusaoGlobal: TBitBtnLocked
      Left = 177
      Top = 2
      Width = 112
      Height = 24
      Align = alLeft
      Caption = '[F3] Exclus'#227'o Global'
      TabOrder = 1
      OnClick = btnExclusaoGlobalClick
    end
  end
  object pnlCliente: TPanel [7]
    Left = 0
    Top = 0
    Width = 683
    Height = 37
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label4: TLabel
      Left = 10
      Top = 14
      Width = 60
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 72
      Top = 8
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 142
      Top = 8
      Width = 401
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object btnPesquisaDesc: TBitBtnLocked
      Left = 547
      Top = 7
      Width = 78
      Height = 24
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnPesquisaDescClick
    end
  end
  object grdProdutos: TcxGridCitel [8]
    AlignWithMargins = True
    Left = 3
    Top = 195
    Width = 677
    Height = 214
    Align = alClient
    TabOrder = 8
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdProdutosTv: TcxGridDBTableViewCitel
      OnDblClick = grdProdutosTvDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object grdProdutoCodIte: TcxGridDBColumn
        DataBinding.FieldName = 'PDS_CODITE'
        Width = 100
      end
      object grdProdutoDesIte: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 400
      end
      object grdProdutoSigUni: TcxGridDBColumn
        DataBinding.FieldName = 'UNI_SIGUNI'
      end
      object grdProdutoPerDes: TcxGridDBColumn
        DataBinding.FieldName = 'PDS_PERDES'
      end
    end
    object grdProdutosLvl: TcxGridLevel
      GridView = grdProdutosTv
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 592
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 256
  end
  inherited qryConsulta: TUniQuery
    Left = 224
    Top = 40
  end
  inherited dspConsulta: TUniDataSetProvider
    ResolveToDataSet = True
    Left = 464
    Top = 256
  end
  inherited cdsConsulta: TUniClientDataSet
    OnReconcileError = cdsConsultaReconcileError
    Left = 496
    Top = 256
    object cdsConsultaPDS_CODCLI: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 8
      FieldName = 'PDS_CODCLI'
      Size = 8
    end
    object cdsConsultaPDS_CODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 5
      FieldName = 'PDS_CODITE'
      Size = 5
    end
    object cdsConsultaITE_DESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 70
      FieldName = 'ITE_DESITE'
      ProviderFlags = []
      Size = 70
    end
    object cdsConsultaUNI_SIGUNI: TStringField
      DisplayLabel = 'UN'
      DisplayWidth = 6
      FieldName = 'UNI_SIGUNI'
      ProviderFlags = []
      Size = 6
    end
    object cdsConsultaPDS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      DisplayWidth = 3
      FieldName = 'PDS_CODEMP'
      Size = 3
    end
    object cdsConsultaAUTOINCREM: TStringField
      DisplayLabel = 'AutoIncremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object cdsConsultaPDS_PERDES: TFloatField
      DisplayLabel = '(%) Desconto'
      FieldName = 'PDS_PERDES'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 528
    Top = 256
  end
end
