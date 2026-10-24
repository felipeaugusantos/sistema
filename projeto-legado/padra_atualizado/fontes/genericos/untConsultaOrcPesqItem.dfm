inherited frmConsultaOrcPesqItem: TfrmConsultaOrcPesqItem
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Or'#231'amentos Pendentes'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
    object btnDocCom: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 240
      Height = 22
      Caption = '[ F5 ] Visualizar Documento Completo'
      TabOrder = 0
      Visible = False
      OnClick = btnDocComClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object dbgOrcamentos: TcxGridCitel [3]
    Tag = 99
    Left = 0
    Top = 0
    Width = 794
    Height = 527
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgOrcamentosView: TcxGridDBTableViewCitel
      OnKeyDown = dbgOrcamentosViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsOrcamentos
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
      Destaque = False
      CorZebra = clMoneyGreen
      object dbgOrcamentosNumDoc: TcxGridDBColumn
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'NUMDOC'
        Width = 100
      end
      object dbgOrcamentosEspDoc: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 30
      end
      object dbgOrcamentosCodEmp: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'CODEMP'
        Width = 30
      end
      object dbgOrcamentosCodVen: TcxGridDBColumn
        Caption = 'Ven.'
        DataBinding.FieldName = 'CODVEN'
        Width = 30
      end
      object dbgOrcamentosDtaEnt: TcxGridDBColumn
        Caption = 'Data Emiss'#227'o'
        DataBinding.FieldName = 'DTAENT'
      end
      object dbgOrcamentosNomCLi: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
      end
      object dbgOrcamentosQtdIte: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
      end
      object dbgOrcamentosTabPre: TcxGridDBColumn
        Caption = 'TP'
        DataBinding.FieldName = 'TABPRE'
      end
      object dbgOrcamentosUnitar: TcxGridDBColumn
        Caption = 'Valor Unit.'
        DataBinding.FieldName = 'UNITAR'
      end
      object dbgOrcamentosTotIte: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'TOTITE'
      end
    end
    object dbgOrcamentosLevel1: TcxGridLevel
      GridView = dbgOrcamentosView
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 88
  end
  object dtsOrcamentos: TDataSource
    Left = 376
    Top = 328
  end
end
