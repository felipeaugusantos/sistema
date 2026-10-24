{************************************************************************}
{* Objeto criado para gerar as mensagens de liberação do sistema        *}
{************************************************************************}
{* Existe a untLiberacaoFactory, para trabalhar com interface e dlls    *}
{************************************************************************}
{* O objMsgLibera aparece para o usuário, já para as mensagens enviadas *}
{* para o gerente por exemplo, irá aparecer o conteúdo do objMsgLibera, *}
{* mais o conteúdo do objMsgRemota                                      *}
{************************************************************************}
{* Para trabalhar com tabelas, utilizar o objeto específico para isso   *}
{************************************************************************}
{* Para trabalhar com tabelas, ou alinhamentos é necesário declarar     *}
{* untMsgLiberacao                                                      *}
{************************************************************************}
{* Ao montar a mensagem, lembre-se que ela será exibida no autcom e no  *}
{* APP Mobile                                                           *}
{************************************************************************}
{* Em caso de dúvidas, falar com Luiz Oliveira                          *}
{*********************************************************************LO*}

unit untLiberacao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet, Forms, untMensagemSenhaFixa,
{$ENDIF}
  classes, untILiberacao, untMsgLiberacao, untConstantes, untFuncoesGenerica,
  sysutils, strutils, untTypesSistema;

