unit uGarantiaBaixaEnvioFornecedorConsertoModel;

interface
uses
  System.Generics.Collections, untTRestauraDel, Uni;

Type
  TDocumentoRecord = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strSerie_: String;
  end;
  TDocumento = TDocumentoRecord;
  TArrDocumentos = Array of TDocumento;


 type
    TItemDoc = class;
    TDocBaixa = Class;
    TItensDoc = TObjectList<TItemDoc>;
    TListaItensDoc = TItensDoc;

    TMovBCG = class
    public
      AutoIncrem: String;
      strMotBai: String;
      strSeqGer: String;
      strCodOpe: String;
      strCodFor: String;
      dtaDtaEmi: TDateTime;
      function fGravar: boolean;virtual;
      function fSqlGravar: String;

    end;

    TMovBCD = class
    Private
      FfltQtdBai: Double;
      procedure pSetfltQtdBai(const fltQtd: Double);virtual;
    public
      Autoincrem: String;
      strSeqGae: String;
      strSeqBcg: String;
      strNumEnv: String;
      strEspEnv: String;
      strEmpEnv: String;
      blnDelGae: Boolean;
      function fGravar: Boolean;
      property fltQtdBai: Double Read FfltQtdBai Write pSetfltQtdBai;
    end;


    TDocBaixa = class(TMovBCG)
    private
      function GravarItens: Boolean;
      function fSqlCarregarAutIncRetorno: String;
    public
      blnAnularEnvio: Boolean;
      blnEmitirDocEntradaProprio: Boolean;
      ItensDoc: TListaItensDoc;
      strClaFis: String;
      strNumDoc: String;
      strEspDoc: String;
      constructor Create;
      destructor Destroy;override;
      function fstrDesCla:String;
      function fGravar: boolean;override;
      function fChavesGarantias: String;
      procedure pCarregarAutIncRetorno;
      function fBaixarEnvioFornecedor: boolean;
      function fBaixarRetorno: Boolean;
    end;

    TItemDoc = class(TMovBCD)
    private
      function fGetPrecus: Double;
      function fGetUnitar: Double;
    public
      strCodIte: String;
      strSeqGad: String;
      strSeqDet: String;
      strNumEnt: String;
      strDesIte: String;
      strCodFor: String;
      strClaFis: String;
      strLotSai: String;
      strTabPre: String;
      fltQtdIte: Double;
      fltValIte: Double;
      fltTotUni: Double;
      fltTotCus: Double;
      fltQtdRef: Double;
      fltQtdRet: Double;
      fltQtdEnv: Double;
      constructor Create;
      function fCustoTotal: Double;
      function fValorItens: Double;
      function fSaldoEnvioFornecedor: Double;
      function fAplicarBaixaNoEnvio: boolean;
      function fExluirEnvio: boolean;
      procedure pSetfltQtdBai(const fltQtd: Double);override;
      property fltPreCus: Double  Read fGetPreCus;
      property fltUnitar: Double  Read fGetUnitar;
    end;

    TCancelamentoBaixaEnvio = class
    private
      function fSqlDocBaixaEnvio: String;
      function fSqlMovGaeBaixada: String;
      procedure pMensagemNaoPermitidoCancelarEnvio(arrDocBai: TArrDocumentos);
      function fExcluirMovBCG(const strIncBCG: String): Boolean;
      function fExcluir(const strTabela, strAutInc: String): Boolean;
      function fEstornarBaixaMovGae(const strIncGae: String; const fltQtdBai: Double): boolean;
      function fPermiteEstornarDocumentosBaixa(Qry: TUniQuery): Boolean;
      function fEstornarBaixaItensDocumento(Qry: TUniQuery): Boolean;
      function fSqlExisteDocumentoBaixaEnvioMaisRecente: String;
      function fVerificarSeExisteDocumentoBaixaEnvioMaisRecente(const aDocEnvio: TDocumento; const strIncBcg: String; dtaEmissao: TDateTime): Boolean;
      procedure pExibirMsgNaoPermitirEstornar;

    public
      Class function fConverterEspDocSelparaEspDoc(const strEspDocSel: String): String;
      class function fVerificarMovGaeBaixada(const strNumDoc, strEspDoc, strCodEmp: String): Boolean;overload;
      class function fEstornarBaixaEnvioConserto(const strNumDoc, strEspDoc, strCodEmp: String; blnTestando: boolean = False): Boolean;
    end;


