unit untIDigSenVar;

interface

Uses Classes, untConstantes, UniClientDataSet, untTypesSistema;

Type
   IDigSenVar = Interface
     ['{CABB35DC-5E23-409A-8C9D-27A04F716E15}']
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

end.
