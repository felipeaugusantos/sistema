unit untInformacoesECF;

interface

uses SysUtils, Classes, Uni, Contnrs, DateUtils, Math;

Type
  TEcfLoja = class(TObject)
    public
      strNumSer: String;
      strCodEmp: String;
      strCodEcf: String;
  End;

Type
  TInformacoesECF = class(TObject)
    private
      stlEcfs: TObjectList;
      dtaDtaIni: TDateTime;
      dtaDtaFin: TDateTime;

      procedure pCarregaEcfsPorLoja;
      procedure pDefineDatasEcf;
    public
      constructor Create(dtaDtaIni, dtaDtaFin: TDateTime);
      destructor Destroy; override;

      procedure pProcessarInformacoes;
      procedure pTotaisPorLoja(const strCodEmp: String; Var fltVlrCon, fltBasIcm, fltValIcm: Double);
      procedure pVerificaReducoesPendentes(strEmpresa: String; stlResult: TStrings);

      function fEcfsPorLoja(const strCodEmp: String): TObjectList;
      function fReducoesOk(strEmpresa: String): Boolean;
      function fVerificaNfceSat(strCodEmp: String): Boolean;
  End;

implementation

uses untMemo, untFuncoesSimples, untIFuncoes;

{ TInformacoesECF }

constructor TInformacoesECF.Create(dtaDtaIni, dtaDtaFin: TDateTime);
begin
  stlEcfs := TObjectList.Create;

  Self.dtaDtaIni := dtaDtaIni;
  Self.dtaDtaFin := dtaDtaFin;
  pDefineDatasEcf;
end;

procedure TInformacoesECF.pCarregaEcfsPorLoja;
  Var
    qryEcfs: TUniQuery;
    ecf: TEcfLoja;
begin
  qryEcfs := fCriaQuery(Nil);
  qryEcfs.SQL.Add('SELECT ');
  qryEcfs.SQL.Add('  FIS_CODEMP, ECF_CODECF, REPLACE(FIS_NUMSER, "\0", "") AS FIS_NUMSER ');
  qryEcfs.SQL.Add('FROM ');
  qryEcfs.SQL.Add('  CADFIS ');
  qryEcfs.SQL.Add('JOIN CADECF ON ECF_NUMSER = REPLACE(FIS_NUMSER, "\0", "") ');
  qryEcfs.SQL.Add('WHERE ');
  qryEcfs.SQL.Add('  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ');
  qryEcfs.SQL.Add('  FIS_ESPDOC IN ("IF", "IV") AND ');
  qryEcfs.SQL.Add('  IFNULL(FIS_HISTOR, "") NOT LIKE "%CANCELADO%" ');
  qryEcfs.SQL.Add('GROUP BY ');
  qryEcfs.SQL.Add('  FIS_CODEMP, FIS_NUMSER ');

  qryEcfs.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
  qryEcfs.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
  qryEcfs.Open;

  While (Not qryEcfs.Eof) Do
  Begin
    ecf := TEcfLoja.Create;
    ecf.strNumSer := qryEcfs.FieldByName('FIS_NUMSER').AsString;
    ecf.strCodEmp := qryEcfs.FieldByName('FIS_CODEMP').AsString;
    ecf.strCodEcf := qryEcfs.FieldByName('ECF_CODECF').AsString;

    stlEcfs.Add(ecf);
    
    qryEcfs.Next;
  End;

  FreeAndNil(qryEcfs);
end;

procedure TInformacoesECF.pDefineDatasEcf;
  Var
    dtaSped: TDateTime;
    strDtaSped: String;
begin
  If (dtaDtaFin >= VS_Date) Then
  Begin
    dtaDtaFin := IncDay(dtaDtaFin, -1);
  End;

  strDtaSped := fCfgSis('INOBSF', varString);
  If fEmptyStr(strDtaSped) Then
  Begin
    Exit;
  End;

  dtaSped := fCfgSis('INOBSF', varDate);
  If (dtaDtaIni < dtaSped) And (dtaDtaFin < dtaSped) Then
  Begin
    dtaDtaIni := 0;
    dtaDtaFin := 0;
  End
  Else If dtaDtaIni < dtaSped Then
  Begin
    dtaDtaIni := Max(dtaSped, dtaDtaIni);
    dtaDtaFin := Max(dtaSped, dtaDtaFin);
  End;

