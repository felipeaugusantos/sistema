unit untGraficosDashboard;

interface

uses
  SysUtils,
  Classes,
  Uni,
  Json,
  untZClient,
  untFuncEditorRel,
  untGeraFr3,
  IdComponent,
  IdExceptionCore,
  IdStack;

Type
  TGraficosDashboard = class(TObject)
  private

    FNumeroSeries: Integer;

    FJArrPainel: TJSONArray;

    FArrElements: Array Of TJSONArray;

    FarrRows: Array Of TJSONObject;

    FarrNroRow: Array Of Record
                           intNroLin: Integer;
                           strPropor: String[40];
                         End;

    Function fGetNumeroLinhas: Integer;
    Procedure pInicializaRows;

    Function fGetTipoGrafico(intNroRel: Integer): String;

    Function fGetLabelsGrid(intNroRel: Integer): TJSONArray;
    Function fGetLabelsVelocimetro(intNroRel: Integer): TJSONArray;
    Function fGetLabelsGenerico(intNroRel: Integer): TJSONArray;
    Function fGetLabels(intNroRel: Integer): TJSONArray;
    Function fGetGrupos(intNroRel: Integer): TJSONArray;

    Procedure pAdicionaValor(jarData: TJSONArray; intNroRel: Integer);

    Procedure pMontaValue(intNroRel: Integer; jsnGrafico: TJSONObject);

    Function fGetDataSetsGrid(intNroRel: Integer): TJSONObject;
    Function fGetDataSetsVelocimetro(intNroRel: Integer): TJSONArray;
    Function fGetDataSetsGenerico(intNroRel: Integer): TJSONArray;

    Procedure pGeraTotalize(jsnGrafico: TJSONObject; intNroRel: Integer);

    Function fGetCdsCampos(intNroRel: Integer): TZClient;

    procedure OnWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);

    Function fGetURL: String;
    Function fSetaCSS(strId, strCSS: String): Boolean;
    Function fGetCSS: String;
    Function fRetId(strId: String): String;

    Function fGetTotalCampoInteger(intIndexTotal: Integer): Integer;
    Function fGetTotalCampoDouble(intIndexTotal: Integer): Double;

    Function fGetColumns(strPropor: String): String;

    Procedure pValidaVisibilidade(intNroRel: Integer);

    Function fExisteQuebra(intNroRel: Integer): Boolean;
    Function fExisteGrupos(intNroRel: Integer): Boolean;

    Function fGetUTC(dt: TDateTime): TDateTime;
    Function fRetornaTimeStampEmMilisegundos: Int64;
    Function fRetornaChaveBasic(AClientID, AClientSecret: String): String;
    Function fGetMD5(const strTexto: String): String;
    Function fGetAuthorization: String;

  public
    strJSon: String;

    objGeraFr3: TGeraFR3;
    arrCadRel: TArrQuery;
    arrDados: TArrDataSet;
    cdsColunasPorLinha: TZClient;
    desDestino: TDestinoRel;

    destructor Destroy; override;

    Function fMontaGrafico: Boolean;

    Procedure pMostraGrafico;

    property strUrlGrafico: String Read fGetURL;
  End;


implementation

Uses
  Math,
  untFuncoesSimples,
  untInterfaceRelatorio,
  untRelatorio,
  untMostraDashboard,
  StrUtils,
  DB,
  idHTTP, IdBaseComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  idAntiFreeze, System.Generics.Collections, DateUtils,
  WinAPI.Windows, IdCoder, IdCoder3to4, IdCoderMIME,

  Winapi.Messages, System.Variants,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.OleCtrls, SHDocVw,
  Vcl.ComCtrls, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls, REST.Types, System.NetEncoding,
  IdHashMessageDigest, Winapi.ShellAPI, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser;


const
  API_URL = 'https://dashboard.citelsoftware.com.br';
  API_KEY = 'uLtr@-F!n&320147';

destructor  TGraficosDashboard.Destroy;
Begin
  SetLength(FarrRows, 0);
  SetLength(FArrElements, 0);
  SetLength(FarrNroRow, 0);
End;

Function TGraficosDashboard.fGetNumeroLinhas: Integer;
Begin
  If Length(arrCadRel) > 0 Then
    Result := arrCadRel[0].FieldByName('REL_LINGRA').AsInteger
  Else
    Result := 1;

  If Result = 0 Then
    Result := 1;

  Result := Min(Result, Length(arrCadRel));
End;

Procedure TGraficosDashboard.pInicializaRows;
  Var
    intContador,
    intNroRow: Integer;
