inherited frmRelFichaCadFuncionario: TfrmRelFichaCadFuncionario
  Width = 529
  Height = 236
  VertScrollBar.Range = 56
  Caption = 'Ficha de Cadastro de Funcion'#225'rios'
  Font.Height = -11
  ExplicitWidth = 529
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 165
    Width = 523
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 165
    ExplicitWidth = 523
    inherited FlwBotoes: TFlowPanel
      Width = 442
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Font.Height = -11
      ParentFont = False
      ExplicitWidth = 442
      inherited btnImprimir: TBitBtnLocked
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Font.Height = -11
        ParentFont = False
      end
      inherited btnConfigurar: TBitBtnLocked
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 444
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 444
    end
  end
  inherited pnlStatus: TPanel
    Top = 191
    Width = 523
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 191
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 309
      Width = 214
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 309
      ExplicitWidth = 214
    end
    inherited pnlInfo: TPanel
      Width = 309
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitWidth = 309
      inherited shpMultSel: TShape
        Left = 388
        Width = 20
        Height = 18
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 388
        ExplicitWidth = 20
        ExplicitHeight = 18
      end
    end
    inherited pnlBotoesTrace: TPanel
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      inherited btnIniciarTrace: TSpeedButton
        Width = 29
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 29
        ExplicitHeight = 20
      end
      inherited btnPausarTrace: TSpeedButton
        Left = 29
        Width = 29
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 29
        ExplicitTop = 0
        ExplicitWidth = 29
        ExplicitHeight = 20
      end
      inherited btnSalvarTrace: TSpeedButton
        Left = 58
        Width = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 58
        ExplicitTop = 0
        ExplicitWidth = 28
        ExplicitHeight = 20
      end
      inherited btnViewerTrace: TSpeedButton
        Left = 86
        Width = 29
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitTop = 0
        ExplicitWidth = 29
        ExplicitHeight = 20
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 523
    Height = 165
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 523
    ExplicitHeight = 165
    object lblProduto: TLabel [0]
      Left = 190
      Top = 5
      Width = 56
      Height = 14
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Caption = 'Funcion'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 110
      Width = 175
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Font.Height = -11
      TabOrder = 3
      ExplicitLeft = 8
      ExplicitTop = 110
      ExplicitWidth = 175
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 140
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '(V)'#237'deo (I)mpressora (E)-Mail'
        Font.Height = -11
        ParentFont = False
        ExplicitTop = 19
        ExplicitWidth = 140
      end
      inherited edtDestino: TEditFocus
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        OnChange = edtDestinoChange
      end
    end
    object rdgModelo: TRadioGroup
      Left = 7
      Top = 8
      Width = 175
      Height = 48
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Caption = 'Modelo da Ficha'
      ItemIndex = 0
      Items.Strings = (
        'Em Branco'
        'Preenchida')
      TabOrder = 0
      TabStop = True
      OnClick = rdgModeloClick
    end
    object gpbContato: TGroupBox
      Left = 190
      Top = 63
      Width = 327
      Height = 92
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabOrder = 4
      object lblEmail: TLabel
        Left = 7
        Top = 17
        Width = 31
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'E-mail:'
        Enabled = False
      end
      object lblContato: TLabel
        Left = 7
        Top = 40
        Width = 40
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Contato:'
        Enabled = False
      end
      object edtEmail: TEditFocus
        Tag = 99
        Left = 55
        Top = 15
        Width = 249
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taLeftJustify
        CharCase = ecLowerCase
        Color = 16770261
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 60
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtContato: TEditFocus
        Tag = 99
        Left = 55
        Top = 40
        Width = 249
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Alignment = taLeftJustify
        Color = 16770261
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 50
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
    object edtCodFun: TEditFocus
      Tag = 99
      Left = 190
      Top = 22
      Width = 64
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodFunExit
      OnKeyPress = edtCodFunKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesFun: TEditFocus
      Left = 257
      Top = 22
      Width = 260
      Height = 22
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 57
      Width = 175
      Height = 50
      Caption = 'Exibir'
      TabOrder = 2
      object chkFotoFuncionario: TCheckBox
        Left = 7
        Top = 13
        Width = 141
        Height = 17
        Caption = 'Foto do funcion'#225'rio'
        Enabled = False
        TabOrder = 0
      end
      object chkExibirFuncDemitidos: TCheckBox
        Left = 7
        Top = 29
        Width = 168
        Height = 17
        Caption = 'Funcion'#225'rios Demitidos'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 208
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 248
    Top = 112
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 352
    Top = 24
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 320
    Top = 24
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 312
    Top = 88
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 432
    Top = 104
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 160
    Top = 0
  end
  inherited frxGen: TfrxUserDataSet
    Left = 288
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 448
    Top = 24
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 480
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 320
    Top = 56
  end
  object frxBeneficia: TfrxDBDataset
    UserName = 'frxBeneficia'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 288
  end
  object frxFerias: TfrxDBDataset
    UserName = 'frxFerias'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 360
    Top = 112
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45181.673481678240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbCabecalhoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure Memo118OnAfterData(Sender: TfrxComponent);'
      'begin'
      '    if (Trim(Memo118.Text) = '#39#39') then'
      '    Memo118.Text := '#39#39
      '  else'
      '    Memo118.Text := fFormataFonePaisInterna(Trim(Memo118.Text));'
      '        '
      'end;'
      ''
      'procedure Memo114OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(Memo114.Text) = '#39#39') then'
      '    Memo114.Text := '#39#39
      '  else'
      '    Memo114.Text := fFormataFonePaisInterna(Trim(Memo114.Text));'
      'end;'
      ''
      'procedure qckPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure Memo256OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure qckPaginaOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure Header1OnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  foto: string;                                    '
      'begin'
      '   // FOTO_FUNCIONARIO.Visible:=False;'
      '    FOTO_FUNCIONARIO.Picture := Nil;               '
      ''
      '    foto:=<frxRelatorio."FUN_FOTO02">;'
      '      '
      '    if FrFileExists(foto) Then'
      '    begin'
      '       FOTO_FUNCIONARIO.LoadFromFile(foto);'
      '      // FOTO_FUNCIONARIO.Visible:=True;          '
      '    end;                      '
      ''
      '    foto:=<frxRelatorio."FUN_FOTO01">;'
      '      '
      '    if FrFileExists(foto) Then'
      '    begin'
      '        FOTO_FUNCIONARIO.LoadFromFile(foto);'
      '     //   FOTO_FUNCIONARIO.Visible:=True;                  '
      '    end;               '
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'function fRetornaEmExperiencia: String;'
      'begin'
      '  If (<frxRelatorio."FUN_EMEXPE"> = '#39'S'#39') Then'
      '  Begin              '
      '    Result := '#39'Em Experi'#234'ncia'#39';'
      '    '
      
        '    If (<frxRelatorio."FUN_EXP45D"> = '#39'S'#39') And (<frxRelatorio."F' +
        'UN_EXPM45"> <> '#39'S'#39') Then'
      '      Result := '#39'Em Experi'#234'ncia - 45 dias'#39
      '    Else If (<frxRelatorio."FUN_EXPM45"> = '#39'S'#39') Then'
      
        '      Result := '#39'Em Experi'#234'ncia - mais 45 dias'#39';                ' +
        '    '
      '  End'
      '  Else'
      '    Result := '#39#39';  '
      'end;  '
      '          '
      ''
      'procedure rllEmExp02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllEmExp02.Text := fRetornaEmExperiencia;'
      'end;'
      ''
      'procedure rllEmExp01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllEmExp01.Text := fRetornaEmExperiencia;'
      'end;'
      '    '
      'procedure rllCEP01OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(<frxRelatorio."FUN_C_E_P_">) = '#39#39') Then'
      '    rllCEP01.Text := '#39#39
      '  else'
      
        '    rllCEP01.Text := fFormataCEPInterna(Trim(<frxRelatorio."FUN_' +
        'C_E_P_">));  '
      'end;'
      ''
      'procedure rllCEP02OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(<frxRelatorio."FUN_C_E_P_">) = '#39#39') Then'
      '    rllCEP02.Text := '#39#39
      '  else'
      
        '    rllCEP02.Text := fFormataCEPInterna(Trim(<frxRelatorio."FUN_' +
        'C_E_P_">));  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 224
    Top = 48
    Datasets = <
      item
        DataSet = frxBeneficia
        DataSetName = 'frxBeneficia'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
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
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 582.047610240000000000
        ParentFont = False
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        StartNewPage = True
        Stretched = True
        object Shape84: TfrxShapeView
          Left = 653.858690000000000000
          Top = 321.141930000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
        end
        object Shape83: TfrxShapeView
          Left = 653.858690000000000000
          Top = 294.685219999999900000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
        end
        object Shape1: TfrxShapeView
          Top = 3.779529999999994000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape2: TfrxShapeView
          Left = 302.362400000000000000
          Top = 3.779529999999994000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape3: TfrxShapeView
          Left = 415.748300000000000000
          Top = 3.779529999999994000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape6: TfrxShapeView
          Top = 22.677179999999990000
          Width = 359.055350000000100000
          Height = 18.897650000000000000
        end
        object Shape14: TfrxShapeView
          Left = 527.693260000000000000
          Top = 98.149660000000010000
          Width = 190.110243540000000000
          Height = 18.897650000000000000
        end
        object Shape39: TfrxShapeView
          Top = 438.086890000000100000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape40: TfrxShapeView
          Left = 302.362400000000000000
          Top = 438.086890000000100000
          Width = 415.748031496063000000
          Height = 18.897650000000000000
        end
        object Shape42: TfrxShapeView
          Top = 456.984540000000100000
          Width = 718.110236220471900000
          Height = 113.385797480000000000
        end
        object Memo1: TfrxMemoView
          Left = 302.362400000000000000
          Top = 3.779529999999994000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 415.748300000000000000
          Top = 3.779529999999994000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt. Admiss'#227'o')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 22.677179999999990000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 441.338900000000000000
          Top = 98.149660000000010000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'R.G.')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Top = 456.984540000000100000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 3.779530000000000000
          Top = 6.559060000000003000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS GERAIS')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 3.779530000000000000
          Top = 440.866420000000100000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 461.575140000000000000
          Top = 104.267780000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NUM_RG"]')
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 336.378170000000000000
          Top = 10.338590000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CODFUN"]')
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 464.882190000000000000
          Top = 10.338590000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTAADM"]')
          ParentFont = False
        end
        object Memo161: TfrxMemoView
          Left = 11.338590000000000000
          Top = 469.102660000000000000
          Width = 706.772110000000000000
          Height = 98.267687240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_OBSERV"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 28.015770000000000000
          Top = 26.236240000000010000
          Width = 325.039580000000100000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMFUN"]')
          ParentFont = False
        end
        object Shape7: TfrxShapeView
          Top = 41.677179999999990000
          Width = 718.110700000000000000
          Height = 18.897637800000000000
        end
        object Memo7: TfrxMemoView
          Left = -0.251700000000000000
          Top = 41.677179999999990000
          Width = 453.543600000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 39.882190000000000000
          Top = 45.236240000000010000
          Width = 672.756340000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Shape8: TfrxShapeView
          Top = 79.252010000000010000
          Width = 415.748031500000000000
          Height = 18.897650000000000000
        end
        object Memo9: TfrxMemoView
          Top = 79.252010000000010000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 39.354360000000000000
          Top = 82.811070000000000000
          Width = 366.614410000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 415.771809760000000000
          Top = 79.252010000000010000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo3: TfrxMemoView
          Left = 415.748300000000000000
          Top = 79.252010000000010000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fun'#231#227'o')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 455.882190000000000000
          Top = 82.811070000000000000
          Width = 166.299320000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_FUNCAO"]')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Left = 566.953009760000000000
          Top = 3.779529999999994000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Memo32: TfrxMemoView
          Left = 616.063390000000000000
          Top = 10.338590000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTANAS"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779529999999994000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt. Nascimento')
          ParentFont = False
        end
        object Shape9: TfrxShapeView
          Left = 358.566929130000000000
          Top = 98.165429999999990000
          Width = 82.771572990000000000
          Height = 18.897650000000000000
        end
        object Memo39: TfrxMemoView
          Left = 247.094620000000000000
          Top = 98.165429999999990000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.P.F.')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 286.889920000000000000
          Top = 104.267780000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_C_P_F_">]')
          ParentFont = False
        end
        object Shape10: TfrxShapeView
          Top = 98.165429999999990000
          Width = 102.803125200000000000
          Height = 18.897637800000000000
        end
        object Memo12: TfrxMemoView
          Left = 0.338590000000000000
          Top = 97.708720000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CTPS.')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 32.133890000000000000
          Top = 104.267780000000000000
          Width = 68.031540000000010000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_N_CTPS">]')
          ParentFont = False
        end
        object Shape11: TfrxShapeView
          Left = 140.401574800000000000
          Top = 98.165429999999990000
          Width = 106.582667400000000000
          Height = 18.897637800000000000
        end
        object Memo42: TfrxMemoView
          Left = 140.315090000000000000
          Top = 97.708720000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Num. S'#233'rie')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 188.110390000000000000
          Top = 104.267780000000000000
          Width = 56.692901180000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMSER">]')
          ParentFont = False
        end
        object Shape12: TfrxShapeView
          Top = 154.401670000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Memo13: TfrxMemoView
          Top = 154.401670000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grau de Instru'#231#227'o')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 72.149660000000000000
          Top = 157.960730000000000000
          Width = 336.378170000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_GRAINS"]')
          ParentFont = False
        end
        object Shape13: TfrxShapeView
          Left = 415.771809760000000000
          Top = 154.401670000000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
        end
        object Memo34: TfrxMemoView
          Left = 415.748300000000000000
          Top = 154.401670000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nacionalidade')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 474.000310000000000000
          Top = 157.960730000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NACION"]')
          ParentFont = False
        end
        object Shape15: TfrxShapeView
          Top = 173.299320000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
        end
        object Memo45: TfrxMemoView
          Top = 173.299320000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome M'#227'e')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 44.472480000000000000
          Top = 176.858380000000000000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMMAE"]')
          ParentFont = False
        end
        object Shape16: TfrxShapeView
          Left = 359.078859760000000000
          Top = 173.299320000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
        end
        object Memo47: TfrxMemoView
          Left = 359.055350000000000000
          Top = 173.299320000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome Pai')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 398.527830000000000000
          Top = 176.858380000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMPAI"]')
          ParentFont = False
        end
        object Shape17: TfrxShapeView
          Top = 192.196970000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo49: TfrxMemoView
          Top = 192.196970000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Nascimento')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 80.708720000000000000
          Top = 195.756030000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CID_NOMCID"]')
          ParentFont = False
        end
        object Shape18: TfrxShapeView
          Left = 302.141930000000000000
          Top = 192.196970000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
        end
        object Memo51: TfrxMemoView
          Left = 302.141930000000000000
          Top = 192.196970000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Certificado Militar')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 375.512060000000000000
          Top = 195.756030000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CERMIL"]')
          ParentFont = False
        end
        object Shape27: TfrxShapeView
          Left = 551.834889760000000000
          Top = 192.196970000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
        end
        object Memo53: TfrxMemoView
          Left = 551.811380000000000000
          Top = 192.196970000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 599.283860000000000000
          Top = 195.756030000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_ESTCIV"]')
          ParentFont = False
        end
        object Shape43: TfrxShapeView
          Top = 211.094620000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape44: TfrxShapeView
          Left = 302.385909760000000000
          Top = 211.094620000000000000
          Width = 415.748031500000000000
          Height = 18.897650000000000000
        end
        object Memo57: TfrxMemoView
          Left = 3.779530000000000000
          Top = 213.874150000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Conta Corrente')
          ParentFont = False
        end
        object Shape45: TfrxShapeView
          Top = 229.992270000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo55: TfrxMemoView
          Top = 229.992270000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 35.574830000000000000
          Top = 233.551330000000000000
          Width = 260.787570000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_BANCO_"] - [frxRelatorio."BCO_NOMBCO"]')
          ParentFont = False
        end
        object Shape46: TfrxShapeView
          Left = 302.141930000000000000
          Top = 229.992270000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo58: TfrxMemoView
          Left = 302.141930000000000000
          Top = 229.992270000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 336.716760000000000000
          Top = 233.551330000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_AGENCI"]')
          ParentFont = False
        end
        object Shape47: TfrxShapeView
          Left = 510.260059760000000000
          Top = 229.992270000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo60: TfrxMemoView
          Left = 514.016080000000000000
          Top = 229.992270000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Conta')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 543.811380000000000000
          Top = 233.551330000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CONTA_"]')
          ParentFont = False
        end
        object Shape48: TfrxShapeView
          Top = 400.512060000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape49: TfrxShapeView
          Left = 302.362400000000000000
          Top = 400.512060000000000000
          Width = 415.748031496063000000
          Height = 18.897650000000000000
        end
        object Memo62: TfrxMemoView
          Left = 3.779530000000000000
          Top = 403.291590000000100000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Desligamento')
          ParentFont = False
        end
        object Shape50: TfrxShapeView
          Top = 419.409710000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Memo63: TfrxMemoView
          Top = 419.409710000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 35.574830000000000000
          Top = 422.968770000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTADEM"]')
          ParentFont = False
        end
        object Shape52: TfrxShapeView
          Left = 113.385900000000000000
          Top = 419.409710000000000000
          Width = 604.724409448818900000
          Height = 18.897650000000000000
        end
        object Memo67: TfrxMemoView
          Left = 117.165430000000000000
          Top = 419.409710000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Motivo')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 146.960730000000000000
          Top = 422.968770000000100000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_MOTDES"]')
          ParentFont = False
        end
        object Shape20: TfrxShapeView
          Left = 510.260059760000000000
          Top = 117.047310000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo17: TfrxMemoView
          Left = 511.118430000000000000
          Top = 117.504020000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Se'#231#227'o')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 548.913730000000000000
          Top = 123.606370000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_SECTIT">]')
          ParentFont = False
        end
        object Shape21: TfrxShapeView
          Left = 140.000000000000000000
          Top = 117.047310000000000000
          Width = 204.094417400000000000
          Height = 18.897650000000000000
        end
        object Memo19: TfrxMemoView
          Left = 140.385900000000000000
          Top = 117.047310000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'T'#237'tulo de Eleitor')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 201.417440000000000000
          Top = 123.606370000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMTIT">]')
          ParentFont = False
        end
        object Shape22: TfrxShapeView
          Left = 313.700990000000000000
          Top = 117.047310000000000000
          Width = 196.535433070000000000
          Height = 18.897650000000000000
        end
        object Memo21: TfrxMemoView
          Left = 314.700990000000000000
          Top = 117.047310000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Zona')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 339.819110000000000000
          Top = 123.606370000000000000
          Width = 158.740260000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_ZONTIT">]')
          ParentFont = False
        end
        object Shape19: TfrxShapeView
          Left = 510.260059760000000000
          Top = 135.944960000000000000
          Width = 207.874150000000000000
          Height = 18.897637800000000000
        end
        object Memo15: TfrxMemoView
          Left = 511.118430000000000000
          Top = 136.401670000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Validade')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 575.370440000000000000
          Top = 142.504020000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_VALHAB">]')
          ParentFont = False
        end
        object Shape23: TfrxShapeView
          Top = 135.944960000000000000
          Width = 313.700787400000000000
          Height = 18.897650000000000000
        end
        object Memo23: TfrxMemoView
          Top = 135.944960000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#186' Carteira Habilita'#231#227'o')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 87.708720000000000000
          Top = 142.504020000000000000
          Width = 219.212740000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_CARHAB">]')
          ParentFont = False
        end
        object Shape24: TfrxShapeView
          Left = 313.700990000000000000
          Top = 135.944960000000000000
          Width = 196.535433070000000000
          Height = 18.897637800000000000
        end
        object Memo25: TfrxMemoView
          Left = 314.700990000000000000
          Top = 135.944960000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Categoria')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 358.716760000000000000
          Top = 142.504020000000000000
          Width = 139.842610000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_CATHAB">]')
          ParentFont = False
        end
        object Shape25: TfrxShapeView
          Top = 248.574817800000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape26: TfrxShapeView
          Left = 302.385909760000000000
          Top = 248.574817800000000000
          Width = 415.748031500000000000
          Height = 18.897650000000000000
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 251.220487090000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Hor'#225'rio de Trabalho')
          ParentFont = False
        end
        object Shape28: TfrxShapeView
          Top = 267.346630000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape29: TfrxShapeView
          Left = 151.181200000000000000
          Top = 267.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape30: TfrxShapeView
          Left = 226.771800000000000000
          Top = 267.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape31: TfrxShapeView
          Left = 302.362400000000000000
          Top = 267.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape32: TfrxShapeView
          Left = 377.953000000000000000
          Top = 267.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape33: TfrxShapeView
          Left = 453.543600000000000000
          Top = 267.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo28: TfrxMemoView
          Left = 306.141930000000000000
          Top = 271.126160000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 271.126160000000000000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Domingo das')
          ParentFont = False
        end
        object Shape34: TfrxShapeView
          Top = 286.126160000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape35: TfrxShapeView
          Left = 151.181200000000000000
          Top = 286.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape36: TfrxShapeView
          Left = 226.771800000000000000
          Top = 286.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape37: TfrxShapeView
          Left = 302.362400000000000000
          Top = 286.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape38: TfrxShapeView
          Left = 377.953000000000000000
          Top = 286.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape41: TfrxShapeView
          Left = 453.543600000000000000
          Top = 286.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo30: TfrxMemoView
          Left = 306.141930000000000000
          Top = 289.905690000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 289.905690000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Segunda das')
          ParentFont = False
        end
        object Shape51: TfrxShapeView
          Top = 305.023810000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape53: TfrxShapeView
          Left = 151.181200000000000000
          Top = 305.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape54: TfrxShapeView
          Left = 226.771800000000000000
          Top = 305.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape55: TfrxShapeView
          Left = 302.362400000000000000
          Top = 305.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape56: TfrxShapeView
          Left = 377.953000000000000000
          Top = 305.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape57: TfrxShapeView
          Left = 453.543600000000000000
          Top = 305.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo35: TfrxMemoView
          Left = 306.141930000000000000
          Top = 308.803340000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 308.803340000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Ter'#231'a das')
          ParentFont = False
        end
        object Shape58: TfrxShapeView
          Top = 323.803340000000100000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape59: TfrxShapeView
          Left = 151.181200000000000000
          Top = 323.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape60: TfrxShapeView
          Left = 226.771800000000000000
          Top = 323.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape61: TfrxShapeView
          Left = 302.362400000000000000
          Top = 323.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape62: TfrxShapeView
          Left = 377.953000000000000000
          Top = 323.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape63: TfrxShapeView
          Left = 453.543600000000000000
          Top = 323.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo37: TfrxMemoView
          Left = 306.141930000000000000
          Top = 327.582869999999900000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 3.779530000000000000
          Top = 327.582869999999900000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quarta das')
          ParentFont = False
        end
        object Shape64: TfrxShapeView
          Top = 342.819110000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape65: TfrxShapeView
          Left = 151.181200000000000000
          Top = 342.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape66: TfrxShapeView
          Left = 226.771800000000000000
          Top = 342.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape67: TfrxShapeView
          Left = 302.362400000000000000
          Top = 342.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape68: TfrxShapeView
          Left = 377.953000000000000000
          Top = 342.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape69: TfrxShapeView
          Left = 453.543600000000000000
          Top = 342.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo66: TfrxMemoView
          Left = 306.141930000000000000
          Top = 346.598640000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 3.779530000000000000
          Top = 346.598640000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quinta das')
          ParentFont = False
        end
        object Shape70: TfrxShapeView
          Top = 361.716760000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape71: TfrxShapeView
          Left = 151.181200000000000000
          Top = 361.716760000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape72: TfrxShapeView
          Left = 226.771800000000000000
          Top = 361.716760000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape73: TfrxShapeView
          Left = 302.362400000000000000
          Top = 361.716760000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape74: TfrxShapeView
          Left = 377.953000000000000000
          Top = 361.716760000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape75: TfrxShapeView
          Left = 453.543600000000000000
          Top = 361.716760000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo70: TfrxMemoView
          Left = 306.141930000000000000
          Top = 366.496290000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 3.779530000000000000
          Top = 366.496290000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Sexta das')
          ParentFont = False
        end
        object Shape76: TfrxShapeView
          Top = 381.496290000000100000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape77: TfrxShapeView
          Left = 151.181200000000000000
          Top = 381.496290000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape78: TfrxShapeView
          Left = 226.771800000000000000
          Top = 381.496290000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape79: TfrxShapeView
          Left = 302.362400000000000000
          Top = 381.496290000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape80: TfrxShapeView
          Left = 377.953000000000000000
          Top = 381.496290000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape81: TfrxShapeView
          Left = 453.543600000000000000
          Top = 381.496290000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo72: TfrxMemoView
          Left = 306.141930000000000000
          Top = 385.275819999999900000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 3.779530000000000000
          Top = 385.275819999999900000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'S'#225'bado das')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 158.740260000000000000
          Top = 271.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo75: TfrxMemoView
          Left = 232.771800000000000000
          Top = 271.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo76: TfrxMemoView
          Left = 383.953000000000000000
          Top = 271.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo77: TfrxMemoView
          Left = 457.984540000000000000
          Top = 271.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo78: TfrxMemoView
          Left = 158.740260000000000000
          Top = 289.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo79: TfrxMemoView
          Left = 232.771800000000000000
          Top = 289.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo80: TfrxMemoView
          Left = 383.953000000000000000
          Top = 289.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo81: TfrxMemoView
          Left = 457.984540000000000000
          Top = 289.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo82: TfrxMemoView
          Left = 158.740260000000000000
          Top = 308.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo83: TfrxMemoView
          Left = 232.771800000000000000
          Top = 327.582869999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo84: TfrxMemoView
          Left = 383.953000000000000000
          Top = 308.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo85: TfrxMemoView
          Left = 457.984540000000000000
          Top = 308.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo86: TfrxMemoView
          Left = 158.740260000000000000
          Top = 327.582869999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo87: TfrxMemoView
          Left = 232.771800000000000000
          Top = 346.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo88: TfrxMemoView
          Left = 383.953000000000000000
          Top = 327.582869999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo89: TfrxMemoView
          Left = 457.984540000000000000
          Top = 327.582869999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo90: TfrxMemoView
          Left = 158.740260000000000000
          Top = 346.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo91: TfrxMemoView
          Left = 232.771800000000000000
          Top = 366.496290000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo92: TfrxMemoView
          Left = 383.953000000000000000
          Top = 346.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo93: TfrxMemoView
          Left = 457.984540000000000000
          Top = 346.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo94: TfrxMemoView
          Left = 158.740260000000000000
          Top = 366.496290000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo95: TfrxMemoView
          Left = 232.771800000000000000
          Top = 385.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo96: TfrxMemoView
          Left = 383.953000000000000000
          Top = 366.496290000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo97: TfrxMemoView
          Left = 457.984540000000000000
          Top = 366.496290000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo98: TfrxMemoView
          Left = 158.740260000000000000
          Top = 385.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo99: TfrxMemoView
          Left = 232.771800000000000000
          Top = 308.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo100: TfrxMemoView
          Left = 383.953000000000000000
          Top = 385.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo101: TfrxMemoView
          Left = 457.984540000000000000
          Top = 385.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Shape82: TfrxShapeView
          Left = 529.134200000000000000
          Top = 267.346630000000000000
          Width = 188.976377950000000000
          Height = 133.039370080000000000
        end
        object Memo102: TfrxMemoView
          Left = 555.590910000000000000
          Top = 298.464750000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O DE PONTO')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo103: TfrxMemoView
          Left = 555.590910000000000000
          Top = 324.921460000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTRO')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo104: TfrxMemoView
          Left = 657.638220000000000000
          Top = 298.464750000000000000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF( <frxRelatorio."FUN_CARPON"> = '#39'S'#39', '#39'X'#39', '#39#39' )]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo105: TfrxMemoView
          Left = 657.638220000000000000
          Top = 324.921460000000000000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF( <frxRelatorio."FUN_REGIST"> = '#39'S'#39', '#39'X'#39', '#39#39' )]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Shape89: TfrxShapeView
          Left = 246.819110000000000000
          Top = 98.149660000000010000
          Width = 111.874015750000000000
          Height = 18.897637800000000000
        end
        object Memo111: TfrxMemoView
          Left = 0.811070000000000000
          Top = 117.047310000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PIS/PASEP')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 49.724490000000000000
          Top = 121.826840000000000000
          Width = 68.031540000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_PISPAS">]')
          ParentFont = False
        end
        object Shape90: TfrxShapeView
          Left = 566.929133860000000000
          Top = 22.677179999999990000
          Width = 151.181099920000000000
          Height = 18.897650000000000000
        end
        object Memo113: TfrxMemoView
          Left = 568.268338980000000000
          Top = 22.677179999999990000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEL')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 598.504578980000000000
          Top = 28.795300000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo114OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NUMCEL"]')
          ParentFont = False
        end
        object Shape91: TfrxShapeView
          Left = 415.748300000000000000
          Top = 22.692950000000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
        end
        object Memo115: TfrxMemoView
          Left = 416.394188980000000000
          Top = 22.692950000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TEL')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 447.189488980000000000
          Top = 28.795300000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo118OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMTEL">]')
          ParentFont = False
        end
        object Shape179: TfrxShapeView
          Top = 60.472480000000000000
          Width = 359.055081500000000000
          Height = 18.897650000000000000
        end
        object Memo240: TfrxMemoView
          Top = 60.472479999999990000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo241: TfrxMemoView
          Left = 39.354360000000000000
          Top = 64.031540000000000000
          Width = 317.480520000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_ENDERE"] [frxRelatorio."FUN_ENDNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Shape180: TfrxShapeView
          Left = 487.582879760000000000
          Top = 60.472480000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
        end
        object Memo242: TfrxMemoView
          Left = 491.338582680000000000
          Top = 60.472480000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo243: TfrxMemoView
          Left = 529.133858270000000000
          Top = 64.031540000000000000
          Width = 185.196850393700800000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_BAIRRO"]')
          ParentFont = False
        end
        object Shape186: TfrxShapeView
          Left = 625.520100000000000000
          Top = 98.267779999999990000
          Width = 92.598425196850380000
          Height = 18.897650000000000000
        end
        object Memo258: TfrxMemoView
          Left = 624.520100000000000000
          Top = 98.267779999999990000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Org'#227'o expe')
          ParentFont = False
        end
        object Memo259: TfrxMemoView
          Left = 668.197280000000000000
          Top = 104.314960630000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NRGEXP"]  [frxRelatorio."FUN_RG_CUF"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo262: TfrxMemoView
          Left = 361.716760000000000000
          Top = 22.677179999999990000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sexo')
          ParentFont = False
        end
        object Memo263: TfrxMemoView
          Left = 386.953000000000000000
          Top = 26.456710000000020000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_SEXOFU"]')
          ParentFont = False
        end
        object Shape188: TfrxShapeView
          Left = 625.401980000000000000
          Top = 79.370129999999990000
          Width = 92.598425196850380000
          Height = 18.897650000000000000
        end
        object Memo264: TfrxMemoView
          Left = 627.401980000000000000
          Top = 79.370129999999990000
          Width = 22.677179999999990000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CBO')
          ParentFont = False
        end
        object Memo265: TfrxMemoView
          Left = 653.858690000000000000
          Top = 83.149660000000010000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CODCBO"]')
          ParentFont = False
        end
        object Shape189: TfrxShapeView
          Top = 117.165430000000000000
          Width = 139.842519685039400000
          Height = 18.897637800000000000
        end
        object Memo266: TfrxMemoView
          Left = 103.047310000000000000
          Top = 98.267779999999990000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UF')
          ParentFont = False
        end
        object Memo267: TfrxMemoView
          Left = 119.944960000000000000
          Top = 104.826840000000000000
          Width = 18.897650000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_CTPSUF">]')
          ParentFont = False
        end
        object Memo268: TfrxMemoView
          Left = 357.834880000000000000
          Top = 98.267779999999990000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo269: TfrxMemoView
          Left = 389.291590000000000000
          Top = 104.385900000000000000
          Width = 50.267716535433080000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CPFDEM"]')
          ParentFont = False
        end
        object Memo270: TfrxMemoView
          Left = 530.354670000000100000
          Top = 98.267779999999990000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emiss'#227'o')
          ParentFont = False
        end
        object Memo271: TfrxMemoView
          Left = 569.929499999999900000
          Top = 104.385900000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUNC_RGDEM"]')
          ParentFont = False
        end
        object Memo272: TfrxMemoView
          Left = 360.055350000000000000
          Top = 60.472480000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object rllCEP01: TfrxMemoView
          Left = 385.850625590000000000
          Top = 64.031540000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'rllCEP01OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_C_E_P_"]')
          ParentFont = False
        end
        object rllEmExp01: TfrxMemoView
          Left = 304.141930000000000000
          Top = 215.433210000000000000
          Width = 377.953000000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'rllEmExp01OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 1474.016700000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661409999999933000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baClient
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 68.031540000000010000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Header1OnBeforePrint'
        ReprintOnNewPage = True
        object Memo256: TfrxMemoView
          Left = 11.338590000000000000
          Top = 1.000000000000000000
          Width = 691.653990000000000000
          Height = 11.338590000000000000
          Visible = False
          OnAfterData = 'Memo256OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_FOTO01"]')
          ParentFont = False
        end
        object Memo257: TfrxMemoView
          Left = 11.338590000000000000
          Top = 15.118120000000000000
          Width = 691.653990000000000000
          Height = 11.338590000000000000
          Visible = False
          OnAfterData = 'Memo256OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_FOTO02"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 189.845950000000000000
          Top = 35.897650000000000000
          Width = 338.418800000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object FOTO_FUNCIONARIO: TfrxPictureView
          Left = 638.740570000000000000
          Width = 75.590600000000000000
          Height = 64.252010000000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 1.000000000000000000
          Width = 729.600000000000000000
          Height = 32.118120000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1319.055970000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Shape85: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape86: TfrxShapeView
          Left = 302.362400000000000000
          Width = 415.748031496063000000
          Height = 18.897650000000000000
        end
        object Memo106: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000022000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'BENEFICI'#193'RIOS')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 1364.410330000000000000
        Width = 718.110700000000000000
        DataSet = frxBeneficia
        DataSetName = 'frxBeneficia'
        RowCount = 0
        Stretched = True
        object Shape87: TfrxShapeView
          Width = 359.055350000000000000
          Height = 18.897650000000000000
        end
        object Memo107: TfrxMemoView
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome ')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 44.472480000000000000
          Top = 3.559060000000045000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxBeneficia."BNF_NOMBEN"]')
          ParentFont = False
        end
        object Shape88: TfrxShapeView
          Left = 359.078859760000000000
          Width = 359.055118110236000000
          Height = 18.897650000000000000
        end
        object Memo109: TfrxMemoView
          Left = 359.055350000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grau de Parentesco')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 440.102660000000000000
          Top = 3.559060000000045000
          Width = 272.126160000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxBeneficia."BNF_GRAPAR"]')
          ParentFont = False
        end
        object Shape183: TfrxShapeView
          Top = 18.897650000000110000
          Width = 238.110236220000000000
          Height = 18.897650000000000000
        end
        object Shape184: TfrxShapeView
          Left = 238.110390000000000000
          Top = 18.897650000000110000
          Width = 241.889766220000000000
          Height = 18.897650000000000000
        end
        object Shape185: TfrxShapeView
          Left = 480.000310000000000000
          Top = 18.897650000000110000
          Width = 237.732283464567000000
          Height = 18.897650000000000000
        end
        object Memo250: TfrxMemoView
          Top = 18.897650000000110000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento de Identidade (RG):')
          ParentFont = False
        end
        object Memo251: TfrxMemoView
          Left = 238.110390000000000000
          Top = 18.897650000000110000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF:')
          ParentFont = False
        end
        object Memo252: TfrxMemoView
          Left = 480.000310000000000000
          Top = 18.897650000000110000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Nascimento:')
          ParentFont = False
        end
        object Memo253: TfrxMemoView
          Left = 120.944960000000000000
          Top = 23.433070866141640000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxBeneficia."BNF_NUMRG"]')
          ParentFont = False
        end
        object Memo254: TfrxMemoView
          Left = 283.464750000000000000
          Top = 23.433070866141640000
          Width = 173.858380000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxBeneficia."BNF_NUMCPF"]')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 563.149970000000000000
          Top = 23.433070869999940000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = 'Value = 0'
          Highlight.FillType = ftBrush
          Highlight.Visible = False
          Memo.UTF8W = (
            '[frxBeneficia."BNF_DTANAS"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 582.047610240000000000
        ParentFont = False
        Top = 714.331170000000000000
        Width = 718.110700000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        StartNewPage = True
        Stretched = True
        object Shape92: TfrxShapeView
          Left = 653.858690000000000000
          Top = 325.141929999999900000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
        end
        object Shape93: TfrxShapeView
          Left = 653.858690000000000000
          Top = 298.685219999999900000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
        end
        object Shape94: TfrxShapeView
          Top = 3.779530000000022000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape95: TfrxShapeView
          Left = 302.362400000000000000
          Top = 3.779530000000022000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape96: TfrxShapeView
          Left = 415.748300000000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape97: TfrxShapeView
          Top = 22.677180000000020000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Shape99: TfrxShapeView
          Top = 442.086889999999900000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape100: TfrxShapeView
          Left = 302.362400000000000000
          Top = 442.086889999999900000
          Width = 415.748031496063000000
          Height = 18.897650000000000000
        end
        object Shape101: TfrxShapeView
          Top = 460.984540000000100000
          Width = 718.110236220471900000
          Height = 113.385797480000000000
        end
        object Memo119: TfrxMemoView
          Left = 302.362400000000000000
          Top = 3.779530000000022000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 415.748300000000000000
          Top = 3.779530000000022000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt. Admiss'#227'o')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Top = 22.677180000000020000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Top = 460.984540000000100000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 3.779530000000000000
          Top = 6.559060000000045000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS GERAIS')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 3.779530000000000000
          Top = 444.866419999999900000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 336.378170000000000000
          Top = 10.338589999999950000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CODFUN"]')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 464.882190000000000000
          Top = 10.338589999999950000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTAADM"]')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 11.338590000000000000
          Top = 473.102659999999900000
          Width = 706.772110000000000000
          Height = 98.267687240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_OBSERV"]')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 28.015770000000000000
          Top = 26.236239999999950000
          Width = 381.732530000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMFUN"]')
          ParentFont = False
        end
        object Shape102: TfrxShapeView
          Top = 41.677180000000020000
          Width = 718.110236220471900000
          Height = 18.897637800000000000
        end
        object Memo131: TfrxMemoView
          Left = -0.251700000000000000
          Top = 41.677180000000020000
          Width = 453.543600000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 39.882190000000000000
          Top = 45.236239999999960000
          Width = 672.756340000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Shape103: TfrxShapeView
          Top = 80.252010000000040000
          Width = 415.748031500000000000
          Height = 18.897650000000000000
        end
        object Memo133: TfrxMemoView
          Top = 80.252010000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 39.354360000000000000
          Top = 83.811069999999970000
          Width = 366.614410000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Shape104: TfrxShapeView
          Left = 415.771809760000000000
          Top = 80.252010000000040000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo135: TfrxMemoView
          Left = 415.748300000000000000
          Top = 80.252010000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fun'#231#227'o')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 455.882190000000000000
          Top = 83.811069999999970000
          Width = 257.008040000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_FUNCAO"]')
          ParentFont = False
        end
        object Shape105: TfrxShapeView
          Left = 566.953009760000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Memo137: TfrxMemoView
          Left = 616.063390000000000000
          Top = 10.338589999999950000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTANAS"]')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000022000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt. Nascimento')
          ParentFont = False
        end
        object Shape109: TfrxShapeView
          Top = 155.401670000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Memo146: TfrxMemoView
          Top = 155.401670000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Grau de Instru'#231#227'o')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 72.149660000000000000
          Top = 158.960730000000000000
          Width = 336.378170000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_GRAINS"]')
          ParentFont = False
        end
        object Shape110: TfrxShapeView
          Left = 415.771809760000000000
          Top = 155.401670000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo148: TfrxMemoView
          Left = 415.748300000000000000
          Top = 155.401670000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nacionalidade')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 474.000310000000000000
          Top = 158.960730000000000000
          Width = 241.889920000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NACION"]')
          ParentFont = False
        end
        object Shape111: TfrxShapeView
          Top = 174.299320000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
        end
        object Memo150: TfrxMemoView
          Top = 174.299320000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome M'#227'e')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 44.472480000000000000
          Top = 177.858380000000000000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMMAE"]')
          ParentFont = False
        end
        object Shape112: TfrxShapeView
          Left = 359.078859760000000000
          Top = 174.299320000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
        end
        object Memo152: TfrxMemoView
          Left = 359.055350000000000000
          Top = 174.299320000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome Pai')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 398.527830000000000000
          Top = 177.858380000000000000
          Width = 313.700990000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NOMPAI"]')
          ParentFont = False
        end
        object Shape113: TfrxShapeView
          Top = 193.196970000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo154: TfrxMemoView
          Top = 193.196970000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Local de Nascimento')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Left = 80.708720000000000000
          Top = 196.756030000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CID_NOMCID"]')
          ParentFont = False
        end
        object Shape114: TfrxShapeView
          Left = 302.141930000000000000
          Top = 193.196970000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
        end
        object Memo156: TfrxMemoView
          Left = 302.141930000000000000
          Top = 193.196970000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Certificado Militar')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 375.512060000000000000
          Top = 196.756030000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CERMIL"]')
          ParentFont = False
        end
        object Shape115: TfrxShapeView
          Left = 551.834889760000000000
          Top = 193.196970000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
        end
        object Memo158: TfrxMemoView
          Left = 551.811380000000000000
          Top = 193.196970000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 599.283860000000000000
          Top = 196.756030000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_ESTCIV"]')
          ParentFont = False
        end
        object Shape116: TfrxShapeView
          Top = 215.094620000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape117: TfrxShapeView
          Left = 302.385909760000000000
          Top = 215.094620000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Memo160: TfrxMemoView
          Left = 3.779530000000000000
          Top = 217.874150000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Conta Corrente')
          ParentFont = False
        end
        object Shape118: TfrxShapeView
          Top = 233.992270000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Memo164: TfrxMemoView
          Top = 233.992270000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 35.574830000000000000
          Top = 237.551330000000000000
          Width = 260.787570000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_BANCO_"] - [frxRelatorio."BCO_NOMBCO"]')
          ParentFont = False
        end
        object Shape119: TfrxShapeView
          Left = 302.141930000000000000
          Top = 233.992270000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo166: TfrxMemoView
          Left = 302.141930000000000000
          Top = 233.992270000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 336.716760000000000000
          Top = 237.551330000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_AGENCI"]')
          ParentFont = False
        end
        object Shape120: TfrxShapeView
          Left = 510.260059760000000000
          Top = 233.992270000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo168: TfrxMemoView
          Left = 514.016080000000000000
          Top = 233.992270000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Conta')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 543.811380000000000000
          Top = 237.551330000000000000
          Width = 170.078850000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_CONTA_"]')
          ParentFont = False
        end
        object Shape121: TfrxShapeView
          Top = 404.512059999999900000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape122: TfrxShapeView
          Left = 302.362400000000000000
          Top = 404.512059999999900000
          Width = 415.748031496063000000
          Height = 18.897650000000000000
        end
        object Memo170: TfrxMemoView
          Left = 3.779530000000000000
          Top = 407.291589999999900000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Desligamento')
          ParentFont = False
        end
        object Shape123: TfrxShapeView
          Top = 423.409710000000000000
          Width = 113.385826771654000000
          Height = 18.897650000000000000
        end
        object Memo171: TfrxMemoView
          Top = 423.409710000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 35.574830000000000000
          Top = 426.968770000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_DTADEM"]')
          ParentFont = False
        end
        object Shape124: TfrxShapeView
          Left = 113.385900000000000000
          Top = 423.409710000000000000
          Width = 604.724409448818900000
          Height = 18.897650000000000000
        end
        object Memo173: TfrxMemoView
          Left = 117.165430000000000000
          Top = 423.409710000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Motivo')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 146.960730000000000000
          Top = 426.968770000000100000
          Width = 566.929500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_MOTDES"]')
          ParentFont = False
        end
        object Shape125: TfrxShapeView
          Left = 510.260059760000000000
          Top = 118.047310000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
        end
        object Memo175: TfrxMemoView
          Left = 511.118430000000000000
          Top = 118.504020000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Se'#231#227'o')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 548.913730000000000000
          Top = 124.606370000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_SECTIT">]')
          ParentFont = False
        end
        object Shape126: TfrxShapeView
          Top = 118.047310000000000000
          Width = 313.700787401575000000
          Height = 18.897650000000000000
        end
        object Memo177: TfrxMemoView
          Top = 118.047310000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'T'#237'tulo de Eleitor')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 64.252010000000000000
          Top = 124.606370000000000000
          Width = 245.669450000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMTIT">]')
          ParentFont = False
        end
        object Shape127: TfrxShapeView
          Left = 313.700990000000000000
          Top = 118.047310000000000000
          Width = 196.535433070000000000
          Height = 18.897650000000000000
        end
        object Memo179: TfrxMemoView
          Left = 314.700990000000000000
          Top = 118.047310000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Zona')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 339.819110000000000000
          Top = 124.606370000000000000
          Width = 158.740260000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_ZONTIT">]')
          ParentFont = False
        end
        object Shape128: TfrxShapeView
          Left = 510.260059760000000000
          Top = 136.944960000000000000
          Width = 207.874150000000000000
          Height = 18.897637800000000000
        end
        object Memo181: TfrxMemoView
          Left = 511.118430000000000000
          Top = 137.401670000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Validade')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 575.370440000000000000
          Top = 143.504020000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_VALHAB">]')
          ParentFont = False
        end
        object Shape129: TfrxShapeView
          Top = 136.944960000000000000
          Width = 313.700787400000000000
          Height = 18.897650000000000000
        end
        object Memo183: TfrxMemoView
          Top = 136.944960000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#186' Carteira Habilita'#231#227'o')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 87.708720000000000000
          Top = 143.504020000000000000
          Width = 219.212740000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_CARHAB">]')
          ParentFont = False
        end
        object Shape130: TfrxShapeView
          Left = 313.700990000000000000
          Top = 136.944960000000000000
          Width = 196.535433070000000000
          Height = 18.897637800000000000
        end
        object Memo185: TfrxMemoView
          Left = 314.700990000000000000
          Top = 136.944960000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Categoria')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 358.716760000000000000
          Top = 143.504020000000000000
          Width = 139.842610000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_CATHAB">]')
          ParentFont = False
        end
        object Shape131: TfrxShapeView
          Top = 252.574817800000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape132: TfrxShapeView
          Left = 302.385909760000000000
          Top = 252.574817800000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Memo187: TfrxMemoView
          Left = 3.779530000000000000
          Top = 255.220487090000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Hor'#225'rio de Trabalho')
          ParentFont = False
        end
        object Shape133: TfrxShapeView
          Top = 271.346630000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape134: TfrxShapeView
          Left = 151.181200000000000000
          Top = 271.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape135: TfrxShapeView
          Left = 226.771800000000000000
          Top = 271.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape136: TfrxShapeView
          Left = 302.362400000000000000
          Top = 271.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape137: TfrxShapeView
          Left = 377.953000000000000000
          Top = 271.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape138: TfrxShapeView
          Left = 453.543600000000000000
          Top = 271.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo188: TfrxMemoView
          Left = 306.141930000000000000
          Top = 275.126160000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          Left = 3.779530000000000000
          Top = 275.126160000000000000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Domingo das')
          ParentFont = False
        end
        object Shape139: TfrxShapeView
          Top = 290.126160000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape140: TfrxShapeView
          Left = 151.181200000000000000
          Top = 290.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape141: TfrxShapeView
          Left = 226.771800000000000000
          Top = 290.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape142: TfrxShapeView
          Left = 302.362400000000000000
          Top = 290.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape143: TfrxShapeView
          Left = 377.953000000000000000
          Top = 290.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape144: TfrxShapeView
          Left = 453.543600000000000000
          Top = 290.126160000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo190: TfrxMemoView
          Left = 306.141930000000000000
          Top = 293.905690000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 3.779530000000000000
          Top = 293.905690000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Segunda das')
          ParentFont = False
        end
        object Shape145: TfrxShapeView
          Top = 309.023810000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape146: TfrxShapeView
          Left = 151.181200000000000000
          Top = 309.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape147: TfrxShapeView
          Left = 226.771800000000000000
          Top = 309.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape148: TfrxShapeView
          Left = 302.362400000000000000
          Top = 309.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape149: TfrxShapeView
          Left = 377.953000000000000000
          Top = 309.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape150: TfrxShapeView
          Left = 453.543600000000000000
          Top = 309.023810000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo192: TfrxMemoView
          Left = 306.141930000000000000
          Top = 312.803340000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 3.779530000000000000
          Top = 312.803340000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Ter'#231'a das')
          ParentFont = False
        end
        object Shape151: TfrxShapeView
          Top = 327.803340000000100000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape152: TfrxShapeView
          Left = 151.181200000000000000
          Top = 327.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape153: TfrxShapeView
          Left = 226.771800000000000000
          Top = 327.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape154: TfrxShapeView
          Left = 302.362400000000000000
          Top = 327.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape155: TfrxShapeView
          Left = 377.953000000000000000
          Top = 327.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape156: TfrxShapeView
          Left = 453.543600000000000000
          Top = 327.803340000000100000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo194: TfrxMemoView
          Left = 306.141930000000000000
          Top = 331.582870000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo195: TfrxMemoView
          Left = 3.779530000000000000
          Top = 331.582870000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quarta das')
          ParentFont = False
        end
        object Shape157: TfrxShapeView
          Top = 346.819110000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape158: TfrxShapeView
          Left = 151.181200000000000000
          Top = 346.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape159: TfrxShapeView
          Left = 226.771800000000000000
          Top = 346.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape160: TfrxShapeView
          Left = 302.362400000000000000
          Top = 346.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape161: TfrxShapeView
          Left = 377.953000000000000000
          Top = 346.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape162: TfrxShapeView
          Left = 453.543600000000000000
          Top = 346.819110000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo196: TfrxMemoView
          Left = 306.141930000000000000
          Top = 350.598640000000100000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo197: TfrxMemoView
          Left = 3.779530000000000000
          Top = 350.598640000000100000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quinta das')
          ParentFont = False
        end
        object Shape163: TfrxShapeView
          Top = 365.716759999999900000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape164: TfrxShapeView
          Left = 151.181200000000000000
          Top = 365.716759999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape165: TfrxShapeView
          Left = 226.771800000000000000
          Top = 365.716759999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape166: TfrxShapeView
          Left = 302.362400000000000000
          Top = 365.716759999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape167: TfrxShapeView
          Left = 377.953000000000000000
          Top = 365.716759999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape168: TfrxShapeView
          Left = 453.543600000000000000
          Top = 365.716759999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo198: TfrxMemoView
          Left = 306.141930000000000000
          Top = 370.496289999999900000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo199: TfrxMemoView
          Left = 3.779530000000000000
          Top = 370.496289999999900000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Sexta das')
          ParentFont = False
        end
        object Shape169: TfrxShapeView
          Top = 385.496289999999900000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape170: TfrxShapeView
          Left = 151.181200000000000000
          Top = 385.496289999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape171: TfrxShapeView
          Left = 226.771800000000000000
          Top = 385.496289999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape172: TfrxShapeView
          Left = 302.362400000000000000
          Top = 385.496289999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape173: TfrxShapeView
          Left = 377.953000000000000000
          Top = 385.496289999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape174: TfrxShapeView
          Left = 453.543600000000000000
          Top = 385.496289999999900000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Memo200: TfrxMemoView
          Left = 306.141930000000000000
          Top = 389.275819999999900000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'e das')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Left = 3.779530000000000000
          Top = 389.275819999999900000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'S'#225'bado das')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Left = 158.740260000000000000
          Top = 275.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo203: TfrxMemoView
          Left = 232.771800000000000000
          Top = 275.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo204: TfrxMemoView
          Left = 383.953000000000000000
          Top = 275.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo205: TfrxMemoView
          Left = 457.984540000000000000
          Top = 275.126160000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4DOM"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo206: TfrxMemoView
          Left = 158.740260000000000000
          Top = 293.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo207: TfrxMemoView
          Left = 232.771800000000000000
          Top = 293.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo208: TfrxMemoView
          Left = 383.953000000000000000
          Top = 293.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo209: TfrxMemoView
          Left = 457.984540000000000000
          Top = 293.905690000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SEG"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo210: TfrxMemoView
          Left = 158.740260000000000000
          Top = 312.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo211: TfrxMemoView
          Left = 232.771800000000000000
          Top = 331.582870000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo212: TfrxMemoView
          Left = 383.953000000000000000
          Top = 312.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo213: TfrxMemoView
          Left = 457.984540000000000000
          Top = 312.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo214: TfrxMemoView
          Left = 158.740260000000000000
          Top = 331.582870000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo215: TfrxMemoView
          Left = 232.771800000000000000
          Top = 350.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo216: TfrxMemoView
          Left = 383.953000000000000000
          Top = 331.582870000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo217: TfrxMemoView
          Left = 457.984540000000000000
          Top = 331.582870000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4QUA"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo218: TfrxMemoView
          Left = 158.740260000000000000
          Top = 350.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo219: TfrxMemoView
          Left = 232.771800000000000000
          Top = 370.496289999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo220: TfrxMemoView
          Left = 383.953000000000000000
          Top = 350.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo221: TfrxMemoView
          Left = 457.984540000000000000
          Top = 350.598640000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4QUI"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo222: TfrxMemoView
          Left = 158.740260000000000000
          Top = 370.496289999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo223: TfrxMemoView
          Left = 232.771800000000000000
          Top = 389.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo224: TfrxMemoView
          Left = 383.953000000000000000
          Top = 370.496289999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo225: TfrxMemoView
          Left = 457.984540000000000000
          Top = 370.496289999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SEX"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo226: TfrxMemoView
          Left = 158.740260000000000000
          Top = 389.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT1SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo227: TfrxMemoView
          Left = 232.771800000000000000
          Top = 312.803340000000100000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT2TER"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo228: TfrxMemoView
          Left = 383.953000000000000000
          Top = 389.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT3SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo229: TfrxMemoView
          Left = 457.984540000000000000
          Top = 389.275819999999900000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."FUN_HT4SAB"]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Shape175: TfrxShapeView
          Left = 529.134200000000000000
          Top = 271.346630000000000000
          Width = 188.976500000000000000
          Height = 133.039370080000000000
        end
        object Memo230: TfrxMemoView
          Left = 555.590910000000000000
          Top = 302.464750000000000000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O DE PONTO')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo231: TfrxMemoView
          Left = 555.590910000000000000
          Top = 328.921459999999900000
          Width = 94.488250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTRO')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo232: TfrxMemoView
          Left = 657.638220000000000000
          Top = 302.464750000000000000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF( <frxRelatorio."FUN_CARPON"> = '#39'S'#39', '#39'X'#39', '#39#39' )]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Memo233: TfrxMemoView
          Left = 657.638220000000000000
          Top = 328.921459999999900000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[IIF( <frxRelatorio."FUN_REGIST"> = '#39'S'#39', '#39'X'#39', '#39#39' )]')
          ParentFont = False
          SuppressRepeated = True
        end
        object Shape177: TfrxShapeView
          Left = 566.929133860000000000
          Top = 22.677180000000020000
          Width = 151.181099920000000000
          Height = 18.897650000000000000
        end
        object Memo236: TfrxMemoView
          Left = 568.268338980000000000
          Top = 22.677180000000020000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEL')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Left = 598.504578980000000000
          Top = 28.795300000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo114OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NUMCEL"]')
          ParentFont = False
        end
        object Shape178: TfrxShapeView
          Left = 415.748300000000000000
          Top = 22.692950000000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
        end
        object Memo238: TfrxMemoView
          Left = 416.394188980000000000
          Top = 22.692950000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TEL')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Left = 447.189488980000000000
          Top = 28.795300000000000000
          Width = 113.385900000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo118OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMTEL">]')
          ParentFont = False
        end
        object Shape181: TfrxShapeView
          Top = 61.252010000000000000
          Width = 359.055118110236200000
          Height = 18.897650000000000000
        end
        object Memo245: TfrxMemoView
          Top = 61.252010000000040000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 39.354360000000000000
          Top = 64.811070000000000000
          Width = 317.480520000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_ENDERE"] [frxRelatorio."FUN_ENDNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Shape182: TfrxShapeView
          Left = 487.559055118110200000
          Top = 61.252010000000000000
          Width = 230.551181102362200000
          Height = 18.897650000000000000
        end
        object Memo247: TfrxMemoView
          Left = 491.338582677165400000
          Top = 61.252010000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 529.133858267716500000
          Top = 64.811070000000000000
          Width = 185.196850393700800000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_BAIRRO"]')
          ParentFont = False
        end
        object Shape98: TfrxShapeView
          Left = 504.031850000000000000
          Top = 98.708719999999970000
          Width = 106.582677170000000000
          Height = 18.897650000000000000
        end
        object Memo122: TfrxMemoView
          Left = 505.031850000000000000
          Top = 98.708719999999970000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'R.G.')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 535.268090000000000000
          Top = 104.826840000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NUM_RG"]')
          ParentFont = False
        end
        object Shape106: TfrxShapeView
          Left = 383.511811020000000000
          Top = 98.724489999999950000
          Width = 120.566872990000000000
          Height = 18.897650000000000000
        end
        object Memo139: TfrxMemoView
          Left = 386.157700000000000000
          Top = 98.724489999999950000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.P.F.')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 425.953000000000000000
          Top = 104.826840000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_C_P_F_">]')
          ParentFont = False
        end
        object Shape107: TfrxShapeView
          Top = 98.724489999999950000
          Width = 140.598425200000000000
          Height = 18.897637800000000000
        end
        object Memo142: TfrxMemoView
          Left = 0.338590000000000000
          Top = 98.267780000000010000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.T.P.S.')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          Left = 38.133890000000000000
          Top = 104.826840000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_N_CTPS">]')
          ParentFont = False
        end
        object Shape108: TfrxShapeView
          Left = 140.401574800000000000
          Top = 98.724489999999950000
          Width = 121.700787400000000000
          Height = 18.897637800000000000
        end
        object Memo144: TfrxMemoView
          Left = 140.315090000000000000
          Top = 98.267780000000010000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Num. S'#233'rie')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 188.110390000000000000
          Top = 104.826840000000000000
          Width = 71.811021180000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_NUMSER">]')
          ParentFont = False
        end
        object Shape176: TfrxShapeView
          Left = 262.157700000000000000
          Top = 98.708719999999970000
          Width = 121.322834650000000000
          Height = 18.897637800000000000
        end
        object Memo234: TfrxMemoView
          Left = 265.157700000000000000
          Top = 98.708719999999970000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PIS/PASEP')
          ParentFont = False
        end
        object Memo235: TfrxMemoView
          Left = 314.071120000000000000
          Top = 103.488250000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."FUN_PISPAS">]')
          ParentFont = False
        end
        object Shape187: TfrxShapeView
          Left = 610.520100000000000000
          Top = 98.826839999999950000
          Width = 107.338582680000000000
          Height = 18.897650000000000000
        end
        object Memo260: TfrxMemoView
          Left = 612.520100000000000000
          Top = 98.826839999999950000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Org'#227'o expe')
          ParentFont = False
        end
        object Memo261: TfrxMemoView
          Left = 661.417750000000000000
          Top = 104.874020630000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_NRGEXP"]  [frxRelatorio."FUN_RG_CUF"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo274: TfrxMemoView
          Left = 359.055350000000000000
          Top = 60.472480000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object rllCEP02: TfrxMemoView
          Left = 384.850625590000000000
          Top = 64.031540000000000000
          Width = 98.267780000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'rllCEP02OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FUN_C_E_P_"]')
          ParentFont = False
        end
        object rllEmExp02: TfrxMemoView
          Left = 302.362400000000000000
          Top = 219.212740000000000000
          Width = 377.953000000000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'rllEmExp02OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
end
