unit untAdiantamentoClienteGenerico;

interface

uses
  Classes, SysUtils, StrUtils, Math, Data.DB,
 {$IFDEF LINUX}
   {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
 {$ELSE }
  untFuncoesSimples,
 {$ENDIF LINUX}
  Uni, untTypesSistema;

type
  TAdiantamentoGenerico = class
    private
      class function fCalcularValorModalidadesAdiantamento(dadosAdiantamento: TDadosAdiantamento): TTotaisAdiantamento;

      class procedure pAplicaDiferenca(Var fltDif, fltVal: Double; const fltMax: Double);
      class function fCalcValorModalidade(fltTotFpg: Double; fltFator: Double): Double;

    public
      class function fAdiantamentoPossuiDebitos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; blnIgnorarEstornos: Boolean = True): Boolean;

      class function fCarregarAdiantamentos(strNumDoc, strEspDoc, strCodEmp,strCodCli: String; qryAdiantamentos: TUniQuery): Boolean;

      class function fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp: String): TTotaisAdiantamento;
      class function fGetCodPorAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
      class function fGetOpeLanAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
      class function fGetCodCtaAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class function fPermiteAlterarPedidoComAdiantamento: TPermissaoAlteracaoDePedidosQuePossuemAdiantamento;

      class function fGravaAdiantamentoCliente(dadosAdiantamento: TDadosAdiantamento): Boolean;

      class function fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

      class function fGetResCaiAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

      class function fRetornaValorBoletosAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaValorBoletosAdiantamentoJaEnviados(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaValorBoletosAdiantamentoJaImpressos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaUltimaParcelaBoletosAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class procedure pAtualizaValorBoletosAdiantamentoDoPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);

      class function fLiberaPedidoRetiraExpedicaoImpressaoSeparacaoMedianteAdiantamento(dadosAdiantamento: TDadosAdiantamento): Boolean;

      class function fCalcularValorModalidadesDocumentos(dadosAdiantamento: TDadosAdiantamento): TArrTotaisAdiantamento;

      class function AdiantamentoRecebidoPorPix(ANumeroDocumento,
                                                AEspecieDocumento,
                                                AEmpresaDocumento: String): Boolean;
  end;

implementation

const
  // Apos a baixa da duplicata o sistema zera o VALDUP e grava no VALREC, por isso precisa somar estes dois campos.
  STR_VALOR_DUPLICATA = 'SUM(IFNULL(CTR_VALDUP,0) + IFNULL(CTR_VALREC,0))';

{ TAdiantamentoGenerico }

class function TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
begin
  If Not fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp) Then
    Exit(0.00);
  Result := fCampoTabela(STR_VALOR_DUPLICATA, 'CADREC',
                        ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_ADTCLI'],
                        [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'S']);
end;

class function TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaEnviados(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
begin
  If Not fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp) Then
    Exit(0.00);
  Result := fCampoTabela(STR_VALOR_DUPLICATA, 'CADREC',
                        ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_ADTCLI',
                         'IF(CTR_BCOENV IS NULL, "N", "S")'],
                        [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'S', 'S']);
end;

class function TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaImpressos(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
begin
  If Not fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp) Then
    Exit(0.00);
  Result := fCampoTabela(STR_VALOR_DUPLICATA, 'CADREC',
                        ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_ADTCLI',
                         'IF(CTR_NOSNUM IS NULL, "N", "S")'],
                        [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'S', 'S']);
end;

