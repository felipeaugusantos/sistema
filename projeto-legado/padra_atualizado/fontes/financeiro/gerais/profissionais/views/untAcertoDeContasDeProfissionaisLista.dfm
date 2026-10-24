inherited frmAcertoDeContasDeProfissionaisLista: TfrmAcertoDeContasDeProfissionaisLista
  Width = 1024
  Height = 568
  BorderIcons = [biSystemMenu]
  Caption = 'Lista de Comiss'#245'es em Aberto'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 495
    Width = 1018
    ExplicitTop = 511
    ExplicitWidth = 791
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 787
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 708
    end
  end
  inherited pnlStatus: TPanel
    Top = 523
    Width = 1018
    ExplicitTop = 495
    ExplicitWidth = 791
    inherited pnlNomeForm: TPanel
      Left = 751
      Width = 267
      ExplicitLeft = 524
      ExplicitWidth = 267
    end
    inherited pnlInfo: TPanel
      Width = 751
      ExplicitWidth = 524
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 495
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = -3
    ExplicitWidth = 791
    object grdListaComissoes: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1016
      Height = 458
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitLeft = 2
      ExplicitTop = -1
      ExplicitHeight = 493
      object grdListaComissoesDados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsListaComissoes
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            FieldName = 'COM_VRCOMI'
            Column = grdListaComissoesDadosCOM_VRCOMI
          end
          item
            Kind = skCount
            FieldName = 'COM_CODCOM'
            Column = grdListaComissoesDadosCOM_CODCOM
            DisplayText = 'Qtde.'
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
        object grdListaComissoesDadosCOM_CODCOM: TcxGridDBColumn
          Caption = 'C'#243'digo Comiss'#227'o'
          DataBinding.FieldName = 'COM_CODCOM'
          Width = 101
        end
        object grdListaComissoesDadosCOM_DTACAD: TcxGridDBColumn
          Caption = 'Data Comiss'#227'o'
          DataBinding.FieldName = 'COM_DTACAD'
          HeaderAlignmentHorz = taCenter
          Width = 93
        end
        object grdListaComissoesDadosCOM_CREDEB: TcxGridDBColumn
          Caption = 'C_D'
          DataBinding.FieldName = 'COM_CREDEB'
          Width = 32
        end
        object grdListaComissoesDadosCONTASARECEBER: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'CONTASARECEBER'
          Width = 183
        end
        object grdListaComissoesDadosCOM_VRVEND: TcxGridDBColumn
          Caption = 'Valor Venda'
          DataBinding.FieldName = 'COM_VRVEND'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 79
        end
        object grdListaComissoesDadosCOM_VRCOMI: TcxGridDBColumn
          Caption = 'Valor Comiss'#227'o'
          DataBinding.FieldName = 'COM_VRCOMI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 90
        end
        object grdListaComissoesDadosCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Nome Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 178
        end
        object grdListaComissoesDadosVENDEDOR: TcxGridDBColumn
          Caption = 'Vendedor'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 227
        end
      end
      object grdListaComissoesNivel: TcxGridLevel
        GridView = grdListaComissoesDados
      end
    end
    object pnlTotais: TPanel
      Left = 1
      Top = 459
      Width = 1016
      Height = 35
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      ExplicitTop = 458
      object Label21: TLabel
        Left = 792
        Top = 10
        Width = 109
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total Comiss'#245'es:'
      end
      object Label6: TLabel
        Left = 617
        Top = 10
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtde. Comiss'#245'es:'
      end
      object edtQtdComissoes: TEditFocus
        Left = 704
        Top = 6
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorTotal: TEditFocus
        Left = 907
        Top = 6
        Width = 98
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
  end
  object dtsListaComissoes: TDataSource
    AutoEdit = False
    Left = 460
    Top = 168
  end
end
