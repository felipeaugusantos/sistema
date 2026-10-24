inherited frmTransfLancEntreContas: TfrmTransfLancEntreContas
  Width = 1037
  Height = 581
  BorderStyle = bsSizeable
  Caption = 'Transfer'#234'ncia de Lan'#231'amentos entre Contas'
  ExplicitWidth = 1037
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 1021
    TabOrder = 3
    ExplicitTop = 500
    ExplicitWidth = 1021
    inherited FlwBotoes: TFlowPanel
      Width = 1017
      ExplicitWidth = 1017
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
      object btnExportar: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 77
        Height = 22
        Hint = 'Exportar os Dados para Planilha Eletr'#244'nica'
        Caption = '&Exportar'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 941
      ModalResult = 0
      ExplicitLeft = 941
    end
  end
  inherited pnlStatus: TPanel
    Top = 526
    Width = 1021
    TabOrder = 2
    ExplicitTop = 526
    ExplicitWidth = 1021
    inherited pnlNomeForm: TPanel
      Left = 850
      ExplicitLeft = 850
    end
    inherited pnlInfo: TPanel
      Width = 850
      ExplicitWidth = 850
    end
  end
  object gbFiltros: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 1021
    Height = 177
    Align = alTop
    Caption = 'Filtros'
    TabOrder = 0
    object Label15: TLabel
      Left = 12
      Top = 23
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 11
      Top = 49
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object lbTipLan: TLabel
      Left = 7
      Top = 78
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Lancto:'
    end
    object Label12: TLabel
      Left = 7
      Top = 148
      Width = 111
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta Cont'#225'bil Original:'
    end
    object edtEmpLan: TEditFocus
      Tag = 99
      Left = 84
      Top = 20
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtEmpLanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 143
      Top = 20
      Width = 688
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 84
      Top = 45
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 157
      Top = 45
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtTipLan: TComboBoxFocus
      Tag = 99
      Left = 84
      Top = 70
      Width = 747
      Height = 22
      Style = csDropDownList
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object rdgLancamentos: TRadioGroup
      Left = 7
      Top = 100
      Width = 824
      Height = 39
      Caption = 'Lan'#231'amentos'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Lan'#231'amentos a D'#233'bito'
        'Lan'#231'amentos a Cr'#233'dito'
        'Todos Lan'#231'amentos')
      TabOrder = 4
    end
    object mskContaOriginal: TMaskEditFocus
      Tag = 99
      Left = 124
      Top = 145
      Width = 126
      Height = 22
      TabOrder = 5
      Text = ''
      OnKeyPress = mskContaOriginalKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtConOriRed: TEditFocus
      Tag = 99
      Left = 252
      Top = 145
      Width = 113
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesContaOriginal: TEditFocus
      Left = 367
      Top = 145
      Width = 465
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAbrir: TBitBtnLocked
      Left = 837
      Top = 143
      Width = 116
      Height = 25
      Caption = '&Abrir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
        0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
        B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
        FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
        FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
        FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
        0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
        0555555555777777755555555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btnAbrirClick
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 177
    Width = 1021
    Height = 323
    Align = alClient
    TabOrder = 1
    object pnlContaTransf: TPanel
      Left = 1
      Top = 281
      Width = 1019
      Height = 41
      Align = alBottom
      TabOrder = 1
      object Label1: TLabel
        Left = 9
        Top = 14
        Width = 131
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Cont'#225'bil Transferida:'
      end
      object mskContaTransferida: TMaskEditFocus
        Tag = 99
        Left = 142
        Top = 11
        Width = 126
        Height = 22
        TabOrder = 0
        Text = ''
        OnKeyPress = mskContaTransferidaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtConTraRed: TEditFocus
        Tag = 99
        Left = 270
        Top = 11
        Width = 113
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesContaTransferida: TEditFocus
        Left = 385
        Top = 11
        Width = 465
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object Grid: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1019
      Height = 280
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridTab: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsTransferencia
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsCustomize.ColumnMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CheckBoxVisibility = [cbvDataRow, cbvColumnHeader]
        OptionsSelection.MultiSelectMode = msmPersistent
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object GridTabAUTOINCREM: TcxGridDBColumn
          DataBinding.FieldName = 'AUTOINCREM'
          Visible = False
          VisibleForCustomization = False
        end
        object GridTabCON_EMPLAN: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CON_EMPLAN'
          Width = 80
        end
        object GridTabCON_DTALAN: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CON_DTALAN'
          Width = 96
        end
        object GridTabCON_VALLAN: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CON_VALLAN'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '##,##0.00'
          Width = 134
        end
        object GridTabCON_TIPLAN: TcxGridDBColumn
          Caption = 'Tipo de Lancto'
          DataBinding.FieldName = 'CON_TIPLAN'
          Width = 112
        end
        object GridTabCON_DESVAL: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Valor'
          DataBinding.FieldName = 'CON_DESVAL'
          Width = 126
        end
        object GridTabCON_CONDEB: TcxGridDBColumn
          Caption = 'Conta D'#233'bito'
          DataBinding.FieldName = 'CON_CONDEB'
          Width = 98
        end
        object GridTabCON_DESDEB: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Conta D'#233'bito'
          DataBinding.FieldName = 'CON_DESDEB'
          Width = 292
        end
        object GridTabCON_CONCRE: TcxGridDBColumn
          Caption = 'Conta Cr'#233'dito'
          DataBinding.FieldName = 'CON_CONCRE'
          Width = 84
        end
        object GridTabCON_DESCRE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Conta Cr'#233'dito'
          DataBinding.FieldName = 'CON_DESCRE'
          Width = 484
        end
        object GridTabCON_HISTOR: TcxGridDBColumn
          Caption = 'Complemento'
          DataBinding.FieldName = 'CON_HISTOR'
          Width = 504
        end
      end
      object GridLevel: TcxGridLevel
        GridView = GridTab
      end
    end
  end
  object dsTransferencia: TDataSource
    AutoEdit = False
    Left = 704
    Top = 265
  end
end