Begin
  SetLength(FarrRows, Succ(fGetNumeroLinhas));

  For intContador := Low(FarrRows) To High(FarrRows) Do
    FarrRows[intContador] := Nil;

  SetLength(FarrNroRow, Length(arrCadRel));
  For intContador := Low(FarrNroRow) To High(FarrNroRow) Do
  Begin
    FarrNroRow[intContador].intNroLin := 1;
    FarrNroRow[intContador].strPropor := '';
  End;

  intNroRow := 0;

  cdsColunasPorLinha.First;
  While Not cdsColunasPorLinha.Eof Do
  Begin

    For intContador := 1 To cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger Do
    Begin
      If intNroRow <= High(FarrNroRow) Then
      Begin
        FarrNroRow[intNroRow].intNroLin := cdsColunasPorLinha.FieldByName('NROLIN').AsInteger;
        FarrNroRow[intNroRow].strPropor := ShortString(cdsColunasPorLinha.FieldByName('DEFPRO').AsString);
        Inc(intNroRow);
      End

      Else Break;
    End;

    cdsColunasPorLinha.Next;
  End;

  SetLength(FArrElements, fGetNumeroLinhas);
  For intContador := Low(FArrElements) To High(FArrElements) Do
    FArrElements[intContador] := Nil;
End;

Function TGraficosDashboard.fGetTipoGrafico(intNroRel: Integer): String;
  Var
    desRelatorio: TDestinoRel;
Begin
  If Length(arrCadRel) = 0 Then
    desRelatorio := desDestino
  Else
    desRelatorio := TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intNroRel].FieldByName('REL_DESTIN').AsString);

  Case desRelatorio Of
    desCardDashboard              : Result := 'card';
    desGridDashboard              : Result := 'table';
    desGraficoLinhaDashboard      : Result := 'line';

    desGraficoBarrasDashboard,
    desGraficoBarrasEmpilhadasDashboard: Result := 'bar';

    desGraficoTortaDashboard      : Result := 'pie';
    desGraficoVelocimetroDashboard: Result := 'velocimetro';

    desGraficoColunasDashboard,
    desGraficoColunasEmpilhadasDashboard: Result := 'column';

    desGraficoAreaDashboard,
    desGraficoAreaEmpilhadoDashboard: Result := 'area';

    Else                            Result := 'bar';
  End;
End;

function TGraficosDashboard.fExisteGrupos(intNroRel: Integer): Boolean;
var
  strFiltro: String;
begin
  Result := False;

  strFiltro := '';
  strFiltro := strFiltro + 'CAM_TIPGRA = ' + IntToStr(INT_SERIE) + ' AND ';
  strFiltro := strFiltro + 'VISIVEL = 1 AND ';
  strFiltro := strFiltro + 'CAM_LISQUE = ' + QuotedStr('') + ' AND ';
  strFiltro := strFiltro + 'CAM_CODGRU <> ' + QuotedStr('') ;

  fGetCdsCampos(intNroRel).Filter   := strFiltro;
  fGetCdsCampos(intNroRel).Filtered := True;

  If(fGetCdsCampos(intNroRel).RecordCount > 0) then
    Result := True;

  fGetCdsCampos(intNroRel).Filtered := False;
end;

function TGraficosDashboard.fExisteQuebra(intNroRel: Integer): Boolean;
var
  strFiltro : String;
begin
  Result := False;

  strFiltro := '';
  strFiltro := strFiltro + 'CAM_TIPGRA = ' + IntToStr(INT_SERIE) + ' AND ';
  strFiltro := strFiltro + 'VISIVEL = 1 AND ';
  strFiltro := strFiltro + 'CAM_LISTAR = ' + QuotedStr('') + ' AND ' ;
  strFiltro := strFiltro + 'CAM_LISQUE <> ' + QuotedStr('') + ' ' ;

  fGetCdsCampos(intNroRel).Filter   := strFiltro;
  fGetCdsCampos(intNroRel).Filtered := True;

  if (fGetCdsCampos(intNroRel).RecordCount > 0) then
    Result := True;

  fGetCdsCampos(intNroRel).Filtered := False;
end;

Function TGraficosDashboard.fGetCdsCampos(intNroRel: Integer): TZClient;
begin
  If intNroRel = 0 Then
    Result := objGeraFr3.cdsCamposG
  Else
    Result := TRelatorio(objGeraFr3.arrSalvaComplementos[Pred(intNroRel)]).objInterface.cdsCampos;
End;

