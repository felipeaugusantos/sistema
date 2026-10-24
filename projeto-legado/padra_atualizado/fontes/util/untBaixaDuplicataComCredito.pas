unit untBaixaDuplicataComCredito;

interface

uses Classes, SysUtils, Math, Uni, untFuncFat, untCadRec, untMovGer, untFuncoes, untFuncoesSimples;

Type
  TBaixaDuplicataComCredito = class(TComponent)
    private
      fltRecebido:Double;
      strPorBai: String;
      strCtaBai: String;
      strHisBai: String;
      intSeqBai: Integer;
      strAutIncBaixaParcial: String;
      qryAux: TUniQuery;
      stlDupCreditos: TStringList;

      function fDuplicatasCredito(strCodCli: string):Double;
      function fBaixaReceber(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOpeBai: string; intSeqCon: integer):Boolean;
      function fEfetuarBaixaParcial(qryDuplicatas: TUniQuery; strCodEmp, strOpeBai: string; intSeqCon: integer): boolean;
      function fEfetuarBaixaTotal(qryDuplicatas: TUniQuery; strCodEmp, strOpeBai: string; intSeqCon: integer): boolean;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function fBaixaDuplicatas(strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strCodCli,
                                strCliNom,
                                strOpeBai,
                                strCodVen: String;
                                intSeqCon: integer):Boolean;

  End;

implementation

{ TBaixaDuplicataComCredito }

constructor TBaixaDuplicataComCredito.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TBaixaDuplicataComCredito.Destroy;
begin
  inherited;
end;

function TBaixaDuplicataComCredito.fBaixaDuplicatas(strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strCodCli,
                                strCliNom,
                                strOpeBai,
                                strCodVen: String;
                                intSeqCon: integer): Boolean;
Var
  fltCredUtilizados: Double;
  fltTotCadRec: Double;
  fltTotCreditos: Double;
  strValCnfNfeCom: String;
Begin
  Result := True;

  try
    fltRecebido    := 0;
    qryAux         := fCriaQuery(nil);
    stlDupCreditos := TStringList.Create;

    strPorBai := fCfgSis('PORBAC');
    strCtaBai := fCfgSis('CTABAC');
    strHisBai := fCfgSis('HISBAC');

    If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTABAC'))) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Baixa automática de créditos no faturamento de pedidos de venda pela expedição - Plano de contas para baixa do crédito está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If fEmptyStr(fRetNomPortador(fCfgSis('PORBAC'))) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Baixa automática de créditos no faturamento de pedidos de venda pela expedição - Portador para baixa do crédito está vazia ou preenchida incorretamente, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If fEmptyStr(fCfgSis('HISBAC')) Then
    Begin
      fRollBack;
      fMensagem('', 'A configuração Baixa automática de créditos no faturamento de pedidos de venda pela expedição - Histórico para baixa do crédito está vazia, corrija!', ['&Ok']);
      Result := False;
      Exit;
    End;

    fltTotCreditos := fDuplicatasCredito(strCodCli);

    If fltTotCreditos > 0 Then
    Begin
      fltTotCadRec := fCampoTabela('SUM(CTR_VALDUP)', 'CADREC', ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI'],
                                                                [strNumDoc,    strEspDoc,    strCodEmp,     strCodCli]);

      fltCredUtilizados := Min(fltTotCreditos, fltTotCadRec);

      fltRecebido := fltCredUtilizados;

      Result := fBaixaReceber(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOpeBai, intSeqCon);

      If Result then
        Result := TFatVenda.fBaixaDuplicatasCredito(VS_Date,
                                                    strCodEmp,
                                                    strCodCli,
                                                    strCliNom,
                                                    strOpeBai,
                                                    strCodVen,
                                                    strPorBai,
                                                    'N',
                                                    '',
                                                    '',
                                                    fltCredUtilizados,
                                                    stlDupCreditos,
                                                    false,
                                                    false,
                                                    intSeqCon,
                                                    Self.Name,
                                                    '',
                                                    '',
                                                    strPorBai,
                                                    strCtaBai,
                                                    strHisBai);
      If Result then
      Begin
        strValCnfNfeCom := 'Utilização de crédito no valor de R$ '+ FormatFloat('#,##0.00', fltCredUtilizados) ;
        fAtualizaCnfNfeMovNotObs(strNumDoc, strEspDoc, strCodEmp, strValCnfNfeCom, '');
      End;

    End;
  Finally
    FreeAndNil(stlDupCreditos);
    FreeAndNil(qryAux);
  End;