Type
  TLiberacao = class(TInterfacedPersistent, ILiberacao)
  private
    FFreeobjMsgLibera                                              : Boolean;
    FobjMsgLibera                                                  : TMensagemLiberacao;
    FobjMsgRemota                                                  : TMensagemLiberacao;
    FstrCaption                                                    : String;
    FstrDirAce                                                     : String;
    FstrDirAceAuxiliar                                             : String;
    FblnAviso_                                                     : boolean;
    FblnTraTel                                                     : boolean;
    FBlnLiberaAcesso                                               : Boolean;
    FstrSenLib                                                     : String;
    FstrMsgSen                                                     : String;
    FblnMosMen                                                     : Boolean;
    FstrCodOpe                                                     : String;
    FstrCodDig                                                     : String;
    FstrOperador                                                   : String;
    FstrCodIte                                                     : String;
    FintAutInc                                                     : Integer;
    FstrCliente                                                    : String;
    FstrCpfCnpj                                                    : String;
    FblnCamuflarMsgSeConfigurado                                   : boolean;
    FtipCliFor                                                     : TClienteFornecedor;
    FblnUsarSenhaFixa                                              : boolean;
    FblnSempreVariavelUsuario                                      : boolean;
    FstrOpeEnv                                                     : String;
    FcdsXmlTra                                                     : TUniClientDataSet;
    FcdsXmlF4                                                      : TUniClientDataSet;
    FcdsVenda                                                      : TUniClientDataSet;
    FcdsTravaProdMin                                               : TUniClientDataSet;
    FblnTelaResumida                                               : boolean;
    FblnIgnInc                                                     : boolean;
    FintLargura                                                    : Integer;
    FstlNumLib                                                     : TStringList;
    FstrDirAceNv2                                                  : String;
    FstrSenLibNv2                                                  : String;
    FblnNivel2                                                     : Boolean;
    FstrDirAceNv3                                                  : String;
    FstrSenLibNv3                                                  : String;
    FblnNivel3                                                     : Boolean;
    FfltValorVenda                                                 : double;
    FstrSenFvu                                                     : String;
    FblnAnAnalitica                                                : Boolean;
    FblnManterCompatibilidadeSenCfg                                : Boolean;
    FintQuantidadeLinhas                                           : Integer;
    FblnLimitaQuantidadeDuplicata                                  : Boolean;
    FstrNumLib                                                     : String;

    FblnNivel4                                                     : Boolean;
    FstrDirAceNv4                                                  : String;
    FstrSenLibNv4                                                  : String;

    FblnNivel5                                                     : Boolean;
    FstrDirAceNv5                                                  : String;
    FstrSenLibNv5                                                  : String;

    FblnNivel6                                                     : Boolean;
    FstrDirAceNv6                                                  : String;
    FstrSenLibNv6                                                  : String;
    FstrMotivos                                                    : String;
    FblnSomenteMsgRemota                                           : Boolean;

    FOperacaoMultiLojaTravaEstoqueItemAItem                        : Boolean;
    FEmpresaOperacaoMultiLoja                                      : String;

    FConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco : Boolean;

    FJaInformadoDadosCliente                                       : Boolean;
    FstrNumDoc                                                     : String;
    FstrEspDoc                                                     : String;
    FstrCodEmp                                                     : String;
    FstrSequencialUnicoDtaHra                                      : String;
    FpCarregaCodigoLiberadoGerado                                  : TProcCarregaCodigoLiberacao;

    FblnEhTravaItemAItemFinalVenda: Boolean;
    FstrRotina                                                     : String;
    FExibirAvisosTravaRemota : Boolean;
    FstrTotGer                                                     : String;

    FLarguraMotivos                                                : Integer;
    FblnSuprimirNivel                                              : Boolean;

    //getter
    function getAutInc: Integer;
    function getCamuflarMsgSeConfigurado: boolean;
    function getCliente: String;
    function getCliFor: TClienteFornecedor;
    function getCodDig: String;
    function getCodIte: String;
    function getCodOpe: String;
    function getCpfCnpj: String;
    function getDirAce: String;
    function getDirAceAuxiliar: String;
    function getDirAceNv2: String;
    function getDirAceNv3: String;
    function getDirAceNv4: String;
    function getDirAceNv5: String;
    function getDirAceNv6: String;
    function getTelaResumida: boolean;
    function getIgnInc: boolean;
    function getLargura: Integer;
    function getMosMen: Boolean;
    function getMsgLibera: TMensagemLiberacao;
    function getMsgRemota: TMensagemLiberacao;
    function getMsgSen: String;
    function getNivel2: Boolean;
    function getNivel3: Boolean;
    function getNivel4: Boolean;
    function getNivel5: Boolean;
    function getNivel6: Boolean;
    function getNumLib: TStringList;
    function getOpeEnv: String;
    function getOperador: String;
    function getSempreVariavelUsuario: boolean;
    function getSenLib: String;
    function getSenLibNv2: String;
    function getSenLibNv3: String;
    function getSenLibNv4: String;
    function getSenLibNv5: String;
    function getSenLibNv6: String;
    function getTraTel: boolean;
    function getLiberaAcesso: Boolean;
    function getAviso_: boolean;
    function getUsarSenhaFixa: boolean;
    function getValorVenda: double;
    function getXmlTra: TUniClientDataSet;
    function getXmlF4: TUniClientDataSet;
    function getCdsVenda: TUniClientDataSet;
    function getCdsTravaProdMin: TUniClientDataSet;
    function getSenFvu: String;
    function getAnAnalitica: Boolean;
    function getManterCompatibilidadeSenCfg: Boolean;
    function getQuantidadeLinhas: Integer;
    function getLimitaQuantidadeDuplicata: Boolean;
    function getCaption: String;
    function getMotivos: String;
    function getSomenteMsgRemota: Boolean;
    function getOperacaoMultiLojaTravaEstoqueItemAItem : Boolean;
    function getEmpresaOperacaoMultiLoja : String;
    function getCodEmp: String;
    function getEspDoc: String;
    function getNumDoc: String;
    function getSequencialUnicoDtaHra: String;
    function getNumLibPreco: String;

    //setters
    procedure setAutInc( Value: Integer);
    procedure setCamuflarMsgSeConfigurado( Value: boolean);
    procedure setCliente( Value: String);
    procedure setCliFor( Value: TClienteFornecedor);
    procedure setCodDig( Value: String);
    procedure setCodIte( Value: String);
    procedure setCodOpe( Value: String);
    procedure setCpfCnpj( Value: String);
    procedure setDirAce( Value: String);
    procedure setDirAceAuxiliar(const Value: String);
    procedure setDirAceNv2( Value: String);
    procedure setDirAceNv3( Value: String);
    procedure setDirAceNv4( Value: String);
    procedure setDirAceNv5( Value: String);
    procedure setDirAceNv6( Value: String);
    procedure setTelaResumida( Value: boolean);
    procedure setIgnInc( Value: boolean);
    procedure setLargura( Value: Integer);
    procedure setMosMen( Value: Boolean);
    procedure setMsgLibera( Value : TMensagemLiberacao);
    procedure setMsgRemota( Value: TMensagemLiberacao);
    procedure setMsgSen( Value: String);
    procedure setNivel2( Value: Boolean);
    procedure setNivel3( Value: Boolean);
    procedure setNivel4( Value: Boolean);
    procedure setNivel5( Value: Boolean);
    procedure setNivel6( Value: Boolean);
    procedure setNumLib( Value: TStringList);
    procedure setOpeEnv( Value: String);
    procedure setOperador( Value: String);
    procedure setSempreVariavelUsuario( Value: boolean);
    procedure setSenLib( Value: String);
    procedure setSenLibNv2( Value: String);
    procedure setSenLibNv3( Value: String);
    procedure setSenLibNv4( Value: String);
    procedure setSenLibNv5( Value: String);
    procedure setSenLibNv6( Value: String);
    procedure setTraTel( Value: boolean);
    procedure setLiberaAcesso(Value: Boolean);
    procedure setAviso_(const Value: boolean);
    procedure setUsarSenhaFixa( Value: boolean);
    procedure setValorVenda( Value: double);
    procedure setXmlTra( Value: TUniClientDataSet);
    procedure setXmlF4( Value: TUniClientDataSet);
    procedure setCdsVenda( Value: TUniClientDataSet);
    procedure setCdsTravaProdMin( Value: TUniClientDataSet);
    procedure setSenFvu(const Value: String);
    procedure setAnAnalitica(const Value: Boolean);
    procedure setManterCompatibilidadeSenCfg(const Value: Boolean);
    procedure setQuantidadeLinhas(const Value: Integer);
    procedure setLimitaQuantidadeDuplicata(const Value: Boolean);
    procedure setCaption(Value: String);
    procedure setMotivos(const Value: String);
    procedure setSomenteMsgRemoto(Value: Boolean);
    procedure setOperacaoMultiLojaTravaEstoqueItemAItem(AValue : Boolean);
    procedure setEmpresaOperacaoMultiLoja(AValue : String);
    procedure SetCarregaCodigoLiberadoGerado(const Value: TProcCarregaCodigoLiberacao);
    procedure setSequencialUnicoDtaHra(const Value: String);
    function fExibirAvisoTravaRemota: Boolean;
    procedure setNumLibPreco(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;

    function fLibera : boolean;
    function fGetJsonMensagemCompleta : String;
    function fGetJsonMensagemLiberacao : String;
    function fGetJsonMensagemRemota : String;
    procedure Clear;
    procedure InicializaObjeto;
    procedure pInformaDadosCliente;
    procedure pInformaNumDocEspDocCodEmp(const AstrNumDoc, AstrEspDoc,
      AstrCodEmp: String);
    procedure pInformaDadosClienteMsgRemota;

    property objMsgLibera                 : TMensagemLiberacao    read getMsgLibera                write setMsgLibera;
    property objMsgRemota                 : TMensagemLiberacao    read getMsgRemota                write setMsgRemota                ;
    property strCaption                   : String                read getCaption                  write setCaption                  ;
    property strDirAce                    : String                read getDirAce                   write setDirAce                   ;
    property strDirAceAuxiliar            : String                read getDirAceAuxiliar           write setDirAceAuxiliar           ;
    property blnTraTel                    : boolean               read getTraTel                   write setTraTel                   ;
    property blnLiberaAcesso              : Boolean               read getLiberaAcesso             write setLiberaAcesso             ;
    property blnAviso_                    : boolean               read getAviso_                   write setAviso_                   ;
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
    property cdsXmlF4                     : TUniClientDataSet     read getXmlF4                    write setXmlF4                    ;
    property cdsVenda                     : TUniClientDataSet     read getCdsVenda                 write setCdsVenda                 ;
    property cdsTravaProdMin              : TUniClientDataSet     read getCdsTravaProdMin          write setCdsTravaProdMin          ;
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
    property blnAnAnalitica               : Boolean               read getAnAnalitica              write setAnAnalitica              ;
    property blnManterCompatibilidadeSenCfg : Boolean             read getManterCompatibilidadeSenCfg write setManterCompatibilidadeSenCfg;
    property intQuantidadeLinhas          : Integer               read getQuantidadeLinhas         write setQuantidadeLinhas;
    property blnLimitaQuantidadeDuplicata : Boolean               read getLimitaQuantidadeDuplicata write setLimitaQuantidadeDuplicata;
    property strDirAceNv4                 : String                read getDirAceNv4                write setDirAceNv4                ;
    property strSenLibNv4                 : String                read getSenLibNv4                write setSenLibNv4                ;
    property blnNivel4                    : Boolean               read getNivel4                   write setNivel4                   ;
    property strDirAceNv5                 : String                read getDirAceNv5                write setDirAceNv5                ;
    property strSenLibNv5                 : String                read getSenLibNv5                write setSenLibNv5                ;
    property blnNivel5                    : Boolean               read getNivel5                   write setNivel5                   ;
    property strDirAceNv6                 : String                read getDirAceNv6                write setDirAceNv6                ;
    property strSenLibNv6                 : String                read getSenLibNv6                write setSenLibNv6                ;
    property blnNivel6                    : Boolean               read getNivel6                   write setNivel6                   ;
    property strMotivos                   : String                read getMotivos                  write setMotivos                  ;
    property blnSomenteMsgRemota          : Boolean               read getSomenteMsgRemota         write setSomenteMsgRemoto         ;
    property strSequencialUnicoDtaHra     : String                read getSequencialUnicoDtaHra    write setSequencialUnicoDtaHra    ;
    property strNumLib                    : String                read getNumLibPreco              write setNumLibPreco              ;

    property blnOperacaoMultiLojaTravaEstoqueItemAItem : Boolean  read getOperacaoMultiLojaTravaEstoqueItemAItem write setOperacaoMultiLojaTravaEstoqueItemAItem;
    property strEmpresaOperacaoMultiLoja               : String   read getEmpresaOperacaoMultiLoja               write setEmpresaOperacaoMultiLoja;
    property blnConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco : Boolean read FConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco write FConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco;

    property strNumDoc                       : String                      read getNumDoc;
    property strEspDoc                       : String                      read getEspDoc;
    property strCodEmp                       : String                      read getCodEmp;
    property procCarregaCodigoLiberadoGerado : TProcCarregaCodigoLiberacao                                       write SetCarregaCodigoLiberadoGerado;

    property blnEhTravaItemAItemFinalVenda: Boolean               read FblnEhTravaItemAItemFinalVenda            write FblnEhTravaItemAItemFinalVenda;
    property strRotina                      :String                      read FstrRotina                        write FstrRotina;
    property blnExibirAvisosTravaRemota : Boolean read FExibirAvisosTravaRemota write FExibirAvisosTravaRemota;
    property strTotGer                    : String                read FstrTotGer                  write FstrTotGer;
    property intLarguraMotivos            : Integer read FLarguraMotivos write FLarguraMotivos;
    property blnSuprimirNivel             : Boolean read FblnSuprimirNivel write FblnSuprimirNivel;
  end;

implementation

{ TLiberacao }

{$IFDEF LINUX}
{$ELSE}
uses
  untFuncoes,
  untFuncoesSimples,
  untFatLiberacaoCliente;
{$ENDIF}

procedure TLiberacao.Clear;
begin
  FobjMsgLibera.Clear;
  FobjMsgRemota.Clear;
  FExibirAvisosTravaRemota := True;
  FstrDirAce                    := '';
  FstrDirAceAuxiliar            := '';
  FblnTraTel                    := True;
  FBlnLiberaAcesso              := False;
  FblnAviso_                    := False;
  FstrSenLib                    := '';
  FstrMsgSen                    := '';
  FblnMosMen                    := False;
  FstrCodOpe                    := '';
  FstrCodDig                    := '';
  FstrOperador                  := '';
  FstrCodIte                    := '';
  FintAutInc                    := 0;
  FstrCliente                   := '';
  FstrCpfCnpj                   := '';
  FblnCamuflarMsgSeConfigurado  := True;
  FtipCliFor                    := cfCliente;
  FblnUsarSenhaFixa             := True;
  FblnSempreVariavelUsuario     := False;
  FstrOpeEnv                    := '';
  FblnTelaResumida              := False;
  FblnAnAnalitica               := False;
  FblnManterCompatibilidadeSenCfg:= false;
  FJaInformadoDadosCliente      := False;
  FstrNumLib                    := EmptyStr;

  if Assigned(FcdsXmlTra) then
    FreeAndNil(FcdsXmlTra);

  FblnIgnInc                    := False;
  FintLargura                   := -1;
  FstrDirAceNv2                 := '';
  FstrSenLibNv2                 := '';
  FblnNivel2                    := False;
  FstrDirAceNv3                 := '';
  FstrSenLibNv3                 := '';
  FblnNivel3                    := False;
  FfltValorVenda                := 0;
  FstlNumLib.Clear;
  FintQuantidadeLinhas          := 0;
  FblnLimitaQuantidadeDuplicata := False; 

  FblnNivel4                    := False;
  FstrDirAceNv4                 := '';
  FstrSenLibNv4                 := '';

  FblnNivel5                    := False;
  FstrDirAceNv5                 := '';
  FstrSenLibNv5                 := '';

  FblnNivel6                    := False;
  FstrDirAceNv6                 := '';
  FstrSenLibNv6                 := '';
  FstrMotivos                   := 'Motivos';
  FblnSomenteMsgRemota          := False;

  FOperacaoMultiLojaTravaEstoqueItemAItem := False;
  FEmpresaOperacaoMultiLoja               := '';

  FConsiderarAComissaoDoProfissionalEOValorDoFreteNaTravaDePreco := False;

  FstrNumDoc := '';
  FstrEspDoc := '';
  FstrCodEmp := '';

  FblnEhTravaItemAItemFinalVenda := False;

{$IFNDEF LINUX}
  strRotina := FRetornaRotina;
{$ENDIF}

end;

constructor TLiberacao.Create;
begin
  inherited;
  InicializaObjeto;
end;

procedure TLiberacao.InicializaObjeto;
begin
  FblnSuprimirNivel := False;
  FLarguraMotivos := 1024;

  if not Assigned(FobjMsgLibera) then
  Begin
    FobjMsgLibera := TMensagemLiberacao.Create(Application);
    FFreeobjMsgLibera := True;
  End;

  if not Assigned(FobjMsgRemota) then
    FobjMsgRemota := TMensagemLiberacao.Create(Application);

  if not Assigned(FstlNumLib) then
    FstlNumLib    := TStringList.Create;

{$IFNDEF LINUX}
  strRotina := fRetornaRotina;
{$ENDIF}

  clear;
end;

procedure TLiberacao.pInformaDadosCliente;
begin
  If FJaInformadoDadosCliente Then
    Exit;

  If Not fEmptyStr(strCpfCnpj) Then
    FobjMsgLibera.pAddTexto('CPF/CNPJ: ' + fFormataCpfCgc(strCpfCnpj{$IFNDEF LINUX}, fSetaPais{$ENDIF}));

  If Not fEmptyStr(strCliente) Then
  Begin
    {***************************************}
    {* VERIFICA SE É CLIENTE OU FORNECEDOR *}
    {************************************PZ*}
    Case tipCliFor of
      cfFornecedor : objMsgLibera.pAddTexto(STR_FORNECEDOR + strCliente);
      cfCliente    : objMsgLibera.pAddTexto(STR_CLIENTE + strCliente);
    end;
  End;

  FJaInformadoDadosCliente := True;
end;

procedure TLiberacao.pInformaDadosClienteMsgRemota;
  Var
    strCodCli: String;
begin
  If Not fEmptyStr(strCpfCnpj) Then
    FobjMsgRemota.pAddTexto('CPF/CNPJ: ' + fFormataCpfCgc(strCpfCnpj{$IFNDEF LINUX}, fSetaPais{$ENDIF}));

  If Not fEmptyStr(strCliente) Then
  Begin
    strCodCli := LeftStr(strCliente, 8);

    Case tipCliFor of
      cfFornecedor:
      Begin
        objMsgRemota.pAddTexto(STR_FORNECEDOR + strCliente);
        objMsgRemota.pAddTexto('Nome Fantasia: ' + fRetNomFanFor(strCodCli));
      End;

      cfCliente:
      Begin
        objMsgRemota.pAddTexto(STR_CLIENTE + strCliente);
        objMsgRemota.pAddTexto('Nome Fantasia: ' + fRetNomFantasia(strCodCli));
      End;
    end;

  End;
end;

procedure TLiberacao.pInformaNumDocEspDocCodEmp(const AstrNumDoc, AstrEspDoc,
  AstrCodEmp: String);
begin
  FstrNumDoc := AstrNumDoc;
  FstrEspDoc := AstrEspDoc;
  FstrCodEmp := AstrCodEmp;
end;

destructor TLiberacao.Destroy;
begin
  if Assigned(FobjMsgLibera) And FFreeobjMsgLibera then
    FreeAndNil(FobjMsgLibera);

  if Assigned(FobjMsgRemota) then
    FreeAndNil(FobjMsgRemota);

  if Assigned(FstlNumLib) then
    FreeAndNil(FstlNumLib);
  inherited;
end;

function TLiberacao.fExibirAvisoTravaRemota: Boolean;
begin
  Result := True;

  If (Self.blnTraTel) Then
    Exit;

  If (Self.strDirAce = 'NENHUM') Then
    Exit;

  If (Not Self.blnExibirAvisosTravaRemota) Then
    Exit(False);

  If (Not fOperadorVisualizaAvisoTrava) Then
    Exit(False);
end;

function TLiberacao.fGetJsonMensagemCompleta: String;
var
  objMsg : TMensagemLiberacao;

  procedure pAddToMsg(objMsgOri : TMensagemLiberacao);
  var
    objRegistro    : TRegistroMsgLibera;
  begin

    for objRegistro in objMsgOri.lstRegistros do
      objMsg.lstRegistros.Add(objRegistro);

    if (objMsg.strTitulo.IsEmpty) and (not objMsgOri.strTitulo.IsEmpty) then
      objMsg.strTitulo := objMsgOri.strTitulo;

    if (objMsg.strJustificativa.IsEmpty) and (not objMsgOri.strJustificativa.IsEmpty) then
      objMsg.strJustificativa := objMsgOri.strJustificativa;

  end;
begin
  Result := '';

  //Une as duas mensagem e retorna uma string
  objMsg := TMensagemLiberacao.Create(Application);
  objMsg.lstRegistros.OwnsObjects := False; //seta para false para não matar os objetos que estão adicionados em outras listas
  try
    if not FblnSomenteMsgRemota then
      pAddToMsg(FobjMsgLibera);

    pAddToMsg(FobjMsgRemota);

    Result := objMsg.fGetJsonObject.ToJson;
  finally
    FreeAndNil(objMsg);
  end;

end;

function TLiberacao.fGetJsonMensagemLiberacao: String;
var
  objMsg : TMensagemLiberacao;

  procedure pAddToMsg(objMsgOri : TMensagemLiberacao);
  var
    objRegistro    : TRegistroMsgLibera;
  begin

    for objRegistro in objMsgOri.lstRegistros do
      objMsg.lstRegistros.Add(objRegistro);

    if (objMsg.strTitulo.IsEmpty) and (not objMsgOri.strTitulo.IsEmpty) then
      objMsg.strTitulo := objMsgOri.strTitulo;

    if (objMsg.strJustificativa.IsEmpty) and (not objMsgOri.strJustificativa.IsEmpty) then
      objMsg.strJustificativa := objMsgOri.strJustificativa;

  end;
begin
  Result := '';

  //Une as duas mensagem e retorna uma string
  objMsg := TMensagemLiberacao.Create(Application);
  objMsg.lstRegistros.OwnsObjects := False; //seta para false para não matar os objetos que estão adicionados em outras listas
  try
    pAddToMsg(FobjMsgLibera);

    Result := objMsg.fGetJsonObject.ToJson;
  finally
    FreeAndNil(objMsg);
  end;
end;

function TLiberacao.fGetJsonMensagemRemota: String;
var
  objMsg : TMensagemLiberacao;

  procedure pAddToMsg(objMsgOri : TMensagemLiberacao);
  var
    objRegistro    : TRegistroMsgLibera;
  begin

    for objRegistro in objMsgOri.lstRegistros do
      objMsg.lstRegistros.Add(objRegistro);

    if (objMsg.strTitulo.IsEmpty) and (not objMsgOri.strTitulo.IsEmpty) then
      objMsg.strTitulo := objMsgOri.strTitulo;

    if (objMsg.strJustificativa.IsEmpty) and (not objMsgOri.strJustificativa.IsEmpty) then
      objMsg.strJustificativa := objMsgOri.strJustificativa;

  end;
begin
  Result := '';

  //Une as duas mensagem e retorna uma string
  objMsg := TMensagemLiberacao.Create(Application);
  objMsg.lstRegistros.OwnsObjects := False; //seta para false para não matar os objetos que estão adicionados em outras listas
  try
    pAddToMsg(FobjMsgRemota);

    Result := objMsg.fGetJsonObject.ToJson;
  finally

    FreeAndNil(objMsg);
  end;
end;

{$IFDEF LINUX}
function TLiberacao.fLibera: boolean;
begin
  raise Exception.Create('TLiberacao.fLibera nao possui implementacao para compilacao linux');
end;
{$ELSE}
function TLiberacao.fLibera: boolean;
  Var
    strMensagem            : String;
    strSenha               : String;
    strInfBlo              : String;
    objRegistro            : TRegistroMsgLibera;
    objLinha               : TLinhaMsgLibera;
    frmFatLiberacaoCliente : TfrmFatLiberacaoCliente;
    strExpressaoTroca      : String;
    strCodigoLiberacao     : String;

  function fSenhaValidaParaLiberacao: Boolean;
  begin
    Result := True;

    If blnNivel6 Then
    Begin
      If (fEmptyStr(strDirAceNv6))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv6, strLoginUsuarioLogado)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel5 Then
    Begin
      If (fEmptyStr(strDirAceNv5))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv5, strLoginUsuarioLogado)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel4 Then
    Begin
      If (fEmptyStr(strDirAceNv4))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv4, strLoginUsuarioLogado)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel3 Then
    Begin
      If (fEmptyStr(strDirAceNv3))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv3, strLoginUsuarioLogado)) Then
      Begin
        Result := False;
      End;
    End

    Else If blnNivel2 Then
    Begin
      If (fEmptyStr(strDirAceNv2))                               Or
         (Not fVerificaAcessoSistema(strDirAceNv2, strLoginUsuarioLogado)) Then
      Begin
        Result := False;
      End;
    End

    Else If (Not fVerificaAcessoSistema(strDirAce, strLoginUsuarioLogado)) Then
    Begin
      Result := False;
    End;

  end;

