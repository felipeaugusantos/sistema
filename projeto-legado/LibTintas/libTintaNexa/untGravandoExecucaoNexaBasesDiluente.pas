unit untGravandoExecucaoNexaBasesDiluente;

interface

uses
  untAbstractGravandoExecucaoNexa, untIGravando, SysUtils, untIDataSet,

  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoNexaBasesDiluente = class(TAbstractGravandoExecucaoNexa)
  private
    function IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
    procedure DeletarRegistroExistente(const qryOrigem: IDataSet);
    procedure GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
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

{ TGravandoExecucaoNexaBasesDiluente }

procedure TGravandoExecucaoNexaBasesDiluente.DeletarRegistroExistente(
  const qryOrigem: IDataSet);
Var
  qryDelete: IDataSet;
begin
  qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelete.Close;
  qryDelete.SQL.Empty;
  qryDelete.SQL := '  DELETE                ';
  qryDelete.SQL := qryDelete.SQL + '  FROM  NEX_CADBAS      ';
  qryDelete.SQL := qryDelete.SQL + '  WHERE BAS_CODBAS = :BASE  AND     ';
  qryDelete.SQL := qryDelete.SQL + '        BAS_TIPO__ = :TIPO          ';

  qryDelete.ParamByName('BASE').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDelete.ParamByName('TIPO').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDelete.ExecSQL;
end;

procedure TGravandoExecucaoNexaBasesDiluente.Executar(const gravando: IGravando);
var
  qryOrigem : IDataSet;
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
      TAutcomTintaFactory.Get.fInsereProCod('NEX_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

     // CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      qryOrigem := TAutcomTintaFactory.Get.fGetDataSet;
      qryOrigem.Close;
      qryOrigem.SQL  := GetSqlOrigem('', Nil);
      qryOrigem.Open;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := 'SELECT * FROM NEX_CADBAS; ';
      qryDestino.Open;

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
              DeletarRegistroExistente(qryOrigem);
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


function TGravandoExecucaoNexaBasesDiluente.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Diluentes';
end;

function TGravandoExecucaoNexaBasesDiluente.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM NEX_CADBAS';
end;

function TGravandoExecucaoNexaBasesDiluente.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := ' SELECT DISTINCT                                            ' +
            '   NEX_TIPO__ AS BAS_TIPO__                                 ' +
            '   , DIL_CODDIL AS BAS_CODBAS                               ' +
            '   , DIL_PESESP AS BAS_PESESP                               ' +
            ' FROM                                                       ' +
            '   PPG_CADDIL D                                             ' +
            '   , NEX_CADNEX T                                           ' +
            ' WHERE T.NEX_TIPO__ LIKE CONCAT("%", D.DIL_LINHA_, "%") '
end;


procedure TGravandoExecucaoNexaBasesDiluente.GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('NEX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDestino.FieldByName('BAS_DESBAS').AsString := 'DILUENTE ' + qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
  qryDestino.FieldByName('BAS_PESESP').AsString := qryOrigem.FieldByName('BAS_PESESP').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 3600;
  qryDestino.FieldByName('BAS_QTDEMB').AsString := '3600 ML';
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.Post;
end;

function TGravandoExecucaoNexaBasesDiluente.IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

end.
