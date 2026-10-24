unit untNfeDinamico;

{
  Impressao dinamica da NF-e (provedor NOTA_FISCAL): contexto, funcoes FLD_FUNC e
  datasets com os mesmos nomes do ACBr.
}

interface

uses
{$IF Defined(LINUX)}
  FMX.frxClass, FMX.frxDBSet,
{$ELSE}
  frxClass, frxDBSet,
{$IFEND}
  SysUtils, Classes, Variants, DB, Contnrs, XMLIntf,
  untUniClientDataSet, untNfsDinamico, untNFe, ACBrNFeDANFEClass;

const
  // provedor reservado (criado pelo script 003)
  cstProvedorNotaFiscal = 'NOTA_FISCAL';

type
  // Dados da nota informados por quem imprime (TImpressaoNFe). Nao e dono do dsDoc.
  TNfeDinEntrada = class
  public
    strProvedor: String;
    strXml: String;
    strAcesso: String;
    strCodEmp: String;
    strNumDoc: String;
    strEspDoc: String;
    strSerie: String;
    dsDoc: TDataSet; // resultado da S1 (pCarregaDados) = fonte @DOC
    constructor Create;
  end;

  TNfeDinContexto = class(TNfdContexto)
  private
    FEntrada: TNfeDinEntrada;
    FDM: TObject; // TACBrNFeFRClass
    FDanfe: TACBrNFeDANFEClass;
    FNFe: TNFe;
    // Parametros (calculados uma vez, como em TACBrNFeFRClass.CarregaParametros)
    FblnParamOk: Boolean;
    FstrResumo, FstrMensagem0, FstrChaveDesc, FstrContID, FstrContDesc,
    FstrContValor, FstrConsulta, FstrNProt: String;
    FblnChaveDesc, FblnContDesc, FblnContValor, FblnNProt, FblnDhRecbto: Boolean;
    FdtaDhRecbto: TDateTime;
    // Logo / marca d'agua (convertidos uma vez)
    FblnImagensOk, FblnLogoOk, FblnMDaguaOk: Boolean;
    FstmLogo, FstmMDagua: TMemoryStream;
    // InformacoesAdicionais (calculadas uma vez)
    FblnInfOk: Boolean;
    FstrBufferInfCpl: String;
    FintLinhasObs: Integer;
    function fItem(AIndice: Integer): TDetCollectionItem;
    function fDanfeProp(const ANome: String; out AValor: String): Boolean;
    function fFormataQtd(AValor: Double): String;
    function fFormataVUn(AValor: Double): String;
    procedure pUnidadeQtdVlr(AItem: TDetCollectionItem; out AUnidade, AQuantidade,
      AValorUnit: String; out AQtdProduto: Double; out AAtribuido: Boolean);
    procedure pCalculaParametros;
    procedure pCalculaImagens;
    procedure pCalculaInfAdic;
    procedure pAgrupaNcm(ACds: TUniClientDataSet);
    function fCampoRegistro(AField: TField; const ANome: String): String;
    function fExibeDuplicata: Boolean;
  public
    constructor Create(AEntrada: TNfeDinEntrada; ADM: TObject; ADanfe: TACBrNFeDANFEClass);
    destructor Destroy; override;
    procedure pDefineNFe(ANFe: TNFe);
    function fMarcador(const ANome: String; out AValor: Variant): Boolean; override;
    function fDataSetDoc(const ANome: String): TDataSet; override;
    function fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
      AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean; override;
    procedure pPosProcessa(const APosPrc: String; ACds: TUniClientDataSet); override;
    function fChaveAcesso: String; override;
  end;

  TNfeDinamico = class
  private
    FEntrada: TNfeDinEntrada;
    FDM: TObject;
    FDanfe: TACBrNFeDANFEClass;
    FContexto: TNfeDinContexto;
    FlstNomes: TStringList;   // CDS_NOMCDS, na ordem de CDS_ORDEM
    FlstCampos: TObjectList;  // um TObjectList (de TNfdCampo) por dataset
    FlstFrx: TObjectList;     // TfrxDBDataset (dono)
    FlstCds: TObjectList;     // TUniClientDataSet (dono)
    FarrDefs: array of TNfdDefCds;
    FXmlDoc: IXMLDocument;
    FstrXmlCarregado: String;  // XML (original) carregado no FXmlDoc
    // so referencia (o dono e o DM do ACBr)
    FReport: TfrxReport;
    procedure pLiberaDataSets;
  public
    constructor Create(AEntrada: TNfeDinEntrada; ADM: TObject; ADanfe: TACBrNFeDANFEClass);
    destructor Destroy; override;
    class function fDisponivel(const AProvedor: String): Boolean;
    procedure pCriarEstrutura(AReport: TfrxReport);
    procedure pPreencher(ANFe: TNFe);
    function fDataSet(const ANome: String): TUniClientDataSet;
    // comparador do editor: datasets do ACBr x datasets do motor
    class procedure pComparar(ADM: TObject; AResultado: TStrings);
  end;

implementation

uses
{$IF Defined(UNIDAC)}
  Uni,
{$ELSE}
  ZDataset,
{$IFEND}
{$IF Defined(LINUX)}
  FMX.Graphics,
{$ELSE}
  Graphics,
{$IFEND}
  StrUtils, Math, DateUtils, TypInfo, XMLDoc, ACBrUtil, ACBrValidador, ACBrDFeUtil, ACBrNFe,
  untConversao, untConversaoNFe, untImagemBase64, untUtil, ACBrNFeDANFEFRDM;

