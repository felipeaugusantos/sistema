inherited frmOrdProAtualizaPrecosFiltros: TfrmOrdProAtualizaPrecosFiltros
  Width = 500
  Height = 396
  Caption = 'Estruturas - Atualiza'#231#227'o de Pre'#231'os - Filtros'
  ExplicitWidth = 500
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 325
    Width = 494
    TabOrder = 3
    ExplicitTop = 325
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Width = 490
      ExplicitWidth = 490
    end
    inherited btnSair: TBitBtnLocked
      Left = 411
      ExplicitLeft = 411
    end
  end
  inherited pnlStatus: TPanel
    Top = 351
    Width = 494
    TabOrder = 4
    ExplicitTop = 351
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
      object shpMultSel: TShape
        Left = 307
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        Visible = False
      end
    end
  end
  object GroupBox1: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 494
    Height = 71
    Align = alTop
    Padding.Left = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    StyleElements = [seFont, seBorder]
    object Label2: TLabel
      Left = 7
      Top = 16
      Width = 480
      Height = 28
      Align = alTop
      Caption = 
        'Esta rotina atualiza o pre'#231'o de custo dos produtos estrutura, so' +
        'mando o pre'#231'o de custo dos seus sub-produtos.'
      WordWrap = True
      ExplicitWidth = 476
    end
    object rdgCalculo: TRadioGroup
      Left = 102
      Top = 31
      Width = 371
      Height = 36
      Caption = 'Deseja recalcular:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Venda'
        'Margem')
      TabOrder = 1
    end
    object chkApenasExibir: TCheckBox
      Left = 208
      Top = 30
      Width = 91
      Height = 17
      Caption = 'Apenas exibir'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 71
    Width = 494
    Height = 128
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentColor = True
    TabOrder = 1
    object grpProdutoAcabado: TGroupBox
      Left = 5
      Top = 5
      Width = 484
      Height = 118
      Align = alClient
      Caption = 'Produtos Acabados'
      TabOrder = 0
      object Label9: TLabel
        Left = 37
        Top = 24
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
      object Label10: TLabel
        Left = 41
        Top = 70
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
      object Label11: TLabel
        Left = 66
        Top = 93
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
      object Label1: TLabel
        Left = 397
        Top = 95
        Width = 27
        Height = 14
        Caption = 'Unid.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 59
        Top = 49
        Width = 43
        Height = 14
        Caption = 'Produto.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtLinGruProAca: TMaskEditFocus
        Tag = 99
        Left = 105
        Top = 21
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
        TabOrder = 0
        Text = ''
        OnExit = mskLinhaGrupoGeralExit
        OnKeyPress = mskLinhaGrupoGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesLinGruProAca: TEditFocus
        Left = 163
        Top = 21
        Width = 309
        Height = 22
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
      object edtFornecProAca: TEditFocus
        Tag = 99
        Left = 105
        Top = 67
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
        TabOrder = 2
        OnExit = edtFornecedorGeralExit
        OnKeyPress = edtFornecedorGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForProAca: TEditFocus
        Left = 163
        Top = 67
        Width = 309
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMarcaProAca: TEditFocus
        Tag = 99
        Left = 105
        Top = 90
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
        TabOrder = 3
        OnExit = edtMarcaGeralExit
        OnKeyPress = edtMarcaGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarcaProAca: TEditFocus
        Left = 163
        Top = 90
        Width = 228
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidadeProAca: TEditFocus
        Tag = 99
        Left = 425
        Top = 90
        Width = 47
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
        MaxLength = 2
        ParentFont = False
        TabOrder = 4
        OnKeyPress = edtUnidadeGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesProdutoPROACA: TEditFocus
        Left = 163
        Top = 44
        Width = 309
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtProdutosPROACA: TEditFocus
        Tag = 99
        Left = 105
        Top = 44
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 1
        OnExit = edtProdutosPROACAExit
        OnKeyPress = edtProdutosPROACAKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlSubProdutos: TPanel [4]
    Left = 0
    Top = 199
    Width = 494
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentColor = True
    TabOrder = 2
    object GroupBox3: TGroupBox
      Left = 5
      Top = 5
      Width = 484
      Height = 111
      Align = alClient
      Caption = 'Sub Produtos'
      TabOrder = 0
      object Label3: TLabel
        Left = 37
        Top = 20
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
      object Label4: TLabel
        Left = 41
        Top = 66
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
      object Label5: TLabel
        Left = 66
        Top = 89
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
      object Label6: TLabel
        Left = 397
        Top = 91
        Width = 27
        Height = 14
        Caption = 'Unid.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 59
        Top = 43
        Width = 43
        Height = 14
        Caption = 'Produto.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtLinGruSubPro: TMaskEditFocus
        Tag = 99
        Left = 105
        Top = 17
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
        TabOrder = 0
        Text = ''
        OnExit = mskLinhaGrupoGeralExit
        OnKeyPress = mskLinhaGrupoGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesLinGruSubPro: TEditFocus
        Left = 163
        Top = 17
        Width = 309
        Height = 22
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
      object edtFornecSubPro: TEditFocus
        Tag = 99
        Left = 105
        Top = 63
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
        TabOrder = 2
        OnExit = edtFornecedorGeralExit
        OnKeyPress = edtFornecedorGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForSubPro: TEditFocus
        Left = 163
        Top = 63
        Width = 309
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMarcaSubPro: TEditFocus
        Tag = 99
        Left = 105
        Top = 86
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
        TabOrder = 3
        OnExit = edtMarcaGeralExit
        OnKeyPress = edtMarcaGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarcaSubPro: TEditFocus
        Left = 163
        Top = 86
        Width = 228
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidadeSubPro: TEditFocus
        Tag = 99
        Left = 425
        Top = 86
        Width = 47
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
        MaxLength = 2
        ParentFont = False
        TabOrder = 4
        OnKeyPress = edtUnidadeGeralKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesProdutoSubGru: TEditFocus
        Left = 163
        Top = 40
        Width = 309
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtProdutosSubPro: TEditFocus
        Tag = 99
        Left = 105
        Top = 40
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 1
        OnExit = edtProdutosPROACAExit
        OnKeyPress = edtProdutosPROACAKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 356
    Top = 132
  end
end
