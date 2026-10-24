unit untProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando,
   Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
  private
    novaFormula: INovaFormula;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    function GetDataSetOrigem(): TDataSet;
    function GetSqlDestino(): string;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet);
    function fGetNomeGravacao(): string;
    procedure LimparTabelas;
    constructor Create(const novaFormula: INovaFormula); overload;
    constructor Create(); overload;
  end;

implementation

uses
 untFuncoesSimples, untNovaFormulaBrasimixImobiliaria;

{ TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas }

constructor TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;
end;

constructor TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.Create;
begin
  Create(TNovaFormulaBrasimixImobiliaria.Create);
end;

function TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM BZI_CADNFM');
end;

function TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZI_CADBZI WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZI_CADBZI';
end;

procedure TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.LimparTabelas;
begin
  fExecutaSQL('DELETE FROM BZI_CADBZI WHERE BZI_CODIGO IN (SELECT NFM_CODIGO FROM BZI_CADNFM)');
end;

procedure TProcessadorGravandoExecucaoBrasimixImobiliariaNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a nova formula [%s %s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('NFM_CODIGO').AsString,
    qryOrigem.FieldByName('NFM_LINHA_').AsString,
    qryOrigem.FieldByName('NFM_BASE__').AsString,
    qryOrigem.FieldByName('NFM_DESCRI').AsString,
    qryOrigem.FieldByName('NFM_UNIDAD').AsString,
    E.ClassName,
    E.Message
  ]);
end;

end.
