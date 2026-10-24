inherited frmImportProdutoVeiculoConfirma: TfrmImportProdutoVeiculoConfirma
  Width = 973
  Height = 531
  Caption = 'Importa'#231#227'o de Produtos x Ve'#237'culos - Confirma'
  OldCreateOrder = False
  ExplicitWidth = 973
  ExplicitHeight = 531
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 460
    Width = 967
    ExplicitTop = 460
    ExplicitWidth = 967
    inherited FlwBotoes: TFlowPanel
      Width = 963
      ExplicitWidth = 963
    end
    inherited btnSair: TBitBtnLocked
      Left = 884
      ExplicitLeft = 884
    end
  end
  inherited pnlStatus: TPanel
    Top = 486
    Width = 967
    ExplicitTop = 486
    ExplicitWidth = 967
    inherited pnlNomeForm: TPanel
      Left = 796
      ExplicitLeft = 796
    end
    inherited pnlInfo: TPanel
      Width = 796
      ExplicitWidth = 796
    end
  end
  object cxgProdVeic: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 967
    Height = 460
    Align = alClient
    TabOrder = 2
    object cxgProdVeicDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsProVe
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgProdVeicDBTableView1CodIte: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'VEI_CODITE'
        Options.Editing = False
        Width = 80
      end
      object cxgProdVeicDBTableView1CodMar: TcxGridDBColumn
        Caption = 'C'#243'd. Marca'
        DataBinding.FieldName = 'MOD_CODMAR'
        Options.Editing = False
        Width = 70
      end
      object cxgProdVeicDBTableView1CodMod: TcxGridDBColumn
        Caption = 'C'#243'd Modelo'
        DataBinding.FieldName = 'MOD_CODMOD'
        Options.Editing = False
        Width = 70
      end
      object cxgProdVeicDBTableView1AnoIni: TcxGridDBColumn
        Caption = 'Ano Inicial'
        DataBinding.FieldName = 'MOD_ANOINI'
        Options.Editing = False
        Width = 60
      end
      object cxgProdVeicDBTableView1AnoFin: TcxGridDBColumn
        Caption = 'Ano Final'
        DataBinding.FieldName = 'MOD_ANOFIN'
        Options.Editing = False
        Width = 60
      end
      object cxgProdVeicDBTableView1Valvul: TcxGridDBColumn
        Caption = 'V'#225'lvula'
        DataBinding.FieldName = 'MOD_VALVUL'
        Options.Editing = False
        Width = 50
      end
      object cxgProdVeicDBTableView1Cilind: TcxGridDBColumn
        Caption = 'Cilindrada'
        DataBinding.FieldName = 'MOD_CILIND'
        Options.Editing = False
      end
      object cxgProdVeicDBTableView1Potenc: TcxGridDBColumn
        Caption = 'Pot'#234'ncia'
        DataBinding.FieldName = 'MOD_POTENC'
        Options.Editing = False
      end
      object cxgProdVeicDBTableView1Combus: TcxGridDBColumn
        Caption = 'Combust'#237'vel'
        DataBinding.FieldName = 'MOD_COMBUS'
        Options.Editing = False
        Width = 70
      end
      object cxgProdVeicDBTableView1ObsIte: TcxGridDBColumn
        Caption = 'Obs. Item'
        DataBinding.FieldName = 'VEI_OBSERV'
        Options.Editing = False
        Width = 180
      end
      object cxgProdVeicDBTableView1Observ: TcxGridDBColumn
        Caption = 'Observa'#231#245'es'
        DataBinding.FieldName = 'MOD_OBSERV'
        Options.Editing = False
        Width = 180
      end
    end
    object cxgProdVeicLevel1: TcxGridLevel
      GridView = cxgProdVeicDBTableView1
    end
  end
  object dtsProVe: TDataSource
    Left = 56
    Top = 32
  end
end
