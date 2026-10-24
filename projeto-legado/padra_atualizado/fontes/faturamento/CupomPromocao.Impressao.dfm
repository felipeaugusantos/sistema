object frmModeloCupomPromocao: TfrmModeloCupomPromocao
  Left = 0
  Top = 0
  ClientHeight = 94
  ClientWidth = 197
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object frxCupomPromo: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43915.366419259300000000
    ReportOptions.LastChange = 45363.623557546300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure Memo5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if Length(<CPF>) < 18 then'
      '  Begin'
      '    Memo5.Text := '#39'CPF: '#39' + <CPF>;    '
      '  End'
      '  Else'
      '    Memo5.Text := '#39'CNPJ: '#39' + <CPF>;                 '
      
        '                                                                ' +
        '            '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 32
    Top = 16
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 87.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      LeftMargin = 8.000000000000000000
      RightMargin = 2.000000000000000000
      TopMargin = 2.000000000000000000
      BottomMargin = 2.000000000000000000
      ColumnWidth = 4.800000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 291.023810000000000000
        Child = frxCupomPromo.Child1
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 294.803149610000000000
        Top = 64.252010000000000000
        Width = 291.023810000000000000
        object Memo1: TfrxMemoView
          Top = 9.118120000000000000
          Width = 268.346456690000000000
          Height = 64.252010000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CUPOM PROMOCIONAL'
            'REFERENTE AO DOCUMENTO'
            '[NUMDOC]-[ESPDOC]-[CODEMP]'
            'VENDEDOR:  [VENDEDOR]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo4: TfrxMemoView
          Top = 87.488250000000000000
          Width = 268.346456690000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME:  [NOME]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 114.842610000000000000
          Width = 268.346456690000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo5OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 131.196970000000000000
          Width = 268.346456692913000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RG: [RG]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 146.551330000000000000
          Width = 268.346456692913000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TELEFONE: [FONE]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Top = 189.700990000000000000
          Width = 268.346456690000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'QUAL EMPRESA SORTEIA PREMIO'
            'INCRIVEL PARA OS CLIENTES DA REGI'#195'O?'
            '(  ) MINAS TINTAS ( ) OUTROS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Top = 234.834880000000000000
          Width = 268.346456690000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONSULTE O REGULAMENTO DA LOJA')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Top = 270.543600000000000000
          Width = 268.346456692913000000
          Height = 15.118107800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA/HORARIO: [DTACUP] [HORCUP]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Top = 282.086890000000000000
          Width = 268.346456692913000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-----------')
        end
        object Memo3: TfrxMemoView
          Top = 161.889920000000000000
          Width = 268.346456692913000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O:  [ENDERE], [NUM]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '-------------------------')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Top = 71.370130000000000000
          Width = 268.346456692913000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CODIGO: [CODCLI]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Top = 253.228510000000000000
          Width = 268.346456692913000000
          Height = 15.118107800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CUPOM: [CUPOM]')
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
end
