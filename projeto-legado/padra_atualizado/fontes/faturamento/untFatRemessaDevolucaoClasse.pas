unit untFatRemessaDevolucaoClasse;

interface

uses
  Uni, Types, Data.DB, strUtils, SysUtils, Classes, System.DateUtils, untFuncoesSimples, untFuncoesGenerica, UniClientDataSet,
  untCadLote, Math, untFatVendas, untTypesSistema, untAuditoriaGravacaoSaldo, untConstantes,
  System.Generics.Collections, untDicSis;

type
  TRecItemRemessa = Record
    AutInc: String;
    CodIte: String;
    QtdIte: Double;
  End;

  TArrItemRemessa = Array of TRecItemRemessa;

TRemessaDevolucao = class
  private
    FNumDoc: String;
    FEspDoc: String;
    FNumFat: String;
    FEspFat: String;
    FCodCli: String;
    FNumLot: String;
    FDtaEnt: TDate;
    FHorEnt: TTime;
    FClaFis: String;
    FAutIncMovGer: String;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    function fLocalizaDocumento(AChaveAcesso: String; Var AAutIncDoc: String): Boolean;
    function fExisteRemessa(AAutIncDoc: String; AEhCancelamento: Boolean = False): Boolean;
    procedure pAtualizaLotePedidoEnderecamento(AAutInc, ANumLot: String);
    function fCriaTransferencia(ANumRemessa, ANumLot: String; AArrItemRemessa: TArrItemRemessa): Boolean;
    function fGravaMovGerTransf: Boolean;
    function fGravaMovDetTransf(AArrItemRemessa: TArrItemRemessa): Boolean;
    function fSQLItem: String;
    function fCancelaTL(AIncDev: String): Boolean;
    function fCancelaLote(ANumRemessa: String; AAlterar: Boolean): Boolean;
    function fCancelaDocumentoRemessa(ANumRemessa: String; AAlterar: Boolean = False): Boolean;
    procedure pRetornaLotePedidoEnderecamento(AAutInc, ANumLot: String);
    function fRemessaJaFezEnderecamento(ANumRemessa: String): Boolean;
    function fAtualizaLibCol(ANumRemessa: String): Boolean;
    function fClassificacaoEhPermitida(AClaFis : String) : Boolean;
    function fMarcaIncGor(const AIncGor, AChaveAcesso: String): Boolean;
  public
    function fValidaChaveAcesso(AChaveAcesso: String; Var AAutIncDoc: String): Boolean;
    function fGerarRemessa(AAutInc: String; Var ANumRemessa: String; ATipoOperacao: TTipoOperacaoRemessa; AAlterar: Boolean = False): Boolean;
    function fCarregaRemessa(Var ACdsRemessa: TUniClientDataSet; ANumeroRemessa: String): Boolean;
    procedure pAbreTransferenciaEstoque(ANumRemessa: String);
    function fCancelaRemessa(ANumRemessa: String; AAlterar: Boolean = False): Boolean;
    procedure pImprimeRemessaDevolucao(ANumRemessa: String);
    function fContemRemessaVinculadaPeloCancelamento(ANumDoc, AEspDoc: String): Boolean;
    function fTemPedidoDeEnderecamentoVinculado(const AChaveAcesso: String; AJaEnderecado: Boolean = False): Boolean;
    function fVerificaNotaFulfillment(const AChaveAcesso: String; out AImport: String): Boolean;
    function fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment(const AChaveAcesso: String; out AMensagem: String): Boolean;

    class function fValidaRemessa(ANumRemessa, AOpcDoc: String): Boolean;

    constructor Create;
end;

procedure pVinculaRemessaDevolucao(strOpcDoc, strNumRemessa, strAutInc, strItens: String);

implementation

uses
  untMovGer, untEditorFastImpressao, TypesRel, untCfgRel, untEnderecamentoProduto,
  untTransferenciaArmazens;

Const
  STR_CLAENT = '1999';
  STR_CLASAI = '5999';
  LOT_ADEFINIR = 'A DEFINIR';

{ TRemessaDevolucao }

constructor TRemessaDevolucao.Create;
begin
  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

function TRemessaDevolucao.fAtualizaLibCol(ANumRemessa: String): Boolean;
var
  LQryAtualiza: TUniQuery;
begin
  LQryAtualiza := fCriaQuery;

  try
    Result := False;

    LQryAtualiza.Close;
    LQryAtualiza.SQL.Clear;
    LQryAtualiza.SQL.Add('UPDATE REMDEV');
    LQryAtualiza.SQL.Add('SET RMV_LIBCOL = "N" ');
    LQryAtualiza.SQL.Add('WHERE RMV_NUMREM = :NUMREM');
    LQryAtualiza.SQL.Add('AND RMV_EMPREM = :EMPREM');

    LQryAtualiza.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryAtualiza.ParamByName('EMPREM').AsString := VS_strCodEmp;

    LQryAtualiza.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryAtualiza);
  end;
end;

function TRemessaDevolucao.fCancelaDocumentoRemessa(
  ANumRemessa: String; AAlterar: Boolean = False): Boolean;
var
  LQryRemessa: TUniQuery;
begin
  LQryRemessa := fCriaQuery;

  try
    Result := False;

    if not AAlterar then
    begin
      LQryRemessa.Close;
      LQryRemessa.SQL.Clear;
      LQryRemessa.SQL.Add('SELECT * FROM REMDEV WHERE RMV_EMPREM = :EMPREM AND RMV_NUMREM = :NUMREM');
      LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;
      LQryRemessa.ParamByName('NUMREM').AsString := ANumRemessa;
      LQryRemessa.ExecSQL;

      if LQryRemessa.IsEmpty then
        Exit;

      while not LQryRemessa.Eof do
      begin
        fVerificaIntegridade('TRemessaDevolucao', 'REMDEV', LQryRemessa, True, False, 'Cancelamento de Remessa', strLoginUsuarioLogado);
        LQryRemessa.Next;
      end;
    end;

    LQryRemessa.Close;
    LQryRemessa.SQL.Clear;
    LQryRemessa.SQL.Add('DELETE FROM REMDEV WHERE RMV_EMPREM = :EMPREM AND RMV_NUMREM = :NUMREM');
    LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryRemessa.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryRemessa.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryRemessa);
  end;
end;

function TRemessaDevolucao.fCancelaLote(ANumRemessa: String; AAlterar: Boolean): Boolean;
var
  LQryLote: TUniQuery;
begin
  LQryLote := fCriaQuery;

  try
    Result := False;

    LQryLote.Close;
    LQryLote.SQL.Clear;

    if AAlterar then
      LQryLote.SQL.Add('UPDATE CADLOT SET LOT_STATUS = "N" WHERE LOT_CODEMP = :CODEMP AND LOT_AUTREM = :NUMREM')
    else
      LQryLote.SQL.Add('DELETE FROM CADLOT WHERE LOT_CODEMP = :CODEMP AND LOT_AUTREM = :NUMREM');

    LQryLote.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryLote.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryLote.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryLote);
  end;
end;

function TRemessaDevolucao.fCancelaRemessa(ANumRemessa: String; AAlterar: Boolean = False): Boolean;
var
  LQryRemessa: TUniQuery;
  LLoteRemessa: String;
  LObjCadLote: TCadLot;
  LIncDev: String;
  LIniciouTransacaoLocal: Boolean;

  procedure pAbortaTransacao;
  begin
    if LIniciouTransacaoLocal then
      fRollback;
  end;
