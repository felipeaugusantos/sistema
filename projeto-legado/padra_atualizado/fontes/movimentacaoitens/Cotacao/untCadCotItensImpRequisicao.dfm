inherited frmCadCotItensImpRequisicao: TfrmCadCotItensImpRequisicao
  Width = 1024
  Height = 584
  BorderStyle = bsSizeable
  Caption = 'Importar Requisi'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 584
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 1008
    Height = 50
    TabOrder = 1
    ExplicitTop = 479
    ExplicitWidth = 1008
    ExplicitHeight = 50
    inherited FlwBotoes: TFlowPanel
      Width = 927
      Height = 46
      ExplicitWidth = 927
      ExplicitHeight = 46
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 107
        Height = 22
        Caption = '[F10] Confirmar'
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
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 107
        Top = 0
        Width = 122
        Height = 22
        Caption = '[F6] Marca / Desmarca'
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnDesTodos: TBitBtnLocked
        Left = 229
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F7] Desmarca todas'
        TabOrder = 2
        OnClick = btnDesTodosClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 342
        Top = 0
        Width = 96
        Height = 22
        Caption = '[F8] Marca todas'
        TabOrder = 3
        OnClick = btnMarTodosClick
      end
      object btnNegar: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 196
        Height = 22
        Caption = '[ F9 ] Negar e excluir a requisi'#231#227'o'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        Visible = False
        OnClick = btnNegarClick
      end
      object btnPedVen: TBitBtnLocked
        Left = 634
        Top = 0
        Width = 102
        Height = 22
        Caption = '[F5] Pedido Venda'
        TabOrder = 5
        OnClick = btnPedVenClick
      end
      object btnAssPedCom: TBitBtnLocked
        Left = 736
        Top = 0
        Width = 167
        Height = 22
        Caption = '[Alt F5] Associar Ped. Compra'
        TabOrder = 6
        OnClick = btnAssPedComClick
      end
      object btnMostraEstoque: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 133
        Height = 22
        Caption = '[ F4 ] Estoque das Lojas'
        TabOrder = 7
        Visible = False
        OnClick = btnMostraEstoqueClick
      end
      object btnGerarPedidoCompra: TBitBtnLocked
        Left = 133
        Top = 22
        Width = 141
        Height = 22
        Caption = '[ F3 ] Ir Para Pedido Compra'
        TabOrder = 8
        Visible = False
        OnClick = btnGerarPedidoCompraClick
      end
      object bntGerarCotacao: TBitBtnLocked
        Left = 274
        Top = 22
        Width = 135
        Height = 22
        Caption = '[ F2 ] Ir Para Cota'#231#227'o'
        TabOrder = 9
        Visible = False
        OnClick = bntGerarCotacaoClick
      end
      object btnAbrirRequisicao: TBitBtnLocked
        Left = 409
        Top = 22
        Width = 135
        Height = 22
        Caption = '[ F11 ] Abrir Requisi'#231#227'o'
        TabOrder = 10
        OnClick = btnAbrirRequisicaoClick
      end
      object btnMostrarPedidodVenda: TBitBtnLocked
        Left = 544
        Top = 22
        Width = 161
        Height = 22
        Caption = '[ F12 ] Mostrar Ped. de Venda '
        TabOrder = 11
        OnClick = btnMostrarPedidodVendaClick
      end
      object btnAtualizarProdOS: TBitBtnLocked
        Left = 705
        Top = 22
        Width = 161
        Height = 22
        Caption = '[ Alt F6 ] Atualizar Produtos O.S'
        TabOrder = 13
        OnClick = btnAtualizarProdOSClick
      end
      object btnObsPed: TBitBtnLocked
        Left = 0
        Top = 44
        Width = 139
        Height = 22
        Caption = '[ Alt + F8 ] Obs. do Pedido'
        TabOrder = 12
        OnClick = btnObsPedClick
      end
      object btnAlterarItensEspeciaisReq: TBitBtnLocked
        Left = 139
        Top = 44
        Width = 210
        Height = 22
        Caption = '[Alt F7] Alterar Itens Especiais'
        TabOrder = 14
        OnClick = btnAlterarItensEspeciaisReqClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Height = 46
      Align = alRight
      Caption = '&Cancela'
      ModalResult = 2
      ExplicitLeft = 929
      ExplicitTop = 2
      ExplicitHeight = 46
    end
  end
  inherited pnlStatus: TPanel
    Top = 529
    Width = 1008
    TabOrder = 2
    ExplicitTop = 529
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      TabOrder = 1
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      TabOrder = 0
      ExplicitWidth = 837
    end
  end
  object cxgReq: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 366
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgReqView: TcxGridDBTableView
      OnKeyDown = cxgReqViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxgReqViewCellDblClick
      OnCustomDrawCell = cxgReqViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '  '
      OptionsView.GroupByBox = False
      object cxgReqViewNEGADA: TcxGridDBColumn
        Caption = 'Negada'
        DataBinding.FieldName = 'NEGADA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
      end
      object cxgReqViewMARANT: TcxGridDBColumn
        Caption = 'J'#225' Vinculada'
        DataBinding.FieldName = 'MARANT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        Width = 79
      end
      object cxgReqViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
      object cxgReqViewCODREQ: TcxGridDBColumn
        Caption = 'C'#243'd.Req.'
        DataBinding.FieldName = 'CODREQ'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 66
      end
      object cxgReqViewCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 57
      end
      object cxgReqViewDTACAD: TcxGridDBColumn
        Caption = 'Cadastro'
        DataBinding.FieldName = 'DTACAD'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgReqViewNOMOPE: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'NOMOPE'
        Width = 110
      end
      object cxgReqViewRCD_DTPREV: TcxGridDBColumn
        Caption = 'Prev. Estoque'
        DataBinding.FieldName = 'RCD_DTPREV'
        MinWidth = 87
        Width = 87
      end
      object cxgReqViewDTA_ENTREGA: TcxGridDBColumn
        Caption = 'Data Entrega'
        DataBinding.FieldName = 'DTA_ENTREGA'
        MinWidth = 80
      end
      object cxgReqViewNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 160
      end
      object cxgReqViewPRODUT: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUT'
        Visible = False
        Width = 160
      end
      object cxgReqViewCODITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 55
      end
      object cxgReqViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESITE'
        SortIndex = 0
        SortOrder = soAscending
        Width = 225
      end
      object cxgReqViewREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 75
      end
      object cxgReqViewSIGUNI: TcxGridDBColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 35
      end
      object cxgReqViewCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Width = 79
      end
      object cxgReqViewQTDORI: TcxGridDBColumn
        Caption = 'Qtd.Orig.'
        DataBinding.FieldName = 'QTDORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 50
      end
      object cxgReqViewQTDITE: TcxGridDBColumn
        Caption = 'Qtd.Pendente'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 73
      end
      object cxgReqViewCOMLIQ: TcxGridDBColumn
        Caption = 'Pre'#231'o l'#237'q.'
        DataBinding.FieldName = 'COMLIQ'
        Options.Editing = False
      end
      object cxgReqViewMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgReqViewDEPITE: TcxGridDBColumn
        Caption = 'Departamento'
        DataBinding.FieldName = 'DEPITE'
        MinWidth = 72
        Width = 175
      end
      object cxgReqViewSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'FGO_STATUS'
        Visible = False
      end
      object cxgReqViewDOCPDV: TcxGridDBColumn
        Caption = 'Num.Ped.Ven.'
        DataBinding.FieldName = 'DOCPDV'
        MinWidth = 76
        Width = 78
      end
      object cxgReqViewESPPDV: TcxGridDBColumn
        Caption = 'Esp.Ped.Ven.'
        DataBinding.FieldName = 'ESPPDV'
        MinWidth = 69
      end
      object cxgReqViewEMPPDV: TcxGridDBColumn
        Caption = 'Emp.Ped.Ven.'
        DataBinding.FieldName = 'EMPPDV'
        MinWidth = 72
      end
      object cxgReqViewCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd.Fornec.'
        DataBinding.FieldName = 'CODFOR'
        Width = 65
      end
      object cxgReqViewNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 235
      end
      object cxgReqViewDESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Width = 197
      end
      object cxgReqViewAUTDET: TcxGridDBColumn
        DataBinding.FieldName = 'AUTDET'
        Visible = False
      end
      object cxgReqViewSALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'SALDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '#,##0.000;-#,##0.000'
        HeaderAlignmentHorz = taRightJustify
        Width = 89
      end
      object cxgReqViewSalEnd: TcxGridDBColumn
        Caption = 'Saldo a endere'#231'ar dispon'#237'vel'
        DataBinding.FieldName = 'SALEND'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '#,##0.000;-#,##0.000'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 152
        Width = 152
      end
      object cxgReqViewQTDPEN: TcxGridDBColumn
        Caption = 'PD Compra Pendente'
        DataBinding.FieldName = 'QTDPEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 110
      end
      object cxgReqViewREQPCD: TcxGridDBColumn
        Caption = '(*) Ped. Compra Dispon'#237'vel '
        DataBinding.FieldName = 'QTDDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 138
      end
      object cxgReqViewQTDPEN_TODAS: TcxGridDBColumn
        Caption = 'PD Compra Pendente (Todas Lojas)'
        DataBinding.FieldName = 'QTDPEN_TODAS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Width = 177
      end
      object cxgReqViewQTDDIS_TODAS: TcxGridDBColumn
        Caption = '(*) Ped. Compra Dispon'#237'vel (Todas Lojas)'
        DataBinding.FieldName = 'QTDDIS_TODAS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Width = 205
      end
      object cxgReqViewOPERES: TcxGridDBColumn
        Caption = 'Comprador'
        DataBinding.FieldName = 'OPERES'
        HeaderAlignmentHorz = taCenter
        Width = 63
      end
      object cxgReqViewNOMRES: TcxGridDBColumn
        Caption = 'Nome do Comprador'
        DataBinding.FieldName = 'NOMRES'
        Width = 124
      end
      object cxgReqViewNOMLIN: TcxGridDBColumn
        Caption = 'Linha'
        DataBinding.FieldName = 'NOMLIN'
        Width = 190
      end
      object cxgReqViewNOMGRU: TcxGridDBColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'NOMGRU'
        Width = 190
      end
      object cxgReqViewNOTAS: TcxGridDBColumn
        Caption = 'Notas'
        DataBinding.FieldName = 'NOTAS'
        Width = 120
      end
      object cxgReqViewOBSERV: TcxGridDBColumn
        Caption = 'Observa'#231#227'o'
        DataBinding.FieldName = 'OBSERV'
        Width = 200
      end
      object cxgReqViewNUMOSE: TcxGridDBColumn
        Caption = 'N'#250'mero da O.S.'
        DataBinding.FieldName = 'EQU_NUMOSE'
      end
      object cxgReqViewEMPOSE: TcxGridDBColumn
        Caption = 'Emp. O.S.'
        DataBinding.FieldName = 'EQU_CODEMP'
      end
      object cxgReqViewPROTOC: TcxGridDBColumn
        Caption = 'Protocolo'
        DataBinding.FieldName = 'EQU_PROTOC'
      end
      object cxgReqViewGarant: TcxGridDBColumn
        Caption = 'Garantia'
        DataBinding.FieldName = 'EQU_GARANT'
      end
      object cxgReqViewColumn1: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda'
        DataBinding.FieldName = 'UNITAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        OnGetDisplayText = cxgReqViewColumn1GetDisplayText
        Width = 95
      end
      object cxgReqViewPCD_NUMPED: TcxGridDBColumn
        Caption = 'Pedido de Compra'
        DataBinding.FieldName = 'PCD_NUMPED'
        Width = 188
      end
      object cxgReqViewFORNEC: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Width = 176
      end
      object cxgReqViewQTDPED: TcxGridDBColumn
        Caption = 'Qtd. Ped. Compra'
        DataBinding.FieldName = 'QTDPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Width = 102
      end
      object cxgReqViewPCD_DTAENT: TcxGridDBColumn
        Caption = 'Ped. Dta. Ent.'
        DataBinding.FieldName = 'PCD_DTAENT'
        Width = 83
      end
    end
    object cxgCliCnd: TcxGridLevel
      GridView = cxgReqView
    end
  end
  object pnlObservacoes: TPanel [3]
    Left = 0
    Top = 366
    Width = 1008
    Height = 34
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 4
    DesignSize = (
      1008
      34)
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 106
      Height = 14
      Caption = 'Observa'#231#245'es do Item:'
    end
    object dbeObserv: TDBEditFocus
      Left = 120
      Top = 6
      Width = 873
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      DataField = 'OBSERV'
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlLegendas: TPanel [4]
    Left = 0
    Top = 400
    Width = 1008
    Height = 79
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 3
    object shpAssOutPed: TShape
      Left = 13
      Top = 23
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label2: TLabel
      Left = 30
      Top = 22
      Width = 196
      Height = 14
      Caption = 'Requisi'#231#245'es associdas a outros pedidos'
    end
    object shpAssPed: TShape
      Left = 13
      Top = 6
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
    object lblAssPed: TLabel
      Left = 30
      Top = 6
      Width = 212
      Height = 14
      Caption = 'Requisi'#231#245'es associadas ao pedido corrente'
    end
    object lblDisponivel: TLabel
      Left = 584
      Top = 6
      Width = 409
      Height = 14
      Caption = 
        '(*) Ped. Compra Dispon'#237'vel = Pedido de Compra Pendente - Requisi' +
        #231#245'es dos Pedidos '
    end
    object shpAguaEfet: TShape
      Left = 13
      Top = 40
      Width = 14
      Height = 14
      Brush.Color = clMoneyGreen
    end
    object Label4: TLabel
      Left = 30
      Top = 38
      Width = 360
      Height = 14
      Caption = 
        'Requisi'#231#245'es do pedido corrente onde existem notas de entrada vin' +
        'culadas'
    end
    object shpAguaEfetOut: TShape
      Left = 13
      Top = 56
      Width = 14
      Height = 14
      Brush.Color = 12039936
    end
    object Label5: TLabel
      Left = 30
      Top = 55
      Width = 356
      Height = 14
      Caption = 
        'Requisi'#231#245'es de outros pedidos onde existem notas de entrada vinc' +
        'uladas'
    end
    object lblMsgTransferencia: TLabel
      Left = 476
      Top = 23
      Width = 517
      Height = 14
      Alignment = taRightJustify
      Caption = 
        'O pedido de compra 123456789012 prov'#233'm de uma transfer'#234'ncia e n'#227 +
        'o pode ser associado a requisi'#231#245'es.'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 774
    Top = 74
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 342
    Top = 150
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 160
  end
end
