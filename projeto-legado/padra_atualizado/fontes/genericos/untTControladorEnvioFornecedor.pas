unit untTControladorEnvioFornecedor;

interface

uses
  DB,
  UNI,
  System.SysUtils,
  System.Generics.Collections,
  untTypesSistema,
  UniClientDataSet;

Type
  EControleDevolucaoFornecedor = Class(Exception)
  private
    FLocal: String;
  public
    constructor Create(const Msg: string; pLocal: String);
    procedure pExibirMensagem;
    property Local: String Read FLocal;
  end;

  //prototipagem
  TControladorEnvioFornecedor = Class;
  TControladorEnvioFornecedorItem = Class;
  TDocEntradaGarantia = Class;
  TDocEntradaItem = Class;
  TGarantiaItem = Class;

  //listas
  TListaGarantiaItem = TObjectList<TGarantiaItem>;
  TListaDocEntradaItem = TObjectList<TDocEntradaItem>;

  TListaDocEntradaGarantia = class(TObjectList<TDocEntradaGarantia>)
  public
    function fIndexOf(pDocEntradaItem: TDocEntradaItem; pGarantiaItem: TGarantiaItem): Integer;
    procedure pAdicionar(pDocEntradaGarantia: TDocEntradaGarantia);
    procedure pRemover(pDocEntradaGarantia: TDocEntradaGarantia);
  end;

  TListaControladorEnvioFornecedorItem = Class(TObjectList<TControladorEnvioFornecedorItem>)
  public
    function fIndexOfCodIte(const pstrCodIte: String): Integer;
  end;

  TItemEnvio = Class
  strict protected
    FOwner: TControladorEnvioFornecedorItem;
    FstrAutInc: String;
  public
    constructor Create(pOwner: TControladorEnvioFornecedorItem; pstrAutInc: String);overload;
    Destructor Destroy;override;
    property strAutInc: String Read FstrAutInc;
  end;

  TGarantiaItem = Class(TItemEnvio)
  strict private
    //quantidade selecionada do item para enviar ao fornecedor.
    FfltQtdDev: Double;
  public
    function fTotalDocumento: Double;
    function fTotalSemDocumento: Double;
    function fTemDocEntrada: Boolean;
    property fltQtdDev: Double Read FfltQtdDev Write FfltQtdDev;
  end;

  TDocEntradaItem = Class(TItemEnvio)
  strict private
    FstrCodFor,
    FstrNumDoc,
    FstrEspDoc,
    FstrCodEmp,
    FstrCodIte,
    FstrSerie_,
    FstrRefere,
    FstrDesIte,
    FstrAcesso,
    FstrOrdIte: String;
    FfltQtdIte, //Quantidade documento entrada
    FfltQtdDev, //quantidade total já devolvida
    FfltUnitar,
    FfltAlqIpi: Double;

  public
    constructor Create(pOwner: TControladorEnvioFornecedorItem;
                       const pstrAutInc,
                             pstrCodEmp,
                             pstrCodFor,
                             pstrEspDoc,
                             pstrSerie_,
                             pstrNumDoc,
                             pstrCodIte,
                             pstrDesIte,
                             pstrRefere,
                             pstrAcesso,
                             pstrOrdIte: String;
                       const pfltUnitar,
                             pfltAlqIpi,
                             pfltQtdIte,
                             pfltQtdDev: Double);overload;
    function fQuantidadeReservada: Double;
    function fSaldoDisponivel: Double;
    property strCodFor: String Read FstrCodFor;
    property strNumDoc: String Read FstrNumDoc;
    property strEspDoc: String Read FstrEspDoc;
    property strCodEmp: String Read FstrCodEmp;
    property strCodIte: String Read FstrCodIte;
    property strSerie_: String Read FstrSerie_;
    property strRefere: String Read FstrRefere;
    property strDesIte: String Read FstrDesIte;
    property strAcesso: String Read FstrAcesso;
    property fltQtdIte: Double Read FfltQtdIte;
    property fltQtdDev: Double Read FfltQtdDev;
    property fltUnitar: Double Read FfltUnitar;
    property fltAlqIpi: Double Read FfltAlqIpi;
    property strOrdIte: String Read FstrOrdIte;
  end;

  {TdocEntradaGarantia é associação entre item do documento de entrada e a garantia selecionada}
  TDocEntradaGarantia = Class
  Strict private
    FDocEntradaItem: TDocEntradaItem;
    FGarantiaItem: TGarantiaItem;
    FQuantidade: Double;
  public
    constructor Create(pDocEntradaItem: TDocEntradaItem;
                       pGarantiaItem: TGarantiaItem);
    destructor Destroy;override;
    property DocEntradaItem: TDocEntradaItem Read FDocEntradaItem;
    property GarantiaItem: TGarantiaItem Read FGarantiaItem;
    property Quantidade: Double Read FQuantidade Write FQuantidade;
  end;

  TMALocalizarDocEntradaGarantia = reference to procedure(pDocEntradaGarantia: TDocEntradaGarantia; Out pblnEncontrou: Boolean);

  TControladorEnvioFornecedorItem = Class
  strict private
    FOwner: TControladorEnvioFornecedor;
    FCodIte: String;
    FListaDocEntradaGarantia: TListaDocEntradaGarantia;
    FListaDocEntradaItem: TListaDocEntradaItem;
    FListaGarantiaItem: TListaGarantiaItem;
    function fGetDocEntradaItem(const Index: Integer): TDocEntradaItem;overload;
    function fGetGarantiaItem(const Index: integer): TGarantiaItem;
    function fGetGarantiaItemAutInc(const pstrIncGad: String): TGarantiaItem;
    function fGetDocEntradaGarantia(const pstrIncGad: String): TDocEntradaGarantia;
    function fGetDocEntradaGarantiaIncDet(const pstrIncDet: String):TDocEntradaGarantia;
    function fGetDocEntradaGarantiaDeValorUnitario(const pfltUnitar: Double): TDocEntradaGarantia;
    function fGetDocEntradaGarantiaDeIndice(const Index: Integer): TDocEntradaGarantia;
    function fLocalizarDocEntradaGarantia(pMALocalizarDocEntradaGarantia: TMALocalizarDocEntradaGarantia): TDocEntradaGarantia;
  public
    blnValidarQtdDevolvidaDocumento: Boolean;
    dtaDtaIni: TDate;
    dtaDtaFim: TDate;
    constructor Create(const pOwner: TControladorEnvioFornecedor;
                       const pstrCodIte: String);
    destructor Destroy;override;

    procedure pAdicionarDocEntradaItem(const pstrAutInc,
                                             pstrCodEmp,
                                             pstrCodFor,
                                             pstrEspDoc,
                                             pstrSerie_,
                                             pstrNumDoc,
                                             pstrCodite,
                                             pstrDesIte,
                                             pstrRefere,
                                             pstrAcesso,
                                             pstrOrdIte: String;
                                       const pfltQtdIte,
                                             pfltQtdDev,
                                             pfltUnitar,
                                             pfltAlqIPI: double);overload;
    procedure pAdicionarGarantiaItem(const pstrAutInc: String;
                                           pfltQtdSel: Double);
    function fContarDocEntrada: Integer;
    function fContarDocEntradaGarantia: Integer;
    function fContarGarantiaItem: Integer;
    function fGetDocEntradaItem(const pstrIncDet: String): TDocEntradaItem;overload;
    function fIndexOfAutoIncremDocEntradaItem(const pstrAutInc: String): Integer;

    function fObterDocEntradaGarantia(const pstrIncDet,
                                            pstrIncGad: String): TDocEntradaGarantia;
    procedure pLimpar;
    procedure pReservarItemGarantia(pDocEntradaItem: TDocEntradaItem;
                                    pGarantiaItem: TGarantiaItem;
                                    pfltQtdDev: Double);overload;

    procedure pRemoverGarantia(const pstrIncGad: String);
    procedure pRemoverDocEntradaGantia(pDocEntradaGarantia: TDocEntradaGarantia);
    procedure pRemoverDocEntradaItemNaoSelecionado;
    function fTemDocumentoVenda: Boolean;
    function fDocumentoComSaldo(const pfltQtdIte: Double): TDocEntradaItem;
    procedure pTrimExcess;
    property strCodIte: String Read FcodIte;
    property DocEntradaItem[const Index: Integer]: TDocEntradaItem Read fGetDocEntradaItem;
    property DocEntradaGarantia[const pstrIncGad: String]: TDocEntradaGarantia Read fGetDocEntradaGarantia;
    property DocEntradaGarantiaDeIncDet[const pstrIncDet: String]: TDocEntradaGarantia Read fGetDocEntradaGarantiaIncDet;
    property DocEntradaGarantiaDeIndice[const Index: Integer]: TDocEntradaGarantia Read fGetDocEntradaGarantiaDeIndice;
    property DocEntradaGarantiaDeValorUnitario[const pfltUnitar: Double]: TDocEntradaGarantia Read fGetDocEntradaGarantiaDeValorUnitario;
    property GarantiaItem[const Index: Integer]: TGarantiaItem Read fGetGarantiaItem;
    property GarantiaItemAutInc[const pIncGad: String]: TGarantiaItem Read fGetGarantiaItemAutInc;

  end;

  TControladorEnvioFornecedor = Class
  private
    FControladorEnvioItemSelecionado: TControladorEnvioFornecedorItem;
    FGarantiaItemSelecionado: TGarantiaItem;
    FLista: TListaControladorEnvioFornecedorItem;
    FCodFor: String;

    procedure pAplicarSaldosDataSet(const pstrCodIte,
                                          pstrIncGad: String;
                                          pcdsDocSel: TUniClientDataSet);

    function fGetControladorEnvioFornecedorItem(const pStrCodIte: String;
                                                      pblnCriar: Boolean = False): TControladorEnvioFornecedorItem;
    function fGetItem(const pIndex: Integer): TControladorEnvioFornecedorItem;
    function fGetItemDeCodigo(const pstrCodIte: String): TControladorEnvioFornecedorItem;
    procedure pPrepararParaSelecao(const pstrCodIte,
                                         pstrIncGad: String;
                                   const pfltQtdSel: Double);
    function fAutoSelecaoDocumentoComSaldoDisponivel: Boolean;overload;
  public
    blnEmpGar,
    blnGarMat,
    blnEfvApr,
    blnGFSDoc,
    blnValidarQtdDevolvidaDocumento: Boolean;
    intDecUni: Integer;
    constructor Create(const pstrCodFor: String);
    destructor Destroy;override;
    procedure pAdicionarItem(const pstrCodIte,
                                   pstrIncGad: String;
                             const pfltQtdSel: Double);

    procedure pAdicionarDocEntradaItem(const pstrAutInc,
                                             pstrCodEmp,
                                             pstrCodFor,
                                             pstrEspDoc,
                                             pstrSerie_,
                                             pstrNumDoc,
                                             pstrCodite,
                                             pstrDesIte,
                                             pstrRefere,
                                             pstrAcesso,
                                             pstrOrdIte: String;
                                       const pfltQtdIte,
                                             pfltQtdDev,
                                             pfltUnitar,
                                             pfltAlqIPI: double);overload;

    function fAutoSelecaoDocumentoComSaldoDisponivel(const pstrCodIte,
                                                           pstrIncGad: String;
                                                     const pfltQtdSel: Double): Boolean;overload;

    function fCarregarDocEnt(const pstrCodIte,
                                   pstrIncGad,
                                   pstrNumGar: String;
                             const pfltQtdSel: Double;
                             const pdtaDtaIni,
                                   pdtaDtaFim: TDate;
                             const penuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia;
                             const pblnPermitirInfChave: Boolean): Boolean;
    function fContar: Integer;
    procedure pRemoverGarantia(const pstrCodIte,
                                     pstrIncGad: String);
    procedure pcdsValidarQtdIte(Sender: TField);
    procedure pSelecionarItem(pControladorEnvioFornecedorItem: TControladorEnvioFornecedorItem);
    function fTemGarantiaSemDocumentoDeVenda: Boolean;
    property Item[const Index: Integer]: TControladorEnvioFornecedorItem Read fGetItem;
    property ItemDecodigo[const pstrCodIte: String]: TControladorEnvioFornecedorItem Read fGetItemDeCodigo;
    property ItemSelecionado: TControladorEnvioFornecedorItem Read FControladorEnvioItemSelecionado;
    property GarantiaItemSelecionado: TGarantiaItem Read FGarantiaItemSelecionado;

  end;