class function TAdiantamentoGenerico.fRetornaUltimaParcelaBoletosAdiantamento(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
  Var
    strUltParCadRec: String;
    strUltParAdtCli: String;
begin
  If Not fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp) Then
    Exit('');

  strUltParCadRec := fCampoTabela('MAX(CTR_PARCEL)', 'CADREC',
                                 ['CTR_NUMDUP', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_ADTCLI'],
                                 [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'S']);

  strUltParAdtCli := fCampoTabela('MAX(ADT_PARCEL)', 'ADTCLI',
                                 ['ADT_NUMDOC', 'ADT_ESPDOC', 'ADT_CODEMP', 'ADT_CODCLI'],
                                 [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

  If strUltParCadRec > strUltParAdtCli Then
    Result := strUltParCadRec
  Else
    Result := strUltParAdtCli;
end;

class function TAdiantamentoGenerico.fAdiantamentoPossuiDebitos(strNumDoc,
  strEspDoc, strCodEmp, strCodCli: String;
  blnIgnorarEstornos: Boolean): Boolean;
  Var
    qryAdiantamentos: TUniQuery;
begin
  Try
    Result := False;

    qryAdiantamentos := fCriaQuery;

    If fCarregarAdiantamentos(strNumDoc, strEspDoc, strCodEmp, strCodCli, qryAdiantamentos) Then
    Begin
      qryAdiantamentos.First;

      While Not qryAdiantamentos.EOF Do
      Begin
        If (qryAdiantamentos.FieldByName('TIPLAN').AsString = 'D') Then
        Begin
          If blnIgnorarEstornos Then
            Result := qryAdiantamentos.FieldByName('ESTORN').AsString <> 'S'
          Else
            Result := True;
        End;

        If Result Then
          Break;

        qryAdiantamentos.Next;
      End;
    End;

  Finally
    FreeAndNil(qryAdiantamentos);
  End;
end;

class function TAdiantamentoGenerico.fCalcularValorModalidadesAdiantamento(
  dadosAdiantamento: TDadosAdiantamento): TTotaisAdiantamento;
  Var
    X: Integer;
    fltValDif: Double;
    fltFator : Double;
    fltTotRec: Double;
begin
  FillChar(Result, SizeOf(Result), #0);

  fltTotRec := dadosAdiantamento.fltValDin +
               dadosAdiantamento.fltValChV +
               dadosAdiantamento.fltValChP +
               dadosAdiantamento.fltValCar +
               dadosAdiantamento.fltValOrd +
               dadosAdiantamento.fltValFin +
               dadosAdiantamento.fltValCre;

  Result.fltValLan := dadosAdiantamento.fltValLan;

  fltFator := Result.fltValLan / fltTotRec;
  If Length(dadosAdiantamento.documentos) = 1 Then
    fltFator := 1;

  Result.fltValDin := fCalcValorModalidade(dadosAdiantamento.fltValDin, fltFator);
  Result.fltValChV := fCalcValorModalidade(dadosAdiantamento.fltValChV, fltFator);
  Result.fltValChP := fCalcValorModalidade(dadosAdiantamento.fltValChP, fltFator);
  Result.fltValCar := fCalcValorModalidade(dadosAdiantamento.fltValCar, fltFator);
  Result.fltValOrd := fCalcValorModalidade(dadosAdiantamento.fltValOrd, fltFator);
  Result.fltValFin := fCalcValorModalidade(dadosAdiantamento.fltValFin, fltFator);
  Result.fltValCre := fCalcValorModalidade(dadosAdiantamento.fltValCre, fltFator);
  Result.fltValJur := dadosAdiantamento.fltValJur;

  For X := 1 To 3 Do //Tres tentativas para aplicar a diferenca nas modalidades
  Begin
    fltValDif := Result.fltValLan -
                 Result.fltValDin -
                 Result.fltValChV -
                 Result.fltValChP -
                 Result.fltValCar -
                 Result.fltValOrd -
                 Result.fltValFin -
                 Result.fltValCre;

    fltValDif := fFormataFloat(fltValDif, 2);

    pAplicaDiferenca(fltValDif, Result.fltValDin, dadosAdiantamento.fltValDin);
    pAplicaDiferenca(fltValDif, Result.fltValChV, dadosAdiantamento.fltValChV);
    pAplicaDiferenca(fltValDif, Result.fltValChP, dadosAdiantamento.fltValChP);
    pAplicaDiferenca(fltValDif, Result.fltValCar, dadosAdiantamento.fltValCar);
    pAplicaDiferenca(fltValDif, Result.fltValOrd, dadosAdiantamento.fltValOrd);
    pAplicaDiferenca(fltValDif, Result.fltValFin, dadosAdiantamento.fltValFin);
    pAplicaDiferenca(fltValDif, Result.fltValCre, dadosAdiantamento.fltValCre);

    If fFormataFloat(fltValDif, 2) = 0.00 Then
      Break;
  End;

end;

class function TAdiantamentoGenerico.fCalcularValorModalidadesDocumentos(
  dadosAdiantamento: TDadosAdiantamento): TArrTotaisAdiantamento;
  Var
    I: Integer;
    X: Integer;
    fltFator: Double;
    fltValDif: Double;
    TotModRec: TTotaisAdiantamento;
    TotLanc: TTotaisAdiantamento;
    documento: TDocAdiantamento;

    LTotalDocumentos: Integer;
begin
  TotModRec := fCalcularValorModalidadesAdiantamento(dadosAdiantamento);

  FillChar(TotLanc, SizeOf(TotLanc), #0);

  SetLength(Result, Length(dadosAdiantamento.documentos));

  LTotalDocumentos := Length(dadosAdiantamento.documentos);

  For I := 0 To Length(dadosAdiantamento.documentos) -1 Do
  Begin
    documento := dadosAdiantamento.documentos[I];

    FillChar(Result[I], SizeOf(Result[I]), #0);

    Result[I].fltValLan := documento.fltValLan;

    fltFator := documento.fltValLan / dadosAdiantamento.fltValLan;
    If LTotalDocumentos = 1 Then
    Begin
      If documento.fltValLan > dadosAdiantamento.fltValLan Then
      Begin
        dadosAdiantamento.fltValLan := documento.fltValLan;
        TotModRec.fltValOrd := documento.fltValLan;
      End;
    End;

    If I = High(dadosAdiantamento.documentos) Then
    Begin
      Result[I].fltValDin := TotModRec.fltValDin - TotLanc.fltValDin;
      Result[I].fltValChV := TotModRec.fltValChV - TotLanc.fltValChV;
      Result[I].fltValChP := TotModRec.fltValChP - TotLanc.fltValChP;
      Result[I].fltValCar := TotModRec.fltValCar - TotLanc.fltValCar;
      Result[I].fltValOrd := TotModRec.fltValOrd - TotLanc.fltValOrd;
      Result[I].fltValFin := TotModRec.fltValFin - TotLanc.fltValFin;
      Result[I].fltValCre := TotModRec.fltValCre - TotLanc.fltValCre;
      Result[I].fltValJur := TotModRec.fltValJur - TotLanc.fltValJur;
    End
    Else
    Begin
      Result[I].fltValDin := fCalcValorModalidade(TotModRec.fltValDin, fltFator);
      Result[I].fltValChV := fCalcValorModalidade(TotModRec.fltValChV, fltFator);
      Result[I].fltValChP := fCalcValorModalidade(TotModRec.fltValChP, fltFator);
      Result[I].fltValCar := fCalcValorModalidade(TotModRec.fltValCar, fltFator);
      Result[I].fltValOrd := fCalcValorModalidade(TotModRec.fltValOrd, fltFator);
      Result[I].fltValFin := fCalcValorModalidade(TotModRec.fltValFin, fltFator);
      Result[I].fltValCre := fCalcValorModalidade(TotModRec.fltValCre, fltFator);
      Result[I].fltValJur := TotModRec.fltValJur;
    End;

    For X := 1 To 3 Do //Tres tentativas para aplicar a diferenca nas modalidades
    Begin
      fltValDif := Result[I].fltValLan -
                   Result[I].fltValDin -
                   Result[I].fltValChV -
                   Result[I].fltValChP -
                   Result[I].fltValCar -
                   Result[I].fltValOrd -
                   Result[I].fltValFin -
                   Result[I].fltValCre;

      fltValDif := fFormataFloat(fltValDif, 2);

      pAplicaDiferenca(fltValDif, Result[I].fltValDin, TotModRec.fltValDin);
      pAplicaDiferenca(fltValDif, Result[I].fltValChV, TotModRec.fltValChV);
      pAplicaDiferenca(fltValDif, Result[I].fltValChP, TotModRec.fltValChP);
      pAplicaDiferenca(fltValDif, Result[I].fltValCar, TotModRec.fltValCar);
      pAplicaDiferenca(fltValDif, Result[I].fltValOrd, TotModRec.fltValOrd);
      pAplicaDiferenca(fltValDif, Result[I].fltValFin, TotModRec.fltValFin);
      pAplicaDiferenca(fltValDif, Result[I].fltValCre, TotModRec.fltValCre);

      If fFormataFloat(fltValDif, 2) = 0.00 Then
        Break;
    End;

    TotLanc.fltValDin := TotLanc.fltValDin + Result[I].fltValDin;
    TotLanc.fltValChV := TotLanc.fltValChV + Result[I].fltValChV;
    TotLanc.fltValChP := TotLanc.fltValChP + Result[I].fltValChP;
    TotLanc.fltValCar := TotLanc.fltValCar + Result[I].fltValCar;
    TotLanc.fltValOrd := TotLanc.fltValOrd + Result[I].fltValOrd;
    TotLanc.fltValFin := TotLanc.fltValFin + Result[I].fltValFin;
    TotLanc.fltValCre := TotLanc.fltValCre + Result[I].fltValCre;
    TotLanc.fltValJur := TotLanc.fltValJur + Result[I].fltValJur;
  End;

end;

class function TAdiantamentoGenerico.fCalcValorModalidade(fltTotFpg,
  fltFator: Double): Double;
begin
  Result := Min(fltTotFpg, fFormataFloat(fltTotFpg * fltFator, 2));
end;

class function TAdiantamentoGenerico.fCarregarAdiantamentos(strNumDoc,
  strEspDoc, strCodEmp, strCodCli: String;
  qryAdiantamentos: TUniQuery): Boolean;
begin
  With qryAdiantamentos, SQL Do
  Begin
    Close;
    Clear;

    Add('SET @SALFIN := 0');
    ExecSQL;

    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE     ');
    Add('  ADT_NUMDOC AS NUMDOC, ');
    Add('  ADT_ESPDOC AS ESPDOC, ');
    Add('  ADT_CODEMP AS CODEMP, ');
    Add('  ADT_CODCLI AS CODCLI, ');
    Add('  ADT_EMPLAN AS EMPLAN, ');
    Add('  ADT_DTALAN AS DTALAN, ');
    Add('  ADT_HORLAN AS HORLAN, ');
    Add('  ADT_OPELAN AS OPELAN, ');
    Add('  ADT_DESCRI AS DESCRI, ');
    Add('  ADT_SEQCON AS SEQCON, ');
    Add('  ADT_TIPLAN AS TIPLAN, ');
    Add('  ADT_ESTORN AS ESTORN, ');
    Add('  ADT_ORIGEM AS ORIGEM, ');
    Add('  IF(ADT_VALDIN = 0, NULL, ADT_VALDIN) AS VALDIN, ');
    Add('  IF(ADT_VALCHV = 0, NULL, ADT_VALCHV) AS VALCHV, ');
    Add('  IF(ADT_VALCHP = 0, NULL, ADT_VALCHP) AS VALCHP, ');
    Add('  IF(ADT_VALCAR = 0, NULL, ADT_VALCAR) AS VALCAR, ');
    Add('  IF(ADT_VALORD = 0, NULL, ADT_VALORD) AS VALORD, ');
    Add('  IF(ADT_VALFIN = 0, NULL, ADT_VALFIN) AS VALFIN, ');
    Add('  IF(ADT_VALCRE = 0, NULL, ADT_VALCRE) AS VALCRE, ');
    Add('  IF(ADT_VALLAN = 0, NULL, ADT_VALLAN) AS VALLAN, ');
    Add('  (@SALFIN := @SALFIN + IF(ADT_TIPLAN = "C", 1, -1) * ADT_VALLAN) AS SALFIN ');

    Add('FROM ');
    Add('  ADTCLI ');
    Add('WHERE    ');
    Add('  ADT_NUMDOC = :NUMDOC AND ');
    Add('  ADT_ESPDOC = :ESPDOC AND ');

    If Not fEmptyStr(strCodCli) Then
      Add('  ADT_CODCLI = :CODCLI AND ');

    Add('  ADT_CODEMP = :CODEMP ');
    Add('ORDER BY ');
    Add('  ADT_DTALAN, ');
    Add('  ADT_HORLAN  ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli) Then
      ParambyName('CODCLI').AsString := strCodCli;

    Open;

    Result := Not IsEmpty;
  End;
end;

class function TAdiantamentoGenerico.fGetCodPorAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_CODPOR', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli]);
end;

class function TAdiantamentoGenerico.fGetOpeLanAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_OPELAN', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI','ADT_TIPLAN'], [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'C']);
end;

class function TAdiantamentoGenerico.fGetCodCtaAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_CODCTA', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli]);
end;

class function TAdiantamentoGenerico.fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp: String): TTotaisAdiantamento;
  Var
    qryGen: TUniQuery;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fEmptyStr(strNumDoc) Then
    Exit;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) AS VALLAN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALDIN, -ADT_VALDIN)) AS VALDIN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHV, -ADT_VALCHV)) AS VALCHV, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHP, -ADT_VALCHP)) AS VALCHP, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR)) AS VALCAR, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALORD, -ADT_VALORD)) AS VALORD, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALFIN, -ADT_VALFIN)) AS VALFIN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCRE, -ADT_VALCRE)) AS VALCRE, ');
    Add('  COUNT(*) AS TOTLAN ');
    Add('FROM ');
    Add('  ADTCLI ');
    Add('WHERE ');
    Add('  ADT_NUMDOC = :NUMDOC AND ');
    Add('  ADT_ESPDOC = :ESPDOC AND ');
    Add('  ADT_CODEMP = :CODEMP     ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result.fltValLan := FieldByName('VALLAN').AsFloat;
    Result.fltValDin := FieldByName('VALDIN').AsFloat;
    Result.fltValChV := FieldByName('VALCHV').AsFloat;
    Result.fltValChP := FieldByName('VALCHP').AsFloat;
    Result.fltValCar := FieldByName('VALCAR').AsFloat;
    Result.fltValOrd := FieldByName('VALORD').AsFloat;
    Result.fltValFin := FieldByName('VALFIN').AsFloat;
    Result.fltValCre := FieldByName('VALCRE').AsFloat;
    Result.blnExiAdt := (FieldByName('TOTLAN').AsInteger > 0);

  End;

  FreeAndNil(qryGen);
end;

class function TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento: TDadosAdiantamento): Boolean;
  Var
    I: Integer;
    qryAdtCli: TUniQuery;
    documento: TDocAdiantamento;
    arrModDoc: TArrTotaisAdiantamento;
  const
    strRESUMO_DE_CAIXA_NAO = '0';
    strRESUMO_DE_CAIXA_SIM = '1';
