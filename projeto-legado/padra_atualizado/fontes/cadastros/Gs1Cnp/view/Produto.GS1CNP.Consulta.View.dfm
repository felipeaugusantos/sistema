inherited ProdutoGS1CNPConsultaView: TProdutoGS1CNPConsultaView
  Width = 639
  Height = 453
  Caption = 'Consultar cadastro'
  OnDestroy = FormDestroy
  ExplicitWidth = 639
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 380
    Width = 633
    ExplicitTop = 380
    ExplicitWidth = 633
    inherited btnSair: TBitBtnLocked
      Left = 550
      ExplicitLeft = 550
    end
  end
  inherited pnlStatus: TPanel
    Top = 408
    Width = 633
    ExplicitTop = 408
    ExplicitWidth = 633
    inherited pnlNomeForm: TPanel
      Left = 462
      ExplicitLeft = 462
    end
    inherited pnlInfo: TPanel
      Width = 462
      ExplicitWidth = 462
    end
  end
  object pnlStatusCadastro: TPanel [3]
    Left = 0
    Top = 339
    Width = 633
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
    TabOrder = 3
    Visible = False
  end
  object grdDadosConsulta: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 633
    Height = 339
    Align = alClient
    TabOrder = 4
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
        Caption = 'Valor Cad. Produtos'
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
        Properties.OnChange = grdDadosConsultaTableViewTrocarPropertiesChange
        Width = 91
      end
    end
    object grdDadosConsultaLevel: TcxGridLevel
      GridView = grdDadosConsultaTableView
    end
  end
end
