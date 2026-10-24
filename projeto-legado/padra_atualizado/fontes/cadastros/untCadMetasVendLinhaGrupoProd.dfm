inherited frmCadMetasVendLinhaGrupoProd: TfrmCadMetasVendLinhaGrupoProd
  Width = 908
  Height = 565
  Caption = 'Metas de Vendedores por Linha/Grupo e Unidade do Produto'
  OnClose = FormClose
  ExplicitWidth = 908
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 482
    Width = 892
    TabOrder = 1
    ExplicitTop = 482
    ExplicitWidth = 892
    inherited FlwBotoes: TFlowPanel
      Width = 888
      TabOrder = 2
      ExplicitWidth = 888
    end
    inherited btnSair: TBitBtnLocked
      Left = 803
      TabOrder = 3
      ExplicitLeft = 803
    end
    object btnCopiarMetas: TBitBtnLocked
      Left = 110
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F11 ] Copiar Metas'
      TabOrder = 1
      OnClick = btnCopiarMetasClick
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlHeader: TPanel
    Width = 892
    Height = 203
    TabOrder = 0
    ExplicitWidth = 892
    ExplicitHeight = 203
    object pnlDados: TPanel
      Left = 0
      Top = 89
      Width = 892
      Height = 112
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblLinhaGrupo: TLabel
        Left = 53
        Top = 13
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha/Grupo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 73
        Top = 37
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 479
        Top = 35
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o:'
      end
      object Label12: TLabel
        Left = 346
        Top = 37
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object ColorLabel27: TColorLabel
        Left = 530
        Top = 84
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label28: TLabel
        Left = 402
        Top = 84
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha/Grupo chave?'
      end
      object Label7: TLabel
        Left = 576
        Top = 35
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object Label8: TLabel
        Left = 56
        Top = 59
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label9: TLabel
        Left = 16
        Top = 84
        Width = 287
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor M'#237'nimo de Faturamento para Pagamento da Comiss'#227'o:'
      end
      object edtUnidade: TEditFocus
        Tag = 99
        Left = 117
        Top = 32
        Width = 61
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnExit = edtUnidadeExit
        OnKeyPress = edtUnidadeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtQuantidade: TEditFocus
        Tag = 99
        Left = 406
        Top = 32
        Width = 65
        Height = 22
        Alignment = taRightJustify
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
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object mskLinhaGrupo: TMaskEditFocus
        Left = 117
        Top = 8
        Width = 61
        Height = 22
        EditMask = '999.999;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 0
        Text = ''
        OnExit = mskLinhaGrupoExit
        OnKeyPress = mskLinhaGrupoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGrupo: TEditFocus
        Left = 181
        Top = 8
        Width = 407
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLinhaGrupoChave: TEditFocus
        Tag = 99
        Left = 504
        Top = 81
        Width = 20
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtComissao: TEditFocus
        Tag = 99
        Left = 530
        Top = 32
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDesUni: TEditFocus
        Left = 181
        Top = 32
        Width = 159
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFornecedor: TEditFocus
        Tag = 99
        Left = 117
        Top = 56
        Width = 61
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 5
        OnExit = edtCodFornecedorExit
        OnKeyPress = edtCodFornecedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomeFornecedor: TEditFocus
        Left = 181
        Top = 56
        Width = 407
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorMinimoParaComissao: TEditFocus
        Tag = 99
        Left = 309
        Top = 81
        Width = 87
        Height = 22
        Alignment = taRightJustify
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object pnlMesAnoOrigem: TPanel
        Left = 741
        Top = 1
        Width = 150
        Height = 110
        Align = alRight
        Color = 16770261
        ParentBackground = False
        TabOrder = 10
        Visible = False
        object Label4: TLabel
          Left = 5
          Top = 22
          Width = 94
          Height = 14
          AutoSize = False
          Caption = 'Per'#237'odo de Origem:'
        end
        object mskDtaOrigem: TMaskEditFocus
          Tag = 99
          Left = 96
          Top = 13
          Width = 53
          Height = 22
          EditMask = '99/9999'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 0
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
    object pnlFiltro: TPanel
      Left = 0
      Top = 0
      Width = 892
      Height = 89
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 12
        Top = 41
        Width = 55
        Height = 14
        Caption = 'Empresa: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 467
        Top = 69
        Width = 60
        Height = 14
        Caption = 'Meta M'#234's: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 17
        Top = 16
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblTipOpe: TLabel
        Left = 594
        Top = 12
        Width = 60
        Height = 14
        Caption = 'Sub-gerente'
        Font.Charset = ANSI_CHARSET
        Font.Color = 185
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label10: TLabel
        Left = 21
        Top = 68
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Meta por:'
      end
      object ColorLabel1: TColorLabel
        Left = 93
        Top = 68
        Width = 203
        Height = 14
        Caption = '(P)ercentual - %  (V)alor por Unidade - R$'
        CorDestaque = clRed
      end
      object edtNomEmp: TEditFocus
        Tag = 99
        Left = 124
        Top = 37
        Width = 464
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 3
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 67
        Top = 37
        Width = 54
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object mskDtaAtual: TMaskEditFocus
        Tag = 99
        Left = 534
        Top = 65
        Width = 54
        Height = 22
        EditMask = '99/9999'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        ParentFont = False
        TabOrder = 5
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 67
        Top = 9
        Width = 54
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
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
        Left = 124
        Top = 9
        Width = 464
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
      object edtMetaPor: TEditFocus
        Tag = 99
        Left = 67
        Top = 65
        Width = 20
        Height = 22
        Alignment = taCenter
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
        OnExit = edtMetaPorExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 465
    Width = 892
    Height = 17
    ExplicitTop = 465
    ExplicitWidth = 892
    ExplicitHeight = 17
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 244
    Width = 892
    Height = 221
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'LINHA_GRUPO'
        Title.Caption = 'Linha/ Grupo'
        Width = 199
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNI_DESUNI'
        Title.Caption = 'Unidade'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_DESCRI'
        Title.Caption = 'Fornecedor'
        Width = 187
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLG_QTDVEN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLG_PERCOM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Comiss'#227'o'
        Width = 65
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VLG_TIPMET'
        Title.Caption = 'Meta Por'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLG_VLRMIN'
        Title.Caption = 'Valor M'#237'nimo de Faturamento '
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLG_CHAVE_'
        Title.Caption = 'Chave'
        Width = 39
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 203
    Width = 892
    Height = 41
    ExplicitTop = 203
    ExplicitWidth = 892
    ExplicitHeight = 41
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 892
    TabOrder = 2
    ExplicitTop = 510
    ExplicitWidth = 892
    inherited pnlNomeForm: TPanel
      Left = 721
      ExplicitLeft = 721
    end
    inherited pnlInfo: TPanel
      Width = 721
      ExplicitWidth = 721
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 128
  end
  inherited qryConsulta: TUniQuery
    Left = 576
    Top = 72
    object qryConsultaVLG_CODVEN: TStringField
      FieldName = 'VLG_CODVEN'
      Size = 3
    end
    object qryConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryConsultaVLG_CODEMP: TStringField
      FieldName = 'VLG_CODEMP'
      Size = 3
    end
    object qryConsultaVLG_MESANO: TStringField
      FieldName = 'VLG_MESANO'
      Size = 6
    end
    object qryConsultaVLG_CODUNI: TStringField
      FieldName = 'VLG_CODUNI'
      Size = 2
    end
    object qryConsultaVLG_CODGRU: TStringField
      FieldName = 'VLG_CODGRU'
      Size = 6
    end
    object qryConsultaVLG_QTDVEN: TFloatField
      FieldName = 'VLG_QTDVEN'
    end
    object qryConsultaVLG_PERCOM: TFloatField
      FieldName = 'VLG_PERCOM'
    end
    object qryConsultaVLG_CHAVE_: TStringField
      FieldName = 'VLG_CHAVE_'
      Size = 1
    end
    object qryConsultaLINHA_GRUPO: TStringField
      FieldKind = fkLookup
      FieldName = 'LINHA_GRUPO'
      LookupDataSet = qryCadGru
      LookupKeyFields = 'GRU_CODGRU'
      LookupResultField = 'LINHA_GRUPO'
      KeyFields = 'VLG_CODGRU'
      Size = 76
      Lookup = True
    end
    object qryConsultaUNI_DESUNI: TStringField
      FieldKind = fkLookup
      FieldName = 'UNI_DESUNI'
      LookupDataSet = qryCadUni
      LookupKeyFields = 'UNI_CODUNI'
      LookupResultField = 'UNI_DESUNI'
      KeyFields = 'VLG_CODUNI'
      Size = 25
      Lookup = True
    end
    object qryConsultaGRUPO: TStringField
      FieldKind = fkLookup
      FieldName = 'GRUPO'
      LookupDataSet = qryCadGru
      LookupKeyFields = 'GRU_CODGRU'
      LookupResultField = 'GRU_DESGRU'
      KeyFields = 'VLG_CODGRU'
      Size = 80
      Lookup = True
    end
    object qryConsultaVLG_CODFOR: TStringField
      FieldName = 'VLG_CODFOR'
      Size = 8
    end
    object qryConsultaVLG_VLRMINVLG_VLRMIN: TFloatField
      FieldName = 'VLG_VLRMIN'
    end
    object qryConsultaVLG_TIPMET: TStringField
      FieldName = 'VLG_TIPMET'
    end
    object qryConsultaFOR_DESCRI: TStringField
      FieldKind = fkLookup
      FieldName = 'FOR_DESCRI'
      LookupDataSet = qryCadFor
      LookupKeyFields = 'FOR_CODFOR'
      LookupResultField = 'FOR_DESCRI'
      KeyFields = 'VLG_CODFOR'
      Lookup = True
    end
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 608
    Top = 72
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterOpen = cdsConsultaAfterOpen
    Left = 640
    Top = 72
    object cdsConsultaVLG_CODVEN: TStringField
      FieldName = 'VLG_CODVEN'
      Size = 3
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Size = 50
    end
    object cdsConsultaVLG_CODEMP: TStringField
      FieldName = 'VLG_CODEMP'
      Size = 3
    end
    object cdsConsultaVLG_MESANO: TStringField
      FieldName = 'VLG_MESANO'
      Size = 6
    end
    object cdsConsultaVLG_CODUNI: TStringField
      FieldName = 'VLG_CODUNI'
      Size = 2
    end
    object cdsConsultaVLG_CODGRU: TStringField
      FieldName = 'VLG_CODGRU'
      Size = 6
    end
    object cdsConsultaVLG_QTDVEN: TFloatField
      FieldName = 'VLG_QTDVEN'
    end
    object cdsConsultaVLG_PERCOM: TFloatField
      FieldName = 'VLG_PERCOM'
    end
    object cdsConsultaVLG_CHAVE_: TStringField
      FieldName = 'VLG_CHAVE_'
      Size = 1
    end
    object cdsConsultaLINHA_GRUPO: TStringField
      FieldKind = fkLookup
      FieldName = 'LINHA_GRUPO'
      LookupDataSet = qryCadGru
      LookupKeyFields = 'GRU_CODGRU'
      LookupResultField = 'LINHA_GRUPO'
      KeyFields = 'VLG_CODGRU'
      Size = 76
      Lookup = True
    end
    object cdsConsultaUNI_DESUNI: TStringField
      FieldKind = fkLookup
      FieldName = 'UNI_DESUNI'
      LookupDataSet = qryCadUni
      LookupKeyFields = 'UNI_CODUNI'
      LookupResultField = 'UNI_DESUNI'
      KeyFields = 'VLG_CODUNI'
      Lookup = True
    end
    object cdsConsultaGRUPO: TStringField
      FieldKind = fkLookup
      FieldName = 'GRUPO'
      LookupDataSet = qryCadGru
      LookupKeyFields = 'GRU_CODGRU'
      LookupResultField = 'GRU_DESGRU'
      KeyFields = 'VLG_CODGRU'
      Size = 80
      Lookup = True
    end
    object cdsConsultaVLG_CODFOR: TStringField
      FieldName = 'VLG_CODFOR'
    end
    object cdsConsultaVLG_VLRMIN: TFloatField
      FieldName = 'VLG_VLRMIN'
    end
    object cdsConsultaVLG_TIPMET: TStringField
      FieldName = 'VLG_TIPMET'
    end
    object cdsConsultaFOR_DESCRI: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'FOR_DESCRI'
      LookupDataSet = qryCadFor
      LookupKeyFields = 'FOR_CODFOR'
      LookupResultField = 'FOR_DESCRI'
      KeyFields = 'VLG_CODFOR'
      Size = 40
      Lookup = True
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 672
    Top = 72
  end
  object qryCadGru: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 456
    Top = 136
    object qryCadGruGRU_CODGRU: TStringField
      FieldName = 'GRU_CODGRU'
      Size = 6
    end
    object qryCadGruGRU_DESGRU: TStringField
      FieldName = 'GRU_DESGRU'
      Size = 70
    end
    object qryCadGruLINHA_GRUPO: TStringField
      FieldName = 'LINHA_GRUPO'
      Size = 100
    end
  end
  object qryCadUni: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 456
    Top = 184
    object qryCadUniUNI_CODUNI: TStringField
      FieldName = 'UNI_CODUNI'
      Size = 2
    end
    object qryCadUniUNI_DESUNI: TStringField
      FieldName = 'UNI_DESUNI'
      Size = 25
    end
  end
  object qryCadFor: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 456
    Top = 240
    object StringField1: TStringField
      FieldName = 'FOR_CODFOR'
      Size = 8
    end
    object StringField2: TStringField
      FieldName = 'FOR_DESCRI'
      Size = 25
    end
  end
end
