unit CobrancaEletronica.Lib.Facade;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  System.SysUtils, System.Variants, Data.DB, Uni, TypInfo, System.StrUtils,
  System.Generics.Collections, System.Classes,
  UntMsgInterna, untConstantes, CobrancaEletronica.Lib.Types;

type
  TFacadeCobrancaEletronica = class
  public
    class function fExisteCobrancaEletronica(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica;
      const AApenasComTransacaoOuPagamento: Boolean=False): Boolean;

    class function fExisteAdiantamentoClienteCobrancaEletronica(const ANumDoc,
      AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica): Boolean;

    class function fCondicaoPagamentoCobrancaEletronica(const ACodCnd: String;
      const ATipoCobranca: TTipoCobrancaEletronica): Boolean;

    class procedure pCancelaLinkBaixaPedidoNaoEntregue(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);

    class procedure pCancelaLinkPagamento(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);

    class procedure pCriarNovoLinkPagamento(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);

    class procedure pGravarLogCobrancaEletronica(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica;
      const AObservacao: String);

    class procedure pProcessaEstornoAdiantamento(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);

    {$IF not Defined(LINUX) and not Defined(TEST_FULFILLMENT)}
    class function fUtilizarRoboDisparosCobrancaEletronica(
      const ATipoCobranca: TTipoCobrancaEletronica): Boolean;

    class function fValidaCadastroClienteCobrancaEletronica(const ACodCli,
      ACodCnd: String; const ATipoCobranca: TTipoCobrancaEletronica): Boolean;

    class function fValidarValorMinimoDocumento(const ACodCnd, AOpcDoc: String;
      const ATotGer: Double; const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
    {$ENDIF}
  end;

implementation

uses
{$IF not Defined(LINUX) and not Defined(TEST_FULFILLMENT)}
  untTEnvioEmailAutController,
{$ENDIF}
  untControleCobrancaEletronica;

{ TFacadeCobrancaEletronica }

class function TFacadeCobrancaEletronica.fCondicaoPagamentoCobrancaEletronica(
  const ACodCnd: String; const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
var
  LCampoCondicaoPagamento : String;
begin
  Result := False;

  if ATipoCobranca = tcPagarMe then
  begin
    LCampoCondicaoPagamento := 'CND_COBPME';

    if not fCfgSis('PMEHAB', varBoolean) then
      Exit(False);

    Result := (fCampoTabela('CND_COBPME', 'CADCND', ['CND_CODIGO'], [ACodCnd]) = 'S')
  end;
end;

class function TFacadeCobrancaEletronica.fExisteAdiantamentoClienteCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
var
  LControlador: TControladorCobrancaEletronica;
begin
  if (AEspDoc <> 'PD') then
      Exit(True);

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fExisteAdiantamentoClienteCobrancaEletronica(
                   ANumDoc, AEspDoc, ACodEmp, ATipoCobranca, Result);
  finally
    FreeAndNil(LControlador);
  end;
end;

class function TFacadeCobrancaEletronica.fExisteCobrancaEletronica(const ANumDoc,
  AEspDoc, ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica;
  const AApenasComTransacaoOuPagamento: Boolean): Boolean;
var
  LControlador: TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit(False);
  end;

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fExisteCobrancaEletronica(
                    ANumDoc, AEspDoc, ACodEmp, ATipoCobranca,
                    Result, AApenasComTransacaoOuPagamento);
  finally
    FreeAndNil(LControlador);
  end;
end;

{$IF not Defined(LINUX) and not Defined(TEST_FULFILLMENT)}
class function TFacadeCobrancaEletronica.fUtilizarRoboDisparosCobrancaEletronica(
  const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
begin
  Result := False;

  if ATipoCobranca = tcPagarMe then
  begin
    Result := TEmailAutController
                .fExistemConbrancasEletronicasASeremEnviadas(
                   fCfgSis('PMEHAB', varBoolean));
  end;
end;

class function TFacadeCobrancaEletronica.fValidaCadastroClienteCobrancaEletronica(
  const ACodCli, ACodCnd: String; const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
var
  LRetorno: Boolean;
  LControlador: TControladorCobrancaEletronica;
begin

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fValidaCadastroCliente(ACodCli, ACodCnd, LRetorno, ATipoCobranca);
    Result := LRetorno;
  finally
    FreeAndNil(LControlador);
  end;
end;

class function TFacadeCobrancaEletronica.fValidarValorMinimoDocumento(
  const ACodCnd, AOpcDoc: String; const ATotGer: Double;
  const ATipoCobranca: TTipoCobrancaEletronica): Boolean;
begin
  Result := True;

  If Not fCondicaoPagamentoCobrancaEletronica(ACodCnd, ATipoCobranca) Then
    Exit;

  If (ATipoCobranca = tcPagarMe) And
     (MatchStr(AOpcDoc, ['OR','PD','VN'])) Then
  Begin
    If Not fCfgSis('PMEHAB', varBoolean) Then
      Exit;

    If ATotGer < fStrToFloat(fCfgSis('PMEVMN')) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Para utilizar a condição de pagamento é necessário '+
                            'que o valor da venda seja maior ou igual a '+
                            FormatFloat(',0.00', fStrToFloat(fCfgSis('PMEVMN'),0)), ['&OK']);
    End;
  End;
end;
{$ENDIF}

class procedure TFacadeCobrancaEletronica.pCancelaLinkBaixaPedidoNaoEntregue(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica);
var
  LControlador: TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit;
  end;

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fCancelaLinkBaixaPedidoNaoEntregue(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca);
  finally
    FreeAndNil(LControlador);
  end;
end;

class procedure TFacadeCobrancaEletronica.pCancelaLinkPagamento(const ANumDoc,
  AEspDoc, ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);
var
  LControlador: TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit;
  end;

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fCancelaLinkPagamento(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca);
  finally
    FreeAndNil(LControlador);
  end;
end;

class procedure TFacadeCobrancaEletronica.pCriarNovoLinkPagamento(const ANumDoc,
  AEspDoc, ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);
var
  LControlador: TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit;
  end;

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fCriarNovoLinkPagamento(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca);
  finally
    FreeAndNil(LControlador);
  end;
end;

class procedure TFacadeCobrancaEletronica.pGravarLogCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica; const AObservacao: String);
var
  LControlador: TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit;
  end;

  LControlador := TControladorCobrancaEletronica.New;
  try
    LControlador.fGravarLogCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp,
                   ATipoCobranca, AObservacao);
  finally
    FreeAndNil(LControlador);
  end;
end;

class procedure TFacadeCobrancaEletronica.pProcessaEstornoAdiantamento(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica);
var
  controlador : TControladorCobrancaEletronica;
begin
  if ATipoCobranca = tcPagarMe then
  begin
    if not fCfgSis('PMEHAB', varBoolean) then
      Exit;
  end;

  controlador := nil;
  Try
    controlador := TControladorCobrancaEletronica.Create;
    controlador.fProcessaEstornoAdiantamento(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca);
  Finally
    FreeAndNil(controlador);
  End;
end;

end.


