inherited frmRcxLiberacaoDeCaixasDocumentosTF: TfrmRcxLiberacaoDeCaixasDocumentosTF
  Width = 997
  Height = 518
  BorderIcons = [biSystemMenu]
  Caption = 'Libera'#231#227'o de Caixas - Documentos Transferidos'
  Position = poScreenCenter
  ExplicitWidth = 997
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 445
    Width = 991
    TabOrder = 1
    ExplicitTop = 445
    ExplicitWidth = 991
    inherited FlwBotoes: TFlowPanel
      Width = 987
      ExplicitWidth = 987
      object btnEditarDocumento: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F2 ] Editar Documento'
        TabOrder = 0
        OnClick = btnEditarDocumentoClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 252
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnConfirmar: TBitBtnLocked
        Left = 372
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 3
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 908
      ExplicitLeft = 908
    end
  end
  inherited pnlStatus: TPanel
    Top = 473
    Width = 991
    TabOrder = 2
    ExplicitTop = 473
    ExplicitWidth = 991
    inherited pnlNomeForm: TPanel
      Left = 676
      Width = 315
      ExplicitLeft = 676
      ExplicitWidth = 315
    end
    inherited pnlInfo: TPanel
      Width = 676
      ExplicitWidth = 676
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 991
    Height = 417
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object grdLancamentos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 989
      Height = 415
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDadosCartoes: TcxGridDBTableViewCitel
        OnKeyDown = grdLancamentosDadosCartoesKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosCartoesCustomDrawCell
        DataController.DataSource = dtsLancamentos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = grdLancamentosDadosCartoesVALOR
          end
          item
            Kind = skSum
            Column = grdLancamentosDadosCartoesVALORSELECIONADO
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosCartoesCAR_DESCAR: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'CAR_DESCAR'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 186
        end
        object grdLancamentosDadosCartoesDOCUMENTO: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'MCA_NUMDUP'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 76
        end
        object grdLancamentosDadosCartoesPARCELAS: TcxGridDBColumn
          Caption = 'Parcelas'
          DataBinding.FieldName = 'PARCELAS'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 52
        end
        object grdLancamentosDadosCartoesMCA_CODCLI: TcxGridDBColumn
          Caption = 'C'#243'd. Cliente'
          DataBinding.FieldName = 'MCA_CODCLI'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 66
        end
        object grdLancamentosDadosCartoesCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 176
        end
        object grdLancamentosDadosCartoesVALOR: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VALOR'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 83
        end
        object grdLancamentosDadosCartoesMCA_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'MCA_DTACAD'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DisplayFormat = 'dd/mm/yyyy'
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
        end
        object grdLancamentosDadosCartoesMCA_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'MCA_DTAVEN'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DisplayFormat = 'dd/mm/yyyy'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
        end
        object grdLancamentosDadosCartoesMCA_NUMCCD: TcxGridDBColumn
          Caption = 'N'#250'm. Libera'#231#227'o'
          DataBinding.FieldName = 'MCA_NUMCCD'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 98
        end
        object grdLancamentosDadosCartoesMCA_NUMNSU: TcxGridDBColumn
          Caption = 'N'#250'm. NSU'
          DataBinding.FieldName = 'MCA_NUMNSU'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 129
        end
        object grdLancamentosDadosCartoesMCA_DOCUME: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'MCA_DOCUME'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 171
        end
        object grdLancamentosDadosCartoesVALORSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'VALORSELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosCartoesSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object grdLancamentosDadosCheques: TcxGridDBTableViewCitel
        OnKeyDown = grdLancamentosDadosCartoesKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosChequesCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = grdLancamentosDadosChequesCHQ_VALCHQ
            VisibleForCustomization = False
          end
          item
            Kind = skSum
            Column = grdLancamentosDadosChequesVALORSELECIONADO
            VisibleForCustomization = False
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosChequesCHQ_CODBCO: TcxGridDBColumn
          Caption = 'Banco'
          DataBinding.FieldName = 'CHQ_CODBCO'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 49
        end
        object grdLancamentosDadosChequesCHQ_NUMAGE: TcxGridDBColumn
          Caption = 'Ag'#234'ncia'
          DataBinding.FieldName = 'CHQ_NUMAGE'
        end
        object grdLancamentosDadosChequesCHQ_CONCOR: TcxGridDBColumn
          Caption = 'N'#250'm. Conta'
          DataBinding.FieldName = 'CHQ_CONCOR'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 109
        end
        object grdLancamentosDadosChequesCHQ_NUMCHQ: TcxGridDBColumn
          Caption = 'N'#250'm. Cheque'
          DataBinding.FieldName = 'CHQ_NUMCHQ'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 115
        end
        object grdLancamentosDadosChequesCHQ_CODCLI: TcxGridDBColumn
          Caption = 'C'#243'd. Cliente'
          DataBinding.FieldName = 'CHQ_CODCLI'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 68
        end
        object grdLancamentosDadosChequesCHQ_NOMEMI: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'CHQ_NOMEMI'
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 240
        end
        object grdLancamentosDadosChequesCHQ_VALCHQ: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CHQ_VALCHQ'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 83
        end
        object grdLancamentosDadosChequesCHQ_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'CHQ_DTACAD'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.DisplayFormat = 'dd/mm/yyyy'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
        end
        object grdLancamentosDadosChequesCHQ_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CHQ_DTAVEN'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.AutoWidthSizable = False
          Width = 69
        end
        object grdLancamentosDadosChequesVALORSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'VALORSELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
        object grdLancamentosDadosChequesSELECIONADO: TcxGridDBColumn
          DataBinding.FieldName = 'SELECIONADO'
          Visible = False
          VisibleForCustomization = False
          IsCaptionAssigned = True
        end
      end
      object grdLancamentosNivelCartoes: TcxGridLevel
        GridView = grdLancamentosDadosCartoes
      end
      object grdLancamentosNivelCheques: TcxGridLevel
        GridView = grdLancamentosDadosCheques
      end
    end
  end
  object pnlTail: TPanel [3]
    Left = 0
    Top = 417
    Width = 991
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object lblValorTotal: TLabel
      Left = 636
      Top = 6
      Width = 53
      Height = 14
      Caption = 'Valor Total:'
    end
    object lblTotalSelecionados: TLabel
      Left = 794
      Top = 6
      Width = 93
      Height = 14
      Caption = 'Total Selecionados:'
    end
    object edtTotalSelecionados: TEditFocus
      Left = 892
      Top = 2
      Width = 92
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtValorTotal: TEditFocus
      Left = 696
      Top = 2
      Width = 92
      Height = 22
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object dtsLancamentos: TDataSource
    AutoEdit = False
    Left = 400
    Top = 112
  end
end
