unit AgrupamentoDeOndaDeSeparacao.Classes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB,
  MemDS, DBAccess, Uni, Datasnap.Provider, UniDataSetProvider, cxProgressBar,
  Datasnap.DBClient, UniClientDataSet, System.UITypes, untTLock,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxClasses, Expedicao.TemporariaPedidosExpedicao, untTypesSistema, System.StrUtils,
  AgrupamentoDeOndaDeSeparacao.Types,
  AgrupamentoDeOndaDeSeparacao.Funcoes,
  AgrupamentoDeOndaDeSeparacao.Impressao,
  AgrupamentoDeOndaDeSeparacao.Classes.DefinicaoDeLotes;

type

  TLog = class
  private
    FLog : TStringList;
    FIni,
    FFin : TTime;
    procedure Add(AInfo : String);
  public
    constructor New; Reintroduce;
    destructor  Destroy; Override;
    procedure IniciouProcesso(AProcesso : String);
    procedure Finalizou(AProcesso : String);
    procedure Salvar(ANomeArquivo : String);
  End;

  TRemessaDeSeparacao = Class(TComponent)
  private

    FRemessasDePedidoSelecionadas,
    FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto,
    FPedidosCortados,
    FMensagensDeErro : TStringList;

    FQryPDs,
    FQryIte : TUniQuery;

    FRemessas : TUniClientDataSet;

    FName,
    FRemessaDeSeparacaoGerada : String;

    FTemPedidoCortado,
    FCortouTodosOsPedidos : Boolean;

    FDecQtd : Integer;

    FItensAgrupadosRemessa : TItensAgrupadosRemessaSeparacao;
    FItensRemessa : TItensRemessa;

    FLock : TLock;

    procedure MovimentacaoProgramada(Const AConfirmou: Boolean);
    procedure MostrarMensagensProcessoDefinicaoDeLotes(out AGerarNovamente : Boolean);
    procedure MensagemItensEPedidosRemovidos;
    procedure UpdateAgrupar(ARemessaDePedido, ARemessaDeSeparacao : String; ADataDeGeracao : TDate);
    procedure TratamentoExcecoes(AExcecao : Exception);
    procedure BuscaRemessasSelecionadas;

    function GetItensOnda(const ASeqSep: String): TItensAgrupadosRemessaSeparacao;
    function CortouTodosOsPedidos : Boolean;
    function GerarSeqOnd : String;
    function Validacoes(pgbStatus: TcxProgressBar) : Boolean;
    function LiberarDocumentos(pgbStatus: TcxProgressBar) : Boolean;
    function CorteDosPedidosSemSaldo(pgbStatus: TcxProgressBar): Boolean;
    function RealizarAgrupamentoDeRemessasDePedidos(pgbStatus: TcxProgressBar): Boolean;
    function DefineLotesPedidoWMSRemessaDeSeparacao: Boolean;
    function ValidaLotesRemessasSelecionadas: Boolean;
    function DefinicaoDeLotesOtimizada(AOwner: TComponent; var AItensRemessa: TItensRemessa; AMenErr: TStringList = Nil): Boolean;

  public
    constructor New(AName : String); Reintroduce;
    destructor  Destroy; Override;

    procedure RealizarImpressao;
    procedure setOndas(AOndas : TUniClientDataSet);

    function Gerar : TGeracao;
    class function DefinicaoDeLotes(const ARemessaDeSeparacao: String; AApresentarTela: Boolean; var AItensRemessa : TItensRemessa; AMenErr : TStringList = Nil) : Boolean;

    property RemessaDeSeparacaoGerada : String Read FRemessaDeSeparacaoGerada;

  end;

implementation

uses
  untGravando, untFuncoesSimples, untQckSintetizaItensSep,
  untMovimentacaoProgramada, untFatDefineLotesPedidoWMS, untFatExpedicao,
  untMensagemExplicativa_ComConsultaProdutos,
  untLibExt, untFatGor, untConstantes;

{ TRemessaDeSeparacao }

