inherited frmRelSimplesNacionalResumoEmpresa: TfrmRelSimplesNacionalResumoEmpresa
  Height = 315
  Caption = 'Resumo por Empresa'
  Position = poMainFormCenter
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 242
    ExplicitTop = 242
  end
  inherited pnlStatus: TPanel
    Top = 270
    ExplicitTop = 270
    inherited pnlNomeForm: TPanel
      Left = 236
      Width = 247
      ExplicitLeft = 236
      ExplicitWidth = 247
    end
    inherited pnlInfo: TPanel
      Width = 236
      ExplicitWidth = 229
    end
  end
  object cxDadois: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 242
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 84
    ExplicitTop = 56
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skCount
          Column = cxgDadosValor
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          OnGetText = cxgDadosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText
          FieldName = 'VALOR'
          Column = cxgDadosValor
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosEMPRESA: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        MinWidth = 64
      end
      object cxgDadosCNPJ: TcxGridDBColumn
        DataBinding.FieldName = 'CNPJ'
        Width = 118
      end
      object cxgDadosValor: TcxGridDBColumn
        DataBinding.FieldName = 'Valor'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 263
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object dtsDados: TDataSource
    Left = 232
    Top = 116
  end
end
