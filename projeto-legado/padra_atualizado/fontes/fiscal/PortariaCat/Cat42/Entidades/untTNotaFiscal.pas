unit untTNotaFiscal;

interface

uses SysUtils,
     System.Generics.Collections,
     untTItemNotaFiscal,
     untTFormaPagamento,
     untTTransportadora,
     untTParticipante,
     untTObservacao,
     untTEcf,
     untTGNRE;

type
  TNotaFiscalDetalhada = class(TObject)
    private
      FCfop: String;
      FValorContabil: Double;
      FBaseIcms: Double;
      FAliquotaIcms: Double;
      FValorIcms: Double;
      FValorOutras: Double;
      FValorIsentas: Double;
      FBaseIcmsSt: double;
      FValorIcmsST: double;
      FBaseIpi: double;
      FAliquotaIpi: double;
      FValorIpi: double;
      FNumDoc: string;
    public
      property strCfop: String read FCfop write FCfop;
      property fltValorContabil: Double read FValorContabil write FValorContabil;
      property fltBaseIcms: Double read FBaseIcms write FBaseIcms;
      property fltAliquotaIcms: Double read FAliquotaIcms write FAliquotaIcms;
      property fltValorIcms: Double read FValorIcms write FValorIcms;
      property fltValorOutras: Double read FValorOutras write FValorOutras;
      property fltValorIsentas: Double read FValorIsentas write FValorIsentas;
      property fltBaseIcmsSt: double read FBaseIcmsSt write FBaseIcmsSt;
      property fltValorIcmsST: double read FValorIcmsST write FValorIcmsST;
      property fltBaseIpi: double read FBaseIpi write FBaseIpi;
      property fltAliquotaIpi: double read FAliquotaIpi write FAliquotaIpi;
      property fltValorIpi: double read FValorIpi write FValorIpi;
      property strNumDoc: string read FNumDoc write FNumDoc;
  end;

type
  TNotaFiscalSintetizada = class(TObject)
    private
      FCFOP: String;
      FCFPS: String;
      FCNPJ: String;
      FIBGE: String;
      FTotalContabil: Double;
      FTotalRetidoISS: Double;
    public
      property strCfop: String read FCFOP write FCFOP;
      property strCfps: String read FCFPS write FCFPS;
      property strCPNJ: String read FCNPJ write FCNPJ;
      property strIBGE: String read FIBGE write FIBGE;
      property fltTotalContabil: Double read FTotalContabil write FTotalContabil;
      property fltTotalRetidoISS: Double read FTotalRetidoISS write FTotalRetidoISS;
  end;

