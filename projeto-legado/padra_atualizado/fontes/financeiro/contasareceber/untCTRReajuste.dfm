inherited frmCTRReajuste: TfrmCTRReajuste
  Width = 835
  Height = 499
  BorderStyle = bsSizeable
  Caption = 'Reajuste de Financiamento'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 835
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 416
    Width = 819
    TabOrder = 1
    ExplicitTop = 416
    ExplicitWidth = 819
    inherited FlwBotoes: TFlowPanel
      Width = 815
      TabOrder = 0
      ExplicitTop = 2
      ExplicitWidth = 815
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 739
      Top = 2
      TabOrder = 1
      ExplicitLeft = 739
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 444
    Width = 819
    TabOrder = 2
    ExplicitTop = 444
    ExplicitWidth = 819
    inherited pnlNomeForm: TPanel
      Left = 648
      ExplicitLeft = 648
    end
    inherited pnlInfo: TPanel
      Width = 648
      ExplicitWidth = 648
    end
  end
  object cxDados: TcxGridCitel [3]
    Left = 0
    Top = 135
    Width = 819
    Height = 281
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
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
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxDadosTableViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CTR_CODCLI'
        Width = 86
      end
      object cxDadosTableViewColumn2: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 231
      end
      object cxDadosTableViewColumn3: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUME'
        Width = 124
      end
      object cxDadosTableViewColumn4: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CTR_CODEMP'
        Width = 37
      end
      object cxDadosTableViewColumn5: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Width = 72
      end
      object cxDadosTableViewColumn9: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'NOMPOR'
        Width = 199
      end
      object cxDadosTableViewColumn6: TcxGridDBColumn
        Caption = #218'ltimo Reajuste'
        DataBinding.FieldName = 'CTR_ULTRIN'
        Width = 86
      end
      object cxDadosTableViewColumn7: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTR_VALDUP'
        Width = 74
      end
      object cxDadosTableViewColumn8: TcxGridDBColumn
        Caption = 'Valor Corrigido'
        DataBinding.FieldName = 'CTR_VALAJU'
        Width = 90
      end
    end
    object cxDadosLevel: TcxGridLevel
      GridView = cxDadosTableView
    end
  end
  object pnlTopo: TPanel [4]
    Left = 0
    Top = 0
    Width = 819
    Height = 135
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 6
      Width = 147
      Height = 14
      Caption = 'A partir da data de vencimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblPortador: TLabel
      Left = 8
      Top = 87
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 397
      Top = 47
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
    object lbl5: TLabel
      Left = 8
      Top = 47
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 397
      Top = 87
      Width = 114
      Height = 14
      Caption = 'Percentual de Corre'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 23
      Width = 64
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
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 8
      Top = 104
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 75
      Top = 104
      Width = 319
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 397
      Top = 62
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 463
      Top = 62
      Width = 333
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Left = 8
      Top = 62
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 1
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
      Left = 75
      Top = 62
      Width = 319
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFator: TEditFocus
      Tag = 99
      Left = 397
      Top = 104
      Width = 70
      Height = 22
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 75
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 11
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 35
  end
end
