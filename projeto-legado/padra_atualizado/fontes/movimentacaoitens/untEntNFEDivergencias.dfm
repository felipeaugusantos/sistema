inherited frmEntNFEDivergencias: TfrmEntNFEDivergencias
  Width = 1161
  Height = 699
  BorderStyle = bsSizeable
  Caption = 
    'Diverg'#234'ncias entre os valores dos XMLs e os calculados na Entrad' +
    'a de Mercadorias '
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitLeft = -374
  ExplicitTop = -264
  ExplicitWidth = 1161
  ExplicitHeight = 699
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 596
    Width = 1145
    Height = 48
    ExplicitTop = 596
    ExplicitWidth = 1145
    ExplicitHeight = 48
    inherited FlwBotoes: TFlowPanel
      Width = 1141
      Height = 44
      ExplicitWidth = 1141
      ExplicitHeight = 44
      object btnLiberar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Liberar Importa'#231#227'o'
        TabOrder = 0
        OnClick = btnLiberarClick
      end
      object btnExpExc: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F11 ] Exportar para Excel'
        TabOrder = 1
        OnClick = btnExpExcClick
      end
      object btnCadAbrFisICM: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 180
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F5 ] Cad. Abrevia'#231#227'o Fiscal ICMS'
        TabOrder = 2
        OnClick = btnCadAbrFisICMClick
      end
      object btnCadAbrFisIpi: TBitBtnLocked
        Left = 480
        Top = 0
        Width = 168
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F6 ] Cad. Abrevia'#231#227'o Fiscal IPI'
        TabOrder = 3
        OnClick = btnCadAbrFisIpiClick
      end
      object btnCadAbrFisPIS: TBitBtnLocked
        Left = 648
        Top = 0
        Width = 172
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F7 ] Cad. Abrevia'#231#227'o Fiscal PIS'
        TabOrder = 4
        OnClick = btnCadAbrFisPISClick
      end
      object btnCadAbrFisCOF: TBitBtnLocked
        Left = 820
        Top = 0
        Width = 188
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F8 ] Cad. Abrevia'#231#227'o Fiscal COFINS'
        TabOrder = 5
        OnClick = btnCadAbrFisCOFClick
      end
      object bntReprocessaAbvFiscal: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 180
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F9 ] Reprocessar Abrev. Fiscal'
        TabOrder = 6
        OnClick = bntReprocessaAbvFiscalClick
      end
      object btnCadPro: TBitBtnLocked
        Left = 180
        Top = 22
        Width = 168
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F12 ] Cadastro de Produtos'
        TabOrder = 7
        OnClick = btnCadProClick
      end
      object btnMotivosPedencia: TBitBtnLocked
        Left = 348
        Top = 22
        Width = 181
        Height = 22
        Caption = '[ F5 ] Motivos da Pend'#234'ncia Fiscal'
        TabOrder = 8
        OnClick = btnMotivosPedenciaClick
      end
      object btnRejeitaNota: TBitBtnLocked
        Left = 529
        Top = 22
        Width = 132
        Height = 22
        Caption = '[ F4 ] Rejeitar Nota Fiscal'
        TabOrder = 9
        OnClick = btnRejeitaNotaClick
      end
      object btnExpPdf: TBitBtnLocked
        Left = 661
        Top = 22
        Width = 153
        Height = 22
        Caption = '[ ALT + P ] Exportar para PDF'
        TabOrder = 10
        OnClick = btnExpPdfClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1063
      Top = 23
      ExplicitLeft = 1063
      ExplicitTop = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 644
    Width = 1145
    ExplicitTop = 644
    ExplicitWidth = 1145
    inherited pnlNomeForm: TPanel
      Left = 974
      ExplicitLeft = 974
    end
    inherited pnlInfo: TPanel
      Width = 974
      ExplicitWidth = 974
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1145
    Height = 535
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.FocusRect = False
      object cxgItensFORNEC: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNEC'
        Visible = False
        GroupIndex = 0
        SortIndex = 0
        SortOrder = soAscending
        Width = 1011
      end
      object cxgItensNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Visible = False
        GroupIndex = 1
        SortIndex = 1
        SortOrder = soAscending
        Width = 74
      end
      object cxgItensELETRO: TcxGridDBColumn
        Caption = 'XML'
        DataBinding.FieldName = 'ELETRO'
        Visible = False
        MinWidth = 10
        SortIndex = 4
        SortOrder = soAscending
        Width = 19
      end
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'd.Item'
        DataBinding.FieldName = 'CODITE'
        Options.CellMerging = True
        SortIndex = 3
        SortOrder = soAscending
        Width = 60
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.CellMerging = True
        SortIndex = 2
        SortOrder = soAscending
        Width = 201
      end
      object cxItensCODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. Fabrica'
        DataBinding.FieldName = 'CODFAB'
        Options.CellMerging = True
        Width = 120
      end
      object cxgItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.CellMerging = True
        Width = 82
      end
      object cxgItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.CellMerging = True
        Width = 46
      end
      object cxgItensNCM: TcxGridDBColumn
        Caption = 'NCM'
        DataBinding.FieldName = 'CLAIPI'
        Options.CellMerging = True
      end
      object cxgItensABRICM: TcxGridDBColumn
        Caption = 'C'#243'd. Abrev. ICMS'
        DataBinding.FieldName = 'CODABF'
        Options.CellMerging = True
      end
      object cxgItensDESABF: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Abrevia'#231#227'o ICMS'
        DataBinding.FieldName = 'DESABF'
        Options.CellMerging = True
        Width = 155
      end
      object cxgItensCLAFIS: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLAFIS'
        OnCustomDrawCell = cxgItensCLAFISCustomDrawCell
        MinWidth = 38
        Width = 38
      end
      object cxgItensCODSIT: TcxGridDBColumn
        Caption = 'CST'
        DataBinding.FieldName = 'CODSIT'
        OnCustomDrawCell = cxgItensCODSITCustomDrawCell
        Width = 35
      end
      object cxgItensBASICM: TcxGridDBColumn
        Caption = 'Base ICMS'
        DataBinding.FieldName = 'BASICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASICMCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensALQICM: TcxGridDBColumn
        Caption = 'Alq.ICMS'
        DataBinding.FieldName = 'ALQICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALQICMCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object cxgItensVALICM: TcxGridDBColumn
        Caption = 'Valor ICMS'
        DataBinding.FieldName = 'VALICM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALICMCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensBASSUB: TcxGridDBColumn
        Caption = 'Base Subst.'
        DataBinding.FieldName = 'BASSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASSUBCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensFATMVA: TcxGridDBColumn
        Caption = 'MVA'
        DataBinding.FieldName = 'FATMVA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000;(0.00)'
        OnCustomDrawCell = cxgItensFATMVACustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 47
      end
      object cxgItensVALSUB: TcxGridDBColumn
        Caption = 'Valor Subst.'
        DataBinding.FieldName = 'VALSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALSUBCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensBASIPI: TcxGridDBColumn
        Caption = 'Base IPI'
        DataBinding.FieldName = 'BASIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensBASIPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 65
      end
      object cxgItensALQIPI: TcxGridDBColumn
        Caption = 'Alq.IPI'
        DataBinding.FieldName = 'ALQIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensALQIPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 46
      end
      object cxgItensVALIPI: TcxGridDBColumn
        Caption = 'Valor IPI'
        DataBinding.FieldName = 'VALIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVALIPICustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensDIF_BASICM: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_BASICM'
        Visible = False
      end
      object cxgItensDIF_ALQICM: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_ALQICM'
        Visible = False
      end
      object cxgItensDIF_VALICM: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_VALICM'
        Visible = False
      end
      object cxgItensDIF_BASIPI: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_BASIPI'
        Visible = False
      end
      object cxgItensDIF_ALQIPI: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_ALQIPI'
        Visible = False
      end
      object cxgItensDIF_VALIPI: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_VALIPI'
        Visible = False
      end
      object cxgItensDIF_BASSUB: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_BASSUB'
        Visible = False
      end
      object cxgItensDIF_FATMVA: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_FATMVA'
        Visible = False
      end
      object cxgItensDIF_VALSUB: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_VALSUB'
        Visible = False
      end
      object cxgItensDIF_CODSIT: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_CODSIT'
        Visible = False
      end
      object cxgItensABFICM: TcxGridDBColumn
        Caption = 'Abrev. ICMS.'
        DataBinding.FieldName = 'ABFICM'
        Width = 65
      end
      object cxgItensPERFOR: TcxGridDBColumn
        Caption = 'Perfil do Fornec.'
        DataBinding.FieldName = 'PERFOR'
        Width = 90
      end
      object cxgItensABFPIS: TcxGridDBColumn
        Caption = 'Abr. PIS'
        DataBinding.FieldName = 'ABFPIS'
        Width = 52
      end
      object cxgItensPISCST: TcxGridDBColumn
        Caption = 'CST PIS'
        DataBinding.FieldName = 'PISCST'
        OnCustomDrawCell = cxgItensPISCSTCustomDrawCell
        Width = 47
      end
      object cxgItensPISVBC: TcxGridDBColumn
        Caption = 'Base. PIS'
        DataBinding.FieldName = 'PISVBC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensPISVBCCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensPISPPIS: TcxGridDBColumn
        Caption = 'Alq. PIS'
        DataBinding.FieldName = 'PISPPIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensPISPPISCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensPISVPIS: TcxGridDBColumn
        Caption = 'Vlr. PIS'
        DataBinding.FieldName = 'PISVPIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensPISVPISCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensABFCOF: TcxGridDBColumn
        Caption = 'Abr. COFINS.'
        DataBinding.FieldName = 'ABFCOF'
        Width = 70
      end
      object cxgItensCOFCST: TcxGridDBColumn
        Caption = 'CST COFINS'
        DataBinding.FieldName = 'COFCST'
        OnCustomDrawCell = cxgItensCOFCSTCustomDrawCell
        Width = 79
      end
      object cxgItensCOFVBC: TcxGridDBColumn
        Caption = 'Base. COFINS'
        DataBinding.FieldName = 'COFVBC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensCOFVBCCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgItensCOFPCOFINS: TcxGridDBColumn
        Caption = 'Alq. COFINS'
        DataBinding.FieldName = 'COFPCOFINS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensCOFPCOFINSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensCOFVCOFINS: TcxGridDBColumn
        Caption = 'Vlr. COFINS'
        DataBinding.FieldName = 'COFVCOFINS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensCOFVCOFINSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 72
      end
      object cxgItensDIF_PISCST: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PISCST'
        Visible = False
      end
      object cxgItensDIF_PISVBC: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PISVBC'
        Visible = False
      end
      object cxgItensDIF_PISPPIS: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PISPPIS'
        Visible = False
      end
      object cxgItensDIF_PISVPIS: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PISVPIS'
        Visible = False
      end
      object cxgItensDIF_COFCST: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_COFCST'
        Visible = False
      end
      object cxgItensDIF_COFVBC: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_COFVBC'
        Visible = False
      end
      object cxgItensDIF_COFPCOFINS: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_COFPCOFINS'
        Visible = False
      end
      object cxgItensDIF_COFVCOFINS: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_COFVCOFINS'
        Visible = False
      end
      object cxgItensDIF_PFCPST: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_PFCPST'
        Visible = False
        Options.Editing = False
      end
      object cxgItensDIF_VFCPST: TcxGridDBColumn
        DataBinding.FieldName = 'DIF_VFCPST'
        Visible = False
      end
      object cxgItensVBCFCPST: TcxGridDBColumn
        Caption = 'Base FCP ST'
        DataBinding.FieldName = 'VBCFCPST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVBCFCPSTCustomDrawCell
        Options.Editing = False
        Width = 71
      end
      object cxgItensPFCPST: TcxGridDBColumn
        Caption = 'Aliq. FCP ST'
        DataBinding.FieldName = 'PFCPST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVBCFCPSTCustomDrawCell
        Options.Editing = False
        Width = 71
      end
      object cxgItensVFCPST: TcxGridDBColumn
        Caption = 'Valor FCP ST'
        DataBinding.FieldName = 'VFCPST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(0.00)'
        OnCustomDrawCell = cxgItensVBCFCPSTCustomDrawCell
        Options.Editing = False
        Width = 71
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 535
    Width = 1145
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Shape1: TShape
      Left = 5
      Top = 8
      Width = 20
      Height = 20
      Brush.Color = clBlue
    end
    object Label1: TLabel
      Left = 31
      Top = 13
      Width = 104
      Height = 14
      Caption = 'Nota Eletr'#244'nica (XML)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape2: TShape
      Left = 5
      Top = 30
      Width = 20
      Height = 20
      Brush.Color = clGreen
    end
    object Label2: TLabel
      Left = 31
      Top = 35
      Width = 111
      Height = 14
      Caption = 'Calculado pelo Sistema'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape3: TShape
      Left = 173
      Top = 8
      Width = 20
      Height = 20
      Brush.Color = clRed
    end
    object Label3: TLabel
      Left = 199
      Top = 13
      Width = 63
      Height = 14
      Caption = 'Diverg'#234'ncias'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object Shape4: TShape
      Left = 173
      Top = 30
      Width = 20
      Height = 20
      Brush.Color = clYellow
    end
    object lblTolerancia: TLabel
      Left = 199
      Top = 35
      Width = 267
      Height = 14
      Caption = 'Diverg'#234'ncias dentro do limite de toler'#226'ncia (+/- R$ 0.05)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      StyleElements = []
    end
    object lblDivergenciaSTMensagem: TLabel
      Left = 908
      Top = 19
      Width = 208
      Height = 28
      Alignment = taCenter
      Caption = 
        'Diverg'#234'ncias de ST permite preparar GNRE automaticamente ao fina' +
        'l da libera'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
      StyleElements = []
    end
    object rdgCSTCad: TRadioGroup
      Left = 487
      Top = 8
      Width = 388
      Height = 47
      Caption = 'Na Entrada de Mercadorias utilizar a CST'
      Columns = 2
      Items.Strings = (
        'da Nota Eletr'#244'nica (XML)'
        'do Cadastro de Abrevia'#231#227'o Fiscal')
      TabOrder = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 104
  end
  object frxDivergencias: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44755.346338923600000000
    ReportOptions.LastChange = 44764.433788773150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure pPintarCelula(Sender: TfrxComponent);'
      'var'
      '  strValor: String;'
      'begin'
      
        '  strValor := fGetValorCampo('#39'DIF_'#39' + TFrxMemoView(Sender).DataF' +
        'ield);'
      ''
      '  // Linha = AZUL (NFe) VERDE(Autcom)'
      '  if <frxdbDivergencias."ELETRO"> = '#39'S'#39' then'
      '    TFrxMemoView(Sender).Font.Color := clBlue'
      '  else'
      '  if <frxdbDivergencias."ELETRO"> = '#39'N'#39' then'
      '    TFrxMemoView(Sender).Font.Color := clGreen;'
      ''
      '  // Cor da c'#233'lular = VERMELHO (Diverg'#234'ncia) AMARELO(Alerta)'
      '  if strValor = '#39'S'#39' then'
      '    TFrxMemoView(Sender).Color := clRed'
      '  else'
      '  if strValor = '#39'A'#39' then'
      '    TFrxMemoView(Sender).Color := clYellow;'
      'end;'
      ''
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxDivergenciasUserFunction
    Left = 440
    Top = 328
    Datasets = <
      item
        DataSet = frxDBDivergencias
        DataSetName = 'frxdbDivergencias'
      end>
    Variables = <
      item
        Name = ' Empresa'
        Value = Null
      end
      item
        Name = 'EMPRESA'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 655.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 22.677180000000000000
        Width = 2400.001550000000000000
        object EMPRESA: TfrxMemoView
          Align = baWidth
          Top = -0.000000000000000108
          Width = 2400.001550000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object memoExplicativo: TfrxMemoView
          Align = baWidth
          Top = 22.677180000000000000
          Width = 2400.001550000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clYellow
          HAlign = haCenter
          Memo.UTF8W = (
            'Diverg'#234'ncias...')
          ParentFont = False
        end
      end
      object ColumnHeader1: TfrxColumnHeader
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 90.708720000000000000
        Width = 2400.001550000000000000
        object memoFornec: TfrxMemoView
          Align = baWidth
          Top = 22.677180000000010000
          Width = 2400.001550000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Fill.BackColor = 8421440
          HAlign = haCenter
          Memo.UTF8W = (
            'Fornecedor: ')
          ParentFont = False
        end
        object memoNumdoc: TfrxMemoView
          Align = baWidth
          Top = 45.354360000000010000
          Width = 2400.001550000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Fill.BackColor = 8421440
          HAlign = haCenter
          Memo.UTF8W = (
            'Documento: ')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd.Item')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 68.031466770000000000
          Top = -0.000000000000000430
          Width = 120.944886770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          Memo.UTF8W = (
            'Descri'#231#227'o do Item')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 188.976353540000000000
          Top = -0.000000000000000430
          Width = 94.488176770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. F'#225'brica')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 283.464530310000000000
          Top = -0.000000000000000430
          Width = 94.488176770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Refer'#234'ncia')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 377.952707080000000000
          Top = -0.000000000000000430
          Width = 83.149586770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Unidade')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 461.102293849999900000
          Top = -0.000000000000000430
          Width = 83.149586770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'NCM')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 544.251880619999900000
          Top = -0.000000000000000430
          Width = 98.267706770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. Abrev. ICMS')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 642.519587390000000000
          Top = -0.000000000000000430
          Width = 154.960656770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Descri'#231#227'o Abrevia'#231#227'o ICMS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 797.480244160000000000
          Top = -0.000000000000000430
          Width = 52.913346770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 850.393590930000000000
          Top = -0.000000000000000430
          Width = 52.913346770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'CST')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 903.306937699999900000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Base ICMS')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 971.338404469999900000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Alq.ICMS')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 1039.369871240000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. ICMS')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Left = 1107.401338010000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Base Subst.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 1175.432804780000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'MVA')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 1243.464271550000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Subst.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 1311.495738320000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Base IPI')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 1379.527205090000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Alq. IPI')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 1447.558671860000000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. IPI')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 1515.590138629999000000
          Top = -0.000000000000000430
          Width = 68.031466770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Abrev. ICMS')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Left = 1583.621605399999000000
          Top = -0.000000000000000430
          Width = 105.826766770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Perfil do Forn.')
          ParentFont = False
        end
        object memoAbrPIS: TfrxMemoView
          Align = baLeft
          Left = 1689.448372169999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Abrev. PIS')
          ParentFont = False
        end
        object memoCSTPIST: TfrxMemoView
          Align = baLeft
          Left = 1761.259368939999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'CST PIS')
          ParentFont = False
        end
        object memoBasePIST: TfrxMemoView
          Align = baLeft
          Left = 1833.070365709999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Base PIS')
          ParentFont = False
        end
        object memoAliqPIST: TfrxMemoView
          Align = baLeft
          Left = 1904.881362479999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Alq. PIS')
          ParentFont = False
        end
        object memoVlrPIST: TfrxMemoView
          Align = baLeft
          Left = 1976.692359249999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. PIS')
          ParentFont = False
        end
        object memoCSTCOFT: TfrxMemoView
          Align = baLeft
          Left = 2120.314352790000000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'CST COF.')
          ParentFont = False
        end
        object memoBaseCOFT: TfrxMemoView
          Align = baLeft
          Left = 2192.125349560000000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Base COF.')
          ParentFont = False
        end
        object memoAlqCofT: TfrxMemoView
          Align = baLeft
          Left = 2263.936346330000000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Alq. COF.')
          ParentFont = False
        end
        object memoVlrCOFT: TfrxMemoView
          Align = baLeft
          Left = 2335.747343100000000000
          Top = -0.000000000000000430
          Width = 64.648818900000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. COF.')
          ParentFont = False
        end
        object memoAbrCofT: TfrxMemoView
          Align = baLeft
          Left = 2048.503356019999000000
          Top = -0.000000000000000430
          Width = 71.810996770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clBlack
          HAlign = haCenter
          Memo.UTF8W = (
            'Abrev. COF.')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 181.417440000000000000
        Width = 2400.001550000000000000
        AllowSplit = True
        DataSet = frxDBDivergencias
        DataSetName = 'frxdbDivergencias'
        RowCount = 0
        Stretched = True
        object Memo24: TfrxMemoView
          Align = baLeft
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CODITE'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CODITE"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 68.031466770000000000
          Top = -0.000000000000000860
          Width = 120.944886770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'DESITE'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxdbDivergencias."DESITE"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 188.976353540000000000
          Top = -0.000000000000000860
          Width = 94.488176770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CODFAB'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CODFAB"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Left = 283.464530310000000000
          Top = -0.000000000000000860
          Width = 94.488176770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'REFERE'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."REFERE"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 377.952707080000000000
          Top = -0.000000000000000860
          Width = 83.149586770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'SIGUNI'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."SIGUNI"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Left = 461.102293849999900000
          Top = -0.000000000000000860
          Width = 83.149586770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CLAIPI'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CLAIPI"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Left = 544.251880619999900000
          Top = -0.000000000000000860
          Width = 98.267706770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CODABF'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CODABF"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 642.519587390000000000
          Top = -0.000000000000000860
          Width = 154.960656770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'DESABF'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."DESABF"]')
          ParentFont = False
          WordBreak = True
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Left = 797.480244160000000000
          Top = -0.000000000000000860
          Width = 52.913346770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CLAFIS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CLAFIS"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 850.393590930000000000
          Top = -0.000000000000000860
          Width = 52.913346770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'CODSIT'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."CODSIT"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 903.306937699999900000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."BASICM"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 971.338404469999900000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'ALQICM'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."ALQICM"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 1039.369871240000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'VALICM'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."VALICM"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Align = baLeft
          Left = 1107.401338010000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'BASSUB'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."BASSUB"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Align = baLeft
          Left = 1175.432804780000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'FATMVA'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."FATMVA"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Left = 1243.464271550000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'VALSUB'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."VALSUB"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Align = baLeft
          Left = 1311.495738320000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'BASIPI'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."BASIPI"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Left = 1379.527205090000000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'ALQIPI'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."ALQIPI"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Align = baLeft
          Left = 1447.558671860000000000
          Top = -0.000000000000000860
          Width = 64.251936770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'VALIPI'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."VALIPI"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Align = baLeft
          Left = 1511.810608629999000000
          Top = -0.000000000000000860
          Width = 68.031466770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."ABFICM"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Align = baLeft
          Left = 1579.842075399999000000
          Top = -0.000000000000000860
          Width = 109.606296770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'PERFOR'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."PERFOR"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 1689.448372169999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'ABFPIS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."ABFPIS"]')
          ParentFont = False
        end
        object memoCSTPPIS: TfrxMemoView
          Align = baLeft
          Left = 1761.259368939999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'PISCST'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."PISCST"]')
          ParentFont = False
        end
        object memoBasePIS: TfrxMemoView
          Align = baLeft
          Left = 1833.070365709999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'PISVBC'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."PISVBC"]')
          ParentFont = False
        end
        object memoAliqPIS: TfrxMemoView
          Align = baLeft
          Left = 1904.881362479999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'PISPPIS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."PISPPIS"]')
          ParentFont = False
        end
        object memoVLRPIS: TfrxMemoView
          Align = baLeft
          Left = 1976.692359249999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'PISVPIS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."PISVPIS"]')
          ParentFont = False
        end
        object memoCSTCOF: TfrxMemoView
          Align = baLeft
          Left = 2120.314352790000000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'COFCST'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."COFCST"]')
          ParentFont = False
        end
        object memoBASECOF: TfrxMemoView
          Align = baLeft
          Left = 2192.125349560000000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'COFVBC'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."COFVBC"]')
          ParentFont = False
        end
        object memoAlqCOF: TfrxMemoView
          Align = baLeft
          Left = 2263.936346330000000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'COFPCOFINS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."COFPCOFINS"]')
          ParentFont = False
        end
        object memoVlrCOF: TfrxMemoView
          Align = baLeft
          Left = 2335.747343100000000000
          Top = -0.000000000000000860
          Width = 64.648818900000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataField = 'COFVCOFINS'
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."COFVCOFINS"]')
          ParentFont = False
        end
        object memoAbrCof: TfrxMemoView
          Align = baLeft
          Left = 2048.503356019999000000
          Top = -0.000000000000000860
          Width = 71.810996770000000000
          Height = 18.897637800000000000
          OnBeforePrint = 'pPintarCelula'
          StretchMode = smMaxHeight
          DataSet = frxDBDivergencias
          DataSetName = 'frxdbDivergencias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdbDivergencias."ABFCOF"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 102.047310000000000000
        Top = 616.063267950000000000
        Width = 2400.001550000000000000
        object Shape1: TfrxShapeView
          Left = 22.677180000000000000
          Top = 71.811192050000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clGreen
          Frame.Color = clGreen
        end
        object Memo22: TfrxMemoView
          Left = 60.472480000000000000
          Top = 71.811192050000000000
          Width = 188.976500000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Calculado pelo sistema')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Left = 22.677180000000000000
          Top = 41.574952049999820000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clBlue
          Frame.Color = clBlue
        end
        object Memo23: TfrxMemoView
          Left = 60.472480000000000000
          Top = 41.574952049999820000
          Width = 188.976500000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nota Fiscal Eletr'#244'nica ( XML )')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Align = baWidth
          Top = 3.779652049999935000
          Width = 2400.001550000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = 8421440
          Memo.UTF8W = (
            'Legendas')
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          Left = 381.732530000000000000
          Top = 71.811192050000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clRed
          Frame.Color = clRed
        end
        object Memo47: TfrxMemoView
          Left = 419.527830000000000000
          Top = 71.811192050000000000
          Width = 188.976500000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Diverg'#234'ncias')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 381.732530000000000000
          Top = 41.574952049999820000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clYellow
          Frame.Color = clYellow
        end
        object memoLegDiv: TfrxMemoView
          Left = 419.527830000000000000
          Top = 41.574952049999820000
          Width = 332.598640000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 44718
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Alertas')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDivergencias: TfrxDBDataset
    UserName = 'frxdbDivergencias'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 440
    Top = 376
  end
  object frxPDFExport: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = True
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 440
    Top = 424
  end
  object fodDestino: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'PDF'
        FileMask = '*.pdf'
      end>
    Options = []
    Left = 440
    Top = 472
  end
end
