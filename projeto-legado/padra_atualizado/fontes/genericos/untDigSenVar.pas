unit untDigSenVar;

interface

Uses untIDigSenVar, untConstantes, Classes, UniClientDataSet,
  untTypesSistema;

Type
  TDigSenVar = Class(TInterfacedPersistent, IDigSenVar)

  public
    function fDigSenVar(arrMenSag: TStringArray;
                        strDirAce: String;
                        blnTraTel: boolean;
                        strSenLib, strMsgSen: String;
                        blnMosMen: Boolean;
                        strCodOpe,
                        strCodDig: String;
                        Var strNTrava: String;
                        Var strOperador: String;
                        stlNumLib: TStringList = Nil;
                        strCodIte: String = '';
                        intAutInc: Integer = 0;
                        strDirAceNv2: String = '';
                        strSenLibNv2: String = '';
                        blnNivel2: Boolean = False;
                        strCliente: String = '';
                        strCpfCnpj: String = '';
                        arrMsgLib: TStringArray = Nil;
                        blnUsarSenhaFixa: Boolean = True;
                        blnSempreVariavelUsuario: Boolean = False;
                        blnTablet: Boolean = False;
                        strDirAceNv3: String = '';
                        strSenLibNv3: String = '';
                        blnNivel3: Boolean = False;
                        tipCliFor: TClienteFornecedor = cfCliente;
                        cdsXmlTra: TUniClientDataSet = Nil;
                        blnTelaResumida: Boolean = False;
                        blnIgnInc: Boolean = False;
                        strAssuntoTit: String = '';
                        fltValorVenda: Double = 0;
                        arrHinLin: TStringArray = Nil;
                        strOpeEnv: String = '';
                        blnCamuflarMsgSeConfigurado: Boolean=True;
                        intLargura: Integer = -1): Boolean;
  End;

implementation

uses untFuncFat;

{ TDigSenVar }

function TDigSenVar.fDigSenVar(arrMenSag: TStringArray;
                               strDirAce: String;
                               blnTraTel: boolean;
                               strSenLib, strMsgSen: String;
                               blnMosMen: Boolean;
                               strCodOpe,
                               strCodDig: String;
                               Var strNTrava: String;
                               Var strOperador: String;
                               stlNumLib: TStringList = Nil;
                               strCodIte: String = '';
                               intAutInc: Integer = 0;
                               strDirAceNv2: String = '';
                               strSenLibNv2: String = '';
                               blnNivel2: Boolean = False;
                               strCliente: String = '';
                               strCpfCnpj: String = '';
                               arrMsgLib: TStringArray = Nil;
                               blnUsarSenhaFixa: Boolean = True;
                               blnSempreVariavelUsuario: Boolean = False;
                               blnTablet: Boolean = False;
                               strDirAceNv3: String = '';
                               strSenLibNv3: String = '';
                               blnNivel3: Boolean = False;
                               tipCliFor: TClienteFornecedor = cfCliente;
                               cdsXmlTra: TUniClientDataSet = Nil;
                               blnTelaResumida: Boolean = False;
                               blnIgnInc: Boolean = False;
                               strAssuntoTit: String = '';
                               fltValorVenda: Double = 0;
                               arrHinLin: TStringArray = Nil;
                               strOpeEnv: String = '';
                               blnCamuflarMsgSeConfigurado: Boolean=True;
                               intLargura: Integer = -1): Boolean;
begin
  Result := untFuncFat.fDigSenVar(arrMenSag,
                                  strDirAce,
                                  blnTraTel,
                                  strSenLib,
                                  strMsgSen,
                                  blnMosMen,
                                  strCodOpe,
                                  strCodDig,
                                  strNTrava,
                                  strOperador,
                                  stlNumLib,
                                  strCodIte,
                                  intAutInc,
                                  strDirAceNv2,
                                  strSenLibNv2,
                                  blnNivel2,
                                  strCliente,
                                  strCpfCnpj,
                                  arrMsgLib,
                                  blnUsarSenhaFixa,
                                  blnSempreVariavelUsuario,
                                  blnTablet,
                                  strDirAceNv3,
                                  strSenLibNv3,
                                  blnNivel3,
                                  tipCliFor,
                                  cdsXmlTra,
                                  blnTelaResumida,
                                  blnIgnInc,
                                  strAssuntoTit,
                                  fltValorVenda,
                                  arrHinLin,
                                  strOpeEnv,
                                  blnCamuflarMsgSeConfigurado,
                                  intLargura);

end;

initialization

  RegisterClass(TDigSenVar);

end.
