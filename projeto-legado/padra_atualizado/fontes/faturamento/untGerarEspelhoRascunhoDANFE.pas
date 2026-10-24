unit untGerarEspelhoRascunhoDANFE;

interface

uses
  untFuncFat, UniClientDataSet, SysUtils, DB, StrUtils, untFuncFatTypes;

type
  TGerarEspelhoRascunhoDANFE = class
  private
    FCodEmp   : String;
    FfatVenda : TFatVenda;
    FcdsEspGer: TUniClientDataSet;
    FcdsEspDet: TUniClientDataSet;
    FcdsDuplic: TUniClientDataSet;
    FcdsEndEnt: TUniClientDataSet;

    fltTotIpiDev: Double;

    procedure pCriarClientEspGer;
    procedure pCriarClientEspDet;
    procedure pCriarClientDuplicatas;
    procedure pCriarClientEnderecoEntrega;

    procedure pCarregaEspGer;
    procedure pCarregaEspDet;
    procedure pCarregaDuplicatas;
    procedure pCarregaEnderecoEntrega;

    function fGetTipoFrete: String;
    function fUtilizarUnidadeTributavel(const strClaFis: String): Boolean;
    function fGetDescIte(const intCont: Integer): String;
    function fDescontaICMSDesonerado(const item: TDadosFechamento): Double;
  public
    constructor Create(aCodEmp: String; aFatVenda: TFatVenda);
    destructor Destroy; override;
    function fGerarEspelho(const strOpcDoc : String): Boolean;
  end;

implementation

uses
  untFuncoesSimples, untConstantes, untConstantesNFE, untEspelhoImpressao, untDuplicatas,
  untTypesSistema, Shared.Functions.Types;

{ TGerarEspelhoRascunhoDANFE }

constructor TGerarEspelhoRascunhoDANFE.Create(aCodEmp: String; aFatVenda: TFatVenda);
begin
  FCodEmp   := aCodEmp;
  FfatVenda := aFatVenda;
  fltTotIpiDev := 0;

  pCriarClientEspGer;
  pCriarClientEspDet;
  pCriarClientDuplicatas;
  pCriarClientEnderecoEntrega;
end;

destructor TGerarEspelhoRascunhoDANFE.Destroy;
begin
  FreeAndNil(FcdsEspDet);
  FreeAndNil(FcdsEspGer);
  FreeAndNil(FcdsDuplic);
  FreeAndNil(FcdsEndEnt);
  inherited;
end;

function TGerarEspelhoRascunhoDANFE.fDescontaICMSDesonerado(
  const item: TDadosFechamento): Double;
begin
  Result := item.fltDesEsp;

  If (FfatVenda.strZonFra = 'S') and (item.fltIcmOrg > 0) Then
  Begin
    If (item.fltDesEsp - item.fltIcmOrg) > 0 Then
      Result := item.fltDesEsp - item.fltIcmOrg
    Else
      Result := 0;
  End
  Else If (item.fltVrdIcm > 0) and (RightStr(item.strCodFis, 2) = '40') Then
  Begin
    If (item.fltDesEsp - item.fltVrdIcm) > 0 Then
      Result := item.fltDesEsp - item.fltVrdIcm
    Else
      Result := 0;
  End;
end;

function TGerarEspelhoRascunhoDANFE.fGerarEspelho(const strOpcDoc : String): Boolean;
var
  blnDocFor: Boolean;
  blnEspelhoDevolucaoCliente: Boolean;
begin
  Result := True;

  pCarregaEspGer;
  pCarregaEspDet;
  pCarregaDuplicatas;
  pCarregaEnderecoEntrega;

  blnDocFor := FfatVenda.fDocumentoParaFornecedor;
  blnEspelhoDevolucaoCliente := FfatVenda.blnEspelhoDevolucaoCliente;
  TfrmEspelhoImpressao.pImprimeEspelhoDANFE(strOpcDoc, VS_strCodEmp, blnDocFor, FcdsEspGer, FcdsEspDet, '', FcdsDuplic, FcdsEndEnt, blnEspelhoDevolucaoCliente);
end;

function TGerarEspelhoRascunhoDANFE.fGetTipoFrete: String;
var
  intCont: Integer;
begin
  Result := '';

  if fEmptyStr(FFatVenda.strTipFre) then
    Exit;

  for intCont := Low(TiposFrete) to High(TiposFrete) do
  begin
    if (TiposFrete[intCont] = StrToInt(FFatVenda.strTipFre)) then
      Result := DescricoesFrete[intCont];
  end;
end;

procedure TGerarEspelhoRascunhoDANFE.pCarregaDuplicatas;
var
  intContador: integer;
