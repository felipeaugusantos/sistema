
unit untGravandoExecucaoPpgMontadora;

interface

uses
  untAbstractGravandoExecucaoPpg, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgMontadora = class(TAbstractGravandoExecucaoPpg)
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

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoPpgMontadora }


procedure TGravandoExecucaoPpgMontadora.Executar(const gravando: IGravando);
var
  qryOrigem : TDataSet;
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
      TAutcomTintaFactory.Get.fInsereProCod('PPG_CADMON');
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


function TGravandoExecucaoPpgMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;

function TGravandoExecucaoPpgMontadora.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADMON';
end;

function TGravandoExecucaoPpgMontadora.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT                       ' +
    '   [MANUFACTURER KEY CODE] AS CODMON             ' +
    '   , [MANUFACTURER DESCRIPTION] AS DESCRI        ' +
    ' FROM                                  ' +
    '   ' + StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]) + '        ' +
    ' WHERE [MANUFACTURER KEY CODE] <> '''' AND (NOT [MANUFACTURER KEY CODE] LIKE ''%,%'') ' +
    ' AND UCase([Brand Description]) = ' + AnsiUpperCase(QuotedStr('PPG'));
end;


procedure TGravandoExecucaoPpgMontadora.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('MON_CODMON').AsString := qryOrigem.FieldByName('CODMON').AsString;

  qryDestino.FieldByName('MON_DESCRI').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESCRI').AsString)))));

  qryDestino.FieldByName('MON_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  qryDestino.FieldByName('AUTOINCREM').AsString :=  TAutcomTintaFactory.Get.fRetAutoIncrem('PPG_CADMON', TAutcomTintaFactory.Get.GetCodEmp);

  qryDestino.Post;
end;

function TGravandoExecucaoPpgMontadora.IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := qryDestino.Locate('MON_CODMON',
    VarArrayOf([Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODMON').AsString)))))]),
    []);

end;

end.
