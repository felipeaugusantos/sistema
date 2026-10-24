inherited frmRestauraPreco: TfrmRestauraPreco
  Width = 844
  Height = 410
  BorderStyle = bsSizeable
  Caption = 'Restaura Pre'#231'os'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 844
  ExplicitHeight = 410
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 327
    Width = 828
    ExplicitTop = 327
    ExplicitWidth = 828
    inherited FlwBotoes: TFlowPanel
      Width = 824
      ExplicitWidth = 824
      object btnMarTod: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 133
        Height = 22
        Caption = '[ F8 ]Consultar Altera'#231#245'es'
        TabOrder = 0
        OnClick = btnMarTodClick
      end
      object btnRestaura: TBitBtnLocked
        Left = 133
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F9 ]Restaurar Pre'#231'os Alterados'
        TabOrder = 1
        OnClick = btnRestauraClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 748
      ExplicitLeft = 748
    end
  end
  inherited pnlStatus: TPanel
    Top = 355
    Width = 828
    ExplicitTop = 355
    ExplicitWidth = 828
    inherited pnlNomeForm: TPanel
      Left = 657
      ExplicitLeft = 657
    end
    inherited pnlInfo: TPanel
      Width = 657
      ExplicitWidth = 657
    end
  end
  object cxGridCitel1: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 828
    Height = 327
    Align = alClient
    TabOrder = 2
    object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
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
      object cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'ALT_DTAALT'
      end
      object cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'ALT_HORALT'
      end
      object cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'OPERADOR'
        Width = 229
      end
      object cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn
        Caption = 'Qtd Produtos'
        DataBinding.FieldName = 'QTDPRO'
      end
      object cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn
        Caption = 'Local'
        DataBinding.FieldName = 'LOCALT'
        VisibleForEditForm = bTrue
        Width = 329
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitel1DBTableViewCitel1
    end
  end
  object dtsDados: TDataSource
    Left = 408
    Top = 192
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 420
    Top = 204
  end
end
