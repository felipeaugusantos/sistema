inherited frmVendaBaseTrocaInfProduto: TfrmVendaBaseTrocaInfProduto
  Width = 845
  Height = 500
  Caption = 'Venda a Base de Trocas - Informar Produtos'
  ExplicitWidth = 845
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 839
    ExplicitTop = 429
    ExplicitWidth = 839
    inherited FlwBotoes: TFlowPanel
      Width = 835
      ExplicitWidth = 835
    end
    inherited btnSair: TBitBtnLocked
      Left = 756
      ExplicitLeft = 756
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 839
    ExplicitTop = 455
    ExplicitWidth = 839
    inherited pnlNomeForm: TPanel
      Left = 668
      ExplicitLeft = 668
    end
    inherited pnlInfo: TPanel
      Width = 668
      ExplicitWidth = 668
    end
  end
  object pnlAdicionar: TPanel [2]
    Left = 0
    Top = 0
    Width = 839
    Height = 113
    Align = alTop
    TabOrder = 2
    object lblCodCliente: TLabel
      Left = 510
      Top = 16
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblDocumento: TLabel
      Left = 23
      Top = 16
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object lblProduto: TLabel
      Left = 40
      Top = 40
      Width = 40
      Height = 14
      Caption = 'Produto:'
    end
    object lblTipRec: TLabel
      Left = 57
      Top = 65
      Width = 23
      Height = 14
      Caption = 'Tipo:'
    end
    object lblVlrUnit: TLabel
      Left = 219
      Top = 65
      Width = 67
      Height = 14
      Caption = 'Valor Unit'#225'rio:'
    end
    object lblQuantidade: TLabel
      Left = 487
      Top = 65
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
    end
    object clrlblPesoUnit: TColorLabel
      Left = 112
      Top = 65
      Width = 79
      Height = 14
      Caption = '(P)eso (U)nit'#225'rio'
      CorDestaque = clRed
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 548
      Top = 13
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 8
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 618
      Top = 13
      Width = 190
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Left = 84
      Top = 13
      Width = 202
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Left = 287
      Top = 13
      Width = 58
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEmpDoc: TEditFocus
      Left = 346
      Top = 13
      Width = 58
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 84
      Top = 37
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 5
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 154
      Top = 37
      Width = 250
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVlrUni: TCurrencyEditFocus
      Tag = 99
      Left = 292
      Top = 65
      Enabled = False
      StyleFocused.Color = clInfoBk
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 64
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 548
      Top = 61
      Width = 58
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnAddProduto: TBitBtnLocked
      Left = 709
      Top = 60
      Width = 99
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 10
      OnClick = btnAddProdutoClick
    end
    object edtTipRec: TEditFocus
      Left = 84
      Top = 61
      Width = 21
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxGridProdutos: TcxGridCitel [3]
    Left = 0
    Top = 113
    Width = 839
    Height = 275
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridProdutosDBTableView: TcxGridDBTableViewCitel
      OnKeyUp = cxGridProdutosDBTableViewKeyUp
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      DataController.DataSource = dtsProdutos
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridProdutosDBTableViewPRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUTO'
        Options.Editing = False
        Width = 449
      end
      object cxGridProdutosDBTableViewSTR_TIPREC: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'STR_TIPREC'
        Options.Editing = False
        Width = 92
      end
      object cxGridProdutosDBTableViewIRC_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'IRC_QTDITE'
      end
      object cxGridProdutosDBTableViewIRC_UNITAR: TcxGridDBColumn
        Caption = 'Vlr.Unit.'
        DataBinding.FieldName = 'IRC_UNITAR'
        Options.Editing = False
        Width = 89
      end
      object cxGridProdutosDBTableViewIRC_TOTITE: TcxGridDBColumn
        Caption = 'Vlr. Total'
        DataBinding.FieldName = 'IRC_TOTITE'
        Options.Editing = False
        Width = 114
      end
    end
    object cxGridProdutosLevel1: TcxGridLevel
      GridView = cxGridProdutosDBTableView
    end
  end
  object pnlTotal: TPanel [4]
    Left = 0
    Top = 388
    Width = 839
    Height = 41
    Align = alBottom
    TabOrder = 4
    object lblVlrTotal: TLabel
      Left = 715
      Top = 13
      Width = 25
      Height = 14
      Caption = 'Total:'
    end
    object edtVltTot: TCurrencyEditFocus
      Tag = 99
      Left = 746
      Top = 10
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 79
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 584
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 208
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 112
    Top = 216
  end
  object cdsProdutos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 216
    object cdsProdutosIRC_CODITE: TStringField
      FieldName = 'IRC_CODITE'
    end
    object cdsProdutosITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
    end
    object cdsProdutosPRODUTO: TStringField
      DisplayWidth = 100
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsProdutosIRC_TIPREC: TStringField
      FieldName = 'IRC_TIPREC'
    end
    object cdsProdutosSTR_TIPREC: TStringField
      FieldName = 'STR_TIPREC'
    end
    object cdsProdutosIRC_QTDITE: TFloatField
      FieldName = 'IRC_QTDITE'
      OnChange = cdsProdutosIRC_QTDITEChange
    end
    object cdsProdutosIRC_UNITAR: TFloatField
      FieldName = 'IRC_UNITAR'
    end
    object cdsProdutosIRC_TOTITE: TFloatField
      FieldName = 'IRC_TOTITE'
    end
    object cdsProdutosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
end
