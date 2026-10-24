unit Fulfillment.Classes.NotaFiscal;

interface

Uses
  Classes, untEntNfeXml, untTValidaNFeCapa, StrUtils, System.SysUtils,
  untFuncoesSimples;

Type
  TItemNota = class(TObject)
  public
    intNumIte: Integer;
    strNumPed: String;
    strCodXml: String; //código do produto no xml
    strCodAut: String; //código do produto no autcom
    strEANTri: String;
    strDescri: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    strUnidad: String;
    fltTotPro: Double;
    fltDesEsp: Double;
    fltTotFre: Double;
    fltDescon: Double;
    fltDesAce: Double;
    blnMovEstoque: Boolean;
    strCstIcms: String;
    strCfop: String;
    strCodNat: String;
    fltBaseIcms: Double;
    fltAlqIcms: Double;
    fltValIcms: Double;
    fltBaseST: Double;
    fltAlqST: Double;
    fltValorST: Double;
    strPerApuIpi: String;
    strCstIpi: String;
    strCodEnqIpi: String;
    fltBaseIPI: Double;
    fltAlqIPI: Double;
    fltValorIPI: Double;

    strCstPis: String;
    fltBasePis: Double;
    fltAlqPis: Double;
    fltValorPis: Double;

    strCstCofins: String;
    fltBaseCofins: Double;
    fltAlqCofins: Double;
    fltValorCofins: Double;

    fltBaseIcmsUfDest: Double;

    fltBaseFcp: Double;
    fltPercFcp: Double;
    fltValorFcp: Double;

    fltBaseFcpST: Double;
    fltPercFcpST: Double;
    fltValorFcpST: Double;

    fltBaseFcpUfDest: Double;
    fltPercFcpUfDest: Double;
    fltValorFcpUfDest: Double;

    fltPercIcmsUfDest: Double;
    fltPercIcmsInter: Double;
    fltPercIcmsInterPart: Double;
    fltIcmsUfDest: Double;
    fltIcmsUfRemet: Double;
    strBxSbIt: String;

    constructor Create(nota: TNFeXml; intIndice: Integer);
  End;

  TNotaFiscal = class(TObject)
  public
    strEntSai: String;
    strCFOP: String;
    blnEmiPropria: Boolean;
    strCodCli: String;
    strModelo: String;
    strSerie: String;
    strNumDoc: String;
    intIndFinal: Integer;
    strCNPJEmi: String;
    strChaveNfe: String;
    strStatusNFE: String;
    strMotivo: String;
    strCodMot: String;
    dtaDtaDoc: TDateTime;
    dtaDtaEnt: TDateTime;
    fltValorProdutos: Double;
    fltValorTotal: Double;
    strIndPagto: String;
    fltDesconto: Double;
    fltAbatNaoTrib: Double;
    fltTotalNota: Double;
    strTipoFrete: String;
    fltValorFrete: Double;
    fltValorSeguro: Double;
    fltDespAcessorias: Double;
    fltBaseIcms: Double;
    fltValorIcms: Double;
    fltBaseST: Double;
    fltValorST: Double;
    fltBaseIPI: Double;
    fltValorIPI: Double;
    fltValorPIS: Double;
    fltValorCofins: Double;
    fltValorPISST: Double;
    fltValorCOFINSST: Double;
    fltValorIcmsDest: Double;
    strCodExt: String;
    strXTexto: String;

    arrItemNota: Array Of TItemNota;

    constructor Create(nota: TNFeXml; strCnpjEmpresa: String);
    destructor Destroy; override;
    procedure pAdicionaItem(nota: TNFeXml);
    function DeSaida: Boolean;
  end;

implementation

{ TItemNota }

constructor TItemNota.Create(nota: TNFeXml; intIndice: Integer);
  Var
    item: TRecDetEle;
