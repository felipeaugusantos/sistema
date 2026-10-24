unit untTransferenciaDivergenciaExcedente;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Controls, UniClientDataSet,
{$ENDIF}
  SysUtils, Classes, DB, Variants, Math, System.StrUtils,
  untZClient, Generics.Collections, Uni,
  untFuncoesGenerica, untPreparaGeracaoTE, untFatGor;

const
  MEN_TRF_DIVERGENCIA = 'GERADO PELA ROTINA DE ENTRADA SIMPLIFICADA COM DIVERGÊNCIA.';

type


  TDocumento = record
    strNumDoc : String;
    strEspDoc : String;
    strEmpDoc : String;
  end;

  TEmpresasTransf = record
    CodEmp: string;
    NomEmp: string;
    QtdEnviar: Double;
  end;

  TItemContext = record
    CodIte: string;
    CodBar: string;
    Descricao: string;
    TipoDivergencia: string; //A MAIS - A MENOS - FALTOU
    QtdDivergencia: Double;
    EmpresasTransf: TArray<TEmpresasTransf>;
  end;

  TTransferenciaDivergenciaExcedente = class
  private
    FobjDocumentos: TUniClientDataSet;
    FobjItens: TZClient;
    FobjItensColetor: TZClient;
    FcdsItensExcedentes: TUniClientDataSet;
    FstlSelecionados: TStringList;
    FintDeqTem: Integer;
    FstrEmpresaAtual: string;
    FblnGerarTransferencia: Boolean;

    FrecDocumentos: TList<TDocumento>;
    FrecItens: TList<TItemContext>;
    FArrEmpOrigem: TArray<string>;

    procedure pCarregarItens;
    procedure pMontarEmpresas;
    function  fExibirGradeConfirmacao: Boolean;
    procedure pAdicionarItem(const AstrCodIte, AstrCodBar, AstrDescricao, AstrTipoDiv: string; AfltQtdDiv: Double);
    procedure pCarregarItensConferidos;
    procedure pCarregarItensExcedente;
    procedure pCarregarItensConferidosColetor;

    procedure pValidarConsistencia;
    procedure pCriarPreparacoesTE(const AintIndiceEmpOri: Integer; const AstNumDoc, AstEspDoc, AstEmpDoc: string);
    procedure pGerarPedidos(const AstrEmpOri: String);
    function fSqlFiltroDocumentos: String;
    procedure pLimparPreparacoesPendentes;
    procedure pValidarReexecucao;
  public
    constructor Create;
    destructor Destroy; override;

    function fDocumentos(AobjDocumentos: TUniClientDataSet): TTransferenciaDivergenciaExcedente;
    function fItensTransferencia(AobjItens: TZClient): TTransferenciaDivergenciaExcedente;
    function fItensExcedentes(AobjItensExcedentes: TUniClientDataSet): TTransferenciaDivergenciaExcedente;
    function fItensColetor(AobjItensColetor: TZClient): TTransferenciaDivergenciaExcedente;
    function fSelecionados(AstlSelecionados: TStringList): TTransferenciaDivergenciaExcedente;
    function fDeqTem(AintDeqTem: Integer): TTransferenciaDivergenciaExcedente;
    function fGerarTransferencia(AblnGerarTransferencia: Boolean): TTransferenciaDivergenciaExcedente;
    function fEmpresaAtual(AstrEmpresaAtual: string): TTransferenciaDivergenciaExcedente;

    function fExecutar: Boolean;
    class function fNovo: TTransferenciaDivergenciaExcedente;
    class function fCancelarTransferenciasDivergencia(const AstrNumDocEntrada,
      AstrEspDocEntrada, AstrEmpDocEntrada: String;
      out AstrMsgBloqueio: String): Boolean;
  end;

implementation

{$IFNDEF LINUX}
uses
  untTransferenciaItensDivergencia;
{$ENDIF}

constructor TTransferenciaDivergenciaExcedente.Create;
begin
  FrecDocumentos     := TList<TDocumento>.Create;
  FrecItens          := TList<TItemContext>.Create;
end;

