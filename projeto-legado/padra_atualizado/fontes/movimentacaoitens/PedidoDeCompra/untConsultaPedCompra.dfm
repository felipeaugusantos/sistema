inherited frmConsultaPedCompra: TfrmConsultaPedCompra
  Width = 506
  Height = 449
  Caption = 'Consulta Ped.Compra'
  ExplicitWidth = 506
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  object lblEmpresa: TLabel [0]
    Left = 5
    Top = 58
    Width = 42
    Height = 14
    Caption = 'Empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel [1]
    Left = 5
    Top = 95
    Width = 56
    Height = 14
    Caption = 'Fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 5
    Top = 133
    Width = 88
    Height = 14
    Caption = 'Linha/Grupo Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 5
    Top = 170
    Width = 37
    Height = 14
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel [4]
    Left = 5
    Top = 207
    Width = 30
    Height = 14
    Caption = 'Marca'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [5]
    Left = 5
    Top = 242
    Width = 85
    Height = 14
    Caption = 'Grupo de Compra'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel [6]
    Left = 5
    Top = 282
    Width = 53
    Height = 14
    Caption = 'Comprador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 378
    Width = 500
    ExplicitLeft = 5
    ExplicitTop = 378
    ExplicitWidth = 490
    inherited FlwBotoes: TFlowPanel
      Width = 496
    end
    inherited btnSair: TBitBtnLocked
      Left = 417
      ExplicitLeft = 407
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 500
    ExplicitLeft = 5
    ExplicitTop = 404
    ExplicitWidth = 490
    inherited pnlNomeForm: TPanel
      Left = 329
      ExplicitLeft = 319
    end
    inherited pnlInfo: TPanel
      Width = 329
      ExplicitWidth = 319
    end
  end
  object Panel1: TPanel [10]
    Left = 0
    Top = 0
    Width = 500
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = 5
    ExplicitWidth = 490
    object GroupBox2: TGroupBox
      Left = 243
      Top = 0
      Width = 257
      Height = 55
      Align = alClient
      Caption = 'Entrega'
      TabOrder = 1
      ExplicitWidth = 247
      object Label1: TLabel
        Left = 14
        Top = 15
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 116
        Top = 15
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskEntregaDtaIni: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 29
        Width = 87
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
        ValidaData = True
      end
      object mskEntregaDtaFin: TMaskEditFocus
        Tag = 99
        Left = 116
        Top = 29
        Width = 89
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
        ValidaData = True
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 243
      Height = 55
      Align = alLeft
      Caption = 'Emiss'#227'o'
      TabOrder = 0
      object Label5: TLabel
        Left = 14
        Top = 15
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 117
        Top = 15
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskEmissaoDtaIni: TMaskEditFocus
        Tag = 99
        Left = 14
        Top = 29
        Width = 88
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
        ValidaData = True
      end
      object mskEmissaoDtaFin: TMaskEditFocus
        Tag = 99
        Left = 117
        Top = 29
        Width = 89
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
        ValidaData = True
      end
    end
  end
  object edtCodEmpresa: TEditFocus [11]
    Tag = 99
    Left = 5
    Top = 72
    Width = 67
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
    TabOrder = 4
    OnExit = edtCodEmpresaExit
    OnKeyPress = edtCodEmpresaKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesEmpresa: TEditFocus [12]
    Left = 73
    Top = 72
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    TabOrder = 5
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodFornecedor: TEditFocus [13]
    Tag = 99
    Left = 5
    Top = 109
    Width = 67
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
    TabOrder = 6
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
  object edtDesFornecedor: TEditFocus [14]
    Left = 73
    Top = 109
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
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
  object mskLinhaGrupo: TMaskEditFocus [15]
    Tag = 99
    Left = 5
    Top = 150
    Width = 66
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
    TabOrder = 8
    Text = ''
    OnExit = mskLinhaGrupoExit
    OnKeyPress = mskLinhaGrupoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtDesGrupo: TEditFocus [16]
    Left = 73
    Top = 150
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtProdutos: TEditFocus [17]
    Left = 5
    Top = 184
    Width = 66
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnExit = edtProdutosExit
    OnKeyPress = edtProdutosKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 5
    TipoTexto = ttNumerico
  end
  object edtDesProduto: TEditFocus [18]
    Left = 73
    Top = 184
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtMarca: TEditFocus [19]
    Left = 5
    Top = 221
    Width = 66
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 12
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
  object edtDesMarca: TEditFocus [20]
    Left = 73
    Top = 221
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    TabOrder = 13
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtGruCmp: TEditFocus [21]
    Left = 5
    Top = 256
    Width = 67
    Height = 22
    Alignment = taLeftJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 14
    OnExit = edtGruCmpExit
    OnKeyPress = edtGruCmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesGruCmp: TEditFocus [22]
    Left = 73
    Top = 256
    Width = 421
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 15
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodCmp: TEditFocus [23]
    Tag = 99
    Left = 5
    Top = 296
    Width = 67
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
    TabOrder = 16
    OnExit = edtCodCmpExit
    OnKeyPress = edtCodCmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesCmp: TEditFocus [24]
    Left = 73
    Top = 296
    Width = 421
    Height = 22
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight]
    Color = 16768952
    Enabled = False
    TabOrder = 17
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgSituacao: TRadioGroup [25]
    Left = 0
    Top = 324
    Width = 500
    Height = 54
    Align = alBottom
    Caption = 'Situa'#231#227'o'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Todos'
      'Baixados'
      'N'#227'o Baixados'
      'Baixados que n'#227'o ser'#227'o entregues')
    TabOrder = 18
    ExplicitLeft = 5
    ExplicitWidth = 490
  end
end
