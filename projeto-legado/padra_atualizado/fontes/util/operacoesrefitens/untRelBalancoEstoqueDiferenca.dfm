inherited frmRelBalancoEstoqueDiferenca: TfrmRelBalancoEstoqueDiferenca
  Left = 421
  Top = 246
  Width = 336
  Height = 722
  Caption = 'Relat'#243'rio de Diferen'#231'as Contagem'
  ExplicitWidth = 336
  ExplicitHeight = 722
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 651
    Width = 330
    ExplicitTop = 651
    ExplicitWidth = 330
    inherited FlwBotoes: TFlowPanel
      Width = 249
      ExplicitWidth = 249
    end
    inherited btnSair: TBitBtnLocked
      Left = 251
      ExplicitLeft = 251
    end
  end
  inherited pnlStatus: TPanel
    Top = 677
    Width = 330
    ExplicitTop = 677
    ExplicitWidth = 330
    inherited pnlNomeForm: TPanel
      Left = 159
      ExplicitLeft = 159
    end
    inherited pnlInfo: TPanel
      Width = 159
      ExplicitWidth = 159
      object Shape1: TShape
        Left = 138
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 330
    Height = 651
    ExplicitWidth = 330
    ExplicitHeight = 651
    object Label8: TLabel [0]
      Left = 7
      Top = 3
      Width = 59
      Height = 14
      Caption = 'Linha/Grupo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 7
      Top = 42
      Width = 129
      Height = 14
      Caption = 'Localiza'#231#227'o Estoque Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [2]
      Left = 166
      Top = 42
      Width = 125
      Height = 14
      Caption = 'Localiza'#231#227'o Estoque Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [3]
      Left = 7
      Top = 122
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shaImprime: TShape [4]
      Left = 10
      Top = 565
      Width = 8
      Height = 17
    end
    object lblPermImp: TLabel [5]
      Left = 21
      Top = 566
      Width = 260
      Height = 14
      AutoSize = False
      Caption = 'Permite Impress'#227'o Custo e Diferen'#231'a em Valor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [6]
      Left = 7
      Top = 82
      Width = 140
      Height = 14
      Caption = 'Localiza'#231#227'o Super Est. Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [7]
      Left = 166
      Top = 82
      Width = 136
      Height = 14
      Caption = 'Localiza'#231#227'o Super Est. Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDigita: TLabel [8]
      Left = 7
      Top = 161
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador'
    end
    object Label5: TLabel [9]
      Left = 7
      Top = 200
      Width = 30
      Height = 14
      Caption = 'Marca'
    end
    object Label9: TLabel [10]
      Left = 7
      Top = 237
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Departamento:'
    end
    inherited gpbDestino: TGroupBox
      Top = 585
      Width = 313
      Height = 52
      TabOrder = 20
      ExplicitTop = 585
      ExplicitWidth = 313
      ExplicitHeight = 52
      inherited ColorLabel1: TColorLabel
        Left = 73
        Top = 27
        Width = 62
        Caption = '(I)mpressora'
        WordWrap = True
        ExplicitLeft = 73
        ExplicitTop = 27
        ExplicitWidth = 62
      end
      object ColorLabel2: TColorLabel [1]
        Left = 141
        Top = 27
        Width = 34
        Height = 14
        Caption = '(E)xcel'
        WordWrap = True
        CorDestaque = clRed
      end
      object ColorLabel3: TColorLabel [2]
        Left = 31
        Top = 27
        Width = 36
        Height = 14
        Caption = '(V)'#237'deo'
        WordWrap = True
        CorDestaque = clRed
      end
      inherited edtDestino: TEditFocus
        Top = 22
        ExplicitTop = 22
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 17
      Width = 55
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 63
      Top = 17
      Width = 257
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
      ParentFont = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocIni: TEditFocus
      Tag = 99
      Left = 7
      Top = 58
      Width = 156
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtLocIniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLocFin: TEditFocus
      Tag = 99
      Left = 166
      Top = 58
      Width = 154
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtLocFinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 7
      Top = 136
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 82
      Top = 136
      Width = 238
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
      ParentFont = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgMostrar: TRadioGroup
      Left = 7
      Top = 272
      Width = 313
      Height = 58
      Caption = 'Mostrar'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Refer'#234'ncia'
        'Cod.F'#225'brica'
        'Marca'
        'Cod.Barra'
        'N'#227'o Mostrar')
      TabOrder = 12
    end
    object grbOpcoes: TGroupBox
      Left = 7
      Top = 450
      Width = 155
      Height = 76
      Caption = 'Op'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      object ckbNumeroLote: TCheckBox
        Left = 10
        Top = 16
        Width = 117
        Height = 17
        Caption = 'N'#250'mero Lote'
        TabOrder = 0
      end
      object ckbLocalizacaoFisica: TCheckBox
        Left = 10
        Top = 34
        Width = 115
        Height = 17
        Caption = 'Localiza'#231#227'o F'#237'sica'
        TabOrder = 1
      end
      object ckbSuperEstoque: TCheckBox
        Left = 10
        Top = 52
        Width = 115
        Height = 17
        Caption = 'Super Estoque'
        TabOrder = 2
      end
    end
    object rdgOrdem: TRadioGroup
      Tag = 99
      Left = 7
      Top = 396
      Width = 313
      Height = 53
      Caption = 'Ordenar por'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Descri'#231#227'o do Produto'
        'Localiza'#231#227'o F'#237'sica'
        'Ordem de Contagem')
      TabOrder = 15
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 644
      Width = 328
      Height = 6
      Align = alBottom
      Smooth = True
      TabOrder = 21
      Visible = False
    end
    object rdgImpIte: TRadioGroup
      Left = 7
      Top = 330
      Width = 156
      Height = 66
      Caption = 'Imprimir itens'
      ItemIndex = 2
      Items.Strings = (
        'Com Localiza'#231#227'o Fisica'
        'Sem Localiza'#231#227'o Fisica'
        'Todos')
      TabOrder = 13
    end
    object edtSupEstFin: TEditFocus
      Tag = 99
      Left = 169
      Top = 99
      Width = 154
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSupEstIni: TEditFocus
      Tag = 99
      Left = 7
      Top = 98
      Width = 156
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkSemDif: TCheckBox
      Left = 7
      Top = 532
      Width = 296
      Height = 17
      Caption = 'Exibir produtos mesmo sem diferen'#231'a na contagem'
      TabOrder = 18
    end
    object rdgTipo: TGroupBox
      Left = 169
      Top = 330
      Width = 151
      Height = 66
      Caption = 'Tipo'
      TabOrder = 14
      object cbbTipo: TComboBoxFocus
        Left = 7
        Top = 25
        Width = 134
        Height = 22
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'Completo'
        Items.Strings = (
          'Completo'
          'Resumido')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object rdgStatus: TRadioGroup
      Left = 168
      Top = 450
      Width = 152
      Height = 76
      Caption = 'Status'
      ItemIndex = 2
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 17
    end
    object chkSalCon_SalEst: TCheckBox
      Left = 7
      Top = 548
      Width = 256
      Height = 17
      Caption = 'Ocultar o Saldo de Estoque e a Diferen'#231'a'
      TabOrder = 19
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 7
      Top = 176
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 8
      OnExit = edtCodDigExit
      OnKeyPress = edtCodDigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 82
      Top = 176
      Width = 238
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodMarca: TEditFocus
      Tag = 99
      Left = 7
      Top = 215
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 10
      OnExit = edtCodMarcaExit
      OnKeyPress = edtCodMarcaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtNomMarca: TEditFocus
      Left = 82
      Top = 215
      Width = 238
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 7
      Top = 250
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 22
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
      Left = 83
      Top = 250
      Width = 239
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 23
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 424
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 480
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 560
    Top = 415
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 635
    Top = 371
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 552
    Top = 376
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 704
    Top = 376
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 384
    Top = 416
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 432
    Top = 368
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 504
    Top = 416
  end
  inherited frxGen: TfrxUserDataSet
    Left = 440
    Top = 416
  end
  inherited frxDesigner: TfrxDesigner
    Left = 536
    Top = 480
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 600
    Top = 480
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 480
  end
  object frxRelDiferencaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42580.494719317130000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        ' '
      
        '  DMPMemo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '   '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  DMPMemo10.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 64
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxRelDiferencaM.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllRefere: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLocalizacao: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_DIFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALCON"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDifVal: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_VALDIF'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_VALDIF"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLote: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          TruncOutboundText = False
        end
        object rdbCusto: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PRECUS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object rllReferencia: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object rllTitLocalizacao: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOC. F'#205'SICA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
          TruncOutboundText = False
        end
        object rllDifVal: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DIFER.')
          TruncOutboundText = False
        end
        object rllTitLote: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUM. DO LOTE')
          TruncOutboundText = False
        end
        object rllCusto: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1238.400000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1257.600000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 1257.600000000000000000
        object rdbTotDif: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_VALDIF">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotDif: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object rdbLocSup: TfrxDMPMemoView
          Left = 364.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocSup: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelDiferencaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43383.416145914350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  Memo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  Memo10.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 128
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 320.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 1133.859000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxRelDiferencaJ.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo17: TfrxMemoView
          Width = 1133.858277480000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 239.622047240000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllRefere: TfrxMemoView
          Left = 474.347990000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 593.670810000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllDetLocalizacao: TfrxMemoView
          Left = 362.741620000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 842.514780000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFERE"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 649.305380000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 745.910080000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'ITE_SALCON'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALCON"]')
          WordWrap = False
        end
        object rdbDifVal: TfrxMemoView
          Left = 1028.409448820000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_VALDIF"]')
          WordWrap = False
        end
        object rllDetLote: TfrxMemoView
          Left = 244.669450000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          WordWrap = False
        end
        object rdbCusto: TfrxMemoView
          Left = 937.323440000000000000
          Width = 86.929133860000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PRECUS"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 1133.859000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Top = 2.779529999999994000
          Width = 1133.859000000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 239.546320000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object rllReferencia: TfrxMemoView
          Left = 474.347990000000000000
          Top = 4.000000000000000000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo7: TfrxMemoView
          Left = 593.670810000000000000
          Top = 4.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object rllTitLocalizacao: TfrxMemoView
          Left = 362.741620000000000000
          Top = 4.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC. F'#205'SICA ')
        end
        object Memo11: TfrxMemoView
          Left = 842.514780000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
        end
        object Memo6: TfrxMemoView
          Left = 649.305380000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO ')
        end
        object Memo13: TfrxMemoView
          Left = 745.910080000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
        end
        object rllDifVal: TfrxMemoView
          Left = 1028.473100000000000000
          Top = 3.779530000000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DIFER.')
        end
        object rllTitLote: TfrxMemoView
          Left = 244.669450000000000000
          Top = 3.779529999999994000
          Width = 115.502350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#218'M. DO LOTE')
        end
        object rllCusto: TfrxMemoView
          Left = 937.323440000000000000
          Top = 3.779529999999994000
          Width = 86.929131420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI.')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 190.811070000000000000
        Top = 18.897650000000000000
        Width = 1133.859000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 954.255040000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1040.655040000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 935.055040000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.661410000000000000
          Width = 1026.444280000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 468.661720000000000000
        Width = 1133.859000000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 593.612740000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 601.776190000000000000
          Top = 12.000000000000000000
          Width = 525.278850000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 385.512060000000000000
        Width = 1133.859000000000000000
        object rllTotDif: TfrxMemoView
          Left = 869.291900000000000000
          Top = 3.779530000000000000
          Width = 147.401611420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
        end
        object rdbTotDif: TfrxMemoView
          Left = 1028.409448820000000000
          Top = 3.779530000000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_VALDIF">,rlbDetalhes)]')
          WordWrap = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 343.937230000000000000
        Width = 1133.859000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object Memo8: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 17.007859370000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object rdbLocSup: TfrxMemoView
          Left = 362.741620000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          ParentFont = False
        end
        object rllLocSup: TfrxMemoView
          Left = 162.519790000000000000
          Width = 198.047244090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          ParentFont = False
        end
      end
    end
  end
  object frxRelDiferencaGmlM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40926.347235254630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFERE">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllConEmb.Text := '#39#39';'
      '    rllDifEmb.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllConEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALCON">);'
      
        '    rllDifEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'DIFERE">);'
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFGML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllConGml.Text := '#39#39';'
      '    rllDifGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllConGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_GMLCON">);'
      
        '    rllDifGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_DIFGML">);'
      '  End;    '
      'end;'
      ''
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      
        '  DMPMemo20.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllDifEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  rllSalEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  rllDifGml.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      
        '  rllSalGMl.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 184
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxRelDiferencaGmlM.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllRefere: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLocalizacao: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          TruncOutboundText = False
        end
        object rllDifEmb: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalEmb: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllConEmb: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDifGml: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalGMl: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllConGml: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDifVal: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_VALDIF"> + <frxRelatorio."ITE_VLDGML">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLote: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          TruncOutboundText = False
        end
        object rdbCusto: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_PRECUS">]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object rllReferencia: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object rllTitLocalizacao: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOC. F'#205'SICA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFER(G/ML)')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONT.(G/ML)')
          TruncOutboundText = False
        end
        object rllDifVal: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.DIFER.')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTitLote: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUM. DO LOTE')
          TruncOutboundText = False
        end
        object rllCusto: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1296.000000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1296.000000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1507.200000000000000000
        object rdbTotDif: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ITE_VALDIF">+<frxRelatorio."ITE_VLDGML">,rlb' +
              'Detalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotDif: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object rdbLocSup: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocSup: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelDiferencaGmlJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41996.390986793980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '                                                       '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFERE">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllConEmb.Text := '#39#39';'
      '    rllDifEmb.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllConEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALCON">);'
      
        '    rllDifEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'DIFERE">);'
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFGML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllConGml.Text := '#39#39';'
      '    rllDifGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllConGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_GMLCON">);'
      
        '    rllDifGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_DIFGML">);'
      '  End;'
      ''
      'end;       '
      ' '
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      
        '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;    ' +
        '                                                               '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllDifEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  rllSalEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  rllDifGML.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  rllSalGML.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      '  Memo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo20.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      
        '  Memo21.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;     ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 240
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 360.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.007859370000000000
        ParentFont = False
        Top = 292.000000000000000000
        Width = 1285.040200000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxRelDiferencaGmlJ.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo5: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 18.897637795275590000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 198.047244090000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllRefere: TfrxMemoView
          Left = 400.371490000000000000
          Width = 104.163760000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 508.300680000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllDetLocalizacao: TfrxMemoView
          Left = 291.387260000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object rllDifEmb: TfrxMemoView
          Left = 736.144650000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllSalEmb: TfrxMemoView
          Left = 542.935250000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllConEmb: TfrxMemoView
          Left = 639.539950000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllDifGML: TfrxMemoView
          Left = 1024.721770000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllConGML: TfrxMemoView
          Left = 930.117070000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllSalGML: TfrxMemoView
          Left = 831.953310000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rdbDifVal: TfrxMemoView
          Left = 1191.929133860000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_VALDIF"> + <frxRelatorio."ITE_VLDGML">]')
          WordWrap = False
        end
        object rllDetLote: TfrxMemoView
          Left = 202.094620000000000000
          Width = 85.266110000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          WordWrap = False
        end
        object rdbCusto: TfrxMemoView
          Left = 1119.944881890000000000
          Width = 68.031481420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_PRECUS">]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 248.000000000000000000
        Width = 1285.040200000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Top = 2.779530000000000000
          Width = 1285.040200000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 197.971490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object rllReferencia: TfrxMemoView
          Left = 400.371490000000000000
          Top = 4.000000000000000000
          Width = 104.163760000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo7: TfrxMemoView
          Left = 508.300680000000000000
          Top = 4.000000000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object rllTitLocalizacao: TfrxMemoView
          Left = 291.387260000000000000
          Top = 4.000000000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC. F'#205'SICA ')
        end
        object Memo11: TfrxMemoView
          Left = 736.144650000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
        end
        object Memo6: TfrxMemoView
          Left = 542.935250000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
        end
        object Memo13: TfrxMemoView
          Left = 639.539950000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
        end
        object Memo20: TfrxMemoView
          Left = 1024.721770000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFER.(G/ML)')
        end
        object Memo21: TfrxMemoView
          Left = 831.953310000000000000
          Top = 3.779530000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
        end
        object Memo22: TfrxMemoView
          Left = 930.117070000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONT.(G/ML)')
        end
        object rllDifVal: TfrxMemoView
          Left = 1191.992890000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. DIFER.')
        end
        object rllTitLote: TfrxMemoView
          Left = 202.094620000000000000
          Top = 3.779530000000000000
          Width = 85.266110000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE')
        end
        object rllCusto: TfrxMemoView
          Left = 1119.079470000000000000
          Top = 3.779530000000000000
          Width = 68.031481420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 198.370130000000000000
        Top = 16.000000000000000000
        Width = 1285.040200000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1105.436240000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1191.836240000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1086.236240000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.661410000000000000
          Width = 1264.554670000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 448.000000000000000000
        Width = 1285.040200000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 593.612740000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 601.776190000000000000
          Top = 12.000000000000000000
          Width = 676.460050000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 364.000000000000000000
        Width = 1285.040200000000000000
        object rdbTotDif: TfrxMemoView
          Left = 1191.929133860000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ITE_VALDIF">+<frxRelatorio."ITE_VLDGML">,rlb' +
              'Detalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotDif: TfrxMemoView
          Left = 1035.591220000000000000
          Top = 3.779530000000000000
          Width = 143.622081420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          ParentFont = False
          WordWrap = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 328.000000000000000000
        Width = 1285.040200000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object Memo8: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 17.007859370000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object rdbLocSup: TfrxMemoView
          Left = 291.387260000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          ParentFont = False
        end
        object rllLocSup: TfrxMemoView
          Left = 86.929190000000000000
          Width = 198.047244090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          ParentFont = False
        end
      end
    end
  end
  object frxRelDiferencaJ2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40070.697197627320000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '  Memo10.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 600
    Top = 248
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 320.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 306.141930000000000000
        Width = 1133.859000000000000000
        Child = frxRelDiferencaJ2.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo17: TfrxMemoView
          Width = 1133.858277480000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          Memo.UTF8W = (
            '')
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 277.417322830000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllRefere: TfrxMemoView
          Left = 563.718120000000000000
          Width = 145.738590000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 715.277180000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllDetLocalizacao: TfrxMemoView
          Left = 443.111750000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 854.853370000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFSAL"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 759.911750000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
        end
        object rdbDifVal: TfrxMemoView
          Left = 1029.543307090000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFVAL"]')
          WordWrap = False
        end
        object rllDetLote: TfrxMemoView
          Left = 283.464750000000000000
          Width = 153.297650000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          WordWrap = False
        end
        object rdbCusto: TfrxMemoView
          Left = 951.307086610000000000
          Width = 75.590551180000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PRECUS"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 257.008040000000000000
        Width = 1133.859000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Top = 2.779530000000000000
          Width = 1133.859000000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 277.341620000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object rllReferencia: TfrxMemoView
          Left = 563.718120000000000000
          Top = 4.000000000000000000
          Width = 145.738590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo7: TfrxMemoView
          Left = 715.277180000000000000
          Top = 4.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object rllTitLocalizacao: TfrxMemoView
          Left = 443.111750000000000000
          Top = 4.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC. F'#205'SICA ')
        end
        object Memo11: TfrxMemoView
          Left = 854.853370000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
        end
        object Memo6: TfrxMemoView
          Left = 759.911750000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO ')
        end
        object rllDifVal: TfrxMemoView
          Left = 1029.473100000000000000
          Top = 3.779530000000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DIFER.')
        end
        object rllTitLote: TfrxMemoView
          Left = 283.464750000000000000
          Top = 3.779530000000000000
          Width = 153.297650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'N'#218'M. DO LOTE')
        end
        object rllCusto: TfrxMemoView
          Left = 951.441560000000000000
          Top = 3.779530000000000000
          Width = 75.590541420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 194.590600000000000000
        Top = 18.897650000000000000
        Width = 1133.859000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 954.255040000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1040.655040000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 935.055040000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 60.440940000000000000
          Width = 1068.019110000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 472.441250000000000000
        Width = 1133.859000000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 593.612740000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 601.776190000000000000
          Top = 12.000000000000000000
          Width = 525.278850000000100000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 389.291590000000000000
        Width = 1133.859000000000000000
        object rllTotDif: TfrxMemoView
          Left = 869.291900000000000000
          Top = 3.779530000000000000
          Width = 147.401611420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
        end
        object rdbTotDif: TfrxMemoView
          Left = 1029.543307090000000000
          Top = 3.779530000000000000
          Width = 102.047251420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_DIFVAL">,rlbDetalhes)]')
          WordWrap = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 347.716760000000000000
        Width = 1133.859000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object Memo8: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 17.007859370000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object rdbLocSup: TfrxMemoView
          Left = 443.111750000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          ParentFont = False
        end
        object rllLocSup: TfrxMemoView
          Left = 241.889920000000000000
          Width = 198.047244090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          ParentFont = False
        end
      end
    end
  end
  object frxRelDiferencaGmlM2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42580.590577256950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFVAL">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllDifEmb.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllDifEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'DIFSAL">);'
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFVML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllDifGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllDifGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_DIF_ML">);'
      '  End;    '
      'end;'
      ''
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        '   '
      
        '  DMPMemo19.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '    '
      
        '  DMPMemo20.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  rllDifEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  rllSalEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '    '
      
        '  rllDifGml.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '    '
      
        '  rllSalGMl.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 592
    Top = 8
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        Child = frxRelDiferencaGmlM2.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllRefere: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLocalizacao: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          TruncOutboundText = False
        end
        object rllDifEmb: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalEmb: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDifGml: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalGMl: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDifVal: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_DIFVAL"> - <frxRelatorio."ITE_DIFVML">]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLote: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          TruncOutboundText = False
        end
        object rdbCusto: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_PRECUS">]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object rllReferencia: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object rllTitLocalizacao: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOC. F'#205'SICA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFER(G/ML)')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
          TruncOutboundText = False
        end
        object rllDifVal: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.DIFER.')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTitLote: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUM. DO LOTE')
          TruncOutboundText = False
        end
        object rllCusto: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1296.000000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1296.000000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1507.200000000000000000
        object rdbTotDif: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ITE_VALDIF"> - <frxRelatorio."ITE_VLDGML">,r' +
              'lbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotDif: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object rdbLocSup: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocSup: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelDiferencaGmlJ2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40070.684935254600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFVAL">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllDifEmb.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllDifEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'DIFSAL">);'
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFVML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllDifGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllDifGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_DIF_ML">);'
      '  End;  '
      'end;'
      ''
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo20.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo21.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      
        '  rllDifEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '    '
      
        '  rllSalEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      '  rllSalGML.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;'
      'End;'
      '  '
      'begin'
      ''
      'end.')
    Left = 592
    Top = 64
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 360.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 1285.040200000000000000
        Child = frxRelDiferencaGmlJ2.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo5: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 281.196850390000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllRefere: TfrxMemoView
          Left = 546.937007870000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 687.954360000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllDetLocalizacao: TfrxMemoView
          Left = 440.788930000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object rllDifEmb: TfrxMemoView
          Left = 821.294310000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllSalEmb: TfrxMemoView
          Left = 726.352690000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllDifGML: TfrxMemoView
          Left = 1019.162710000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllSalGML: TfrxMemoView
          Left = 917.102970000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rdbDifVal: TfrxMemoView
          Left = 1192.062992130000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_DIFVAL"> - <frxRelatorio."ITE_DIFVML">]')
          WordWrap = False
        end
        object rllDetLote: TfrxMemoView
          Left = 287.244280000000000000
          Width = 145.738590000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          WordWrap = False
        end
        object rdbCusto: TfrxMemoView
          Left = 1114.961350000000000000
          Width = 71.811011420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ITE_PRECUS">]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 1285.040200000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Top = 2.779530000000000000
          Width = 1285.040200000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 281.121150000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object rllReferencia: TfrxMemoView
          Left = 546.937007870000000000
          Top = 4.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo7: TfrxMemoView
          Left = 687.954360000000000000
          Top = 4.000000000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object rllTitLocalizacao: TfrxMemoView
          Left = 440.788930000000000000
          Top = 4.000000000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC. F'#205'SICA ')
        end
        object Memo11: TfrxMemoView
          Left = 821.294310000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
        end
        object Memo6: TfrxMemoView
          Left = 726.352690000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
        end
        object Memo20: TfrxMemoView
          Left = 1019.162710000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIFER.(G/ML)')
        end
        object Memo21: TfrxMemoView
          Left = 917.102970000000000000
          Top = 3.779530000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
        end
        object rllDifVal: TfrxMemoView
          Left = 1191.992890000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. DIFER.')
        end
        object rllTitLote: TfrxMemoView
          Left = 287.244280000000000000
          Top = 3.779530000000000000
          Width = 145.738590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOTE')
        end
        object rllCusto: TfrxMemoView
          Left = 1114.961350000000000000
          Top = 3.779530000000000000
          Width = 71.811011420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 190.811070000000000000
        Top = 18.897650000000000000
        Width = 1285.040200000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1105.436240000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1191.836240000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1086.236240000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.661410000000000000
          Width = 1068.019110000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 468.661720000000000000
        Width = 1285.040200000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 593.612740000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 601.776190000000000000
          Top = 12.000000000000000000
          Width = 676.460050000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 385.512060000000000000
        Width = 1285.040200000000000000
        object rdbTotDif: TfrxMemoView
          Left = 1192.062992130000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."ITE_DIFVAL"> - <frxRelatorio."ITE_DIFVML">,r' +
              'lbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllTotDif: TfrxMemoView
          Left = 1035.591220000000000000
          Top = 3.779530000000000000
          Width = 143.622081420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          ParentFont = False
          WordWrap = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 343.937230000000000000
        Width = 1285.040200000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object Memo8: TfrxMemoView
          Width = 1285.947250000000000000
          Height = 17.007874015748030000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object rdbLocSup: TfrxMemoView
          Left = 440.788930000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          ParentFont = False
        end
        object rllLocSup: TfrxMemoView
          Left = 238.110390000000000000
          Width = 198.047244090000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          ParentFont = False
        end
      end
    end
  end
  object frxRelDiferencaM2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42580.594291446760000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure chdLocSupOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdLocSup.Visible := blnLocSup And ( <frxRelatorio."ITE_LOCSUP' +
        '"> <> '#39#39');  '
      '  rdbLocSup.Left    := rllDetLocalizacao.Left;'
      '  rllLocSup.Left    := rdbLocSup.Left - rllLocSup.Width - 5;  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo11.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        ' '
      
        '  DMPMemo10.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      
        '  DMPMemo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 592
    Top = 128
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1257.600000000000000000
        Child = frxRelDiferencaM2.chdLocSup
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllRefere: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_REFERE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLocalizacao: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'ITE_LOCFIS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFSAL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDifVal: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DIFVAL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDetLote: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_NUMLOT"]')
          TruncOutboundText = False
        end
        object rdbCusto: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PRECUS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object rllReferencia: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object rllTitLocalizacao: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'LOC. F'#205'SICA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'DIFERENCA')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object rllDifVal: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            'VALOR DIFER.')
          TruncOutboundText = False
        end
        object rllTitLote: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'NUM. DO LOTE')
          TruncOutboundText = False
        end
        object rllCusto: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO UNI.')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1104.000000000000000000
          Height = 68.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1257.600000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 1257.600000000000000000
        object rdbTotDif: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_DIFVAL">,rlbDetalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllTotDif: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DIFERENCAS:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object chdLocSup: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'chdLocSupOnBeforePrint'
        object rdbLocSup: TfrxDMPMemoView
          Left = 451.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLocSup: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUPER ESTOQUE:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object svdExcel: TSaveDialog
    Filter = 'Arquivos Excel|*.xls'
    Left = 472
    Top = 472
  end
  object frxRelDiferencaResJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41996.388051458340000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Memo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      '  Memo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 304
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo17: TfrxMemoView
          Width = 718.110236220472400000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 455.055257240000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 468.946320000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 524.580890000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 621.185590000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataField = 'ITE_SALCON'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALCON"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Top = 2.779530000000000000
          Width = 718.110236220472400000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 239.546320000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object Memo7: TfrxMemoView
          Left = 468.946320000000000000
          Top = 4.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object Memo6: TfrxMemoView
          Left = 524.580890000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO ')
        end
        object Memo13: TfrxMemoView
          Left = 621.185590000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 190.811070000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 508.648670000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 542.286270000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 628.686270000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 523.086270000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 509.404700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.661410000000000000
          Width = 667.388930000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 381.732530000000000000
        Width = 718.110700000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 472.667780000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 473.272170000000000000
          Top = 12.000000000000000000
          Width = 241.814100000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
    end
  end
  object frxRelDiferencaGmlResJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40925.741086331020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '                                                       '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    '
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFERE">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllConEmb.Text := '#39#39';   '
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllConEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALCON">);'
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFGML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllConGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllConGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_GMLCON">);'
      '  End;  '
      '  '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllSalGML.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '    '
      '  Memo21.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 608
    Top = 312
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 302.362400000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo5: TfrxMemoView
          Width = 718.110089760000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> MOD 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
          WordWrap = False
        end
        object frxRelatorioHORENV: TfrxMemoView
          Width = 284.976434090000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object rllUnidade: TfrxMemoView
          Left = 292.867470000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllSalEmb: TfrxMemoView
          Left = 327.502040000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllConEmb: TfrxMemoView
          Left = 424.106740000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllConGML: TfrxMemoView
          Left = 620.195610000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
        object rllSalGML: TfrxMemoView
          Left = 522.031850000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 24.543290000000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Top = 2.779530000000000000
          Width = 718.110236220000000000
          Height = 18.897650000000000000
          Fill.BackColor = clSilver
        end
        object rllTitDescricao: TfrxMemoView
          Top = 4.000000000000000000
          Width = 281.121150000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
        end
        object Memo7: TfrxMemoView
          Left = 292.867470000000000000
          Top = 4.000000000000000000
          Width = 30.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
        end
        object Memo6: TfrxMemoView
          Left = 327.502040000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
        end
        object Memo13: TfrxMemoView
          Left = 424.106740000000000000
          Top = 4.000000000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
        end
        object Memo21: TfrxMemoView
          Left = 522.031850000000000000
          Top = 3.779530000000000000
          Width = 94.488191420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
        end
        object Memo22: TfrxMemoView
          Left = 620.195610000000000000
          Top = 3.779530000000000000
          Width = 90.708661420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CONT.(G/ML)')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 190.811070000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 512.428200000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 538.506740000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 624.906740000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 523.086270000000000000
          Top = 34.000000000000000000
          Width = 86.702350000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object frxUserRelstrTitRel: TfrxMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 513.184230000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 9.600000000000000000
          Top = 56.661410000000000000
          Width = 701.404700000000000000
          Height = 126.590600000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]'
            '[DEPARTAMENTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 30.220470000000000000
        Top = 381.732530000000000000
        Width = 718.110700000000000000
        object Memo15: TfrxMemoView
          Left = 9.600000000000000000
          Top = 12.000000000000000000
          Width = 495.344960000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 492.169820000000000000
          Top = 12.000000000000000000
          Width = 219.136920000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
    end
  end
  object frxRelDiferencaResM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40925.628552870370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  DMPMemo5.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        ' '
      
        '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   ' +
        ' '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 592
    Top = 192
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALCON"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1094.400000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1238.400000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]'
            '[MARCA]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1257.600000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelDiferencaGmlResM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40926.347235254630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'procedure rllSalEmbOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_DIFERE">) = '#39'0,0' +
        '00'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalEmb.Text := '#39#39';'
      '    rllConEmb.Text := '#39#39';    '
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALDOS">);'
      
        '    rllConEmb.Text := FORMATFLOAT('#39'###0.000'#39',<frxRelatorio."ITE_' +
        'SALCON">);    '
      '  End;    '
      '      '
      
        '  If (FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE_DIFGML">) = '#39'0,' +
        '0000'#39') And (Not <SEMDIF>) Then'
      '  Begin'
      '    rllSalGml.Text := '#39#39';'
      '    rllConGml.Text := '#39#39';'
      '  End'
      '  Else'
      '  Begin'
      
        '    rllSalGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_SAL_ML">);'
      
        '    rllConGml.Text := FORMATFLOAT('#39'###0.0000'#39',<frxRelatorio."ITE' +
        '_GMLCON">);'
      '  End;    '
      'end;'
      ''
      'procedure rlbTituloOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  DMPMemo6.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;   '
      '  DMPMemo20.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllSalEmb.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  '
      
        '  rllSalGMl.Visible :=  Not blnOcultar_saldoEstoque_Diferenca;  ' +
        '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 440
    Top = 8
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 292.364394514661800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioHORENV: TfrxDMPMemoView
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODITE"]-[frxRelatorio."ITE_DESITE"]')
          TruncOutboundText = False
        end
        object rllUnidade: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'UNI_SIGUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalEmb: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllSalEmbOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllConEmb: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllSalGMl: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rllConGml: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##,#0.0000'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        ReprintOnNewPage = True
        object rllTitDescricao: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CODIGO/DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONTAGEM')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1276.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO(G/ML)')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CONT.(G/ML)')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1305.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'RELATORIO DE DIFERENCAS (SALDO / CONTAGEM)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1296.000000000000000000
          Height = 85.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[LINGRU]'
            '[LOCAL1]'
            '[LOCAL2]'
            '[STATUS]'
            '[DEPARTAMENTO]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 1296.000000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]'
            '[DIGITADOR]')
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
end
