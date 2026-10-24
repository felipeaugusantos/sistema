unit Expedicao.TSeparacaoAvulsa;

interface

uses
  Classes,
  SysUtils,
  StrUtils;

Type
  TSeparacaoAvulsa = class
  private
    FUTCSEA: String;
    FCodigo: String;
  public
    const
      NAO_UTILIZA= 'N';
      AUTCOM = 'S';
      COLETOR = 'C';

    function fUtilizaColetor : Boolean;
    function fUTilizaSeparacaoAvulsa : Boolean;
    function fRetornaLegendaSeparacao: String;

    function fRetornaSQLPedidoReserva: String;
    function fRetornaSQLInsertDetalhe : String;

    function fRetornaMensagemPedidoReserva : String;

    constructor Create(strUTCSEA : String);

    property strCodigo: String read FCodigo write FCodigo;
  end;
implementation

{ TSeparacaoAvulsa }


constructor TSeparacaoAvulsa.Create(strUTCSEA : String);
begin
  if strUTCSEA = '' then
    FUTCSEA := NAO_UTILIZA
  else
    FUTCSEA := strUTCSEA;
end;

function TSeparacaoAvulsa.fUtilizaColetor: Boolean;
begin
  Result := FUTCSEA = COLETOR;
end;

function TSeparacaoAvulsa.fUTilizaSeparacaoAvulsa: Boolean;
begin
  Result := FUTCSEA <> NAO_UTILIZA;
end;

function TSeparacaoAvulsa.fRetornaLegendaSeparacao : String;
begin
  if fUtilizaColetor then
    Result := 'Enviado ao separador'
  else
    Result := 'Produto Retirado';
end;


function TSeparacaoAvulsa.fRetornaMensagemPedidoReserva: String;
begin
  Result := 'PEDIDO DE RESERVA DE ESTOQUE: SEPARAÇÃO AVULSA ' + FCodigo;
end;

function TSeparacaoAvulsa.fRetornaSQLInsertDetalhe: String;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create;
  try
    stlSQL.Add('INSERT INTO DETCSP ( ');
    stlSQL.Add(' AUTOINCREM,         ');
    stlSQL.Add(' DET_CODEMP,         ');
    stlSQL.Add(' DET_SEQCSP,         ');
    stlSQL.Add(' DET_SEQFDO,         ');
    stlSQL.Add(' DET_CODITE,         ');
    stlSQL.Add(' DET_NUMLOT,         ');
    stlSQL.Add(' DET_QTDITE,         ');
    stlSQL.Add(' DET_OPESEP )        ');
    stlSQL.Add('VALUES (             ');
    stlSQL.Add(' :AUTOINCREM,        ');
    stlSQL.Add(' :DET_CODEMP,        ');
    stlSQL.Add(' :DET_SEQCSP,        ');
    stlSQL.Add(' :DET_SEQFDO,        ');
    stlSQL.Add(' :DET_CODITE,        ');
    stlSQL.Add(' :DET_NUMLOT,        ');
    stlSQL.Add(' :DET_QTDITE,        ');
    stlSQL.Add(' :DET_OPESEP )       ');

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;

end;

function TSeparacaoAvulsa.fRetornaSQLPedidoReserva : String;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create;
  try
    stlSQL.Add('SELECT                                    ');
    stlSQL.Add('  FDO_SEQGER,                             ');
    stlSQL.Add('  FDO_NUMDOC,                             ');
    stlSQL.Add('  FDO_ESPDOC,                             ');
    stlSQL.Add('  FDO_CODEMP                              ');
    stlSQL.Add('FROM                                      ');
    stlSQL.Add('  DETCSP                                  ');
    stlSQL.Add('  INNER JOIN FATDOR ON FATDOR.AUTOINCREM  ');
    stlSQL.Add('WHERE DET_SEQCSP = :AUTOINCREM            ');
    stlSQL.Add('LIMIT 1                                   ');

    Result := stlSQL.Text;
  finally
    FreeAndNil(stlSQL);
  end;
end;

end.
