inherited frmConsultaCadastroFit: TfrmConsultaCadastroFit
  Width = 640
  Height = 453
  Caption = 'Consultar cadastro'
  OnDestroy = FormDestroy
  ExplicitWidth = 640
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 382
    Width = 634
    ExplicitTop = 382
    ExplicitWidth = 634
    inherited FlwBotoes: TFlowPanel
      Width = 630
      ExplicitWidth = 630
    end
    inherited btnSair: TBitBtnLocked
      Left = 551
      ExplicitLeft = 551
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 634
    ExplicitTop = 408
    ExplicitWidth = 634
    inherited pnlNomeForm: TPanel
      Left = 463
      ExplicitLeft = 463
    end
    inherited pnlInfo: TPanel
      Width = 463
      ExplicitWidth = 463
    end
  end
  object grdDadosConsulta: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 634
    Height = 341
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosConsultaTableView: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdDadosConsultaTableViewCustomDrawCell
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
      object grdDadosConsultaTableViewCampo: TcxGridColumn
        Caption = 'Campo'
        Options.Editing = False
        Width = 151
      end
      object grdDadosConsultaTableViewValorCadCli: TcxGridColumn
        Caption = 'Valor Cad. Clientes'
        Options.Editing = False
        Width = 389
      end
      object grdDadosConsultaTableViewValor: TcxGridColumn
        Caption = 'Valor'
        Options.Editing = False
        Width = 389
      end
      object grdDadosConsultaTableViewTrocar: TcxGridColumn
        Caption = 'Trocar'
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Width = 91
      end
    end
    object grdDadosConsultaLevel: TcxGridLevel
      GridView = grdDadosConsultaTableView
    end
  end
  object pnlStatusCadastro: TPanel [3]
    Left = 0
    Top = 341
    Width = 634
    Height = 41
    Align = alBottom
    Caption = 'N'#227'o habilitado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object browser: TTMSFNCWebBrowser [4]
    Left = 752
    Top = 8
    Width = 369
    Height = 233
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 4
    URL = 'about:blank'
  end
end
