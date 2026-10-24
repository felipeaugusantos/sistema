inherited frmGerarOrdemdeProducaoPorArquivoDeImportacao: TfrmGerarOrdemdeProducaoPorArquivoDeImportacao
  Width = 1024
  Height = 669
  Caption = 'Importar arquivo para Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1024
  ExplicitHeight = 669
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel [0]
    Left = 0
    Top = 101
    Width = 1018
    Height = 455
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 5
    object cxDados: TcxGrid
      Left = 1
      Top = 1
      Width = 1016
      Height = 453
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxDadosDB: TcxGridDBTableView
        OnDblClick = cxDadosDBDblClick
        OnKeyDown = cxDadosDBKeyDown
        OnKeyPress = cxDadosDBKeyPress
        Navigator.Buttons.CustomButtons = <>
        OnCanFocusRecord = cxDadosDBCanFocusRecord
        OnCellClick = cxDadosDBCellClick
        OnCustomDrawCell = cxDadosDBCustomDrawCell
        OnEditKeyPress = cxDadosDBEditKeyPress
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Filter.Active = True
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxDadosVLRTOT
            DisplayText = 'Total de Pedidos'
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        object cxDadosDBColumn1: TcxGridDBColumn
          Caption = 'Arqv. C'#243'd. Fabrica'
          DataBinding.FieldName = 'ARQ_CODFAB'
          Options.Editing = False
          Width = 85
        end
        object cxDadosDBColumn2: TcxGridDBColumn
          Caption = 'Arqv. Desc. Item'
          DataBinding.FieldName = 'ARQ_DESITE'
          Options.Editing = False
          Width = 166
        end
        object cxDadosCODITE: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Width = 58
        end
        object cxDadosDESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 208
        end
        object cxDadosSIGUNI: TcxGridDBColumn
          Caption = 'UN'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Width = 24
        end
        object cxDadosSALDOS: TcxGridDBColumn
          Caption = 'Est. Fisico'
          DataBinding.FieldName = 'SALDOS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 58
        end
        object cxDadosSALDIS: TcxGridDBColumn
          Caption = 'Est. Dispon'#237'vel'
          DataBinding.FieldName = 'SALDIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 83
        end
        object cxDadosPEDCOM: TcxGridDBColumn
          Caption = 'Ped. Compra'
          DataBinding.FieldName = 'PEDCOM'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxDadosQTDIMP: TcxGridDBColumn
          Caption = 'Qtd. Importada'
          DataBinding.FieldName = 'QTDIMP'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 80
        end
        object cxDadosQTDSUG: TcxGridDBColumn
          Caption = 'Qtd. Sugest.'
          DataBinding.FieldName = 'QTDSUG'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Width = 70
        end
        object cxDadosVLRUNI: TcxGridDBColumn
          Caption = 'Vlr. Unit'#225'rio'
          DataBinding.FieldName = 'VLRUNI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxDadosVLRTOT: TcxGridDBColumn
          Caption = 'Vlr. Total'
          DataBinding.FieldName = 'VLRTOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxDadosCODFOR: TcxGridDBColumn
          Caption = 'C'#243'd. Fornec.'
          DataBinding.FieldName = 'CODFOR'
          Options.Editing = False
          Width = 69
        end
        object cxDadosNOMFOR: TcxGridDBColumn
          Caption = 'Nome Fornecedor'
          DataBinding.FieldName = 'NOMFOR'
          Options.Editing = False
          Width = 149
        end
        object cxDadosIDENTIFICADO: TcxGridDBColumn
          DataBinding.FieldName = 'IDENTIFICADO'
          Visible = False
        end
        object cxDadosMARCADO: TcxGridDBColumn
          DataBinding.FieldName = 'MARCADO'
          Visible = False
        end
        object cxDadosGRUPO: TcxGridDBColumn
          Caption = 'Grupo'
          DataBinding.FieldName = 'GRUPO'
          Visible = False
          GroupIndex = 0
        end
      end
      object cxDadosLvl: TcxGridLevel
        GridView = cxDadosDB
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 596
    Width = 1018
    TabOrder = 2
    ExplicitTop = 596
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnGerarDocumentos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 187
        Height = 22
        Caption = '[ F1 ] Gerar Ordem de Produ'#231#227'o'
        TabOrder = 0
        OnClick = btnGerarDocumentosClick
      end
      object btnApagarProduto: TBitBtnLocked
        Left = 187
        Top = 0
        Width = 106
        Height = 22
        Caption = '[ DEL ] Apagar'
        TabOrder = 1
        OnClick = btnApagarProdutoClick
      end
      object btnApagarProdutos: TBitBtnLocked
        Left = 293
        Top = 0
        Width = 355
        Height = 22
        Caption = '[ F2 ] Apagar produtos com quantidade maior que saldo dispon'#237'vel'
        TabOrder = 2
        OnClick = btnApagarProdutosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
  end
  inherited pnlStatus: TPanel
    Top = 624
    Width = 1018
    TabOrder = 3
    ExplicitTop = 624
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 712
      Width = 306
      ExplicitLeft = 712
      ExplicitWidth = 306
    end
    inherited pnlInfo: TPanel
      Width = 712
      ExplicitWidth = 712
      object pgbProgresso: TcxProgressBar
        Left = 2
        Top = 2
        Align = alClient
        TabOrder = 0
        Visible = False
        Width = 708
      end
    end
  end
  object pnHeader: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 73
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 93
      Height = 14
      Caption = 'Path do arquivo txt:'
    end
    object Label6: TLabel
      Left = 8
      Top = 32
      Width = 87
      Height = 14
      Caption = 'Numero do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEspecie: TLabel
      Left = 100
      Top = 32
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblSerie: TLabel
      Left = 141
      Top = 32
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProjeto: TLabel
      Left = 292
      Top = 50
      Width = 3
      Height = 14
    end
    object edtPath: TFilenameEditFocus
      Tag = 99
      Left = 102
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000004020FF406040FF406040FF4060
            40FF004020FF0000000000000000000000000000000000000000806040FFC080
            60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
            80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
            FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
            60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
            FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
            60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
            FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
            60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
            60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
            80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
            A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
            FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
            80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
            80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
            80FFC0A080FF808060FF000000000000000000000000}
          Kind = bkGlyph
        end>
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Width = 551
    end
    object btnCarregar: TBitBtnLocked
      Tag = 99
      Left = 189
      Top = 45
      Width = 97
      Height = 24
      Caption = '&Carregar'
      TabOrder = 4
      OnClick = btnCarregarClick
    end
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 8
      Top = 46
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtDocumentoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 100
      Top = 46
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 141
      Top = 46
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 556
    Width = 1018
    Height = 40
    Align = alBottom
    ParentColor = True
    TabOrder = 4
    object Shape1: TShape
      Left = 8
      Top = 5
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label2: TLabel
      Left = 28
      Top = 5
      Width = 102
      Height = 14
      Caption = 'Itens n'#227'o encontrado'
    end
    object Label5: TLabel
      Left = 276
      Top = 5
      Width = 503
      Height = 14
      Caption = 
        'Itens Encontrado , mas o c'#243'digo de f'#225'brica pertence a fornecedor' +
        'es distintos - Duplo Clique para alterar.'
    end
    object Shape3: TShape
      Left = 256
      Top = 5
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
  end
  object pnlProdutoAcabado: TPanel [5]
    Left = 0
    Top = 73
    Width = 1018
    Height = 28
    Align = alTop
    Enabled = False
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 7
      Width = 89
      Height = 14
      Caption = 'Produto Acabado: '
    end
    object edtCodIte: TEditFocus
      Left = 97
      Top = 3
      Width = 67
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object edtDesIte: TEditFocus
      Left = 165
      Top = 3
      Width = 504
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 644
    Top = 65528
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 824
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 876
    Top = 0
  end
  object dtsDados: TDataSource
    Left = 600
    Top = 267
  end
  object dtsDuplicados: TDataSource
    Left = 500
    Top = 320
  end
end
