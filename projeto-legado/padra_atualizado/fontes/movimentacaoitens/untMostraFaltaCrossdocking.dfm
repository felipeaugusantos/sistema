inherited frmMostraFaltaCrossdocking: TfrmMostraFaltaCrossdocking
  Width = 804
  Height = 486
  BorderStyle = bsSizeable
  Caption = 'Produtos com falta de Lote  Crossdocking'
  ExplicitWidth = 804
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 404
    Width = 788
    inherited btnSair: TBitBtnLocked
      Left = 708
      ExplicitLeft = 708
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      Visible = False
      ExplicitLeft = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 432
    Width = 788
    inherited pnlNomeForm: TPanel
      Left = 617
    end
    inherited pnlInfo: TPanel
      Width = 617
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 788
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = 
      'Os produtos abaixo n'#227'o possuem Lote Crossdocking. Configure os L' +
      'otes, no Cadastro de Lotes, para prosseguir.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    ExplicitWidth = 841
  end
  object cxgItens: TcxGridCitel [4]
    Left = 0
    Top = 49
    Width = 788
    Height = 355
    Align = alClient
    TabOrder = 4
    ExplicitLeft = 88
    ExplicitTop = 104
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'FDO_CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 76
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'FDO_DESCRI'
        Width = 688
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 560
    Top = 168
  end
  object dtsConsulta: TDataSource
    Left = 136
    Top = 232
  end
end
