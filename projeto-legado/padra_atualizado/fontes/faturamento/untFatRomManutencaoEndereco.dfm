inherited frmFatRomManutencaoEndereco: TfrmFatRomManutencaoEndereco
  Width = 784
  Height = 939
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o de Endere'#231'os'
  OnDestroy = FormDestroy
  ExplicitWidth = 784
  ExplicitHeight = 939
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 868
    Width = 778
    TabOrder = 1
    ExplicitTop = 868
    ExplicitWidth = 778
    inherited FlwBotoes: TFlowPanel
      Width = 774
      ExplicitWidth = 774
      inherited btnConfirma: TBitBtnLocked
        Width = 113
        Caption = '[F10] &Confirma'
        ExplicitWidth = 113
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 141
        Height = 22
        Caption = '[Ctrl + F4] Desmarca Todos'
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 254
        Top = 0
        Width = 124
        Height = 22
        Caption = '[Ctrl + F3] Marca Todos'
        TabOrder = 2
        OnClick = btnMarcaTodosClick
      end
      object btnOutroModo: TBitBtnLocked
        Left = 378
        Top = 0
        Width = 195
        Height = 22
        Caption = '[F6] Escolher outro modo de entrega'
        TabOrder = 3
        OnClick = btnOutroModoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 695
      ModalResult = 0
      ExplicitLeft = 695
    end
  end
  inherited pnlStatus: TPanel
    Top = 894
    Width = 778
    TabOrder = 2
    ExplicitTop = 894
    ExplicitWidth = 778
    inherited pnlNomeForm: TPanel
      Left = 607
      ExplicitLeft = 607
    end
    inherited pnlInfo: TPanel
      Width = 607
      ExplicitWidth = 607
    end
  end
  object gpbEnderecoEntrega: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 778
    Height = 225
    Align = alTop
    Caption = 'Dados da entrega'
    TabOrder = 0
    object lblEndCon: TLabel
      Left = 37
      Top = 145
      Width = 49
      Height = 14
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblBaiCon: TLabel
      Left = 203
      Top = 173
      Width = 32
      Height = 14
      Caption = 'Bairro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblComple: TLabel
      Left = 19
      Top = 173
      Width = 67
      Height = 14
      Caption = 'Complemento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCidade: TLabel
      Left = 186
      Top = 119
      Width = 36
      Height = 14
      Caption = 'Cidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCep: TLabel
      Left = 64
      Top = 118
      Width = 22
      Height = 14
      Caption = 'CEP:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblTipEnt: TLabel
      Left = 11
      Top = 25
      Width = 77
      Height = 57
      AutoSize = False
      Caption = 'A entrega ser'#225' realizada no endere'#231'o da Transportadora:'
      Layout = tlBottom
      WordWrap = True
    end
    object Shape2: TShape
      Left = 25
      Top = 98
      Width = 550
      Height = 1
      Pen.Color = clGray
    end
    object lblEndRef: TLabel
      Left = 30
      Top = 201
      Width = 56
      Height = 14
      Caption = 'Refer'#234'ncia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtEndEnt: TEditFocus
      Tag = 99
      Left = 92
      Top = 142
      Width = 493
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBaiEnt: TEditFocus
      Tag = 99
      Left = 241
      Top = 170
      Width = 222
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtComple: TEditFocus
      Tag = 99
      Left = 92
      Top = 170
      Width = 99
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 227
      Top = 115
      Width = 69
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
      TabOrder = 4
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
      Left = 296
      Top = 115
      Width = 246
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtEstado: TEditFocus
      Left = 545
      Top = 115
      Width = 37
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtCepEnt: TEditFocus
      Tag = 99
      Left = 92
      Top = 115
      Width = 87
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
      TabOrder = 3
      OnKeyPress = edtCepEntKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtRefEnt: TEditFocus
      Tag = 99
      Left = 92
      Top = 198
      Width = 371
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgEntrega: TRadioGroup
      Left = 92
      Top = 16
      Width = 457
      Height = 41
      Caption = 'A entrega ser'#225' realizada no endere'#231'o ?'
      Columns = 3
      Items.Strings = (
        'Transportadora'
        'Transbordo'
        'Retirar na Filial')
      TabOrder = 0
      OnClick = rdgEntregaClick
    end
    object pnlTransp: TPanel
      Left = 94
      Top = 63
      Width = 469
      Height = 25
      BevelOuter = bvNone
      TabOrder = 1
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 2
        Top = 0
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 78
        Top = 0
        Width = 387
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    object pnlFilial: TPanel
      Left = 545
      Top = 20
      Width = 469
      Height = 25
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object edtCodFil: TEditFocus
        Tag = 99
        Left = 2
        Top = 0
        Width = 70
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodFilKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomFil: TEditFocus
        Left = 78
        Top = 0
        Width = 387
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    object btnConfirmaCapa: TBitBtnLocked
      Left = 510
      Top = 197
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 11
      OnClick = btnConfirmaCapaClick
    end
  end
  object cxgDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 225
    Width = 778
    Height = 643
    Align = alClient
    Enabled = False
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTv: TcxGridDBTableViewCitel
      OnDblClick = cxgDocumentosTvDblClick
      OnKeyDown = cxgDocumentosTvKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosTvCustomDrawCell
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
      object cxgDocumentosTvGER_TIPENT: TcxGridDBColumn
        Caption = 'Entrega'
        DataBinding.FieldName = 'GER_TIPENT'
        OnGetDisplayText = cxgDocumentosTvGER_TIPENTGetDisplayText
      end
      object cxgDocumentosTvGER_CODFIL: TcxGridDBColumn
        Caption = 'Filial'
        DataBinding.FieldName = 'GER_CODFIL'
      end
      object cxgDocumentosTvGER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
      end
      object cxgDocumentosTvGER_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
      end
      object cxgDocumentosTvGER_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente/Descri'#231#227'o Entr.'
        DataBinding.FieldName = 'GER_NOMCLI'
      end
      object cxgDocumentosTvGER_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'GER_NOMCID'
      end
      object cxgDocumentosTvGER_ESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'GER_ESTADO'
      end
      object cxgDocumentosTvGER_BAIRRO: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'GER_BAIRRO'
      end
      object cxgDocumentosTvGER_ENDCON: TcxGridDBColumn
        Caption = 'End. Entrega'
        DataBinding.FieldName = 'GER_ENDCON'
      end
      object cxgDocumentosTvGER_CEPCON: TcxGridDBColumn
        Caption = 'CEP Entrega'
        DataBinding.FieldName = 'GER_CEPCON'
      end
      object cxgDocumentosTvGER_TRANSP: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'GER_TRANSP'
      end
    end
    object cxgDocumentosLvl: TcxGridLevel
      GridView = cxgDocumentosTv
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 632
  end
end