begin
  Result := False;
  LIniciouTransacaoLocal := False;

  if (not fInTransaction) then
    LIniciouTransacaoLocal := fStartTransaction;

  try
    LQryRemessa := fCriaQuery;
    LObjCadLote := TCadLot.Create(Nil);

    try
      LQryRemessa.Close;
      LQryRemessa.SQL.Clear;
      LQryRemessa.SQL.Add('SELECT *');
      LQryRemessa.SQL.Add('FROM REMDEV');
      LQryRemessa.SQL.Add('WHERE RMV_NUMREM = :NUMREM');
      LQryRemessa.SQL.Add('AND RMV_EMPREM = :EMPREM');
      LQryRemessa.ParamByName('NUMREM').AsString := ANumRemessa;
      LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;
      LQryRemessa.Open;

      if LQryRemessa.IsEmpty then
      begin
        pAbortaTransacao;
        Exit;
      end;

      LLoteRemessa := Concat(LQryRemessa.FieldByName('RMV_TIPOPE').AsString, '_', ANumRemessa);
      LIncDev := LQryRemessa.FieldByName('AUTOINCREM').AsString;

      if LQryRemessa.FieldByName('RMV_TIPOPE').AsString = 'REM_COL' then
      begin
        if fVerificaLCKATCNomeParcial(LLoteRemessa) Then
        begin
          pAbortaTransacao;
          fMensagem('ATENÇÃO!', 'Esta remessa está sendo utilizado por outra estação:' + fGetHostLock(LLoteRemessa), ['&Ok']);
          Exit;
        end;

        if fRemessaJaFezEnderecamento(ANumRemessa) then
        begin
          pAbortaTransacao;
          fMensagem('ATENÇÃO!', 'Esta remessa já foi endereçada no coletor e não pode ser alterada / cancelada.', ['&Ok']);
          Exit;
        end;

        if not fAtualizaLibCol(ANumRemessa) then
        begin
          pAbortaTransacao;
          fMensagem('ATENÇÃO!', 'Erro ao atualizar RMV_LIBCOL.', ['&Ok']);
          Exit;
        end;
      end;

      while not LQryRemessa.Eof do
      begin
        LObjCadLote.fAtualizaEstoqueLote(LQryRemessa.FieldByName('RMV_CODITE').AsString,
                                         'S',
                                         LLoteRemessa,
                                         LQryRemessa.FieldByName('RMV_QTDITE').AsFloat);

        LObjCadLote.fAtualizaEstoqueLote(LQryRemessa.FieldByName('RMV_CODITE').AsString,
                                         'E',
                                         LQryRemessa.FieldByName('RMV_LOTFDE').AsString,
                                         LQryRemessa.FieldByName('RMV_QTDITE').AsFloat);

        pRetornaLotePedidoEnderecamento(LQryRemessa.FieldByName('RMV_AUTFDE').AsString, LQryRemessa.FieldByName('RMV_LOTFDE').AsString);

        LQryRemessa.Next;
      end;

      if not fCancelaTL(LIncDev) then
      begin
        pAbortaTransacao;
        fMensagem('ATENÇÃO!', 'Não foi possível cancelar a remessa!', ['&Ok']);
        Exit;
      end;

      if not fCancelaLote(ANumRemessa, AAlterar) then
      begin
        pAbortaTransacao;
        fMensagem('ATENÇÃO!', 'Não foi possível cancelar a remessa!', ['&Ok']);
        Exit;
      end;

      if not fCancelaDocumentoRemessa(ANumRemessa, AAlterar) then
      begin
        pAbortaTransacao;
        fMensagem('ATENÇÃO!', 'Não foi possível cancelar a remessa!', ['&Ok']);
        Exit;
      end;

      if LIniciouTransacaoLocal then
        fCommit;

      Result := True;
    finally
      FreeAndNil(LQryRemessa);
      FreeAndNil(LObjCadLote);
    end;
  except
    On E: Exception Do
    Begin
      pAbortaTransacao;
      pMensagensErro(E.Message, '[TRemessaDevolucao.fCancelaRemessa]');
    End;
  end;
end;

function TRemessaDevolucao.fCarregaRemessa(var ACdsRemessa: TUniClientDataSet;
  ANumeroRemessa: String): Boolean;
var
  LQryRemessa: TUniQuery;
begin
  ACdsRemessa.DisableControls;
  LQryRemessa := fCriaQuery;

  try
    ACdsRemessa.EmptyDataSet;

    LQryRemessa.Close;
    LQryRemessa.SQL.Clear;
    LQryRemessa.SQL.Add('SELECT DISTINCT G.AUTOINCREM, G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP, F.FIS_ACESSO,');
    LQryRemessa.SQL.Add('       C.CLI_NOMCLI, G.GER_CODCLI, G.GER_DTAENT, G.GER_HORENT');
    LQryRemessa.SQL.Add('FROM MOVGER G');
    LQryRemessa.SQL.Add('INNER JOIN MOVDET D');
    LQryRemessa.SQL.Add('ON(G.AUTOINCREM = D.DET_SEQGER)');
    LQryRemessa.SQL.Add('INNER JOIN REMDEV R');
    LQryRemessa.SQL.Add('ON(R.RMV_AUTDEV = D.AUTOINCREM)');
    LQryRemessa.SQL.Add('INNER JOIN CADFIS F');
    LQryRemessa.SQL.Add('ON(G.GER_NUMDOC = F.FIS_NUMDOC');
    LQryRemessa.SQL.Add('   AND G.GER_ESPDOC = F.FIS_ESPDOC');
    LQryRemessa.SQL.Add('   AND G.GER_CODEMP = F.FIS_CODEMP');
    LQryRemessa.SQL.Add('   AND G.GER_SERIE_ = F.FIS_SERIE_');
    LQryRemessa.SQL.Add('   AND G.GER_TIP_FC = F.FIS_TIP_FC');
    LQryRemessa.SQL.Add('   AND  IF(F.FIS_TIP_FC="C", G.GER_CODCLI, G.GER_CODFOR) = F.FIS_FORCLI )');
    LQryRemessa.SQL.Add('INNER JOIN CADCLI C');
    LQryRemessa.SQL.Add('ON(G.GER_CODCLI = C.CLI_CODCLI)');
    LQryRemessa.SQL.Add('WHERE R.RMV_NUMREM = :NUMREM');
    LQryRemessa.SQL.Add('AND R.RMV_ESPREM = :ESPREM');
    LQryRemessa.SQL.Add('AND R.RMV_EMPREM = :EMPREM');

    LQryRemessa.ParamByName('NUMREM').AsString := ANumeroRemessa;
    LQryRemessa.ParamByName('ESPREM').AsString := 'RD';
    LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;

    LQryRemessa.Open;

    while not LQryRemessa.Eof do
    begin
      ACdsRemessa.Append;
      ACdsRemessa.FieldByName('DTAENT').AsDateTime := LQryRemessa.FieldByName('GER_DTAENT').AsDateTime;
      ACdsRemessa.FieldByName('HORENT').AsDateTime := LQryRemessa.FieldByName('GER_HORENT').AsDateTime;
      ACdsRemessa.FieldByName('NUMDOC').AsString := LQryRemessa.FieldByName('GER_NUMDOC').AsString;
      ACdsRemessa.FieldByName('ESPDOC').AsString := LQryRemessa.FieldByName('GER_ESPDOC').AsString;
      ACdsRemessa.FieldByName('CODEMP').AsString := LQryRemessa.FieldByName('GER_CODEMP').AsString;
      ACdsRemessa.FieldByName('CODCLI').AsString := LQryRemessa.FieldByName('GER_CODCLI').AsString;
      ACdsRemessa.FieldByName('NOMCLI').AsString := LQryRemessa.FieldByName('CLI_NOMCLI').AsString;
      ACdsRemessa.FieldByName('ACESSO').AsString := LQryRemessa.FieldByName('FIS_ACESSO').AsString;
      ACdsRemessa.FieldByName('AUTINC').AsString := LQryRemessa.FieldByName('AUTOINCREM').AsString;
      ACdsRemessa.Post;
      LQryRemessa.Next;
    end;

    Result := ACdsRemessa.RecordCount > 0;

    if not Result then
      fMensagem('ATENÇÃO!', 'Remessa não encontrada!', ['&Ok']);
  finally
    FreeAndNil(LQryRemessa);
    ACdsRemessa.EnableControls;
  end;
