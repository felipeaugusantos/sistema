unit untCNFOCO_Dao;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, DB, UniClientDataSet,
     Uni, System.Variants, untCNFOCO_Class, System.Generics.Collections,
     untFuncoesSimples, VCL.Forms;

type
  TCnfOcoDao = class(TObject)
  private
     FCodBco: String;
     FCartei: Integer;
     FTipLay: String;
     FNumPos: String;
     FEspeci: String;
     FCodEmp: String;

     function fRetornaSQLInserir: String;
     function fRetornaSQLInserirLog: String;
     function fRetornaSQLAtualizar: String;
     function fRetornaSQLBuscaTodasOcorrencias: String;
     function fRetornaSQLBuscaOcorrencia(blnCodCta : Boolean = False): String;
     function fRetornaSQLApagarOcorrencia: String;
     function fGravaLog(const objCnfOco: TCnfOco; strDesLog: String): Boolean;
  public
     constructor Create(const strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp: String; intCartei: Integer); overload;

     function fBuscaPorOcorrencia(const strCodOco: String; strMotOco: String = ''; strCodCta: String = ''; intTipDes: Integer = 0): TCnfOco;
     function fBuscaTodas: TObjectList<TCnfOco>;
     function fInserir(const objCnfOco: TCnfOco): Boolean;
     function fInserirLista(listCnfOco: TObjectList<TCnfOco>): Boolean;
     function fAtualizar(const objCnfOco: TCnfOco): Boolean;
     function fAtualizarLista(listCnfOco: TObjectList<TCnfOco>): Boolean;
     function fRemoverOcorrencia(const strCodOco: String; strMotOco: String = ''; strCodCta: String = ''; intTipDes: Integer = 0): Boolean;
  end;

implementation

{ TCNFOCODao }

constructor TCNFOCODao.Create(const strCodBco, strTipLay, strNumPos, strEspeci,
  strCodEmp: String; intCartei: Integer);
begin
  FCodBco := strCodBco;
  FTipLay := strTiplay;
  FNumPos := strNumPos;
  FEspeci := strEspeci;
  FCodEmp := strCodEmp;
  FCarTei := intCartei;
end;

function TCNFOCODao.fAtualizar(const objCnfOco: TCnfOco): Boolean;
Var
  qryExeSql: TUniQuery;
Begin
  Result := False;
  If Assigned(objCnfOco) Then
  Begin
    qryExeSql := fCriaQuery();

    Try
      With qryExeSql Do
      Begin
        SQL.Text := '';
        SQL.Text := fRetornaSQLAtualizar;

        ParamByName('GERPAG').AsBoolean := objCnfOco.blnGerPag;
        ParamByName('CUSCAR').AsBoolean := objCnfOco.blnCusCar;
        ParamByName('GERREC').AsBoolean := objCnfOco.blnGerRec;
        ParamByName('USADIA').AsString  := IIF(objCnfOco.blnUsaDia, 'S', 'N');
        ParamByName('CODFOR').AsString  := objCnfOco.strCodFor;
        ParamByName('CODCTA').AsString  := objCnfOco.strCodCta;
        ParamByName('CODPOR').AsString  := objCnfOco.strCodPor;
        ParamByName('AUTOIN').AsString  := objCnfOco.strAutInc;

        ExecSQL;

        fGravaLog(objCnfOco, 'ATUALIZAÇÃO');

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryExeSql);

        Raise Exception.Create(E.Message);
      End;
    End;

    If Assigned(qryExeSql) Then
      FreeAndNil(qryExeSql);
  End;
end;

function TCNFOCODao.fAtualizarLista(listCnfOco: TObjectList<TCnfOco>): Boolean;
var
  objCnfOco: TCnfOco;
Begin
  Result := False;
  If Assigned(listCnfOco) Then
  Begin
    If listCnfOco.Count > 0  Then
    Begin
      Try
        For objCnfOco in listCnfOco Do
          fAtualizar(objCnfOco);

        Result := True;
      Except
        On E: Exception Do
          Raise Exception.Create(E.Message);
      End;
    End;
  End;
End;

function TCNFOCODao.fBuscaPorOcorrencia(const strCodOco: String; strMotOco: String = ''; strCodCta: String = ''; intTipDes: Integer = 0): TCnfOco;
var
  qryRetOco: TUniQuery;
