inherited frmFaturaMensalLocEqu: TfrmFaturaMensalLocEqu
  Width = 995
  Height = 636
  Caption = 'Faturamento Mensal de Loca'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 995
  ExplicitHeight = 636
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 563
    Width = 989
    ExplicitTop = 563
    ExplicitWidth = 989
    inherited FlwBotoes: TFlowPanel
      Width = 985
      ExplicitWidth = 985
      object blnConfirmarFaturamento: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 153
        Height = 22
        Caption = '[F10] Confirmar Faturamento'
        TabOrder = 0
        OnClick = blnConfirmarFaturamentoClick
      end
      object blnExpandirAcessorios: TBitBtnLocked
        Left = 153
        Top = 0
        Width = 136
        Height = 22
        Caption = '[F5] Expandir Acess'#243'rios'
        TabOrder = 1
        OnClick = blnExpandirAcessoriosClick
      end
      object blnRetrairAcessorios: TBitBtnLocked
        Left = 289
        Top = 0
        Width = 135
        Height = 22
        Caption = '[F6] Retrair Acess'#243'rios'
        TabOrder = 2
        OnClick = blnRetrairAcessoriosClick
      end
      object blnMarcarTodos: TBitBtnLocked
        Left = 424
        Top = 0
        Width = 135
        Height = 22
        Caption = '[F7] Marcar Todos'
        TabOrder = 3
        OnClick = blnMarcarTodosClick
      end
      object blnDesmarcarTodos: TBitBtnLocked
        Left = 559
        Top = 0
        Width = 135
        Height = 22
        Caption = '[F8] Desmarcar Todos'
        TabOrder = 4
        OnClick = blnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 906
      ExplicitLeft = 906
    end
  end
  inherited pnlStatus: TPanel
    Top = 591
    Width = 989
    ExplicitTop = 591
    ExplicitWidth = 989
    inherited pnlNomeForm: TPanel
      Left = 818
      ExplicitLeft = 818
    end
    inherited pnlInfo: TPanel
      Width = 818
      ExplicitWidth = 818
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 989
    Height = 89
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      985
      85)
    object lblNumCon: TLabel
      Left = 275
      Top = 9
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblCodCli: TLabel
      Left = 76
      Top = 33
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblMesVigencia: TLabel
      Left = 28
      Top = 58
      Width = 83
      Height = 14
      Caption = 'M'#234's de Vig'#234'ncia:'
    end
    object lblNumPed: TLabel
      Left = 75
      Top = 8
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 380
      Top = 5
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
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 213
      Top = 29
      Width = 328
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
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
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 116
      Top = 29
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object mskMesVig: TMaskEditFocus
      Tag = 99
      Left = 116
      Top = 53
      Width = 59
      Height = 22
      EditMask = '99/9999'
      MaxLength = 7
      TabOrder = 4
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 116
      Top = 5
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
  object pnlDtaRef: TPanel [3]
    Left = 0
    Top = 121
    Width = 989
    Height = 35
    Align = alTop
    TabOrder = 3
    DesignSize = (
      989
      35)
    object lblDataReferencia: TLabel
      Left = 30
      Top = 9
      Width = 241
      Height = 14
      Caption = 'Data/Hora refer'#234'ncia para c'#225'lculo do fechamento:'
    end
    object btnConfirmar: TBitBtnLocked
      Left = 463
      Top = 6
      Width = 120
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      TabOrder = 2
      OnClick = btnConfirmarClick
    end
    object mskDtaReferencia: TMaskEditFocus
      Tag = 99
      Left = 277
      Top = 6
      Width = 82
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtHorReferencia: TMaskEditFocus
      Tag = 99
      Left = 363
      Top = 6
      Width = 35
      Height = 22
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
  end
  object pnlFiltros: TPanel [4]
    Left = 0
    Top = 89
    Width = 989
    Height = 32
    Align = alTop
    TabOrder = 4
    object chkAgruparDuplicatas: TCheckBox
      Left = 118
      Top = 6
      Width = 298
      Height = 17
      Caption = 'Agrupar duplicatas com mesmo vencimento'
      TabOrder = 0
    end
    object chkImpBoleto: TCheckBox
      Left = 463
      Top = 6
      Width = 298
      Height = 17
      Caption = 'Imprimir boletos na finaliza'#231#227'o '
      TabOrder = 1
    end
  end
  object pnlContratos: TPanel [5]
    Left = 0
    Top = 156
    Width = 989
    Height = 407
    Align = alClient
    TabOrder = 5
    object cxGridContratos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 987
      Height = 405
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridContratosTableView: TcxGridDBTableViewCitel
        OnKeyDown = cxGridContratosTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridContratosTableViewCustomDrawCell
        DataController.DataSource = dtsContratos
        DataController.Filter.Options = [fcoCaseInsensitive]
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
        object cxGridContratosTableViewEQL_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'EQL_MARDES'
          Visible = False
          Options.Editing = False
        end
        object cxGridContratosTableViewEQL_NROCON: TcxGridDBColumn
          Caption = 'Contrato'
          DataBinding.FieldName = 'EQL_NROCON'
          Options.Editing = False
        end
        object cxGridContratosTableViewEQL_CODCLI: TcxGridDBColumn
          DataBinding.FieldName = 'EQL_CODCLI'
          Visible = False
          Options.Editing = False
        end
        object cxGridContratosTableViewCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          MinWidth = 100
          Options.Editing = False
          Width = 201
        end
        object cxGridContratosTableViewDUR_ESTCON: TcxGridDBColumn
          Caption = 'Dura'#231#227'o Estimada do Contrato'
          DataBinding.FieldName = 'DUR_ESTCON'
          MinWidth = 70
          Options.Editing = False
          Width = 289
        end
        object cxGridContratosTableViewEQL_TOTHOR: TcxGridDBColumn
          Caption = 'Horas Estimadas'
          DataBinding.FieldName = 'EQL_TOTHOR'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewEQL_TOTDIA: TcxGridDBColumn
          Caption = 'Di'#225'rias Estimadas'
          DataBinding.FieldName = 'EQL_TOTDIA'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewEQL_TOMES: TcxGridDBColumn
          Caption = 'Meses Estimados'
          DataBinding.FieldName = 'EQL_TOTMES'
          Width = 91
        end
        object cxGridContratosTableViewEQL_TOTCON: TcxGridDBColumn
          Caption = 'Valor Estimado'
          DataBinding.FieldName = 'EQL_TOTCON'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewFAT_TOTCAL: TcxGridDBColumn
          Caption = 'Valor J'#225' Faturado'
          DataBinding.FieldName = 'EQF_VLJFAT'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewEQF_VLRFAT: TcxGridDBColumn
          Caption = 'Valor Restante'
          DataBinding.FieldName = 'EQF_VLRFAT'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewTOT_HRACAL: TcxGridDBColumn
          Caption = 'Horas calc.'
          DataBinding.FieldName = 'TOT_HRACAL'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewTOT_DIACAL: TcxGridDBColumn
          Caption = 'Di'#225'rias calc.'
          DataBinding.FieldName = 'TOT_DIACAL'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewTOT_MESCAL: TcxGridDBColumn
          Caption = 'Meses Cal.'
          DataBinding.FieldName = 'TOT_MESCAL'
          Options.Editing = False
          Width = 93
        end
        object cxGridContratosTableViewVLR_LOCCAL: TcxGridDBColumn
          Caption = 'Valor loca'#231#227'o calc.'
          DataBinding.FieldName = 'VLR_LOCCAL'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewEQL_VLRCOB: TcxGridDBColumn
          Caption = 'Cobran'#231'a inspe'#231#227'o'
          DataBinding.FieldName = 'EQL_VLRCOB'
          Options.Editing = False
          Width = 102
        end
        object cxGridContratosTableViewEQL_TAXENT: TcxGridDBColumn
          Caption = 'Taxa Entrega'
          DataBinding.FieldName = 'EQL_TAXENT'
          Options.Editing = False
          Width = 81
        end
        object cxGridContratosTableViewTOT_VLRCAL: TcxGridDBColumn
          Caption = 'Valor total calc.'
          DataBinding.FieldName = 'TOT_VLRCAL'
          Options.Editing = False
          Width = 95
        end
        object cxGridContratosTableViewEQL_SEQCON: TcxGridDBColumn
          DataBinding.FieldName = 'EQL_SEQCON'
          Visible = False
        end
      end
      object cxGridItensTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEqlDet
        DataController.DetailKeyFieldNames = 'EQD_SEQCON'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'EQD_SEQCON;EQD_SEQEQL'
        DataController.MasterKeyFieldNames = 'EQL_SEQCON'
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsBehavior.FixedGroups = True
        OptionsSelection.MultiSelect = True
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridItensTableViewEQD_SEQCON: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_SEQCON'
          Visible = False
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_SEQEQL: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'EQD_SEQEQL'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_DESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'EQD_DESCRI'
          Options.Editing = False
        end
        object cxGridItensTableViewTIPO_CONTRATO: TcxGridDBColumn
          Caption = 'Contratado em'
          DataBinding.FieldName = 'TIPO_CONTRATO'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_TIPDUR: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_TIPDUR'
          Visible = False
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_QTDDUR: TcxGridDBColumn
          Caption = 'Qtd. Horas/Di'#225'rias'
          DataBinding.FieldName = 'EQD_QTDDUR'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_NSERIE: TcxGridDBColumn
          Caption = 'N'#250'mero de S'#233'rie'
          DataBinding.FieldName = 'EQD_NSERIE'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_QTDEQU: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'EQD_QTDEQU'
        end
        object cxGridItensTableViewEQD_DTACOB: TcxGridDBColumn
          Caption = 'Data/Hora Inicial - Cobran'#231'a'
          DataBinding.FieldName = 'EQD_DTACOB'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_DOCENV: TcxGridDBColumn
          Caption = 'Doc. Envio'
          DataBinding.FieldName = 'EQD_DOCENV'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_DTAFCOB: TcxGridDBColumn
          Caption = 'Data/Hora Final - Cobran'#231'a'
          DataBinding.FieldName = 'EQD_DTAFCOB'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_DOCRET: TcxGridDBColumn
          Caption = 'Doc. Retorno'
          DataBinding.FieldName = 'EQD_DOCRET'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_TOTEQL: TcxGridDBColumn
          Caption = 'Valor Loca'#231#227'o'
          DataBinding.FieldName = 'EQD_TOTEQL'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQD_VALIPE: TcxGridDBColumn
          Caption = 'Valor Cobran'#231'a'
          DataBinding.FieldName = 'EQD_VALIPE'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQF_VLJFAT: TcxGridDBColumn
          Caption = 'Valor J'#225' Faturado'
          DataBinding.FieldName = 'EQF_VLJFAT'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQF_VLRFAT: TcxGridDBColumn
          Caption = 'Valor Restante a Faturar'
          DataBinding.FieldName = 'EQF_VLRFAT'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQF_VLRDSC: TcxGridDBColumn
          Caption = 'Desconto %'
          DataBinding.FieldName = 'EQF_VLRDSC'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQF_VLRLIQ: TcxGridDBColumn
          Caption = 'Valor Restante L'#237'q.'
          DataBinding.FieldName = 'EQF_VLRLIQ'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQF_VLAFAT: TcxGridDBColumn
          Caption = 'Valor a Faturar'
          DataBinding.FieldName = 'EQF_VLAFAT'
          Options.Editing = False
          Width = 95
        end
        object cxGridItensTableViewEQD_DTAENC: TcxGridDBColumn
          Caption = 'Data Encerramento'
          DataBinding.FieldName = 'EQD_DTAENC'
          Options.Editing = False
        end
        object cxGridItensTableViewEQD_VALTOT: TcxGridDBColumn
          Caption = 'Valor total'
          DataBinding.FieldName = 'EQD_VALTOT'
          Options.Editing = False
          Width = 95
        end
      end
      object cxGridAcessoriosTableView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsEqlAcl
        DataController.DetailKeyFieldNames = 'EQD_SEQCON;EQA_SEQEQU'
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'EQD_SEQCON;EQA_SEQEQU;EQA_SEQACL'
        DataController.MasterKeyFieldNames = 'EQD_SEQCON;EQD_SEQEQL'
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
        object cxGridAcessoriosTableViewCODIGO: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Options.Editing = False
        end
        object cxGridAcessoriosTableViewDESCRICAO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRICAO'
          Options.Editing = False
          Width = 300
        end
        object cxGridAcessoriosTableViewQUANTIDADE: TcxGridDBColumn
          Caption = 'Qtd. Por Equipamento'
          DataBinding.FieldName = 'QUANTIDADE'
          Options.Editing = False
        end
        object cxGridAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn
          Caption = 'Qtde.Total'
          DataBinding.FieldName = 'EQA_QTDTOT'
        end
        object cxGridAcessoriosTableViewEQA_VLRCOB: TcxGridDBColumn
          Caption = 'Cobran'#231'a Inspe'#231#227'o'
          DataBinding.FieldName = 'EQA_VLRCOB'
          Options.Editing = False
          Width = 100
        end
        object cxGridAcessoriosTableViewEQA_SEQEQU: TcxGridDBColumn
          DataBinding.FieldName = 'EQA_SEQEQU'
          Visible = False
          Options.Editing = False
        end
        object cxGridAcessoriosTableViewEQA_SEQACL: TcxGridDBColumn
          DataBinding.FieldName = 'EQA_SEQACL'
          Visible = False
          Options.Editing = False
        end
        object cxGridAcessoriosTableViewEQD_SEQCON: TcxGridDBColumn
          DataBinding.FieldName = 'EQD_SEQCON'
          Visible = False
        end
        object cxGridAcessoriosTableViewEQA_VLRADC: TcxGridDBColumn
          Caption = 'Vlr. Adicional'
          DataBinding.FieldName = 'EQA_VLRADC'
        end
      end
      object cxGridContratosLevel1: TcxGridLevel
        GridView = cxGridContratosTableView
        object cxGridContratosLevel2: TcxGridLevel
          GridView = cxGridItensTableView
          object cxGridContratosLevelAcessorios: TcxGridLevel
            GridView = cxGridAcessoriosTableView
          end
        end
      end
    end
  end
  object dtsContratos: TUniDataSource
    DataSet = cdsContratos
    Left = 144
    Top = 212
  end
  object cdsContratos: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQL_NROCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_CODCLI'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CLI_NOMCLI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DUR_ESTCON'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EQL_TOTDIA'
        DataType = ftFloat
      end
      item
        Name = 'EQL_TOTHOR'
        DataType = ftFloat
      end
      item
        Name = 'EQL_TOTCON'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLJFAT'
        DataType = ftFloat
      end
      item
        Name = 'EQF_VLRFAT'
        DataType = ftFloat
      end
      item
        Name = 'TOT_DIACAL'
        DataType = ftFloat
      end
      item
        Name = 'TOT_HRACAL'
        DataType = ftFloat
      end
      item
        Name = 'VLR_LOCCAL'
        DataType = ftFloat
      end
      item
        Name = 'EQL_VLRCOB'
        DataType = ftFloat
      end
      item
        Name = 'TOT_VLRCAL'
        DataType = ftFloat
      end
      item
        Name = 'EQL_MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQL_TAXENT'
        DataType = ftFloat
      end
      item
        Name = 'EQL_TOTMES'
        DataType = ftInteger
      end
      item
        Name = 'TOT_MESCAL'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 212
    object cdsContratosEQL_NROCON: TStringField
      FieldName = 'EQL_NROCON'
    end
    object cdsContratosEQL_CODCLI: TStringField
      FieldName = 'EQL_CODCLI'
    end
    object cdsContratosCLI_NOMCLI: TStringField
      DisplayWidth = 70
      FieldName = 'CLI_NOMCLI'
      Size = 70
    end
    object cdsContratosDUR_ESTCON: TStringField
      DisplayWidth = 70
      FieldName = 'DUR_ESTCON'
      Size = 70
    end
    object cdsContratosEQL_TOTDIA: TFloatField
      FieldName = 'EQL_TOTDIA'
    end
    object cdsContratosEQL_TOTHOR: TFloatField
      FieldName = 'EQL_TOTHOR'
    end
    object cdsContratosEQL_TOTCON: TFloatField
      FieldName = 'EQL_TOTCON'
    end
    object cdsContratosEQF_VLJFAT: TFloatField
      FieldName = 'EQF_VLJFAT'
    end
    object cdsContratosEQF_VLRFAT: TFloatField
      FieldName = 'EQF_VLRFAT'
    end
    object cdsContratosTOT_DIACAL: TFloatField
      FieldName = 'TOT_DIACAL'
    end
    object cdsContratosTOT_HRACAL: TFloatField
      FieldName = 'TOT_HRACAL'
    end
    object cdsContratosVLR_LOCCAL: TFloatField
      FieldName = 'VLR_LOCCAL'
    end
    object cdsContratosEQL_VLRCOB: TFloatField
      FieldName = 'EQL_VLRCOB'
    end
    object cdsContratosTOT_VLRCAL: TFloatField
      FieldName = 'TOT_VLRCAL'
    end
    object cdsContratosEQL_MARDES: TStringField
      FieldName = 'EQL_MARDES'
    end
    object cdsContratosEQL_SEQCON: TStringField
      FieldName = 'EQL_SEQCON'
    end
    object cdsContratosEQL_TAXENT: TFloatField
      FieldName = 'EQL_TAXENT'
    end
    object cdsContratosEQL_TOTMES: TIntegerField
      FieldName = 'EQL_TOTMES'
    end
    object cdsContratosTOT_MESCAL: TFloatField
      FieldName = 'TOT_MESCAL'
    end
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 328
    Top = 215
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
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end>
    IndexDefs = <>
    IndexFieldNames = 'EQD_SEQCON;EQD_SEQEQL'
    Params = <>
    StoreDefs = True
    Left = 264
    Top = 215
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
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object cdsEqlAce: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'EQD_SEQCON;EQA_SEQEQU;EQA_SEQACL'
    Params = <>
    Left = 264
    Top = 271
    object cdsEqlAceCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object cdsEqlAceDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
    end
    object cdsEqlAceQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsEqlAceEQA_SEQEQU: TStringField
      FieldName = 'EQA_SEQEQU'
    end
    object cdsEqlAceEQA_SEQACL: TStringField
      FieldName = 'EQA_SEQACL'
    end
    object cdsEqlAceEQA_VLRCOB: TFloatField
      DisplayWidth = 25
      FieldName = 'EQA_VLRCOB'
    end
    object cdsEqlAceEQD_SEQCON: TStringField
      FieldName = 'EQD_SEQCON'
    end
    object cdsEqlAceEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
    object cdsEqlAceEQA_VLRADC: TFloatField
      FieldName = 'EQA_VLRADC'
    end
  end
  object dtsEqlAcl: TDataSource
    DataSet = cdsEqlAce
    Left = 328
    Top = 271
  end
end
