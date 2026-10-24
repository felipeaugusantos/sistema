unit Contabilidade.Classes.TUpdateContaContabil;

interface

uses Contabilidade.Interfaces, System.Generics.Collections,
  Contabilidade.Model.Contabilizaveis;

type
  TUpdateContaContabil = class(TInterfacedObject, IUpdateContaContabil)
  private
    FListaContabilizaveis: TObjectList<TContabilizaveis>;
    procedure pUpdateContaCliente(const ACodigo, AConta: string);
    procedure pUpdateContaFornecedor(const ACodigo, AConta: string);
    procedure pUpdateContaPortador(const ACodigo, AConta: string);
    procedure pUpdateContaPlanoContas(const ACodigo, AConta: string);
    procedure pUpdateContaContaCredito(const AContaNova, AContaAntiga: string);
    procedure pUpdateContaContaDebito(const AContaNova, AContaAntiga: string);
    procedure pUpdateBandeira(const ACodigo, AConta: string);
  public
    procedure setContaContabil(const AConta, AIncDoc: string);
    constructor Create(const AListaContabilizaveis: TObjectList<TContabilizaveis>);
    class function New(const AListaContabilizaveis: TObjectList<TContabilizaveis>): IUpdateContaContabil;
  end;

implementation

uses
  Uni, System.SysUtils, untFuncoesSimples, Contabilidade.Funcoes ;

{ TUpdateContaContabil }

constructor TUpdateContaContabil.Create(
  const AListaContabilizaveis: TObjectList<TContabilizaveis>);
begin
  FListaContabilizaveis := AListaContabilizaveis;
end;

class function TUpdateContaContabil.New(
  const AListaContabilizaveis: TObjectList<TContabilizaveis>): IUpdateContaContabil;
begin
  Result := Self.Create(AListaContabilizaveis);
end;

procedure TUpdateContaContabil.pUpdateBandeira(const ACodigo, AConta: string);
  var
    qryUpdate : TUniQuery;
begin
  if ACodigo.IsEmpty then
    exit;

  if AConta.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Text := 'UPDATE CADBAN SET BAN_PLANCO = :PLANCO WHERE BAN_CODBAN = :CODBAN AND BAN_PLANCO IS NULL';
    qryUpdate.ParamByName('CODBAN').AsString := ACodigo;
    qryUpdate.ParamByName('PLANCO').AsString := AConta;
    qryUpdate.ExecSQL;
  finally
    FreeANdNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaCliente(const ACodigo,
  AConta: string);
  var
    qryUpdate : TUniQuery;
begin
  if ACodigo.IsEmpty then
    exit;

  if AConta.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Text := 'UPDATE CADCLI SET CLI_PLANCO = :PLANCO WHERE CLI_CODCLI = :CODCLI AND CLI_PLANCO IS NULL';
    qryUpdate.ParamByName('CODCLI').AsString := ACodigo;
    qryUpdate.ParamByName('PLANCO').AsString := AConta;
    qryUpdate.ExecSQL;
  finally
    FreeANdNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaContaCredito(const AContaNova,
  AContaAntiga: string);
 var
    qryUpdate : TUniQuery;
begin
  if AContaNova.IsEmpty then
    exit;

  if AContaAntiga.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Clear ;
    qryUpdate.SQL.Add('UPDATE PARCON SET CON_CONCRE = :CONCRE_NOVO WHERE CON_CONCRE = :CONCRE_ANTIGO ');
    pSetarFiltroEmpresa(qryUpdate) ;
    qryUpdate.ParamByName('CONCRE_NOVO').AsString := AContaNova;
    qryUpdate.ParamByName('CONCRE_ANTIGO').AsString := AContaAntiga;
    qryUpdate.ExecSQL;
  finally
    FreeANdNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaContaDebito(const AContaNova,
  AContaAntiga: string);
  var
    qryUpdate : TUniQuery;
begin
  if AContaNova.IsEmpty then
    exit;

  if AContaAntiga.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Clear ;
    qryUpdate.SQL.Add('UPDATE PARCON SET CON_CONDEB = :CONDEB_NOVO WHERE CON_CONDEB = :CONDEB_ANTIGO ');
    pSetarFiltroEmpresa(qryUpdate) ;
    qryUpdate.ParamByName('CONDEB_NOVO').AsString := AContaNova;
    qryUpdate.ParamByName('CONDEB_ANTIGO').AsString := AContaAntiga;
    qryUpdate.ExecSQL;
  finally
    FreeANdNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaFornecedor(const ACodigo,
  AConta: string);
  var
    qryUpdate : TUniQuery;
begin
  if ACodigo.IsEmpty then
    exit;

  if AConta.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Text := 'UPDATE CADFOR SET FOR_PLANCO = :PLANCO WHERE FOR_CODFOR = :CODFOR AND FOR_PLANCO IS NULL';
    qryUpdate.ParamByName('CODFOR').AsString := ACodigo;
    qryUpdate.ParamByName('PLANCO').AsString := AConta;
    qryUpdate.ExecSQL;
  finally
    FreeANdNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaPlanoContas(const ACodigo,
  AConta: string);
  var
    qryUpdate : TUniQuery;
begin
  if ACodigo.IsEmpty then
    exit;

  if AConta.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Text := 'UPDATE CADCTA SET CTA_PLANCO = :PLANCO WHERE CTA_CODCTA = :CODCTA AND CTA_PLANCO IS NULL';
    qryUpdate.ParamByName('CODCTA').AsString := ACodigo;
    qryUpdate.ParamByName('PLANCO').AsString := AConta;
    qryUpdate.ExecSQL;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.pUpdateContaPortador(const ACodigo,
  AConta: string);
  var
    qryUpdate : TUniQuery;
begin
  if ACodigo.IsEmpty then
    exit;

  if AConta.IsEmpty then
    exit;

  qryUpdate := fCriaQuery(nil);
  try
    qryUpdate.SQL.Text := 'UPDATE CADPOR SET POR_PLANCO = :PLANCO WHERE POR_CODPOR = :CODPOR AND POR_PLANCO IS NULL';
    qryUpdate.ParamByName('CODPOR').AsString := ACodigo;
    qryUpdate.ParamByName('PLANCO').AsString := AConta;
    qryUpdate.ExecSQL;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TUpdateContaContabil.setContaContabil(const AConta, AIncDoc: string);
  var
    LContabilizavel : TContabilizaveis;
begin
  if not Assigned(FListaContabilizaveis) then
    Exit;

  if FListaContabilizaveis.Count = 0 then
    Exit;

  for LContabilizavel in FListaContabilizaveis do
  begin
    if (LContabilizavel.IncDoc = AIncDoc) then
    begin
      pUpdateContaCliente(LContabilizavel.Cliente.strCodigo, AConta);
      pUpdateContaFornecedor(LContabilizavel.Fornecedor.strCodigo, AConta);
      pUpdateContaPortador(LContabilizavel.Portador.strCodigo, AConta);
      pUpdateContaPlanoContas(LContabilizavel.PlanoContasCadastro.strCodigo, AConta);
      pUpdateContaPlanoContas(LContabilizavel.PlanoContasBaixa.strCodigo, AConta);
      pUpdateContaPlanoContas(LContabilizavel.PlanoContasTaxa.strCodigo, AConta);
      pUpdateContaContaDebito(AConta, LContabilizavel.ContaDebito);
      pUpdateContaContaCredito(AConta, LContabilizavel.ContaCredito);
      pUpdateBandeira(AConta, LContabilizavel.CodigoBandeira);
    end;
  end;
end;

end.
