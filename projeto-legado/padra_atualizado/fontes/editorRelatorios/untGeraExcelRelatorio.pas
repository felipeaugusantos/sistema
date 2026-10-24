unit untGeraExcelRelatorio;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers,
  Vcl.Graphics, Uni, DB, untFuncoesSimples,
  cxProgressBar, Forms, untGravando,
  untFuncEditorRel, untZClient, Math, untGeraFR3,
  untGridRelatorio;

CONST
  ARR_CORES_QUEBRA: ARRAY[0..9] Of String =
  ('#AADCF7', '#FDE9A9', '#5F9EA0', '#BDB76B', '#7CFC00', '#EE82EE', '#C0C0C0', '#FFC0CB', '#B0C4DE', '#DEB887');

  COR_ZEBRA = '#F0F0F0';

type
  TDetalhe = Record
    strFontName,
    strFontStylesInicio,
    strFontStylesFinal,
    strColor,
    strBrushColor: String;
  End;

  TGeraExcelRelatorio = class(TComponent)
    private
      FIndexRelatorio: Integer;

      FArquivoAberto: String;
      FTextFile: TextFile;

      FColumnIndex,
      FArquivo: TStringList;

      FDetalhe: TDetalhe;

      FNomeArquivo: String;

      FNroRel,
      FNroGrid,
      FPosLargura,
      FNroColunas: Integer;

      FGravaDireto,
      FNaZebra: Boolean;

      FGeraFR3: TGeraFR3;

      arrTotais: Array Of Record
        strTitulo,
        strValor: String;

        intLinha: Integer;
      End;

      blnTemTotal: Boolean;

      function fRemoveDesenhoLinha(strLinha: string): string;

      function fMskDigitos(intDigitos: Integer; blnMilhar: boolean = True): String;

      Function fGetCdsCampos: TZClient;

      Procedure pEscreveLinha(strLinha: String);

      Procedure pEscreveNomeEmpresa;
      Function fGetBkColorTituloRel: String;
      Function fGetBkColorNomeEmpresa: String;
      Function fTituloRelatorio: String;
      procedure pEscreveTituloRelatorio;
      procedure pEscreveFiltroPrimeiro(strFiltro: String);
      Function fGetNomeFontFiltro: String;
      procedure pEscreveFiltroMeio(strFiltro: String);
      procedure pEscreveFiltroUltimo(strFiltro: String);
      procedure pEscreveFiltros;

      Function fGetSdnum: String;

      Function fGetAlinhamento: String;

      procedure pEscreveTituloCamposPelaGrid;

      Procedure pEscreveCampoLinhaDetalhe(intColumnIndex, intNumRec: Integer; strValor: String);

      Procedure pGetFonteDetalhe(intNumRec: Integer);

      Function fGetFontName(strDefFonte: String): String;

      Function fGetFontNameTituloColuna: String;
      Function fGetFontColorTituloColuna: String;
      Function fGetFontBkColorTituloColuna: String;
      Function fGetFontStyleTituloColuna(Var strFontStylesFinal: String): String;

      Function fGetSdvalPelaGrid(intColumnIndex: Integer; strValor: String): String;
      Function fGetValorCampoPelaGrid(strValor: String): String;

      Function fGetBkColorCampoDetalhe: String;
      Function fGetColorCampoDetalhe: String;
      Function fGetFontCampoDetalhe: String;

      Function fGetColorCampoQuebra: String;
      Function fGetColorCampoTotal: String;

      Function fGetBkColorQuebra(intQuebra: Integer): String;
      Procedure pEscreveCampoQuebra(intColumnIndex, intQuebra: Integer; strValor: String);
      Function fGetFontQuebra: String;

      Procedure pListaTotais(intInicio, intQuebra: Integer);

      Procedure pListaTotalGeral;

      Procedure pGeraLinhasDetalhePelaGrid;

      Function fProximaLinhaDados(intIndex: Integer): Integer;

      Function fGetNumeroColunas: Integer;

      procedure pCriaParametrosInterno(FParametros: TZClient; blnParamsAut: Boolean = False);

      Procedure pGeraRelatorioCorrente;

      Procedure pSetNomeArquivo(value: String);

      Function fAbreArquivo(strNomeArquivo: String): Boolean;

    public
      strCorZebra: String;

      frmGravando: TfrmGravando;

      grdGridRelatorioGeral: TGridRelatorioGeral;

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

      procedure pIniciaHTML(FArquivo: TStringList);
      procedure pInsereLarguraColuna(FArquivo: TStringList; Var FPosLargura: Integer; intPixels: Integer);
      procedure pEscreveTituloCampo(FArquivo: TStringList; strTitulo, strAlinhamento: String);

      procedure pSaveFile(ANomeArquivo: String; frmGravando: TfrmGravando);
      procedure pFinalizaHTML(FArquivo: TStringList);

      function fColorToHtml(cor: TColor): string;

      Function fGeraExcel(AIndexRelatorio: Integer = -1): Boolean;

    published

      Property objGeraGR3: TGeraFR3 Read FGeraFR3 Write FGeraFR3;
      Property strNomeArquivo: String Read FNomeArquivo Write pSetNomeArquivo;
  end;

implementation

Uses
  Windows,
  cxGridDBTableView,
  cxGridCustomTableView,
  cxGraphics,
  untRelFrx,
  UITypes,
  untExcel, untFuncoesEditorFast,
  System.MaskUtils, untConstantes, untFuncoesGenerica,
  untRelatorio, untInterfaceRelatorio;

constructor TGeraExcelRelatorio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FArquivoAberto := '';

  strCorZebra := COR_ZEBRA;

  FIndexRelatorio := -1;

  FArquivo := TStringList.Create;
  FColumnIndex  := TStringList.Create;

  grdGridRelatorioGeral := Nil;