end;

procedure TInformacoesECF.pProcessarInformacoes;
begin
  stlEcfs.Clear;
  pCarregaEcfsPorLoja;
end;

procedure TInformacoesECF.pTotaisPorLoja(const strCodEmp: String; var fltVlrCon, fltBasIcm,
  fltValIcm: Double);
  Var
    qryTotais: TUniQuery;
    stlEcfsTmp: TObjectList;
    strNumSerEmp: String;
    intContador: Integer;
begin
  strNumSerEmp := '';
  stlEcfsTmp := fEcfsPorLoja(strCodEmp);
  For intContador := 0 To stlEcfsTmp.Count-1 Do
  Begin
    strNumSerEmp := strNumSerEmp + TEcfLoja(stlEcfsTmp[intContador]).strNumSer + ',';
  End;

  fltBasIcm := 0;
  fltValIcm := 0;

  If Not fEmptyStr(strNumSerEmp) Then
  Begin
    qryTotais := fCriaQuery(Nil);

    qryTotais.SQL.Add('SELECT ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_BASIMP, 0)) AS VLRCON, ');
    qryTotais.SQL.Add('  SUM(IF(TOT_ALQIMP > 0, IFNULL(TOT_BASIMP, 0), 0)) AS BASIMP, ');
    qryTotais.SQL.Add('  SUM(IFNULL(TOT_VALIMP, 0)) AS VALIMP ');
    qryTotais.SQL.Add('FROM ');
    qryTotais.SQL.Add('  RDZTOT ');
    qryTotais.SQL.Add('JOIN CADRDZ ON RDZ_QTDRDZ = TOT_NUMCRZ AND ');
    qryTotais.SQL.Add('               RDZ_CODECF = TOT_CODECF ');
    qryTotais.SQL.Add('JOIN CADECF ON ECF_CODECF = RDZ_CODECF ');
    qryTotais.SQL.Add('WHERE ');
    qryTotais.SQL.Add('  LOCATE(ECF_NUMSER, :NUMSER) > 0 AND ');
    qryTotais.SQL.Add('  RDZ_DTAMOV BETWEEN :DTAINI AND :DTAFIN ');

    qryTotais.ParamByName('NUMSER').AsString := strNumSerEmp;
    qryTotais.ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    qryTotais.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
    qryTotais.Open;

    fltVlrCon := qryTotais.FieldByName('VLRCON').AsFloat;
    fltBasIcm := qryTotais.FieldByName('BASIMP').AsFloat;
    fltValIcm := qryTotais.FieldByName('VALIMP').AsFloat;

    FreeAndNil(qryTotais);
  End;

  FreeAndNil(stlEcfs);
end;

destructor TInformacoesECF.Destroy;
begin
  FreeAndNil(stlEcfs);
  inherited;
end;

{*************************************}
{* QUEM CHAMA A FUNÇÃO É RESPONSÁVEL *}
{* POR LIBERAR A MEMÓRIA.            *}
{**********************************MV*}
function TInformacoesECF.fEcfsPorLoja(const strCodEmp: String): TObjectList;
  Var
    intContador: Integer;
begin
  Result := TObjectList.Create;
  Result.OwnsObjects := False;

  For intContador := 0 To stlEcfs.Count-1 Do
  Begin
    If (fEmptyStr(strCodEmp)) Or (TEcfLoja(stlEcfs[intContador]).strCodEmp = strCodEmp) Then
      Result.Add(stlEcfs[intContador]);
  End;
end;

