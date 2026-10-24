(*****************************************************************************************************************)
(*   MODELO PARA EXIBIÇÃO JUNTO COM A MENSAGEM DE LIGERAÇÃO                                                      *)
(*   |-------------------------------------------------------------------------------------------------------|   *)
(*   | DUPLICATA             | DT.CAD     | DT.VENCTO  | VR.DUPLICATA |     VR.JUROS | VR.CORRIGIDO | ATRASO |   *)
(*   |-------------------------------------------------------------------------------------------------------|   *)
(*   | 123456789012-A-NF-001 | 99/99/9999 | 99/99/9999 | 9.999.999,99 | 9.999.999,99 | 9.999.999,99 |  999   |   *)
(*   |-------------------------------------------------------------------------------------------------------|   *)
(**************************************************************************************************************WL*)

unit Faturamento.Classes.DuplicataAtraso;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Uni, untMsgLiberacao;

type
  TDuplicataAtrasoFaturamento = class
  private
    FCodigoCliente      : String;
    FQryDuplicataAtraso : TUniQuery;
    FTxtDuplicataAtraso : TStrings;

    constructor Create(const ACodigoCliente: String); overload;

    procedure pCarregarSQL;

    procedure pCabecalho;
    procedure pRodape;
    procedure pMontarTxtDuplicataAtraso;

    function fPreencheEspaco(const AStrTexto: String; const AIntTamanho: Integer;
      const ABlnPreencherADireita: Boolean=True): String;

  public
    destructor Destroy; Override;

    class function New(const ACodigoCliente: String): TDuplicataAtrasoFaturamento;
    class procedure fCarregaMensagemLiberacao(const ACodigoCliente: String;
      const AMensagemLiberacao: TMensagemLiberacao);

    function fExecutar: TDuplicataAtrasoFaturamento;

    property QryDuplicataAtraso : TUniQuery read FQryDuplicataAtraso;
    property TxtDuplicataAtraso : TStrings  read FTxtDuplicataAtraso;
  end;

implementation

uses
  untFuncoesSimples;

{ TDuplicataAtrasoFaturamento }

constructor TDuplicataAtrasoFaturamento.Create(const ACodigoCliente: String);
begin
  FCodigoCliente      := ACodigoCliente;
  FQryDuplicataAtraso := fCriaQuery;
  FTxtDuplicataAtraso := TStringList.Create;
end;

destructor TDuplicataAtrasoFaturamento.Destroy;
begin
  FreeAndNil(FQryDuplicataAtraso);
  FreeAndNil(FTxtDuplicataAtraso);

  inherited;
end;

class procedure TDuplicataAtrasoFaturamento.fCarregaMensagemLiberacao(
  const ACodigoCliente: String; const AMensagemLiberacao: TMensagemLiberacao);
var
  LStrLinha : String;
  LDuplicataAtraso: TDuplicataAtrasoFaturamento;
begin
  if (not fCfgSis('EXBDUP', varBoolean)) or
     (not Assigned(AMensagemLiberacao)) or
     (fEmptyStr(ACodigoCliente)) then
    Exit;

  LDuplicataAtraso := TDuplicataAtrasoFaturamento.New(ACodigoCliente);
  try
    LDuplicataAtraso.fExecutar;

    for LStrLinha in LDuplicataAtraso.TxtDuplicataAtraso do
      AMensagemLiberacao.pAddTexto(LStrLinha);
  finally
    FreeAndNil(LDuplicataAtraso);
  end;
end;

function TDuplicataAtrasoFaturamento.fExecutar: TDuplicataAtrasoFaturamento;
begin
  Result := Self;

  pCarregarSQL;
  pMontarTxtDuplicataAtraso;
end;

function TDuplicataAtrasoFaturamento.fPreencheEspaco(const AStrTexto: String;
  const AIntTamanho: Integer; const ABlnPreencherADireita: Boolean): String;
var
  LIntTamanhoTexto : Integer;
begin
  LIntTamanhoTexto := AStrTexto.Trim.Length;

  if ABlnPreencherADireita then
    Result := AStrTexto+DupeString(' ', AIntTamanho - LIntTamanhoTexto)
  else
    Result := DupeString(' ', AIntTamanho - LIntTamanhoTexto) + AStrTexto;
end;

class function TDuplicataAtrasoFaturamento.New(
  const ACodigoCliente: String): TDuplicataAtrasoFaturamento;
begin
  Result := Self.Create(ACodigoCliente);
end;

procedure TDuplicataAtrasoFaturamento.pCabecalho;
begin
  FTxtDuplicataAtraso.Add('|-------------------------------------------------------------------------------------------------------|');
  FTxtDuplicataAtraso.Add('| DUPLICATA             | DT.CAD     | DT.VENCTO  | VR.DUPLICATA |     VR.JUROS | VR.CORRIGIDO | ATRASO |');
  FTxtDuplicataAtraso.Add('|-------------------------------------------------------------------------------------------------------|');
end;

procedure TDuplicataAtrasoFaturamento.pCarregarSQL;
var
  LStrSQL : String;