end;

destructor TGeraExcelRelatorio.Destroy;
begin
  inherited;

  FreeAndNil(FArquivo);
end;

Function TGeraExcelRelatorio.fAbreArquivo(strNomeArquivo: String): Boolean;
Begin
  Try
    If SameText(strNomeArquivo, FArquivoAberto) Then
    Begin
      Result := True;
      Exit;
    End;

    AssignFile(FTextFile, strNomeArquivo);
    Rewrite(FTextFile);

    FArquivoAberto := strNomeArquivo;

   Result := True;

  Except

    On E: Exception Do
    Begin
      FArquivoAberto := '';
      pMensagensErro(E.Message, 'TGeraExcelRelatorio.fAbreArquivo');
      Result := False;
    End;
  End;

End;

function TGeraExcelRelatorio.fMskDigitos(intDigitos: Integer; blnMilhar: boolean = True): String;
  Var
    intContador: Integer;
    strMsk1, strMsk2: String;
begin
  strMsk1 := '';
  If blnMilhar Then
    strMsk1 := '#.##';
  strMsk2 := '0,';

  If (intDigitos = 0) Then
    intDigitos := 2;

  For intContador := 1 To intDigitos Do
  Begin
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;
end;

procedure TGeraExcelRelatorio.pSaveFile(ANomeArquivo: String; frmGravando: TfrmGravando);
  Var
    FExcel: TExcel;
Begin
  If Assigned(frmGravando) Then
  Begin
    frmGravando.pgbStatus.Visible := False;
    frmGravando.lblGravando.Caption := 'Convertendo arquivo para excel...';
    Application.ProcessMessages;
  End;

  FExcel := TExcel.fCriarExcel(nil);

  FExcel.AbrirArquivo(ChangeFileExt(ANomeArquivo, '.xls'));
  FExcel.blnShowOnTerminate := False;
  FExcel.AutoAjuste;
  FExcel.SalvarArquivo(True);
  FExcel.FecharArquivo;

  FreeAndNil(FExcel);
End;

Function TGeraExcelRelatorio.fGetCdsCampos: TZClient;
begin
  If FNroRel = 0 Then
    Result := FGeraFr3.cdsCamposG
  Else
    Result := TRelatorio(FGeraFr3.arrSalvaComplementos[Pred(FGeraFr3.arrControleRel[FNroRel].intExcel)]).objInterface.cdsCampos;
End;

Function TGeraExcelRelatorio.fGetNumeroColunas: Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;

  For intContador := 0 To grdGridRelatorioGeral.cxColumnCount -1 Do
    If grdGridRelatorioGeral.fcxColumns(intContador).Visible Then
      Inc(Result);

  If Result = 0 Then
    Result := 1;
End;

Procedure TGeraExcelRelatorio.pEscreveLinha(strLinha: String);
Begin
  If FGravaDireto Then
    Writeln(FTextFile, strLinha)
  Else
    FArquivo.Add(strLinha);
End;

procedure TGeraExcelRelatorio.pIniciaHTML(FArquivo: TStringList);
begin
	pEscreveLinha('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');

	pEscreveLinha('<html>');
	pEscreveLinha('<head>');

	pEscreveLinha('	<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>');
	pEscreveLinha('	<title></title>');
	pEscreveLinha('	<meta name="generator" content="LibreOffice 6.4.7.2 (Windows)"/>');
	pEscreveLinha('	<meta name="created" content="00:00:00"/>');
	pEscreveLinha('	<meta name="changed" content="' + FormatDateTime('YYYY-MM-DD', VS_Date) + 'T' + FormatDateTime('HH:NN:SS', fTime()) + '.495000000"/>');

	pEscreveLinha('	<style type="text/css">');
	pEscreveLinha('		body,div,table,thead,tbody,tfoot,tr,th,td,p { font-family:"Arial"; font-size:x-small }');
	pEscreveLinha('		a.comment-indicator:hover + comment { background:#ffd; position:absolute; display:block; border:1px solid black; padding:0.5em;  }');
	pEscreveLinha('		a.comment-indicator { background:red; display:inline-block; border:1px solid black; width:0.5em; height:0.5em;  }');
	pEscreveLinha('		comment { display:none;  }');
	pEscreveLinha('	</style>');

	pEscreveLinha('</head>');

	pEscreveLinha('<body>');
	pEscreveLinha('<table cellspacing="0" border="0">');
end;

procedure TGeraExcelRelatorio.pFinalizaHTML(FArquivo: TStringList);
begin
  pEscreveLinha('</table>');
  pEscreveLinha('</body>');
  pEscreveLinha('</html>');
End;

Function TGeraExcelRelatorio.fGetBkColorNomeEmpresa: String;
Begin
  Result := '#AADCF7';
End;

procedure TGeraExcelRelatorio.pEscreveNomeEmpresa;
Begin
	pEscreveLinha('<tr>');
	pEscreveLinha(Concat('	<td colspan=', FNroColunas.ToString, ' height="18" align="center" bgcolor="', fGetBkColorNomeEmpresa, '"><b>', FGeraFR3.fGetNomeEmpresa, '</b></td>'));
	pEscreveLinha('</tr>');
End;

Function TGeraExcelRelatorio.fGetBkColorTituloRel: String;
Begin
  Result := '#EEEEEE';
End;


Function TGeraExcelRelatorio.fTituloRelatorio: String;
Begin
  If FNroRel = 0 Then
    Result := FGeraFR3.fGetTituloRelatorio
  Else
    Result := FGeraFR3.fGetTituloRelatorios(FNroRel);
End;

