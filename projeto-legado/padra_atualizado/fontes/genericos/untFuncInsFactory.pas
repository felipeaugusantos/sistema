unit untFuncInsFactory;

interface

uses untIFuncIns;

  function fChamaCadReg(Key: Word): String;
  function fChamaCadTri(Key: Word): String;
  function fChamaCadMar(Key: Word): String;
  function fChamaCadUni(Key: Word): String;
  function fChamaCadGru(Key: Word): String;
  function fChamaCadEmp(Key: Word): String;
  function fChamaCadCli(Key: Word): String;
  function fChamaCadPor(Key: Word): String;
  function fChamaCadBco(Key: Word): String;
  function fChamaCadCta(Key: Word): String;
  function fChamaCadCfo(Key: Word): String;
  function fChamaCadCar(Key: Word): String;
  function fChamaCadOpe(Key: Word): String;
  function fChamaCadEve(Key: Word): String;
  function fChamaCadCnd(Key: Word): String;
  function fChamaCadFpg(Key: Word): String;
  function fChamaCadIte(Key: Word): String;
  function fChamaCadBan(Key: Word): String;
  function fChamaCadDep(Key: Word): String;
  function fChamaCorVei(Key: Word): String;
  function fChamaModVei(Key: Word): String;
  function fChamaMarVei(Key: Word): String;
  function fChamaTipSer(Key: Word): String;
  function fChamaCadRed(Key: Word): String;
  function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
  function fChamaCadFor(Key: Word; strCodFor : String = ''): String;
  function fChamaCadOco(Key: Word): String;
  function fChamaCadDiv(Key: Word): String;
  function fChamaCadAce(Key: Word): String;
  function fChamaCadPag(Key: Word): String;
  function fChamaTipCli(Key: Word): String;
  function fChamaCadEqu(Key: Word): String;
  function fChamaCadDfe(Key: Word): String;
  function fChamaCadSubReg(Key: Word): String;
  function fChamaCadLocFisAmostraProducao(key: Word): String;
  function fChamaCadGruSer(Key: Word): String;
  function fChamaCadEmbarcacoes(Key: Word): String;
  function fChamaCadLocFisica(Key: Word): String;
  function fChamaCadAcessorio(Key: Word): String;

var
  objIFuncIns : IFuncIns;

implementation

function fChamaCadReg(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadReg(Key);
End;

function fChamaCadTri(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadTri(Key);
End;

function fChamaCadMar(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadMar(Key);
End;

function fChamaCadUni(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadUni(Key);
End;

function fChamaCadGru(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadGru(Key);
End;

function fChamaCadEmp(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadEmp(Key);
End;

function fChamaCadCli(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadCli(Key);
End;

function fChamaCadPor(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadPor(Key);
End;

function fChamaCadBco(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadBco(Key);
End;

function fChamaCadCta(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadReg(Key);
End;

function fChamaCadCfo(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadCfo(Key);
End;

function fChamaCadCar(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadReg(Key);
End;

function fChamaCadOpe(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadOpe(Key);
End;

function fChamaCadEve(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadEve(Key);
End;

function fChamaCadCnd(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadCnd(Key);
End;

function fChamaCadFpg(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadFpg(Key);
End;

function fChamaCadIte(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadIte(Key);
End;

function fChamaCadBan(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadBan(Key);
End;

function fChamaCadDep(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadDep(Key);
End;

function fChamaCorVei(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCorVei(Key);
End;

function fChamaModVei(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaModVei(Key);
End;

function fChamaMarVei(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaMarVei(Key);
End;

function fChamaTipSer(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaTipSer(Key);
End;

function fChamaCadRed(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadRed(Key);
End;

function fChamaCadVei(Key: Word; strPlaVei: String = ''): String;
Begin
  Result := objIFuncIns.fChamaCadVei(Key, strPlaVei);
End;

function fChamaCadFor(Key: Word; strCodFor : String = ''): String;
Begin
  Result := objIFuncIns.fChamaCadFor(Key, strCodFor);
End;

function fChamaCadOco(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadOco(Key);
End;

function fChamaCadDiv(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadDiv(Key);
End;

function fChamaCadAce(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadAce(Key);
End;

function fChamaCadPag(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadPag(Key);
End;

function fChamaTipCli(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaTipCli(Key);
End;

function fChamaCadEqu(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadEqu(Key);
End;

function fChamaCadDfe(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadDfe(Key);
End;

function fChamaCadSubReg(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadSubReg(Key);
End;

function fChamaCadLocFisAmostraProducao(key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadLocFisAmostraProducao(Key);
End;

function fChamaCadGruSer(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadGruSer(Key);
End;

function fChamaCadEmbarcacoes(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadEmbarcacoes(Key);
End;

function fChamaCadLocFisica(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadLocFisica(Key);
End;

function fChamaCadAcessorio(Key: Word): String;
Begin
  Result := objIFuncIns.fChamaCadAcessorio(Key);
End;

end.