destructor TTransferenciaDivergenciaExcedente.Destroy;
begin
  FreeAndNil(FrecDocumentos);
  FreeAndNil(FrecItens);
  inherited Destroy;
end;

procedure TTransferenciaDivergenciaExcedente.pMontarEmpresas;
var
  LobjEmpresas: TDictionary<string, string>;
  LIndice: Integer;
  LstrAutoIncrem, LstrCodEmp, LstrNumDoc, LstrEspDoc: string;
  LrecDocumento: TDocumento;
begin
  FrecDocumentos.Clear;
  SetLength(FArrEmpOrigem, 0);

  LobjEmpresas := TDictionary<string, string>.Create;
  try
    for LIndice := 0 to FstlSelecionados.Count - 1 do
    begin
      LstrAutoIncrem := FstlSelecionados[LIndice];
      if not FobjDocumentos.Locate('AUTOINCREM', LstrAutoIncrem, []) then
        Continue;

      LstrCodEmp := FobjDocumentos.FieldByName('GER_CODEMP').AsString;
      LstrNumDoc := FobjDocumentos.FieldByName('GER_NUMDOC').AsString;
      LstrEspDoc := FobjDocumentos.FieldByName('GER_ESPDOC').AsString;

      if not LobjEmpresas.ContainsKey(LstrCodEmp) then
        LobjEmpresas.Add(LstrCodEmp, LstrCodEmp);

      LrecDocumento.strNumDoc := LstrNumDoc;
      LrecDocumento.strEspDoc := LstrEspDoc;
      LrecDocumento.strEmpDoc := LstrCodEmp;
      FrecDocumentos.Add(LrecDocumento);
    end;
    FArrEmpOrigem := LobjEmpresas.Values.ToArray;
  finally
    LobjEmpresas.Free;
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pCarregarItens;
begin
  FrecItens.Clear;
  pCarregarItensConferidos;
  pCarregarItensExcedente;
  pCarregarItensConferidosColetor;
end;

procedure TTransferenciaDivergenciaExcedente.pCarregarItensConferidos;
var
  LqtdIte, LqtdCon: Double;
  LstrTipoDiv: string;
  LqtdDiv: Double;
begin
  if Not (Assigned(FobjItens) and (FobjItens.RecordCount > 0)) then
    Exit;

  FobjItens.First;
  while not FobjItens.Eof do
  begin
    LqtdIte := FobjItens.FieldByName('QTDITE').AsFloat;
    LqtdCon := FobjItens.FieldByName('QTDCON').AsFloat;

    if LqtdCon < LqtdIte then
    begin
      LstrTipoDiv := 'A MENOS';
      LqtdDiv     := LqtdIte - LqtdCon;

      pAdicionarItem(
        FobjItens.FieldByName('CODITE').AsString,
        '',
        FobjItens.FieldByName('DESITE').AsString,
        LstrTipoDiv,
        LqtdDiv
      );
    end;

    FobjItens.Next;
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pCarregarItensExcedente;
begin
  if Not (Assigned(FcdsItensExcedentes) and (FcdsItensExcedentes.RecordCount > 0)) then
    Exit;

  FcdsItensExcedentes.First;
  while not FcdsItensExcedentes.Eof do
  begin
    pAdicionarItem(
      FcdsItensExcedentes.FieldByName('CODITE').AsString,
      '',
      FcdsItensExcedentes.FieldByName('DESITE').AsString,
      IfThen(FcdsItensExcedentes.FieldByName('TIPEXC').AsString = 'I', 'FALTOU', 'A MAIS'),
      FcdsItensExcedentes.FieldByName('QTDEXC').AsFloat
    );

    FcdsItensExcedentes.Next;
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pCarregarItensConferidosColetor;
var
  LqtdIte, LqtdCon: Double;
  LstrStatus, LstrTipoDiv: string;
  LqtdDiv: Double;
