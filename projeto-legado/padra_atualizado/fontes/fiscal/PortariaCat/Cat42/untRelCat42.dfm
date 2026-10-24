inherited frmRelCat42: TfrmRelCat42
  Width = 535
  Height = 447
  Caption = 'CAT-42'
  ExplicitWidth = 535
  ExplicitHeight = 447
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 374
    Width = 529
    ExplicitTop = 374
    ExplicitWidth = 529
    inherited btnSair: TBitBtn
      Left = 447
      ExplicitLeft = 447
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 5
      Width = 101
      OnErro = btnImprimirErro
      ExplicitLeft = 5
      ExplicitWidth = 101
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 131
      Visible = False
      ExplicitLeft = 131
    end
    object btnDeletarPeriodo: TBitBtnLocked
      Left = 107
      Top = 3
      Width = 101
      Height = 22
      Caption = '&Deletar Per'#237'odo'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = btnDeletarPeriodoClick
    end
  end
  inherited pnlDados: TPanel
    Width = 529
    Height = 374
    ExplicitWidth = 529
    ExplicitHeight = 374
    object lbl1: TLabel [0]
      Left = 8
      Top = 18
      Width = 51
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object lbl3: TLabel [1]
      Left = 78
      Top = 18
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [2]
      Left = 8
      Top = 5
      Width = 91
      Height = 12
      BiDiMode = bdRightToLeft
      Caption = 'DATA DE ENTRADA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCodEmp: TLabel [3]
      Left = 8
      Top = 100
      Width = 42
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Empresa'
      ParentBiDiMode = False
    end
    object lblOperacao: TLabel [4]
      Left = 8
      Top = 346
      Width = 113
      Height = 14
      Caption = 'descri'#231#227'o da operacao'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object btnEscolherTabela: TSpeedButton [5]
      Left = 328
      Top = 253
      Width = 89
      Height = 22
      Caption = 'Escolher Tabela'
      OnClick = btnEscolherTabelaClick
    end
    object lblTabInventario: TLabel [6]
      Left = 423
      Top = 256
      Width = 95
      Height = 14
      AutoSize = False
      Caption = 'TABELA PADR'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object btnCriarTabelas: TSpeedButton [7]
      Left = 448
      Top = 319
      Width = 70
      Height = 22
      Caption = 'Criar Tabelas'
      Visible = False
      OnClick = btnCriarTabelasClick
    end
    object Label5: TLabel [8]
      Left = 8
      Top = 256
      Width = 142
      Height = 14
      Caption = 'Valor IVA - NF X60 Invent'#225'rio:'
    end
    object Label3: TLabel [9]
      Left = 8
      Top = 136
      Width = 37
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Produto'
      ParentBiDiMode = False
    end
    inherited gpbDestino: TGroupBox
      Left = 735
      Top = 126
      ExplicitLeft = 735
      ExplicitTop = 126
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 33
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 78
      Top = 33
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 113
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodEmpExit
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
      Left = 74
      Top = 113
      Width = 444
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValIva: TEditFocus
      Left = 156
      Top = 253
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object chkCalcularST: TCheckBox
      Left = 215
      Top = 256
      Width = 80
      Height = 17
      Caption = 'Calcular ST'
      TabOrder = 13
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 8
      Top = 150
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 6
      OnExit = edtCodProExit
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPro: TEditFocus
      Left = 74
      Top = 150
      Width = 444
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object gpbEnquadramento: TGroupBox
      Left = 152
      Top = 3
      Width = 366
      Height = 99
      Caption = 'Enquadramento'
      TabOrder = 3
      object chkSaidaConsumidor: TCheckBox
        Tag = 1
        Left = 7
        Top = 18
        Width = 225
        Height = 17
        Caption = '1 - Sa'#237'da a Consumidor ou Usu'#225'rio Final'
        TabOrder = 0
        OnClick = chkEnquadramentoClick
      end
      object chkFatorGerador: TCheckBox
        Tag = 2
        Left = 7
        Top = 33
        Width = 299
        Height = 17
        Caption = '2 - Fato Gerador n'#227'o Realizado'
        TabOrder = 1
        OnClick = chkEnquadramentoClick
      end
      object chkSaidaSubsequente: TCheckBox
        Tag = 3
        Left = 7
        Top = 48
        Width = 322
        Height = 17
        Caption = '3 - Sa'#237'da ou Sa'#237'da Subsequente com Isen'#231#227'o ou n'#227'o Incid'#234'ncia'
        TabOrder = 2
        OnClick = chkEnquadramentoClick
      end
      object chkSaidaOutroEstado: TCheckBox
        Tag = 4
        Left = 7
        Top = 63
        Width = 299
        Height = 17
        Caption = '4 - Sa'#237'da para Outro Estado'
        TabOrder = 3
        OnClick = chkEnquadramentoClick
      end
      object chkSaidaParaComercializacao: TCheckBox
        Left = 7
        Top = 78
        Width = 319
        Height = 17
        Caption = '0 - Sa'#237'da para Comercializa'#231#227'o Subsequente (Demais Sa'#237'das) '
        TabOrder = 4
        OnClick = chkEnquadramentoClick
      end
    end
    object chkSomaIcmsRetido: TCheckBox
      Left = 159
      Top = 196
      Width = 215
      Height = 17
      Caption = 'Somar Retido + ICMS Opera'#231#227'o Pr'#243'pria'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 365
      Width = 527
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 14
    end
    object chkUtilizarConfigCfopCstEnquadramentos: TCheckBox
      Left = 159
      Top = 180
      Width = 301
      Height = 17
      Caption = 'Utilizar Configura'#231#227'o de CFOP/CST para os Enquadramentos'
      TabOrder = 9
      OnClick = chkUtilizarConfigCfopCstEnquadramentosClick
    end
    object rdgTipConferencia: TRadioGroup
      Left = 8
      Top = 175
      Width = 132
      Height = 66
      Caption = 'Confer'#234'ncia de Saldo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Conferir')
      ParentFont = False
      TabOrder = 8
      OnClick = rdgTipConferenciaClick
    end
    object chkEnviaNfCredSemSubsti: TCheckBox
      Left = 159
      Top = 212
      Width = 233
      Height = 17
      Caption = 'Enviar Notas de Cr'#233'dito sem Subst. Tribut'#225'ria'
      Enabled = False
      TabOrder = 11
    end
    object chkGerarComSaldoZero: TCheckBox
      Left = 159
      Top = 233
      Width = 368
      Height = 14
      Hint = 'Somar Retido + ICMS Opera'#231#227'o Pr'#243'pria: '
      Caption = 'Enviar Produtos com Saldo Final ZERO ?'
      TabOrder = 15
    end
  end
  inherited pnlStatus: TPanel
    Top = 402
    Width = 529
    ExplicitTop = 402
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 358
      ExplicitLeft = 358
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
      inherited btnShowTrace: TSpeedButton
        Left = 356
        ExplicitLeft = 356
      end
      inherited btnHideTrace: TSpeedButton
        Left = 356
        ExplicitLeft = 356
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 704
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 672
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 640
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 608
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 576
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsRelatorio
    Left = 608
    Top = 48
  end
  inherited frxGen: TfrxUserDataSet
    Left = 576
    Top = 48
  end
  inherited frxDesigner: TfrxDesigner
    Left = 768
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 800
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43521.637828240700000000
    ReportOptions.LastChange = 43521.637828240700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 464
    Top = 202
    Datasets = <
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
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 620.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 272.889920000000000000
        Top = 18.897650000000000000
        Width = 2286.615650000000000000
        Condition = 'frxRelatorio."CODITE"'
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 110.267780000000000000
          Width = 56.692950000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero '
            'de Ordem'
            ' (1)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 60.472480000000000000
          Top = 110.267780000000000000
          Width = 68.031540000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data'
            '(2)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 128.504020000000000000
          Top = 110.267780000000000000
          Width = 268.346630000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Chave do'
            'Documento'
            'Fiscal'
            'Eletr'#244'nico'
            '(3)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 396.850650000000000000
          Top = 110.267780000000000000
          Width = 56.692950000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero de'
            'S'#233'rie de '
            'Fabrica'#231#227'o'
            'do ECF'
            '(4)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 453.543600000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Tipo do'
            'Documento'
            '(5)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 514.016080000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'S'#233'rie do'
            'Documento'
            '(6)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 574.488560000000000000
          Top = 110.267780000000000000
          Width = 75.590600000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero do'
            'Documento'
            '(7)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 650.079160000000000000
          Top = 110.267780000000000000
          Width = 64.252010000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'digo do'
            'Remetente ou'
            'Destinat'#225'rio'
            '(8)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 3.779527560000000000
          Top = 91.370130000000000000
          Width = 812.598950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dados Gerais')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 714.331170000000000000
          Top = 110.267780000000000000
          Width = 41.574830000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CFOP'
            '(9)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 755.906000000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero do'
            'Item no'
            'Documento'
            '(10)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 816.378480000000000000
          Top = 110.267780000000000000
          Width = 60.472480000000000000
          Height = 162.519685040000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(11)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Left = 876.850960000000000000
          Top = 110.267780000000000000
          Width = 86.929190000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do'
            'ICMS Suportado'
            'na Reten'#231#227'o ou'
            'Antecipa'#231#227'o por'
            'ST'
            '(12)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 816.378477560000000000
          Top = 91.370130000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Entradas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 963.780150000000000000
          Top = 110.267780000000000000
          Width = 64.252010000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(13)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Top = 144.385900000000000000
          Width = 64.252010000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor'
            'Unit'#225'rio do'
            'ICMS'
            'Suportado'
            '(14)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Top = 110.047310000000000000
          Width = 483.779840000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'Valor Total do ICMS Suportado na Reten'#231#227'o ou Antecipa'#231#227'o por Sub' +
              'stitui'#231#227'o Tribut'#225'ria'
            '(apurado pela m'#233'dia ponderada m'#243'vel)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 963.780147560000000000
          Top = 91.370130000000000000
          Width = 729.449290000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'das')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 1092.284170000000000000
          Top = 144.283550000000000000
          Width = 75.590600000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da a'
            'Consumidor'
            'ou Usu'#225'rio'
            'Final - C'#243'digo'
            'Equadramento'
            'legal = 1'
            '(15)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Left = 1167.874770000000000000
          Top = 144.283550000000000000
          Width = 83.149660000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Fato Gerador'
            'N'#227'o Realizado -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 2'
            '(16)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 1251.024430000000000000
          Top = 144.283550000000000000
          Width = 83.149660000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da ou Sa'#237'da'
            'subsequente'
            'com Isen'#231#227'o ou'
            'N'#227'o Incid'#234'ncia -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 3'
            '(17)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 1334.174090000000000000
          Top = 144.283550000000000000
          Width = 86.929190000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da para Outro'
            'Estado - C'#243'digo'
            'Enquadramento'
            'Legal = 4'
            '(18)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Left = 1421.103280000000000000
          Top = 144.283550000000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da para'
            'Comercializa'#231#227'o'
            'Subsequente'
            '(Demais Sa'#237'das) -'
            'C'#243'digo'
            'Enquadramento'
            'Legal = 0'
            '(19)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 144.283515830000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS Efetivo'
            'na Sa'#237'da: a'
            'Consumidor'
            'ou Usu'#225'rio'
            'Final ou no'
            'caso de Sa'#237'da'
            'Subsequente'
            'Com Isen'#231#227'o'
            'ou N'#227'o Incid'#234'ncia'
            '(20)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Left = 1602.520720000000000000
          Top = 144.283550000000000000
          Width = 90.708720000000000000
          Height = 128.504020000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS Efetivo da'
            'Entrada, nas'
            'Demais Hip'#243'teses'
            '(21)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade'
            '(22)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Top = 174.519790000000000000
          Width = 120.944960000000000000
          Height = 98.267780000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Unit'#225'rio do'
            'Saldo'
            '(23)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Top = 110.267780000000000000
          Width = 219.212740000000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do ICMS Suportado na'
            'Reten'#231#227'o ou Antecipa'#231#227'o por'
            'Substitui'#231#227'o Tribut'#225'ria (m'#233'dia'
            'ponderada m'#243'vel)')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Left = 1904.883120000000000000
          Top = 174.519790000000000000
          Width = 98.267780000000000000
          Height = 98.267780000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Total do Saldo'
            '(24)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor do'
            'Ressarcimento'
            '(25)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 2093.859620000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor do'
            'Complemento'
            '(26)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 2184.568340000000000000
          Top = 110.267780000000000000
          Width = 90.708720000000000000
          Height = 162.519790000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ICMS - Cr'#233'dito'
            'da Opera'#231#227'o'
            'Pr'#243'pria'
            '(artigo 271 do '
            'RICMS)'
            '(27)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.338590000000000000
          Width = 2271.497530000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'CONTROLE DE ESTOQUE - MERCADORIAS ENQUADRADAS NA SUBSTITUI'#199#195'O TR' +
              'IBUT'#193'RIA')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.236240000000000000
          Width = 2271.497530000000000000
          Height = 56.692950000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'CONTRIBUINTE: [frxRelatorio."NOMEMP"]                           ' +
              '                                                                ' +
              '                                                                ' +
              '                                                                ' +
              '                 INSCRI'#199#195'O ESTADUAL: [frxRelatorio."IES"]'
            ''
            
              'M'#202'S E ANO DE REFER'#202'NCIA:  [MESANO]                              ' +
              '                                     MERCADORIA: [frxRelatorio."' +
              'MERCADORIA"]                                                    ' +
              '                                           UNIDADE: [frxRelatori' +
              'o."UNIDADE"]                                              AL'#205'QUO' +
              'TA: [frxRelatorio."ALIQUOTA"]')
          ParentFont = False
          VAlign = vaCenter
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
            end>
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 110.267780000000000000
          Width = 181.417440000000000000
          Height = 34.015748030000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor de Confronto')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Top = 91.370130000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Top = 91.370130000000000000
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Top = 91.370130000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Apura'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 313.700990000000000000
        Width = 2286.615650000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioCampo01: TfrxMemoView
          Left = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'Campo01'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo02: TfrxMemoView
          Align = baLeft
          Left = 60.472480000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'Campo02'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo02"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo03: TfrxMemoView
          Align = baLeft
          Left = 128.504020000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DataField = 'Campo03'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."Campo03"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo04: TfrxMemoView
          Align = baLeft
          Left = 396.850650000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'Campo04'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."Campo04"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo05: TfrxMemoView
          Align = baLeft
          Left = 453.543600000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo05'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo05"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo06: TfrxMemoView
          Align = baLeft
          Left = 514.016080000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo06'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo06"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo07: TfrxMemoView
          Align = baLeft
          Left = 574.488560000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Campo07'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo07"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo08: TfrxMemoView
          Align = baLeft
          Left = 650.079160000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo08'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo08"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo09: TfrxMemoView
          Align = baLeft
          Left = 714.331170000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'Campo09'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo09"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo10: TfrxMemoView
          Align = baLeft
          Left = 755.906000000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo10'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."Campo10"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo11: TfrxMemoView
          Align = baLeft
          Left = 816.378480000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'Campo11'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo11"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo12: TfrxMemoView
          Align = baLeft
          Left = 876.850960000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Campo12'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo12"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo13: TfrxMemoView
          Align = baLeft
          Left = 963.780150000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo13'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo13"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo14: TfrxMemoView
          Align = baLeft
          Left = 1028.032160000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Campo14'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo14"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo15: TfrxMemoView
          Align = baLeft
          Left = 1092.284170000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Campo15'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo15"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo16: TfrxMemoView
          Align = baLeft
          Left = 1167.874770000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'Campo16'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo16"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo17: TfrxMemoView
          Align = baLeft
          Left = 1251.024430000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'Campo17'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo17"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo18: TfrxMemoView
          Align = baLeft
          Left = 1334.174090000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Campo18'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo18"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo19: TfrxMemoView
          Align = baLeft
          Left = 1421.103280000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo19'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo19"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo20: TfrxMemoView
          Align = baLeft
          Left = 1511.812000000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo20'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo20"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo21: TfrxMemoView
          Align = baLeft
          Left = 1602.520720000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo21'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo21"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo22: TfrxMemoView
          Align = baLeft
          Left = 1693.229440000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo22'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo22"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo23: TfrxMemoView
          Align = baLeft
          Left = 1783.938160000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'Campo23'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.8f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo23"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo24: TfrxMemoView
          Align = baLeft
          Left = 1904.883120000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'Campo24'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo24"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo25: TfrxMemoView
          Align = baLeft
          Left = 2003.150900000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo25'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo25"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo26: TfrxMemoView
          Align = baLeft
          Left = 2093.859620000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo26'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo26"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object frxRelatorioCampo27: TfrxMemoView
          Align = baLeft
          Left = 2184.568340000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Campo27'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Campo27"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 2286.615650000000000000
        object Memo40: TfrxMemoView
          Align = baLeft
          Left = 2003.150836540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo25">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Left = 2093.859556540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo26">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Align = baLeft
          Left = 2184.568276540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo27">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 1904.883120000000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 434.645950000000000000
        Width = 2286.615650000000000000
        object Memo44: TfrxMemoView
          Align = baLeft
          Left = 2003.150836540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo25">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 2093.859556540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo26">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Left = 2184.568276540000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."Campo27">, MasterData1)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 1904.883120000000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 202
    object cdsRelatorioCampo01: TIntegerField
      FieldName = 'Campo01'
    end
    object cdsRelatorioCampo02: TDateField
      FieldName = 'Campo02'
    end
    object cdsRelatorioCampo03: TStringField
      FieldName = 'Campo03'
      Size = 44
    end
    object cdsRelatorioCampo04: TStringField
      FieldName = 'Campo04'
    end
    object cdsRelatorioCampo05: TStringField
      FieldName = 'Campo05'
    end
    object cdsRelatorioCampo06: TStringField
      FieldName = 'Campo06'
    end
    object cdsRelatorioCampo07: TStringField
      FieldName = 'Campo07'
    end
    object cdsRelatorioCampo08: TStringField
      FieldName = 'Campo08'
    end
    object cdsRelatorioCampo09: TStringField
      FieldName = 'Campo09'
    end
    object cdsRelatorioCampo10: TStringField
      FieldName = 'Campo10'
    end
    object cdsRelatorioCampo11: TFloatField
      FieldName = 'Campo11'
    end
    object cdsRelatorioCampo12: TFloatField
      FieldName = 'Campo12'
    end
    object cdsRelatorioCampo13: TFloatField
      FieldName = 'Campo13'
    end
    object cdsRelatorioCampo14: TFloatField
      FieldName = 'Campo14'
    end
    object cdsRelatorioCampo15: TFloatField
      FieldName = 'Campo15'
    end
    object cdsRelatorioCampo17: TFloatField
      FieldName = 'Campo17'
    end
    object cdsRelatorioCampo18: TFloatField
      FieldName = 'Campo18'
    end
    object cdsRelatorioCampo19: TFloatField
      FieldName = 'Campo19'
    end
    object cdsRelatorioCampo20: TFloatField
      FieldName = 'Campo20'
    end
    object cdsRelatorioCampo21: TFloatField
      FieldName = 'Campo21'
    end
    object cdsRelatorioCampo22: TFloatField
      FieldName = 'Campo22'
    end
    object cdsRelatorioCampo23: TFloatField
      FieldName = 'Campo23'
    end
    object cdsRelatorioCampo24: TFloatField
      FieldName = 'Campo24'
    end
    object cdsRelatorioCampo25: TFloatField
      FieldName = 'Campo25'
    end
    object cdsRelatorioCampo26: TFloatField
      FieldName = 'Campo26'
    end
    object cdsRelatorioCampo27: TFloatField
      FieldName = 'Campo27'
    end
    object cdsRelatorioCampo16: TFloatField
      FieldName = 'Campo16'
    end
    object cdsRelatorioMERCADORIA: TStringField
      FieldName = 'MERCADORIA'
      Size = 100
    end
    object cdsRelatorioCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsRelatorioUNIDADE: TStringField
      FieldName = 'UNIDADE'
    end
    object cdsRelatorioNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 100
    end
    object cdsRelatorioIES: TStringField
      FieldName = 'IES'
      Size = 100
    end
    object cdsRelatorioALIQUOTA: TFloatField
      FieldName = 'ALIQUOTA'
    end
    object cdsRelatorioINCVEN: TStringField
      FieldName = 'INCVEN'
    end
  end
  object cdsRelContabil: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 130
    object FloatField19: TFloatField
      FieldName = 'VALORCONTABIL'
    end
    object cdsRelContabilCST: TStringField
      FieldName = 'ENQUADRAMENTO'
      Size = 30
    end
    object cdsRelContabilCFOP: TStringField
      FieldName = 'CFOP'
      Size = 30
    end
  end
end
