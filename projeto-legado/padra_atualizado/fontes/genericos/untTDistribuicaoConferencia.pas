unit untTDistribuicaoConferencia;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  System.Classes, System.Generics.Collections, System.Generics.Defaults,
  System.SysUtils, System.DateUtils, System.Math, Uni;

type
  TItemAgrupado = Record
    FCodItem: string;
    FQuantidadeTotal: Double;
  End;

  TArrItemAgrupado = array of TItemAgrupado;

  TItemAgrupadoManager = class
  private
    FItens: TArrItemAgrupado;
    function GetItemIndex(const ACodItem: string): Integer;
    function GetItem(Index: string): TItemAgrupado;
  public
    procedure AdicionarItem(const ACodItem: string; AQuantidade: Double);
    destructor Destroy; override;
   property Items[Index: string]: TItemAgrupado read GetItem; default;

  End;

  TItemConferencia = class
  private
    FSeqFatDor: string;
    FSeqFatGor: string;
    FSeqMovDet: string;
    FSeqMovGer: String;
    FCodItem: string;
    FQuantidadeTotal: Double;
    FQuantidadeConferida: Double;
    FQuantidadeLiberadaEnderecamento: Double;
    FQuantidadeLiberadaDevolucao: Double;
    FDataEmissao: TDateTime;
    FQuantidadeDevolucao: Double;
    FQuantidadeLiberadoDevolucaoNova: Double;

  protected
  public
    SeqDigCon: string;

    procedure ReverterLiberacaoEnderecamento(AQuantidade: Double);

    property SeqFatDor: string read FSeqFatDor;
    property SeqFatGor: string read FSeqFatGor;
    property SeqMovDet: string read FSeqMovDet;
    property CodItem: string read FCodItem;
    property QuantidadeTotal: Double read FQuantidadeTotal;
    property QuantidadeConferida: Double read FQuantidadeConferida write FQuantidadeConferida;
    property QuantidadeLiberadaEnderecamento: Double read FQuantidadeLiberadaEnderecamento write FQuantidadeLiberadaEnderecamento;
    property DataEmissao: TDateTime read FDataEmissao;

    constructor Create(const AMovGer, AMovDet, AFatdor, AFatGor, ACodItem: string;
      AQuantidade: Double; ADataEmissao: TDateTime); overload;

    constructor Create(const AIncDigCon, AMovGer, AMovDet, AFatdor, AFatGor, ACodItem: string;
                AQuantidadeTotal: Double;
                AQuantidadeConferida: Double;
                AQtdDevolucao: Double;
                AQtdLiberadoDevolucao: Double;
                ADataEmissao: TDateTime); overload;


  end;

  TDistribuicaoConferencia = class
  private
    FItensReserva: TObjectList<TItemConferencia>;
    ItemAgrupadoManager: TItemAgrupadoManager;
    FListaSeqFatGor: TStringList;
    FIDeDig: string;
    FQryConsulta: TUniQuery;
    FQryInsertDigCon: TUniQuery;
    FQryUpdateDigCon: TUniQuery;
    qryExtDor: TUniQuery;
    qryFatDor: TUniQuery;
    qryFatGor: TUniQuery;
    qryExtGor: TUniQuery;
    qryComand: TUniQuery;
    Log: TStringList;
    FUDEVME: Boolean;

    procedure OrdenarItensPorData(AAscendente: Boolean = True);
    function DistribuirParaItens(ACodItem: string; AQuantidade: Double): Double;
    function GetItemPorChave(const ASeqMovDet, ASeqFatDor, ASeqFatGor: string): TItemConferencia;

    procedure CarregarDadosDigEle(const AIdeDig: string);
    procedure CarregarDadosDigCon(const AListaSeqFatGor: TStringList);
    procedure CarregarDadosPorMovGer(const AMovGer: String);
    procedure CarregarDadosPorGerEle(const AListaIncGerele: TStringList);
    procedure CarregarDadosPorFatGorEntradaSimplificada(AIncFatGor: String);
    procedure CarregarDadosPorIDeDig;
   // procedure pGeraLog;
    function fFinalizaConferenciaSemContagem: Boolean;
    function GravaDigEle(AItem: TItemAgrupado): Boolean;
    function GravaDigCon(AItem: TItemConferencia; AQuantidade: Double): Boolean;
    function AtualizaDigCon(AItem: TItemConferencia; AQuantidade: Double): Boolean;
    function fGetIncDigCon(AIncMovDet: string): String;
    function fAjusteDigConParaGravacao: Boolean;

    procedure pAjustaDigConFinal;
    procedure CarregarDadosConDig(const ASeqGer: string);
  protected
    procedure ValidarQuantidade(AQuantidade: Double);
    function fMarcaParaReprocessamentoSaldo: Boolean;
  public
    LiberadoEnderecamentoSemConferencia: Boolean;
    EfetivacaoMovimentoFiscal: Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarItemReserva(const AIncMovger, AIncMovDet, AIncFatDor, AIncFatGor,
      ACodItem: string; AQuantidade: Double; ADataEmissao: TDateTime);
    procedure AdicionarConferenciaAnterior(const ACodItem, ASeqFatDor: string;
      AQuantidade: Double; ADigCon: string);
    function DesfazerLiberacaoEnderecamento(ACodItem: string; AQuantidade: Double): Boolean;
    function AtualizarRegistroDesfazerLiberacao(AItem: TItemConferencia; AQuantidade: Double): Boolean;

    function ConferirItem(ACodItem: string; AQuantidade: Double): Boolean;
    function DesfazerConferenciaItem(ACodItem: string): Boolean;
    function DesfazerConferenciaItemParcial(ACodItem: string; AQuantidade: Double): Double;
    function GetQuantidadeConferidaItem(const ACodItem: string): Double;
    function GetQuantidadeRestanteItem(const ACodItem: string): Double;
    function fTemQuantidadeNaoConferida: Boolean;
    function GetQuantidadeLiberadaEnderecamento(const ACodItem: string): Double;
    function GetQuantidadeTotalItem(const ACodItem: string): Double;
    function TemQuantidadeLiberadaEnderecamento: Boolean; overload;
    function TemQuantidadeLiberadaEnderecamento(ACodIte: String): Boolean; overload;
    function TemQuantidadeLiberarEnderecamento: Boolean;
    function TemConferencia: Boolean; overload;
    function TemConferencia(ACodite: string): Boolean; overload;

    function fCancelaConferenciaBaixada(var aError: String): Boolean;
    function fPodeCancelarConferencia(var aError: String): Boolean;

    function fJateveEnderecamento: Boolean;
    function fJateveDevolucao: Boolean;

    function fGravaLiberacaoEnderecamento: Boolean;
    function fFinalizaConferencia(): Boolean;
    function fApagaDigCon: Boolean;

    function fGetIdeDig: String;
    procedure pZeraConferencia;
    procedure SetIdeDig(AValue: string);
    class function GetIdeDigByIncGerEle(AIncGerEle: String): String;
    class function ReservaTemDigCon(AIncFatGor: string): Boolean;
    class function fGerarDigConEntradaSimplificada(
      const AstrAutIncPed: string): Boolean;
    property ItensReserva: TObjectList<TItemConferencia> read FItensReserva;
  end;

  TProcCarregaExterno = reference to procedure(AConferenciaNota: TDistribuicaoConferencia);

  TDistribuicaoConferenciaFactory = class
  public
    class function CriarPorIDeDig(const AIdeDig: string;
      AProcCarregaExterno: TProcCarregaExterno = nil): TDistribuicaoConferencia;
    class function CriarPorGerEle(const AListaIncGerele: TStringList): TDistribuicaoConferencia; overload;
    class function CriarPorFatGorEntradaSimplificada(AIncFatGor: String): TDistribuicaoConferencia; overload;
    class function CriarPorGerEle(const AGerEle: String): TDistribuicaoConferencia; overload;
    class function CriarPorMovGer(const AMovGer: String): TDistribuicaoConferencia; overload;
  end;

 TDevolucaoRetornaEstoque = class
  private
    qryExtDor: TUniQuery;
    qryFatDor: TUniQuery;
    qryFatGor: TUniQuery;
    qryExtGor: TUniQuery;

    qryComand: TUniQuery;
    qryComand2: TUniQuery;
    FItens: TObjectList<TItemConferencia>;  // Lista de itens de conferência
    function ConsultarDadosSQL(const AListaStrings: TArray<string>): TObjectList<TItemConferencia>;
    procedure pAtualizaRepAud(ACodite: String);

  public
    constructor Create(const AListaDigCon: TArray<string>);
    destructor Destroy; override;
    procedure AjustarQuantidadeDevolucao(Quantidades: Double);
    class function fAtualizaReservaEnderecamento(AIncReservaEnderecamento: String; AQtdDevolvida: Double): Boolean;
    class function fnsereDevDigitado(ASeqMov, ASeqDet, ASeqDig: String; AQtdDev: Double): Boolean;

    function DevolveParaEnderecamento: Boolean;
  end;




implementation

uses
  untTEnderecamentoConferenciaParcial, untEnderecamentoProduto,
  untTypesSistema, untTRestauraDel;

{ TItemConferencia }

constructor TItemConferencia.Create(const AMovGer, AMovDet, AFatdor, AFatGor, ACodItem: string;
  AQuantidade: Double; ADataEmissao: TDateTime);
begin
  FSeqMovDet := AMovDet;
  FSeqFatDor := AFatdor;
  FSeqFatGor := AFatGor;
  FSeqMovGer := AMovGer;
  FCodItem := ACodItem;
  FQuantidadeTotal := AQuantidade;
  FDataEmissao := ADataEmissao;
  FQuantidadeConferida := 0;
  FQuantidadeLiberadaEnderecamento := 0;
  FQuantidadeDevolucao := 0;
  FQuantidadeLiberadoDevolucaoNova := 0;