procedure TGeraExcelRelatorio.pEscreveTituloRelatorio;
Begin
  If fTituloRelatorio.IsEmpty Then
  Begin
    pEscreveLinha('	<tr>');
  End Else
  Begin
    pEscreveLinha('<tr>');
    pEscreveLinha('		<td height="17" align="left" valign=bottom><br></td>');
    pEscreveLinha('	</tr>');
    pEscreveLinha('	<tr>');
    pEscreveLinha(Concat('		<td colspan=', FNroColunas.ToString, ' height="20" align="center" valign=bottom bgcolor="', fGetBkColorTituloRel, '"><b><font size=3>', fTituloRelatorio, '</font></b></td>'));
    pEscreveLinha('		</tr>');
    pEscreveLinha('	<tr>');
    pEscreveLinha('		<td height="17" align="left" valign=bottom><br></td>');
    pEscreveLinha('	</tr>');
  End;
End;

Function TGeraExcelRelatorio.fGetNomeFontFiltro: String;
Begin
  Result := 'Courier New';
End;

procedure TGeraExcelRelatorio.pEscreveFiltroPrimeiro(strFiltro: String);
Begin
	pEscreveLinha('<tr>');
	pEscreveLinha(Concat('		<td style="border-top: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" colspan=', FNroColunas.ToString, ' height="20" align="left" bgcolor="#F6F9D4"><font face="', fGetNomeFontFiltro, '">', strFiltro, '</font></td>'));
	pEscreveLinha('		</tr>');
End;

procedure TGeraExcelRelatorio.pEscreveFiltroMeio(strFiltro: String);
Begin
	pEscreveLinha('<tr>');
	pEscreveLinha(Concat('		<td style="border-left: 1px solid #000000; border-right: 1px solid #000000" colspan=', FNroColunas.ToString, ' height="20" align="left" bgcolor="#F6F9D4"><font face="', fGetNomeFontFiltro, '">', strFiltro, '</font></td>'));
	pEscreveLinha('		</tr>');
End;

procedure TGeraExcelRelatorio.pEscreveFiltroUltimo(strFiltro: String);
Begin
	pEscreveLinha('<tr>');
	pEscreveLinha(Concat('		<td style="border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" colspan=', FNroColunas.ToString, ' height="20" align="left" bgcolor="#F6F9D4"><font face="', fGetNomeFontFiltro, '">', strFiltro, '</font></td>'));
	pEscreveLinha('		</tr>');
End;

procedure TGeraExcelRelatorio.pCriaParametrosInterno(FParametros: TZClient; blnParamsAut: Boolean = False);
  Var
    intIndex: Integer;
begin

  If Not blnParamsAut then
    FParametros.IndexFieldNames := 'PAR_ORDENA'
  Else
  begin
    FParametros.Filtered := False;
    FParametros.Filter := 'PARVIS = 1';
    FParametros.Filtered := True;
  end;

  FParametros.First;

  While Not FParametros.Eof Do
  Begin
    intIndex := FGeraFR3.sltListaParFiltros.IndexOf(FParametros.FieldByName('PAR_NOMPAR').AsString);

    If intIndex > -1 Then
    Begin
      If FParametros.RecNo = 1 Then
        pEscreveFiltroPrimeiro(FGeraFR3.fTrataAcento(FGeraFR3.stlTituloFiltros[intIndex]))

      Else If FParametros.RecNo = FParametros.Recordcount Then
        pEscreveFiltroUltimo(FGeraFR3.fTrataAcento(FGeraFR3.stlTituloFiltros[intIndex]))

      Else
        pEscreveFiltroMeio(FGeraFR3.fTrataAcento(FGeraFR3.stlTituloFiltros[intIndex]))
    End;

    FParametros.Next;
  End;

  if blnParamsAut then
  begin
    FParametros.Filtered := False;
    FParametros.Filter := '';
  end;
End;

procedure TGeraExcelRelatorio.pEscreveFiltros;
Begin
  If Assigned(frmGravando) Then
  Begin
    frmGravando.lblGravando.Caption := 'Listando filtro do relatório...';
    Application.ProcessMessages;
  End;

  FGeraFR3.pCarregaTitulosRelatorio;

  pCriaParametrosInterno(FGeraFR3.cdsParams);
  pCriaParametrosInterno(FGeraFR3.cdsParamsAut, True);

	pEscreveLinha('		<td height="17" align="left"><br></td>');
End;

procedure TGeraExcelRelatorio.pInsereLarguraColuna(FArquivo: TStringList; Var FPosLargura: Integer; intPixels: Integer);
Begin
  If FGravaDireto Then
    pEscreveLinha(Concat('	<colgroup width="', intPixels.ToString, '"></colgroup>'))
  Else
    FArquivo.Insert(FPosLargura, Concat('	<colgroup width="', intPixels.ToString, '"></colgroup>'));

  Inc(FPosLargura);
End;

Function TGeraExcelRelatorio.fGetFontNameTituloColuna: String;
  Var
    fntFonte: TFont;
Begin
  Result := 'Courier New';

  If Not fEmptyStr(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString) Then
  Begin
    fntFonte := TInterfaceRelatorio.StrToFont(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString);
    Result := fntFonte.Name;
    FreeAndNil(fntFonte);
  End;
End;

Function TGeraExcelRelatorio.fGetFontColorTituloColuna: String;
  Var
    fntFonte: TFont;
Begin
  Result := '#FFFFFF';

  If Not fEmptyStr(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString) Then
  Begin
    fntFonte := TInterfaceRelatorio.StrToFont(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString);
    Result := fColorToHtml(fntFonte.Color);
    FreeAndNil(fntFonte);
  End;

  If Result.IsEmpty Then
    Result := '#FFFFFF';
End;

Function TGeraExcelRelatorio.fGetFontStyleTituloColuna(Var strFontStylesFinal: String): String;
  Var
    fntFonte: TFont;
