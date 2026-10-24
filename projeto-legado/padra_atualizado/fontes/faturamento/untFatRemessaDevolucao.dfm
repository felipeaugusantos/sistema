inherited frmFatRemessaDevolucao: TfrmFatRemessaDevolucao
  Width = 1128
  Height = 712
  Caption = 'Remessa de Devolu'#231#227'o'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1128
  ExplicitHeight = 712
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 637
    Width = 1122
    Height = 30
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 637
    ExplicitWidth = 1122
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 1118
      Height = 26
      ExplicitWidth = 1118
      ExplicitHeight = 26
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 129
        Height = 22
        Caption = '[ F10 ] Confirmar'
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object BtnImprimir: TBitBtnLocked
        Left = 129
        Top = 0
        Width = 129
        Height = 22
        Caption = '[ F7 ] Imprimir Remessa'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = BtnImprimirClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 258
        Top = 0
        Width = 183
        Height = 22
        Caption = '[ F6 ] Cancelar Remessa Gerada'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnCancelarClick
      end
      object btnNovaRemessa: TBitBtnLocked
        Left = 441
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F8 ] Nova Remessa'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnNovaRemessaClick
      end
      object btnDocumentosPendentes: TBitBtnLocked
        Left = 561
        Top = 0
        Width = 160
        Height = 22
        Caption = '[ F9 ] Documentos Pendentes'
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDocumentosPendentesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1041
      Top = 2
      ExplicitLeft = 1041
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 667
    Width = 1122
    TabOrder = 3
    ExplicitTop = 667
    ExplicitWidth = 1122
    inherited pnlNomeForm: TPanel
      Left = 902
      Width = 220
      ExplicitLeft = 951
      ExplicitWidth = 220
    end
    inherited pnlInfo: TPanel
      Width = 902
      ExplicitWidth = 951
    end
  end
  inherited pgcDados: TPageControl
    Width = 1122
    Height = 637
    TabOrder = 2
    ExplicitWidth = 1122
    ExplicitHeight = 637
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1114
      ExplicitHeight = 605
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 1122
    Height = 637
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlOperacao: TPanel
      Left = 1
      Top = 595
      Width = 1120
      Height = 41
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      TabStop = True
      DesignSize = (
        1120
        41)
      object lblOperacao: TLabel
        Left = 12
        Top = 17
        Width = 51
        Height = 14
        Caption = 'Opera'#231#227'o:'
      end
      object rdgOperacao: TRadioGroup
        Left = 63
        Top = 3
        Width = 1054
        Height = 31
        Anchors = [akLeft, akTop, akRight]
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Gerar Remessa'
          'Gerar Transfer'#234'ncia'
          'Gerar Reserva para Outras Sa'#237'das para Fornecedor'
          'Liberar para Guardar Devolu'#231#227'o no Coletor')
        TabOrder = 0
        TabStop = True
      end
    end
    object pnlInfoRemessa: TPanel
      Left = 1
      Top = 570
      Width = 1120
      Height = 25
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblLegendaDelRemessa: TLabel
        Left = 12
        Top = 6
        Width = 229
        Height = 14
        Caption = 'Pressione [DEL] para excluir um registro do grid'
      end
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 1120
      Height = 65
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblNumeroRemessa: TLabel
        Left = 140
        Top = 8
        Width = 78
        Height = 14
        Caption = 'N'#186' da Remessa:'
      end
      object lblBarraChave: TLabel
        Left = 12
        Top = 41
        Width = 203
        Height = 14
        Caption = 'C'#243'digo de Barras - Chave de Acesso Nfe:'
      end
      object lblInformacaoRemessa: TLabel
        Left = 471
        Top = 10
        Width = 109
        Height = 14
        Caption = 'lblInformacaoRemessa'
      end
      object edtNumeroRemessa: TEditFocus
        Left = 219
        Top = 5
        Width = 126
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 12
        TabOrder = 0
        OnExit = edtNumeroRemessaExit
        OnKeyPress = edtNumeroRemessaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object EdtBarraChave: TEditFocus
        Left = 219
        Top = 38
        Width = 278
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 44
        TabOrder = 2
        OnKeyPress = EdtBarraChaveKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnConsultar: TBitBtnLocked
        Left = 351
        Top = 5
        Width = 114
        Height = 22
        Caption = '&Consultar'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnConsultarClick
      end
      object btnIncluir: TBitBtnLocked
        Left = 503
        Top = 38
        Width = 82
        Height = 22
        Caption = '&Incluir'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnIncluirClick
      end
    end
    object cxgRemessa: TcxGridCitel
      Left = 1
      Top = 66
      Width = 1120
      Height = 504
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgRemessaDBTableViewCitel: TcxGridDBTableViewCitel
        OnKeyDown = cxgRemessaDBTableViewCitelKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsRemessa
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
        object cxgRemessaDTAENT: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DTAENT'
        end
        object cxgRemessaHORENT: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'HORENT'
        end
        object cxgRemessaNUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'NUMDOC'
          Width = 102
        end
        object cxgRemessaESPDOC: TcxGridDBColumn
          Caption = 'Esp.'
          DataBinding.FieldName = 'ESPDOC'
          Width = 46
        end
        object cxgRemessaCODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CODEMP'
          Width = 45
        end
        object cxgRemessaCODCLI: TcxGridDBColumn
          Caption = 'C'#243'd. Cliente'
          DataBinding.FieldName = 'CODCLI'
          Width = 128
        end
        object cxgRemessaNOMCLI: TcxGridDBColumn
          Caption = 'Nome Cliente'
          DataBinding.FieldName = 'NOMCLI'
        end
        object cxgRemessaACESSO: TcxGridDBColumn
          Caption = 'Chave de Acesso'
          DataBinding.FieldName = 'ACESSO'
        end
      end
      object cxgRemessaLevel: TcxGridLevel
        GridView = cxgRemessaDBTableViewCitel
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1048
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1016
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 944
    Top = 24
  end
  object cdsRemessa: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 952
    Top = 360
    object cdsRemessaDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsRemessaHORENT: TTimeField
      FieldName = 'HORENT'
    end
    object cdsRemessaNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsRemessaESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsRemessaCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsRemessaCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsRemessaNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsRemessaACESSO: TStringField
      FieldName = 'ACESSO'
      Size = 50
    end
    object cdsRemessaAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object dtsRemessa: TDataSource
    DataSet = cdsRemessa
    Left = 952
    Top = 424
  end
end
