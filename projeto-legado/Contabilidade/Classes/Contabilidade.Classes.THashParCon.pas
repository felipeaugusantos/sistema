unit Contabilidade.Classes.THashParCon;

interface

type
  IHashParCon = Interface
    ['{7EF7B034-B4F2-403C-9D16-EAD22E4E55FC}']
    function getHash: string;
  end;

  THashParCon = class(TInterfacedObject, IHashParCon)
  private
    FDesVal: string;
    FForPgo: string;
    FNatOpe: string;
    FTipLan: string;
    FNatCfo: string;
    FSeqPar: string;
    FVigIni: string;
    FVigFin: string;
  public
    constructor Create(strDesVal, strForPgo, strNatOpe, strTipLan, strNatCfo,
      strSeqPar, strvigIni, strVigFin: string);
    class function New(strDesVal, strForPgo, strNatOpe, strTipLan, strNatCfo,
      strSeqPar, strVigIni, strVigFin: string): IHashParCon;
    function getHash: string;
  end;

implementation

uses
  System.Hash, SysUtils;

{ THashParCon }

constructor THashParCon.Create(strDesVal, strForPgo, strNatOpe, strTipLan,
  strNatCfo, strSeqPar, strVigIni, strVigFin: string);
begin
  FDesVal := strDesVal;
  FForPgo := strForPgo;
  FNatOpe := strNatOpe;
  FTipLan := strTipLan;
  FNatCfo := strNatCfo;
  FSeqPar := strSeqPar;
  FVigIni := strVigIni;
  FVigFin := strVigFin;
end;

function THashParCon.getHash: string;
begin
  Result := THashMD5.GetHashString(FDesVal + FForPgo + FNatOpe + FTipLan + FNatCfo
    + FSeqPar + FVigIni + FVigFin + DateToStr(Date)).ToUpper;
end;

class function THashParCon.New(strDesVal, strForPgo, strNatOpe, strTipLan,
  strNatCfo, strSeqPar, strVigIni, strVigFin: string): IHashParCon;
begin
  Result := Self.Create(strDesVal, strForPgo, strNatOpe, strTipLan, strNatCfo,
    strSeqPar, strVigIni, strVigFin);
end;

end.
