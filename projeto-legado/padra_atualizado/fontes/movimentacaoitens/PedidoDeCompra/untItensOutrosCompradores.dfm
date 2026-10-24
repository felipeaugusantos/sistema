inherited frmItensOutrosCompradores: TfrmItensOutrosCompradores
  Width = 599
  Height = 455
  Caption = 'Itens que pertencem a grupos de compras de outros compradores'
  ExplicitWidth = 599
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 383
    Width = 593
    ExplicitTop = 383
    ExplicitWidth = 593
    inherited btnSair: TBitBtnLocked
      Left = 510
      ExplicitLeft = 510
    end
  end
  inherited pnlStatus: TPanel
    Top = 411
    Width = 593
    ExplicitTop = 411
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 422
      ExplicitLeft = 422
    end
    inherited pnlInfo: TPanel
      Width = 422
      ExplicitWidth = 422
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 593
    Height = 383
    Align = alClient
    TabOrder = 2
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 57
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 455
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Comprador'
        DataBinding.FieldName = 'CODOPE'
        Width = 61
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object dtsItens: TDataSource
    Left = 368
    Top = 8
  end
end
