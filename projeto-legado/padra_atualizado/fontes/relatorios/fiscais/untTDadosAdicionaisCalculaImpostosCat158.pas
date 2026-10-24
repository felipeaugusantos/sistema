unit untTDadosAdicionaisCalculaImpostosCat158;

interface

uses untIDadosAdicionaisCalculaImpostosCat158;

type
  TDadosAdicionaisCalculaImpostosCat158 = class(TInterfacedObject, IDadosAdicionaisCalculaImpostosCat158)
  private
    FRegraCstCfop: string;
    FValorProduto: double;
    FAlqInterna: double;
    FValorIpi: double;
    FValorIVA: double;
    FValorIcms: double;
    FValorIcmsUntCompra: double;
  public
    procedure pSetRegraCstCfop(strRegraCstCfop: string);
    function fGetRegraCstCfop: string;

    procedure pSetValorProduto(fltValorProduto: double);
    function fGetValorProduto: double;

    procedure pSetAlqInterna(fltAlqInterna: double);
    function fGetAlqInterna: double;

    procedure pSetValorIVA(fltValorIVA: double);
    function fGetValorIVA: double;

    procedure pSetValorIpi(fltValorIpi: double);
    function fGetValorIpi: double;

    procedure pSetValorIcms(fltValorIcms: double);
    function fGetValorIcms: double;

    procedure pSetValorIcmsUntCompra(fltValorIcmsUntCompra: double);
    function fGetValorIcmsUntCompra: double;

    function fGetTotalProdutoIpi: double;
  end;

implementation

{ TConfiguracoesCat158 }

function TDadosAdicionaisCalculaImpostosCat158.fGetAlqInterna: double;
begin
  Result := FAlqInterna;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetRegraCstCfop: string;
begin
  Result := FRegraCstCfop;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetTotalProdutoIpi: double;
begin
  Result := FValorProduto + FValorIpi;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetValorIcms: double;
begin
  Result := FValorIcms;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetValorIcmsUntCompra: double;
begin
  Result := FValorIcmsUntCompra;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetValorIpi: double;
begin
  Result := FValorIpi;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetValorIVA: double;
begin
  Result := FValorIVA;
end;

function TDadosAdicionaisCalculaImpostosCat158.fGetValorProduto: double;
begin
  Result := FValorProduto;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetAlqInterna(fltAlqInterna: double);
begin
  FAlqInterna := fltAlqInterna;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetRegraCstCfop(strRegraCstCfop: string);
begin
  FRegraCstCfop := strRegraCstCfop;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetValorIcms(fltValorIcms: double);
begin
  FValorIcms := fltValorIcms;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetValorIcmsUntCompra(fltValorIcmsUntCompra: double);
begin
  FValorIcmsUntCompra := fltValorIcmsUntCompra;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetValorIpi(fltValorIpi: double);
begin
  FValorIpi := fltValorIpi;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetValorIVA(fltValorIVA: double);
begin
  FValorIVA := fltValorIVA;
end;

procedure TDadosAdicionaisCalculaImpostosCat158.pSetValorProduto(fltValorProduto: double);
begin
  FValorProduto := fltValorProduto;
end;

end.