end;

constructor TItemConferencia.Create(const AIncDigCon, AMovGer, AMovDet, AFatdor, AFatGor, ACodItem: string;
  AQuantidadeTotal: Double;
  AQuantidadeConferida: Double;
  AQtdDevolucao: Double;
  AQtdLiberadoDevolucao: Double;
  ADataEmissao: TDateTime);
begin
  SeqDigCon := AIncDigCon;
  FSeqMovDet := AMovDet;
  FSeqFatDor := AFatdor;
  FSeqFatGor := AFatGor;
  FSeqMovGer := AMovGer;
  FCodItem := ACodItem;
  FQuantidadeTotal := AQuantidadeTotal;
  FQuantidadeLiberadaEnderecamento := AQuantidadeTotal;
  FQuantidadeDevolucao := AQtdDevolucao;
  FQuantidadeLiberadaDevolucao :=  AQtdLiberadoDevolucao;
  FDataEmissao := ADataEmissao;
  FQuantidadeLiberadoDevolucaoNova := 0;
end;

procedure TItemConferencia.ReverterLiberacaoEnderecamento(AQuantidade: Double);
begin
  if AQuantidade > FQuantidadeLiberadaEnderecamento then
    raise EArgumentOutOfRangeException.Create('Quantidade a reverter maior que quantidade liberada');

  FQuantidadeLiberadaEnderecamento := FQuantidadeLiberadaEnderecamento - AQuantidade;
//  FQuantidadeConferida := FQuantidadeConferida - AQuantidade;
end;

{ TDistribuicaoConferencia }

constructor TDistribuicaoConferencia.Create;
begin
  FItensReserva := TObjectList<TItemConferencia>.Create(True);
  EfetivacaoMovimentoFiscal := False;
  FUDEVME := fCfgSis('UDEVME') = 'S';
  LiberadoEnderecamentoSemConferencia := False;
  Log := TStringList.Create;
  ItemAgrupadoManager := TItemAgrupadoManager.Create;
  FListaSeqFatGor := TStringList.Create;
  FListaSeqFatGor.Sorted := True;
  FListaSeqFatGor.Duplicates := dupIgnore;
  FQryConsulta := fCriaQuery;
  qryComand := fCriaQuery;

  qryExtDor := fCriaQuery;
  qryFatDor := fCriaQuery;
  qryExtGor := fCriaQuery;
  qryFatGor := fCriaQuery;

  FQryInsertDigCon := fCriaQuery;
  FQryInsertDigCon.SQL.Add('INSERT INTO DIGCON ');
  FQryInsertDigCon.SQL.Add('(     AUTOINCREM, ');
  FQryInsertDigCon.SQL.Add('      DIC_SEQGER, ');
  FQryInsertDigCon.SQL.Add('      DIC_CODITE, ');
  FQryInsertDigCon.SQL.Add('      DIC_QTDITE, ');
  FQryInsertDigCon.SQL.Add('      DIC_IDEDIG, ');
  FQryInsertDigCon.SQL.Add('      DIC_SEQDOR, ');
  FQryInsertDigCon.SQL.Add('      DIC_MOVDET, ');
  FQryInsertDigCon.SQL.Add('      DIC_QTDTOT, ');
  FQryInsertDigCon.SQL.Add('      DIC_SEMCON, ');
  FQryInsertDigCon.SQL.Add('      DIC_QTDDEV) ');
  FQryInsertDigCon.SQL.Add('VALUES ( ');
  FQryInsertDigCon.SQL.Add('      :AUTOINCREM, ');
  FQryInsertDigCon.SQL.Add('      :DIC_SEQGER, ');
  FQryInsertDigCon.SQL.Add('      :DIC_CODITE, ');
  FQryInsertDigCon.SQL.Add('      :DIC_QTDITE, ');
  FQryInsertDigCon.SQL.Add('      :DIC_IDEDIG, ');
  FQryInsertDigCon.SQL.Add('      :DIC_SEQDOR, ');
  FQryInsertDigCon.SQL.Add('      :DIC_MOVDET, ');
  FQryInsertDigCon.SQL.Add('      :DIC_QTDTOT, ');
  FQryInsertDigCon.SQL.Add('      :DIC_SEMCON, ');
  FQryInsertDigCon.SQL.Add('      :DIC_QTDDEV) ');



  FQryUpdateDigCon := fCriaQuery;
  FQryUpdateDigCon.SQL.Add('UPDATE DIGCON SET DIC_QTDITE = IFNULL(DIC_QTDITE, 0) + :DIC_QTDITE,');
  FQryUpdateDigCon.SQL.Add('                  DIC_QTDTOT = :DIC_QTDTOT,');
  FQryUpdateDigCon.SQL.Add('                  DIC_QTDDEV = :DIC_QTDDEV, ');
  FQryUpdateDigCon.SQL.Add('                  DIC_SEQGER = :DIC_SEQGER, ');
  FQryUpdateDigCon.SQL.Add('                  DIC_SEQDOR = :DIC_SEQDOR ');
  FQryUpdateDigCon.SQL.Add(' WHERE DIC_IDEDIG = :DIC_IDEDIG');
  FQryUpdateDigCon.SQL.Add('   AND DIC_MOVDET = :DIC_MOVDET');
end;

destructor TDistribuicaoConferencia.Destroy;
begin
  FreeAndNil(FItensReserva);
  FreeAndNil(Log);
  FreeAndNil(qryComand);
  FreeAndNil(qryExtDor);
  FreeAndNil(qryFatDor);

  FreeAndNil(qryExtGor);
  FreeAndNil(qryFatGor);

  FreeAndNil(FQryConsulta);
  FreeAndNil(FQryInsertDigCon);
  FreeAndNil(FQryUpdateDigCon);
  FreeAndNil(ItemAgrupadoManager);
  FreeAndNil(FListaSeqFatGor);
  inherited;
end;

procedure TDistribuicaoConferencia.ValidarQuantidade(AQuantidade: Double);
begin
  if AQuantidade < 0 then
    raise EArgumentOutOfRangeException.Create('Quantidade não pode ser negativa');
end;

procedure TDistribuicaoConferencia.OrdenarItensPorData(AAscendente: Boolean = True);
begin
  FItensReserva.Sort(TComparer<TItemConferencia>.Construct(
    function(const Left, Right: TItemConferencia): Integer
    begin
      // Primeiro compara por DataEmissao
      Result := CompareDateTime(Left.DataEmissao, Right.DataEmissao);

      // Se as datas forem iguais, compara por SeqMovDet
      if Result = 0 then
        Result := CompareStr(Left.SeqMovDet, Right.SeqMovDet);

      // Inverte o resultado se não for ascendente
      if not AAscendente then
        Result := -Result;
    end));
end;

function TDistribuicaoConferencia.fAjusteDigConParaGravacao: Boolean;
var LItem: TItemConferencia;
begin
  Try
    for LItem in FItensReserva do
    Begin
      LItem.FQuantidadeDevolucao := IIf(FUDEVME, LItem.FQuantidadeTotal - LItem.FQuantidadeLiberadaEnderecamento, 0);
      If fEmptyStr(LItem.SeqDigCon) then
        LItem.SeqDigCon := fGetIncDigCon(LItem.FSeqMovDet);
      If Not FUDEVME then
        ConferirItem(LItem.CodItem, LItem.QuantidadeTotal - LItem.QuantidadeConferida);
    End;
    pAjustaDigConFinal();
    Result := True;
  Except
    on e: Exception do
    begin
      pMensagensErro(e.message, '[TDistribuicaoConferencia.fAjusteDigConParaGravacao]');
      Result := False;
    End;
  End
end;

procedure TDistribuicaoConferencia.pAjustaDigConFinal;
var
  LItem: TItemConferencia;
begin
  for LItem in FItensReserva do
  begin
    If (LItem.SeqDigCon = '') and EfetivacaoMovimentoFiscal then
      GravaDigCon(LItem,  LItem.QuantidadeConferida)
    else If LItem.SeqDigCon = '' Then
      GravaDigCon(LItem, IIf(LiberadoEnderecamentoSemConferencia or (Not FUDEVME), LItem.FQuantidadeTotal, 0))
    Else
      AtualizaDigCon(LItem, IIf(FUDEVME, 0, LItem.QuantidadeConferida - LItem.QuantidadeLiberadaEnderecamento));
  end;
End;

procedure TDistribuicaoConferencia.SetIdeDig(AValue: string);
begin
  FIDeDig :=  AValue;
end;

function TDistribuicaoConferencia.TemQuantidadeLiberadaEnderecamento: Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
    If LItem.FQuantidadeLiberadaEnderecamento > 0 Then
      Exit(True);
end;

function TDistribuicaoConferencia.TemConferencia: Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
   If LItem.FQuantidadeConferida > 0 Then
     Exit(True)

end;

function TDistribuicaoConferencia.TemConferencia(ACodite: string): Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
   If SameText(LItem.FCodItem,ACodite) Then
     If LItem.FQuantidadeConferida > 0 Then
       Exit(True);
end;

function TDistribuicaoConferencia.TemQuantidadeLiberadaEnderecamento(
  ACodIte: String): Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
    If LItem.FCodItem = ACodite Then
      If LItem.FQuantidadeLiberadaEnderecamento > 0 Then
        Exit(True);
end;