begin
  FQryDuplicataAtraso.Close;

  LStrSQL := '';
  LStrSQL := LStrSQL + 'SELECT ';
  LStrSQL := LStrSQL + '  CONCAT( CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  LStrSQL := LStrSQL + '  CTR_ESPDOC, ';
  LStrSQL := LStrSQL + '  CTR_CODEMP, ';
  LStrSQL := LStrSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
  LStrSQL := LStrSQL + '  CTR_DTACAD, ';
  LStrSQL := LStrSQL + '  CTR_DTAVEN, ';
  LStrSQL := LStrSQL + '  IF (DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN) < 0, 0, DATEDIFF(' + fCurrentDate + ', CTR_DTAVEN)) AS CTR_DIAATR, ';
  LStrSQL := LStrSQL + '  CTR_VALDUP, ';
  LStrSQL := LStrSQL + '  CTR_VALORI, ';
  LStrSQL := LStrSQL + '  CTR_JURSUJ, ';
  LStrSQL := LStrSQL + '  CTR_DESSUJ, ';
  LStrSQL := LStrSQL + '  CTR_DESCOB  ';
  LStrSQL := LStrSQL + 'FROM ';
  LStrSQL := LStrSQL + '  CADREC ';
  LStrSQL := LStrSQL + 'INNER JOIN CADCLI ';
  LStrSQL := LStrSQL + '  ON CLI_CODCLI = CTR_CODCLI ';
  LStrSQL := LStrSQL + 'WHERE (';
  LStrSQL := LStrSQL + '  CLI_CODCLI = :CODCLI ';

  if fCfgSis('TRFTCR', varString) = '2' then
  begin
    LStrSQL := LStrSQL + '    OR CLI_CODRED = ';
    LStrSQL := LStrSQL + '    (SELECT ';
    LStrSQL := LStrSQL + '       CLI_CODRED ';
    LStrSQL := LStrSQL + '     FROM ';
    LStrSQL := LStrSQL + '       CADCLI ';
    LStrSQL := LStrSQL + '     WHERE CLI_CODCLI = :CODCLI) ';
  end;

  LStrSQL := LStrSQL + ' ) AND CTR_DTAREC IS NULL       ';

  if fCfgSis('EXIPOR', varBoolean) then
    LStrSQL := LStrSQL + ' AND ((IFNULL(POR_EXIPOR, "") = "") OR (POR_EXIPOR = "S"))  ';

  LStrSQL := LStrSQL + ' AND CTR_DTAVEN < :DTAREF ';
  LStrSQL := LStrSQL + ' AND CTR_VALDUP > 0 ';

  LStrSQL := LStrSQL + 'ORDER BY ';
  LStrSQL := LStrSQL + '  6, 3, 2, 1 ';

  FQryDuplicataAtraso.SQL.Text := LStrSQL;
  FQryDuplicataAtraso.ParamByName('CODCLI').AsString   := FCodigoCliente;
  FQryDuplicataAtraso.ParamByName('DTAREF').AsDateTime := VS_Date;
  FQryDuplicataAtraso.Open;
end;

procedure TDuplicataAtrasoFaturamento.pMontarTxtDuplicataAtraso;
var
  LStrLinha       : String;
  LValorDuplicata : Double;
  LValorJuros     : Double;
  LValorCorrigido : Double;

begin
  FTxtDuplicataAtraso.Clear;

  pCabecalho;

  FQryDuplicataAtraso.First;

  while not FQryDuplicataAtraso.Eof do
  begin
    LValorDuplicata := FQryDuplicataAtraso.FieldByName('CTR_VALDUP').AsFloat;
    LValorJuros     := fCalculaJurosCadCtr(FQryDuplicataAtraso.FieldByName('CTR_DTAVEN').AsDateTime,
                                           FQryDuplicataAtraso.FieldByName('CTR_VALDUP').AsFloat);
    LValorCorrigido := LValorDuplicata
                     + LValorJuros;

    LStrLinha := '| '
               + fPreencheEspaco(FQryDuplicataAtraso.FieldByName('CTR_NUMDUP').AsString,21)
               + ' | '
               + fPreencheEspaco(FormatDateTime('dd/mm/yyyy', FQryDuplicataAtraso.FieldByName('CTR_DTACAD').AsDateTime),10)
               + ' | '
               + fPreencheEspaco(FormatDateTime('dd/mm/yyyy', FQryDuplicataAtraso.FieldByName('CTR_DTAVEN').AsDateTime),10)
               + ' | '
               + fPreencheEspaco(FormatFloat(',0.00', LValorDuplicata),12,False)
               + ' | '
               + fPreencheEspaco(FormatFloat(',0.00', LValorJuros),12,False)
               + ' | '
               + fPreencheEspaco(FormatFloat(',0.00', LValorCorrigido),12,False)
               + ' |  '
               + fPreencheEspaco(FQryDuplicataAtraso.FieldByName('CTR_DIAATR').AsString,3,False)
               + '   | ';

    FTxtDuplicataAtraso.Add(LStrLinha);

    FQryDuplicataAtraso.Next;
  end;

  pRodape;
end;

procedure TDuplicataAtrasoFaturamento.pRodape;
begin
  FTxtDuplicataAtraso.Add('|-------------------------------------------------------------------------------------------------------|');
end;

end.