procedure TRemessaDeSeparacao.BuscaRemessasSelecionadas;
begin
  Try

    FRemessasDePedidoSelecionadas.Clear;

    FRemessas.Filtered := False;
    FRemessas.Filter   := 'MARDES=' + QuotedStr(SELECIONADO);
    FRemessas.Filtered := True;

    FRemessas.First;
    while not FRemessas.Eof do
    begin
      FRemessasDePedidoSelecionadas.Add(QuotedStr(FRemessas.FieldByName('ONDFIN').AsString));
      FRemessas.Next;
    end;

    FItensAgrupadosRemessa := GetItensOnda(FRemessasDePedidoSelecionadas.CommaText);

  Finally
    FRemessas.Filtered := False;
    FRemessas.Filter   := '';
  End;
end;

function TRemessaDeSeparacao.CorteDosPedidosSemSaldo(pgbStatus: TcxProgressBar): Boolean;
  var
    objLibExt  : TLibExt;
    LItem      : String;
    LMotCorte  : String;
    LItemOnda  : TItemRemessaSeparacao;
    LSalDis    : TRecSalDis;
    LVlrSalDis : Double;
    LExcluirExtLar: Boolean;
begin

  Result := False;

  if (not fTravaSaldoDisponivelGeracaoRemessaPedido) then
    Exit;

  if (not FRemessas.Active) then
    Exit;

  if FRemessas.IsEmpty then
    Exit;

  if Length(FItensAgrupadosRemessa) = 0 then
    Exit;

  Try

    FQryIte.SQL.Add('SELECT SUM(FDO_QTDITE - FDO_QTDBAI) AS QTDITE ');
    FQryIte.SQL.Add('FROM EXTGOR ');
    FQryIte.SQL.Add('INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO ');
    FQryIte.SQL.Add('WHERE FGO_SEQSEP IN (' + FRemessasDePedidoSelecionadas.CommaText + ') ');
    FQryIte.SQL.Add('  AND FDO_CODITE = :CODITE ');
    FQryIte.SQL.Add('GROUP BY FDO_CODITE ');

    for LItemOnda in FItensAgrupadosRemessa do
    begin

      pProgresso(Trunc(pgbStatus.Position) +1, Length(FItensAgrupadosRemessa), pgbStatus);

      FQryIte.Close;
      FQryIte.ParamByName('CODITE').AsString := LItemOnda.strCodIte;
      FQryIte.Open;

      if FQryIte.IsEmpty then
        Continue;

      while not TemSaldoDisponivel(LItemOnda.strCodIte, FQryIte.FieldByName('QTDITE').AsFloat, LSalDis) do
      begin

        LVlrSalDis := (LSalDis.fltSalDis - LSalDis.fltQtdOnd);

        LItem := LItemOnda.strCodIte + ' - ' + fRetNomProduto(LItemOnda.strCodIte);

        If Not FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto.Text.Contains(LItem) Then
          FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto.Add(LItem +
            ' - Qtd. Necessária: '+ FormatFloat(fMskDigitos(FDecQtd), FQryIte.FieldByName('QTDITE').AsFloat) +
            ' - Qtd. Disponível: '+ FormatFloat(fMskDigitos(FDecQtd), LVlrSalDis));

        FQryPDs.Close;
        FQryPDs.SQL.Clear;
        FQryPDs.SQL.Add('SELECT FATGOR.AUTOINCREM, FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ');
        FQryPDs.SQL.Add('FROM FATGOR ');
        FQryPDs.SQL.Add('INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ');
        FQryPDs.SQL.Add('INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ');
        FQryPDs.SQL.Add('WHERE FGO_SEQSEP IN (' + FRemessasDePedidoSelecionadas.CommaText + ') ');
        FQryPDs.SQL.Add('  AND FDO_CODITE = :CODITE ');
        FQryPDs.SQL.Add('ORDER BY FGO_DTAENT, FGO_HORENT ');
        FQryPDs.ParamByName('CODITE').AsString := LItemOnda.strCodIte;
        FQryPDs.Open;

        //vai para o pedido mais recente
        FQryPDs.Last;

        try

          LMotCorte := 'Qtde necessária PD...: '+ FormatFloat(fMskDigitos(FDecQtd), FQryIte.FieldByName('QTDITE').AsFloat) + sLineBreak +
                       'Saldo disponível item: '+ FormatFloat(fMskDigitos(FDecQtd), LSalDis.fltSalDis) + sLineBreak +
                       'Remessas em aberto...: '+ FormatFloat(fMskDigitos(FDecQtd), LSalDis.fltQtdOnd) +
                                                  IIF(Not LSalDis.strSeqOnd.IsEmpty, ' (' + LSalDis.strSeqOnd + ')', '') + sLineBreak +
                       '---------------------- '+ sLineBreak +
                       'Total disponível.....: '+ FormatFloat(fMskDigitos(FDecQtd), LVlrSalDis) +
                                                  ' (Saldo disponível item - Remessas em aberto)';

          LExcluirExtLar := fValidaExcluiEXTLAR(FQryPDs.FieldByName('AUTOINCREM').AsString);

          fStartTransaction;

          //remove o pedido mais recente da onda
          fLimpaExpedicaoPedido(FQryPDs.FieldByName('AUTOINCREM').AsString, True, IIF(LExcluirExtLar, eeloExcluir, eeloNaoExcluir), False);

          FPedidosCortados.Add(FQryPDs.FieldByName('FGO_NUMDOC').AsString +'-'+
                               FQryPDs.FieldByName('FGO_ESPDOC').AsString +'-'+
                               FQryPDs.FieldByName('FGO_CODEMP').AsString);

          if fCfgSis('LIBEXT', varBoolean) then
          begin
            //volta para a liberação de pedidos externos, com motivo de bloqueio
            objLibExt := TLibExt.Create(Nil,
                                        FQryPDs.FieldByName('FGO_NUMDOC').AsString,
                                        FQryPDs.FieldByName('FGO_ESPDOC').AsString,
                                        FQryPDs.FieldByName('FGO_CODEMP').AsString);
            try
              if not fEmptyStr(objLibExt.strOpeLib) Then
                objLibExt.pLimparLiberacao;

              objLibExt.blnOndBlo := True;
              objLibExt.strOpeBlo := strLoginUsuarioLogado;
              objLibExt.strMotBlo := RetMotivoBloqueio(LItemOnda.strCodIte, FQryPDs.FieldByName('FGO_CODEMP').AsString) + sLineBreak + LMotCorte;
              objLibExt.pBloquear;
            finally
              FreeAndNil(objLibExt);
            end;
          end;

          fCommit;

        except
          on E: Exception do
          begin
            fRollback;
            Raise Exception.Create('Não foi possível remover o pedido ' + FQryPDs.FieldByName('FGO_NUMDOC').AsString + ' da remessa. ' + E.Message);
          end;
        end;

        FQryIte.Close;
        FQryIte.Open;

        if FQryIte.IsEmpty then
          Break;

      end;

    end;

    FRemessas.First;
    while not FRemessas.Eof do
    begin

      if FRemessasDePedidoSelecionadas.Text.Contains(FRemessas.FieldByName('ONDFIN').AsString) then
      begin
        FRemessas.Edit;
        FRemessas.FieldByName('MARDES').AsString := SELECIONADO;
        FRemessas.Post;
      end;

      FRemessas.Next;
    end;

    FTemPedidoCortado     := (FPedidosCortados.Count > 0);
    FCortouTodosOsPedidos := CortouTodosOsPedidos;

    Result := True;

  Except
    On E: Exception Do
      Raise ExceptionAutComGeracaoRemessaDeSeparacao_Cortes.Create(E.Message);
  End;