implementation

uses
  StrUtils,System.DateUtils, SysUtils, Db, Classes, untFuncoesSimples, untGarant, untFuncoes, untGarantiaLibDiversos,
  UniClientDataSet,
  untTGarantiaRetornoFornecedor;


{ TMovBCG }


function TMovBCG.fSqlGravar: String;
begin
  Result := 'INSERT INTO MOVBCG (AUTOINCREM, BCG_DTAENT, BCG_MOTIVO, BCG_CODFOR, BCG_SEQGER,  BCG_CODOPE) ';
  Result := Result + 'VALUES (:AUTOINCREM, :BCG_DTAENT, :BCG_MOTIVO, :BCG_CODFOR, :BCG_SEQGER, :BCG_CODOPE) ';
end;

function TMovBCG.fGravar: boolean;
var
 QryMovBcg: TUniQuery;
 strSql: String;
 dtaDtaEnt: TDateTime;
begin

  dtaDtaEnt := EncodeDateTime(YearOf(self.dtaDtaEmi),
                            MonthOf(self.dtaDtaEmi),
                            DayOf(self.dtaDtaEmi),
                            HourOf(fNow()),
                            MinuteOf(fNow()),
                            SecondOf(fNow()),
                            0);

  QryMovBcg := nil;
  Result := True;
  Try
    strSQL := fSqlGravar;
    Try
      if fEmptyStr(Self.AutoIncrem) then
        Self.AutoIncrem := fRetAutoIncrem('MOVBCG',VS_strCodEmp);
      QryMovBcg := fCriaQuery;
      QryMovBcg.close;
      QryMovBcg.Sql.Clear;
      QryMovBcg.Sql.Add(strSql);
      QryMovBcg.ParamByName('AUTOINCREM').AsString :=  Self.AutoIncrem;
      QryMovBcg.ParamByName('BCG_DTAENT').AsDateTime :=  dtaDtaEnt;
      QryMovBcg.ParamByName('BCG_MOTIVO').AsString :=  Self.strMotBai;
      QryMovBcg.ParamByName('BCG_CODFOR').AsString :=  Self.strCodFor;
      QryMovBcg.ParamByName('BCG_SEQGER').AsString :=  Self.strSeqGer;
      QryMovBcg.ParamByName('BCG_CODOPE').AsString :=  Self.strCodOpe;
      QryMovBcg.ExecSQL;
    Except
      On E: Exception do
      begin
        Result := False;
        Raise Exception.Create('Erro ao gravar baixa de envio para conserto! ' +
                E.Message +  ' - [fGravar]');
      end;
    End;
  Finally
    if Assigned(QryMovBCG) then
      QryMovBCG.Free;
  End;
end;

{ TMovBCD }

function TMovBCD.fGravar: Boolean;
var
 QryMovBcd: TUniQuery;
 strSql: String;
begin
  Result := True;
  strSql := ' INSERT INTO MOVBCD (AUTOINCREM,  BCD_SEQGAE,  BCD_QTDBAI,  BCD_SEQBCG,  BCD_NUMENV,  BCD_ESPENV,  BCD_EMPENV,  BCD_DELGAE) ';
  strSql := strSql + ' VALUES   (:AUTOINCREM, :BCD_SEQGAE, :BCD_QTDBAI, :BCD_SEQBCG, :BCD_NUMENV, :BCD_ESPENV, :BCD_EMPENV, :BCD_DELGAE); ';

  QryMovBcd := nil;
  Try
    Try
      if fEmptyStr(Self.AutoIncrem) then
        Self.Autoincrem := fRetAutoIncrem('MOVBCD',VS_strCodEmp);

      QryMovBcd := fCriaQuery;
      QryMovBcd.close;
      QryMovBcd.Sql.Clear;
      QryMovBcd.Sql.Add(strSql);
      QryMovBcd.ParamByName('AUTOINCREM').AsString :=  Self.Autoincrem;
      QryMovBcd.ParamByName('BCD_SEQBCG').AsString :=  Self.strSeqBCG;
      QryMovBcd.ParamByName('BCD_SEQGAE').AsString :=  Self.strSeqGae;
      QryMovBcd.ParamByName('BCD_NUMENV').AsString :=  Self.strNumEnv;
      QryMovBcd.ParamByName('BCD_ESPENV').AsString :=  Self.strEspEnv;
      QryMovBcd.ParamByName('BCD_EMPENV').AsString :=  Self.strEmpEnv;
      QryMovBcd.ParamByName('BCD_QTDBAI').AsFloat  :=  Self.fltQtdBai;
      QryMovBcd.ParamByName('BCD_DELGAE').AsString :=  ifthen(Self.blnDelGae,'S','N');
      QryMovBcd.ExecSQL;
    Except
      On E: Exception do
      begin
        Result := False;
        Raise Exception.Create('Erro ao gravar itens da baixa de envio para conserto! ' +
                E.Message +  ' - [fGravar]');
      end;
    End;
  Finally
    if Assigned(QryMovBcd) then
      QryMovBcd.Free;
  End;
