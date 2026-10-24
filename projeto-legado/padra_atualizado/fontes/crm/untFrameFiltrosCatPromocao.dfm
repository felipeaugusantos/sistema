object frameFiltrosCatPromocao: TframeFiltrosCatPromocao
  Left = 0
  Top = 0
  Width = 822
  Height = 364
  TabOrder = 0
  object pnlFiltrosProdutos: TPanel
    Left = 0
    Top = 0
    Width = 822
    Height = 265
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object grpProdutos: TGroupBox
      Left = 0
      Top = 0
      Width = 822
      Height = 265
      Align = alClient
      Caption = 'Sele'#231#227'o de produtos para gera'#231#227'o de cat'#225'logo '
      TabOrder = 0
      object lblDepartamento: TLabel
        Left = 16
        Top = 133
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'Departamento:'
      end
      object Label56: TLabel
        Left = 19
        Top = 95
        Width = 59
        Height = 14
        Caption = 'Linha/Grupo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label57: TLabel
        Left = 336
        Top = 95
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblDescricao: TLabel
        Left = 19
        Top = 57
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 19
        Top = 19
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label58: TLabel
        Left = 594
        Top = 19
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Com saldo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblDesCon: TLabel
        Left = 594
        Top = 55
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = '(%) Desconto:'
      end
      object lblTabPreco: TLabel
        Left = 708
        Top = 19
        Width = 56
        Height = 13
        Caption = 'Tab. pre'#231'o:'
      end
      object Label59: TLabel
        Left = 336
        Top = 133
        Width = 59
        Height = 13
        Caption = 'Fornecedor:'
      end
      object shpLiberadoDesconto: TShape
        Left = 594
        Top = 70
        Width = 8
        Height = 22
      end
      object shpLiberadoTabSProm: TShape
        Left = 708
        Top = 32
        Width = 8
        Height = 21
      end
      object Label60: TLabel
        Left = 19
        Top = 173
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo sem Venda'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label61: TLabel
        Left = 132
        Top = 190
        Width = 15
        Height = 14
        Alignment = taRightJustify
        Caption = 'at'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label62: TLabel
        Left = 309
        Top = 190
        Width = 200
        Height = 14
        Alignment = taRightJustify
        Caption = 'Itens que n'#227'o foram vendidos nos '#250'ltimos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label63: TLabel
        Left = 566
        Top = 190
        Width = 20
        Height = 14
        Alignment = taRightJustify
        Caption = 'dias'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label64: TLabel
        Left = 19
        Top = 213
        Width = 158
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa para buscar as vendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodDepPrm: TEditFocus
        Tag = 99
        Left = 19
        Top = 146
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 7
        OnExit = edtCodDepPrmExit
        OnKeyPress = edtCodDepPrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object mskLinGruPrm: TMaskEditFocus
        Tag = 99
        Left = 19
        Top = 107
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
        TabOrder = 3
        Text = ''
        OnExit = mskLinGruPrmExit
        OnKeyPress = mskLinGruPrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGruPrm: TEditFocus
        Left = 81
        Top = 107
        Width = 245
        Height = 22
        TabStop = False
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
      object edtDesDepPrm: TEditFocus
        Left = 81
        Top = 146
        Width = 245
        Height = 21
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
      object edtCodMarPrm: TEditFocus
        Tag = 99
        Left = 336
        Top = 108
        Width = 68
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 5
        OnExit = edtCodMarPrmExit
        OnKeyPress = edtCodMarPrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtDesMarPrm: TEditFocus
        Left = 405
        Top = 108
        Width = 181
        Height = 21
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
      object edtDescri: TEditFocus
        Left = 19
        Top = 71
        Width = 567
        Height = 21
        Alignment = taLeftJustify
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodItePrm: TEditFocus
        Tag = 99
        Left = 19
        Top = 32
        Width = 61
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        ParentColor = True
        TabOrder = 0
        OnExit = edtCodItePrmExit
        OnKeyPress = edtCodItePrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesItePrm: TEditFocus
        Left = 81
        Top = 32
        Width = 505
        Height = 21
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
      object cmbComSaldo: TComboBoxFocus
        Tag = 99
        Left = 595
        Top = 32
        Width = 85
        Height = 21
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 16
        Text = 'Todos'
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtDesconto: TEditFocus
        Tag = 99
        Left = 594
        Top = 71
        Width = 86
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
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object chkCatalogoComPreco: TCheckBox
        Left = 592
        Top = 99
        Width = 154
        Height = 22
        Caption = 'Gerar cat'#225'logo com pre'#231'o?'
        Checked = True
        State = cbChecked
        TabOrder = 19
      end
      object cbTabPreco: TComboBoxFocus
        Tag = 99
        Left = 715
        Top = 32
        Width = 36
        Height = 21
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Sorted = True
        TabOrder = 17
        OnSelect = cbTabPrecoSelect
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtCodForPrm: TEditFocus
        Tag = 99
        Left = 336
        Top = 146
        Width = 68
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
        TabOrder = 9
        OnExit = edtCodForPrmExit
        OnKeyPress = edtCodForPrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomForPrm: TEditFocus
        Left = 405
        Top = 146
        Width = 181
        Height = 21
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
      object chkPrecoImposto: TCheckBox
        Left = 592
        Top = 145
        Width = 159
        Height = 22
        Caption = 'Calcular pre'#231'o com impostos?'
        TabOrder = 20
      end
      object mskDtaSemVendaIni: TMaskEditFocus
        Tag = 99
        Left = 19
        Top = 185
        Width = 93
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
        TabOrder = 11
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaSemVendaFin: TMaskEditFocus
        Tag = 99
        Left = 165
        Top = 185
        Width = 86
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
        TabOrder = 12
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtNroDiasSemVenda: TEditFocus
        Tag = 99
        Left = 515
        Top = 185
        Width = 45
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
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCodEmpPrm: TEditFocus
        Tag = 99
        Left = 19
        Top = 227
        Width = 61
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 14
        OnExit = edtCodEmpPrmExit
        OnKeyPress = edtCodEmpPrmKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpPrm: TEditFocus
        Left = 81
        Top = 227
        Width = 245
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 15
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlFiltrosPromocao: TPanel
    Left = 0
    Top = 265
    Width = 822
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object grpPromocao: TGroupBox
      Left = 0
      Top = 0
      Width = 822
      Height = 97
      Align = alTop
      Caption = 'Promo'#231#227'o'
      TabOrder = 0
      object lbl4: TLabel
        Left = 594
        Top = 45
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data vig'#234'ncia:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 19
        Top = 45
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Promo'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblTabPrecoPromocinal: TLabel
        Left = 706
        Top = 45
        Width = 113
        Height = 13
        Caption = 'Tab.Pre'#231'o promocional:'
      end
      object shpLiberadoTabCProm: TShape
        Left = 708
        Top = 59
        Width = 8
        Height = 21
      end
      object chkSomenteEmPromocao: TCheckBox
        Left = 19
        Top = 17
        Width = 184
        Height = 22
        Caption = 'Somente produtos em promo'#231#227'o?'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object mskDataVigencia: TMaskEditFocus
        Tag = 99
        Left = 592
        Top = 59
        Width = 86
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
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtCodPro: TEditFocus
        Tag = 99
        Left = 19
        Top = 59
        Width = 73
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
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        OnExit = edtCodProExit
        OnKeyPress = edtCodProKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtDesPro: TEditFocus
        Left = 93
        Top = 59
        Width = 493
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cbTabPrecoProm: TComboBoxFocus
        Tag = 99
        Left = 715
        Top = 59
        Width = 36
        Height = 21
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Sorted = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
  end
end
