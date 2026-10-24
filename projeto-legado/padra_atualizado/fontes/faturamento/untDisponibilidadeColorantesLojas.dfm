inherited frmDisponibilidadeColorantesLojas: TfrmDisponibilidadeColorantesLojas
  Width = 772
  Height = 351
  Caption = 'frmDisponibilidadeColorantesLojas'
  Position = poMainFormCenter
  ExplicitWidth = 772
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 278
    Width = 766
    ExplicitTop = 278
    ExplicitWidth = 766
    inherited FlwBotoes: TFlowPanel
      Width = 762
      ExplicitWidth = 762
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 85
        Height = 22
        Align = alLeft
        Caption = '[F10] Confirma'
        ModalResult = 1
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 683
      ExplicitLeft = 683
    end
  end
  inherited pnlStatus: TPanel
    Top = 306
    Width = 766
    ExplicitTop = 306
    ExplicitWidth = 766
    inherited pnlNomeForm: TPanel
      Left = 595
      ExplicitLeft = 595
    end
    inherited pnlInfo: TPanel
      Width = 595
      ExplicitWidth = 595
    end
  end
  object cxGrid1: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 766
    Height = 275
    Align = alTop
    TabOrder = 3
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxGrid1DBTableView1EditKeyDown
      DataController.DataSource = dtsEmpresa
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableViewNOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_NOMEMP'
        Options.Editing = False
      end
      object cxGrid1DBTableViewSALDOS: TcxGridDBColumn
        Caption = 'Saldo Dispon.'
        DataBinding.FieldName = 'ITE_SALDIS'
        Options.Editing = False
        Width = 80
      end
      object cxGrid1DBTableViewQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object cdsEmpresa: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 72
    object cdsEmpresaEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 80
    end
    object cdsEmpresaITE_SALDIS: TFloatField
      FieldName = 'ITE_SALDIS'
      DisplayFormat = '#0.00'
    end
    object cdsEmpresaITE_QTDITE: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'ITE_QTDITE'
      DisplayFormat = '#0.00'
    end
    object cdsEmpresaEMP_CODEMP: TStringField
      FieldName = 'EMP_CODEMP'
      Size = 3
    end
    object cdsEmpresaITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 5
    end
  end
  object dtsEmpresa: TDataSource
    DataSet = cdsEmpresa
    Left = 456
    Top = 152
  end
end