begin
  qryAdtCli := fCriaQuery;

  qryAdtCli.Close;
  qryAdtCli.SQL.Clear;
  qryAdtCli.SQL.Add('SELECT * FROM ADTCLI WHERE FALSE');
  qryAdtCli.Open;

  If fEmptyStr(dadosAdiantamento.strEstorn) Then
    dadosAdiantamento.strEstorn := 'N';

  arrModDoc := fCalcularValorModalidadesDocumentos(dadosAdiantamento);

  For I := 0 To Length(dadosAdiantamento.documentos) -1 Do
  Begin
    documento := dadosAdiantamento.documentos[I];

    qryAdtCli.Append;

    qryAdtCli.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ADTCLI', VS_strCodEmp);
    qryAdtCli.FieldByName('ADT_NUMDOC').AsString   := documento.strNumDoc;
    qryAdtCli.FieldByName('ADT_ESPDOC').AsString   := documento.strEspDoc;
    qryAdtCli.FieldByName('ADT_CODEMP').AsString   := documento.strCodEmp;
    qryAdtCli.FieldByName('ADT_CODCLI').AsString   := documento.strCodCli;

    qryAdtCli.FieldByName('ADT_DTALAN').AsDateTime := dadosAdiantamento.dtaDtaLan;
    qryAdtCli.FieldByName('ADT_HORLAN').AsDateTime := dadosAdiantamento.horHorLan;
    qryAdtCli.FieldByName('ADT_EMPLAN').AsString   := dadosAdiantamento.strEmpLan;
    qryAdtCli.FieldByName('ADT_OPELAN').AsString   := dadosAdiantamento.strOpeLan;
    qryAdtCli.FieldByName('ADT_TIPLAN').AsString   := dadosAdiantamento.strTipLan;
    qryAdtCli.FieldByName('ADT_DESCRI').AsString   := dadosAdiantamento.strDescri;
    qryAdtCli.FieldByName('ADT_ESTORN').AsString   := dadosAdiantamento.strEstorn;
    qryAdtCli.FieldByName('ADT_SEQCON').AsInteger  := dadosAdiantamento.intSeqCon;
    qryAdtCli.FieldByName('ADT_ORIGEM').AsString   := dadosAdiantamento.strOrigem;

    qryAdtCli.FieldByName('ADT_VALLAN').AsFloat    := arrModDoc[I].fltValLan;
    qryAdtCli.FieldByName('ADT_VALDIN').AsFloat    := arrModDoc[I].fltValDin;
    qryAdtCli.FieldByName('ADT_VALCHV').AsFloat    := arrModDoc[I].fltValChV;
    qryAdtCli.FieldByName('ADT_VALCHP').AsFloat    := arrModDoc[I].fltValChP;
    qryAdtCli.FieldByName('ADT_VALCAR').AsFloat    := arrModDoc[I].fltValCar;
    qryAdtCli.FieldByName('ADT_VALORD').AsFloat    := arrModDoc[I].fltValOrd;
    qryAdtCli.FieldByName('ADT_VALFIN').AsFloat    := arrModDoc[I].fltValFin;
    qryAdtCli.FieldByName('ADT_VALCRE').AsFloat    := arrModDoc[I].fltValCre;

    if qryAdtCli.FindField('ADT_VALJUR') <> nil then
      qryAdtCli.FieldByName('ADT_VALJUR').AsFloat  := arrModDoc[I].fltValJur;

    If Not fEmptyStr(dadosAdiantamento.strCodPor) Then
      qryAdtCli.FieldByName('ADT_CODPOR').AsString := dadosAdiantamento.strCodPor;

