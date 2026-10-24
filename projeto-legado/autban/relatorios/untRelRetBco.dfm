inherited frmRelRetBco: TfrmRelRetBco
  Left = 452
  Top = 278
  Width = 720
  Height = 302
  BorderStyle = bsNone
  Caption = 'frmRelRetBco'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 720
  ExplicitHeight = 302
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 260
    Width = 720
    ExplicitTop = 260
    ExplicitWidth = 720
    inherited FlwBotoes: TFlowPanel
      Width = 639
      ExplicitWidth = 639
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 641
      ExplicitLeft = 641
    end
  end
  inherited pnlStatus: TPanel
    Top = 286
    Width = 720
    ExplicitTop = 286
    ExplicitWidth = 720
    inherited pnlNomeForm: TPanel
      Left = 549
      ExplicitLeft = 549
    end
    inherited pnlInfo: TPanel
      Width = 549
      ExplicitWidth = 549
    end
  end
  inherited pnlDados: TPanel
    Width = 720
    Height = 260
    ExplicitWidth = 720
    ExplicitHeight = 260
    object Label1: TLabel [0]
      Left = 183
      Top = 30
      Width = 60
      Height = 14
      Caption = 'Ocorrencias'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 205
      Width = 169
      TabOrder = 3
      ExplicitLeft = 8
      ExplicitTop = 205
      ExplicitWidth = 169
      inherited edtDestino: TEditFocus
        Top = 17
        ExplicitTop = 17
      end
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 718
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Relat'#243'rio de Arq. Retorno'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
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
      Top = 81
      Width = 169
      Height = 48
      Caption = 'Mostrar dados'
      TabOrder = 1
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 23
        Width = 89
        Height = 14
        Caption = '(C)liente (A)rquivo'
        CorDestaque = clRed
      end
      object edtDados: TEditFocus
        Tag = 99
        Left = 7
        Top = 20
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object lstCodOco: TcxCheckListBox
      Tag = 99
      Left = 183
      Top = 47
      Width = 533
      Height = 203
      Items = <>
      TabOrder = 5
      OnKeyPress = lstCodOcoKeyPress
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 131
      Width = 169
      Height = 72
      Caption = 'Exibir'
      TabOrder = 2
      object ColorLabel4: TColorLabel
        Left = 105
        Top = 23
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label2: TLabel
        Left = 7
        Top = 23
        Width = 60
        Height = 14
        Caption = 'C'#243'd. Cliente:'
      end
      object lblQuebraNomeCliente: TLabel
        Left = 7
        Top = 47
        Width = 72
        Height = 14
        Caption = 'Quebrar nome:'
      end
      object ColorLabel5: TColorLabel
        Left = 105
        Top = 47
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtExibirCodCliente: TEditFocus
        Tag = 99
        Left = 81
        Top = 20
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtQuebraNomeCliente: TEditFocus
        Tag = 99
        Left = 81
        Top = 44
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 1
        Text = 'N'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 401
    Top = 58
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 369
    Top = 58
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 337
    Top = 58
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 305
    Top = 58
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 273
    Top = 58
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 209
    Top = 58
  end
  inherited frxGen: TfrxUserDataSet
    Left = 241
    Top = 58
  end
  inherited frxDesigner: TfrxDesigner
    Left = 433
    Top = 58
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 465
    Top = 58
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 16
  end
  object frxRetBco: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44776.404497118100000000
    ReportOptions.LastChange = 45798.563397557870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var strCodMot : String;'
      
        '    contReg   : Integer;                                        ' +
        '             '
      '    contRegBaix : integer;'
      '      '
      
        'procedure frxDBDatasetBcoCODOCOOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      ' Var '
      '     strBco : String;'
      '     strtpCnab : String;         '
      'begin'
      
        ' strtpCnab := <TPCNAB>;                                         ' +
        '                                         '
      ' strBco := <frxDBDatasetBco."RET_CODBCO">;'
      '  '
      '  if (strBco = '#39'001'#39') or'
      '     (strBco = '#39'748'#39') or'
      '     (strBco = '#39'237'#39') or'
      '     (strBco = '#39'077'#39') or'
      '     (strBco = '#39'097'#39') or'
      '     (strBco = '#39'341'#39') or'
      '     (strBco = '#39'033'#39') or'
      '     (strBco = '#39'756'#39') then'
      '  begin'
      ''
      '    // strText := Text;'
      
        '    // Text    := pRetornaDescricaoBeforePrint( strText, ABanco,' +
        ' Length(Text) );'
      ''
      
        '     mmOcorrencia.Text := pRetornaDescricaoBeforePrint_Rel( <frx' +
        'DBDatasetBco."CODOCO">, strBco, Length(strtpCnab) );            ' +
        '                           '
      ''
      '  end'
      '  Else'
      
        '     mmOcorrencia.Text := <frxDBDatasetBco."CODOCO"> + '#39' - '#39' + f' +
        'RetDescOco_Rel(<frxDBDatasetBco."CODOCO">);  '
      'end;'
      ''
      
        'procedure masterDataDuplicatasOnBeforePrint(Sender: TfrxComponen' +
        't);'
      'Var'
      
        '    ntop : real;                                                ' +
        '    '
      'begin'
      ''
      '  contReg := contReg + 1;    '
      '    '
      '  if ( strCodMot <> <frxDBDatasetBco."CODMOT"> ) Then'
      '  Begin'
      '    // Mostra o motivo da rejei'#231#227'o na linha de detalhe'
      '    mmCodMot.Text := <frxDBDatasetBco."CODMOT"> + '#39' '#39' +'
      '                     <frxDBDatasetBco."DESMOT">;'
      ''
      '    ntop := mmCodMot.height + 0.05;                 '
      '             '
      '    mmCliente.Top  := ntop;  '
      '    mmNossoNum.Top := ntop;    '
      '    mmCarteira.Top := ntop;    '
      '    mmNumDup.Top   := ntop;'
      '    mmEmpresa.Top  := ntop;  '
      '    mmDtVenc.Top   := ntop;  '
      '    mmDtPag.Top    := ntop;  '
      '    mmVlPago.Top   := ntop;  '
      '    mmVlJuros.Top  := ntop;'
      '    mmVlOCob.Top   := ntop;'
      '    mmVldesc.Top   := ntop;  '
      '    mmValDup.Top   := ntop;  '
      '    mmValCorr.Top  := ntop;  '
      '    mmValDif.Top   := ntop;  '
      '    masterDataDuplicatas.height := 24;'
      
        '    mmoZebra.height := 24;                                      ' +
        '            '
      '  End'
      '  Else'
      '  Begin'
      '    // N'#227'o mostra o motivo da rejei'#231#227'o na linha de detalhe'
      '    mmCodMot.Text := '#39#39';'
      ''
      '    mmCliente.Top  := 0;'
      '    mmNossoNum.Top := 0;  '
      '    mmCarteira.Top := 0;  '
      '    mmNumDup.Top   := 0;'
      '    mmEmpresa.Top  := 0;'
      '    mmDtVenc.Top   := 0;'
      '    mmDtPag.Top    := 0;'
      '    mmVlPago.Top   := 0;'
      '    mmVlJuros.Top  := 0;'
      '    mmVlOCob.Top   := 0;'
      '    mmVldesc.Top   := 0;'
      '    mmValDup.Top   := 0;'
      '    mmValCorr.Top  := 0;'
      '    mmValDif.Top   := 0;'
      '    masterDataDuplicatas.Height := 12;'
      '    mmoZebra.height := 12;        '
      '  End;'
      ''
      '  strCodMot := <frxDBDatasetBco."CODMOT">;'
      '                           '
      'end;'
      ''
      'procedure mmDescOcorrenciaOnBeforePrint(Sender: TfrxComponent);'
      ' Var '
      '     strBco : String;'
      'begin'
      '    strBco := <frxDBDatasetBco."RET_CODBCO">;'
      ''
      '    if (strBco = '#39'237'#39') then'
      '       mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO">'
      '    Else'
      '    Begin'
      
        '      if ( <frxDBDatasetOcor."MOTOCO"> <> '#39#39' ) and ( <frxDBDatas' +
        'etOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '          mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO"> +' +
        ' '#39'.'#39' + <frxDBDatasetOcor."MOTOCO">'
      '      else'
      '          mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO">;'
      '    End;'
      '                                    '
      
        '    //mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO"> + '#39' -' +
        ' '#39' + fRetDescOco_Rel(<frxDBDatasetOcor."CODOCO">);'
      ''
      'end;'
      ''
      'procedure mmDescMotOcoOnBeforePrint(Sender: TfrxComponent);'
      ' Var '
      '     strBco : String;'
      '     strtpCnab : String;         '
      'begin'
      
        '    strtpCnab := <TPCNAB>;                                      ' +
        '                                            '
      '    strBco    := <frxDBDatasetBco."RET_CODBCO">;'
      '  '
      '    if (strBco = '#39'001'#39') or'
      '       (strBco = '#39'748'#39') or'
      '       (strBco = '#39'237'#39') or'
      '       (strBco = '#39'097'#39') or'
      '       (strBco = '#39'341'#39') or'
      '       (strBco = '#39'033'#39') or'
      '       (strBco = '#39'756'#39') then'
      '    begin'
      ''
      '      if (strBco = '#39'237'#39') then'
      '      Begin'
      ''
      
        '         if (<frxDBDatasetOcor."MOTOCO"> <> '#39#39') and (<frxDBDatas' +
        'etOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '            mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <' +
        'frxDBDatasetOcor."CODOCO">, strtpCnab)+ '#39' /. '#39' +'
      
        '                                                       <frxDBDat' +
        'asetOcor."MOTOCO"> + '#39' - '#39' + RetornaOcorrencia_Rel(strBco, <frxD' +
        'BDatasetOcor."CODOCO">, strtpCnab, <frxDBDatasetOcor."MOTOCO">, ' +
        'False)'
      '         else'
      
        '            mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <' +
        'frxDBDatasetOcor."CODOCO">, strtpCnab);'
      ''
      '      End'
      '      Else'
      '      Begin'
      ''
      
        '        if (<frxDBDatasetOcor."MOTOCO"> <> '#39#39') and (<frxDBDatase' +
        'tOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '           mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <f' +
        'rxDBDatasetOcor."CODOCO">, strtpCnab, <frxDBDatasetOcor."MOTOCO"' +
        '>, False)'
      '        else'
      
        '           mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <f' +
        'rxDBDatasetOcor."CODOCO">, strtpCnab);'
      ''
      '      End;'
      ''
      '    end'
      '    else'
      
        '      mmDescMotOco.Text := fRetDescOco_Rel(<frxDBDatasetOcor."CO' +
        'DOCO">);'
      '        '
      'end;'
      ''
      'procedure MasterData4OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  contRegBaix := contRegBaix + 1;'
      'end;'
      ''
      'procedure PageFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmQtdeReg.Text := fPreencheComZerosEsquerda_Rel(intToStr(contR' +
        'eg));  '
      'end;'
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  contReg := 0;                  '
      'end;'
      ''
      'procedure PageFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    mmQtdeBaix.Text := fPreencheComZerosEsquerda_Rel(intToStr(co' +
        'ntRegBaix));  '
      'end;'
      ''
      'procedure Header3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  contRegBaix := 0;                         '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  strCodMot := '#39#39';                                              ' +
        '      '
      'end;'
      ''
      'begin'
      ''
      'end.  ')
    OnUserFunction = frxRetBcoUserFunction
    Left = 211
    Top = 118
    Datasets = <
      item
        DataSet = frxDBDatasetBco
        DataSetName = 'frxDBDatasetBco'
      end
      item
        DataSet = frxDBDataSetCodigoErroPIX
        DataSetName = 'frxDBDatasetCodigoErroPIX'
      end
      item
        DataSet = frxDBDatasetJaBaixadas
        DataSetName = 'frxDBDatasetJaBaixadas'
      end
      item
        DataSet = frxDBDatasetNaoBaix
        DataSetName = 'frxDBDatasetNaoBaix'
      end
      item
        DataSet = frxDBDatasetOcor
        DataSetName = 'frxDBDatasetOcor'
      end
      item
        DataSet = frxDBDatasetTotOcor
        DataSetName = 'frxDBDatasetTotOcor'
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
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 16.000000000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 20.881880000000000000
          Width = 400.629921260000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE DUPLICATAS DE RETORNO')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 681.732840000000000000
          Top = 23.984230000000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 1.889763779527560000
          Top = 91.000000000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 625.724800000000000000
          Top = 25.118120000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 1.889763779527560000
          Top = 71.929190000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[NOMBCO]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 689.839890000000000000
          Top = 2.425170000000000000
          Width = 84.963760000000000000
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
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 2.220470000000000000
          Width = 400.629921260000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo89: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 40.354360000000000000
          Width = 400.629921260000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
      end
      object HeaderFixo: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Frame.Typ = [ftTop, ftBottom]
        Height = 15.118120000000000000
        Top = 184.000000000000000000
        Width = 774.803650000000000000
        object Memo8: TfrxMemoView
          Left = 246.842519690000000000
          Top = 1.889763780000000000
          Width = 75.590553620000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 342.803149606299000000
          Top = 1.889763780000000000
          Width = 39.685039370078700000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VEN')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 136.511811020000000000
          Top = 1.889763780000000000
          Width = 90.708676060000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object mmlblCliente: TfrxMemoView
          Left = 1.889763780000000000
          Top = 1.889763780000000000
          Width = 133.039367640000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 319.669291340000000000
          Top = 1.889763780000000000
          Width = 22.677165350000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP.')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 430.110236220472000000
          Top = 1.889763780000000000
          Width = 52.157480314960600000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 484.535433070866000000
          Top = 1.889763780000000000
          Width = 41.574803149606300000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 612.661417322834900000
          Top = 1.889763780000000000
          Width = 52.157480314960600000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP.')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 529.133858267717000000
          Top = 1.889763780000000000
          Width = 39.685039370078700000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'O. COB')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 228.905511810000000000
          Top = 1.889763780000000000
          Width = 16.629921260000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'CT')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 385.511811023622000000
          Top = 1.889763780000000000
          Width = 40.818897637795300000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 572.220472440945000000
          Top = 1.889763780000000000
          Width = 37.795275590551200000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 667.842519685039000000
          Top = 1.889763780000000000
          Width = 52.157480314960600000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. COR')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 722.645669291339000000
          Top = 1.889763780000000000
          Width = 51.023622047244100000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DIF.')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.496062990000000000
        Top = 220.000000000000000000
        Width = 774.803650000000000000
        Condition = 'frxDBDatasetBco."CODOCO"'
        object mmOcorrencia: TfrxMemoView
          Left = 2.889763780000000000
          Top = 1.377952760000000000
          Width = 540.472790000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'frxDBDatasetBcoCODOCOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 304.000000000000000000
        Width = 774.803650000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object Memo16: TfrxMemoView
          Left = 340.866141730000000000
          Top = 0.377952760000000000
          Width = 86.929133860000000000
          Height = 12.850393700000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 430.110236220472000000
          Top = 0.377952760000000000
          Width = 52.157480314960600000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 484.535433070866000000
          Top = 0.377952760000000000
          Width = 41.574803149606300000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JURMOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo3: TfrxSysMemoView
          Left = 529.133858267717000000
          Top = 0.377952760000000000
          Width = 39.685039370078700000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."OUTVAL">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          Left = 572.220472440945000000
          Top = 0.377952760000000000
          Width = 37.795275590551200000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."DESCON">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo5: TfrxSysMemoView
          Left = 612.661417322834900000
          Top = 0.377952760000000000
          Width = 52.157480314960600000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDUP">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo6: TfrxSysMemoView
          Left = 667.842519685039000000
          Top = 0.377952760000000000
          Width = 52.157480314960600000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALCOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo7: TfrxSysMemoView
          Left = 722.645669291339000000
          Top = 0.377952760000000000
          Width = 51.023622047244100000
          Height = 12.850393700000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDIF">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 430.000000000000000000
          Top = 0.377952760000000000
          Width = 343.181073070000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object masterDataDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 29.480314960000000000
        Top = 256.000000000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'masterDataDuplicatasOnBeforePrint'
        DataSet = frxDBDatasetBco
        DataSetName = 'frxDBDatasetBco'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Left = 0.833333330000000000
          Width = 774.803650000000000000
          Height = 28.346466460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object mmcliente: TfrxMemoView
          Left = 3.023622050000000000
          Top = 15.118110240000000000
          Width = 132.283462130000000000
          Height = 11.338582680000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBco."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmNumDup: TfrxMemoView
          Left = 246.842519690000000000
          Top = 15.118110240000000000
          Width = 75.590553620000000000
          Height = 11.338582680000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBco."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmdtpag: TfrxMemoView
          Left = 385.511811023622000000
          Top = 15.118110240000000000
          Width = 40.818897637795300000
          Height = 11.338582680000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmvlPago: TfrxMemoView
          Left = 430.188976380000000000
          Top = 15.118110240000000000
          Width = 52.157480310000000000
          Height = 11.338582680000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValDup: TfrxMemoView
          Left = 612.661417322834900000
          Top = 16.118110240000000000
          Width = 52.157480314960600000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmvlJuros: TfrxMemoView
          Left = 484.614173230000000000
          Top = 15.118110240000000000
          Width = 41.574803150000000000
          Height = 11.338582680000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmEmpresa: TfrxMemoView
          Left = 321.669291340000000000
          Top = 15.118110240000000000
          Width = 18.897635350000000000
          Height = 11.338582680000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmdtVenc: TfrxMemoView
          Left = 342.803149610000000000
          Top = 15.118110240000000000
          Width = 39.685039370000000000
          Height = 11.338582680000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object mmNossoNum: TfrxMemoView
          Left = 135.511811020000000000
          Top = 15.118110240000000000
          Width = 94.488188976378000000
          Height = 11.338582680000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object mmCarteira: TfrxMemoView
          Left = 229.905511810000000000
          Top = 15.118110240000000000
          Width = 16.251966060000000000
          Height = 11.338582680000000000
          DataField = 'CARBCO'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."CARBCO"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValCorr: TfrxMemoView
          Left = 667.842519685039000000
          Top = 15.118110240000000000
          Width = 52.157480314960600000
          Height = 11.338582680000000000
          DataField = 'VALCOR'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValDif: TfrxMemoView
          Left = 722.645669290000000000
          Top = 15.118110240000000000
          Width = 51.023622050000000000
          Height = 11.338582680000000000
          DataField = 'VALDIF'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALDIF"]')
          ParentFont = False
          WordWrap = False
        end
        object mmVlOCob: TfrxMemoView
          Left = 529.212598430000000000
          Top = 15.118110240000000000
          Width = 39.685039370000000000
          Height = 11.338582680000000000
          DataField = 'OUTVAL'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."OUTVAL"]')
          ParentFont = False
          WordWrap = False
        end
        object mmVlDesc: TfrxMemoView
          Left = 572.220472440000000000
          Top = 15.118110240000000000
          Width = 37.795275590000000000
          Height = 11.338582680000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object mmCodMot: TfrxMemoView
          Left = 3.023622050000000000
          Width = 540.472790000000000000
          Height = 11.338580240000000000
          OnBeforePrint = 'frxDBDatasetBcoCODOCOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677165350000000000
        Top = 588.000000000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'PageFooter1OnBeforePrint'
        object Memo14: TfrxMemoView
          Left = 602.016080000000000000
          Top = 0.377952760000000000
          Width = 112.906926670000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGISTRO IMPRESSOS:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Top = 0.377952760000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object mmQtdeReg: TfrxSysMemoView
          Left = 717.500000000000000000
          Top = 0.377952760000000000
          Width = 55.380643330000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 17.677180000000000000
        Top = 340.000000000000000000
        Width = 774.803650000000000000
        object Memo5: TfrxMemoView
          Left = 339.866141730000000000
          Top = 0.740260000000000000
          Width = 86.929133860000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object SysMemo8: TfrxSysMemoView
          Left = 430.110236220000000000
          Top = 0.740260000000000000
          Width = 52.157480310000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo9: TfrxSysMemoView
          Left = 484.535433070866000000
          Top = 0.740260000000000000
          Width = 41.574803149606300000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JURMOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo10: TfrxSysMemoView
          Left = 529.133858267717000000
          Top = 0.740260000000000000
          Width = 39.685039370078700000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."OUTVAL">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo11: TfrxSysMemoView
          Left = 572.220472440945000000
          Top = 0.740260000000000000
          Width = 37.795275590551200000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."DESCON">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo12: TfrxSysMemoView
          Left = 612.661417322834900000
          Top = 0.740260000000000000
          Width = 52.157480314960600000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDUP">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo13: TfrxSysMemoView
          Left = 722.645669291339000000
          Top = 0.740260000000000000
          Width = 51.023622047244100000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDIF">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo14: TfrxSysMemoView
          Left = 667.842519685039000000
          Top = 0.740260000000000000
          Width = 52.157480314960600000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALCOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 25.177180000000000000
        Top = 416.000000000000000000
        Width = 774.803650000000000000
        Child = frxRetBco.Child4
        object Subreport1: TfrxSubreport
          Left = 3.779527559055120000
          Top = 1.956710000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBco.Page2
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 43.510513330000000000
        Top = 460.000000000000000000
        Width = 774.803650000000000000
        Child = frxRetBco.Child3
        PrintChildIfInvisible = True
        object Subreport2: TfrxSubreport
          Left = 3.779527560000000000
          Top = 17.682126660000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBco.Page5
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 43.464566930000000000
        Top = 524.000000000000000000
        Width = 774.803650000000000000
        object Subreport3: TfrxSubreport
          Left = 3.779527560000000000
          Top = 17.763779530000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBco.Page3
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        object Memo7: TfrxMemoView
          Left = 566.929133860000000000
          Top = 31.370078740000000000
          Width = 98.267716535433100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PAGO')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 64.251968500000000000
          Top = 31.370078740000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = -2.488188980000000000
          Top = 31.440940000000000000
          Width = 54.803147170000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 350.740157480315000000
          Top = 31.370078740000000000
          Width = 102.047244094488000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT. DUPLICATAS')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 671.244094488189100000
          Top = 31.370078740000000000
          Width = 98.267716540000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL CART'#211'RIO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baCenter
          Left = 316.535675945000000000
          Top = 3.559060000000000000
          Width = 141.732298110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGOS DE OCORR'#202'NCIAS')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 459.212598425197000000
          Top = 31.370078740000000000
          Width = 102.047244094488000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DUPLICATAS')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204724409400000
        Top = 86.929190000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDatasetOcor
        DataSetName = 'frxDBDatasetOcor'
        RowCount = 0
        object frxDBDatasetOcorQTDDUP: TfrxMemoView
          Left = 350.740157480000000000
          Top = 0.755905510000000000
          Width = 102.047244090000000000
          Height = 11.338582680000000000
          DataField = 'QTDDUP'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."QTDDUP"]')
          ParentFont = False
        end
        object frxDBDatasetOcorVALDUP: TfrxMemoView
          Left = 459.212598430000000000
          Top = 0.755905511811024000
          Width = 102.047244090000000000
          Height = 11.338582677165400000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."VALDUP"]')
          ParentFont = False
        end
        object frxDBDatasetOcorVALPAG: TfrxMemoView
          Left = 566.929133860000000000
          Top = 0.755905511811024000
          Width = 98.267716540000000000
          Height = 11.338582677165400000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."VALPAG"]')
          ParentFont = False
        end
        object frxDBDatasetOcorCUSCAR: TfrxMemoView
          Left = 671.244094490000000000
          Top = 0.755905511811024000
          Width = 98.267716540000000000
          Height = 11.338582677165400000
          DataField = 'CUSCAR'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."CUSCAR"]')
          ParentFont = False
        end
        object mmDescOcorrencia: TfrxMemoView
          Left = 3.023622050000000000
          Top = 0.755905510000000000
          Width = 58.582677170000000000
          Height = 11.338582680000000000
          OnBeforePrint = 'mmDescOcorrenciaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmDescMotOco: TfrxMemoView
          Left = 64.251968500000000000
          Top = 0.755905510000000000
          Width = 279.685220000000000000
          Height = 11.338582680000000000
          OnBeforePrint = 'mmDescMotOcoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 162.519790000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDatasetTotOcor
        DataSetName = 'frxDBDatasetTotOcor'
        RowCount = 0
        object Memo17: TfrxMemoView
          Left = 192.574803150000000000
          Top = 1.889763780000000000
          Width = 153.070866140000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DUPLICATAS :')
          ParentFont = False
        end
        object frxDBDatasetTotOcorQTDDUP: TfrxMemoView
          Left = 350.740157480000000000
          Top = 1.889763780000000000
          Width = 102.047244090000000000
          Height = 11.338582680000000000
          DataField = 'QTDDUP'
          DataSet = frxDBDatasetTotOcor
          DataSetName = 'frxDBDatasetTotOcor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetTotOcor."QTDDUP"]')
          ParentFont = False
        end
        object frxDBDatasetTotOcorVALDUP: TfrxMemoView
          Left = 459.212598430000000000
          Top = 1.889763779527560000
          Width = 102.047244090000000000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetTotOcor
          DataSetName = 'frxDBDatasetTotOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetTotOcor."VALDUP"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 124.724490000000000000
        Width = 774.803650000000000000
        AllowSplit = True
        object Memo10: TfrxMemoView
          Left = 191.015743150000000000
          Top = 2.267716540000000000
          Width = 153.070866140000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'TOTAL GERAL OCORR'#202'NCIAS :')
          ParentFont = False
        end
        object SysMemo15: TfrxSysMemoView
          Left = 350.740157480000000000
          Top = 2.267716540000000000
          Width = 102.047244090000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."QTDDUP">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo16: TfrxSysMemoView
          Left = 459.212598430000000000
          Top = 2.267716535433070000
          Width = 102.047244090000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."VALDUP">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo17: TfrxSysMemoView
          Left = 566.929133860000000000
          Top = 2.267716535433070000
          Width = 98.267716540000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."VALPAG_COMTAR">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo19: TfrxSysMemoView
          Left = 671.244094490000000000
          Top = 2.267716535433070000
          Width = 98.267716540000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."CUSCAR">,MasterData1)]')
          ParentFont = False
        end
      end
    end
    object Page5: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 14.362204720000000000
        Top = 109.606370000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDatasetNaoBaix
        DataSetName = 'frxDBDatasetNaoBaix'
        RowCount = 0
        object Memo91: TfrxMemoView
          Left = 1.779530000000000000
          Top = 0.377952760000000000
          Width = 173.858145670000000000
          Height = 12.094488190000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 354.944881890000000000
          Top = 0.377952760000000000
          Width = 79.370078740000000000
          Height = 12.094488188976400000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 525.645950000000000000
          Top = 0.377952760000000000
          Width = 45.354330710000000000
          Height = 12.094488188976400000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo94: TfrxMemoView
          Left = 575.496062990000000000
          Top = 0.377952760000000000
          Width = 52.913373620000000000
          Height = 12.094488188976400000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo95: TfrxMemoView
          Left = 721.488188980000000000
          Top = 0.377952760000000000
          Width = 52.913373620000000000
          Height = 12.094488190000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo96: TfrxMemoView
          Left = 631.157480310000000000
          Top = 0.377952760000000000
          Width = 39.685022280000000000
          Height = 12.094488190000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo97: TfrxMemoView
          Left = 276.173228350000000000
          Top = 0.377952760000000000
          Width = 75.590548740000000000
          Height = 12.094488188976400000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo98: TfrxMemoView
          Left = 674.078740160000000000
          Top = 0.377952760000000000
          Width = 43.464552280000000000
          Height = 12.094488190000000000
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo99: TfrxMemoView
          Left = 178.944881890000000000
          Top = 0.377952760000000000
          Width = 92.598422760000000000
          Height = 12.094488188976400000
          DataField = 'MOTDIV'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."MOTDIV"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo100: TfrxMemoView
          Left = 466.724409450000000000
          Top = 0.377952760000000000
          Width = 56.692913390000000000
          Height = 12.094488188976400000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo101: TfrxMemoView
          Left = 436.370440000000000000
          Top = 0.377952760000000000
          Width = 26.456692910000000000
          Height = 12.094488188976400000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        Child = frxRetBco.Child1
        object Memo102: TfrxMemoView
          Align = baCenter
          Left = 314.645910945000000000
          Top = 7.559060000000000000
          Width = 145.511828110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'DUPLICATAS N'#195'O BAIXADAS')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clSilver
        Frame.Typ = [ftTop, ftBottom]
        Height = 15.118110240000000000
        Top = 71.811070000000000000
        Width = 774.803650000000000000
        object Memo103: TfrxMemoView
          Left = 353.944881890000000000
          Top = 1.889763780000000000
          Width = 79.370078740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 466.724409450000000000
          Top = 1.889763780000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 275.173228350000000000
          Top = 1.889763780000000000
          Width = 75.590548740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Left = 2.440940000000000000
          Top = 1.889763780000000000
          Width = 173.858145670000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 436.338900000000000000
          Top = 1.889763780000000000
          Width = 26.456692910000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 574.496062990000000000
          Top = 1.889763780000000000
          Width = 52.913373620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 630.157480310000000000
          Top = 1.889763780000000000
          Width = 39.685022280000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 720.488188980000000000
          Top = 1.889763780000000000
          Width = 52.913373620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP.')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 525.291590000000000000
          Top = 1.889763780000000000
          Width = 45.354330710000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG.')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 673.078740160000000000
          Top = 1.889763780000000000
          Width = 43.464552280000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 178.944881890000000000
          Top = 1.889763780000000000
          Width = 92.598422760000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'MOTIVO')
          ParentFont = False
        end
      end
    end
    object Page4: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 15.496062990000000000
        Top = 192.756030000000000000
        Width = 774.803650000000000000
        OnAfterPrint = 'MasterData4OnAfterPrint'
        OnBeforePrint = 'MasterData4OnBeforePrint'
        DataSet = frxDBDatasetJaBaixadas
        DataSetName = 'frxDBDatasetJaBaixadas'
        RowCount = 0
        object mmoZebraRet: TfrxMemoView
          Left = -1.000000000000000000
          Width = 777.661720000000000000
          Height = 15.496062990000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 0.377952760000000000
          Top = 1.133858270000000000
          Width = 159.968503940000000000
          Height = 12.094488190000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 351.779527560000000000
          Top = 1.133858270000000000
          Width = 79.370076300000000000
          Height = 12.094488190000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 505.417322830000000000
          Top = 1.133858270000000000
          Width = 41.574803150000000000
          Height = 12.094488190000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 551.267716540000000000
          Top = 1.133858270000000000
          Width = 49.133846060000000000
          Height = 12.094488190000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 727.582677170000000000
          Top = 1.133858270000000000
          Width = 45.354316060000000000
          Height = 12.094488190000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 603.456692910000000000
          Top = 1.133858270000000000
          Width = 39.685029610000000000
          Height = 12.094488190000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 270.614173228347000000
          Top = 1.133858270000000000
          Width = 78.614173230000000000
          Height = 12.094488190000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 645.661417320000000000
          Top = 1.133858270000000000
          Width = 39.685029610000000000
          Height = 12.094488190000000000
          DataField = 'OUTVAL'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."OUTVAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          Left = 174.157480310000000000
          Top = 1.133858270000000000
          Width = 60.472440944881890000
          Height = 12.094488190000000000
          DataField = 'CEPCLI'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo63: TfrxMemoView
          Left = 459.968770000000000000
          Top = 1.133858270000000000
          Width = 41.574803150000000000
          Height = 12.094488190000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 433.133858267717000000
          Top = 1.133858270000000000
          Width = 26.456710000000000000
          Height = 12.094488190000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 688.244094490000000000
          Top = 1.133858270000000000
          Width = 35.905499610000000000
          Height = 12.094488190000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 237.724411890000000000
          Top = 1.133858270000000000
          Width = 30.236225350000000000
          Height = 12.094488190000000000
          DataField = 'CODOCO'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODOCO"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 109.606299210000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'Header3OnBeforePrint'
        Child = frxRetBco.Child2
        object Memo65: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 20.897650000000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATAS J'#193' BAIXADAS QUE CONSTAVAM NO ARQUIVO RETORNO')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 0.779530000000000000
          Top = 70.692950000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[NOMBCOBAIX]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 0.779530000000000000
          Top = 90.590600000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 2.267716540000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo80: TfrxMemoView
          Left = 682.031850000000000000
          Top = 23.811023620000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 624.511593780000000000
          Top = 24.944881890000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Align = baRight
          Left = 689.839890000000000000
          Top = 2.267716540000000000
          Width = 84.963760000000000000
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
        object Memo83: TfrxMemoView
          Align = baCenter
          Left = 187.086864370000000000
          Top = 39.795300000000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
      end
      object ReportJaBaixadas: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 268.346630000000000000
        Visible = False
        Width = 774.803650000000000000
        object Memo84: TfrxMemoView
          Left = 378.433520000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object SysMemo20: TfrxSysMemoView
          Left = 426.811006540000000000
          Top = 3.779530000000000000
          Width = 94.488206060000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."VALPAG">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo21: TfrxSysMemoView
          Left = 525.456692910000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 13.228346456692900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."JURMOR">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo22: TfrxSysMemoView
          Left = 583.661417320000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 13.228346456692900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."OUTVAL">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo23: TfrxSysMemoView
          Left = 642.244094490000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 13.228346456692900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."DESCON">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo24: TfrxSysMemoView
          Left = 701.582677170000000000
          Top = 3.779530000000000000
          Width = 68.031496060000000000
          Height = 13.228346456692900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."VALDUP">,MasterData4)]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clScrollBar
        Frame.Typ = [ftTop, ftBottom]
        Height = 18.897640240000000000
        Top = 151.181200000000000000
        Width = 774.803650000000000000
        object Memo66: TfrxMemoView
          Left = 351.779527560000000000
          Top = 3.023622050000000000
          Width = 79.370076300000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 460.700990000000000000
          Top = 3.023622050000000000
          Width = 41.574803150000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VEN')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 270.614173228347000000
          Top = 3.023622050000000000
          Width = 78.614173230000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 0.377952760000000000
          Top = 3.023622050000000000
          Width = 171.968398980000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 433.133858267717000000
          Top = 3.023622050000000000
          Width = 24.566929130000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 551.267716540000000000
          Top = 3.023622050000000000
          Width = 49.133846060000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 603.456692910000000000
          Top = 3.023622050000000000
          Width = 39.685029610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 727.448818900000000000
          Top = 3.023622050000000000
          Width = 45.354316060000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 505.417322830000000000
          Top = 3.023622050000000000
          Width = 41.574803150000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 688.244094490000000000
          Top = 3.023622050000000000
          Width = 35.905499610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 174.157480310000000000
          Top = 3.023622050000000000
          Width = 60.472440944881890000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 237.724411890000000000
          Top = 3.023622050000000000
          Width = 30.236225350000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OC.')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 645.661417320000000000
          Top = 3.023622050000000000
          Width = 39.685029610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'O. COB.')
          ParentFont = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677180000000000000
        Top = 313.700990000000000000
        Width = 774.803650000000000000
        OnBeforePrint = 'PageFooter2OnBeforePrint'
        object Memo26: TfrxMemoView
          Left = 598.516080000000000000
          Top = 0.377952760000000000
          Width = 112.906926670000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGISTRO IMPRESSOS:')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 2.500000000000000000
          Top = 0.377952755905512000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object mmQtdeBaix: TfrxSysMemoView
          Left = 714.000000000000000000
          Top = 0.377952760000000000
          Width = 55.380643330000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
    end
    object Page3: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        Child = frxRetBco.Child5
        object Memo27: TfrxMemoView
          Left = 314.834645670000000000
          Top = 7.559055120000000000
          Width = 105.826840000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO DE ERRO PIX')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 22.677180000000000000
        Top = 71.811070000000000000
        Width = 774.803650000000000000
        object Memo28: TfrxMemoView
          Left = 365.858380000000000000
          Top = 3.779530000000000000
          Width = 79.370078740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 597.637907560000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 287.086726460000000000
          Top = 3.779530000000000000
          Width = 75.590548740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 567.252398110000000000
          Top = 3.779530000000000000
          Width = 26.456692910000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 715.401687090000000000
          Top = 3.779530000000000000
          Width = 52.913373620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP.')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 656.205088110000000000
          Top = 3.779530000000000000
          Width = 56.692920710000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. CAD.')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 3.559060000000000000
          Top = 3.779530000000000000
          Width = 62.362182760000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'COD. ERRO')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 449.244280000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 510.252400550000000000
          Top = 3.779530000000000000
          Width = 52.913390710000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EPS. DOC.')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 71.811070000000000000
          Top = 3.779530000000000000
          Width = 62.362182760000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 166.299320000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDataSetCodigoErroPIX
        DataSetName = 'frxDBDatasetCodigoErroPIX'
        RowCount = 0
        object Memo33: TfrxMemoView
          Left = 3.401574800000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 11.338582680000000000
          DataField = 'ERRPIX'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."ERRPIX"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 287.188976380000000000
          Top = 3.779530000000000000
          Width = 75.590551180000000000
          Height = 11.338582680000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."NOSNUM"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 365.803149610000000000
          Top = 3.779530000000000000
          Width = 79.370078740000000000
          Height = 11.338582680000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."NUMDUP"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 567.196850390000000000
          Top = 3.779530000000000000
          Width = 26.456692910000000000
          Height = 11.338582680000000000
          DataField = 'CODEMP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."CODEMP"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 597.811023620000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DTAVEN"]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 715.464566930000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."VALDUP"]')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 449.062992130000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          DataField = 'PARCEL'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."PARCEL"]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 510.291338580000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 11.338582680000000000
          DataField = 'ESPDOC'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."ESPDOC"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 71.811070000000000000
          Top = 3.779530000000000000
          Width = 209.763874720000000000
          Height = 11.338582680000000000
          DataField = 'CLIENTE'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."CLIENTE"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 656.196850390000000000
          Top = 3.779530000000000000
          Width = 56.692913385826770000
          Height = 11.338582680000000000
          DataField = 'DTACAD'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DTACAD"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 117.165430000000000000
        Width = 774.803650000000000000
        Condition = 'frxDBDatasetCodigoErroPIX."ERRPIX"'
        KeepTogether = True
        object Memo49: TfrxMemoView
          Left = 3.401574800000000000
          Top = 3.779530000000000000
          Width = 765.354650470000000000
          Height = 15.118110240000000000
          DataField = 'DESCRICAO_ERRPIX'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DESCRICAO_ERRPIX"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDatasetBco: TfrxDBDataset
    UserName = 'frxDBDatasetBco'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'NOSNUM=NOSNUM'
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'DTAVEN=DTAVEN'
      'DTAPAG=DTAPAG'
      'VALPAG=VALPAG'
      'JURMOR=JURMOR'
      'DESCON=DESCON'
      'RET_CODREJ=RET_CODREJ'
      'RET_CODBCO=RET_CODBCO'
      'OUTVAL=OUTVAL'
      'VALDUP=VALDUP'
      'CARTEI=CARTEI'
      'TARIFA=TARIFA'
      'CODCLI=CODCLI'
      'DTARET=DTARET'
      'NOMARQ=NOMARQ'
      'CEPCLI=CEPCLI'
      'CTR_DTAVEN=CTR_DTAVEN'
      'CTR_VALORI=CTR_VALORI'
      'CTR_VALDUP=CTR_VALDUP'
      'VALCOR=VALCOR'
      'CTR_DESSUJ=CTR_DESSUJ'
      'VALDIF=VALDIF'
      'CODMOT=CODMOT'
      'DESMOT=DESMOT'
      'CUSCAR=CUSCAR'
      'CARBCO=CARBCO'
      'IOFDES=IOFDES'
      'TXADES=TXADES'
      'JUROPE=JUROPE'
      'VL_TARIFA=VL_TARIFA'
      'VALPAG_COMTAR=VALPAG_COMTAR'
      'VAL_CRED=VAL_CRED'
      'CTR_VALREC=CTR_VALREC')
    DataSet = cdsRetBco
    BCDToCurrency = False
    Left = 284
    Top = 118
  end
  object qryRetBco: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      ''
      ''
      
        'SELECT IF(RET_MOTOCO <> '#39'00'#39' AND RET_CODBCO IN (SELECT DISTINCT(' +
        'OCO_CODBCO) FROM OCOBAN), '
      
        '       CONCAT(RET_CODOCO, '#39'.'#39', RET_MOTOCO), RET_CODOCO) AS CODOC' +
        'O, '
      
        '       RET_NOSNUM AS NOSNUM,                                    ' +
        ' '
      
        '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP,                 ' +
        ' '
      
        '       RET_CODEMP AS CODEMP,                                    ' +
        ' '
      
        '       RET_DTAVEN AS DTAVEN,                                    ' +
        ' '
      
        '       IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, R' +
        'ET_DTAOCO),NULL) AS DTAPAG, '
      
        '       RET_VALPAG AS VALPAG,                                    ' +
        ' '
      
        '       RET_JURMOR AS JURMOR,                                    ' +
        ' '
      
        '       RET_DESCON AS DESCON,                                    ' +
        ' '
      
        '       RET_CODREJ,                                              ' +
        ' '
      
        '       RET_CODBCO,                                              ' +
        ' '
      
        '       RET_OUTVAL AS OUTVAL,                                    ' +
        ' '
      
        '       RET_VALDUP AS VALDUP,                                    ' +
        ' '
      
        '       RET_CARTEI AS CARTEI,                                    ' +
        ' '
      
        '       IFNULL(RET_TARIFA, 0.00) AS TARIFA,                      ' +
        ' '
      '       CONCAT(RET_CODCLI, '#39'-'#39', CLI_NOMCLI) AS CODCLI,'
      
        '       MAX(DET.DET_DTARET) AS DTARET,                           ' +
        '      '
      
        '       CONCAT(RET_NOMARQ, '#39' - '#39', RET_DTAARQ, '#39' - '#39', RET_HORARQ) ' +
        'AS NOMARQ, '
      
        '       CLI_C_E_P_ AS CEPCLI,                                    ' +
        ' '
      
        '       R.CTR_DTAVEN,                                            ' +
        ' '
      
        '       R.CTR_VALORI,                                            ' +
        ' '
      
        '       R.CTR_VALDUP, 0.00 AS VALCOR, IFNULL(R.CTR_DESSUJ,0.00) A' +
        'S CTR_DESSUJ, '
      '       0.00 AS VALDIF,'
      
        '       IFNULL(R.CTR_VALREC, 0.00) AS CTR_VALREC,                ' +
        ' '
      
        '       MOT_CODMOT CODMOT,                                       ' +
        ' '
      
        '       MOT_DESMOT DESMOT,                                       ' +
        ' '
      
        '       RET_CUSCAR AS CUSCAR,                                    ' +
        ' '
      
        '       RET_CARBCO AS CARBCO,                                    ' +
        ' '
      
        '       RET_IOFDES AS IOFDES,                                    ' +
        ' '
      
        '       RET_TXADES AS TXADES,                                    ' +
        ' '
      '       RET_JUROPE AS JUROPE,'
      
        '       IF(RET_CUSCAR > 0, RET_CUSCAR, IFNULL(RET_TARIFA, 0.00)) ' +
        'VL_TARIFA,'
      
        '       IF(RET_VALPAG <> 0, (RET_VALPAG + RET_TARIFA), 0) VALPAG_' +
        'COMTAR,'
      
        '       IF(RET_TXADES > 0,(((RET_VALDUP - RET_TARIFA) - RET_IOFDE' +
        'S) - RET_TXADES),0) VAL_CRED'
      '                                      '
      
        'FROM RETBCO                                                     ' +
        ' '
      
        'LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI                     ' +
        ' '
      
        'LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP                 ' +
        ' '
      
        '                  AND R.CTR_CODCLI = RET_CODCLI                 ' +
        ' '
      
        '                  AND R.CTR_NUMDUP = RET_NUMDUP                 ' +
        ' '
      
        '                  AND R.CTR_PARCEL = RET_PARCEL                 ' +
        ' '
      
        '                  AND R.CTR_ESPDOC = RET_ESPDOC                 ' +
        ' '
      
        '                  AND R.CTR_SEQBAI = 0                          ' +
        ' '
      
        'LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM           ' +
        ' '
      
        '                    AND DET.DET_CODOCO = RET_CODOCO             ' +
        ' '
      
        'LEFT JOIN RETMOT                                                ' +
        ' '
      
        '                 ON MOT_CODEMP = RET_CODEMP                     ' +
        ' '
      
        '                AND MOT_CODCLI = RET_CODCLI                     ' +
        ' '
      
        '                AND MOT_NUMDUP = RET_NUMDUP                     ' +
        ' '
      
        '                AND MOT_PARCEL = RET_PARCEL                     ' +
        ' '
      
        '                AND MOT_ESPDOC = RET_ESPDOC                     ' +
        ' '
      
        '                AND MOT_CODOCO = RET_CODOCO                     ' +
        ' '
      'WHERE RET_CODBCO = '#39'987'#39' AND                                   '
      
        '      IFNULL(RET_DUPDIV, '#39'N'#39') <> '#39'S'#39' AND                        ' +
        ' '
      '      LOCATE(RET_CODOCO, '#39'06'#39') > 0    '
      
        'GROUP BY R.AUTOINCREM, RET_CODOCO                               ' +
        ' '
      'ORDER BY RET_CODOCO, RET_MOTOCO, MOT_CODMOT, RET_NUMDUP')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 360
    Top = 118
    object qryRetBcoCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 86
    end
    object qryRetBcoNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryRetBcoNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 15
    end
    object qryRetBcoCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryRetBcoDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryRetBcoDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object qryRetBcoVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryRetBcoJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object qryRetBcoDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object qryRetBcoRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      FixedChar = True
      Size = 2
    end
    object qryRetBcoRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryRetBcoOUTVAL: TFloatField
      FieldName = 'OUTVAL'
    end
    object qryRetBcoVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryRetBcoCARTEI: TIntegerField
      FieldName = 'CARTEI'
    end
    object qryRetBcoTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object qryRetBcoCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 69
    end
    object qryRetBcoDTARET: TDateField
      FieldName = 'DTARET'
    end
    object qryRetBcoNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 46
    end
    object qryRetBcoCEPCLI: TStringField
      FieldName = 'CEPCLI'
      Size = 9
    end
    object qryRetBcoCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object qryRetBcoCTR_VALORI: TFloatField
      FieldName = 'CTR_VALORI'
    end
    object qryRetBcoCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
    end
    object qryRetBcoVALCOR: TFloatField
      FieldName = 'VALCOR'
    end
    object qryRetBcoCTR_DESSUJ: TFloatField
      FieldName = 'CTR_DESSUJ'
    end
    object qryRetBcoVALDIF: TFloatField
      FieldName = 'VALDIF'
    end
    object qryRetBcoCODMOT: TStringField
      FieldName = 'CODMOT'
      Size = 5
    end
    object qryRetBcoDESMOT: TStringField
      FieldName = 'DESMOT'
      Size = 120
    end
    object qryRetBcoCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryRetBcoCARBCO: TStringField
      FieldName = 'CARBCO'
      FixedChar = True
      Size = 3
    end
    object qryRetBcoIOFDES: TFloatField
      FieldName = 'IOFDES'
    end
    object qryRetBcoTXADES: TFloatField
      FieldName = 'TXADES'
    end
    object qryRetBcoJUROPE: TFloatField
      FieldName = 'JUROPE'
    end
    object qryRetBcoVL_TARIFA: TFloatField
      FieldName = 'VL_TARIFA'
    end
    object qryRetBcoVALPAG_COMTAR: TFloatField
      FieldName = 'VALPAG_COMTAR'
    end
    object qryRetBcoVAL_CRED: TFloatField
      FieldName = 'VAL_CRED'
    end
    object qryRetBcoCTR_VALREC: TFloatField
      FieldName = 'CTR_VALREC'
    end
  end
  object cdsRetBco: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRetBco'
    Left = 480
    Top = 120
    object cdsRetBcoCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 86
    end
    object cdsRetBcoNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object cdsRetBcoNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 15
    end
    object cdsRetBcoCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object cdsRetBcoDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object cdsRetBcoDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object cdsRetBcoVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object cdsRetBcoJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object cdsRetBcoDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object cdsRetBcoRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      FixedChar = True
      Size = 2
    end
    object cdsRetBcoRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object cdsRetBcoOUTVAL: TFloatField
      FieldName = 'OUTVAL'
    end
    object cdsRetBcoVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object cdsRetBcoCARTEI: TIntegerField
      FieldName = 'CARTEI'
    end
    object cdsRetBcoTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object cdsRetBcoCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 69
    end
    object cdsRetBcoDTARET: TDateField
      FieldName = 'DTARET'
    end
    object cdsRetBcoNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 46
    end
    object cdsRetBcoCEPCLI: TStringField
      FieldName = 'CEPCLI'
      Size = 9
    end
    object cdsRetBcoCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object cdsRetBcoCTR_VALORI: TFloatField
      FieldName = 'CTR_VALORI'
    end
    object cdsRetBcoCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
    end
    object cdsRetBcoVALCOR: TFloatField
      FieldName = 'VALCOR'
    end
    object cdsRetBcoCTR_DESSUJ: TFloatField
      FieldName = 'CTR_DESSUJ'
    end
    object cdsRetBcoVALDIF: TFloatField
      FieldName = 'VALDIF'
    end
    object cdsRetBcoCODMOT: TStringField
      FieldName = 'CODMOT'
      Size = 5
    end
    object cdsRetBcoDESMOT: TStringField
      FieldName = 'DESMOT'
      Size = 120
    end
    object cdsRetBcoCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object cdsRetBcoCARBCO: TStringField
      FieldName = 'CARBCO'
      FixedChar = True
      Size = 3
    end
    object cdsRetBcoIOFDES: TFloatField
      FieldName = 'IOFDES'
    end
    object cdsRetBcoTXADES: TFloatField
      FieldName = 'TXADES'
    end
    object cdsRetBcoJUROPE: TFloatField
      FieldName = 'JUROPE'
    end
    object cdsRetBcoVL_TARIFA: TFloatField
      FieldName = 'VL_TARIFA'
    end
    object cdsRetBcoVALPAG_COMTAR: TFloatField
      FieldName = 'VALPAG_COMTAR'
    end
    object cdsRetBcoVAL_CRED: TFloatField
      FieldName = 'VAL_CRED'
    end
    object cdsRetBcoCTR_VALREC: TFloatField
      FieldName = 'CTR_VALREC'
    end
  end
  object dspRetBco: TUniDataSetProvider
    DataSet = qryRetBco
    Options = []
    Left = 424
    Top = 120
  end
  object frxDBDatasetOcor: TfrxDBDataset
    UserName = 'frxDBDatasetOcor'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'QTDDUP=QTDDUP'
      'MOTOCO=MOTOCO'
      'VALDUP=VALDUP'
      'VALPAG=VALPAG'
      'TARIFA=TARIFA'
      'VALJUR=VALJUR'
      'VALDES=VALDES'
      'CUSCAR=CUSCAR'
      'VALPAG_COMTAR=VALPAG_COMTAR')
    DataSet = qryOcorr
    BCDToCurrency = False
    Left = 576
    Top = 31
  end
  object qryOcorr: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      '  RET_CODOCO AS CODOCO,'
      '  COUNT(RET_CODOCO) AS QTDDUP,'
      '  RET_MOTOCO AS MOTOCO,'
      '  SUM(RET_VALDUP) AS VALDUP,'
      '  SUM(RET_VALPAG) AS VALPAG,'
      '  SUM(RET_TARIFA) AS TARIFA,'
      '  SUM(RET_JURMOR) AS VALJUR,'
      '  SUM(RET_DESCON) AS VALDES,'
      '  SUM(RET_CUSCAR) AS CUSCAR,'
      '  CASE WHEN SUM(RET_VALPAG) > 0 THEN '
      '          ( SUM(RET_VALPAG) + SUM(RET_TARIFA) ) '
      '  ELSE '
      '       SUM(RET_VALPAG) END AS VALPAG_COMTAR '
      'FROM'
      '  RETBCO'
      'WHERE RET_CODBCO = '#39'987'#39
      '  AND LOCATE(RET_CODOCO, '#39'06_'#39') > 0'
      'GROUP BY RET_CODOCO,'
      '  IF('
      '    RET_CODBCO IN'
      '    (SELECT DISTINCT'
      '      (OCO_CODBCO)'
      '    FROM'
      '      OCOBAN),'
      '    RET_MOTOCO,'
      '    '#39#39
      '  )'
      'ORDER BY RET_CODOCO,'
      '  RET_MOTOCO')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 664
    Top = 29
    object qryOcorrCODOCO: TStringField
      FieldName = 'CODOCO'
      Required = True
      Size = 5
    end
    object qryOcorrQTDDUP: TLargeintField
      FieldName = 'QTDDUP'
    end
    object qryOcorrMOTOCO: TStringField
      FieldName = 'MOTOCO'
      Size = 80
    end
    object qryOcorrVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryOcorrVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryOcorrTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object qryOcorrVALJUR: TFloatField
      FieldName = 'VALJUR'
    end
    object qryOcorrVALDES: TFloatField
      FieldName = 'VALDES'
    end
    object qryOcorrCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryOcorrVALPAG_COMTAR: TFloatField
      FieldName = 'VALPAG_COMTAR'
    end
  end
  object frxDBDatasetTotOcor: TfrxDBDataset
    UserName = 'frxDBDatasetTotOcor'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'QTDDUP=QTDDUP'
      'VALDUP=VALDUP'
      'VALPAG=VALPAG'
      'TARIFA=TARIFA'
      'VALJUR=VALJUR'
      'VALDES=VALDES'
      'CUSCAR=CUSCAR'
      'VALPAG_COMTAR=VALPAG_COMTAR')
    DataSet = qryTotOcor
    BCDToCurrency = False
    Left = 576
    Top = 79
  end
  object qryTotOcor: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT'
      '  RET_CODOCO AS CODOCO,'
      '  COUNT(RET_CODOCO) AS QTDDUP,'
      '  SUM(RET_VALDUP) AS VALDUP,'
      '  SUM(RET_VALPAG) AS VALPAG,'
      '  SUM(RET_TARIFA) AS TARIFA ,'
      '  SUM(RET_JURMOR) AS VALJUR,'
      '  SUM(RET_DESCON) AS VALDES,'
      '  SUM(RET_CUSCAR) AS CUSCAR,'
      '  CASE WHEN SUM(RET_VALPAG) > 0 THEN '
      '          ( SUM(RET_VALPAG) + SUM(RET_TARIFA) ) '
      '  ELSE '
      '       SUM(RET_VALPAG) END AS VALPAG_COMTAR '
      '  '
      'FROM'
      '  (SELECT'
      '    RET_CODOCO,'
      '    RET_VALDUP,'
      '    RET_VALPAG,'
      '    RET_TARIFA,'
      '    RET_JURMOR,'
      '    RET_DESCON,'
      '    RET_CUSCAR'
      '  FROM'
      '    RETBCO'
      '  WHERE RET_CODBCO = '#39'987'#39
      '    AND LOCATE(RET_CODOCO, '#39'06_'#39') > 0'
      '  GROUP BY RET_NUMDUP,'
      '    RET_PARCEL,'
      '    RET_ESPDOC,'
      '    RET_CODEMP) AS TEMP')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 664
    Top = 77
    object qryTotOcorCODOCO: TStringField
      FieldName = 'CODOCO'
      Required = True
      Size = 5
    end
    object qryTotOcorQTDDUP: TLargeintField
      FieldName = 'QTDDUP'
    end
    object qryTotOcorVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryTotOcorVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryTotOcorTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object qryTotOcorVALJUR: TFloatField
      FieldName = 'VALJUR'
    end
    object qryTotOcorVALDES: TFloatField
      FieldName = 'VALDES'
    end
    object qryTotOcorCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryTotOcorVALPAG_COMTAR: TFloatField
      FieldName = 'VALPAG_COMTAR'
    end
  end
  object frxDBDatasetNaoBaix: TfrxDBDataset
    UserName = 'frxDBDatasetNaoBaix'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'NOSNUM=NOSNUM'
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'DTAVEN=DTAVEN'
      'DTAPAG=DTAPAG'
      'VALPAG=VALPAG'
      'JURMOR=JURMOR'
      'DESCON=DESCON'
      'RET_CODREJ=RET_CODREJ'
      'RET_CODBCO=RET_CODBCO'
      'VALDUP=VALDUP'
      'CARTEI=CARTEI'
      'DUPDIV=DUPDIV'
      'TARIFA=TARIFA'
      'CODCLI=CODCLI'
      'DTARET=DTARET'
      'NOMARQ=NOMARQ'
      'CEPCLI=CEPCLI'
      'MOTDIV=MOTDIV'
      'CUSCAR=CUSCAR'
      'CARBCO=CARBCO'
      'IOFDES=IOFDES'
      'TXADES=TXADES'
      'JUROPE=JUROPE')
    DataSet = qryNaoBaix
    BCDToCurrency = False
    Left = 576
    Top = 127
  end
  object qryNaoBaix: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      '    '
      
        '    SELECT IF(RET_MOTOCO <> '#39'00'#39' AND RET_CODBCO IN (SELECT DISTI' +
        'NCT(OCO_CODBCO) FROM OCOBAN), '
      
        '           CONCAT(RET_CODOCO, '#39'.'#39', RET_MOTOCO), RET_CODOCO) AS C' +
        'ODOCO, RET_NOSNUM AS NOSNUM, '
      '           CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, '
      
        '           RET_CODEMP AS CODEMP, RET_DTAVEN AS DTAVEN,  IF( RET_' +
        'VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, RET_DTAOCO),NULL' +
        ') AS DTAPAG, '
      
        '           RET_VALPAG AS VALPAG, RET_JURMOR AS JURMOR, RET_DESCO' +
        'N AS DESCON, RET_CODREJ, RET_CODBCO, '
      
        '           RET_VALDUP AS VALDUP, RET_CARTEI AS CARTEI, RET_DUPDI' +
        'V AS DUPDIV,  IFNULL(RET_TARIFA, 0.00) AS TARIFA, '
      '           CONCAT(RET_CODCLI, '#39'-'#39', CLI_NOMCLI) AS CODCLI, '
      
        '           MAX(DET.DET_DTARET) AS DTARET, CONCAT(RET_NOMARQ, '#39' -' +
        ' '#39', RET_DTAARQ, '#39' - '#39', RET_HORARQ) AS NOMARQ, '
      
        '           CLI_C_E_P_ AS CEPCLI, RET_MOTDIV AS MOTDIV, RET_CUSCA' +
        'R AS CUSCAR, RET_CARBCO AS CARBCO,  '
      
        '           RET_IOFDES AS IOFDES, RET_TXADES AS TXADES, RET_JUROP' +
        'E AS JUROPE '
      '    FROM RETBCO '
      '    LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI '
      '    LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP '
      '                      AND R.CTR_CODCLI = RET_CODCLI '
      '                      AND R.CTR_NUMDUP = RET_NUMDUP '
      '                      AND R.CTR_PARCEL = RET_PARCEL '
      '                      AND R.CTR_ESPDOC = RET_ESPDOC '
      '    LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM '
      '    WHERE RET_CODBCO = '#39'987'#39' AND '
      '          RET_DUPDIV = '#39'S'#39' '
      '    GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO  '
      '    ORDER BY RET_CODOCO, RET_MOTOCO, '
      '      RET_NUMDUP ')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 664
    Top = 125
    object qryNaoBaixCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 86
    end
    object qryNaoBaixNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryNaoBaixNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 15
    end
    object qryNaoBaixCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryNaoBaixDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryNaoBaixDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object qryNaoBaixVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryNaoBaixJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object qryNaoBaixDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object qryNaoBaixRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      FixedChar = True
      Size = 2
    end
    object qryNaoBaixRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryNaoBaixVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryNaoBaixCARTEI: TIntegerField
      FieldName = 'CARTEI'
    end
    object qryNaoBaixDUPDIV: TStringField
      FieldName = 'DUPDIV'
      FixedChar = True
      Size = 1
    end
    object qryNaoBaixTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object qryNaoBaixCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 69
    end
    object qryNaoBaixDTARET: TDateField
      FieldName = 'DTARET'
    end
    object qryNaoBaixNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 46
    end
    object qryNaoBaixCEPCLI: TStringField
      FieldName = 'CEPCLI'
      Size = 9
    end
    object qryNaoBaixMOTDIV: TStringField
      FieldName = 'MOTDIV'
      Size = 255
    end
    object qryNaoBaixCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryNaoBaixCARBCO: TStringField
      FieldName = 'CARBCO'
      FixedChar = True
      Size = 3
    end
    object qryNaoBaixIOFDES: TFloatField
      FieldName = 'IOFDES'
    end
    object qryNaoBaixTXADES: TFloatField
      FieldName = 'TXADES'
    end
    object qryNaoBaixJUROPE: TFloatField
      FieldName = 'JUROPE'
    end
  end
  object qryDupJaBaixadas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      ''
      
        'SELECT IF(RET_MOTOCO <> '#39'00'#39' AND RET_CODBCO IN (SELECT DISTINCT(' +
        'OCO_CODBCO) FROM OCOBAN), '
      
        '       CONCAT(RET_CODOCO, '#39'.'#39', RET_MOTOCO), RET_CODOCO) AS CODOC' +
        'O, RET_NOSNUM AS NOSNUM, '
      '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, '
      '       RET_CODEMP AS CODEMP, RET_DTAVEN AS DTAVEN, '
      
        '       IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, R' +
        'ET_DTAOCO), NULL) AS DTAPAG, '
      '       R.CTR_VALREC AS VALPAG, RET_JURMOR AS JURMOR, '
      '       RET_DESCON AS DESCON, RET_OUTVAL AS OUTVAL, '
      '       RET_VALDUP AS VALDUP, RET_CODREJ, RET_CODBCO, '
      '       RET_CARTEI AS CARTEI, '
      '       CONCAT(RET_CODCLI, '#39'-'#39', CLI_NOMCLI) AS CODCLI, '
      '       IFNULL(RET_TARIFA, 0.00) AS TARIFA,  '
      
        '       CONCAT(RET_NOMARQ, '#39' - '#39', RET_DTAARQ, '#39' - '#39', RET_HORARQ) ' +
        'AS NOMARQ, CLI_C_E_P_ AS CEPCLI, '
      
        '       IFNULL(R.CTR_DESSUJ,0.00) AS CTR_DESSUJ, R.CTR_DTAVEN, R.' +
        'CTR_VALORI, R.CTR_VALDUP, 0.00 AS VALCOR, 0.00 AS VALDIF, MAX(DE' +
        'T.DET_DTARET) AS DTARET, RET_CUSCAR AS CUSCAR, RET_CARBCO AS CAR' +
        'BCO, '
      
        '       RET_IOFDES AS IOFDES, RET_TXADES AS TXADES, RET_JUROPE AS' +
        ' JUROPE '
      'FROM RETBCO '
      'LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI '
      'LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP '
      '                  AND R.CTR_CODCLI = RET_CODCLI '
      '                  AND R.CTR_NUMDUP = RET_NUMDUP '
      '                  AND R.CTR_PARCEL = RET_PARCEL '
      '                  AND R.CTR_ESPDOC = RET_ESPDOC '
      '                  AND R.CTR_SEQBAI = 0          '
      'LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM '
      'WHERE RET_CODBCO = :CODBCO AND '
      '      IFNULL(RET_DUPDIV, '#39'N'#39') <> '#39'S'#39' AND '
      '      LOCATE(RET_CODOCO, '#39'06'#39') > 0 AND '
      '      CTR_DTAREC IS NOT NULL '
      'GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO  '
      'ORDER BY RET_CODOCO, RET_MOTOCO, '
      '  RET_NUMDUP ')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 664
    Top = 181
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODBCO'
        Value = nil
      end>
    object qryDupJaBaixadasCODOCO: TStringField
      FieldName = 'CODOCO'
      Size = 86
    end
    object qryDupJaBaixadasNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryDupJaBaixadasNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 15
    end
    object qryDupJaBaixadasCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDupJaBaixadasDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryDupJaBaixadasDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object qryDupJaBaixadasVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryDupJaBaixadasJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object qryDupJaBaixadasDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object qryDupJaBaixadasOUTVAL: TFloatField
      FieldName = 'OUTVAL'
    end
    object qryDupJaBaixadasVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryDupJaBaixadasRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      FixedChar = True
      Size = 2
    end
    object qryDupJaBaixadasRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDupJaBaixadasCARTEI: TIntegerField
      FieldName = 'CARTEI'
    end
    object qryDupJaBaixadasCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 69
    end
    object qryDupJaBaixadasTARIFA: TFloatField
      FieldName = 'TARIFA'
    end
    object qryDupJaBaixadasNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 46
    end
    object qryDupJaBaixadasCEPCLI: TStringField
      FieldName = 'CEPCLI'
      Size = 9
    end
    object qryDupJaBaixadasCTR_DESSUJ: TFloatField
      FieldName = 'CTR_DESSUJ'
    end
    object qryDupJaBaixadasCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
    end
    object qryDupJaBaixadasCTR_VALORI: TFloatField
      FieldName = 'CTR_VALORI'
    end
    object qryDupJaBaixadasCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
    end
    object qryDupJaBaixadasVALCOR: TFloatField
      FieldName = 'VALCOR'
    end
    object qryDupJaBaixadasVALDIF: TFloatField
      FieldName = 'VALDIF'
    end
    object qryDupJaBaixadasDTARET: TDateField
      FieldName = 'DTARET'
    end
    object qryDupJaBaixadasCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryDupJaBaixadasCARBCO: TStringField
      FieldName = 'CARBCO'
      FixedChar = True
      Size = 3
    end
    object qryDupJaBaixadasIOFDES: TFloatField
      FieldName = 'IOFDES'
    end
    object qryDupJaBaixadasTXADES: TFloatField
      FieldName = 'TXADES'
    end
    object qryDupJaBaixadasJUROPE: TFloatField
      FieldName = 'JUROPE'
    end
  end
  object frxDBDatasetJaBaixadas: TfrxDBDataset
    UserName = 'frxDBDatasetJaBaixadas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'NOSNUM=NOSNUM'
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'DTAVEN=DTAVEN'
      'DTAPAG=DTAPAG'
      'VALPAG=VALPAG'
      'JURMOR=JURMOR'
      'DESCON=DESCON'
      'OUTVAL=OUTVAL'
      'VALDUP=VALDUP'
      'RET_CODREJ=RET_CODREJ'
      'RET_CODBCO=RET_CODBCO'
      'CARTEI=CARTEI'
      'CODCLI=CODCLI'
      'TARIFA=TARIFA'
      'NOMARQ=NOMARQ'
      'CEPCLI=CEPCLI'
      'CTR_DESSUJ=CTR_DESSUJ'
      'CTR_DTAVEN=CTR_DTAVEN'
      'CTR_VALORI=CTR_VALORI'
      'CTR_VALDUP=CTR_VALDUP'
      'VALCOR=VALCOR'
      'VALDIF=VALDIF'
      'DTARET=DTARET'
      'CUSCAR=CUSCAR'
      'CARBCO=CARBCO'
      'IOFDES=IOFDES'
      'TXADES=TXADES'
      'JUROPE=JUROPE')
    DataSet = qryDupJaBaixadas
    BCDToCurrency = False
    Left = 576
    Top = 183
  end
  object frxRetBcoTarifa: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44776.404497118100000000
    ReportOptions.LastChange = 45798.416413715280000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var strCodMot : String;'
      
        '    contReg   : Integer;                                        ' +
        '             '
      '    contRegBaix : integer;'
      '    contRegBaixLcTar : integer;        '
      '                                         '
      
        'procedure frxDBDatasetBcoCODOCOOnBeforePrint(Sender: TfrxCompone' +
        'nt);'
      ' Var '
      '     strBco : String;'
      '     strtpCnab : String;         '
      'begin'
      
        ' strtpCnab := <TPCNAB>;                                         ' +
        '                                         '
      ' strBco := <frxDBDatasetBco."RET_CODBCO">;'
      '  '
      '  if (strBco = '#39'001'#39') or'
      '     (strBco = '#39'748'#39') or'
      '     (strBco = '#39'237'#39') or '
      '     (strBco = '#39'077'#39') or'
      '     (strBco = '#39'341'#39') or'
      '     (strBco = '#39'033'#39') or'
      '     (strBco = '#39'756'#39') then'
      '  begin'
      ''
      
        '     mmOcorrencia.Text := pRetornaDescricaoBeforePrint_Rel( <frx' +
        'DBDatasetBco."CODOCO">, strBco, Length(strtpCnab) );            ' +
        '                           '
      ''
      '  end'
      '  else'
      
        '     mmOcorrencia.Text := <frxDBDatasetBco."CODOCO"> + '#39' - '#39' + f' +
        'RetDescOco_Rel(<frxDBDatasetBco."CODOCO">);  '
      'end;'
      ''
      
        'procedure masterDataDuplicatasOnBeforePrint(Sender: TfrxComponen' +
        't);'
      ' Var nTop : real;                                        '
      'begin'
      ''
      '  contReg := contReg + 1;    '
      ''
      '  if ( strCodMot <> <frxDBDatasetBco."CODMOT"> ) Then'
      '  Begin'
      '    // Mostra o motivo da rejei'#231#227'o na linha de detalhe'
      '    mmCodMot.Text := <frxDBDatasetBco."CODMOT"> + '#39' '#39' +'
      '                     <frxDBDatasetBco."DESMOT">;'
      ''
      
        '    nTop := mmcodMot.height + 0.05;                             ' +
        '                      '
      '                       '
      '    mmCliente.Top  := nTop;'
      '    mmNossoNum.Top := nTop;  '
      '    mmCarteira.Top := nTop;  '
      '    mmNumDup.Top   := nTop;'
      '    mmEmpresa.Top  := nTop;'
      '    mmDtVenc.Top   := nTop;'
      '    mmDtPag.Top    := nTop;'
      '    mmVlPago.Top   := nTop;'
      '    mmVlJuros.Top  := nTop;'
      '    mmVldesc.Top   := nTop;  '
      '    mmValDup.Top   := nTop;  '
      '    mmTarifa.Top   := nTop;'
      '    mmtarIOF.Top   := nTop;'
      '    mmtxdesc.Top   := nTop;'
      '    mmJurOpe.top   := nTop;'
      '    mmValCred.Top  := nTop;'
      '    mmValPag.Top   := nTop;'
      '    mmValDif.Top   := nTop;'
      '                          '
      '    masterDataDuplicatas.height := 24;'
      
        '    mmoZebra.height := 24;                                      ' +
        '              '
      '  End'
      '  Else'
      '  Begin'
      '    // N'#227'o mostra o motivo da rejei'#231#227'o na linha de detalhe'
      '    mmCodMot.Text := '#39#39';'
      ''
      '    mmCliente.Top  := 0;'
      '    mmNossoNum.Top := 0;  '
      '    mmCarteira.Top := 0;  '
      '    mmNumDup.Top   := 0;'
      '    mmEmpresa.Top  := 0;'
      '    mmDtVenc.Top   := 0;'
      '    mmDtPag.Top    := 0;'
      '    mmVlPago.Top   := 0;'
      '    mmVlJuros.Top  := 0;'
      '    mmVldesc.Top   := 0;  '
      '    mmValDup.Top   := 0;  '
      '    mmTarifa.Top   := 0;'
      '    mmtarIOF.Top   := 0;'
      '    mmtxdesc.Top   := 0;'
      '    mmJurOpe.top   := 0;'
      '    mmValCred.Top  := 0;'
      '    mmValPag.Top   := 0;'
      '    mmValDif.Top   := 0;'
      '    masterDataDuplicatas.Height := 12;'
      '    mmoZebra.height := 12;        '
      '  End;'
      ''
      '  strCodMot := <frxDBDatasetBco."CODMOT">;'
      '                           '
      'end;'
      ''
      'procedure mmDescOcorrenciaOnBeforePrint(Sender: TfrxComponent);'
      ' Var '
      '     strBco : String;'
      'begin'
      '    strBco := <frxDBDatasetBco."RET_CODBCO">;'
      ''
      '    if (strBco = '#39'237'#39') then'
      '       mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO">'
      '    Else'
      '    Begin'
      
        '      if ( <frxDBDatasetOcor."MOTOCO"> <> '#39#39' ) and ( <frxDBDatas' +
        'etOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '          mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO"> +' +
        ' '#39'.'#39' + <frxDBDatasetOcor."MOTOCO">'
      '      else'
      '          mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO">;'
      '    End;'
      '                                    '
      
        '    //mmDescOcorrencia.Text := <frxDBDatasetOcor."CODOCO"> + '#39' -' +
        ' '#39' + fRetDescOco_Rel(<frxDBDatasetOcor."CODOCO">);'
      ''
      'end;'
      ''
      'procedure mmDescMotOcoOnBeforePrint(Sender: TfrxComponent);'
      ' Var '
      '     strBco : String;'
      '     strtpCnab : String;         '
      'begin'
      
        '    strtpCnab := <TPCNAB>;                                      ' +
        '                                            '
      '    strBco    := <frxDBDatasetBco."RET_CODBCO">;'
      '  '
      '    if (strBco = '#39'001'#39') or'
      '       (strBco = '#39'748'#39') or'
      '       (strBco = '#39'237'#39') or'
      '       (strBco = '#39'097'#39') or'
      '       (strBco = '#39'274'#39') or'
      '       (strBco = '#39'341'#39') or'
      '       (strBco = '#39'033'#39') or'
      '       (strBco = '#39'756'#39') then'
      '    begin'
      ''
      '      if (strBco = '#39'237'#39') then'
      '      Begin'
      ''
      
        '         if (<frxDBDatasetOcor."MOTOCO"> <> '#39#39') and (<frxDBDatas' +
        'etOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '            mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <' +
        'frxDBDatasetOcor."CODOCO">, strtpCnab)+ '#39' /. '#39' +'
      
        '                                                       <frxDBDat' +
        'asetOcor."MOTOCO"> + '#39' - '#39' + RetornaOcorrencia_Rel(strBco, <frxD' +
        'BDatasetOcor."CODOCO">, strtpCnab, <frxDBDatasetOcor."MOTOCO">, ' +
        'False)'
      '         else'
      
        '            mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <' +
        'frxDBDatasetOcor."CODOCO">, strtpCnab);'
      ''
      '      End'
      '      Else'
      '      Begin'
      ''
      
        '        if (<frxDBDatasetOcor."MOTOCO"> <> '#39#39') and (<frxDBDatase' +
        'tOcor."MOTOCO"> <> '#39'00'#39') then'
      
        '           mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <f' +
        'rxDBDatasetOcor."CODOCO">, strtpCnab, <frxDBDatasetOcor."MOTOCO"' +
        '>, False)'
      '        else'
      
        '           mmDescMotOco.Text := RetornaOcorrencia_Rel(strBco, <f' +
        'rxDBDatasetOcor."CODOCO">, strtpCnab);'
      ''
      '      End;'
      ''
      '    end'
      '    else'
      
        '      mmDescMotOco.Text := fRetDescOco_Rel(<frxDBDatasetOcor."CO' +
        'DOCO">);'
      '        '
      'end;              '
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   contReg := 0;                     '
      'end;'
      ''
      'procedure PageFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmQtdeReg.Text := fPreencheComZerosEsquerda_Rel(intToStr(contR' +
        'eg));  '
      'end;'
      ''
      'procedure Header3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  contRegBaix := 0;                '
      'end;'
      ''
      'procedure MasterData4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    contRegBaix := contRegBaix + 1;        '
      'end;'
      ''
      'procedure PageFooter2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '    mmQtdeRegBaix.Text := fPreencheComZerosEsquerda_Rel(intToStr' +
        '(contRegBaix));  '
      'end;'
      ''
      'procedure Header4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  contRegBaixLcTar := 0;                   '
      'end;'
      ''
      'procedure MasterData5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  contRegBaixLcTar := contRegBaixLcTar + 1;  '
      'end;'
      ''
      'procedure PageFooter3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmqtdRegBaixLcTar.text := fPreencheComZerosEsquerda_Rel(intToS' +
        'tr(contRegBaixLcTar));              '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  strCodmot := '#39#39';                                    '
      'end;'
      ''
      'begin'
      ''
      'end.  ')
    OnUserFunction = frxRetBcoUserFunction
    Left = 210
    Top = 176
    Datasets = <
      item
        DataSet = frxDBDatasetBaixadasLancaTarifa
        DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
      end
      item
        DataSet = frxDBDatasetBco
        DataSetName = 'frxDBDatasetBco'
      end
      item
        DataSet = frxDBDataSetCodigoErroPIX
        DataSetName = 'frxDBDatasetCodigoErroPIX'
      end
      item
        DataSet = frxDBDatasetJaBaixadas
        DataSetName = 'frxDBDatasetJaBaixadas'
      end
      item
        DataSet = frxDBDatasetNaoBaix
        DataSetName = 'frxDBDatasetNaoBaix'
      end
      item
        DataSet = frxDBDatasetOcor
        DataSetName = 'frxDBDatasetOcor'
      end
      item
        DataSet = frxDBDatasetTotOcor
        DataSetName = 'frxDBDatasetTotOcor'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 20.881880000000000000
          Width = 400.629921260000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE DUPLICATAS DE RETORNO')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 1012.418060000000000000
          Top = 27.763760000000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Top = 91.000000000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 951.630490000000000000
          Top = 28.897650000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 71.929190000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[NOMBCO]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 1018.659000000000000000
          Top = 2.425170000000000000
          Width = 84.963760000000000000
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
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 2.220470000000000000
          Width = 400.629921260000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo89: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 40.354360000000000000
          Width = 400.629921260000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
      end
      object HeaderFixo: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 15.118120000000000000
        Top = 188.976500000000000000
        Width = 1103.622760000000000000
        object Memo8: TfrxMemoView
          Left = 306.141732280000000000
          Top = 1.889763780000000000
          Width = 82.015748030000000000
          Height = 11.338582677165350000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 421.039370080000000000
          Top = 1.889763780000000000
          Width = 46.110236220000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT VEN')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 173.535433070000000000
          Top = 1.889763780000000000
          Width = 105.826786300000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object mmlblCliente: TfrxMemoView
          Top = 1.889763780000000000
          Width = 171.968479530000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 392.692913390000000000
          Top = 1.889763780000000000
          Width = 23.811023620000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 519.307086614173000000
          Top = 1.889763780000000000
          Width = 77.480314960629900000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 599.811023622047000000
          Top = 1.889763780000000000
          Width = 54.803149606299200000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 705.637795275591000000
          Top = 1.889763780000000000
          Width = 60.472440940000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR PAGO')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 281.708661420000000000
          Top = 1.889763780000000000
          Width = 22.677165350000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'CRT')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 469.858267720000000000
          Top = 1.889763780000000000
          Width = 46.110236220000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT PAG')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 659.149606300000000000
          Top = 1.889763780000000000
          Width = 43.464566930000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 909.732283464567000000
          Top = 2.889763780000000000
          Width = 47.622047244094500000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUR OPE')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 1062.803149606300000000
          Top = 1.889763780000000000
          Width = 38.551181102362200000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DIF.')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 768.000000000000000000
          Top = 1.889763780000000000
          Width = 41.574803150000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TARIFA')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 812.976377952756000000
          Top = 1.889763780000000000
          Width = 41.574803149606300000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TAR IOF')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 857.952755910000000000
          Top = 1.889763780000000000
          Width = 49.133858270000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TX DESC')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 961.889763780000000000
          Top = 1.889763780000000000
          Width = 47.622047240000000000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR CRED')
          ParentFont = False
        end
        object Memo131: TfrxMemoView
          Left = 1012.157480314960000000
          Top = 1.889763780000000000
          Width = 47.622047244094500000
          Height = 10.204724410000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR LAN')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.496062990000000000
        Top = 226.771800000000000000
        Width = 1103.622760000000000000
        Condition = 'frxDBDatasetBco."CODOCO"'
        object mmOcorrencia: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.220470000000000000
          Width = 540.472790000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'frxDBDatasetBcoCODOCOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 313.700990000000000000
        Width = 1103.622760000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object Memo124: TfrxMemoView
          Left = 429.133858270000000000
          Top = 1.889763779527560000
          Width = 86.929133860000000000
          Height = 11.338582677165400000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object SysMemo38: TfrxSysMemoView
          Left = 519.307086610000000000
          Top = 1.889763780000000000
          Width = 77.480314960000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDUP">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo39: TfrxSysMemoView
          Left = 599.811023620000000000
          Top = 1.889763780000000000
          Width = 54.803149610000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JURMOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo40: TfrxSysMemoView
          Left = 659.527559060000000000
          Top = 1.889763780000000000
          Width = 43.464566930000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."DESCON">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo41: TfrxSysMemoView
          Left = 706.771653540000000000
          Top = 1.889763780000000000
          Width = 59.338582680000000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG_COMTAR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo42: TfrxSysMemoView
          Left = 768.000000000000000000
          Top = 1.889763780000000000
          Width = 41.574803149606300000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VL_TARIFA">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo43: TfrxSysMemoView
          Left = 812.976377952756000000
          Top = 1.889763780000000000
          Width = 41.574803149606300000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."IOFDES">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo44: TfrxSysMemoView
          Left = 859.086614173228000000
          Top = 1.889763780000000000
          Width = 49.133858267716500000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."TXADES">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo45: TfrxSysMemoView
          Left = 909.732283464567000000
          Top = 1.889763780000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JUROPE">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo46: TfrxSysMemoView
          Left = 961.889763779528100000
          Top = 1.889763780000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VAL_CRED">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo47: TfrxSysMemoView
          Left = 1012.157480314960000000
          Top = 1.889763780000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo48: TfrxSysMemoView
          Left = 1061.669291338580000000
          Top = 1.889763780000000000
          Width = 38.551181102362200000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDIF">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 518.000000000000000000
          Top = 1.299010000000000000
          Width = 586.000000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object masterDataDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 27.480314960000000000
        Top = 264.567100000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'masterDataDuplicatasOnBeforePrint'
        DataSet = frxDBDatasetBco
        DataSetName = 'frxDBDatasetBco'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Left = 2.000000000000000000
          Top = 0.432900000000000000
          Width = 1102.701300000000000000
          Height = 24.566936460000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object mmcliente: TfrxMemoView
          Left = 2.000000000000000000
          Top = 15.118110240000000000
          Width = 168.188949530000000000
          Height = 11.338582680000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBco."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object mmNumDup: TfrxMemoView
          Left = 306.141732280000000000
          Top = 15.118110236220500000
          Width = 85.795278030000000000
          Height = 11.338582680000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBco."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmdtpag: TfrxMemoView
          Left = 469.858267720000000000
          Top = 15.118110236220500000
          Width = 46.110236220000000000
          Height = 11.338582680000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object mmvlPago: TfrxMemoView
          Left = 519.307086610000000000
          Top = 15.118110240000000000
          Width = 77.480314960000000000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValDup: TfrxMemoView
          Left = 706.771653540000000000
          Top = 15.118110240000000000
          Width = 59.338582680000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALPAG_COMTAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmvlJuros: TfrxMemoView
          Left = 599.811023622047000000
          Top = 15.118110240000000000
          Width = 54.803149610000000000
          Height = 11.338582680000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmEmpresa: TfrxMemoView
          Left = 392.692913390000000000
          Top = 15.118110236220500000
          Width = 23.811023620000000000
          Height = 11.338582680000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object mmdtVenc: TfrxMemoView
          Left = 421.039370080000000000
          Top = 15.118110236220500000
          Width = 46.110236220000000000
          Height = 11.338582680000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object mmNossoNum: TfrxMemoView
          Left = 173.535433070000000000
          Top = 15.118110240000000000
          Width = 105.826786300000000000
          Height = 11.338582680000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object mmCarteira: TfrxMemoView
          Left = 281.708661420000000000
          Top = 15.118110240000000000
          Width = 22.677165350000000000
          Height = 11.338582680000000000
          DataField = 'CARBCO'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBco."CARBCO"]')
          ParentFont = False
          WordWrap = False
        end
        object mmJurOpe: TfrxMemoView
          Left = 909.732283464567000000
          Top = 15.118110240000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DataField = 'JUROPE'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."JUROPE"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValDif: TfrxMemoView
          Left = 1061.669291338580000000
          Top = 16.118110240000000000
          Width = 38.551181102362200000
          Height = 11.338582680000000000
          DataField = 'VALDIF'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALDIF"]')
          ParentFont = False
          WordWrap = False
        end
        object mmVlDesc: TfrxMemoView
          Left = 659.527559055118000000
          Top = 15.118110240000000000
          Width = 43.464566930000000000
          Height = 11.338582680000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object mmCodMot: TfrxMemoView
          Left = 2.000000000000000000
          Width = 540.472790000000000000
          Height = 11.338580240000000000
          OnBeforePrint = 'frxDBDatasetBcoCODOCOOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object mmTarifa: TfrxMemoView
          Left = 768.000000000000000000
          Top = 15.118110240000000000
          Width = 41.574803149606300000
          Height = 11.338582680000000000
          DataField = 'VL_TARIFA'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VL_TARIFA"]')
          ParentFont = False
          WordWrap = False
        end
        object mmtarIOF: TfrxMemoView
          Left = 812.976377952756000000
          Top = 15.118110240000000000
          Width = 41.574803149606300000
          Height = 11.338582680000000000
          DataField = 'IOFDES'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."IOFDES"]')
          ParentFont = False
          WordWrap = False
        end
        object mmtxDesc: TfrxMemoView
          Left = 859.086614173228000000
          Top = 15.118110240000000000
          Width = 49.133858267716500000
          Height = 11.338582680000000000
          DataField = 'TXADES'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."TXADES"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValCred: TfrxMemoView
          Left = 961.889763779528100000
          Top = 15.118110240000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DataField = 'VAL_CRED'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VAL_CRED"]')
          ParentFont = False
          WordWrap = False
        end
        object mmValPag: TfrxMemoView
          Left = 1012.157480314960000000
          Top = 15.118110240000000000
          Width = 47.622047244094500000
          Height = 11.338582680000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetBco
          DataSetName = 'frxDBDatasetBco'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBco."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 26.724490000000000000
        Top = 434.645950000000000000
        Width = 1103.622760000000000000
        Child = frxRetBcoTarifa.Child4
        object Subreport1: TfrxSubreport
          Left = 5.000000000000000000
          Top = 3.794990000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBcoTarifa.Page2
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 355.275820000000000000
        Width = 1103.622760000000000000
        object Memo5: TfrxMemoView
          Left = 427.000000000000000000
          Top = 1.133858267716540000
          Width = 86.929133860000000000
          Height = 12.472440944881900000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object SysMemo8: TfrxSysMemoView
          Left = 519.307086614173000000
          Top = 1.133858270000000000
          Width = 77.480314960000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDUP">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo9: TfrxSysMemoView
          Left = 599.811023622047000000
          Top = 1.133858270000000000
          Width = 54.803149610000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JURMOR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo10: TfrxSysMemoView
          Left = 659.527559055118000000
          Top = 1.133858270000000000
          Width = 43.464566930000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."DESCON">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo11: TfrxSysMemoView
          Left = 706.771653540000000000
          Top = 1.133858270000000000
          Width = 59.338582680000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG_COMTAR">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo12: TfrxSysMemoView
          Left = 768.000000000000000000
          Top = 1.133858270000000000
          Width = 41.574803149606300000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VL_TARIFA">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo13: TfrxSysMemoView
          Left = 1061.669291338580000000
          Top = 1.133858270000000000
          Width = 38.551181102362200000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALDIF">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo14: TfrxSysMemoView
          Left = 961.889763779528100000
          Top = 1.133858270000000000
          Width = 47.622047244094500000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VAL_CRED">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo34: TfrxSysMemoView
          Left = 812.976377952756000000
          Top = 1.133858270000000000
          Width = 41.574803149606300000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."IOFDES">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo35: TfrxSysMemoView
          Left = 859.086614173228000000
          Top = 1.133858270000000000
          Width = 49.133858267716500000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."TXADES">,masterDataDuplicatas,1)]')
          ParentFont = False
        end
        object SysMemo36: TfrxSysMemoView
          Left = 909.732283464567000000
          Top = 1.133858270000000000
          Width = 47.622047244094500000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."JUROPE">,masterDataDuplicatas)]')
          ParentFont = False
        end
        object SysMemo37: TfrxSysMemoView
          Left = 1012.157480314960000000
          Top = 1.133858270000000000
          Width = 47.622047244094500000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBco."VALPAG">,masterDataDuplicatas)]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 49.677180000000000000
        Top = 483.779840000000000000
        Width = 1103.622760000000000000
        Child = frxRetBcoTarifa.Child1
        object Subreport2: TfrxSubreport
          Left = 5.000000000000000000
          Top = 11.661100000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBcoTarifa.Page3
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677165350000000000
        Top = 627.401980000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageFooter1OnBeforePrint'
        object Memo16: TfrxMemoView
          Left = 928.016080000000000000
          Top = 0.377952760000000000
          Width = 112.906926670000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGISTRO IMPRESSOS:')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Top = 0.377952760000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object mmQtdeReg: TfrxSysMemoView
          Left = 1043.500000000000000000
          Top = 0.377952760000000000
          Width = 55.380643330000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 49.511811020000000000
        Top = 555.590910000000000000
        Width = 1103.622760000000000000
        object Subreport3: TfrxSubreport
          Left = 4.913385830000000000
          Top = 11.716535430000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBcoTarifa.Page6
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.007874020000000000
        Top = 86.929190000000000000
        Width = 1103.622760000000000000
        DataSet = frxDBDatasetOcor
        DataSetName = 'frxDBDatasetOcor'
        RowCount = 0
        object frxDBDatasetOcorQTDDUP: TfrxMemoView
          Left = 540.850393700787000000
          Top = 0.755905510000000000
          Width = 102.047244094488000000
          Height = 13.228346460000000000
          DataField = 'QTDDUP'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."QTDDUP"]')
          ParentFont = False
        end
        object frxDBDatasetOcorVALDUP: TfrxMemoView
          Left = 654.236220470000000000
          Top = 0.755905510000000000
          Width = 98.267716540000000000
          Height = 13.228346460000000000
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."VALDUP"]')
          ParentFont = False
        end
        object frxDBDatasetOcorVALPAG: TfrxMemoView
          Left = 763.842519690000000000
          Top = 0.755905510000000000
          Width = 94.488188976378000000
          Height = 13.228346460000000000
          DataField = 'VALPAG_COMTAR'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."VALPAG_COMTAR"]')
          ParentFont = False
        end
        object frxDBDatasetOcorCUSCAR: TfrxMemoView
          Left = 872.314960630000000000
          Top = 0.755905510000000000
          Width = 98.267716535433100000
          Height = 13.228346460000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."VALPAG"]')
          ParentFont = False
        end
        object mmDescOcorrencia: TfrxMemoView
          Left = 4.779530000000000000
          Top = 0.755905511811024000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'mmDescOcorrenciaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmDescMotOco: TfrxMemoView
          Left = 75.590600000000000000
          Top = 0.755905510000000000
          Width = 457.323130000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'mmDescMotOcoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo135: TfrxMemoView
          Left = 981.921259842519900000
          Top = 0.755905510000000000
          Width = 98.267716535433100000
          Height = 13.228346460000000000
          DataField = 'CUSCAR'
          DataSet = frxDBDatasetOcor
          DataSetName = 'frxDBDatasetOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetOcor."CUSCAR"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        object Memo7: TfrxMemoView
          Left = 763.842519690000000000
          Top = 30.614173230000000000
          Width = 94.488188976378000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL PAGO')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 75.354360000000000000
          Top = 31.440940000000000000
          Width = 75.590600000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.220470000000000000
          Top = 31.440940000000000000
          Width = 66.141698110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 540.850393700787000000
          Top = 30.614173230000000000
          Width = 102.047244094488000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT. DUPLICATAS')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 872.314960630000000000
          Top = 30.614173230000000000
          Width = 98.267716535433100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LAN'#199'ADO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baCenter
          Left = 480.945230945000000000
          Top = 3.779530000000000000
          Width = 141.732298110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGOS DE OCORR'#202'NCIAS')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 654.236220472441000000
          Top = 30.614173230000000000
          Width = 98.267716535433100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DUPLICATAS')
          ParentFont = False
        end
        object Memo134: TfrxMemoView
          Left = 981.921259842519900000
          Top = 30.614173230000000000
          Width = 98.267716535433100000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL CART'#211'RIO')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 166.299320000000000000
        Width = 1103.622760000000000000
        DataSet = frxDBDatasetTotOcor
        DataSetName = 'frxDBDatasetTotOcor'
        RowCount = 0
        object Memo17: TfrxMemoView
          Left = 382.574803150000000000
          Top = 1.889763779527560000
          Width = 153.070866140000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DUPLICATAS :')
          ParentFont = False
        end
        object frxDBDatasetTotOcorQTDDUP: TfrxMemoView
          Left = 540.850393700787000000
          Top = 1.889763780000000000
          Width = 102.047244094488000000
          Height = 11.338582680000000000
          DataField = 'QTDDUP'
          DataSet = frxDBDatasetTotOcor
          DataSetName = 'frxDBDatasetTotOcor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetTotOcor."QTDDUP"]')
          ParentFont = False
        end
        object frxDBDatasetTotOcorVALDUP: TfrxMemoView
          Left = 654.236220472441000000
          Top = 1.889763780000000000
          Width = 98.267716535433100000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetTotOcor
          DataSetName = 'frxDBDatasetTotOcor'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetTotOcor."VALDUP"]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 15.874015750000000000
        Top = 128.504020000000000000
        Width = 1103.622760000000000000
        AllowSplit = True
        object Memo10: TfrxMemoView
          Left = 383.015743150000000000
          Top = 2.267716535433070000
          Width = 153.070866140000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'TOTAL GERAL OCORR'#202'NCIAS :')
          ParentFont = False
        end
        object SysMemo15: TfrxSysMemoView
          Left = 540.850393700787000000
          Top = 2.267716540000000000
          Width = 102.047244094488000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."QTDDUP">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo16: TfrxSysMemoView
          Left = 654.236220472441000000
          Top = 2.267716540000000000
          Width = 98.267716535433100000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."VALDUP">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo17: TfrxSysMemoView
          Left = 763.842519690000000000
          Top = 2.267716540000000000
          Width = 94.488188976378000000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."VALPAG_COMTAR">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo19: TfrxSysMemoView
          Left = 872.314960630000000000
          Top = 2.267716540000000000
          Width = 98.267716535433100000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."VALPAG">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo1: TfrxSysMemoView
          Left = 981.921259842519900000
          Top = 2.267716540000000000
          Width = 98.267716535433100000
          Height = 11.338582680000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetOcor."CUSCAR">,MasterData1)]')
          ParentFont = False
        end
      end
    end
    object Page3: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 109.606370000000000000
        Width = 1103.622760000000000000
        DataSet = frxDBDatasetNaoBaix
        DataSetName = 'frxDBDatasetNaoBaix'
        RowCount = 0
        object Memo27: TfrxMemoView
          Left = 1.779530000000000000
          Top = 0.377952760000000000
          Width = 325.039345670000000000
          Height = 15.118110240000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 570.944881889764000000
          Top = 0.377952760000000000
          Width = 79.370078740157500000
          Height = 15.118110240000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 743.645950000000000000
          Top = 0.377952755905500000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 807.496062990000000000
          Top = 0.377952755905500000
          Width = 75.590553620000000000
          Height = 15.118110240000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 1026.488188980000000000
          Top = 0.377952760000000000
          Width = 71.811023620000000000
          Height = 15.118110240000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 886.157480310000000000
          Top = 0.377952755905500000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 450.173228350000000000
          Top = 0.377952760000000000
          Width = 117.165378740000000000
          Height = 15.118110240000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 956.078740160000000000
          Top = 0.377952755905500000
          Width = 66.141732280000000000
          Height = 15.118110240000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 330.874015750000000000
          Top = 0.377952760000000000
          Width = 115.275590550000000000
          Height = 15.118110240000000000
          DataField = 'MOTDIV'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."MOTDIV"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Left = 683.968770000000000000
          Top = 0.377952760000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo51: TfrxMemoView
          Left = 653.370440000000000000
          Top = 0.377952755905500000
          Width = 26.456692910000000000
          Height = 15.118110240000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetNaoBaix
          DataSetName = 'frxDBDatasetNaoBaix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNaoBaix."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        object Memo42: TfrxMemoView
          Align = baCenter
          Left = 479.055465945000000000
          Top = 3.779530000000000000
          Width = 145.511828110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'DUPLICATAS N'#195'O BAIXADAS')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 15.118110240000000000
        Top = 71.811070000000000000
        Width = 1103.622760000000000000
        object Memo33: TfrxMemoView
          Left = 569.944881890000000000
          Top = 1.889763780000000000
          Width = 79.370078740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 682.700990000000000000
          Top = 1.889763780000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 449.173228350000000000
          Top = 1.889763780000000000
          Width = 117.165378740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 2.440940000000000000
          Top = 1.889763780000000000
          Width = 325.039345670000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 653.338900000000000000
          Top = 1.889763780000000000
          Width = 26.456692910000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 806.496062990000000000
          Top = 1.889763780000000000
          Width = 75.590553620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 885.157480310000000000
          Top = 1.889763780000000000
          Width = 66.141732280000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 1025.488188980000000000
          Top = 1.889763780000000000
          Width = 71.811023620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUPLIC')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 743.291590000000000000
          Top = 1.889763780000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG.')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 955.078740160000000000
          Top = 1.889763780000000000
          Width = 66.141732280000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 329.874015750000000000
          Top = 1.889763780000000000
          Width = 115.275590550000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'MOTIVO')
          ParentFont = False
        end
      end
    end
    object Page4: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 16.496062990000000000
        Top = 188.976500000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'MasterData4OnBeforePrint'
        DataSet = frxDBDatasetJaBaixadas
        DataSetName = 'frxDBDatasetJaBaixadas'
        RowCount = 0
        object mmoZebraRet: TfrxMemoView
          Left = 2.000000000000000000
          Top = 1.755905510000000000
          Width = 1102.701300000000000000
          Height = 14.362204720000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object Memo52: TfrxMemoView
          Left = 1.779530000000000000
          Top = 0.755905510000000000
          Width = 258.897588980000000000
          Height = 12.094488190000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo53: TfrxMemoView
          Left = 493.779527560000000000
          Top = 0.755905511811024000
          Width = 83.149606300000000000
          Height = 12.094488190000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 671.417322830000000000
          Top = 0.755905511811024000
          Width = 56.692913390000000000
          Height = 12.094488190000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 732.094488188976000000
          Top = 0.755905511811024000
          Width = 68.031496062992100000
          Height = 12.094488190000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 1032.566929133860000000
          Top = 0.755905511811024000
          Width = 68.031496062992100000
          Height = 12.094488190000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo58: TfrxMemoView
          Left = 855.307086614173100000
          Top = 0.755905511811024000
          Width = 54.803149606299200000
          Height = 12.094488190000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 366.149660000000000000
          Top = 0.755905510000000000
          Width = 124.724433860000000000
          Height = 12.094488190000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 913.511811023622000000
          Top = 0.755905511811024000
          Width = 54.803149606299200000
          Height = 12.094488190000000000
          DataField = 'OUTVAL'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."OUTVAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          Left = 266.157480310000000000
          Top = 0.755905510000000000
          Width = 66.141732280000000000
          Height = 12.094488190000000000
          DataField = 'CEPCLI'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo63: TfrxMemoView
          Left = 610.968770000000000000
          Top = 0.755905511811024000
          Width = 56.692913390000000000
          Height = 12.094488190000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo64: TfrxMemoView
          Left = 580.055350000000000000
          Top = 0.755905511811024000
          Width = 26.456710000000000000
          Height = 12.094488190000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo87: TfrxMemoView
          Left = 973.228346456693000000
          Top = 0.755905511811024000
          Width = 54.803149606299200000
          Height = 12.094488190000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo88: TfrxMemoView
          Left = 334.944881890000000000
          Top = 0.755905510000000000
          Width = 28.346456690000000000
          Height = 12.094488190000000000
          DataField = 'CODOCO'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."CODOCO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo138: TfrxMemoView
          Left = 802.015748031496100000
          Top = 0.755905511811024000
          Width = 51.023622047244100000
          Height = 12.094488190000000000
          DataField = 'TARIFA'
          DataSet = frxDBDatasetJaBaixadas
          DataSetName = 'frxDBDatasetJaBaixadas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetJaBaixadas."TARIFA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 109.606299210000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'Header3OnBeforePrint'
        Child = frxRetBcoTarifa.Child2
        object Memo65: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 20.897650000000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATAS J'#193' BAIXADAS QUE CONSTAVAM NO ARQUIVO RETORNO')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 0.779530000000000000
          Top = 70.692950000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[NOMBCOBAIX]')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 0.779530000000000000
          Top = 90.590600000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 2.267716540000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo80: TfrxMemoView
          Left = 1012.410020000000000000
          Top = 23.811023620000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 954.889763780000000000
          Top = 24.944881890000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Align = baRight
          Left = 1018.659000000000000000
          Top = 2.267716540000000000
          Width = 84.963760000000000000
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
        object Memo83: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 39.795300000000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
      end
      object ReportSummary2: TfrxReportSummary
        FillType = ftBrush
        Height = 20.787401574803200000
        Top = 264.567100000000000000
        Width = 1103.622760000000000000
        object Memo84: TfrxMemoView
          Left = 661.433520000000000000
          Top = 3.779527560000000000
          Width = 45.354360000000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object SysMemo20: TfrxSysMemoView
          Left = 710.094488190000000000
          Top = 3.779527560000000000
          Width = 90.031496060000000000
          Height = 12.472440940000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."VALPAG">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo21: TfrxSysMemoView
          Left = 855.307086614173100000
          Top = 3.779527559055120000
          Width = 54.803149606299200000
          Height = 12.472440944881900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."JURMOR">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo22: TfrxSysMemoView
          Left = 913.511811023622000000
          Top = 3.779527559055120000
          Width = 54.803149606299200000
          Height = 12.472440944881900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."OUTVAL">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo23: TfrxSysMemoView
          Left = 973.228346456693000000
          Top = 3.779527559055120000
          Width = 54.803149606299200000
          Height = 12.472440944881900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."DESCON">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo24: TfrxSysMemoView
          Left = 1032.566929133860000000
          Top = 3.779527559055120000
          Width = 68.031496062992100000
          Height = 12.472440944881900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."VALDUP">,MasterData4)]')
          ParentFont = False
        end
        object SysMemo2: TfrxSysMemoView
          Left = 802.015748031496100000
          Top = 3.779527559055120000
          Width = 51.023622047244100000
          Height = 12.472440944881900000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetJaBaixadas."TARIFA">,MasterData4)]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 15.118110240000000000
        Top = 151.181200000000000000
        Width = 1103.622760000000000000
        object Memo66: TfrxMemoView
          Left = 493.779527560000000000
          Top = 3.023622047244090000
          Width = 83.149606300000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 610.700990000000000000
          Top = 3.023622047244090000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 366.385900000000000000
          Top = 3.023622050000000000
          Width = 124.724433860000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 2.440940000000000000
          Top = 3.023622050000000000
          Width = 258.897588980000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 581.023810000000000000
          Top = 3.023622047244090000
          Width = 26.456710000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 732.094488188976000000
          Top = 3.023622047244090000
          Width = 68.031496062992100000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 855.307086614173100000
          Top = 3.023622047244090000
          Width = 54.803149606299200000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 1032.566929133860000000
          Top = 3.023622047244090000
          Width = 68.031496062992100000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUPLIC')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 671.417322830000000000
          Top = 3.023622047244090000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG.')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 973.228346456693000000
          Top = 3.023622047244090000
          Width = 54.803149606299200000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo76: TfrxMemoView
          Left = 265.157480310000000000
          Top = 3.023622050000000000
          Width = 66.141732280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 334.944881890000000000
          Top = 3.023622050000000000
          Width = 28.346456690000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OC.')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 913.511811023622000000
          Top = 3.023622047244090000
          Width = 54.803149606299200000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'O. COB.')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 802.015748031496100000
          Top = 3.023622047244090000
          Width = 51.023622047244100000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TARIFA')
          ParentFont = False
        end
      end
      object PageFooter2: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677165350000000000
        Top = 309.921460000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageFooter2OnBeforePrint'
        object Memo128: TfrxMemoView
          Left = 927.016080000000000000
          Top = 0.377952760000000000
          Width = 112.906926670000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGISTRO IMPRESSOS:')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Top = 0.377952760000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object mmQtdeRegBaix: TfrxSysMemoView
          Left = 1042.500000000000000000
          Top = 0.377952760000000000
          Width = 55.380643330000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
    end
    object Page5: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 15.496062990000000000
        Top = 188.976500000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'MasterData5OnBeforePrint'
        DataSet = frxDBDatasetBaixadasLancaTarifa
        DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
        RowCount = 0
        object Memo14: TfrxMemoView
          Left = 1.779530000000000000
          Top = 1.133858270000000000
          Width = 258.897588980000000000
          Height = 12.094488190000000000
          DataField = 'CODCLI'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."CODCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 491.779527560000000000
          Top = 1.133858270000000000
          Width = 82.393700790000000000
          Height = 12.094488190000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 668.417322830000000000
          Top = 1.133858270000000000
          Width = 56.692913390000000000
          Height = 12.094488190000000000
          DataField = 'DTAPAG'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo90: TfrxMemoView
          Left = 729.228346460000000000
          Top = 1.133858270000000000
          Width = 70.677165354330700000
          Height = 12.094488190000000000
          DataField = 'VALPAG'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo91: TfrxMemoView
          Left = 1031.582677170000000000
          Top = 1.133858270000000000
          Width = 68.031496060000000000
          Height = 12.094488190000000000
          DataField = 'VALDUP'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo92: TfrxMemoView
          Left = 855.307086610000000000
          Top = 1.133858270000000000
          Width = 54.803149610000000000
          Height = 12.094488190000000000
          DataField = 'JURMOR'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo93: TfrxMemoView
          Left = 363.141732280000000000
          Top = 1.133858270000000000
          Width = 124.724409448819000000
          Height = 12.094488190000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo94: TfrxMemoView
          Left = 913.511811020000000000
          Top = 1.133858270000000000
          Width = 54.803149610000000000
          Height = 12.094488190000000000
          DataField = 'OUTVAL'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."OUTVAL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo95: TfrxMemoView
          Left = 265.157480310000000000
          Top = 1.133858270000000000
          Width = 62.362202280000000000
          Height = 12.094488190000000000
          DataField = 'CEPCLI'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."CEPCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo96: TfrxMemoView
          Left = 607.968770000000000000
          Top = 1.133858270000000000
          Width = 56.692913390000000000
          Height = 12.094488190000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo97: TfrxMemoView
          Left = 577.055350000000000000
          Top = 1.133858270000000000
          Width = 26.456710000000000000
          Height = 12.094488190000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo98: TfrxMemoView
          Left = 972.094488190000000000
          Top = 1.133858270000000000
          Width = 54.803149610000000000
          Height = 12.094488190000000000
          DataField = 'DESCON'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo99: TfrxMemoView
          Left = 331.944881890000000000
          Top = 1.133858270000000000
          Width = 28.346456690000000000
          Height = 12.094488190000000000
          DataField = 'CODOCO'
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."CODOCO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo122: TfrxMemoView
          Left = 804.125984250000000000
          Top = 0.929036220000000000
          Width = 47.244094490000000000
          Height = 12.094488190000000000
          DataSet = frxDBDatasetBaixadasLancaTarifa
          DataSetName = 'frxDBDatasetBaixadasLancaTarifa'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetBaixadasLancaTarifa."TARIFA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 109.606299210000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'Header4OnBeforePrint'
        object Memo100: TfrxMemoView
          Align = baCenter
          Left = 264.996419370000000000
          Top = 20.897650000000000000
          Width = 573.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              'DUPLICATAS J'#193' BAIXADAS QUE CONSTAVAM NO ARQUIVO RETORNO E QUE SE' +
              'R'#195'O LAN'#199'ADAS TARIFA')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 0.779530000000000000
          Top = 70.692950000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[NOMBCOBAIX]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 0.779530000000000000
          Top = 90.590600000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[ORDEM]')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 2.267716540000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
        object Memo104: TfrxMemoView
          Left = 1012.410020000000000000
          Top = 23.811023620000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 954.889763780000000000
          Top = 24.944881890000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Align = baRight
          Left = 1018.659000000000000000
          Top = 2.267716540000000000
          Width = 84.963760000000000000
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
        object Memo107: TfrxMemoView
          Align = baCenter
          Left = 351.496419370000000000
          Top = 39.795300000000000000
          Width = 400.629921260000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[DTARET]')
          ParentFont = False
        end
      end
      object ReportSummary3: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 264.567100000000000000
        Width = 1103.622760000000000000
        object Memo108: TfrxMemoView
          Left = 657.433520000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object SysMemo18: TfrxSysMemoView
          Left = 705.811006540000000000
          Top = 3.779530000000000000
          Width = 94.488206060000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."VALPAG">,MasterData5)]')
          ParentFont = False
        end
        object SysMemo25: TfrxSysMemoView
          Left = 855.307086610000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."JURMOR">,MasterData5)]')
          ParentFont = False
        end
        object SysMemo26: TfrxSysMemoView
          Left = 913.511811020000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."OUTVAL">,MasterData5)]')
          ParentFont = False
        end
        object SysMemo27: TfrxSysMemoView
          Left = 972.094488190000000000
          Top = 3.779530000000000000
          Width = 54.803149610000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."DESCON">,MasterData5)]')
          ParentFont = False
        end
        object SysMemo28: TfrxSysMemoView
          Left = 1028.582677170000000000
          Top = 3.779530000000000000
          Width = 68.031496060000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."VALDUP">,MasterData5)]')
          ParentFont = False
        end
        object SysMemo29: TfrxSysMemoView
          Left = 804.125984250000000000
          Top = 3.432900000000000000
          Width = 47.244094490000000000
          Height = 14.362204720000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetBaixadasLancaTarifa."TARIFA">,MasterData5)]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clScrollBar
        Height = 15.118110240000000000
        Top = 151.181200000000000000
        Width = 1103.622760000000000000
        object Memo109: TfrxMemoView
          Left = 491.779527560000000000
          Top = 3.023622050000000000
          Width = 82.393700790000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 607.700990000000000000
          Top = 3.023622050000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 363.141732280000000000
          Top = 3.023622050000000000
          Width = 124.724409448819000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 2.440940000000000000
          Top = 3.023622050000000000
          Width = 258.897588980000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 578.023810000000000000
          Top = 3.023622050000000000
          Width = 26.456710000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 729.228346460000000000
          Top = 3.023622050000000000
          Width = 70.677165354330700000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. PAGO')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 855.307086610000000000
          Top = 3.023622050000000000
          Width = 54.803149610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 1031.448818900000000000
          Top = 3.023622047244000000
          Width = 68.031496060000000000
          Height = 11.338582677165400000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUPLIC')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 668.417322830000000000
          Top = 3.023622050000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. PAG.')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 972.094488190000000000
          Top = 3.023622050000000000
          Width = 54.803149610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 265.157480310000000000
          Top = 3.023622050000000000
          Width = 62.362202280000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 331.944881890000000000
          Top = 3.023622050000000000
          Width = 28.346456690000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OC.')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 913.511811020000000000
          Top = 3.023622050000000000
          Width = 54.803149610000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'O. COB.')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 804.125984250000000000
          Top = 2.818800000000000000
          Width = 47.244094490000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'TARIFA')
          ParentFont = False
        end
      end
      object PageFooter3: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = [ftTop]
        Height = 22.677165350000000000
        Top = 309.921460000000000000
        Width = 1103.622760000000000000
        OnBeforePrint = 'PageFooter3OnBeforePrint'
        object Memo132: TfrxMemoView
          Left = 926.016080000000000000
          Top = 0.377952760000000000
          Width = 112.906926670000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGISTRO IMPRESSOS:')
          ParentFont = False
        end
        object Memo133: TfrxMemoView
          Top = 0.377952760000000000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
        object mmqtdRegBaixLcTar: TfrxSysMemoView
          Left = 1041.500000000000000000
          Top = 0.377952760000000000
          Width = 55.380643330000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
      end
    end
    object Page6: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object Header5: TfrxHeader
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 18.897650000000000000
        Width = 1103.622760000000000000
        Child = frxRetBcoTarifa.Child6
        object Memo136: TfrxMemoView
          Left = 486.803154490000000000
          Top = 7.559055120000000000
          Width = 105.826771650000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#211'DIGO DE ERRO PIX')
          ParentFont = False
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Fill.BackColor = clSilver
        Height = 22.677180000000000000
        Top = 71.811070000000000000
        Width = 1103.622760000000000000
        object Memo143: TfrxMemoView
          Left = 693.078850000000000000
          Top = 3.779530000000000000
          Width = 79.370078740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'NUM. DUP.')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 924.858377560000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. VENC.')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 614.307196460000000000
          Top = 3.779530000000000000
          Width = 75.590548740000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'NOSSO NUM')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 894.472868110000000000
          Top = 3.779530000000000000
          Width = 26.456692910000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo158: TfrxMemoView
          Left = 1042.622157090000000000
          Top = 3.779530000000000000
          Width = 52.913373620000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DUP.')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Left = 983.425558110000000000
          Top = 3.779530000000000000
          Width = 56.692920710000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'DT. CAD.')
          ParentFont = False
        end
        object Memo161: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 62.362182760000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'COD. ERRO')
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 776.464750000000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 837.472870550000000000
          Top = 3.779530000000000000
          Width = 52.913390710000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'EPS. DOC.')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 72.031540000000000000
          Top = 3.779530000000000000
          Width = 62.362182760000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 117.165430000000000000
        Width = 1103.622760000000000000
        Condition = 'frxDBDatasetCodigoErroPIX."ERRPIX"'
        KeepTogether = True
        object Memo151: TfrxMemoView
          Left = 3.401574800000000000
          Top = 3.779530000000000000
          Width = 765.354650470000000000
          Height = 15.118110240000000000
          DataField = 'DESCRICAO_ERRPIX'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DESCRICAO_ERRPIX"]')
          ParentFont = False
        end
      end
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 166.299320000000000000
        Width = 1103.622760000000000000
        DataSet = frxDBDataSetCodigoErroPIX
        DataSetName = 'frxDBDatasetCodigoErroPIX'
        RowCount = 0
        object Memo152: TfrxMemoView
          Left = 3.779527560000000000
          Top = 3.779530000000000000
          Width = 62.362204720000000000
          Height = 11.338582680000000000
          DataField = 'ERRPIX'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."ERRPIX"]')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Left = 72.188976380000000000
          Top = 3.779530000000000000
          Width = 534.803454720000000000
          Height = 11.338582680000000000
          DataField = 'CLIENTE'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."CLIENTE"]')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 614.173228350000000000
          Top = 3.779530000000000000
          Width = 75.590551180000000000
          Height = 11.338582680000000000
          DataField = 'NOSNUM'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."NOSNUM"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 693.165354330000000000
          Top = 3.779530000000000000
          Width = 79.370078740000000000
          Height = 11.338582680000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."NUMDUP"]')
          ParentFont = False
        end
        object Memo144: TfrxMemoView
          Left = 776.314960630000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          DataField = 'PARCEL'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."PARCEL"]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 837.543307090000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 11.338582680000000000
          DataField = 'ESPDOC'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."ESPDOC"]')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 894.614173230000000000
          Top = 3.779530000000000000
          Width = 26.456692910000000000
          Height = 11.338582680000000000
          DataField = 'CODEMP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."CODEMP"]')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 924.850393700000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DTAVEN"]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 983.433070870000000000
          Top = 3.779530000000000000
          Width = 56.692913390000000000
          Height = 11.338582680000000000
          DataField = 'DTACAD'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."DTACAD"]')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 1042.771653540000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 11.338582680000000000
          DataField = 'VALDUP'
          DataSet = frxDBDataSetCodigoErroPIX
          DataSetName = 'frxDBDatasetCodigoErroPIX'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetCodigoErroPIX."VALDUP"]')
          ParentFont = False
        end
      end
    end
  end
  object qryBaixadasLancaTarifa: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      
        'SELECT IF(RET_MOTOCO <> '#39'00'#39' AND RET_CODBCO IN (SELECT DISTINCT(' +
        'OCO_CODBCO) FROM OCOBAN), '
      
        '       CONCAT(RET_CODOCO, '#39'.'#39', RET_MOTOCO), RET_CODOCO) AS CODOC' +
        'O, RET_NOSNUM AS NOSNUM, '
      '       CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, '
      '       RET_CODEMP AS CODEMP, RET_DTAVEN AS DTAVEN, '
      
        '       IF( RET_VALPAG <> 0 ,IF(RET_DTAOCO IS NULL, RET_DTAPAG, R' +
        'ET_DTAOCO), NULL) AS DTAPAG, '
      '       R.CTR_VALREC AS VALPAG, RET_JURMOR AS JURMOR, '
      '       RET_DESCON AS DESCON, RET_OUTVAL AS OUTVAL, '
      '       RET_VALDUP AS VALDUP, RET_CODREJ, RET_CODBCO, '
      '       RET_CARTEI AS CARTEI, '
      '       CONCAT(RET_CODCLI, '#39'-'#39', CLI_NOMCLI) AS CODCLI, '
      '       IFNULL(RET_TARIFA, 0.00) AS TARIFA,  '
      
        '       CONCAT(RET_NOMARQ, '#39' - '#39', RET_DTAARQ, '#39' - '#39', RET_HORARQ) ' +
        'AS NOMARQ, CLI_C_E_P_ AS CEPCLI, '
      
        '       IFNULL(R.CTR_DESSUJ,0.00) AS CTR_DESSUJ, R.CTR_DTAVEN, R.' +
        'CTR_VALORI, R.CTR_VALDUP, 0.00 AS VALCOR, 0.00 AS VALDIF, MAX(DE' +
        'T.DET_DTARET) AS DTARET, RET_CUSCAR AS CUSCAR, RET_CARBCO AS CAR' +
        'BCO, '
      
        '       RET_IOFDES AS IOFDES, RET_TXADES AS TXADES, RET_JUROPE AS' +
        ' JUROPE '
      '  FROM RETBCO '
      '  LEFT JOIN CADCLI ON CLI_CODCLI = RET_CODCLI '
      '  LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP '
      '                  AND R.CTR_CODCLI = RET_CODCLI '
      '                  AND R.CTR_NUMDUP = RET_NUMDUP '
      '                  AND R.CTR_PARCEL = RET_PARCEL '
      '                  AND R.CTR_ESPDOC = RET_ESPDOC '
      '                  AND R.CTR_SEQBAI = 0          '
      '  LEFT JOIN RETDET DET ON DET.DET_DUPLIC = R.AUTOINCREM '
      ' WHERE RET_CODBCO = '#39'341'#39' AND '
      '       IFNULL(RET_DUPDIV, '#39'N'#39') <> '#39'S'#39' AND '
      ' '
      ' -- APENAS  TARIFAS QUANDO BANCO FOR 341;      '
      '       LOCATE(RET_CODOCO, '#39'09_35'#39') > 0 AND '
      '       CTR_DTAREC IS NOT NULL '
      ' GROUP BY RET_NUMDUP, RET_PARCEL, RET_CODOCO  '
      ' ORDER BY RET_CODOCO, RET_MOTOCO, RET_DTAVEN  ')
    Left = 434
    Top = 211
    object qryBaixadasLancaTarifaCODOCO: TStringField
      FieldName = 'CODOCO'
      ReadOnly = True
      Size = 86
    end
    object qryBaixadasLancaTarifaNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryBaixadasLancaTarifaNUMDUP: TStringField
      FieldName = 'NUMDUP'
      ReadOnly = True
      Required = True
      Size = 15
    end
    object qryBaixadasLancaTarifaCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryBaixadasLancaTarifaDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryBaixadasLancaTarifaDTAPAG: TDateField
      FieldName = 'DTAPAG'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaVALPAG: TFloatField
      FieldName = 'VALPAG'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object qryBaixadasLancaTarifaDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object qryBaixadasLancaTarifaOUTVAL: TFloatField
      FieldName = 'OUTVAL'
    end
    object qryBaixadasLancaTarifaVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryBaixadasLancaTarifaRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      FixedChar = True
      Size = 2
    end
    object qryBaixadasLancaTarifaRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryBaixadasLancaTarifaCARTEI: TIntegerField
      FieldName = 'CARTEI'
    end
    object qryBaixadasLancaTarifaCODCLI: TStringField
      FieldName = 'CODCLI'
      ReadOnly = True
      Size = 69
    end
    object qryBaixadasLancaTarifaTARIFA: TFloatField
      FieldName = 'TARIFA'
      ReadOnly = True
      Required = True
    end
    object qryBaixadasLancaTarifaNOMARQ: TStringField
      FieldName = 'NOMARQ'
      ReadOnly = True
      Size = 46
    end
    object qryBaixadasLancaTarifaCEPCLI: TStringField
      FieldName = 'CEPCLI'
      ReadOnly = True
      Size = 9
    end
    object qryBaixadasLancaTarifaCTR_DESSUJ: TFloatField
      FieldName = 'CTR_DESSUJ'
      ReadOnly = True
      Required = True
    end
    object qryBaixadasLancaTarifaCTR_DTAVEN: TDateField
      FieldName = 'CTR_DTAVEN'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaCTR_VALORI: TFloatField
      FieldName = 'CTR_VALORI'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaCTR_VALDUP: TFloatField
      FieldName = 'CTR_VALDUP'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaVALCOR: TFloatField
      FieldName = 'VALCOR'
      ReadOnly = True
      Required = True
    end
    object qryBaixadasLancaTarifaVALDIF: TFloatField
      FieldName = 'VALDIF'
      ReadOnly = True
      Required = True
    end
    object qryBaixadasLancaTarifaDTARET: TDateField
      FieldName = 'DTARET'
      ReadOnly = True
    end
    object qryBaixadasLancaTarifaCUSCAR: TFloatField
      FieldName = 'CUSCAR'
    end
    object qryBaixadasLancaTarifaCARBCO: TStringField
      FieldName = 'CARBCO'
      FixedChar = True
      Size = 3
    end
    object qryBaixadasLancaTarifaIOFDES: TFloatField
      FieldName = 'IOFDES'
    end
    object qryBaixadasLancaTarifaTXADES: TFloatField
      FieldName = 'TXADES'
    end
    object qryBaixadasLancaTarifaJUROPE: TFloatField
      FieldName = 'JUROPE'
    end
  end
  object frxDBDatasetBaixadasLancaTarifa: TfrxDBDataset
    UserName = 'frxDBDatasetBaixadasLancaTarifa'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'NOSNUM=NOSNUM'
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'DTAVEN=DTAVEN'
      'DTAPAG=DTAPAG'
      'VALPAG=VALPAG'
      'JURMOR=JURMOR'
      'DESCON=DESCON'
      'OUTVAL=OUTVAL'
      'VALDUP=VALDUP'
      'RET_CODREJ=RET_CODREJ'
      'RET_CODBCO=RET_CODBCO'
      'CARTEI=CARTEI'
      'CODCLI=CODCLI'
      'TARIFA=TARIFA'
      'NOMARQ=NOMARQ'
      'CEPCLI=CEPCLI'
      'CTR_DESSUJ=CTR_DESSUJ'
      'CTR_DTAVEN=CTR_DTAVEN'
      'CTR_VALORI=CTR_VALORI'
      'CTR_VALDUP=CTR_VALDUP'
      'VALCOR=VALCOR'
      'VALDIF=VALDIF'
      'DTARET=DTARET'
      'CUSCAR=CUSCAR'
      'CARBCO=CARBCO'
      'IOFDES=IOFDES'
      'TXADES=TXADES'
      'JUROPE=JUROPE')
    DataSet = qryBaixadasLancaTarifa
    BCDToCurrency = False
    Left = 278
    Top = 211
  end
  object qryCodigoErroPix: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      '')
    Options.SetFieldsReadOnly = False
    AutoCalcFields = False
    Left = 440
    Top = 168
  end
  object frxDBDataSetCodigoErroPIX: TfrxDBDataset
    UserName = 'frxDBDatasetCodigoErroPIX'
    CloseDataSource = False
    DataSet = qryCodigoErroPix
    BCDToCurrency = False
    Left = 320
    Top = 168
  end
end