begin
  if VS_AutoatendimentoPagueFacil then
  Begin
    Result := False;
    Exit;
  End;

  If Not VS_ExibirMensagemAoUsuario Then
  Begin
    If Assigned(VS_OnMensagemAoUsuario) Then
      VS_OnMensagemAoUsuario(Self.objMsgLibera.fGetMensagem);
    Result := False;
    Exit;
  End;

  If VS_IgnoraTravaAjustePrecoAutorizado Then
  Begin
    Exit(True);
  End;

  Result                := True;
  strMensagem           := '';

  {********************************************************}
  {* CASO UTILIZE SISTEMA DE CREDIARIO E SEJA UMA TRAVA   *}
  {* RELACIONADA COM O MESMO, MOSTRA UMA MENSAGEM PADRAO  *}
  {* E ESCONDE A MENSAGEM ORIGINAL PARA O VENDEDEDOR,     *}
  {* EXIBE SOMENTE PARA O RESPONSAVEL PELA LIBERACAO...   *}
  {*****************************************************JC*}
  If (FblnCamuflarMsgSeConfigurado) And (Pos(FstrDirAce, TRAVAS_CREDIARIO) > 0) And fCfgSis('SISCRE', varBoolean) And (not fClienteFilial(LeftStr(strCliente,8))) Then
  Begin
    FobjMsgRemota.fGetObjectFromJson(FobjMsgLibera.fGetJsonObject.ToJSON);

    FobjMsgLibera.Clear;
    FobjMsgLibera.pAddTexto(MENSAG_CREDIARIO);
  End;

  strMensagem := FobjMsgLibera.fGetMensagem;

  pInformaDadosCliente;

  If FfltValorVenda > 0 then
    FobjMsgLibera.pAddTexto('Valor total da venda: ' + FormatFloat('#,##0.00', FfltValorVenda));

  strInfBlo := FobjMsgRemota.fGetMensagem;

  if fEmptyStr(FstrSenFvu) then
  begin
    FstrSenFvu := fCfgSis('SENFVU');

    If (Not FblnUsarSenhaFixa) Then
      FstrSenFvu := 'V';
  end;

  If (Pos(FstrSenFvu, 'V_U_') > 0) Or (FblnSempreVariavelUsuario) Then
  Begin

    If FobjMsgLibera.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    Try
      pCriarFormularios(TfrmFatLiberacaoCliente, frmFatLiberacaoCliente);
      frmFatLiberacaoCliente.intQuantidadeLinhas         := intQuantidadeLinhas;
      frmFatLiberacaoCliente.blnLimitaQuantidadeDuplicata:= blnLimitaQuantidadeDuplicata;
      frmFatLiberacaoCliente.objLiberacao                := Self;
      frmFatLiberacaoCliente.strMotivos := strMotivos;
      frmFatLiberacaoCliente.lsvMotivos.Columns[0].Width := FLarguraMotivos;
      if not (fVerificaAcessoSistema('PVISPF')) then
      begin
        while Pos('@(', strMensagem) > 1 do
        begin
          strExpressaoTroca := Copy(strMensagem, Pos('@(', strMensagem), Pos(')@', strMensagem) - Pos('@(', strMensagem) + 2);
          strMensagem := AnsiReplaceStr(strMensagem, strExpressaoTroca, '*,**');
        end;
      end;

      strMensagem := fLimpaTagMsgOculta(strMensagem, omlMsgParaQuemReceb);

      frmFatLiberacaoCliente.strMenObs                   := strMensagem;
      frmFatLiberacaoCliente.strSenFvu                   := FstrSenFvu;

      SetLength(frmFatLiberacaoCliente.arrHinLin, 0);

      for objRegistro in objMsgLibera.lstRegistros do
      begin
        case objRegistro.enuTipo of
          trTexto,
          trTextoCaption : pAddDados(frmFatLiberacaoCliente.arrHinLin, TRegistroMsgLiberaTexto(objRegistro).strHint);

          trTabela       : begin
                             for objLinha in TRegistroMsgLiberaTabela(objRegistro).lstLinhas do
                               pAddDados(frmFatLiberacaoCliente.arrHinLin, objLinha.strHint);
                           end;

          else             pAddDados(frmFatLiberacaoCliente.arrHinLin, '');
        end;
      end;

      If (FtipCliFor = cfFornecedor) Then
        frmFatLiberacaoCliente.Caption := 'Liberação de Fornecedor'
      Else
        frmFatLiberacaoCliente.Caption := 'Liberação de Cliente';

      If FintLargura <> - 1 Then
         frmFatLiberacaoCliente.lsvMotivos.Columns[0].Width := FintLargura;

      frmFatLiberacaoCliente.pPreparaDados;
      If (fExibirAvisoTravaRemota) Then
      Begin
        If (Self.blnTraTel) Then
        Begin
          If (fCampoTabela('OPE_SENLIB', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'N') Or
             (fVerificaAcessoMaster(frmFatLiberacaoCliente.strDirAce, strLoginUsuarioLogado)) Then
          Begin
            If fSenhaValidaParaLiberacao Then
            Begin
              frmFatLiberacaoCliente.blnSenLib               := True;
              frmFatLiberacaoCliente.strOperador             := strLoginUsuarioLogado;
              frmFatLiberacaoCliente.lblSenLibMaster.Top     := 41;
              frmFatLiberacaoCliente.lblSenLibMaster.Left    := 6;
              frmFatLiberacaoCliente.lblSenLibMaster.Visible := frmFatLiberacaoCliente.edtSenLib.Visible;
              frmFatLiberacaoCliente.btnTipSenha.Visible     := False;
              frmFatLiberacaoCliente.btnLibera.Visible       := False;
              frmFatLiberacaoCliente.edtSenLib.Visible       := False;
              frmFatLiberacaoCliente.lblSenLib.Visible       := False;
            End
          End;
        End;

        If Self.blnLiberaAcesso Then
          frmFatLiberacaoCliente.btnLibera.Visible       := True;

        frmFatLiberacaoCliente.ShowModal;
      End;

      FstlNumLib.Add(frmFatLiberacaoCliente.strNumLib);

      FstrOperador := frmFatLiberacaoCliente.strOperador;

      if (fCfgSis('ALTVMT', varString) = 'S') and (fCfgSis('TRAREM', varString) = '1') and ((Pos(Copy(FstrDirAce, 1, 5), 'PRMIN_VEMIN_') > 0)) then
        FstrNumLib := frmFatLiberacaoCliente.strNumLib;

      Result := frmFatLiberacaoCliente.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fLibera]');
      End;
    End;

    If Assigned(frmFatLiberacaoCliente) Then
      FreeAndNil(frmFatLiberacaoCliente);

    If (Not FblnTraTel) Then
      Result := True;
  End
  Else
  Begin

    {*************************************}
    { DEFINE QUE O OPERADOR QUE AUTORIZOU }
    { EH O MESMO QUE ESTA LOGADO          }
    {**********************************JB*}
    If fEmptyStr(FstrCodOpe) Then
      FstrCodOpe := strLoginUsuarioLogado;

    FstrOperador := FstrCodOpe;

    If FblnMosMen Then
      TfrmMensagemSenhaFixa.pShowMessage(strMensagem);

    If ffrmSenha(strSenha, FstrMsgSen) Then
    Begin
      {***************************************************************************************}
      {* Foi acrescentado Nivel6, Nivel5 e Nivel4 para atender a necessidade do faturamento. *}
      {*********************************************************************************** BZ*}
      If (FblnNivel6) Then
       Begin
        If (fEmptyStr(FstrSenLibNv6)) Or
           (TRIM(strSenha) <> TRIM(FstrSenLibNv6)) Then
        Begin
          Result := False;
        End;
      End
      Else If (FblnNivel5) Then
      Begin
        If (fEmptyStr(FstrSenLibNv5)) Or
           (TRIM(strSenha) <> TRIM(FstrSenLibNv5)) Then
        Begin
          Result := False;
        End;
      End
      Else If (FblnNivel4) Then
      Begin
        If (fEmptyStr(FstrSenLibNv4)) Or
           (TRIM(strSenha) <> TRIM(FstrSenLibNv4)) Then
        Begin
          Result := False;
        End;
      End
      Else If (FblnNivel3) Then
      Begin
        If (fEmptyStr(FstrSenLibNv3)) Or
           (TRIM(strSenha) <> TRIM(FstrSenLibNv3)) Then
        Begin
          Result := False;
        End;
      End
      Else If (FblnNivel2) Then
      Begin
        If (fEmptyStr(FstrSenLibNv2)) Or
           (TRIM(strSenha) <> TRIM(FstrSenLibNv2)) Then
        Begin
          Result := False;
        End;
      End
      Else If (TRIM(strSenha) <> TRIM(FstrSenLib)) Then
        Result := False;

      If (Not FblnTraTel) Then
        Result := True;
    End
    Else
      Result := False;

    If Result Then
    Begin
      strCodigoLiberacao := fCodigoLiberacaoLogLib(FstrDirAce);
      {**********************}
      {* GERA LOG LIBERACAO *}
      {*******************AF*}
      pGeraMatrizLiberacao(FstrOperador,
                           FstrCodOpe,
                           strMensagem,
                           FstrDirAce,
                           strCodigoLiberacao,
                           FstrCodIte,
                           FintAutInc,
                           '',
                           strInfBlo,
                           False,
                           EmptyStr,
                           0,
                           0,
                           0,
                           EmptyStr,
                           EmptyStr,
                           EmptyStr);

      pGeraLogLiberacao(FstrOperador,
                        FstrCodOpe,
                        strMensagem,
                        FstrDirAce,
                        FstrCodIte,
                        FintAutInc,
                        '',
                        strInfBlo,
                        False,
                        EmptyStr,
                        0,
                        0,
                        0,
                        EmptyStr,
                        EmptyStr,
                        EmptyStr,
                        FstrNumDoc,
                        FstrEspDoc,
                        IIF(not fEmptyStr(FEmpresaOperacaoMultiLoja), FEmpresaOperacaoMultiLoja, FstrCodEmp),
                        strCodigoLiberacao,
                        '',
                        FpCarregaCodigoLiberadoGerado);
    End;
  End;

