unit untTDireitoAcesso;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Aurelius.Bind.Dataset, DB,
  untTCadGpo, untTCadOpe, untTCadOpeRepository, untTCadGpoRepository, untTDirOpeRepository,
  untTDirOpe, untTDirGpo, untTDirGpoRepository, System.Generics.Defaults, untFuncoesSimples;



Type
  TipoOperacao = (opNone, opInsert, opUpdate, opDelete);

  TRecDireitoAcesso = class
  Private
    FOpOperacao    : TipoOperacao;
  Public
    Constructor Create(AOperacao: TipoOperacao);

    procedure pOperacaoInserir;
    procedure pOperacaoAtualizar;
    procedure pOperacaoExcluir;
    function  fGetOperacao: TipoOperacao;
  end;

  TRecDirOperador = class(TRecDireitoAcesso)
  Private
    FRecDirOperador: TDirOpe;
  Public
    Constructor Create(ADirOperador: TDirOpe; AOperacao: TipoOperacao);

    property recDirOperador: TDirOpe Read FRecDirOperador Write FRecDirOperador;
  end;

  TRecDirGrupo = class(TRecDireitoAcesso)
  Private
    FRecDirGrupo: TDirGpo;
  Public
    Constructor Create(ADirGrupo: TDirGpo; AOperacao: TipoOperacao);

    property recDirGrupo: TDirGpo Read FRecDirGrupo Write FRecDirGrupo;
  end;

  TDireitoAcesso = class(TComponent)
  Private
    FCodEmp: String;
    FOrderGrupoPorDescricao: IComparer<TCadGpo>;
    FOrderOperadorPorNome  : IComparer<TCadOpe>;
    FPossuiAlteracoes      : Boolean;

    lstCadGrupos             : TList<TCadGpo>;
    lstCadOperadores         : TList<TCadOpe>;
    lstCadGruposPermissao    : TList<TCadGpo>;
    lstCadOperadoresPermissao: TList<TCadOpe>;

    repCadGrupos    : TCadGpoRepository;
    repCadOperadores: TCadOpeRepository;
    repDirGrupos    : TDirGpoRepository;
    repDirOperadores: TDirOpeRepository;

    qryCadGrupos             : TAureliusDataset;
    qryCadOperadores         : TAureliusDataset;
    qryCadGruposPermissao    : TAureliusDataset;
    qryCadOperadoresPermissao: TAureliusDataset;

    dtsCadGrupos             : TDataSource;
    dtsCadOperadores         : TDataSource;
    dtsCadGruposPermissao    : TDataSource;
    dtsCadOperadoresPermissao: TDataSource;

    lstRecDirOperadores: TList<TRecDirOperador>;
    lstRecDirGrupos    : TList<TRecDirGrupo>;

    procedure pDefinirDataSets;
    function  pListarOperadoresSistema: TList<TCadOpe>;
    function  pListarGruposSistema: TList<TCadGpo>;

    procedure pListarOperadoresComPermissao(strNomFrm: String);
    procedure pListarOperadoresSemPermissao(strNomFrm: String);
    procedure pListarGruposComPermissao(strNomFrm: String);
    procedure pListarGruposSemPermissao(strNomFrm: String);

    procedure pOrderGrupoPorDescricao;
    procedure pOrderOperadorPorNome;

    procedure pVerificarAlteracoesPendentes;
  Public
    Constructor Create(Owner: TComponent; strCodEmp: String); Reintroduce;
    Destructor  Destroy; Override;

    function  fCarregarOperadoresComPermissao(strNomFrm: String): TDataSource;
    function  fCarregarOperadoresSemPermissao(strNomFrm: String): TDataSource;
    function  fCarregarGruposComPermissao(strNomFrm: String): TDataSource;
    function  fCarregarGruposSemPermissao(strNomFrm: String): TDataSource;

    function  fVerificarConcederPermissaoOperador(strNomFrm, strCodOpe: String): Boolean;
    function  fVerificarConcederPermissaoGrupo(strNomFrm: String; intCodGpo: Integer): Boolean;
    function  fVerificarRemoverPermissaoOperador(strNomFrm, strCodOpe: String): Boolean;
    function  fVerificarRemoverPermissaoGrupo(strNomFrm: String; intCodGpo: Integer): Boolean;

    procedure pConcederPermissaoTodosOperadores(strNomFrm: String);
    procedure pConcederPermissaoTodosGrupos(strNomFrm: String);
    procedure pConcederPermissaoOperador(strNomFrm: String; objCadOpe: TCadOpe);
    procedure pConcederPermissaoGrupo(strNomFrm: String; objCadGpo: TCadGpo);

    procedure pRemoverPermissaoTodosOperadores(strNomFrm: String);
    procedure pRemoverPermissaoTodosGrupos(strNomFrm: String);
    procedure pRemoverPermissaoOperador(strNomFrm: String; objCadOpe: TCadOpe);
    procedure pRemoverPermissaoGrupo(strNomFrm: String; objCadGpo: TCadGpo);

    procedure pGravarAlteracoes;

    property bolAlteracoesPendentes: Boolean Read FPossuiAlteracoes;
  End;

