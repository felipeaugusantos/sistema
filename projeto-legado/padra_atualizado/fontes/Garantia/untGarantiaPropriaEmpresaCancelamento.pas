unit untGarantiaPropriaEmpresaCancelamento;

interface
uses
  DAta.DB, Uni;


type
  TGarantiaPropriaEmpresaCancelamento = class
  private
    function fEstornarReposicaoGarantia(const strAutInc: String): boolean;
    function fSqlCancelarAvaliacao: String;
    function fExisteDocumentoBaixa(qry: TUniquery; out strDocumento: String): Boolean;overload;
    function fCancelarAvaliacao(const strIncGad, strIncGpe, stIncAju: String): Boolean;
    function fSqlGarantiaTemPedidoReposicao(strEspSel: String): String;
    function fSqlRefazAvaliacaoGarantiaPropriaEmpresa: String;

    function fGetSqlHisticoCRM(blnHISOCO: Boolean): String;
  public
    function fSqlObterMovGpv: String;
    function fExcluirMovGPV(const strAutInc: String): Boolean;
    class function fCancelarPedidoReposicaoGarantia(const strNumDoc, strEspDoc, strCodEmp: String): boolean;overload;
    class procedure pExcluirOcorrenciaCRM(const strAutInc: String);
    class function fApagarPedido(const strAutInc: String): Boolean;
    class function fEhPedidoReposicaoGarantia(const strNumDoc, strEspDoc, strCodEmp: String; strCodCli: String = ''; blnDocFiscal: boolean = False): boolean; overload;

    class function fEhPedidoReposicaoGarantia(const strSeqFDO: String): boolean; overload;
    class function fEstornarAvaliacaoGarantia(const strAutInc: String): Boolean;
    class function fExcluirMovGPE(const strAutInc: String): boolean;
    class function fExcluirAjuste(const strAutInc: String): boolean;
    class function fCancelarAvaliacaoGarantiaPropriaEmpresa(const  strNumDoc, strEspDoc, strCodEmp: String): boolean;
    class function fGarantiaTemPedidoReposicao(const strCodCli, strNumDoc,  strEspSel, strCodEmp: String): Boolean;
    class function fRefazAvalizacaoGarantiaPropriaEmpresa(const strNumDoc, strEspDoc, strCodCli, strCodEmp: String): boolean;
    class function fDocumentoFiscalComOrigemGarantiaPropriaEmpresa(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String): boolean;
    class function fEhDocumentoPerdaComSaidaVinculado(const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  end;


implementation

uses
   untFuncoesSimples, System.SysUtils,  System.strUtils, untGarantiaPropriaEmpresaTypes, untGarant, untGarantiaLibDiversos, untCadIte;

{ TGarantiaPropriaEmpresaCancelamento }

class function TGarantiaPropriaEmpresaCancelamento.fApagarPedido(const strAutInc: String): Boolean;
Const
  SQL_DELETE: String = ' DELETE FROM FATGOR WHERE AUTOINCREM = :AUTINC ';
Var
  Qry: TUniquery;

begin
  Result := True;
  
  Try  
    Qry := fCriaQuery;
    Try
      Qry.close;
      Qry.Sql.clear;
      Qry.sql.add(SQL_DELETE);
      Qry.ParamByName('AUTINC').AsString := strAutInc;
      Qry.Execute;
    Finally
      if Assigned(Qry) then
        FreeAndnil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fEhPedidoReposicaoGarantia(const strNumDoc, strEspDoc, strCodEmp: String;  strCodCli: String = ''; blnDocFiscal: boolean = False): boolean;
  const
    SIM: String = 'S';
Var
  strSQL: String;
  Qry: TUniQuery;
begin
  {$Region 'Montagem SQL'}
  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT G3.AUTOINCREM, G3.FGO_NUMDOC, G3.FGO_ESPDOC, G3.FGO_CODEMP, IF(IFNULL(CONTAGEM,0)> 0,"S","N") AS PEDGAR ';
  strSQL := strSQL + ' FROM FATGOR G3 ';
  strSQL := strSQL + ' LEFT JOIN (SELECT G.AUTOINCREM,  COUNT(1) AS CONTAGEM ';
  strSQL := strSQL +            ' FROM  FATGOR G  ';
  strSQL := strSQL +            ' JOIN  FATDOR D  ON D.FDO_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL +            ' JOIN  MOVGPV G2 ON G2.GPV_SEQFDO = D.AUTOINCREM ';
  strSQL := strSQL +            ' GROUP BY G.AUTOINCREM) PVG ';
  strSQL := strSQL + ' ON PVG.AUTOINCREM = G3.AUTOINCREM ';
  strSQL := strSQL + ' WHERE ';

  if blnDocFiscal then
  begin
    strSQL := strSQL + ' G3.FGO_NUMFAT = :NUMDOC ';
    strSQL := strSQL + ' AND G3.FGO_TIPFAT = :ESPDOC ';
    strSQL := strSQL + ' AND G3.FGO_EMPFAT = :CODEMP ';
    strSQL := strSQL + ' AND G3.FGO_CODCLI = :CODCLI ';
    strSQL := strSQL + ' AND G3.FGO_JAFATU = "1" ';
  end
  else begin
    strSQL := strSQL + ' G3.FGO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + ' AND G3.FGO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + ' AND G3.FGO_CODEMP = :CODEMP ';
  end;
  {$Endregion}
  Result := False;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := strEspDoc;
      Qry.ParamByName('CODEMP').AsString := strCodEmp;

      if blnDocFiscal then
        Qry.ParamByName('CODCLI').AsString := strCodCli;

      Qry.Open;
      if Not Qry.IsEmpty then
        Result := Qry.FieldByName('PEDGAR').AsString = SIM ;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      pMensagensErro(E.Message, '[fEhPedidoReposicaoGarantia]');
      Result := True;
    end;
  End;
end;


class function TGarantiaPropriaEmpresaCancelamento.fEhPedidoReposicaoGarantia(const strSeqFDO: String): boolean;
Var
  strSQL: String;
  Qry: TUniQuery;
begin
  {$Region 'Montagem SQL'}
  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT COUNT(1) AS CONTAGEM ';
  strSQL := strSQL +  ' FROM FATGOR G ';
  strSQL := strSQL +  ' JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL +  ' JOIN MOVGPV G2 ON G2.GPV_SEQFDO = D.AUTOINCREM ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL +  ' G.AUTOINCREM IN(' + strSeqFDO + ')';
  {$Endregion}
  Result := False;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.Open;
      if Not Qry.IsEmpty then
        Result := Qry.FieldByName('CONTAGEM').AsInteger > 0;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      pMensagensErro(E.Message, '[fEhPedidoReposicaoGarantia]');
      Result := True;
    end;
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fEstornarAvaliacaoGarantia(const strAutInc: String): Boolean;
const
  SQL_UPDATE: String = ' UPDATE MOVGAD  SET GAD_QTDRET = 0, GAD_QTDREP = 0, GAD_QTDREF = 0, GAD_DTARET = NULL WHERE AUTOINCREM = :AUTINC ';
Var
  Qry: TUniQuery;
begin
  Result := False;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(SQL_UPDATE);
      Qry.ParamByName('AUTINC').AsString := strAutInc;
      Qry.ExecSql;
      Result := True;
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      pMensagensErro(E.Message, '[TGarantiaPropriaEmpresaCancelamento.fEstornarAvaliacaoGarantia]');
    end;
  End;
end;

function TGarantiaPropriaEmpresaCancelamento.fEstornarReposicaoGarantia(const strAutInc: String): boolean;
const
  SQL: String = ' UPDATE MOVGAD SET GAD_REPOST = "N", GAD_SCREDI = 1 WHERE GAD_SEQGAG = :AUTINC ';

Var
  Qry: TUniQuery;
begin
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(SQL);
    Qry.ParamByName('AUTINC').AsString := strAutInc;
    Qry.ExecSql;
    Result := True;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TGarantiaPropriaEmpresaCancelamento.fExcluirMovGPV(const strAutInc: String): Boolean;
const
  SQL: String = ' DELETE FROM MOVGPV WHERE AUTOINCREM = :AUTINC ';
Var
  Qry: TUniQuery;
begin
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(SQL);
    Qry.ParamByName('AUTINC').AsString := strAutInc;
    Qry.ExecSql;
    Result := True;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;


function TGarantiaPropriaEmpresaCancelamento.fExisteDocumentoBaixa(qry: TUniquery; out strDocumento: String): Boolean;
begin
  Result := False;
  while Not Qry.Eof do
  begin
    if Not fEmptyStr(Qry.FieldByName('GER_NUMDOC').AsString) then
    begin
      Result := True;
      strDocumento := fConcatenar([Qry.FieldByName('GER_NUMDOC').AsString, Qry.FieldByName('GER_ESPDOC').AsString,
                  Qry.FieldByName('GER_CODEMP').AsString],'-');
      Break;
    end;
    Qry.next;
  end;
end;

function TGarantiaPropriaEmpresaCancelamento.fSqlGarantiaTemPedidoReposicao(strEspSel: String): String;
begin
  Result := Result + ' SELECT DISTINCT  D2.FDO_NUMDOC, D2.FDO_ESPDOC ';

  Result := Result + ' FROM MOVGAG G ';
  Result := Result + ' JOIN MOVGAD D ON GAD_SEQGAG = G.AUTOINCREM ';
  Result := Result + ' JOIN MOVGPV GPV ON GPV.GPV_SEQGAD = D.AUTOINCREM ';
  Result := Result + ' JOIN FATDOR D2 ON D2.AUTOINCREM = GPV.GPV_SEQFDO ';
  Result := Result + ' JOIN MOVGRC R ON R.GRC_SEQGAD = D.AUTOINCREM ';
  Result := Result + ' JOIN MOVDET D3 ON D3.AUTOINCREM = R.GRC_SEQDET ';
  Result := Result + ' JOIN MOVGER G3 ON G3.AUTOINCREM = D3.DET_SEQGER ';
  Result := Result + ' WHERE G3.GER_NUMDOC = :NUMDOC AND G3.GER_ESPDOC = :ESPDOC AND G3.GER_CODEMP = :CODEMP AND G3.GER_CODCLI = :CODCLI ';

  if pos(strEspSel, '_GA_') > 0  then
    Result := Result + ' AND R.GRC_OPCDOC = "GA" '
  else
    Result := Result + ' AND R.GRC_OPCDOC IN ("NE","OE") ';

  Result := Result + ' ORDER BY D2.FDO_NUMDOC ';
end;

class function TGarantiaPropriaEmpresaCancelamento.fGarantiaTemPedidoReposicao(const strCodCli, strNumDoc, strEspSel,  strCodEmp: String): Boolean;
Var
  Qry: TUniQuery;
  strPedido: String;
  strMsg: String;
  GPECancelamento: TGarantiaPropriaEmpresaCancelamento;
begin
  Try
    GPECancelamento := TGarantiaPropriaEmpresaCancelamento.Create;
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(GPECancelamento.fSqlGarantiaTemPedidoReposicao(strEspSel));
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := ifthen(strEspSel = 'GA','GA','NF');
      Qry.ParamByName('CODEMP').AsString := strCodEmp;
      Qry.ParamByName('CODCLI').AsString := strCodCli;
      Qry.Open;
      Result := Not Qry.IsEmpty;
      if Result  then
      begin
        Qry.First;
        strPedido := fConcatenar([Qry.FieldByName('FDO_NUMDOC').AsString, Qry.FieldByName('FDO_ESPDOC').AsString],'-');
        strMsg := Format('Esta documento pertence ao processo de garantia própria empresa. Cancele o pedido de reposição [%s] antes de continuar.',
            [strPedido]);
        fMensagem('Atenção!',strMsg,['&Ok']);
      end;
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);

      if Assigned(GPECancelamento) then
        FreeAndNil(GPECancelamento);
    End;
  Except
    On E: Exception do
    begin
      Result := True;
      pMensagensErro(E.Message, '[TGarantiaPropriaEmpresaCancelamento.fGarantiaTemPedidoReposicao]');
    end;
  End;
