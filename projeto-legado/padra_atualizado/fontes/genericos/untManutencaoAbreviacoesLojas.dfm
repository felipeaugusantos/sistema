inherited frmManutencaoAbreviacoesLojas: TfrmManutencaoAbreviacoesLojas
  Width = 1078
  Height = 706
  BorderStyle = bsNone
  Caption = 'frmManutencaoAbreviacoesLojas'
  Enabled = False
  OnDestroy = FormDestroy
  ExplicitWidth = 1078
  ExplicitHeight = 706
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 662
    Width = 1078
    ExplicitTop = 662
    ExplicitWidth = 1078
    inherited FlwBotoes: TFlowPanel
      Width = 1074
      ExplicitWidth = 1074
    end
    inherited btnSair: TBitBtnLocked
      Left = 995
      ExplicitLeft = 995
    end
  end
  inherited pnlStatus: TPanel
    Top = 690
    Width = 1078
    ExplicitTop = 690
    ExplicitWidth = 1078
    inherited pnlNomeForm: TPanel
      Left = 907
      ExplicitLeft = 907
    end
    inherited pnlInfo: TPanel
      Width = 907
      ExplicitWidth = 907
    end
  end
  object pnlGrid: TPanel [2]
    Left = 0
    Top = 0
    Width = 1078
    Height = 662
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 2
    object cxAbreviacaoes: TcxGrid
      Left = 1
      Top = 1
      Width = 1076
      Height = 619
      Align = alClient
      TabOrder = 0
      object cxTblAbrev: TcxGridDBTableView
        OnKeyPress = cxTblAbrevKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxTblAbrevCustomDrawCell
        OnEditKeyPress = cxTblAbrevEditKeyPress
        DataController.DataSource = dtsControle
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        object cxEMPRESA: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMPRESA'
          Options.Editing = False
        end
        object cxCODICM: TcxGridDBColumn
          Caption = 'Abr. Fiscal'
          DataBinding.FieldName = 'CODABF'
          Width = 64
        end
        object cxDESICM: TcxGridDBColumn
          Caption = 'Desc. Abr. Fiscal'
          DataBinding.FieldName = 'DESABF'
          Options.Editing = False
          Width = 200
        end
        object cxCODPIS: TcxGridDBColumn
          Caption = 'Abr. PIS'
          DataBinding.FieldName = 'ABFPIS'
          Width = 52
        end
        object cxDESPIS: TcxGridDBColumn
          Caption = 'Desc. PIS'
          DataBinding.FieldName = 'DESPIS'
          Options.Editing = False
          Width = 200
        end
        object cxCODCOF: TcxGridDBColumn
          Caption = 'Abr. COFINS'
          DataBinding.FieldName = 'ABFCOF'
          Width = 69
        end
        object cxDESCOF: TcxGridDBColumn
          Caption = 'Desc. COFINS'
          DataBinding.FieldName = 'DESCOF'
          Options.Editing = False
          Width = 200
        end
        object cxCODIPI: TcxGridDBColumn
          Caption = 'Abr. IPI'
          DataBinding.FieldName = 'ABFIPI'
          MinWidth = 52
          Width = 52
        end
        object cxDESIPI: TcxGridDBColumn
          Caption = 'Desc. IPI'
          DataBinding.FieldName = 'DESIPI'
          Options.Editing = False
          Width = 155
        end
        object cxABF_POREMP: TcxGridDBColumn
          DataBinding.FieldName = 'ABF_POREMP'
          Visible = False
        end
        object cxPCI_POREMP: TcxGridDBColumn
          DataBinding.FieldName = 'PCI_POREMP'
          Visible = False
        end
      end
      object cxAbreviacaoesLvl: TcxGridLevel
        GridView = cxTblAbrev
      end
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 620
      Width = 1076
      Height = 41
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        1076
        41)
      object Shape1: TShape
        Left = 3
        Top = 2
        Width = 16
        Height = 16
        Brush.Color = clSilver
      end
      object Label1: TLabel
        Left = 21
        Top = 3
        Width = 367
        Height = 14
        Caption = 
          'Cadastro de Abrevia'#231#227'o Geral - Deve ser alterado pela guia "Dado' +
          's Fiscais"'
      end
      object Label2: TLabel
        Left = 21
        Top = 23
        Width = 325
        Height = 14
        Caption = 
          'Cadastro de Abrevia'#231#227'o Por Empresa - pode ser editado nesta tela' +
          '.'
      end
      object Shape2: TShape
        Left = 3
        Top = 22
        Width = 16
        Height = 16
        Brush.Color = clMoneyGreen
      end
      object btnReplicaDados: TBitBtnLocked
        Left = 893
        Top = 6
        Width = 173
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Replica Abrevia'#231#227'o'
        TabOrder = 0
        OnClick = btnReplicaDadosClick
      end
    end
  end
  object dtsControle: TDataSource
    Left = 280
    Top = 128
  end
end
