unit untTPreparaRequisicaoCompra;

interface

Uses
  Classes, UniClientDataSet, DB, SysUtils, Forms, Windows, Controls,
  Uni, cxProgressBar, StrUtils, untTypesSistema, untFuncoesSimples,
  System.Generics.Collections;

Type
  TItemRequisicaoCompra = class(TObject)
  Private
    FAutInc: String;
    FCodReq: String;
    FEmpReq: String;
    FCodOpe: String;
    FCodIte: String;
    FNumLot: String;
    FNumDoc: String;
    FEspDoc: String;
    FEmpDoc: String;
    FObserv: String;
    FQtdIte: Double;
    FDtaCad: TDateTime;
    FHorCad: TDateTime;
    FSeqPCD: String;
  Public
    Constructor Create; Overload;
    Constructor Create(ACodReq, AEmpReq, ACodOpe, ACodIte, ANumLot, ANumDoc, AEspDoc, AEmpDoc, AObserv: String;
      AQtdIte: Double; ADtaCad, AHorCad: TDateTime; ASeqPCD: String = ''); Overload;

    Destructor Destroy; Override;

    procedure fSetAutInc(Value: String);
    procedure fSetCodReq(Value: String);
    procedure fSetEmpReq(Value: String);
    procedure fSetCodOpe(Value: String);
    procedure fSetCodIte(Value: String);
    procedure fSetNumLot(Value: String);
    procedure fSetQtdIte(Value: Double);
    procedure fSetDtaCad(Value: TDateTime);
    procedure fSetHorCad(Value: TDateTime);
    procedure fSetNumDoc(Value: String);
    procedure fSetEspDoc(Value: String);
    procedure fSetEmpDoc(Value: String);
    procedure fSetObserv(Value: String);
    procedure fSetSeqPCD(Value: String);

    function fGetAutInc: String;
    function fGetCodReq: String;
    function fGetEmpReq: String;
    function fGetCodOpe: String;
    function fGetCodIte: String;
    function fGetNumLot: String;
    function fGetQtdIte: Double;
    function fGetDtaCad: TDateTime;
    function fGetHorCad: TDateTime;
    function fGetNumDoc: String;
    function fGetEspDoc: String;
    function fGetEmpDoc: String;
    function fGetObserv: String;
    function fGetSeqPCD: String;
  End;

  TPreparaRequisicaoCompra = class(TObject)
  Private
    FRequisicoes: TUniQuery;
    FItensRequisicao: TObjectList<TItemRequisicaoCompra>;

    function fGetSQL_Insert: String;
    function fGetSQL_RequisicoesPendentes: String;
    procedure pPesquisarRequisicoes(qryTemp: TUniQuery);
  Public
    Constructor Create;
    Destructor Destroy; Override;

    procedure pAdicionarItemRequisicao(item: TItemRequisicaoCompra);
    procedure pGerarRequisicoesMultiLoja;
    function  fGerarRequisicoesMultiLoja(pgbProgresso: TcxProgressBar): Boolean;
    function  fGravarRequisicao: Boolean;

    property ItensRequisicao: TObjectList<TItemRequisicaoCompra> Read FItensRequisicao;
  End;

implementation

{ TPreparaRequisicaoCompra }

uses untFatRequisicaoCompras, untRelFatRequisicaoCompras, untGravando,
  untAtualizaOcorrenciasCRM, untTypesCRM, untTSituacaoPedidoVenda;

constructor TPreparaRequisicaoCompra.Create;
begin
  inherited Create;

  FRequisicoes := fCriaQuery();
  FItensRequisicao := TObjectList<TItemRequisicaoCompra>.Create();
end;

destructor TPreparaRequisicaoCompra.Destroy;
begin
  FreeAndNil(FRequisicoes);
  FreeAndNil(FItensRequisicao);

  inherited;
end;

