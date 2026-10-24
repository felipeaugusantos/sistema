{************************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta Ppg *}
{*********************************************************************************AC*}
unit untGravandoExecucaoPpgCores;

interface

uses
  untAbstractGravandoExecucaoPpg, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgCores = class(TAbstractGravandoExecucaoPpg)
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

{ TGravandoExecucaoPpgCores }

procedure TGravandoExecucaoPpgCores.Executar(const gravando: IGravando);
var
  qryOrigem : TDataSet;
  qryDestino: IDataSet;
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
      TAutcomTintaFactory.Get.fInsereProCod('PPG_CADPPG');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      qryInsert := TAutcomTintaFactory.Get.fGetDataSet;

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


function TGravandoExecucaoPpgCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoPpgCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PPG_CADPPG WHERE FALSE;';
end;

function TGravandoExecucaoPpgCores.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := Format('SELECT * FROM [%s] WHERE UCase([Brand Description]) = ''%s'' ',
    [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]), AnsiUpperCase('PPG')]);
end;


procedure TGravandoExecucaoPpgCores.GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet);
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

procedure TGravandoExecucaoPpgCores.GravarRegistroMontadora(const qryOrigem : TDataSet; const qryDestino: IDataSet; const strCodMon: string);
var
  intCont  : Integer;
begin
  qryInsert := qryDestino;

  qryInsert.Close;
  qryInsert.SQL := GetSqlDestino;
  qryInsert.Open;

  qryInsert.Insert;
  qryInsert.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPG_CADPPG', TAutcomTintaFactory.Get.GetCodEmp);
  qryInsert.FieldByName('PPG_CODSEQ').AsString := TStrUtils.fStrZero(intAuto, 6);

  qryInsert.FieldByName('PPG_DESCOR').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Product Description').AsString)))));

  qryInsert.FieldByName('PPG_VEICUL').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Model').AsString)))));

  qryInsert.FieldByName('PPG_MONTAD').AsString := strCodMon;

  qryInsert.FieldByName('PPG_TIPO__').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Mixing Scheme Description').AsString)))));

  qryInsert.FieldByName('PPG_A_N_O_').AsString := qryOrigem.FieldByName('Initial Year').AsString;

  if (not TStrUtils.fEmptyStr(qryOrigem.FieldByName('Finish Year').AsString))
   And (StrToIntDef(qryOrigem.FieldByName('Finish Year').AsString, 0) > 0) then
  begin
    if not TStrUtils.fEmptyStr(qryInsert.FieldByName('PPG_A_N_O_').AsString) then
      qryInsert.FieldByName('PPG_A_N_O_').AsString := qryInsert.FieldByName('PPG_A_N_O_').AsString + '/';

    qryInsert.FieldByName('PPG_A_N_O_').AsString := qryInsert.FieldByName('PPG_A_N_O_').AsString + qryOrigem.FieldByName('Finish Year').AsString;
  end;

  qryInsert.FieldByName('PPG_CODCOR').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('OEM Color Code').AsString)))));

  qryInsert.FieldByName('PPG_CODATC').AsString := qryOrigem.FieldByName('UFID').AsString;

  qryInsert.FieldByName('PPG_UTILIZ').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Usage Description').AsString)))));

  qryInsert.FieldByName('PPG_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryInsert.FieldByName('PPG_ATIVO_').AsString := 'S';


  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString) then
      Break;

    qryInsert.FieldByName('PPG_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString :=
      qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString;

    qryInsert.FieldByName('PPG_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  :=
      qryOrigem.FieldByName('Amount of Grams/Prodct' + IntToStr(intCont)).AsFloat / 10;
  end;

  if (qryOrigem.FieldByName('Variant Description').AsString = qryOrigem.FieldByName('VariantCode').AsString) then
    qryInsert.FieldByName('PPG_VARIAN').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('Variant Description').AsString)))))
  else
    qryInsert.FieldByName('PPG_VARIAN').AsString := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('VariantCode').AsString + ' ' +
                                                    qryOrigem.FieldByName('Variant Description').AsString)))));


  qryInsert.FieldByName('PPG_MARCA_').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Brand Description').AsString)))));

  qryInsert.FieldByName('PPG_SISTEM').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Paint System').AsString)))));

  qryInsert.FieldByName('PPG_ORIGEM').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Source Type Description').AsString)))));

  qryInsert.FieldByName('PPG_PAISES').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Contry For Color Desc').AsString)))));

  qryInsert.FieldByName('PPG_EFEFIN').AsString :=
    Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Finish Effect Description').AsString)))));

  qryInsert.FieldByName('PPG_MD5KEY').AsString := GetMD5( qryInsert.FieldByName('PPG_DESCOR').AsString +
                                                          qryInsert.FieldByName('PPG_VEICUL').AsString +
                                                          qryInsert.FieldByName('PPG_TIPO__').AsString +
                                                          qryInsert.FieldByName('PPG_A_N_O_').AsString +
                                                          qryInsert.FieldByName('PPG_CODCOR').AsString +
                                                          qryInsert.FieldByName('PPG_CODATC').AsString +
                                                          qryInsert.FieldByName('PPG_VARIAN').AsString +
                                                          qryInsert.FieldByName('PPG_MARCA_').AsString +
                                                          qryInsert.FieldByName('PPG_UTILIZ').AsString +
                                                          qryInsert.FieldByName('PPG_SISTEM').AsString +
                                                          qryInsert.FieldByName('PPG_ORIGEM').AsString +
                                                          strCodMon);

  qryInsert.Post;

  Inc(intAuto);

end;

end.
