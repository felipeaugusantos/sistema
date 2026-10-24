unit untGarantiaColetaClassesCancelamentoRetornoColeta;

interface
uses
  untGarantiaColetalibtypes, Uni, untGarantiaColetaClassesRetornoColeta, untGarantiaLibDiversos;

Type
  TMetodoApagarGarantia = reference to function (strNumDoc, strCodCli, strEspSel: String):Boolean;

  TExisteEnvioParaFornecedorDaGarantia = function (strEspSel, strNumDoc,strCliFor: String): Boolean of object;
  TCancelaContasReceber = function (strEspDoc, strNumDoc, strCliFor, strCodEmp: String; PermiteRecursividade: Boolean = True; blnEhGarantiaGA: Boolean = False): Boolean of object;

Type
   TCancelamentoRetornoColeta = class
  private
    FstrNumDoc: String;
    FstrEspDoc: String;
    FstrCodEmp: String;
    FRetornoColeta: TRetornoColeta;
    function fSqlConsultaExisteDocumentoReposicao: String;
    function fExecutarQuery(aProc: TProcAnonimoQuery): Boolean;
    function fExisteDocumentoReposicao(const strNumDoc, strEspDoc, strCodEmp: String; Out strNumDocGar: String): Boolean;
    function fSqlCarregarRetornoColeta: String;
    procedure pCarregarRetornoColeta(var Qry: TUniQuery);
    function fSqlExcluirRegistro: String;
    function fExcluirRetornoColeta(ItensRetorno: TItensRetornoColeta): Boolean;
    procedure pRestaurarPedidoReserva;
    procedure pObterConfirmacao;
    procedure pExibirMensagemNaoPermitirCancelar(const strNumDoc: String);
  public
    blnTemRetorno: Boolean;
    blnConfirmado: boolean;
    blnTemReposicao: Boolean;
    Constructor Create(const strNumDoc, strEspDoc, strCodEmp: String);
    destructor Destroy;override;
    function fCarregaColeta(blnApenasCarrega: Boolean = False): Boolean;
    function fGetCodCli: String;
    function fCancelarColeta(MetodoApagarGarantia: TMetodoApagarGarantia): Boolean;
    function fVericaSeTemEnvioParaFornecedor: Boolean;
    function fSqlObterTitulosCredito: String;
    function fCancelarTitulosCredito(MetodoCancelaContasReceber: TCancelaContasReceber): Boolean;
    procedure pExibirMensagemTituloCredito;
  end;

implementation
uses
  System.StrUtils, untFuncoesSimples, System.SysUtils, untTRestauraDel, untGarantiaColetaLibfuncoes;

{ TCancelamentoRetornoColeta }


constructor TCancelamentoRetornoColeta.Create(const strNumDoc, strEspDoc, strCodEmp: String);
begin
  FstrNumDoc := strNumDoc;
  FstrEspDoc := strEspDoc;
  FstrCodEmp := strCodemp;
end;

destructor TCancelamentoRetornoColeta.Destroy;
begin
  if Assigned(FRetornoColeta) then
    FreeAndNil(FRetornoColeta);
  inherited;
end;

function TCancelamentoRetornoColeta.fSqlConsultaExisteDocumentoReposicao: String;
begin
  Result :=          ' SELECT DISTINCT G2.AUTOINCREM, G2.GER_NUMDOC, G2.GER_ESPDOC, G2.GER_SERIE_, G2.GER_CODEMP ';
  Result := Result + ' FROM MOVGER G1 ';
  Result := Result + ' INNER JOIN MOVDET D1 ON D1.DET_SEQGER = G1.AUTOINCREM ';
  Result := Result + ' INNER JOIN MOVGRC C1 ON C1.GRC_SEQDET = D1.AUTOINCREM AND GRC_OPCDOC = ''DV'' ';
  Result := Result + ' INNER JOIN MOVGRC C2 ON C2.GRC_SEQGAD = C1.GRC_SEQGAD AND C2.GRC_OPCDOC = ''OU'' ';
  Result := Result + ' INNER JOIN MOVDET D2 ON D2.AUTOINCREM = C2.GRC_SEQDET ';
  Result := Result + ' INNER JOIN MOVGER G2 ON G2.AUTOINCREM = D2.DET_SEQGER ';
  Result := Result + ' WHERE G1.GER_NUMDOC = :NUMDOC AND G1.GER_ESPDOC = :ESPDOC AND G1.GER_CODEMP = :CODEMP ';
end;

function TCancelamentoRetornoColeta.fExisteDocumentoReposicao(const strNumDoc, strEspDoc, strCodEmp: String;  Out strNumDocGar: String): Boolean;
Var
  lstrEspDoc: String;
  strSerie: String;
  strDocGar: String;
  blnResult: Boolean;
