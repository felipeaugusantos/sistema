inherited frmFatFormulacaoItens: TfrmFatFormulacaoItens
  Left = 135
  Top = 144
  Width = 1506
  Height = 600
  Caption = 'Formula'#231#227'o de Tinta de M'#225'quina'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1506
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 1500
    TabOrder = 6
    ExplicitTop = 427
    ExplicitWidth = 1500
    DesignSize = (
      1500
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1496
      ExplicitWidth = 1496
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1500
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 1500
    inherited pnlNomeForm: TPanel
      Left = 1329
      ExplicitLeft = 1329
    end
    inherited pnlInfo: TPanel
      Width = 1329
      ExplicitWidth = 1329
    end
  end
  inherited pgcDados: TPageControl
    Left = 2000
    Width = 1063
    Height = 325
    Align = alNone
    TabOrder = 5
    Visible = False
    ExplicitLeft = 2000
    ExplicitWidth = 1063
    ExplicitHeight = 325
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1055
      ExplicitHeight = 293
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1500
    Height = 427
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object dbgItens: TDBGridCitel
      Left = 1
      Top = 62
      Width = 1498
      Height = 364
      Align = alClient
      DataSource = dtsTinMaq
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgItensDrawColumnCell
      OnDblClick = dbgItensDblClick
      OnKeyDown = dbgItensKeyDown
      OnTitleClick = dbgItensTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'FDO_ENTRET'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          Title.Caption = 'Destino'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = 15
          Title.Font.Name = 'Arial'
          Title.Font.Pitch = fpVariable
          Title.Font.Style = []
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_NUMDOC'
          Title.Caption = 'Doc.'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_ESPDOC'
          Title.Caption = 'Esp.'
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FGO_DOCFAT'
          Title.Caption = 'Doc.Faturamento'
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_CODEMP'
          Title.Caption = 'Emp.'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_CODVEN'
          Title.Caption = 'Vend.'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DTAENT'
          Title.Caption = 'Data'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_HORENT'
          Title.Caption = 'Hora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_CODITE'
          Title.Caption = 'Item'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FIS_NUMCOO'
          Title.Caption = 'COO'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_IDEPRO'
          Title.Caption = 'Id. Tin.'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_DESCRI'
          Title.Caption = 'Descri'#231#227'o / Refer'#234'ncia'
          Width = 237
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNI_DESUNI'
          Title.Caption = 'Unidade'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'DET_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quantidade'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_TIPEMB'
          Title.Caption = 'Emb.'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DET_NOMCLI'
          Title.Caption = 'Cliente'
          Width = 223
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMLOT'
          Title.Caption = 'Lote'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ORDIMP'
          Title.Alignment = taCenter
          Title.Caption = 'OP'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIXAOP'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DESTINO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'SITFIN'
          Title.Caption = 'Sit.Financ.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AJUFOR'
          Title.Caption = 'AJ'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DTAULT'
          Title.Caption = #218'ltima Venda'
          Visible = False
        end>
    end
    object pnlCab: TPanel
      Left = 1
      Top = 1
      Width = 1498
      Height = 61
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Shape2: TShape
        Left = 644
        Top = 21
        Width = 12
        Height = 12
        Brush.Color = clBlue
        Pen.Color = clBlue
      end
      object Label2: TLabel
        Left = 660
        Top = 20
        Width = 125
        Height = 14
        Caption = 'Etiqueta Entrega impressa'
      end
      object Label3: TLabel
        Left = 660
        Top = 35
        Width = 92
        Height = 14
        Caption = 'Em processamento'
      end
      object Shape3: TShape
        Left = 644
        Top = 36
        Width = 12
        Height = 12
        Brush.Color = clRed
        Pen.Color = clRed
      end
      object lblSitFin: TLabel
        Left = 915
        Top = 28
        Width = 98
        Height = 14
        Caption = 'Situa'#231#227'o Financeira:'
      end
      object rdgTipTin: TRadioGroup
        Left = 11
        Top = 1
        Width = 268
        Height = 47
        Caption = 'Tipo de tinta de m'#225'quina'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Todas'
          'Imobili'#225'ria'
          'Automotiva'
          'Industrial')
        TabOrder = 0
        OnClick = rdgTipTinClick
      end
      object gpbPeriodo: TGroupBox
        Left = 423
        Top = 9
        Width = 216
        Height = 47
        Caption = 'Per'#237'odo de Entrada'
        TabOrder = 2
        object mskDtaIni: TMaskEditFocus
          Left = 5
          Top = 18
          Width = 67
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFin: TMaskEditFocus
          Left = 77
          Top = 18
          Width = 67
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object btnCarregBaixa: TBitBtnLocked
          Left = 147
          Top = 16
          Width = 63
          Height = 25
          Caption = 'Carregar'
          TabOrder = 2
          OnClick = btnCarregBaixaClick
        end
      end
      object btnDesmBaixa: TBitBtnLocked
        Left = 286
        Top = 23
        Width = 131
        Height = 25
        Caption = '[F4] Desmarcar Baixa OP'
        TabOrder = 1
        OnClick = btnDesmBaixaClick
      end
      object btnExportarRegistros: TBitBtnLocked
        Left = 811
        Top = 24
        Width = 98
        Height = 25
        Caption = 'Exportar Registros'
        TabOrder = 3
        OnClick = btnExportarRegistrosClick
      end
      object cmbSitFin: TcxImageComboBox
        Left = 1016
        Top = 24
        EditValue = False
        Properties.Images = imglSitFin
        Properties.Items = <
          item
            ImageIndex = 0
          end
          item
            ImageIndex = 1
            Value = True
          end
          item
            ImageIndex = 2
            Value = False
          end>
        TabOrder = 4
        OnClick = cmbSitFinClick
        Width = 40
      end
    end
  end
  object pnlBotoesFor: TPanel [4]
    Left = 0
    Top = 527
    Width = 1500
    Height = 28
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object btnImprimir: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 116
      Height = 26
      Align = alLeft
      Caption = '[F10] Etiqueta Entrega'
      TabOrder = 0
      OnClick = btnImprimirClick
    end
    object btnBaixar: TBitBtnLocked
      Left = 117
      Top = 1
      Width = 76
      Height = 26
      Align = alLeft
      Caption = '[ F9 ] Baixar'
      TabOrder = 1
      OnClick = btnBaixarClick
    end
    object btnAtualizar: TBitBtnLocked
      Left = 193
      Top = 1
      Width = 86
      Height = 26
      Align = alLeft
      Caption = '[F8] Atualizar'
      TabOrder = 2
      OnClick = btnAtualizarClick
    end
    object btnBaiTin: TBitBtnLocked
      Left = 279
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F7] Baixar por Tinta'
      TabOrder = 3
      OnClick = btnBaiTinClick
    end
    object btnImpOrd: TBitBtnLocked
      Left = 389
      Top = 1
      Width = 130
      Height = 26
      Align = alLeft
      Caption = '[F6] Ordem de Produ'#231#227'o'
      TabOrder = 4
      OnClick = btnImpOrdClick
    end
    object btnAltTipTin: TBitBtnLocked
      Left = 519
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F3] Mudar Tipo Tinta'
      TabOrder = 5
      OnClick = btnAltTipTinClick
    end
    object btnApagar: TBitBtnLocked
      Left = 739
      Top = 1
      Width = 93
      Height = 26
      Align = alLeft
      Caption = '[DEL] Apagar'
      TabOrder = 6
      OnClick = btnApagarClick
    end
    object btnCancelarForm: TBitBtnLocked
      Left = 1389
      Top = 1
      Width = 110
      Height = 26
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = '[Esc] Cancelar'
      TabOrder = 10
      OnClick = btnCancelarFormClick
    end
    object btnImpAjuste: TBitBtnLocked
      Left = 1052
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F12] Imp. Ajuste'
      TabOrder = 9
      Visible = False
      OnClick = btnImpAjusteClick
    end
    object btnImpSep: TBitBtnLocked
      Left = 629
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F5] Imp. Separa'#231#227'o'
      TabOrder = 11
      Visible = False
      OnClick = btnImpSepClick
    end
    object btnImpEtiqProd: TBitBtnLocked
      Left = 832
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F2] Etiq. Prod.'
      TabOrder = 7
      OnClick = btnImpEtiqProdClick
    end
    object btnRealizarAjuste: TBitBtnLocked
      Left = 942
      Top = 1
      Width = 110
      Height = 26
      Align = alLeft
      Caption = '[F11] Realizar Ajuste'
      TabOrder = 8
      Visible = False
      OnClick = btnRealizarAjusteClick
    end
    object btnPesquisar: TBitBtnLocked
      Left = 1162
      Top = 1
      Width = 103
      Height = 26
      Align = alLeft
      Caption = '[ Alt + P ] &Pesquisar'
      TabOrder = 12
      OnClick = btnPesquisarClick
    end
  end
  object pgbProgresso: TProgressBar [5]
    Left = 0
    Top = 427
    Width = 1500
    Height = 10
    Align = alBottom
    TabOrder = 1
  end
  object memMenFor: TMemoFocus [6]
    Left = 0
    Top = 437
    Width = 1500
    Height = 49
    Align = alBottom
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  object pnlObsColorista: TPanel [7]
    Left = 0
    Top = 486
    Width = 1500
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    BevelKind = bkFlat
    TabOrder = 7
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 148
      Height = 14
      Caption = 'Observa'#231#227'o para Colorista:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtObsColorista: TEdit
      Left = 159
      Top = 10
      Width = 602
      Height = 21
      CharCase = ecUpperCase
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object rdgTipoFormula: TRadioGroup
      Left = 778
      Top = 1
      Width = 279
      Height = 33
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'F'#243'rmula Original'
        'F'#243'rmula Ajustada')
      TabOrder = 1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 188
    Top = 192
  end
  object dtsTinMaq: TDataSource
    Left = 560
    Top = 328
  end
  object frxEtiqueta: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39520.636765671300000000
    ReportOptions.LastChange = 39526.710568611100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 376
    Top = 192
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 92.000000000000000000
      PaperHeight = 72.000000000000000000
      PaperSize = 256
      BottomMargin = 5.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.Width = 5.000000000000000000
      object rllNomEmp: TfrxMemoView
        Left = 81.000000000000000000
        Top = 13.000000000000000000
        Width = 260.488250000000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          '[NOMEMP]')
        ParentFont = False
        WordWrap = False
      end
      object rllNumDoc: TfrxMemoView
        Left = 184.000000000000000000
        Top = 43.000000000000000000
        Width = 157.488250000000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          '[NUMDOC]')
        ParentFont = False
        WordWrap = False
      end
      object rllNomVen: TfrxMemoView
        Left = 81.000000000000000000
        Top = 66.000000000000000000
        Width = 260.488250000000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          '[NOMVEN]')
        ParentFont = False
        WordWrap = False
      end
      object rllDesTin: TfrxMemoView
        Left = 7.000000000000000000
        Top = 91.000000000000000000
        Width = 334.488250000000000000
        Height = 40.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic, fsUnderline]
        Memo.UTF8W = (
          '[DESTIN]')
        ParentFont = False
      end
      object rllDadCli: TfrxMemoView
        Left = 7.000000000000000000
        Top = 140.000000000000000000
        Width = 334.488188980000000000
        Height = 26.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8W = (
          '[NOMCLI]')
        ParentFont = False
        WordWrap = False
      end
      object rllDtaEmi: TfrxMemoView
        Left = 7.000000000000000000
        Top = 225.000000000000000000
        Width = 158.488250000000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          '[DTAEMI]')
        ParentFont = False
        WordWrap = False
      end
      object rllDtaVal: TfrxMemoView
        Left = 178.000000000000000000
        Top = 225.000000000000000000
        Width = 163.488250000000000000
        Height = 18.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haRight
        Memo.UTF8W = (
          '[DTAVAL]')
        ParentFont = False
        WordWrap = False
      end
      object imgLogo: TfrxPictureView
        Left = 7.000000000000000000
        Top = 13.000000000000000000
        Width = 70.488250000000000000
        Height = 71.897650000000000000
        HightQuality = False
        Transparent = False
        TransparentColor = clWhite
      end
      object Memo1: TfrxMemoView
        Left = 7.000000000000000000
        Top = 163.000000000000000000
        Width = 334.488188980000000000
        Height = 26.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8W = (
          '[ENDENT]')
        ParentFont = False
        WordWrap = False
      end
      object Memo2: TfrxMemoView
        Left = 7.000000000000000000
        Top = 187.000000000000000000
        Width = 334.488188980000000000
        Height = 19.897650000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Memo.UTF8W = (
          '[CIDENT]')
        ParentFont = False
        WordWrap = False
      end
    end
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 312
    Top = 192
  end
  object tmrTmpOci: TTimer
    Enabled = False
    OnTimer = tmrTmpOciTimer
    Left = 496
    Top = 328
  end
  object tmrAtuFti: TTimer
    Enabled = False
    OnTimer = tmrAtuFtiTimer
    Left = 432
    Top = 328
  end
  object imglSitFin: TImageList
    Left = 772
    Top = 136
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFEFF7FFFF0000
      FFFFC7E3C1FF0000FFFF83C1C0FF0000FFFFC183C07F0000FFFFE007803F0000
      FFFFF00F801F0000FFFFF81F800F0000FFFFF81F04070000FFFFF00F06030000
      FFFFE0078F000000FFFFC183FFC00000FFFF83C1FFE00000FFFFC7E3FFF10000
      FFFFEFF7FFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
