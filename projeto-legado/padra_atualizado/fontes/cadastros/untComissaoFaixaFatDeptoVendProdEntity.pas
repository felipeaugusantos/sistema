unit untComissaoFaixaFatDeptoVendProdEntity;

interface

uses
  SysUtils,
  System.Generics.Collections,
  untFuncoesSimples;

type
  TComissaoFaixaFatDeptoVendProdItemEntity = class
  private
    FstrAutInc : String;
    FstrDepVen : String;
    FstrDepPro : String;
    FfltPerCom : Double;
    FfltPerBon : Double;

    procedure pSetDepVen(strADepVen : String);
    procedure pSetDepPro(strADepPro : String);
  public
    property strAutInc : String  read FstrAutInc write FstrAutInc;
    property strDepVen : String  read FstrDepVen write pSetDepVen;
    property strDepPro : String  read FstrDepPro write pSetDepPro;
    property fltPerCom : Double  read FfltPerCom write FfltPerCom;
    property fltPerBon : Double  read FfltPerBon write FfltPerBon;

    constructor Create();
    destructor Destroy(); override;

    procedure pClear();
  end;

type
  TComissaoFaixaFatDeptoVendProdItemEntityList = class(TObjectList<TComissaoFaixaFatDeptoVendProdItemEntity>)
  private
  public
    function fNew():TComissaoFaixaFatDeptoVendProdItemEntity;
  end;

type
  TComissaoFaixaFatDeptoVendProdEntity = class
  private
    FstrAutInc : String;
    FstrCodFFD : String;
    FstrDesFFD : String;
    FfltMarIni : Double;
    FfltMarFin : Double;
    FfltFatIni : Double;
    FfltFatFin : Double;
    FlstItens  : TComissaoFaixaFatDeptoVendProdItemEntityList;

    procedure pSetCodFDD(strACodFDD : String);
    procedure pSetItens(lstItens : TComissaoFaixaFatDeptoVendProdItemEntityList);
  public
    property strAutInc : String                                       read FstrAutInc write FstrAutInc;
    property strCodFFD : String                                       read FstrCodFFD write pSetCodFDD;
    property strDesFFD : String                                       read FstrDesFFD write FstrDesFFD;
    property fltMarIni : Double                                       read FfltMarIni write FfltMarIni;
    property fltMarFin : Double                                       read FfltMarFin write FfltMarFin;
    property fltFatIni : Double                                       read FfltFatIni write FfltFatIni;
    property fltFatFin : Double                                       read FfltFatFin write FfltFatFin;
    property lstItens  : TComissaoFaixaFatDeptoVendProdItemEntityList read FlstItens  write pSetItens;

    constructor Create();
    destructor Destroy(); override;

    procedure pClear();

    function fFoiCarregado():Boolean;
  end;

implementation

{ TComissaoFaixaFatDeptoVendProdItemEntity }

procedure TComissaoFaixaFatDeptoVendProdItemEntity.pClear;
begin
  FstrAutInc := '';
  FstrDepVen := '';
  FstrDepPro := '';
  FfltPerCom := 0;
  FfltPerBon := 0;
end;

procedure TComissaoFaixaFatDeptoVendProdItemEntity.pSetDepPro(strADepPro: String);
begin
  FstrDepPro := fPreencheEspaco(Trim(strADepPro), 3, False, '0');
end;

procedure TComissaoFaixaFatDeptoVendProdItemEntity.pSetDepVen(strADepVen: String);
begin
  FstrDepVen := fPreencheEspaco(Trim(strADepVen), 3, False, '0');
end;

constructor TComissaoFaixaFatDeptoVendProdItemEntity.Create;
begin
  Self.pClear;
end;

destructor TComissaoFaixaFatDeptoVendProdItemEntity.Destroy;
begin

  inherited;
end;

{ TComissaoFaixaFatDeptoVendProdItemEntityList }

function TComissaoFaixaFatDeptoVendProdItemEntityList.fNew: TComissaoFaixaFatDeptoVendProdItemEntity;
begin
  Result := TComissaoFaixaFatDeptoVendProdItemEntity.Create;
  Self.Add(Result);
end;

{ TComissaoFaixaFatDeptoVendProdEntity }

constructor TComissaoFaixaFatDeptoVendProdEntity.Create;
begin
  FlstItens := TComissaoFaixaFatDeptoVendProdItemEntityList.Create;

  Self.pClear;
end;

destructor TComissaoFaixaFatDeptoVendProdEntity.Destroy;
begin
  If Assigned(FlstItens) Then
    FreeAndNil(FlstItens);

  inherited;
end;

function TComissaoFaixaFatDeptoVendProdEntity.fFoiCarregado: Boolean;
begin
  Result := (Not fEmptyStr(FstrAutInc));
end;

procedure TComissaoFaixaFatDeptoVendProdEntity.pClear;
begin
  FstrAutInc := '';
  FstrCodFFD := '';
  FstrDesFFD := '';
  FfltMarIni := 0;
  FfltMarFin := 0;
  FfltFatIni := 0;
  FfltFatFin := 0;

  FlstItens.Clear;
end;

procedure TComissaoFaixaFatDeptoVendProdEntity.pSetCodFDD(strACodFDD: String);
begin
  FstrCodFFD := fPreencheEspaco(Trim(strACodFDD), 3, False, '0');
end;

procedure TComissaoFaixaFatDeptoVendProdEntity.pSetItens(lstItens: TComissaoFaixaFatDeptoVendProdItemEntityList);
begin
  If Assigned(FlstItens) Then
    FreeAndNil(FlstItens);

  If Assigned(lstItens) Then
    FlstItens := lstItens
  Else
    FLstItens := TComissaoFaixaFatDeptoVendProdItemEntityList.Create;
end;

end.
