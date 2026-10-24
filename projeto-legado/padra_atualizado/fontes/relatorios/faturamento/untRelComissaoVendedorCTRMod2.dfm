inherited frmRelComissaoVendedorCTRMod2: TfrmRelComissaoVendedorCTRMod2
  Left = 474
  Top = 129
  Width = 394
  Height = 668
  Caption = 'Relat'#243'rio de Comiss'#227'o por Vendedor - Contas a Receber'
  OnDestroy = FormDestroy
  ExplicitWidth = 394
  ExplicitHeight = 668
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 597
    Width = 388
    TabOrder = 6
    ExplicitTop = 597
    ExplicitWidth = 388
    inherited FlwBotoes: TFlowPanel
      Width = 307
      ExplicitWidth = 307
    end
    inherited btnSair: TBitBtnLocked
      Left = 309
      ExplicitLeft = 309
    end
  end
  inherited pnlDados: TPanel
    Top = 409
    Width = 388
    Height = 116
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 409
    ExplicitWidth = 388
    ExplicitHeight = 116
    object shpDocCom: TShape [0]
      Left = 2
      Top = 102
      Width = 5
      Height = 12
    end
    object rdgTipRel: TRadioGroup [1]
      Left = 8
      Top = 0
      Width = 225
      Height = 45
      Caption = 'Tipo de Relat'#243'rio'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Anal'#237'tico'
        'Sint'#233'tico')
      TabOrder = 0
      OnClick = rdgTipRelClick
    end
    inherited gpbDestino: TGroupBox
      Left = 238
      Top = 0
      TabOrder = 1
      ExplicitLeft = 238
      ExplicitTop = 0
    end
    object rdgPosCom: TRadioGroup
      Left = 8
      Top = 46
      Width = 368
      Height = 35
      Caption = 'Posi'#231#227'o da Comiss'#227'o'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todas'
        'Pendentes'
        'Baixadas')
      TabOrder = 2
    end
    object chkConJur: TCheckBox
      Left = 8
      Top = 84
      Width = 343
      Height = 15
      Caption = 'Considerar juros cobrado para c'#225'lculo da comiss'#227'o?'
      Checked = True
      State = cbChecked
      TabOrder = 3
      WordWrap = True
    end
    object chkDocCom: TCheckBox
      Left = 8
      Top = 101
      Width = 368
      Height = 15
      Caption = 'Exibir somente documentos com valor de comiss'#227'o'
      TabOrder = 4
      WordWrap = True
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 388
    Height = 127
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
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
    object Label2: TLabel
      Left = 81
      Top = 4
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
    object Label3: TLabel
      Left = 8
      Top = 42
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
    object Label4: TLabel
      Left = 177
      Top = 4
      Width = 66
      Height = 14
      Caption = 'Data do Corte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 70
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
      Left = 81
      Top = 19
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
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 56
      Width = 55
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
      TabOrder = 3
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
      Left = 66
      Top = 56
      Width = 310
      Height = 22
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
    object rdgRelEmp: TRadioGroup
      Left = 8
      Top = 81
      Width = 368
      Height = 44
      Caption = 'Relacionar a Empresa  com:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Movimenta'#231#227'o'
        'Vendedor')
      TabOrder = 5
    end
    object mskDtaCor: TMaskEditFocus
      Tag = 99
      Left = 177
      Top = 19
      Width = 72
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  object pnlServico: TPanel [4]
    Left = 0
    Top = 127
    Width = 388
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object rdgServicos: TRadioGroup
      Left = 8
      Top = -1
      Width = 368
      Height = 72
      Caption = 'Notas de Servi'#231'os'
      ItemIndex = 2
      Items.Strings = (
        'Somente Notas de Servi'#231'o'
        'Exceto Notas de Servi'#231'o'
        'Todas as Notas Fiscais')
      TabOrder = 0
    end
  end
  object pnlGerCom: TPanel [5]
    Left = 0
    Top = 275
    Width = 388
    Height = 132
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object gpbGravaComi: TGroupBox
      Left = 8
      Top = 2
      Width = 368
      Height = 127
      Caption = 'Gravar Contas a Pagar'
      TabOrder = 0
      object TLabel
        Left = 7
        Top = 84
        Width = 81
        Height = 14
        Caption = 'Data Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object chkGraCom: TCheckBox
        Left = 7
        Top = 17
        Width = 264
        Height = 17
        Caption = 'Gravar contas a pagar referente a comiss'#227'o'
        TabOrder = 0
        OnClick = chkGraComClick
      end
      object mskDtaVen: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 99
        Width = 70
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
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 4
        Top = 37
        Width = 360
        Height = 42
        TabOrder = 1
        ExplicitLeft = 4
        ExplicitTop = 37
        ExplicitWidth = 360
        ExplicitHeight = 42
        inherited lblPlaContas: TLabel
          Left = 4
          Top = 1
          Width = 81
          Height = 14
          ExplicitLeft = 4
          ExplicitTop = 1
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 62
          Top = 18
          Width = 297
          Height = 22
          ExplicitLeft = 62
          ExplicitTop = 18
          ExplicitWidth = 297
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 3
          Top = 18
          Width = 57
          Height = 22
          Enabled = False
          ExplicitLeft = 3
          ExplicitTop = 18
          ExplicitWidth = 57
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlVendedor: TPanel [6]
    Left = 0
    Top = 198
    Width = 388
    Height = 77
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblTitVen: TLabel
      Left = 16
      Top = 39
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpVen: TShape
      Left = 9
      Top = 54
      Width = 5
      Height = 22
    end
    object lblOpcVen: TLabel
      Left = 8
      Top = 2
      Width = 97
      Height = 14
      Caption = 'Op'#231#227'o de Vendedor'
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 16
      Top = 54
      Width = 49
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 67
      Top = 54
      Width = 309
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxVenRep: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 16
      Width = 371
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemIndex = 0
      TabOrder = 0
      Text = '1- Vendedor'
      OnChange = cbxVenRepChange
      Items.Strings = (
        '1- Vendedor'
        '2- Representante')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 623
    Width = 388
    TabOrder = 7
    ExplicitTop = 623
    ExplicitWidth = 388
    inherited pnlNomeForm: TPanel
      Left = 217
      TabOrder = 1
      ExplicitLeft = 217
    end
    inherited pnlInfo: TPanel
      Width = 217
      TabOrder = 0
      ExplicitWidth = 217
      inherited shpMultSel: TShape
        Left = 200
        ExplicitLeft = 200
      end
    end
  end
  object pnlPDF: TPanel [8]
    Left = 0
    Top = 525
    Width = 388
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object chkEjeVen: TCheckBox
      Tag = 99
      Left = 8
      Top = 1
      Width = 226
      Height = 17
      Caption = 'Ejetar p'#225'gina a cada quebra de vendedor?'
      Enabled = False
      TabOrder = 0
    end
    object chkPDFVen: TCheckBox
      Tag = 99
      Left = 8
      Top = 18
      Width = 181
      Height = 17
      Caption = 'Gerar PDF para cada Vendedor?'
      Enabled = False
      TabOrder = 1
      OnClick = chkPDFVenClick
    end
    inline fraDirPDF: TfraDirectoryEditFocus
      Left = 8
      Top = 37
      Width = 368
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      ExplicitLeft = 8
      ExplicitTop = 37
      ExplicitWidth = 368
      ExplicitHeight = 24
      inherited edtDirectory: TEditFocus
        Width = 343
        Height = 22
        ExplicitWidth = 343
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 345
        Height = 24
        ExplicitLeft = 345
        ExplicitHeight = 24
      end
    end
  end
  object prbProgresso: TProgressBar [9]
    Left = 0
    Top = 591
    Width = 388
    Height = 6
    Align = alBottom
    Smooth = True
    TabOrder = 9
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 416
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 480
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 448
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 416
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 576
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 544
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 480
  end
  inherited frxGen: TfrxUserDataSet
    Left = 512
  end
  inherited frxDesigner: TfrxDesigner
    Left = 544
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 576
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 48
  end
  object frxComissaoVendedorCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41401.418783993050000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure mmoTitRelOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure mmoVendedorOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 176
    Top = 72
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
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 386.079750656827700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object RTComissao: TfrxReportTitle
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1459.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
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
          Left = 1305.600000000000000000
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
        object Time: TfrxDMPMemoView
          Left = 1363.200000000000000000
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
          Left = 1180.800000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
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
          Command = '#27#64#18#27#80#15#27#77'
        end
        object frxCabecalhoPERIODO: TfrxDMPMemoView
          Align = baCenter
          Left = 528.000000000000000000
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
        object frxCabecalhoVENDEDOR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          TruncOutboundText = False
        end
        object frxCabecalhoEMPRESA: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 720.000000000000000000
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
          Left = 480.000000000000000000
          Top = 34.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE COMISSAO POR VENDEDOR - CONTAS A RECEBER')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1449.600000000000000000
          Color = clBlack
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."JUROS"]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 102.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[DOCCOM]')
          TruncOutboundText = False
        end
      end
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1459.200000000000000000
        Condition = 'frxRelatorio."VENDEDOR"'
        ReprintOnNewPage = True
        object mmoVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoVendedorOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR : ')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 115.200000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1449.600000000000000000
          Color = clBlack
        end
      end
      object CComissao: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1459.200000000000000000
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA REC')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLICATA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DUPLIC.ORIGINAL')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ORI C/IMP')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.JUROS')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DESC.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.REC P/COM')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COM.')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA CAD')
          TruncOutboundText = False
        end
      end
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1459.200000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALREC"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 931.200000000000000000
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
          Left = 1036.800000000000000000
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
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_RECCOM"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_COMISSAO"]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0,(<frxRelatorio."VALOR_COMI' +
              'SSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTACAD"]')
          TruncOutboundText = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1459.200000000000000000
        object Memo1: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 931.200000000000000000
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
          Left = 1036.800000000000000000
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
        object DMPMemo24: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 633.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Total Vendedor : ')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1449.600000000000000000
          Color = clBlack
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]'
            '')
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1459.200000000000000000
        object DMPMemo27: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 931.200000000000000000
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
          Left = 1036.800000000000000000
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
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECCOM">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 105.600000000000000000
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
          Left = 633.600000000000000000
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
          Top = 25.500000000000000000
          Width = 1449.600000000000000000
          Color = clBlack
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]'
            '')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 510.000000000000000000
        Width = 1459.200000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Desenvolvido por Citel Software')
          TruncOutboundText = False
        end
      end
      object GHSetor: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1459.200000000000000000
        Child = frxComissaoVendedorCTR_M.CComissao
        Condition = 'frxRelatorio."NSETOR"'
        object DMPMemo34: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SETOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GFSetor: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.000000000000000000
        Width = 1459.200000000000000000
        object DMPMemo35: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 931.200000000000000000
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
        object DMPMemo37: TfrxDMPMemoView
          Left = 1036.800000000000000000
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
        object DMPMemo43: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Total : ')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxCabecalho: TfrxUserDataSet
    UserName = 'frxCabecalho'
    Fields.Strings = (
      'EMPRESA'
      'VENDEDOR'
      'PERIODO'
      'intVenDig')
    OnGetValue = frxCabecalhoGetValue
    Left = 240
    Top = 72
  end
  object frxComissaoVendedorCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41401.458226088000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure mmoTitRelOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 208
    Top = 72
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
      LeftMargin = 4.000000000000000000
      RightMargin = 4.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object GHComissao: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 241.889920000000000000
        Width = 839.055660000000000000
        Condition = 'frxRelatorio."VENDEDOR"'
        object Memo35: TfrxMemoView
          Left = 7.655040000000000000
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
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
          WordWrap = False
        end
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
        Top = 325.039580000000000000
        Width = 839.055660000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Align = baClient
          Width = 839.055660000000000000
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
          Left = 1.456692910000000000
          Top = 2.169295000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
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
          Left = 102.039370080000000000
          Top = 2.169295000000000000
          Width = 124.724404570000000000
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
          Left = 230.826813150000000000
          Top = 2.169295000000000000
          Width = 124.724404570000000000
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
          Left = 359.511884250000000000
          Top = 2.169295000000000000
          Width = 108.850381500000000000
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
          Left = 470.803210630000000000
          Top = 2.169295000000000000
          Width = 75.590551180000000000
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
        object Memo19: TfrxMemoView
          Left = 545.700858190000000000
          Top = 2.169295000000000000
          Width = 43.464566930000000000
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
          Left = 590.393771570000000000
          Top = 2.169295000000000000
          Width = 54.803149610000000000
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
          Left = 645.433144090000000000
          Top = 2.169295000000000000
          Width = 83.149606300000000000
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
            '[frxRelatorio."CTR_RECCOM"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 768.685102830000000000
          Top = 2.169295000000000000
          Width = 64.251968500000000000
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
        object Memo37: TfrxMemoView
          Left = 728.645671730000000000
          Top = 2.169295000000000000
          Width = 39.307086610000000000
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
            
              '[IIF(<frxRelatorio."CTR_RECCOM"> <> 0,(<frxRelatorio."VALOR_COMI' +
              'SSAO"> / <frxRelatorio."CTR_RECCOM">) * 100, 0)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 51.252010000000000000
          Top = 2.169295000000000000
          Width = 46.866141730000000000
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
            '[frxRelatorio."CTR_DTACAD"]')
          ParentFont = False
        end
      end
      object GFComissao: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 408.189240000000000000
        Width = 839.055660000000000000
        object Memo22: TfrxMemoView
          Left = 545.700858190000000000
          Top = 1.000000000000000000
          Width = 43.464566930000000000
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
          Left = 590.393771570000000000
          Top = 1.000000000000000000
          Width = 54.803149610000000000
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
        object Memo24: TfrxMemoView
          Left = 644.409495200000000000
          Top = 1.000000000000000000
          Width = 83.149606300000000000
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
            '[SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 768.755951890000000000
          Top = 1.000000000000000000
          Width = 64.251968500000000000
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
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 762.330713540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo34: TfrxMemoView
          Left = 470.803210630000000000
          Top = 1.000000000000000000
          Width = 75.590551180000000000
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
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 379.055350000000000000
          Top = 0.996061770000000000
          Width = 90.708720000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Vendedor : ')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 728.645671730000000000
          Top = 1.000000000000000000
          Width = 39.307089060000000000
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
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 487.559370000000000000
        Width = 839.055660000000000000
        object Memo27: TfrxMemoView
          Left = 470.992140630000000000
          Top = 1.000000000000000000
          Width = 75.590551180000000000
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
        object Memo28: TfrxMemoView
          Left = 545.889788190000000000
          Top = 1.000000000000000000
          Width = 43.464566930000000000
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
          Left = 590.582701570000000000
          Top = 1.000000000000000000
          Width = 54.803149610000000000
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
          Left = 644.598425200000000000
          Top = 1.000000000000000000
          Width = 83.149606300000000000
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
            '[SUM(<frxRelatorio."CTR_RECCOM">,0,0)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 768.944898980000000000
          Top = 1.000000000000000000
          Width = 64.251973390000000000
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
          Left = 379.244338580000000000
          Top = 1.000000000000000000
          Width = 90.708661420000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral        : ')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 0.755905510000000000
          Top = 18.500000000000000000
          Width = 834.141783540000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 0.338590000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 834.756340000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo39: TfrxMemoView
          Left = 728.834601730000000000
          Top = 1.000000000000000000
          Width = 39.307089060000000000
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
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,0,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,0,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,0,0)) * 100, 0)]')
          ParentFont = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 529.134200000000000000
        Width = 839.055660000000000000
        object Memo1: TfrxMemoView
          Left = 467.717810000000000000
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
          Width = 468.661720000000000000
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
        Top = 200.315090000000000000
        Width = 839.055660000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 839.055660000000000000
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
        object Memo4: TfrxMemoView
          Left = 1.456692910000000000
          Top = 2.000000000000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT. REC')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 102.039370080000000000
          Top = 2.000000000000000000
          Width = 124.724404570000000000
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
        object Memo7: TfrxMemoView
          Left = 230.826813150000000000
          Top = 2.000000000000000000
          Width = 124.724404570000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DUP. ORIG.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 359.511884250000000000
          Top = 2.000000000000000000
          Width = 108.774830000000000000
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
        object Memo9: TfrxMemoView
          Left = 470.803210630000000000
          Top = 2.000000000000000000
          Width = 75.590558500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ORI C/IMP')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 545.700858190000000000
          Top = 2.000000000000000000
          Width = 43.464566930000000000
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
        object Memo11: TfrxMemoView
          Left = 590.393771570000000000
          Top = 2.000000000000000000
          Width = 54.803149610000000000
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
        object Memo12: TfrxMemoView
          Left = 645.433144090000000000
          Top = 2.000000000000000000
          Width = 83.149618500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR.REC P/COM')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 768.685102830000000000
          Top = 2.000000000000000000
          Width = 64.251973390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.COM.')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 728.645671730000000000
          Top = 2.000000000000000000
          Width = 39.307086610000000000
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
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 51.252010000000000000
          Top = 1.889763780000000000
          Width = 46.866141730000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DT.CAD.')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 18.897650000000000000
        Width = 839.055660000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 204.813050000000000000
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
          Left = 610.717810000000000000
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
          Left = 702.333580000000000000
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
          Left = 566.270810000000000000
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
          Left = 291.288560000000000000
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
        object frxCabecalhoVENDEDOR: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 373.643970000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 384.662030000000000000
          Top = 78.338590000000000000
          Width = 369.864440000000000000
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
          Left = 219.893260000000000000
          Top = 36.897650000000000000
          Width = 399.269140000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR VENDEDOR - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 117.267780000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo44: TfrxMemoView
          Left = 7.559060000000000000
          Top = 98.267780000000000000
          Width = 298.053370000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."JUROS"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 309.921460000000000000
          Top = 98.047310000000000000
          Width = 445.455040000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DOCCOM]')
          ParentFont = False
        end
      end
      object GHSetor: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 283.464750000000000000
        Width = 839.055660000000000000
        Condition = 'frxRelatorio."NSETOR"'
        object Memo45: TfrxMemoView
          Left = 7.655040000000000000
          Top = 2.779530000000000000
          Width = 518.400000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."SETOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GFSetor: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 366.614410000000000000
        Width = 839.055660000000000000
        object Memo40: TfrxMemoView
          Left = 545.700858190000000000
          Top = 1.000000000000000000
          Width = 43.464566930000000000
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
        object Memo41: TfrxMemoView
          Left = 590.393771570000000000
          Top = 1.000000000000000000
          Width = 54.803149610000000000
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
        object Memo42: TfrxMemoView
          Left = 645.433144090000000000
          Top = 1.000000000000000000
          Width = 83.149606300000000000
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
            '[SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 768.685102830000000000
          Top = 1.000000000000000000
          Width = 64.251968500000000000
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
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 470.803210630000000000
          Top = 1.000000000000000000
          Width = 75.590551180000000000
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
            '[SUM(<frxRelatorio."CTR_VALREC">,MDComissao,0)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 428.189240000000000000
          Top = 1.051175000000000000
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total  : ')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 728.645671730000000000
          Top = 1.000000000000000000
          Width = 39.307089060000000000
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
            '[IIF(SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0) <> 0, '
            '     (SUM(<frxRelatorio."VALOR_COMISSAO">,MDComissao,0) /'
            '      SUM(<frxRelatorio."CTR_RECCOM">,MDComissao,0)) * 100, 0)]')
          ParentFont = False
        end
      end
    end
  end
  object frxComissaoVendedorSintCTR_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 41402.543906782400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxComissaoVendedorSintCTR_MUserFunction
    Left = 176
    Top = 104
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
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PComissao: TfrxDMPPage
      PaperWidth = 386.079750656827700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object RTComissao: TfrxReportTitle
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1459.200000011990000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
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
          Left = 1305.600000000000000000
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
          Left = 1363.200000000000000000
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
          Left = 1209.600000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
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
          Command = '#27#64#18#27#80#15#27#77'
        end
        object frxCabecalhoPERIODO: TfrxDMPMemoView
          Align = baCenter
          Left = 528.000000000000000000
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
        object frxCabecalhoVENDEDOR: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          TruncOutboundText = False
        end
        object frxCabecalhoEMPRESA: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 85.000000000000000000
          Width = 748.800000000000000000
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
          Left = 480.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE COMISSAO POR VENDEDOR - CONTAS A RECEBER ')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1440.000000000000000000
          Color = clBlack
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Memo.UTF8W = (
            '[frxCabecalho."JUROS"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          HAlign = haRight
          Memo.UTF8W = (
            '[DOCCOM]')
          TruncOutboundText = False
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 289.000000000000000000
        Width = 1459.200000011990000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fPercent(SUM(<frxRelatorio."VALOR_COMISSAO">, MasterData1),'
            '          SUM(<frxRelatorio."CTR_RECCOM">, MasterData1))]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Total Geral: ')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1440.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1440.000000000000000000
          Color = clBlack
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
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
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
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
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
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
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCarChq'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALCHQ">,MasterData1)]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCarChq'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALCAR">,MasterData1)]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,MasterData1)]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCarChq'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECCOM">, MasterData1)]')
          TruncOutboundText = False
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1459.200000011990000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 1152.000000000000000000
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
        Width = 1459.200000011990000000
        ReprintOnNewPage = True
        object DMPMemo12: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC. c/Imp.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.COMISSAO')
          TruncOutboundText = False
        end
        object mmoVendedor: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TITVEN]'
            '')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1440.000000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.A VISTA')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC.A PRAZO')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.CARTAO')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '%COMI.')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC. P/COMI.')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1459.200000011990000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo5: TfrxDMPMemoView
          Left = 518.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTR_VALREC">]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."VALOR_COMISSAO">]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 115.200000000000000000
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
          Left = 768.000000000000000000
          Width = 115.200000000000000000
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
          Left = 268.800000000000000000
          Width = 115.200000000000000000
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
          Left = 393.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          TruncOutboundText = False
        end
        object frxCarChqVALCHQ: TfrxDMPMemoView
          Left = 892.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCarChq'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCHQ"]')
          TruncOutboundText = False
        end
        object frxCarChqVALCAR: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCarChq'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCAR"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercent(<frxRelatorio."VALOR_COMISSAO">, <frxRelatorio."CTR_RE' +
              'CCOM">)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTR_RECCOM">]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxComissaoVendedorSintCTR_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39609.601045879600000000
    ReportOptions.LastChange = 39657.621942314800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxComissaoVendedorSintCTR_MUserFunction
    Left = 208
    Top = 104
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
      LeftMargin = 4.000000000000000000
      RightMargin = 4.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MDComissao: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 245.669450000000000000
        Width = 763.465060000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllFundoDetalhe: TfrxMemoView
          Top = 1.220470000000000000
          Width = 763.465060000000000000
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
          Left = 264.787401570000000000
          Top = 1.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTR_VALREC">]')
        end
        object Memo36: TfrxMemoView
          Left = 704.905743700000000000
          Top = 1.000000000000000000
          Width = 54.803149610000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."VALOR_COMISSAO">]')
        end
        object Memo3: TfrxMemoView
          Left = 1.779530000000000000
          Top = 1.133858270000000000
          Width = 129.259840080000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 330.818790240000000000
          Top = 1.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_AVISTA"]')
        end
        object Memo7: TfrxMemoView
          Left = 396.850286300000000000
          Top = 1.000000000000000000
          Width = 68.031496060000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_APRAZO"]')
        end
        object frxGenfltValFat: TfrxMemoView
          Left = 132.724409450000000000
          Top = 1.000000000000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALFAT"]')
        end
        object frxCabecalhofltTotAbe: TfrxMemoView
          Left = 198.755905510000000000
          Top = 1.133858270000000000
          Width = 64.251968500000000000
          Height = 13.228346460000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ABERTO"]')
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 532.464454650000000000
          Top = 1.000000000000000000
          Width = 62.362204724409450000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCAR"]')
        end
        object Memo17: TfrxMemoView
          Left = 467.149606299212600000
          Top = 1.000000000000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALCHQ"]')
        end
        object Memo24: TfrxMemoView
          Left = 663.307086614173200000
          Top = 1.000000000000000000
          Width = 39.685039370000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fPercent(<frxRelatorio."VALOR_COMISSAO">,<frxRelatorio."CTR_REC' +
              'COM">)]')
        end
        object Memo26: TfrxMemoView
          Left = 597.165354330000000000
          Top = 1.133858270000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CTR_RECCOM">]')
        end
      end
      object RSComissao: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 56.677180000000000000
        ParentFont = False
        Top = 325.039580000000000000
        Width = 763.465060000000000000
        object Shape1: TfrxShapeView
          Align = baWidth
          Top = 0.220469999999977500
          Width = 763.465060000000000000
          Height = 18.897650000000000000
        end
        object Memo30: TfrxMemoView
          Left = 264.834645670000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALREC">,0,0)]')
        end
        object Memo31: TfrxMemoView
          Left = 704.882087480000000000
          Top = 1.889763780000000000
          Width = 54.803149610000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_COMISSAO">,0,0)]')
        end
        object Memo32: TfrxMemoView
          Left = 42.220160000000000000
          Top = 2.000000000000000000
          Width = 72.491280000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Total Geral : ')
        end
        object Memo8: TfrxMemoView
          Left = 330.976377950000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_AVISTA">,0,0)]')
        end
        object Memo14: TfrxMemoView
          Left = 396.740157480000000000
          Top = 1.889763780000000000
          Width = 68.031496060000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_APRAZO">,0,0)]')
        end
        object Memo16: TfrxMemoView
          Left = 132.551181100000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALFAT">,0,0)]')
        end
        object Memo10: TfrxMemoView
          Left = 198.692913390000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_ABERTO">,0,0)]')
        end
        object Memo20: TfrxMemoView
          Left = 467.149606299212600000
          Top = 1.889763780000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALCHQ">,0,0)]')
        end
        object Memo22: TfrxMemoView
          Left = 532.535433070000000000
          Top = 1.889763780000000000
          Width = 62.362204724409450000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALCAR">,0,0)]')
        end
        object Memo25: TfrxMemoView
          Left = 663.307086614173200000
          Top = 1.889763780000000000
          Width = 39.685039370000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fPercent(SUM(<frxRelatorio."VALOR_COMISSAO">, MDComissao),'
            '          SUM(<frxRelatorio."CTR_RECCOM">, MDComissao))]'
            ''
            '')
        end
        object Memo28: TfrxMemoView
          Left = 597.165354330000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_RECCOM">, MDComissao)]')
        end
      end
      object PFComissao: TfrxPageFooter
        FillType = ftBrush
        Height = 24.559060000000000000
        Top = 404.409710000000000000
        Width = 763.465060000000000000
        object Memo1: TfrxMemoView
          Left = 467.717810000000000000
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
          Width = 468.661720000000000000
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 18.897650000000000000
        ParentFont = False
        Top = 204.094620000000000000
        Width = 763.465060000000000000
        ReprintOnNewPage = True
        object Memo2: TfrxMemoView
          Width = 763.465060000000000000
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
        object mmoVendedor: TfrxMemoView
          Left = 1.494310000000000000
          Top = 2.000000000000000000
          Width = 101.215770000000000000
          Height = 13.220470000000000000
          Memo.UTF8W = (
            '[TITVEN]')
        end
        object Memo12: TfrxMemoView
          Left = 264.787401570000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'REC. c/Imp')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 704.905743700000000000
          Top = 2.000000000000000000
          Width = 54.803149610000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VAL.COM')
          WordWrap = False
        end
        object Memo4: TfrxMemoView
          Left = 330.818790240000000000
          Top = 2.000000000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.VISTA')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 396.850286300000000000
          Top = 2.000000000000000000
          Width = 68.031496060000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            ' REC.PRAZO')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 132.724409450000000000
          Top = 1.779530000000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'FATURADO')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 198.755905510000000000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PENDENTE')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 467.149606299212600000
          Top = 2.000000000000000000
          Width = 62.362204720000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE')
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 532.464454650000000000
          Top = 2.000000000000000000
          Width = 62.362204724409450000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CARTAO')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 663.307086614173200000
          Top = 2.779530000000000000
          Width = 39.685039370000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '%COM')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 597.165354330708700000
          Top = 1.889763780000000000
          Width = 64.251968500000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'REC.p/COM')
          WordWrap = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 763.465060000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 167.017750000000000000
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
          Left = 610.717810000000000000
          Top = 37.795300000000000000
          Width = 144.000000000000000000
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
          Left = 702.333580000000000000
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
          Left = 566.270810000000000000
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
          Left = 253.493260000000000000
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
        object frxCabecalhoVENDEDOR: TfrxMemoView
          Left = 7.559060000000000000
          Top = 78.440940000000000000
          Width = 369.864440000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."VENDEDOR"]')
          ParentFont = False
        end
        object frxCabecalhoEMPRESA: TfrxMemoView
          Left = 380.882500000000000000
          Top = 78.338590000000000000
          Width = 373.643970000000000000
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
          Left = 182.097960000000000000
          Top = 36.897650000000000000
          Width = 399.269140000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE COMISS'#195'O POR VENDEDOR - CONTAS A RECEBER')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.779530000000000000
          Top = 119.267780000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo29: TfrxMemoView
          Left = 7.559060000000000000
          Top = 98.267780000000000000
          Width = 226.242300000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCabecalho."JUROS"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 238.110390000000000000
          Top = 98.267780000000000000
          Width = 517.266110000000000000
          Height = 17.000000000000000000
          DataSet = frxCabecalho
          DataSetName = 'frxCabecalho'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DOCCOM]')
          ParentFont = False
        end
      end
    end
  end
end