end;

function TRemessaDevolucao.fClassificacaoEhPermitida(AClaFis: String): Boolean;
  var
    LOutrasEntradas : String;
begin

  LOutrasEntradas := '1949_2949_1907_2907_';

  Result := True;

  If (Pos(AClaFis, fCfgSis('CLADEV')) > 0) Then
    Exit;

  If (Pos(AClaFis, LOutrasEntradas) > 0) Then
    Exit;

  Result := False;

end;

function TRemessaDevolucao.fExisteRemessa(AAutIncDoc: String; AEhCancelamento: Boolean = False): Boolean;
var
  LQryRemessa: TUniQuery;
  LDocumento: String;
  LRemessa: String;
  LMsgCancelamento: String;
begin
  LQryRemessa := fCriaQuery;

  try
    Result := False;
    LMsgCancelamento := EmptyStr;

    LQryRemessa.Close;
    LQryRemessa.SQL.Clear;
    LQryRemessa.SQL.Add('SELECT G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP, R.RMV_NUMREM ');
    LQryRemessa.SQL.Add('FROM MOVGER G');
    LQryRemessa.SQL.Add('INNER JOIN MOVDET D');
    LQryRemessa.SQL.Add('ON(G.AUTOINCREM = D.DET_SEQGER)');
    LQryRemessa.SQL.Add('INNER JOIN REMDEV R');
    LQryRemessa.SQL.Add('ON(D.AUTOINCREM = R.RMV_AUTDEV)');
    LQryRemessa.SQL.Add('WHERE G.AUTOINCREM = :AUTINC');
    LQryRemessa.ParamByName('AUTINC').AsString := AAutIncDoc;
    LQryRemessa.Open;

    if not LQryRemessa.IsEmpty then
    begin
      if AEhCancelamento then
        LMsgCancelamento := sLineBreak + 'Cancele a remessa para prosseguir.';

      LDocumento := Concat(LQryRemessa.FieldByName('GER_NUMDOC').AsString,'-',LQryRemessa.FieldByName('GER_ESPDOC').AsString,'-',LQryRemessa.FieldByName('GER_CODEMP').AsString);
      LRemessa := LQryRemessa.FieldByName('RMV_NUMREM').AsString;
      fMensagem('ATENÇÃO!', 'O documento '+LDocumento+' já está vinculado à remessa '+LRemessa+'.' + LMsgCancelamento, ['&Ok']);
      Result := True;
    end;
  finally
    FreeAndNil(LQryRemessa);
  end;
end;

function TRemessaDevolucao.fMarcaIncGor(const AIncGor, AChaveAcesso: String): Boolean;
begin
  Result := fExecutaSQL('UPDATE NFEIMP SET NFE_INCGOR = '+ QuotedStr(AIncGor) +
                        ' WHERE NFE_ACESSO = '+ QuotedStr(AChaveAcesso));
end;

function TRemessaDevolucao.fGeraPedidoReservaEstoqueParaEnderecamentoFulfillment(
  const AChaveAcesso: String; out AMensagem: String): Boolean;
  var
    qryMovDet: TUniQuery;
    endDoc: TEndDocumento;
    endIte: TEndItem;
    objEnderecamento: TEnderecamentoProduto;
    cdsItensTL: TUniClientDataSet;
    objTransf: TTransferenciaArmazens;
    strLotExt, strItensSemLote: String;
