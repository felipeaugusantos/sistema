unit untLucreePgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTRedeCard, System.Generics.Collections, Json;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaLucreePgto = Array Of TEstruturaPgto;

  TLucreeRegistroPgto = class
    private
    public
      total_registros,
      total_liquido,
      total_bruto,
      total_desconto,
      paginas,
      pagina,
      total_credito,
      total_parcelado,
      total_debito,
      total_bruto_credito,
      total_bruto_parcelado,
      total_bruto_debito,
      total_cedido,
      nsu,
      autorizacao,
      data_pagamento,
      data_transacao,
      data_agendado,
      valor_bruto,
      valor_liquido,
      valor_transacao,
      valor_desconto,
      modalidade,
      status,
      bandeira,
      parcela,
      qtd_parcelas,
      terminal,
      split_porcentual,
      split_cliente,
      split_agente,
      entrada : String;
  end;

  TLucreePgto = Class(TInterfacedObject, ICartoes)
  Private
    FLucreeRegistrosPgto: TList<TLucreeRegistroPgto>;

    FImportouRegistro,
    FImportouPagamento: Boolean;
    FPaginas: String;

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
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaLucreePgto;

    property Paginas: String read FPaginas;

    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;
    property TipoDoArquivo: String read FTipoDoArquivo write FTipoDoArquivo;
  End;

  Var
    NomeArquivo,
    DataArquivo: String;

implementation

uses untFuncoes, untIDataSet;

{ TLucreePgto }

function TLucreePgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TLucreePgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;

  FLucreeRegistrosPgto := TList<TLucreeRegistroPgto>.Create;
end;

class function TLucreePgto.fRetEstruturaPgto(
  strTabela: String): TArrEstruturaLucreePgto;
begin
  If strTabela = 'LUC_LUPGTO' Then
  Begin
    SetLength(Result, 20);

    Result[0].strDescri   := 'LUC_NUMNSU'; Result[0].strTipCmp   := 'VARCHAR(100)';
    Result[1].strDescri   := 'LUC_DTAIMP'; Result[1].strTipCmp   := 'DATE';
    Result[2].strDescri   := 'LUC_DTAEFE'; Result[2].strTipCmp   := 'DATE';
    Result[3].strDescri   := 'LUC_AUTORI'; Result[3].strTipCmp   := 'VARCHAR(40)';
    Result[4].strDescri   := 'LUC_DTAPGT'; Result[4].strTipCmp   := 'DATE';
    Result[5].strDescri   := 'LUC_DTATRA'; Result[5].strTipCmp   := 'DATE';
    Result[6].strDescri   := 'LUC_DTAAGE'; Result[6].strTipCmp   := 'DATE';

    Result[7].strDescri   := 'LUC_VBRUTO'; Result[7].strTipCmp   := 'DECIMAL(15,2)';
    Result[8].strDescri   := 'LUC_VLIQUI'; Result[8].strTipCmp   := 'DECIMAL(15,2)';
    Result[9].strDescri   := 'LUC_VTRANS'; Result[8].strTipCmp   := 'DECIMAL(15,2)';
    Result[10].strDescri  := 'LUC_VDESCO'; Result[10].strTipCmp  := 'DECIMAL(15,2)';

    Result[11].strDescri  := 'LUC_MODALI'; Result[11].strTipCmp  := 'VARCHAR(100)';
    Result[12].strDescri  := 'LUC_STATUS'; Result[12].strTipCmp  := 'VARCHAR(40)';
    Result[13].strDescri  := 'LUC_BANDEI'; Result[13].strTipCmp  := 'VARCHAR(40)';

    Result[14].strDescri  := 'LUC_QTDPAR'; Result[14].strTipCmp  := 'INT DEFAULT 1';
    Result[15].strDescri  := 'LUC_PARCEL'; Result[15].strTipCmp  := 'INT DEFAULT 1';

    Result[16].strDescri  := 'LUC_TERMIN'; Result[16].strTipCmp  := 'VARCHAR(40)';
    Result[17].strDescri  := 'LUC_ENTRAD'; Result[17].strTipCmp  := 'VARCHAR(60)';


    Result[18].strDescri  := 'LUC_CONCIL'; Result[18].strTipCmp := 'INT DEFAULT 0';
    Result[19].strDescri  := 'LUC_CODAUT'; Result[19].strTipCmp := 'VARCHAR(100)';
  End;
