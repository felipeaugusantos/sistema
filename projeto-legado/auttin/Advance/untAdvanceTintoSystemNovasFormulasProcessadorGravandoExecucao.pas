unit untAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao;

interface

uses
  untIProcessadorGravandoExecucao, Uni, DB, Classes, SysUtils, untIGravando;

type
  TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao = class(TInterfacedObject, IProcessadorGravandoExecucao)
  public
    function GetDataSetOrigem: TDataSet;
    function GetSqlDestino: string;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure LimparTabelas;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet);
    function fGetNomeGravacao: string;
  end;

implementation

uses
   untFuncoesSimples, UniClientDataSet,
   untProcessadorGravandoExecucaoAdvanceTintoSystemCores;

{ TAdvancrTintoSystemProcessadorGravandoExecucao }

function TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM ADT_CADNFM');  
end;

function TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ADT_CADADT WHERE FALSE ';
end;

procedure TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADT_CADADT';
end;

procedure TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GravarNovaFormula(qryOrigem);
end;

function TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.LimparTabelas;
begin
end;

procedure TAdvanceTintoSystemNovasFormulasProcessadorGravandoExecucao.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a nova fórmula %s - %s, [%s: %s]', [
    qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_CODCOR').AsString,
    E.ClassName,
    E.Message]);
end;

end.
