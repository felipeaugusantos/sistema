unit untIIdentificadorTinta;

interface

uses
  untAutcomDllTinta;

type
  IIdentificadorTinta = interface
    ['{FC9F79AC-68D8-4F80-939F-ED87562AC7C8}']
    function GetfGTinForGeral: TfGTinForGeral;
    function GetIdePro: string;
    function GetVolPro: Double;
    function GetIteTin: string;
    function GetTipPre: string;
    function GetLinTin: string;
    function GetCatalize: string;
    function GetLazQua: Integer;
    function GetQtdEmb: Double;
    function GetQtdIte: Double;
    function GetDescri: string;
    function GetCodDil: string;
    function GetPorDil: Double;
    function GetDilCon: string;
    function GetPorCat: Double;
    function GetTipCor: string;
    function GetTextBase: string;
    function GetAcao: Integer;
    function GetIteCob: string;

    property fGTinForGeral: TfGTinForGeral read GetfGTinForGeral;
    property IdePro: String read GetIdePro;
    property VolPro: Double read GetVolPro;
    property IteTin: string read GetIteTin;
    property TipPre: string read GetTipPre;
    property LinTin: string read GetLinTin;
    property Catalize: string read GetCatalize;
    property LazQua: Integer read GetLazQua;
    property QtdEmb: Double read GetQtdEmb;
    property QtdIte: Double read GetQtdIte;
    property Descri: string read GetDescri;
    property CodDil: string read GetCodDil;
    property PorDil: Double read GetPorDil;
    property DilCon: string read GetDilCon;
    property PorCat: Double read GetPorCat;
    property TipCor: string read GetTipCor;
    property TextBase: string read GetTextBase;
    property Acao: Integer read GetAcao;
    property IteCob: string read GetIteCob;
  end;


implementation

end.
