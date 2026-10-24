unit untExportaGridExcel;

interface

uses
  SysUtils, Windows, Classes, Menus, Uni, DB, StrUtils, Forms,
  CxProgressBar, cxGridDBBandedTableView,cxGridDBDataDefinitions,
  untGravando, cxGridBandedTableView, cxGridTableView, cxGridDBTableView,
  untGeraExcelRelatorio;

Type
  TExportaGridExcel = class(TComponent)
    Private
      FArquivo: TStringList;
      FNroColunas,
      FPosLargura: Integer;

      FDetalhe: TDetalhe;

      FTemFooter,
      FNaZebra: Boolean;

      frmGravando: TfrmGravando;

      FNomeArquivo: String;

      FColumnIndex: TStringList;

      FView: TcxGridDBTableView;
      FBandedView: TcxGridDBBandedTableView;

      FDataSet: TDataset;

      FViewData: TcxGridViewData;

      Function fcxColumns(intIndex: Integer): TcxGridColumn;

      Function fcxFieldName(intIndex: Integer): String;

      Function fcxDataController: TcxGridDBDataController;

      Function fColumnCount: Integer;

      Function fGetAlinhamento(intColumnIndex: Integer): String;

      Procedure pMontaCabecalhoGrid;
      Procedure pMontaLinhasGrid(cxProgresso: TcxProgressBar);

      Procedure pGetFonteDetalhe(intNumRec: Integer);
      Procedure pEscreveCampoLinhaDetalhe(intColumnIndex, intNumRec: Integer; strValor: String);
      Function fGetBkColorCampoDetalhe: String;
      Function fGetSdnum(intColumnIndex: Integer): String;
      Function fGetFontCampoDetalhe: String;
      Function fGetColorCampoDetalhe: String;
      Function fGetValorCampoPelaGrid(strValor: String; intColumnIndex: Integer): String;
      Function fGetFontQuebra: String;
      Function fGetColorCampoTotal: String;
      Function fGetBkColorQuebra(intQuebra: Integer): String;

      Function fExportaPrg(cxProgresso: TcxProgressBar): Boolean;

      Function fGetSdvalPelaGrid(intColumnIndex: Integer; strValor: String): String;

      Function fPedeArquivo: Boolean;

      Procedure pInicializaDados;

      Procedure pMontaFooter;

      procedure pInsereLarguraColuna(FArquivo: TStringList; Var FPosLargura: Integer; intPixels: Integer);
      procedure pEscreveTituloCampo(FArquivo: TStringList; strTitulo, strAlinhamento: String);
      procedure pIniciaHTML(FArquivo: TStringList);
      procedure pFinalizaHTML(FArquivo: TStringList);
      procedure pSaveFile(ANomeArquivo: String; frmGravando: TfrmGravando);

    public
      strCorZebra: String;

      constructor Create(Owner: TComponent; cxView: TcxGridDBBandedTableView); Reintroduce; Overload;

      constructor Create(Owner: TComponent; cxView: TcxGridDBTableView); Reintroduce; Overload;

      Destructor Destroy; override;

      Function fExporta: Boolean;

  End;

implementation

Uses
  System.Variants,
  Vcl.Dialogs,
  cxCustomData,
  untExcel,
  untFuncoesSimples;

constructor TExportaGridExcel.Create(Owner: TComponent; cxView: TcxGridDBBandedTableView);
Begin
  Inherited Create(Owner);

  pInicializaDados;

  FBandedView := cxView;
  FViewData   := cxView.ViewData;
  FDataSet    := cxView.DataController.DataSource.DataSet;

  FTemFooter := cxView.OptionsView.Footer;
End;

constructor TExportaGridExcel.Create(Owner: TComponent; cxView: TcxGridDBTableView);
Begin
  Inherited Create(Owner);

  pInicializaDados;

  FView     := cxView;
  FViewData := cxView.ViewData;
  FDataSet  := cxView.DataController.DataSource.DataSet;

  FTemFooter := cxView.OptionsView.Footer;
End;

Destructor TExportaGridExcel.Destroy;
Begin
  Inherited;

  FreeAndNil(FArquivo);
  FreeAndNil(FColumnIndex);
End;

procedure TExportaGridExcel.pInsereLarguraColuna(FArquivo: TStringList; Var FPosLargura: Integer; intPixels: Integer);
Begin
  FArquivo.Insert(FPosLargura, Concat('	<colgroup width="', intPixels.ToString, '"></colgroup>'));
  Inc(FPosLargura);
End;