begin
  if Not (Assigned(FobjItensColetor) and (FobjItensColetor.RecordCount > 0)) then
    Exit;

  FobjItensColetor.First;
  while not FobjItensColetor.Eof do
  begin
    LstrStatus := FobjItensColetor.FieldByName('STATUS').AsString;

    if LstrStatus = 'OK' then
    begin
      FobjItensColetor.Next;
      Continue;
    end;

    LqtdIte := FobjItensColetor.FieldByName('QTDDOC').AsFloat;
    LqtdCon := FobjItensColetor.FieldByName('QTDDIG').AsFloat;
    LqtdDiv := LqtdCon;
    LstrTipoDiv := LstrStatus;

    if (LstrStatus = 'MAIS') Then
    begin
      LstrTipoDiv := 'A MAIS';
      LqtdDiv     := LqtdCon - LqtdIte;
    end
    else if (LstrStatus = 'MENOS')  then
    begin
      LstrTipoDiv := 'A MENOS';
      LqtdDiv     := LqtdIte - LqtdCon;
    end;

    if LstrTipoDiv <> '' then
    begin
      pAdicionarItem(
        FobjItensColetor.FieldByName('CODITE').AsString,
        '',
        FobjItensColetor.FieldByName('ITE_DESITE').AsString,
        LstrTipoDiv,
        LqtdDiv
      );
    end;

    FobjItensColetor.Next;
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pAdicionarItem(const AstrCodIte, AstrCodBar, AstrDescricao, AstrTipoDiv: string; AfltQtdDiv: Double);
var
  LItem: TItemContext;
  I: Integer;
begin
  LItem.CodIte          := AstrCodIte;
  LItem.CodBar          := AstrCodBar;
  LItem.Descricao       := AstrDescricao;
  LItem.TipoDivergencia := AstrTipoDiv;
  LItem.QtdDivergencia  := RoundTo(AfltQtdDiv, -FintDeqTem);

  SetLength(LItem.EmpresasTransf, Length(FArrEmpOrigem));
  for I := 0 to High(FArrEmpOrigem) do
  begin
    LItem.EmpresasTransf[I].CodEmp    := FArrEmpOrigem[I];
    LItem.EmpresasTransf[I].NomEmp    := fRetNomeEmpresa(FArrEmpOrigem[I]);
    LItem.EmpresasTransf[I].QtdEnviar := 0;
  end;

  FrecItens.Add(LItem);
end;

function TTransferenciaDivergenciaExcedente.fExibirGradeConfirmacao: Boolean;
{$IFDEF LINUX}
begin
  Result := False;
end;
{$ELSE}
var
  LfrmTransferenciaItensDivergencia: TfrmTransferenciaItensDivergencia;
begin
  pCriarFormularios(TfrmTransferenciaItensDivergencia, LfrmTransferenciaItensDivergencia);
  try
    LfrmTransferenciaItensDivergencia.ListaItens := FrecItens;
    LfrmTransferenciaItensDivergencia.ShowModal;
    Result := LfrmTransferenciaItensDivergencia.ModalResult = mrOk;
  finally
    FreeAndNil(LfrmTransferenciaItensDivergencia);
  end;
end;
{$ENDIF}

function TTransferenciaDivergenciaExcedente.fDeqTem(AintDeqTem: Integer): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FintDeqTem := AintDeqTem;
end;

function TTransferenciaDivergenciaExcedente.fDocumentos(AobjDocumentos: TUniClientDataSet): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FobjDocumentos := AobjDocumentos;
end;

function TTransferenciaDivergenciaExcedente.fEmpresaAtual(AstrEmpresaAtual: string): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FstrEmpresaAtual := AstrEmpresaAtual;
end;

function TTransferenciaDivergenciaExcedente.fGerarTransferencia(AblnGerarTransferencia: Boolean): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FblnGerarTransferencia := AblnGerarTransferencia;
end;

function TTransferenciaDivergenciaExcedente.fItensColetor(AobjItensColetor: TZClient): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FobjItensColetor := AobjItensColetor;
end;

function TTransferenciaDivergenciaExcedente.fItensExcedentes(AobjItensExcedentes: TUniClientDataSet): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FcdsItensExcedentes := AobjItensExcedentes;
end;

function TTransferenciaDivergenciaExcedente.fItensTransferencia(AobjItens: TZClient): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FobjItens := AobjItens;
end;

function TTransferenciaDivergenciaExcedente.fSelecionados(AstlSelecionados: TStringList): TTransferenciaDivergenciaExcedente;
begin
  Result := Self;
  FstlSelecionados := AstlSelecionados;
