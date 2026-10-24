unit untTCalculaImpostos;

interface

uses untIDadosAdicionaisCalculaImpostosCat158,
     untICalculaImpostosCat158;

type
  TCalculaImpostos = class(TInterfacedObject, ICalculaImpostosCat158)
  protected
    FDadosAdicionais: IDadosAdicionaisCalculaImpostosCat158;
    FQuantidadeUtilizada: double;
    FQuantidadeComprada: double;
    FBaseStUnitaria: double;
    FBaseSt: double;
    FAlqSt: double;
    FValorSt: double;
    FValorN15Vbc: double;
    FValorN17Vicms: double;
    FValorN21VbcSt: double;
    FValorN23VicmsSt: double;
    FValorIcmUnitar: double;
    FBaseIcmsStEntrada: double;
    FAlqIcmsStEntrada: double;
  private
    function fRetN15VbcMaiorN21VbcSt: Boolean;
  public
    function fRetBaseStUnitaria: double; virtual;
    function fRetBaseSt: double; virtual;
    function fRetAlqSt: double; virtual;
    function fRetValorSt: double; virtual;

    procedure pSetDadosAdicionais(dados: IDadosAdicionaisCalculaImpostosCat158);
    procedure pSetQuantidadeUtilizada(fltQuantidadeUtilizada: double);
    procedure pSetQuantidadeComprada(fltQuantidadeComprada: double);
    procedure pSetBaseStUnitaria(fltBaseStUnitaria: double);
    procedure pSetBaseSt(fltBaseSt: double);
    procedure pSetAlqSt(fltAlqSt: double);
    procedure pSetValorSt(fltValorSt: double);
    procedure pSetValorN15Vbc(fltValorN15Vbc: double);
    procedure pSetValorN17Vicms(fltValorN17Vicms: double);
    procedure pSetValorN21VbcSt(fltValorN21VbcSt: double);
    procedure pSetValorN23VicmsSt(fltValorN23VicmsSt: double);
    procedure pSetValorIcmUnitar(fltValorIcmUnitar: double);
    procedure pSetBaseIcmsStEntrada(fltBaseIcmsStEntrada: double);
    procedure pSetAlqIcmsStEntrada(fltAlqIcmsStEntrada: double);

  end;

implementation

uses untFuncoes, untFuncoesSimples, untFuncoesConsulta, untConsultas, untFuncoesRelatorios, untZClient;

{ TCalculaImpostos }

function TCalculaImpostos.fRetAlqSt: double;
begin
  Result := FAlqSt;
end;

function TCalculaImpostos.fRetBaseSt: double;
begin
  Result := (FBaseSt / FQuantidadeComprada) * FQuantidadeUtilizada;
end;

function TCalculaImpostos.fRetBaseStUnitaria: double;
begin
  Result := FBaseStUnitaria;
end;

function TCalculaImpostos.fRetN15VbcMaiorN21VbcSt: Boolean;
begin
  Result := ((FValorN21VbcSt > 0) and (FValorN15Vbc > FValorN21VbcSt));
end;

function TCalculaImpostos.fRetValorSt: double;
begin
  if fRetN15VbcMaiorN21VbcSt then
    Result := fFormataFloat((((fFormataFloat(((FBaseIcmsStEntrada * FAlqIcmsStEntrada)/100), 003) / FQuantidadeComprada) - FValorIcmUnitar) * FQuantidadeUtilizada), 003)
  else
    Result := fFormataFloat(fFormataFloat((FValorSt / FQuantidadeComprada), 003) * FQuantidadeUtilizada, 003);

  if Result < 0 then
    Result := 0;
end;

procedure TCalculaImpostos.pSetAlqSt(fltAlqSt: double);
begin
  FAlqSt := fltAlqSt;
end;

procedure TCalculaImpostos.pSetBaseSt(fltBaseSt: double);
begin
  FBaseSt := fltBaseSt;
end;

procedure TCalculaImpostos.pSetBaseStUnitaria(fltBaseStUnitaria: double);
begin
  FBaseStUnitaria := fltBaseStUnitaria;
end;

procedure TCalculaImpostos.pSetDadosAdicionais(dados: IDadosAdicionaisCalculaImpostosCat158);
begin
  FDadosAdicionais := dados;
end;

procedure TCalculaImpostos.pSetQuantidadeComprada(fltQuantidadeComprada: double);
begin
  FQuantidadeComprada := fltQuantidadeComprada;
end;

procedure TCalculaImpostos.pSetQuantidadeUtilizada(fltQuantidadeUtilizada: double);
begin
  FQuantidadeUtilizada := fltQuantidadeUtilizada;
end;

procedure TCalculaImpostos.pSetValorSt(fltValorSt: double);
begin
  FValorSt := fltValorSt;
end;

procedure TCalculaImpostos.pSetValorN15Vbc(fltValorN15Vbc: double);
begin
  FValorN15Vbc := fltValorN15Vbc;
end;

procedure TCalculaImpostos.pSetValorN17Vicms(fltValorN17Vicms: double);
begin
  FValorN17Vicms := fltValorN17Vicms;
end;

procedure TCalculaImpostos.pSetValorN21VbcSt(fltValorN21VbcSt: double);
begin
  FValorN21VbcSt := fltValorN21VbcSt;
end;

procedure TCalculaImpostos.pSetValorN23VicmsSt(fltValorN23VicmsSt: double);
begin
  FValorN23VicmsSt := fltValorN23VicmsSt;
end;

procedure TCalculaImpostos.pSetValorIcmUnitar(fltValorIcmUnitar: double);
begin
  FValorIcmUnitar := fltValorIcmUnitar;
end;

procedure TCalculaImpostos.pSetBaseIcmsStEntrada(fltBaseIcmsStEntrada: double);
begin
  FBaseIcmsStEntrada := fltBaseIcmsStEntrada;
end;

procedure TCalculaImpostos.pSetAlqIcmsStEntrada(fltAlqIcmsStEntrada: double);
begin
  FAlqIcmsStEntrada := fltAlqIcmsStEntrada;
end;

end.