implementation

{ TRecDireitoAcesso }

constructor TRecDireitoAcesso.Create(AOperacao: TipoOperacao);
begin
  Self.FOpOperacao := AOperacao;
end;

function TRecDireitoAcesso.fGetOperacao: TipoOperacao;
begin
  Result := Self.FOpOperacao;
end;

procedure TRecDireitoAcesso.pOperacaoAtualizar;
begin
  Self.FOpOperacao := opUpdate;
end;

procedure TRecDireitoAcesso.pOperacaoExcluir;
begin
  Self.FOpOperacao := opDelete;
end;

procedure TRecDireitoAcesso.pOperacaoInserir;
begin
  Self.FOpOperacao := opInsert;
end;

{ TRecDirOperador }

Constructor TRecDirOperador.Create(ADirOperador: TDirOpe; AOperacao: TipoOperacao);
begin
  inherited Create(AOperacao);

  Self.FRecDirOperador := ADirOperador;
end;

{ TRecDirGrupo }

constructor TRecDirGrupo.Create(ADirGrupo: TDirGpo; AOperacao: TipoOperacao);
begin
  inherited Create(AOperacao);

  Self.FRecDirGrupo := ADirGrupo;
end;

{ TDireitoAcesso }

constructor TDireitoAcesso.Create(Owner: TComponent; strCodEmp: String);
begin
  inherited Create(Owner);

  Self.FCodEmp           := strCodEmp;
  Self.FPossuiAlteracoes := False;

  Self.lstCadGrupos              := TList<TCadGpo>.Create();
  Self.lstCadOperadores          := TList<TCadOpe>.Create();
  Self.lstCadGruposPermissao     := TList<TCadGpo>.Create();
  Self.lstCadOperadoresPermissao := TList<TCadOpe>.Create();

  Self.qryCadGrupos              := TAureliusDataset.Create(Owner);
  Self.qryCadOperadores          := TAureliusDataset.Create(Owner);
  Self.qryCadGruposPermissao     := TAureliusDataset.Create(Owner);
  Self.qryCadOperadoresPermissao := TAureliusDataset.Create(Owner);

  Self.dtsCadGrupos              := TDataSource.Create(Owner);
  Self.dtsCadOperadores          := TDataSource.Create(Owner);
  Self.dtsCadGruposPermissao     := TDataSource.Create(Owner);
  Self.dtsCadOperadoresPermissao := TDataSource.Create(Owner);

  Self.repCadGrupos     := TCadGpoRepository.Create();
  Self.repCadOperadores := TCadOpeRepository.Create();
  Self.repDirGrupos     := TDirGpoRepository.Create();
  Self.repDirOperadores := TDirOpeRepository.Create();

  Self.lstRecDirOperadores := TList<TRecDirOperador>.Create;
  Self.lstRecDirGrupos     := TList<TRecDirGrupo>.Create;

  pDefinirDataSets;
  pOrderGrupoPorDescricao;
  pOrderOperadorPorNome;