begin
  lstrEspDoc := IfThen(strEspDoc = 'NW','NF',strEspDoc);
  Result := fExecutarQuery(procedure(Var Qry: TUniQuery)
                           begin
                             blnResult := False;
                             Qry.Sql.Add(fSqlConsultaExisteDocumentoReposicao);
                             Qry.ParamByName('NUMDOC').AsString := strNumDoc;
                             Qry.ParamByName('ESPDOC').AsString := lstrEspDoc;
                             Qry.ParamByName('CODEMP').AsString := strCodEmp;
                             Qry.Open;
                             if Not Qry.IsEmpty then
                             begin
                               blnResult := True;
                               Qry.First;
                               strDocGar := Qry.FieldByName('GER_NUMDOC').AsString;
                               strSerie  := Qry.FieldByName('GER_SERIE_').AsString;
                             end;
                           end);
  if Result then
  begin
    Result := blnResult;
    strNumDocGar := fConcatenar([strDocGar,strSerie],'-');
  end;
end;

function TCancelamentoRetornoColeta.fGetCodCli: String;
begin
  if Assigned(FRetornoColeta) then
    Result := FRetornoColeta.strCodCli
  else
    Result := EmptyStr;
end;

function TCancelamentoRetornoColeta.fVericaSeTemEnvioParaFornecedor(): Boolean;
Var
  TipoGarantia: TTipoGarantia;
  ItensRetornoColeta: TItensRetornoColeta;
begin
  Result := False;

  for TipoGarantia in FRetornoColeta.fGetOperacoes do
  begin
    if TipoGarantia in [TTipoGarantia.AguardarRetornoFornecedor..TTipoGarantia.ReposicaoProduto] then
    begin
      ItensRetornoColeta :=  FRetornoColeta.fObterItensColeta(TipoGarantia);
      if Assigned(ItensRetornoColeta)  then
        Result := Result And ItensRetornoColeta.blnTemEnvio;
    end;
  end;
end;

function TCancelamentoRetornoColeta.fCancelarColeta(MetodoApagarGarantia: TMetodoApagarGarantia): Boolean;
Var
  TipoGarantia: TTipoGarantia;
  ItensRetornoColeta: TItensRetornoColeta;
begin
  Result := True;
  for TipoGarantia in FRetornoColeta.fGetOperacoes do
  begin
    if TipoGarantia in [TTipoGarantia.Nenhum..TTipoGarantia.ReposicaoProduto] then
    begin
      ItensRetornoColeta :=  FRetornoColeta.fObterItensColeta(TipoGarantia);
      if Not Assigned(ItensRetornoColeta) then
         Result := False;

      case TipoGarantia of
        TTipoGarantia.Nenhum: Result := Result And Self.fExcluirRetornoColeta(ItensRetornoColeta);
        TTipoGarantia.AguardarRetornoFornecedor..TTipoGarantia.ReposicaoProduto:
         begin
           Result :=  Result And MetodoApagarGarantia(ItensRetornoColeta.strNumEnt,Self.fGetCodCli,'NW');
           Result :=  Result And  Self.fExcluirRetornoColeta(ItensRetornoColeta);
         end;
      end;
    end;

    if Not Result then
      Break;
  end;

  if Result then
    Self.pRestaurarPedidoReserva;
end;

function TCancelamentoRetornoColeta.fSqlObterTitulosCredito: String;
begin
  Result := ' SELECT CTR_NUMDUP, CTR_ESPDOC ';
  Result := Result + ' FROM CADREC ';
  Result := Result + ' WHERE CTR_INCDOC = :INCDOC ';
end;

function TCancelamentoRetornoColeta.fCancelarTitulosCredito(MetodoCancelaContasReceber: TCancelaContasReceber): Boolean;
Var
  aProc: TProcAnonimoQuery;
  arrDuplicatas: TDuplicadasCreditoCancelar;
  intIdx: integer;
begin
  {$Region 'Definição do método anônimo'}
  aProc := procedure(Var Qry: TUniQuery)
           begin
            Qry.Sql.Add(fSqlObterTitulosCredito);
            Qry.ParamByName('INCDOC').AsString := FRetornoColeta.strIncGer;
            Qry.Open;
            if Not Qry.IsEmpty then
            begin
              Qry.First;
              while Not Qry.Eof do
              begin
                SetLength(arrDuplicatas,Length(arrDuplicatas)+1);
                ArrDuplicatas[High(ArrDuplicatas)].strNumDup := Qry.FieldByName('CTR_NUMDUP').AsString;
                ArrDuplicatas[High(ArrDuplicatas)].strEspDoc := Qry.FieldByName('CTR_ESPDOC').AsString;
                Qry.Next;
              end;
            end;
           end;
  {$Endregion}
  Result := True;
  Setlength(arrDuplicatas,0);
  if Not Assigned(MetodoCancelaContasReceber) then
    Exit(False);

  fExecutarQuery(aProc);

  if Length(arrDuplicatas) = 0 then
    Exit(True);

  for intIdx := 0 to Length(arrDuplicatas) -1 do
  begin
    Result := MetodoCancelaContasReceber(arrDuplicatas[intIdx].strEspDoc,
                                         arrDuplicatas[intIdx].strNumDup,
                                         FRetornoColeta.strCodCli,
                                         VS_strCodEmp,
                                         False);
    if Not Result then
      Break;
  end;

