inherited frmCadMetasVendDepProd: TfrmCadMetasVendDepProd
  Width = 745
  Height = 479
  Caption = 'Metas de Vendedores por Departamento do Produto'
  OnClose = FormClose
  ExplicitWidth = 745
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 398
    Width = 729
    Height = 26
    TabOrder = 3
    ExplicitTop = 398
    ExplicitWidth = 729
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 725
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 725
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 120
        ExplicitWidth = 120
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 120
        Width = 120
        ExplicitLeft = 120
        ExplicitWidth = 120
      end
      object btnConfirmar: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
      object btnCopiarMetas: TBitBtnLocked
        Left = 360
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F11 ] Copiar Metas'
        TabOrder = 3
        OnClick = btnCopiarMetasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 649
      Top = 2
      ExplicitLeft = 649
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 424
    Width = 730
    TabOrder = 4
    ExplicitTop = 424
    ExplicitWidth = 730
    inherited pnlNomeForm: TPanel
      Left = 559
      ExplicitLeft = 559
    end
    inherited pnlInfo: TPanel
      Width = 559
      ExplicitWidth = 559
    end
  end
  inherited pnlHeader: TPanel
    Width = 729
    Height = 141
    TabOrder = 0
    ExplicitWidth = 729
    ExplicitHeight = 141
    object pnlFiltro: TPanel
      Left = 0
      Top = 0
      Width = 567
      Height = 74
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 4
        Top = 41
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
      object Label2: TLabel
        Left = 341
        Top = 41
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
      object Label1: TLabel
        Left = 9
        Top = 16
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblTipOpe: TLabel
        Left = 500
        Top = 17
        Width = 60
        Height = 14
        Caption = 'Sub-gerente'
        Font.Charset = ANSI_CHARSET
        Font.Color = 185
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object edtNomEmp: TEditFocus
        Tag = 99
        Left = 116
        Top = 37
        Width = 219
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 3
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 59
        Top = 37
        Width = 54
        Height = 22
        Alignment = taLeftJustify
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
      object mskDtaAtual: TMaskEditFocus
        Tag = 99
        Left = 440
        Top = 37
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
        TabOrder = 4
        Text = '  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 59
        Top = 9
        Width = 54
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomVen: TEditFocus
        Left = 116
        Top = 9
        Width = 378
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
    end
    object pnlDados: TPanel
      Left = 0
      Top = 74
      Width = 729
      Height = 67
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblDepVen: TLabel
        Left = 38
        Top = 14
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Departamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 45
        Top = 42
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Prazo M'#233'dio:'
      end
      object Label6: TLabel
        Left = 345
        Top = 40
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Margem Liquida:'
      end
      object Label12: TLabel
        Left = 195
        Top = 40
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Faturamento:'
      end
      object edtCodDep: TEditFocus
        Tag = 99
        Left = 110
        Top = 6
        Width = 54
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodDepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesDep: TEditFocus
        Left = 166
        Top = 6
        Width = 324
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtPraMed: TEditFocus
        Tag = 99
        Left = 110
        Top = 34
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtMarLiq: TEditFocus
        Tag = 99
        Left = 425
        Top = 34
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtFatura: TEditFocus
        Tag = 99
        Left = 260
        Top = 34
        Width = 65
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
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
    object pnlMesAnoOrigem: TPanel
      Left = 567
      Top = 0
      Width = 162
      Height = 74
      Align = alRight
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object Label4: TLabel
        Left = 5
        Top = 22
        Width = 94
        Height = 14
        AutoSize = False
        Caption = 'Per'#237'odo de Origem:'
      end
      object mskDtaOrigem: TMaskEditFocus
        Tag = 99
        Left = 96
        Top = 13
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
  end
  inherited pnlTail: TPanel
    Top = 394
    Width = 729
    Height = 4
    TabOrder = 5
    ExplicitTop = 392
    ExplicitWidth = 729
    ExplicitHeight = 4
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 178
    Width = 729
    Height = 216
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'VDE_CODDEP'
        Title.Caption = 'C'#243'd. Dep.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEPARTAMENTO'
        Title.Caption = 'Departamento'
        Width = 290
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VDE_PRZMED'
        Title.Caption = 'Prazo M'#233'dio'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VDE_VALFAT'
        Title.Caption = 'Faturamento'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VDE_MARLIQ'
        Title.Caption = 'Margem L'#237'quida'
        Width = 116
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 141
    Width = 729
    Height = 37
    TabOrder = 1
    ExplicitTop = 141
    ExplicitWidth = 729
    ExplicitHeight = 37
  end
  object pnlTotalizacoes: TPanel [6]
    Left = 0
    Top = 361
    Width = 730
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      730
      33)
    object lblTotFat: TLabel
      Left = 355
      Top = 9
      Width = 119
      Height = 14
      Anchors = [akRight, akBottom]
      Caption = 'Total do Faturamento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotFat: TDBEditFocus
      Left = 480
      Top = 6
      Width = 107
      Height = 20
      BiDiMode = bdRightToLeft
      CharCase = ecUpperCase
      DataField = 'VDE_TOTFAT'
      DataSource = dtsConsulta
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
  inherited qryConsulta: TUniQuery
    Left = 536
    Top = 48
    object qryConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryConsultaVDE_CODVEN: TStringField
      FieldName = 'VDE_CODVEN'
      Size = 3
    end
    object qryConsultaVDE_CODEMP: TStringField
      FieldName = 'VDE_CODEMP'
      Size = 3
    end
    object qryConsultaVDE_MESANO: TStringField
      FieldName = 'VDE_MESANO'
      Size = 6
    end
    object qryConsultaVDE_CODDEP: TStringField
      FieldName = 'VDE_CODDEP'
      Size = 3
    end
    object qryConsultaVDE_PRZMED: TFloatField
      FieldName = 'VDE_PRZMED'
    end
    object qryConsultaVDE_VALFAT: TFloatField
      FieldName = 'VDE_VALFAT'
    end
    object qryConsultaVDE_MARLIQ: TFloatField
      FieldName = 'VDE_MARLIQ'
    end
    object qryConsultaDEPARTAMENTO: TStringField
      FieldKind = fkLookup
      FieldName = 'DEPARTAMENTO'
      LookupDataSet = qryCadDep
      LookupKeyFields = 'DEP_CODIGO'
      LookupResultField = 'DEP_DESCRI'
      KeyFields = 'VDE_CODDEP'
      Size = 60
      Lookup = True
    end
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 568
    Top = 48
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    AfterOpen = cdsConsultaAfterOpen
    Left = 600
    Top = 48
    object cdsConsultaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Size = 50
    end
    object cdsConsultaVDE_CODVEN: TStringField
      FieldName = 'VDE_CODVEN'
      Size = 3
    end
    object cdsConsultaVDE_CODEMP: TStringField
      FieldName = 'VDE_CODEMP'
      Size = 3
    end
    object cdsConsultaVDE_MESANO: TStringField
      FieldName = 'VDE_MESANO'
      Size = 6
    end
    object cdsConsultaVDE_CODDEP: TStringField
      FieldName = 'VDE_CODDEP'
      Size = 3
    end
    object cdsConsultaVDE_PRZMED: TFloatField
      FieldName = 'VDE_PRZMED'
    end
    object cdsConsultaVDE_VALFAT: TFloatField
      FieldName = 'VDE_VALFAT'
    end
    object cdsConsultaVDE_MARLIQ: TFloatField
      FieldName = 'VDE_MARLIQ'
    end
    object cdsConsultaDEPARTAMENTO: TStringField
      FieldKind = fkLookup
      FieldName = 'DEPARTAMENTO'
      LookupDataSet = qryCadDep
      LookupKeyFields = 'DEP_CODIGO'
      LookupResultField = 'DEP_DESCRI'
      KeyFields = 'VDE_CODDEP'
      Size = 60
      Lookup = True
    end
    object cdsConsultaVDE_TOTFAT: TAggregateField
      FieldName = 'VDE_TOTFAT'
      ProviderFlags = []
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VDE_VALFAT)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 632
    Top = 48
  end
  object qryCadDep: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 536
    Top = 80
    object qryCadDepDEP_CODIGO: TStringField
      FieldName = 'DEP_CODIGO'
      Size = 3
    end
    object qryCadDepDEP_DESCRI: TStringField
      FieldName = 'DEP_DESCRI'
      Size = 40
    end
  end
end
