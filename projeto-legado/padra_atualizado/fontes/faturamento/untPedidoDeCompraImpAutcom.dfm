inherited frmPedidoDeCompraImpAutcom: TfrmPedidoDeCompraImpAutcom
  Width = 817
  Height = 597
  Caption = 'Importa'#231#227'o de Pedido de Compra - Autcom'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 817
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 344
    Width = 811
    ExplicitTop = 344
    ExplicitWidth = 811
    inherited FlwBotoes: TFlowPanel
      Width = 807
      ExplicitWidth = 807
    end
  end
  inherited pnlStatus: TPanel
    Top = 552
    Width = 811
    ExplicitTop = 552
    ExplicitWidth = 811
    inherited pnlNomeForm: TPanel
      Left = 640
      ExplicitLeft = 640
    end
    inherited pnlInfo: TPanel
      Width = 640
      ExplicitWidth = 640
    end
  end
  inherited pgcDados: TPageControl
    Left = -10
    Top = -10
    Width = 17
    Height = 9
    Align = alNone
    Visible = False
    ExplicitLeft = -10
    ExplicitTop = -10
    ExplicitWidth = 17
    ExplicitHeight = 9
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 9
      ExplicitHeight = 428
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 811
    Height = 158
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object grbArquivo: TGroupBox
      Left = 1
      Top = 1
      Width = 660
      Height = 156
      Align = alClient
      TabOrder = 0
      DesignSize = (
        660
        156)
      object Label1: TLabel
        Left = 12
        Top = 14
        Width = 41
        Height = 14
        Hint = '999'
        Caption = 'Arquivo:'
      end
      object gauProgresso: TGauge
        Left = 57
        Top = 39
        Width = 599
        Height = 18
        Anchors = [akLeft, akTop, akRight]
        PopupMenu = mnuAuxiliar
        Progress = 0
        ExplicitWidth = 590
      end
      object flnArqTxt: TFilenameEditFocus
        Left = 57
        Top = 11
        Anchors = [akLeft, akTop, akRight]
        PopupMenu = mnuAuxiliar
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000004020FF406040FF406040FF4060
              40FF004020FF0000000000000000000000000000000000000000806040FFC080
              60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
              80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
              FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
              60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
              FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
              60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
              FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
              60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
              FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
              60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
              80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
              FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
              A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
              FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
              80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
              80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
              80FFC0A080FF808060FF000000000000000000000000}
            Kind = bkGlyph
          end>
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        OnExit = flnArqTxtExit
        Width = 599
      end
      object chkImprime: TCheckBox
        Left = 57
        Top = 58
        Width = 336
        Height = 17
        Caption = 'Imprimir pedido ap'#243's a grava'#231#227'o'
        TabOrder = 1
      end
      object rdgTabPre: TRadioGroup
        Left = 57
        Top = 84
        Width = 301
        Height = 62
        Caption = 'Tabela de pre'#231'o que ser'#225' utilizado na grava'#231#227'o do pedido:'
        ItemIndex = 0
        Items.Strings = (
          'Tabela de Pre'#231'o do Cliente / Regras do Faturamento'
          'Pre'#231'os definidos no arquivo')
        TabOrder = 2
      end
    end
    object Panel4: TPanel
      Left = 661
      Top = 1
      Width = 149
      Height = 156
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object gpbLegendas: TGroupBox
        Left = 1
        Top = 1
        Width = 147
        Height = 56
        Caption = 'Legenda'
        TabOrder = 0
        object Shape1: TShape
          Left = 10
          Top = 16
          Width = 17
          Height = 15
          Brush.Color = clRed
          Pen.Color = clRed
          Pen.Style = psClear
          Shape = stCircle
        end
        object Label2: TLabel
          Left = 38
          Top = 16
          Width = 26
          Height = 14
          Caption = 'Erros'
        end
        object Label3: TLabel
          Left = 38
          Top = 35
          Width = 34
          Height = 14
          Caption = 'Avisos'
        end
        object Shape2: TShape
          Left = 10
          Top = 35
          Width = 17
          Height = 15
          Brush.Color = clYellow
          Pen.Color = clRed
          Pen.Style = psClear
          Shape = stCircle
        end
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 158
    Width = 811
    Height = 186
    Align = alClient
    ParentColor = True
    TabOrder = 4
    object DBGrid1: TDBGridCitel
      Left = 1
      Top = 1
      Width = 809
      Height = 184
      Align = alClient
      BorderStyle = bsNone
      DataSource = dtsOcorrencias
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'LINHA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CAMPO'
          Width = 442
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OCORRENCIA'
          Width = 1363
          Visible = True
        end>
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 524
    Width = 811
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 5
    object BitBtnLocked1: TBitBtnLocked
      Left = 712
      Top = 2
      Width = 97
      Height = 24
      Align = alRight
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 97
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnLimpa: TBitBtnLocked
      Left = 104
      Top = 3
      Width = 97
      Height = 22
      Caption = '&Limpar'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnLimpaClick
    end
  end
  object pnlDivergSaldo: TPanel [6]
    Left = 0
    Top = 344
    Width = 811
    Height = 180
    Align = alBottom
    TabOrder = 6
    Visible = False
    object dbgDivergSaldo: TDBGridCitel
      Left = 1
      Top = 25
      Width = 809
      Height = 135
      Align = alClient
      BorderStyle = bsNone
      DataSource = dtsDivergSaldo
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDivergSaldoDrawColumnCell
      OnKeyDown = dbgDivergSaldoKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODITE'
          Title.Caption = 'C'#243'd. Produto'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Descri'#231#227'o do Produto'
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALDIS'
          Title.Caption = 'Saldo Dispon'#237'vel'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDPED'
          Title.Caption = 'Qtde do Pedido'
          Width = 100
          Visible = True
        end>
    end
    object pnlRodDivergSaldo: TPanel
      Left = 1
      Top = 160
      Width = 809
      Height = 19
      Align = alBottom
      TabOrder = 1
      object lblRodDivergSaldo: TLabel
        Left = 7
        Top = 3
        Width = 265
        Height = 14
        Caption = '* [ENTER] para marcar itens que n'#227'o ser'#227'o importados.'
      end
      object pnlLegMarcado: TPanel
        AlignWithMargins = True
        Left = 715
        Top = 2
        Width = 92
        Height = 15
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alRight
        BevelOuter = bvNone
        Color = 16770261
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 0
        Visible = False
        object shpMarcado: TShape
          Left = 6
          Top = 3
          Width = 10
          Height = 10
          Brush.Color = clAqua
        end
        object lblLegMarcado: TLabel
          Left = 20
          Top = 1
          Width = 48
          Height = 14
          Caption = 'Marcados'
        end
      end
    end
    object pnlCabDivergSaldo: TPanel
      Left = 1
      Top = 1
      Width = 809
      Height = 24
      Align = alTop
      Caption = 'Itens sem Saldo Dispon'#237'vel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 80
  end
  object cdsOcorrencias: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'LINHA'
        DataType = ftInteger
      end
      item
        Name = 'CAMPO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'OCORRENCIA'
        DataType = ftString
        Size = 300
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 160
    Top = 136
    object cdsOcorrenciasTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 4
      FieldName = 'TIPO'
      Size = 1
    end
    object cdsOcorrenciasLINHA: TIntegerField
      DisplayLabel = 'N'#186' Linha'
      DisplayWidth = 9
      FieldName = 'LINHA'
    end
    object cdsOcorrenciasCAMPO: TStringField
      DisplayLabel = 'Campo'
      DisplayWidth = 43
      FieldName = 'CAMPO'
      Size = 60
    end
    object cdsOcorrenciasOCORRENCIA: TStringField
      DisplayLabel = 'Ocorr'#234'ncia'
      DisplayWidth = 91
      FieldName = 'OCORRENCIA'
      Size = 300
    end
  end
  object dtsOcorrencias: TDataSource
    DataSet = cdsOcorrencias
    Left = 248
    Top = 136
  end
  object dtsDivergSaldo: TDataSource
    Left = 120
    Top = 408
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44854.384284398150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;  '
      ''
      'begin'
      ''
      'end.')
    Left = 280
    Top = 408
    Datasets = <
      item
        DataSet = frxDBDivergSaldo
        DataSetName = 'frxDBDivergSaldo'
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
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDivergSaldo
        DataSetName = 'frxDBDivergSaldo'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 714.708649210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxDBDivergSaldoCODITE: TfrxMemoView
          Left = 3.000000000000000000
          Width = 88.818897640000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDivergSaldo."CODITE"]')
          ParentFont = False
        end
        object frxDBDivergSaldoDESITE: TfrxMemoView
          Left = 93.732283460000000000
          Width = 381.732530000000000000
          Height = 15.118120000000000000
          DataField = 'DESITE'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDivergSaldo."DESITE"]')
          ParentFont = False
        end
        object frxDBDivergSaldoSALDIS: TfrxMemoView
          Left = 478.488188980000000000
          Width = 122.456692910000000000
          Height = 15.118120000000000000
          DataField = 'SALDIS'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDivergSaldo."SALDIS"]')
          ParentFont = False
        end
        object frxDBDivergSaldoQTDPED: TfrxMemoView
          Left = 604.724800000000000000
          Width = 109.606299210000000000
          Height = 15.118110240000000000
          DataField = 'QTDPED'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDivergSaldo."QTDPED"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 309.921460000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 359.584230000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 7.559059999999988000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo18: TfrxMemoView
          Width = 718.110700000000000000
          Height = 15.874015750000000000
          DataSet = frmProcArqSPC.frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 3.000000000000000000
          Width = 88.818878110000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'D. PRODUTO')
        end
        object Memo4: TfrxMemoView
          Left = 93.708720000000000000
          Width = 381.732530000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O DO PRODUTO')
        end
        object Memo7: TfrxMemoView
          Left = 478.441250000000000000
          Width = 122.504020000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO DISPON'#205'VEL')
        end
        object Memo8: TfrxMemoView
          Left = 604.724800000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE DO PEDIDO')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 107.661410000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 6.538745000000000000
          Top = 34.000000000000000000
          Width = 705.033210000000000000
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
        object rllPagina: TfrxMemoView
          Left = 599.584230000000000000
          Top = 54.000000000000000000
          Width = 115.200000000000000000
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
          Left = 621.127520000000000000
          Top = 71.000000000000000000
          Width = 93.656710000000000000
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
        end
        object Date: TfrxMemoView
          Left = 488.768460000000000000
          Top = 71.000000000000000000
          Width = 124.800000000000000000
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
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 99.370130000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 3.779530000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object lblNomOpe: TfrxMemoView
          Align = baLeft
          Top = 71.023622050000000000
          Width = 474.481880000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OPERADOR]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDivergSaldo: TfrxDBDataset
    UserName = 'frxDBDivergSaldo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODITE=CODITE'
      'DESITE=DESITE'
      'SALDIS=SALDIS'
      'QTDPED=QTDPED')
    BCDToCurrency = False
    Left = 200
    Top = 408
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 39693.439363055600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
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
      'begin'
      ''
      'end.')
    Left = 360
    Top = 408
    Datasets = <
      item
        DataSet = frxDBDivergSaldo
        DataSetName = 'frxDBDivergSaldo'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1248.000000000000000000
        DataSet = frxDBDivergSaldo
        DataSetName = 'frxDBDivergSaldo'
        RowCount = 0
        object frxDBDivergSaldoCODITE: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBDivergSaldo."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBDivergSaldoDESITE: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBDivergSaldo."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBDivergSaldoSALDIS: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataField = 'SALDIS'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDivergSaldo."SALDIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDBDivergSaldoQTDPED: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDPED'
          DataSet = frxDBDivergSaldo
          DataSetName = 'frxDBDivergSaldo'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDivergSaldo."QTDPED"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 238.000000000000000000
        Width = 1248.000000000000000000
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
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'C'#211'D. PRODUTO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O DO PRODUTO')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'SADO DISPON'#205'VEL')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE DO PEDIDO')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 76.800000000000000000
          Top = 34.000000000000000000
          Width = 1094.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 787.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Align = baLeft
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
      end
    end
  end
end
