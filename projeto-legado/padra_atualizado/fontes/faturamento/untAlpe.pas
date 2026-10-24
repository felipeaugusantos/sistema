unit untAlpe;

interface

uses
  Data.DB, MemDS, DBAccess, Uni, System.SysUtils;

type

  TAlpe = class
  private
    FstrEspDoc: String;
    FstrNumDoc: String;
    FstrNumPok: String;
    FstrTipRec: String;
    FstrCodEmp: String;
    FstrCodCli: String;

    procedure SetstrCodEmp(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrNumPok(const Value: String);
    procedure SetstrTipRec(const Value: String);
    procedure SetstrCodCli(const Value: String);
  public
    property strTipRec: String read FstrTipRec write SetstrTipRec;
    property strNumPok: String read FstrNumPok write SetstrNumPok;
    property strNumDoc: String read FstrNumDoc write SetstrNumDoc;
    property strEspDoc: String read FstrEspDoc write SetstrEspDoc;
    property strCodEmp: String read FstrCodEmp write SetstrCodEmp;
    property strCodCli: String read FstrCodCli write SetstrCodCli;

    procedure pCarregaPedidoAlpe(strNumDoc, strEspDoc, strCodEmp: string);
    class function fPedidoAlpe(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
    class function fPossuiAdiantamentoAlpe(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
    function fCancelaAdtCliMovCarAlpe(strNomFrm: String): Boolean;
    function fVerificaEstrutura: Boolean;
  end;

implementation

uses
untFuncoesSimples, untAdiantamentoCliente, untTypesSistema;

{ TAlpe }

function TAlpe.fCancelaAdtCliMovCarAlpe(strNomFrm: String): Boolean;
var
  qryAlpe: TUniQuery;
begin
  Result := True;

  qryAlpe := fCriaQuery;
  try
    try

      qryAlpe.Close;
      qryAlpe.SQL.Text :=
     ' SELECT SQL_NO_CACHE '+
      '   * '+
      ' FROM '+
      '   MOVCAR '+
      ' WHERE '+
      '   UPPER(MCA_NUMCCD) = :NUMCCD';

      qryAlpe.ParamByName('NUMCCD').AsString := UpperCase(Self.strNumPok);

      qryAlpe.Open;

      if not qryAlpe.IsEmpty then
      begin
        fVerificaIntegridade(strNomFrm, 'MOVCAR', qryAlpe);


        fExecutaSQL( 'DELETE '+
                     ' FROM '+
                     '   MOVCAR '+
                     ' WHERE '+
                     '   UPPER(MCA_NUMCCD) = ' + QuotedStr(UpperCase(qryAlpe.FieldByName('MCA_NUMCCD').AsString)));

      end;

    except
      Result := False;
    end;

  finally
    qryAlpe.Free;
  end;
end;

function TAlpe.fVerificaEstrutura: Boolean;
var
  qryAlpe: TUniQuery;
begin
  Result := False;

  qryAlpe := fCriaQuery;
  try
    qryAlpe.Close;
    qryAlpe.SQL.Text :=
    ' SELECT '+
    '   * '+
    ' FROM FATGOR F '+
    '   INNER JOIN ADTCLI A '+
    '     ON  F.FGO_NUMDOC = A.ADT_NUMDOC '+
    '     AND F.FGO_ESPDOC = A.ADT_ESPDOC '+
    '     AND F.FGO_CODEMP = A.ADT_CODEMP '+
    ' WHERE '+
    '   F.FGO_NUMDOC = :NUMDOC AND '+
    '   F.FGO_ESPDOC = :ESPDOC AND '+
    '   F.FGO_CODEMP = :CODEMP     ';

    qryAlpe.ParamByName('NUMDOC').AsString := Self.strNumDoc;
    qryAlpe.ParamByName('ESPDOC').AsString := Self.strEspDoc;
    qryAlpe.ParamByName('CODEMP').AsString := Self.strCodEmp;

    qryAlpe.Open;

    if not qryAlpe.IsEmpty then
      Result := True;

  finally
    qryAlpe.Free;
  end;
end;

procedure TAlpe.pCarregaPedidoAlpe(strNumDoc, strEspDoc, strCodEmp: string);
var
  qryAlpe: TUniQuery;
begin
  Self.strTipRec := '';
  Self.strNumPok := '';
  Self.strNumDoc := '';
  Self.strEspDoc := '';
  Self.strCodEmp := '';

  qryAlpe := fCriaQuery;
  try
     qryAlpe.Close;
     qryAlpe.SQL.Text :=
     ' SELECT '+
     '   F.FGO_NUMPOK, E.FGO_TIPREC, F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI '+
     ' FROM FATGOR F '+
     '   INNER JOIN EXTGOR E '+
     '     ON F.AUTOINCREM = E.FGO_SEQFGO '+
    ' WHERE '+
    ' ( FGO_NUMDOC = :NUMDOC AND '+
    '   FGO_ESPDOC = :ESPDOC AND'+
    '   FGO_CODEMP = :CODEMP ) '+
    ' OR '+
    ' ( FGO_NUMFAT = :NUMDOC AND '+
    '   FGO_TIPFAT = :ESPDOC AND ' +
    '   FGO_EMPFAT = :CODEMP) ';

    qryAlpe.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAlpe.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAlpe.ParamByName('CODEMP').AsString := strCodEmp;

    qryAlpe.Open;

    if not qryAlpe.IsEmpty then
    begin
     Self.strTipRec := qryAlpe.FieldByName('FGO_TIPREC').AsString;
     Self.strNumPok := qryAlpe.FieldByName('FGO_NUMPOK').AsString;
       Self.strNumDoc := qryAlpe.FieldByName('FGO_NUMDOC').AsString;
       Self.strEspDoc := qryAlpe.FieldByName('FGO_ESPDOC').AsString;
       Self.strCodEmp := qryAlpe.FieldByName('FGO_CODEMP').AsString;
       Self.strCodCli := qryAlpe.FieldByName('FGO_CODCLI').AsString;
     end;
   finally
     qryAlpe.Free;
  end;

end;

class function TAlpe.fPedidoAlpe(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
var
  qryAlpe: TUniQuery;
begin
  Result := False;

  qryAlpe := fCriaQuery;
  try
    qryAlpe.Close;
    qryAlpe.SQL.Text :=
    ' SELECT '+
    '   * '+
    ' FROM '+
    '   EXTGOR '+
    ' WHERE '+
    '   FGO_SEQFGO = ( SELECT '+
    '                    AUTOINCREM '+
    '                  FROM '+
    '                    FATGOR '+
    '                  WHERE '+
    '                    FGO_NUMDOC = :NUMDOC AND '+
    '                    FGO_ESPDOC = :ESPDOC AND '+
    '                    FGO_CODEMP = :CODEMP )'+

    ' AND '+

    ' FGO_TIPREC IN ("ALPE", "ALPEF", "ALPEC", "ALPEP", "ALPES", "ALPEFP") ';

    qryAlpe.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAlpe.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAlpe.ParamByName('CODEMP').AsString := strCodEmp;

    qryAlpe.Open;

    if not qryAlpe.IsEmpty then
      Result := True;

  finally
    qryAlpe.Free;
  end;
end;

class function TAlpe.fPossuiAdiantamentoAlpe(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
var
  recTotaisAdiantamento: TTotaisAdiantamento;
begin
  Result := False;

  if TAlpe.fPedidoAlpe(strNumDoc, strEspDoc, strCodEmp) then
  begin
    recTotaisAdiantamento := TAdiantamento.fGetTotaisAdiantamento(strNumDoc,
                                                                  strEspDoc,
                                                                  VS_strCodEmp);

    if (recTotaisAdiantamento.blnExiAdt) then
      if (recTotaisAdiantamento.fltValLan > 0) Then
      begin
        fMensagem('ATENÇÃO!', 'O pedido '+strNumDoc+'-'+strEspDoc+
                              ' já possui adiantamento gerado pela Alpe. Sendo assim, sua alteração não é permitida. '+
                              'Se for necessário, cancele o pedido e refaça o processo.', ['&OK']);

        Result := True;

      end;
  end;
end;

procedure TAlpe.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TAlpe.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TAlpe.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TAlpe.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TAlpe.SetstrNumPok(const Value: String);
begin
  FstrNumPok := Value;
end;

procedure TAlpe.SetstrTipRec(const Value: String);
begin
  FstrTipRec := Value;
end;

end.
