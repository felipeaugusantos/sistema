inherited frmImprimeEtiquetaLoteRastreamentoProduto: TfrmImprimeEtiquetaLoteRastreamentoProduto
  Width = 805
  Height = 768
  Caption = 'Etiquetas - Lote de Rastreamento de Produto'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 805
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 697
    Width = 799
    TabOrder = 3
    ExplicitTop = 697
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 795
      ExplicitWidth = 1014
    end
  end
  inherited pgcDados: TPageControl
    Top = 209
    Width = 799
    Height = 488
    TabOrder = 1
    ExplicitTop = 291
    ExplicitWidth = 1018
    ExplicitHeight = 406
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 374
    end
  end
  object pnlContFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 799
    Height = 209
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1018
    object pnlFiltros: TPanel
      Left = 1
      Top = 1
      Width = 797
      Height = 174
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 1016
      ExplicitHeight = 208
      object lbl3: TLabel
        Left = 10
        Top = 11
        Width = 97
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo Inicial:'
      end
      object lbl4: TLabel
        Left = 70
        Top = 58
        Width = 37
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 74
        Top = 81
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object lbl6: TLabel
        Left = 22
        Top = 103
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia Inicial:'
      end
      object lbl2: TLabel
        Left = 48
        Top = 126
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object lbl9: TLabel
        Left = 53
        Top = 148
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pesq. Lote:'
      end
      object Label2: TLabel
        Left = 14
        Top = 34
        Width = 93
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo Final:'
      end
      object Label3: TLabel
        Left = 279
        Top = 103
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia Final:'
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 108
        Top = 7
        Width = 56
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = ''
        OnExit = mskLinGruExit
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesGru: TEditFocus
        Left = 164
        Top = 7
        Width = 359
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
      object edtCodIte: TEditFocus
        Left = 108
        Top = 53
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnExit = edtCodIteExit
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
        Left = 164
        Top = 53
        Width = 359
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 108
        Top = 76
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 6
        OnExit = edtCodMarExit
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesMar: TEditFocus
        Left = 164
        Top = 76
        Width = 359
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRefere: TEditFocus
        Tag = 99
        Left = 108
        Top = 99
        Width = 162
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 8
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
        Left = 108
        Top = 122
        Width = 56
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 10
        OnExit = edtCodForExit
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 152
        Top = 145
        Width = 371
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
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
      object edtNomFor: TEditFocus
        Left = 164
        Top = 122
        Width = 359
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtLinGruFin: TEditFocus
        Left = 164
        Top = 30
        Width = 359
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
      object mskLinGruFin: TMaskEditFocus
        Tag = 99
        Left = 108
        Top = 30
        Width = 56
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 2
        Text = ''
        OnExit = mskLinGruFinExit
        OnKeyPress = mskLinGruFinKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtRefFin: TEditFocus
        Tag = 99
        Left = 361
        Top = 99
        Width = 162
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnPesDoc: TBitBtnLocked
        Left = 108
        Top = 145
        Width = 41
        Height = 22
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 12
        OnClick = btnPesDocClick
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 175
      Width = 797
      Height = 33
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 257
      ExplicitWidth = 1016
      object lblQtdEtq: TLabel
        Left = 110
        Top = 11
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade de Etiquetas:'
      end
      object edtQtdEtq: TEditFocus
        Tag = 99
        Left = 231
        Top = 5
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        NumbersOnly = True
        TabOrder = 0
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '##0'
      end
      object btnConfirmaFiltro: TBitBtnLocked
        Left = 425
        Top = 5
        Width = 98
        Height = 24
        Caption = '[ F5 ] Confirma'
        TabOrder = 1
        OnClick = btnConfirmaFiltroClick
      end
      object btnLimFil: TBitBtnLocked
        Left = 325
        Top = 5
        Width = 98
        Height = 24
        Caption = '[ F4 ] Limpa Filtro'
        TabOrder = 2
        OnClick = btnLimFilClick
      end
    end
  end
  object cxDados: TcxGrid [4]
    Left = 0
    Top = 209
    Width = 799
    Height = 488
    Align = alClient
    TabOrder = 4
    LockedStateImageOptions.Text = 'Por favor aguarde...'
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -1
    ExplicitTop = 210
    ExplicitWidth = 1018
    object cxDadostv: TcxGridDBTableView
      OnKeyDown = cxDadostvKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      OnCustomDrawCell = cxDadostvCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftCompare]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar.'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir.'
      OptionsView.GroupByBox = False
      object cxDadosQTDETI: TcxGridDBColumn
        Caption = 'Qtd. Etiq.'
        DataBinding.FieldName = 'QTDETI'
        Width = 51
      end
      object cxDadosNUMLOT: TcxGridDBColumn
        Caption = 'N'#250'mero do Lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
        Width = 153
      end
      object cxDadosCODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 75
      end
      object cxDadosDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 495
      end
    end
    object cxDadosLvl: TcxGridLevel
      GridView = cxDadostv
    end
  end
  object pnlBotoesImp: TPanel [5]
    Left = 0
    Top = 697
    Width = 799
    Height = 26
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    ExplicitWidth = 1018
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 84
      Height = 22
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairImp: TBitBtnLocked
      Left = 713
      Top = 2
      Width = 84
      Height = 22
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairImpClick
      ExplicitLeft = 932
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 799
    TabOrder = 2
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 628
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 628
      ExplicitWidth = 847
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 156
    Top = 308
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 124
    Top = 308
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 148
    Top = 348
  end
  object dtsDados: TDataSource
    Left = 456
    Top = 328
  end
end