end;

function TGarantiaPropriaEmpresaCancelamento.fGetSqlHisticoCRM(blnHISOCO: Boolean): String;
  Var
    strEntidade: String;
    strAlias: String;
    strSQLSub: String;
begin
  strSQLSub := EmptyStr;
  
  if blnHISOCO then
  begin
    strEntidade := 'HISOCO';
    strAlias := 'H';
  end
  else begin
    strEntidade := 'MOVOCO';
    strAlias := 'M';
  end;

  strSQLSub := strSQLSub + ' SELECT DISTINCT %0:s.AUTOINCREM ';
  strSQLSub := strSQLSub + ' FROM FATGOR G ';
  strSQLSub := strSQLSub + ' JOIN MOVOCO M ON M.OCO_NUMDOC = G.FGO_NUMDOC AND M.OCO_ESPDOC = G.FGO_ESPDOC ';
  strSQLSub := strSQLSub +                  ' AND M.OCO_CODEMP = G.FGO_CODEMP AND M.OCO_CODCLI = G.FGO_CODCLI ';

  if blnHISOCO then
  begin
    strSQLSub := strSQLSub + ' JOIN HISOCO H ON H.HIS_NUMDOC = G.FGO_NUMDOC AND H.HIS_ESPDOC = G.FGO_ESPDOC ';
    strSQLSub := strSQLSub +                   'AND H.HIS_CODEMP = G.FGO_CODEMP AND H.HIS_CODOCO = M.OCO_CODOCO ';    
  end;
                                                   
  strSQLSub := strSQLSub + ' WHERE G.AUTOINCREM = :AUTINC ';

  strSQLSub := Format(strSQLSub, [strAlias]);

  Result := Format('DELETE T1 FROM %0:s T1  INNER JOIN (%1:s) T2 ON T1.AUTOINCREM = T2.AUTOINCREM ',[strEntidade, strSQLSub]);  

