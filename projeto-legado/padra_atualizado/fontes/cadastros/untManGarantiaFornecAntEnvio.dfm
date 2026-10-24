inherited frmManGarantiaFornecAntEnvio: TfrmManGarantiaFornecAntEnvio
  Width = 800
  Height = 600
  Caption = 'Manuten'#231#227'o do Fornecedor Antes do Envio'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 794
    Height = 26
    TabOrder = 2
    ExplicitTop = 529
    ExplicitWidth = 794
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 713
      Height = 22
      ExplicitWidth = 713
      ExplicitHeight = 22
      object btnConfirmar: TBitBtnLocked
        Tag = 99
        Left = 0
        Top = 0
        Width = 128
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Tag = 1
        Left = 128
        Top = 0
        Width = 128
        Height = 22
        Align = alLeft
        Caption = '[ F8 ] Marcar Todos'
        Enabled = False
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 256
        Top = 0
        Width = 128
        Height = 22
        Align = alLeft
        Caption = '[ F9 ] Desmarcar Todos'
        Enabled = False
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      Top = 2
      Align = alRight
      ExplicitLeft = 715
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
      object shpMultSel: TShape
        Left = 606
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Anchors = [akTop, akRight]
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 147
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 9
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 10
      Top = 52
      Width = 33
      Height = 14
      Caption = 'Marca:'
    end
    object Label3: TLabel
      Left = 10
      Top = 95
      Width = 62
      Height = 14
      Caption = 'Linha/Grupo:'
    end
    object Label4: TLabel
      Left = 436
      Top = 9
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label5: TLabel
      Left = 436
      Top = 52
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
    end
    object Label6: TLabel
      Left = 516
      Top = 95
      Width = 50
      Height = 14
      Caption = 'Data Final:'
    end
    object Label7: TLabel
      Left = 436
      Top = 95
      Width = 54
      Height = 14
      Caption = 'Data Inicial:'
    end
    object Label8: TLabel
      Left = 593
      Top = 115
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNomFor: TEditFocus
      Left = 80
      Top = 24
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 10
      Top = 24
      Width = 67
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
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 436
      Top = 112
      Width = 67
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
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 515
      Top = 112
      Width = 68
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
      TabOrder = 9
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 10
      Top = 68
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 2
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 80
      Top = 68
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescProd: TEditFocus
      Tag = 99
      Left = 436
      Top = 24
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 200
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Tag = 99
      Left = 436
      Top = 68
      Width = 348
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 200
      TipoTexto = ttAlfanumerico
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 10
      Top = 112
      Width = 67
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
      TabOrder = 4
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
      Left = 80
      Top = 112
      Width = 348
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 147
    Width = 794
    Height = 334
    Align = alClient
    TabOrder = 1
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosGrid1DBTableView1: TcxGridDBTableView
      OnDblClick = cxDadosGrid1DBTableView1DblClick
      OnKeyDown = cxDadosGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxDadosGrid1DBTableView1CustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object NUMENT: TcxGridDBColumn
        Caption = 'N'#186' Garantia'
        DataBinding.FieldName = 'NUMENT'
        Options.Editing = False
        Width = 122
      end
      object CODITE: TcxGridDBColumn
        Caption = 'Cod.Prod.'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 55
      end
      object CODFAB: TcxGridDBColumn
        Caption = 'Cod. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 138
      end
      object DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 233
      end
      object REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Width = 105
      end
      object SIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
      end
      object NOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 194
      end
      object DTAENT: TcxGridDBColumn
        Caption = 'Dt.Entrada'
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Width = 78
      end
      object DOCVENDA: TcxGridDBColumn
        Caption = 'N'#250'm. Doc. Venda'
        DataBinding.FieldName = 'DOCVENDA'
        Options.Editing = False
      end
      object EMPDOC: TcxGridDBColumn
        Caption = 'Empresa Venda'
        DataBinding.FieldName = 'EMPDOC'
        Options.Editing = False
      end
      object QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Options.Editing = False
        Width = 71
      end
      object MARCA: TcxGridDBColumn
        DataBinding.FieldName = 'MARCA'
        Visible = False
      end
      object UC_FORNEC: TcxGridDBColumn
        DataBinding.FieldName = 'UC_FORNEC'
        Options.Editing = False
        Width = 318
      end
      object UC_DTAENT: TcxGridDBColumn
        DataBinding.FieldName = 'UC_DTAENT'
        Options.Editing = False
        Width = 109
      end
      object UC_QTDITE: TcxGridDBColumn
        DataBinding.FieldName = 'UC_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 101
      end
    end
    object cxDadosGrid1Level1: TcxGridLevel
      GridView = cxDadosGrid1DBTableView1
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 481
    Width = 794
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    object grbLegenda: TGroupBox
      Left = 7
      Top = 2
      Width = 121
      Height = 42
      Caption = 'Legenda de cores'
      TabOrder = 0
      object Shape2: TShape
        Left = 8
        Top = 20
        Width = 14
        Height = 13
        Brush.Color = clGreen
        Pen.Color = clGreen
      end
      object Label9: TLabel
        Left = 26
        Top = 19
        Width = 74
        Height = 14
        Caption = 'Itens Marcados'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <
      item
        Name = 'NUMENT'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'CODFAB'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'REFERE'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'SIGUNI'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'CODFOR'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'NOMFOR'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'DTAENT'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'QTDITE'
        DataType = ftFloat
      end
      item
        Name = 'MARCA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMDOC'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'ESPDOC'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'EMPDOC'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'REPOST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VALITE'
        DataType = ftCurrency
      end
      item
        Name = 'QTDDEV'
        DataType = ftFloat
      end
      item
        Name = 'OBSP_1'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'OBSP_2'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODEMP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'GARFIL'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'UC_FORNEC'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'UC_DTAENT'
        DataType = ftDate
      end
      item
        Name = 'UC_QTDITE'
        DataType = ftFloat
      end
      item
        Name = 'DOCVENDA'
        DataType = ftString
        Size = 17
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 707
    Top = 104
    object cdsDadosNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsDadosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsDadosCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsDadosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDadosREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsDadosSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsDadosCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsDadosNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Size = 60
    end
    object cdsDadosDTAENT: TStringField
      FieldName = 'DTAENT'
      Size = 10
    end
    object cdsDadosQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsDadosMARCA: TStringField
      FieldName = 'MARCA'
      Size = 1
    end
    object cdsDadosNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 14
    end
    object cdsDadosESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsDadosEMPDOC: TStringField
      FieldName = 'EMPDOC'
      Size = 3
    end
    object cdsDadosREPOST: TStringField
      FieldName = 'REPOST'
      Size = 1
    end
    object cdsDadosVALITE: TCurrencyField
      FieldName = 'VALITE'
    end
    object cdsDadosQTDDEV: TFloatField
      FieldName = 'QTDDEV'
    end
    object cdsDadosOBSP_1: TStringField
      FieldName = 'OBSP_1'
      Size = 70
    end
    object cdsDadosOBSP_2: TStringField
      FieldName = 'OBSP_2'
      Size = 70
    end
    object cdsDadosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsDadosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDadosGARFIL: TStringField
      FieldName = 'GARFIL'
      Size = 1
    end
    object cdsDadosUC_FORNEC: TStringField
      DisplayLabel = 'Fornecedor '#218'lt. Compra'
      FieldName = 'UC_FORNEC'
      Size = 60
    end
    object cdsDadosUC_DTAENT: TDateField
      DisplayLabel = 'Dt. '#218'lt. Compra'
      FieldName = 'UC_DTAENT'
    end
    object cdsDadosUC_QTDITE: TFloatField
      DisplayLabel = 'Qtd '#218'lt. Compra'
      FieldName = 'UC_QTDITE'
    end
    object cdsDadosDOCVENDA: TStringField
      FieldName = 'DOCVENDA'
      Size = 17
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 709
    Top = 140
  end
end