End;

function TBaixaDuplicataComCredito.fBaixaReceber(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOpeBai: string; intSeqCon: integer): Boolean;
  var strSql: String;
      qryDuplicatas: TUniQuery;
  Begin
    Result := true;

    qryDuplicatas := fCriaQuery(nil);
    try
      qryDuplicatas.Close;
      qryDuplicatas.SQL.Clear;
      strSql := '';
      strSql := strSql + 'SELECT * FROM CADREC       ';
      strSql := strSql + 'WHERE CTR_NUMDUP = :NUMDUP ';
      strSql := strSql + '  AND CTR_ESPDOC = :ESPDOC ';
      strSql := strSql + '  AND CTR_CODEMP = :CODEMP ';
      strSql := strSql + '  AND CTR_CODCLI = :CODCLI ';
      strSql := strSql + '  AND ROUND(ABS(CTR_VALDUP), 2) <> 0.00 ';
      strSql := strSql + 'ORDER BY CTR_PARCEL        ';
      qryDuplicatas.SQL.Add(strSql);
      qryDuplicatas.ParamByName('NUMDUP').AsString := strNumDoc;
      qryDuplicatas.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDuplicatas.ParamByName('CODEMP').AsString := strCodEmp;
      qryDuplicatas.ParamByName('CODCLI').AsString := strCodCli;
      qryDuplicatas.Open;

      While not qryDuplicatas.eof do
      Begin
        If fFormataFloat(fltRecebido, 2) = 0.00 Then
        Begin
          Break;
        End;

        If (fFormataFloat(fltRecebido, 2) >= fFormataFloat(Abs(qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat), 2)) Then
        Begin
          If (Result) Then
            Result := fEfetuarBaixaTotal(qryDuplicatas, strCodEmp, strOpeBai, intSeqCon);
        End
        Else
        Begin
          if (Result) then
            Result := fEfetuarBaixaParcial(qryDuplicatas, strCodEmp, strOpeBai, intSeqCon);
        End;

        qryDuplicatas.Next;
      End;
    Finally
      FreeAndNil(qryDuplicatas);
    End;

  End;

function TBaixaDuplicataComCredito.fDuplicatasCredito(strCodCli: string): Double;
  var strSql: String;
      fltCreditos: Double;
  Begin
    fltCreditos := 0;
    try
      qryAux.Close;
      qryAux.SQL.Clear;
      strSql := '';
      strSql := strSql + 'SELECT * FROM CADREC       ';
      strSql := strSql + 'WHERE CTR_DTAREC IS NULL   ';
      strSql := strSql + '  AND CTR_VALDUP < 0.0     ';
      strSql := strSql + '  AND CTR_CODCLI = :CODCLI ';
      strSql := strSql + 'ORDER BY CTR_VALDUP DESC   ';
      qryAux.SQL.Add(strSql);
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;

      While not qryAux.eof do
      Begin
        fltCreditos := fltCreditos + qryAux.FieldByName('CTR_VALDUP').AsFloat;
        stlDupCreditos.Add( qryAux.FieldByName('AUTOINCREM').AsString );
        qryAux.Next;
      End;
      qryAux.First;
    Finally
      Result := fltCreditos * -1;
    End;

  End;