Begin
  Result := '<b>';
  strFontStylesFinal := '</b>';

  If Not fEmptyStr(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString) Then
  Begin
    fntFonte := TInterfaceRelatorio.StrToFont(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FONTCO').AsString);
    Result := '';
    strFontStylesFinal := '';

    If fsBold In fntFonte.Style Then
    Begin
      Result := '<b>';
      strFontStylesFinal := '</b>';
    End;

    If fsItalic In fntFonte.Style Then
    Begin
      Result := Concat(Result, '<i>');
      strFontStylesFinal := Concat(strFontStylesFinal, '</i>');
    End;

    If fsUnderline In fntFonte.Style Then
    Begin
      Result := Concat(Result, '<u>');
      strFontStylesFinal := Concat(strFontStylesFinal, '</u>');
    End;

    If fsStrikeOut In fntFonte.Style Then
    Begin
      Result:= Concat(Result, '<s>');
      strFontStylesFinal := Concat(strFontStylesFinal, '</s>');
    End;

    FreeAndNil(fntFonte);
  End;
End;

Function TGeraExcelRelatorio.fGetFontBkColorTituloColuna: String;
Begin
  Result := '#000000';

  If FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FUNTCO').AsInteger > 0 Then
    Result := fColorToHtml(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_FUNTCO').AsInteger);

  If Result.IsEmpty Then
    Result := '#000000';
End;

procedure TGeraExcelRelatorio.pEscreveTituloCampo(FArquivo: TStringList; strTitulo, strAlinhamento: String);
  Var
    strFontStylesFinal: String;
Begin
	pEscreveLinha(Concat('<td height="20" align="', strAlinhamento,
   '" bgcolor="', fGetFontBkColorTituloColuna, '">', fGetFontStyleTituloColuna(strFontStylesFinal),
             '<font face="', fGetFontNameTituloColuna, '" color="', fGetFontColorTituloColuna, '">', strTitulo, '</font>',
             strFontStylesFinal, '</td>'));
End;

Function TGeraExcelRelatorio.fGetSdnum: String;
Begin
  Result := '';

  Case FGeraFR3.qryDados[FNroRel].FieldByName(fGetCdsCampos.FieldByName('CAM_NOMCAM').AsString).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint,
    ftCurrency,
    ftFloat: Result := Concat('sdnum="1046;0;', fMskDigitos(fGetCdsCampos.FieldByName('CAM_NRODEC').AsInteger) , '"');

    ftDate: Result := 'sdnum="1046;0;DD/MM/AA"';

    ftString: If fEmptyStr(fGetCdsCampos.FieldByName('CAM_MASCAR').AsString) Then
                Result := 'sdnum="1046;0;@"';
  End;
End;

Function TGeraExcelRelatorio.fGetColorCampoQuebra: String;
Begin
  Result := '';
End;

Function TGeraExcelRelatorio.fGetColorCampoTotal: String;
Begin
  Result := '';
End;

procedure TGeraExcelRelatorio.pEscreveTituloCamposPelaGrid;
  Var
    intContador: Integer;
Begin
	pEscreveLinha('<tr>');

  FColumnIndex.Clear;

  For intContador := 0 To grdGridRelatorioGeral.cxColumnCount -1 Do
  If grdGridRelatorioGeral.fcxColumns(intContador).Visible And
     fGetCdsCampos.FindKey([grdGridRelatorioGeral.fcxFieldNameColumns(grdGridRelatorioGeral.fcxColumns(intContador).Index)]) Then
  Begin
    If Not FGravaDireto Then
      pInsereLarguraColuna(FArquivo, FPosLargura, grdGridRelatorioGeral.fcxColumns(intContador).Width);

    pEscreveTituloCampo(FArquivo, grdGridRelatorioGeral.fcxColumns(intContador).Caption,
                        fGetAlinhamento);

    FColumnIndex.Add(grdGridRelatorioGeral.fcxColumns(intContador).Index.ToString());
  End;

	pEscreveLinha('	</tr>');
End;

Function TGeraExcelRelatorio.fGetSdvalPelaGrid(intColumnIndex: Integer; strValor: String): String;
Begin
  Result := '';

  Case grdGridRelatorioGeral.fcxDataController.DataSource.DataSet.FieldByName(
                grdGridRelatorioGeral.fcxFieldNameColumns(intColumnIndex)).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftCurrency,
    ftFloat,
    ftLargeint: Result := Concat('sdval="', ReplaceStr(strValor, '.', ',') , '" ');

    ftString: Case TInterfaceRelatorio.fDescMascaraToTipo(fGetCdsCampos.FieldByName('CAM_MASCAR').AsString) Of
                masCNPJ,
                masContabil,
                masTelefone,
                masCEP,
                masPlacaVeiculo,
                masPlanoContabil,
                masCondPagto:  Result := Concat('sdval="', strValor, '" ');
              End;
  End;
End;

Function TGeraExcelRelatorio.fGetValorCampoPelaGrid(strValor: String): String;
Begin
  Case FGeraFR3.qryDados[FNroRel].FieldByName(fGetCdsCampos.FieldByName('CAM_NOMCAM').AsString).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint: Result := strValor;

    ftCurrency,
    ftFloat  : Result := AnsiReplaceStr(strValor, '.', ',');

    ftString: Case TInterfaceRelatorio.fDescMascaraToTipo(fGetCdsCampos.FieldByName('CAM_MASCAR').AsString) Of
                masCNPJ         : Result := FGeraFR3.fFormataCpfCgcRel(strValor);

                masContabil     : Result := FGeraFR3.fFormataContabilRel(StrToFloatDef(strValor, 0),
                                                                         StrToIntDef(fGetCdsCampos.FieldByName('CAM_NRODEC').AsString, 2), False);

                masTelefone     : Result := FormatMaskText(fRetMascaraFonePais, strValor);

                masCEP          : Result := FormatMaskText('99999-999;0;_', strValor);

                masPlacaVeiculo : Result := FormatMaskText('lll-9999;0;_', strValor);

                masPlanoContabil: Result := FormatMaskText(fCfgSis('MSKCON') + ';0;_', strValor);

                masCondPagto    : Result := FormatMaskText(MASK_CONPAG, strValor);

                Else Result := strValor;
              End;

    Else Result := strValor;
  End;

  Result := Trim(Result);
End;

Function TGeraExcelRelatorio.fGetAlinhamento: String;
Begin
  If AnsiMatchStr(fGetCdsCampos.FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
  Begin

    If SameText(fGetCdsCampos.FieldByName('CAM_TIPCAM').AsString, 'Número inteiro') Or
       SameText(fGetCdsCampos.FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Then
      Result := 'right'
    Else
      Result := 'left'

  End Else
  Begin

    Case AnsiIndexStr(fGetCdsCampos.FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
      0 :  Result := 'left';
      1 :  Result := 'center';
      Else Result := 'right';
    End;

  End;

End;

Function TGeraExcelRelatorio.fGetFontCampoDetalhe: String;
Begin
  Result := Concat(FDetalhe.strFontStylesInicio, '<font face="', FDetalhe.strFontName, '"');
End;

function TGeraExcelRelatorio.fColorToHtml(cor: TColor): string;
begin
  If Cor >= 0 Then
    Result := Concat('#', IntToHex(GetRValue(cor), 2), IntToHex(GetGValue(cor), 2), IntToHex(GetBValue(cor), 2))
  Else
    Result := '';
end;

Function TGeraExcelRelatorio.fGetFontName(strDefFonte: String): String;
Begin
  Result := TdtmRelFrx.fRetornaFontName(strDefFonte);

  If Result.IsEmpty Then
    Result := 'Arial';
End;

Procedure TGeraExcelRelatorio.pGetFonteDetalhe(intNumRec: Integer);
  Var
    intIndexCampoFonte: Integer;
    strDefFonte,
    strFontStyles: String;
Begin
  Fillchar(FDetalhe, SizeOf(FDetalhe), #0);
  FDetalhe.strFontName := 'Arial';

  If grdGridRelatorioGeral.arrGrid[FNroGrid].cdsCoresColunas.locate('campo', fGetCdsCampos.FieldByName('CAM_NOMCAM').AsString, [])
               And (Not grdGridRelatorioGeral.arrGrid[FNroGrid].cdsCoresColunas.FieldByName('index_coluna').IsNull) Then
  Begin
    intIndexCampoFonte := grdGridRelatorioGeral.arrGrid[FNroGrid].cdsCoresColunas.FieldByName('index_coluna').AsInteger;

    If intIndexCampoFonte > -1 Then
    Begin
      strDefFonte := VarToStr(grdGridRelatorioGeral.fcxViewData.Records[intNumRec].Values[intIndexCampoFonte]);

      FDetalhe.strFontName := fGetFontName(strDefFonte);
      strFontStyles := TdtmRelFrx.fRetornaFontStyles(strDefFonte);

      If Pos('fsBold', strFontStyles) > 0 Then
      Begin
        FDetalhe.strFontStylesInicio := '<b>';
        FDetalhe.strFontStylesFinal := '</b>';
      End;

      If Pos('fsItalic', strFontStyles) > 0 Then
      Begin
        FDetalhe.strFontStylesInicio := Concat(FDetalhe.strFontStylesInicio, '<i>');
        FDetalhe.strFontStylesFinal := Concat(FDetalhe.strFontStylesFinal, '</i>');
      End;

      If Pos('fsUnderline', strFontStyles) > 0 Then
      Begin
        FDetalhe.strFontStylesInicio := Concat(FDetalhe.strFontStylesInicio, '<u>');
        FDetalhe.strFontStylesFinal := Concat(FDetalhe.strFontStylesFinal, '</u>');
      End;

      If Pos('fsStrikeOut', strFontStyles) > 0 Then
      Begin
        FDetalhe.strFontStylesInicio := Concat(FDetalhe.strFontStylesInicio, '<s>');
        FDetalhe.strFontStylesFinal := Concat(FDetalhe.strFontStylesFinal, '</s>');
      End;

      If Not strDefFonte.IsEmpty Then
      Begin
        FDetalhe.strColor      := fColorToHtml(TdtmRelFrx.fRetornaFontColor(strDefFonte));
        FDetalhe.strBrushColor := fColorToHtml(TdtmRelFrx.fRetornaBrushColor(strDefFonte));
      End;
    End;

  End;
End;

Function TGeraExcelRelatorio.fGetColorCampoDetalhe: String;
Begin
  If FDetalhe.strColor.IsEmpty Then
    Result := ''
  Else
    Result := Concat('color="', FDetalhe.strColor, '"');
End;

Function TGeraExcelRelatorio.fGetBkColorCampoDetalhe: String;
Begin
  If Not FDetalhe.strBrushColor.IsEmpty Then
    Result := Concat('bgcolor="', FDetalhe.strBrushColor, '"')

  Else If FNaZebra And (Not strCorZebra.IsEmpty) Then
    Result := Concat('bgcolor="', strCorZebra , '"')
  Else
    Result := '';
End;

Procedure TGeraExcelRelatorio.pEscreveCampoLinhaDetalhe(intColumnIndex, intNumRec: Integer; strValor: String);
Begin
  If fGetCdsCampos.FindKey([grdGridRelatorioGeral.fcxFieldNameColumns(intColumnIndex)]) Then
  Begin
    pGetFonteDetalhe(intNumRec);

    pEscreveLinha(Concat('<td height="17" align="',
                 fGetAlinhamento, '" ',
                 fGetBkColorCampoDetalhe,
                 fGetSdvalPelaGrid(intColumnIndex, strValor),
                 fGetSdnum,
                 '>',
                 fGetFontCampoDetalhe,
                 fGetColorCampoDetalhe,
                 '>',
                 fGetValorCampoPelaGrid(strValor),
                 '</font>',
                 FDetalhe.strFontStylesFinal,
                 '</td>'));
  End;
End;

Function TGeraExcelRelatorio.fGetBkColorQuebra(intQuebra: Integer): String;
Begin
  Result := Concat('bgcolor="',  ARR_CORES_QUEBRA[intQuebra], '"');
End;

Function TGeraExcelRelatorio.fGetFontQuebra: String;
Begin
  Result := '<b><font face="Arial"';
End;

Procedure TGeraExcelRelatorio.pEscreveCampoQuebra(intColumnIndex, intQuebra: Integer; strValor: String);
Begin
  If fGetCdsCampos.FindKey([grdGridRelatorioGeral.fcxFieldNameColumns(intColumnIndex)]) Then
    pEscreveLinha(Concat('<td height="20" align="',
                 fGetAlinhamento, '" ',
                 fGetBkColorQuebra(intQuebra),
                 fGetSdvalPelaGrid(intColumnIndex, strValor),
                 fGetSdnum,
                 '>',
                 fGetFontQuebra,
                 fGetColorCampoQuebra,
                 '>',
                 fGetValorCampoPelaGrid(strValor),
                 '</font></b></td>'));
End;

Procedure TGeraExcelRelatorio.pListaTotais(intInicio, intQuebra: Integer);
  Var
    intContaCampos,
    intColunas,
    intContaQuebras,
    intValues,
    intColunaTotal: Integer;
    strValor: String;
Begin
  For intContaQuebras := intInicio DownTo intQuebra Do
  Begin
    If SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '2') Then
    Begin
      pEscreveLinha('<tr>');

      intColunas := 0;

      If Not arrTotais[intContaQuebras].strTitulo.IsEmpty Then
      Begin
        pEscreveLinha(Concat('<td height="20" align="left" bgcolor="', ARR_CORES_QUEBRA[intContaQuebras], '"><b><font face="Arial">',
           arrTotais[intContaQuebras].strTitulo, '</font></b></td>'));
        Inc(intColunas);
      End;

      pEscreveLinha(Concat('<td height="20" align="left" bgcolor="', ARR_CORES_QUEBRA[intContaQuebras], '"><b><font face="Arial">',
        arrTotais[intContaQuebras].strValor, '</font></b></td>'));

      Inc(intColunas);

      For intContaCampos := intColunas To FNroColunas - 1 Do
        pEscreveLinha(Concat('<td align="left" bgcolor="', ARR_CORES_QUEBRA[intContaQuebras], '"><br></td>'));

      pEscreveLinha('</tr>');
    End;

    intColunas := 0;
    intColunaTotal := 0;

    pEscreveLinha('<tr>');

    For intValues := 0 To FColumnIndex.Count - 1 Do
    If fGetCdsCampos.FindKey([grdGridRelatorioGeral.fcxFieldNameColumns(FColumnIndex[intValues].ToInteger)]) Then
    Begin
      If fEmptyStr(fGetCdsCampos.FieldByName('CAM_TOTALI').AsString) Then
      Begin
        pEscreveLinha(Concat('<td height="20" align="left" bgcolor="', ARR_CORES_QUEBRA[intContaQuebras], '"><br></td>'));

      End Else
      Begin
        strValor := fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxDataController.Summary.GroupSummaryValues[arrTotais[intContaQuebras].intLinha, intColunaTotal]));

        pEscreveLinha(Concat('<td height="20" align="',
                     fGetAlinhamento, '" ',
                     fGetBkColorQuebra(intContaQuebras),
                     fGetSdvalPelaGrid(FColumnIndex[intValues].ToInteger, strValor),
                     fGetSdnum,
                     '>',
                     fGetFontQuebra,
                     fGetColorCampoTotal,
                     '>',
                     fGetValorCampoPelaGrid(strValor),
                     '</font></b></td>'));

        Inc(intColunaTotal);
      End;

      Inc(intColunas);
    End;

    For intContaCampos := intColunas To FNroColunas - 1 Do
      pEscreveLinha(Concat('<td align="left" bgcolor="', ARR_CORES_QUEBRA[intContaQuebras], '"><br></td>'));

    pEscreveLinha('</tr>');
  End;

End;

Procedure TGeraExcelRelatorio.pListaTotalGeral;
  Var
    intContaCampos,
    intColunas,
    intValues,
    intColunaTotal,
    intIndexCor: Integer;
    strValor: String;
    View: TcxGridDBTableView;
Begin
  intColunas := 0;
  intColunaTotal := 0;
  intIndexCor := 0;

  If blnTemTotal Then
  Begin
    View := grdGridRelatorioGeral.fcxDataController.GridView as TcxGridDBTableView;

    if View.OptionsView.Footer then
      Inc(intIndexCor); // tem um footer geral

    if Ord(View.OptionsView.GroupFooters) in [1, 2] then
      Inc(intIndexCor, View.DataController.Groups.GroupingItemCount); // footers de cada grupo

    intIndexCor := intIndexCor - IIF(intIndexCor > 0, 1, 0); // pra pegar a posição correta do ARR_CORES_QUEBRA
  End
  Else
    intIndexCor := 0;

  If SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '2') Then
  Begin
    pEscreveLinha('<tr>');

    intColunas := 0;

    pEscreveLinha(Concat('<td height="20" align="left" bgcolor="',
                         ARR_CORES_QUEBRA[intIndexCor], '"><b><font face="Arial">',
                         'Total Geral', '</font></b></td>'));
    Inc(intColunas);

    For intContaCampos := intColunas To FNroColunas - 1 Do
      pEscreveLinha(Concat('<td align="left" bgcolor="',
                  ARR_CORES_QUEBRA[intIndexCor], '"><br></td>'));

    pEscreveLinha('</tr>');
  End;

  pEscreveLinha('<tr>');

  For intValues := 0 To FColumnIndex.Count - 1 Do
  If fGetCdsCampos.FindKey([grdGridRelatorioGeral.fcxFieldNameColumns(FColumnIndex[intValues].ToInteger)]) Then
  Begin
    If fEmptyStr(fGetCdsCampos.FieldByName('CAM_TOTALI').AsString) Then
    Begin
      pEscreveLinha(Concat('<td height="20" align="left" bgcolor="',
                          ARR_CORES_QUEBRA[intIndexCor], '"><br></td>'));
    End Else
    Begin
      strValor := fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxDataController.Summary.FooterSummaryValues[intColunaTotal]));

      pEscreveLinha(Concat('<td height="20" align="',
                   fGetAlinhamento, '" ',
                   fGetBkColorQuebra(intIndexCor),
                   fGetSdvalPelaGrid(FColumnIndex[intValues].ToInteger, strValor),
                   fGetSdnum,
                   '>',
                   fGetFontQuebra,
                   fGetColorCampoTotal,
                   '>',
                   fGetValorCampoPelaGrid(strValor),
                   '</font></b></td>'));

      Inc(intColunaTotal);
    End;

    Inc(intColunas);
  End;

  For intContaCampos := intColunas To FNroColunas - 1 Do
    pEscreveLinha(Concat('<td align="left" bgcolor="',
                 ARR_CORES_QUEBRA[intIndexCor], '"><br></td>'));

  pEscreveLinha('</tr>');
