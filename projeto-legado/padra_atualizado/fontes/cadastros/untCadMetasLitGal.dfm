inherited frmCadMetasLitGal: TfrmCadMetasLitGal
  Left = 304
  Top = 105
  Width = 527
  Height = 653
  ActiveControl = dbgConsulta
  Caption = 'Cadastro de Metas'
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 343
    Width = 519
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  inherited pnlBotoes: TPanel
    Top = 575
    Width = 519
    inherited btnSair: TBitBtn
      Left = 438
    end
    inherited btnMudaOrdem: TBitBtn
      Left = 217
    end
    inherited btnPesquisar: TBitBtn
      Left = 337
    end
    object btnConfirmar: TBitBtn
      Left = 3
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 3
      OnClick = btnConfirmarClick
    end
    object btnCopiarMetas: TBitBtn
      Left = 110
      Top = 3
      Width = 105
      Height = 22
      Caption = '[ F11 ] Copiar Metas'
      TabOrder = 4
      OnClick = btnCopiarMetasClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 603
    Width = 519
    inherited pnlNomeForm: TPanel
      Left = 348
    end
    inherited pnlInfo: TPanel
      Width = 348
    end
  end
  inherited pnlHeader: TPanel
    Width = 519
    Height = 35
    object Label2: TLabel
      Left = 8
      Top = 13
      Width = 97
      Height = 14
      Caption = 'Periodo Atual de: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlMesAnoOrigem: TPanel
      Left = 305
      Top = 0
      Width = 214
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      object Label1: TLabel
        Left = 7
        Top = 11
        Width = 102
        Height = 14
        AutoSize = False
        Caption = 'Per'#237'odo de Origem:'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 1
        Height = 35
        Shape = bsLeftLine
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 103
        Top = 6
        Width = 100
        Height = 22
        EditMask = '99/9999'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        OnExit = mskDtaOrigemExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 107
      Top = 6
      Width = 94
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 1
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlTail: TPanel
    Top = 346
    Width = 519
    Height = 229
    Visible = True
    OnEnter = pnlTailEnter
    OnExit = pnlTailExit
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 75
    Width = 519
    Height = 268
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODVEN'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Vend.'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        ReadOnly = True
        Title.Caption = 'Nome do Vendedor'
        Width = 240
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MET_TOTMET'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor'
        Width = 95
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 35
    Width = 519
  end
  inherited qryConsulta: TUniQuery
    RequestLive = True
    object qryConsultaCODVEN: TStringField
      FieldName = 'MET_CODVEN'
      Size = 3
    end
    object qryConsultaTOTMET: TFloatField
      FieldName = 'MET_TOTMET'
    end
    object qryConsultaNOMVEN: TStringField
      FieldKind = fkLookup
      FieldName = 'OPE_NOMOPE'
      LookupDataSet = qryCadVen
      LookupKeyFields = 'OPE_CODOPE'
      LookupResultField = 'OPE_NOMOPE'
      KeyFields = 'MET_CODVEN'
      Size = 30
      Lookup = True
    end
    object qryConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryConsultaMET_MESANO: TStringField
      FieldName = 'MET_MESANO'
    end
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
  end
  object qryCadVen: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = False
    SQL.Strings = (
      'SELECT OPE_CODOPE, OPE_NOMOPE FROM CADOPE')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 120
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = frmCadMetasGrupo.qryCadGru
    Left = 552
    Top = 104
  end
end
