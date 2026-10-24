inherited frmAlteraVendedorMarca: TfrmAlteraVendedorMarca
  Width = 1102
  Height = 863
  Caption = 'Altera'#231#227'o Global de Vendedores e Marcas - Clientes'
  WindowState = wsMaximized
  ExplicitWidth = 1102
  ExplicitHeight = 863
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 790
    Width = 1096
    TabOrder = 2
    ExplicitTop = 790
    ExplicitWidth = 1096
    inherited FlwBotoes: TFlowPanel
      Width = 1092
      ExplicitWidth = 1092
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnImportarPlanilha: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 22
        Caption = '&Importar Planilha'
        TabOrder = 1
        OnClick = btnImportarPlanilhaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 984
      Width = 106
      Caption = 'Cancelar/&Sair'
      ExplicitLeft = 984
      ExplicitWidth = 106
    end
  end
  inherited pnlStatus: TPanel
    Top = 818
    Width = 1096
    TabOrder = 3
    ExplicitTop = 818
    ExplicitWidth = 1096
    inherited pnlNomeForm: TPanel
      Left = 925
      ExplicitLeft = 925
    end
    inherited pnlInfo: TPanel
      Width = 925
      ExplicitWidth = 925
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1096
    Height = 177
    Align = alTop
    TabOrder = 0
    object Label19: TLabel
      Left = 43
      Top = 12
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label3: TLabel
      Left = 42
      Top = 59
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lbl1: TLabel
      Left = 42
      Top = 82
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object Label4: TLabel
      Left = 39
      Top = 104
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label6: TLabel
      Left = 153
      Top = 104
      Width = 9
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'a'
    end
    object Label2: TLabel
      Left = 2
      Top = 128
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor atual:'
    end
    object ColorLabel1: TColorLabel
      Left = 659
      Top = 11
      Width = 116
      Height = 14
      Caption = '(A)tivo (I)nativo (T)odos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label1: TLabel
      Left = 578
      Top = 11
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Status:'
    end
    object Label58: TLabel
      Left = 6
      Top = 35
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rede de Lojas:'
    end
    object lbl12: TLabel
      Left = 553
      Top = 81
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Regi'#227'o:'
    end
    object Label40: TLabel
      Left = 564
      Top = 36
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label5: TLabel
      Left = 370
      Top = 103
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Filtrar por data de:'
    end
    object Label11: TLabel
      Left = 21
      Top = 151
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca atual:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 577
      Top = 59
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 83
      Top = 8
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 149
      Top = 8
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 83
      Top = 54
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 7
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 149
      Top = 54
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 83
      Top = 77
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 11
      OnExit = edtCodRegExit
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomReg: TEditFocus
      Left = 149
      Top = 77
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdbCadastro: TRadioButton
      Left = 464
      Top = 103
      Width = 74
      Height = 17
      Caption = 'Cadastro'
      Checked = True
      TabOrder = 17
      TabStop = True
    end
    object rdbUtlVnd: TRadioButton
      Left = 544
      Top = 103
      Width = 87
      Height = 17
      Caption = #218'ltima venda'
      TabOrder = 18
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 83
      Top = 100
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
      TabOrder = 15
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 168
      Top = 100
      Width = 66
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
      TabOrder = 16
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodVenAtual: TEditFocus
      Tag = 99
      Left = 83
      Top = 123
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 19
      OnExit = edtCodVenAtualExit
      OnKeyPress = edtCodVenAtualKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVenAtual: TEditFocus
      Left = 149
      Top = 123
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtStatus: TEditFocus
      Tag = 99
      Left = 618
      Top = 8
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtDesRed: TEditFocus
      Left = 149
      Top = 31
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesSub: TEditFocus
      Left = 684
      Top = 77
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesAti: TEditFocus
      Left = 684
      Top = 31
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 83
      Top = 31
      Width = 65
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 618
      Top = 31
      Width = 65
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodAtiExit
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodSub: TEditFocus
      Tag = 99
      Left = 618
      Top = 77
      Width = 65
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 13
      OnExit = edtCodSubExit
      OnKeyPress = edtCodSubKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtMarcaAtual: TEditFocus
      Tag = 99
      Left = 83
      Top = 147
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 21
      OnExit = edtMarcaAtualExit
      OnKeyPress = edtMarcaAtualKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarcaAtual: TEditFocus
      Left = 149
      Top = 147
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 22
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 618
      Top = 54
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 9
      OnExit = edtEstadoExit
      OnKeyPress = edtEstadoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtDesEstado: TEditFocus
      Left = 684
      Top = 54
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 177
    Width = 1096
    Height = 136
    Align = alTop
    TabOrder = 1
    object Label7: TLabel
      Left = 1
      Top = 1
      Width = 1094
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Dados para altera'#231#227'o'
      Layout = tlCenter
      ExplicitWidth = 104
    end
    object Label8: TLabel
      Left = 59
      Top = 31
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Opera'#231#227'o:'
    end
    object lblVendedor: TLabel
      Left = 20
      Top = 56
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor a incluir:'
    end
    object lblMarca: TLabel
      Left = 39
      Top = 79
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca a incluir:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdbIncluir: TRadioButton
      Left = 115
      Top = 31
      Width = 140
      Height = 17
      Caption = 'Incluir Vendedor / Marca'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdbIncluirClick
    end
    object rdbExcluir: TRadioButton
      Left = 271
      Top = 31
      Width = 163
      Height = 17
      Caption = 'Excluir Vendedor / Marca'
      TabOrder = 1
      OnClick = rdbExcluirClick
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 115
      Top = 51
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 181
      Top = 51
      Width = 390
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
    object edtMarca: TEditFocus
      Tag = 99
      Left = 115
      Top = 75
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 4
      OnExit = edtMarcaExit
      OnKeyPress = edtMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMarca: TEditFocus
      Left = 181
      Top = 75
      Width = 390
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregar: TBitBtnLocked
      Left = 848
      Top = 105
      Width = 226
      Height = 25
      Caption = '[ F8 ] Carregar registros para altera'#231#227'o'
      TabOrder = 6
      OnClick = btnCarregarClick
    end
  end
  object grdDados: TcxGridCitel [4]
    Left = 0
    Top = 313
    Width = 1096
    Height = 477
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdDadosTvCustomDrawCell
      DataController.DataSource = dsDados
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
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosTvCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        Width = 80
      end
      object grdDadosTvNOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 250
      end
      object grdDadosTvCODOPE: TcxGridDBColumn
        Caption = 'C'#243'd. Vendedor'
        DataBinding.FieldName = 'CODOPE'
        Width = 80
      end
      object grdDadosTvNOMOPE: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'NOMOPE'
        Width = 250
      end
      object grdDadosTvCODMAR: TcxGridDBColumn
        Caption = 'C'#243'd. Marca'
        DataBinding.FieldName = 'CODMAR'
        Width = 80
      end
      object grdDadosTvDESMAR: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Marca'
        DataBinding.FieldName = 'DESMAR'
        Width = 250
      end
      object grdDadosTvOPERAC: TcxGridDBColumn
        Caption = 'Opera'#231#227'o'
        DataBinding.FieldName = 'OPERAC'
        Width = 70
      end
    end
    object grdDadosLvl: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object dsDados: TDataSource
    Left = 448
    Top = 176
  end
end