type
  TNotaFiscal = class(TObject)
    private
      FSerie: String;
      FTipFc: String;
      FModelo: string;
      FNumero: String;
      FEspecie: String;
      FEmpresa: String;
      FEstado: String;
      FHistorico: String;
      FOrigemDocumento: string; //famoso ORIDOC
      FSituacaoDocumento: String;
      FUFParticipante: String;
      FCepParticipante: String;
      FCnpjParticipante: String;
      FNomeParticipante: String;
      FBairroParticipante: String;
      FEnderecoParticipante: String;
      FTelefoneParticipante: String;
      FMunicipioParticipante: String;
      FUFEmpresaEmitente: String;
      FCfop1: String;
      FCfop2: String;
      FCfop3: String;
      FCfop4: String;
      FCfop5: String;
      FCondicaoPagamento: String;
      FChaveAcesso: String;
      FNumeroSerie: String;
      FCodEcf: String;
      FNumUsu: String;
      FNumCoo: String;
      FNumCooRdz: String;
      FTipoFrete: string;
      FValCon1: Double;
      FValCon2: Double;
      FValCon3: Double;
      FValCon4: Double;
      FValCon5: Double;
      FVlrIcm1: Double;
      FVlrIcm2: Double;
      FVlrIcm3: Double;
      FVlrIcm4: Double;
      FVlrIcm5: Double;
      FBasIss: Double;
      FAlqIss: Double;
      FValIss: Double;
      FRetIss: Double;
      FBasPis: Double;
      FAlqPis: Double;
      FValPis: Double;
      FBasCof: Double;
      FAlqCof: Double;
      FValCof: Double;
      FFrete: Double;
      FOutras: Double;
      FDesconto: Double;
      FValorContabil: Double;
      FDtaDoc: TDateTime;
      FDtaEnt: TDateTime;
      FItensNota: TObjectList<TItemNotaFiscal>;
      FNotaFiscalDetalhada: TObjectList<TNotaFiscalDetalhada>;
      FDadosGNRE: TGNRE;
      FEcf: TEcf;
      FObservacao: TObservacao;
      FFormaPagamento: TFormaPagamento;
      FParticipante: TParticipante;
      FTransportadora: TTransportadora;
      FNumeroCro: String;
      FNumeroCrz: String;
      FIndicadorEmitente: String;
      FNotaComplementar: boolean;
      FIndicadorOperacao: string;
      FCodigoServico: string;

      FNumDocDapi: string;
      FCfopDapi: string;
      FValorContabilDapi: Double;
      FBaseIcmsDapi: Double;
      FAliquotaIcmsDapi: Double;
      FValorIcmsDapi: Double;
      FValorOutrasDapi: Double;
      FValorIsentasDapi: Double;
      FBaseIcmsSTDapi: Double;
      FValorIcmsSTDapi: Double;
      FBaseIpiDapi: Double;
      FValorIpiDapi: Double;

    public
      procedure pAdicionarItem(Item: TItemNotaFiscal);
      procedure pAdicionarDetalhamento(NotaFiscalDetalhada: TNotaFiscalDetalhada);

      //função que retorna o valor de FValCon1 + FValCon2 + FValCon3 + FValCon4 + FValCon5
      function fRetTotalContabil: double;

      function fRetTotalIpiNaoCreditado: Double;
      function fRetValorTotalIsentas: Double;
      function fRetBaseTotalIcms: Double;
      function fRetValorTotalIcms: Double;
      function fRetValorTotalOutras: Double;
      function fRetValorTotalOutrasReceitas: Double;
      function fRetBaseTotalIcmsST: Double;
      function fRetValorTotalIcmsST: Double;
      function fRetBaseTotalIPI: Double;
      function fRetValorTotalIPI: Double;
      function fRetValorTotalDespesasAcessorias: Double;
      function fRetValorTotalProdutos(Nota: TNotaFiscal): double;
      function fRetValorTotalProdutosSemDesconto(Nota: TNotaFiscal): Double;

      function fRetValorTotalIcmsDIEF(strCfop: string): Double;
      function fretvalorContabil(strCfop: string): Double;
      function fretvalorContabilDIEF(strCfop: string): Double;

      function fRetValorTotalOutrasDapi(strCfop: string): Double;
      function fRetValorTotalOutrasDIEF(strCfop: string): Double;
      function fRetValorTotalIcmsSTDapi(strCfop: string): Double;
      function fRetValorTotalIsentasDapi(strCfop: string): Double;
      function fRetValorTotalIcmsDapi(strCfop: string): Double;
      function fRetBaseTotalIcmsDapi(strCfop: string): Double;
      function fRetBaseTotalIcmsDIEF(strCfop: string): Double;
      function fRetValorTotalProdutosDapi(Nota: TNotaFiscal; strCfop: string): double;

      function fRetValorTotalIcmsTransfEstabelecimentoProprio: Double;
      function fRetValorTotalIcmsTransfOutrosEstabelecimentos: Double;

      property strSerie: String read FSerie write FSerie;
      property strTipFc: String read FTipFc write FTipFc;
      property strModelo: string read FModelo write FModelo;
      property strNumero: String read FNumero write FNumero;
      property strEspecie: String read FEspecie write FEspecie;
      property strEmpresa: String read FEmpresa write FEmpresa;
      property strEstado: String read FEstado write FEstado;
      property strHistorico: String read FHistorico write FHistorico;
      property strOrigemDocumento: string read FOrigemDocumento write FOrigemDocumento;
      property strSituacaoDocumento: String read FSituacaoDocumento write FSituacaoDocumento;
      property strUFParticipante: String read FUFParticipante write FUFParticipante;
      property strCepParticipante: String read FCepParticipante write FCepParticipante;
      property strCnpjParticipante: String read FCnpjParticipante write FCnpjParticipante;
      property strNomeParticipante: String read FNomeParticipante write FNomeParticipante;
      property strBairroParticipante: String read FBairroParticipante write FBairroParticipante;
      property strEnderecoParticipante: String read FEnderecoParticipante write FEnderecoParticipante;
      property strTelefoneParticipante: String read FTelefoneParticipante write FTelefoneParticipante;
      property strMunicipioParticipante: String read FMunicipioParticipante  write FMunicipioParticipante;
      property strUFEmpresaEmitente: String read FUFEmpresaEmitente write FUFEmpresaEmitente;
      property strCfop1: String read FCfop1 write FCfop1;
      property strCfop2: String read FCfop2 write FCfop2;
      property strCfop3: String read FCfop3 write FCfop3;
      property strCfop4: String read FCfop4 write FCfop4;
      property strCfop5: String read FCfop5 write FCfop5;
      property strCondicaoPagamento: String read FCondicaoPagamento write FCondicaoPagamento;
      property strChaveAcesso: String read FChaveAcesso write FChaveAcesso;
      property strNumeroSerie: String read FNumeroSerie write FNumeroSerie;
      property strCodEcf: String read FCodEcf write FCodEcf;
      property strNumUsu: String read FNumUsu write FNumUsu;
      property strNumCoo: String read FNumCoo write FNumCoo;
      property strNumCooRdz: String read FNumCooRdz write FNumCooRdz;
      property strTipoFrete: string read FTipoFrete write FTipoFrete;
      property fltValCon1: Double read FValCon1 write FValCon1;
      property fltValCon2: Double read FValCon2 write FValCon2;
      property fltValCon3: Double read FValCon3 write FValCon3;
      property fltValCon4: Double read FValCon4 write FValCon4;
      property fltValCon5: Double read FValCon5 write FValCon5;
      property fltVlrIcm1: Double read FVlrIcm1 write FVlrIcm1;
      property fltVlrIcm2: Double read FVlrIcm2 write FVlrIcm2;
      property fltVlrIcm3: Double read FVlrIcm3 write FVlrIcm3;
      property fltVlrIcm4: Double read FVlrIcm4 write FVlrIcm4;
      property fltVlrIcm5: Double read FVlrIcm5 write FVlrIcm5;
      property fltBasIss: Double read FBasIss write FBasIss;
      property fltAlqIss: Double read FAlqIss write FAlqIss;
      property fltValIss: Double read FValIss write FValIss;
      property fltRetIss: Double read FRetIss write FRetIss;
      property fltBasPis: Double read FBasPis write FBasPis;
      property fltAlqPis: Double read FAlqPis write FAlqPis;
      property fltValPis: Double read FValPis write FValPis;
      property fltBasCof: Double read FBasCof write FBasCof;
      property fltAlqCof: Double read FAlqCof write FAlqCof;
      property fltValCof: Double read FValCof write FValCof;
      property fltFrete: Double read FFrete write FFrete;
      property fltOutras: Double read FOutras write FOutras;
      property fltDesconto: Double read FDesconto write FDesconto;
      property fltValorContabil: Double read FValorContabil write FValorContabil;
      property dtaDtaDoc: TDateTime read FDtaDoc write FDtaDoc;
      property dtaDtaEnt: TDateTime read FDtaEnt write FDtaEnt;
      property itensNota: TObjectList<TItemNotaFiscal> read FItensNota;
      property notaFiscalDetalhada: TObjectList<TNotaFiscalDetalhada> read FNotaFiscalDetalhada;
      property dadosGNRE: TGNRE read FDadosGNRE write FDadosGNRE;
      property observacao: TObservacao read FObservacao write FObservacao;
      property ecf: TEcf read FEcf write FEcf;
      property formaPagamento: TFormaPagamento read FFormaPagamento write FFormaPagamento;
      property participante: TParticipante read FParticipante write FParticipante;
      property transportadora: TTransportadora read FTransportadora write FTransportadora;
      property strNumeroCro: String read FNumeroCro write FNumeroCro;
      property strNumeroCrz: String read FNumeroCrz write FNumeroCrz;
      property strIndicadorEmitente: String read FIndicadorEmitente write FIndicadorEmitente;
      property blnNotaComplementar: boolean read FNotaComplementar write FNotaComplementar;
      property strIndicadorOperacao: string read FIndicadorOperacao write FIndicadorOperacao;
      property strCodigoServico: string read FCodigoServico write FCodigoServico;

      property strNumDocDapi: string read FNumDocDapi write FNumDocDapi;
      property strCfopDapi: string read FCfopDapi write FCfopDapi;
      property fltValorContabilDapi: Double read FValorContabilDapi write FValorContabilDapi;
      property fltBaseIcmsDapi: Double read FBaseIcmsDapi write FBaseIcmsDapi;
      property fltAliquotaIcmsDapi: Double read FAliquotaIcmsDapi write FAliquotaIcmsDapi;
      property fltValorIcmsDapi: Double read FValorIcmsDapi write FValorIcmsDapi;
      property fltValorOutrasDapi: Double read FValorOutrasDapi write FValorOutrasDapi;
      property fltValorIsentasDapi: Double read FValorIsentasDapi write FValorIsentasDapi;
      property fltBaseIcmsSTDapi: Double read FBaseIcmsSTDapi write FBaseIcmsSTDapi;
      property fltValorIcmsSTDapi: Double read FValorIcmsSTDapi write FValorIcmsSTDapi;
      property fltBaseIpiDapi: Double read FBaseIpiDapi write FBaseIpiDapi;
      property fltValorIpiDapi: Double read FValorIpiDapi write FValorIpiDapi;

      constructor Create; virtual;
      destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples;