procedure TExportaGridExcel.pEscreveTituloCampo(FArquivo: TStringList; strTitulo, strAlinhamento: String);
Begin
	FArquivo.Add(Concat('<td height="20" align="', strAlinhamento,
   '" bgcolor="#000000"><b><font face="Courier New" color="#FFFFFF">', strTitulo, '</font></b></td>'));
End;

procedure TExportaGridExcel.pIniciaHTML(FArquivo: TStringList);
begin
	FArquivo.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');

	FArquivo.Add('<html>');
	FArquivo.Add('<head>');

	FArquivo.Add('	<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>');
	FArquivo.Add('	<title></title>');
	FArquivo.Add('	<meta name="generator" content="LibreOffice 6.4.7.2 (Windows)"/>');
	FArquivo.Add('	<meta name="created" content="00:00:00"/>');
	FArquivo.Add('	<meta name="changed" content="' + FormatDateTime('YYYY-MM-DD', VS_Date) + 'T' + FormatDateTime('HH:NN:SS', fTime()) + '.495000000"/>');

	FArquivo.Add('	<style type="text/css">');
	FArquivo.Add('		body,div,table,thead,tbody,tfoot,tr,th,td,p { font-family:"Arial"; font-size:x-small }');
	FArquivo.Add('		a.comment-indicator:hover + comment { background:#ffd; position:absolute; display:block; border:1px solid black; padding:0.5em;  }');
	FArquivo.Add('		a.comment-indicator { background:red; display:inline-block; border:1px solid black; width:0.5em; height:0.5em;  }');
	FArquivo.Add('		comment { display:none;  }');
	FArquivo.Add('	</style>');

	FArquivo.Add('</head>');

	FArquivo.Add('<body>');
	FArquivo.Add('<table cellspacing="0" border="0">');
end;

procedure TExportaGridExcel.pFinalizaHTML(FArquivo: TStringList);
begin
  FArquivo.Add('</table>');
  FArquivo.Add('</body>');
  FArquivo.Add('</html>');
End;

procedure TExportaGridExcel.pSaveFile(ANomeArquivo: String; frmGravando: TfrmGravando);
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
  FExcel.SalvarArquivo(True);
  FExcel.FecharArquivo;

  FExcel.AbrirArquivo(ChangeFileExt(ANomeArquivo, '.xls'));
  FExcel.AutoAjuste;
  FExcel.SalvarArquivo(True);
  FExcel.FecharArquivo;

  FreeAndNil(FExcel);
End;

Procedure TExportaGridExcel.pInicializaDados;
Begin
  strCorZebra := COR_ZEBRA;
  FArquivo := TStringList.Create;
  FColumnIndex := TStringList.Create;
End;

Function TExportaGridExcel.fExporta: Boolean;
Begin
  Result := fPedeArquivo And
            TfrmGravando.fExecuta(fExportaPrg, frmGravando, 'Gerando arquivo, aguarde...');

  If Result Then
    pMensagemOk('Arquivo gerado com sucesso!');
End;

Function TExportaGridExcel.fPedeArquivo: Boolean;
  Var
    savPedeArquivo: TSaveDialog;
Begin
  Result := False;
  FNomeArquivo := '';

  savPedeArquivo := TSaveDialog.Create(Self);
  savPedeArquivo.Filter     := 'Arquivos do Excel|*.xls;*.xlsx';
  savPedeArquivo.DefaultExt := 'xls';

  If savPedeArquivo.Execute Then
  Begin
    Result := True;
    FNomeArquivo := savPedeArquivo.FileName;
  End;

  FreeAndNil(savPedeArquivo);
End;

Function TExportaGridExcel.fColumnCount: Integer;
Begin
  If Assigned(FView) Then
    Result := FView.ColumnCount
  Else
    Result := FBandedView.ColumnCount
End;

Function TExportaGridExcel.fcxColumns(intIndex: Integer): TcxGridColumn;
Begin
  If Assigned(FView) Then
    Result := FView.Columns[intIndex]
  Else
    Result := FBandedView.Columns[intIndex];
End;

Function TExportaGridExcel.fcxFieldName(intIndex: Integer): String;
Begin
  If Assigned(FView) Then
    Result := FView.Columns[intIndex].DataBinding.FieldName
  Else
    Result := FBandedView.Columns[intIndex].DataBinding.FieldName;
End;

Function TExportaGridExcel.fcxDataController: TcxGridDBDataController;
Begin
  If Assigned(FView) Then
    Result := FView.DataController
  Else
    Result := FBandedView.DataController;
End;

