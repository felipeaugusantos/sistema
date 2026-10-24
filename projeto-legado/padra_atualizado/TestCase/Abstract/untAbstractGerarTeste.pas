unit untAbstractGerarTeste;

interface

Uses untIGerarTeste, Uni, UniClientDataSet, untModulo, Dialogs;

Type

  TAbstractGerarTeste = class abstract(TInterfacedObject, IGerarTeste)
  private
    procedure pFinalizarProcessamentoComErroExecutandoPeloJenkins;
    procedure pExibirMensagemDeErroProcessamento(
      const ADados: TUniClientDataSet; const AMensagemErro: string);
  public
    function fGerarTesteIpi(const ADados: OleVariant) : Boolean; Virtual;
    function fGerarTesteStCustoAquisicao(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteIcmsSt(const ADados: OleVariant; Const AOpcao : String) : Boolean;Virtual;
    function fGerarTesteIcmsEfetivo(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteDifal(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteFcp(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteFcpDifal(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteIcmsOrgaoPublico(const ADados: OleVariant) : Boolean;Virtual;
    function fGerarTesteCfop(const ADados: OleVariant): Boolean; Virtual;
    function fGerarTestePrecoCusto(const ADados: OleVariant): Boolean; Virtual;
    function fGerarTesteMargemVenda(const ADados: OleVariant): Boolean; Virtual;
    procedure pFinalizarProcessamentoComErro(const ADados: TUniClientDataSet; const AMensagemErro: string);
  end;


implementation

{ TAbstractConsulta }

function TAbstractGerarTeste.fGerarTesteCfop(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteDifal(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteFcp(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteFcpDifal(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteIcmsSt(const ADados: OleVariant; const AOpcao : String): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteIcmsEfetivo(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteIcmsOrgaoPublico(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteIpi(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;


function TAbstractGerarTeste.fGerarTesteMargemVenda(
  const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTestePrecoCusto(
  const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

function TAbstractGerarTeste.fGerarTesteStCustoAquisicao(const ADados: OleVariant): Boolean;
begin
  Result := False;
end;

procedure TAbstractGerarTeste.pFinalizarProcessamentoComErroExecutandoPeloJenkins;
begin
  ExitCode := ExitCode + 1;
  frmModulo.FPararProcessamento := True;
end;

procedure TAbstractGerarTeste.pExibirMensagemDeErroProcessamento(const ADados: TUniClientDataSet;
  const AMensagemErro: string);
begin
  ShowMessage('Documento:'+ ADados.FieldByName('DET_NUMDOC').AsString +
              '| Especie:'+ ADados.FieldByName('DET_ESPDOC').AsString +
              '| Item:'+ ADados.FieldByName('DET_CODITE').AsString +
              '| Empresa:'+ ADados.FieldByName('DET_CODEMP').AsString + #13#10 + AMensagemErro);
end;

procedure TAbstractGerarTeste.pFinalizarProcessamentoComErro(const ADados: TUniClientDataSet;
  const AMensagemErro: string);
begin
  if frmModulo.ExecutandoPeloJenkins Then
  begin
    pFinalizarProcessamentoComErroExecutandoPeloJenkins;
    Exit;
  end;

  pExibirMensagemDeErroProcessamento(ADados, AMensagemErro);
end;

end.