end;

function TGarantiaPropriaEmpresaCancelamento.fSqlRefazAvaliacaoGarantiaPropriaEmpresa: String;
begin
  Result := EmptyStr;
  Result := Result + ' UPDATE MOVGAD ';
  Result := Result + ' SET  GAD_QTDREP = GAD_QTDREF, GAD_QTDREF = 0 ';
  Result := Result + ' WHERE MOVGAD.AUTOINCREM IN (SELECT     GPV_SEQGAD ';
  Result := Result +                             ' FROM  FATGOR ';
  Result := Result +                             ' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result +                             ' INNER JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result +                             ' WHERE FATGOR.FGO_NUMFAT = :NUMDOC ';
  Result := Result +                             ' AND FATGOR.FGO_TIPFAT = :ESPDOC ';
  Result := Result +                             ' AND FATGOR.FGO_EMPFAT = :CODEMP ';
  Result := Result +                             ' AND FATGOR.FGO_CODCLI = :CODCLI ';
  Result := Result +                             ' AND FATGOR.FGO_JAFATU = "1") ';
  Result := Result + ' AND GAD_QTDREF > 0 ';
end;

class procedure TGarantiaPropriaEmpresaCancelamento.pExcluirOcorrenciaCRM(const strAutInc: String);
  Type
    TenuTabela = (TabHISOCO, TabMOVOCO); 

  var
    strSQL: String;
    QryDel: TUniQuery;
    enuTab: TenuTabela;
    objGarantiaPropriaEmpresaCancelamento: TGarantiaPropriaEmpresaCancelamento;    