implementation

uses
  untZClient,
  Vcl.Controls,
  untGarantiaEnvFornecedorSelNE,
  untFuncoesSimples,
  untGarant;

{ TControladorEnvioFornecedorItem }

constructor TControladorEnvioFornecedorItem.Create(const pOwner: TControladorEnvioFornecedor;
                                                   const pstrCodIte: String);

begin
  FOwner := pOwner;
  FCodIte := pstrCodIte;
  FListaDocEntradaItem := TListaDocEntradaItem.Create;
  FListaGarantiaItem := TListaGarantiaItem.Create;
  FListaDocEntradaGarantia := TListaDocEntradaGarantia.Create;
end;

destructor TControladorEnvioFornecedorItem.Destroy;
begin

  if Assigned(FlistaDocEntradaItem) then
  begin
    FListaDocEntradaItem.Clear;
    FreeAndNil(FlistaDocEntradaItem);
  end;

  if Assigned(FListaGarantiaItem) then
  begin
    FListaGarantiaItem.Clear;
    FreeAndNil(FListaGarantiaItem);
  end;

  if Assigned(FListaDocEntradaGarantia) then
  begin
    FListaDocEntradaGarantia.Clear;
    FreeAndNil(FListaDocEntradaGarantia);
  end;

  inherited;
