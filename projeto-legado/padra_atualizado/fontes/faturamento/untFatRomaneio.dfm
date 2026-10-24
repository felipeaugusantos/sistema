inherited frmFatRomaneio: TfrmFatRomaneio
  Left = 308
  Top = 178
  Width = 1290
  Height = 863
  Caption = 'Romaneio'
  Constraints.MinHeight = 584
  Constraints.MinWidth = 800
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1290
  ExplicitHeight = 863
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 734
    Width = 1284
    Height = 84
    ExplicitTop = 734
    ExplicitWidth = 1284
    ExplicitHeight = 84
    inherited FlwBotoes: TFlowPanel
      Top = 16
      Width = 1280
      Height = 66
      Color = clGray
      ParentBackground = False
      ExplicitTop = 16
      ExplicitWidth = 1280
      ExplicitHeight = 66
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnEntrPendentes: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F9] Entregas Pendentes'
        TabOrder = 1
        OnClick = btnEntrPendentesClick
      end
      object btnEntrRealizadas: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F8] Entregas Realizadas'
        TabOrder = 2
        OnClick = btnEntrRealizadasClick
      end
      object btnReimprimeDocumento: TBitBtnLocked
        Left = 375
        Top = 0
        Width = 101
        Height = 22
        Caption = '[F7] Imprime Doc.'
        TabOrder = 3
        Visible = False
        OnClick = btnReimprimeDocumentoClick
      end
      object btnReimprimeRomaneio: TBitBtnLocked
        Left = 476
        Top = 0
        Width = 108
        Height = 22
        Caption = '[F6] Imprime Rom.'
        TabOrder = 4
        Visible = False
        OnClick = btnReimprimeRomaneioClick
      end
      object btnPreviaRomaneio: TBitBtnLocked
        Left = 584
        Top = 0
        Width = 108
        Height = 22
        Caption = '[Alt+F9] Pr'#233'via Rom.'
        TabOrder = 5
        Visible = False
        OnClick = btnPreviaRomaneioClick
      end
      object btnVisualizarItensDocumentos: TBitBtnLocked
        Left = 692
        Top = 0
        Width = 184
        Height = 22
        Caption = '[F5] Visualizar itens do documento'
        TabOrder = 6
        OnClick = btnVisualizarItensDocumentosClick
      end
      object btnOutEnt: TBitBtnLocked
        Left = 876
        Top = 0
        Width = 125
        Height = 22
        Caption = '[F11] Outras Entregas'
        TabOrder = 7
        OnClick = btnOutEntClick
      end
      object btnDocumentosExcluidos: TBitBtnLocked
        Left = 1001
        Top = 0
        Width = 125
        Height = 22
        Caption = '&Documentos Exclu'#237'dos'
        TabOrder = 8
        OnClick = btnDocumentosExcluidosClick
      end
      object btnAcoEnt: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 180
        Height = 22
        Caption = '[F12] Acompanhamento da Entrega'
        TabOrder = 9
        OnClick = btnAcoEntClick
      end
      object btnFeriados: TBitBtnLocked
        Left = 180
        Top = 22
        Width = 158
        Height = 22
        Caption = '[ALT + F1] Feriados Municipais'
        TabOrder = 10
        OnClick = btnFeriadosClick
      end
      object btnPadrao: TBitBtnLocked
        Left = 338
        Top = 22
        Width = 138
        Height = 22
        Caption = '&Restaurar Grid Padr'#227'o'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 11
        OnClick = btnPadraoClick
      end
      object btnLimpaSeparacao: TBitBtnLocked
        Left = 476
        Top = 22
        Width = 97
        Height = 22
        Caption = '&Limpar Separa'#231#227'o'
        TabOrder = 12
        Visible = False
        OnClick = btnLimpaSeparacaoClick
      end
      object btnNovoVeiculo: TBitBtnLocked
        Left = 573
        Top = 22
        Width = 125
        Height = 22
        Caption = '[F2] Criar novo Ve'#237'culo'
        TabOrder = 13
        OnClick = btnNovoVeiculoClick
      end
      object btnPedPendentes: TBitBtnLocked
        Left = 698
        Top = 22
        Width = 165
        Height = 22
        Caption = '[Alt + F2] PD Venda Pendentes'
        TabOrder = 14
        OnClick = btnPedPendentesClick
      end
      object BtnCfgColRomaneio: TBitBtnLocked
        Left = 863
        Top = 22
        Width = 76
        Height = 22
        Caption = 'Configurar'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 15
        OnClick = BtnCfgColRomaneioClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 939
        Top = 22
        Width = 134
        Height = 22
        Caption = '[Ctrl + F3] Marca Todos'
        TabOrder = 16
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 1073
        Top = 22
        Width = 148
        Height = 22
        Caption = '[Ctrl + F4] Desmarca Todos'
        TabOrder = 17
        OnClick = btnDesmarcaTodosClick
      end
      object btnManEnd: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 197
        Height = 22
        Caption = '[ALT + F5] Manuten'#231#227'o de Endere'#231'os'
        TabOrder = 18
        OnClick = btnManEndClick
      end
      object btnLogRastreamento: TBitBtnLocked
        Left = 197
        Top = 44
        Width = 178
        Height = 22
        Caption = '[ALT + F8] Log de Rastreamento'
        TabOrder = 19
        OnClick = btnLogRastreamentoClick
      end
      object btnResumoAberto: TBitBtnLocked
        Left = 375
        Top = 44
        Width = 247
        Height = 22
        Caption = '[ALT + F6] Resumo dos Romaneios em Aberto'
        TabOrder = 20
        Visible = False
        OnClick = btnResumoAbertoClick
      end
      object btnManutRomaneio: TBitBtnLocked
        Left = 622
        Top = 44
        Width = 190
        Height = 22
        Caption = '[ALT + F7] Manuten'#231#227'o de Romaneio'
        TabOrder = 21
        Visible = False
        OnClick = btnManutRomaneioClick
      end
      object btnManutEntrega: TBitBtnLocked
        Left = 812
        Top = 44
        Width = 179
        Height = 22
        Caption = '[ALT + E] Manuten'#231#227'o da Entrega'
        TabOrder = 22
        Visible = False
        OnClick = btnManutEntregaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1216
      Top = 60
      Width = 58
      ExplicitLeft = 1216
      ExplicitTop = 60
      ExplicitWidth = 58
    end
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 1280
      Height = 14
      Align = alTop
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      ShowCaption = False
      TabOrder = 2
      object lblMarca: TLabel
        Left = 3
        Top = 0
        Width = 207
        Height = 14
        Caption = '[ENTER] Marca / Desmarca Documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblMarcaParc: TLabel
        Left = 216
        Top = 0
        Width = 228
        Height = 14
        Caption = '[ESPA'#199'O] Marca Documento Parcialmente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 818
    Width = 1284
    TabOrder = 2
    ExplicitTop = 818
    ExplicitWidth = 1284
    inherited pnlNomeForm: TPanel
      Left = 1113
      ExplicitLeft = 1113
    end
    inherited pnlInfo: TPanel
      Width = 1113
      ExplicitWidth = 1113
      object shpMultSel: TShape
        Left = 1095
        Top = 2
        Width = 16
        Height = 12
        Hint = 'Os filtros possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 310
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 1256
    Height = 734
    Align = alClient
    TabOrder = 1
    object dbgDocumentos: TcxGrid
      Left = 1
      Top = 356
      Width = 1254
      Height = 189
      Align = alClient
      PopupMenu = popOpcoes
      TabOrder = 3
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      LookAndFeel.ScrollbarMode = sbmClassic
      LookAndFeel.SkinName = ''
      object dbgDocumentosDBView: TcxGridDBTableView
        DragMode = dmAutomatic
        OnDblClick = dbgDocumentosDBViewDblClick
        OnKeyDown = dbgDocumentosDBViewKeyDown
        OnMouseDown = dbgDocumentosDBViewMouseDown
        OnStartDrag = dbgDocumentosDBViewStartDrag
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = dbgDocumentosDBViewCellClick
        OnCustomDrawCell = dbgDocumentosDBViewCustomDrawCell
        OnFocusedRecordChanged = dbgDocumentosDBViewFocusedRecordChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.DragDropText = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GridLines = glVertical
        OptionsView.GroupByBox = False
        object dbgDocumentosGER_VEICUL: TcxGridDBColumn
          Caption = 'N'#186' Ve'#237'culo'
          DataBinding.FieldName = 'GER_VEICUL'
          Options.Editing = False
        end
        object dbgDocumentosGER_RETROM: TcxGridDBColumn
          Caption = 'Doc.ret.Rom.'
          DataBinding.FieldName = 'GER_RETROM'
        end
        object dbgDocumentosGER_ROMIMP: TcxGridDBColumn
          Caption = 'Imp?'
          DataBinding.FieldName = 'GER_ROMIMP'
          Width = 29
        end
        object dbgDocumentosGER_ENTSAI: TcxGridDBColumn
          Caption = 'E/S'
          DataBinding.FieldName = 'GER_ENTSAI'
          Width = 24
        end
        object dbgDocumentosGER_DTAENT: TcxGridDBColumn
          Caption = 'Data Documento'
          DataBinding.FieldName = 'GER_DTAENT'
          Width = 105
        end
        object dbgDocumentosGER_HORENT: TcxGridDBColumn
          Caption = 'Hora'
          DataBinding.FieldName = 'GER_HORENT'
          Width = 49
        end
        object dbgDocumentosGER_DTENTR: TcxGridDBColumn
          Caption = 'Data Entrega'
          DataBinding.FieldName = 'GER_DTENTR'
          Width = 80
        end
        object dbgDocumentosTURENT: TcxGridDBColumn
          Caption = 'Turno'
          DataBinding.FieldName = 'TURENT'
          Width = 75
        end
        object dbgDocumentosGER_VOLUME: TcxGridDBColumn
          Caption = 'Volume Doc.'
          DataBinding.FieldName = 'GER_VOLUME'
          Width = 80
        end
        object dbgDocumentosGER_VOLBIP: TcxGridDBColumn
          Caption = 'Volume Bipado'
          DataBinding.FieldName = 'GER_VOLBIP'
          Width = 80
        end
        object dbgDocumentosGER_PEDVEN: TcxGridDBColumn
          Caption = 'Pedido(s)'
          DataBinding.FieldName = 'GER_PEDVEN'
          Width = 95
        end
        object dbgDocumentosGER_NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'GER_NUMDOC'
          Width = 102
        end
        object dbgDocumentosGER_CODEMP: TcxGridDBColumn
          Caption = 'Emp. Fat.'
          DataBinding.FieldName = 'GER_CODEMP'
          Width = 56
        end
        object dbgDocumentosDET_EMPORI: TcxGridDBColumn
          Caption = 'Emp. Ori.'
          DataBinding.FieldName = 'DET_EMPORI'
          Options.AutoWidthSizable = False
          Width = 70
        end
        object dbgDocumentosTIPPED: TcxGridDBColumn
          Caption = 'Esp'#233'cie.Fat.'
          DataBinding.FieldName = 'TIPPED'
          Width = 70
        end
        object dbgDocumentosPOSOBS: TcxGridDBColumn
          Caption = 'Obs?'
          DataBinding.FieldName = 'POSOBS'
          Width = 34
        end
        object dbgDocumentosGER_CODCLI: TcxGridDBColumn
          Caption = 'C'#243'd.Cliente'
          DataBinding.FieldName = 'GER_CODCLI'
          Width = 62
        end
        object dbgDocumentosGER_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente/Descri'#231#227'o Entr.'
          DataBinding.FieldName = 'GER_NOMCLI'
          Width = 115
        end
        object dbgDocumentosGER_NOMCID: TcxGridDBColumn
          Caption = 'Cidade'
          DataBinding.FieldName = 'GER_NOMCID'
          Width = 95
        end
        object dbgDocumentosGER_ESTADO: TcxGridDBColumn
          Caption = 'UF'
          DataBinding.FieldName = 'GER_ESTADO'
          Width = 40
        end
        object dbgDocumentosGER_BAIRRO: TcxGridDBColumn
          Caption = 'Bairro'
          DataBinding.FieldName = 'GER_BAIRRO'
          Width = 88
        end
        object dbgDocumentosGER_ENDCON: TcxGridDBColumn
          Caption = 'End.Entrega'
          DataBinding.FieldName = 'GER_ENDCON'
          Width = 80
        end
        object dbgDocumentosGER_CEPCON: TcxGridDBColumn
          Caption = 'CEP Entrega'
          DataBinding.FieldName = 'GER_CEPCON'
          OnGetDataText = dbgDocumentosGER_CEPCONGetDataText
          Width = 75
        end
        object dbgDocumentosGER_REFCON: TcxGridDBColumn
          Caption = 'Refer'#234'ncia Entrega'
          DataBinding.FieldName = 'GER_REFCON'
        end
        object dbgDocumentosREGIAO: TcxGridDBColumn
          Caption = 'Regi'#227'o'
          DataBinding.FieldName = 'REGIAO'
        end
        object dbgDocumentosSUBREGIAO: TcxGridDBColumn
          Caption = 'Sub Regi'#227'o'
          DataBinding.FieldName = 'SUBREGIAO'
        end
        object dbgDocumentosGER_CODVEN: TcxGridDBColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'GER_CODVEN'
          Width = 35
        end
        object dbgDocumentosGER_NOMVEN: TcxGridDBColumn
          Caption = 'Nome Vend.'
          DataBinding.FieldName = 'GER_NOMVEN'
          Options.Editing = False
        end
        object dbgDocumentosGER_PESBRU: TcxGridDBColumn
          Caption = 'Peso Total Doc.'
          DataBinding.FieldName = 'GER_PESBRU'
          HeaderAlignmentHorz = taRightJustify
          Width = 85
        end
        object dbgDocumentosGER_FORPAG: TcxGridDBColumn
          Caption = 'Forma de Pagamento'
          DataBinding.FieldName = 'GER_FORPAG'
          Width = 120
        end
        object dbgDocumentosGER_TRANSP: TcxGridDBColumn
          Caption = 'Transportadora'
          DataBinding.FieldName = 'GER_TRANSP'
          Width = 79
        end
        object dbgDocumentosGER_TIPFRE: TcxGridDBColumn
          Caption = 'Tipo de Frete'
          DataBinding.FieldName = 'GER_TIPFRE'
          OnGetDataText = dbgDocumentosGER_TIPFREGetDataText
        end
        object dbgDocumentosGER_VLRCON: TcxGridDBColumn
          Caption = 'Valor Documento'
          DataBinding.FieldName = 'GER_VLRCON'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 75
        end
        object dbgDocumentosGER_VLRPRO: TcxGridDBColumn
          Caption = 'Valor Produtos'
          DataBinding.FieldName = 'GER_VLRPRO'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 75
        end
        object dbgDocumentosENTURG: TcxGridDBColumn
          Caption = 'Urgente'
          DataBinding.FieldName = 'ENTURG'
          Width = 45
        end
        object dbgDocumentosGER_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'GER_MARDES'
          Visible = False
          VisibleForCustomization = False
        end
        object dbgDocumentosGER_PRVIMP: TcxGridDBColumn
          DataBinding.FieldName = 'GER_PRVIMP'
          Visible = False
          VisibleForCustomization = False
        end
        object dbgDocumentosGER_ORIDOC: TcxGridDBColumn
          DataBinding.FieldName = 'GER_ORIDOC'
          Visible = False
          VisibleForCustomization = False
        end
        object dbgDocumentosGER_NOMTBL: TcxGridDBColumn
          DataBinding.FieldName = 'GER_NOMTBL'
          Visible = False
        end
        object dbgDocumentosGER_ESPDOC: TcxGridDBColumn
          DataBinding.FieldName = 'GER_ESPDOC'
          Visible = False
        end
        object dbgDocumentosGER_ORIDEV: TcxGridDBColumn
          DataBinding.FieldName = 'GER_ORIDEV'
          Visible = False
          VisibleForCustomization = False
        end
        object dbgDocumentosFIS_ACESSO: TcxGridDBColumn
          Caption = 'Chave de Acesso'
          DataBinding.FieldName = 'FIS_ACESSO'
          Width = 320
        end
        object dbgDocumentosGER_CODDIV: TcxGridDBColumn
          Caption = 'C'#243'digo do Profissional'
          DataBinding.FieldName = 'GER_CODDIV'
          Width = 127
        end
        object dbgDocumentosGER_NOMDIV: TcxGridDBColumn
          Caption = 'Nome do Profissional'
          DataBinding.FieldName = 'GER_NOMDIV'
          Width = 320
        end
        object dbgDocumentosGER_TRAFAT: TcxGridDBColumn
          Caption = 'Transportadora Faturamento'
          DataBinding.FieldName = 'GER_TRAFAT'
          Width = 145
        end
        object dbgDocumentosGER_ORIPDR: TcxGridDBColumn
          DataBinding.FieldName = 'GER_ORIPDR'
          Visible = False
          VisibleForCustomization = False
        end
        object dbgDocumentosDocFaturados: TcxGridDBColumn
          Caption = 'Docs. Faturados'
          DataBinding.FieldName = 'DOC_FATURADOS'
        end
        object dbgDocumentosROMLOT: TcxGridDBColumn
          Caption = 'Lote Romaneio'
          DataBinding.FieldName = 'ROMLOT'
        end
        object dbgDocumentosGER_DOCORI: TcxGridDBColumn
          DataBinding.FieldName = 'GER_DOCORI'
          Visible = False
        end
        object dbgDocumentosCLI_CODRED: TcxGridDBColumn
          Caption = 'Rede de Lojas'#39
          DataBinding.FieldName = 'CLI_CODRED'
        end
        object dbgDocumentosCLI_CODCAC: TcxGridDBColumn
          Caption = 'Canal de Acesso'
          DataBinding.FieldName = 'CLI_CODCAC'
        end
        object dbgDocumentosCORILP: TcxGridDBColumn
          Caption = 'Cor Lib Pedido'
          DataBinding.FieldName = 'CAC_CORILP'
          Visible = False
        end
        object dbgDocumentosCNDDESCRICAO: TcxGridDBColumn
          Caption = 'Condi'#231#227'o de Pagamento'
          DataBinding.FieldName = 'CNDDESCRICAO'
        end
        object dbgDocumentosROMTRA: TcxGridDBColumn
          Caption = 'Transbordo'
          DataBinding.FieldName = 'ROMTRA'
          OnCustomDrawCell = dbgDocumentosROMTRACustomDrawCell
          Width = 70
        end
        object dbgDocumentosTRA_EMPDES: TcxGridDBColumn
          DataBinding.FieldName = 'TRA_EMPDES'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
        end
        object dbgDocumentosGER_TOTFRE: TcxGridDBColumn
          Caption = 'Valor Frete'
          DataBinding.FieldName = 'GER_TOTFRE'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
        end
        object dbgDocumentosCLI_FANSOB: TcxGridDBColumn
          Caption = 'Nome Fantasia'
          DataBinding.FieldName = 'CLI_FANSOB'
          Visible = False
        end
      end
      object dbgDocumentosDBViewMaster: TcxGridDBTableViewCitel
        OnKeyDown = dbgDocumentosDBViewMasterKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = dbgDocumentosDBViewMasterCellClick
        OnCustomDrawCell = dbgDocumentosDBViewMasterCustomDrawCell
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
        object dbgDocumentosMasterGER_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'GER_MARDES'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'M'
          Properties.ValueUnchecked = 'D'
          Options.Filtering = False
          Options.FilteringWithFindPanel = False
          Options.IgnoreTimeForFiltering = False
          Options.IncSearch = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          IsCaptionAssigned = True
        end
        object dbgDocumentosMasterGER_CODROT: TcxGridDBColumn
          Caption = 'C'#243'digo Rota'
          DataBinding.FieldName = 'GER_CODROT'
        end
        object dbgDocumentosMasterGER_DESROT: TcxGridDBColumn
          Caption = 'Desci'#231#227'o'
          DataBinding.FieldName = 'GER_DESROT'
        end
        object dbgDocumentosMasterGER_QTDENT: TcxGridDBColumn
          Caption = 'Num. Entr.'
          DataBinding.FieldName = 'GER_QTDENT'
        end
        object dbgDocumentosMasterGER_QTDDOC: TcxGridDBColumn
          Caption = 'Num. Docs.'
          DataBinding.FieldName = 'GER_QTDDOC'
        end
        object dbgDocumentosMasterGER_TOTPES: TcxGridDBColumn
          Caption = 'Peso'
          DataBinding.FieldName = 'GER_TOTPES'
        end
        object dbgDocumentosMasterGER_TOTVOL: TcxGridDBColumn
          Caption = 'Volume'
          DataBinding.FieldName = 'GER_TOTVOL'
        end
        object dbgDocumentosMasterGER_TOTROT: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'GER_TOTROT'
        end
      end
      object dbgDocumentoslevel1: TcxGridLevel
        GridView = dbgDocumentosDBViewMaster
        object dbgDocumentosLevel2: TcxGridLevel
          GridView = dbgDocumentosDBView
        end
      end
    end
    object pnlInformacoes: TPanel
      Left = 1
      Top = 553
      Width = 1254
      Height = 130
      Align = alBottom
      TabOrder = 4
      object pnlObserv: TPanel
        Left = 985
        Top = 1
        Width = 320
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 320
          Height = 17
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label15: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 314
            Height = 14
            Hint = 'Inseridas na exclus'#227'o do documento em um romaneio anterior'
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Observa'#231#245'es'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Layout = tlCenter
            ExplicitLeft = 1
            ExplicitTop = 1
            ExplicitWidth = 1023
            ExplicitHeight = 13
          end
        end
        object dbmObs: TMemoFocus
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 314
          Height = 105
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object pnlObsExp: TPanel
        Left = 1305
        Top = 1
        Width = 360
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 360
          Height = 17
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label14: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 354
            Height = 14
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Observa'#231#245'es para Expedi'#231#227'o'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 5
            ExplicitTop = 4
            ExplicitWidth = 788
          end
        end
        object mmoObsExp: TMemoFocus
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 354
          Height = 105
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object pnlDadosAdicionais: TPanel
        Left = 641
        Top = 1
        Width = 344
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 344
          Height = 17
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label20: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 338
            Height = 14
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Dados adicionais da Nota Fiscal'
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 5
            ExplicitTop = 4
            ExplicitWidth = 788
          end
        end
        object memDadosAdicionais: TMemoFocus
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 338
          Height = 105
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object pnlFeriados: TPanel
        Left = 1
        Top = 1
        Width = 320
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object pnlTopFeriados: TPanel
          Left = 0
          Top = 0
          Width = 320
          Height = 17
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object lblFeriados: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 314
            Height = 14
            Hint = 'Inseridas na exclus'#227'o do documento em um romaneio anterior'
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Feriados Municipais'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Layout = tlCenter
          end
        end
        object memFeriados: TMemoFocus
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 314
          Height = 105
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object pnlOrientacoes: TPanel
        Left = 321
        Top = 1
        Width = 320
        Height = 128
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object pnlOriEntTop: TPanel
          Left = 0
          Top = 0
          Width = 320
          Height = 17
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object lblOrientacoes: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 314
            Height = 14
            Hint = 'Inseridas na exclus'#227'o do documento em um romaneio anterior'
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'Orienta'#231#245'es para Entrega'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Layout = tlCenter
          end
        end
        object memOriEnt: TMemoFocus
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 314
          Height = 105
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
    object pnlRodape: TPanel
      Left = 1
      Top = 683
      Width = 1254
      Height = 50
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object lblTotGer: TLabel
        Left = 1075
        Top = 6
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr Docs Total:'
      end
      object lblTotSel: TLabel
        Left = 1067
        Top = 29
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr Docs Selec.:'
      end
      object lblTotPes: TLabel
        Left = 706
        Top = 29
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Peso Docs Selec.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblDocSelec: TLabel
        Left = 537
        Top = 29
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd Docs Selec.:'
      end
      object lblDocumentosMaisVolumes: TLabel
        Left = 303
        Top = 6
        Width = 157
        Height = 14
        Caption = 'Documento possui mais volumes'
        Visible = False
      end
      object lblDocsTot: TLabel
        Left = 545
        Top = 6
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd Docs Total:'
      end
      object lblPesSel: TLabel
        Left = 714
        Top = 6
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Peso Docs Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblVlrProdTot: TLabel
        Left = 887
        Top = 5
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr Produtos Total:'
      end
      object lblVlrProdSel: TLabel
        Left = 879
        Top = 29
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr Produtos Selec.:'
      end
      object edtTotGer: TEditFocus
        Left = 1148
        Top = 2
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtTotSel: TEditFocus
        Left = 1148
        Top = 26
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object btnIniBus: TBitBtnLocked
        Left = 5
        Top = 2
        Width = 115
        Height = 22
        Caption = '[ F3 ] Inicia Busca'
        TabOrder = 2
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 121
        Top = 2
        Width = 140
        Height = 22
        Caption = '[ F4 ] Localiza Pr'#243'xima'
        TabOrder = 3
        OnClick = btnLocProxClick
      end
      object edtTotPes: TEditFocus
        Left = 796
        Top = 1
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object btnAdicChaveAcesso: TBitBtnLocked
        Left = 261
        Top = 26
        Width = 267
        Height = 22
        Caption = '[ALT + F3] Busca Chave de Acesso/C'#243'd. Barras Doc.'
        TabOrder = 5
        OnClick = btnAdicChaveAcessoClick
      end
      object edtDocSelec: TEditFocus
        Left = 619
        Top = 26
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object btnNovaObservacao: TBitBtnLocked
        Left = 5
        Top = 25
        Width = 115
        Height = 23
        Hint = 'Nova Observa'#231#227'o'
        Caption = '&Nova Observa'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000001000000010000000110000
          0011000000100000000B00000003000000000000000000000000000000000000
          00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
          5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
          000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
          000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
          000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
          000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
          E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
          0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
          E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
          0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
          EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
          0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
          EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
          0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
          0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
          0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
          FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
          0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
          84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
          000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
          EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
          0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
          00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
          93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btnNovaObservacaoClick
      end
      object btnLimparObs: TBitBtnLocked
        Left = 121
        Top = 25
        Width = 140
        Height = 23
        Hint = 'Limpar Observa'#231#245'es'
        Caption = '&Limpar Observa'#231#245'es'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00020000000900000012000000180000001A0000001A00000018000000100000
          0005000000010000000000000000000000000000000000000000000000020000
          000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
          022800000006000000010000000000000000000000000000000000000008442F
          1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
          2AD80302042A00000006000000010000000000000000000000000000000DB07D
          4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
          7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
          329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
          CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
          000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
          CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
          00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
          D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
          0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
          F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
          000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
          F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
          000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
          F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
          00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
          F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
          000000000000000000000000000000000000000000010000000736457A9FD8F0
          FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
          0000000000000000000000000000000000000000000000000001000000063947
          7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
          0000000000000000000000000000000000000000000000000000000000010000
          00053543728E4F63AACD151A2D40000000040000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0001000000030000000400000002000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = btnLimparObsClick
      end
      object pnlDocumentosMaisVolumes: TPanel
        Left = 282
        Top = 7
        Width = 15
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = 3644415
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 9
        Visible = False
      end
      object edtDocsTot: TEditFocus
        Left = 619
        Top = 2
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotPesSel: TEditFocus
        Left = 796
        Top = 25
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotProd: TEditFocus
        Left = 977
        Top = 2
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotProdSel: TEditFocus
        Left = 977
        Top = 26
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlTotalDocsSimp: TPanel
        Left = 1084
        Top = 0
        Width = 313
        Height = 26
        BevelOuter = bvNone
        TabOrder = 14
        Visible = False
        object lblTotDoc: TLabel
          Left = 9
          Top = 5
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Docs:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTotVol: TLabel
          Left = 176
          Top = 4
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Vol.:'
        end
        object edtTotDoc: TEditFocus
          Left = 64
          Top = 2
          Width = 80
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtTotVol: TEditFocus
          Left = 222
          Top = 2
          Width = 80
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    end
    object pnlCabecalhoPrincipal: TPanel
      Left = 1
      Top = 1
      Width = 1254
      Height = 29
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblRomaneio: TLabel
        Left = 30
        Top = 7
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'N'#186' Romaneio:'
      end
      object edtNumRom: TEditFocus
        Tag = 99
        Left = 99
        Top = 3
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        OnChange = edtNumRomChange
        OnExit = edtNumRomExit
        OnKeyPress = edtNumRomKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object chbRomaneio: TCheckBox
        Left = 171
        Top = 6
        Width = 178
        Height = 17
        Caption = 'Incluir documentos sem romaneio'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 1
      end
      object chkSomenteCliFil: TCheckBox
        Tag = 99
        Left = 355
        Top = 5
        Width = 230
        Height = 19
        Caption = 'Somente documentos de cliente filial'
        TabOrder = 2
      end
      object btnRomaneioPorVolumes: TBitBtnLocked
        Left = 586
        Top = 3
        Width = 320
        Height = 20
        Caption = 'Gera'#231#227'o de Romaneio por C'#243'digo de Barras de Volumes'
        TabOrder = 3
        OnClick = btnRomaneioPorVolumesClick
      end
      object btnConsultar: TBitBtnLocked
        Left = 165
        Top = 3
        Width = 112
        Height = 22
        Caption = '&Consultar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        Visible = False
        OnClick = btnConsultarClick
      end
    end
    object pnlCabecalhoCodigoBarras: TPanel
      Left = 1
      Top = 30
      Width = 1254
      Height = 29
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object lblCodigoDeBarras: TLabel
        Left = 16
        Top = 8
        Width = 203
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Barras - Chave de Acesso Nfe:'
      end
      object edtCodBar: TEditFocus
        Left = 225
        Top = 4
        Width = 360
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 0
        OnKeyPress = edtCodBarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnIncluir: TBitBtnLocked
        Left = 591
        Top = 4
        Width = 112
        Height = 22
        Caption = '&Incluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnIncluirClick
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 709
        Top = 4
        Width = 85
        Height = 22
        Caption = 'Recuperar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnRecuperaClick
      end
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 59
      Width = 1254
      Height = 289
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label3: TLabel
        Left = 58
        Top = 29
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label2: TLabel
        Left = 44
        Top = 144
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblCodEmp: TLabel
        Left = 49
        Top = 168
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label4: TLabel
        Left = 55
        Top = 7
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
      end
      object Label6: TLabel
        Left = 329
        Top = 7
        Width = 10
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'a'
      end
      object lbl1: TLabel
        Left = 536
        Top = 29
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Regi'#227'o:'
      end
      object Label7: TLabel
        Left = 26
        Top = 189
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label8: TLabel
        Left = 387
        Top = 188
        Width = 395
        Height = 28
        AutoSize = False
        Caption = 
          '(Inclui os documentos que contenham algum produto na linha/grupo' +
          ' especificada)'
      end
      object Label13: TLabel
        Left = 16
        Top = 98
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object lbl3: TLabel
        Left = 595
        Top = 9
        Width = 225
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dias para considerar documento no Romaneio:'
      end
      object Label9: TLabel
        Left = 99
        Top = 272
        Width = 507
        Height = 14
        Caption = 
          '[Doc.ret.Rom.] Documento retirado do romaneio, atrav'#233's da baixa ' +
          'de romaneio, por n'#227'o ter sido entregue.'
      end
      object Label16: TLabel
        Left = 36
        Top = 121
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transp. Fat:'
      end
      object lblDepVen: TLabel
        Left = 536
        Top = 144
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Depart:'
      end
      object lblCodRot: TLabel
        Left = 682
        Top = 98
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Rota:'
      end
      object Label19: TLabel
        Left = 59
        Top = 52
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object Label21: TLabel
        Left = 515
        Top = 213
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo Atend:'
      end
      object edtCodCid: TEditFocus
        Tag = 99
        Left = 99
        Top = 25
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 5
        OnExit = edtCodCidExit
        OnKeyPress = edtCodCidKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomCid: TEditFocus
        Left = 165
        Top = 25
        Width = 365
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 23
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 165
        Top = 140
        Width = 365
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 22
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 99
        Top = 140
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 12
        OnExit = edtCodVenExit
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object btnFiltrar: TBitBtnLocked
        Left = 786
        Top = 164
        Width = 85
        Height = 22
        Caption = '&Consultar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 27
        OnClick = btnFiltrarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 786
        Top = 186
        Width = 85
        Height = 22
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 28
        OnClick = btnCancelarClick
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 259
        Top = 3
        Width = 65
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
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 344
        Top = 3
        Width = 65
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
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodReg: TEditFocus
        Tag = 99
        Left = 573
        Top = 25
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 6
        OnExit = edtCodRegExit
        OnKeyPress = edtCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomReg: TEditFocus
        Left = 633
        Top = 25
        Width = 143
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 25
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLinGru: TMaskEditFocus
        Tag = 99
        Left = 99
        Top = 186
        Width = 65
        Height = 22
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 15
        Text = ''
        OnExit = edtLinGruExit
        OnKeyPress = edtLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 165
        Top = 186
        Width = 216
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 26
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdbEntrada: TRadioButton
        Left = 99
        Top = 6
        Width = 76
        Height = 17
        Caption = 'de Entrada'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rdbEntrega: TRadioButton
        Left = 178
        Top = 6
        Width = 76
        Height = 17
        Caption = 'de Entrega'
        TabOrder = 1
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 99
        Top = 94
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 9
        OnExit = edtCodTraExit
        OnKeyPress = edtCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesTra: TEditFocus
        Left = 165
        Top = 94
        Width = 511
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 32
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDiaRom: TEditFocus
        Left = 827
        Top = 3
        Width = 43
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object rdgTurno: TRadioGroup
        Tag = 99
        Left = 783
        Top = 26
        Width = 157
        Height = 73
        Caption = '   Turno:   '
        Columns = 2
        ItemIndex = 3
        Items.Strings = (
          'Manh'#227
          'Tarde'
          'Noite'
          'Todos')
        TabOrder = 20
      end
      object pnlLegend: TPanel
        Left = 99
        Top = 255
        Width = 574
        Height = 13
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 29
        object lblDevRom: TLabel
          Left = 15
          Top = 0
          Width = 69
          Height = 13
          Align = alLeft
          Alignment = taRightJustify
          Caption = ' Devolu'#231#245'es   '
          ExplicitHeight = 14
        end
        object lblPedRet: TLabel
          Left = 99
          Top = 0
          Width = 90
          Height = 13
          Align = alLeft
          Alignment = taRightJustify
          Caption = ' Pedidos Retirada  '
          ExplicitHeight = 14
        end
        object Label10: TLabel
          Left = 204
          Top = 0
          Width = 86
          Height = 13
          Align = alLeft
          Alignment = taRightJustify
          Caption = ' Pr'#233'via Impressa  '
          ExplicitHeight = 14
        end
        object Label11: TLabel
          Left = 305
          Top = 0
          Width = 93
          Height = 13
          Align = alLeft
          Alignment = taRightJustify
          Caption = ' Doc. Selecionado  '
          ExplicitHeight = 14
        end
        object Label12: TLabel
          Left = 413
          Top = 0
          Width = 157
          Height = 13
          Align = alLeft
          Caption = ' Doc. Parcialmente Selecionado  '
          ExplicitHeight = 14
        end
        object pnlDevRom: TPanel
          Left = 0
          Top = 0
          Width = 15
          Height = 13
          Align = alLeft
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clYellow
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 0
          StyleElements = [seFont, seBorder]
        end
        object pnlPedRet: TPanel
          Left = 84
          Top = 0
          Width = 15
          Height = 13
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = cl3DLight
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 1
          StyleElements = [seFont, seBorder]
        end
        object blnPreviaImpressa: TPanel
          Left = 189
          Top = 0
          Width = 15
          Height = 13
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clRed
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 2
          StyleElements = [seFont, seBorder]
        end
        object pnlDocSelecionado: TPanel
          Left = 290
          Top = 0
          Width = 15
          Height = 13
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clBlue
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 3
          StyleElements = [seFont, seBorder]
        end
        object pnlDocParcialBaixado: TPanel
          Left = 398
          Top = 0
          Width = 15
          Height = 13
          Align = alLeft
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clGreen
          Ctl3D = False
          ParentBackground = False
          ParentCtl3D = False
          TabOrder = 4
          StyleElements = [seFont, seBorder]
        end
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 99
        Top = 163
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 14
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomEmp: TEditFocus
        Left = 165
        Top = 163
        Width = 611
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 30
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTraFat: TEditFocus
        Tag = 99
        Left = 99
        Top = 117
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 11
        OnExit = edtTraFatExit
        OnKeyPress = edtTraFatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomTraFat: TEditFocus
        Left = 165
        Top = 117
        Width = 611
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 24
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 573
        Top = 140
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 13
        OnExit = edtCodDepExit
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomDep: TEditFocus
        Left = 633
        Top = 140
        Width = 143
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 31
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodRot: TEditFocus
        Tag = 99
        Left = 711
        Top = 94
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 10
        OnKeyPress = edtCodRotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object pnlLoteSep: TPanel
        Left = 2
        Top = 208
        Width = 510
        Height = 26
        BevelOuter = bvNone
        TabOrder = 16
        object Label17: TLabel
          Left = 12
          Top = 5
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Lote Separa'#231#227'o:'
        end
        object edtCodLot: TEditFocus
          Tag = 99
          Left = 97
          Top = 1
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          OnExit = edtCodLotExit
          OnKeyPress = edtCodLotKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesLot: TEditFocus
          Left = 163
          Top = 1
          Width = 341
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object pnlProduto: TPanel
        Left = 2
        Top = 68
        Width = 775
        Height = 26
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 8
        object Label18: TLabel
          Left = 52
          Top = 7
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto:'
        end
        object edtCodProduto: TEditFocus
          Tag = 99
          Left = 97
          Top = 3
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodProdutoExit
          OnKeyPress = edtCodProdutoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesProduto: TEditFocus
          Left = 163
          Top = 3
          Width = 611
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCodCliente: TEditFocus
        Tag = 99
        Left = 99
        Top = 48
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 7
        OnExit = edtCodClienteExit
        OnKeyPress = edtCodClienteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesCliente: TEditFocus
        Left = 165
        Top = 48
        Width = 611
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 33
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnRecupera: TBitBtnLocked
        Left = 786
        Top = 208
        Width = 85
        Height = 22
        Caption = 'Recuperar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 34
        OnClick = btnRecuperaClick
      end
      object pnlFiltroTpDoc: TPanel
        Left = 2
        Top = 236
        Width = 775
        Height = 15
        BevelOuter = bvNone
        TabOrder = 19
        Visible = False
        object lblTipoDocumento: TLabel
          Left = 12
          Top = -1
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo Documento:'
        end
        object rdbTotalmenteConferido: TRadioButton
          Left = 105
          Top = -1
          Width = 181
          Height = 17
          Caption = 'Totalmente Conferido'
          TabOrder = 0
        end
        object rdbParcialmenteConferido: TRadioButton
          Left = 239
          Top = -1
          Width = 236
          Height = 17
          Caption = 'Parcialmente Conferidos e N'#227'o Conferidos'
          TabOrder = 1
        end
        object rdbTodos: TRadioButton
          Left = 481
          Top = -1
          Width = 59
          Height = 17
          Caption = 'Todos'
          TabOrder = 2
        end
      end
      object edtCodTip: TEditFocus
        Tag = 99
        Left = 573
        Top = 209
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 17
        OnExit = edtCodTipExit
        OnKeyPress = edtCodTipKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesTip: TEditFocus
        Left = 633
        Top = 209
        Width = 143
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgEmpresa: TRadioGroup
        Left = 782
        Top = 105
        Width = 185
        Height = 57
        Caption = 'Utilizar empresa:'
        ItemIndex = 0
        Items.Strings = (
          'Empresa Faturamento'
          'Empresa Origem')
        TabOrder = 21
      end
    end
    object splInformacoes: TcxSplitter
      Left = 1
      Top = 545
      Width = 1254
      Height = 8
      Hint = 'Retrair Observa'#231#245'es'
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salBottom
      OnAfterOpen = splInformacoesAfterOpen
      OnAfterClose = splInformacoesAfterClose
      ShowHint = True
      ParentShowHint = False
    end
    object splCabecalho: TcxSplitter
      Left = 1
      Top = 348
      Width = 1254
      Height = 8
      Hint = 'Retrair Filtros'
      HotZoneClassName = 'TcxSimpleStyle'
      AlignSplitter = salTop
      OnAfterOpen = splCabecalhoAfterOpen
      OnAfterClose = splCabecalhoAfterClose
      ShowHint = True
      ParentShowHint = False
    end
  end
  object dksVeiculos: TdxDockSite [3]
    Left = 1256
    Top = 0
    Width = 28
    Height = 734
    Align = alRight
    AutoSize = True
    DockingType = 5
    OriginalWidth = 28
    OriginalHeight = 755
    object ldsVeiculos: TdxLayoutDockSite
      Left = 0
      Top = 0
      Width = 0
      Height = 734
      Visible = False
      DockingType = 0
      OriginalWidth = 300
      OriginalHeight = 200
    end
    object dkpVeiculos: TdxDockPanel
      Left = 0
      Top = 0
      Width = 300
      Height = 140
      Visible = False
      AllowFloating = True
      AutoHide = True
      Caption = 'Ve'#237'culos'
      CaptionButtons = [cbMaximize, cbHide]
      CustomCaptionButtons.Buttons = <>
      TabsProperties.CustomButtons.Buttons = <>
      AutoHidePosition = 2
      DockingType = 0
      OriginalWidth = 300
      OriginalHeight = 140
      object scbVeiculo: TScrollBox
        Left = 0
        Top = 0
        Width = 296
        Height = 0
        Align = alClient
        Color = 16770261
        ParentColor = False
        TabOrder = 0
        object flwpnlVeiculo: TFlowPanel
          Left = 1
          Top = 2
          Width = 288
          Height = 134
          AutoSize = True
          BevelOuter = bvNone
          Color = 16770261
          Padding.Left = 3
          Padding.Top = 3
          Padding.Right = 3
          Padding.Bottom = 3
          ParentBackground = False
          TabOrder = 0
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 344
  end
  object cxHintStyleController1: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpAuto
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 137
    Top = 404
  end
  object tmrLogRom: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrLogRomTimer
    Left = 328
    Top = 44
  end
  object popOpcoes: TPopupMenu
    Left = 576
    Top = 332
    object mnuExcluirOutEnt: TMenuItem
      Caption = 'Excluir "Outras Entradas"'
      Visible = False
      OnClick = mnuExcluirOutEntClick
    end
  end
end