Function TGraficosDashboard.fGetLabels(intNroRel: Integer): TJSONArray;
Begin
  Case TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intNroRel].FieldByName('REL_DESTIN').AsString) Of
    desGridDashboard              : Result := fGetLabelsGrid(intNroRel);
    desGraficoVelocimetroDashboard: Result := fGetLabelsVelocimetro(intNroRel);
    Else                            Result := fGetLabelsGenerico(intNroRel);
  End;
End;

Function TGraficosDashboard.fGetLabelsGenerico(intNroRel: Integer): TJSONArray;
  Var
    strCamLab: String;
Begin
  result := TJSONArray.Create;

  If fGetCdsCampos(intNroRel).Locate('CAM_TIPGRA;VISIVEL', VarArrayOf([INT_LEGENDA, 1]), []) Then
    strCamLab := fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString
  Else
    Exit;

  arrDados[intNroRel].First;

  While Not arrDados[intNroRel].Eof Do
  Begin
    result.Add(arrDados[intNroRel].FieldByName(strCamLab).AsString);

    arrDados[intNroRel].Next;
  End;

End;

Function TGraficosDashboard.fGetLabelsGrid(intNroRel: Integer): TJSONArray;
Begin
  result := TJSONArray.Create;

  If (fExisteQuebra(intNroRel)) then
    result.Add('Quebra');

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1 AND CAM_LISQUE = ', QuotedStr(''));
  fGetCdsCampos(intNroRel).Filtered := True;

  fGetCdsCampos(intNroRel).First;

  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    result.Add(objGeraFR3.fDescricaoCampo(fGetCdsCampos(intNroRel).FieldByName('CAM_DESCAM').AsString));
    fGetCdsCampos(intNroRel).Next;
  End;

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetGrupos(intNroRel: Integer): TJSONArray;
Begin
  result := TJSONArray.Create;

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1 AND CAM_LISQUE = ', QuotedStr(''));
  fGetCdsCampos(intNroRel).Filtered := True;

  fGetCdsCampos(intNroRel).First;

  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    result.Add(objGeraFr3.fRetNomeGrupo(fGetCdsCampos(intNroRel).FieldByName('CAM_CODGRU').AsString));
    fGetCdsCampos(intNroRel).Next;
  End;

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetLabelsVelocimetro(intNroRel: Integer): TJSONArray;
Begin
  result := TJSONArray.Create;

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');
  fGetCdsCampos(intNroRel).Filtered := True;

  fGetCdsCampos(intNroRel).First;

  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    result.Add(objGeraFR3.fDescricaoCampo(fGetCdsCampos(intNroRel).FieldByName('CAM_DESCAM').AsString));
    fGetCdsCampos(intNroRel).Next;
  End;

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Procedure TGraficosDashboard.pAdicionaValor(jarData: TJSONArray; intNroRel: Integer);
Begin
  Case arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).DataType Of
    ftLargeint,
    DB.ftInteger,
    ftWord    : jarData.Add(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsInteger);
    ftFloat   : jarData.Add(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsFloat);
    Else        jarData.Add(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsString);
  End;
End;

Function TGraficosDashboard.fGetDataSetsVelocimetro(intNroRel: Integer): TJSONArray;
  Var
    jsnSerie: TJSONObject;
    jarData: TJSONArray;
Begin
  result := TJSONArray.Create;

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');
  fGetCdsCampos(intNroRel).Filtered := True;

  jsnSerie := TJSONObject.Create;
  jsnSerie.AddPair('label', TJSONString.Create(''));
  jarData := TJSONArray.Create;

  fGetCdsCampos(intNroRel).First;
  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    pAdicionaValor(jarData, intNroRel);

    fGetCdsCampos(intNroRel).Next;
  End;

  jsnSerie.AddPair('data', jarData);
  result.AddElement(jsnSerie);

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetDataSetsGrid(intNroRel: Integer): TJSONObject;
  Var
    jarData,
    jarLinha,
    jarCores,
    jarCor: TJSONArray;
    strQuebra: String;
