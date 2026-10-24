inherited frmFatRomaneioManutencao: TfrmFatRomaneioManutencao
  Width = 1053
  Height = 565
  Caption = 'Lote de Separa'#231#227'o para Romaneios - Manuten'#231#227'o'
  WindowState = wsMaximized
  ExplicitWidth = 1053
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 492
    Width = 1047
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 492
    ExplicitWidth = 1047
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 1045
      Height = 26
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 1045
      ExplicitHeight = 26
      object btnTrocar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 160
        Height = 23
        Align = alLeft
        Caption = '[F5] Trocar lote de separa'#231#227'o'
        TabOrder = 0
        OnClick = btnTrocarClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 160
        Top = 0
        Width = 98
        Height = 23
        Align = alLeft
        Caption = '[F6] Imprimir'
        TabOrder = 1
        OnClick = btnImprimirClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 258
        Top = 0
        Width = 110
        Height = 23
        Align = alLeft
        Caption = '[F7] Marcar Todos'
        TabOrder = 2
        OnClick = btnMarTodosClick
      end
      object btnDesmarTodos: TBitBtnLocked
        Left = 368
        Top = 0
        Width = 118
        Height = 23
        Align = alLeft
        Caption = '[F8] Desmarcar Todos'
        TabOrder = 3
        OnClick = btnDesmarTodosClick
      end
      object btnDefRota: TBitBtnLocked
        Left = 486
        Top = 0
        Width = 107
        Height = 23
        Align = alLeft
        Caption = '[F9] Definir Rota'
        TabOrder = 4
        OnClick = btnDefRotaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 964
      ExplicitLeft = 964
    end
  end
  inherited pnlStatus: TPanel
    Top = 520
    Width = 1047
    TabOrder = 4
    ExplicitTop = 520
    ExplicitWidth = 1047
    inherited pnlNomeForm: TPanel
      Left = 876
      ExplicitLeft = 876
    end
    inherited pnlInfo: TPanel
      Width = 876
      ExplicitWidth = 876
    end
  end
  object pnlFiltro: TPanel [3]
    Left = 0
    Top = 0
    Width = 1047
    Height = 60
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblNumLot: TLabel
      Left = 56
      Top = 5
      Width = 122
      Height = 14
      Caption = 'N'#186' do Lote de Separa'#231#227'o'
    end
    object Label2: TLabel
      Left = 231
      Top = 17
      Width = 241
      Height = 33
      AutoSize = False
      Caption = 
        'Digite o n'#250'mero do lote e pressione [Enter] para carregar os doc' +
        'umentos do Lote de Separa'#231#227'o'
      WordWrap = True
    end
    object edtNumLot: TEditFocus
      Left = 16
      Top = 22
      Width = 202
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttNumerico
    end
  end
  object pnlObservacao: TPanel [4]
    Left = 0
    Top = 426
    Width = 1047
    Height = 48
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label5: TLabel
      Left = 20
      Top = 10
      Width = 84
      Height = 28
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es do Documento:'
      WordWrap = True
    end
    object edtObs1: TEditFocus
      Left = 112
      Top = 2
      Width = 933
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtObs2: TEditFocus
      Left = 112
      Top = 24
      Width = 933
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgDocumentos: TcxGrid [5]
    Left = 0
    Top = 60
    Width = 1047
    Height = 366
    Align = alClient
    TabOrder = 1
    object cxgDocumentosDBTableView: TcxGridDBTableView
      OnKeyPress = cxgDocumentosDBTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosDBTableViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object cxgDocumentosNUMLOT: TcxGridDBColumn
        Caption = 'N'#186' do Lote de Separa'#231#227'o'
        DataBinding.FieldName = 'NUMLOT'
        Width = 128
      end
      object cxgDocumentosDTAENT: TcxGridDBColumn
        Caption = 'Data Entrada'
        DataBinding.FieldName = 'DTAENT'
        Width = 68
      end
      object cxgDocumentosHORENT: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'HORENT'
      end
      object cxgDocumentosDTENTR: TcxGridDBColumn
        Caption = 'Data Entrega'
        DataBinding.FieldName = 'DTENTR'
        Width = 80
      end
      object cxgDocumentosTURNO: TcxGridDBColumn
        Caption = 'Turno'
        DataBinding.FieldName = 'TURNO'
      end
      object cxgDocumentosNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
      end
      object cxgDocumentosESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
      end
      object cxgDocumentosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
      end
      object cxgDocumentosNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
      end
      object cxgDocumentosNUMFAT: TcxGridDBColumn
        Caption = 'Doc. Faturamento'
        DataBinding.FieldName = 'NUMFAT'
        Width = 91
      end
      object cxgDocumentosDESREG: TcxGridDBColumn
        Caption = 'Regi'#227'o'
        DataBinding.FieldName = 'DESREG'
      end
      object cxgDocumentosNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'NOMCID'
      end
      object cxgDocumentosCEPENT: TcxGridDBColumn
        Caption = 'CEP'
        DataBinding.FieldName = 'CEPENT'
        OnGetDataText = cxgDocumentosCEPENTGetDataText
      end
      object cxgDocumentosBAIENT: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'BAIENT'
      end
      object cxgDocumentosENDENT: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDENT'
      end
      object cxgDocumentosPESBRU: TcxGridDBColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'PESBRU'
      end
      object cxgDocumentosDESFPG: TcxGridDBColumn
        Caption = 'Forma de Pagamento'
        DataBinding.FieldName = 'DESFPG'
        Width = 107
      end
      object cxgDocumentosNOMTRA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'NOMTRA'
        Width = 81
      end
      object cxgDocumentosVLRCON: TcxGridDBColumn
        Caption = 'Vr. do Documento'
        DataBinding.FieldName = 'VLRCON'
        Width = 92
      end
      object cxgDocumentosCODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CODVEN'
      end
      object cxgDocumentosMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosDBTableView
    end
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 474
    Width = 1047
    Height = 18
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    ShowCaption = False
    TabOrder = 6
    object lblMarca: TLabel
      Left = 3
      Top = 1
      Width = 217
      Height = 14
      Caption = '[ESPA'#199'O] Marca / Desmarca Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 800
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 760
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 720
    Top = 8
  end
end