end;

function TRemessaDeSeparacao.CortouTodosOsPedidos: Boolean;
begin
  FQryIte.Close;
  FQryIte.SQL.Clear;
  FQryIte.SQL.Add('SELECT COUNT(*) AS TOT ');
  FQryIte.SQL.Add('FROM EXTGOR ');
  FQryIte.SQL.Add('WHERE FGO_SEQSEP IN (' + FRemessasDePedidoSelecionadas.CommaText + ') ');
  FQryIte.Open;

  Result := FQryIte.FieldByName('TOT').AsInteger <= 0;
end;

function TRemessaDeSeparacao.DefineLotesPedidoWMSRemessaDeSeparacao: Boolean;
  Const
    SQL = 'SELECT                    ' +
          '  G.AUTOINCREM AS AUTINC, ' +
          '  G.FGO_NUMDOC AS NUMDOC, ' +
          '  G.FGO_ESPDOC AS ESPDOC, ' +
          '  G.FGO_CODEMP AS CODEMP, ' +
          '  G.FGO_CODCLI AS CODCLI  ' +
          'FROM            ' +
          '  FATGOR G      ' +
          '  INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = G.AUTOINCREM) ' +
          'WHERE                                                  ' +
          '  E.FGO_SEQOND = :SEQOND ';

  Var
    LConfirmou : Boolean;
