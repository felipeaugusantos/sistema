unit untTApuradorAjustesIcms;

interface

uses untIRepositorioAjusteIcms, untTAjusteIcms, untTRepositorioAjusteIcmsFactory, untTypesSistema,
     System.Generics.Collections, Uni, UniClientDataSet;

type
  TApuradorAjustesIcms = class
  private
    RepositorioAjusteIcms: IRepositorioAjusteIcms;
    FListaAjustesIcms: TObjectList<TAjusteIcms>;
    FConexao: TUniConnection;
  public
    procedure pCarregarAjustes(strTipo: string; dtaInicial, dtaFinal: TDateTime; strCodEmp: string = '');
    procedure pCarregaObservacoesDebito(cdsAux: TUniClientDataSet);
    procedure pCarregaObservacoesCredito(cdsAux: TUniClientDataSet);

    function fRetValorOutrosDebitos: double;
    function fRetValorEstornoCredito: double;
    function fRetValorOutrosCreditos: double;
    function fRetValorEstornoDebito: double;
    function fRetValorDeducaoImposto: double;
    function fRetValorDebitosEspeciais: double;

    constructor create(conexao: TUniConnection);
  end;

implementation

{ TApuradorAjustesIcms }

constructor TApuradorAjustesIcms.create(conexao: TUniConnection);
begin
  inherited create;
  FConexao := conexao;
end;

function TApuradorAjustesIcms.fRetValorDebitosEspeciais: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = DEBITOS_ESPECIAIS then
      Result := Result + ajuste.fltValor;
  end;
end;

function TApuradorAjustesIcms.fRetValorDeducaoImposto: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = DEDUCAO_IMPOSTO then
      Result := Result + ajuste.fltValor;
  end;
end;

function TApuradorAjustesIcms.fRetValorEstornoCredito: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = ESTORNO_CREDITO then
      Result := Result + ajuste.fltValor;
  end;
end;

function TApuradorAjustesIcms.fRetValorEstornoDebito: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = ESTORNO_DEBITO then
      Result := Result + ajuste.fltValor;
  end;
end;

function TApuradorAjustesIcms.fRetValorOutrosCreditos: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = OUTROS_CREDITOS then
      Result := Result + ajuste.fltValor;
  end;
end;

function TApuradorAjustesIcms.fRetValorOutrosDebitos: double;
  var
    ajuste: TAjusteIcms;
begin
  Result := 0;

  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = OUTROS_DEBITOS then
      Result := Result + ajuste.fltValor;
  end;
end;

procedure TApuradorAjustesIcms.pCarregaObservacoesCredito(cdsAux: TUniClientDataSet);
  var
    ajuste: TAjusteIcms;
begin
  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = OUTROS_CREDITOS then
    begin
      cdsAux.Append;
      cdsAux.FieldByName('OBSERV').AsString := ajuste.strObservacao;
      cdsAux.FieldByName('VALOR').AsFloat := ajuste.fltValor;
      cdsAux.Post;
    end;
  end;
end;

procedure TApuradorAjustesIcms.pCarregaObservacoesDebito(cdsAux: TUniClientDataSet);
  var
    ajuste: TAjusteIcms;
begin
  for ajuste in FListaAjustesIcms do
  begin
    if ajuste.strTipo = OUTROS_DEBITOS then
    begin
      cdsAux.Append;
      cdsAux.FieldByName('OBSERV').AsString := ajuste.strObservacao;
      cdsAux.FieldByName('VALOR').AsFloat := ajuste.fltValor;
      cdsAux.Post;
    end;
  end;
end;

procedure TApuradorAjustesIcms.pCarregarAjustes(strTipo: string; dtaInicial, dtaFinal: TDateTime; strCodEmp: string = '');
begin
  RepositorioAjusteIcms := TRepositorioAjusteIcmsFactory.fGetInstance.fGetRepositorio(strTipo, FConexao);
  FListaAjustesIcms := RepositorioAjusteIcms.fRetListaAjusteIcms(dtaInicial, dtaFinal, strCodEmp);
end;

end.
