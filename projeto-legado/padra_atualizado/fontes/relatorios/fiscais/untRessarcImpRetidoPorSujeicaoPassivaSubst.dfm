inherited frmRessarcImpRetidoPorSujeicaoPassivaSubst: TfrmRessarcImpRetidoPorSujeicaoPassivaSubst
  Width = 502
  Height = 704
  Caption = 
    'Ressarcimento do imposto retido por sujei'#231#227'o passiva por substit' +
    'ui'#231#227'o - CAT 158'
  OnDestroy = FormDestroy
  ExplicitTop = -127
  ExplicitWidth = 502
  ExplicitHeight = 704
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 633
    Width = 496
    ExplicitTop = 633
    ExplicitWidth = 496
    inherited FlwBotoes: TFlowPanel
      Width = 415
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 415
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
      object btnDeletarPeriodo: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 101
        Height = 22
        Align = alLeft
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
        TabOrder = 2
        OnClick = btnDeletarPeriodoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 417
      ExplicitLeft = 417
    end
  end
  inherited pnlDados: TPanel
    Width = 496
    Height = 625
    ExplicitWidth = 496
    ExplicitHeight = 625
    object lbl1: TLabel [0]
      Left = 8
      Top = 3
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
      Left = 8
      Top = 40
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
      Left = 75
      Top = 23
      Width = 105
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label2: TLabel [3]
      Left = 75
      Top = 59
      Width = 105
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCodEmp: TLabel [4]
      Left = 8
      Top = 156
      Width = 42
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Empresa'
      ParentBiDiMode = False
    end
    object Label3: TLabel [5]
      Left = 8
      Top = 77
      Width = 54
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Documento'
      ParentBiDiMode = False
    end
    object lblCodCla: TLabel [6]
      Left = 8
      Top = 116
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Class. Fiscal'
    end
    object lblTip_fc: TLabel [7]
      Left = 11
      Top = 196
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 575
      Width = 172
      Height = 44
      TabOrder = 10
      ExplicitLeft = 8
      ExplicitTop = 575
      ExplicitWidth = 172
      ExplicitHeight = 44
      inherited ColorLabel1: TColorLabel
        Left = 31
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 31
        ExplicitTop = 19
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 9
        ExplicitLeft = 9
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 64
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
      Left = 8
      Top = 53
      Width = 64
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 170
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
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
      Top = 170
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 8
      Top = 91
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodClaFis: TEditFocus
      Tag = 99
      Left = 8
      Top = 130
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 3
      OnExit = edtCodClaFisExit
      OnKeyPress = edtCodClaFisKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesClaFis: TEditFocus
      Left = 74
      Top = 130
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object grpOpcoes: TGroupBox
      Left = 8
      Top = 233
      Width = 411
      Height = 342
      Caption = 'Op'#231#245'es'
      TabOrder = 9
      object Label5: TLabel
        Left = 9
        Top = 190
        Width = 89
        Height = 14
        Caption = 'Valor IVA - NF X60'
      end
      object Label4: TLabel
        Left = 9
        Top = 300
        Width = 67
        Height = 14
        Caption = 'Cst tributadas'
      end
      object Label6: TLabel
        Left = 280
        Top = 260
        Width = 51
        Height = 14
        Caption = 'Data limite:'
      end
      object Label7: TLabel
        Left = 9
        Top = 240
        Width = 214
        Height = 14
        Caption = 'Filtro empresas transfer'#234'ncia ex: 001_002...'
      end
      object lblAlqSimples: TLabel
        Left = 9
        Top = 217
        Width = 249
        Height = 14
        Caption = 'Al'#237'quota Forn Simples Nacional sem cr'#233'dito de ICMS'
      end
      object chkVerificaItensComprSt: TCheckBox
        Left = 9
        Top = 279
        Width = 245
        Height = 17
        Caption = 'Verificar itens que foram comprados com ST'
        TabOrder = 15
        OnClick = chkVerificaItensComprStClick
      end
      object chkValidarNotasEntrada: TCheckBox
        Left = 9
        Top = 17
        Width = 388
        Height = 14
        Caption = 
          'Validar Forn Simples s/ Cr'#233'dito ICMS e/ou Notas Fiscais s/ Subst' +
          '. Tribut'#225'ria'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkVerificaItensComprStClick
      end
      object chkNaoEnviarValorZeradoIcmsSt: TCheckBox
        Left = 9
        Top = 47
        Width = 256
        Height = 14
        Caption = 'N'#227'o enviar valor zerado ICMS-ST para CAT 158'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = chkVerificaItensComprStClick
      end
      object chkValidaSaidaForaEstadoDifal: TCheckBox
        Left = 9
        Top = 62
        Width = 200
        Height = 14
        Caption = 'Validar saidas fora do estado difal'
        TabOrder = 3
        OnClick = chkVerificaItensComprStClick
      end
      object edtValIva: TEditFocus
        Left = 103
        Top = 187
        Width = 106
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object mskCstTrib: TMaskEditFocus
        Left = 9
        Top = 315
        Width = 392
        Height = 22
        Enabled = False
        EditMask = 
          '999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-999-' +
          '999-999-999-999;1;_'
        MaxLength = 79
        TabOrder = 16
        Text = 
          '   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -' +
          '   -   -   -   '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object chkValidaSaidaForaEstado: TCheckBox
        Left = 9
        Top = 77
        Width = 200
        Height = 14
        Caption = 'Validar saidas fora do estado'
        TabOrder = 4
        OnClick = chkVerificaItensComprStClick
      end
      object chkValidarCompraDentroForaEstado: TCheckBox
        Left = 9
        Top = 92
        Width = 243
        Height = 14
        Caption = 'Validar compras para dentro e fora do estado'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = chkVerificaItensComprStClick
      end
      object chkCalcularST: TCheckBox
        Left = 215
        Top = 189
        Width = 80
        Height = 17
        Caption = 'Calcular ST'
        TabOrder = 11
        OnClick = chkVerificaItensComprStClick
      end
      object mskDtaLimiteNfCompra: TMaskEditFocus
        Tag = 99
        Left = 337
        Top = 255
        Width = 64
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
        TabOrder = 14
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object chkUtilizarStNCredX60: TCheckBox
        Left = 9
        Top = 107
        Width = 243
        Height = 14
        Caption = 'Utilizar ST n'#227'o creditada X60'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = chkVerificaItensComprStClick
      end
      object chkEnviaCombinacaoCnpjNomeNfEntrada: TCheckBox
        Left = 9
        Top = 122
        Width = 280
        Height = 14
        Caption = 'Enviar combina'#231#227'o CNPJ + Nome dados NF - entrada'
        TabOrder = 7
        OnClick = chkVerificaItensComprStClick
      end
      object chkUtilizarNfTransf: TCheckBox
        Left = 9
        Top = 137
        Width = 272
        Height = 14
        Caption = 'Utilizar Notas fiscais de transfer'#234'ncias'
        TabOrder = 8
        OnClick = chkVerificaItensComprStClick
      end
      object edtEmpTransf: TEditFocus
        Left = 9
        Top = 255
        Width = 263
        Height = 22
        Alignment = taLeftJustify
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object chkIgnorarNfImp: TCheckBox
        Left = 9
        Top = 152
        Width = 272
        Height = 14
        Caption = 'Ignorar notas de importa'#231#227'o'
        TabOrder = 9
        OnClick = chkVerificaItensComprStClick
      end
      object edtAlqSimples: TEditFocus
        Left = 300
        Top = 214
        Width = 101
        Height = 22
        Hint = 
          'Compra de fornecedor de simples nacional sem permiss'#227'o de cr'#233'dit' +
          'o de ICMS (CFG_CAT158 = 0)'
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        Text = '1,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object chkValidarFornecedorSimplesNacional: TCheckBox
        Left = 9
        Top = 32
        Width = 217
        Height = 14
        Caption = 'Validar Regime Forn. Simples Nacional'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object edtNomFor: TEditFocus
      Left = 94
      Top = 211
      Width = 325
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 8
      Top = 211
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 7
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
  end
  inherited pnlStatus: TPanel
    Top = 659
    Width = 496
    ExplicitTop = 659
    ExplicitWidth = 496
    inherited pnlNomeForm: TPanel
      Left = 248
      Width = 248
      ExplicitLeft = 248
      ExplicitWidth = 248
    end
    inherited pnlInfo: TPanel
      Width = 248
      ExplicitWidth = 248
      inherited shpMultSel: TShape
        Left = 232
        ExplicitLeft = 232
      end
    end
  end
  object pgbProgresso: TProgressBar [4]
    Left = 0
    Top = 625
    Width = 496
    Height = 8
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 584
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 840
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 808
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 776
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 744
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 712
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 648
  end
  inherited frxGen: TfrxUserDataSet
    Left = 680
  end
  inherited frxDesigner: TfrxDesigner
    Left = 904
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 936
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 840
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 768
  end
  object cdsRelatorioNotasSaida: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 211
    Top = 6
    object cdsRelatorioNotasSaidaDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 50
    end
    object cdsRelatorioNotasSaidaCFOP: TStringField
      FieldName = 'CFOP'
    end
    object cdsRelatorioNotasSaidaVLR_CONTABIL: TFloatField
      FieldName = 'VLR_CONTABIL'
    end
    object cdsRelatorioNotasSaidaVLR_ICMS: TFloatField
      FieldName = 'VLR_ICMS'
    end
    object cdsRelatorioNotasSaidaVLR_ICMS_ST: TFloatField
      FieldName = 'VLR_ICMS_ST'
    end
    object cdsRelatorioNotasSaidaVLR_DIFAL_ORIGEM: TFloatField
      FieldName = 'VLR_DIFAL_ORIGEM'
    end
    object cdsRelatorioNotasSaidaVLR_DIFAL_DESTINO: TFloatField
      FieldName = 'VLR_DIFAL_DESTINO'
    end
    object cdsRelatorioNotasSaidaDATA_EMISSAO: TDateField
      FieldName = 'DATA_EMISSAO'
    end
    object cdsRelatorioNotasSaidaCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 100
    end
    object cdsRelatorioNotasSaidaESTADO: TStringField
      FieldName = 'ESTADO'
    end
    object cdsRelatorioNotasSaidaCODITE: TStringField
      FieldName = 'CODITE'
      Size = 100
    end
    object cdsRelatorioNotasSaidaREFERENCIA: TStringField
      FieldName = 'REFERENCIA'
    end
    object cdsRelatorioNotasSaidaUNIDADE: TStringField
      FieldName = 'UNIDADE'
    end
    object cdsRelatorioNotasSaidaQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsRelatorioNotasSaidaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsRelatorioNotasSaidaTABELA: TStringField
      FieldName = 'TABELA'
    end
  end
  object cdsRelatorioNotasEntrada: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 350
    Top = 5
    object cdsRelatorioNotasEntradaDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsRelatorioNotasEntradaFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Size = 120
    end
    object cdsRelatorioNotasEntradaDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 50
    end
    object cdsRelatorioNotasEntradaQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsRelatorioNotasEntradaTOTAL_PRODUTO: TFloatField
      FieldName = 'TOTAL_PRODUTO'
    end
    object cdsRelatorioNotasEntradaVALOR_ICMS: TFloatField
      FieldName = 'VALOR_ICMS'
    end
    object cdsRelatorioNotasEntradaVALORST: TFloatField
      FieldName = 'VALORST'
    end
    object cdsRelatorioNotasEntradaVALORIPI: TFloatField
      FieldName = 'VALORIPI'
    end
    object cdsRelatorioNotasEntradaDOCUMENTO_SAIDA: TStringField
      FieldName = 'DOCUMENTO_SAIDA'
    end
    object cdsRelatorioNotasEntradaESPECIE_SAIDA: TStringField
      FieldName = 'ESPECIE_SAIDA'
    end
    object cdsRelatorioNotasEntradaCLIENTE_SAIDA: TStringField
      FieldName = 'CLIENTE_SAIDA'
    end
    object cdsRelatorioNotasEntradaSERIE_SAIDA: TStringField
      FieldName = 'SERIE_SAIDA'
    end
    object cdsRelatorioNotasEntradaAUTOINCREM_VENDA: TStringField
      FieldName = 'AUTOINCREM_VENDA'
    end
    object cdsRelatorioNotasEntradaTABELA_VENDA: TStringField
      FieldName = 'TABELA_VENDA'
    end
    object cdsRelatorioNotasEntradaAUTOINCREM_COMPRA: TStringField
      FieldName = 'AUTOINCREM_COMPRA'
    end
    object cdsRelatorioNotasEntradaBASE_ICMS: TFloatField
      FieldName = 'BASE_ICMS'
    end
    object cdsRelatorioNotasEntradaBASE_ST: TFloatField
      FieldName = 'BASE_ST'
    end
    object cdsRelatorioNotasEntradaACESSO: TStringField
      FieldName = 'ACESSO'
      Size = 44
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42430.700695775500000000
    ReportOptions.LastChange = 42430.700695775500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fFiltraItemNotasEntradas(<frxRelatorioSaida."AUTOINCREM">, <fr' +
        'xRelatorioSaida."TABELA">);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 414
    Top = 4
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxRelatorioRetrocessoUltimaNota'
      end
      item
        DataSet = frxDBDataset3
        DataSetName = 'frxRelatorioSaida'
      end
      item
        DataSet = frxDBDataset2
        DataSetName = 'frxRelatorioSintetico'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pPrincipal: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 410.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 88.763760000000000000
        Top = 18.897650000000000000
        Width = 1474.016700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 313.814720000000000000
          Top = 4.000000000000000000
          Width = 846.387260000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 362.230490000000000000
          Top = 21.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1364.700990000000000000
          Top = 28.559060000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 1414.219110000000000000
          Top = 53.118120000000010000
          Width = 46.563760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 1268.700990000000000000
          Top = 53.118120000000010000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 401.650960000000000000
          Top = 57.574830000000010000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Align = baCenter
          Left = 401.650960000000000000
          Top = 73.692950000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CLAFIS]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Align = baCenter
          Left = 401.650960000000000000
          Top = 42.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[REFERE]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 45.472480000000000000
        Top = 170.078850000000000000
        Width = 1474.016700000000000000
        ReprintOnNewPage = True
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1474.016700000000000000
          Height = 45.472480000000000000
          Fill.BackColor = clSilver
        end
        object Memo4: TfrxMemoView
          Left = 5.559060000000000000
          Top = 3.677179999999993000
          Width = 355.275702830000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD. ITEM')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 896.992125980000000000
          Top = 3.677179999999993000
          Width = 98.267716540000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. CONT'#193'BIL')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1105.244094490000000000
          Top = 3.677179999999993000
          Width = 109.606304090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR DIFAL ORIGEM')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 22.795300000000000000
          Width = 1474.016700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo31: TfrxMemoView
          Left = 117.165430000000000000
          Top = 26.574829999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. EMISS'#195'O')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 212.212740000000000000
          Top = 26.574829999999990000
          Width = 132.283464566929100000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 348.472440940000000000
          Top = 26.574829999999990000
          Width = 353.385826770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 976.969080000000000000
          Top = 26.574829999999990000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 1079.016390000000000000
          Top = 26.574829999999990000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR ICMS')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 1185.244900000000000000
          Top = 26.574829999999990000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR ST')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 1291.071740000000000000
          Top = 26.574829999999990000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR IPI')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 999.039370080000000000
          Top = 3.677179999999993000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ICMS')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 1219.512370000000000000
          Top = 3.779529999999994000
          Width = 113.385834090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR DIFAL DESTINO')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 475.944960000000000000
          Top = 3.779529999999994000
          Width = 37.795234090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 366.614410000000000000
          Top = 3.779529999999994000
          Width = 75.590534090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 445.984540000000000000
          Top = 3.779529999999994000
          Width = 22.677114090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 846.614720000000000000
          Top = 3.779529999999994000
          Width = 45.354294090000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 706.772110000000000000
          Top = 26.456709999999990000
          Width = 266.456636770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CHAVE ACESSO')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 275.905690000000000000
        Width = 1474.016700000000000000
        Child = frxReportJ.Child1
        DataSet = frxDBDataset3
        DataSetName = 'frxRelatorioSaida'
        RowCount = 0
        object rllRetangulo: TfrxMemoView
          Align = baClient
          Width = 1474.016700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 5.669291340000000000
          Width = 355.275590550000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioSaida."CODITE"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 896.881889760000000000
          Width = 98.267716540000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSaida."VLR_CONTABIL"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 998.929133858268000000
          Width = 102.047244090000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSaida."VLR_ICMS"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 1105.133858267720000000
          Width = 109.606299210000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSaida."VLR_DIFAL_ORIGEM"]')
          ParentFont = False
        end
        object frxRelatorioSaidaCFOP: TfrxMemoView
          Left = 475.842519690000000000
          Width = 37.795275590000000000
          Height = 13.228346460000000000
          DataField = 'CFOP'
          DataSet = frxDBDataset3
          DataSetName = 'frxRelatorioSaida'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioSaida."CFOP"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 1219.653543310000000000
          Width = 113.385826770000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSaida."VLR_DIFAL_DESTINO"]')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 366.614173230000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioSaida."REFERENCIA"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 445.984251970000000000
          Width = 22.677165350000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioSaida."UNIDADE"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 846.614173230000000000
          Width = 45.354330710000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSaida."QUANTIDADE"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 351.496290000000000000
        Width = 1474.016700000000000000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1474.016700000000000000
          Height = 15.118120000000000000
          OnAfterPrint = 'Shape1OnAfterPrint'
        end
        object Memo23: TfrxMemoView
          Left = 799.370078740158000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 896.881889760000000000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorioSaida."VLR_CONTABIL">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 998.929133858268000000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorioSaida."VLR_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 1105.133858267720000000
          Width = 109.606299210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorioSaida."VLR_DIFAL_ORIGEM">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 1219.653543307090000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorioSaida."VLR_DIFAL_DESTINO">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 313.700990000000000000
        Width = 1474.016700000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        object Subreport1: TfrxSubreport
          Align = baClient
          Width = 1474.016700000000000000
          Height = 15.118120000000000000
          Page = frxReportJ.Page2
        end
      end
      object ghDocumento: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 238.110390000000000000
        Width = 1474.016700000000000000
        Condition = 'frxRelatorioSaida."DOCUMENTO"'
        object Memo48: TfrxMemoView
          Left = 196.535560000000000000
          Width = 79.370130000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO:')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 279.685220000000000000
          Width = 196.535330550000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorioSaida."DOCUMENTO"]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 5.669291340000000000
          Width = 83.149660000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA EMISS'#195'O:')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 90.708720000000000000
          Width = 98.267550550000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorioSaida."DATA_EMISSAO"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 483.779840000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 540.929500000000000000
          Width = 355.275590550000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorioSaida."CLIENTE"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 900.307670000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ESTADO:')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 956.221090000000000000
          Width = 34.015540550000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorioSaida."ESTADO"]')
          ParentFont = False
        end
      end
    end
    object pTotal: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 303.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 69.866110000000000000
        Top = 18.897650000000000000
        Width = 1069.606990000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 111.609865000000000000
          Top = 4.000000000000000000
          Width = 846.387260000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baCenter
          Left = 160.025635000000000000
          Top = 21.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 969.700990000000000000
          Top = 28.559060000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 1019.219110000000000000
          Top = 53.118120000000010000
          Width = 46.563760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 873.700990000000000000
          Top = 53.118120000000010000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baCenter
          Left = 199.446105000000000000
          Top = 38.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 151.181200000000000000
        Width = 1069.606990000000000000
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 1069.606990000000000000
          Height = 37.795300000000000000
          OnAfterPrint = 'Shape1OnAfterPrint'
          Fill.BackColor = clSilver
        end
        object Memo29: TfrxMemoView
          Left = 2.834761610000000000
          Top = 1.000000000000000000
          Width = 318.236220470000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DAS')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 2.834761620000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ICMS')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 109.606370000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. DIFAL')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 217.212740000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 323.598640000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo39: TfrxMemoView
          Left = 325.039580000000000000
          Top = 1.000000000000000000
          Width = 526.866141730000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 325.039370080000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. CONT'#193'BIL')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 430.866420000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ICMS')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 536.693260000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ICMS ST')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 642.520100000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. IPI')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 748.346940000000000000
          Top = 18.897650000000000000
          Width = 103.936846770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 854.173780000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Top = 18.897650000000000000
          Width = 854.173780000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Left = 964.102970000000000000
          Top = 1.133858269999990000
          Width = 103.937007870000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESSARCIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 856.953310000000000000
          Top = 1.133858269999990000
          Width = 103.937007870000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CRED. ICMS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line7: TfrxLineView
          Left = 963.023622047244200000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 211.653680000000000000
        Width = 1069.606990000000000000
        DataSet = frxDBDataset2
        DataSetName = 'frxRelatorioSintetico'
        RowCount = 0
        object Memo16: TfrxMemoView
          Align = baClient
          Width = 1069.606990000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          ParentFont = False
        end
        object frxRelatorioSinteticoICMS_SAIDA: TfrxMemoView
          Left = 3.023622050000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'ICMS_SAIDA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."ICMS_SAIDA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoDIFAL_SAIDA: TfrxMemoView
          Left = 109.606299210000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'DIFAL_SAIDA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."DIFAL_SAIDA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoTOTAL_SAIDA: TfrxMemoView
          Left = 217.322834650000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'TOTAL_SAIDA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."TOTAL_SAIDA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoVLRCON_ENTRADA: TfrxMemoView
          Left = 325.039370080000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'VLRCON_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."VLRCON_ENTRADA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoICMS_ENTRADA: TfrxMemoView
          Left = 430.866141730000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'ICMS_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."ICMS_ENTRADA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoICMS_ST_ENTRADA: TfrxMemoView
          Left = 536.692913390000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'ICMS_ST_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."ICMS_ST_ENTRADA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoIPI_ENTRADA: TfrxMemoView
          Left = 642.519685040000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'IPI_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."IPI_ENTRADA"]')
          ParentFont = False
        end
        object frxRelatorioSinteticoTOTAL_ENTRADA: TfrxMemoView
          Left = 748.346456690000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'TOTAL_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."TOTAL_ENTRADA"]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 854.173780000000000000
          Height = 15.118120000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 323.527559055118000000
          Height = 15.118120000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo63: TfrxMemoView
          Left = 964.023622050000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'ICMS_ST_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."ICMS_ST_ENTRADA"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 856.818897640000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataField = 'ICMS_ENTRADA'
          DataSet = frxDBDataset2
          DataSetName = 'frxRelatorioSintetico'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioSintetico."ICMS_ENTRADA"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 287.244280000000000000
        Width = 1069.606990000000000000
        object Memo66: TfrxMemoView
          Align = baClient
          Width = 1069.606990000000000000
          Height = 22.677180000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '     [MSG1]')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 410.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 1474.016700000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxRelatorioRetrocessoUltimaNota'
        RowCount = 0
        object frxRelatorioRetrocessoUltimaNotaDATA: TfrxMemoView
          Left = 118.165354330000000000
          Width = 90.708661420000000000
          Height = 15.118110240000000000
          DataField = 'DATA'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."DATA"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaDOCUMENTO: TfrxMemoView
          Left = 213.031496060000000000
          Width = 132.283464566929100000
          Height = 15.118110240000000000
          DataField = 'DOCUMENTO'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."DOCUMENTO"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaFORNECEDOR: TfrxMemoView
          Left = 349.606299212598400000
          Width = 353.385826770000000000
          Height = 15.118110240000000000
          DataField = 'FORNECEDOR'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."FORNECEDOR"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaQUANTIDADE: TfrxMemoView
          Left = 977.007874020000000000
          Width = 98.267716540000000000
          Height = 15.118110240000000000
          DataField = 'QUANTIDADE'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."QUANTIDADE"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaVALOR_ICMS: TfrxMemoView
          Left = 1079.055118110000000000
          Width = 102.047244090000000000
          Height = 15.118110240000000000
          DataField = 'VALOR_ICMS'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."VALOR_ICMS"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaVALORST: TfrxMemoView
          Left = 1185.259842520000000000
          Width = 102.047244090000000000
          Height = 15.118110240000000000
          DataField = 'VALORST'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."VALORST"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaVALORIPI: TfrxMemoView
          Left = 1291.086614170000000000
          Width = 102.047244090000000000
          Height = 15.118110240000000000
          DataField = 'VALORIPI'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."VALORIPI"]')
          ParentFont = False
        end
        object frxRelatorioRetrocessoUltimaNotaACESSO: TfrxMemoView
          Left = 706.771653540000000000
          Width = 268.346456692913400000
          Height = 15.118110240000000000
          DataField = 'ACESSO'
          DataSet = frxDBDataset1
          DataSetName = 'frxRelatorioRetrocessoUltimaNota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioRetrocessoUltimaNota."ACESSO"]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 60.472480000000000000
        Width = 1474.016700000000000000
        object Memo20: TfrxMemoView
          Left = 978.898270000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 1079.055118110000000000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorioRetrocessoUltimaNota."VALOR_ICMS">, MasterData' +
              '1)]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 1185.259842520000000000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.3f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorioRetrocessoUltimaNota."VALORST">, MasterData1)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1291.086614170000000000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorioRetrocessoUltimaNota."VALORIPI">, MasterData1)' +
              ']')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorioRetrocessoUltimaNota'
    CloseDataSource = False
    DataSet = cdsRelatorioNotasEntrada
    BCDToCurrency = False
    Left = 384
    Top = 5
  end
  object cdsRelatorioSintetico: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 206
    Top = 61
    object cdsRelatorioSinteticoICMS_SAIDA: TFloatField
      FieldName = 'ICMS_SAIDA'
    end
    object cdsRelatorioSinteticoDIFAL_SAIDA: TFloatField
      FieldName = 'DIFAL_SAIDA'
    end
    object cdsRelatorioSinteticoTOTAL_SAIDA: TFloatField
      FieldName = 'TOTAL_SAIDA'
    end
    object cdsRelatorioSinteticoVLRCON_ENTRADA: TFloatField
      FieldName = 'VLRCON_ENTRADA'
    end
    object cdsRelatorioSinteticoICMS_ENTRADA: TFloatField
      FieldName = 'ICMS_ENTRADA'
    end
    object cdsRelatorioSinteticoICMS_ST_ENTRADA: TFloatField
      FieldName = 'ICMS_ST_ENTRADA'
    end
    object cdsRelatorioSinteticoIPI_ENTRADA: TFloatField
      FieldName = 'IPI_ENTRADA'
    end
    object cdsRelatorioSinteticoTOTAL_ENTRADA: TFloatField
      FieldName = 'TOTAL_ENTRADA'
    end
  end
  object frxDBDataset2: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorioSintetico'
    CloseDataSource = False
    DataSet = cdsRelatorioSintetico
    BCDToCurrency = False
    Left = 240
    Top = 61
  end
  object frxDBDataset3: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorioSaida'
    CloseDataSource = False
    DataSet = cdsRelatorioNotasSaida
    BCDToCurrency = False
    Left = 240
    Top = 5
  end
  object frxDBDataset4: TfrxDBDataset
    UserName = 'frxNotasEntradaSemIcms'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DATAENTRADA=DATAENTRADA'
      'DATADOCUMENTO=DATADOCUMENTO'
      'DOCUMENTO=DOCUMENTO'
      'SERIE=SERIE'
      'FORNECEDOR=FORNECEDOR'
      'VALORCONTABIL=VALORCONTABIL'
      'HIST_ERRO=HIST_ERRO'
      'NIVEL_ERRO=NIVEL_ERRO')
    DataSet = cdsEntradasSemIcms
    BCDToCurrency = False
    Left = 240
    Top = 96
  end
  object cdsEntradasSemIcms: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 96
    object cdsEntradasSemIcmsDATAENTRADA: TDateField
      FieldName = 'DATAENTRADA'
    end
    object cdsEntradasSemIcmsDATADOCUMENTO: TStringField
      FieldName = 'DATADOCUMENTO'
    end
    object cdsEntradasSemIcmsDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 30
    end
    object cdsEntradasSemIcmsSERIE: TStringField
      FieldName = 'SERIE'
    end
    object cdsEntradasSemIcmsFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Size = 100
    end
    object cdsEntradasSemIcmsVALORCONTABIL: TFloatField
      FieldName = 'VALORCONTABIL'
    end
    object cdsEntradasSemIcmsHIST_ERRO: TStringField
      FieldName = 'HIST_ERRO'
      Size = 100
    end
    object cdsEntradasSemIcmsNIVEL_ERRO: TIntegerField
      FieldName = 'NIVEL_ERRO'
    end
  end
  object frxNotasEntradaSemIcms: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42810.440686006900000000
    ReportOptions.LastChange = 42815.389213981500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 272
    Top = 96
    Datasets = <
      item
        DataSet = frxDBDataset4
        DataSetName = 'frxNotasEntradaSemIcms'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 295.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 88.763760000000000000
        Top = 18.897650000000000000
        Width = 1039.370750000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 96.491745000000000000
          Top = 4.000000000000000000
          Width = 846.387260000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 144.907515000000000000
          Top = 21.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 184.327985000000000000
          Top = 57.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Align = baCenter
          Left = 184.327985000000000000
          Top = 73.692950000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CLAFIS]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Align = baCenter
          Left = 184.327985000000000000
          Top = 42.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[REFERE]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 935.055660000000000000
          Top = 2.677180000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 984.573780000000000000
          Top = 27.236240000000000000
          Width = 46.563760000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 839.055660000000000000
          Top = 27.236240000000000000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 170.078850000000000000
        Width = 1039.370750000000000000
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1039.370750000000000000
          Height = 15.118110240000000000
        end
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Width = 83.149606299212600000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. ENTRADA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 96.377952755905510000
          Width = 147.401574803149600000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 251.338582677165400000
          Width = 45.354360000000000000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'S'#201'RIE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 304.251968500000000000
          Width = 355.275590550000000000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 931.653543307086600000
          Width = 98.267716540000000000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. CONT'#193'BIL')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 665.574803150000000000
          Width = 260.787401570000000000
          Height = 15.874015750000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'INCONSIST'#202'NCIAS')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 207.874150000000000000
        Width = 1039.370750000000000000
        DataSet = frxDBDataset4
        DataSetName = 'frxNotasEntradaSemIcms'
        RowCount = 0
        object frxNotasEntradaSemIcmsDATAENTRADA: TfrxMemoView
          Left = 7.559060000000000000
          Width = 83.149606300000000000
          Height = 15.874015750000000000
          DataField = 'DATAENTRADA'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."DATAENTRADA"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNotasEntradaSemIcmsDOCUMENTO: TfrxMemoView
          Left = 96.377952760000000000
          Width = 147.401574800000000000
          Height = 15.874015748031500000
          DataField = 'DOCUMENTO'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."DOCUMENTO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNotasEntradaSemIcmsSERIE: TfrxMemoView
          Left = 251.338582680000000000
          Width = 45.354330710000000000
          Height = 15.874015748031500000
          DataField = 'SERIE'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."SERIE"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNotasEntradaSemIcmsFORNECEDOR: TfrxMemoView
          Left = 304.251968500000000000
          Width = 355.275590550000000000
          Height = 15.874015748031500000
          DataField = 'FORNECEDOR'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."FORNECEDOR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxNotasEntradaSemIcmsVALORCONTABIL: TfrxMemoView
          Left = 931.653543310000000000
          Width = 98.267716540000000000
          Height = 15.874015748031500000
          DataField = 'VALORCONTABIL'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."VALORCONTABIL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 665.574803150000000000
          Width = 260.787401570000000000
          Height = 15.874015750000000000
          DataField = 'HIST_ERRO'
          DataSet = frxDBDataset4
          DataSetName = 'frxNotasEntradaSemIcms'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNotasEntradaSemIcms."HIST_ERRO"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
