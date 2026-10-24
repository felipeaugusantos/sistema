inherited frmGarantiaRetornoColeta: TfrmGarantiaRetornoColeta
  Width = 1129
  Height = 488
  Caption = 'Retorno de Coleta de  Produtos em Garantia'
  Position = poMainFormCenter
  ExplicitWidth = 1129
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 415
    Width = 1123
    ExplicitTop = 415
    ExplicitWidth = 1123
    inherited FlwBotoes: TFlowPanel
      Width = 1119
      ExplicitWidth = 1119
      object btnProcessar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 193
        Height = 25
        Caption = '[F10] Processar Retornos de Coleta'
        TabOrder = 0
        OnClick = btnProcessarClick
      end
      object btnExcel: TBitBtnLocked
        Left = 193
        Top = 0
        Width = 94
        Height = 24
        Anchors = [akBottom]
        Caption = '[ F6 ] Exp. Excel'
        TabOrder = 1
        OnClick = btnExcelClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1043
      ExplicitLeft = 1043
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 1123
    ExplicitTop = 443
    ExplicitWidth = 1123
    inherited pnlNomeForm: TPanel
      Left = 952
      ExplicitLeft = 952
    end
    inherited pnlInfo: TPanel
      Width = 952
      ExplicitWidth = 952
    end
  end
  object pnlGrid: TPanel [2]
    Left = 0
    Top = 41
    Width = 1123
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 2
    object dbgridColeta: TcxGridCitel
      Left = 0
      Top = 0
      Width = 1123
      Height = 367
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 374
      object dbgridColetaDBTableViewCitel1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object dbgridColetaDBTableViewCitel1FGO_DTAENT: TcxGridDBColumn
          Caption = 'Dt Pedido'
          DataBinding.FieldName = 'FGO_DTAENT'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 60
        end
        object dbgridColetaDBTableViewCitel1PEDIDO: TcxGridDBColumn
          Caption = 'Pedido'
          DataBinding.FieldName = 'PEDIDO'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgridColetaDBTableViewCitel1CLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Options.Editing = False
          Width = 200
        end
        object dbgridColetaDBTableViewCitel1FDO_QTDITE: TcxGridDBColumn
          Caption = 'Qtd Coleta'
          DataBinding.FieldName = 'FDO_QTDITE'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 100
        end
        object dbgridColetaDBTableViewCitel1DOCDEVOLUCAO: TcxGridDBColumn
          Caption = 'Doc Devolu'#231#227'o'
          DataBinding.FieldName = 'DOCDEVOLUCAO'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgridColetaDBTableViewCitel1PRODUTO: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'PRODUTO'
          Options.Editing = False
          Width = 200
        end
        object dbgridColetaDBTableViewCitel1UN: TcxGridDBColumn
          Caption = 'Un'
          DataBinding.FieldName = 'UNI_SIGUNI'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
        end
        object dbgridColetaDBTableViewCitel1QTDSEMAVARIA: TcxGridDBColumn
          Caption = 'Qtd Sem Avaria'
          DataBinding.FieldName = 'QTDSEMAVARIA'
          OnCustomDrawCell = dbgridColetaDBTableViewCitel1QTDSEMAVARIACustomDrawCell
          HeaderAlignmentHorz = taRightJustify
          Width = 100
        end
        object dbgridColetaDBTableViewCitel1QTDAVARIA: TcxGridDBColumn
          Caption = 'Qtd Com Avaria'
          DataBinding.FieldName = 'QTDAVARIA'
          OnCustomDrawCell = dbgridColetaDBTableViewCitel1QTDAVARIACustomDrawCell
          HeaderAlignmentHorz = taRightJustify
          Width = 100
        end
        object dbgridColetaDBTableViewCitel1GARANTIA: TcxGridDBColumn
          Caption = 'Garantia'
          DataBinding.FieldName = 'GARANTIA'
          OnCustomDrawCell = dbgridColetaDBTableViewCitel1GARANTIACustomDrawCell
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 100
        end
      end
      object dbgridColetaLevel1: TcxGridLevel
        GridView = dbgridColetaDBTableViewCitel1
      end
    end
    object pbProgresso: TProgressBar
      Left = 0
      Top = 367
      Width = 1123
      Height = 7
      Align = alBottom
      Smooth = True
      TabOrder = 1
      Visible = False
      ExplicitTop = 470
      ExplicitWidth = 944
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1123
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCabecalho'
    ShowCaption = False
    TabOrder = 3
    object rgGarantia: TRadioGroup
      Left = 0
      Top = 0
      Width = 1123
      Height = 39
      Align = alTop
      Caption = 'Op'#231#245'es de condu'#231#227'o da quantidade avariada'
      Columns = 4
      ItemIndex = 0
      Items.Strings = (
        'Indicar individualmente cada caso'
        'Aguardar retorno do fornecedor'
        'Cr'#233'dito para cliente'
        'Reposi'#231#227'o do produto')
      TabOrder = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 152
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 1024
    Top = 144
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 1024
    Top = 121
    object cdsDadosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDadosFGO_DTAENT: TDateTimeField
      Alignment = taCenter
      FieldName = 'FGO_DTAENT'
    end
    object cdsDadosFGO_NUMDOC: TStringField
      FieldName = 'FGO_NUMDOC'
      Size = 12
    end
    object cdsDadosFGO_ESPDOC: TStringField
      FieldName = 'FGO_ESPDOC'
      Size = 2
    end
    object cdsDadosFGO_CODEMP: TStringField
      FieldName = 'FGO_CODEMP'
      Size = 3
    end
    object cdsDadosFGO_CODCLI: TStringField
      FieldName = 'FGO_CODCLI'
      Size = 8
    end
    object cdsDadosCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsDadosFDO_CODITE: TStringField
      FieldName = 'FDO_CODITE'
      Size = 5
    end
    object cdsDadosFDO_UNIDAD: TStringField
      FieldName = 'FDO_UNIDAD'
      Size = 2
    end
    object cdsDadosUNI_SIGUNI: TStringField
      Alignment = taCenter
      FieldName = 'UNI_SIGUNI'
      Size = 6
    end
    object cdsDadosFDO_QTDITE: TFloatField
      FieldName = 'FDO_QTDITE'
    end
    object cdsDadosITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
      Size = 70
    end
    object cdsDadosGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Size = 12
    end
    object cdsDadosGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Size = 2
    end
    object cdsDadosGER_CODEMP: TStringField
      FieldName = 'GER_CODEMP'
      Size = 3
    end
    object cdsDadosINCGOR: TStringField
      FieldName = 'INCGOR'
    end
    object cdsDadosINCDET: TStringField
      FieldName = 'INCDET'
    end
    object cdsDadosPEDIDO: TStringField
      Alignment = taCenter
      FieldName = 'PEDIDO'
      Size = 19
    end
    object cdsDadosDOCDEVOLUCAO: TStringField
      Alignment = taCenter
      FieldName = 'DOCDEVOLUCAO'
      Size = 19
    end
    object cdsDadosCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 100
    end
    object cdsDadosPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsDadosQTDAVARIA: TFloatField
      DisplayLabel = 'QTD COM AVARIA'
      FieldName = 'QTDAVARIA'
      OnValidate = cdsDadosQTDAVARIAValidate
    end
    object cdsDadosQTDSEMAVARIA: TFloatField
      DisplayLabel = 'QTD SEM AVARIA'
      FieldName = 'QTDSEMAVARIA'
      OnValidate = cdsDadosQTDSEMAVARIAValidate
    end
    object cdsDadosGARANTIA: TStringField
      Alignment = taCenter
      FieldName = 'GARANTIA'
      OnGetText = cdsDadosGARANTIAGetText
      Size = 1
    end
    object cdsDadosITE_CODFOR: TStringField
      FieldName = 'ITE_CODFOR'
      Size = 8
    end
    object cdsDadosVALITEUNITARIO: TFloatField
      FieldName = 'VALITEUNITARIO'
    end
    object cdsDadosITE_PRECUS: TFloatField
      FieldName = 'ITE_PRECUS'
    end
    object cdsDadosCLI_CODCID: TStringField
      FieldName = 'CLI_CODCID'
      Size = 5
    end
    object cdsDadosDET_TABPRE: TStringField
      FieldName = 'DET_TABPRE'
      Size = 1
    end
    object cdsDadosDET_NUMLOT: TStringField
      FieldName = 'DET_NUMLOT'
    end
    object cdsDadosINCGER: TStringField
      FieldName = 'INCGER'
    end
    object cdsDadosINCORI: TStringField
      FieldName = 'INCORI'
    end
    object cdsDadosDET_TOTFRE: TFloatField
      FieldName = 'DET_TOTFRE'
    end
    object cdsDadosDET_VLRCON: TFloatField
      FieldName = 'DET_VLRCON'
    end
  end
end
