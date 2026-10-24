object frmQckRomLoteSeparacao: TfrmQckRomLoteSeparacao
  Left = 0
  Top = 0
  ClientHeight = 191
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxReportConferencia: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43006.411090254600000000
    ReportOptions.LastChange = 44540.352038923600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure ReportTitle1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' lblBoxLot.Visible := (<frxDBConferencia."BOXLOT"> <> '#39#39');  '
      ' edtBoxLot.Visible := (<frxDBConferencia."BOXLOT"> <> '#39#39');  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 85
    Datasets = <
      item
        DataSet = frxDBConferencia
        DataSetName = 'frxDBConferencia'
      end
      item
        DataSet = frxDBConferenciaVolumes
        DataSetName = 'frxDBConferenciaVolumes'
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
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 164.031522910000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ReportTitle1OnBeforePrint'
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 1.779530000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Lote Separa'#231#227'o: ')
        end
        object frxDBSeparacaoNUMLOT: TfrxMemoView
          Left = 116.944960000000000000
          Top = 1.779530000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."NUMLOT"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 601.149970000000000000
          Top = 1.779530000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Data: ')
        end
        object frxDBSeparacaoDTACAD: TfrxMemoView
          Left = 642.079160000000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."DTACAD"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 199.330860000000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Descri'#231#227'o:')
        end
        object frxDBSeparacaoDESCRI: TfrxMemoView
          Left = 274.921460000000000000
          Top = 1.779530000000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."DESLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBSeparacaoNOMTRA: TfrxMemoView
          Left = 116.944960000000000000
          Top = 23.236240000000000000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."NOMTRA"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 23.236240000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
        end
        object frxDBSeparacaoNOMMOT: TfrxMemoView
          Left = 116.944960000000000000
          Top = 43.913420000000000000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."NOMMOT"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 43.913420000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Motorista:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 1.559060000000000000
          Top = 152.929190000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo11: TfrxMemoView
          Left = 8.559060000000000000
          Top = 110.370130000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd.Vol. Emb.')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 103.063080000000000000
          Top = 110.370130000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          Left = 150.212740000000000000
          Top = 110.370130000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unid.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 188.346630000000000000
          Top = 110.370130000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          Left = 252.937230000000000000
          Top = 110.370130000000000000
          Width = 464.882190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 116.787401570000000000
          Top = 65.435683330000000000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."PLAVEI"] - [frxDBConferencia."DESVEI"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo17: TfrxMemoView
          Left = 7.559055120000000000
          Top = 65.435683330000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ve'#237'culo:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 7.559060000000000000
          Top = 132.283550000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo28: TfrxMemoView
          Left = 136.063080000000000000
          Top = 132.283550000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaBottom
        end
        object edtBoxLot: TfrxMemoView
          Left = 116.787406450000000000
          Top = 86.929190000000000000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBConferencia."BOXLOT"]')
          ParentFont = False
        end
        object lblBoxLot: TfrxMemoView
          Left = 7.559060000000000000
          Top = 86.929190000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Box:')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        DataSet = frxDBConferencia
        DataSetName = 'frxDBConferencia'
        RowCount = 0
        object frxDBSeparacaoQTDEMB: TfrxMemoView
          Left = 12.338590000000000000
          Top = 1.133858270000000000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBConferencia."QTDEMB"] - [frxDBConferencia."UNDCOP"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object frxDBSeparacaoQTDUNI: TfrxMemoView
          Left = 103.063080000000000000
          Top = 1.133858270000000000
          Width = 41.574830000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBConferencia."QTDUNI"]')
          ParentFont = False
        end
        object frxDBSeparacaoUNDVEN: TfrxMemoView
          Left = 150.212740000000000000
          Top = 1.133858270000000000
          Width = 34.015770000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBConferencia."UNDVEN"]')
          ParentFont = False
        end
        object frxDBSeparacaoCODITE: TfrxMemoView
          Left = 188.346630000000000000
          Top = 1.133858270000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBConferencia."CODITE"]')
          ParentFont = False
        end
        object frxDBSeparacaoDESCRI1: TfrxMemoView
          Left = 252.937230000000000000
          Top = 1.133858270000000000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBConferencia."DESCRI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 11.338590000000000000
          Top = 18.897650000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBConferencia."CODBAR"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo21: TfrxMemoView
          Left = 136.063080000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBConferencia."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 430.866420000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Left = 7.559060000000000000
          Width = 411.968770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'gina: [Page#] de [TotalPages#]       Impress'#227'o: [Date] [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo20: TfrxMemoView
          Left = 532.913730000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'frmQckRomLoteSeparacao')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 385.512060000000000000
        Width = 718.110700000000000000
        object Subreport1: TfrxSubreport
          Left = 7.559060000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportConferencia.Page2
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 302.362400000000000000
        Width = 718.110700000000000000
        object SysMemo1: TfrxSysMemoView
          Left = 88.062982360000000000
          Top = 1.889763780000000000
          Width = 56.692923150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBConferencia."QTDUNI">,MasterData1)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 8.692913390000000000
          Top = 1.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Qtde. total:')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 16.629921259842500000
        Top = 113.385900000000000000
        Width = 718.110700000000000000
        DataSet = frxDBConferenciaVolumes
        DataSetName = 'frxDBConferenciaVolumes'
        RowCount = 0
        object frxDBConferenciaVolumesUNDCOP: TfrxMemoView
          Left = 11.338590000000000000
          Top = 0.779530000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frxDBConferenciaVolumes
          DataSetName = 'frxDBConferenciaVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[frxDBConferenciaVolumes."QTDEMB"] - [frxDBConferenciaVolumes."U' +
              'NDCOP"]')
          ParentFont = False
        end
        object frxDBConferenciaVolumesTOTPES: TfrxMemoView
          Left = 113.283550000000000000
          Top = 0.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'TOTPES'
          DataSet = frxDBConferenciaVolumes
          DataSetName = 'frxDBConferenciaVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBConferenciaVolumes."TOTPES"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        object Memo9: TfrxMemoView
          Left = 113.385900000000000000
          Top = 2.000000000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDBConferenciaVolumes
          DataSetName = 'frxDBConferenciaVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBConferenciaVolumes."TOTPES">,MasterData2)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Width = 188.976500000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          Left = 11.338590000000000000
          Top = 2.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          DataSet = frxDBConferenciaVolumes
          DataSetName = 'frxDBConferenciaVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBConferenciaVolumes."QTDEMB">,MasterData2)]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 11.338590000000000000
          Top = 51.338590000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd.Vol. Emb.')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 28.102350000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 113.283550000000000000
          Top = 51.338590000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Peso')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 70.236240000000000000
          Width = 188.976500000000000000
          Color = clBlack
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBSeparacao: TfrxDBDataset
    UserName = 'frxDBSeparacao'
    CloseDataSource = False
    DataSource = dtsSeparacao
    BCDToCurrency = False
    Left = 152
    Top = 29
  end
  object frxDBConferencia: TfrxDBDataset
    UserName = 'frxDBConferencia'
    CloseDataSource = False
    DataSource = dtsConferencia
    BCDToCurrency = False
    Left = 152
    Top = 85
  end
  object dtsSeparacao: TDataSource
    Left = 236
    Top = 29
  end
  object dtsConferencia: TDataSource
    Left = 236
    Top = 85
  end
  object frxReportSeparacao: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43006.411090254600000000
    ReportOptions.LastChange = 44844.458484837960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  ChdObs1.Visible := (<frxDbSeparacao."OBSER1"> <> '#39#39');'
      '  ChdObs2.Visible := (<frxDbSeparacao."OBSER2"> <> '#39#39');'
      ''
      '  mmoObs1.Memo.Text := '#39'OBS.1: '#39' + <frxDbSeparacao."OBSER1">;'
      '  mmoObs2.Memo.Text := '#39'OBS.2: '#39' + <frxDbSeparacao."OBSER2">;'
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' If Trim(<frxDBSeparacao."NUMFAT">) = '#39#39' Then'
      ' Begin'
      '   lblDocFat.Visible := false;'
      '   edtDocFat.Visible := false;'
      ' End'
      ' Else'
      ' Begin'
      '   lblDocFat.Visible := true;'
      '   edtDocFat.Visible := true;'
      ' End;'
      ''
      'end;'
      ''
      'procedure ReportTitle1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  lblBoxLot.Visible := (<frxDbSeparacao."BOXLOT"> <> '#39#39');'
      '  edtBoxLot.Visible := (<frxDbSeparacao."BOXLOT"> <> '#39#39');'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 49
    Top = 29
    Datasets = <
      item
        DataSet = frxDBSeparacao
        DataSetName = 'frxDBSeparacao'
      end
      item
        DataSet = frxDBSeparacaoVolumes
        DataSetName = 'frxDBSeparacaoVolumes'
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
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 89.007629840000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ReportTitle1OnBeforePrint'
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 1.779530000000000000
          Width = 105.826840000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote Separa'#231#227'o: ')
          ParentFont = False
        end
        object frxDBSeparacaoNUMLOT: TfrxMemoView
          Left = 116.944960000000000000
          Top = 1.779530000000000000
          Width = 75.590551180000000000
          Height = 15.118110236220500000
          DataField = 'NUMLOT'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NUMLOT"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 601.149970000000000000
          Top = 1.779530000000000000
          Width = 37.795300000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data: ')
          ParentFont = False
        end
        object frxDBSeparacaoDTACAD: TfrxMemoView
          Left = 642.079160000000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110236220500000
          DataField = 'DTACAD'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."DTACAD"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 199.330860000000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o:')
          ParentFont = False
        end
        object frxDBSeparacaoDESCRI: TfrxMemoView
          Left = 274.921460000000000000
          Top = 1.779530000000000000
          Width = 321.260050000000000000
          Height = 15.118110236220500000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."DESLOT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBSeparacaoNOMTRA: TfrxMemoView
          Left = 116.944960000000000000
          Top = 18.236240000000000000
          Width = 597.165740000000000000
          Height = 15.118110240000000000
          DataField = 'NOMTRA'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NOMTRA"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 7.559060000000000000
          Top = 18.236240000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Transportadora:')
          ParentFont = False
        end
        object frxDBSeparacaoNOMMOT: TfrxMemoView
          Left = 116.944960000000000000
          Top = 34.913420000000000000
          Width = 597.165740000000000000
          Height = 15.118110240000000000
          DataField = 'NOMMOT'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NOMMOT"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 34.842519690000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Motorista:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 116.787401570000000000
          Top = 52.385826770000000000
          Width = 597.165740000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."PLAVEI"] - [frxDBSeparacao."DESVEI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 7.559055120000000000
          Top = 52.385826770000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ve'#237'culo: ')
          ParentFont = False
        end
        object edtBoxLot: TfrxMemoView
          Left = 116.787406450000000000
          Top = 69.929190000000000000
          Width = 597.165740000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."BOXLOT"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object lblBoxLot: TfrxMemoView
          Left = 7.559060000000000000
          Top = 69.929190000000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Box:')
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 89.007629840000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 35.905511810000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        DataSet = frxDBSeparacao
        DataSetName = 'frxDBSeparacao'
        RowCount = 0
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 35.905511810000000000
        end
        object frxDBSeparacaoQTDEMB: TfrxMemoView
          Left = 7.559060000000000000
          Top = 1.133858270000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSeparacao."QTDEMB"] - [frxDBSeparacao."UNDCOP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBSeparacaoQTDUNI: TfrxMemoView
          Left = 135.187111010000000000
          Top = 1.133858270000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DataField = 'QTDUNI'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSeparacao."QTDUNI"]')
          ParentFont = False
        end
        object frxDBSeparacaoUNDVEN: TfrxMemoView
          Left = 185.336771010000000000
          Top = 1.133858270000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DataField = 'UNDVEN'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."UNDVEN"]')
          ParentFont = False
        end
        object frxDBSeparacaoCODITE: TfrxMemoView
          Left = 228.470661010000000000
          Top = 1.133858270000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataField = 'CODITE'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSeparacao."CODITE"]')
          ParentFont = False
        end
        object frxDBSeparacaoDESCRI1: TfrxMemoView
          Left = 287.445876390000000000
          Top = 1.133858270000000000
          Width = 427.123258470000000000
          Height = 15.118110240000000000
          DataField = 'DESCRI'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."DESCRI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 7.559060000000000000
          Top = 18.897650000000000000
          Width = 124.724490000000000000
          Height = 15.118110236220500000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."CODBAR"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo32: TfrxMemoView
          Left = 136.063080000000000000
          Top = 18.897650000000000000
          Width = 105.826840000000000000
          Height = 15.118110236220500000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."LOCFIS"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo33: TfrxMemoView
          Left = 245.669450000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 15.118110236220500000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."DESMAR"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo34: TfrxMemoView
          Left = 483.779840000000000000
          Top = 18.897650000000000000
          Width = 230.551330000000000000
          Height = 15.118110236220500000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."LOTITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 87.692307690000000000
          Top = 1.133858270000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSeparacao."CALCVO"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 604.724800000000000000
        Width = 718.110700000000000000
        object Memo19: TfrxMemoView
          Left = 7.559060000000000000
          Width = 411.968770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'P'#225'gina: [Page#] de [TotalPages#]       Impress'#227'o: [Date] [Time]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo20: TfrxMemoView
          Left = 532.913730000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'frmQckRomLoteSeparacao')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 115.036318150000000000
        Top = 170.078850000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxDBSeparacao."SEQUEN"'
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 115.036318150000000000
        end
        object Shape1: TfrxShapeView
          Left = 0.775193800000000000
          Top = 75.425025970000000000
          Width = 716.193676360000000000
          Height = 37.502301160000000000
          Fill.BackColor = 14211288
        end
        object frxDBSeparacaoNOMCLI: TfrxMemoView
          Left = 86.929190000000000000
          Top = 5.779530000000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          DataField = 'NOMCLI'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NOMCLI"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 7.559060000000000000
          Top = 5.779530000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object frxDBSeparacaoSEQUEN: TfrxMemoView
          Left = 618.142484190000000000
          Top = 5.128367210000000000
          Width = 86.639873020000000000
          Height = 60.765478840000000000
          DataField = 'SEQUEN'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBSeparacao."SEQUEN"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBSeparacaoNOMCID: TfrxMemoView
          Left = 86.929190000000000000
          Top = 22.456710000000000000
          Width = 517.795610000000000000
          Height = 15.118110240000000000
          DataField = 'NOMCID'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NOMCID"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.456710000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Cidade:')
          ParentFont = False
        end
        object frxDBSeparacaoNUMDOC: TfrxMemoView
          Left = 86.929190000000000000
          Top = 40.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DataField = 'NUMDOC'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NUMDOC"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 7.559060000000000000
          Top = 40.133890000000000000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Documento:')
          ParentFont = False
        end
        object frxDBSeparacaoESPDOC: TfrxMemoView
          Left = 204.094620000000000000
          Top = 40.133890000000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          DataField = 'ESPDOC'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."ESPDOC"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 185.196970000000000000
          Top = 40.133890000000000000
          Width = 15.118120000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            ' - ')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 6.008672400000000000
          Top = 76.973860700000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Embalagem')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 135.187111010000000000
          Top = 76.973860700000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          Left = 185.336771010000000000
          Top = 76.973860700000000000
          Width = 37.795300000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unid.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 228.470661010000000000
          Top = 76.973860700000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          Left = 287.445876390000000000
          Top = 76.204629930000000000
          Width = 423.277104620000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxDBSeparacaoNOMVEN: TfrxMemoView
          Left = 85.149660000000000000
          Top = 57.811070000000000000
          Width = 287.244280000000000000
          Height = 15.118110240000000000
          DataField = 'NOMVEN'
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NOMVEN"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 15.118120000000000000
          Top = 57.811070000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object edtDocFat: TfrxMemoView
          Left = 362.819110000000000000
          Top = 40.133890000000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBSeparacao."NUMFAT"]')
          ParentFont = False
        end
        object lblDocFat: TfrxMemoView
          Left = 249.448980000000000000
          Top = 40.133890000000000000
          Width = 109.606370000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Doc.Faturamento:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 6.008672400000000000
          Top = 94.452251710000000000
          Width = 124.724490000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo29: TfrxMemoView
          Left = 135.287886200000000000
          Top = 94.452251710000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Localiza'#231#227'o')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo30: TfrxMemoView
          Left = 244.894256200000000000
          Top = 94.452251710000000000
          Width = 230.551330000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Marca')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo35: TfrxMemoView
          Left = 483.004646200000000000
          Top = 94.452251710000000000
          Width = 230.551330000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Lote do Item')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo36: TfrxMemoView
          Left = 87.692307690000000000
          Top = 76.973860700000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vol')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        Child = frxReportSeparacao.ChdObs1
        PrintChildIfInvisible = True
        object frxDBSeparacaoVOLUME: TfrxMemoView
          Left = 75.708720000000000000
          Top = 3.000000000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxDBSeparacao."VOLUME">,MasterData1)]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 11.559060000000000000
          Top = 3.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Volumes:')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxDBSeparacaoPESLIQ: TfrxMemoView
          Left = 331.819110000000000000
          Top = 3.000000000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxDBSeparacao."PESLIQ">,MasterData1)]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo17: TfrxMemoView
          Left = 237.330860000000000000
          Top = 3.000000000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Peso L'#237'quido:')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxDBSeparacaoPESBRU: TfrxMemoView
          Left = 554.031850000000000000
          Top = 3.000000000000000000
          Width = 132.283464570000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[SUM(<frxDBSeparacao."PESBRU">,MasterData1)]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo18: TfrxMemoView
          Left = 470.102660000000000000
          Top = 3.000000000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Peso Bruto:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 22.677180000000000000
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 536.693260000000000000
        Width = 718.110700000000000000
        object Subreport1: TfrxSubreport
          Left = 7.559060000000000000
          Top = 22.000000000000100000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportSeparacao.Page2
        end
      end
      object ChdObs1: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 411.968770000000000000
        Width = 718.110700000000000000
        Child = frxReportSeparacao.ChdObs2
        PrintChildIfInvisible = True
        object mmoObs1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object ChdObs2: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 453.543600000000000000
        Width = 718.110700000000000000
        object mmoObs2: TfrxMemoView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 64.252010000000000000
        Width = 718.110700000000000000
        DataSet = frxDBSeparacaoVolumes
        DataSetName = 'frxDBSeparacaoVolumes'
        RowCount = 0
        object frxDBSeparacaoUNDVEN1: TfrxMemoView
          Left = 10.322820000000000000
          Top = 1.000000000000000000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          DataField = 'EMBALAGEM'
          DataSet = frxDBSeparacaoVolumes
          DataSetName = 'frxDBSeparacaoVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBSeparacaoVolumes."EMBALAGEM"]')
          ParentFont = False
        end
        object frxDBSeparacaoVOLUME1: TfrxMemoView
          Left = 147.606370000000000000
          Top = 0.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataField = 'VOLUMES'
          DataSet = frxDBSeparacaoVolumes
          DataSetName = 'frxDBSeparacaoVolumes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBSeparacaoVolumes."VOLUMES"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 21.126792400000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 10.322820000000000000
          Top = 3.000000000000000000
          Width = 154.960730000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RESUMO DOS VOLUMES')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 38.959931630000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        object Shape6: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 38.959931630000000000
        end
        object Memo21: TfrxMemoView
          Left = 10.322820000000000000
          Top = 2.779530000000000000
          Width = 128.504020000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DE VOLUMES')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 147.606370000000000000
          Top = 2.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBSeparacaoVolumes."VOLUMES">,MasterData2)]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 10.338590000000000000
          Top = 20.787401574803100000
          Width = 128.504020000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DE PESO')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 147.622140000000000000
          Top = 20.787401574803100000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          DataSet = frxDBSeparacao
          DataSetName = 'frxDBSeparacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBSeparacaoVolumes."PESO">,MasterData2)]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBSeparacaoVolumes: TfrxDBDataset
    UserName = 'frxDBSeparacaoVolumes'
    CloseDataSource = False
    DataSource = dtsSeparacaoVolumes
    BCDToCurrency = False
    Left = 344
    Top = 29
  end
  object dtsSeparacaoVolumes: TDataSource
    Left = 473
    Top = 29
  end
  object frxDBConferenciaVolumes: TfrxDBDataset
    UserName = 'frxDBConferenciaVolumes'
    CloseDataSource = False
    DataSource = dtsConferenciaVolumes
    BCDToCurrency = False
    Left = 344
    Top = 83
  end
  object dtsConferenciaVolumes: TDataSource
    Left = 473
    Top = 82
  end
  object dtsSeparacaoResumo: TDataSource
    Left = 252
    Top = 141
  end
  object frxDBSeparacaoResumo: TfrxDBDataset
    UserName = 'frxDBSeparacaoResumo'
    CloseDataSource = False
    DataSource = dtsSeparacaoResumo
    BCDToCurrency = False
    Left = 152
    Top = 141
  end
end
