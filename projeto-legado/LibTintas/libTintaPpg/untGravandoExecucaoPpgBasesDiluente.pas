unit untGravandoExecucaoPpgBasesDiluente;

interface

uses
  untAbstractGravandoExecucaoPpg, untIGravando, SysUtils, untIDataSet,

  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgBasesDiluente = class(TAbstractGravandoExecucaoPpg)
  private
    function IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
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

{ TGravandoExecucaoPpgBasesDiluente }

procedure TGravandoExecucaoPpgBasesDiluente.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('PPG_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

     // CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      qryOrigem := TAutcomTintaFactory.Get.fGetDataSet;
      qryOrigem.Close;
      qryOrigem.SQL  := GetSqlOrigem('', Nil);
      qryOrigem.Open;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := 'SELECT * FROM PPG_CADBAS; ';
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


function TGravandoExecucaoPpgBasesDiluente.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases Diluentes';
end;

function TGravandoExecucaoPpgBasesDiluente.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADBAS';
end;

function TGravandoExecucaoPpgBasesDiluente.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := ' SELECT DISTINCT                                            ' +
            '   PPG_TIPO__ AS BAS_TIPO__                                 ' +
            '   , DIL_CODDIL AS BAS_CODBAS                               ' +
            '   , DIL_PESESP AS BAS_PESESP                               ' +
            ' FROM                                                       ' +
            '   PPG_CADDIL D                                             ' +
            '   , PPG_CADPPG T                                           ' +
            ' WHERE T.PPG_TIPO__ LIKE CONCAT("%", D.DIL_LINHA_, "%") '
end;


procedure TGravandoExecucaoPpgBasesDiluente.GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPG_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('BAS_CODBAS').AsString;
  qryDestino.FieldByName('BAS_DESBAS').AsString := 'DILUENTE ' + qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
  qryDestino.FieldByName('BAS_PESESP').AsString := qryOrigem.FieldByName('BAS_PESESP').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := 3600;
  qryDestino.FieldByName('BAS_QTDEMB').AsString := '3600 ML';
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('BAS_TIPO__').AsString;
  qryDestino.Post;
end;

function TGravandoExecucaoPpgBasesDiluente.IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

end.
