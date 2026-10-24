unit untAdiantamentoClienteGenerico;

interface

uses
  Classes, SysUtils, StrUtils,
 {$IFDEF LINUX}
   {$I '..\..\..\core\services.core.uses.inc'},
 {$ELSE }
  untFuncoesSimples,
  Uni,
 {$ENDIF LINUX}
  untTypesSistema,
  System.Variants,
  Math;

type
  TAdiantamentoGenerico = class
    private
      class function fCalcularValorModalidadesAdiantamento(dadosAdiantamento: TDadosAdiantamento): TTotaisAdiantamento;
      class function fCalcularValorModalidadesDocumentos(dadosAdiantamento: TDadosAdiantamento): TArrTotaisAdiantamento;

      class procedure pAplicaDiferenca(Var fltDif, fltVal: Double; const fltMax: Double);
      class function fCalcValorModalidade(fltTotFpg: Double; fltFator: Double): Double;
      class function fInformouMaisDeUmaModalidade(const arrModDoc: TArrTotaisAdiantamento) : Boolean;
      class procedure pGravarRegistroDeAdiantamento(documento: TDocAdiantamento; dadosAdiantamento: TDadosAdiantamento; ATotaisAdiantamento: TTotaisAdiantamento; const blnValidarPortadorOrdemPagto : Boolean; Var strIncAdt : String);
      class procedure pGravarRegistroDeAdiantamentoPorModalidade(documento: TDocAdiantamento; dadosAdiantamento: TDadosAdiantamento; totaisAdiantamento : TTotaisAdiantamento; Var strIncAdt : String);
      class function fAddTotAdtDinheiro(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtChequeVista(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtChequePrazo(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtCartao(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtOrdemPagamento(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtFinanciamento(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fAddTotAdtCredito(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
      class function fRetornaDEAMRC: String ;
    public
      class function fGravaAdiantamentoCliente(dadosAdiantamento: TDadosAdiantamento): Boolean;
      class function fPedidoTemBoletoAdiantamento(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
      class function fRetornaValorBoletosAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaValorBoletosAdiantamentoJaEnviados(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaValorBoletosAdiantamentoJaImpressos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Double;
      class function fRetornaUltimaParcelaBoletosAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
      class procedure pAtualizaValorBoletosAdiantamentoDoPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
      class function fLiberaPedidoRetiraExpedicaoImpressaoSeparacaoMedianteAdiantamento(dadosAdiantamento: TDadosAdiantamento): Boolean;
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

class function TAdiantamentoGenerico.fRetornaDEAMRC: String;
begin
  Result := 'N' ;
  if not fCfgSisExist('DEAMRC', VS_strCodEmp) then
    Exit ;

  Result := fCfgSis('DEAMRC', varString) ;
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
begin
  TotModRec := fCalcularValorModalidadesAdiantamento(dadosAdiantamento);

  FillChar(TotLanc, SizeOf(TotLanc), #0);

  SetLength(Result, Length(dadosAdiantamento.documentos));

  For I := 0 To Length(dadosAdiantamento.documentos) -1 Do
  Begin
    documento := dadosAdiantamento.documentos[I];

    FillChar(Result[I], SizeOf(Result[I]), #0);

    Result[I].fltValLan := documento.fltValLan;

    fltFator := documento.fltValLan / dadosAdiantamento.fltValLan;

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

class function TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento: TDadosAdiantamento): Boolean;
  Var
    I: Integer;
    documento: TDocAdiantamento;
    arrModDoc: TArrTotaisAdiantamento;
    blnDeveDesmembrarPorModalidade : Boolean;
    strIncAdt : String;
    fltFatorJuros : Double;
begin
  If fEmptyStr(dadosAdiantamento.strEstorn) Then
    dadosAdiantamento.strEstorn := 'N';

  arrModDoc := fCalcularValorModalidadesDocumentos(dadosAdiantamento);

  blnDeveDesmembrarPorModalidade := (fRetornaDEAMRC = 'S') And (TAdiantamentoGenerico.fInformouMaisDeUmaModalidade(arrModDoc));

  For I := 0 To Length(dadosAdiantamento.documentos) -1 Do
  Begin
    documento := dadosAdiantamento.documentos[I];
    If (blnDeveDesmembrarPorModalidade) Then
    Begin
      fltFatorJuros := arrModDoc[I].fltValJur / arrModDoc[I].fltValLan;
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtDinheiro(arrModDoc[I].fltValDin, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtChequeVista(arrModDoc[I].fltValChV, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtChequePrazo(arrModDoc[I].fltValChP, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtCartao(arrModDoc[I].fltValCar, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtOrdemPagamento(arrModDoc[I].fltValOrd, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtFinanciamento(arrModDoc[I].fltValFin, fltFatorJuros), strIncAdt);
      pGravarRegistroDeAdiantamentoPorModalidade(documento, dadosAdiantamento, fAddTotAdtCredito(arrModDoc[I].fltValCre, fltFatorJuros), strIncAdt);
      dadosAdiantamento.documentos[I].strIncAdt := strIncAdt;
    End
    Else
    Begin
      pGravarRegistroDeAdiantamento(documento, dadosAdiantamento, arrModDoc[I], False, strIncAdt);
      dadosAdiantamento.documentos[I].strIncAdt := strIncAdt;
    End;
  End;

  Result := True;
end;

class function TAdiantamentoGenerico.fInformouMaisDeUmaModalidade(const arrModDoc: TArrTotaisAdiantamento) : Boolean;
  Var
    intCountMod : Integer;
    totaisAdiantamento : TTotaisAdiantamento;
begin
  Result := False;
  For totaisAdiantamento In arrModDoc Do
  Begin
    intCountMod := 0;
    If (totaisAdiantamento.fltValDin > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValChV > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValChP > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValCar > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValOrd > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValFin > 0) Then Inc(intCountMod);
    If (totaisAdiantamento.fltValCre > 0) Then Inc(intCountMod);
    Result := (intCountMod > 1);
    If (Result) Then
      Break;
  End;
end;

class function TAdiantamentoGenerico.fLiberaPedidoRetiraExpedicaoImpressaoSeparacaoMedianteAdiantamento(
  dadosAdiantamento: TDadosAdiantamento): Boolean;
  Var
    qryPedidoRetiraExpedicao: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    documento: TDocAdiantamento;
begin
  qryPedidoRetiraExpedicao := fCriaQuery;

  try
    Result := False;

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
    {$IFNDEF LINUX}
    FreeAndNil(qryPedidoRetiraExpedicao);
    {$ENDIF LINUX}
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
    qryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
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
    {$IFNDEF LINUX}
    FreeAndNil(qryUpdate);
    {$ENDIF LINUX}
  End;
end;

class procedure TAdiantamentoGenerico.pGravarRegistroDeAdiantamento(documento: TDocAdiantamento; dadosAdiantamento: TDadosAdiantamento; ATotaisAdiantamento: TTotaisAdiantamento; const blnValidarPortadorOrdemPagto : Boolean; Var strIncAdt : String);
  Var
    qryAdtCli: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  const
    strRESUMO_DE_CAIXA_NAO = '0';
    strRESUMO_DE_CAIXA_SIM = '1';
begin
  qryAdtCli := fCriaQuery;
  Try
    qryAdtCli.Close;
    qryAdtCli.SQL.Clear;
    qryAdtCli.SQL.Add('SELECT * FROM ADTCLI WHERE FALSE');
    qryAdtCli.Open;

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

    qryAdtCli.FieldByName('ADT_VALLAN').AsFloat    := ATotaisAdiantamento.fltValLan;
    qryAdtCli.FieldByName('ADT_VALDIN').AsFloat    := ATotaisAdiantamento.fltValDin;
    qryAdtCli.FieldByName('ADT_VALCHV').AsFloat    := ATotaisAdiantamento.fltValChV;
    qryAdtCli.FieldByName('ADT_VALCHP').AsFloat    := ATotaisAdiantamento.fltValChP;
    qryAdtCli.FieldByName('ADT_VALCAR').AsFloat    := ATotaisAdiantamento.fltValCar;
    qryAdtCli.FieldByName('ADT_VALORD').AsFloat    := ATotaisAdiantamento.fltValOrd;
    qryAdtCli.FieldByName('ADT_VALFIN').AsFloat    := ATotaisAdiantamento.fltValFin;
    qryAdtCli.FieldByName('ADT_VALCRE').AsFloat    := ATotaisAdiantamento.fltValCre;
    qryAdtCli.FieldByName('ADT_VALJUR').AsFloat    := ATotaisAdiantamento.fltValJur;

    If (blnValidarPortadorOrdemPagto) And (fFormataFloat(ATotaisAdiantamento.fltValOrd, 2) > 0) Then
    Begin
      If Not fEmptyStr(dadosAdiantamento.strCodPorOrdPagto) Then
        qryAdtCli.FieldByName('ADT_CODPOR').AsString := dadosAdiantamento.strCodPorOrdPagto
      Else If Not fEmptyStr(dadosAdiantamento.strCodPor) Then
        qryAdtCli.FieldByName('ADT_CODPOR').AsString := dadosAdiantamento.strCodPor;
    End
    Else
    Begin
      If Not fEmptyStr(dadosAdiantamento.strCodPor) Then
        qryAdtCli.FieldByName('ADT_CODPOR').AsString := dadosAdiantamento.strCodPor;
    End;

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

    qryAdtCli.FieldByName('ADT_ADTORI').AsString := qryAdtCli.FieldByName('AUTOINCREM').AsString;
    strIncAdt := qryAdtCli.FieldByName('AUTOINCREM').AsString;

    Try
      if (dadosAdiantamento.dtaDtaban <= 0) and dadosAdiantamento.RecebidoPorPix then
      begin
        if dadosAdiantamento.dtaDtaLan > 0 then
        begin

          dadosAdiantamento.dtaDtaban := dadosAdiantamento.dtaDtaLan;
          If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [dadosAdiantamento.strCodPor]) = 'S' Then
            dadosAdiantamento.dtaDtaban := fAcertaDataParaDiaUtil(dadosAdiantamento.dtaDtaLan);
        end;
      end;

      If (dadosAdiantamento.dtaDtaban > 0) Then
        qryAdtCli.FieldByName('ADT_DTABAN').Value := dadosAdiantamento.dtaDtaban;
    Except
      //se não preencher o campo data no record com algum valor chega aqui com lixo memoria
    End;

    If fEmptyStr(dadosAdiantamento.strSeqBan) Then
      qryAdtCli.FieldByName('ADT_SEQBAN').Value := Null
    Else
      qryAdtCli.FieldByName('ADT_SEQBAN').AsString := dadosAdiantamento.strSeqBan;

    qryAdtCli.Post;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(qryAdtCli);
    {$ENDIF LINUX}
  End;
end;

class procedure TAdiantamentoGenerico.pGravarRegistroDeAdiantamentoPorModalidade(documento: TDocAdiantamento; dadosAdiantamento: TDadosAdiantamento; totaisAdiantamento : TTotaisAdiantamento; Var strIncAdt : String);
begin
  If (fFormataFloat(totaisAdiantamento.fltValLan, 2) <= 0) Then
    Exit;
  pGravarRegistroDeAdiantamento(documento, dadosAdiantamento, totaisAdiantamento, True, strIncAdt);
end;

class function TAdiantamentoGenerico.fAddTotAdtDinheiro(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValDin := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtChequeVista(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValChV := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtChequePrazo(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValChP := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtCartao(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValCar := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtOrdemPagamento(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValOrd := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtFinanciamento(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValFin := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

class function TAdiantamentoGenerico.fAddTotAdtCredito(const AValorModalidade : Double; const AFatorJuros : Double): TTotaisAdiantamento;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.fltValCre := AValorModalidade;
  Result.fltValLan := AValorModalidade;
  Result.fltValJur := fFormataFloat(AValorModalidade * AFatorJuros, 2);
end;

end.