end;

class function TLucreePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaLucreePgto;
    intCont  : Integer;
begin
  If strTabela.IsEmpty Then
    Exit('');

  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  If strTabela = 'LUC_LUPGTO' Then
    Result := Result + ' PRIMARY KEY(LUC_NUMNSU,LUC_AUTORI,LUC_DTATRA,LUC_PARCEL))) ENGINE INNODB ';

end;

procedure TLucreePgto.ImportaPagamentos(strString: String);
  Var
    LRegistro: TLucreeRegistroPgto;
    LJsonObject: TJsonObject;
    LJsonArrayRecebimento :TJSONArray;
    LJsonValueContent: TJsonValue;
begin

  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    LJsonArrayRecebimento := LJsonObject.GetValue('recebimentos') as TJsonArray;
    FPaginas  :=RetornaValorJson(LJsonObject,'paginas');

    For LJsonValueContent In LJsonArrayRecebimento Do
    Begin
        LRegistro := TLucreeRegistroPgto.Create;

        LRegistro.total_registros       := RetornaValorJson(LJsonObject,'total_registros');
        LRegistro.total_liquido         := RetornaValorJson(LJsonObject,'total_liquido');
        LRegistro.total_bruto           := RetornaValorJson(LJsonObject,'total_bruto');
        LRegistro.total_desconto        := RetornaValorJson(LJsonObject,'total_desconto');
        LRegistro.paginas               := RetornaValorJson(LJsonObject,'paginas');
        LRegistro.pagina                := RetornaValorJson(LJsonObject,'pagina');
        LRegistro.total_credito         := RetornaValorJson(LJsonObject,'total_credito');
        LRegistro.total_parcelado       := RetornaValorJson(LJsonObject,'total_parcelado');
        LRegistro.total_debito          := RetornaValorJson(LJsonObject,'total_debito');
        LRegistro.total_bruto_credito   := RetornaValorJson(LJsonObject,'total_bruto_credito');
        LRegistro.total_bruto_parcelado := RetornaValorJson(LJsonObject,'total_bruto_parcelado');
        LRegistro.total_bruto_debito    := RetornaValorJson(LJsonObject,'total_bruto_debito');
        LRegistro.total_cedido          := RetornaValorJson(LJsonObject,'total_cedido');

        LRegistro.nsu             := RetornaValorJson(LJsonValueContent,'nsu');
        LRegistro.autorizacao     := RetornaValorJson(LJsonValueContent,'autorizacao');
        LRegistro.data_pagamento  := RetornaValorJson(LJsonValueContent,'data_pagamento');
        LRegistro.data_transacao  := RetornaValorJson(LJsonValueContent,'data_transacao');
        LRegistro.data_agendado   := RetornaValorJson(LJsonValueContent,'data_agendado');

        LRegistro.valor_bruto     := RetornaValorJson(LJsonValueContent,'valor_bruto').Replace('.',',');
        LRegistro.valor_liquido   := RetornaValorJson(LJsonValueContent,'valor_liquido').Replace('.',',');
        LRegistro.valor_transacao := RetornaValorJson(LJsonValueContent,'valor_transacao').Replace('.',',');
        LRegistro.valor_desconto  := RetornaValorJson(LJsonValueContent,'valor_desconto').Replace('.',',');


        LRegistro.modalidade      := RetornaValorJson(LJsonValueContent,'modalidade');
        LRegistro.status          := RetornaValorJson(LJsonValueContent,'status');
        LRegistro.bandeira        := RetornaValorJson(LJsonValueContent,'bandeira');
        LRegistro.parcela         := RetornaValorJson(LJsonValueContent,'parcela');
        LRegistro.qtd_parcelas    := RetornaValorJson(LJsonValueContent,'qtd_parcelas');
        LRegistro.terminal        := RetornaValorJson(LJsonValueContent,'terminal');
        LRegistro.split_porcentual:= RetornaValorJson(LJsonValueContent,'split_porcentual');
        LRegistro.split_cliente   := RetornaValorJson(LJsonValueContent,'split_cliente');
        LRegistro.split_agente    := RetornaValorJson(LJsonValueContent,'split_agente');
        LRegistro.entrada         := RetornaValorJson(LJsonValueContent,'entrada');

        FLucreeRegistrosPgto.Add(LRegistro);
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TLucreePgto.pAdicionaLinha(strString: String);
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