end;


procedure TMovBCD.pSetfltQtdBai(const fltQtd: Double);
begin
  FfltQtdBai := fltQtd;
end;

{ TCancelamentoBaixaEnvio }

function TCancelamentoBaixaEnvio.fSqlMovGaeBaixada: String;
begin
  Result := ' SELECT  G2.GER_NUMDOC, G2.GER_ESPDOC, G2.GER_CODEMP, G2.GER_SERIE_ ';
  Result := Result + ' FROM  MOVBCD D ';
  Result := Result + ' INNER JOIN MOVBCG G ON G.AUTOINCREM = D.BCD_SEQBCG ';
  Result := Result + ' INNER JOIN MOVGER G2 ON G2.AUTOINCREM = G.BCG_SEQGER ';
  Result := Result + ' WHERE BCD_NUMENV = :NUMDOC AND BCD_EMPENV = :EMPDOC AND BCD_ESPENV = :ESPDOC ';
  Result := Result + ' ORDER BY G.BCG_DTAENT DESC ';
end;

class function TCancelamentoBaixaEnvio.fVerificarMovGaeBaixada(const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  objCanc: TCancelamentoBaixaEnvio;
  Qry: TUniQuery;
  arrDocBai: TArrDocumentos;
  strSQL: String;
begin
  SetLength(arrDocBai,0);
  objCanc := TCancelamentoBaixaEnvio.Create;
  strSQL := objCanc.fSqlMovGaeBaixada;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.ParamByName('NUMDOC').AsString :=  strNumDoc;
    Qry.ParamByName('EMPDOC').AsString :=  strCodEmp;
    Qry.ParamByName('ESPDOC').AsString :=  fConverterEspDocSelparaEspDoc(strEspDoc);
    Qry.Open;
    if Not Qry.isEmpty then
    begin
      Qry.First;
      while Not Qry.Eof do
      begin
        Setlength(arrDocBai,Length(arrDocBai)+1);
        arrDocBai[high(arrDocBai)].strNumDoc := Qry.FieldByName('GER_NUMDOC').AsString;
        arrDocBai[high(arrDocBai)].strEspDoc := Qry.FieldByName('GER_ESPDOC').AsString;
        arrDocBai[high(arrDocBai)].strCodEmp := Qry.FieldByName('GER_CODEMP').AsString;
        arrDocBai[high(arrDocBai)].strSerie_ := Qry.FieldByName('GER_SERIE_').AsString;
        Qry.Next;
      end;
    end;

    Result := length(arrDocBai) > 0;
    if Result then
      objCanc.pMensagemNaoPermitidoCancelarEnvio(arrDocBai);
  Finally
    if Assigned(objCanc) then
      objCanc.Free;
    if Assigned(Qry) then
      Qry.Free;
  End;
end;

function TCancelamentoBaixaEnvio.fSqlDocBaixaEnvio: String;
begin
  Result := 'SELECT    G1.AUTOINCREM AS INCGER, ';
  Result := Result + ' G2.AUTOINCREM AS INCBCG, ';
  Result := Result + ' G2.BCG_DTAENT AS DTAENT, ';
  Result := Result + ' D2.AUTOINCREM AS INCBCD, ';
  Result := Result + ' D2.BCD_NUMENV AS NUMENV, ';
  Result := Result + ' D2.BCD_ESPENV AS ESPENV, ';
  Result := Result + ' D2.BCD_EMPENV AS EMPENV, ';
  Result := Result + ' D2.BCD_SEQGAE AS INCGAE, ';
  Result := Result + ' D2.BCD_DELGAE AS DELGAE, ';
  Result := Result + ' D2.BCD_QTDBAI AS QTDBAI ';
  Result := Result + 'FROM  MOVGER G1 ';
  Result := Result + 'INNER JOIN MOVBCG G2 ON G2.BCG_SEQGER = G1.AUTOINCREM ';
  Result := Result + 'INNER JOIN MOVBCD D2 ON D2.BCD_SEQBCG = G2.AUTOINCREM ';
  Result := Result + 'WHERE G1.GER_NUMDOC = :NUMDOC  AND G1.GER_CODEMP = :CODEMP AND G1.GER_ESPDOC = :ESPDOC ';
end;

class function TCancelamentoBaixaEnvio.fEstornarBaixaEnvioConserto(const strNumDoc, strEspDoc, strCodEmp: String; blnTestando: boolean = False): Boolean;
var
  objCanc: TCancelamentoBaixaEnvio;
  strSQL: String;
  strIncBCG: String;
  Qry: TUniQuery;
  blnPermitido: Boolean;
begin
  Qry := Nil;
  Try
    objCanc :=  TCancelamentoBaixaEnvio.Create;
    strSQL := objCanc.fSqlDocBaixaEnvio;
    Try
      Qry := fCriaQuery;
      Qry.close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('NUMDOC').AsString := strNumDoc;
      Qry.ParamByName('ESPDOC').AsString := fConverterEspDocSelparaEspDoc(strEspDoc);
      Qry.ParamByName('CODEMP').AsString := strCodEmp;
      Qry.Open;

      Result :=  Qry.IsEmpty;

      if Not Result then
      begin
        Qry.First;
        strIncBCG := Qry.FieldByName('INCBCG').AsString;
        blnPermitido := objCanc.fPermiteEstornarDocumentosBaixa(Qry);

        Result := blnPermitido and blnTestando;

        if (Not Result) and blnPermitido then
        begin
          Result := objCanc.fEstornarBaixaItensDocumento(Qry);
          if Result then
            Result := objCanc.fExcluirMovBCG(strIncBCG);
        end;

        if Not blnPermitido then
          objCanc.pExibirMsgNaoPermitirEstornar;
      end;
    Finally
     Qry.Free;
     FreeAndNil(ObjCanc);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;



function TCancelamentoBaixaEnvio.fEstornarBaixaItensDocumento(Qry: TUniQuery): Boolean;
const
  SIM: String = 'S';
begin
  Result := False;
  Qry.First;
  while Not Qry.Eof do
  begin
    if Qry.FieldByName('DELGAE').AsString = SIM then
    begin
      TRestauraDel.pRestauraTabela('MOVGAE', Qry.FieldByName('INCGAE').AsString);
      Result := True;
    end
    else
    begin
      Result := Self.fEstornarBaixaMovGae(Qry.FieldByName('INCGAE').AsString, Qry.FieldByName('QTDBAI').AsFloat);
    end;
    if Not Result  then
      Break;
    Qry.Next;
  end;
end;


function TCancelamentoBaixaEnvio.fPermiteEstornarDocumentosBaixa(Qry: TUniQuery): Boolean;
Var
  DocEnvio: TDocumento;
  dtaEmissao: TDateTime;
  strIncBcg: String;
begin
  Result := False;
  Qry.First;
  while Not Qry.Eof do
  begin
    DocEnvio.strNumDoc := Qry.FieldByName('NUMENV').AsString;
    DocEnvio.strEspDoc := Qry.FieldByName('ESPENV').AsString;
    DocEnvio.strCodEmp := Qry.FieldByName('EMPENV').AsString;
    strIncBcg          := Qry.FieldByName('INCBCG').AsString;
    dtaEmissao         := Qry.FieldByName('DTAENT').AsDateTime;
    Result := fVerificarSeExisteDocumentoBaixaEnvioMaisRecente(DocEnvio,strIncBcg, dtaEmissao);
    if Not Result then
      Break;
    Qry.Next;
  end;
end;

function TCancelamentoBaixaEnvio.fExcluirMovBCG(const strIncBCG: String): Boolean;
begin
  Result := fExcluir('MOVBCG',strIncBCG);
end;

function TCancelamentoBaixaEnvio.fSqlExisteDocumentoBaixaEnvioMaisRecente: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT COUNT(1) AS QTDDOCUMENTOS ';
  Result := Result + ' FROM MOVBCG G ';
  Result := Result + ' WHERE G.AUTOINCREM <> :INCBCG ';
  Result := Result +        ' AND G.BCG_DTAENT >= :DTAEMI ';
  Result := Result +        ' AND EXISTS (SELECT 1 ';
  Result := Result +                    ' FROM MOVBCD D ';
  Result := Result +                    ' WHERE D.BCD_NUMENV = :NUMENV ';
  Result := Result +                          ' AND D.BCD_ESPENV = :ESPENV ';
  Result := Result +                          ' AND D.BCD_EMPENV = :EMPENV ';
  Result := Result +                          ' AND D.BCD_SEQBCG = G.AUTOINCREM) ';
end;

function TCancelamentoBaixaEnvio.fVerificarSeExisteDocumentoBaixaEnvioMaisRecente(const aDocEnvio: TDocumento; const strIncBcg: String; dtaEmissao: TDateTime): Boolean;
Var
  Qry: TUniQuery;
begin
  Qry := nil;
  Result := True;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.clear;
      Qry.Sql.Add(fSqlExisteDocumentoBaixaEnvioMaisRecente);
      Qry.ParamByName('INCBCG').AsString := strIncBcg;
      Qry.ParamByName('DTAEMI').AsDateTime := dtaEmissao;
      Qry.ParamByName('NUMENV').AsString := aDocEnvio.strNumDoc;
      Qry.ParamByName('ESPENV').AsString := aDocEnvio.strEspDoc;
      Qry.ParamByName('EMPENV').AsString := aDocEnvio.strCodEmp;
      Qry.Open;

      if Qry.Isempty then
       Exit;

      Qry.First;
      Result := Qry.FieldByName('QTDDOCUMENTOS').AsInteger = 0;

    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  end;

end;

function TCancelamentoBaixaEnvio.fEstornarBaixaMovGae(const strIncGae: String; const fltQtdBai: Double): boolean;
CONST
   SQLUPDATE: String = 'UPDATE MOVGAE SET GAE_QTDENV = (GAE_QTDENV + :QTDBAI) WHERE AUTOINCREM = :INCGAE ';


Var
  Qry: TUniQuery;

begin
  Qry := nil;
  Result := True;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.Sql.clear;
      Qry.Sql.Add(SQLUPDATE);
      Qry.ParamByName('INCGAE').AsString := strIncGae;
      Qry.ParamByName('QTDBAI').AsFloat  := fltQtdBai;
      Qry.ExecSql;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  end;

end;

function TCancelamentoBaixaEnvio.fExcluir(const strTabela, strAutInc: String): Boolean;
CONST
   SQLDEL: String = 'DELETE FROM %s WHERE AUTOINCREM = :AUTINC ';

Var
  strSQL: String;
  Qry: TUniQuery;

begin
  Qry := nil;
  Result := True;
  Try
    strSQL := Format(SQLDEL,[strTabela]);
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.Sql.clear;
      Qry.Sql.Add(strSql);
      Qry.ParamByName('AUTINC').AsString := strAutInc;
      Qry.ExecSql;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  end;

end;

procedure TCancelamentoBaixaEnvio.pExibirMsgNaoPermitirEstornar;
begin
  fMensagem('Atenção!','Este documento não pode ser estornado porque um ou mais itens estão vinculados a outros documentos de baixa mais recentes.',['&Ok']);
end;

procedure TCancelamentoBaixaEnvio.pMensagemNaoPermitidoCancelarEnvio(arrDocBai: TArrDocumentos);
const
  LIMITE_DOC_MSG: Integer = 3;
  MSG: String = 'Cancele as baixas antes de continuar. '+sLineBreak+
                ' Documento(s) de baixa (EF) [Número-Série-Espécie-Loja]: '+sLineBreak+'%s';

Var
  strMsg: String;
  i: Integer;
  blnContinuar: boolean;
begin
  strMsg := EmptyStr;
  i := 0;
  Repeat
    strMsg := strMsg + fConcatenar([arrDocBai[i].strNumDoc,
                                    arrDocBai[i].strSerie_,
                                    arrDocBai[i].strEspDoc,
                                    arrDocBai[i].strCodEmp],
                                   '-');

    inc(i);
    blnContinuar := i < length(arrDocBai);
    if blnContinuar then
    begin
      strMsg := strMsg+sLineBreak;
      blnContinuar := i < LIMITE_DOC_MSG;
      if Not blnContinuar then
       strMsg := strMsg+ Format(' e mais %s documento(s).',[Integer.ToString((length(arrDocBai) - LIMITE_DOC_MSG))]);
    end;
  Until Not blnContinuar ;

  fMensagem('Atenção',Format(MSG,[strMsg]),['&OK']);
end;

class function TCancelamentoBaixaEnvio.fConverterEspDocSelparaEspDoc(const strEspDocSel: String): String;
const
  OUTRAS_ENTRADAS_FORNECEDOR = 0;
  GARANTIA_FORNECEDOR = 1;
  NOTA_GARANTIA_FORNECEDOR = 2;
  NOTA_RETORNO_FORNECEDOR = 3;
  NOTA_FISCAL: String = 'NF';
  DOC_GARANTIA_FORNECEDOR: String = 'GF';

begin
  case IndexStr(strEspDocSel,['EF','GF','NG','NR']) of
    OUTRAS_ENTRADAS_FORNECEDOR  : Result := NOTA_FISCAL;
    GARANTIA_FORNECEDOR         : Result := DOC_GARANTIA_FORNECEDOR;
    NOTA_GARANTIA_FORNECEDOR    : Result := NOTA_FISCAL;
    NOTA_RETORNO_FORNECEDOR     : Result := NOTA_FISCAL;
    Else
      Result := strEspDocSel;
  end;
end;


{ TItemDoc }

function TItemDoc.fCustoTotal: Double;
begin
  Result := fltQtdIte * fltPreCus;
end;

function TItemDoc.fExluirEnvio: boolean;
CONST
  SQLGAE: String = 'SELECT * FROM MOVGAE WHERE AUTOINCREM = :AUTINC ';
var
 Qry: TUniQuery;
begin
  Try
    Qry := fCriaQuery;
    Try
      Qry.close;
      Qry.Sql.Clear;
      Qry.Sql.Add(SQLGAE);
      Qry.ParamByName('AUTINC').AsString := Self.strSeqGae;
      Qry.Open;
      if Not Qry.IsEmpty then
      begin
        Qry.First;
        fVerificaIntegridade('frmGarantiaBaixaEnvnioFornecedorConserto', 'MOVGAE', qry, True);
        Qry.Delete;
      end;
      Result := True;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Raise Exception.Create('Erro ao tentar excluir MovGae! ' +
              E.Message +  ' - [fExluirEnvio]');
    end;
  End;
end;

function TItemDoc.fGetPrecus: Double;
begin
  Result := fltTotCus/fltQtdBai;
end;

function TItemDoc.fGetUnitar: Double;
begin
  Result := fltTotUni/fltQtdBai;
end;

function TItemDoc.fSaldoEnvioFornecedor: Double;
begin
 Result := fltQtdEnv - (fltQtdRef + fltQtdRet);
end;

function TItemDoc.fValorItens: Double;
begin
  Result := fltQtdIte * fltValIte;
end;

procedure TItemDoc.pSetfltQtdBai(const fltQtd: Double);
Var
  fltSaldo: double;
  blnTemRetFor: Boolean;
begin
  inherited;
  fltSaldo := Self.fSaldoEnvioFornecedor - fltQtd;
  blnTemRetFor := (Self.fltQtdRef + Self.fltQtdRet) > 0;
  Self.blnDelGae := (fltSaldo = 0) and (Not blnTemRetFor);
end;

constructor TItemDoc.Create;
begin
  strCodIte :=  EmptyStr;
  strSeqGad :=  EmptyStr;
  strSeqDet :=  EmptyStr;
  strNumEnt :=  EmptyStr;
  strDesIte :=  EmptyStr;
  strCodFor :=  EmptyStr;
  strClaFis :=  EmptyStr;
  strLotSai :=  EmptyStr;
  strTabPre :=  EmptyStr;
  fltQtdIte :=  0;
  fltValIte :=  0;
  fltTotUni :=  0;
  fltTotCus :=  0;
  fltQtdBai :=  0;
  blnDelGae := False;
end;

function TItemDoc.fAplicarBaixaNoEnvio: boolean;
var
 Qry: TUniQuery;
 strSql: String;
begin
  strSql := ' UPDATE MOVGAE SET GAE_QTDENV = (GAE_QTDENV - :QTDBAI)  WHERE AUTOINCREM = :AUTOINCREM ';
  Qry := nil;
  Try
    Try
      Qry := fCriaQuery;
      Qry.close;
      Qry.Sql.Clear;
      Qry.Sql.Add(strSql);
      Qry.ParamByName('AUTOINCREM').AsString :=  Self.strSeqGae;
      Qry.ParamByName('QTDBAI').AsFloat :=  Self.fltQTDBAI;
      Qry.ExecSQL;
      Result := True;
    Finally
      if Assigned(Qry) then
        Qry.Free;
    End;
  Except
    On E: Exception do
    begin
      Raise Exception.Create('Erro ao gravar baixa Envio - MOVGAE! ' +
              E.Message +  ' - [fAtualizarRetornoMovGae]');
    end;
  End;

end;


{ TDocBaixa }

constructor TDocBaixa.Create;
begin
  Self.ItensDoc := TListaItensDoc.Create;
  Self.blnAnularEnvio := False;
  Self.blnEmitirDocEntradaProprio := False;
end;

destructor TDocBaixa.Destroy;
begin
  if Assigned(Self.ItensDoc) then
  begin
    Self.ItensDoc.clear;
    if Assigned(Self.ItensDoc) then
      Self.ItensDoc.free;
  end;

  inherited;
end;

function TDocBaixa.GravarItens: Boolean;
Var
  ItemDoc: TItemDoc;
begin
  Result := True;
  for ItemDoc in Self.ItensDoc do
  begin
    ItemDoc.strSeqBcg := Self.Autoincrem;
    ItemDoc.Autoincrem := fRetAutoIncrem('MOVBCD',VS_strCodEmp);

    if ItemDoc.blnDelGae and (Not Self.blnAnularEnvio) then
      ItemDoc.blnDelGae := False;

    Result := ItemDoc.fGravar;
    if Not Result then
      Break;
  end;
end;

function TDocBaixa.fBaixarEnvioFornecedor: Boolean;
Var
  ItemDoc: TItemDoc;
begin
  Result  := Self.fGravar;

  If Not Result then
    Exit;

  if blnEmitirDocEntradaProprio and Self.blnAnularEnvio then
  begin
    for ItemDoc in Self.ItensDoc do
    begin
      if ItemDoc.blnDelGae then
        Result := ItemDoc.fExluirEnvio
      else
        Result := ItemDoc.fAplicarBaixaNoEnvio;

      if Not Result then
        Break;
    end;
  end
  else
    Result := fBaixarRetorno;

end;

function TDocBaixa.fBaixarRetorno: Boolean;
Var
  objRetornoFornecedor: TRetornoFornecedor;
  lItemDoc: TItemDoc;
  lItemRetornado: TItemRetornado;
  larrIncGad: Array of String;
  lcdsProdutosRetornados: TUniClientDataSet;
begin
  Result := False;
  objRetornoFornecedor := TRetornoFornecedor.Create(nil, orBaixa);
  Try
    SetLength(larrIncGad, 0);
    objRetornoFornecedor.strCodFor := Self.strCodFor;
    objRetornoFornecedor.strCodOpe := strLoginUsuarioLogado;
    objRetornoFornecedor.strMotivo := Self.strMotBai;
    objRetornoFornecedor.strNomFrmOrigem := 'TfrmGarantiaBaixaEnvioFornecedorConserto';

    For lItemDoc  in Self.ItensDoc do
    begin
      SetLength(larrIncGad, Length(larrIncGad)+1);
      larrIncGad[Length(larrIncGad)-1] := lItemDoc.strSeqGad;
    end;

    Try
      lcdsProdutosRetornados := objRetornoFornecedor.fObterProdutosRetornadosPorMovGad(larrIncGad);

      if lcdsProdutosRetornados.IsEmpty then
        raise Exception.Create('Não foram encontrados retornos para os itens selecionados.')
      else
        Result := True;

      For lItemDoc  in Self.ItensDoc do
      begin
        if Not lcdsProdutosRetornados.locate('AUTINC', lItemDoc.strSeqGad, []) then
          raise Exception.Create('´Retorno não encontrado para item selecionado!');

        objRetornoFornecedor.pCarregarItemRetornado(lcdsProdutosRetornados, lItemRetornado);
        lItemRetornado.blnSELECIONADO := True;
        lItemRetornado.fltQTDRET_1 := lItemDoc.fltQtdBai;

        if Not objRetornoFornecedor.fIncluirItem(lItemRetornado) then
        begin
          Result := False;
          Break;
        end
      end;

    Except
      On E: Exception do
      begin
        if Result then
          Result := False;
        pMensagensErro(E.Message, '[TDocBaixa.fBaixarRetorno]');
        Exit;
      end;
    End;

    if Not Result then
      Exit;

    Result :=  objRetornoFornecedor.fBaixarEnvio(False);
  Finally
    Finalize(larrIncGad);
    if Assigned(lcdsProdutosRetornados) then
      FreeAndNil(lcdsProdutosRetornados);
    objRetornoFornecedor.Free;
  End;
end;

function TDocBaixa.fChavesGarantias: String;
Var
  objItemDoc: TItemDoc;
begin
  Result := EmptyStr;
  for objItemDoc in Self.ItensDoc do
  begin
    if Pos(objItemDoc.strNumEnt,Result) = 0 then
      Result := Result +Format('%s,',[QuotedStr(objItemDoc.strNumEnt)]);
  end;

  if fEmptyStr(Result) then
    Exit;

  Result := Copy(Result,1,(length(Result)-1));
end;

function TDocBaixa.fGravar: boolean;
begin
  Result := Inherited fGravar;
  if Result then
  begin
    Result := Self.GravarItens;
  end;
end;

function TDocBaixa.fstrDesCla: String;
begin
 Result := fRetDesCla(Self.strClaFis);
end;

function TDocBaixa.fSqlCarregarAutIncRetorno: String;
begin
  Result := 'SELECT AUTOINCREM, DET_CODITE, DET_QTDITE, IFNULL(DET_NUMLOT,'''') AS DET_NUMLOT ';
  Result := Result + 'FROM MOVDET ';
  Result := Result + 'WHERE DET_SEQGER = :AUTOINCREM ';
end;

procedure TDocBaixa.pCarregarAutIncRetorno;
Var
 Qry: TUniQuery;
 ItemDoc: TItemDoc;
 strSQL: String;
begin
  Qry := nil;
  Try
    Try
      strSQL :=  fSqlCarregarAutIncRetorno;
      Qry := fCriaQuery();
      Qry.Sql.Clear;
      Qry.Sql.Add(strSQL);
      Qry.ParamByName('AUTOINCREM').AsString := Self.strSeqGer;
      Qry.Open;
      if Not Qry.IsEmpty then
      begin
        for ItemDoc in Self.ItensDoc  do
        begin
          if Qry.FieldByName('DET_CODITE').AsString = ItemDoc.strCodIte then
          begin
            if Qry.FieldByName('DET_NUMLOT').AsString = ItemDoc.strLotSai  then
            begin
              ItemDoc.strSeqDet := Qry.FieldByName('AUTOINCREM').AsString;
            end;
          end;
        end;
        Qry.Close;
      end;
    Except
      ON E: Exception do
      begin
        Raise Exception.Create('Erro ao carregar documento retorno! ' +
                E.Message +  ' - [pCarregarAutIncRetorno]');
      end;

    End;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  End;
end;

end.