end;

function TCancelamentoRetornoColeta.fSqlExcluirRegistro: String;
begin
  Result := ' DELETE FROM %0:s WHERE %1:s = %2:s ';
end;


function TCancelamentoRetornoColeta.fExcluirRetornoColeta(ItensRetorno: TItensRetornoColeta): Boolean;
Var
  strSql: String;
  Proc: TProcAnonimoQuery;
begin
  Proc := Procedure(Var Qry: TUniQuery)
          begin
            Qry.Sql.Add(strSql);
            Qry.ExecSql;
          end;
  strSql := Format(fSqlExcluirRegistro,['MOVGCD','GCD_SEQGCG',QuotedStr(ItensRetorno.strAutoIncrem)]);
  Result := fExecutarQuery(Proc);
  if Result then
  begin
    strSql := Format(fSqlExcluirRegistro,['MOVGCG','AUTOINCREM',QuotedStr(ItensRetorno.strAutoIncrem)]);
    Result := fExecutarQuery(Proc);
  end;
end;

function TCancelamentoRetornoColeta.fExecutarQuery(aProc: TProcAnonimoQuery): Boolean;
Var
  Qry: TUniQuery;
begin
  Result := True;
  Qry := Nil;
  Try
    Try
      Qry := fCriaQuery();
      Qry.Close;
      Qry.Sql.Clear;
      aProc(Qry); //chamada do método anônimo.
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;

procedure TCancelamentoRetornoColeta.pRestaurarPedidoReserva;
begin
  TRestauraDel.pRestauraTabela('FATGOR', FRetornoColeta.strIncGor);
end;

procedure TCancelamentoRetornoColeta.pExibirMensagemTituloCredito;
begin
 fMensagem('Atenção!',
           'O documento não pode ser cancelado porque está vincularo a um título de contas a receber.'+
           'Cancele o documento antes de continuar.',
           ['&Ok']);

end;

procedure TCancelamentoRetornoColeta.pObterConfirmacao;
Const
  MSG: String = 'O documento informado é uma devolução de retorno de coleta. '+
                ' Neste processo serão cancelados os movimentos refetente a garantia. '+slineBreak+
                ' Deseja continuar com o cancelamento dos retornos processados?';
begin
  Self.blnConfirmado :=  fMensagem('Atenção',Msg,['&Sim','&Não'], 2) = 1;
end;

function TCancelamentoRetornoColeta.fCarregaColeta(blnApenasCarrega: Boolean = False): Boolean;
Var
  strDocRep: String;
begin
  fExecutarQuery(pCarregarRetornoColeta);
  if Not Assigned(FRetornoColeta) then
    Exit(False);

  if blnApenasCarrega then
    Exit(True);

  pObterConfirmacao;
  if Self.blnConfirmado then
  begin
    blnTemReposicao := Self.fExisteDocumentoReposicao(FStrNumDoc, FStrEspDoc, FStrCodEmp, strDocRep);
    if blnTemReposicao then
      pExibirMensagemNaoPermitirCancelar(strDocRep);
  end;

  Result := True;
end;

function TCancelamentoRetornoColeta.fSqlCarregarRetornoColeta: String;
begin
  Result := ' SELECT  G3.GAG_NUMENT, G2.AUTOINCREM, G1.GER_CODCLI, G2.GCG_SEQGAG, G2.GCG_SEQGER, G2.GCG_SEQGOR, G2.GCG_DTAENT, ';
  Result := Result + '  (SELECT COUNT(1) FROM MOVGAE WHERE GAE_SEQGAD = GCD_SEQGAD) AS TEMENVIO, ';
  Result := Result + '    D2.GCD_SEQGAD, D2.GCD_SEQDET, D2.GCD_SEQDOR, D2.GCD_QTDCOL, D2.GCD_QTDAVA, D2.GCD_QTDSEM, D2.GCD_TIPGAR ';
  Result := Result + ' FROM MOVGER G1 ';
  Result := Result + ' INNER JOIN AUXMOV A  ON A.AUX_SEQGER  = G1.AUTOINCREM AND A.AUX_COLETA = ''S'' ';
  Result := Result + ' INNER JOIN MOVGCG G2 ON G2.GCG_SEQGER = G1.AUTOINCREM ';
  Result := Result + ' INNER JOIN MOVGCD D2 ON D2.GCD_SEQGCG = G2.AUTOINCREM ';
  Result := Result + ' LEFT JOIN MOVGAG G3 ON G3.AUTOINCREM = G2.GCG_SEQGAG ';
  Result := Result + ' WHERE G1.GER_NUMDOC = :NUMDOC AND G1.GER_ESPDOC = :ESPDOC AND G1.GER_CODEMP = :CODEMP ';
  Result := Result + ' ORDER BY G2.AUTOINCREM ';
