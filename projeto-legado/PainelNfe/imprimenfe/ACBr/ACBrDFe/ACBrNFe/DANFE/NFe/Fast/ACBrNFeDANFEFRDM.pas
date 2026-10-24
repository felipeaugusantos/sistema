unit ACBrNFeDANFEFRDM;

interface

uses
  {$IFDEF VER300}
  System.UITypes,
  {$ENDIF}
  {$IF Defined(LINUX)}
  FMX.frxClass, FMX.frxDBSet, FMX.frxExportPDF, FMX.frxBarcode,
  FMX.frxDelphiZXingQRCode, FMX.Graphics, FMX.Objects,
  {$ELSE}
  frxClass, frxDBSet, frxExportPDF, frxBarcode,
  frxDelphiZXingQRCode, frxRich, Graphics, Dialogs,
  {$IFEND}
  SysUtils, Classes, ACBrNFeDANFEClass, untNFe, DB,
  DBClient, untConversao, ACBrUtil, untUniClientDataSet, untNfeDinamico;

type
  TACBrNFeFRClass = class
  private
    FDANFEClassOwner: TACBrNFeDANFEClass;
    FNFe: TNFe;
    FExibirTotalTributos: Boolean;
    FExibirTotalTributosItem: Boolean;
    FExibeCampoFatura: Boolean;
    FTributosFonte: string;
    FTributosPercentual: TPercentualTributos;
    FTributosPercentualPersonalizado: double;
    FMarcaDaguaMSG: string;
    FvTroco: Currency;
    FDetalhado: Boolean;
    FURLConsultaPublica:String;
    FDescricaoViaEstabelec: string;
    FImprimirUnQtVlComercial: TImprimirUnidQtdeValor;
    FExpandirDadosAdicionaisAuto: boolean;
    FImprimirDadosArma: Boolean;
    FExibirLocalEntrega: Boolean;
    FExibirLocalRetirada: Boolean;
    fQuebraLinhaEmDetalhamentoEspecifico : Boolean;
    fsQuebraLinha : String;
    FfrxReport: TfrxReport;
    FfrxPDFExport: TfrxPDFExport;
    FfrxBarCodeObject: TfrxBarCodeObject;
    cdsIdentificacao: TUniClientDataSet;
    FfrxIdentificacao: TfrxDBDataset;
    cdsEmitente: TUniClientDataSet;
    FfrxEmitente: TfrxDBDataset;
    cdsDestinatario: TUniClientDataSet;
    FfrxDestinatario: TfrxDBDataset;
    cdsDadosProdutos: TUniClientDataSet;
    FfrxDadosProdutos: TfrxDBDataset;
    cdsParametros: TUniClientDataSet;
    FfrxParametros: TfrxDBDataset;
    cdsDuplicatas: TUniClientDataSet;
    FfrxDuplicatas: TfrxDBDataset;
    cdsCalculoImposto: TUniClientDataSet;
    FfrxCalculoImposto: TfrxDBDataset;
    cdsTransportador: TUniClientDataSet;
    FfrxTransportador: TfrxDBDataset;
    cdsVeiculo: TUniClientDataSet;
    FfrxVeiculo: TfrxDBDataset;
    cdsVolumes: TUniClientDataSet;
    FfrxVolumes: TfrxDBDataset;
    cdsEventos: TUniClientDataSet;
    FfrxEventos: TfrxDBDataset;
    cdsISSQN: TUniClientDataSet;
    FfrxISSQN: TfrxDBDataset;
    cdsFatura: TUniClientDataSet;
    FfrxFatura: TfrxDBDataset;
    cdsLocalRetirada: TUniClientDataSet;
    FfrxLocalRetirada: TfrxDBDataset;
    cdsLocalEntrega: TUniClientDataSet;
    FfrxLocalEntrega: TfrxDBDataset;
    cdsInformacoesAdicionais: TUniClientDataSet;
    FfrxInformacoesAdicionais: TfrxDBDataset;
    cdsPagamento: TUniClientDataSet;
    FfrxPagamento: TfrxDBDataset;
    FIncorporarFontesPdf: Boolean;
    FIncorporarBackgroundPdf: Boolean;
    FfrxInutilizacao: TfrxDBDataset;
    cdsInutilizacao: TUniClientDataSet;
    FImprimirDadosDocReferenciados: Boolean;
    FDinEntrada: TNfeDinEntrada;
    FDin: TNfeDinamico;
    FDinValidando: Boolean;

    procedure frxReportBeforePrint(Sender: TfrxReportComponent);
    procedure CarregaIdentificacao;
    procedure CarregaEmitente;
    procedure CarregaDestinatario;
    procedure CarregaDadosProdutos;
    procedure CarregaParametros;
    procedure CarregaCalculoImposto;
    procedure CarregaTransportador;
    procedure CarregaVeiculo;
    procedure CarregaVolumes;
    procedure CarregaDuplicatas;
    procedure CarregaISSQN;
    procedure CarregaLocalRetirada;
    procedure CarregaLocalEntrega;
    procedure CarregaFatura;
    procedure CarregaPagamento;
    procedure CarregaInformacoesAdicionais;
  public
    function QuebraLinha: String;

    function CollateBr(Str: String): String;
    function ManterVprod(dVProd, dvDesc: Double): String;
    function ManterdvTotTrib(dvTotTrib: Double):  String;
    function ManterVDesc(dvDesc: Currency; dVUnCom , dQCom : double ) : Double;
    function ManterCst(dCRT: TCRT; dCSOSN: TCSOSNIcms;
      dCST: TCSTIcms): String;
    function ManterArma(inItem: integer): String;
    function ManterMedicamentos(inItem: integer): String;
    function ManterVeiculos( inItem : integer): String;
    function ManterValAprox( inItem : Integer ): String;
    function ManterInfAProd( inItem : Integer; sinfAdProd : String; GerarQuebraLinha : Boolean = True ) : String;
    function ManterDescricaoProduto(sXProd, sinfAdProd: String): String;
    function ManterVTrib(dVTotTrib: Double): Double;
    function ManterVTribPerc(dVTotTrib, dVProd, dVNF: Double): Double;
    function ManterCombustivel(inItem: integer): String;
    function FormatQuantidade(dValor: Double): String;
    function FormatValorUnitario(dValor: Double): String;
    function ManterContingencia(swObs: String): String;
    function ManterInfAdi(swObs: String): String;
    function ManterRastro(inItem: integer): String;
    function fLocalFaturaIgualLocalEntrega(cdsDestinatario, cdsLocalEntrega: TUniClientDataSet): Boolean;
    procedure pGeraItensParaTotalizacaoPorNCM;
    function ManterNro( strNro: String ): String;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    property NFe: TNFe read FNFe write FNFe;
    property DANFEClassOwner: TACBrNFeDANFEClass read FDANFEClassOwner;
    property ExibirTotalTributos: Boolean read FExibirTotalTributos write FExibirTotalTributos;
    property ExibirTotalTributosItem: Boolean read FExibirTotalTributosItem write FExibirTotalTributosItem default False;
    property ExibeCampoFatura: Boolean read FExibeCampoFatura write FExibeCampoFatura default True;
    property TributosFonte: string read FTributosFonte write FTributosFonte;
    property TributosPercentual: TPercentualTributos read FTributosPercentual write FTributosPercentual;
    property TributosPercentualPersonalizado: double read FTributosPercentualPersonalizado write FTributosPercentualPersonalizado;
    property MarcaDaguaMSG: string read FMarcaDaguaMSG write FMarcaDaguaMSG;
    property ImprimirUnQtVlComercial: TImprimirUnidQtdeValor read FImprimirUnQtVlComercial write FImprimirUnQtVlComercial;
    property ExpandirDadosAdicionaisAuto: boolean read FExpandirDadosAdicionaisAuto write FExpandirDadosAdicionaisAuto;
    property vTroco: Currency read FvTroco write FvTroco;
    property Detalhado: Boolean read FDetalhado write FDetalhado;
    property URLConsultaPublica:String read FURLConsultaPublica write FURLConsultaPublica;
    property DescricaoViaEstabelec: string read FDescricaoViaEstabelec write FDescricaoViaEstabelec;
    property frxReport: TfrxReport read FfrxReport write FfrxReport;
    property frxPDFExport: TfrxPDFExport read FfrxPDFExport write FfrxPDFExport;
    property ImprimirDadosArma: Boolean read FImprimirDadosArma write FImprimirDadosArma;
    property ExibirLocalEntrega: Boolean read FExibirLocalEntrega write FExibirLocalEntrega;
    property ExibirLocalRetirada: Boolean read FExibirLocalRetirada write FExibirLocalRetirada;
    property QuebraLinhaEmDetalhamentoEspecifico : Boolean  read fQuebraLinhaEmDetalhamentoEspecifico write fQuebraLinhaEmDetalhamentoEspecifico;
    property sQuebraLinha : String read fsQuebraLinha Write    fsQuebraLinha;
    property IncorporarBackgroundPdf: Boolean read FIncorporarBackgroundPdf write FIncorporarBackgroundPdf;
    property IncorporarFontesPdf: Boolean read FIncorporarFontesPdf write FIncorporarFontesPdf;
    property ImprimirDadosDocReferenciados: Boolean read FImprimirDadosDocReferenciados write FImprimirDadosDocReferenciados;
    property DinEntrada: TNfeDinEntrada read FDinEntrada write FDinEntrada;
    property DinValidando: Boolean read FDinValidando write FDinValidando;
    function fDataSetDinamico(const ANome: String): TDataSet;
    function fImagemParametros: String;
    function fDataSetNativo(const AUserName: String): TDataSet;

    procedure SetDataSetsToFrxReport;
    procedure CarregaDadosNFe;

  end;


implementation

uses ACBrNFe, ACBrDFeUtil, StrUtils, Math, DateUtils, untConversaoNFe,
  ACBrValidador, untConexaoBD, untImagemBase64, untUtil;

{ TACBrNFeFRClass }

function TACBrNFeFRClass.fDataSetDinamico(const ANome: String): TDataSet;
begin
  Result := nil;
  if Assigned(FDin) then
    Result := FDin.fDataSet(ANome);
end;

function TACBrNFeFRClass.fDataSetNativo(const AUserName: String): TDataSet;
var
  arrFrx: array[0..17] of TfrxDBDataset;
  i: Integer;
begin
  Result := nil;
  arrFrx[0]  := FfrxIdentificacao;
  arrFrx[1]  := FfrxEmitente;
  arrFrx[2]  := FfrxDestinatario;
  arrFrx[3]  := FfrxDadosProdutos;
  arrFrx[4]  := FfrxParametros;
  arrFrx[5]  := FfrxDuplicatas;
  arrFrx[6]  := FfrxCalculoImposto;
  arrFrx[7]  := FfrxTransportador;
  arrFrx[8]  := FfrxVeiculo;
  arrFrx[9]  := FfrxVolumes;
  arrFrx[10] := FfrxEventos;
  arrFrx[11] := FfrxISSQN;
  arrFrx[12] := FfrxFatura;
  arrFrx[13] := FfrxLocalRetirada;
  arrFrx[14] := FfrxLocalEntrega;
  arrFrx[15] := FfrxInformacoesAdicionais;
  arrFrx[16] := FfrxPagamento;
  arrFrx[17] := FfrxInutilizacao;
  for i := Low(arrFrx) to High(arrFrx) do
    if Assigned(arrFrx[i]) and SameText(arrFrx[i].UserName, AUserName) then
    begin
      Result := arrFrx[i].DataSet;
      Exit;
    end;
end;

function TACBrNFeFRClass.fImagemParametros: String;
var
  dsPar: TDataSet;
begin
  if Assigned(FDinEntrada) and Assigned(FDin) then
  begin
    Result := '';
    dsPar := FDin.fDataSet('Parametros');
    if (dsPar <> nil) and dsPar.Active and (dsPar.FindField('Imagem') <> nil) then
      Result := dsPar.FieldByName('Imagem').AsString;
  end
  else
    Result := cdsParametros.FieldByName('Imagem').AsString;
end;

procedure TACBrNFeFRClass.SetDataSetsToFrxReport;
begin
  if Assigned(FDinEntrada) then
  begin
    if not Assigned(FDin) then
      FDin := TNfeDinamico.Create(FDinEntrada, Self, FDANFEClassOwner);
    FDin.pCriarEstrutura(frxReport);
    Exit;
  end;

  frxReport.DataSets.Clear;
  frxReport.DataSets.Add(FfrxIdentificacao);
  frxReport.DataSets.Add(FfrxEmitente);
  frxReport.DataSets.Add(FfrxDestinatario);
  frxReport.DataSets.Add(FfrxDadosProdutos);
  frxReport.DataSets.Add(FfrxCalculoImposto);
  frxReport.DataSets.Add(FfrxTransportador);
  frxReport.DataSets.Add(FfrxVeiculo);
  frxReport.DataSets.Add(FfrxVolumes);
  frxReport.DataSets.Add(FfrxEventos);
  frxReport.DataSets.Add(FfrxISSQN);
  frxReport.DataSets.Add(FfrxFatura);
  frxReport.DataSets.Add(FfrxLocalRetirada);
  frxReport.DataSets.Add(FfrxLocalEntrega);
  frxReport.DataSets.Add(FfrxInformacoesAdicionais);
  frxReport.DataSets.Add(FfrxPagamento);
  frxReport.DataSets.Add(FfrxParametros);
  frxReport.DataSets.Add(FfrxDuplicatas);
  frxReport.DataSets.Add(FfrxInutilizacao);

  frxReport.EnabledDataSets.Clear;
  frxReport.EnabledDataSets.Add(FfrxIdentificacao);
  frxReport.EnabledDataSets.Add(FfrxEmitente);
  frxReport.EnabledDataSets.Add(FfrxDestinatario);
  frxReport.EnabledDataSets.Add(FfrxDadosProdutos);
  frxReport.EnabledDataSets.Add(FfrxCalculoImposto);
  frxReport.EnabledDataSets.Add(FfrxTransportador);
  frxReport.EnabledDataSets.Add(FfrxVeiculo);
  frxReport.EnabledDataSets.Add(FfrxVolumes);
  frxReport.EnabledDataSets.Add(FfrxEventos);
  frxReport.EnabledDataSets.Add(FfrxISSQN);
  frxReport.EnabledDataSets.Add(FfrxFatura);
  frxReport.EnabledDataSets.Add(FfrxLocalRetirada);
  frxReport.EnabledDataSets.Add(FfrxLocalEntrega);
  frxReport.EnabledDataSets.Add(FfrxInformacoesAdicionais);
  frxReport.EnabledDataSets.Add(FfrxPagamento);
  frxReport.EnabledDataSets.Add(FfrxParametros);
  frxReport.EnabledDataSets.Add(FfrxDuplicatas);
  frxReport.EnabledDataSets.Add(FfrxInutilizacao);
end;

function TACBrNFeFRClass.CollateBr(Str: String): String;
var
  Resultado,Temp: string;
  vChar: Char;
  Tamanho, i: integer;