Begin
  result := TJSONObject.Create;
  strQuebra := '';

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');
  fGetCdsCampos(intNroRel).Filtered := True;
  fGetCdsCampos(intNroRel).IndexFieldNames := 'CAM_LISTAR;CAM_POSICA';

  result.AddPair('label', TJSONString.Create(''));

  jarData := TJSONArray.Create;
  jarCores := TJSONArray.Create;

  arrDados[intNroRel].First;

  While Not arrDados[intNroRel].Eof Do
  Begin
    jarLinha := TJSONArray.Create;
    jarCor := TJSONArray.Create;

    fGetCdsCampos(intNroRel).First;
    While Not fGetCdsCampos(intNroRel).Eof Do
    Begin
      if (fGetCdsCampos(intNroRel).FieldByName('CAM_LISTAR').AsString = '') And
          (fGetCdsCampos(intNroRel).FieldByName('CAM_LISQUE').AsString <> '') then
      begin
        if (fGetCdsCampos(intNroRel).FieldByName('CAM_DESCAM').AsString <> '') then
          strQuebra := strQuebra + fGetCdsCampos(intNroRel).FieldByName('CAM_DESCAM').AsString + ': ';

        strQuebra := strQuebra + arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsString + ' ';
      end
      else
      begin
        if (strQuebra <> '') then
        begin
          jarLinha.Add(strQuebra);
          strQuebra := '';
        end;

        if (fGetCdsCampos(intNroRel).FieldByName('CAM_DEFFON').AsString <> '') then
          jarCor.Add(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_DEFFON').AsString).AsString)
        else
          jarCor.Add('');

        pAdicionaValor(jarLinha, intNroRel);
      end;

      fGetCdsCampos(intNroRel).Next;
    End;

    jarData.AddElement(jarLinha);
    jarCores.AddElement(jarCor);

    arrDados[intNroRel].Next;
  End;

  result.AddPair('data', jarData);
  result.AddPair('colorCells', jarCores);

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Procedure TGraficosDashboard.pMontaValue(intNroRel: Integer; jsnGrafico: TJSONObject);
Begin
  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');
  fGetCdsCampos(intNroRel).Filtered := True;

  arrDados[intNroRel].First;

  Case arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).DataType Of
    ftLargeint,
    DB.ftInteger,
    ftWord    : jsnGrafico.AddPair('value', TJSONNumber.Create(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsInteger));
    ftFloat   : jsnGrafico.AddPair('value', TJSONNumber.Create(arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsFloat));
    Else        jsnGrafico.AddPair('value', arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).AsString);
  End;

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetDataSetsGenerico(intNroRel: Integer): TJSONArray;
  Var
    strNomeSerie: String;
    jsnSerie: TJSONObject;
    jarData: TJSONArray;
Begin
  result := TJSONArray.Create;

  fGetCdsCampos(intNroRel).Filter   := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');
  fGetCdsCampos(intNroRel).Filtered := True;

  FNumeroSeries := fGetCdsCampos(intNroRel).RecordCount;

  fGetCdsCampos(intNroRel).First;
  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    jsnSerie := TJSONObject.Create;

    If FNumeroSeries > 1 Then
      strNomeSerie := objGeraFR3.fDescricaoCampo(fGetCdsCampos(intNroRel).FieldByName('CAM_DESCAM').AsString)
    Else
      strNomeSerie := '';

    jsnSerie.AddPair('label', TJSONString.Create(strNomeSerie));

    jarData := TJSONArray.Create;

    arrDados[intNroRel].First;

    While Not arrDados[intNroRel].Eof Do
    Begin
      pAdicionaValor(jarData, intNroRel);

      arrDados[intNroRel].Next;
    End;

    jsnSerie.AddPair('data', jarData);

    result.AddElement(jsnSerie);

    fGetCdsCampos(intNroRel).Next;
  End;

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetTotalCampoInteger(intIndexTotal: Integer): Integer;
Begin
  Result := 0;

  If intIndexTotal < Length(objGeraFr3.ArrTotaisRodape) Then
    Result := Trunc(objGeraFr3.ArrTotaisRodape[intIndexTotal]);
End;

Function TGraficosDashboard.fGetTotalCampoDouble(intIndexTotal: Integer): Double;
Begin
  Result := 0;

  If intIndexTotal < Length(objGeraFr3.ArrTotaisRodape) Then
    Result := RoundTo(objGeraFr3.ArrTotaisRodape[intIndexTotal], -2);
End;

Procedure TGraficosDashboard.pGeraTotalize(jsnGrafico: TJSONObject; intNroRel: Integer);
  Var
    jarTotais: TJSONArray;
    intIndexTotal: Integer;