end;


procedure TCancelamentoRetornoColeta.pCarregarRetornoColeta(var Qry: TUniQuery);
Var
  TipoGarantia: TTipoGarantia;
  ItensRetorno: TItensRetornoColeta;
  Item: TItemRetornoColeta;
  blnQuebra: Boolean;
  strIncGCG: String;
  lstrEspDoc: String;
begin
  lstrEspDoc := IfThen(FstrEspDoc = 'NW','NF',FstrEspDoc);
  Qry.Sql.Add(fSqlCarregarRetornoColeta);
  Qry.ParamByName('NUMDOC').AsString := FstrNumDoc;
  Qry.ParamByName('ESPDOC').AsString := lstrEspDoc;
  Qry.ParamByName('CODEMP').AsString := FstrCodEmp;
  Qry.Open;
  if Not Qry.IsEmpty then
  begin
    FRetornoColeta := TRetornoColeta.create;
    Qry.First;
    FRetornoColeta.strNumDoc  := Self.FstrNumDoc;
    FRetornoColeta.strEspDoc  := Self.FstrEspDoc;
    FRetornoColeta.strEmpDoc  := Self.FstrCodEmp;
    FRetornoColeta.strIncGer  := Qry.FieldByName('GCG_SEQGER').AsString;
    FRetornoColeta.strIncGor  := Qry.FieldByName('GCG_SEQGOR').AsString;
    FRetornoColeta.strCodCli  := Qry.FieldByName('GER_CODCLI').AsString;
    strIncGCG := EmptyStr;
    while Not Qry.Eof do
    begin
      blnQuebra := False;
      while (Not blnQuebra) and (Not Qry.Eof) do
      begin
        if strIncGCG <> Qry.FieldByName('AUTOINCREM').AsString then
        begin
          TipoGarantia.SetValueAsString(Qry.FieldByName('GCD_TIPGAR').AsString);
          strIncGCG := Qry.FieldByName('AUTOINCREM').AsString;
          ItensRetorno  := FRetornoColeta.fObterItensColeta(TipoGarantia);
          ItensRetorno.strAutoIncrem := strIncGCG ;
          ItensRetorno.strIncGag     := Qry.FieldByName('GCG_SEQGAG').AsString;
          ItensRetorno.strNumEnt     := Qry.FieldByName('GAG_NUMENT').AsString;
          ItensRetorno.blnTemEnvio   := Qry.FieldByName('TEMENVIO').AsInteger > 0;
        end;
        Item := TItemRetornoColeta.Create;
        Item.strIncGad       := Qry.FieldByName('GCD_SEQGAD').AsString;
        Item.strIncDet       := Qry.FieldByName('GCD_SEQDET').AsString;
        Item.strIncDor       := Qry.FieldByName('GCD_SEQDOR').AsString;
        Item.fltQtdColeta    := Qry.FieldByName('GCD_QTDCOL').AsFloat;
        Item.fltQtdAvaria    := Qry.FieldByName('GCD_QTDAVA').AsFloat;
        Item.fltQtdSemAvaria := Qry.FieldByName('GCD_QTDSEM').AsFloat;
        Item.Garantia := TipoGarantia;
        FRetornoColeta.pAdicionarItem(Item);
        if Not Self.blnTemRetorno then
          Self.blnTemRetorno := True;
        Qry.Next;
        blnQuebra := strIncGcg <> Qry.FieldByName('AUTOINCREM').AsString;
      end;
    end;
  end;
end;

procedure TCancelamentoRetornoColeta.pExibirMensagemNaoPermitirCancelar(const strNumDoc: String);
begin
  fMensagem('ATENÇÃO!', 'Este documento não pode ser cancelado, ' + #13#10 +
                        'pois o mesmo foi reposto ao cliente. ' + #13#10 +
                        'Efetue Primeiro o Cancelamento da reposição ao cliente. ' + #13#10 +
                        'Cancele o documento nº [Número-Série] ' + strNumDoc + ' através da opção: ' + #13#10 +
                        '"OF" - Nota de Outras Saídas' , ['&Ok']);
end;


end.