function TPreparaRequisicaoCompra.fGerarRequisicoesMultiLoja(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strDocAnt: String;
    strEspAnt: String;
    strEmpAnt: String;

    qryUpdate: TUniQuery;
    strCodSeq: String;
    strInRqCp: String;
    strIncRcd: String;
    blnTransacaoAberta: Boolean;

  procedure pAtualizarRequisicao(const AAutInc: String);
  begin
    qryUpdate.Close();
    qryUpdate.SQL.Clear();
    qryUpdate.SQL.Add('UPDATE PREPRQ SET');
    qryUpdate.SQL.Add('  PRQ_CODREQ = :CODREQ, PRQ_SEQRCD = :SEQRCD');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryUpdate.ParamByName('AUTINC').AsString := FRequisicoes.FieldByName('AUTOINCREM').AsString;
    qryUpdate.ParamByName('CODREQ').AsString := strCodSeq;
    qryUpdate.ParamByName('SEQRCD').AsString := AAutInc;
    qryUpdate.ExecSQL();
  end;

  procedure pAtualizarSeqRequisicaoPedido;
  begin
    qryUpdate.Close();
    qryUpdate.SQL.Clear();
    qryUpdate.SQL.Text := ' UPDATE FATGOR INNER JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM '+
                          ' SET FGO_INRQCP = :INRQCP '+
                          ' WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP ';

    qryUpdate.ParamByName('INRQCP').AsString := strInRqCp;
    qryUpdate.ParamByName('NUMDOC').AsString := FRequisicoes.FieldByName('NUMDOC').AsString;
    qryUpdate.ParamByName('ESPDOC').AsString := FRequisicoes.FieldByName('ESPDOC').AsString;
    qryUpdate.ParamByName('CODEMP').AsString := FRequisicoes.FieldByName('EMPDOC').AsString;

    qryUpdate.ExecSQL();
  end;

  procedure pRegistraOcorrenciaCRM(const strNumDoc, strEspDoc, strCodEmp: String);
  begin
    If (VS_strHabilitarCRM) Then
      TUpdateOccurrenceCRM.New()
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strCodEmp)
        .AcaFat(afcPedidoReqCompraGerada)
        .strNomFrm('[TPreparaRequisicaoCompra.fGerarRequisicoesMultiLoja]')
        .pRun();
  end;

  procedure pProcessaStatusPedido(const strNumDoc, strEspDoc, strCodEmp: String);
  begin
    TUpdateStatus.New(TParamStatus.New()
                        .NumDoc(strNumDoc)
                        .EspDoc(strEspDoc)
                        .CodEmp(strCodEmp)).pExecute();
  end;