end;
{$ENDIF}

function TLiberacao.getAnAnalitica: Boolean;
begin
  Result := FblnAnAnalitica;
end;

function TLiberacao.getAutInc: Integer;
begin
  Result := FintAutInc;
end;

function TLiberacao.getAviso_: boolean;
begin
  Result := FblnAviso_;
end;

function TLiberacao.getCamuflarMsgSeConfigurado: boolean;
begin
  Result := FblnCamuflarMsgSeConfigurado;
end;

function TLiberacao.getCliente: String;
begin
  Result := FstrCliente;
end;

function TLiberacao.getCliFor: TClienteFornecedor;
begin
  Result := FtipCliFor;
end;

function TLiberacao.getCodDig: String;
begin
  Result := FstrCodDig;
end;

function TLiberacao.getCodEmp: String;
begin
  Result := FstrCodEmp;
end;

function TLiberacao.getCodIte: String;
begin
  Result := FstrCodIte;
end;

function TLiberacao.getCodOpe: String;
begin
  Result := FstrCodOpe;
end;

function TLiberacao.getCpfCnpj: String;
begin
  Result := FstrCpfCnpj;
end;

function TLiberacao.getDirAce: String;
begin
  Result := FstrDirAce;
end;

function TLiberacao.getDirAceAuxiliar: String;
begin
  Result := FstrDirAceAuxiliar;