begin
  QryDel := Nil;
  objGarantiaPropriaEmpresaCancelamento := Nil;
  Try
    objGarantiaPropriaEmpresaCancelamento := TGarantiaPropriaEmpresaCancelamento.create;  
    Try
      QryDel := fCriaQuery;
      QryDel.Close;

      for enuTab := TabHISOCO to TabMOVOCO do
      begin
        QryDel.Sql.Clear;
        strSQL := objGarantiaPropriaEmpresaCancelamento.fGetSqlHisticoCRM(enuTab = TabHISOCO);
        QryDel.SQL.add(strSQL);
        QryDel.ParamByName('AUTINC').AsString := strAutInc;
        QryDel.ExecSQL;
      end;
    Except
      On E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmAvaliacaoGarantiaPropriaEmpresa.pExcluirHISOCOdoPedido]');
      end;
    End;        
  Finally
    if Assigned(QryDel) then
      FreeAndNil(QryDel);
    if Assigned(objGarantiaPropriaEmpresaCancelamento) then
      FreeAndNil(objGarantiaPropriaEmpresaCancelamento);      
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fRefazAvalizacaoGarantiaPropriaEmpresa(
  const strNumDoc, strEspDoc,  strCodCli, strCodEmp: String): boolean;
Var
  Qry: TUniQuery;
  GPECancelamento: TGarantiaPropriaEmpresaCancelamento;
