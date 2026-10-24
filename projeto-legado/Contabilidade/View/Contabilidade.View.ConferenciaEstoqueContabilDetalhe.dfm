inherited frmConferenciaEstoqueContabilDetalhe: TfrmConferenciaEstoqueContabilDetalhe
  Width = 885
  Height = 525
  Caption = 'Detalhe'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 885
  ExplicitHeight = 525
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 454
    Width = 879
    Height = 26
    ExplicitTop = 454
    ExplicitWidth = 879
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 798
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 875
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 800
      Top = 2
      Align = alRight
      ExplicitLeft = 796
    end
  end
  inherited pnlStatus: TPanel
    Top = 480
    Width = 879
    ExplicitTop = 480
    ExplicitWidth = 879
    inherited pnlNomeForm: TPanel
      Left = 708
      ExplicitLeft = 708
    end
    inherited pnlInfo: TPanel
      Width = 708
      ExplicitWidth = 708
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 879
    Height = 454
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitHeight = 452
    object cxGridCitel1: TcxGridCitel
      Left = 0
      Top = 0
      Width = 879
      Height = 454
      Align = alClient
      TabOrder = 0
      LookAndFeel.NativeStyle = False
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitHeight = 452
      object cxGridCitel1DBTableViewSaldoInicial: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitel1DBTableViewSaldoInicialCODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
          Width = 39
        end
        object cxGridCitel1DBTableViewSaldoInicialDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Width = 332
        end
        object cxGridCitel1DBTableViewSaldoInicialREFERE: TcxGridDBColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Width = 82
        end
        object cxGridCitel1DBTableViewSaldoInicialUNIDAD: TcxGridDBColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'UNIDAD'
          Width = 45
        end
        object cxGridCitel1DBTableViewSaldoInicialVALTOT: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'VALTOT'
          Width = 83
        end
      end
      object cxGridCitelAgrupadoCfop: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            OnGetText = cxGridCitelAgrupadoCfopTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText
            Column = cxGridCitelAgrupadoCfopVLRCON
            DisplayText = 'Valor'
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridCitelAgrupadoCfopCLAFIS: TcxGridDBColumn
          Caption = 'CFOP'
          DataBinding.FieldName = 'CLAFIS'
          GroupIndex = 0
          Width = 48
        end
        object cxGridCitelAgrupadoCfopAGRUP2: TcxGridDBColumn
          Caption = 'Data/Documento'
          DataBinding.FieldName = 'AGRUP2'
          GroupIndex = 1
          Width = 78
        end
        object cxGridCitelAgrupadoCfopCODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
        end
        object cxGridCitelAgrupadoCfopDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
        end
        object cxGridCitelAgrupadoCfopQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
        end
        object cxGridCitelAgrupadoCfopUNITAR: TcxGridDBColumn
          Caption = 'Vlr. Unit'#225'rio'
          DataBinding.FieldName = 'UNITAR'
        end
        object cxGridCitelAgrupadoCfopTOTITE: TcxGridDBColumn
          Caption = 'Vlr. Produto'
          DataBinding.FieldName = 'TOTITE'
        end
        object cxGridCitelAgrupadoCfopTOTFRE: TcxGridDBColumn
          Caption = 'Frete'
          DataBinding.FieldName = 'TOTFRE'
        end
        object cxGridCitelAgrupadoCfopDESACE: TcxGridDBColumn
          Caption = 'Des. Acess'#243'ria'
          DataBinding.FieldName = 'DESACE'
        end
        object cxGridCitelAgrupadoCfopVALIPI: TcxGridDBColumn
          Caption = 'Vlr. IPI'
          DataBinding.FieldName = 'VALIPI'
        end
        object cxGridCitelAgrupadoCfopVALRET: TcxGridDBColumn
          Caption = 'Vlr. ST'
          DataBinding.FieldName = 'VALRET'
        end
        object cxGridCitelAgrupadoCfopVLRCON: TcxGridDBColumn
          Caption = 'Vlr. Cont'#225'bil'
          DataBinding.FieldName = 'VLRCON'
        end
      end
      object cxGridCitelAgrupadoCfopRecuperaveis: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            OnGetText = cxGridCitelAgrupadoCfopRecuperaveisTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText
            Column = cxGridCitelAgrupadoCfopRecuperaveisIMPREC
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridCitelAgrupadoCfopRecuperaveisCLAFIS: TcxGridDBColumn
          Caption = 'CFOP'
          DataBinding.FieldName = 'CLAFIS'
          GroupIndex = 0
          Width = 32
        end
        object cxGridCitelAgrupadoCfopRecuperaveisAGRUP2: TcxGridDBColumn
          Caption = 'Data/Documento'
          DataBinding.FieldName = 'AGRUP2'
          GroupIndex = 1
        end
        object cxGridCitelAgrupadoCfopRecuperaveisCODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
        end
        object cxGridCitelAgrupadoCfopRecuperaveisDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Width = 255
        end
        object cxGridCitelAgrupadoCfopRecuperaveisQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          Width = 72
        end
        object cxGridCitelAgrupadoCfopRecuperaveisUNITAR: TcxGridDBColumn
          Caption = 'Vlr. Unit'#225'rio'
          DataBinding.FieldName = 'UNITAR'
          Width = 86
        end
        object cxGridCitelAgrupadoCfopRecuperaveisTOTITE: TcxGridDBColumn
          Caption = 'Vlr. Produto'
          DataBinding.FieldName = 'TOTITE'
          Width = 84
        end
        object cxGridCitelAgrupadoCfopRecuperaveisIMPREC: TcxGridDBColumn
          Caption = 'Valor ???'
          DataBinding.FieldName = 'IMPREC'
          Width = 97
        end
      end
      object cxGridCitelAjustes: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDados
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            OnGetText = cxGridCitelAjustesTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText
            Column = cxGridCitelAjustesVLRCON
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridCitelAjustesAGRUP2: TcxGridDBColumn
          Caption = 'Data/Documento'
          DataBinding.FieldName = 'AGRUP2'
          GroupIndex = 0
        end
        object cxGridCitelAjustesCODITE: TcxGridDBColumn
          Caption = 'Item'
          DataBinding.FieldName = 'CODITE'
          Width = 47
        end
        object cxGridCitelAjustesDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          Width = 149
        end
        object cxGridCitelAjustesQTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
        end
        object cxGridCitelAjustesUNITAR: TcxGridDBColumn
          Caption = 'Vlr. Unit'#225'rio'
          DataBinding.FieldName = 'UNITAR'
        end
        object cxGridCitelAjustesTOTITE: TcxGridDBColumn
          Caption = 'Vlr. Produto'
          DataBinding.FieldName = 'TOTITE'
          Width = 77
        end
        object cxGridCitelAjustesVALFRE: TcxGridDBColumn
          Caption = 'Frete'
          DataBinding.FieldName = 'VALFRE'
          Width = 76
        end
        object cxGridCitelAjustesDESACE: TcxGridDBColumn
          Caption = 'Des. Acess'#243'ria'
          DataBinding.FieldName = 'DESACE'
          Width = 78
        end
        object cxGridCitelAjustesVALIPI: TcxGridDBColumn
          Caption = 'Vlr. IPI'
          DataBinding.FieldName = 'VALIPI'
          Width = 69
        end
        object cxGridCitelAjustesVALRET: TcxGridDBColumn
          Caption = 'Vlr. ST'
          DataBinding.FieldName = 'VALRET'
        end
        object cxGridCitelAjustesVLRCON: TcxGridDBColumn
          Caption = 'Vlr. Cont'#225'bil'
          DataBinding.FieldName = 'VLRCON'
          Width = 80
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitelAjustes
      end
    end
  end
  object dtsDados: TDataSource
    Left = 60
    Top = 136
  end
end
