unit untProcessadorGravandoNexaCores;

interface

uses
  untAbstractProcessadorGravandoPpg, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, untFuncoesSimples, StrUtils, untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoNexaCores = class(TAbstractProcessadorGravandoPpg, IProcessadorGravandoExecucaoArquivosInsert)
  private
    intAuto: Integer;
    qryCadMon: TUniQuery;
    dicCadMon: TDicionario;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    procedure GravarRegistroMontadora(const qryOrigem: TDataSet; const qryDestino: TDataSet; const strCodMon: string);
    function GetMonDescri(const strCodMon: string): string;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
    constructor Create(); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  untDDLFactory, untFuncTinta;

{ TProcessadorGravandoPpgCores }

constructor TProcessadorGravandoNexaCores.Create;
begin
  inherited Create('NEX', 'PATNEXA', 'NEXA AUTOCOLOR');
  intAuto := 0;
  Self.qryCadMon := nil;
  Self.dicCadMon := TDicionario.Create;
end;

destructor TProcessadorGravandoNexaCores.Destroy;
begin
  pAtualizaProCodAutInc('NEX_CADNEX', intAuto);
  if Assigned(qryCadMon) then FreeAndNil(qryCadMon);
  if Assigned(dicCadMon) then FreeAndNil(dicCadMon);
  inherited;
end;

function TProcessadorGravandoNexaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoNexaCores.GetMonDescri(const strCodMon: string): string;
var
  varResult: Variant;
begin
  Result := '';
  varResult := dicCadMon[strCodMon];
  if VarIsNull(varResult) then
  begin
    if not Assigned(qryCadMon) then
    begin
      qryCadMon := fCriaQuery();
      qryCadMon.SQL.Text := 'SELECT MON_CODMON, MON_DESCRI FROM NEX_CADMON ORDER BY MON_CODMON';
      qryCadMon.Open;
    end;

    if qryCadMon.Locate('MON_CODMON', VarArrayOf([strCodMon]), []) then
    begin
      Result := qryCadMon.FieldByName('MON_DESCRI').AsString;
      dicCadMon[strCodMon] := Result;
    end;
  end
  else
    Result := varResult;
end;

function TProcessadorGravandoNexaCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('NEX_CADNEX');
end;

function TProcessadorGravandoNexaCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;  
begin
  Result := Format('SELECT DISTINCT * FROM [%s] WHERE UCase([Brand Description]) = ''%s'' ',
    [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]), AnsiUpperCase(strMarca)]);
end;

procedure TProcessadorGravandoNexaCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'NEX_CADNEX';
end;

procedure TProcessadorGravandoNexaCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  stlMontadoras: TStringList;
  intMontadoras: Integer;
begin
  stlMontadoras := nil;
  Try
    Try
      stlMontadoras := TStringList.Create;
      stlMontadoras.CommaText := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Manufacturer Key Code').AsString)))));

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

procedure TProcessadorGravandoNexaCores.GravarRegistroMontadora(const qryOrigem, qryDestino: TDataSet; const strCodMon: string);
var
  qryInsert: TUniQuery;
  intCont: Integer;
