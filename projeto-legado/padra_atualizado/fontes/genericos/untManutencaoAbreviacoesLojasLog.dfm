inherited frmManutencaoAbreviacoesLojasLog: TfrmManutencaoAbreviacoesLojasLog
  Width = 617
  Height = 585
  Caption = 'Falhas encontradas ao gravar abrevia'#231#245'es'
  ExplicitWidth = 617
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 512
    Width = 611
    ExplicitTop = 374
    ExplicitWidth = 664
    inherited btnSair: TBitBtnLocked
      Left = 528
      ExplicitLeft = 581
    end
  end
  inherited pnlStatus: TPanel
    Top = 540
    Width = 611
    ExplicitTop = 402
    ExplicitWidth = 664
    inherited pnlNomeForm: TPanel
      Left = 440
      ExplicitLeft = 493
    end
    inherited pnlInfo: TPanel
      Width = 440
      ExplicitWidth = 493
    end
  end
  object cxGrid1: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 611
    Height = 512
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 664
    ExplicitHeight = 374
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        DataBinding.FieldName = 'EMP_CODEMP'
        Visible = False
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        DataBinding.FieldName = 'EMPRESA'
        Visible = False
        GroupIndex = 0
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = 'Erros:'
        DataBinding.FieldName = 'ERRO'
        Width = 607
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dtsDados: TDataSource
    Left = 320
    Top = 208
  end
end
