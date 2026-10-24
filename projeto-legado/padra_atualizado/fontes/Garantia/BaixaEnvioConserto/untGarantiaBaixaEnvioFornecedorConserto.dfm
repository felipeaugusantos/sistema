inherited frmGarantiaBaixaEnvioFornecedorConserto: TfrmGarantiaBaixaEnvioFornecedorConserto
  Width = 913
  Height = 508
  Hint = 'frmGarantiaBaixaEnvioFornecedorConserto'
  BorderIcons = [biSystemMenu]
  Caption = 'Garantia - Baixa de envio para fornecedor para conserto'
  Position = poMainFormCenter
  ExplicitWidth = 913
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 434
    Width = 907
    Height = 0
    ExplicitTop = 434
    ExplicitWidth = 907
    ExplicitHeight = 0
    inherited FlwBotoes: TFlowPanel
      Width = 903
      Enabled = False
      ExplicitWidth = 903
    end
    inherited btnSair: TBitBtnLocked
      Left = 721
      Top = -25
      Enabled = False
      Visible = False
      ExplicitLeft = 721
      ExplicitTop = -25
    end
  end
  inherited pnlStatus: TPanel
    Top = 463
    Width = 907
    ExplicitTop = 463
    ExplicitWidth = 907
    inherited pnlNomeForm: TPanel
      Left = 671
      Width = 236
      ExplicitLeft = 671
      ExplicitWidth = 236
    end
    inherited pnlInfo: TPanel
      Width = 671
      ExplicitWidth = 671
    end
  end
  object pnlFiltro: TPanel [2]
    Left = 0
    Top = 0
    Width = 907
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlFiltro'
    ShowCaption = False
    TabOrder = 2
    object lblFornecedor: TLabel
      Left = 8
      Top = 14
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object lblPeriodo: TLabel
      Left = 520
      Top = 14
      Width = 54
      Height = 14
      Caption = 'Per'#237'odo de:'
    end
    object lblPeriodoAte: TLabel
      Left = 650
      Top = 14
      Width = 18
      Height = 14
      Caption = 'at'#233':'
    end
    object edtCodFor: TEditFocus
      Left = 72
      Top = 10
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 148
      Top = 10
      Width = 366
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnPesquisar: TBitBtnLocked
      Left = 752
      Top = 10
      Width = 146
      Height = 22
      Caption = '[F5] Pesquisar'
      TabOrder = 4
      OnClick = btnPesquisarClick
    end
    object mskDtaIni: TMaskEditFocus
      Left = 577
      Top = 10
      Width = 70
      Height = 22
      Alignment = taRightJustify
      EditMask = '!99/99/9999;1;'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnExit = mskDtaIniExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Left = 671
      Top = 10
      Width = 70
      Height = 22
      Alignment = taRightJustify
      EditMask = '!99/99/9999;1;'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnExit = mskDtaFinExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 89
    Width = 907
    Height = 345
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDados'
    ShowCaption = False
    TabOrder = 3
    ExplicitTop = 85
    ExplicitHeight = 349
    object pnlMotivo: TPanel
      Left = 0
      Top = 318
      Width = 907
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlMotivo'
      ShowCaption = False
      TabOrder = 0
      ExplicitTop = 322
      object lblMotivo: TLabel
        Left = 5
        Top = 7
        Width = 34
        Height = 14
        Caption = 'Motivo:'
      end
      object edtMotivo: TEdit
        Left = 45
        Top = 3
        Width = 861
        Height = 22
        ReadOnly = True
        TabOrder = 0
      end
    end
    object dbgDadosNew: TcxGridCitel
      Left = 0
      Top = 0
      Width = 907
      Height = 318
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 322
      object dbgDadosNewDBTableViewCitel1: TcxGridDBTableViewCitel
        OnDblClick = dbgDadosNewDBTableViewCitel1DblClick
        OnKeyDown = dbgDadosNewDBTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDadosNewDBTableViewCitel1CustomDrawCell
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Filter.Active = True
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object dbgDadosNewDBTableViewCitel1NFENVI: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'NFENVI'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgDadosNewDBTableViewCitel1DTAENV: TcxGridDBColumn
          DataBinding.FieldName = 'DTAENV'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 67
        end
        object dbgDadosNewDBTableViewCitel1FORNECEDOR: TcxGridDBColumn
          DataBinding.FieldName = 'FORNECEDOR'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 67
        end
        object dbgDadosNewDBTableViewCitel1NUMGAR: TcxGridDBColumn
          DataBinding.FieldName = 'NUMGAR'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 97
        end
        object dbgDadosNewDBTableViewCitel1CODITE: TcxGridDBColumn
          DataBinding.FieldName = 'CODITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 85
        end
        object dbgDadosNewDBTableViewCitel1DESITE: TcxGridDBColumn
          DataBinding.FieldName = 'DESITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 300
        end
        object dbgDadosNewDBTableViewCitel1CODUNI: TcxGridDBColumn
          DataBinding.FieldName = 'CODUNI'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgDadosNewDBTableViewCitel1SALENV: TcxGridDBColumn
          Caption = 'Enviado'
          DataBinding.FieldName = 'SALENV'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgDadosNewDBTableViewCitel1QTDBAI: TcxGridDBColumn
          DataBinding.FieldName = 'QTDBAI'
          HeaderAlignmentHorz = taCenter
        end
        object dbgDadosNewDBTableViewCitel1Selecionado: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          Visible = False
        end
      end
      object dbgDadosNewLevel1: TcxGridLevel
        GridView = dbgDadosNewDBTableViewCitel1
      end
    end
  end
  object pnlBotoesEnt: TPanel [4]
    Left = 0
    Top = 434
    Width = 907
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object btnConfirmar: TBitBtnLocked
      Left = 6
      Top = 4
      Width = 155
      Height = 22
      Caption = '[F10] Confirmar/Gerar Baixa'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnDesmarcarTodos: TBitBtnLocked
      Left = 317
      Top = 4
      Width = 153
      Height = 22
      Caption = '[F7] Desmarcar todos'
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
      TabOrder = 1
      OnClick = btnDesmarcarTodosClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 164
      Top = 4
      Width = 153
      Height = 22
      Caption = '[F6] Marcar todos'
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
      TabOrder = 2
      OnClick = btnMarcarTodosClick
    end
    object btnSair_: TBitBtnLocked
      Left = 785
      Top = 3
      Width = 117
      Height = 22
      Caption = '[ESC] Sair'
      TabOrder = 3
      OnClick = btnSairClick
    end
    object btnInformarMotivo: TBitBtnLocked
      Left = 472
      Top = 4
      Width = 145
      Height = 22
      Caption = '[F4] Informar motivo'
      TabOrder = 4
      OnClick = btnInformarMotivoClick
    end
  end
  object PnlOpcao: TPanel [5]
    Left = 0
    Top = 41
    Width = 907
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PnlOpcao'
    Padding.Top = 3
    Padding.Bottom = 2
    ShowCaption = False
    TabOrder = 5
    object lblInfOperacao: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 28
      Width = 901
      Height = 18
      Align = alClient
      Caption = 
        'A mercadoria ir'#225' retornar para estoque (reservado em garantia) e' +
        ' ficar'#225' dispon'#237'vel para ser reenviada ao fornecedor.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 644
      ExplicitHeight = 14
    end
    object pnlRadio: TPanel
      Left = 0
      Top = 3
      Width = 907
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlRadio'
      ShowCaption = False
      TabOrder = 0
      ExplicitTop = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 54
        Height = 22
        Margins.Top = 0
        Margins.Right = 5
        Align = alLeft
        Caption = 'Opera'#231#227'o: '
        Layout = tlCenter
        ExplicitHeight = 14
      end
      object rdbEntrada: TRadioButton
        AlignWithMargins = True
        Left = 65
        Top = 3
        Width = 157
        Height = 16
        Margins.Right = 5
        Align = alLeft
        Caption = 'Emitir Documento de Entrada'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rdbEntradaClick
        ExplicitLeft = 62
        ExplicitTop = 0
        ExplicitHeight = 22
      end
      object rdbCredito: TRadioButton
        AlignWithMargins = True
        Left = 230
        Top = 3
        Width = 187
        Height = 16
        Align = alLeft
        Caption = 'Baixar Retorno do Fornecedor'
        TabOrder = 1
        OnClick = rdbCreditoClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 120
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 632
    Top = 137
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    FilterOptions = [foCaseInsensitive]
    FieldDefs = <
      item
        Name = 'SELECIONADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DTAENV'
        DataType = ftDate
      end
      item
        Name = 'FORNECEDOR'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'NUMGAR'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODUNI'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'QTDBAI'
        DataType = ftFloat
      end
      item
        Name = 'NFENVI'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CLAFIS'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'PRECUS'
        DataType = ftFloat
      end
      item
        Name = 'UNITAR'
        DataType = ftFloat
      end
      item
        Name = 'QTDENV'
        DataType = ftFloat
      end
      item
        Name = 'VALITE'
        DataType = ftFloat
      end
      item
        Name = 'LOTSAI'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TABPRE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INCGAE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NUMENT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QTDREF'
        DataType = ftFloat
      end
      item
        Name = 'QTDRET'
        DataType = ftFloat
      end
      item
        Name = 'GAE_NUMENV'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'GAE_ESPENV'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'GAE_EMPENV'
        DataType = ftString
        Size = 3
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cdsDadosCalcFields
    Left = 632
    Top = 89
    object cdsDadosSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsDadosDTAENV: TDateField
      DisplayLabel = 'Data Envio'
      FieldName = 'DTAENV'
    end
    object cdsDadosFORNECEDOR: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'FORNECEDOR'
      Size = 7
    end
    object cdsDadosNUMGAR: TStringField
      Alignment = taCenter
      DisplayLabel = 'Num. Garantia'
      FieldName = 'NUMGAR'
      Size = 12
    end
    object cdsDadosCODITE: TStringField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsDadosDESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o Item'
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDadosCODUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'CODUNI'
      Size = 2
    end
    object cdsDadosQTDBAI: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Qtd Baixar'
      FieldName = 'QTDBAI'
      OnValidate = cdsDadosQTDBAIValidate
    end
    object cdsDadosNFENVI: TStringField
      FieldName = 'NFENVI'
    end
    object cdsDadosCLAFIS: TStringField
      FieldName = 'CLAFIS'
      Size = 4
    end
    object cdsDadosPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsDadosUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsDadosVALITE: TFloatField
      FieldName = 'VALITE'
    end
    object cdsDadosLOTSAI: TStringField
      FieldName = 'LOTSAI'
    end
    object cdsDadosTABPRE: TStringField
      FieldName = 'TABPRE'
      Size = 1
    end
    object cdsDadosINCGAE: TStringField
      FieldName = 'INCGAE'
    end
    object cdsDadosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDadosNUMENT: TStringField
      FieldName = 'NUMENT'
    end
    object cdsDadosQTDENV: TFloatField
      Alignment = taCenter
      FieldName = 'QTDENV'
    end
    object cdsDadosQTDREF: TFloatField
      FieldName = 'QTDREF'
    end
    object cdsDadosQTDRET: TFloatField
      FieldName = 'QTDRET'
    end
    object cdsDadosSALENV: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'SALENV'
    end
    object cdsDadosGAE_NUMENV: TStringField
      FieldName = 'GAE_NUMENV'
      Size = 12
    end
    object cdsDadosGAE_ESPENV: TStringField
      FieldName = 'GAE_ESPENV'
      Size = 2
    end
    object cdsDadosGAE_EMPENV: TStringField
      FieldName = 'GAE_EMPENV'
      Size = 3
    end
  end
end
