inherited frmFatTravaProdPreco: TfrmFatTravaProdPreco
  Width = 1086
  Height = 590
  Caption = 'Produtos abaixo do valor m'#237'nimo'
  Position = poMainFormCenter
  ExplicitWidth = 1086
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 515
    Width = 1080
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 515
    ExplicitWidth = 1080
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 1076
      Height = 26
      ExplicitWidth = 1076
      ExplicitHeight = 26
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 24
        Caption = '&Confirmar'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        Spacing = 0
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 999
      Top = 3
      ExplicitLeft = 999
      ExplicitTop = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1080
    ExplicitTop = 545
    ExplicitWidth = 1080
    inherited pnlNomeForm: TPanel
      Left = 909
      ExplicitLeft = 909
    end
    inherited pnlInfo: TPanel
      Width = 909
      ExplicitWidth = 909
    end
  end
  inherited pgcDados: TPageControl
    Width = 1080
    Height = 515
    ExplicitWidth = 1080
    ExplicitHeight = 515
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1072
      ExplicitHeight = 483
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 0
    Width = 1080
    Height = 515
    Align = alClient
    TabOrder = 3
    object cxgProdutos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1078
      Height = 478
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgProdutosDBTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgProdutosDBTableViewCustomDrawCell
        DataController.DataSource = dtsProdutos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxgProdutosCODITE: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 49
        end
        object cxgProdutosDESITE: TcxGridDBColumn
          Caption = 'Produto'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 425
        end
        object cxgProdutosPREORI: TcxGridDBColumn
          Caption = 'Valor Tabela'
          DataBinding.FieldName = 'PREORI'
          Options.Editing = False
          Width = 65
        end
        object cxgProdutosDESCON: TcxGridDBColumn
          Caption = 'Desc. Concedido'
          DataBinding.FieldName = 'DESCON'
          Options.Editing = False
          Width = 88
        end
        object cxgProdutosPRENOV: TcxGridDBColumn
          Caption = 'Unit'#225'rio Prat.'
          DataBinding.FieldName = 'PRENOV'
          Options.Editing = False
          Width = 79
        end
        object cxgProdutosPRECUS: TcxGridDBColumn
          Caption = 'Custo Real'
          DataBinding.FieldName = 'PRECUS'
          Options.Editing = False
          Width = 58
        end
        object cxgProdutosMARLIQ: TcxGridDBColumn
          Caption = 'Margem Liq. Prat.'
          DataBinding.FieldName = 'MARLIQ'
          Options.Editing = False
          Width = 89
        end
        object cxgProdutosPREPER: TcxGridDBColumn
          Caption = 'Pre'#231'o Min. Permitido'
          DataBinding.FieldName = 'PREPER'
          Options.Editing = False
          Width = 102
        end
        object cxgProdutosPREAUT: TcxGridDBColumn
          Caption = 'Pre'#231'o Autorizado'
          DataBinding.FieldName = 'PREAUT'
          Width = 89
        end
      end
      object cxgProdutosLevel: TcxGridLevel
        GridView = cxgProdutosDBTableView
      end
    end
    object pnlLegenda: TPanel
      Left = 1
      Top = 479
      Width = 1078
      Height = 35
      Align = alBottom
      TabOrder = 1
      object shpLegCampEdit: TShape
        Left = 8
        Top = 3
        Width = 20
        Height = 20
        Brush.Color = clYellow
      end
      object lblLegCampEdit: TLabel
        Left = 34
        Top = 6
        Width = 99
        Height = 13
        Caption = 'Campos Editaveis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1024
    Top = 568
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 992
    Top = 568
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 920
    Top = 592
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 1000
    Top = 336
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 864
    Top = 336
    object cdsProdutosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsProdutosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 100
    end
    object cdsProdutosPREORI: TFloatField
      FieldName = 'PREORI'
    end
    object cdsProdutosDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object cdsProdutosPRENOV: TFloatField
      FieldName = 'PRENOV'
    end
    object cdsProdutosPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsProdutosMARLIQ: TFloatField
      FieldName = 'MARLIQ'
    end
    object cdsProdutosPREPER: TFloatField
      FieldName = 'PREPER'
    end
    object cdsProdutosPREAUT: TFloatField
      FieldName = 'PREAUT'
    end
    object cdsProdutosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsProdutosSEQFDO: TStringField
      FieldName = 'SEQFDO'
    end
  end
end
