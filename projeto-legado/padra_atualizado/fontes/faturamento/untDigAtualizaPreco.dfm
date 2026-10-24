inherited frmDigAtualizaPreco: TfrmDigAtualizaPreco
  Width = 876
  Height = 615
  Caption = 'Atualiza'#231#227'o de pre'#231'os de documento venda'
  ExplicitWidth = 876
  ExplicitHeight = 615
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 544
    Width = 870
    ExplicitTop = 544
    ExplicitWidth = 870
    inherited FlwBotoes: TFlowPanel
      Width = 866
      ExplicitWidth = 866
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
      object btnMarcarDesmarcarTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F2] Marcar / Desmarcar Todos'
        TabOrder = 1
        OnClick = btnMarcarDesmarcarTodosClick
      end
      object btnValidaPreco: TBitBtnLocked
        Left = 242
        Top = 0
        Width = 167
        Height = 22
        Caption = '[F3] Valida trava de pre'#231'o'
        TabOrder = 2
        OnClick = btnValidaPrecoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 790
      ExplicitLeft = 790
    end
  end
  inherited pnlStatus: TPanel
    Top = 570
    Width = 870
    ExplicitTop = 570
    ExplicitWidth = 870
    inherited pnlNomeForm: TPanel
      Left = 699
      ExplicitLeft = 699
    end
    inherited pnlInfo: TPanel
      Width = 699
      ExplicitWidth = 699
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 870
    Height = 153
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblCliente: TLabel
      Left = 8
      Top = 101
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblEmpresa: TLabel
      Left = 8
      Top = 125
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 8
      Top = 77
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label6: TLabel
      Left = 129
      Top = 76
      Width = 9
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'a'
    end
    object rdgTipoDocumento: TRadioGroup
      Left = 16
      Top = 8
      Width = 273
      Height = 56
      Caption = 'Tipo de Documento'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Or'#231'amentos'
        'Pedidos')
      TabOrder = 0
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 59
      Top = 97
      Width = 86
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
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
      Left = 148
      Top = 97
      Width = 235
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 59
      Top = 122
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 97
      Top = 122
      Width = 286
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object btnFiltrar: TBitBtnLocked
      Left = 388
      Top = 122
      Width = 85
      Height = 22
      Caption = 'C&onsultar'
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 59
      Top = 72
      Width = 64
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
      OnExit = mskDtaIniExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 144
      Top = 72
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
  end
  object pnlDocumentos: TPanel [3]
    Left = 0
    Top = 153
    Width = 870
    Height = 391
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grdConsulta: TcxGrid
      Left = 1
      Top = 1
      Width = 868
      Height = 389
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfOffice11
      object grdConsultaDBTableView1: TcxGridDBTableView
        OnKeyDown = grdConsultaDBTableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdConsultaDBTableView1CustomDrawCell
        DataController.DataSource = dtsConsulta
        DataController.KeyFieldNames = 'AUTOINCREM'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object grdConsultaDBTableViewCODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'FGO_CODEMP'
          MinWidth = 64
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 64
        end
        object grdConsultaDBTableViewNUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'FGO_NUMDOC'
          MinWidth = 78
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 78
        end
        object grdConsultaDBTableViewESPDOC: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'FGO_ESPDOC'
          MinWidth = 64
          Options.Editing = False
          Options.AutoWidthSizable = False
        end
        object grdConsultaDBTableViewCODCLI: TcxGridDBColumn
          Caption = 'C'#243'd. Cliente'
          DataBinding.FieldName = 'FGO_CODCLI'
          MinWidth = 75
          Options.Editing = False
          Options.AutoWidthSizable = False
          Width = 75
        end
        object grdConsultaDBTableViewNOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Options.Editing = False
        end
        object grdConsultaDBTableViewDTAENT: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'FGO_DTAENT'
          MinWidth = 64
          Options.Editing = False
        end
        object grdConsultaDBTableViewHORENT: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'FGO_HORENT'
          MinWidth = 64
          Options.Editing = False
        end
        object grdConsultaDBTableViewMARDES: TcxGridDBColumn
          Caption = 'MARDES'
          DataBinding.FieldName = 'FGO_MARDES'
          Visible = False
          Options.Editing = False
          Options.AutoWidthSizable = False
        end
        object grdConsultaDBTableViewVALIDA: TcxGridDBColumn
          Caption = 'Validar'
          DataBinding.FieldName = 'FGO_VALIDA'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = cxImageList1
          Properties.Items = <
            item
              ImageIndex = 0
              Value = 1
            end
            item
              ImageIndex = 1
              Value = 2
            end
            item
              ImageIndex = 2
              Value = 0
            end>
          Options.Editing = False
        end
      end
      object grdConsultaTableView1: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object grdConsultaDBTableView2: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsTrava
        DataController.DetailKeyFieldNames = 'AUTOINCREM'
        DataController.KeyFieldNames = 'AUTOINCREM'
        DataController.MasterKeyFieldNames = 'AUTOINCREM'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        object grdConsultaDBTableViewTRAVAS: TcxGridDBColumn
          Caption = 'Motivo da trava'
          DataBinding.FieldName = 'TRAVAS'
        end
      end
      object grdConsultaLevel1: TcxGridLevel
        GridView = grdConsultaDBTableView1
        object grdConsultaLevel2: TcxGridLevel
          GridView = grdConsultaDBTableView2
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 888
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 896
    Top = 64
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 680
    Top = 16
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaFGO_CODEMP: TStringField
      FieldName = 'FGO_CODEMP'
      Size = 3
    end
    object cdsConsultaFGO_NUMDOC: TStringField
      FieldName = 'FGO_NUMDOC'
      Size = 12
    end
    object cdsConsultaFGO_ESPDOC: TStringField
      FieldName = 'FGO_ESPDOC'
      Size = 2
    end
    object cdsConsultaFGO_CODCLI: TStringField
      FieldName = 'FGO_CODCLI'
      Size = 8
    end
    object cdsConsultaCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsConsultaFGO_DTAENT: TDateField
      FieldName = 'FGO_DTAENT'
    end
    object cdsConsultaFGO_HORENT: TTimeField
      FieldName = 'FGO_HORENT'
    end
    object cdsConsultaFGO_MARDES: TStringField
      FieldName = 'FGO_MARDES'
      Size = 1
    end
    object cdsConsultaFGO_VALIDA: TIntegerField
      FieldName = 'FGO_VALIDA'
    end
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 680
    Top = 72
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 15794272
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000101011A0102016C020402A6030603C4030603C40204
          02A60102016C0101011A00000000000000000000000000000000000000000000
          0000000000000202014D050502BF0D1E07E31C6D0DF52BC320FD2BC320FD1C6D
          0DF50D1E07E3050502BF0202014D000000000000000000000000000000000000
          00000202014D070903CD207410F632D121FF31B620FF31D120FF31D120FF31D1
          20FF31D120FF1D720EF6070903CD0202014D0000000000000000000000000101
          011A050502BF267016F632C821FF31B220FFE6E6E6FF31B220FF31C820FF31C8
          20FF31C820FF31C820FF1E6F0EF6050502BF0101011A00000000000000000202
          016C0D200DE335C024FF31AD20FFDEDEDEFFE2E2E2FFE6E6E6FF31AD20FF31BE
          20FF31BE20FF31BE20FF31BE20FF0D1F08E30202016C00000000000000000404
          02A72A6922F532AE21FFD5D5D5FFDADADAFFDEDEDEFFE2E2E2FFE6E6E6FF31A8
          20FF31B420FF31B420FF31B420FF206210F5040402A700000000000000000606
          03C44FB73FFDA9D7A2FFD5D5D5FFEBEBEBFF31A520FFDEDEDEFFE2E2E2FFE6E6
          E6FF31A320FF31AA20FF31AA20FF2B9E26FD060603C400000000000000000606
          03C452BA41FD4BB33AFFF8F8F8FF3CA82BFF32A221FF319F20FFDEDEDEFFE2E2
          E2FFE6E6E6FF319E20FF31A120FF2C9A2AFD060603C400000000000000000404
          02A735712CF556BE45FF4DB53CFF56BE45FF50B93FFF46AF35FF3CA42BFFE2E2
          E2FFE3E3E3FFE7E7E7FF359E24FF236322F5040402A700000000000000000202
          016C11240EE363CB52FF5DC54CFF5DC54CFF5DC54CFF5DC54CFF5DC54CFF53BB
          42FFFFFFFFFFA7E29EFF61C950FF10220DE30202016C00000000000000000101
          011A050505BF3D7D35F667CF56FF66CE55FF66CE55FF66CE55FF66CE55FF66CE
          55FF59C148FF61C950FF3B7C32F6050504BF0101011A00000000000000000000
          00000202014D070A07CD3E8036F672DA61FF6ED65DFF6ED65DFF6ED65DFF6ED6
          5DFF71D960FF3D7F35F6070A07CD0202014D0000000000000000000000000000
          0000000000000202014D050505BF12240EE3397933F56ACC59FD6ACC58FD3978
          33F512240EE3050505BF0202014D000000000000000000000000000000000000
          000000000000000000000101011A0202016C040402A6060603C4060603C40404
          02A60202016C0101011A00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000001010101010101010000
          0000000000000000000000000000000000000000000000000000000000000101
          010201010113010101250101013801020249010202550102025B0102025C0102
          02560102024B0101013C01010128010101160101010400000000000000000101
          010201010114050D13BC204D63EA235870EE20566EEE1F556EEF1A526BEF1651
          69EF144B62ED13485EEC081E29D7010101340101010400000000000000000000
          0000020202485493A8F579F0FEFF69EFFEFF5CEBFCFF50E7F9FF44E3F7FF38E0
          F4FF30DDF2FF27D9EFFF409FB6FA020608A90000000000000000000000000000
          00000202026588DCF0FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658CDEF1FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658EDFF2FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          0000020202658EDFF3FF4CEBFEFF45EBFEFF3AE7FBFF30E3F8FF26DFF6FF1CDC
          F3FF12D8F0FF07D4EDFF349EB1F8051118C70000000000000000000000000000
          000001010131437D95F291F1FDFF82F2FEFF7CEFFCFF71EBFAFF63E8F8FF56E5
          F6FF48E1F3FF39DCF1FF328BA4F80203048F0000000000000000000000000000
          000000000000030505993F83A9FA2A7194F70C2532D50B2531D50B2430D50923
          2FD5256785F72A6F92FA04090BB20101010E0000000000000000000000000000
          00000000000002020250C5C8C7FD232424DC0000000000000000000000000000
          0000363737E38C8F8DF702020240000000000000000000000000000000000000
          0000000000000202024FCDCECEFD2B2C2BE10000000000000000000000000101
          0101333534E56A6D6CF30101013F000000000000000000000000000000000000
          00000000000001010131A0A1A1F6464747E90202024000000000000000000202
          0241444847EC383B3AE60101011F000000000000000000000000000000000000
          000000000000010101064D4D4DE6DBDEDDFF3F4040E8222222DB212121DA3B3D
          3BE8B7BBB9FF212323DC00000000000000000000000000000000000000000000
          00000000000000000000020202404A4E4CE7A9ACABFBC5C8C7FFC5C8C7FF8487
          86F7292B2AE10101013200000000000000000000000000000000000000000000
          00000000000000000000000000000101010A0202025D0303038C030303860202
          0251010101060000000000000000000000000000000000000000}
      end>
  end
  object cdsTrava: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 24
    object cdsTravaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsTravaTRAVAS: TStringField
      FieldName = 'TRAVAS'
      Size = 200
    end
  end
  object dtsTrava: TDataSource
    DataSet = cdsTrava
    Left = 520
    Top = 80
  end
end
