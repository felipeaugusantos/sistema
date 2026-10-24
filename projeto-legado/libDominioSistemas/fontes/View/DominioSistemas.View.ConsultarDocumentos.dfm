inherited frmDominioSistemasConsultarDocumentos: TfrmDominioSistemasConsultarDocumentos
  Width = 1090
  Height = 529
  Caption = 'Consultar Documentos'
  ExplicitWidth = 1090
  ExplicitHeight = 529
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 458
    Width = 1084
    TabOrder = 2
    ExplicitTop = 458
    ExplicitWidth = 1084
    inherited FlwBotoes: TFlowPanel
      Width = 1080
      ExplicitWidth = 1080
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
      object btnExportar: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 75
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
        ShowHint = False
        TabOrder = 1
        OnClick = btnExportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1004
      Caption = '&Fechar'
      ExplicitLeft = 1004
    end
  end
  inherited pnlStatus: TPanel
    Top = 484
    Width = 1084
    TabOrder = 3
    ExplicitTop = 484
    ExplicitWidth = 1084
    inherited pnlNomeForm: TPanel
      Left = 913
      ExplicitLeft = 913
    end
    inherited pnlInfo: TPanel
      Width = 913
      ExplicitWidth = 913
    end
  end
  object gbFiltros: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 1084
    Height = 81
    Align = alTop
    Caption = 'Filtros'
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 21
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo Dta. Doc.:'
    end
    object lblCodEmp: TLabel
      Left = 52
      Top = 48
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 106
      Top = 17
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 182
      Top = 17
      Width = 72
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 106
      Top = 45
      Width = 57
      Height = 22
      Hint = 'Tecle / para selecionar varias empresas'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 166
      Top = 45
      Width = 378
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object btnConsultar: TBitBtnLocked
      Left = 548
      Top = 44
      Width = 103
      Height = 25
      Caption = 'C&onsultar'
      TabOrder = 4
      OnClick = btnConsultarClick
    end
  end
  object GridCitel: TcxGridCitel [3]
    Left = 0
    Top = 81
    Width = 1084
    Height = 377
    Align = alClient
    Enabled = False
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object TableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsConsulta
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
      OptionsView.Indicator = True
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object TableViewAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
      end
      object TableViewDOM_TIPCON: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'DOM_TIPCON'
        Options.Editing = False
        Width = 67
      end
      object TableViewFIS_NUMDOC: TcxGridDBColumn
        Caption = 'N'#186' Doc.'
        DataBinding.FieldName = 'FIS_NUMDOC'
        Options.Editing = False
        Width = 150
      end
      object TableViewDOM_DTADOC: TcxGridDBColumn
        Caption = 'Data Doc.'
        DataBinding.FieldName = 'DOM_DTADOC'
        Options.Editing = False
        Width = 127
      end
      object TableViewFIS_SERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie Doc.'
        DataBinding.FieldName = 'FIS_SERIE_'
        Options.Editing = False
        Width = 94
      end
      object TableViewFIS_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie Doc.'
        DataBinding.FieldName = 'FIS_ESPDOC'
        Options.Editing = False
        Width = 82
      end
      object TableViewFIS_FORCLI: TcxGridDBColumn
        Caption = 'Cliente/Fornecedor Doc.'
        DataBinding.FieldName = 'FIS_FORCLI'
        Options.Editing = False
        Width = 153
      end
      object TableViewDOM_TIP_FC: TcxGridDBColumn
        Caption = 'F/C'
        DataBinding.FieldName = 'DOM_TIP_FC'
        Options.Editing = False
      end
      object TableViewDOM_CODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo Empresa'
        DataBinding.FieldName = 'DOM_CODEMP'
        Options.Editing = False
        Width = 104
      end
      object TableViewEMP_NOMFAN: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_NOMFAN'
        Options.Editing = False
        Width = 266
      end
      object TableViewDOM_ACESSO: TcxGridDBColumn
        Caption = 'Chave Acesso'
        DataBinding.FieldName = 'DOM_ACESSO'
        Options.Editing = False
        Width = 304
      end
      object TableViewDOM_CODOPE: TcxGridDBColumn
        Caption = 'Operador Proc.'
        DataBinding.FieldName = 'DOM_CODOPE'
        Options.Editing = False
        Width = 88
      end
      object TableViewDOM_DTPROC: TcxGridDBColumn
        Caption = 'Data Proc.'
        DataBinding.FieldName = 'DOM_DTPROC'
        Options.Editing = False
        Width = 119
      end
      object TableViewDOM_HRPROC: TcxGridDBColumn
        Caption = 'Hora Proc.'
        DataBinding.FieldName = 'DOM_HRPROC'
        Options.Editing = False
        Width = 117
      end
      object TableViewDOM_PROTOC: TcxGridDBColumn
        Caption = 'Protocolo Proc.'
        DataBinding.FieldName = 'DOM_PROTOC'
        Options.Editing = False
        Width = 264
      end
      object TableViewDOM_STATUS: TcxGridDBColumn
        Caption = 'Status Dom'#237'nio'
        DataBinding.FieldName = 'DOM_STATUS'
        Options.Editing = False
        Width = 600
      end
      object TableViewDOM_STATNF: TcxGridDBColumn
        Caption = 'Status Doc.'
        DataBinding.FieldName = 'DOM_STATNF'
        Options.Editing = False
        Width = 83
      end
    end
    object GridCitelLevel1: TcxGridLevel
      GridView = TableView
    end
  end
  object dsConsulta: TDataSource
    AutoEdit = False
    Left = 392
    Top = 64
  end
end
