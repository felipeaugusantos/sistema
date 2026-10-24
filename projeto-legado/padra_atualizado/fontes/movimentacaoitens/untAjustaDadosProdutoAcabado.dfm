inherited frmAjustaDadosProdutoAcabado: TfrmAjustaDadosProdutoAcabado
  Width = 786
  Height = 349
  Caption = 'Ajusta Dados do Produto Acabado'
  ExplicitWidth = 786
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 278
    Width = 780
    ExplicitTop = 278
    ExplicitWidth = 780
    inherited FlwBotoes: TFlowPanel
      Width = 776
      ExplicitWidth = 776
    end
    inherited btnSair: TBitBtnLocked
      Left = 697
      Visible = False
      ExplicitLeft = 697
    end
  end
  inherited pnlStatus: TPanel
    Top = 304
    Width = 780
    ExplicitTop = 304
    ExplicitWidth = 780
    inherited pnlNomeForm: TPanel
      Left = 609
      ExplicitLeft = 609
    end
    inherited pnlInfo: TPanel
      Width = 609
      ExplicitWidth = 609
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 780
    Height = 278
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensORDITE: TcxGridDBColumn
        Caption = 'IT'
        DataBinding.FieldName = 'ORDITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 47
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Embalagem'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 195
      end
      object cxgItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 50
      end
      object cxgItensQTDPRO: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ORD_QTDPRO'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 67
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Volume (LT)'
        DataBinding.FieldName = 'VOLACA'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensPESUNI: TcxGridDBColumn
        Caption = 'Peso (KG)'
        DataBinding.FieldName = 'PESACA'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensQTDENV: TcxGridDBColumn
        Caption = 'Envasado'
        DataBinding.FieldName = 'ORD_QTDENV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 77
      end
      object cxgItensNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = LoteRapido
            Default = True
            Kind = bkText
          end
          item
            Action = PesqLotes
            Kind = bkText
          end>
        Width = 120
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object ActionList1: TActionList
    Left = 384
    Top = 104
    object LoteRapido: TAction
      Caption = 'Cadastrar Lote'
      OnExecute = LoteRapidoExecute
    end
    object PesqLotes: TAction
      Caption = 'Carregar Lote'
      OnExecute = PesqLotesExecute
    end
  end
end
