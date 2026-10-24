inherited frmImpressaoCPList: TfrmImpressaoCPList
  Width = 815
  Height = 307
  BorderIcons = [biSystemMenu]
  Caption = 'Impress'#227'o de Controle de Pagamento'
  Position = poScreenCenter
  ExplicitWidth = 815
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 236
    Width = 809
    Height = 26
    TabOrder = 1
    ExplicitTop = 236
    ExplicitWidth = 809
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 727
      Height = 22
      TabOrder = 1
      ExplicitWidth = 727
      ExplicitHeight = 22
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F5 ] Inicia Busca'
        Spacing = 2
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 119
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        Spacing = 2
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 238
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        Spacing = 2
        TabOrder = 2
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcaTodas: TBitBtnLocked
        Left = 357
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        Spacing = 2
        TabOrder = 3
        OnClick = btnDesmarcaTodasClick
      end
      object BtnSelecionadas: TBitBtnLocked
        Left = 476
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F9 ] Selecionadas'
        Spacing = 2
        TabOrder = 4
        OnClick = BtnSelecionadasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 595
        Top = 0
        Width = 119
        Height = 21
        Caption = '[ F10 ] Confirma'
        Spacing = 2
        TabOrder = 5
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 729
      Top = 2
      Width = 78
      Align = alRight
      Spacing = 2
      TabOrder = 0
      ExplicitLeft = 729
      ExplicitTop = 2
      ExplicitWidth = 78
    end
  end
  inherited pnlStatus: TPanel
    Top = 262
    Width = 809
    TabOrder = 2
    ExplicitTop = 262
    ExplicitWidth = 809
    inherited pnlNomeForm: TPanel
      Left = 638
      ExplicitLeft = 638
    end
    inherited pnlInfo: TPanel
      Width = 638
      ExplicitWidth = 638
    end
  end
  object cxGridImpressao: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 809
    Height = 236
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableTitulos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridDBTableTitulosCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsCustomize.ColumnSorting = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridDBTableTitulosDUPLIC: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'DUPLIC'
        Options.Editing = False
        Width = 113
      end
      object cxGridDBTableTitulosCODEMP: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'CTP_CODEMP'
        Options.Editing = False
        Width = 38
      end
      object cxGridDBTableTitulosNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 169
      end
      object cxGridDBTableTitulosNOMPOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'NOMPOR'
        Options.Editing = False
        Width = 175
      end
      object cxGridDBTableTitulosESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 30
      end
      object cxGridDBTableTitulosDTACAD: TcxGridDBColumn
        Caption = 'Dt. Cadastro'
        DataBinding.FieldName = 'DTACAD'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxGridDBTableTitulosDTAVEN: TcxGridDBColumn
        Caption = 'Dt. Vencimento'
        DataBinding.FieldName = 'CTP_DTAVEN'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 84
      end
      object cxGridDBTableTitulosVALORI: TcxGridDBColumn
        Caption = 'Valor Bruto'
        DataBinding.FieldName = 'VALORI'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 102
      end
      object cxGridDBTableTitulosTOTDUP: TcxGridDBColumn
        Caption = 'Valor L'#237'quido'
        DataBinding.FieldName = 'TOTDUP'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 106
      end
      object cxGridDBTableTitulosMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'CTP_MARDES'
        Visible = False
      end
    end
    object cxGridLevel2: TcxGridLevel
      GridView = cxGridDBTableTitulos
    end
  end
end
