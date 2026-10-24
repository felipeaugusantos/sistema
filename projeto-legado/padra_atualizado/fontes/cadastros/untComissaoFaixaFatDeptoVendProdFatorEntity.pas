unit untComissaoFaixaFatDeptoVendProdFatorEntity;

interface

uses
  SysUtils,
  System.Generics.Collections,
  untFuncoesSimples;

type
  TComissaoFaixaFatDeptoVendProdFatorItemEntity = class
  private
    FstrAutInc : String;
    FstrDepVen : String;
    FstrDepPro : String;
    FfltFatCom : Double;
    FfltPerBon : Double;

    procedure pSetDepVen(strADepVen : String);
    procedure pSetDepPro(strADepPro : String);
  public
    property strAutInc : String  read FstrAutInc write FstrAutInc;
    property strDepVen : String  read FstrDepVen write pSetDepVen;
    property strDepPro : String  read FstrDepPro write pSetDepPro;
    property fltFatCom : Double  read FfltFatCom write FfltFatCom;
    property fltPerBon : Double  read FfltPerBon write FfltPerBon;

    constructor Create();
    destructor Destroy(); override;

    procedure pClear();
  end;

type
  TComissaoFaixaFatDeptoVendProdFatorItemEntityList = class(TObjectList<TComissaoFaixaFatDeptoVendProdFatorItemEntity>)
  private
  public
    function fNew():TComissaoFaixaFatDeptoVendProdFatorItemEntity;
  end;

type
  TComissaoFaixaFatDeptoVendProdFatorEntity = class
  private
    FstrAutInc : String;
    FstrCodFDF : String;
    FstrDesFDF : String;
    FfltMarIni : Double;
    FfltMarFin : Double;
    FfltFatIni : Double;
    FfltFatFin : Double;
    FlstItens  : TComissaoFaixaFatDeptoVendProdFatorItemEntityList;

    procedure pSetCodFDF(strACodFDF : String);
    procedure pSetItens(lstItens : TComissaoFaixaFatDeptoVendProdFatorItemEntityList);
  public
    property strAutInc : String                                       read FstrAutInc write FstrAutInc;
    property strCodFDF : String                                       read FstrCodFDF write pSetCodFDF;
    property strDesFDF : String                                       read FstrDesFDF write FstrDesFDF;
    property fltMarIni : Double                                       read FfltMarIni write FfltMarIni;
    property fltMarFin : Double                                       read FfltMarFin write FfltMarFin;
    property fltFatIni : Double                                       read FfltFatIni write FfltFatIni;
    property fltFatFin : Double                                       read FfltFatFin write FfltFatFin;
    property lstItens  : TComissaoFaixaFatDeptoVendProdFatorItemEntityList read FlstItens  write pSetItens;

    constructor Create();
    destructor Destroy(); override;

    procedure pClear();

    function fFoiCarregado():Boolean;
  end;

implementation

{ TComissaoFaixaFatDeptoVendProdFatorItemEntity }

procedure TComissaoFaixaFatDeptoVendProdFatorItemEntity.pClear;
begin
  FstrAutInc := '';
  FstrDepVen := '';
  FstrDepPro := '';
  FfltFatCom := 0;
  FfltPerBon := 0;
end;

procedure TComissaoFaixaFatDeptoVendProdFatorItemEntity.pSetDepPro(strADepPro: String);
begin
  FstrDepPro := fPreencheEspaco(Trim(strADepPro), 3, False, '0');
end;

procedure TComissaoFaixaFatDeptoVendProdFatorItemEntity.pSetDepVen(strADepVen: String);
begin
  FstrDepVen := fPreencheEspaco(Trim(strADepVen), 3, False, '0');
end;

constructor TComissaoFaixaFatDeptoVendProdFatorItemEntity.Create;
begin
  Self.pClear;
end;

destructor TComissaoFaixaFatDeptoVendProdFatorItemEntity.Destroy;
begin

  inherited;
end;

{ TComissaoFaixaFatDeptoVendProdFatorItemEntityList }

function TComissaoFaixaFatDeptoVendProdFatorItemEntityList.fNew: TComissaoFaixaFatDeptoVendProdFatorItemEntity;
begin
  Result := TComissaoFaixaFatDeptoVendProdFatorItemEntity.Create;
  Self.Add(Result);
end;

{ TComissaoFaixaFatDeptoVendProdFatorEntity }

constructor TComissaoFaixaFatDeptoVendProdFatorEntity.Create;
begin
  FlstItens := TComissaoFaixaFatDeptoVendProdFatorItemEntityList.Create;

  Self.pClear;
end;

destructor TComissaoFaixaFatDeptoVendProdFatorEntity.Destroy;
begin
  If Assigned(FlstItens) Then
    FreeAndNil(FlstItens);

  inherited;
end;

function TComissaoFaixaFatDeptoVendProdFatorEntity.fFoiCarregado: Boolean;
begin
  Result := (Not fEmptyStr(FstrAutInc));
end;

procedure TComissaoFaixaFatDeptoVendProdFatorEntity.pClear;
begin
  FstrAutInc := '';
  FstrCodFDF := '';
  FstrDesFDF := '';
  FfltMarIni := 0;
  FfltMarFin := 0;
  FfltFatIni := 0;
  FfltFatFin := 0;

  FlstItens.Clear;
end;

procedure TComissaoFaixaFatDeptoVendProdFatorEntity.pSetCodFDF(strACodFDF: String);
begin
  FstrCodFDF := fPreencheEspaco(Trim(strACodFDF), 3, False, '0');
end;

procedure TComissaoFaixaFatDeptoVendProdFatorEntity.pSetItens(lstItens: TComissaoFaixaFatDeptoVendProdFatorItemEntityList);
begin
  If Assigned(FlstItens) Then
    FreeAndNil(FlstItens);

  If Assigned(lstItens) Then
    FlstItens := lstItens
  Else
    FLstItens := TComissaoFaixaFatDeptoVendProdFatorItemEntityList.Create;
end;

end.
