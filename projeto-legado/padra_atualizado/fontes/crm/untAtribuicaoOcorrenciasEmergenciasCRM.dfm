inherited frmAtribuicaoOcorrenciasEmergenciasCRM: TfrmAtribuicaoOcorrenciasEmergenciasCRM
  Height = 513
  Caption = 'Atribui'#231#227'o de Ocorr'#234'ncias Emerg'#234'nciais CRM'
  Position = poMainFormCenter
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 469
    ExplicitTop = 469
    end
  inherited pgcDados: TPageControl
    Height = 469
    ExplicitHeight = 469
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 437
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 769
    Height = 469
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlCabecalho: TPanel
      Left = 1
      Top = 151
      Width = 767
      Height = 286
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object dbgOcorrencias: TcxGrid
        Left = 2
        Top = 2
        Width = 763
        Height = 282
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgOcorrenciasDBTableView1: TcxGridDBTableView
          OnKeyDown = dbgOcorrenciasDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = dbgOcorrenciasDBTableView1CustomDrawCell
          DataController.DataSource = dtsOcorrencias
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.PullFocusing = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhuma ocorr'#234'ncia dispon'#237'vel>'
          OptionsView.GroupByBox = False
          object dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CLI_NOMCLI'
            Width = 192
          end
          object dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn
            Caption = 'Protocolo'
            DataBinding.FieldName = 'OCO_PROTOC'
            Width = 149
          end
          object dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'GOC_CODGOC'
            Width = 45
          end
          object dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn
            Caption = 'Grupo Ocorr'#234'ncia'
            DataBinding.FieldName = 'GOC_DESGOC'
            Width = 150
          end
          object dbgOcorrenciasDBTableView1OCO_CODTOC: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'OCO_CODTOC'
            Width = 45
          end
          object dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn
            Caption = 'Tipo de Ocorr'#234'ncia'
            DataBinding.FieldName = 'TOC_DESTOC'
            Width = 169
          end
          object dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn
            Caption = 'Data Inclus'#227'o'
            DataBinding.FieldName = 'OCO_DTAINC'
            Width = 79
          end
          object dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn
            Caption = 'Hora Inclus'#227'o'
            DataBinding.FieldName = 'OCO_HORINC'
            Width = 83
          end
          object dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn
            Caption = 'Data Conclus'#227'o'
            DataBinding.FieldName = 'OCO_DTACON'
            Width = 91
          end
          object dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn
            Caption = 'Hora Conclus'#227'o'
            DataBinding.FieldName = 'OCO_HORCON'
            Width = 91
          end
          object dbgOcorrenciasDBTableView1NOPEOCO: TcxGridDBColumn
            Caption = 'Operador'
            DataBinding.FieldName = 'NOPEOCO'
            Width = 157
          end
          object dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn
            Caption = 'Operador Destino'
            DataBinding.FieldName = 'OPE_NOMOPE'
            Width = 165
          end
          object dbgOcorrenciasDBTableView1OCO_CODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'OCO_CODEMP'
            Width = 57
          end
          object dbgOcorrenciasDBTableView1SELECAO: TcxGridDBColumn
            DataBinding.FieldName = 'SELECAO'
            Visible = False
          end
        end
        object dbgOcorrenciasLevel1: TcxGridLevel
          GridView = dbgOcorrenciasDBTableView1
        end
      end
    end
    object pnlBotoesInferiores: TPanel
      Left = 1
      Top = 437
      Width = 767
      Height = 31
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 1
      object btnIniBus: TBitBtnLocked
        Left = 235
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ F5 ] Inicia Busca'
        Enabled = False
        TabOrder = 0
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 118
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        Enabled = False
        TabOrder = 1
        OnClick = btnLocProxClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 2
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ F10 ] Confirma'
        Enabled = False
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 352
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ F4 ] Marcar Todas'
        Enabled = False
        TabOrder = 4
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 470
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ F3 ] Desmarcar Todas'
        Enabled = False
        TabOrder = 5
        OnClick = btnDesmarcarClick
      end
      object btnSairBaixa: TBitBtnLocked
        Left = 642
        Top = 4
        Width = 116
        Height = 22
        Caption = '[ Esc ] Sair'
        TabOrder = 3
        OnClick = btnSairBaixaClick
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 767
      Height = 150
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 2
      object Label5: TLabel
        Left = 82
        Top = 13
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 78
        Top = 106
        Width = 46
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 204
        Top = 104
        Width = 6
        Height = 14
        Alignment = taRightJustify
        Caption = #224
      end
      object Label9: TLabel
        Left = 68
        Top = 128
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Protocolo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 7
        Top = 59
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
      object Label11: TLabel
        Left = 17
        Top = 82
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
      object Label1: TLabel
        Left = 25
        Top = 36
        Width = 99
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador Origem:'
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
        Left = 128
        Top = 8
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 0
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 128
        Top = 100
        Width = 72
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 215
        Top = 100
        Width = 72
        Height = 22
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtProtoc: TEditFocus
        Tag = 99
        Left = 128
        Top = 123
        Width = 159
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtDesCli: TEditFocus
        Left = 201
        Top = 8
        Width = 289
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
      object edtCodGoc: TEditFocus
        Tag = 99
        Left = 128
        Top = 54
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 2
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
        Left = 201
        Top = 54
        Width = 289
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesToc: TEditFocus
        Left = 201
        Top = 77
        Width = 289
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodToc: TEditFocus
        Tag = 99
        Left = 128
        Top = 77
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 3
        OnKeyPress = edtCodTocKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtOpeOco: TEditFocus
        Tag = 99
        Left = 128
        Top = 31
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 1
        OnKeyPress = edtOpeOcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesOpeOco: TEditFocus
        Left = 201
        Top = 31
        Width = 289
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 469
    ExplicitTop = 469
    inherited pnlInfo: TPanel
    end
  end
  object dtsOcorrencias: TDataSource
    DataSet = cdsOcorrencias
    Left = 359
    Top = 152
  end
  object cdsOcorrencias: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOcorrencias'
    AfterScroll = cdsOcorrenciasAfterScroll
    Left = 391
    Top = 152
    object cdsOcorrenciasOCO_CODOCO: TStringField
      FieldName = 'OCO_CODOCO'
      Size = 8
    end
    object cdsOcorrenciasOCO_CODTOC: TStringField
      FieldName = 'OCO_CODTOC'
      Size = 5
    end
    object cdsOcorrenciasTOC_DESTOC: TStringField
      FieldName = 'TOC_DESTOC'
      Size = 40
    end
    object cdsOcorrenciasOCO_CODCLI: TStringField
      FieldName = 'OCO_CODCLI'
      Size = 8
    end
    object cdsOcorrenciasGOC_CODGOC: TStringField
      FieldName = 'GOC_CODGOC'
      Size = 5
    end
    object cdsOcorrenciasGOC_DESGOC: TStringField
      FieldName = 'GOC_DESGOC'
      Size = 40
    end
    object cdsOcorrenciasCLI_NOMCLI: TStringField
      FieldName = 'CLI_NOMCLI'
      Size = 60
    end
    object cdsOcorrenciasOCO_DTAINC: TDateField
      FieldName = 'OCO_DTAINC'
    end
    object cdsOcorrenciasOCO_HORINC: TTimeField
      FieldName = 'OCO_HORINC'
    end
    object cdsOcorrenciasOCO_DTACON: TDateField
      FieldName = 'OCO_DTACON'
    end
    object cdsOcorrenciasOCO_HORCON: TTimeField
      FieldName = 'OCO_HORCON'
    end
    object cdsOcorrenciasOCO_CODOPE: TStringField
      FieldName = 'OCO_CODOPE'
      Size = 3
    end
    object cdsOcorrenciasOPE_NOMOPE: TStringField
      FieldName = 'OPE_NOMOPE'
      Size = 30
    end
    object cdsOcorrenciasOCO_CODEMP: TStringField
      FieldName = 'OCO_CODEMP'
      Size = 3
    end
    object cdsOcorrenciasOCO_OPEOCO: TStringField
      FieldName = 'OCO_OPEOCO'
      Size = 3
    end
    object cdsOcorrenciasNOPEOCO: TStringField
      FieldName = 'NOPEOCO'
      Size = 30
    end
    object cdsOcorrenciasOCO_PROTOC: TStringField
      FieldName = 'OCO_PROTOC'
      Size = 22
    end
    object cdsOcorrenciasSELECAO: TStringField
      FieldName = 'SELECAO'
      Size = 1
    end
  end
  object qryOcorrencias: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 296
    Top = 152
  end
  object dspOcorrencias: TUniDataSetProvider
    DataSet = qryOcorrencias
    Options = []
    Left = 328
    Top = 152
  end
end