Begin
  Result    := nil;
  qryRetOco := fCriaQuery();

  With qryRetOco Do
  Begin
    SQL.Text := '';
    SQL.Text := fRetornaSQLBuscaOcorrencia(IIF(Not fEmptyStr(strCodCta),True,False));

    ParamByName('CODBCO').AsString  := FCodBco;
    ParamByName('TIPLAY').AsString  := FTipLay;
    ParamByName('NUMPOS').AsString  := FNumPos;
    ParamByName('ESPECI').AsString  := FEspeci;
    ParamByName('CODEMP').AsString  := FCodEmp;
    ParamByName('CARTEI').AsInteger := FCarTei;
    ParamByName('CODOCO').AsString  := strCodOco;
    ParamByName('MOTOCO').AsString  := strMotOco;
    If Not fEmptyStr(strCodCta) Then
      ParamByName('CODCTA').AsString  := strCodCta;
    ParamByName('TIPDES').AsInteger := intTipDes;

    Open;

    If not IsEmpty Then
    Begin
      Result := TCnfOco.Create;
      Result.strCodBco := FieldByName('CNF_CODBCO').AsString;
      Result.intCartei := FieldByName('CNF_CARTEI').AsInteger;
      Result.strTipLay := FieldByName('CNF_TIPLAY').AsString;
      Result.strNumPos := FieldByName('CNF_NUMPOS').AsString;
      Result.strEspeci := FieldByName('CNF_ESPECI').AsString;
      Result.strCodEmp := FieldByName('CNF_CODEMP').AsString;
      Result.strCodOco := FieldByname('CNF_CODOCO').AsString;
      Result.strMotOco := FieldByname('CNF_MOTOCO').AsString;
      Result.intTipDes := FieldByName('CNF_TIPDES').AsInteger;
      Result.strDesOco := FieldByname('CNF_DESOCO').AsString;
      Result.strCodPor := FieldByname('CNF_CODPOR').AsString;
      Result.strCodFor := FieldByname('CNF_CODFOR').AsString;
      Result.strCodCta := FieldByname('CNF_CODCTA').AsString;
      Result.blnGerpag := FieldByname('CNF_GERPAG').AsInteger.ToBoolean;
      Result.blnCusCar := FieldByname('CNF_CUSCAR').AsInteger.ToBoolean;
      Result.blnUsaDia := FieldByName('CNF_USADIA').AsString = 'S';
      Result.strAutInc := FieldByname('AUTOINCREM').AsString;
      Result.blnGerRec := FieldByname('CNF_GERREC').AsInteger.ToBoolean;
    End;
  End;

  FreeAndNil(qryRetOco);
End;

function TCNFOCODao.fBuscaTodas: TObjectList<TCnfOco>;
Var
  qryRetOco: TUniQuery;
  objCnfOco: TCnfOco;
Begin
  Result := TObjectList<TCnfOco>.Create;

  qryRetOco := fCriaQuery();

  With qryRetOco Do
  Begin
    SQL.Clear;
    SQL.Text := fRetornaSQLBuscaTodasOcorrencias;

    ParamByName('CODBCO').AsString  := FCodBco;
    ParamByName('TIPLAY').AsString  := FTipLay;
    ParamByName('NUMPOS').AsString  := FNumPos;
    ParamByName('ESPECI').AsString  := FEspeci;
    ParamByName('CODEMP').AsString  := FCodEmp;
    ParamByName('CARTEI').AsInteger := FCarTei;

    Open;

    If Not IsEmpty Then
    begin
      While Not Eof Do
      Begin
        objCnfOco := TCnfOco.Create;
        objCnfOco.strCodBco := FieldByName('CNF_CODBCO').AsString;
        objCnfOco.intCartei := FieldByName('CNF_CARTEI').AsInteger;
        objCnfOco.strTipLay := FieldByName('CNF_TIPLAY').AsString;
        objCnfOco.strNumPos := FieldByName('CNF_NUMPOS').AsString;
        objCnfOco.strEspeci := FieldByName('CNF_ESPECI').AsString;
        objCnfOco.strCodEmp := FieldByName('CNF_CODEMP').AsString;
        objCnfOco.strCodOco := FieldByName('CNF_CODOCO').AsString;
        objCnfOco.strMotOco := FieldByName('CNF_MOTOCO').AsString;
        objCnfOco.intTipDes := FieldByName('CNF_TIPDES').AsInteger;
        objCnfOco.strDesOco := FieldByName('CNF_DESOCO').AsString;
        objCnfOco.strCodPor := FieldByName('CNF_CODPOR').AsString;
        objCnfOco.strCodFor := FieldByName('CNF_CODFOR').AsString;
        objCnfOco.strCodCta := FieldByName('CNF_CODCTA').AsString;
        objCnfOco.blnGerpag := FieldByName('CNF_GERPAG').AsInteger.ToBoolean;
        objCnfOco.blnCusCar := FieldByName('CNF_CUSCAR').AsInteger.ToBoolean;
        objCnfOco.blnUsaDia := FieldByName('CNF_USADIA').AsString = 'S';
        objCnfOco.strAutInc := FieldByName('AUTOINCREM').AsString;
        objCnfOco.blnGerRec := FieldByName('CNF_GERREC').AsInteger.ToBoolean;

        Result.Add(objCnfOco);

        Next;
      End;
    End;
  End;

  FreeAndNil(qryRetOco);