begin
  item := nota.getItemNota[intIndice];

  intNumIte   := intIndice+1;
  strNumPed   := String(item.XPED);
  strCodXml   := String(item.I02_CPROD);
  strCodAut   := EmptyStr;
  strEANTri   := String(item.I12_CEANTRIB);
  strDescri   := String(item.I04_XPROD);
  strUnidad   := String(item.I09_UCOM);
  fltQtdIte   := IIF(item.I10_QCOM > 0, item.I10_QCOM, 1);
  fltUnitar   := item.I10A_VUNCOM;
  fltTotPro   := item.I11_VPROD;
  fltTotFre   := item.I15_VFRETE;
  fltDescon   := item.I17_VDESC;
  fltDesAce   := item.I17A_VOUTRO;
  blnMovEstoque := True;
  strCstIcms  := String(item.DET_CSTXML);
  strCfop     := String(item.I08_CFOP);
  strCodNat   := String(item.I08_CFOP);
  fltBaseIcms := item.N15_VBC;
  fltAlqIcms  := item.N16_PICMS;
  fltValIcms  := item.N17_VICMS;
  fltBaseST   := item.N21_VBCST;
  fltAlqST    := item.N22_PICMSST;
  fltValorST  := item.N23_VICMSST;

  // FCP Operação própria
  fltBaseFcp  := item.N17A_VBCFCP;
  fltPercFcp  := item.N17B_PFCP;
  fltValorFcp := item.N17C_VFCP;

  // FCP Substituição Tributária
  fltBaseFcpST  := item.N23A_VBCFCPST;
  fltPercFcpST  := item.N23B_PFCPST;
  fltValorFcpST := item.N23D_FCPST;

  // FCP Difal (UF Destino)
  fltBaseFcpUfDest     := item.N24_VBCFCPUFDEST;
  fltPercFcpUfDest     := item.N24_PFCPUFDEST;
  fltValorFcpUfDest    := item.N24_VFCPUFDEST;

  fltBaseIcmsUfDest    := item.N24_VBCUFDEST;
  fltPercIcmsUfDest    := item.N24_PICMSUFDEST;
  fltPercIcmsInter     := item.N24_PICMSINTER;
  fltPercIcmsInterPart := item.N24_PICMSINTERPART;
  fltIcmsUfDest        := item.N24_VICMSUFDEST;
  fltIcmsUfRemet       := item.N24_VICMSUFREMET;

  strPerApuIpi := '0';
  strCstIpi := '';
  strCodEnqIpi := String(item.I06_EXTIPI);

  If item.O14_VIPI > 0 Then
    fltBaseIPI := item.O10_VBC;

  fltAlqIPI := item.O13_PIPI;

  If (item.U61_VALIPIDEVOL > 0) Then
  Begin
    fltValorIPI := item.U61_VALIPIDEVOL;
    If (item.U51_PERCDEVOL = 100) Then
      fltBaseIPI := item.I11_VPROD
    Else
      fltBaseIPI := fFormataFloat((item.I11_VPROD * (item.U51_PERCDEVOL / 100)), 2);
    fltAlqIPI := fFormataFloat(((fltValorIPI/fltBaseIPI) * 100), 2)
  End
  Else
   fltValorIPI := item.O14_VIPI;

  strCstPis := String(item.Q06_CST);
  fltBasePis := item.Q07_VBC;
  fltAlqPis := item.Q08_PPIS;
  fltValorPis := item.Q09_VPIS;

  strCstCofins := String(item.S06_CST);
  fltBaseCofins := item.S07_VBC;
  fltAlqCofins := item.S08_PCOFINS;
  fltValorCofins := item.S11_VCOFINS;
  strBxSbIt := 'N';
end;

{ TNotaFiscal }

constructor TNotaFiscal.Create(nota: TNFeXml; strCnpjEmpresa: String);
Var
  I: Integer;
begin
  SetLength(arrItemNota, 0);

  strEntSai := IIF(nota.getItemNota[0].I08_CFOP > '5000', 'S', 'E');
  strCFOP   := String(nota.getItemNota[0].I08_CFOP);

  blnEmiPropria := True;
  strCodCli := String(nota.recDadosNota.E02_CNPJ);
  strModelo := '55';
  strSerie  := fStrZero(String(nota.recDadosNota.B07_SERIE),3);
  strNumDoc := RightStr(String(nota.recDadosNota.B08_NNF), nota.fTamNumDocGerEle);
  intIndFinal := nota.recDadosNota.B25B_INDFINAL;
  strCNPJEmi  := String(nota.recDadosNota.C02_CNPJ);
  strChaveNfe := nota.recDadosNota.PR07_CHNFE;
  dtaDtaDoc := nota.recDadosNota.B09_DEMI;
  dtaDtaEnt := nota.recDadosNota.B09_DEMI;
  fltValorProdutos := nota.recDadosNota.W07_VPROD;
  fltValorTotal := nota.recDadosNota.W16_VNF;
  strIndPagto := String(nota.recDadosNota.B05_INDPAG);
  fltDesconto := nota.recDadosNota.W10_VDESC;
  fltAbatNaoTrib := 0;
  fltTotalNota := nota.recDadosNota.W16_VNF;
  strTipoFrete := nota.recDadosNota.X33_MODFRETE;
  fltValorFrete := nota.recDadosNota.W08_VFRETE;
  fltValorSeguro := 0;
  fltDespAcessorias := nota.recDadosNota.W15_VOUTRO;
  fltBaseIcms := nota.recDadosNota.W03_VBC;
  fltValorIcms := nota.recDadosNota.W04_VICMS;
  fltBaseST := nota.recDadosNota.W05_VBCST;
  fltValorST := nota.recDadosNota.W06_VST;

  fltBaseIPI := 0;
  For I := 0 To nota.getQuantidadeItens -1 do
    fltBaseIPI := fltBaseIPI + nota.getItemNota[I].O10_VBC;

  If (nota.recDadosNota.W12A_VIPIDEVOL > 0) Then
    fltValorIPI := nota.recDadosNota.W12A_VIPIDEVOL
  Else
    fltValorIPI := nota.recDadosNota.W12_VIPI;

  fltValorPIS := nota.recDadosNota.W13_VPIS;
  fltValorCofins := nota.recDadosNota.W14_VCOFINS;
  fltValorIcmsDest := nota.recDadosNota.W31_VICMSUFDEST;
  strStatusNFE     := nota.recDadosNota.PR08_STATUS;
  strMotivo        := nota.recDadosNota.PR09_MOTIVO;
  strCodMot        := String(nota.recDadosNota.B06_MOD);
  fltValorPISST    := 0;
  fltValorCOFINSST := 0;
end;

function TNotaFiscal.DeSaida: Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    If arrItemNota[intContador].strCfop > '5000' Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

destructor TNotaFiscal.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    FreeAndNil(arrItemNota[intContador]);
  End;
  SetLength(arrItemNota,0);
  inherited;
end;

procedure TNotaFiscal.pAdicionaItem(nota: TNFeXml);
  Var
    intContador: Integer;
begin
  SetLength(arrItemNota, nota.getQuantidadeItens);

  For intContador := Low(arrItemNota) To High(arrItemNota) Do
  Begin
    arrItemNota[intContador] := TItemNota.Create(nota, intContador);
  End;
end;

end.
