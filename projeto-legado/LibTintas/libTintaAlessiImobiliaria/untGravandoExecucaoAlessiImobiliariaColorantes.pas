{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Alessi Imobiliaria  *}
{***************************************************************************************AC*}
unit untGravandoExecucaoAlessiImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoAlessiImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DB, Classes, StrUtils, Variants;

type
  TGravandoExecucaoAlessiImobiliariaColorantes = class(TAbstractGravandoExecucaoAlessiImobiliaria)
  private
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    procedure DeletarRegistros;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoAlessiImobiliariaCores }

procedure TGravandoExecucaoAlessiImobiliariaColorantes.DeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('ALE_CADCOL');
end;

procedure TGravandoExecucaoAlessiImobiliariaColorantes.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Verificando path dos arquivos...';

      if not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) then
      begin
        gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
        gravando.Cancelar;
      end;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Path validado com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALE_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Deletando registros da tabela ALE_CADCOL...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluido com sucesso...';

      gravando.Texto := 'Carregando dados...';

      CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Dados carregados com sucesso...';

      gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
      gravando.RegistrarProgresso(0, 0, 0);

      qryOrigem.First;
      while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try

            if gravando.Status <> sgGravando then
            begin
              Exit;
            end;

            if not IsRegistroExistente(qryOrigem, qryDestino) then
            begin
              GravarRegistro(qryOrigem, qryDestino);
            end;

          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryOrigem.Next;
          gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
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

  End;
end;

function TGravandoExecucaoAlessiImobiliariaColorantes.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL',
    VarArrayOf([LimpaTexto(qryOrigem.FieldByName('NOME CORANTE').AsString)]), []);
end;

function TGravandoExecucaoAlessiImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoAlessiImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ALE_CADCOL';
end;

function TGravandoExecucaoAlessiImobiliariaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT            ' +
    '   [NOME CORANTE]           ' +
    ' FROM                       ' +
    '   [CORANTES$]              ' +
    ' WHERE [NOME CORANTE] <> "" ';
end;

procedure TGravandoExecucaoAlessiImobiliariaColorantes.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('NOME CORANTE').AsString);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALE_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 946;
  qryDestino.Post;
end;

end.

