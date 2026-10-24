inherited ProdutoGS1CNPInconsistenciaView: TProdutoGS1CNPInconsistenciaView
  Width = 900
  Height = 453
  Caption = 'Retorno das inconsist'#234'ncias do cadastro produto GS1/CNP'
  ExplicitWidth = 900
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 894
    ExplicitTop = 380
    ExplicitWidth = 894
    inherited btnSair: TBitBtnLocked
      Left = 811
      ExplicitLeft = 811
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 894
    ExplicitTop = 408
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object grdDadosConsulta: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 894
    Height = 380
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosConsultaTableView: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdDadosConsultaTableViewCodigo: TcxGridColumn
        Caption = 'C'#243'digo'
        Options.Editing = False
        Width = 90
      end
      object grdDadosConsultaTableViewMensagem: TcxGridColumn
        Caption = 'Mensagem'
        Options.Editing = False
        Width = 389
      end
      object grdDadosConsultaTableViewCampoArquivo: TcxGridColumn
        Caption = 'Campo arquivo'
        Options.Editing = False
        Width = 389
      end
    end
    object grdDadosConsultaLevel: TcxGridLevel
      GridView = grdDadosConsultaTableView
    end
  end
end