Begin
  fGetCdsCampos(intNroRel).Filter   := 'CAM_TOTALI <> ' + QuotedStr('');
  fGetCdsCampos(intNroRel).Filtered := True;

  If fGetCdsCampos(intNroRel).IsEmpty Then
    Exit;

  If Not objGeraFr3.fMontaGrid(intNroRel, mntTotais) Then
    Exit;

  fGetCdsCampos(intNroRel).Filter := Concat('CAM_TIPGRA = ', IntToStr(INT_SERIE), ' AND VISIVEL = 1');

  jarTotais := TJSONArray.Create;

  fGetCdsCampos(intNroRel).First;
  jarTotais.Add('Total:');

  fGetCdsCampos(intNroRel).Next;

  intIndexTotal := 0;

  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    If fEmptyStr(fGetCdsCampos(intNroRel).FieldByName('CAM_TOTALI').AsString) Then
    Begin
      jarTotais.Add('')
    End Else
    Begin

      Case arrDados[intNroRel].FieldByName(fGetCdsCampos(intNroRel).FieldByName('CAM_NOMCAM').AsString).DataType Of
        ftLargeint,
        DB.ftInteger,
        ftWord    : jarTotais.Add(fGetTotalCampoInteger(intIndexTotal));
        ftFloat   : jarTotais.Add(fGetTotalCampoDouble(intIndexTotal));
        Else        jarTotais.Add('');
      End;

      Inc(intIndexTotal);
    End;

    fGetCdsCampos(intNroRel).Next;
  End;

  jsnGrafico.AddPair('totalize', jarTotais);

  fGetCdsCampos(intNroRel).Filtered := False;
End;

Function TGraficosDashboard.fGetColumns(strPropor: String): String;
Begin
  If strPropor.IsEmpty Then
    Result := ''
  Else
    Result := Concat('template-', strPropor);
End;

Procedure TGraficosDashboard.pValidaVisibilidade(intNroRel: Integer);
Begin
  fGetCdsCampos(intNroRel).Filtered := False;

  fGetCdsCampos(intNroRel).First;
  While Not fGetCdsCampos(intNroRel).Eof Do
  Begin
    objGeraFR3.fValidaVisibilidade(fGetCdsCampos(intNroRel));
    fGetCdsCampos(intNroRel).Next;
  End;
End;

Function TGraficosDashboard.fMontaGrafico: Boolean;
  Var
    intGraficos,
    intNroRow: Integer;
    jsnGrafico: TJSONObject;