//    Req: 398699
//    If Not fEmptyStr(dadosAdiantamento.strPorTra) Then
//      qryAdtCli.FieldByName('ADT_CODPOR').AsString := dadosAdiantamento.strPorTra;

    If Not fEmptyStr(dadosAdiantamento.strCodCta) Then
      qryAdtCli.FieldByName('ADT_CODCTA').AsString := dadosAdiantamento.strCodCta;

    If Not fEmptyStr(dadosAdiantamento.strParcel) Then
      qryAdtCli.FieldByName('ADT_PARCEL').AsString := dadosAdiantamento.strParcel;

    If Not fEmptyStr(dadosAdiantamento.strNosNum) Then
      qryAdtCli.FieldByName('ADT_NOSNUM').AsString := dadosAdiantamento.strNosNum;

    If Not fEmptyStr(dadosAdiantamento.strDtaBol) Then
      qryAdtCli.FieldByName('ADT_DTABOL').AsDateTime := StrToDateDef(dadosAdiantamento.strDtaBol, 0);

    If Not fEmptyStr(dadosAdiantamento.strBcoBol) Then
      qryAdtCli.FieldByName('ADT_BCOBOL').AsString := dadosAdiantamento.strBcoBol;

    If Not fEmptyStr(dadosAdiantamento.strBcoEnv) Then
      qryAdtCli.FieldByName('ADT_BCOENV').AsString := dadosAdiantamento.strBcoEnv;

    If Not fEmptyStr(dadosAdiantamento.strDtaEnv) Then
      qryAdtCli.FieldByName('ADT_DTAENV').AsDateTime := StrToDateDef(dadosAdiantamento.strDtaEnv, 0);

    If Not fEmptyStr(dadosAdiantamento.strCartei) Then
      qryAdtCli.FieldByName('ADT_CARTEI').AsString := dadosAdiantamento.strCartei;

    If Not fEmptyStr(dadosAdiantamento.strLinDig) Then
      qryAdtCli.FieldByName('ADT_LINDIG').AsString := dadosAdiantamento.strLinDig;

    If Not fEmptyStr(dadosAdiantamento.strCodCed) Then
      qryAdtCli.FieldByName('ADT_CODCED').AsString := dadosAdiantamento.strCodCed;

    if (dadosAdiantamento.strOrigem = 'RCX') then
      qryAdtCli.FieldByName('ADT_RESCAI').AsString := strRESUMO_DE_CAIXA_SIM
    else
      qryAdtCli.FieldByName('ADT_RESCAI').AsString := strRESUMO_DE_CAIXA_NAO;

    qryAdtCli.FieldByName('ADT_RECPIX').AsString := 'N';
    If dadosAdiantamento.RecebidoPorPix Then
      qryAdtCli.FieldByName('ADT_RECPIX').AsString := 'S';

    if qryAdtCli.FindField('ADT_ADTORI') <> nil then
      qryAdtCli.FieldByName('ADT_ADTORI').AsString := qryAdtCli.FieldByName('AUTOINCREM').AsString;

    if dadosAdiantamento.RecebidoPorPix then
    begin
      qryAdtCli.FieldByName('ADT_DTABAN').AsDateTime := dadosAdiantamento.dtaDtaLan;
      If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [dadosAdiantamento.strCodPor]) = 'S' Then
        qryAdtCli.FieldByName('ADT_DTABAN').AsDateTime := fAcertaDataParaDiaUtil(dadosAdiantamento.dtaDtaLan);
    end;

    dadosAdiantamento.documentos[I].strIncAdt := qryAdtCli.FieldByName('AUTOINCREM').AsString;

    qryAdtCli.Post;
  End;

  FreeAndNil(qryAdtCli);

  Result := True;