{ TNotaFiscal }

constructor TNotaFiscal.Create;
begin
  inherited Create;

  FItensNota := TObjectList<TItemNotaFiscal>.Create;
  FNotaFiscalDetalhada := TObjectList<TNotaFiscalDetalhada>.Create;
  FDadosGNRE := TGNRE.Create;
  FEcf := TEcf.Create;
  FObservacao := TObservacao.Create;
  FFormaPagamento := TFormaPagamento.Create;
  FParticipante := TParticipante.Create;
  FTransportadora := TTransportadora.Create;
end;

destructor TNotaFiscal.destroy;
begin
  FItensNota.Free;
  FNotaFiscalDetalhada.Free;
  FFormaPagamento.Free;
  FParticipante.Free;
  FDadosGNRE.Free;
  FEcf.Free;
  FObservacao.Free;
  FTransportadora.Free;

  inherited destroy;
end;

function TNotaFiscal.fRetBaseTotalIcms: Double;
  var
    notaFiscalDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    fltValor := fltValor + itemNota.fltBasIcm;
  End;

  if fltValor <= 0 then
  begin
    for notaFiscalDetalhada in FNotaFiscalDetalhada do
    begin
      fltValor := fltValor + notaFiscalDetalhada.fltBaseIcms;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetBaseTotalIcmsDapi(strCfop: string): Double;
  var
    notaFiscalDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltBasIcm;
  End;

  if fltValor <= 0 then
  begin
    for notaFiscalDetalhada in FNotaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaFiscalDetalhada.strNumDoc))) and ((notaFiscalDetalhada.strCfop) = (strCfop)) then
        fltValor := fltValor + notaFiscalDetalhada.fltBaseIcms;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetBaseTotalIcmsDIEF(strCfop: string): Double;
  var
    notaFiscalDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin

  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltBasIcm;
  End;

  if fltValor <= 0 then
  begin
    if Pos(self.FCfop1,'2353_1253_1933_2933') > 0 then
    Begin
      for notaFiscalDetalhada in FNotaFiscalDetalhada do
      begin
        fltValor := fltValor + notaFiscalDetalhada.fltBaseIcms;
      end;
    End
    Else
    Begin
      for notaFiscalDetalhada in FNotaFiscalDetalhada do
      begin
        if (not(fEmptyStr(notaFiscalDetalhada.strNumDoc))) and ((notaFiscalDetalhada.strCfop) = (strCfop)) then
          fltValor := fltValor + notaFiscalDetalhada.fltBaseIcms;
      end;
    End;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetBaseTotalIcmsST: Double;
  var
    item: TItemNotaFiscal;
