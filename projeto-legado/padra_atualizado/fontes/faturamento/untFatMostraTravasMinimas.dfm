inherited frmFatMostraTravasMinimas: TfrmFatMostraTravasMinimas
  Width = 1024
  Height = 450
  Caption = 'Consulta de Travas M'#237'nimas'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 1018
    ExplicitTop = 377
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitTop = 2
      ExplicitWidth = 1014
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 1018
    ExplicitTop = 405
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object cxGridCitel1: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 377
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxgTravaMinimaQTDITE
        end
        item
          Kind = skSum
          Column = cxgTravaMinimaVLRTAB
        end
        item
          Kind = skSum
          Column = cxgTravaMinimaTOTVLRTAB
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
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgTravaMinimaCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 78
      end
      object cxgTravaMinimaDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 177
      end
      object cxgTravaMinimaUNIDAD: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNIDAD'
        Width = 28
      end
      object cxgTravaMinimaQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 66
      end
      object cxgTravaMinimaVLRTAB: TcxGridDBColumn
        Caption = 'Vr.Unit.Tab.'
        DataBinding.FieldName = 'VLRTAB'
        Width = 83
      end
      object cxgTravaMinimaTOTVLRTAB: TcxGridDBColumn
        Caption = 'Vr.Tot.Tab.'
        DataBinding.FieldName = 'TOTVLRTAB'
        Width = 83
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitel1DBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 424
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 96
  end
  object dtsDados: TDataSource
    Left = 360
    Top = 96
  end
end