Procedure TExportaGridExcel.pMontaCabecalhoGrid;
  Var
    intContador: Integer;
    strTitulo: String;
Begin
  FNroColunas := 0;
  FColumnIndex.Clear;

	FArquivo.Add('<tr>');

  For intContador := 0 To fColumnCount -1 Do
  If fcxColumns(intContador).Visible Then
  Begin
    Inc(FNroColunas);

    pInsereLarguraColuna(FArquivo, FPosLargura, fcxColumns(intContador).Width);

    If fcxColumns(intContador).AlternateCaption.IsEmpty Then
      strTitulo := fcxColumns(intContador).Caption
    Else
      strTitulo := fcxColumns(intContador).AlternateCaption;

    pInsereLarguraColuna(FArquivo, FPosLargura, fcxColumns(intContador).Width);
    pEscreveTituloCampo(FArquivo, strTitulo, fGetAlinhamento(fcxColumns(intContador).Index));

    FColumnIndex.Add(fcxColumns(intContador).Index.ToString());
  End;

	FArquivo.Add('	</tr>');
End;

Procedure TExportaGridExcel.pGetFonteDetalhe(intNumRec: Integer);
Begin
  Fillchar(FDetalhe, SizeOf(FDetalhe), #0);
  FDetalhe.strFontName := 'Arial';
End;

Function TExportaGridExcel.fGetBkColorCampoDetalhe: String;
Begin
  If Not FDetalhe.strBrushColor.IsEmpty Then
    Result := Concat('bgcolor="', FDetalhe.strBrushColor, '"')

  Else If FNaZebra And (Not strCorZebra.IsEmpty) Then
    Result := Concat('bgcolor="', strCorZebra , '"')
  Else
    Result := '';
End;

Function TExportaGridExcel.fGetAlinhamento(intColumnIndex: Integer): String;
Begin
  Case FDataSet.FieldByName(fcxFieldName(intColumnIndex)).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint,
    ftCurrency,
    ftFloat  :  Result := 'right';

    ftDate,
    ftDateTime: Result := 'center';

    Else        Result := 'left';
  End;
End;

Function TExportaGridExcel.fGetSdvalPelaGrid(intColumnIndex: Integer; strValor: String): String;
Begin
  Result := '';

  Case FDataSet.FieldByName(fcxFieldName(intColumnIndex)).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftCurrency,
    ftFloat,
    ftLargeint: Result := Concat('sdval="', ReplaceStr(strValor, '.', ',') , '" ');

   (* ftString: Case TInterfaceRelatorio.fDescMascaraToTipo(fGetCdsCampos.FieldByName('CAM_MASCAR').AsString) Of
                masCNPJ,
                masContabil,
                masTelefone,
                masCEP,
                masPlacaVeiculo,
                masPlanoContabil,
                masCondPagto:  Result := Concat('sdval="', strValor, '" ');
              End; *)
  End;
End;

Function TExportaGridExcel.fGetSdnum(intColumnIndex: Integer): String;
Begin
  Result := '';

  Case FDataSet.FieldByName(fcxFieldName(intColumnIndex)).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint: Result := Concat('sdnum="1046;0;', fMskDigitos(0), '"');

    ftCurrency,
    ftFloat: Result := Concat('sdnum="1046;0;', fMskDigitos(2), '"');

    ftDate: Result := 'sdnum="1046;0;DD/MM/AA"';

    ftString: Result := 'sdnum="1046;0;@"';
  End;
End;

Function TExportaGridExcel.fGetFontCampoDetalhe: String;
Begin
  Result := Concat(FDetalhe.strFontStylesInicio, '<font face="', FDetalhe.strFontName, '"');
End;

Function TExportaGridExcel.fGetColorCampoDetalhe: String;
Begin
  If FDetalhe.strColor.IsEmpty Then
    Result := ''
  Else
    Result := Concat('color="', FDetalhe.strColor, '"');
End;

Function TExportaGridExcel.fGetValorCampoPelaGrid(strValor: String; intColumnIndex: Integer): String;
Begin
  Case FDataSet.FieldByName(fcxFieldName(intColumnIndex)).DataType Of
    ftSmallint,
    ftInteger,
    ftWord,
    ftLargeint: Result := strValor;

    ftCurrency,
    ftFloat  : Result := AnsiReplaceStr(strValor, '.', ',');

    (*
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
              End; *)

    Else Result := strValor;
  End;

  Result := Trim(Result);
End;

Procedure TExportaGridExcel.pEscreveCampoLinhaDetalhe(intColumnIndex, intNumRec: Integer; strValor: String);
Begin
  pGetFonteDetalhe(intNumRec);

  FArquivo.Add(Concat('<td height="17" align="',
               fGetAlinhamento(intColumnIndex), '" ',
               fGetBkColorCampoDetalhe,
               fGetSdvalPelaGrid(intColumnIndex, strValor),
               fGetSdnum(intColumnIndex),
               '>',
               fGetFontCampoDetalhe,
               fGetColorCampoDetalhe,
               '>',
               fGetValorCampoPelaGrid(strValor, intColumnIndex),
               '</font>',
               FDetalhe.strFontStylesFinal,
               '</td>'));
End;

Procedure TExportaGridExcel.pMontaLinhasGrid(cxProgresso: TcxProgressBar);
  Var
    intContador,
    intValues: Integer;
Begin
  If Assigned(frmGravando) Then
  Begin
    frmGravando.lblGravando.Caption := 'Listando dados...';
    frmGravando.pgbStatus.Position := 0;
    frmGravando.pgbStatus.Properties.Max := FViewData.RecordCount;
    Application.ProcessMessages;
  End;

  FNaZebra := False;

  For intContador := 0 To FViewData.RecordCount - 1 Do
  Begin

    If FViewData.Records[intContador].IsData Then
    Begin

    	FArquivo.Add('<tr>');

      For intValues := 0 To FColumnIndex.Count - 1 Do
        pEscreveCampoLinhaDetalhe(FColumnIndex[intValues].ToInteger, intContador,
                                  VarToStr(FViewData.Records[intContador].Values[FColumnIndex[intValues].ToInteger]));

      FArquivo.Add('</tr>');

      FNaZebra := Not FNaZebra;
    End;

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;
End;

Function TExportaGridExcel.fGetFontQuebra: String;
Begin
  Result := '<b><font face="Arial"';
End;

Function TExportaGridExcel.fGetColorCampoTotal: String;
Begin
  Result := '';
End;

Function TExportaGridExcel.fGetBkColorQuebra(intQuebra: Integer): String;
Begin
  Result := Concat('bgcolor="',  ARR_CORES_QUEBRA[intQuebra], '"');
End;

Procedure TExportaGridExcel.pMontaFooter;
  Var
    intColunaTotal,
    intValues: Integer;
    strValor: String;
Begin
 	FArquivo.Add('<tr>');

  intColunaTotal := 0;

  For intValues := 0 To FColumnIndex.Count - 1 Do
    If fcxColumns(FColumnIndex[intValues].ToInteger).Summary.FooterKind = skNone Then
    Begin
      FArquivo.Add(Concat('<td height="20" align="left" bgcolor="', ARR_CORES_QUEBRA[0], '"><br></td>'));
    End Else
    Begin
      strValor := '';

      strValor := VarToStr(fcxDataController.Summary.FooterSummaryValues[intColunaTotal]);

      FArquivo.Add(Concat('<td height="20" align="',
                   fGetAlinhamento(FColumnIndex[intValues].ToInteger), '" ',
                   fGetBkColorQuebra(0),
                   fGetSdvalPelaGrid(FColumnIndex[intValues].ToInteger, strValor),
                   fGetSdnum(FColumnIndex[intValues].ToInteger),
                   '>',
                   fGetFontQuebra,
                   fGetColorCampoTotal,
                   '>',
                   fGetValorCampoPelaGrid(strValor, FColumnIndex[intValues].ToInteger),
                   '</font></b></td>'));

      Inc(intColunaTotal);
    End;

  For intValues := 0 To FColumnIndex.Count - 1 Do
    FArquivo.Add(Concat('<td align="left" bgcolor="', ARR_CORES_QUEBRA[0], '"><br></td>'));

  FArquivo.Add('</tr>');
End;

Function TExportaGridExcel.fExportaPrg(cxProgresso: TcxProgressBar): Boolean;
Begin
  Try
    cxProgresso.Properties.Max := FViewData.RecordCount;

    FArquivo.Clear;

    pIniciaHTML(FArquivo);

    FPosLargura := FArquivo.Count;

    pMontaCabecalhoGrid;

    pMontaLinhasGrid(cxProgresso);

    If FTemFooter Then
      pMontaFooter;

    pFinalizaHTML(FArquivo);

    frmGravando.lblGravando.Caption := 'Salvando arquivo, aguarde...';
    Application.ProcessMessages;

    FArquivo.SaveToFile(FNomeArquivo);

    pSaveFile(FNomeArquivo, frmGravando);

    Result := True;
  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TExportaGridCSV.fExportaPrg');
    End;

  End;

End;

end.