function TDistribuicaoConferencia.TemQuantidadeLiberarEnderecamento: Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
   If (LItem.FQuantidadeConferida > LItem.FQuantidadeLiberadaEnderecamento) then
     Exit(True);
end;

function TDistribuicaoConferencia.fFinalizaConferencia: Boolean;
begin
  Result := True;
  If (Not TemConferencia) and LiberadoEnderecamentoSemConferencia then
    Result := fFinalizaConferenciaSemContagem;

  Result := Result and fAjusteDigConParaGravacao;
  result := result and fMarcaParaReprocessamentoSaldo;
end;

function TDistribuicaoConferencia.fFinalizaConferenciaSemContagem: Boolean;
var
  LItem: TItemConferencia;
  LItemAgrupado: TItemAgrupado;
begin
  Result := True;

  for LItem in FItensReserva do
  begin
    ConferirItem(lItem.FCodItem, LItem.FQuantidadeTotal);
    LItem.FQuantidadeLiberadaEnderecamento := LItem.FQuantidadeTotal;
  End;

  for LItemAgrupado in ItemAgrupadoManager.FItens do
  begin
    If not GravaDigEle(LItemAgrupado) Then
       Exit(False)
  end;


end;

class function TDistribuicaoConferencia.GetIdeDigByIncGerEle(AIncGerEle: String): String;
var lQry: TUniQuery;
begin
  Result := '';
  lQry := fCriaQuery;
  Try
    lQry.SQl.Add('SELECT GERELE.GER_IDEDIG FROM GERELE');
    lQry.SQl.Add(' WHERE GERELE.AUTOINCREM = "'+AIncGerEle+'"');
    lQry.SQl.Add('   AND GER_DTACON IS NOT NULL');

    lQry.Open;
    If Not lQry.IsEmpty then
      Result := lQry.FieldByname('GER_IDEDIG').AsString;
  Finally
    FreeAndNil(lQry);
  End;

end;

function TDistribuicaoConferencia.GetItemPorChave(const ASeqMovDet, ASeqFatDor,
  ASeqFatGor: string): TItemConferencia;
var
  LItem: TItemConferencia;
begin
  for LItem in FItensReserva do
  begin
    if (LItem.SeqMovDet = ASeqMovDet) and
       (LItem.SeqFatDor = ASeqFatDor) and
       (LItem.SeqFatGor = ASeqFatGor) then
      Exit(LItem);
  end;
  Result := nil;
end;

procedure TDistribuicaoConferencia.AdicionarItemReserva(const AIncMovger, AIncMovDet, AIncFatDor,
  AIncFatGor, ACodItem: string; AQuantidade: Double; ADataEmissao: TDateTime);
begin
  ValidarQuantidade(AQuantidade);

  if GetItemPorChave(AIncMovDet, AIncFatDor, AIncFatGor) <> nil then
    raise EInvalidOperation.Create('Item já existe na lista de reserva');

  FItensReserva.Add(TItemConferencia.Create(AIncMovger,
    AIncMovDet, AIncFatDor, AIncFatGor, ACodItem, AQuantidade, ADataEmissao));
end;

function TDistribuicaoConferencia.fJateveDevolucao: Boolean;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add(' SELECT COUNT(1) AS QTD FROM DIGCON');
  FQryConsulta.SQL.Add('  INNER JOIN DEVVEN ON  DEVVEN.DEV_SEQDET = DIGCON.DIC_MOVDET');
  FQryConsulta.SQL.Add('  WHERE DIC_IDEDIG = "' + FIDeDig + '"');
  FQryConsulta.Open;
  Result := FQryConsulta.FieldByName('QTD').AsInteger > 0;
end;

function TDistribuicaoConferencia.fJateveEnderecamento: Boolean;
var i: integer;
begin
  If fEmptyStr(FListaSeqFatGor.Text) Then
    Exit(False);
  Result := False;
  for i := 0 to FListaSeqFatGor.Count - 1 do
    If TEnderecamentoConferenciaParcial.JaTeveEnderecamento(FListaSeqFatGor[I]) Then
    Begin
      Result := True;
      Break;
    End;
end;


function TDistribuicaoConferencia.fMarcaParaReprocessamentoSaldo: Boolean;
var
  LItemAgrupado: TItemAgrupado;
begin
  Result := True;
  Try
    qryComand.SQL.Clear;
    qryComand.SQL.Text := 'UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = "'+VS_StrCodEmp+'"';

    for LItemAgrupado in ItemAgrupadoManager.FItens do
    begin
      qryComand.paramByName('CODITE').AsString := LItemAgrupado.FCodItem;
      qryComand.ExecSQL;
    end;
  Except
    on e: Exception do
    begin
      Result := False;
      pMensagensErro(e.message, '[TDistribuicaoConferencia.fMarcaParaReprocessamentoSaldo]');
    End
  End


end;

function TDistribuicaoConferencia.fTemQuantidadeNaoConferida: Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
  Begin
    If LItem.QuantidadeTotal <> LItem.QuantidadeConferida Then
      Exit(True);
  End;
end;

function TDistribuicaoConferencia.fApagaDigCon: Boolean;
begin
  Result := True;
  Try
    FQryConsulta.SQL.Clear;
    FQryConsulta.SQL.Add('DELETE FROM DIGCON');
    FQryConsulta.SQL.Add('WHERE DIC_IDEDIG = "'+ FIDeDig +'"');
    FQryConsulta.ExecSQL;
  Except
    on e: Exception do
    begin
      Result := False;
      pMensagensErro(e.message, '[TDistribuicaoConferencia.fApagaDigCon]');
    End
  End
End;


function TDistribuicaoConferencia.fPodeCancelarConferencia(var aError: String): Boolean;
begin
  aError := '';
  Result := True;
  If fJateveEnderecamento then
  begin
    aError := 'O endereçamento desta conferência já foi realizado, portanto, não será possível cancelá-la.';
    Result := false;
    Exit;
  End;

  If fJateveDevolucao then
  begin
    aError := 'Existe uma devolução referente a esta conferência; é necessário cancelar a devolução.';
    Result := false;
    Exit;
  End;
End;

function TDistribuicaoConferencia.fCancelaConferenciaBaixada(var aError: String): Boolean;
var i: integer;
begin

  If not fPodeCancelarConferencia(aError) then
    Exit(False);

  Result := True;

  For i := 0 To FItensReserva.Count - 1 do
    FItensReserva[i].FQuantidadeConferida := 0;

  If fEmptyStr(FIDeDig) Then
    Exit;

  Try
    If not fEmptyStr(FIDeDig) Then
    begin
      Result := Result and fApagaDigCon;
      Result := Result and fMarcaParaReprocessamentoSaldo;
    End;
  Except
    on e: Exception do
    begin
      Result := False;
      pMensagensErro(e.message, '[TDistribuicaoConferencia.fCancelaConferenciaBaixada]');
    End;
  End;
end;

procedure TDistribuicaoConferencia.AdicionarConferenciaAnterior(const ACodItem,
  ASeqFatDor: string; AQuantidade: Double; ADigCon: string);
var
  LItem: TItemConferencia;
begin
  for LItem in FItensReserva do
  begin
    if (LItem.CodItem = ACodItem) and (LItem.SeqFatDor = ASeqFatDor) Then
      LItem.QuantidadeLiberadaEnderecamento := AQuantidade;
  end;
end;

function TDistribuicaoConferencia.DistribuirParaItens(ACodItem: string;
  AQuantidade: Double): Double;
var
  LItem: TItemConferencia;
  LQuantidadeRestante, LQuantidadeDistribuir: Double;
begin
  Result := 0;
  ValidarQuantidade(AQuantidade);

  for LItem in FItensReserva do
  begin
    if (LItem.CodItem = ACodItem) and (AQuantidade > 0) then
    begin
      LQuantidadeRestante := LItem.QuantidadeTotal - LItem.QuantidadeConferida;

      if LQuantidadeRestante > 0 then
      begin
        LQuantidadeDistribuir := Min(LQuantidadeRestante, AQuantidade);
        LItem.QuantidadeConferida := LItem.QuantidadeConferida + LQuantidadeDistribuir;
        AQuantidade := AQuantidade - LQuantidadeDistribuir;
        Result := Result + LQuantidadeDistribuir;
      end;
    end;
  end;
end;

function TDistribuicaoConferencia.ConferirItem(ACodItem: string;
  AQuantidade: Double): Boolean;
begin
  OrdenarItensPorData;
  Result := (DistribuirParaItens(ACodItem, AQuantidade) = AQuantidade);
end;

function TDistribuicaoConferencia.GetQuantidadeLiberadaEnderecamento(
  const ACodItem: string): Double;
var
  LItem: TItemConferencia;
begin
  Result := 0;
  for LItem in FItensReserva do
    if LItem.CodItem = ACodItem then
      Result := Result + LItem.FQuantidadeLiberadaEnderecamento;
end;

function TDistribuicaoConferencia.GetQuantidadeConferidaItem(
  const ACodItem: string): Double;
var
  LItem: TItemConferencia;
begin
  Result := 0;
  for LItem in FItensReserva do
    if LItem.CodItem = ACodItem then
      Result := Result + LItem.QuantidadeConferida;
end;

function TDistribuicaoConferencia.GetQuantidadeRestanteItem(
  const ACodItem: string): Double;
var
  LItem: TItemConferencia;
begin
  Result := 0;
  for LItem in FItensReserva do
    if LItem.CodItem = ACodItem then
      Result := Result + (LItem.QuantidadeTotal - LItem.QuantidadeConferida);
end;

function TDistribuicaoConferencia.GetQuantidadeTotalItem(
  const ACodItem: string): Double;