end;

function TLiberacao.getDirAceNv2: String;
begin
  Result := FstrDirAceNv2;
end;

function TLiberacao.getDirAceNv3: String;
begin
  Result := FstrDirAceNv3;
end;

function TLiberacao.getTelaResumida: boolean;
begin
  Result := FblnTelaResumida;
end;

function TLiberacao.getIgnInc: boolean;
begin
  Result := FblnIgnInc;
end;

function TLiberacao.getLargura: Integer;
begin
  Result := FintLargura;
end;

function TLiberacao.getManterCompatibilidadeSenCfg: Boolean;
begin
  Result := FblnManterCompatibilidadeSenCfg;
end;

function TLiberacao.getMosMen: Boolean;
begin
  Result := FblnMosMen;
end;

function TLiberacao.getMotivos: String;
begin
  Result := FstrMotivos;
end;

function TLiberacao.getMsgLibera: TMensagemLiberacao;
begin
  Result := FobjMsgLibera;
end;

function TLiberacao.getMsgRemota: TMensagemLiberacao;
begin
  Result := FobjMsgRemota;
end;

function TLiberacao.getMsgSen: String;
begin
  Result := FstrMsgSen;
end;

function TLiberacao.getCaption: String;
begin
  Result := FstrCaption;
end;

function TLiberacao.getCdsTravaProdMin: TUniClientDataSet;
begin
  Result := FcdsTravaProdMin;
