inherited frmItensDocumento: TfrmItensDocumento
  Width = 640
  Height = 399
  Caption = 'Itens do Documento'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 640
  ExplicitHeight = 399
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 326
    Width = 634
    inherited FlwBotoes: TFlowPanel
      Width = 630
    end
    inherited btnSair: TBitBtnLocked
      Left = 554
    end
  end
  inherited pnlStatus: TPanel
    Top = 354
    Width = 634
    inherited pnlNomeForm: TPanel
      Left = 463
    end
    inherited pnlInfo: TPanel
      Width = 463
    end
  end
  object cxgItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 634
    Height = 326
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = -3
    ExplicitWidth = 483
    ExplicitHeight = 189
    object cxgItensTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.AutoDataSetFilter = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensTvCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        Width = 57
      end
      object cxgItensTvDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 234
      end
      object cxgItensTvMARCA_: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MARCA_'
        Width = 104
      end
      object cxgItensTvCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Width = 94
      end
      object cxgItensTvUNIDAD: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'UNIDAD'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 54
      end
      object cxgItensTvQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 74
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTv
    end
  end
end
