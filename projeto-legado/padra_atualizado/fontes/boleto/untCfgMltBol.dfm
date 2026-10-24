inherited frmCfgMltBol: TfrmCfgMltBol
  Width = 849
  Height = 444
  Caption = 'Configura'#231#227'o - Impress'#227'o de Boletos M'#250'ltiplos Bancos'
  Position = poMainFormCenter
  ExplicitWidth = 849
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 371
    Width = 843
    ExplicitTop = 371
    ExplicitWidth = 843
    inherited FlwBotoes: TFlowPanel
      Left = 77
      Width = 687
      ExplicitLeft = 77
      ExplicitWidth = 687
    end
    inherited btnSair: TBitBtnLocked
      Left = 764
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 764
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 75
      Height = 24
      Align = alLeft
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 399
    Width = 843
    ExplicitTop = 399
    ExplicitWidth = 843
    inherited pnlNomeForm: TPanel
      Left = 672
      ExplicitLeft = 672
    end
    inherited pnlInfo: TPanel
      Width = 672
      ExplicitWidth = 672
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 843
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label4: TLabel
      Left = 43
      Top = 104
      Width = 31
      Height = 14
      Caption = 'Prazo:'
    end
    object btnAdicionar: TBitBtnLocked
      Left = 142
      Top = 101
      Width = 108
      Height = 22
      Caption = 'Adicionar'
      TabOrder = 3
      OnClick = btnAdicionarClick
    end
    object edtQtdDia: TEditFocus
      Tag = 99
      Left = 79
      Top = 101
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object btnCancel: TBitBtnLocked
      Left = 250
      Top = 101
      Width = 108
      Height = 22
      Caption = 'Cancelar'
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object gbNF: TGroupBox
      Left = 6
      Top = 8
      Width = 391
      Height = 88
      Caption = 'NF/IF'
      TabOrder = 0
      object Label5: TLabel
        Left = 28
        Top = 17
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label3: TLabel
        Left = 38
        Top = 40
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object Label6: TLabel
        Left = 31
        Top = 62
        Width = 41
        Height = 14
        Caption = 'Carteira:'
      end
      object edtCodPorNF: TEditFocus
        Tag = 99
        Left = 75
        Top = 13
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodPorNFKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomPorNF: TEditFocus
        Left = 132
        Top = 13
        Width = 254
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodBcoNF: TEditFocus
        Tag = 99
        Left = 75
        Top = 36
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodBcoNFExit
        OnKeyPress = edtCodBcoNFKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomBanNF: TEditFocus
        Left = 132
        Top = 36
        Width = 254
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCarteiNF: TEditFocus
        Tag = 99
        Left = 75
        Top = 59
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 4
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
    object gbFF: TGroupBox
      Left = 401
      Top = 8
      Width = 399
      Height = 88
      Caption = 'FF'
      TabOrder = 1
      object Label1: TLabel
        Left = 28
        Top = 17
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label2: TLabel
        Left = 38
        Top = 40
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object Label7: TLabel
        Left = 31
        Top = 62
        Width = 41
        Height = 14
        Caption = 'Carteira:'
      end
      object edtCodPorFF: TEditFocus
        Tag = 99
        Left = 75
        Top = 13
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodPorFFKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomPorFF: TEditFocus
        Left = 132
        Top = 13
        Width = 254
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodBcoFF: TEditFocus
        Tag = 99
        Left = 75
        Top = 36
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodBcoFFExit
        OnKeyPress = edtCodBcoFFKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomBanFF: TEditFocus
        Left = 132
        Top = 36
        Width = 254
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCarteiFF: TEditFocus
        Tag = 99
        Left = 75
        Top = 59
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 4
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
  end
  object dbgBancos: TcxGrid [3]
    Left = 0
    Top = 129
    Width = 843
    Height = 242
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgBancosDBTableView1: TcxGridDBTableView
      OnKeyDown = dbgBancosDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgBancosDBTableView1CustomDrawCell
      DataController.DataSource = dtsMltBol
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object dbgBancosDBTableView1CODPOR: TcxGridDBColumn
        Caption = 'C'#243'd. Por.'
        DataBinding.FieldName = 'CODPOR'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 50
      end
      object dbgBancosDBTableView1DESPOR: TcxGridDBColumn
        Caption = 'Portador NF/IF'
        DataBinding.FieldName = 'DESPOR'
        Width = 124
      end
      object dbgBancosDBTableView1CODBCO: TcxGridDBColumn
        Caption = 'C'#243'd. Bco'
        DataBinding.FieldName = 'CODBCO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 50
      end
      object dbgBancosDBTableView1DESBCO: TcxGridDBColumn
        Caption = 'Banco NF/IF'
        DataBinding.FieldName = 'DESBCO'
        Width = 125
      end
      object dbgBancosDBTableView1CARTEI: TcxGridDBColumn
        Caption = 'Cart. NF'
        DataBinding.FieldName = 'CARTEI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 50
      end
      object dbgBancosDBTableView1POR_FF: TcxGridDBColumn
        Caption = 'C'#243'd. Por.'
        DataBinding.FieldName = 'POR_FF'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 50
      end
      object dbgBancosDBTableView1PODEFF: TcxGridDBColumn
        Caption = 'Portador FF'
        DataBinding.FieldName = 'PODEFF'
        Width = 124
      end
      object dbgBancosDBTableView1BCO_FF: TcxGridDBColumn
        Caption = 'C'#243'd. Bco'
        DataBinding.FieldName = 'BCO_FF'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 50
      end
      object dbgBancosDBTableView1BCDEFF: TcxGridDBColumn
        Caption = 'Banco FF'
        DataBinding.FieldName = 'BCDEFF'
        Width = 120
      end
      object dbgBancosDBTableView1CAR_FF: TcxGridDBColumn
        Caption = 'Cart. FF'
        DataBinding.FieldName = 'CAR_FF'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = False
        Width = 47
      end
      object dbgBancosDBTableView1QTDDIA: TcxGridDBColumn
        Caption = 'Prazo'
        DataBinding.FieldName = 'QTDDIA'
        Width = 34
      end
    end
    object dbgBancosLevel1: TcxGridLevel
      GridView = dbgBancosDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
    Top = 84
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 588
    Top = 80
  end
  object dtsMltBol: TDataSource
    Left = 356
    Top = 216
  end
end
