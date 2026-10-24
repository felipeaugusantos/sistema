inherited frmImportaLimiteComprasFornecedor: TfrmImportaLimiteComprasFornecedor
  Width = 1024
  Height = 513
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o de Limite de Compras por Fornecedor'
  ExplicitWidth = 1024
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 430
    Width = 1008
    ExplicitTop = 430
    ExplicitWidth = 1008
    inherited btnSair: TBitBtnLocked
      Left = 927
      ExplicitLeft = 927
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 5
      Width = 168
      Caption = '[ F10 ] Importa dados v'#225'lidos'
      ExplicitLeft = 5
      ExplicitWidth = 168
    end
  end
  inherited pnlStatus: TPanel
    Top = 458
    Width = 1008
    ExplicitTop = 458
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
  object cxgLinhas: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 430
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 382
    object cxvLinhas: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum dado encontrado>'
      OptionsView.GroupByBox = False
      object cxvLinhasCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd. Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 95
      end
      object cxvLinhasNOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 218
      end
      object cxvLinhasNROANO: TcxGridDBColumn
        Caption = 'Ano'
        DataBinding.FieldName = 'NROANO'
        HeaderAlignmentHorz = taCenter
        Width = 63
      end
      object cxvLinhasNROMES: TcxGridDBColumn
        Caption = 'M'#234's'
        DataBinding.FieldName = 'NROMES'
        HeaderAlignmentHorz = taCenter
        Width = 57
      end
      object cxvLinhasVALPED: TcxGridDBColumn
        Caption = 'Novo Valor'
        DataBinding.FieldName = 'VALPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 95
      end
      object cxvLinhasVALANT: TcxGridDBColumn
        Caption = 'Valor Anterior'
        DataBinding.FieldName = 'VALANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 102
      end
      object cxvLinhasCOMERR: TcxGridDBColumn
        Caption = 'Com Erro'
        DataBinding.FieldName = 'COMERR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxvLinhasMSGERR: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'MSGERR'
        Width = 287
      end
    end
    object cxgLinhasLevel1: TcxGridLevel
      GridView = cxvLinhas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 256
  end
end
