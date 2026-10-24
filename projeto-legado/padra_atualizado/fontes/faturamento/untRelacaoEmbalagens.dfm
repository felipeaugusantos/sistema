inherited frmRelacaoEmbalagens: TfrmRelacaoEmbalagens
  Width = 663
  Height = 341
  Caption = 'Rela'#231#227'o de Embalagens'
  Position = poScreenCenter
  ExplicitWidth = 663
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 270
    Width = 657
    ExplicitTop = 270
    ExplicitWidth = 657
    object Label1: TLabel [0]
      Left = 247
      Top = 6
      Width = 163
      Height = 14
      Caption = 'ENTER - Seleciona Embalagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 576
      ExplicitTop = 2
      ExplicitWidth = 653
    end
    inherited btnSair: TBitBtnLocked
      Left = 578
      Top = 2
      Align = alRight
      ExplicitLeft = 574
    end
  end
  inherited pnlStatus: TPanel
    Top = 296
    Width = 657
    ExplicitTop = 296
    ExplicitWidth = 657
    inherited pnlNomeForm: TPanel
      Left = 486
      ExplicitLeft = 486
    end
    inherited pnlInfo: TPanel
      Width = 486
      ExplicitWidth = 486
    end
  end
  object cxProdutos: TcxGridCitel [3]
    Left = 0
    Top = 40
    Width = 657
    Height = 230
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxProdutosDBTableView1: TcxGridDBTableViewCitel
      OnDblClick = cxProdutosDBTableView1DblClick
      OnKeyDown = cxProdutosDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsProdutos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxProdutosCODBAR: TcxGridDBColumn
        Caption = 'C'#243'digo de Barras'
        DataBinding.FieldName = 'CODBAR'
        Options.Editing = False
        Options.Moving = False
        Width = 140
      end
      object cxProdutosQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Moving = False
        Width = 90
      end
      object cxProdutosPREVEN: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda'
        DataBinding.FieldName = 'PREVEN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Moving = False
        Width = 122
      end
      object cxProdutosTABPRE: TcxGridDBColumn
        Caption = 'Tabela de Pre'#231'o'
        DataBinding.FieldName = 'TABPRE'
        Visible = False
        Options.Editing = False
        Options.Moving = False
        Width = 89
      end
      object cxProdutosDESEMB: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Embalagem'
        DataBinding.FieldName = 'DESEMB'
        Options.Editing = False
        Options.Moving = False
        Width = 278
      end
    end
    object cxProdutosLevel1: TcxGridLevel
      GridView = cxProdutosDBTableView1
    end
  end
  object pnlTopo: TPanel [4]
    Left = 0
    Top = 0
    Width = 657
    Height = 40
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lblProduto: TLabel
      Left = 12
      Top = 13
      Width = 273
      Height = 14
      Caption = 'Embalagens do Produto - 99999-XXXXXXXXXXXXXX'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 216
  end
  object dsProdutos: TDataSource
    Left = 528
    Top = 128
  end
end
