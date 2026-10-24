inherited frmImportarArquivoParaAnalise_de_Compras_Totais: TfrmImportarArquivoParaAnalise_de_Compras_Totais
  Width = 579
  Height = 517
  Caption = 'Totais por Fornecedor'
  ExplicitWidth = 579
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 444
    Width = 573
    ExplicitTop = 444
    ExplicitWidth = 573
    inherited btnSair: TBitBtnLocked
      Left = 490
      ExplicitLeft = 490
    end
  end
  inherited pnlStatus: TPanel
    Top = 472
    Width = 573
    ExplicitTop = 472
    ExplicitWidth = 573
    inherited pnlNomeForm: TPanel
      Left = 402
      ExplicitLeft = 402
    end
    inherited pnlInfo: TPanel
      Width = 402
      ExplicitWidth = 402
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 573
    Height = 444
    Align = alClient
    TabOrder = 3
    object cxDadosDB: TcxGridDBTableView
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
      object cxDadosCODFOR: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODFOR'
      end
      object cxDadosNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 410
      end
      object cxDadosTOTPED: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'TOTPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object cxDadosLvl: TcxGridLevel
      GridView = cxDadosDB
    end
  end
  object dtsDados: TDataSource
    Left = 232
    Top = 116
  end
end