End;

function TGeraExcelRelatorio.fRemoveDesenhoLinha(strLinha: string): string;
begin
  Result := strLinha;
  if Pos('<<LINEUP>>', Result) > 0 then
    Result := AnsiReplaceStr(Result, '<<LINEUP>>', '');
  if Pos('<<LINEDOWN>>', Result) > 0 then
    Result := AnsiReplaceStr(Result, '<<LINEDOWN>>', '');
  if Pos('<<LINELEFT>>', Result) > 0 then
    Result := AnsiReplaceStr(Result, '<<LINELEFT>>', '');
  if Pos('<<LINERIGHT>>', Result) > 0 then
    Result := AnsiReplaceStr(Result, '<<LINERIGHT>>', '');
end;

Function TGeraExcelRelatorio.fProximaLinhaDados(intIndex: Integer): Integer;
  Var
    intContador: Integer;
Begin
  Result := intIndex;
  For intContador := Succ(intIndex) To grdGridRelatorioGeral.fcxViewData.RecordCount - 1 Do
    If grdGridRelatorioGeral.fcxViewData.Records[intContador].IsData Then
    Begin
      Result := intContador;
      Break;
    End;
End;

Procedure TGeraExcelRelatorio.pGeraLinhasDetalhePelaGrid;
  Var
    intLinhaTotal,
    intQuebra: Integer;
    blnTemTotalGeral: Boolean;
    intContador,
    intContaCampos,
    intValues,
    intColunas: Integer;
    blnJaListouData: Boolean;
    strDadosQuebra: String;