end;

function TControladorEnvioFornecedorItem.fContarDocEntrada: Integer;
begin
  Result := Self.FListaDocEntradaItem.Count;
end;

function TControladorEnvioFornecedorItem.fContarDocEntradaGarantia: Integer;
begin
  Result := Self.FListaDocEntradaGarantia.Count;
end;

function TControladorEnvioFornecedorItem.fContarGarantiaItem: Integer;
begin
  Result := FListaGarantiaItem.count;
end;

function TControladorEnvioFornecedorItem.fDocumentoComSaldo(const pfltQtdIte: Double): TDocEntradaItem;
Var
  i: Integer;
begin
  Result := Nil;

  for i := fContarDocEntrada -1 downto 0 do
  begin
    if FListaDocEntradaItem[i].fSaldoDisponivel >= pfltQtdIte then
    begin
      Result := FListaDocEntradaItem[i];
      Break;
    end;
  end;
end;

function TControladorEnvioFornecedorItem.fGetDocEntradaGarantia(const pstrIncGad: String): TDocEntradaGarantia;
begin
  Result :=
    Self.
      fLocalizarDocEntradaGarantia(
        procedure(pDocEntradaGarantia: TDocEntradaGarantia; Out pblnEncontrado: Boolean)
        begin
          pblnEncontrado := pDocEntradaGarantia.GarantiaItem.strAutInc = pstrIncGad;
        end);
end;

function TControladorEnvioFornecedorItem.fGetDocEntradaGarantiaDeValorUnitario(const pfltUnitar: Double): TDocEntradaGarantia;
begin
  Result :=
    Self.
      fLocalizarDocEntradaGarantia(
        procedure(pDocEntradaGarantia: TDocEntradaGarantia; Out pblnEncontrado: Boolean)
        begin
          pblnEncontrado := pDocEntradaGarantia.DocEntradaItem.fltUnitar = pfltUnitar;
        end);
end;

function TControladorEnvioFornecedorItem.fGetDocEntradaGarantiaIncDet(
  const pstrIncDet: String): TDocEntradaGarantia;
begin
  Result :=
    Self.
      fLocalizarDocEntradaGarantia(
        procedure(pDocEntradaGarantia: TDocEntradaGarantia; Out pblnEncontrado: Boolean)
        begin
          pblnEncontrado := pDocEntradaGarantia.DocEntradaItem.strAutInc = pstrIncDet;
        end);
end;

function TControladorEnvioFornecedorItem.fGetDocEntradaItem(
  const Index: Integer): TDocEntradaItem;
begin
  if (Index < 0) Or (Index > (FListaDocEntradaItem.Count -1)) then
   raise EControleDevolucaoFornecedor.Create('Índice inválido.', 'TControladorEnvioFornecedorItem.fGetDocEntradaItem');
  Result := FListaDocEntradaItem[Index];
end;

function TControladorEnvioFornecedorItem.fGetDocEntradaItem(const pstrIncDet: String): TDocEntradaItem;
Var
  i: integer;
begin
  Result := Nil;
  for i := 0 to (FListaDocEntradaItem.count -1) do
  begin
    if FListaDocEntradaItem[i].strAutInc = pstrIncDet then
    begin
      Result := FListaDocEntradaItem[i];
      Break;
    end;
  end;
end;

function TControladorEnvioFornecedorItem.fGetGarantiaItem(const Index: integer): TGarantiaItem;
begin
  if (Index < 0) Or (Index > (FListaGarantiaItem.Count -1)) then
   raise EControleDevolucaoFornecedor.Create('Índice inválido.', 'TControladorEnvioFornecedorItem.fGetGarantiaItem');
  Result := FListaGarantiaItem[Index];
end;


function TControladorEnvioFornecedorItem.fGetGarantiaItemAutInc(const pstrIncGad: String): TGarantiaItem;
Var
  i: Integer;
begin
  Result := Nil;
  For i := 0 to FListaGarantiaItem.Count -1 do
  begin
    if FListaGarantiaItem[i].strAutInc = pstrIncGad then
    begin
      Result := FListaGarantiaItem[i];
      Break;
    end;
  end;

end;

function TControladorEnvioFornecedorItem.fGetDocEntradaGarantiaDeIndice(const Index: Integer): TDocEntradaGarantia;
begin
  if (Index < 0) Or (Index > (FListaDocEntradaGarantia.Count -1)) then
    raise EControleDevolucaoFornecedor.Create('Índice inválido.','TControladorEnvioFornecedorItem.fGetDocEntraGarantia');
  Result := FListaDocEntradaGarantia[Index];
end;

function TControladorEnvioFornecedorItem.fIndexOfAutoIncremDocEntradaItem(
  const pstrAutInc: String): Integer;
Var
  i: integer;
begin
  Result := -1;
  If FListaDocEntradaItem.Count = 0 then
    Exit;
  for i := 0 to  FListaDocEntradaItem.Count -1 do
  begin
    if FListaDocEntradaItem[i].strAutInc = pstrAutInc then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TControladorEnvioFornecedorItem.fLocalizarDocEntradaGarantia(pMALocalizarDocEntradaGarantia: TMALocalizarDocEntradaGarantia): TDocEntradaGarantia;