begin
  Result := '';
  Tamanho := Length(str);
  i := 1;
  while i <= Tamanho do
  begin
    Temp := Copy(str,i,1);
    vChar := Temp[1];
    case vChar of
      'á', 'â', 'ã', 'à', 'ä', 'å', 'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': Resultado := 'A';
      'é', 'ê', 'è', 'ë', 'É', 'Ê', 'È', 'Ë': Resultado := 'E';
      'í', 'î', 'ì', 'ï', 'Í', 'Î', 'Ì', 'Ï': Resultado := 'I';
      'ó', 'ô', 'õ', 'ò', 'ö', 'Ó', 'Ô', 'Õ', 'Ò', 'Ö': Resultado := 'O';
      'ú', 'û', 'ù', 'ü', 'Ú', 'Û', 'Ù', 'Ü': Resultado := 'U';
      'ç', 'Ç': Resultado := 'C';
      'ñ', 'Ñ': Resultado := 'N';
      'ý', 'ÿ', 'Ý', 'Y': Resultado := 'Y';
    else
      if vChar > #127 then Resultado := #32
      else if CharInset(vChar, ['a'..'z','A'..'Z','0'..'9','-',' ',Chr(39)]) then
        Resultado := UpperCase(vCHAR);
    end;
    Result := Result + Resultado;
    i := i + 1;
  end;
end;

procedure TACBrNFeFRClass.CarregaCalculoImposto;
begin
  with cdsCalculoImposto do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    with FNFe.Total.ICMSTot do
    begin
      FieldByName('VBC').AsFloat          := VBC;
      FieldByName('VICMS').AsFloat        := VICMS;
      FieldByName('VBCST').AsFloat        := VBCST;
      FieldByName('VST').AsFloat          := VST;
      FieldByName('VProd').AsFloat        := VProd;
      FieldByName('VFrete').AsFloat       := VFrete;
      FieldByName('VSeg').AsFloat         := VSeg;
      FieldByName('VDesc').AsFloat        := VDesc;
      FieldByName('VII').AsFloat          := VII;
      FieldByName('VIPI').AsFloat         := VIPI;
      FieldByName('VPIS').AsFloat         := VPIS;
      FieldByName('VCOFINS').AsFloat      := VCOFINS;
      FieldByName('VOutro').AsFloat       := VOutro;
      FieldByName('VNF').AsFloat          := VNF;
      FieldByName('VTotTrib').AsFloat     := ManterVTrib( VTotTrib );
      FieldByName('ValorApagar').AsFloat  := VProd- VDesc + VOutro;
      FieldByName('VTribPerc').AsFloat    := ManterVTribPerc(ManterVTrib( VTotTrib ), VProd , VNF);
      if NaoEstaVazio(TributosFonte) then
        FieldByName('VTribFonte').AsString := '(Fonte: '+TributosFonte+')';
    end;
    if FNFe.pag.vTroco > 0 then
    begin
      FieldByName('vTroco').AsCurrency    := FNFe.pag.vTroco;
      FieldByName('vTotPago').AsCurrency  := FNFe.pag.vTroco+FieldByName('VProd').AsFloat;
    end
    else
    begin
      FieldByName('vTroco').AsCurrency    := FvTroco;
      FieldByName('vTotPago').AsCurrency  := FvTroco+FieldByName('VProd').AsFloat;
    end;

    FieldByName('VFCP').AsFloat         := FNFe.Total.ICMSTot.vFCP;
    FieldByName('VICMSUFRemet').AsFloat := FNFe.Total.ICMSTot.vICMSUFRemet;
    FieldByName('VICMSUFDest').AsFloat  := FNFe.Total.ICMSTot.vICMSUFDest;
    FieldByName('VTotTribII').AsFloat   := FNFe.Total.ICMSTot.vTotTrib;
    FieldByName('VICMSDeson').AsFloat   := FNFe.Total.ICMSTot.vICMSDeson;
    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaDadosNFe;
begin
  if Assigned(FDinEntrada) and Assigned(FDin) then
  begin
    if FDinValidando then
      frxReport.EngineOptions.SilentMode := True;
    FDin.pPreencher(FNFe);
    Exit;
  end;

  CarregaParametros;
  CarregaIdentificacao;
  CarregaEmitente;
  CarregaDestinatario;
  CarregaDadosProdutos;
  CarregaCalculoImposto;
  CarregaTransportador;
  CarregaVeiculo;
  CarregaVolumes;
  CarregaDuplicatas;
  CarregaISSQN;
  CarregaLocalRetirada;
  CarregaLocalEntrega;
  CarregaFatura;
  CarregaPagamento;
  CarregaInformacoesAdicionais;
end;

procedure TACBrNFeFRClass.CarregaDadosProdutos;
var
  inItem : Integer;
  fltQtdProduto: Double;
