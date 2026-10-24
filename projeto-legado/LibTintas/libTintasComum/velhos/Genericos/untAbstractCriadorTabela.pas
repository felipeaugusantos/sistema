{*******************************************************************************************}
{* Classe abstrata responsável pela geração de tabelas no banco de dados e já alimentando, *}
{* mostrando o progresso atraves da implementação da interface IGravandoExecucao           *}
{****************************************************************************************PH*}
unit untAbstractCriadorTabela;

interface

uses
  untIGravandoExecucao, DB, untIDataSet, untAutcomTintaFactory,
  untIGravando, SysUtils, untStatusGravando;

type
  TAbstractCriadorTabela = class abstract (TInterfacedObject, IGravandoExecucao)
  private
    qryOrigem: TDataSet;
    strNomeTabela: string;
  protected
    strCampos: string;
    procedure CarregarTabela(const qryOrigem: TDataSet; const qryGrava: IDataSet; const gravando: IGravando); virtual; 
  public
    constructor Create(const strNomeTabela: string; const qryOrigem: TDataSet; const strCampos: string); overload;
    constructor Create(const strNomeTabela: string; const strCampos: string); overload;
    procedure Executar(const gravando: IGravando);
    destructor Destroy; override;
    function GetNomeTabela: string;
  end;


implementation

{ TAbstractCriadorTabela }

procedure TAbstractCriadorTabela.CarregarTabela(const qryOrigem: TDataSet; const qryGrava: IDataSet; const gravando: IGravando);
begin

end;

constructor TAbstractCriadorTabela.Create(const strNomeTabela: string; const qryOrigem: TDataSet; const strCampos: string);
begin
  inherited Create();
  Self.strNomeTabela := strNomeTabela;
  Self.qryOrigem := qryOrigem;
  Self.strCampos := strCampos;
end;

constructor TAbstractCriadorTabela.Create(const strNomeTabela, strCampos: string);
begin
  Create(strNomeTabela, nil, strCampos);
end;

destructor TAbstractCriadorTabela.Destroy;
begin
  strCampos := '';
  inherited;
end;

procedure TAbstractCriadorTabela.Executar(const gravando: IGravando);
var
  qryGrava: IDataSet;
begin
  TAutcomTintaFactory.Get.DropTable(strNomeTabela);
  qryGrava := TAutcomTintaFactory.Get.fGetDataSet;
  qryGrava.SQL := 'CREATE TABLE ' + strNomeTabela + ' (' + strCampos + ')';
  qryGrava.ExecSQL;

  if not Assigned(qryOrigem) then
    Exit;

  qryOrigem.First;
  while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
  begin
    Try
      Try
        qryGrava.SQL := TAutcomTintaFactory.Get.GetInsert(strNomeTabela);
        CarregarTabela(qryOrigem, qryGrava, gravando);
      Except
        on E: Exception do
        begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        end;
      End;
    Finally
      gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
      qryOrigem.Next;
    End;
  end;
end;


function TAbstractCriadorTabela.GetNomeTabela: string;
begin
  Result := strNomeTabela;
end;

end.
