inherited frmAltPrecoGlobalPrecoPautaFiscal: TfrmAltPrecoGlobalPrecoPautaFiscal
  Width = 800
  Height = 640
  Caption = 'frmAltPrecoGlobalPrecoPautaFiscal'
  ExplicitWidth = 800
  ExplicitHeight = 640
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 567
    Width = 794
    ExplicitTop = 567
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 2
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 595
    Width = 794
    ExplicitTop = 595
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object cxGridPautaFiscal: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 567
    Align = alClient
    TabOrder = 2
    object cxGridPautaFiscalDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsPrecoPautaFiscal
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridPautaFiscalDBTableViewPPF_CODITE: TcxGridDBColumn
        DataBinding.FieldName = 'PPF_CODITE'
        Visible = False
      end
      object cxGridPautaFiscalDBTableViewPPF_ESTADO: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'PPF_ESTADO'
        Options.Editing = False
        Options.Focusing = False
        Options.Sorting = False
        Width = 80
      end
      object cxGridPautaFiscalDBTableViewPPF_VLRPPF: TcxGridDBColumn
        Caption = 'Pre'#231'o da Pauta Fiscal'
        DataBinding.FieldName = 'PPF_VLRPPF'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ' ,0.0000;- ,0.0000'
        HeaderAlignmentHorz = taRightJustify
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 50
      end
      object cxGridPautaFiscalDBTableViewPPF_DTAINI: TcxGridDBColumn
        Caption = 'Data In'#237'cio da Vig'#234'ncia'
        DataBinding.FieldName = 'PPF_DTAINI'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 60
      end
      object cxGridPautaFiscalDBTableViewPPF_DTAFIN: TcxGridDBColumn
        Caption = 'Data Final da Vig'#234'ncia'
        DataBinding.FieldName = 'PPF_DTAFIN'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ImmediatePost = True
        HeaderAlignmentHorz = taCenter
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 60
      end
    end
    object cxGridPautaFiscalLevel1: TcxGridLevel
      GridView = cxGridPautaFiscalDBTableView
    end
  end
  object dtsPrecoPautaFiscal: TDataSource
    Left = 303
    Top = 149
  end
end
