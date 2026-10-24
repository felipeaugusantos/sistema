inherited frmImportAliquotaIBPTConfirma: TfrmImportAliquotaIBPTConfirma
  Width = 946
  Height = 456
  Caption = 'Importa'#231#227'o de Al'#237'quota IBPT - LEI 12741 - Confirma'
  ExplicitWidth = 946
  ExplicitHeight = 456
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 385
    Width = 940
    ExplicitTop = 385
    ExplicitWidth = 940
    inherited FlwBotoes: TFlowPanel
      Width = 936
      ExplicitWidth = 936
    end
    inherited btnSair: TBitBtnLocked
      Left = 860
      ExplicitLeft = 860
    end
  end
  inherited pnlStatus: TPanel
    Top = 411
    Width = 940
    ExplicitTop = 411
    ExplicitWidth = 940
    inherited pnlNomeForm: TPanel
      Left = 769
      ExplicitLeft = 769
    end
    inherited pnlInfo: TPanel
      Width = 769
      ExplicitWidth = 769
    end
  end
  object cxgAliqIBPT: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 940
    Height = 315
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 385
    object cxgAliqIBPTDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgAliqIBPTDBTableView1CustomDrawCell
      DataController.DataSource = dtsCadIbp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object cxgAliqIBPTDBTableView1Estado: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'IBP_ESTADO'
        Options.Editing = False
        Width = 40
      end
      object cxgAliqIBPTDBTableView1NCM: TcxGridDBColumn
        Caption = 'NCM'
        DataBinding.FieldName = 'IBP_N_C_M_'
        Options.Editing = False
      end
      object cxgAliqIBPTDBTableView1EX: TcxGridDBColumn
        Caption = 'EX'
        DataBinding.FieldName = 'IBP_E_X___'
        Options.Editing = False
      end
      object cxgAliqIBPTDBTableView1AlqNac: TcxGridDBColumn
        Caption = 'Tributa'#231#227'o Federal para Nacionais (%)'
        DataBinding.FieldName = 'IBP_ALQNAC'
        Options.Editing = False
        Width = 200
      end
      object cxgAliqIBPTDBTableView1AlqImp: TcxGridDBColumn
        Caption = 'Tributa'#231#227'o Federal para Importados (%)'
        DataBinding.FieldName = 'IBP_ALQIMP'
        Options.Editing = False
        Width = 200
      end
      object cxgAliqIBPTDBTableView1AlqEst: TcxGridDBColumn
        Caption = 'Tributa'#231#227'o Estadual (%)'
        DataBinding.FieldName = 'IBP_ALQEST'
        Options.Editing = False
        Width = 140
      end
      object cxgAliqIBPTDBTableView1AlqMun: TcxGridDBColumn
        Caption = 'Tributa'#231#227'o Municipal (%)'
        DataBinding.FieldName = 'IBP_ALQMUN'
        Options.Editing = False
        Width = 140
      end
      object cxgAliqIBPTDBTableView1Acao: TcxGridDBColumn
        DataBinding.FieldName = 'ACAO'
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
        VisibleForEditForm = bFalse
      end
    end
    object cxgAliqIBPTLevel1: TcxGridLevel
      GridView = cxgAliqIBPTDBTableView1
    end
  end
  object grpLegenda: TGroupBox [3]
    Left = 0
    Top = 315
    Width = 940
    Height = 70
    Align = alBottom
    Caption = 'Legenda'
    TabOrder = 3
    ExplicitLeft = -8
    ExplicitTop = 265
    object Shape2: TShape
      Left = 8
      Top = 26
      Width = 17
      Height = 15
      Brush.Color = clYellow
    end
    object Shape3: TShape
      Left = 8
      Top = 42
      Width = 17
      Height = 15
      Brush.Color = clAqua
    end
    object Label2: TLabel
      Left = 31
      Top = 26
      Width = 120
      Height = 14
      Caption = 'NCM que ser'#225' atualizado'
    end
    object Label3: TLabel
      Left = 31
      Top = 42
      Width = 109
      Height = 14
      Caption = 'NCM que ser'#225' inserido'
    end
  end
  object dtsCadIbp: TDataSource
    Left = 48
    Top = 48
  end
end