begin
  Result := True;
  Try
    GPECancelamento := TGarantiaPropriaEmpresaCancelamento.Create;
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(GPECancelamento.fSqlRefazAvaliacaoGarantiaPropriaEmpresa);
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := strEspDoc;
      Qry.ParamByName('CODCLI').AsString := strCodCli;
      Qry.ParamByName('CODEMP').AsString := strCodEmp;
      Qry.ExecSql;
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);

      if Assigned(GPECancelamento) then
        FreeAndNil(GPECancelamento);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TGarantiaPropriaEmpresaCancelamento.fRefazAvalizacaoGarantiaPropriaEmpresa]');
    end;
  End;
end;

function TGarantiaPropriaEmpresaCancelamento.fSqlObterMovGpv: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT G.AUTOINCREM, G.GPV_SEQGAD, G.GPV_SEQFDO, G.GPV_QTDDEV, G.GPV_QTDPRE, G.GPV_INCORI, G.GPV_TIPENT, ';
  Result := Result +        ' D.GAD_QTDDEV, D.GAD_QTDPRE ';
  Result := Result + ' FROM MOVGPV G ';
  Result := Result + ' INNER JOIN MOVGAD D ON D.AUTOINCREM = G.GPV_SEQGAD ';
  Result := Result + ' WHERE G.GPV_SEQFDO IN (SELECT D2.AUTOINCREM ';
  Result := Result +                        ' FROM FATGOR G2 ';
  Result := Result +                        ' JOIN FATDOR D2 ON D2.FDO_SEQGER = G2.AUTOINCREM ';
  Result := Result +                        ' WHERE G2.FGO_NUMDOC = :NUMDOC AND G2.FGO_ESPDOC = :ESPDOC AND G2.FGO_CODEMP = :CODEMP) ';
end;


function TGarantiaPropriaEmpresaCancelamento.fSqlCancelarAvaliacao: String;
begin
  Result := Result + ' SELECT DISTINCT D.FDO_SEQGER, GPV.GPV_SEQGAD, GPE.AUTOINCREM AS "GPE_AUTINC", GPE_SEQAJE, GPE_SEQBAI, ';
  Result := Result +        'G1.GER_NUMDOC, G1.GER_ESPDOC, G1.GER_CODEMP, G1.GER_SERIE_ ';
  Result := Result + ' FROM FATDOR D ';
  Result := Result + ' JOIN MOVGPV GPV ON GPV_SEQFDO = D.AUTOINCREM ';
  Result := Result + ' JOIN MOVGPE GPE ON GPE_SEQGAD = GPV.GPV_SEQGAD ';
  Result := Result + ' LEFT JOIN MOVGER G1 ON G1.AUTOINCREM = GPE_SEQBAI ';
  Result := Result + ' WHERE D.FDO_NUMDOC = :NUMDOC AND D.FDO_ESPDOC = :ESPDOC AND D.FDO_CODEMP = :CODEMP ';