Begin
  If Assigned(frmGravando) Then
  Begin
    frmGravando.lblGravando.Caption := 'Listando dados...';
    frmGravando.pgbStatus.Position := 0;
    frmGravando.pgbStatus.Properties.Max := grdGridRelatorioGeral.fcxViewData.RecordCount;
    Application.ProcessMessages;
  End;

  SetLength(arrTotais, Length(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras));

  blnTemTotal := (Length(arrTotais) > 0) And
                  Assigned(grdGridRelatorioGeral.fcxDataController.Summary) And
                  Assigned(grdGridRelatorioGeral.fcxDataController.Summary.DefaultGroupSummaryItems) And
                 (grdGridRelatorioGeral.fcxDataController.Summary.DefaultGroupSummaryItems.Count > 0);

  blnTemTotalGeral := grdGridRelatorioGeral.arrGrid[FNroGrid].fGetFooter;

  If blnTemTotalGeral And
     SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '0') Then
    pListaTotalGeral;

  FNaZebra := False;
  blnJaListouData := False;

  intLinhaTotal := 0;

  For intContador := 0 To grdGridRelatorioGeral.fcxViewData.RecordCount - 1 Do
  Begin
    If grdGridRelatorioGeral.fcxViewData.Records[intContador].IsData Then
    Begin
      blnJaListouData := True;

    	pEscreveLinha('<tr>');

      For intValues := 0 To FColumnIndex.Count - 1 Do
        pEscreveCampoLinhaDetalhe(FColumnIndex[intValues].ToInteger, intContador,
                                  fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxViewData.Records[intContador].Values[FColumnIndex[intValues].ToInteger])));

      pEscreveLinha('</tr>');

      FNaZebra := Not FNaZebra;
    End Else
    Begin
      // TRATA O TOTAL

      intQuebra := grdGridRelatorioGeral.fcxViewData.Records[intContador].Level;

      If blnJaListouData And
         (SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '1') Or
          SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '2')) Then
      Begin
        If blnTemTotal Then
          pListaTotais(High(ArrTotais), intQuebra);

        blnJaListouData := False;
      End;

      // TRATA A QUEBRA
      intColunas := 0;

      arrTotais[intQuebra].strTitulo := grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].strTitulo;
      arrTotais[intQuebra].strValor  := fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxViewData.Records[intContador].Values[TcxCustomGridTableItem(
                                                 grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].cxiColuna).Index]));
      arrTotais[intQuebra].intLinha := intLinhaTotal;

      pEscreveLinha('<tr>');
      pEscreveLinha('<tr>');

      strDadosQuebra := '';

      For intContaCampos := 0 To grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos.Count - 1 Do
      Begin

        If SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TITQUE').AsString, 'S') Then
        Begin
          strDadosQuebra := Concat(strDadosQuebra, ' ',
                                   TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Caption,
                                   IfThen(AnsiEndsStr(':', TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Caption), '', ':'),
                                   ' ',
                                   fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxViewData.Records[fProximaLinhaDados(intContador)].Values[
                       TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Index])),
                                   '   ');
        End Else
        Begin
          pEscreveLinha(Concat('<td height="20" align="left" bgcolor="', ARR_CORES_QUEBRA[intQuebra], '"><b><font face="Arial">',
            TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Caption,
             '</font></b></td>'));
          Inc(intColunas);

          pEscreveCampoQuebra(TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Index,
                            intQuebra,
            fRemoveDesenhoLinha(VarToStr(grdGridRelatorioGeral.fcxViewData.Records[fProximaLinhaDados(intContador)].Values[
              TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[intContaCampos]).Index])));
          Inc(intColunas);
        End;

      End;

      If SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TITQUE').AsString, 'S') Then
      Begin
        pEscreveCampoQuebra(TcxCustomGridTableItem(grdGridRelatorioGeral.arrGrid[FNroGrid].arrQuebras[intQuebra].stlCampos[0]).Index,
                            intQuebra,
                            Trim(strDadosQuebra));
        Inc(intColunas);
      End;

      For intContaCampos := intColunas To FNroColunas - 1 Do
        pEscreveLinha(Concat('<td align="left" bgcolor="', ARR_CORES_QUEBRA[intQuebra], '"><br></td>'));

      pEscreveLinha('</tr>');

      If blnTemTotal And
         SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '0') Then
        pListaTotais(intQuebra, intQuebra);

      FNaZebra := False;

      Inc(intLinhaTotal);
    End;

    If Assigned(frmGravando) Then
    Begin
      frmGravando.pgbStatus.Position := Succ(intContador);
      Application.ProcessMessages;
    End;
  End;

  If (SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '1') Or
     SameText(FGeraFr3.arrCadRel[FNroRel].FieldByName('REL_TOTINI').AsString, '2')) Then
  Begin
    If blnTemTotal Then
      pListaTotais(High(ArrTotais), 0);

    If blnTemTotalGeral Then
      pListaTotalGeral;
  End;

  SetLength(arrTotais, 0);
