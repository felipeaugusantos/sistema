inherited frmFatConfPedidos: TfrmFatConfPedidos
  Left = 129
  Top = 119
  Width = 772
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Pedidos'
  Position = poMainFormCenter
  ExplicitWidth = 772
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 340
    Width = 766
    TabOrder = 7
    ExplicitTop = 340
    ExplicitWidth = 766
    inherited FlwBotoes: TFlowPanel
      Width = 762
      ExplicitWidth = 762
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 766
    ExplicitTop = 555
    ExplicitWidth = 766
    inherited pnlNomeForm: TPanel
      Left = 581
      Width = 185
      ExplicitLeft = 581
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 581
      ExplicitWidth = 581
    end
  end
  inherited pgcDados: TPageControl
    Left = 549
    Top = 101
    Width = 217
    Height = 239
    Visible = False
    ExplicitLeft = 549
    ExplicitTop = 101
    ExplicitWidth = 217
    ExplicitHeight = 239
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 209
      ExplicitHeight = 207
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 766
    Height = 101
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      766
      101)
    object Label1: TLabel
      Left = 76
      Top = 17
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 115
      Top = 11
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 189
      Top = 11
      Width = 569
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
    object pnlFiltroEndereco: TPanel
      Left = 2
      Top = 33
      Width = 762
      Height = 26
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object lblEnderecoEntrega: TLabel
        Left = 5
        Top = 6
        Width = 104
        Height = 14
        Alignment = taRightJustify
        Caption = 'Endere'#231'o de Entrega:'
      end
      object cmbClienteEnderecos: TComboBoxFocus
        Left = 113
        Top = 0
        Width = 429
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        OnSelect = cmbClienteEnderecosSelect
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object pnlCliFat: TPanel
      Left = 2
      Top = 7
      Width = 762
      Height = 26
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      DesignSize = (
        762
        26)
      object Label10: TLabel
        Left = 46
        Top = 7
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Novo Cliente:'
      end
      object edtCliFat: TEditFocus
        Tag = 99
        Left = 113
        Top = 1
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnKeyPress = edtCliFatKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCliFat: TEditFocus
        Left = 187
        Top = 1
        Width = 569
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
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
    object pnlPedOSG: TPanel
      Left = 2
      Top = 59
      Width = 762
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
      object chkPedOSG: TCheckBox
        Left = 113
        Top = 0
        Width = 449
        Height = 17
        Caption = 
          'Exibir apenas pedidos de fabricantes oriundos de OS (garantia f'#225 +
          'brica) com servi'#231'o?'
        TabOrder = 0
        OnClick = chkPedOSGClick
      end
    end
    object pnlPedOSC: TPanel
      Left = 2
      Top = 79
      Width = 762
      Height = 20
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object chkPedOSC: TCheckBox
        Left = 113
        Top = 1
        Width = 466
        Height = 17
        Caption = 
          'Exibir apenas pedidos oriundos de OS aprovados como garantia em ' +
          'cortesia com servi'#231'o? '
        TabOrder = 0
        OnClick = chkPedOSGClick
      end
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 101
    Width = 549
    Height = 239
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object cxgDocumentos: TcxGridCitel
      Left = 0
      Top = 0
      Width = 549
      Height = 239
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocumentosTBV: TcxGridDBTableView
        OnKeyDown = cxgDocumentosTBVKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxgDocumentosTBVCellDblClick
        OnCustomDrawCell = cxgDocumentosTBVCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para filtrar os pedidos'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracDelayed
        FilterRow.ApplyInputDelay = 500
        OptionsBehavior.FocusCellOnTab = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideSelection = True
        OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxgDocumentosTBVTMP_DTAENT: TcxGridDBColumn
          Caption = 'Dta. Emiss'#227'o'
          DataBinding.FieldName = 'TMP_DTAENT'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          Width = 75
        end
        object cxgDocumentosTBVTMP_CODVEN: TcxGridDBColumn
          Caption = 'Vendedor'
          DataBinding.FieldName = 'TMP_CODVEN'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object cxgDocumentosTBVTMP_NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'TMP_NUMDOC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Width = 87
        end
        object cxgDocumentosTBVTMP_NUMOSE: TcxGridDBColumn
          Caption = 'N'#186' OS'
          DataBinding.FieldName = 'TMP_NUMOSE'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Width = 45
        end
        object cxgDocumentosTBVTMP_ESPDOC: TcxGridDBColumn
          Caption = 'Esp.'
          DataBinding.FieldName = 'TMP_ESPDOC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Width = 40
        end
        object cxgDocumentosTBVTMP_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'TMP_CODEMP'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taCenter
          Width = 30
        end
        object cxgDocumentosTBVTMP_PORDES: TcxGridDBColumn
          Caption = '% Desc.'
          DataBinding.FieldName = 'TMP_PORDES'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taLeftJustify
          Properties.ReadOnly = True
          Width = 47
        end
        object cxgDocumentosTBVTMP_VLRCON: TcxGridDBColumn
          Caption = 'Vlr. Total'
          DataBinding.FieldName = 'TMP_VLRCON'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taRightJustify
        end
        object cxgDocumentosTBVTMP_ITEDOC: TcxGridDBColumn
          Caption = 'Itens'
          DataBinding.FieldName = 'TMP_ITEDOC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.ReadOnly = True
          HeaderAlignmentHorz = taRightJustify
          Width = 57
        end
        object cxgDocumentosTBVTMP_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'TMP_MARDES'
          Visible = False
          IsCaptionAssigned = True
        end
        object cxgDocumentosTBVTMP_TIPDOC: TcxGridDBColumn
          DataBinding.FieldName = 'TMP_TIPDOC'
          Visible = False
          IsCaptionAssigned = True
        end
        object cxgDocumentosTBVTMP_CILVAS: TcxGridDBColumn
          DataBinding.FieldName = 'TMP_CILVAS'
          Visible = False
          IsCaptionAssigned = True
        end
      end
      object cxgDocumentosLevel1: TcxGridLevel
        GridView = cxgDocumentosTBV
      end
    end
  end
  object pnlAux1: TPanel [5]
    Left = 549
    Top = 101
    Width = 217
    Height = 239
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 217
      Height = 89
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label4: TLabel
        Left = 2
        Top = 2
        Width = 213
        Height = 23
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitTop = 3
      end
      object Label3: TLabel
        Left = 17
        Top = 32
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label11: TLabel
        Left = 57
        Top = 55
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDoc: TEditFocus
        Left = 114
        Top = 28
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotLiq: TEditFocus
        Left = 114
        Top = 51
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
    object pnlInformativos: TPanel
      Left = 0
      Top = 89
      Width = 217
      Height = 150
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 213
        Height = 32
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 18
        Top = 40
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label17: TLabel
        Left = 57
        Top = 67
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 114
        Top = 36
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotLiqSel: TEditFocus
        Left = 114
        Top = 63
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object gpbLegenda: TGroupBox
        Left = 2
        Top = 64
        Width = 213
        Height = 84
        Align = alBottom
        Caption = 'Legenda de cores'
        TabOrder = 2
        object Shape1: TShape
          Left = 22
          Top = 17
          Width = 14
          Height = 13
          Brush.Color = clBackground
        end
        object Label7: TLabel
          Left = 40
          Top = 17
          Width = 148
          Height = 14
          Caption = 'Documentos n'#227'o selecionados'
        end
        object Shape2: TShape
          Left = 22
          Top = 33
          Width = 14
          Height = 13
          Brush.Color = clBlue
          Pen.Color = clGreen
        end
        object Label8: TLabel
          Left = 40
          Top = 33
          Width = 127
          Height = 14
          Caption = 'Documentos selecionados'
        end
        object Label9: TLabel
          Left = 40
          Top = 49
          Width = 144
          Height = 14
          Caption = 'Documentos oriundos de O.S.'
        end
        object Shape3: TShape
          Left = 22
          Top = 49
          Width = 14
          Height = 13
          Brush.Color = clGreen
          Pen.Color = clGreen
        end
        object shpLegendaComodato: TShape
          Left = 22
          Top = 65
          Width = 14
          Height = 13
          Brush.Color = clPurple
          Pen.Color = clPurple
        end
        object lblLegendaComodato: TLabel
          Left = 40
          Top = 65
          Width = 126
          Height = 14
          Caption = 'Documentos de Comodato'
        end
      end
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 524
    Width = 766
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnItensDoc: TBitBtnLocked
      Left = 97
      Top = 2
      Width = 137
      Height = 27
      Align = alLeft
      Caption = '[ F5 ] Itens do Documento'
      TabOrder = 1
      OnClick = btnItensDocClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 95
      Height = 27
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairConf: TBitBtnLocked
      Left = 653
      Top = 2
      Width = 111
      Height = 27
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairConfClick
    end
  end
  object pnlItens: TPanel [7]
    Left = 0
    Top = 340
    Width = 766
    Height = 162
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object dbgItens: TDBGridCitel
      Left = 0
      Top = 18
      Width = 766
      Height = 115
      Align = alClient
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          Title.Caption = 'C'#243'digo'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 321
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNIDAD'
          Title.Alignment = taCenter
          Title.Caption = 'UN'
          Width = 30
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quantidade'
          Width = 84
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNITAR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Unit'#225'rio'
          Width = 76
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TOTITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Total'
          Width = 83
          Visible = True
        end>
    end
    object pnlTotais: TPanel
      Left = 0
      Top = 133
      Width = 766
      Height = 29
      Align = alBottom
      ParentBackground = False
      TabOrder = 1
      object Label32: TLabel
        Left = 582
        Top = 9
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object Label2: TLabel
        Left = 289
        Top = 9
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Geral:'
      end
      object Label5: TLabel
        Left = 411
        Top = 9
        Width = 92
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desconto Especial:'
      end
      object lblTotSerDoc: TLabel
        Left = 147
        Top = 9
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total Servi'#231'os:'
      end
      object edtTotGerDoc: TEditFocus
        Left = 344
        Top = 3
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = clSilver
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        Text = '0,00'
        NormalColor = clSilver
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesEspDoc: TEditFocus
        Left = 504
        Top = 3
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = clSilver
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        Text = '0,00'
        NormalColor = clSilver
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotLiqDoc: TEditFocus
        Left = 646
        Top = 3
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = clSilver
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Text = '0,00'
        NormalColor = clSilver
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotSerDoc: TEditFocus
        Left = 219
        Top = 3
        Width = 59
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = clSilver
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        Text = '0,00'
        NormalColor = clSilver
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlItensDoc: TPanel
      Left = 0
      Top = 0
      Width = 766
      Height = 18
      Align = alTop
      BevelOuter = bvLowered
      Caption = 'Produtos do Documento - 123456 - PD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnlDadosOS: TPanel [8]
    Left = 0
    Top = 502
    Width = 766
    Height = 22
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 
      '  O.S.: 000666 - Situa'#231#227'o: REALIZADA (DEVOLVIDA AO CLIENTE) | St' +
      'atus: N'#195'O FATURADAS | Compl.: AGUARDANDO PE'#199'AS'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 8
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 56
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 296
  end
end