end;

destructor TDireitoAcesso.Destroy;
begin
  Self.lstCadGrupos.Free;
  Self.lstCadOperadores.Free;
  Self.lstCadGruposPermissao.Free;
  Self.lstCadOperadoresPermissao.Free;

  Self.qryCadGrupos.Free;
  Self.qryCadOperadores.Free;
  Self.qryCadGruposPermissao.Free;
  Self.qryCadOperadoresPermissao.Free;

  Self.repCadGrupos.Free;
  Self.repCadOperadores.Free;
  Self.repDirGrupos.Free;
  Self.repDirOperadores.Free;

  Self.lstRecDirOperadores.Free;
  Self.lstRecDirGrupos.Free;

  inherited;
end;

procedure TDireitoAcesso.pListarOperadoresComPermissao(strNomFrm: String);
  var
    lstDirOpe: TList<TDirOpe>;
    i: Integer;
begin
  lstCadOperadoresPermissao.Clear;
  lstDirOpe := repDirOperadores.fRetDirOperadorByFrm(strNomFrm);

  if (Assigned(lstDirOpe)) then
    for i := 0 to lstDirOpe.Count - 1 do
      lstCadOperadoresPermissao.Add(lstDirOpe[i].objCadOpe);
end;

function TDireitoAcesso.fCarregarGruposComPermissao(strNomFrm: String): TDataSource;
begin
  pListarGruposComPermissao(strNomFrm);
  lstCadGruposPermissao.Sort(FOrderGrupoPorDescricao);

  qryCadGruposPermissao.Close;
  qryCadGruposPermissao.SetSourceList(lstCadGruposPermissao);
  qryCadGruposPermissao.Open;

  Result := dtsCadGruposPermissao;
end;

function TDireitoAcesso.fCarregarGruposSemPermissao(strNomFrm: String): TDataSource;
begin
  pListarGruposSemPermissao(strNomFrm);
  lstCadGrupos.Sort(FOrderGrupoPorDescricao);

  qryCadGrupos.Close;
  qryCadGrupos.SetSourceList(lstCadGrupos);
  qryCadGrupos.Open;

  Result := dtsCadGrupos;
end;

function TDireitoAcesso.fCarregarOperadoresComPermissao(strNomFrm: String): TDataSource;
begin
  pListarOperadoresComPermissao(strNomFrm);
  lstCadOperadoresPermissao.Sort(FOrderOperadorPorNome);

  qryCadOperadoresPermissao.Close;
  qryCadOperadoresPermissao.SetSourceList(lstCadOperadoresPermissao);
  qryCadOperadoresPermissao.Open;

  Result := dtsCadOperadoresPermissao;
end;

function TDireitoAcesso.fCarregarOperadoresSemPermissao(strNomFrm: String): TDataSource;
begin
  pListarOperadoresSemPermissao(strNomFrm);
  lstCadOperadores.Sort(FOrderOperadorPorNome);

  qryCadOperadores.Close;
  qryCadOperadores.SetSourceList(lstCadOperadores);
  qryCadOperadores.Open;

  Result := dtsCadOperadores;
end;

function TDireitoAcesso.fVerificarConcederPermissaoGrupo(strNomFrm: String; intCodGpo: Integer): Boolean;
  var
    i: Integer;
    objRecGrupo: TRecDirGrupo;