var
  LItem: TItemConferencia;
begin
  Result := 0;
  for LItem in FItensReserva do
    if LItem.CodItem = ACodItem then
      Result := Result + LItem.QuantidadeTotal;
end;

function TDistribuicaoConferencia.DesfazerConferenciaItem(
  ACodItem: string): Boolean;
var
  LItem: TItemConferencia;
begin
  Result := False;
  for LItem in FItensReserva do
  begin
    if (LItem.CodItem = ACodItem) and (LItem.QuantidadeConferida > 0) then
    begin
      LItem.QuantidadeConferida := 0;
      Result := True;
    end;
  end;
end;

function TDistribuicaoConferencia.DesfazerConferenciaItemParcial(
  ACodItem: string; AQuantidade: Double): Double;
var
  LItem: TItemConferencia;
  LQuantidadeRestante: Double;
begin
  Result := 0;
  ValidarQuantidade(AQuantidade);
  LQuantidadeRestante := AQuantidade;

  // Ordena por data mais recente primeiro
  OrdenarItensPorData(False);

  for LItem in FItensReserva do
  begin
    if (LItem.CodItem = ACodItem) and (LItem.QuantidadeConferida > 0) and
       (LQuantidadeRestante > 0) then
    begin
      if LItem.QuantidadeConferida >= LQuantidadeRestante then
      begin
        LItem.QuantidadeConferida := LItem.QuantidadeConferida - LQuantidadeRestante;
        Result := AQuantidade;
        Exit;
      end
      else
      begin
        Result := Result + LItem.QuantidadeConferida;
        LQuantidadeRestante := LQuantidadeRestante - LItem.QuantidadeConferida;
        LItem.QuantidadeConferida := 0;
      end;
    end;
  end;
end;

function TDistribuicaoConferencia.DesfazerLiberacaoEnderecamento(
  ACodItem: string; AQuantidade: Double): Boolean;
var
  LItem: TItemConferencia;
  LQuantidadeRestante: Double;
begin
  Result := False;
  ValidarQuantidade(AQuantidade);
  LQuantidadeRestante := AQuantidade;

  // Ordena por data mais recente primeiro (LIFO - Last In First Out)
  OrdenarItensPorData(False);

  try
    for LItem in FItensReserva do
    begin
      if (LItem.CodItem = ACodItem) and
         (LItem.QuantidadeLiberadaEnderecamento > 0) and
         (LQuantidadeRestante > 0) then
      begin
        if LItem.QuantidadeLiberadaEnderecamento >= LQuantidadeRestante then
        begin
          LItem.ReverterLiberacaoEnderecamento(LQuantidadeRestante);
          if not AtualizarRegistroDesfazerLiberacao(LItem, LQuantidadeRestante) then
            raise EArgumentOutOfRangeException.Create('Falha ao atualizar registro no banco de dados');

          LQuantidadeRestante := 0;
          Result := True;
          Break;
        end
        else
        begin
          LQuantidadeRestante := LQuantidadeRestante - LItem.QuantidadeLiberadaEnderecamento;
          if not AtualizarRegistroDesfazerLiberacao(LItem, LItem.QuantidadeLiberadaEnderecamento) then
            raise EArgumentOutOfRangeException.Create('Falha ao atualizar registro no banco de dados');

          LItem.ReverterLiberacaoEnderecamento(LItem.QuantidadeLiberadaEnderecamento);
          Result := True;
        end;
      end;
    end;

    if LQuantidadeRestante > 0 then
      raise EArgumentException.Create('Quantidade a reverter maior que quantidade liberada para o item');

  except
    on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TDistribuicaoConferencia.DesfazerLiberacaoEnderecamento]');
      // Opcional: fazer rollback da transação se estiver usando
    end;
  end;
end;

function TDistribuicaoConferencia.AtualizarRegistroDesfazerLiberacao(AItem: TItemConferencia; AQuantidade: Double): Boolean;
begin
  try
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE DIGCON SET');
    qryComand.SQL.Add('  DIC_QTDITE = DIC_QTDITE - :QTD_REVERTIDA,');
    qryComand.SQL.Add('  DIC_QTDDEV = IFNULL(DIC_QTDDEV, 0) + :QTD_REVERTIDA');
    qryComand.SQL.Add('WHERE DIC_MOVDET = :AUTOINCREM');

    qryComand.ParamByName('QTD_REVERTIDA').AsFloat := AQuantidade;
    qryComand.ParamByName('AUTOINCREM').AsString := AItem.FSeqMovDet;
    qryComand.ExecSQL;

    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TDistribuicaoConferencia.AtualizarRegistroDesfazerLiberacao]');
    end;
  end;
end;

function TDistribuicaoConferencia.fGetIdeDig: String;
begin
  Result := FIDeDig;
end;

function TDistribuicaoConferencia.fGetIncDigCon(AIncMovDet: string): String;
begin
  Result := '';
  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT AUTOINCREM FROM DIGCON WHERE DIC_MOVDET = "'+AIncMovDet+'" AND DIC_IDEDIG = "'+FIDeDig+'"');
  FQryConsulta.Open;
  If not FQryConsulta.IsEmpty Then
    Result := FQryConsulta.FieldByname('AUTOINCREM').AsString;
  {}
end;

function TDistribuicaoConferencia.fGravaLiberacaoEnderecamento: Boolean;
var
  LItem: TItemConferencia;
  LDiferenca: Double;
begin
  Result := False;
  for LItem in FItensReserva do
  begin
    If fEmptyStr(LItem.SeqDigCon) then
      LItem.SeqDigCon := fGetIncDigCon(LItem.FSeqMovDet);

    LDiferenca := LItem.QuantidadeConferida - LItem.QuantidadeLiberadaEnderecamento;
    if LDiferenca > 0 then
    begin
      If Not fEmptyStr(LItem.SeqDigCon) then
      begin
        If AtualizaDigCon(LItem, LDiferenca) Then
        begin
          Result := True;
          LItem.QuantidadeLiberadaEnderecamento := LItem.QuantidadeConferida;
        End;
      End
      Else If GravaDigCon(LItem, LDiferenca) Then
      Begin
        Result := True;
        LItem.QuantidadeLiberadaEnderecamento := LItem.QuantidadeConferida;
      End;
    end;
  end;
//  pGeraLog;

End;

function TDistribuicaoConferencia.GravaDigEle(AItem: TItemAgrupado): Boolean;
begin
  Result := True;
  qryComand.SQL.Clear;
  Try
    qryComand.SQl.Add('INSERT INTO DIGELE(');
    qryComand.SQl.Add('  AUTOINCREM,');
    qryComand.SQl.Add('  DIG_CODITE,');
    qryComand.SQl.Add('  DIG_QTDITE,');
    qryComand.SQl.Add('  DIG_IDEDIG,');
    qryComand.SQl.Add('  DIG_CODEMP,');
    qryComand.SQl.Add('  DIG_CONFER) VALUES (');
    qryComand.SQl.Add('  :AUTOINCREM,');
    qryComand.SQl.Add('  :DIG_CODITE,');
    qryComand.SQl.Add('  :DIG_QTDITE,');
    qryComand.SQl.Add('  "'+FIdeDig+'",');
    qryComand.SQl.Add('  "'+VS_StrCodEmp+'",');
    qryComand.SQl.Add('  "N")');

    qryComand.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('DIGELE', VS_StrCodemp);
    qryComand.ParamByName('DIG_CODITE').AsString := AItem.FCodItem;
    qryComand.ParamByName('DIG_QTDITE').ASFloat := AItem.FQuantidadeTotal;
    qryComand.ExecSQL;
  Except
    on e: Exception do
    Begin
      Result := false;
      pMensagensErro(e.message, '[TDistribuicaoConferencia.GravaDigEle]');
    End;
  End;
end;


function TDistribuicaoConferencia.AtualizaDigCon(AItem: TItemConferencia; AQuantidade: Double): Boolean;
begin
  Try
    FQryUpdateDigCon.ParamByName('DIC_QTDITE').AsFloat := AQuantidade;

    FQryUpdateDigCon.ParamByName('DIC_QTDTOT').AsFloat := AItem.FQuantidadeTotal;
    FQryUpdateDigCon.ParamByName('DIC_QTDDEV').AsFloat := AItem.FQuantidadeTotal - AItem.FQuantidadeConferida;

    FQryUpdateDigCon.ParamByName('DIC_SEQGER').AsString := AItem.SeqFatGor;

    FQryUpdateDigCon.ParamByName('DIC_SEQDOR').AsString := AItem.SeqFatDor;
    FQryUpdateDigCon.ParamByName('DIC_IDEDIG').AsString := FIdeDig;
    FQryUpdateDigCon.ParamByName('DIC_MOVDET').AsString := AItem.SeqMovDet;

    FQryUpdateDigCon.ExecSQL;
    Result := True;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TDistribuicaoConferencia.GravaDigCon]');
      Result := False;
    End;
  End;
End;

function TDistribuicaoConferencia.GravaDigCon(AItem: TItemConferencia; AQuantidade: Double): Boolean;
var
  LstrAutInc: string;
