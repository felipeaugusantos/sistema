{************************************************************************}
{* Interface criada para TLiberacao, para trabalhar dlls                *}
{* Em caso de dúvidas, falar com Luiz Oliveira }
{*********************************************************************LO*}
unit untILiberacao;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  Classes, untMsgLiberacao, untTypesSistema, untConstantes;

Type
  ILiberacao = Interface
     ['{FB3C0B6D-22DF-4F09-A458-5C886FAA18C9}']

    function getAutInc: Integer;
    function getCamuflarMsgSeConfigurado: boolean;
    function getCliente: String;
    function getCliFor: TClienteFornecedor;
    function getCodDig: String;
    function getCodIte: String;
    function getCodOpe: String;
    function getCpfCnpj: String;
    function getDirAce: String;
    function getDirAceNv2: String;
    function getDirAceNv3: String;
    function getTelaResumida: boolean;
    function getIgnInc: boolean;
    function getLargura: Integer;
    function getMosMen: Boolean;
    function getMsgLibera: TMensagemLiberacao;
    function getMsgRemota: TMensagemLiberacao;
    function getMsgSen: String;
    function getNivel2: Boolean;
    function getNivel3: Boolean;
    function getNumLib: TStringList;
    function getOpeEnv: String;
    function getOperador: String;
    function getSempreVariavelUsuario: boolean;
    function getSenLib: String;
    function getSenLibNv2: String;
    function getSenLibNv3: String;
    function getTraTel: boolean;
    function getLiberaAcesso: Boolean;
    function getUsarSenhaFixa: boolean;
    function getValorVenda: double;
    function getXmlTra: TUniClientDataSet;
    function getSenFvu: String;
    function getQuantidadeLinhas: Integer;
    function getLimitaQuantidadeDuplicata: Boolean;
    function getCaption: String;
    function getMotivos: String;
    function getNumDoc: String;
    function getEspDoc: String;
    function getCodEmp: String;

    procedure setAutInc( Value: Integer);
    procedure setCamuflarMsgSeConfigurado( Value: boolean);
    procedure setCliente( Value: String);
    procedure setCliFor( Value: TClienteFornecedor);
    procedure setCodDig( Value: String);
    procedure setCodIte( Value: String);
    procedure setCodOpe( Value: String);
    procedure setCpfCnpj( Value: String);
    procedure setDirAce( Value: String);
    procedure setDirAceNv2( Value: String);
    procedure setDirAceNv3( Value: String);
    procedure setTelaResumida( Value: boolean);
    procedure setIgnInc( Value: boolean);
    procedure setLargura( Value: Integer);
    procedure setMosMen( Value: Boolean);
    procedure setMsgLibera( Value : TMensagemLiberacao);
    procedure setMsgRemota( Value: TMensagemLiberacao);
    procedure setMsgSen( Value: String);
    procedure setNivel2( Value: Boolean);
    procedure setNivel3( Value: Boolean);
    procedure setNumLib( Value: TStringList);
    procedure setOpeEnv( Value: String);
    procedure setOperador( Value: String);
    procedure setSempreVariavelUsuario( Value: boolean);
    procedure setSenLib( Value: String);
    procedure setSenLibNv2( Value: String);
    procedure setSenLibNv3( Value: String);
    procedure setTraTel( Value: boolean);
    procedure setLiberaAcesso(Value: Boolean);
    procedure setUsarSenhaFixa( Value: boolean);
    procedure setValorVenda( Value: double);
    procedure setXmlTra( Value: TUniClientDataSet);
    procedure setSenFvu(const Value: String);
    procedure setQuantidadeLinhas(const Value: Integer);
    procedure setLimitaQuantidadeDuplicata(const Value: Boolean);
    procedure setCaption(Value: String);
    procedure setMotivos(const Value: String);

    function fLibera : boolean;
    procedure Clear;
    procedure InicializaObjeto;
    procedure pInformaNumDocEspDocCodEmp(const AstrNumDoc, AstrEspDoc,
      AstrCodEmp: String);

    property strCaption                   : String                read getCaption                  write setCaption                  ;
    property objMsgLibera                 : TMensagemLiberacao    read getMsgLibera                write setMsgLibera                ;
    property objMsgRemota                 : TMensagemLiberacao    read getMsgRemota                write setMsgRemota                ;
    property strDirAce                    : String                read getDirAce                   write setDirAce                   ;
    property blnTraTel                    : boolean               read getTraTel                   write setTraTel                   ;
    property blnLiberaAcesso              : Boolean               read getLiberaAcesso             write setLiberaAcesso             ;
    property strSenLib                    : String                read getSenLib                   write setSenLib                   ;
    property strMsgSen                    : String                read getMsgSen                   write setMsgSen                   ;
    property blnMosMen                    : Boolean               read getMosMen                   write setMosMen                   ;
    property strCodOpe                    : String                read getCodOpe                   write setCodOpe                   ;
    property strCodDig                    : String                read getCodDig                   write setCodDig                   ;
    property strOperador                  : String                read getOperador                 write setOperador                 ;
    property strCodIte                    : String                read getCodIte                   write setCodIte                   ;
    property intAutInc                    : Integer               read getAutInc                   write setAutInc                   ;
    property strCliente                   : String                read getCliente                  write setCliente                  ;
    property strCpfCnpj                   : String                read getCpfCnpj                  write setCpfCnpj                  ;
    property blnCamuflarMsgSeConfigurado  : boolean               read getCamuflarMsgSeConfigurado write setCamuflarMsgSeConfigurado ;
    property tipCliFor                    : TClienteFornecedor    read getCliFor                   write setCliFor                   ;
    property blnUsarSenhaFixa             : boolean               read getUsarSenhaFixa            write setUsarSenhaFixa            ;
    property blnSempreVariavelUsuario     : boolean               read getSempreVariavelUsuario    write setSempreVariavelUsuario    ;
    property strOpeEnv                    : String                read getOpeEnv                   write setOpeEnv                   ;
    property cdsXmlTra                    : TUniClientDataSet     read getXmlTra                   write setXmlTra                   ;
    property blnTelaResumida              : boolean               read getTelaResumida             write setTelaResumida             ;
    property blnIgnInc                    : boolean               read getIgnInc                   write setIgnInc                   ;
    property intLargura                   : Integer               read getLargura                  write setLargura                  ;
    property stlNumLib                    : TStringList           read getNumLib                   write setNumLib                   ;
    property strDirAceNv2                 : String                read getDirAceNv2                write setDirAceNv2                ;
		property strSenLibNv2                 : String                read getSenLibNv2                write setSenLibNv2                ;
		property blnNivel2                    : Boolean               read getNivel2                   write setNivel2                   ;
    property strDirAceNv3                 : String                read getDirAceNv3                write setDirAceNv3                ;
		property strSenLibNv3                 : String                read getSenLibNv3                write setSenLibNv3                ;
		property blnNivel3                    : Boolean               read getNivel3                   write setNivel3                   ;
    property fltValorVenda                : double                read getValorVenda               write setValorVenda               ;
    property strSenFvu                    : String                read getSenFvu                   write setSenFvu                   ;
    property intQuantidadeLinhas          : Integer               read getQuantidadeLinhas         write setQuantidadeLinhas         ;
    property blnLimitaQuantidadeDuplicata : Boolean               read getLimitaQuantidadeDuplicata write setLimitaQuantidadeDuplicata ;
    property strMotivos                   : String                read getMotivos                  write setMotivos;

    property strNumDoc                    : String                read getNumDoc;
    property strEspDoc                    : String                read getEspDoc;
    property strCodEmp                    : String                read getCodEmp;

  end;

implementation

end.

