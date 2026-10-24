inherited frmQckAcertoConta: TfrmQckAcertoConta
  Left = 281
  Top = 220
  Width = 432
  Height = 232
  Caption = 'frmQckAcertoConta'
  ExplicitWidth = 432
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 161
    Width = 426
    ExplicitTop = 161
    ExplicitWidth = 426
    inherited FlwBotoes: TFlowPanel
      Width = 345
      ExplicitWidth = 345
    end
    inherited btnSair: TBitBtnLocked
      Left = 347
      ExplicitLeft = 347
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 426
    ExplicitTop = 187
    ExplicitWidth = 426
    inherited pnlNomeForm: TPanel
      Left = 255
      ExplicitLeft = 255
    end
    inherited pnlInfo: TPanel
      Width = 255
      ExplicitWidth = 255
    end
  end
  inherited pnlDados: TPanel
    Width = 426
    Height = 161
    ExplicitWidth = 426
    ExplicitHeight = 161
    inherited gpbDestino: TGroupBox
      Left = 15
      Top = 108
      ExplicitLeft = 15
      ExplicitTop = 108
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 12
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    DataSource = dtsCtaRec
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 8
  end
  object dtsCtaRec: TDataSource
    Left = 172
    Top = 64
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726900000000
    ReportOptions.LastChange = 44386.714962673600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 48
    Top = 64
    Datasets = <
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 287.244280000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 1.779527560000000000
          Width = 86.929153390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 89.590600000000000000
          Width = 43.464540080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ESPDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 134.519790000000000000
          Width = 51.023600080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 187.008040000000000000
          Width = 62.362190080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 251.834880000000000000
          Width = 62.362190080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 311.740396690000000000
          Width = 75.590563390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
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
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 678.527966690000000000
          Top = 0.220470000000000000
          Width = 75.590563390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALCAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 391.181336690000000000
          Width = 71.811033390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 526.464886690000000000
          Width = 64.251973390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
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
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 463.102660000000000000
          Width = 60.472438500000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALMUL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 594.165740000000000000
          Width = 83.149623390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DESPCO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbFooter: TfrxFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 328.819110000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.ChildCndPag
        object Line1: TfrxLineView
          Left = -0.220470000000000000
          Top = 2.779530000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Top = 21.677180000000020000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rlbSoma01: TfrxMemoView
          Left = 321.039580000000000000
          Top = 3.940940000000000000
          Width = 68.031503390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 268.346630000000000000
          Top = 3.940940000000000000
          Width = 45.354323390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 679.268090000000000000
          Top = 4.000000000000000000
          Width = 75.590563390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALCAL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 392.260050000000000000
          Top = 3.940940000000000000
          Width = 71.811033390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALDUP">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 465.291590000000000000
          Top = 3.940940000000000000
          Width = 56.692913390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALMUL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 524.433383310000000000
          Top = 3.779530000000000000
          Width = 64.251973390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALJUR">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 594.126333310000000000
          Top = 3.779530000000000000
          Width = 83.149623390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_DESPCO">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 948.662030000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 298.582389130000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 506.450012520000000000
          Top = 3.779530000000022000
          Width = 245.668520000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhes)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Left = 0.220470000000000000
          Top = 1.000000000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ChildCndPag: TfrxChild
        FillType = ftBrush
        Height = 468.441225590000000000
        Top = 374.173470000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'ChildCndPagOnBeforePrint'
        Stretched = True
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 97.322924960000000000
          Top = 3.338590000000011000
          Width = 561.260150080000000000
          Height = 22.677155590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CNDPAG]')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag1: TfrxMemoView
          Left = 264.567100000000000000
          Top = 30.015769999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag1: TfrxMemoView
          Left = 381.732530000000000000
          Top = 30.015769999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag2: TfrxMemoView
          Left = 264.567100000000000000
          Top = 47.913419999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag2: TfrxMemoView
          Left = 381.732530000000000000
          Top = 47.913419999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag3: TfrxMemoView
          Left = 264.567100000000000000
          Top = 65.811069999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag3: TfrxMemoView
          Left = 381.732530000000000000
          Top = 65.811069999999970000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag4: TfrxMemoView
          Left = 264.567100000000000000
          Top = 84.708720000000030000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag4: TfrxMemoView
          Left = 381.732530000000000000
          Top = 84.708720000000030000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag5: TfrxMemoView
          Left = 264.567100000000000000
          Top = 102.606370000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag5: TfrxMemoView
          Left = 381.732530000000000000
          Top = 102.606370000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag6: TfrxMemoView
          Left = 264.567100000000000000
          Top = 121.504020000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag6: TfrxMemoView
          Left = 381.732530000000000000
          Top = 121.504020000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag7: TfrxMemoView
          Left = 264.567100000000000000
          Top = 139.401670000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag7: TfrxMemoView
          Left = 381.732530000000000000
          Top = 139.401670000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag8: TfrxMemoView
          Left = 264.567100000000000000
          Top = 158.299320000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag8: TfrxMemoView
          Left = 381.732530000000000000
          Top = 158.299320000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag9: TfrxMemoView
          Left = 264.567100000000000000
          Top = 176.196970000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag9: TfrxMemoView
          Left = 381.732530000000000000
          Top = 176.196970000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag10: TfrxMemoView
          Left = 264.567100000000000000
          Top = 195.315090000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag10: TfrxMemoView
          Left = 381.732530000000000000
          Top = 195.315090000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag11: TfrxMemoView
          Left = 264.567100000000000000
          Top = 213.212740000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag11: TfrxMemoView
          Left = 381.732530000000000000
          Top = 213.212740000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag12: TfrxMemoView
          Left = 264.567100000000000000
          Top = 230.330860000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag12: TfrxMemoView
          Left = 381.732530000000000000
          Top = 230.330860000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag13: TfrxMemoView
          Left = 264.567100000000000000
          Top = 249.448979999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag13: TfrxMemoView
          Left = 381.732530000000000000
          Top = 249.448979999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag14: TfrxMemoView
          Left = 264.567100000000000000
          Top = 267.346629999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag14: TfrxMemoView
          Left = 381.732530000000000000
          Top = 267.346629999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag15: TfrxMemoView
          Left = 264.567100000000000000
          Top = 285.244279999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag15: TfrxMemoView
          Left = 381.732530000000000000
          Top = 285.244279999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag16: TfrxMemoView
          Left = 264.567100000000000000
          Top = 304.141929999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag16: TfrxMemoView
          Left = 381.732530000000000000
          Top = 304.141929999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag17: TfrxMemoView
          Left = 264.567100000000000000
          Top = 322.039579999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag17: TfrxMemoView
          Left = 381.732530000000000000
          Top = 322.039579999999900000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag18: TfrxMemoView
          Left = 264.567100000000000000
          Top = 340.937230000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag18: TfrxMemoView
          Left = 381.732530000000000000
          Top = 340.937230000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag19: TfrxMemoView
          Left = 264.567100000000000000
          Top = 358.834880000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag19: TfrxMemoView
          Left = 381.732530000000000000
          Top = 358.834880000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag20: TfrxMemoView
          Left = 264.567100000000000000
          Top = 377.732530000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag20: TfrxMemoView
          Left = 381.732530000000000000
          Top = 377.732530000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag21: TfrxMemoView
          Left = 264.567100000000000000
          Top = 395.630180000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag21: TfrxMemoView
          Left = 381.732530000000000000
          Top = 395.630180000000100000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag22: TfrxMemoView
          Left = 264.567100000000000000
          Top = 414.748300000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag22: TfrxMemoView
          Left = 381.732530000000000000
          Top = 414.748300000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag23: TfrxMemoView
          Left = 264.567100000000000000
          Top = 432.645950000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag23: TfrxMemoView
          Left = 381.732530000000000000
          Top = 432.645950000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoDtaPag24: TfrxMemoView
          Left = 264.567100000000000000
          Top = 449.764070000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          VAlign = vaCenter
        end
        object mmoValPag24: TfrxMemoView
          Left = 381.732530000000000000
          Top = 449.764070000000000000
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 196.535560000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.Child1
        Condition = 'frxRelatorio."CTR_CODCLI"'
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.897649999999999000
          Width = 332.673530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NOMCLI"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 865.512370000000000000
        Width = 755.906000000000000000
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 245.669450000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007859370000000000
          Fill.BackColor = clSilver
        end
        object rllTitulo01: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.889763780000000000
          Width = 54.803130080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 87.590600000000000000
          Top = 1.889763780000000000
          Width = 47.244070080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Esp'#233'cie')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 135.519790000000000000
          Top = 1.889763780000000000
          Width = 51.023600080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 186.008040000000000000
          Top = 1.889763780000000000
          Width = 66.141720080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 253.496290000000000000
          Top = 1.889763780000000000
          Width = 62.362190080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 317.850650000000000000
          Top = 1.889763780000000000
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Original')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 679.638220000000000000
          Top = 1.889763780000000000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Corrigido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 390.291590000000000000
          Top = 1.889763780000000000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 528.354670000000000000
          Top = 1.889763780000000000
          Width = 62.362190080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Juros')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 464.102660000000000000
          Top = 2.000000000000000000
          Width = 58.582660080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 594.165740000000000000
          Top = 1.779530000000000000
          Width = 85.039370080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desp. Cobran'#231'a')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo34: TfrxMemoView
          Left = 421.527830000000000000
          Top = 56.590599999999990000
          Width = 332.673530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = 46.753000000000000000
          Top = 2.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
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
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baCenter
          Left = 181.682190000000000000
          Top = 27.500000000000000000
          Width = 392.541620000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ACERTO DE CONTA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 655.825170000000000000
          Top = 15.661410000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 560.691280000000000000
          Top = 33.543290000000000000
          Width = 192.830920000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITIDO EM [(<Date>)]  [fTime(False)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 154.960730000000000000
        Width = 755.906000000000000000
        object Memo46: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007859370000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.669293780000004000
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 102.047310000000000000
          Top = 2.669293780000004000
          Width = 54.803130080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Esp'#233'cie')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 163.535560000000000000
          Top = 2.669293780000004000
          Width = 54.803130080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 221.685220000000000000
          Top = 2.669293780000004000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 297.512060000000000000
          Top = 2.669293780000004000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 375.882190000000000000
          Top = 2.669293780000004000
          Width = 77.480310080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Original')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 669.417750000000000000
          Top = 1.889763780000010000
          Width = 81.259840080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Corrigido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 453.102660000000000000
          Top = 2.669293780000004000
          Width = 85.039370080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 599.165740000000000000
          Top = 2.669293780000004000
          Width = 62.362190080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Juros')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Left = 534.913730000000000000
          Top = 2.669293780000004000
          Width = 62.362190080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726900000000
    ReportOptions.LastChange = 42129.482209849500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 120
    Top = 64
    Datasets = <
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
    object Page1: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 912.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ACERTO DE CONTA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllPagina: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'PAGINA [Page]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo2: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO EM [(<Date>)]  [fTime(False)]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object rllCliente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo20: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 68.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#77'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 115.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#62'
        end
      end
      object rlbHeader: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 153.000000000000000000
        Width = 912.000000000000000000
        object Memo5: TfrxDMPMemoView
          Align = baClient
          Width = 912.000000000000000000
          Height = 17.000000000000000000
          TruncOutboundText = False
        end
        object rllTitulo01: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo3: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Esp')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo8: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Emp')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo9: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencto')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo10: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagto')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo11: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Orig.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo12: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Corrig.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vr. Duplic.')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Juros')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 624.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 912.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoDetalhe: TfrxDMPMemoView
          Align = baClient
          Width = 912.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object rllZebra: TfrxDMPMemoView
          Align = baClient
          Width = 912.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo13: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ESPDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo14: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo15: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo16: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAPAG"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo17: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo18: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALCAL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALMUL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object rlbFooter: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 912.000000000000000000
        object rlbSoma01: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo4: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = []
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Memo6: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CTR_VALCAL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Line1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object Line2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALDUP">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALJUR">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."CTR_VALMUL">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 816.000000000000000000
        Width = 912.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 34.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object Line3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
      end
      object ChildCndPag: TfrxChild
        FillType = ftBrush
        Height = 476.000000000000000000
        Top = 306.000000000000000000
        Width = 912.000000000000000000
        OnBeforePrint = 'ChildCndPagOnBeforePrint'
        Stretched = True
        object Memo19: TfrxDMPMemoView
          Align = baCenter
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CNDPAG]')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag1: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag1: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag2: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag2: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag3: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag3: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag4: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag4: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag5: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag5: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag6: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag6: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag7: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 153.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag7: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 153.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag8: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 170.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag8: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 170.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag9: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 187.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag9: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 187.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag10: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 204.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag10: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 204.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag11: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 221.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag11: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 221.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag12: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 238.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag12: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 238.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag13: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 255.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag13: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 255.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag14: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 272.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag14: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 272.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag15: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 289.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag15: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 289.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag16: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 306.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag16: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 306.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag17: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 323.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag17: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 323.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag18: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 340.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag18: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 340.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag19: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 357.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag19: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 357.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag20: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 374.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag20: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 374.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag21: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 391.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag21: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 391.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag22: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 408.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag22: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 408.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag23: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 425.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag23: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 425.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoDtaPag24: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 442.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            '99/99/9999')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object mmoValPag24: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 442.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '9999999,99')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxPreviaNeg: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40772.569103726900000000
    ReportOptions.LastChange = 44393.591296076390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 284
    Top = 112
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxParcelas
        DataSetName = 'frxParcelas'
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 487.559370000000000000
        Width = 755.906000000000000000
        DataSet = frxParcelas
        DataSetName = 'frxParcelas'
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 3.779527560000000000
          Width = 68.031503390000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxParcelas."parcela"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 76.283550000000000000
          Width = 73.700780080000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxParcelas."vencimento"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 253.937230000000000000
          Width = 85.039370080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxParcelas."amortizacao"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 344.976636690000000000
          Width = 83.149623390000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxParcelas."juros"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 154.409536690000000000
          Width = 90.708683390000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxParcelas."saldo_devedor"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 433.086890000000000000
          Width = 79.370088500000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxParcelas."prestacao"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 514.016080000000000000
          Width = 109.606328500000000000
          Height = 17.000000000000000000
          DataSet = frxParcelas
          DataSetName = 'frxParcelas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxParcelas."prestacao_a_pagar"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 797.480830000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 298.582389130000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 479.993302520000000000
          Top = 3.779530000000022000
          Width = 272.125230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(MASTERDATA1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Left = 0.220470000000000000
          Top = 1.000000000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 20.787389370000000000
        Top = 404.409710000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Width = 642.520100000000000000
          Height = 17.007859370000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779527560000000000
          Top = 0.669293779999975400
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parcela')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 76.842610000000000000
          Top = 0.669293779999975400
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 153.889920000000000000
          Top = 0.889763780000009700
          Width = 103.937020080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Saldo Devedor')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 259.716760000000000000
          Top = 0.889763780000009700
          Width = 81.259840080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Armotiza'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 343.496290000000000000
          Top = 0.669293779999975400
          Width = 85.039370080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 431.866420000000000000
          Top = 0.669293780000000000
          Width = 81.259840080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Presta'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 515.016080000000000000
          Top = -0.000004880000000013
          Width = 111.496080080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Presta'#231#227'o a pagar')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 86.929190000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxPreviaNeg.cInfGeral
        object Memo3: TfrxMemoView
          Align = baCenter
          Left = 46.753000000000000000
          Top = 2.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
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
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baCenter
          Left = 181.682190000000000000
          Top = 27.500000000000000000
          Width = 392.541620000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            ' NEGOCIA'#199#195'O DE PARCELAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 655.825170000000000000
          Top = 15.661410000000000000
          Width = 96.302350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA [Page]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baRight
          Left = 563.075080000000000000
          Top = 33.543290000000000000
          Width = 192.830920000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [(<Date>)]  [fTime(False)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object cInfGeral: TfrxChild
        FillType = ftBrush
        Height = 253.228510000000000000
        Top = 128.504020000000000000
        Width = 755.906000000000000000
        Child = frxPreviaNeg.Child1
        object Memo9: TfrxMemoView
          Align = baLeft
          Top = 1.000000000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total Geral Corrigido')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Top = 19.897650000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Desconto')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 39.015770000000010000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total com Desconto')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Top = 57.913420000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtd.Parcelas')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Top = 77.590600000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '** Valor Final Desejado')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Top = 96.929190000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Taxa Juros Parcelamento')
          ParentFont = False
        end
        object memoInterDias: TfrxMemoView
          Align = baLeft
          Top = 116.606370000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Invervalo em Dias')
          ParentFont = False
        end
        object memoVencFixo: TfrxMemoView
          Align = baLeft
          Top = 135.504020000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vencimento Dia Fixo')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Top = 154.960730000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Car'#234'ncia (N'#186' Parcelas)')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 1.000000000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [TOTGERCOR]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 19.897650000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [VALDES]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 39.015770000000010000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [TOTCOMDES]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 57.913420000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [QTDPAR]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 77.590600000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [VALFINDES]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 96.929190000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [TAXJUR]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 116.606370000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [INTERDIAS]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 135.504020000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [VENCDIAFIXO]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Align = baLeft
          Left = 154.960730000000000000
          Top = 154.960730000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [CARENCIA]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Align = baRight
          Left = 529.134200000000000000
          Top = 57.252010000000010000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Base')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Align = baRight
          Left = 600.945270000000000000
          Top = 57.252010000000010000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [DTABASE]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Align = baRight
          Left = 521.575140000000000000
          Top = 117.165430000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Amortiza'#231#227'o')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Align = baRight
          Left = 600.945270000000000000
          Top = 117.165430000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [AMORTI]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Align = baRight
          Left = 563.149970000000000000
          Top = 136.063080000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Align = baRight
          Left = 600.945270000000000000
          Top = 136.063080000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [JUROS]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Align = baRight
          Left = 536.693260000000000000
          Top = 154.960730000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor final')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Align = baRight
          Left = 600.945270000000000000
          Top = 154.960730000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ': [VALFIN]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 3.779530000000000000
          Top = 188.976500000000000000
          Width = 578.268090000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '** A taxa de juros do parcelamento ser'#225' calculada automaticament' +
              'e caso informe o '
            
              '  "Valor Final Desejado". Se deseja digitar a taxa de juros favo' +
              'r n'#227'o informar       '
            '   valor neste campo.')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 593.386210000000000000
        Width = 755.906000000000000000
        Child = frxPreviaNeg.Child2
        Condition = 'frxRelatorio."CTR_CODCLI"'
        object Memo68: TfrxMemoView
          Align = baLeft
          Top = 0.661410000000046200
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NOMCLI"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 721.890230000000000000
        Width = 755.906000000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 680.315400000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo4: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 <> 1'
          Highlight.FillType = ftBrush
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 3.779527560000000000
          Width = 98.267743390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 100.724490000000000000
          Width = 39.685010080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_CODEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 292.842746690000000000
          Top = 0.102350000000001300
          Width = 64.251973390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALORI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 634.732666690000000000
          Top = 0.102350000000001300
          Width = 68.031503390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALCAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 358.283686690000000000
          Top = 0.102350000000001300
          Width = 64.251973390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 495.787706690000000000
          Top = 0.102350000000001300
          Width = 64.251973390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALJUR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 424.866420000000000000
          Top = 0.102350000000001300
          Width = 71.811028500000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_VALMUL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 140.433210000000000000
          Width = 73.700780080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 218.039580000000000000
          Top = 0.102350000000001300
          Width = 73.700780080000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DTAPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Left = 560.929500000000000000
          Top = 0.102350000000001300
          Width = 71.811033390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CTR_DESPCO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Left = 704.772110000000000000
          Top = 0.102350000000001300
          Width = 49.133853390000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_ATRASO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 17.007859370000000000
        Top = 638.740570000000000000
        Width = 755.906000000000000000
        object Memo42: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 17.007859370000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 3.779527560000000000
          Top = 1.669293779999975000
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 103.283550000000000000
          Top = 1.669293779999975000
          Width = 35.905480080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Left = 142.212740000000000000
          Top = 1.669293779999975000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Left = 218.039580000000000000
          Top = 1.669293779999975000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Left = 290.732530000000000000
          Top = 1.669293779999975000
          Width = 66.141720080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Orig.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo64: TfrxMemoView
          Left = 633.401980000000000000
          Top = 0.889763779999952900
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Corrig.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 426.984540000000000000
          Top = 1.669293780000000000
          Width = 69.921250080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Multa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 497.897960000000000000
          Top = 1.669293779999975000
          Width = 62.362190080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Juros')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 359.055350000000000000
          Top = 1.669293780000000000
          Width = 66.141720080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. Dup.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 705.992580000000000000
          Top = 1.000000000000000000
          Width = 47.244070080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Atraso')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 559.370440000000000000
          Top = 2.000000000000000000
          Width = 73.700780080000000000
          Height = 15.118095590000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desp. Cob.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 529.134200000000000000
        Width = 755.906000000000000000
        object Memo69: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATAS NEGOCIA'#199#195'O PARCELAMENTO ')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxParcelas: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxParcelas'
    CloseDataSource = False
    DataSource = dtsParcelas
    BCDToCurrency = False
    Left = 168
    Top = 112
  end
  object dtsParcelas: TDataSource
    Left = 224
    Top = 112
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = True
    Left = 360
    Top = 110
  end
end