begin
  Result      := True;
  objRecGrupo := nil;

  if (not fEmptyStr(strNomFrm)) and (intCodGpo > 0) then
  begin

    for i := 0 to lstRecDirGrupos.Count - 1 do
    begin
      if (SameText(lstRecDirGrupos[i].recDirGrupo.DIR_NOMFRM, strNomFrm))
        and (lstRecDirGrupos[i].recDirGrupo.GPO_CODGPO = intCodGpo)
        and (lstRecDirGrupos[i].fGetOperacao() = opDelete) then
          objRecGrupo := lstRecDirGrupos[i];
    end;

    if (Assigned(objRecGrupo)) then
    begin
      lstRecDirGrupos.Remove(objRecGrupo);
      Result := False;
    end;

    pVerificarAlteracoesPendentes;
  end;
end;

function TDireitoAcesso.fVerificarConcederPermissaoOperador(strNomFrm, strCodOpe: String): Boolean;
  var
    i: Integer;
    objRecOperador: TRecDirOperador;
begin
  Result         := True;
  objRecOperador := nil;

  if (not fEmptyStr(strNomFrm)) and (not fEmptyStr(strCodOpe)) then
  begin

    for i := 0 to lstRecDirOperadores.Count - 1 do
    begin
      if (SameText(lstRecDirOperadores[i].recDirOperador.DIR_NOMFRM, strNomFrm))
        and (SameText(lstRecDirOperadores[i].recDirOperador.OPE_CODOPE, strCodOpe))
        and (lstRecDirOperadores[i].fGetOperacao() = opDelete) then
          objRecOperador := lstRecDirOperadores[i];
    end;

    if (Assigned(objRecOperador)) then
    begin
      lstRecDirOperadores.Remove(objRecOperador);
      Result := False;
    end;

    pVerificarAlteracoesPendentes;
  end;
end;

function TDireitoAcesso.fVerificarRemoverPermissaoGrupo(strNomFrm: String; intCodGpo: Integer): Boolean;
  var
    i: Integer;
    objRecGrupo: TRecDirGrupo;
begin
  Result      := True;
  objRecGrupo := nil;

  if (not fEmptyStr(strNomFrm)) and (intCodGpo > 0) then
  begin

    for i := 0 to lstRecDirGrupos.Count - 1 do
    begin
      if (SameText(lstRecDirGrupos[i].recDirGrupo.DIR_NOMFRM, strNomFrm))
        and (lstRecDirGrupos[i].recDirGrupo.GPO_CODGPO = intCodGpo)
        and (lstRecDirGrupos[i].fGetOperacao() in [opInsert, opUpdate]) then
          objRecGrupo := lstRecDirGrupos[i];
    end;

    if (Assigned(objRecGrupo)) then
    begin
      lstRecDirGrupos.Remove(objRecGrupo);
      Result := False;
    end;

    pVerificarAlteracoesPendentes;
  end;
end;

function TDireitoAcesso.fVerificarRemoverPermissaoOperador(strNomFrm, strCodOpe: String): Boolean;
  var
    i: Integer;
    objRecOperador: TRecDirOperador;
begin
  Result         := True;
  objRecOperador := nil;

  if (not fEmptyStr(strNomFrm)) and (not fEmptyStr(strCodOpe)) then
  begin

    for i := 0 to lstRecDirOperadores.Count - 1 do
    begin
      if (SameText(lstRecDirOperadores[i].recDirOperador.DIR_NOMFRM, strNomFrm))
        and (SameText(lstRecDirOperadores[i].recDirOperador.OPE_CODOPE, strCodOpe))
        and (lstRecDirOperadores[i].fGetOperacao() in [opInsert, opUpdate]) then
          objRecOperador := lstRecDirOperadores[i];
    end;

    if (Assigned(objRecOperador)) then
    begin
      lstRecDirOperadores.Remove(objRecOperador);
      Result := False;
    end;

    pVerificarAlteracoesPendentes;
  end;
end;

procedure TDireitoAcesso.pListarOperadoresSemPermissao(strNomFrm: String);
  var
    lstOperadores: TList<TCadOpe>;
    lstDirOpe    : TList<TDirOpe>;
    blnEncontrou : Boolean;
    i, j: Integer;