end;

function TTransferenciaDivergenciaExcedente.fExecutar: Boolean;
var
  LstrEmpDoc        : string;
  LIndiceEmpOri,
  LIndiceItens,
  LIndiceDocumento  : Integer;
  LstrNumDoc,
  LstrEspDoc        : string;
  LItem             : TItemContext;
  LstrEmpOri        : String;
begin
  if not FblnGerarTransferencia then
    Exit(True);

  pMontarEmpresas;

  if Length(FArrEmpOrigem) = 0 then
    Exit(True);

  pCarregarItens;

  if FrecItens.Count = 0 then
    Exit(True);

  pValidarReexecucao;

  if Length(FArrEmpOrigem) = 1 then
  begin
    for LIndiceItens := 0 to FrecItens.Count - 1 do
    begin
      LItem := FrecItens[LIndiceItens];
      LItem.EmpresasTransf[0].QtdEnviar := LItem.QtdDivergencia;
      FrecItens[LIndiceItens] := LItem;
    end;
  end
  else
  begin
    if not fExibirGradeConfirmacao then
      Exit(False);
  end;

  pValidarConsistencia;

  try
    for LIndiceEmpOri := 0 to High(FArrEmpOrigem) do
    begin
      LstrEmpDoc := FArrEmpOrigem[LIndiceEmpOri];

      LstrNumDoc := '';
      LstrEspDoc := '';
      for LIndiceDocumento := 0 to FrecDocumentos.Count - 1 do
        if FrecDocumentos[LIndiceDocumento].strEmpDoc = LstrEmpDoc then
        begin
          LstrNumDoc := FrecDocumentos[LIndiceDocumento].strNumDoc;
          LstrEspDoc := FrecDocumentos[LIndiceDocumento].strEspDoc;
          Break;
        end;

      pCriarPreparacoesTE(LIndiceEmpOri, LstrNumDoc, LstrEspDoc, LstrEmpDoc);
    end;

    for LstrEmpOri In FArrEmpOrigem do
      pGerarPedidos(LstrEmpOri);

    if not MatchText(FstrEmpresaAtual, FArrEmpOrigem) then
      pGerarPedidos(FstrEmpresaAtual);

    Result := True;
  except
    on E: Exception do
    begin
      try
        pLimparPreparacoesPendentes;   {agora só faz rollback se houver T1 viva}
      except
        on EClean: Exception do
          pMensagensErro(
            'Falha adicional ao reverter preparações pendentes: ' + EClean.Message,
            '[TTransferenciaDivergenciaExcedente.pLimparPreparacoesPendentes]');
      end;

      Result := False;
      pMensagensErro(E.Message, '[TTransferenciaDivergenciaExcedente.fExecutar]');
    end;
  end;
end;

class function TTransferenciaDivergenciaExcedente.fNovo: TTransferenciaDivergenciaExcedente;
begin
  Result := TTransferenciaDivergenciaExcedente.Create;
end;

procedure TTransferenciaDivergenciaExcedente.pValidarConsistencia;
begin
  if FrecItens.Count = 0 then
    Raise Exception.Create('Não há itens divergentes para gerar transferência.');

  if FrecDocumentos.Count = 0 then
    Raise Exception.Create('Documento não informado.');
end;

procedure TTransferenciaDivergenciaExcedente.pCriarPreparacoesTE(const AintIndiceEmpOri: Integer; const AstNumDoc, AstEspDoc, AstEmpDoc: string);
var
  LintIndice         : Integer;
  strAutPrep         : String;
  LstrEmpresaOrigem  : String;
  LstrEmpresaDestino : String;
  LQtdEnviar         : Double;
  LItem              : TItemContext;
