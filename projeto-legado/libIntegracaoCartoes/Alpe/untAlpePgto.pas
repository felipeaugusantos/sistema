unit untAlpePgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTRedeCard, System.Generics.Collections, Json;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaAlpePgto = Array Of TEstruturaPgto;

  TAlpeRegistroPgto = class
    private
    public
      id,
      resource,
      instant,
      duration,
      status,
      effectiveDate,
      amountAll,
      bankAccount,
      bankAgency,
      bankNumber,
      amount,
      creationDate,
      identificationNumber,
      cessionNumber,
      referenceNumber: String;
  end;

  TAlpePgto = Class(TInterfacedObject, ICartoes)
  Private
    FAlpeRegistrosPgto: TList<TAlpeRegistroPgto>;

    FImportouRegistro,
    FImportouPagamento: Boolean;


    FTipoDoArquivo: String;

    function CorrigeDadosBanco(AValor: Variant): Variant;

    function RetornaSQLReplaceTabela(ATabela: String): String;

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String): String; Overload;
    function RetornaValorJson(AObjeto: TJsonValue; ANomeCampo: String): String; Overload;

    procedure ImportaPagamentos(strString: String);

  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaAlpePgto;

    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;
    property TipoDoArquivo: String read FTipoDoArquivo write FTipoDoArquivo;
  End;

  Var
    NomeArquivo,
    DataArquivo: String;

implementation

uses untFuncoes, untIDataSet;

{ TAlpePgto }

function TAlpePgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TAlpePgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;

  FAlpeRegistrosPgto := TList<TAlpeRegistroPgto>.Create;
end;

class function TAlpePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaAlpePgto;
Begin
  If strTabela = 'ALP_ALPGTO' Then
  Begin
    SetLength(Result, 16);

    Result[0].strDescri  := 'ALP_COD_ID'; Result[0].strTipCmp  := 'VARCHAR(100)';
    Result[1].strDescri  := 'ALP_RECURS'; Result[1].strTipCmp  := 'VARCHAR(100)';
    Result[2].strDescri  := 'ALP_DTAIMP'; Result[2].strTipCmp  := 'DATE';
    Result[3].strDescri  := 'ALP_HORDUR'; Result[3].strTipCmp  := 'VARCHAR(15)';
    Result[4].strDescri  := 'ALP_STATUS'; Result[4].strTipCmp  := 'VARCHAR(15)';

    Result[5].strDescri  := 'ALP_DTAEFE'; Result[5].strTipCmp  := 'DATE';
    Result[6].strDescri  := 'ALP_TOTPAG'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := 'ALP_CTABAN'; Result[7].strTipCmp  := 'VARCHAR(10)';
    Result[8].strDescri  := 'ALP_AGEBAN'; Result[8].strTipCmp  := 'VARCHAR(10)';
    Result[9].strDescri  := 'ALP_CODBCO'; Result[9].strTipCmp  := 'CHAR(3)';


    Result[10].strDescri  := 'ALP_VALPAG'; Result[10].strTipCmp  := 'DECIMAL(15,2)';
    Result[11].strDescri  := 'ALP_DTACRI'; Result[11].strTipCmp  := 'DATE';
    Result[12].strDescri  := 'ALP_NUMIDE'; Result[12].strTipCmp  := 'VARCHAR(100)';
    Result[13].strDescri  := 'ALP_CODAUT'; Result[13].strTipCmp  := 'VARCHAR(40)';
    Result[14].strDescri  := 'ALP_REFNUM'; Result[14].strTipCmp  := 'VARCHAR(100)';

    Result[15].strDescri  := 'ALP_CONCIL'; Result[15].strTipCmp := 'INT DEFAULT 0';
  End;

End;

class function TAlpePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaAlpePgto;
    intCont  : Integer;
begin
  If strTabela.IsEmpty Then
    Exit('');

  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  If strTabela = 'ALP_ALPGTO' Then
    Result := Result + ' PRIMARY KEY(ALP_DTAEFE,ALP_CODAUT,ALP_VALPAG,ALP_NUMIDE)) ENGINE INNODB ';
End;


procedure TAlpePgto.ImportaPagamentos(strString: String);
  Var
    LRegistro: TAlpeRegistroPgto;
    LJsonObject,
    LJsonObjectValue: TJsonObject;
    LJsonArrayContent,
    LJsonArrayTransaction: TJSONArray;
    LJsonValueContent,
    LJsonValueTransaction: TJsonValue;