begin
  lstCadOperadores.Clear;

  lstDirOpe     := repDirOperadores.fRetDirOperadorByFrm(strNomFrm);
  lstOperadores := pListarOperadoresSistema;


  if (Assigned(lstDirOpe)) and (Assigned(lstOperadores)) then
    for i := 0 to lstOperadores.Count - 1 do
    begin
      blnEncontrou := False;
      for j := 0 to lstDirOpe.Count - 1 do
      begin
        if (lstOperadores[i].OPE_CODOPE = lstDirOpe[j].objCadOpe.OPE_CODOPE) then
          blnEncontrou := True;
      end;

      if (not blnEncontrou) then
        lstCadOperadores.Add(lstOperadores[i]);
    end;
end;

procedure TDireitoAcesso.pConcederPermissaoGrupo(strNomFrm: String; objCadGpo: TCadGpo);
begin
  if (fVerificarConcederPermissaoGrupo(strNomFrm, objCadGpo.GPO_CODGPO)) then
    lstRecDirGrupos.Add(TRecDirGrupo.Create(TDirGpo.Create(strNomFrm, objCadGpo.GPO_CODGPO), opInsert));

  pVerificarAlteracoesPendentes;
  lstCadGrupos.Remove(objCadGpo);
  lstCadGruposPermissao.Add(objCadGpo);
  lstCadGruposPermissao.Sort(FOrderGrupoPorDescricao);
end;

procedure TDireitoAcesso.pConcederPermissaoOperador(strNomFrm: String; objCadOpe: TCadOpe);
begin
  if (fVerificarConcederPermissaoOperador(strNomFrm, objCadOpe.OPE_CODOPE)) then
    lstRecDirOperadores.Add(TRecDirOperador.Create(TDirOpe.Create(strNomFrm, objCadOpe.OPE_CODOPE), opInsert));

  pVerificarAlteracoesPendentes;
  lstCadOperadores.Remove(objCadOpe);
  lstCadOperadoresPermissao.Add(objCadOpe);
  lstCadOperadoresPermissao.Sort(FOrderOperadorPorNome);
end;

procedure TDireitoAcesso.pConcederPermissaoTodosGrupos(strNomFrm: String);
  var
    i: Integer;
begin
  if (lstCadGrupos.Count > 0) then
  begin
    for i := 0 to lstCadGrupos.Count - 1 do
    begin
      if (fVerificarConcederPermissaoGrupo(strNomFrm, lstCadGrupos[i].GPO_CODGPO)) then
        lstRecDirGrupos.Add(TRecDirGrupo.Create(TDirGpo.Create(strNomFrm, lstCadGrupos[i].GPO_CODGPO), opInsert));

      lstCadGruposPermissao.Add(lstCadGrupos[i]);
    end;
    pVerificarAlteracoesPendentes;
    lstCadGrupos.Clear;
    lstCadGruposPermissao.Sort(FOrderGrupoPorDescricao);
  end;
end;

procedure TDireitoAcesso.pConcederPermissaoTodosOperadores(strNomFrm: String);
  var
    i: Integer;
begin
  if (lstCadOperadores.Count > 0) then
  begin
    for i := 0 to lstCadOperadores.Count - 1 do
    begin
      if (fVerificarConcederPermissaoOperador(strNomFrm, lstCadOperadores[i].OPE_CODOPE)) then
        lstRecDirOperadores.Add(TRecDirOperador.Create(TDirOpe.Create(strNomFrm, lstCadOperadores[i].OPE_CODOPE), opInsert));

      lstCadOperadoresPermissao.Add(lstCadOperadores[i]);
    end;
    pVerificarAlteracoesPendentes;
    lstCadOperadores.Clear;
    lstCadOperadoresPermissao.Sort(FOrderOperadorPorNome);
  end;