begin

  Result := False;

  If FRemessaDeSeparacaoGerada.IsEmpty Then
    Exit;

  Try

    Try

      FQryPDs.Close;
      FQryPDs.SQL.Clear;
      FQryPDs.SQL.Add(SQL);
      FQryPDs.ParamByName('SEQOND').AsString := FRemessaDeSeparacaoGerada;
      FQryPDs.Open;

      If FQryPDs.IsEmpty Then
        Exit;

      If Not fExecutarModal(Validacoes, 'Aguarde, validando travas...', '') Then
        Exit;

      If fCfgSis('ONDOTI', varBoolean) Then
        LConfirmou := DefinicaoDeLotesOtimizada(Self, FItensRemessa, FMensagensDeErro)
      Else
        LConfirmou := DefinicaoDeLotes(FRemessaDeSeparacaoGerada, False, FItensRemessa, FMensagensDeErro);

      MovimentacaoProgramada(LConfirmou);

      Result := LConfirmou;

    Finally
      fExecutarModal(LiberarDocumentos, 'Aguarde, liberando documentos...', '');
      FLock.pDestravarTodos;
    End;

  Except
    On E: Exception Do
      Raise ExceptionAutComGeracaoRemessaDeSeparacao_DefLot.Create(E.Message);
  End;

end;

class function TRemessaDeSeparacao.DefinicaoDeLotes(const ARemessaDeSeparacao: String; AApresentarTela: Boolean; var AItensRemessa: TItensRemessa; AMenErr: TStringList): Boolean;
  var
    LFatDefineLotesPedidoWMS : TfrmFatDefineLotesPedidoWMS;
begin

  Try

    pCriarFormularios(TfrmFatDefineLotesPedidoWMS, LFatDefineLotesPedidoWMS);

    Try

      LFatDefineLotesPedidoWMS.TipoDefinicoesLotes := tdlOndaDeSeparacao;
      LFatDefineLotesPedidoWMS.strOndaDeSeparacao  := ARemessaDeSeparacao;

      LFatDefineLotesPedidoWMS.strCodSep          := strLoginUsuarioLogado;
      LFatDefineLotesPedidoWMS.blnApenasImpressao := True;
      LFatDefineLotesPedidoWMS.btnRecalcularLocalizacoes.Visible := True;

      LFatDefineLotesPedidoWMS.stlMensagens := AMenErr;

      If Not AApresentarTela Then
      Begin
        LFatDefineLotesPedidoWMS.ComTransacao := False;
        LFatDefineLotesPedidoWMS.fCriarObjetos;
        LFatDefineLotesPedidoWMS.btnConfirma.Click;
      End Else
        LFatDefineLotesPedidoWMS.ShowModal;

      If Assigned(LFatDefineLotesPedidoWMS.ItensRemessa) Then
        AItensRemessa := LFatDefineLotesPedidoWMS.ItensRemessa;

      Result := LFatDefineLotesPedidoWMS.blnConfirma;

    Finally
      pFreeAndNil(LFatDefineLotesPedidoWMS);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TRemessaDeSeparacao.DefinicaoDeLotesOtimizada(AOwner: TComponent; var AItensRemessa: TItensRemessa; AMenErr: TStringList): Boolean;
  Var
    objDefineLotesRemessaDeSeparacao: TDefineLotesWMSRemessaDeSeparacao;
begin

  objDefineLotesRemessaDeSeparacao := TDefineLotesWMSRemessaDeSeparacao.CreateInstance(AOwner, FRemessaDeSeparacaoGerada, AMenErr);
  objDefineLotesRemessaDeSeparacao.setItensAgrupadosRemessa(FItensAgrupadosRemessa);

  Try
    Result := fExecutarModal(objDefineLotesRemessaDeSeparacao.DefineLotes, 'Aguarde, gerando definição de lotes...', '');
    AItensRemessa := objDefineLotesRemessaDeSeparacao.ItensRemessa;
  Finally
    FreeAndNil(objDefineLotesRemessaDeSeparacao);
  End;

end;