begin
  Try
    LstrAutInc := fRetAutoIncrem('DIGCON', VS_strCodEmp);
    FQryInsertDigCon.ParamByName('AUTOINCREM').AsString := LstrAutInc;
    FQryInsertDigCon.ParamByName('DIC_SEQGER').AsString := AItem.SeqFatGor;
    FQryInsertDigCon.ParamByName('DIC_CODITE').AsString := AItem.CodItem;
    FQryInsertDigCon.ParamByName('DIC_QTDITE').AsCurrency := AQuantidade;
    FQryInsertDigCon.ParamByName('DIC_IDEDIG').AsString := FIdeDig;
    FQryInsertDigCon.ParamByName('DIC_SEQDOR').AsString := AItem.SeqFatDor;
    FQryInsertDigCon.ParamByName('DIC_MOVDET').AsString := AItem.FSeqMovDet;
    FQryInsertDigCon.ParamByName('DIC_QTDTOT').AsFloat := AItem.FQuantidadeTotal;
    FQryInsertDigCon.ParamByName('DIC_QTDDEV').AsFloat := AItem.FQuantidadeTotal - AItem.FQuantidadeConferida;
    FQryInsertDigCon.ParamByName('DIC_SEMCON').AsString := IIf(LiberadoEnderecamentoSemConferencia, 'S', 'N');

    FQryInsertDigCon.ExecSQL;
    AItem.SeqDigCon := LstrAutInc; 
    Result := True;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TDistribuicaoConferencia.GravaDigCon]');
      Result := False;
    End;
  End;
end;

procedure TDistribuicaoConferencia.CarregarDadosDigEle(const AIdeDig: string);
begin
  FQryConsulta.SQL.Text :=
    'SELECT * FROM DIGELE WHERE DIG_IDEDIG = :IDEDIG';
  FQryConsulta.ParamByName('IDEDIG').AsString := AIdeDig;
  FQryConsulta.Open;

  try
    while not FQryConsulta.Eof do
    begin
      ConferirItem(
        FQryConsulta.FieldByName('DIG_CODITE').AsString,
        FQryConsulta.FieldByName('DIG_QTDITE').AsFloat);
      FQryConsulta.Next;
    end;
  finally
    FQryConsulta.Close;
  end;
end;

procedure TDistribuicaoConferencia.CarregarDadosDigCon(const AListaSeqFatGor: TStringList);
var
  I: Integer;
begin
  if AListaSeqFatGor.Count = 0 then Exit;

  FQryConsulta.SQL.Clear;
  FQryConsulta.SQL.Add('SELECT * ');
  FQryConsulta.SQL.Add('FROM DIGCON');
  FQryConsulta.SQL.Add('WHERE DIC_SEQGER IN (');

  for I := 0 to AListaSeqFatGor.Count - 1 do
  begin
    FQryConsulta.SQL.Add(QuotedStr(AListaSeqFatGor[I]));
    if I < AListaSeqFatGor.Count - 1 then
      FQryConsulta.SQL.Add(',');
  end;

  FQryConsulta.SQL.Add(') ');

  FQryConsulta.Open;
  try
    while not FQryConsulta.Eof do
    begin
      AdicionarConferenciaAnterior(
        FQryConsulta.FieldByName('DIC_CODITE').AsString,
        FQryConsulta.FieldByName('DIC_SEQDOR').AsString,
        FQryConsulta.FieldByName('DIC_QTDITE').AsFloat,
        FQryConsulta.FieldByName('AUTOINCREM').AsString);
      FQryConsulta.Next;
    end;
  finally
    FQryConsulta.Close;
  end;
end;

procedure TDistribuicaoConferencia.CarregarDadosPorFatGorEntradaSimplificada(AIncFatGor: String);
Var
  LstrSeqGer: String;
begin
  FQryConsulta.SQL.Text :=
    ' SELECT DETSAI.DET_SEQGER AS SEQGER, ' +
    '       MOVDET.DET_CODITE AS CODITE, ' +
    '       MOVDET.AUTOINCREM AS INCDET, ' +
    '       MOVDET.DET_QTDITE AS QTDITE, ' +
    '       FATDOR.AUTOINCREM AS INCFDO, ' +
    '       FATDOR.FDO_SEQGER AS INCFGO, ' +
    '       MOVDET.DET_DTAENT AS DTAEMI, ' +
    '       DOC_SEQCON AS IDEDIG ' +
    'FROM '+
    '  FATGOR '+
    '  INNER JOIN EXTGOR '+
    '    ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '+
    '  INNER JOIN FATDOR '+
    '    ON FATDOR.FDO_SEQGER = EXTGOR.FGO_SEQFGO '+
    '  INNER JOIN EXTDOR '+
    '    ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM '+
    '  INNER JOIN MOVDET '+
    '    ON MOVDET.AUTOINCREM = EXTDOR.FDO_AUTDET '+
    '  INNER JOIN CADEMP EMPSAI ON EMPSAI.EMP_FORFIL = MOVDET.DET_CODFOR '+
    '  INNER JOIN MOVDET DETSAI ON DETSAI.DET_CODEMP = EMPSAI.EMP_CODEMP AND '+
    '                              DETSAI.DET_NUMDOC = MOVDET.DET_NUMDOC AND '+
    '                              REPLACE(DETSAI.DET_ESPDOC,"TE","PD") = MOVDET.DET_ESPDOC AND '+
    '                              DETSAI.DET_SERIE_ = MOVDET.DET_SERIE_  '+
    '  INNER JOIN CONDOC ON DOC_SEQGER = DETSAI.DET_SEQGER               '+
    '  INNER JOIN CONGER ON CONGER.AUTOINCREM = CONDOC.DOC_SEQCON        '+
    '  LEFT JOIN GERELE ON GERELE.GER_DOCENT = MOVDET.DET_NUMDOC ' +
    '                  AND GERELE.GER_ESPENT = MOVDET.DET_ESPDOC ' +
    '                  AND GERELE.GER_EMPENT = MOVDET.DET_CODEMP ' +
    '                  AND GERELE.GER_CODFOR = MOVDET.DET_CODFOR ' +
    '                  AND GERELE.B07_SERIE  = MOVDET.DET_SERIE_ ' +
    'WHERE FATGOR.AUTOINCREM = "'+AIncFatGor+'" ' +
    'GROUP BY MOVDET.AUTOINCREM ';
  FQryConsulta.Open;
  try
    LstrSeqGer := FQryConsulta.FieldByName('SEQGER').AsString;
    FIdeDig := FQryConsulta.FieldByName('IDEDIG').AsString;
    if not FQryConsulta.IsEmpty then
    begin


      while not FQryConsulta.Eof do
      begin
        ItemAgrupadoManager.AdicionarItem(FQryConsulta.FieldByName('CODITE').AsString, FQryConsulta.FieldByName('QTDITE').AsFloat);
        AdicionarItemReserva(
          FQryConsulta.FieldByName('SEQGER').AsString,
          FQryConsulta.FieldByName('INCDET').AsString,
          FQryConsulta.FieldByName('INCFDO').AsString,
          FQryConsulta.FieldByName('INCFGO').AsString,
          FQryConsulta.FieldByName('CODITE').AsString,
          FQryConsulta.FieldByName('QTDITE').AsFloat,
          FQryConsulta.FieldByName('DTAEMI').AsDateTime);

        if not FQryConsulta.FieldByName('INCFGO').IsNull then
          FListaSeqFatGor.Add(FQryConsulta.FieldByName('INCFGO').AsString);

        FQryConsulta.Next;
      end;

      CarregarDadosConDig(LstrSeqGer);

    End;
  finally
    FQryConsulta.Close;
  end;
end;

procedure TDistribuicaoConferencia.CarregarDadosPorGerEle(const AListaIncGerele: TStringList);
var
  I: Integer;
begin
  if AListaIncGerele.Count = 0 then Exit;

  FQryConsulta.SQL.Text :=
    'SELECT MOVDET.DET_SEQGER AS SEQGER, ' +
    '       MOVDET.DET_CODITE AS CODITE, ' +
    '       MOVDET.AUTOINCREM AS INCDET, ' +
    '       MOVDET.DET_QTDITE AS QTDITE, ' +
    '       FATDOR.AUTOINCREM AS INCFDO, ' +
    '       FATDOR.FDO_SEQGER AS INCFGO, ' +
    '       GERELE.B09_DEMI AS DTAEMI, ' +
    '       GERELE.GER_IDEDIG AS IDEDIG ' +
    'FROM GERELE ' +
    'INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM ' +
    'INNER JOIN MOVTRI ON MOVTRI.DET_AUTELE = DETELE.AUTOINCREM ' +
    'INNER JOIN MOVDET ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ' +
    'LEFT JOIN EXTDOR ON EXTDOR.FDO_AUTDET = MOVTRI.DET_SEQGER ' +
    'LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
    'LEFT JOIN FATGOR ON FATGOR.AUTOINCREM =  FATDOR.FDO_SEQGER ' +
    'LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO =  FATGOR.AUTOINCREM ' +
    'WHERE GERELE.AUTOINCREM IN (';

  for I := 0 to AListaIncGerele.Count - 1 do
  begin
    FQryConsulta.SQL.Add(QuotedStr(AListaIncGerele[I]));
    if I < AListaIncGerele.Count - 1 then
      FQryConsulta.SQL.Add(',');
  end;

  FQryConsulta.SQL.Add(')');

  FQryConsulta.Open;
  try
    if not FQryConsulta.IsEmpty then
    begin
      FIdeDig := FQryConsulta.FieldByName('IDEDIG').AsString;

      while not FQryConsulta.Eof do
      begin
        ItemAgrupadoManager.AdicionarItem(FQryConsulta.FieldByName('CODITE').AsString, FQryConsulta.FieldByName('QTDITE').AsFloat);
        AdicionarItemReserva(
          FQryConsulta.FieldByName('SEQGER').AsString,
          FQryConsulta.FieldByName('INCDET').AsString,
          FQryConsulta.FieldByName('INCFDO').AsString,
          FQryConsulta.FieldByName('INCFGO').AsString,
          FQryConsulta.FieldByName('CODITE').AsString,
          FQryConsulta.FieldByName('QTDITE').AsFloat,
          FQryConsulta.FieldByName('DTAEMI').AsDateTime);

        if not FQryConsulta.FieldByName('INCFGO').IsNull then
          FListaSeqFatGor.Add(FQryConsulta.FieldByName('INCFGO').AsString);

        FQryConsulta.Next;
      end;

      CarregarDadosDigEle(FIdeDig);
      CarregarDadosDigCon(FListaSeqFatGor);
    end;
  finally
    FQryConsulta.Close;
  end;

  //Log
