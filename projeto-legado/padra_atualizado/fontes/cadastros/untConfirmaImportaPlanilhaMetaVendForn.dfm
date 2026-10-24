inherited frmConfirmaImportaPlanilhaMetaVendForn: TfrmConfirmaImportaPlanilhaMetaVendForn
  Width = 848
  Height = 558
  Caption = 
    'Importar Metas de Vendedores por Fornecedor - Valores de Faturam' +
    'ento  '
  ExplicitWidth = 848
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 487
    Width = 842
    ExplicitTop = 487
    ExplicitWidth = 842
    inherited FlwBotoes: TFlowPanel
      Width = 838
      ExplicitWidth = 838
    end
    inherited btnSair: TBitBtnLocked
      Left = 762
      ExplicitLeft = 762
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 842
    ExplicitTop = 513
    ExplicitWidth = 842
    inherited pnlNomeForm: TPanel
      Left = 576
      Width = 266
      ExplicitLeft = 576
      ExplicitWidth = 266
    end
    inherited pnlInfo: TPanel
      Width = 576
      ExplicitWidth = 568
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 842
    Height = 487
    ActivePage = tbsDados
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    TabStop = False
    object tbsDados: TTabSheet
      Caption = '&1 - Dados para altera'#231#227'o'
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 834
        Height = 455
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDadosTbv: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDados
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para filtrar'
          FilterRow.ApplyChanges = fracDelayed
          FilterRow.ApplyInputDelay = 500
          OptionsBehavior.FocusCellOnTab = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideSelection = True
          OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxgDadosTbvPERMES: TcxGridDBColumn
            Caption = 'M'#234's'
            DataBinding.FieldName = 'PERMES'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 46
          end
          object cxgDadosTbvPERANO: TcxGridDBColumn
            Caption = 'Ano'
            DataBinding.FieldName = 'PERANO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            FooterAlignmentHorz = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 43
          end
          object cxgDadosTbvCODVEN: TcxGridDBColumn
            Caption = 'C'#243'd. Vendedor'
            DataBinding.FieldName = 'CODVEN'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 79
          end
          object cxgDadosTbvNOMVEN: TcxGridDBColumn
            Caption = 'Nome Vendedor'
            DataBinding.FieldName = 'NOMVEN'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 160
          end
          object cxgDadosTbvCODFOR: TcxGridDBColumn
            Caption = 'C'#243'd. Fornecedor'
            DataBinding.FieldName = 'CODFOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 87
          end
          object cxgDadosTbvNOMFOR: TcxGridDBColumn
            Caption = 'Nome Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Width = 205
          end
          object cxgDadosTbvVALOR_: TcxGridDBColumn
            Caption = 'Valor'
            DataBinding.FieldName = 'VALOR_'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Width = 67
          end
          object cxgDadosTbvEXISTE: TcxGridDBColumn
            Caption = 'Existente'
            DataBinding.FieldName = 'EXISTE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Options.AutoWidthSizable = False
            Width = 54
          end
        end
        object cxgDadosLevel: TcxGridLevel
          GridView = cxgDadosTbv
        end
      end
    end
    object tbsErros: TTabSheet
      Caption = '&2 - Erros de Importa'#231#227'o'
      ImageIndex = 1
      object cxgErros: TcxGridCitel
        Left = 0
        Top = 0
        Width = 834
        Height = 455
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgErrosTbv: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsErros
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para filtrar'
          FilterRow.ApplyChanges = fracDelayed
          FilterRow.ApplyInputDelay = 500
          OptionsBehavior.FocusCellOnTab = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideSelection = True
          OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxgErrosTbvMENSAG: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'MENSAG'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 300
          end
          object cxgErrosTbvLINHA: TcxGridDBColumn
            Caption = 'Linha'
            DataBinding.FieldName = 'LINHA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxgErrosTbvCOLUNA: TcxGridDBColumn
            Caption = 'Coluna'
            DataBinding.FieldName = 'COLUNA'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxgErrosTbv
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 72
  end
  object dtsDados: TDataSource
    Left = 600
    Top = 160
  end
  object dtsErros: TDataSource
    Left = 688
    Top = 168
  end
end