begin
  Result := True;
  blnTransacaoAberta := fInTransaction();

  Try
    If Not fLock_Unlock('PEDIDOS_PREPARACAO_RQ', True, False) Then
      Exit;

    qryUpdate := fCriaQuery();

    strDocAnt := '';
    strEspAnt := '';
    strEmpAnt := '';

    FRequisicoes.IndexFieldNames := 'NUMDOC;ESPDOC;EMPDOC';

    Try
      FRequisicoes.Refresh();

      If (Not FRequisicoes.IsEmpty) Then
      Begin
        If (Not blnTransacaoAberta) Then
          fStartTransaction();

        FRequisicoes.First;

        While (Not FRequisicoes.Eof) Do
        Begin
          strIncRcd := '';
          If Concat(strDocAnt, strEspAnt, strEmpAnt) <>
             Concat(FRequisicoes.FieldByName('NUMDOC').AsString,
                    FRequisicoes.FieldByName('ESPDOC').AsString,
                    FRequisicoes.FieldByName('EMPDOC').AsString) Then
          Begin
            If (Not fEmptyStr(strDocAnt)) Then
            Begin
              pRegistraOcorrenciaCRM(strDocAnt, strEspAnt, strEmpAnt);
              pProcessaStatusPedido(strDocAnt, strEspAnt, strEmpAnt);
            End;

            strDocAnt := FRequisicoes.FieldByName('NUMDOC').AsString;
            strEspAnt := FRequisicoes.FieldByName('ESPDOC').AsString;
            strEmpAnt := FRequisicoes.FieldByName('EMPDOC').AsString;

            strCodSeq := fAtualizaProCod('MOVRCG', 'RCG_CODIGO');

            TfrmFatRequisicaoCompras.pIncluiMovRcg(strCodSeq,
                                                   FRequisicoes.FieldByName('CODCLI').AsString,
                                                   FRequisicoes.FieldByName('CODVEN').AsString,
                                                   FRequisicoes.FieldByName('C_G_C_').AsString,
                                                   VS_Date,
                                                   '',
                                                   '',
                                                   '');

            strInRqCp := fCampoTabela('AUTOINCREM', 'MOVRCG', ['RCG_CODIGO','RCG_CODEMP'], [strCodSeq, VS_strCodEmp]);
          End;

          strIncRcd := TfrmFatRequisicaoCompras.fIncluiMovRcd(strCodSeq,
                                                              FRequisicoes.FieldByName('CODITE').AsString,
                                                              FRequisicoes.FieldByName('DESITE').AsString,
                                                              FRequisicoes.FieldByName('OBSERV').AsString,
                                                              FRequisicoes.FieldByName('NUMDOC').AsString,
                                                              FRequisicoes.FieldByName('ESPDOC').AsString,
                                                              FRequisicoes.FieldByName('EMPDOC').AsString,
                                                              FRequisicoes.FieldByName('QTDITE').AsFloat,
                                                              0,
                                                              '',
                                                              FRequisicoes.FieldByName('SEQPCD').AsString);

          pAtualizarRequisicao(strIncRcd);
          pAtualizarSeqRequisicaoPedido();

          FRequisicoes.Next();
        End;

        pRegistraOcorrenciaCRM(strDocAnt, strEspAnt, strEmpAnt);
        pProcessaStatusPedido(strDocAnt, strEspAnt, strEmpAnt);

        If (Not blnTransacaoAberta) Then
          fCommit();
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack();
        pMensagensErro(E.Message, '[TPreparaRequisicaoCompra.fGerarRequisicoesMultiLoja]');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);

    fLock_Unlock('PEDIDOS_PREPARACAO_RQ', False, False);
  End;
end;

function TPreparaRequisicaoCompra.fGetSQL_Insert: String;
begin
  Result := 'INSERT INTO PREPRQ ( ' +
                ' AUTOINCREM, ' +
                ' PRQ_CODREQ, ' +
                ' PRQ_EMPREQ, ' +
                ' PRQ_CODOPE, ' +
                ' PRQ_CODITE, ' +
                ' PRQ_NUMLOT, ' +
                ' PRQ_QTDITE, ' +
                ' PRQ_DTACAD, ' +
                ' PRQ_HORCAD, ' +
                ' PRQ_NUMDOC, ' +
                ' PRQ_ESPDOC, ' +
                ' PRQ_OBSERV, ' +
                ' PRQ_EMPDOC, ' +
                ' PRQ_SEQPCD) VALUES ( ' +
                '   :AUTINC, ' +
                '   :CODREQ, ' +
                '   :EMPREQ, ' +
                '   :CODOPE, ' +
                '   :CODITE, ' +
                '   :NUMLOT, ' +
                '   :QTDITE, ' +
                '   :DTACAD, ' +
                '   :HORCAD, ' +
                '   :NUMDOC, ' +
                '   :ESPDOC, ' +
                '   :OBSERV, ' +
                '   :EMPDOC, ' +
                '   :SEQPCD) ';
end;

