inherited frmItensCotacaoSemCotacao: TfrmItensCotacaoSemCotacao
  Width = 679
  Height = 568
  Caption = 'Produtos sem fornecedor'
  ExplicitWidth = 679
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 0
    Top = 0
    Width = 673
    Height = 14
    Align = alTop
    Caption = 
      'Os produtos abaixo n'#227'o foram selecionados para cota'#231#227'o em nenhum' +
      ' dos fornecedores listados.'
    ExplicitWidth = 472
  end
  inherited pnlBotoes: TPanel
    Top = 497
    Width = 673
    inherited FlwBotoes: TFlowPanel
      Width = 669
    end
    inherited btnSair: TBitBtnLocked
      Left = 593
    end
  end
  inherited pnlStatus: TPanel
    Top = 523
    Width = 673
    inherited pnlNomeForm: TPanel
      Left = 502
    end
    inherited pnlInfo: TPanel
      Width = 502
    end
  end
  object rdgOpcao: TRadioGroup [4]
    Left = 0
    Top = 440
    Width = 673
    Height = 57
    Align = alBottom
    Caption = 'Escolha uma das opc'#245'es abaixo:'
    ItemIndex = 0
    Items.Strings = (
      
        'Gerar pedido de compra dos produtos selecionados e descartar os ' +
        'produtos n'#227'o selecionados.'
      
        'Gerar pedido de compra dos produtos selecionados e gerar nova co' +
        'ta'#231#227'o com os produtos n'#227'o selecionados.')
    TabOrder = 3
  end
  object cxgItens: TcxGridCitel [5]
    Left = 0
    Top = 14
    Width = 673
    Height = 426
    Align = alClient
    TabOrder = 4
    ExplicitLeft = 216
    ExplicitTop = 32
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'cod. Item'
        DataBinding.FieldName = 'CODITE'
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 427
      end
      object cxvItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
    end
    object cxlItens: TcxGridLevel
      GridView = cxvItens
    end
  end
  object dtsItens: TDataSource
    Left = 324
    Top = 272
  end
end