end;

class function TGarantiaPropriaEmpresaCancelamento.fCancelarAvaliacaoGarantiaPropriaEmpresa(const strNumDoc, strEspDoc, strCodEmp: String): boolean;
  Var
    GPECancelamento: TGarantiaPropriaEmpresaCancelamento;
    Qry: TUniQuery;
    fldGPV_SEQGAD: TField;
    fldGPE_SEQAJE: TField;
    fldGPE_AUTINC: TField;
    Msg: String;
    strDocBaixa: String;
    strAjustesCancelados: String;
    strAutIncGor: String;
begin
  Qry := Nil;
  strAjustesCancelados := EmptyStr;
  GPECancelamento := TGarantiaPropriaEmpresaCancelamento.Create;
  Try
    Try
      Qry := fCriaQuery;
      Qry.close;
      Qry.Sql.Clear;
      Qry.Sql.Add(GPECancelamento.fSqlCancelarAvaliacao);
      Qry.ParambyName('NUMDOC').AsString := strNumDoc;
      Qry.ParambyName('ESPDOC').AsString := strEspDoc;
      Qry.ParambyName('CODEMP').AsString := strCodEmp;
      Qry.Open;

      if Qry.IsEmpty then
        Exit(True);

      Result := Not GPECancelamento.fExisteDocumentoBaixa(qry,strDocBaixa);

      if Not Result then
      begin
        Msg:= Format('Este é um pedido com origem no processo "Garantia Própria Empresa" e '+ slinebreak+
              ' e contém um documento de baixa [%s] vinculado. Cancele este documento antes de continuar.',[strDocBaixa]);

        fMensagem('Atenção',Msg,['&OK']);
        Exit;
      end;

      fldGPV_SEQGAD := qry.FieldByName('GPV_SEQGAD');
      fldGPE_SEQAJE := qry.FieldByName('GPE_SEQAJE');
      fldGPE_AUTINC := qry.FieldByName('GPE_AUTINC');

      Qry.First;
      strAutIncGor :=  qry.FieldByName('FDO_SEQGER').AsString;
      while (Not Qry.Eof) and Result  do
      begin
        if Pos(fldGPE_SEQAJE.AsString, strAjustesCancelados) = 0 then
        begin
          Result := GPECancelamento.fCancelarAvaliacao(fldGPV_SEQGAD.AsString, fldGPE_AUTINC.AsString, fldGPE_SEQAJE.AsString);

          if Result then
            strAjustesCancelados := strAjustesCancelados  + Format('_%s',[fldGPE_SEQAJE.AsString]);
        end
        else
          Result := GPECancelamento.fCancelarAvaliacao(fldGPV_SEQGAD.AsString, fldGPE_AUTINC.AsString, EmptyStr);

        Qry.Next;
      end;

      if Result then
        GPECancelamento.pExcluirOcorrenciaCRM(strAutIncGor);

    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TGarantiaPedidoCancelamento.fCancelarAvaliacao]');
      end;
    End;
  Finally
    if Assigned(GPECancelamento) then
      FreeAndNil(GPECancelamento);

    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;

end;

function TGarantiaPropriaEmpresaCancelamento.fCancelarAvaliacao(const strIncGad, strIncGpe, stIncAju: String): Boolean;
begin
  Result :=  TGarantiaPropriaEmpresaCancelamento.fExcluirMovGPE(strIncGpe);

  if Result And (Not fEmptyStr(stIncAju)) then
      Result := fExcluirAjuste(stIncAju);

  if Result then
    Result := fEstornarAvaliacaoGarantia(strIncGad);
end;

class function TGarantiaPropriaEmpresaCancelamento.fCancelarPedidoReposicaoGarantia(const strNumDoc, strEspDoc, strCodEmp: String): boolean;
CONST
  CANCELAR: boolean = True;
