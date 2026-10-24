unit untTRestauraRemessa;

interface

uses System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
     Data.DB, untFuncAutBan, Uni, UniClientDataset, untTypesSistema;

Type
  TTipoData = (tdEnvio, tdVencimento, tdImpressao, tdCadastro);

Type
  TRestauraRemessa = Class(TComponent)
  Private
    FAutInc: String;
    FCodCli: String;
    FCodEmp: String;
    FEmpAce: String;
    FCodBco: String;
    FDataEV: TTipoData;
    FDtaIni: TDateTime;
    FDtaFin: TDateTime;

    FTotMar: Double;

    qryCadRec: TUniClientDataSet;

    FListaFiltros: TStringList;

    function getTotDup: Double;

    function RetornaSQLDuplicatas: String;
    function RetornaChavesDuplicatasSelecionadas: String;
  Public
    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; Override;

    procedure pDesmarcaTodos;
    procedure pMarcaTodos;

    procedure pDeleteSelecion;
    procedure pInsertSelecion;

    procedure pCarregaDados;
    procedure pCarregaDuplicata;
    procedure pLimparDados;
    procedure pRestauraDuplicatas;

    property strAutInc: String    Read FAutInc Write FAutInc;
    property strCodCli: String    Read FCodCli Write FCodCli;
    property strCodEmp: String    Read FCodEmp Write FCodEmp;
    property strCodBco: String    Read FCodBco Write FCodBco;
    property opcDataEV: TTipoData Read FDataEV Write FDataEV;
    property dtaDtaIni: TDateTime Read FDtaIni Write FDtaIni;
    property dtaDtaFin: TDateTime Read FDtaFin Write FDtaFin;
    property strEmpAce: String    Read FEmpAce Write FEmpAce;

    property fltTotDup: Double Read getTotDup;
    property fltTotMar: Double Read FTotMar;

    property qryRec: TUniClientDataset Read qryCadRec Write qryCadRec;

    property ListaFiltros: TStringList read FListaFiltros Write FListaFiltros;
  End;

implementation

{ TEstornoPagar }

uses untFuncoesSimples, untConstantes, untLogCtr,
     untAtualizaOcorrenciasCRM, untTypesCRM;

constructor TRestauraRemessa.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FDtaIni := 0;
  FDtaFin := 0;

  FTotMar := 0;

  qryCadRec := TUniCLientDataSet.Create(Owner);

  FListaFiltros := TStringList.Create;
end;

destructor TRestauraRemessa.Destroy;
begin
  qryCadRec.Close;
  FreeAndNil(qryCadRec);

  FreeAndNil(FListaFiltros);
  inherited;
end;

function TRestauraRemessa.getTotDup: Double;
  Var
    LprcScroll: TprcScroll;

    LRegistro: Integer;
begin
  Result := 0;

  If Not Assigned(qryCadRec) Then
    Exit;

  If qryCadRec.IsEmpty Then
    Exit;

  pDisableControls(qryCadRec, LprcScroll);

  LRegistro := qryCadRec.RecNo;

  qryCadRec.First;

  Try
    While Not qryCadRec.Eof Do
    Begin
      Result := fFormataFloat(Result + qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 2);

      qryCadRec.Next;
    End;
  Finally
    qryCadRec.RecNo := LRegistro;

    pEnableControls(qryCadRec, LprcScroll);
  End;
end;