function TPreparaRequisicaoCompra.fGetSQL_RequisicoesPendentes: String;
begin
  Result := 'SELECT ' +
            '  FGO_CODCLI AS CODCLI, ' +
            '  FGO_CODVEN AS CODVEN, ' +
            '  CLI_C_G_C_ AS C_G_C_, ' +
            '  PRQ_CODITE AS CODITE, ' +
            '  ITE_DESITE AS DESITE, ' +
            '  PRQ_OBSERV AS OBSERV, ' +
            '  PRQ_NUMDOC AS NUMDOC, ' +
            '  PRQ_ESPDOC AS ESPDOC, ' +
            '  PRQ_EMPDOC AS EMPDOC, ' +
            '  PRQ_QTDITE AS QTDITE, ' +
            '  PRQ_SEQPCD AS SEQPCD, ' +
            '  PREPRQ.AUTOINCREM ' +
            'FROM ' +
            '  PREPRQ ' +
            '  LEFT JOIN FATGOR ' +
            '    ON PRQ_NUMDOC = FGO_NUMDOC ' +
            '    AND PRQ_ESPDOC = FGO_ESPDOC ' +
            '    AND PRQ_EMPDOC = FGO_CODEMP ' +
            '  LEFT JOIN CADCLI ' +
            '    ON CLI_CODCLI = FGO_CODCLI ' +
            '  LEFT JOIN CADITE ' +
            '    ON ITE_CODITE = PRQ_CODITE ' +
            'WHERE PRQ_EMPREQ = :CODEMP ' +
            '  AND IFNULL(PRQ_CODREQ, "") = "" ';
end;

function TPreparaRequisicaoCompra.fGravarRequisicao: Boolean;
  Var
    i: Integer;
    qryTemp: TUniQuery;
    blnTransacaoAberta: Boolean;
begin
  Result := True;
  blnTransacaoAberta := fInTransaction();

  Try
    qryTemp := fCriaQuery();

    Try
      If (Not blnTransacaoAberta) Then
        fStartTransaction();

      For i := 0 To FItensRequisicao.Count - 1 Do
      Begin
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := fGetSQL_Insert();

        FItensRequisicao.Items[i].fSetAutInc(fRetAutoIncrem('PREPRQ', VS_strCodEmp));

        qryTemp.ParamByName('AUTINC').AsString   := FItensRequisicao.Items[i].fGetAutInc();
        qryTemp.ParamByName('CODREQ').AsString   := FItensRequisicao.Items[i].fGetCodReq();
        qryTemp.ParamByName('EMPREQ').AsString   := FItensRequisicao.Items[i].fGetEmpReq();
        qryTemp.ParamByName('CODOPE').AsString   := FItensRequisicao.Items[i].fGetCodOpe();
        qryTemp.ParamByName('CODITE').AsString   := FItensRequisicao.Items[i].fGetCodIte();
        qryTemp.ParamByName('NUMLOT').AsString   := FItensRequisicao.Items[i].fGetNumLot();
        qryTemp.ParamByName('NUMDOC').AsString   := FItensRequisicao.Items[i].fGetNumDoc();
        qryTemp.ParamByName('ESPDOC').AsString   := FItensRequisicao.Items[i].fGetEspDoc();
        qryTemp.ParamByName('EMPDOC').AsString   := FItensRequisicao.Items[i].fGetEmpDoc();
        qryTemp.ParamByName('OBSERV').AsString   := FItensRequisicao.Items[i].fGetObserv();
        qryTemp.ParamByName('QTDITE').AsFloat    := FItensRequisicao.Items[i].fGetQtdIte();
        qryTemp.ParamByName('DTACAD').AsDateTime := FItensRequisicao.Items[i].fGetDtaCad();
        qryTemp.ParamByName('HORCAD').AsDateTime := FItensRequisicao.Items[i].fGetHorCad();
        qryTemp.ParamByName('SEQPCD').AsString   := FItensRequisicao.Items[i].fGetSeqPCD();

        If (fEmptyStr(qryTemp.ParamByName('CODREQ').AsString)) Then qryTemp.ParamByName('CODREQ').Clear();
        If (fEmptyStr(qryTemp.ParamByName('EMPREQ').AsString)) Then qryTemp.ParamByName('EMPREQ').Clear();
        If (fEmptyStr(qryTemp.ParamByName('CODOPE').AsString)) Then qryTemp.ParamByName('CODOPE').Clear();
        If (fEmptyStr(qryTemp.ParamByName('CODITE').AsString)) Then qryTemp.ParamByName('CODITE').Clear();
        If (fEmptyStr(qryTemp.ParamByName('NUMLOT').AsString)) Then qryTemp.ParamByName('NUMLOT').Clear();
        If (fEmptyStr(qryTemp.ParamByName('NUMDOC').AsString)) Then qryTemp.ParamByName('NUMDOC').Clear();
        If (fEmptyStr(qryTemp.ParamByName('ESPDOC').AsString)) Then qryTemp.ParamByName('ESPDOC').Clear();
        If (fEmptyStr(qryTemp.ParamByName('EMPDOC').AsString)) Then qryTemp.ParamByName('EMPDOC').Clear();
        If (fEmptyStr(qryTemp.ParamByName('OBSERV').AsString)) Then qryTemp.ParamByName('OBSERV').Clear();
        If (fEmptyStr(qryTemp.ParamByName('SEQPCD').AsString)) Then qryTemp.ParamByName('SEQPCD').Clear();

        qryTemp.ExecSQL();
      End;

      If (Not blnTransacaoAberta) Then
        fCommit();
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack();
        pMensagensErro(E.Message, '[TPreparaRequisicaoCompra.fGravarRequisicao]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TPreparaRequisicaoCompra.pAdicionarItemRequisicao(item: TItemRequisicaoCompra);
begin
  FItensRequisicao.Add(item);
end;

procedure TPreparaRequisicaoCompra.pGerarRequisicoesMultiLoja;
var
  LfrmGravando: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, LfrmGravando);

    pPesquisarRequisicoes(FRequisicoes);

    If (Not FRequisicoes.IsEmpty) Then
    Begin
      LfrmGravando.lblGravando.Caption := 'Aguarde, gerando requisições de compra...';
      LfrmGravando.fExecutarAcao := fGerarRequisicoesMultiLoja;
      LfrmGravando.ShowModal;
    End;
  Finally
    pFreeAndNil(LfrmGravando);
  End;