Var
  Qry: TUniquery;
  fldAutoIncrem, fldSeqGad, fldQtdDev, fldQtdPre, fldTipEnt, fldGAD_QtdDev, fldGAD_QtdPre: TField;
  Origem: TOrigemPedido;
  fltQtdDev, fltQtdPre: Double;
  GPCancelamento: TGarantiaPropriaEmpresaCancelamento;
begin
  Result := Not fEhPedidoReposicaoGarantia(strNumDoc, strEspDoc, strCodEmp);
  if Result then
   Exit(Result);

  Try
    GPCancelamento := TGarantiaPropriaEmpresaCancelamento.Create;
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(GPCancelamento.fSqlObterMovGpv);
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := strEspDoc;
      Qry.ParamByName('CODEMP').AsString := strCodemp;
      Qry.Open;
      if Not Qry.IsEmpty then
      begin
         {$Region 'Identificando Fields'}
          fldAutoIncrem   := Qry.FieldByName('AUTOINCREM');
          fldSeqGad       := Qry.FieldByName('GPV_SEQGAD');
          fldQtdDev       := Qry.FieldByName('GPV_QTDDEV');
          fldQtdPre       := Qry.FieldByName('GPV_QTDPRE');
          fldTipEnt       := Qry.FieldByName('GPV_TIPENT');
          fldGAD_QtdDev   := Qry.FieldByName('GAD_QTDDEV');
          fldGAD_QtdPre   := Qry.FieldByName('GAD_QTDPRE');
         {$Endregion}
        Qry.First;
        while Not Qry.EOF do
        begin
          fltQtdDev := 0;
          fltQtdPre := 0;
          Origem.SetAsString(fldTipEnt.AsString);
          case Origem of
            TOrigemPedido.RecebimentoCliente:
              begin
                Result := GPCancelamento.fEstornarReposicaoGarantia(fldSeqGad.AsString);
              end;

            TOrigemPedido.EnvioCliente:
              begin
                fltQtdDev := fldGAD_QtdDev.AsFloat - fldQtdDev.AsFloat;
                fltQtdPre := fldGAD_QtdPre.AsFloat - fldQtdPre.AsFloat;
                Result := True;
              end;
          end ;

          if Result then
            TMovGad.fAtualizaProdutosDevolucao(fldSeqGad.AsString, '', fltQtdDev, fltQtdPre, CANCELAR);

          if Result then
            Result := GPCancelamento.fExcluirMovGPV(fldAutoIncrem.AsString);

          if Not Result then
            Break;

          Qry.Next;
        end;
      end;
    Finally
      FreeAndNil(Qry);
      FreeAndNil(GPCancelamento);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TGarantiaPedidoCancelamento.fCancelarPedidoReposicao]');
    end;
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fDocumentoFiscalComOrigemGarantiaPropriaEmpresa(
  const strNumDoc, strEspDoc, strCodEmp, strCodCli: String): boolean;
CONST
  EH_DOCUMENTO_FISCAL: Boolean = True;
begin
  Result :=  TGarantiaPropriaEmpresaCancelamento.fEhPedidoReposicaoGarantia(strNumDoc, strEspDoc, strCodEmp, strCodCli, EH_DOCUMENTO_FISCAL);
end;

class function TGarantiaPropriaEmpresaCancelamento.fExcluirMovGPE(const strAutInc: String): boolean;
  CONST
    SQL_DELETE: String = ' DELETE FROM MOVGPE WHERE AUTOINCREM = :AUTINC ';
  Var
    Qry: TUniQuery;
begin
  Result := True;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Sql.Clear;
      Qry.Sql.Add(SQL_DELETE);
      Qry.ParamByName('AUTINC').AsString := strAutInc;
      Qry.Execute;
    Finally
      Qry.Free;
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fExcluirAjuste(const strAutInc: String): Boolean;
  CONST
    SAIDA: String = 'S';
Var
  Qry: TUniQuery;
  strSQL: String;
  intErros: Integer;