begin
  for LintIndice := 0 to FrecItens.Count - 1 do
  begin
    LItem      := FrecItens[LintIndice];
    LQtdEnviar := LItem.EmpresasTransf[AintIndiceEmpOri].QtdEnviar;

    if LQtdEnviar <= 0 then
      Continue;

    if (LItem.TipoDivergencia = 'A MAIS') or (LItem.TipoDivergencia = 'FALTOU') then
    begin
      LstrEmpresaOrigem  := AstEmpDoc;
      LstrEmpresaDestino := FstrEmpresaAtual;
    end
    else // 'A MENOS'
    begin
      LstrEmpresaOrigem  := FstrEmpresaAtual;
      LstrEmpresaDestino := AstEmpDoc;
    end;
    strAutPrep := '';

    if not TPreparaGeracaoTE.fGravarPreparaGeracaoTE_MultiLoja(
              AstNumDoc,
              AstEspDoc,
              FstrEmpresaAtual,
              LItem.CodIte,
              LstrEmpresaOrigem,
              LstrEmpresaDestino,
              '',
              LQtdEnviar,
              strAutPrep,
              True,
              '') then
      Raise Exception.Create(
        'Item ' + LItem.CodIte +
        ' (preparação de transferência): consulte a mensagem de erro anterior para detalhes.');
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pGerarPedidos(const AstrEmpOri: String);
var
  LobjPreparaGeracaoTE : TPreparaGeracaoTE;
begin
  if FrecItens.Count = 0 then
    Exit;

  LobjPreparaGeracaoTE := TPreparaGeracaoTE.Create(fGravaFatGor, fGravaFatDor);
  try
    LobjPreparaGeracaoTE.Men001Customizada := MEN_TRF_DIVERGENCIA;
    if not LobjPreparaGeracaoTE.fGeraPedidosVenda(AstrEmpOri) then
      Raise Exception.Create('Falha ao gerar pedidos de transferência para a empresa origem ' +
                             AstrEmpOri + '.');
  finally
    FreeAndNil(LobjPreparaGeracaoTE);
  end;
end;

function TTransferenciaDivergenciaExcedente.fSqlFiltroDocumentos: String;
var
  LIndice: Integer;
begin
  Result := '';
  for LIndice := 0 to FrecDocumentos.Count - 1 do
  begin
    if Result <> '' then
      Result := Result + ' OR ';
    Result := Result +
      '(PRE_DOCABS = ' + QuotedStr(FrecDocumentos[LIndice].strNumDoc) +
      ' AND PRE_ESPABS = ' + QuotedStr(FrecDocumentos[LIndice].strEspDoc) +
      ' AND PRE_EMPABS = ' + QuotedStr(FstrEmpresaAtual) + ')';
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pValidarReexecucao;
var
  LqryLock      : TUniQuery;
  LstrCondicoes : String;
  LIndice       : Integer;
begin
  if FrecDocumentos.Count = 0 then
    Exit;

  LstrCondicoes := '';
  for LIndice := 0 to FrecDocumentos.Count - 1 do
  begin
    if LstrCondicoes <> '' then
      LstrCondicoes := LstrCondicoes + ' OR ';
    LstrCondicoes := LstrCondicoes +
      '(PRE_DOCABS = :DOC' + IntToStr(LIndice) +
      ' AND PRE_ESPABS = :ESP' + IntToStr(LIndice) + ')';
  end;

  LqryLock := fCriaQuery(nil);
  try
    LqryLock.SQL.Text :=
      'SELECT COUNT(*) AS QTD FROM PREPTE ' +
      'WHERE PRE_NUMDOC IS NULL ' +
      '  AND PRE_EMPABS = :EMPATU ' +
      '  AND (' + LstrCondicoes + ')';

    LqryLock.ParamByName('EMPATU').AsString := FstrEmpresaAtual;
    for LIndice := 0 to FrecDocumentos.Count - 1 do
    begin
      LqryLock.ParamByName('DOC' + IntToStr(LIndice)).AsString :=
        FrecDocumentos[LIndice].strNumDoc;
      LqryLock.ParamByName('ESP' + IntToStr(LIndice)).AsString :=
        FrecDocumentos[LIndice].strEspDoc;
    end;

    LqryLock.Open;

    if LqryLock.FieldByName('QTD').AsInteger > 0 then
      raise Exception.Create(
        'Já existem preparações de transferência pendentes para os documentos ' +
        'desta conferência. Verifique o Painel de TE antes de tentar finalizar ' +
        'novamente.');
  finally
    FreeAndNil(LqryLock);
  end;
