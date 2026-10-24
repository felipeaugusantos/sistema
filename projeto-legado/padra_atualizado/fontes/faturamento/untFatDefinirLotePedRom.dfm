inherited frmDefinirLotePedRom: TfrmDefinirLotePedRom
  Width = 1113
  Height = 650
  BorderStyle = bsSingle
  Caption = 'WMS - Separa'#231#227'o por Lote de Pedidos para Romaneio'
  OnDestroy = FormDestroy
  ExplicitWidth = 1113
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 579
    Width = 1107
    ExplicitTop = 579
    ExplicitWidth = 1107
    inherited FlwBotoes: TFlowPanel
      Width = 1103
      ExplicitWidth = 1103
      inherited btnConfirma: TBitBtnLocked
        Width = 117
        Caption = '[F10] &Confirma'
        ModalResult = 0
        ExplicitWidth = 117
      end
      object btnAtualiza: TBitBtnLocked
        Left = 117
        Top = 0
        Width = 156
        Height = 22
        Caption = '[F5] Atualizar lista de lotes'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnAtualizaClick
      end
      object btnCadLot: TBitBtnLocked
        Left = 273
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F8] Cad. Lotes'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnCadLotClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1024
      ExplicitLeft = 1024
    end
  end
  inherited pnlStatus: TPanel
    Top = 605
    Width = 1107
    ExplicitTop = 605
    ExplicitWidth = 1107
    inherited pnlNomeForm: TPanel
      Left = 936
      ExplicitLeft = 936
    end
    inherited pnlInfo: TPanel
      Width = 936
      ExplicitWidth = 936
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1107
    Height = 41
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 1099
      Height = 36
      Align = alClient
      Caption = 
        'Aten'#231#227'o! N'#227'o foi poss'#237'vel definir de forma autom'#225'tica o lote par' +
        'a o(s) item(ns) listado(s) abaixo. Por conta disto, ser'#225' precido' +
        ' realizar a defini'#231#227'o de forma manual.'
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 785
      ExplicitHeight = 14
    end
  end
  object grdProduto: TcxGridCitel [3]
    Left = 0
    Top = 41
    Width = 1107
    Height = 344
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdProdutoTv: TcxGridDBTableViewCitel
      OnKeyDown = grdProdutoTvKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDefineLote
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdProdutoCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo Item'
        DataBinding.FieldName = 'CODITE'
        Width = 100
      end
      object grdProdutoDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 200
      end
      object grdProdutoDOCS: TcxGridDBColumn
        Caption = 'Pedidos(s) Envolvido(s)'
        DataBinding.FieldName = 'NUMDOC'
        Width = 300
      end
      object grdProdutoQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 100
      end
      object grdProdutoNUMLOT: TcxGridDBColumn
        Caption = 'Lote(s) Selecionado(s)'
        DataBinding.FieldName = 'NUMLOT'
        OnGetDisplayText = grdProdutoNUMLOTGetDisplayText
        Width = 300
      end
      object grdProdutoAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTINC'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object grdProdutoLv: TcxGridLevel
      GridView = grdProdutoTv
    end
  end
  object dbgLotes: TDBGridCitel [4]
    Left = 0
    Top = 408
    Width = 1107
    Height = 171
    Align = alBottom
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgLotesKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMLOT'
        Title.Caption = 'Lote'
        Width = 212
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCFIS'
        Title.Caption = 'Localiza'#231#227'o F'#237'sica'
        Width = 142
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PICKIN'
        Title.Alignment = taCenter
        Title.Caption = 'Picking?'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAVAL'
        Title.Alignment = taCenter
        Title.Caption = 'Data Validade'
        Width = 86
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 123
        Visible = True
      end>
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 385
    Width = 1107
    Height = 23
    Align = alBottom
    TabOrder = 4
    object Label2: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 1099
      Height = 18
      Align = alClient
      Caption = 'Defini'#231#227'o de Lotes '
      ExplicitWidth = 93
      ExplicitHeight = 14
    end
  end
  object cdsDefineLote: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 204
    object cdsDefineLoteCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsDefineLoteDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDefineLoteQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsDefineLoteNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 1000
    end
    object cdsDefineLoteNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsDefineLoteCODSEP: TStringField
      FieldName = 'CODSEP'
      Size = 3
    end
    object cdsDefineLoteSEQSEP: TIntegerField
      FieldName = 'SEQSEP'
    end
    object cdsDefineLoteAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object dtsDefineLote: TDataSource
    DataSet = cdsDefineLote
    Left = 448
    Top = 204
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 424
    Top = 300
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 392
    Top = 300
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 360
    Top = 300
  end
  object cdsLotesSel: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 208
    object cdsLotesSelCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsLotesSelNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsLotesSelQTDLOT: TFloatField
      FieldName = 'QTDLOT'
    end
    object cdsLotesSelAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
end
