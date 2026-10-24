inherited frmRecorrenciaOcorrencia: TfrmRecorrenciaOcorrencia
  Width = 969
  Height = 604
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Recorr'#234'ncia de Ocorr'#234'ncias'
  WindowState = wsMaximized
  OnClose = nil
  ExplicitWidth = 969
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 531
    Width = 963
    ExplicitTop = 531
    ExplicitWidth = 963
    inherited FlwBotoes: TFlowPanel
      Width = 959
      ExplicitWidth = 959
      object btnAlterar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 24
        Caption = '[F5] Alterar'
        TabOrder = 0
        OnClick = btnAlterarClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 125
        Height = 24
        Caption = '[F6] Excluir'
        TabOrder = 1
        OnClick = btnExcluirClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 125
        Height = 24
        Caption = '[F7] Marcar Todos'
        TabOrder = 2
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 375
        Top = 0
        Width = 125
        Height = 24
        Caption = '[F8] Desmarcar Todos'
        TabOrder = 3
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 880
      ExplicitLeft = 880
    end
  end
  inherited pnlStatus: TPanel
    Top = 559
    Width = 963
    ExplicitTop = 559
    ExplicitWidth = 963
    inherited pnlNomeForm: TPanel
      Left = 792
      ExplicitLeft = 792
    end
    inherited pnlInfo: TPanel
      Width = 792
      ExplicitWidth = 792
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 963
    Height = 177
    Align = alTop
    TabOrder = 2
    DesignSize = (
      963
      177)
    object lblCliente: TLabel
      Left = 100
      Top = 12
      Width = 42
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblGrupoOcorrencia: TLabel
      Left = 25
      Top = 34
      Width = 117
      Height = 14
      Caption = 'Grupo de Ocorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblComplemento: TLabel
      Left = 60
      Top = 56
      Width = 82
      Height = 14
      Caption = 'Complemento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUsuario: TLabel
      Left = 97
      Top = 79
      Width = 45
      Height = 14
      Caption = 'Usu'#225'rio:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRecorrencia: TLabel
      Left = 73
      Top = 103
      Width = 69
      Height = 14
      Caption = 'Recorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblIntervaloRecorrencia: TLabel
      Left = 5
      Top = 123
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Caption = 'Intervalo de Recorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblOcorrencias: TLabel
      Left = 539
      Top = 124
      Width = 58
      Height = 14
      Caption = 'ocorr'#234'ncias'
    end
    object lblTipo: TLabel
      Left = 553
      Top = 14
      Width = 107
      Height = 14
      Caption = 'Tipo de Ocorr'#234'ncia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSituacao: TLabel
      Left = 613
      Top = 34
      Width = 49
      Height = 14
      Caption = 'Situa'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPeriodoInclusao: TLabel
      Left = 550
      Top = 56
      Width = 112
      Height = 14
      Caption = 'Per'#237'odo de Inclus'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPeriodoAgendamento: TLabel
      Left = 518
      Top = 82
      Width = 144
      Height = 14
      Caption = 'Per'#237'odo de Agendamento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAte1: TLabel
      Left = 743
      Top = 56
      Width = 17
      Height = 14
      Caption = 'at'#233
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAte2: TLabel
      Left = 743
      Top = 79
      Width = 17
      Height = 14
      Caption = 'at'#233
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 146
      Top = 8
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Left = 231
      Top = 8
      Width = 280
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCodGoc: TEditFocus
      Tag = 99
      Left = 146
      Top = 31
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodGocExit
      OnKeyPress = edtCodGocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesGoc: TEditFocus
      Left = 219
      Top = 31
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCoc: TEditFocus
      Tag = 99
      Left = 146
      Top = 54
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 4
      OnExit = edtCodCocExit
      OnKeyPress = edtCodCocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCoc: TEditFocus
      Left = 219
      Top = 54
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 146
      Top = 77
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 6
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 219
      Top = 77
      Width = 292
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object cxCheckDiario: TcxCheckBox
      Left = 142
      Top = 101
      Caption = 'Di'#225'rio'
      TabOrder = 8
      Transparent = True
    end
    object cxCheckSemanal: TcxCheckBox
      Left = 233
      Top = 101
      Caption = 'Semanal'
      TabOrder = 9
      Transparent = True
    end
    object cxCheckMensal: TcxCheckBox
      Left = 349
      Top = 100
      Caption = 'Mensal'
      TabOrder = 10
      Transparent = True
    end
    object cxCheckAnual: TcxCheckBox
      Left = 460
      Top = 99
      Caption = 'Anual'
      TabOrder = 11
      Transparent = True
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 236
      Top = 121
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 13
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cxCheckTerminaEm: TcxCheckBox
      Left = 142
      Top = 121
      Caption = 'Termina em:'
      TabOrder = 12
      Transparent = True
    end
    object edtNroOcoTer: TEditFocus
      Tag = 99
      Left = 464
      Top = 121
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object cxCheckSemDataTermino: TcxCheckBox
      Left = 663
      Top = 121
      Caption = 'Sem data de T'#233'rmino'
      TabOrder = 16
      Transparent = True
    end
    object edtCodToc: TEditFocus
      Tag = 99
      Left = 666
      Top = 8
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 17
      OnExit = edtCodTocExit
      OnKeyPress = edtCodTocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesToc: TEditFocus
      Left = 739
      Top = 8
      Width = 214
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
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
    object mskDtaIncIni: TMaskEditFocus
      Tag = 99
      Left = 666
      Top = 54
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 21
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaIncFim: TMaskEditFocus
      Tag = 99
      Left = 770
      Top = 54
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 22
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaAgeIni: TMaskEditFocus
      Tag = 99
      Left = 666
      Top = 77
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 23
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaAgeFim: TMaskEditFocus
      Tag = 99
      Left = 770
      Top = 77
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 24
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object cxCheckTerminaApos: TcxCheckBox
      Left = 349
      Top = 121
      Caption = 'Termina ap'#243's:'
      TabOrder = 14
      Transparent = True
    end
    object btnConfirmaConsulta: TBitBtnLocked
      Left = 832
      Top = 146
      Width = 125
      Height = 25
      Caption = 'Confirma'
      TabOrder = 25
      OnClick = btnConfirmaConsultaClick
    end
    object edtCodSit: TEditFocus
      Tag = 99
      Left = 666
      Top = 31
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 19
      OnExit = edtCodSitExit
      OnKeyPress = edtCodSitKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesSitOco: TEditFocus
      Left = 739
      Top = 31
      Width = 214
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 20
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cxCheckRecFinalizadas: TcxCheckBox
      Left = 142
      Top = 142
      Caption = 'Exibir Recorr'#234'ncias Finalizadas'
      TabOrder = 26
      Transparent = True
    end
  end
  object pnlPrincipal: TPanel [3]
    Left = 0
    Top = 177
    Width = 963
    Height = 354
    Align = alClient
    TabOrder = 3
    object lblLegenda: TLabel
      Left = 1
      Top = 333
      Width = 961
      Height = 20
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Utilize a tecla [ENTER] para selecionar um item na tela'
      Layout = tlCenter
      ExplicitLeft = 2
      ExplicitTop = 155
      ExplicitWidth = 1014
    end
    object cxGridCitelRecorrencia: TcxGridCitel
      Left = 1
      Top = 1
      Width = 961
      Height = 332
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridCitelRecorrenciaView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridCitelRecorrenciaViewCustomDrawCell
        DataController.DataSource = dtsRecorrencia
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
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridCitelRecorrenciaViewDESC_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'DESC_STATUS'
          Width = 117
        end
        object cxGridCitelRecorrenciaViewCLIENTE: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CLIENTE'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewDTAINC: TcxGridDBColumn
          Caption = 'Data/Hora Inclus'#227'o'
          DataBinding.FieldName = 'DTAINC'
          Options.Editing = False
          Width = 124
        end
        object cxGridCitelRecorrenciaViewDTAINI: TcxGridDBColumn
          Caption = 'Data Inicial'
          DataBinding.FieldName = 'DTAINI'
        end
        object cxGridCitelRecorrenciaViewDTAAGE: TcxGridDBColumn
          Caption = 'Data/Hora Agendamento'
          DataBinding.FieldName = 'DTAAGE'
          Options.Editing = False
          Width = 145
        end
        object cxGridCitelRecorrenciaViewGRPOCO: TcxGridDBColumn
          Caption = 'Grupo de Ocorr'#234'ncia'
          DataBinding.FieldName = 'GRPOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewTIPOCO: TcxGridDBColumn
          Caption = 'Tipo'
          DataBinding.FieldName = 'TIPOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewCMPOCO: TcxGridDBColumn
          Caption = 'Complemento'
          DataBinding.FieldName = 'CMPOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewSITOCO: TcxGridDBColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'SITOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewNOMOPE: TcxGridDBColumn
          Caption = 'Usu'#225'rio'
          DataBinding.FieldName = 'NOMOPE'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewRECOCO: TcxGridDBColumn
          Caption = 'Recorr'#234'ncia'
          DataBinding.FieldName = 'RECOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewITVOCO: TcxGridDBColumn
          Caption = 'Intervalo de Recorr'#234'ncia'
          DataBinding.FieldName = 'ITVOCO'
          Options.Editing = False
        end
        object cxGridCitelRecorrenciaViewMARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MARDES'
          Visible = False
        end
        object cxGridCitelRecorrenciaViewSTATUS: TcxGridDBColumn
          DataBinding.FieldName = 'STATUS'
          Visible = False
        end
      end
      object cxGridCitelRecorrenciaLevel1: TcxGridLevel
        GridView = cxGridCitelRecorrenciaView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 884
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 884
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 888
    Top = 388
  end
  object cdsRecorrencia: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CLIENTE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'DTAINC'
        DataType = ftDateTime
      end
      item
        Name = 'DTAAGE'
        DataType = ftDateTime
      end
      item
        Name = 'GRPOCO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TIPOCO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CMPOCO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'SITOCO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMOPE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'RECOCO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ITVOCO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'MARDES'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPREC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPITV'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTAINI'
        DataType = ftDateTime
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESC_STATUS'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 260
    Top = 281
    object cdsRecorrenciaCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 50
    end
    object cdsRecorrenciaDTAINC: TDateTimeField
      FieldName = 'DTAINC'
    end
    object cdsRecorrenciaDTAAGE: TDateTimeField
      FieldName = 'DTAAGE'
    end
    object cdsRecorrenciaGRPOCO: TStringField
      FieldName = 'GRPOCO'
      Size = 40
    end
    object cdsRecorrenciaTIPOCO: TStringField
      FieldName = 'TIPOCO'
      Size = 40
    end
    object cdsRecorrenciaCMPOCO: TStringField
      DisplayWidth = 40
      FieldName = 'CMPOCO'
      Size = 40
    end
    object cdsRecorrenciaSITOCO: TStringField
      DisplayWidth = 40
      FieldName = 'SITOCO'
      Size = 40
    end
    object cdsRecorrenciaNOMOPE: TStringField
      DisplayWidth = 40
      FieldName = 'NOMOPE'
      Size = 40
    end
    object cdsRecorrenciaRecorrencia: TStringField
      FieldName = 'RECOCO'
    end
    object cdsRecorrenciaITVOCO: TStringField
      FieldName = 'ITVOCO'
      Size = 30
    end
    object cdsRecorrenciaMARDES: TStringField
      FieldName = 'MARDES'
    end
    object cdsRecorrenciaAUTINC: TStringField
      DisplayWidth = 30
      FieldName = 'AUTINC'
    end
    object cdsRecorrenciaTIPREC: TStringField
      FieldName = 'TIPREC'
    end
    object cdsRecorrenciaTIPITV: TStringField
      FieldName = 'TIPITV'
    end
    object cdsRecorrenciaDTAINI: TDateTimeField
      FieldName = 'DTAINI'
    end
    object cdsRecorrenciaSTATUS: TStringField
      FieldName = 'STATUS'
    end
    object cdsRecorrenciaDESC_STATUS: TStringField
      FieldName = 'DESC_STATUS'
    end
  end
  object dtsRecorrencia: TDataSource
    DataSet = cdsRecorrencia
    Left = 368
    Top = 281
  end
end