end;

procedure TTransferenciaDivergenciaExcedente.pLimparPreparacoesPendentes;
var
  LqryDel    : TUniQuery;
  LstrFiltro : String;
begin
  LstrFiltro := fSqlFiltroDocumentos;
  if LstrFiltro = '' then
    Exit;

  if fInTransaction then
    fRollBack;

  fStartTransaction;
  LqryDel := fCriaQuery(nil);
  try
    try
      LqryDel.SQL.Text :=
        'DELETE FROM PREPTE ' +
        'WHERE PRE_NUMDOC IS NULL ' +
        '  AND (' + LstrFiltro + ') ' +
        '  AND IFNULL((SELECT COUNT(*) FROM REQVEN WHERE SEQ_PREPTE = PREPTE.AUTOINCREM), 0) = 0 ' +
        '  AND IFNULL((SELECT COUNT(*) FROM BAIREQ WHERE BAI_QTDREQ = PREPTE.AUTOINCREM), 0) = 0';
      LqryDel.ExecSQL;
      fCommit;
    except
      on E: Exception do
      begin
        if fInTransaction then
          fRollBack;
        raise;
      end;
    end;
  finally
    FreeAndNil(LqryDel);
  end;
end;

class function TTransferenciaDivergenciaExcedente.fCancelarTransferenciasDivergencia(
  const AstrNumDocEntrada, AstrEspDocEntrada, AstrEmpDocEntrada : String;
  out AstrMsgBloqueio : String) : Boolean;
Const
  CstrNomFrm = 'untTransferenciaDivergenciaExcedente';
  CstrMotDel = 'CANCELAMENTO DE NE GERADA NA ENTRADA SIMPLIFICADA COM DIVERGÊNCIA.';
Var
  LqryPrep    : TUniQuery;
  LqryBkp     : TUniQuery;
  LqryDel     : TUniQuery;
  LqryDep     : TUniQuery;
  LstrIncFGo  : String;
  LstrIncPrep : String;
  LstrNumDocF : String;
  LstrEspDocF : String;
  LstrCodEmpF : String;
  LstrCodCliF : String;
