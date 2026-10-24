unit untManutencaoEquipamentoInterno;

interface

Uses
  StrUtils, AnsiStrings, Uni, SysUtils, untZClient, Variants, Data.DB;

Type
  TManutencaoEquipamentoInternoStatus = (tsAberto, tsAprovada, tsNegada, tsCotacao, tsPedCompra, tsConcluida, tsFinalizada, tsTodas);

Type
  TManutencaoEquipamentoInternoStatusFuncoes = class

  public
    class function fTSatusParaString(oStatus: TManutencaoEquipamentoInternoStatus): String;
    class function fStringPraTStatus(strStatus: string): TManutencaoEquipamentoInternoStatus;
  end;

Type
  TManutencaoEquipamentoInternoAcao = (taIncluir, taAlterar, taExcluir, taAprovar, taRejeitar, taFinalizar, taVincular, taDesvincular, taAtualizarStatus, taConcluiuCompra);

Type
  TManutencaoEquipamentoInternoAcaoFuncoes = class

  public
    class function fTAcaoParaString(oAcao: TManutencaoEquipamentoInternoAcao): String;
  end;

Type
  TManutencaoEquipamentoInterno = class
  private
    FPrioridade: string;
    FAutoincrem: string;
    FDataEstimadaConclusao: string;
    FMotivoPausa: string;
    FCodigo: string;
    FOperadorCadastro: string;
    FResponsavelTecnico: string;
    FStatus: string;
    FDepartamento: string;
    FDataFinalParalizacao: string;
    FDataCadastro: string;
    FDataInicialParalizacao: string;
    FDescricaoManutencao: string;
    FTipoVinculo : Integer;
    FNumeroDocumento : String;
    FEspDoc : String;
    FSerie : String;
    FCodFor : String;
    FCadCta : String;
    procedure SetAutoincrem(const Value: string);
    procedure SetCodigo(const Value: string);
    procedure SetDataCadastro(const Value: string);
    procedure SetDataEstimadaConclusao(const Value: string);
    procedure SetDataFinalParalizacao(const Value: string);
    procedure SetDataInicialParalizacao(const Value: string);
    procedure SetDepartamento(const Value: string);
    procedure SetDescricaoManutencao(const Value: string);
    procedure SetMotivoPausa(const Value: string);
    procedure SetOperadorCadastro(const Value: string);
    procedure SetPrioridade(const Value: string);
    procedure SetResponsavelTecnico(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetTipoVinculo(const Value: integer);
    procedure SetNumeroDocumento(const Value: string);
    procedure SetEspDoc(const Value: string);
    procedure SetSerie(const Value: string);
    procedure SetCodFor(const Value: string);
    procedure SetCadCta(const Value: string);

  public
    property Autoincrem: string read FAutoincrem write SetAutoincrem;
    property Codigo: string read FCodigo write SetCodigo;
    property DataCadastro: string read FDataCadastro write SetDataCadastro;
    property OperadorCadastro: string read FOperadorCadastro write SetOperadorCadastro;
    property Departamento: string read FDepartamento write SetDepartamento;
    property Prioridade: string read FPrioridade write SetPrioridade;
    property Status: string read FStatus write SetStatus;
    property DataEstimadaConclusao: string read FDataEstimadaConclusao write SetDataEstimadaConclusao;
    property DescricaoManutencao: string read FDescricaoManutencao write SetDescricaoManutencao;
    property ResponsavelTecnico: string read FResponsavelTecnico write SetResponsavelTecnico;
    property DataInicialParalizacao: string read FDataInicialParalizacao write SetDataInicialParalizacao;
    property DataFinalParalizacao: string read FDataFinalParalizacao write SetDataFinalParalizacao;
    property MotivoPausa: string read FMotivoPausa write SetMotivoPausa;
    property TipoVinculo: integer read FTipoVinculo write SetTipoVinculo;
    property NumeroDocumento: string read FNumeroDocumento write SetNumeroDocumento;
    property EspDoc: string read FEspDoc write SetEspDoc;
    property Serie: string read FSerie write SetSerie;
    property CodFor: string read FCodFor write SetCodFor;
    property CadCta: string read FCadCta write SetCadCta;

    function fIncluirSolicicao(oManutencao: TManutencaoEquipamentoInterno): Boolean;
    function fAlterarSolicicao(oManutencao: TManutencaoEquipamentoInterno): Boolean;
    class procedure pAjustaStatusAutomatica(strCodSolicitacao: string);
    class function fCarregarSolicitacao(strCodSolicitacao: string): TManutencaoEquipamentoInterno;
    class procedure pCarregaListaSolicitacoes(oStatus: TManutencaoEquipamentoInternoStatus; cdsLista: TZClient);
    class function fDeletarSolicitacao(strCodSolicitacao: string): Boolean;
    class function fFinalizarSolicitacao(oManutencao: TManutencaoEquipamentoInterno): Boolean;
    class function fAtualizarStatus(strAutoincrem: string; oStatus: TManutencaoEquipamentoInternoStatus): Boolean;
    class function fVinculaSolicitacao(strCodSol, strCodDoc, strEspDoc: string):Boolean;
    class function fRemoverVinculoSolicitacao(strCodDoc, strEspDoc: string): Boolean;
    class function fRetornaSolicitacaoVinculada(strCodDoc, strEspDoc: string): string;
    class procedure pGravaHistoricoAcao(strCodSolicitacao: string; oAcao: TManutencaoEquipamentoInternoAcao);
  end;

Type
  TManutencaoEquipamentoInternoItens = class
  private
    FCodigoManutencao: string;
    FAutoincrem: string;
    FCodigoEquipamento: string;
    procedure SetAutoincrem(const Value: string);
    procedure SetCodigoEquipamento(const Value: string);
    procedure SetCodigoManutencao(const Value: string);

  public
    property Autoincrem: string read FAutoincrem write SetAutoincrem;
    property CodigoManutencao: string read FCodigoManutencao write SetCodigoManutencao;
    property CodigoEquipamento: string read FCodigoEquipamento write SetCodigoEquipamento;

    function fIncluirSolicicaoItens(oManutencaoItens: TManutencaoEquipamentoInternoItens): Boolean;
    class function fDeletarItens(strCodSolicitacao: string; blnGravarDel: Boolean = True): Boolean;
    class procedure pCarregarItensSolicitacao(strCodSolicitacao: string; cdsLista: TZClient);
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untFuncoesGenerica;

{ TStatusFuncoes }

class function TManutencaoEquipamentoInternoStatusFuncoes.fStringPraTStatus(strStatus: string): TManutencaoEquipamentoInternoStatus;
begin
  case AnsiIndexText(strStatus, ['Em Aberto', 'Aprovada', 'Negada', 'Em Cotação', 'Em Ped. Compra', 'Compra Concluida', 'Finalizada']) of
    0: Result := tsAberto;
    1: Result := tsAprovada;
    2: Result := tsNegada;
    3: Result := tsCotacao;
    4: Result := tsPedCompra;
    5: Result := tsConcluida;
    6: Result := tsFinalizada;
  else
    Result := tsAberto;
  end;
end;

class function TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(oStatus: TManutencaoEquipamentoInternoStatus): String;
begin
  case oStatus of
    tsAberto: Result := 'Em Aberto';
    tsAprovada: Result := 'Aprovada';
    tsNegada: Result := 'Negada';
    tsCotacao: Result := 'Em Cotação';
    tsPedCompra: Result := 'Em Ped. Compra';
    tsConcluida: Result := 'Compra Concluida';
    tsFinalizada: Result := 'Finalizada';
  end;
end;

{ TManutencaoEquipamentoInterno }

function TManutencaoEquipamentoInterno.fAlterarSolicicao(
  oManutencao: TManutencaoEquipamentoInterno): Boolean;
Var
  qryAlterar: TUniQuery;
begin
  qryAlterar := fCriaQuery(nil);
  Try
    qryAlterar.Close;
    qryAlterar.SQL.Clear;
    qryAlterar.SQL.Add('UPDATE MNEQIG SET MEI_DEPART = :DEPART, MEI_PRIORI = :PRIORI, ');
    qryAlterar.SQL.Add('MEI_STATUS = :STATUS, MEI_DTAEST = :DTAEST, MEI_DESMAN = :DESMAN, ');
    qryAlterar.SQL.Add('MEI_RESTEC = :RESTEC, MEI_DTAINI = :DTAINI, MEI_DTAFIM = :DTAFIM, ');
    qryAlterar.SQL.Add('MEI_MOTIPA = :MOTIPA, MEI_TIPVIN = :TIPVIN, MEI_NUMDOC = :NUMDOC ');
    qryAlterar.SQL.Add(' WHERE MEI_CODIGO = :CODIGO');

    qryAlterar.ParamByName('CODIGO').AsString := oManutencao.Codigo;
    qryAlterar.ParamByName('DEPART').AsString := oManutencao.Departamento;
    qryAlterar.ParamByName('PRIORI').AsString := oManutencao.Prioridade;
    qryAlterar.ParamByName('STATUS').AsString := oManutencao.Status;

    if fEmptyDate(oManutencao.DataEstimadaConclusao) then
      qryAlterar.ParamByName('DTAEST').Value := Null
    else
      qryAlterar.ParamByName('DTAEST').AsDate := StrToDate(oManutencao.DataEstimadaConclusao);

    qryAlterar.ParamByName('DESMAN').AsString := oManutencao.DescricaoManutencao;
    qryAlterar.ParamByName('RESTEC').AsString := oManutencao.ResponsavelTecnico;

    if fEmptyDate(oManutencao.DataInicialParalizacao) then
      qryAlterar.ParamByName('DTAINI').Value := Null
    else
      qryAlterar.ParamByName('DTAINI').AsDate := StrToDate(oManutencao.DataInicialParalizacao);

    if fEmptyDate(oManutencao.DataFinalParalizacao) then
      qryAlterar.ParamByName('DTAFIM').Value := Null
    else
      qryAlterar.ParamByName('DTAFIM').AsDate := StrToDate(oManutencao.DataFinalParalizacao);

    qryAlterar.ParamByName('MOTIPA').AsString := oManutencao.MotivoPausa;

    qryAlterar.ParamByName('TIPVIN').AsInteger := oManutencao.TipoVinculo;
    qryAlterar.ParamByName('NUMDOC').AsString := oManutencao.NumeroDocumento;
    qryAlterar.ExecSQL;

    Result := qryAlterar.RowsAffected > 0;

    if Result then
      pGravaHistoricoAcao(oManutencao.Codigo, taAlterar);
  Finally
    FreeAndNil(qryAlterar);
  End;
end;

class function TManutencaoEquipamentoInterno.fAtualizarStatus(
  strAutoincrem: string; oStatus: TManutencaoEquipamentoInternoStatus): Boolean;
Var
  qryAtualizar: TUniQuery;

  function fRetCodigo(const AIncrem: String): string;
  begin
    Result := fCampoTabela('MEI_CODIGO', 'MNEQIG', ['AUTOINCREM'], [AIncrem]);
  end;
begin
  qryAtualizar := fCriaQuery(nil);
  Try
    qryAtualizar.Close;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE MNEQIG SET MEI_STATUS = :STATUS');
    qryAtualizar.SQL.Add('WHERE AUTOINCREM = :INCREM');

    qryAtualizar.ParamByName('INCREM').AsString := strAutoincrem;
    qryAtualizar.ParamByName('STATUS').AsString := TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(oStatus);

    qryAtualizar.ExecSQL;

    Result := qryAtualizar.RowsAffected > 0;

    if Result then
    begin
      case oStatus of
        tsAprovada: pGravaHistoricoAcao(fRetCodigo(strAutoincrem), taAprovar);
        tsNegada: pGravaHistoricoAcao(fRetCodigo(strAutoincrem), taRejeitar);
        tsConcluida: pGravaHistoricoAcao(fRetCodigo(strAutoincrem), taConcluiuCompra);
      else
        pGravaHistoricoAcao(fRetCodigo(strAutoincrem), taAtualizarStatus);
      end;
    end;
  Finally
    FreeAndNil(qryAtualizar);
  End;
end;

class function TManutencaoEquipamentoInterno.fCarregarSolicitacao(
  strCodSolicitacao: string): TManutencaoEquipamentoInterno;
Var
  qryBusca: TUniQuery;
  oManutencao: TManutencaoEquipamentoInterno;
begin
  qryBusca := fCriaQuery(nil);

  oManutencao := TManutencaoEquipamentoInterno.Create;
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT AUTOINCREM, MEI_CODIGO, MEI_DTACAD, MEI_OPECAD,');
    qryBusca.SQL.Add('MEI_DEPART, MEI_PRIORI, MEI_STATUS, MEI_DTAEST, MEI_DESMAN,');
    qryBusca.SQL.Add('MEI_RESTEC, MEI_DTAINI, MEI_DTAFIM, MEI_MOTIPA, MEI_CODEMP, ');
    qryBusca.SQL.Add('MEI_TIPVIN, MEI_NUMDOC, MEI_ESPDOC, MEI_SERIE_, MEI_CODFOR, ');
    qryBusca.SQL.Add('MEI_CADCTA ');
    qryBusca.SQL.Add('FROM MNEQIG WHERE MEI_CODIGO = :CODIGO');
    qryBusca.ParamByName('CODIGO').AsString := strCodSolicitacao;
    qryBusca.Open;

    oManutencao.Autoincrem := qryBusca.FieldByName('AUTOINCREM').AsString;
    oManutencao.Codigo := qryBusca.FieldByName('MEI_CODIGO').AsString;
    oManutencao.DataCadastro := qryBusca.FieldByName('MEI_DTACAD').AsString;
    oManutencao.OperadorCadastro := qryBusca.FieldByName('MEI_OPECAD').AsString;
    oManutencao.Departamento := qryBusca.FieldByName('MEI_DEPART').AsString;
    oManutencao.Prioridade := qryBusca.FieldByName('MEI_PRIORI').AsString;
    oManutencao.Status := qryBusca.FieldByName('MEI_STATUS').AsString;
    oManutencao.DataEstimadaConclusao := qryBusca.FieldByName('MEI_DTAEST').AsString;
    oManutencao.DescricaoManutencao := qryBusca.FieldByName('MEI_DESMAN').AsString;
    oManutencao.ResponsavelTecnico := qryBusca.FieldByName('MEI_RESTEC').AsString;
    oManutencao.DataInicialParalizacao := qryBusca.FieldByName('MEI_DTAINI').AsString;
    oManutencao.DataFinalParalizacao := qryBusca.FieldByName('MEI_DTAFIM').AsString;
    oManutencao.MotivoPausa := qryBusca.FieldByName('MEI_MOTIPA').AsString;
    oManutencao.TipoVinculo := qryBusca.FieldByName('MEI_TIPVIN').AsInteger;
    oManutencao.NumeroDocumento := qryBusca.FieldByName('MEI_NUMDOC').AsString;
    oManutencao.EspDoc := qryBusca.FieldByName('MEI_ESPDOC').AsString;
    oManutencao.Serie := qryBusca.FieldByName('MEI_SERIE_').AsString;
    oManutencao.CodFor := qryBusca.FieldByName('MEI_CODFOR').AsString;
    oManutencao.CadCta := qryBusca.FieldByName('MEI_CADCTA').AsString;

    Result := oManutencao;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

class function TManutencaoEquipamentoInterno.fDeletarSolicitacao(
  strCodSolicitacao: string): Boolean;
Var
  qryDeletar, qryBuscar: TUniQuery;
begin
  qryDeletar := fCriaQuery(nil);
  qryBuscar := fCriaQuery(nil);
  Result := False;
  Try
    qryBuscar.Close;
    qryBuscar.SQL.Clear;
    qryBuscar.SQL.Add('SELECT * FROM MNEQIG WHERE MEI_CODIGO = :CODIGO');
    qryBuscar.ParamByName('CODIGO').AsString := strCodSolicitacao;
    qryBuscar.Open;

    fVerificaIntegridade('fDeletarSolicitacao', 'MNEQIG', qryBuscar);

    qryDeletar.Close;
    qryDeletar.SQL.Clear;
    qryDeletar.SQL.Add('DELETE FROM MNEQIG WHERE MEI_CODIGO = :CODIGO');

    qryDeletar.ParamByName('CODIGO').AsString := strCodSolicitacao;
    qryDeletar.ExecSQL;

    if qryDeletar.RowsAffected > 0 then
    begin
      Result := TManutencaoEquipamentoInternoItens.fDeletarItens(strCodSolicitacao);
    end;

    if Result then
      pGravaHistoricoAcao(strCodSolicitacao, taExcluir);
  Finally
    FreeAndNil(qryDeletar);
    FreeAndNil(qryBuscar);
  End;
end;

class function TManutencaoEquipamentoInterno.fFinalizarSolicitacao(
  oManutencao: TManutencaoEquipamentoInterno): Boolean;
Var
  qryAtualizar: TUniQuery;
begin
  qryAtualizar := fCriaQuery(nil);
  Try
    qryAtualizar.Close;
    qryAtualizar.SQL.Clear;
    qryAtualizar.SQL.Add('UPDATE MNEQIG SET MEI_STATUS = :STATUS, MEI_RESTEC = :RESTEC,');
    qryAtualizar.SQL.Add('MEI_DTAINI = :DTAINI, MEI_DTAFIM = :DTAFIM, MEI_MOTIPA = :MOTIPA, ');
    qryAtualizar.SQL.Add('MEI_TIPVIN = :TIPVIN, MEI_NUMDOC = :NUMDOC, MEI_ESPDOC = :ESPDOC, ');
    qryAtualizar.SQL.Add('MEI_SERIE_ = :SERIE_, MEI_CODFOR = :CODFOR, MEI_CADCTA = :CADCTA ');
    qryAtualizar.SQL.Add('WHERE MEI_CODIGO = :CODIGO');

    qryAtualizar.ParamByName('CODIGO').AsString := oManutencao.Codigo;
    qryAtualizar.ParamByName('STATUS').AsString := oManutencao.Status;
    qryAtualizar.ParamByName('RESTEC').AsString := oManutencao.ResponsavelTecnico;

    if fEmptyDate(oManutencao.DataInicialParalizacao) then
      qryAtualizar.ParamByName('DTAINI').Value := Null
    else
      qryAtualizar.ParamByName('DTAINI').AsDate := StrToDate(oManutencao.DataInicialParalizacao);

    if fEmptyDate(oManutencao.DataFinalParalizacao) then
      qryAtualizar.ParamByName('DTAFIM').Value := Null
    else
      qryAtualizar.ParamByName('DTAFIM').AsDate := StrToDate(oManutencao.DataFinalParalizacao);

    qryAtualizar.ParamByName('MOTIPA').AsString := oManutencao.MotivoPausa;
    qryAtualizar.ParamByName('TIPVIN').AsInteger := oManutencao.TipoVinculo;
    qryAtualizar.ParamByName('NUMDOC').AsString := oManutencao.NumeroDocumento;
    qryAtualizar.ParamByName('ESPDOC').AsString := oManutencao.EspDoc;
    qryAtualizar.ParamByName('SERIE_').AsString := oManutencao.Serie;
    qryAtualizar.ParamByName('CODFOR').AsString := oManutencao.CodFor;
    qryAtualizar.ParamByName('CADCTA').AsString := oManutencao.CadCta;

    qryAtualizar.ExecSQL;

    Result := qryAtualizar.RowsAffected > 0;

    if Result then
      pGravaHistoricoAcao(oManutencao.Codigo, taFinalizar);
  Finally
    FreeAndNil(qryAtualizar);
  End;
end;

function TManutencaoEquipamentoInterno.fIncluirSolicicao(
  oManutencao: TManutencaoEquipamentoInterno): Boolean;
Var
  qryInclui: TUniQuery;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('MNEQIG', 'MEI_CODIGO');
  end;
begin
  oManutencao.Autoincrem := fRetAutoIncrem('MNEQIG', VS_strCodEmp);
  oManutencao.Codigo := fProximoCodigo;

  qryInclui := fCriaQuery(nil);
  Try
    qryInclui.Close;
    qryInclui.SQL.Clear;
    qryInclui.SQL.Add('INSERT INTO MNEQIG (AUTOINCREM, MEI_CODIGO, MEI_DTACAD,');
    qryInclui.SQL.Add('MEI_OPECAD, MEI_DEPART, MEI_PRIORI, MEI_STATUS, MEI_DTAEST,');
    qryInclui.SQL.Add('MEI_DESMAN, MEI_RESTEC, MEI_DTAINI, MEI_DTAFIM, MEI_MOTIPA, MEI_CODEMP)');
    qryInclui.SQL.Add('VALUES (:INCREM, :CODIGO, :DTACAD, :OPECAD,');
    qryInclui.SQL.Add(':DEPART, :PRIORI, :STATUS, :DTAEST, :DESMAN,');
    qryInclui.SQL.Add(':RESTEC, :DTAINI, :DTAFIM, :MOTIPA, :CODEMP)');

    qryInclui.ParamByName('INCREM').AsString := oManutencao.Autoincrem;
    qryInclui.ParamByName('CODIGO').AsString := oManutencao.Codigo;

    if fEmptyDate(oManutencao.DataCadastro) then
      qryInclui.ParamByName('DTACAD').Value := Null
    else
      qryInclui.ParamByName('DTACAD').AsDate := StrToDate(oManutencao.DataCadastro);

    qryInclui.ParamByName('OPECAD').AsString := oManutencao.OperadorCadastro;
    qryInclui.ParamByName('DEPART').AsString := oManutencao.Departamento;
    qryInclui.ParamByName('PRIORI').AsString := oManutencao.Prioridade;
    qryInclui.ParamByName('STATUS').AsString := oManutencao.Status;

    if fEmptyDate(oManutencao.DataEstimadaConclusao) then
      qryInclui.ParamByName('DTAEST').Value := Null
    else
      qryInclui.ParamByName('DTAEST').AsDate := StrToDate(oManutencao.DataEstimadaConclusao);

    qryInclui.ParamByName('DESMAN').AsString := oManutencao.DescricaoManutencao;
    qryInclui.ParamByName('RESTEC').AsString := oManutencao.ResponsavelTecnico;

    if fEmptyDate(oManutencao.DataInicialParalizacao) then
      qryInclui.ParamByName('DTAINI').Value := Null
    else
      qryInclui.ParamByName('DTAINI').AsDate := StrToDate(oManutencao.DataInicialParalizacao);

    if fEmptyDate( oManutencao.DataFinalParalizacao) then
      qryInclui.ParamByName('DTAFIM').Value := Null
    else
      qryInclui.ParamByName('DTAFIM').AsDate := StrToDate(oManutencao.DataFinalParalizacao);

    qryInclui.ParamByName('MOTIPA').AsString := oManutencao.MotivoPausa;
    qryInclui.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryInclui.ExecSQL;

    Result := qryInclui.RowsAffected > 0;

    if Result then
      pGravaHistoricoAcao(oManutencao.Codigo, taIncluir);
  Finally
    FreeAndNil(qryInclui);
  End;
end;

class function TManutencaoEquipamentoInterno.fRemoverVinculoSolicitacao(
  strCodDoc, strEspDoc: string): Boolean;
Var
  qryDeletar, qryBuscar: TUniQuery;
begin
  qryDeletar := fCriaQuery(nil);
  qryBuscar := fCriaQuery(nil);

  Try
    qryBuscar.Close;
    qryBuscar.SQL.Clear;
    qryBuscar.SQL.Add('SELECT * FROM MNEQIR WHERE MEI_CODDOC = :CODIGO AND MEI_ESPDOC = :ESPDOC');
    qryBuscar.ParamByName('CODIGO').AsString := strCodDoc;
    qryBuscar.ParamByName('ESPDOC').AsString := strEspDoc;
    qryBuscar.Open;

    if qryBuscar.IsEmpty then
    begin
      Result := True;
      Exit;
    end;

    fVerificaIntegridade('fRemoverVinculoSolicitacao', 'MNEQIR', qryBuscar);

    qryDeletar.Close;
    qryDeletar.SQL.Clear;
    qryDeletar.SQL.Add('DELETE FROM MNEQIR WHERE MEI_CODDOC = :CODIGO AND MEI_ESPDOC = :ESPDOC');
    qryDeletar.ParamByName('CODIGO').AsString := strCodDoc;
    qryDeletar.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDeletar.ExecSQL;

    Result := qryDeletar.RowsAffected > 0;

    if Result then
      pGravaHistoricoAcao(qryBuscar.FieldByName('MEI_CODSOL').AsString, taDesvincular);

    pAjustaStatusAutomatica(qryBuscar.FieldByName('MEI_CODSOL').AsString);
  Finally
    FreeAndNil(qryDeletar);
    FreeAndNil(qryBuscar);
  End;
end;

class function TManutencaoEquipamentoInterno.fRetornaSolicitacaoVinculada(
  strCodDoc, strEspDoc: string): string;
Var
  qryBuscar: TUniQuery;
begin
  qryBuscar := fCriaQuery(nil);
  Result := EmptyStr;

  Try
    qryBuscar.Close;
    qryBuscar.SQL.Clear;
    qryBuscar.SQL.Add('SELECT MEI_CODSOL FROM MNEQIR WHERE MEI_CODDOC = :CODIGO AND MEI_ESPDOC = :ESPDOC');
    qryBuscar.ParamByName('CODIGO').AsString := strCodDoc;
    qryBuscar.ParamByName('ESPDOC').AsString := strEspDoc;
    qryBuscar.Open;

    if not qryBuscar.IsEmpty then
      Result := qryBuscar.FieldByName('MEI_CODSOL').AsString;
  Finally
    FreeAndNil(qryBuscar);
  End;
end;

class function TManutencaoEquipamentoInterno.fVinculaSolicitacao(strCodSol,
  strCodDoc, strEspDoc: string): Boolean;
Var
  qryInclui: TUniQuery;
begin
  qryInclui := fCriaQuery(nil);
  Try
    qryInclui.Close;
    qryInclui.SQL.Clear;

    if fEmptyStr(strCodSol) then
    begin
      Result := fRemoverVinculoSolicitacao(strCodDoc, strEspDoc);
      Exit;
    end;

    if fRetornaSolicitacaoVinculada(strCodDoc, strEspDoc) = strCodSol then
    begin
      Result := True;
      Exit;
    end
    else
    begin
      Result := fRemoverVinculoSolicitacao(strCodDoc, strEspDoc);
    end;

    qryInclui.SQL.Add('INSERT INTO MNEQIR (MEI_CODSOL, MEI_CODDOC, MEI_ESPDOC,');
    qryInclui.SQL.Add('MEI_DTAREL, MEI_HORREL, MEI_OPEREL) VALUES');
    qryInclui.SQL.Add('(:CODSOL, :CODDOC, :ESPDOC, :DTAREL, :HORREL, :OPEREL)');
    qryInclui.ParamByName('CODSOL').AsString := strCodSol;
    qryInclui.ParamByName('CODDOC').AsString := strCodDoc;
    qryInclui.ParamByName('ESPDOC').AsString := strEspDoc;
    qryInclui.ParamByName('DTAREL').AsDate := VS_Date;
    qryInclui.ParamByName('HORREL').AsTime := fTime();
    qryInclui.ParamByName('OPEREL').AsString := strLoginUsuarioLogado;
    qryInclui.ExecSQL;

    Result := qryInclui.RowsAffected > 0;

    if Result then
      pGravaHistoricoAcao(strCodSol, taVincular);

    pAjustaStatusAutomatica(strCodSol);
  Finally
    FreeAndNil(qryInclui);
  End;
end;

class procedure TManutencaoEquipamentoInterno.pAjustaStatusAutomatica(
  strCodSolicitacao: string);
Var
  qryBuscar: TUniQuery;
  blnCotacao, blnPedidoCompra, blnCompraConcluida: Boolean;

  function fPedidoBaixado(const ANumDoc, AEspDoc, ACodEmp: String): Boolean;
  begin
    Result := fCampoTabela('PCG_BAIXAD', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP' ], [ANumDoc, AEspDoc, ACodEmp]) = '1';
  end;

  function fRetAutoIncrem(const ANumSol, ACodEmp: String): string;
  begin
    Result := fCampoTabela('AUTOINCREM', 'MNEQIG', ['MEI_CODIGO', 'MEI_CODEMP'], [ANumSol, ACodEmp]);
  end;
begin
  blnCotacao := False;
  blnPedidoCompra := False;
  blnCompraConcluida := False;

  qryBuscar := fCriaQuery(nil);
  Try
    qryBuscar.Close;
    qryBuscar.SQL.Clear;
    qryBuscar.SQL.Add('SELECT MNEQIG.AUTOINCREM, MNEQIR.MEI_CODSOL, MNEQIR.MEI_CODDOC, MNEQIR.MEI_ESPDOC,');
    qryBuscar.SQL.Add(' MNEQIG.MEI_CODEMP FROM MNEQIR');
    qryBuscar.SQL.Add('INNER JOIN MNEQIG ON MNEQIG.MEI_CODIGO = MNEQIR.MEI_CODSOL');
    qryBuscar.SQL.Add('WHERE MNEQIR.MEI_CODSOL = :CODSOL');
    qryBuscar.ParamByName('CODSOL').AsString := strCodSolicitacao;
    qryBuscar.Open;

    if qryBuscar.IsEmpty then
    begin
      TManutencaoEquipamentoInterno.fAtualizarStatus(fRetAutoIncrem(strCodSolicitacao, VS_strCodEmp), tsAprovada);
      Exit;
    end;

    qryBuscar.First;
    while not qryBuscar.Eof do
    begin
      if qryBuscar.FieldByName('MEI_ESPDOC').AsString = 'PD' then
      begin
        blnPedidoCompra := True;

        If fPedidoBaixado(qryBuscar.FieldByName('MEI_CODDOC').AsString, qryBuscar.FieldByName('MEI_ESPDOC').AsString, qryBuscar.FieldByName('MEI_CODEMP').AsString) Then
        begin
          blnCompraConcluida := True;
        end
        else
        begin
          blnCompraConcluida := False;
          Break;
        end;
      end;

      if qryBuscar.FieldByName('MEI_ESPDOC').AsString = 'CT' then
      begin
        blnCotacao:= True;
      end;

      qryBuscar.Next;
    end;

    if blnCompraConcluida then
    begin
      TManutencaoEquipamentoInterno.fAtualizarStatus(qryBuscar.FieldByName('AUTOINCREM').AsString, tsConcluida);
    end
    else if blnPedidoCompra then
    begin
      TManutencaoEquipamentoInterno.fAtualizarStatus(qryBuscar.FieldByName('AUTOINCREM').AsString, tsPedCompra);
    end
    else
    begin if blnCotacao then
      TManutencaoEquipamentoInterno.fAtualizarStatus(qryBuscar.FieldByName('AUTOINCREM').AsString, tsCotacao);
    end;
  Finally
    FreeAndNil(qryBuscar);
  End;
end;

class procedure TManutencaoEquipamentoInterno.pCarregaListaSolicitacoes(
  oStatus: TManutencaoEquipamentoInternoStatus; cdsLista: TZClient);
Var
  qryBusca: TUniQuery;

begin
  qryBusca := fCriaQuery(nil);

  cdsLista.EmptyDataSet;
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT AUTOINCREM, MEI_CODIGO, MEI_DTACAD, MEI_DEPART, ');
    qryBusca.SQL.Add('MEI_OPECAD, MEI_PRIORI, MEI_STATUS, MEI_DESMAN, ');
    qryBusca.SQL.Add('MEI_TIPVIN, MEI_NUMDOC FROM MNEQIG ');
    qryBusca.SQL.Add('WHERE MEI_CODEMP = :CODEMP');

    if oStatus <> tsTodas then
    begin
      qryBusca.SQL.Add('AND MEI_STATUS = :STATUS');
      qryBusca.ParamByName('STATUS').AsString := TManutencaoEquipamentoInternoStatusFuncoes.fTSatusParaString(oStatus);
    end;

    qryBusca.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBusca.Open;

    if not qryBusca.IsEmpty then
    begin
      qryBusca.First;

      while not qryBusca.Eof do
      begin
        cdsLista.Append;

        if cdsLista.FindField('AUTOINCREM') <> nil then
          cdsLista.FieldByName('AUTOINCREM').AsString := qryBusca.FieldByName('AUTOINCREM').AsString;

        if cdsLista.FindField('MEI_CODIGO') <> nil then
          cdsLista.FieldByName('MEI_CODIGO').AsString := qryBusca.FieldByName('MEI_CODIGO').AsString;

        if cdsLista.FindField('MEI_DTACAD') <> nil then
          cdsLista.FieldByName('MEI_DTACAD').AsString := qryBusca.FieldByName('MEI_DTACAD').AsString;

        if cdsLista.FindField('MEI_OPECAD') <> nil then
          cdsLista.FieldByName('MEI_OPECAD').AsString := qryBusca.FieldByName('MEI_OPECAD').AsString + ' - ' + fRetNomVendedor(qryBusca.FieldByName('MEI_OPECAD').AsString);

        if cdsLista.FindField('MEI_DEPART') <> nil then
          cdsLista.FieldByName('MEI_DEPART').AsString := qryBusca.FieldByName('MEI_DEPART').AsString + ' - ' + fRetDescDepartamento(qryBusca.FieldByName('MEI_DEPART').AsString);

        if cdsLista.FindField('MEI_PRIORI') <> nil then
          cdsLista.FieldByName('MEI_PRIORI').AsString := qryBusca.FieldByName('MEI_PRIORI').AsString;

        if cdsLista.FindField('MEI_STATUS') <> nil then
          cdsLista.FieldByName('MEI_STATUS').AsString := qryBusca.FieldByName('MEI_STATUS').AsString;

        if cdsLista.FindField('MEI_DESMAN') <> nil then
          cdsLista.FieldByName('MEI_DESMAN').AsString := qryBusca.FieldByName('MEI_DESMAN').AsString;

        if cdsLista.FindField('MEI_TIPVIN') <> nil then
          cdsLista.FieldByName('MEI_TIPVIN').AsInteger := qryBusca.FieldByName('MEI_TIPVIN').AsInteger
        else
          cdsLista.FieldByName('MEI_TIPVIN').AsInteger := 0;

        if cdsLista.FindField('MEI_NUMDOC') <> nil then
          cdsLista.FieldByName('MEI_NUMDOC').AsString := qryBusca.FieldByName('MEI_NUMDOC').AsString;

        cdsLista.Post;
        qryBusca.Next;
      end;
    end;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

class procedure TManutencaoEquipamentoInterno.pGravaHistoricoAcao(
  strCodSolicitacao: string; oAcao: TManutencaoEquipamentoInternoAcao);
Var
  qryInclui: TUniQuery;
begin

  qryInclui := fCriaQuery(nil);
  Try
    qryInclui.Close;
    qryInclui.SQL.Clear;
    qryInclui.SQL.Add('INSERT INTO MNEQIH (MEI_CODSOL, MEI_DTACAD, MEI_HORCAD,');
    qryInclui.SQL.Add('MEI_CODOPE, MEI_ACAOHS) VALUES');
    qryInclui.SQL.Add('(:CODSOL, :DTACAD, :HORCAD, :CODOPE, :ACAOHS)');
    qryInclui.ParamByName('CODSOL').AsString := strCodSolicitacao;
    qryInclui.ParamByName('DTACAD').AsDate := VS_Date;
    qryInclui.ParamByName('HORCAD').AsTime := fTime();
    qryInclui.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryInclui.ParamByName('ACAOHS').AsString := TManutencaoEquipamentoInternoAcaoFuncoes.fTAcaoParaString(oAcao);
    qryInclui.ExecSQL;
  Finally
    FreeAndNil(qryInclui);
  End;
end;

procedure TManutencaoEquipamentoInterno.SetAutoincrem(const Value: string);
begin
  FAutoincrem := Value;
end;

procedure TManutencaoEquipamentoInterno.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDataCadastro(const Value: string);
begin
  FDataCadastro := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDataEstimadaConclusao(
  const Value: string);
begin
  FDataEstimadaConclusao := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDataFinalParalizacao(
  const Value: string);
begin
  FDataFinalParalizacao := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDataInicialParalizacao(
  const Value: string);
begin
  FDataInicialParalizacao := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDepartamento(const Value: string);
begin
  FDepartamento := Value;
end;

procedure TManutencaoEquipamentoInterno.SetDescricaoManutencao(
  const Value: string);
begin
  FDescricaoManutencao := Value;
end;

procedure TManutencaoEquipamentoInterno.SetMotivoPausa(const Value: string);
begin
  FMotivoPausa := Value;
end;

procedure TManutencaoEquipamentoInterno.SetOperadorCadastro(
  const Value: string);
begin
  FOperadorCadastro := Value;
end;

procedure TManutencaoEquipamentoInterno.SetPrioridade(const Value: string);
begin
  FPrioridade := Value;
end;

procedure TManutencaoEquipamentoInterno.SetResponsavelTecnico(
  const Value: string);
begin
  FResponsavelTecnico := Value;
end;

procedure TManutencaoEquipamentoInterno.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TManutencaoEquipamentoInterno.SetTipoVinculo(const Value: integer);
begin
  FTipoVinculo := Value;
end;

procedure TManutencaoEquipamentoInterno.SetNumeroDocumento(const Value: string);
begin
  FNumeroDocumento := Value;
end;

procedure TManutencaoEquipamentoInterno.SetEspDoc(const Value: string);
begin
  FEspDoc := Value;
end;

procedure TManutencaoEquipamentoInterno.SetSerie(const Value: string);
begin
  FSerie := Value;
end;

procedure TManutencaoEquipamentoInterno.SetCodFor(const Value: string);
begin
  FCodFor := Value;
end;

procedure TManutencaoEquipamentoInterno.SetCadCta(const Value: string);
begin
  FCadCta := Value;
end;


{ TManutencaoEquipamentoInternoItens }

class function TManutencaoEquipamentoInternoItens.fDeletarItens(
  strCodSolicitacao: string; blnGravarDel: Boolean = True): Boolean;
Var
  qryDeletar, qryBuscar: TUniQuery;
begin
  qryDeletar := fCriaQuery(nil);
  qryBuscar := fCriaQuery(nil);
  Try
    if blnGravarDel then
    begin
      qryBuscar.Close;
      qryBuscar.SQL.Clear;
      qryBuscar.SQL.Add('SELECT * FROM MNEQID WHERE MEI_CODSOL = :CODSOL');
      qryBuscar.ParamByName('CODSOL').AsString := strCodSolicitacao;
      qryBuscar.Open;

      fVerificaIntegridade('fDeletarItens', 'MNEQID', qryBuscar);
    end;
    qryDeletar.Close;
    qryDeletar.SQL.Clear;
    qryDeletar.SQL.Add('DELETE FROM MNEQID WHERE MEI_CODSOL = :CODSOL');

    qryDeletar.ParamByName('CODSOL').AsString := strCodSolicitacao;
    qryDeletar.ExecSQL;

    Result := qryDeletar.RowsAffected > 0;
  Finally
    FreeAndNil(qryDeletar);
    FreeAndNil(qryBuscar);
  End;
end;

function TManutencaoEquipamentoInternoItens.fIncluirSolicicaoItens(
  oManutencaoItens: TManutencaoEquipamentoInternoItens): Boolean;
Var
  qryInclui: TUniQuery;
begin
  qryInclui := fCriaQuery(nil);
  Try
    qryInclui.Close;
    qryInclui.SQL.Clear;
    qryInclui.SQL.Add('INSERT INTO MNEQID (AUTOINCREM, MEI_CODSOL, MEI_CODEQP, MEI_CODEMP)');
    qryInclui.SQL.Add('VALUES (:INCREM, :CODSOL, :CODEQP, :CODEMP)');

    qryInclui.ParamByName('INCREM').AsString := fRetAutoIncrem('MNEQID', VS_strCodEmp);
    qryInclui.ParamByName('CODSOL').AsString := oManutencaoItens.CodigoManutencao;
    qryInclui.ParamByName('CODEQP').AsString := oManutencaoItens.CodigoEquipamento;
    qryInclui.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryInclui.ExecSQL;

    Result := qryInclui.RowsAffected > 0;

    qryInclui.Close;
  Finally
    FreeAndNil(qryInclui);
  End;
end;

class procedure TManutencaoEquipamentoInternoItens.pCarregarItensSolicitacao(
  strCodSolicitacao: string; cdsLista: TZClient);
Var
  qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery(nil);

  cdsLista.EmptyDataSet;
  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT MQ.AUTOINCREM, MEI_CODEQP, CQ.EQU_DESCRI, CM.MAR_DESMAR,');
    qryBusca.SQL.Add('CQ.EQU_CODITE, CI.ITE_DESITE FROM MNEQID MQ');
    qryBusca.SQL.Add('INNER JOIN CADEQU CQ ON CQ.EQU_CODIGO = MQ.MEI_CODEQP');
    qryBusca.SQL.Add('INNER JOIN CADMAR CM ON CM.MAR_CODMAR = CQ.EQU_CODMAR');
    qryBusca.SQL.Add('INNER JOIN CADITE CI ON CI.ITE_CODITE = CQ.EQU_CODITE');
    qryBusca.SQL.Add('WHERE MEI_CODSOL = :CODSOL');
    qryBusca.ParamByName('CODSOL').AsString := strCodSolicitacao;
    qryBusca.Open;

    if not qryBusca.IsEmpty then
    begin
      qryBusca.First;

      while not qryBusca.Eof do
      begin
        cdsLista.Append;

        if cdsLista.FindField('AUTOINCREM') <> nil then
          cdsLista.FieldByName('AUTOINCREM').AsString := qryBusca.FieldByName('AUTOINCREM').AsString;

        if cdsLista.FindField('EQU_CODIGO') <> nil then
          cdsLista.FieldByName('EQU_CODIGO').AsString := qryBusca.FieldByName('MEI_CODEQP').AsString;

        if cdsLista.FindField('EQU_DESCRI') <> nil then
          cdsLista.FieldByName('EQU_DESCRI').AsString := qryBusca.FieldByName('EQU_DESCRI').AsString;

        if cdsLista.FindField('MAR_DESMAR') <> nil then
          cdsLista.FieldByName('MAR_DESMAR').AsString := qryBusca.FieldByName('MAR_DESMAR').AsString ;

        if cdsLista.FindField('EQU_CODITE') <> nil then
          cdsLista.FieldByName('EQU_CODITE').AsString := qryBusca.FieldByName('EQU_CODITE').AsString;

        if cdsLista.FindField('ITE_DESITE') <> nil then
          cdsLista.FieldByName('ITE_DESITE').AsString := qryBusca.FieldByName('ITE_DESITE').AsString;

        cdsLista.Post;
        qryBusca.Next;
      end;
    end;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

procedure TManutencaoEquipamentoInternoItens.SetAutoincrem(const Value: string);
begin
  FAutoincrem := Value;
end;

procedure TManutencaoEquipamentoInternoItens.SetCodigoEquipamento(
  const Value: string);
begin
  FCodigoEquipamento := Value;
end;

procedure TManutencaoEquipamentoInternoItens.SetCodigoManutencao(
  const Value: string);
begin
  FCodigoManutencao := Value;
end;

{ TAcaoFuncoes }

class function TManutencaoEquipamentoInternoAcaoFuncoes.fTAcaoParaString(oAcao: TManutencaoEquipamentoInternoAcao): String;
begin
   case oAcao of
    taIncluir: Result := 'INCLUIU';
    taAlterar: Result := 'ALTEROU';
    taExcluir: Result := 'EXCLUIU';
    taAprovar: Result := 'APROVOU';
    taRejeitar: Result := 'REJEITOU';
    taFinalizar: Result := 'FINALIZOU';
    taVincular: Result := 'VINCULOU';
    taDesvincular: Result := 'DESVINCULOU';
    taAtualizarStatus: Result := 'ATUALIZOU STATUS';
    taConcluiuCompra: Result := 'COMPRA CONCLUIDA';
  end;
end;

end.
