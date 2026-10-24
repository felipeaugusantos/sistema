inherited frmImportaRetornoCustodia: TfrmImportaRetornoCustodia
  Width = 461
  Height = 142
  Caption = 'Importa'#231#227'o de arquivo de retorno de cust'#243'dia de cheques'
  OnDestroy = FormDestroy
  ExplicitWidth = 461
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 13
    Width = 41
    Height = 14
    Caption = 'Arquivo:'
  end
  object Label2: TLabel [1]
    Left = 15
    Top = 42
    Width = 34
    Height = 14
    Caption = 'Banco:'
  end
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 455
    ExplicitTop = 69
    ExplicitWidth = 455
    inherited FlwBotoes: TFlowPanel
      Top = 3
      Width = 451
      Height = 23
      TabOrder = 0
      ExplicitTop = 3
      ExplicitWidth = 451
      ExplicitHeight = 23
      inherited btnConfirma: TBitBtnLocked
        Height = 20
        ModalResult = 0
        ExplicitHeight = 20
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 375
      Height = 20
      TabOrder = 1
      ExplicitLeft = 375
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 97
    Width = 455
    ExplicitTop = 97
    ExplicitWidth = 455
    inherited pnlNomeForm: TPanel
      Left = 284
      ExplicitLeft = 284
    end
    inherited pnlInfo: TPanel
      Width = 284
      ExplicitWidth = 284
    end
  end
  object edtArquivo: TFilenameEditFocus [5]
    Tag = 99
    Left = 55
    Top = 8
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
    TabOrder = 3
    Width = 389
  end
  object cbxBanco: TComboBoxFocus [6]
    Left = 55
    Top = 38
    Width = 389
    Height = 22
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = 'Santander'
    Items.Strings = (
      'Santander')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 680
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 560
    Top = 32
  end
  object frxRetCustodia: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42648.641263634260000000
    ReportOptions.LastChange = 42650.402692256950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure gphOcorrenciaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdOcorrencia.Visible := <frxCheques."strCodOcorrencia"> <> '#39#39 +
        ';                                      '
      'end;'
      ''
      'procedure memStatusOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  case <frxCheques."intStatus"> of'
      '    0: memStatus.text := '#39'CHEQUES ENCONTRADOS EM CUST'#211'DIA'#39';'
      
        '    1: memStatus.text := '#39'CHEQUES EM CUST'#211'DIA N'#195'O ENCONTRADOS NO' +
        ' SISTEMA'#39';                   '
      
        '    2: memStatus.text := '#39'CHEQUES EM CUST'#211'DIA NO SISTEMA N'#195'O ENC' +
        'ONTRADOS NO ARQUIVO'#39';                   '
      '  end;          '
      'end;'
      ''
      'procedure gphStatusOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  pghTitulo.Child := chdTitulosColunas;                         ' +
        '   '
      'end;'
      ''
      'procedure gphLoteOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chdLote.Visible := <frxCheques."intStatus"> <> 1;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 336
    Datasets = <
      item
        DataSet = frxCheques
        DataSetName = 'frxCheques'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 340.157700000000000000
        Width = 740.409927000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Memo1: TfrxMemoView
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."strEmitente"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 234.330860000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."strBanco"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 275.905690000000000000
          Width = 56.692903620000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."strAgencia"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 332.598640000000000000
          Width = 75.590553620000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."strNumConta"]-[frxCheques."strDvConta"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Left = 483.779840000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."fltValor"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 574.488560000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheques."dtaCadastro"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 657.638220000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheques."dtaVencimento"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 408.189240000000000000
          Width = 75.590553620000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."strNumCheque"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object gphOcorrencia: TfrxGroupHeader
        FillType = ftBrush
        Top = 279.685220000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'gphOcorrenciaOnBeforePrint'
        Child = frxRetCustodia.chdOcorrencia
        Condition = 'frxCheques."strCodOcorrencia"'
      end
      object gphLote: TfrxGroupHeader
        FillType = ftBrush
        Top = 219.212740000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'gphLoteOnBeforePrint'
        Child = frxRetCustodia.chdLote
        Condition = 'frxCheques."strLote"'
      end
      object gpfOcorrencia: TfrxGroupFooter
        FillType = ftBrush
        Top = 377.953000000000000000
        Width = 740.409927000000000000
      end
      object gpfLote: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 400.630180000000000000
        Width = 740.409927000000000000
        object Memo17: TfrxMemoView
          Left = 302.362400000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Lote:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 400.630180000000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COUNT(MasterData1)] Cheques')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 483.779840000000000000
          Top = 3.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheques."fltValor">,MasterData1)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 21.677180000000000000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object pghTitulo: TfrxPageHeader
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object Memo22: TfrxMemoView
          Width = 740.787880000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 151.181200000000000000
          Top = 18.897650000000000000
          Width = 438.425480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'POSI'#199#195'O DE CHEQUES EM CUST'#211'DIA')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 597.165740000000000000
          Top = 18.897650000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 597.165740000000000000
          Top = 37.795300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 37.795300000000000000
          Width = 582.047620000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Arquivo: [NOMARQ]')
          ParentFont = False
        end
      end
      object gphStatus: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 136.063080000000000000
        Width = 740.409927000000000000
        OnAfterPrint = 'gphStatusOnAfterPrint'
        Child = frxRetCustodia.chdTitulosColunas
        Condition = 'frxCheques."intStatus"'
        object memStatus: TfrxMemoView
          Width = 740.787880000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'memStatusOnBeforePrint'
          Frame.Typ = [ftBottom]
        end
      end
      object chdTitulosColunas: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 177.637910000000000000
        Width = 740.409927000000000000
        object Shape1: TfrxShapeView
          Width = 740.787880000000000000
          Height = 15.118120000000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitente')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 234.330860000000000000
          Top = 0.000000000000000028
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 275.905690000000000000
          Top = 0.000000000000000028
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 332.598640000000000000
          Top = 0.000000000000000028
          Width = 75.590553620000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'm. Conta')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo14: TfrxMemoView
          Left = 483.779840000000000000
          Top = 0.000000000000000028
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 574.488560000000000000
          Top = 0.000000000000000028
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Cadastro')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 657.638220000000000000
          Top = 0.000000000000000028
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 408.189240000000000000
          Top = 0.000000000000000028
          Width = 75.590553620000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'm. Cheque')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.015748031496060000
        Top = 540.472790000000000000
        Width = 740.409927000000000000
        object Line2: TfrxLineView
          Top = 17.007874015748030000
          Width = 740.787880000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.007874015748030000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'frmImportaRetornoCustodia')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 510.236550000000000000
          Top = 17.007874015748030000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MasterData1)]')
          ParentFont = False
        end
      end
      object gpfStatus: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 445.984540000000000000
        Width = 740.409927000000000000
        object Memo29: TfrxMemoView
          Left = 302.362400000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total Geral:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 400.630180000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COUNT(MasterData1)] Cheques')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 483.779840000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheques."fltValor">,MasterData1)]')
          ParentFont = False
        end
      end
      object chdLote: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 241.889920000000000000
        Width = 740.409927000000000000
        object Memo9: TfrxMemoView
          Width = 733.228820000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote: [frxCheques."strLote"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object chdOcorrencia: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 302.362400000000000000
        Width = 740.409927000000000000
        object Memo8: TfrxMemoView
          Left = 18.897650000000000000
          Width = 718.110700000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              '[frxCheques."strCodOcorrencia"] - [frxCheques."strDescOcorrencia' +
              '"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
  object frxCheques: TfrxUserDataSet
    UserName = 'frxCheques'
    OnCheckEOF = frxChequesCheckEOF
    OnFirst = frxChequesFirst
    OnNext = frxChequesNext
    OnPrior = frxChequesPrior
    OnNewGetValue = frxChequesNewGetValue
    Left = 408
  end
end