Begin
  Result          := True;
  AstrMsgBloqueio := '';

  LqryPrep := fCriaQuery(nil);
  Try
    LqryBkp := fCriaQuery(nil);
    Try
      LqryDel := fCriaQuery(nil);
      Try
        LqryDep := fCriaQuery(nil);
        Try
          LqryPrep.SQL.Text :=
            'SELECT P.AUTOINCREM       AS PRE_INCREM, '         +
            '       P.PRE_NUMDOC, P.PRE_ESPDOC, P.PRE_EMPDOC, ' +
            '       F.AUTOINCREM       AS FGO_INCREM, '         +
            '       F.FGO_JAFATU, F.FGO_NUMFAT, '               +
            '       F.FGO_NUMDOC       AS FGO_NUMDOC_, '        +
            '       F.FGO_ESPDOC       AS FGO_ESPDOC_, '        +
            '       F.FGO_CODEMP       AS FGO_CODEMP_, '        +
            '       F.FGO_CODCLI '                              +
            '  FROM PREPTE P '                                  +
            '  LEFT JOIN FATGOR F ON F.FGO_NUMDOC = P.PRE_NUMDOC ' +
            '                   AND F.FGO_ESPDOC = P.PRE_ESPDOC ' +
            '                   AND F.FGO_CODEMP = P.PRE_EMPDOC ' +
            ' WHERE P.PRE_DOCABS = :DOCABS '                    +
            '   AND P.PRE_ESPABS IN ("TE","NF") '               +
            '   AND P.PRE_EMPABS = :EMPABS '                    +
            '   AND (F.FGO_MEN001 = :MENSAGEM '                 +
            '        OR F.AUTOINCREM IS NULL)';
          LqryPrep.ParamByName('DOCABS').AsString   := AstrNumDocEntrada;
          LqryPrep.ParamByName('EMPABS').AsString   := AstrEmpDocEntrada;
          LqryPrep.ParamByName('MENSAGEM').AsString := MEN_TRF_DIVERGENCIA;
          LqryPrep.Open;

          If LqryPrep.IsEmpty Then
            Exit;

          LqryPrep.First;
          While Not LqryPrep.Eof Do
          Begin
            If Not LqryPrep.FieldByName('FGO_INCREM').IsNull Then
            Begin
              If LqryPrep.FieldByName('FGO_JAFATU').AsInteger > 0 Then
              Begin
                Result := False;
                AstrMsgBloqueio :=
                  'Não foi possível cancelar este documento. '         +
                  'O Pedido de Transferência '                         +
                  LqryPrep.FieldByName('FGO_NUMDOC_').AsString + '/'   +
                  LqryPrep.FieldByName('FGO_ESPDOC_').AsString         +
                  ' (empresa ' +
                  LqryPrep.FieldByName('FGO_CODEMP_').AsString + ')'   +
                  ' já foi baixado.';
                Exit;
              End;

              If Trim(LqryPrep.FieldByName('FGO_NUMFAT').AsString) <> '' Then
              Begin
                Result := False;
                AstrMsgBloqueio :=
                  'Não foi possível cancelar este documento. '         +
                  'O Pedido de Transferência '                         +
                  LqryPrep.FieldByName('FGO_NUMDOC_').AsString + '/'   +
                  LqryPrep.FieldByName('FGO_ESPDOC_').AsString         +
                  ' já foi faturado no documento '                     +
                  LqryPrep.FieldByName('FGO_NUMFAT').AsString + '.';
                Exit;
              End;
            End;

            LqryDep.Close;
            LqryDep.SQL.Text :=
              'SELECT '                                                                              +
              '  IFNULL((SELECT COUNT(*) FROM REQVEN WHERE SEQ_PREPTE = :SEQPRE), 0) AS QTDREQ, '    +
              '  IFNULL((SELECT COUNT(*) FROM BAIREQ WHERE BAI_QTDREQ = :SEQPRE), 0) AS QTDBAI '     +
              'FROM DUAL';
            LqryDep.ParamByName('SEQPRE').AsString :=
              LqryPrep.FieldByName('PRE_INCREM').AsString;
            LqryDep.Open;

            If (LqryDep.FieldByName('QTDREQ').AsInteger > 0) Or
               (LqryDep.FieldByName('QTDBAI').AsInteger > 0) Then
            Begin
              Result := False;
              AstrMsgBloqueio :=
                'Não foi possível cancelar este documento. '                              +
                'A preparação de transferência '                                          +
                LqryPrep.FieldByName('PRE_NUMDOC').AsString + '/'                         +
                LqryPrep.FieldByName('PRE_ESPDOC').AsString                               +
                ' (empresa ' + LqryPrep.FieldByName('PRE_EMPDOC').AsString + ')'          +
                ' possui requisições ou baixas associadas e não pode ser removida.';
              Exit;
            End;

            LqryPrep.Next;
          End;

          LqryPrep.First;
          While Not LqryPrep.Eof Do
          Begin
            LstrIncPrep := LqryPrep.FieldByName('PRE_INCREM').AsString;

            If Not LqryPrep.FieldByName('FGO_INCREM').IsNull Then
            Begin
              LstrIncFGo  := LqryPrep.FieldByName('FGO_INCREM').AsString;
              LstrNumDocF := LqryPrep.FieldByName('FGO_NUMDOC_').AsString;
              LstrEspDocF := LqryPrep.FieldByName('FGO_ESPDOC_').AsString;
              LstrCodEmpF := LqryPrep.FieldByName('FGO_CODEMP_').AsString;
              LstrCodCliF := LqryPrep.FieldByName('FGO_CODCLI').AsString;

              LqryBkp.Close;
              LqryBkp.SQL.Text :=
                'SELECT * FROM FATDOR '         +
                ' WHERE FDO_NUMDOC = :NUMDOC '  +
                '   AND FDO_ESPDOC = :ESPDOC '  +
                '   AND FDO_CODEMP = :CODEMP '  +
                '   AND FDO_CODCLI = :CODCLI';
              LqryBkp.ParamByName('NUMDOC').AsString := LstrNumDocF;
              LqryBkp.ParamByName('ESPDOC').AsString := LstrEspDocF;
              LqryBkp.ParamByName('CODEMP').AsString := LstrCodEmpF;
              LqryBkp.ParamByName('CODCLI').AsString := LstrCodCliF;
              LqryBkp.Open;
              If Not LqryBkp.IsEmpty Then
                fVerificaIntegridade(CstrNomFrm, 'FATDOR', LqryBkp, True, False, CstrMotDel);

              LqryDel.Close;
              LqryDel.SQL.Text :=
                'DELETE FROM FATDOR '          +
                ' WHERE FDO_NUMDOC = :NUMDOC ' +
                '   AND FDO_ESPDOC = :ESPDOC ' +
                '   AND FDO_CODEMP = :CODEMP ' +
                '   AND FDO_CODCLI = :CODCLI';
              LqryDel.ParamByName('NUMDOC').AsString := LstrNumDocF;
              LqryDel.ParamByName('ESPDOC').AsString := LstrEspDocF;
              LqryDel.ParamByName('CODEMP').AsString := LstrCodEmpF;
              LqryDel.ParamByName('CODCLI').AsString := LstrCodCliF;
              LqryDel.ExecSQL;

              LqryBkp.Close;
              LqryBkp.SQL.Text := 'SELECT * FROM PEDTRA WHERE TRA_FATGOR = :FGOINC';
              LqryBkp.ParamByName('FGOINC').AsString := LstrIncFGo;
              LqryBkp.Open;
              If Not LqryBkp.IsEmpty Then
                fVerificaIntegridade(CstrNomFrm, 'PEDTRA', LqryBkp, True, False, CstrMotDel);

              LqryDel.Close;
              LqryDel.SQL.Text := 'DELETE FROM PEDTRA WHERE TRA_FATGOR = :FGOINC';
              LqryDel.ParamByName('FGOINC').AsString := LstrIncFGo;
              LqryDel.ExecSQL;

              LqryBkp.Close;
              LqryBkp.SQL.Text := 'SELECT * FROM FATGOR WHERE AUTOINCREM = :FGOINC';
              LqryBkp.ParamByName('FGOINC').AsString := LstrIncFGo;
              LqryBkp.Open;
              If Not LqryBkp.IsEmpty Then
                fVerificaIntegridade(CstrNomFrm, 'FATGOR', LqryBkp, True, False, CstrMotDel);

              LqryDel.Close;
              LqryDel.SQL.Text := 'DELETE FROM FATGOR WHERE AUTOINCREM = :FGOINC';
              LqryDel.ParamByName('FGOINC').AsString := LstrIncFGo;
              LqryDel.ExecSQL;
            End;

            LqryBkp.Close;
            LqryBkp.SQL.Text := 'SELECT * FROM PREPTE WHERE AUTOINCREM = :SEQPRE';
            LqryBkp.ParamByName('SEQPRE').AsString := LstrIncPrep;
            LqryBkp.Open;
            If Not LqryBkp.IsEmpty Then
              fVerificaIntegridade(CstrNomFrm, 'PREPTE', LqryBkp, True, False, CstrMotDel);

            LqryDel.Close;
            LqryDel.SQL.Text :=
              'DELETE FROM PREPTE '                                                                       +
              ' WHERE AUTOINCREM = :SEQPRE '                                                              +
              '   AND IFNULL((SELECT COUNT(*) FROM REQVEN WHERE SEQ_PREPTE = PREPTE.AUTOINCREM), 0) = 0 ' +
              '   AND IFNULL((SELECT COUNT(*) FROM BAIREQ WHERE BAI_QTDREQ = PREPTE.AUTOINCREM), 0) = 0';
            LqryDel.ParamByName('SEQPRE').AsString := LstrIncPrep;
            LqryDel.ExecSQL;

            LqryPrep.Next;
          End;
        Finally
          FreeAndNil(LqryDep);
        End;
      Finally
        FreeAndNil(LqryDel);
      End;
    Finally
      FreeAndNil(LqryBkp);
    End;
  Finally
    FreeAndNil(LqryPrep);
  End;
End;

end.