end;

procedure TPreparaRequisicaoCompra.pPesquisarRequisicoes(qryTemp: TUniQuery);
begin
  If (Not Assigned(qryTemp)) Then
    Exit;

  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := fGetSQL_RequisicoesPendentes();
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.Open();
  qryTemp.First();
end;

{ TItemRequisicaoCompra }

constructor TItemRequisicaoCompra.Create;
begin
  inherited Create;

  Self.fSetCodReq('');
  Self.fSetEmpReq('');
  Self.fSetCodOpe('');
  Self.fSetCodIte('');
  Self.fSetNumLot('');
  Self.fSetQtdIte(0);
  Self.fSetDtaCad(0);
  Self.fSetHorCad(0);
  Self.fSetNumDoc('');
  Self.fSetEspDoc('');
  Self.fSetEmpDoc('');
  Self.fSetObserv('');
  Self.fSetSeqPCD('');
end;

constructor TItemRequisicaoCompra.Create(ACodReq, AEmpReq, ACodOpe, ACodIte,
  ANumLot, ANumDoc, AEspDoc, AEmpDoc, AObserv: String; AQtdIte: Double; ADtaCad,
  AHorCad: TDateTime; ASeqPCD: String = '');
begin
  inherited Create;

  Self.fSetCodReq(ACodReq);
  Self.fSetEmpReq(AEmpReq);
  Self.fSetCodOpe(ACodOpe);
  Self.fSetCodIte(ACodIte);
  Self.fSetNumLot(ANumLot);
  Self.fSetQtdIte(AQtdIte);
  Self.fSetDtaCad(ADtaCad);
  Self.fSetHorCad(AHorCad);
  Self.fSetNumDoc(ANumDoc);
  Self.fSetEspDoc(AEspDoc);
  Self.fSetEmpDoc(AEmpDoc);
  Self.fSetObserv(AObserv);
  Self.fSetSeqPCD(ASeqPCD);
