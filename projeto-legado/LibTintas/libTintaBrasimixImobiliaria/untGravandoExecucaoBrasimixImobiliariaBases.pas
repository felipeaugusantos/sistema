{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta BrasimixImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoBrasimixImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoBrasimixImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoBrasimixImobiliariaBases = class(TAbstractGravandoExecucaoBrasimixImobiliaria)
  private
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

{ TGravandoExecucaoBrasimixImobiliariaBases }

procedure TGravandoExecucaoBrasimixImobiliariaBases.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('BZI_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

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

function TGravandoExecucaoBrasimixImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoBrasimixImobiliariaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZI_CADBAS';
end;

function TGravandoExecucaoBrasimixImobiliariaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
const
  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
var
  intCont: Integer;
begin

  Result := '';
  for intCont := 0 to Length(arrUnidades) - 1 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT DISTINCT          ' +
      '   LINHA                   ' +
      '   , BASE                 ' +
      '   , DESBAS                 ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS CODUNI     ' +
      ' FROM                     ' +
      '   [%s]  ' +
      ' WHERE BASE <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TGravandoExecucaoBrasimixImobiliariaBases.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_LINHA_').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString)));
  qryDestino.FieldByName('BAS_BASE__').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('BASE').AsString)));
  qryDestino.FieldByName('BAS_UNIDAD').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString));
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_DESCRI').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('DESBAS').AsString));
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZI_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.Post;
end;

function TGravandoExecucaoBrasimixImobiliariaBases.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_LINHA_;BAS_BASE__;BAS_UNIDAD', VarArrayOf([
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString))),
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('BASE').AsString))),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString))]), []);
end;

end.