Var
  i: integer;
  lDocEntradaGarantia: TDocEntradaGarantia;
  lblnEncontrado: Boolean;
begin
  Result := Nil;
  if FListaDocEntradaGarantia.count = 0 then
    Exit;

  if Not Assigned(pMALocalizarDocEntradaGarantia) then
    Exit;

  For I := 0 to FListaDocEntradaGarantia.Count -1 do
  begin
    lblnEncontrado := False;
    lDocEntradaGarantia := Self.DocEntradaGarantiaDeIndice[i];
    pMALocalizarDocEntradaGarantia(lDocEntradaGarantia, lblnEncontrado);
    if lblnEncontrado then
    begin
      Result := lDocEntradaGarantia;
      Break;
    end;
  end;
end;

function TControladorEnvioFornecedorItem.fObterDocEntradaGarantia(const pstrIncDet,
                                                                        pstrIncGad: String): TDocEntradaGarantia;
begin
  Result :=
    Self.
      fLocalizarDocEntradaGarantia(
        procedure(pDocEntradaGarantia: TDocEntradaGarantia; Out pblnEncontrado: Boolean)
        Var
          lblnGarantia,
          lblnDocEntrada: Boolean;
        begin
          pblnEncontrado := False;
          lblnGarantia := False;
          lblnDocEntrada := False;
          if Assigned(pDocEntradaGarantia.GarantiaItem) then
          begin
            lblnGarantia := pDocEntradaGarantia.GarantiaItem.strAutInc = pstrIncGad;
          end;

          if fEmptyStr(pstrIncDet) then
            lblnDocEntrada := pDocEntradaGarantia.DocEntradaItem = Nil
          else
          begin
            if Not (pDocEntradaGarantia.DocEntradaItem = Nil) then
              lblnDocEntrada := pDocEntradaGarantia.DocEntradaItem.strAutInc = pstrIncDet;
          end;
          pblnEncontrado := lblnGarantia And lblnDocEntrada;
        end);
end;

function TControladorEnvioFornecedorItem.fTemDocumentoVenda: Boolean;
begin
  Result := FListaDocEntradaGarantia.Count > 0;
end;

procedure TControladorEnvioFornecedorItem.pAdicionarDocEntradaItem(const pstrAutInc,
                                                                         pstrCodEmp,
                                                                         pstrCodFor,
                                                                         pstrEspDoc,
                                                                         pstrSerie_,
                                                                         pstrNumDoc,
                                                                         pstrCodite,
                                                                         pstrDesIte,
                                                                         pstrRefere,
                                                                         pstrAcesso,
                                                                         pstrOrdIte: String;
                                                                   const pfltQtdIte,
                                                                         pfltQtdDev,
                                                                         pfltUnitar,
                                                                         pfltAlqIPI: double);
Var
  i: Integer;
  lDocEntradaItem: TDocEntradaItem;
begin
  i := fIndexOfAutoIncremDocEntradaItem(pstrAutInc);
  if i >=0 then
    Exit;

  lDocEntradaItem := TDocEntradaItem.Create(Self,
                                            pstrAutInc,
                                            pstrCodEmp,
                                            pstrCodFor,
                                            pstrEspDoc,
                                            pstrSerie_,
                                            pstrNumDoc,
                                            pstrCodIte,
                                            pstrDesIte,
                                            pstrRefere,
                                            pstrAcesso,
                                            pstrOrdIte,
                                            pfltUnitar,
                                            pfltAlqIPI,
                                            pfltQtdIte,
                                            pfltQtdDev);

  FListaDocEntradaItem.Add(lDocEntradaItem);
end;

procedure TControladorEnvioFornecedorItem.pAdicionarGarantiaItem(const pstrAutInc: String;
                                                                       pfltQtdSel: Double);
Var
  lGarantiaItem: TGarantiaItem;
  i: Integer;
begin
  lGarantiaItem := Nil;
  for i := 0 to FListaGarantiaItem.Count -1 do
  begin
    if FListaGarantiaItem[i].strAutInc = pstrAutInc then
    begin
      lGarantiaItem := FListaGarantiaItem[i];
      Break;
    end;
  end;

  if lGarantiaItem = Nil then
  begin
    FListaGarantiaItem.Add(TGarantiaItem.Create(Self, pstrAutInc));
    lGarantiaItem := FListaGarantiaItem.Last;
  end;
  lGarantiaItem.fltQtdDev := pfltQtdSel;
end;


procedure TControladorEnvioFornecedorItem.pLimpar;
begin
  if FListaDocEntradaGarantia <> Nil then
    FListaDocEntradaGarantia.Clear;

  if FListaDocEntradaItem <> Nil then
    FListaDocEntradaItem.Clear;

  if FListaGarantiaItem <> Nil then
    FListaGarantiaItem.Clear;
end;

procedure TControladorEnvioFornecedorItem.pRemoverDocEntradaGantia(
  pDocEntradaGarantia: TDocEntradaGarantia);
begin
  Self.FListaDocEntradaGarantia.pRemover(pDocEntradaGarantia);
end;

procedure TControladorEnvioFornecedorItem.pRemoverDocEntradaItemNaoSelecionado;
Var
  lDocEntradaItem: TDocEntradaItem;
  lDocEntradaGarantia: TDocEntradaGarantia;
  lblnRemover: Boolean;
  i, n: Integer;
begin
  If (FListaDocEntradaItem = Nil) or (FListaDocEntradaGarantia = Nil) Then
    Exit;

  if FListaDocEntradaItem.Count = 0 then
    Exit;

  for i := FListaDocEntradaItem.Count -1 downto 0 do
  begin
    lDocEntradaItem := FListaDocEntradaItem[i];
    lblnRemover := True;
    for n := FListaDocEntradaGarantia.count -1 downto 0 do
    begin
      lDocEntradaGarantia := FListaDocEntradaGarantia[n];
      if (lDocEntradaGarantia.DocEntradaItem = lDocEntradaItem) then
      begin
        if (lDocEntradaGarantia.GarantiaItem = Nil) then
          FListaDocEntradaGarantia.pRemover(lDocEntradaGarantia)
        else if lblnRemover then
          lblnRemover := False;
      end;
    end;
    if lblnRemover then
      FListaDocEntradaItem.Remove(lDocEntradaItem);
  end;
