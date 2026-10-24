inherited frmItensDuplicados: TfrmItensDuplicados
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Items que est'#227'o em mais de uma tabela'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 784
    ExplicitTop = 517
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 709
      ExplicitLeft = 709
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object Memo1: TMemo [2]
    Left = 0
    Top = 0
    Width = 784
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
      'Os itens abaixo est'#227'o em mais de uma tabela de pre'#231'o, '
      'a altera'#231#227'o n'#227'o ser'#225' realizada.')
    ParentFont = False
    TabOrder = 2
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 65
    Width = 784
    Height = 452
    Align = alClient
    TabOrder = 3
    object cxgItensView: TcxGridDBTableView
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
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 61
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        SortIndex = 0
        SortOrder = soAscending
        Width = 295
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Tabela Pre'#231'o'
        DataBinding.FieldName = 'CODTAB'
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Descri'#231#227'o da Tabela de Pre'#231'o'
        DataBinding.FieldName = 'NOMTAB'
        Width = 350
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 120
  end
  object dtsItens: TDataSource
    Left = 680
    Top = 224
  end
end
