unit untIdentificadorTinta;

interface

uses
  untIIdentificadorTinta, untAutcomDllTinta;

type
  TIdentificadorTinta = class(TInterfacedObject, IIdentificadorTinta)
  private
    strIdePro: string;
    fltVolPro: Double;
    intAcao: Integer;
    strCatalize: string;
    strCodDil: string;
    strDescri: string;
    strDilCon: string;
    strIteCob: string;
    strIteTin: string;
    intLazQua: Integer;
    strLinTin: string;
    fltPorCat: Double;
    fltPorDil: Double;
    fltQtdEmb: Double;
    fltQtdIte: Double;
    strTextBase: string;
    strTipCor: string;
    strTipPre: string;
    fGTinForGeral: TfGTinForGeral;
  public
    function GetIdePro: string;
    function GetVolPro: Double;
    function GetfGTinForGeral: TfGTinForGeral;
    function GetAcao: Integer;
    function GetCatalize: string;
    function GetCodDil: string;
    function GetDescri: string;
    function GetDilCon: string;
    function GetIteCob: string;
    function GetIteTin: string;
    function GetLazQua: Integer;
    function GetLinTin: string;
    function GetPorCat: Double;
    function GetPorDil: Double;
    function GetQtdEmb: Double;
    function GetQtdIte: Double;
    function GetTextBase: string;
    function GetTipCor: string;
    function GetTipPre: string;
  public
    constructor Create(const strIdePro: string; const fltVolPro: Double; const intAcao: Integer; const strCatalize,
      strCodDil, strDescri, strDilCon, strIteCob, strIteTin: string; const intLazQua: Integer; const strLinTin: string; const blnPPGPM: Boolean;
      const fltPorCat, fltPorDil, fltQtdEmb, fltQtdIte: Double; const strTextBase, strTipCor, strTipPre: string;
      const fGTinForGeral: TfGTinForGeral);
  end;


implementation

{ TIdentificadorTinta }



constructor TIdentificadorTinta.Create(const strIdePro: string; const fltVolPro: Double; const intAcao: Integer; const strCatalize,
  strCodDil, strDescri, strDilCon, strIteCob, strIteTin: string; const intLazQua: Integer; const strLinTin: string; const blnPPGPM: Boolean;
  const fltPorCat, fltPorDil, fltQtdEmb, fltQtdIte: Double; const strTextBase, strTipCor, strTipPre: string;
  const fGTinForGeral: TfGTinForGeral);
begin
  inherited Create();
  Self.strIdePro := strIdePro;
  Self.fltVolPro := fltVolPro;
  Self.intAcao := intAcao;
  Self.strCatalize := strCatalize;
  Self.strCodDil := strCodDil;
  Self.strDescri := strDescri;
  Self.strDilCon := strDilCon;
  Self.strIteCob := strIteCob;
  Self.strIteTin := strIteTin;
  Self.intLazQua := intLazQua;
  Self.strLinTin := strLinTin;
  Self.fltPorCat := fltPorCat;
  Self.fltPorDil := fltPorDil;
  Self.fltQtdEmb := fltQtdEmb;
  Self.fltQtdIte := fltQtdIte;
  Self.strTextBase := strTextBase;
  Self.strTipCor := strTipCor;
  Self.strTipPre := strTipPre;
  Self.fGTinForGeral := fGTinForGeral;
end;

function TIdentificadorTinta.GetAcao: Integer;
begin
  Result := intAcao;
end;

function TIdentificadorTinta.GetCatalize: string;
begin
  Result := strCatalize;
end;

function TIdentificadorTinta.GetCodDil: string;
begin
  Result := strCodDil;
end;

function TIdentificadorTinta.GetDescri: string;
begin
  Result := strDescri;
end;

function TIdentificadorTinta.GetDilCon: string;
begin
  Result := strDilCon;
end;

function TIdentificadorTinta.GetfGTinForGeral: TfGTinForGeral;
begin
  Result := fGTinForGeral;
end;

function TIdentificadorTinta.GetIdePro: string;
begin
  Result := strIdePro;
end;

function TIdentificadorTinta.GetIteCob: string;
begin
  Result := strIteCob;
end;

function TIdentificadorTinta.GetIteTin: string;
begin
  Result := strIteTin;
end;

function TIdentificadorTinta.GetLazQua: Integer;
begin
  Result := intLazQua;
end;

function TIdentificadorTinta.GetLinTin: string;
begin
  Result := strLinTin;
end;

function TIdentificadorTinta.GetPorCat: Double;
begin
  Result := fltPorCat;
end;

function TIdentificadorTinta.GetPorDil: Double;
begin
  Result := fltPorDil;
end;

function TIdentificadorTinta.GetQtdEmb: Double;
begin
  Result := fltQtdEmb;
end;

function TIdentificadorTinta.GetQtdIte: Double;
begin
  Result := fltQtdIte;
end;

function TIdentificadorTinta.GetTextBase: string;
begin
  Result := strTextBase;
end;

function TIdentificadorTinta.GetTipCor: string;
begin
  Result := strTipCor;
end;

function TIdentificadorTinta.GetTipPre: string;
begin
  Result := strTipPre;
end;

function TIdentificadorTinta.GetVolPro: Double;
begin
  Result := fltVolPro;
end;

end.