destructor TRemessaDeSeparacao.Destroy;
begin

  If Assigned(FRemessasDePedidoSelecionadas) Then
    FreeAndNil(FRemessasDePedidoSelecionadas);

  If Assigned(FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto) Then
    FreeAndNil(FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto);

  If Assigned(FPedidosCortados) Then
    FreeAndNil(FPedidosCortados);

  If Assigned(FQryPDs) Then
    FreeAndNil(FQryPDs);

  If Assigned(FQryIte) Then
    FreeAndNil(FQryIte);

  If Assigned(FRemessas) Then
    FreeAndNil(FRemessas);

  If Assigned(FMensagensDeErro) Then
    FreeAndNil(FMensagensDeErro);

  If Assigned(FLock) Then
    FreeAndNil(FLock);

end;

function TRemessaDeSeparacao.Gerar: TGeracao;
  var
    LGerarNovamente : Boolean;
begin

  Result := geGerouComSucesso;

  BuscaRemessasSelecionadas;

  If Not ValidaLotesRemessasSelecionadas Then
    Exit(geErro);

  fExecutarModal(CorteDosPedidosSemSaldo, 'Aguarde, cortando pedidos sem saldo disponível...', '');

  If (FTemPedidoCortado) And (FCortouTodosOsPedidos) Then
  Begin
    MensagemItensEPedidosRemovidos;
    Exit;
  End;

  fStartTransaction;

  Try

    fExecutarModal(RealizarAgrupamentoDeRemessasDePedidos, 'Aguarde, agrupando remessas...', '');

    Result := IIF(DefineLotesPedidoWMSRemessaDeSeparacao, geGerouComSucesso, geErro);

    If (Result = geGerouComSucesso) Then
    Begin
      fCommit;
      MensagemItensEPedidosRemovidos;
    End
    Else
    Begin
      fRollBack;
      MostrarMensagensProcessoDefinicaoDeLotes(LGerarNovamente);

      If LGerarNovamente Then
        Result := geTenteNovamente;
    End;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := geErro;
      TratamentoExcecoes(E);
    End;

  End;

end;

function TRemessaDeSeparacao.GerarSeqOnd: String;
begin
  Result := VS_strCodEmp + fRetSequencial('SEQOND', VS_strCodEmp, 9);
end;

function TRemessaDeSeparacao.GetItensOnda(const ASeqSep: String): TItensAgrupadosRemessaSeparacao;
  Var
    LQryIte: TUniQuery;
begin
  LQryIte := fCriaQuery;
  try
    LQryIte.SQL.Add('SELECT FDO_CODITE, FDO_IDEPRO, FDO_PROACA ');
    LQryIte.SQL.Add('FROM EXTGOR ');
    LQryIte.SQL.Add('INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO ');
    LQryIte.SQL.Add('WHERE FGO_SEQSEP IN (' + ASeqSep + ') ');
    LQryIte.SQL.Add('GROUP BY FDO_CODITE ');
    LQryIte.Open;

    SetLength(Result, LQryIte.RecordCount);

    LQryIte.First;
    while not LQryIte.Eof do
    begin
      Result[LQryIte.RecNo -1].strCodIte := LQryIte.FieldByName('FDO_CODITE').AsString;
      Result[LQryIte.RecNo -1].strIdePro := LQryIte.FieldByName('FDO_IDEPRO').AsString;
      Result[LQryIte.RecNo -1].strProAca := LQryIte.FieldByName('FDO_PROACA').AsString;

      LQryIte.Next;
    end;
  finally
    FreeAndNil(LQryIte);
  end;
end;

function TRemessaDeSeparacao.LiberarDocumentos(pgbStatus: TcxProgressBar): Boolean;
  var
    LDocTra : String;
    LEspTra : String;
    LEmpTra : String;
    LCliTra : String;
begin

  Result := True;

  FQryPDs.First;
  While Not FQryPDs.Eof Do
  Begin

    pProgresso(FQryPDs.RecNo, FQryPDs.RecordCount, pgbStatus);

    LDocTra := FQryPDs.FieldByName('NUMDOC').AsString;
    LEspTra := FQryPDs.FieldByName('ESPDOC').AsString;
    LEmpTra := FQryPDs.FieldByName('CODEMP').AsString;
    LCliTra := FQryPDs.FieldByName('CODCLI').AsString;

    FLock.fLock_Unlock('FATGOR' + LDocTra + LEspTra + LEmpTra, False, False,
                       False, '', True, '', True, True, False, False, False);
    FLock.fLock_Unlock('CADREC' + LDocTra + LEspTra + LEmpTra + LCliTra, False, False,
                       False, '', True, '', True, True, False, False, False);

    FQryPDs.Next;

  End;

  FRemessas.First;
  While Not FRemessas.Eof Do
  Begin

    If FRemessas.FieldByName('MARDES').AsString = SELECIONADO Then
      FLock.fLock_Unlock('SEQSEP' + FRemessas.FieldByName('ONDFIN').AsString, False, False,
                         False, '', True, '', True, True, False, False, False);

    FRemessas.Next;

  End;