end;

procedure TControladorEnvioFornecedorItem.pRemoverGarantia(const pstrIncGad: String);
Var
  lGarantiaItem: TGarantiaItem;
  lDocEntradaGarantia: TDocEntradaGarantia;
  i: Integer;
begin
  lGarantiaItem := fGetGarantiaItemAutInc(pstrIncGad);
  if Assigned(lGarantiaItem) then
  begin
    for i := (FListaDocEntradaGarantia.Count -1) downto 0 do
    begin
      lDocEntradaGarantia := FListaDocEntradaGarantia[i];
      if lDocEntradaGarantia.GarantiaItem = lGarantiaItem then
        FListaDocEntradaGarantia.pRemover(FListaDocEntradaGarantia[i]);
    end;
    FListaGarantiaItem.Remove(lGarantiaItem);
  end;
end;

procedure TControladorEnvioFornecedorItem.pReservarItemGarantia(pDocEntradaItem: TDocEntradaItem; pGarantiaItem: TGarantiaItem;
                                                                pfltQtdDev: Double);
Var
  lDocEntradaGarantia: TDocEntradaGarantia;
  i: Integer;
begin
  i := FListaDocEntradaGarantia.fIndexOf(pDocEntradaItem, pGarantiaItem);
  if i >= 0 then
    lDocEntradaGarantia := FListaDocEntradaGarantia[i]
  else
  begin
    lDocEntradaGarantia := TDocEntradaGarantia.Create(pDocEntradaItem, pGarantiaItem);
    FListaDocEntradaGarantia.pAdicionar(lDocEntradaGarantia);
  end;
  lDocEntradaGarantia.Quantidade := pfltQtdDev;
end;

procedure TControladorEnvioFornecedorItem.pTrimExcess;
begin
  pRemoverDocEntradaItemNaoSelecionado;
  if FListaDocEntradaGarantia <> Nil then
    FListaDocEntradaGarantia.TrimExcess;

  if FListaDocEntradaItem <> Nil then
    FListaDocEntradaItem.TrimExcess;

  if FListaGarantiaItem <> Nil then
    FListaGarantiaItem.TrimExcess;
end;

{ TDocEntradaItem }

constructor TDocEntradaItem.Create(pOwner: TControladorEnvioFornecedorItem;
                                   const pstrAutInc,
                                         pstrCodEmp,
                                         pstrCodFor,
                                         pstrEspDoc,
                                         pstrSerie_,
                                         pstrNumDoc,
                                         pstrCodIte,
                                         pstrDesIte,
                                         pstrRefere,
                                         pstrAcesso,
                                         pstrOrdIte: String;
                                   const pfltUnitar,
                                         pfltAlqIpi,
                                         pfltQtdIte,
                                         pfltQtdDev: Double);



begin
  inherited Create(pOwner, pstrAutInc);
  FstrCodEmp := pstrCodEmp;
  FstrCodFor := pstrCodFor;
  FstrEspDoc := pstrEspDoc;
  FstrSerie_ := pstrSerie_;
  FstrNumDoc := pstrNumDoc;
  FstrCodIte := pstrCodIte;
  FstrDesIte := pstrDesIte;
  FstrRefere := pstrRefere;
  FstrAcesso := pstrAcesso;
  FfltQtdIte := pfltQtdIte;
  FfltQtdDev := pfltQtdDev;
  FfltUnitar := pfltUnitar;
  FfltAlqIpi := pfltAlqIpi;
  FstrOrdIte := pstrOrdIte;
end;



function TDocEntradaItem.fQuantidadeReservada: Double;
Var
  i: Integer;
begin
  Result := 0;

  For i := 0 to (FOwner.fContarDocEntradaGarantia -1) do
  begin
    if FOwner.DocEntradaGarantiaDeIndice[i].DocEntradaItem = Self then
      Result := Result + FOwner.DocEntradaGarantiaDeIndice[i].Quantidade;
  end;
end;

function TDocEntradaItem.fSaldoDisponivel: Double;
begin
  Result := FfltQtdIte - FfltQtdDev - Self.fQuantidadeReservada;
end;

{ EControleDevolucaoFornecedor }

constructor EControleDevolucaoFornecedor.Create(const Msg: string; pLocal: String);
begin
  inherited Create(Msg);
  FLocal := pLocal;
end;

procedure EControleDevolucaoFornecedor.pExibirMensagem;
begin
  pMensagemOk(Self.Message);
end;

{ TGarantiaItem }

function TGarantiaItem.fTemDocEntrada: Boolean;
Var
  i: Integer;
  lDocEntradaGarantia: TDocEntradaGarantia;
begin
  Result := False;
  for i := 0 to (FOwner.fContarDocEntradaGarantia -1) do
  begin
    lDocEntradaGarantia := FOwner.DocEntradaGarantiaDeIndice[i];
    if (lDocEntradaGarantia.GarantiaItem = Self)
         And (lDocEntradaGarantia.DocEntradaItem <> Nil) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TGarantiaItem.fTotalDocumento: Double;
Var
  i: Integer;
begin
  Result := 0;
  for i := 0 to (FOwner.fContarDocEntradaGarantia -1) do
  begin
    if FOwner.DocEntradaGarantiaDeIndice[i].GarantiaItem = Self then
      Result := Result + FOwner.DocEntradaGarantiaDeIndice[i].Quantidade;
  end;
end;

function TGarantiaItem.fTotalSemDocumento: Double;
begin
  Result := FfltQtdDev - fTotalDocumento;
end;


{ TDocEntradaGarantia }

constructor TDocEntradaGarantia.Create(pDocEntradaItem: TDocEntradaItem;
  pGarantiaItem: TGarantiaItem);
begin
  FDocEntradaItem := pDocEntradaItem;
  FGarantiaItem := pGarantiaItem;
  Quantidade := 0;
end;

destructor TDocEntradaGarantia.Destroy;
begin
  FDocEntradaItem := Nil;
  FGarantiaItem := Nil;
  inherited;
end;

{ TListaDocEntradaGarantia }

function TListaDocEntradaGarantia.fIndexOf(pDocEntradaItem: TDocEntradaItem;
  pGarantiaItem: TGarantiaItem): Integer;
Var
  i: Integer;
