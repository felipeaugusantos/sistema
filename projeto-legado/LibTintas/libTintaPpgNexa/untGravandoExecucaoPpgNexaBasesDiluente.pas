unit untGravandoExecucaoPpgNexaBasesDiluente;

interface

uses
  untAbstractGravandoExecucaoPpgNexa, untIGravando, SysUtils, untIDataSet,

  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgNexaBasesDiluente = class(TAbstractGravandoExecucaoPpgNexa)
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

{ TGravandoExecucaoPpgNexaBasesDiluente }

procedure TGravandoExecucaoPpgNexaBasesDiluente.DeletarRegistroExistente(
  const qryOrigem: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL.Empty;
  qryGen.SQL := ' DELETE FROM PPX_CADBAS  ';
  qryGen.SQL := qryGen.SQL + '  WHERE BAS_CODBAS = :BASE  AND ';
  qryGen.SQL := qryGen.SQL + '    BAS_TIPO__ = :TIPO      ';
  qryGen.ParamByName('BASE').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryGen.ParamByName('TIPO').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoPpgNexaBasesDiluente.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('PPX_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

     // CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      qryOrigem := TAutcomTintaFactory.Get.fGetDataSet;
      qryOrigem.Close;
      qryOrigem.SQL  := GetSqlOrigem('', Nil);
      qryOrigem.Open;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := 'SELECT * FROM PPX_CADBAS; ';
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


function TGravandoExecucaoPpgNexaBasesDiluente.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Diluentes';
end;

function TGravandoExecucaoPpgNexaBasesDiluente.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPX_CADBAS';
end;

function TGravandoExecucaoPpgNexaBasesDiluente.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := ' SELECT DISTINCT                                            ' +
            '   PPX_TIPO__ AS BAS_TIPO__                                 ' +
            '   , DIL_CODDIL AS BAS_CODBAS                               ' +
            '   , DIL_PESESP AS BAS_PESESP                               ' +
            ' FROM                                                       ' +
            '   PPX_CADDIL D                                             ' +
            '   , PPX_CADPPX T                                           ' +
            ' WHERE T.PPX_TIPO__ LIKE CONCAT("%", D.DIL_LINHA_, "%") '
end;


procedure TGravandoExecucaoPpgNexaBasesDiluente.GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDestino.FieldByName('BAS_DESBAS').AsString := 'DILUENTE ' + qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
  qryDestino.FieldByName('BAS_PESESP').AsString := qryOrigem.FieldByName('BAS_PESESP').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 3600;
  qryDestino.FieldByName('BAS_QTDEMB').AsString := '3600 ML';
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.Post;
end;

function TGravandoExecucaoPpgNexaBasesDiluente.IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

end.
