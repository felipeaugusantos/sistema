inherited frmEmiFichaCad: TfrmEmiFichaCad
  Left = 488
  Top = 367
  Width = 439
  Height = 392
  Caption = 'Emiss'#227'o de Documentos do Cliente'
  ExplicitWidth = 439
  ExplicitHeight = 392
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 321
    Width = 433
    TabOrder = 5
    ExplicitTop = 321
    ExplicitWidth = 433
    inherited FlwBotoes: TFlowPanel
      Width = 352
      ExplicitWidth = 352
    end
    inherited btnSair: TBitBtnLocked
      Left = 354
      Top = 2
      Align = alRight
      ExplicitLeft = 354
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 347
    Width = 433
    TabOrder = 6
    ExplicitTop = 347
    ExplicitWidth = 433
    inherited pnlNomeForm: TPanel
      Left = 262
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      ExplicitWidth = 262
    end
  end
  object rdgModelo: TRadioGroup [2]
    Left = 8
    Top = 8
    Width = 121
    Height = 95
    Caption = 'Modelo Documento'
    ItemIndex = 0
    Items.Strings = (
      'Em Branco'
      'Preenchido')
    TabOrder = 0
    TabStop = True
    OnEnter = rdgModeloEnter
  end
  object gpbContato: TGroupBox [3]
    Left = 8
    Top = 184
    Width = 417
    Height = 69
    TabOrder = 3
    object lblEmail: TLabel
      Left = 8
      Top = 20
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'E-mail:'
      Enabled = False
    end
    object lblContato: TLabel
      Left = 8
      Top = 44
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Contato:'
      Enabled = False
    end
    object edtEmail: TEditFocus
      Tag = 99
      Left = 56
      Top = 16
      Width = 249
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecLowerCase
      Color = 16770261
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtContato: TEditFocus
      Tag = 99
      Left = 56
      Top = 40
      Width = 249
      Height = 22
      Alignment = taLeftJustify
      Color = 16770261
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object chklstOpcoes: TCheckListBox [4]
    Left = 0
    Top = 259
    Width = 433
    Height = 62
    OnClickCheck = chklstOpcoesClickCheck
    Align = alBottom
    Columns = 2
    ItemHeight = 14
    TabOrder = 4
  end
  object rdgFormasEnvio: TRadioGroup [5]
    Left = 8
    Top = 105
    Width = 417
    Height = 72
    Caption = 'Forma de Envio:'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Impress'#227'o'
      'Enviar PDF por E-mail'
      'Enviar Word por E-mail'
      'Gerar PDF')
    TabOrder = 2
    WordWrap = True
    OnClick = rdgFormasEnvioClick
  end
  object rdgEmissao: TRadioGroup [6]
    Left = 135
    Top = 8
    Width = 290
    Height = 95
    Caption = 'Emiss'#227'o'
    ItemIndex = 0
    Items.Strings = (
      'Ficha Cadastral '
      'Ficha Cadastral e Termo de Consentimento (LGPD)'
      'Termo de Consentimento (LGPD)'
      'Termo de Consentimento Bacen')
    TabOrder = 1
    OnClick = rdgEmissaoClick
    OnExit = rdgEmissaoExit
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 324
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 88
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 152
    Top = 112
  end
  object frxExportaPDF: TfrxPDFExport
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
    Top = 96
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40277.730067083300000000
    ReportOptions.LastChange = 44439.650115104170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo139OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbC_G_C_.Text) <> '#39#39') Then'
      '    rlbC_G_C_.Text := fFormataCGCInterna(rlbC_G_C_.Text);'
      'end;'
      ''
      'procedure rlbTelCli_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCli_01.Text) <> '#39#39') Then'
      '    rlbTelCli_01.Text := fFormataFoneInterna(rlbTelCli_01.Text);'
      'end;'
      ''
      'procedure rlbTelCli_02OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCli_02.Text) <> '#39#39') Then'
      '    rlbTelCli_02.Text := fFormataFoneInterna(rlbTelCli_02.Text);'
      'end;'
      ''
      'procedure rlbFaxCli_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbFaxCli_01.Text) <> '#39#39') Then'
      '    rlbFaxCli_01.Text := fFormataFoneInterna(rlbFaxCli_01.Text);'
      'end;'
      ''
      'procedure rlbCelCli_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbCelCli_01.Text) <> '#39#39') Then'
      '    rlbCelCli_01.Text := fFormataFoneInterna(rlbCelCli_01.Text);'
      'end;'
      ''
      'procedure rlbTelCob_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCob_01.Text) <> '#39#39') Then'
      '    rlbTelCob_01.Text := fFormataFoneInterna(rlbTelCob_01.Text);'
      'end;'
      ''
      'procedure rlbTelCob_02OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCob_02.Text) <> '#39#39') Then'
      '    rlbTelCob_02.Text := fFormataFoneInterna(rlbTelCob_02.Text);'
      'end;'
      ''
      'procedure rlbTelRef_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelRef_01.Text) <> '#39#39') Then'
      '    rlbTelRef_01.Text := fFormataFoneInterna(rlbTelRef_01.Text);'
      'end;'
      ''
      'procedure rlbTelRef_02OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelRef_02.Text) <> '#39#39') Then'
      '    rlbTelRef_02.Text := fFormataFoneInterna(rlbTelRef_02.Text);'
      'end;'
      ''
      'procedure rlbTelRef_03OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelRef_03.Text) <> '#39#39') Then'
      '    rlbTelRef_03.Text := fFormataFoneInterna(rlbTelRef_03.Text);'
      'end;'
      ''
      'procedure rlbTelPro_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelPro_01.Text) <> '#39#39') Then'
      '    rlbTelPro_01.Text := fFormataFoneInterna(rlbTelPro_01.Text);'
      'end;'
      ''
      'procedure rlbTelCom_01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCom_01.Text) <> '#39#39') Then'
      '    rlbTelCom_01.Text := fFormataFoneInterna(rlbTelCom_01.Text);'
      'end;'
      ''
      'procedure rlbTelCom_02OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCom_02.Text) <> '#39#39') Then'
      '    rlbTelCom_02.Text := fFormataFoneInterna(rlbTelCom_02.Text);'
      'end;'
      ''
      'procedure rlbTelCom_03OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(rlbTelCom_03.Text) <> '#39#39') Then'
      '    rlbTelCom_03.Text := fFormataFoneInterna(rlbTelCom_03.Text);'
      'end;'
      ''
      'procedure mvTelefoneOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(mvTelefone.Text) <> '#39#39') Then'
      '    mvTelefone.Text := fFormataFoneInterna(mvTelefone.Text);'
      'end;'
      ''
      'procedure mvCelularOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(mvCelular.Text) <> '#39#39') Then'
      '    mvCelular.Text := fFormataFoneInterna(mvCelular.Text);'
      'end;'
      ''
      'procedure mvFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(mvFax.Text) <> '#39#39') Then'
      '    mvFax.Text := fFormataFoneInterna(mvFax.Text);'
      'end;'
      ''
      'procedure memSociosCGCOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  If (Trim(memSociosCGC.Text) <> '#39#39') Then'
      
        '    memSociosCGC.Text := fFormataCGCInterna(memSociosCGC.Text); ' +
        '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportJUserFunction
    Left = 372
    Top = 160
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxRelatorioAutorizacaoCompra
        DataSetName = 'frxRelatorioAutorizacaoCompra'
      end
      item
        DataSet = frxRelatorioContatos
        DataSetName = 'frxRelatorioContatos'
      end
      item
        DataSet = frxResumoFinanceiro
        DataSetName = 'frxResumoFinanceiro'
      end
      item
        DataSet = frxSocios
        DataSetName = 'frxSocios'
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
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo124: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000001000
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.897650000000000000
          Width = 748.346940000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FICHA CADASTRAL')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 491.338900000000000000
          Top = 31.236240000000000000
          Width = 260.787570000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>] - [fTime(False)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 124.724490000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.child_ResumoFinanceiro
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object subrep_Geral: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.000000000000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page3
        end
      end
      object Child_Contatos: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 215.433210000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_DadosCobrancaEntrega
        PrintChildIfInvisible = True
        object subrep_Contatos: TfrxSubreport
          Left = 2.779530000000000000
          Top = 2.220470000000006000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page10
        end
      end
      object Child_DadosCobrancaEntrega: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 260.787570000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_QuadroSocietario
        PrintChildIfInvisible = True
        object subrep_DadosCobrancaEntrega: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.440940000000000000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page4
        end
      end
      object Child_QuadroSocietario: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 306.141930000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_RefBancarias
        PrintChildIfInvisible = True
        object subrep_QuadroSocietario: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.440940000000012000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page5
        end
      end
      object Child_RefBancarias: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 351.496290000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_RefComerciais
        PrintChildIfInvisible = True
        object subrep_RefBancarias: TfrxSubreport
          Left = 2.779530000000000000
          Top = 2.220469999999978000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page6
        end
      end
      object Child_RefComerciais: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 396.850650000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_InfCrediario
        PrintChildIfInvisible = True
        object subrep_RefComerciais: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.220469999999977000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page7
        end
      end
      object Child_InfCrediario: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 442.205010000000000000
        Visible = False
        Width = 755.906000000000000000
        Child = frxReportJ.Child_Complemento
        PrintChildIfInvisible = True
        object subrep_DadosParaProtesto: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.779530000000022000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page8
        end
      end
      object Child_Complemento: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 487.559370000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.Child_AutorizacaoCompra
        PrintChildIfInvisible = True
        object subrep_Complemento: TfrxSubreport
          Left = 2.779530000000000000
          Top = 1.440940000000012000
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page9
        end
      end
      object FooterRodape: TfrxFooter
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 578.268090000000000000
        Width = 755.906000000000000000
        Stretched = True
        object Line1: TfrxLineView
          Left = 141.952722960000000000
          Top = 40.897650000000120000
          Width = 472.441250000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo243: TfrxMemoView
          Left = 141.952722960000000000
          Top = 42.677179999999910000
          Width = 472.441250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo139: TfrxMemoView
          Left = 3.779530000000000000
          Top = 59.692950000000000000
          Width = 748.346456690000000000
          Height = 30.236240000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSGROD]')
          ParentFont = False
        end
      end
      object child_ResumoFinanceiro: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 170.078850000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.Child_Contatos
        PrintChildIfInvisible = True
        object subrep_ResumoFinanceiro: TfrxSubreport
          Left = 2.645669291338580000
          Top = 0.921150000000011500
          Width = 188.976377950000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page2
        end
      end
      object Child_AutorizacaoCompra: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 532.913730000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object subrep_AutorizacaoComplemento: TfrxSubreport
          Left = 3.000000000000000000
          Top = 1.086270000000000000
          Width = 188.488250000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page11
        end
      end
    end
    object Page3: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rdbDadosGerais: TfrxMasterData
        FillType = ftBrush
        Height = 340.157455910000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Shape70: TfrxShapeView
          Top = 170.078850000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
        end
        object Shape1: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape2: TfrxShapeView
          Left = 302.362400000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape3: TfrxShapeView
          Left = 415.748300000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape4: TfrxShapeView
          Left = 529.134200000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape5: TfrxShapeView
          Left = 642.520100000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape6: TfrxShapeView
          Top = 18.897650000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
        end
        object Shape7: TfrxShapeView
          Left = 529.134200000000000000
          Top = 18.897650000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape8: TfrxShapeView
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
        end
        object Shape9: TfrxShapeView
          Top = 56.692950000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape10: TfrxShapeView
          Left = 226.771800000000000000
          Top = 56.692950000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
        end
        object Shape11: TfrxShapeView
          Left = 491.338900000000000000
          Top = 56.692950000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape12: TfrxShapeView
          Left = 566.929500000000000000
          Top = 56.692950000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape13: TfrxShapeView
          Left = 680.315400000000000000
          Top = 56.692950000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape14: TfrxShapeView
          Top = 75.590600000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape15: TfrxShapeView
          Left = 151.181200000000000000
          Top = 75.590600000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape16: TfrxShapeView
          Left = 340.157700000000000000
          Top = 75.590600000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape17: TfrxShapeView
          Left = 491.338900000000000000
          Top = 75.590600000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape18: TfrxShapeView
          Left = 642.520100000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape19: TfrxShapeView
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape20: TfrxShapeView
          Left = 151.181200000000000000
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape21: TfrxShapeView
          Left = 302.362400000000000000
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape22: TfrxShapeView
          Left = 453.543600000000000000
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape23: TfrxShapeView
          Left = 566.929500000000000000
          Top = 94.488250000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape24: TfrxShapeView
          Left = 113.385900000000000000
          Top = 94.488250000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
        end
        object Shape25: TfrxShapeView
          Left = 264.567100000000000000
          Top = 94.488250000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
        end
        object Shape26: TfrxShapeView
          Left = 415.748300000000000000
          Top = 94.488250000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
        end
        object Shape28: TfrxShapeView
          Top = 113.385900000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape29: TfrxShapeView
          Left = 188.976500000000000000
          Top = 113.385900000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape30: TfrxShapeView
          Left = 415.748300000000000000
          Top = 113.385900000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape31: TfrxShapeView
          Left = 491.338900000000000000
          Top = 113.385900000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape32: TfrxShapeView
          Left = 604.724800000000000000
          Top = 113.385900000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape33: TfrxShapeView
          Top = 132.283550000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape34: TfrxShapeView
          Left = 188.976500000000000000
          Top = 132.283550000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object Shape35: TfrxShapeView
          Left = 604.724800000000000000
          Top = 132.283550000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape36: TfrxShapeView
          Top = 151.181200000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
        end
        object Shape37: TfrxShapeView
          Left = 264.567100000000000000
          Top = 151.181200000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape38: TfrxShapeView
          Left = 491.338900000000000000
          Top = 151.181200000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
        end
        object Shape39: TfrxShapeView
          Top = 195.417440000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape40: TfrxShapeView
          Left = 302.362400000000000000
          Top = 195.417440000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape41: TfrxShapeView
          Top = 214.315090000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
        end
        object Memo1: TfrxMemoView
          Left = 303.362400000000000000
          Top = 1.000000000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 416.748300000000000000
          Top = 1.000000000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt.Cadastro')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 530.134200000000000000
          Top = 1.000000000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'lt. Altera.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 643.520100000000000000
          Top = 1.000000000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Situa'#231#227'o')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome/Raz'#227'o')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 1.000000000000000000
          Top = 38.795300000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 530.134200000000000000
          Top = 19.897650000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fantasia/Sobrenome')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1.000000000000000000
          Top = 57.692950000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 227.771800000000000000
          Top = 57.692950000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 492.338900000000000000
          Top = 57.692950000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 1.000000000000000000
          Top = 76.590600000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[R.G.]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 152.181200000000000000
          Top = 76.590600000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ/CPF]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 341.157700000000000000
          Top = 76.590600000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Insc.Est.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 492.338900000000000000
          Top = 76.590600000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Inscr.Munic./Prod.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 454.543600000000000000
          Top = 95.488250000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Celular')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 415.748300000000000000
          Top = 94.488250000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ramal')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 303.362400000000000000
          Top = 95.488250000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FAX')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 265.567100000000000000
          Top = 95.488250000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ramal')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 152.181200000000000000
          Top = 95.488250000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone 2')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 114.385900000000000000
          Top = 95.488250000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ramal')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 1.000000000000000000
          Top = 95.488250000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone 1')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 1.000000000000000000
          Top = 114.385900000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-mail')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 1.000000000000000000
          Top = 133.283550000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 189.976500000000000000
          Top = 114.385900000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Home Page')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 189.976500000000000000
          Top = 133.283550000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Representante')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 416.748300000000000000
          Top = 114.385900000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cons. Final')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 1.000000000000000000
          Top = 171.078850000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Atividade')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 492.338900000000000000
          Top = 114.385900000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Zona Franca')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 492.338900000000000000
          Top = 152.181200000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Portador')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 265.567100000000000000
          Top = 152.181200000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Forma Pagamento')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 1.000000000000000000
          Top = 152.181200000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cond. Pagamento')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 567.929500000000000000
          Top = 57.692950000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 681.315400000000000000
          Top = 57.692950000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cx.Postal')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 643.520100000000000000
          Top = 76.590600000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt.Nascimento')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 567.929500000000000000
          Top = 95.488250000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 605.724800000000000000
          Top = 114.385900000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Limite Cr'#233'dito')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 1.000000000000000000
          Top = 215.315090000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Rede de Lojas')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 1.000000000000000000
          Top = 234.212740000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS GERAIS')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 3.779530000000000000
          Top = 198.196970000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 684.094930000000000000
          Top = 6.559060000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_STATUS"]')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 52.913420000000000000
          Top = 25.456710000000000000
          Width = 472.441250000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 41.574830000000000000
          Top = 44.354360000000000000
          Width = 710.551640000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDERE"]')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 608.504330000000000000
          Top = 25.456710000000000000
          Width = 143.622140000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_FANSOB"]')
          ParentFont = False
        end
        object Memo131: TfrxMemoView
          Left = 26.456710000000000000
          Top = 63.252010000000000000
          Width = 196.535560000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_BAIRRO"]')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 257.008040000000000000
          Top = 63.252010000000000000
          Width = 196.535560000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDCLI"]')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          Left = 521.575140000000000000
          Top = 63.252010000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTCLI"]')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 597.165740000000000000
          Top = 63.252010000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##.###-###'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(Length(<frxRelatorio."CLI_C_E_P_">) > 0, FormatMaskText('#39'00' +
              '000-000;0'#39',<frxRelatorio."CLI_C_E_P_">),'#39#39')]')
          ParentFont = False
        end
        object Memo135: TfrxMemoView
          Left = 718.110700000000000000
          Top = 63.252010000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CAIPOS"]')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 691.653990000000000000
          Top = 82.149660000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NASCIM"]')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 559.370440000000000000
          Top = 82.149660000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_I_M_P_"]')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          Left = 377.953000000000000000
          Top = 82.149660000000000000
          Width = 109.606370000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_I_E_S_"]')
          ParentFont = False
        end
        object rlbC_G_C_: TfrxMemoView
          Left = 211.653680000000000000
          Top = 82.149660000000000000
          Width = 124.724490000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo139OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_C_G_C_"]')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 30.236240000000000000
          Top = 82.149660000000000000
          Width = 117.165430000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NUMR_G"]')
          ParentFont = False
        end
        object rlbTelCli_01: TfrxMemoView
          Left = 37.795300000000000000
          Top = 101.047310000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCli_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(99) 9999-9999'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_FONE01">]')
          ParentFont = False
        end
        object rlbTelCli_02: TfrxMemoView
          Left = 188.976500000000000000
          Top = 101.047310000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCli_02OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(00) 0000-0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_FONE02">]')
          ParentFont = False
        end
        object rlbFaxCli_01: TfrxMemoView
          Left = 325.039580000000000000
          Top = 101.047310000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbFaxCli_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_F_A_X_">]')
          ParentFont = False
        end
        object rlbCelCli_01: TfrxMemoView
          Left = 483.779840000000000000
          Top = 101.047310000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbCelCli_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_CELULA">]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 600.945270000000000000
          Top = 101.047310000000000000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONTAT"]')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 117.165430000000000000
          Top = 101.047310000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RAMAL1"]')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 268.346630000000000000
          Top = 101.047310000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RAMAL2"]')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 419.527830000000000000
          Top = 101.047310000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RAMAL3"]')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 665.197280000000000000
          Top = 119.944960000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_LIMCRE"]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 555.590910000000000000
          Top = 119.944960000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ZONFRA"]')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 453.543600000000000000
          Top = 119.944960000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONSUM"]')
          ParentFont = False
        end
        object Memo152: TfrxMemoView
          Left = 238.110390000000000000
          Top = 119.944960000000000000
          Width = 173.858380000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_HOMEPA"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 30.236240000000000000
          Top = 119.944960000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_EMAIL_"]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Left = 37.795300000000000000
          Top = 138.842610000000000000
          Width = 147.401670000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMVEN"]')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Left = 245.669450000000000000
          Top = 138.842610000000000000
          Width = 355.275590551181100000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMREP"]')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 41.574830000000000000
          Top = 176.637910000000000000
          Width = 706.771653543307100000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ATI_DESATI"]')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 71.811070000000000000
          Top = 157.740260000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fFormataCondPag(<frxRelatorio."CND_CNDPAG">)]')
          ParentFont = False
        end
        object Memo158: TfrxMemoView
          Left = 332.598640000000000000
          Top = 157.740260000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FPG_DESCRI"]')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 529.134200000000000000
          Top = 157.740260000000000000
          Width = 222.992270000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."POR_NOMPOR"]')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Left = 56.692950000000000000
          Top = 220.874150000000000000
          Width = 695.433520000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODRED"]')
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 336.378170000000000000
          Top = 6.559060000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CODCLI"]')
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 464.882190000000000000
          Top = 6.559060000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_DTACAD"]')
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 536.693260000000000000
          Top = 6.559060000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_DTAALT"]')
          ParentFont = False
        end
        object Memo161: TfrxMemoView
          Left = 3.779530000000000000
          Top = 247.330860000000000000
          Width = 748.346940000000000000
          Height = 86.929104570000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."CLI_OBSERV"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 605.724433860000000000
          Top = 133.283550000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Capital Social')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 665.197280000000000000
          Top = 137.842610000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CAPSOC"]')
          ParentFont = False
        end
      end
    end
    object Page4: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape43: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape44: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape45: TfrxShapeView
          Top = 18.897650000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
        end
        object Shape46: TfrxShapeView
          Left = 529.134200000000000000
          Top = 18.897650000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape47: TfrxShapeView
          Top = 37.795300000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape48: TfrxShapeView
          Left = 529.134200000000000000
          Top = 37.795300000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape49: TfrxShapeView
          Left = 226.771800000000000000
          Top = 37.795300000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape50: TfrxShapeView
          Left = 302.362400000000000000
          Top = 37.795300000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape51: TfrxShapeView
          Left = 415.748300000000000000
          Top = 37.795300000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape52: TfrxShapeView
          Top = 60.472480000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
        end
        object Shape53: TfrxShapeView
          Left = 529.134200000000000000
          Top = 60.472480000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape54: TfrxShapeView
          Top = 79.370130000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape55: TfrxShapeView
          Left = 529.134200000000000000
          Top = 79.370130000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape56: TfrxShapeView
          Left = 226.771800000000000000
          Top = 79.370130000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape57: TfrxShapeView
          Left = 302.362400000000000000
          Top = 79.370130000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape58: TfrxShapeView
          Left = 415.748300000000000000
          Top = 79.370130000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape59: TfrxShapeView
          Top = 56.692950000000000000
          Width = 755.906000000000000000
          Height = 3.779530000000000000
        end
        object Memo39: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cobran'#231'a - Endere'#231'o')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 1.000000000000000000
          Top = 38.795300000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 530.134200000000000000
          Top = 19.897650000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 227.771800000000000000
          Top = 38.795300000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 303.362400000000000000
          Top = 38.795300000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 416.748300000000000000
          Top = 38.795300000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 530.134200000000000000
          Top = 38.795300000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 1.000000000000000000
          Top = 61.472480000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Entrega - Endere'#231'o')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 1.000000000000000000
          Top = 80.370130000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 227.771800000000000000
          Top = 80.370130000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 303.362400000000000000
          Top = 80.370130000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C.E.P.')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 416.748300000000000000
          Top = 80.370130000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 530.134200000000000000
          Top = 61.472480000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 530.134200000000000000
          Top = 80.370130000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779529999999990000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DE COBRAN'#199'A / ENTREGA')
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 83.149660000000000000
          Top = 25.456710000000000000
          Width = 442.205010000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDCOB"]')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 34.015770000000000000
          Top = 44.354360000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDCOB"]')
          ParentFont = False
        end
        object Memo167: TfrxMemoView
          Left = 86.929190000000000000
          Top = 67.031540000000000000
          Width = 438.425480000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDENT"]')
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          Left = 34.015770000000000000
          Top = 85.929190000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CIDENT"]')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 257.008040000000000000
          Top = 44.354360000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTCOB"]')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 257.008040000000000000
          Top = 85.929190000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ESTENT"]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 336.378170000000000000
          Top = 44.354360000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##.###-###'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(Length(<frxRelatorio."CLI_CEPCOB">) > 0, FormatMaskText('#39'00' +
              '000-000;0'#39',<frxRelatorio."CLI_CEPCOB">),'#39#39')]')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 336.378170000000000000
          Top = 85.929190000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '##.###-###'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(Length(<frxRelatorio."CLI_CEPENT">) > 0, FormatMaskText('#39'00' +
              '000-000;0'#39',<frxRelatorio."CLI_CEPENT">),'#39#39')]')
          ParentFont = False
        end
        object rlbTelCob_01: TfrxMemoView
          Left = 453.543600000000000000
          Top = 44.354360000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCob_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_TELCOB">]')
          ParentFont = False
        end
        object rlbTelCob_02: TfrxMemoView
          Left = 453.543600000000000000
          Top = 85.929190000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCob_02OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_TELENT">]')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 563.149970000000000000
          Top = 25.456710000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_BAICOB"]')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 563.149970000000000000
          Top = 44.354360000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONCOB"]')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 563.149970000000000000
          Top = 67.031540000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_BAIENT"]')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 563.149970000000000000
          Top = 85.929190000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONENT"]')
          ParentFont = False
        end
        object Shape63: TfrxShapeView
          Top = 98.267780000000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
        end
        object Shape68: TfrxShapeView
          Left = 302.362400000000000000
          Top = 98.267780000000000000
          Width = 302.362204720000000000
          Height = 18.897650000000000000
        end
        object Shape69: TfrxShapeView
          Left = 604.724800000000000000
          Top = 98.267780000000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
        end
        object Memo54: TfrxMemoView
          Left = 605.724800000000000000
          Top = 99.267780000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Consulta')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 672.756340000000000000
          Top = 103.937007870000000000
          Width = 79.370078740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_DTCOCB"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 1.000000000000000000
          Top = 99.267780000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-mail 1:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 303.362400000000000000
          Top = 99.267780000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-mail 2:')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 37.795300000000000000
          Top = 103.826840000000000000
          Width = 260.787401570000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_EMCOB1"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 340.157700000000000000
          Top = 103.937007870000000000
          Width = 260.787401570000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_EMCOB2"]')
          ParentFont = False
        end
      end
    end
    object Page5: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape60: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape61: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Memo119: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779529999999990000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QUADRO SOCIET'#193'RIO')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 60.472480000000000000
        Width = 755.906000000000000000
        DataSet = frxSocios
        DataSetName = 'frxSocios'
        RowCount = 0
        object Shape62: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Shape64: TfrxShapeView
          Left = 302.362400000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
        end
        object Shape65: TfrxShapeView
          Left = 680.315400000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape66: TfrxShapeView
          Left = 434.645950000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape67: TfrxShapeView
          Left = 548.031850000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
        end
        object Memo53: TfrxMemoView
          Left = 1.000000000000000000
          Top = 1.000000000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome do S'#243'cio')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 303.362400000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ/CPF]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 435.645950000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nascimento')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 549.031850000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 681.315400000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Participa'#231#227'o')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          Left = 60.472480000000000000
          Top = 6.559060000000000000
          Width = 238.110390000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSocios."SCO_NOMSCO"]')
          ParentFont = False
        end
        object memSociosCGC: TfrxMemoView
          Left = 343.937230000000000000
          Top = 6.559060000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          OnAfterData = 'memSociosCGCOnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSocios."SCO_CPFCNP"]')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          Left = 480.000310000000000000
          Top = 6.559060000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxSocios."SCO_DTANAS"]')
          ParentFont = False
        end
        object Memo188: TfrxMemoView
          Left = 597.165740000000000000
          Top = 6.559060000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSocios."SCO_ESTCIV"]')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 710.551640000000000000
          Top = 6.559060000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxSocios."SCO_PER_PS"]%')
          ParentFont = False
        end
      end
    end
    object Page6: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 86.929190000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape79: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape80: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape81: TfrxShapeView
          Top = 18.897650000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Shape82: TfrxShapeView
          Left = 302.362400000000000000
          Top = 18.897650000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape83: TfrxShapeView
          Left = 415.748300000000000000
          Top = 18.897650000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape84: TfrxShapeView
          Left = 566.929500000000000000
          Top = 18.897650000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape85: TfrxShapeView
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Height = 3.779530000000000000
        end
        object Shape86: TfrxShapeView
          Top = 41.574830000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Shape87: TfrxShapeView
          Left = 302.362400000000000000
          Top = 41.574830000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape88: TfrxShapeView
          Left = 415.748300000000000000
          Top = 41.574830000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape89: TfrxShapeView
          Left = 566.929500000000000000
          Top = 41.574830000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape90: TfrxShapeView
          Top = 60.472480000000000000
          Width = 755.906000000000000000
          Height = 3.779530000000000000
        end
        object Shape91: TfrxShapeView
          Top = 64.252010000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object Shape92: TfrxShapeView
          Left = 302.362400000000000000
          Top = 64.252010000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape93: TfrxShapeView
          Left = 415.748300000000000000
          Top = 64.252010000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape94: TfrxShapeView
          Left = 566.929500000000000000
          Top = 64.252010000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Memo68: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 303.362400000000000000
          Top = 19.897650000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 416.748300000000000000
          Top = 19.897650000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 567.929500000000000000
          Top = 19.897650000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 1.000000000000000000
          Top = 42.574830000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 303.362400000000000000
          Top = 42.574830000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 416.748300000000000000
          Top = 42.574830000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 567.929500000000000000
          Top = 42.574830000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 1.000000000000000000
          Top = 65.252010000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 303.362400000000000000
          Top = 65.252010000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 416.748300000000000000
          Top = 65.252010000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 567.929500000000000000
          Top = 65.252010000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779529999999990000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'REFER'#202'NCIAS BANC'#193'RIAS')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 30.236240000000000000
          Top = 24.456710000000000000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMBC1"]')
          ParentFont = False
        end
        object Memo195: TfrxMemoView
          Left = 30.236240000000000000
          Top = 47.133890000000000000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMBC2"]')
          ParentFont = False
        end
        object Memo196: TfrxMemoView
          Left = 30.236240000000000000
          Top = 70.811070000000000000
          Width = 268.346630000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMBC3"]')
          ParentFont = False
        end
        object Memo200: TfrxMemoView
          Left = 325.039580000000000000
          Top = 25.456710000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_AGEBC1"]')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Left = 325.039580000000000000
          Top = 48.133890000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_AGEBC2"]')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Left = 325.039580000000000000
          Top = 70.811070000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_AGEBC3"]')
          ParentFont = False
        end
        object rlbTelRef_03: TfrxMemoView
          Left = 461.102660000000000000
          Top = 70.811070000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelRef_03OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELBC3">]')
          ParentFont = False
        end
        object rlbTelRef_02: TfrxMemoView
          Left = 461.102660000000000000
          Top = 48.133890000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelRef_02OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELBC2">]')
          ParentFont = False
        end
        object rlbTelRef_01: TfrxMemoView
          Left = 461.102660000000000000
          Top = 25.456710000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelRef_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELBC1">]')
          ParentFont = False
        end
        object Memo206: TfrxMemoView
          Left = 604.724800000000000000
          Top = 25.456710000000000000
          Width = 147.401670000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONBC1"]')
          ParentFont = False
        end
        object Memo207: TfrxMemoView
          Left = 604.724800000000000000
          Top = 48.133890000000000000
          Width = 147.401670000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONBC2"]')
          ParentFont = False
        end
        object Memo208: TfrxMemoView
          Left = 604.724800000000000000
          Top = 70.811070000000000000
          Width = 147.401670000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONBC3"]')
          ParentFont = False
        end
      end
    end
    object Page7: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 258.897713460000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape95: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape96: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape97: TfrxShapeView
          Top = 18.897650000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape98: TfrxShapeView
          Left = 453.362400000000000000
          Top = 18.897650000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape99: TfrxShapeView
          Left = 604.543600000000000000
          Top = 18.897650000000000000
          Width = 151.559055118110200000
          Height = 18.897650000000000000
        end
        object Shape100: TfrxShapeView
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Height = 37.795275590000000000
        end
        object Shape101: TfrxShapeView
          Top = 94.692913390000000000
          Width = 755.906000000000000000
          Height = 3.779530000000000000
        end
        object Shape102: TfrxShapeView
          Top = 98.645669290000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape103: TfrxShapeView
          Left = 453.543600000000000000
          Top = 98.645669291338570000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape104: TfrxShapeView
          Left = 604.724800000000000000
          Top = 98.645669290000000000
          Width = 151.181102360000000000
          Height = 18.897650000000000000
        end
        object Shape105: TfrxShapeView
          Top = 117.472480000000000000
          Width = 755.906000000000000000
          Height = 37.795275590551180000
        end
        object Shape106: TfrxShapeView
          Top = 174.236220472441000000
          Width = 755.906000000000000000
          Height = 3.779530000000000000
        end
        object Shape107: TfrxShapeView
          Top = 178.015748031496100000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape108: TfrxShapeView
          Left = 453.362400000000000000
          Top = 178.015748031496100000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
        end
        object Shape109: TfrxShapeView
          Left = 604.543600000000000000
          Top = 178.015748030000000000
          Width = 151.559055118110200000
          Height = 18.897650000000000000
        end
        object Shape110: TfrxShapeView
          Top = 196.913385826771600000
          Width = 755.906000000000000000
          Height = 37.795275590000000000
        end
        object Memo80: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 454.362400000000000000
          Top = 19.897650000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ/CPF]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 605.543600000000000000
          Top = 19.897650000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 1.000000000000000000
          Top = 38.795300000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 1.000000000000000000
          Top = 100.015770000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 454.543600000000000000
          Top = 100.015770000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ/CPF]')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 605.724800000000000000
          Top = 100.015770000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo87: TfrxMemoView
          Left = 1.000000000000000000
          Top = 118.472480000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 1.000000000000000000
          Top = 179.015748030000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 454.362400000000000000
          Top = 179.252010000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ/CPF]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 605.543600000000000000
          Top = 179.252010000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 1.000000000000000000
          Top = 198.149660000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779529999999990000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'REFER'#202'NCIAS COMERCIAIS')
          ParentFont = False
        end
        object Memo197: TfrxMemoView
          Left = 37.795300000000000000
          Top = 25.456710000000000000
          Width = 377.952755910000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMEM1"]')
          ParentFont = False
        end
        object Memo198: TfrxMemoView
          Left = 37.795300000000000000
          Top = 105.574830000000000000
          Width = 377.952755905511800000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMEM2"]')
          ParentFont = False
        end
        object Memo199: TfrxMemoView
          Left = 37.795300000000000000
          Top = 184.811070000000000000
          Width = 377.952755905511800000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_NOMEM3"]')
          ParentFont = False
        end
        object Memo209: TfrxMemoView
          Left = 498.716760000000000000
          Top = 25.456710000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CGCEM1"]')
          ParentFont = False
        end
        object Memo210: TfrxMemoView
          Left = 498.897960000000000000
          Top = 105.574830000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CGCEM2"]')
          ParentFont = False
        end
        object Memo211: TfrxMemoView
          Left = 498.716760000000000000
          Top = 184.811070000000000000
          Width = 102.047310000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CGCEM3"]')
          ParentFont = False
        end
        object rlbTelCom_01: TfrxMemoView
          Left = 642.338900000000000000
          Top = 25.456710000000000000
          Width = 109.606299212598400000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCom_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELEM1">]')
          ParentFont = False
        end
        object rlbTelCom_02: TfrxMemoView
          Left = 642.520100000000000000
          Top = 105.574830000000000000
          Width = 109.606299210000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCom_02OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELEM2">]')
          ParentFont = False
        end
        object rlbTelCom_03: TfrxMemoView
          Left = 642.338900000000000000
          Top = 184.811070000000000000
          Width = 109.606299212598400000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelCom_03OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."FIC_TELEM3">]')
          ParentFont = False
        end
        object Memo215: TfrxMemoView
          Left = 37.795300000000000000
          Top = 44.354360000000000000
          Width = 714.331170000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONEM1"]')
          ParentFont = False
        end
        object Memo216: TfrxMemoView
          Left = 37.795300000000000000
          Top = 124.031540000000000000
          Width = 714.330708660000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONEM2"]')
          ParentFont = False
        end
        object Memo217: TfrxMemoView
          Left = 37.795300000000000000
          Top = 203.708720000000000000
          Width = 714.330708660000000000
          Height = 26.456692910000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_CONEM3"]')
          ParentFont = False
        end
        object Shape71: TfrxShapeView
          Top = 75.795300000000000000
          Width = 109.606299212598400000
          Height = 18.897650000000000000
        end
        object Shape72: TfrxShapeView
          Left = 109.606370000000000000
          Top = 75.795300000000000000
          Width = 102.047244094488200000
          Height = 18.897650000000000000
        end
        object Shape73: TfrxShapeView
          Left = 211.212740000000000000
          Top = 75.795300000000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape74: TfrxShapeView
          Left = 320.819110000000000000
          Top = 75.795300000000000000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Shape75: TfrxShapeView
          Left = 422.425480000000000000
          Top = 75.795300000000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape76: TfrxShapeView
          Left = 634.141732280000000000
          Top = 75.795300000000000000
          Width = 121.700787401574800000
          Height = 18.897650000000000000
        end
        object Shape77: TfrxShapeView
          Left = 532.031850000000000000
          Top = 75.795300000000000000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Memo66: TfrxMemoView
          Left = 1.000000000000000000
          Top = 76.795300000000000000
          Width = 52.913385830000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Prim.Compra')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 110.606370000000000000
          Top = 76.795300000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 212.212740000000000000
          Top = 76.795300000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Maior Compra')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 321.819110000000000000
          Top = 76.795300000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo143: TfrxMemoView
          Left = 423.425480000000000000
          Top = 76.795300000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'lt. Compra')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 533.031850000000000000
          Top = 76.795300000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 635.520100000000000000
          Top = 76.795300000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Consulta')
          ParentFont = False
        end
        object Shape78: TfrxShapeView
          Top = 155.338582680000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape200: TfrxShapeView
          Left = 109.606370000000000000
          Top = 155.338582677165400000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Shape201: TfrxShapeView
          Left = 211.212740000000000000
          Top = 155.338582677165400000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape202: TfrxShapeView
          Left = 320.819110000000000000
          Top = 155.338582677165400000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Shape203: TfrxShapeView
          Left = 422.425480000000000000
          Top = 155.338582680000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape204: TfrxShapeView
          Left = 634.141732280000000000
          Top = 155.338582680000000000
          Width = 121.700787400000000000
          Height = 18.897650000000000000
        end
        object Shape205: TfrxShapeView
          Left = 532.031850000000000000
          Top = 155.338582677165400000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Memo180: TfrxMemoView
          Left = 1.000000000000000000
          Top = 157.149660000000000000
          Width = 52.913385830000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Prim.Compra')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 110.606370000000000000
          Top = 157.149660000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 212.212740000000000000
          Top = 157.149660000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Maior Compra')
          ParentFont = False
        end
        object Memo183: TfrxMemoView
          Left = 321.819110000000000000
          Top = 157.149660000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 423.425480000000000000
          Top = 157.149660000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'lt. Compra')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 533.031850000000000000
          Top = 157.149660000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo187: TfrxMemoView
          Left = 635.520100000000000000
          Top = 157.149660000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Consulta')
          ParentFont = False
        end
        object Shape206: TfrxShapeView
          Top = 234.708661417322800000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape207: TfrxShapeView
          Left = 109.606370000000000000
          Top = 234.708661417322800000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Shape208: TfrxShapeView
          Left = 211.212740000000000000
          Top = 234.708661417322800000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape209: TfrxShapeView
          Left = 320.819110000000000000
          Top = 234.708661417322800000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Shape210: TfrxShapeView
          Left = 422.425480000000000000
          Top = 234.708661417322800000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
        end
        object Shape211: TfrxShapeView
          Left = 634.141732280000000000
          Top = 234.708661417322800000
          Width = 121.700787400000000000
          Height = 18.897650000000000000
        end
        object Shape212: TfrxShapeView
          Left = 532.031850000000000000
          Top = 234.708661417322800000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
        end
        object Memo189: TfrxMemoView
          Left = 1.000000000000000000
          Top = 237.181200000000000000
          Width = 52.913385830000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Prim.Compra')
          ParentFont = False
        end
        object Memo190: TfrxMemoView
          Left = 110.606370000000000000
          Top = 237.181200000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 212.212740000000000000
          Top = 237.181200000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Maior Compra')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 321.819110000000000000
          Top = 237.181200000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          Left = 423.425480000000000000
          Top = 237.181200000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'lt. Compra')
          ParentFont = False
        end
        object Memo204: TfrxMemoView
          Left = 533.031850000000000000
          Top = 237.181200000000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo205: TfrxMemoView
          Left = 635.520100000000000000
          Top = 237.181200000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Consulta')
          ParentFont = False
        end
        object Memo212: TfrxMemoView
          Left = 52.913420000000000000
          Top = 83.354360000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAPC1"]')
          ParentFont = False
        end
        object Memo213: TfrxMemoView
          Left = 52.913420000000000000
          Top = 162.519685039370100000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAPC2"]')
          ParentFont = False
        end
        object Memo214: TfrxMemoView
          Left = 52.913420000000000000
          Top = 242.645669291338600000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAPC3"]')
          ParentFont = False
        end
        object Memo231: TfrxMemoView
          Left = 264.567100000000000000
          Top = 83.354360000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAMC1"]')
          ParentFont = False
        end
        object Memo244: TfrxMemoView
          Left = 264.567100000000000000
          Top = 162.519685039370100000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAMC2"]')
          ParentFont = False
        end
        object Memo245: TfrxMemoView
          Left = 264.567100000000000000
          Top = 242.724490000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAMC3"]')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 472.441250000000000000
          Top = 82.354360000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAUC1"]')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 472.441250000000000000
          Top = 163.275590551181100000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAUC2"]')
          ParentFont = False
        end
        object Memo249: TfrxMemoView
          Left = 472.441250000000000000
          Top = 241.724490000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTAUC3"]')
          ParentFont = False
        end
        object Memo251: TfrxMemoView
          Left = 695.433520000000000000
          Top = 81.574830000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTACO1"]')
          ParentFont = False
        end
        object Memo253: TfrxMemoView
          Left = 695.433520000000000000
          Top = 162.519685039370100000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTACO2"]')
          ParentFont = False
        end
        object Memo270: TfrxMemoView
          Left = 695.433520000000000000
          Top = 242.724490000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FIC_DTACO3"]')
          ParentFont = False
        end
        object Memo271: TfrxMemoView
          Left = 566.929500000000000000
          Top = 241.724490000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALUC3"]')
          ParentFont = False
        end
        object Memo272: TfrxMemoView
          Left = 566.929500000000000000
          Top = 161.149660000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALUC2"]')
          ParentFont = False
        end
        object Memo273: TfrxMemoView
          Left = 566.929500000000000000
          Top = 81.354360000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALUC1"]')
          ParentFont = False
        end
        object Memo274: TfrxMemoView
          Left = 355.275820000000000000
          Top = 242.724490000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALMC3"]')
          ParentFont = False
        end
        object Memo293: TfrxMemoView
          Left = 355.275820000000000000
          Top = 162.149660000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALMC2"]')
          ParentFont = False
        end
        object Memo294: TfrxMemoView
          Left = 355.275820000000000000
          Top = 82.354360000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALMC1"]')
          ParentFont = False
        end
        object Memo295: TfrxMemoView
          Left = 143.622140000000000000
          Top = 241.944960000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALPC3"]')
          ParentFont = False
        end
        object Memo296: TfrxMemoView
          Left = 143.622140000000000000
          Top = 161.370130000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALPC2"]')
          ParentFont = False
        end
        object Memo297: TfrxMemoView
          Left = 143.622140000000000000
          Top = 81.574830000000000000
          Width = 64.251973390000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FIC_VALPC1"]')
          ParentFont = False
        end
      end
    end
    object Page8: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData7: TfrxMasterData
        FillType = ftBrush
        Height = 268.207687300000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape111: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape112: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape113: TfrxShapeView
          Top = 18.897650000000000000
          Width = 377.953000000000000000
          Height = 18.897650000000000000
        end
        object Shape114: TfrxShapeView
          Left = 377.953000000000000000
          Top = 18.897650000000000000
          Width = 377.953000000000000000
          Height = 18.897650000000000000
        end
        object Shape115: TfrxShapeView
          Top = 37.795300000000000000
          Width = 377.953000000000000000
          Height = 18.897650000000000000
        end
        object Shape116: TfrxShapeView
          Left = 377.953000000000000000
          Top = 37.795300000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape117: TfrxShapeView
          Left = 472.441250000000000000
          Top = 37.795300000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape118: TfrxShapeView
          Left = 585.827150000000000000
          Top = 37.795300000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
        end
        object Shape119: TfrxShapeView
          Top = 56.692950000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape120: TfrxShapeView
          Left = 113.385900000000000000
          Top = 56.692950000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
        end
        object Shape121: TfrxShapeView
          Left = 377.953000000000000000
          Top = 56.692950000000000000
          Width = 377.953000000000000000
          Height = 18.897650000000000000
        end
        object Shape122: TfrxShapeView
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape123: TfrxShapeView
          Left = 113.385900000000000000
          Top = 75.590600000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape124: TfrxShapeView
          Left = 188.976500000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape125: TfrxShapeView
          Left = 302.362400000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape126: TfrxShapeView
          Left = 415.748300000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape127: TfrxShapeView
          Left = 529.134200000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape128: TfrxShapeView
          Left = 642.520100000000000000
          Top = 75.590600000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Memo92: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome do Pai')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 378.953000000000000000
          Top = 19.897650000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome da M'#227'e')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 1.000000000000000000
          Top = 38.795300000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome do C'#244'njuge')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 378.953000000000000000
          Top = 38.795300000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nascimento')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 473.441250000000000000
          Top = 38.795300000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado Civil')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 378.953000000000000000
          Top = 57.692950000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o Trabalho')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 114.385900000000000000
          Top = 57.692950000000000000
          Width = 79.370130000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Empresa Trabalho')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 1.000000000000000000
          Top = 57.692950000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cart. Profissional')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 1.000000000000000000
          Top = 76.590600000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 114.385900000000000000
          Top = 76.590600000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tempo Servi'#231'o')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 189.976500000000000000
          Top = 76.590600000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sal'#225'rio')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 303.362400000000000000
          Top = 76.590600000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Outras Rendas')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 416.748300000000000000
          Top = 76.590600000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Moradia')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 530.134200000000000000
          Top = 76.590600000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Aluguel')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 586.827150000000000000
          Top = 38.795300000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Profiss'#227'o')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 643.520100000000000000
          Top = 76.590600000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMA'#199#213'ES DE CREDI'#193'RIO')
          ParentFont = False
        end
        object Memo218: TfrxMemoView
          Left = 56.692950000000000000
          Top = 20.787401570000000000
          Width = 317.480520000000000000
          Height = 14.740157480000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMPAI"]')
          ParentFont = False
        end
        object Memo219: TfrxMemoView
          Left = 74.834645669291340000
          Top = 37.795275590551180000
          Width = 302.362400000000000000
          Height = 17.007874015748030000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CONJUG"]')
          ParentFont = False
        end
        object Memo220: TfrxMemoView
          Left = 438.645950000000000000
          Top = 20.787401570000000000
          Width = 313.700787400000000000
          Height = 14.740157480000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NOMMAE"]')
          ParentFont = False
        end
        object Memo221: TfrxMemoView
          Left = 623.622450000000000000
          Top = 44.354360000000000000
          Width = 128.504020000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_PROFIS"]')
          ParentFont = False
        end
        object Memo222: TfrxMemoView
          Left = 449.764070000000000000
          Top = 63.252010000000000000
          Width = 302.362400000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ENDSER"]')
          ParentFont = False
        end
        object Memo223: TfrxMemoView
          Left = 185.196970000000000000
          Top = 63.252010000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CLI_TRABAL"]')
          ParentFont = False
        end
        object Memo224: TfrxMemoView
          Left = 400.630180000000000000
          Top = 44.354360000000000000
          Width = 68.031540000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_NASCON"]')
          ParentFont = False
        end
        object Memo225: TfrxMemoView
          Left = 498.897960000000000000
          Top = 44.354360000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ESTCIV"]')
          ParentFont = False
        end
        object Memo226: TfrxMemoView
          Left = 668.976810000000000000
          Top = 82.149660000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_TOTREN"]')
          ParentFont = False
        end
        object Memo227: TfrxMemoView
          Left = 563.149970000000000000
          Top = 82.149660000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_VRALUG"]')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Left = 442.205010000000000000
          Top = 82.149660000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CASAPR"]')
          ParentFont = False
        end
        object Memo229: TfrxMemoView
          Left = 328.819110000000000000
          Top = 82.149660000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_OUTREN"]')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Left = 215.433210000000000000
          Top = 82.149660000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_SALARI"]')
          ParentFont = False
        end
        object rlbTelPro_01: TfrxMemoView
          Left = 26.456710000000000000
          Top = 82.149660000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '(##) ####-####'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_TELSER">]')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Left = 128.504020000000000000
          Top = 82.149660000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_TEMSER"]')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 26.456710000000000000
          Top = 63.252010000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_C_PROF"]')
          ParentFont = False
        end
        object Shape142: TfrxShapeView
          Top = 113.047310000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object memSexo: TfrxMemoView
          Top = 113.047310000000000000
          Width = 22.677180000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sexo')
          ParentFont = False
        end
        object Shape143: TfrxShapeView
          Left = 113.385900000000000000
          Top = 113.047310000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
        end
        object memNacionalidade: TfrxMemoView
          Left = 114.385900000000000000
          Top = 114.047310000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nacionalidade')
          ParentFont = False
        end
        object Shape144: TfrxShapeView
          Left = 415.748300000000000000
          Top = 113.047310000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
        end
        object memNaturalidade: TfrxMemoView
          Left = 416.748300000000000000
          Top = 114.047310000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Naturalidade')
          ParentFont = False
        end
        object Shape152: TfrxShapeView
          Left = 188.976500000000000000
          Top = 94.488250000000000000
          Width = 566.929500000000000000
          Height = 18.897650000000000000
        end
        object memOutrasRendas: TfrxMemoView
          Left = 189.976500000000000000
          Top = 95.488250000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Motivo Outras Rendas')
          ParentFont = False
        end
        object Shape153: TfrxShapeView
          Top = 132.283550000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
        end
        object memEscolaridade: TfrxMemoView
          Left = 1.000000000000000000
          Top = 133.283550000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Escolaridade')
          ParentFont = False
        end
        object Shape154: TfrxShapeView
          Left = 415.748300000000000000
          Top = 132.283550000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
        end
        object memAvalista: TfrxMemoView
          Left = 416.748300000000000000
          Top = 133.283550000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Avalista')
          ParentFont = False
        end
        object Shape155: TfrxShapeView
          Top = 94.488250000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object memResideQuantosAnos: TfrxMemoView
          Left = 1.000000000000000000
          Top = 95.488250000000000000
          Width = 86.929190000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Reside '#224' quantos anos')
          ParentFont = False
        end
        object Shape157: TfrxShapeView
          Top = 151.181102360000000000
          Width = 755.905511810000000000
          Height = 18.897650000000000000
        end
        object memCartoes: TfrxMemoView
          Left = 1.000000000000000000
          Top = 152.958977780000000000
          Width = 34.940341610000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cart'#245'es')
          ParentFont = False
        end
        object chkVisa: TfrxCheckBoxView
          Left = 40.368377780000000000
          Top = 154.105373710000000000
          Width = 15.934687040000000000
          Height = 12.971724070000000000
          CheckColor = clBlack
          Checked = False
          CheckStyle = csCross
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object memVisa: TfrxMemoView
          Left = 59.207093550000000000
          Top = 155.783353590000000000
          Width = 20.746793230000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Visa')
          ParentFont = False
        end
        object chkMasterCard: TfrxCheckBoxView
          Left = 85.658706450000000000
          Top = 154.105373710000000000
          Width = 15.934687040000000000
          Height = 12.971724070000000000
          CheckColor = clBlack
          Checked = False
          CheckStyle = csCross
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object memMasterCard: TfrxMemoView
          Left = 104.497422220000000000
          Top = 155.783353590000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Master Card')
          ParentFont = False
        end
        object chkHiperCard: TfrxCheckBoxView
          Left = 158.561932260000000000
          Top = 154.105373710000000000
          Width = 15.934687040000000000
          Height = 12.971724070000000000
          CheckColor = clBlack
          Checked = False
          CheckStyle = csCross
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object memHiperCard: TfrxMemoView
          Left = 177.400648030000000000
          Top = 155.783353590000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hiper Card')
          ParentFont = False
        end
        object chkAmericanExpress: TfrxCheckBoxView
          Left = 226.819996770000000000
          Top = 154.105373710000000000
          Width = 15.934687040000000000
          Height = 12.971724070000000000
          CheckColor = clBlack
          Checked = False
          CheckStyle = csCross
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object memAmericanExpress: TfrxMemoView
          Left = 245.658712540000000000
          Top = 155.783353590000000000
          Width = 68.488728710000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'American Express')
          ParentFont = False
        end
        object chkDiners: TfrxCheckBoxView
          Left = 317.787738710000000000
          Top = 154.105373710000000000
          Width = 15.934687040000000000
          Height = 12.971724070000000000
          CheckColor = clBlack
          Checked = False
          CheckStyle = csCross
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        end
        object memDiners: TfrxMemoView
          Left = 336.626454480000000000
          Top = 155.783353590000000000
          Width = 29.870489030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Diners')
          ParentFont = False
        end
        object memOutros: TfrxMemoView
          Left = 375.200000000000000000
          Top = 155.702350000000000000
          Width = 29.870489030000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Outros:')
          ParentFont = False
        end
        object Shape158: TfrxShapeView
          Top = 169.669917570000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object memBensMateriais: TfrxMemoView
          Left = 3.779530000000000000
          Top = 172.449447570000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'BENS MATERIAIS')
          ParentFont = False
        end
        object Shape162: TfrxShapeView
          Top = 188.669917570000000000
          Width = 609.831494830000000000
          Height = 18.897650000000000000
        end
        object memEndereco01: TfrxMemoView
          Left = 1.000000000000000000
          Top = 189.669917570000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Shape163: TfrxShapeView
          Top = 208.028275930000000000
          Width = 609.831494830000000000
          Height = 18.897650000000000000
        end
        object memEndereco02: TfrxMemoView
          Left = 1.000000000000000000
          Top = 209.028275930000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Shape164: TfrxShapeView
          Left = 610.285714290000000000
          Top = 188.669917570000000000
          Width = 145.700787401575000000
          Height = 18.897650000000000000
        end
        object memValorEnd01: TfrxMemoView
          Left = 611.285714290000000000
          Top = 189.669917570000000000
          Width = 30.236220470000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape165: TfrxShapeView
          Left = 610.256410260000000000
          Top = 208.028275930000000000
          Width = 145.700787401575000000
          Height = 18.897650000000000000
        end
        object memValorEnd02: TfrxMemoView
          Left = 611.256410260000000000
          Top = 208.743375640000000000
          Width = 30.236220470000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape166: TfrxShapeView
          Left = 302.362400000000000000
          Top = 169.669917570000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape169: TfrxShapeView
          Top = 226.987250290000000000
          Width = 609.831494830000000000
          Height = 18.897650000000000000
        end
        object memVeiculo: TfrxMemoView
          Left = 1.000000000000000000
          Top = 227.987250290000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ve'#237'culo')
          ParentFont = False
        end
        object Shape170: TfrxShapeView
          Left = 610.256410260000000000
          Top = 226.987250290000000000
          Width = 145.700787401575000000
          Height = 18.897650000000000000
        end
        object memValorVeiculo: TfrxMemoView
          Left = 611.256410260000000000
          Top = 227.702350000000000000
          Width = 30.236220470000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape171: TfrxShapeView
          Top = 246.102350000000000000
          Width = 755.918451350000000000
          Height = 18.897650000000000000
        end
        object memObservacoes: TfrxMemoView
          Left = 1.000000000000000000
          Top = 247.102350000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object Memo254: TfrxMemoView
          Left = 95.200000000000000000
          Top = 99.502350000000000000
          Width = 89.549660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_RESIDE">]')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 275.200000000000000000
          Top = 99.502350000000000000
          Width = 479.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_MOTOUT">]')
          ParentFont = False
        end
        object Memo256: TfrxMemoView
          Left = 24.000000000000000000
          Top = 120.302350000000000000
          Width = 83.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_SEXO__">]')
          ParentFont = False
        end
        object Memo257: TfrxMemoView
          Left = 407.200000000000000000
          Top = 155.702350000000000000
          Width = 345.549660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_OUTROS">]')
          ParentFont = False
        end
        object Memo258: TfrxMemoView
          Left = 56.000000000000000000
          Top = 194.102350000000000000
          Width = 551.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_ENDIM1">]')
          ParentFont = False
        end
        object Memo259: TfrxMemoView
          Left = 56.800000000000000000
          Top = 213.302350000000000000
          Width = 551.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_ENDIM2">]')
          ParentFont = False
        end
        object Memo260: TfrxMemoView
          Left = 56.800000000000000000
          Top = 230.902350000000000000
          Width = 551.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_VEICUL">]')
          ParentFont = False
        end
        object Memo261: TfrxMemoView
          Left = 56.800000000000000000
          Top = 248.502350000000000000
          Width = 695.949660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_OBS_FC">]')
          ParentFont = False
        end
        object Memo262: TfrxMemoView
          Left = 644.000000000000000000
          Top = 194.102350000000000000
          Width = 110.349660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_VALIM1"]')
          ParentFont = False
        end
        object Memo263: TfrxMemoView
          Left = 644.000000000000000000
          Top = 212.902350000000000000
          Width = 110.349660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_VALIM2"]')
          ParentFont = False
        end
        object Memo264: TfrxMemoView
          Left = 644.000000000000000000
          Top = 232.102350000000000000
          Width = 110.349660000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_VALVEI"]')
          ParentFont = False
        end
        object Memo265: TfrxMemoView
          Left = 176.800000000000000000
          Top = 120.302350000000000000
          Width = 235.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo266: TfrxMemoView
          Left = 468.000000000000000000
          Top = 120.302350000000000000
          Width = 284.749660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo267: TfrxMemoView
          Left = 56.000000000000000000
          Top = 137.102350000000000000
          Width = 355.149660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."CLI_ESCOLA">]')
          ParentFont = False
        end
        object Memo268: TfrxMemoView
          Left = 468.000000000000000000
          Top = 137.902350000000000000
          Width = 284.749660000000000000
          Height = 11.338590000000000000
          OnAfterData = 'rlbTelPro_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object Page9: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData8: TfrxMasterData
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.CObsCad
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape129: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape130: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape131: TfrxShapeView
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape132: TfrxShapeView
          Left = 94.488250000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape133: TfrxShapeView
          Left = 170.078850000000000000
          Top = 18.897650000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
        end
        object Shape134: TfrxShapeView
          Left = 245.669450000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape135: TfrxShapeView
          Left = 340.157700000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape136: TfrxShapeView
          Left = 434.645950000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape137: TfrxShapeView
          Left = 661.417750000000000000
          Top = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
        end
        object Shape138: TfrxShapeView
          Left = 529.134200000000000000
          Top = 18.897650000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
        end
        object Memo108: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ret'#233'm Pis e Cofins')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 95.488250000000000000
          Top = 19.897650000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ret'#233'm IRPJ')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 171.078850000000000000
          Top = 19.897650000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ret'#233'm ISS')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 246.669450000000000000
          Top = 19.897650000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Al'#237'quota ISS')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 341.157700000000000000
          Top = 19.897650000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Seguridade Social')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 435.645950000000000000
          Top = 19.897650000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #211'rg'#227'o P'#250'blico')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 530.134200000000000000
          Top = 19.897650000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tipo Desconto')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 662.417750000000000000
          Top = 19.897650000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Calcula Desc. ICMS')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779529999999990000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPLEMENTOS')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Left = 52.913420000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RETPCO"]')
          ParentFont = False
        end
        object Memo235: TfrxMemoView
          Left = 128.504020000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RETIRF"]')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Left = 204.094620000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_RETISS"]')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Left = 298.582870000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ALQISS"]')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Left = 393.071120000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_SEGSOC"]')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Left = 487.559370000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ORGPUB"]')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Left = 536.693260000000000000
          Top = 26.456710000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_ORPURD"]')
          ParentFont = False
        end
        object Memo241: TfrxMemoView
          Left = 714.331170000000000000
          Top = 25.456710000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CLI_CALICM"]')
          ParentFont = False
        end
        object Shape27: TfrxShapeView
          Top = 37.795300000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Memo242: TfrxMemoView
          Left = 3.779530000000000000
          Top = 39.685065000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES GERAIS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape139: TfrxShapeView
          Left = 302.362400000000000000
          Top = 37.795300000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
      end
      object CObsCad: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 98.267780000000000000
        Width = 755.906000000000000000
        Stretched = True
        object rllObsCad: TfrxMemoView
          Width = 755.905516690000000000
          Height = 37.795300000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[OBSCAD]')
          ParentFont = False
        end
      end
    end
    object Page10: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 116.960730000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorioContatos
        DataSetName = 'frxRelatorioContatos'
        RowCount = 0
        object Shape141: TfrxShapeView
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object Shape145: TfrxShapeView
          Left = 302.362400000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
        end
        object Shape146: TfrxShapeView
          Top = 18.897650000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
        end
        object Shape147: TfrxShapeView
          Left = 529.134200000000000000
          Top = 18.897650000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape148: TfrxShapeView
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
        end
        object Shape149: TfrxShapeView
          Top = 56.692950000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape150: TfrxShapeView
          Left = 226.771800000000000000
          Top = 56.692950000000000000
          Width = 438.425480000001000000
          Height = 18.897650000000000000
        end
        object Shape151: TfrxShapeView
          Left = 665.197280000000000000
          Top = 56.692950000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
        end
        object Shape159: TfrxShapeView
          Left = 415.748300000000000000
          Top = 75.590551180000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
        end
        object Shape160: TfrxShapeView
          Left = 536.929500000000000000
          Top = 75.590551180000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
        end
        object Shape161: TfrxShapeView
          Left = 650.417811020000000000
          Top = 75.590551180000000000
          Width = 105.448818897638000000
          Height = 18.897650000000000000
        end
        object Shape167: TfrxShapeView
          Top = 75.590551181102400000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
        end
        object Shape168: TfrxShapeView
          Left = 188.976500000000000000
          Top = 75.590551181102400000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object Shape172: TfrxShapeView
          Top = 94.283550000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
        end
        object memNome: TfrxMemoView
          Left = 1.000000000000000000
          Top = 19.897650000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object memEndereco: TfrxMemoView
          Left = 1.000000000000000000
          Top = 38.795300000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object memBairro: TfrxMemoView
          Left = 1.000000000000000000
          Top = 57.692950000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object memCidade: TfrxMemoView
          Left = 227.771800000000000000
          Top = 57.692950000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object memEstado: TfrxMemoView
          Left = 668.094930000000000000
          Top = 57.692950000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Estado')
          ParentFont = False
        end
        object memFax: TfrxMemoView
          Left = 653.110700000000000000
          Top = 76.385900000000000000
          Width = 18.897650000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FAX')
          ParentFont = False
        end
        object memCelular: TfrxMemoView
          Left = 537.929500000000000000
          Top = 76.385900000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Celular')
          ParentFont = False
        end
        object memTelefone: TfrxMemoView
          Left = 416.748300000000000000
          Top = 76.385900000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone')
          ParentFont = False
        end
        object memEmail: TfrxMemoView
          Left = 1.000000000000000000
          Top = 76.385900000000000000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E-mail')
          ParentFont = False
        end
        object memObs: TfrxMemoView
          Left = 1.000000000000000000
          Top = 95.283550000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Observa'#231#245'es')
          ParentFont = False
        end
        object memDepartamento: TfrxMemoView
          Left = 189.976500000000000000
          Top = 76.385900000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Departamento')
          ParentFont = False
        end
        object memContato: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONTATO')
          ParentFont = False
        end
        object mvCliNOme: TfrxMemoView
          Left = 28.913420000000000000
          Top = 25.456710000000000000
          Width = 495.118430000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_NOMCTT"]')
          ParentFont = False
        end
        object mvEndereco: TfrxMemoView
          Left = 43.574830000000000000
          Top = 44.354360000000000000
          Width = 706.772110000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_ENDCTT"]')
          ParentFont = False
        end
        object mvBairro: TfrxMemoView
          Left = 32.456710000000000000
          Top = 63.252010000000000000
          Width = 188.976500000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_BAICTT"]')
          ParentFont = False
        end
        object mvCidade: TfrxMemoView
          Left = 264.008040000000000000
          Top = 63.252010000000000000
          Width = 396.850650000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CID_NOMCID"]')
          ParentFont = False
        end
        object mvEstado: TfrxMemoView
          Left = 700.331170000000000000
          Top = 63.252010000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CID_ESTADO"]')
          ParentFont = False
        end
        object mvTelefone: TfrxMemoView
          Left = 454.543600000000000000
          Top = 81.944960000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          OnAfterData = 'mvTelefoneOnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorioContatos."CLI_TELCTT">]')
          ParentFont = False
        end
        object mvCelular: TfrxMemoView
          Left = 574.724800000000000000
          Top = 81.944960000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'mvCelularOnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorioContatos."CLI_CELCTT">]')
          ParentFont = False
        end
        object mvFax: TfrxMemoView
          Left = 674.787880000000000000
          Top = 81.944960000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          OnAfterData = 'mvFaxOnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorioContatos."CLI_FAXCTT">]')
          ParentFont = False
        end
        object mvDepartamento: TfrxMemoView
          Left = 249.110390000000000000
          Top = 81.944960000000000000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          OnAfterData = 'Memo293OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_DEPCTT"]')
          ParentFont = False
        end
        object mvEmail: TfrxMemoView
          Left = 30.236240000000000000
          Top = 81.944960000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_EMACTT"]')
          ParentFont = False
        end
        object mvObservacoes: TfrxMemoView
          Left = 55.795300000000000000
          Top = 100.842610000000000000
          Width = 695.433520000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_OBSERV"]')
          ParentFont = False
        end
        object memDtNasc: TfrxMemoView
          Left = 532.693260000000000000
          Top = 19.897650000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dt. Nascimento')
          ParentFont = False
        end
        object mdDtNascimento: TfrxMemoView
          Left = 598.724800000000000000
          Top = 25.456710000000000000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioContatos."CLI_NASCTT"]')
          ParentFont = False
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData9: TfrxMasterData
        FillType = ftBrush
        Height = 173.406838800000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        DataSet = frxResumoFinanceiro
        DataSetName = 'frxResumoFinanceiro'
        RowCount = 0
        object Shape174: TfrxShapeView
          Top = 19.000000000000000000
          Width = 301.606299212599000000
          Height = 18.897650000000000000
        end
        object Shape175: TfrxShapeView
          Left = 301.634200000000000000
          Top = 19.000000000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object memTotDupAberto: TfrxMemoView
          Left = 2.000000000000000000
          Top = 20.000000000000000000
          Width = 113.123376660000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Duplicatas em Aberto')
          ParentFont = False
        end
        object Memo252: TfrxMemoView
          Left = 368.283364490000000000
          Top = 23.335188780000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_ABE_QTD"]')
          ParentFont = False
        end
        object Shape173: TfrxShapeView
          Left = 528.244094490000000000
          Top = 19.000000000000000000
          Width = 227.527559055118000000
          Height = 18.897650000000000000
        end
        object memTotDupAbertoQtde: TfrxMemoView
          Left = 305.333333330000000000
          Top = 20.000000000000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object memTotDupAbertoValor: TfrxMemoView
          Left = 533.500000000000000000
          Top = 20.000000000000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape176: TfrxShapeView
          Top = 37.769016670000000000
          Width = 301.606299212599000000
          Height = 18.897637800000000000
        end
        object Shape177: TfrxShapeView
          Left = 301.634200000000000000
          Top = 37.769016670000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object memTotDupLiquidadas: TfrxMemoView
          Left = 2.000000000000000000
          Top = 39.769016670000000000
          Width = 116.456709990000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Duplicatas Liquidadas')
          ParentFont = False
        end
        object Shape178: TfrxShapeView
          Left = 528.244094490000000000
          Top = 37.769016670000000000
          Width = 227.527559055118000000
          Height = 18.897650000000000000
        end
        object memTotDupLiquidadasQtde: TfrxMemoView
          Left = 305.333333330000000000
          Top = 39.769016670000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object memTotDupLiquidadasValor: TfrxMemoView
          Left = 533.500000000000000000
          Top = 39.769016670000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape179: TfrxShapeView
          Top = 56.269016670000000000
          Width = 301.606299212599000000
          Height = 18.897650000000000000
        end
        object Shape180: TfrxShapeView
          Left = 301.467533330000000000
          Top = 56.269016670000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object memTotDupAtraso: TfrxMemoView
          Left = 1.833333330000000000
          Top = 57.269016670000000000
          Width = 113.123376660000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Duplicatas em Atraso')
          ParentFont = False
        end
        object Shape181: TfrxShapeView
          Left = 528.244094490000000000
          Top = 56.269016670000000000
          Width = 227.527559055118000000
          Height = 18.897650000000000000
        end
        object memTotDupAtrasoQtde: TfrxMemoView
          Left = 305.166666660000000000
          Top = 57.269016670000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object memTotDupAtrasoValor: TfrxMemoView
          Left = 533.333333330000000000
          Top = 57.269016670000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape182: TfrxShapeView
          Top = 75.038033340000000000
          Width = 301.606299212599000000
          Height = 18.897637800000000000
        end
        object Shape183: TfrxShapeView
          Left = 301.467533330000000000
          Top = 75.038033340000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
        end
        object memTotDupLiqAtraso: TfrxMemoView
          Left = 2.000000000000000000
          Top = 77.038033340000000000
          Width = 129.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total de Duplicatas Liq. em Atraso')
          ParentFont = False
        end
        object Shape184: TfrxShapeView
          Left = 528.244094490000000000
          Top = 75.038033340000000000
          Width = 227.527559055118000000
          Height = 18.897650000000000000
        end
        object memTotDupLiqAtrasoQtde: TfrxMemoView
          Left = 305.166666660000000000
          Top = 77.038033340000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object memTotDupLiqAtrasoValor: TfrxMemoView
          Left = 533.333333330000000000
          Top = 77.038033340000000000
          Width = 26.010513330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Shape185: TfrxShapeView
          Left = 416.307692300000000000
          Top = 114.102349990000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape186: TfrxShapeView
          Left = 246.384615380000000000
          Top = 114.102349990000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape187: TfrxShapeView
          Left = 586.826661810000000000
          Top = 114.102349990000000000
          Width = 168.944881889764000000
          Height = 18.897650000000000000
        end
        object Shape188: TfrxShapeView
          Top = 114.102362190000000000
          Width = 246.425196850000000000
          Height = 18.897637800000000000
        end
        object Shape189: TfrxShapeView
          Left = 416.307692300000000000
          Top = 133.102337810000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape190: TfrxShapeView
          Left = 246.384615380000000000
          Top = 133.102337810000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape191: TfrxShapeView
          Left = 586.826661810000000000
          Top = 133.102337810000000000
          Width = 168.944881889764000000
          Height = 18.897650000000000000
        end
        object Shape192: TfrxShapeView
          Top = 133.102350010000000000
          Width = 246.425196850000000000
          Height = 18.897637800000000000
        end
        object Shape193: TfrxShapeView
          Left = 416.307692300000000000
          Top = 152.062979930000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape194: TfrxShapeView
          Left = 246.384615380000000000
          Top = 152.062979930000000000
          Width = 170.078740160000000000
          Height = 18.897650000000000000
        end
        object Shape195: TfrxShapeView
          Left = 586.826661810000000000
          Top = 152.062979930000000000
          Width = 168.944881889764000000
          Height = 18.897650000000000000
        end
        object Shape196: TfrxShapeView
          Top = 152.062992130000000000
          Width = 246.425196850000000000
          Height = 18.897637800000000000
        end
        object memUltCompra: TfrxMemoView
          Left = 1.000000000000000000
          Top = 116.959492860000000000
          Width = 69.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #218'ltima Compra')
          ParentFont = False
        end
        object memMaiorCompra: TfrxMemoView
          Left = 1.000000000000000000
          Top = 136.388064290000000000
          Width = 69.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Maior Compra')
          ParentFont = False
        end
        object memAtrasados: TfrxMemoView
          Left = 1.000000000000000000
          Top = 156.102350000000000000
          Width = 69.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Atrasados')
          ParentFont = False
        end
        object memUltCompraData: TfrxMemoView
          Left = 248.142857140000000000
          Top = 116.959492860000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object memMaiorCompraData: TfrxMemoView
          Left = 248.142857140000000000
          Top = 136.388064290000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object memUltCompraNota: TfrxMemoView
          Left = 418.857142860000000000
          Top = 116.959492860000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N. Nota')
          ParentFont = False
        end
        object memMaiorCompraNota: TfrxMemoView
          Left = 418.857142860000000000
          Top = 136.388064290000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N. Nota')
          ParentFont = False
        end
        object memUltCompraValor: TfrxMemoView
          Left = 589.571428570000000000
          Top = 116.959492860000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object memMaiorCompraValor: TfrxMemoView
          Left = 589.571428570000000000
          Top = 136.388064290000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object memAtrasadosMedia: TfrxMemoView
          Left = 248.142857140000000000
          Top = 156.102350000000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'M'#233'dia')
          ParentFont = False
        end
        object memAtrasadosMaior: TfrxMemoView
          Left = 418.857142860000000000
          Top = 156.102350000000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Maior')
          ParentFont = False
        end
        object memAtrasadosAtual: TfrxMemoView
          Left = 589.571428570000000000
          Top = 156.102350000000000000
          Width = 31.218614760000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Atual')
          ParentFont = False
        end
        object Shape197: TfrxShapeView
          Top = 94.530921430000000000
          Width = 379.086614170000000000
          Height = 18.897637800000000000
        end
        object Shape198: TfrxShapeView
          Left = 378.952755900000000000
          Top = 94.530921430000000000
          Width = 376.818897637795000000
          Height = 18.897637800000000000
        end
        object memLimCreDisponivel: TfrxMemoView
          Left = 2.000000000000000000
          Top = 97.769016670000000000
          Width = 109.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Limite de Cr'#233'dito Dispon'#237'vel')
          ParentFont = False
        end
        object memDiasSemVenda: TfrxMemoView
          Left = 381.000000000000000000
          Top = 96.769016670000000000
          Width = 69.790043330000000000
          Height = 11.338590000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dias Sem Venda')
          ParentFont = False
        end
        object Memo275: TfrxMemoView
          Left = 598.500000000000000000
          Top = 23.335188780000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_ABE_VAL'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_ABE_VAL"]')
          ParentFont = False
        end
        object Memo276: TfrxMemoView
          Left = 368.283364490000000000
          Top = 42.102350000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_LIQ_QTD'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_LIQ_QTD"]')
          ParentFont = False
        end
        object Memo277: TfrxMemoView
          Left = 598.500000000000000000
          Top = 42.102350000000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_LIQ_VAL'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_LIQ_VAL"]')
          ParentFont = False
        end
        object Memo278: TfrxMemoView
          Left = 368.283364490000000000
          Top = 61.269016670000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_ATR_QTD'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_ATR_QTD"]')
          ParentFont = False
        end
        object Memo279: TfrxMemoView
          Left = 598.500000000000000000
          Top = 61.269016670000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_ATR_VAL'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_ATR_VAL"]')
          ParentFont = False
        end
        object Memo280: TfrxMemoView
          Left = 368.283364490000000000
          Top = 77.935683330000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_LTR_QTD'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_LTR_QTD"]')
          ParentFont = False
        end
        object Memo281: TfrxMemoView
          Left = 598.500000000000000000
          Top = 77.935683330000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'TOT_DUP_LTR_VAL'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."TOT_DUP_LTR_VAL"]')
          ParentFont = False
        end
        object Memo282: TfrxMemoView
          Left = 119.500000000000000000
          Top = 99.269016670000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'LIM_CRE_DISPONI'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."LIM_CRE_DISPONI"]')
          ParentFont = False
        end
        object Memo283: TfrxMemoView
          Left = 458.500000000000000000
          Top = 99.269016670000000000
          Width = 154.960730000000000000
          Height = 11.338590000000000000
          DataField = 'DIAS_SEM_VENDA_'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxResumoFinanceiro."DIAS_SEM_VENDA_"]')
          ParentFont = False
        end
        object Memo284: TfrxMemoView
          Left = 287.666666670000000000
          Top = 117.935683330000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ULT_COMPRA_DATA'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ULT_COMPRA_DATA"]')
          ParentFont = False
        end
        object Memo285: TfrxMemoView
          Left = 287.666666670000000000
          Top = 138.769016670000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'MAI_COMPRA_DATA'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."MAI_COMPRA_DATA"]')
          ParentFont = False
        end
        object Memo286: TfrxMemoView
          Left = 287.666666670000000000
          Top = 157.102350000000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ATRASADOS_MEDIA'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ATRASADOS_MEDIA"]')
          ParentFont = False
        end
        object Memo287: TfrxMemoView
          Left = 459.333333330000000000
          Top = 117.935683330000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ULT_COMPRA_NOTA'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ULT_COMPRA_NOTA"]')
          ParentFont = False
        end
        object Memo288: TfrxMemoView
          Left = 459.333333330000000000
          Top = 138.769016670000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'MAI_COMPRA_NOTA'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."MAI_COMPRA_NOTA"]')
          ParentFont = False
        end
        object Memo289: TfrxMemoView
          Left = 459.333333330000000000
          Top = 157.102350000000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ATRASADOS_MAIOR'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ATRASADOS_MAIOR"]')
          ParentFont = False
        end
        object Memo290: TfrxMemoView
          Left = 628.500000000000000000
          Top = 117.935683330000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ULT_COMPRA_VAL_'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ULT_COMPRA_VAL_"]')
          ParentFont = False
        end
        object Memo291: TfrxMemoView
          Left = 628.500000000000000000
          Top = 138.769016670000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'MAI_COMPRA_VAL_'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."MAI_COMPRA_VAL_"]')
          ParentFont = False
        end
        object Memo292: TfrxMemoView
          Left = 628.500000000000000000
          Top = 157.102350000000000000
          Width = 121.627396670000000000
          Height = 11.338590000000000000
          DataField = 'ATRASADOS_ATUAL'
          DataSet = frxResumoFinanceiro
          DataSetName = 'frxResumoFinanceiro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoFinanceiro."ATRASADOS_ATUAL"]')
          ParentFont = False
        end
        object Shape156: TfrxShapeView
          Top = 0.435683330000000000
          Width = 755.905511810000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object memResumoFinanceiro: TfrxMemoView
          Left = 3.612863330000000000
          Top = 2.215213330000000000
          Width = 748.346451810000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO FINANCEIRO')
          ParentFont = False
        end
      end
    end
    object Page11: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData10: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 143.622140000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorioAutorizacaoCompra
        DataSetName = 'frxRelatorioAutorizacaoCompra'
        PrintChildIfInvisible = True
        RowCount = 0
        object Memo247: TfrxMemoView
          Left = 347.716760000000000000
          Top = 0.921150000000000000
          Width = 119.811021180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorioAutorizacaoCompra."CLI_NUMR_G"]')
          ParentFont = False
        end
        object Memo250: TfrxMemoView
          Left = 473.440940000000000000
          Top = 0.921150000000000000
          Width = 118.677162910000000000
          Height = 15.118120000000000000
          OnAfterData = 'rlbTelCom_01OnAfterData'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[<frxRelatorioAutorizacaoCompra."CLI_NUMCPF">]')
          ParentFont = False
        end
        object Memo269: TfrxMemoView
          Left = 596.748280470000000000
          Top = 0.921150000000000000
          Width = 157.984249530000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioAutorizacaoCompra."CLI_ASSCTT"]')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 2.000000000000000000
          Top = 0.921150000000000000
          Width = 341.669288900000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorioAutorizacaoCompra."CLI_NOMCTT"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 0.755905511811023600
          Top = 18.897637795275590000
          Width = 755.905511811023600000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 345.826771653543300000
          Height = 18.897637795275590000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 0.755905511811023600
          Height = 18.897637795275590000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 470.551181102362200000
          Height = 18.897637795275590000
          Color = clBlack
          Diagonal = True
        end
        object Line7: TfrxLineView
          Left = 596.409448818897600000
          Height = 18.897637795275590000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 756.661417322834600000
          Height = 18.897637795275590000
          Color = clBlack
          Diagonal = True
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 5.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.Child_Cabecalho
        PrintChildIfInvisible = True
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 3.677180000000000000
        Top = 185.196970000000000000
        Width = 755.906000000000000000
        Child = frxReportJ.Child2
        PrintChildIfInvisible = True
      end
      object Child_Cabecalho: TfrxChild
        FillType = ftBrush
        Height = 70.677165354330710000
        Top = 49.133890000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object Shape140: TfrxShapeView
          Left = 1.000000000000000000
          Top = 2.007730000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          Fill.BackColor = clScrollBar
        end
        object memTitulo: TfrxMemoView
          Left = 4.779530000000000000
          Top = 4.787260000000000000
          Width = 294.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AUTORIZA'#199#195'O DE COMPRA')
          ParentFont = False
        end
        object Shape199: TfrxShapeView
          Left = 303.220470000000000000
          Top = 2.007730000000000000
          Width = 453.543307086614200000
          Height = 18.897650000000000000
        end
        object memAutorizOBSCompra: TfrxMemoView
          Left = 1.000000000000000000
          Top = 20.889610000000000000
          Width = 755.905511811023600000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            
              '              AUTORIZO a(s) pessoa(s) abaixo relacionada(s) a co' +
              'mprar mercadorias em meu nome, pelo credi'#225'rio dessa Empresa, cuj' +
              'o(s) comprovante(s) de compra(s) devidamente assinado(s) pelo(s)' +
              ' comprador(es) assumo inteira responsabilidade:')
          ParentFont = False
        end
        object memCaptionNome: TfrxMemoView
          Left = 1.000000000000000000
          Top = 55.007730000000000000
          Width = 346.362400000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOME')
          ParentFont = False
        end
        object memCaptionRG: TfrxMemoView
          Left = 345.826840000000000000
          Top = 55.007730000000000000
          Width = 124.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RG')
          ParentFont = False
        end
        object memCaptioncpf: TfrxMemoView
          Left = 469.661410000000000000
          Top = 55.007730000000000000
          Width = 126.803340000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CPF')
          ParentFont = False
        end
        object memCaptionAssinatura: TfrxMemoView
          Left = 595.929190000000000000
          Top = 55.007730000000000000
          Width = 161.007874015748000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ASSINATURA')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 77.480314960629920000
        Top = 211.653680000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object memOBSRodape: TfrxMemoView
          Left = 1.000000000000000000
          Top = 4.991960000000000000
          Width = 756.141930000000000000
          Height = 29.543290000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8W = (
            
              'A presente autoriza'#231#227'o tem validade por _______________, OU at'#233' ' +
              'minha ordem EXPRESSA em contr'#225'rio, por escrito, e torna sem efei' +
              'to eventuais autoriza'#231#245'es anteriores. O limite de cr'#233'dito autori' +
              'zado '#233' de R$ ________________ (valor por extenso)')
          ParentFont = False
        end
        object memAssinaturaRodape: TfrxMemoView
          Left = 1.000000000000000000
          Top = 35.551020000000000000
          Width = 756.141930000000000000
          Height = 42.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            
              '                                                                ' +
              '                       ______________________________________'
            
              '                                                                ' +
              '                       Nome'
            
              '                                                                ' +
              '                       CPF')
          ParentFont = False
        end
      end
    end
  end
  object qryRelatorioContatos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Left = 64
    Top = 64
  end
  object dtsRelatorioContatos: TDataSource
    DataSet = qryRelatorioContatos
    Left = 56
    Top = 208
  end
  object frxRelatorioContatos: TfrxDBDataset
    UserName = 'frxRelatorioContatos'
    CloseDataSource = False
    DataSet = qryRelatorioContatos
    BCDToCurrency = False
    Left = 64
    Top = 16
  end
  object cdsOpcoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 160
    object cdsOpcoesINDICE_LISTA: TIntegerField
      FieldName = 'INDICE_LISTA'
    end
    object cdsOpcoesNOME_ABA: TStringField
      FieldName = 'NOME_ABA'
      Size = 200
    end
    object cdsOpcoesSELECIONADO: TBooleanField
      FieldName = 'SELECIONADO'
    end
    object cdsOpcoesSIGLA: TStringField
      FieldName = 'SIGLA'
      Size = 6
    end
  end
  object cdsResumoFinanceiro: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 256
    object cdsResumoFinanceiroTOT_DUP_ABE_QTD: TIntegerField
      FieldName = 'TOT_DUP_ABE_QTD'
    end
    object cdsResumoFinanceiroTOT_DUP_ABE_VAL: TFloatField
      FieldName = 'TOT_DUP_ABE_VAL'
      currency = True
    end
    object cdsResumoFinanceiroTOT_DUP_LIQ_QTD: TIntegerField
      FieldName = 'TOT_DUP_LIQ_QTD'
    end
    object cdsResumoFinanceiroTOT_DUP_LIQ_VAL: TFloatField
      FieldName = 'TOT_DUP_LIQ_VAL'
      currency = True
    end
    object cdsResumoFinanceiroTOT_DUP_ATR_QTD: TIntegerField
      FieldName = 'TOT_DUP_ATR_QTD'
    end
    object cdsResumoFinanceiroTOT_DUP_ATR_VAL: TFloatField
      FieldName = 'TOT_DUP_ATR_VAL'
      currency = True
    end
    object cdsResumoFinanceiroTOT_DUP_LTR_QTD: TIntegerField
      FieldName = 'TOT_DUP_LTR_QTD'
    end
    object cdsResumoFinanceiroTOT_DUP_LTR_VAL: TFloatField
      FieldName = 'TOT_DUP_LTR_VAL'
      currency = True
    end
    object cdsResumoFinanceiroLIM_CRE_DISPONI: TFloatField
      FieldName = 'LIM_CRE_DISPONI'
      currency = True
    end
    object cdsResumoFinanceiroDIAS_SEM_VENDA_: TIntegerField
      FieldName = 'DIAS_SEM_VENDA_'
    end
    object cdsResumoFinanceiroULT_COMPRA_DATA: TStringField
      FieldName = 'ULT_COMPRA_DATA'
      Size = 10
    end
    object cdsResumoFinanceiroULT_COMPRA_NOTA: TStringField
      FieldName = 'ULT_COMPRA_NOTA'
      Size = 100
    end
    object cdsResumoFinanceiroULT_COMPRA_VAL_: TFloatField
      FieldName = 'ULT_COMPRA_VAL_'
      currency = True
    end
    object cdsResumoFinanceiroMAI_COMPRA_DATA: TStringField
      FieldName = 'MAI_COMPRA_DATA'
      Size = 10
    end
    object cdsResumoFinanceiroMAI_COMPRA_NOTA: TStringField
      FieldName = 'MAI_COMPRA_NOTA'
      Size = 100
    end
    object cdsResumoFinanceiroMAI_COMPRA_VAL_: TFloatField
      FieldName = 'MAI_COMPRA_VAL_'
      currency = True
    end
    object cdsResumoFinanceiroATRASADOS_MEDIA: TFloatField
      FieldName = 'ATRASADOS_MEDIA'
    end
    object cdsResumoFinanceiroATRASADOS_MAIOR: TFloatField
      FieldName = 'ATRASADOS_MAIOR'
      currency = True
    end
    object cdsResumoFinanceiroATRASADOS_ATUAL: TFloatField
      FieldName = 'ATRASADOS_ATUAL'
      currency = True
    end
  end
  object frxResumoFinanceiro: TfrxDBDataset
    UserName = 'frxResumoFinanceiro'
    CloseDataSource = False
    DataSet = cdsResumoFinanceiro
    BCDToCurrency = False
    Left = 144
    Top = 176
  end
  object qryRelatorioAutorizacaoCompra: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Left = 340
    Top = 212
  end
  object dtsRelatorioAutorizacaoCompra: TDataSource
    DataSet = qryRelatorioAutorizacaoCompra
    Left = 224
    Top = 184
  end
  object frxRelatorioAutorizacaoCompra: TfrxDBDataset
    UserName = 'frxRelatorioAutorizacaoCompra'
    CloseDataSource = False
    DataSet = qryRelatorioAutorizacaoCompra
    BCDToCurrency = False
    Left = 356
    Top = 28
  end
  object qrySocios: TUniQuery
    Connection = frmModulo.Database
    Left = 8
    Top = 144
  end
  object frxSocios: TfrxDBDataset
    UserName = 'frxSocios'
    CloseDataSource = False
    DataSet = qrySocios
    BCDToCurrency = False
    Left = 8
    Top = 192
  end
  object frxExportaWord: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 296
    Top = 164
  end
end
