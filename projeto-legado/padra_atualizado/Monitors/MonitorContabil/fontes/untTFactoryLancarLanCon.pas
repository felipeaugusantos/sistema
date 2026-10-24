unit untTFactoryLancarLanCon;

interface

uses untIContabilidade;

type
  TFactoryLancarLanCon = Class(TInterfacedObject, IFactoryLancarLanCon)
  private
    function fIsCTP(const strTipLan:string):Boolean ;
  public
    procedure Execute(AParams: IParametrosGeracaoLanCon);
    class function New: IFactoryLancarLanCon;
  end;

implementation

uses
  untTLancarLanCon, untTLancarLanConCtp, untTLancarEstornoLanCon, Contabilidade.Interfaces;

{ TFactoryLancarLanCon }

procedure TFactoryLancarLanCon.Execute(AParams: IParametrosGeracaoLanCon);
begin
  if (AParams.ModLan = MODO_ROBO_2_ESTORNO) then
    TLancarEstornoLanCon.New(AParams).Execute
  else if fIsCTP(AParams.TipLan) then
    TLancarLanConCtp.New(AParams).Execute
  else
    TLancarLanCon.New(AParams).Execute;
end;

function TFactoryLancarLanCon.fIsCTP(const strTipLan: string): Boolean;
begin
  result := True ;
  if strTipLan = 'CTP' then
    exit ;

  if strTipLan = 'PCP' then
    exit ;

  result := False ;
end;

class function TFactoryLancarLanCon.New: IFactoryLancarLanCon;
begin
  Result := Self.Create;
end;

end.
