unit untSeparacaoFina;

interface

uses classes, untConstantes, sysutils, strutils, UniClientDataSet, uni, Data.DB,
     untCdsItensLocalSeparacao;

Type
    TTipoDocumentoSeparacaoFina = (tdsPedido, tdsRomaneio);


    TSeparacaoFina = class
    private
      FTipoDocumento : TTipoDocumentoSeparacaoFina;
      FNumeroDocumento : String;
      FAutoincremLocalSeparacao : String;
      FCodigoBarrasSeparacao: String;
      FCodigoOperadorFinalizouConferencia: String;
      FCodigoOperadorFinalizouSeparacao: String;
      FFiltroTipoDocumento : String;

      qryExpedicaoAutcom : TUniQuery;
      FCodigoEmpresa: String;

      procedure setCodigoBarrasSeparacao(const Value: String);
      function getCodigoOperadorConferenciaColetor: String;
      function getCodigoOperadorSeparacaoColetor: String;
      procedure setNumeroDocumento(const Value: String);

    public
      procedure pMarcaSeparacaoImpressaColetor;
      procedure pLimpaSeparacaoStatus;
      procedure pLimpaConferenciaStatus;
      procedure pLimpaSeparacaoEConferenciaStatus;
      procedure pLimpaSeparacaoEConferenciaItensAlterados(cdsItensAlterados : TCdsItensLocalSeparacao);
      function fImprimeSeparacaoRomaneio : boolean;
      function fSeparacaoCompletaColetor: boolean;

      constructor Create(enuTipoDocumento : TTipoDocumentoSeparacaoFina; strCodEmp : String);
      destructor Destroy; override;

      property strCodigoBarrasSeparacao : String read FCodigoBarrasSeparacao write setCodigoBarrasSeparacao;
      property strNumeroDocumento : String read FNumeroDocumento write setNumeroDocumento;
      property strCodigoEmpresa : String read FCodigoEmpresa write FCodigoEmpresa;
      property strAutoincremLocalSeparacao: String read FAutoincremLocalSeparacao write FAutoincremLocalSeparacao;
      property strCodigoOperadorFinalizouSeparacao   : String read FCodigoOperadorFinalizouSeparacao   write FCodigoOperadorFinalizouSeparacao;
      property strCodigoOperadorFinalizouConferencia : String read FCodigoOperadorFinalizouConferencia write FCodigoOperadorFinalizouConferencia;
    end;

    function fTipoDocumentoSeparacaoFinaToString(enuTipoDocumento : TTipoDocumentoSeparacaoFina) : String;

implementation

uses untFuncoesSimples, untFuncFatImp, untTypesSistema, untFuncFatTypes;