begin
  Result := 0;

  for item in FItensNota do
  begin
    Result := Result + item.fltBasRet;
  end;
end;

function TNotaFiscal.fRetBaseTotalIPI: Double;
  var
    item: TItemNotaFiscal;
begin
  Result := 0;

  for item in FItensNota do
  begin
    Result := Result + item.fltBasIpi;
  end;
end;

function TNotaFiscal.fRetTotalContabil: double;
begin
  Result := FValCon1 + FValCon2 + FValCon3 + FValCon4 + FValCon5;
end;

function TNotaFiscal.fRetTotalIpiNaoCreditado: Double;
  var
    item: TItemNotaFiscal;
begin
  Result := 0;

  for item in FItensNota do
  begin
    Result := Result + item.fltValorIpiNaoCreditado;
  end;
end;

function TNotaFiscal.fretvalorContabil(strCfop: string): Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
    begin
      if (itemNota.strCfop) = (strCfop) then
        fltValor := fltValor + itemNota.fltValorContabil;
    end;
  end
  else
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
        fltValor := fltValor + notaDetalhada.fltValorContabil;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fretvalorContabilDIEF(strCfop: string): Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
    begin
      if (itemNota.strCfop) = (strCfop) then
        fltValor := fltValor + itemNota.fltValorContabil;
    end;
  end
  else
  begin
    if Pos(self.FCfop1,'2353_1253_1933_2933') > 0 then
      fltValor := self.FValorContabil
    Else
    Begin
      for notaDetalhada in notaFiscalDetalhada do
      begin
        if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
          fltValor := fltValor + notaDetalhada.fltValorContabil;
      end;
    End;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalDespesasAcessorias: Double;
  var
    item: TItemNotaFiscal;