end;

function TLiberacao.getCdsVenda: TUniClientDataSet;
begin
  Result := FcdsVenda;
end;

function TLiberacao.getNivel2: Boolean;
begin
  Result := FblnNivel2;
end;

function TLiberacao.getNivel3: Boolean;
begin
  Result := FblnNivel3;
end;

function TLiberacao.getNumDoc: String;
begin
  Result := FstrNumDoc;
end;

function TLiberacao.getNumLib: TStringList;
begin
  Result := FstlNumLib;
end;

function TLiberacao.getNumLibPreco: String;
begin
  Result := FstrNumLib;
end;

function TLiberacao.getOpeEnv: String;
begin
  Result := FstrOpeEnv;
end;

function TLiberacao.getOperacaoMultiLojaTravaEstoqueItemAItem: Boolean;
begin
  Result := FOperacaoMultiLojaTravaEstoqueItemAItem;
end;

function TLiberacao.getOperador: String;
begin
  Result := FstrOperador;
end;

function TLiberacao.getSempreVariavelUsuario: boolean;
begin
  Result := FblnSempreVariavelUsuario;
end;

function TLiberacao.getSenFvu: String;
begin
  Result := FstrSenFvu;
end;

function TLiberacao.getSenLib: String;
begin
  Result := FstrSenLib;
