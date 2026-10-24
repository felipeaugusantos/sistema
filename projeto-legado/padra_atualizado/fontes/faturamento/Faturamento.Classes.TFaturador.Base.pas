unit Faturamento.Classes.TFaturador.Base;

interface

uses Classes, TypInfo, Controls, DB, UniClientDataSet, Uni, untFuncoes, SysUtils,
  Variants, untConstantes, untTypesSistema, strUtils, DateUtils, Shared.Functions.Types,
  System.Generics.Collections, untFuncFat, untFuncoesSimples, Faturamento.Classes.TAlterarPedido,
  Faturamento.Classes.TValidarVenda, untFuncFatTypes, untTCdsVinculosRequisicoes;

type
  TFaturadorBase = class
  private
    FNumDoc: String;
    FEspDoc: String;
    FEmpDoc: String;
    FPagFac: Boolean;
    FFatAut: Boolean;
    FAutIncFatAut: String;
    FDmpPix: Boolean;
    FEspFat: String;
    FLckInt: Boolean;
    FExpedi: Boolean;
    FAltPed: TAlterarPedido;
    FArrDoc: TFatDocInfoArray;
    FOnGravou: TFatVendaNotifyEvent;
    FSmartPOS: Boolean;
    FCdsVinculos: TUniClientDataSet;
  private
    procedure AtualizarCfop;
    procedure LiberarObjetos;

    function GetKeyLock: String;
    function LockDocumento: Boolean;
    procedure UnlockDocumento;

    procedure CarregarDocumento;
    procedure ValidarTravaDeCaixa;
    procedure ValidarFaturamento;
    procedure GravarFaturamento;
  protected
    procedure SetEspFat(const Value: string);
    procedure SetFatAut(const Value: Boolean);
    procedure SetDmpPix(const Value: Boolean);
    procedure SetPagFac(const Value: Boolean);
    procedure SetExpedi(const Value: Boolean);
    procedure SetSmartPOS(const Value: Boolean);
    procedure SetAutIncFatAut(const Value: String);

    procedure OnSetParametros; virtual;
  public
    constructor Create(ANumDoc, AEspDoc, AEmpDoc: String);
    destructor Destroy; override;

    procedure ValidarDocumento;
    procedure FaturarDocumento;
  public
    property strDocumento: String read FNumDoc;
    property strEspecie: string read FEspDoc;
    property strEmpresa: string read FEmpDoc;
    property blnPagueFacil: Boolean read FPagFac;
    property blnExpedicao: Boolean read FExpedi;
    property blnDesmembramentoPedidoPIX: Boolean read FDmpPix;
    property blnFaturadorAutomatico: Boolean read FFatAut;
    property strAutIncFaturadorAutomatico: String read FAutIncFatAut write FAutIncFatAut;
    property blnSmartPOS: Boolean read FSmartPOS;
    property strEspecieFaturamento: string read FEspFat;
    property arrDocumentosEmitidos: TFatDocInfoArray read FArrDoc;
    property OnAfterFaturamento: TFatVendaNotifyEvent read FOnGravou write FOnGravou;
  end;

implementation

uses
  untPesqAux;

const
  MSG_SUCESSO_GRAVAR = 'Documento emitido com sucesso: %s-%s-%s';
  MSG_ERRO_NA_GRAVACAO = 'Não foi possível faturar o documento.';
  MSG_ESPECIE_NAO_IMPLEMENTADA = 'Espécie de faturamento não possui implementação.';
  MSG_ERRO_CALCULAR_TOTAL = 'Não foi possível calcular o valor do documento de venda.';
  MSG_DOCUMENTO_BLOQUEADO = 'Esse Documento está sendo utilizado em Outra Estação por %s.';

{ TFaturadorBase }

constructor TFaturadorBase.Create(ANumDoc, AEspDoc, AEmpDoc: String);
begin
  FNumDoc := ANumDoc;
  FEspDoc := AEspDoc;
  FEmpDoc := AEmpDoc;
  Self.OnSetParametros;
end;

destructor TFaturadorBase.Destroy;
begin
  LiberarObjetos;
  inherited;
end;

procedure TFaturadorBase.FaturarDocumento;
begin
  CarregarDocumento;
  ValidarFaturamento;
  GravarFaturamento;
end;

procedure TFaturadorBase.GravarFaturamento;
var
  LIndex: Integer;