begin
  if fStatusCndPag(FfatVenda.strConPag) = A_VISTA then
    Exit;

  fDigDuplic(FfatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(FfatVenda.strConPag), 0, FfatVenda.fltTotGer, False, False, False,
             VS_Date, False, FfatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean),False, 0, False,
             Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, False, False,
             Nil, False, False, 0, '', '', '', False, False, False, True, True);

  intContador := 0;

  while intContador <= 23 do
  begin
    if (FfatVenda.arrDuplicata[intContador].curValor <= 0) or (intContador > 23) then
      break;

    FcdsDuplic.Insert;
    FcdsDuplic.FieldByName('NUMER1').AsString := fStrZero(intContador + 1, 3);
    FcdsDuplic.FieldByName('DTVEN1').AsString := FfatVenda.arrDuplicata[intContador].dtaDtaVen;
    FcdsDuplic.FieldByName('VALOR1').AsString := FormatFloat('#,##0.00', FfatVenda.arrDuplicata[intContador].curValor);

    Inc(intContador);

    if (FfatVenda.arrDuplicata[intContador].curValor <= 0) or (intContador > 23) then
    begin
      FcdsDuplic.Post;
      break;
    end;

    FcdsDuplic.FieldByName('NUMER2').AsString := fStrZero(intContador + 1, 3);
    FcdsDuplic.FieldByName('DTVEN2').AsString := FfatVenda.arrDuplicata[intContador].dtaDtaVen;
    FcdsDuplic.FieldByName('VALOR2').AsString := FormatFloat('#,##0.00', FfatVenda.arrDuplicata[intContador].curValor);

    Inc(intContador);

    if (FfatVenda.arrDuplicata[intContador].curValor <= 0) or (intContador > 23) then
    begin
      FcdsDuplic.Post;
      break;
    end;

    FcdsDuplic.FieldByName('NUMER3').AsString := fStrZero(intContador + 1, 3);
    FcdsDuplic.FieldByName('DTVEN3').AsString := FfatVenda.arrDuplicata[intContador].dtaDtaVen;
    FcdsDuplic.FieldByName('VALOR3').AsString := FormatFloat('#,##0.00', FfatVenda.arrDuplicata[intContador].curValor);

    FcdsDuplic.Post;

    Inc(intContador);
  end;
end;

function TGerarEspelhoRascunhoDANFE.fUtilizarUnidadeTributavel(const strClaFis: String): Boolean;
begin
  Result := False;

  If (fCfgSis('UNITRI') = 'S') And (Pos(strClaFis, fCfgSis('UTCFOP')) > 0) Then
    Result := True;
end;

function TGerarEspelhoRascunhoDANFE.fGetDescIte(const intCont: Integer): String;
  var
    strDesIte : String;
begin
  If (fEmptyStr(FFatVenda.arrMatItens[intCont].strDesIte)) Then
    strDesIte := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FFatVenda.arrMatItens[intCont].strCodIte], False)
  Else
    strDesIte := FFatVenda.arrMatItens[intCont].strDesIte;

  If fCfgSis('NFEREF', varBoolean) Then
    Result := strDesIte
  Else
    Result := Trim(fCampoTabela('IFNULL(ITE_REFERE, "")', 'CADITE', ['ITE_CODITE'], [FFatVenda.arrMatItens[intCont].strCodIte], False)+ ' '+strDesIte);

  If (fCfgSis('FABNFE', varString) = 'S') AND (Not fEmptyStr(FFatVenda.arrMatItens[intCont].strCodFab)) Then
    Result := FFatVenda.arrMatItens[intCont].strCodFab + ' ' + Result;

  If not fEmptyStr(FFatVenda.arrMatItens[intCont].strDesNes) Then
    Result := Result + ' ' + FFatVenda.arrMatItens[intCont].strDesNes;

end;

procedure TGerarEspelhoRascunhoDANFE.pCarregaEspDet;
var
  intCont  : Integer;
  strCodUni,
  strCodFis: String;
  fltBasFcp: Double;
  fltPerFcp: Double;
  fltValFcp: Double;
  fltBasFcpST: Double;
  fltPerFcpST: Double;
  fltValFcpST: Double;
  fltTotDesEsp: Double;
