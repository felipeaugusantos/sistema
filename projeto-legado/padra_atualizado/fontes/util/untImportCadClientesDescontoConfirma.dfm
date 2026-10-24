inherited frmImportCadClientesDescontoConfirma: TfrmImportCadClientesDescontoConfirma
  Width = 948
  Height = 500
  BorderStyle = bsSingle
  Caption = 'Importar Cadastro de Descontos Clientes / Fornecedores'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 948
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 942
    ExplicitTop = 429
    ExplicitWidth = 942
    inherited FlwBotoes: TFlowPanel
      Width = 938
      ExplicitWidth = 938
    end
    inherited btnSair: TBitBtnLocked
      Left = 862
      ExplicitLeft = 862
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 942
    ExplicitTop = 455
    ExplicitWidth = 942
    inherited pnlNomeForm: TPanel
      Left = 771
      ExplicitLeft = 771
    end
    inherited pnlInfo: TPanel
      Width = 771
      ExplicitWidth = 771
    end
  end
  object cxgRegistros: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 942
    Height = 429
    Align = alClient
    TabOrder = 2
    object cxgRegistrosDBTv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsRegistros
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgRegistrosDBCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CDS_CODCLI'
        Options.Editing = False
        Width = 70
      end
      object cxgRegistrosDBNOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Options.Editing = False
        Width = 260
      end
      object cxgRegistrosDBCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'CDS_CODFOR'
        Options.Editing = False
        Width = 94
      end
      object cxgRegistrosDBNOMFOR: TcxGridDBColumn
        Caption = 'Nome Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.Editing = False
        Width = 260
      end
      object cxgRegistrosDBPERDESC: TcxGridDBColumn
        Caption = 'Desconto (%)'
        DataBinding.FieldName = 'CDS_PERDES'
        Options.Editing = False
        Width = 76
      end
      object cxgRegistrosDBPERCOM: TcxGridDBColumn
        Caption = 'Comiss'#227'o (%)'
        DataBinding.FieldName = 'CDS_PERCOM'
        Options.Editing = False
        Width = 76
      end
      object cxgRegistrosDBCADASTRADO: TcxGridDBColumn
        Caption = 'J'#225' cadastrado'
        DataBinding.FieldName = 'CADASTRADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
      end
    end
    object cxgRegistrosLv: TcxGridLevel
      GridView = cxgRegistrosDBTv
    end
  end
  object dtsRegistros: TDataSource
    Left = 56
    Top = 32
  end
end