begin
  intErros := 0;
  Result := False;
{$Region 'SQL'}
    strSQL := EmptyStr;
    strSQL := strSQL + ' SELECT G.GER_NUMDOC, GER_CODCLI, GER_ESPDOC, DET_CODITE, DET_QTDITE ';
    strSQL := strSQL + ' FROM MOVGER G ';
    strSQL := strSQL + ' JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' WHERE G.AUTOINCREM = :AUTINC ';
{$Endregion}
  Qry := Nil;
  Try
    Qry := fCriaQuery;
{$Region 'Estornando estoque'}
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('AUTINC').AsString := strAutInc;
      Qry.Open;
      if Not Qry.IsEmpty then
      begin
        Qry.First;
        while Not Qry.EOF do
        begin
          if Not fAtualizaEstoqueCadIte(qry.FieldByName('DET_CODITE').AsString,  SAIDA,
                  qry.FieldByName('DET_QTDITE').AsFloat, 0.0, '', False) then
          begin
            inc(intErros);
            Break;
          end;
          qry.Next;
        end;
      end;
{$Endregion}
{$Region 'Excluindo MOVGER'}
      if (intErros = 0) then
      begin
        strSQL := 'DELETE FROM MOVGER WHERE AUTOINCREM = :AUTINC ';
        Qry.Close;
        Qry.SQL.Clear;
        Qry.SQL.Add(strSQL);
        Qry.ParamByName('AUTINC').AsString := strAutInc;
        Qry.ExecSQL;
        Result := True;
      end;
{$Endregion}
  Finally
    if Assigned(Qry) then
      Qry.Free;
  End;
end;

class function TGarantiaPropriaEmpresaCancelamento.fEhDocumentoPerdaComSaidaVinculado(const strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  Var
    strSQL: String;
    Qry: TUniQuery;
    Msg: String;
begin
{$REGION 'Montando sql'}
    strSQL := strSQL + ' SELECT DISTINCT G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP' ;
    strSQL := strSQL + ' FROM MOVGER G' ;
    strSQL := strSQL + ' JOIN FATGOR FGO ON G.GER_NUMDOC = FGO.FGO_NUMFAT AND G.GER_ESPDOC = FGO.FGO_TIPFAT AND G.GER_CODEMP = FGO.FGO_EMPFAT' ;
    strSQL := strSQL + ' JOIN FATDOR FDO ON FDO.FDO_SEQGER = FGO.AUTOINCREM' ;
    strSQL := strSQL + ' JOIN MOVGPV GPV ON GPV.GPV_SEQFDO =  FDO.AUTOINCREM' ;
    strSQL := strSQL + ' JOIN MOVGPE GPE ON GPE.GPE_SEQGAD = GPV.GPV_SEQGAD' ;
    strSQL := strSQL + ' JOIN MOVGER G2 ON G2.AUTOINCREM = GPE.GPE_SEQBAI' ;
    strSQL := strSQL + ' WHERE G2.GER_NUMDOC = :NUMDOC  AND G2.GER_ESPDOC = :ESPDOC AND G2.GER_CODEMP = :CODEMP ' ;
{$ENDREGION}

  Result := False;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := strEspDoc;
      Qry.ParamByName('CODEMP').AsString := strCodEmp;

      Qry.Open;
      if Not Qry.IsEmpty then
      begin
        Result := True;
        Msg := 'Não é possível cancelar este documento porque ele está vinculado '+slinebreak+
                             ' a uma operação de garantia da própria empresa que contém o documento associado [%0:s-%1:s-%2:s].';

        msg := format(Msg,[Qry.FieldByName('GER_NUMDOC').AsString,
                           Qry.FieldByName('GER_ESPDOC').AsString,
                           Qry.FieldByName('GER_CODEMP').AsString]);


        fMensagem('Atenção!',Msg,['&Ok']);
      end;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      pMensagensErro(E.Message, '[fEhPedidoReposicaoGarantia]');
      Result := True;
    end;
  End;



end;


end.