begin
  Result := 0;

  for item in FItensNota do
  begin
    Result := Result + item.fltDesAce;
  end;
end;

function TNotaFiscal.fRetValorTotalIcms: Double;
  Var
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    fltValor := fltValor + itemNota.fltValIcm;
  End;

  if fltValor <= 0 then
    fltValor := FVlrIcm1 + FVlrIcm2 + FVlrIcm3 + FVlrIcm4 + FVlrIcm5;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsDapi(strCfop: string): Double;
  Var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
    blnTemItem: Boolean;
begin
  //# DAPI 07022020 0956
  fltValor := 0;
  blnTemItem := false;
  for itemNota in FItensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltValIcm;
    blnTemItem := True;
  End;

  if not (blnTemItem) Then
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      fltValor := fltValor + notaDetalhada.FValorIcms;
      blnTemItem := true;
    end;
  end;

  if (fltValor <= 0) and (not blnTemItem) then
    fltValor := FVlrIcm1 + FVlrIcm2 + FVlrIcm3 + FVlrIcm4 + FVlrIcm5;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsDIEF(strCfop: string): Double;
  Var
    itemNota: TItemNotaFiscal;
    fltValor: Double;
    blnTemItem: Boolean;
begin
  fltValor := 0;
  blnTemItem := false;

  for itemNota in FItensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltValIcm;
    blnTemItem := True;
  End;

  if (fltValor <= 0) and (not blnTemItem) then
    fltValor := self.FVlrIcm1 + self.FVlrIcm2 + self.FVlrIcm3 + self.FVlrIcm4 + self.FVlrIcm5;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsST: Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
      fltValor := fltValor + itemNota.fltValRet + itemNota.fltValorRetidoNaoCreditado;
  end
  else
  begin
    for notaDetalhada in notaFiscalDetalhada do
      fltValor := fltValor + notaDetalhada.FValorIcmsST;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsSTDapi(strCfop: string): Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
    begin
      if (itemNota.strCfop) = (strCfop) then
        fltValor := fltValor + itemNota.fltValRet + itemNota.fltValorRetidoNaoCreditado;
    end;
  end
  else
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
      fltValor := fltValor + notaDetalhada.FValorIcmsST;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsTransfEstabelecimentoProprio: Double;
  var
    fltValor: Double;
    itemNota: TItemNotaFiscal;
begin
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota do
    begin
      if pos(itemNota.strCfop, '5209_6209') > 0 then
        fltValor := fltValor + itemNota.fltValIcm;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIcmsTransfOutrosEstabelecimentos: Double;
  var
    fltValor: Double;
    itemNota: TItemNotaFiscal;
begin
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota do
    begin
      if pos(itemNota.strCfop, '5409_6409') > 0 then
        fltValor := fltValor + itemNota.fltValIcm;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIPI: Double;
  var
    item: TItemNotaFiscal;
