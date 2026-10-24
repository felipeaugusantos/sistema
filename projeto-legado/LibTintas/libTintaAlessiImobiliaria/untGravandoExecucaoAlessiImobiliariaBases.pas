{************************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Alessi Imobiliaria *}
{*********************************************************************************AC*}
unit untGravandoExecucaoAlessiImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoAlessiImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoAlessiImobiliariaBases = class(TAbstractGravandoExecucaoAlessiImobiliaria)
  private
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    function fRetCodUnidade(strEmbalagem: String): String;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    procedure DeletarRegistros;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

{ TGravandoExecucaoAlessiImobiliariaBases }

procedure TGravandoExecucaoAlessiImobiliariaBases.DeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('ALE_CADBAS');
end;

procedure TGravandoExecucaoAlessiImobiliariaBases.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('ALE_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Deletando registros da tabela ALE_CADBAS...';
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
          gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoAlessiImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAlessiImobiliariaBases.fRetCodUnidade(
  strEmbalagem: String): String;
begin
  Result := 'LT';

  if ((strEmbalagem = 'GALAO') Or (strEmbalagem = '5KG') Or (strEmbalagem =  '4.4 KG')) Then
    Result := 'GL'
  else if ((strEmbalagem = 'LATA')Or (strEmbalagem =  '22 KG') Or (strEmbalagem = '25KG')) Then
    Result := 'LA'
  else if (strEmbalagem = 'QUARTO') Then
    Result := 'QT';
end;

function TGravandoExecucaoAlessiImobiliariaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ALE_CADBAS';
end;

function TGravandoExecucaoAlessiImobiliariaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT              ' +
    '   *                 ' +
    ' FROM                ' +
    '   [BASES$]          ' +
    ' WHERE [NOME PRODUTO] <> "" ';
end;

procedure TGravandoExecucaoAlessiImobiliariaBases.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALE_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('NOME PRODUTO').AsString);
  qryDestino.FieldByName('BAS_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('NOME BASE').AsString);
  qryDestino.FieldByName('BAS_CODUNI').AsString := fRetCodUnidade(LimpaTexto(qryOrigem.FieldByName('NOME EMBALAGEM').AsString));
  qryDestino.FieldByName('BAS_EMBALA').AsString := LimpaTexto(qryOrigem.FieldByName('NOME EMBALAGEM').AsString);
  qryDestino.Post;
end;

function TGravandoExecucaoAlessiImobiliariaBases.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_PRODUT;BAS_BASE__;BAS_EMBALA', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('NOME PRODUTO').AsString),
    LimpaTexto(qryOrigem.FieldByName('NOME BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('NOME EMBALAGEM').AsString)]), []);
end;

end.
