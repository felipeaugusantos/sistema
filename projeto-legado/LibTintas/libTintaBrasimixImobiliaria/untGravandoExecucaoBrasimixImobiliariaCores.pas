{*************************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta BrasimixImobiliaria *}
{**********************************************************************************AC*}
unit untGravandoExecucaoBrasimixImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoBrasimixImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Classes;

type
  TGravandoExecucaoBrasimixImobiliariaCores = class(TAbstractGravandoExecucaoBrasimixImobiliaria)
  private
    intAutInc: Integer;

    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    procedure LimparTabelas;
    function GetFator(const strCodUni: string): Double;

    procedure pSelecionaProInc(strNomArq: String);
    procedure pIncrementaProInc;
    procedure pAtualizaProInc(strNomArq: String);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
    function GetDataSetDestino(): IDataSet; override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoBrasimixImobiliariaCores }

procedure TGravandoExecucaoBrasimixImobiliariaCores.LimparTabelas;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'TRUNCATE TABLE BZI_CADBZI';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

procedure TGravandoExecucaoBrasimixImobiliariaCores.pAtualizaProInc(strNomArq: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE PROINC ' +
                '   SET PRO_AUTINC = :AUTINC ' +
                ' WHERE PRO_NOMARQ = :NOMARQ ';
  qryGen.ParamByName('AUTINC').AsInteger := intAutInc;
  qryGen.ParamByName('NOMARQ').AsString  := strNomArq;
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoBrasimixImobiliariaCores.pIncrementaProInc;
begin
  intAutInc := intAutInc + 1;
end;

procedure TGravandoExecucaoBrasimixImobiliariaCores.pSelecionaProInc(strNomArq: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(PRO_AUTINC,0) AS AUTINC FROM PROINC WHERE PRO_NOMARQ = :NOMARQ';
  qryGen.ParamByName('NOMARQ').AsString := strNomArq;
  qryGen.Open;

  intAutInc := qryGen.FieldByName('AUTINC').AsInteger;
end;

procedure TGravandoExecucaoBrasimixImobiliariaCores.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Limpando tabela de formulação...';
      LimparTabelas;
      gravando.Texto := 'Tabela limpa com sucesso...';

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
      TAutcomTintaFactory.Get.fInsereProCod('BZI_CADBZI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      pSelecionaProInc('BZI_CADBZI');

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
          pIncrementaProInc;
          qryOrigem.Next;
          gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
        End;
      end;

      pAtualizaProInc('BZI_CADBZI');

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    //
  End;
end;

function TGravandoExecucaoBrasimixImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoBrasimixImobiliariaCores.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
end;

function TGravandoExecucaoBrasimixImobiliariaCores.GetFator(
  const strCodUni: string): Double;
begin
  Result := 1;
  if strCodUni = 'LA' then
    Result := 1
  else if strCodUni = 'GL' then
    Result := 1 / 5
  else if strCodUni = 'LT' then
    Result := 1 / 20;
end;

function TGravandoExecucaoBrasimixImobiliariaCores.GetSqlDestino: string;
begin
  Result := TAutcomTintaFactory.Get.GetInsert('BZI_CADBZI');
end;

function TGravandoExecucaoBrasimixImobiliariaCores.GetSqlOrigem(
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
      ' UNION                ' +
      ' SELECT               ' +
      '   T.*                ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS CODUNI ' +
      ' FROM                 ' +
      '   [%s] AS T          ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TGravandoExecucaoBrasimixImobiliariaCores.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
var
  intCont: Integer;
begin

  qryDestino.SQL := GetSqlDestino;

  qryDestino.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.GetCodEmp + TStrUtils.fStrZero(IntToStr(intAutInc) + TAutcomTintaFactory.Get.GetCodEmp, 17); //TAutcomTintaFactory.Get.fRetAutoIncrem('BZI_CADBZI', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.ParamByName('BZI_CODIGO').AsString   := Trim(AnsiUpperCase(LeftStr(qryOrigem.FieldByName('IDREGISTRO').AsString, 10)));
  qryDestino.ParamByName('BZI_GRUPRO').AsString   := Trim(AnsiUpperCase(RightStr(qryOrigem.FieldByName('IDREGISTRO').AsString, 3))) + '-' + Trim(AnsiUpperCase(qryOrigem.FieldByName('CATALOGO').AsString));
  qryDestino.ParamByName('BZI_DESCRI').AsString   := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('DESBAS').AsString)));
  qryDestino.ParamByName('BZI_REFERE').AsString   := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('REFERE').AsString)));
  qryDestino.ParamByName('BZI_UNIDAD').AsString   := qryOrigem.FieldByName('CODUNI').AsString;
  qryDestino.ParamByName('BZI_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.ParamByName('BZI_DTACAD').AsDateTime := Date;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(qryOrigem.FieldByName('FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
      Break;

    if TAutcomTintaFactory.Get.fStrToFloat(qryOrigem.FieldByName('QTD' + TStrUtils.fStrZero(intCont, 2)).AsString) <= 0 then
      Break;

    qryDestino.ParamByName('BZI_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := qryOrigem.FieldByName('FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;
    qryDestino.ParamByName('BZI_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(qryOrigem.FieldByName('QTD' + TStrUtils.fStrZero(intCont, 2)).AsString) *
                                                                                      GetFator(qryOrigem.FieldByName('CODUNI').AsString) / 100;
  end;

  qryDestino.ParamByName('BZI_LINHA_').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString)));
  qryDestino.ParamByName('BZI_CODBAS').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(qryOrigem.FieldByName('BASE').AsString)));
  qryDestino.ParamByName('BZI_CODUNI').AsString := qryOrigem.FieldByName('CODUNI').AsString;
  qryDestino.ParamByName('BZI_MD5KEY').AsString := GetMD5(qryDestino.ParamByName('BZI_CODIGO').AsString +
                                                          qryDestino.ParamByName('BZI_DESCRI').AsString +
                                                          qryDestino.ParamByName('BZI_REFERE').AsString +
                                                          qryDestino.ParamByName('BZI_UNIDAD').AsString +
                                                          qryDestino.ParamByName('BZI_LINHA_').AsString +
                                                          qryDestino.ParamByName('BZI_CODBAS').AsString +
                                                          qryDestino.ParamByName('BZI_CODUNI').AsString);
  qryDestino.ParamByName('BZI_ATIVAD').AsString := 'S';

  qryDestino.ExecSQL;
end;

function TGravandoExecucaoBrasimixImobiliariaCores.IsRegistroExistente(
  const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

end.
