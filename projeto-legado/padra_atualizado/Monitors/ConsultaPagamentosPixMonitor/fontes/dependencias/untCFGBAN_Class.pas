unit untCFGBAN_Class;

interface

Uses Classes, DateUtils, StrUtils, SysUtils;

type
  TCfgBan = class
  private

    FCodEmp: String;
    FCodCFG: String;
    FDescri: String;
    FValCFG: String;
    FCodBan: String;
    FBanco_: String;
    FCartei: String;
    FUltAlt: TDateTime;
    FNumPos: String;
    FCodOpe: String;
    FChave_: String;
    FTipLay: String;

  protected

    function GetBanco_: String;
    function GetCartei: String;
    function GetCodBan: String;
    function GetCodCFG: String;
    function GetCodEmp: String;
    function GetDescri: String;
    function GetUltAlt: TDateTime;
    function GetValCFG: String;
    function GetCodOpe: String;
    function GetNumPos: String;
    function GetChave_: String;
    function GetTipLay: String;

    procedure SetCodOpe(const Value: String);
    procedure SetBanco_(const Value: String);
    procedure SetCartei(const Value: String);
    procedure SetCodBan(const Value: String);
    procedure SetCodCFG(const Value: String);
    procedure SetCodEmp(const Value: String);
    procedure SetDescri(const Value: String);
    procedure SetUltAlt(const Value: TDateTime);
    procedure SetValCFG(const Value: String);
    procedure SetNumPos(const Value: String);
    procedure SetChave_(const Value: String);
    procedure SetTipLay(const Value: String);
  public

    property CodEmp: String read GetCodEmp write SetCodEmp;
    property CodCFG: String read GetCodCFG write SetCodCFG;
    property Descri: String read GetDescri write SetDescri;
    property ValCFG: String read GetValCFG write SetValCFG;
    property CodBan: String read GetCodBan write SetCodBan;
    property Banco_: String read GetBanco_ write SetBanco_;
    property Cartei: String read GetCartei write SetCartei;
    property CodOpe: String read GetCodOpe write SetCodOpe;
    property NumPos: String read GetNumPos write SetNumPos;
    property UltAlt: TDateTime read GetUltAlt write SetUltAlt;
    property Chave_: String read GetChave_ write SetChave_;
    property TipLay: String read GetTipLay write SetTipLay;
  end;


implementation

{ TCfgBan }

function TCfgBan.GetBanco_: String;
begin
  Result := FBanco_;
end;

function TCfgBan.GetCartei: String;
begin
  Result := FCartei;
end;

function TCfgBan.GetChave_: String;
begin
  Result := FChave_;
end;

function TCfgBan.GetCodBan: String;
begin
  Result := FCodBan;
end;

function TCfgBan.GetCodCFG: String;
begin
  Result := FCodCFG;
end;

function TCfgBan.GetCodEmp: String;
begin
  Result := FCodEmp;
end;

function TCfgBan.GetCodOpe: String;
begin
  Result := FCodOpe;
end;

function TCfgBan.GetDescri: String;
begin
  Result := FDescri;
end;

function TCfgBan.GetNumPos: String;
begin
  Result := FNumPos;
end;

function TCfgBan.GetTipLay: String;
begin
  Result := FTipLay;
end;

function TCfgBan.GetUltAlt: TDateTime;
begin
  Result := FUltAlt;
end;

function TCfgBan.GetValCFG: String;
begin
  Result := FValCFG;
end;

procedure TCfgBan.SetBanco_(const Value: String);
begin
  FBanco_ := Value;
end;

procedure TCfgBan.SetCartei(const Value: String);
begin
  FCartei := Value;
end;

procedure TCfgBan.SetChave_(const Value: String);
begin
  FChave_ := Value;
end;

procedure TCfgBan.SetCodBan(const Value: String);
begin
  FCodBan := Value;
end;

procedure TCfgBan.SetCodCFG(const Value: String);
begin
  FCodCFG := Value;
end;

procedure TCfgBan.SetCodEmp(const Value: String);
begin
  FCodEmp := Value;
end;

procedure TCfgBan.SetCodOpe(const Value: String);
begin
  FCodOpe := Value;
end;

procedure TCfgBan.SetDescri(const Value: String);
begin
  FDescri := Value;
end;

procedure TCfgBan.SetNumPos(const Value: String);
begin
  FNumPos := Value;
end;

procedure TCfgBan.SetTipLay(const Value: String);
begin
  FTipLay := Value;
end;

procedure TCfgBan.SetUltAlt(const Value: TDateTime);
begin
  FUltAlt := Value;
end;

procedure TCfgBan.SetValCFG(const Value: String);
begin
  FValCFG := Value;
end;

end.
