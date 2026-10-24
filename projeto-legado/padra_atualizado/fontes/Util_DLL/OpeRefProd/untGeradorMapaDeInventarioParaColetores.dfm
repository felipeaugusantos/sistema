inherited frmGeradorMapaDeInventarioParaColetores: TfrmGeradorMapaDeInventarioParaColetores
  Width = 1048
  Height = 768
  Caption = 'Gerador de Mapa de Invent'#225'rio'
  WindowState = wsMaximized
  ExplicitWidth = 1048
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1042
    ExplicitTop = 695
    ExplicitWidth = 1042
    inherited FlwBotoes: TFlowPanel
      Width = 1038
      ExplicitWidth = 1038
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 146
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 146
        Top = 0
        Width = 146
        Height = 22
        Caption = '[ F9 ] Marcar Todos'
        Enabled = False
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 292
        Top = 0
        Width = 146
        Height = 22
        Caption = '[ F8 ] Desmarcar Todos'
        Enabled = False
        TabOrder = 2
        OnClick = btnDesmarcarClick
      end
      object btnEspaco: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 146
        Height = 22
        Caption = '[ Espa'#231'o ] Marca/Desmarca'
        Enabled = False
        TabOrder = 3
        OnClick = btnEspacoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 962
      ExplicitLeft = 962
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1042
    ExplicitTop = 723
    ExplicitWidth = 1042
    inherited pnlNomeForm: TPanel
      Left = 871
      ExplicitLeft = 871
    end
    inherited pnlInfo: TPanel
      Width = 871
      ExplicitWidth = 871
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1042
    Height = 153
    Align = alTop
    TabOrder = 2
    object Label4: TLabel
      Left = 65
      Top = 60
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto.:'
    end
    object Label6: TLabel
      Left = 429
      Top = 13
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Localiza'#231#227'o F'#237'sica.:'
    end
    object Label7: TLabel
      Left = 499
      Top = 36
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Rua.:'
    end
    object Label8: TLabel
      Left = 489
      Top = 82
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Andar.:'
    end
    object Label9: TLabel
      Left = 488
      Top = 60
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pr'#233'dio.:'
    end
    object Label10: TLabel
      Left = 456
      Top = 105
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Apartamento.:'
    end
    object Label11: TLabel
      Left = 43
      Top = 82
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 48
      Top = 13
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 72
      Top = 105
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 36
      Top = 36
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblLocSep: TLabel
      Left = 4
      Top = 130
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Local de separa'#231#227'o: '
    end
    object edtApartamento: TEditFocus
      Left = 527
      Top = 102
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAndar: TEditFocus
      Left = 527
      Top = 79
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPredio: TEditFocus
      Left = 527
      Top = 56
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRua: TEditFocus
      Left = 527
      Top = 33
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFis: TEditFocus
      Left = 527
      Top = 10
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 110
      Top = 79
      Width = 57
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
      TabOrder = 3
      Text = ''
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 168
      Top = 79
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 110
      Top = 10
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 168
      Top = 10
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 17
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
      Left = 110
      Top = 102
      Width = 57
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
      Left = 168
      Top = 102
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 110
      Top = 56
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
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
      Left = 168
      Top = 56
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 110
      Top = 33
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCodDep: TEditFocus
      Left = 168
      Top = 33
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgSaldo: TRadioGroup
      Left = 631
      Top = 5
      Width = 203
      Height = 48
      Caption = 'Saldo Atual'
      Columns = 2
      Enabled = False
      ItemIndex = 2
      Items.Strings = (
        'Maior que zero'
        'Zero'
        'Todos'
        'Menor que zero')
      TabOrder = 11
    end
    object btnBusca: TBitBtnLocked
      Left = 920
      Top = 105
      Width = 112
      Height = 22
      Caption = '[ F5 ] Buscar'
      TabOrder = 15
      OnClick = btnBuscaClick
    end
    object rdgListagem: TRadioGroup
      Left = 632
      Top = 54
      Width = 201
      Height = 39
      Caption = 'Listagem por'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Produto'
        'Localiza'#231#227'o')
      TabOrder = 12
      OnClick = rdgListagemClick
    end
    object chkLocFisVazia: TCheckBox
      Left = 836
      Top = 13
      Width = 164
      Height = 14
      Caption = 'Mapear Localiza'#231#245'es Vazias'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 13
    end
    object chkExcluirItensSaldoReservado: TCheckBox
      Left = 836
      Top = 30
      Width = 196
      Height = 14
      Hint = '"Saldo reservado = reservado pedido de venda +'
      Caption = 'Excluir itens com saldo reservado'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
    end
    object btnHlpImp: TBitBtnLocked
      Left = 1020
      Top = 27
      Width = 20
      Height = 20
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      OnClick = btnHlpImpClick
    end
    object chkMovProgramada: TCheckBox
      Left = 836
      Top = 47
      Width = 235
      Height = 14
      Hint = '"Saldo reservado = reservado pedido de venda +'
      Caption = 'Excluir Movimenta'#231#227'o Programada'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 22
    end
    object chkApenasItensMapeados: TCheckBox
      Left = 836
      Top = 64
      Width = 235
      Height = 14
      Hint = '"Saldo reservado = reservado pedido de venda +'
      Caption = 'Inventariar apenas itens mapeados'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
    end
    object edtCodLocSep: TEditFocus
      Tag = 99
      Left = 110
      Top = 125
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 5
      OnKeyPress = edtCodLocSepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesLocSep: TEditFocus
      Left = 168
      Top = 125
      Width = 255
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 666
    Width = 1042
    Height = 29
    Align = alBottom
    TabOrder = 4
    object Label1: TLabel
      Left = 11
      Top = 10
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador Respons'#225'vel Coletor.:'
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 168
      Top = 3
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 226
      Top = 3
      Width = 300
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
  end
  object cxDados: TcxGridCitel [4]
    Left = 0
    Top = 153
    Width = 1042
    Height = 513
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      OnKeyDown = cxgDadosKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosColumn1: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARCAD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'M'
        Properties.ValueUnchecked = 'D'
        Width = 27
      end
      object cxgDadosColumn2: TcxGridDBColumn
        Caption = 'C'#243'd. Produto'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Width = 76
      end
      object cxgDadosColumn3: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 305
      end
      object cxgDadosColumn4: TcxGridDBColumn
        Caption = 'Loc. Fisica'
        DataBinding.FieldName = 'LOT_LOCFIS'
        Options.Editing = False
        Width = 183
      end
      object cxgDadosColumn5: TcxGridDBColumn
        Caption = 'Numero do Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Options.Editing = False
        Width = 216
      end
      object cxgDadosColumn6: TcxGridDBColumn
        Caption = 'Saldo Lote'
        DataBinding.FieldName = 'SALDO_CALC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object cxgDadosColumn7: TcxGridDBColumn
        Caption = 'Saldo Reservado'
        DataBinding.FieldName = 'SALRES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 96
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object dtsDados: TDataSource
    Left = 500
    Top = 372
  end
end
