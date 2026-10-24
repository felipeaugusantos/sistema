inherited frmDigCtaFornecedores: TfrmDigCtaFornecedores
  Width = 850
  Height = 540
  BorderStyle = bsSizeable
  Caption = 'Selecione o Plano de Contas para cada fornecedor'
  ExplicitWidth = 850
  ExplicitHeight = 540
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 458
    Width = 834
    TabOrder = 1
    ExplicitTop = 458
    ExplicitWidth = 834
    inherited btnSair: TBitBtnLocked
      Left = 753
      ExplicitLeft = 753
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 486
    Width = 834
    TabOrder = 2
    ExplicitTop = 486
    ExplicitWidth = 834
    inherited pnlNomeForm: TPanel
      Left = 663
      ExplicitLeft = 663
    end
    inherited pnlInfo: TPanel
      Width = 663
      ExplicitWidth = 663
    end
  end
  object cxgFornec: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 834
    Height = 458
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvFornec: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvFornecCODFOR: TcxGridDBColumn
        Caption = 'C'#243'digo Fornec.'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 83
      end
      object cxvFornecNOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 283
      end
      object cxvFornecCODCTA: TcxGridDBColumn
        Caption = 'Plano de Contas'
        DataBinding.FieldName = 'CODCTA'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CODCTA'
        Properties.ListColumns = <
          item
            FieldName = 'DESCTA'
          end>
        Properties.ListOptions.CaseInsensitive = True
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dtsCodCta
        OnGetDisplayText = cxvFornecCODCTAGetDisplayText
        Width = 466
      end
      object cxvFornecDESCTA: TcxGridDBColumn
        DataBinding.FieldName = 'DESCTA'
        Visible = False
      end
    end
    object cxgFornecLevel1: TcxGridLevel
      GridView = cxvFornec
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 312
  end
  object dtsCodCta: TDataSource
    Left = 504
    Top = 72
  end
end