end;

procedure TRemessaDeSeparacao.MensagemItensEPedidosRemovidos;
  var
    LMenExp : TfrmMensagemExplicativa_ComConsultaProdutos;
begin

  if (FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto.Count > 0) then
  begin

    pCriarFormularios(TfrmMensagemExplicativa_ComConsultaProdutos, LMenExp);

    try
      LMenExp.Caption := 'Itens SEM Saldo Disponível';
      LMenExp.btnConsultaProdutos.Visible := True;

      LMenExp.Width   := 700;
      LMenExp.Height  := 400;
      LMenExp.Font.Size := 9;
      LMenExp.mmoInstru.Lines.Add('Os pedidos que contém os itens sem saldo suficiente serão removidos da '+
                                  'remessa de pedido automaticamente, segue relação de item(ns) e pedido(s):');
      LMenExp.mmoInstru.Lines.Add('');
      LMenExp.mmoInstru.Lines.Add(FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto.Text.Trim);
      LMenExp.mmoInstru.Lines.Add('');
      LMenExp.mmoInstru.Lines.Add(FPedidosCortados.Text.Trim);
      LMenExp.btnSair.Caption := 'Prosseguir';
      LMenExp.ShowModal;
    finally
      pFreeAndNil(LMenExp);
    end;

  end;

end;

procedure TRemessaDeSeparacao.MostrarMensagensProcessoDefinicaoDeLotes(out AGerarNovamente: Boolean);
  var
    LMenExp: TfrmMensagemExplicativa_ComConsultaProdutos;
begin

  AGerarNovamente := False;

  if (not Assigned(FMensagensDeErro)) then
    Exit;

  if (fEmptyStr(FMensagensDeErro.Text)) then
    Exit;

  pCriarFormularios(TfrmMensagemExplicativa_ComConsultaProdutos, LMenExp);

  try
    LMenExp.Caption := 'Mensagens ocorridas no processo de definição dos lotes da Remessa de Separação:';
    LMenExp.btnConsultaProdutos.Visible := True;

    LMenExp.ItensRemessa := nil;

    If Assigned(FItensRemessa) Then
      LMenExp.ItensRemessa := FItensRemessa;

    LMenExp.Width   := 700;
    LMenExp.Height  := 400;
    LMenExp.Font.Size := 9;
    LMenExp.mmoInstru.Lines.Add(FMensagensDeErro.Text);

    AGerarNovamente := (LMenExp.ShowModal = mrRetry);

  finally
    pFreeAndNil(LMenExp);
  end;

end;

procedure TRemessaDeSeparacao.MovimentacaoProgramada(const AConfirmou: Boolean);
begin
  If Not fCfgSis('WMSMOV', varBoolean) Then
    Exit;

  FQryPDs.First;

  While Not FQryPDs.Eof Do
  Begin
    RealizarMovimentacaoProgramadaPedido(FQryPDs.FieldByName('AUTINC').AsString,
                                         AConfirmou);

    FQryPDs.Next;
  End;
end;

constructor TRemessaDeSeparacao.New(AName: String);
begin
  FName := AName;
  FRemessaDeSeparacaoGerada := '';

  FMensagensDeErro := TStringList.Create;
  FRemessasDePedidoSelecionadas := TStringList.Create;
  FItensSemSaldoDisponivelParaAtenderRemessaPorCompleto := TStringList.Create;
  FPedidosCortados := TStringList.Create;

  FQryPDs := fCriaQuery;
  FQryIte := fCriaQuery;

  FRemessas  := TUniClientDataSet.Create(Nil);

  FTemPedidoCortado     := False;
  FCortouTodosOsPedidos := False;

  FDecQtd := fCfgSis('DECQTD', varInteger);

  FLock := TLock.Create;

end;

function TRemessaDeSeparacao.RealizarAgrupamentoDeRemessasDePedidos(pgbStatus: TcxProgressBar): Boolean;
  var
    LClone         : TUniClientDataSet;
    LDataDeGeracao : TDate;
