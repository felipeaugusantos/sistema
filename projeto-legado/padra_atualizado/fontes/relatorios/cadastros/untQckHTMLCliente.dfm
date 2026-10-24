object frmQckHTMLCliente: TfrmQckHTMLCliente
  Left = 566
  Top = 396
  Caption = 'frmQckHTMLCliente'
  ClientHeight = 303
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxRetrato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    OldStyleProgress = True
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 44739.432372303200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin        '
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    If (<frxRelatorio."STATUS3"> = '#39'1'#39') Then'
      '    Begin                '
      '      TotalVencidas.Visible   := False;                        '
      '      TotalVencer.Visible     := False;'
      '      mmTotalVencer.Visible   := True;'
      
        '      mmTotalVencidas.Visible := True;                          ' +
        '        '
      '    End;                '
      ''
      '    mmTotalDup.Text         := '#39'Total Recebido'#39';'
      '    TotalDuplicatas.Visible := False;'
      
        '    TotalRecebido.Visible   := True;                            ' +
        '             '
      '  '
      '    mmTotalCor.Text         := '#39'Total Diferen'#231'a'#39';'
      '    TotalCorrigidos.Visible := False;'
      
        '    If TotalDiferenca.Visible <> False Then                     ' +
        '                         '
      '      TotalDiferenca.Visible  := True;'
      '    TotalJuros.Text         := '#39'0.00'#39';'
      '    mmResumoJuros.Text      := '#39'Total Diferen'#231'a'#39';'
      
        '    ResumoTotalJuros.DataField := '#39'TOTALDIFERENCA'#39';             ' +
        '       '
      '  End'
      '  Else'
      '  Begin              '
      '    Memo51.Visible := False;'
      '    If TotalCorrigidos.Visible <> False Then        '
      '      TotalCorrigidos.Visible := True;'
      '    TotalDiferenca.Visible := False;        '
      '  End;                  '
      'end;'
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin    '
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      ''
      '    //Campos de Labels'
      '    mmVlrDuplicata.Text    := '#39'Vl. Receb.'#39';'
      '    mmVlrJuros.Text        := '#39'Diferen'#231'a'#39';'
      ''
      '    //Campos de Dados      '
      '    dbVlrDuplicata.DataField  := '#39'VALORRECEBIDO'#39';'
      '    dbVlrJuros.DataField      := '#39'DIFERENCA'#39';        '
      '  End;     '
      'end;                                                           '
      ''
      'procedure gfDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."CODITEM"> = '#39#39' Then'
      '    gfDuplicatas.Visible := False'
      '  Else                         '
      '    gfDuplicatas.Visible := True;              '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CEnderecoEntrega.Visible := (<frxRelatorio."ENDERECO_ENTREGA">' +
        ' <> '#39#39');            '
      
        '  CObservacao.Visible := ((<frxRelatorio."OBS001"> <> '#39#39') Or (<f' +
        'rxRelatorio."OBS002"> <> '#39#39'));'
      '    '
      '  MasterData1.Visible := (<frxRelatorio."CODITEM"> <> '#39#39');      '
      'end;'
      ''
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure pExibeGrid(blnOpcao: Boolean);'
      'begin'
      '  sItensDuplicata.Visible := blnOpcao;'
      '  Line2.Visible  := blnOpcao;'
      '  Line50.Visible := blnOpcao;      '
      '  Line24.Visible := blnOpcao;'
      '  Line25.Visible := blnOpcao;'
      '  Line26.Visible := blnOpcao;'
      '  Line27.Visible := blnOpcao;'
      '  Line28.Visible := blnOpcao;'
      '  Line29.Visible := blnOpcao;'
      '  Line30.Visible := blnOpcao;'
      '  Line31.Visible := blnOpcao;'
      '  Case <bChkJuros> Of'
      '    0 : Begin'
      '          Line32.Visible := blnOpcao;'
      '          Line33.Visible := blnOpcao;'
      '        End;                        '
      '    1 : Begin              '
      '          Line32.Visible := False;'
      '          Line33.Visible := False;'
      
        '        End;                                                    ' +
        '          '
      '  End;'
      '  Line49.Visible := blnOpcao;'
      '  Line48.Visible := blnOpcao;      '
      'end;  '
      '         '
      'procedure ghDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  pExibeGrid(True);                                         '
      '  '
      '  If (<frxRelatorio."ORDEM2"> = '#39'AG'#39') Then      '
      '  Begin                                              '
      '    dbEspecie.Color        := $0001A6FE;'
      '    dbDuplicata.Color      := $0001A6FE;'
      '    dbEspecie.Font.Color   := clBlack;'
      '    dbDuplicata.Font.Color := clBlack;        '
      '    dbEspecie.Font.Style   := fsBold;'
      '    dbDuplicata.Font.Style := fsBold;'
      
        '    dbDuplicata.Visible    := True;                             ' +
        '                                                        '
      '  End            '
      '  Else If (<frxRelatorio."ORDEM2"> = '#39'AH'#39') Then                '
      '  Begin'
      '    dbEspecie.Color        := clNone;'
      '    dbDuplicata.Color      := clNone;      '
      '    dbEspecie.Font.Color   := $0001A6FE;'
      '    dbDuplicata.Font.Color := $0001A6FE;      '
      '    dbEspecie.Font.Style   := fsBold;'
      '    dbDuplicata.Font.Style := fsBold;             '
      '    dbDuplicata.Visible    := True;'
      '    pExibeGrid(False);        '
      '  End'
      '  Else'
      '  Begin'
      '    dbEspecie.Color        := clNone;'
      '    dbDuplicata.Color      := clNone;      '
      '    dbEspecie.Font.Color   := clBlack;'
      '    dbDuplicata.Font.Color := clBlack;                     '
      '    dbEspecie.Font.Style   := nil;'
      '    dbDuplicata.Font.Style := nil;'
      
        '    dbDuplicata.Visible    := False;                            ' +
        '                                                         '
      '  End;'
      ''
      '  If (dbVlrDuplicata.Text = '#39'0.00'#39') Then'
      '  begin'
      
        '    dbVlrJuros.Text := '#39'0.00'#39';                                  ' +
        '                                           '
      '  end;      '
      'end;'
      ''
      'procedure FResumoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure PageHeader2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure ChildSumaryOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                             '
      'end;'
      ''
      'procedure ReportSummary2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure Header2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    RResumoDuplicata.Text      := '#39'Total Recebido:'#39';'
      
        '    ResumoRecebido.Visible  := True;                            ' +
        '             '
      '  '
      
        '    If ResumoDiferenca.Visible <> False Then                    ' +
        '                        '
      '      ResumoDiferenca.Visible := True;'
      
        '    ResumoJuros.Text        := '#39'0.00'#39';                          ' +
        '                                                                ' +
        ' '
      '  End;    '
      'end;'
      ''
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxInformacoes."CHEQUE"> = '#39'N'#39' Then'
      '    SubResumo.Visible  := True'
      '  Else'
      
        '    SubCheques.Visible := True;                                 ' +
        '        '
      'end;'
      ''
      'procedure mmResumoVencidasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    RResumoDuplicata.Text      := '#39'Total Recebido:'#39';'
      
        '    ResumoRecebido.Visible  := True;                            ' +
        '             '
      '  '
      '    RResumoCorrigido.Text       := '#39'Total Diferen'#231'a:'#39';'
      '    ResumoCorrigido.Visible := False;'
      '    If ResumoDiferenca.Visible <> False Then        '
      '      ResumoDiferenca.Visible := True;'
      ''
      '    ResumoTotalDiferenca.Visible := False;          '
      '  End'
      '  Else'
      '  If (<frxRelatorio."STATUS1"> = '#39'A'#39') Then'
      '    ResumoTotalDiferenca.Visible := False;      '
      'end;'
      '                   '
      ''
      ''
      'procedure rllDuplicataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      '  rllDuplicata.Text := <frxRelatorio."NUMDUP">;'
      ''
      '  If (<frxRelatorio."ORDEM2"> = '#39'AG'#39') Then'
      '    ChildGHDuplicatas.Visible := False'
      '  Else'
      '    ChildGHDuplicatas.Visible := True;                         '
      '    '
      'end;'
      ''
      'procedure mmDesEspOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If SUM(<frxRelatorio."TOTALDESESP">,MasterData1) = 0 Then'
      '    mmDesEsp.Text := '#39#39';                               '
      'end;'
      ''
      'procedure dbTOTALDESESPOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' If SUM(<frxRelatorio."TOTALDESESP">,MasterData1) = 0 Then'
      '   dbTOTALDESESP.Text := '#39#39';                               '
      'end;'
      ''
      'procedure dbFoneEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFoneEmpresa.Text) = '#39#39') then'
      '    dbFoneEmpresa.Text := '#39#39'  '
      '  else                     '
      
        '    dbFoneEmpresa.Text := fFormataFonePaisInterna(Trim(dbFoneEmp' +
        'resa.Text));  '
      'end;'
      ''
      'procedure dbFoneEmpresa2OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFoneEmpresa.Text) = '#39#39') then'
      '    dbFoneEmpresa2.Text := '#39#39'  '
      '  else                     '
      
        '    dbFoneEmpresa2.Text := fFormataFonePaisInterna(Trim(dbFoneEm' +
        'presa2.Text));  '
      'end;'
      ''
      'procedure dbFaxEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFaxEmpresa.Text) = '#39#39') then'
      '    dbFaxEmpresa.Text := '#39#39'  '
      '  else                     '
      
        '    dbFaxEmpresa.Text := fFormataFonePaisInterna(Trim(dbFaxEmpre' +
        'sa.Text));  '
      'end;'
      ''
      'procedure dbTelefoneClienteOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbTelefoneCliente.Text) = '#39#39') then'
      '    dbTelefoneCliente.Text := '#39#39'  '
      '  else                     '
      
        '    dbTelefoneCliente.Text := fFormataFonePaisInterna(Trim(dbTel' +
        'efoneCliente.Text));  '
      'end;'
      ''
      ''
      'procedure dbTelefoneCliente2OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbTelefoneCliente2.Text) = '#39#39') then'
      '    dbTelefoneCliente2.Text := '#39#39'  '
      '  else                     '
      
        '    dbTelefoneCliente2.Text := fFormataFonePaisInterna(Trim(dbTe' +
        'lefoneCliente2.Text));  '
      'end; '
      ''
      'procedure Memo47OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  if (dbDtarecew.DataField = '#39'DATAVENCIMENTO'#39') OR (dbDtaCadast' +
        'ro.DataField = '#39#39') then                                         ' +
        '                                                                ' +
        '            '
      '//  begin            '
      
        '    // fun'#231#227'o para recalculo da data de vencimento e dias de atr' +
        'aso no label'
      
        '    Memo47.DataField   := '#39#39';                                   ' +
        '                '
      
        '    Memo47.Text        := fDiasAtraso(<frxRelatorio."DIASATRASO"' +
        '>,<frxRelatorio."DATAVENCIMENTO">, <frxRelatorio."DATARECEBIMENT' +
        'O">, 1);'
      '//  end;                  '
      'end;'
      ''
      'procedure dbDtaCadastroOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure dbVlrOriginalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  dbVlrOriginal.DataField  := '#39'VALORORIGINAL'#39';        '
      'end;'
      ''
      'procedure mmTotalJurosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."STATUS3"> = '#39'2'#39') Then'
      '  Begin'
      '    mmTotalJuros.Text     := '#39'Vl. Dup. Orig.'#39';'
      '    RResumoJuros.Text     := '#39'Vl. Dup. Orig.'#39';'
      '    ResumoJuros.DataField := '#39'TOTALDUPLICATA'#39';'
      
        '    If Memo51.Visible <> False Then                             ' +
        '                 '
      '      Memo51.Visible        := True;'
      
        '    TotalJuros.Visible    := False;                             ' +
        '                    '
      '  end;  '
      'end;'
      ''
      'procedure RResumoDuplicataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio."STATUS3"> <> '#39'2'#39') and (<frxRelatorio."STATU' +
        'S2"> <> '#39'B'#39') Then'
      '  begin'
      '    RResumoDuplicata.Text   := '#39'Total Dup. Original'#39';'
      '    Memo53.Visible          := True;'
      
        '    ResumoRecebido.Visible  := False;                           ' +
        '                                                         '
      '    RResumoDiferenca.Text   := '#39'Total Duplicata'#39';'
      
        '    If Memo54.Visible <> False Then                             ' +
        '                          '
      '      Memo54.Visible        := True'
      '    Else'
      
        '      ResumoDiferenca.Visible := False;                         ' +
        '                     '
      '    Memo54.DataField        := '#39'TOTALDUP'#39';        '
      
        '    ResumoDiferenca.Visible := False;                           ' +
        '                      '
      '  end'
      '  Else            '
      '    Memo54.Visible          := False;      '
      'end;'
      ''
      'procedure mmResumoJurosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."STATUS3"> = '#39'2'#39') Then'
      '  begin'
      '    mmResumoJuros.Text         := '#39'Total Diferen'#231'a'#39';'
      
        '    ResumoTotalJuros.DataField := '#39'TOTALDIFERENCA'#39';             ' +
        '                                 '
      '  end;          '
      'end;'
      ''
      'procedure dbDtaRecebOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  IF (<frxRelatorio."DATARECEBIMENTO"> <= 0) then    '
      '    dbDtaReceb.Text := '#39#39
      '  else'
      
        '     dbDtaReceb.Text := formatdatetime('#39'dd/mm/yy'#39',<frxRelatorio.' +
        '"DATARECEBIMENTO">);                                            ' +
        '           '
      'end;'
      ''
      'procedure dbDtaVencimentoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  dbDtavencimento.Text := fDiasAtraso(<frxRelatorio."DIASATRASO"' +
        '>,<frxRelatorio."DATAVENCIMENTO">,<frxRelatorio."DATARECEBIMENTO' +
        '">, 2);    '
      'end;'
      ''
      'begin                        '
      'end.')
    OnUserFunction = frxRetratoUserFunction
    Left = 16
    Top = 8
    Datasets = <
      item
        DataSet = frxCheque
        DataSetName = 'frxCheque'
      end
      item
        DataSet = frxCliente
        DataSetName = 'frxCliente'
      end
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxInformacoes
        DataSetName = 'frxInformacoes'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTotal
        DataSetName = 'frxTotal'
      end>
    Variables = <
      item
        Name = ' Vari'#225'veis'
        Value = Null
      end
      item
        Name = 'bChkJuros'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 3.500000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 370.393940000000000000
        Top = 18.897650000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Imagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 17.559060000000000000
          Top = 57.559060000000000000
          Width = 224.133890000000000000
          Height = 101.677180000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 50.338589999999990000
          Width = 351.496290000000000000
          Height = 15.118120000000000000
          DataField = 'EMPRESA'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMPRESA"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 262.519790000000000000
          Top = 66.015770000000000000
          Width = 710.551640000000000000
          Height = 15.118120000000000000
          DataField = 'ENDERECO'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."ENDERECO"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 296.315090000000000000
          Top = 112.929190000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFoneEmpresaOnAfterData'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE1"]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 294.535560000000000000
          Top = 97.047310000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CEP'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 291.756030000000000000
          Top = 129.385900000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFaxEmpresaOnAfterData'
          DataField = 'EMP_F_A_X_'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_F_A_X_"]')
          ParentFont = False
        end
        object dbDataEmpresa: TfrxMemoView
          Left = 329.330860000000000000
          Top = 145.181200000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'DATA'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 263.110390000000000000
          Top = 113.370130000000000000
          Width = 30.614173228346500000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 263.110390000000000000
          Top = 128.606370000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object mmCEPEmpresa: TfrxMemoView
          Left = 263.110390000000000000
          Top = 96.929190000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object mmEmitidoEm: TfrxMemoView
          Left = 263.110390000000000000
          Top = 144.622140000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em :')
          ParentFont = False
        end
        object mmDadosCliente: TfrxMemoView
          Align = baLeft
          Top = 181.756030000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Dados do Cliente ')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Align = baLeft
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cod./Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Align = baLeft
          Left = 64.252010000000000000
          Top = 202.433210000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."NOME"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Align = baLeft
          Top = 235.889920000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Align = baLeft
          Left = 64.252010000000000000
          Top = 235.889920000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'ENDERECO'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."ENDERECO"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Align = baLeft
          Top = 269.244280000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 63.913420000000000000
          Top = 251.567100000000000000
          Width = 684.094930000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Align = baLeft
          Left = 34.015770000000000000
          Top = 269.244280000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneClienteOnAfterData'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."TELEFONE1"]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Align = baLeft
          Top = 284.921460000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Align = baLeft
          Left = 37.795300000000000000
          Top = 284.921460000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CLI_C_G_C_'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CLI_C_G_C_"]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Align = baLeft
          Top = 301.598640000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Align = baLeft
          Left = 18.897650000000000000
          Top = 301.598640000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CLI_I_E_S_'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CLI_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Align = baLeft
          Top = 318.275820000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Align = baLeft
          Left = 49.133890000000000000
          Top = 318.275820000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'CONTATO'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CONTATO"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 262.669450000000000000
          Top = 82.252010000000000000
          Width = 457.323130000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."BAIRRO"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 612.299630000000000000
          Top = 291.244280000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clBlue
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 627.417750000000000000
          Top = 289.244280000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 627.417750000000000000
          Top = 326.819110000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Resumo')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 627.197280000000000000
          Top = 307.921460000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheques')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 612.299630000000000000
          Top = 309.921460000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clRed
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 612.299630000000000000
          Top = 329.598640000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clGreen
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          Left = 604.740570000000000000
          Top = 286.346630000000000000
          Width = 102.047310000000000000
          Height = 79.370130000000000000
        end
        object Memo34: TfrxMemoView
          Left = 627.299630000000000000
          Top = 270.008040000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Legenda')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 612.283425510000000000
          Top = 348.378170000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 108286
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 627.858690000000000000
          Top = 346.039580000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Agrupamento')
          ParentFont = False
        end
        object dbTelefoneCliente2: TfrxMemoView
          Align = baLeft
          Left = 138.582870000000000000
          Top = 269.240000000000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneCliente2OnAfterData'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."TELEFONE2"]')
          ParentFont = False
        end
        object dbFoneEmpresa2: TfrxMemoView
          Left = 380.732530000000000000
          Top = 112.385900000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFoneEmpresa2OnAfterData'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE2"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 15.118120000000000000
          Top = 350.598640000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PORTADOR DO CONTAS '#192' RECEBER:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 221.992270000000000000
          Top = 350.598640000000000000
          Width = 340.157700000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODPOR]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Align = baLeft
          Top = 219.212740000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cod. Rede/Rede de Loja:')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Align = baLeft
          Left = 132.283550000000000000
          Top = 219.212740000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'REDE'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."REDE"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Align = baLeft
          Top = 336.378170000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Email:  ')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Align = baLeft
          Left = 37.795300000000000000
          Top = 335.378170000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."EMAIL"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 990.236860000000000000
        Width = 761.575295000000000000
        object mmCitelSoftware: TfrxMemoView
          Left = 10.559060000000000000
          Top = 1.559060000000045000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Citel Software')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.141732280000000000
        ParentFont = False
        Top = 631.181510000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        KeepChild = True
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 17.677180000000000000
          Top = 0.755905510000047700
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataField = 'CODITEM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITEM"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 80.488250000000000000
          Top = 0.755905510000000000
          Width = 294.803340000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRICAOITEM"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 380.614410000000000000
          Top = 0.755905510000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDADE"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 451.882190000000000000
          Top = 0.755905510000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDEITEM"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 524.031850000000000000
          Top = 0.755905510000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITARIOITEM"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 668.181510000000000000
          Top = 0.755905510000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTALDOITEM"]')
          ParentFont = False
        end
        object meVlrDescEspecial: TfrxMemoView
          Left = 596.031496060000000000
          Top = 0.755905510000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTALDESESP"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 846.614720000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxRetrato.ChildSumary
        object mmDupVencidas: TfrxMemoView
          Left = 8.118120000000000000
          Top = 25.118119999999980000
          Width = 113.385831650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dup. Venc. em aberto')
          ParentFont = False
        end
        object mmTotalDup: TfrxMemoView
          Left = 253.378170000000000000
          Top = 24.559060000000040000
          Width = 105.826766770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Dup. Original')
          ParentFont = False
        end
        object mmTotalJuros: TfrxMemoView
          Left = 373.559370000000000000
          Top = 24.559060000000040000
          Width = 94.488176770000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmTotalJurosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Juros')
          ParentFont = False
        end
        object mmTotalCor: TfrxMemoView
          Left = 487.520100000000000000
          Top = 24.559060000000040000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Duplicata')
          ParentFont = False
        end
        object mmDupVencer: TfrxMemoView
          Left = 130.535560000000000000
          Top = 24.338589999999960000
          Width = 109.606296770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Duplicatas a Vencer')
          ParentFont = False
        end
        object TotalVencer: TfrxMemoView
          Left = 132.976500000000000000
          Top = 47.015769999999970000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object TotalVencidas: TfrxMemoView
          Left = 10.118120000000000000
          Top = 46.236239999999960000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 4.779530000000000000
          Top = 19.779530000000020000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line13: TfrxLineView
          Left = 4.779530000000000000
          Top = 43.236239999999960000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line14: TfrxLineView
          Left = 4.779530000000000000
          Top = 64.913419999999970000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 125.519790000000000000
          Top = 20.559060000000040000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 248.039580000000000000
          Top = 20.559060000000040000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 367.441250000000000000
          Top = 20.559060000000040000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 480.047620000000000000
          Top = 20.559060000000040000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 4.779530000000000000
          Top = 19.779530000000020000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 757.126470000000000000
          Top = 19.779530000000020000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmTotalVencidas: TfrxMemoView
          Left = 10.118120000000000000
          Top = 46.692949999999990000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object mmTotalVencer: TfrxMemoView
          Left = 132.976500000000000000
          Top = 47.472480000000020000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 248.504097500000000000
          Top = 1.338589999999954000
          Width = 264.567100000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clBlue
          HAlign = haCenter
          Memo.UTF8W = (
            'Total da(s) Duplicata(s)')
          ParentFont = False
        end
        object TotalDiferenca: TfrxMemoView
          Left = 498.961040000000000000
          Top = 47.692949999999990000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object TotalCorrigidos: TfrxMemoView
          Left = 502.740570000000000000
          Top = 47.472480000000020000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUP"]')
          ParentFont = False
        end
        object TotalJuros: TfrxMemoView
          Left = 374.118430000000000000
          Top = 46.692949999999990000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object TotalRecebido: TfrxMemoView
          Left = 253.937230000000000000
          Top = 46.472480000000020000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object TotalDuplicatas: TfrxMemoView
          Left = 253.937230000000000000
          Top = 47.252010000000040000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object Line46: TfrxLineView
          Left = 613.283860000000000000
          Top = 20.559999999999950000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo49: TfrxMemoView
          Left = 627.622450000000000000
          Top = 22.677180000000020000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Corrigido')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 639.299630000000000000
          Top = 45.354360000000040000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 376.559370000000000000
          Top = 47.133889999999950000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
      end
      object ghDuplicatas: TfrxGroupHeader
        FillType = ftBrush
        Height = 28.551190870000000000
        Top = 529.134200000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'ghDuplicatasOnBeforePrint'
        Child = frxRetrato.ChildGHDuplicatas
        Condition = 'frxRelatorio."GRUPO"'
        object sItensDuplicata: TfrxShapeView
          Left = 2.755903070000000000
          Top = 1.779530000000022000
          Width = 758.551181102362000000
          Height = 22.677180000000000000
        end
        object dbEspecie: TfrxMemoView
          Left = 104.590600000000000000
          Top = 5.338589999999954000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DataField = 'ESPECIE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."ESPECIE"]')
          ParentFont = False
        end
        object dbEmpresa: TfrxMemoView
          Left = 130.504020000000000000
          Top = 5.338589999999954000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataField = 'EMPRESA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMPRESA"]')
          ParentFont = False
        end
        object dbVendedor: TfrxMemoView
          Left = 164.078850000000000000
          Top = 5.338589999999954000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'VENDEDOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
        end
        object dbDtaCadastro: TfrxMemoView
          Left = 241.315090000000000000
          Top = 5.338589999999954000
          Width = 52.913390710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaCadastroOnBeforePrint'
          DataField = 'DATACADASTRO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DATACADASTRO"]')
          ParentFont = False
        end
        object dbVlrOriginal: TfrxMemoView
          Left = 445.630180000000000000
          Top = 5.338589999999954000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbVlrOriginalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORIRELATORIO"]')
          ParentFont = False
        end
        object dbVlrDuplicata: TfrxMemoView
          Left = 513.323176380000000000
          Top = 5.338589999999954000
          Width = 64.251963620000000000
          Height = 15.118120000000000000
          DataField = 'VALORDUPLICATA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORDUPLICATA"]')
          ParentFont = False
        end
        object dbVlrJuros: TfrxMemoView
          Left = 581.811380000000000000
          Top = 5.338589999999954000
          Width = 41.133890000000000000
          Height = 15.118120000000000000
          DataField = 'VALORJUROS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORJUROS"]')
          ParentFont = False
        end
        object dbVlrCorrigido: TfrxMemoView
          Left = 625.724800000000000000
          Top = 5.338589999999954000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VALORCORRIGIDO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORCORRIGIDO"]')
          ParentFont = False
        end
        object Line24: TfrxLineView
          Left = 101.811070000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 129.385900000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 161.960730000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 194.535560000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 296.126160000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line29: TfrxLineView
          Left = 401.590502360000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line30: TfrxLineView
          Left = 511.984540000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 579.913730000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line32: TfrxLineView
          Left = 624.031432600000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllDuplicata: TfrxMemoView
          Left = 4.291338580000000000
          Top = 5.291338580000001000
          Width = 94.488213390000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllDuplicataOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 444.732530000000000000
          Top = 1.511811019999982000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo47: TfrxMemoView
          Left = 407.834880000000000000
          Top = 5.338589999999954000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo47OnBeforePrint'
          DataField = 'DIASATRASO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIASATRASO"]')
          ParentFont = False
        end
        object Line33: TfrxLineView
          Left = 691.535870000000000000
          Top = 1.511811019999982000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object dbNosNum: TfrxMemoView
          Left = 692.409448818898000000
          Top = 5.338589999999954000
          Width = 68.031496062992100000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NOSNUM"]')
          ParentFont = False
        end
        object dbDtaVencimento: TfrxMemoView
          Left = 298.362400000000000000
          Top = 5.338589999999954000
          Width = 49.133860710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaVencimentoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 195.551330000000000000
          Top = 5.338589999999954000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REPRESENTANTE"]')
          ParentFont = False
        end
        object Line48: TfrxLineView
          Left = 239.126160000000000000
          Top = 1.000000000000000000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 349.496290000000000000
          Top = 1.338589999999954000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object dbDtaReceb: TfrxMemoView
          Left = 351.496290000000000000
          Top = 5.338589999999954000
          Width = 48.574800710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaRecebOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DATARECEBIMENTO"]')
          ParentFont = False
        end
      end
      object gfDuplicatas: TfrxGroupFooter
        FillType = ftBrush
        Height = 20.787404020000000000
        Top = 672.756340000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'gfDuplicatasOnBeforePrint'
        Child = frxRetrato.CEnderecoEntrega
        KeepChild = True
        PrintChildIfInvisible = True
        object SysMemo1: TfrxSysMemoView
          Left = 668.181510000000000000
          Top = 0.755905510000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTALDOITEM">,MasterData1)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 606.236550000000000000
          Top = 0.755905510000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Item :')
          ParentFont = False
        end
        object dbTOTALDESESP: TfrxSysMemoView
          Left = 536.220780000000000000
          Top = 0.755905510000000000
          Width = 64.251961180000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbTOTALDESESPOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."TOTALDESESP">,MasterData1)]')
          ParentFont = False
        end
        object mmDesEsp: TfrxMemoView
          Left = 424.260050000000000000
          Top = 0.755905510000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmDesEspOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desconto Especial : ')
          ParentFont = False
        end
        object mmMensagemTributos: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.755905510000000000
          Width = 415.748300000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."VALIPI">,MasterData1) <> 0, '#39'Vr. IPI: '#39' ' +
              '+ FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."VALIPI">,MasterData' +
              '1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."VALRET">,MasterData1) ' +
              '<> 0, '#39'Vr. ST: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."VA' +
              'LRET">,MasterData1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."TOTAL' +
              'FRETE">,MasterData1) <> 0, '#39'Vr. Frete: '#39' + FormatFloat('#39'#,##0.00' +
              #39', SUM(<frxRelatorio."TOTALFRETE">,MasterData1)) + '#39'   '#39', '#39#39')] [' +
              'IIF(SUM(<frxRelatorio."DESACE">,MasterData1) <> 0, '#39'Vr. Desp. Ac' +
              'es: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."DESACE">,Mast' +
              'erData1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."VFCPST">,MasterD' +
              'ata1) <> 0, '#39'Vr. FCP ST: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRel' +
              'atorio."VFCPST">,MasterData1)), '#39#39')]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
      end
      object ChildGHDuplicatas: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 582.047620000000000000
        Width = 761.575295000000000000
        object dbDUPLICATA: TfrxMemoView
          Left = 248.669450000000000000
          Top = 5.779530000000023000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LEGENDA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 17.677180000000000000
          Top = 4.559060000000045000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 80.488250000000000000
          Top = 4.559060000000045000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 380.614410000000000000
          Top = 4.559060000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unidade')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 451.882190000000000000
          Top = 4.559060000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 524.031850000000000000
          Top = 4.338590000000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit'#225'rio')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 668.181510000000000000
          Top = 4.559060000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object meTitDescEspecial: TfrxMemoView
          Left = 595.945270000000000000
          Top = 4.157480310000000000
          Width = 68.031496060000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desc. Esp.')
          ParentFont = False
        end
      end
      object ChildSumary: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 941.102970000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'ChildSumaryOnBeforePrint'
        object SubResumo: TfrxSubreport
          Left = 1.133858267716540000
          Top = 0.779530000000022500
          Width = 120.944881890000000000
          Height = 18.897650000000000000
          Visible = False
          Page = frxRetrato.Resumo
        end
        object SubCheques: TfrxSubreport
          Left = 2.118120000000000000
          Top = 3.543289999999956000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Visible = False
          Page = frxRetrato.Cheques
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 55.913420000000000000
        Top = 449.764070000000000000
        Width = 761.575295000000000000
        ReprintOnNewPage = True
        object sDuplicata: TfrxShapeView
          Left = 2.779530000000000000
          Top = 20.779530000000020000
          Width = 758.551181102362000000
          Height = 30.236240000000000000
        end
        object Memo39: TfrxMemoView
          Align = baCenter
          Left = 210.708797500000000000
          Top = 2.338590000000011000
          Width = 340.157700000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clBlue
          HAlign = haCenter
          Memo.UTF8W = (
            'Rela'#231#227'o de Duplicata(s) - CONTAS A RECEBER')
          ParentFont = False
        end
        object mmDuplicata: TfrxMemoView
          Left = 4.338590000000000000
          Top = 28.007884999999990000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object mmEspecie: TfrxMemoView
          Left = 101.590600000000000000
          Top = 28.007884999999990000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object mmEmpresa: TfrxMemoView
          Left = 130.504020000000000000
          Top = 28.007884999999990000
          Width = 30.236222910000000000
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
        object mmVendedor: TfrxMemoView
          Left = 164.078850000000000000
          Top = 28.007884999999990000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vend.')
          ParentFont = False
        end
        object mmDtaCadastro: TfrxMemoView
          Left = 241.315090000000000000
          Top = 23.338590000000010000
          Width = 52.913390710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Cadastro')
          ParentFont = False
        end
        object mmDtaVencimento: TfrxMemoView
          Left = 298.362400000000000000
          Top = 23.338590000000010000
          Width = 49.133860710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Venc.')
          ParentFont = False
        end
        object mmVlrOriginal: TfrxMemoView
          Left = 445.630180000000000000
          Top = 28.007884999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Orig.')
          ParentFont = False
        end
        object mmVlrDuplicata: TfrxMemoView
          Left = 513.323130000000000000
          Top = 28.007884999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Duplic.')
          ParentFont = False
        end
        object mmVlrJuros: TfrxMemoView
          Left = 581.031850000000000000
          Top = 28.007884999999990000
          Width = 41.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
        end
        object mmVlrCorrigido: TfrxMemoView
          Left = 625.724800000000000000
          Top = 28.007884999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Corrig.')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 101.811070000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 129.385900000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 161.960730000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 194.535560000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 296.126160000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 401.590502360000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 511.984540000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 579.913730000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 624.031432600000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line1: TfrxLineView
          Left = 444.732530000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo46: TfrxMemoView
          Left = 404.055350000000000000
          Top = 23.338590000000010000
          Width = 37.795300000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dias'
            'Atraso')
          ParentFont = False
        end
        object Line21: TfrxLineView
          Left = 691.535870000000000000
          Top = 20.897650000000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmNosNum: TfrxMemoView
          Left = 693.315400000000000000
          Top = 28.007884999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nosso n'#250'm')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 195.551330000000000000
          Top = 28.007884999999990000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Repres.')
          ParentFont = False
        end
        object Line47: TfrxLineView
          Left = 239.126160000000000000
          Top = 22.220469999999980000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line49: TfrxLineView
          Left = 349.496290000000000000
          Top = 20.787401569999990000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDtaReceb: TfrxMemoView
          Left = 351.716760000000000000
          Top = 22.677180000000020000
          Width = 47.574800710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Receb.')
          ParentFont = False
        end
      end
      object CEnderecoEntrega: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 718.110700000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'CObservacaoOnBeforePrint'
        Child = frxRetrato.CObservacao
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo60: TfrxMemoView
          Left = 7.559055120000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmDesEspOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o de Entrega Cliente:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 162.519685039370000000
          Top = 0.102362210000023900
          Width = 572.598727870000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERECO_ENTREGA"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object CObservacao: TfrxChild
        FillType = ftBrush
        Height = 31.370078740157500000
        Top = 755.906000000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'CObservacaoOnBeforePrint'
        KeepChild = True
        PrintChildIfInvisible = True
        object Memo45: TfrxMemoView
          Left = 7.559060000000000000
          Top = 0.779530000000022500
          Width = 752.126470000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#227'o : ')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 7.559060000000000000
          Top = 17.677180000000020000
          Width = 752.126470000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OBS001"] [frxRelatorio."OBS002"]')
          ParentFont = False
        end
      end
    end
    object Cheques: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 3.500000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MDCheques: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 83.149660000000000000
        Width = 761.575295000000000000
        DataSet = frxCheque
        DataSetName = 'frxCheque'
        RowCount = 0
        object frxChequeCHQ_NUMCHQ: TfrxMemoView
          Left = 240.078850000000000000
          Top = 2.559060000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_NUMCHQ"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 321.448980000000000000
          Top = 3.000000000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTADEP'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTADEP"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 413.157700000000000000
          Top = 3.000000000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTADEV'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTADEV"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 515.425480000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTAVEN"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 627.031850000000000000
          Top = 3.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheque."CHQ_VALCHQ"]')
          ParentFont = False
        end
        object frxChequeCHQ_CODEMP: TfrxMemoView
          Left = 44.763760000000000000
          Top = 2.779529999999990000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODEMP'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_CODEMP"]')
          ParentFont = False
        end
        object frxChequeCHQ_CODBCO: TfrxMemoView
          Left = 108.236240000000000000
          Top = 2.779529999999990000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODBCO'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_CODBCO"]')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Left = 39.078740160000000000
          Top = 1.133858270000000000
          Width = 687.874460000000000000
          Height = 18.897650000000000000
        end
        object Line38: TfrxLineView
          Left = 101.370130000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line39: TfrxLineView
          Left = 170.401670000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line40: TfrxLineView
          Left = 315.803340000000000000
          Top = 0.779529999999994000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line41: TfrxLineView
          Left = 407.512060000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line42: TfrxLineView
          Left = 508.559370000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line43: TfrxLineView
          Left = 620.165740000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object frxChequeCHQ_NUMAGE: TfrxMemoView
          Left = 174.960730000000000000
          Top = 2.779529999999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_NUMAGE"]')
          ParentFont = False
        end
        object Line44: TfrxLineView
          Left = 236.433210000000000000
          Top = 1.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object HCheques: TfrxHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 761.575295000000000000
        object Memo15: TfrxMemoView
          Left = 241.078850000000000000
          Top = 22.338590000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nro. Cheque')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 44.645640000000000000
          Top = 21.779530000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 108.897650000000000000
          Top = 21.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 322.330860000000000000
          Top = 21.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Dep'#243'sito')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 414.039580000000000000
          Top = 21.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Devolu'#231#227'o')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 517.086890000000000000
          Top = 21.779530000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Vencimento')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 628.693260000000000000
          Top = 21.779530000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Cheque')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Left = 39.236220472440900000
          Top = 20.000000000000000000
          Width = 687.874460000000000000
          Height = 18.897650000000000000
        end
        object Line22: TfrxLineView
          Left = 101.370130000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 170.401670000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 315.803340000000000000
          Top = 19.559060000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 407.512060000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line36: TfrxLineView
          Left = 508.559370000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line37: TfrxLineView
          Left = 619.945270000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 175.960730000000000000
          Top = 21.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Line45: TfrxLineView
          Left = 236.433210000000000000
          Top = 19.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo14: TfrxMemoView
          Left = 216.244343340000000000
          Top = 2.000000000000000000
          Width = 340.157480310000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clRed
          HAlign = haCenter
          Memo.UTF8W = (
            'Rela'#231#227'o de Cheque(s)')
          ParentFont = False
        end
      end
      object FCheque: TfrxFooter
        FillType = ftBrush
        Height = 48.598640000000000000
        Top = 128.504020000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
        Child = frxRetrato.FChequeChild
        object SysMemo2: TfrxSysMemoView
          Left = 626.504330000000000000
          Top = 23.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheque."CHQ_VALCHQ">,MDCheques)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 543.897960000000000000
          Top = 23.677180000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque : ')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 248.488445160000000000
          Top = 3.779529999999990000
          Width = 268.346456690000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clRed
          HAlign = haCenter
          Memo.UTF8W = (
            'Total do(s) Cheque(s)')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 507.559370000000000000
          Top = 21.456710000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
        end
      end
      object FChequeChild: TfrxChild
        FillType = ftBrush
        Height = 223.086580000000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        Stretched = True
        object mmInformacoesAdicionais: TfrxMemoView
          Left = 8.000000000000000000
          Top = 180.299320000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Adicionais : ')
          ParentFont = False
        end
        object dbAdicionais: TfrxMemoView
          Left = 8.000000000000000000
          Top = 197.535560000000000000
          Width = 752.126470000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'ADICIONAIS'
          DataSet = frxInformacoes
          DataSetName = 'frxInformacoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxInformacoes."ADICIONAIS"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 189.078850000000000000
          Width = 393.070946690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGreen
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO GERAL')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Left = 189.912183330000000000
          Top = 22.677180000000000000
          Width = 393.071120000000000000
          Height = 151.181200000000000000
        end
        object SysMemo3: TfrxSysMemoView
          Left = 397.205010000000000000
          Top = 117.944960000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheque."CHQ_VALCHQ">,MDCheques)]')
          ParentFont = False
        end
        object mmResumoCheque: TfrxMemoView
          Left = 272.023810000000000000
          Top = 118.504020000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque: ')
          ParentFont = False
        end
        object mmResumoVencidas: TfrxMemoView
          Left = 272.023810000000000000
          Top = 26.015770000000000000
          Width = 117.165361650000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmResumoVencidasOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas Vencidas:')
          ParentFont = False
        end
        object mmResumoDuplicatas: TfrxMemoView
          Left = 272.582870000000000000
          Top = 63.252010000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Duplicatas:')
          ParentFont = False
        end
        object mmResumoJuros: TfrxMemoView
          Left = 271.803340000000000000
          Top = 82.149660000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmResumoJurosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Juros:')
          ParentFont = False
        end
        object mmResumoCorrigido: TfrxMemoView
          Left = 272.141930000000000000
          Top = 100.047310000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Corrigido:')
          ParentFont = False
        end
        object mmResumoVencer: TfrxMemoView
          Left = 272.260050000000000000
          Top = 44.133890000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas a Vencer:')
          ParentFont = False
        end
        object ResumoTotalDuplicata: TfrxMemoView
          Left = 396.968770000000000000
          Top = 63.252010000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object ResumoTotalRecebido: TfrxMemoView
          Left = 397.527830000000000000
          Top = 63.252010000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object ResumoTotalCorrigido: TfrxMemoView
          Left = 396.748300000000000000
          Top = 101.047310000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object ResumoTotalDiferenca: TfrxMemoView
          Left = 396.748300000000000000
          Top = 101.047310000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object ResumoTotalVencer: TfrxMemoView
          Left = 396.968770000000000000
          Top = 44.574830000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object ResumoTotalJuros: TfrxMemoView
          Left = 396.748300000000000000
          Top = 83.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object ResumoTotalVencida: TfrxMemoView
          Left = 396.748300000000000000
          Top = 26.677180000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoDispCh: TfrxMemoView
          Left = 272.023810000000000000
          Top = 155.972788790000000000
          Width = 135.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite cr'#233'dito dispon'#237'vel: ')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredDispCh: TfrxMemoView
          Left = 412.205010000000000000
          Top = 155.139455460000000000
          Width = 98.385900000000000000
          Height = 15.118120000000000000
          DataField = 'TOTALCREDITODISP'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCREDITODISP"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoCh: TfrxMemoView
          Left = 272.023810000000000000
          Top = 138.851576670000000000
          Width = 146.503944330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite de cr'#233'dito do cliente:')
          ParentFont = False
        end
        object mmResumoVlrLimiteCreditoCh: TfrxMemoView
          Left = 423.038343330000000000
          Top = 138.851576670000000000
          Width = 87.552566670000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."CREDCLI"]')
          ParentFont = False
        end
      end
    end
    object Resumo: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 3.500000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MDInformacao: TfrxMasterData
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 253.228510000000000000
        Width = 761.575295000000000000
        DataSet = frxInformacoes
        DataSetName = 'frxInformacoes'
        RowCount = 0
        Stretched = True
        object Memo40: TfrxMemoView
          Left = 7.118120000000000000
          Top = 4.118120000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Adicionais : ')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 7.118120000000000000
          Top = 22.354360000000000000
          Width = 752.126470000000000000
          Height = 18.897430310000000000
          StretchMode = smMaxHeight
          DataField = 'ADICIONAIS'
          DataSet = frxInformacoes
          DataSetName = 'frxInformacoes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxInformacoes."ADICIONAIS"]')
          ParentFont = False
        end
      end
      object HResumo: TfrxHeader
        FillType = ftBrush
        Height = 211.653680000000000000
        Top = 18.897650000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'Header2OnBeforePrint'
        object Memo42: TfrxMemoView
          Left = 189.976500000000000000
          Top = 2.000000000000000000
          Width = 393.070946690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGreen
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO GERAL')
          ParentFont = False
        end
        object Shape6: TfrxShapeView
          Left = 189.976500000000000000
          Top = 21.220470000000000000
          Width = 393.070946690000000000
          Height = 185.196970000000000000
        end
        object RResumoCheques: TfrxMemoView
          Left = 265.921467320000000000
          Top = 148.944960000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque: ')
          ParentFont = False
        end
        object RResumoVencidas: TfrxMemoView
          Left = 265.921460000000000000
          Top = 24.015770000000000000
          Width = 117.165361650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dup. Venc. em aberto:')
          ParentFont = False
        end
        object RResumoDuplicata: TfrxMemoView
          Left = 265.921464880000000000
          Top = 77.692950000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'RResumoDuplicataOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Duplicatas:')
          ParentFont = False
        end
        object RResumoJuros: TfrxMemoView
          Left = 265.921467320000000000
          Top = 96.590600000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Juros:')
          ParentFont = False
        end
        object RResumoCorrigido: TfrxMemoView
          Left = 265.921467320000000000
          Top = 131.488250000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Corrigido:')
          ParentFont = False
        end
        object RResumoVencer: TfrxMemoView
          Left = 265.921464880000000000
          Top = 42.133890000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas a Vencer:')
          ParentFont = False
        end
        object ResumoRecebido: TfrxMemoView
          Left = 397.543600000000000000
          Top = 77.692950000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object ResumoCorrigido: TfrxMemoView
          Left = 397.645950000000000000
          Top = 131.488250000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object ResumoDiferenca: TfrxMemoView
          Left = 398.425480000000000000
          Top = 114.488250000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object ResumoVencer: TfrxMemoView
          Left = 397.866420000000000000
          Top = 42.133890000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object ResumoJuros: TfrxMemoView
          Left = 397.645950000000000000
          Top = 96.590600000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object ResumoVencidas: TfrxMemoView
          Left = 397.645950000000000000
          Top = 24.015770000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object mmResumoCheques: TfrxMemoView
          Left = 397.850650000000000000
          Top = 149.606370000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object RResumoDiferenca: TfrxMemoView
          Left = 265.921467320000000000
          Top = 114.708720000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Diferen'#231'a:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 397.543600000000000000
          Top = 77.913420000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 398.425480000000000000
          Top = 113.488250000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoDisp: TfrxMemoView
          Left = 265.921467320000000000
          Top = 184.543290000000000000
          Width = 135.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite cr'#233'dito dispon'#237'vel: ')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredDisp: TfrxMemoView
          Left = 409.000000000000000000
          Top = 184.543290000000000000
          Width = 102.370130000000000000
          Height = 15.118120000000000000
          DataField = 'TOTALCREDITODISP'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCREDITODISP"]')
          ParentFont = False
        end
        object mmResumoLimiteCredito: TfrxMemoView
          Left = 265.921467320000000000
          Top = 166.422077880000000000
          Width = 146.503944330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite de cr'#233'dito do cliente:')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredito: TfrxMemoView
          Left = 414.927026060000000000
          Top = 166.422077880000000000
          Width = 96.309523940000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."CREDCLI"]')
          ParentFont = False
        end
        object RResumoGeralAberto: TfrxMemoView
          Left = 265.567100000000000000
          Top = 60.472480000000000000
          Width = 120.944886770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral em Aberto:')
          ParentFont = False
        end
        object ResumoGeralAberto: TfrxMemoView
          Left = 397.850650000000000000
          Top = 60.472480000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxTotal."DUPVEN"> + <frxTotal."DUPAVE">]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = qryRelatorio
    BCDToCurrency = False
    Left = 80
    Top = 16
  end
  object qryRelatorio: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      '')
    ReadOnly = True
    Constraints = <>
    Left = 144
    Top = 8
  end
  object qryCliente: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 144
    Top = 64
    object qryClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object qryClienteFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Size = 60
    end
    object qryClienteENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 60
    end
    object qryClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 90
    end
    object qryClienteTELEFONE: TStringField
      FieldName = 'TELEFONE1'
      Size = 33
    end
    object qryClienteCLI_CGCCPF: TLongWordField
      FieldName = 'CLI_CGCCPF'
    end
    object qryClienteCLI_C_G_C_: TStringField
      FieldName = 'CLI_C_G_C_'
      Size = 18
    end
    object qryClienteCLI_F_A_X_: TStringField
      FieldName = 'CLI_F_A_X_'
      Size = 15
    end
    object qryClienteCLI_I_E_S_: TStringField
      FieldName = 'CLI_I_E_S_'
      Size = 18
    end
    object qryClienteCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 25
    end
    object qryClienteTELEFONE2: TStringField
      FieldName = 'TELEFONE2'
    end
    object qryClienteREDE: TStringField
      FieldName = 'REDE'
      Size = 40
    end
    object qryClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
  end
  object frxCliente: TfrxDBDataset
    UserName = 'frxCliente'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NOME=NOME'
      'FANTASIA=FANTASIA'
      'ENDERECO=ENDERECO'
      'BAIRRO=BAIRRO'
      'TELEFONE1=TELEFONE1'
      'CLI_CGCCPF=CLI_CGCCPF'
      'CLI_C_G_C_=CLI_C_G_C_'
      'CLI_F_A_X_=CLI_F_A_X_'
      'CLI_I_E_S_=CLI_I_E_S_'
      'CONTATO=CONTATO'
      'TELEFONE2=TELEFONE2'
      'REDE=REDE'
      'EMAIL=EMAIL')
    DataSet = qryCliente
    BCDToCurrency = False
    Left = 56
    Top = 64
  end
  object frxEmpresa: TfrxDBDataset
    UserName = 'frxEmpresa'
    CloseDataSource = False
    DataSet = qryEmpresa
    BCDToCurrency = False
    Left = 232
    Top = 8
  end
  object qryEmpresa: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      '')
    ReadOnly = True
    Constraints = <>
    Left = 296
    Top = 8
    object qryEmpresaEMPRESA: TStringField
      FieldName = 'EMPRESA'
      Required = True
      Size = 44
    end
    object qryEmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 89
    end
    object qryEmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 73
    end
    object qryEmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
      Required = True
      Size = 46
    end
    object qryEmpresaCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object qryEmpresaEMP_F_A_X_: TStringField
      FieldName = 'EMP_F_A_X_'
      Size = 15
    end
    object qryEmpresaEMP_CONTAT: TStringField
      FieldName = 'EMP_CONTAT'
      Size = 30
    end
    object qryEmpresaEMP_EMAIL_: TStringField
      FieldName = 'EMP_EMAIL_'
      Size = 50
    end
    object qryEmpresaDATA: TDateField
      FieldName = 'DATA'
    end
    object qryEmpresaTELEFONE1: TStringField
      FieldName = 'TELEFONE1'
      Size = 15
    end
    object qryEmpresaTELEFONE2: TStringField
      FieldName = 'TELEFONE2'
      Size = 15
    end
  end
  object frxTotal: TfrxDBDataset
    UserName = 'frxTotal'
    CloseDataSource = False
    DataSet = cdsTotal
    BCDToCurrency = False
    Left = 232
    Top = 64
  end
  object qryInformacoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 120
    object qryInformacoesCHEQUE: TStringField
      FieldName = 'CHEQUE'
      Size = 1
    end
    object qryInformacoesIMAGEM: TStringField
      FieldName = 'IMAGEM'
      Size = 1
    end
    object qryInformacoesDIRETORIO: TStringField
      FieldName = 'DIRETORIO'
      Size = 255
    end
    object qryInformacoesADICIONAIS: TMemoField
      FieldName = 'ADICIONAIS'
      BlobType = ftMemo
    end
  end
  object frxInformacoes: TfrxDBDataset
    UserName = 'frxInformacoes'
    CloseDataSource = False
    DataSet = qryInformacoes
    BCDToCurrency = False
    Left = 56
    Top = 120
  end
  object frxExportaPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
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
    Left = 8
    Top = 80
  end
  object frxCheque: TfrxDBDataset
    UserName = 'frxCheque'
    CloseDataSource = False
    DataSet = cdsCheque
    BCDToCurrency = False
    Left = 232
    Top = 120
  end
  object cdsTotal: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 64
    object cdsTotalDUPVEN: TFloatField
      FieldName = 'DUPVEN'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalDUPAVE: TFloatField
      FieldName = 'DUPAVE'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALCORRIGIDO: TFloatField
      FieldName = 'TOTALCORRIGIDO'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALDIFERENCA: TFloatField
      FieldName = 'TOTALDIFERENCA'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALJUROS: TFloatField
      FieldName = 'TOTALJUROS'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALRECEBIDO: TFloatField
      FieldName = 'TOTALRECEBIDO'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALDUPLICATA: TFloatField
      FieldName = 'TOTALDUPLICATA'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALDUP: TFloatField
      FieldName = 'TOTALDUP'
      DisplayFormat = '#,##0.00'
    end
    object cdsTotalTOTALCREDITODISP: TFloatField
      FieldName = 'TOTALCREDITODISP'
    end
    object cdsTotalCREDCLI: TFloatField
      FieldName = 'CREDCLI'
    end
  end
  object cdsCheque: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 120
  end
  object qryFeriado: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      '')
    ReadOnly = True
    Constraints = <>
    Left = 144
    Top = 184
  end
  object frxPaisagem: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    OldStyleProgress = True
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39504.578949363400000000
    ReportOptions.LastChange = 44832.408518171300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin        '
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    If (<frxRelatorio."STATUS3"> = '#39'1'#39') Then'
      '    Begin                '
      '      TotalVencidas.Visible   := False;                        '
      '      TotalVencer.Visible     := False;'
      '      mmTotalVencer.Visible   := True;'
      
        '      mmTotalVencidas.Visible := True;                          ' +
        '        '
      '    End;                '
      ''
      '    mmTotalDup.Text         := '#39'Total Recebido'#39';'
      '    TotalDuplicatas.Visible := False;'
      
        '    TotalRecebido.Visible   := True;                            ' +
        '             '
      '  '
      '    mmTotalCor.Text         := '#39'Total Diferen'#231'a'#39';'
      '    TotalCorrigidos.Visible := False;'
      
        '    If TotalDiferenca.Visible <> False Then                     ' +
        '                         '
      '      TotalDiferenca.Visible  := True;'
      '    TotalJuros.Text         := '#39'0.00'#39';'
      '    mmResumoJuros.Text      := '#39'Total Diferen'#231'a'#39';'
      
        '    ResumoTotalJuros.DataField := '#39'TOTALDIFERENCA'#39';             ' +
        '       '
      '  End'
      '  Else'
      '  Begin              '
      '    Memo51.Visible := False;'
      '    If TotalCorrigidos.Visible <> False Then        '
      '      TotalCorrigidos.Visible := True;'
      '    TotalDiferenca.Visible := False;        '
      '  End;                  '
      'end;'
      ''
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin    '
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      ''
      '    //Campos de Labels'
      '    mmVlrDuplicata.Text    := '#39'Vl. Receb.'#39';'
      '    mmVlrJuros.Text        := '#39'Diferen'#231'a'#39';'
      ''
      '    //Campos de Dados      '
      '    dbVlrDuplicata.DataField  := '#39'VALORRECEBIDO'#39';'
      '    dbVlrJuros.DataField      := '#39'DIFERENCA'#39';        '
      '  End;     '
      'end;                                                           '
      ''
      'procedure gfDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."CODITEM"> = '#39#39' Then'
      '    gfDuplicatas.Visible := False'
      '  Else                         '
      '    gfDuplicatas.Visible := True;              '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."CODITEM"> = '#39#39' Then'
      '    MasterData1.Visible := False'
      '  Else'
      '    MasterData1.Visible := True;'
      ''
      '  If <frxRelatorio."ENDERECO_ENTREGA"> = '#39#39' Then'
      '  Begin'
      '    Memo60.Visible := False;'
      '    Memo61.Visible := False          '
      '  End'
      '  Else'
      '  Begin'
      '    Memo60.Visible := True;'
      '    Memo61.Visible := True;          '
      '  End;            '
      'end;'
      ''
      'procedure Footer1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure pExibeGrid(blnOpcao: Boolean);'
      'begin'
      '  sItensDuplicata.Visible := blnOpcao;'
      '  Line2.Visible  := blnOpcao;'
      '  Line50.Visible := blnOpcao;      '
      '  Line24.Visible := blnOpcao;'
      '  Line25.Visible := blnOpcao;'
      '  Line26.Visible := blnOpcao;'
      '  Line27.Visible := blnOpcao;'
      '  Line28.Visible := blnOpcao;'
      '  Line29.Visible := blnOpcao;'
      '  Line30.Visible := blnOpcao;'
      '  Line31.Visible := blnOpcao;'
      '  Case <bChkJuros> Of'
      '    0 : Begin'
      '          Line32.Visible := blnOpcao;'
      '          Line33.Visible := blnOpcao;'
      '        End;                        '
      '    1 : Begin              '
      '          Line32.Visible := False;'
      '          Line33.Visible := False;'
      
        '        End;                                                    ' +
        '          '
      '  End;'
      '  Line49.Visible := blnOpcao;'
      '  Line48.Visible := blnOpcao;      '
      'end;  '
      '         '
      'procedure ghDuplicatasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  pExibeGrid(True);                                         '
      '  '
      '  If (<frxRelatorio."ORDEM2"> = '#39'AG'#39') Then      '
      '  Begin                                              '
      '    dbEspecie.Color        := $0001A6FE;'
      '    dbDuplicata.Color      := $0001A6FE;'
      '    dbEspecie.Font.Color   := clBlack;'
      '    dbDuplicata.Font.Color := clBlack;        '
      '    dbEspecie.Font.Style   := fsBold;'
      '    dbDuplicata.Font.Style := fsBold;'
      
        '    dbDuplicata.Visible    := True;                             ' +
        '                                                        '
      '  End            '
      '  Else If (<frxRelatorio."ORDEM2"> = '#39'AH'#39') Then                '
      '  Begin'
      '    dbEspecie.Color        := clNone;'
      '    dbDuplicata.Color      := clNone;      '
      '    dbEspecie.Font.Color   := $0001A6FE;'
      '    dbDuplicata.Font.Color := $0001A6FE;      '
      '    dbEspecie.Font.Style   := fsBold;'
      '    dbDuplicata.Font.Style := fsBold;             '
      '    dbDuplicata.Visible    := True;'
      '    pExibeGrid(False);        '
      '  End'
      '  Else'
      '  Begin'
      '    dbEspecie.Color        := clNone;'
      '    dbDuplicata.Color      := clNone;      '
      '    dbEspecie.Font.Color   := clBlack;'
      '    dbDuplicata.Font.Color := clBlack;                     '
      '    dbEspecie.Font.Style   := nil;'
      '    dbDuplicata.Font.Style := nil;'
      
        '    dbDuplicata.Visible    := False;                            ' +
        '                                                         '
      '  End;'
      ''
      '  If (dbVlrDuplicata.Text = '#39'0.00'#39') Then'
      '  begin'
      
        '    dbVlrJuros.Text := '#39'0.00'#39';                                  ' +
        '                                           '
      '  end;      '
      'end;'
      ''
      'procedure FResumoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure PageHeader2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure ChildSumaryOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                                             '
      'end;'
      ''
      'procedure ReportSummary2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure Header2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    RResumoDuplicata.Text      := '#39'Total Recebido:'#39';'
      
        '    ResumoRecebido.Visible  := True;                            ' +
        '             '
      '  '
      
        '    If ResumoDiferenca.Visible <> False Then                    ' +
        '                        '
      '      ResumoDiferenca.Visible := True;'
      
        '    ResumoJuros.Text        := '#39'0.00'#39';                          ' +
        '                                                                ' +
        ' '
      '  End;    '
      'end;'
      ''
      'procedure RelatorioOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxInformacoes."CHEQUE"> = '#39'N'#39' Then'
      '    SubResumo.Visible  := True'
      '  Else'
      
        '    SubCheques.Visible := True;                                 ' +
        '        '
      'end;'
      ''
      'procedure mmResumoVencidasOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure Child1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (((<frxRelatorio."STATUS1"> = '#39'0'#39') And (<frxRelatorio."STAT' +
        'US2"> = '#39'B'#39')) OR'
      '     (<frxRelatorio."STATUS3"> = '#39'2'#39')) Then'
      '  Begin'
      '    RResumoDuplicata.Text      := '#39'Total Recebido:'#39';'
      
        '    ResumoRecebido.Visible  := True;                            ' +
        '             '
      '  '
      '    RResumoCorrigido.Text       := '#39'Total Diferen'#231'a:'#39';'
      '    ResumoCorrigido.Visible := False;'
      '    If ResumoDiferenca.Visible <> False Then        '
      '      ResumoDiferenca.Visible := True;'
      ''
      '    ResumoTotalDiferenca.Visible := False;          '
      '  End'
      '  Else'
      '  If (<frxRelatorio."STATUS1"> = '#39'A'#39') Then'
      '    ResumoTotalDiferenca.Visible := False;      '
      'end;'
      '                   '
      'procedure CObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio."OBS001"> <> '#39#39') Or (<frxRelatorio."OBS002">' +
        ' <> '#39#39') Then'
      '    CObservacao.Visible := True'
      '  Else'
      '    CObservacao.Visible := False;  '
      'end;'
      ''
      'procedure rllDuplicataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      '  rllDuplicata.Text := Copy(<frxRelatorio."DUPLICATA">, 1, 15);'
      ''
      '  If (<frxRelatorio."ORDEM2"> = '#39'AG'#39') Then'
      '    ChildGHDuplicatas.Visible := False'
      '  Else'
      '    ChildGHDuplicatas.Visible := True;                         '
      '    '
      'end;'
      ''
      'procedure mmDesEspOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If SUM(<frxRelatorio."TOTALDESESP">,MasterData1) = 0 Then'
      '    mmDesEsp.Text := '#39#39';                               '
      'end;'
      ''
      'procedure dbTOTALDESESPOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ' If SUM(<frxRelatorio."TOTALDESESP">,MasterData1) = 0 Then'
      '   dbTOTALDESESP.Text := '#39#39';                               '
      'end;'
      ''
      'procedure dbFoneEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFoneEmpresa.Text) = '#39#39') then'
      '    dbFoneEmpresa.Text := '#39#39'  '
      '  else                     '
      
        '    dbFoneEmpresa.Text := fFormataFonePaisInterna(Trim(dbFoneEmp' +
        'resa.Text));  '
      'end;'
      ''
      'procedure dbFoneEmpresa2OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFoneEmpresa.Text) = '#39#39') then'
      '    dbFoneEmpresa2.Text := '#39#39'  '
      '  else                     '
      
        '    dbFoneEmpresa2.Text := fFormataFonePaisInterna(Trim(dbFoneEm' +
        'presa2.Text));  '
      'end;'
      ''
      'procedure dbFaxEmpresaOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbFaxEmpresa.Text) = '#39#39') then'
      '    dbFaxEmpresa.Text := '#39#39'  '
      '  else                     '
      
        '    dbFaxEmpresa.Text := fFormataFonePaisInterna(Trim(dbFaxEmpre' +
        'sa.Text));  '
      'end;'
      ''
      'procedure dbTelefoneClienteOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbTelefoneCliente.Text) = '#39#39') then'
      '    dbTelefoneCliente.Text := '#39#39'  '
      '  else                     '
      
        '    dbTelefoneCliente.Text := fFormataFonePaisInterna(Trim(dbTel' +
        'efoneCliente.Text));  '
      'end;'
      ''
      ''
      'procedure dbTelefoneCliente2OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  if (Trim(dbTelefoneCliente2.Text) = '#39#39') then'
      '    dbTelefoneCliente2.Text := '#39#39'  '
      '  else                     '
      
        '    dbTelefoneCliente2.Text := fFormataFonePaisInterna(Trim(dbTe' +
        'lefoneCliente2.Text));  '
      'end; '
      ''
      'procedure Memo47OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  if (dbDtarecew.DataField = '#39'DATAVENCIMENTO'#39') OR (dbDtaCadast' +
        'ro.DataField = '#39#39') then                                         ' +
        '                                                                ' +
        '            '
      '//  begin            '
      
        '    // fun'#231#227'o para recalculo da data de vencimento e dias de atr' +
        'aso no label'
      
        '    Memo47.DataField   := '#39#39';                                   ' +
        '                '
      
        '    Memo47.Text        := fDiasAtraso(<frxRelatorio."DIASATRASO"' +
        '>,<frxRelatorio."DATAVENCIMENTO">, <frxRelatorio."DATARECEBIMENT' +
        'O">, 1);'
      '//  end;                  '
      'end;'
      ''
      'procedure dbDtaCadastroOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure dbVlrOriginalOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  dbVlrOriginal.DataField  := '#39'VALORORIGINAL'#39';        '
      'end;'
      ''
      'procedure mmTotalJurosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."STATUS3"> = '#39'2'#39') Then'
      '  Begin'
      '    mmTotalJuros.Text     := '#39'Vl. Dup. Orig.'#39';'
      '    RResumoJuros.Text     := '#39'Vl. Dup. Orig.'#39';'
      '    ResumoJuros.DataField := '#39'TOTALDUPLICATA'#39';'
      
        '    If Memo51.Visible <> False Then                             ' +
        '                 '
      '      Memo51.Visible        := True;'
      
        '    TotalJuros.Visible    := False;                             ' +
        '                    '
      '  end;  '
      'end;'
      ''
      'procedure RResumoDuplicataOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If (<frxRelatorio."STATUS3"> <> '#39'2'#39') and (<frxRelatorio."STATU' +
        'S2"> <> '#39'B'#39') Then'
      '  begin'
      '    RResumoDuplicata.Text   := '#39'Total Dup. Original'#39';'
      '    Memo53.Visible          := True;'
      
        '    ResumoRecebido.Visible  := False;                           ' +
        '                                                         '
      '    RResumoDiferenca.Text   := '#39'Total Duplicata'#39';'
      
        '    If Memo54.Visible <> False Then                             ' +
        '                          '
      '      Memo54.Visible        := True'
      '    Else'
      
        '      ResumoDiferenca.Visible := False;                         ' +
        '                     '
      '    Memo54.DataField        := '#39'TOTALDUP'#39';        '
      
        '    ResumoDiferenca.Visible := False;                           ' +
        '                      '
      '  end'
      '  Else            '
      '    Memo54.Visible          := False;      '
      'end;'
      ''
      'procedure mmResumoJurosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."STATUS3"> = '#39'2'#39') Then'
      '  begin'
      '    mmResumoJuros.Text         := '#39'Total Diferen'#231'a'#39';'
      
        '    ResumoTotalJuros.DataField := '#39'TOTALDIFERENCA'#39';             ' +
        '                                 '
      '  end;          '
      'end;'
      ''
      'procedure dbDtaRecebOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  IF (<frxRelatorio."DATARECEBIMENTO"> <= 0) then    '
      '    dbDtaReceb.Text := '#39#39
      '  else'
      
        '     dbDtaReceb.Text := formatdatetime('#39'dd/mm/yy'#39',<frxRelatorio.' +
        '"DATARECEBIMENTO">);                                            ' +
        '           '
      'end;'
      ''
      'procedure dbDtaVencimentoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  dbDtavencimento.Text := fDiasAtraso(<frxRelatorio."DIASATRASO"' +
        '>,<frxRelatorio."DATAVENCIMENTO">,<frxRelatorio."DATARECEBIMENTO' +
        '">, 2);    '
      'end;'
      ''
      'begin                        '
      'end.')
    OnUserFunction = frxRetratoUserFunction
    Left = 56
    Top = 232
    Datasets = <
      item
        DataSet = frxCheque
        DataSetName = 'frxCheque'
      end
      item
        DataSet = frxCliente
        DataSetName = 'frxCliente'
      end
      item
        DataSet = frxEmpresa
        DataSetName = 'frxEmpresa'
      end
      item
        DataSet = frxInformacoes
        DataSetName = 'frxInformacoes'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxTotal
        DataSetName = 'frxTotal'
      end>
    Variables = <
      item
        Name = ' Vari'#225'veis'
        Value = Null
      end
      item
        Name = 'bChkJuros'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Relatorio: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 3.500000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      OnBeforePrint = 'RelatorioOnBeforePrint'
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 370.393940000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Imagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 17.559060000000000000
          Top = 57.559060000000000000
          Width = 224.133890000000000000
          Height = 101.677180000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object dbEmrpesa: TfrxMemoView
          Left = 387.244280000000000000
          Top = 39.000000000000000000
          Width = 351.496290000000000000
          Height = 15.118120000000000000
          DataField = 'EMPRESA'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxEmpresa."EMPRESA"]')
          ParentFont = False
        end
        object dbEnderecoEmpresa: TfrxMemoView
          Left = 387.244280000000000000
          Top = 54.677180000000000000
          Width = 710.551640000000000000
          Height = 15.118120000000000000
          DataField = 'ENDERECO'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."ENDERECO"]')
          ParentFont = False
        end
        object dbFoneEmpresa: TfrxMemoView
          Left = 421.039580000000000000
          Top = 101.590600000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFoneEmpresaOnAfterData'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE1"]')
          ParentFont = False
        end
        object dbCEPEmpresa: TfrxMemoView
          Left = 419.260050000000000000
          Top = 85.708720000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CEP'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."CEP"]')
          ParentFont = False
        end
        object dbFaxEmpresa: TfrxMemoView
          Left = 416.480520000000000000
          Top = 118.047310000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFaxEmpresaOnAfterData'
          DataField = 'EMP_F_A_X_'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."EMP_F_A_X_"]')
          ParentFont = False
        end
        object dbDataEmpresa: TfrxMemoView
          Left = 454.055350000000000000
          Top = 133.842610000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'DATA'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."DATA"]')
          ParentFont = False
        end
        object mmFoneEmpresa: TfrxMemoView
          Left = 387.834880000000000000
          Top = 102.031540000000000000
          Width = 30.614173230000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone:')
          ParentFont = False
        end
        object mmFaxEmpresa: TfrxMemoView
          Left = 388.614410000000000000
          Top = 117.267780000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fax : ')
          ParentFont = False
        end
        object mmCEPEmpresa: TfrxMemoView
          Left = 387.834880000000000000
          Top = 85.590600000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP:')
          ParentFont = False
        end
        object mmEmitidoEm: TfrxMemoView
          Left = 387.834880000000000000
          Top = 133.283550000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitido em :')
          ParentFont = False
        end
        object mmDadosCliente: TfrxMemoView
          Align = baLeft
          Top = 181.756030000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            'Dados do Cliente ')
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Align = baLeft
          Top = 202.212740000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cod./Nome:  ')
          ParentFont = False
        end
        object dbNomeCliente: TfrxMemoView
          Align = baLeft
          Left = 64.252010000000000000
          Top = 202.433210000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'NOME'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."NOME"]')
          ParentFont = False
        end
        object mmEnderecoCliente: TfrxMemoView
          Align = baLeft
          Top = 235.889920000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o:  ')
          ParentFont = False
        end
        object dbEnderecoCliente: TfrxMemoView
          Align = baLeft
          Left = 64.252010000000000000
          Top = 235.889920000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'ENDERECO'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."ENDERECO"]')
          ParentFont = False
        end
        object mmFoneCliente: TfrxMemoView
          Align = baLeft
          Top = 269.244280000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Fone:  ')
          ParentFont = False
        end
        object dbBairroCliente: TfrxMemoView
          Left = 63.913420000000000000
          Top = 251.567100000000000000
          Width = 684.094930000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."BAIRRO"]')
          ParentFont = False
        end
        object dbTelefoneCliente: TfrxMemoView
          Align = baLeft
          Left = 34.015770000000000000
          Top = 269.244280000000000000
          Width = 104.567100000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneClienteOnAfterData'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."TELEFONE1"]')
          ParentFont = False
        end
        object mmCNPJCliente: TfrxMemoView
          Align = baLeft
          Top = 284.921460000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:  ')
          ParentFont = False
        end
        object dbCNPJCliente: TfrxMemoView
          Align = baLeft
          Left = 37.795300000000000000
          Top = 284.921460000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CLI_C_G_C_'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CLI_C_G_C_"]')
          ParentFont = False
        end
        object mmIECliente: TfrxMemoView
          Align = baLeft
          Top = 301.598640000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IE:  ')
          ParentFont = False
        end
        object dbIECliente: TfrxMemoView
          Align = baLeft
          Left = 18.897650000000000000
          Top = 301.598640000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          DataField = 'CLI_I_E_S_'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CLI_I_E_S_"]')
          ParentFont = False
        end
        object mmContatoCliente: TfrxMemoView
          Align = baLeft
          Top = 318.275820000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contato:  ')
          ParentFont = False
        end
        object dbContatoCliente: TfrxMemoView
          Align = baLeft
          Left = 49.133890000000000000
          Top = 318.275820000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataField = 'CONTATO'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."CONTATO"]')
          ParentFont = False
        end
        object dbBairroEmpresa: TfrxMemoView
          Left = 387.393940000000000000
          Top = 70.913420000000000000
          Width = 457.323130000000000000
          Height = 15.118120000000000000
          DataField = 'BAIRRO'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."BAIRRO"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 933.559680000000000000
          Top = 291.244280000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clBlue
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 948.677800000000000000
          Top = 289.244280000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 948.677800000000000000
          Top = 326.819110000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Resumo')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 948.457330000000000000
          Top = 307.921460000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheques')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 933.559680000000000000
          Top = 309.921460000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clRed
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 933.559680000000000000
          Top = 329.598640000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clGreen
          ParentFont = False
        end
        object Shape3: TfrxShapeView
          Left = 926.000620000000000000
          Top = 286.346630000000000000
          Width = 102.047310000000000000
          Height = 79.370130000000000000
        end
        object Memo34: TfrxMemoView
          Left = 948.559680000000000000
          Top = 270.008040000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Legenda')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 933.543475510000000000
          Top = 348.378170000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = 108286
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 949.118740000000000000
          Top = 346.039580000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Agrupamento')
          ParentFont = False
        end
        object dbTelefoneCliente2: TfrxMemoView
          Align = baLeft
          Left = 138.582870000000000000
          Top = 269.240000000000000000
          Width = 108.567100000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbTelefoneCliente2OnAfterData'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."TELEFONE2"]')
          ParentFont = False
        end
        object dbFoneEmpresa2: TfrxMemoView
          Left = 505.457020000000000000
          Top = 101.047310000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          OnAfterData = 'dbFoneEmpresa2OnAfterData'
          DataSet = frxEmpresa
          DataSetName = 'frxEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxEmpresa."TELEFONE2"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 15.118120000000000000
          Top = 350.598640000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PORTADOR DO CONTAS '#192' RECEBER:')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 221.992270000000000000
          Top = 350.598640000000000000
          Width = 340.157700000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODPOR]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Align = baLeft
          Top = 219.212740000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cod. Rede/Rede de Loja:')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Align = baLeft
          Left = 132.283550000000000000
          Top = 219.212740000000000000
          Width = 480.000310000000000000
          Height = 15.118120000000000000
          DataField = 'REDE'
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."REDE"]')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Align = baLeft
          Top = 336.378170000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Email:  ')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Align = baLeft
          Left = 37.795300000000000000
          Top = 335.378170000000000000
          Width = 200.315090000000000000
          Height = 15.118120000000000000
          DataSet = frxCliente
          DataSetName = 'frxCliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCliente."EMAIL"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 975.118740000000000000
        Width = 1046.929810000000000000
        object mmCitelSoftware: TfrxMemoView
          Left = 10.559060000000000000
          Top = 1.559060000000050000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Citel Software')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 19.897650000000000000
        Top = 627.401980000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object frxRelatorioCODITEM: TfrxMemoView
          Left = 17.677180000000000000
          Top = 1.559060000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DataField = 'CODITEM'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITEM"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 80.488250000000000000
          Top = 1.559060000000000000
          Width = 408.189240000000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRICAOITEM"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 615.535870000000000000
          Top = 1.511811023622047000
          Width = 86.929190000000000000
          Height = 15.118110240000000000
          DataField = 'UNIDADE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDADE"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 709.803650000000000000
          Top = 1.511811023622047000
          Width = 75.590600000000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDEITEM"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 792.953310000000000000
          Top = 1.511811020000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITARIOITEM"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 964.102970000000000000
          Top = 1.511811020000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTALDOITEM"]')
          ParentFont = False
        end
        object meVlrDescEspecial: TfrxMemoView
          Left = 880.629921260000000000
          Top = 1.511811020000000000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTALDESESP"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 831.496600000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxPaisagem.ChildSumary
        object mmDupVencidas: TfrxMemoView
          Left = 136.622140000000000000
          Top = 25.118120000000000000
          Width = 113.385831650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Dup. Venc. em aberto')
          ParentFont = False
        end
        object mmTotalDup: TfrxMemoView
          Left = 381.882190000000000000
          Top = 24.559060000000000000
          Width = 105.826766770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Dup. Original')
          ParentFont = False
        end
        object mmTotalJuros: TfrxMemoView
          Left = 502.063390000000000000
          Top = 24.559060000000000000
          Width = 94.488176770000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmTotalJurosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Juros')
          ParentFont = False
        end
        object mmTotalCor: TfrxMemoView
          Left = 616.024120000000000000
          Top = 24.559060000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Duplicata')
          ParentFont = False
        end
        object mmDupVencer: TfrxMemoView
          Left = 259.039580000000000000
          Top = 24.338590000000000000
          Width = 109.606296770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Duplicatas a Vencer')
          ParentFont = False
        end
        object TotalVencer: TfrxMemoView
          Left = 261.480520000000000000
          Top = 47.015770000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object TotalVencidas: TfrxMemoView
          Left = 138.622140000000000000
          Top = 46.236240000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 133.283550000000000000
          Top = 19.779530000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line13: TfrxLineView
          Left = 133.283550000000000000
          Top = 43.236240000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line14: TfrxLineView
          Left = 133.283550000000000000
          Top = 64.913420000000000000
          Width = 752.126470000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line17: TfrxLineView
          Left = 254.023810000000000000
          Top = 20.559060000000000000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 376.543600000000000000
          Top = 20.559060000000000000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 495.945270000000000000
          Top = 20.559060000000000000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 608.551640000000000000
          Top = 20.559060000000000000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 133.283550000000000000
          Top = 19.779530000000000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line15: TfrxLineView
          Left = 885.630490000000000000
          Top = 19.779530000000000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmTotalVencidas: TfrxMemoView
          Left = 138.622140000000000000
          Top = 46.692950000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object mmTotalVencer: TfrxMemoView
          Left = 261.480520000000000000
          Top = 47.472480000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Align = baCenter
          Left = 391.181355000000000000
          Top = 1.338589999999950000
          Width = 264.567100000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clBlue
          HAlign = haCenter
          Memo.UTF8W = (
            'Total da(s) Duplicata(s)')
          ParentFont = False
        end
        object TotalDiferenca: TfrxMemoView
          Left = 627.465060000000000000
          Top = 47.692950000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object TotalCorrigidos: TfrxMemoView
          Left = 631.244590000000000000
          Top = 47.472480000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUP"]')
          ParentFont = False
        end
        object TotalJuros: TfrxMemoView
          Left = 502.622450000000000000
          Top = 46.692950000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object TotalRecebido: TfrxMemoView
          Left = 382.441250000000000000
          Top = 46.472480000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object TotalDuplicatas: TfrxMemoView
          Left = 382.441250000000000000
          Top = 47.252010000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object Line46: TfrxLineView
          Left = 741.787880000000000000
          Top = 20.560000000000000000
          Height = 44.000000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo49: TfrxMemoView
          Left = 756.126470000000000000
          Top = 22.677180000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Corrigido')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 767.803650000000000000
          Top = 45.354360000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 505.063390000000000000
          Top = 47.133890000000000000
          Width = 94.488188980000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
      end
      object ghDuplicatas: TfrxGroupHeader
        FillType = ftBrush
        Height = 28.551190870000000000
        Top = 525.354670000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'ghDuplicatasOnBeforePrint'
        Child = frxPaisagem.ChildGHDuplicatas
        Condition = 'frxRelatorio."GRUPO"'
        object sItensDuplicata: TfrxShapeView
          Left = 3.779530000000000000
          Top = 4.559060000000050000
          Width = 1037.480488270000000000
          Height = 22.677180000000000000
        end
        object dbEspecie: TfrxMemoView
          Left = 105.614226930000000000
          Top = 8.118119999999980000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DataField = 'ESPECIE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."ESPECIE"]')
          ParentFont = False
        end
        object dbEmpresa: TfrxMemoView
          Left = 131.527646930000000000
          Top = 8.118119999999980000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataField = 'EMPRESA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMPRESA"]')
          ParentFont = False
        end
        object dbVendedor: TfrxMemoView
          Left = 165.102476930000000000
          Top = 8.118119999999980000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'VENDEDOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."VENDEDOR"]')
          ParentFont = False
        end
        object dbDtaCadastro: TfrxMemoView
          Left = 242.338716930000000000
          Top = 8.118119999999980000
          Width = 52.913390710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaCadastroOnBeforePrint'
          DataField = 'DATACADASTRO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DATACADASTRO"]')
          ParentFont = False
        end
        object dbVlrOriginal: TfrxMemoView
          Left = 465.637795280000000000
          Top = 8.118119999999980000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbVlrOriginalOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORIRELATORIO"]')
          ParentFont = False
        end
        object dbVlrDuplicata: TfrxMemoView
          Left = 550.480693310000000000
          Top = 8.118119999999980000
          Width = 75.590553620000000000
          Height = 15.118120000000000000
          DataField = 'VALORDUPLICATA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORDUPLICATA"]')
          ParentFont = False
        end
        object dbVlrJuros: TfrxMemoView
          Left = 640.764196930000000000
          Top = 8.118119999999980000
          Width = 48.692950000000000000
          Height = 15.118120000000000000
          DataField = 'VALORJUROS'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORJUROS"]')
          ParentFont = False
        end
        object dbVlrCorrigido: TfrxMemoView
          Left = 699.913856930000000000
          Top = 8.118119999999980000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'VALORCORRIGIDO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORCORRIGIDO"]')
          ParentFont = False
        end
        object Line24: TfrxLineView
          Left = 102.834696930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 130.409526930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 162.984356930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line27: TfrxLineView
          Left = 195.559186930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 297.149786930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line29: TfrxLineView
          Left = 402.614129290000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line30: TfrxLineView
          Left = 545.007874015748000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 630.039374960000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line32: TfrxLineView
          Left = 693.236225360000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllDuplicata: TfrxMemoView
          Left = 5.314965510000000000
          Top = 8.070868580000020000
          Width = 94.488213390000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllDuplicataOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 460.614178110000000000
          Top = 4.291341020000000000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo47: TfrxMemoView
          Left = 421.197096930000000000
          Top = 8.118119999999980000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo47OnBeforePrint'
          DataField = 'DIASATRASO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIASATRASO"]')
          ParentFont = False
        end
        object Line33: TfrxLineView
          Left = 776.740162360000000000
          Top = 4.291341020000000000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object dbNosNum: TfrxMemoView
          Left = 784.299756930000000000
          Top = 8.118119999999980000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CTR_NOSNUM"]')
          ParentFont = False
        end
        object dbDtaVencimento: TfrxMemoView
          Left = 299.386026930000000000
          Top = 8.118119999999980000
          Width = 49.133860710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaVencimentoOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 196.574956930000000000
          Top = 8.118119999999980000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REPRESENTANTE"]')
          ParentFont = False
        end
        object Line48: TfrxLineView
          Left = 240.149786930000000000
          Top = 3.779530000000020000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 350.519916930000000000
          Top = 4.118119999999980000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object dbDtaReceb: TfrxMemoView
          Left = 352.519916930000000000
          Top = 8.118119999999980000
          Width = 48.574800710000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbDtaRecebOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DATARECEBIMENTO"]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 868.937007870000000000
          Top = 8.692913389999940000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."CTR_BCOBOL"]')
          ParentFont = False
        end
        object Line52: TfrxLineView
          Left = 862.102367090000000000
          Top = 4.559060000000050000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 948.662030000000000000
          Top = 4.779530000000020000
          Height = 22.677165350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo66: TfrxMemoView
          Left = 952.441560000000000000
          Top = 8.692913389999940000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."FGO_NUMDOC"]')
          ParentFont = False
        end
      end
      object gfDuplicatas: TfrxGroupFooter
        FillType = ftBrush
        Height = 45.354335590000000000
        Top = 668.976810000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'gfDuplicatasOnBeforePrint'
        Child = frxPaisagem.CObservacao
        object SysMemo1: TfrxSysMemoView
          Left = 964.102970000000000000
          Top = 0.779530000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTALDOITEM">,MasterData1)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 898.158010000000000000
          Top = 0.779530000000022000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total Item :')
          ParentFont = False
        end
        object dbTOTALDESESP: TfrxSysMemoView
          Left = 797.803650000000000000
          Top = 0.779530000000022000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'dbTOTALDESESPOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [SUM(<frxRelatorio."TOTALDESESP">,MasterData1)]')
          ParentFont = False
        end
        object mmDesEsp: TfrxMemoView
          Left = 682.181510000000000000
          Top = 1.000000000000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmDesEspOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Desconto Especial : ')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 4.559060000000000000
          Top = 20.787401574803200000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmDesEspOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Endere'#231'o de Entrega Cliente:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 162.944960000000000000
          Top = 20.889763780000000000
          Width = 572.598727870000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ENDERECO_ENTREGA"]')
          ParentFont = False
          WordWrap = False
        end
        object mmMensagemTributos: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.133858270000000000
          Width = 668.976810000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxRelatorio."VALIPI">,MasterData1) <> 0, '#39'Vr. IPI: '#39' ' +
              '+ FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."VALIPI">,MasterData' +
              '1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."VALRET">,MasterData1) ' +
              '<> 0, '#39'Vr. ST: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."VA' +
              'LRET">,MasterData1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."TOTAL' +
              'FRETE">,MasterData1) <> 0, '#39'Vr. Frete: '#39' + FormatFloat('#39'#,##0.00' +
              #39', SUM(<frxRelatorio."TOTALFRETE">,MasterData1)) + '#39'   '#39', '#39#39')] [' +
              'IIF(SUM(<frxRelatorio."DESACE">,MasterData1) <> 0, '#39'Vr. Desp. Ac' +
              'es: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRelatorio."DESACE">,Mast' +
              'erData1)) + '#39'   '#39', '#39#39')] [IIF(SUM(<frxRelatorio."VFCPST">,MasterD' +
              'ata1) <> 0, '#39'Vr. FCP ST: '#39' + FormatFloat('#39'#,##0.00'#39', SUM(<frxRel' +
              'atorio."VFCPST">,MasterData1)), '#39#39')]')
          ParentFont = False
        end
      end
      object ChildGHDuplicatas: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 578.268090000000000000
        Width = 1046.929810000000000000
        object dbDUPLICATA: TfrxMemoView
          Left = 447.590910000000000000
          Top = 5.291338580000000000
          Width = 103.937007870000000000
          Height = 15.118110240000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LEGENDA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Left = 17.677180000000000000
          Top = 4.559060000000050000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Item')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 80.488250000000000000
          Top = 4.559060000000050000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 615.535870000000000000
          Top = 5.291338580000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unidade')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 709.803650000000000000
          Top = 5.291338580000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 792.953310000000000000
          Top = 5.291338580000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Unit'#225'rio')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 964.102970000000000000
          Top = 5.291338580000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object meTitDescEspecial: TfrxMemoView
          Left = 880.630490000000000000
          Top = 5.291338580000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Desc. Esp.')
          ParentFont = False
        end
      end
      object ChildSumary: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 925.984850000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'ChildSumaryOnBeforePrint'
        object SubResumo: TfrxSubreport
          Left = 1.133858267716540000
          Top = 0.779530000000022000
          Width = 120.944881890000000000
          Height = 18.897650000000000000
          Visible = False
          Page = frxPaisagem.Resumo
        end
        object SubCheques: TfrxSubreport
          Left = 2.118120000000000000
          Top = 3.543289999999960000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Visible = False
          Page = frxPaisagem.Cheques
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 449.764070000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object sDuplicata: TfrxShapeView
          Left = 3.779527560000000000
          Top = 20.661410000000000000
          Width = 1039.370252050000000000
          Height = 30.236240000000000000
        end
        object Memo39: TfrxMemoView
          Align = baCenter
          Left = 353.386055000000000000
          Top = 3.000000000000000000
          Width = 340.157700000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clBlue
          HAlign = haCenter
          Memo.UTF8W = (
            'Rela'#231#227'o de Duplicata(s) - CONTAS A RECEBER')
          ParentFont = False
        end
        object mmDuplicata: TfrxMemoView
          Left = 5.338590000000000000
          Top = 28.669295000000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object mmEspecie: TfrxMemoView
          Left = 102.590600000000000000
          Top = 28.669295000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
        end
        object mmEmpresa: TfrxMemoView
          Left = 131.504020000000000000
          Top = 28.669295000000000000
          Width = 30.236222910000000000
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
        object mmVendedor: TfrxMemoView
          Left = 165.078850000000000000
          Top = 28.669295000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vend.')
          ParentFont = False
        end
        object mmDtaCadastro: TfrxMemoView
          Left = 242.315090000000000000
          Top = 24.000000000000000000
          Width = 52.913390710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Cadastro')
          ParentFont = False
        end
        object mmDtaVencimento: TfrxMemoView
          Left = 299.362400000000000000
          Top = 24.000000000000000000
          Width = 49.133860710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Venc.')
          ParentFont = False
        end
        object mmVlrOriginal: TfrxMemoView
          Left = 465.527830000000000000
          Top = 28.669295000000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Orig.')
          ParentFont = False
        end
        object mmVlrDuplicata: TfrxMemoView
          Left = 550.457020000000000000
          Top = 28.669295000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Duplic.')
          ParentFont = False
        end
        object mmVlrJuros: TfrxMemoView
          Left = 639.031850000000000000
          Top = 28.669295000000000000
          Width = 49.472480000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Juros')
          ParentFont = False
        end
        object mmVlrCorrigido: TfrxMemoView
          Left = 699.890230000000000000
          Top = 28.629913940000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Corrig.')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 102.811070000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 130.385900000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 162.960730000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 195.535560000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 297.126160000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 402.590502360000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 544.984540000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 629.913730000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 693.251968500000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line1: TfrxLineView
          Left = 460.732530000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo46: TfrxMemoView
          Left = 419.055350000000000000
          Top = 24.000000000000000000
          Width = 37.795300000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Dias'
            'Atraso')
          ParentFont = False
        end
        object Line21: TfrxLineView
          Left = 776.535870000000000000
          Top = 21.559060000000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmNosNum: TfrxMemoView
          Left = 784.276130000000000000
          Top = 28.724409450000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Nosso n'#250'm')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 196.551330000000000000
          Top = 28.669295000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Repres.')
          ParentFont = False
        end
        object Line47: TfrxLineView
          Left = 240.126160000000000000
          Top = 22.881880000000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line49: TfrxLineView
          Left = 350.496290000000000000
          Top = 21.448811570000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmDtaReceb: TfrxMemoView
          Left = 352.716760000000000000
          Top = 23.338590000000000000
          Width = 47.574800710000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '  Data '
            'Receb.')
          ParentFont = False
        end
        object Line51: TfrxLineView
          Left = 862.087200000000000000
          Top = 21.559060000000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo64: TfrxMemoView
          Left = 869.071430000000000000
          Top = 28.724409450000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'BCO  Boleto')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 960.000620000000000000
          Top = 28.724409450000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Num. Ped. FF')
          ParentFont = False
        end
        object Line53: TfrxLineView
          Left = 948.662030000000000000
          Top = 21.543307090000000000
          Height = 30.236240000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object CObservacao: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 737.008350000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'CObservacaoOnBeforePrint'
        object Memo45: TfrxMemoView
          Left = 7.559060000000000000
          Top = 2.779530000000020000
          Width = 752.126470000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Observa'#231#227'o : ')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 7.559060000000000000
          Top = 20.677180000000000000
          Width = 752.126470000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OBS001"] [frxRelatorio."OBS002"]')
          ParentFont = False
        end
      end
    end
    object Cheques: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 3.500000000000000000
      BottomMargin = 5.000000000000000000
      object HCheques: TfrxHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Shape1: TfrxShapeView
          Left = 37.795300000000000000
          Top = 14.220470000000000000
          Width = 963.780150000000000000
          Height = 18.897650000000000000
        end
        object Memo15: TfrxMemoView
          Left = 356.637929530000000000
          Top = 16.559060000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nro. Cheque')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 43.204719530000000000
          Top = 16.000000000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 216.456729530000000000
          Top = 16.000000000000000000
          Width = 52.913385830000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 464.819129530000000000
          Top = 16.000000000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Dep'#243'sito')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 598.323149530000000000
          Top = 16.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Devolu'#231#227'o')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 750.307111030000000000
          Top = 16.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Vencimento')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 892.126489530000000000
          Top = 16.000000000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Cheque')
          ParentFont = False
        end
        object Line22: TfrxLineView
          Left = 202.929209530000000000
          Top = 14.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 271.960749530000000000
          Top = 14.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 443.362419530000000000
          Top = 13.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 566.118449530000000000
          Top = 14.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line36: TfrxLineView
          Left = 711.520119530000000000
          Top = 14.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line37: TfrxLineView
          Left = 872.480849530000000000
          Top = 13.779530000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 286.519809530000000000
          Top = 16.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia')
          ParentFont = False
        end
        object Line45: TfrxLineView
          Left = 348.992289530000000000
          Top = 14.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object MDCheques: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 83.149660000000000000
        Width = 1046.929810000000000000
        DataSet = frxCheque
        DataSetName = 'frxCheque'
        RowCount = 0
        object Shape2: TfrxShapeView
          Left = 37.795300000000000000
          Top = 2.133858270000000000
          Width = 963.780150000000000000
          Height = 18.897650000000000000
        end
        object frxChequeCHQ_NUMCHQ: TfrxMemoView
          Left = 357.858326300000000000
          Top = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_NUMCHQ"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 465.952814490000000000
          Top = 4.220470000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTADEP'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTADEP"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 599.370137320000000000
          Top = 4.220470000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTADEV'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTADEV"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 750.464591340000000000
          Top = 4.220470000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxCheque."CHQ_DTAVEN"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 892.196874800000000000
          Top = 4.220470000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheque."CHQ_VALCHQ"]')
          ParentFont = False
        end
        object frxChequeCHQ_CODEMP: TfrxMemoView
          Left = 43.480319840000000000
          Top = 3.779530000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODEMP'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_CODEMP"]')
          ParentFont = False
        end
        object frxChequeCHQ_CODBCO: TfrxMemoView
          Left = 216.559169840000000000
          Top = 3.779530000000000000
          Width = 52.913385830000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_CODBCO'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_CODBCO"]')
          ParentFont = False
        end
        object Line38: TfrxLineView
          Left = 203.189000780000000000
          Top = 2.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line39: TfrxLineView
          Left = 273.196908970000000000
          Top = 2.220470000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line40: TfrxLineView
          Left = 444.409507400000000000
          Top = 2.000000000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line41: TfrxLineView
          Left = 567.244153070000000000
          Top = 2.220470000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line42: TfrxLineView
          Left = 711.535457480000000000
          Top = 2.220470000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line43: TfrxLineView
          Left = 872.543331490000000000
          Top = 2.220470000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object frxChequeCHQ_NUMAGE: TfrxMemoView
          Left = 287.559113700000000000
          Top = 4.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxCheque
          DataSetName = 'frxCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheque."CHQ_NUMAGE"]')
          ParentFont = False
        end
        object Line44: TfrxLineView
          Left = 349.921318420000000000
          Top = 2.220470000000000000
          Height = 18.897650000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object FCheque: TfrxFooter
        FillType = ftBrush
        Height = 48.598640000000000000
        Top = 128.504020000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'Footer1OnBeforePrint'
        Child = frxPaisagem.FChequeChild
        object SysMemo2: TfrxSysMemoView
          Left = 626.504330000000000000
          Top = 23.677180000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheque."CHQ_VALCHQ">,MDCheques)]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 543.897960000000000000
          Top = 23.677180000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque : ')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 480.039775160000000000
          Top = 3.779530000000000000
          Width = 268.346456690000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clRed
          HAlign = haCenter
          Memo.UTF8W = (
            'Total do(s) Cheque(s)')
          ParentFont = False
        end
        object Shape4: TfrxShapeView
          Left = 507.559370000000000000
          Top = 21.456710000000000000
          Width = 219.212740000000000000
          Height = 18.897650000000000000
        end
      end
      object FChequeChild: TfrxChild
        FillType = ftBrush
        Height = 238.204700000000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        Stretched = True
        object mmInformacoesAdicionais: TfrxMemoView
          Left = 8.000000000000000000
          Top = 194.299320000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Adicionais : ')
          ParentFont = False
        end
        object dbAdicionais: TfrxMemoView
          Left = 8.000000000000000000
          Top = 211.535560000000000000
          Width = 752.126470000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'ADICIONAIS'
          DataSet = frxInformacoes
          DataSetName = 'frxInformacoes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxInformacoes."ADICIONAIS"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 366.716760000000000000
          Top = 3.779530000000000000
          Width = 393.070946690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGreen
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO GERAL')
          ParentFont = False
        end
        object Shape5: TfrxShapeView
          Left = 366.716760000000000000
          Top = 26.456710000000000000
          Width = 393.071120000000000000
          Height = 154.960730000000000000
        end
        object SysMemo3: TfrxSysMemoView
          Left = 574.842920000000000000
          Top = 121.724490000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxCheque."CHQ_VALCHQ">,MDCheques)]')
          ParentFont = False
        end
        object mmResumoCheque: TfrxMemoView
          Left = 449.661720000000000000
          Top = 122.283550000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque: ')
          ParentFont = False
        end
        object mmResumoVencidas: TfrxMemoView
          Left = 449.661720000000000000
          Top = 29.795300000000000000
          Width = 117.165361650000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmResumoVencidasOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas Vencidas:')
          ParentFont = False
        end
        object mmResumoDuplicatas: TfrxMemoView
          Left = 450.220780000000000000
          Top = 67.031540000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Duplicatas:')
          ParentFont = False
        end
        object mmResumoJuros: TfrxMemoView
          Left = 449.441250000000000000
          Top = 85.929190000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmResumoJurosOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Juros:')
          ParentFont = False
        end
        object mmResumoCorrigido: TfrxMemoView
          Left = 449.779840000000000000
          Top = 103.826840000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Corrigido:')
          ParentFont = False
        end
        object mmResumoVencer: TfrxMemoView
          Left = 449.897960000000000000
          Top = 47.913420000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas a Vencer:')
          ParentFont = False
        end
        object ResumoTotalDuplicata: TfrxMemoView
          Left = 574.606680000000000000
          Top = 67.031540000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object ResumoTotalRecebido: TfrxMemoView
          Left = 575.165740000000000000
          Top = 67.031540000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object ResumoTotalCorrigido: TfrxMemoView
          Left = 574.386210000000000000
          Top = 104.826840000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object ResumoTotalDiferenca: TfrxMemoView
          Left = 574.386210000000000000
          Top = 104.826840000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object ResumoTotalVencer: TfrxMemoView
          Left = 574.606680000000000000
          Top = 48.354360000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object ResumoTotalJuros: TfrxMemoView
          Left = 574.386210000000000000
          Top = 86.929190000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object ResumoTotalVencida: TfrxMemoView
          Left = 574.386210000000000000
          Top = 30.456710000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoDispCh: TfrxMemoView
          Left = 449.661720000000000000
          Top = 157.947742420000000000
          Width = 135.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite cr'#233'dito dispon'#237'vel: ')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredDispCh: TfrxMemoView
          Left = 592.466296670000000000
          Top = 157.947742420000000000
          Width = 95.762523330000000000
          Height = 15.118120000000000000
          DataField = 'TOTALCREDITODISP'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCREDITODISP"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoCh: TfrxMemoView
          Left = 449.661720000000000000
          Top = 140.518243330000000000
          Width = 146.503944330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite de cr'#233'dito do cliente:')
          ParentFont = False
        end
        object mmResumoVlrLimiteCreditoCh: TfrxMemoView
          Left = 599.040508180000000000
          Top = 140.518243330000000000
          Width = 89.188311820000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."CREDCLI"]')
          ParentFont = False
        end
      end
      object Memo14: TfrxMemoView
        Left = 214.803422870000000000
        Top = 15.118120000000000000
        Width = 612.283640310000000000
        Height = 15.118120000000000000
        DisplayFormat.DecimalSeparator = ','
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Fill.BackColor = clRed
        HAlign = haCenter
        Memo.UTF8W = (
          'Rela'#231#227'o de Cheque(s)')
        ParentFont = False
      end
    end
    object Resumo: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 3.500000000000000000
      BottomMargin = 5.000000000000000000
      object MDInformacao: TfrxMasterData
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 253.228510000000000000
        Width = 1046.929810000000000000
        DataSet = frxInformacoes
        DataSetName = 'frxInformacoes'
        RowCount = 0
        Stretched = True
        object Memo40: TfrxMemoView
          Left = 7.118120000000000000
          Top = 4.118120000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Informa'#231#245'es Adicionais : ')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 7.118120000000000000
          Top = 22.354360000000000000
          Width = 752.126470000000000000
          Height = 18.897430310000000000
          StretchMode = smMaxHeight
          DataField = 'ADICIONAIS'
          DataSet = frxInformacoes
          DataSetName = 'frxInformacoes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxInformacoes."ADICIONAIS"]')
          ParentFont = False
        end
      end
      object HResumo: TfrxHeader
        FillType = ftBrush
        Height = 211.653680000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'Header2OnBeforePrint'
        object Memo42: TfrxMemoView
          Left = 337.378170000000000000
          Top = 2.000000000000000000
          Width = 393.070946690000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGreen
          HAlign = haCenter
          Memo.UTF8W = (
            'RESUMO GERAL')
          ParentFont = False
        end
        object Shape6: TfrxShapeView
          Left = 337.378170000000000000
          Top = 19.677180000000000000
          Width = 393.071120000000000000
          Height = 185.196869920000000000
        end
        object RResumoCheques: TfrxMemoView
          Left = 405.323137320000000000
          Top = 150.504020000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Cheque: ')
          ParentFont = False
        end
        object RResumoVencidas: TfrxMemoView
          Left = 405.323130000000000000
          Top = 24.015770000000000000
          Width = 117.165361650000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dup. Venc. em aberto:')
          ParentFont = False
        end
        object RResumoDuplicata: TfrxMemoView
          Left = 405.323134880000000000
          Top = 78.252010000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'RResumoDuplicataOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Duplicatas:')
          ParentFont = False
        end
        object RResumoJuros: TfrxMemoView
          Left = 405.323137320000000000
          Top = 97.149660000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Juros:')
          ParentFont = False
        end
        object RResumoCorrigido: TfrxMemoView
          Left = 405.323137320000000000
          Top = 132.047310000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Corrigido:')
          ParentFont = False
        end
        object RResumoVencer: TfrxMemoView
          Left = 405.323134880000000000
          Top = 42.133890000000000000
          Width = 117.165356770000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas a Vencer:')
          ParentFont = False
        end
        object ResumoRecebido: TfrxMemoView
          Left = 544.945270000000000000
          Top = 78.252010000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALRECEBIDO"]')
          ParentFont = False
        end
        object ResumoCorrigido: TfrxMemoView
          Left = 545.047620000000000000
          Top = 132.047310000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object ResumoDiferenca: TfrxMemoView
          Left = 545.827150000000000000
          Top = 115.047310000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDIFERENCA"]')
          ParentFont = False
        end
        object ResumoVencer: TfrxMemoView
          Left = 545.268090000000000000
          Top = 42.133890000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPAVE"]')
          ParentFont = False
        end
        object ResumoJuros: TfrxMemoView
          Left = 545.047620000000000000
          Top = 97.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALJUROS"]')
          ParentFont = False
        end
        object ResumoVencidas: TfrxMemoView
          Left = 545.047620000000000000
          Top = 24.015770000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataField = 'DUPVEN'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."DUPVEN"]')
          ParentFont = False
        end
        object mmResumoCheques: TfrxMemoView
          Left = 545.252320000000000000
          Top = 150.165430000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object RResumoDiferenca: TfrxMemoView
          Left = 405.323137320000000000
          Top = 115.267780000000000000
          Width = 117.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Diferen'#231'a:')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 544.945270000000000000
          Top = 78.472480000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALDUPLICATA"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 545.827150000000000000
          Top = 115.047310000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCORRIGIDO"]')
          ParentFont = False
        end
        object mmResumoLimiteCreditoDisp: TfrxMemoView
          Left = 405.323137320000000000
          Top = 185.440940000000000000
          Width = 135.165354330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite cr'#233'dito dispon'#237'vel: ')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredDisp: TfrxMemoView
          Left = 548.709030000000000000
          Top = 185.440940000000000000
          Width = 109.929190000000000000
          Height = 15.118120000000000000
          DataField = 'TOTALCREDITODISP'
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."TOTALCREDITODISP"]')
          ParentFont = False
        end
        object mmResumoLimiteCredito: TfrxMemoView
          Left = 405.323137320000000000
          Top = 168.011440910000000000
          Width = 146.503944330000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Limite de cr'#233'dito do cliente:')
          ParentFont = False
        end
        object mmResumoVlrLimiteCredito: TfrxMemoView
          Left = 554.449908180000000000
          Top = 168.011440910000000000
          Width = 104.188311820000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxTotal."CREDCLI"]')
          ParentFont = False
        end
        object RResumoGeralAberto: TfrxMemoView
          Left = 405.409710000000000000
          Top = 60.472480000000000000
          Width = 120.944886770000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total Geral em Aberto:')
          ParentFont = False
        end
        object ResumoGeralAberto: TfrxMemoView
          Left = 544.693260000000000000
          Top = 60.472480000000000000
          Width = 113.385826770000000000
          Height = 15.118120000000000000
          DataSet = frxTotal
          DataSetName = 'frxTotal'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxTotal."DUPVEN"> + <frxTotal."DUPAVE">]')
          ParentFont = False
        end
      end
    end
  end
end