begin

  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    LJsonArrayContent := LJsonObject.GetValue('content') as TJsonArray;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

      LJsonArrayTransaction :=  LJsonObjectValue.GetValue('transactions') as TJsonArray;

      For LJsonValueTransaction In LJsonArrayTransaction Do
      Begin
        LRegistro := TAlpeRegistroPgto.Create;


        LRegistro.id       := RetornaValorJson(LJsonObject,'id');
        LRegistro.resource := RetornaValorJson(LJsonObject,'resource');
        LRegistro.instant  := RetornaValorJson(LJsonObject,'instant');
        LRegistro.duration := RetornaValorJson(LJsonObject,'duration');
        LRegistro.status   := RetornaValorJson(LJsonObject,'status');

        LRegistro.effectiveDate := RetornaValorJson(LJsonValueContent,'effectiveDate');
        LRegistro.amountAll     := RetornaValorJson(LJsonValueContent,'amount').Replace('.',',');
        LRegistro.bankAccount   := RetornaValorJson(LJsonValueContent,'bankAccount');
        LRegistro.bankAgency    := RetornaValorJson(LJsonValueContent,'bankAgency');
        LRegistro.bankNumber    := RetornaValorJson(LJsonValueContent,'bankNumber');

        LRegistro.amount               := RetornaValorJson(LJsonValueTransaction,'amount').Replace('.',',');
        LRegistro.creationDate         := RetornaValorJson(LJsonValueTransaction,'creationDate');
        LRegistro.identificationNumber := RetornaValorJson(LJsonValueTransaction,'identificationNumber');
        LRegistro.cessionNumber        := RetornaValorJson(LJsonValueTransaction,'cessionNumber');
        LRegistro.referenceNumber      := RetornaValorJson(LJsonValueTransaction,'referenceNumber');

        FAlpeRegistrosPgto.Add(LRegistro);
      End;

    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TAlpePgto.pAdicionaLinha(strString: String);
begin

  If strString.Trim.IsEmpty Then
    Exit;

  Try

    If FTipoDoArquivo = 'PAGAMENTOS' Then
    Begin
      ImportaPagamentos(strString);
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TAlpePgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;

    LSQL: String;

    LRegistro: TAlpeRegistroPgto;

begin
  LSQL := RetornaSQLReplaceTabela('ALP_ALPGTO');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FAlpeRegistrosPgto.Count;

  For LRegistro In FAlpeRegistrosPgto Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;

      LDados.ParamByName('ALP_COD_ID').Value := CorrigeDadosBanco(LRegistro.id);
      LDados.ParamByName('ALP_RECURS').Value := CorrigeDadosBanco(LRegistro.resource);
      LDados.ParamByName('ALP_DTAIMP').Value := Date;
      LDados.ParamByName('ALP_HORDUR').Value := CorrigeDadosBanco(LRegistro.duration);
      LDados.ParamByName('ALP_STATUS').Value := CorrigeDadosBanco(LRegistro.status);

      LDados.ParamByName('ALP_DTAEFE').Value := CorrigeDadosBanco(Copy(LRegistro.effectiveDate,1,10));
      LDados.ParamByName('ALP_TOTPAG').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.amountAll));
      LDados.ParamByName('ALP_CTABAN').Value := CorrigeDadosBanco(LRegistro.bankAccount);
      LDados.ParamByName('ALP_AGEBAN').Value := CorrigeDadosBanco(LRegistro.bankAgency);
      LDados.ParamByName('ALP_CODBCO').Value := CorrigeDadosBanco(LRegistro.bankNumber);

      LDados.ParamByName('ALP_VALPAG').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.amount));
      LDados.ParamByName('ALP_DTACRI').Value := CorrigeDadosBanco(LRegistro.creationDate);
      LDados.ParamByName('ALP_NUMIDE').Value := CorrigeDadosBanco(LRegistro.identificationNumber);
      LDados.ParamByName('ALP_CODAUT').Value := CorrigeDadosBanco(LRegistro.cessionNumber);
      LDados.ParamByName('ALP_REFNUM').Value := CorrigeDadosBanco(LRegistro.referenceNumber);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

end;

function TAlpePgto.RetornaSQLReplaceTabela(ATabela: String): String;
  Var
    LCampos: TArrEstruturaAlpePgto;

    LContador: Integer;
begin
  Result := 'REPLACE INTO ' + ATabela + ' (';

  LCampos := fRetEstruturaPgto(ATabela);

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <>  'ALP_CONCIL') Then
      Result := Result + LCampos[LContador].strDescri + ',';
  End;

  Result := Copy(Result, 1, Length(Result) - 1) + ') VALUES (';

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <> 'ALP_CONCIL') Then
      Result := Result + ':' + LCampos[LContador].strDescri + ',';
  End;
  Result := Copy(Result, 1, Length(Result) - 1) + ')';
end;

function TAlpePgto.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TAlpePgto.RetornaValorJson(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  Result := '';
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;


end.