Begin
  Try
    If Not cdsColunasPorLinha.Active Then
      TInterfaceRelatorio(objGeraFr3.objInterfaceGera).fCarregaColunhasPorLinha;

    If Not TInterfaceRelatorio(objGeraFr3.objInterfaceGera).fValidaColunhasPorLinha Then
    Begin
      Result := False;
      Exit;
    End;

    FJArrPainel := TJSONArray.Create;

    pInicializaRows;

    intNroRow := 0;

    For intGraficos := Low(arrCadRel) To High(arrCadRel) Do
    If TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intGraficos].FieldByName('REL_DESTIN').AsString) In SET_GRAFICO_DASH Then
    Begin
      fGetCdsCampos(intGraficos).DisableControls;
      pValidaVisibilidade(intGraficos);

      If intNroRow <> FarrNroRow[intGraficos].intNroLin Then
      Begin
        intNroRow := FarrNroRow[intGraficos].intNroLin;
        FarrRows[Pred(intNroRow)] := TJSONObject.Create;
        FarrRows[Pred(intNroRow)].AddPair('row', TJSONNumber.Create(intNroRow));
        FarrRows[Pred(intNroRow)].AddPair('columns', fGetColumns(String(FarrNroRow[intGraficos].strPropor)));
      End;

      jsnGrafico := TJSONObject.Create;

      jsnGrafico.AddPair('id', TJSONString.Create(arrCadRel[intGraficos].FieldByName('REL_CODREL').AsString));
      jsnGrafico.AddPair('title', TJSONString.Create(objGeraFr3.fGetNomeRelatorio(arrCadRel[intGraficos])));
      jsnGrafico.AddPair('type', TJSONString.Create(fGetTipoGrafico(intGraficos)));

      If Not fEmptyStr(arrCadRel[intGraficos].FieldByName('REL_STYLID').AsString) Then
        jsnGrafico.AddPair('styleId', TJSONString.Create(arrCadRel[intGraficos].FieldByName('REL_STYLID').AsString));

      If TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intGraficos].FieldByName('REL_DESTIN').AsString)
            In [desGraficoBarrasEmpilhadasDashboard, desGraficoColunasEmpilhadasDashboard, desGraficoAreaEmpilhadoDashboard] Then
        jsnGrafico.AddPair('stacked', TJSONBool.Create(True));

      If TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intGraficos].FieldByName('REL_DESTIN').AsString) = desCardDashboard Then
      Begin
        pMontaValue(intGraficos, jsnGrafico);
        jsnGrafico.AddPair('icon', arrCadRel[intGraficos].FieldByName('REL_ICOGRA').AsString);
      End Else
      Begin
        if (fExisteGrupos(intGraficos)) then
          jsnGrafico.AddPair('groups', fGetGrupos(intGraficos));

        if (fExisteQuebra(intGraficos)) then
          jsnGrafico.AddPair('groupByFirstCollumn', TJSONBool.Create(True));

        jsnGrafico.AddPair('labels', fGetLabels(intGraficos));

        Case TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intGraficos].FieldByName('REL_DESTIN').AsString) Of
          desGridDashboard              : jsnGrafico.AddPair('datasets', fGetDataSetsGrid(intGraficos));
          desGraficoVelocimetroDashboard: jsnGrafico.AddPair('datasets', fGetDataSetsVelocimetro(intGraficos));
          Else                            jsnGrafico.AddPair('datasets', fGetDataSetsGenerico(intGraficos));
        End;

        Case TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intGraficos].FieldByName('REL_DESTIN').AsString) Of
          desGridDashboard: pGeraTotalize(jsnGrafico, intGraficos);
        End;

      End;

      If Not Assigned(FArrElements[Pred(intNroRow)]) Then
        FArrElements[Pred(intNroRow)] := TJSONArray.Create;

      FArrElements[Pred(intNroRow)].AddElement(jsnGrafico);

      If (intGraficos =  High(arrCadRel)) Or
         (intNroRow <> FarrNroRow[Succ(intGraficos)].intNroLin) Then
       If Assigned(FarrRows[Pred(intNroRow)]) Then
         FarrRows[Pred(intNroRow)].AddPair('elements', FArrElements[Pred(intNroRow)]);

      fGetCdsCampos(intGraficos).EnableControls;
    End;

    Inc(intNroRow);
    FarrRows[Pred(intNroRow)] := TJSONObject.Create;
    FarrRows[Pred(intNroRow)].AddPair('row', TJSONNumber.Create(intNroRow));
    FarrRows[Pred(intNroRow)].AddPair('date', FormatDateTime('DD/MM/YYYY', VS_Date));
    FarrRows[Pred(intNroRow)].AddPair('hour', FormatDateTime('HH:NN', fTime()));

    For intNroRow := Low(FarrRows) To High(FarrRows) Do
      If Assigned(FarrRows[intNroRow]) Then
        FJArrPainel.AddElement(FarrRows[intNroRow]);

    strJSon := FJArrPainel.ToString;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TGraficosDashboard.fMontaGrafico]');
    End;
  End;

End;

Procedure TGraficosDashboard.pMostraGrafico;
Begin
  Try
    pCriarFormularios(TfrmMostraDashboard, frmMostraDashboard);

    frmMostraDashboard.objGeraFr3 := objGeraFr3;

    If arrCadRel[0].FieldByName('REL_ALTGRA').AsInteger > 0 Then
    Begin
      objGeraFr3.intAlturaGrafico  := arrCadRel[0].FieldByName('REL_ALTGRA').AsInteger;
      objGeraFr3.intLarguraGrafico := arrCadRel[0].FieldByName('REL_LARGRA').AsInteger;
      objGeraFr3.blnMaximizado     := arrCadRel[0].FieldByName('REL_MAXGRA').AsString = 'S';
    End;

    frmMostraDashboard.blnMontagem := arrCadRel[0].State In [dsEdit, dsInsert];
    frmMostraDashboard.Caption := objGeraFr3.fGetNomeRelatorio(arrCadRel[0]);
    frmMostraDashboard.TMSFNCWebBrowser.URL := fGetURL;
    frmMostraDashboard.TMSFNCWebBrowser.Navigate;
    frmMostraDashboard.ShowModal;

    If arrCadRel[0].State In dsEditModes Then
    Begin
      arrCadRel[0].FieldByName('REL_ALTGRA').AsInteger := objGeraFr3.intAlturaGrafico;
      arrCadRel[0].FieldByName('REL_LARGRA').AsInteger := objGeraFr3.intLarguraGrafico;
      arrCadRel[0].FieldByName('REL_ALTLIN').AsString  := objGeraFr3.stlAlturaLinhas.Text;

      If objGeraFr3.blnMaximizado Then
        arrCadRel[0].FieldByName('REL_MAXGRA').AsString := 'S'
      Else
        arrCadRel[0].FieldByName('REL_MAXGRA').AsString := 'N';
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.message, '[TGraficosDashboard.pMostraGrafico]');
    End;
  End;

  pFreeAndNil(frmMostraDashboard);