begin
  Result := -1;
  For i := 0 to Self.count -1 do
  begin
    if (Self.Items[i].DocEntradaItem = pDocEntradaItem)
       And (Self.Items[i].GarantiaItem = pGarantiaItem) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TListaDocEntradaGarantia.pAdicionar(pDocEntradaGarantia: TDocEntradaGarantia);
begin
  if IndexOf(pDocEntradaGarantia) = -1 then
    Add(pDocEntradaGarantia);
end;

procedure TListaDocEntradaGarantia.pRemover(pDocEntradaGarantia: TDocEntradaGarantia);
begin
  if IndexOf(pDocEntradaGarantia) >= 0 then
    Self.Remove(pDocEntradaGarantia);
end;


{ TListaControladorEnvioFornecedorItem }

function TListaControladorEnvioFornecedorItem.fIndexOfCodIte(
  const pstrCodIte: String): Integer;
Var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Self.Count -1 do
  begin
    if Items[i].strCodIte = pstrCodIte then
    begin
      Result := i;
      Break;
    end;
  end;
end;

{ TControladorEnvioFornecedor }

constructor TControladorEnvioFornecedor.Create(const pstrCodFor: String);
begin
  FCodFor := pstrcodFor;
  FLista := TListaControladorEnvioFornecedorItem.Create;
end;

destructor TControladorEnvioFornecedor.Destroy;
begin
  FLista.Clear;
  FLista.Free;
  FControladorEnvioItemSelecionado := Nil;
  FGarantiaItemSelecionado := Nil;
  inherited;
end;

function TControladorEnvioFornecedor.fContar: Integer;
begin
  Result := FLista.Count;
end;

function TControladorEnvioFornecedor.fGetControladorEnvioFornecedorItem(const pStrCodIte: String;
                                                                              pblnCriar: Boolean = False): TControladorEnvioFornecedorItem;
Var
  i: Integer;
begin
  Result := Nil;
  i := FLista.fIndexOfCodIte(pstrCodIte);
  if i >= 0 then
    Result := FLista[i]

  else if pblnCriar then
  begin
    FLista.Add(TControladorEnvioFornecedorItem.Create(Self, pstrCodIte));
    Result := FLista.Last;
  end;
end;

function TControladorEnvioFornecedor.fGetItem(const pIndex: Integer): TControladorEnvioFornecedorItem;
begin
  if (pIndex < 0) or (pIndex > (FLista.Count) -1) then
    raise Exception.Create('Índice inválido para lista [TControladorEnvioFornecedor].');
  Result := FLista[pIndex];
end;

function TControladorEnvioFornecedor.fGetItemDeCodigo(const pstrCodIte: String): TControladorEnvioFornecedorItem;
begin
  Result := Self.fGetControladorEnvioFornecedorItem(pstrCodIte)
end;

function TControladorEnvioFornecedor.fTemGarantiaSemDocumentoDeVenda: Boolean;
Var
  i, n: Integer;
begin
  Result := False;
  For i := 0 to FLista.Count -1 do
  begin
    For n := 0 to  FLista[I].fContarGarantiaItem -1 do
    begin
      if FLista[i].GarantiaItem[n].fTotalSemDocumento > 0 then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

end;

procedure TControladorEnvioFornecedor.pAdicionarDocEntradaItem(const pstrAutInc,
                                                                     pstrCodEmp,
                                                                     pstrCodFor,
                                                                     pstrEspDoc,
                                                                     pstrSerie_,
                                                                     pstrNumDoc,
                                                                     pstrCodite,
                                                                     pstrDesIte,
                                                                     pstrRefere,
                                                                     pstrAcesso,
                                                                     pstrOrdIte: String;
                                                               const pfltQtdIte,
                                                                     pfltQtdDev,
                                                                     pfltUnitar,
                                                                     pfltAlqIPI: double);
begin
  Self
    .fGetControladorEnvioFornecedorItem(pstrCodite, True)
      .pAdicionarDocEntradaItem(pstrAutInc,
                                pstrCodEmp,
                                pstrCodFor,
                                pstrEspDoc,
                                pstrSerie_,
                                pstrNumDoc,
                                pstrCodite,
                                pstrDesIte,
                                pstrRefere,
                                pstrAcesso,
                                pstrOrdIte,
                                pfltQtdIte,
                                pfltQtdDev,
                                pfltUnitar,
                                pfltAlqIPI);
end;

procedure TControladorEnvioFornecedor.pAdicionarItem(const pstrCodIte,
                                                           pstrIncGad: String;
                                                     const pfltQtdSel: Double);
begin
  Self
    .fGetControladorEnvioFornecedorItem(pstrCodIte, True)
      .pAdicionarGarantiaItem(pstrIncGad, pfltQtdSel);
end;

procedure TControladorEnvioFornecedor.pAplicarSaldosDataSet(const pstrCodIte,
                                                                  pstrIncGad: String;
                                                                  pcdsDocSel: TUniClientDataSet);
Var
  lDocEntradaGarantia: TDocEntradaGarantia;
  lfltQtdSel: Double;
begin
  if pcdsDocSel = Nil then
    Exit;

  pcdsDocSel.First;
  While Not pcdsDocSel.Eof do
  begin
    lDocEntradaGarantia :=
      FControladorEnvioItemSelecionado.fObterDocEntradaGarantia(pcdsDocSel.FieldByName('AUTOINCREM').AsString,
                                                                pstrIncGad);

    if Assigned(lDocEntradaGarantia) then
      lfltQtdSel := lDocEntradaGarantia.Quantidade
    else
    begin
      lfltQtdSel := 0;
      //Se o documento não foi selecionado para garantia, localizar qualquer registro do documento para pegar os dados.
      lDocEntradaGarantia :=
        FControladorEnvioItemSelecionado.DocEntradaGarantiaDeIncDet[pcdsDocSel.FieldByName('AUTOINCREM').AsString];
    end;

    pcdsDocSel.Edit;
    if lDocEntradaGarantia <> Nil then
    begin
      pcdsDocSel.FieldByName('QTDITE').Asfloat := lfltQtdSel;
      pcdsDocSel.FieldByName('QTDRES').Asfloat := lDocEntradaGarantia.DocEntradaItem.fQuantidadeReservada
                                                   - lfltQtdSel;

      pcdsDocSel.FieldByName('QTDDIS').Asfloat :=  lDocEntradaGarantia.DocEntradaItem.fSaldoDisponivel
                                                   + lfltQtdSel;
    end
    else
    begin
      pcdsDocSel.FieldByName('QTDITE').Asfloat := 0;
      pcdsDocSel.FieldByName('QTDRES').Asfloat := 0;
      pcdsDocSel.FieldByName('QTDDIS').Asfloat := pcdsDocSel.FieldByName('DET_QTDITE').Asfloat
                                                   -  pcdsDocSel.FieldByName('QTDDEV').Asfloat
                                                     - pcdsDocSel.FieldByName('QTDRES').Asfloat;
    end;
    pcdsDocSel.post;
    pcdsDocSel.Next;
  end;
