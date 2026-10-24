inherited frmLiberacaoPedidosExternos: TfrmLiberacaoPedidosExternos
  Width = 1024
  Height = 768
  Caption = 'Libera'#231#227'o de Pedidos Externos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 667
    Width = 1018
    Height = 56
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 667
    ExplicitWidth = 1018
    ExplicitHeight = 56
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 54
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 1016
      ExplicitHeight = 54
      object btnSeleciona: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 109
        Height = 26
        Align = alLeft
        Caption = '[ENTER] Seleciona'
        TabOrder = 0
        OnClick = btnSelecionaClick
      end
      object btnAtualizar: TBitBtnLocked
        Left = 109
        Top = 0
        Width = 88
        Height = 26
        Align = alLeft
        Caption = '[F2] Atualizar'
        TabOrder = 1
        OnClick = btnAtualizarClick
      end
      object btnReimpressao: TBitBtnLocked
        Left = 197
        Top = 0
        Width = 100
        Height = 26
        Align = alLeft
        Caption = '[F9] Reimpress'#227'o'
        TabOrder = 2
        OnClick = btnReimpressaoClick
      end
      object btnExpandirTodos: TBitBtnLocked
        Left = 297
        Top = 0
        Width = 125
        Height = 26
        Align = alLeft
        Caption = '[F11] [+] Expandir Todos'
        TabOrder = 3
        OnClick = btnExpandirTodosClick
      end
      object btnRetrairTodos: TBitBtnLocked
        Left = 422
        Top = 0
        Width = 119
        Height = 26
        Align = alLeft
        Caption = '[F12] [-] Retrair Todos'
        TabOrder = 4
        OnClick = btnRetrairTodosClick
      end
      object btnPadrao: TBitBtnLocked
        Left = 541
        Top = 0
        Width = 114
        Height = 26
        Caption = '&Restaurar Padr'#227'o'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 5
        OnClick = btnPadraoClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 655
        Top = 0
        Width = 115
        Height = 26
        Align = alLeft
        Caption = '[F7] Marcar Todos'
        TabOrder = 6
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 770
        Top = 0
        Width = 115
        Height = 26
        Align = alLeft
        Caption = '[F8] Desmarcar Todos'
        TabOrder = 7
        OnClick = btnDesmarcarTodosClick
      end
      object btnRelPedExternos: TBitBtnLocked
        Left = 0
        Top = 26
        Width = 265
        Height = 26
        Align = alLeft
        Caption = 'Pedidos Externos sem Saldo para Transfer'#234'ncia'
        TabOrder = 8
        OnClick = btnRelPedExternosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 892
      Top = 29
      Width = 125
      Height = 26
      ExplicitLeft = 892
      ExplicitTop = 29
      ExplicitWidth = 125
      ExplicitHeight = 26
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 0
    ExplicitTop = 723
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
  object pnlRodape: TPanel [2]
    Left = 0
    Top = 635
    Width = 1018
    Height = 32
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    object shpLiberado: TShape
      Left = 108
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clGreen
      Pen.Mode = pmMask
    end
    object lblLiberado: TLabel
      Left = 129
      Top = 9
      Width = 42
      Height = 14
      Caption = 'Liberado'
    end
    object shpBloqueado: TShape
      Left = 17
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clRed
      Pen.Mode = pmMask
    end
    object lblBloqueado: TLabel
      Left = 38
      Top = 9
      Width = 51
      Height = 14
      Caption = 'Bloqueado'
    end
  end
  object cxgPedidos: TcxGrid [3]
    Left = 0
    Top = 53
    Width = 1018
    Height = 582
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgPedidosDados: TcxGridDBTableView
      OnKeyDown = cxgPedidosDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      FilterBox.CustomizeDialog = False
      OnCustomDrawCell = cxgPedidosDadosCustomDrawCell
      DataController.DataSource = dtsPedidos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar os pedidos'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.MultiSelect = True
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' pedidos para serem exibidos'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxgPedidosDadosFGO_TIPPED: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'FGO_TIPPED'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 25
      end
      object cxgPedidosDadosBONIFICA: TcxGridDBColumn
        Caption = 'Bonif.'
        DataBinding.FieldName = 'BONIFICA'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 39
      end
      object cxgPedidosDadosDESTINO: TcxGridDBColumn
        Caption = 'Destino'
        DataBinding.FieldName = 'DESTINO'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 53
      end
      object cxgPedidosDadosFGO_NUMPOK: TcxGridDBColumn
        Caption = 'Pedido Site/Tablet'
        DataBinding.FieldName = 'PEDIDOSITE'
        Options.AutoWidthSizable = False
        Width = 135
      end
      object cxgPedidosDadosFGO_NUMDOC: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Width = 90
      end
      object cxgPedidosDadosFGO_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FGO_CODEMP'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 70
      end
      object cxgPedidosDadosFGO_EMP_CD: TcxGridDBColumn
        Caption = 'Emp.Destino'
        DataBinding.FieldName = 'FGO_EMP_CD'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 75
      end
      object cxgPedidosDadosFGO_DTAENT: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o'
        DataBinding.FieldName = 'FGO_DTAENT'
        SortIndex = 0
        SortOrder = soAscending
        Width = 79
      end
      object cxgPedidosDadosFGO_HORENT: TcxGridDBColumn
        Caption = 'Hr. Emiss'#227'o'
        DataBinding.FieldName = 'FGO_HORENT'
        SortIndex = 1
        SortOrder = soAscending
        Width = 79
      end
      object cxgPedidosDadosFGO_PREVIS: TcxGridDBColumn
        Caption = 'Dt. Previs'#227'o'
        DataBinding.FieldName = 'FGO_PREVIS'
        Width = 79
      end
      object cxgPedidosDadosFGO_C_G_C_: TcxGridDBColumn
        Caption = 'CNPJ / CPF'
        DataBinding.FieldName = 'FGO_C_G_C_'
        Width = 121
      end
      object cxgPedidosDadosFGO_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'FGO_NOMCLI'
        Width = 221
      end
      object cxgPedidosDadosFGO_TIPFRE: TcxGridDBColumn
        Caption = 'Tp. Frete'
        DataBinding.FieldName = 'FGO_TIPFRE'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 60
      end
      object cxgPedidosDadosFGO_TOTFRE: TcxGridDBColumn
        Caption = 'Vlr. Frete'
        DataBinding.FieldName = 'FGO_TOTFRE'
        Width = 61
      end
      object cxgPedidosDadosTRANSPORTADORA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'TRANSPORTADORA'
        Width = 85
      end
      object cxgPedidosDadosDIGITADOR: TcxGridDBColumn
        Caption = 'Digitador'
        DataBinding.FieldName = 'DIGITADOR'
        Width = 171
      end
      object cxgPedidosDadosVENDEDOR: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDEDOR'
        Width = 190
      end
      object cxgPedidosDadosDESCRI: TcxGridDBColumn
        Caption = 'Departamento do Vendedor'
        DataBinding.FieldName = 'DEP_DESCRI'
        Width = 140
      end
      object cxgPedidosDadosDESFPG: TcxGridDBColumn
        Caption = 'Forma de Pagamento'
        DataBinding.FieldName = 'DESFPG'
        Width = 136
      end
      object cxgPedidosDadosFGO_CONPAG: TcxGridDBColumn
        Caption = 'Condi'#231#227'o de Pagamento'
        DataBinding.FieldName = 'FGO_CONPAG'
        Width = 132
      end
      object cxgPedidosDadosTIPATE: TcxGridDBColumn
        Caption = 'Tipo de Atendimento'
        DataBinding.FieldName = 'TIPATE'
        Width = 136
      end
      object cxgPedidosDadosFGO_VLRCON: TcxGridDBColumn
        Caption = 'Vlr. Pedido'
        DataBinding.FieldName = 'FGO_VLRCON'
        Width = 104
      end
      object cxgPedidosDadosLEX_DTALIB: TcxGridDBColumn
        Caption = 'Dt. Libera'#231#227'o'
        DataBinding.FieldName = 'LEX_DTALIB'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 121
      end
      object cxgPedidosDadosLEX_HRALIB: TcxGridDBColumn
        Caption = 'Hr. Libera'#231#227'o'
        DataBinding.FieldName = 'LEX_HRALIB'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 109
      end
      object cxgPedidosDadosLEX_OPELIB: TcxGridDBColumn
        Caption = 'Ope. Libera'#231#227'o'
        DataBinding.FieldName = 'LEX_OPELIB'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 114
      end
      object cxgPedidosDadosFGO_TIPOPE: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_TIPOPE'
        Visible = False
      end
      object cxgPedidosDadosVALFUT: TcxGridDBColumn
        DataBinding.FieldName = 'VALFUT'
        Visible = False
      end
      object cxgPedidosDadosVALENT: TcxGridDBColumn
        DataBinding.FieldName = 'VALENT'
        Visible = False
      end
      object cxgPedidosDadosVALRET: TcxGridDBColumn
        DataBinding.FieldName = 'VALRET'
        Visible = False
      end
      object cxgPedidosDadosFGO_LIBERA: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_LIBERA'
        Visible = False
      end
      object cxgPedidosDadosFGO_LIBCOM: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_LIBCOM'
        Visible = False
      end
      object cxgPedidosDadosDESOCO: TcxGridDBColumn
        Caption = 'Ocorr'#234'ncia'
        DataBinding.FieldName = 'DESOCO'
        Width = 128
      end
      object cxgPedidosDadosCLILOJ: TcxGridDBColumn
        Caption = 'Cliente na Loja?'
        DataBinding.FieldName = 'CLILOJ'
        Width = 90
      end
      object cxgPedidosDadosLEX_LIBPOK: TcxGridDBColumn
        DataBinding.FieldName = 'LEX_LIBPOK'
        Visible = False
      end
    end
    object cxgPedidosMotivos: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsMotivos
      DataController.DetailKeyFieldNames = 'LEX_NUMDOC;LEX_ESPDOC;LEX_CODEMP'
      DataController.KeyFieldNames = 'LEX_NUMDOC;LEX_ESPDOC;LEX_CODEMP'
      DataController.MasterKeyFieldNames = 'FGO_NUMDOC;FGO_ESPDOC;FGO_CODEMP'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      object cxgPedidosMotivosLEX_MOTLIB: TcxGridDBColumn
        Caption = 'Libera'#231#227'o'
        DataBinding.FieldName = 'LEX_MOTLIB'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        Width = 300
      end
      object cxgPedidosMotivosLEX_MOTBLO: TcxGridDBColumn
        Caption = 'Bloqueio'
        DataBinding.FieldName = 'LEX_MOTBLO'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.ScrollBars = ssVertical
        Width = 300
      end
    end
    object cxgPedidosNivel: TcxGridLevel
      GridView = cxgPedidosDados
      object cxgPedidosNivelMotivos: TcxGridLevel
        GridView = cxgPedidosMotivos
      end
    end
  end
  object pnlDiversos: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    ShowCaption = False
    TabOrder = 3
    object lblMotivoBloqueio: TLabel
      Left = 391
      Top = 33
      Width = 93
      Height = 14
      Caption = 'Motivo do Bloqueio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProdutoPedido: TLabel
      Left = 394
      Top = 10
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto do pedido:'
    end
    object rdgStatus: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 378
      Height = 44
      Caption = 'Pedidos'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        '&Bloqueados'
        '&Liberados'
        '&Todos')
      TabOrder = 0
      OnClick = rdgStatusClick
    end
    object edtMotivoBloqueio: TEditFocus
      Tag = 99
      Left = 486
      Top = 29
      Width = 332
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 486
      Top = 6
      Width = 71
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 558
      Top = 6
      Width = 409
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 84
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 88
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 156
    Top = 132
  end
  object qryPedidos: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 732
    Top = 424
  end
  object dspPedidos: TUniDataSetProvider
    DataSet = qryPedidos
    Options = [poDisableInserts, poDisableEdits, poDisableDeletes]
    Left = 668
    Top = 424
  end
  object cdsPedidos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    Left = 604
    Top = 424
  end
  object dtsPedidos: TDataSource
    DataSet = cdsPedidos
    Left = 540
    Top = 424
  end
  object dtsMotivos: TDataSource
    DataSet = cdsMotivos
    Left = 540
    Top = 480
  end
  object cdsMotivos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 604
    Top = 480
    object cdsMotivosLEX_NUMDOC: TStringField
      FieldName = 'LEX_NUMDOC'
      Size = 12
    end
    object cdsMotivosLEX_ESPDOC: TStringField
      FieldName = 'LEX_ESPDOC'
      Size = 2
    end
    object cdsMotivosLEX_CODEMP: TStringField
      FieldName = 'LEX_CODEMP'
      Size = 3
    end
    object cdsMotivosLEX_OPELIB: TStringField
      FieldName = 'LEX_OPELIB'
    end
    object cdsMotivosLEX_MOTLIB: TMemoField
      FieldName = 'LEX_MOTLIB'
      BlobType = ftMemo
    end
    object cdsMotivosLEX_LIBPOK: TStringField
      FieldName = 'LEX_LIBPOK'
      Size = 1
    end
    object cdsMotivosLEX_OPEBLO: TStringField
      FieldName = 'LEX_OPEBLO'
      Size = 3
    end
    object cdsMotivosLEX_MOTBLO: TMemoField
      FieldName = 'LEX_MOTBLO'
      BlobType = ftMemo
    end
  end
end