constructor TSeparacaoFina.Create(enuTipoDocumento : TTipoDocumentoSeparacaoFina; strCodEmp : String);
begin
  FNumeroDocumento := '';
  FAutoincremLocalSeparacao := '';
  FCodigoBarrasSeparacao := '';
  FCodigoBarrasSeparacao := '';
  FCodigoOperadorFinalizouConferencia := '';
  FTipoDocumento := enuTipoDocumento;
  FCodigoEmpresa := strCodEmp;

  FFiltroTipoDocumento := fTipoDocumentoSeparacaoFinaToString(enuTipoDocumento);

  qryExpedicaoAutcom := fCriaQuery(nil);
  if FTipoDocumento = tdsRomaneio then
  begin
    qryExpedicaoAutcom.SQL.Add('SELECT                                                ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      qryExpedicaoAutcom.SQL.Add('IF(IFNULL(FDO_NUMLOT, "") = "", LS2.AUTOINCREM, LS1.AUTOINCREM) AS AUTOINCREM, ')
    else
      qryExpedicaoAutcom.SQL.Add('  CADLSE.AUTOINCREM,                                  ');

    qryExpedicaoAutcom.SQL.Add('  SUM(FDO_SEPEXP="N") AS QUANTIDADE_NAO_EXPEDIDA      ');
    qryExpedicaoAutcom.SQL.Add('FROM                                                  ');
    qryExpedicaoAutcom.SQL.Add('  ROMGERX                                             ');
    qryExpedicaoAutcom.SQL.Add('  INNER JOIN FATDOR ON FDO_NUMDOC = GER_NUMDOC        ');
    qryExpedicaoAutcom.SQL.Add('                   AND FDO_ESPDOC = GER_ESPDOC        ');
    qryExpedicaoAutcom.SQL.Add('                   AND FDO_CODEMP = GER_CODEMP        ');
    qryExpedicaoAutcom.SQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryExpedicaoAutcom.SQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE        ');
    qryExpedicaoAutcom.SQL.Add('                   AND ITE_CODEMP = GER_EMPROM        ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      qryExpedicaoAutcom.SQL.Add(' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FDO_CODITE AND LT.LOT_CODEMP = FDO_CODEMP AND LT.LOT_NUMLOT = FDO_NUMLOT ');
      qryExpedicaoAutcom.SQL.Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
      qryExpedicaoAutcom.SQL.Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = ITE_LOCFIS AND CL2.LOC_CODEMP = ITE_CODEMP ');
      qryExpedicaoAutcom.SQL.Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      qryExpedicaoAutcom.SQL.Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      qryExpedicaoAutcom.SQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE        ');

    qryExpedicaoAutcom.SQL.Add('WHERE GER_NUMROM = :NUMROM                            ');
    qryExpedicaoAutcom.SQL.Add('  AND GER_EMPROM = :CODEMP                            ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      qryExpedicaoAutcom.SQL.Add('GROUP BY  IF(IFNULL(FDO_NUMLOT, "") = "", LS2.AUTOINCREM, LS1.AUTOINCREM) ')
    else
      qryExpedicaoAutcom.SQL.Add('GROUP BY  CADLSE.AUTOINCREM;                          ');
  end;
end;

destructor TSeparacaoFina.Destroy;
begin
  FreeAndNil(qryExpedicaoAutcom);
  inherited;
end;


function TSeparacaoFina.fImprimeSeparacaoRomaneio : boolean;
  Var
    impPreRomaneio: TFatVendaImp;
    recSepara     : TDadosImpressaoVenda;
    qryLocaisSeparacao    : TUniQuery;

    Procedure pPreenchaMatItens(Var arrMatItens: TMatrizFechamento; strCodLse: String);
      Var
        i: Integer;
        qryAux: TUniQuery;
    Begin
      qryAux := fCriaQuery(Nil);
      SetLength(arrMatItens,0);

      With qryAux, SQL Do
      Begin
        Add('SELECT SQL_NO_CACHE          ');
        Add('  DISTINCT D.DET_CODITE      ');
        Add('FROM                         ');
        Add('  ROMDETX D                  ');
        Add('    INNER JOIN ITEGER G ON D.DET_CODITE = G.ITE_CODITE ');
        Add('WHERE                        ');
        Add('  D.DET_NUMROM = :NUMROM AND ');
        Add('  D.DET_SEPIMP = "N"     AND ');
        Add('  G.ITE_CODLSE = :CODLSE     ');
        Add('ORDER BY D.DET_CODITE        ');

        ParamByName('NUMROM').AsString := FNumeroDocumento;
        ParamByName('CODLSE').AsString := strCodLse;

        Open;
        First;
        While Not EOF Do
        Begin
          SetLength(arrMatItens, Length(arrMatItens) + 1);
          i := Length(arrMatItens) - 1;

          arrMatItens[i].strCodIte := FieldByName('DET_CODITE').AsString;
          Next;
        End;
      End;

      FreeAndNil(qryAux);
    End;

begin

  if FTipoDocumento <> tdsRomaneio then
    exit(false);

  qryLocaisSeparacao := fCriaQuery(Nil);
  result := false;
  try
    qryLocaisSeparacao.SQL.Add('SELECT                                                   ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      qryLocaisSeparacao.SQL.Add('IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) AS ITE_CODLSE, ');
      qryLocaisSeparacao.SQL.Add('IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSE_DESCRI, ');
    end
    else
    begin
      qryLocaisSeparacao.SQL.Add('  I.ITE_CODLSE,                                          ');
      qryLocaisSeparacao.SQL.Add('  L.LSE_DESCRI,                                          ');
    end;

    qryLocaisSeparacao.SQL.Add('  FDO_NUMDOC,                                            ');
    qryLocaisSeparacao.SQL.Add('  FDO_ESPDOC,                                            ');
    qryLocaisSeparacao.SQL.Add('  FDO_CODCLI,                                            ');
    qryLocaisSeparacao.SQL.Add('  FDO_CODEMP                                             ');
    qryLocaisSeparacao.SQL.Add('FROM                                                     ');
    qryLocaisSeparacao.SQL.Add('  ROMDETX D                                              ');
    qryLocaisSeparacao.SQL.Add('    INNER JOIN ITEGER I ON (D.DET_CODITE = I.ITE_CODITE) ');
    qryLocaisSeparacao.SQL.Add('                       AND (D.DET_CODEMP = I.ITE_CODEMP) ');
    qryLocaisSeparacao.SQL.Add('    INNER JOIN FATDOR F ON (D.DET_CODEMP = F.FDO_CODEMP) ');
    qryLocaisSeparacao.SQL.Add('                       AND (D.DET_NUMDOC = F.FDO_NUMDOC) ');
    qryLocaisSeparacao.SQL.Add('                       AND (D.DET_ESPDOC = F.FDO_ESPDOC) ');
    qryLocaisSeparacao.SQL.Add('                       AND (D.DET_CODCLI = F.FDO_CODCLI) ');
    qryLocaisSeparacao.SQL.Add('                       AND (I.ITE_CODITE = F.FDO_CODITE) ');
    qryLocaisSeparacao.SQL.Add('                       AND (I.ITE_CODEMP = F.FDO_CODEMP) ');
    qryLocaisSeparacao.SQL.Add('    INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      qryLocaisSeparacao.SQL.Add(' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FDO_CODITE AND LT.LOT_CODEMP = FDO_CODEMP AND LT.LOT_NUMLOT = FDO_NUMLOT ');
      qryLocaisSeparacao.SQL.Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
      qryLocaisSeparacao.SQL.Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = I.ITE_LOCFIS AND CL2.LOC_CODEMP = I.ITE_CODEMP ');
      qryLocaisSeparacao.SQL.Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      qryLocaisSeparacao.SQL.Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      qryLocaisSeparacao.SQL.Add('    LEFT  JOIN CADLSE L ON (I.ITE_CODLSE = L.LSE_CODIGO) ');

    qryLocaisSeparacao.SQL.Add('WHERE                                                    ');
    qryLocaisSeparacao.SQL.Add('  E.FDO_SEPEXP = "N"     AND                             ');
    qryLocaisSeparacao.SQL.Add('  D.DET_NUMROM = :NUMROM AND                             ');
    qryLocaisSeparacao.SQL.Add('  D.DET_EMPROM = :CODEMP AND                             ');
    qryLocaisSeparacao.SQL.Add('  IFNULL(L.AUTOINCREM,"SEMLOCAL") = :AUTLSE              ');
    qryLocaisSeparacao.SQL.Add('GROUP BY                                                 ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      qryLocaisSeparacao.SQL.Add('IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) ')
    else
      qryLocaisSeparacao.SQL.Add('  I.ITE_CODLSE                                           ');

    qryLocaisSeparacao.ParamByName('NUMROM').AsString := FNumeroDocumento;
    qryLocaisSeparacao.ParamByName('CODEMP').AsString := FCodigoEmpresa;
    qryLocaisSeparacao.ParamByName('AUTLSE').AsString := FautoincremLocalSeparacao;

    qryLocaisSeparacao.Open;
    qryLocaisSeparacao.First;

    recSepara.strNumDoc := qryLocaisSeparacao.FieldByName('FDO_NUMDOC').AsString;
    recSepara.strEspDoc := qryLocaisSeparacao.FieldByName('FDO_ESPDOC').AsString;
    recSepara.strCodCli := qryLocaisSeparacao.FieldByName('FDO_CODCLI').AsString;
    recSepara.strEmpDoc := qryLocaisSeparacao.FieldByName('FDO_CODEMP').AsString;

    recSepara.strCodLse := qryLocaisSeparacao.FieldByName('ITE_CODLSE').AsString;
    recSepara.strNumRom := FNumeroDocumento;

    impPreRomaneio := TFatVendaImp.Create;

    pPreenchaMatItens(recSepara.arrMatItens, qryLocaisSeparacao.FieldByName('ITE_CODLSE').AsString);

    impPreRomaneio.blnPreRomaneio   := True;
    impPreRomaneio.blnSomenteNaoImp := True;
    impPreRomaneio.opcAgrupaPor     := opcPedido;
    impPreRomaneio.Add(recSepara);

    if impPreRomaneio.fImprimeSeparacao(recSepara, '', '', False) then
    begin
      pMarcaSeparacaoImpressaColetor;
      Result := True;
    end;

    qryLocaisSeparacao.Next;

    qryLocaisSeparacao.close;

  finally
    FreeAndNil(qryLocaisSeparacao);
  end;

end;

procedure TSeparacaoFina.pMarcaSeparacaoImpressaColetor;
var
  qryConferencia : TUniQuery;
begin
  qryConferencia := fCriaQuery(nil);
  try
    qryConferencia.SQL.Add('SELECT                                         ');
    qryConferencia.SQL.Add('  *                                            ');
    qryConferencia.SQL.Add('FROM                                           ');
    qryConferencia.SQL.Add('  CONSTA                                       ');
    qryConferencia.SQL.Add('WHERE CON_IMPRES = "N"                         ');
    qryConferencia.SQL.Add('  AND CON_CODBAR = :CODBAR                     ');
    qryConferencia.SQL.Add('  AND IFNULL(CON_AUTLSE, "SEMLOCAL") = :AUTLSE ');

    qryConferencia.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;
    qryConferencia.ParamByName('AUTLSE').AsString := FAutoincremLocalSeparacao;

    qryConferencia.Open;

    if not qryConferencia.isEmpty then
    begin
      qryConferencia.Edit;
      qryConferencia.FieldByName('CON_IMPRES').AsString := 'S';
      qryConferencia.Post;
    end;

  finally
    FreeAndNil(qryConferencia);
  end;

end;

function TSeparacaoFina.getCodigoOperadorConferenciaColetor : String;
var
  qryConferencia : TUniQuery;
begin
  qryConferencia := fCriaQuery(nil);
  Result := '';
  try
    qryConferencia.SQL.Add('SELECT                     ');
    qryConferencia.SQL.Add('  *                        ');
    qryConferencia.SQL.Add('FROM                       ');
    qryConferencia.SQL.Add('  CONSTA                   ');
    qryConferencia.SQL.Add('WHERE CON_CODBAR = :CODBAR ');
    qryConferencia.SQL.Add('ORDER BY CON_FINALI        ');

    qryConferencia.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;
    qryConferencia.Open;

    qryConferencia.First;
    while not qryConferencia.eof do
    begin
      if (qryConferencia.FieldByName('CON_STATUS').AsString = 'DIVERGENCIA') or (qryConferencia.FieldByName('CON_IMPRES').AsString = 'N') then
      begin
        if qryExpedicaoAutcom.Locate('AUTOINCREM', qryConferencia.FieldByName('CON_AUTLSE').AsString, []) then
        begin
          if qryExpedicaoAutcom.FieldByName('QUANTIDADE_NAO_EXPEDIDA').AsFloat > 0 then
            exit;
        end
        else
          exit;
      end;

      Result := qryConferencia.FieldByName('CON_CODOPE').AsString;
      qryConferencia.Next;
    end;

  finally
    FreeAndNil(qryConferencia);
  end;

end;


function TSeparacaoFina.getCodigoOperadorSeparacaoColetor : String;
var
  qrySeparacao : TUniQuery;
begin
  qrySeparacao := fCriaQuery(nil);
  Result := '';
  try
    qrySeparacao.SQL.Add('SELECT                     ');
    qrySeparacao.SQL.Add('  *                        ');
    qrySeparacao.SQL.Add('FROM                       ');
    qrySeparacao.SQL.Add('  SEPSTA                   ');
    qrySeparacao.SQL.Add('WHERE SEP_CODBAR = :CODBAR ');
    qrySeparacao.SQL.Add('ORDER BY SEP_FINALI        ');

    qrySeparacao.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;
    qrySeparacao.Open;

    qrySeparacao.First;
    while not qrySeparacao.eof do
    begin
      if (qrySeparacao.FieldByName('SEP_STATUS').AsString = 'DIVERGENCIA') then
      begin
        if qryExpedicaoAutcom.Locate('AUTOINCREM', qrySeparacao.FieldByName('SEP_AUTLSE').AsString, []) then
        begin
          if qryExpedicaoAutcom.FieldByName('QUANTIDADE_NAO_EXPEDIDA').AsFloat > 0 then
            exit;
        end
        else
          exit;
      end;

      Result := qrySeparacao.FieldByName('SEP_CODOPE').AsString;
      qrySeparacao.Next;
    end;
  finally
    FreeAndNil(qrySeparacao);
  end;

end;

procedure TSeparacaoFina.pLimpaSeparacaoEConferenciaItensAlterados(
  cdsItensAlterados: TCdsItensLocalSeparacao);
  var
    qryAuxiliar : TUniQuery;
    blnTransacaoExterna : Boolean;
begin
  qryAuxiliar := fCriaQuery(nil);
  blnTransacaoExterna := qryAuxiliar.Connection.InTransaction;
  try
    try
      if not blnTransacaoExterna then
        fStartTransaction;

      //Separação
      qryAuxiliar.SQL.Add('SELECT                   ');
      qryAuxiliar.SQL.Add('  *                      ');
      qryAuxiliar.SQL.Add('FROM                     ');
      qryAuxiliar.SQL.Add('  SEPSTA                 ');
      qryAuxiliar.SQL.Add('WHERE SEP_CODBAR = :CODBAR ');

      qryAuxiliar.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;

      qryAuxiliar.Open;

      qryAuxiliar.First;
      while not qryAuxiliar.eof do
      begin
        if cdsItensAlterados.Locate('AUTOINCREM_LOCAL_SEPARACAO', qryAuxiliar.FieldByName('SEP_AUTLSE').AsString, []) then
          qryAuxiliar.Delete
        else
          qryAuxiliar.Next;
      end;

      //Conferência
      qryAuxiliar.Close;
      qryAuxiliar.SQL.Clear;
      qryAuxiliar.SQL.Add('SELECT                    ');
      qryAuxiliar.SQL.Add('  *                       ');
      qryAuxiliar.SQL.Add('FROM                      ');
      qryAuxiliar.SQL.Add('  CONSTA                  ');
      qryAuxiliar.SQL.Add('WHERE CON_CODBAR = :CODBAR  ');

      qryAuxiliar.ParamByName('CODBAR').AsString := FCodigoBArrasSeparacao;

      qryAuxiliar.Open;

      qryAuxiliar.First;
      while not qryAuxiliar.eof do
      begin
        if cdsItensAlterados.Locate('AUTOINCREM_LOCAL_SEPARACAO', qryAuxiliar.FieldByName('CON_AUTLSE').AsString, []) then
          qryAuxiliar.Delete
        else
          qryAuxiliar.Next;
      end;

      if not blnTransacaoExterna then
        fCommit;
    except
      ON E: Exception do
      begin
        if not blnTransacaoExterna then
          fRollBack;
        raise Exception.Create(E.Message);
      end;
    end;

  finally
    FreeAndNil(qryAuxiliar);
  end;


end;

procedure TSeparacaoFina.pLimpaSeparacaoStatus;
var
  qrySeparacao : TUniQuery;
begin
  qrySeparacao := fCriaQuery(nil);
  try
    qrySeparacao.SQL.Add('DELETE FROM SEPSTA        ');
    qrySeparacao.SQL.Add('WHERE SEP_CODBAR = :CODBAR ');

    qrySeparacao.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;
    qrySeparacao.ExecSQL;

  finally
    FreeAndNil(qrySeparacao);
  end;

end;

procedure TSeparacaoFina.pLimpaSeparacaoEConferenciaStatus;
begin
  pLimpaSeparacaoStatus;
  pLimpaConferenciaStatus;
end;


procedure TSeparacaoFina.pLimpaConferenciaStatus;
var
  qrySeparacao : TUniQuery;
begin
  qrySeparacao := fCriaQuery(nil);
  try
    qrySeparacao.SQL.Add('DELETE FROM CONSTA         ');
    qrySeparacao.SQL.Add('WHERE CON_CODBAR = :CODBAR ');

    qrySeparacao.ParamByName('CODBAR').AsString := FCodigoBarrasSeparacao;
    qrySeparacao.ExecSQL;

  finally
    FreeAndNil(qrySeparacao);
  end;

end;

function TSeparacaoFina.fSeparacaoCompletaColetor: boolean;
begin
  FCodigoOperadorFinalizouSeparacao   := '';
  FCodigoOperadorFinalizouConferencia := '';
  try
    qryExpedicaoAutcom.Close;
    qryExpedicaoAutcom.ParamByName('NUMROM').AsString := FNumeroDocumento;
    qryExpedicaoAutcom.ParamByName('CODEMP').AsString := FCodigoEmpresa;
    qryExpedicaoAutcom.Open;

    FCodigoOperadorFinalizouSeparacao := getCodigoOperadorSeparacaoColetor;
    if FCodigoOperadorFinalizouSeparacao <> '' then
      FCodigoOperadorFinalizouConferencia := getCodigoOperadorConferenciaColetor;

    qryExpedicaoAutcom.Close;

    if FCodigoOperadorFinalizouConferencia  <> '' then
      Result := True
    else
      raise Exception.create('');

  except
    FCodigoOperadorFinalizouSeparacao   := '';
    FCodigoOperadorFinalizouConferencia := '';
    Result := False;
  end;
end;

procedure TSeparacaoFina.setCodigoBarrasSeparacao(const Value: String);
begin
  FCodigoBarrasSeparacao := Value;

  if FTipoDocumento = tdsRomaneio then
    FNumeroDocumento := Copy(FCodigoBarrasSeparacao, 8, 6)
  else
    FNumeroDocumento := Copy(FCodigoBarrasSeparacao, 1, 12);
end;


procedure TSeparacaoFina.setNumeroDocumento(const Value: String);
begin
  FNumeroDocumento := Value;

  FCodigoBarrasSeparacao := '1';
  FCodigoBarrasSeparacao := FCodigoBarrasSeparacao + FPadL(FNumeroDocumento, 12, '0');
  FCodigoBarrasSeparacao := FCodigoBarrasSeparacao + fTipoDocumentoSeparacaoFinaToString(FTipoDocumento);
  FCodigoBarrasSeparacao := FCodigoBarrasSeparacao + FCodigoEmpresa;
end;

function fTipoDocumentoSeparacaoFinaToString(enuTipoDocumento : TTipoDocumentoSeparacaoFina) : String;
begin
  case enuTipoDocumento of
    tdsPedido   : Result := '10';
    tdsRomaneio : Result := '28';
  end;
end;

end.