End;

function TCnfOcoDao.fGravaLog(const objCnfOco: TCnfOco; strDesLog: String): Boolean;
Var
  qryExeSql: TUniQuery;
Begin
  Result := False;
  If Assigned(objCnfOco) Then
  Begin
    qryExeSql := fCriaQuery();

    Try
      With qryExeSql Do
      Begin
        SQL.Text := '';
        SQL.Text := fRetornaSQLInserirLog;

        ParamByName('CODBCO').AsString  := objCnfOco.strCodBco;
        ParamByName('CARTEI').AsInteger := objCnfOco.intCartei;
        ParamByName('TIPLAY').AsString  := objCnfOco.strTipLay;
        ParamByName('NUMPOS').AsString  := objCnfOco.strNumPos;
        ParamByName('ESPECI').AsString  := objCnfOco.strEspeci;
        ParamByName('CODEMP').AsString  := objCnfOco.strCodEmp;
        ParamByName('CODOCO').AsString  := objCnfOco.strCodOco;
        ParamByName('MOTOCO').AsString  := objCnfOco.strMotOco;
        ParamByName('TIPDES').AsInteger := objCnfOco.intTipDes;
        ParamByName('DESOCO').AsString  := objCnfOco.strDesOco;
        ParamByName('GERPAG').AsBoolean := objCnfOco.blnGerPag;
        ParamByName('GERREC').AsBoolean := objCnfOco.blnGerRec;
        ParamByName('CUSCAR').AsBoolean := objCnfOco.blnCusCar;
        ParamByName('CODFOR').AsString  := objCnfOco.strCodFor;
        ParamByName('CODCTA').AsString  := objCnfOco.strCodCta;
        ParamByName('CODPOR').AsString  := objCnfOco.strCodPor;
        ParamByName('USADIA').AsString  := IIF(objCnfOco.blnUsaDia, 'S', 'N');
        ParamByName('DTALOG').AsDate    := VS_Date;
        ParamByName('HORLOG').AsTime    := fTime();
        ParamByName('HISLOG').AsString  := strDesLog;
        ParamByName('NOMFRM').AsString  := 'frmPrincipal';
        ParamByName('OPELOG').AsString  := strLoginUsuarioLogado;
        ParamByName('AUTOIN').AsString  := fRetAutoIncrem('LOGOCO', objCnfOco.strCodEmp);

        ExecSQL;

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryExeSql);

        Raise Exception.Create(E.Message);
      End;
    End;

    If Assigned(qryExeSql) Then
      FreeAndNil(qryExeSql);
  End;
End;

function TCNFOCODao.fInserir(const objCnfOco: TCnfOco): Boolean;
Var
  qryExeSql: TUniQuery;
Begin
  Result := False;
  If Assigned(objCnfOco) Then
  Begin
    qryExeSql := fCriaQuery();

    Try
      With qryExeSql Do
      Begin
        SQL.Text := '';
        SQL.Text := fRetornaSQLInserir;

        ParamByName('CODBCO').AsString  := objCnfOco.strCodBco;
        ParamByName('CARTEI').AsInteger := objCnfOco.intCartei;
        ParamByName('TIPLAY').AsString  := objCnfOco.strTipLay;
        ParamByName('NUMPOS').AsString  := objCnfOco.strNumPos;
        ParamByName('ESPECI').AsString  := objCnfOco.strEspeci;
        ParamByName('CODEMP').AsString  := objCnfOco.strCodEmp;
        ParamByName('CODOCO').AsString  := objCnfOco.strCodOco;
        ParamByName('MOTOCO').AsString  := objCnfOco.strMotOco;
        ParamByName('TIPDES').AsInteger := objCnfOco.intTipDes;
        ParamByName('DESOCO').AsString  := objCnfOco.strDesOco;
        ParamByName('GERPAG').AsBoolean := objCnfOco.blnGerPag;
        ParamByName('GERREC').AsBoolean := objCnfOco.blnGerRec;
        ParamByName('CUSCAR').AsBoolean := objCnfOco.blnCusCar;
        ParamByName('CODFOR').AsString  := objCnfOco.strCodFor;
        ParamByName('CODCTA').AsString  := objCnfOco.strCodCta;
        ParamByName('CODPOR').AsString  := objCnfOco.strCodPor;
        ParamByName('USADIA').AsString  := IIF(objCnfOco.blnUsaDia, 'S', 'N');
        ParamByName('AUTOIN').AsString  := fRetAutoIncrem('CNFOCO', objCnfOco.strCodEmp);

        ExecSQL;

        fGravaLog(objCnfOco, 'INCLUSÃO');

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryExeSql);

        Raise Exception.Create(E.Message);
      End;
    End;

    If Assigned(qryExeSql) Then
      FreeAndNil(qryExeSql);
  End;
