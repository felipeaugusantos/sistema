unit untDepTab;

interface

uses
  Classes;

type
  TDepTab = class
  private
    strAutInc: String;
    strCodCom: String;
    strCodTab: String;
    fltPerCom: Double;
  public
    constructor Create; overload;
    constructor Create(strAutInc, strCodCom, strCodTab: String; fltPerCom: Double); overload;
    function getAutInc: String;
    function getCodCom: String;
    function getCodTab: String;
    function getPerCom: Double;
    procedure setAutInc(strAutInc: String);
    procedure setCodCom(strCodCom: String);
    procedure setCodTab(strCodTab: String);
    procedure setPerCom(fltPerCom: Double);
  end;

  TColDepTab = Class(TList)
  public
    function  fRetorna(pIndex: Integer): TDepTab;
    procedure pAdiciona(pObj: TObject);
  end;

implementation

constructor TDepTab.Create;
begin
  Self.strAutInc := '';
  Self.strCodCom := '';
  Self.strCodTab := '';
  Self.fltPerCom := 0;
end;

constructor TDepTab.Create(strAutInc, strCodCom, strCodTab: String; fltPerCom: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodCom := strCodCom;
  Self.strCodTab := strCodTab;
  Self.fltPerCom := fltPerCom;
end;

function TDepTab.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TDepTab.getCodCom: String;
begin
  Result := Self.strCodCom;
end;

function TDepTab.getCodTab: String;
begin
  Result := Self.strCodTab;
end;

function TDepTab.getPerCom: Double;
begin
  Result := Self.fltPerCom;
end;

procedure TDepTab.setAutInc(strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

procedure TDepTab.setCodCom(strCodCom: String);
begin
  Self.strCodCom := strCodCom;
end;

procedure TDepTab.setCodTab(strCodTab: String);
begin
  Self.strCodTab := strCodTab;
end;

procedure TDepTab.setPerCom(fltPerCom: Double);
begin
  Self.fltPerCom := fltPerCom;
end;

{ TColDepTab }

procedure TColDepTab.pAdiciona(pObj: TObject);
begin
   Self.Add(TDepTab(pObj));
end;

function TColDepTab.fRetorna(pIndex: Integer): TDepTab;
begin
   Result := TDepTab(Self[pIndex]);
end;


end.