End;

Function TGraficosDashboard.fRetId(strId: String): String;
Begin
  If Pos('=', strId) > 0 Then
    Delete(strId, 1, Pos('=', strId));

  Result := strId;
End;

Function TGraficosDashboard.fGetUTC(dt: TDateTime): TDateTime;
Begin
  Result := TTimeZone.Local.ToUniversalTime(dt);
End;

Function TGraficosDashboard.fRetornaTimeStampEmMilisegundos: Int64;
Begin
  Result := MilliSecondsBetween(fGetUTC(fNow), UnixDateDelta);
End;

Function TGraficosDashboard.fRetornaChaveBasic(AClientID, AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
Begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  LBase64 := TBase64Encoding.Create(0);
  Try
    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;
End;

Function TGraficosDashboard.fGetMD5(const strTexto: String): String;
  Var
    idHash128: TIdHashMessageDigest5;
Begin
  idHash128 := TIdHashMessageDigest5.Create;
  Try
    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
End;

Function TGraficosDashboard.fGetAuthorization: String;
  Var
    strTimeStampRequisicao: String;
Begin
  strTimeStampRequisicao := fRetornaTimeStampEmMilisegundos.ToString;
  Result := fRetornaChaveBasic(strTimeStampRequisicao,
                               fGetMD5(strTimeStampRequisicao + API_KEY));
End;

Function TGraficosDashboard.fGetURL: String;
var
  LRequisicao: TidHTTP;
  LParametros: TStringStream;
  strCSS,
  strIdDashboard,
  LRespostaRequisicao: string;
  LURL: string;

  function GetBody: string;
  begin
    Result := strJSon;
  end;

  function GetJsonValue(AJson, APath: String): string;
  var
    LObj: TJSONValue;
  begin
    Result := '';
    LObj := TJSONObject.ParseJSONValue(AJson);
    if LObj = nil then
      Exit;
    try
      Result := LObj.GetValue<string>(APath);
    finally
      LObj.Free;
    end;
  end;

Begin
  Result := '';
  LRequisicao := TIdHTTP.Create(Nil);
  LParametros := nil;

  try
    LURL := API_URL + '/api/dashboard';

    LRequisicao.ConnectTimeout      := 15000;
    LRequisicao.ReadTimeout         := 30000;
    LRequisicao.Request.Connection  := 'close';
    LRequisicao.Request.ContentType := 'application/json';
    LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
    LRequisicao.OnWork              := OnWork;
    LRequisicao.HTTPOptions         := [];
    LRequisicao.HandleRedirects     := True;

    LRequisicao.Request.CustomHeaders.Clear;
    LRequisicao.Request.CustomHeaders.AddValue('Authorization', fGetAuthorization);

    LParametros := TStringStream.Create(Trim(GetBody), TEncoding.UTF8);

    try
      LRespostaRequisicao := LRequisicao.Post(LURL, LParametros);
    except
      on E: EIdConnectTimeout do
      begin
        E.Message := 'Não foi possível conectar ao servidor do dashboard dentro do tempo limite.' + sLineBreak +
          'Verifique internet, firewall, DNS ou se o servidor está online.' + sLineBreak + sLineBreak +
          'URL: ' + LURL + sLineBreak + 'Detalhe: ' + E.Message;
        raise;
      end;
      on E: EIdReadTimeout do
      begin
        E.Message := 'O servidor do dashboard demorou muito para responder.' + sLineBreak +
          'Tente novamente em alguns instantes.' + sLineBreak + sLineBreak +
          'URL: ' + LURL + sLineBreak + 'Detalhe: ' + E.Message;
        raise;
      end;
      on E: EIdSocketError do
      begin
        E.Message := 'Erro de conexão com o servidor do dashboard.' + sLineBreak +
          E.Message + sLineBreak + sLineBreak + 'URL: ' + LURL;
        raise;
      end;
      on E: EIdHTTPProtocolException do
      begin
        E.Message := 'O servidor do dashboard retornou erro HTTP ' + IntToStr(E.ErrorCode) + '.' + sLineBreak +
          E.ErrorMessage;
        raise;
      end;
      on E: EAbort do
        raise;                                    { deixa EAbort propagar silencioso }
      on E: Exception do
      begin
        E.Message := 'Erro ao gerar dashboard web.' + sLineBreak + E.Message;
        raise;
      end;
    end;

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' +
        LRespostaRequisicao);

    strIdDashboard := GetJsonValue(LRespostaRequisicao, 'location');

    Try
      strCSS := fGetCSS;

      If Not strCSS.IsEmpty Then
        fSetaCSS(fRetId(strIdDashboard), strCSS);
    Except
      On E: EAbort Do raise;
      On E: Exception Do
        pMensagemOk('Erro ao aplicar estilo do dashboard.' + sLineBreak + E.Message);
    End;

    Result := API_URL  + strIdDashboard;

  finally
    FreeAndNil(LParametros);
    FreeAndNil(LRequisicao);
  end;