begin
  Result := 0;

  for item in FItensNota do
  begin
    Result := Result + item.fltValorIpi;
  end;
end;

function TNotaFiscal.fRetValorTotalIsentas: Double;
  Var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    fltValor := fltValor + itemNota.fltIsentas;
  End;

  if fltValor <= 0 then
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      fltValor := fltValor + notaDetalhada.fltValorIsentas;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalIsentasDapi(strCfop: string): Double;
  Var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  for itemNota in FItensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltIsentas;
  End;

  if fltValor <= 0 then
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
        fltValor := fltValor + notaDetalhada.fltValorIsentas;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalOutras: Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
      fltValor := fltValor + itemNota.fltOutIcm + itemNota.fltValorIpi + itemNota.fltValorIpiNaoCreditado;
  end
  else
  begin
    for notaDetalhada in notaFiscalDetalhada do
      fltValor := fltValor + notaDetalhada.fltValorOutras;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalOutrasDapi(strCfop: string): Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
    begin
      if (itemNota.strCfop) = (strCfop) then
        fltValor := fltValor + itemNota.fltOutIcm + itemNota.fltValorIpi + itemNota.fltValorIpiNaoCreditado;
    end;
  end
  else
  begin
    for notaDetalhada in notaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
        fltValor := fltValor + notaDetalhada.fltValorOutras;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalOutrasDIEF(strCfop: string): Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  if FItensNota.Count > 0 then
  begin
    for itemNota in FItensNota Do
    begin
      if (itemNota.strCfop) = (strCfop) then
        fltValor := fltValor + itemNota.fltOutIcm + itemNota.fltValorIpi + itemNota.fltValorIpiNaoCreditado;
    end;
  end
  else
  begin
    if Pos(self.FCfop1,'2353_1253_1933_2933') > 0 then
      fltValor := self.FOutras
    Else
    Begin
      for notaDetalhada in notaFiscalDetalhada do
      begin
        if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
          fltValor := fltValor + notaDetalhada.fltValorOutras;
      end;
    End;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalOutrasReceitas: Double;
  var
    notaDetalhada: TNotaFiscalDetalhada;
    fltValor: Double;
begin
  fltValor := 0;

  for notaDetalhada in notaFiscalDetalhada do
    fltValor := fltValor + notaDetalhada.fltValorOutras;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalProdutos(Nota: TNotaFiscal): double;
  Var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  for itemNota in Nota.itensNota Do
  Begin
    fltValor := fltValor + itemNota.fltValorContabil;
  End;

  if fltValor <= 0 then
  begin
    for notaDetalhada in Nota.notaFiscalDetalhada do
      fltValor := fltValor + notaDetalhada.fltValorContabil;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalProdutosDapi(Nota: TNotaFiscal; strCfop: string): double;
  Var
    notaDetalhada: TNotaFiscalDetalhada;
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  //# DAPI 07022020 0956
  fltValor := 0;

  for itemNota in Nota.itensNota Do
  Begin
    if (itemNota.strCfop) = (strCfop) then
      fltValor := fltValor + itemNota.fltValorContabil;
  End;

  if fltValor <= 0 then
  begin
    for notaDetalhada in FNotaFiscalDetalhada do
    begin
      if (not(fEmptyStr(notaDetalhada.strNumDoc))) and ((notaDetalhada.strCfop) = (strCfop)) then
        fltValor := fltValor + notaDetalhada.fltValorContabil;
    end;
  end;

  Result := fltValor;
end;

function TNotaFiscal.fRetValorTotalProdutosSemDesconto(Nota: TNotaFiscal): Double;
  Var
    itemNota: TItemNotaFiscal;
    fltValor: Double;
begin
  fltValor := 0;

  for itemNota in Nota.itensNota Do
  Begin
    fltValor := fltValor + itemNota.fltValorContabil + itemNota.fltDesconto;
  End;

  Result := fltValor;
end;

procedure TNotaFiscal.pAdicionarDetalhamento(NotaFiscalDetalhada: TNotaFiscalDetalhada);
begin
  FNotaFiscalDetalhada.Add(NotaFiscalDetalhada);
end;

procedure TNotaFiscal.pAdicionarItem(Item: TItemNotaFiscal);
begin
  FItensNota.Add(Item);
end;

end.