type
  TQueryNfeDin = {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

const
  cstMaskValor = '###,###,##0.00';

function fSimNao(ABool: Boolean): String;
begin
  if ABool then
    Result := 'S'
  else
    Result := 'N';
end;

function fTextoXmlParaCurr(const AValor: Variant): Currency;
var
  strValor: String;
  extValor: Extended;
  intCod: Integer;
begin
  // mesma leitura do ACBr: texto do XML (decimal '.') -> Currency (ex.: vProd, qCom)
  Result := 0;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  if not VarIsStr(AValor) then
  begin
    Result := AValor;
    Exit;
  end;
  strValor := Trim(VarToStr(AValor));
  if strValor = '' then
    Exit;
  Val(strValor, extValor, intCod);
  if intCod = 0 then
    Result := extValor;
end;

function fTextoXmlParaDouble(const AValor: Variant): Double;
var
  strValor: String;
  extValor: Extended;
  intCod: Integer;
begin
  // mesma leitura do ACBr: texto do XML (decimal '.') -> Double (ex.: vUnCom)
  Result := 0;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  if not VarIsStr(AValor) then
  begin
    Result := AValor;
    Exit;
  end;
  strValor := Trim(VarToStr(AValor));
  if strValor = '' then
    Exit;
  Val(strValor, extValor, intCod);
  if intCod = 0 then
    Result := extValor;
end;

function fTextoXmlParaData(const AValor: Variant): TDateTime;
var
  strValor: String;
  intAno, intMes, intDia: Integer;
begin
  // tcDat do ACBr: yyyy-mm-dd (vazio = 0)
  Result := 0;
  if VarIsNull(AValor) or VarIsEmpty(AValor) then
    Exit;
  strValor := Trim(VarToStr(AValor));
  if Length(strValor) < 10 then
    Exit;
  intAno := StrToIntDef(Copy(strValor, 1, 4), 0);
  intMes := StrToIntDef(Copy(strValor, 6, 2), 0);
  intDia := StrToIntDef(Copy(strValor, 9, 2), 0);
  if not TryEncodeDate(intAno, intMes, intDia, Result) then
    Result := 0;
end;

{ TNfeDinEntrada }

constructor TNfeDinEntrada.Create;
begin
  inherited Create;
  strProvedor := cstProvedorNotaFiscal;
  dsDoc := nil;
end;

{ TNfeDinContexto }

constructor TNfeDinContexto.Create(AEntrada: TNfeDinEntrada; ADM: TObject; ADanfe: TACBrNFeDANFEClass);
begin
  inherited Create;
  FEntrada := AEntrada;
  FDM := ADM;
  FDanfe := ADanfe;
  FNFe := nil;
  FstmLogo := nil;
  FstmMDagua := nil;
end;

destructor TNfeDinContexto.Destroy;
begin
  FreeAndNil(FstmLogo);
  FreeAndNil(FstmMDagua);
  inherited;
end;

procedure TNfeDinContexto.pDefineNFe(ANFe: TNFe);
begin
  FNFe := ANFe;
  FblnParamOk := False;
  FblnImagensOk := False;
  FblnInfOk := False;
end;

function TNfeDinContexto.fItem(AIndice: Integer): TDetCollectionItem;
begin
  Result := nil;
  if (FNFe <> nil) and (AIndice >= 1) and (AIndice <= FNFe.Det.Count) then
    Result := FNFe.Det.Items[AIndice - 1];
end;

function TNfeDinContexto.fCampoRegistro(AField: TField; const ANome: String): String;
var
  fldOutro: TField;
begin
  // valor de outro campo do registro corrente (ja preenchido: FLD_ORDEM)
  Result := '';
  if (AField = nil) or (AField.DataSet = nil) then
    Exit;
  fldOutro := AField.DataSet.FindField(ANome);
  if fldOutro <> nil then
    Result := fldOutro.AsString;
end;

function TNfeDinContexto.fDanfeProp(const ANome: String; out AValor: String): Boolean;
var
  strNome: String;
begin
  // propriedades Citel do DANFE preenchidas por TImpressaoNFe.Imprimir
  Result := True;
  AValor := '';
  strNome := UpperCase(Trim(ANome));
  if strNome = 'DADOSCNDFPG' then AValor := FDanfe.DadosCndFpg
  else if strNome = 'NUMEROPEDIDOSFATURADOS' then AValor := FDanfe.NumeroPedidosFaturados
  else if strNome = 'DTENTR' then AValor := FDanfe.DtEntr
  else if strNome = 'ENTREGARETIRA' then AValor := FDanfe.EntregaRetira
  else if strNome = 'TRANSPCODTRA' then AValor := FDanfe.TranspCodTra
  else if strNome = 'TRANSPNOMTRA' then AValor := FDanfe.TranspNomTra
  else if strNome = 'TRANSPENDERE' then AValor := FDanfe.TranspEndere
  else if strNome = 'TRANSPBAIRRO' then AValor := FDanfe.TranspBairro
  else if strNome = 'TRANSPCIDADE' then AValor := FDanfe.TranspCidade
  else if strNome = 'TRANSPESTADO' then AValor := FDanfe.TranspEstado
  else if strNome = 'ROMANEIO' then AValor := FDanfe.Romaneio
  else if strNome = 'CODBOX' then AValor := FDanfe.CodBox
  else if strNome = 'DESREG' then AValor := FDanfe.DesReg
  else if strNome = 'VENDEDOR' then AValor := FDanfe.Vendedor
  else if strNome = 'NUMROM' then AValor := FDanfe.NumRom
  else if strNome = 'PLACAVEICULO' then AValor := FDanfe.PlacaVeiculo
  else if strNome = 'KMVEICULO' then AValor := FDanfe.KMVeiculo
  else if strNome = 'INFADICDANFESIMPLIFICADO' then AValor := FDanfe.InfAdicDanfeSimplificado
  else if strNome = 'TOMADORCOMPLENDER' then AValor := FDanfe.TomadorComplEnder
  else if strNome = 'TOMADORCELULAR' then AValor := FDanfe.TomadorCelular
  else if strNome = 'TOMADORFONE2' then AValor := FDanfe.TomadorFone2
  else if strNome = 'TOMADORNOMFANTASIA' then AValor := FDanfe.TomadorNomFantasia
  else if strNome = 'TELENT' then AValor := FDanfe.TelEnt
  else if strNome = 'WHATSAPP' then AValor := FDanfe.WhatsApp
  else if strNome = 'PONIMP' then AValor := FDanfe.PonImp
  else if strNome = 'RAZSOC' then AValor := FDanfe.RazSoc
  else if strNome = 'EMAIL' then AValor := FDanfe.Email
  else if strNome = 'HOMEPAGE' then AValor := FDanfe.Homepage
  else if strNome = 'FONE2' then AValor := FDanfe.Fone2
  else if strNome = 'SITE' then AValor := FDanfe.Site
  else if strNome = 'FAX' then AValor := FDanfe.Fax
  else if strNome = 'USUARIO' then AValor := FDanfe.Usuario
  else if strNome = 'SISTEMA' then AValor := FDanfe.Sistema
  else
    Result := False;
end;

function TNfeDinContexto.fFormataQtd(AValor: Double): String;
begin
  // TACBrNFeFRClass.FormatQuantidade (iFormato/Casas_qCom/Mask_qCom de Parametros)
  case Integer(FDanfe.CasasDecimais.Formato) of
    0: Result := FormatFloatBr(AValor, FloatMask(FDanfe.CasasDecimais._qCom));
    1: Result := FormatFloatBr(AValor, FDanfe.CasasDecimais._Mask_qCom);
  else
    Result := FormatFloatBr(AValor, FloatMask(FDanfe.CasasDecimais._qCom));
  end;
end;

function TNfeDinContexto.fFormataVUn(AValor: Double): String;
begin
  // TACBrNFeFRClass.FormatValorUnitario (iFormato/Casas_vUnCom/Mask_vUnCom de Parametros)
  case Integer(FDanfe.CasasDecimais.Formato) of
    0: Result := FormatFloatBr(AValor, FloatMask(FDanfe.CasasDecimais._vUnCom));
    1: Result := FormatFloatBr(AValor, FDanfe.CasasDecimais._Mask_vUnCom);
  else
    Result := FormatFloatBr(AValor, FloatMask(StrToIntDef(FDanfe.CasasDecimais._Mask_vUnCom, 0)));
  end;
end;

procedure TNfeDinContexto.pUnidadeQtdVlr(AItem: TDetCollectionItem; out AUnidade, AQuantidade,
  AValorUnit: String; out AQtdProduto: Double; out AAtribuido: Boolean);
var
  dm: TACBrNFeFRClass;
  strUCom, strUTrib: String;
  dblQCom, dblQTrib, dblVUnCom, dblVUnTrib: Double;
begin
  // mesma regra de CarregaDadosProdutos (ImprimirUnQtVlComercial)
  dm := TACBrNFeFRClass(FDM);
  AUnidade := '';
  AQuantidade := '';
  AValorUnit := '';
  AQtdProduto := 1;
  AAtribuido := True;

  strUCom    := Copy(AItem.Prod.uCom, 1, 6);
  strUTrib   := Copy(AItem.Prod.uTrib, 1, 6);
  dblQCom    := AItem.Prod.qCom;
  dblQTrib   := AItem.Prod.qTrib;
  dblVUnCom  := AItem.Prod.vUnCom;
  dblVUnTrib := AItem.Prod.vUnTrib;

  case dm.ImprimirUnQtVlComercial of
    iuComercial:
      begin
        AUnidade    := strUCom;
        AQuantidade := fFormataQtd(dblQCom);
        AValorUnit  := fFormataVUn(dblVUnCom);
        AQtdProduto := dblQCom;
      end;
    iuTributavel:
      begin
        AUnidade    := strUTrib;
        AQuantidade := fFormataQtd(dblQTrib);
        AValorUnit  := fFormataVUn(dblVUnTrib);
        AQtdProduto := dblQTrib;
      end;
    iuComercialETributavel:
      begin
        if strUCom = strUTrib then
        begin
          AUnidade    := strUCom;
          AQuantidade := fFormataQtd(dblQCom);
          AValorUnit  := fFormataVUn(dblVUnCom);
          AQtdProduto := dblQCom;
        end
        else
        begin
          AUnidade    := FDanfe.ManterUnidades(strUCom, strUTrib);
          AQuantidade := FDanfe.ManterQuantidades(dblQCom, dblQTrib);
          AValorUnit  := FDanfe.ManterValoresUnitarios(dblVUnCom, dblVUnTrib);
          AQtdProduto := dblQCom;
          if dblQTrib > 0 then
            AQtdProduto := dblQTrib;
        end;
      end;
  else
    AAtribuido := False;
  end;
end;

procedure TNfeDinContexto.pCalculaParametros;
var
  intP: Integer;
begin
  // reproduz TACBrNFeFRClass.CarregaParametros; o que o ACBr nao atribui fica nulo
  if FblnParamOk then
    Exit;
  FblnParamOk := True;

  FstrResumo    := '';
  FstrMensagem0 := '';
  FstrContID    := '';
  FstrConsulta  := 'Consulta de autenticidade no portal nacional da NF-e'+#13+
                   'www.nfe.fazenda.gov.br/portal ou no site da Sefaz autorizadora';
  FblnChaveDesc := False;
  FstrChaveDesc := '';
  FblnContDesc  := False;
  FstrContDesc  := '';
  FblnContValor := False;
  FstrContValor := '';
  FblnNProt     := False;
  FstrNProt     := '';
  FblnDhRecbto  := False;
  FdtaDhRecbto  := 0;

  if FNFe = nil then
    Exit;

  if FDanfe.ExibirResumoCanhoto then
  begin
    if EstaVazio(FDanfe.ExibirResumoCanhoto_Texto) then
      FstrResumo := ACBrStr('Emissão: ' )+ FormatDateBr(FNFe.Ide.DEmi) + '  Dest/Reme: ' + FNFe.Dest.XNome + '  Valor Total: ' + FormatFloatBr(FNFe.Total.ICMSTot.VNF)
    else
      FstrResumo := FDanfe.ExibirResumoCanhoto_Texto;
  end;

  if (FNFe.Ide.TpAmb = taHomologacao) then
  begin
    if (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teSCAN, teDPEC, teSVCAN, teSVCRS, teSVCSP]) then
    begin
      if (FNFe.procNFe.cStat in [101,135, 151, 155]) then
        FstrMensagem0 := ACBrStr('NFe sem Valor Fiscal - HOMOLOGAÇÃO ' +
                                 #10#13+'NFe em Contingência - CANCELADA')
      else
        FstrMensagem0 := ACBrStr('NFe sem Valor Fiscal - HOMOLOGAÇÃO'+
                                 #10#13+'NFe em Contingência');
    end
    else
      FstrMensagem0 := ACBrStr( 'NFe sem Valor Fiscal - HOMOLOGAÇÃO')
  end
  else
  begin
    if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teSVCAN, teSVCRS, teSVCSP]) then
    begin
      if (FDanfe.NFeCancelada) or
         ((NaoEstaVazio(FNFe.procNFe.nProt)) and
          (FNFe.procNFe.cStat in [101,135,151,155])) then
        FstrMensagem0 := 'NFe Cancelada'
      else if ( FNFe.procNFe.cStat = 110 ) or
              ( FNFe.procNFe.cStat = 301 ) or
              ( FNFe.procNFe.cStat = 302 ) or
              ( FNFe.procNFe.cStat = 303 ) then
        FstrMensagem0 := 'NFe denegada pelo Fisco'
      else if ((EstaVazio(FDanfe.ProtocoloNFe)) and
               (EstaVazio(FNFe.procNFe.nProt))) then
        FstrMensagem0 := ACBrStr( 'NFe sem Autorização de Uso da SEFAZ')
      else if (FNFe.Ide.tpImp = tiSimplificado) then
        FstrMensagem0 := ACBrStr( 'EMISSÃO NORMAL' );
    end;
  end;

  case FNFe.Ide.tpEmis of
    teNormal,
    teSVCAN,
    teSCAN,
    teSVCRS,
    teSVCSP :   begin
                  FblnChaveDesc := True;
                  FstrChaveDesc := 'CHAVE DE ACESSO';
                  FstrContID := '';

                  FblnContDesc := True;
                  if ((FDanfe.NFeCancelada) or (FNFe.procNFe.cStat in [101,151,155])) then
                    FstrContDesc := ACBrStr('PROTOCOLO DE HOMOLOGAÇÃO DO CANCELAMENTO' )
                  else if ( FNFe.procNFe.cStat = 110 ) or
                          ( FNFe.procNFe.cStat = 301 ) or
                          ( FNFe.procNFe.cStat = 302 ) or
                          ( FNFe.procNFe.cStat = 303 ) then
                    FstrContDesc := ACBrStr('PROTOCOLO DE DENEGAÇÃO DE USO')
                  else
                    FstrContDesc := ACBrStr('PROTOCOLO DE AUTORIZAÇÃO DE USO');

                  FblnContValor := True;
                  if EstaVazio(FDanfe.ProtocoloNFe) then
                  begin
                    if EstaVazio(FNFe.procNFe.nProt) then
                      FstrContValor := ACBrStr('NFe sem Autorização de Uso da SEFAZ')
                    else
                    begin
                      FstrContValor := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                      FblnNProt := True;
                      FstrNProt := FNFe.procNfe.nProt;
                      FblnDhRecbto := True;
                      FdtaDhRecbto := FNFe.procNFe.dhRecbto;
                    end;
                  end
                  else
                  begin
                    FstrContValor := FDanfe.ProtocoloNFe;
                    intP := Pos('-', FDanfe.ProtocoloNFe);
                    FblnNProt := True;
                    FblnDhRecbto := True;
                    if intP = 0 then
                    begin
                      FstrNProt := Trim(FDanfe.ProtocoloNFe);
                      FdtaDhRecbto := 0;
                    end
                    else
                    begin
                      FstrNProt := Trim(Copy(FDanfe.ProtocoloNFe, 1, intP - 1));
                      FdtaDhRecbto := StringToDateTimeDef(Trim(
                        Copy(FDanfe.ProtocoloNFe, intP + 1, Length(FDanfe.ProtocoloNFe) - intP)
                        ), 0, 'dd/mm/yyyy hh:nn:ss');
                    end;
                  end;
                end;

    teContingencia ,
    teFSDA :    begin
                  FstrContID := TACBrNFe(FDanfe.ACBrNFe).GerarChaveContingencia(FNFe);
                  FblnChaveDesc := True;
                  FstrChaveDesc := 'CHAVE DE ACESSO';
                  FblnContDesc := True;
                  FstrContDesc := 'DADOS DA NF-E';
                  FblnContValor := True;
                  FstrContValor := FormatarChaveAcesso(FstrContID);
                  FstrConsulta := '';
                end;

     teDPEC  :  begin
                  FblnContDesc := True;
                  if NaoEstaVazio(FNFe.procNFe.nProt) then // DPEC TRANSMITIDO
                  begin
                    FstrContDesc := ACBrStr( 'PROTOCOLO DE AUTORIZAÇÃO DE USO');
                    FblnContValor := True;
                    FstrContValor := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                  end
                  else
                  begin
                    FstrContDesc := ACBrStr('NÚMERO DE REGISTRO DPEC');
                    if NaoEstaVazio(FDanfe.ProtocoloNFe) then
                    begin
                      FblnContValor := True;
                      FstrContValor := FDanfe.ProtocoloNFe;
                    end;
                  end;
                end;

     teOffLine: begin
                  FblnContValor := True;
                  FstrContValor := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                  FblnNProt := True;
                  FstrNProt := FNFe.procNfe.nProt;
                  FblnDhRecbto := True;
                  FdtaDhRecbto := FNFe.procNFe.dhRecbto;
                end;
  end;