begin
  qryInsert := TUniQuery(qryDestino);
  qryInsert.SQL.Clear;
  qryInsert.Params.Clear;
  qryInsert.SQL.Text := GetSqlDestino;

  qryInsert.ParamByName('AUTOINCREM').AsString := fFormataAutInc(fInc(intAuto), VS_strCodEmp);
  qryInsert.ParamByName('NEX_CODSEQ').AsString := fStrZero(intAuto, 6);
  qryInsert.ParamByName('NEX_DESCOR').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Product Description').AsString)))));
  qryInsert.ParamByName('NEX_VEICUL').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Model').AsString)))));
  qryInsert.ParamByName('NEX_MONTAD').AsString := strCodMon;
  qryInsert.ParamByName('NEX_TIPO__').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Mixing Scheme Description').AsString)))));

  qryInsert.ParamByName('NEX_A_N_O_').AsString := qryOrigem.FieldByName('Initial Year').AsString;
  if (not fEmptyStr(qryOrigem.FieldByName('Finish Year').AsString)) and (StrToIntDef(qryOrigem.FieldByName('Finish Year').AsString, 0) > 0) then
  begin
    if not fEmptyStr(qryInsert.ParamByName('NEX_A_N_O_').AsString) then
      qryInsert.ParamByName('NEX_A_N_O_').AsString := qryInsert.ParamByName('NEX_A_N_O_').AsString + '/';

    qryInsert.ParamByName('NEX_A_N_O_').AsString := qryInsert.ParamByName('NEX_A_N_O_').AsString + qryOrigem.FieldByName('Finish Year').AsString;
  end;

  qryInsert.ParamByName('NEX_CODCOR').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('OEM Color Code').AsString)))));
  qryInsert.ParamByName('NEX_CODATC').AsString := qryOrigem.FieldByName('UFID').AsString;
  qryInsert.ParamByName('NEX_UTILIZ').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Usage Description').AsString)))));
  qryInsert.ParamByName('NEX_CODEMP').AsString := VS_strCodEmp;


  for intCont := 1 to 20 do
  begin
    if fEmptyStr(qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString) then
      Break;

    qryInsert.ParamByName('NEX_CODB' + fStrZero(intCont, 2)).AsString := qryOrigem.FieldByName('Product' + IntToStr(intCont) + ' Code').AsString;
    qryInsert.ParamByName('NEX_QTDB' + fStrZero(intCont, 2)).AsFloat := qryOrigem.FieldByName('Amount of Grams/Prodct' + IntToStr(intCont)).AsFloat / 10;
  end;

  if (qryOrigem.FieldByName('Variant Description').AsString = qryOrigem.FieldByName('VariantCode').AsString) then
    qryInsert.ParamByName('NEX_VARIAN').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('Variant Description').AsString)))))
  else
    qryInsert.ParamByName('NEX_VARIAN').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(
                                                    AnsiString(qryOrigem.FieldByName('VariantCode').AsString + ' ' +
                                                    qryOrigem.FieldByName('Variant Description').AsString)))));


  qryInsert.ParamByName('NEX_MARCA_').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Brand Description').AsString)))));
  qryInsert.ParamByName('NEX_SISTEM').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Paint System').AsString)))));
  qryInsert.ParamByName('NEX_ORIGEM').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Source Type Description').AsString)))));
  qryInsert.ParamByName('NEX_PAISES').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Contry For Color Desc').AsString)))));
  qryInsert.ParamByName('NEX_EFEFIN').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Finish Effect Description').AsString)))));

  qryInsert.ParamByName('NEX_SISTEM').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Paint System').AsString)))));
  qryInsert.ParamByName('NEX_ORIGEM').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Source Type Description').AsString)))));
  qryInsert.ParamByName('NEX_MD5KEY').AsString := GetMD5(qryInsert.ParamByName('NEX_DESCOR').AsString +
                                                    qryInsert.ParamByName('NEX_VEICUL').AsString +
                                                    qryInsert.ParamByName('NEX_TIPO__').AsString +
                                                    qryInsert.ParamByName('NEX_A_N_O_').AsString +
                                                    qryInsert.ParamByName('NEX_CODCOR').AsString +
                                                    qryInsert.ParamByName('NEX_CODATC').AsString +
                                                    qryInsert.ParamByName('NEX_VARIAN').AsString +
                                                    qryInsert.ParamByName('NEX_MARCA_').AsString +
                                                    qryInsert.ParamByName('NEX_UTILIZ').AsString +
                                                    qryInsert.ParamByName('NEX_SISTEM').AsString +
                                                    qryInsert.ParamByName('NEX_ORIGEM').AsString +
                                                    strCodMon);

  qryInsert.ExecSQL;
end;

function TProcessadorGravandoNexaCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoNexaCores.LimparTabelas;
begin
  TruncateTable('NEX_CADNEX');
end;

procedure TProcessadorGravandoNexaCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem,
  qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a cor %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s - %s [%s: %s]',[
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('UFID').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Brand Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('OEM Color Code').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Product Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Mixing Scheme Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Manufacturer Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Model').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Contry For Color Desc').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Finish Effect Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Paint System').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('VariantCode').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Variant Description').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Initial Year').AsString)))))
    , Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('Finish Year').AsString)))))
    , E.ClassName, E.Message 
  ]);
end;

end.