end;

class function TAdiantamentoGenerico.fLiberaPedidoRetiraExpedicaoImpressaoSeparacaoMedianteAdiantamento(
  dadosAdiantamento: TDadosAdiantamento): Boolean;
  Var
    qryPedidoRetiraExpedicao: TUniQuery;
    documento: TDocAdiantamento;
begin
  qryPedidoRetiraExpedicao := fCriaQuery;

  try
    qryPedidoRetiraExpedicao.Close;
    qryPedidoRetiraExpedicao.SQL.Clear;
    qryPedidoRetiraExpedicao.SQL.Add('UPDATE FATDOR F');
    qryPedidoRetiraExpedicao.SQL.Add('INNER JOIN EXTDOR E');
    qryPedidoRetiraExpedicao.SQL.Add('ON(F.AUTOINCREM = E.FDO_SEQFDO)');
    qryPedidoRetiraExpedicao.SQL.Add('SET E.FDO_EXIBSE = "S" ');
    qryPedidoRetiraExpedicao.SQL.Add('WHERE F.FDO_NUMDOC = :NUMDOC');
    qryPedidoRetiraExpedicao.SQL.Add('AND F.FDO_ESPDOC = :ESPDOC');
    qryPedidoRetiraExpedicao.SQL.Add('AND F.FDO_CODEMP = :CODEMP');
    qryPedidoRetiraExpedicao.SQL.Add('AND F.FDO_CODCLI = :CODCLI');
    qryPedidoRetiraExpedicao.SQL.Add('AND F.FDO_ENTFUT = "N" ');
    qryPedidoRetiraExpedicao.SQL.Add('AND E.FDO_ENTRET = "R" ');
    qryPedidoRetiraExpedicao.SQL.Add('AND E.FDO_LOCRET = "E" ');
    qryPedidoRetiraExpedicao.SQL.Add('AND E.FDO_EXIBSE = "N" ');

    for documento in dadosAdiantamento.documentos do
    Begin
      qryPedidoRetiraExpedicao.Close;
      qryPedidoRetiraExpedicao.ParamByName('NUMDOC').AsString := documento.strNumDoc;
      qryPedidoRetiraExpedicao.ParamByName('ESPDOC').AsString := documento.strEspDoc;
      qryPedidoRetiraExpedicao.ParamByName('CODEMP').AsString := documento.strCodEmp;
      qryPedidoRetiraExpedicao.ParamByName('CODCLI').AsString := documento.strCodCli;
      qryPedidoRetiraExpedicao.ExecSQL;
    End;

    Result := True;
  finally
    FreeAndNil(qryPedidoRetiraExpedicao);
  end;