end;

procedure TControladorEnvioFornecedor.pcdsValidarQtdIte(Sender: TField);
Var
  lQtdSelDoc: Double;
  lDisponivelGarantia: Double;
  lDocEntradaItem: TDocEntradaItem;
  lDocEntradaGarantia: TDocEntradaGarantia;
  lcdsDocEnt: TDataSet;
begin
  if Sender.AsFloat < 0 then
  begin
    pMensagemOk('A quantidade não pode ser negativa!');
    abort;
  end;

  lcdsDocEnt := Sender.DataSet;
  lQtdSelDoc := 0;
  lDocEntradaGarantia := FControladorEnvioItemSelecionado.fObterDocEntradaGarantia(lcdsDocEnt.FieldByName('AUTOINCREM').AsString,
                                                                                   FGarantiaItemSelecionado.strAutInc);

  if (lDocEntradaGarantia <> Nil) then
    lQtdSelDoc := lDocEntradaGarantia.Quantidade;


  if Sender.AsFloat > 0 then
  begin
    lDisponivelGarantia := (FGarantiaItemSelecionado.fTotalSemDocumento + lQtdSelDoc);
    if (lDisponivelGarantia = 0)then
    begin
      pMensagemOk('A quantidade total já foi selecionada!');
      abort;
    end;

    if Sender.AsFloat > lDisponivelGarantia then
    begin
      pMensagemOk('A quantidade é maior que o total selecionados de todos os documentos!');
      abort;
    end;

    if blnValidarQtdDevolvidaDocumento And (lcdsDocEnt.FieldByName('QTDDIS').AsFloat < Sender.AsFloat) then
    begin
      pMensagemOk('Quantidade não pode ser é maior que disponível!');
      abort;
    end;
  end;


  if lDocEntradaGarantia = Nil then
  begin
    lDocEntradaItem := FControladorEnvioItemSelecionado.fGetDocEntradaItem(lcdsDocEnt.FieldByName('AUTOINCREM').AsString);
    if lDocEntradaItem = Nil then
    begin
      Self.pAdicionarDocEntradaItem(lcdsDocEnt.FieldByName('AUTOINCREM').AsString,
                                    lcdsDocEnt.FieldByName('DET_CODEMP').AsString,
                                    FCodFor,
                                    lcdsDocEnt.FieldByName('DET_ESPDOC').AsString,
                                    lcdsDocEnt.FieldByName('DET_SERIE_').AsString,
                                    lcdsDocEnt.FieldByName('DET_NUMDOC').AsString,
                                    lcdsDocEnt.FieldByName('DET_CODITE').AsString,
                                    lcdsDocEnt.FieldByName('ITE_DESITE').AsString,
                                    lcdsDocEnt.FieldByName('ITE_REFERE').AsString,
                                    lcdsDocEnt.FieldByName('FIS_ACESSO').AsString,
                                    lcdsDocEnt.FieldByName('ORDITE').AsString,
                                    lcdsDocEnt.FieldByName('DET_QTDITE').AsFloat,
                                    lcdsDocEnt.FieldByName('QTDDEV').AsFloat,
                                    lcdsDocEnt.FieldByName('DET_UNITAR').AsFloat,
                                    lcdsDocEnt.FieldByName('DET_ALQIPI').AsFloat);
      lDocEntradaItem := FControladorEnvioItemSelecionado.fGetDocEntradaItem(lcdsDocEnt.FieldByName('AUTOINCREM').AsString);
    end;
    FControladorEnvioItemSelecionado.pReservarItemGarantia(lDocEntradaItem, FGarantiaItemSelecionado, Sender.AsFloat);
  end
  else
  begin
    if Sender.AsFloat <= 0 then
      FControladorEnvioItemSelecionado.pRemoverDocEntradaGantia(lDocEntradaGarantia)
    else
      lDocEntradaGarantia.Quantidade := Sender.AsFloat;
  end;
end;

procedure TControladorEnvioFornecedor.pPrepararParaSelecao(const pstrCodIte,
                                                                 pstrIncGad: String;
                                                           const pfltQtdSel: Double);
begin
  FControladorEnvioItemSelecionado := fGetControladorEnvioFornecedorItem(pstrCodIte, True);
  FGarantiaItemSelecionado := FControladorEnvioItemSelecionado.GarantiaItemAutInc[pstrIncGad];

  if FGarantiaItemSelecionado <> Nil then
  begin
    if FGarantiaItemSelecionado.fltQtdDev <> pfltQtdSel then
    begin
      FControladorEnvioItemSelecionado.pRemoverGarantia(FGarantiaItemSelecionado.strAutInc);
      FGarantiaItemSelecionado := Nil;
    end;
  end;

  if FGarantiaItemSelecionado = Nil then
  begin
    FControladorEnvioItemSelecionado.pAdicionarGarantiaItem(pstrIncGad, pfltQtdSel);
    FGarantiaItemSelecionado := FControladorEnvioItemSelecionado.GarantiaItemAutInc[pstrIncGad];
  end;
end;

function TControladorEnvioFornecedor.fAutoSelecaoDocumentoComSaldoDisponivel: Boolean;
Var
  lDocEntradaItem: TDocEntradaItem;
begin
  Result := False;
  lDocEntradaItem := FControladorEnvioItemSelecionado.fDocumentoComSaldo(FGarantiaItemSelecionado.fltQtdDev);
  if lDocEntradaItem = Nil then
    Exit;

  FControladorEnvioItemSelecionado.pReservarItemGarantia(lDocEntradaItem, FGarantiaItemSelecionado, FGarantiaItemSelecionado.fltQtdDev);
  Result := True;
end;

function TControladorEnvioFornecedor.fAutoSelecaoDocumentoComSaldoDisponivel(const pstrCodIte,
                                                                                   pstrIncGad: String;
                                                                             const pfltQtdSel: Double): Boolean;
