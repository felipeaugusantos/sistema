inherited frmFatLotePedRom: TfrmFatLotePedRom
  Width = 803
  Height = 468
  Caption = 'WMS - Separa'#231#227'o por Lote de Pedidos para Romaneio'
  ExplicitWidth = 803
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 397
    Width = 797
    TabOrder = 4
    ExplicitTop = 397
    ExplicitWidth = 797
    inherited FlwBotoes: TFlowPanel
      Width = 793
      ExplicitWidth = 793
      inherited btnConfirma: TBitBtnLocked
        Width = 97
        Caption = '[F10] Confirmar'
        Glyph.Data = {00000000}
        ModalResult = 0
        ExplicitWidth = 97
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 714
      Caption = 'C&ancelar'
      ExplicitLeft = 714
    end
  end
  inherited pnlStatus: TPanel
    Top = 423
    Width = 797
    TabOrder = 5
    ExplicitTop = 423
    ExplicitWidth = 797
    inherited pnlNomeForm: TPanel
      Left = 626
      ExplicitLeft = 626
    end
    inherited pnlInfo: TPanel
      Width = 626
      ExplicitWidth = 626
    end
  end
  object pnlNumLot: TPanel [2]
    Left = 0
    Top = 0
    Width = 797
    Height = 57
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblLote: TLabel
      Left = 5
      Top = 31
      Width = 95
      Height = 14
      Caption = 'Lote de Separa'#231#227'o:'
    end
    object lblEmpresa: TLabel
      Left = 54
      Top = 8
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtCodLot: TEditFocus
      Tag = 99
      Left = 102
      Top = 28
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtCodLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttInteiro
    end
    object edtDesLot: TEditFocus
      Left = 164
      Top = 28
      Width = 489
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 102
      Top = 5
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomEmp: TEditFocus
      Left = 164
      Top = 5
      Width = 489
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 57
    Width = 797
    Height = 61
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblQtdDocDes: TLabel
      Left = 5
      Top = 8
      Width = 136
      Height = 14
      Caption = 'Quantidade de Documentos:'
    end
    object lblQtdDocVlr: TLabel
      Left = 145
      Top = 8
      Width = 30
      Height = 14
      Caption = '99999'
      Visible = False
    end
    object lblPesBruDes: TLabel
      Left = 60
      Top = 28
      Width = 81
      Height = 14
      Caption = 'Peso Total Bruto:'
    end
    object lblPesBruVlr: TLabel
      Left = 145
      Top = 28
      Width = 27
      Height = 14
      Caption = '0,000'
      Visible = False
    end
    object lblQtdProDes: TLabel
      Left = 480
      Top = 23
      Width = 119
      Height = 14
      Caption = 'Quantidade de Produtos:'
    end
    object lblQtdProVlr: TLabel
      Left = 602
      Top = 23
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = '0000,0000'
      Visible = False
    end
    object lblPesLiqDes: TLabel
      Left = 510
      Top = 43
      Width = 89
      Height = 14
      Caption = 'Peso Total L'#237'quido:'
    end
    object lblPesLiqVlr: TLabel
      Left = 626
      Top = 43
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = '0,000'
      Visible = False
    end
    object lblProDisDes: TLabel
      Left = 436
      Top = 5
      Width = 163
      Height = 14
      Caption = 'Quantidade de Produtos Distintos:'
    end
    object lblProDisVlr: TLabel
      Left = 602
      Top = 5
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = '0000,0000'
      Visible = False
    end
  end
  object Panel3: TPanel [4]
    Left = 0
    Top = 118
    Width = 797
    Height = 35
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblSequencia: TLabel
      Left = 6
      Top = 7
      Width = 135
      Height = 14
      Caption = 'Quantidade de Sequenciais:'
    end
    object edtSequencia: TEditFocus
      Tag = 99
      Left = 145
      Top = 4
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtSequenciaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object btnSequencia: TBitBtnLocked
      Left = 578
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Confirmar'
      TabOrder = 1
      OnClick = btnSequenciaClick
    end
  end
  object Panel4: TPanel [5]
    Left = 0
    Top = 153
    Width = 797
    Height = 244
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grdLoteSep: TcxGrid
      Left = 0
      Top = 0
      Width = 797
      Height = 244
      Align = alClient
      TabOrder = 0
      object grdLoteSepDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnEditKeyPress = grdLoteSepDBTableViewEditKeyPress
        DataController.DataSource = dtsLoteSep
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdLoteSepDBTableViewSEQSEP: TcxGridDBColumn
          Caption = 'Sequencial de Separa'#231#227'o'
          DataBinding.FieldName = 'SEQSEP'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Focusing = False
          Options.Moving = False
          Options.Sorting = False
          Width = 135
        end
        object grdLoteSepDBTableViewCODSEP: TcxGridDBColumn
          Caption = 'Separador'
          DataBinding.FieldName = 'CODSEP'
          HeaderAlignmentHorz = taCenter
          MinWidth = 3
          Options.Moving = False
          Options.Sorting = False
          Width = 65
        end
        object grdLoteSepDBTableViewOPESEP: TcxGridDBColumn
          Caption = 'Opera'#231#245'es'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Alterar Separador'
              Default = True
              Kind = bkText
            end
            item
              Caption = 'Imprimir Separa'#231#227'o'
              Kind = bkText
            end
            item
              Caption = 'Limpar Separa'#231#227'o'
              Kind = bkText
            end>
          Properties.ClickKey = 0
          Properties.ValidationOptions = []
          Properties.ViewStyle = vsButtonsAutoWidth
          Properties.OnButtonClick = grdLoteSepDBTableViewOPESEPPropertiesButtonClick
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.Moving = False
          Options.Sorting = False
          Width = 450
        end
      end
      object grdLoteSepLevel1: TcxGridLevel
        GridView = grdLoteSepDBTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 816
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 872
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 856
    Top = 16
  end
  object cdsLoteSep: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsLoteSepBeforePost
    Left = 480
    Top = 228
    object cdsLoteSepSEQSEP: TIntegerField
      FieldName = 'SEQSEP'
    end
    object cdsLoteSepCODSEP: TStringField
      FieldName = 'CODSEP'
      Size = 3
    end
  end
  object dtsLoteSep: TDataSource
    DataSet = cdsLoteSep
    Left = 544
    Top = 228
  end
  object cdsDefineLote: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 204
    object cdsDefineLoteCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsDefineLoteDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDefineLoteQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsDefineLoteNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 1000
    end
    object cdsDefineLoteNUMLOT: TStringField
      FieldName = 'NUMLOT'
    end
    object cdsDefineLoteCODSEP: TStringField
      FieldName = 'CODSEP'
      Size = 3
    end
    object cdsDefineLoteSEQSEP: TIntegerField
      FieldName = 'SEQSEP'
    end
    object cdsDefineLoteAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 424
    Top = 300
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 392
    Top = 300
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 360
    Top = 300
  end
end