end;

class function TAdiantamentoGenerico.fPedidoTemBoletoAdiantamento(strNumDoc,
  strEspDoc, strCodEmp: String): Boolean;
begin
  Result := fCampoTabela('FGO_BOLADT',
     'FATGOR INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM',
    ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],
    [strNumDoc, strEspDoc, strCodEmp]) > 0;
end;

class function TAdiantamentoGenerico.fPermiteAlterarPedidoComAdiantamento: TPermissaoAlteracaoDePedidosQuePossuemAdiantamento;
var
  strALPDAD : String;
begin

  strALPDAD := fCfgSis('ALPDAD');

  If strALPDAD = papSimTodosOsCampos.GetValue Then
    Exit(papSimTodosOsCampos);

  If strALPDAD = papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo.GetValue Then
    Exit(papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo);

  If strALPDAD = papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos.GetValue Then
    Exit(papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos);

  Result := papNaoNenhumaInformacao;
end;

class procedure TAdiantamentoGenerico.pAplicaDiferenca(var fltDif,
  fltVal: Double; const fltMax: Double);
begin
  If (fltDif <> 0) And (fltVal <> 0) And (fltVal <> fltMax) Then
  Begin
    If fltVal + fltDif <= 0 Then
    Begin
      fltDif := fltDif - fltVal;
      fltVal := 0;
    End
    Else
    Begin
      fltVal := fltVal + fltDif;
      fltDif := 0;
    End;
    If fltVal > fltMax Then
      fltVal := fltMax;
  End;
