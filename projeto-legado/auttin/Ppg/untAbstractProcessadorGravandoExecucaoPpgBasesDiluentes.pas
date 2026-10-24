unit untAbstractProcessadorGravandoExecucaoPpgBasesDiluentes;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Variants;

type
  TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
  public
    function GetDataSetOrigem: TDataSet; virtual; abstract;
    function GetSqlDestino: string; virtual; abstract;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; virtual; 
    procedure LimparTabelas;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet);
    function fGetNomeGravacao: string;
  end;

implementation

{ TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes }

function TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Diluentes';
end;

function TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_TIPO__', VarArrayOf([
    qryOrigem.FieldByName('BAS_CODBAS').AsString,
    qryOrigem.FieldByName('BAS_TIPO__').AsString
  ]), []);
end;

procedure TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes.LimparTabelas;
begin

end;

procedure TAbstractProcessadorGravandoExecucaoPpgBasesDiluentes.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a Base [%s - %s], [%s: %s]',
    [qryOrigem.FieldByName('BAS_CODBAS').AsString,
    qryOrigem.FieldByName('BAS_TIPO__').AsString,
    E.ClassName,
    E.Message]);
end;

end.