begin
  If Not fChamaTelaGravando(FAltPed.objVenda.fGravaArquivosDesmembrandoVenda) Then
    Raise Exception.Create(MSG_ERRO_NA_GRAVACAO);

  If Assigned(OnAfterFaturamento) Then
    OnAfterFaturamento(FAltPed.objVenda);

  SetLength(FArrDoc, FAltPed.objVenda.objFatVendaImp.ItemsCount);

  For LIndex := 0 To FAltPed.objVenda.objFatVendaImp.ItemsCount -1 Do
  Begin
    FArrDoc[LIndex].Numero  := FAltPed.objVenda.objFatVendaImp[LIndex].strNumDoc;
    FArrDoc[LIndex].Especie := FAltPed.objVenda.objFatVendaImp[LIndex].strEspDoc;
    FArrDoc[LIndex].Empresa := FAltPed.objVenda.objFatVendaImp[LIndex].strEmpDoc;
    FArrDoc[LIndex].Cliente := FAltPed.objVenda.objFatVendaImp[LIndex].strCodCli;
    FArrDoc[LIndex].Serie   := FAltPed.objVenda.objFatVendaImp[LIndex].strSerFsc;

    If Not Self.blnPagueFacil Then
      pMensagemOK(Format(MSG_SUCESSO_GRAVAR, [FArrDoc[LIndex].Numero,
        FArrDoc[LIndex].Especie, FArrDoc[LIndex].Empresa]));
  End;
end;

procedure TFaturadorBase.AtualizarCfop;
Var
  LQuery: TUniQuery;
begin
  FAltPed.objVenda.strDesCla := fRetDesCla(FAltPed.objVenda.strClaFis);

  LQuery := fCriaQuery;
  Try
    pPesquisaCadCfo(LQuery, LQuery, FAltPed.objVenda.strClaFis);

    FAltPed.objVenda.strMenCfo1 := LQuery.FieldByName('CFO_MNAT01').AsString;
    FAltPed.objVenda.strMenCfo2 := LQuery.FieldByName('CFO_MNAT02').AsString;
    FAltPed.objVenda.strMenCfo3 := LQuery.FieldByName('CFO_MNAT03').AsString;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TFaturadorBase.CarregarDocumento;
begin
  LiberarObjetos;

  FAltPed := TAlterarPedido.Create(nil);

  FAltPed.strNumPed := FNumDoc;
  FAltPed.strEspPed := FEspDoc;
  FAltPed.strEmpPed := FEmpDoc;

  ValidarDocumento;

  If Not LockDocumento Then
    Abort;

  If Not FAltPed.fCarregarPedido Then
    Abort;

  If Self.blnDesmembramentoPedidoPIX Then
  Begin
    FCdsVinculos := TCdsVinculosRequisicoes.fGetClientDataSet;

    TCdsVinculosRequisicoes.pCarregarClientDataSet(FNumDoc,
                                                   FEspDoc,
                                                   FEmpDoc);

    FAltPed.objVenda.cdsVinculos := FCdsVinculos;
  End;

  FAltPed.objVenda.strOpcDoc := 'VN';

  if Self.blnFaturadorAutomatico then
    FAltPed.objVenda.strOpcDocTrue := 'FA';

  if Self.blnSmartPOS then
    FAltPed.objVenda.strOpcDocTrue := 'FS';

  FAltPed.objVenda.strNomeForm := 'frmFatVendas';

  FAltPed.objVenda.strNumOrigem := FAltPed.objVenda.strNumOrc;
  FAltPed.objVenda.strEspOrigem := FAltPed.objVenda.strEspOrc;
  FAltPed.objVenda.strEmpOrigem := FAltPed.objVenda.strEmpOri;

  FAltPed.objVenda.strCodOpe := strLoginUsuarioLogado;
  FAltPed.objVenda.objFormasPagtoNegociada.strCodOperador := strLoginUsuarioLogado;

  FAltPed.ObjVenda.blnExecutandoDesmembramentoPedidoPIX := Self.blnDesmembramentoPedidoPIX;
  FAltPed.objVenda.blnExecutandoFaturadorAutomatico := Self.blnFaturadorAutomatico;
  FAltPed.objVenda.strAutIncFaturadorAutomatico := Self.strAutIncFaturadorAutomatico;
  FAltPed.objVenda.blnExecutandoPagueFacil := Self.blnPagueFacil;
  FAltPed.objVenda.blnSmartPOS := Self.blnSmartPOS;

  If Self.blnFaturadorAutomatico Or Self.blnDesmembramentoPedidoPIX Then
  Begin
    FAltPed.objVenda.blnIgnorarValidacaoCest := True;
    FAltPed.objVenda.blnValidarDadosNotaEletronica := False;
  End;

  If Self.blnPagueFacil Or Self.blnDesmembramentoPedidoPIX Then
  Begin
  { Para realizar desmembramento em novos pedidos corretamente (CFG_NPDF11) }
    FAltPed.objVenda.strOriF11 := 'S';
    FAltPed.objVenda.blnResCaiAdt := True;
  End;

  FAltPed.objVenda.blnConfOrcamento := True;
  FAltPed.objVenda.blnImprimeSep := False;
  FAltPed.objVenda.blnImprimeDocs := False;
  FAltPed.objVenda.blnImprimeTicketIF := False;

  FAltPed.objVenda.strEspDoc := Self.strEspecieFaturamento;

  If strEspecieFaturamento.Equals('IF') Then
  Begin
    FAltPed.objVenda.strTipPed := 'C';
  End
  Else If strEspecieFaturamento.Equals('NF') Then
  Begin
    FAltPed.objVenda.strTipPed := 'A';
  End
  Else If strEspecieFaturamento.Equals('PD') Then
  Begin
    If Not Self.blnDesmembramentoPedidoPIX Then
      Raise Exception.Create(MSG_ESPECIE_NAO_IMPLEMENTADA);
    If FAltPed.objVenda.strTipPed.IsEmpty Then
      FAltPed.objVenda.strTipPed := 'A';
  End
  Else
    Raise Exception.Create(MSG_ESPECIE_NAO_IMPLEMENTADA);

  FAltPed.objVenda.fltValMor := fCfgSis('TAXDIA', varDouble);

  If Not FAltPed.fCalculaTotalPedido Then
    Raise Exception.Create(MSG_ERRO_CALCULAR_TOTAL);

  FAltPed.objVenda.blnPdOutraLojaEmPdComEntCDOndeCDEhLojaAtual :=
    FAltPed.objVenda.fFatPedidoOutraLojaEmPedidoComEntCDOndeCDEhLojaAtual
    (FAltPed.objVenda.arrMatItens);

  FAltPed.objVenda.pSetarCentroCustoFaturamento;

  Self.AtualizarCfop;

  If Self.blnDesmembramentoPedidoPIX Then
  Begin
    If (Not FAltPed.objVenda.fDefineAbastecimentoItens(oeNaoExibir)) Then
      Abort;
  End;
