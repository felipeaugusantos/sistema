inherited frmConfirmaImportacaoVendedorMarca: TfrmConfirmaImportacaoVendedorMarca
  Width = 826
  Height = 581
  BorderStyle = bsSingle
  Caption = 'Altera'#231#227'o Global de Vendedores e Marcas - Clientes'
  OnDestroy = FormDestroy
  ExplicitWidth = 826
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 820
    ExplicitTop = 510
    ExplicitWidth = 832
    inherited FlwBotoes: TFlowPanel
      Width = 816
      ExplicitWidth = 828
      inherited btnConfirma: TBitBtnLocked
        Width = 90
        ModalResult = 0
        ExplicitWidth = 90
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 726
      Width = 90
      ExplicitLeft = 726
      ExplicitWidth = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 536
    Width = 820
    ExplicitTop = 536
    ExplicitWidth = 832
    inherited pnlNomeForm: TPanel
      Left = 600
      Width = 220
      ExplicitLeft = 600
      ExplicitWidth = 220
    end
    inherited pnlInfo: TPanel
      Width = 600
      ExplicitWidth = 617
    end
  end
  object pgcDados: TPageControl [2]
    Left = 0
    Top = 0
    Width = 820
    Height = 510
    ActivePage = tbsDados
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    TabStop = False
    ExplicitWidth = 832
    object tbsDados: TTabSheet
      Caption = '&1 - Dados para altera'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 824
      ExplicitHeight = 0
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 0
        Width = 812
        Height = 478
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 824
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
          object cxgDadosTbvCODCLI: TcxGridDBColumn
            Caption = 'C'#243'd. Cliente'
            DataBinding.FieldName = 'CODCLI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxgDadosTbvNOMCLI: TcxGridDBColumn
            Caption = 'Nome Cliente'
            DataBinding.FieldName = 'NOMCLI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 250
          end
          object cxgDadosTbvCODVEN: TcxGridDBColumn
            Caption = 'C'#243'd. Vendedor'
            DataBinding.FieldName = 'CODVEN'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxgDadosTbvCODMAR: TcxGridDBColumn
            Caption = 'C'#243'd. Marca'
            DataBinding.FieldName = 'CODMAR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object cxgDadosTbvDESMAR: TcxGridDBColumn
            Caption = 'Descri'#231#227'o Marca'
            DataBinding.FieldName = 'DESMAR'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 180
          end
          object cxgDadosTbvOPERAC: TcxGridDBColumn
            Caption = 'Opera'#231#227'o'
            DataBinding.FieldName = 'OPERAC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object cxgDadosTbvVALIDO: TcxGridDBColumn
            Caption = 'V'#225'lido'
            DataBinding.FieldName = 'VALIDO'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 824
      ExplicitHeight = 0
      object cxgErros: TcxGridCitel
        Left = 0
        Top = 0
        Width = 812
        Height = 478
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 824
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
    Left = 544
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 64
  end
  object dtsDados: TDataSource
    Left = 624
    Top = 64
  end
  object dtsErros: TDataSource
    Left = 656
    Top = 64
  end
end