//  pGeraLog;
end;

//procedure TDistribuicaoConferencia.pGeraLog;
//var i: integer;
//begin
//  Log.Clear;
//  For i := 0 To FItensReserva.Count -1 do
//  begin
//    Log.Add(' CodItem = ' + FItensReserva[i].CodItem +
//            ' FSeqMovDet = ' + FItensReserva[i].FSeqMovDet +
//            ' QuantidadeConferida = ' + FItensReserva[i].QuantidadeConferida.ToString +
//            ' FQuantidadeLiberadaEnderecamento = ' + FItensReserva[i].FQuantidadeLiberadaEnderecamento.ToString +
//            ' FQuantidadeTotal= ' + FItensReserva[i].FQuantidadeTotal.ToString);
//  End;
//End;


procedure TDistribuicaoConferencia.pZeraConferencia;
var
  LItem: TItemConferencia;
begin
  for LItem in FItensReserva do
  begin
    LItem.QuantidadeConferida := 0;
    LItem.QuantidadeLiberadaEnderecamento := 0;
  end;
end;

class function TDistribuicaoConferencia.ReservaTemDigCon(
  AIncFatGor: string): Boolean;
var lQry: TUniQuery;
begin
  lQry := fCriaQuery;
  try
    lQry.SQL.add('SELECT COUNT(1) QTD FROM  DIGCON WHERE DIC_SEQGER = "'+AIncFatGor+'"');
    lQry.Open;
    Result := lQry.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(lQry)
  End
end;

procedure TDistribuicaoConferencia.CarregarDadosPorIDeDig;
begin
  FQryConsulta.SQL.Text :=
    'SELECT MOVDET.DET_SEQGER AS SEQGER, ' +
    '       MOVDET.DET_CODITE AS CODITE, ' +
    '       MOVDET.AUTOINCREM AS INCDET, ' +
    '       MOVDET.DET_QTDITE AS QTDITE, ' +
    '       FATDOR.AUTOINCREM AS INCFDO, ' +
    '       FATDOR.FDO_SEQGER AS INCFGO, ' +
    '       GERELE.B09_DEMI AS DTAEMI, ' +
    '       GERELE.GER_IDEDIG AS IDEDIG, ' +
    '       GERELE.GER_SEMCON AS SEMCON, ' +
    '       GERELE.GER_ENDDEV AS ENDDEV ' +
    'FROM GERELE ' +
    'INNER JOIN DETELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM ' +
    'INNER JOIN MOVTRI ON MOVTRI.DET_AUTELE = DETELE.AUTOINCREM ' +
    'INNER JOIN MOVDET ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ' +
    'LEFT JOIN EXTDOR ON EXTDOR.FDO_AUTDET = MOVTRI.DET_SEQGER ' +
    'LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
    'LEFT JOIN FATGOR ON FATGOR.AUTOINCREM =  FATDOR.FDO_SEQGER ' +
    'LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO =  FATGOR.AUTOINCREM ' +
    'WHERE GERELE.GER_IDEDIG = :DIGELE';

  FQryConsulta.ParamByName('DIGELE').AsString := FIdeDig;
  FQryConsulta.Open;

  If FQryConsulta.FieldByName('ENDDEV').AsString = '1' Then
    LiberadoEnderecamentoSemConferencia := FQryConsulta.FieldByName('SEMCON').AsString = 'S';

  try
    if not FQryConsulta.IsEmpty then
    begin

      while not FQryConsulta.Eof do
      begin
        AdicionarItemReserva(
          FQryConsulta.FieldByName('SEQGER').AsString,
          FQryConsulta.FieldByName('INCDET').AsString,
          FQryConsulta.FieldByName('INCFDO').AsString,
          FQryConsulta.FieldByName('INCFGO').AsString,
          FQryConsulta.FieldByName('CODITE').AsString,
          FQryConsulta.FieldByName('QTDITE').AsFloat,
          FQryConsulta.FieldByName('DTAEMI').AsDateTime);

        if not FQryConsulta.FieldByName('INCFGO').IsNull then
          FListaSeqFatGor.Add(FQryConsulta.FieldByName('INCFGO').AsString);

        FQryConsulta.Next;
      end;

      CarregarDadosDigEle(FIdeDig);
      CarregarDadosDigCon(FListaSeqFatGor);
    end;
  finally
    FQryConsulta.Close;
  end;
end;

{ TDistribuicaoConferenciaFactory }

class function TDistribuicaoConferenciaFactory.CriarPorFatGorEntradaSimplificada(
  AIncFatGor: String): TDistribuicaoConferencia;
begin
  Result := TDistribuicaoConferencia.Create;
  try
    Result.CarregarDadosPorFatGorEntradaSimplificada(AIncFatGor);
  except
    If Assigned(Result) Then
      Result.Free;
    raise;
  end;
end;

class function TDistribuicaoConferenciaFactory.CriarPorGerEle(
  const AGerEle: String): TDistribuicaoConferencia;
var lListaGerEle: TStringList;
begin
  Result := TDistribuicaoConferencia.Create;
  lListaGerEle := TStringList.Create;
  Try
    try
      lListaGerEle.Add(AGerEle);
      Result.CarregarDadosPorGerEle(lListaGerEle);
    except
      FreeAndNil(Result);
      raise;
    end;
  Finally
    FreeAndNil(lListaGerEle);
  End;
end;

class function TDistribuicaoConferenciaFactory.CriarPorMovGer(
  const AMovGer: String): TDistribuicaoConferencia;
begin
  Result := TDistribuicaoConferencia.Create;
  Try
    try
      Result.CarregarDadosPorMovGer(AMovGer);
    except
      FreeAndNil(Result);
      raise;
    end;
  Finally

  End;
end;


class function TDistribuicaoConferenciaFactory.CriarPorIDeDig(const AIdeDig: string;
  AProcCarregaExterno: TProcCarregaExterno): TDistribuicaoConferencia;
begin
  Result := TDistribuicaoConferencia.Create;
  try
    Result.FIdeDig := AIdeDig;
    if Assigned(AProcCarregaExterno) then
      AProcCarregaExterno(Result)
    else
      Result.CarregarDadosPorIDeDig;
  except
    Result.Free;
    raise;
  end;
end;


class function TDistribuicaoConferenciaFactory.CriarPorGerEle(
  const AListaIncGerele: TStringList): TDistribuicaoConferencia;
begin
  Result := TDistribuicaoConferencia.Create;
  try
    Result.CarregarDadosPorGerEle(AListaIncGerele);
  except
    FreeAndNil(Result);
    raise;
  end;
end;

{ TItemAgrupadoManager }

procedure TItemAgrupadoManager.AdicionarItem(const ACodItem: string; AQuantidade: Double);
var
  lIndex: Integer;
begin
  if AQuantidade <= 0 then
    raise EArgumentException.Create('Quantidade deve ser maior que zero');

  lIndex := GetItemIndex(ACodItem);

  if lIndex >= 0 then
    FItens[lIndex].FQuantidadeTotal := FItens[lIndex].FQuantidadeTotal + AQuantidade
  else
  begin
    SetLength(FItens, Length(FItens) + 1);
    FItens[High(FItens)].FCodItem := ACodItem;
    FItens[High(FItens)].FQuantidadeTotal := AQuantidade;
  end;
end;

destructor TItemAgrupadoManager.Destroy;
begin
  SetLength(FItens, 0);
  inherited;
end;

function TItemAgrupadoManager.GetItem(Index: string): TItemAgrupado;
var lItemAgrupado: TItemAgrupado;
begin
  for lItemAgrupado in FItens do
    if SameText(lItemAgrupado.FCodItem, Index) then
      Exit(lItemAgrupado);
  raise Exception.Create('Item não encontrado!');
end;

function TItemAgrupadoManager.GetItemIndex(const ACodItem: string): Integer;
begin
  for Result := Low(FItens) to High(FItens) do
    if SameText(FItens[Result].FCodItem, ACodItem) then
      Exit;
  Result := -1;
end;

{ TDevolucaoRetornaEstoque }
constructor TDevolucaoRetornaEstoque.Create(const AListaDigCon: TArray<string>);
begin
  FItens := ConsultarDadosSQL(AListaDigCon);  // True garante que os itens serão liberados automaticamente
  qryComand := fCriaQuery;
  qryComand2:= fCriaQuery;
  qryExtDor:= fCriaQuery;
  qryFatDor:= fCriaQuery;
  qryFatGor:= fCriaQuery;
  qryExtGor:= fCriaQuery;
end;

destructor TDevolucaoRetornaEstoque.Destroy;
begin
  FreeAndNil(qryComand);
  FreeAndNil(qryComand2);
  FreeAndNil(qryExtDor);
  FreeAndNil(qryFatDor);
  FreeAndNil(qryFatGor);
  FreeAndNil(qryExtGor);
  FreeAndNil(FItens);
  inherited;
end;

procedure TDevolucaoRetornaEstoque.pAtualizaRepAud(ACodite: String);
begin
  qryComand2.SQL.Text := 'UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = "'+ACodite+'" AND ITE_CODEMP = "'+VS_StrCodEmp+'"';
  qryComand2.ExecSQL;
