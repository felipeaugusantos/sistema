unit TestExpedicao.TSeparacaoAvulsa;

interface

uses
  TestFramework, Classes, SysUtils, Expedicao.TSeparacaoAvulsa, StrUtils;

type

  TestTSeparacaoAvulsa = class(TTestCase)
  published
    procedure TestCreate_Sem_Configuracao;
    procedure TestfUtilizaColetor_Utiliza;
    procedure TestfUtilizaColetor_Nao_Utiliza;
    procedure TestfUTilizaSeparacaoAvulsa_Nao_Utiliza;
    procedure TestfUTilizaSeparacaoAvulsa_Utiliza;
    procedure TestfRetornaLegendaSeparacao_COLETOR;
    procedure TestfRetornaLegendaSeparacao;
    procedure TestfRetornaSQLPedidoReserva;
    procedure TestfRetornaSQLInsertDetalhe;
    procedure TestfRetornaMensagemPedidoReserva;
  end;

implementation


procedure TestTSeparacaoAvulsa.TestCreate_Sem_Configuracao;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create('');
  try
    CheckFalse(FSeparacaoAvulsa.fUtilizaColetor);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfUtilizaColetor_Utiliza;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
  try
    CheckTrue(FSeparacaoAvulsa.fUtilizaColetor);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfUtilizaColetor_Nao_Utiliza;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.AUTCOM);
  try
    CheckFalse(FSeparacaoAvulsa.fUtilizaColetor);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfUTilizaSeparacaoAvulsa_Nao_Utiliza;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.NAO_UTILIZA);
  try
    CheckFalse(FSeparacaoAvulsa.fUTilizaSeparacaoAvulsa);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;


procedure TestTSeparacaoAvulsa.TestfUTilizaSeparacaoAvulsa_Utiliza;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
  try
    CheckTrue(FSeparacaoAvulsa.fUTilizaSeparacaoAvulsa);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfRetornaLegendaSeparacao;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.AUTCOM);
  try
    CheckEquals('Produto Retirado', FSeparacaoAvulsa.fRetornaLegendaSeparacao);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfRetornaLegendaSeparacao_COLETOR;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
  try
    CheckEquals('Enviado ao separador', FSeparacaoAvulsa.fRetornaLegendaSeparacao);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfRetornaSQLPedidoReserva;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
  stlSQL : TStringList;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
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

    CheckEquals(stlSQL.Text, FSeparacaoAvulsa.fRetornaSQLPedidoReserva);
  finally
    FreeAndNil(FSeparacaoAvulsa);
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfRetornaSQLInsertDetalhe;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
  stlSQL : TStringList;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
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

    CheckEquals(stlSQL.Text, FSeparacaoAvulsa.fRetornaSQLInsertDetalhe);
  finally
    FreeAndNil(FSeparacaoAvulsa);
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSeparacaoAvulsa.TestfRetornaMensagemPedidoReserva;
var
  FSeparacaoAvulsa : TSeparacaoAvulsa;
begin
  FSeparacaoAvulsa := TSeparacaoAvulsa.Create(TSeparacaoAvulsa.COLETOR);
  FSeparacaoAvulsa.strCodigo := '000001';
  try
    CheckEquals('PEDIDO DE RESERVA DE ESTOQUE: SEPARAÇÃO AVULSA 000001', FSeparacaoAvulsa.fRetornaMensagemPedidoReserva);
  finally
    FreeAndNil(FSeparacaoAvulsa);
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSeparacaoAvulsa.Suite);
end.

