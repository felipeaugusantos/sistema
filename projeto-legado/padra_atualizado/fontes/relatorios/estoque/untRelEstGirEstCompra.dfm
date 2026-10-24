inherited frmRelEstGirEstCompra: TfrmRelEstGirEstCompra
  Left = 288
  Top = 185
  Width = 610
  Height = 620
  Caption = 'Relat'#243'rio do Giro de Estoque - Compra'
  OnDestroy = FormDestroy
  ExplicitTop = -158
  ExplicitWidth = 610
  ExplicitHeight = 620
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 547
    Width = 604
    ExplicitTop = 547
    ExplicitWidth = 604
    inherited btnSair: TBitBtnLocked
      Left = 521
      ExplicitLeft = 521
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      ExplicitLeft = 7
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 84
      Width = 80
      ExplicitLeft = 84
      ExplicitWidth = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 604
    Height = 547
    ExplicitWidth = 604
    ExplicitHeight = 547
    object Label2: TLabel [0]
      Left = 315
      Top = 260
      Width = 21
      Height = 14
      Caption = 'Unid'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 7
      Top = 260
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDescricao: TLabel [2]
      Left = 7
      Top = 223
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [3]
      Left = 7
      Top = 112
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
    object Label10: TLabel [4]
      Left = 7
      Top = 77
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
    object Label3: TLabel [5]
      Left = 7
      Top = 42
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
    object Label9: TLabel [6]
      Left = 7
      Top = 7
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
    object Label5: TLabel [7]
      Left = 7
      Top = 186
      Width = 91
      Height = 14
      Caption = 'Grupo de Compras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [8]
      Left = 7
      Top = 297
      Width = 80
      Height = 14
      Caption = 'Tipo de Relat'#243'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtGrupoProd: TLabel [9]
      Left = 7
      Top = 149
      Width = 85
      Height = 14
      Caption = 'Grupo de Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 160
      Top = 498
      Width = 194
      Height = 42
      TabOrder = 23
      ExplicitLeft = 160
      ExplicitTop = 498
      ExplicitWidth = 194
      ExplicitHeight = 42
      inherited ColorLabel1: TColorLabel
        Top = 17
        Width = 144
        Caption = '(V)'#237'deo  (I)mpressora  (E)xcel'
        ExplicitTop = 17
        ExplicitWidth = 144
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object gpbOrdem: TGroupBox
      Left = 7
      Top = 341
      Width = 225
      Height = 42
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ColorLabel2: TColorLabel
        Left = 27
        Top = 17
        Width = 194
        Height = 14
        Caption = '(A)lfabetica (L)inha/Grupo (F)ornecedor'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnChange = edtOpcaoChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtUnidade: TEditFocus
      Left = 315
      Top = 274
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 14
      OnExit = edtUnidadeExit
      OnKeyPress = edtUnidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescri: TEditFocus
      Left = 7
      Top = 237
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 7
      Top = 274
      Width = 303
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Left = 7
      Top = 126
      Width = 57
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
      TabOrder = 6
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
    object edtFornecedor: TEditFocus
      Left = 7
      Top = 91
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
      TabOrder = 4
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtProdutos: TEditFocus
      Left = 7
      Top = 56
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
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
    object mskLinhaGrupo: TMaskEditFocus
      Left = 7
      Top = 21
      Width = 55
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
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 67
      Top = 21
      Width = 285
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
    object edtDesProduto: TEditFocus
      Left = 67
      Top = 56
      Width = 285
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 67
      Top = 91
      Width = 285
      Height = 22
      Alignment = taLeftJustify
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
    object edtDesMarca: TEditFocus
      Left = 67
      Top = 126
      Width = 285
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgStatus: TRadioGroup
      Left = 233
      Top = 341
      Width = 121
      Height = 42
      Caption = 'Status'
      Columns = 2
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 17
    end
    object GroupBox4: TGroupBox
      Left = 174
      Top = 383
      Width = 180
      Height = 44
      Caption = 'Itens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 17
        Width = 148
        Height = 14
        Caption = '(C)om Giro (S)em Giro (T)odos'
        CorDestaque = clRed
      end
      object edtFilGir: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object grbRefere: TGroupBox
      Left = 7
      Top = 468
      Width = 347
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      object chkReferencia: TCheckBox
        Left = 8
        Top = 6
        Width = 156
        Height = 17
        Caption = 'Exibir Refer'#234'ncia do Produto'
        TabOrder = 0
      end
      object chkExiAtu: TCheckBox
        Left = 176
        Top = 7
        Width = 142
        Height = 13
        Caption = 'Exibir m'#234's atual'
        TabOrder = 1
      end
    end
    object rdgLocFis: TRadioGroup
      Left = 7
      Top = 429
      Width = 347
      Height = 34
      Caption = 'Localiza'#231#227'o F'#237'sica'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Com Localiza'#231#227'o'
        'Sem Localiza'#231#227'o')
      TabOrder = 20
    end
    object rdgExibir: TRadioGroup
      Left = 7
      Top = 383
      Width = 165
      Height = 44
      Caption = 'Exibir'
      ItemIndex = 0
      Items.Strings = (
        'Pre'#231'o de Venda'
        'Pre'#231'o de Compra/Custo')
      TabOrder = 18
    end
    object edtGruCmp: TEditFocus
      Left = 7
      Top = 200
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
      TabOrder = 10
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
    object edtDesGruCmp: TEditFocus
      Left = 67
      Top = 200
      Width = 285
      Height = 22
      Alignment = taLeftJustify
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
    object cmbTipRel: TComboBoxFocus
      Tag = 99
      Left = 7
      Top = 314
      Width = 345
      Height = 20
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 0
      ParentFont = False
      TabOrder = 15
      Text = 'Completo'
      OnChange = cmbTipRelChange
      Items.Strings = (
        'Completo'
        'Sint'#233'tico por Acordo de Objetivos'
        'Anal'#237'tico por Acordo de Objetivos')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object prgProgresso: TProgressBar
      Left = 1
      Top = 541
      Width = 602
      Height = 5
      Align = alBottom
      TabOrder = 24
      Visible = False
    end
    object pnlMeses: TPanel
      Left = 362
      Top = 1
      Width = 241
      Height = 540
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 25
      object cxgItens: TcxGrid
        Left = 0
        Top = 20
        Width = 241
        Height = 520
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgItensAno: TcxGridDBColumn
            Caption = 'Ano'
            DataBinding.FieldName = 'VALANO'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soDescending
            Width = 68
          end
          object cxgItensMES: TcxGridDBColumn
            Caption = 'M'#234's'
            DataBinding.FieldName = 'VALMES'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 1
            SortOrder = soDescending
            Width = 72
          end
          object cxgItensSEL: TcxGridDBColumn
            Caption = 'Selecionar'
            DataBinding.FieldName = 'SELECI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxgItensSELPropertiesChange
            HeaderAlignmentHorz = taCenter
            Options.Grouping = False
            Options.Moving = False
            Width = 93
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxgItensView
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 241
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Selecione 3 meses de movimenta'#231#227'o'
        TabOrder = 1
      end
    end
    object edtGrpPrd: TEditFocus
      Tag = 99
      Left = 7
      Top = 163
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
      TabOrder = 8
      OnKeyPress = edtGrpPrdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesGrpPrd: TEditFocus
      Left = 67
      Top = 164
      Width = 285
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgQuebraFornec: TRadioGroup
      Left = 7
      Top = 498
      Width = 151
      Height = 42
      Caption = 'Quebrar por Fornecedor'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 22
    end
  end
  inherited pnlStatus: TPanel
    Top = 575
    Width = 604
    ExplicitTop = 575
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 433
      ExplicitLeft = 433
    end
    inherited pnlInfo: TPanel
      Width = 433
      ExplicitWidth = 433
      inherited shpMultSel: TShape
        Visible = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
    Top = 88
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 384
    Top = 224
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 472
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 440
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 536
    Top = 296
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 536
    Top = 224
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 408
    Top = 64
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 432
    Top = 232
  end
  inherited frxGen: TfrxUserDataSet
    Left = 488
    Top = 224
  end
  inherited frxDesigner: TfrxDesigner
    Left = 536
    Top = 88
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 568
    Top = 88
  end
  object dlgExcel: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Planilha do Excel|*.xls'
    Left = 320
    Top = 32
  end
end