end;

destructor TItemRequisicaoCompra.Destroy;
begin
  inherited;
end;

function TItemRequisicaoCompra.fGetAutInc: String;
begin
  Result := Self.FAutInc;
end;

function TItemRequisicaoCompra.fGetCodIte: String;
begin
  Result := Self.FCodIte;
end;

function TItemRequisicaoCompra.fGetCodOpe: String;
begin
  Result := Self.FCodOpe;
end;

function TItemRequisicaoCompra.fGetCodReq: String;
begin
  Result := Self.FCodReq;
end;

function TItemRequisicaoCompra.fGetDtaCad: TDateTime;
begin
  Result := Self.FDtaCad;
end;

function TItemRequisicaoCompra.fGetEmpDoc: String;
begin
  Result := Self.FEmpDoc;
end;

function TItemRequisicaoCompra.fGetEmpReq: String;
begin
  Result := Self.FEmpReq;
end;

function TItemRequisicaoCompra.fGetEspDoc: String;
begin
  Result := Self.FEspDoc;
end;

function TItemRequisicaoCompra.fGetHorCad: TDateTime;
begin
  Result := Self.FHorCad;
end;

function TItemRequisicaoCompra.fGetNumDoc: String;
begin
  Result := Self.FNumDoc;
end;

function TItemRequisicaoCompra.fGetNumLot: String;
begin
  Result := Self.FNumLot;
end;

function TItemRequisicaoCompra.fGetObserv: String;
begin
  Result := Self.FObserv;
end;

function TItemRequisicaoCompra.fGetQtdIte: Double;
begin
  Result := Self.FQtdIte;
end;

function TItemRequisicaoCompra.fGetSeqPCD: String;
begin
  Result := Self.FSeqPCD;
end;

procedure TItemRequisicaoCompra.fSetAutInc(Value: String);
begin
  Self.FAutInc := Value;
end;

procedure TItemRequisicaoCompra.fSetCodIte(Value: String);
begin
  Self.FCodIte := Value;
end;

procedure TItemRequisicaoCompra.fSetCodOpe(Value: String);
begin
  Self.FCodOpe := Value;
end;

procedure TItemRequisicaoCompra.fSetCodReq(Value: String);
begin
  Self.FCodReq := Value;
end;

procedure TItemRequisicaoCompra.fSetDtaCad(Value: TDateTime);
begin
  Self.FDtaCad := Value;
end;

procedure TItemRequisicaoCompra.fSetEmpDoc(Value: String);
begin
  Self.FEmpDoc := Value;
end;

procedure TItemRequisicaoCompra.fSetEmpReq(Value: String);
begin
  Self.FEmpReq := Value;
end;

procedure TItemRequisicaoCompra.fSetEspDoc(Value: String);
begin
  Self.FEspDoc := Value;
end;

procedure TItemRequisicaoCompra.fSetHorCad(Value: TDateTime);
begin
  Self.FHorCad := Value;
end;

procedure TItemRequisicaoCompra.fSetNumDoc(Value: String);
begin
  Self.FNumDoc := Value;
end;

procedure TItemRequisicaoCompra.fSetNumLot(Value: String);
begin
  Self.FNumLot := Value;
end;

procedure TItemRequisicaoCompra.fSetObserv(Value: String);
begin
  Self.FObserv := Value;
end;

procedure TItemRequisicaoCompra.fSetQtdIte(Value: Double);
begin
  Self.FQtdIte := Value;
end;

procedure TItemRequisicaoCompra.fSetSeqPCD(Value: String);
begin
  Self.FSeqPCD := Value;
end;

end.