end;

procedure TNfeDinContexto.pCalculaImagens;
{$IF not Defined(LINUX)}
var
  img: TPicture;
{$IFEND}
begin
  // logo e marca d'agua: mesma conversao do CarregaParametros (Base64 -> bitmap)
  if FblnImagensOk then
    Exit;
  FblnImagensOk := True;
  FblnLogoOk := False;
  FblnMDaguaOk := False;
  FreeAndNil(FstmLogo);
  FreeAndNil(FstmMDagua);

{$IF not Defined(LINUX)}
  if NaoEstaVazio(FDanfe.Logo) then
  begin
    img := TPicture.Create;
    try
      FstmLogo := TMemoryStream.Create;
      ConverterBase64ParaImagem(FDanfe.Logo, img);
      try
        img.Bitmap.SaveToStream(FstmLogo);
        FblnLogoOk := True;
      except on E: Exception do
        ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
      end;
    finally
      FreeAndNil(img);
    end;
  end;

  if NaoEstaVazio(FDanfe.MarcaDagua) then
  begin
    img := TPicture.Create;
    try
      FstmMDagua := TMemoryStream.Create;
      ConverterBase64ParaImagem(FDanfe.MarcaDagua, img);
      try
        img.Bitmap.SaveToStream(FstmMDagua);
        FblnMDaguaOk := True;
      except on E: Exception do
        ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
      end;
    finally
      FreeAndNil(img);
    end;
  end;
{$IFEND}
end;

procedure TNfeDinContexto.pCalculaInfAdic;
var
  dm: TACBrNFeFRClass;
  vTemp: TStringList;
  IndexCampo: Integer;
  Campos: TSplitResult;
  wObs: String;
begin
  // reproduz o inicio de TACBrNFeFRClass.CarregaInformacoesAdicionais
  if FblnInfOk then
    Exit;
  FblnInfOk := True;
  FintLinhasObs := 0;
  FstrBufferInfCpl := '';
  if FNFe = nil then
    Exit;

  dm := TACBrNFeFRClass(FDM);
  vTemp := TStringList.Create;
  try
    wObs := FDanfe.ManterDocreferenciados(FNFe, dm.ImprimirDadosDocReferenciados, ';');
    wObs := dm.ManterInfAdi(wObs);
    wObs := dm.ManterContingencia(wObs);
    if Trim(wObs) <> '' then
    begin
      Campos := Split(';', wObs);
      for IndexCampo := 0 to Length(Campos) - 1 do
        vTemp.Add(Campos[IndexCampo]);

      FintLinhasObs := 1;
      FstrBufferInfCpl := vTemp.Text;
    end;
  finally
    FreeAndNil(vTemp);
  end;
end;

function TNfeDinContexto.fExibeDuplicata: Boolean;
var
  cdsProd: TUniClientDataSet;
  strCFOP: String;
  dm: TACBrNFeFRClass;
begin
  // mesma condicao de CarregaDuplicatas (CFOP do registro corrente de DadosProdutos)
  Result := False;
  if FNFe = nil then
    Exit;
  dm := TACBrNFeFRClass(FDM);
  strCFOP := '';
  cdsProd := fDataSetPorNome('DadosProdutos');
  if (cdsProd <> nil) and cdsProd.Active and (cdsProd.FindField('CFOP') <> nil) then
    strCFOP := cdsProd.FieldByName('CFOP').AsString;

  Result := (not (dm.ExibeCampoFatura and (FNFe.Ide.indPag = ipVista) and (FNFe.infNFe.Versao <= 3.10))) and
            FDanfe.ExibirDuplicata and
            (Pos(strCFOP, FDanfe.CFOPTransf) = 0);
end;

function TNfeDinContexto.fMarcador(const ANome: String; out AValor: Variant): Boolean;
var
  dm: TACBrNFeFRClass;
begin
  Result := True;
  AValor := Null;
  dm := TACBrNFeFRClass(FDM);

  if ANome = 'ACESSO' then AValor := FEntrada.strAcesso
  else if ANome = 'CODEMP' then AValor := FEntrada.strCodEmp
  else if ANome = 'NUMDOC' then AValor := FEntrada.strNumDoc
  else if ANome = 'ESPDOC' then AValor := FEntrada.strEspDoc
  else if ANome = 'SERIE' then AValor := FEntrada.strSerie
  else if ANome = 'CANCELADA' then AValor := fSimNao(FDanfe.NFeCancelada)
  else if ANome = 'REIMPRESSAO' then AValor := fSimNao(FDanfe.Reimpressao)
  else if ANome = 'NUMVIA' then AValor := FDanfe.NumDaVia
  else if ANome = 'QTDVOL' then AValor := FDanfe.QtdVolume
  else if ANome = 'CLASSIFIVENDA' then AValor := fSimNao(FDanfe.ClassifiVenda)
  else if ANome = 'POSCANHOTO' then AValor := IntToStr(Ord(FDanfe.PosCanhoto))
  else if ANome = 'LOGO' then AValor := FDanfe.Logo
  else if ANome = 'MDAGUA' then AValor := FDanfe.MarcaDagua
  else if ANome = 'URLQRC' then AValor := FDanfe.QrCodeDadosAdicionais
  else if ANome = 'EXIBECAMPOFATURA' then AValor := fSimNao(dm.ExibeCampoFatura)
  else if ANome = 'EXIBIRDUPLICATA' then AValor := fSimNao(FDanfe.ExibirDuplicata)
  else if ANome = 'CFOPTRANSF' then AValor := FDanfe.CFOPTransf
  else if ANome = 'EXIBIRLOCALRETIRA' then AValor := FDanfe.ExibirLocalRetira
  else if ANome = 'UFAGRUPANCM' then AValor := FDanfe.UFAgrupaNCM
  else if FNFe = nil then
    Result := False
  else if ANome = 'VERSAO' then AValor := FNFe.infNFe.Versao
  else if ANome = 'INDPAG' then AValor := IndpagToStr(FNFe.Ide.IndPag)
  else if ANome = 'IFORMA' then AValor := Integer(FNFe.Ide.indPag)
  else if ANome = 'INFCPL' then AValor := FNFe.InfAdic.infCpl
  else if ANome = 'INFADFISCO' then AValor := FNFe.InfAdic.infAdFisco
  else if ANome = 'FATNFAT' then AValor := FNFe.Cobr.Fat.nFat
  else if ANome = 'RETIRADACNPJCPF' then AValor := FNFe.Retirada.CNPJCPF
  // condicoes de existencia de registro, com a MESMA expressao Delphi do ACBr
  else if ANome = 'DUPLICATAEXIBE' then AValor := fSimNao(fExibeDuplicata)
  else if ANome = 'FATURAEXIBE' then
    AValor := fSimNao(dm.ExibeCampoFatura and
      not (((FNFe.infNFe.Versao >= 4) or (FNFe.Ide.indPag = ipOutras)) and EstaVazio(FNFe.Cobr.Fat.nFat)))
  else if ANome = 'LOCALRETIRADAEXIBE' then
    AValor := fSimNao((FDanfe.ExibirLocalRetira = 'NFE-RETIRA') and NaoEstaVazio(FNFe.Retirada.CNPJCPF))
  else if ANome = 'LOCALENTREGAEXIBE' then
    // na pratica o ACBr so exige o logradouro de entrega
    AValor := fSimNao(NaoEstaVazio(FNFe.Entrega.XLgr))
  else
    Result := False;