end;

procedure TFaturadorBase.LiberarObjetos;
begin
  If FLckInt Then
    UnlockDocumento;

  If Assigned(FCdsVinculos) Then
    FreeAndNil(FCdsVinculos);

  If Assigned(FAltPed) Then
    FreeAndNil(FAltPed);
end;

procedure TFaturadorBase.ValidarTravaDeCaixa;
var
  LMensagem: String;
begin
  { Caixa fechado impede o faturamento todo fim de tarde. Deixar a recusa para
    dentro de fGravaArquivos fazia o faturador automático gastar as cinco
    retentativas e registrar na LOGERR uma situação rotineira, afogando o erro
    de verdade. Aqui a recusa sai por Abort, que pExecute já distingue de
    exceção. A checagem dentro de fGravaArquivos permanece. Req. 462062. }
  If FAltPed.objVenda.fTravaDeCaixaImpedeFaturamento(LMensagem) Then
  Begin
    pMensagemOK(LMensagem);
    Abort;
  End;
end;

procedure TFaturadorBase.ValidarFaturamento;
begin
  ValidarTravaDeCaixa;

  If Not TValidarFaturamento.Validate(FAltPed.objVenda) Then
    Abort;
end;

procedure TFaturadorBase.ValidarDocumento;
begin
  If Not fValidaFaturarPedido(FNumDoc, FEspDoc, FEmpDoc, FEspFat, FFatAut, FDmpPix) Then
    Abort;
end;

function TFaturadorBase.GetKeyLock: String;
begin
  Result := 'FATGOR' + FNumDoc + FEspDoc + FEmpDoc;
end;

function TFaturadorBase.LockDocumento: Boolean;
begin
  Result := True;
  FLckInt := True;
  If Not fLock_Unlock(GetKeyLock(), True, False) Then
  Begin
    FLckInt := False;
    If Not (fGetIdConnectionLock(GetKeyLock) = fGetConnectionID) Then
    Begin
      pMensagemOk(Format(MSG_DOCUMENTO_BLOQUEADO, [fGetHostLock(GetKeyLock())]));
      Result := False;
    End;
  End;
end;

procedure TFaturadorBase.OnSetParametros;
begin
  //Default parameters
  SetEspFat('NF');
  SetFatAut(False);
  SetDmpPix(False);
  SetPagFac(False);
  SetExpedi(False);
  SetSmartPOS(False);
  SetAutIncFatAut(EmptyStr);
end;

procedure TFaturadorBase.SetAutIncFatAut(const Value: String);
begin
  FAutIncFatAut := Value;
end;

procedure TFaturadorBase.SetSmartPOS(const Value: Boolean);
begin
  FSmartPOS := Value;
end;

procedure TFaturadorBase.SetEspFat(const Value: string);
begin
  FEspFat := Value;
end;

procedure TFaturadorBase.SetExpedi(const Value: Boolean);
begin
  FExpedi := Value;
end;

procedure TFaturadorBase.SetFatAut(const Value: Boolean);
begin
  FFatAut := Value;
end;

procedure TFaturadorBase.SetDmpPix(const Value: Boolean);
begin
  FDmpPix := Value;
end;

procedure TFaturadorBase.SetPagFac(const Value: Boolean);
begin
  FPagFac := Value;
end;

procedure TFaturadorBase.UnlockDocumento;
begin
  fLock_Unlock(GetKeyLock(), False, False);
end;

end.
