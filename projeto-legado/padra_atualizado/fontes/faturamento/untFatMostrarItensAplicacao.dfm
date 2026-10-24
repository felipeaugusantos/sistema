inherited frmFatMostrarItensAplicacao: TfrmFatMostrarItensAplicacao
  Width = 729
  Height = 463
  Caption = 'Mostrar Itens por Aplica'#231#227'o'
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  ExplicitWidth = 729
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 391
    Width = 723
    ExplicitTop = 391
    ExplicitWidth = 723
    inherited btnSair: TBitBtnLocked
      Left = 640
      ExplicitLeft = 640
    end
  end
  inherited pnlStatus: TPanel
    Top = 419
    Width = 723
    ExplicitTop = 419
    ExplicitWidth = 723
    inherited pnlNomeForm: TPanel
      Left = 552
      ExplicitLeft = 552
    end
    inherited pnlInfo: TPanel
      Width = 552
      ExplicitWidth = 552
    end
  end
  object cxgrdDadosProdutos: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 723
    Height = 391
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    object cxgrdDadosProdutosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDadosProdutos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          OnGetText = cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText
          FieldName = 'ITE_UNITAR'
          Column = ITE_UNITAR
        end
        item
          Format = ',0.00;(,0.00)'
          Kind = skSum
          OnGetText = cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText
          FieldName = 'ITE_TOTITE'
          Column = ITE_TOTITE
        end>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
              Column = ITE_APLICA
            end>
          SummaryItems = <
            item
              FieldName = 'ITE_APLICA'
              Column = ITE_APLICA
              DisplayText = 'Aplica'#231#227'o'
            end>
        end>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object ITE_CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 73
      end
      object ITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 291
      end
      object ITE_ENTSAI: TcxGridDBColumn
        Caption = 'E/S'
        DataBinding.FieldName = 'ITE_ENTSAI'
        Width = 40
      end
      object UNI_SIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Width = 41
      end
      object ITE_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        Width = 70
      end
      object ITE_UNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit'#225'rio'
        DataBinding.FieldName = 'ITE_UNITAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 79
      end
      object ITE_TOTITE: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'ITE_TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 105
      end
      object ITE_APLICA: TcxGridDBColumn
        Caption = 'Aplica'#231#227'o'
        DataBinding.FieldName = 'ITE_APLICA'
        Visible = False
        GroupIndex = 0
        Options.Moving = False
        SortIndex = 0
        SortOrder = soAscending
      end
    end
    object cxgrdlvlDadosProdutosLevel1: TcxGridLevel
      GridView = cxgrdDadosProdutosDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 96
  end
  object dsDadosProdutos: TDataSource
    Left = 505
    Top = 95
  end
end