end;

function TNfeDinContexto.fDataSetDoc(const ANome: String): TDataSet;
begin
  Result := nil;
  if SameText(Trim(ANome), '@DOC') then
    Result := FEntrada.dsDoc;
end;

function TNfeDinContexto.fAplicaFuncao(const AFuncao: String; AParams: TStrings; const AValor: Variant;
  AEncontrado: Boolean; AField: TField; const ANoRegistro: IXMLNode; AIndice: Integer): Boolean;
var
  dm: TACBrNFeFRClass;
  item: TDetCollectionItem;
  strValor, strAux, strUnidade, strQuantidade, strValorUnit: String;
  dblQtdProduto: Double;
  blnAtribuido: Boolean;
  cdsDest: TUniClientDataSet;
  i, nPos: Integer;
  strNfRef: String;
{$IF not Defined(LINUX)}
  img: TPicture;
  vStream: TStream;
{$IFEND}

  function fParam(AIdx: Integer): String;
  begin
    Result := '';
    if (AParams <> nil) and (AIdx < AParams.Count) then
      Result := AParams[AIdx];
  end;

begin
  Result := True;
  dm := TACBrNFeFRClass(FDM);
  strValor := '';
  if not (VarIsNull(AValor) or VarIsEmpty(AValor)) then
    strValor := VarToStr(AValor);

  { ------------------------------ genericas ------------------------------ }
  if AFuncao = 'INT' then
    AField.AsString := IntToStr(StrToIntDef(Trim(strValor), 0))
  else if AFuncao = 'INTNUM' then
    AField.AsFloat := StrToIntDef(Trim(strValor), 0)
  else if AFuncao = 'MILHAR' then
    AField.AsString := FormatFloat(',0', StrToIntDef(Trim(strValor), 0))
  else if AFuncao = 'VALOR' then
    AField.AsString := FormatFloatBr(fTextoXmlParaCurr(AValor), cstMaskValor)
  else if AFuncao = 'CURR' then
    AField.AsFloat := fTextoXmlParaCurr(AValor)
  else if AFuncao = 'DBL' then
    AField.AsFloat := fTextoXmlParaDouble(AValor)
  else if AFuncao = 'DATA' then
    AField.AsString := FormatDateBr(fTextoXmlParaData(AValor))
  else if AFuncao = 'DATADUP' then
  begin
    // duplicata: a linha "em branco" (sem dup, AIndice = 0) o ACBr grava vazia
    if AIndice = 0 then
      AField.AsString := ''
    else
      AField.AsString := FormatDateBr(fTextoXmlParaData(AValor));
  end
  else if AFuncao = 'COLLATE' then
    AField.AsString := dm.CollateBr(strValor)
  else if AFuncao = 'CNPJ' then
    AField.AsString := FormatarCNPJ(strValor)
  else if AFuncao = 'CNPJCPF' then
    AField.AsString := FormatarCNPJouCPF(strValor)
  else if AFuncao = 'CEP' then
    AField.AsString := FormatarCEP(strValor)
  else if AFuncao = 'CEPCITEL' then
    AField.AsString := fFormataCEP(strValor)
  else if AFuncao = 'FONE' then
    AField.AsString := FormatarFone(strValor)
  else if AFuncao = 'FONECITEL' then
    AField.AsString := fFormataFone(strValor)
  else if AFuncao = 'SEMPONTOVIRG' then
    AField.AsString := StringReplace(strValor, ';', #13, [rfReplaceAll])
  else if AFuncao = 'NRO' then
    AField.AsString := dm.ManterNro(strValor)
  else if AFuncao = 'ONLYNUMBER' then
    AField.AsString := OnlyNumber(strValor)
  else if AFuncao = 'CHAVE' then
    AField.AsString := FormatarChaveAcesso(strValor)
  else if AFuncao = 'TRIM' then
    AField.AsString := Trim(strValor)
  else if AFuncao = 'UPPER' then
    AField.AsString := UpperCase(strValor)
  else if AFuncao = 'INTZERO' then
  begin
    // INTZERO(n): zero ou ausente vira n (como o tcInt do ACBr)
    nPos := StrToIntDef(OnlyNumber(strValor), 0);
    if nPos = 0 then
      AField.AsString := Trim(fParam(0))
    else
      AField.AsString := IntToStr(nPos);
  end

  { ------------------------- propriedades do DANFE ------------------------- }
  else if (AFuncao = 'DANFE') or (AFuncao = 'DANFETRIM') or
          (AFuncao = 'DANFEFONE') or (AFuncao = 'DANFEFONECITEL') then
  begin
    if not fDanfeProp(fParam(0), strAux) then
      raise Exception.CreateFmt('Propriedade do DANFE desconhecida: %s', [fParam(0)]);
    if AFuncao = 'DANFETRIM' then
      strAux := Trim(strAux)
    else if AFuncao = 'DANFEFONE' then
      strAux := FormatarFone(strAux)
    else if AFuncao = 'DANFEFONECITEL' then
      strAux := fFormataFone(strAux);
    AField.AsString := strAux;
  end

  { ---------------------- demais: dependem do objeto NF-e ------------------ }
  else if FNFe = nil then
    Result := False

  { Identificacao }
  else if AFuncao = 'IDNUM' then
    AField.AsString := OnlyNumber(FNFe.infNFe.Id)
  else if AFuncao = 'CHAVEFMT' then
    AField.AsString := FormatarChaveAcesso(FNFe.infNFe.Id)
  else if AFuncao = 'CHAVENFE' then
    AField.AsString := FNFe.infNFe.ID
  else if AFuncao = 'INDPAG' then
    AField.AsString := IndpagToStr(FNFe.Ide.IndPag)
  else if AFuncao = 'DEMI' then
  begin
    if (FNFe.Ide.Modelo = 65) then
      AField.AsString := FormatDateTimeBr(FNFe.Ide.DEmi)
    else
      AField.AsString := FormatDateBr(FNFe.Ide.DEmi);
  end
  else if AFuncao = 'HEMI' then
    AField.AsString := FormatDateTimeBr(FNFe.Ide.DEmi, 'hh:mm')
  else if AFuncao = 'DSAIENT' then
  begin
    if (FDanfe.ExibirDataHoraSaida = 'N') then
      AField.AsString := ''
    else
      AField.AsString := ifthen(FNFe.Ide.DSaiEnt <> 0, FormatDateBr(FNFe.Ide.DSaiEnt), IfThen(FDanfe.Dtsai <> 0, FormatDateBr(FDanfe.Dtsai)));
  end
  else if AFuncao = 'HORASAIDA' then
  begin
    if (FDanfe.ExibirDataHoraSaida = 'N') then
      AField.AsString := ''
    else if FNFe.infNFe.versao = 2.00 then
      AField.AsString := ifthen(FNFe.ide.hSaiEnt = 0, ifthen(FDanfe.Hrsai = 0, '', TimeToStr(FDanfe.Hrsai)), TimeToStr(FNFe.ide.hSaiEnt))
    else
      AField.AsString := ifthen(TimeOf(FNFe.ide.dSaiEnt)=0, ifthen(FDanfe.Hrsai = 0, '', TimeToStr(FDanfe.Hrsai)), TimeToStr(FNFe.ide.dSaiEnt));
  end
  else if AFuncao = 'MSGFISCAL' then
  begin
    if (FNFe.Ide.Modelo = 65) then
    begin
      if FNFe.Ide.TpAmb = taHomologacao then
        AField.AsString := ACBrStr('EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL')
      else if FNFe.Ide.tpEmis <> teNormal then
        AField.AsString := ACBrStr('EMITIDA EM CONTINGÊNCIA'+LineBreak+'Pendente de autorização')
      else
        AField.AsString := ACBrStr('ÁREA DE MENSAGEM FISCAL');
    end
    else
      AField.AsString := '';
  end
  else if AFuncao = 'URLNFCE' then
  begin
    if (FNFe.Ide.Modelo = 65) then
      AField.AsString := FNFe.infNFeSupl.urlChave
    else
      AField.AsString := '';
  end
  else if AFuncao = 'XMSG' then
    AField.AsString := FNFe.procNFe.xMsg
  // enumerados saem do objeto (valor invalido vira o padrao do ACBr)
  else if AFuncao = 'TPNF' then
    AField.AsString := tpNFToStr(FNFe.Ide.TpNF)
  else if AFuncao = 'TPIMP' then
    AField.AsString := TpImpToStr(FNFe.Ide.TpImp)
  else if AFuncao = 'TPEMIS' then
    AField.AsString := TpEmisToStr(FNFe.Ide.TpEmis)
  else if AFuncao = 'TPAMB' then
    AField.AsString := TpAmbToStr(FNFe.Ide.TpAmb)
  else if AFuncao = 'FINNFE' then
    AField.AsString := FinNFeToStr(FNFe.Ide.FinNFe)
  else if AFuncao = 'PROCEMI' then
    AField.AsString := procEmiToStr(FNFe.Ide.ProcEmi)
  else if AFuncao = 'CRT' then
    AField.AsString := CRTToStr(FNFe.Emit.CRT)

  { Emitente }
  else if AFuncao = 'NOMEIMPRESSO' then
    AField.AsString := FDanfe.ManterNomeImpresso(FNFe.Emit.XNome, FNFe.Emit.XFant)
  else if AFuncao = 'DESCRCST' then
  begin
    if Trim(fCampoRegistro(AField, 'CRT')) = '1' then
      AField.AsString := 'CSOSN'
    else
      AField.AsString := 'CST';
  end
  else if AFuncao = 'DADOSEND' then
  begin
    strAux := Trim(fCampoRegistro(AField, 'XLgr')) + ', ' + Trim(fCampoRegistro(AField, 'Nro'));
    if (trim(fCampoRegistro(AField, 'XCpl')) <> '') then
      strAux := strAux + ', ' + Trim(fCampoRegistro(AField, 'XCpl'));
    strAux := strAux + #13 +
              Trim(fCampoRegistro(AField, 'XBairro')) + #13 +
              Trim(fCampoRegistro(AField, 'XMun')) + ' - ' + Trim(fCampoRegistro(AField, 'UF')) + #13 +
              'CEP: ' + Trim(fCampoRegistro(AField, 'CEP')) + #13 +
              'Fone: ' + Trim(fCampoRegistro(AField, 'Fone')) +
              IfThen(Trim(FDanfe.Fone2) <> '', ' / ' + FormatarFone(FDanfe.Fone2), '');
    AField.AsString := strAux;
  end

  { Destinatario }
  else if AFuncao = 'DESTDOC' then
  begin
    if NaoEstaVazio(FNFe.Dest.idEstrangeiro) then
      AField.AsString := FNFe.Dest.idEstrangeiro
    else
      AField.AsString := FormatarCNPJouCPF(FNFe.Dest.CNPJCPF);
  end
  else if AFuncao = 'INDIEDEST' then
  begin
    case FNFe.Dest.indIEDest of
      inContribuinte: AField.AsString := '1-Contribuinte';
      inIsento: AField.AsString := '2-Isento';
      inNaoContribuinte: AField.AsString := '9-Não Contribuinte';
    else
      AField.Clear;
    end;
  end
  else if AFuncao = 'CONSUMIDOR' then
    // texto do consumidor e so da NFC-e (modelo 65); na NF-e o ACBr grava vazio
    AField.AsString := ''

  { Itens: como o ACBr, a partir dos campos ja gravados no registro (FLD_ORDEM) }
  else if AFuncao = 'DESCRPROD' then
    AField.AsString := dm.ManterDescricaoProduto( fCampoRegistro(AField, 'XProd') , fCampoRegistro(AField, 'infAdProd') )
  else if AFuncao = 'DESCRSEMQ' then
    AField.AsString := fCampoRegistro(AField, 'XProd') +' '+ fCampoRegistro(AField, 'infAdProdSemQuebra')

  { Itens (DadosProdutos): AIndice = posicao do det (1..n) }
  else if (AFuncao = 'CPROD') or (AFuncao = 'XPROD') or (AFuncao = 'VPRODITEM') or
          (AFuncao = 'VTOTTRIBITEM') or (AFuncao = 'INFADPROD') or (AFuncao = 'INFADSEMQ') or
          (AFuncao = 'VDESCITEM') or (AFuncao = 'ORIG') or (AFuncao = 'CSTCSOSN') or
          (AFuncao = 'VLRLIQITEM') or (AFuncao = 'VLRACRESC') or (AFuncao = 'VSTLIQ') or
          (AFuncao = 'UNIDADE') or (AFuncao = 'QUANTIDADE') or (AFuncao = 'VLRUNIT') or
          (AFuncao = 'QTDEMB') or (AFuncao = 'VLRCONTAB') or (AFuncao = 'DESCPORC') or
          (AFuncao = 'VLRPRODIMP') or (AFuncao = 'QTDETQ') then
  begin
    item := fItem(AIndice);
    if item = nil then
    begin
      // registro sem det (ex.: sintetico): o ACBr nao atribui
      AField.Clear;
      Exit;
    end;

    with item do
    begin
      if AFuncao = 'CPROD' then
        AField.AsString := FDanfe.ManterCodigo( Prod.cEAN,Prod.cProd)
      else if AFuncao = 'XPROD' then
        AField.AsString := StringReplace( Prod.xProd, ';', #13, [rfReplaceAll])
      else if AFuncao = 'VPRODITEM' then
        AField.AsString := dm.ManterVprod( Prod.VProd , Prod.vDesc )
      else if AFuncao = 'VTOTTRIBITEM' then
        AField.AsString := dm.ManterdvTotTrib( Imposto.vTotTrib )
      else if AFuncao = 'INFADPROD' then
        AField.AsString := dm.ManterInfAProd( AIndice - 1, infAdProd )
      else if AFuncao = 'INFADSEMQ' then
        AField.AsString := dm.ManterInfAProd( AIndice - 1, infAdProd, False )
      else if AFuncao = 'VDESCITEM' then
        AField.AsString := FormatFloatBr( dm.ManterVDesc( Prod.vDesc , Prod.VUnCom , Prod.QCom),'###,###,##0.00')
      else if AFuncao = 'ORIG' then
        AField.AsString := OrigToStr( Imposto.ICMS.orig)
      else if AFuncao = 'CSTCSOSN' then
        AField.AsString := dm.ManterCst( FNFe.Emit.CRT , Imposto.ICMS.CSOSN , Imposto.ICMS.CST )
      else if AFuncao = 'VLRLIQITEM' then
        AField.AsString := FormatFloatBr( Prod.vProd - Prod.vDesc ,'###,###,##0.00')
      else if AFuncao = 'VLRACRESC' then
        AField.AsString := FormatFloatBr( Prod.vProd + Prod.vOutro,'###,###,##0.00')
      else if AFuncao = 'VSTLIQ' then
        AField.AsString := FormatFloatBr( Imposto.ICMS.vICMSST + Imposto.ICMS.vFCPST ,'###,###,##0.00')
      else if (AFuncao = 'UNIDADE') or (AFuncao = 'QUANTIDADE') or (AFuncao = 'VLRUNIT') or
              (AFuncao = 'VLRCONTAB') then
      begin
        pUnidadeQtdVlr(item, strUnidade, strQuantidade, strValorUnit, dblQtdProduto, blnAtribuido);
        if AFuncao = 'VLRCONTAB' then
          AField.AsString := FormatFloatBr( (( Prod.VProd - Prod.vDesc ) + ( Imposto.ICMS.vICMSST + Imposto.ICMS.vFCPST + Imposto.IPI.VIPI + Prod.vFrete + Prod.vSeg + Prod.vOutro )) / iif(dblQtdProduto=0,1,dblQtdProduto) , '###,###,##0.00')
        else if not blnAtribuido then
          AField.Clear
        else if AFuncao = 'UNIDADE' then
          AField.AsString := strUnidade
        else if AFuncao = 'QUANTIDADE' then
          AField.AsString := strQuantidade
        else
          AField.AsString := strValorUnit;
      end
      else if AFuncao = 'QTDEMB' then
        AField.AsString := FormatFloatBr(Prod.nQuantidadeEmbalagem, '(#####)')
      else if AFuncao = 'DESCPORC' then
      begin
        if Prod.vProd > 0 then
          AField.AsString := FormatFloatBr( (1 - ((Prod.vProd - Prod.vDesc) / Prod.VProd)) * 100 ,'###,###,##0.00')
        else
          AField.Clear;
      end
      else if AFuncao = 'VLRPRODIMP' then
        AField.AsString := FormatFloatBr( Prod.VProd +
                                          Imposto.IPI.VIPI +
                                          Imposto.ICMS.vICMSST +
                                          Imposto.ICMS.vFCPST ,'###,###,##0.00' )
      else if AFuncao = 'QTDETQ' then
        AField.AsFloat := Prod.QtdEtq;
    end;
  end

  { Parametros }
  else if (AFuncao = 'RESUMOCANHOTO') or (AFuncao = 'MENSAGEM0') or (AFuncao = 'CHVACESSODESC') or
          (AFuncao = 'CONTID') or (AFuncao = 'CONTDESC') or (AFuncao = 'CONTVALOR') or
          (AFuncao = 'NPROT') or (AFuncao = 'DHRECBTO') or (AFuncao = 'CONSULTAAUT') then
  begin
    pCalculaParametros;
    if AFuncao = 'RESUMOCANHOTO' then
      AField.AsString := FstrResumo
    else if AFuncao = 'MENSAGEM0' then
    begin
      // mesma sequencia do ACBr, no proprio campo (inclusive o corte pelo tamanho)
      AField.AsString := FstrMensagem0;
      if NaoEstaVazio(AField.AsString) then
        AField.AsString := AField.AsString + #10#13;
      AField.AsString := AField.AsString + dm.MarcaDaguaMSG;
    end
    else if AFuncao = 'CHVACESSODESC' then
    begin
      if FblnChaveDesc then AField.AsString := FstrChaveDesc else AField.Clear;
    end
    else if AFuncao = 'CONTID' then
      AField.AsString := FstrContID
    else if AFuncao = 'CONTDESC' then
    begin
      if FblnContDesc then AField.AsString := FstrContDesc else AField.Clear;
    end
    else if AFuncao = 'CONTVALOR' then
    begin
      if FblnContValor then AField.AsString := FstrContValor else AField.Clear;
    end
    else if AFuncao = 'NPROT' then
    begin
      if FblnNProt then AField.AsString := FstrNProt else AField.Clear;
    end
    else if AFuncao = 'DHRECBTO' then
    begin
      if FblnDhRecbto then AField.AsDateTime := FdtaDhRecbto else AField.Clear;
    end
    else
      AField.AsString := FstrConsulta;
  end
  else if AFuncao = 'POSCANHOTO' then
    AField.AsString := IntToStr( Ord(FDanfe.PosCanhoto))
  else if AFuncao = 'QTDITENS' then
    AField.AsInteger := FNFe.Det.Count
  else if AFuncao = 'LOGOEXP' then
    AField.AsString := IfThen( FDanfe.ExpandirLogoMarca, '1' , '0' )
  else if AFuncao = 'SISTEMA' then
    AField.AsString := IfThen( FDanfe.Sistema <> '' , FDanfe.Sistema, 'Projeto ACBr - http://acbr.sf.net')
  else if AFuncao = 'USUARIO' then
    AField.AsString := IfThen( FDanfe.Usuario <> '' , ' - ' + FDanfe.Usuario , '' )
  else if AFuncao = 'FAX' then
    AField.AsString := IfThen( FDanfe.Fax     <> '' , ' - FAX ' + FDanfe.Fax , '')
  else if AFuncao = 'DESCONTO' then
    AField.AsString := IfThen( FDanfe.ImprimirDescPorc , '%' , 'VALOR')
  else if AFuncao = 'TOTALLIQ' then
    AField.AsString := IfThen( FDanfe.ImprimirTotalLiquido ,ACBrStr('LÍQUIDO') ,'TOTAL')
  else if AFuncao = 'LINHASPAG' then
    AField.AsInteger := FDanfe.ProdutosPorPagina
  else if AFuncao = 'EXPANDIRAUTO' then
    AField.AsString := IfThen( dm.ExpandirDadosAdicionaisAuto , 'S' , 'N')
  else if AFuncao = 'IFORMATO' then
    AField.AsInteger := integer( FDanfe.CasasDecimais.Formato )
  else if AFuncao = 'MASKQCOM' then
    AField.AsString := FDanfe.CasasDecimais._Mask_qCom
  else if AFuncao = 'MASKVUNCOM' then
    AField.AsString := FDanfe.CasasDecimais._Mask_vUnCom
  else if AFuncao = 'CASASQCOM' then
    AField.AsInteger := FDanfe.CasasDecimais._qCom
  else if AFuncao = 'CASASVUNCOM' then
    AField.AsInteger := FDanfe.CasasDecimais._vUnCom
  else if AFuncao = 'VIAESTAB' then
    AField.AsString := dm.DescricaoViaEstabelec
  else if AFuncao = 'DESCACRESC' then
    AField.AsInteger := IfThen( FDanfe.ImprimeDescAcrescItem, 1 , 0 )
  else if (AFuncao = 'IMAGEM') or (AFuncao = 'LOGOBLOB') or (AFuncao = 'MDAGUA') or (AFuncao = 'MDAGUABLOB') then
  begin
    // mesmo logo e mesma conversao do ACBr
    pCalculaImagens;
    if AFuncao = 'IMAGEM' then
    begin
      if FblnLogoOk then AField.AsString := FDanfe.Logo else AField.Clear;
    end
    else if AFuncao = 'LOGOBLOB' then
    begin
      if FblnLogoOk and (FstmLogo <> nil) then
      begin
        FstmLogo.Position := 0;
        TBlobField(AField).LoadFromStream(FstmLogo);
      end
      else
        AField.Clear;
    end
    else if AFuncao = 'MDAGUA' then
    begin
      if FblnMDaguaOk then AField.AsString := FDanfe.MarcaDagua else AField.Clear;
    end
    else
    begin
      if FblnMDaguaOk and (FstmMDagua <> nil) then
      begin
        FstmMDagua.Position := 0;
        TBlobField(AField).LoadFromStream(FstmMDagua);
      end
      else
        AField.Clear;
    end;
  end
  else if AFuncao = 'MSGREIMP' then
    AField.AsString := IfThen( FDanfe.Reimpressao , '*** SEGUNDA VIA ***', '')
  else if AFuncao = 'CLASSIFIVENDA' then
    AField.AsBoolean := (FDanfe.ClassifiVenda)
  else if AFuncao = 'NFECANCELADA' then
    AField.AsBoolean := (FDanfe.NfeCancelada)
  else if AFuncao = 'NUMDAVIA' then
    AField.AsInteger := (FDanfe.NumDaVia)
  else if AFuncao = 'QTDVOLUME' then
    AField.AsInteger := (FDanfe.QtdVolume)

  { CalculoImposto }
  else if AFuncao = 'VTOTTRIB' then
    AField.AsFloat := dm.ManterVTrib( FNFe.Total.ICMSTot.VTotTrib )
  else if AFuncao = 'VALORAPAGAR' then
    AField.AsFloat := FNFe.Total.ICMSTot.VProd - FNFe.Total.ICMSTot.VDesc + FNFe.Total.ICMSTot.VOutro
  else if AFuncao = 'VTRIBPERC' then
    AField.AsFloat := dm.ManterVTribPerc(dm.ManterVTrib( FNFe.Total.ICMSTot.VTotTrib ), FNFe.Total.ICMSTot.VProd , FNFe.Total.ICMSTot.VNF)
  else if AFuncao = 'VTRIBFONTE' then
  begin
    if NaoEstaVazio(dm.TributosFonte) then
      AField.AsString := '(Fonte: '+dm.TributosFonte+')'
    else
      AField.Clear;
  end
  else if AFuncao = 'VTROCO' then
  begin
    if FNFe.pag.vTroco > 0 then
      AField.AsCurrency := FNFe.pag.vTroco
    else
      AField.AsCurrency := dm.vTroco;
  end
  else if AFuncao = 'VTOTPAGO' then
  begin
    if FNFe.pag.vTroco > 0 then
      AField.AsCurrency := FNFe.pag.vTroco + FNFe.Total.ICMSTot.VProd
    else
      AField.AsCurrency := dm.vTroco + FNFe.Total.ICMSTot.VProd;
  end

  { Transportador }
  else if AFuncao = 'MODFRETE' then
    AField.AsString := modFreteToDesStr( FNFe.Transp.ModFrete )

  { Fatura }
  else if AFuncao = 'IFORMA' then
    AField.AsInteger := Integer( FNFe.Ide.indPag)
  else if AFuncao = 'PAGTOFAT' then
  begin
    if FNFe.infNFe.Versao >= 4 then
      AField.AsString := ACBrStr('DADOS DA FATURA')
    else
    begin
      case FNFe.Ide.indPag of
        ipVista : AField.AsString := ACBrStr('PAGAMENTO À VISTA');
        ipPrazo : AField.AsString := ACBrStr('PAGAMENTO A PRAZO');
        ipOutras: AField.AsString := ACBrStr('OUTROS');
      else
        AField.Clear;
      end;
    end;
  end
  else if (AFuncao = 'FATNFAT') or (AFuncao = 'FATVORIG') or (AFuncao = 'FATVDESC') or (AFuncao = 'FATVLIQ') then
  begin
    if NaoEstaVazio(FNFe.Cobr.Fat.nFat) then
    begin
      if AFuncao = 'FATNFAT' then AField.AsString := FNFe.Cobr.Fat.nFat
      else if AFuncao = 'FATVORIG' then AField.AsFloat := FNFe.Cobr.Fat.vOrig
      else if AFuncao = 'FATVDESC' then AField.AsFloat := FNFe.Cobr.Fat.vDesc
      else AField.AsFloat := FNFe.Cobr.Fat.vLiq;
    end
    else
      AField.Clear;
  end

  { LocalEntrega }
  else if AFuncao = 'EXIBIRLOCALENTREGA' then
  begin
    // fLocalFaturaIgualLocalEntrega com o registro em edicao (ja com XLgr/Nro/XBairro/XMun/UF)
    cdsDest := fDataSetPorNome('Destinatario');
    if (cdsDest <> nil) and cdsDest.Active and (not cdsDest.IsEmpty) and
       (fCampoRegistro(AField, 'XLgr')    = cdsDest.FieldByName('XLgr').asString) and
       (fCampoRegistro(AField, 'Nro')     = cdsDest.FieldByName('Nro').asString) and
       (fCampoRegistro(AField, 'XBairro') = cdsDest.FieldByName('XBairro').asString) and
       (fCampoRegistro(AField, 'XMun')    = cdsDest.FieldByName('XMun').asString) and
       (fCampoRegistro(AField, 'UF')      = cdsDest.FieldByName('UF').asString) then
      AField.AsBoolean := False
    else
      AField.AsBoolean := True;
  end

  { InformacoesAdicionais }
  else if (AFuncao = 'OBS') or (AFuncao = 'OBSSEMQUEBRA') or (AFuncao = 'LINHASOBS') or
          (AFuncao = 'OBSDANFESIMP') then
  begin
    pCalculaInfAdic;
    if AFuncao = 'OBSSEMQUEBRA' then
      AField.AsString := StringReplace( FstrBufferInfCpl, #$D#$A, ' / ', [rfReplaceAll])
    else if AFuncao = 'OBS' then
      AField.AsString := StringReplace(FstrBufferInfCpl, '\n', sLineBreak, [rfReplaceAll])
    else if AFuncao = 'LINHASOBS' then
      AField.AsInteger := FintLinhasObs
    else
    begin
      nPos := Pos('Digitador:', StringReplace(FstrBufferInfCpl, '\n', sLineBreak, [rfReplaceAll]));
      if nPos > 0 then
        AField.AsString := Copy( StringReplace(FstrBufferInfCpl, '\n', sLineBreak, [rfReplaceAll]), 1, nPos-1)
      else
        AField.AsString := '';
    end;
  end
  else if AFuncao = 'NFREF' then
  begin
    strNfRef := '';
    for i := 0 to Pred(FNFe.Ide.NFref.Count) do
      strNfRef:= strNfRef +'- NF-e referenciada:'+ FNFe.Ide.NFref.Items[i].refNFe + ' ';
    AField.AsString := strNfRef;
  end
  else if AFuncao = 'QRDADOSADIC' then
  begin
    AField.Clear;
{$IF not Defined(LINUX)}
    // mesmo tratamento de CarregaInformacoesAdicionais (imagem + objetos do fr3)
    if NaoEstaVazio(FDanfe.QrCodeDadosAdicionais) and
      (FDanfe.ImprimirQrCodeDadosAdicionais) then
    begin
      img := TPicture.Create;
      try
        vStream := TMemoryStream.Create;
        try
          img.Bitmap := fGerarQRCode(FDanfe.QrCodeDadosAdicionais);
          try
            img.Bitmap.SaveToStream(vStream);
            vStream.Position := 0;
            TBlobField(AField).LoadFromStream(vStream);

            If Assigned(TfrxPictureView(dm.frxReport.FindObject('imgQrCodeDadosAdicionais'))) then
            begin
              TfrxPictureView(dm.frxReport.FindObject('imgQrCodeDadosAdicionais')).Visible := True;
              TfrxPictureView(dm.frxReport.FindObject('imgQrCodeDadosAdicionais')).Picture.Bitmap := img.Bitmap;
              TFrxMemoView(dm.frxReport.FindObject('memObs')).Width := 380;
            end;
          Except
           On E: Exception do
            ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
          end;
        finally
          FreeAndNil(vStream);
        end;
      finally
        FreeAndNil(img);
      end;
    end;
{$IFEND}
  end

  { Pagamento: AIndice = posicao do detPag (1..n) }
  else if (AFuncao = 'TPAG') or (AFuncao = 'VPAG') or (AFuncao = 'CNPJPAG') or
          (AFuncao = 'TBAND') or (AFuncao = 'CAUT') then
  begin
    if (AIndice < 1) or (AIndice > FNFe.Pag.Count) then
    begin
      AField.Clear;
      Exit;
    end;
    with FNFe.Pag[AIndice - 1] do
    begin
      if AFuncao = 'TPAG' then AField.AsString := FormaPagamentoToDescricao( tPag )
      else if AFuncao = 'VPAG' then AField.AsFloat := vPag
      else if AFuncao = 'CNPJPAG' then AField.AsString := FormatarCNPJ(CNPJ)
      else if AFuncao = 'TBAND' then AField.AsString := BandeiraCartaoToDescStr( tBand )
      else AField.AsString := cAut;
    end;
  end
  else
    Result := False;
end;

procedure TNfeDinContexto.pAgrupaNcm(ACds: TUniClientDataSet);
var
  strNCM: string;
  VProd,
  VBC,
  VICMS,
  VIPI : real;
  cdsNCMDadosProdutos : TUniClientDataSet;
  cdsDest: TUniClientDataSet;
  strUF: String;
begin
  // so quando a UF do destinatario esta em CFG_UFANCM
  strUF := '';
  cdsDest := fDataSetPorNome('Destinatario');
  if (cdsDest <> nil) and cdsDest.Active and (cdsDest.FindField('UF') <> nil) then
    strUF := cdsDest.FieldByName('UF').AsString;

  if not (Pos(FDanfe.UFAgrupaNCM, strUF) > 0) then
    Exit;

  ACds.IndexFieldNames := 'NCM';

  cdsNCMDadosProdutos := TUniClientDataSet.Create(nil);
  try
    cdsNCMDadosProdutos.FieldDefs.Add('ChaveNFe', ftString, 50);
    cdsNCMDadosProdutos.FieldDefs.Add('NCM'     , ftString, 9);
    cdsNCMDadosProdutos.FieldDefs.Add('VProd'   , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vBC'     , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vICMS'   , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vIPI'    , ftString, 18);

    cdsNCMDadosProdutos.CreateDataSet;
    cdsNCMDadosProdutos.LogChanges := False;

    cdsNCMDadosProdutos.IndexFieldNames := 'NCM';

    ACds.First;

    while not ACds.Eof do
    begin
      cdsNCMDadosProdutos.Append;
      cdsNCMDadosProdutos.FieldByName('ChaveNFe').asString := ACds.FieldByName('ChaveNFe').asString;
      cdsNCMDadosProdutos.FieldByName('NCM').asString      := ACds.FieldByName('NCM').asString;
      cdsNCMDadosProdutos.FieldByName('VProd').asString    := ACds.FieldByName('VProd').asString;
      cdsNCMDadosProdutos.FieldByName('vBC').asString      := ACds.FieldByName('vBC').asString;
      cdsNCMDadosProdutos.FieldByName('vICMS').asString    := ACds.FieldByName('vICMS').asString;
      cdsNCMDadosProdutos.FieldByName('vIPI').asString     := ACds.FieldByName('vIPI').asString;
      cdsNCMDadosProdutos.Post;

      ACds.Next;
    end;

    VProd := 0;
    VBC   := 0;
    VICMS := 0;
    VIPI  := 0;

    cdsNCMDadosProdutos.First;

    strNCM := cdsNCMDadosProdutos.FieldByName('NCM').asString;

    while not cdsNCMDadosProdutos.Eof do
    begin
      if cdsNCMDadosProdutos.FieldByName('NCM').asString = strNCM then
      begin
        VProd  := VProd + fStrToFloat(cdsNCMDadosProdutos.FieldByName('VProd').AsString);
        VBC    := VBC   + fStrToFloat(cdsNCMDadosProdutos.FieldByName('VBC').AsString);
        VICMS  := VICMS + fStrToFloat(cdsNCMDadosProdutos.FieldByName('VICMS').AsString);
        VIPI   := VIPI  + fStrToFloat(cdsNCMDadosProdutos.FieldByName('VIPI').AsString);
      end
      else
      begin
        ACds.Append;
        ACds.FieldByName('ChaveNFe').AsString         := FNFe.infNFe.ID;
        ACds.FieldByName('NCM').asString              := strNCM;
        ACds.FieldByName('DescricaoProduto').AsString := 'GRUPO DO NCM: ' + strNCM + #13 +
                                                         'SUBTOTAL DOS PRODUTOS: ' + FormatFloatBr( VProd, '###,###,##0.00' ) + #13 +
                                                         'SUBTOTAL DA BASE DE CALCULO ICMS: ' + FormatFloatBr( VBC, '###,###,##0.00' ) + #13 +
                                                         'SUBTOTAL DO ICMS: '  + FormatFloatBr( VICMS, '###,###,##0.00' ) + #13 +
                                                         'SUBTOTAL DO IPI: ' + FormatFloatBr( VIPI, '###,###,##0.00' ) ;
        ACds.Post;

        VProd  := fStrToFloat(cdsNCMDadosProdutos.FieldByName('VProd').AsString);
        VBC    := fStrToFloat(cdsNCMDadosProdutos.FieldByName('VBC').AsString);
        VICMS  := fStrToFloat(cdsNCMDadosProdutos.FieldByName('VICMS').AsString);
        VIPI   := fStrToFloat(cdsNCMDadosProdutos.FieldByName('VIPI').AsString);
        strNCM := cdsNCMDadosProdutos.FieldByName('NCM').asString;
      end;

      cdsNCMDadosProdutos.Next;
    end;

    ACds.Insert;
    ACds.FieldByName('ChaveNFe').AsString         := FNFe.infNFe.ID;
    ACds.FieldByName('NCM').asString              := strNCM;
    ACds.FieldByName('DescricaoProduto').AsString := 'GRUPO DO NCM: ' + strNCM + #13 +
                                                     'SUBTOTAL DOS PRODUTOS: ' + FormatFloatBr( VProd, '###,###,##0.00' ) + #13 +
                                                     'SUBTOTAL DA BASE DE CALCULO ICMS: ' + FormatFloatBr( VBC, '###,###,##0.00' ) + #13 +
                                                     'SUBTOTAL DO ICMS: '  + FormatFloatBr( VICMS, '###,###,##0.00' ) + #13 +
                                                     'SUBTOTAL DO IPI: ' + FormatFloatBr( VIPI, '###,###,##0.00' ) ;
    ACds.Post;

    ACds.First;
  finally
    FreeAndNil(cdsNCMDadosProdutos);
  end;
end;

procedure TNfeDinContexto.pPosProcessa(const APosPrc: String; ACds: TUniClientDataSet);
begin
  if APosPrc = 'AGRUPA_NCM' then
    pAgrupaNcm(ACds)
  else
    pGravaErro('Pos-processamento dinamico', 'Pos-processamento desconhecido: ' + APosPrc);
end;

function TNfeDinContexto.fChaveAcesso: String;
begin
  Result := '';
  if FEntrada <> nil then
    Result := FEntrada.strAcesso;
end;

{ TNfeDinamico }

constructor TNfeDinamico.Create(AEntrada: TNfeDinEntrada; ADM: TObject; ADanfe: TACBrNFeDANFEClass);
begin
  inherited Create;
  FEntrada := AEntrada;
  FDM := ADM;
  FDanfe := ADanfe;
  FContexto := nil;
  FReport := nil;
  FlstNomes := TStringList.Create;
  FlstCampos := TObjectList.Create(True);
  FlstFrx := TObjectList.Create(True);
  FlstCds := TObjectList.Create(True);
end;

destructor TNfeDinamico.Destroy;
begin
  pLiberaDataSets;
  FreeAndNil(FlstCds);
  FreeAndNil(FlstFrx);
  FreeAndNil(FlstCampos);
  FreeAndNil(FlstNomes);
  FXmlDoc := nil;
  inherited;
end;

procedure TNfeDinamico.pLiberaDataSets;
begin
  // frxDBDataset antes dos datasets; o contexto so tem referencias
  FlstFrx.Clear;
  FlstCds.Clear;
  FlstCampos.Clear;
  FlstNomes.Clear;
  SetLength(FarrDefs, 0);
  FreeAndNil(FContexto);
end;

class function TNfeDinamico.fDisponivel(const AProvedor: String): Boolean;
begin
  // qualquer falha = False
  try
    Result := TNfsDinamico.fModeloNovoDisponivel and TNfsDinamico.fExisteProvedor(AProvedor);
  except
    Result := False;
  end;
end;

procedure TNfeDinamico.pCriarEstrutura(AReport: TfrxReport);
var
  qry: TQueryNfeDin;
  lstCampos: TObjectList;
  cds: TUniClientDataSet;
  frxDb: TfrxDBDataset;
  i: Integer;
begin
  FReport := AReport;

  // estrutura antes da carga do fr3 (as bandas ligam pelo nome)
  AReport.DataSets.Clear;
  AReport.EnabledDataSets.Clear;

  // ja montada: so registra de novo (o fr3 carregado ainda referencia os datasets)
  if FlstCds.Count > 0 then
  begin
    for i := 0 to FlstFrx.Count - 1 do
    begin
      AReport.DataSets.Add(TfrxDBDataset(FlstFrx[i]));
      AReport.EnabledDataSets.Add(TfrxDBDataset(FlstFrx[i]));
    end;
    Exit;
  end;

  pLiberaDataSets;

  FContexto := TNfeDinContexto.Create(FEntrada, FDM, FDanfe);

  qry := fCriaQuery(nil);
  try
    qry.SQL.Text :=
      'SELECT CDS_NOMCDS FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV ' +
      'ORDER BY CDS_ORDEM, CDS_NOMCDS';
    qry.ParamByName('PRV').AsString := FEntrada.strProvedor;
    qry.Open;
    while not qry.Eof do
    begin
      FlstNomes.Add(qry.FieldByName('CDS_NOMCDS').AsString);
      qry.Next;
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;

  if FlstNomes.Count = 0 then
    raise Exception.CreateFmt('Provedor dinamico %s sem datasets (IMPNFE_CDS).', [FEntrada.strProvedor]);

  SetLength(FarrDefs, FlstNomes.Count);
  for i := 0 to FlstNomes.Count - 1 do
  begin
    TNfsDinamico.pCarregaDefCds(FEntrada.strProvedor, FlstNomes[i], FarrDefs[i]);

    lstCampos := TObjectList.Create(True);
    FlstCampos.Add(lstCampos);
    TNfsDinamico.pCarregaCampos(FEntrada.strProvedor, FlstNomes[i], lstCampos);

    cds := TUniClientDataSet.Create(nil);
    FlstCds.Add(cds);
    if FarrDefs[i].strOrigem = 'B' then
      TNfsDinamico.pMontarPorBancoDin(cds, FarrDefs[i], FContexto)
    else
      TNfsDinamico.pCriarEstruturaDin(cds, FarrDefs[i], lstCampos, FContexto);

    frxDb := TfrxDBDataset.Create(nil);
    FlstFrx.Add(frxDb);
    frxDb.Name := 'frxDsNfeDin' + IntToStr(i + 1);
    frxDb.UserName := FarrDefs[i].strNomFrx;
    frxDb.DataSet := cds;
    frxDb.OpenDataSource := False;
    frxDb.CloseDataSource := False;
    frxDb.Enabled := False;
    AReport.DataSets.Add(frxDb);
    AReport.EnabledDataSets.Add(frxDb);

    FContexto.pRegistraDataSet(FarrDefs[i].strNomCds, FarrDefs[i].strNomFrx, cds);
  end;
end;

function fXmlDaNotaDin(const AXml: String): String;
const
  cstFechamentos: array[0..2] of String = ('</nfeProc>', '</procNFe>', '</NFe>');
var
  i, intPos: Integer;
begin
  // como o LoadFromString do ACBr: ignora o que vier depois do fechamento da nota
  Result := AXml;
  for i := Low(cstFechamentos) to High(cstFechamentos) do
  begin
    intPos := Pos(cstFechamentos[i], AXml);
    if intPos > 0 then
    begin
      Result := Copy(AXml, 1, intPos + Length(cstFechamentos[i]) - 1);
      Exit;
    end;
  end;
end;

procedure TNfeDinamico.pPreencher(ANFe: TNFe);
var
  i: Integer;
  noRaiz: IXMLNode;
  cds: TUniClientDataSet;
begin
  if FContexto = nil then
    raise Exception.Create('Datasets dinamicos da NF-e sem estrutura (pCriarEstrutura).');

  FContexto.pDefineNFe(ANFe);

  // recarrega quando a nota muda; mesma conversao de texto do ACBr (acentos)
  if (FXmlDoc = nil) or (FstrXmlCarregado <> FEntrada.strXml) then
  begin
    FXmlDoc := nil;
    FXmlDoc := TXMLDocument.Create(nil);
    FXmlDoc.LoadFromXML(fXmlDaNotaDin(String(AnsiString(ConverteXMLtoNativeString(FEntrada.strXml)))));
    FXmlDoc.Active := True;
    FstrXmlCarregado := FEntrada.strXml;
  end;
  noRaiz := FXmlDoc.DocumentElement;

  for i := 0 to FlstNomes.Count - 1 do
    if FarrDefs[i].strOrigem <> 'B' then
    begin
      cds := TUniClientDataSet(FlstCds[i]);
      // nova preparacao (via): recomeca do zero, como o Close/CreateDataSet do ACBr
      if cds.Active then
      begin
        cds.IndexFieldNames := '';
        cds.EmptyDataSet;
      end;
      TNfsDinamico.pPreencherDin(cds, FarrDefs[i], TObjectList(FlstCampos[i]), noRaiz, FContexto);
    end;

  // variaveis do fr3 a cada preparacao; erro registra e segue
  if (FReport <> nil) and (FlstCds.Count > 0) then
  begin
    try
      TNfsDinamico.pCarregaVariaveis(FReport, FEntrada.strProvedor, TUniClientDataSet(FlstCds[0]),
        FEntrada.strAcesso, FEntrada.strCodEmp, FEntrada.strNumDoc, FEntrada.strEspDoc, FContexto);
    except
      on E: Exception do
        FContexto.pGravaErro('Variaveis do provedor ' + FEntrada.strProvedor, E.Message);
    end;
  end;
end;

function TNfeDinamico.fDataSet(const ANome: String): TUniClientDataSet;
begin
  Result := nil;
  if FContexto <> nil then
    Result := FContexto.fDataSetPorNome(ANome);
end;

class procedure TNfeDinamico.pComparar(ADM: TObject; AResultado: TStrings);
const
  cstNomes: array[0..17] of String = ('Parametros', 'Identificacao', 'Emitente',
    'Destinatario', 'DadosProdutos', 'CalculoImposto', 'Transportador', 'Veiculo',
    'Volumes', 'Duplicatas', 'ISSQN', 'LocalRetirada', 'LocalEntrega', 'Fatura',
    'Pagamento', 'InformacoesAdicionais', 'Eventos', 'Inutilizacao');
  cstMaxLinhas = 300;
  cstMaxTexto  = 120;
var
  dm: TACBrNFeFRClass;
  dsNat, dsDin: TDataSet;
  fldNat, fldDin: TField;
  i, j, intReg, intDif, intTotDif, intNovos: Integer;
  blnIgual: Boolean;
  strNome: String;

  function fTipo(AField: TField): String;
  begin
    Result := GetEnumName(TypeInfo(TFieldType), Ord(AField.DataType));
    if AField.Size > 0 then
      Result := Result + '(' + IntToStr(AField.Size) + ')';
  end;

  function fTexto(AField: TField): String;
  begin
    if AField.IsNull then
      Result := '<nulo>'
    else
      Result := '"' + Copy(StringReplace(StringReplace(AField.AsString, #13, '\r', [rfReplaceAll]),
        #10, '\n', [rfReplaceAll]), 1, cstMaxTexto) + '"';
  end;

  procedure pDif(const ATexto: String);
  begin
    Inc(intDif);
    Inc(intTotDif);
    if AResultado.Count < cstMaxLinhas then
      AResultado.Add('  ' + ATexto)
    else if AResultado.Count = cstMaxLinhas then
      AResultado.Add('  ... (demais divergencias omitidas)');
  end;

begin
  dm := TACBrNFeFRClass(ADM);
  intTotDif := 0;
  AResultado.Add('Datasets: rotina antiga (ACBr) x rotina nova (provedor ' + cstProvedorNotaFiscal + ')');
  AResultado.Add(StringOfChar('-', 78));

  for i := Low(cstNomes) to High(cstNomes) do
  begin
    strNome := cstNomes[i];
    intDif := 0;
    intNovos := 0;
    dsNat := dm.fDataSetNativo(strNome);
    dsDin := dm.fDataSetDinamico(strNome);

    AResultado.Add('[' + strNome + ']');
    if dsNat = nil then
    begin
      AResultado.Add('  (dataset nao existe na rotina antiga)');
      Continue;
    end;
    if dsDin = nil then
    begin
      pDif('FALTA o dataset na rotina nova');
      Continue;
    end;
    if dsNat.Active <> dsDin.Active then
    begin
      pDif('Situacao diferente: antiga ' + IfThen(dsNat.Active, 'aberto', 'fechado') +
        ', nova ' + IfThen(dsDin.Active, 'aberto', 'fechado'));
      Continue;
    end;
    if not dsNat.Active then
    begin
      AResultado.Add('  OK (fechado nas duas rotinas)');
      Continue;
    end;

    // estrutura
    for j := 0 to dsNat.FieldCount - 1 do
    begin
      fldNat := dsNat.Fields[j];
      fldDin := dsDin.FindField(fldNat.FieldName);
      if fldDin = nil then
        pDif('Campo ' + fldNat.FieldName + ' FALTA na rotina nova')
      else if (fldDin.DataType <> fldNat.DataType) or (fldDin.Size <> fldNat.Size) then
        pDif('Campo ' + fldNat.FieldName + ': tipo antiga ' + fTipo(fldNat) + ', nova ' + fTipo(fldDin));
    end;
    for j := 0 to dsDin.FieldCount - 1 do
      if dsNat.FindField(dsDin.Fields[j].FieldName) = nil then
        Inc(intNovos);

    // registros e valores (na ordem de cada dataset)
    if dsNat.RecordCount <> dsDin.RecordCount then
      pDif('Registros: antiga ' + IntToStr(dsNat.RecordCount) + ', nova ' + IntToStr(dsDin.RecordCount));

    dsNat.First;
    dsDin.First;
    intReg := 0;
    while (not dsNat.Eof) and (not dsDin.Eof) do
    begin
      Inc(intReg);
      for j := 0 to dsNat.FieldCount - 1 do
      begin
        fldNat := dsNat.Fields[j];
        fldDin := dsDin.FindField(fldNat.FieldName);
        if fldDin = nil then
          Continue;

        if fldNat.IsNull or fldDin.IsNull then
          blnIgual := fldNat.IsNull and fldDin.IsNull
        else if fldNat.DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd] then
          blnIgual := (fldNat.AsFloat = fldDin.AsFloat)
        else
          blnIgual := (fldNat.AsString = fldDin.AsString);

        if not blnIgual then
          pDif('Registro ' + IntToStr(intReg) + ', campo ' + fldNat.FieldName + ': antiga ' +
            fTexto(fldNat) + ', nova ' + fTexto(fldDin));
      end;
      dsNat.Next;
      dsDin.Next;
    end;

    if intDif = 0 then
      AResultado.Add('  OK (' + IntToStr(dsNat.RecordCount) + ' registro(s))');
    if intNovos > 0 then
      AResultado.Add('  ' + IntToStr(intNovos) + ' campo(s) novo(s), somente na rotina nova');
  end;

  AResultado.Add(StringOfChar('-', 78));
  if intTotDif = 0 then
    AResultado.Add('Nenhuma divergencia: a rotina nova gera os mesmos datasets da rotina antiga.')
  else
    AResultado.Add(IntToStr(intTotDif) + ' divergencia(s) encontrada(s).');
end;

end.
