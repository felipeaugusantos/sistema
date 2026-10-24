inherited frmProdutoCadastroRapidoLoteRastreamento: TfrmProdutoCadastroRapidoLoteRastreamento
  Width = 594
  Height = 654
  Caption = 'Produto - Cadastro R'#225'pido de Lote de Rastreamento'
  ExplicitWidth = 594
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 583
    Width = 588
    TabOrder = 3
    ExplicitTop = 379
    ExplicitWidth = 894
    inherited FlwBotoes: TFlowPanel
      Width = 507
      inherited btnConfirma: TBitBtnLocked
        Width = 142
        Align = alLeft
        Caption = 'Confirma [F10]'
        ModalResult = 0
        ExplicitWidth = 142
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 509
      Top = 2
      Align = alRight
      ExplicitLeft = 815
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 609
    Width = 588
    TabOrder = 4
    ExplicitTop = 405
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 350
      Width = 238
      ExplicitLeft = 656
      ExplicitWidth = 238
    end
    inherited pnlInfo: TPanel
      Width = 350
      ExplicitWidth = 656
    end
  end
  object cxgLotRas: TcxGridCitel [3]
    Left = 0
    Top = 128
    Width = 588
    Height = 434
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = 309
    ExplicitTop = 145
    ExplicitHeight = 503
    object cxgLotRasTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgLotRasTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgLotRasTableViewNUMLOT: TcxGridDBColumn
        Caption = 'Lote Rastreamento'
        DataBinding.FieldName = 'LOT_NUMLOT'
        Width = 391
      end
    end
    object cxgLotRasLevel: TcxGridLevel
      GridView = cxgLotRasTableView
    end
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 562
    Width = 588
    Height = 21
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 359
    ExplicitWidth = 894
    DesignSize = (
      588
      21)
    object lblLegendaDelete: TLabel
      Left = 434
      Top = 3
      Width = 144
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '[ DEL ] - Deletar Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 740
    end
  end
  object pnlLoteRastreamento: TPanel [5]
    Left = 0
    Top = 69
    Width = 588
    Height = 59
    Align = alTop
    TabOrder = 1
    object Label11: TLabel
      Left = 7
      Top = 5
      Width = 91
      Height = 14
      Caption = 'Lote Rastreamento'
    end
    object edtLoteRastreamento: TEditFocus
      Tag = 99
      Left = 7
      Top = 22
      Width = 269
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 30
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDadosItem: TPanel [6]
    Left = 0
    Top = 0
    Width = 588
    Height = 69
    Align = alTop
    TabOrder = 0
    object Label7: TLabel
      Left = 43
      Top = 14
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object lbl2: TLabel
      Left = 9
      Top = 41
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 69
      Top = 11
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 127
      Top = 11
      Width = 438
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 69
      Top = 36
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 127
      Top = 36
      Width = 438
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 340
    Top = 212
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 284
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 372
    Top = 156
  end
end
