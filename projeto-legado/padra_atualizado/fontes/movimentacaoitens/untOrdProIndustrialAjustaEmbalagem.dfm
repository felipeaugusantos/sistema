inherited frmOrdProIndustrialAjustaEmbalagem: TfrmOrdProIndustrialAjustaEmbalagem
  Width = 661
  Height = 330
  Caption = 'Baixa de Ordem de Produ'#231#227'o - Ajuste de Composi'#231#227'o'
  ExplicitWidth = 661
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 655
    ExplicitTop = 259
    ExplicitWidth = 655
    inherited FlwBotoes: TFlowPanel
      Width = 574
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 576
      Top = 2
      Align = alRight
      ExplicitLeft = 576
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 285
    Width = 655
    ExplicitTop = 285
    ExplicitWidth = 655
    inherited pnlNomeForm: TPanel
      Left = 484
      ExplicitLeft = 484
    end
    inherited pnlInfo: TPanel
      Width = 484
      ExplicitWidth = 484
    end
  end
  object cxgComposicao: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 655
    Height = 259
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgComposicaoTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditing = cxgComposicaoTableViewEditing
      DataController.DataSource = dtsDigitacao
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgComposicaoTableViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 68
      end
      object cxgComposicaoTableViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Options.Focusing = False
        Options.Moving = False
        Width = 327
      end
      object cxgComposicaoTableViewColumn3: TcxGridDBColumn
        Caption = 'Qtde. Utilizada'
        DataBinding.FieldName = 'QTDUSA'
        Width = 87
      end
      object cxgComposicaoTableViewIteFra: TcxGridDBColumn
        Caption = 'Fracionado'
        DataBinding.FieldName = 'ITEFRA'
        OnGetDisplayText = cxgComposicaoTableViewIteFraGetDisplayText
        Options.Editing = False
        Width = 62
      end
    end
    object cxgComposicaoLevel: TcxGridLevel
      GridView = cxgComposicaoTableView
    end
  end
  object cdsDigitacao: TUniClientDataSet
    PersistDataPacket.Data = {
      A40000009619E0BD010000001800000006000000000003000000A40006415554
      494E43010049000000010005574944544802000200140006434F444954450100
      4900000001000557494454480200020005000644455349544501004900000001
      0005574944544802000200500006515444495445080004000000000006515444
      5553410800040000000000064954454652410100490000000100055749445448
      0200020001000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 576
    Top = 72
    object cdsDigitacaoAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsDigitacaoCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsDigitacaoDESITE: TStringField
      FieldName = 'DESITE'
      Size = 80
    end
    object cdsDigitacaoQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.0000'
    end
    object cdsDigitacaoQTDUSA: TFloatField
      FieldName = 'QTDUSA'
      DisplayFormat = '#,##0.0000'
    end
    object cdsDigitacaoITEFRA: TStringField
      FieldName = 'ITEFRA'
      Size = 1
    end
  end
  object dtsDigitacao: TDataSource
    DataSet = cdsDigitacao
    Left = 496
    Top = 72
  end
end