{*************************************}
{* QUEM CHAMA A FUNÇÃO É RESPONSÁVEL *}
{* POR LIBERAR A MEMÓRIA.            *}
{**********************************MV*}
procedure TInformacoesECF.pVerificaReducoesPendentes(strEmpresa: String; stlResult: TStrings);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT DISTINCT' +
                       '  F.FIS_DTAENT, F.FIS_NUMSER, E.ECF_CODECF, F.FIS_CODEMP, IFNULL(F.FIS_ACESSO, "") AS ACESSO ' +
                       'FROM ' +
                       '  CADFIS F ' +
                       'LEFT JOIN CADECF E ' +
                       '  ON REPLACE(E.ECF_NUMSER, "\0", "") = REPLACE(F.FIS_NUMSER, "\0", "") ' +
                       'LEFT JOIN CADRDZ R ' +
                       '  ON R.RDZ_CODECF = E.ECF_CODECF AND ' +
                       '  R.RDZ_DTAMOV = F.FIS_DTAENT ' +
                       'WHERE (F.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIM) ' +
                       'AND (F.FIS_ESPDOC IN ("IF", "IV")) ' +
                       'AND (F.FIS_NUMSER IS NOT NULL) ' +
                       'AND (R.RDZ_DTAMOV IS NULL) ';

    If Not fEmptyStr(strEmpresa) Then
      qryAux.SQL.Text := qryAux.SQL.Text + 'AND (F.FIS_CODEMP = :CODEMP) ';

    qryAux.ParamByName('DTAINI').AsDate    := dtaDtaIni;
    qryAux.ParamByName('DTAFIM').AsDate    := dtaDtaFin;

    If Not fEmptyStr(strEmpresa) Then
      qryAux.ParamByName('CODEMP').AsString := strEmpresa;

    qryAux.Open;

    While Not qryAux.Eof Do
    Begin
      If fEmptyStr(qryAux.FieldByName('ACESSO').AsString) Then
      Begin
        Begin
          If fEmptyStr(qryAux.FieldByName('ECF_CODECF').AsString) Then
          Begin
            stlResult.Add('Não existe ECF cadastrado para o dia ' +
              FormatDateTime('dd/mm/yyyy',qryAux.FieldByName('FIS_DTAENT').AsDateTime) + ' ECF ' +
              qryAux.FieldByName('FIS_NUMSER').AsString);
          End
          Else
          Begin
            stlResult.Add('Não existe Redução Z gravada para o dia ' +
              FormatDateTime('dd/mm/yyyy',qryAux.FieldByName('FIS_DTAENT').AsDateTime) + ' ECF ' +
              qryAux.FieldByName('FIS_NUMSER').AsString);
          End;
        End;
      End;

      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TInformacoesECF.fReducoesOk(strEmpresa: String): Boolean;
  Var
    stlErros: TStringList;
begin
  stlErros := TStringList.Create;
  pVerificaReducoesPendentes(strEmpresa, stlErros);

  Result := (stlErros.Count <= 0);

  If Not Result Then
  Begin
    pCriarFormularios(TfrmMemo, frmMemo);

    Try
      stlErros.Insert(0, 'Verifique as pendências abaixo antes de de prosseguir.');
      frmMemo.cxMemo.Lines.Assign(stlErros);
      frmMemo.ShowModal;
    Finally
      FreeAndNil(frmMemo);
    End;
  End;

  FreeAndNil(stlErros);
end;

function TInformacoesECF.fVerificaNfceSat(strCodEmp: String): Boolean;
  Var
    qryAux: TUniQuery;

  procedure pCarregaSQL(qryAux: TUniQuery);
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG IN ("CFG_USNFCE", "CFG_USASAT") AND SIS_CODEMP = :CODEMP ';
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  end;
begin
  //Essa função tem como objetivo não validar as reduções Z quando a empresa for configurada para usar SAT ou NFCE.
  Result := True;

  qryAux := fCriaQuery(Nil);
  Try
    pCarregaSQL(qryAux);
    qryAux.Open;

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      If qryAux.FieldByName('SIS_VALCFG').AsString = 'S' Then
      Begin
        Result := False;
        Exit;
      End;

      Result := True;

      qryAux.Next;
    End;
  Finally
    qryAux.Free;
  End;
end;

end.