End;

function TCNFOCODao.fInserirLista(listCnfOco: TObjectList<TCnfOco>): Boolean;
var
  objCnfOco: TCnfOco;
Begin
  Result := False;
  If Assigned(listCnfOco) Then
  Begin
    If listCnfOco.Count > 0  Then
    Begin
      Try
        For objCnfOco in listCnfOco Do
          fInserir(objCnfOco);

        Result := True;
      Except
        On E: Exception Do
          Raise Exception.Create(E.Message);
      End;
    End
  End;
End;

function TCnfOcoDao.fRemoverOcorrencia(const strCodOco: String; strMotOco: String = ''; strCodCta: String = ''; intTipDes: Integer = 0): Boolean;
Var
  qryExeSql: TUniQuery;
  objCnfOco: TCnfOco;
Begin
  Result := False;
  If Not fEmptyStr(strCodOco) Then
  Begin
    objCnfOco := fBuscaPorOcorrencia(strCodOco,strMotOco,strCodCta,intTipDes);
    If Assigned(objCnfOco) Then
    Begin
      qryExeSql := fCriaQuery();

      Try
        With qryExeSql Do
        Begin
          SQL.Text := '';
          SQL.Text := fRetornaSQLApagarOcorrencia;

          ParamByName('CODBCO').AsString  := objCnfOco.strCodBco;
          ParamByName('CARTEI').AsInteger := objCnfOco.intCartei;
          ParamByName('TIPLAY').AsString  := objCnfOco.strTipLay;
          ParamByName('NUMPOS').AsString  := objCnfOco.strNumPos;
          ParamByName('ESPECI').AsString  := objCnfOco.strEspeci;
          ParamByName('CODEMP').AsString  := objCnfOco.strCodEmp;
          ParamByName('CODOCO').AsString  := objCnfOco.strCodOco;
          ParamByName('MOTOCO').AsString  := objCnfOco.strMotOco;
          ParamByName('CODCTA').AsString  := objCnfOco.strCodCta;
          ParamByName('TIPDES').AsInteger := objCnfOco.intTipDes;

          ExecSQL;

          fGravaLog(objCnfOco, 'EXCLUSÃO');

          Result := True;
        End;
      Except
        On E: Exception Do
        Begin
          FreeAndNil(qryExeSql);

          Raise Exception.Create(E.Message);
        End;
      End;

      If Assigned(qryExeSql) Then
        FreeAndNil(qryExeSql);
    End;
  End;
end;

function TCnfOcoDao.fRetornaSQLApagarOcorrencia: String;
begin
  Result :=   ' DELETE FROM CNFOCO ' +
              ' WHERE ' +
              '   CNF_CODBCO  = :CODBCO AND ' +
              '   CNF_CARTEI  = :CARTEI AND ' +
              '   CNF_TIPLAY  = :TIPLAY AND ' +
              '   CNF_NUMPOS  = :NUMPOS AND ' +
              '   CNF_ESPECI  = :ESPECI AND ' +
              '   CNF_CODEMP  = :CODEMP AND ' +
              '   CNF_CODOCO  = :CODOCO AND ' +
              '   CNF_MOTOCO  = :MOTOCO AND ' +
              '   CNF_CODCTA  = :CODCTA AND ' +
              '   CNF_TIPDES  = :TIPDES     ';
end;

function TCnfOcoDao.fRetornaSQLAtualizar: String;
begin
  Result :=   ' UPDATE CNFOCO '   +
              ' SET ' +
              '   CNF_GERPAG  = :GERPAG, ' +
              '   CNF_GERREC  = :GERREC, ' +
              '   CNF_CUSCAR  = :CUSCAR, ' +
              '   CNF_USADIA  = :USADIA, ' +
              '   CNF_CODFOR  = :CODFOR, ' +
              '   CNF_CODPOR  = :CODPOR, ' +
              '   CNF_CODCTA  = :CODCTA  ' +
              ' WHERE                    ' +
              '   AUTOINCREM  = :AUTOIN  ';
