inherited frmRelComissaoProfissionalCTR: TfrmRelComissaoProfissionalCTR
  Left = 284
  Top = 108
  Width = 392
  Height = 703
  Caption = 'Relat'#243'rio de Comiss'#227'o por Profissional - Contas a Receber'
  OnDestroy = FormDestroy
  ExplicitWidth = 392
  ExplicitHeight = 703
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 632
    Width = 386
    ExplicitTop = 632
    ExplicitWidth = 386
    inherited FlwBotoes: TFlowPanel
      Width = 305
    end
    inherited btnSair: TBitBtnLocked
      Left = 307
      ExplicitLeft = 307
    end
  end
  inherited pnlDados: TPanel
    Width = 386
    Height = 632
    ExplicitWidth = 386
    ExplicitHeight = 632
    object Label1: TLabel [0]
      Left = 5
      Top = 8
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [1]
      Left = 78
      Top = 8
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
    object Label3: TLabel [2]
      Left = 5
      Top = 46
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProfissional: TLabel [3]
      Left = 5
      Top = 130
      Width = 56
      Height = 14
      Caption = 'Profissional'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 182
      Top = 315
      Width = 192
      Height = 50
      TabOrder = 12
      ExplicitLeft = 182
      ExplicitTop = 315
      ExplicitWidth = 192
      ExplicitHeight = 50
      inherited ColorLabel1: TColorLabel
        Top = 23
        ExplicitTop = 23
      end
      inherited edtDestino: TEditFocus
        Top = 20
        ExplicitTop = 20
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 5
      Top = 22
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 78
      Top = 22
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      OnExit = mskDtaFinExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 5
      Top = 60
      Width = 56
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
      TabOrder = 2
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
    object edtDesEmpresa: TEditFocus
      Left = 62
      Top = 60
      Width = 312
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodProfissional: TEditFocus
      Tag = 99
      Left = 5
      Top = 144
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodProfissionalExit
      OnKeyPress = edtCodProfissionalKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesProfissional: TEditFocus
      Left = 69
      Top = 144
      Width = 305
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgTipRel: TRadioGroup
      Left = 5
      Top = 263
      Width = 169
      Height = 102
      Caption = 'Tipo de Relat'#243'rio'
      ItemIndex = 0
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico'
        'Recibo')
      TabOrder = 10
      OnClick = rdgTipRelClick
    end
    object rdgPerCom: TRadioGroup
      Left = 5
      Top = 192
      Width = 369
      Height = 50
      Caption = 'Utilizar % de comiss'#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Calculado na venda'
        'Cadastro de Diversos')
      TabOrder = 8
    end
    object rdgComRes: TRadioGroup
      Left = 182
      Top = 263
      Width = 192
      Height = 50
      Caption = 'Op'#231#227'o Anal'#237'tico'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Completo'
        'Resumido')
      TabOrder = 11
    end
    object grbRecibo: TGroupBox
      Left = 5
      Top = 367
      Width = 369
      Height = 100
      Caption = 'Dados para o Recibo'
      Enabled = False
      TabOrder = 13
      object Label5: TLabel
        Left = 8
        Top = 18
        Width = 42
        Height = 14
        Caption = 'Hist'#243'rico'
      end
      object Label6: TLabel
        Left = 8
        Top = 56
        Width = 70
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data do recibo'
      end
      object Label7: TLabel
        Left = 93
        Top = 56
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade vias'
      end
      object edtHisRec: TEditFocus
        Tag = 99
        Left = 8
        Top = 32
        Width = 355
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 80
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaRec: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 70
        Width = 81
        Height = 22
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object edtQtdVia: TEditFocus
        Tag = 99
        Left = 90
        Top = 70
        Width = 81
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
        Text = '2'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
    object chkConJur: TCheckBox
      Left = 5
      Top = 244
      Width = 372
      Height = 17
      Caption = 'Considerar juros cobrado para c'#225'lculo da comiss'#227'o?'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkResumo: TCheckBox
      Left = 5
      Top = 168
      Width = 371
      Height = 25
      Caption = 'Imprimir resumo por Profissional e modalidade de recebimento'
      TabOrder = 7
      WordWrap = True
    end
    object rdgStatus: TRadioGroup
      Left = 5
      Top = 88
      Width = 369
      Height = 41
      Caption = 'Status do Profissional'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Ativo'
        'Inativo'
        'Todos')
      TabOrder = 4
    end
    object rdgPosCom: TRadioGroup
      Left = 5
      Top = 471
      Width = 369
      Height = 65
      Caption = 'Posi'#231#227'o da Comiss'#227'o - Contas a Pagar'
      ItemIndex = 0
      Items.Strings = (
        'Todas'
        'Pendentes (Sem contas a pagar)'
        'Baixadas (Com contas a pagar gerado)')
      TabOrder = 14
    end
    object grbGerCadPag: TGroupBox
      Left = 5
      Top = 536
      Width = 369
      Height = 89
      Caption = 'Gravar Contas a Pagar'
      TabOrder = 15
      object lblDtaVen: TLabel
        Left = 8
        Top = 64
        Width = 99
        Height = 14
        Caption = 'Data de Vencimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkGerCadPag: TCheckBox
        Left = 8
        Top = 16
        Width = 250
        Height = 17
        Caption = 'Gravar contas a pagar referente a comiss'#227'o'
        TabOrder = 0
        OnClick = chkGerCadPagClick
      end
      object mskDtaVen: TMaskEditFocus
        Tag = 99
        Left = 109
        Top = 61
        Width = 62
        Height = 22
        Enabled = False
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentFont = False
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 5
        Top = 33
        Width = 359
        Height = 22
        TabOrder = 1
        ExplicitLeft = 5
        ExplicitTop = 33
        ExplicitWidth = 359
        inherited lblPlaContas: TLabel
          Left = 3
          Width = 81
          Height = 14
          ExplicitLeft = 3
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 166
          Width = 192
          Height = 22
          ExplicitLeft = 166
          ExplicitWidth = 192
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 104
          Width = 62
          Height = 22
          Enabled = False
          ExplicitLeft = 104
          ExplicitWidth = 62
          ExplicitHeight = 22
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 658
    Width = 386
    ExplicitTop = 658
    ExplicitWidth = 386
    inherited pnlNomeForm: TPanel
      Left = 215
      ExplicitLeft = 215
    end
    inherited pnlInfo: TPanel
      Width = 215
      ExplicitWidth = 215
      inherited shpMultSel: TShape
        Left = 201
        ExplicitLeft = 201
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 384
    Top = 56
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 448
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 416
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 384
    Top = 88
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 544
    Top = 56
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 512
    Top = 56
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 448
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 480
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 512
    Top = 88
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 544
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 152
  end
  object frxComissaoProfissionalCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41090.749550775460000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure mmoTotDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalProfissional(rllValComDiv.Text);  '
      'end;'
      ''
      'begin'
      '                             '
      'end.')
    OnUserFunction = frxComissaoProfissionalCTR_MUserFunction
    Left = 512
    Top = 120
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      BottomMargin = 4.497916666666670000
      OnBeforePrint = 'PComissaoOnBeforePrint'
      FontStyle = []
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1276.800000000000000000
        Child = frxComissaoProfissionalCTR_M.CHeader
        Condition = 'frxRelatorio."CTR_CODDIV"'
        ReprintOnNewPage = True
        object DMPCommand5: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 345.600000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComAna: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          TruncOutboundText = False
        end
        object rllPerComAna: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1276.800000000000000000
        Child = frxComissaoProfissionalCTR_M.CRecibo
        object Memo1: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object mmoTotDiv: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'mmoTotDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object rllValComDiv: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllValComDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [PROFISSIONAL]: ')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllPerComDiv: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 493.000000000000000000
        Width = 1276.800000000000000000
        Child = frxComissaoProfissionalCTR_M.CResumo
        object DMPMemo27: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 612.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 442.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        AllowSplit = True
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComissaoProfissionalCTR_M.Page1
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 255.000000000000000000
        Width = 1276.800000000000000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object mmoProfissional: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 825.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PROFISSIONAL]: [frxRelatorio."PROFISSIONAL"]')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DATA REC')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLIC.ORIGINAL')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL ORI')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONT.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL REC')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A/P')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComissaoProfissionalCTR_M.CPageHeader
        PrintChildIfInvisible = True
        object DMPMemo24: TfrxDMPMemoView
          Align = baCenter
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand6: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo42: TfrxDMPMemoView
          Align = baCenter
          Left = 441.600000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Align = baCenter
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 960.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER'
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1276.800000000000000000
        object rllPaginaAux: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#80'
        end
        object DMPCommand7: TfrxDMPCommand
          Left = 1267.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 578.000000000000000000
        Width = 1276.800000000000000000
        object Subreport2: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComissaoProfissionalCTR_M.Page2
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo25: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 408.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = -115.200000000000000000
          Top = 272.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 136.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 442.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 467.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo21: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1276.800000000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object DMPMemo39: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS'#195'O $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS'#195'O %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo54: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL PROFISSIONAL:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxCabecalho: TfrxUserDataSet
    UserName = 'frxCabecalho'
    Fields.Strings = (
      'EMPRESA'
      'PROFISSIONAL'
      'PERIODO'
      'intDivDig')
    OnGetValue = frxCabecalhoGetValue
    Left = 416
    Top = 120
  end
  object frxComissaoProfissionalCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41012.626638263900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure mmoTotDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalProfissional(rllValComDiv.Text);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComissaoProfissionalCTR_MUserFunction
    Left = 544
    Top = 120
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      PaperWidth = 230.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 245.669450000000000000
        Width = 831.496600000000000000
        Child = frxComissaoProfissionalCTR_J.CHeader
        Condition = 'frxRelatorio."CTR_CODDIV"'
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 336.378170000000000000
        Width = 831.496600000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Align = baClient
          Width = 831.496600000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 26.456710000000000000
          Top = 1.000000000000000000
          Width = 46.866141732283460000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 76.481880000000000000
          Top = 1.000000000000000000
          Width = 134.173233230000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 215.733890000000000000
          Top = 1.000000000000000000
          Width = 130.393703230000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 350.108720000000000000
          Top = 1.000000000000000000
          Width = 93.278540000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 447.412430000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 515.748041260000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 573.903710000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 634.448828660000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllValComAna: TfrxMemoView
          Left = 706.410760000000000000
          Top = 1.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 1.000000000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          ParentFont = False
        end
        object rllPerComAna: TfrxMemoView
          Left = 772.244590000000000000
          Top = 1.000000000000000000
          Width = 54.425189530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          ParentFont = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 377.953000000000000000
        Width = 831.496600000000000000
        Child = frxComissaoProfissionalCTR_J.CRecibo
        object Memo22: TfrxMemoView
          Left = 515.748041260000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoValDes: TfrxMemoView
          Left = 573.903710000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoTotDiv: TfrxMemoView
          Left = 634.448828660000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          OnAfterData = 'mmoTotDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object rllValComDiv: TfrxMemoView
          Left = 706.410760000000000000
          Top = 1.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          OnAfterData = 'rllValComDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 826.582723540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 447.412430000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 170.590385200000000000
          Top = 1.000000000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [PROFISSIONAL] : ')
          ParentFont = False
        end
        object rllPerComDiv: TfrxMemoView
          Left = 772.244590000000000000
          Top = 1.000000000000000000
          Width = 54.425189530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.251968500000000000
        Top = 502.677490000000000000
        Width = 831.496600000000000000
        Child = frxComissaoProfissionalCTR_J.CResumo
        object Memo27: TfrxMemoView
          Left = 447.412430000000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 515.748041260000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 573.903710000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 634.448828660000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 706.410760000000000000
          Top = 1.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 298.204726850000000000
          Top = 1.779530000000000000
          Width = 144.302350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 826.582723540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPerComTot: TfrxMemoView
          Left = 772.244590000000000000
          Top = 1.000000000000000000
          Width = 54.425189530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 827.567410000000000000
          Top = 19.472480000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 631.181510000000000000
        Width = 831.496600000000000000
        object Memo1: TfrxMemoView
          Left = 456.717810000000000000
          Top = 4.000000000000000000
          Width = 369.411070000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 831.496600000000000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComissaoProfissionalCTR_J.CPageHeader
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 201.033520000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 710.324180000000000000
          Top = 37.795300000000000000
          Width = 109.984230000000000000
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
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 767.924180000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 631.861410000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 287.509030000000000000
          Top = 54.779530000000000000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoProfissional: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 373.643970000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 472.929810000000000000
          Top = 78.440940000000000000
          Width = 347.187260000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 163.200310000000000000
          Top = 36.897650000000000000
          Width = 505.095980000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 120.267780000000000000
          Width = 823.937540000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 98.267780000000000000
          Width = 373.795275590000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 423.307360000000000000
        Width = 831.496600000000000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        AllowSplit = True
        Stretched = True
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComissaoProfissionalCTR_J.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 166.299320000000000000
        Width = 831.496600000000000000
        object rllPaginaAux: TfrxMemoView
          Left = 604.724800000000000000
          Width = 223.370130000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 272.126160000000000000
        Width = 831.496600000000000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object Memo35: TfrxMemoView
          Left = 3.875510000000000000
          Top = 2.779530000000020000
          Width = 518.400000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PROFISSIONAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Top = 20.559060000000000000
          Width = 827.717070000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 26.456692910000000000
          Top = 22.559060000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEB.')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 76.440944880000000000
          Top = 22.559060000000000000
          Width = 63.722820000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 215.733890000000000000
          Top = 22.559060000000000000
          Width = 89.877180000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUP. ORIGINAL')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 349.984295910000000000
          Top = 22.559060000000000000
          Width = 52.081880000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 447.412430000000000000
          Top = 22.559060000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. ORI.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 515.748041260000000000
          Top = 22.559060000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 573.903710000000000000
          Top = 22.559060000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCON.')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 634.448828660000000000
          Top = 22.559060000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. REC.')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 706.410760000000000000
          Top = 22.559060000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1.000000000000000000
          Top = 22.338590000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A/P')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 772.244590000000000000
          Top = 22.559060000000000000
          Width = 54.425189530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 589.606680000000000000
        Width = 831.496600000000000000
        object Subreport2: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComissaoProfissionalCTR_J.Page2
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 230.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.220780000000000000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Width = 755.906000000000000000
          Height = 408.189240000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 275.905690000000000000
          Top = 332.598640000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 22.677180000000000000
          Top = 385.512060000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxUser."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 15.118120000000000000
          Top = 212.724490000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 49.133890000000000000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 26.456710000000000000
          Top = 105.826840000000000000
          Width = 702.992580000000000000
          Height = 90.708720000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 230.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 124.000000000000000000
        Width = 831.496600000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo5: TfrxMemoView
          Left = 605.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 512.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 426.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 335.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 135.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 64.000000000000000000
        Width = 831.496600000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object Memo59: TfrxMemoView
          Left = 605.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 135.755905510000000000
          Top = 17.007874020000000000
          Width = 562.393937560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 512.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 426.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 335.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 135.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 160.000000000000000000
        Width = 831.496600000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo60: TfrxMemoView
          Left = 605.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 512.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 426.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 335.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 135.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 16.000000000000000000
        Width = 831.496600000000000000
        object Memo6: TfrxMemoView
          Left = 135.755905510000000000
          Width = 562.393937560000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComissaoProfissionalSintCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40266.473066400460000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 544
    Top = 152
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object RTComissao: TfrxReportTitle
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1238.400000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object frxCabecalhoPERIODO: TfrxDMPMemoView
          Align = baCenter
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object frxCabecalhoProfissional: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          TruncOutboundText = False
        end
        object frxCabecalhoEMPRESA: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 85.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object mmoTitRel: TfrxDMPMemoView
          Align = baCenter
          Left = 172.800000000000000000
          Top = 34.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER'
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object rllTipo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 289.000000000000000000
        Width = 1238.400000000000000000
        Child = frxComissaoProfissionalSintCTR_M.CResumo
        object DMPMemo30: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Total Geral    : ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          TruncOutboundText = False
        end
        object rllPerCo2Tot: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object HeaderSintetico: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1238.400000000000000000
        ReprintOnNewPage = True
        object DMPMemo12: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.c/Imp')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object mmoProfissional: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PROFISSIONAL]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1228.800000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.(A.V)')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.(A.P)')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.s/Imp')
          TruncOutboundText = False
        end
        object rllPerCo2Tit: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1238.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo5: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComDiv: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."PROFISSIONAL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 950.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_AVISTA"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_APRAZO"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALFAT"]')
          TruncOutboundText = False
        end
        object frxCabecalhofltTotAbe: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          TruncOutboundText = False
        end
        object rllPerComDiv: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          TruncOutboundText = False
        end
        object rllPerCo2Div: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          TruncOutboundText = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1238.400000000000000000
        object Subreport1: TfrxSubreport
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComissaoProfissionalSintCTR_M.Page1
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo9: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1238.400000000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object DMPMemo39: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISSAO %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1238.400000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1238.400000000000000000
        object DMPMemo54: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxComissaoProfissionalSintCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 40266.472670891210000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 512
    Top = 152
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 253.228510000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Top = 1.220470000000006000
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 354.897625590000000000
          Top = 1.000000000000000000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECIPI"]')
          ParentFont = False
        end
        object rllValComDiv: TfrxMemoView
          Left = 427.842507480000000000
          Top = 1.000000000000000000
          Width = 73.322819999999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.133858269999990000
          Width = 121.549350000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PROFISSIONAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 570.708661420000000000
          Top = 1.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_AVISTA"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 685.606299212598400000
          Top = 1.000000000000000000
          Width = 65.763779527559050000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_APRAZO"]')
          ParentFont = False
        end
        object frxGenfltValFat: TfrxMemoView
          Left = 129.165430000000000000
          Top = 1.000000000000000000
          Width = 73.322834650000000000
          Height = 13.228346460000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
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
            '[frxRelatorio."CTR_VALFAT"]')
          ParentFont = False
        end
        object frxCabecalhofltTotAbe: TfrxMemoView
          Left = 206.094620000000000000
          Top = 1.133858269999990000
          Width = 73.322834650000000000
          Height = 13.228346460000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPerComDiv: TfrxMemoView
          Left = 508.346446930000000000
          Top = 1.000000000000000000
          Width = 58.204700000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 281.574790940000000000
          Top = 1.000000000000000000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllPerCo2Div: TfrxMemoView
          Left = 638.740570000000000000
          Top = 0.755905509999991000
          Width = 43.086580000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, '
            
              '(<frxRelatorio."VALOR_COMISSAO"> / <frxRelatorio."CTR_RECCOM">) ' +
              '* 100 , 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.236240000000000000
        Top = 332.598640000000000000
        Width = 755.906000000000000000
        Child = frxComissaoProfissionalSintCTR_J.CResumo
        object Memo30: TfrxMemoView
          Left = 354.897625590000000000
          Top = 7.779530000000022000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECIPI">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 427.842507480000000000
          Top = 7.779530000000022000
          Width = 73.322834650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 27.102040000000000000
          Top = 7.779530000000022000
          Width = 91.388930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral : ')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 570.708661417322800000
          Top = 7.559059999999988000
          Width = 65.763779527559050000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 685.606299212598400000
          Top = 7.559059999999988000
          Width = 65.763779527559050000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 129.259847400000000000
          Top = 7.559059999999988000
          Width = 73.322819999999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 205.984239760000000000
          Top = 7.669293779999974000
          Width = 73.322834650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          ParentFont = False
        end
        object rllPerComTot: TfrxMemoView
          Left = 508.346446930000000000
          Top = 7.779530000000022000
          Width = 58.204714650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 3.559059999999988000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 25.677180000000020000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo22: TfrxMemoView
          Left = 281.574790940000000000
          Top = 7.559059999999988000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllPerCo2Tot: TfrxMemoView
          Left = 638.740570000000000000
          Top = 7.559059999999988000
          Width = 43.086594650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            
              '(SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)/ SUM(<frxRelatorio."CT' +
              'R_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 461.102660000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          Left = 456.717810000000000000
          Top = 4.000000000000057000
          Width = 293.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 211.653680000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          Width = 755.906000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object mmoProfissional: TfrxMemoView
          Left = 3.494310000000000000
          Top = 2.000000000000000000
          Width = 123.892950000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[PROFISSIONAL]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 354.897625590000000000
          Top = 2.000000000000000000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. s/ Imp.')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 427.843660000000000000
          Top = 2.000000000000000000
          Width = 73.322834650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 570.606680000000000000
          Top = 2.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.(A.V)')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 685.606299212598400000
          Top = 2.000000000000000000
          Width = 65.763779527559050000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.(A.P)')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 129.259847400000000000
          Top = 1.779529999999994000
          Width = 73.322834650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 205.984239760000000000
          Top = 1.889763780000010000
          Width = 73.322834650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 509.236550000000000000
          Top = 1.889763780000010000
          Width = 58.204714650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 281.574790940000000000
          Top = 1.779529999999994000
          Width = 69.543307090000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'REC. c/ Imp.')
          ParentFont = False
        end
        object rllPerCo2Tit: TfrxMemoView
          Left = 639.740570000000000000
          Top = 1.889763780000010000
          Width = 43.086594650000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 163.238220000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 627.174520000000000000
          Top = 37.795300000000000000
          Width = 117.543290000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 692.333580000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 556.270810000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 249.713730000000000000
          Top = 54.779529999999990000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoProfissional: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 373.643970000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 397.339210000000000000
          Top = 78.338590000000000000
          Width = 347.187260000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 134.853835000000000000
          Top = 36.897650000000000000
          Width = 486.198330000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 123.267780000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559055120000000000
          Top = 99.047310000000000000
          Width = 373.795275590000000000
          Height = 18.897650000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 419.527830000000000000
        Width = 755.906000000000000000
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComissaoProfissionalSintCTR_J.Page1
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 132.283550000000000000
        Width = 755.906000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo18: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 68.031540000000000000
        Width = 755.906000000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object Memo59: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Align = baCenter
          Left = 96.756031220000000000
          Top = 17.007874020000000000
          Width = 562.393937560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 173.858380000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo60: TfrxMemoView
          Left = 566.173588390000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 473.952753460000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 387.023622050000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 296.314960630000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 96.755905510000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo31: TfrxMemoView
          Align = baCenter
          Left = 96.756031220000000000
          Width = 562.393937560000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComissaoProfissionalCTRP_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41012.630747604200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure mmoTotDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;'
      '  PageHeader.Visible  := False;      '
      'end;'
      '  '
      'procedure CAfterReciboOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' PageHeader.Visible  := True;  '
      'end;'
      ''
      'procedure rllValComDivOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalProfissional(rllValComDiv.Text);  '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                         '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComissaoProfissionalCTR_MUserFunction
    Left = 448
    Top = 120
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 245.669450000000000000
        Width = 1084.725110000000000000
        Child = frxComissaoProfissionalCTRP_J.CHeader
        Condition = 'frxRelatorio."CTR_CODDIV"'
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 336.378170000000000000
        Width = 1084.725110000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Top = 1.220469999999980000
          Width = 1084.725110000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 98.267780000000000000
          Top = 1.000000000000000000
          Width = 58.204700000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 160.292950000000000000
          Top = 1.000000000000000000
          Width = 130.393700787401600000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 298.960629921259800000
          Top = 1.000000000000000000
          Width = 130.393700790000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 437.037910000000000000
          Top = 1.000000000000000000
          Width = 240.680210000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 687.496043460000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 755.527539530000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 816.755885980000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 877.228326930000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          ParentFont = False
        end
        object rllValComAna: TfrxMemoView
          Left = 949.417303310000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 1.000000000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          ParentFont = False
        end
        object rllPerComAna: TfrxMemoView
          Left = 1017.070849060000000000
          Top = 1.000000000000000000
          Width = 61.984230000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 1.000000000000000000
          Width = 69.543290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 377.953000000000000000
        Width = 1084.725110000000000000
        Child = frxComissaoProfissionalCTRP_J.CRecibo
        object Memo22: TfrxMemoView
          Left = 755.527539530000000000
          Top = 2.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 816.755885980000000000
          Top = 2.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          ParentFont = False
        end
        object mmoTotDiv: TfrxMemoView
          Left = 877.228326930000000000
          Top = 2.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          OnAfterPrint = 'mmoTotDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object rllValComDiv: TfrxMemoView
          Left = 949.417303310000000000
          Top = 2.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          OnAfterPrint = 'rllValComDivOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 18.500000000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 687.496043460000000000
          Top = 2.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 412.480305200000000000
          Top = 1.000000000000000000
          Width = 272.957480310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [PROFISSIONAL] : ')
          ParentFont = False
        end
        object rllPerComDiv: TfrxMemoView
          Left = 1017.070849060000000000
          Top = 2.000000000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 64.251968503937010000
        Top = 540.472790000000000000
        Width = 1084.725110000000000000
        Child = frxComissaoProfissionalCTRP_J.CResumo
        object Memo27: TfrxMemoView
          Left = 691.165525200000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 759.197021260000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 820.425367720000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 880.897808660000000000
          Top = 1.000000000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          ParentFont = False
        end
        object rllValComTot: TfrxMemoView
          Left = 952.708832280000000000
          Top = 1.000000000000000000
          Width = 61.984251970000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 416.125967170000000000
          Top = 0.779530000000022000
          Width = 272.806370000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          ParentFont = False
        end
        object rllPerComTot: TfrxMemoView
          Left = 1018.472636220000000000
          Top = 1.000000000000000000
          Width = 61.984269060000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 672.756340000000000000
        Width = 1084.725110000000000000
        object Memo1: TfrxMemoView
          Left = 789.316450000000000000
          Top = 4.000000000000000000
          Width = 293.820470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS : [COUNT(MDComissao)]')
          ParentFont = False
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.000000000000000000
          Width = 786.142240000000000000
          Height = 18.897650000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'PageHeaderOnAfterPrint'
        Child = frxComissaoProfissionalCTRP_J.CPageHeader
        PrintChildIfInvisible = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 327.647775000000000000
          Top = 18.897650000000000000
          Width = 429.429560000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 937.095980000000000000
          Top = 37.795300000000000000
          Width = 144.000000000000000000
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
          WordWrap = False
        end
        object Time: TfrxMemoView
          Left = 1028.711750000000000000
          Top = 54.795300000000000000
          Width = 52.384230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          WordWrap = False
        end
        object Date: TfrxMemoView
          Left = 892.648980000000000000
          Top = 54.795300000000000000
          Width = 134.021830000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          WordWrap = False
        end
        object frxCabecalhoPERIODO: TfrxMemoView
          Align = baCenter
          Left = 414.123285000000000000
          Top = 54.779530000000000000
          Width = 256.478540000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          ParentFont = False
        end
        object frxCabecalhoProfissional: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 532.384230000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 544.740880000000000000
          Top = 78.338590000000000000
          Width = 536.163760000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          ParentFont = False
        end
        object mmoTitRel: TfrxMemoView
          Align = baCenter
          Left = 151.861720000000000000
          Top = 36.897650000000000000
          Width = 781.001670000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 120.267780000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllTipo: TfrxMemoView
          Left = 7.559060000000000000
          Top = 98.267780000000000000
          Width = 373.795275590000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STATUS]')
          ParentFont = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 423.307360000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'CReciboOnBeforePrint'
        Child = frxComissaoProfissionalCTRP_J.CAfterRecibo
        object Subreport1: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxComissaoProfissionalCTRP_J.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 166.299320000000000000
        Width = 1084.725110000000000000
        object rllPaginaAux: TfrxMemoView
          Left = 937.323440000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 272.126160000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'CHeaderOnAfterPrint'
        object Memo35: TfrxMemoView
          Left = 3.875510000000000000
          Top = 2.779530000000000000
          Width = 518.400000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PROFISSIONAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Top = 22.677180000000000000
          Width = 1084.725110000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 98.267762910000000000
          Top = 24.677180000000000000
          Width = 58.204700000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECEBIM')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 160.252014880000000000
          Top = 24.677180000000000000
          Width = 63.722820000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 298.960629921259800000
          Top = 24.677180000000000000
          Width = 97.436240000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUP. ORIGINAL')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 436.913485910000000000
          Top = 24.677180000000000000
          Width = 82.318120000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 687.606465200000000000
          Top = 24.677180000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. ORI.')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 755.637961260000000000
          Top = 24.677180000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 816.793630000000000000
          Top = 24.677180000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCON.')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 877.338748660000000000
          Top = 24.677180000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. REC.')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 949.300680000000000000
          Top = 24.677180000000000000
          Width = 61.984249530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL. COM.')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 1.000000000000000000
          Top = 24.456710000000000000
          Width = 24.188930000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'A/P')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 1016.914040000000000000
          Top = 24.677180000000000000
          Width = 65.763779530000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 26.456710000000000000
          Top = 24.677180000000000000
          Width = 69.543290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
      end
      object CAfterRecibo: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 464.882190000000000000
        Width = 1084.725110000000000000
        OnAfterPrint = 'CAfterReciboOnAfterPrint'
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 627.401980000000000000
        Width = 1084.725110000000000000
        object Subreport2: TfrxSubreport
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          Page = frxComissaoProfissionalCTRP_J.Page2
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.220780000000000000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Width = 755.906000000000000000
          Height = 408.189240000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 275.905690000000000000
          Top = 332.598640000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 22.677180000000000000
          Top = 385.512060000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxUser."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 15.118120000000000000
          Top = 212.724490000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 49.133890000000000000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 26.456710000000000000
          Top = 105.826840000000000000
          Width = 702.992580000000000000
          Height = 90.708720000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 136.063080000000000000
        Width = 1084.725110000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object Memo7: TfrxMemoView
          Left = 261.165354330000000000
          Width = 195.779527560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 456.566926690000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 551.055118110000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 641.763779530000000000
          Width = 85.417320390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 44.598425200000000000
        Top = 68.031540000000000000
        Width = 1084.725110000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object Memo8: TfrxMemoView
          Left = 261.165586220000000000
          Width = 199.559057560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 261.165354330000000000
          Top = 15.897650000000000000
          Width = 566.173467560000000000
          Height = 28.724409450000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 460.346456690000000000
          Width = 89.196850390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'C. IMPOSTO')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 547.275588110000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'S. IMPOSTO')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 637.984249530000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. $')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS. %')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874015748030000
        Top = 177.637910000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        object Memo10: TfrxMemoView
          Left = 261.165354330708700000
          Width = 195.779527560000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 456.566926690000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 547.275588110000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 637.984249530000000000
          Width = 92.976380390000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 728.315431730000000000
          Width = 99.023622050000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 24.566929130000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Memo4: TfrxMemoView
          Left = 261.165586220000000000
          Width = 566.173467560000000000
          Height = 24.559060000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxComissaoProfissionalCTRP_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41012.726756539300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure mmoTotDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure CHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  If CRecibo.Visible Then                        '
      '    CHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      '  CPageHeader.Visible := False;'
      'end;'
      ''
      'procedure PageHeaderOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ' If CRecibo.Visible Then'
      '   PageHeader.Visible := False;'
      'end;'
      ''
      'procedure rllPaginaAuxOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' rllPaginaAux.Text := '#39'PAGINA: '#39' + rllPaginaAux.Text;'
      'end;'
      ''
      'procedure CReciboOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  CPageHeader.Visible := True;  '
      'end;'
      ''
      'procedure rllValComDivOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  pSetaTotalProfissional(rllValComDiv.Text);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComissaoProfissionalCTR_MUserFunction
    Left = 480
    Top = 120
    Datasets = <
      item
        DataSet = frxCabecalho
        DataSetName = 'frxCabecalho'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumo
        DataSetName = 'frxResumo'
      end
      item
        DataSet = frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComissaoProfissionalCTRP_M.CHeader
        Condition = 'frxRelatorio."CTR_CODDIV"'
        ReprintOnNewPage = True
        object DMPCommand6: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDES"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object rllValComAna: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_FORMAPG"]')
          TruncOutboundText = False
        end
        object rllPerComAna: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0, (<frxRelatorio."VALOR_COM' +
              'ISSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          TruncOutboundText = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComissaoProfissionalCTRP_M.CRecibo
        object Memo1: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object mmoTotDiv: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'mmoTotDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object rllValComDiv: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllValComDivOnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 480.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL [PROFISSIONAL]: ')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComDiv: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, (SUM(<f' +
              'rxRelatorio."VALOR_COMISSAO">,MDComissao,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 476.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComissaoProfissionalCTRP_M.CResumo
        object DMPMemo27: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALORI">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALJUR">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALDES">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object rllValComTot: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL: ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object rllPerComTot: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.000000'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, (SUM(<frxRelator' +
              'io."VALOR_COMISSAO">,0,0)/'
            'SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 595.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object CRecibo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 425.000000000000000000
        Width = 1526.400000000000000000
        object Subreport1: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComissaoProfissionalCTRP_M.Page1
        end
      end
      object CPageHeader: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1526.400000000000000000
        object rllPaginaAux: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaAuxOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object DMPCommand7: TfrxDMPCommand
          Left = 1507.200000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
      object PageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        Child = frxComissaoProfissionalCTRP_M.CPageHeader
        object DMPMemo41: TfrxDMPMemoView
          Align = baCenter
          Left = 316.800000000000000000
          Top = 17.000000000000000000
          Width = 892.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
        object DMPMemo52: TfrxDMPMemoView
          Align = baCenter
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'PERIODO'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCabecalho."PERIODO"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PROFISSIONAL'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."PROFISSIONAL"]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 998.400000000000000000
          Top = 85.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataField = 'EMPRESA'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCabecalho."EMPRESA"]')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Align = baCenter
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR [PROFISSIONAL] - CONTAS A RECEBER')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object CHeader: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 255.000000000000000000
        Width = 1526.400000000000000000
        object mmoProfissional: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoProfissionalOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PROFISSIONAL]: [frxRelatorio."PROFISSIONAL"]')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DATA CAD.')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLIC.ORIGINAL')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL ORI')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo57: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTOS')
          TruncOutboundText = False
        end
        object DMPMemo58: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL REC')
          TruncOutboundText = False
        end
        object DMPMemo59: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL COM')
          TruncOutboundText = False
        end
        object DMPMemo60: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'A/P')
          TruncOutboundText = False
        end
        object DMPMemo61: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPMemo62: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DATA REC.')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
      end
      object CResumo: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 561.000000000000000000
        Width = 1526.400000000000000000
        object Subreport2: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxComissaoProfissionalCTRP_M.Page2
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 476.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo31: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 408.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMASS'
          DataSet = frxUser
          DataSetName = 'frxUser'
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = -115.200000000000000000
          Top = 272.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 748.800000000000000000
          Height = 136.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"] a importancia ' +
              'supra mencionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC"' +
              '>)] ( [frxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object DMPLine10: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 442.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 467.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 19.200000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 19.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
      end
    end
    object Page2: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo3: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO POR PROFISSIONAL E MODALIDADE DE RECEBIMENTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1526.400000000000000000
        Condition = 'frxResumo."RMO_NOMDIV"'
        object DMPMemo4: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'MODALIDADES')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'SEM IMPOSTO')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS'#195'O $')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'COMISS'#195'O %')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'PROFISSIONAL: [frxResumo."RMO_NOMDIV"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 170.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxResumo
        DataSetName = 'frxResumo'
        RowCount = 0
        object DMPMemo64: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxResumo."RMO_DESMOD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_COMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_SEMIMP"]')
          TruncOutboundText = False
        end
        object DMPMemo65: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumo."RMO_VALCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo66: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftRight]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TOTCOM' +
              '"> = 0,1,<frxResumo."RMO_TOTCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo34: TfrxDMPMemoView
          Left = 412.800000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          AllowExpressions = False
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'TOTAL DO PROFISSIONAL:')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_COMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_SEMIMP">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumo."RMO_VALCOM">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo67: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(((<frxResumo."RMO_VALCOM">) * 100) / IIF(<frxResumo."RMO_TO' +
              'TCOM"> = 0,1,<frxResumo."RMO_TOTCOM">))]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxUser: TfrxUserDataSet
    UserName = 'frxUser'
    OnCheckEOF = frxUserCheckEOF
    OnFirst = frxUserFirst
    OnNext = frxUserNext
    OnPrior = frxUserPrior
    Fields.Strings = (
      'DTAREC'
      'VALREC'
      'NOMREC'
      'NOMASS'
      'HISREC'
      'CIDREC'
      'NROVIA'
      'VLREXT')
    OnGetValue = frxUserGetValue
    Left = 384
    Top = 120
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    ProviderName = 'dspRelatorio'
    Left = 480
    Top = 152
  end
  object dspRelatorio: TUniDataSetProvider
    DataSet = frmModuloSPR.qryRelatorio
    Options = []
    Left = 448
    Top = 152
  end
  object frxResumo: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxResumo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 416
    Top = 152
  end
end
