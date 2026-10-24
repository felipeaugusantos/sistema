inherited frmMostraLimiteEstoqMax: TfrmMostraLimiteEstoqMax
  Width = 1024
  Height = 459
  BorderStyle = bsSizeable
  Caption = 
    'Este pedido de compra possui produtos com quantidade de compra q' +
    'ue deixar'#225' o saldo de estoque maior que o estoque m'#225'ximo'
  ExplicitWidth = 1024
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 1008
    ExplicitTop = 376
    ExplicitWidth = 1008
    inherited btnSair: TBitBtnLocked
      Left = 925
      Caption = 'Ok'
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 1008
    ExplicitTop = 404
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 376
    Align = alClient
    TabOrder = 3
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 63
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 417
      end
      object cxvItensSIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        Width = 40
      end
      object cxvItensCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
      object cxvItensQTDCOM: TcxGridDBColumn
        Caption = 'Qtd. Comprada'
        DataBinding.FieldName = 'QTDCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object cxvItensQTDREQ: TcxGridDBColumn
        Caption = 'Qtd. Requisi'#231#227'o'
        DataBinding.FieldName = 'QTDREQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object cxvItensSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon.'
        DataBinding.FieldName = 'SALDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object cxvItensESTMAX: TcxGridDBColumn
        Caption = 'Estoq. M'#225'ximo'
        DataBinding.FieldName = 'ESTMAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
      object cxvItensQTDEXC: TcxGridDBColumn
        Caption = 'Qtd. Excedente'
        DataBinding.FieldName = 'QTDEXC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 83
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 232
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 232
  end
end