begin
  Result := False;
  AMensagem := EmptyStr;

  qryMovDet := fCriaQuery;

  try
    try
      qryMovDet.SQL.Add('SELECT DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_SERIE_, DET_CODCLI,');
      qryMovDet.SQL.Add('       DET_CODFOR, DET_TIP_FC, DET_CODITE, DET_DESCRI, DET_CODMAR,');
      qryMovDet.SQL.Add('       DET_REFERE, DET_UNIDAD, DET_FORITE, DET_QTDITE, DET_CODEXT ');
      qryMovDet.SQL.Add('FROM CADFIS');
      qryMovDet.SQL.Add('JOIN MOVDET ON DET_NUMDOC = FIS_NUMDOC');
      qryMovDet.SQL.Add('           AND DET_ESPDOC = FIS_ESPDOC');
      qryMovDet.SQL.Add('           AND DET_CODEMP = FIS_CODEMP');
      qryMovDet.SQL.Add('           AND DET_CODCLI = FIS_FORCLI');
      qryMovDet.SQL.Add('           AND DET_SERIE_ = FIS_SERIE_');
      qryMovDet.SQL.Add('JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
      qryMovDet.SQL.Add('WHERE FIS_ACESSO = :ACESSO');

      qryMovDet.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryMovDet.Open;

      if qryMovDet.IsEmpty then
      begin
        AMensagem := 'Documento não localizado. Chave de acesso: '+ AChaveAcesso;
        Exit;
      end;

      objEnderecamento := TEnderecamentoProduto.Create;
      objEnderecamento.blnPedidoDeEnderecamentoFulfillment := True;

      qryMovDet.First;

      FillChar(endDoc, SizeOf(endDoc), #0);

      endDoc.strNumDoc := qryMovDet.FieldByName('DET_NUMDOC').AsString;
      endDoc.strEspDoc := qryMovDet.FieldByName('DET_ESPDOC').AsString;
      endDoc.strSerie_ := qryMovDet.FieldByName('DET_SERIE_').AsString;
      endDoc.strCodEmp := qryMovDet.FieldByName('DET_CODEMP').AsString;
      endDoc.strCliFor := IIF(qryMovDet.FieldByName('DET_TIP_FC').AsString = 'C',
                              qryMovDet.FieldByName('DET_CODCLI').AsString,
                              qryMovDet.FieldByName('DET_CODFOR').AsString);
      endDoc.strTip_FC := qryMovDet.FieldByName('DET_TIP_FC').AsString;

      objEnderecamento.endDocumento := endDoc;

      while not qryMovDet.Eof do
      begin
        FillChar(endIte, SizeOf(endIte), #0);

        endIte.strCodIte := qryMovDet.FieldByName('DET_CODITE').AsString;
        endIte.strCodMar := qryMovDet.FieldByName('DET_CODMAR').AsString;
        endIte.strDesIte := qryMovDet.FieldByName('DET_DESCRI').AsString;
        endIte.strRefere := qryMovDet.FieldByName('DET_REFERE').AsString;
        endIte.strCodUni := qryMovDet.FieldByName('DET_UNIDAD').AsString;
        endIte.strCodFor := qryMovDet.FieldByName('DET_FORITE').AsString;
        endIte.fltQtdIte := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
        endIte.strCodAmz := LOT_ADEFINIR;

        objEnderecamento.pAddItem(endIte);

        qryMovDet.Next;
      end;

      fStartTransaction;

      Result := objEnderecamento.fGerarPedidoParaReservarEstoque;

      if Result then
      begin
        cdsItensTL := TUniClientDataSet.Create(nil);
        cdsItensTL.FieldDefs.Add('CODITE', ftString, fTamCodIte);
        cdsItensTL.FieldDefs.Add('ARMDES', ftString, 30);
        cdsItensTL.FieldDefs.Add('ARMORI', ftString, 30);
        cdsItensTL.FieldDefs.Add('QTDITE', ftFloat);
        cdsItensTL.CreateDataSet;

        strItensSemLote := EmptyStr;

        qryMovDet.First;
        while not qryMovDet.Eof do
        begin
          if not TCadLot.ExisteLoteEstoqueExterno(qryMovDet.FieldByName('DET_CODITE').AsString,
                                                  qryMovDet.FieldByName('DET_CODEXT').AsString,
                                                  qryMovDet.FieldByName('DET_CODEMP').AsString,
                                                  strLotExt) then
          begin
            pIncrementaListaStr(qryMovDet.FieldByName('DET_CODITE').AsString, strItensSemLote);
            qryMovDet.Next;
            Continue;
          end;

          cdsItensTL.Append;
          cdsItensTL.FieldByName('CODITE').AsString := qryMovDet.FieldByName('DET_CODITE').AsString;
          cdsItensTL.FieldByName('ARMDES').AsString := LOT_ADEFINIR;
          cdsItensTL.FieldByName('ARMORI').AsString := strLotExt;
          cdsItensTL.FieldByName('QTDITE').AsFloat  := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
          cdsItensTL.Post;

          qryMovDet.Next;
        end;

        if not fEmptyStr(strItensSemLote) then
        begin
          Result := False;
          AMensagem := 'O(s) produto(s) listado(s) abaixo não tem lote do Fulfillment cadastrado. Por favor, entre em contato '+
                       'com a Citel pois este lote deve ser cadastrado na importação da nota de remessa. Item(ns): '+ strItensSemLote;
        end;

        if Result then
        begin
          objTransf := TTransferenciaArmazens.Create(nil, cdsItensTL, nil, nil);

          Result := objTransf.fGeraTransferencia(True, False) and
                    fMarcaIncGor(objEnderecamento.strAutIncPed, AChaveAcesso);
        end;
      end;

      if Result then
        fCommit
      else
        fRollback;

    except
      on E: Exception do
      begin
        fRollback;
        Result := False;
        AMensagem := E.Message;
      end;
    end;
  finally
    FreeAndNil(qryMovDet);
    FreeAndNil(objEnderecamento);
    FreeAndNil(cdsItensTL);
    FreeAndNil(objTransf);
  end;
end;

function TRemessaDevolucao.fGerarRemessa(AAutInc: String; Var ANumRemessa: String; ATipoOperacao: TTipoOperacaoRemessa; AAlterar: Boolean = False): Boolean;
var
  LQryMovDet: TUniQuery;
  LQryRemessa: TUniQuery;
  LNumLot: String;
  LObjCadLote: TCadLot;
  LArrItemRemessa: TArrItemRemessa;
  LAutIncFatDor: String;
  LSiglaTipOpe: String;
  LLocFis: String;
  LAutIncRemessa: String;
  LAutIncLot: String;
  strCodErrosAuditoria: String;
  dicQtdLot: TDictionary<string, double>;
  strMsgErr: String;
  strChvBus: String;
  fltTotAux: Double;
  fltSalAut: Double;
  intIdx: Integer;
begin
  LQryMovDet := fCriaQuery;

  dicQtdLot := TDictionary<string, double>.Create;
  try
    Result := False;

    objAuditoriaSaldo.Limpar;

    fStartTransaction;

    if (AAlterar) and (Not fEmptyStr(ANumRemessa)) then
    begin
      if not fCancelaRemessa(ANumRemessa, AAlterar) then
      begin
        fRollBack;
        Exit;
      end;
    end;

    LQryMovDet.Close;
    LQryMovDet.SQL.Clear;
    LQryMovDet.SQL.Add('SELECT D.AUTOINCREM AS AUTINCMOVDET, D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP, FD.FDO_NUMLOT,');
    LQryMovDet.SQL.Add('       D.DET_CODITE, D.DET_QTDITE, E.FGO_SEQFGO, FD.AUTOINCREM AS AUTINCFATDOR');
    LQryMovDet.SQL.Add('FROM MOVDET D');
    LQryMovDet.SQL.Add('INNER JOIN EXTGOR E');
    LQryMovDet.SQL.Add('ON(D.DET_NUMDOC = SUBSTRING(E.FGO_DOCEND, 1, 12) AND');
    LQryMovDet.SQL.Add('   D.DET_ESPDOC = SUBSTRING(E.FGO_DOCEND, 13, 2) AND');
    LQryMovDet.SQL.Add('   D.DET_SERIE_ = SUBSTRING(E.FGO_DOCEND, 15, 3) AND');
    LQryMovDet.SQL.Add('   D.DET_CODEMP = SUBSTRING(E.FGO_DOCEND, 18, 3))');
    LQryMovDet.SQL.Add('INNER JOIN FATGOR F');
    LQryMovDet.SQL.Add('ON(E.FGO_SEQFGO = F.AUTOINCREM)');
    LQryMovDet.SQL.Add('INNER JOIN FATDOR FD');
    LQryMovDet.SQL.Add('ON(F.AUTOINCREM = FD.FDO_SEQGER AND FD.FDO_CODITE = D.DET_CODITE)');
    LQryMovDet.SQL.Add('WHERE DET_SEQGER IN ('+AAutInc+')');
    LQryMovDet.Open;

    if LQryMovDet.IsEmpty then
    begin
      fRollBack;
      Exit;
    end;

    try
      LQryRemessa := fCriaQuery;
      LObjCadLote := TCadLot.Create(Nil);

      try
        case ATipoOperacao of
          toRemessa: begin
                       LSiglaTipOpe := 'REM_DEV';
                       LLocFis := fCfgSis('RDDLFL', varString);
                     end;

          toTransferencia: begin
                             LSiglaTipOpe := 'REM_TRA';
                             LLocFis := fCfgSis('RDLFLT', varString);
                           end;

          toOutrasSaidas: begin
                            LSiglaTipOpe := 'REM_OUF';
                            LLocFis := fCfgSis('LFLOSF', varString);
                          end;

          toColetor: begin
                       LSiglaTipOpe := 'REM_COL';
                       LLocFis := fCfgSis('LFLGDC', varString);
                     end;
        end;

        if (not AAlterar) or (fEmptyStr(ANumRemessa)) then
          ANumRemessa := fRetSequencial('SEQRDV', VS_strCodEmp, 12);

        LNumLot := Concat(LSiglaTipOpe, '_', ANumRemessa);
        FillChar(LArrItemRemessa, Sizeof(LArrItemRemessa) , #0);
        LAutIncFatDor := EmptyStr;

        LQryRemessa.Close;
        LQryRemessa.SQL.Clear;
        LQryRemessa.SQL.Add('SELECT * FROM REMDEV WHERE FALSE');
        LQryRemessa.Open;

        while not LQryMovDet.Eof do
        begin
          if (LQryRemessa.Locate('RMV_AUTDEV', LQryMovDet.FieldByName('AUTINCMOVDET').AsString, [])) or
             (LQryRemessa.Locate('RMV_AUTFDE', LQryMovDet.FieldByName('AUTINCFATDOR').AsString, [])) then
          begin
            LQryMovDet.Next;
            Continue;
          end;

          if LObjCadLote.fExisteLote(LQryMovDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp, LNumLot, True, False) then
          begin
            LAutIncLot := fCampoTabela('AUTOINCREM', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [LQryMovDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp, LNumLot], False);
            LObjCadLote.fAtivarLote(LAutIncLot, True);
          end
          else
          begin
            LObjCadLote.pGravaLoteRemessaDevolucao(LNumLot, LQryMovDet.FieldByName('DET_CODITE').AsString, ANumRemessa, LLocFis);
          end;

          pIncrementaListaStr(LQryMovDet.FieldByName('AUTINCFATDOR').AsString, LAutIncFatDor, True);

          SetLength(LArrItemRemessa, Length(LArrItemRemessa) + 1);

          LAutIncRemessa := fRetAutoIncrem('REMDEV', VS_strCodEmp);

          LArrItemRemessa[Length(LArrItemRemessa) - 1].AutInc := LAutIncRemessa;
          LArrItemRemessa[Length(LArrItemRemessa) - 1].CodIte := LQryMovDet.FieldByName('DET_CODITE').AsString;
          LArrItemRemessa[Length(LArrItemRemessa) - 1].QtdIte := LQryMovDet.FieldByName('DET_QTDITE').AsFloat;

          LQryRemessa.Append;
          LQryRemessa.FieldByName('AUTOINCREM').AsString := LAutIncRemessa;
          LQryRemessa.FieldByName('RMV_DTACAD').AsDateTime := fRetDataServidor;
          LQryRemessa.FieldByName('RMV_HORCAD').AsDateTime := fRetHoraServidor;
          LQryRemessa.FieldByName('RMV_CODDIG').AsString := strLoginUsuarioLogado;
          LQryRemessa.FieldByName('RMV_EMPREM').AsString := VS_strCodEmp;
          LQryRemessa.FieldByName('RMV_NUMREM').AsString := ANumRemessa;
          LQryRemessa.FieldByName('RMV_ESPREM').AsString := 'RD';
          LQryRemessa.FieldByName('RMV_AUTDEV').AsString := LQryMovDet.FieldByName('AUTINCMOVDET').AsString;
          LQryRemessa.FieldByName('RMV_NUMDOC').AsString := LQryMovDet.FieldByName('DET_NUMDOC').AsString;
          LQryRemessa.FieldByName('RMV_ESPDOC').AsString := LQryMovDet.FieldByName('DET_ESPDOC').AsString;
          LQryRemessa.FieldByName('RMV_CODEMP').AsString := LQryMovDet.FieldByName('DET_CODEMP').AsString;
          LQryRemessa.FieldByName('RMV_CODITE').AsString := LQryMovDet.FieldByName('DET_CODITE').AsString;
          LQryRemessa.FieldByName('RMV_QTDITE').AsFloat := LQryMovDet.FieldByName('DET_QTDITE').AsFloat;
          LQryRemessa.FieldByName('RMV_TIPOPE').AsString := LSiglaTipOpe;
          LQryRemessa.FieldByName('RMV_AUTFDE').AsString := LQryMovDet.FieldByName('AUTINCFATDOR').AsString;
          LQryRemessa.FieldByName('RMV_LOTFDE').AsString := LQryMovDet.FieldByName('FDO_NUMLOT').AsString;
          LQryRemessa.FieldByName('RMV_LIBCOL').AsString := IIF(ATipoOperacao = toColetor, 'S', 'N');;
          LQryRemessa.Post;

          ReprocessarItem(LQryMovDet.FieldByName('DET_CODITE').AsString, LQryMovDet.FieldByName('DET_CODEMP').AsString);

          If (ATipoOperacao = toRemessa) Then
          Begin
            If (LQryMovDet.FieldByName('FDO_NUMLOT').AsString = 'A DEFINIR') Then
            Begin
              strChvBus := LQryMovDet.FieldByName('DET_CODITE').AsString+'|'+LQryMovDet.FieldByName('DET_CODEMP').AsString+'|'+LQryMovDet.FieldByName('FDO_NUMLOT').AsString;
              fltTotAux := 0;
              If dicQtdLot.TryGetValue(strChvBus, fltTotAux) Then
              Begin
                fltTotAux := fltTotAux + LQryMovDet.FieldByName('DET_QTDITE').AsFloat;
                dicQtdLot.AddOrSetValue(strChvBus, fltTotAux);
              End
              Else
              Begin
                dicQtdLot.AddOrSetValue(strChvBus, LQryMovDet.FieldByName('DET_QTDITE').AsFloat);
              End;
            End;
          End;

          LQryMovDet.Next;
        end;

        strMsgErr := '';
        For intIdx := 0 To dicQtdLot.Count-1 Do
        Begin
          strChvBus := dicQtdLot.ToArray[intIdx].Key;

          fltTotAux := 0;
          If dicQtdLot.TryGetValue(strChvBus, fltTotAux) Then
          Begin
            fltSalAut := fCampoTabela('IFNULL(LOT_SALDOS, 0)', 'CADLOT',
                                      ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
                                      [fGetValorPipeDisSis(strChvBus,'|',1), fGetValorPipeDisSis(strChvBus,'|',2), fGetValorPipeDisSis(strChvBus,'|',3)]);

            If ((fltSalAut-fltTotAux) < 0) Then
              strMsgErr := strMsgErr + IIF(strMsgErr.IsEmpty,'',', ') + fGetValorPipeDisSis(strChvBus,'|',1);
          End;
        End;

        Result := strMsgErr.IsEmpty;
        If (Not Result) Then
        Begin
          fRollBack;

          fMensagem('ATENÇÃO!', 'O lote "A DEFINIR" do produto a seguir não possui saldo suficiente para atender a essa remessa de devolução. '+
                                'Por favor, entre em contato com a citel para análise do caso.'+#10#13+strMsgErr, ['&Ok']);
        End;

        If Result And (Not fEmptyStr(LAutIncFatDor)) Then
          pAtualizaLotePedidoEnderecamento(LAutIncFatDor, LNumLot);

        Result := Result And fCriaTransferencia(ANumRemessa, LNumLot, LArrItemRemessa);

        If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
        Begin
          Result := False;
          fRollBack;
          pMostraErrosAuditoria(strCodErrosAuditoria);
        End;

        if Result then
          fCommit
        else
        begin
          fRollBack;
          fMensagem('ATENÇÃO!', 'Não foi possível gerar a remessa!', ['&Ok']);
        end;
      except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[TRemessaDevolucao.fGerarRemessa]');
        End;
      end;
    finally
      FreeAndNil(LQryRemessa);
      FreeAndNil(LObjCadLote);
    end
  finally
    FreeAndNil(LQryMovDet);
    FreeAndNil(dicQtdLot);
  end;
end;

function TRemessaDevolucao.fGravaMovDetTransf(
  AArrItemRemessa: TArrItemRemessa): Boolean;
var
  LQryCadIte: TUniQuery;
  LRecItemRemessa: TRecItemRemessa;
  LObjCadLote: TCadLot;
  LAutIncMovDet: String;
begin
  LQryCadIte := fCriaQuery;
  LObjCadLote := TCadLot.Create(Nil);

  try
    Result := False;
    LQryCadIte.Close;
    LQryCadIte.SQL.Clear;
    LQryCadIte.SQL.Add(fSQLItem);

    for LRecItemRemessa in AArrItemRemessa do
    begin
      LQryCadIte.Close;
      LQryCadIte.ParamByName('CODITE').AsString := LRecItemRemessa.CodIte;
      LQryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryCadIte.Open;

      LAutIncMovDet:= EmptyStr;

      Result := fGravaMovDet(LAutIncMovDet,
                             FAutIncMovGer,
                             FNumDoc,
                             FEspDoc,
                             VS_strCodEmp,
                             LRecItemRemessa.CodIte,
                             strLoginUsuarioLogado,
                             '',
                             LQryCadIte.FieldByName('ITE_CODMAR').AsString,
                             '',
                             FCodCli,
                             FDtaEnt,
                             FHorEnt,
                             FDtaEnt,
                             '01000',
                             'C',
                             '',
                             LQryCadIte.FieldByName('ITE_DESITE').AsString,
                             LQryCadIte.FieldByName('ITE_REFERE').AsString,
                             LQryCadIte.FieldByName('ITE_CODUNI').AsString,
                             LQryCadIte.FieldByName('ITE_CODFOR').AsString,
                             LRecItemRemessa.QtdIte,
                             LQryCadIte.FieldByName('ITE_PRECUS').AsFloat,
                             LQryCadIte.FieldByName('ITE_PRECUS').AsFloat,
                             LQryCadIte.FieldByName('ITE_PRECUS').AsFloat,
                             RoundTo(LRecItemRemessa.QtdIte * LQryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),
                             RoundTo(LRecItemRemessa.QtdIte * LQryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             FClaFis,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             True,
                             FEspFat,
                             FNumFat,
                             VS_strCodEmp,
                             FDtaEnt,
                             '',
                             '',
                             0.0,
                             'NOR',
                             LQryCadIte.FieldByName('ITE_INCPIS').AsString,
                             '',
                             0.0,
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             '',
                             strLoginUsuarioLogado,
                             '',
                             '',
                             '',
                             '',
                             0,
                             'N',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             FCodCli,
                             0,
                             0,
                             0.0,
                             '',
                             '',
                             False,
                             False,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             'N',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             IIF(FClaFis = STR_CLASAI, LOT_ADEFINIR, FNumLot),
                             'N',
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             0,
                             IIF(FClaFis = STR_CLASAI, FNumLot, LOT_ADEFINIR),
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             'P',
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             '',
                             'N',
                             'N',
                             0,
                             0,
                             0,
                             '',
                             'N',
                             0,
                             '',
                             0,
                             'N',
                             '',
                             'NOR',
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             LRecItemRemessa.AutInc);

      if not Result then
        Exit;

      Result := LObjCadLote.fAtualizaEstoqueLote(LRecItemRemessa.CodIte,
                                                 IIF(FClaFis = STR_CLASAI, 'S', 'E'),
                                                 IIF(FClaFis = STR_CLASAI, LOT_ADEFINIR, FNumLot),
                                                 LRecItemRemessa.QtdIte);

      if not Result then
        Exit;
    end;
  finally
    FreeAndNil(LQryCadIte);
    FreeAndNil(LObjCadLote);
  end;
end;

function TRemessaDevolucao.fGravaMovGerTransf: Boolean;
var
  recServicos: TDadosServicos;
  arrDuplic : TarrDuplicata;
begin
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  Result := fGravaMovGer(FAutIncMovGer,
                         FNumDoc,
                         FEspDoc,
                         VS_strCodEmp,
                         '',
                         strLoginUsuarioLogado,
                         '',
                         FCodCli,
                         'C',
                         FDtaEnt,
                         FHorEnt,
                         FDtaEnt,
                         '01000',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         True,
                         FEspFat,
                         FNumFat,
                         VS_strCodEmp,
                         FDtaEnt,
                         '',
                         '',
                         False,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         arrDuplic,
                         '',
                         'N',
                         '99999',
                         '',
                         '',
                         '',
                         0.0,
                         strLoginUsuarioLogado,
                         '',
                         '',
                         0.0,
                         recServicos,
                         0.0,
                         '',
                         'N',
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         '',
                         'N',
                         FCodCli,
                         '',
                         '',
                         '',
                         '',
                         'N',
                         False,
                         0,
                         0.0,
                         0.0,
                         'N',
                         '',
                         FDtaEnt,
                         '',
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         False);

  If Result Then
    objAuditoriaSaldo.Adicionar(FAutIncMovGer, 'MOVGER');
end;

function TRemessaDevolucao.fLocalizaDocumento(AChaveAcesso: String; Var AAutIncDoc: String): Boolean;
var
  LQryAcesso: TUniQuery;
begin
  LQryAcesso := fCriaQuery;

  try
    Result := False;

    LQryAcesso.Close;
    LQryAcesso.SQL.Clear;
    LQryAcesso.SQL.Add('SELECT G.AUTOINCREM, F.FIS_CLFSC1');
    LQryAcesso.SQL.Add('FROM MOVGER G');
    LQryAcesso.SQL.Add('INNER JOIN CADFIS F');
    LQryAcesso.SQL.Add('ON(G.GER_NUMDOC = F.FIS_NUMDOC AND G.GER_ESPDOC = F.FIS_ESPDOC AND G.GER_CODEMP = F.FIS_CODEMP AND');
    LQryAcesso.SQL.Add('   G.GER_CODCLI = F.FIS_FORCLI AND G.GER_TIP_FC = F.FIS_TIP_FC)');
    LQryAcesso.SQL.Add('WHERE F.FIS_ACESSO = :ACESSO');
    LQryAcesso.ParamByName('ACESSO').AsString := AChaveAcesso;
    LQryAcesso.Open;

    if (LQryAcesso.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'O documento não foi localizado!', ['&Ok']);
      Exit;
    end;

    LQryAcesso.Close;
    LQryAcesso.SQL.Add('AND F.FIS_CODEMP = :CODEMP');
    LQryAcesso.ParamByName('ACESSO').AsString := AChaveAcesso;
    LQryAcesso.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryAcesso.Open;

    if (LQryAcesso.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'O documento bipado não pertence à empresa '+VS_strCodEmp+'!', ['&Ok']);
      Exit;
    end;

    If Not fClassificacaoEhPermitida(LQryAcesso.FieldByName('FIS_CLFSC1').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Só é permitido informar devoluções ou outras entradas!', ['&Ok']);
      Exit;
    End;

    AAutIncDoc := LQryAcesso.FieldByName('AUTOINCREM').AsString;
    Result := True;
  finally
    FreeAndNil(LQryAcesso);
  end;
end;

function TRemessaDevolucao.fRemessaJaFezEnderecamento(
  ANumRemessa: String): Boolean;
var
  LQryEnderecamento: TUniQuery;
begin
  LQryEnderecamento := fCriaQuery;

  try
    LQryEnderecamento.Close;
    LQryEnderecamento.SQL.Clear;
    LQryEnderecamento.SQL.Add('SELECT RMV_NUMREM');
    LQryEnderecamento.SQL.Add('FROM REMDEV');
    LQryEnderecamento.SQL.Add('WHERE RMV_INIEND IS NOT NULL');
    LQryEnderecamento.SQL.Add('AND RMV_NUMREM = :NUMREM');
    LQryEnderecamento.SQL.Add('AND RMV_EMPREM = :EMPREM');

    LQryEnderecamento.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryEnderecamento.ParamByName('EMPREM').AsString := VS_strCodEmp;

    LQryEnderecamento.Open;

    Result := Not LQryEnderecamento.IsEmpty;
  finally
    FreeAndNil(LQryEnderecamento);
  end;
end;

function TRemessaDevolucao.fSQLItem: String;
var
  LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT                   ';
  LSQL := LSQL + '   ITE_DESITE,            ';
  LSQL := LSQL + '   ITE_CODMAR,            ';
  LSQL := LSQL + '   ITE_CODUNI,            ';
  LSQL := LSQL + '   ITE_CODFOR,            ';
  LSQL := LSQL + '   ITE_REFERE,            ';
  LSQL := LSQL + '   ITE_INCPIS,            ';
  LSQL := LSQL + '   ITE_PRECUS             ';
  LSQL := LSQL + ' FROM                     ';
  LSQL := LSQL + '   CADITE C               ';
  LSQL := LSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND ';
  LSQL := LSQL + '                        G.ITE_CODEMP = :CODEMP          ';
  LSQL := LSQL + ' WHERE                    ';
  LSQL := LSQL + '   C.ITE_CODITE = :CODITE ';

  Result := LSQL;
end;

function TRemessaDevolucao.fTemPedidoDeEnderecamentoVinculado(
  const AChaveAcesso: String; AJaEnderecado: Boolean = False): Boolean;
var
  qryPedido: TUniQuery;
begin
  Result := False;

  if fEmptyStr(AChaveAcesso) then
    Exit;

  qryPedido := fCriaQuery;

  try
    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add('SELECT F.FIS_ACESSO');
    qryPedido.SQL.Add('FROM CADFIS F');
    qryPedido.SQL.Add('INNER JOIN MOVGER G');
    qryPedido.SQL.Add('ON(F.FIS_NUMDOC = G.GER_NUMDOC AND');
    qryPedido.SQL.Add('   F.FIS_ESPDOC = G.GER_ESPDOC AND');
    qryPedido.SQL.Add('   F.FIS_CODEMP = G.GER_CODEMP AND');
    qryPedido.SQL.Add('   F.FIS_FORCLI = G.GER_CODCLI)');
    qryPedido.SQL.Add('INNER JOIN ' + IIF(AJaEnderecado, 'DEL_', '') + 'EXTGOR E');
    qryPedido.SQL.Add('ON(G.GER_NUMDOC = SUBSTRING(E.FGO_DOCEND, 1, 12) AND');
    qryPedido.SQL.Add('   G.GER_ESPDOC = SUBSTRING(E.FGO_DOCEND, 13, 2) AND');
    qryPedido.SQL.Add('   G.GER_SERIE_ = SUBSTRING(E.FGO_DOCEND, 15, 3) AND');
    qryPedido.SQL.Add('   G.GER_CODEMP = SUBSTRING(E.FGO_DOCEND, 18, 3))');
    qryPedido.SQL.Add('WHERE F.FIS_ACESSO = :ACESSO');

    qryPedido.ParamByName('ACESSO').AsString := AChaveAcesso;

    qryPedido.Open;

    Result := Not qryPedido.IsEmpty;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function TRemessaDevolucao.fVerificaNotaFulfillment(const AChaveAcesso: String;
  out AImport: String): Boolean;
var
  qryNfeImp: TUniQuery;
begin
  Result := False;

  AImport := EmptyStr;

  if fEmptyStr(AChaveAcesso) then
    Exit;

  qryNfeImp := fCriaQuery;

  try
    qryNfeImp.SQL.Add('SELECT NFE_IMPORT');
    qryNfeImp.SQL.Add('FROM NFEIMP');
    qryNfeImp.SQL.Add('WHERE NFE_HUBMKP <> "MLB"');
    qryNfeImp.SQL.Add('  AND NFE_STATUS = "AT"');
    qryNfeImp.SQL.Add('  AND NFE_CODEMP = :CODEMP');
    qryNfeImp.SQL.Add('  AND NFE_ACESSO = :ACESSO');

    qryNfeImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNfeImp.ParamByName('ACESSO').AsString := AChaveAcesso;

    qryNfeImp.Open;

    Result := Not qryNfeImp.IsEmpty;

    if Result then
      AImport := qryNfeImp.FieldByName('NFE_IMPORT').AsString;
  finally
    FreeAndNil(qryNfeImp);
  end;
end;

function TRemessaDevolucao.fValidaChaveAcesso(AChaveAcesso: String; Var AAutIncDoc: String): Boolean;
begin
  Result := False;
  AAutIncDoc := EmptyStr;

  if fLocalizaDocumento(AChaveAcesso, AAutIncDoc) then
  begin
    if not fExisteRemessa(AAutIncDoc) then
      Result := True;
  end;
end;

class function TRemessaDevolucao.fValidaRemessa(ANumRemessa,
  AOpcDoc: String): Boolean;
var
  LQryRemessa: TUniQuery;
begin
  LQryRemessa := fCriaQuery;

  try
    LQryRemessa.Close;
    LQryRemessa.SQL.Clear;
    LQryRemessa.SQL.Add('SELECT AUTOINCREM');
    LQryRemessa.SQL.Add('FROM REMDEV');
    LQryRemessa.SQL.Add('WHERE RMV_NUMREM = :NUMREM');
    LQryRemessa.SQL.Add('AND RMV_EMPREM = :EMPREM');

    if AOpcDoc = 'TE' then
    begin
      LQryRemessa.SQL.Add('AND RMV_TIPOPE = "REM_TRA" ');
      LQryRemessa.SQL.Add('AND RMV_AUTTRA IS NULL');
    end
    else if AOpcDoc = 'OF' then
    begin
      LQryRemessa.SQL.Add('AND RMV_TIPOPE = "REM_OUF" ');
      LQryRemessa.SQL.Add('AND RMV_AUTOUF IS NULL');
    end;

    LQryRemessa.ParamByName('NUMREM').AsString := ANumRemessa;
    LQryRemessa.ParamByName('EMPREM').AsString := VS_strCodEmp;
    LQryRemessa.Open;

    Result := not LQryRemessa.IsEmpty;
  finally
    FreeAndNil(LQryRemessa);
  end;
end;

function TRemessaDevolucao.fContemRemessaVinculadaPeloCancelamento(
  ANumDoc, AEspDoc: String): Boolean;
var
  LAutInc: String;
begin
  Result := False;

  LAutInc := fCampoTabela('AUTOINCREM','MOVGER', ['GER_NUMDOC','GER_ESPDOC','GER_CODEMP'], [ANumDoc, AEspDoc, VS_strCodEmp]);

  if fEmptyStr(LAutInc) then
    Exit;

  Result := fExisteRemessa(LAutInc, True);
end;

procedure TRemessaDevolucao.pAbreTransferenciaEstoque(ANumRemessa: String);
var
  frmFatVendas: TfrmFatVendas;
begin
  pCriarFormularios(TfrmFatVendas, frmFatVendas);

  try
    frmFatVendas.strOpcDoc          := 'TE';
    frmFatVendas.strTitulo          := ' > Principal > Faturamento > Emissão de Faturamento > Transferência de Estoque';
    frmFatVendas.blnApenasPrazo     := False;
    frmFatVendas.blnApenasVista     := False;
    frmFatVendas.blnGravarComo      := True;
    frmFatVendas.strNumRemessa      := ANumRemessa;

    frmFatVendas.ShowModal;
  finally
    pFreeAndNil(frmFatVendas);
  end;
end;

procedure TRemessaDevolucao.pAtualizaLotePedidoEnderecamento(AAutInc,
  ANumLot: String);
var
  LQryPedidoEnderecamento: TUniQuery;
begin
  LQryPedidoEnderecamento := fCriaQuery;

  try
    LQryPedidoEnderecamento.Close;
    LQryPedidoEnderecamento.SQL.Clear;
    LQryPedidoEnderecamento.SQL.Add('UPDATE FATDOR');
    LQryPedidoEnderecamento.SQL.Add('SET FDO_NUMLOT = :NUMLOT');
    LQryPedidoEnderecamento.SQL.Add('WHERE AUTOINCREM IN('+AAutInc+')');
    LQryPedidoEnderecamento.ParamByName('NUMLOT').AsString := ANumLot;
    LQryPedidoEnderecamento.ExecSQL;
  finally
    FreeAndNil(LQryPedidoEnderecamento);
  end;
end;

function TRemessaDevolucao.fCancelaTL(AIncDev: String): Boolean;
var
  LQryCancela: TUniQuery;
  LAutIncDet: String;
  LAutIncGer: String;
begin
  Result := False;

  if fEmptyStr(AIncDev) then
    Exit;

  LAutIncDet := fCampoTabela('DET_SEQGER', 'MOVTRI', ['DET_INCDEV'], [AIncDev], False);

  if fEmptyStr(LAutIncDet) then
    Exit;

  LAutIncGer := fCampoTabela('DET_SEQGER', 'MOVDET', ['AUTOINCREM'], [LAutIncDet], False);

  if fEmptyStr(LAutIncGer) then
    Exit;

  LQryCancela := fCriaQuery;

  try
    LQryCancela.Close;
    LQryCancela.SQL.Clear;
    LQryCancela.SQL.Add('DELETE FROM MOVGER WHERE AUTOINCREM = :AUTINC');
    LQryCancela.ParamByName('AUTINC').AsString := LAutIncGer;
    LQryCancela.ExecSQL;

    Result := True;
  finally
    FreeAndNil(LQryCancela);
  end;
end;

procedure TRemessaDevolucao.pRetornaLotePedidoEnderecamento(AAutInc,
  ANumLot: String);
var
  LQryPedido: TUniQuery;
begin
  LQryPedido := fCriaQuery;

  try
    LQryPedido.Close;
    LQryPedido.SQL.Clear;
    LQryPedido.SQL.Add('UPDATE FATDOR');
    LQryPedido.SQL.Add('SET FDO_NUMLOT = :NUMLOT');
    LQryPedido.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    LQryPedido.ParamByName('NUMLOT').AsString := ANumLot;
    LQryPedido.ParamByName('AUTINC').AsString := AAutInc;
    LQryPedido.ExecSQL;
  finally
    FreeAndNil(LQryPedido);
  end;
end;


function TRemessaDevolucao.fCriaTransferencia(ANumRemessa, ANumLot: String; AArrItemRemessa: TArrItemRemessa): Boolean;
begin
  FNumDoc := fRetSequencial_TL;
  FEspDoc := 'TL';
  FNumFat := ANumRemessa;
  FEspFat := 'RD';
  FCodCli := fCfgSis('RDCGTL', varString);
  FNumLot := ANumLot;
  FDtaEnt := fRetDataServidor;
  FHorEnt := fRetHoraServidor;

  Result := fGravaMovGerTransf;

  if not Result then
    Exit;

  FClaFis := STR_CLASAI;
  Result := fGravaMovDetTransf(AArrItemRemessa);

  if not Result then
    Exit;

  FClaFis := STR_CLAENT;
  Result := fGravaMovDetTransf(AArrItemRemessa);
end;

procedure TRemessaDevolucao.pImprimeRemessaDevolucao(ANumRemessa: String);
var
  strLayPadrao: string;
  objImpressao: TEditorFastImpressao;
  strNomImp: string;
begin

  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeRemessaDevolucao], VS_strCodEmp, 'S']);

  if (not fEmptyStr(strLayPadrao)) then
  begin

    if fEmptyStr(strNomImp) then
    begin
      TCfgRel.fExecutePrintDialog(strNomImp);
      if fEmptyStr(strNomImp) then
        strNomImp := TCfgRel.fGetImpressoraSelecionada;
    end;

    objImpressao := TEditorFastImpressao.Create(Nil);

    try

      objImpressao.recDocume.strNomImp := strNomImp;
      objImpressao.recDocume.strCodLay := strLayPadrao;
      objImpressao.recDocume.strNumRem := ANumRemessa;
      objImpressao.recDocume.strNumDoc := ANumRemessa;
      objImpressao.recDocume.strEspDoc := 'RD';
      objImpressao.recDocume.strCodEmp := VS_strCodEmp;
      objImpressao.fImprimeDocumento(tpaNormal);

    finally
      FreeAndNil(objImpressao);
    end;

  end
  else
  begin

    fMensagem('ATENÇÃO!', 'Não foi encontrato layout definido para esse tipo de impressão!', ['&Ok']);

  end;

end;

procedure pVinculaRemessaDevolucao(strOpcDoc, strNumRemessa, strAutInc, strItens: String);
var
  qryRemessa: TUniQuery;
  qryDocumento: TUniQuery;
  qryItemRemessa: TUniQuery;
  strCampo: String;
begin
  qryRemessa := fCriaQuery;
  qryDocumento := fCriaQuery;
  qryItemRemessa := fCriaQuery;

  try
    case AnsiIndexStr(UpperCase(strOpcDoc), ['TE','OF']) of
      0: strCampo := 'RMV_AUTTRA';
      1: strCampo := 'RMV_AUTOUF';
    end;

    qryDocumento.Close;
    qryDocumento.SQL.Clear;
    qryDocumento.SQL.Add('SELECT AUTOINCREM, DET_CODITE FROM MOVDET WHERE DET_SEQGER = :AUTINC');
    qryDocumento.ParamByName('AUTINC').AsString := strAutInc;
    qryDocumento.Open;

    if qryDocumento.IsEmpty then
      Exit;

    qryItemRemessa.Close;
    qryItemRemessa.SQL.Clear;
    qryItemRemessa.SQL.Add('SELECT AUTOINCREM');
    qryItemRemessa.SQL.Add('FROM REMDEV');
    qryItemRemessa.SQL.Add('WHERE RMV_NUMREM = :NUMREM');
    qryItemRemessa.SQL.Add('AND RMV_CODITE = :CODITE');
    qryItemRemessa.SQL.Add('AND '+strCampo+' IS NULL');

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add('UPDATE REMDEV');
    qryRemessa.SQL.Add('SET '+strCampo+' = :AUTINC');
    qryRemessa.SQL.Add('WHERE AUTOINCREM = :CHAVE_');

    while not qryDocumento.Eof do
    begin
      qryItemRemessa.Close;
      qryItemRemessa.ParamByName('NUMREM').AsString := strNumRemessa;
      qryItemRemessa.ParamByName('CODITE').AsString := qryDocumento.FieldByName('DET_CODITE').AsString;
      qryItemRemessa.Open;

      qryRemessa.Close;
      qryRemessa.ParamByName('AUTINC').AsString := qryDocumento.FieldByName('AUTOINCREM').AsString;
      qryRemessa.ParamByName('CHAVE_').AsString := qryItemRemessa.FieldByName('AUTOINCREM').AsString;
      qryRemessa.ExecSQL;

      qryDocumento.Next;
    end;

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add('UPDATE CADLOT');
    qryRemessa.SQL.Add('SET LOT_STATUS = "N" ');
    qryRemessa.SQL.Add('WHERE LOT_AUTREM = :REMESSA');
    qryRemessa.SQL.Add('AND LOT_CODEMP = :CODEMP');
    qryRemessa.SQL.Add('AND LOT_CODITE IN('+strItens+')');
    qryRemessa.ParamByName('REMESSA').AsString := strNumRemessa;
    qryRemessa.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryRemessa.ExecSQL;
  finally
    FreeAndNil(qryRemessa);
    FreeAndNil(qryDocumento);
    FreeAndNil(qryItemRemessa);
  end;
end;

end.