begin
  if not cdsParametros.Active then
    CarregaParametros;
  cdsParametros.First;

  // verificar se e DANFE detalhado
  // dados dos produtos
  with cdsDadosProdutos do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    If Pos(FDANFEClassOwner.UFAgrupaNCM, cdsDestinatario.FieldByName('UF').AsString) > 0 Then
      cdsDadosProdutos.IndexFieldNames := 'NCM';

    if (NFe.Ide.modelo <> 65) or FDetalhado then
    begin
      for inItem := 0 to NFe.Det.Count - 1 do
      begin
        Append;
        with FNFe.Det.Items[inItem] do
        begin
          FieldByName('ChaveNFe').AsString           := FNFe.infNFe.ID;
          FieldByName('cProd').AsString              := FDANFEClassOwner.ManterCodigo( Prod.cEAN,Prod.cProd);
          FieldByName('cEAN').AsString               := Prod.cEAN;
          FieldByName('XProd').AsString              := StringReplace( Prod.xProd, ';', #13, [rfReplaceAll]);
          FieldByName('VProd').AsString              := ManterVprod( Prod.VProd , Prod.vDesc );
          FieldByName('vTotTrib').AsString           := ManterdvTotTrib( Imposto.vTotTrib );
          FieldByName('infAdProd').AsString          := ManterInfAProd( inItem, infAdProd );
          FieldByName('infAdProdXml').AsString       := infAdProd;
          FieldByName('DescricaoProduto').AsString   := ManterDescricaoProduto( FieldByName('XProd').AsString , FieldByName('infAdProd').AsString );
          FieldByName('infAdProdSemQuebra').AsString := ManterInfAProd( inItem, infAdProd, False );
          FieldByName('NCM').AsString                := Prod.NCM;
          FieldByName('EXTIPI').AsString             := Prod.EXTIPI;
          FieldByName('genero').AsString             := '';
          FieldByName('CFOP').AsString               := Prod.CFOP;
          FieldByName('Ucom').AsString               := Prod.UCom;
          FieldByName('QCom').AsFloat                := Prod.QCom;
          FieldByName('VUnCom').AsFloat              := Prod.VUnCom;
          FieldByName('cEANTrib').AsString           := Prod.cEANTrib;
          FieldByName('UTrib').AsString              := Prod.uTrib;
          FieldByName('QTrib').AsFloat               := Prod.qTrib;
          FieldByName('VUnTrib').AsFloat             := Prod.vUnTrib;
          FieldByName('vFrete').AsString             := FormatFloatBr( Prod.vFrete ,'###,###,##0.00');
          FieldByName('vSeg').AsString               := FormatFloatBr( Prod.vSeg   ,'###,###,##0.00');
          FieldByName('vOutro').AsString             := FormatFloatBr( Prod.vOutro ,'###,###,##0.00');
          FieldByName('vDesc').AsString              := FormatFloatBr( ManterVDesc( Prod.vDesc , Prod.VUnCom , Prod.QCom),'###,###,##0.00');
          FieldByName('ORIGEM').AsString             := OrigToStr( Imposto.ICMS.orig);
          FieldByName('CST').AsString                := ManterCst( FNFe.Emit.CRT , Imposto.ICMS.CSOSN , Imposto.ICMS.CST );
          FieldByName('VBC').AsString                := FormatFloatBr( Imposto.ICMS.vBC        ,'###,###,##0.00');
          FieldByName('PICMS').AsString              := FormatFloatBr( Imposto.ICMS.pICMS      ,'###,###,##0.00');
          FieldByName('VICMS').AsString              := FormatFloatBr( Imposto.ICMS.vICMS      ,'###,###,##0.00');
          FieldByName('VBCST').AsString              := FormatFloatBr( Imposto.ICMS.vBcST      ,'###,###,##0.00');
          FieldByName('VICMSST').AsString            := FormatFloatBr( Imposto.ICMS.vICMSST    ,'###,###,##0.00');
          FieldByName('VIPI').AsString               := FormatFloatBr( Imposto.IPI.VIPI        ,'###,###,##0.00');
          FieldByName('PIPI').AsString               := FormatFloatBr( Imposto.IPI.PIPI        ,'###,###,##0.00');
          FieldByName('vISSQN').AsString             := FormatFloatBr( Imposto.ISSQN.vISSQN    ,'###,###,##0.00');
          FieldByName('vBcISSQN').AsString           := FormatFloatBr( Imposto.ISSQN.vBC       ,'###,###,##0.00');
          FieldByName('Valorliquido').AsString       := FormatFloatBr( Prod.vProd - Prod.vDesc ,'###,###,##0.00');
          FieldByName('ValorAcrescimos').AsString    := FormatFloatBr( Prod.vProd + Prod.vOutro,'###,###,##0.00');

          FieldByName('VSTLIQ').AsString             := FormatFloatBr( Imposto.ICMS.vICMSST + Imposto.ICMS.vFCPST ,'###,###,##0.00');

          fltQtdProduto := 1;
          case FImprimirUnQtVlComercial of
          iuComercial:
            begin
              FieldByName('Unidade').AsString        := FieldByName('Ucom').AsString;
              FieldByName('Quantidade').AsString     := FormatQuantidade( FieldByName('QCom').AsFloat );
              FieldByName('ValorUnitario').AsString  := FormatValorUnitario( FieldByName('VUnCom').AsFloat );
              fltQtdProduto := FieldByName('QCom').AsFloat;
            end;
          iuTributavel:
            begin
              FieldByName('Unidade').AsString        := FieldByName('UTrib').AsString;
              FieldByName('Quantidade').AsString     := FormatQuantidade( FieldByName('QTrib').AsFloat );
              FieldByName('ValorUnitario').AsString  := FormatValorUnitario( FieldByName('VUnTrib').AsFloat);
              fltQtdProduto := FieldByName('QTrib').AsFloat;
            end;
          iuComercialETributavel:
            begin
              if FieldByName('Ucom').AsString = FieldByName('UTrib').AsString then
              begin
                FieldByName('Unidade').AsString       := FieldByName('Ucom').AsString;
                FieldByName('Quantidade').AsString    := FormatQuantidade( FieldByName('QCom').AsFloat );
                FieldByName('ValorUnitario').AsString := FormatValorUnitario( FieldByName('VUnCom').AsFloat );
                fltQtdProduto := FieldByName('QCom').AsFloat;
              end
              else
              begin
                FieldByName('Unidade').AsString       := FDANFEClassOwner.ManterUnidades(FieldByName('Ucom').AsString, FieldByName('UTrib').AsString);
                FieldByName('Quantidade').AsString    := FDANFEClassOwner.ManterQuantidades(FieldByName('QCom').AsFloat, FieldByName('QTrib').AsFloat);
                FieldByName('ValorUnitario').AsString := FDANFEClassOwner.ManterValoresUnitarios(FieldByName('VUnCom').AsFloat, FieldByName('VUnTrib').AsFloat);
                fltQtdProduto := FieldByName('QCom').AsFloat;
                if FieldByName('QTrib').AsFloat > 0 then
                  fltQtdProduto := FieldByName('QTrib').AsFloat;
              end;
            end;
          end;

          FieldByName('DeptoProd').asString := Prod.xDeptoProd;

          FieldByName('DescricaoProdutoSemQuebra').AsString := FieldByName('XProd').AsString +' '+FieldByName('infAdProdSemQuebra').AsString;
          FieldByName('QuantidadeEmbalagem').AsString := FormatFloatBr(Prod.nQuantidadeEmbalagem, '(#####)');
          FieldByName('ValorContabil').AsString       := FormatFloatBr( (( Prod.VProd - Prod.vDesc ) + ( Imposto.ICMS.vICMSST + Imposto.ICMS.vFCPST + Imposto.IPI.VIPI + Prod.vFrete + Prod.vSeg + Prod.vOutro )) / iif(fltQtdProduto=0,1,fltQtdProduto) , '###,###,##0.00');

          if Prod.vProd > 0 then
            FieldByName('DescPorc').asString := FormatFloatBr( (1 - ((Prod.vProd - Prod.vDesc) / Prod.VProd)) * 100 ,'###,###,##0.00');

          FieldByName('pRedBC').AsString  := FormatFloatBr( Imposto.ICMS.pRedBC  ,'###,###,##0.00');
          FieldByName('pMVAST').AsString  := FormatFloatBr( Imposto.ICMS.pMVAST  ,'###,###,##0.00');
          FieldByName('pICMSST').AsString := FormatFloatBr( Imposto.ICMS.pICMSST ,'###,###,##0.00');

          FieldByName('Comple').AsString     := Prod.Comple;
          FieldByName('QtdEtq').AsFloat      := Prod.QtdEtq;
          FieldByName('PorcDESESP').AsFloat  := Prod.PorcDESESP;
          FieldByName('Referencia').AsString := Prod.Referencia;
          FieldByName('PesBru').AsFloat      := Prod.PesoBruto;
          FieldByName('PesLiq').AsFloat      := Prod.PesoLiq;

          FieldByName('ValorProdutoComImpostos').AsString := FormatFloatBr( Prod.VProd +
                                                                            Imposto.IPI.VIPI +
                                                                            Imposto.ICMS.vICMSST +
                                                                            Imposto.ICMS.vFCPST ,'###,###,##0.00' );
          FieldByName('COD_NF').AsString     := Prod.COD_NF;
          FieldByName('vBCSTRet').AsString   := FormatFloatBr( Imposto.ICMS.vBCSTRet  , '###,###,##0.00');
          FieldByName('vICMSSTRet').AsString := FormatFloatBr( Imposto.ICMS.vICMSSTRet, '###,###,##0.00');
          FieldByName('LocAdi').AsString := Prod.LocAdi;

          Post;
        end;
      end;
    end;
  end;

  If Pos(FDANFEClassOwner.UFAgrupaNCM, cdsDestinatario.FieldByName('UF').AsString) > 0 Then
    pGeraItensParaTotalizacaoPorNCM;

end;

procedure TACBrNFeFRClass.CarregaDestinatario;
begin
  { destinatário }
  with cdsDestinatario do
  begin
    Close;
    CreateDataSet;
    Append;

    with FNFe.Dest do
    begin
      if NaoEstaVazio(idEstrangeiro) then
        FieldByName('CNPJCPF').AsString := idEstrangeiro
      else
        FieldByName('CNPJCPF').AsString := FormatarCNPJouCPF(CNPJCPF);

      FieldByName('IE').AsString        := IE;
      FieldByName('XNome').AsString     := XNome;
      with EnderDest do
      begin
        FieldByName('XLgr').AsString    := XLgr;
        FieldByName('Nro').AsString     := Nro;
        FieldByName('XCpl').AsString    := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString    := IntToStr(CMun);
        FieldByName('XMun').AsString    := CollateBr(XMun);
        FieldByName('UF').AsString      := UF;
        FieldByName('CEP').AsString     := FormatarCEP(CEP);
        FieldByName('CPais').AsString   := IntToStr(CPais);
        FieldByName('XPais').AsString   := XPais;
        FieldByName('Fone').AsString    := FormatarFone(Fone);
      end;

      FieldByName('Consumidor').AsString := '';

      if (cdsIdentificacao.FieldByName('Mod_').AsString = '65') then
      begin
        if NaoEstaVazio(idEstrangeiro) then
          FieldByName('Consumidor').AsString := 'ESTRANGEIRO: ' + Trim(FieldByName('CNPJCPF').AsString) + ' ' + trim(FieldByName('XNome').AsString)
        else
        begin
          if (FieldByName('CNPJCPF').AsString = '') then
            FieldByName('Consumidor').AsString := ACBrStr('CONSUMIDOR NÃO IDENTIFICADO')
          else
            FieldByName('Consumidor').AsString :=
              IfThen(Length(CNPJCPF) = 11, 'CPF: ', 'CNPJ: ') + Trim(FieldByName('CNPJCPF').AsString) + ' ' + trim(FieldByName('XNome').AsString);
        end;

        if Trim(FieldByName('XLgr').AsString) <> '' then
          FieldByName('Consumidor').AsString := FieldByName('Consumidor').AsString + #13 +
            Trim(FieldByName('XLgr').AsString) + ', ' + Trim(FieldByName('Nro').AsString);
        if Trim(FieldByName('XCpl').AsString) <> '' then
          FieldByName('Consumidor').AsString := FieldByName('Consumidor').AsString + #13 +
            Trim(FieldByName('XCpl').AsString);

        if Trim(FieldByName('XMun').AsString) <> '' then
          FieldByName('Consumidor').AsString := FieldByName('Consumidor').AsString + #13 +
            Trim(FieldByName('XBairro').AsString) + ' - ' +
            Trim(FieldByName('XMun').AsString) + '/' +
            Trim(FieldByName('UF').AsString);
      end;

      FieldByName('ComplementoEnd').AsString := FDANFEClassOwner.TomadorComplEnder;
      FieldByName('Celular').AsString        := FormatarFone(FDANFEClassOwner.TomadorCelular);
      FieldByName('Fone2').AsString          := FormatarFone(FDANFEClassOwner.TomadorFone2);
      FieldByName('NomeFantasia').AsString   := FDANFEClassOwner.TomadorNomFantasia;

      case indIEDest of
        inContribuinte: FieldByName('IndIEDest').AsString := '1-Contribuinte';
        inIsento: FieldByName('IndIEDest').AsString := '2-Isento';
        inNaoContribuinte: FieldByName('IndIEDest').AsString := '9-Não Contribuinte';
      end;

    end;
    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaDuplicatas;
var
  i: Integer;
begin
  cdsDuplicatas.Close;
  cdsDuplicatas.CreateDataSet;
  cdsDuplicatas.LogChanges := False;

  if Not ( FExibeCampoFatura and (FNFe.Ide.indPag = ipVista) and (FNFe.infNFe.Versao <= 3.10) ) then
  Begin
    if (FDANFEClassOwner.ExibirDuplicata) then
    begin
      If Pos(cdsDadosProdutos.FieldByName('CFOP').AsString , FDANFEClassOwner.CFOPTransf) = 0 Then
      Begin
        with cdsDuplicatas do
        begin
          if (NFe.Cobr.Dup.Count = 0) and (FDANFEClassOwner.ExibirDuplicata) then
          begin
            Append;
            FieldByName('ChaveNFe').AsString  := FNFe.infNFe.ID;
            FieldByName('NDup').AsString      := '';
            FieldByName('DVenc').AsString     := '';
            FieldByName('VDup').AsFloat       := 0;
            Post;
          end
          else
          begin
            for i := 0 to NFe.Cobr.Dup.Count - 1 do
            begin
              Append;
              with FNFe.Cobr.Dup[i] do
              begin
                FieldByName('ChaveNFe').AsString  := FNFe.infNFe.ID;
                FieldByName('NDup').AsString      := NDup;
                FieldByName('DVenc').AsString     := FormatDateBr(DVenc);
                FieldByName('VDup').AsFloat       := VDup;
              end;
              Post;
            end;
          end;
        end;
      End;
    end;
  End;
end;

procedure TACBrNFeFRClass.CarregaEmitente;
begin
  { emitente }
  with cdsEmitente do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    with FNFe.Emit do
    begin
      FieldByName('CNPJ').AsString  := FormatarCNPJ(CNPJCPF);
      FieldByName('XNome').AsString := DANFEClassOwner.ManterNomeImpresso( XNome , XFant );
      FieldByName('XFant').AsString := XFant;
      with EnderEmit do
      begin
        FieldByName('Xlgr').AsString    := XLgr;
        FieldByName('Nro').AsString     := Nro;
        FieldByName('XCpl').AsString    := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString    := IntToStr(CMun);
        FieldByName('XMun').AsString    := CollateBr(XMun);
        FieldByName('UF').AsString      := UF;
        FieldByName('CEP').AsString     := FormatarCEP(CEP);
        FieldByName('CPais').AsString   := IntToStr(CPais);
        FieldByName('XPais').AsString   := XPais;
        FieldByName('Fone').AsString    := FormatarFone(Fone);
        FieldByName('WhatsApp').AsString:= FormatarFone(FDANFEClassOwner.WhatsApp);
      end;
      FieldByName('IE').AsString        := IE;
      FieldByName('IM').AsString        := IM;
      FieldByName('IEST').AsString      := IEST;
      FieldByName('CRT').AsString       := CRTToStr(CRT);

      if Trim(FieldByName('CRT').AsString) = '1' then
        FieldByName('DESCR_CST').AsString := 'CSOSN'
      else
        FieldByName('DESCR_CST').AsString := 'CST';

      cdsEmitente.FieldByName('DADOS_ENDERECO').AsString    := Trim(FieldByName('XLgr').AsString) + ', ' +
                                                               Trim(FieldByName('Nro').AsString);
	    if (trim(FieldByName('XCpl').AsString) <> '') then
        cdsEmitente.FieldByName('DADOS_ENDERECO').AsString  := cdsEmitente.FieldByName('DADOS_ENDERECO').AsString + ', ' +
                                                               Trim(FieldByName('XCpl').AsString);

      cdsEmitente.FieldByName('DADOS_ENDERECO').AsString := cdsEmitente.FieldByName('DADOS_ENDERECO').AsString + #13 +                                           //Rua, Nro, Cpl
  										  	                                  Trim(FieldByName('XBairro').AsString) + #13 +                                                        //Bairro
                                                            Trim(FieldByName('XMun').AsString) + ' - ' + Trim(FieldByName('UF').AsString) + #13 +                //Cidade-UF
                                                            'CEP: ' + Trim(FieldByName('CEP').AsString) + #13 +                                                  //CEP
                                                            'Fone: ' + Trim(FieldByName('Fone').AsString) +                                                      //Telefone 1
                                                            IfThen(Trim(FDANFEClassOwner.Fone2) <> '', ' / ' + FormatarFone(FDANFEClassOwner.Fone2), '');        //Telefone 2

      cdsEmitente.FieldByName('Email').AsString    := Trim(FDANFEClassOwner.Email);
      cdsEmitente.FieldByName('Homepage').AsString := Trim(FDANFEClassOwner.Homepage);
      cdsEmitente.FieldByName('Fone2').AsString    := FormatarFone(FDANFEClassOwner.Fone2);
      cdsEmitente.FieldByName('RazSoc').AsString   := Trim(FDANFEClassOwner.RazSoc);
      cdsEmitente.FieldByName('PonImp').AsString   := Trim(FDANFEClassOwner.PonImp);
    end;

    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaFatura;
begin
  with cdsFatura do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    if ExibeCampoFatura then
    begin
      Append;

      FieldByName('iForma').asInteger := Integer( FNFe.Ide.indPag);

      if FNFe.infNFe.Versao >= 4 then
        FieldByName('Pagamento').AsString := ACBrStr('DADOS DA FATURA')
      else
      begin
        case FNFe.Ide.indPag of
          ipVista : FieldByName('Pagamento').AsString := ACBrStr('PAGAMENTO À VISTA');
          ipPrazo : FieldByName('Pagamento').AsString := ACBrStr('PAGAMENTO A PRAZO');
          ipOutras: FieldByName('Pagamento').AsString := ACBrStr('OUTROS');
        end;
      end;

      if NaoEstaVazio(FNFe.Cobr.Fat.nFat) then
      begin
        with FNFe.Cobr.Fat do
        begin
          FieldByName('nfat').AsString  := nFat;
          FieldByName('vOrig').AsFloat  := vOrig;
          FieldByName('vDesc').AsFloat  := vDesc;
          FieldByName('vLiq').AsFloat   := vLiq;
        end;
      end;

      if ((FNFe.infNFe.Versao >= 4) or (FNFe.Ide.indPag = ipOutras)) and EstaVazio(FNFe.Cobr.Fat.nFat) then
        Cancel
      else
        Post;

    end;
  end;
end;

procedure TACBrNFeFRClass.CarregaPagamento;
var
  i: Integer;
begin
  with cdsPagamento do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    for i := 0 to NFe.Pag.Count - 1 do
    begin
      Append;
      with FNFe.Pag[i] do
      begin
        FieldByName('tPag').AsString  := FormaPagamentoToDescricao( tPag );
        FieldByName('vPag').AsFloat   := vPag;
        // ver tpIntegra
        FieldByName('CNPJ').AsString  := FormatarCNPJ(CNPJ);
        FieldByName('tBand').AsString := BandeiraCartaoToDescStr( tBand );
        FieldByName('cAut').AsString  := cAut;
      end;
      Post;
    end;

    // acrescenta o troco
    if vTroco > 0 then
    begin
      Append;
      FieldByName('tPag').AsString  := 'Troco R$';
      FieldByName('vPag').AsFloat   := vTroco;
      Post;
    end;
  end;
end;

procedure TACBrNFeFRClass.CarregaIdentificacao;
begin
  with cdsIdentificacao do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    FieldByName('Id').AsString      := OnlyNumber(FNFe.infNFe.Id);
    FieldByName('Chave').AsString   := FormatarChaveAcesso(FNFe.infNFe.Id);
    FieldByName('CUF').AsString     := IntToStr(FNFe.Ide.CUF);
    FieldByName('CNF').AsString     := IntToStr(FNFe.Ide.CNF);
    FieldByName('NatOp').AsString   := FNFe.Ide.NatOp;
    FieldByName('IndPag').AsString  := IndpagToStr(FNFe.Ide.IndPag );
    FieldByName('Mod_').AsString    := IntToStr(FNFe.Ide.Modelo);
    FieldByName('Serie').AsString   := IntToStr(FNFe.Ide.Serie);
    FieldByName('NNF').AsString     := FormatFloat(',0', FNFe.Ide.NNF);
    FieldByName('DEmi').AsString    := FormatDateBr(FNFe.Ide.DEmi);
    FieldByName('HEmi').AsString    := FormatDateTimeBr(FNFe.Ide.DEmi, 'hh:mm');
    FieldByName('DSaiEnt').AsString := ifthen(FNFe.Ide.DSaiEnt <> 0, FormatDateBr(FNFe.Ide.DSaiEnt), IfThen(FDANFEClassOwner.Dtsai <> 0, FormatDateBr(FDANFEClassOwner.Dtsai)));
    FieldByName('TpNF').AsString    := tpNFToStr( FNFe.Ide.TpNF );
    FieldByName('CMunFG').AsString  := IntToStr(FNFe.Ide.CMunFG);
    FieldByName('TpImp').AsString   := TpImpToStr( FNFe.Ide.TpImp );
    FieldByName('TpEmis').AsString  := TpEmisToStr( FNFe.Ide.TpEmis );
    FieldByName('CDV').AsString     := IntToStr(FNFe.Ide.CDV);
    FieldByName('TpAmb').AsString   := TpAmbToStr( FNFe.Ide.TpAmb );
    FieldByName('FinNFe').AsString  := FinNFeToStr( FNFe.Ide.FinNFe );
    FieldByName('ProcEmi').AsString := procEmiToStr( FNFe.Ide.ProcEmi );
    FieldByName('VerProc').AsString := FNFe.Ide.VerProc;
    if FNFe.infNFe.versao = 2.00 then
      FieldByName('HoraSaida').AsString := ifthen(FNFe.ide.hSaiEnt = 0, ifthen(FDANFEClassOwner.Hrsai = 0, '', TimeToStr(FDANFEClassOwner.Hrsai)), TimeToStr(FNFe.ide.hSaiEnt))
    else
      FieldByName('HoraSaida').AsString := ifthen(TimeOf(FNFe.ide.dSaiEnt)=0, ifthen(FDANFEClassOwner.Hrsai = 0, '', TimeToStr(FDANFEClassOwner.Hrsai)), TimeToStr(FNFe.ide.dSaiEnt));

    if (FNFe.Ide.Modelo = 65) then
    begin
      FieldByName('DEmi').AsString := FormatDateTimeBr(FNFe.Ide.DEmi);
      if FNFe.Ide.TpAmb = taHomologacao then
          FieldByName('MensagemFiscal').AsString := ACBrStr('EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL')
      else
      begin
        if FNFe.Ide.tpEmis <> teNormal then
          FieldByName('MensagemFiscal').AsString := ACBrStr('EMITIDA EM CONTINGÊNCIA'+LineBreak+'Pendente de autorização')
        else
          FieldByName('MensagemFiscal').AsString := ACBrStr('ÁREA DE MENSAGEM FISCAL');
      end;

//      if EstaVazio(FNFe.infNFeSupl.urlChave) then
//        FieldByName('URL').AsString := TACBrNFe(DANFEClassOwner.ACBrNFe).GetURLConsultaNFCe(FNFe.Ide.cUF, FNFe.Ide.tpAmb, FNFe.infNFe.Versao)
//      else
        FieldByName('URL').AsString := FNFe.infNFeSupl.urlChave;
    end
    else
    begin
      FieldByName('MensagemFiscal').AsString := '';
      FieldByName('URL').AsString            := '';
    end;
    FieldByName('DadosCndFpg').AsString := FDANFEClassOwner.DadosCndFpg;
    FieldByName('NumeroPedidosFaturados').AsString := FDANFEClassOwner.NumeroPedidosFaturados;

    FieldByName('xMsg').AsString := FNFe.procNFe.xMsg;
    FieldByName('DtEntr').AsString := FDANFEClassOwner.DtEntr;
    FieldByName('EntregaRetira').AsString := FDANFEClassOwner.EntregaRetira;
    FieldByName('TranspCodTra').AsString := FDANFEClassOwner.TranspCodTra;
    FieldByName('TranspNomTra').AsString := FDANFEClassOwner.TranspNomTra;
    FieldByName('TranspEndere').AsString := FDANFEClassOwner.TranspEndere;
    FieldByName('TranspBairro').AsString := FDANFEClassOwner.TranspBairro;
    FieldByName('TranspCidade').AsString := FDANFEClassOwner.TranspCidade;
    FieldByName('TranspEstado').AsString := FDANFEClassOwner.TranspEstado;
    FieldByName('Romaneio').AsString := FDANFEClassOwner.Romaneio;
    FieldByName('CodBox').AsString := FDANFEClassOwner.CodBox;
    FieldByName('DesReg').AsString := FDANFEClassOwner.DesReg;

    if (FDANFEClassOwner.ExibirDataHoraSaida = 'N') then
    begin
      FieldByName('HoraSaida').AsString := '';
      FieldByName('DSaiEnt').AsString   := '';
    end;

    FieldByName('Vendedor').AsString := FDANFEClassOwner.Vendedor;
    FieldByName('NumRom').AsString := FDANFEClassOwner.NumRom;
    FieldByName('PlacaVeiculo').AsString := FDANFEClassOwner.PlacaVeiculo;
    FieldByName('KMVeiculo').AsString := FDANFEClassOwner.KMVeiculo;
    FieldByName('infAdicDanfeSimplificado').AsString := FDANFEClassOwner.InfAdicDanfeSimplificado;
    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaInformacoesAdicionais;
var
  vTemp         : TStringList;
  IndexCampo    : Integer;
  Campos        : TSplitResult;
  BufferInfCpl  : String;
  wObs          : string;
  wLinhasObs    : integer;
{$IF Defined(LINUX)}
  img           : FMX.Graphics.TBitmap;
{$ELSE}
  img           : TPicture;
{$IFEND}
  vStream       : TStream;
  iIndiceNfRef  : Integer;
  strNfRef      : String;
  nPos          : Integer;
begin
  wLinhasObs  := 0;
  BufferInfCpl:= '';
  vTemp       := TStringList.Create;
  try
    wObs  := FDANFEClassOwner.ManterDocreferenciados( FNFe,FImprimirDadosDocReferenciados , ';' );
    wObs  := ManterInfAdi( wObs );
    wObs  := ManterContingencia( wObs );
    if Trim(wObs) <> '' then
    begin
      Campos := Split(';', wObs);
      for IndexCampo := 0 to Length(Campos) - 1 do
        vTemp.Add(Campos[IndexCampo]);

      wLinhasObs    := 1; //TotalObS(vTemp.Text);
      BufferInfCpl  := vTemp.Text;
    end;
    with cdsInformacoesAdicionais do
    begin
      Close;
      CreateDataSet;
      LogChanges := False;
      Append;

      FieldByName('OBSSemQuebra').AsString := StringReplace( BufferInfCpl, #$D#$A, ' / ', [rfReplaceAll]);
      FieldByName('OBS').AsString          := StringReplace(BufferInfCpl, '\n', sLineBreak, [rfReplaceAll]);
      FieldByName('LinhasOBS').AsInteger   := wLinhasObs;

      nPos := Pos('Digitador:', StringReplace(BufferInfCpl, '\n', sLineBreak, [rfReplaceAll]));
      if nPos > 0 then
        FieldByName('OBSDanfeSimp').AsString := Copy( StringReplace(BufferInfCpl, '\n', sLineBreak, [rfReplaceAll]),
                                                      1,
                                                      nPos-1)
      else
        FieldByName('OBSDanfeSimp').AsString := '';

      for iIndiceNfRef := 0 to Pred(NFe.Ide.NFref.Count) do
        strNfRef:= strNfRef +'- NF-e referenciada:'+ NFe.Ide.NFref.Items[iIndiceNfRef].refNFe + ' ';

      FieldByName('NfRef').AsString := strNfRef;

      // Carregamento da qrCode
      if NaoEstaVazio(DANFEClassOwner.QrCodeDadosAdicionais) and
        (DANFEClassOwner.ImprimirQrCodeDadosAdicionais) then
      begin
      {$IF Defined(LINUX)}
      {$ELSE}
        img := TPicture.Create;
      {$IFEND}
        vStream := TMemoryStream.Create;
        try
        {$IF Defined(LINUX)}
          img := fGerarQRCode(DANFEClassOwner.QrCodeDadosAdicionais);
        {$ELSE}
          img.Bitmap := fGerarQRCode(DANFEClassOwner.QrCodeDadosAdicionais);
        {$IFEND}
          try
          {$IF Defined(LINUX)}
            img.SaveToStream(vStream);
          {$ELSE}
            img.Bitmap.SaveToStream(vStream);
          {$IFEND}
            vStream.Position := 0;
            TBlobField(cdsInformacoesAdicionais.FieldByName('QrCodeDadosAdicionaisCarregado')).LoadFromStream(vStream);

            If Assigned(TfrxPictureView(frxReport.FindObject('imgQrCodeDadosAdicionais'))) then
            begin
              TfrxPictureView(frxReport.FindObject('imgQrCodeDadosAdicionais')).Visible := True;
            {$IF Defined(LINUX)}
              TfrxPictureView(frxReport.FindObject('imgQrCodeDadosAdicionais')).Picture.Assign(img);
            {$ELSE}
              TfrxPictureView(frxReport.FindObject('imgQrCodeDadosAdicionais')).Picture.Bitmap := img.Bitmap;
            {$IFEND}
              TFrxMemoView(frxReport.FindObject('memObs')).Width := 380;
            end;
          Except
           On E: Exception do
          {$IF Defined(LINUX)}
            Writeln(e.Message);
          {$ELSE}
            ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
          {$IFEND}
          end;
        finally
          begin
            FreeAndNil(vStream);
            FreeAndNil(img);
          end;
        end;
      end;

      Post;
    end;
  finally
    vTemp.Free;
  end;
end;

procedure TACBrNFeFRClass.CarregaISSQN;
begin
  with cdsISSQN do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    with FNFe.Total.ISSQNtot do
    begin
      FieldByName('vSERV').AsFloat        := VServ;
      FieldByName('vBC').AsFloat          := VBC;
      FieldByName('vISS').AsFloat         := VISS;
      FieldByName('vDescIncond').AsFloat  := vDescIncond;
      FieldByName('vISSRet').AsFloat      := vISSRet;
    end;
    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaLocalEntrega;
begin
  { local de entrega }
  with cdsLocalEntrega do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    if Not fLocalFaturaIgualLocalEntrega(cdsDestinatario, cdsLocalEntrega)
       And (NaoEstaVazio(FNFe.Entrega.XLgr)) then
    begin
      Append;

      with FNFe.Entrega do
      begin
        FieldByName('CNPJ').AsString    := FormatarCNPJouCPF(CNPJCPF);
        FieldByName('Xlgr').AsString    := XLgr;
        FieldByName('Nro').AsString     := ManterNro(Nro);
        FieldByName('XCpl').AsString    := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString    := inttostr(CMun);
        FieldByName('XMun').AsString    := CollateBr(XMun);
        FieldByName('UF').AsString      := UF;
        FieldByName('ExibirLocalEntrega').AsBoolean := Not fLocalFaturaIgualLocalEntrega(cdsDestinatario, cdsLocalEntrega);
        FieldByName('CEP').AsString     := fFormataCEP(CEP);
        FieldByName('Fone').AsString    := fFormataFone(FDANFEClassOwner.TelEnt);
      end;
      Post;
    end;

  end;
end;

procedure TACBrNFeFRClass.CarregaLocalRetirada;
begin
  { local de retirada }
  with cdsLocalRetirada do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    if (FDANFEClassOwner.ExibirLocalRetira='NFE-RETIRA') And NaoEstaVazio(FNFe.Retirada.CNPJCPF) then
    begin
      Append;

      with FNFe.Retirada do
      begin
        FieldByName('CNPJ').AsString    := FormatarCNPJouCPF(CNPJCPF);
        FieldByName('Xlgr').AsString    := XLgr;
        FieldByName('Nro').AsString     := Nro;
        FieldByName('XCpl').AsString    := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString    := inttostr(CMun);
        FieldByName('XMun').AsString    := CollateBr(XMun);
        FieldByName('UF').AsString      := UF;
      end;
      Post;
    end;
  end;
end;

procedure TACBrNFeFRClass.CarregaParametros;
var
  vChave_Contingencia : String;
  vStream             : TStream;
  vStringStream       : TStringStream;
  P                   : Integer;
{$IF Defined(LINUX)}
  img                 : FMX.Graphics.TBitmap;
{$ELSE}
  img                 : TPicture;
{$IFEND}
begin
  { parâmetros }
  with cdsParametros do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    FieldByName('poscanhoto').AsString            := IntToStr( Ord(DANFEClassOwner.PosCanhoto));
    FieldByName('ResumoCanhoto').AsString         := '';
    FieldByName('Mensagem0').AsString             := '';
    FieldByName('Contingencia_ID').AsString       := '';
    FieldByName('ConsultaAutenticidade').AsString := 'Consulta de autenticidade no portal nacional da NF-e'+#13+
                                                     'www.nfe.fazenda.gov.br/portal ou no site da Sefaz autorizadora';

    if Assigned(FNFe) then
    begin
      if DANFEClassOwner.ExibirResumoCanhoto then
      begin
         if EstaVazio(DANFEClassOwner.ExibirResumoCanhoto_Texto) then
          FieldByName('ResumoCanhoto').AsString := ACBrStr('Emissão: ' )+ FormatDateBr(FNFe.Ide.DEmi) + '  Dest/Reme: ' + FNFe.Dest.XNome + '  Valor Total: ' + FormatFloatBr(FNFe.Total.ICMSTot.VNF)
        else
          FieldByName('ResumoCanhoto').AsString := DANFEClassOwner.ExibirResumoCanhoto_Texto;
      end;

      if (FNFe.Ide.TpAmb = taHomologacao) then
      begin
        if (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teSCAN, teDPEC, teSVCAN, teSVCRS, teSVCSP]) then
        begin
          if (FNFe.procNFe.cStat in [101,135, 151, 155]) then
            FieldByName('Mensagem0').AsString := ACBrStr('NFe sem Valor Fiscal - HOMOLOGAÇÃO ' +
                                                        #10#13+'NFe em Contingência - CANCELADA')
          else
            FieldByName('Mensagem0').AsString := ACBrStr('NFe sem Valor Fiscal - HOMOLOGAÇÃO'+
                                                        #10#13+'NFe em Contingência');
        end
        else
          FieldByName('Mensagem0').AsString :=ACBrStr( 'NFe sem Valor Fiscal - HOMOLOGAÇÃO')
      end
      else
      begin
        if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teSVCAN, teSVCRS, teSVCSP]) then
        begin
          //prioridade para opção NFeCancelada
          if (FDANFEClassOwner.NFeCancelada) or
             ((NaoEstaVazio(FNFe.procNFe.nProt)) and
              (FNFe.procNFe.cStat in [101,135,151,155])) then
            FieldByName('Mensagem0').AsString := 'NFe Cancelada'
          else if ( FNFe.procNFe.cStat = 110 ) or
                  ( FNFe.procNFe.cStat = 301 ) or
                  ( FNFe.procNFe.cStat = 302 ) or
                  ( FNFe.procNFe.cStat = 303 ) then
            FieldByName('Mensagem0').AsString := 'NFe denegada pelo Fisco'
          else if ((EstaVazio(FDANFEClassOwner.ProtocoloNFe)) and
                   (EstaVazio(FNFe.procNFe.nProt))) then
            FieldByName('Mensagem0').AsString := ACBrStr( 'NFe sem Autorização de Uso da SEFAZ')
          else if (FNFe.Ide.tpImp = tiSimplificado) then
            FieldByName('Mensagem0').AsString := ACBrStr( 'EMISSÃO NORMAL' );
        end;
      end;

      case FNFe.Ide.tpEmis of
        teNormal,
        teSVCAN,
        teSCAN,
        teSVCRS,
        teSVCSP :   begin
                      FieldByName('ChaveAcesso_Descricao').AsString := 'CHAVE DE ACESSO';
                      FieldByName('Contingencia_ID').AsString := '';

                      if ((FDANFEClassOwner.NFeCancelada) or (FNFe.procNFe.cStat in [101,151,155])) then
                        FieldByName('Contingencia_Descricao').AsString := ACBrStr('PROTOCOLO DE HOMOLOGAÇÃO DO CANCELAMENTO' )
                      else if ( FNFe.procNFe.cStat = 110 ) or
                              ( FNFe.procNFe.cStat = 301 ) or
                              ( FNFe.procNFe.cStat = 302 ) or
                              ( FNFe.procNFe.cStat = 303 ) then
                        FieldByName('Contingencia_Descricao').AsString := ACBrStr('PROTOCOLO DE DENEGAÇÃO DE USO')
                      else
                        FieldByName('Contingencia_Descricao').AsString := ACBrStr('PROTOCOLO DE AUTORIZAÇÃO DE USO');

                      if EstaVazio(FDANFEClassOwner.ProtocoloNFe) then
                      begin
                        if EstaVazio(FNFe.procNFe.nProt) then
                          FieldByName('Contingencia_Valor').AsString := ACBrStr('NFe sem Autorização de Uso da SEFAZ')
                        else
                        begin
                          FieldByName('Contingencia_Valor').AsString := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                          FieldByName('nProt').AsString := FNFe.procNfe.nProt;
                          FieldByName('dhRecbto').AsDateTime := FNFe.procNFe.dhRecbto;
                        end;
                      end
                      else
                      begin
                        FieldByName('Contingencia_Valor').AsString := FDANFEClassOwner.ProtocoloNFe;
                        P := Pos('-', FDANFEClassOwner.ProtocoloNFe);
                        if P = 0 then
                        begin
                          FieldByName('nProt').AsString := Trim(FDANFEClassOwner.ProtocoloNFe);
                          FieldByName('dhRecbto').AsDateTime := 0;
                        end
                        else
                        begin
                          FieldByName('nProt').AsString := Trim(Copy(FDANFEClassOwner.ProtocoloNFe, 1, P - 1));
                          FieldByName('dhRecbto').AsDateTime := StringToDateTimeDef(Trim(
                            Copy(FDANFEClassOwner.ProtocoloNFe, P + 1, Length(FDANFEClassOwner.ProtocoloNFe) - P)
                            ), 0, 'dd/mm/yyyy hh:nn:ss');
                        end;
                      end;
                    end;

        teContingencia ,
        teFSDA :    begin
                      vChave_Contingencia := TACBrNFe(DANFEClassOwner.ACBrNFe).GerarChaveContingencia(FNFe);
                      FieldByName('ChaveAcesso_Descricao').AsString  := 'CHAVE DE ACESSO';
                      FieldByName('Contingencia_ID').AsString        := vChave_Contingencia;
                      FieldByName('Contingencia_Descricao').AsString := 'DADOS DA NF-E';
                      FieldByName('Contingencia_Valor').AsString     := FormatarChaveAcesso(vChave_Contingencia);
                      FieldByName('ConsultaAutenticidade').AsString  := '';
                    end;

         teDPEC  :  begin
                      if NaoEstaVazio(FNFe.procNFe.nProt) then // DPEC TRANSMITIDO
                      begin
                        FieldByName('Contingencia_Descricao').AsString := ACBrStr( 'PROTOCOLO DE AUTORIZAÇÃO DE USO');
                        FieldByName('Contingencia_Valor').AsString     := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                      end
                      else
                      begin
                        FieldByName('Contingencia_Descricao').AsString := ACBrStr('NÚMERO DE REGISTRO DPEC');
                        if NaoEstaVazio(FDANFEClassOwner.ProtocoloNFe) then
                          FieldByName('Contingencia_Valor').AsString := FDANFEClassOwner.ProtocoloNFe;
                      end;
                    end;

         teOffLine: begin
                      FieldByName('Contingencia_Valor').AsString := FNFe.procNFe.nProt + ' ' + IfThen(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
                      FieldByName('nProt').AsString := FNFe.procNfe.nProt;
                      FieldByName('dhRecbto').AsDateTime := FNFe.procNFe.dhRecbto;
                    end;
      end;

      FieldByName('QtdeItens').AsInteger := NFe.Det.Count;

    end;

    if NaoEstaVazio(FieldByName('Mensagem0').AsString) then
      FieldByName('Mensagem0').AsString  := FieldByName('Mensagem0').AsString+#10#13;

    FieldByName('Mensagem0').AsString                   := FieldByName('Mensagem0').AsString + MarcaDaguaMSG;

    FieldByName('LogoExpandido').AsString               := IfThen( FDANFEClassOwner.ExpandirLogoMarca, '1' , '0' );
    FieldByName('Sistema').AsString                     := IfThen( FDANFEClassOwner.Sistema <> '' , FDANFEClassOwner.Sistema, 'Projeto ACBr - http://acbr.sf.net');
    FieldByName('Usuario').AsString                     := IfThen( FDANFEClassOwner.Usuario <> '' , ' - ' + FDANFEClassOwner.Usuario , '' );
    FieldByName('Fax').AsString                         := IfThen( FDANFEClassOwner.Fax     <> '' , ' - FAX ' + FDANFEClassOwner.Fax , '');
    FieldByName('Site').AsString                        := FDANFEClassOwner.Site;
    FieldByName('Email').AsString                       := FDANFEClassOwner.Email;
    FieldByName('Desconto').AsString                    := IfThen( FDANFEClassOwner.ImprimirDescPorc , '%' , 'VALOR');
    FieldByName('TotalLiquido').AsString                := IfThen( FDANFEClassOwner.ImprimirTotalLiquido ,ACBrStr('LÍQUIDO') ,'TOTAL');
    FieldByName('LinhasPorPagina').AsInteger            := FDANFEClassOwner.ProdutosPorPagina;
    FieldByName('ExpandirDadosAdicionaisAuto').AsString := IfThen( ExpandirDadosAdicionaisAuto , 'S' , 'N');
    FieldByName('sDisplayFormat').AsString              := '###,###,###,##0.%.*d';
    FieldByName('iFormato').AsInteger                   := integer( FDANFEClassOwner.CasasDecimais.Formato );
    FieldByName('Mask_qCom').AsString                   := FDANFEClassOwner.CasasDecimais._Mask_qCom;
    FieldByName('Mask_vUnCom').AsString                 := FDANFEClassOwner.CasasDecimais._Mask_vUnCom;
    FieldByName('Casas_qCom').AsInteger                 := FDANFEClassOwner.CasasDecimais._qCom;
    FieldByName('Casas_vUnCom').AsInteger               := FDANFEClassOwner.CasasDecimais._vUnCom;
    FieldByName('DescricaoViaEstabelec').AsString       := FDescricaoViaEstabelec;
    FieldByName('ImprimeDescAcrescItem').AsInteger      := IfThen( FDANFEClassOwner.ImprimeDescAcrescItem, 1 , 0 );

    // Carregamento da imagem
    if NaoEstaVazio(DANFEClassOwner.Logo) then
    begin
    {$IF Defined(LINUX)}
      img := FMX.Graphics.TBitmap.Create;
    {$ELSE}
      img := TPicture.Create;
    {$IFEND}
      vStream := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(DANFEClassOwner.Logo, img);
        try
        {$IF Defined(LINUX)}
          If Assigned(TfrxPictureView(frxReport.FindObject('imgLogo'))) Then
          Begin
            TfrxPictureView(frxReport.FindObject('imgLogo')).HightQuality := True;
            TfrxPictureView(frxReport.FindObject('imgLogo')).Stretched := False;

            ResizeBitmapProportional(img,
                                     Trunc(TfrxPictureView(frxReport.FindObject('imgLogo')).Width),
                                     Trunc(TfrxPictureView(frxReport.FindObject('imgLogo')).Height));
          End;
          img.SaveToStream(vStream);
        {$ELSE}
          img.Bitmap.SaveToStream(vStream);
        {$IFEND}
          FieldByName('Imagem').AsString := DANFEClassOwner.Logo;
          vStream.Position := 0;
          TBlobField(cdsParametros.FieldByName('LogoCarregado')).LoadFromStream(vStream);
        except on E: Exception do
          {$IF Defined(LINUX)}
            Writeln(e.Message);
          {$ELSE}
            ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
          {$IFEND}
        end;
      finally
        FreeAndNil(vStream);
        FreeAndNil(img);
      end;
    end;

    // Carregamento da marca d´agua
    if NaoEstaVazio(DANFEClassOwner.MarcaDagua) then
    begin
    {$IF Defined(LINUX)}
      img := FMX.Graphics.TBitmap.Create;
    {$ELSE}
      img := TPicture.Create;
    {$IFEND}
      vStream := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(DANFEClassOwner.MarcaDagua, img);
        try
        {$IF Defined(LINUX)}
          img.SaveToStream(vStream);
        {$ELSE}
          img.Bitmap.SaveToStream(vStream);
        {$IFEND}
          FieldByName('MarcaDagua').AsString := DANFEClassOwner.MarcaDagua;
          vStream.Position := 0;
          TBlobField(cdsParametros.FieldByName('MarcaDaguaCarregada')).LoadFromStream(vStream);
        except on E: Exception do
          {$IF Defined(LINUX)}
            Writeln(e.Message);
          {$ELSE}
            ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
          {$IFEND}
        end;
      finally
        FreeAndNil(vStream);
        FreeAndNil(img);
      end;
    end;

    FieldByName('MensagemReimpressao').AsString := IfThen( FDANFEClassOwner.Reimpressao , '*** SEGUNDA VIA ***', '');

    FieldByName('ClassifiVenda').AsBoolean := (FDANFEClassOwner.ClassifiVenda);

    FieldByName('NfeCancelada').AsBoolean := (FDANFEClassOwner.NfeCancelada);
    FieldByName('NumDaVia').AsInteger := (FDANFEClassOwner.NumDaVia);
    FieldByName('QtdVolume').AsInteger := (FDANFEClassOwner.QtdVolume);

    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaTransportador;
begin
  with cdsTransportador do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    with FNFe.Transp do
    begin
      FieldByName('ModFrete').AsString :=modFreteToDesStr( ModFrete );
      with Transporta do
      begin
        FieldByName('CNPJCPF').AsString := FormatarCNPJouCPF(CNPJCPF);
        FieldByName('XNome').AsString   := XNome;
        FieldByName('IE').AsString      := IE;
        FieldByName('XEnder').AsString  := XEnder;
        FieldByName('XMun').AsString    := CollateBr(XMun);
        FieldByName('UF').AsString      := UF;
      end;
    end;
    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaVeiculo;
begin
  with cdsVeiculo do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;
    Append;

    with FNFe.Transp.VeicTransp do
    begin
      FieldByName('PLACA').AsString := Placa;
      FieldByName('UF').AsString    := UF;
      FieldByName('RNTC').AsString  := RNTC;
    end;

    Post;
  end;
end;

procedure TACBrNFeFRClass.CarregaVolumes;
var
  i: Integer;
begin
  with cdsVolumes do
  begin
    Close;
    CreateDataSet;
    LogChanges := False;

    for i := 0 to NFe.Transp.Vol.Count - 1 do
    begin
      Append;
      with FNFe.Transp.Vol[i] do
      begin
        FieldByName('QVol').AsFloat   := QVol;
        FieldByName('Esp').AsString   := Esp;
        FieldByName('Marca').AsString := Marca;
        FieldByName('NVol').AsString  := NVol;
        FieldByName('PesoL').AsFloat  := PesoL;
        FieldByName('PesoB').AsFloat  := PesoB;
      end;
      Post;
    end;
  end;
end;


constructor TACBrNFeFRClass.Create(AOwner: TComponent);
begin
  FDANFEClassOwner := TACBrNFeDANFEClass(AOwner);

  FfrxReport := TfrxReport.Create( nil);
  FfrxReport.EngineOptions.UseGlobalDataSetList := False;
{$IF Defined(LINUX)}
  FfrxReport.PreviewOptions.Buttons := [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbThumbnails,
    pbOutline, pbPageSetup, pbPageSetup, pbNavigator, pbExport];
{$ELSE}
  FfrxReport.PreviewOptions.Buttons := [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind,
    pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick];
{$IFEND}
  with FfrxReport do
  begin
     EngineOptions.DoublePass := True;
     StoreInDFM := False;
     OnBeforePrint := frxReportBeforePrint;
     OnReportPrint := 'frxReportOnReportPrint';
  end;
  FfrxPDFExport := TfrxPDFExport.Create(nil);
  with FfrxPDFExport do
  begin
     Background    := IncorporarBackgroundPdf;
     EmbeddedFonts := IncorporarFontesPdf;
     Subject       := 'Exportando DANFE para PDF';
     ShowProgress  := False;
  end;

  // cdsIdentificacao
  if not Assigned(cdsIdentificacao) then
  begin
     cdsIdentificacao := TUniClientDataSet.Create(nil);
     FfrxIdentificacao := TfrxDBDataset.Create(nil);
     with FfrxIdentificacao do
     begin
        DataSet := cdsIdentificacao;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Identificacao';
     end;
     with cdsIdentificacao do
     begin
        FieldDefs.Add('Id', ftString, 44);
        FieldDefs.Add('Chave', ftString, 60);
        FieldDefs.Add('cUF', ftString, 2);
        FieldDefs.Add('cNF', ftString, 9);
        FieldDefs.Add('NatOp', ftString, 60);
        FieldDefs.Add('IndPag', ftString, 1);
        FieldDefs.Add('Mod_', ftString, 2);
        FieldDefs.Add('Serie', ftString, 3);
        FieldDefs.Add('NNF', ftString, 11);
        FieldDefs.Add('DEmi', ftString, 19);
        FieldDefs.Add('HEmi', ftString, 19);
        FieldDefs.Add('DSaiEnt', ftString, 10);
        FieldDefs.Add('TpNF', ftString, 1);
        FieldDefs.Add('CMunFG', ftString, 7);
        FieldDefs.Add('TpImp', ftString, 1);
        FieldDefs.Add('TpEmis', ftString, 1);
        FieldDefs.Add('CDV', ftString, 1);
        FieldDefs.Add('TpAmb', ftString, 1);
        FieldDefs.Add('FinNFe', ftString, 1);
        FieldDefs.Add('ProcEmi', ftString, 1);
        FieldDefs.Add('VerProc', ftString, 6);
        FieldDefs.Add('HoraSaida', ftString, 10);
        FieldDefs.Add('MensagemFiscal', ftString, 200);
        FieldDefs.Add('URL', ftString, 1000);
        FieldDefs.Add('DadosCndFpg', ftString, 256);
        FieldDefs.Add('NumeroPedidosFaturados', ftString, 256);
        FieldDefs.Add('xMsg', ftString, 256);
        FieldDefs.Add('DtEntr', ftString, 19);
        FieldDefs.Add('EntregaRetira', ftString, 10);
        FieldDefs.Add('TranspCodTra', ftString, 5);
        FieldDefs.Add('TranspNomTra', ftString, 40);
        FieldDefs.Add('TranspEndere', ftString, 40);
        FieldDefs.Add('TranspBairro', ftString, 60);
        FieldDefs.Add('TranspCidade', ftString, 40);
        FieldDefs.Add('TranspEstado', ftString, 2);
        FieldDefs.Add('Romaneio', ftString, 23);
        FieldDefs.Add('CodBox', ftString, 10);
        FieldDefs.Add('DesReg', ftString, 40);
        FieldDefs.Add('Vendedor', ftString, 80);
        FieldDefs.Add('NumRom', ftString, 6);
        FieldDefs.Add('PlacaVeiculo', ftString, 7);
        FieldDefs.Add('KMVeiculo', ftString, 10);
        FieldDefs.Add('InfAdicDanfeSimplificado', ftString, 6900);
        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsEmitente
   if not Assigned(cdsEmitente) then
   begin
     cdsEmitente := TUniClientDataSet.Create(nil);
     FfrxEmitente := TfrxDBDataset.Create(nil);
     with FfrxEmitente do
     begin
        DataSet := cdsEmitente;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Emitente';
     end;
     with cdsEmitente do
     begin
        FieldDefs.Add('CNPJ', ftString, 18);
        FieldDefs.Add('XNome', ftString, 60);
        FieldDefs.Add('XFant', ftString, 60);
        FieldDefs.Add('XLgr', ftString, 60);
        FieldDefs.Add('Nro', ftString, 60);
        FieldDefs.Add('XCpl', ftString, 60);
        FieldDefs.Add('XBairro', ftString, 60);
        FieldDefs.Add('CMun', ftString, 7);
        FieldDefs.Add('XMun', ftString, 60);
        FieldDefs.Add('UF', ftString, 2);
        FieldDefs.Add('CEP', ftString, 9);
        FieldDefs.Add('CPais', ftString, 4);
        FieldDefs.Add('XPais', ftString, 60);
        FieldDefs.Add('Fone', ftString, 15);
        FieldDefs.Add('WhatsApp', ftString, 15);
        FieldDefs.Add('IE', ftString, 15);
        FieldDefs.Add('IM', ftString, 15);
        FieldDefs.Add('IEST', ftString, 15);
        FieldDefs.Add('CRT', ftString, 1);
        FieldDefs.Add('DESCR_CST', ftString, 30);
        FieldDefs.Add('DADOS_ENDERECO', ftString, 1000);
        FieldDefs.Add('Email', ftString, 50);
        FieldDefs.Add('Homepage', ftString, 50);
        FieldDefs.Add('Fone2', ftString, 15);
        FieldDefs.Add('RazSoc', ftString, 60);
        FieldDefs.Add('PonImp', ftString, 30);
        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsDestinatario
   if not Assigned(cdsDestinatario) then
   begin
     cdsDestinatario := TUniClientDataSet.Create(nil);
     FfrxDestinatario := TfrxDBDataset.Create(nil);
     with FfrxDestinatario do
     begin
        DataSet := cdsDestinatario;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Destinatario';
     end;
     with cdsDestinatario do
     begin
        FieldDefs.Add('CNPJCPF', ftString, 18);
        FieldDefs.Add('XNome', ftString, 60);
        FieldDefs.Add('XLgr', ftString, 60);
        FieldDefs.Add('Nro', ftString, 60);
        FieldDefs.Add('XCpl', ftString, 60);
        FieldDefs.Add('XBairro', ftString, 60);
        FieldDefs.Add('CMun', ftString, 7);
        FieldDefs.Add('XMun', ftString, 60);
        FieldDefs.Add('UF', ftString, 2);
        FieldDefs.Add('CEP', ftString, 9);
        FieldDefs.Add('CPais', ftString, 4);
        FieldDefs.Add('XPais', ftString, 60);
        FieldDefs.Add('Fone', ftString, 15);
        FieldDefs.Add('IE', ftString, 18);
        FieldDefs.Add('Consumidor', ftString, 150);
        FieldDefs.Add('ComplementoEnd', ftString, 60);
        FieldDefs.Add('Celular', ftString, 15);
        FieldDefs.Add('IndIEDest', ftString, 20);
        FieldDefs.Add('Fone2', ftString, 15);
        FieldDefs.Add('NomeFantasia', ftString, 60);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsDadosProdutos
   if not Assigned(cdsDadosProdutos) then
   begin
     cdsDadosProdutos   := TUniClientDataSet.Create(nil);
     FfrxDadosProdutos  := TfrxDBDataset.Create(nil);
     with FfrxDadosProdutos do
     begin
        DataSet := cdsDadosProdutos;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'DadosProdutos';
     end;
     with cdsDadosProdutos do
     begin
        FieldDefs.Add('CProd'     , ftString, 60);
        FieldDefs.Add('cEAN'      , ftString, 60);
        FieldDefs.Add('XProd'     , ftString, 120);
        FieldDefs.Add('infAdProdXml' , ftString, 1000);
        FieldDefs.Add('infAdProd' , ftString, 1000);
        FieldDefs.Add('infAdProdSemQuebra', ftString, 1000);
        FieldDefs.Add('NCM'       , ftString, 9);
        FieldDefs.Add('EXTIPI'    , ftString, 8);
        FieldDefs.Add('genero'    , ftString, 8);
        FieldDefs.Add('CFOP'      , ftString, 4);
        FieldDefs.Add('UCom'      , ftString, 6);
        FieldDefs.Add('QCom'      , ftFloat);
        FieldDefs.Add('VUnCom'    , ftFloat);
        FieldDefs.Add('VProd'     , ftString, 18);
        FieldDefs.Add('cEANTrib'  , ftString, 60);
        FieldDefs.Add('UTrib'     , ftString, 6);
        FieldDefs.Add('QTrib'     , ftFloat);
        FieldDefs.Add('vUnTrib'   , ftFloat);
        FieldDefs.Add('vFrete'    , ftString, 18);
        FieldDefs.Add('vOutro'    , ftString, 18);
        FieldDefs.Add('vSeg'      , ftString, 18);
        FieldDefs.Add('vDesc'     , ftString, 18);
        FieldDefs.Add('ORIGEM'    , ftString, 1);
        FieldDefs.Add('CST'       , ftString, 3);
        FieldDefs.Add('vBC'       , ftString, 18);
        FieldDefs.Add('pICMS'     , ftString, 18);
        FieldDefs.Add('vICMS'     , ftString, 18);
        FieldDefs.Add('vIPI'      , ftString, 18);
        FieldDefs.Add('pIPI'      , ftString, 18);
        FieldDefs.Add('VTotTrib'  , ftString, 18);
        FieldDefs.Add('ChaveNFe'  , ftString, 50);
        FieldDefs.Add('vISSQN'    , ftString, 18);
        FieldDefs.Add('vBcISSQN'  , ftString, 18);
        FieldDefs.Add('vBcST'     , ftString, 18);
        FieldDefs.Add('vICMSST'   , ftString, 18);
        FieldDefs.Add('nLote'     , ftString, 20);
        FieldDefs.Add('qLote'     , ftFloat);
        FieldDefs.Add('dFab'      , ftDateTime);
        FieldDefs.Add('dVal'      , ftDateTime);
        FieldDefs.Add('DescricaoProduto', ftString, 2000);
        FieldDefs.Add('Unidade'   , ftString, 14);
        FieldDefs.Add('Quantidade', ftString, 18);
        FieldDefs.Add('ValorUnitario'   , ftString, 18);
        FieldDefs.Add('Valorliquido'    , ftString, 18);
        FieldDefs.Add('ValorAcrescimos' , ftString, 18);
        FieldDefs.Add('DeptoProd'       , ftString, 40);

        FieldDefs.Add('vSTLIQ'          , ftString, 18);

        FieldDefs.Add('DescricaoProdutoSemQuebra', ftString, 2000);
        FieldDefs.Add('QuantidadeEmbalagem', ftString, 18);
        FieldDefs.Add('ValorContabil', ftString, 18);

        FieldDefs.Add('DescPorc', ftString, 18);
        FieldDefs.Add('pRedBC'  , ftString, 18);
        FieldDefs.Add('pMVAST'  , ftString, 18);
        FieldDefs.Add('pICMSST' , ftString, 18);
        FieldDefs.Add('Comple'  , ftString, 1000);
        FieldDefs.Add('QtdEtq'  , ftFloat);
        FieldDefs.Add('PorcDESESP', ftFloat);
        FieldDefs.Add('Referencia', ftString, 20);
        FieldDefs.Add('PesBru', ftFloat);
        FieldDefs.Add('PesLiq', ftFloat);
        FieldDefs.Add('ValorProdutoComImpostos' , ftString, 18);
        FieldDefs.Add('COD_NF' , ftString, 20);
        FieldDefs.Add('vBCSTRet' , ftString, 18);
        FieldDefs.Add('vICMSSTRet' , ftString, 18);
        FieldDefs.Add('LocAdi', ftString, 256);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsParametros
   if not Assigned(cdsParametros) then
   begin
     cdsParametros  := TUniClientDataSet.Create(nil);
     FfrxParametros := TfrxDBDataset.Create(nil);
     with FfrxParametros do
     begin
        DataSet         := cdsParametros;
        OpenDataSource  := False;
        Enabled := False;
        UserName        := 'Parametros';
     end;
     with cdsParametros do
     begin
        FieldDefs.Add('poscanhoto', ftString, 1);
        FieldDefs.Add('ResumoCanhoto', ftString, 200);
        FieldDefs.Add('Mensagem0', ftString, 60);
        FieldDefs.Add('Imagem', ftString, 256);
        FieldDefs.Add('Sistema', ftString, 150);
        FieldDefs.Add('Usuario', ftString, 60);
        FieldDefs.Add('Fax', ftString, 60);
        FieldDefs.Add('Site', ftString, 60);
        FieldDefs.Add('Email', ftString, 60);
        FieldDefs.Add('Desconto', ftString, 60);
        FieldDefs.Add('TotalLiquido', ftString, 60);
        FieldDefs.Add('ChaveAcesso_Descricao', ftString, 90);
        FieldDefs.Add('Contingencia_ID', ftString, 36);
        FieldDefs.Add('Contingencia_Descricao', ftString, 60);
        FieldDefs.Add('Contingencia_Valor', ftString, 60);
        FieldDefs.Add('LinhasPorPagina', ftInteger);
        FieldDefs.Add('LogoExpandido', ftString, 1);
        FieldDefs.Add('DESCR_CST', ftString, 30);
        FieldDefs.Add('ConsultaAutenticidade', ftString, 300);
        FieldDefs.Add('sDisplayFormat', ftString, 25);
        FieldDefs.Add('iFormato', ftInteger);
        FieldDefs.Add('Casas_qCom', ftInteger);
        FieldDefs.Add('Casas_vUnCom', ftInteger);
        FieldDefs.Add('Mask_qCom', ftString, 30);
        FieldDefs.Add('Mask_vUnCom', ftString, 30);
        FieldDefs.Add('LogoCarregado', ftBlob);
        FieldDefs.Add('QrCodeCarregado', ftGraphic, 1000);
        FieldDefs.Add('DescricaoViaEstabelec', ftString, 30);
        FieldDefs.Add('QtdeItens', ftInteger);
        FieldDefs.Add('ExpandirDadosAdicionaisAuto', ftString, 1);
        FieldDefs.Add('ImprimeDescAcrescItem', ftInteger);
        FieldDefs.Add('nProt', ftString, 30);
        FieldDefs.Add('dhRecbto', ftDateTime);
        FieldDefs.Add('MarcaDagua', ftString, 256);
        FieldDefs.Add('MarcaDaguaCarregada', ftBlob);
        FieldDefs.Add('MensagemReimpressao', ftString, 60);
        FieldDefs.Add('ClassifiVenda', ftBoolean);
        FieldDefs.Add('NfeCancelada', ftBoolean);
        FieldDefs.Add('NumDaVia', ftInteger);
        FieldDefs.Add('QtdVolume', ftInteger);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsDuplicatas
   if not Assigned(cdsDuplicatas) then
   begin
     cdsDuplicatas := TUniClientDataSet.Create(nil);
     FfrxDuplicatas := TfrxDBDataset.Create(nil);
     with FfrxDuplicatas do
     begin
        DataSet := cdsDuplicatas;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Duplicatas';
     end;
     with cdsDuplicatas do
     begin
        FieldDefs.Add('NDup', ftString, 60);
        FieldDefs.Add('DVenc', ftString, 10);
        FieldDefs.Add('VDup', ftFloat);
        FieldDefs.Add('ChaveNFe', ftString, 50);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsCalculoImposto
   if not Assigned(cdsCalculoImposto) then
   begin
     cdsCalculoImposto := TUniClientDataSet.Create(nil);
     FfrxCalculoImposto := TfrxDBDataset.Create(nil);
     with FfrxCalculoImposto do
     begin
        DataSet := cdsCalculoImposto;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'CalculoImposto';
     end;
     with cdsCalculoImposto do
     begin
        FieldDefs.Add('VBC'         , ftFloat);
        FieldDefs.Add('VICMS'       , ftFloat);
        FieldDefs.Add('VBCST'       , ftFloat);
        FieldDefs.Add('VST'         , ftFloat);
        FieldDefs.Add('VProd'       , ftFloat);
        FieldDefs.Add('VFrete'      , ftFloat);
        FieldDefs.Add('VSeg'        , ftFloat);
        FieldDefs.Add('VDesc'       , ftFloat);
        FieldDefs.Add('VII'         , ftFloat);
        FieldDefs.Add('VIPI'        , ftFloat);
        FieldDefs.Add('VPIS'        , ftFloat);
        FieldDefs.Add('VCOFINS'     , ftFloat);
        FieldDefs.Add('VOutro'      , ftFloat);
        FieldDefs.Add('VNF'         , ftFloat);
        FieldDefs.Add('VTotTrib'    , ftFloat);
        FieldDefs.Add('VTribPerc'   , ftFloat);
        FieldDefs.Add('VTribFonte'  , ftString, 100);
        FieldDefs.Add('vTotPago'    , ftFloat);
        FieldDefs.Add('vTroco'      , ftFloat);
        FieldDefs.Add('ValorApagar' , ftFloat);
        FieldDefs.Add('VFCP'        , ftFloat);
        FieldDefs.Add('VICMSUFRemet', ftFloat);
        FieldDefs.Add('VICMSUFDest' , ftFloat);
        FieldDefs.Add('VTotTribII'  , ftFloat);
        FieldDefs.Add('VICMSDeson'  , ftFloat);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsTransportador
   if not Assigned(cdsTransportador) then
   begin
     cdsTransportador := TUniClientDataSet.Create(nil);
     FfrxTransportador := TfrxDBDataset.Create(nil);
     with FfrxTransportador do
     begin
        DataSet := cdsTransportador;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Transportador';
     end;
     with cdsTransportador do
     begin
        FieldDefs.Add('ModFrete', ftString, 17);
        FieldDefs.Add('CNPJCPF', ftString, 18);
        FieldDefs.Add('XNome', ftString, 60);
        FieldDefs.Add('IE', ftString, 15);
        FieldDefs.Add('XEnder', ftString, 60);
        FieldDefs.Add('XMun', ftString, 60);
        FieldDefs.Add('UF', ftString, 2);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsVeiculo
   if not Assigned(cdsVeiculo) then
   begin
     cdsVeiculo := TUniClientDataSet.Create(nil);
     FfrxVeiculo := TfrxDBDataset.Create(nil);
     with FfrxVeiculo do
     begin
        DataSet := cdsVeiculo;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Veiculo';
     end;
     with cdsVeiculo do
     begin
        FieldDefs.Add('PLACA', ftString, 8);
        FieldDefs.Add('UF', ftString, 2);
        FieldDefs.Add('RNTC', ftString, 20);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // cdsVolumes
   if not Assigned(cdsVolumes) then
   begin
     cdsVolumes := TUniClientDataSet.Create(nil);
     FfrxVolumes := TfrxDBDataset.Create(nil);
     with FfrxVolumes do
     begin
        DataSet := cdsVolumes;
        OpenDataSource := False;
        Enabled := False;
        UserName := 'Volumes';
     end;
     with cdsVolumes do
     begin
        FieldDefs.Add('QVol', ftFloat);
        FieldDefs.Add('Esp', ftString, 60);
        FieldDefs.Add('Marca', ftString, 60);
        FieldDefs.Add('NVol', ftString, 60);
        FieldDefs.Add('PesoL', ftFloat);
        FieldDefs.Add('PesoB', ftFloat);

        CreateDataSet;
        LogChanges := False;
     end;
   end;

   // csdEvento
   if not Assigned(cdsEventos) then
   begin
      cdsEventos := TUniClientDataSet.Create(nil);
      FfrxEventos := TfrxDBDataset.Create(nil);
      with FfrxEventos do
      begin
         DataSet := cdsEventos;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'Eventos';
      end;
   end;

   // cdsISSQN
   if not Assigned(cdsISSQN) then
   begin
      cdsISSQN := TUniClientDataSet.Create(nil);
      FfrxISSQN := TfrxDBDataset.Create(nil);
      with FfrxISSQN do
      begin
         DataSet := cdsISSQN;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'ISSQN';
      end;
      with cdsISSQN do
      begin
         FieldDefs.Add('vSERV', ftFloat);
         FieldDefs.Add('vBC', ftFloat);
         FieldDefs.Add('vISS', ftFloat);
         FieldDefs.Add('vDescIncond', ftFloat);
         FieldDefs.Add('vISSRet', ftFloat);

         CreateDataSet;
         LogChanges := False;
      end;
   end;

   // cdsFatura
   if not Assigned(cdsFatura) then
   begin
      cdsFatura   := TUniClientDataSet.Create(nil);
      FfrxFatura  := TfrxDBDataset.Create(nil);
      with FfrxFatura do
      begin
         DataSet        := cdsFatura;
         OpenDataSource := False;
         Enabled := False;
         UserName       := 'Fatura';
      end;
      with cdsFatura do
      begin
         FieldDefs.Add('iForma'   , ftInteger);
         FieldDefs.Add('Pagamento', ftString, 20);
         FieldDefs.Add('nFat'     , ftString, 60);
         FieldDefs.Add('vOrig'    , ftFloat);
         FieldDefs.Add('vDesc'    , ftFloat);
         FieldDefs.Add('vLiq'     , ftFloat);

         CreateDataSet;
         LogChanges := False;
      end;
   end;

   // cdsLocalRetirada
   if not Assigned(cdsLocalRetirada) then
   begin
      cdsLocalRetirada := TUniClientDataSet.Create(nil);
      FfrxLocalRetirada := TfrxDBDataset.Create(nil);
      with FfrxLocalRetirada do
      begin
         DataSet := cdsLocalRetirada;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'LocalRetirada';
      end;
      with cdsLocalRetirada do
      begin
         FieldDefs.Add('CNPJ', ftString, 18);
         FieldDefs.Add('XLgr', ftString, 60);
         FieldDefs.Add('Nro', ftString, 60);
         FieldDefs.Add('XCpl', ftString, 60);
         FieldDefs.Add('XBairro', ftString, 60);
         FieldDefs.Add('CMun', ftString, 7);
         FieldDefs.Add('XMun', ftString, 60);
         FieldDefs.Add('UF', ftString, 2);

         CreateDataSet;
         LogChanges := False;
      end;
   end;

   // cdsLocalEntrega
   if not Assigned(cdsLocalEntrega) then
   begin
      cdsLocalEntrega := TUniClientDataSet.Create(nil);
      FfrxLocalEntrega := TfrxDBDataset.Create(nil);
      with FfrxLocalEntrega do
      begin
         DataSet := cdsLocalEntrega;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'LocalEntrega';
      end;
      with cdsLocalEntrega do
      begin
         FieldDefs.Add('CNPJ', ftString, 18);
         FieldDefs.Add('XLgr', ftString, 60);
         FieldDefs.Add('Nro', ftString, 60);
         FieldDefs.Add('XCpl', ftString, 60);
         FieldDefs.Add('XBairro', ftString, 60);
         FieldDefs.Add('CMun', ftString, 7);
         FieldDefs.Add('XMun', ftString, 60);
         FieldDefs.Add('UF', ftString, 2);
         FieldDefs.Add('ExibirLocalEntrega', ftBoolean);
         FieldDefs.Add('CEP', ftString, 9);
         FieldDefs.Add('Fone', ftString, 15);

         CreateDataSet;
         LogChanges := False;
      end;
   end;

   // cdsInformacoesAdicionais
   if not Assigned(cdsInformacoesAdicionais) then
   begin
      cdsInformacoesAdicionais := TUniClientDataSet.Create(nil);
      FfrxInformacoesAdicionais := TfrxDBDataset.Create(nil);
      with FfrxInformacoesAdicionais do
      begin
         DataSet := cdsInformacoesAdicionais;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'InformacoesAdicionais';
      end;
      with cdsInformacoesAdicionais do
      begin
         FieldDefs.Add('OBSSemQuebra', ftString, 6900);
         FieldDefs.Add('OBS'         , ftString, 6900);
         FieldDefs.Add('NfRef'       , ftString, 6900);
         FieldDefs.Add('LinhasOBS'   , ftInteger);
         FieldDefs.Add('QrCodeDadosAdicionaisCarregado', ftBlob);
         FieldDefs.Add('OBSDanfeSimp', ftString, 6900);
         CreateDataSet;
         LogChanges := False;
      end;
   end;

   // cdsPagamento
   if not Assigned(cdsPagamento) then
   begin
      cdsPagamento := TUniClientDataSet.Create(nil);
      FfrxPagamento := TfrxDBDataset.Create(nil);
      with FfrxPagamento do
      begin
         DataSet := cdsPagamento;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'Pagamento';
      end;
      with cdsPagamento do
      begin
         FieldDefs.Add('tPag', ftString, 50);
         FieldDefs.Add('vPag', ftFloat);
         FieldDefs.Add('vTroco', ftFloat);
         FieldDefs.Add('CNPJ', ftString, 50);
         FieldDefs.Add('tBand', ftString, 50);
         FieldDefs.Add('cAut', ftString, 20);

         CreateDataSet;
         LogChanges := False;
      end;
   end;

   //cdsInutilização
   if not Assigned(cdsInutilizacao) then
   begin
      cdsInutilizacao := TUniClientDataSet.Create(nil);
      FfrxInutilizacao := TfrxDBDataset.Create(nil);
      with FfrxInutilizacao do
      begin
         DataSet := cdsInutilizacao;
         OpenDataSource := False;
         Enabled := False;
         UserName := 'Inutilizacao';
      end;
   end;
end;

destructor TACBrNFeFRClass.Destroy;
begin
    FfrxReport.Free;
    FreeAndNil(FDin);
    FfrxPDFExport.Free;
    FfrxBarCodeObject.Free;
    cdsIdentificacao.Free;
    FfrxIdentificacao.Free;
    cdsEmitente.Free;
    FfrxEmitente.Free;
    cdsDestinatario.Free;
    FfrxDestinatario.Free;
    cdsDadosProdutos.Free;
    FfrxDadosProdutos.Free;
    cdsParametros.Free;
    FfrxParametros.Free;
    cdsDuplicatas.Free;
    FfrxDuplicatas.Free;
    cdsCalculoImposto.Free;
    FfrxCalculoImposto.Free;
    cdsTransportador.Free;
    FfrxTransportador.Free;
    cdsVeiculo.Free;
    FfrxVeiculo.Free;
    cdsVolumes.Free;
    FfrxVolumes.Free;
    cdsEventos.Free;
    FfrxEventos.Free;
    cdsISSQN.Free;
    FfrxISSQN.Free;
    cdsFatura.Free;
    FfrxFatura.Free;
    cdsLocalRetirada.Free;
    FfrxLocalRetirada.Free;
    cdsLocalEntrega.Free;
    FfrxLocalEntrega.Free;
    cdsInformacoesAdicionais.Free;
    FfrxInformacoesAdicionais.Free;
    cdsPagamento.Free;
    FfrxPagamento.Free;
    cdsInutilizacao.Free;
    FfrxInutilizacao.Free;

  inherited;
//  FDANFEClassOwner := TACBrNFeDANFEClass(AOwner);
end;


procedure TACBrNFeFRClass.frxReportBeforePrint(Sender: TfrxReportComponent);
var
  qrcode : String;
  CpTituloReport, CpLogomarca : TfrxComponent;
{$IF Defined(LINUX)}
  img : FMX.Graphics.TBitmap;
{$ELSE}
  img : TPicture;
{$IFEND}
begin

  qrCode := '';
  if Assigned(NFe) then
  begin
    if NaoEstaVazio(DANFEClassOwner.MarcaDagua) then
    begin
      {$IF Defined(LINUX)}
      img := FMX.Graphics.TBitmap.Create;
      {$ELSE}
      img := TPicture.Create;
      {$IFEND}
      try
        ConverterBase64ParaImagem(DANFEClassOwner.MarcaDagua, img);
        If Assigned(TfrxPictureView(frxReport.FindObject('imgMarcaDagua'))) then
          TfrxPictureView(frxReport.FindObject('imgMarcaDagua')).Picture.Assign(img);
      finally
        FreeAndNil(img);
      end;
    end;

    case NFe.Ide.modelo of
      55 :  case FNFe.Ide.tpImp of
              tiSimplificado :
                begin
                  CpTituloReport := frxReport.FindObject('PageHeader1');
                  if Assigned(CpTituloReport) then
                    CpTituloReport.Visible  := ( fImagemParametros <> '' );

                  CpLogomarca := frxReport.FindObject('ImgLogo');
                  if Assigned(CpLogomarca) and Assigned(CpTituloReport) then
                    CpLogomarca.Visible := CpTituloReport.Visible;
                end;
            end;
    end;
  end;
end;

Function TACBrNFeFRClass.ManterVprod( dVProd , dvDesc : Double ) : String;
Var
  dValor : Double;
begin
  if FDANFEClassOwner.ImprimirTotalLiquido then
    dValor := dVProd - dvDesc
  else
    dValor := dVProd;

  Result := FormatFloatBr( dValor,'###,###,##0.00');
end;

Function TACBrNFeFRClass.ManterdvTotTrib( dvTotTrib  : Double ) : String;
Var
  dValor : Double;
begin
  if ExibirTotalTributosItem then
    dValor := dvTotTrib
  else
    dValor := 0;
  Result := FormatFloatBr( dValor,'###,###,##0.00');
end;

Function TACBrNFeFRClass.ManterVDesc( dvDesc: Currency; dVUnCom , dQCom : double ) : Double;
begin
  if ( FDANFEClassOwner.ImprimirDescPorc ) then
  begin
    if ( ( dvDesc  > 0 ) and ( dVUnCom > 0 ) and ( dQCom   > 0 ) ) then
      Result := (( dvDesc*100 ) / (dVUnCom * dQCom) )
    else
      Result := 0;
  end
  else
    Result := dvDesc;
end;

Function TACBrNFeFRClass.ManterCst( dCRT: TCRT;  dCSOSN: TCSOSNIcms; dCST: TCSTIcms ) : String;
begin
  if dCRT = crtSimplesNacional then
    Result := CSOSNIcmsToStr(dCSOSN)
  else
    Result := CSTICMSToStr(dCST);
end;

Function TACBrNFeFRClass.ManterArma( inItem:  integer  ) : String;
Var
  i : Integer;
begin
  Result := '';
  with FNFe.Det.Items[inItem].Prod do
  begin
    if (FImprimirDadosArma) and ( arma.Count > 0) then
    begin
      Result := sQuebraLinha;
      for i := 0 to arma.Count - 1 do
      begin
        Result := Result + ACBrStr('TIPO DE ARMA: ')   + ArmaTipoStr( arma.Items[i].tpArma ) + sQuebraLinha;
        Result := Result + ACBrStr('No. SÉRIE ARMA: ') + arma.Items[i].nSerie + sQuebraLinha;
        Result := Result + ACBrStr('No. SÉRIE CANO: ') + arma.Items[i].nCano + sQuebraLinha;
        Result := Result + ACBrStr('DESCRIÇÃO ARMA: ') + arma.Items[i].descr + ';';
       end;
    end;
  end;
end;

Function TACBrNFeFRClass.ManterMedicamentos( inItem:  integer  ) : String;
Var
  i : Integer;
begin
  Result := '';
  { detalhamento específico de medicamentos }
  with FNFe.Det.Items[inItem].Prod do
  begin
    if med.Count > 0 then
    begin
      Result := sQuebraLinha;
      for i := 0 to med.Count - 1 do
      begin
        if NFe.infNFe.Versao >= 4 then
          Result := Result + 'C.P. ANVISA '+ med.Items[i].cProdANVISA+ sQuebraLinha
        else
        begin
          Result := Result + 'LOTE: ' + med.Items[i].nLote+ sQuebraLinha;
          Result := Result + 'QTD: '  + FormatFloatBr(med.Items[i].qLote)+ sQuebraLinha;
          Result := Result + 'FAB: '  + FormatDateBr(med.Items[i].dFab)+ sQuebraLinha;
          Result := Result + 'VAL: '  + FormatDateBr(med.Items[i].dVal)+ sQuebraLinha;
        end;
        Result := Result + IfThen( med.Items[i].vPMC  > 0, 'PMC: ' + FormatFloatBr(med.Items[i].vPMC) + ';' , '');
      end;
    end;
  end;
end;

function TACBrNFeFRClass.ManterNro(strNro: String): String;
begin
  Result := strNro;
  if Trim(strNro)='0' then
    Result := '';
end;

Function TACBrNFeFRClass.ManterRastro( inItem:  integer  ) : String;
Var
  i : Integer;
begin
  Result := '';
  { rastreabilidade do produto}
  with FNFe.Det.Items[inItem].Prod do
  begin
    if Rastro.Count > 0 then
    begin
      Result := sQuebraLinha;
      for i := 0 to Rastro.Count - 1 do
      begin
        Result := Result + 'LOTE: ' + rastro.Items[i].nLote+ sQuebraLinha;
        Result := Result + 'QTD: '  + FormatFloatBr(rastro.Items[i].qLote)+ sQuebraLinha;
        Result := Result + 'FAB: '  + FormatDateBr(rastro.Items[i].dFab)+ sQuebraLinha;
        Result := Result + 'VAL: '  + FormatDateBr(rastro.Items[i].dVal)+ sQuebraLinha;
        Result := Result + ACBrStr('C.AGREGAÇÃO: ' ) + rastro.Items[i].cAgreg+ ';';
      end;
    end;
  end;
end;

Function TACBrNFeFRClass.ManterVeiculos( inItem:  integer  ) : String;
begin
  Result := '';
{ detalhamento especifico de veículos }
  with FNFe.Det.Items[inItem].Prod do
  begin
    if veicProd.chassi > '' then
    begin
      Result := sQuebraLinha;
	    Result := Result + ACBrStr('TIPO DE OPERAÇÃO: ' + VeiculosTipoOperStr( veicProd.tpOP ) ) + sQuebraLinha;
	    Result := Result + ACBrStr('CHASSI: ' )+ veicProd.chassi + sQuebraLinha;
	    Result := Result + ACBrStr('CÓDIGO DA COR: ' )+ veicProd.cCor + sQuebraLinha;
	    Result := Result + ACBrStr('NOME DA COR: ') + veicProd.xCor + sQuebraLinha;
	    Result := Result + ACBrStr('POTÊNCIA DO MOTOR: ') + veicProd.pot + sQuebraLinha;
	    Result := Result + ACBrStr('CILINDRADAS: ') + veicProd.Cilin + sQuebraLinha;
	    Result := Result + ACBrStr('PESO LÍQUIDO: ') + veicProd.pesoL + sQuebraLinha;
	    Result := Result + ACBrStr('PESO BRUTO: ' )+ veicProd.pesoB + sQuebraLinha;
	    Result := Result + ACBrStr('NÚMERO DE SÉRIE: ') + veicProd.nSerie + sQuebraLinha;
	    Result := Result + ACBrStr('COMBUSTÍVEL: ' + VeiculosCombustivelStr( veicProd.tpComb ) ) + sQuebraLinha;
	    Result := Result + ACBrStr('NÚMERO DO MOTOR: ') + veicProd.nMotor + sQuebraLinha;
	    Result := Result + ACBrStr('CAP. MÁX. TRAÇÃO: ') + veicProd.CMT + sQuebraLinha;
	    Result := Result + ACBrStr('DISTÂNCIA ENTRE EIXOS: ') + veicProd.dist + sQuebraLinha;
	    Result := Result + ACBrStr('ANO DO MODELO: ' )+ IntToStr(veicProd.anoMod) + sQuebraLinha;
	    Result := Result + ACBrStr('ANO DE FABRICAÇÃO: ') + IntToStr(veicProd.anoFab) + sQuebraLinha;
	    Result := Result + ACBrStr('TIPO DE PINTURA: ') + veicProd.tpPint + sQuebraLinha;
	    Result := Result + ACBrStr('TIPO DE VEÍCULO: ' + VeiculosTipoStr( veicProd.tpVeic ) )+ sQuebraLinha;
	    Result := Result + ACBrStr('ESPÉCIE DO VEÍCULO: ' +VeiculosEspecieStr( veicProd.espVeic )) + sQuebraLinha;
	    Result := Result + ACBrStr('VIN (CHASSI): ' + VeiculosVinStr( veicProd.VIN ) )+ sQuebraLinha;
	    Result := Result + ACBrStr('CONDIÇÃO DO VEÍCULO: ' +VeiculosCondicaoStr( veicProd.condVeic)) + sQuebraLinha;
	    Result := Result + ACBrStr('CÓDIGO MARCA MODELO: ') + veicProd.cMod + sQuebraLinha;
	    Result := Result + ACBrStr('CÓDIGO COR DENATRAN: ' +VeiculosCorDENATRANSTr( veicProd.cCorDENATRAN )) + sQuebraLinha;
	    Result := Result + ACBrStr('CAP.MÁXIMA DE LOTAÇÃO: ') +IntToStr(veicProd.lota) + sQuebraLinha;
	    Result := Result + ACBrStr('RESTRIÇÃO: ' +VeiculosRestricaoStr( veicProd.tpRest ) )+ ';';
    end;
  end;
end;


Function TACBrNFeFRClass.ManterValAprox( inItem : Integer ): String;
begin
  Result := '';
  with FNFe.Det.Items[inItem] do
  begin
    if (Imposto.vTotTrib <> 0) and (ExibirTotalTributosItem) then
    begin
      Result := '';
      with Imposto do
      begin
        Result := Result+'Val Aprox Tributos: '+ FloatToStrF(Imposto.vTotTrib,ffCurrency,15,2);
        if TributosPercentual = ptValorNF then
          Result := Result+' ('+FloatToStrF(((StringToFloatDef(FloatToStr(Imposto.vTotTrib),0)*100)/(StringToFloatDef(FloatToStr(Prod.VProd),0) +
                                StringToFloatDef(FloatToStr(Prod.vFrete),0)  +
                                StringToFloatDef(FloatToStr(Prod.vOutro),0)  +
                                StringToFloatDef(FloatToStr(Prod.vSeg),0)    +
                                StringToFloatDef(FloatToStr(IPI.vIPI), 0)    +
                                StringToFloatDef(FloatToStr(ICMS.vICMSST), 0))),ffNumber,15,2)+'%)'
        else
          Result := Result+' ('+FloatToStrF(((StringToFloatDef(FloatToStr(Imposto.vTotTrib),0)*100)/(StringToFloatDef(FloatToStr(Prod.VProd),0))),ffNumber,15,2)+'%)';
      end;
    end;
  end;
end;

Function TACBrNFeFRClass.ManterCombustivel( inItem:  integer  ) : String;
begin
  Result := '';
  with FNFe.Det.Items[inItem].Prod do
  begin
    if comb.cProdANP > 0 then
    begin
      Result := sQuebraLinha;
      Result := Result + ACBrStr( 'CÓD. PRODUTO ANP: ') + IntToStr(comb.cProdANP) + sQuebraLinha;
      Result := Result + IfThen( comb.CODIF > '', ACBrStr( 'AUTORIZAÇÃO/CODIF: ') + comb.CODIF + sQuebraLinha , '');
      Result := Result + IfThen( comb.qTemp > 0 , ACBrStr( 'QTD. FATURADA TEMP. AMBIENTE: ' )+ FormatFloat('###,##0.0000', comb.qTemp) + sQuebraLinha , '');
      Result := Result + ACBrStr('UF DE CONSUMO: ') + comb.UFcons + sQuebraLinha;
      if comb.CIDE.qBCProd > 0 then
      begin
        Result := Result + ACBrStr('BASE DE CÁLCULO CIDE: ') + FormatFloat('###,##0.0000', comb.CIDE.qBCProd) + sQuebraLinha;
        Result := Result + ACBrStr('ALÍQUOTA CIDE: ') + FormatFloat('###,##0.0000', comb.CIDE.vAliqProd) + sQuebraLinha;
        Result := Result + ACBrStr('VALOR CIDE: ') + FormatFloat('###,##0.00', comb.CIDE.vCIDE);
      end;
      if comb.encerrante.nBico > 0  then
      begin
        Result := Result + 'ENCERRANTE' + sQuebraLinha;
        Result := Result + 'BICO: ' +  IntToStr( comb.encerrante.nBico ) + sQuebraLinha;
        Result := Result + IfThen( comb.encerrante.nBomba > 0, 'BOMBA: ' + IntToStr(comb.encerrante.nBomba) + sQuebraLinha , '');
        Result := Result + 'TANQUE: ' + IntToStr(comb.encerrante.nTanque) + sQuebraLinha;
        Result := Result + ACBrStr('NO INÍCIO: ' ) + FormatFloat('###,##0.000', comb.encerrante.vEncIni) + sQuebraLinha;
        Result := Result + 'NO FINAL: ' + FormatFloat('###,##0.000', comb.encerrante.vEncFin) + sQuebraLinha;
      end;
    end;
  end;
end;

Function TACBrNFeFRClass.ManterInfAProd( inItem : Integer; sinfAdProd : String ; GerarQuebraLinha : Boolean = True ) : String;
var
  Campos2     : TSplitResult;
  IndexCampo2 : Integer;
  vTemp2      : TStringList;
begin
  vTemp2  := TStringList.create;
  try
    Result  := sinfAdProd;
    Result  := Result + ManterValAprox( inItem );
    if FDANFEClassOwner.ImprimirDetalhamentoEspecifico then
    begin
      sQuebraLinha := QuebraLinha;
      Result := Result + ManterVeiculos( inItem  );
      Result := Result + ManterMedicamentos( inItem  );
      Result := Result + ManterRastro( inItem  );
      Result := Result + ManterArma( inItem  );
      Result := Result + ManterCombustivel( inItem );
    end;
    if Trim(Result) <> '' then
    begin
      Campos2 := Split(';', Result);

      for IndexCampo2 := 0 to Length(Campos2) - 1 do
        vTemp2.Add(Trim(Campos2[IndexCampo2]));

      If (GerarQuebraLinha) Then
        Result  := #13 + Trim(vTemp2.Text)
      Else
        Result  := '' + Trim(vTemp2.Text);

    end;
  finally
    vTemp2.free;
  end;
end;

Function TACBrNFeFRClass.ManterDescricaoProduto( sXProd,sinfAdProd : String ) : String;
begin
  Result := trim( sXProd );
  if sinfAdProd <> '' then
    Result := Result +#13+ trim( sinfAdProd );
end;


Function TACBrNFeFRClass.ManterVTribPerc( dVTotTrib , dVProd ,dVNF : Double ) : Double;
begin
  Result := 0;
  case TributosPercentual of
    ptPersonalizado   : Result := TributosPercentualPersonalizado;
    ptValorProdutos   : if (dVProd > 0) then Result := dVTotTrib*100/dVProd;
    ptValorNF         : if (dVNF   > 0) then Result := dVTotTrib*100/dVNF;
  end;
end;

procedure TACBrNFeFRClass.pGeraItensParaTotalizacaoPorNCM;
  var
    strNCM: string;
    VProd,
    VBC,
    VICMS,
    VIPI : real;
    cdsNCMDadosProdutos : TUniClientDataSet;
begin

  try

    cdsNCMDadosProdutos := TUniClientDataSet.Create(nil);

    cdsNCMDadosProdutos.FieldDefs.Add('ChaveNFe', ftString, 50);
    cdsNCMDadosProdutos.FieldDefs.Add('NCM'     , ftString, 9);
    cdsNCMDadosProdutos.FieldDefs.Add('VProd'   , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vBC'     , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vICMS'   , ftString, 18);
    cdsNCMDadosProdutos.FieldDefs.Add('vIPI'    , ftString, 18);

    cdsNCMDadosProdutos.CreateDataSet;
    cdsNCMDadosProdutos.LogChanges := False;

    cdsNCMDadosProdutos.IndexFieldNames := 'NCM';

    cdsDadosProdutos.First;

    while not cdsDadosProdutos.Eof do
    begin

      cdsNCMDadosProdutos.Append;
      cdsNCMDadosProdutos.FieldByName('ChaveNFe').asString := cdsDadosProdutos.FieldByName('ChaveNFe').asString;
      cdsNCMDadosProdutos.FieldByName('NCM').asString      := cdsDadosProdutos.FieldByName('NCM').asString;
      cdsNCMDadosProdutos.FieldByName('VProd').asString    := cdsDadosProdutos.FieldByName('VProd').asString;
      cdsNCMDadosProdutos.FieldByName('vBC').asString      := cdsDadosProdutos.FieldByName('vBC').asString;
      cdsNCMDadosProdutos.FieldByName('vICMS').asString    := cdsDadosProdutos.FieldByName('vICMS').asString;
      cdsNCMDadosProdutos.FieldByName('vIPI').asString     := cdsDadosProdutos.FieldByName('vIPI').asString;
      cdsNCMDadosProdutos.Post;

      cdsDadosProdutos.Next;

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

        VProd  := VProd + StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VProd').AsString, '.', '', [rfReplaceAll]));
        VBC    := VBC   + StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VBC').AsString,   '.', '', [rfReplaceAll]));
        VICMS  := VICMS + StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VICMS').AsString, '.', '', [rfReplaceAll]));
        VIPI   := VIPI  + StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VIPI').AsString,  '.', '', [rfReplaceAll]));

      end
      else
      begin

        cdsDadosProdutos.Append;
        cdsDadosProdutos.FieldByName('ChaveNFe').AsString         := FNFe.infNFe.ID;
        cdsDadosProdutos.FieldByName('NCM').asString              := strNCM;
        cdsDadosProdutos.FieldByName('DescricaoProduto').AsString := 'GRUPO DO NCM: ' + strNCM + #13 +
                                                                     'SUBTOTAL DOS PRODUTOS: ' + FormatFloatBr( VProd, '###,###,##0.00' ) + #13 +
                                                                     'SUBTOTAL DA BASE DE CALCULO ICMS: ' + FormatFloatBr( VBC, '###,###,##0.00' ) + #13 +
                                                                     'SUBTOTAL DO ICMS: '  + FormatFloatBr( VICMS, '###,###,##0.00' ) + #13 +
                                                                     'SUBTOTAL DO IPI: ' + FormatFloatBr( VIPI, '###,###,##0.00' ) ;
        cdsDadosProdutos.Post;

        VProd  := StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VProd').AsString, '.', '', [rfReplaceAll]));
        VBC    := StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VBC').AsString,   '.', '', [rfReplaceAll]));
        VICMS  := StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VICMS').AsString, '.', '', [rfReplaceAll]));
        VIPI   := StrToFloat(StringReplace(cdsNCMDadosProdutos.FieldByName('VIPI').AsString,  '.', '', [rfReplaceAll]));
        strNCM := cdsNCMDadosProdutos.FieldByName('NCM').asString;

      end;

      cdsNCMDadosProdutos.Next;

    end;

    cdsDadosProdutos.Insert;
    cdsDadosProdutos.FieldByName('ChaveNFe').AsString         := FNFe.infNFe.ID;
    cdsDadosProdutos.FieldByName('NCM').asString              := strNCM;
    cdsDadosProdutos.FieldByName('DescricaoProduto').AsString := 'GRUPO DO NCM: ' + strNCM + #13 +
                                                                 'SUBTOTAL DOS PRODUTOS: ' + FormatFloatBr( VProd, '###,###,##0.00' ) + #13 +
                                                                 'SUBTOTAL DA BASE DE CALCULO ICMS: ' + FormatFloatBr( VBC, '###,###,##0.00' ) + #13 +
                                                                 'SUBTOTAL DO ICMS: '  + FormatFloatBr( VICMS, '###,###,##0.00' ) + #13 +
                                                                 'SUBTOTAL DO IPI: ' + FormatFloatBr( VIPI, '###,###,##0.00' ) ;
    cdsDadosProdutos.Post;

    cdsDadosProdutos.First;

  finally
    FreeAndNil(cdsNCMDadosProdutos);
  end;

end;


function TACBrNFeFRClass.ManterVTrib(dVTotTrib: Double): Double;
begin
  Result := 0;
  If FExibirTotalTributos Then
    Result := dVTotTrib;
end;

Function TACBrNFeFRClass.FormatQuantidade( dValor : Double ) : String;
begin
  With cdsParametros do
  begin
     case FieldByName('iFormato').AsInteger of
      0 : Result := FormatFloatBr( dValor , FloatMask( FieldByName('Casas_qCom').AsInteger));
      1 : Result := FormatFloatBr( dValor , FieldByName('Mask_qCom').AsString);
      else
        Result := FormatFloatBr( dValor , FloatMask( FieldByName('Casas_qCom').AsInteger));
    end;
  end;
end;


Function TACBrNFeFRClass.FormatValorUnitario( dValor : Double ) : String;
begin
  With cdsParametros do
  begin
    case FieldByName('iFormato').AsInteger of
      0 : Result := FormatFloatBr( dValor , FloatMask( FieldByName('Casas_vUnCom').AsInteger));
      1 : Result := FormatFloatBr( dValor , FieldByName('Mask_vUnCom').AsString);
      else
        Result := FormatFloatBr( dValor , FloatMask( FieldByName('Mask_vUnCom').AsInteger));
    end;
  end;
end;


Function TACBrNFeFRClass.QuebraLinha : String;
begin
  if fQuebraLinhaEmDetalhamentoEspecifico then
    Result := ';'
  else
    Result := ' - ';
end;


Function TACBrNFeFRClass.ManterInfAdi( swObs : String ) : String;
var
  i : Integer;
  TmpStr : String;
begin
  result := swObs;
  TmpStr := '';
  with FNFe.InfAdic do
  begin
    TmpStr  := '';
    if FDANFEClassOwner.ImprimeTagObsCont then
    begin
      for i := 0 to ObsCont.Count - 1 do
      begin
        with ObsCont.Items[i] do
          TmpStr := TmpStr + XCampo + ': ' + XTexto + ';';
      end;
    end;
    //Inf. Complementar
    if Length(InfCpl) = 0 then InfCpl := '';

    result  := result + TmpStr + InfCpl;

    TmpStr  := '';
    for i := 0 to ObsFisco.Count - 1 do
    begin
      with ObsFisco.Items[i] do
        TmpStr := TmpStr + XCampo + ': ' + XTexto + ';';
    end;

    //Fisco
    if Length(InfAdFisco) = 0 then InfAdFisco := '';

    result  := result + TmpStr + InfAdFisco;
  end;
end;

Function TACBrNFeFRClass.ManterContingencia( swObs : String ) : String;
  //Contingencia
begin
  result := swObs;
  case FNFe.Ide.tpEmis of
    teNORMAL : result := result + '';
    teOffLine,
    teContingencia,
    teFSDA,
    teSCAN,
    teSVCAN,
    teSVCRS,
    teSVCSP : result := result + ACBrStr('DANFE EM CONTINGÊNCIA, IMPRESSO EM DECORRÊNCIA DE PROBLEMAS TÉCNICOS;');
    teDPEC  : begin
                result := result +
                  ACBrStr( 'DANFE IMPRESSO EM CONTINGÊNCIA - DPEC REGULARMENTE RECEBIDA PELA RECEITA FEDERAL DO BRASIL;')+
                  ACBrStr('DATA/HORA INÍCIO: ') + IfThen(FNFe.ide.dhCont = 0, ' ', DateTimeToStr(FNFe.ide.dhCont)) + ';'+
                  ACBrStr('MOTIVO CONTINGÊNCIA: ') + IfThen(EstaVazio(FNFe.ide.xJust), ' ', FNFe.ide.xJust)+';';
              end;
  end;
end;

function TACBrNFeFRClass.fLocalFaturaIgualLocalEntrega(cdsDestinatario, cdsLocalEntrega: TUniClientDataSet): Boolean;
begin

  if cdsLocalEntrega.IsEmpty then
  begin
    result := false;
  end
  else
  begin
    if (cdsLocalEntrega.FieldByName('XLgr').asString    = cdsDestinatario.FieldByName('XLgr').asString) and
       (cdsLocalEntrega.FieldByName('Nro').asString     = cdsDestinatario.FieldByName('Nro').asString) and
       (cdsLocalEntrega.FieldByName('XBairro').asString = cdsDestinatario.FieldByName('XBairro').asString) and
       (cdsLocalEntrega.FieldByName('XMun').asString    = cdsDestinatario.FieldByName('XMun').asString) and
       (cdsLocalEntrega.FieldByName('UF').asString      = cdsDestinatario.FieldByName('UF').asString) then
    begin
      result := true;
    end
    else
    begin
      result := false;
    end;
  end;

end;

end.