begin

  Result := False;

  If Not FRemessas.Active Then
    Exit;

  If FRemessas.IsEmpty Then
    Exit;

  Try

    FRemessaDeSeparacaoGerada := GerarSeqOnd;

    LClone := TUniClientDataSet.Create(Nil);

    Try

      pCloneDataSet(LClone, FRemessas);
      LDataDeGeracao := fRetDataServidor;

      LClone.First;
      While Not LClone.Eof Do
      Begin
        pProgresso(LClone.RecNo, LClone.RecordCount, pgbStatus);

        If (LClone.FieldByName('MARDES').AsString = SELECIONADO) Then
          UpdateAgrupar(LClone.FieldByName('ONDFIN').AsString, FRemessaDeSeparacaoGerada, LDataDeGeracao);

        LClone.Next;
      End;

      Result := True;

    Finally
      FreeAndNil(LClone);
    End;

  Except
    On E: Exception Do
      Raise ExceptionAutComGeracaoRemessaDeSeparacao_Agrupa.Create(E.Message);
  End;

end;

procedure TRemessaDeSeparacao.RealizarImpressao;
begin
  AgrupamentoDeOndaDeSeparacao.Funcoes.RealizarImpressao(FRemessaDeSeparacaoGerada);
end;

procedure TRemessaDeSeparacao.setOndas(AOndas: TUniClientDataSet);
begin
  pCloneDataSet(FRemessas, AOndas);
end;

procedure TRemessaDeSeparacao.TratamentoExcecoes(AExcecao: Exception);
begin
  If AExcecao Is ExceptionAutComGeracaoRemessaDeSeparacao_Cortes Then
    pMensagensErro('Erro: Corte de pedido(s) sem saldo:' + AExcecao.Message, '')
  Else
  If AExcecao Is ExceptionAutComGeracaoRemessaDeSeparacao_Agrupa Then
    pMensagensErro('Erro: Ao agrupar remessas de pedido:' + AExcecao.Message, '')
  Else
  If AExcecao Is ExceptionAutComGeracaoRemessaDeSeparacao_DefLot Then
    pMensagensErro('Erro: Ao definir lotes para a remessa de separação:' + AExcecao.Message, '')
  Else
  If AExcecao Is Exception Then
    pMensagensErro('Erro: Ao gerar remessa de separação:' + AExcecao.Message, '');
end;

procedure TRemessaDeSeparacao.UpdateAgrupar(ARemessaDePedido, ARemessaDeSeparacao: String; ADataDeGeracao: TDate);
  const
    SQL = 'UPDATE EXTGOR SET FGO_SEQOND = :SEQOND, FGO_DTAOND = :DTAOND WHERE FGO_SEQSEP = :SEQSEP';
  var
    LQryUpd : TUniQuery;
begin

  If ARemessaDePedido.IsEmpty Then
    Exit;

  If ARemessaDeSeparacao.IsEmpty Then
    Exit;

  LQryUpd := fCriaQuery();

  Try

    LQryUpd.SQL.Clear;
    LQryUpd.SQL.Add(SQL);
    LQryUpd.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
    LQryUpd.ParamByName('SEQSEP').AsString := ARemessaDePedido;
    LQryUpd.ParamByName('DTAOND').AsDate   := ADataDeGeracao;
    LQryUpd.ExecSQL;

  Finally
    FreeAndNil(LQryUpd);
  End;

end;

function TRemessaDeSeparacao.Validacoes(pgbStatus: TcxProgressBar): Boolean;
  var
    LDocTra : String;
    LEspTra : String;
    LEmpTra : String;
    LCliTra : String;
    LDocume : String;