procedure TRestauraRemessa.pCarregaDados;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := RetornaSQLDuplicatas;

    If FListaFiltros.Count > 0 Then
      LConsulta.SQL.Add('  AND ' + RetornaChavesDuplicatasSelecionadas)
    Else
    Begin
      If Not FEmpAce.IsEmpty Then
        LConsulta.SQL.Add('  AND CTR_CODEMP IN (' + fRetStrToSQLIn(FEmpAce) + ')')
      Else If Not FCodEmp.IsEmpty Then
      Begin
        LConsulta.SQL.Add('  AND CTR_CODEMP=:CODEMP');
        LConsulta.ParamByName('CODEMP').AsString := FCodEmp;
      End;

      If Not FCodCli.IsEmpty THen
      Begin
        LConsulta.SQL.Add('  AND CTR_CODCLI=:CODCLI');
        LConsulta.ParamByName('CODCLI').AsString := FCodCli;
      End;

      If Not FCodBco.IsEmpty Then
      Begin
        LConsulta.SQL.Add('  AND CTR_BCOENV=:BCOENV');
        LConsulta.ParamByName('BCOENV').AsString := FCodBco;
      End;

      If FDtaIni > 0 Then
      Begin
        Case FDataEV Of
          tdEnvio: LConsulta.SQL.Add('  AND CTR_DTAENV BETWEEN :DTAINI AND :DTAFIN');
          tdVencimento: LConsulta.SQL.Add('  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN');
          Else LConsulta.SQL.Add('  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN');
        End;

        LConsulta.ParamByName('DTAINI').AsDateTime := FDtaIni;
        LConsulta.ParamByName('DTAFIN').AsDateTime := FDtaFin;
      End;
    End;

    LConsulta.Open;

    qryCadRec := fCriaClientDatSet(LConsulta);
    qryCadRec.Open;
    qryCadRec.First;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);

    TFloatField(qryCadRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TRestauraRemessa.pCarregaDuplicata;
   Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := RetornaSQLDuplicatas +
                          ' AND AUTOINCREM=:AUTOIN ';

    LConsulta.ParamByName('AUTOIN').AsString := FAutInc;

    LConsulta.Open;

    qryCadRec := fCriaClientDatSet(LConsulta);
    qryCadRec.Open;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);

    TFloatField(qryCadRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TRestauraRemessa.pDeleteSelecion;
begin
  FTotMar := fFormataFloat(FTotMar - qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 2);

  qryCadRec.Edit;
  qryCadRec.FieldByName('CTR_MARDES').AsString := 'D';
  qryCadRec.Post;
end;

procedure TRestauraRemessa.pDesmarcaTodos;
begin
  FTotMar := 0;

  qryCadRec.First;

  Try
    While Not qryCadRec.Eof Do
    Begin
      qryCadRec.Edit;
      qryCadRec.FieldByName('CTR_MARDES').AsString := 'D';
      qryCadRec.Post;

      qryCadRec.Next;
    End;
  Finally
    qryCadRec.First;
  End;
end;

procedure TRestauraRemessa.pInsertSelecion;
begin
  FTotMar := fFormataFloat(FTotMar + qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 2);

  qryCadRec.Edit;
  qryCadRec.FieldByName('CTR_MARDES').AsString := 'M';
  qryCadRec.Post;
end;

procedure TRestauraRemessa.pLimparDados;
begin
  FCodCli := '';
  FCodEmp := '';
  FCodBco := '';
  FDataEV := tdEnvio;
  FDtaIni := 0;
  FDtaFin := 0;
  FTotMar := 0;

  If qryCadRec.Active Then
    qryCadRec.Close;
end;

procedure TRestauraRemessa.pMarcaTodos;
begin
  FTotMar := 0;

  qryCadRec.First;

  Try
    While Not qryCadRec.Eof Do
    Begin
      qryCadRec.Edit;
      qryCadRec.FieldByName('CTR_MARDES').AsString := 'M';
      qryCadRec.Post;

      FTotMar := fFormataFloat(FTotMar + qryCadRec.FieldByName('CTR_VALDUP').AsFloat, 2);

      qryCadRec.Next;
    End;
  Finally
    qryCadRec.First;
  End;
end;

procedure TRestauraRemessa.pRestauraDuplicatas;
  Var
    strSeqGeral: String;
    strCarteira: String;
    strEmpresaCarteira: String;

    LSQL: String;

    LprcScroll: TprcScroll;
Begin
  pDisableControls(qryCadRec, LprcScroll);

  Try
    fStartTransaction;

    qryCadRec.First;
    While Not qryCadRec.Eof Do
    Begin
      If Not qryCadRec.FieldByName('CTR_MARDES').AsString.Equals('M') THen
      Begin
        qryCadRec.Next;
        Continue;
      End;

      LSQL := 'UPDATE CADREC SET  ' +
              '   CTR_BCOENV = NULL, ' +
              '   CTR_DTAENV = NULL, ' +
              '   CTR_CTREME = NULL ';

      strCarteira        := LeftStr(qryCadRec.FieldByName('CTR_CARTEI').AsString,
                                    qryCadRec.FieldByName('CTR_CARTEI').AsString.Length - 4);
      strEmpresaCarteira := RightStr(qryCadRec.FieldByName('CTR_CARTEI').AsString, 3);

      if fGetBancoConfig(0, strCarteira, 'RESPONS', '', strEmpresaCarteira) = 'B' then
        LSQL := LSQL + ', CTR_CARTEI = "" '+
                       ', CTR_BCOBOL = NULL ';

      If (strCodBco = '033') Then
      Begin
        If (fGetBancoConfig(0, strCarteira, 'ENVNOSN', '', strEmpresaCarteira) = 'S') And
           (fGetBancoConfig(0, strCarteira, 'RESPONS', '', strEmpresaCarteira) = 'B') Then
          LSQL := LSQL + ', CTR_NOSNUM = NULL ' +
                         ', CTR_DTABOL = NULL ' +
                         ', CTR_LINDIG = NULL ';
      End;

      If (strCodBco = '021') and (fGetBancoConfig(0, strCarteira, 'RESPONS', '', strEmpresaCarteira) = 'B') Then
        LSQL := LSQL + ', CTR_NOSNUM = NULL ' +
                       ', CTR_DTABOL = NULL ';

      LSQL := LSQL + ' WHERE AUTOINCREM="' + qryCadRec.FieldByName('AUTOINCREM').AsString + '"';

      pGravaDelRemDet('CANCELAMENTO DE REMESSA BANCARIA',
                      qryCadRec.FieldByName('AUTOINCREM').AsString,
                      strSeqGeral);
      pGravaDelRemGer(strSeqGeral, 'CANCELAMENTO DE REMESSA BANCARIA');

      strSeqGeral := '';
      if fVerificaRetorno(qryCadRec.FieldByName('AUTOINCREM').AsString) then
      begin
        pGravaDelRetDet('CANCELAMENTO DE RETORNO BANCARIO UNTTRESTAURAREMESSA',
                        qryCadRec.FieldByName('AUTOINCREM').AsString,
                        strSeqGeral);
        pGravaDelRetGer(strSeqGeral, 'CANCELAMENTO DE RETORNO BANCARIO UNTTRESTAURAREMESSA');
      End;

      If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
      Begin
        TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                 qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                 qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                 qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                 qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                 strLoginUsuarioLogado,
                                                 fRetCgcCpf(qryCadRec.FieldByName('CTR_CODCLI').AsString),
                                                 afcRestauraRemessaBancaria);
      End;

      fExecutaSQL(LSQL, True);

      untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                            'RESTAURA REMESSA BANCÁRIA',
                            'frmFinDesmRemBanc');

      fExecutaSQL('DELETE FROM CADCBI ' +
                  'WHERE CBI_NUMDUP="' + qryCadRec.FieldByName('CTR_NUMDUP').AsString + '"' +
                  '  AND CBI_PARCEL="' + qryCadRec.FieldByName('CTR_PARCEL').AsString + '"' +
                  '  AND CBI_ESPDOC="' + qryCadRec.FieldByName('CTR_ESPDOC').AsString + '"' +
                  '  AND CBI_CODEMP="' + qryCadRec.FieldByName('CTR_CODEMP').AsString + '"' +
                  '  AND CBI_CODCLI="' + qryCadRec.FieldByName('CTR_CODCLI').AsString + '"', True);

      qryCadRec.Next;
    End;

    If fCommit Then
      pMensagemOk('Restauração efetuada com sucesso!');
  Except
    On E: ExceptionAutcom Do
    Begin
      fRollBack;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Erro ao tentar restaurar duplicata(s):' + #13 + E.Message, '[pEstornaDuplicataConjug]');
    End;
  End;

  pEnableControls(qryCadRec, LprcScroll);