begin
  strCodFis   := '';
  fltBasFcp   := 0;
  fltPerFcp   := 0;
  fltValFcp   := 0;
  fltBasFcpST := 0;
  fltPerFcpST := 0;
  fltValFcpST := 0;
  fltTotDesEsp := 0;

  for intCont := 0 to Pred(Length(FFatVenda.arrMatItens)) do
  begin
    If ((Pos(FFatVenda.strClaFis, CFOP_DEVOLUCAO) > 0) And
                 (Not fEmptyStr(FFatVenda.arrMatItens[intCont].strDocDev)) And
                 (FFatVenda.fDocumentoParaFornecedor) And
                 (fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [FFatVenda.strCodCli]) = 'I')) Then
    Begin
      fltTotIpiDev := fltTotIpiDev + FFatVenda.arrMatItens[intCont].fltValIpi;
    End;

    FcdsEspDet.Insert;
    FcdsEspDet.FieldByName('DET_SEQGER').AsString := '000000000001';
    FcdsEspDet.FieldByName('DET_ALQCOF').AsFloat  := FFatVenda.arrMatItens[intCont].fltAlqCof;
    FcdsEspDet.FieldByName('DET_ALQICM').AsFloat  := FFatVenda.arrMatItens[intCont].fltAlqIcm;
    FcdsEspDet.FieldByName('DET_ALQIPI').AsFloat  := FFatVenda.arrMatItens[intCont].fltAlqIpi;
    FcdsEspDet.FieldByName('DET_ALQPIS').AsFloat  := FFatVenda.arrMatItens[intCont].fltAlqPis;
    FcdsEspDet.FieldByName('DET_BASCOF').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasCoF;
    FcdsEspDet.FieldByName('DET_BASICM').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasIcm;
    FcdsEspDet.FieldByName('DET_BASIPI').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasIpi;
    FcdsEspDet.FieldByName('DET_BASPIS').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasPis;
    FcdsEspDet.FieldByName('DET_BASRET').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasRet;
    FcdsEspDet.FieldByName('DET_BASVRD').AsFloat  := FFatVenda.arrMatItens[intCont].fltBasVrd;
    FcdsEspDet.FieldByName('DET_CLAFIS').AsString := FFatVenda.arrMatItens[intCont].strClaFis;
    FcdsEspDet.FieldByName('DET_CODABF').AsString := FFatVenda.arrMatItens[intCont].strCodAbf;
    FcdsEspDet.FieldByName('DET_CODFIS').AsString := FFatVenda.arrMatItens[intCont].strCodFis;

    FcdsEspDet.FieldByName('DET_CODFIS').AsString := FFatVenda.fRetornaCstDiferimento(FcdsEspDet.FieldByName('DET_BASICM').AsFloat,
                                                                                      FcdsEspDet.FieldByName('DET_CODFIS').AsString);

    If fCfgSis('NFEREF', varBoolean) And (Not fEmptyStr(FFatVenda.arrMatItens[intCont].strRefere)) Then
      FcdsEspDet.FieldByName('DET_CODITE').AsString := FFatVenda.arrMatItens[intCont].strRefere
    Else
      FcdsEspDet.FieldByName('DET_CODITE').AsString := FFatVenda.arrMatItens[intCont].strCodIte;
    FcdsEspDet.FieldByName('DET_CSTCOF').AsString := FFatVenda.arrMatItens[intCont].strCstCof;
    FcdsEspDet.FieldByName('DET_CSTPIS').AsString := FFatVenda.arrMatItens[intCont].strCstPis;
    FcdsEspDet.FieldByName('DET_DESCON').AsFloat  := FFatVenda.arrMatItens[intCont].fltDescon;
    FcdsEspDet.FieldByName('DET_DESESP').AsFloat  := fDescontaICMSDesonerado(FFatVenda.arrMatItens[intCont]);
    FcdsEspDet.FieldByName('DET_INCPIS').AsString := FFatVenda.arrMatItens[intCont].strIncPis;
    FcdsEspDet.FieldByName('DET_MTDICM').AsString := FFatVenda.arrMatItens[intCont].strMtdIcm;
    FcdsEspDet.FieldByName('DET_QTDITE').AsFloat  := FFatVenda.arrMatItens[intCont].fltQtdIte;

    if not fEmptyStr(FFatVenda.arrMatItens[intCont].strSeqGad) then
      FcdsEspDet.FieldByName('DET_SEQDET').AsString := FFatVenda.arrMatItens[intCont].strIncDev
    else
      FcdsEspDet.FieldByName('DET_SEQDET').AsString := FFatVenda.arrMatItens[intCont].strAiDvOr;

    FcdsEspDet.FieldByName('DET_TOTITE').AsFloat  := FFatVenda.arrMatItens[intCont].fltTotIte;
    FcdsEspDet.FieldByName('DET_UNIDIG').AsFloat  := FFatVenda.arrMatItens[intCont].fltUniDig;
    FcdsEspDet.FieldByName('DET_UNIORI').AsFloat  := FFatVenda.arrMatItens[intCont].fltUniOri;
    FcdsEspDet.FieldByName('DET_UNITAR').AsFloat  := FFatVenda.arrMatItens[intCont].fltUnitar;
    FcdsEspDet.FieldByName('DET_VALCOF').AsFloat  := FFatVenda.arrMatItens[intCont].fltValCof;
    FcdsEspDet.FieldByName('DET_VALICM').AsFloat  := FFatVenda.arrMatItens[intCont].fltValIcm;
    FcdsEspDet.FieldByName('DET_VALIPI').AsFloat  := FFatVenda.arrMatItens[intCont].fltValIpi;
    FcdsEspDet.FieldByName('DET_VALPIS').AsFloat  := FFatVenda.arrMatItens[intCont].fltValPis;
    FcdsEspDet.FieldByName('DET_VALRET').AsFloat  := FFatVenda.arrMatItens[intCont].fltValRet;
    FcdsEspDet.FieldByName('DET_VRDICM').AsFloat  := FFatVenda.arrMatItens[intCont].fltVrdIcm;

    If FFatVenda.fEhGarantiaFornecedorComDocumentoVinculado Then
    Begin
      FcdsEspDet.FieldByName('DET_BASFCP').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltBase;
      FcdsEspDet.FieldByName('DET_PERFCP').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltAliquota;
      FcdsEspDet.FieldByName('DET_VALFCP').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltValor;

      FcdsEspDet.FieldByName('DET_BFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltBase;
      FcdsEspDet.FieldByName('DET_PFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltAliquota;
      FcdsEspDet.FieldByName('DET_VFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltValor;
    End
    Else
    Begin
      FcdsEspDet.FieldByName('DET_BASFCP').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltBase;
      FcdsEspDet.FieldByName('DET_PERFCP').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltAliquota;
      FcdsEspDet.FieldByName('DET_VALFCP').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltValor;

      FcdsEspDet.FieldByName('DET_BFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltBase;
      FcdsEspDet.FieldByName('DET_PFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltAliquota;
      FcdsEspDet.FieldByName('DET_VFCPST').AsFloat  := FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltValor;
    End;

    FcdsEspDet.FieldByName('DET_NUMLOT').AsString := '';
    FcdsEspDet.FieldByName('DET_DOCDEV').AsString := FFatVenda.arrMatItens[intCont].strDocDev;
    FcdsEspDet.FieldByName('DET_ESPDEV').AsString := FFatVenda.arrMatItens[intCont].strEspDev;
    FcdsEspDet.FieldByName('DET_EMPDEV').AsString := FFatVenda.arrMatItens[intCont].strEmpDev;
    FcdsEspDet.FieldByName('DET_DESNES').AsString := FFatVenda.arrMatItens[intCont].strDesNes;
    FcdsEspDet.FieldByName('DESITE').AsString     := fGetDescIte(intCont);
    FcdsEspDet.FieldByName('CLAIPI').AsString     := FFatVenda.arrMatItens[intCont].strClaIPI;

    If Not fUtilizarUnidadeTributavel(FFatVenda.arrMatItens[intCont].strClaFis) Then
      strCodUni := fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [FFatVenda.arrMatItens[intCont].strCodIte], False)
    Else
      strCodUni := fCampoTabela('ITE_UNITRI', 'CADITE', ['ITE_CODITE'], [FFatVenda.arrMatItens[intCont].strCodIte], False);

    FcdsEspDet.FieldByName('SIGUNI').AsString := fCampoTabela('UNI_SIGUNI', 'CADUNI', ['UNI_CODUNI'], [strCodUni], False);
    FcdsEspDet.Post;

    strCodFis   := strCodFis   + ',' + FFatVenda.arrMatItens[intCont].strCodFis;

    If FFatVenda.fEhGarantiaFornecedorComDocumentoVinculado Then
    Begin
      fltBasFcp   := fltBasFcp   + FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltBase;
      fltValFcp   := fltValFcp   + FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltValor;
      fltBasFcpST := fltBasFcpST + FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltBase;
      fltValFcpST := fltValFcpST + FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltValor;
      fltPerFcp   := IIF(FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltAliquota   > 0, FFatVenda.arrMatItens[intCont].EspelhoFcpIcms.fltAliquota,   0);
      fltPerFcpST := IIF(FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltAliquota > 0, FFatVenda.arrMatItens[intCont].EspelhoFcpIcmsST.fltAliquota, 0);
    End
    Else
    Begin
      fltBasFcp   := fltBasFcp   + FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltBase;
      fltValFcp   := fltValFcp   + FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltValor;
      fltBasFcpST := fltBasFcpST + FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltBase;
      fltValFcpST := fltValFcpST + FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltValor;
      fltPerFcp   := IIF(FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltAliquota   > 0, FFatVenda.arrMatItens[intCont].VisualizarFcpIcms.fltAliquota,   0);
      fltPerFcpST := IIF(FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltAliquota > 0, FFatVenda.arrMatItens[intCont].VisualizarFcpIcmsST.fltAliquota, 0);
    End;

    fltTotDesEsp := fltTotDesEsp + FcdsEspDet.FieldByName('DET_DESESP').AsFloat;
  end;

  FcdsEspGer.Edit;
  FcdsEspGer.FieldByName('BASFCP').AsFloat  := fltBasFcp;
  FcdsEspGer.FieldByName('PERFCP').AsFloat  := fltPerFcp;
  FcdsEspGer.FieldByName('VALFCP').AsFloat  := fltValFcp;
  FcdsEspGer.FieldByName('BFCPST').AsFloat  := fltBasFcpST;
  FcdsEspGer.FieldByName('PFCPST').AsFloat  := fltPerFcpST;
  FcdsEspGer.FieldByName('VFCPST').AsFloat  := fltValFcpST;
  FcdsEspGer.FieldByName('CODFIS').AsString := Copy(strCodFis, 2, Length(strCodFis));
  FcdsEspGer.FieldByName('GER_DESESP').AsFloat  := fltTotDesEsp;

  If (fltTotIpiDev > 0) Then
  Begin
    FcdsEspGer.FieldByName('GER_TOTIPI').AsFloat   := 0;
    FcdsEspGer.FieldByName('GER_IPIDEV').AsFloat   := fltTotIpiDev;
  End;

  FcdsEspGer.Post;
end;

procedure TGerarEspelhoRascunhoDANFE.pCarregaEspGer;
var
  valorDuplicatas: TValoresDuplicatas;
begin
  try
    valorDuplicatas := TValoresDuplicatas.Create(FFatVenda.arrDuplicata, FFatVenda.intSeqDupBaiUtiCred);

    FcdsEspGer.Insert;
    FcdsEspGer.FieldByName('AUTOINCREM').AsString  := '000000000001';
    FcdsEspGer.FieldByName('GER_CODEMP').AsString  := VS_strCodEmp;
    FcdsEspGer.FieldByName('GER_NUMESP').AsString  := '';
    FcdsEspGer.FieldByName('GER_CODFOR').AsString  := FFatVenda.strCodFor;
    FcdsEspGer.FieldByName('GER_CODCLI').AsString  := FFatVenda.strCodCli;
    FcdsEspGer.FieldByName('GER_TIP_FC').AsString  := 'F';
    FcdsEspGer.FieldByName('GER_CODADE').AsFloat   := 0;
    FcdsEspGer.FieldByName('GER_CLAFIS').AsString  := FFatVenda.strClaFis;
    FcdsEspGer.FieldByName('GER_TOTPRO').AsFloat   := FFatVenda.fltTotPro;
    FcdsEspGer.FieldByName('GER_TOTIPI').AsFloat   := FFatVenda.fltTotIpi;
    FcdsEspGer.FieldByName('GER_TOTRET').AsFloat   := FFatVenda.fltTotRet;
    FcdsEspGer.FieldByName('GER_TOTFCP').AsFloat   := FFatVenda.fltTotFcpST;
    FcdsEspGer.FieldByName('GER_TOTFRE').AsFloat   := FFatVenda.fltValFre;
    FcdsEspGer.FieldByName('GER_DESACE').AsFloat   := FFatVenda.fltDesAce;
    FcdsEspGer.FieldByName('GER_VLRCON').AsFloat   := FFatVenda.fltTotGer;
    FcdsEspGer.FieldByName('GER_QTDITE').AsInteger := Length(FFatVenda.arrMatItens);
    FcdsEspGer.FieldByName('GER_MOVGER').AsString  := '';
    FcdsEspGer.FieldByName('GER_CONPAG').AsString  := FFatVenda.strConPag;
    FcdsEspGer.FieldByName('GER_CODCND').AsString  := FFatVenda.strCodCnd;
    FcdsEspGer.FieldByName('GER_CODFPG').AsString  := FFatVenda.strCodFpg;
    FcdsEspGer.FieldByName('GER_VPAR01').AsFloat   := valorDuplicatas.fltValor01;
    FcdsEspGer.FieldByName('GER_VPAR02').AsFloat   := valorDuplicatas.fltValor02;
    FcdsEspGer.FieldByName('GER_VPAR03').AsFloat   := valorDuplicatas.fltValor03;
    FcdsEspGer.FieldByName('GER_VPAR04').AsFloat   := valorDuplicatas.fltValor04;
    FcdsEspGer.FieldByName('GER_VPAR05').AsFloat   := valorDuplicatas.fltValor05;
    FcdsEspGer.FieldByName('GER_VPAR06').AsFloat   := valorDuplicatas.fltValor06;
    FcdsEspGer.FieldByName('GER_VPAR07').AsFloat   := valorDuplicatas.fltValor07;
    FcdsEspGer.FieldByName('GER_VPAR08').AsFloat   := valorDuplicatas.fltValor08;
    FcdsEspGer.FieldByName('GER_VPAR09').AsFloat   := valorDuplicatas.fltValor09;
    FcdsEspGer.FieldByName('GER_VPAR10').AsFloat   := valorDuplicatas.fltValor10;
    FcdsEspGer.FieldByName('GER_VPAR11').AsFloat   := valorDuplicatas.fltValor11;
    FcdsEspGer.FieldByName('GER_VPAR12').AsFloat   := valorDuplicatas.fltValor12;
    FcdsEspGer.FieldByName('GER_CNFNFE').AsString  := FFatVenda.fRetDadosCNF_NFE('C');
    FcdsEspGer.FieldByName('GER_CNFFIS').AsString  := FFatVenda.fRetDadosCNF_NFE('F');
    FcdsEspGer.FieldByName('GER_OBSERV').AsString  := FFatVenda.fMensagemAdicionalComercial;
    FcdsEspGer.FieldByName('GER_OBSFIS').AsString  := FFatVenda.fMensagemAdicionalFiscal;
    FcdsEspGer.FieldByName('GER_CODTRA').AsString  := FFatVenda.strCodTra;
    FcdsEspGer.FieldByName('GER_BASIPI').AsFloat   := FFatVenda.fltBasIPI;
    FcdsEspGer.FieldByName('GER_ALQIPI').AsFloat   := FFatVenda.fltAlqIPI;
    FcdsEspGer.FieldByName('GER_BASICM').AsFloat   := FFatVenda.fltBasIcm;
    FcdsEspGer.FieldByName('GER_ALQICM').AsFloat   := FFatVenda.fltAlqICM;
    FcdsEspGer.FieldByName('GER_TOTICM').AsFloat   := FFatVenda.fltTotICM;
    FcdsEspGer.FieldByName('GER_ALQRET').AsFloat   := FFatVenda.fltAlqRet;
    FcdsEspGer.FieldByName('GER_BASRET').AsFloat   := FFatVenda.fltBasRet;
    FcdsEspGer.FieldByName('GER_ALQFCP').AsFloat   := FFatVenda.fltAlqFcpST;
    FcdsEspGer.FieldByName('GER_BASFCP').AsFloat   := FFatVenda.fltBasFcpST;
    FcdsEspGer.FieldByName('GER_DESESP').AsFloat   := FFatVenda.fltDesEsp;
    FcdsEspGer.FieldByName('GER_TIPFRE').AsString  := FFatVenda.strTipFre;
    FcdsEspGer.FieldByName('GER_PESBRU').AsFloat   := FFatVenda.fltPesBru;
    FcdsEspGer.FieldByName('GER_PESLIQ').AsFloat   := FFatVenda.fltPesLiq;
    FcdsEspGer.FieldByName('GER_VOLUME').AsFloat   := FFatVenda.intQtdTra;
    FcdsEspGer.FieldByName('GER_ESPECI').AsString  := FFatVenda.strEspTra;
    FcdsEspGer.FieldByName('GER_MARCA_').AsString  := FFatVenda.strMarTra;
    FcdsEspGer.FieldByName('GER_NUMERA').AsString  := FFatVenda.strNumera;
    FcdsEspGer.FieldByName('GER_MEN001').AsString  := FFatVenda.strMen001;
    FcdsEspGer.FieldByName('GER_MEN002').AsString  := FFatVenda.strMen002;
    FcdsEspGer.FieldByName('GER_MEN003').AsString  := FFatVenda.strMen003;
    FcdsEspGer.FieldByName('GER_MEN004').AsString  := FFatVenda.strMen004;
    FcdsEspGer.FieldByName('GER_MEN005').AsString  := FFatVenda.strMen005;
    FcdsEspGer.FieldByName('GER_CHVNFE').AsString  := FFatVenda.strChaveNFeRefDevolucao;
    FcdsEspGer.FieldByName('NUMESP').AsString      := 'Espelho Rascunho da DANFE';
    FcdsEspGer.FieldByName('TIP_FC').AsString      := 'F';
    FcdsEspGer.FieldByName('BASFCP').AsFloat       := 0;
    FcdsEspGer.FieldByName('VALFCP').AsFloat       := 0;
    FcdsEspGer.FieldByName('DISCRIMINACAO_DESPESAS_ACESSORIAS').AsString := '';
    If Not fEmptyStr(FFatVenda.strDesCla) Then
      FcdsEspGer.FieldByName('CLAFIS').AsString      := FFatVenda.strDesCla
    Else
      FcdsEspGer.FieldByName('CLAFIS').AsString      := fCampoTabela('CFO_DESCR1', 'CADCFO', ['CFO_CODCFO'], [FFatVenda.strClaFis], False);
    FcdsEspGer.FieldByName('TIPFRE').AsString      := fGetTipoFrete;
    FcdsEspGer.FieldByName('GER_IPIDEV').AsFloat   := 0;
    FcdsEspGer.Post;
  finally
    FreeAndNil(valorDuplicatas);
  end;
end;

procedure TGerarEspelhoRascunhoDANFE.pCriarClientDuplicatas;
begin
  FcdsDuplic := TUniClientDataSet.Create(nil);
  FcdsDuplic.FieldDefs.Add('NUMER1', ftString, 3);
  FcdsDuplic.FieldDefs.Add('NUMER2', ftString, 3);
  FcdsDuplic.FieldDefs.Add('NUMER3', ftString, 3);
  FcdsDuplic.FieldDefs.Add('DTVEN1', ftString, 10);
  FcdsDuplic.FieldDefs.Add('DTVEN2', ftString, 10);
  FcdsDuplic.FieldDefs.Add('DTVEN3', ftString, 10);
  FcdsDuplic.FieldDefs.Add('VALOR1', ftString, 12);
  FcdsDuplic.FieldDefs.Add('VALOR2', ftString, 12);
  FcdsDuplic.FieldDefs.Add('VALOR3', ftString, 12);
  FcdsDuplic.CreateDataSet;
end;

procedure TGerarEspelhoRascunhoDANFE.pCarregaEnderecoEntrega;
begin
  FcdsEndEnt.Insert;
  FcdsEndEnt.FieldByName('CNPJ').AsString    := FfatVenda.strCliCgc;
  FcdsEndEnt.FieldByName('XLgr').AsString    := FfatVenda.enderecoEntrega.strEndEnt;
  FcdsEndEnt.FieldByName('Nro').AsString     := '';
  FcdsEndEnt.FieldByName('XCpl').AsString    := '';
  FcdsEndEnt.FieldByName('XBairro').AsString := FfatVenda.enderecoEntrega.strBaiEnt;
  FcdsEndEnt.FieldByName('CMun').AsString    := '';
  FcdsEndEnt.FieldByName('XMun').AsString    := FfatVenda.enderecoEntrega.strNomCid;
  FcdsEndEnt.FieldByName('UF').AsString      := FfatVenda.enderecoEntrega.strEstEnt;
  FcdsEndEnt.FieldByName('CEP').AsString     := FfatVenda.enderecoEntrega.strCepEnt;
  FcdsEndEnt.FieldByName('Fone').AsString    := FfatVenda.enderecoEntrega.strTelEnt;
  FcdsEndEnt.Post;
end;

procedure TGerarEspelhoRascunhoDANFE.pCriarClientEnderecoEntrega;
begin
  FcdsEndEnt := TUniClientDataSet.Create(nil);
  FcdsEndEnt.FieldDefs.Add('CNPJ'   , ftString, 18);
  FcdsEndEnt.FieldDefs.Add('XLgr'   , ftString, 60);
  FcdsEndEnt.FieldDefs.Add('Nro'    , ftString, 60);
  FcdsEndEnt.FieldDefs.Add('XCpl'   , ftString, 60);
  FcdsEndEnt.FieldDefs.Add('XBairro', ftString, 60);
  FcdsEndEnt.FieldDefs.Add('CMun'   , ftString, 7);
  FcdsEndEnt.FieldDefs.Add('XMun'   , ftString, 60);
  FcdsEndEnt.FieldDefs.Add('UF'     , ftString, 2);
  FcdsEndEnt.FieldDefs.Add('CEP'    , ftString, 9);
  FcdsEndEnt.FieldDefs.Add('Fone'   , ftString, 15);
  FcdsEndEnt.CreateDataSet;
end;

procedure TGerarEspelhoRascunhoDANFE.pCriarClientEspDet;
begin
  FcdsEspDet := TUniClientDataSet.Create(nil);
  FcdsEspDet.FieldDefs.Add('DET_SEQGER', ftString, 12);
  FcdsEspDet.FieldDefs.Add('DET_ALQCOF', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_ALQICM', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_ALQIPI', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_ALQPIS', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASCOF', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASICM', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASIPI', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASPIS', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASRET', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASVRD', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_CLAFIS', ftString,  4);
  FcdsEspDet.FieldDefs.Add('DET_CODABF', ftString,  IIf(fCfgSis('USASAN') = 'S', 7, 3));
  FcdsEspDet.FieldDefs.Add('DET_CODFIS', ftString,  3);
  FcdsEspDet.FieldDefs.Add('DET_CODITE', ftString,  20);
  FcdsEspDet.FieldDefs.Add('DET_CSTCOF', ftString,  2);
  FcdsEspDet.FieldDefs.Add('DET_CSTPIS', ftString,  2);
  FcdsEspDet.FieldDefs.Add('DET_DESCON', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_DESESP', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_INCPIS', ftString,  1);
  FcdsEspDet.FieldDefs.Add('DET_MTDICM', ftString,  2);
  FcdsEspDet.FieldDefs.Add('DET_QTDITE', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_SEQDET', ftString, 20);
  FcdsEspDet.FieldDefs.Add('DET_TOTITE', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_UNIDIG', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_UNIORI', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_UNITAR', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALCOF', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALICM', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALIPI', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALPIS', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALRET', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VRDICM', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BASFCP', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_PERFCP', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VALFCP', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_BFCPST', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_PFCPST', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_VFCPST', ftFloat);
  FcdsEspDet.FieldDefs.Add('DET_NUMLOT', ftString, 30);
  FcdsEspDet.FieldDefs.Add('DET_DOCDEV', ftString, 20);
  FcdsEspDet.FieldDefs.Add('DET_ESPDEV', ftString,  2);
  FcdsEspDet.FieldDefs.Add('DET_EMPDEV', ftString,  3);
  FcdsEspDet.FieldDefs.Add('DET_DESNES', ftString, 255);
  FcdsEspDet.FieldDefs.Add('DESITE'    , ftString, 150);
  FcdsEspDet.FieldDefs.Add('CLAIPI'    , ftString, 60);
  FcdsEspDet.FieldDefs.Add('SIGUNI'    , ftString,  6);
  FcdsEspDet.FieldDefs.Add('CHVPRO'    , ftMemo);
  FcdsEspDet.CreateDataSet;
end;

procedure TGerarEspelhoRascunhoDANFE.pCriarClientEspGer;
begin
  FcdsEspGer := TUniClientDataSet.Create(nil);
  FcdsEspGer.FieldDefs.Add('AUTOINCREM', ftString, 12);
  FcdsEspGer.FieldDefs.Add('GER_CODEMP', ftString,  3);
  FcdsEspGer.FieldDefs.Add('GER_NUMESP', ftString, 12);
  FcdsEspGer.FieldDefs.Add('GER_CODFOR', ftString,  8);
  FcdsEspGer.FieldDefs.Add('GER_CODCLI', ftString,  8);
  FcdsEspGer.FieldDefs.Add('GER_TIP_FC', ftString,  1);
  FcdsEspGer.FieldDefs.Add('GER_CODADE', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_CLAFIS', ftString,  4);
  FcdsEspGer.FieldDefs.Add('GER_TOTPRO', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TOTIPI', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TOTRET', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TOTFCP', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TOTFRE', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_DESACE', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VLRCON', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_QTDITE', ftInteger);
  FcdsEspGer.FieldDefs.Add('GER_MOVGER', ftString, 20);
  FcdsEspGer.FieldDefs.Add('GER_CONPAG', ftString, 38);
  FcdsEspGer.FieldDefs.Add('GER_CODCND', ftString,  3);
  FcdsEspGer.FieldDefs.Add('GER_CODFPG', ftString,  3);
  FcdsEspGer.FieldDefs.Add('GER_VPAR01', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR02', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR03', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR04', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR05', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR06', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR07', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR08', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR09', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR10', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR11', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VPAR12', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_CNFNFE', ftMemo);
  FcdsEspGer.FieldDefs.Add('GER_CNFFIS', ftMemo);
  FcdsEspGer.FieldDefs.Add('GER_OBSERV', ftMemo);
  FcdsEspGer.FieldDefs.Add('GER_OBSFIS', ftMemo);
  FcdsEspGer.FieldDefs.Add('GER_CODTRA', ftString,  5);
  FcdsEspGer.FieldDefs.Add('GER_BASIPI', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_ALQIPI', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_BASICM', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_ALQICM', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TOTICM', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_ALQRET', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_BASRET', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_ALQFCP', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_BASFCP', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_DESESP', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_TIPFRE', ftString,  1);
  FcdsEspGer.FieldDefs.Add('GER_PESBRU', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_PESLIQ', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_VOLUME', ftFloat);
  FcdsEspGer.FieldDefs.Add('GER_ESPECI', ftString, 10);
  FcdsEspGer.FieldDefs.Add('GER_MARCA_', ftString, 10);
  FcdsEspGer.FieldDefs.Add('GER_NUMERA', ftString, 14);
  FcdsEspGer.FieldDefs.Add('GER_MEN001', ftString, 80);
  FcdsEspGer.FieldDefs.Add('GER_MEN002', ftString, 80);
  FcdsEspGer.FieldDefs.Add('GER_MEN003', ftString, 80);
  FcdsEspGer.FieldDefs.Add('GER_MEN004', ftString, 80);
  FcdsEspGer.FieldDefs.Add('GER_MEN005', ftString, 80);
  FcdsEspGer.FieldDefs.Add('GER_CHVNFE', ftString, 44);
  FcdsEspGer.FieldDefs.Add('NUMESP',     ftString, 30);
  FcdsEspGer.FieldDefs.Add('TIP_FC',     ftString,  1);
  FcdsEspGer.FieldDefs.Add('CODFIS',     ftString, 10);
  FcdsEspGer.FieldDefs.Add('BFCPST',     ftFloat);
  FcdsEspGer.FieldDefs.Add('PFCPST',     ftFloat);
  FcdsEspGer.FieldDefs.Add('VFCPST',     ftFloat);
  FcdsEspGer.FieldDefs.Add('BASFCP',     ftFloat);
  FcdsEspGer.FieldDefs.Add('PERFCP',     ftFloat);
  FcdsEspGer.FieldDefs.Add('VALFCP',     ftFloat);
  FcdsEspGer.FieldDefs.Add('DISCRIMINACAO_DESPESAS_ACESSORIAS', ftString, 50);
  FcdsEspGer.FieldDefs.Add('CLAFIS',     ftString, 60);
  FcdsEspGer.FieldDefs.Add('TIPFRE',     ftString, 50);
  FcdsEspGer.FieldDefs.Add('GER_IPIDEV', ftFloat);
  FcdsEspGer.CreateDataSet;
end;

end.
