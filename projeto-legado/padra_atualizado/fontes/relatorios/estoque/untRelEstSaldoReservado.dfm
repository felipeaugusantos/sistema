inherited frmRelEstSaldoReservado: TfrmRelEstSaldoReservado
  Left = 854
  Top = 202
  VertScrollBar.Range = 0
  Caption = 'Relat'#243'rio de Saldos Reservados'
  ClientHeight = 627
  ClientWidth = 356
  OnDestroy = FormDestroy
  ExplicitWidth = 362
  ExplicitHeight = 656
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 585
    Width = 356
    ExplicitTop = 585
    ExplicitWidth = 356
    DesignSize = (
      356
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 223
      Align = alLeft
      ExplicitWidth = 223
    end
    inherited btnSair: TBitBtnLocked
      Left = 269
      Align = alNone
      Anchors = [akTop, akRight]
      ExplicitLeft = 269
    end
  end
  inherited pnlStatus: TPanel
    Top = 611
    Width = 356
    ExplicitTop = 611
    ExplicitWidth = 356
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
    end
  end
  inherited pnlDados: TPanel
    Width = 356
    Height = 585
    ExplicitWidth = 356
    ExplicitHeight = 585
    object Label5: TLabel [0]
      Left = 5
      Top = 6
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
    object Label6: TLabel [1]
      Left = 5
      Top = 41
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
    object Label9: TLabel [2]
      Left = 5
      Top = 77
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
    object Label3: TLabel [3]
      Left = 5
      Top = 112
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
    object Label10: TLabel [4]
      Left = 5
      Top = 229
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [5]
      Left = 5
      Top = 265
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
    object Label1: TLabel [6]
      Left = 6
      Top = 192
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
    object Label12: TLabel [7]
      Left = 6
      Top = 302
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [8]
      Left = 5
      Top = 151
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
    object Label2: TLabel [9]
      Left = 6
      Top = 338
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
    inherited gpbDestino: TGroupBox
      Left = 5
      Top = 514
      Width = 173
      Height = 53
      TabOrder = 23
      ExplicitLeft = 5
      ExplicitTop = 514
      ExplicitWidth = 173
      ExplicitHeight = 53
      inherited ColorLabel1: TColorLabel
        Top = 22
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 22
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 19
        ExplicitTop = 19
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 19
      Width = 76
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 55
      Width = 77
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 91
      Width = 57
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
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtProdutos: TEditFocus
      Left = 5
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
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
    object edtCliente: TEditFocus
      Left = 5
      Top = 243
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 11
      OnExit = edtClienteExit
      OnKeyPress = edtClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesGrupo: TEditFocus
      Left = 64
      Top = 91
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesProduto: TEditFocus
      Left = 64
      Top = 126
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCliente: TEditFocus
      Left = 64
      Top = 243
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOpcao: TGroupBox
      Left = 5
      Top = 458
      Width = 173
      Height = 53
      Caption = 'Op'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 23
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 19
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbQuebra: TGroupBox
      Left = 180
      Top = 525
      Width = 170
      Height = 42
      Caption = 'Quebra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 25
      object ColorLabel4: TColorLabel
        Left = 29
        Top = 23
        Width = 127
        Height = 14
        Caption = '(A)lfab'#233'tica (L)inha/Grupo'
        CorDestaque = clRed
      end
      object edtQuebra: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtCodEmpresa: TEditFocus
      Left = 5
      Top = 279
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 13
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
    object edtDesEmpresa: TEditFocus
      Left = 64
      Top = 279
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgPeriodo: TRadioGroup
      Left = 87
      Top = 15
      Width = 89
      Height = 66
      Caption = 'Per'#237'odo'
      ItemIndex = 0
      Items.Strings = (
        'Entrada'
        'Previs'#227'o')
      TabOrder = 2
    end
    object rdgOrdenacao: TRadioGroup
      Left = 215
      Top = 376
      Width = 135
      Height = 65
      Caption = 'Ordenar Pedidos por'
      ItemIndex = 0
      Items.Strings = (
        'Cliente'
        'Data de Previs'#227'o')
      TabOrder = 20
    end
    object edtFornecedor: TEditFocus
      Left = 5
      Top = 206
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
      TabOrder = 9
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
    object edtDesFornecedor: TEditFocus
      Left = 64
      Top = 206
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgSituacao: TRadioGroup
      Left = 5
      Top = 376
      Width = 204
      Height = 65
      Caption = 'Situa'#231#227'o'
      ItemIndex = 2
      Items.Strings = (
        'Itens que n'#227'o podem ser atendidos'
        'Itens que podem ser atendidos'
        'Todos os itens')
      TabOrder = 19
      OnClick = rdgSituacaoClick
    end
    object edtCodVendedor: TEditFocus
      Left = 5
      Top = 316
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 15
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 64
      Top = 316
      Width = 286
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 574
      Width = 354
      Height = 10
      Align = alBottom
      Smooth = True
      TabOrder = 26
      Visible = False
    end
    object edtMarca: TEditFocus
      Tag = 99
      Left = 5
      Top = 165
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
      TabOrder = 7
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
      Left = 64
      Top = 165
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtGruCmp: TEditFocus
      Left = 5
      Top = 352
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 17
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
      Left = 64
      Top = 352
      Width = 286
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object ckbPedCom: TCheckBox
      Left = 12
      Top = 442
      Width = 344
      Height = 16
      Caption = 'Considerar como saldo, quantidades em "Pedidos de Compra"'
      Checked = True
      State = cbChecked
      TabOrder = 21
      Visible = False
      WordWrap = True
    end
    object rdgTipoSaldo: TRadioGroup
      Left = 180
      Top = 458
      Width = 170
      Height = 65
      Caption = 'Tipo de saldo reservado'
      ItemIndex = 2
      Items.Strings = (
        'Pedido de Venda'
        'Garantia'
        'Todos')
      TabOrder = 24
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 560
    Top = 80
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 176
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 560
    Top = 48
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 528
    Top = 48
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 496
    Top = 48
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 464
    Top = 48
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 432
    Top = 48
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 368
    Top = 48
  end
  inherited frxGen: TfrxUserDataSet
    Left = 400
    Top = 48
  end
  inherited frxDesigner: TfrxDesigner
    Left = 624
    Top = 48
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 656
    Top = 48
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45266.490965648100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '    grpLinha.Visible := False;'
      '    grpGrupo.Visible := False;'
      ''
      '    if <OPCAO> = '#39'S'#39' then'
      '       qckSintetico.Visible := True'
      '    else if <OPCAO> = '#39'A'#39' then'
      '    begin'
      '       qckAnalitico.Visible := True;'
      ''
      '       if <QUEBRA> = '#39'L'#39' then'
      '       begin'
      '           grpLinha.Visible := True;'
      '           grpGrupo.Visible := True;'
      '       end;'
      '    end;'
      ''
      ''
      'end.')
    Left = 289
    Top = 14
    Datasets = <
      item
        DataSet = frxDocumentos
        DataSetName = 'frxDocumentos'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckSintetico: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      ColumnWidth = 2.500000000000000000
      PrintIfEmpty = False
      object CabecalhoSintetico: TfrxPageHeader
        FillType = ftBrush
        Height = 205.090600000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmoSlNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoSNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL] - SINT'#201'TICO')
          ParentFont = False
        end
        object mmoSPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
        end
        object mmoSEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
        end
        object mmoSPeriodo: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 36.015770000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REFERENTE AO PERIODO DE [DATA_INICIO] A [DATA_FINAL]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoSLinhaGrupo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 62.472480000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          ParentFont = False
        end
        object mmoSProdutos: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.370130000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTOS]')
          ParentFont = False
        end
        object mmoSMarca: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object mmoSClientes: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.606370000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTES]')
          ParentFont = False
        end
        object mmoSFornecedor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 124.724490000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object mmoSEmpresa: TfrxMemoView
          Left = 7.559060000000000000
          Top = 139.842610000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object mmoSVendedor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object mmoSSituacao: TfrxMemoView
          Left = 7.559060000000000000
          Top = 170.078850000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITUACAO]')
          ParentFont = False
        end
        object mmoSGrupoCompra: TfrxMemoView
          Left = 7.559060000000000000
          Top = 185.196970000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_COMPRA]')
          ParentFont = False
        end
      end
      object FooterSintetico: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 457.323130000000000000
        Width = 748.346940000000000000
        object mmoSContaRegistro: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Top = 15.118120000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterSintetico, 2)]')
          ParentFont = False
          WordWrap = False
        end
        object mmoSNomeRel: TfrxMemoView
          Top = 15.118120000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmRelEstSaldoReservado')
          ParentFont = False
        end
        object mmoSLinhaFinal: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '* A quantidade informada na coluna RESERV se refere a quantidade' +
              ' total reservada do produto, independentemente do filtro aplicad' +
              'o no relatorio')
          ParentFont = False
        end
      end
      object HeaderSintetico: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 283.464750000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object mmoSHFundoHeader: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          Fill.BackColor = clScrollBar
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object mmoSHCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 41.574803150000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHDescricao: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 188.976377950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHReferencia: TfrxMemoView
          Left = 236.220484650000000000
          Top = 3.779530000000000000
          Width = 90.708668740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHUnidade: TfrxMemoView
          Left = 328.819110000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UNIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHMarca: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 111.496075200000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHFaltSob: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FALT/SOB')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHSalReservado: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'RESERV.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHPedCompra: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PED.COM')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoSHSaldo: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterSintetico: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 328.819110000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoZebraSin: TfrxMemoView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clMoneyGreen
        end
        object mmoSMCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMDescricao: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 188.976500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMReferencia: TfrxMemoView
          Left = 236.330860000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMUnidade: TfrxMemoView
          Left = 328.819110000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMMarca: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 111.496094720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMSaldo: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMPedCompra: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDPEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMSalReservado: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoSMFaltSob: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SALDO">+<frxRelatorio."QTDPEN">-<frxRelatorio."' +
              'SALRES">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end
            item
            end>
        end
      end
      object SummarySintetico: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 411.968770000000000000
        Width = 748.346940000000000000
        object Memo1: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779527560000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDO">,MasterSintetico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line1: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDPEN">,MasterSintetico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALRES">,MasterSintetico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SALDO">+<frxRelatorio."QTDPEN">-<frxRelatori' +
              'o."SALRES">,MasterSintetico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 374.173470000000000000
          Top = 3.779530000000000000
          Width = 128.503983390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object qckAnalitico: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object CabecalhoAnalitico: TfrxPageHeader
        FillType = ftBrush
        Height = 205.090600000000000000
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        object mmoANomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.428665000000000000
          Top = 5.779542200000000000
          Width = 491.489610000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object mmoANomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 20.897650000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL] - ANAL'#205'TICO')
          ParentFont = False
        end
        object mmoAPagina: TfrxMemoView
          Left = 627.401320940000000000
          Top = 5.779530000000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
        end
        object mmoAEmitido: TfrxMemoView
          Left = 551.811380000000000000
          Top = 24.677180000000000000
          Width = 190.790600000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date] [Time]')
          ParentFont = False
        end
        object mmoAPeriodo: TfrxMemoView
          Align = baCenter
          Left = 137.764070000000000000
          Top = 36.015770000000000000
          Width = 472.818800000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'REFERENTE AO PERIODO DE [DATA_INICIO] A [DATA_FINAL]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoALinhaGrupo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 62.472480000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINHAGRUPO]')
          ParentFont = False
        end
        object mmoAProdutos: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.370130000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PRODUTOS]')
          ParentFont = False
        end
        object mmoAMarca: TfrxMemoView
          Left = 7.559060000000000000
          Top = 94.488250000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object mmoAClientes: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.606370000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTES]')
          ParentFont = False
        end
        object mmoAFornecedor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 124.724490000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object mmoAEmpresa: TfrxMemoView
          Left = 7.559060000000000000
          Top = 139.842610000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object mmoAVendedor: TfrxMemoView
          Left = 7.559060000000000000
          Top = 154.960730000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object mmoASituacao: TfrxMemoView
          Left = 7.559060000000000000
          Top = 170.078850000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITUACAO]')
          ParentFont = False
        end
        object mmoAGrupoCompra: TfrxMemoView
          Left = 7.559060000000000000
          Top = 185.196970000000000000
          Width = 733.228595430000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPO_COMPRA]')
          ParentFont = False
        end
      end
      object HeaderAnalitico: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 374.173470000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object mmoAHFundoHeader: TfrxShapeView
          Align = baClient
          Width = 748.346940000000000000
          Height = 22.677165350000000000
          Fill.BackColor = clScrollBar
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object mmoAHCodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 41.574803150000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHDescricao: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 188.976377950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHReferencia: TfrxMemoView
          Left = 236.220484650000000000
          Top = 3.779530000000000000
          Width = 90.708668740000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHUnidade: TfrxMemoView
          Left = 328.819110000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UNIDADE')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHMarca: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 111.496075200000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHFaltSob: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'FALT/SOB')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHSalres: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'RESERV.')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHPedCompra: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PED.COM')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoAHSaldo: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterAnalitico: TfrxMasterData
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 419.527830000000000000
        Width = 748.346940000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoMACodigo: TfrxMemoView
          Top = 3.779530000000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMADescricao: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 188.976500000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMAReferencia: TfrxMemoView
          Left = 236.330860000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMAUnidade: TfrxMemoView
          Left = 328.819110000000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESUNI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMAMarca: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 111.496094720000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMASaldo: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMAPedCompra: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDPEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMASalReservado: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object mmoMAFaltSob: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxRelatorio."SALDO">+<frxRelatorio."QTDPEN">-<frxRelatorio."' +
              'SALRES">)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2n'
              Kind = fkNumeric
            end
            item
            end
            item
            end>
        end
        object SubReportDocumentos: TfrxSubreport
          Top = 22.677180000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page1
        end
      end
      object SummaryAnalitico: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 525.354670000000000000
        Width = 748.346940000000000000
        object Memo8: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779527560000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALDO">,MasterAnalitico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDPEN">,MasterAnalitico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 627.401980000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."SALRES">,MasterAnalitico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 687.874460000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."SALDO">+<frxRelatorio."QTDPEN">-<frxRelatori' +
              'o."SALRES">,MasterAnalitico)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 374.173470000000000000
          Top = 3.779530000000000000
          Width = 128.503983390000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object FooterAnalitico: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 570.709030000000000000
        Width = 748.346940000000000000
        object Memo13: TfrxMemoView
          Align = baRight
          Left = 495.118430000000000000
          Top = 15.118120000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterAnalitico, 2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Top = 15.118120000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmRelEstSaldoReservado')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo15: TfrxMemoView
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '* A quantidade informada na coluna RESERV se refere a quantidade' +
              ' total reservada do produto, independentemente do filtro aplicad' +
              'o no relatorio')
          ParentFont = False
        end
      end
      object grpLinha: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 283.464750000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."LINHA"'
        object frxRelatorioLINHA: TfrxMemoView
          Left = 3.779527560000000000
          Top = 3.779530000000000000
          Width = 661.417750000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Linha: [frxRelatorio."LINDES"] ')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object grpGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 328.819110000000000000
        Width = 748.346940000000000000
        Condition = 'frxRelatorio."GRUPO"'
        object Memo29: TfrxMemoView
          Left = 30.236220470000000000
          Top = 3.779530000000000000
          Width = 623.622450000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grupo: [frxRelatorio."DESGRU"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 6.000000000000000000
      RightMargin = 6.000000000000000000
      TopMargin = 6.000000000000000000
      BottomMargin = 6.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 64.252010000000000000
        Width = 748.346940000000000000
        DataSet = frxDocumentos
        DataSetName = 'frxDocumentos'
        Filter = '<frxDocumentos."CODITE"> = <frxRelatorio."CODITE">'
        RowCount = 0
        object frxDocumentosCODCLI: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataField = 'CODCLI'
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumentos."CODCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxDocumentosNOMCLI: TfrxMemoView
          Left = 98.267780000000000000
          Top = 3.779530000000000000
          Width = 238.110390000000000000
          Height = 15.118110240000000000
          DataField = 'NOMCLI'
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumentos."NOMCLI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 340.157700000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumentos."SALTOT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumentos."SALRES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 464.882190000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumentos."SALBAI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 529.134200000000000000
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumentos."PREVIS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 593.386210000000000000
          Top = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumentos."NUMDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataSet = frxDocumentos
          DataSetName = 'frxDocumentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumentos."CODVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object HeaderChild: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677165350000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 748.346940000000000000
        ReprintOnNewPage = True
        object Memo17: TfrxMemoView
          Left = 45.354360000000000000
          Top = 3.779530000000000000
          Width = 49.133767950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 98.267780000000000000
          Top = 3.779530000000000000
          Width = 238.110236220472000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 340.157700000000000000
          Top = 3.779530000000000000
          Width = 49.133767950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 393.071120000000000000
          Top = 3.779530000000000000
          Width = 68.031417950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'RESERVADA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 464.882190000000000000
          Top = 3.779530000000000000
          Width = 49.133767950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'BAIXADA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 529.134200000000000000
          Top = 3.779530000000000000
          Width = 60.472357950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PREVIS'#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 593.386210000000000000
          Top = 3.779530000000000000
          Width = 86.929067950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 684.094930000000000000
          Top = 3.779530000000000000
          Width = 60.472357950000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 109.606370000000000000
        Width = 748.346940000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDocumentos: TfrxDBDataset
    Description = 'Documentos Child'
    UserName = 'frxDocumentos'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 368
    Top = 96
  end
end
