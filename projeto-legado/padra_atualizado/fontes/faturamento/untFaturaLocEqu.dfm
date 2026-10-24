inherited frmFaturaLocEqu: TfrmFaturaLocEqu
  Width = 1047
  Height = 588
  Caption = 'Faturamento de contrato de loca'#231#227'o de equipamentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1047
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 290
    Width = 1041
    Height = 9
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 8
    ExplicitWidth = 921
  end
  inherited pnlBotoes: TPanel
    Top = 531
    Width = 1041
    TabOrder = 3
    ExplicitTop = 531
    ExplicitWidth = 1041
    inherited FlwBotoes: TFlowPanel
      Width = 1037
      ExplicitWidth = 1037
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F10] Confirma'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnImpRecibo: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F11] Imprimir Recibo'
        Enabled = False
        TabOrder = 1
        OnClick = btnImpReciboClick
      end
      object btnExpandirTodos: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 128
        Height = 22
        Caption = '[F1] Expandir Acess'#243'rios'
        TabOrder = 2
        OnClick = btnExpandirTodosClick
      end
      object btnRetrairTodos: TBitBtnLocked
        Left = 358
        Top = 0
        Width = 128
        Height = 22
        Caption = '[F2] Retrair Acess'#243'rios'
        TabOrder = 3
        OnClick = btnRetrairTodosClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 486
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F3] Marcar todos'
        TabOrder = 4
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 606
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F4] Desmarcar todos '
        TabOrder = 5
        OnClick = btnDesmarcarTodosClick
      end
      object btnImpFatura: TBitBtnLocked
        Left = 726
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F5] Imprimir Fatura'
        Enabled = False
        TabOrder = 6
        OnClick = btnImpFaturaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 959
      Top = 2
      ExplicitLeft = 959
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 515
    Width = 1041
    TabOrder = 4
    ExplicitTop = 515
    ExplicitWidth = 1041
    inherited pnlNomeForm: TPanel
      Left = 870
      ExplicitLeft = 870
    end
    inherited pnlInfo: TPanel
      Width = 870
      ExplicitWidth = 870
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1041
    Height = 34
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object lblNumCon: TLabel
      Left = 298
      Top = 7
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblInfoContrato: TLabel
      Left = 524
      Top = 7
      Width = 354
      Height = 14
      Caption = 'Contrato totalmente faturado. Carregado somente para consulta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblNumPed: TLabel
      Left = 35
      Top = 7
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 400
      Top = 4
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      OnKeyPress = edtNumConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 76
      Top = 4
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  object pnlDadosContrato: TPanel [4]
    Left = 0
    Top = 34
    Width = 1041
    Height = 103
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblCodCli: TLabel
      Left = 14
      Top = 8
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblCodVen: TLabel
      Left = 14
      Top = 31
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblEntCli: TLabel
      Left = 14
      Top = 54
      Width = 61
      Height = 14
      Caption = 'Localiza'#231#227'o:'
    end
    object Label1: TLabel
      Left = 11
      Top = 79
      Width = 164
      Height = 14
      Caption = 'Pedido gerado para adiantamento:'
    end
    object Label2: TLabel
      Left = 471
      Top = 61
      Width = 128
      Height = 14
      Caption = 'Total de Di'#225'rias estimadas:'
    end
    object lblQtde: TLabel
      Left = 500
      Top = 84
      Width = 99
      Height = 14
      Caption = 'Qtde. Equipamentos:'
    end
    object lblTotEst: TLabel
      Left = 661
      Top = 61
      Width = 123
      Height = 14
      Caption = 'Total de horas estimadas:'
    end
    object Label4: TLabel
      Left = 663
      Top = 84
      Width = 138
      Height = 14
      Caption = 'Valor total loca'#231#227'o estimado:'
    end
    object edtCodCli: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 5
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_CODCLI'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtNomCli: TDBEditFocus
      Tag = 99
      Left = 143
      Top = 5
      Width = 322
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'CLI_NOMCLI'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 28
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_CODVEN'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TDBEditFocus
      Tag = 99
      Left = 143
      Top = 28
      Width = 322
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'OPE_NOMOPE'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtLocalizacao: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 51
      Width = 387
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'ETC_ENDENT'
      DataSource = dtsContrato
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grbDuracao: TGroupBox
      Left = 479
      Top = 3
      Width = 424
      Height = 42
      Caption = '   Dura'#231#227'o do Contrato   '
      TabOrder = 5
      object lblInicio: TLabel
        Left = 27
        Top = 17
        Width = 27
        Height = 14
        Caption = 'In'#237'cio:'
      end
      object lblTermino: TLabel
        Left = 200
        Top = 17
        Width = 41
        Height = 14
        Caption = 'T'#233'rmino:'
      end
      object edtDtaIni: TDBEditFocus
        Tag = 99
        Left = 71
        Top = 14
        Width = 65
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'EQL_DTAINI'
        DataSource = dtsContrato
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDtaFin: TDBEditFocus
        Tag = 99
        Left = 247
        Top = 14
        Width = 65
        Height = 22
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'EQL_DTAFIN'
        DataSource = dtsContrato
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtHorIni: TDBEditFocus
        Tag = 99
        Left = 137
        Top = 14
        Width = 40
        Height = 22
        Color = 16768952
        DataField = 'EQL_HORINI'
        DataSource = dtsContrato
        Enabled = False
        MaxLength = 5
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtHorFin: TDBEditFocus
        Tag = 99
        Left = 313
        Top = 14
        Width = 40
        Height = 22
        Color = 16768952
        DataField = 'EQL_HORFIN'
        DataSource = dtsContrato
        Enabled = False
        MaxLength = 5
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object edtNumPedAd: TEditFocus
      Tag = 99
      Left = 181
      Top = 74
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtQtde: TDBEditFocus
      Tag = 99
      Left = 600
      Top = 81
      Width = 55
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_QTDEQU'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtQtdDia: TDBEditFocus
      Tag = 99
      Left = 600
      Top = 58
      Width = 55
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_TOTDIA'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtTotHorEst: TDBEditFocus
      Tag = 99
      Left = 801
      Top = 58
      Width = 102
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_TOTHOR'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Tag = 99
      Left = 801
      Top = 81
      Width = 102
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_TOTCON'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gbDuracaoContratoMensal: TGroupBox
      Left = 551
      Top = 1
      Width = 424
      Height = 44
      Caption = '   Dura'#231#227'o do Contrato   '
      TabOrder = 11
      object pnlDuracaoMensal: TPanel
        Left = 2
        Top = 16
        Width = 420
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblMesIni: TLabel
          Left = 7
          Top = 6
          Width = 52
          Height = 14
          Caption = 'M'#234's Inicial:'
        end
        object lblMesFin: TLabel
          Left = 179
          Top = 6
          Width = 48
          Height = 14
          Caption = 'M'#234's Final:'
        end
        object edtMesIni: TMaskEditFocus
          Tag = 99
          Left = 62
          Top = 2
          Width = 57
          Height = 22
          Color = 16768952
          Enabled = False
          EditMask = '99/9999'
          MaxLength = 7
          ReadOnly = True
          TabOrder = 0
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtMesFin: TMaskEditFocus
          Tag = 99
          Left = 230
          Top = 2
          Width = 59
          Height = 22
          Color = 16768952
          Enabled = False
          EditMask = '99/9999'
          MaxLength = 7
          ReadOnly = True
          TabOrder = 1
          Text = '  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
    object edtTotMesEst: TDBEditFocus
      Tag = 99
      Left = 807
      Top = 56
      Width = 102
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'EQL_TOTMES'
      DataSource = dtsContrato
      Enabled = False
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object grpDetalhes: TGroupBox [5]
    Left = 0
    Top = 137
    Width = 1041
    Height = 153
    Align = alClient
    Caption = '   Equipamentos do Contrato   '
    TabOrder = 2
    object lblLegendaEquipamento: TLabel
      Left = 2
      Top = 137
      Width = 1037
      Height = 14
      Align = alBottom
      Caption = 'Aten'#231#227'o:'
      Color = clBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 48
    end
    object grdItens: TcxGridCitel
      Left = 2
      Top = 16
      Width = 1037
      Height = 121
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitLeft = 3
      ExplicitTop = 40
      ExplicitHeight = 81
      object grdItensView: TcxGridDBTableViewCitel
        OnKeyDown = grdItensViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = grdItensViewCellDblClick
        OnCustomDrawCell = grdItensViewCustomDrawCell
        OnEditKeyDown = grdItensViewEditKeyDown
        DataController.DataSource = dtsEqlDet
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        OptionsView.GroupByHeaderLayout = ghlHorizontal
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdItensEQL_CODIGO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'EQD_SEQEQL'
          Options.Editing = False
          Width = 86
        end
        object grdItensEQL_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'EQD_DESCRI'
          Options.Editing = False
          Width = 189
        end
        object grdItensEQD_TIPDUR: TcxGridDBColumn
          Caption = 'Contratado Em'
          DataBinding.FieldName = 'TIPO_CONTRATO'
          Options.Editing = False
          Width = 78
        end
        object grdItensEQL_NSERIE: TcxGridDBColumn
          Caption = 'N'#250'mero de S'#233'rie'
          DataBinding.FieldName = 'EQD_NSERIE'
          Options.Editing = False
          Width = 91
        end
        object grdItensEQD_QTDEQU: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'EQD_QTDEQU'
          Options.Editing = False
        end
        object grdItensEQD_DTACOB: TcxGridDBColumn
          Caption = 'Data/Hora Inicial - Cobran'#231'a'
          DataBinding.FieldName = 'EQD_DTACOB'
          Options.Editing = False
          Width = 141
        end
        object grdItensEQD_DOCENV: TcxGridDBColumn
          Caption = 'Doc. envio'
          DataBinding.FieldName = 'EQD_DOCENV'
          Options.Editing = False
          Width = 69
        end
        object grdItensEQD_DTAFCOB: TcxGridDBColumn
          Caption = 'Data/Hora final - cobran'#231'a'
          DataBinding.FieldName = 'EQD_DTAFCOB'
          Options.Editing = False
          Width = 137
        end
        object grdItensEQD_DOCRET: TcxGridDBColumn
          Caption = 'Doc. retorno'
          DataBinding.FieldName = 'EQD_DOCRET'
          Options.Editing = False
          Width = 69
        end
        object grdItensEQF_DIACAL: TcxGridDBColumn
          Caption = 'Di'#225'rias a Faturar'
          DataBinding.FieldName = 'EQF_DIACAL'
          Options.Editing = False
          Width = 89
        end
        object grdItensEQF_HORCAL: TcxGridDBColumn
          Caption = 'Horas a Faturar'
          DataBinding.FieldName = 'EQF_HORCAL'
          Options.Editing = False
          Width = 87
        end
        object grdItensEQF_MESCAL: TcxGridDBColumn
          Caption = 'Meses a Faturar'
          DataBinding.FieldName = 'EQF_MESCAL'
          Options.Editing = False
          Width = 89
        end
        object grdItensEQD_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_MARDES'
          Visible = False
          Options.Editing = False
        end
        object grdItensEQD_TOTEQL: TcxGridDBColumn
          Caption = 'Valor loca'#231#227'o'
          DataBinding.FieldName = 'EQD_TOTEQL'
          Options.Editing = False
          Width = 80
        end
        object grdItensEQD_VALIPE: TcxGridDBColumn
          Caption = 'Cobran'#231'a inspe'#231#227'o'
          DataBinding.FieldName = 'EQD_VALIPE'
          Options.Editing = False
          Width = 101
        end
        object grdItensEQF_VLJFAT: TcxGridDBColumn
          Caption = 'Valor j'#225' Faturado'
          DataBinding.FieldName = 'EQF_VLJFAT'
          Options.Editing = False
          Width = 89
        end
        object grdItensEQF_VLRFAT: TcxGridDBColumn
          Caption = 'Valor Restante a Faturar'
          DataBinding.FieldName = 'EQF_VLRFAT'
          Options.Editing = False
          Width = 125
        end
        object grdItensEQF_VALDES: TcxGridDBColumn
          Caption = 'Desc.(R$)'
          DataBinding.FieldName = 'EQF_VALDES'
        end
        object grdItensEQF_VLRDSC: TcxGridDBColumn
          Caption = 'Desconto(%)'
          DataBinding.FieldName = 'EQF_VLRDSC'
          Options.Editing = False
          Width = 77
        end
        object grdItensEQF_VLRLIQ: TcxGridDBColumn
          Caption = 'Valor Restante L'#237'q.'
          DataBinding.FieldName = 'EQF_VLRLIQ'
          Options.Editing = False
          Width = 105
        end
        object grdItensEQF_VLAFAT: TcxGridDBColumn
          Caption = 'Valor a Faturar'
          DataBinding.FieldName = 'EQF_VLAFAT'
          Options.Editing = False
          Width = 83
        end
        object grdItensEQF_DTAENC: TcxGridDBColumn
          Caption = 'Data Encerramento'
          DataBinding.FieldName = 'EQD_DTAENC'
          Options.Editing = False
        end
        object grdItensEQD_VALTOT: TcxGridDBColumn
          Caption = 'Valor total'
          DataBinding.FieldName = 'EQD_VALTOT'
          Options.Editing = False
          Width = 69
        end
      end
      object grdAcessoriosTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEqlAcl
        DataController.DetailKeyFieldNames = 'EQA_SEQEQU'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'EQA_SEQEQU'
        DataController.MasterKeyFieldNames = 'EQD_SEQEQL'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdAcessoriosTableViewCODIGO: TcxGridDBColumn
          Caption = 'C'#243'd. Acess'#243'rio'
          DataBinding.FieldName = 'CODIGO'
          Options.Editing = False
        end
        object grdAcessoriosTableViewDESCRICAO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRICAO'
          Options.Editing = False
        end
        object grdAcessoriosTableViewQUANTIDADE: TcxGridDBColumn
          Caption = 'Qtd. Por Equipamento'
          DataBinding.FieldName = 'QUANTIDADE'
          Options.Editing = False
        end
        object grdAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn
          Caption = 'Qtde.Total'
          DataBinding.FieldName = 'EQA_QTDTOT'
        end
        object grdAcessoriosTableViewEQA_SEQEQU: TcxGridDBColumn
          DataBinding.FieldName = 'EQA_SEQEQU'
          Visible = False
          Options.Editing = False
        end
        object grdAcessoriosTableViewEQA_SEQACL: TcxGridDBColumn
          DataBinding.FieldName = 'EQA_SEQACL'
          Visible = False
          Options.Editing = False
        end
        object grdAcessoriosTableViewEQA_VLRCOB: TcxGridDBColumn
          Caption = 'Valor Cobran'#231'a'
          DataBinding.FieldName = 'EQA_VLRCOB'
          Options.Editing = False
        end
        object grdAcessoriosTableViewEQA_VLRADC: TcxGridDBColumn
          Caption = 'Vlr.Total Adicional '
          DataBinding.FieldName = 'EQA_VLRADC'
          Options.Editing = False
        end
      end
      object grdItensLvl: TcxGridLevel
        GridView = grdItensView
        object grdAcessoriosLevel1: TcxGridLevel
          GridView = grdAcessoriosTableView
        end
      end
    end
  end
  object pnlFatura: TPanel [6]
    Left = 0
    Top = 299
    Width = 1041
    Height = 216
    Align = alBottom
    Caption = 'pnlFatura'
    TabOrder = 5
    object pnlObservacoes: TPanel
      Left = 1
      Top = 200
      Width = 1039
      Height = 15
      Align = alBottom
      Color = 13826810
      ParentBackground = False
      TabOrder = 0
      object lblInfoHoraReferencia: TLabel
        Left = 1
        Top = 1
        Width = 1037
        Height = 14
        Align = alTop
        Caption = 
          'Aten'#231#227'o: foi utilizada para hora de refer'#234'cia estimada de final ' +
          'de contrato, a data inicial de cobran'#231'a do primeiro item. Verifi' +
          'que antes de prosseguir.'
        Color = clRed
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 813
      end
    end
    object grpDadosFaturamento: TGroupBox
      Left = 1
      Top = 115
      Width = 1039
      Height = 85
      Align = alBottom
      Caption = '   Dados para emiss'#227'o da nota fiscal de faturamento   '
      Enabled = False
      TabOrder = 1
      object Label7: TLabel
        Left = 135
        Top = 22
        Width = 119
        Height = 14
        Caption = 'Data/Hora de refer'#234'ncia:'
      end
      object Label8: TLabel
        Left = 724
        Top = 43
        Width = 104
        Height = 14
        Caption = 'Valor do faturamento:'
      end
      object Label9: TLabel
        Left = 372
        Top = 64
        Width = 71
        Height = 14
        Caption = 'Valor restante:'
      end
      object Label11: TLabel
        Left = 538
        Top = 64
        Width = 94
        Height = 14
        Caption = 'Valor Restante L'#237'q.:'
      end
      object Label10: TLabel
        Left = 346
        Top = 43
        Width = 97
        Height = 14
        Caption = 'Cobran'#231'a inspe'#231#227'o:'
      end
      object Label12: TLabel
        Left = 167
        Top = 61
        Width = 83
        Height = 14
        Caption = 'Valor j'#225' faturado:'
      end
      object Label13: TLabel
        Left = 777
        Top = 62
        Width = 51
        Height = 14
        Caption = 'Valor total:'
      end
      object Label5: TLabel
        Left = 139
        Top = 44
        Width = 116
        Height = 14
        Caption = 'Total dos Equipamentos:'
      end
      object Label6: TLabel
        Left = 551
        Top = 43
        Width = 81
        Height = 14
        Caption = 'Taxa de Entrega:'
      end
      object Label3: TLabel
        Left = 696
        Top = 20
        Width = 132
        Height = 14
        Caption = 'Valor Adicional Acess'#243'rios:'
      end
      object edtDtaReferencia: TMaskEditFocus
        Tag = 99
        Left = 256
        Top = 16
        Width = 67
        Height = 22
        Color = 16768952
        Enabled = False
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtHorReferencia: TMaskEditFocus
        Tag = 99
        Left = 324
        Top = 16
        Width = 35
        Height = 22
        Color = 16768952
        Enabled = False
        EditMask = '99:99;1;_'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtValorFaturamento: TEditFocus
        Left = 830
        Top = 39
        Width = 85
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
      object edtVlrTotRestante: TEditFocus
        Left = 446
        Top = 62
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVlrRestanteLiq: TEditFocus
        Left = 636
        Top = 62
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVlrTotIpe: TEditFocus
        Left = 446
        Top = 39
        Width = 85
        Height = 22
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
      object chkEncerrarEquipamentos: TCheckBox
        Left = 401
        Top = 16
        Width = 201
        Height = 17
        Caption = 'Encerrar equipamentos selecionados'
        TabOrder = 6
        OnClick = chkEncerrarEquipamentosClick
      end
      object edtVltTotJaFatu: TEditFocus
        Left = 256
        Top = 62
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVlrTot: TEditFocus
        Left = 830
        Top = 62
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdgOpcao: TRadioGroup
        Left = 3
        Top = 13
        Width = 130
        Height = 66
        Caption = 'Op'#231#227'o'
        ItemIndex = 0
        Items.Strings = (
          'Faturamento total'
          'Faturamento parcial')
        TabOrder = 9
        OnClick = rdgOpcaoClick
      end
      object edtTotLocEqu: TEditFocus
        Left = 256
        Top = 39
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTaxEnt: TEditFocus
        Left = 636
        Top = 39
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVlrAdc: TEditFocus
        Left = 830
        Top = 16
        Width = 85
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 12
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object grpFatura: TGroupBox
      Left = 1
      Top = 1
      Width = 1039
      Height = 114
      Align = alClient
      Caption = '   Faturas emitidas   '
      TabOrder = 2
      object grdFatur: TcxGridCitel
        Left = 2
        Top = 16
        Width = 1035
        Height = 96
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdFaturTableView: TcxGridDBTableViewCitel
          OnKeyDown = grdFaturTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = grdFaturTableViewCellClick
          DataController.DataSource = dtsEqlFat
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
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdFaturEQF_SEQEQL: TcxGridDBColumn
            Caption = 'C'#243'd. Equipamento'
            DataBinding.FieldName = 'EQF_SEQEQL'
            Width = 95
          end
          object grdFaturEQF_DOCFAT: TcxGridDBColumn
            Caption = 'Documento fat.'
            DataBinding.FieldName = 'EQF_DOCFAT'
            Width = 149
          end
          object grdFaturEQF_DTAFAT: TcxGridDBColumn
            Caption = 'Data faturamento'
            DataBinding.FieldName = 'EQF_DTAFAT'
            Width = 105
          end
          object grdFaturEQF_DTAREF: TcxGridDBColumn
            Caption = 'Data Ref.'
            DataBinding.FieldName = 'EQF_DTAREF'
            Width = 89
          end
          object grdFaturEQF_HORREF: TcxGridDBColumn
            Caption = 'Hora Ref.'
            DataBinding.FieldName = 'EQF_HORREF'
            Width = 60
          end
          object grdFaturEQF_QTDHOR: TcxGridDBColumn
            Caption = 'Qtd. horas/di'#225'rias'
            DataBinding.FieldName = 'EQF_QTDHOR'
            Width = 100
          end
          object grdFaturColumn5: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de pagamento'
            DataBinding.FieldName = 'EQF_CONPAG'
            Width = 216
          end
          object grdFaturEQF_VALFAT: TcxGridDBColumn
            Caption = 'Valor faturado'
            DataBinding.FieldName = 'EQF_VALFAT'
            Width = 101
          end
          object grdFaturEQF_NUMDOC: TcxGridDBColumn
            DataBinding.FieldName = 'EQF_NUMDOC'
            Visible = False
          end
          object grdFaturEQF_ESPDOC: TcxGridDBColumn
            DataBinding.FieldName = 'EQF_ESPDOC'
            Visible = False
          end
          object grdFaturEQF_EMPDOC: TcxGridDBColumn
            DataBinding.FieldName = 'EQF_EMPDOC'
            Visible = False
          end
        end
        object grdFaturLevel: TcxGridLevel
          GridView = grdFaturTableView
        end
      end
    end
  end
  object dtsContrato: TDataSource
    Left = 688
    Top = 58
  end
  object dtsEqlFat: TDataSource
    Left = 224
    Top = 338
  end
  object cdsEqlDet: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQD_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_DSCVEN'
        DataType = ftFloat
      end
      item
        Name = 'EQL_DSCSGE'
        DataType = ftFloat
      end
      item
        Name = 'EQL_DSCGER'
        DataType = ftFloat
      end
      item
        Name = 'EQL_VALLOC'
        DataType = ftFloat
      end
      item
        Name = 'EQD_VLLOCL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTLIQ'
        DataType = ftFloat
      end
      item
        Name = 'EQD_PERDES'
        DataType = ftFloat
      end
      item
        Name = 'EQL_VLRCAU'
        DataType = ftFloat
      end
      item
        Name = 'EQD_VLRALT'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_VALHOR'
        DataType = ftFloat
      end
      item
        Name = 'EQD_TOTEQL'
        DataType = ftFloat
      end
      item
        Name = 'EQD_DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQD_SEQEQL'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_TIPDUR'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_CODIGO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_NSERIE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTOINCREM'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPO_CONTRATO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_VALIPE'
        DataType = ftFloat
      end
      item
        Name = 'EQD_VALTOT'
        DataType = ftFloat
      end
      item
        Name = 'EQD_QTDDUR'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLAFAT'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLRFAT'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLRDSC'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLRLIQ'
        DataType = ftFloat
      end
      item
        Name = 'EQF_DTAENC'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_VLJFAT'
        DataType = ftFloat
      end
      item
        Name = 'EQD_DOCENV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DOCRET'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQD_DTAIPE'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_DTACOB'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_DTAFCOB'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_DTAENC'
        DataType = ftDateTime
      end
      item
        Name = 'EQD_UTIFXN'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_VALDES'
        DataType = ftFloat
      end
      item
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end
      item
        Name = 'EQF_DIACAL'
        DataType = ftFloat
      end
      item
        Name = 'EQF_HORCAL'
        DataType = ftFloat
      end
      item
        Name = 'EQF_MESCAL'
        DataType = ftFloat
      end>
    IndexDefs = <>
    IndexFieldNames = 'EQD_DTAENC;EQD_SEQEQL'
    Params = <>
    StoreDefs = True
    Left = 112
    Top = 255
    object cdsEqlDetEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsEqlDetEQL_DSCVEN: TFloatField
      FieldName = 'EQL_DSCVEN'
    end
    object cdsEqlDetEQL_DSCSGE: TFloatField
      FieldName = 'EQL_DSCSGE'
    end
    object cdsEqlDetEQL_DSCGER: TFloatField
      FieldName = 'EQL_DSCGER'
    end
    object cdsEqlDetEQL_VALLOC: TFloatField
      FieldName = 'EQL_VALLOC'
    end
    object cdsEqlDetEQD_VLLOCL: TFloatField
      FieldName = 'EQD_VLLOCL'
    end
    object cdsEqlDetEQD_TOTLIQ: TFloatField
      FieldName = 'EQD_TOTLIQ'
    end
    object cdsEqlDetEQD_PERDES: TFloatField
      FieldName = 'EQD_PERDES'
    end
    object cdsEqlDetEQL_VLRCAU: TFloatField
      FieldName = 'EQL_VLRCAU'
    end
    object cdsEqlDetTIPO_CONTRATO: TStringField
      FieldName = 'TIPO_CONTRATO'
    end
    object cdsEqlDetEQD_VLRALT: TStringField
      FieldName = 'EQD_VLRALT'
    end
    object cdsEqlDetEQD_VALHOR: TFloatField
      FieldName = 'EQD_VALHOR'
    end
    object cdsEqlDetEQD_TOTEQL: TFloatField
      FieldName = 'EQD_TOTEQL'
    end
    object cdsEqlDetEQD_DESCRI: TStringField
      FieldName = 'EQD_DESCRI'
    end
    object cdsEqlDetEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetEQD_TIPDUR: TStringField
      FieldName = 'EQD_TIPDUR'
    end
    object cdsEqlDetEQL_CODIGO: TStringField
      FieldName = 'EQL_CODIGO'
    end
    object cdsEqlDetEQD_NSERIE: TStringField
      FieldName = 'EQD_NSERIE'
    end
    object cdsEqlDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEqlDetEQD_VALIPE: TFloatField
      FieldName = 'EQD_VALIPE'
    end
    object cdsEqlDetEQD_VALTOT: TFloatField
      FieldName = 'EQD_VALTOT'
    end
    object cdsEqlDetEQD_QTDDUR: TFloatField
      FieldName = 'EQD_QTDDUR'
    end
    object cdsEqlDetEQF_VLJFAT: TFloatField
      FieldName = 'EQF_VLJFAT'
    end
    object cdsEqlDetEQF_VLAFAT: TFloatField
      FieldName = 'EQF_VLAFAT'
    end
    object cdsEqlDetEQF_VLRFAT: TFloatField
      FieldName = 'EQF_VLRFAT'
    end
    object cdsEqlDetEQF_VLRDSC: TFloatField
      FieldName = 'EQF_VLRDSC'
    end
    object cdsEqlDetEQF_VLRLIQ: TFloatField
      FieldName = 'EQF_VLRLIQ'
    end
    object cdsEqlDetEQF_DTAENC: TDateTimeField
      FieldName = 'EQF_DTAENC'
    end
    object cdsEqlDetEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsEqlDetEQD_DOCENV: TStringField
      FieldName = 'EQD_DOCENV'
    end
    object cdsEqlDetEQD_DOCRET: TStringField
      FieldName = 'EQD_DOCRET'
    end
    object cdsEqlDetEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsEqlDetEQD_DTACOB: TDateTimeField
      FieldName = 'EQD_DTACOB'
    end
    object cdsEqlDetEQD_DTAFCOB: TDateTimeField
      FieldName = 'EQD_DTAFCOB'
    end
    object cdsEqlDetEQD_DTAENC: TDateTimeField
      FieldName = 'EQD_DTAENC'
    end
    object cdsEqlDetEQD_UTIFXN: TStringField
      FieldName = 'EQD_UTIFXN'
    end
    object cdsEqlDetEQF_VALDES: TFloatField
      FieldName = 'EQF_VALDES'
    end
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
    object cdsEqlDetEQF_DIACAL: TFloatField
      FieldName = 'EQF_DIACAL'
    end
    object cdsEqlDetEQF_HORCAL: TFloatField
      FieldName = 'EQF_HORCAL'
    end
    object cdsEqlDetEQF_MESCAL: TFloatField
      FieldName = 'EQF_MESCAL'
    end
  end
  object csdEqlAce: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 255
    object csdEqlAceCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object csdEqlAceDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object csdEqlAceQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object csdEqlAceEQA_SEQEQU: TStringField
      FieldName = 'EQA_SEQEQU'
    end
    object csdEqlAceEQA_SEQACL: TStringField
      FieldName = 'EQA_SEQACL'
    end
    object csdEqlAceEQA_VLRCOB: TFloatField
      DisplayWidth = 25
      FieldName = 'EQA_VLRCOB'
    end
    object csdEqlAceEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
    object csdEqlAceEQA_VLRADC: TFloatField
      FieldName = 'EQA_VLRADC'
    end
  end
  object dtsEqlAcl: TDataSource
    DataSet = csdEqlAce
    Left = 240
    Top = 255
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 40
    Top = 255
  end
  object frxContratoLocacao: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44834.440589953700000000
    ReportOptions.LastChange = 44986.664282650460000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 344
    Top = 192
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Emitente: TfrxPageHeader
        FillType = ftBrush
        Height = 846.614651650000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'EmitenteOnBeforePrint'
        object Memo56: TfrxMemoView
          Left = 196.535560000000000000
          Width = 521.574676220000000000
          Height = 86.929121650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object memEmitenteCaixa: TfrxMemoView
          Width = 196.535096220000000000
          Height = 86.929121650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object memDadosEmitente: TfrxMemoView
          Left = 202.960695830000000000
          Top = 24.188971500000000000
          Width = 510.236415750000000000
          Height = 39.685019840000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMP_ENDERE]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 203.094620000000000000
          Top = 68.031452130000000000
          Width = 510.236550000000000000
          Height = 13.228344020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'CNPJ: [EMP_C_G_C_]')
          ParentFont = False
        end
        object imgLogo: TfrxPictureView
          Left = 5.669293780000000000
          Top = 3.779525120000000000
          Width = 185.196921180000000000
          Height = 75.590551180000000000
          Center = True
          DataField = 'LogoCarregado'
          DataSetName = 'Parametros'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object memEmitente: TfrxMemoView
          Left = 202.960695830000000000
          Top = 3.779530000000000000
          Width = 510.236415750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMP_NOMEMP]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Top = 94.488250000000000000
          Width = 718.110236220000000000
          Height = 41.574761650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8W = (
            'FATURA / DUPLICATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Top = 136.063080000000000000
          Width = 718.110619450000000000
          Height = 113.385875590000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 555.590910000000000000
          Top = 94.488250000000000000
          Width = 166.298856220000000000
          Height = 41.574761650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURA DE LOCA'#199#195'O')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 389.291590000000000000
          Top = 94.488250000000000000
          Width = 166.298856220000000000
          Height = 41.574761650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA DE EMISS'#195'O')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 559.370440000000000000
          Top = 117.165430000000000000
          Width = 154.960595750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#186' [NUMFAT]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 393.071120000000000000
          Top = 117.165430000000000000
          Width = 158.740125750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 139.842610000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'RAZ'#195'O SOCIAL:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 154.960730000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'ENDERE'#199'O')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 170.078850000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 185.196970000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'CIDADE / ESTADO:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 200.315090000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 215.433210000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 230.551330000000000000
          Width = 151.181102360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            'IE:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 162.519790000000000000
          Top = 139.842610000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[NOMDES]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 162.519790000000000000
          Top = 154.960730000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[ENDDES]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 162.519790000000000000
          Top = 170.078850000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[BAIDES]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 162.519790000000000000
          Top = 185.196970000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[CIDDES]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 162.519790000000000000
          Top = 200.315090000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[CEPDES]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 162.519790000000000000
          Top = 215.433210000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[CGCDES]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 162.519790000000000000
          Top = 230.551330000000000000
          Width = 548.031752360000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[IE_DES]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Top = 336.378170000000000000
          Width = 718.110236220000000000
          Height = 18.897581650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Fill.BackColor = 14211288
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DESCRI'#199#195'O DOS SERVI'#199'OS / DURA'#199#195'O / VALOR')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Top = 355.275820000000000000
          Width = 718.110619450000000000
          Height = 381.732505590000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 362.834880000000000000
          Width = 706.772110000000000000
          Height = 366.614400240000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'courier new'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[DSCSER]')
          ParentFont = False
        end
        object memoObs: TfrxMemoView
          Top = 771.024120000000000000
          Width = 718.110236220000000000
          Height = 68.031471650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Top = 744.567410000000000000
          Width = 521.574676220000000000
          Height = 26.456641650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL DA FATURA / DUPLICATA (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 521.575140000000000000
          Top = 744.567410000000000000
          Width = 196.535096220000000000
          Height = 26.456641650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 158.740260000000000000
          Top = 253.228510000000000000
          Width = 559.369976220000000000
          Height = 18.897581650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Fill.BackColor = 14211288
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 158.740260000000000000
          Top = 272.126160000000000000
          Width = 559.370359450000000000
          Height = 60.472455590000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapY = 2.000000000000000000
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Top = 253.228510000000000000
          Width = 158.739796220000000000
          Height = 79.370061650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Top = 275.905690000000000000
          Width = 147.401535750000000000
          Height = 16.629916380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DESDOBRAMENTO DA')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 298.582870000000000000
          Width = 147.401535750000000000
          Height = 16.629916380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'FATURA/DUPLICATA')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 166.299320000000000000
          Top = 255.008040000000000000
          Width = 105.826705750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'NO. DA COBRAN'#199'A')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 302.362400000000000000
          Top = 255.228510000000000000
          Width = 120.944825750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA DO VENCIMENTO')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 445.984540000000000000
          Top = 255.228510000000000000
          Width = 124.724355750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 585.827150000000000000
          Top = 255.228510000000000000
          Width = 124.724355750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'COND. PAGAMENTO')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 158.740260000000000000
          Top = 272.126160000000000000
          Width = 128.503556220000000000
          Height = 60.472411650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 287.244280000000000000
          Top = 272.126160000000000000
          Width = 151.180736220000000000
          Height = 60.472411650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 438.425480000000000000
          Top = 272.126160000000000000
          Width = 139.842146220000000000
          Height = 60.472411650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 578.268090000000000000
          Top = 272.126160000000000000
          Width = 139.842146220000000000
          Height = 60.472411650000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          GapY = 2.000000000000000000
          HAlign = haCenter
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 162.519790000000000000
          Top = 275.905690000000000000
          Width = 120.944825750000000000
          Height = 12.850386380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[NUMFAT]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 291.023810000000000000
          Top = 275.905690000000000000
          Width = 143.622005750000000000
          Height = 50.645686380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTAVEN]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 442.205010000000000000
          Top = 275.905690000000000000
          Width = 132.283415750000000000
          Height = 50.645686380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[VALOR_]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 529.134200000000000000
          Top = 748.346940000000000000
          Width = 185.196835750000000000
          Height = 16.629916380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[VLRTOT]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 786.142240000000000000
          Width = 710.551505750000000000
          Height = 50.645686380000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          GapX = 1.000000000000000000
          Memo.UTF8W = (
            '[OBS]')
          ParentFont = False
        end
      end
    end
  end
  object cdsFatura: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 649
    Top = 356
    object cdsFaturaIMPRIM: TBooleanField
      FieldName = 'IMPRIM'
    end
    object cdsFaturaCTR_NUMDUP: TStringField
      FieldName = 'CTR_NUMDUP'
      Size = 12
    end
    object cdsFaturaCTR_ESPDOC: TStringField
      FieldName = 'CTR_ESPDOC'
      Size = 2
    end
    object cdsFaturaCTR_CODEMP: TStringField
      FieldName = 'CTR_CODEMP'
      Size = 3
    end
    object cdsFaturaCTR_PARCEL: TStringField
      FieldName = 'CTR_PARCEL'
      Size = 3
    end
    object cdsFaturaCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object cdsFaturaCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
    end
  end
end