end;

procedure TDireitoAcesso.pDefinirDataSets;
begin
  dtsCadGrupos.DataSet              := qryCadGrupos;
  dtsCadOperadores.DataSet          := qryCadOperadores;
  dtsCadGruposPermissao.DataSet     := qryCadGruposPermissao;
  dtsCadOperadoresPermissao.DataSet := qryCadOperadoresPermissao;
end;

procedure TDireitoAcesso.pGravarAlteracoes;
  var
    i: Integer;
begin
  if (Self.FPossuiAlteracoes) then
  begin
    for i := 0 to lstRecDirOperadores.Count - 1 do
      case lstRecDirOperadores[i].fGetOperacao() of
        opInsert: repDirOperadores.pGravar(lstRecDirOperadores[i].recDirOperador);
        opUpdate: repDirOperadores.pAtualizar(lstRecDirOperadores[i].recDirOperador);
        opDelete: repDirOperadores.pExcluir(lstRecDirOperadores[i].recDirOperador);
      end;


    for i := 0 to lstRecDirGrupos.Count - 1 do
      case lstRecDirOperadores[i].fGetOperacao() of
        opInsert: repDirGrupos.pGravar(lstRecDirGrupos[i].recDirGrupo);
        opUpdate: repDirGrupos.pAtualizar(lstRecDirGrupos[i].recDirGrupo);
        opDelete: repDirGrupos.pExcluir(lstRecDirGrupos[i].recDirGrupo);
      end;

    lstRecDirOperadores.Clear;
    lstRecDirGrupos.Clear;

    pVerificarAlteracoesPendentes;
  end;
end;

procedure TDireitoAcesso.pListarGruposComPermissao(strNomFrm: String);
  var
    lstDirGpo: TList<TDirGpo>;
    i: Integer;
begin
  lstCadGruposPermissao.Clear;
  lstDirGpo := repDirGrupos.fRetDirGrupoByFrm(strNomFrm);

  if (Assigned(lstDirGpo)) then
    for i := 0 to lstDirGpo.Count - 1 do
      lstCadGruposPermissao.Add(lstDirGpo[i].objCadGpo);
end;

procedure TDireitoAcesso.pListarGruposSemPermissao(strNomFrm: String);
  var
    lstGrupos    : TList<TCadGpo>;
    lstDirGpo    : TList<TDirGpo>;
    blnEncontrou : Boolean;
    i, j: Integer;
begin
  lstCadGrupos.Clear;

  lstDirGpo := repDirGrupos.fRetDirGrupoByFrm(strNomFrm);
  lstGrupos := pListarGruposSistema;


  if (Assigned(lstDirGpo)) and (Assigned(lstGrupos)) then
    for i := 0 to lstGrupos.Count - 1 do
    begin
      blnEncontrou := False;
      for j := 0 to lstDirGpo.Count - 1 do
      begin
        if (lstGrupos[i].GPO_CODGPO = lstDirGpo[j].objCadGpo.GPO_CODGPO) then
          blnEncontrou := True;
      end;

      if (not blnEncontrou) then
        lstCadGrupos.Add(lstGrupos[i]);
    end;
end;

function TDireitoAcesso.pListarGruposSistema: TList<TCadGpo>;
begin
  Result := repCadGrupos.fRetTodos(FCodEmp);
end;

function TDireitoAcesso.pListarOperadoresSistema: TList<TCadOpe>;
begin
  Result := repCadOperadores.fRetTodos;
end;

procedure TDireitoAcesso.pRemoverPermissaoGrupo(strNomFrm: String; objCadGpo: TCadGpo);
begin
   if (fVerificarConcederPermissaoGrupo(strNomFrm, objCadGpo.GPO_CODGPO)) then
    lstRecDirGrupos.Add(TRecDirGrupo.Create(repDirGrupos.fReTDirGrupoByCodFrm(objCadGpo.GPO_CODGPO, strNomFrm), opDelete));

  pVerificarAlteracoesPendentes;
  lstCadGruposPermissao.Remove(objCadGpo);
  lstCadGrupos.Add(objCadGpo);
  lstCadGrupos.Sort(FOrderGrupoPorDescricao);
