inherited frmCadChecklistValidacaoGarantia: TfrmCadChecklistValidacaoGarantia
  Width = 616
  Height = 259
  Caption = 'Checklist para Troca de Mercadoria e Devolu'#231#227'o de Garantia'
  OnDestroy = FormDestroy
  ExplicitWidth = 616
  ExplicitHeight = 259
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 610
    ExplicitTop = 186
    ExplicitWidth = 610
    inherited FlwBotoes: TFlowPanel
      Width = 606
      ExplicitTop = 2
      ExplicitWidth = 606
      object btnVisualizar: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 75
        Height = 20
        Caption = 'Visualizar'
        TabOrder = 6
        OnClick = btnVisualizarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 529
      ExplicitLeft = 529
    end
  end
  inherited pnlStatus: TPanel
    Top = 214
    Width = 610
    ExplicitTop = 214
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 263
      ExplicitLeft = 263
    end
    inherited pnlInfo: TPanel
      Width = 263
      ExplicitWidth = 263
    end
  end
  inherited pgcDados: TPageControl
    Width = 610
    Height = 186
    ExplicitWidth = 610
    ExplicitHeight = 186
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 602
      ExplicitHeight = 154
      object pnlTipoRes: TPanel
        Left = 0
        Top = 95
        Width = 602
        Height = 59
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlTipoRes'
        ShowCaption = False
        TabOrder = 0
        object Panel3: TPanel
          Left = 121
          Top = 0
          Width = 481
          Height = 59
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel3'
          ShowCaption = False
          TabOrder = 0
          object rbDescLinha: TRadioButton
            Left = 0
            Top = 0
            Width = 481
            Height = 17
            Align = alTop
            Caption = 'Descri'#231#227'o - Linha '#218'nica'
            TabOrder = 0
          end
          object rbDesMLi: TRadioButton
            Left = 0
            Top = 17
            Width = 481
            Height = 17
            Align = alTop
            Caption = 'Descri'#231#227'o - Multiplas Linhas'
            TabOrder = 1
          end
          object rbNA: TRadioButton
            Left = 0
            Top = 34
            Width = 481
            Height = 17
            Align = alTop
            Caption = 'N/A'
            TabOrder = 2
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 121
          Height = 59
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 1
          object Label2: TLabel
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 111
            Height = 14
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            Caption = 'Tipo de Resultado:'
            ExplicitLeft = 22
            ExplicitWidth = 89
          end
        end
      end
      object pnlGrupoCkl: TPanel
        Left = 0
        Top = 49
        Width = 602
        Height = 46
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlGrupoCkl'
        ShowCaption = False
        TabOrder = 1
        object Panel5: TPanel
          Left = 121
          Top = 0
          Width = 481
          Height = 46
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel5'
          ShowCaption = False
          TabOrder = 0
          object rbTroca: TRadioButton
            Left = 0
            Top = 17
            Width = 481
            Height = 13
            Align = alTop
            Caption = 'Valida'#231#227'o de troca de mercadoria'
            TabOrder = 0
          end
          object rbGarantia: TRadioButton
            Left = 0
            Top = 0
            Width = 481
            Height = 17
            Align = alTop
            Caption = 'Valida'#231#227'o de garantia de mercadoria'
            TabOrder = 1
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 121
          Height = 46
          Align = alLeft
          BevelOuter = bvNone
          Caption = 'Panel6'
          ShowCaption = False
          TabOrder = 1
          object Label1: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 0
            Width = 108
            Height = 14
            Margins.Top = 0
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            Caption = 'Grupo do Checklist:'
            ExplicitLeft = 17
            ExplicitWidth = 94
          end
        end
      end
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 602
        Height = 49
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlDados'
        ShowCaption = False
        TabOrder = 2
        object Label3: TLabel
          Left = 74
          Top = 7
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label4: TLabel
          Left = 59
          Top = 32
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object dbeCodigo: TDBEditFocus
          Left = 117
          Top = 2
          Width = 71
          Height = 22
          Color = 16770261
          DataField = 'CVG_CODIGO'
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 117
          Top = 26
          Width = 460
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CVG_DESCRI'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 536
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44816.341141088000000000
    ReportOptions.LastChange = 45074.558418298610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '                                  '
      ''
      'procedure GrupoCheckListOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxDBRel."CVG_TIPOVG"> = '#39'T'#39' Then'
      '  begin'
      
        '       Memo6.Text := '#39'Vistoria para devolu'#231#227'o de sobra: itens a ' +
        'serem verificados na devolu'#231#227'o do produto'#39';                     ' +
        '                                           '
      '  end'
      '  else begin        '
      
        '       Memo6.Text := '#39'Vistoria para devolu'#231#227'o de garantia: itens' +
        ' a serem verificados para este produto'#39';      '
      '  end;            '
      'end;'
      ''
      'procedure ReportTitle1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxDBRel."CVG_TIPOVG"> = '#39'T'#39' Then'
      '  begin'
      
        '       Memo1.Text := '#39'Checklist de Valida'#231#227'o de Troca de Mercado' +
        'ria'#39';                                                           ' +
        '     '
      '  end'
      '  else begin'
      
        '       Memo1.Text := '#39'Checklist de Valida'#231#227'o de Garantia de Merc' +
        'adoria'#39';      '
      '  end;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 525
    Top = 149
    Datasets = <
      item
        DataSet = frxDbRel
        DataSetName = 'frxDbRel'
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
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 544.252320000000000000
        Width = 718.110700000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        DataSet = frxDbRel
        DataSetName = 'frxDbRel'
        RowCount = 0
      end
      object GrupoResultadoNa: TfrxGroupHeader
        FillType = ftBrush
        Height = 19.275590550000000000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        Condition = 'frxDbRel."CVG_TIPORE"'
        object Memo7: TfrxMemoView
          Width = 377.952755905511800000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 377.952829130000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Conte'#250'do')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        DataSet = frxDbRel
        DataSetName = 'frxDbRel'
        Filter = '<frxDbRel."CVG_TIPORE">='#39'N'#39
        RowCount = 0
        Stretched = True
        object frxDbRelDESCRICAO: TfrxMemoView
          Width = 377.952755905511800000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDbRel."CVG_DESCRI"]:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 377.952755905511800000
          Width = 340.157480314960600000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_CONTEU'
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDbRel."ITE_CONTEU"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DetailData2: TfrxDetailData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 718.110700000000000000
        DataSet = frxDbRel
        DataSetName = 'frxDbRel'
        Filter = '<frxDbRel."CVG_TIPORE">='#39'L'#39
        RowCount = 0
        Stretched = True
        object Memo2: TfrxMemoView
          Width = 377.952755905511800000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDbRel."CVG_DESCRI"]:')
          ParentFont = False
        end
        object frxDbRelITE_CONTEU: TfrxMemoView
          Left = 377.952755905511800000
          Width = 340.157480314960600000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'ITE_CONTEU'
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDbRel."ITE_CONTEU"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GrupoResultadoMultiplas: TfrxGroupHeader
        FillType = ftBrush
        Top = 389.291590000000000000
        Width = 718.110700000000000000
        Condition = 'frxDbRel."CVG_TIPORE"'
      end
      object DetailData3: TfrxDetailData
        FillType = ftBrush
        Height = 49.133858270000000000
        Top = 411.968770000000000000
        Width = 718.110700000000000000
        DataSet = frxDbRel
        DataSetName = 'frxDbRel'
        Filter = '<frxDbRel."CVG_TIPORE">='#39'M'#39
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Top = 3.779530000000000000
          Width = 714.330999130000000000
          Height = 18.897637800000000000
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDbRel."CVG_DESCRI"]:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baLeft
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Height = 64.251968503937010000
          StretchMode = smMaxHeight
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Align = baRight
          Left = 718.110700000000000000
          Height = 64.251968500000000000
          StretchMode = smMaxHeight
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Align = baLeft
          Height = 18.897637800000000000
          Color = clBlack
          Diagonal = True
        end
        object frxDbRelCVG_DESCRI: TfrxMemoView
          Align = baBottom
          Left = 4.000000000000000000
          Top = 30.236208270000000000
          Width = 710.551176220000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frxDbRel
          DataSetName = 'frxDbRel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDbRel."ITE_CONTEU"]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baBottom
          Top = 49.133858270000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'ReportTitle1OnBeforePrint'
        object Memo1: TfrxMemoView
          Left = 3.559060000000000000
          Top = 15.118120000000000000
          Width = 710.551640000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            't'#237'tulo')
          ParentFont = False
        end
      end
      object GrupoCheckList: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 124.724490000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GrupoCheckListOnBeforePrint'
        Condition = 'frxDbRel."CVG_TIPOVG"'
        StartNewPage = True
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'sub t'#237'tulo')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Top = 366.614410000000000000
        Width = 718.110700000000000000
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Top = 483.779840000000000000
        Width = 718.110700000000000000
      end
      object Line4: TfrxLineView
        Align = baBottom
        Top = 1046.929810000000000000
        Width = 718.110700000000000000
        Color = clBlack
        Diagonal = True
      end
    end
  end
  object cdsRel: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 540
    Top = 108
    object cdsRelAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsRelCVG_CODIGO: TStringField
      FieldName = 'CVG_CODIGO'
      Size = 5
    end
    object cdsRelCVG_DESCRI: TStringField
      FieldName = 'CVG_DESCRI'
      Size = 60
    end
    object cdsRelCVG_TIPORE: TStringField
      FieldName = 'CVG_TIPORE'
      Size = 1
    end
    object cdsRelCVG_TIPOVG: TStringField
      FieldName = 'CVG_TIPOVG'
      Size = 1
    end
    object cdsRelASSOCIADO: TStringField
      FieldName = 'ASSOCIADO'
      Size = 1
    end
    object cdsRelITE_CONTEU: TStringField
      FieldName = 'ITE_CONTEU'
      Size = 256
    end
  end
  object frxDbRel: TfrxDBDataset
    UserName = 'frxDbRel'
    CloseDataSource = False
    FieldAliases.Strings = (
      'AUTOINCREM=AUTOINCREM'
      'CVG_CODIGO=CVG_CODIGO'
      'CVG_DESCRI=CVG_DESCRI'
      'CVG_TIPORE=CVG_TIPORE'
      'CVG_TIPOVG=CVG_TIPOVG'
      'ASSOCIADO=ASSOCIADO'
      'ITE_CONTEU=ITE_CONTEU')
    DataSet = cdsRel
    BCDToCurrency = False
    Left = 565
    Top = 149
  end
end