procedure TLucreePgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;

    LSQL: String;

    LRegistro: TLucreeRegistroPgto;

begin
  LSQL := RetornaSQLReplaceTabela('LUC_LUPGTO');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FLucreeRegistrosPgto.Count;

  For LRegistro In FLucreeRegistrosPgto Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;

      LDados.ParamByName('LUC_NUMNSU').Value := CorrigeDadosBanco(LRegistro.nsu);
      LDados.ParamByName('LUC_CODAUT').Value := CorrigeDadosBanco(LRegistro.autorizacao);
      LDados.ParamByName('LUC_DTAIMP').Value := Date;
      LDados.ParamByName('LUC_DTAEFE').Value := CorrigeDadosBanco(LRegistro.data_transacao);
      LDados.ParamByName('LUC_AUTORI').Value := CorrigeDadosBanco(LRegistro.autorizacao);
      LDados.ParamByName('LUC_DTAPGT').Value := CorrigeDadosBanco(LRegistro.data_pagamento);
      LDados.ParamByName('LUC_DTATRA').Value := CorrigeDadosBanco(LRegistro.data_transacao);
      LDados.ParamByName('LUC_DTAAGE').Value := CorrigeDadosBanco(LRegistro.data_agendado);

      LDados.ParamByName('LUC_VBRUTO').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.valor_bruto));
      LDados.ParamByName('LUC_VLIQUI').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.valor_liquido));
      LDados.ParamByName('LUC_VTRANS').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.valor_transacao));
      LDados.ParamByName('LUC_VDESCO').Value := CorrigeDadosBanco(fStrToFloat(LRegistro.valor_desconto));

      LDados.ParamByName('LUC_MODALI').Value := CorrigeDadosBanco(LRegistro.modalidade);
      LDados.ParamByName('LUC_STATUS').Value := CorrigeDadosBanco(LRegistro.status);
      LDados.ParamByName('LUC_BANDEI').Value := CorrigeDadosBanco(LRegistro.bandeira);

      LDados.ParamByName('LUC_QTDPAR').Value := CorrigeDadosBanco(LRegistro.qtd_parcelas);
      LDados.ParamByName('LUC_PARCEL').Value := CorrigeDadosBanco(LRegistro.parcela);
      LDados.ParamByName('LUC_TERMIN').Value := CorrigeDadosBanco(LRegistro.terminal);
      LDados.ParamByName('LUC_ENTRAD').Value := CorrigeDadosBanco(LRegistro.entrada);


      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

end;

function TLucreePgto.RetornaSQLReplaceTabela(ATabela: String): String;
  Var
    LCampos: TArrEstruturaLucreePgto;

    LContador: Integer;
begin
  Result := 'REPLACE INTO ' + ATabela + ' (';

  LCampos := fRetEstruturaPgto(ATabela);

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <>  'LUC_CONCIL') Then
      Result := Result + LCampos[LContador].strDescri + ',';
  End;

  Result := Copy(Result, 1, Length(Result) - 1) + ') VALUES (';

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <> 'LUC_CONCIL') Then
      Result := Result + ':' + LCampos[LContador].strDescri + ',';
  End;
  Result := Copy(Result, 1, Length(Result) - 1) + ')';

end;



function TLucreePgto.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TLucreePgto.RetornaValorJson(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  Result := '';
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

end.