end;

function TLiberacao.getSenLibNv2: String;
begin
  Result := FstrSenLibNv2;
end;

function TLiberacao.getSenLibNv3: String;
begin
  Result := FstrSenLibNv3;
end;

function TLiberacao.getTraTel: boolean;
begin
  Result := FblnTraTel;
end;

function TLiberacao.getUsarSenhaFixa: boolean;
begin
  Result := FblnUsarSenhaFixa;
end;

function TLiberacao.getValorVenda: double;
begin
  Result := FfltValorVenda;
end;

function TLiberacao.getXmlTra: TUniClientDataSet;
begin
  Result := FcdsXmlTra;
end;

function TLiberacao.getXmlF4: TUniClientDataSet;
begin
  Result := FcdsXmlF4;
end;

function TLiberacao.getQuantidadeLinhas: Integer;
begin
  Result:= FintQuantidadeLinhas;
end;

function TLiberacao.getLiberaAcesso: Boolean;
begin
  Result := FBlnLiberaAcesso;
end;

function TLiberacao.getLimitaQuantidadeDuplicata: Boolean;
begin
  Result:= FblnLimitaQuantidadeDuplicata;
end;

procedure TLiberacao.setAnAnalitica(const Value: Boolean);
begin
  FblnAnAnalitica := Value;
end;

procedure TLiberacao.setAutInc( Value: Integer);
begin
  FintAutInc := Value;
end;

procedure TLiberacao.setAviso_(const Value: boolean);
begin
  FblnAviso_ := Value;
end;

procedure TLiberacao.setCamuflarMsgSeConfigurado( Value: boolean);
begin
  FblnCamuflarMsgSeConfigurado := Value;
end;

procedure TLiberacao.setCdsTravaProdMin(Value: TUniClientDataSet);
begin
  FcdsTravaProdMin := Value;
end;

procedure TLiberacao.setCdsVenda(Value: TUniClientDataSet);
begin
  FcdsVenda := Value;
end;

procedure TLiberacao.setCliente( Value: String);
begin
  FstrCliente := Value;
end;

procedure TLiberacao.setCliFor( Value: TClienteFornecedor);
begin
  FtipCliFor := Value;
end;

procedure TLiberacao.setCodDig( Value: String);
begin
  FstrCodDig := Value;
end;

procedure TLiberacao.setCodIte( Value: String);
begin
  FstrCodIte := Value;
end;

procedure TLiberacao.setCodOpe( Value: String);
begin
  FstrCodOpe := Value;
end;

procedure TLiberacao.setCpfCnpj( Value: String);
begin
  FstrCpfCnpj := Value;
end;

procedure TLiberacao.setDirAce( Value: String);
begin
  FstrDirAce := Value;
end;

procedure TLiberacao.setDirAceAuxiliar(const Value: String);
begin
  FstrDirAceAuxiliar := Value;
end;

procedure TLiberacao.setDirAceNv2( Value: String);
begin
  FstrDirAceNv2 := Value;
end;

procedure TLiberacao.setDirAceNv3( Value: String);
begin
  FstrDirAceNv3 := Value;
end;

procedure TLiberacao.setTelaResumida( Value: boolean);
begin
  FblnTelaResumida := Value;
end;

procedure TLiberacao.setIgnInc( Value: boolean);
begin
  FblnIgnInc := Value;
end;

procedure TLiberacao.setLargura( Value: Integer);
begin
  FintLargura := Value;
end;

procedure TLiberacao.setManterCompatibilidadeSenCfg(const Value: Boolean);
begin
  FblnManterCompatibilidadeSenCfg:= Value;
