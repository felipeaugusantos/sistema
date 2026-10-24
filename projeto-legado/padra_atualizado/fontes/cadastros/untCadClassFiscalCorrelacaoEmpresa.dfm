inherited frmCadClassFiscalCorrelacaoEmpresa: TfrmCadClassFiscalCorrelacaoEmpresa
  Width = 800
  Height = 500
  Caption = 'Correla'#231#227'o de CFOP para Entrada de Mercadorias Por Empresa'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 794
    ExplicitTop = 427
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 22
        Caption = '[F10] - Confirmar'
        TabOrder = 0
        TabStop = False
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      Top = 2
      ExplicitLeft = 711
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 794
    ExplicitTop = 455
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
  object cxClaFis: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 427
    Align = alClient
    TabOrder = 3
    object cxTblClaFis: TcxGridDBTableView
      OnKeyPress = cxTblClaFisKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxTblClaFisEditKeyPress
      DataController.DataSource = dtsClaFis
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
        Width = 300
      end
      object cxCLASUB: TcxGridDBColumn
        Caption = 'Para produtos substitu'#237'dos ou conhecimento de frete'
        DataBinding.FieldName = 'CLASUB'
        Width = 270
      end
      object cxCLAENT: TcxGridDBColumn
        Caption = 'Para produtos n'#227'o substitu'#237'dos'
        DataBinding.FieldName = 'CLAENT'
        Width = 160
      end
    end
    object cxClaFisLvl: TcxGridLevel
      GridView = cxTblClaFis
    end
  end
  object dtsClaFis: TDataSource
    Left = 456
    Top = 104
  end
end