begin

  Result := True;

  FQryPDs.First;
  While Not FQryPDs.Eof Do
  Begin

    pProgresso(FQryPDs.RecNo, FQryPDs.RecordCount, pgbStatus);

    LDocTra := FQryPDs.FieldByName('NUMDOC').AsString;
    LEspTra := FQryPDs.FieldByName('ESPDOC').AsString;
    LEmpTra := FQryPDs.FieldByName('CODEMP').AsString;
    LCliTra := FQryPDs.FieldByName('CODCLI').AsString;

    LDocume := LDocTra + '-' + LEspTra + '-' + LEmpTra;

    If Not FLock.fLock_Unlock('FATGOR' + LDocTra + LEspTra + LEmpTra, True, False,
                              False, '', True, '', True, True, False, False, False) Then
    Begin
      FMensagensDeErro.Add('Esse documento '+LDocume+' está sendo utilizado em outra estação por ' + fGetHostLock('FATGOR' + LDocTra + LEspTra + LEmpTra)  + '!');
      Exit(False);
    End;

    If Not FLock.fLock_Unlock('CADREC' + LDocTra + LEspTra + LEmpTra + LCliTra, True, False,
                              False, '', True, '', True, True, False, False, False) Then
    Begin
      FMensagensDeErro.Add('Esse documento '+LDocume+' está sendo utilizado em outra estação por ' + fGetHostLock('CADREC' + LDocTra + LEspTra + LEmpTra + LCliTra)  + '!');
      Exit(False);
    End;

    FQryPDs.Next;

  End;

end;

function TRemessaDeSeparacao.ValidaLotesRemessasSelecionadas: Boolean;
  Var
    LCodItens: String;
    LItemOnda: TItemRemessaSeparacao;
    LQry     : TUniQuery;
begin

  Result := False;

  if Length(FItensAgrupadosRemessa) = 0 then
    Exit;

  LQry := fCriaQuery;

  Try

    LCodItens := EmptyStr;

    for LItemOnda in FItensAgrupadosRemessa do
    begin
      if LItemOnda.strIdePro = 'NOR' then
        if LItemOnda.strProAca <> 'S' then
          pIncrementaListaStr(LItemOnda.strCodIte, LCodItens, True);
    end;

    if LCodItens.IsEmpty then
      Exit(True);

    LQry.SQL.Add('SELECT ITE_CODITE');
    LQry.SQL.Add('FROM CADITE');
    LQry.SQL.Add('WHERE ITE_CODITE IN ('+ LCodItens +')');
    LQry.SQL.Add('AND NOT EXISTS (SELECT 1 FROM CADLOT');
    LQry.SQL.Add('                WHERE LOT_CODITE = ITE_CODITE');
    LQry.SQL.Add('                  AND LOT_CODEMP = :CODEMP');
    LQry.SQL.Add('                  AND LOT_NUMLOT = :NUMLOT)');

    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.ParamByName('NUMLOT').AsString := STR_A_DEFINIR;
    LQry.Open;

    Result := LQry.IsEmpty;

    if not Result then
    begin

      LCodItens := EmptyStr;

      LQry.First;
      while not LQry.Eof do
      begin
        pIncrementaListaStr(LQry.FieldByName('ITE_CODITE').AsString, LCodItens);

        LQry.Next;
      end;

      pMensagemSonora('Para separar um pedido utilizando rotina de WMS é necessário que todos os '+
                      'produtos possuam lote "'+ STR_A_DEFINIR +'" cadastrado corretamente. '+ sLineBreak +
                      'Favor verificar o cadastro de lotes dos produtos: '+ LCodItens +'.');

    end;

  Finally
    FreeAndNil(LQry);
  End;

end;

{ TLog }

procedure TLog.Add(AInfo: String);
begin
  FLog.Add(AInfo);
end;

destructor TLog.Destroy;
begin

  inherited;

  If Assigned(FLog) Then
    FreeAndNil(FLog);

end;

procedure TLog.Finalizou;
  var
    LInf : String;
    LTot : TTime;
begin

  FFin := fNow;
  LTot := (FFin - FIni);

  LInf := 'Finalizou o processo - ' + AProcesso + ': ' + FormatDateTime('hh:mm:ss:zzz', FFin);
  Add(LInf);
  Add('Tempo total: ' + FormatDateTime('hh:mm:ss:zzz', LTot));
  Add(EmptyStr);

end;

procedure TLog.IniciouProcesso(AProcesso: String);
  var
    LInf : String;
begin
  FIni := fNow;
  LInf := 'Iniciou o processo - ' + AProcesso + ': ' + FormatDateTime('hh:mm:ss:zzz', FIni);
  Add(LInf);
end;

constructor TLog.New;
begin
  FLog := TStringList.Create;
end;

procedure TLog.Salvar(ANomeArquivo : String);
  var
    LArquivo : String;
begin

  LArquivo := ExtractFilePath(Application.ExeName) + ANomeArquivo;

  If FileExists(LArquivo) Then
    DeleteFile(LArquivo);

  FLog.SaveToFile(LArquivo);

end;

end.
