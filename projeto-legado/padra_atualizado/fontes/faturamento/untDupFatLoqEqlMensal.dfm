inherited frmDupFatLocEqlMensal: TfrmDupFatLocEqlMensal
  Width = 796
  Height = 426
  Caption = 'Faturamento realizado com successo!'
  Position = poMainFormCenter
  ExplicitWidth = 796
  ExplicitHeight = 426
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 353
    Width = 790
    ExplicitTop = 353
    ExplicitWidth = 790
    inherited FlwBotoes: TFlowPanel
      Width = 786
      ExplicitWidth = 786
      object blnImprimirRelacao: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F10] Imprimir Rela'#231#227'o'
        TabOrder = 0
        OnClick = blnImprimirRelacaoClick
      end
      object btnGerarCSL: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F5] Gerar CSV'
        TabOrder = 1
        OnClick = btnGerarCSLClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 707
      ExplicitLeft = 707
    end
  end
  inherited pnlStatus: TPanel
    Top = 381
    Width = 790
    ExplicitTop = 381
    ExplicitWidth = 790
    inherited pnlNomeForm: TPanel
      Left = 619
      ExplicitLeft = 619
    end
    inherited pnlInfo: TPanel
      Width = 619
      ExplicitWidth = 619
      object btnShowTrace: TSpeedButton
        Left = 617
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 617
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 790
    Height = 353
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grdFatur: TcxGridCitel
      Left = 0
      Top = 0
      Width = 790
      Height = 353
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdFaturTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEqlFat
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
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdFaturTableViewEQF_SEQCON: TcxGridDBColumn
          DataBinding.FieldName = 'EQF_SEQCON'
          Visible = False
        end
        object grdFaturTableViewEQL_NROCON: TcxGridDBColumn
          Caption = 'Contrato'
          DataBinding.FieldName = 'EQL_NROCON'
          Width = 100
        end
        object grdFaturTableViewEQL_CODCLI: TcxGridDBColumn
          DataBinding.FieldName = 'EQL_CODCLI'
          Visible = False
        end
        object grdFaturTableViewEQL_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          MinWidth = 70
          Width = 177
        end
        object grdFaturTableViewEQF_AUT_PD: TcxGridDBColumn
          Caption = 'Documento Gerado'
          DataBinding.FieldName = 'EQF_AUT_PD'
          Width = 145
        end
        object grdFaturTableViewEQF_VLRTOT: TcxGridDBColumn
          Caption = 'Valor Total'
          DataBinding.FieldName = 'EQF_VLRTOT'
          Width = 82
        end
        object grdFaturTableViewEQF_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicatas Geradas'
          DataBinding.FieldName = 'EQF_NUMDUP'
          MinWidth = 70
          Width = 215
        end
        object grdFaturTableViewEQF_GERBOL: TcxGridDBColumn
          Caption = 'Boleto Gerado?'
          DataBinding.FieldName = 'EQF_GERBOL'
          Width = 93
        end
      end
      object grdFaturLevel: TcxGridLevel
        GridView = grdFaturTableView
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [3]
    Left = 0
    Top = 353
    Width = 790
    Height = 0
    TabOrder = 3
    object lblNSQLTrace: TLabel
      Left = 727
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object cdsEqlFat: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 320
    Top = 265
    object cdsEqlFatEQF_SEQCON: TStringField
      FieldName = 'EQF_SEQCON'
    end
    object cdsEqlFatEQL_CODCLI: TStringField
      FieldName = 'EQL_CODCLI'
    end
    object cdsEqlFatCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 70
    end
    object cdsEqlFatEQF_AUT_PD: TStringField
      FieldName = 'EQF_AUT_PD'
    end
    object cdsEqlFatEQF_VLRTOT: TFloatField
      FieldName = 'EQF_VLRTOT'
    end
    object cdsEqlFatEQF_NUMDUP: TStringField
      FieldName = 'EQF_NUMDUP'
      Size = 70
    end
    object cdsEqlFatEQF_GERBOL: TStringField
      FieldName = 'EQF_GERBOL'
    end
    object cdsEqlFatEQL_NROCON: TStringField
      FieldName = 'EQL_NROCON'
      Size = 100
    end
  end
  object dtsEqlFat: TDataSource
    DataSet = cdsEqlFat
    Left = 384
    Top = 265
  end
end