end;

function TCnfOcoDao.fRetornaSQLBuscaOcorrencia(blnCodCta : Boolean = False): String;
begin
  Result :=   ' SELECT * FROM CNFOCO ' +
              ' WHERE ' +
              '   CNF_CODBCO  = :CODBCO AND ' +
              '   CNF_CARTEI  = :CARTEI AND ' +
              '   CNF_TIPLAY  = :TIPLAY AND ' +
              '   CNF_NUMPOS  = :NUMPOS AND ' +
              '   CNF_ESPECI  = :ESPECI AND ' +
              '   CNF_CODEMP  = :CODEMP AND ' +
              '   CNF_CODOCO  = :CODOCO AND ' +
              '   CNF_MOTOCO  = :MOTOCO AND ' +
              IIF(blnCodCta, '   CNF_CODCTA  = :CODCTA AND ','') +
              '   CNF_TIPDES  = :TIPDES     ';
end;

function TCnfOcoDao.fRetornaSQLBuscaTodasOcorrencias: String;
begin
  Result :=   ' SELECT * FROM CNFOCO ' +
              ' WHERE ' +
              '   CNF_CODBCO  = :CODBCO AND ' +
              '   CNF_CARTEI  = :CARTEI AND ' +
              '   CNF_TIPLAY  = :TIPLAY AND ' +
              '   CNF_NUMPOS  = :NUMPOS AND ' +
              '   CNF_ESPECI  = :ESPECI AND ' +
              '   CNF_CODEMP  = :CODEMP     ';
end;

function TCnfOcoDao.fRetornaSQLInserir: String;
begin
  Result :=   ' INSERT INTO CNFOCO ' +
              ' SET ' +
              '   CNF_CODBCO  = :CODBCO, ' +
              '   CNF_MOTOCO  = :MOTOCO, ' +
              '   CNF_TIPDES  = :TIPDES, ' +
              '   CNF_CARTEI  = :CARTEI, ' +
              '   CNF_TIPLAY  = :TIPLAY, ' +
              '   CNF_NUMPOS  = :NUMPOS, ' +
              '   CNF_ESPECI  = :ESPECI, ' +
              '   CNF_CODEMP  = :CODEMP, ' +
              '   CNF_CODOCO  = :CODOCO, ' +
              '   CNF_DESOCO  = :DESOCO, ' +
              '   CNF_GERPAG  = :GERPAG, ' +
              '   CNF_GERREC  = :GERREC, ' +
              '   CNF_CUSCAR  = :CUSCAR, ' +
              '   CNF_CODFOR  = :CODFOR, ' +
              '   CNF_CODPOR  = :CODPOR, ' +
              '   CNF_CODCTA  = :CODCTA, ' +
              '   CNF_USADIA  = :USADIA, ' +
              '   AUTOINCREM  = :AUTOIN  ';
end;

function TCnfOcoDao.fRetornaSQLInserirLog: String;
begin
  Result :=   ' INSERT INTO LOGOCO ' +
              ' SET ' +
              '   CNF_CODBCO  = :CODBCO, ' +
              '   CNF_MOTOCO  = :MOTOCO, ' +
              '   CNF_TIPDES  = :TIPDES, ' +
              '   CNF_CARTEI  = :CARTEI, ' +
              '   CNF_TIPLAY  = :TIPLAY, ' +
              '   CNF_NUMPOS  = :NUMPOS, ' +
              '   CNF_ESPECI  = :ESPECI, ' +
              '   CNF_CODEMP  = :CODEMP, ' +
              '   CNF_CODOCO  = :CODOCO, ' +
              '   CNF_DESOCO  = :DESOCO, ' +
              '   CNF_GERPAG  = :GERPAG, ' +
              '   CNF_GERREC  = :GERREC, ' +
              '   CNF_CUSCAR  = :CUSCAR, ' +
              '   CNF_CODFOR  = :CODFOR, ' +
              '   CNF_CODPOR  = :CODPOR, ' +
              '   CNF_CODCTA  = :CODCTA, ' +
              '   CNF_DTALOG  = :DTALOG, ' +
              '   CNF_HORLOG  = :HORLOG, ' +
              '   CNF_HISLOG  = :HISLOG, ' +
              '   CNF_NOMFRM  = :NOMFRM, ' +
              '   CNF_OPELOG  = :OPELOG, ' +
              '   CNF_USADIA  = :USADIA, ' +
              '   AUTOINCREM  = :AUTOIN  ';
end;

end.