end;

function TRestauraRemessa.RetornaChavesDuplicatasSelecionadas: String;
  Var
    LItem: String;

    LItemSeparado: TStringList;
begin
  Result := ' TRUE ';

  If FListaFiltros.Count = 0 THen
    Exit;

  LItemSeparado := TStringList.Create;
  LItemSeparado.StrictDelimiter := True;
  LItemSeparado.Delimiter := '-';

  Try
    Result := '(';

    For LItem In FListaFiltros Do
    Begin
      LItemSeparado.DelimitedText := LItem;

      Result := Result + '(CTR_NUMDUP="' + LItemSeparado[0] + '" AND ' +
                         ' CTR_PARCEL="' + LItemSeparado[1] + '" AND ' +
                         ' CTR_ESPDOC="' + LItemSeparado[2] + '" AND ' +
                         ' CTR_CODEMP="' + LItemSeparado[3] + '" AND ' +
                         ' CTR_CODCLI="' + LItemSeparado[4] + '" AND ' +
                         ' CTR_SEQBAI=0) OR ';
    End;

    Result := LeftStr(Result, Result.Length - 4) + ')';
  Finally
    LItemSeparado.Clear;
    FreeAndNil(LItemSeparado);
  End;
end;

function TRestauraRemessa.RetornaSQLDuplicatas: String;
begin
  Result := 'SELECT *, ' +
            '  "D" AS CTR_MARDES ' +
            'FROM CADREC ' +
            'WHERE CTR_DTAREC IS NULL ' +
            '  AND CTR_DTAENV IS NOT NULL ';
end;

end.