function TBaixaDuplicataComCredito.fEfetuarBaixaParcial(qryDuplicatas: TUniQuery; strCodEmp, strOpeBai: string; intSeqCon: integer): boolean;
begin
  Result := fBaixaParcial(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                          qryDuplicatas.FieldByName('CTR_PARCEL').AsString,
                          qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                          qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                          qryDuplicatas.FieldByName('CTR_CODCLI').AsString,
                          fltRecebido,
                          0.0,
                          0.0,
                          VS_Date,
                          qryDuplicatas.FieldByName('CTR_DTAVEN').AsDateTime,
                          strPorBai,
                          strHisBai,
                          strCtaBai,
                          strOpeBai,
                          '',
                          qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                          qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat-fltRecebido,
                          0,//fltValCqP,
                          0,//fltValCqV,
                          fltRecebido,//fltValDin,
                          0,//fltValCar,
                          0,//fltValOrd,
                          0,//fltValFin,
                          0,
                          0,
                          False,
                          False,
                          True,
                          False,
                          False,
                          False,
                          intSeqBai,
                          strAutIncBaixaParcial,
                          intSeqCon,
                          0,0,0,0,0,0,
                          0,
                          fltRecebido,
                          0,
                          1.0000000,
                          0,
                          0,
                          qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                          'N',
                          strCodEmp,
                          fGetValOriDuplicata(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                                              qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                                              qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                                              qryDuplicatas.FieldByName('CTR_PARCEL').AsString,
                                              qryDuplicatas.FieldByName('CTR_CODCLI').AsString),
                          '',
                          '');

  If (Result) Then
  Begin
    pGravaLogCtr(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                 qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                 qryDuplicatas.FieldByName('CTR_CODCLI').AsString,
                 qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                 qryDuplicatas.FieldByName('CTR_PARCEL').AsString, intSeqBai,
                 'BAIXA PARCIAL - AUTOMÁTICA', 'untBaixaDuplicataComCredito');

    pGravaLogCtr(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                 qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                 qryDuplicatas.FieldByName('CTR_CODCLI').AsString,
                 qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                 qryDuplicatas.FieldByName('CTR_PARCEL').AsString, 0,
                 'ALTERAÇÃO DE BAIXA - AUTOMÁTICA', 'untBaixaDuplicataComCredito');
  End;

  If (Result) Then
    fltRecebido := 0;
end;

function TBaixaDuplicataComCredito.fEfetuarBaixaTotal(qryDuplicatas: TUniQuery; strCodEmp, strOpeBai: string; intSeqCon: integer): boolean;
begin
  Result := fBaixaTotal(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                        qryDuplicatas.FieldByName('CTR_PARCEL').AsString,
                        qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                        qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                        qryDuplicatas.FieldByName('CTR_CODCLI').AsString,
                        qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                        qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                        0.0,
                        0.0,
                        0,//fltValCqP,
                        0,//fltValCqV,
                        qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat,//fltValDin,
                        0,//fltValCar,
                        0,//fltValOrd,
                        0,//fltValFin,
                        VS_Date,
                        '',
                        strHisBai,
                        strCtaBai,
                        strPorBai,
                        strOpeBai,
                        0,
                        False,
                        False,
                        True,
                        False,
                        False,
                        False,
                        0,
                        intSeqCon,
                        0,
                        'N',
                        strCodEmp,
                        '',
                        '');

  If (Result) Then
    pGravaLogCtr(qryDuplicatas.FieldByName('CTR_NUMDUP').AsString,
                 qryDuplicatas.FieldByName('CTR_ESPDOC').AsString,
                 qryDuplicatas.FieldByName('CTR_CODCLI').AsString,
                 qryDuplicatas.FieldByName('CTR_CODEMP').AsString,
                 qryDuplicatas.FieldByName('CTR_PARCEL').AsString, 0,
                 'BAIXA TOTAL - AUTOMÁTICA', 'untBaixaDuplicataComCredito');

  If (Result) Then
    fltRecebido := fltRecebido - qryDuplicatas.FieldByName('CTR_VALDUP').AsFloat;
end;

end.
