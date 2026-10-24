inherited frmCadConciliaAcumuloNetpoints: TfrmCadConciliaAcumuloNetpoints
  Width = 763
  Height = 384
  BorderIcons = [biSystemMenu]
  Caption = 'Concilia'#231#227'o de Acumulo Netpoints'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 763
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 311
    Width = 757
    ExplicitTop = 311
    ExplicitWidth = 757
    inherited FlwBotoes: TFlowPanel
      Width = 753
      TabOrder = 4
    end
    inherited btnSair: TBitBtnLocked
      Left = 674
      TabOrder = 3
      ExplicitLeft = 674
    end
    object btnConfirmar: TBitBtnLocked
      Left = 381
      Top = 3
      Width = 181
      Height = 21
      Caption = '[ F10 ] Confirmar'
      TabOrder = 2
      OnClick = btnConfirmarClick
    end
    object btnDesmarcarRegistros: TBitBtnLocked
      Left = 200
      Top = 3
      Width = 181
      Height = 21
      Caption = '[F9] Desmarcar Registros'
      TabOrder = 1
      OnClick = btnDesmarcarRegistrosClick
    end
    object btnMarcarRegistros: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 195
      Height = 21
      Caption = '[F8] Marcar Registros'
      TabOrder = 0
      OnClick = btnMarcarRegistrosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 339
    Width = 757
    ExplicitTop = 339
    ExplicitWidth = 757
    inherited pnlNomeForm: TPanel
      Left = 586
      ExplicitLeft = 586
    end
    inherited pnlInfo: TPanel
      Width = 586
      ExplicitWidth = 586
    end
  end
  object pnlGrid: TPanel [3]
    Left = 0
    Top = 0
    Width = 757
    Height = 281
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object cxGridCitel1: TcxGridCitel
      Left = 0
      Top = 41
      Width = 757
      Height = 240
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitel1TableView1: TcxGridDBTableViewCitel
        OnDblClick = cxGridCitel1TableView1DblClick
        OnKeyDown = cxGridCitel1TableView1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridCitel1TableView1CustomDrawCell
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitel1TableView1NPS_DTAPRO: TcxGridDBColumn
          Caption = 'Data Processamento'
          DataBinding.FieldName = 'NPS_DTAPRO'
          Width = 109
        end
        object cxGridCitel1TableView1NPS_CODITE: TcxGridDBColumn
          Caption = 'C'#243'digo do Item'
          DataBinding.FieldName = 'NPS_CODITE'
          Width = 94
        end
        object cxGridCitel1TableView1NPS_DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Produto'
          DataBinding.FieldName = 'NPS_DESITE'
          Width = 205
        end
        object cxGridCitel1TableView1NPS_FATNPS: TcxGridDBColumn
          Caption = 'Valor da Comiss'#227'o Netpoints'
          DataBinding.FieldName = 'NPS_FATNPS'
          Width = 164
        end
        object cxGridCitel1TableView1NPS_DTAARQ: TcxGridDBColumn
          Caption = 'Data do Arquivo'
          DataBinding.FieldName = 'NPS_DTAARQ'
          Width = 92
        end
        object cxGridCitel1TableView1NPS_CNPMAT: TcxGridDBColumn
          Caption = 'CNPJ Matriz'
          DataBinding.FieldName = 'NPS_CNPMAT'
          Width = 143
        end
        object cxGridCitel1TableView1NPS_CPFCLI: TcxGridDBColumn
          Caption = 'Cpf Cliente'
          DataBinding.FieldName = 'NPS_CPFCLI'
          Width = 124
        end
        object cxGridCitel1TableView1NPS_TIPTRA: TcxGridDBColumn
          Caption = 'Tipo de Transa'#231#227'o'
          DataBinding.FieldName = 'NPS_TIPTRA'
          Width = 112
        end
        object cxGridCitel1TableView1NPS_CNPFIL: TcxGridDBColumn
          Caption = 'CNPJ Filial'
          DataBinding.FieldName = 'NPS_CNPFIL'
          Width = 128
        end
        object cxGridCitel1TableView1NPS_NUMDOC: TcxGridDBColumn
          Caption = 'N'#250'mero do Documento'
          DataBinding.FieldName = 'NPS_NUMDOC'
          Width = 120
        end
        object cxGridCitel1TableView1NPS_PEDCMP: TcxGridDBColumn
          Caption = 'Pedido de Compra'
          DataBinding.FieldName = 'NPS_PEDCMP'
          Width = 100
        end
        object cxGridCitel1TableView1NPS_VALPRO: TcxGridDBColumn
          Caption = 'Valor do Produto'
          DataBinding.FieldName = 'NPS_VALPRO'
          Width = 96
        end
        object cxGridCitel1TableView1NPS_DTACMP: TcxGridDBColumn
          Caption = 'Data da Compra'
          DataBinding.FieldName = 'NPS_DTACMP'
          Width = 90
        end
        object cxGridCitel1TableView1NPS_QTDNPS: TcxGridDBColumn
          Caption = 'Quantidade de Pontos Creditados'
          DataBinding.FieldName = 'NPS_QTDNPS'
          Width = 75
        end
        object cxGridCitel1TableView1NPS_REGVAR: TcxGridDBColumn
          Caption = 'Valor da Pontua'#231#227'o no Varejo'
          DataBinding.FieldName = 'NPS_REGVAR'
        end
        object cxGridCitel1TableView1NPS_REGCAR: TcxGridDBColumn
          Caption = 'Valor da Pontua'#231#227'o no Cart'#227'o'
          DataBinding.FieldName = 'NPS_REGCAR'
        end
        object cxGridCitel1TableView1NPS_CODCON: TcxGridDBColumn
          Caption = 'C'#243'digo da Concilia'#231#227'o'
          DataBinding.FieldName = 'NPS_CODCON'
        end
        object cxGridCitel1TableView1NPS_NOMARQ: TcxGridDBColumn
          Caption = 'Nome do Arquivo'
          DataBinding.FieldName = 'NPS_NOMARQ'
        end
        object cxGridCitel1TableView1MARCADO: TcxGridDBColumn
          Caption = 'Marcado'
          DataBinding.FieldName = 'MARCADO'
        end
      end
      object cxGridCitel1Level1: TcxGridLevel
        GridView = cxGridCitel1TableView1
      end
    end
    object pnlFiltro: TPanel
      Left = 0
      Top = 0
      Width = 757
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label5: TLabel
        Left = 19
        Top = 19
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Inicial:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 171
        Top = 19
        Width = 50
        Height = 14
        Caption = 'Data Final:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 312
        Top = 16
        Width = 231
        Height = 15
        Caption = '(DATA DE PROCESSAMENTO NETPOINTS)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 77
        Top = 11
        Width = 75
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 223
        Top = 11
        Width = 78
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object btnCarregar: TBitBtnLocked
        Left = 607
        Top = 12
        Width = 136
        Height = 21
        Caption = 'Carregar Dados'
        TabOrder = 2
        OnClick = btnCarregarClick
      end
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 281
    Width = 757
    Height = 30
    Align = alBottom
    TabOrder = 4
    object Label2: TLabel
      Left = 494
      Top = 8
      Width = 152
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total de Comiss'#227'o Selecionado:'
    end
    object edtTotSel: TEditFocus
      Left = 648
      Top = 4
      Width = 95
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 160
  end
  object dtsDados: TDataSource
    Left = 480
    Top = 72
  end
end