end;

class function TDevolucaoRetornaEstoque.fAtualizaReservaEnderecamento(AIncReservaEnderecamento: String; AQtdDevolvida: Double): Boolean;
  Var
    lQryFatDor : TUniQuery;
    qryAuxili : TUniQuery;
    qryFatDorReserva : TUniQuery;
    qryExtDorReserva : TUniQuery;
    strIncFgo : String;
begin
  Result := True;
  lQryFatDor := fCriaQuery;
  qryAuxili := fCriaQuery;
  qryFatDorReserva := fCriaQuery;
  qryExtDorReserva := fCriaQuery;
  Try
    Try
      lQryFatDor.SQL.Add('SELECT FATDOR.* FROM FATDOR');
      lQryFatDor.SQL.add('WHERE AUTOINCREM = "' + AIncReservaEnderecamento+'"');
      lQryFatDor.Open;
      If Not lQryFatDor.IsEmpty Then
      Begin
        strIncFgo := lQryFatDor.FieldByName('FDO_SEQGER').AsString;

        qryAuxili.SQL.Clear;
        //Baixa a reserva
        qryAuxili.SQL.Add(' UPDATE FATDOR SET FDO_QTDBAI = IFNULL(FDO_QTDBAI, 0) + :QTDENV');
        qryAuxili.SQL.Add('  WHERE AUTOINCREM = :AUTINC');
        qryAuxili.ParamByName('AUTINC').AsString := lQryFatDor.FieldByName('AUTOINCREM').AsString;
        qryAuxili.ParamByName('QTDENV').AsFloat :=  AQtdDevolvida;
        qryAuxili.ExecSQL;
        qryAuxili.Close;

        qryAuxili.SQL.Clear;
        qryAuxili.SQL.Add('SELECT COUNT(0) AS QTD FROM FATDOR WHERE FDO_SEQGER = :SEQGER ');
        qryAuxili.SQL.Add('  AND FDO_QTDITE > IFNULL(FDO_QTDBAI, 0)');
        qryAuxili.ParamByName('SEQGER').AsString := strIncFgo;
        qryAuxili.Open;

        If qryAuxili.FieldByName('QTD').AsInteger = 0 then
        Begin
          qryFatDorReserva.SQL.Clear;
          qryFatDorReserva.SQL.Add('SELECT * FROM FATDOR WHERE FDO_SEQGER = "'+strIncFgo+'"');
          qryFatDorReserva.Open;

          while not qryFatDorReserva.Eof Do
          Begin
            fVerificaIntegridade(Self.ClassName, 'FATDOR', qryFatDorReserva, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');
            qryExtDorReserva.Close;
            qryExtDorReserva.SQL.Clear;

            qryExtDorReserva.SQL.Add('SELECT * FROM EXTDOR WHERE FDO_SEQFDO = "'+qryFatDorReserva.FieldByName('AUTOINCREM').AsString+'"');
            qryExtDorReserva.Open;
            fVerificaIntegridade(Self.ClassName, 'EXTDOR', qryExtDorReserva, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

            qryFatDorReserva.Next;
          End;

          qryAuxili.Close;
          qryAuxili.SQL.Clear;
          qryAuxili.SQL.Add('DELETE FROM FATDOR WHERE AUTOINCREM = :AUTINC ');
          qryFatDorReserva.First;
          while not qryFatDorReserva.Eof do
          Begin
            qryAuxili.ParamByName('AUTINC').AsString := qryFatDorReserva.FieldByName('AUTOINCREM').AsString;
            qryAuxili.ExecSQL;
            qryFatDorReserva.Next;
          End;

          qryAuxili.Close;
          qryAuxili.SQL.Clear;
          qryAuxili.SQL.Add('SELECT * FROM EXTGOR WHERE FGO_SEQFGO = :SEQFGO ');
          qryAuxili.ParamByName('SEQFGO').AsString := strIncFgo;
          qryAuxili.Open;
          fVerificaIntegridade(Self.ClassName, 'EXTGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

          qryAuxili.Close;
          qryAuxili.SQL.Clear;
          qryAuxili.SQL.Add('SELECT * FROM FATGOR WHERE AUTOINCREM = :AUTINC');
          qryAuxili.ParamByName('AUTINC').AsString := strIncFgo;
          qryAuxili.Open;
          fVerificaIntegridade(Self.ClassName, 'FATGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');
          qryAuxili.Delete;
        End;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmEntConferPreNotaWMSDevolucao.fLiberaReservaDeEstoque');
      End;

    End;

  Finally
   FreeAndNil(qryExtDorReserva);
    FreeAndNil(lQryFatDor);
    FreeAndNil(qryAuxili);
    FreeAndNil(qryFatDorReserva);
  End;
end;

class function TDevolucaoRetornaEstoque.fnsereDevDigitado(ASeqMov, ASeqDet,
  ASeqDig: String; AQtdDev: Double): Boolean;
Var
  LSQL   : String;
  LAutInc: String;
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery();
  Try
    Try

      LSQL := '';
      LSQL := LSQL + ' SELECT AUTOINCREM FROM DIGDEV ';
      LSQL := LSQL + ' WHERE  ';
      LSQL := LSQL + '   DEV_SEQMOV = :SEQMOV AND ';
      LSQL := LSQL + '   DEV_SEQDET = :SEQDET ';

      qryGen.SQL.Add(LSQL);
      qryGen.ParamByName('SEQMOV').AsString := ASeqMov;
      qryGen.ParamByName('SEQDET').AsString := ASeqDet;

      qryGen.Open;

      If (qryGen.RecordCount > 0) Then
      Begin
        LAutInc := qryGen.FieldByName('AUTOINCREM').AsString;

        LSQL := '';
        LSQL := LSQL + ' UPDATE DIGDEV SET ';
        LSQL := LSQL + '   DEV_QTDDEV = DEV_QTDDEV + :QTDDEV ';
        LSQL := LSQL + ' WHERE AUTOINCREM = :AUTINC';

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(LSQL);

        qryGen.ParamByName('AUTINC').AsString := LAutInc;
        qryGen.ParamByName('QTDDEV').AsFloat  := AQtdDev;
      End
      Else
      Begin
        LSQL := '';
        LSQL := LSQL + ' INSERT INTO DIGDEV ( ';
        LSQL := LSQL + '   AUTOINCREM, ';
        LSQL := LSQL + '   DEV_SEQMOV, ';
        LSQL := LSQL + '   DEV_SEQDET, ';
        LSQL := LSQL + '   DEV_QTDDEV) ';
        LSQL := LSQL + ' VALUES ( ';
        LSQL := LSQL + '   :AUTINC, ';
        LSQL := LSQL + '   :SEQMOV, ';
        LSQL := LSQL + '   :SEQDET, ';
        LSQL := LSQL + '   :QTDDEV) ';

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(LSQL);

        qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('DIGDEV', VS_strCodEmp);
        qryGen.ParamByName('SEQMOV').AsString := ASeqMov;
        qryGen.ParamByName('SEQDET').AsString := ASeqDet;
        qryGen.ParamByName('QTDDEV').AsFloat  := AQtdDev;

      End;

      qryGen.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[InsereDevDigitado]');
        FreeAndNil(qryGen);
        Exit;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;

end;

function TDevolucaoRetornaEstoque.DevolveParaEnderecamento : Boolean;
var
    lItem: TItemConferencia;
begin
  Result := True;
  Try
    qryComand.SQL.Add('UPDATE DIGCON');
    qryComand.SQL.Add('   SET DIC_QTDLDE = IFNULL(DIC_QTDLDE, 0) + IFNULL(:QTDLDE, 0), ');
    qryComand.SQL.Add('       DIC_QTDDEV = :QTDDEV');
    qryComand.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
    Try
      for lItem in FItens do
      Begin
        If lItem.FQuantidadeLiberadoDevolucaoNova > 0 Then
        begin
          qryComand.ParamByName('QTDLDE').AsFloat := lItem.FQuantidadeLiberadoDevolucaoNova;
          qryComand.ParamByName('QTDDEV').AsFloat := lItem.FQuantidadeDevolucao;
          qryComand.ParamByName('AUTINC').AsString := lItem.SeqDigCon;
          qryComand.ExecSQL;
          pAtualizaRepAud(lItem.CodItem);
        End;
      End;
    Except
      on e: Exception do
      begin
        Result := False;
        pMensagensErro(e.message, '[TDevolucaoRetornaEstoque.DevolveParaEnderecamento]');
      end;
    End;
  Finally
  End;
end;

function TDevolucaoRetornaEstoque.ConsultarDadosSQL(const AListaStrings: TArray<string>): TObjectList<TItemConferencia>;
var qrySQL: TUniQuery;
begin
  qrySQL := fCriaQuery;
  Try
    qrySQL.sql.Add('SELECT DIGCON.* ,');
    qrySQL.sql.Add('       MOVDET.DET_SEQGER AS SEQGER,');
    qrySQL.sql.Add('       MOVDET.DET_CODITE AS CODITE,');
    qrySQL.sql.Add('       MOVDET.AUTOINCREM AS INCDET,');
    qrySQL.sql.Add('       MOVDET.DET_QTDITE AS QTDITE,');
    qrySQL.sql.Add('       GERELE.B09_DEMI AS DTAEMI,');
    qrySQL.sql.Add('       GERELE.GER_IDEDIG AS IDEDIG ');
    qrySQL.sql.Add('  FROM DIGCON');
    qrySQL.sql.Add(' INNER JOIN MOVDET ON MOVDET.AUTOINCREM = DIC_MOVDET');
    qrySQL.sql.Add(' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
    qrySQL.sql.Add(' LEFT JOIN DETELE ON DETELE.AUTOINCREM = MOVTRI.DET_AUTELE ');
    qrySQL.sql.Add(' LEFT JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER');
    qrySQL.sql.Add(' WHERE DIGCON.AUTOINCREM ' + CriarSentencaIN(AListaStrings));
    qrySQL.Open;

    Result := TObjectList<TItemConferencia>.Create(True);  // True para liberar objetos automaticamente

    while not qrySQL.Eof do
    begin

      Result.Add(TItemConferencia.Create(qrySQL.FieldByName('AUTOINCREM').AsString,
                                         qrySQL.FieldByName('SEQGER').AsString,
                                         qrySQL.FieldByName('INCDET').AsString,
                                         qrySQL.FieldByName('DIC_SEQDOR').AsString,
                                         qrySQL.FieldByName('DIC_SEQGER').AsString,
                                         qrySQL.FieldByName('DIC_CODITE').AsString,
                                         qrySQL.FieldByName('DIC_QTDTOT').AsFloat,
                                         qrySQL.FieldByName('DIC_QTDITE').AsFloat,
                                         qrySQL.FieldByName('DIC_QTDDEV').AsFloat,
                                         qrySQL.FieldByName('DIC_QTDLDE').AsFloat,
                                         qrySQL.FieldByName('DTAEMI').AsDateTime));
      qrySQL.Next;
    End;
  Finally
    FreeAndNil(qrySQL);
  end;
end;

procedure TDevolucaoRetornaEstoque.AjustarQuantidadeDevolucao(Quantidades: Double);
var
  QuantidadeRestante: Double;
  Item: TItemConferencia;
begin
  QuantidadeRestante := Quantidades;

  // Itera sobre a lista de itens e ajusta a quantidade de devolução
  for Item in FItens do
  begin
    if QuantidadeRestante > 0 then
    begin
      if Item.FQuantidadeDevolucao >= QuantidadeRestante then
      begin
        // Remove a quantidade correspondente e acumula no total removido do Item
        Item.FQuantidadeDevolucao := Item.FQuantidadeDevolucao - QuantidadeRestante;
        Item.FQuantidadeLiberadoDevolucaoNova := Item.FQuantidadeLiberadoDevolucaoNova + QuantidadeRestante;
        QuantidadeRestante := 0;  // Quantidade totalmente removida
      end
      else
      begin
        // Remove a quantidade total do item e acumula no total removido do Item
        QuantidadeRestante := QuantidadeRestante - Item.FQuantidadeDevolucao;
        Item.FQuantidadeLiberadoDevolucaoNova := Item.FQuantidadeLiberadoDevolucaoNova + Item.FQuantidadeDevolucao;
        Item.FQuantidadeDevolucao := 0;  // Já removeu todo o ajuste
      end;
    end
    else
      Break;  // Sai do loop quando a quantidade restante chega a zero
  end;
end;


procedure TDistribuicaoConferencia.CarregarDadosPorMovGer(const AMovGer: String);
var
  LAutoIncrem: String;
begin
  FQryConsulta.SQL.Clear;
  FQryConsulta.sql.Add(' SELECT CONDIG.* ,');
  FQryConsulta.sql.Add('        MOVDET.DET_SEQGER AS SEQGER,');
  FQryConsulta.sql.Add('        MOVDET.DET_CODITE AS CODITE,');
  FQryConsulta.sql.Add('        MOVDET.AUTOINCREM AS INCDET,');
  FQryConsulta.sql.Add('        MOVDET.DET_QTDITE AS QTDITE,');
  FQryConsulta.sql.Add('        FATDOR.AUTOINCREM AS INCFDO,');
  FQryConsulta.sql.Add('        FATDOR.FDO_SEQGER AS INCFGO,');
  FQryConsulta.sql.Add('        CONGER.AUTOINCREM AS AUTINC,');
  FQryConsulta.sql.Add('        MOVDET.DET_DTAENT AS DTAEMI,');
  FQryConsulta.sql.Add('        GER_CODCON AS CODCON');
  FQryConsulta.sql.Add('   FROM CONDIG');
  FQryConsulta.sql.Add('  INNER JOIN CONGER ON CONGER.AUTOINCREM = CONDIG.DIG_SEQCON');
  FQryConsulta.sql.Add('  INNER JOIN CONDOC ON CONDOC.DOC_SEQCON = CONGER.AUTOINCREM');
  FQryConsulta.sql.Add('  INNER JOIN MOVGER TRASAI ON TRASAI.AUTOINCREM = CONDOC.DOC_SEQGER');
  FQryConsulta.sql.Add('  INNER JOIN CADEMP CLIFIL ON CLIFIL.EMP_CODEMP = TRASAI.GER_CODEMP');
  FQryConsulta.sql.Add('  INNER JOIN MOVGER TRAENT ON TRAENT.GER_CODEMP = CONGER.GER_CODEMP');
  FQryConsulta.sql.Add(' 	                 AND TRAENT.GER_NUMDOC = TRASAI.GER_NUMDOC');
  FQryConsulta.sql.Add(' 	                 AND TRAENT.GER_ESPDOC = TRASAI.GER_ESPDOC');
  FQryConsulta.sql.Add(' 	                 AND TRAENT.GER_CODFOR = CLIFIL.EMP_FORFIL');
  FQryConsulta.sql.Add(' 	                 AND TRAENT.GER_SERIE_ = TRASAI.GER_SERIE_');
  FQryConsulta.sql.Add('  INNER JOIN MOVDET ON MOVDET.DET_SEQGER = TRAENT.AUTOINCREM AND MOVDET.DET_CODITE = DIG_CODITE');
  FQryConsulta.sql.Add('  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
  FQryConsulta.sql.Add('  LEFT JOIN EXTDOR ON EXTDOR.FDO_AUTDET = MOVTRI.DET_SEQGER ');
  FQryConsulta.sql.Add('  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
  FQryConsulta.sql.Add('  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM =  FATDOR.FDO_SEQGER ');
  FQryConsulta.sql.Add('  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO =  FATGOR.AUTOINCREM ');
  FQryConsulta.sql.Add('  WHERE TRAENT.AUTOINCREM = ' + AMovGer.QuotedString);
  FQryConsulta.Open;


  Try
    if Not FQryConsulta.IsEmpty then
    begin
      LAutoIncrem := FQryConsulta.FieldByName('AUTINC').AsString;

      while not FQryConsulta.Eof do
      begin
        ItemAgrupadoManager.AdicionarItem(FQryConsulta.FieldByName('CODITE').AsString,
          FQryConsulta.FieldByName('QTDITE').AsFloat);

        AdicionarItemReserva(
          FQryConsulta.FieldByName('SEQGER').AsString,
          FQryConsulta.FieldByName('INCDET').AsString,
          FQryConsulta.FieldByName('INCFDO').AsString,
          FQryConsulta.FieldByName('INCFGO').AsString,
          FQryConsulta.FieldByName('CODITE').AsString,
          FQryConsulta.FieldByName('QTDITE').AsFloat,
          FQryConsulta.FieldByName('DTAEMI').AsDateTime);

        if not FQryConsulta.FieldByName('INCFGO').IsNull then
          FListaSeqFatGor.Add(FQryConsulta.FieldByName('INCFGO').AsString);

        FQryConsulta.Next;
      end;

      CarregarDadosConDig(LAutoIncrem);
    end;
  finally
    FQryConsulta.Close;
  end;

  //Log
//  pGeraLog;
end;

procedure TDistribuicaoConferencia.CarregarDadosConDig(const ASeqGer: string);
begin
  Try
    FQryConsulta.SQL.Clear;
    FQryConsulta.SQL.Add('SELECT DIG_CODITE, SUM(IFNULL(DIG_QTDITE, 0)) DIG_QTDITE');
    FQryConsulta.SQL.Add('FROM CONDOC');
    FQryConsulta.SQL.Add('JOIN CONGER ON CONGER.AUTOINCREM = CONDOC.DOC_SEQCON');
    FQryConsulta.SQL.Add('JOIN CONDIG ON CONDIG.DIG_SEQCON = CONGER.AUTOINCREM');
    FQryConsulta.SQL.Add('WHERE CONDOC.DOC_SEQGER = :SEQGER');
    FQryConsulta.SQL.Add('GROUP BY DIG_CODITE');
    FQryConsulta.ParamByName('SEQGER').AsString := ASeqGer;
    FQryConsulta.Open;

    While not FQryConsulta.Eof Do
    Begin
      ConferirItem(
        FQryConsulta.FieldByName('DIG_CODITE').AsString,
        FQryConsulta.FieldByName('DIG_QTDITE').AsFloat);
      FQryConsulta.Next;
    End;
  Finally
    FQryConsulta.Close;
  End;
end;


class function TDistribuicaoConferencia.fGerarDigConEntradaSimplificada(const AstrAutIncPed: string): Boolean;
Var
  LobjDistribuicaoConferencia: TDistribuicaoConferencia;
Begin
  Result := True;
  If Not TDistribuicaoConferencia.ReservaTemDigCon(AstrAutIncPed) then
  begin
    LobjDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorFatGorEntradaSimplificada(AstrAutIncPed);
    Try
      LobjDistribuicaoConferencia.fGravaLiberacaoEnderecamento;
      Result := LobjDistribuicaoConferencia.fFinalizaConferencia;
    Finally
      pFreeAndNil(LobjDistribuicaoConferencia);
    End;
  End;
End;

end.

