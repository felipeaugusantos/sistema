inherited frmCadMetasValor: TfrmCadMetasValor
  Left = 304
  Top = 105
  Width = 930
  Height = 595
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Metas de Vendedores'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 930
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 292
    Width = 924
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 343
    ExplicitWidth = 519
  end
  inherited pnlBotoes: TPanel
    Top = 524
    Width = 924
    Height = 26
    TabOrder = 4
    ExplicitTop = 524
    ExplicitWidth = 924
    ExplicitHeight = 26
    DesignSize = (
      924
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 920
      Height = 22
      ExplicitWidth = 920
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 128
        ExplicitWidth = 128
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 128
        Width = 128
        ExplicitLeft = 128
        ExplicitWidth = 128
      end
      object btnConfirmar: TBitBtnLocked
        Left = 256
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 384
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 3
        OnClick = btnCopiarMetasClick
      end
      object btnPerGru: TBitBtnLocked
        Left = 512
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F9 ] Percentual Grupos'
        TabOrder = 4
        OnClick = btnPerGruClick
      end
      object btnImportarMetas: TBitBtnLocked
        Left = 640
        Top = 0
        Width = 128
        Height = 22
        Caption = 'Importar Metas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000946D
          4CB7CC9668FFCC9467FFCA9364FFC99163FFC98F61FFC78E5FFFC78C5EFFC68C
          5CFFC48A5AFFC4895AFF8C6240B700000000000000000000000000000000CF9A
          6DFFFFFFFFFFF5EADEFFF4E9DDFFF4E8DBFFF4E7D9FFF3E6D8FFF3E6D7FFF2E4
          D5FFF2E4D4FFF1E2D2FFC4895AFF00000000000000000000000000000000D19C
          70FFFFFFFFFFF9F1E7FFF8F0E6FFF8EFE5FFF8EFE4FFF8EEE3FFF7EEE1FFF7ED
          E1FFF5EBDFFFEDDFCFFFD5B699FF00000008000000020000000000000000D19E
          72FFFFFFFFFFF5ECE1FFD29D6BFFD09C69FFCF9B67FFCF9A66FFCE9965FFCD98
          64FFF2E8DDFF569A5DFF1F8233FF155B23BF000000080000000000000000D3A1
          75FFFFFFFFFFF6ECE2FFF5ECE1FFF5EBDFFFF9F1E7FFF8F0E6FFF7EFE3FFF5EC
          E0FFEDE5DAFF228637FF55D99CFF1F8232FF000000130000000800000000D4A2
          77FFFFFFFFFFF6EDE4FF6061D0FF5D5DCCFF5959C8FF5656C6FFF6EEE4FF5FA7
          6BFF258B3CFF238839FF5EDFA4FF208435FF1F8233FF155B23BF00000000D6A4
          7AFFFFFFFFFFF7EEE5FFF6EEE4FFF5EDE3FFF9F3EBFFF9F2EAFFF7F0E7FF2990
          40FFB0F6DAFF72E9B4FF68E4ADFF5FDEA4FF56D99CFF1F8233FF00000000D7A7
          7CFFFFFFFFFFF7EFE7FF6B6CDBFF6868D8FF6565D4FF6162D1FFFAF3EAFF5FAA
          6CFF299040FF288D3EFF72E9B4FF24893AFF228637FF186227C300000000D8A8
          7EFFFFFFFFFFF7F0E9FFF7EFE7FFF6EFE6FFFBF5EEFFFAF4EDFFFAF4EBFFF9F3
          EAFFF7EFE7FF299040FFB0F7DAFF258B3BFF0000000A0000000500000000DAAB
          80FFFFFFFFFFF8F1EAFFDDAA7BFFDCA97AFFDAA778FFD9A677FFD8A575FFD7A4
          74FFF9F3EAFF5FA86AFF299040FF1D682EBF000000030000000000000000DBAC
          82FFFFFFFFFFF8F1EBFFF8F2EBFFF7F1EAFFFBF6F1FFFBF6F0FFFAF5EFFFFBF4
          EEFFFAF4ECFFF6EEE4FFE3C4A8FF00000002000000010000000000000000DCAD
          84FFFFFFFFFFF9F2ECFFDFAC80FFDEAC7FFFDEAC7DFFDDAA7CFFDCA97BFFDAA8
          79FFFAF5EEFFF7EFE6FFD19C71FF00000000000000000000000000000000DDAF
          85FFFFFFFFFFFDFAF7FFFCFAF7FFFCF9F6FFFCF9F4FFFCF8F3FFFCF7F3FFFBF6
          F1FFFBF5F0FFF8F0E9FFD29E73FF00000000000000000000000000000000DEB0
          87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFD4A176FF00000000000000000000000000000000A583
          65BDDEB187FFDDAF86FFDCAE85FFDBAD83FFDBAC82FFDAAB81FFD9A97FFFD8A8
          7DFFD7A67CFFD6A57AFF9E7959BD000000000000000000000000}
        TabOrder = 5
        OnClick = btnImportarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 845
      Top = 2
      ExplicitLeft = 845
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 550
    Width = 924
    TabOrder = 5
    ExplicitTop = 550
    ExplicitWidth = 924
    inherited pnlNomeForm: TPanel
      Left = 753
      ExplicitLeft = 753
    end
    inherited pnlInfo: TPanel
      Width = 753
      ExplicitWidth = 753
      object shpLiberado: TShape
        Left = 554
        Top = 2
        Width = 16
        Height = 14
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pnlHeader: TPanel
    Width = 924
    Height = 35
    TabOrder = 0
    ExplicitWidth = 924
    ExplicitHeight = 35
    object Label2: TLabel
      Left = 3
      Top = 10
      Width = 97
      Height = 14
      Caption = 'Per'#237'odo Atual de: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 160
      Top = 10
      Width = 55
      Height = 14
      Caption = 'Empresa: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpCodEmp: TShape
      Left = 218
      Top = 6
      Width = 5
      Height = 22
      Brush.Color = clGreen
    end
    object edtNomEmp: TEditFocus
      Tag = 99
      Left = 268
      Top = 6
      Width = 222
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object pnlMesAnoOrigem: TPanel
      Left = 669
      Top = 0
      Width = 255
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
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      TabStop = True
      Visible = False
      object Label1: TLabel
        Left = 5
        Top = 10
        Width = 188
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Copiar metas do Per'#237'odo de Origem:'
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
        Left = 196
        Top = 6
        Width = 53
        Height = 22
        EditMask = '99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
    end
    object mskDtaAtual: TMaskEditFocus
      Tag = 99
      Left = 102
      Top = 6
      Width = 54
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      OnKeyPress = mskDtaAtualKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 224
      Top = 6
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
  end
  inherited pnlTail: TPanel
    Top = 295
    Width = 924
    Height = 229
    Visible = True
    OnEnter = pnlTailEnter
    OnExit = pnlTailExit
    ExplicitTop = 295
    ExplicitWidth = 924
    ExplicitHeight = 229
  end
  inherited pnlPesquisa: TPanel [5]
    Top = 35
    Width = 924
    TabOrder = 1
    ExplicitTop = 35
    ExplicitWidth = 924
    inherited lblPesquisa: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      ExplicitTop = 12
    end
  end
  inherited dbgConsulta: TDBGridCitel [6]
    Top = 75
    Width = 924
    Height = 176
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ParentCtl3D = False
    TabOrder = 2
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'MET_CODVEN'
        ReadOnly = True
        Title.Caption = 'C'#243'd.'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPE_NOMOPE'
        ReadOnly = True
        Title.Caption = 'Nome do Vendedor'
        Width = 185
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FUNCAO'
        ReadOnly = True
        Title.Caption = 'Fun'#231#227'o'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUBGER'
        ReadOnly = True
        Title.Caption = 'Sub-Gerente'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GERENT'
        ReadOnly = True
        Title.Caption = 'Gerente'
        Width = 136
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_TOTMET'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Faturamento'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_TOTFRE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Frete'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MET_MARGEM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Margem'
        Width = 90
        Visible = True
      end>
  end
  object pnlTotalizacoes: TPanel [7]
    Left = 0
    Top = 251
    Width = 924
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    object lblTotFat: TLabel
      Left = 648
      Top = 2
      Width = 38
      Height = 14
      Caption = 'Total R$'
    end
    object lblTotFre: TLabel
      Left = 759
      Top = 2
      Width = 38
      Height = 14
      Caption = 'Total R$'
    end
    object lblMedMar: TLabel
      Left = 847
      Top = 2
      Width = 41
      Height = 14
      Caption = 'M'#233'dia %'
    end
    object edtTotFat: TEditFocus
      Left = 576
      Top = 15
      Width = 110
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtTotFre: TEditFocus
      Left = 687
      Top = 15
      Width = 110
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtMedMar: TEditFocus
      Left = 798
      Top = 15
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 124
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 368
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 208
  end
  inherited qryConsulta: TUniQuery
    Top = 124
    object qryConsultaCODVEN: TStringField
      FieldName = 'MET_CODVEN'
      Size = 3
    end
    object qryConsultaTOTMET: TFloatField
      FieldName = 'MET_TOTMET'
    end
    object qryConsultaMET_TOTFRE: TFloatField
      FieldName = 'MET_TOTFRE'
    end
    object qryConsultaMET_MARGEM: TFloatField
      FieldName = 'MET_MARGEM'
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
    object qryConsultaFUNCAO: TStringField
      FieldName = 'FUNCAO'
      Size = 15
    end
    object qryConsultaSUBGER: TStringField
      FieldName = 'SUBGER'
      Size = 30
    end
    object qryConsultaGERENT: TStringField
      FieldName = 'GERENT'
      Size = 30
    end
    object qryConsultaMET_CODEMP: TStringField
      FieldName = 'MET_CODEMP'
    end
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 124
  end
  inherited cdsConsulta: TUniClientDataSet
    BeforePost = cdsConsultaBeforePost
    BeforeScroll = cdsConsultaBeforeScroll
    AfterScroll = cdsConsultaAfterScroll
    Left = 200
    Top = 124
    object cdsConsultaMET_CODVEN: TStringField
      FieldName = 'MET_CODVEN'
    end
    object cdsConsultaOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      ProviderFlags = []
      Size = 0
    end
    object cdsConsultaMET_TOTMET: TFloatField
      FieldName = 'MET_TOTMET'
    end
    object cdsConsultaMET_TOTFRE: TFloatField
      FieldName = 'MET_TOTFRE'
    end
    object cdsConsultaMET_MARGEM: TFloatField
      FieldName = 'MET_MARGEM'
    end
    object cdsConsultaMET_MESANO: TStringField
      FieldName = 'MET_MESANO'
    end
    object cdsConsultaFUNCAO: TStringField
      FieldName = 'FUNCAO'
      Size = 15
    end
    object cdsConsultaGERENT: TStringField
      FieldName = 'GERENT'
      Size = 30
    end
    object cdsConsultaSUBGER: TStringField
      FieldName = 'SUBGER'
      Size = 30
    end
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsConsultaMET_CODEMP: TStringField
      FieldName = 'MET_CODEMP'
    end
  end
  inherited dtsConsulta: TDataSource
    OnUpdateData = dtsConsultaUpdateData
    Left = 264
    Top = 132
  end
  object qryCadVen: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT OPE_CODOPE, OPE_NOMOPE FROM CADOPE')
    ReadOnly = True
    Constraints = <>
    Left = 120
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = frmCadMetasGrupo.qryCadGru
    Left = 440
    Top = 124
  end
end
