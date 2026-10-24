inherited frmFornecDuplicados: TfrmFornecDuplicados
  Width = 839
  Height = 484
  Caption = 'Fornecedores Duplicados'
  ExplicitWidth = 839
  ExplicitHeight = 484
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 411
    Width = 833
    ExplicitTop = 411
    ExplicitWidth = 833
    inherited FlwBotoes: TFlowPanel
      Width = 829
    end
    inherited btnSair: TBitBtnLocked
      Left = 750
      ExplicitLeft = 750
    end
  end
  inherited pnlStatus: TPanel
    Top = 439
    Width = 833
    ExplicitTop = 439
    ExplicitWidth = 833
    inherited pnlNomeForm: TPanel
      Left = 662
      ExplicitLeft = 662
    end
    inherited pnlInfo: TPanel
      Width = 662
      ExplicitWidth = 662
    end
  end
  object mmo1: TMemo [2]
    Left = 0
    Top = 0
    Width = 833
    Height = 65
    Align = alTop
    Alignment = taCenter
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        'H'#225' mais de uma tabela para o mesmo fornecedor, a altera'#231#227'o n'#227'o s' +
        'er'#225' realizada.')
    ParentFont = False
    TabOrder = 2
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 833
    Height = 346
    Align = alClient
    TabOrder = 3
    object cxvItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Tabela Pre'#231'o'
        DataBinding.FieldName = 'CODTAB'
        HeaderAlignmentHorz = taCenter
        Width = 97
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Descri'#231#227'o da Tabela de Pre'#231'o'
        DataBinding.FieldName = 'NOMTAB'
        Width = 339
      end
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd.Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 110
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        SortIndex = 0
        SortOrder = soAscending
        Width = 285
      end
    end
    object cxlItensLevel1: TcxGridLevel
      GridView = cxvItensView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 144
  end
  object dtsItens: TDataSource
    Left = 680
    Top = 224
  end
end
