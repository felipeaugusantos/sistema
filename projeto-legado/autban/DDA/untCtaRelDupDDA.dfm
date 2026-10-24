inherited frmCtaRelDupDDA: TfrmCtaRelDupDDA
  Width = 572
  Height = 276
  BorderStyle = bsNone
  Caption = 'Relat'#243'rio de Arq. Retorno DDA'
  Position = poMainFormCenter
  ExplicitWidth = 572
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 234
    Width = 572
    ExplicitTop = 194
    ExplicitWidth = 572
    inherited FlwBotoes: TFlowPanel
      Width = 491
      ExplicitWidth = 491
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 493
      ExplicitLeft = 493
    end
  end
  inherited pnlStatus: TPanel
    Top = 260
    Width = 572
    ExplicitTop = 220
    ExplicitWidth = 572
    inherited pnlNomeForm: TPanel
      Left = 401
      ExplicitLeft = 401
    end
    inherited pnlInfo: TPanel
      Width = 401
      ExplicitWidth = 401
    end
  end
  inherited pnlDados: TPanel
    Width = 572
    Height = 234
    ExplicitWidth = 572
    ExplicitHeight = 194
    object Label1: TLabel [0]
      Left = 184
      Top = 30
      Width = 60
      Height = 14
      Caption = 'Ocorr'#234'ncias'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 82
      Width = 167
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 82
      ExplicitWidth = 167
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 570
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Relat'#243'rio de Arq. Retorno DDA'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object lstCodOco: TcxCheckListBox
      Tag = 99
      Left = 181
      Top = 47
      Width = 378
      Height = 177
      Items = <>
      TabOrder = 3
    end
    object gpbOrdem: TGroupBox
      Left = 8
      Top = 30
      Width = 169
      Height = 49
      Caption = 'Ordenar por...'
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 24
        Width = 130
        Height = 14
        Caption = '(V)encimento (D)ocumento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 128
      Width = 167
      Height = 45
      Caption = 'Apenas registros pendentes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ColorLabel3: TColorLabel
        Left = 31
        Top = 18
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtApenasPendentes: TEditFocus
        Tag = 99
        Left = 7
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'N'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object grpDataArquivos: TGroupBox
      Left = 8
      Top = 179
      Width = 167
      Height = 45
      Caption = 'Data dos arquivos a partir de'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object edtDataInicial: TcxDateEdit
        Tag = 99
        Left = 7
        Top = 16
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        Width = 90
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 784
    Top = 208
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 784
    Top = 176
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 752
    Top = 176
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 720
    Top = 176
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 688
    Top = 176
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 656
    Top = 176
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 592
    Top = 176
  end
  inherited frxGen: TfrxUserDataSet
    Left = 624
    Top = 176
  end
  inherited frxDesigner: TfrxDesigner
    Left = 848
    Top = 176
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 880
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 208
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42614.410288645800000000
    ReportOptions.LastChange = 42621.632153819500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllNomeForOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."CODFOR"> = '#39#39' Then'
      '    rllNomeFor.Text := <frxRelatorio."NOMFOR">'
      '  Else'
      
        '    rllNomeFor.Text := <frxRelatorio."CODFOR"> + '#39'-'#39' + <frxRelat' +
        'orio."NOMFOR">;                                            '
      'end;'
      ''
      'procedure chdDuplicataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chdDuplicata.Visible := (<frxRelatorio."DUPCAD"> <> '#39#39');      ' +
        '                                                  '
      'end;'
      ''
      'procedure memDupCadOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memDupCad.Text := <frxRelatorio."DUPCAD">;                    ' +
        '                             '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 280
    Top = 40
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
    object frxPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rdbDuplicC: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 128.504020000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."DESCRI"'
        object Shape9: TfrxShapeView
          Top = 0.779529999999994100
          Width = 716.220489530000000000
          Height = 24.566934020000000000
        end
        object Memo78: TfrxMemoView
          Left = 7.031540000000000000
          Top = 3.559059999999988000
          Width = 706.772053860000000000
          Height = 20.787406460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          ParentFont = False
        end
      end
      object rdbDuplicR: TfrxGroupFooter
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        object Memo7: TfrxMemoView
          Left = 207.716760000000000000
          Top = 9.118119999999976000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde. Total de Duplicatas:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 377.795610000000000000
          Top = 9.118119999999976000
          Width = 75.590563390000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(mtdDados)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 494.677490000000000000
          Top = 9.118119999999976000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 570.268090000000000000
          Top = 9.118119999999976000
          Width = 143.244094490000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALDUP">,mtdDados)]')
          ParentFont = False
        end
      end
      object rlbCabDDA: TfrxPageHeader
        FillType = ftBrush
        Height = 47.188930000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo24: TfrxMemoView
          Align = baCenter
          Left = 121.814410000000000000
          Top = 16.000000000000000000
          Width = 474.481880000000000000
          Height = 17.007874020000000000
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
        object Memo58: TfrxMemoView
          Left = 592.403340000000000000
          Width = 122.759060000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 592.619110000000000000
          Top = 16.000000000000000000
          Width = 121.020470000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Align = baCenter
          Left = 121.814410000000000000
          Width = 474.481880000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
      end
      object rdbOcorrenciasC: TfrxGroupHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 177.637910000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."CODOCO"'
        object Shape1: TfrxShapeView
          Width = 716.220489530000000000
          Height = 35.905524020000000000
          Fill.BackColor = clSilver
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.559059999999990000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 166.299320000000000000
          Top = 17.448823780000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 578.267982600000000000
          Top = 17.559059999999990000
          Width = 64.251956300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dta. Venc.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 642.519938900000000000
          Top = 17.559059999999990000
          Width = 71.811033390000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Dup.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 1.779530000000000000
          Top = 1.000000000000000000
          Width = 714.331113860000000000
          Height = 17.007876460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CODOCO"] - [frxRelatorio."NOMOCO"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 517.795556300000000000
          Top = 17.118120000000000000
          Width = 60.472426300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dta. Emi.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 196.535560000000000000
          Top = 17.118120000000000000
          Width = 219.212686300000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fornecedor')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 415.748246300000000000
          Top = 17.118120000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 90.708720000000000000
          Top = 17.118120000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'T'#237'tulo')
          ParentFont = False
        end
      end
      object rdbOcorrenciasR: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        object Memo9: TfrxMemoView
          Left = 279.685039370079000000
          Top = 7.559059999999988000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde. Duplicatas:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 377.952819370079000000
          Top = 7.559059999999988000
          Width = 75.590563390000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(mtdDados)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 501.897960000000000000
          Top = 7.559059999999988000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 569.929500000000000000
          Top = 7.559059999999988000
          Width = 143.622103390000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALDUP">,mtdDados)]')
          ParentFont = False
        end
      end
      object mtdDados: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 238.110390000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioJ.chdDuplicata
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rllDuplicV: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.889763780000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DUPCOR"]')
          ParentFont = False
        end
        object rllLiberacaoV: TfrxMemoView
          Align = baLeft
          Left = 166.299320000000000000
          Top = 1.889763780000010000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
        end
        object rllVencimentoV: TfrxMemoView
          Align = baLeft
          Left = 578.267982600000000000
          Top = 1.889763779527556000
          Width = 64.251956300000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
        end
        object rllValorV: TfrxMemoView
          Align = baLeft
          Left = 642.519938900000000000
          Top = 1.889763780000010000
          Width = 71.811033390000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDUP"]')
          ParentFont = False
        end
        object rllCadastroV: TfrxMemoView
          Align = baLeft
          Left = 517.795556300000000000
          Top = 1.889763779527556000
          Width = 60.472426300000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DTAEMI"]')
          ParentFont = False
        end
        object rllNomeFor: TfrxMemoView
          Align = baLeft
          Left = 196.535560000000000000
          Top = 1.889763780000010000
          Width = 219.212686300000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'rllNomeForOnBeforePrint'
          AllowExpressions = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]-[frxRelatorio."NOMFOR"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 415.748246300000000000
          Top = 1.889763780000010000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CNPJ__"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 90.708720000000000000
          Top = 1.779530000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDUP"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 480.000310000000000000
        Width = 718.110700000000000000
        object Memo18: TfrxMemoView
          Left = 207.874150000000000000
          Top = 15.118119999999980000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde. Geral de Duplicatas:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 377.953000000000000000
          Top = 15.118119999999980000
          Width = 75.590563390000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(mtdDados)]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 460.819110000000000000
          Top = 15.118119999999980000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Total Geral:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Left = 570.425480000000000000
          Top = 15.118119999999980000
          Width = 143.244094488189000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALDUP">,mtdDados)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 710.551640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object chdDuplicata: TfrxChild
        FillType = ftBrush
        Height = 12.850393700000000000
        Top = 279.685220000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'chdDuplicataOnBeforePrint'
        object memDupCad: TfrxMemoView
          Left = 3.779530000000000000
          Width = 684.094876300000000000
          Height = 11.338590000000000000
          OnBeforePrint = 'memDupCadOnBeforePrint'
          AllowExpressions = False
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DUPCAD"]')
          ParentFont = False
        end
      end
    end
  end
end