end;

procedure TDireitoAcesso.pRemoverPermissaoOperador(strNomFrm: String; objCadOpe: TCadOpe);
begin
  if (fVerificarRemoverPermissaoOperador(strNomFrm, objCadOpe.OPE_CODOPE)) then
    lstRecDirOperadores.Add(TRecDirOperador.Create(repDirOperadores.fRetDirOperadorByCodFrm(objCadOpe.OPE_CODOPE, strNomFrm), opDelete));

  pVerificarAlteracoesPendentes;
  lstCadOperadoresPermissao.Remove(objCadOpe);
  lstCadOperadores.Add(objCadOpe);
  lstCadOperadores.Sort(FOrderOperadorPorNome);
end;

procedure TDireitoAcesso.pRemoverPermissaoTodosGrupos(strNomFrm: String);
  var
    i: Integer;
begin
  if (lstCadGruposPermissao.Count > 0) then
  begin
    for i := 0 to lstCadGruposPermissao.Count - 1 do
    begin
      if (fVerificarConcederPermissaoGrupo(strNomFrm, lstCadGruposPermissao[i].GPO_CODGPO)) then
        lstRecDirGrupos.Add(TRecDirGrupo.Create(repDirGrupos.fReTDirGrupoByCodFrm(lstCadGruposPermissao[i].GPO_CODGPO, strNomFrm), opDelete));

      lstCadGrupos.Add(lstCadGruposPermissao[i]);
    end;
    pVerificarAlteracoesPendentes;
    lstCadGruposPermissao.Clear;
    lstCadGrupos.Sort(FOrderGrupoPorDescricao);
    Self.FPossuiAlteracoes := True;
  end;
end;

procedure TDireitoAcesso.pRemoverPermissaoTodosOperadores(strNomFrm: String);
  var
    i: Integer;
begin
  if (lstCadOperadoresPermissao.Count > 0) then
  begin
    for i := 0 to lstCadOperadoresPermissao.Count - 1 do
    begin
      if (fVerificarRemoverPermissaoOperador(strNomFrm, lstCadOperadoresPermissao[i].OPE_CODOPE)) then
        lstRecDirOperadores.Add(TRecDirOperador.Create(repDirOperadores.fRetDirOperadorByCodFrm(lstCadOperadoresPermissao[i].OPE_CODOPE, strNomFrm), opDelete));

      lstCadOperadores.Add(lstCadOperadoresPermissao[i]);
    end;
    pVerificarAlteracoesPendentes;
    lstCadOperadoresPermissao.Clear;
    lstCadOperadores.Sort(FOrderOperadorPorNome);
  end;
end;

procedure TDireitoAcesso.pVerificarAlteracoesPendentes;
begin
  Self.FPossuiAlteracoes := (lstRecDirOperadores.Count > 0) or (lstRecDirGrupos.Count > 0);
end;

procedure TDireitoAcesso.pOrderGrupoPorDescricao;
begin
  FOrderGrupoPorDescricao := TComparer<TCadGpo>.Construct(TComparison<TCadGpo>(
    function(const R, L: TCadGpo): Integer
    Begin
      Result := CompareText(R.GPO_DESCRI, L.GPO_DESCRI);
    End
  ));
end;

procedure TDireitoAcesso.pOrderOperadorPorNome;
begin
  FOrderOperadorPorNome := TComparer<TCadOpe>.Construct(TComparison<TCadOpe>(
    function(const R, L: TCadOpe): Integer
    Begin
      Result := CompareText(R.OPE_NOMOPE, L.OPE_NOMOPE);
    End
  ));
end;

end.