End;

Function TGraficosDashboard.fGetCSS: String;
  Var
    intGraficos: Integer;
Begin
  Result := '';

  For intGraficos := Low(arrCadRel) To High(arrCadRel) Do
    Result := Result + ' ' + AnsiReplaceStr(arrCadRel[intGraficos].FieldByName('REL_STYSHE').AsString, '<<csq>>', ' ');

  Result := Trim(Result)
End;

Function TGraficosDashboard.fSetaCSS(strId, strCSS: String): Boolean;
var
  LRequisicao: TidHTTP;
  LParametros: TStringStream;
  LRespostaRequisicao: string;
  jsnReq: TJSONObject;
  LURL: string;
Begin
  Result := False;

 {$IFDEF LINUX}
  IdOpenSSLSetLibPath(GetCurrentDir);//Forçar libcrypto.so e libssl.so da pasta do programa.
 {$ENDIF}

  LRequisicao := TIdHTTP.Create(Nil);
  LParametros := nil;
  try
    LRequisicao.ConnectTimeout      := 15000;
    LRequisicao.ReadTimeout         := 30000;
    LRequisicao.Request.Connection  := 'close';
    LRequisicao.Request.ContentType := 'application/json';
    LRequisicao.Request.UserAgent   := 'Mozilla/5.0';
    LRequisicao.OnWork              := OnWork;
    LRequisicao.HTTPOptions         := [];
    LRequisicao.HandleRedirects     := True;

    LRequisicao.Request.CustomHeaders.Clear;
    LRequisicao.Request.CustomHeaders.AddValue('Authorization', fGetAuthorization);

    LURL := API_URL + '/api/css';

    jsnReq := TJSONObject.Create;

    Try
      jsnReq.AddPair('md5Id', strId);
      jsnReq.AddPair('dashboardCSS', strCSS);
      LParametros := TStringStream.Create(jsnReq.ToJSON, TEncoding.UTF8);

      try
        LRespostaRequisicao := LRequisicao.Post(LURL, LParametros);
      except
        on E: EIdConnectTimeout do
        begin
          E.Message := 'Não foi possível conectar ao servidor do dashboard dentro do tempo limite.' + sLineBreak +
            'Verifique internet, firewall, DNS ou se o servidor está online.' + sLineBreak + sLineBreak +
            'URL: ' + LURL + sLineBreak + 'Detalhe: ' + E.Message;
          raise;
        end;
        on E: EIdReadTimeout do
        begin
          E.Message := 'O servidor do dashboard demorou muito para responder.' + sLineBreak +
            'Tente novamente em alguns instantes.' + sLineBreak + sLineBreak +
            'URL: ' + LURL + sLineBreak + 'Detalhe: ' + E.Message;
          raise;
        end;
        on E: EIdSocketError do
        begin
          E.Message := 'Erro de conexão com o servidor do dashboard.' + sLineBreak +
            E.Message + sLineBreak + sLineBreak + 'URL: ' + LURL;
          raise;
        end;
        on E: EIdHTTPProtocolException do
        begin
          E.Message := 'O servidor do dashboard retornou erro HTTP ' + IntToStr(E.ErrorCode) + '.' + sLineBreak +
            E.ErrorMessage;
          raise;
        end;
        on E: EAbort do
          raise;                                    { deixa EAbort propagar silencioso }
        on E: Exception do
        begin
          E.Message := 'Erro ao gerar dashboard web.' + sLineBreak + E.Message;
          raise;
        end;
      end;

    Finally
      jsnReq.Free;
    End;

    if LRequisicao.Response.ResponseCode <> 200 then
      raise Exception.Create(LRequisicao.Response.ResponseCode.ToString + ' - ' +
        LRespostaRequisicao);

    Result := True;
  finally
    FreeAndNil(LParametros);
    FreeAndNil(LRequisicao);
  end;
End;

procedure TGraficosDashboard.OnWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  // apenas atualização de progresso, sem ProcessMessages
end;

end.
