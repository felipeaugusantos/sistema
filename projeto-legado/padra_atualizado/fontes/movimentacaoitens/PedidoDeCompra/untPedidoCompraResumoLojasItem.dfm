inherited frmPedidoCompraResumoLojasItem: TfrmPedidoCompraResumoLojasItem
  Width = 987
  Height = 454
  Caption = 'Itens da Loja'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 987
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 382
    Width = 981
    TabOrder = 1
    ExplicitTop = 382
    ExplicitWidth = 981
    inherited btnSair: TBitBtnLocked
      Left = 898
      ExplicitLeft = 898
    end
  end
  inherited pnlStatus: TPanel
    Top = 410
    Width = 981
    TabOrder = 2
    ExplicitTop = 410
    ExplicitWidth = 981
    inherited pnlNomeForm: TPanel
      Left = 810
      ExplicitLeft = 810
    end
    inherited pnlInfo: TPanel
      Width = 810
      ExplicitWidth = 810
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 981
    Height = 382
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          Column = cxvItensTOTGER
        end
        item
          Kind = skSum
          Column = cxvItensTOTITE
        end
        item
          Kind = skSum
          Column = cxvItensTOTIPI
        end
        item
          Kind = skSum
          Column = cxvItensTOTCBS
        end
        item
          Kind = skSum
          Column = cxvItensTOTIBS
        end
        item
          Kind = skSum
          Column = cxvItensTOT_IS
        end
        item
          Kind = skSum
          Column = cxvItensTOTSUB
        end
        item
          Kind = skSum
          Column = cxvItensQTDITE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Nenhum item para essa empresa'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Styles.ContentOdd = cxStyle1
      Styles.Selection = cxStyle2
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 57
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Width = 381
      end
      object cxvItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Width = 51
      end
      object cxvItensQTDITE: TcxGridDBColumn
        Caption = 'Qtde.'
        DataBinding.FieldName = 'QTDITE'
      end
      object cxvItensTOTITE: TcxGridDBColumn
        Caption = 'Total Itens'
        DataBinding.FieldName = 'TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvItensTOTIPI: TcxGridDBColumn
        Caption = 'Total IPI'
        DataBinding.FieldName = 'TOTIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvItensTOTCBS: TcxGridDBColumn
        Caption = 'Total CBS'
        DataBinding.FieldName = 'TOTCBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxvItensTOTIBS: TcxGridDBColumn
        Caption = 'Total IBS'
        DataBinding.FieldName = 'TOTIBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxvItensTOT_IS: TcxGridDBColumn
        Caption = 'Total IS'
        DataBinding.FieldName = 'TOT_IS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxvItensTOTSUB: TcxGridDBColumn
        Caption = 'Total ST'
        DataBinding.FieldName = 'TOTSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxvItensTOTGER: TcxGridDBColumn
        Caption = 'Itens+IPI+ST'
        DataBinding.FieldName = 'TOTGER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 168
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 56
    Top = 88
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
end
