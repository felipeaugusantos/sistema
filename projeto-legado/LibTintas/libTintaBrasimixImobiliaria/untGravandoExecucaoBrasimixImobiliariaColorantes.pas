{******************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta BrasimixImobiliaria *}
{***************************************************************************************PH*}
unit untGravandoExecucaoBrasimixImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoBrasimixImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, DB, Classes, StrUtils, Variants;

type
  TGravandoExecucaoBrasimixImobiliariaColorantes = class(TAbstractGravandoExecucaoBrasimixImobiliaria)
  private
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoBrasimixImobiliariaCores }

procedure TGravandoExecucaoBrasimixImobiliariaColorantes.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('BZI_CADCOL');
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

function TGravandoExecucaoBrasimixImobiliariaColorantes.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString))]), []);
end;

function TGravandoExecucaoBrasimixImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoBrasimixImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZI_CADCOL';
end;

function TGravandoExecucaoBrasimixImobiliariaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to 20 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT           ' +
      '   FORM' + TStrUtils.fStrZero(intCont, 2) + ' AS CODCOL     ' +
      ' FROM                     ' +
      '   [%s]  ' +
      ' WHERE FORM' + TStrUtils.fStrZero(intCont, 2) + ' <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TGravandoExecucaoBrasimixImobiliariaColorantes.GravarRegistro(
  const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('CODCOL').AsString)));
  qryDestino.FieldByName('COL_PESESP').AsFloat  := 1;
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BZI_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
  qryDestino.Post;
end;

end.

