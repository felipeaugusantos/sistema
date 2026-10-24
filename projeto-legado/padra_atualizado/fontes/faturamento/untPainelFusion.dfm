inherited frmPainelFusion: TfrmPainelFusion
  Width = 1000
  Height = 500
  Caption = 'Painel Fusion'
  Position = poScreenCenter
  ExplicitWidth = 1000
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 994
    ExplicitTop = 427
    ExplicitWidth = 994
    inherited FlwBotoes: TFlowPanel
      Width = 990
      ExplicitWidth = 990
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      ExplicitLeft = 914
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 994
    ExplicitTop = 455
    ExplicitWidth = 994
    inherited pnlNomeForm: TPanel
      Left = 823
      ExplicitLeft = 823
    end
    inherited pnlInfo: TPanel
      Width = 823
      ExplicitWidth = 823
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 994
    Height = 108
    Align = alTop
    TabOrder = 2
    object lblStatus: TLabel
      Left = 70
      Top = 84
      Width = 34
      Height = 14
      Caption = 'Status:'
    end
    object lblEmissaoDoPedido: TLabel
      Left = 11
      Top = 61
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o do Pedido:'
    end
    object lblA: TLabel
      Left = 183
      Top = 61
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object lblEmp: TLabel
      Left = 15
      Top = 37
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emp. Faturamento:'
    end
    object lblPedido: TLabel
      Left = 69
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido:'
    end
    object lblEmpresa: TLabel
      Left = 191
      Top = 13
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object btnCarregar: TBitBtnLocked
      Left = 515
      Top = 78
      Width = 136
      Height = 22
      Caption = 'Carregar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = btnCarregarClick
    end
    object chkAguardandoEnvio: TCheckBox
      Left = 107
      Top = 83
      Width = 110
      Height = 17
      Caption = 'Aguardando envio'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object chkEnviado: TCheckBox
      Left = 221
      Top = 83
      Width = 60
      Height = 17
      Caption = 'Enviado'
      TabOrder = 8
    end
    object chkRoteirizado: TCheckBox
      Left = 284
      Top = 83
      Width = 80
      Height = 17
      Caption = 'Roteirizado'
      TabOrder = 9
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 107
      Top = 57
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 198
      Top = 57
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEmpFat: TEditFocus
      Tag = 99
      Left = 107
      Top = 33
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 3
      OnExit = edtEmpFatExit
      OnKeyPress = edtEmpFatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpFat: TEditFocus
      Left = 187
      Top = 33
      Width = 464
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 107
      Top = 9
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEmpPed: TEditFocus
      Tag = 99
      Left = 238
      Top = 9
      Width = 79
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnExit = edtEmpPedExit
      OnKeyPress = edtEmpPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpPed: TEditFocus
      Left = 318
      Top = 9
      Width = 333
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
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
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 397
    Width = 994
    Height = 30
    Align = alBottom
    TabOrder = 3
    object btnReenviar: TBitBtnLocked
      Left = 2
      Top = 4
      Width = 136
      Height = 22
      Caption = 'Reenviar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnReenviarClick
    end
    object btnRegrasDeEnvio: TBitBtnLocked
      Left = 144
      Top = 4
      Width = 136
      Height = 22
      Caption = 'Regras de envio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnRegrasDeEnvioClick
    end
  end
  object cxgPedidos: TcxGrid [4]
    Left = 0
    Top = 108
    Width = 994
    Height = 289
    Align = alClient
    TabOrder = 4
    object cxgPedidosDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsPedidos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Total 0'
          Kind = skCount
          FieldName = 'EMPROM'
          Column = cxgPedidosDBTableViewEMPROM
          DisplayText = 'Total'
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum informa'#231#227'o dispon'#237'vel>'
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      object cxgPedidosDBTableViewDOCUMENTO: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'DOCUMENTO'
        Width = 130
      end
      object cxgPedidosDBTableViewEMPDOC: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMPDOC'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 60
      end
      object cxgPedidosDBTableViewDTAEMI: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DTAEMI'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 85
      end
      object cxgPedidosDBTableViewCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Width = 350
      end
      object cxgPedidosDBTableViewEMPFAT: TcxGridDBColumn
        Caption = 'Emp. Fat.'
        DataBinding.FieldName = 'EMPFAT'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 60
      end
      object cxgPedidosDBTableViewSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Width = 100
      end
      object cxgPedidosDBTableViewNUMROM: TcxGridDBColumn
        Caption = 'N'#186' Romaneio'
        DataBinding.FieldName = 'NUMROM'
        Width = 100
      end
      object cxgPedidosDBTableViewEMPROM: TcxGridDBColumn
        Caption = 'Emp. Romaneio'
        DataBinding.FieldName = 'EMPROM'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 85
      end
    end
    object cxgPedidosLevel: TcxGridLevel
      GridView = cxgPedidosDBTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 760
    Top = 200
  end
  object qryPedidos: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 790
    Top = 200
  end
  object dtsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 822
    Top = 200
  end
end
