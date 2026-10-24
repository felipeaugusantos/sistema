object frmRelatorioSerasaPowerCurve: TfrmRelatorioSerasaPowerCurve
  Left = 0
  Top = 0
  Caption = 'frmRelatorioSerasaPowerCurve'
  ClientHeight = 266
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelatorioPFConsultaSPC: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44972.551269780100000000
    ReportOptions.LastChange = 44972.551269780100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 136
    Datasets = <>
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
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 58.527520000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPFConsultaSPC.ChildIdentificacao
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 20.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Serasa PowerCurve Cr'#233'dito')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baCenter
          Left = 89.688405000000000000
          Width = 538.733890000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nome da empresa')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 665.847620000000000000
          Top = 20.118120000000000000
          Width = 48.302350000000000000
          Height = 17.007874020000000000
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
        object Memo54: TfrxMemoView
          Left = 602.945270000000000000
          Top = 20.118120000000000000
          Width = 60.547990000000000000
          Height = 17.007874020000000000
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
      end
      object ChildIdentificacao: TfrxChild
        FillType = ftBrush
        Height = 238.110390000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPFConsultaSPC.ChildAnotacoesNegativa
        object Memo2: TfrxMemoView
          Align = baWidth
          Top = 30.456692910000000000
          Width = 302.362400000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Raz'#227'o Social')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 302.362400000000000000
          Top = 30.456692910000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CPF')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 442.205010000000000000
          Top = 30.456710000000000000
          Width = 117.165430000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data de Nasci.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 559.370440000000000000
          Top = 30.456710000000000000
          Width = 158.740260000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'UF / Munic'#237'pio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baWidth
          Top = 53.133858270000000000
          Width = 302.362400000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Citel Software')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 302.362400000000000000
          Top = 53.133858270000000000
          Width = 139.842610000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '51.212.892/0001-25')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 442.205010000000000000
          Top = 53.133890000000000000
          Width = 117.165430000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '18/04/1979')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 559.370440000000000000
          Top = 53.133890000000000000
          Width = 158.740260000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'SP / Ribeir'#227'o Preto')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            ' Identifica'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baWidth
          Top = 76.590600000000000000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            ' Status do Documento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 107.385900000000000000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'Situa'#231#227'o do CPF em 15/02/2023:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 192.756030000000000000
          Top = 107.385900000000000000
          Width = 525.354670000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            'Ativa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Align = baWidth
          Top = 130.504020000000000000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Informa'#231#245'es da proposta')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Align = baWidth
          Top = 160.960730000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            'Valor Solicitado')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Align = baLeft
          Left = 109.606370000000000000
          Top = 160.960730000000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            'Limite Sugerido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Align = baWidth
          Top = 183.637895360000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '32532')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Align = baLeft
          Left = 109.606370000000000000
          Top = 183.637895360000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '65465')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildAnotacoesNegativa: TfrxChild
        FillType = ftBrush
        Height = 279.685220000000000000
        Top = 362.834880000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPFConsultaSPC.ChildScore
        object Memo13: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' Anota'#231#245'es Negativas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          Top = 30.236240000000000000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '     Resumo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Align = baWidth
          Top = 60.472480000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Ocorr'#234'ncias')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 60.472480000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 60.472497090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 60.472497090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 604.724455826772000000
          Top = 60.472480000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Align = baWidth
          Top = 83.149660000000000000
          Width = 268.346456690000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Pend'#234'ncias Comerciais (PEFIN)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 268.346456690000000000
          Top = 83.149660000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Left = 340.157526690000000000
          Top = 83.149677090000000000
          Width = 151.181102360000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '15/12/2023 '#225' 15/12/2023')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 491.338629050000000000
          Top = 83.149677090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '12,66')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 604.724455820000000000
          Top = 83.149660000000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baWidth
          Top = 105.826840000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Pend'#234'ncias Banc'#225'rias (REFIN)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 105.826840000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 105.826857090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 105.826857090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 604.724455825118000000
          Top = 105.826840000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Align = baWidth
          Top = 128.504020000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Cheques sem fundos')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 128.504020000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 128.504037090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 128.504037090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 604.724455826772000000
          Top = 128.504020000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Align = baWidth
          Top = 151.181200000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Protestos')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 151.181200000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 151.181217090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 151.181217090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Left = 604.724455826772000000
          Top = 151.181200000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Align = baWidth
          Top = 173.858380000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'A'#231#245'es Judiciais')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 173.858380000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 173.858397090000000000
          Width = 151.181102360000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 491.338629052913000000
          Top = 173.858397090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Left = 604.724455824567000000
          Top = 173.858380000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Align = baWidth
          Top = 196.535560000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Participa'#231#227'o em Fal'#234'ncias')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 196.535560000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 196.535577090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 196.535577090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Align = baLeft
          Left = 604.724455826772000000
          Top = 196.535560000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Align = baWidth
          Top = 219.212740000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'D'#237'vidas Vencidas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 219.212740000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 219.212757090000000000
          Width = 151.181102362205000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Align = baLeft
          Left = 491.338629055118000000
          Top = 219.212757090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Align = baLeft
          Left = 604.724455826772000000
          Top = 219.212740000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Align = baWidth
          Top = 241.889920000000000000
          Width = 268.346456692913000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Fal'#234'ncia/Concordata/Recupera'#231#227'o Judicial')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Align = baLeft
          Left = 268.346456692913000000
          Top = 241.889920000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo61: TfrxMemoView
          Align = baLeft
          Left = 340.157526692913000000
          Top = 241.889937090000000000
          Width = 151.181102360000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Per'#237'odo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Align = baLeft
          Left = 491.338629052913000000
          Top = 241.889937090000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Align = baLeft
          Left = 604.724455824567000000
          Top = 241.889920000000000000
          Width = 113.385826771654000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Mais Recente')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildScore: TfrxChild
        FillType = ftBrush
        Height = 220.307050000000000000
        Top = 665.197280000000000000
        Width = 718.110700000000000000
        object Picture1: TfrxPictureView
          Left = 3.779530000000000000
          Top = 23.456710000000000000
          Width = 311.653370000000000000
          Height = 177.952690000000000000
          Center = True
          Picture.Data = {
            0A544A504547496D61676500D50000FFD8FFE000104A46494600010101006000
            600000FFE1003A4578696600004D4D002A000000080003510000040000000100
            0000035101000300000001000000005104000100000001FF00000000000000FF
            DB00430002010102010102020202020202020305030303030306040403050706
            07070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E
            0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0CFFC000110800EF01E603012200021101031101FFC4001F
            0000010501010101010100000000000000000102030405060708090A0BFFC400
            B5100002010303020403050504040000017D0102030004110512213141061351
            6107227114328191A1082342B1C11552D1F02433627282090A161718191A2526
            2728292A3435363738393A434445464748494A535455565758595A6364656667
            68696A737475767778797A838485868788898A92939495969798999AA2A3A4A5
            A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DA
            E1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101
            010101010000000000000102030405060708090A0BFFC400B511000201020404
            0304070504040001027700010203110405213106124151076171132232810814
            4291A1B1C109233352F0156272D10A162434E125F11718191A262728292A3536
            3738393A434445464748494A535455565758595A636465666768696A73747576
            7778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2
            B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7
            E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDFCA28A2800
            A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
            A28A2800A2992DC470292EEAA07A9AE23C53FB467853C2F136ED492F248C9DC9
            68A67DB8DFBB257217051C7247231D4807C5CDF8932BCAE9BAB9862214D7F7A4
            91D387C1D7C44B96841C9F92B9DD50CC147271F5AF9F7C47FB65DD5C94874BD2
            EDE03208DBCE9E6120DACCABC05207249C65C640E031CA8E0FC43F1E7C59E2C8
            5D4EAD710C738242D9831A1CACA3E560A1803853FEB3FBBF374DFF0087F117D2
            6B84B2E6E18572AF25FCAACAFEAEC8FABC1F01E675973544A0BCDFE8AE7D697F
            AD5A6996ED2DC5C430C6BC96770AA3F13C572FAAFED01E11D22558E4D6AD2469
            31B3C92660D97D8395C8FBDC7B1AF926F6F66D6EF9A4B8926BC6DC246F3B7B6C
            F30AE4ED6048DC1A41C86E0B0DEB8C0AF6D707CA5C5CE0B6CE44ABBB2C41240D
            E54F128EB9390A4EFF0096BF1DCDBE9738F9E996E0A31F39B6FF002B7F5D0FA6
            C2F86F4AD7AF55BF24ADE9DFE7F8773E9CD53F6B8F0D59CFB218F53BADCC1559
            6D8A06F9431C6F2A4E01E801390C30769C61DC7EDA16C4E6DF41BD954B2AE1E4
            0AE99DBCB85DC171B8704E71CE31CD7CFEAA046BE546C1532A563DE188DC4797
            95E32BBB68F9C2825CF1B000EB7DB2EC4578D954A1548F942331F2AA19C00005
            6FBA30245E54EE35F9EE3BE935C6D5F5A55214FF00C304FF00F4ABFF005E47B5
            4780B2A87C49CBD5F9F95BFABF95BDAAEFF6D3BCD8248F458E3899721FCFF3BA
            98F6F4500921DB852724719208AAB27ED87AE79C4AE99671C6B8F94A4D23705C
            30C803380B9071F3640C0CA93E3C88FBD362B4770AA84E436E5E5572F852D824
            7F7F0C225E4A962119A2DBBB217E457CE55D883B42B0387DCDD3193966897008
            C9AF9BADE3C71CD47778E92D7B2FF25DBFCB53BA1C1B942492A3F8BF2F33D72E
            3F6C2F105BC0DBEC74F8DBE61831CDB55B90A33D5B254FA755C64904DA8BF6C3
            D694EE6D26CE64DCE0796CDC952DC7CBBCF2170410305863711B4F8CC56F8998
            2A18BCB5C308C72AA720E36EC7C7C9B47073B6361CA9A2E15B7348F1AAC8CFD7
            68CEECF00168F19C800127931C5CFCD58C7C72E364F4C7CBF0FF002B7DF6DD69
            62BFD50CA76F64BF1FF3FEBEE3DBADBF6D6B849FCBB8D0E16F9F63325E852B97
            DA06D29938DD19271821B23B03AB61FB69E9B23FFA5693A840839764024F2F24
            050470771C8F97EF7CEBC1E76FCFD149E5C319B7DD2246146D8D8B21C36EE141
            217395DA0B81B5CEE185C5344B96876B22AAA048D95555392806DE41D99D8DC3
            3641653CED15EB60FE911C7345FBD8BE65E718FE76BDBEFF00974E7A9C11944F
            6A76F9CBFCEC7D41A4FED6DE14BE855AE24BCB37381B1E032B07DAC4A7EEB78D
            CBB4E4678F7AEA34CF8CDE19D5DB6C3AC5986FEEC92089BB91C360E0E0E0F438
            3E86BE390C259B69559329E5947CF3B72BB1B192D8F314337CEB90D90A698ABE
            6CFE5AED2D264B091554B96C1F987C8C73B0390320E24523E515F6D96FD2BB89
            A8CAD8BA34EA2F4717F837F93F5D0F26BF8738196B4A728FDCD7E5FAF9F91F76
            477B0CAB959148F5CD4A0E6BE1DD17C457DA34EDF61BFBCB195B8578643BC02E
            18EE5C82722419DC9C1196270A4F61A0FED33E2BD049692F63BA8630A1D6E937
            2C408049CA2ABF1B93FD61C90A49C7DEAFD4B21FA5A6535DA8667859D37DE2F9
            95FF000D3EF3E7B19E1CE2E0AF87A8A5EAACFE5BFE9F71F59515E1FE18FDB161
            91962D5F47BAB693E51985C485C92B93B4E303E752482C01DC320005BD23C1FF
            00197C37E3A2ABA6EA96F349202562DDB64600E0B056C12BC1C301838E0D7EE9
            C37E2C70AE7968E03171E67F65BE597DCCF92C770FE6183BBAF49A5DD6ABEF57
            47514536395651F2B06FA53ABF448CE325CD177478E145145500514514005145
            1400514514005145140051451400514514005145140051451400514514005145
            140051451400514514005145140051451400514514005145140051451400504E
            0573FE37F89BA3F802D4BEA174AB215CA4318F3257E7030839C678CF41DC8AF0
            AF1D7ED5BAB789E55874755D2ECE46501D658E49E40407C16E554ECDC0850C4E
            E421C7247E67C71E2D70EF0BC1FF0068564EA74847593F974F99EEE53C3B8DCC
            1DE8C7DDEADE88F77F18FC4BD0FC07017D5350B7B76C6E1103BE671FECC6B976
            3ECA09AF22F1CFED83711B04D174BF2E342C65B8BC3D02E49015582FCCA06D62
            E00248232003E2171AA5D5CA3497534D7131092CCD31F9DD8124B316660BF75F
            E638520A00DF28351C50012288953319F2FCC8D49F9870CD928DCE6473CB1E54
            F3CBE3F8E78D7E9419FE652951C962B0F4FBEF36B4EB6D3E5D5EE7E9B95F0060
            E87BD8A7ED25DB65FE66CF8BBE206B9E2C27FB6354B8B8F9725666115BEE0243
            958C7EED400AA41C3B05032339638F2B35BAB6E0DB172D1EF2C146D720201823
            9DB180A101E4952C4925814C11AC8ABF67F2C290E50A2443E4382446A768C8E3
            70C884671F3E1D244F19DC9148B22818F94EFCE3A13FC5FF002C813E661B69C9
            014E7F9CB34CE31F98D5FAC63EB4AA49EADB6DDFBDB75F768B43EDF0F85A3422
            A1462A2BB256058DFCF6897CD6CEE21158A3BF2C091F7073C92467E6914F0029
            2322DCAF2BE73670C0C47072A0E1B21D979908C1DBB5247E30B922ED795B059A
            26C3AB28F318A85E1D7272E46D88EE2AF827009CF0E4B6954FCB0B6E8B004621
            6DAAC0B08F076A0215C90031C0015F23927CE8C2529251D7FAFF0081D1B56B9B
            7325ABF222963DD1B2B292B28382F10EA7D03054566DC47424B4841F9508A9CE
            FB956DA6431DC64A9552EAC85D8673F38C6D7561C0CE067E5042A8D2E4B693F7
            71BA792A3E610804281B0E3603B98EDDDB769188D41553834CB9D364656DD6E7
            73296DBE587DA184C71C44C09F9BB13DFAE7E7D3EAF51ABA5FE7FD75BDBF461C
            C9ECC8EE4F9917EF36AB2A1626507F760B0058F04A8DD9230F8FDD2956C02438
            C9E7EE059594B6191D8301B8B2E187998237395C7731B003EE8124FA7CDB6465
            864C6E936614F07F7BC8C6304E473F2673F7DB232FB9B69D919C2CDD1C46F860
            F83971FC2ECB82AAB83C1E46DFBAA4FABD5F8631FEBD34EABCFCF6775CEB6441
            1AAC676B248AAAC2590CA76ECC105B72E0A8398DDB7E157246D3925A8B52EB24
            3F33AB31562BCAFF007371DBB47532392761E7AB21000926D3E6F9B6C327572B
            852BF37EFB38E170791CFC99FF009E8D4F6B46FB649BE36786470AFB90857C92
            9839DAA796C701B2B18E4964A161EA5DDA2FFAB69D3FAFBC39A2568A3F34430E
            D65755185D9B9D0965058828D825F2D92C413129C91B8822DB88E4844316E236
            EC652230785525401D0C3F2EFCB0518240F9A64D3A7915A3649B6B00B20D8DB4
            16C2138D814F265639420F04951B69520B82FE779326F863326D68DCF39E4646
            4FCC778DA37AE11187F086AFABD5DF95FF005FD5B4F96DAD73222F9A45B79155
            7E60BB19FE6CE0FEEC921B0D8320EAFC942557273492A9D922AA49E5CCAC9F32
            92CD9080677ED524A850376E3B9C8E8AD5249A79591BE59182B60C8B1959303A
            90563EA7F7BF74F5718237AE156CE449159A27591583BEC89B74848527E705B8
            183F28EBB517EEE0B4FD5EAAD795FDDFA6BAF7FE909496E46F32CD0BB6E69236
            755C0932B26E673B4E59970C8C301800772F20950AD2FBAD9D7CC8FCB9232CE7
            0AB19044A77606E50A7AE4819E32CC72B530B6B853BB64ACD1A050E55E4655CF
            4C92A4FCD8E8096541924B2D2CB67298DC88E4E4B15650C08E64271B54904838
            2428386E19895C9F57A9B59FF5FE5FE7ADEC1CCBFAFEBE645349E5AB67746B26
            595597CB04E4B82772EDE0307271B818CE77E0E058D5B6C31EC5D85C2ED2CFE5
            8CC883E55CEDC160010CA701BEE8420493DA4B11CB8937676B840DBCE4F1D093
            C8F3991770200E158AF0D94CCAED95DDE5EE2410660082ADBB683C1C90C0162C
            15405009389953946DCC9AF5F5FEBB7F98A49AB21AB179EDFEABCB1315670232
            31F346DD4C79E0B39CE41C96E873B00F218B6B1B91B53CC400B0CB28E1F0D963
            8C47C05203373B8E4844B5560D1C6A3F76084DAB1B30236C6A4ED53B46E8C9E1
            4E3CB19202EDA6CA56D6362A16159016404796015C95CEE5DA36A953D370F2B1
            F3E0E269C9C1A707F9FF005E7BF55B0F953D3FAF9FC8EB7C25F1CBC43E057DB6
            FA999EDE156021BA916655C171D5A5DC3E58B18C8008CF1F38AF5EF067ED7DA5
            DE491C3ADC274F2C594CE84C90E577E727191C2138F9B1D091C13F3B17F20CAB
            1B2AAC3BB187F9142E7A7CE836AED8C1C0C0C9049DCC44AD1307C62E55B2C9BB
            E6040DF1804361BB007AED241DC3EF6DFD5384BC67E2AE1E946386C4B9C17D89
            DE51B2F5D56BDB7BDB73E7332E15CB71BFC485A5DE3A3FF2FBD1F6E68BE24B1F
            10D84775677505CC130DCB244E1D1873C82382383CD5EAF87FC31E29BEF086AB
            F6AD3EEAE2C6E37096444739604C6E576B2E5B21641B4A312148CAE303D9BE1C
            7ED672279367E22B590B0217ED96D03796FF003EC194E597B31238C1C8C8048F
            EB8E04FA4F64D99F26173C8FD5EABB2BEF06FD7A7E87E6D9BF01E2F0CBDA61BD
            F8F6EABFCF43DEA8ACFF000EF8AB4FF15E970DEE9F750DD5ADC2EE8E58DB2AC3
            2475F518E476AD0AFE9BC2632862A92AD869A945EA9A7747C2CE1284B964ACD0
            514515D248514514005145140051451400514514005145140051451400514514
            00514514005145140051451400514514005145140051451400514D9255863677
            65555196627000F535F2DFEDEBFF000556F03FEC576971A4C4D0F89BC72A8CC9
            A2C33855B61E586125D4A32204F981F986E60AF85C02C33AB5614E3CF51D91EA
            E4D9263B36C5470597D3752A4B64BFAD3E67D11F11FE297873E0FF0085AE35CF
            14EB9A5F87F49B452F2DD5F5C2C31A0E3BB1F71D3D6BF2E7F6DCFF0082F4EA9E
            27FB7787FE0F46FA3E9E57CA7F115CC4AD76E495E6DE06C9504F00C8BBC8703C
            B562B9F8B7F69FFDB07E217ED7DE374D53C67AC4B70B6AE8B61A7C51ECB4B0DC
            3E4F2A17270ECA4EE327CF8077383B48F298936C21236B65792386357DB848C3
            C6630EBD11902AB1CB63798557E60C8A9F21987104E7EE61FDD5DFAEBF7DBD7E
            EE87F6BF86FF0046DC1603931DC4D6AB5746A9ABF245F44DE9CCEFE76ED747D8
            FF00F04FEFDAC758F14F8E352F0AF8D35ABAD62FF579A4BFB4BED42EBCEB86BA
            672658BCD909391867F9582860EA1F286BED74992E8EE89A295599594EECBC80
            9122E570CC02EF41CE36EF6385C2D7E37E93AEDDF87357B5D52C259ACEE2CEE5
            2EEDE558D375B9138941E415E1844BC7CABB8499756247EA77ECCFF1B22F8F7F
            07B4CD721DD1DD379A97310CB9B6B94C89C7CB97E19D8839527E41904B63F883
            E903C1728D78E7F455D49DA7D6CEDBB7FE7AAB3D763DCF14F8469E02AC31D838
            28D3968E2B4516BADBB35B6D6D6EAE7A0DAAA8709B73CA1552147DD31FCC540C
            E76EC3CA02A411B802A69BFF001F56F1AB32FEF906D324AA53FD584C8DC1CE49
            9147CA5871D492432CAEB14591E588D46F546C7971322C98503705CAEC5C80C4
            657385FBD523E6DAE1B6BCCBF26C5639DCC0671CE32EC01908521C1DAA7209C9
            FE5FBE977FD69FD79EBDEE7E4047B567958ED2872CFF0022AAC9B77062781BC3
            6D908002820B364E583526D5B93B5843E7484E4809BB710073FBC2DC32B1C290
            4793807E51B9D1482181C7EED16150CCBB86C8CA9040FBCFB5437983207017A8
            D809165F22CC05FBB0FCCCA5D060295C71CAAE046EB9CA2EE56E99043D756B7F
            EB5F97C9EBB86BF64557FB44D236D5956E177056248946D00676F047EF157215
            C054E4938DB248AF2793B557CA2913A92A64F9CEF3B9829099DE549DB9F5381B
            58468144CB186136D7009C1218A98413DC92083C9DF823975ECEB9688984B986
            3DD123E7746CCBFBB8C072CE4FF719FAB67CB07771B6B586B4A76F25F9FF004B
            7DB5D1691BB561D656325FB2C56D69717123465E28A005D8F0DCE559DB2C640B
            BD464B772194559D4B41D4B40919AFAD2FADF9257CE85E2F3586547DD00FCC63
            5E4A11C3282C196BA1F847E38BBF075CEAB0E9F6B24DAC6AD17D9AD301552DE5
            62FB588DB96064738670A3087D496EF3E26DDEA9A4FC029ADFC505AE356BAB96
            36D828CD1C6A7EF12A0A9FDDE701B77DE1BC90188FD6384FC3FCB739CA6A6315
            692AB18C9BB46F08DACD293BEEFA69F27D3E5F32CEB1387C62A3CA9A93496AB9
            9DFAA5D12EADBF3BAD0F21D1FC3BA87886693EC36379A879732A48F1C45955C6
            797DA8719F2A3E4A7CBBF2AC4600A6035B3C7E6C6D1CA8A9B90AED98B1D995C6
            E2CE711364AB1040007998AF64F899E24BFF00835E0EF0BD8E933C9A795B696E
            6F248C45CBE14B6FDCACA012D2BF652CA0640C03B1AD784E1F16FC4FF06EA934
            3FF217B17B9BC555255DD1612BC1057041C107921176F4727DA8784385AD0FAA
            61B10DE260A9CA71E55CBCB3B6CEEEED69BAB3BDD79F1FFAD1561FBE9C17B297
            372B4F5F76FAB5D13B69AFDFB9E1E7C2DA9E9F630DCBE9B7C2DC28D92AC24C64
            2B441B6B2E063E5270366403FBB620D53853CB10B6E52AA562574394E0C2A543
            0C003208C0D99C7DC6AF70F08FC4FD5BC4BF1AB51D1EF3CABCD16EA69ACC5BF9
            09E54712F9BB1B96CB06540091B812DC60642791F89F416B2F18EA3A65BACD2F
            D8EEE7821059A695FF0078E91E7E724677119523EEF263C141F2FC65C0F81CBF
            02B1B965575231A8E94AEADEFAEAACDE8EFA6FAF9591E96539D56AD59D1C4C54
            5F2A9AB6BA3EFA2D53D3CFF3C91189708CDE6799184C86F3378F946436DCBA81
            2B750EA70092A73562CF4BBCD72D9BC8B6BCBC8D44734DE446D2EC46C1DD8566
            DA37172183023CB180CA84D5BD47C23ACE9B6D25D5D69BA85A42AA9234D3C3E5
            C28CD9DAC59954021846A0B0671B4650672DA7F0FBE275F7C3BB3D57FB2ED435
            D6A30AC4B308CB4D0329211CAB654B05914E1C8241C9C05DB5F2397E4F46963A
            9D1CEF9A8D396ED46F2D3B2BABEBF97A9EA57C64E545CB0769C95BAE8B6DDF97
            96BE465C9E1BD56D924926B3BF8446C919764640AEEC54FF001303B7F7870415
            E1467319C43A3E87A96B16CD258DADDDD5BC6B1B66DD1DD23DC4285E0A0F9580
            1B76E76A30EB262BD7BC45E37D623F80FE76AD78D7775E24BA5B7B7236058ED9
            987CDF22A12ACBC1FF00AE830C4E329F163C71A9FC2ABFD0343D12E3C986CED6
            19E78D123DD7ACCED80D9CBA82D09DCDC8DAEFF78E5A3FD7311E17649469FD72
            7899AA5184272BC1732E77682B7359DD5DEADD969E4BE629F116324FD8AA6B9D
            B696BA3E5B5DFC377AE9D35F99E312B67742D26C922CE44CFB5ADBEF212DB98B
            E0295E531B8B021B0C48B9A9E857FA75BC5717B63A858A4C3719654655915886
            FBE095C22B38CEF01482429052BDE1BC2561ADFC7DD26FE38EDD61934B3AA04D
            8C565977EDDF83F2A9C3A907863F375E7187F0A3E245FF00C4FF0017EA9A3EB3
            20B8D3754B595E1845B6D58D72846370DCB85915704637264E19B156FC1EC0D0
            ADEC7198992F6D374E8DA3BE89A94B5565AABEEEFA2BA27FD6BAD38F3D2A6BDC
            8F34EEF6BBB5969ADBCEDF91E331F991C8DE5B1DCB213F217550D93B90E14A9F
            99F6938070493CA668B931CFA7C2D27DE8E231BB480B30FE0FBAC1F0CCB26403
            F39C2839F9B136A36DF67D6EE21DAB234770546F1B77B0F35D41E4F2320FF176
            608A0835197FB3D847B7CE51B4AA8C30CB0F2CAE1329FC0BB8A2A91C30E0E437
            E218AC23C1E26B6167BC2EBEE76EEFA7E6CFB3A73552319DB7B3FBD7F5F3219A
            40F13798A8CE031224752A0846DCBB59CFF11906015C0420B6146E5982DAC8C7
            F78ABF30720884C80024F384C93B663C310A583E3046D7C927D925DACD22AA31
            F9DA470A4065EECC3A2A3E71BB2016E8DB5A2F3D615563E5868C7CCDBD158850
            A5B277962C4C6CBCB01846DC5828CF9B7D6FFD7E5FF03646F1D4B0DE747247E6
            076689B78DB116E49C92387EA04980082032AE01208AF1C31C7026F8E365C88A
            41E586C601408AC7E4E4ABAE309FEB31F293865F2C293B76CED1EE3BB8F98A08
            B7632ACEC772A8E0B11DCEE0AA11488A38CC2C9208C144752307A6CE8C02E711
            6155807DC72A3A8169FD7F5FF0D6145597F5FD7EBF88F8170235F336AC843196
            376DA4B2A93CF0872FB08207CC5986DFBC69B2C2AF1B34AA238DB3B9DA3F9501
            FBDD62EDE731E7FBBCF5931284116A18F2F82FB54E0A31CBB31C1CA8E4824ED0
            72B1E493B96A25876A2FCAA8CDB104851936663D98E557182E0809B0FCCC0004
            10C46D7B7F5FA76FBFA845EA5ED17C7F7DF0FCC9A95AEA1FD9E618E59657250A
            9D8A858B2EE667DACA576EE0A06413C293DB7ECF5FF054EF08FC48D5E4D2FC4A
            BFF08DDC2CAC90DE4D229B39C7552CF9C44DB41383907070D9214FCB9FB557C4
            EFB0E9F1E81A7DD28BBD412492F82161884A831F99C285C8FBC4F2A8A324AE41
            F9F91CC938DBB6478C16811D30D9555287E6C03D46405DAC40071E63327F63F8
            0388CE329C0BC654A92F6727A41EB1F5B74D36FBD2D4FE51F1978FA186CCE183
            C0A8B943E37F859F5D3CADAE8FCFF732DAEE3BC4DD1B2BA838C8FF003F43EE08
            3D0D495F947FB2B7EDE5E2CFD9B658F4F9A7975CF09C6C7FD06E599E4B28F12B
            2F9521F9C2ED5CED6455FBE4AA64CA3F48BE07FED15E19F8FDE185D4B42BE466
            8D47DAACE43B6EB4F7E729327F01055867254E382722BFB2725E24C2E60B962E
            D3EABFC8F9FC8F8A70998C7962F967D53FD3B9DD514515F447D3051451400514
            5140051451400514514005145140051451400514514005145140051451400514
            5140051451400557D4F55B7D22D249AE268A18E243212F22A0C0C64E58803A81
            9240E45667C40F88BA27C2EF0A5FEB5AF6A9A7E91A6E9B179B717379388A2897
            9C163D8120F63D0F5AFC64FF0082947FC15A7C41FB576A179E11F06DC6A1E1EF
            87225952470EF0DDEBF1A8601E5DA428B75CB130F0594A97DCE1547163B30A58
            4873D4F92EAFFAEE7E83E1FF008739AF15E3561F0516A9A6B9E6D3E58AFD5DB6
            5D4F70FF008293FF00C16D8DAFF697827E0DDE379C8B2C17BE2E8CE62007256C
            C02C091855F3DC632C020F98357E64DF6B379ADEBAF757579717579737C93C97
            13CDE63CAD23E18B3B0CB3021F2DBB0CED805BCCF28518832246615DE76160A5
            F9276155192194B2363E66190A72E37052E1FF0054CB1ACD2C6D9689B24BB199
            0AA9224E325410A48059CEC2FB9A52DF018ECC2B62E779BD3B74FEBFAE9A7FA2
            FC03E1BE51C2783F638185EA7DB9BF8A4FAFA75B25A75D3AB6DD545BC31B0C46
            D6E40461F7C9FDD3E4B6406CED04302376E12282E8039D9955A3F2D7CE8D9242
            8C8577CA44670016F33FD6B07E08C943B8066F319C2364DCB1EDDCE3C94CB7EE
            DB32B18C6492AE9891C066EACC382FF2C6B0A2BCDE42EE685A68E36421D58AA8
            DEE0A633975F9B68CB64007846F2FCFBDB5FF87E9FD27F3EC8FD0ADEF72FF5DF
            4FEBAF98D748EE246F25A26563288E5DA39004986E73BB7C6CED9E589691D415
            639F73FD82FF006825F83DF14E4B0D4A62BA0F880C70DD40EA7F71301E487041
            25777FA93905B186C90A36F85293A95B8691BCE79A306461865C48A5BCBDC99D
            CC4C83637CA50B6780EA922CC1E62CBE5CD31698EE8F952ECEB2175CF07CDC7C
            A76F45C329D9BA3AF2F3CC9E866582A982C46B19A6BFC9AF4D1F4EE7999B6554
            732C1CF095F69AFC7A35E69DB5F3EAD9FB370DEA831CFE62EDDCC3793B55F046
            EE771C85CCA40DD8183856001A48A35487CB60BFBC52BB546E25506C2085C83B
            46ECA6CD9B9D40E793E13FB05FED18DF1A3E1A476B7F334DE22D04A59DD34926
            D6BC058B41312188C48BD4F3968E5C292FF37BB33E6191B779D1CCB90CCB859F
            A2E385218BED8C60AE70E76161C0FF0037F8A787EBE4B99D4CBEB2D62EC9F75D
            2DF2DEF7DB4DCFE32CD72DAD97E2EA60EB2F7A2ECFCF5D2DE4F7FC89111AEA25
            DDE633337F086F90E543E18338523748A71838E32026EA36C93EDCEE56720E4A
            C8E80EEDC1B63292304AF1B8100B0CFEEC10C91962DACEDB922C65890C3726E2
            C14B9C2E4C4B9F9988C6485396A58AD562995447FEACA061B541237A2838D99E
            4459CE02FA1C0057E76DDFFAFEBFE1B6B1E6FA8E0649D02FEFD55F6160C5E4C1
            1B307E78C9C82C0F3DE304E3E7C3AF2E089B7965B7322ACA433050A4AA9C91B9
            091F2FF12E488A41DC01563DA2DD1A31199142045DB1B36EC0E026C0786880E7
            6630E7E50AA45B6DB242F35BCD0EC863DC63136DF2C0036C870F86DE50B1DC57
            76F249C96DDD14E2DC2515BD97DDF76FE7BFE24CAD16AFE9F97F91BFF0F7C0E9
            E3BBF9A28F54B5D2EEA352D0ACAC9BA4676653B38DA24462C1880D9DCA1B3B81
            1DE78B275F01FC10BCD1750D62D6FB55D46659ADE086669A341B9262A19407DA
            4719C104107630DC0F93CBA4F9D238755918950CAEA8CCC1888C92021386553C
            F70C41C0C6231612246FF752E2521995B63798CA37039380C4B464E06CE1C93B
            4E0D7E89C33C690C9305528D0C25EBCE2E2E6E4ECD3DDB8ECF47BBEB63E7F1F9
            44B19594AAD5F7134ED65756D77DEDFF000D73D6F54D22CFE35F847C3B3D9EA9
            636BA868F1359DC4773208C611E32F228C3E30622C3D470C41195975CF8A3A5F
            867E2B7866D6D6E1A4D3743B3363248FB9F7EEDA9924923F854860BB9CAB00D8
            E1BC867D299D5A3D91A3C848024641BC859157921C96DBB725BB007D54905AF9
            45592686386490C8A827C09034A58B0DA4824EE53924839DB84DDCFBD2F16F1D
            1A4AA61B0D18E21A8295457F794365CAF44F4D7EFE9638D70CD293E5A951CA9F
            BD68F6E6DFEEE9D8F64D07C2DA4F843E24DFF8BA6D7343B8D2D7CEBCB54B7941
            9E4926776002F4E92301866DECE302304A9F23D6F547D7BC4D7176EB12CF35EC
            972CA8CC159CCCC46D47218855576C9F949CB00FDABDBDA3186347923FDD8859
            43CA70A4BE01018B10C428C02A0E4B00C49621B6B63304C217561179BB524DD2
            02DBF190C57E6258E0B29CECCB1C91B7C0E2CE38AB9B6196170B86F611E77525
            66DB94DADEFBAB6E9795FA6BDD96E4EB0D5255AAD4E7959455D2D12E9F89A9AA
            7C45D775ED30DA5D6AD78F14C4218FCD7DA59B0C0373BFE5560470A7F7649201
            AABE16D2A0F156B9636324D6D05BDECA21769767971C257748B925D798B1B540
            019D41C14248823B06F3957743B640621E5CA1795CE5432853F2832003078453
            F29A44B692EE3FDF18DD59955D9EE1595D83A2950BC8249427EEA9C90000C5B1
            F212CCB1B5B150AF8EE6AAA0D6926F549DEDBBB2FE96B6BFA9F57A50A72A742D
            1BAE96DDAB276EA765F1DBC656FE28F1D5BDADA35AFF006768A896B0849401B8
            950C5007017861F37500C640CF5EAFC63A2E9BF1E2DB41D5A3D634CB19A2B748
            2F639DCC72C04105B67232CA5A4F94E577AA1041439F204B4B896C9576ABAB46
            D1B2ACAACA58B32B6EDD9F9B38249F331871D4E59E217591995A15DCE417320F
            9CACA4AA9386E8C400323EF310010057E8187F123132C6E26AE330EAAD2AF64E
            1769479758D9ABB5FAB3C4970FC234E9430F539674DBB4959BD77B9ECB37C6DD
            2E1F8E96F3477319D256C96C45D898790EAC7CCF341F3029524607CA4811B9CE
            D6150F84FC3DA6FC0ED6755F104DAD69B3D9FD9644D36CEDE7446BB1C6D5C70B
            B95610A0A9DBCC87E55185F1F8F4F78A59159D55B2BE612FE5BC8199D4728FDF
            21870016248018FCA7D926551FBC8E1997616DF224632D80385C92A4FCB8DE37
            1882E48C9AF569F8BB8A95475B15838CDC25CF4B56B91F2DAD6D6E95969A6BF8
            733E14A292A74AAB5169465FDE57BFC9BBEFE7A21B777321BF96413493EE9A4C
            C9B8AEF21C00A4EF09F7555073966639030E089B6DED2D7632A890E46D654590
            7991A8202B81B71803EF1C1C1E72ACE168EB736F8F2F21C2B2BCC7CC5180E549
            C920AAA293B490E776473B8365F92DBC9888918C728972E5B2C0283838FDE6D3
            85DC518F18272086FC7F115AB56AB52BD6DE6DB7E6DEBE5FD58FAAA508C231A7
            0D97FC12383F73244CAAB1E71C42A382A172A02F39FDD38DAACC47190CB80AE0
            65815721B7280A32EEAB210FB7EF337CB92233820E416C6FDC4D36789A64B82A
            ACCA55C138DDB80330C67E6C8C9FBBF3E3FB8B4970AA864902FDD772C542C7B3
            0CD901F040E04B9258105CE76961B7CEDDA5FD6BF95FE5D3D5EDBB162984A985
            93CF932A54F9A583E36738CC9C1210EE2385901CE724A1702277F987960A2C92
            48DBA25E186E6C1DBF7A3C875070AC5B7814FB9DD1C4566576DCC014DCCAB264
            918C316421B2FC1231B917838223C865DC591FE432972E235E44C7782A5B683D
            9B8383CB31E284D357FEBF1BEFB79F5D3716D7060B05BB4AA3C9DBBB69555458
            80D806594363695553B8E3E56241550067F8B7C416FE09F0DDEEAD74BE4DBE9E
            85C840AA411E532C2021CEE2005E58293D7E5231A90EE7B8DDC19599194B447C
            C61955E323230AC4B00A147998C8218D7CEDFB537C486D5B57B7D02DE489AC74
            E28F7601122CF708A0322300B9D8A58EDF939639DB5F59C17C395339CCA9E163
            F0E8E4FB2EBFD7A6D6D7E2F8F38AA9E4394D4C5CFE2B5A2BBBF2F4FE91E71E24
            F12DE78B7C533EA977BE69EFEE1A7447DC06E0088E307AF0AC00D80B7CC801CB
            857CA859A1B38B733B2470A34C6351F70798B9C125724F98A7EF29F34865DE4A
            BA940F16E902C9F688C6F6540778F30207DCC486CBBBB6E7251FCC032BE59DAE
            8D96EE48599D42C87CCF3073B0CB2677F273C1650A4B1FBE15DC6D646FEE2C2E
            129E1A8C30F452518D97E1A69DFF00AD5DAFFE75E618DAB8CC4CF15887CD29BB
            B7F3F969D2DF7EBB364877FEE760DDBF1B550B0F3BCA00AA8E58E00401548762
            AAEE54AAE77BE1BFC54D77E0EF8AD75CF0AEA9FD93A9431C851A0C9F36376C95
            6454D92C6B855C0CE0A29076ECDB8317FA5C50AF96BFBF8A16DA14B222C83795
            60C40D8A0C8E0315272A5B702B207A4ED28126246DC41F9D8912195B71DD8196
            2410E4E039058A2A2818ECA55A74E4A707AAD7E7F2FBADB339E8D695292A916D
            35D7CFFAF96C7E9EFEC6FF00F0504D0FF6898EDF44D51A1D2FC60917EF2D448A
            60BC2A0B335BB28209208223DC4ED0482C14B1FA401CD7E1BE9D79369F756B35
            B4D751DD5AC88D1CC9249B99D66116E5642D83B813B94380E4E0B6E892BEEEFD
            857FE0A39FF0928B1F08F8FAE248F5475892C35692311C5A8161848A4C200AFC
            A286270DB325B9064FD5386F8C2357FD9F18F55A27DFD7FCF5B9FAF70BF1B2AF
            6C2E3B497493FD76FBFB6E7DB54536193CE895BE53B867E53B87E069D5FA21FA
            5277574145145001451450014514500145145001451450014514500145145001
            45145001451450015CBFC60F8BDA0FC0FF00879AB789BC45A8DBE9BA568D6CD7
            3733C841F2D7076E1720B1661B5557966200F6B1F143E27689F07FC0FA97887C
            45AA59E8FA4E956EF7373777522A47022F1B8E48CE58AA80392CEA0726BF0C7F
            E0A4FF00F0516D67F6E1F88925A69F2DEE9BF0FB45BC6FEC8D3DA501EECE4017
            33C619B2D216D8AAD9F2C48B853F313C1986610C253E67AC9ECBFE01FA67865E
            1AE3F8BB31587A0B9694759CFA25DBD5F45F3F597FE0A3FF00F0527F117EDB5E
            319B4ED3DB50D2BE1F69F7B9D3B49691035D3292E971700965694AEE61196DB1
            A32E3009957E5E11C6CECB1ED9616215640770258A44B92E31908A08E199B2AA
            7395F383134D0EC5DDBA4CC48E541CF999DDF2962065C9752C70FB412CD856A9
            25B8579BCE65FDDC772D705B0398CB0F3321803B54A22B67011A4CBAA940E3F3
            AC4E2AA579FB49BBBFF3E9FF000DB7A9FE9570C709E5DC3F808E5B96C1461156
            6FAB7D5C9EEEFBF7D6DD08D5945C43B8B798EA029E413FBCDA0EE63C9FF52770
            DC4951932661DCE8033346B1C2ACA11982AC8104F909190379206F756424120E
            E461CB975646CD02C91C72F973C6980567DAECE26D9BB04EEC932B7255D8B0C9
            0C582C9280A976CA8A9B6391C8521F2A91B33479EA4066DD96C17DE8580217F7
            7CFE4B5FEB5FC0FA47B37D3F5FF80BE6ADF25188FE48F734B2AB1C8F906F9761
            48970368C49F7A37241187C381F2C4A06548B930ED93EF1F302891595A5DA8D9
            29B42A6E0E703863F7D8B04B7FF4782368FF00D5C29110CC08316DF27686C676
            AAAB9E15B90E58336F62AFF2DA38F6AAC918669132D3049225654230D9DA080A
            CD9C80CC323249916BCBFE03E9BF974FF216BB2E8FF257FD17DDE5AB25902C39
            7914490C4ECE76491940B12804639558FCD38048DB9F986E6322BA458A12CB20
            5F2A0C4254657312E5986DC020AABAB020A888BAA2F3B95DF1DDB0B88E4DD1EE
            695EE555CC9F33EE2780832A783115C1704ED21FE6F36341F63B4DCD965B7804
            6C546D3084DB26588C8423771B7E55590796D18DCC677DFF00E0FCBD3F2169D7
            FADB6BFDF67B3BDF6B9E81FB2FFC70B8FD9EBE2D69BAD3B3369924AD6FAAC28E
            5639224F2C348A17680D190A720005D08FDD336C3FAA5A0EAA9ACE9F69750C9F
            6AF3A25649148DD2FF0019287CCE558A3723E520A8E88C07E37CA8FE7340CD11
            9247F298360F9A410A72AD85030EABB4633E6AA03B412FF707FC1353F683FF00
            8487C2371E09D5666FB46928EFA6F9AC313DB02A3CA60D871B090082DF32B461
            CAE1957F9EBC77E08FED0C0C737C32FDE52F8ADD63FF00036FF2B58FC67C5AE1
            7F6F4239B505EF474979AE8EDDD7E2B7D9B3EBACFD9A756766F902A976DCA195
            4A93C965381B656C12E76E4E7076B327EBE5B2AAB387254852012C47CA1D5412
            4B3A023AEF42C18370F72B1CAF227DEDCE542A901C2C9BB6FEEC93C6D6C9607E
            697DCA12E035BA4DFEB6155DC18E5C640465CB1214123CB53B99C1C9FBC011BB
            F8BA3A34D7DFFD5BD3B6E7F3AC47BCDE45C6E91E48D15D8EF0CCA1B0C4F3BDB1
            C032640072AA18630A2A2DAC8A72B9922632EDC1E5F00EEC28C80C5651B80507
            27E46CF2EF2CC4EED1C7B5A204E150038DE4F3801F1B624500023A7FAC1D055C
            798374AD1A125D63D8EE70D80FB718077EF7E149254771B29592DBF1FEBFAD77
            0561B2A4715CED92356192364837171911FF001150C4AA85C92C7328E769F9A6
            B7855A58FE642B23A6E95C058C8F32328DBFCBDBCEE2D9C800BB73C6E58576DB
            F98BE6476E30C87CBDDC1036100294DD8322A0DA09FDD80486DBB6410BDDDF24
            6AA915D48E8881E6032CDE60FBCCA1C2E59B9C81B012A4722BA30D4E32AB1835
            A5D2FCB4EBAFCBBF5DA6A3B46FD91BDADFC2DD73C27A5C97575A7C6B159889A5
            F2E7899A2E8F997972BF3EEC3648CB9248237565EABA3BE95AB4B6A6E2D6F0C2
            B14664B491DC483CB663865CB6EC12C012DC15E14B06AF56F1CF8874ED5A1F12
            FD82EB45B3B8B882D674BF170A925D85F924572E4AAF96510938E30A1D71D6CE
            99E29B54F19DF4A758D2E58EF8D893347A8450CC816351BFAB2B2EF27319E0F9
            8319CF3FBCE33C36C8AA354F0F88E54ED76DA93BF55F676D168BB59BB9F0F478
            871FCBCD569EBDACD7F2FABEFE7F733C4B1E640CCDB95942B12C026C672CA461
            49218990A80B862C841639069D2C0B2C786528B348FF0021552A5B69DC106D70
            5B6B3E403F3346DC60B57A4EABE2285BC336EBA5EB76234F30DC457D6AF3C70C
            D78647CB48B128F9E474642A170ABB8AA8538152F8F7C551DD683ADC70EA96B7
            F1DF5C5B3E930412EEFB1EDCAB929C796163DAA412406FF9664B664F99C5787B
            97423526B189A8AE6BDA367BECF99BD1AD5DBAEDD4F4E19F625CE31747776EB7
            5B74B69BDF7DB53CBE30AE926EDB92C626055E72C5548D85776F700303CA8076
            B3606F53562D34D9354BBFB387226918DA33CDC8CB3383BCB0C286F95B185538
            4018A915EADE06F192E97A178663975DB6B7B6B3B2BCFB5C325D4706D5201B74
            75664C324633B7829C64AF52FD3F58D3DF54D2EE752D4617BE5D1EE2D964FB44
            324F6F289A3742F290C63628C39E839C9042D7A197F8699755A546B4F1A93972
            B92692493B3B5EF7BD9DB65BD8E6ADC49885294151DAFB3BED749EDA2D2FBED6
            B3EA7982F87DB56D7BEC56B24737993BDBA5CB4598E5019949C7CEC7077FC995
            3B64603952449AF784E6D1DAE9669AC92E2C65368E8D31FB423624F2C85C6F70
            C18A8747E591C0C1C83E890F89D751B8D51AD6FB49D2B506BCB492E6E2DEECCD
            E6DB0840016E32ACEC5A34CE03395DB91F385592EBC45A55CC9A8B4DAB697A85
            81F10C57E22B7B84959E239676545C9619054A8C92639703820FA50F0F32474A
            77C42936DD9E89457CDBD7CB7BDCC7FB7B1BCE9723D95D6EDEDB596EEFA5F4B2
            BF747924D1FD9A293F73B6DD932176158987DC0A3E521B76D8C60AE70C769618
            C24518F31A3DCADE5CADB94643127085B2395386DE4AAA8CC8A7760927D03E25
            EAF1DCE816F05E5F58EB1AB47AB34D0CF0B0B8F22DD919082546517CDDEC132C
            06003B40013CF6156DB6F1E36AE536A3A9C6E08B8214841C67715CE3F7790A1B
            3B7F27E2AC8F0F95E2D61A855F69A277D34F27ABE8BBDBB773E9B2DC654C4D27
            3A91E5E9FD75DBAFCC00D916F78CADB88C06431FCBB42EEDA7213E5DAEEA3702
            A30324364191D254C473799E6332659D8B6E2790572A41218BB6405C6C5C80BC
            D470344CF0B2F96B8D853942C72EA725B796276CB8CE7925CFCDBD41107D95BC
            C61B3B867FDC871B59C1661B7AB2E482A4A93271B5B35F36FF00AFF86FC7F5D4
            F40122DEACBE486F2D0110B46D27961D31C21D9C0CE000B9C238FBCC4549B18B
            B3A65DB738562416DE15630F9552A1B70C60824293D0065A69B66CBA347E72E7
            F8A338DD961CFC8000DF36E2158FEF3390A0128844F22B47B6E1F89158A83B86
            E5018E22380CC89CF4C162384520DDFDFF00F0DFD69F986AC02794F198C793F3
            2846DBE58404F00FC8A71CC20A8604EC2BC953B90FFA4432343BA4519914276D
            ED2A860063AE47CC3671CF98C0134470016CDB415640103088EE002B8E429257
            1190C154272C3182E4074E9F6A8F2CAD87DCA4B15758F2E14F0C4A8650EEA72C
            3A1F958600A51727C91DF6FEBFAFC8539462AEDE9DCE5FE3478FEDBC03E0DD42
            F44D672DC5D031DA473380B2B15041DC703626F66E77203B46572057C932DEC9
            A84F2CED37DA6E2E5C177506513B3C726F0C9B86E7612904F0C4A80A18BEFAED
            BF684F89CBF11BC6927D96463A6D86E8AC0CDF2A6E0C497CB13B8EF31820820A
            3818500E385B89176C9BCEE8CAB0266272E595CED62CC4AEE2B23907A3C6CC1D
            566DD5FD85E15F097F65E58B11597EF2AABBBF65D1F5D6EAFADEFDD9FC29E347
            1B3CE333783C3C9FB2A2ECB5DDF57E7F3B7E22BC8BFEB1A565058AF99E6FDE7C
            1F31B7756C86C9DA325942B2B17DD23B124B211FBEF31A774051B6B072872000
            4F3E5F3B57AB615930F8A595584CC19A446DE4492316DEADE6039C93F290EED9
            42546E9222C4A124370D9662A88DE664AB2B3088230CA95F55942B3201C0C9DA
            C148AFD4B9BB6DFD68FB25F7E9A797E31D74FEBBDBEEE8BA6BB06EDC59E31228
            7DD38518CC6C0150D9E42931E087918ED5264C10CC4A245B8AAF96B261228FCB
            2B959C33DC74503760FF00AD09804F194739628A1191474123FCA46D90BEC538
            38E8EE642A79392AC41F2D54B075BFFA4CB02B32C5E7E4125CEF3E66F666073B
            B829B780CE3CBF982FCB1A8E3EEB5FF0FF00D7456B5B4B911D5DFF00AD3FAF45
            F78D53E7796A19B74CB1F96EE402C079A51CFDECE46F24AEE20A140146D57107
            9CCAE12461215982AA9F998EF5500E49F30A3498044B868C2EF2A1D14B4B861E
            5C9B63DC7CAB8640B8182B1A11C0236A9F30100300148D815190115BE76AAA82
            C628ED9379F99973801F07EF2AF94EC371D8467726D896AB99DDBBD9AFF3FC6D
            7D3CD79D8B52716ADEBDBEE7BE9DFEFD8FB3FF0060CFF828549E1C974FF0678E
            AF9BFB3E606DF4CD65D77343872AB14ADB70E01604382555465890C08FBF60BB
            8EE8663656E33F87201FA1C1C1E87B57E1B4004B751EC0C8269D4EE2D9F34065
            C6F385C81132904001BCC0CCC02A1AFB3FFE09D3FB7949A18D2FC05E30BA91AC
            E44861D16F647045B92A156DE460A30A782BB87F171B97613FA5709F15356C26
            31FA3FD2EFE7ABDB67D11FA8F08F18723582C74BD24FA2E97FC969DBA3D3EFEA
            29B149E6C61877F634EAFD3E324D5D1FAD0514514C028A28A0028A28A0028A28
            A0028A28A0028A28A0028A28A002ABEA7AA5BE8D6325D5DCD1DBDBC582F2C8DB
            550138C93D873D4F02A6966581373B2A2E40CB1C0C9381FAD7E52FFC16C3FE0A
            49FDB9A8EA1F06FC17A97EEAD4B43E24BEB099049296DC459230661FC0A640C3
            691924811BAD72E33150C3D27567D0FAEE09E0DC6F12E694F2DC1ADDFBD2E918
            F56FD0F18FF82A9FFC14CAFF00F6B7F1C3785FC2FA835AFC39D0EE7CC4742CA3
            5A914794F74EA18830A96F963C91870C465B2BF1DC713C656308D1AC45615408
            BE64720DE891EF60403B5B70E3690557846C3302E1638FCC58DA6558186F2308
            9BB9F98E32248C9CB3EE197184766A70F9FE745B7538708E8CE8102B2B860704
            AAAE64439525320850ACE4FE718CC554C4D473A9D7FA5EBF9DB6EA7FA85C1FC2
            181E1BCB619660636514AEFAB9756FBB6DDB4FD15E3954FD99BFD4FCF01F2C88
            C1EA70C496FBFB5CB9CB1DDBA5C168C31792490ADBDC36C5552B2381F2312A63
            C140067E7C79AC3683BD9DB3F2B64C4EB5DD15C46F1C6FE6C922792A786405E3
            9153E42003B5E4F94FCBF780214B968A276B5B68C46CCBB60FDD329F2C3C68EA
            154F7E18B1F941F2C80A1583626E4DFF00AFCFD3F13EAB7B2FEB47F75EFF009D
            95FACB048D14E90C6DFEA8C4E90B49FEAD94F96170AB8C9DF1B02A36A8906EF9
            3CB0628622D6E91FCCAAD1222B0C95C79AC1410305B0A761519DE09F2CA857A5
            9708648632912AA342885B18489650848618DA02821083B9D6420055762E2EB1
            DCB30F9DE2559911F0A703053270DCF2B9DDB82A859095281417BFF5FA7ABFE9
            85AF256EFF003BFE8DFAEFE7A34499262AD2339898C51E0CDBD444DBA4215B39
            2A446841C7CA06E257326C600CCA5A62ACCBE63CA199080D88CBB7041400364B
            E029389300796AF2451B0FB3DBAB4C8FBC5BEF24AB485B6ACA4AE4E18905C82C
            33BF7619829046ED3346620AACE11E34420E379728178C6372865C12A854B072
            061CE97E9F97A7F5EBAEA4DF4D3A7ADBFE075F37D2DD5D21795F6CC2668E42B1
            3B31DBB9199D9B72360EC2ECA36B39C60AB1EA8F109173249FB86F2D5A425986
            3E6DB2339CA8DA0F9A51895F955B7ED559082A2448D4CC1164584AB0404FC837
            108A4EDDD956420EF1D5576E1D30A39F22DA48DA46F2A18CC9B9DF064FDE9956
            4EA79758D5B746B9DDE6614B02A87AFF005A7EA55ADF83FE97E9F2D741C563B6
            69A36F3846A56DA45642AA41F32428E79079DC3043E55971BFCD0D5B1F0D7C7F
            A87C34F1D68DE23D39E117FA5CCB310AC85645F2943C6CEC4B05750EAEECC481
            70006670A531F2B05C2B7EE95A1D912A0F906E5064750C18E1959655C962A819
            F0C4ABA1747BC18646698A44E858CB164019667246728C3CD20AB12C53AB1225
            158E228C2AD3953A893525B3ECD76FEBB7432C4518558CA9558DE324D35A5B55
            67F7FCAF7E9ADFF5DBE107C47B1F8BBE02D2F5ED3DA49ADF528209D43A157424
            424870724B2E541CAE571925030037E045716FB42AEF0A1485E64F972C437AE2
            490E4484FCA48DD9715F047FC134FF006813E07F16B782F546CE9BAA4AB3DA6F
            0BFB8B80A18C590140DEB0ABA80586FCFCCC1F9FBED4F99FBC97C9911B06567D
            FE5CA9FBDDC4B11F77192033328C803190C7FCF6F13B8367C3D9C4E8C17EEE7A
            C1FF005F7FA9FC75C5DC3D3C9B319E15DDC778BEEBA76DB67B0C77024FE03247
            97C6C099242C9C2942F96656381BBA39CEE00077D9B10A43B51D158C40380549
            07CBC60232AE70AB85C70EE7682314D5593ECDFEADD9190BC88C8ECA58A00C76
            6101C97C95EFB0E177138B16D70DA76AAB74B0A4B241379837C2595F6973CFEE
            8E47EEE3F5FBABD78DFF009ED08D375211A8F9637577E5D5E9FD69AAB9F2B3BA
            8FB8B5FCD9D36A3F0C6F342F0336AB74D35B6A0F7490C76EEC804C590ED0DB4A
            B0625632437006403B58D646BDE0BD53C26B049796B2DAA5F48CB6D975769993
            6800ED70C5880A487195092862062BB193E25E83A65EDF5C59FF006A49713EAF
            6FAB113411460ED97698C924B1FE2C315CB2ED0B920B0C5F88DE35B3F18DD588
            D3EE648EDDE792E8C11DBC502C6F23C7273B09591F68DE58B6E3B73B5C330AFD
            873AC8F852180F6B87ADFBC845249496BFDE7A2E9D17CF767C9E071B993ACA35
            23EEBD5B69F6D976DB77A5AF61B71F087506D565B7D2ACE4F2E24855A50E8811
            A54207DC7505773200541E02E5B2014CF8FC03AB5FDEDD599B37CDAE249A3799
            5628849BD01F34E4E1DBA30C7CB82060367A2D57C71A2DED8EA8D1AEB11C97FA
            5456318366AACFE5E700B2B12A1847DF91E60180DC34DAD7C41D075D8756B513
            6A16F67796D65B2EBC985DADC42701B6EF21B7AE4EF385009CAF0D5D15387785
            6ADA52C4F2B76D14D356D76566D5F4B37A59EC671C7E6495BD9DF65AC5A7F66F
            D75D2FD2F65A3EFCFE89F0CB54D4FC4B3D8359C91B5ADC27DB82CC8BF65326FE
            AD90A642AEB80A4336E5F9D81DC2EF887E190B33AA7D95A4BC921D50E9D019D9
            3C865209F2A5937139CEEE4FCA0386C64AC6BAFAFF00C4AD0FC4173A84778358
            82DEF2EED2F625D9034AACA815E1C3360A9CAA820B05797208DBC32F3E246877
            AF7ECCBAC017BABC37A42C50C798D421313664E198C8C9CF2463803E6AF430B9
            1F0953A12A4EBC6776F575126976DBCED7DB7F4594B199A4E6A6E0E3A6CA3A5D
            D9DFAF5BE9F8BB1896FF0005BC4534B1C71E9C58C8E544A5A08F0DF7DB72B72A
            FF0075F18C31446000C81574AF855AE788EDBCCB5D3649219649BCB2648E3DB3
            2C8FB970C570EACC59B1B5818D86E620EDE9AE7E27E82F2C93349AA6C8F5C5D7
            7C99A08F04229053025C8206D7064014168BE556C91AB6FA86970F833FB7EE24
            D51B4F83C4AD7F1C496B1FDA2524298C4877100EF0AAAC4EE2084237B66A70BC
            13C31889F2E1EBCA56577EFC7656D76D16FD1FDE15337CCA0AF3A6A37DBDD7BF
            DF7DFF001BFCB9097E1CC5A8D8E8721374F73AA5DCD693DB9DD23C441557110C
            0629839C9DBB402DBB6102A4F107C2CBEBBD5A48ECACEEEEA0FB35B5CB453BC7
            BE38D8B6448F9DB229E40271D39DA55A4ADAD13E2D69BA6DFE937DE5DD4B7D05
            EDF4F343C22309739087715671B106D7209F98920822A9C5E3CD2FCDBD78E6D4
            5B7690FA65A3A58476E96B9FDEEDF2A370C91E022EDC0738209FB95A4B2BE0F9
            D0F64ABA77715A495D257BB77BEEF7B2F3D53B047159A2A9CCA1A6BA34ECEF2D
            76EDA6BD7AF5B73ABF0D756FF84827D366D3CBDF410092EE30F10558CF98E5B7
            79802C6CC147CC39E8D9C12B35F7C3BBCD3F4259A48675D4A4BE6D3E38185B01
            2C832C8C482C4B6F23A291939C7256BA0BEF1DE81A969F268B249A847A7DC69D
            6BA7338091BC0F06403E58942ED390308B825E2C0239A3C2BF12B4BD0E1B555F
            ED39EE62D646AB2C8F6E15996484C2CAE448D8708E0E1B7023681B3868FC95C3
            FC2D0A8D7B7E68B4EEDCD68F4B2B6F7ECD5ADF2D37963F34705EE6B75A28DAFA
            6F7D96BD2D75BBBA4CE575DF08EA7E0F28D7D1CD6F1CAD2408EB224E77286C8C
            095FE60AA8795CE4F4CB305C70BE465A3F2E2309C6F8C1F2D48280825507CA32
            01191910A838F9F1D4788FC4BA36A9E04D3EC6C6E352BC6B7BC12799751AAACB
            1C9E511BB32372176AED7F998E4E0715CBB09044CAC6469A224B062ECC4856F4
            190093280EA10F0A002300FE7BC5596E5F82C62A7974F9A1657D53B3F26BF557
            5DB467D06575ABD5A5CD885677B6D6BFC9F97C81A11247BBCB7DAA7E701048C7
            695079192587009DFBB74408070454864F34FEF1BCC585D832C6E59BF8C330DA
            ACCB9FDE63E6C8DAAA31920138612B31577F2D9D9432B381C96C0263279310E9
            D3771D23CB446D02F978DDE529215976F1195230A37039C47CA2F1963F2B1DB5
            F2F776B3DFB7F4FF00AFC0F4375A8D8E1F322F25915DA3430EC18711123CBC90
            3200CA30C88F80DD061C579BFED2DF143FE10DF0BC96762C5756D637421F0B98
            E16241707008DC11546E04151F29F9771F43D42F62D13489A69A454B6B78D8F9
            878F2FCB272CA02BC658244CC1428C32741BF03E46F881E39B8F88BE356D4A65
            9ADE0B87F26D218BCCC450ABA05C007272DE58000DA5D9802BC91FA8F85FC26F
            36CC956AB1BD2A6EEFF45AF7F97E47E43E30F1B2C8F29952A12FDF54D23E4BAB
            F2FEB6DCE7E358D6E176FCA721546C31B1511B724285C856419CE4673F329DAC
            441BF636D99776C5C2A92577387907057E5032C0E40DD9C67734CED8D0CD0C67
            E51E6C4ADE5E079593E5B96181864CF98A490DBF21003B77AAB46663F37CAF31
            932F270C85CEFDF9273B9546E639CA0662D27544FEC58C54572C7A6DF2EFF95B
            A2FBCFE099C9C9DDBBDFAF9F7FF3D8403ED2B11C7DF566384CB6269370500005
            B2ACDF2029B83A8036333C822F98F1EE936AC8C2742B216214AC855C30DA0845
            4F4DA36B8253CCC5384AD29775E1A4DEC898390C70D1A90703E652EE1708A487
            C676048D0C6AE09CC86228E4E5FE571E62E198900104844666180CC15844235D
            AFCBFAF3F3DFE56B750DDD97FC36DFAF9DBF216190097CC64C7CD13B2A4AEBB1
            33B117A82037CE9B9BA216E5DA6151EEF26DD95E48D8B2ECF9F2BE63C6F1B1DD
            F30196658B7636B158D5872EBBDD3179524F95E599A277DAAA774A65F2C8C267
            7658B1041E489402CC24DA24F34F9E1E191446B2398E4421D48C24E541E00524
            172D9015955888B32528BB6AFA7E96B2EFDB6EFAAEE6DAF45FD2EF67D7E5E80F
            E5F9C566F37C9577498B65F7208F730DBC0660BB7701866D993E5E4992331384
            FDF21F31A154914A8DC64425A4507241DA5882AC4A804126322314E8D3044611
            9B88804DA54AAEF3204C63AB21181B725B6611883206A07630EDDBBA655656E7
            0D9F34A90FC8E1565553F336D73819212335517AEBD5FDDAFDFB76F226D6F77A
            FF005D3FAFC019F96DBB188258B00EB1BA285C11F2EE3D4480AFCCB148C0336E
            5A1A0FDE61BCC2B1B32AC9B155D5951FAE3015B68672A38569F2E493903BF996
            CFB15954A49F232602AE4BA065638DA5407218E19A3666673BD42CEC23F34AEF
            9162F2F6E7AC91892465001072CDE50003280F8576524B9AAE6E57FD696DBEEB
            7CFBF7A5269B71767FD6BEBDBABF53EFDFF826DFEDB8DE30583C03E28B82DAB5
            B4691693792EE56BD8803FBB73B70D2228186CFCCA07A176FB4237F311586EC3
            0C8C820FE46BF0E6C67934CD6A0BA8669A39ACEE9A48AE6DFCCF3A36F3180646
            0725CBA90006724AB12E4AAB37EA07EC05FB5D0FDA2BC02BA7EAD22C5E2CD122
            097F1020FDAC642FDA136A052A5B3B8A9201E701594D7EADC1FC49ED57D4B12F
            DE5B36F7F56FEFFF0033F62E0AE28F6F1582C4E924BDD7DFFA5DFD3A1F445145
            15FA21FA505145140051451400514514005145140051451400514571FF001DBE
            36687FB3DFC2BD6FC5DE20BB8ED74CD06DFED33E48DEE09C2A282465DCFCAA3B
            B1E87A51EA6D87C3D4AF5234692BCA4D249756F447CE7FF0568FF8280FFC3207
            C248F48F0EDE429E3FF13B35AE9E87716B184AE1EF0EDC8F9776D45619672081
            8426BF0D65BA9B52B8F3A79249A47004CEF21DD379A70E649036483B98172CC0
            B4619794DAFDE7ED31FB43EBBFB557C6BD63C67AE36FB8D4A4115BDBC7BB6DA5
            B212B1DB20E8624427710A14B93B0798F85E020611086655F31E3C38DD1B052D
            912E14A313F331703008CEE503E531C9F9DE71993C4D6F73E18EDF76FF00D69D
            AE7FA5DE0BF86F4F857288CEAA4F13552949FE51F457D7CDE9A8E8B74AC14B4C
            AFB1DCB98886DBE66D766DA33F346AA5978F9CE7F76E1453155EE5772C6C3CD4
            52235F98E418A40B18017180AF8C0E80C8B93B8158ACC2082DDA3DEAB388DB31
            31F358280FD18E197E63B14F28072DB182B5834D1E199D9A48195B7B1771F36F
            18C70776CFF69300B6EC7CD378EAD7BA5FF03AFE8F4FD4FD976577B7F5BFCECB
            F2DF47A2C62E595B6AC9BCBC8442571FBD0A7807E554C2B860014DCAEDF31C3C
            65BECF6D23792A196DD1DD5A12A4EDDA3615E38E73C8259976919511ACA1FC99
            61E562512E634DEF85248EC4FDF8DC72599721E41B479829902ADBC50AAE142E
            D25909560CB2BC7F2AFAE5C2201B7690030DA15285E7E5FD7DDF3BF98B5DBAAF
            EBFAF976577CAEF034CB1CBCACB204DB3ED323ACBB412B900FCA1979E329F298
            5503045F9C797001E433AC11F95FEF3491305240DC06D50B91B3923CB0AA0892
            7969037EEDB6AC4D0805DA37E18ED1201B8825615F9480CC21618DE15902E4A4
            6773151E5AC6E515CFCE9BD36E49527008E858F192DB2406BB75FEBF4E9D352B
            4BDFEEE965D7E77D2DDFCB5491B315DD1A99711B48B144824326D882C854003E
            F65580DA55CFDE6C49190B8F2D1B632B6E55CB471AC8B2B312172402A77ABAB2
            AE36B32AF1116C532F1196CA612331664639917CC52F242A012B8C65949C9C29
            66F300D8198B497DB639A6FF00966BFE92016763B48319FF006B2C480A7FD66E
            2C3E421A445AEBFD5FD36EDFE7D9046CAD7F2FEADF73FF00268042770857CC56
            8A431AED90C5B1D95A346CE4ED2C5A4FDE72782B8326D48CF3199249238A691A
            6DD72AB0A15326D888631821C6470A0631CA29919582B3942ADCAEE589A3FB42
            8D8D8D91AC800C82415276AB3166C8E362EF66F32ABF93E769ABB91A4F321DAC
            1D598164C44FF7B0C4F97D40218859148858BEE95E7FD7FC0F4FF824A8AB72F6
            FF0087BFF9F5B6C89E26F2B6B41267CB1B5248C1651B184A180CF31B6490A0EE
            207560049142618E3B76DB1858EDD3B01234606C7460C0E0E446554E3CBCA95C
            12A5659E6DB7336E931FBD9640AFF248AA99DE46E662BBB6C9B80E8364BD5308
            233E61403FD5B420AA80AC3CB94B22962CF9DAD825B24B0DEF96DE423311959D
            FF00ADFF00AE9B7E2F45BFFC35FF00AB7AF4B344D0DE5DE917B1DE59C8F6F796
            A59ADA58E33288A55950AF2412C728B924EF69386DBF281FA89FB28FC79B3F8F
            3F0B2D7585F262BDB27FB2DE5BA306FB34D16F6705B00AB3619B0CC140958721
            483F96FE534927FA3C6DE6045688AA32B0688FF73E66E5A42F8272B9DB2101CA
            9F66FD887E3EAFC0EF8B56F0DFCD3DBF85F5B0D6375E6A7991D8B6E93CA7230A
            1768C82A4EC08E55800A9BFF002CF16382E19F64D254D7EF69DE51EEF4D55BBD
            969F86E7E79E2470CFF6A65CEB5257AB4EED777D5C7F3B75E87E9A4911866CC9
            1AB36E0D909F74E439405B6AE4B9401872DE995DC23291A6554432295223CA27
            972829B4103281B3FBB1D300BED0707E54B5BB5BD8D268FCB49256DE4F42BB9B
            1CB16CB2EE08BB4952DE59C64616A45B8562CD0B75512AAF98CD93B6360A4A9C
            B31543FDF38C1CE0ED3FC01529D4A739539AB35A3F5BEABFABBFC4FE53D53B31
            167580B347236D5CCBC48A372FCAC58E240BC800E7007EF949182D9749B95D80
            625A18820C23EE97687E4E3E719C48016DC3254A9278267CC90C6B206C93147B
            A51248B8DEB9E1D483CB723E6DB1B6496E024A7CD12AF97BB7ABC8049173C890
            92011D7E740488C9CB60EEE48CEEAFFD77F55E5FD2244DB142F9FDCA22C9C1DB
            1A22056E46707EEAC23A1CFA84C295194C6B28914E63C330570AC3EF6E2A7002
            6712FCE546EDC30E3A091BE7766DDBBE621823B17D81A6CFDCCB0EF8C9232301
            50E30D11C925BFCA3E67392028DA1C16CF4DEA3123AF51B86C249603917A7F5F
            73FE9FDC5C23B9F224661242AE0B963B95431E492D966E3F74C33825548031B5
            A8B48F7BC291AB6E8C00390ADB7747C6C072BF2052402A3E61F2127687405A63
            1EC7917CCC7945989046D2C0E44843636A838249C31E8F9A8DBFD262DADC21DA
            8439F33CB2CB1AFF00CB4EF866FBDB49C9F91B3C9D6CFF00AD3D1FAE9E41D6C8
            2191A0B63B1A48C2C7B7E519F2B11C6D82090AA701B1B91403D40CE1D2558ADA
            662DB576060A30AAD1AE5F214928546C8F036E1467396C12159D658247461B54
            BB00080CB9594EEEDB79254E761CAB02C7BC9233DB798CAD243B77B2B0565507
            7C83248181CB29C94231CE5F19149B5B697D3D7CB4DFAFFC040F47E60E8F2AEE
            5CC8CD95271B86E56719CED7DA048CA4027E5C741B58164291DC244B1EDDA0E2
            30A558A025186D187E177A1EA00289C0539A59EDFCE2A9247229655897CC50C4
            821860121F710AEF9CB755C9015892798CE31236CF94492172544446E3921B78
            1860EC1B85CAA282C2A7FE07F5D7A7F56BA05B05B6F16E1635646C6D5552E162
            24123B300079A830CAB800B630AA0110CA911C7B955C158CEEDB18054A823690
            A398860A8651B882792635457B6F2F644030F292360582332310AA09257893BA
            70A8D95DB801CE8931DACABB5E528170A796DC795C1C1292938D80FC87712BC9
            34DFFAFCBD5DBFE1C76D6E032D0990170AA8EA933B93B1572C32DD539DA0EE53
            CC655B7719742AA51FCB8E455271B162C6CFBA57E55DD865545601D49CB281B7
            EED08BE65C45E62A89832939C2C9BB774C16DD81894821B6ED6200719A491558
            299B7797C0DD3AAFCC9F3B659DC64E23DCBB71B865F39CEFA3ADBFCBFAFD3762
            120895DE14DA91EE381E5C51E15B6A2E067201528CC546E23CA5E780A48A48E0
            8E4DDE4C7C2BF9615472A2328B8EBC6E0BFEAC3636770A4A956E5597CD758CAB
            A619965C6E5505705CA90B210589197E37F18CCF1978BEDFC01E1ABED5277334
            766ACC200CB99A40762E76FCAAAF2160D904E5F71DA1085E8C261EA622AC6843
            57276EBFD76F4EBA1CF8CC5D3C3509622ABB462AEFA6DA9E4FFB577C436B2B58
            FC2F672799E6A2BDFC4AA5F2AB9F2A3002931337CA08DA06E2981C9AF0948B7B
            C88CC5A491958B30F99899B06460BF367A9076A9C3C9C94DA24B9AD6B775E20D
            5E5D4AE9E6B89AE6413C8141632B1577FBBE58214A976C676B7944A86E00A702
            A432085C868D7059148994448BFC2BC6E0598118077294F9860F99FDC1C0FC35
            0C972C8E152F7DA4E56EFA37FE4BE5B2DBFCEFF10B8BAAE7D9BCF189FB917687
            A2EBEBF8EA9DEE2C23CF7263F9A494AA2A872CC1D846B8F97A12D16E214B3B05
            C6482ECA5B3AC2F6AC311AE2168F0771214EC3B4672D804EC3D06C460CBB1D42
            244D77147036636B88E289B189163624E0E0121958484A819DCA8B956F964772
            EEBE49184127FA732B7925BCC32B33348C8096392C46003B4928CA59BCB7F37E
            BB4D9FA7CBF2EEF6D5F63E095968BFAED6F9DFAB1B0C6CD1C5092AA372204CAE
            D745383F7936940772925482CA0B9E36D35C2DE42C72CEF344EF19DFD779625B
            93F36E593E6DECDB70BB9DB32209502DD5DC6A6646FB64A184AE0B2CB1BF9997
            2991BF786C9206EDD0AA95DFB98321DD78997F3365D0DAFB893200E9BF277055
            6604A8248C16562CEBB8328DFBAE5FD7FC15F3F5D367D6DB5BE7D37F4F4E8BA8
            EB8D970D36F5531CAEB2B124624F32268C1624823FD616CB9270776F0CED233B
            63CF3859172F26124494166667F337A36E3D8CB1CAC18FCA598EE8CE1446B20B
            8186C0F3216690062CC165D85C8DC77B7CAC4062012261B98AAB9238F3430B83
            12A94FDFE4644442B166DB83F2FF000A9E47EF1B62E5CA4752DECFD5FE1F9F5F
            5DEE4A56D17CBF2F2F9D868963F298B05F9A18A6689CF2172D2B8DB83853C820
            A951C9D8F8DED324327DB364AACCD24856507E52ECCE5A40ACCDD19792771DC9
            2A8322860B51CB9689A3955A3DC268E50C7732332B48E4E490CD1ED2B96CE7E6
            2EC9B81559184934ACCC23926533C9B4B1642A07239DC480CC5581CB6E95D9C6
            582093D9EFFD5B5DEDF8EA9DCAE97FEBE5F2FCFE6A25954C500332C52B409246
            400A63321F30B2720A90C2375C636EE8CE1833B3CCE0932101635E51A3C03184
            8D9032AAE09DAB9566560C5948CA31CC8C36E3132AB240D244C31D638B27076E
            4636069BA9C9624A8FBF21A716C5D2BF96D13023621272AC38DA463931F9B96C
            65FE6400479902284BFE07F97FC1BF97904AF66BFAE9F97F9EA86BC2D2CB22AA
            B6E6530A90FE63329D8C807243103C864E5B785DA8E4AAE7A2F845F15753F831
            F1174DF12685E4C775A7B34AC864062922778411207FBE8E251D467F7990FB94
            D734C8B05B49FBB1B2389C95CEDE100562CD9C0DFB9549047121F9CBEF512FCB
            6F36D7F336C73397665F2C47B18365BEE88F0F2918F90E26C1F28124DD1AD3A5
            38D483B35B774F7F27A7DD6F2DF4A75A74A7ED61BA7FF0FF00F02DAE9DB6FD98
            F80DF1A74BF8EBF0DF4DF1069AC523BE8C33C121C496D273BA2208072BEB8C11
            82090727B4AFCB1FF82777ED3EDFB3B7C4D8747D5AE2687C2BE2078D2E8B9F2E
            3D366C229B820E4E0C81D243850786CFEEC2A7EA55B4DE7C2AD8DA7B8E719F6C
            8191EF8AFDDF873388E3F0A9BF8968D79D8FE84E19CF2399E1154BFBCB47FE7F
            324A28A2BE84FA40A28A2800A28A2800A28A2800A28A2801B24AB0AEE76555C8
            5C938E49C01F892057E3B7FC174BF6DB93E2D7C47FF855BE1FBC793C3FE1099A
            E75596166D97BA8642AC79DC50AC499186C0DCD2B1D85372FE86FF00C148BF6C
            187F631FD9A354F11C6D1FF6F5F1FECDD0E0908C5C5DCAAE01DB90C56250656C
            15E1301B2403FCFCEAF7B73AE6AD797779335E5EDECB2CD2B5C38F36E2567284
            B330E59A5918F3B8A79ACCDF348AABF3D9F639D382A10DE5F96BA7CFFAD4FEA4
            FA36F876B32CC1E7F8C8DE9517EE2E929FFC0F9EBD3421B991641334934602BB
            659DC330C00B9CB7CD90639D0061B42091A4C8CAB1760C2974C76DBBC493A9DC
            EEC20F2E253B8E3320F94F965B03E5394642EBE648929596365763B0970CC1A3
            326D1C04C1270DC0CAEE7D92460AB9C18E4D1F4F9354D4ADEDE3648F7390E640
            B1AAAC69E63339523615DD9DC49E1430936B10DF0B1E897CBBFF00C3F9755F79
            FDE92FEF7CFF005F5E9F86DA2505CC0B335C471A44AD2BFD9D5490AABBDC7EED
            80C8DAA4796F8387C050C5C2A23C48D3CA26877B47712078F0776F7CA88C1C82
            A6451970CC595B2ADF30DACB736E92F02335FEA2D186DEEC2CA26D8086567F99
            C2A8218B10EA854A4BF295628645834C3791A4973A94926F54F2C5B47211D15A
            3E6425B255890CC41DB2484A10A43F67D1B5FD7F4BD3EE33F6C9EA93FBB6F9FE
            1F7696B332D17C98CF971AB2B471438CBA2BAAA70417CAEC32329CBEEE1CFCA4
            BE4C8C1A09FF00DAF37CC77923D8405651E63657015B73A60364EE70C412E61B
            56F0E929133AEA37DBA3803890DB2655576A00CC5FE6001058EDC1072E557616
            47B3D26087E6B9D41A3B74241FECE543E579610337EFD58E1E28776F605493B8
            808195F2F9FE3D7B7E9E7BDEC3F6ABAA7D3A3F5EDDBC9A7AFA1454E164032D27
            94EB8DE59D805013771B9893339FBA4E1D4952EC85A555FDE951B95637789CAB
            B2AC69F7581EADC9572792010080CBB9C685C41A7348F8BAD537B48CAA86C95B
            748CC43B2FEF02EE20841CA9C6E398C8985452596932A6C5B9D54C3FEA2366D3
            8288774D958B064063C8C818C32285500B18CB1CADFC4D7C9AFEBAD97F575ED9
            767E7BEDD7BF5EBF2667216B7B456C35BBAED667560924452325C925B6636E14
            1CAEE033FEA901A92450AF22E6685428DFB76A34237B607238237ABA9380A0A9
            611EE2B2DE64D19E6120BBBF55404EF4B48F306E0809C79F92885C708CDB413B
            5D46C5214D3239176DDEA2A02AC8EA967130898860A481208F2AF11DA795678C
            6464C65172B6AEADF87CB777F9742BDBAE6BD9F7D9F7DFEEB5B7EDD594940965
            FDE28923DE24B9450645C798CA7078011410376EE01EA12364662F122BC9F3C8
            AB89CB2EE718DDE613B800C7688D486DE388D8F09BAAFBDB6922DFFE3EB54455
            C45FF1E0ADE51F35D9570262C9B8AE0606F56DA0176F2CA8E9A382DBAE7508A1
            5511BF97A7A158A2D824E8B330E338001380B185FF00588F4F92FA2FBBCBF1EF
            B3F2B846A28E967A793E9A7FC149FE9AD10CD681A66CB4906DF318C5E62A15FD
            EA2E79DC0E0461B0A4955201CC5B51235B511A47B648605920468C3348CB1828
            817E6525821E02E0E5DD941DC1CDED4349864D29E6B59BCCFB2BAFDAA29710CD
            03492798E57E67523723A64488CAE158F5494547DD7131C18E766B89D0480ED0
            A4B0DB8C10CB96DE41183F210A1D8894A95D6EFF002EDFD5AEF61D371B72FCBE
            FF005B7F5DBA323119994C9E5C91AAA4D22C415F007944E3695014A146DCBD99
            724602C91889648A366F2646F2A401CAA2AA287C9C9206D45059B73021377DC0
            C63569DC4B3998AACD9556976107F74CE18F98157EE8652A59B690A0B280EEF2
            1A1F6CF3B73285DA9F2463242E525C28192763636ED2E13CEF90B6F5459F27E7
            F97E3E9FF0E38EA9DFCBEEDB55FABBFE07E89FFC13DBF68893E2AFC323A46A12
            CADAC786585B4DB9C87BA4631B41210CCADB8C4AAAC0E4862C5B20E6BE8666C2
            ED693CF85F682EA095954AAE54798DB70C76807273BC8E0EE6AFC97FD9EFE324
            DF02BE2A697E224F31AC158C7A8C2A859AEE024C93C655492BF33EF18DD9D8AD
            BDC3064FD54F0AF88ED7C63A0D9EA16B7114F1DFC3E6C5306524838453925597
            9763B47CC370008C853FC43E38703BCAB32FED2C345FB2ADABECA5AE9A77FF00
            2573F963C4AE17FECBCC5D7A2AD4AA36D764FAAFD56D64EDD0D28EE7685DB2AC
            9B42FDD9B3E67DCC6332F7C2E3FEBB2E7ABE554C69285565114847965766D237
            008CA0855240687070E06D2BD7EF3E59DA2BBE58AFCE5D54C8D9FF0059D06E2A
            082540FE2C1900E13EF34A48B2A2E6690E3CA3B58C6D2055E837609FBB291F3B
            60B06390411F842BAF2FEADE5FD7CCFCD9798DCF970B0DD104D998F0FB901C29
            5D9C6DE18C614AA30F94FF00136294C0B3078E358B6ABED8F90FE50DC1390BCA
            AE402028183164B039C234CA4AC8D27EEE45C19558A0906492C18B038C34A400
            580555618E03124AB2C6CB33C23236B9628FE5E7EF101A42063F7C38046108E4
            280C47A5B7FEBC97DF7F3E850E7995A1136D5F2F8919D81C11BB7AE5B6B8C2E5
            464360067231B461228F744911C862A63076A1217E546181BC0032B90AA17746
            49C034E74F327CB8647DE15CB60940C400B9C92A76CC47DF0410362907058B70
            6E1646573BA48FCC3E5380C5F6236EC296CA8C20E439F9F1F77EF2DB6FEBB7F5
            EBBF495E43A549248012B2090A96CB249FBB3860703E6EE64236303C22824104
            A4A6366326D5882B65F6840D183BF2495395C069016DC30C8700EE20A6D8A298
            B15B7545938388E3440ADCF63F75611C024FA850015047E518E076DBB760037F
            978E91B6D2547A6D063C67CD1C2E4351FD7F5A7F56B0048AABB58AC6DBB0B2A8
            51B2463B832703693BB70019C8DD212727682F9A07543F24CF2296E0425727E7
            05976F1C99072195B19DCE70D8480FDA9977625DFB164217CCDAAE32C8725940
            2719DA4E14AF4003D46515A22CD12B7CA376F55F9D8A8254811E72C5F182031F
            364C2F4A1277B2FEBF3EFDBB3EE3D5BB13492E1DA659362F1FBD05997612D96D
            E57180250C33B906180C6D2D4D450A4831808AAA9242177E13121D8762E38523
            0A770E83A90C4CB472B36D324B09241619723E7C127696C921C70AAB89085CE0
            53523125B2C68239E35181D1958701780ACAB94283E5C656476DA31474FF0087
            FEADBADFF2D55BFAFEBFAD4740AD858BE5F324724A1652A5D08DC490AD8F9D39
            21500F33A6FE28B783CB9236546DAA5579899091F201CAA295C058CE3A1F9D48
            C2E4247279D1CCCAC260C482AC06E71B4825D554FDEF2C290CA0A9DE01FBA291
            614927D8151D831570557737CC15BE5D99E559998E00FDF1E704329FD7FC3747
            6DBFAD0D7FAFEBE406391ED981DC5644F983AB28C94033F702FDE76C82A7392C
            71B368F9CFF6A9F89ADE23F10FF64DAC8E2D345918C92A178035D670FB892C3F
            75B94649182180201535EB9F1AFE210F875E056BC84C4DA8DF031586E09212EC
            1B2E42003E50FBB392BBA6239CA9AF956CA27D4F5056865FDF4B2A6E904A1516
            4223918B3283D0C665E09460370CED2ABFBE7833C21EDF13FDAD895A4748F5F7
            BBAF4BF73F9BFC79E36FAB61A3926164B9A7F1F5B2DACFB5DFF990DC0C4B36D3
            B248D8A46C47CD6CDB1D40C60B290E1D8AA8673E5823A2BABDDB64FE5A99630C
            C04488C32BE5B482358D54E77079011B09CE30AF93BDACF95A53DB851A85D4D1
            6DF29A64B68D2221C85E0B498505D0CD83C81B9D768F9AA4C69A64690CDA9AB4
            8499A216F1E599818F6326FCEE3B1C8562CD80C187009FE9CE47FE5F77FC35B4
            D3A2EFFC7928BB5BAFAEBD3F1FF8267B2ACB148BC08F691BD15420134A55D811
            8565077004617236962ACAB2395F74EB23069374A8781D14CF0B8047F16E555D
            ABB4E368C46DB848D69BFB2E05321B9D4375BAA0DCD146E03A175CB6D9B27779
            AC000778DC590AA05DAED9A780C164D619530A316B1BB6D5665046D930DB5F21
            CA8DAC59401BCAB53E57BC7CBEFB7EBD3CF7EC5B8BBEBE9F2EBFA5AFABBA28AA
            AC6155D9A4F3BCC4F2FCC0CB228DBB803C8666DB18DC770223620BB00AAE07CB
            9BCE67915F01DDE30C24DDE5B6D6504E77E4384CE5D8CAEC5810185CFB369CAB
            709E76ADB8F9713B456C9B99823AB480F98720BE4EEE7006D07694A238B4D95B
            E5B8BA3279A8D88EDA25485CCED920897E4562FB725B70DA83763E463934B2F9
            FF009F9FF9EF7D8954DA7FF0DE5A7E4ADF3EA8A22430C201DB0FD9C45232A388
            FCA0A320A939D831E6221EA1CA3314230091FEC4AD22B2AF9215917FD5AA6D2F
            B30091B37053919DCBB43862A086B8174D31B3C771A87EE99D8ABDA46AC51CE1
            011E6A956CC7B431DA49D808DACAAD235BE9A1D57CFD464E7629486372770551
            B48949DC4E36B03B8872725181A4D5FE6F5EDBFE3BE9DAFAEDA0E16D55BEFF00
            EB7F5B25A5DE97A32C46DCB43B70215F2CE5367CB1382CA00561BF382540654D
            833B88CB0BBAF0B2AF9732CD820286FDEF9D22A2B00377DD223FEFE081970CB1
            86B58D3240CA66BC6DE0AF36912AB857959C81E68FDD9C3E76E02B2B32ED53B6
            9D29D3BE666B8D4940567F325B685946FDEAACC4C9B58852449DA40A0901B9A1
            C7A7F5FD7DFF0073D4E5EBE8F7FBBE4D6DF72BEE5189BED611A36597ED45D776
            E2B9DFE50C8E700EC2B237391C0773B7CB2B13799E53A348ACEA08C7CC59A404
            479550376142A84181F3E515942937E48F4D8A5C799AB20DFC2FD88349851221
            C12E49284484373B40F9B70272D822D34326EBABB31AE1A61E445F22F9DE6654
            F9A502B651700323156600904ABE5697F57B69B76EC96D7B07B2B7BAEDF7FA79
            FF005A7CA8C08AA6158BF7215D7CB70CAA13E729BB7018073B543A00AC442DF2
            95F90B42ACF0344A8ACDE57D9FE43FB9F94BA0500E5721F0541DE4AA3216664C
            5BB7934C102B35E6A1232A34B24A218C91843BB762624190F2DDC9CA646E2866
            16D60678D5AE35366DDE4BAB5BC4483E590FB9BCCC060A70C7A657E70C4B6E4E
            2ED77F2FC3FA76D35D6E29536D696DBCBFAFEADAF4CE8604F2A3D96F851E598C
            18F6AB0E482CE14B70862F99540611BAAE4302FF00A55FF04C3FDA7D3E2FFC2B
            FF00846EFEE3CED77C331C5197764DF7B68CA0C536D504EE01911C166230096E
            6BF382FF00468E06B5CA892C750459A29BCA2A76632EFB4AFDE0AFB0ED04A88C
            B6D901DF5D3FC03F8D77DF023E2DE8FE288D8AC96C7179000733C4F892780738
            0C0B1DBC970EE87EFB1AFA0E1FCD6780C6465F65EFD92FEBABFCAD6FA4E1BCE2
            59763233BFB8F47E9DFF001BBF979B3F67A8ACBF0678AAD3C6BE1BB3D52C6E23
            BAB4D4204BA8244390F1B8DCA7A0E3D3D40CF7AD4AFDE29D48CE2A51D99FD094
            EA4671538ECC28A28AA2C28A28A0028A28A0029B23948D982B395190A3196F61
            9E3F3A757827FC148BF6A31FB29FEC9FE26F1159DDC36FAF4911D3F47CB2EE17
            D20C464296058C79F34AE082B1907839A9A951422E72D96A7765997D6C762E9E
            0F0EAF39C9452F36EC7E597FC1657F6B66FDA3FF006AC9BC3DA55E35C786BE1F
            F9DA341E5C8FE5DD5E373772A6D66CFCD1B4402E4A8801019198AFC7904DE646
            9316F91B13119F964258C8AC557E6CB4AC36EDCFFABCAE4CBB5E4BB792E5DFFD
            648CCD1AB331064B80E494CB336195990302C4072E88589464665DC9FEB02343
            FBE81807321DA63F28FEF0173B1812BBF73162DB5496ED1FE638EC53AF5DD493
            DFFAF4FEAFAEE7FAC1C0FC2F4720C96865743ECC75F3968DB7EAEFF95AEC7431
            012C69B5B747E522FC8372925C9CB0EADF3B703CC0549EAACE5AE7865A4373E6
            C7B63F2ECAEC1919B30C65ADB1BF1D54280AFB5CE4C44762E168DE10E2455086
            3937ED21F1E62B2B6E62D21230EA318DC09607247DE8F4F4084CFE219E3F9E67
            097289CE58078DD86D72558B0025230010B86047DF7E5A6FDE4FD3FAFCFF001D
            CFA8ADF03F3FCBBFA3F95BA6E674B1ACBFEB048B1B177D8597746377CDF32E40
            F9B99005255E3C9CF1257D0FFB37FF00C137BC65FB417C376F1B5D6B1E15F077
            8567B96B78F51F105CB5A437D2B16DC23408488D9B805B059D4850EE1D8FCF10
            3BDCCF0C90B34B2CAB13C3B93A03BFE70148076314C0C9011D46407047DBBFF0
            53078F43FD89FF00659D1F4F544D166F0FC77AF12CA161F385A58004A65013FB
            C90E4A820B1E4E413E965B87A528D4AB595D41276F3BDADFD7FC13F39E3ECFB3
            0C2D4C1659964D42A6266E1CED5D4528B93B2BEEF6D764DE97D4F9A7F69DFD96
            7C5DFB21FC438340F175BDAF9B3C315E595FDB4A67B5D4225F2C2B21D81982BA
            B215C2B891906D270F5E6B092F1AA42DE63705199448B21C18812703EF2E4893
            1F38DAB80A5564FB83FE0A5D72DAD7EC35FB326AD7D70D36B6DA13C3E7492859
            A45FB35A14C9FBE7E608DC23172E4EE2CDB47887C04FD933C37F1C3C04FAD6A9
            F19BE1EF827FD2668E0B0D76F512EFE525C4C0C8C06C2A536F67D85BF78066B4
            C665FCB88F654168D26AF6DAC9DAFD7A2BAE9AE9AB7CBC23C78A7907F6967524
            A51A92A729462DA6E326AF657B5ED7B6CB4D575F0F60B243B90C2D0CDB23F3D8
            B8C068F6AB360F01D791C96F963539DCA91FD87E12FF008232F8F35E934DB7B8
            F16FC39D17C49AC5BC57963A35DEAC7FB49E360D893CA8C0603E790613E5C162
            1BAB57CB1F12FC290F80BE22EB7A4D9EB1A76BD069B7F3D945A9E9F73E7DADD9
            57802CB1B2E46D97728C90C4AE0ECCB482BED2FD833C4DE07FDA77F68BF03F8B
            3E2E7C50BB3F12344D4E2D3F47D097475B54BB10CBB6D91E5488C25BCC762106
            0C9E585E77026B2CC3D195474AB46F2D16AECBCF5EFD95B5F332F1273CCE30B9
            5C333C96AF2528C64E4D539549EA9382492B24F5E76ED6D2FD4F983C3FFB1CF8
            F3C5FF00B45C9F0AECF46FF8AA6D6736F340DB5A2B15446C48F2200040125017
            6E73BC0DBF3E0FA7FC70FF00825578EFE17FC2DF10F8AB4FD7BC17E38B3F0DC9
            B35C8344D51AE2E34D6F9637DE8C8AFBE3490A3118700107A2B27D61FB31B789
            61FDBDFF0069FF0010F89ACACACFC75A7E86F2DA8D3A43711C5198736A126C66
            4CC70DA2E7E57662A708DF2D78A7FC10FEFBFB6BC79F15B48B89A1B9D1F52F08
            B4BA997CC81D8CA50338C10CC565704775948380E4D7A4B2DC3A9AA4E2DB9CA5
            14DE964B6F57F2F2E87E735BC4AE22AF4E78EC354846385A746738A8F32A8E76
            E6B3BE8AD651B5F5B37A1E2BFB307FC13FBC59FB4DF85B52F1747A8787FC21E1
            1D3A6789F5CD76E5AD2DF7FCCA2357518184639650006660A59CB6EE7BF6B0FD
            8E7C61FB1AF89F49D3BC4834DBA8756816E746D434E93CEB4D4A2880470A5406
            DC8EDC2050ABE7EE00FC8F5F477ED90C9E15FF008242FC09D3EC76D9DADE6A52
            DCDD849084123413B10E64C16C34923091D08DC1C80BF2931FED4F1CDE28FF00
            823A7C05BCBE8E39354B7D6E7B38647839166AD7A89DB76C616B6E09072FF2A9
            1B76671C465D8750953B7BD18A95EFDFA7A6BA3BED63D2CA7C42CEEBE3B0D985
            59C7EAD5B112A1ECB97DE4A2A4D4B9AF7726E3B34D6A97447C57A3AAC7A66A91
            C6A648C5B3881C0E25433C3B48050EE52DB7771F348C33C6C2D52393124455A5
            6DAA2621BAC800254923770DF32B37CCC55186242A5D2DE852ACF61A849C0B7B
            AB65998FCCFB14CD18001FF6612CC08E70CA4ED0115F3E4756B6692E36AC6CB2
            BC89BB6ED1B5656C6012BBB7A960D924A6EC303E62FCDCB5B2F2FD59FD111B73
            49BFEB4D2CBB2DFD6D65A2145A7950AC4CBB5623B19665DCA1D222CE4C6A4E49
            491D7602CD222A60ED064A7AC6D22280BE76D5DEC9F798B4924AEAE4AE572416
            0C4654E5D02B644748F0E5BCB97CB0C4B9963572DB4E09900C1242B484161CB6
            51B0182870AFE63491CDB5A49B7160A1848DE62A239395C972D1F2A9BB76E1F2
            964549239DF5FE9FE5E77F35A1AAF892FEBF5F96DDD771ABCC23122B2970ACEB
            1F4F3D304ED5CA03B87DDDDC8C2ED2EC8CDF687FC133BF68C7BAD3F50F02EA77
            3B64B1492EB4CDB2FCCD16FDB2C5C6D62124DCA8842F1BC829B7E5F8C6DCAC13
            5BB2B43B61D8BBF710AA98CA38F2F0BF70B28C360E70AAA32A343C0DE32D47E1
            BF8C749D734B99AC751D1592E2DBCC3B961923DA4A30511FDEDAC9B533959173
            85F2D07CAF1970CD0CF32BA981AAAF75EEBECFFCBADADF2D8F99E2AC869E7196
            CF0AD7BDBC7C9ADBCEEF6B767DB7FD8C89365D010A2AFCFE5A2236C8D9977E07
            CBC13FBB41D58E011B14135194655181B7795C33C4179DE0A96051413B8838DC
            0E64900E545727F03BE2A58FC67F871A6EB561B9639A0C4917CAD2C0626DAC84
            6C24B46CC4038DAC6352B90C4D75B1C2D14AAB1AC71CAB8384CFCA372AE0ED40
            76F6EA372C4BDB711FE71E6B9657CBF1953058856941B4FE4F7B5BFAB791FC75
            88C354C3D6951AAAD28BB35E6852FE44A646FDD80A150CACC9BD00675CB920FF
            000824302CBF3E4156CD4989A3902A8B83B4E0066762EA19C81CAA8CE14004B0
            077FCC586DDD1428BF2155F2FCCDBE5EC0AA30DB0AEC281B76D54E79C7CBC8D9
            8C24453C9FB43EDF2F76E24C7F2C7F3AB373820618B6772AB1DBCE36EEAF3ECF
            FAF2FEBA6BD598587188945C2CA238C292123618015549452014F95CF0AD9057
            8C92C2894B5CC4CAC449B77060844847DF566DBB5CAE7F79804FF0AAFF001114
            EB0D365BA9EDE3B781A69E5658E28E3412316051027C919F9B7246303A65B1C2
            2D759E1EF805E30D72C63921F0FDFAC28EA8BF69296646D20E7CB91BFBAA98C2
            0E49C6D25B6FB194F0EE6999CB932CC354AED7FCFB84A6FD6D052D97F9A673E2
            31987C3ABE22A463EAD2FCEC720CC64900F32312C8BB1F127DD24941921863E7
            77F94B9C6CF972724247721F0D1BAAF98DBFEF8FBCC508CE25F9B1BA21F45207
            0CA2BD5345FD917C5971A4DBCD24DA5D9C85771B49EE245689BFBBFBADE817E5
            4C63760020E4B1A92EBF63EF1547652FFA669370BE5B2794B72ECEEA03E07CF1
            6D24E54738E47CCCC3AFDA47C1AE3774FDB2CB2AD9ABEB1D6D6BEA9FBD7F26AF
            7D2C99E53E28CA94B97DBC7B6FA7F5E7B1E57165CA21591B738DAA64DFCABA03
            FC4F92BF28271C32B9DCBB81A8ED86C5878DBE5844E38D9930F07A6DCFF77E4C
            FF0071BBF6FAAFECEBE34D3ED1EE66D0E5655756716D3C5349CE1090A987270C
            46E5390114E0E5857257FA55D6877EB6D79673E9F7306C568A64685A3CF9276E
            D6C6DC8C6155F07D1CE40F8DCDF86738CAACB34C255A3CDB7B4A7285EF7B5B9A
            2AFB3DBCFCCF4B0B8FC3623F815233EFCB24FB766565DD0AC7B964C6F590A952
            32F856230E1537170982003966185219A9B21F36D36EE59E3C32AB0C49E63792
            40C6E673CA82D80A49122E41F9F289B5600AA235955000495561FBA550A06410
            7749C01E5E327EEE7E675D4A2669B0EB21742BF290DBC159582F0A33F29076E1
            F823E53F78F8CFBFF5FE5F9743B75E8492C8CD21F9BCCFDE6D019C957612395C
            70FC82A01C10402490BB5408AE3F7362CA72B6E150664FDDC698185625951531
            98C9F9900218E46D62659E5FB35D6E2FE536F705E452AB81B883D46E50AFB882
            DD10E141CEDF2BFDA6FE212F84FC2916916934315F6B45636C3AC6F1DB158C30
            250A85DCCA067952320118C0F5F87F27AB9A63A9E0E82D64FF005D5FF57F2678
            1C459ED0C9F2FA98FAEECA2AEBCDF97FC0FB8F21F8EDF1124F89BE3C9BCA676B
            1B6CC3610C924AA6752EC1A450C09CB49F2E1795DC800E315CCE8CED3DD33C5B
            9A492D6764748F0C375ABB02067E4566652149E7CB1F701E6AA49E5BAB32848F
            224976C6202C1597A85C3A90F2AA82AA72028DA4C7B5ED787E169676DABF2FD9
            2E3795DBE5FF00C7BB2336F0C5507C9180DB8EEF998B60C66BFBB321CA68E5B8
            4A783A2BDD8AB795ED7FC7F27AD8FF003978833CAD9BE3EA636B3D66DBF24B5D
            3BE8BA6FAEB6D4D6F867F0F6FBE2DFC43D3BC3BA5DC59C37DAB3CB15A49772CC
            23508495DCC14B15FBEE005541BC12415007B827FC1313C677BA8B69F1F8A3C0
            51EA4DE6462D935290CC872AEE36080B0202B92A318DCE71F361BE7AF0FEBFA9
            7853C4106A9A55F5C69FAA59933437B02BA5C24815E67915C7CF960CCA71BF02
            463D179FA77F63A8AE3E16FC39F889F1AB5B59A6BDB4B77B2D2DEF43B7DA6F66
            9086255BE7397F2D598336499BE665048FB3C8E8E12BD4F675A0E4F56DA76B25
            F9BEC8E9C868E12B4FD9D6A6DBDEF7B5924AFDB5B7DFF82F37F879FB1878B3E2
            178BBC5B616971A369367E0F9EE6CAEF55B99DE0B082589B71547DA785688609
            E154AB10ACE2A8FED01FB276BBFB3EDA69BA95DCFA5EB5E1FD5644361A8E9F2F
            9B6B3A828C91B336E2088E305320960C7E62032D7AD49AA49FF0EB9B9BE86432
            49E21F1297D46E15F0F29F3C9F98800963E547C1272B9E8080D7BE14411F8BBF
            E09AD636BAA797716B65E2DB2B7B769E470B14325D5B876CAEE039B8B800E5B7
            7214166E3D8FEC6C14E3ECA29DE51724FA2D745F9EF6D6EFC8F6A391E0276A50
            8BE6945C93ECAFA2B5ADADBBB5ADEDB9C2F823FE09BFE34F13784F4ABCBED53C
            2FE1DBCD6E212E9DA66AD70D1DD4FB511D0321560555133D77E0306DB8F2EBC5
            FE247C3DD5FE1978AB51F0F6B56725B5F69723DACF190DB57746E570543758F6
            05638254804796B81F447FC145F5EBEB3FDB2B455B394413E8B65602D1910EE0
            C1DA645C060CC77C849D83760310B9EB4FFE0A9D656EFF00B4E696D1AACD35D6
            8B66F74AE04997F3248CABEE618C4239395E4741BAB9B34CAF0D4E8D5F65177A
            6D26FBE8EEFC9FE1AF4DDF166793E129D0A8A945A95369377BA77DFF002E9F86
            B7F9B41325C6D21557CCCF979DBB1CF9A59481F71F6BE7683C319B632B215597
            44D22EFC41796967676B757D757412DD6DE08497B8601A44C291962CEFBB0148
            5631E5646C93EBBE0AFD95743F177802CF5697E2BF80AC65BED3A299AC6E2F11
            260182CC62906E0508705B006E0CD8F9B249F27D135CBAF0D7886D754D3EE9AD
            6FED65135BDD42C866570F18C8601B909E6361416CB36411B957E76AE0E74795
            D5F865DAD7B6BD16B7D7FCF53E62A60A74946A555A4BB5BAFA3FD7AEF6DBD43E
            2AFEC51E3AF82FF092DBC5FE21874DB6B3965446B41745AEB74BB1B2C3618BEF
            206059A4C29DA7715014F823FB1A7893E357842F3C4DFDA1A3F87FC3F673343F
            DABAC5C3430C8F962D226158EFDC10B39623394CB7CEA3D53E22F89350F1D7FC
            12E346D435AD42F354BEBAF10387BABA7F35C1F32E542EE719C051DB2C7D9028
            AAFF00B56DCBD8FEC27F076C6CC3C76FA8C7F6FB8548C0696E9A10C18EEC1FBF
            34DF310724B9C7014FD47F64E0E2FDA46EE2A1CD6BEEEF6E9B77F3EE7D84B27C
            0C66ABB8BE450E7B3EBADADB7E5F2EEFC6FE37FECB5E2AFD9F7C6363A3EB3636
            D75FDACE9F61974E412A6A6A1C3FC99C1DF9915190A91872C013B437A541FF00
            04C9F1B5E694B0C9AF785E4F107D996FFF00B1A4D40B5DCA8CACAE1B080FEF03
            95043E3E500B13923D93C1DA45AF8AFE16FECCB36B6AC6F2D757786DDD9181F2
            C42ED090A532559ADEDD7760F38232B9DBE5FE23D6AFE5FF0082AB35C2DDCFE7
            7FC24B1C0ABBCA810E162619552154444E71D4E0E0EE761BAC9F07492AD34DC6
            4E365B5B9926F5EEBF3D6C91B54C8F034A3EDA716D4B9525DB99277F36B557B2
            F4B1E39F08FF0066EF177C7AF1E5FF0086B4CB548F50D3379D4E4D41CC3158C8
            AF36F3271F78EE6C2800AB64AA3619874BF1AFF627F117C1BF050F152EADA0F8
            97C3AB722D65BED22EDE54B72AEC8413B4FCC247910382E57728DA8E2BE9EF16
            DADBF8674BFDAA2FB4D8E2B6B9628931E8CA1ACE3965246EE1834B349BB20609
            203019AF23FD8C5E7BEFD8F7E385A6A1E72E989A6FDA60594151E798A475C720
            8CF9701E707E5230D804AFEC1C2D37F5792779A93BF6B74B75DBAF75B9553877
            0745AC34936E5CCE2FB5AFA5BE5ADFBEDDFE611B17C27691B22CFF00E9324B2A
            8C6D63E44287765C8DC5A40A00C6DDF8050AE0D6C79076EE7791A42ADE57C9E6
            3F70143203BD0C800FBCBF6858C8E63616E59377866CDE32CD22DC4E89F3FEE6
            20042AA0B36E5E5C46986057F7873B5415154B792F3793B8ED52111549657431
            AC49B482C4931B8D8C5C9050138DB28F87A9752B7F5F9FDEFAEBA9F0359352FC
            FD6FF8FEBE87DF9FF049DFDA1BFB63C2F7DE01BEBA5924D17CCD434F7405FCFB
            77725D4B141928CE98C649F35400363D7DA55F8BBF02BE2ACFF057E2CE87E28B
            292493FB16E184C2261279B6EF1E241BC8057318762ED8F9D87C800F97F64BC3
            3E21B5F14E8567A859DC43756F7D025CC3244729244E328CB9EAA4746E87A8AF
            D8B82735FAC617EAF37EF43F2E9F71FB5F01E6FF0059C1FD5EA3F7A1A6FD3A75
            E9F7799A1451457DB1F76145145001451450015F8E1FF05F2FDA64FC51F8F7A5
            7C3DD3666B8D37C0907DAAF444AD22BDF4F119551A2E4164802A91F2B6657195
            2463F5B3E2DFC48D2BE127C37D73C49AD49147A5E87A7DC6A1765D9547931465
            DFEF119CE02F7E597D6BF9BAF8ADF112FBE357C4FD77C4DAD4935E6A5AF6A735
            F5D16264F96572ED1A02ECCF841B44679088D80CA7649F3FC458AF6586F669D9
            CBF23FA53E8D1C25FDA1C412CD6AC6F0C3ABAFF13D17DCBBF75A3E9CFA15332B
            6E50635127C928900CC6515D58105B036307271B5B2DB00411C723B595ADC363
            1B161C08C1D89205523AED1BBE4661C03878D83459DF4E52B7512F99FBCF390C
            B26D1BB77CE503AF3960AA1DD58E0C9183F2B9DC508E452CB2336DDF995C24D9
            DAAD8320F909DAB23B212B8DC09246F006CF85E6B3D3F0F277FCFF000F33FD05
            4AD6B6FAFF005E56DBB7DC3A73FBEBC863915A36690125836E00CF110C1F0BC6
            582AEDF9C8080948CB55EF0E3AADF48EAB1B2436F7814962D1B6D8C3E39C9667
            D9239F9BE61F3B91C6DA22491E2F319BCE58C07408C154E0B857C9188D0B2440
            6E1C79795E54B54FA5DEBE8DAC5BCEBF7ADA678776E09E6AEF8C3A9040655F2D
            F6E090079AEA0A0F2B711D1DDF4FD3FAFC7E444A29D36BEEFD7EED3B25D74D48
            25B668D8C7B24918A85DAC03199595F3D50871B8956918316562141675CFD79F
            0B7F6E1F853F123F667F09FC36F8E1E14F166B90F816E449A16A1A15CA9B8309
            C936EC3E5C068B6EE55DF958783E62EEAF93ED6E34B486355D32F1A4DAADB16F
            B7B3952DB881E493943E60DAEA64F9013BDF72528BCD323863DB6778C234C845
            9D5D64531EF4C614970EC59536B6DDC1881BC0DBD985C54B0F26E0D6AACF4DD7
            9E9FE5AF5E87CCF1370BE133CA30A38B524E9CB9A128CB965196D7525B5D369E
            F7BBEE7B3FEDDFFB66DAFED6BE25F0EC7A0E8ABE17F03F82748FECCD0F4F694F
            EEA02A864762990A1A348D3E42C635DAFF00312EC7C2EE3CC677DD234770D208
            C3EC10AABFEF98EE64C64AE4B30046033BAB16DBB7425BBD3D6768FECFA87986
            5F30335C0E724F96E47924166922CE5140250E3E565CC4D77A4C314729B3BE5D
            A920FF008FE462A308E1490A005F28803952B93F3042C6B3AD88955A9ED26D5F
            E7D36E9FD2B6C766439161328C0C30182A7EE476BBBB6DEADB6DDDB7BF57AEEF
            5BD6F94CDE6AF9F143319A7430B14700B055E8A70CBB58F01B0B956003807ECC
            F877FB46FEC93E04F12E93E2FB5F86FF00102C7C45E1F961BDB6D261B8496C45
            C288E48E540665DCABB4B646D1F28F9382ADF1FBCBA65B4E59AC6F15ADDDC319
            2E976855886036E894797B7E4DA429FBEFCAEEC3ED9F4D1710471D95F3342502
            A1B800B6C2594C89E56FEAC8E5492C0B06F977965AC2E2BEAE9B859DFBABEDE7
            6F5FC2E79DC4FC2B433BA70A55EA54A6A375FBB9F22927BA924ECF5D3CAED2B3
            6EFF004AF80BFE0A77ACF867F6EFF117C60D53455B8D3FC541B46D4F44676663
            603CB8E3892525B32A224632CA4334A57E42582F55AC7EDEDF087E05FC29F1DE
            97F037C13E32D1BC4BF106230DCEA1ACF93E569F6EEAEB225B44B2B48CC11E75
            8FF87241DCFB573F1BC37DA6369EAB0D9EA0D32C3B63496F23FE28D9BCAC98CA
            EE3247F361554046270BB45585BFD262BBF312D6F76FDA0C9B85E0C95578DD73
            FBA6662F9C052339910A8E413D51CDABC6EAE9B6DBBB5AABEF6D34B9F3988F09
            F22A93A7285394630518B8C66D426A0EF1538A7AF2EAFCD5EEED647D37FB3E7E
            DABF0EE5FD96A0F83BF18BC37E23D5FC33A0DDFF006A787F52D02E2317960F99
            8B63CCDA0905E41BFE74D920523E559179AFDB8BF6CED23F684D17C21E08F067
            872FBC39F0E7C0B0347A7585D4C1EEAF0FEEE3324CA0BA17550CA00DCCF894E4
            B3155F04B4BDD3638E111D8DDB4BB21DA89728E256511B2F3F71C86981DE782D
            B7E6E804B69A96930CF1C915ADEC96FE7A85297A0F9C17322B1FDDA8E2308790
            5CE59806010999E6756547D9392B5AD7B34ECAD657EDFD7A7661BC36C9B0B99F
            F69D28494949CD439BDC536ACE4A1B5DABDDF5BDD2EEDD1B71D3B527663232C1
            1AC922BE4B3092220EFC8C63CCC6436DDCE1F962E959F2A2A8685B6AED2606C0
            1198DF69DB862BB576F94D963CB1DAD8D9B10DD3A8C569A64767636BF67C35BC
            724D7171BD9F81B406454558C1477EF90C02B12551283B2C762A15976AFCB1C5
            3484E57044592A7002E5FA32A1D8D82705C79F2DFDD7F77ADFFCADF9E87E8505
            273936B47A5BF4BDFAD9BFF83A8EB85FB7C723332EEBADC8C10F9793249B0E78
            DD818FBAD860C02A92E36ABC85B8BD7C8491A4919C81F32346E58B272DF307D9
            180B93960C01644C297C1A3927691A6DD1ACE56492356678F6B44BC9DBBFE739
            20E36EE5190BCBAC9FE8F22A267F76E45B8DAD2A09A39B0473C313D481C332E7
            30B26E39F4FEB4FEBAFF0093B3A8CAFADF4E9FD5F6FD757D6F1395B884F9DFEA
            E4890CAC4821B91E611925B791943B70EA1B2727CB5594331BA40CCCB34921F3
            363306DECC7CDD98F9170088D8AB3152400CD2637360912D0C4AA235F2645018
            B18D942BC809200F94F961C61002140F951372A444FD9EC595A48D5A28821122
            958FE4432AABECC8DABB37320F9424A3CB6C36D737D17E5F2FF87D4AE8BE56FB
            BF3F979F549FD2BFF04DFF00DA1FFE15FF008F7FE115D46485745F1000F6F114
            558EDEF0A8419553801E36584464E329B433336EAFD058DE392DBF85D194CB22
            9750186159B237AAF200272A07EF972065C1FC6E4B936DA82C90DC490490DCC7
            2432A39F3A0D81D8BEECE7CC8CA7CCDB81250825C811D7EA77FC13F3E25DFF00
            ED87F0FB4FB7B3589B5EB526DF5240CCB1D848AAE1E46E010996CEE50877164C
            93B50FF2EF8E1E1D57C5D7A799E5749CEA4DA8B8C55DB6F4564B76DE9E5BF73F
            9E3C60E1D86165FDB94ED183F8DF44F7BDFB74BBDDFA9E9F67A4DCF886FD6CEC
            EDE4BBBABA0D188E143234AC04DB801F3640C13B497DA3AAAE09AF6DF867FB23
            35C491DFF8A6468648E52C9656CE37300E0A99250491D645DA87EEBE7232547A
            7FC32F83DA4FC30B62D6B1FDA3529A311DCDF48A04930DC5B681D15413C28EC0
            64B119AEAEBF48F0BFE8C380C042198F165AB57DD524FF00750DADCD6B73C975
            57F66AED5A6AD23F8CB3EE3DAD5A4E8E5DEEC3F9BED3F4ECBB75EBA3D0CBF0C7
            82B49F065B795A5E9F6B640C6913BC69FBC955010BBDFEF39196E58939627392
            6B528A2BFABB0983A185A31C3E160A108ED18A492F44AC97C8FCF6A559D4939D
            46DB7D5EAC28A28AE8330AABABE8765AFDB2C37F676B7D0AB6F097112C8A1B04
            670C08CE09E7DEAD5158D7C3D2AF4DD2AD1528BDD349A7EA9E8CA8CA517CD176
            678BF8F7F63EB1BD5F33C3778DA6E060DA5C4B2BC2D9C024386DEA7064249DE5
            98A9E36D7846BDE1DD53C2DA89B3D4AD6EACEEB631314DE642CFCB2128559B72
            072C372E536B290C768CFDBF587E3BF873A4FC47D3E3B7D52DDA4FB396682547
            29242CCA5490475EB9DAD952554907031FCC3E277D19F28CDE94F1BC32A385C4
            EFCBAAA53F2B2BFB376DB9172DD6B1D5B3EF722E3BC4E1DAA58F6EA43BFDA5F3
            EBF377F3E87C3FAFF882DBC29A2DE6A178EF0DA5AC6649182085990239C9F9A3
            2CE59C7B069140C10CC3E45F1F78CAE3C75E34BCD62F5DD5667256376CAC1010
            0286071942A57E62AC0AAB8C1C153F417FC1427C33AD7C1CD5ECFC2325BDC49A
            6EA8A6EE0D42283CB8EFB6A88D625DBC6E0E23DD1FF79E2FBAA55CFCC8E372C8
            A0C72798B34A9E515DAE0B1DC3A6181400070AB90429C2E7CAFC97C31F0FF159
            23AB5F35A6E15EEE1CAF78A5F369DF5B3574F46AEB7FC83C74E3B8E6389864F8
            497EEA36726BED37ADBEEB68D6FBF64B6F1EC2A8FF00DF48C8C90C408D1A424F
            03E655D8CCA47DCDCCEA096367C3E16F35586390A33496B32112305720C12953
            83B7B16DDF74312876FC8CD5046D1C97EBBA453279AACCFD64C796B23383C372
            CAAD90C492FCC8BBCBD1A5DFCDA72C324219E65B65223424AB928EC01C151F36
            66538C1CC91BA160FCFECB4EEDA7D6DF77E3D7B9FCE7196BCD2ED7FBFD6FA7AF
            6BAD48E341244DF2A2ACEC87F78A8B83CCA58829B780F229F97680872563386F
            62F8D7FB45E8FE29FD9CFC0DF0FBC33A7EAB67A5F87D4DDEA8F731247F699CA3
            6E68CA338032B75D7A1E4E15091E533C9A4CF24DE5D8C922B6F4C8BA4DA8482C
            30C212C06D847CCF823CA61CFCC59D25F69FE63C8B6B7CD22AC8E8AB7684A70E
            C4E3CADDBF0B1B03C920A863B559475E1B193A2A71835692D5F5B68B7E9E6FD1
            DEC7A186C654C3F3C28FDA567B5EDBD93BFE1D6DB9ED1FB377ED39E1FF0002FC
            2AF117807C7BA3EA1ADF8475CB97B9F374D64FB4C1387527037E36A98811B718
            60D8565906D4FDA13F6A3D0FC55F09742F877F0DF45D4B47F0CE9330BF91EFA5
            2D777570FBD938476054B38C1CE0BCB163CB046EF189E4B18AE26D905F7991F9
            823C5CC7832AC78FF9E3C00BBB04E761957705DF9573DDE9B64CB2476D72B042
            0CB130BA4064C212A1818B0A6456F9867E7556277A953276D3CEF12A92A09AD1
            593B6B67D1E9B6FD35D0EEA79F62550541356B5AF6D52DF47DB6F3F5D51F505C
            FED9DF0A7E26EA9E18F15F8F7C2BE249BC5DE19B78CFDA34D2AB657C2365685C
            AC9221F2C3481C2E01CB8462C2BC17F686F8CF79FB427C57D4BC45A95ADADA2E
            A0E121B10CCD15BC70AB4020C81BB760E0E13382CE0C78AE5C269F6314904769
            A9FEECAC298BA556DCB0216017CAF94BA2AAB1C6E03EF6CCBE24867B149D76DB
            DF4CDE61054DCC2AB2E625C8FF005430B86DA01DBE5E4644476D462B3AAF89A3
            ECA6D5ADABB5AF6EAFAFAB7F3F3CF1B9D6271343D8D4B59EF64AEEDB5DF5B5FE
            FD7B997705AF6C99AE3CB2B3060659885DC1954B60824AAAAC4FB506D00EE5C9
            2AC2B4B457B56F14DAB6A90DC49A735D467508A00E26084C6AE8842E038DD244
            0121732852AA37056C13E9EC6DD960D43F7904623732C4D952855464C3F30F2D
            09DA324F2A10B34AA2379B4D6B5C35ADE346F045B835E46555479A0E5BCAE763
            09406C90410AC406641E6276968F4F9E8FFAFCECF73C98CB5E676BFF00C377FD
            77DBB9F516A3FB56FC11D47F678B6F876741F885FD830486F61212D44F213BDD
            9B76FE54E5893D00419C04615CDFC35FDA77C1FA9FC01B7F87BF13F40F106A1A
            6E857E6EB4DBCD224F2EE212BE633248252A3E5579133CA9552000630F5E0B75
            7563B2F37D8DFCD249E6B4EAF743765FE79142888A16DC0AE3A80C0F040DA489
            A64576CAB6B732346CCAACB711C7E6483F7872CB0865521DFE618280A821032D
            7B7FEB157528C95AC95AD6BDD6964F6BFE0FCAECF7BFD64C526A6B95595B6566
            AFF8F93D7BE9D3D9FE3C7ED870F8ABC51E088FC11A37F61F877E1B8867D2ED2F
            1CEFB8910C259A71BC8DA42AAAE492CA4E1CB48AB5E8CFFB687C23B8F89D0FC4
            C97C17E286F8810DBEC5433C6DA7BDC88842AC5B7EE6CED2A1C260821BCB66C5
            7CA56D71A6C6F0B2D9DE4AA64420A5E22B1E0B020796AA08100914820B96C13C
            B80D88E9EF1B6EB7BD25832BE278802A463A342A0288C33A870A8A15C9D8431A
            21C41898C9CA6D3BDBA5D2E8ADDBCBFC8A8F12E2D4DCDD9A7AD9A4D2B5926977
            4BFA5647B57C0BFDB29BC33F10FC717BE32D2EE35EF0FF00C445960D6AD2C995
            668CC990BE5067DCDFEB18040CADB70776508AD0F88DFB4EF817C35F01352F02
            FC2DF0FEA96163E26B8373AAEA3AACA8D31406393CB8DA377070A46470555589
            04B3B2F82C977A63C65A5B7BC8E100A6C17430B1F39405E10D9752E46E20BAA1
            52C30504CB3D9FDA56492C6E3CC1246C49BC0A11F6C72162C211850B975C9D80
            190A850A36CC788314A9F249A7BF4D75DD27D9DFCFCB5DF38F1262E3071BABEB
            AD93693DECDF74FEF44379FE8FE1BB6959A4F356E25850DDA989F22085771C96
            0788F6B6E0CB87653B47C9557632131C6D249E53F96576B139695A31180C5C82
            C2365653BB76D4F96401A4692E6FC4F0C11C70C51C36B1E121E558C63CB241E3
            7316013730085B7919DA85D6278C2BED779245C4885B96063F2A25E3A00B8C1C
            C61B28EDC15640DE254D5A6F5FEB5D3F47FA33C1A9BDBCBEFEBF3FF83B2E8498
            9F0A76DCF12329DE36B223C7F3025B214AA282FB8ED0A1BCC214D7E947FC12B3
            E36BFC42F8272786EF2E249351F08CC2D8AB46CA4DBB06F2B208CA95292A119F
            97CA4C9CB73F9B1B564D9BD8476ECAC242AC36460B0691C000AF55870D960597
            2A095D83DCBFE09DBF181BE14FED27A3C1752436F67E260BA3DC44D13058A493
            E78D5405214A4E546092144846C52A76FD0F0AE60F098E8DDFBADDBEFF00EAFF
            003BB67D3709E66F079945B7A4B47F3FC74DBCDF767EAE514D89FCC8D5B9E477
            52BFA1A757EF0B5573FA1028A28A0028A28A00F877FE0BD1F1F1BE16FEC7A7C3
            7677821D4BC6B7F15A1442CB28B48D6496E1B2180DA42246D905409083F7857E
            2D5CA331757131380ADE6C406DDD1BA80C3E6C97DD8446CE0C9CE7E5897EE4FF
            0082F3FC6693E227ED91A4F8560B863A6F8234E8A2D8D260C57378F14D338CE0
            862A6D9369618D806D620237C316416716E36C52472052DBA46E7CD953721DC4
            11B8B44E71B589218AE1BCA6F80E20C473E2DC16D1B7F5F7FF0096DBFF00A43F
            475E1B8E59C270C4CE369576E6FBB4F45FF92A5E97B6AC7B233F98D22CCCAC54
            746560C91A6EDC73B8B2EDC83CBB10843288CBD327B8768D9E4F2FCCDAC1C074
            F2E4670CE17231F30F3010E71C26ECC6AF976A14F2D5BF772E5236421B607121
            0EAC0E30ADB80F986C5254904140B0C91C8F088DD18C8C2511068E01CB226231
            B430015DA5048CA83924031B194787B6FF00D6DFA6BF77CBF79D5EFDD7DEBF57
            B7977B05D28791BCDFDE7952901E47019F0AC1B7138218FCBB558A85E1F04464
            942A093E6B47FE9840322AB299017563B493B3E56E30FD79DE09243B4C6BE4B0
            1B4C7247E4A60AB233388F71DDC2ED70A0A92A5084C6D18DA56EE6F96F24DC7E
            E48652E7CC6DBB9C286CF2BB406237851852082577A1CADD92DFFAFC3F0FD25B
            49597A795F7BFCFE77B75BA0B990C2256B85C1CBC8EB244427F0E57E6C655A36
            CB06C06037394DA4B39E2293CD0F9972245EAEC1D9C948F025C70D92830CDC30
            C000AE44ACE743677A4A6E568DE7811DF7A8561E631276307DD82B27525F7121
            42FCD1D8F0D8D3ED3C45671EA96F746C56788CF6D0CB1C534B0A911901305564
            38DAAE136E470762AD3A714DFF005DFD3B7F5DE6ACED16E2B5B3D34BEBD17E69
            77D2FAD8F73F8EDFB1F699F0E7F657F0F78F749D52FAE7589ADECA5D77479963
            5FECBFED1B799EDCA95D84A37945413B5B6BC232A4935D4FC42FD81F4CD7AEF5
            2D4FC23E21D27C37A2E97E0AD2BC4D2C5AE6AB6F1CE66BF0008FCD5288A80BB6
            D76F977431800B329AD6F16FFC14B347F8A373F11343F10786F50B8F0478E349
            B2D334AB0B27D3AD6FB4CF24218E59AEE384492EC2C8B0869245DAFB0AB70E32
            F58FDB93C0DE285D5B4DD47C29E306F0CF893C11A7784EF041A9C02F81B0B957
            85D0BA08B7BB0D8F194E180C80596BE8B9B2FDA2D5B45DB549EBD6D77BEAAFBF
            63F00A75B8F15A53A524D3934EF192E59383E56AF1BB8AE78AD34B5AFADCF2BD
            67F631F1D683F0C66F135C59692DF64D321F135D696BAA4526AD63A7CF224893
            C96FF2B468F3491B64F96F868D88DAA333FC31FD893C5DF193E1BDA789B4BB9F
            0B7F62EA53DD594325D6B36F6F24B346CF218FCA906E3214DB2283B88C176C83
            BDFB5F1DFEDBDA1F89BC31E2AD4B4FF0FEA569E3CF16F856DFC27AA4F3EA30C9
            A63C3018237991228D65491D42020E228C303F38638E16EFE34E8137EC7F6FF0
            E8E95AC47ABC3E237F10A6A4F3C7159BB34696DB7CB2A1B6FD9C07E58B165723
            382A39274F03197BBAAB3EFBDF4E9BD9F9EB677EA7D3E1732E31AD846EA52519
            BA91FB29F2C396F276E7D527A277BDBA1D6F8F7F621D52F3C516B17875ADF4FD
            27FE115D2B5FD4B53D535CB76D3E337785478AE22C0C4CFE5AA960643B091B58
            8618567FB08F8FAE6DB509997C37A4B69777756966B7BABC16FF00DA53D9C6CD
            3C768065E68E2467FB8C13EFAEE52703D4FC3BFF000508F07F873C4DA56A969A
            2F8FB4BBCD07C23A67853ED76BA9DA4B70B05A23712C0EBE4489228C0F3495CA
            8D8577306E33E2D7ED57E02F8EBE0B7D2FC47E07D43405F0E6A9AC6A5E1B8F42
            BD86DADED175068A5686E91A02152272B26F401B1B86D58F06B79D3CBDEBCDAF
            6BE8FE76FD3B3F4F23079A71CD39428D4A1EE5D5E564DABDF5B39EBAE97BDD2B
            ED64DF21E32FD8D7C69E08F87DA87886FADF4C8E3D1A2B6D4351D2D75681B55D
            2A0B87710CD3DBE0BA2BB48071B9995C17077BE3C95DCAB2A3322C8BBE076924
            F90FC8C0B00C0E42B0DC77EECB160C19D015FA53E257EDBFA378BFC29E32D434
            DF0B6ABA478E3C7FA1D8F86B5A77D4629B4BB486058B88A144DEB24A2144DB26
            4212A159C9007CD72CBFBA766B89B632B4719F337ED46DAEA89CFEF1CE02F967
            B850410C5A6F37194F0CA4950D7BEB7FD2DB6F6BF91F7FC178CCEF1342A4F3BA
            6A0EEB96DA7457DA4EFAB6AFA7E377246ACB37CABB5A170A81C37EE9891BB70D
            C5B76E4766F9886F91C38C191226923583CC5DDB1A105556511B2E4E07217264
            C48AEA480EA181233C33AE5A38972648638E49248BCC724C7082D9665EABB433
            162ADC7EEC03B936488E767CBAED96391A5F29E30305331CCA1097243B8550EC
            5B38DE1F7BA601E1B77FEBBFF5FE7AFD9737E9F27B7F4B7BF477D49512D6E313
            1897648E1B011537859379C91F28C1C8DC0E4492FCBB143227907E686452BBF6
            DACAF93F21556051F79C1521613B4B12C3397742A2458CB6EFDCB7EF1E468B7C
            6188FBBBD885C92C5B1BB612410777CE19A5A8DE68FECF24B19FDDC692ED1BD7
            2CACA4EECB1390C5C6E66257E4F33761B731BFAFCFE5F8FE3E5A15DBBF9DBBF9
            F57D7CFCAEDC81DE797E5654F3C8C32398DBFD2363E572AB820B31048552DB00
            C48C7637ED12081650AC19B75C23C67CB4032A4AE300951B5B3B0803CC46CB30
            332BA788A48F183BA6526193017E600B7CA3E7C950D172F9054601E41D836C9E
            59586EF2E7651E6A236E21CABA337CA769E9B703CC0E573939635D7AEFEBFF00
            0F7FEBC8DB55D3F2EDF3BBF3B6AEC6BF833C13AAFC41F1DE93E1AD16C1F52D5B
            58BE8F4FD32CB72C22E9A49D228A205C05552CCA8C1B6A2100FCA30D27EFFF00
            EC01FB11681FB0E7C08D3B41B2B7B7B8F14EA16B6D2F89F5857323EAB7A91056
            DAECAA45BA1DE228C2A85566620C8F23BFC53FF06F8FEC7DE77F6D7C6AD7B4E8
            71B9F4AF0C192DC6D66651F6CBD84BC67E4F98C114B14A787BD8DBAE07EA457D
            A70EE5AA9D3FACD4F8A5B792FF0083F91FC19F494F122A63F30FF55F052FDCD0
            6BDA34DFBF3DD45F46A9FCD735F76930A28A2BE98FE580A28A2800A28A2800A2
            8A2800A28A280391F8DFF047C3DFB427C3BBCF0CF896CFED36375878E44C09AC
            E600EC9A262080EB93D415605959591994FE467C62F831E22FD9FF00E264DE18
            F1259C96DA923ACD14A8CFE4EA81660F1CD0C87064DFEB9DE0865CAC8E621FB4
            35F297FC1563F6793F10BE1143E36D2ED5A4D67C1E1CDDF929992EB4F7560E0E
            1496F2646594163B523FB41C1DC55BE278D3238E2B0CF174D7BF4D5DFF00792D
            6CFD375F3EE7C2F1C6431C5E11E3292FDE5357D2DAC7769FA6EBE6BA9F9B514B
            B6CE3543B9638ADDA304EDDABB5447C654AE5A43F31D836CA0E3749B964688B1
            2B1B178DFCD48F6AFCD1F98D180C02EDC97258A80AACCA633B4A054558BF712C
            6B1AA8DB3AA2AA2842C4428781C6482538E5B2F8C4673E645188CC61495F252D
            D0336D56F94344588E70C03487E5236C84BAE5DF2CFF008D2EDBFE1FF0DA2F4D
            B4EA7E19E8FB7CFE5BFE4BBED61F24BBC6E65B67559B7AAAFCD1ED112C63076E
            36EEC2820229611907182AAB1C877AF98CDDF76C2D97548F259472DB4AB332E0
            B1D90B9F3805DC3332CD279FF2AB6E9A70ACEC707734817804907731C9DC5422
            92A14B3364433C727991A33347E54F965521D9994A90781FBCCA853CAAEF2AAC
            630EC46FA5B6FEADE96EB6FC6E837FCFF1F9FE22891AD766C3F65DB24522876F
            F567CB1105CEE03E4058921B2AADC6CC023DB7F679FD9A7C3FF167E1A5FEA971
            078D66BEB5D6974392DF41B08EF2789255568E67051595708C1CF040DA7E5C9A
            F119B72A4BB7E5FDCCA03484E09DACB86CE7801E40320B6C66FBA0C657D7BE12
            FC77F0AF81BE144FE1FD5EC3C5170D71AD47A9C773A66A96F68A4C7BC2206299
            5FF585DFEE60919DB8247A993C70EEB7FB4FC16FEBA3FC7AEF6D11EBE4AF0DED
            EF8BF86CF7D3A696D2EB5FEBB36E3F644D6354F1BF8834FD2EFB4096C74CD724
            F0F5BDDEA171F658754BAC844B652EFBDA4705BE45076B15DB818224B4FD9964
            D57C0FA0AC3F666F11EA1E22B9D1259E6D4AD7EC45E00ACB0777F398C7952728
            4CA00E250A7A6B9FDB7345F197887FB4B5EF0CCD1DCE9FE2C4F13E9B1586A704
            7187114282194C8AD956F26377908C92241852AC2A85D7ED1BE05F12690DA5EA
            9E1DF145D69F7DE2E9FC57710FDBE3DD3096360210447BB6908BB812597321DE
            3B7B3530F96DDF2CB7F3FF0080F6EFFF000C7BD2C3E54A4DC27BFF00C0E9F7F7
            7B3B26ECF9EB8FD8F7C61A4EB9676930D156E248EEA5B857D4E10B6D0D94EC93
            5C4C5D94AC41936F3BD7E7032092B5CFF88BE01EB9E1BF88FA4F852F25B0FB4F
            88204FB0DEA5C799677B05C0451324A08DEAECAC012549E85982035EB1E26FDB
            6341F1B7885B5DD4BC33ACC971AF787EE3C3FADC96D7EB0AC96ACDE746F080A5
            4344B8563DD000F9DE0D79FF008E7E38E99E25F89BE0FBD5D2EEECFC3DE0986C
            F4FB2B6FB444B7122C0FE6F992395F28C8FF00BD258AAA1E0E4ED6C618BC3E5B
            ABA73BEDF3D7D345AFFC13971785CB22AD4A77BECAFB7E1D9EBAEFEAAFD169BF
            B206A5A05DEB9FF095C76970B6FA3EA7710C3A6EB36B2CB05D5A2E5D25049E23
            59149FBCE8AA3EE8E0F2EDFB2DF8AAE342D33528FF00B1A69B5A166F0E990DF4
            32DE6DBA70B6DBA26218AB79A02825B98D4B291B88DDD13F68CF0B695F1D7C5D
            E32934BD77FB3FC4D6F78AB6F15EC31CD692DE2C8F27CFB586D1890A02038E17
            0CCAF8E974DFDB42D7C2DE09F0EE9767A1EB5AC5D68377A7BC235578A78AC3EC
            854CE6D6478CC88B379241DE4AC4A85540C6C5D551CADAB4A5DFCEE95B5DADE7
            EBD0DBEAF94CD3F7ED66FCDF4B3BD979DBF4DCE26F3F648F14DBF8821B217DE1
            FB88E68679EE6FE1D46396DB4DF2804BBFB44A5BE465696DC31607EF260B6191
            B8EF89BF0B752F855E255D2F565B558E6821BEB59EC26496DE5B793CA55B8824
            1F236FF979C28010AE47FABAF42D2FE3AF817C33E29D65AC7C35E2B6D2FC69A5
            DCDB6A36B3EA713CD179D2C2F11B6C264B2B7003972E1B3CE3E6E47E3A7C5483
            E29F8934992D6DD74DD2B40D36DF43D3924984D218A091903CB2064566E5D885
            E00643C01E6579F8AA1818D16E94AF2E9DBF25AF9BDB5D1F5E1C761F2F8D36E9
            CBDEBAD2F7F576B2F56EFB1C43B6FB73215556DBBB024DBE5868D768DE48C280
            C72090490B23175CB05BA87796DCA15448C58CB1FC88DE52860DD0A7CDB4919D
            E32A41908568DC901F323FDC347B4A2B47217631E5C3BC430739CCAA0A86E986
            6C36EC300DA0B18E395D2191BE745943E0AA85E000401194C00149DDB4B8DA87
            C66B5D76FEBCDFAEBFA5CF9F96B3D3BBFEBCF6D3F2D491DD4CB234D1CDB5A53E
            7C727CCCEBB3CC7DEA303772371C03965DDE56DCD4685A683732B334F1626915
            958BEC9544CEC4643360AB670769058AF2ED4F857CBB85895EE1648E7CAEECF9
            836201BB27938682525B18055BFD59232968BE7C9131DD1F9860CF96795CAAA4
            7B00E41DC23DA172CAA491E626C351A5BDED7BFDF65FF037EDA226EEF78F6FF8
            75F8F4ECB60917CC66C8F244CD2A3924FCAAC15B72E4F25618812C187452F212
            E42CDA5EA975A45E5BDE59B3D9DE58BC53C1E5CA4FCE8730900825BE62CAA8C1
            7E45C8C2EE7582C62F3668554C10B33C6498E3429C0C92C3680CA2550303084C
            5862368646D91FB5471EDDCBE72C4E0331054BAC6CE80E0B364346412BB9F6BA
            82DB763D464E32BFF5FD6B7E9F90E3270D57DFE5A7F5E5DDEC7ED07C01F88F0F
            C59F83FE1FF1043B00D52CA39DD54F08E461D79E721C3024F5209191835D8D7C
            8BFF000488F89CDE22F829A8786EE270F75E1FBA122A08F005BCEA25439C0049
            91A5E5720E063800B7D755FD0992633EB582A757AB5AFAFF005FF00FE95C8F19
            F5AC0D3ACF7695FD50514515EB1EB0543A95D2D9D84D2492794AAA7E7DCAB83D
            B05BE5CFD78A9ABC83F6F9F8A9FF000A67F637F891E20599219ECBC3F76B092F
            B1BCC92330C654E78224963E7D7038CE4272E55CCFA1D997E16589C553C34379
            C9457AB763F043F6A5F89D27C6DFDA33C77E29DD24DFF0916BD77246B2CAC5A2
            4797FD1D487F9536C6A89B4E1C16400AEE1BB86DCA8FBBE66450191E4881562C
            F266428327F7806D1804C9E690BB59A4C24037DDC691B46BB54C2CDBA3FDC859
            086CA9E0E378C82C480EC3F76CDE5C90F9A8B68D3011BECB30C44A0B129E5441
            838E3770B1B92E70548572A0A95FCAEBC9D4AB293EAFF55AFCFF00E1EE7FAED9
            0E5F0C065B430905A538A5F87EB6D2F6E9D7524667B68C8DD2ACCAE515646559
            7CC8D176EE6C9F9CB38F998608FE32A54B93BF94677568D3687505D7E5407396
            70C0F56566C3038F99DC90B524C8F0C970B186693CD96D01C8413160DB779C6D
            E59B049006E914E1999184734BE5A798BB9D56379373208C6158A2BB296FBD1B
            05059B98C08CC80B2A94C232DBA7F4BFAFEB4F5ECF65DB4FC7FCF4F2B5F46C71
            46F3E68E33B5E3570A1B7CCD192CB0856520E582AA7621B3CB6D2CD2FD892FEC
            D5E15F83FF00B397C5EF0DC8D1F883E23787B47D0F539DA6D2E28D7459AF6EED
            888EDEF37BCBB82CAA642C1776F272DBF15F1DDD968448AADFE8E8F3CDB5DCB2
            8C39C860C546F56453B81036C9212D93E737B96B9FB7E78EB5FF000EEB5A4DCE
            9BE13B9B8D7EC2DF44D57529B4ADBA85F79007D99E6915953CE4DB952A026595
            8AB2B21AF472EC450A49BADBF4DF4DFCFD35B33F3CE3ECA73BCC23469E5524A0
            A49C95ECEF19464B75B594959352F855ECDB36BF6B5FD842DFF651F87F6F7B71
            AD5FCDAD45A99D2EE2C6E6C12CD6FF00744CF34B685EE1A4920464589CCB1C41
            CBA3A9246E8FA3D4FF0064EF0BFC4487C2B0DC788A3F0F58DBFC29FF0084C7CE
            D3FC2AAA2F63B633ADC9BB02E7F79336D6019542C83E455523E6F17F8DDFB516
            BBFB43D8C2DE20D2BC269A9BB5BC971AE5BE9DB6FAF364422F366624A1424B06
            002062A1801F2B2F4FA4FEDEFE2FD3ED6C238FC3BE1066B3F0D3F845236D2C9F
            F40B8D825B7933322EE93320C304197C6C1B80AED8D6C0AA92F77DD695B76DEB
            D75FBEDB6CFCFE6AB64BC67532EA3CD5EF888CA6DB5C8924E3656D1AB27DD5EC
            EEDBB9D3EABFB0DE8367E248F56B5F186ADFF0813783EDFC6CDA849A4A7F6A98
            67B87862B658566286E1DBE457F347C8ED866284D3B54FD87FC3FE05BCD53C45
            73E2CD4BFE101F0EF84F48F14FDAC68B6F2EA0575132C569662DCCED133EE2E3
            2250842E1411230AE4A2FDBCBC5A896912E89E0A5D2E0F0B3F8526B17D35BECF
            A8E982643E4CE8D203B84A0B6E565642773E090B562FFF006FEF1A6ABA95C7DB
            745F03DD586A5A2C3E1ABBD25B4971A6DCC16C7CC851D0B8398C96DA57600093
            B0AAB383DB65C97C3E7D7B7AF7F9D937D55F9A596F1ECB49554D59ADE1AABAD7
            E14B99C6E97D9578A4B73D9FF697F835E0F8756F8E7368F63A0F87F4BF0FE9BE
            18BA8E1B7F0B4323DA417115AEF96CB6CF12C33334FE63445595818D7857515C
            E78CBFE09E5F0FBE1FBF8B3FB47E247889BFE1036D29F5936BE1640248B538CF
            D9BC96FB592AF171BC9C10220724226EF39F12FF00C1413C5DE321E265D53C3D
            E007FF0084D349B4D3B53DBA63A7DAEDAD9666846D1222AB22A26D20156D9C67
            6BB54BE24FDBFF00C5FE2F7F118BEF0CF80E697C5FFD98BA98934FB82B74B68A
            1AD14869F3B73BD0E0229F9C13BB26BA2B63B0139B738EBAF4F37E7E71FBAD7B
            EFE4E5FC2FC7382A6A8E1AB72AF76F6706FDD54D3D5C5BBD94FB36ECDF4B7597
            FF00B08784BC0B7DE38B8F1778FB55B483C03E28B7D06E7EC1E1B137DA05DB79
            D05C238B81860EE37C615880A412EC406EA753FD8A668BE1E37C37B5D3FC3B79
            E2EB5F8C56DE19B4D6A5B24B696E6D66D3A69C6F74264F2CACA18A2B31013920
            AB30C7F0C7EDF1A4EA5F0BBE236B9E26B1F0CDE7C42F176A9A7EA96FA6DC787A
            5BBD2651671344B249FBC0C1CB485402D8DD08050A1CAF9BC9FB7CFC427B7BB5
            925D2DB52B8F16AF8B65D4C58FFA50D49731A48A59954830B3C1E5B2E02B84C1
            120661D6C053B38AF8974F57A3D77D57DDDEC94C72DE3AC74A74AB4FF8728BF7
            B9546FCB16DC5A8A6D26E4A5BADAC7BF7C79FD8DF41F8B3F15BC3BA5EA9E2487
            C2DA9FFC239AC491DB2F8523B2B98AD74D91597CD816ED8881A0DCD14ABB2622
            205F714623CB6E3F61AD1354BDB2F10691E32D407806F3C1F75E33B8BE9B4A30
            EA96F04337953C42DE3976B48D205DA565546126EFBDB9AB93D33F6EAF10F877
            C7B2F89B49F0AFC3DD3F509AC2EAC677B3D2648D6EE39F68959CF9AAEF27CAAB
            F33011A86398C105E3D1FF006EFF0018E876DE1F861D3FC26D67A2E8F3F87BC9
            934CDD6FAA58C9B5E78EEF749860CD1B4C4ED4657DDCE240B51531597D59734A
            3777F3F2F3B77BADEDD4ECC0F0FF001CE0A9428E1EB7BA95ACF92DAB77B68F54
            9A49B6D2D6E9A3B6F0EFC00F0CF8D7E0BF8D20F00EB563E22BE8FC45E1DB3B2B
            DBFD04DA5E5B1D4018E38965F39FCBD92878A4411BA332A10CA180AE67E3E7EC
            99E16F857F07B5AF10787FC65A96BB2785FC57FF000856A91DD6902DE196E7C9
            67924B63E7CAD222988AFCE06E25A4C2E0E70F4DFDB23C47E1CD07C41A4E87A0
            F837C3B0EB97B63A898F4CD3258A4B19ED522F27C842E36ED18621C30DD39C82
            5F6549F18BF6D3F137C69F02EB9E1FD4B44F07D958F8A7525D7AFEE34EB116D2
            CF7AAB27FA4ACBE6E0CAF1385383B544A42E0798D58CB1182953B35676ECEDE5
            BB6F4FEBB9EB61729E32A58D8D4F6AFD9B945C9370726AD0E6BDA3AE8A4928DA
            DAAB1E3F2E658B73168F7C4E0B95F323C4830EC108E466489CAB336F663CB940
            D524727DA27858F9BFEB96451E6798C1598305539CE0F97D723739CE0B26000B
            1BC6936F99894A2B091B064126D0464828CC2211FCE7970465725A56DB27DB19
            57CCFB434852194B932F9990A1890541248531FCCB8F99B6F2DE51F0B7FEBFAE
            FD5FC8FD9BCFFABE9F874EB7BFA91C448B38D99A3FDE2A7C8D86505B6FEECEDE
            157CCDC7042E73CAED8D88D8F03F82752F891E38D0FC3DA2DBB5E6B1E20BE874
            DD3E172A86796E1BECE9F3B38C056755196298951CB7CC0AE4C04DD0F3215693
            200C08F2E0BB17605067180640D9DC0E036647DCB5F467FC124BC15A67C44FF8
            28AFC2EB2D56CDAFACE3BC9B558F123A7EF6D2D2E2E2198B06DDB7ED16D6F200
            5983ED1B9A45381B50A2AA558D3FE6697DEF7FEAFE9A1E3F1266DFD9994E2B32
            B5FD8D39D4B6FF000479ADBABB6B5DD5DF5EA7EEAFC12F83FA2FECFF00F093C3
            FE0BF0F4261D23C39651D9C05923596E0A8F9E697CB55569A572D248E146F777
            6C649AEA68A2BF548C54572C7647F90D8AC4D5C4569E22BC9CA736E4DBDDB6EE
            DBF36F50A28A2A8C028A28A0028A28A0028A28A0028A28A002ABEAFA45A78834
            9BAB0BFB5B7BEB1BE85EDEE6DAE231243711B82AC8EAC0865652410460824558
            A286AEACC1A4D599F8C3FB437C2F3F047E36789BC2F27DA162D1B526B6B7374F
            1CB235B9DD3DB3B943866689A36C33C60B34590BB19178D218E5378F94B06467
            077348F146431F9761E7058A804237DE495157EA6FF82B8F8321F09FED2B63AC
            436935BC7E23D222BA96790168EEEE6176B79150B92BB85B9B7564002ED6076B
            BBE57E5B6CDA05DCE636B7772AEA198AE6305982B64B05500156E0AAB0711E5B
            6FF3B66F85585C755A2B68B697A5F4DB5BDB7B75D977FE68CF306B098FAB855B
            464EDE9D3B5F476EFDB4B063740CDB199364BE6478F9F6142EB1B8C90AA4142D
            961B76B6DDA5559BE96D4BE01E87E01F819F12BC33717169AE78DB438B489EE6
            76D3628E3D2A7BA9A1DD1C1727F7814AC8AA721170E080017AF99FE44655611C
            5E4A0976BFEFBC960021C2B1C9D91EC20EE28E20CB670C62F58D5BF6C0F156BF
            A56A7A7CFA4F87E5B9D62D62B0BBD41ACE61A8DC79727EE65765C334B1B46082
            170193054C8154EB9556C3517296237B59795EFAFABF9FE46B93E230945C9E23
            57D34BAEABFAEBDCD4FDA2FF006545FD9EBC33677926B57575AD43A925BBDB4B
            66B0FDA4A45BDEEAD7323CB2431EC3113228525FE5E1863A1D4FF678D17C6571
            E1D8E4F115BE870DAFC3AB7F1179F65A118DAEE08FCDDDE72ADC959270AA1F78
            C07C805576015E51F14BE3DEA5F192D95354D27C2EBA8B4AB732EA365A7A4377
            A9C82178C17906E0E7720CAC69B1DDC32904A56EC1FB5DEB56AB16DD27C26B14
            7E1E93C2AB2C76926E7B27DB23A7120E58E41DBBB2CEBF28320AF42188CB6355
            DA3EE34BBDF7BEBDAFF25AF91E84717962AF2D2D169776F7F55FD2F43A2D43F6
            5DD2F4ED7535187C4F7F6DE11B5F0BDBF8ACDEC96205F44924E163B7F24CDB5E
            52E9B54B310411976015A967FD95B49F06DE6A9ACDD6BDA82F857C33A5693AD4
            9236961EF25FB5ED36B0087CDC070A194B34840C0C2819AE761FDAEFC4486CE1
            5D17C23F67B1D28F8724B41632CD05EDA990148A505C3F0F991366D762189186
            0CD25C7ED8BE21BDB9B8B8B8D2FC2B73A7DFE976BA4DCE9F269E63B29E18599A
            06644700326EF2D0A3600D9945E28F6D94C55D475BF9FF009FA79FCD9A42A64C
            EC92EBE77D7A24DDB7EF776EA7A87C73F857E1DB7D7FE2FCD656BA369365A526
            8172D6CBA1432DC5A4532DB6E92D584A8B113E610EBC893E55DCBBF2313C41FB
            1C784FC0B71E228EF3C69AB093C15358437ED0E8C42CA9782368920FF4907723
            3333671B77B95E803711ADFED85AFEB1078816F342F08DDC7E20B6B48AFD9ED2
            48DA64B539B7CAAC8235658FCB2319561B5771DA733EB3FB6578935D6D71B50F
            0EF82449E21B8B49F562D6737EFCD9345B5252242A57E4E41F98A6F00290A1BA
            AB63B2D9CEF28EFA75F3F3DB5F5B26958DAA66595547CD357BFAAEF6D9DFB77E
            FE66CDC7ECA7E1CF0BCDE267F1178DB50B787C37E204D025369A179FE7ACE144
            3280B28312958BE70AA19554AA993000EB2F3F663593C076BE0EFB368D7FAD5A
            7C4E8B428F5316CB049716EF69E702F20FDE3261F795DCDB48DA092AA062E81F
            B5D69ADE0AF186AFAF59E8975E32D6357B6D4FFB3E6D1E59AC1668222A0F3303
            14A5D65CF2492A40560EA0710DFB6078D20D3AE23F2F496BC3E206F1435F8B69
            D6E0DF21706524305DA23509B5C1FDDC817202332BF6D9653B4A2B7EDD2FD1F6
            76F9FAD91AFD6329A3694568D37A76BED6BBB7DEDF45E7EBFF00157F673D2FE2
            1F8DF4BB5BEF105A787AE2FB46BCB948E3F0DFD9E610D94A42F9D69E79630989
            0F920A891E38C2B86642CDC04DFB2868F7D3C5AA59F88B528BC27378626F10CB
            7773A7A0D421804A6DDE2316F2ACF232A8522458F0CC3180A2B12C3F6AED634A
            F19C9AC5AF84FC0B6F71756F77693C31E9132C770B33A248F2296DC589455C12
            117CD65DB9F35841A7FED79E25D2ADF4358F4BF0A8B7D17459344990D849247A
            8D9384324739FE3C18A53942BF32487905C563531996547CD28FE7ADB4F4E9FD
            6CB9EA6332893E67177F9F97F5D3D56A751A0FC1ED07C51F0EFC4161E14D534F
            D7FF00E2A0D22C6D26BDD0DE1BC905C8444067F34BC71F98AE1D02BAE61DEA54
            72313E34FECF1A27C38F8777DAB693AFEA5AD4DA0F890F872FE3BCD39608EE27
            8D659249633E6312AC1554676918070300B67D9FED3DAE687A56ADA6E9BA1F85
            3455D56F60BF636B672C3358CB6AD1F96D19663B550C458970402F216243E55B
            E3CFDA735BF89BE15D4343BED07C27636BAC5F43AACED65A7B89A4BB6603CCC4
            8CC77B890A3291865258261B230A988CBA54ACA3AA4EDBEFBAB6BBF9EADF4EE6
            55313962A4D38EB6F3D2FA7AEBE69ECBE7E6F0858E48C348AD0868812AC572AA
            A42B863818DC76641C0DAC37C69B4A4681920559372ECB74570C9B4AB2BFCEC3
            7600DB21CE195558EE1CBC4095566921DED33AB3167124C7732AB460976607E6
            2244552C76B361C618EE489E655B693CE7592155943B2050C405824624A8C02E
            0A956E8402C3306428F9B6D27AF9FE1FAF7D3AAF23E47D3FAFEB41B2AB6D653B
            9D9A22AC5490AE701DDF1839E8BF30DE4050401B1763E6918DC3C6B9692432F9
            3BE3CAC8769541DC36E5232A090CB2825A4DE88AC9229A1458CC2B24A8AAAD16
            549628DBB6E40DBFBCC92A1B019598ED62C1839BE69268D242DE70750E7E5FB4
            FCE406CE7E6DACCF9627E53BB2EC0AA2CFF777DFFE1FD35BF7F3D0A51B6FD3FC
            BF27F8F43E99FF008252FC428BC23FB47CDA3AC9BACFC4F60D6F00707124F128
            9A324A801B09E67CC41258963B4BED5FD35AFC6AFD9ABC6CDF0FBF683F076B42
            4FB22C3ABDBF9B22265A28657F2CA83B09F9A30C02B05E223B550950DFB1FA7C
            8B2D8C4CAAAABB70005DA171C631DB1E9DABF60E01C5BA98395296F17F9FFC37
            F48FDA7C3AC67B4C14A83DE2FF003FD09A8A28AFBC3F430AF88FFE0BE3F117FE
            10FF00D87FFB2D248E197C49AE59D996270E6142F7126CC1078F2501070086C7
            2322BEDCAFCC3FF838EBC6AF168BF0C3C3EBB9B75D6A1AA18D5324AA47046ADF
            C438F32504B0070780C01AE1CCAA72616725D8FD13C27CB563F8B7038792D39D
            3FFC06ED7E291F9638927478F76EDC02157FDE2C3D154124B2AA1CC8038DC73C
            7556461EE17619376D88B26C777C1286232264B0214C78DE037FABF998827697
            0A7969B55A491638C471053956062640C09276A9DAAB862DCB00497C62413EDB
            A8DB3261659234FDEB2958D4A2B2AB6031244BB3008612040003E6357E65D6F6
            FF002E9FD7FC1DFF00D54D1E9E5F8744EDF7FE4DF48E685E1DF85F2E48721708
            FC1F2711A807F78430DCBB4FAFCB8600970785EE5442D0C91A09191519B72AE1
            4C6BB970491E790A5598033061D1710AB2C561E67970C8C96A1DD3F76136281F
            26402A54EE8D58950AA3258226D8DA6BB0D349342F234FB9E681CB3801C9740B
            9C0200662EBFC78CB285DCCD185B69FD74D7FAF2DCA7AFBD2D7FE0A5D7F0ECFB
            EE11C5E6310567FDF6220A300E3645F2E00ED8694054FBC18AE54B65AB1B5D2A
            EEC6EB840C8D9F9774B379A5902F3C88D3262CFCC4156E0B82ED9648E66DC236
            9C0646910A825C3B498E1F1FBC40700B01BA360EF98D039B6CF3BEDF2E3F31CC
            8FBCE321C9911CF9673F296DD95FB8CC1B039928D52B7DDFD7E1EBBBD0356FCF
            557FD3EEBAEAF6D7541004D4194AB6E49B0544685B0640CD80A1870AAC92003A
            01B8FCC5006C4CB791C2FB59BCF68C001C48AE2408EEA36E3938594E76923739
            C0F941BFED636E64567129649235DC824846E2E98232376E910280CC091CE51D
            646F3372B483FD2029123306383B4C7B18B8DCB9456DEA41DCEECACAC5BCA34B
            DFFAF97F5DD12ED676D174F24F5FD7EED1EAD0DFB42189676585B98F0039DAFB
            0E546EE5977308CE5F0CA17772AACAAEF2962DA3CC553BBCBF30E634DCAD2004
            919DBB4B338F989E1C3E1D4B17A3FDAAE1BE646DD308DB07EE99C00D92C0721D
            6443950A7200065528638663249134691B34C90A80FBA3790EC589D383C13C82
            D96DA514167F9550D568F4F2FEBCB5F5F32B9B556FEBB5BFA7657B8F8D99A48C
            F36B23B9597618D443990970CBD4A8047DF201C639DC15E20330491B2C617CB6
            92485D73C08CC654FD5769C82700637797E5B81D237B7DA55678E52E0811AA89
            C2A889405006D66DCDBB69DDB491B46E1B6572D35C32E6391B761965DACAD249
            205705402002AB2AB0E4F1852CFB806BCBFAF27FD798A3B5D7CFE4D6BF8A5F35
            6D8478F73F97F37EF0382EE8ABBCE5DA4257247CC17705070E48750A1598B646
            E15993689092A1D832BA90F236090AD83B33B890488D5812C0AA35903DB08564
            676F28943E665E6578933BD937172D85DC13EF1DEC9B9941495E2135EC89FBA5
            79AE1E0C948FE657F907CBCE576018DFB801221F9B1E585A2D7FAFEBFE08B6F7
            3CFF0005AAF3D6FA755AF9892A6F592346999618CC230E0B60EF65E40206DDA1
            8B7CCAA612A8199DD013CCC1E499771B81E548BF7D449BD5768DC0B361E408A0
            124020E1CED2A5A8E2E6DE22ADBA4900281F76D72F1C818646E2CDB001F360FC
            CACCACDB558126D55F2FCB658C79836624798BC2AC17617F9B73101B63153B94
            64925A33AB4FA77FC7FCBF3D8ADDD9F5FEBE77FCBB6838A96468D5E49141982E
            CCB095D08997728FBCE40078CEE3B982BA48E41950EEFB6368F31CC43B0904D9
            F34A12DC9DAD18CB3A861B8B633B5C536E3C8884CD234735BC32E32640CD3AAB
            0568C960081B51F0480A5449B8EC25EA45134771FBCDB2490CC9E67CE706445F
            2C86666E15946031259B255B70528EF65A69FD7AEE0A4F7FD7FE07DCDAB75766
            C646BE5BC7BD5E46420B00C55D98F0C7E56C093CB2B82195546C2331A82A8B10
            9921B791D5FCC0235284E1D59C872848006197195099CEE51F723A408AF1242F
            217560CAEAEC09FDF4582C4640FE38D9F0406691581524A33DA46F303C8ED16E
            DEEEC19998F0B09271B1D8891949F983011A6154EC00D6FE7FD5BFAFBC9E5D34
            FEBB7DDB6BE7BEC111FB7F93BC3B44C625F2D1D4F944BAB12A325A3DBF381824
            A976557C88C57DE1FF0006EE48D37EDA5E2491996432F822F2591D5142876BED
            38F1B41037637E010A4BB1065E597E0A9956EAD258D4C4C25427CA62BB00F282
            B6768014EDCB33A8042C855771C2AFDB7FF041BF89169E10FDBFD6C6EE3BF9A6
            F19685A969166E832B0C8AD0DFABCA1CEE54686D2600AE72C106DDB81177E52D
            47194D3EEBFAFEBAFE1F9CF8C14E7578333254D5DFB293F3B2D5EFE57D7B7C91
            FB65451457E987F95A1451450014514500145145001451450014514500145145
            007C31FF0005A0B968E6F86CAA7E5D9AB4A5039064DBF63E319C630C790320E3
            9552C6BE1509F668BE6C2C696F87C264BA4403B70D82D80918F2DBEF2265BCB1
            831FDB7FF0599F1559DCF8ABE1FE8F0CCCDA9E9B05E5F4F08570238E731C701D
            DD0B33C13602FCCA2276CA10AD5F12C11EF8A144319DE122C8407714946D4C0C
            8DC588C8190C5149500171F84F18494B39AAE3FDD5FF00922BAF935F27BF97F3
            E71B352CEEB72FF7577DA11FBAC3AE372A4C9249B582CBE617DC59599FE624F3
            9F2D63576FBCFC03C36D3113C3E6968DE2470D2059230BF7705E355014E0EF8D
            A40AA08002811B2B304548DFCC74F2D917F8D369E8A30C392413B06D8C156E0A
            E3CC54208155408C46A9B02AAA82C1460BBF921B200E33193F7720ABED7DA84F
            CCEDA2FE935BF4D3BAFE97CB4757E7FE7F7F5E9F900B892E048D1B09A4699B05
            5D594B11F29C7CAA1061490420E327E52D1C6F12B4737991EE711B0923019DD9
            F84F2D7D4EF61B972189037796AB2150D32A4281A4F31A1B4298DE84148902E4
            F38206EC2EE18CEF54DD1AA8C3192410C91FCBE604645CC630CEEA5DCFC80165
            0BB8B155190C54965DAA0B2BFF005FD7A765A697D677B2EFF9FF0056BF6BF5D0
            57FDC4320CE556272B92A01F2E4600B01F2E37B33607C9B958E6465085D9DF74
            BB4EF0C7740C09566FBB9746382ADB907EF392ACB1AB08C238A250AE6465CED7
            532A7218ED5063041FBAC576B107EEB095826C3F2B0AF1DC2BE374D1C8CB1B79
            2DB8B2B2C6588C9C2FC91643BFCC0EDCEE23CC05F6B6FF00F0D6EDB2B5F7D8AF
            B377FD3FF81AF6B0912348144292316D8E9F6750194798E42AAEEC9FBBB942E1
            448A884672888B8919BC9754F9D12DDA222511AAF9857616C7DD53131CE392AE
            5D59CAD2164756F37CB94471992558CED122ED8C6F190305848BE59C0550610A
            19C328594EE59A39244DC836BE3EE82A7058803E5015942FCB95DFB5632ECA55
            BB276E9FF075F97FC3750D7AFF005B69D2FE7E401D563DCBE5C70A841851C431
            B0D9952C40D9B5776D6DA5E37624FCEAEAF7578D94C8B247246CA1C36570EADB
            F69E723CB453D1810B93BD31125249FBF67F33CC5F31995B2798CBEC3210A09E
            429E76B6724348C14A0A200CF730B7DD5DC1DD437DE0D1860A30006DB132AEE5
            2AA37A15DA06E55AEEFF00AEBF356DD3F95AC4CB4F9EBF77E7AF55DC6A47E5A8
            551E533E1948C611DF79C9C0207C8A15805DAFE5E151B6A16743B5846BB5554E
            D5DB81F222EF2A78E30190AE3EE928A5F6380592D433A40BFC4C96EAEC872C5D
            B7E028C7219D83631C860DB641870C76FDD2C8559D563DECB1B83E610E19BFD9
            2199154392C0EF8B00B6110B3BFBBABEFF002BFF004B75F8AAD3FCBFAD9DBB31
            D183247B97CC4DC55D9E307721C6EDF925768518915D88201032E9197022027E
            55DB9F217CBDA4281E61C04182429C1601C162BB4EC63117323407ED9B599048
            277DAF92A2270CD23BE4E18708067707554059E3D880C6B12DD42B1E19227454
            2AC36AC6BB599430C28F963419CEC466F309F951DAA959CAEBCBFE1FFCBD6FDE
            D3A257FEAD6FEBCEFF002143ED68F649BA4632CB0A862ACCE8E40DBCE4193246
            771202603B18CC65018E38E445CB431C480748F745B8151B49E016041DC1576A
            A1237E36B9DDA50D229FDE4CA1882BD259328A586DCB606E255C312AF300A416
            6A47956DE332A6C296E66B80081B7E4CC6A7EF778D554E1812C3FD63B6E0A95F
            4F9E9FD69F9A0E96F4FBF7FF002DBCFD049A37B98E487CC87CE76B88246CC985
            77DE09C637E4E652010198A15C907CB590CFF68B8698C7229697CE2AA0394053
            00E1460ED2CCBC71918061F30061603E6AC4AAD243854460A245911240ABC632
            4798E51BE43BF2E4C7BF0B50CC8B716CE2E02C91ED95DD8B093716F2C921B393
            F3315DD9E59DB0D27CA8CADA793FEAFE5E9AD9FDC572DD72F9FE7AFA7EA1B196
            D17CB871200C54065902489F239DDD37331600FF00108FE6525BCD3FB59F077C
            5B1F8F3E17F87F5A877795AB69D6F76831C2ABC6A400703F1F7F6C57E2ADE3AC
            AB248ECCC58310DBFF00D62C810901C86CB3333A003AEF90B05C387FD62FF827
            9F8964F147EC9BE119A6756961B792D32AEAEAEB0CAD0AE08EB8545E41230C39
            F4FD0FC3DAEFEB1383FB4AF6F4B696F4E9BF99FA47871886B155693D9ABDBE6B
            A7F5F79EDD451457EB27EC815F8E3FF070D789DB53FDAE3C1FA3280C74FF000F
            C32A090B322B4F73282D83F2E3F74B950416D9D54B035FB1D5F877FF0005D4D6
            FF00B47F6FDD5AD5B6BFF676896568DFC2D77FBA129471FC63F7E9C229396190
            C3E4AF1F3E9F2E0E47EEBF473C2C6B71A5194BEC4652FC97EA7C6CAD14DA7AB2
            95FB3B7259C16C811330DDB49190ACBB42005C0EC8DCCD24F246CD332AB49969
            F6798B86DAA131E66E6C93BA346249DA73B8BC7B0535E5F92391E6DCC7CB1E66
            5497531C9B1C336F21400FDCAB0C90CECCF1B047972AA8904331936AA124B424
            6E54EB952D1BBA1C648224551BCAA6EFCEFE5FD69FD7DCB4D8FF004965B5E5E4
            DFA77FEBAEDD873A9B47CB4924DB433191D97F7A63658909FBD975700B37CECA
            366E5DDB0222293E5C6BB495DD126D5C22B24CD82A31B90614A845C38F2C2E5B
            686A16D95420589523671011F3246A0BAAEC249FBA163DDB49DDF2851B3700C2
            4BF69C48DBA4123446500C88E480A1B3C67CCCFCA003B83C63E6F936C474B6BF
            D7F5E9A7904747E6BF3E9FF03D6DD450AD6BBA558E58FECEE1DCBC5F3465146C
            671C6033487E50CA09278219E40C693ECE8CEAD21F24095DD984BBBCA08A1DB8
            553872E4BBE0679CE103C4D11B46BF2C76EB22C7B4AED0BFBD024C2AAE36AB05
            08395230887E6588E2551BE558E29131BD92277412A81F7B6ED39E540420000B
            A3A052D8121367FD5BFA5F3B13D2EBD3C92FD7C9F569F6423DAEE95AC70AC559
            94C018B02EEE10827AE308FF003A8DE809278CEF449D647CB6C9BCD75772C155
            A45642F26F3BB6F1BA35233B33B71B58AB2A2385B48D63DE88C84F94C1CA3B67
            8C850CAC594201F7812A76A294689DC5B6662F94F96CAE2370DB598249232E3E
            6E0FCF8504FCAC0EE7076A97EFFD7F5FD329F77B7F5B7DFEB67AE96BB65C4A26
            8646171B91C3E7E5C4AC1A390ED2BC96552F855C81E68E070EE9269154C8DBD7
            73798CE1997CC5C223B039C9CF0776E50A224230A048C2E7FD5AFCCCDE59552E
            554931ED84162D925721C31E0BB2AEF2C8096BCA2279668FC959149B84532300
            C58091558FCA0859118F017710C376EF343D25D969E5F27FD7FC386FBF4DFF00
            5EDD2FB5BE6B6732084B2C8B1F98E5632A530980C53CA253838D89C28524941F
            C4B1B0A5E28A393124AB917284111A3ED83248DA42E58AE7E5C0C9621D9415A5
            307932797F347B0B08CBA2EF8C329F28EEC12C4BC8E0A95EA593279132448E97
            9B6250B74A4480344FB8B2C4593863E610C5816CFCD90C307E7759D7AFF5FD7C
            FA6BB12EEF75FD7DDA69BAD9DFA6A2346D04722AB22B6232BB636084B393193C
            63CCCB22AFCA00C03C10110FB814C6AD0C78206D50181431E180E8A57F7B1B12
            CECB905BE50C0242238E28C5B9645B73F292089235C84120DBC0DABB972C42E1
            24C0DAAC59560595D958322968E290A2BA9831B808F8E99CE4280707E5560442
            68566FEEE9E9F8FF00C315CDBF57B6F7BFF5F87908E08F342A85F2E3680A9902
            460BAB36CF9C750CAD9DFB81DD921810B1CD12BFDAE358F6F98B289117E6F94B
            856591D771E77760DFF2D7E6C348CCB035DB18639DCC224DED392240AA92491B
            3FCAD8651B1A30D96C8DA1CB267616784482E9576B2886604A051B902C809047
            591F7156500B6319F98E164257B59F6FEBD7A3FF003179AFC3ADEFFE6D2FBAE8
            6413471C4ADE6491C16F0A60B49B5B665CBA2E3040000FB8A70CB850A1570F68
            A631B4276B48A25431F97B86E5272A8A776D053CC236A8623690B20534D81551
            E185A45465758087E5A25259885618000F95B70656219080B94573E692000ACC
            DBF7029E5FCCADB92468D4601076217DAA159FE60446CAB824BDEDBFE1B5F5FF
            002FCC16AFF0F97F97FC07BDC71954090ACBE48F31F132B0511AA624624E49E7
            706E71BB6BBEE901405440C18B347E5ADC300418822461A665656E00C2AAAA90
            793B54FEEDDB34C90A6ED8CDE643246022A371E5B4A836C640DAC7E684FF0012
            9C05058BB48541F2A45B865B7924DE26672CED96323CA9828096593E45475186
            2A4100810B0E2EDB7F5FD5823DFBFCFE4FBAFD57CC491DA78B05A4DD3C7E7AB4
            86439037EC2E71B9B66DE0A600DDBB21BCB7AF64FF00827F7C625F817FB6BFC3
            6F1749268F65676DE2158AFEE351936DAD8D95E03697133C8A5553CA8AE2772C
            48446DAD22B6E32D78D84FB2AB2AEE8658C2AED646E6453249C8C3032A2E4A83
            951959332FCBB496DF6C8D1ECF2E4CBA618BB60AE5FE600EF32062AE08CB3170
            5771FDF8D29D4F6752338FD9775E76B7F5F2E879F9B65F4F1F80AD80AFF05584
            A12F49A6BF27FE76D59FD45515E07FF04D2FDAD87ED97FB25681E28BA9BCDF11
            69FF00F128D7FA1DD7B1471B19772C71C44CD0C90CE4420C686731866D84D7BE
            57EA946AC6AC15486CD5CFF22B3AC9F159563EB65B8D8F2D4A527192F34ED75D
            D3DD3EA9A7D428A28AD0F2C28A28A0028A28A0028A28A0028A28A0028A2B9FF8
            ADF1334AF835F0E35AF14EB53793A66876AF75361D11E5C0F9624DECAA64762A
            88A586E77519E6A6738C22E72D12D59352A4611739BB25AB7E48FCCFFF00829A
            FC433E3FFDAEF5A8E3934F9ED7C376B6FA3C135B3EE2CA3E7903B659432DC4B7
            50938DA19155D37202DE0224F376C8AA650C859308489B7B131A632436419502
            7CFC305DD863B6D78A7C4D79E2AF106A9AC6A532DC6A7A95EDC5DDFCD1A888BD
            CBCD248C7680B890956D806DF98E03101235AF2230B866DCAD3234BF392AA1C8
            68E45DDC001001CEE0150480158F96AFE72CC315F5AC554C44B69C9BD7B6F6F9
            5F4FF876FF0098F32C63C5E2AA62A5F6E4DFCAFA26BB5BD7A11B39822DD9DDE4
            C4EC2504323ED0BB0839E71BD8062DDC80CE385734662C2A8549373322A04665
            60840C1E572CC1CF1B37AAB30C06411376EE2AB1FCD2AC6ED09FBB26E6C48AFB
            49DEA54464B12411B4FCEE04619D26E78E4F25506F47F2914642E5D5A250319C
            36236550BF30DC55140490715EE95FE7FD79DB6FB9F43815FF003FE9FF004BF4
            64766B3C91C5146DE5DC32C31941852B21588E32464B063CE43EEDE24DDF3144
            4996F5BCD65DCD75145349B89FDE07F295B38192BBB7BE41671E58C10CAC5070
            8ACD27EF7CBDD80ED1FCD22058E542571F328298C636919388CC809465674F2C
            7EEDE4578C29625BCE79221B7F88653F71D77B70A78C020F2FE977EDE5EBE43F
            EBFA7ADFD775DC745B8DCA16F96449170252172FB577172065180F998AFDD111
            24EF45C462413DBF9722EF55B6472A54671F207C2E0904C60007691FBA0086DB
            E61799163CF9788E38DC1556C6D454658A32776432A946C927010C886427A12C
            6EB0B46C5A3C47246D93F323756272705A3DA8C7767210E59592208EFBC9FF00
            C37FC0FF003ECC9564EEFF00ADBF5B7EAC74B23B3316658DD99D9B7AEE284AB9
            DD839DC423485C16218A82EEC1F0A8A8CFFBB0D343B8F971B0CB1562596264C0
            04953820001C9F9C07DFB59CC648A70FB7ECEE9B65DA7E58E36DA5067838540F
            011B492B90100DC8A91ABC76D165F72450A4714B1901B032D9423047555F9707
            2C012922E5E4237D7E5F2EB65F7AB7A795CAE5695BD3E7AFE5BDBD41DD648F27
            72ADC2B11B76B63E7794AA0190F866040505240AAD856514E67CDD48CC6356F3
            0BB383C0769240CC189C300FBC0671C2BBAEF2543335E26DAAA8D9B8DAB10765
            DC921457287B961F2C0F92C5367959DC18252CD347219BEF79190E0B317668A5
            3B589206FF009BCCC96C65C328F943A8908ABE9E9F9FE7AEAF6EB604FB6BFAAF
            F83B2D7D1E835862DC0FDE4216274638398373AF9A724820AB6F382570D85DAE
            3E62F9A0F31DA2DB15BACA6683CB560B1C459141C28C1C925C1C10401B768555
            051CF2ED203236D7695B8563132AA804A93F236D1B42B0528762BB1D99245F2E
            36F3146D54955C2808C465F7609195CB4A8060041964C39728CB56B9ADAEBF97
            E4BCFEFBE81BEFF7FF005FD7CB41249127DEEDE50332FDA0AC8BBFE50CC70CB8
            DA426F6CED19D9115223FDF05562CC54C6AD24A04CCAC1C0647F30E1B25B2727
            F8C1EACEC5888D911FE6343769E6799E62BB33ED043EF8F6860A718DCAA46D1C
            18CA28D85CA978E34DA228D8C4EE22821E59596408BB9BA8C7967F78BF312ABE
            5B0608AAA6137DB7FEBD34BEDB5FD3546A9A97F5B5AFFE5AF4D2C2AC49292B0C
            6AD199B745191B15B742FF00F7C0650A72047C38C6C1B7C948E4CAAB798ACD18
            598173DDFEE48793B777988CCD90788E3FDD8614D9184F161C46DE6C0D300FFB
            C60CCC0339383955DB26EFBCCCA4E703779523C8271BA46FDDCB23877DDBC28E
            5242CEBC02598EE6DCBBC3139883654DB5FF0087FEB5DB4FBB7355F2FEAFEBE9
            FF0001A32AC1192D0C92242155D1D41E23E818B02376EDF1B06048CA95DC1FCB
            9152D9A05584B1F3159612DE66D3BD102BB65B3B30A5C824128DBD898C6EDE42
            9F6C7823D84BDC4689B5142E3CF3233A676F0705C281C7040475794D36D9CCF0
            A4DB774B722295500DE5C86078E08F9BCC8E31951D4838CCB96E2F6F97E4BFE1
            DEDD034EBFD3D3A69D3A6DF88E8E4533AB2ED590C6AE80B3236D67F31030DC1B
            6A0DC0963F22C448760401FA4FFF000494D7DEFBF66692CD9BE5D37589ADE332
            9DAECAF124FB82ED18C973C64F0091C002BF35A065609B5BCC2C6122442C4CCC
            B8F986086672645C0C893254B1897E55FD02FF0082376A247C33F1558A85DB6F
            A9C7213110C8CCD02A920800103CBDB9C738F97E5E4FD7F04CF97338C5ED67F7
            FF005F9BB743ED3806A4A39A45774FF2DFF4E897CD1F67514515FB61FBC1E67F
            B487ED91F0BFF642D334DBCF895E36D0FC1F0EB12345622FA53E65D95DBBB646
            A0BB05DCBB980C2EE192335F847FF0548FDADBE1DFC6FF00DBA7C5BE20F0C78A
            AD35CD0AF8D85B5ADCC4D218AEC47696A9222927E60AE305B2092A5977AEE53F
            A73FF058DFF82324DFF053ED7FC19E20D23C6D078535AF09DB4F632417D6525D
            5A5FC12488E3EE48A626521F2406DE1D46576027E213FF00069378E84995F8BD
            E11DBB7186D26E0F38C67861DF91F8673CE797198586229FB2A8DDAE9E9E5B6A
            7DAF00F1C62785334FED4C2414E7CAE3695EDADBB7A7F5B9F0FC5F18FC337189
            23D7A1DFF2BACB146C9238286324E3E601997717DC4052E461A312007C60F0AC
            F1E1358B558197CA2A0B471BC4D23045DA41F957AA86254E25401509C7DBE7FE
            0D27F1D0857FE2EE78459D4F6D2EE53CC1C9C13B9B04E40C818007439A17FE0D
            26F1D0DBFF001773C1BF2A91FF00208B9E49CFCDF7FA8CF6E381C1E73E3FFAB9
            85EF2FEADEBFD7DE7EDBFF0013559F2DB0D4FEE91F10DBFC62F0CA5DFDA3FB52
            DDA607CD7FDD48A54AE24DDB540DA72EC0A302D82ED9077A96B7C58F0DFD9FCA
            6D5D648BCA646F322724AAAAA96002FC873B861486209C362255AFB80FFC1A4B
            E3930AA8F8BDE115753F79749B8C375CE46EEBC8E98E9D0E73483FE0D24F1D24
            6C7FE16EF849DF70207F65DC2061DC672704F1CF38F4347FABB86DD37F77A6DF
            F06DFE6FFE26AB3FFF00A07A7FF9379F9F9FFC03E1E9FE3178664877FF006CDA
            A43B1F0D82EACB267695F931CB6331AF700E729F34ADF183C377374CBFDAD6FF
            003B4C7CB2A79F30B06DC0A6163C292548DACCA492590BBFDBABFF000692F8E5
            5A33FF000B7BC22FB4E583E9371B5CE73D98103181D73EFE80FF0083497C7461
            656F8BDE112DCED61A4DC8F4EBF3904707A63AF538C51FEAEE17BBFBBFAFD77F
            5BAFF89AACFAD6586A7DBED7F99F0F9F8B3E1C9201BB54842796C1F7432EF68D
            9406CEE077330462CA41C1624EE3102C4BF173C37721E27D6ADD369749CC71C8
            DB3CC555249249CFCA4B2E46D0EC777EEF737DBDFF00109178E9813FF0B73C1D
            1B74DDFD913B30EDC364100F048E9C01CE01A7AFFC1A4BE386552DF173C28ADF
            31C0D36E1B6E47033919C1CE4E064765A3FD5DC3F493FEB4F9E97F2D7D6F5FF1
            3559FA77FAB53FFC9BD7BEBBB3E21FF85CDE1B7BA1E5EAC219267122E0491BA6
            173D194E02EE2093C65761C2AB46590FC5FF000CAC28A9ACC31AC68F1ED8E094
            1B740918200396E5412626231818E622C7EDE5FF008349BC74AAD9F8B1E0F6C8
            C053A65CF3C8CE1B3C6EC7756C67F8B19A57FF0083497C7402EDF8BDE1327186
            274BB8001CE720679E303191D49CF6A3FD5BC2DF5BFF005BF6FF003EDA682FF8
            9AACFF006FAB53FF00C9BFCFFAF4DBE205F8C3E185976AEA56A9B7CC768FCB93
            E5010C63A282318618186203E1885903BAD3E2E786212B6FFDA96B22C72FCE81
            6400B65882C7051488C72368208FBC368CFDBE9FF0692F8E40F9BE2EF847BFCC
            BA4DC863C719F988C03CF4EE79E9841FF0692F8E4C0CADF17BC22CDCE1BFB26E
            3BE38237608001E983CF53D28FF5770DB5DFDDFD7F5F8AFF0089AACF9AB3C3D3
            FBA5DFD76F2FF827C3F6FF00167C3AB6D6A926ACAC918843968A556E32A1C120
            ED6255095C623DA4F58C350DF167C3B2C631AB2A865C64C5201187DB92A84614
            EE4C32316006F2F9F9F7FDBC3FE0D20F1D03F2FC5EF06A9EE57459D4B7B921B9
            3EE79C003A0147FC4243E3B273FF000B83C239F5FEC7B8FF00E2A9FF00AB986F
            E67FD7C8A7F4AACFDBBFD5E9FDD2FF003FF87EB767C46BF18FC3372030D615A3
            B8770488DF6A2F9FBA36076FF000A392081BCA32042489F19BC353CA0B6AC8A6
            5F9F690EAF97742F228D80AE15B0C47DDDAC328C19EBEDE97FE0D26F1C11B97E
            2D7847218B6C1A5DC2AE3B282492BDC64E7A8E38E45FF8349BC731B4647C5BF0
            8BF20BEED32E002739E80E48230319079CE7B525C39854B77FD7AFDDE7F812FE
            9559F3FF00986A7FF932FD7B7FC0EA7C3F6FF17FC3F15BC7B358B74F92341246
            AE15577653A0C11B81F946046BBB047CE1907C60F0C44CBFF138B5854032ED99
            1D48846D033B873B36FDD6E10B12D9D877FDC07FE0D23F1CA05DBF173C24CD8C
            37FC4AEE17272791C9E99CE3BE0F23390ABFF069378E2331FF00C5DAF08C83F8
            C36977014F24F4072411C6320F24E7B51FEAE61ADBBFEBE56FC341FF00C4D567
            FAFF00B353FBA5FE7AF7D7FCCF87E2F8CBE19B62A3FB66DA16C79E43C6E8AA15
            182960C410838DC832CA0B29242834D3F17FC31E6FFC86ADB74F06C2D74AC666
            429E5062480ACCD84DEAEA7E6EA4889057DC3FF1093F8F0C4CBFF0B77C1EAD91
            87FECAB9627AF6DC00EBD39FBA0E4648A7C9FF00069478E1A4DC3E2DF83C641C
            A9D26E4A82738C7CF9E38C649E4739E943E1DC35F77F72F977FC7E7D452FA556
            7FD70F4FFF0026FF003FEBA9F0FF00FC2DCF0BC93C6BFDAB02C6C863F2DCCB1E
            F4656F33AFCC19B692C0B121B2EC498F6D2DAFC5FF000EC5243249AA5BB49E64
            32C845B3C5B82EF00ED0A154B37CCC08CA6E7C9C4631F6E9FF0083497C70D238
            3F173C27E5FCDB7FE259704F39C0233DB8C9FE2CF45EA5BFF109178F01E3E30F
            847AF3FF00127B8E7FF1FA3FD5CC33566DF4FF0083FD7F90FF00E26AB3FB5BEA
            F4FEE97F9FF5F81CDFFC116FFE0A55E0CFD93BF6918F4DF1278B34BD37C13E3C
            B64D2F52BEBB1F67B6B29A267369792CA6262A824796320C91C08B79248CDB6D
            CB9FDF4AFC3293FE0D27F1CF55F8B5E110CCC4ED1A65CAA807A63249E393C9E7
            8191D6BF567FE09DFF00023E247ECBDFB33685F0EFE22F89BC37E3193C1B6F16
            97A26ABA5D93D948DA7448120B79E223697855422CAA417409BD4BABC92FB183
            C2C70F4BD9C1B6B5DFA5FA7F5FF0DF8871EF1A4F8A73479BD7A31A752492972D
            ED2E5D1377FB5CB68DF6692EB7BFBA514515D47C585145140051451400514514
            005145140057E5E7FC15DFFE0A81E00B8F88DFF0AB34EF1F69EB61E1B91C789A
            3B3BB678EE2F95F6FD8A4D8996683CB7DCAB211E6B329512DB109FA11FB49E8B
            F10BC4DF07758D33E176B3A0786BC65A9466DACF5AD5EDDAEA1D1C3021AE1200
            0ACD2AFF00024988C310CE24553149F8DB17FC1A53E3A5FBDF16BC1DF781C369
            774D903B6430E1BAE3A8E80F73C199E056330EF0F2938A96F6DDAEDF3EBE5F8F
            9B9AE5EB1B86961A537152DDA5ABF2FF003EEB4EA79C3FED77F0EDD558F8B2C5
            98E3E7D8EF97DDF3850AB821F850A0E0094290DB96A39BF6B2F871756D327FC2
            51A404977840B2C926776E8C107CB6E137B2066015496C0560377A50FF008349
            FC78197FE2EF78376AA1520E9175F3139C37FACED9FA703DF21FF834A3C78EC4
            B7C5CF07EEDBB01FECAB9F6F9B0180078C73BBB9CE4F1F25FEA0E0AF7F692FBB
            FAFF0081BDAF767C67FC439C05EEAA4BEEFEAEADD373CDEE7F6C0F870F2CF349
            E2ED261672663FBD03E618DCF92B8518DE4339720B0FBCD23966C9FB5C7C3702
            45FF0084B34C2C14E61092111EC024D98652C31972CAC1B96CB9CC8057A67FC4
            259E3B575FF8BB3E0C31872C1069372A1471C7DE2CC38C6370C6739EA08FFF00
            069678F3CBFF0092BBE1066C6187F64CC81D463001E769E39619273D0F3995C0
            382FE797DCBF5FF803FF008873807A7B4974E9DBFAD6FF00F04F357FDAEBE1B4
            F348D1F8B34DD9348EE9207606525DDD1BA7FD353F36F0CAAE1F73295C927ED7
            BF0D6391B778B34BC2F9402C864490A89723E5F2F0B9E54920A82809CBA647A5
            1FF834ABC7440FF8BB5E0DE011FF00209BAE7E5033FEB3B1E7EA7D30288FFE0D
            2BF1F44176FC5FF06FCBB4F3A2CEDB8A8C64E5BBF523A1F4C00035C0382FF9F9
            2FBBFAD43FE21D6036F692F3D17F5FE4B4D0F3393F6BBF875E46D93C59A28123
            4D6EC44D200CCF92CA7E5247CA8C065B255002C4050A4FFB5FFC3532349278B3
            4368E52C2567770A10A3AAA31D8B90482C71F2F20A18F72AD7A65BFF00C1A5FF
            00102278DFFE16F783D5A2C84DBA4DCE47270D90C0E79CF3D381C814E5FF0083
            4B7C7713B6CF8BDE11F2CB1255B4ABACBA6410AC438C8E3B01FCB0BFD41C12D3
            DA4BEEFEBFE1FAEE1FF10E7017F8E5F77A6FFD7CCF3393F6B7F86ED70EA7C59A
            3492E7CB6CF98AF3860A1CB13129C9663D70429752ADBA4C23FED7BF0DE71346
            BE2BD3E66F2303E593CC7DD929FBBDBF2AB2B88C804676A2EEE4AD7A57FC4251
            E3AD9B7FE16E783B3B76EEFEC8BACE739CFDFEBDBD31DB3CD2CBFF000695F8F6
            58E44FF85C1E11556C9451A4DCE21271CAE5FAE001CE78A3FE21FE06D6F692FB
            BFAF3D3FC920FF00887580D5FB497DDF97F56F23CE0FED7BF0E1AE1A41E2AD3D
            A46B8C92D33B67E4611EFCAE3CC2ACA4B90372E5837FAC6765BFED7BF0E519A3
            5F17D8BB42A8D18579771185C385D8186011B5C2EE2CDB581DCD9F4A3FF06957
            8ECC8C7FE16DF82C29DC401A45D719FF00B69D0751FAE7A503FE0D2BF1F12DBF
            E2FF008364DCCEDFF2059D705BFDD61C0E303A0C7B9C8F80304D7F11FDDE9FE5
            F887FC43BC0377F693FBBB6DFF0003B77E87998FDAEFE1B9B30D1F8AB476CE00
            C33BDB93F290C3E42B8046470390E48650C85CDFB5E7C3585DA48BC5360D2290
            C24DB92D8F31C12DB48C9208C1CAB46A80E30AADE94BFF00069578E830FF008B
            B5E0D382A70749BAE70391FEB3F8BA9FD31427FC1A5BE3D454FF008BBDE0D2D1
            90558E8B71D893823761B39EE0F403A714FF00D41C0FFCFC97DDFD79FDF7DF73
            FE21CE03FE7E4BEEEFBFCBA7A75D8F35B5FDADBE1A2C2BE5F8AF4D92358E3119
            466642164DEA030465C0509962B8631B31438662C3FB5F7C37B7014F8B7488D9
            90B932492C4C922EC2D92CBB83461C28F98B2B28CB300457A69FF834A3C724AE
            7E2D7834E191B1FD957633B7A8E24E8DD4FE981C50BFF0695F8F842CBFF0B8BC
            2233851B748B850573921BE6F98EEC1C9E9803D30BFE21FE07FE7E4ADE9FD7F5
            E625E1D6017DB97DDFA797F5DCF366FDADFE1A9611FF00C259A7DAC73308D5B0
            FB94121420E17E68C6EDA721B29B48010A28BFB607C399648E65F13596E9991C
            947953079DA884A8FDE0DC5632307FD60258F03D25BFE0D2BF1E6E257E2E7835
            325BA68F72D804631F339E9D8F5E7AF4C2AFFC1A55E3ACC99F8B9E0F0B216385
            D22E3E5CE30012C780467D4E48CFA1FEA06077E797DDFF000FF2FB823E1CE012
            FE24BEEFCFCFCFA7958F305FDAF3E1BCB6BB478B74078D976644FF00B9DCDD57
            014614AE4041839CB20451F2CDFF000D73F0E6E8BAFF00C255A5C8D2330D8D34
            923482460137045C6598AB9930AAC563DAC182B57A42FF00C1A5FE3FDFFF0025
            7BC18BB4A91FF12699B7151C1C678EB8239CE3249CE01FF109578F0C6AADF17B
            C1ADB7183FD8F700E3938E1F9CE7A9E781C8147FA81827AF3CBEEBFF0057FBED
            E7B3FF008873804BF892F92FEBF3F37A9E6A7F6BEF86F7261DDE2AB03E748A1F
            CD2CCC7700EF180402ED2196360095DACF85CE18B7D77FF04BBFF829D7C0BF82
            369E2D83C5BF13B41D145D7D925805D19774BB62983851E5B31C054E770DC3CB
            DA3900F8747FF069678FA275DBF17FC1FE5EDDB22FF645D7EFBE6DDF37EF3A71
            D063A0EFC922FF00834ABC7888AADF17BC1B2EC60416D1EE012324ED3B5C641C
            E3279C01CD7A396708E130388588A537757D2DDFFE1975D7ADEE7A395706E130
            189589A539371EE95BB7E47EC37ECEDFB5CFC35FDAD74AD4AFBE1BF8CB45F185
            AE8D32DBDF49A7CA5C5B3B64A86C804676B107A1C71457CBBFF046BFF823A4FF
            00F04BD3E34D5358F1943E2ED7BC5AB6F68A2CECCDADAD9DB425DC70C4B3C8CF
            21259BEE8500753457D69F667FFFD9}
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo64: TfrxMemoView
          Top = 0.779530000000022000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' Score')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 104.826840000000000000
          Top = 149.401670000000000000
          Width = 109.606370000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '845')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 317.480520000000000000
          Top = 31.748031500000000000
          Width = 124.724490000000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Probabilidade de'
            'Inadimpl'#234'ncia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 442.425480000000000000
          Top = 31.748031500000000000
          Width = 75.590551180000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '0,48%')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Align = baLeft
          Left = 518.016031180000000000
          Top = 31.748031500000000000
          Width = 124.724490000000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Risco de'
            'Cr'#233'dito')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Align = baLeft
          Left = 642.740521180000000000
          Top = 31.795300000000000000
          Width = 75.590551180000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Muito Baixo')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 317.480520000000000000
          Top = 69.031540000000000000
          Width = 400.630180000000000000
          Height = 26.456690470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Interpre'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 317.480520000000000000
          Top = 95.488250000000000000
          Width = 400.630180000000000000
          Height = 105.826840000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'A pontua'#231#227'o enquadra-se na faixa de 801 a 850 e representa risco' +
              ' muito baixo de cr'#233'dito. Para empresas com este perfil de risco,' +
              ' '#233' pr'#225'tica de mercado conceder cr'#233'dito sem necessidades de garan' +
              'tias adicionais. Em m'#233'dia, empresas com esta categoria de risco ' +
              'costumam honrar os'
            'compromissos assumidos em 99,52%.')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 201.535560000000000000
          Width = 321.260050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line1: TfrxLineView
          Top = 30.236240000000000000
          Height = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object frxDBDatasetNovaProposta: TfrxDBDataset
    UserName = 'NovaProposta'
    CloseDataSource = False
    DataSource = DataSourceNovaProposta
    BCDToCurrency = False
    Left = 104
    Top = 200
  end
  object DataSourceNovaProposta: TDataSource
    Left = 184
    Top = 160
  end
  object frxPDFExportNovaProposta: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
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
    Left = 176
    Top = 88
  end
  object frxRelatorioPJConsultaPCC: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44972.551269780100000000
    ReportOptions.LastChange = 45035.608451273100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 64
    Top = 48
    Datasets = <
      item
        DataSet = frxDBDatasetNovaProposta
        DataSetName = 'NovaProposta'
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
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 69.866110000000010000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPJConsultaPCC.ChildIdentificacao
        object Memo19: TfrxMemoView
          Align = baCenter
          Left = 118.034880000000000000
          Top = 32.000000000000000000
          Width = 482.040940000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Serasa PowerCurve Cr'#233'dito')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baCenter
          Left = 89.688404999999970000
          Top = 1.000000000000000000
          Width = 538.733890000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."EMPRESA_LOGADA"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Align = baRight
          Left = 666.028820000000000000
          Top = 52.858235980000000000
          Width = 52.081880000000000000
          Height = 17.007874020000000000
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
        object Memo54: TfrxMemoView
          Align = baRight
          Left = 609.260360000000000000
          Top = 52.858235980000000000
          Width = 56.768460000000000000
          Height = 17.007874020000000000
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
      end
      object ChildIdentificacao: TfrxChild
        FillType = ftBrush
        Height = 238.110390000000000000
        Top = 113.385900000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPJConsultaPCC.ChildAnotacoesNegativa
        object Memo2: TfrxMemoView
          Align = baWidth
          Top = 30.456692910000000000
          Width = 302.362400000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Raz'#227'o Social')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 302.362400000000000000
          Top = 30.456692910000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CNPJ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 404.409710000000000000
          Top = 30.456710000000000000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Funda'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 476.220779999999900000
          Top = 30.456710000000000000
          Width = 241.889920000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'UF / Munic'#237'pio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baWidth
          Top = 53.133858270000000000
          Width = 302.362400000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[NovaProposta."RAZAO_SOCIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Left = 302.362400000000000000
          Top = 53.133858270000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[NovaProposta."CNPJ_CPF"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 404.409710000000000000
          Top = 53.133889999999990000
          Width = 71.811070000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_NASCIMENTO_FUNDACAO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 476.220779999999900000
          Top = 53.133889999999990000
          Width = 241.889920000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[NovaProposta."ESTADO"] / [NovaProposta."CIDADE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo1: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            ' Identifica'#231#227'o')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Align = baWidth
          Top = 76.590600000000010000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            ' Status do Documento')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 107.385900000000000000
          Width = 192.756030000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'Situa'#231#227'o do CNPJ em [NovaProposta."DATA_SITUACAO"]:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 192.756030000000000000
          Top = 107.385900000000000000
          Width = 525.354670000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[NovaProposta."SITUACAO_CNPJ_CPF"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baWidth
          Top = 130.504020000000000000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Informa'#231#245'es da proposta')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Align = baWidth
          Left = 143.622140000000000000
          Top = 160.960730000000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            'Valor Solicitado')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo74: TfrxMemoView
          Align = baLeft
          Left = 253.228510000000000000
          Top = 160.960730000000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            'Limite Sugerido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Align = baWidth
          Left = 143.622140000000000000
          Top = 183.637895360000000000
          Width = 109.606370000000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_SOLICITADO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Align = baLeft
          Left = 253.228510000000000000
          Top = 183.637895360000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_SUGERIDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Align = baLeft
          Top = 161.007874015748000000
          Width = 143.622140000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            'Faturamento Presumido')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Align = baLeft
          Top = 183.685039370078700000
          Width = 143.622140000000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."FATURAMENTO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildAnotacoesNegativa: TfrxChild
        FillType = ftBrush
        Height = 313.700990000000000000
        Top = 374.173470000000000000
        Width = 718.110700000000000000
        Child = frxRelatorioPJConsultaPCC.ChildScore
        object Memo13: TfrxMemoView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            ' Anota'#231#245'es Negativas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Align = baWidth
          Top = 30.236240000000010000
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            '     Resumo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Align = baWidth
          Top = 60.472480000000020000
          Width = 396.472426300000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Ocorr'#234'ncias')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 396.472426300000000000
          Top = 60.472480000000020000
          Width = 90.708720000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 487.181146300000000000
          Top = 60.472497089999990000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Valor (R$)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 600.566973070000000000
          Top = 60.472480000000020000
          Width = 117.165356770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Data da '#250'ltima')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Top = 83.149659999999980000
          Width = 396.472426300000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Pend'#234'ncias Banc'#225'rias (REFIN)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 396.472426300000000000
          Top = 83.149659999999980000
          Width = 90.708668740000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_REFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 487.181095040000000000
          Top = 83.149677090000010000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_REFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 600.566921809999900000
          Top = 83.149659999999980000
          Width = 117.165356770000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMO_REFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 105.826840000000000000
          Width = 396.472426300000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Pend'#234'ncias Comerciais (PEFIN)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 396.472426300000000000
          Top = 105.826840000000000000
          Width = 90.708668740000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_PEFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Align = baLeft
          Left = 487.181095040000000000
          Top = 105.826857090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_PEFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Left = 600.566921809999900000
          Top = 105.826840000000000000
          Width = 117.165354330000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMO_PEFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Top = 128.504020000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'D'#237'vidas Vencidas')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 128.504020000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_DIVIDAS_VENCIDAS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 128.504037090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_DIVIDAS_VENCIDAS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 128.504020000000000000
          Width = 117.165354330000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMA_DIVIDA_VENCIDA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Align = baLeft
          Top = 151.181200000000000000
          Width = 396.472440940000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Fal'#234'ncia/Rec. Judicial')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Align = baLeft
          Left = 396.472440940000000000
          Top = 151.181200000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_FALENCIA_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Align = baLeft
          Left = 487.181102357322900000
          Top = 151.181217090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_FALENCIA_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Align = baLeft
          Left = 600.566929127322900000
          Top = 151.181200000000000000
          Width = 117.165354330000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMA_FALENCIA_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Align = baLeft
          Top = 173.858380000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Fal'#234'ncia / Concordata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 173.858380000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_FALENCIA_CONCORDATA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 173.858397090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_FALENCIA_CONCORDATA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 173.858380000000000000
          Width = 117.165354330709000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMA_FALENCIA_CONCORDATA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Align = baLeft
          Top = 196.535560000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'A'#231#245'es Judiciais')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 196.535560000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_ACAO_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 196.535577090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_ACAO_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 196.535560000000000000
          Width = 117.165354330709000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMA_ACAO_JUDICIAL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Align = baLeft
          Top = 219.212740000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Protestos')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 219.212740000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_PROTESTO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 219.212757090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_PROTESTO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 219.212740000000000000
          Width = 117.165354330709000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMO_PROTESTO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Align = baLeft
          Top = 241.889920000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Cheque sem fundos')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 241.889920000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_CHEQUE_SEM_FUNDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo62: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 241.889937090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_CHEQUE_SEM_FUNDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo63: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 241.889920000000000000
          Width = 117.165354330709000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMO_CHEQUE_SEM_FUNDO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo72: TfrxMemoView
          Align = baLeft
          Top = 264.567100000000000000
          Width = 396.472440944881900000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Cheque Sustado e Cancelado')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo73: TfrxMemoView
          Align = baLeft
          Left = 396.472440944881900000
          Top = 264.567100000000000000
          Width = 90.708661417322830000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."QUANTIDADE_CHEQUE_SUSTADO_CANCELADO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo75: TfrxMemoView
          Align = baLeft
          Left = 487.181102362204700000
          Top = 264.567117090000000000
          Width = 113.385826770000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[NovaProposta."VALOR_TOTAL_CHEQUE_SUSTADO_CANCELADO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo76: TfrxMemoView
          Align = baLeft
          Left = 600.566929132204700000
          Top = 264.567100000000000000
          Width = 117.165354330000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."DATA_ULTIMO_CHEQUE_SUSTADO_CANCELADO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ChildScore: TfrxChild
        FillType = ftBrush
        Height = 220.307050000000000000
        Top = 710.551640000000000000
        Width = 718.110700000000000000
        object Picture1: TfrxPictureView
          Left = 3.779530000000000000
          Top = 23.456710000000040000
          Width = 311.653370000000000000
          Height = 177.952690000000000000
          Center = True
          Picture.Data = {
            0A544A504547496D61676500D50000FFD8FFE000104A46494600010101006000
            600000FFE1003A4578696600004D4D002A000000080003510000040000000100
            0000035101000300000001000000005104000100000001FF00000000000000FF
            DB00430002010102010102020202020202020305030303030306040403050706
            07070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E
            0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
            0C0C0C0C0C0C0C0C0CFFC000110800EF01E603012200021101031101FFC4001F
            0000010501010101010100000000000000000102030405060708090A0BFFC400
            B5100002010303020403050504040000017D0102030004110512213141061351
            6107227114328191A1082342B1C11552D1F02433627282090A161718191A2526
            2728292A3435363738393A434445464748494A535455565758595A6364656667
            68696A737475767778797A838485868788898A92939495969798999AA2A3A4A5
            A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DA
            E1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101
            010101010000000000000102030405060708090A0BFFC400B511000201020404
            0304070504040001027700010203110405213106124151076171132232810814
            4291A1B1C109233352F0156272D10A162434E125F11718191A262728292A3536
            3738393A434445464748494A535455565758595A636465666768696A73747576
            7778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2
            B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7
            E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDFCA28A2800
            A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800
            A28A2800A2992DC470292EEAA07A9AE23C53FB467853C2F136ED492F248C9DC9
            68A67DB8DFBB257217051C7247231D4807C5CDF8932BCAE9BAB9862214D7F7A4
            91D387C1D7C44B96841C9F92B9DD50CC147271F5AF9F7C47FB65DD5C94874BD2
            EDE03208DBCE9E6120DACCABC05207249C65C640E031CA8E0FC43F1E7C59E2C8
            5D4EAD710C738242D9831A1CACA3E560A1803853FEB3FBBF374DFF0087F117D2
            6B84B2E6E18572AF25FCAACAFEAEC8FABC1F01E675973544A0BCDFE8AE7D697F
            AD5A6996ED2DC5C430C6BC96770AA3F13C572FAAFED01E11D22558E4D6AD2469
            31B3C92660D97D8395C8FBDC7B1AF926F6F66D6EF9A4B8926BC6DC246F3B7B6C
            F30AE4ED6048DC1A41C86E0B0DEB8C0AF6D707CA5C5CE0B6CE44ABBB2C41240D
            E54F128EB9390A4EFF0096BF1DCDBE9738F9E996E0A31F39B6FF002B7F5D0FA6
            C2F86F4AD7AF55BF24ADE9DFE7F8773E9CD53F6B8F0D59CFB218F53BADCC1559
            6D8A06F9431C6F2A4E01E801390C30769C61DC7EDA16C4E6DF41BD954B2AE1E4
            0AE99DBCB85DC171B8704E71CE31CD7CFEAA046BE546C1532A563DE188DC4797
            95E32BBB68F9C2825CF1B000EB7DB2EC4578D954A1548F942331F2AA19C00005
            6FBA30245E54EE35F9EE3BE935C6D5F5A55214FF00C304FF00F4ABFF005E47B5
            4780B2A87C49CBD5F9F95BFABF95BDAAEFF6D3BCD8248F458E3899721FCFF3BA
            98F6F4500921DB852724719208AAB27ED87AE79C4AE99671C6B8F94A4D23705C
            30C803380B9071F3640C0CA93E3C88FBD362B4770AA84E436E5E5572F852D824
            7F7F0C225E4A962119A2DBBB217E457CE55D883B42B0387DCDD3193966897008
            C9AF9BADE3C71CD47778E92D7B2FF25DBFCB53BA1C1B942492A3F8BF2F33D72E
            3F6C2F105BC0DBEC74F8DBE61831CDB55B90A33D5B254FA755C64904DA8BF6C3
            D694EE6D26CE64DCE0796CDC952DC7CBBCF2170410305863711B4F8CC56F8998
            2A18BCB5C308C72AA720E36EC7C7C9B47073B6361CA9A2E15B7348F1AAC8CFD7
            68CEECF00168F19C800127931C5CFCD58C7C72E364F4C7CBF0FF002B7DF6DD69
            62BFD50CA76F64BF1FF3FEBEE3DBADBF6D6B849FCBB8D0E16F9F63325E852B97
            DA06D29938DD19271821B23B03AB61FB69E9B23FFA5693A840839764024F2F24
            050470771C8F97EF7CEBC1E76FCFD149E5C319B7DD2246146D8D8B21C36EE141
            217395DA0B81B5CEE185C5344B96876B22AAA048D95555392806DE41D99D8DC3
            3641653CED15EB60FE911C7345FBD8BE65E718FE76BDBEFF00974E7A9C11944F
            6A76F9CBFCEC7D41A4FED6DE14BE855AE24BCB37381B1E032B07DAC4A7EEB78D
            CBB4E4678F7AEA34CF8CDE19D5DB6C3AC5986FEEC92089BB91C360E0E0E0F438
            3E86BE390C259B69559329E5947CF3B72BB1B192D8F314337CEB90D90A698ABE
            6CFE5AED2D264B091554B96C1F987C8C73B0390320E24523E515F6D96FD2BB89
            A8CAD8BA34EA2F4717F837F93F5D0F26BF8738196B4A728FDCD7E5FAF9F91F76
            477B0CAB959148F5CD4A0E6BE1DD17C457DA34EDF61BFBCB195B8578643BC02E
            18EE5C82722419DC9C1196270A4F61A0FED33E2BD049692F63BA8630A1D6E937
            2C408049CA2ABF1B93FD61C90A49C7DEAFD4B21FA5A6535DA8667859D37DE2F9
            95FF000D3EF3E7B19E1CE2E0AF87A8A5EAACFE5BFE9F71F59515E1FE18FDB161
            91962D5F47BAB693E51985C485C92B93B4E303E752482C01DC320005BD23C1FF
            00197C37E3A2ABA6EA96F349202562DDB64600E0B056C12BC1C301838E0D7EE9
            C37E2C70AE7968E03171E67F65BE597DCCF92C770FE6183BBAF49A5DD6ABEF57
            47514536395651F2B06FA53ABF448CE325CD177478E145145500514514005145
            1400514514005145140051451400514514005145140051451400514514005145
            140051451400514514005145140051451400514514005145140051451400504E
            0573FE37F89BA3F802D4BEA174AB215CA4318F3257E7030839C678CF41DC8AF0
            AF1D7ED5BAB789E55874755D2ECE46501D658E49E40407C16E554ECDC0850C4E
            E421C7247E67C71E2D70EF0BC1FF0068564EA74847593F974F99EEE53C3B8DCC
            1DE8C7DDEADE88F77F18FC4BD0FC07017D5350B7B76C6E1103BE671FECC6B976
            3ECA09AF22F1CFED83711B04D174BF2E342C65B8BC3D02E49015582FCCA06D62
            E00248232003E2171AA5D5CA3497534D7131092CCD31F9DD8124B316660BF75F
            E638520A00DF28351C50012288953319F2FCC8D49F9870CD928DCE6473CB1E54
            F3CBE3F8E78D7E9419FE652951C962B0F4FBEF36B4EB6D3E5D5EE7E9B95F0060
            E87BD8A7ED25DB65FE66CF8BBE206B9E2C27FB6354B8B8F9725666115BEE0243
            958C7EED400AA41C3B05032339638F2B35BAB6E0DB172D1EF2C146D720201823
            9DB180A101E4952C4925814C11AC8ABF67F2C290E50A2443E4382446A768C8E3
            70C884671F3E1D244F19DC9148B22818F94EFCE3A13FC5FF002C813E661B69C9
            014E7F9CB34CE31F98D5FAC63EB4AA49EADB6DDFBDB75F768B43EDF0F85A3422
            A1462A2BB256058DFCF6897CD6CEE21158A3BF2C091F7073C92467E6914F0029
            2322DCAF2BE73670C0C47072A0E1B21D979908C1DBB5247E30B922ED795B059A
            26C3AB28F318A85E1D7272E46D88EE2AF827009CF0E4B6954FCB0B6E8B004621
            6DAAC0B08F076A0215C90031C0015F23927CE8C2529251D7FAFF0081D1B56B9B
            7325ABF222963DD1B2B292B28382F10EA7D03054566DC47424B4841F9508A9CE
            FB956DA6431DC64A9552EAC85D8673F38C6D7561C0CE067E5042A8D2E4B693F7
            71BA792A3E610804281B0E3603B98EDDDB769188D41553834CB9D364656DD6E7
            73296DBE587DA184C71C44C09F9BB13DFAE7E7D3EAF51ABA5FE7FD75BDBF461C
            C9ECC8EE4F9917EF36AB2A1626507F760B0058F04A8DD9230F8FDD2956C02438
            C9E7EE059594B6191D8301B8B2E187998237395C7731B003EE8124FA7CDB6465
            864C6E936614F07F7BC8C6304E473F2673F7DB232FB9B69D919C2CDD1C46F860
            F83971FC2ECB82AAB83C1E46DFBAA4FABD5F8631FEBD34EABCFCF6775CEB6441
            1AAC676B248AAAC2590CA76ECC105B72E0A8398DDB7E157246D3925A8B52EB24
            3F33AB31562BCAFF007371DBB47532392761E7AB21000926D3E6F9B6C327572B
            852BF37EFB38E170791CFC99FF009E8D4F6B46FB649BE36786470AFB90857C92
            9839DAA796C701B2B18E4964A161EA5DDA2FFAB69D3FAFBC39A2568A3F34430E
            D65755185D9B9D0965058828D825F2D92C413129C91B8822DB88E4844316E236
            EC652230785525401D0C3F2EFCB0518240F9A64D3A7915A3649B6B00B20D8DB4
            16C2138D814F265639420F04951B69520B82FE779326F863326D68DCF39E4646
            4FCC778DA37AE11187F086AFABD5DF95FF005FD5B4F96DAD73222F9A45B79155
            7E60BB19FE6CE0FEEC921B0D8320EAFC942557273492A9D922AA49E5CCAC9F32
            92CD9080677ED524A850376E3B9C8E8AD5249A79591BE59182B60C8B1959303A
            90563EA7F7BF74F5718237AE156CE449159A27591583BEC89B74848527E705B8
            183F28EBB517EEE0B4FD5EAAD795FDDFA6BAF7FE909496E46F32CD0BB6E69236
            755C0932B26E673B4E59970C8C301800772F20950AD2FBAD9D7CC8FCB9232CE7
            0AB19044A77606E50A7AE4819E32CC72B530B6B853BB64ACD1A050E55E4655CF
            4C92A4FCD8E8096541924B2D2CB67298DC88E4E4B15650C08E64271B54904838
            2428386E19895C9F57A9B59FF5FE5FE7ADEC1CCBFAFEBE645349E5AB67746B26
            595597CB04E4B82772EDE0307271B818CE77E0E058D5B6C31EC5D85C2ED2CFE5
            8CC883E55CEDC160010CA701BEE8420493DA4B11CB8937676B840DBCE4F1D093
            C8F3991770200E158AF0D94CCAED95DDE5EE2410660082ADBB683C1C90C0162C
            15405009389953946DCC9AF5F5FEBB7F98A49AB21AB179EDFEABCB1315670232
            31F346DD4C79E0B39CE41C96E873B00F218B6B1B91B53CC400B0CB28E1F0D963
            8C47C05203373B8E4844B5560D1C6A3F76084DAB1B30236C6A4ED53B46E8C9E1
            4E3CB19202EDA6CA56D6362A16159016404796015C95CEE5DA36A953D370F2B1
            F3E0E269C9C1A707F9FF005E7BF55B0F953D3FAF9FC8EB7C25F1CBC43E057DB6
            FA999EDE156021BA916655C171D5A5DC3E58B18C8008CF1F38AF5EF067ED7DA5
            DE491C3ADC274F2C594CE84C90E577E727191C2138F9B1D091C13F3B17F20CAB
            1B2AAC3BB187F9142E7A7CE836AED8C1C0C0C9049DCC44AD1307C62E55B2C9BB
            E6040DF1804361BB007AED241DC3EF6DFD5384BC67E2AE1E946386C4B9C17D89
            DE51B2F5D56BDB7BDB73E7332E15CB71BFC485A5DE3A3FF2FBD1F6E68BE24B1F
            10D84775677505CC130DCB244E1D1873C82382383CD5EAF87FC31E29BEF086AB
            F6AD3EEAE2C6E37096444739604C6E576B2E5B21641B4A312148CAE303D9BE1C
            7ED672279367E22B590B0217ED96D03796FF003EC194E597B31238C1C8C8048F
            EB8E04FA4F64D99F26173C8FD5EABB2BEF06FD7A7E87E6D9BF01E2F0CBDA61BD
            F8F6EABFCF43DEA8ACFF000EF8AB4FF15E970DEE9F750DD5ADC2EE8E58DB2AC3
            2475F518E476AD0AFE9BC2632862A92AD869A945EA9A7747C2CE1284B964ACD0
            514515D248514514005145140051451400514514005145140051451400514514
            00514514005145140051451400514514005145140051451400514D9255863677
            65555196627000F535F2DFEDEBFF000556F03FEC576971A4C4D0F89BC72A8CC9
            A2C33855B61E586125D4A32204F981F986E60AF85C02C33AB5614E3CF51D91EA
            E4D9263B36C5470597D3752A4B64BFAD3E67D11F11FE297873E0FF0085AE35CF
            14EB9A5F87F49B452F2DD5F5C2C31A0E3BB1F71D3D6BF2E7F6DCFF0082F4EA9E
            27FB7787FE0F46FA3E9E57CA7F115CC4AD76E495E6DE06C9504F00C8BBC8703C
            B562B9F8B7F69FFDB07E217ED7DE374D53C67AC4B70B6AE8B61A7C51ECB4B0DC
            3E4F2A17270ECA4EE327CF8077383B48F298936C21236B65792386357DB848C3
            C6630EBD11902AB1CB63798557E60C8A9F21987104E7EE61FDD5DFAEBF7DBD7E
            EE87F6BF86FF0046DC1603931DC4D6AB5746A9ABF245F44DE9CCEFE76ED747D8
            FF00F04FEFDAC758F14F8E352F0AF8D35ABAD62FF579A4BFB4BED42EBCEB86BA
            672658BCD909391867F9582860EA1F286BED74992E8EE89A295599594EECBC80
            9122E570CC02EF41CE36EF6385C2D7E37E93AEDDF87357B5D52C259ACEE2CEE5
            2EEDE558D375B9138941E415E1844BC7CABB8499756247EA77ECCFF1B22F8F7F
            07B4CD721DD1DD379A97310CB9B6B94C89C7CB97E19D8839527E41904B63F883
            E903C1728D78E7F455D49DA7D6CEDBB7FE7AAB3D763DCF14F8469E02AC31D838
            28D3968E2B4516BADBB35B6D6D6EAE7A0DAAA8709B73CA1552147DD31FCC540C
            E76EC3CA02A411B802A69BFF001F56F1AB32FEF906D324AA53FD584C8DC1CE49
            9147CA5871D492432CAEB14591E588D46F546C7971322C98503705CAEC5C80C4
            657385FBD523E6DAE1B6BCCBF26C5639DCC0671CE32EC01908521C1DAA7209C9
            FE5FBE977FD69FD79EBDEE7E4047B567958ED2872CFF0022AAC9B77062781BC3
            6D908002820B364E583526D5B93B5843E7484E4809BB710073FBC2DC32B1C290
            4793807E51B9D1482181C7EED16150CCBB86C8CA9040FBCFB5437983207017A8
            D809165F22CC05FBB0FCCCA5D060295C71CAAE046EB9CA2EE56E99043D756B7F
            EB5F97C9EBB86BF64557FB44D236D5956E177056248946D00676F047EF157215
            C054E4938DB248AF2793B557CA2913A92A64F9CEF3B9829099DE549DB9F5381B
            58468144CB186136D7009C1218A98413DC92083C9DF823975ECEB9688984B986
            3DD123E7746CCBFBB8C072CE4FF719FAB67CB07771B6B586B4A76F25F9FF004B
            7DB5D1691BB561D656325FB2C56D69717123465E28A005D8F0DCE559DB2C640B
            BD464B772194559D4B41D4B40919AFAD2FADF9257CE85E2F3586547DD00FCC63
            5E4A11C3282C196BA1F847E38BBF075CEAB0E9F6B24DAC6AD17D9AD301552DE5
            62FB588DB96064738670A3087D496EF3E26DDEA9A4FC029ADFC505AE356BAB96
            36D828CD1C6A7EF12A0A9FDDE701B77DE1BC90188FD6384FC3FCB739CA6A6315
            692AB18C9BB46F08DACD293BEEFA69F27D3E5F32CEB1387C62A3CA9A93496AB9
            9DFAA5D12EADBF3BAD0F21D1FC3BA87886693EC36379A879732A48F1C45955C6
            797DA8719F2A3E4A7CBBF2AC4600A6035B3C7E6C6D1CA8A9B90AED98B1D995C6
            E2CE711364AB1040007998AF64F899E24BFF00835E0EF0BD8E933C9A795B696E
            6F248C45CBE14B6FDCACA012D2BF652CA0640C03B1AD784E1F16FC4FF06EA934
            3FF217B17B9BC555255DD1612BC1057041C107921176F4727DA8784385AD0FAA
            61B10DE260A9CA71E55CBCB3B6CEEEED69BAB3BDD79F1FFAD1561FBE9C17B297
            372B4F5F76FAB5D13B69AFDFB9E1E7C2DA9E9F630DCBE9B7C2DC28D92AC24C64
            2B441B6B2E063E5270366403FBB620D53853CB10B6E52AA562574394E0C2A543
            0C003208C0D99C7DC6AF70F08FC4FD5BC4BF1AB51D1EF3CABCD16EA69ACC5BF9
            09E54712F9BB1B96CB06540091B812DC60642791F89F416B2F18EA3A65BACD2F
            D8EEE7821059A695FF0078E91E7E724677119523EEF263C141F2FC65C0F81CBF
            02B1B965575231A8E94AEADEFAEAACDE8EFA6FAF9591E96539D56AD59D1C4C54
            5F2A9AB6BA3EFA2D53D3CFF3C91189708CDE6799184C86F3378F946436DCBA81
            2B750EA70092A73562CF4BBCD72D9BC8B6BCBC8D44734DE446D2EC46C1DD8566
            DA37172183023CB180CA84D5BD47C23ACE9B6D25D5D69BA85A42AA9234D3C3E5
            C28CD9DAC59954021846A0B0671B4650672DA7F0FBE275F7C3BB3D57FB2ED435
            D6A30AC4B308CB4D0329211CAB654B05914E1C8241C9C05DB5F2397E4F46963A
            9D1CEF9A8D396ED46F2D3B2BABEBF97A9EA57C64E545CB0769C95BAE8B6DDF97
            96BE465C9E1BD56D924926B3BF8446C919764640AEEC54FF001303B7F7870415
            E1467319C43A3E87A96B16CD258DADDDD5BC6B1B66DD1DD23DC4285E0A0F9580
            1B76E76A30EB262BD7BC45E37D623F80FE76AD78D7775E24BA5B7B7236058ED9
            987CDF22A12ACBC1FF00AE830C4E329F163C71A9FC2ABFD0343D12E3C986CED6
            19E78D123DD7ACCED80D9CBA82D09DCDC8DAEFF78E5A3FD7311E17649469FD72
            7899AA5184272BC1732E77682B7359DD5DEADD969E4BE629F116324FD8AA6B9D
            B696BA3E5B5DFC377AE9D35F99E312B67742D26C922CE44CFB5ADBEF212DB98B
            E0295E531B8B021B0C48B9A9E857FA75BC5717B63A858A4C3719654655915886
            FBE095C22B38CEF01482429052BDE1BC2561ADFC7DD26FE38EDD61934B3AA04D
            8C565977EDDF83F2A9C3A907863F375E7187F0A3E245FF00C4FF0017EA9A3EB3
            20B8D3754B595E1845B6D58D72846370DCB85915704637264E19B156FC1EC0D0
            ADEC7198992F6D374E8DA3BE89A94B5565AABEEEFA2BA27FD6BAD38F3D2A6BDC
            8F34EEF6BBB5969ADBCEDF91E331F991C8DE5B1DCB213F217550D93B90E14A9F
            99F6938070493CA668B931CFA7C2D27DE8E231BB480B30FE0FBAC1F0CCB26403
            F39C2839F9B136A36DF67D6EE21DAB234770546F1B77B0F35D41E4F2320FF176
            608A0835197FB3D847B7CE51B4AA8C30CB0F2CAE1329FC0BB8A2A91C30E0E437
            E218AC23C1E26B6167BC2EBEE76EEFA7E6CFB3A73552319DB7B3FBD7F5F3219A
            40F13798A8CE031224752A0846DCBB59CFF11906015C0420B6146E5982DAC8C7
            F78ABF30720884C80024F384C93B663C310A583E3046D7C927D925DACD22AA31
            F9DA470A4065EECC3A2A3E71BB2016E8DB5A2F3D615563E5868C7CCDBD158850
            A5B277962C4C6CBCB01846DC5828CF9B7D6FFD7E5FF03646F1D4B0DE747247E6
            076689B78DB116E49C92387EA04980082032AE01208AF1C31C7026F8E365C88A
            41E586C601408AC7E4E4ABAE309FEB31F293865F2C293B76CED1EE3BB8F98A08
            B7632ACEC772A8E0B11DCEE0AA11488A38CC2C9208C144752307A6CE8C02E711
            6155807DC72A3A8169FD7F5FF0D6145597F5FD7EBF88F8170235F336AC843196
            376DA4B2A93CF0872FB08207CC5986DFBC69B2C2AF1B34AA238DB3B9DA3F9501
            FBDD62EDE731E7FBBCF5931284116A18F2F82FB54E0A31CBB31C1CA8E4824ED0
            72B1E493B96A25876A2FCAA8CDB104851936663D98E557182E0809B0FCCC0004
            10C46D7B7F5FA76FBFA845EA5ED17C7F7DF0FCC9A95AEA1FD9E618E59657250A
            9D8A858B2EE667DACA576EE0A06413C293DB7ECF5FF054EF08FC48D5E4D2FC4A
            BFF08DDC2CAC90DE4D229B39C7552CF9C44DB41383907070D9214FCB9FB557C4
            EFB0E9F1E81A7DD28BBD412492F82161884A831F99C285C8FBC4F2A8A324AE41
            F9F91CC938DBB6478C16811D30D9555287E6C03D46405DAC40071E63327F63F8
            0388CE329C0BC654A92F6727A41EB1F5B74D36FBD2D4FE51F1978FA186CCE183
            C0A8B943E37F859F5D3CADAE8FCFF732DAEE3BC4DD1B2BA838C8FF003F43EE08
            3D0D495F947FB2B7EDE5E2CFD9B658F4F9A7975CF09C6C7FD06E599E4B28F12B
            2F9521F9C2ED5CED6455FBE4AA64CA3F48BE07FED15E19F8FDE185D4B42BE466
            8D47DAACE43B6EB4F7E729327F01055867254E382722BFB2725E24C2E60B962E
            D3EABFC8F9FC8F8A70998C7962F967D53FD3B9DD514515F447D3051451400514
            5140051451400514514005145140051451400514514005145140051451400514
            5140051451400557D4F55B7D22D249AE268A18E243212F22A0C0C64E58803A81
            9240E45667C40F88BA27C2EF0A5FEB5AF6A9A7E91A6E9B179B717379388A2897
            9C163D8120F63D0F5AFC64FF0082947FC15A7C41FB576A179E11F06DC6A1E1EF
            87225952470EF0DDEBF1A8601E5DA428B75CB130F0594A97DCE1547163B30A58
            4873D4F92EAFFAEE7E83E1FF008739AF15E3561F0516A9A6B9E6D3E58AFD5DB6
            5D4F70FF008293FF00C16D8DAFF697827E0DDE379C8B2C17BE2E8CE62007256C
            C02C091855F3DC632C020F98357E64DF6B379ADEBAF757579717579737C93C97
            13CDE63CAD23E18B3B0CB3021F2DBB0CED805BCCF28518832246615DE76160A5
            F9276155192194B2363E66190A72E37052E1FF0054CB1ACD2C6D9689B24BB199
            0AA9224E325410A48059CEC2FB9A52DF018ECC2B62E779BD3B74FEBFAE9A7FA2
            FC03E1BE51C2783F638185EA7DB9BF8A4FAFA75B25A75D3AB6DD545BC31B0C46
            D6E40461F7C9FDD3E4B6406CED04302376E12282E8039D9955A3F2D7CE8D9242
            8C8577CA44670016F33FD6B07E08C943B8066F319C2364DCB1EDDCE3C94CB7EE
            DB32B18C6492AE9891C066EACC382FF2C6B0A2BCDE42EE685A68E36421D58AA8
            DEE0A633975F9B68CB64007846F2FCFBDB5FF87E9FD27F3EC8FD0ADEF72FF5DF
            4FEBAF98D748EE246F25A26563288E5DA39004986E73BB7C6CED9E589691D415
            639F73FD82FF006825F83DF14E4B0D4A62BA0F880C70DD40EA7F71301E487041
            25777FA93905B186C90A36F85293A95B8691BCE79A306461865C48A5BCBDC99D
            CC4C83637CA50B6780EA922CC1E62CBE5CD31698EE8F952ECEB2175CF07CDC7C
            A76F45C329D9BA3AF2F3CC9E866582A982C46B19A6BFC9AF4D1F4EE7999B6554
            732C1CF095F69AFC7A35E69DB5F3EAD9FB370DEA831CFE62EDDCC3793B55F046
            EE771C85CCA40DD8183856001A48A35487CB60BFBC52BB546E25506C2085C83B
            46ECA6CD9B9D40E793E13FB05FED18DF1A3E1A476B7F334DE22D04A59DD34926
            D6BC058B41312188C48BD4F3968E5C292FF37BB33E6191B779D1CCB90CCB859F
            A2E385218BED8C60AE70E76161C0FF0037F8A787EBE4B99D4CBEB2D62EC9F75D
            2DF2DEF7DB4DCFE32CD72DAD97E2EA60EB2F7A2ECFCF5D2DE4F7FC89111AEA25
            DDE633337F086F90E543E18338523748A71838E32026EA36C93EDCEE56720E4A
            C8E80EEDC1B63292304AF1B8100B0CFEEC10C91962DACEDB922C65890C3726E2
            C14B9C2E4C4B9F9988C6485396A58AD562995447FEACA061B541237A2838D99E
            4459CE02FA1C0057E76DDFFAFEBFE1B6B1E6FA8E0649D02FEFD55F6160C5E4C1
            1B307E78C9C82C0F3DE304E3E7C3AF2E089B7965B7322ACA433050A4AA9C91B9
            091F2FF12E488A41DC01563DA2DD1A31199142045DB1B36EC0E026C0786880E7
            6630E7E50AA45B6DB242F35BCD0EC863DC63136DF2C0036C870F86DE50B1DC57
            76F249C96DDD14E2DC2515BD97DDF76FE7BFE24CAD16AFE9F97F91BFF0F7C0E9
            E3BBF9A28F54B5D2EEA352D0ACAC9BA4676653B38DA24462C1880D9DCA1B3B81
            1DE78B275F01FC10BCD1750D62D6FB55D46659ADE086669A341B9262A19407DA
            4719C104107630DC0F93CBA4F9D238755918950CAEA8CCC1888C92021386553C
            F70C41C0C6231612246FF752E2521995B63798CA37039380C4B464E06CE1C93B
            4E0D7E89C33C690C9305528D0C25EBCE2E2E6E4ECD3DDB8ECF47BBEB63E7F1F9
            44B19594AAD5F7134ED65756D77DEDFF000D73D6F54D22CFE35F847C3B3D9EA9
            636BA868F1359DC4773208C611E32F228C3E30622C3D470C41195975CF8A3A5F
            867E2B7866D6D6E1A4D3743B3363248FB9F7EEDA9924923F854860BB9CAB00D8
            E1BC867D299D5A3D91A3C848024641BC859157921C96DBB725BB007D54905AF9
            45592686386490C8A827C09034A58B0DA4824EE53924839DB84DDCFBD2F16F1D
            1A4AA61B0D18E21A8295457F794365CAF44F4D7EFE9638D70CD293E5A951CA9F
            BD68F6E6DFEEE9D8F64D07C2DA4F843E24DFF8BA6D7343B8D2D7CEBCB54B7941
            9E4926776002F4E92301866DECE302304A9F23D6F547D7BC4D7176EB12CF35EC
            972CA8CC159CCCC46D47218855576C9F949CB00FDABDBDA3186347923FDD8859
            43CA70A4BE01018B10C428C02A0E4B00C49621B6B63304C217561179BB524DD2
            02DBF190C57E6258E0B29CECCB1C91B7C0E2CE38AB9B6196170B86F611E77525
            66DB94DADEFBAB6E9795FA6BDD96E4EB0D5255AAD4E7959455D2D12E9F89A9AA
            7C45D775ED30DA5D6AD78F14C4218FCD7DA59B0C0373BFE5560470A7F7649201
            AABE16D2A0F156B9636324D6D05BDECA21769767971C257748B925D798B1B540
            019D41C14248823B06F3957743B640621E5CA1795CE5432853F2832003078453
            F29A44B692EE3FDF18DD59955D9EE1595D83A2950BC8249427EEA9C90000C5B1
            F212CCB1B5B150AF8EE6AAA0D6926F549DEDBBB2FE96B6BFA9F57A50A72A742D
            1BAE96DDAB276EA765F1DBC656FE28F1D5BDADA35AFF006768A896B0849401B8
            950C5007017861F37500C640CF5EAFC63A2E9BF1E2DB41D5A3D634CB19A2B748
            2F639DCC72C04105B67232CA5A4F94E577AA1041439F204B4B896C9576ABAB46
            D1B2ACAACA58B32B6EDD9F9B38249F331871D4E59E217591995A15DCE417320F
            9CACA4AA9386E8C400323EF310010057E8187F123132C6E26AE330EAAD2AF64E
            1769479758D9ABB5FAB3C4970FC234E9430F539674DBB4959BD77B9ECB37C6DD
            2E1F8E96F3477319D256C96C45D898790EAC7CCF341F3029524607CA4811B9CE
            D6150F84FC3DA6FC0ED6755F104DAD69B3D9FD9644D36CEDE7446BB1C6D5C70B
            B95610A0A9DBCC87E55185F1F8F4F78A59159D55B2BE612FE5BC8199D4728FDF
            21870016248018FCA7D926551FBC8E1997616DF224632D80385C92A4FCB8DE37
            1882E48C9AF569F8BB8A95475B15838CDC25CF4B56B91F2DAD6D6E95969A6BF8
            733E14A292A74AAB5169465FDE57BFC9BBEFE7A21B777321BF96413493EE9A4C
            C9B8AEF21C00A4EF09F7555073966639030E089B6DED2D7632A890E46D654590
            7991A8202B81B71803EF1C1C1E72ACE168EB736F8F2F21C2B2BCC7CC5180E549
            C920AAA293B490E776473B8365F92DBC9888918C728972E5B2C0283838FDE6D3
            85DC518F18272086FC7F115AB56AB52BD6DE6DB7E6DEBE5FD58FAAA508C231A7
            0D97FC12383F73244CAAB1E71C42A382A172A02F39FDD38DAACC47190CB80AE0
            65815721B7280A32EEAB210FB7EF337CB92233820E416C6FDC4D36789A64B82A
            ACCA55C138DDB80330C67E6C8C9FBBF3E3FB8B4970AA864902FDD772C542C7B3
            0CD901F040E04B9258105CE76961B7CEDDA5FD6BF95FE5D3D5EDBB162984A985
            93CF932A54F9A583E36738CC9C1210EE2385901CE724A1702277F987960A2C92
            48DBA25E186E6C1DBF7A3C875070AC5B7814FB9DD1C4566576DCC014DCCAB264
            918C316421B2FC1231B917838223C865DC591FE432972E235E44C7782A5B683D
            9B8383CB31E284D357FEBF1BEFB79F5D3716D7060B05BB4AA3C9DBBB69555458
            80D806594363695553B8E3E56241550067F8B7C416FE09F0DDEEAD74BE4DBE9E
            85C840AA411E532C2021CEE2005E58293D7E5231A90EE7B8DDC19599194B447C
            C61955E323230AC4B00A147998C8218D7CEDFB537C486D5B57B7D02DE489AC74
            E28F7601122CF708A0322300B9D8A58EDF939639DB5F59C17C395339CCA9E163
            F0E8E4FB2EBFD7A6D6D7E2F8F38AA9E4394D4C5CFE2B5A2BBBF2F4FE91E71E24
            F12DE78B7C533EA977BE69EFEE1A7447DC06E0088E307AF0AC00D80B7CC801CB
            857CA859A1B38B733B2470A34C6351F70798B9C125724F98A7EF29F34865DE4A
            BA940F16E902C9F688C6F6540778F30207DCC486CBBBB6E7251FCC032BE59DAE
            8D96EE48599D42C87CCF3073B0CB2677F273C1650A4B1FBE15DC6D646FEE2C2E
            129E1A8C30F452518D97E1A69DFF00AD5DAFFE75E618DAB8CC4CF15887CD29BB
            B7F3F969D2DF7EBB364877FEE760DDBF1B550B0F3BCA00AA8E58E00401548762
            AAEE54AAE77BE1BFC54D77E0EF8AD75CF0AEA9FD93A9431C851A0C9F36376C95
            6454D92C6B855C0CE0A29076ECDB8317FA5C50AF96BFBF8A16DA14B222C83795
            60C40D8A0C8E0315272A5B702B207A4ED28126246DC41F9D8912195B71DD8196
            2410E4E039058A2A2818ECA55A74E4A707AAD7E7F2FBADB339E8D695292A916D
            35D7CFFAF96C7E9EFEC6FF00F0504D0FF6898EDF44D51A1D2FC60917EF2D448A
            60BC2A0B335BB28209208223DC4ED0482C14B1FA401CD7E1BE9D79369F756B35
            B4D751DD5AC88D1CC9249B99D66116E5642D83B813B94380E4E0B6E892BEEEFD
            857FE0A39FF0928B1F08F8FAE248F5475892C35692311C5A8161848A4C200AFC
            A286270DB325B9064FD5386F8C2357FD9F18F55A27DFD7FCF5B9FAF70BF1B2AF
            6C2E3B497493FD76FBFB6E7DB54536193CE895BE53B867E53B87E069D5FA21FA
            5277574145145001451450014514500145145001451450014514500145145001
            45145001451450015CBFC60F8BDA0FC0FF00879AB789BC45A8DBE9BA568D6CD7
            3733C841F2D7076E1720B1661B5557966200F6B1F143E27689F07FC0FA97887C
            45AA59E8FA4E956EF7373777522A47022F1B8E48CE58AA80392CEA0726BF0C7F
            E0A4FF00F0516D67F6E1F88925A69F2DEE9BF0FB45BC6FEC8D3DA501EECE4017
            33C619B2D216D8AAD9F2C48B853F313C1986610C253E67AC9ECBFE01FA67865E
            1AE3F8BB31587A0B9694759CFA25DBD5F45F3F597FE0A3FF00F0527F117EDB5E
            319B4ED3DB50D2BE1F69F7B9D3B49691035D3292E971700965694AEE61196DB1
            A32E3009957E5E11C6CECB1ED9616215640770258A44B92E31908A08E199B2AA
            7395F383134D0EC5DDBA4CC48E541CF999DDF2962065C9752C70FB412CD856A9
            25B8579BCE65FDDC772D705B0398CB0F3321803B54A22B67011A4CBAA940E3F3
            AC4E2AA579FB49BBBFF3E9FF000DB7A9FE9570C709E5DC3F808E5B96C1461156
            6FAB7D5C9EEEFBF7D6DD08D5945C43B8B798EA029E413FBCDA0EE63C9FF52770
            DC4951932661DCE8033346B1C2ACA11982AC8104F909190379206F756424120E
            E461CB975646CD02C91C72F973C6980567DAECE26D9BB04EEC932B7255D8B0C9
            0C582C9280A976CA8A9B6391C8521F2A91B33479EA4066DD96C17DE8580217F7
            7CFE4B5FEB5FC0FA47B37D3F5FF80BE6ADF25188FE48F734B2AB1C8F906F9761
            48970368C49F7A37241187C381F2C4A06548B930ED93EF1F302891595A5DA8D9
            29B42A6E0E703863F7D8B04B7FF4782368FF00D5C29110CC08316DF27686C676
            AAAB9E15B90E58336F62AFF2DA38F6AAC918669132D3049225654230D9DA080A
            CD9C80CC323249916BCBFE03E9BF974FF216BB2E8FF257FD17DDE5AB25902C39
            7914490C4ECE76491940B12804639558FCD38048DB9F986E6322BA458A12CB20
            5F2A0C4254657312E5986DC020AABAB020A888BAA2F3B95DF1DDB0B88E4DD1EE
            695EE555CC9F33EE2780832A783115C1704ED21FE6F36341F63B4DCD965B7804
            6C546D3084DB26588C8423771B7E55590796D18DCC677DFF00E0FCBD3F2169D7
            FADB6BFDF67B3BDF6B9E81FB2FFC70B8FD9EBE2D69BAD3B3369924AD6FAAC28E
            5639224F2C348A17680D190A720005D08FDD336C3FAA5A0EAA9ACE9F69750C9F
            6AF3A25649148DD2FF0019287CCE558A3723E520A8E88C07E37CA8FE7340CD11
            9247F298360F9A410A72AD85030EABB4633E6AA03B412FF707FC1353F683FF00
            8487C2371E09D5666FB46928EFA6F9AC313DB02A3CA60D871B090082DF32B461
            CAE1957F9EBC77E08FED0C0C737C32FDE52F8ADD63FF00036FF2B58FC67C5AE1
            7F6F4239B505EF474979AE8EDDD7E2B7D9B3EBACFD9A756766F902A976DCA195
            4A93C965381B656C12E76E4E7076B327EBE5B2AAB387254852012C47CA1D5412
            4B3A023AEF42C18370F72B1CAF227DEDCE542A901C2C9BB6FEEC93C6D6C9607E
            697DCA12E035BA4DFEB6155DC18E5C640465CB1214123CB53B99C1C9FBC011BB
            F8BA3A34D7DFFD5BD3B6E7F3AC47BCDE45C6E91E48D15D8EF0CCA1B0C4F3BDB1
            C032640072AA18630A2A2DAC8A72B9922632EDC1E5F00EEC28C80C5651B80507
            27E46CF2EF2CC4EED1C7B5A204E150038DE4F3801F1B624500023A7FAC1D055C
            798374AD1A125D63D8EE70D80FB718077EF7E149254771B29592DBF1FEBFAD77
            0561B2A4715CED92356192364837171911FF001150C4AA85C92C7328E769F9A6
            B7855A58FE642B23A6E95C058C8F32328DBFCBDBCEE2D9C800BB73C6E58576DB
            F98BE6476E30C87CBDDC1036100294DD8322A0DA09FDD80486DBB6410BDDDF24
            6AA915D48E8881E6032CDE60FBCCA1C2E59B9C81B012A4722BA30D4E32AB1835
            A5D2FCB4EBAFCBBF5DA6A3B46FD91BDADFC2DD73C27A5C97575A7C6B159889A5
            F2E7899A2E8F997972BF3EEC3648CB9248237565EABA3BE95AB4B6A6E2D6F0C2
            B14664B491DC483CB663865CB6EC12C012DC15E14B06AF56F1CF8874ED5A1F12
            FD82EB45B3B8B882D674BF170A925D85F924572E4AAF96510938E30A1D71D6CE
            99E29B54F19DF4A758D2E58EF8D893347A8450CC816351BFAB2B2EF27319E0F9
            8319CF3FBCE33C36C8AA354F0F88E54ED76DA93BF55F676D168BB59BB9F0F478
            871FCBCD569EBDACD7F2FABEFE7F733C4B1E640CCDB95942B12C026C672CA461
            49218990A80B862C841639069D2C0B2C786528B348FF0021552A5B69DC106D70
            5B6B3E403F3346DC60B57A4EABE2285BC336EBA5EB76234F30DC457D6AF3C70C
            D78647CB48B128F9E474642A170ABB8AA8538152F8F7C551DD683ADC70EA96B7
            F1DF5C5B3E930412EEFB1EDCAB929C796163DAA412406FF9664B664F99C5787B
            97423526B189A8AE6BDA367BECF99BD1AD5DBAEDD4F4E19F625CE31747776EB7
            5B74B69BDF7DB53CBE30AE926EDB92C626055E72C5548D85776F700303CA8076
            B3606F53562D34D9354BBFB387226918DA33CDC8CB3383BCB0C286F95B185538
            4018A915EADE06F192E97A178663975DB6B7B6B3B2BCFB5C325D4706D5201B74
            75664C324633B7829C64AF52FD3F58D3DF54D2EE752D4617BE5D1EE2D964FB44
            324F6F289A3742F290C63628C39E839C9042D7A197F8699755A546B4F1A93972
            B92692493B3B5EF7BD9DB65BD8E6ADC49885294151DAFB3BED749EDA2D2FBED6
            B3EA7982F87DB56D7BEC56B24737993BDBA5CB4598E5019949C7CEC7077FC995
            3B64603952449AF784E6D1DAE9669AC92E2C65368E8D31FB423624F2C85C6F70
            C18A8747E591C0C1C83E890F89D751B8D51AD6FB49D2B506BCB492E6E2DEECCD
            E6DB0840016E32ACEC5A34CE03395DB91F385592EBC45A55CC9A8B4DAB697A85
            81F10C57E22B7B84959E239676545C9619054A8C92639703820FA50F0F32474A
            77C42936DD9E89457CDBD7CB7BDCC7FB7B1BCE9723D95D6EDEDB596EEFA5F4B2
            BF747924D1FD9A293F73B6DD932176158987DC0A3E521B76D8C60AE70C769618
            C24518F31A3DCADE5CADB94643127085B2395386DE4AAA8CC8A7760927D03E25
            EAF1DCE816F05E5F58EB1AB47AB34D0CF0B0B8F22DD919082546517CDDEC132C
            06003B40013CF6156DB6F1E36AE536A3A9C6E08B8214841C67715CE3F7790A1B
            3B7F27E2AC8F0F95E2D61A855F69A277D34F27ABE8BBDBB773E9B2DC654C4D27
            3A91E5E9FD75DBAFCC00D916F78CADB88C06431FCBB42EEDA7213E5DAEEA3702
            A30324364191D254C473799E6332659D8B6E2790572A41218BB6405C6C5C80BC
            D470344CF0B2F96B8D853942C72EA725B796276CB8CE7925CFCDBD41107D95BC
            C61B3B867FDC871B59C1661B7AB2E482A4A93271B5B35F36FF00AFF86FC7F5D4
            F40122DEACBE486F2D0110B46D27961D31C21D9C0CE000B9C238FBCC4549B18B
            B3A65DB738562416DE15630F9552A1B70C60824293D0065A69B66CBA347E72E7
            F8A338DD961CFC8000DF36E2158FEF3390A0128844F22B47B6E1F89158A83B86
            E5018E22380CC89CF4C162384520DDFDFF00F0DFD69F986AC02794F198C793F3
            2846DBE58404F00FC8A71CC20A8604EC2BC953B90FFA4432343BA4519914276D
            ED2A860063AE47CC3671CF98C0134470016CDB415640103088EE002B8E429257
            1190C154272C3182E4074E9F6A8F2CAD87DCA4B15758F2E14F0C4A8650EEA72C
            3A1F958600A51727C91DF6FEBFAFC8539462AEDE9DCE5FE3478FEDBC03E0DD42
            F44D672DC5D031DA473380B2B15041DC703626F66E77203B46572057C932DEC9
            A84F2CED37DA6E2E5C177506513B3C726F0C9B86E7612904F0C4A80A18BEFAED
            BF684F89CBF11BC6927D96463A6D86E8AC0CDF2A6E0C497CB13B8EF31820820A
            3818500E385B89176C9BCEE8CAB0266272E595CED62CC4AEE2B23907A3C6CC1D
            566DD5FD85E15F097F65E58B11597EF2AABBBF65D1F5D6EAFADEFDD9FC29E347
            1B3CE333783C3C9FB2A2ECB5DDF57E7F3B7E22BC8BFEB1A565058AF99E6FDE7C
            1F31B7756C86C9DA325942B2B17DD23B124B211FBEF31A774051B6B072872000
            4F3E5F3B57AB615930F8A595584CC19A446DE4492316DEADE6039C93F290EED9
            42546E9222C4A124370D9662A88DE664AB2B3088230CA95F55942B3201C0C9DA
            C148AFD4B9BB6DFD68FB25F7E9A797E31D74FEBBDBEEE8BA6BB06EDC59E31228
            7DD38518CC6C0150D9E42931E087918ED5264C10CC4A245B8AAF96B261228FCB
            2B959C33DC74503760FF00AD09804F194739628A1191474123FCA46D90BEC538
            38E8EE642A79392AC41F2D54B075BFFA4CB02B32C5E7E4125CEF3E66F666073B
            B829B780CE3CBF982FCB1A8E3EEB5FF0FF00D7456B5B4B911D5DFF00AD3FAF45
            F78D53E7796A19B74CB1F96EE402C079A51CFDECE46F24AEE20A140146D57107
            9CCAE12461215982AA9F998EF5500E49F30A3498044B868C2EF2A1D14B4B861E
            5C9B63DC7CAB8640B8182B1A11C0236A9F30100300148D815190115BE76AAA82
            C628ED9379F99973801F07EF2AF94EC371D8467726D896AB99DDBBD9AFF3FC6D
            7D3CD79D8B52716ADEBDBEE7BE9DFEFD8FB3FF0060CFF828549E1C974FF0678E
            AF9BFB3E606DF4CD65D77343872AB14ADB70E01604382555465890C08FBF60BB
            8EE8663656E33F87201FA1C1C1E87B57E1B4004B751EC0C8269D4EE2D9F34065
            C6F385C81132904001BCC0CCC02A1AFB3FFE09D3FB7949A18D2FC05E30BA91AC
            E44861D16F647045B92A156DE460A30A782BB87F171B97613FA5709F15356C26
            31FA3FD2EFE7ABDB67D11FA8F08F18723582C74BD24FA2E97FC969DBA3D3EFEA
            29B149E6C61877F634EAFD3E324D5D1FAD0514514C028A28A0028A28A0028A28
            A0028A28A0028A28A0028A28A002ABEA7AA5BE8D6325D5DCD1DBDBC582F2C8DB
            550138C93D873D4F02A6966581373B2A2E40CB1C0C9381FAD7E52FFC16C3FE0A
            49FDB9A8EA1F06FC17A97EEAD4B43E24BEB099049296DC459230661FC0A640C3
            691924811BAD72E33150C3D27567D0FAEE09E0DC6F12E694F2DC1ADDFBD2E918
            F56FD0F18FF82A9FFC14CAFF00F6B7F1C3785FC2FA835AFC39D0EE7CC4742CA3
            5A914794F74EA18830A96F963C91870C465B2BF1DC713C656308D1AC45615408
            BE64720DE891EF60403B5B70E3690557846C3302E1638FCC58DA6558186F2308
            9BB9F98E32248C9CB3EE197184766A70F9FE745B7538708E8CE8102B2B860704
            AAAE64439525320850ACE4FE718CC554C4D473A9D7FA5EBF9DB6EA7FA85C1FC2
            181E1BCB619660636514AEFAB9756FBB6DDB4FD15E3954FD99BFD4FCF01F2C88
            C1EA70C496FBFB5CB9CB1DDBA5C168C31792490ADBDC36C5552B2381F2312A63
            C140067E7C79AC3683BD9DB3F2B64C4EB5DD15C46F1C6FE6C922792A786405E3
            9153E42003B5E4F94FCBF780214B968A276B5B68C46CCBB60FDD329F2C3C68EA
            154F7E18B1F941F2C80A1583626E4DFF00AFCFD3F13EAB7B2FEB47F75EFF009D
            95FACB048D14E90C6DFEA8C4E90B49FEAD94F96170AB8C9DF1B02A36A8906EF9
            3CB0628622D6E91FCCAAD1222B0C95C79AC1410305B0A761519DE09F2CA857A5
            9708648632912AA342885B18489650848618DA02821083B9D6420055762E2EB1
            DCB30F9DE2559911F0A703053270DCF2B9DDB82A859095281417BFF5FA7ABFE9
            85AF256EFF003BFE8DFAEFE7A34499262AD2339898C51E0CDBD444DBA4215B39
            2A446841C7CA06E257326C600CCA5A62ACCBE63CA199080D88CBB7041400364B
            E029389300796AF2451B0FB3DBAB4C8FBC5BEF24AB485B6ACA4AE4E18905C82C
            33BF7619829046ED3346620AACE11E34420E379728178C6372865C12A854B072
            061CE97E9F97A7F5EBAEA4DF4D3A7ADBFE075F37D2DD5D21795F6CC2668E42B1
            3B31DBB9199D9B72360EC2ECA36B39C60AB1EA8F109173249FB86F2D5A425986
            3E6DB2339CA8DA0F9A51895F955B7ED559082A2448D4CC1164584AB0404FC837
            108A4EDDD956420EF1D5576E1D30A39F22DA48DA46F2A18CC9B9DF064FDE9956
            4EA79758D5B746B9DDE6614B02A87AFF005A7EA55ADF83FE97E9F2D741C563B6
            69A36F3846A56DA45642AA41F32428E79079DC3043E55971BFCD0D5B1F0D7C7F
            A87C34F1D68DE23D39E117FA5CCB310AC85645F2943C6CEC4B05750EAEECC481
            70006670A531F2B05C2B7EE95A1D912A0F906E5064750C18E1959655C962A819
            F0C4ABA1747BC18646698A44E858CB164019667246728C3CD20AB12C53AB1225
            158E228C2AD3953A893525B3ECD76FEBB7432C4518558CA9558DE324D35A5B55
            67F7FCAF7E9ADFF5DBE107C47B1F8BBE02D2F5ED3DA49ADF528209D43A157424
            424870724B2E541CAE571925030037E045716FB42AEF0A1485E64F972C437AE2
            490E4484FCA48DD9715F047FC134FF006813E07F16B782F546CE9BAA4AB3DA6F
            0BFB8B80A18C590140DEB0ABA80586FCFCCC1F9FBED4F99FBC97C9911B06567D
            FE5CA9FBDDC4B11F77192033328C803190C7FCF6F13B8367C3D9C4E8C17EEE7A
            C1FF005F7FA9FC75C5DC3D3C9B319E15DDC778BEEBA76DB67B0C77024FE03247
            97C6C099242C9C2942F96656381BBA39CEE00077D9B10A43B51D158C40380549
            07CBC60232AE70AB85C70EE7682314D5593ECDFEADD9190BC88C8ECA58A00C76
            6101C97C95EFB0E177138B16D70DA76AAB74B0A4B241379837C2595F6973CFEE
            8E47EEE3F5FBABD78DFF009ED08D375211A8F9637577E5D5E9FD69AAB9F2B3BA
            8FB8B5FCD9D36A3F0C6F342F0336AB74D35B6A0F7490C76EEC804C590ED0DB4A
            B0625632437006403B58D646BDE0BD53C26B049796B2DAA5F48CB6D975769993
            6800ED70C5880A487195092862062BB193E25E83A65EDF5C59FF006A49713EAF
            6FAB113411460ED97698C924B1FE2C315CB2ED0B920B0C5F88DE35B3F18DD588
            D3EE648EDDE792E8C11DBC502C6F23C7273B09591F68DE58B6E3B73B5C330AFD
            873AC8F852180F6B87ADFBC845249496BFDE7A2E9D17CF767C9E071B993ACA35
            23EEBD5B69F6D976DB77A5AF61B71F087506D565B7D2ACE4F2E24855A50E8811
            A54207DC7505773200541E02E5B2014CF8FC03AB5FDEDD599B37CDAE249A3799
            5628849BD01F34E4E1DBA30C7CB82060367A2D57C71A2DED8EA8D1AEB11C97FA
            5456318366AACFE5E700B2B12A1847DF91E60180DC34DAD7C41D075D8756B513
            6A16F67796D65B2EBC985DADC42701B6EF21B7AE4EF385009CAF0D5D15387785
            6ADA52C4F2B76D14D356D76566D5F4B37A59EC671C7E6495BD9DF65AC5A7F66F
            D75D2FD2F65A3EFCFE89F0CB54D4FC4B3D8359C91B5ADC27DB82CC8BF65326FE
            AD90A642AEB80A4336E5F9D81DC2EF887E190B33AA7D95A4BC921D50E9D019D9
            3C865209F2A5937139CEEE4FCA0386C64AC6BAFAFF00C4AD0FC4173A84778358
            82DEF2EED2F625D9034AACA815E1C3360A9CAA820B05797208DBC32F3E246877
            AF7ECCBAC017BABC37A42C50C798D421313664E198C8C9CF2463803E6AF430B9
            1F0953A12A4EBC6776F575126976DBCED7DB7F4594B199A4E6A6E0E3A6CA3A5D
            D9DFAF5BE9F8BB1896FF0005BC4534B1C71E9C58C8E544A5A08F0DF7DB72B72A
            FF0075F18C31446000C81574AF855AE788EDBCCB5D3649219649BCB2648E3DB3
            2C8FB970C570EACC59B1B5818D86E620EDE9AE7E27E82F2C93349AA6C8F5C5D7
            7C99A08F04229053025C8206D7064014168BE556C91AB6FA86970F833FB7EE24
            D51B4F83C4AD7F1C496B1FDA2524298C4877100EF0AAAC4EE2084237B66A70BC
            13C31889F2E1EBCA56577EFC7656D76D16FD1FDE15337CCA0AF3A6A37DBDD7BF
            DF7DFF001BFCB9097E1CC5A8D8E8721374F73AA5DCD693DB9DD23C441557110C
            0629839C9DBB402DBB6102A4F107C2CBEBBD5A48ECACEEEEA0FB35B5CB453BC7
            BE38D8B6448F9DB229E40271D39DA55A4ADAD13E2D69BA6DFE937DE5DD4B7D05
            EDF4F343C22309739087715671B106D7209F98920822A9C5E3CD2FCDBD78E6D4
            5B7690FA65A3A58476E96B9FDEEDF2A370C91E022EDC0738209FB95A4B2BE0F9
            D0F64ABA77715A495D257BB77BEEF7B2F3D53B047159A2A9CCA1A6BA34ECEF2D
            76EDA6BD7AF5B73ABF0D756FF84827D366D3CBDF410092EE30F10558CF98E5B7
            79802C6CC147CC39E8D9C12B35F7C3BBCD3F4259A48675D4A4BE6D3E38185B01
            2C832C8C482C4B6F23A291939C7256BA0BEF1DE81A969F268B249A847A7DC69D
            6BA7338091BC0F06403E58942ED390308B825E2C0239A3C2BF12B4BD0E1B555F
            ED39EE62D646AB2C8F6E15996484C2CAE448D8708E0E1B7023681B3868FC95C3
            FC2D0A8D7B7E68B4EEDCD68F4B2B6F7ECD5ADF2D37963F34705EE6B75A28DAFA
            6F7D96BD2D75BBBA4CE575DF08EA7E0F28D7D1CD6F1CAD2408EB224E77286C8C
            095FE60AA8795CE4F4CB305C70BE465A3F2E2309C6F8C1F2D48280825507CA32
            01191910A838F9F1D4788FC4BA36A9E04D3EC6C6E352BC6B7BC12799751AAACB
            1C9E511BB32372176AED7F998E4E0715CBB09044CAC6469A224B062ECC4856F4
            190093280EA10F0A002300FE7BC5596E5F82C62A7974F9A1657D53B3F26BF557
            5DB467D06575ABD5A5CD885677B6D6BFC9F97C81A11247BBCB7DAA7E701048C7
            695079192587009DFBB74408070454864F34FEF1BCC585D832C6E59BF8C330DA
            ACCB9FDE63E6C8DAAA31920138612B31577F2D9D9432B381C96C0263279310E9
            D3771D23CB446D02F978DDE529215976F1195230A37039C47CA2F1963F2B1DB5
            F2F776B3DFB7F4FF00AFC0F4375A8D8E1F322F25915DA3430EC18711123CBC90
            3200CA30C88F80DD061C579BFED2DF143FE10DF0BC96762C5756D637421F0B98
            E16241707008DC11546E04151F29F9771F43D42F62D13489A69A454B6B78D8F9
            878F2FCB272CA02BC658244CC1428C32741BF03E46F881E39B8F88BE356D4A65
            9ADE0B87F26D218BCCC450ABA05C007272DE58000DA5D9802BC91FA8F85FC26F
            36CC956AB1BD2A6EEFF45AF7F97E47E43E30F1B2C8F29952A12FDF54D23E4BAB
            F2FEB6DCE7E358D6E176FCA721546C31B1511B724285C856419CE4673F329DAC
            441BF636D99776C5C2A92577387907057E5032C0E40DD9C67734CED8D0CD0C67
            E51E6C4ADE5E079593E5B96181864CF98A490DBF21003B77AAB46663F37CAF31
            932F270C85CEFDF9273B9546E639CA0662D27544FEC58C54572C7A6DF2EFF95B
            A2FBCFE099C9C9DDBBDFAF9F7FF3D8403ED2B11C7DF566384CB6269370500005
            B2ACDF2029B83A8036333C822F98F1EE936AC8C2742B216214AC855C30DA0845
            4F4DA36B8253CCC5384AD29775E1A4DEC898390C70D1A90703E652EE1708A487
            C676048D0C6AE09CC86228E4E5FE571E62E198900104844666180CC15844235D
            AFCBFAF3F3DFE56B750DDD97FC36DFAF9DBF216190097CC64C7CD13B2A4AEBB1
            33B117A82037CE9B9BA216E5DA6151EEF26DD95E48D8B2ECF9F2BE63C6F1B1DD
            F30196658B7636B158D5872EBBDD3179524F95E599A277DAAA774A65F2C8C267
            7658B1041E489402CC24DA24F34F9E1E191446B2398E4421D48C24E541E00524
            172D9015955888B32528BB6AFA7E96B2EFDB6EFAAEE6DAF45FD2EF67D7E5E80F
            E5F9C566F37C9577498B65F7208F730DBC0660BB7701866D993E5E4992331384
            FDF21F31A154914A8DC64425A4507241DA5882AC4A804126322314E8D3044611
            9B88804DA54AAEF3204C63AB21181B725B6611883206A07630EDDBBA655656E7
            0D9F34A90FC8E1565553F336D73819212335517AEBD5FDDAFDFB76F226D6F77A
            FF005D3FAFC019F96DBB188258B00EB1BA285C11F2EE3D4480AFCCB148C0336E
            5A1A0FDE61BCC2B1B32AC9B155D5951FAE3015B68672A38569F2E493903BF996
            CFB15954A49F232602AE4BA065638DA5407218E19A3666673BD42CEC23F34AEF
            9162F2F6E7AC91892465001072CDE50003280F8576524B9AAE6E57FD696DBEEB
            7CFBF7A5269B71767FD6BEBDBABF53EFDFF826DFEDB8DE30583C03E28B82DAB5
            B4691693792EE56BD8803FBB73B70D2228186CFCCA07A176FB4237F311586EC3
            0C8C820FE46BF0E6C67934CD6A0BA8669A39ACEE9A48AE6DFCCF3A36F3180646
            0725CBA90006724AB12E4AAB37EA07EC05FB5D0FDA2BC02BA7EAD22C5E2CD122
            097F1020FDAC642FDA136A052A5B3B8A9201E701594D7EADC1FC49ED57D4B12F
            DE5B36F7F56FEFFF0033F62E0AE28F6F1582C4E924BDD7DFFA5DFD3A1F445145
            15FA21FA505145140051451400514514005145140051451400514571FF001DBE
            36687FB3DFC2BD6FC5DE20BB8ED74CD06DFED33E48DEE09C2A282465DCFCAA3B
            B1E87A51EA6D87C3D4AF5234692BCA4D249756F447CE7FF0568FF8280FFC3207
            C248F48F0EDE429E3FF13B35AE9E87716B184AE1EF0EDC8F9776D45619672081
            8426BF0D65BA9B52B8F3A79249A47004CEF21DD379A70E649036483B98172CC0
            B4619794DAFDE7ED31FB43EBBFB557C6BD63C67AE36FB8D4A4115BDBC7BB6DA5
            B212B1DB20E8624427710A14B93B0798F85E020611086655F31E3C38DD1B052D
            912E14A313F331703008CEE503E531C9F9DE71993C4D6F73E18EDF76FF00D69D
            AE7FA5DE0BF86F4F857288CEAA4F13552949FE51F457D7CDE9A8E8B74AC14B4C
            AFB1DCB98886DBE66D766DA33F346AA5978F9CE7F76E1453155EE5772C6C3CD4
            52235F98E418A40B18017180AF8C0E80C8B93B8158ACC2082DDA3DEAB388DB31
            31F358280FD18E197E63B14F28072DB182B5834D1E199D9A48195B7B1771F36F
            18C70776CFF69300B6EC7CD378EAD7BA5FF03AFE8F4FD4FD976577B7F5BFCECB
            F2DF47A2C62E595B6AC9BCBC8442571FBD0A7807E554C2B860014DCAEDF31C3C
            65BECF6D23792A196DD1DD5A12A4EDDA3615E38E73C8259976919511ACA1FC99
            61E562512E634DEF85248EC4FDF8DC72599721E41B479829902ADBC50AAE142E
            D25909560CB2BC7F2AFAE5C2201B7690030DA15285E7E5FD7DDF3BF98B5DBAAF
            EBFAF976577CAEF034CB1CBCACB204DB3ED323ACBB412B900FCA1979E329F298
            5503045F9C797001E433AC11F95FEF3491305240DC06D50B91B3923CB0AA0892
            7969037EEDB6AC4D0805DA37E18ED1201B8825615F9480CC21618DE15902E4A4
            6773151E5AC6E515CFCE9BD36E49527008E858F192DB2406BB75FEBF4E9D352B
            4BDFEEE965D7E77D2DDFCB5491B315DD1A99711B48B144824326D882C854003E
            F65580DA55CFDE6C49190B8F2D1B632B6E55CB471AC8B2B312172402A77ABAB2
            AE36B32AF1116C532F1196CA612331664639917CC52F242A012B8C65949C9C29
            66F300D8198B497DB639A6FF00966BFE92016763B48319FF006B2C480A7FD66E
            2C3E421A445AEBFD5FD36EDFE7D9046CAD7F2FEADF73FF00268042770857CC56
            8A431AED90C5B1D95A346CE4ED2C5A4FDE72782B8326D48CF3199249238A691A
            6DD72AB0A15326D888631821C6470A0631CA29919582B3942ADCAEE589A3FB42
            8D8D8D91AC800C82415276AB3166C8E362EF66F32ABF93E769ABB91A4F321DAC
            1D598164C44FF7B0C4F97D40218859148858BEE95E7FD7FC0F4FF824A8AB72F6
            FF0087BFF9F5B6C89E26F2B6B41267CB1B5248C1651B184A180CF31B6490A0EE
            207560049142618E3B76DB1858EDD3B01234606C7460C0E0E446554E3CBCA95C
            12A5659E6DB7336E931FBD9640AFF248AA99DE46E662BBB6C9B80E8364BD5308
            233E61403FD5B420AA80AC3CB94B22962CF9DAD825B24B0DEF96DE423311959D
            FF00ADFF00AE9B7E2F45BFFC35FF00AB7AF4B344D0DE5DE917B1DE59C8F6F796
            A59ADA58E33288A55950AF2412C728B924EF69386DBF281FA89FB28FC79B3F8F
            3F0B2D7585F262BDB27FB2DE5BA306FB34D16F6705B00AB3619B0CC140958721
            483F96FE534927FA3C6DE6045688AA32B0688FF73E66E5A42F8272B9DB2101CA
            9F66FD887E3EAFC0EF8B56F0DFCD3DBF85F5B0D6375E6A7991D8B6E93CA7230A
            1768C82A4EC08E55800A9BFF002CF16382E19F64D254D7EF69DE51EEF4D55BBD
            969F86E7E79E2470CFF6A65CEB5257AB4EED777D5C7F3B75E87E9A4911866CC9
            1AB36E0D909F74E439405B6AE4B9401872DE995DC23291A6554432295223CA27
            972829B4103281B3FBB1D300BED0707E54B5BB5BD8D268FCB49256DE4F42BB9B
            1CB16CB2EE08BB4952DE59C64616A45B8562CD0B75512AAF98CD93B6360A4A9C
            B31543FDF38C1CE0ED3FC01529D4A739539AB35A3F5BEABFABBFC4FE53D53B31
            167580B347236D5CCBC48A372FCAC58E240BC800E7007EF949182D9749B95D80
            625A18820C23EE97687E4E3E719C48016DC3254A9278267CC90C6B206C93147B
            A51248B8DEB9E1D483CB723E6DB1B6496E024A7CD12AF97BB7ABC8049173C890
            92011D7E740488C9CB60EEE48CEEAFFD77F55E5FD2244DB142F9FDCA22C9C1DB
            1A22056E46707EEAC23A1CFA84C295194C6B28914E63C330570AC3EF6E2A7002
            6712FCE546EDC30E3A091BE7766DDBBE621823B17D81A6CFDCCB0EF8C9232301
            50E30D11C925BFCA3E67392028DA1C16CF4DEA3123AF51B86C249603917A7F5F
            73FE9FDC5C23B9F224661242AE0B963B95431E492D966E3F74C33825548031B5
            A8B48F7BC291AB6E8C00390ADB7747C6C072BF2052402A3E61F2127687405A63
            1EC7917CCC7945989046D2C0E44843636A838249C31E8F9A8DBFD262DADC21DA
            8439F33CB2CB1AFF00CB4EF866FBDB49C9F91B3C9D6CFF00AD3D1FAE9E41D6C8
            2191A0B63B1A48C2C7B7E519F2B11C6D82090AA701B1B91403D40CE1D2558ADA
            662DB576060A30AAD1AE5F214928546C8F036E1467396C12159D658247461B54
            BB00080CB9594EEEDB79254E761CAB02C7BC9233DB798CAD243B77B2B0565507
            7C83248181CB29C94231CE5F19149B5B697D3D7CB4DFAFFC040F47E60E8F2AEE
            5CC8CD95271B86E56719CED7DA048CA4027E5C741B58164291DC244B1EDDA0E2
            30A558A025186D187E177A1EA00289C0539A59EDFCE2A9247229655897CC50C4
            821860121F710AEF9CB755C9015892798CE31236CF94492172544446E3921B78
            1860EC1B85CAA282C2A7FE07F5D7A7F56BA05B05B6F16E1635646C6D5552E162
            24123B300079A830CAB800B630AA0110CA911C7B955C158CEEDB18054A823690
            A398860A8651B882792635457B6F2F644030F292360582332310AA09257893BA
            70A8D95DB801CE8931DACABB5E528170A796DC795C1C1292938D80FC87712BC9
            34DFFAFCBD5DBFE1C76D6E032D0990170AA8EA933B93B1572C32DD539DA0EE53
            CC655B7719742AA51FCB8E455271B162C6CFBA57E55DD865545601D49CB281B7
            EED08BE65C45E62A89832939C2C9BB774C16DD81894821B6ED6200719A491558
            299B7797C0DD3AAFCC9F3B659DC64E23DCBB71B865F39CEFA3ADBFCBFAFD3762
            120895DE14DA91EE381E5C51E15B6A2E067201528CC546E23CA5E780A48A48E0
            8E4DDE4C7C2BF9615472A2328B8EBC6E0BFEAC3636770A4A956E5597CD758CAB
            A619965C6E5505705CA90B210589197E37F18CCF1978BEDFC01E1ABED5277334
            766ACC200CB99A40762E76FCAAAF2160D904E5F71DA1085E8C261EA622AC6843
            57276EBFD76F4EBA1CF8CC5D3C3509622ABB462AEFA6DA9E4FFB577C436B2B58
            FC2F672799E6A2BDFC4AA5F2AB9F2A3002931337CA08DA06E2981C9AF0948B7B
            C88CC5A491958B30F99899B06460BF367A9076A9C3C9C94DA24B9AD6B775E20D
            5E5D4AE9E6B89AE6413C8141632B1577FBBE58214A976C676B7944A86E00A702
            A432085C868D7059148994448BFC2BC6E0598118077294F9860F99FDC1C0FC35
            0C972C8E152F7DA4E56EFA37FE4BE5B2DBFCEFF10B8BAAE7D9BCF189FB917687
            A2EBEBF8EA9DEE2C23CF7263F9A494AA2A872CC1D846B8F97A12D16E214B3B05
            C6482ECA5B3AC2F6AC311AE2168F0771214EC3B4672D804EC3D06C460CBB1D42
            244D77147036636B88E289B189163624E0E0121958484A819DCA8B956F964772
            EEBE49184127FA732B7925BCC32B33348C8096392C46003B4928CA59BCB7F37E
            BB4D9FA7CBF2EEF6D5F63E095968BFAED6F9DFAB1B0C6CD1C5092AA372204CAE
            D745383F7936940772925482CA0B9E36D35C2DE42C72CEF344EF19DFD779625B
            93F36E593E6DECDB70BB9DB32209502DD5DC6A6646FB64A184AE0B2CB1BF9997
            2991BF786C9206EDD0AA95DFB98321DD78997F3365D0DAFB893200E9BF277055
            6604A8248C16562CEBB8328DFBAE5FD7FC15F3F5D367D6DB5BE7D37F4F4E8BA8
            EB8D970D36F5531CAEB2B124624F32268C1624823FD616CB9270776F0CED233B
            63CF3859172F26124494166667F337A36E3D8CB1CAC18FCA598EE8CE1446B20B
            8186C0F3216690062CC165D85C8DC77B7CAC4062012261B98AAB9238F3430B83
            12A94FDFE4644442B166DB83F2FF000A9E47EF1B62E5CA4752DECFD5FE1F9F5F
            5DEE4A56D17CBF2F2F9D868963F298B05F9A18A6689CF2172D2B8DB83853C820
            A951C9D8F8DED324327DB364AACCD24856507E52ECCE5A40ACCDD19792771DC9
            2A8322860B51CB9689A3955A3DC268E50C7732332B48E4E490CD1ED2B96CE7E6
            2EC9B81559184934ACCC23926533C9B4B1642A07239DC480CC5581CB6E95D9C6
            582093D9EFFD5B5DEDF8EA9DCAE97FEBE5F2FCFE6A25954C500332C52B409246
            400A63321F30B2720A90C2375C636EE8CE1833B3CCE0932101635E51A3C03184
            8D9032AAE09DAB9566560C5948CA31CC8C36E3132AB240D244C31D638B27076E
            4636069BA9C9624A8FBF21A716C5D2BF96D13023621272AC38DA463931F9B96C
            65FE6400479902284BFE07F97FC1BF97904AF66BFAE9F97F9EA86BC2D2CB22AA
            B6E6530A90FE63329D8C807243103C864E5B785DA8E4AAE7A2F845F15753F831
            F1174DF12685E4C775A7B34AC864062922778411207FBE8E251D467F7990FB94
            D734C8B05B49FBB1B2389C95CEDE100562CD9C0DFB9549047121F9CBEF512FCB
            6F36D7F336C73397665F2C47B18365BEE88F0F2918F90E26C1F28124DD1AD3A5
            38D483B35B774F7F27A7DD6F2DF4A75A74A7ED61BA7FF0FF00F02DAE9DB6FD98
            F80DF1A74BF8EBF0DF4DF1069AC523BE8C33C121C496D273BA2208072BEB8C11
            82090727B4AFCB1FF82777ED3EDFB3B7C4D8747D5AE2687C2BE2078D2E8B9F2E
            3D366C229B820E4E0C81D243850786CFEEC2A7EA55B4DE7C2AD8DA7B8E719F6C
            8191EF8AFDDF873388E3F0A9BF8968D79D8FE84E19CF2399E1154BFBCB47FE7F
            324A28A2BE84FA40A28A2800A28A2800A28A2800A28A2801B24AB0AEE76555C8
            5C938E49C01F892057E3B7FC174BF6DB93E2D7C47FF855BE1FBC793C3FE1099A
            E75596166D97BA8642AC79DC50AC499186C0DCD2B1D85372FE86FF00C148BF6C
            187F631FD9A354F11C6D1FF6F5F1FECDD0E0908C5C5DCAAE01DB90C56250656C
            15E1301B2403FCFCEAF7B73AE6AD797779335E5EDECB2CD2B5C38F36E2567284
            B330E59A5918F3B8A79ACCDF348AABF3D9F639D382A10DE5F96BA7CFFAD4FEA4
            FA36F876B32CC1E7F8C8DE9517EE2E929FFC0F9EBD3421B991641334934602BB
            659DC330C00B9CB7CD90639D0061B42091A4C8CAB1760C2974C76DBBC493A9DC
            EEC20F2E253B8E3320F94F965B03E5394642EBE648929596365763B0970CC1A3
            326D1C04C1270DC0CAEE7D92460AB9C18E4D1F4F9354D4ADEDE3648F7390E640
            B1AAAC69E63339523615DD9DC49E1430936B10DF0B1E897CBBFF00C3F9755F79
            FDE92FEF7CFF005F5E9F86DA2505CC0B335C471A44AD2BFD9D5490AABBDC7EED
            80C8DAA4796F8387C050C5C2A23C48D3CA26877B47712078F0776F7CA88C1C82
            A6451970CC595B2ADF30DACB736E92F02335FEA2D186DEEC2CA26D8086567F99
            C2A8218B10EA854A4BF295628645834C3791A4973A94926F54F2C5B47211D15A
            3E6425B255890CC41DB2484A10A43F67D1B5FD7F4BD3EE33F6C9EA93FBB6F9FE
            1F7696B332D17C98CF971AB2B471438CBA2BAAA70417CAEC32329CBEEE1CFCA4
            BE4C8C1A09FF00DAF37CC77923D8405651E63657015B73A60364EE70C412E61B
            56F0E929133AEA37DBA3803890DB2655576A00CC5FE6001058EDC1072E557616
            47B3D26087E6B9D41A3B74241FECE543E579610337EFD58E1E28776F605493B8
            808195F2F9FE3D7B7E9E7BDEC3F6ABAA7D3A3F5EDDBC9A7AFA1454E164032D27
            94EB8DE59D805013771B9893339FBA4E1D4952EC85A555FDE951B95637789CAB
            B2AC69F7581EADC9572792010080CBB9C685C41A7348F8BAD537B48CAA86C95B
            748CC43B2FEF02EE20841CA9C6E398C8985452596932A6C5B9D54C3FEA2366D3
            8288774D958B064063C8C818C32285500B18CB1CADFC4D7C9AFEBAD97F575ED9
            767E7BEDD7BF5EBF2667216B7B456C35BBAED667560924452325C925B6636E14
            1CAEE033FEA901A92450AF22E6685428DFB76A34237B607238237ABA9380A0A9
            611EE2B2DE64D19E6120BBBF55404EF4B48F306E0809C79F92885C708CDB413B
            5D46C5214D3239176DDEA2A02AC8EA967130898860A481208F2AF11DA795678C
            6464C65172B6AEADF87CB777F9742BDBAE6BD9F7D9F7DFEEB5B7EDD594940965
            FDE28923DE24B9450645C798CA7078011410376EE01EA12364662F122BC9F3C8
            AB89CB2EE718DDE613B800C7688D486DE388D8F09BAAFBDB6922DFFE3EB54455
            C45FF1E0ADE51F35D9570262C9B8AE0606F56DA0176F2CA8E9A382DBAE7508A1
            5511BF97A7A158A2D824E8B330E338001380B185FF00588F4F92FA2FBBCBF1EF
            B3F2B846A28E967A793E9A7FC149FE9AD10CD681A66CB4906DF318C5E62A15FD
            EA2E79DC0E0461B0A4955201CC5B51235B511A47B648605920468C3348CB1828
            817E6525821E02E0E5DD941DC1CDED4349864D29E6B59BCCFB2BAFDAA29710CD
            03492798E57E67523723A64488CAE158F5494547DD7131C18E766B89D0480ED0
            A4B0DB8C10CB96DE41183F210A1D8894A95D6EFF002EDFD5AEF61D371B72FCBE
            FF005B7F5DBA323119994C9E5C91AAA4D22C415F007944E3695014A146DCBD99
            724602C91889648A366F2646F2A401CAA2AA287C9C9206D45059B73021377DC0
            C63569DC4B3998AACD9556976107F74CE18F98157EE8652A59B690A0B280EEF2
            1A1F6CF3B73285DA9F2463242E525C28192763636ED2E13CEF90B6F5459F27E7
            F97E3E9FF0E38EA9DFCBEEDB55FABBFE07E89FFC13DBF68893E2AFC323A46A12
            CADAC786585B4DB9C87BA4631B41210CCADB8C4AAAC0E4862C5B20E6BE8666C2
            ED693CF85F682EA095954AAE54798DB70C76807273BC8E0EE6AFC97FD9EFE324
            DF02BE2A697E224F31AC158C7A8C2A859AEE024C93C655492BF33EF18DD9D8AD
            BDC3064FD54F0AF88ED7C63A0D9EA16B7114F1DFC3E6C5306524838453925597
            9763B47CC370008C853FC43E38703BCAB32FED2C345FB2ADABECA5AE9A77FF00
            2573F963C4AE17FECBCC5D7A2AD4AA36D764FAAFD56D64EDD0D28EE7685DB2AC
            9B42FDD9B3E67DCC6332F7C2E3FEBB2E7ABE554C69285565114847965766D237
            008CA0855240687070E06D2BD7EF3E59DA2BBE58AFCE5D54C8D9FF0059D06E2A
            082540FE2C1900E13EF34A48B2A2E6690E3CA3B58C6D2055E837609FBB291F3B
            60B06390411F842BAF2FEADE5FD7CCFCD9798DCF970B0DD104D998F0FB901C29
            5D9C6DE18C614AA30F94FF00136294C0B3078E358B6ABED8F90FE50DC1390BCA
            AE402028183164B039C234CA4AC8D27EEE45C19558A0906492C18B038C34A400
            580555618E03124AB2C6CB33C23236B9628FE5E7EF101A42063F7C38046108E4
            280C47A5B7FEBC97DF7F3E850E7995A1136D5F2F8919D81C11BB7AE5B6B8C2E5
            464360067231B461228F744911C862A63076A1217E546181BC0032B90AA17746
            49C034E74F327CB8647DE15CB60940C400B9C92A76CC47DF0410362907058B70
            6E1646573BA48FCC3E5380C5F6236EC296CA8C20E439F9F1F77EF2DB6FEBB7F5
            EBBF495E43A549248012B2090A96CB249FBB3860703E6EE64236303C22824104
            A4A6366326D5882B65F6840D183BF2495395C069016DC30C8700EE20A6D8A298
            B15B7545938388E3440ADCF63F75611C024FA850015047E518E076DBB760037F
            978E91B6D2547A6D063C67CD1C2E4351FD7F5A7F56B0048AABB58AC6DBB0B2A8
            51B2463B832703693BB70019C8DD212727682F9A07543F24CF2296E0425727E7
            05976F1C99072195B19DCE70D8480FDA9977625DFB164217CCDAAE32C8725940
            2719DA4E14AF4003D46515A22CD12B7CA376F55F9D8A8254811E72C5F182031F
            364C2F4A1277B2FEBF3EFDBB3EE3D5BB13492E1DA659362F1FBD05997612D96D
            E57180250C33B906180C6D2D4D450A4831808AAA9242177E13121D8762E38523
            0A770E83A90C4CB472B36D324B09241619723E7C127696C921C70AAB89085CE0
            53523125B2C68239E35181D1958701780ACAB94283E5C656476DA31474FF0087
            FEADBADFF2D55BFAFEBFAD4740AD858BE5F324724A1652A5D08DC490AD8F9D39
            21500F33A6FE28B783CB9236546DAA5579899091F201CAA295C058CE3A1F9D48
            C2E4247279D1CCCAC260C482AC06E71B4825D554FDEF2C290CA0A9DE01FBA291
            614927D8151D831570557737CC15BE5D99E559998E00FDF1E704329FD7FC3747
            6DBFAD0D7FAFEBE406391ED981DC5644F983AB28C94033F702FDE76C82A7392C
            71B368F9CFF6A9F89ADE23F10FF64DAC8E2D345918C92A178035D670FB892C3F
            75B94649182180201535EB9F1AFE210F875E056BC84C4DA8DF031586E09212EC
            1B2E42003E50FBB392BBA6239CA9AF956CA27D4F5056865FDF4B2A6E904A1516
            4223918B3283D0C665E09460370CED2ABFBE7833C21EDF13FDAD895A4748F5F7
            BBAF4BF73F9BFC79E36FAB61A3926164B9A7F1F5B2DACFB5DFF990DC0C4B36D3
            B248D8A46C47CD6CDB1D40C60B290E1D8AA8673E5823A2BABDDB64FE5A99630C
            C04488C32BE5B482358D54E77079011B09CE30AF93BDACF95A53DB851A85D4D1
            6DF29A64B68D2221C85E0B498505D0CD83C81B9D768F9AA4C69A64690CDA9AB4
            8499A216F1E599818F6326FCEE3B1C8562CD80C187009FE9CE47FE5F77FC35B4
            D3A2EFFC7928BB5BAFAEBD3F1FF8267B2ACB148BC08F691BD15420134A55D811
            8565077004617236962ACAB2395F74EB23069374A8781D14CF0B8047F16E555D
            ABB4E368C46DB848D69BFB2E05321B9D4375BAA0DCD146E03A175CB6D9B27779
            AC000778DC590AA05DAED9A780C164D619530A316B1BB6D5665046D930DB5F21
            CA8DAC59401BCAB53E57BC7CBEFB7EBD3CF7EC5B8BBEBE9F2EBFA5AFABBA28AA
            AC6155D9A4F3BCC4F2FCC0CB228DBB803C8666DB18DC770223620BB00AAE07CB
            9BCE67915F01DDE30C24DDE5B6D6504E77E4384CE5D8CAEC5810185CFB369CAB
            709E76ADB8F9713B456C9B99823AB480F98720BE4EEE7006D07694A238B4D95B
            E5B8BA3279A8D88EDA25485CCED920897E4562FB725B70DA83763E463934B2F9
            FF009F9FF9EF7D8954DA7FF0DE5A7E4ADF3EA8A22430C201DB0FD9C45232A388
            FCA0A320A939D831E6221EA1CA3314230091FEC4AD22B2AF9215917FD5AA6D2F
            B30091B37053919DCBB43862A086B8174D31B3C771A87EE99D8ABDA46AC51CE1
            011E6A956CC7B431DA49D808DACAAD235BE9A1D57CFD464E7629486372770551
            B48949DC4E36B03B8872725181A4D5FE6F5EDBFE3BE9DAFAEDA0E16D55BEFF00
            EB7F5B25A5DE97A32C46DCB43B70215F2CE5367CB1382CA00561BF382540654D
            833B88CB0BBAF0B2AF9732CD820286FDEF9D22A2B00377DD223FEFE081970CB1
            86B58D3240CA66BC6DE0AF36912AB857959C81E68FDD9C3E76E02B2B32ED53B6
            9D29D3BE666B8D4940567F325B685946FDEAACC4C9B58852449DA40A0901B9A1
            C7A7F5FD7DFF0073D4E5EBE8F7FBBE4D6DF72BEE5189BED611A36597ED45D776
            E2B9DFE50C8E700EC2B237391C0773B7CB2B13799E53A348ACEA08C7CC59A404
            479550376142A84181F3E515942937E48F4D8A5C799AB20DFC2FD88349851221
            C12E49284484373B40F9B70272D822D34326EBABB31AE1A61E445F22F9DE6654
            F9A502B651700323156600904ABE5697F57B69B76EC96D7B07B2B7BAEDF7FA79
            FF005A7CA8C08AA6158BF7215D7CB70CAA13E729BB7018073B543A00AC442DF2
            95F90B42ACF0344A8ACDE57D9FE43FB9F94BA0500E5721F0541DE4AA3216664C
            5BB7934C102B35E6A1232A34B24A218C91843BB762624190F2DDC9CA646E2866
            16D60678D5AE35366DDE4BAB5BC4483E590FB9BCCC060A70C7A657E70C4B6E4E
            2ED77F2FC3FA76D35D6E29536D696DBCBFAFEADAF4CE8604F2A3D96F851E598C
            18F6AB0E482CE14B70862F99540611BAAE4302FF00A55FF04C3FDA7D3E2FFC2B
            FF00846EFEE3CED77C331C5197764DF7B68CA0C536D504EE01911C166230096E
            6BF382FF00468E06B5CA892C750459A29BCA2A76632EFB4AFDE0AFB0ED04A88C
            B6D901DF5D3FC03F8D77DF023E2DE8FE288D8AC96C7179000733C4F892780738
            0C0B1DBC970EE87EFB1AFA0E1FCD6780C6465F65EFD92FEBABFCAD6FA4E1BCE2
            59763233BFB8F47E9DFF001BBF979B3F67A8ACBF0678AAD3C6BE1BB3D52C6E23
            BAB4D4204BA8244390F1B8DCA7A0E3D3D40CF7AD4AFDE29D48CE2A51D99FD094
            EA4671538ECC28A28AA2C28A28A0028A28A0029B23948D982B395190A3196F61
            9E3F3A757827FC148BF6A31FB29FEC9FE26F1159DDC36FAF4911D3F47CB2EE17
            D20C464296058C79F34AE082B1907839A9A951422E72D96A7765997D6C762E9E
            0F0EAF39C9452F36EC7E597FC1657F6B66FDA3FF006AC9BC3DA55E35C786BE1F
            F9DA341E5C8FE5DD5E373772A6D66CFCD1B4402E4A8801019198AFC7904DE646
            9316F91B13119F964258C8AC557E6CB4AC36EDCFFABCAE4CBB5E4BB792E5DFFD
            648CCD1AB331064B80E494CB336195990302C4072E88589464665DC9FEB02343
            FBE81807321DA63F28FEF0173B1812BBF73162DB5496ED1FE638EC53AF5DD493
            DFFAF4FEAFAEE7FAC1C0FC2F4720C96865743ECC75F3968DB7EAEFF95AEC7431
            012C69B5B747E522FC8372925C9CB0EADF3B703CC0549EAACE5AE7865A4373E6
            C7B63F2ECAEC1919B30C65ADB1BF1D54280AFB5CE4C44762E168DE10E2455086
            3937ED21F1E62B2B6E62D21230EA318DC09607247DE8F4F4084CFE219E3F9E67
            097289CE58078DD86D72558B0025230010B86047DF7E5A6FDE4FD3FAFCFF001D
            CFA8ADF03F3FCBBFA3F95BA6E674B1ACBFEB048B1B177D8597746377CDF32E40
            F9B99005255E3C9CF1257D0FFB37FF00C137BC65FB417C376F1B5D6B1E15F077
            8567B96B78F51F105CB5A437D2B16DC23408488D9B805B059D4850EE1D8FCF10
            3BDCCF0C90B34B2CAB13C3B93A03BFE70148076314C0C9011D46407047DBBFF0
            53078F43FD89FF00659D1F4F544D166F0FC77AF12CA161F385A58004A65013FB
            C90E4A820B1E4E413E965B87A528D4AB595D41276F3BDADFD7FC13F39E3ECFB3
            0C2D4C1659964D42A6266E1CED5D4528B93B2BEEF6D764DE97D4F9A7F69DFD96
            7C5DFB21FC438340F175BDAF9B3C315E595FDB4A67B5D4225F2C2B21D81982BA
            B215C2B891906D270F5E6B092F1AA42DE63705199448B21C18812703EF2E4893
            1F38DAB80A5564FB83FE0A5D72DAD7EC35FB326AD7D70D36B6DA13C3E7492859
            A45FB35A14C9FBE7E608DC23172E4EE2CDB47887C04FD933C37F1C3C04FAD6A9
            F19BE1EF827FD2668E0B0D76F512EFE525C4C0C8C06C2A536F67D85BF78066B4
            C665FCB88F654168D26AF6DAC9DAFD7A2BAE9AE9AB7CBC23C78A7907F6967524
            A51A92A729462DA6E326AF657B5ED7B6CB4D575F0F60B243B90C2D0CDB23F3D8
            B8C068F6AB360F01D791C96F963539DCA91FD87E12FF008232F8F35E934DB7B8
            F16FC39D17C49AC5BC57963A35DEAC7FB49E360D893CA8C0603E790613E5C162
            1BAB57CB1F12FC290F80BE22EB7A4D9EB1A76BD069B7F3D945A9E9F73E7DADD9
            57802CB1B2E46D97728C90C4AE0ECCB482BED2FD833C4DE07FDA77F68BF03F8B
            3E2E7C50BB3F12344D4E2D3F47D097475B54BB10CBB6D91E5488C25BCC762106
            0C9E585E77026B2CC3D195474AB46F2D16AECBCF5EFD95B5F332F1273CCE30B9
            5C333C96AF2528C64E4D539549EA9382492B24F5E76ED6D2FD4F983C3FFB1CF8
            F3C5FF00B45C9F0AECF46FF8AA6D6736F340DB5A2B15446C48F2200040125017
            6E73BC0DBF3E0FA7FC70FF00825578EFE17FC2DF10F8AB4FD7BC17E38B3F0DC9
            B35C8344D51AE2E34D6F9637DE8C8AFBE3490A3118700107A2B27D61FB31B789
            61FDBDFF0069FF0010F89ACACACFC75A7E86F2DA8D3A43711C5198736A126C66
            4CC70DA2E7E57662A708DF2D78A7FC10FEFBFB6BC79F15B48B89A1B9D1F52F08
            B4BA997CC81D8CA50338C10CC565704775948380E4D7A4B2DC3A9AA4E2DB9CA5
            14DE964B6F57F2F2E87E735BC4AE22AF4E78EC354846385A746738A8F32A8E76
            E6B3BE8AD651B5F5B37A1E2BFB307FC13FBC59FB4DF85B52F1747A8787FC21E1
            1D3A6789F5CD76E5AD2DF7FCCA2357518184639650006660A59CB6EE7BF6B0FD
            8E7C61FB1AF89F49D3BC4834DBA8756816E746D434E93CEB4D4A2880470A5406
            DC8EDC2050ABE7EE00FC8F5F477ED90C9E15FF008242FC09D3EC76D9DADE6A52
            DCDD849084123413B10E64C16C34923091D08DC1C80BF2931FED4F1CDE28FF00
            823A7C05BCBE8E39354B7D6E7B38647839166AD7A89DB76C616B6E09072FF2A9
            1B76671C465D8750953B7BD18A95EFDFA7A6BA3BED63D2CA7C42CEEBE3B0D985
            59C7EAD5B112A1ECB97DE4A2A4D4B9AF7726E3B34D6A97447C57A3AAC7A66A91
            C6A648C5B3881C0E25433C3B48050EE52DB7771F348C33C6C2D52393124455A5
            6DAA2621BAC800254923770DF32B37CCC55186242A5D2DE852ACF61A849C0B7B
            AB65998FCCFB14CD18001FF6612CC08E70CA4ED0115F3E4756B6692E36AC6CB2
            BC89BB6ED1B5656C6012BBB7A960D924A6EC303E62FCDCB5B2F2FD59FD111B73
            49BFEB4D2CBB2DFD6D65A2145A7950AC4CBB5623B19665DCA1D222CE4C6A4E49
            491D7602CD222A60ED064A7AC6D22280BE76D5DEC9F798B4924AEAE4AE572416
            0C4654E5D02B644748F0E5BCB97CB0C4B9963572DB4E09900C1242B484161CB6
            51B0182870AFE63491CDB5A49B7160A1848DE62A239395C972D1F2A9BB76E1F2
            964549239DF5FE9FE5E77F35A1AAF892FEBF5F96DDD771ABCC23122B2970ACEB
            1F4F3D304ED5CA03B87DDDDC8C2ED2EC8CDF687FC133BF68C7BAD3F50F02EA77
            3B64B1492EB4CDB2FCCD16FDB2C5C6D62124DCA8842F1BC829B7E5F8C6DCAC13
            5BB2B43B61D8BBF710AA98CA38F2F0BF70B28C360E70AAA32A343C0DE32D47E1
            BF8C749D734B99AC751D1592E2DBCC3B961923DA4A30511FDEDAC9B533959173
            85F2D07CAF1970CD0CF32BA981AAAF75EEBECFFCBADADF2D8F99E2AC869E7196
            CF0AD7BDBC7C9ADBCEEF6B767DB7FD8C89365D010A2AFCFE5A2236C8D9977E07
            CBC13FBB41D58E011B14135194655181B7795C33C4179DE0A96051413B8838DC
            0E64900E545727F03BE2A58FC67F871A6EB561B9639A0C4917CAD2C0626DAC84
            6C24B46CC4038DAC6352B90C4D75B1C2D14AAB1AC71CAB8384CFCA372AE0ED40
            76F6EA372C4BDB711FE71E6B9657CBF1953058856941B4FE4F7B5BFAB791FC75
            88C354C3D6951AAAD28BB35E6852FE44A646FDD80A150CACC9BD00675CB920FF
            000824302CBF3E4156CD4989A3902A8B83B4E0066762EA19C81CAA8CE14004B0
            077FCC586DDD1428BF2155F2FCCDBE5EC0AA30DB0AEC281B76D54E79C7CBC8D9
            8C24453C9FB43EDF2F76E24C7F2C7F3AB373820618B6772AB1DBCE36EEAF3ECF
            FAF2FEBA6BD598587188945C2CA238C292123618015549452014F95CF0AD9057
            8C92C2894B5CC4CAC449B77060844847DF566DBB5CAE7F79804FF0AAFF001114
            EB0D365BA9EDE3B781A69E5658E28E3412316051027C919F9B7246303A65B1C2
            2D759E1EF805E30D72C63921F0FDFAC28EA8BF69296646D20E7CB91BFBAA98C2
            0E49C6D25B6FB194F0EE6999CB932CC354AED7FCFB84A6FD6D052D97F9A673E2
            31987C3ABE22A463EAD2FCEC720CC64900F32312C8BB1F127DD24941921863E7
            77F94B9C6CF972724247721F0D1BAAF98DBFEF8FBCC508CE25F9B1BA21F45207
            0CA2BD5345FD917C5971A4DBCD24DA5D9C85771B49EE245689BFBBFBADE817E5
            4C63760020E4B1A92EBF63EF1547652FFA669370BE5B2794B72ECEEA03E07CF1
            6D24E54738E47CCCC3AFDA47C1AE3774FDB2CB2AD9ABEB1D6D6BEA9FBD7F26AF
            7D2C99E53E28CA94B97DBC7B6FA7F5E7B1E57165CA21591B738DAA64DFCABA03
            FC4F92BF28271C32B9DCBB81A8ED86C5878DBE5844E38D9930F07A6DCFF77E4C
            FF0071BBF6FAAFECEBE34D3ED1EE66D0E5655756716D3C5349CE1090A987270C
            46E5390114E0E5857257FA55D6877EB6D79673E9F7306C568A64685A3CF9276E
            D6C6DC8C6155F07D1CE40F8DCDF86738CAACB34C255A3CDB7B4A7285EF7B5B9A
            2AFB3DBCFCCF4B0B8FC3623F815233EFCB24FB766565DD0AC7B964C6F590A952
            32F856230E1537170982003966185219A9B21F36D36EE59E3C32AB0C49E63792
            40C6E673CA82D80A49122E41F9F289B5600AA235955000495561FBA550A06410
            7749C01E5E327EEE7E675D4A2669B0EB21742BF290DBC159582F0A33F29076E1
            F823E53F78F8CFBFF5FE5F9743B75E8492C8CD21F9BCCFDE6D019C957612395C
            70FC82A01C10402490BB5408AE3F7362CA72B6E150664FDDC698185625951531
            98C9F9900218E46D62659E5FB35D6E2FE536F705E452AB81B883D46E50AFB882
            DD10E141CEDF2BFDA6FE212F84FC2916916934315F6B45636C3AC6F1DB158C30
            250A85DCCA067952320118C0F5F87F27AB9A63A9E0E82D64FF005D5FF57F2678
            1C459ED0C9F2FA98FAEECA2AEBCDF97FC0FB8F21F8EDF1124F89BE3C9BCA676B
            1B6CC3610C924AA6752EC1A450C09CB49F2E1795DC800E315CCE8CED3DD33C5B
            9A492D6764748F0C375ABB02067E4566652149E7CB1F701E6AA49E5BAB32848F
            224976C6202C1597A85C3A90F2AA82AA72028DA4C7B5ED787E169676DABF2FD9
            2E3795DBE5FF00C7BB2336F0C5507C9180DB8EEF998B60C66BFBB321CA68E5B8
            4A783A2BDD8AB795ED7FC7F27AD8FF003978833CAD9BE3EA636B3D66DBF24B5D
            3BE8BA6FAEB6D4D6F867F0F6FBE2DFC43D3BC3BA5DC59C37DAB3CB15A49772CC
            23508495DCC14B15FBEE005541BC12415007B827FC1313C677BA8B69F1F8A3C0
            51EA4DE6462D935290CC872AEE36080B0202B92A318DCE71F361BE7AF0FEBFA9
            7853C4106A9A55F5C69FAA59933437B02BA5C24815E67915C7CF960CCA71BF02
            463D179FA77F63A8AE3E16FC39F889F1AB5B59A6BDB4B77B2D2DEF43B7DA6F66
            9086255BE7397F2D598336499BE665048FB3C8E8E12BD4F675A0E4F56DA76B25
            F9BEC8E9C868E12B4FD9D6A6DBDEF7B5924AFDB5B7DFF82F37F879FB1878B3E2
            178BBC5B616971A369367E0F9EE6CAEF55B99DE0B082589B71547DA785688609
            E154AB10ACE2A8FED01FB276BBFB3EDA69BA95DCFA5EB5E1FD5644361A8E9F2F
            9B6B3A828C91B336E2088E305320960C7E62032D7AD49AA49FF0EB9B9BE86432
            49E21F1297D46E15F0F29F3C9F98800963E547C1272B9E8080D7BE14411F8BBF
            E09AD636BAA797716B65E2DB2B7B769E470B14325D5B876CAEE039B8B800E5B7
            7214166E3D8FEC6C14E3ECA29DE51724FA2D745F9EF6D6EFC8F6A391E0276A50
            8BE6945C93ECAFA2B5ADADBBB5ADEDB9C2F823FE09BFE34F13784F4ABCBED53C
            2FE1DBCD6E212E9DA66AD70D1DD4FB511D0321560555133D77E0306DB8F2EBC5
            FE247C3DD5FE1978AB51F0F6B56725B5F69723DACF190DB57746E570543758F6
            05638254804796B81F447FC145F5EBEB3FDB2B455B394413E8B65602D1910EE0
            C1DA645C060CC77C849D83760310B9EB4FFE0A9D656EFF00B4E696D1AACD35D6
            8B66F74AE04997F3248CABEE618C4239395E4741BAB9B34CAF0D4E8D5F65177A
            6D26FBE8EEFC9FE1AF4DDF166793E129D0A8A945A95369377BA77DFF002E9F86
            B7F9B41325C6D21557CCCF979DBB1CF9A59481F71F6BE7683C319B632B215597
            44D22EFC41796967676B757D757412DD6DE08497B8601A44C291962CEFBB0148
            5631E5646C93EBBE0AFD95743F177802CF5697E2BF80AC65BED3A299AC6E2F11
            260182CC62906E0508705B006E0CD8F9B249F27D135CBAF0D7886D754D3EE9AD
            6FED65135BDD42C866570F18C8601B909E6361416CB36411B957E76AE0E74795
            D5F865DAD7B6BD16B7D7FCF53E62A60A74946A555A4BB5BAFA3FD7AEF6DBD43E
            2AFEC51E3AF82FF092DBC5FE21874DB6B3965446B41745AEB74BB1B2C3618BEF
            206059A4C29DA7715014F823FB1A7893E357842F3C4DFDA1A3F87FC3F673343F
            DABAC5C3430C8F962D226158EFDC10B39623394CB7CEA3D53E22F89350F1D7FC
            12E346D435AD42F354BEBAF10387BABA7F35C1F32E542EE719C051DB2C7D9028
            AAFF00B56DCBD8FEC27F076C6CC3C76FA8C7F6FB8548C0696E9A10C18EEC1FBF
            34DF310724B9C7014FD47F64E0E2FDA46EE2A1CD6BEEEF6E9B77F3EE7D84B27C
            0C66ABB8BE450E7B3EBADADB7E5F2EEFC6FE37FECB5E2AFD9F7C6363A3EB3636
            D75FDACE9F61974E412A6A6A1C3FC99C1DF9915190A91872C013B437A541FF00
            04C9F1B5E694B0C9AF785E4F107D996FFF00B1A4D40B5DCA8CACAE1B080FEF03
            95043E3E500B13923D93C1DA45AF8AFE16FECCB36B6AC6F2D757786DDD9181F2
            C42ED090A532559ADEDD7760F38232B9DBE5FE23D6AFE5FF0082AB35C2DDCFE7
            7FC24B1C0ABBCA810E162619552154444E71D4E0E0EE761BAC9F07492AD34DC6
            4E365B5B9926F5EEBF3D6C91B54C8F034A3EDA716D4B9525DB99277F36B557B2
            F4B1E39F08FF0066EF177C7AF1E5FF0086B4CB548F50D3379D4E4D41CC3158C8
            AF36F3271F78EE6C2800AB64AA3619874BF1AFF627F117C1BF050F152EADA0F8
            97C3AB722D65BED22EDE54B72AEC8413B4FCC247910382E57728DA8E2BE9EF16
            DADBF8674BFDAA2FB4D8E2B6B9628931E8CA1ACE3965246EE1834B349BB20609
            203019AF23FD8C5E7BEFD8F7E385A6A1E72E989A6FDA60594151E798A475C720
            8CF9701E707E5230D804AFEC1C2D37F5792779A93BF6B74B75DBAF75B9553877
            0745AC34936E5CCE2FB5AFA5BE5ADFBEDDFE611B17C27691B22CFF00E9324B2A
            8C6D63E44287765C8DC5A40A00C6DDF8050AE0D6C79076EE7791A42ADE57C9E6
            3F70143203BD0C800FBCBF6858C8E63616E59377866CDE32CD22DC4E89F3FEE6
            20042AA0B36E5E5C46986057F7873B5415154B792F3793B8ED52111549657431
            AC49B482C4931B8D8C5C9050138DB28F87A9752B7F5F9FDEFAEBA9F0359352FC
            FD6FF8FEBE87DF9FF049DFDA1BFB63C2F7DE01BEBA5924D17CCD434F7405FCFB
            77725D4B141928CE98C649F35400363D7DA55F8BBF02BE2ACFF057E2CE87E28B
            292493FB16E184C2261279B6EF1E241BC8057318762ED8F9D87C800F97F64BC3
            3E21B5F14E8567A859DC43756F7D025CC3244729244E328CB9EAA4746E87A8AF
            D8B82735FAC617EAF37EF43F2E9F71FB5F01E6FF0059C1FD5EA3F7A1A6FD3A75
            E9F7799A1451457DB1F76145145001451450015F8E1FF05F2FDA64FC51F8F7A5
            7C3DD3666B8D37C0907DAAF444AD22BDF4F119551A2E4164802A91F2B6657195
            2463F5B3E2DFC48D2BE127C37D73C49AD49147A5E87A7DC6A1765D9547931465
            DFEF119CE02F7E597D6BF9BAF8ADF112FBE357C4FD77C4DAD4935E6A5AF6A735
            F5D16264F96572ED1A02ECCF841B44679088D80CA7649F3FC458AF6586F669D9
            CBF23FA53E8D1C25FDA1C412CD6AC6F0C3ABAFF13D17DCBBF75A3E9CFA15332B
            6E50635127C928900CC6515D58105B036307271B5B2DB00411C723B595ADC363
            1B161C08C1D89205523AED1BBE4661C03878D83459DF4E52B7512F99FBCF390C
            B26D1BB77CE503AF3960AA1DD58E0C9183F2B9DC508E452CB2336DDF995C24D9
            DAAD8320F909DAB23B212B8DC09246F006CF85E6B3D3F0F277FCFF000F33FD05
            4AD6B6FAFF005E56DBB7DC3A73FBEBC863915A36690125836E00CF110C1F0BC6
            582AEDF9C8080948CB55EF0E3AADF48EAB1B2436F7814962D1B6D8C3E39C9667
            D9239F9BE61F3B91C6DA22491E2F319BCE58C07408C154E0B857C9188D0B2440
            6E1C79795E54B54FA5DEBE8DAC5BCEBF7ADA678776E09E6AEF8C3A9040655F2D
            F6E090079AEA0A0F2B711D1DDF4FD3FAFC7E444A29D36BEEFD7EED3B25D74D48
            25B668D8C7B24918A85DAC03199595F3D50871B8956918316562141675CFD79F
            0B7F6E1F853F123F667F09FC36F8E1E14F166B90F816E449A16A1A15CA9B8309
            C936EC3E5C068B6EE55DF958783E62EEAF93ED6E34B486355D32F1A4DAADB16F
            B7B3952DB881E493943E60DAEA64F9013BDF72528BCD323863DB6778C234C845
            9D5D64531EF4C614970EC59536B6DDC1881BC0DBD985C54B0F26E0D6AACF4DD7
            9E9FE5AF5E87CCF1370BE133CA30A38B524E9CB9A128CB965196D7525B5D369E
            F7BBEE7B3FEDDFFB66DAFED6BE25F0EC7A0E8ABE17F03F82748FECCD0F4F694F
            EEA02A864762990A1A348D3E42C635DAFF00312EC7C2EE3CC677DD234770D208
            C3EC10AABFEF98EE64C64AE4B30046033BAB16DBB7425BBD3D6768FECFA87986
            5F30335C0E724F96E47924166922CE5140250E3E565CC4D77A4C314729B3BE5D
            A920FF008FE462A308E1490A005F28803952B93F3042C6B3AD88955A9ED26D5F
            E7D36E9FD2B6C766439161328C0C30182A7EE476BBBB6DEADB6DDDB7BF57AEEF
            5BD6F94CDE6AF9F143319A7430B14700B055E8A70CBB58F01B0B956003807ECC
            F877FB46FEC93E04F12E93E2FB5F86FF00102C7C45E1F961BDB6D261B8496C45
            C288E48E540665DCABB4B646D1F28F9382ADF1FBCBA65B4E59AC6F15ADDDC319
            2E976855886036E894797B7E4DA429FBEFCAEEC3ED9F4D1710471D95F3342502
            A1B800B6C2594C89E56FEAC8E5492C0B06F977965AC2E2BEAE9B859DFBABEDE7
            6F5FC2E79DC4FC2B433BA70A55EA54A6A375FBB9F22927BA924ECF5D3CAED2B3
            6EFF004AF80BFE0A77ACF867F6EFF117C60D53455B8D3FC541B46D4F44676663
            603CB8E3892525B32A224632CA4334A57E42582F55AC7EDEDF087E05FC29F1DE
            97F037C13E32D1BC4BF106230DCEA1ACF93E569F6EEAEB225B44B2B48CC11E75
            8FF87241DCFB573F1BC37DA6369EAB0D9EA0D32C3B63496F23FE28D9BCAC98CA
            EE3247F361554046270BB45585BFD262BBF312D6F76FDA0C9B85E0C95578DD73
            FBA6662F9C052339910A8E413D51CDABC6EAE9B6DBBB5AABEF6D34B9F3988F09
            F22A93A7285394630518B8C66D426A0EF1538A7AF2EAFCD5EEED647D37FB3E7E
            DABF0EE5FD96A0F83BF18BC37E23D5FC33A0DDFF006A787F52D02E2317960F99
            8B63CCDA0905E41BFE74D920523E559179AFDB8BF6CED23F684D17C21E08F067
            872FBC39F0E7C0B0347A7585D4C1EEAF0FEEE3324CA0BA17550CA00DCCF894E4
            B3155F04B4BDD3638E111D8DDB4BB21DA89728E256511B2F3F71C86981DE782D
            B7E6E804B69A96930CF1C915ADEC96FE7A85297A0F9C17322B1FDDA8E2308790
            5CE59806010999E6756547D9392B5AD7B34ECAD657EDFD7A7661BC36C9B0B99F
            F69D28494949CD439BDC536ACE4A1B5DABDDF5BDD2EEDD1B71D3B527663232C1
            1AC922BE4B3092220EFC8C63CCC6436DDCE1F962E959F2A2A8685B6AED2606C0
            1198DF69DB862BB576F94D963CB1DAD8D9B10DD3A8C569A64767636BF67C35BC
            724D7171BD9F81B406454558C1477EF90C02B12551283B2C762A15976AFCB1C5
            3484E57044592A7002E5FA32A1D8D82705C79F2DFDD7F77ADFFCADF9E87E8505
            273936B47A5BF4BDFAD9BFF83A8EB85FB7C723332EEBADC8C10F9793249B0E78
            DD818FBAD860C02A92E36ABC85B8BD7C8491A4919C81F32346E58B272DF307D9
            180B93960C01644C297C1A3927691A6DD1ACE56492356678F6B44BC9DBBFE739
            20E36EE5190BCBAC9FE8F22A267F76E45B8DAD2A09A39B0473C313D481C332E7
            30B26E39F4FEB4FEBAFF0093B3A8CAFADF4E9FD5F6FD757D6F1395B884F9DFEA
            E4890CAC4821B91E611925B791943B70EA1B2727CB5594331BA40CCCB34921F3
            363306DECC7CDD98F9170088D8AB3152400CD2637360912D0C4AA235F2645018
            B18D942BC809200F94F961C61002140F951372A444FD9EC595A48D5A28821122
            958FE4432AABECC8DABB37320F9424A3CB6C36D737D17E5F2FF87D4AE8BE56FB
            BF3F979F549FD2BFF04DFF00DA1FFE15FF008F7FE115D46485745F1000F6F114
            558EDEF0A8419553801E36584464E329B433336EAFD058DE392DBF85D194CB22
            9750186159B237AAF200272A07EF972065C1FC6E4B936DA82C90DC490490DCC7
            2432A39F3A0D81D8BEECE7CC8CA7CCDB81250825C811D7EA77FC13F3E25DFF00
            ED87F0FB4FB7B3589B5EB526DF5240CCB1D848AAE1E46E010996CEE50877164C
            93B50FF2EF8E1E1D57C5D7A799E5749CEA4DA8B8C55DB6F4564B76DE9E5BF73F
            9E3C60E1D86165FDB94ED183F8DF44F7BDFB74BBDDFA9E9F67A4DCF886FD6CEC
            EDE4BBBABA0D188E143234AC04DB801F3640C13B497DA3AAAE09AF6DF867FB23
            35C491DFF8A6468648E52C9656CE37300E0A99250491D645DA87EEBE7232547A
            7FC32F83DA4FC30B62D6B1FDA3529A311DCDF48A04930DC5B681D15413C28EC0
            64B119AEAEBF48F0BFE8C380C042198F165AB57DD524FF00750DADCD6B73C975
            57F66AED5A6AD23F8CB3EE3DAD5A4E8E5DEEC3F9BED3F4ECBB75EBA3D0CBF0C7
            82B49F065B795A5E9F6B640C6913BC69FBC955010BBDFEF39196E58939627392
            6B528A2BFABB0983A185A31C3E160A108ED18A492F44AC97C8FCF6A559D4939D
            46DB7D5EAC28A28AE8330AABABE8765AFDB2C37F676B7D0AB6F097112C8A1B04
            670C08CE09E7DEAD5158D7C3D2AF4DD2AD1528BDD349A7EA9E8CA8CA517CD176
            678BF8F7F63EB1BD5F33C3778DA6E060DA5C4B2BC2D9C024386DEA7064249DE5
            98A9E36D7846BDE1DD53C2DA89B3D4AD6EACEEB631314DE642CFCB2128559B72
            072C372E536B290C768CFDBF587E3BF873A4FC47D3E3B7D52DDA4FB396682547
            29242CCA5490475EB9DAD952554907031FCC3E277D19F28CDE94F1BC32A385C4
            EFCBAAA53F2B2BFB376DB9172DD6B1D5B3EF722E3BC4E1DAA58F6EA43BFDA5F3
            EBF377F3E87C3FAFF882DBC29A2DE6A178EF0DA5AC6649182085990239C9F9A3
            2CE59C7B069140C10CC3E45F1F78CAE3C75E34BCD62F5DD5667256376CAC1010
            0286071942A57E62AC0AAB8C1C153F417FC1427C33AD7C1CD5ECFC2325BDC49A
            6EA8A6EE0D42283CB8EFB6A88D625DBC6E0E23DD1FF79E2FBAA55CFCC8E372C8
            A0C72798B34A9E515DAE0B1DC3A6181400070AB90429C2E7CAFC97C31F0FF159
            23AB5F35A6E15EEE1CAF78A5F369DF5B3574F46AEB7FC83C74E3B8E6389864F8
            497EEA36726BED37ADBEEB68D6FBF64B6F1EC2A8FF00DF48C8C90C408D1A424F
            03E655D8CCA47DCDCCEA096367C3E16F35586390A33496B32112305720C12953
            83B7B16DDF74312876FC8CD5046D1C97EBBA453279AACCFD64C796B23383C372
            CAAD90C492FCC8BBCBD1A5DFCDA72C324219E65B65223424AB928EC01C151F36
            66538C1CC91BA160FCFECB4EEDA7D6DF77E3D7B9FCE7196BCD2ED7FBFD6FA7AF
            6BAD48E341244DF2A2ACEC87F78A8B83CCA58829B780F229F97680872563386F
            62F8D7FB45E8FE29FD9CFC0DF0FBC33A7EAB67A5F87D4DDEA8F731247F699CA3
            6E68CA338032B75D7A1E4E15091E533C9A4CF24DE5D8C922B6F4C8BA4DA8482C
            30C212C06D847CCF823CA61CFCC59D25F69FE63C8B6B7CD22AC8E8AB7684A70E
            C4E3CADDBF0B1B03C920A863B559475E1B193A2A71835692D5F5B68B7E9E6FD1
            DEC7A186C654C3F3C28FDA567B5EDBD93BFE1D6DB9ED1FB377ED39E1FF0002FC
            2AF117807C7BA3EA1ADF8475CB97B9F374D64FB4C1387527037E36A98811B718
            60D8565906D4FDA13F6A3D0FC55F09742F877F0DF45D4B47F0CE9330BF91EFA5
            2D777570FBD938476054B38C1CE0BCB163CB046EF189E4B18AE26D905F7991F9
            823C5CC7832AC78FF9E3C00BBB04E761957705DF9573DDE9B64CB2476D72B042
            0CB130BA4064C212A1818B0A6456F9867E7556277A953276D3CEF12A92A09AD1
            593B6B67D1E9B6FD35D0EEA79F62550541356B5AF6D52DF47DB6F3F5D51F505C
            FED9DF0A7E26EA9E18F15F8F7C2BE249BC5DE19B78CFDA34D2AB657C2365685C
            AC9221F2C3481C2E01CB8462C2BC17F686F8CF79FB427C57D4BC45A95ADADA2E
            A0E121B10CCD15BC70AB4020C81BB760E0E13382CE0C78AE5C269F6314904769
            A9FEECAC298BA556DCB0216017CAF94BA2AAB1C6E03EF6CCBE24867B149D76DB
            DF4CDE61054DCC2AB2E625C8FF005430B86DA01DBE5E4644476D462B3AAF89A3
            ECA6D5ADABB5AF6EAFAFAB7F3F3CF1B9D6271343D8D4B59EF64AEEDB5DF5B5FE
            FD7B997705AF6C99AE3CB2B3060659885DC1954B60824AAAAC4FB506D00EE5C9
            2AC2B4B457B56F14DAB6A90DC49A735D467508A00E26084C6AE8842E038DD244
            0121732852AA37056C13E9EC6DD960D43F7904623732C4D952855464C3F30F2D
            09DA324F2A10B34AA2379B4D6B5C35ADE346F045B835E46555479A0E5BCAE763
            09406C90410AC406641E6276968F4F9E8FFAFCECF73C98CB5E676BFF00C377FD
            77DBB9F516A3FB56FC11D47F678B6F876741F885FD830486F61212D44F213BDD
            9B76FE54E5893D00419C04615CDFC35FDA77C1FA9FC01B7F87BF13F40F106A1A
            6E857E6EB4DBCD224F2EE212BE633248252A3E5579133CA9552000630F5E0B75
            7563B2F37D8DFCD249E6B4EAF743765FE79142888A16DC0AE3A80C0F040DA489
            A64576CAB6B732346CCAACB711C7E6483F7872CB0865521DFE618280A821032D
            7B7FEB157528C95AC95AD6BDD6964F6BFE0FCAECF7BFD64C526A6B95595B6566
            AFF8F93D7BE9D3D9FE3C7ED870F8ABC51E088FC11A37F61F877E1B8867D2ED2F
            1CEFB8910C259A71BC8DA42AAAE492CA4E1CB48AB5E8CFFB687C23B8F89D0FC4
            C97C17E286F8810DBEC5433C6DA7BDC88842AC5B7EE6CED2A1C260821BCB66C5
            7CA56D71A6C6F0B2D9DE4AA64420A5E22B1E0B020796AA08100914820B96C13C
            B80D88E9EF1B6EB7BD25832BE278802A463A342A0288C33A870A8A15C9D8431A
            21C41898C9CA6D3BDBA5D2E8ADDBCBFC8A8F12E2D4DCDD9A7AD9A4D2B5926977
            4BFA5647B57C0BFDB29BC33F10FC717BE32D2EE35EF0FF00C445960D6AD2C995
            668CC990BE5067DCDFEB18040CADB70776508AD0F88DFB4EF817C35F01352F02
            FC2DF0FEA96163E26B8373AAEA3AACA8D31406393CB8DA377070A46470555589
            04B3B2F82C977A63C65A5B7BC8E100A6C17430B1F39405E10D9752E46E20BAA1
            52C30504CB3D9FDA56492C6E3CC1246C49BC0A11F6C72162C211850B975C9D80
            190A850A36CC788314A9F249A7BF4D75DD27D9DFCFCB5DF38F1262E3071BABEB
            AD93693DECDF74FEF44379FE8FE1BB6959A4F356E25850DDA989F22085771C96
            0788F6B6E0CB87653B47C9557632131C6D249E53F96576B139695A31180C5C82
            C2365653BB76D4F96401A4692E6FC4F0C11C70C51C36B1E121E558C63CB241E3
            7316013730085B7919DA85D6278C2BED779245C4885B96063F2A25E3A00B8C1C
            C61B28EDC15640DE254D5A6F5FEB5D3F47FA33C1A9BDBCBEFEBF3FF83B2E8498
            9F0A76DCF12329DE36B223C7F3025B214AA282FB8ED0A1BCC214D7E947FC12B3
            E36BFC42F8272786EF2E249351F08CC2D8AB46CA4DBB06F2B208CA95292A119F
            97CA4C9CB73F9B1B564D9BD8476ECAC242AC36460B0691C000AF55870D960597
            2A095D83DCBFE09DBF181BE14FED27A3C1752436F67E260BA3DC44D13058A493
            E78D5405214A4E546092144846C52A76FD0F0AE60F098E8DDFBADDBEFF00EAFF
            003BB67D3709E66F079945B7A4B47F3FC74DBCDF767EAE514D89FCC8D5B9E477
            52BFA1A757EF0B5573FA1028A28A0028A28A00F877FE0BD1F1F1BE16FEC7A7C3
            7677821D4BC6B7F15A1442CB28B48D6496E1B2180DA42246D905409083F7857E
            2D5CA331757131380ADE6C406DDD1BA80C3E6C97DD8446CE0C9CE7E5897EE4FF
            0082F3FC6693E227ED91A4F8560B863A6F8234E8A2D8D260C57378F14D338CE0
            862A6D9369618D806D620237C316416716E36C52472052DBA46E7CD953721DC4
            11B8B44E71B589218AE1BCA6F80E20C473E2DC16D1B7F5F7FF0096DBFF00A43F
            475E1B8E59C270C4CE369576E6FBB4F45FF92A5E97B6AC7B233F98D22CCCAC54
            746560C91A6EDC73B8B2EDC83CBB10843288CBD327B8768D9E4F2FCCDAC1C074
            F2E4670CE17231F30F3010E71C26ECC6AF976A14F2D5BF772E5236421B607121
            0EAC0E30ADB80F986C5254904140B0C91C8F088DD18C8C2511068E01CB226231
            B430015DA5048CA83924031B194787B6FF00D6DFA6BF77CBF79D5EFDD7DEBF57
            B7977B05D28791BCDFDE7952901E47019F0AC1B7138218FCBB558A85E1F04464
            942A093E6B47FE9840322AB299017563B493B3E56E30FD79DE09243B4C6BE4B0
            1B4C7247E4A60AB233388F71DDC2ED70A0A92A5084C6D18DA56EE6F96F24DC7E
            E48652E7CC6DBB9C286CF2BB406237851852082577A1CADD92DFFAFC3F0FD25B
            49597A795F7BFCFE77B75BA0B990C2256B85C1CBC8EB244427F0E57E6C655A36
            CB06C06037394DA4B39E2293CD0F9972245EAEC1D9C948F025C70D92830CDC30
            C000AE44ACE743677A4A6E568DE7811DF7A8561E631276307DD82B27525F7121
            42FCD1D8F0D8D3ED3C45671EA96F746C56788CF6D0CB1C534B0A911901305564
            38DAAE136E470762AD3A714DFF005DFD3B7F5DE6ACED16E2B5B3D34BEBD17E69
            77D2FAD8F73F8EDFB1F699F0E7F657F0F78F749D52FAE7589ADECA5D77479963
            5FECBFED1B799EDCA95D84A37945413B5B6BC232A4935D4FC42FD81F4CD7AEF5
            2D4FC23E21D27C37A2E97E0AD2BC4D2C5AE6AB6F1CE66BF0008FCD5288A80BB6
            D76F977431800B329AD6F16FFC14B347F8A373F11343F10786F50B8F0478E349
            B2D334AB0B27D3AD6FB4CF24218E59AEE384492EC2C8B0869245DAFB0AB70E32
            F58FDB93C0DE285D5B4DD47C29E306F0CF893C11A7784EF041A9C02F81B0B957
            85D0BA08B7BB0D8F194E180C80596BE8B9B2FDA2D5B45DB549EBD6D77BEAAFBF
            63F00A75B8F15A53A524D3934EF192E59383E56AF1BB8AE78AD34B5AFADCF2BD
            67F631F1D683F0C66F135C59692DF64D321F135D696BAA4526AD63A7CF224893
            C96FF2B468F3491B64F96F868D88DAA333FC31FD893C5DF193E1BDA789B4BB9F
            0B7F62EA53DD594325D6B36F6F24B346CF218FCA906E3214DB2283B88C176C83
            BDFB5F1DFEDBDA1F89BC31E2AD4B4FF0FEA569E3CF16F856DFC27AA4F3EA30C9
            A63C3018237991228D65491D42020E228C303F38638E16EFE34E8137EC7F6FF0
            E8E95AC47ABC3E237F10A6A4F3C7159BB34696DB7CB2A1B6FD9C07E58B165723
            382A39274F03197BBAAB3EFBDF4E9BD9F9EB677EA7D3E1732E31AD846EA52519
            BA91FB29F2C396F276E7D527A277BDBA1D6F8F7F621D52F3C516B17875ADF4FD
            27FE115D2B5FD4B53D535CB76D3E337785478AE22C0C4CFE5AA960643B091B58
            8618567FB08F8FAE6DB509997C37A4B69777756966B7BABC16FF00DA53D9C6CD
            3C768065E68E2467FB8C13EFAEE52703D4FC3BFF000508F07F873C4DA56A969A
            2F8FB4BBCD07C23A67853ED76BA9DA4B70B05A23712C0EBE4489228C0F3495CA
            8D8577306E33E2D7ED57E02F8EBE0B7D2FC47E07D43405F0E6A9AC6A5E1B8F42
            BD86DADED175068A5686E91A02152272B26F401B1B86D58F06B79D3CBDEBCDAF
            6BE8FE76FD3B3F4F23079A71CD39428D4A1EE5D5E564DABDF5B39EBAE97BDD2B
            ED64DF21E32FD8D7C69E08F87DA87886FADF4C8E3D1A2B6D4351D2D75681B55D
            2A0B87710CD3DBE0BA2BB48071B9995C17077BE3C95DCAB2A3322C8BBE076924
            F90FC8C0B00C0E42B0DC77EECB160C19D015FA53E257EDBFA378BFC29E32D434
            DF0B6ABA478E3C7FA1D8F86B5A77D4629B4BB486058B88A144DEB24A2144DB26
            4212A159C9007CD72CBFBA766B89B632B4719F337ED46DAEA89CFEF1CE02F967
            B850410C5A6F37194F0CA4950D7BEB7FD2DB6F6BF91F7FC178CCEF1342A4F3BA
            6A0EEB96DA7457DA4EFAB6AFA7E377246ACB37CABB5A170A81C37EE9891BB70D
            C5B76E4766F9886F91C38C191226923583CC5DDB1A105556511B2E4E07217264
            C48AEA480EA181233C33AE5A38972648638E49248BCC724C7082D9665EABB433
            162ADC7EEC03B936488E767CBAED96391A5F29E30305331CCA1097243B8550EC
            5B38DE1F7BA601E1B77FEBBFF5FE7AFD9737E9F27B7F4B7BF477D49512D6E313
            1897648E1B011537859379C91F28C1C8DC0E4492FCBB143227907E686452BBF6
            DACAF93F21556051F79C1521613B4B12C3397742A2458CB6EFDCB7EF1E468B7C
            6188FBBBD885C92C5B1BB612410777CE19A5A8DE68FECF24B19FDDC692ED1BD7
            2CACA4EECB1390C5C6E66257E4F33761B731BFAFCFE5F8FE3E5A15DBBF9DBBF9
            F57D7CFCAEDC81DE797E5654F3C8C32398DBFD2363E572AB820B31048552DB00
            C48C7637ED12081650AC19B75C23C67CB4032A4AE300951B5B3B0803CC46CB30
            332BA788A48F183BA6526193017E600B7CA3E7C950D172F9054601E41D836C9E
            59586EF2E7651E6A236E21CABA337CA769E9B703CC0E573939635D7AEFEBFF00
            0F7FEBC8DB55D3F2EDF3BBF3B6AEC6BF833C13AAFC41F1DE93E1AD16C1F52D5B
            58BE8F4FD32CB72C22E9A49D228A205C05552CCA8C1B6A2100FCA30D27EFFF00
            EC01FB11681FB0E7C08D3B41B2B7B7B8F14EA16B6D2F89F5857323EAB7A91056
            DAECAA45BA1DE228C2A85566620C8F23BFC53FF06F8FEC7DE77F6D7C6AD7B4E8
            71B9F4AF0C192DC6D66651F6CBD84BC67E4F98C114B14A787BD8DBAE07EA457D
            A70EE5AA9D3FACD4F8A5B792FF0083F91FC19F494F122A63F30FF55F052FDCD0
            6BDA34DFBF3DD45F46A9FCD735F76930A28A2BE98FE580A28A2800A28A2800A2
            8A2800A28A280391F8DFF047C3DFB427C3BBCF0CF896CFED36375878E44C09AC
            E600EC9A262080EB93D415605959591994FE467C62F831E22FD9FF00E264DE18
            F1259C96DA923ACD14A8CFE4EA81660F1CD0C87064DFEB9DE0865CAC8E621FB4
            35F297FC1563F6793F10BE1143E36D2ED5A4D67C1E1CDDF929992EB4F7560E0E
            1496F2646594163B523FB41C1DC55BE278D3238E2B0CF174D7BF4D5DFF00792D
            6CFD375F3EE7C2F1C6431C5E11E3292FDE5357D2DAC7769FA6EBE6BA9F9B514B
            B6CE3543B9638ADDA304EDDABB5447C654AE5A43F31D836CA0E3749B964688B1
            2B1B178DFCD48F6AFCD1F98D180C02EDC97258A80AACCA633B4A054558BF712C
            6B1AA8DB3AA2AA2842C4428781C6482538E5B2F8C4673E645188CC61495F252D
            D0336D56F94344588E70C03487E5236C84BAE5DF2CFF008D2EDBFE1FF0DA2F4D
            B4EA7E19E8FB7CFE5BFE4BBED61F24BBC6E65B67559B7AAAFCD1ED112C63076E
            36EEC2820229611907182AAB1C877AF98CDDF76C2D97548F259472DB4AB332E0
            B1D90B9F3805DC3332CD279FF2AB6E9A70ACEC707734817804907731C9DC5422
            92A14B3364433C727991A33347E54F965521D9994A90781FBCCA853CAAEF2AAC
            630EC46FA5B6FEADE96EB6FC6E837FCFF1F9FE22891AD766C3F65DB24522876F
            F567CB1105CEE03E4058921B2AADC6CC023DB7F679FD9A7C3FF167E1A5FEA971
            078D66BEB5D6974392DF41B08EF2789255568E67051595708C1CF040DA7E5C9A
            F119B72A4BB7E5FDCCA03484E09DACB86CE7801E40320B6C66FBA0C657D7BE12
            FC77F0AF81BE144FE1FD5EC3C5170D71AD47A9C773A66A96F68A4C7BC2206299
            5FF585DFEE60919DB8247A993C70EEB7FB4FC16FEBA3FC7AEF6D11EBE4AF0DED
            EF8BF86CF7D3A696D2EB5FEBB36E3F644D6354F1BF8834FD2EFB4096C74CD724
            F0F5BDDEA171F658754BAC844B652EFBDA4705BE45076B15DB818224B4FD9964
            D57C0FA0AC3F666F11EA1E22B9D1259E6D4AD7EC45E00ACB0777F398C7952728
            4CA00E250A7A6B9FDB7345F197887FB4B5EF0CCD1DCE9FE2C4F13E9B1586A704
            7187114282194C8AD956F26377908C92241852AC2A85D7ED1BE05F12690DA5EA
            9E1DF145D69F7DE2E9FC57710FDBE3DD3096360210447BB6908BB812597321DE
            3B7B3530F96DDF2CB7F3FF0080F6EFFF000C7BD2C3E54A4DC27BFF00C0E9F7F7
            7B3B26ECF9EB8FD8F7C61A4EB9676930D156E248EEA5B857D4E10B6D0D94EC93
            5C4C5D94AC41936F3BD7E7032092B5CFF88BE01EB9E1BF88FA4F852F25B0FB4F
            88204FB0DEA5C799677B05C0451324A08DEAECAC012549E85982035EB1E26FDB
            6341F1B7885B5DD4BC33ACC971AF787EE3C3FADC96D7EB0AC96ACDE746F080A5
            4344B8563DD000F9DE0D79FF008E7E38E99E25F89BE0FBD5D2EEECFC3DE0986C
            F4FB2B6FB444B7122C0FE6F992395F28C8FF00BD258AAA1E0E4ED6C618BC3E5B
            ABA73BEDF3D7D345AFFC13971785CB22AD4A77BECAFB7E1D9EBAEFEAAFD169BF
            B206A5A05DEB9FF095C76970B6FA3EA7710C3A6EB36B2CB05D5A2E5D25049E23
            59149FBCE8AA3EE8E0F2EDFB2DF8AAE342D33528FF00B1A69B5A166F0E990DF4
            32DE6DBA70B6DBA26218AB79A02825B98D4B291B88DDD13F68CF0B695F1D7C5D
            E32934BD77FB3FC4D6F78AB6F15EC31CD692DE2C8F27CFB586D1890A02038E17
            0CCAF8E974DFDB42D7C2DE09F0EE9767A1EB5AC5D68377A7BC235578A78AC3EC
            854CE6D6478CC88B379241DE4AC4A85540C6C5D551CADAB4A5DFCEE95B5DADE7
            EBD0DBEAF94CD3F7ED66FCDF4B3BD979DBF4DCE26F3F648F14DBF8821B217DE1
            FB88E68679EE6FE1D46396DB4DF2804BBFB44A5BE465696DC31607EF260B6191
            B8EF89BF0B752F855E255D2F565B558E6821BEB59EC26496DE5B793CA55B8824
            1F236FF979C28010AE47FABAF42D2FE3AF817C33E29D65AC7C35E2B6D2FC69A5
            DCDB6A36B3EA713CD179D2C2F11B6C264B2B7003972E1B3CE3E6E47E3A7C5483
            E29F8934992D6DD74DD2B40D36DF43D3924984D218A091903CB2064566E5D885
            E00643C01E6579F8AA1818D16E94AF2E9DBF25AF9BDB5D1F5E1C761F2F8D36E9
            CBDEBAD2F7F576B2F56EFB1C43B6FB73215556DBBB024DBE5868D768DE48C280
            C72090490B23175CB05BA87796DCA15448C58CB1FC88DE52860DD0A7CDB4919D
            E32A41908568DC901F323FDC347B4A2B47217631E5C3BC430739CCAA0A86E986
            6C36EC300DA0B18E395D2191BE745943E0AA85E000401194C00149DDB4B8DA87
            C66B5D76FEBCDFAEBFA5CF9F96B3D3BBFEBCF6D3F2D491DD4CB234D1CDB5A53E
            7C727CCCEBB3CC7DEA303772371C03965DDE56DCD4685A683732B334F1626915
            958BEC9544CEC4643360AB670769058AF2ED4F857CBB85895EE1648E7CAEECF9
            836201BB27938682525B18055BFD59232968BE7C9131DD1F9860CF96795CAAA4
            7B00E41DC23DA172CAA491E626C351A5BDED7BFDF65FF037EDA226EEF78F6FF8
            75F8F4ECB60917CC66C8F244CD2A3924FCAAC15B72E4F25618812C187452F212
            E42CDA5EA975A45E5BDE59B3D9DE58BC53C1E5CA4FCE8730900825BE62CAA8C1
            7E45C8C2EE7582C62F3668554C10B33C6498E3429C0C92C3680CA2550303084C
            5862368646D91FB5471EDDCBE72C4E0331054BAC6CE80E0B364346412BB9F6BA
            82DB763D464E32BFF5FD6B7E9F90E3270D57DFE5A7F5E5DDEC7ED07C01F88F0F
            C59F83FE1FF1043B00D52CA39DD54F08E461D79E721C3024F5209191835D8D7C
            8BFF000488F89CDE22F829A8786EE270F75E1FBA122A08F005BCEA25439C0049
            91A5E5720E063800B7D755FD0992633EB582A757AB5AFAFF005FF00FE95C8F19
            F5AC0D3ACF7695FD50514515EB1EB0543A95D2D9D84D2492794AAA7E7DCAB83D
            B05BE5CFD78A9ABC83F6F9F8A9FF000A67F637F891E20599219ECBC3F76B092F
            B1BCC92330C654E78224963E7D7038CE4272E55CCFA1D997E16589C553C34379
            C9457AB763F043F6A5F89D27C6DFDA33C77E29DD24DFF0916BD77246B2CAC5A2
            4797FD1D487F9536C6A89B4E1C16400AEE1BB86DCA8FBBE66450191E4881562C
            F266428327F7806D1804C9E690BB59A4C24037DDC691B46BB54C2CDBA3FDC859
            086CA9E0E378C82C480EC3F76CDE5C90F9A8B68D3011BECB30C44A0B129E5441
            838E3770B1B92E70548572A0A95FCAEBC9D4AB293EAFF55AFCFF00E1EE7FAED9
            0E5F0C065B430905A538A5F87EB6D2F6E9D7524667B68C8DD2ACCAE515646559
            7CC8D176EE6C9F9CB38F998608FE32A54B93BF94677568D3687505D7E5407396
            70C0F56566C3038F99DC90B524C8F0C970B186693CD96D01C8413160DB779C6D
            E59B049006E914E1999184734BE5A798BB9D56379373208C6158A2BB296FBD1B
            05059B98C08CC80B2A94C232DBA7F4BFAFEB4F5ECF65DB4FC7FCF4F2B5F46C71
            46F3E68E33B5E3570A1B7CCD192CB0856520E582AA7621B3CB6D2CD2FD892FEC
            D5E15F83FF00B397C5EF0DC8D1F883E23787B47D0F539DA6D2E28D7459AF6EED
            888EDEF37BCBB82CAA642C1776F272DBF15F1DDD968448AADFE8E8F3CDB5DCB2
            8C39C860C546F56453B81036C9212D93E737B96B9FB7E78EB5FF000EEB5A4DCE
            9BE13B9B8D7EC2DF44D57529B4ADBA85F79007D99E6915953CE4DB952A026595
            8AB2B21AF472EC450A49BADBF4DF4DFCFD35B33F3CE3ECA73BCC23469E5524A0
            A49C95ECEF19464B75B594959352F855ECDB36BF6B5FD842DFF651F87F6F7B71
            AD5FCDAD45A99D2EE2C6E6C12CD6FF00744CF34B685EE1A4920464589CCB1C41
            CBA3A9246E8FA3D4FF0064EF0BFC4487C2B0DC788A3F0F58DBFC29FF0084C7CE
            D3FC2AAA2F63B633ADC9BB02E7F79336D6019542C83E455523E6F17F8DDFB516
            BBFB43D8C2DE20D2BC269A9BB5BC971AE5BE9DB6FAF364422F366624A1424B06
            002062A1801F2B2F4FA4FEDEFE2FD3ED6C238FC3BE1066B3F0D3F845236D2C9F
            F40B8D825B7933322EE93320C304197C6C1B80AED8D6C0AA92F77DD695B76DEB
            D75FBEDB6CFCFE6AB64BC67532EA3CD5EF888CA6DB5C8924E3656D1AB27DD5EC
            EEDBB9D3EABFB0DE8367E248F56B5F186ADFF0813783EDFC6CDA849A4A7F6A98
            67B87862B658566286E1DBE457F347C8ED866284D3B54FD87FC3FE05BCD53C45
            73E2CD4BFE101F0EF84F48F14FDAC68B6F2EA0575132C569662DCCED133EE2E3
            2250842E1411230AE4A2FDBCBC5A896912E89E0A5D2E0F0B3F8526B17D35BECF
            A8E982643E4CE8D203B84A0B6E565642773E090B562FFF006FEF1A6ABA95C7DB
            745F03DD586A5A2C3E1ABBD25B4971A6DCC16C7CC851D0B8398C96DA57600093
            B0AAB383DB65C97C3E7D7B7AF7F9D937D55F9A596F1ECB49554D59ADE1AABAD7
            E14B99C6E97D9578A4B73D9FF697F835E0F8756F8E7368F63A0F87F4BF0FE9BE
            18BA8E1B7F0B4323DA417115AEF96CB6CF12C33334FE63445595818D7857515C
            E78CBFE09E5F0FBE1FBF8B3FB47E247889BFE1036D29F5936BE1640248B538CF
            D9BC96FB592AF171BC9C10220724226EF39F12FF00C1413C5DE321E265D53C3D
            E007FF0084D349B4D3B53DBA63A7DAEDAD9666846D1222AB22A26D20156D9C67
            6BB54BE24FDBFF00C5FE2F7F118BEF0CF80E697C5FFD98BA98934FB82B74B68A
            1AD14869F3B73BD0E0229F9C13BB26BA2B63B0139B738EBAF4F37E7E71FBAD7B
            EFE4E5FC2FC7382A6A8E1AB72AF76F6706FDD54D3D5C5BBD94FB36ECDF4B7597
            FF00B08784BC0B7DE38B8F1778FB55B483C03E28B7D06E7EC1E1B137DA05DB79
            D05C238B81860EE37C615880A412EC406EA753FD8A668BE1E37C37B5D3FC3B79
            E2EB5F8C56DE19B4D6A5B24B696E6D66D3A69C6F74264F2CACA18A2B31013920
            AB30C7F0C7EDF1A4EA5F0BBE236B9E26B1F0CDE7C42F176A9A7EA96FA6DC787A
            5BBD2651671344B249FBC0C1CB485402D8DD08050A1CAF9BC9FB7CFC427B7BB5
            925D2DB52B8F16AF8B65D4C58FFA50D49731A48A59954830B3C1E5B2E02B84C1
            120661D6C053B38AF8974F57A3D77D57DDDEC94C72DE3AC74A74AB4FF8728BF7
            B9546FCB16DC5A8A6D26E4A5BADAC7BF7C79FD8DF41F8B3F15BC3BA5EA9E2487
            C2DA9FFC239AC491DB2F8523B2B98AD74D91597CD816ED8881A0DCD14ABB2622
            205F714623CB6E3F61AD1354BDB2F10691E32D407806F3C1F75E33B8BE9B4A30
            EA96F04337953C42DE3976B48D205DA565546126EFBDB9AB93D33F6EAF10F877
            C7B2F89B49F0AFC3DD3F509AC2EAC677B3D2648D6EE39F68959CF9AAEF27CAAB
            F33011A86398C105E3D1FF006EFF0018E876DE1F861D3FC26D67A2E8F3F87BC9
            934CDD6FAA58C9B5E78EEF749860CD1B4C4ED4657DDCE240B51531597D59734A
            3777F3F2F3B77BADEDD4ECC0F0FF001CE0A9428E1EB7BA95ACF92DAB77B68F54
            9A49B6D2D6E9A3B6F0EFC00F0CF8D7E0BF8D20F00EB563E22BE8FC45E1DB3B2B
            DBFD04DA5E5B1D4018E38965F39FCBD92878A4411BA332A10CA180AE67E3E7EC
            99E16F857F07B5AF10787FC65A96BB2785FC57FF000856A91DD6902DE196E7C9
            67924B63E7CAD222988AFCE06E25A4C2E0E70F4DFDB23C47E1CD07C41A4E87A0
            F837C3B0EB97B63A898F4CD3258A4B19ED522F27C842E36ED18621C30DD39C82
            5F6549F18BF6D3F137C69F02EB9E1FD4B44F07D958F8A7525D7AFEE34EB116D2
            CF7AAB27FA4ACBE6E0CAF1385383B544A42E0798D58CB1182953B35676ECEDE5
            BB6F4FEBB9EB61729E32A58D8D4F6AFD9B945C9370726AD0E6BDA3AE8A4928DA
            DAAB1E3F2E658B73168F7C4E0B95F323C4830EC108E466489CAB336F663CB940
            D524727DA27858F9BFEB96451E6798C1598305539CE0F97D723739CE0B26000B
            1BC6936F99894A2B091B064126D0464828CC2211FCE7970465725A56DB27DB19
            57CCFB434852194B932F9990A1890541248531FCCB8F99B6F2DE51F0B7FEBFAE
            FD5FC8FD9BCFFABE9F874EB7BFA91C448B38D99A3FDE2A7C8D86505B6FEECEDE
            157CCDC7042E73CAED8D88D8F03F82752F891E38D0FC3DA2DBB5E6B1E20BE874
            DD3E172A86796E1BECE9F3B38C056755196298951CB7CC0AE4C04DD0F3215693
            200C08F2E0BB17605067180640D9DC0E036647DCB5F467FC124BC15A67C44FF8
            28AFC2EB2D56CDAFACE3BC9B558F123A7EF6D2D2E2E2198B06DDB7ED16D6F200
            5983ED1B9A45381B50A2AA558D3FE6697DEF7FEAFE9A1E3F1266DFD9994E2B32
            B5FD8D39D4B6FF000479ADBABB6B5DD5DF5EA7EEAFC12F83FA2FECFF00F093C3
            FE0BF0F4261D23C39651D9C05923596E0A8F9E697CB55569A572D248E146F777
            6C649AEA68A2BF548C54572C7647F90D8AC4D5C4569E22BC9CA736E4DBDDB6EE
            DBF36F50A28A2A8C028A28A0028A28A0028A28A0028A28A002ABEAFA45A78834
            9BAB0BFB5B7BEB1BE85EDEE6DAE231243711B82AC8EAC0865652410460824558
            A286AEACC1A4D599F8C3FB437C2F3F047E36789BC2F27DA162D1B526B6B7374F
            1CB235B9DD3DB3B943866689A36C33C60B34590BB19178D218E5378F94B06467
            077348F146431F9761E7058A804237DE495157EA6FF82B8F8321F09FED2B63AC
            436935BC7E23D222BA96790168EEEE6176B79150B92BB85B9B7564002ED6076B
            BBE57E5B6CDA05DCE636B7772AEA198AE6305982B64B05500156E0AAB0711E5B
            6FF3B66F85585C755A2B68B697A5F4DB5BDB7B75D977FE68CF306B098FAB855B
            464EDE9D3B5F476EFDB4B063740CDB199364BE6478F9F6142EB1B8C90AA4142D
            961B76B6DDA5559BE96D4BE01E87E01F819F12BC33717169AE78DB438B489EE6
            76D3628E3D2A7BA9A1DD1C1727F7814AC8AA721170E080017AF99FE44655611C
            5E4A0976BFEFBC960021C2B1C9D91EC20EE28E20CB670C62F58D5BF6C0F156BF
            A56A7A7CFA4F87E5B9D62D62B0BBD41ACE61A8DC79727EE65765C334B1B46082
            170193054C8154EB9556C3517296237B59795EFAFABF9FE46B93E230945C9E23
            57D34BAEABFAEBDCD4FDA2FF006545FD9EBC33677926B57575AD43A925BBDB4B
            66B0FDA4A45BDEEAD7323CB2431EC3113228525FE5E1863A1D4FF678D17C6571
            E1D8E4F115BE870DAFC3AB7F1179F65A118DAEE08FCDDDE72ADC959270AA1F78
            C07C805576015E51F14BE3DEA5F192D95354D27C2EBA8B4AB732EA365A7A4377
            A9C82178C17906E0E7720CAC69B1DDC32904A56EC1FB5DEB56AB16DD27C26B14
            7E1E93C2AB2C76926E7B27DB23A7120E58E41DBBB2CEBF28320AF42188CB6355
            DA3EE34BBDF7BEBDAFF25AF91E84717962AF2D2D169776F7F55FD2F43A2D43F6
            5DD2F4ED7535187C4F7F6DE11B5F0BDBF8ACDEC96205F44924E163B7F24CDB5E
            52E9B54B310411976015A967FD95B49F06DE6A9ACDD6BDA82F857C33A5693AD4
            9236961EF25FB5ED36B0087CDC070A194B34840C0C2819AE761FDAEFC4486CE1
            5D17C23F67B1D28F8724B41632CD05EDA990148A505C3F0F991366D762189186
            0CD25C7ED8BE21BDB9B8B8B8D2FC2B73A7DFE976BA4DCE9F269E63B29E18599A
            06644700326EF2D0A3600D9945E28F6D94C55D475BF9FF009FA79FCD9A42A64C
            EC92EBE77D7A24DDB7EF776EA7A87C73F857E1DB7D7FE2FCD656BA369365A526
            8172D6CBA1432DC5A4532DB6E92D584A8B113E610EBC893E55DCBBF2313C41FB
            1C784FC0B71E228EF3C69AB093C15358437ED0E8C42CA9782368920FF4907723
            3333671B77B95E803711ADFED85AFEB1078816F342F08DDC7E20B6B48AFD9ED2
            48DA64B539B7CAAC8235658FCB2319561B5771DA733EB3FB6578935D6D71B50F
            0EF82449E21B8B49F562D6737EFCD9345B5252242A57E4E41F98A6F00290A1BA
            AB63B2D9CEF28EFA75F3F3DB5F5B26958DAA66595547CD357BFAAEF6D9DFB77E
            FE66CDC7ECA7E1CF0BCDE267F1178DB50B787C37E204D025369A179FE7ACE144
            3280B28312958BE70AA19554AA993000EB2F3F663593C076BE0EFB368D7FAD5A
            7C4E8B428F5316CB049716EF69E702F20FDE3261F795DCDB48DA092AA062E81F
            B5D69ADE0AF186AFAF59E8975E32D6357B6D4FFB3E6D1E59AC1668222A0F3303
            14A5D65CF2492A40560EA0710DFB6078D20D3AE23F2F496BC3E206F1435F8B69
            D6E0DF21706524305DA23509B5C1FDDC817202332BF6D9653B4A2B7EDD2FD1F6
            76F9FAD91AFD6329A3694568D37A76BED6BBB7DEDF45E7EBFF00157F673D2FE2
            1F8DF4BB5BEF105A787AE2FB46BCB948E3F0DFD9E610D94A42F9D69E79630989
            0F920A891E38C2B86642CDC04DFB2868F7D3C5AA59F88B528BC27378626F10CB
            7773A7A0D421804A6DDE2316F2ACF232A8522458F0CC3180A2B12C3F6AED634A
            F19C9AC5AF84FC0B6F71756F77693C31E9132C770B33A248F2296DC589455C12
            117CD65DB9F35841A7FED79E25D2ADF4358F4BF0A8B7D17459344990D849247A
            8D9384324739FE3C18A53942BF32487905C563531996547CD28FE7ADB4F4E9FD
            6CB9EA6332893E67177F9F97F5D3D56A751A0FC1ED07C51F0EFC4161E14D534F
            D7FF00E2A0D22C6D26BDD0DE1BC905C8444067F34BC71F98AE1D02BAE61DEA54
            72313E34FECF1A27C38F8777DAB693AFEA5AD4DA0F890F872FE3BCD39608EE27
            8D659249633E6312AC1554676918070300B67D9FED3DAE687A56ADA6E9BA1F85
            3455D56F60BF636B672C3358CB6AD1F96D19663B550C458970402F216243E55B
            E3CFDA735BF89BE15D4343BED07C27636BAC5F43AACED65A7B89A4BB6603CCC4
            8CC77B890A3291865258261B230A988CBA54ACA3AA4EDBEFBAB6BBF9EADF4EE6
            55313962A4D38EB6F3D2FA7AEBE69ECBE7E6F0858E48C348AD0868812AC572AA
            A42B863818DC76641C0DAC37C69B4A4681920559372ECB74570C9B4AB2BFCEC3
            7600DB21CE195558EE1CBC4095566921DED33AB3167124C7732AB460976607E6
            2244552C76B361C618EE489E655B693CE7592155943B2050C405824624A8C02E
            0A956E8402C3306428F9B6D27AF9FE1FAF7D3AAF23E47D3FAFEB41B2AB6D653B
            9D9A22AC5490AE701DDF1839E8BF30DE4050401B1763E6918DC3C6B9692432F9
            3BE3CAC8769541DC36E5232A090CB2825A4DE88AC9229A1458CC2B24A8AAAD16
            549628DBB6E40DBFBCC92A1B019598ED62C1839BE69268D242DE70750E7E5FB4
            FCE406CE7E6DACCF9627E53BB2EC0AA2CFF777DFFE1FD35BF7F3D0A51B6FD3FC
            BF27F8F43E99FF008252FC428BC23FB47CDA3AC9BACFC4F60D6F00707124F128
            9A324A801B09E67CC41258963B4BED5FD35AFC6AFD9ABC6CDF0FBF683F076B42
            4FB22C3ABDBF9B22265A28657F2CA83B09F9A30C02B05E223B550950DFB1FA7C
            8B2D8C4CAAAABB70005DA171C631DB1E9DABF60E01C5BA98395296F17F9FFC37
            F48FDA7C3AC67B4C14A83DE2FF003FD09A8A28AFBC3F430AF88FFE0BE3F117FE
            10FF00D87FFB2D248E197C49AE59D996270E6142F7126CC1078F2501070086C7
            2322BEDCAFCC3FF838EBC6AF168BF0C3C3EBB9B75D6A1AA18D5324AA47046ADF
            C438F32504B0070780C01AE1CCAA72616725D8FD13C27CB563F8B7038792D39D
            3FFC06ED7E291F9638927478F76EDC02157FDE2C3D154124B2AA1CC8038DC73C
            7556461EE17619376D88B26C777C1286232264B0214C78DE037FABF998827697
            0A7969B55A491638C471053956062640C09276A9DAAB862DCB00497C62413EDB
            A8DB3261659234FDEB2958D4A2B2AB6031244BB3008612040003E6357E65D6F6
            FF002E9FD7FC1DFF00D54D1E9E5F8744EDF7FE4DF48E685E1DF85F2E48721708
            FC1F2711A807F78430DCBB4FAFCB8600970785EE5442D0C91A09191519B72AE1
            4C6BB970491E790A5598033061D1710AB2C561E67970C8C96A1DD3F76136281F
            26402A54EE8D58950AA3258226D8DA6BB0D349342F234FB9E681CB3801C9740B
            9C0200662EBFC78CB285DCCD185B69FD74D7FAF2DCA7AFBD2D7FE0A5D7F0ECFB
            EE11C5E6310567FDF6220A300E3645F2E00ED8694054FBC18AE54B65AB1B5D2A
            EEC6EB840C8D9F9774B379A5902F3C88D3262CFCC4156E0B82ED9648E66DC236
            9C0646910A825C3B498E1F1FBC40700B01BA360EF98D039B6CF3BEDF2E3F31CC
            8FBCE321C9911CF9673F296DD95FB8CC1B039928D52B7DDFD7E1EBBBD0356FCF
            557FD3EEBAEAF6D7541004D4194AB6E49B0544685B0640CD80A1870AAC92003A
            01B8FCC5006C4CB791C2FB59BCF68C001C48AE2408EEA36E3938594E76923739
            C0F941BFED636E64567129649235DC824846E2E98232376E910280CC091CE51D
            646F3372B483FD2029123306383B4C7B18B8DCB9456DEA41DCEECACAC5BCA34B
            DFFAF97F5DD12ED676D174F24F5FD7EED1EAD0DFB42189676585B98F0039DAFB
            0E546EE5977308CE5F0CA17772AACAAEF2962DA3CC553BBCBF30E634DCAD2004
            919DBB4B338F989E1C3E1D4B17A3FDAAE1BE646DD308DB07EE99C00D92C0721D
            6443950A7200065528638663249134691B34C90A80FBA3790EC589D383C13C82
            D96DA514167F9550D568F4F2FEBCB5F5F32B9B556FEBB5BFA7657B8F8D99A48C
            F36B23B9597618D443990970CBD4A8047DF201C639DC15E20330491B2C617CB6
            92485D73C08CC654FD5769C82700637797E5B81D237B7DA55678E52E0811AA89
            C2A889405006D66DCDBB69DDB491B46E1B6572D35C32E6391B761965DACAD249
            205705402002AB2AB0E4F1852CFB806BCBFAF27FD798A3B5D7CFE4D6BF8A5F35
            6D8478F73F97F37EF0382EE8ABBCE5DA4257247CC17705070E48750A1598B646
            E15993689092A1D832BA90F236090AD83B33B890488D5812C0AA35903DB08564
            676F28943E665E6578933BD937172D85DC13EF1DEC9B9941495E2135EC89FBA5
            79AE1E0C948FE657F907CBCE576018DFB801221F9B1E585A2D7FAFEBFE08B6F7
            3CFF0005AAF3D6FA755AF9892A6F592346999618CC230E0B60EF65E40206DDA1
            8B7CCAA612A8199DD013CCC1E499771B81E548BF7D449BD5768DC0B361E408A0
            124020E1CED2A5A8E2E6DE22ADBA4900281F76D72F1C818646E2CDB001F360FC
            CACCACDB558126D55F2FCB658C79836624798BC2AC17617F9B73101B63153B94
            64925A33AB4FA77FC7FCBF3D8ADDD9F5FEBE77FCBB6838A96468D5E49141982E
            CCB095D08997728FBCE40078CEE3B982BA48E41950EEFB6368F31CC43B0904D9
            F34A12DC9DAD18CB3A861B8B633B5C536E3C8884CD234735BC32E32640CD3AAB
            0568C960081B51F0480A5449B8EC25EA45134771FBCDB2490CC9E67CE706445F
            2C86666E15946031259B255B70528EF65A69FD7AEE0A4F7FD7FE07DCDAB75766
            C646BE5BC7BD5E46420B00C55D98F0C7E56C093CB2B82195546C2331A82A8B10
            9921B791D5FCC0235284E1D59C872848006197195099CEE51F723A408AF1242F
            217560CAEAEC09FDF4582C4640FE38D9F0406691581524A33DA46F303C8ED16E
            DEEEC19998F0B09271B1D8891949F983011A6154EC00D6FE7FD5BFAFBC9E5D34
            FEBB7DDB6BE7BEC111FB7F93BC3B44C625F2D1D4F944BAB12A325A3DBF381824
            A976557C88C57DE1FF0006EE48D37EDA5E2491996432F822F2591D5142876BED
            38F1B41037637E010A4BB1065E597E0A9956EAD258D4C4C25427CA62BB00F282
            B6768014EDCB33A8042C855771C2AFDB7FF041BF89169E10FDBFD6C6EE3BF9A6
            F19685A969166E832B0C8AD0DFABCA1CEE54686D2600AE72C106DDB81177E52D
            47194D3EEBFAFEBAFE1F9CF8C14E7578333254D5DFB293F3B2D5EFE57D7B7C91
            FB65451457E987F95A1451450014514500145145001451450014514500145145
            007C31FF0005A0B968E6F86CAA7E5D9AB4A5039064DBF63E319C630C790320E3
            9552C6BE1509F668BE6C2C696F87C264BA4403B70D82D80918F2DBEF2265BCB1
            831FDB7FF0599F1559DCF8ABE1FE8F0CCCDA9E9B05E5F4F08570238E731C701D
            DD0B33C13602FCCA2276CA10AD5F12C11EF8A144319DE122C8407714946D4C0C
            8DC588C8190C5149500171F84F18494B39AAE3FDD5FF00922BAF935F27BF97F3
            E71B352CEEB72FF7577DA11FBAC3AE372A4C9249B582CBE617DC59599FE624F3
            9F2D63576FBCFC03C36D3113C3E6968DE2470D2059230BF7705E355014E0EF8D
            A40AA08002811B2B304548DFCC74F2D917F8D369E8A30C392413B06D8C156E0A
            E3CC54208155408C46A9B02AAA82C1460BBF921B200E33193F7720ABED7DA84F
            CCEDA2FE935BF4D3BAFE97CB4757E7FE7F7F5E9F900B892E048D1B09A4699B05
            5D594B11F29C7CAA1061490420E327E52D1C6F12B4737991EE711B0923019DD9
            F84F2D7D4EF61B972189037796AB2150D32A4281A4F31A1B4298DE84148902E4
            F38206EC2EE18CEF54DD1AA8C3192410C91FCBE604645CC630CEEA5DCFC80165
            0BB8B155190C54965DAA0B2BFF005FD7A765A697D677B2EFF9FF0056BF6BF5D0
            57FDC4320CE556272B92A01F2E4600B01F2E37B33607C9B958E6465085D9DF74
            BB4EF0C7740C09566FBB9746382ADB907EF392ACB1AB08C238A250AE6465CED7
            532A7218ED5063041FBAC576B107EEB095826C3F2B0AF1DC2BE374D1C8CB1B79
            2DB8B2B2C6588C9C2FC91643BFCC0EDCEE23CC05F6B6FF00F0D6EDB2B5F7D8AF
            B377FD3FF81AF6B0912348144292316D8E9F6750194798E42AAEEC9FBBB942E1
            448A884672888B8919BC9754F9D12DDA222511AAF9857616C7DD53131CE392AE
            5D59CAD2164756F37CB94471992558CED122ED8C6F190305848BE59C0550610A
            19C328594EE59A39244DC836BE3EE82A7058803E5015942FCB95DFB5632ECA55
            BB276E9FF075F97FC3750D7AFF005B69D2FE7E401D563DCBE5C70A841851C431
            B0D9952C40D9B5776D6DA5E37624FCEAEAF7578D94C8B247246CA1C36570EADB
            F69E723CB453D1810B93BD31125249FBF67F33CC5F31995B2798CBEC3210A09E
            429E76B6724348C14A0A200CF730B7DD5DC1DD437DE0D1860A30006DB132AEE5
            2AA37A15DA06E55AEEFF00AEBF356DD3F95AC4CB4F9EBF77E7AF55DC6A47E5A8
            551E533E1948C611DF79C9C0207C8A15805DAFE5E151B6A16743B5846BB5554E
            D5DB81F222EF2A78E30190AE3EE928A5F6380592D433A40BFC4C96EAEC872C5D
            B7E028C7219D83631C860DB641870C76FDD2C8559D563DECB1B83E610E19BFD9
            2199154392C0EF8B00B6110B3BFBBABEFF002BFF004B75F8AAD3FCBFAD9DBB31
            D183247B97CC4DC55D9E307721C6EDF925768518915D88201032E9197022027E
            55DB9F217CBDA4281E61C04182429C1601C162BB4EC63117323407ED9B599048
            277DAF92A2270CD23BE4E18708067707554059E3D880C6B12DD42B1E19227454
            2AC36AC6BB599430C28F963419CEC466F309F951DAA959CAEBCBFE1FFCBD6FDE
            D3A257FEAD6FEBCEFF002143ED68F649BA4632CB0A862ACCE8E40DBCE4193246
            771202603B18CC65018E38E445CB431C480748F745B8151B49E016041DC1576A
            A1237E36B9DDA50D229FDE4CA1882BD259328A586DCB606E255C312AF300A416
            6A47956DE332A6C296E66B80081B7E4CC6A7EF778D554E1812C3FD63B6E0A95F
            4F9E9FD69F9A0E96F4FBF7FF002DBCFD049A37B98E487CC87CE76B88246CC985
            77DE09C637E4E652010198A15C907CB590CFF68B8698C7229697CE2AA0394053
            00E1460ED2CCBC71918061F30061603E6AC4AAD243854460A245911240ABC632
            4798E51BE43BF2E4C7BF0B50CC8B716CE2E02C91ED95DD8B093716F2C921B393
            F3315DD9E59DB0D27CA8CADA793FEAFE5E9AD9FDC572DD72F9FE7AFA7EA1B196
            D17CB871200C54065902489F239DDD37331600FF00108FE6525BCD3FB59F077C
            5B1F8F3E17F87F5A877795AB69D6F76831C2ABC6A400703F1F7F6C57E2ADE3AC
            AB248ECCC58310DBFF00D62C810901C86CB3333A003AEF90B05C387FD62FF827
            9F8964F147EC9BE119A6756961B792D32AEAEAEB0CAD0AE08EB8545E41230C39
            F4FD0FC3DAEFEB1383FB4AF6F4B696F4E9BF99FA47871886B155693D9ABDBE6B
            A7F5F79EDD451457EB27EC815F8E3FF070D789DB53FDAE3C1FA3280C74FF000F
            C32A090B322B4F73282D83F2E3F74B950416D9D54B035FB1D5F877FF0005D4D6
            FF00B47F6FDD5AD5B6BFF676896568DFC2D77FBA129471FC63F7E9C229396190
            C3E4AF1F3E9F2E0E47EEBF473C2C6B71A5194BEC4652FC97EA7C6CAD14DA7AB2
            95FB3B7259C16C811330DDB49190ACBB42005C0EC8DCCD24F246CD332AB49969
            F6798B86DAA131E66E6C93BA346249DA73B8BC7B0535E5F92391E6DCC7CB1E66
            5497531C9B1C336F21400FDCAB0C90CECCF1B047972AA8904331936AA124B424
            6E54EB952D1BBA1C648224551BCAA6EFCEFE5FD69FD7DCB4D8FF004965B5E5E4
            DFA77FEBAEDD873A9B47CB4924DB433191D97F7A63658909FBD975700B37CECA
            366E5DDB0222293E5C6BB495DD126D5C22B24CD82A31B90614A845C38F2C2E5B
            686A16D95420589523671011F3246A0BAAEC249FBA163DDB49DDF2851B3700C2
            4BF69C48DBA4123446500C88E480A1B3C67CCCFCA003B83C63E6F936C474B6BF
            D7F5E9A7904747E6BF3E9FF03D6DD450AD6BBA558E58FECEE1DCBC5F3465146C
            671C6033487E50CA09278219E40C693ECE8CEAD21F24095DD984BBBCA08A1DB8
            553872E4BBE0679CE103C4D11B46BF2C76EB22C7B4AED0BFBD024C2AAE36AB05
            08395230887E6588E2551BE558E29131BD92277412A81F7B6ED39E540420000B
            A3A052D8121367FD5BFA5F3B13D2EBD3C92FD7C9F569F6423DAEE95AC70AC559
            94C018B02EEE10827AE308FF003A8DE809278CEF449D647CB6C9BCD75772C155
            A45642F26F3BB6F1BA35233B33B71B58AB2A2385B48D63DE88C84F94C1CA3B67
            8C850CAC594201F7812A76A294689DC5B6662F94F96CAE2370DB598249232E3E
            6E0FCF8504FCAC0EE7076A97EFFD7F5FD329F77B7F5B7DFEB67AE96BB65C4A26
            8646171B91C3E7E5C4AC1A390ED2BC96552F855C81E68E070EE9269154C8DBD7
            73798CE1997CC5C223B039C9CF0776E50A224230A048C2E7FD5AFCCCDE59552E
            554931ED84162D925721C31E0BB2AEF2C8096BCA2279668FC959149B84532300
            C58091558FCA0859118F017710C376EF343D25D969E5F27FD7FC386FBF4DFF00
            5EDD2FB5BE6B6732084B2C8B1F98E5632A530980C53CA253838D89C28524941F
            C4B1B0A5E28A393124AB917284111A3ED83248DA42E58AE7E5C0C9621D9415A5
            307932797F347B0B08CBA2EF8C329F28EEC12C4BC8E0A95EA593279132448E97
            9B6250B74A4480344FB8B2C4593863E610C5816CFCD90C307E7759D7AFF5FD7C
            FA6BB12EEF75FD7DDA69BAD9DFA6A2346D04722AB22B6232BB636084B393193C
            63CCCB22AFCA00C03C10110FB814C6AD0C78206D50181431E180E8A57F7B1B12
            CECB905BE50C0242238E28C5B9645B73F292089235C84120DBC0DABB972C42E1
            24C0DAAC59560595D958322968E290A2BA9831B808F8E99CE4280707E5560442
            68566FEEE9E9F8FF00C315CDBF57B6F7BFF5F87908E08F342A85F2E3680A9902
            460BAB36CF9C750CAD9DFB81DD921810B1CD12BFDAE358F6F98B289117E6F94B
            856591D771E77760DFF2D7E6C348CCB035DB18639DCC224DED392240AA92491B
            3FCAD8651B1A30D96C8DA1CB267616784482E9576B2886604A051B902C809047
            591F7156500B6319F98E164257B59F6FEBD7A3FF003179AFC3ADEFFE6D2FBAE8
            6413471C4ADE6491C16F0A60B49B5B665CBA2E3040000FB8A70CB850A1570F68
            A631B4276B48A25431F97B86E5272A8A776D053CC236A8623690B20534D81551
            E185A45465758087E5A25259885618000F95B70656219080B94573E692000ACC
            DBF7029E5FCCADB92468D4601076217DAA159FE60446CAB824BDEDBFE1B5F5FF
            002FCC16AFF0F97F97FC07BDC71954090ACBE48F31F132B0511AA624624E49E7
            706E71BB6BBEE901405440C18B347E5ADC300418822461A665656E00C2AAAA90
            793B54FEEDDB34C90A6ED8CDE643246022A371E5B4A836C640DAC7E684FF0012
            9C05058BB48541F2A45B865B7924DE26672CED96323CA9828096593E45475186
            2A4100810B0E2EDB7F5FD5823DFBFCFE4FBAFD57CC491DA78B05A4DD3C7E7AB4
            86439037EC2E71B9B66DE0A600DDBB21BCB7AF64FF00827F7C625F817FB6BFC3
            6F1749268F65676DE2158AFEE351936DAD8D95E03697133C8A5553CA8AE2772C
            48446DAD22B6E32D78D84FB2AB2AEE8658C2AED646E6453249C8C3032A2E4A83
            951959332FCBB496DF6C8D1ECF2E4CBA618BB60AE5FE600EF32062AE08CB3170
            5771FDF8D29D4F6752338FD9775E76B7F5F2E879F9B65F4F1F80AD80AFF05584
            A12F49A6BF27FE76D59FD45515E07FF04D2FDAD87ED97FB25681E28BA9BCDF11
            69FF00F128D7FA1DD7B1471B19772C71C44CD0C90CE4420C686731866D84D7BE
            57EA946AC6AC15486CD5CFF22B3AC9F159563EB65B8D8F2D4A527192F34ED75D
            D3DD3EA9A7D428A28AD0F2C28A28A0028A28A0028A28A0028A28A0028A2B9FF8
            ADF1334AF835F0E35AF14EB53793A66876AF75361D11E5C0F9624DECAA64762A
            88A586E77519E6A6738C22E72D12D59352A4611739BB25AB7E48FCCFFF00829A
            FC433E3FFDAEF5A8E3934F9ED7C376B6FA3C135B3EE2CA3E7903B659432DC4B7
            50938DA19155D37202DE0224F376C8AA650C859308489B7B131A632436419502
            7CFC305DD863B6D78A7C4D79E2AF106A9AC6A532DC6A7A95EDC5DDFCD1A888BD
            CBCD248C7680B890956D806DF98E03101235AF2230B866DCAD3234BF392AA1C8
            68E45DDC001001CEE0150480158F96AFE72CC315F5AC554C44B69C9BD7B6F6F9
            5F4FF876FF0098F32C63C5E2AA62A5F6E4DFCAFA26BB5BD7A11B39822DD9DDE4
            C4EC2504323ED0BB0839E71BD8062DDC80CE385734662C2A8549373322A04665
            60840C1E572CC1CF1B37AAB30C06411376EE2AB1FCD2AC6ED09FBB26E6C48AFB
            49DEA54464B12411B4FCEE04619D26E78E4F25506F47F2914642E5D5A250319C
            36236550BF30DC55140490715EE95FE7FD79DB6FB9F43815FF003FE9FF004BF4
            64766B3C91C5146DE5DC32C31941852B21588E32464B063CE43EEDE24DDF3144
            4996F5BCD65DCD75145349B89FDE07F295B38192BBB7BE41671E58C10CAC5070
            8ACD27EF7CBDD80ED1FCD22058E542571F328298C636919388CC809465674F2C
            7EEDE4578C29625BCE79221B7F88653F71D77B70A78C020F2FE977EDE5EBE43F
            EBFA7ADFD775DC745B8DCA16F96449170252172FB577172065180F998AFDD111
            24EF45C462413DBF9722EF55B6472A54671F207C2E0904C60007691FBA0086DB
            E61799163CF9788E38DC1556C6D454658A32776432A946C927010C886427A12C
            6EB0B46C5A3C47246D93F323756272705A3DA8C7767210E59592208EFBC9FF00
            C37FC0FF003ECC9564EEFF00ADBF5B7EAC74B23B3316658DD99D9B7AEE284AB9
            DD839DC423485C16218A82EEC1F0A8A8CFFBB0D343B8F971B0CB1562596264C0
            04953820001C9F9C07DFB59CC648A70FB7ECEE9B65DA7E58E36DA5067838540F
            011B492B90100DC8A91ABC76D165F72450A4714B1901B032D9423047555F9707
            2C012922E5E4237D7E5F2EB65F7AB7A795CAE5695BD3E7AFE5BDBD41DD648F27
            72ADC2B11B76B63E7794AA0190F866040505240AAD856514E67CDD48CC6356F3
            0BB383C0769240CC189C300FBC0671C2BBAEF2543335E26DAAA8D9B8DAB10765
            DC921457287B961F2C0F92C5367959DC18252CD347219BEF79190E0B317668A5
            3B589206FF009BCCC96C65C328F943A8908ABE9E9F9FE7AEAF6EB604FB6BFAAF
            F83B2D7D1E835862DC0FDE4216274638398373AF9A724820AB6F382570D85DAE
            3E62F9A0F31DA2DB15BACA6683CB560B1C459141C28C1C925C1C10401B768555
            051CF2ED203236D7695B8563132AA804A93F236D1B42B0528762BB1D99245F2E
            36F3146D54955C2808C465F7609195CB4A8060041964C39728CB56B9ADAEBF97
            E4BCFEFBE81BEFF7FF005FD7CB41249127DEEDE50332FDA0AC8BBFE50CC70CB8
            DA426F6CED19D9115223FDF05562CC54C6AD24A04CCAC1C0647F30E1B25B2727
            F8C1EACEC5888D911FE6343769E6799E62BB33ED043EF8F6860A718DCAA46D1C
            18CA28D85CA978E34DA228D8C4EE22821E59596408BB9BA8C7967F78BF312ABE
            5B0608AAA6137DB7FEBD34BEDB5FD3546A9A97F5B5AFFE5AF4D2C2AC49292B0C
            6AD199B745191B15B742FF00F7C0650A72047C38C6C1B7C948E4CAAB798ACD18
            598173DDFEE48793B777988CCD90788E3FDD8614D9184F161C46DE6C0D300FFB
            C60CCC0339383955DB26EFBCCCA4E703779523C8271BA46FDDCB23877DDBC28E
            5242CEBC02598EE6DCBBC3139883654DB5FF0087FEB5DB4FBB7355F2FEAFEBE9
            FF0001A32AC1192D0C92242155D1D41E23E818B02376EDF1B06048CA95DC1FCB
            9152D9A05584B1F3159612DE66D3BD102BB65B3B30A5C824128DBD898C6EDE42
            9F6C7823D84BDC4689B5142E3CF3233A676F0705C281C7040475794D36D9CCF0
            A4DB774B722295500DE5C86078E08F9BCC8E31951D4838CCB96E2F6F97E4BFE1
            DEDD034EBFD3D3A69D3A6DF88E8E4533AB2ED590C6AE80B3236D67F31030DC1B
            6A0DC0963F22C448760401FA4FFF000494D7DEFBF66692CD9BE5D37589ADE332
            9DAECAF124FB82ED18C973C64F0091C002BF35A065609B5BCC2C6122442C4CCC
            B8F986086672645C0C893254B1897E55FD02FF0082376A247C33F1558A85DB6F
            A9C7213110C8CCD02A920800103CBDB9C738F97E5E4FD7F04CF97338C5ED67F7
            FF005F9BB743ED3806A4A39A45774FF2DFF4E897CD1F67514515FB61FBC1E67F
            B487ED91F0BFF642D334DBCF895E36D0FC1F0EB12345622FA53E65D95DBBB646
            A0BB05DCBB980C2EE192335F847FF0548FDADBE1DFC6FF00DBA7C5BE20F0C78A
            AD35CD0AF8D85B5ADCC4D218AEC47696A9222927E60AE305B2092A5977AEE53F
            A73FF058DFF82324DFF053ED7FC19E20D23C6D078535AF09DB4F632417D6525D
            5A5FC12488E3EE48A626521F2406DE1D46576027E213FF00069378E84995F8BD
            E11DBB7186D26E0F38C67861DF91F8673CE797198586229FB2A8DDAE9E9E5B6A
            7DAF00F1C62785334FED4C2414E7CAE3695EDADBB7A7F5B9F0FC5F18FC337189
            23D7A1DFF2BACB146C9238286324E3E601997717DC4052E461A312007C60F0AC
            F1E1358B558197CA2A0B471BC4D23045DA41F957AA86254E25401509C7DBE7FE
            0D27F1D0857FE2EE78459D4F6D2EE53CC1C9C13B9B04E40C818007439A17FE0D
            26F1D0DBFF001773C1BF2A91FF00208B9E49CFCDF7FA8CF6E381C1E73E3FFAB9
            85EF2FEADEBFD7DE7EDBFF0013559F2DB0D4FEE91F10DBFC62F0CA5DFDA3FB52
            DDA607CD7FDD48A54AE24DDB540DA72EC0A302D82ED9077A96B7C58F0DFD9FCA
            6D5D648BCA646F322724AAAAA96002FC873B861486209C362255AFB80FFC1A4B
            E3930AA8F8BDE115753F79749B8C375CE46EEBC8E98E9D0E73483FE0D24F1D24
            6C7FE16EF849DF70207F65DC2061DC672704F1CF38F4347FABB86DD37F77A6DF
            F06DFE6FFE26AB3FFF00A07A7FF9379F9F9FFC03E1E9FE3178664877FF006CDA
            A43B1F0D82EACB267695F931CB6331AF700E729F34ADF183C377374CBFDAD6FF
            003B4C7CB2A79F30B06DC0A6163C292548DACCA492590BBFDBABFF000692F8E5
            5A33FF000B7BC22FB4E583E9371B5CE73D98103181D73EFE80FF0083497C7461
            656F8BDE112DCED61A4DC8F4EBF3904707A63AF538C51FEAEE17BBFBBFAFD77F
            5BAFF89AACFAD6586A7DBED7F99F0F9F8B3E1C9201BB54842796C1F7432EF68D
            9406CEE077330462CA41C1624EE3102C4BF173C37721E27D6ADD369749CC71C8
            DB3CC555249249CFCA4B2E46D0EC777EEF737DBDFF00109178E9813FF0B73C1D
            1B74DDFD913B30EDC364100F048E9C01CE01A7AFFC1A4BE386552DF173C28ADF
            31C0D36E1B6E47033919C1CE4E064765A3FD5DC3F493FEB4F9E97F2D7D6F5FF1
            3559FA77FAB53FFC9BD7BEBBB3E21FF85CDE1B7BA1E5EAC219267122E0491BA6
            173D194E02EE2093C65761C2AB46590FC5FF000CAC28A9ACC31AC68F1ED8E094
            1B740918200396E5412626231818E622C7EDE5FF008349BC74AAD9F8B1E0F6C8
            C053A65CF3C8CE1B3C6EC7756C67F8B19A57FF0083497C7402EDF8BDE1327186
            274BB8001CE720679E303191D49CF6A3FD5BC2DF5BFF005BF6FF003EDA682FF8
            9AACFF006FAB53FF00C9BFCFFAF4DBE205F8C3E185976AEA56A9B7CC768FCB93
            E5010C63A282318618186203E1885903BAD3E2E786212B6FFDA96B22C72FCE81
            6400B65882C7051488C72368208FBC368CFDBE9FF0692F8E40F9BE2EF847BFCC
            BA4DC863C719F988C03CF4EE79E9841FF0692F8E4C0CADF17BC22CDCE1BFB26E
            3BE38237608001E983CF53D28FF5770DB5DFDDFD7F5F8AFF0089AACF9AB3C3D3
            FBA5DFD76F2FF827C3F6FF00167C3AB6D6A926ACAC918843968A556E32A1C120
            ED6255095C623DA4F58C350DF167C3B2C631AB2A865C64C5201187DB92A84614
            EE4C32316006F2F9F9F7FDBC3FE0D20F1D03F2FC5EF06A9EE57459D4B7B921B9
            3EE79C003A0147FC4243E3B273FF000B83C239F5FEC7B8FF00E2A9FF00AB986F
            E67FD7C8A7F4AACFDBBFD5E9FDD2FF003FF87EB767C46BF18FC3372030D615A3
            B8770488DF6A2F9FBA36076FF000A392081BCA32042489F19BC353CA0B6AC8A6
            5F9F690EAF97742F228D80AE15B0C47DDDAC328C19EBEDE97FE0D26F1C11B97E
            2D7847218B6C1A5DC2AE3B282492BDC64E7A8E38E45FF8349BC731B4647C5BF0
            8BF20BEED32E002739E80E48230319079CE7B525C39854B77FD7AFDDE7F812FE
            9559F3FF00986A7FF932FD7B7FC0EA7C3F6FF17FC3F15BC7B358B74F92341246
            AE15577653A0C11B81F946046BBB047CE1907C60F0C44CBFF138B5854032ED99
            1D48846D033B873B36FDD6E10B12D9D877FDC07FE0D23F1CA05DBF173C24CD8C
            37FC4AEE17272791C9E99CE3BE0F23390ABFF069378E2331FF00C5DAF08C83F8
            C36977014F24F4072411C6320F24E7B51FEAE61ADBBFEBE56FC341FF00C4D567
            FAFF00B353FBA5FE7AF7D7FCCF87E2F8CBE19B62A3FB66DA16C79E43C6E8AA15
            182960C410838DC832CA0B29242834D3F17FC31E6FFC86ADB74F06C2D74AC666
            429E5062480ACCD84DEAEA7E6EA4889057DC3FF1093F8F0C4CBFF0B77C1EAD91
            87FECAB9627AF6DC00EBD39FBA0E4648A7C9FF00069478E1A4DC3E2DF83C641C
            A9D26E4A82738C7CF9E38C649E4739E943E1DC35F77F72F977FC7E7D452FA556
            7FD70F4FFF0026FF003FEBA9F0FF00FC2DCF0BC93C6BFDAB02C6C863F2DCCB1E
            F4656F33AFCC19B692C0B121B2EC498F6D2DAFC5FF000EC5243249AA5BB49E64
            32C845B3C5B82EF00ED0A154B37CCC08CA6E7C9C4631F6E9FF0083497C70D238
            3F173C27E5FCDB7FE259704F39C0233DB8C9FE2CF45EA5BFF109178F01E3E30F
            847AF3FF00127B8E7FF1FA3FD5CC33566DF4FF0083FD7F90FF00E26AB3FB5BEA
            F4FEE97F9FF5F81CDFFC116FFE0A55E0CFD93BF6918F4DF1278B34BD37C13E3C
            B64D2F52BEBB1F67B6B29A267369792CA6262A824796320C91C08B79248CDB6D
            CB9FDF4AFC3293FE0D27F1CF55F8B5E110CCC4ED1A65CAA807A63249E393C9E7
            8191D6BF567FE09DFF00023E247ECBDFB33685F0EFE22F89BC37E3193C1B6F16
            97A26ABA5D93D948DA7448120B79E223697855422CAA417409BD4BABC92FB183
            C2C70F4BD9C1B6B5DFA5FA7F5FF0DF8871EF1A4F8A73479BD7A31A752492972D
            ED2E5D1377FB5CB68DF6692EB7BFBA514515D47C585145140051451400514514
            005145140057E5E7FC15DFFE0A81E00B8F88DFF0AB34EF1F69EB61E1B91C789A
            3B3BB678EE2F95F6FD8A4D8996683CB7DCAB211E6B329512DB109FA11FB49E8B
            F10BC4DF07758D33E176B3A0786BC65A9466DACF5AD5EDDAEA1D1C3021AE1200
            0ACD2AFF00024988C310CE24553149F8DB17FC1A53E3A5FBDF16BC1DF781C369
            774D903B6430E1BAE3A8E80F73C199E056330EF0F2938A96F6DDAEDF3EBE5F8F
            9B9AE5EB1B86961A537152DDA5ABF2FF003EEB4EA79C3FED77F0EDD558F8B2C5
            98E3E7D8EF97DDF3850AB821F850A0E0094290DB96A39BF6B2F871756D327FC2
            51A404977840B2C926776E8C107CB6E137B2066015496C0560377A50FF008349
            FC78197FE2EF78376AA1520E9175F3139C37FACED9FA703DF21FF834A3C78EC4
            B7C5CF07EEDBB01FECAB9F6F9B0180078C73BBB9CE4F1F25FEA0E0AF7F692FBB
            FAFF0081BDAF767C67FC439C05EEAA4BEEFEAEADD373CDEE7F6C0F870F2CF349
            E2ED261672663FBD03E618DCF92B8518DE4339720B0FBCD23966C9FB5C7C3702
            45FF0084B34C2C14E61092111EC024D98652C31972CAC1B96CB9CC8057A67FC4
            259E3B575FF8BB3E0C31872C1069372A1471C7DE2CC38C6370C6739EA08FFF00
            069678F3CBFF0092BBE1066C6187F64CC81D463001E769E39619273D0F3995C0
            382FE797DCBF5FF803FF008873807A7B4974E9DBFAD6FF00F04F357FDAEBE1B4
            F348D1F8B34DD9348EE9207606525DDD1BA7FD353F36F0CAAE1F73295C927ED7
            BF0D6391B778B34BC2F9402C864490A89723E5F2F0B9E54920A82809CBA647A5
            1FF834ABC7440FF8BB5E0DE011FF00209BAE7E5033FEB3B1E7EA7D30288FFE0D
            2BF1F44176FC5FF06FCBB4F3A2CEDB8A8C64E5BBF523A1F4C00035C0382FF9F9
            2FBBFAD43FE21D6036F692F3D17F5FE4B4D0F3393F6BBF875E46D93C59A28123
            4D6EC44D200CCF92CA7E5247CA8C065B255002C4050A4FFB5FFC3532349278B3
            4368E52C2567770A10A3AAA31D8B90482C71F2F20A18F72AD7A65BFF00C1A5FF
            00102278DFFE16F783D5A2C84DBA4DCE47270D90C0E79CF3D381C814E5FF0083
            4B7C7713B6CF8BDE11F2CB1255B4ABACBA6410AC438C8E3B01FCB0BFD41C12D3
            DA4BEEFEBFE1FAEE1FF10E7017F8E5F77A6FFD7CCF3393F6B7F86ED70EA7C59A
            3492E7CB6CF98AF3860A1CB13129C9663D70429752ADBA4C23FED7BF0DE71346
            BE2BD3E66F2303E593CC7DD929FBBDBF2AB2B88C804676A2EEE4AD7A57FC4251
            E3AD9B7FE16E783B3B76EEFEC8BACE739CFDFEBDBD31DB3CD2CBFF000695F8F6
            58E44FF85C1E11556C9451A4DCE21271CAE5FAE001CE78A3FE21FE06D6F692FB
            BFAF3D3FC920FF00887580D5FB497DDF97F56F23CE0FED7BF0E1AE1A41E2AD3D
            A46B8C92D33B67E4611EFCAE3CC2ACA4B90372E5837FAC6765BFED7BF0E519A3
            5F17D8BB42A8D18579771185C385D8186011B5C2EE2CDB581DCD9F4A3FF06957
            8ECC8C7FE16DF82C29DC401A45D719FF00B69D0751FAE7A503FE0D2BF1F12DBF
            E2FF008364DCCEDFF2059D705BFDD61C0E303A0C7B9C8F80304D7F11FDDE9FE5
            F887FC43BC0377F693FBBB6DFF0003B77E87998FDAEFE1B9B30D1F8AB476CE00
            C33BDB93F290C3E42B8046470390E48650C85CDFB5E7C3585DA48BC5360D2290
            C24DB92D8F31C12DB48C9208C1CAB46A80E30AADE94BFF00069578E830FF008B
            B5E0D382A70749BAE70391FEB3F8BA9FD31427FC1A5BE3D454FF008BBDE0D2D1
            90558E8B71D893823761B39EE0F403A714FF00D41C0FFCFC97DDFD79FDF7DF73
            FE21CE03FE7E4BEEEFBFCBA7A75D8F35B5FDADBE1A2C2BE5F8AF4D92358E3119
            466642164DEA030465C0509962B8631B31438662C3FB5F7C37B7014F8B7488D9
            90B932492C4C922EC2D92CBB83461C28F98B2B28CB300457A69FF834A3C724AE
            7E2D7834E191B1FD957633B7A8E24E8DD4FE981C50BFF0695F8F842CBFF0B8BC
            2233851B748B850573921BE6F98EEC1C9E9803D30BFE21FE07FE7E4ADE9FD7F5
            E625E1D6017DB97DDFA797F5DCF366FDADFE1A9611FF00C259A7DAC73308D5B0
            FB94121420E17E68C6EDA721B29B48010A28BFB607C399648E65F13596E9991C
            947953079DA884A8FDE0DC5632307FD60258F03D25BFE0D2BF1E6E257E2E7835
            325BA68F72D804631F339E9D8F5E7AF4C2AFFC1A55E3ACC99F8B9E0F0B216385
            D22E3E5CE30012C780467D4E48CFA1FEA06077E797DDFF000FF2FB823E1CE012
            FE24BEEFCFCFCFA7958F305FDAF3E1BCB6BB478B74078D976644FF00B9DCDD57
            014614AE4041839CB20451F2CDFF000D73F0E6E8BAFF00C255A5C8D2330D8D34
            923482460137045C6598AB9930AAC563DAC182B57A42FF00C1A5FE3FDFFF0025
            7BC18BB4A91FF12699B7151C1C678EB8239CE3249CE01FF109578F0C6AADF17B
            C1ADB7183FD8F700E3938E1F9CE7A9E781C8147FA81827AF3CBEEBFF0057FBED
            E7B3FF008873804BF892F92FEBF3F37A9E6A7F6BEF86F7261DDE2AB03E748A1F
            CD2CCC7700EF180402ED2196360095DACF85CE18B7D77FF04BBFF829D7C0BF82
            369E2D83C5BF13B41D145D7D925805D19774BB62983851E5B31C054E770DC3CB
            DA3900F8747FF069678FA275DBF17FC1FE5EDDB22FF645D7EFBE6DDF37EF3A71
            D063A0EFC922FF00834ABC7888AADF17BC1B2EC60416D1EE012324ED3B5C641C
            E3279C01CD7A396708E130388588A537757D2DDFFE1975D7ADEE7A395706E130
            189589A539371EE95BB7E47EC37ECEDFB5CFC35FDAD74AD4AFBE1BF8CB45F185
            AE8D32DBDF49A7CA5C5B3B64A86C804676B107A1C71457CBBFF046BFF823A4FF
            00F04BD3E34D5358F1943E2ED7BC5AB6F68A2CECCDADAD9DB425DC70C4B3C8CF
            21259BEE8500753457D69F667FFFD9}
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo64: TfrxMemoView
          Top = 0.779530000000022500
          Width = 718.110700000000000000
          Height = 30.236220470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' Score')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo65: TfrxMemoView
          Left = 106.826840000000000000
          Top = 143.401670000000000000
          Width = 109.606370000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."SCORE_SERASA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 317.480520000000000000
          Top = 69.031540000000060000
          Width = 400.630180000000000000
          Height = 26.456690470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Recomenda'#231#227'o da Pol'#237'tica')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo69: TfrxMemoView
          Left = 317.480520000000000000
          Top = 95.488249999999990000
          Width = 400.630180000000000000
          Height = 105.826840000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[NovaProposta."MENSAGEM_DECISAO"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 201.448818897637800000
          Width = 321.260050000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line1: TfrxLineView
          Top = 30.236239999999950000
          Height = 170.078850000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo66: TfrxMemoView
          Left = 317.480520000000000000
          Top = 30.236239999999950000
          Width = 124.724490000000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Probabilidade de'
            'Inadimpl'#234'ncia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo67: TfrxMemoView
          Left = 442.425480000000000000
          Top = 30.236239999999950000
          Width = 75.590551180000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."PRINAD_SERASA"]%')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo70: TfrxMemoView
          Align = baLeft
          Left = 518.016031180000000000
          Top = 30.236239999999950000
          Width = 124.724490000000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Modelo do'
            'Score')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo71: TfrxMemoView
          Align = baLeft
          Left = 642.740521180000000000
          Top = 30.283508500000040000
          Width = 75.590551180000000000
          Height = 37.795280470000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NovaProposta."MODELO_SERASA"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
end