End;

Procedure TGeraExcelRelatorio.pGeraRelatorioCorrente;
Begin
  fGetCdsCampos.DisableControls;

  fGetCdsCampos.IndexFieldNames := 'CAM_NOMCAM';

  FNroColunas := fGetNumeroColunas;

  If (FNroGrid = Low(grdGridRelatorioGeral.arrGrid)) Or (FNroGrid = FIndexRelatorio) Then
    pEscreveNomeEmpresa;

  pEscreveTituloRelatorio;

  If ((FNroGrid = Low(grdGridRelatorioGeral.arrGrid)) Or (FNroGrid = FIndexRelatorio))
      And (FGeraFr3.arrCadRel[0].FieldByName('REL_FILPRI').AsString <> 'X') Then
    pEscreveFiltros;

  pEscreveTituloCamposPelaGrid;
  pGeraLinhasDetalhePelaGrid;

  fGetCdsCampos.EnableControls;
End;

Function TGeraExcelRelatorio.fGeraExcel(AIndexRelatorio: Integer = -1): Boolean;
  Var
    intContador: Integer;
Begin
  Try
    If Assigned(frmGravando) Then
    Begin
      frmGravando.pgbStatus.Visible := True;
      Application.ProcessMessages;
    End;

    Result := False;

    If Not Assigned(grdGridRelatorioGeral) Then
      Exit;

    FIndexRelatorio := AIndexRelatorio;

    FArquivo.Clear;

    FGravaDireto := FGeraFr3.arrCadRel[0].FieldByName('REL_GRADIR').AsString = 'S';

    If Not FArquivoAberto.IsEmpty Then
    Begin
      Close(FTextFile);
      FArquivoAberto := '';
    End;

    If FGravaDireto Then
    Begin
      Result := fAbreArquivo(FNomeArquivo);

      If Not Result Then
        Exit;
    End;

    pIniciaHTML(FArquivo);

    FPosLargura := FArquivo.Count;

    FGeraFR3.pCarregaTitulosRelatorio;

    For intContador := Low(grdGridRelatorioGeral.arrGrid) To High(grdGridRelatorioGeral.arrGrid) Do
    If grdGridRelatorioGeral.arrGrid[intContador].blnMontouGrid And
      ((FIndexRelatorio = -1) Or (FIndexRelatorio = intContador)) Then
    Begin
      FNroGrid := intContador;
      grdGridRelatorioGeral.intNroGrid := intContador;
      FNroRel := grdGridRelatorioGeral.arrGrid[intContador].intIndexRelatorio;
      pGeraRelatorioCorrente;
    End;

    pFinalizaHTML(FArquivo);

    If Assigned(frmGravando) Then
    Begin
      frmGravando.lblGravando.Caption := 'Salvando arquivo...';
      Application.ProcessMessages;
    End;

    If FGravaDireto Then
    Begin
      If Not FArquivoAberto.IsEmpty Then
      Begin
        Flush(FTextFile);
        Close(FTextFile);
        FArquivoAberto := '';
      End;
    End Else
    Begin
      FArquivo.SaveToFile(FNomeArquivo);
    End;

    pSaveFile(FNomeArquivo, frmGravando);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraExcelRelatorio.fGeraExcel]');
    End;
  End;
End;

Procedure TGeraExcelRelatorio.pSetNomeArquivo(value: String);
Begin
  FNomeArquivo := ChangeFileExt(Value, '.xls');
end;

end.
