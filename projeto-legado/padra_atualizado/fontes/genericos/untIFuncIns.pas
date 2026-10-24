unit untIFuncIns;

interface

Type
  IFuncIns = Interface
   ['{63723055-F930-41A4-ACCB-AFBD84AE021A}']
  function fChamaCadReg(Key: Word; strCodReg: String = ''): String;
  function fChamaCadTri(Key: Word): String;
  function fChamaCadMar(Key: Word): String;
  function fChamaCadUni(Key: Word): String;
  function fChamaCadGru(Key: Word): String;
  function fChamaCadEmp(Key: Word): String;
  function fChamaCadCli(Key: Word): String;
  function fChamaCadTra(Key: Word; strCodTra: String = ''): String;
  function fChamaCadMot(Key: Word; strCodMot: String = ''): String;
  function fChamaCadAju(Key: Word; strCodAju: String = ''): String;
  function fChamaCadPor(Key: Word): String;
  function fChamaCadBco(Key: Word): String;
  function fChamaCadCta(Key: Word): String;
  function fChamaCadCfo(Key: Word): String;
  function fChamaCadCar(Key: Word): String;
  function fChamaCadOpe(Key: Word): String;
  function fChamaCadEve(Key: Word): String;
  function fChamaCadCnd(Key: Word): String;
  function fChamaCadFpg(Key: Word): String;
  function fChamaCadIte(Key: Word; strCodIte: String = ''): String;
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
  function fChamaCadFun(Key: Word): String;
  function fChamaCadAcessorio(Key: Word): String;
  function fChamaCadAbreviacaoFiscal(strCodAbf: String): String;
  function fChamaCadLocFisicaConsertoEquip(Key: Word): String;
end;

implementation

end.
