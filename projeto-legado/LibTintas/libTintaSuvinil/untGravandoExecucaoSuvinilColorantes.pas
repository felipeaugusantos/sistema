{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta suvinil *}
{***************************************************************************PH*}
unit untGravandoExecucaoSuvinilColorantes;

interface

uses
  untAbstractGravandoExecucaoSuvinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando;

type
  TGravandoExecucaoSuvinilColorantes = class(TAbstractGravandoExecucaoSuvinil)
  private
    procedure Gravar(const qryOrigem: TADODataSet; const dtsDestino: IDataSet);
    function Existe(const qryOrigem: TADODataSet; const dtsDestino: IDataSet): Boolean;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fHabilitaOpcao(): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoSuvinilCores }

procedure TGravandoExecucaoSuvinilColorantes.Executar(const gravando: IGravando);
var
  qryDestino: IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';

      CriarObjetos;

      CarregarDadosColorantes;
      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.SQL := 'SELECT * FROM SUV_CADCOL';
      qryDestino.Open;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SUV_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';
      qryColorantes.Open;

      qryColorantes.First;
      while (not qryColorantes.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try
            if not Existe(qryColorantes, qryDestino) then
              Gravar(qryColorantes, qryDestino);
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0, qryColorantes.RecNo, qryColorantes.RecordCount);
          qryColorantes.Next;
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        gravando.Cancelar;
      end;
    End;
  Finally
    DestruirObjetos;
  End;
end;

function TGravandoExecucaoSuvinilColorantes.Existe(const qryOrigem: TADODataSet; const dtsDestino: IDataSet): Boolean;
begin
  Result := dtsDestino.Locate('COL_CODCOL', qryOrigem.FieldByName('SIGLA_COLORANTE').AsString, []);
end;

function TGravandoExecucaoSuvinilColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoSuvinilColorantes.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoSuvinilColorantes.Gravar(const qryOrigem: TADODataSet; const dtsDestino: IDataSet);
begin
  dtsDestino.Insert;
  dtsDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('SIGLA_COLORANTE').AsString;
  dtsDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  dtsDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SUV_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  dtsDestino.FieldByName('COL_EMBALA').AsFloat  := 900;
  dtsDestino.Post;  
end;

end.

