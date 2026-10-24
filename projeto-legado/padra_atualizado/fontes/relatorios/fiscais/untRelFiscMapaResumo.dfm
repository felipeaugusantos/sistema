inherited frmRelFiscMapaResumo: TfrmRelFiscMapaResumo
  Width = 392
  Height = 257
  Caption = 'Mapa Resumo'
  OnClose = FormClose
  ExplicitWidth = 392
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 386
    ExplicitTop = 186
    ExplicitWidth = 386
    inherited FlwBotoes: TFlowPanel
      Width = 299
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 299
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 307
      ExplicitLeft = 307
    end
  end
  inherited pnlDados: TPanel
    Width = 386
    Height = 186
    ExplicitWidth = 386
    ExplicitHeight = 186
    object Label1: TLabel [0]
      Left = 7
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
    object Label2: TLabel [1]
      Left = 74
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
    object Label3: TLabel [2]
      Left = 7
      Top = 47
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Imp. Fiscal'
    end
    object Label4: TLabel [3]
      Left = 218
      Top = 138
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Inicial'
      Visible = False
    end
    inherited gpbDestino: TGroupBox
      Top = 92
      Width = 178
      TabOrder = 4
      ExplicitTop = 92
      ExplicitWidth = 178
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
      object ColorLabel2: TColorLabel [1]
        Left = 28
        Top = 20
        Width = 101
        Height = 14
        Caption = '(V)'#237'deo (I)mpressora'
        CorDestaque = clRed
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 18
      Width = 62
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
      Left = 74
      Top = 18
      Width = 64
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
    object edtCodEcf: TEditFocus
      Tag = 99
      Left = 7
      Top = 63
      Width = 61
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodEcfExit
      OnKeyPress = edtCodEcfKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesEcf: TEditFocus
      Left = 69
      Top = 63
      Width = 307
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkLayoutCat55: TCheckBox
      Left = 16
      Top = 141
      Width = 112
      Height = 17
      Caption = 'Layout  CAT 55/98'
      TabOrder = 5
      OnClick = chkLayoutCat55Click
    end
    object chkPreencheCabecalho: TCheckBox
      Left = 16
      Top = 157
      Width = 185
      Height = 17
      Caption = 'Preencher cabe'#231'alho autom'#225'tico'
      TabOrder = 6
      Visible = False
      OnClick = chkPreencheCabecalhoClick
    end
    object edtNumRel: TEditFocus
      Tag = 99
      Left = 218
      Top = 152
      Width = 158
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object rgMapaResumo: TRadioGroup
      Left = 218
      Top = 91
      Width = 158
      Height = 44
      Caption = 'Mapa Resumo: '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'ECF'
        'Caixa'
        'PDV')
      TabOrder = 7
      Visible = False
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 177
      Width = 384
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 9
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 212
    Width = 386
    ExplicitTop = 212
    ExplicitWidth = 386
    inherited pnlNomeForm: TPanel
      Left = 215
      ExplicitLeft = 215
    end
    inherited pnlInfo: TPanel
      Width = 215
      ExplicitWidth = 215
      object Shape1: TShape
        Left = 199
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 328
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 296
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 328
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 296
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 200
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 168
    Top = 40
  end
  object frxReport_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41409.742283206000000000
    ReportOptions.LastChange = 41414.494232557870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 408
    Top = 56
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
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
    object Page1: TfrxDMPPage
      PaperWidth = 215.899860564673400000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 816.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 633.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#15#27#77'
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ECF:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagM: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PAGINA:')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 68.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODECF]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 796.800000000000000000
          Height = 34.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftTop]
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTitDta: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'ECF')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'DATA DA REDU'#199#195'O')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'VALOR BRUTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 119.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'CANCELAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 119.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'VALOR CONT'#193'BIL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'Nro. REDU'#199#195'O')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 238.000000000000000000
        Width = 816.000000000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object DMPMemo12: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_DTAMOV'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_DTAMOV"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_QTDRDZ'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_QTDRDZ"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALDIA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_VALDIA"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTDSC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTDSC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCNL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTCNL"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCTB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTCTB"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'TOTALIZADOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 816.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo23: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_DESTOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."TOT_DESTOT"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_BASIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_BASIMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_ALQIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_ALQIMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_VALIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_VALIMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 816.000000000000000000
        Condition = 'frxRelatorio."ECF_DESECF"'
        object DMPMemo11: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DataField = 'ECF_DESECF'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxRelatorio."ECF_DESECF"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftTop]
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReport_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41409.742283206000000000
    ReportOptions.LastChange = 41414.494232557900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 440
    Top = 56
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 90.708641890000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 9.600000000000000000
          Top = 5.661410000000000000
          Width = 576.907050000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 9.600000000000000000
          Top = 22.661410000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 676.686580000000000000
          Top = 5.661409999999999000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Date: TfrxMemoView
          Left = 503.886580000000000000
          Top = 22.661410000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object DMPMemo28: TfrxMemoView
          Left = 9.600000000000000000
          Top = 45.322820000000000000
          Width = 32.881880000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ECF:')
          WordWrap = False
        end
        object rllPagM: TfrxMemoView
          Left = 599.886580000000000000
          Top = 5.661409999999999000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PAGINA:')
        end
        object DMPMemo1: TfrxMemoView
          Left = 48.302350000000000000
          Top = 45.322820000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODECF]')
          WordWrap = False
        end
        object DMPMemo4: TfrxMemoView
          Top = 67.984230000000000000
          Width = 755.225170000000000000
          Height = 22.661410000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          ParentFont = False
        end
        object DMPMemo5: TfrxMemoView
          Left = 21.240630000000000000
          Top = 71.984230000000000000
          Width = 135.080210000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA DA REDU'#199#195'O')
          ParentFont = False
        end
        object DMPMemo6: TfrxMemoView
          Left = 286.354360000000000000
          Top = 71.984230000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR BRUTO')
          ParentFont = False
        end
        object DMPMemo7: TfrxMemoView
          Left = 399.379530000000000000
          Top = 71.984230000000000000
          Width = 80.579530000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
        end
        object DMPMemo8: TfrxMemoView
          Left = 486.122820000000000000
          Top = 71.984230000000000000
          Width = 122.759060000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CANCELAMENTO')
          ParentFont = False
        end
        object DMPMemo9: TfrxMemoView
          Left = 615.307050000000000000
          Top = 71.984230000000000000
          Width = 130.620470000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR CONT'#193'BIL')
          ParentFont = False
        end
        object DMPMemo10: TfrxMemoView
          Left = 160.781200000000000000
          Top = 71.984230000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nro. REDU'#199#195'O')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 39.645640000000000000
        Top = 215.433210000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        KeepTogether = True
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 39.645640000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          ParentFont = False
        end
        object DMPMemo18: TfrxMemoView
          Left = 29.277180000000000000
          Top = 22.543290000000000000
          Width = 326.853680000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTALIZADOR')
          ParentFont = False
        end
        object DMPMemo19: TfrxMemoView
          Left = 378.481880000000000000
          Top = 22.543290000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'BASE')
          ParentFont = False
        end
        object DMPMemo20: TfrxMemoView
          Left = 509.102350000000000000
          Top = 22.543290000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.')
          ParentFont = False
        end
        object DMPMemo21: TfrxMemoView
          Left = 599.281880000000000000
          Top = 22.543290000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object DMPMemo12: TfrxMemoView
          Left = 25.020160000000000000
          Top = 2.102350000000000000
          Width = 131.300680000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_DTAMOV'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_DTAMOV"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo13: TfrxMemoView
          Left = 162.001670000000000000
          Top = 1.984230000000000000
          Width = 118.752690000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_QTDRDZ'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_QTDRDZ"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo14: TfrxMemoView
          Left = 285.354360000000000000
          Top = 1.984230000000000000
          Width = 109.379530000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALDIA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_VALDIA"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo15: TfrxMemoView
          Left = 396.774830000000000000
          Top = 1.984230000000000000
          Width = 84.963760000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTDSC'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTDSC"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo16: TfrxMemoView
          Left = 483.779530000000000000
          Top = 1.984230000000000000
          Width = 117.543290000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCNL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTCNL"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo17: TfrxMemoView
          Left = 614.702350000000000000
          Top = 2.984230000000000000
          Width = 131.225170000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCTB'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RDZ_TOTCTB"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo23: TfrxMemoView
          Left = 28.497650000000000000
          Top = 1.000000000000000000
          Width = 329.045640000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_DESTOT'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."TOT_DESTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo24: TfrxMemoView
          Left = 378.481880000000000000
          Top = 1.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_BASIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_BASIMP"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo29: TfrxMemoView
          Left = 509.102350000000000000
          Top = 1.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_ALQIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_ALQIMP"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo30: TfrxMemoView
          Left = 599.281880000000000000
          Top = 1.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'TOT_VALIMP'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOT_VALIMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 170.078850000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."ECF_DESECF"'
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 22.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clScrollBar
          ParentFont = False
        end
        object DMPMemo11: TfrxMemoView
          Left = 3.040940000000000000
          Top = 0.881880000000000000
          Width = 750.387570000000000000
          Height = 17.000000000000000000
          DataField = 'ECF_DESECF'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."ECF_DESECF"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReport_M_CAT55: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42068.472392766200000000
    ReportOptions.LastChange = 42088.426458495370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 440
    Top = 16
    Datasets = <
      item
        DataSet = frxRel_M_CAT55
        DataSetName = 'frxRel_M_CAT55'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 436.879717848515600000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 17.000000000000000000
        Width = 1651.200000005611000000
        object DMPMemo13: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'NUMERO DE ORDEM DO '
            '   EQUIPAMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 51.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONT. ORDEM'
            'OPERACAO N'
            '   FINAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO FISCAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 316.800000000000000000
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            ' SERIE'
            'SUBSERIE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'NUMERO'
            ' FINAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'MOVIMENTO DO DIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 119.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CANCELAMENTO / DESCONTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR CONTABIL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'SUBSTITUICAO TRIBUTARIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 68.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTA '
            ' OU '
            ' NAO '
            'TRIBUTADA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 119.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'BASE DE CALCULO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '7')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '12')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '18')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1353.600000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '25')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO DEBITADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1545.600000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTADOR REDUCAO Z')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine18: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine19: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 195.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
        object DMPLine20: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine22: TfrxDMPLineView
          Left = 196.800000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine23: TfrxDMPLineView
          Left = 312.000000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine24: TfrxDMPLineView
          Left = 484.800000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine25: TfrxDMPLineView
          Left = 312.000000000000000000
          Top = 144.500000000000000000
          Width = 172.800000000000000000
          Color = clBlack
        end
        object DMPLine26: TfrxDMPLineView
          Left = 398.400000000000000000
          Top = 144.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine27: TfrxDMPLineView
          Left = 590.400000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine28: TfrxDMPLineView
          Left = 734.400000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine29: TfrxDMPLineView
          Left = 840.000000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine30: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine31: TfrxDMPLineView
          Left = 1070.400000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine32: TfrxDMPLineView
          Left = 1416.000000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine33: TfrxDMPLineView
          Left = 1540.800000000000000000
          Top = 127.500000000000000000
          Height = 85.000000000000000000
          Color = clBlack
        end
        object DMPLine34: TfrxDMPLineView
          Left = 1070.400000000000000000
          Top = 144.500000000000000000
          Width = 345.600000000000000000
          Color = clBlack
        end
        object DMPLine35: TfrxDMPLineView
          Left = 1156.800000000000000000
          Top = 144.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine36: TfrxDMPLineView
          Left = 1243.200000000000000000
          Top = 144.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine37: TfrxDMPLineView
          Left = 1329.600000000000000000
          Top = 144.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'MAPA RESUMO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ECF:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DE CAIXA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'PDV:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'NOME:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ENDERECO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'NUMERO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'INSCRICAO ESTADUAL:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CGC/MF:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 85.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'MUNICIPIO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 110.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 1281.600000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 1089.600000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Left = 619.200000000000000000
          Top = 42.500000000000000000
          Width = 182.400000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 42.500000000000000000
          Width = 825.600000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine11: TfrxDMPLineView
          Left = 763.200000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine12: TfrxDMPLineView
          Left = 1089.600000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine13: TfrxDMPLineView
          Left = 1281.600000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine14: TfrxDMPLineView
          Left = 801.600000000000000000
          Top = 76.500000000000000000
          Width = 835.200000000000000000
          Color = clBlack
        end
        object DMPLine15: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine16: TfrxDMPLineView
          Left = 801.600000000000000000
          Top = 42.500000000000000000
          Width = 835.200000000000000000
          Color = clBlack
        end
        object DMPLine17: TfrxDMPLineView
          Left = 110.400000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine9: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Width = 806.400000000000000000
          Color = clBlack
        end
        object DMPLine21: TfrxDMPLineView
          Left = 196.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine48: TfrxDMPLineView
          Left = 312.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine49: TfrxDMPLineView
          Left = 484.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine50: TfrxDMPLineView
          Left = 590.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine51: TfrxDMPLineView
          Left = 734.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine52: TfrxDMPLineView
          Left = 840.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine53: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine54: TfrxDMPLineView
          Left = 1070.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine55: TfrxDMPLineView
          Left = 1416.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine56: TfrxDMPLineView
          Left = 1540.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 1200.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 85.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[ENDERECO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 85.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[MUNICIPIO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[UFEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_PAGINA: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_PAGINA'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_PAGINA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_DTAMOV: TfrxDMPMemoView
          Left = 1344.000000000000000000
          Top = 17.000000000000000000
          Width = 288.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_DTAMOV'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_DTAMOV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 1478.400000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[INSC_EST]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 1363.200000000000000000
          Top = 85.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CGC]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1651.200000005611000000
        DataSet = frxRel_M_CAT55
        DataSetName = 'frxRel_M_CAT55'
        RowCount = 0
        object frxRel_M_CAT55ECF_CODECF: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ECF_CODECF'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."ECF_CODECF"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_CPOFIM: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_CPOFIM'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_CPOFIM"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_VALDIA: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALDIA'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_VALDIA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_TOTCNL: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCNL'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_TOTCNL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55VALOR_CONTABIL: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALOR_CONTABIL'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."VALOR_CONTABIL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_VALOST: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALOST'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_VALOST"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_ISENTO: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_ISENTO'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_ISENTO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_TOTIMP: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTIMP'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_TOTIMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_NUMCRZ: TfrxDMPMemoView
          Left = 1545.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_NUMCRZ'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_NUMCRZ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_NROCOO: TfrxDMPMemoView
          Left = 201.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_NROCOO'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_NROCOO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine62: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine63: TfrxDMPLineView
          Left = 196.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine64: TfrxDMPLineView
          Left = 312.000000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine65: TfrxDMPLineView
          Left = 398.400000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine66: TfrxDMPLineView
          Left = 484.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine68: TfrxDMPLineView
          Left = 590.400000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine69: TfrxDMPLineView
          Left = 734.400000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine70: TfrxDMPLineView
          Left = 840.000000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine71: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine72: TfrxDMPLineView
          Left = 1070.400000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine73: TfrxDMPLineView
          Left = 1156.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine74: TfrxDMPLineView
          Left = 1243.200000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine75: TfrxDMPLineView
          Left = 1329.600000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine76: TfrxDMPLineView
          Left = 1416.000000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine77: TfrxDMPLineView
          Left = 1540.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine78: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPLine58: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
        object frxRel_M_CAT55RDZ_BASCL7: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASCL7'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASCL7"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_BASC12: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC12'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC12"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_BASC18: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC18'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC18"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxRel_M_CAT55RDZ_BASC25: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC25'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC25"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object DMPLine92: TfrxDMPLineView
        Left = 2011.200000000000000000
        Top = 671.500000000000000000
        Height = 102.000000000000000000
        Color = clBlack
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 255.000000000000000000
        Width = 1651.200000005611000000
        Condition = 'frxRel_M_CAT55."RDZ_DTAMOV"'
        StartNewPage = True
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 323.000000000000000000
        Width = 1651.200000005611000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'TOTAIS DO DIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine39: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine42: TfrxDMPLineView
          Left = 1070.400000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine43: TfrxDMPLineView
          Left = 1156.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine44: TfrxDMPLineView
          Left = 1243.200000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine45: TfrxDMPLineView
          Left = 1329.600000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine46: TfrxDMPLineView
          Left = 1416.000000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine47: TfrxDMPLineView
          Left = 1540.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine79: TfrxDMPLineView
          Left = 734.400000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine80: TfrxDMPLineView
          Left = 840.000000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine81: TfrxDMPLineView
          Left = 964.800000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."VALOR_CONTABIL">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_VALOST">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_ISENTO">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_TOTIMP">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine60: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
        end
        object DMPLine40: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASCL7">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC12">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC18">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC25">, rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OBSERVACOES')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine82: TfrxDMPLineView
          Left = 657.600000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine85: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 93.500000000000000000
          Width = 720.000000000000000000
          Color = clBlack
        end
        object DMPLine86: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 59.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPLine88: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine91: TfrxDMPLineView
          Left = 1636.800000000000000000
          Top = 25.500000000000000000
          Height = 102.000000000000000000
          Color = clBlack
        end
        object DMPLine93: TfrxDMPLineView
          Left = 734.400000000000000000
          Top = 93.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
        end
        object DMPLine94: TfrxDMPLineView
          Left = 753.600000000000000000
          Top = 59.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
        end
        object DMPLine95: TfrxDMPLineView
          Left = 1108.800000000000000000
          Top = 93.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'RESPONSAVEL PELO ESTABELECIMENTO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'NOME:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 102.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FUNCAO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ASSINATURA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine38: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine61: TfrxDMPLineView
          Left = 657.600000000000000000
          Top = 25.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
        end
        object DMPLine41: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
        end
      end
    end
  end
  object cdsNovoMapaResumo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 16
    object cdsNovoMapaResumoECF_CODECF: TStringField
      FieldName = 'ECF_CODECF'
    end
    object cdsNovoMapaResumoRDZ_CPOFIM: TStringField
      FieldName = 'RDZ_CPOFIM'
    end
    object cdsNovoMapaResumoRDZ_VALDIA: TFloatField
      FieldName = 'RDZ_VALDIA'
    end
    object cdsNovoMapaResumoRDZ_TOTCNL: TFloatField
      FieldName = 'RDZ_TOTCNL'
    end
    object cdsNovoMapaResumoVALOR_CONTABIL: TFloatField
      FieldName = 'VALOR_CONTABIL'
    end
    object cdsNovoMapaResumoRDZ_VALOST: TFloatField
      FieldName = 'RDZ_VALOST'
    end
    object cdsNovoMapaResumoRDZ_ISENTO: TFloatField
      FieldName = 'RDZ_ISENTO'
    end
    object cdsNovoMapaResumoRDZ_BASCL7: TFloatField
      FieldName = 'RDZ_BASCL7'
    end
    object cdsNovoMapaResumoRDZ_BASC12: TFloatField
      FieldName = 'RDZ_BASC12'
    end
    object cdsNovoMapaResumoRDZ_BASC18: TFloatField
      FieldName = 'RDZ_BASC18'
    end
    object cdsNovoMapaResumoRDZ_BASC25: TFloatField
      FieldName = 'RDZ_BASC25'
    end
    object cdsNovoMapaResumoRDZ_TOTIMP: TFloatField
      FieldName = 'RDZ_TOTIMP'
    end
    object cdsNovoMapaResumoRDZ_NUMCRZ: TFloatField
      FieldName = 'RDZ_NUMCRZ'
    end
    object cdsNovoMapaResumoRDZ_NROCOO: TStringField
      FieldName = 'RDZ_NROCOO'
    end
    object cdsNovoMapaResumoRDZ_DTAMOV: TDateField
      FieldName = 'RDZ_DTAMOV'
    end
    object cdsNovoMapaResumoRDZ_PAGINA: TStringField
      FieldName = 'RDZ_PAGINA'
    end
  end
  object frxRel_M_CAT55: TfrxDBDataset
    UserName = 'frxRel_M_CAT55'
    CloseDataSource = False
    DataSet = cdsNovoMapaResumo
    BCDToCurrency = False
    Left = 504
    Top = 16
  end
  object frxReport_J_CAT55: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42068.472392766200000000
    ReportOptions.LastChange = 42090.411165451400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 408
    Top = 16
    Datasets = <
      item
        DataSet = frxRel_M_CAT55
        DataSetName = 'frxRel_M_CAT55'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 450.000000000000000000
      PaperHeight = 150.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 195.531496060000000000
        Top = 18.897650000000000000
        Width = 1662.993200000000000000
        object Memo13: TfrxMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#218'MERO DE ORDEM DO '
            '         EQUIPAMENTO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 201.600000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 51.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONT. ORDEM'
            'OPERA'#199#195'O N'#186
            '         FINAL')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 316.800000000000000000
          Top = 119.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO FISCAL')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 316.800000000000000000
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            ' S'#201'RIE'
            'SUBS'#201'RIE')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 403.200000000000000000
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#218'MERO'
            ' FINAL')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 489.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'MOVIMENTO DO DIA')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 595.200000000000000000
          Top = 119.000000000000000000
          Width = 134.400000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CANCELAMENTO / DESCONTO')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 739.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR CONT'#193'BIL')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 844.800000000000000000
          Top = 119.000000000000000000
          Width = 115.200000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'SUBSTITUI'#199#195'O TRIBUT'#193'RIA')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 969.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 68.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'ISENTA '
            ' OU '
            ' N'#195'O '
            'TRIBUTADA')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 1075.200000000000000000
          Top = 119.000000000000000000
          Width = 336.831540000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'BASE DE C'#193'LCULO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 1094.400000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '7%')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 1180.800000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '12%')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 1267.200000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '18%')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 1353.600000000000000000
          Top = 153.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '25%')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 1430.400000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'IMPOSTO DEBITADO')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 1545.600000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 34.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTADOR REDU'#199#195'O Z')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 14.400000000000000000
          Top = 195.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line20: TfrxLineView
          Left = 1636.800000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 196.800000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 312.000000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 484.800000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 312.000000000000000000
          Top = 144.500000000000000000
          Width = 172.800000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line26: TfrxLineView
          Left = 398.400000000000000000
          Top = 144.500000000000000000
          Height = 51.023622047244100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 590.400000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 734.400000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line29: TfrxLineView
          Left = 840.000000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line30: TfrxLineView
          Left = 964.800000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 1070.400000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line32: TfrxLineView
          Left = 1416.000000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line33: TfrxLineView
          Left = 1540.800000000000000000
          Top = 127.500000000000000000
          Height = 68.031496062992100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 1070.400000000000000000
          Top = 144.500000000000000000
          Width = 345.600000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line35: TfrxLineView
          Left = 1156.800000000000000000
          Top = 144.500000000000000000
          Height = 51.023622047244100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line36: TfrxLineView
          Left = 1243.200000000000000000
          Top = 144.500000000000000000
          Height = 51.023622047244100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line37: TfrxLineView
          Left = 1329.600000000000000000
          Top = 144.500000000000000000
          Height = 51.023622047244100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 107.640940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MAPA RESUMO:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ECF:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 240.000000000000000000
          Top = 17.000000000000000000
          Width = 71.281880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DE CAIXA:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 351.722820000000000000
          Top = 17.000000000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PDV:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ENDERE'#199'O:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#218'MERO:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1286.400000000000000000
          Top = 17.000000000000000000
          Width = 44.220470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 155.943290000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'INSCRI'#199#195'O ESTADUAL:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 1286.400000000000000000
          Top = 85.000000000000000000
          Width = 59.640940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC/MF:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 1094.400000000000000000
          Top = 85.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UF:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 768.000000000000000000
          Top = 85.000000000000000000
          Width = 77.102350000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MUNIC'#205'PIO:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 14.400000000000000000
          Top = 110.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 1636.800000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 14.400000000000000000
          Top = 8.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Left = 1281.600000000000000000
          Top = 8.500000000000000000
          Height = 68.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 1089.600000000000000000
          Top = 8.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 619.200000000000000000
          Top = 42.500000000000000000
          Width = 182.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line8: TfrxLineView
          Left = 14.400000000000000000
          Top = 42.500000000000000000
          Width = 825.600000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line10: TfrxLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 763.200000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 1089.600000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 1281.600000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 801.600000000000000000
          Top = 76.500000000000000000
          Width = 835.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line15: TfrxLineView
          Left = 1636.800000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 801.600000000000000000
          Top = 42.500000000000000000
          Width = 835.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 110.400000000000000000
          Top = 76.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Width = 806.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 196.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line48: TfrxLineView
          Left = 312.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line49: TfrxLineView
          Left = 484.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 590.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line51: TfrxLineView
          Left = 734.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line52: TfrxLineView
          Left = 840.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 964.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 1070.400000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line55: TfrxLineView
          Left = 1416.000000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line56: TfrxLineView
          Left = 1540.800000000000000000
          Top = 110.500000000000000000
          Height = 17.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo35: TfrxMemoView
          Left = 71.811070000000000000
          Top = 51.133889999999990000
          Width = 1201.890540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 117.165430000000000000
          Top = 84.929190000000000000
          Width = 634.961040000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERECO]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 850.394250000000000000
          Top = 84.905511809999990000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MUNICIPIO]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 1128.299940000000000000
          Top = 84.905511809999990000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[UFEMP]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 1352.410330000000000000
          Top = 85.905511809999990000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CGC]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 1447.559990000000000000
          Top = 51.133889999999990000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSC_EST]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_DTAMOV: TfrxMemoView
          Left = 1336.953620000000000000
          Top = 17.094441810000000000
          Width = 288.000131810000000000
          Height = 18.897650000000000000
          DataField = 'RDZ_DTAMOV'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_DTAMOV"]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 203.094620000000000000
          Top = 17.007874020000000000
          Width = 22.677170240000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 315.480520000000000000
          Top = 17.007874020000000000
          Width = 22.677170240000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 391.071120000000000000
          Top = 17.007874020000000000
          Width = 22.677170240000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '(X)')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_PAGINA: TfrxMemoView
          Left = 1167.315710000000000000
          Top = 17.007874020000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          DataField = 'RDZ_PAGINA'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_PAGINA"]')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 25.500000000000000000
        Top = 298.582870000000000000
        Width = 1662.993200000000000000
        DataSet = frxRel_M_CAT55
        DataSetName = 'frxRel_M_CAT55'
        RowCount = 0
        object frxRel_M_CAT55ECF_CODECF: TfrxMemoView
          Left = 19.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ECF_CODECF'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."ECF_CODECF"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_CPOFIM: TfrxMemoView
          Left = 403.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_CPOFIM'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_CPOFIM"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_VALDIA: TfrxMemoView
          Left = 489.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALDIA'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_VALDIA"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_TOTCNL: TfrxMemoView
          Left = 595.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTCNL'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_TOTCNL"]')
          ParentFont = False
        end
        object frxRel_M_CAT55VALOR_CONTABIL: TfrxMemoView
          Left = 739.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALOR_CONTABIL'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."VALOR_CONTABIL"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_VALOST: TfrxMemoView
          Left = 844.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_VALOST'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_VALOST"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_ISENTO: TfrxMemoView
          Left = 969.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_ISENTO'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_ISENTO"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_TOTIMP: TfrxMemoView
          Left = 1420.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_TOTIMP'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_TOTIMP"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_NUMCRZ: TfrxMemoView
          Left = 1545.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_NUMCRZ'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_NUMCRZ"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_NROCOO: TfrxMemoView
          Left = 201.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_NROCOO'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_NROCOO"]')
          ParentFont = False
        end
        object Line62: TfrxLineView
          Left = 14.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line63: TfrxLineView
          Left = 196.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line64: TfrxLineView
          Left = 312.000000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line66: TfrxLineView
          Left = 484.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line68: TfrxLineView
          Left = 590.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line69: TfrxLineView
          Left = 734.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line70: TfrxLineView
          Left = 840.000000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line71: TfrxLineView
          Left = 964.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line72: TfrxLineView
          Left = 1070.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line73: TfrxLineView
          Left = 1156.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 1243.200000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line75: TfrxLineView
          Left = 1329.600000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line76: TfrxLineView
          Left = 1416.000000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 1540.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 1636.800000000000000000
          Height = 25.322834650000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line58: TfrxLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object frxRel_M_CAT55RDZ_BASCL7: TfrxMemoView
          Left = 1075.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASCL7'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASCL7"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_BASC12: TfrxMemoView
          Left = 1161.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC12'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC12"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_BASC18: TfrxMemoView
          Left = 1248.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC18'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC18"]')
          ParentFont = False
        end
        object frxRel_M_CAT55RDZ_BASC25: TfrxMemoView
          Left = 1334.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'RDZ_BASC25'
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRel_M_CAT55."RDZ_BASC25"]')
          ParentFont = False
        end
        object Line65: TfrxLineView
          Left = 398.362204720000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object Line92: TfrxLineView
        Left = 2011.200000000000000000
        Top = 671.500000000000000000
        Height = 102.000000000000000000
        Color = clBlack
        Frame.Typ = [ftLeft]
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Top = 275.905690000000000000
        Width = 1662.993200000000000000
        Condition = 'frxRel_M_CAT55."RDZ_DTAMOV"'
        StartNewPage = True
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 132.220470000000000000
        Top = 347.716760000000000000
        Width = 1662.993200000000000000
        object Memo30: TfrxMemoView
          Left = 336.000000000000000000
          Top = 3.023622047244089000
          Width = 104.163760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAIS DO DIA')
          ParentFont = False
        end
        object Line39: TfrxLineView
          Left = 1636.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line42: TfrxLineView
          Left = 1070.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line43: TfrxLineView
          Left = 1156.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line44: TfrxLineView
          Left = 1243.200000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line45: TfrxLineView
          Left = 1329.600000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line46: TfrxLineView
          Left = 1416.000000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line47: TfrxLineView
          Left = 1540.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line79: TfrxLineView
          Left = 734.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line80: TfrxLineView
          Left = 840.000000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line81: TfrxLineView
          Left = 964.800000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo31: TfrxMemoView
          Left = 739.200000000000000000
          Top = 3.023622047244089000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."VALOR_CONTABIL">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 844.800000000000000000
          Top = 3.023622047244089000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_VALOST">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 969.600000000000000000
          Top = 3.023622047244089000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_ISENTO">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 1420.800000000000000000
          Top = 3.023622047244089000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_TOTIMP">, rlbDetalhes)]')
          ParentFont = False
        end
        object Line60: TfrxLineView
          Left = 14.400000000000000000
          Height = 25.322834645669300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line40: TfrxLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo45: TfrxMemoView
          Left = 1075.200000000000000000
          Top = 3.023622047244089000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASCL7">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1161.600000000000000000
          Top = 3.023622047244089000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC12">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 1248.000000000000000000
          Top = 3.023622047244089000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC18">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 1334.400000000000000000
          Top = 3.023622047244089000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRel_M_CAT55
          DataSetName = 'frxRel_M_CAT55'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRel_M_CAT55."RDZ_BASC25">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 297.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Line82: TfrxLineView
          Left = 657.600000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line85: TfrxLineView
          Left = 14.400000000000000000
          Top = 93.500000000000000000
          Width = 720.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line86: TfrxLineView
          Left = 14.400000000000000000
          Top = 59.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line88: TfrxLineView
          Left = 14.400000000000000000
          Top = 76.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line91: TfrxLineView
          Left = 1636.800000000000000000
          Top = 25.500000000000000000
          Height = 102.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line93: TfrxLineView
          Left = 734.400000000000000000
          Top = 93.500000000000000000
          Width = 902.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line94: TfrxLineView
          Left = 753.600000000000000000
          Top = 59.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line95: TfrxLineView
          Left = 1108.800000000000000000
          Top = 93.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo37: TfrxMemoView
          Left = 662.400000000000000000
          Top = 34.000000000000000000
          Width = 279.004700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RESPONS'#193'VEL PELO ESTABELECIMENTO:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 662.400000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NOME:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 662.400000000000000000
          Top = 102.000000000000000000
          Width = 63.420470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FUN'#199#195'O:')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 1113.600000000000000000
          Top = 102.000000000000000000
          Width = 94.261410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ASSINATURA:')
          ParentFont = False
        end
        object Line38: TfrxLineView
          Left = 14.400000000000000000
          Top = 25.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line61: TfrxLineView
          Left = 657.600000000000000000
          Top = 25.500000000000000000
          Height = 51.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line41: TfrxLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Width = 1622.400000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