end;

class procedure TAdiantamentoGenerico.pAtualizaValorBoletosAdiantamentoDoPedido(
  strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  Var
    strAutoincrem: String;
    qryUpdate: TUniQuery;
begin
  strAutoincrem := fCampoTabela('AUTOINCREM', 'FATGOR',
    ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
    [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

  qryUpdate := fCriaQuery();
  Try
    qryUpdate.SQL.Text := 'UPDATE EXTGOR ' +
                          'SET FGO_BOLADT = :BOLADT, ' +
                          '    FGO_BOLVEN = IF(:BOLADT <= 0, "N", FGO_BOLVEN) ' +
                          'WHERE FGO_SEQFGO = :AUTINC ';
    qryUpdate.ParamByName('AUTINC').AsString := strAutoincrem;
    qryUpdate.ParamByName('BOLADT').AsFloat  := fRetornaValorBoletosAdiantamento(
      strNumDoc, strEspDoc, strCodEmp, strCodCli);
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

class function TAdiantamentoGenerico.AdiantamentoRecebidoPorPix(ANumeroDocumento,
  AEspecieDocumento, AEmpresaDocumento: String): Boolean;
  Var
    LConsulta: TUNiQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT M.AUTOINCREM ' +
                          'FROM ADTCLI A ' +
                          'JOIN MOVPIX M ON M.MPX_SEQCON=A.ADT_SEQCON ' +
                          '             AND M.MPX_CODEMP=A.ADT_EMPLAN ' +
                          'WHERE A.ADT_NUMDOC=:NUMDOC ' +
                          '  AND A.ADT_ESPDOC=:ESPDOC ' +
                          '  AND A.ADT_CODEMP=:CODEMP ' +
                          '  AND ADT_TIPLAN="C" ' +
                          '  AND ADT_ESTORN="N" ' +
                          '  AND ADT_RECPIX="S" ';

    LConsulta.ParamByName('NUMDOC').AsString := ANumeroDocumento;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaDocumento;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TAdiantamentoGenerico.fGetResCaiAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
begin
  Result := fCampoTabela('ADT_RESCAI',
                         'ADTCLI',
                         ['ADT_NUMDOC',
                          'ADT_ESPDOC',
                          'ADT_CODEMP',
                          'ADT_CODCLI',
                          'ADT_TIPLAN',
                          'ADT_ESTORN'],
                         [strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          'C',
                          'N']) = '1';
end;

end.
