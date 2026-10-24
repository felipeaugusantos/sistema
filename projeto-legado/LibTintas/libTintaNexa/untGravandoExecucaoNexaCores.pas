{************************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta NEX *}
{*********************************************************************************AC*}
unit untGravandoExecucaoNexaCores;

interface

uses
  untAbstractGravandoExecucaoNexa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoNexaCores = class(TAbstractGravandoExecucaoNexa)
  private
    intAuto  : Integer;
    qryInsert: IDataSet;

    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
    procedure GravarRegistroMontadora(const qryOrigem: TDataSet; const qryDestino: IDataSet; const strCodMon: string);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;
  end;

implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoNexaCores }

procedure TGravandoExecucaoNexaCores.Executar(const gravando: IGravando);
var
  qryOrigem : TDataSet;
  qryDestino: IDataSet;
  qryDelete : IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Verificando path dos arquivos...';

      intAuto := 1;

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
      TAutcomTintaFactory.Get.fInsereProCod('NEX_CADNEX');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      qryInsert := TAutcomTintaFactory.Get.fGetDataSet;

      CarregarDados(gravando, qryOrigem, AnsiReplaceStr(fGetNomeArquivo, '"', ''), qryDestino);

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Dados carregados com sucesso...';


      gravando.Texto := 'Apagando os registros antigos da tabela de cores...';
      qryDelete := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelete.SQL := 'DELETE FROM NEX_CADNEX ';
      qryDelete.ExecSQL;


      gravando.Texto := 'Iniciando a geração do arquivo de cores...';
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

            GravarRegistro(qryOrigem, qryDestino);

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


function TGravandoExecucaoNexaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoNexaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM NEX_CADNEX WHERE FALSE;';
end;

function TGravandoExecucaoNexaCores.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := Format('SELECT * FROM [%s] WHERE UCase([Brand Description]) = ''%s'' ',
    [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]), AnsiUpperCase('PPG')]);
end;


procedure TGravandoExecucaoNexaCores.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
var
  stlMontadoras: TStringList;
  intMontadoras: Integer;
begin
  stlMontadoras := nil;
  Try
    Try
      stlMontadoras := TStringList.Create;

      stlMontadoras.CommaText :=
        Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Manufacturer Key Code').AsString)))));

      for intMontadoras := 0 to stlMontadoras.Count - 1 do
      begin
        GravarRegistroMontadora(qryOrigem, qryDestino, Trim(stlMontadoras[intMontadoras]));
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlMontadoras) then FreeAndNil(stlMontadoras);
  End;
end;

procedure TGravandoExecucaoNexaCores.GravarRegistroMontadora(const qryOrigem : TDataSet; const qryDestino: IDataSet; const strCodMon: string);
var
  intCont  : Integer;
begin
  qryInsert := qryDestino;

  qryInsert.Close;
  qryInsert.SQL := GetSqlDestino;
  qryInsert.Open;

  qryInsert.Insert;
  qryInsert.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('NEX_CADNEX', TAutcomTintaFactory.Get.GetCodEmp);
  qryInsert.FieldByName('NEX_CODSEQ').AsString := TStrUtils.fStrZero(intAuto, 6);

  qryInsert.FieldByName('NEX_DESCOR').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Product Description').AsString)))));

  qryInsert.FieldByName('NEX_VEICUL').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Model').AsString)))));

  qryInsert.FieldByName('NEX_MONTAD').AsString := strCodMon;

  qryInsert.FieldByName('NEX_TIPO__').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Mixing Scheme Description').AsString)))));

  qryInsert.FieldByName('NEX_A_N_O_').AsString := qryOrigem.FieldByName('Initial Year').AsString;

  if (not TStrUtils.fEmptyStr(qryOrigem.FieldByName('Finish Year').AsString))
   And (StrToIntDef(qryOrigem.FieldByName('Finish Year').AsString, 0) > 0) then
  begin
    if not TStrUtils.fEmptyStr(qryInsert.FieldByName('NEX_A_N_O_').AsString) then
      qryInsert.FieldByName('NEX_A_N_O_').AsString := qryInsert.FieldByName('NEX_A_N_O_').AsString + '/';

    qryInsert.FieldByName('NEX_A_N_O_').AsString := qryInsert.FieldByName('NEX_A_N_O_').AsString + qryOrigem.FieldByName('Finish Year').AsString;
  end;

  qryInsert.FieldByName('NEX_CODCOR').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('OEM Color Code').AsString)))));

  qryInsert.FieldByName('NEX_CODATC').AsString := qryOrigem.FieldByName('UFID').AsString;

  qryInsert.FieldByName('NEX_UTILIZ').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Usage Description').AsString)))));

  qryInsert.FieldByName('NEX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryInsert.FieldByName('NEX_ATIVO_').AsString := 'S';


  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString) then
      Break;

    qryInsert.FieldByName('NEX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString :=
      qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString;

    qryInsert.FieldByName('NEX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
      qryOrigem.FieldByName('Amount of Grams/Prodct' + IntToStr(intCont)).AsFloat / 10;
  end;

  if (qryOrigem.FieldByName('Variant Description').AsString = qryOrigem.FieldByName('VariantCode').AsString) then
    qryInsert.FieldByName('NEX_VARIAN').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('Variant Description').AsString)))))
  else
    qryInsert.FieldByName('NEX_VARIAN').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('VariantCode').AsString + ' ' +
                                                    qryOrigem.FieldByName('Variant Description').AsString)))));


  qryInsert.FieldByName('NEX_MARCA_').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Brand Description').AsString)))));

  qryInsert.FieldByName('NEX_SISTEM').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Paint System').AsString)))));

  qryInsert.FieldByName('NEX_ORIGEM').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Source Type Description').AsString)))));

  qryInsert.FieldByName('NEX_PAISES').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Contry For Color Desc').AsString)))));

  qryInsert.FieldByName('NEX_EFEFIN').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Finish Effect Description').AsString)))));

  qryInsert.FieldByName('NEX_MD5KEY').AsString := GetMD5( qryInsert.FieldByName('NEX_DESCOR').AsString +
                                                          qryInsert.FieldByName('NEX_VEICUL').AsString +
                                                          qryInsert.FieldByName('NEX_TIPO__').AsString +
                                                          qryInsert.FieldByName('NEX_A_N_O_').AsString +
                                                          qryInsert.FieldByName('NEX_CODCOR').AsString +
                                                          qryInsert.FieldByName('NEX_CODATC').AsString +
                                                          qryInsert.FieldByName('NEX_VARIAN').AsString +
                                                          qryInsert.FieldByName('NEX_MARCA_').AsString +
                                                          qryInsert.FieldByName('NEX_UTILIZ').AsString +
                                                          qryInsert.FieldByName('NEX_SISTEM').AsString +
                                                          qryInsert.FieldByName('NEX_ORIGEM').AsString +
                                                          strCodMon);

  qryInsert.Post;

  Inc(intAuto);

end;

end.
