{************************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta PPX *}
{*********************************************************************************AC*}
unit untGravandoExecucaoPpgNexaBases;

interface

uses
  untAbstractGravandoExecucaoPpgNexa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgNexaBases = class(TAbstractGravandoExecucaoPpgNexa)
  private
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
    constructor Create(); reintroduce;

  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoPpgNexaBases }

constructor TGravandoExecucaoPpgNexaBases.Create;
begin
  inherited Create('PPG', 'PATPPX', 'PPG');
end;

procedure TGravandoExecucaoPpgNexaBases.Executar(const gravando: IGravando);
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
      TAutcomTintaFactory.Get.fInsereProCod('PPX_CADBAS');
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


function TGravandoExecucaoPpgNexaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoPpgNexaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPX_CADBAS';
end;

function TGravandoExecucaoPpgNexaBases.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
Var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to 11 do
  begin
    Result := Result +
      ' UNION   ' +
      ' SELECT  ' +
      '   [MIXING SCHEME DESCRIPTION] AS TIPO  ' +
      '   , [PRODUCT' + IntToStr(intCont) + ' CODE] AS CODBAS      ' +
      '   , PRODUCT' + IntToStr(intCont) + 'DESCRIPTION AS DESBAS  ' +
      '   , GRAVITYPRODUCT' + IntToStr(intCont) + ' AS PESESP      ' +
      ' FROM                            ' +
      '   ' + StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]) + '  ' +
      ' WHERE [PRODUCT' + IntToStr(intCont) + ' CODE] <> ''''   ' +
      ' AND UCase([Brand Description]) = ' + AnsiUpperCase(QuotedStr(strMarca));
  end;

  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;


procedure TGravandoExecucaoPpgNexaBases.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;

  qryDestino.FieldByName('BAS_CODBAS').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))));

  qryDestino.FieldByName('BAS_DESBAS').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESBAS').AsString)))));

  qryDestino.FieldByName('BAS_PESESP').AsFloat  := qryOrigem.FieldByName('PESESP').AsFloat;
  qryDestino.FieldByName('BAS_TIPO__').AsString := qryOrigem.FieldByName('TIPO').AsString;
  qryDestino.FieldByName('BAS_BASEPO').AsString := 'N';

  qryDestino.FieldByName('BAS_EMBALA').AsString := '900';
  qryDestino.FieldByName('BAS_QTDEMB').ASString := '900 ML';

  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);

  qryDestino.Post;
end;

function TGravandoExecucaoPpgNexaBases.IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin

  Result := qryDestino.Locate('BAS_CODBAS', VarArrayOf([
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))))]),[]);

end;

end.