end;

procedure TLiberacao.setMosMen( Value: Boolean);
begin
  FblnMosMen := Value;
end;

procedure TLiberacao.setMotivos(const Value: String);
begin
  FstrMotivos := Value;
end;

procedure TLiberacao.setMsgLibera( Value: TMensagemLiberacao);
begin
  if Assigned(FobjMsgLibera) then
    FreeAndNil(FobjMsgLibera);

  FobjMsgLibera := Value;
  FFreeobjMsgLibera := False;
end;

procedure TLiberacao.setMsgRemota( Value: TMensagemLiberacao);
begin
  FobjMsgRemota := Value;
end;

procedure TLiberacao.setMsgSen( Value: String);
begin
  FstrMsgSen := Value;
end;

procedure TLiberacao.setCaption( Value: String);
begin
  FstrCaption := Value;
end;

procedure TLiberacao.setNivel2( Value: Boolean);
begin
  FblnNivel2 := Value;
end;

procedure TLiberacao.setNivel3( Value: Boolean);
begin
  FblnNivel3 := Value;
end;

procedure TLiberacao.setNumLib( Value: TStringList);
begin
  FstlNumLib := Value;
end;

procedure TLiberacao.setNumLibPreco(const Value: String);
begin
  FstrNumLib := Value;
end;

procedure TLiberacao.setOpeEnv( Value: String);
begin
  FstrOpeEnv := Value;
end;

procedure TLiberacao.setOperacaoMultiLojaTravaEstoqueItemAItem(AValue: Boolean);
begin
  FOperacaoMultiLojaTravaEstoqueItemAItem := AValue;
end;

procedure TLiberacao.setOperador( Value: String);
begin
  FstrOperador := Value;
end;

procedure TLiberacao.setSempreVariavelUsuario( Value: boolean);
begin
  FblnSempreVariavelUsuario := Value;
end;

procedure TLiberacao.setSenFvu(const Value: String);
begin
  FstrSenFvu := Value;
end;

procedure TLiberacao.setSenLib( Value: String);
begin
  FstrSenLib := Value;
end;

procedure TLiberacao.setSenLibNv2( Value: String);
begin
  FstrSenLibNv2 := Value;
end;

procedure TLiberacao.setSenLibNv3( Value: String);
begin
  FstrSenLibNv3 := Value;
end;

procedure TLiberacao.setTraTel( Value: boolean);
begin
  FblnTraTel := Value;
end;

procedure TLiberacao.setUsarSenhaFixa( Value: boolean);
begin
  FblnUsarSenhaFixa := Value;
end;

procedure TLiberacao.setValorVenda( Value: double);
begin
  FfltValorVenda := Value;
end;

procedure TLiberacao.setXmlTra( Value: TUniClientDataSet);
begin
  FcdsXmlTra := Value;
end;

procedure TLiberacao.setXmlF4( Value: TUniClientDataSet);
begin
  FcdsXmlF4 := Value;
end;

procedure TLiberacao.setQuantidadeLinhas(const Value: Integer);
begin
  FintQuantidadeLinhas:= Value;
end;

procedure TLiberacao.setLiberaAcesso(Value: Boolean);
begin
  FBlnLiberaAcesso := Value;
end;

procedure TLiberacao.setLimitaQuantidadeDuplicata(const Value: Boolean);
begin
  FblnLimitaQuantidadeDuplicata:= Value;
end;

function TLiberacao.getDirAceNv4: String;
begin
  Result := FstrDirAceNv4;
end;

function TLiberacao.getDirAceNv5: String;
begin
  Result := FstrDirAceNv5;
end;

function TLiberacao.getDirAceNv6: String;
begin
  Result := FstrDirAceNv6;
end;

function TLiberacao.getEmpresaOperacaoMultiLoja: String;
begin
  Result := FEmpresaOperacaoMultiLoja;
end;

function TLiberacao.getEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TLiberacao.getSenLibNv4: String;
begin
  Result := FstrSenLibNv4;
end;

function TLiberacao.getSenLibNv5: String;
begin
  Result := FstrSenLibNv5;
end;

function TLiberacao.getSenLibNv6: String;
begin
  Result := FstrSenLibNv6;
end;

function TLiberacao.getSequencialUnicoDtaHra: String;
begin
  Result := FstrSequencialUnicoDtaHra;
end;

function TLiberacao.getSomenteMsgRemota: Boolean;
begin
  Result := FblnSomenteMsgRemota;
end;

function TLiberacao.getNivel4: Boolean;
begin
  Result := FblnNivel4;
end;

function TLiberacao.getNivel5: Boolean;
begin
  Result := FblnNivel5;
end;

function TLiberacao.getNivel6: Boolean;
begin
  Result := FblnNivel6;
end;

procedure TLiberacao.setDirAceNv4( Value: String);
begin
  FstrDirAceNv4 := Value;
end;

procedure TLiberacao.setDirAceNv5( Value: String);
begin
  FstrDirAceNv5 := Value;
end;

procedure TLiberacao.setDirAceNv6( Value: String);
begin
  FstrDirAceNv6 := Value;
end;

procedure TLiberacao.setEmpresaOperacaoMultiLoja(AValue: String);
begin
  FEmpresaOperacaoMultiLoja := AValue;
end;

procedure TLiberacao.SetCarregaCodigoLiberadoGerado(
  const Value: TProcCarregaCodigoLiberacao);
begin
  FpCarregaCodigoLiberadoGerado := Value;
end;

procedure TLiberacao.setSenLibNv4( Value: String);
begin
  FstrSenLibNv4 := Value;
end;

procedure TLiberacao.setSenLibNv5( Value: String);
begin
  FstrSenLibNv5 := Value;
end;

procedure TLiberacao.setSenLibNv6( Value: String);
begin
  FstrSenLibNv6 := Value;
end;

procedure TLiberacao.setSequencialUnicoDtaHra(const Value: String);
begin
  FstrSequencialUnicoDtaHra := Value;
end;

procedure TLiberacao.setSomenteMsgRemoto(Value: Boolean);
begin
  FblnSomenteMsgRemota := Value;
end;

procedure TLiberacao.setNivel4( Value: Boolean);
begin
  FblnNivel4 := Value;
end;

procedure TLiberacao.setNivel5( Value: Boolean);
begin
  FblnNivel5 := Value;
end;

procedure TLiberacao.setNivel6( Value: Boolean);
begin
  FblnNivel6 := Value;
end;

initialization

  RegisterClass(TLiberacao);

end.