begin

  pPrepararParaSelecao(pstrCodIte, pstrIncGad, pfltQtdSel);
  if  Self.fAutoSelecaoDocumentoComSaldoDisponivel then
    Result := True
  else
  begin
    Result := False;
    FControladorEnvioItemSelecionado.pRemoverGarantia(FGarantiaItemSelecionado.strAutInc);
  end;
end;

function TControladorEnvioFornecedor.fCarregarDocEnt(const pstrCodIte,
                                                           pstrIncGad,
                                                           pstrNumGar: String;
                                                     const pfltQtdSel: Double;
                                                     const pdtaDtaIni,
                                                           pdtaDtaFim: TDate;
                                                     const penuTipoEnvioFornecedorGarantia : TTipoEnvioFornecedorGarantia;
                                                     const pblnPermitirInfChave: Boolean): Boolean;
Var
  lcdsDocSel: TZClient;
  lblnSair: Boolean;
begin
  Result := False;
  lcdsDocSel := TZClient.Create(Nil);
  lblnSair := False;
  Try
    //Selecionando o item
    pPrepararParaSelecao(pstrCodIte, pstrIncGad, pfltQtdSel);

    lcdsDocSel.Close;
    lcdsDocSel.qryQuery.Sql.Clear;
    lcdsDocSel.qryQuery.Sql.Add(fGetSqlSelNotas(True, (blnEmpGar and blnGarMat)));
    lcdsDocSel.qryQuery.ParamByName('CODFOR').AsString   := FCodFor;
    lcdsDocSel.qryQuery.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    lcdsDocSel.qryQuery.ParamByName('CODITE').AsString   := pstrCodIte;
    lcdsDocSel.qryQuery.ParamByName('DTAINI').AsDateTime := pdtaDtaIni;
    lcdsDocSel.qryQuery.ParamByName('DTAFIM').AsDateTime := pdtaDtaFim;

    lcdsDocSel.fAbreClient(True, 'TfrmGarantiaEnvFornecedor.pCarregaDocEnt');

    If lcdsDocSel.IsEmpty then
    Begin
      if (blnGFSDOC) or (penuTipoEnvioFornecedorGarantia <> tefDevolucao) then
      begin
        If (fMensagem('', 'Nenhum documento de compra foi encontrado. Para emissão do envio ao Fornecedor será utilizado o preço de custo da Garantia. Deseja continuar?', ['&Sim', '&Não'], 2) = 1) Then
          Result := True;
      end
      else
      begin
        fMensagem('', 'Nenhum documento de compra foi encontrado. Documento de Devolução sem Nota Fiscal de Entrada associada.', ['&Ok']);
      end;
      lblnSair := True;
    End
    else
    begin
      TFloatField(lcdsDocSel.FieldByName('DET_UNITAR')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(lcdsDocSel.FieldByName('DET_ALQIPI')).DisplayFormat := '#,##0.00';

      pAplicarSaldosDataSet(pstrCodIte,
                            pstrIncGad,
                            lcdsDocSel);

      lcdsDocSel.FieldByName('QTDITE').OnValidate := pcdsValidarQtdIte;
      pCriarFormularios(TfrmGarantiaEnvFornecedorSelNE, frmGarantiaEnvFornecedorSelNE);
      frmGarantiaEnvFornecedorSelNE.objControladorEnvioFornecedor := Self;
      frmGarantiaEnvFornecedorSelNE.pAtualizarDadosGarantia(pstrNumGar, pfltQtdSel);
      frmGarantiaEnvFornecedorSelNE.enuTipoEnvioFornecedorGarantia := penuTipoEnvioFornecedorGarantia;
      frmGarantiaEnvFornecedorSelNE.cdsDados := lcdsDocSel;
      frmGarantiaEnvFornecedorSelNE.ShowModal;
      If frmGarantiaEnvFornecedorSelNE.ModalResult = MrOk Then
        Result := True;
    end;

    if (Not lblnSair) And ((Not Result) Or (FGarantiaItemSelecionado.fTotalSemDocumento > 0)) then
    begin
      if (penuTipoEnvioFornecedorGarantia <> tefDevolucao) then
        Result := True
      else if (blnGFSDOC and pblnPermitirInfChave) then
      begin
        If (fMensagem('', 'Há itens sem informar documento de compra. Para emissão do envio ao Fornecedor será utilizado o preço de custo da Garantia. Deseja continuar?', ['&Sim', '&Não'], 2) = 1) Then
        begin
          Result := True;
        end;
      end
    end;
    if Not Result then
      FControladorEnvioItemSelecionado.pRemoverGarantia(FGarantiaItemSelecionado.strAutInc);
  Finally
    FControladorEnvioItemSelecionado.pTrimExcess;
    FControladorEnvioItemSelecionado := Nil;
    FGarantiaItemSelecionado := Nil;
    if Assigned(frmGarantiaEnvFornecedorSelNE) then
      FreeAndNil(frmGarantiaEnvFornecedorSelNE);
    FreeAndNil(lcdsDocSel);
  End;

end;

procedure TControladorEnvioFornecedor.pRemoverGarantia(const pstrCodIte,
                                                             pstrIncGad: String);
Var
  lControladorEnvioFornecedorItem: TControladorEnvioFornecedorItem;
begin
  lControladorEnvioFornecedorItem := fGetControladorEnvioFornecedorItem(pstrCodIte);
  if lControladorEnvioFornecedorItem = Nil then
    Exit;
  lControladorEnvioFornecedorItem.pRemoverGarantia(pstrIncGad);
  lControladorEnvioFornecedorItem.pTrimExcess;
end;

procedure TControladorEnvioFornecedor.pSelecionarItem(
  pControladorEnvioFornecedorItem: TControladorEnvioFornecedorItem);
begin
  FControladorEnvioItemSelecionado := pControladorEnvioFornecedorItem;
  FGarantiaItemSelecionado := Nil;
end;

{ TItemEnvio }

constructor TItemEnvio.Create(pOwner: TControladorEnvioFornecedorItem; pstrAutInc: String);
begin
  FOwner := pOwner;
  FstrAutInc := pstrAutInc;
end;

destructor TItemEnvio.Destroy;
begin
  FOwner := Nil;
  inherited;
end;
end.


