inherited frmFatBaixaRomaneio: TfrmFatBaixaRomaneio
  Left = 148
  Top = 137
  Width = 1136
  Height = 448
  Caption = 'Baixa de Romaneio'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1136
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 1130
    Height = 26
    BevelInner = bvNone
    BorderWidth = 1
    TabOrder = 6
    ExplicitTop = 377
    ExplicitWidth = 1130
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1001
      Height = 22
      ExplicitWidth = 1001
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ ENTER ] Marcar'
        TabOrder = 1
        OnClick = btnMarcarClick
      end
      object btnMarcarTudo: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F9 ] Marcar Tudo'
        TabOrder = 2
        OnClick = btnMarcarTudoClick
      end
      object btnObservacoes: TBitBtnLocked
        Left = 360
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ ESPA'#199'O ] Observa'#231#245'es'
        TabOrder = 3
        OnClick = btnObservacoesClick
      end
      object btnRemover: TBitBtnLocked
        Left = 510
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ DEL ] Remover documento'
        TabOrder = 4
        OnClick = btnRemoverClick
      end
      object btnRemoverItem: TBitBtnLocked
        Left = 660
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F8 ] Remover Item'
        TabOrder = 5
        OnClick = btnRemoverItemClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1003
      Top = 2
      Width = 125
      Align = alRight
      ExplicitLeft = 1003
      ExplicitTop = 2
      ExplicitWidth = 125
    end
  end
  inherited pnlStatus: TPanel
    Top = 403
    Width = 1130
    TabOrder = 7
    ExplicitTop = 403
    ExplicitWidth = 1130
    inherited pnlNomeForm: TPanel
      Left = 959
      ExplicitLeft = 959
    end
    inherited pnlInfo: TPanel
      Width = 959
      ExplicitWidth = 959
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1130
    Height = 80
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblRomaneio: TLabel
      Left = 8
      Top = 2
      Width = 47
      Height = 14
      Caption = 'Romaneio'
    end
    object lblMotorista: TLabel
      Left = 8
      Top = 38
      Width = 44
      Height = 14
      Caption = 'Motorista'
    end
    object lblCodEmp: TLabel
      Left = 89
      Top = 3
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 8
      Top = 15
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtNumRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomMot: TEditFocus
      Left = 72
      Top = 51
      Width = 340
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
    object edtCodMot: TEditFocus
      Tag = 99
      Left = 8
      Top = 51
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodMotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 153
      Top = 15
      Width = 259
      Height = 22
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 89
      Top = 15
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  object pnlRecPor: TPanel [3]
    Left = 0
    Top = 322
    Width = 1130
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Recebido por:'
    end
    object lblRecPor: TLabel
      Left = 8
      Top = 27
      Width = 450
      Height = 14
      Caption = 
        'O campo "Recebido Por:", "KM Inicial:" e "KM Final:" deve ser in' +
        'formado para cada documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblRecebidoPorObrig: TLabel
      Left = 1004
      Top = 0
      Width = 126
      Height = 28
      Align = alRight
      Caption = 'Documentos sem informar o campo "Recebido por"'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
      ExplicitLeft = 996
    end
    object Label4: TLabel
      Left = 375
      Top = 6
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'KM Inicial:'
    end
    object Label5: TLabel
      Left = 507
      Top = 6
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'KM Final:'
    end
    object edtNomRec: TEditFocus
      Tag = 99
      Left = 81
      Top = 1
      Width = 283
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 0
      OnEnter = edtNomRecEnter
      OnExit = edtNomRecExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtKMInicial: TEditFocus
      Tag = 99
      Left = 426
      Top = 1
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtKMFinal: TEditFocus
      Tag = 99
      Left = 554
      Top = 1
      Width = 73
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  object pnlDtaBai: TPanel [4]
    Left = 0
    Top = 350
    Width = 1130
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object Label2: TLabel
      Left = 20
      Top = 5
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Baixa:'
    end
    object Label3: TLabel
      Left = 153
      Top = 5
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hora Baixa:'
    end
    object mskDtaBai: TMaskEditFocus
      Tag = 99
      Left = 81
      Top = 1
      Width = 69
      Height = 22
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskHorBai: TMaskEditFocus
      Tag = 99
      Left = 210
      Top = 1
      Width = 53
      Height = 22
      EditMask = '!99:99;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object cxgDocumentos: TcxGridCitel [5]
    Left = 0
    Top = 80
    Width = 1130
    Height = 186
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgDocumentosTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosTableViewCustomDrawCell
      DataController.DataSource = dtsDocumentos
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
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgDocumentosGER_MARDES: TcxGridDBColumn
        Caption = '  '
        DataBinding.FieldName = 'GER_MARDES'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = imgLista
        Properties.Items = <
          item
            ImageIndex = 0
            Value = 'D'
          end
          item
            ImageIndex = 1
            Value = 'M'
          end>
        Width = 27
      end
      object cxgDocumentosGER_ROMIMP: TcxGridDBColumn
        Caption = 'Impress.'
        DataBinding.FieldName = 'GER_ROMIMP'
        Width = 55
      end
      object cxgDocumentosGER_DTAROM: TcxGridDBColumn
        Caption = 'Dt.Romaneio'
        DataBinding.FieldName = 'GER_DTAROM'
        Width = 77
      end
      object cxgDocumentosGER_HORROM: TcxGridDBColumn
        Caption = 'Hr.Romaneio'
        DataBinding.FieldName = 'GER_HORROM'
        Width = 75
      end
      object cxgDocumentosGER_DTAENT: TcxGridDBColumn
        Caption = 'Data Entrada'
        DataBinding.FieldName = 'GER_DTAENT'
        Width = 77
      end
      object cxgDocumentosGER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
        Width = 119
      end
      object cxgDocumentosGER_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
        Width = 36
      end
      object cxgDocumentosGER_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'GER_NOMCLI'
        Width = 68
      end
      object cxgDocumentosCID_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Width = 95
      end
      object cxgDocumentosGER_CODVEN: TcxGridDBColumn
        Caption = 'Vend.'
        DataBinding.FieldName = 'GER_CODVEN'
        Width = 116
      end
      object cxgDocumentosTRA_NOMTRA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'TRA_NOMTRA'
        Width = 135
      end
      object cxgDocumentosGER_VLRCON: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'GER_VLRCON'
        Width = 69
      end
      object cxgDocumentosGER_DTABAI: TcxGridDBColumn
        Caption = 'Dt.Baixa'
        DataBinding.FieldName = 'GER_DTABAI'
        Width = 69
      end
      object cxgDocumentosGER_HORBAI: TcxGridDBColumn
        Caption = 'Hr.Baixa'
        DataBinding.FieldName = 'GER_HORBAI'
        Width = 71
      end
      object cxgDocumentosGER_NOMREC: TcxGridDBColumn
        Caption = 'Recebido Por'
        DataBinding.FieldName = 'GER_NOMREC'
        Width = 288
      end
      object cxgDocumentosDESTACAR: TcxGridDBColumn
        DataBinding.FieldName = 'DESTACAR'
        Visible = False
      end
      object cxgDocumentosGER_KMINI: TcxGridDBColumn
        Caption = 'KM Inicial'
        DataBinding.FieldName = 'GER_KMINI'
        BestFitMaxWidth = 80
        MinWidth = 80
        Width = 80
      end
      object cxgDocumentosGER_KMFIM: TcxGridDBColumn
        Caption = 'KM Final'
        DataBinding.FieldName = 'GER_KMFIM'
        BestFitMaxWidth = 80
        MinWidth = 80
        Width = 80
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
  object pnlAjudantes: TPanel [6]
    Left = 0
    Top = 294
    Width = 1130
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lbl1: TLabel
      Left = 23
      Top = 6
      Width = 52
      Height = 14
      Caption = 'Ajudantes:'
    end
    object edtNomAj1: TEditFocus
      Tag = 99
      Left = 81
      Top = 1
      Width = 150
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj2: TEditFocus
      Tag = 99
      Left = 233
      Top = 1
      Width = 150
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj4: TEditFocus
      Tag = 99
      Left = 537
      Top = 1
      Width = 150
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomAj3: TEditFocus
      Tag = 99
      Left = 385
      Top = 1
      Width = 150
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlEntPen: TPanel [7]
    Left = 0
    Top = 266
    Width = 1130
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Label8: TLabel
      Left = 8
      Top = 27
      Width = 450
      Height = 14
      Caption = 
        'O campo "Recebido Por:", "KM Inicial:" e "KM Final:" deve ser in' +
        'formado para cada documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object chkEntPen: TCheckBox
      Left = 8
      Top = 5
      Width = 116
      Height = 17
      Caption = 'Entrega Pendente'
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 239
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 367
    Top = 16
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDocumentos'
    Left = 335
    Top = 16
  end
  object dspDocumentos: TUniDataSetProvider
    DataSet = qryDocumentos
    Options = []
    Left = 303
    Top = 16
  end
  object qryDocumentos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 271
    Top = 16
  end
  object qryItens: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.LongStrings = False
    Constraints = <>
    Left = 431
    Top = 16
  end
  object dspItens: TUniDataSetProvider
    DataSet = qryItens
    Options = []
    Left = 463
    Top = 16
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 495
    Top = 16
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 527
    Top = 16
  end
  object imgLista: TImageList
    Left = 152
    Top = 233
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDE00D6D6D600D6D6D600D6D6D600DEDEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC1FFFFF00000000EFF7FFFF00000000
      C7E3C1FF0000000083C1C0FF00000000C183C07F00000000E007803F00000000
      F00F801F00000000F81F800F00000000F81F040700000000F00F060300000000
      E0078F0000000000C183FFC00000000083C1FFE000000000C7E3FFF100000000
      EFF7FFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
