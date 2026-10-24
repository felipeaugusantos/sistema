unit Faturamento.Classes.VendaBaseTrocaRecebimento;

interface

uses
  Classes, Windows, System.Generics.Collections, Uni, untTypesVndBaseTroca,
  untFuncFat, TypesRel, untImpressaoPedidoTrocaRecebimento, untTypesSistema;

Type
  TDocFinPen = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
  End;

  TItemRecebimento = Class;
  TItemRecebido = Class;

  TListaDocPen = Array of TDocFinPen;

  TVendaBaseTrocaRecebimento = Class
  private
    FCodCli: String;
    FNomCli: String;
    FLstIte: TList<TItemRecebimento>;
    FDocRec: String;
    FEspRec: String;
    FEmpRec: String;
    FMotBai: String;
    FObjfatVenda: TFatVenda;
    FTotRec: Double;
    FMsgRet: String;
    FStatus: String;
    FCpfCgc: String;
    FNomFan: String;
    FEhFinaceiroPendente: Boolean;
    FDocumento: String;
    FArrayDocFinPen: TListaDocPen;

    procedure pZeraImpostos;
    function GetLstIte: TList<TItemRecebimento>;
    function fIncluiItensDocumento: Boolean;
    function fRetornaClaFisEntrada(blnDentroEstado: Boolean): String;
    function fGravaDadosDocumentoComRecebimento: Boolean;
    function fGravaDadosDocumentoSemRecebimento: Boolean;
    function fInformarMotivo: Boolean;
    function fVerificaItensSelecionados: Boolean;
    function fAtualizarDocumentoComRecebimento(const strAutInc: String): Boolean;
    function fVerificaPodeRealizarBaixaSemRecebimento: Boolean;
    function fLiberaEmissaoDocumentoAvulso: Boolean;
    function fLiberaEmissaoBaixaSemRecebimento: Boolean;
    function fSQLPendenciaFinanceira: String;

    function GetCodCli: String;
    function GetNomCli: String;
    procedure SetCodCli(const Value: String);
    procedure SetNomCli(const Value: String);
    function GetTotRec: Double;
    function GetDocRec: String;
    function GetEmpRec: String;
    function GetEspRec: String;
    procedure SetDocRec(const Value: String);
    procedure SetEmpRec(const Value: String);
    procedure SetEspRec(const Value: String);
    function GetMsgRet: String;
    function GetObjFatVnd: TFatVenda;
    function GetCpfCgc: String;
    function GetNomFan: String;
    procedure SetCpfCgc(const Value: String);
    procedure SetNomFan(const Value: String);
    function GetEhFinaceiroPendente: Boolean;
    procedure SetEhFinaceiroPendente(const Value: Boolean);
    function fDocumentoNaLista(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pLimpar;
    procedure pCalcularTotais;
    function fCarregarPendencias(const strCodCli: String;
                                 const dtaIni, dtaFim: String;
                                 const strCodEmp: String;
                                 arrCodEmp: TConsultasArray): Boolean;
    function fRetornaItemRecebimento(const strAutInc: String): TItemRecebimento;
    function fAddItem: TItemRecebimento;
    function fEmitirDocumentoRB: Boolean;
    function fRealizarEntradaSemVinculo: Boolean;
    function fRealizarBaixaSemRecebimento: Boolean;
    function fVerificaPodeRealizarBaixaSemVinculo: Boolean;
    function fVerificaItemAvulsoSelecionado: Boolean;
    function fImprimirDocumentoRB: Boolean;
    procedure pCarregarDadosCliente;
    procedure pLimparItens;
    function fCarregarFinanceiroPendente: Boolean;
    function fGravaITERECPendente: Boolean;
    function fGravaCadRecDocumentoPendenteInterno(const strNumDoc, strEspDoc, strEmpDoc, strCodCli: String): Boolean;
    function fGravaCadRecDocumentoPendente: Boolean; overload;
    function fVinculaCadRecVBComPedido(strAutIncPed, strIncCadRec: String): Boolean;
    function fAddDocFinPen(const strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fPossuiUnicoDocumentoPendente: Boolean;
    procedure pImprimeFormularioDoc;

    property strCodCli: String read GetCodCli write SetCodCli;
    property strNomCli: String read GetNomCli write SetNomCli;
    property strDocRec: String read GetDocRec write SetDocRec;
    property strEspRec: String read GetEspRec write SetEspRec;
    property strEmpRec: String read GetEmpRec write SetEmpRec;
    property Itens: TList<TItemRecebimento> read GetLstIte;
    property fltTotRec: Double read GetTotRec;
    property strMensagemRetorno: String read GetMsgRet;
    property objFatVenda: TFatVenda read GetObjFatVnd;
    property strNomFan_Cli: String read GetNomFan write SetNomFan;
    property strCpfCgc_Cli: String read GetCpfCgc write SetCpfCgc;
    property blnEhFinaceiroPendente: Boolean read GetEhFinaceiroPendente write SetEhFinaceiroPendente;
    property DocumentosPendentes: TListaDocPen read FArrayDocFinPen;
  End;

  TItemRecebimento = Class
  [weak]
  private
    FObjRec: TVendaBaseTrocaRecebimento;
    FAutInc: String;
    FDtaEnt: TDateTime;
    FHorEnt: TDateTime;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodIte: String;
    FTotIte: Double;
    FStatus: String;
    FLstPro: TList<TItemRecebido>;
    FTotRec: Double;
    FblnEmi: Boolean;
    FblnAvl: Boolean;
    FDesIte: String;
    FMsgRet: String;
    FLstProBkp: TList<TItemRecebido>;

    function GetAutInc: String;
    function GetCodEmp: String;
    function GetCodIte: String;
    function GetDtaEnt: TDateTime;
    function GetEspDoc: String;
    function GetHorEnt: TDateTime;
    function GetNumDoc: String;
    function GetStatus: String;
    function GetTotIte: Double;
    procedure SetAutInc(const Value: String);
    procedure SetCodEmp(const Value: String);
    procedure SetCodIte(const Value: String);
    procedure SetDtaEnt(const Value: TDateTime);
    procedure SetEspDoc(const Value: String);
    procedure SetHorEnt(const Value: TDateTime);
    procedure SetNumDoc(const Value: String);
    procedure SetStatus(const Value: String);
    procedure SetTotIte(const Value: Double);
    function GetLstPro: TList<TItemRecebido>;
    function GetTotRec: Double;
    function GetVndBasTrc: TVendaBaseTrocaRecebimento;
    function GetblnEmi: Boolean;
    procedure SetblnEmi(const Value: Boolean);
    function GetBlnAvl: Boolean;
    procedure SetbBlnAvl(const Value: Boolean);
    function GetDesIte: String;
    procedure SetDesIte(const Value: String);
    function GetMsgRet: String;
    procedure SetLstProBkp(const Value: TList<TItemRecebido>);
    function GetLstProBkp: TList<TItemRecebido>;
  public
    constructor Create(Owner: TVendaBaseTrocaRecebimento);
    destructor Destroy; override;

    procedure pLimpar;
    procedure pLimparProdutosRecebidos;
    procedure pCalcularTotais;
    function fAddProdutoRecebido: TItemRecebido;
    function fRemoveItem(const strCodIte: String): Boolean;
    function fVerificaPodeIncluirProduto(const strCodIteParam: String): Boolean;

    property strAutInc: String read GetAutInc write SetAutInc;
    property DtaEnt: TDateTime read GetDtaEnt write SetDtaEnt;
    property HorEnt: TDateTime read GetHorEnt write SetHorEnt;
    property strNumDoc: String read GetNumDoc write SetNumDoc;
    property strEspDoc: String read GetEspDoc write SetEspDoc;
    property strCodEmp: String read GetCodEmp write SetCodEmp;
    property strCodIte: String read GetCodIte write SetCodIte;
    property strDesIte: String read GetDesIte write SetDesIte;
    property fltTotIte: Double read GetTotIte write SetTotIte;
    property strStatus: String read GetStatus write SetStatus;
    property Produtos: TList<TItemRecebido> read GetLstPro;
    property fltTotRec: Double read GetTotRec;
    property objVendaBaseTroca: TVendaBaseTrocaRecebimento read GetVndBasTrc;
    property blnEmitirDoc: Boolean read GetblnEmi write SetblnEmi;
    property blnAvulso: Boolean read GetBlnAvl write SetbBlnAvl;
    property strMensagemRetorno: String read GetMsgRet;
    property ProdutosBkp: TList<TItemRecebido> read GetLstProBkp write SetLstProBkp;
  End;

  TItemRecebido= Class
  [weak]
  private
    FObjItem: TItemRecebimento;
    FAutInc: String;
    FCodIte: String;
    FDesIte: String;
    FTipRec: TTipoRecebido;
    FstrTipRec: String;
    FQtdIte: Double;
    FVlrUni: Double;
    FVlrTot: Double;
    FEhAlteracao: Boolean;

    // Dados para Emissao Documento
    FstrDescri: String;
    FstrClaFis: String;
    FstrIteDes: String;
    FstrNumLot: String;
    FstrCodGru: String;
    FstrDesFab: String;
    FstrUnidad: String;
    FstrCodUni: String;
    FstrCodMar: String;
    FstrCodFor: String;
    FstrRefere: String;
    FfltUniOri: Double;
    FfltUniVis: Double;
    FfltUniTar: Double;
    FfltUniDig: Double;
    FfltTotIte: Double;
    FfltPreCus: Double;
    FfltTotCus: Double;
    FstrComLub: String;
    FfltIpiSai: Double;
    FfltDesMax: Double;
    FfltPreVe1: Double;
    FfltPreVe2: Double;
    FfltPreVe3: Double;
    FfltPreVe4: Double;
    FfltPreVe5: Double;
    FfltPreVe6: Double;
    FfltPreVe7: Double;
    FfltSaldos: Double;
    FfltComVar: Double;
    FfltComAta: Double;
    FfltComDis: Double;
    FfltTotUlt: Double;
    FfltImpUlt: Double;
    FfltPreUlt: Double;
    FfltPreMed: Double;
    FstrClaIpi: String;
    FstrCodAbf: String;
    FfltPesoIt: Double;
    FfltPesLiq: Double;
    FstrCodFab: String;
    FfltMarMin: Double;
    FfltMarMSG: Double;
    FfltMarMGe: Double;
    FfltPreCom: Double;
    FfltQtdPon: Double;
    FstrObrCpf: String;
    FstrSigUni: String;
    FfltIpiEnt: Double;
    FfltFreEnt: Double;
    FstrImpDir: String;
    FstrCodBar: String;
    FfltCusIte: Double;
    FfltTotImp: Double;
    FSLEquipamentoArmazem: TStringList;

    function GetAutInc: String;
    function GetCodIte: String;
    function GetDesIte: String;
    function GetQtdIte: Double;
    function GetstrTipRec: String;
    function GetTipRec: TTipoRecebido;
    function GetVlrTot: Double;
    function GetVlrUni: Double;
    function GetEhAlteracao: Boolean;
    procedure SetAutInc(const Value: String);
    procedure SetCodIte(const Value: String);
    procedure SetDesIte(const Value: String);
    procedure SetQtdIte(const Value: Double);
    procedure SetTipRec(const Value: TTipoRecebido);
    procedure SetVlrTot(const Value: Double);
    procedure SetVlrUni(const Value: Double);
    procedure SetEhAlteracao(const Value: Boolean);

    function fRetornaNumLote(const strCodIte: String): String;
  public
    constructor Create(Owner: TItemRecebimento);
    destructor Destroy; override;

    procedure pLimpar;
    procedure pCalcularTotais;
    procedure pCarregarDadosFiscais;
    function fGravarDocumentoRecebido: Boolean;
    function fGravarDocumentoRecebidoPendente: Boolean;
    function fAlteraDocumentoRecebido: Boolean;
    procedure pExcluiDocumentoRecebido;
    class function fstrToTipRec(const strTipRec: String): TTipoRecebido;

    property strAutInc: String read GetAutInc write SetAutInc;
    property strCodIte: String read GetCodIte write SetCodIte;
    property strDesIte: String read GetDesIte write SetDesIte;
    property strTipRec: String read GetstrTipRec;
    property TipRec: TTipoRecebido read GetTipRec write SetTipRec;
    property fltQtdIte: Double read GetQtdIte write SetQtdIte;
    property fltVlrUni: Double read GetVlrUni write SetVlrUni;
    property fltVlrTot: Double read GetVlrTot write SetVlrTot;
    property blnEhAlteracao: Boolean read GetEhAlteracao write SetEhAlteracao;

    property strIteDes: String read FstrIteDes write FstrIteDes;
    property strClaFis: String read FstrClaFis write FstrClaFis;
    property strNumLot: String read FstrNumLot write FstrNumLot;
    property strCodGru: String read FstrCodGru write FstrCodGru;
    property strDesFab: String read FstrDesFab write FstrDesFab;
    property strUnidad: String read FstrUnidad write FstrUnidad;
    property strCodUni: String read FstrCodUni write FstrCodUni;
    property strCodMar: String read FstrCodMar write FstrCodMar;
    property strCodFor: String read FstrCodFor write FstrCodFor;
    property strRefere: String read FstrRefere write FstrRefere;
    property fltUniOri: Double read FfltUniOri write FfltUniOri;
    property fltUniVis: Double read FfltUniVis write FfltUniVis;
    property fltUniTar: Double read FfltUniTar write FfltUniTar;
    property fltTotIte: Double read FfltTotIte write FfltTotIte;
    property fltPreCus: Double read FfltPreCus write FfltPreCus;
    property fltTotCus: DOuble read FfltTotCus write FfltTotCus;
    property strComLub: String read FstrComLub write FstrComLub;
    property fltIpiSai: Double read FfltIpiSai write FfltIpiSai;
    property fltDesMax: Double read FfltDesMax write FfltDesMax;
    property fltPreVe1: Double read FfltPreVe1 write FfltPreVe1;
    property fltPreVe2: Double read FfltPreVe2 write FfltPreVe2;
    property fltPreVe3: Double read FfltPreVe3 write FfltPreVe3;
    property fltPreVe4: Double read FfltPreVe4 write FfltPreVe4;
    property fltPreVe5: Double read FfltPreVe5 write FfltPreVe5;
    property fltPreVe6: Double read FfltPreVe6 write FfltPreVe6;
    property fltPreVe7: Double read FfltPreVe7 write FfltPreVe7;
    property fltSaldos: Double read FfltSaldos write FfltSaldos;
    property fltComVar: Double read FfltComVar write FfltComVar;
    property fltComAta: Double read FfltComAta write FfltComAta;
    property fltComDis: Double read FfltComDis write FfltComDis;
    property fltTotUlt: Double read FfltTotUlt write FfltTotUlt;
    property fltImpUlt: Double read FfltImpUlt write FfltImpUlt;
    property fltPreUlt: Double read FfltPreUlt write FfltPreUlt;
    property fltPreMed: Double read FfltPreMed write FfltPreMed;
    property strClaIpi: String read FstrClaIpi write FstrClaIpi;
    property strCodAbf: String read FstrCodAbf write FstrCodAbf;
    property fltPesoIt: Double read FfltPesoIt write FfltPesoIt;
    property fltPesLiq: Double read FfltPesLiq write FfltPesLiq;
    property strCodFab: String read FstrCodFab write FstrCodFab;
    property fltMarMin: Double read FfltMarMin write FfltMarMin;
    property fltMarMSG: Double read FfltMarMSG write FfltMarMSG;
    property fltMarMGe: Double read FfltMarMGe write FfltMarMGe;
    property fltPreCom: Double read FfltPreCom write FfltPreCom;
    property fltUniDig: Double read FfltUniDig write FfltUniDig;
    property fltQtdPon: Double read FfltQtdPon write FfltQtdPon;
    property strObrCpf: String read FstrObrCpf write FstrObrCpf;
    property strSigUni: String read FstrSigUni write FstrSigUni;
    property fltIpiEnt: Double read FfltIpiEnt write FfltIpiEnt;
    property fltFreEnt: Double read FfltFreEnt write FfltFreEnt;
    property strImpDir: String read FstrImpDir write FstrImpDir;
    property strCodBar: String read FstrCodBar write FstrCodBar;
    property fltCusIte: Double read FfltCusIte write FfltCusIte;
    property fltTotImp: Double read FfltTotImp write FfltTotImp;
  End;

implementation

uses
  untFuncoesSimples, StrUtils, SysUtils, untFuncoesGenerica, untGravando,
  untCadLote, untFuncFatTypes, untConstantes, untInputDialog,
  untLiberacao, untMsgLiberacao, untModulo, untEditorFastImpressao,
  MaskUtils, untCadRec, untFuncoes, untFuncoesConsulta;

{ TVendaBaseTrocaRecebimento }

constructor TVendaBaseTrocaRecebimento.Create;
begin
  FLstIte := TList<TItemRecebimento>.Create;

  pLimpar;
  FEspRec := 'RB';
  FEmpRec := VS_strCodEmp;

  FEhFinaceiroPendente := False;

  FObjfatVenda := TFatVenda.CreateInstance('OE');
  pCriarCdsVenda(nil);

  SetLength(FArrayDocFinPen, 0);
end;

destructor TVendaBaseTrocaRecebimento.Destroy;
begin
  If Assigned(FLstIte) Then
    FreeAndNil(FLstIte);

  If Assigned(FObjfatVenda) Then
    FreeAndNil(FObjfatVenda);

  inherited;
end;

function TVendaBaseTrocaRecebimento.fAddDocFinPen(const strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
var
  intIndice: Integer;
begin
  Result := False;

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  If fEmptyStr(strCodCli) Then
    Exit;

  If fDocumentoNaLista(strNumDoc, strEspDoc,strCodEmp, strCodCli) Then
    Exit;

  intIndice := Length(FArrayDocFinPen);

  SetLength(FArrayDocFinPen, Length(FArrayDocFinPen)+1);
  FArrayDocFinPen[intIndice].strCodCli := strCodCli;
  FArrayDocFinPen[intIndice].strNumDoc := strNumDoc;
  FArrayDocFinPen[intIndice].strEspDoc := strEspDoc;
  FArrayDocFinPen[intIndice].strCodEmp := strCodEmp;

  Result := True;
end;

function TVendaBaseTrocaRecebimento.fAddItem: TItemRecebimento;
var
  intCont: Integer;
begin
  FLstIte.add(TItemRecebimento.Create(Self));
  intCont := FLstIte.Count -1;
  Result  := FLstIte[intCont];
end;

function TVendaBaseTrocaRecebimento.fAtualizarDocumentoComRecebimento(const strAutInc: String): Boolean;
var
  qryUpdate: TUniQuery;
begin

  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE PENREC SET           ');
    qryUpdate.SQL.Add('  PEN_STATUS = :PEN_STATUS ,');
    qryUpdate.SQL.Add('  PEN_DOCREC = :PEN_DOCREC ,');
    qryUpdate.SQL.Add('  PEN_ESPREC = :PEN_ESPREC ,');
    qryUpdate.SQL.Add('  PEN_EMPREC = :PEN_EMPREC  ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM   ');
    qryUpdate.ParamByName('PEN_STATUS').AsString := FStatus;
    qryUpdate.ParamByName('PEN_DOCREC').AsString := FObjfatVenda.strNumDoc;
    qryUpdate.ParamByName('PEN_ESPREC').AsString := FObjfatVenda.strEspDoc;
    qryUpdate.ParamByName('PEN_EMPREC').AsString := FObjfatVenda.strEmpDoc;
    qryUpdate.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryUpdate.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TVendaBaseTrocaRecebimento.fCarregarFinanceiroPendente: Boolean;
var
  qrySelect: TUniQuery;
  itemTmp: TItemRecebimento;
begin
  Result := False;

  FLstIte.Clear;

  qrySelect :=  fCriaQuery();

  Try
    qrySelect.DisableControls;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add(fSQLPendenciaFinanceira);
    qrySelect.Open;

    If qrySelect.IsEmpty Then
      Exit;

    

    While not qrySelect.EOF do
    Begin
      itemTmp := fAddItem;
      itemTmp.strAutInc := qrySelect.FieldByName('AUTOINCREM').AsString;
      itemTmp.DtaEnt    := qrySelect.FieldByName('PEN_DTAENT').AsDateTime;
      itemTmp.HorEnt    := qrySelect.FieldByName('PEN_HORENT').AsDateTime;
      itemTmp.strNumDoc := qrySelect.FieldByName('PEN_NUMDOC').AsString;
      itemTmp.strEspDoc := qrySelect.FieldByName('PEN_ESPDOC').AsString;
      itemTmp.strCodEmp := qrySelect.FieldByName('PEN_CODEMP').AsString;
      itemTmp.strCodIte := qrySelect.FieldByName('PEN_CODITE').AsString;
      itemTmp.fltTotIte := qrySelect.FieldByName('PEN_TOTITE').AsFloat;
      itemTmp.strStatus := qrySelect.FieldByName('PEN_STATUS').AsString;
      itemTmp.strDesIte := qrySelect.FieldByName('ITE_DESITE').AsString;

      qrySelect.Next;
    End;

    pCalcularTotais;
    Result := qrySelect.RecordCount > 0;

  Finally
    FreeAndNil(qrySelect);
  End;
end;

function TVendaBaseTrocaRecebimento.fCarregarPendencias(const strCodCli, dtaIni,
  dtaFim: String; const strCodEmp: String; arrCodEmp: TConsultasArray): Boolean;
var
  qrySelect: TUniQuery;
  itemTmp: TItemRecebimento;
  strCnsCodEmp: String;
begin

  If fEmptyStr(strCodCli) Then
    Exit(False);

  FLstIte.Clear;

  qrySelect :=  fCriaQuery();
  Try
    qrySelect.DisableControls;
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT PENREC.* ,  ');
    qrySelect.SQL.Add('       ITE_DESITE, ');
    qrySelect.SQL.Add('       CLI_NOMCLI  ');
    qrySelect.SQL.Add('FROM PENREC        ');
    qrySelect.SQL.Add('INNER JOIN CADITE ON PEN_CODITE = ITE_CODITE  ');
    qrySelect.SQL.Add('INNER JOIN CADCLI ON PEN_CODCLI = CLI_CODCLI  ');
    qrySelect.SQL.Add('WHERE PEN_STATUS = "P"     ');
    qrySelect.SQL.Add('  AND PEN_CODCLI = :CODCLI ');

    If length(arrCodEmp) > 0 Then
    Begin
      qrySelect.SQL.Add( fStrLocate(Nil, arrCodEmp, 'PEN_CODEMP', 'CODEMP') );
    End
    Else If Not fEmptyStr(strCodEmp) Then
    Begin
      qrySelect.SQL.Add('  AND PEN_CODEMP = :CODEMP ');
    End;

    qrySelect.ParamByName('CODCLI').AsString := strCodCli;

    If ((StrToDateTimeDef(dtaIni, 0) > 0) And (StrToDateTimeDef(dtaFim, 0) > 0)) Then
      qrySelect.SQL.Add('  AND PEN_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

    If ((StrToDateTimeDef(dtaIni, 0) > 0) And (StrToDateTimeDef(dtaFim, 0) > 0)) Then
    Begin
      qrySelect.ParamByName('DTAINI').AsDateTime := StrToDateTimeDef(dtaIni, 0);
      qrySelect.ParamByName('DTAFIN').AsDateTime := StrToDateTimeDef(dtaFim, 0);
    End;

    If length(arrCodEmp) > 0 Then
    Begin
      pSetaParam('', arrCodEmp, strCnsCodEmp, 'CODEMP', qrySelect);
    End
    Else If Not fEmptyStr(strCodEmp) Then
    Begin
      qrySelect.ParamByName('CODEMP').AsString := strCodEmp;
    End;

    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      FCodCli := qrySelect.FieldByName('PEN_CODCLI').AsString;
      FNomCli := qrySelect.FieldByName('CLI_NOMCLI').AsString;
      While Not qrySelect.EOF do
      Begin
        itemTmp := fAddItem;
        itemTmp.strAutInc := qrySelect.FieldByName('AUTOINCREM').AsString;
        itemTmp.DtaEnt    := qrySelect.FieldByName('PEN_DTAENT').AsDateTime;
        itemTmp.HorEnt    := qrySelect.FieldByName('PEN_HORENT').AsDateTime;
        itemTmp.strNumDoc := qrySelect.FieldByName('PEN_NUMDOC').AsString;
        itemTmp.strEspDoc := qrySelect.FieldByName('PEN_ESPDOC').AsString;
        itemTmp.strCodEmp := qrySelect.FieldByName('PEN_CODEMP').AsString;
        itemTmp.strCodIte := qrySelect.FieldByName('PEN_CODITE').AsString;
        itemTmp.fltTotIte := qrySelect.FieldByName('PEN_TOTITE').AsFloat;
        itemTmp.strStatus := qrySelect.FieldByName('PEN_STATUS').AsString;
        itemTmp.strDesIte := qrySelect.FieldByName('ITE_DESITE').AsString;

        qrySelect.Next;
      End;
    End;

    Result := qrySelect.RecordCount > 0;

  Finally
    FreeAndNil(qrySelect);
  End;
end;

function TVendaBaseTrocaRecebimento.fDocumentoNaLista(const strNumDoc,
  strEspDoc, strCodEmp, strCodCli: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt:= 0 To Length(FArrayDocFinPen)-1 Do
  Begin
    If (FArrayDocFinPen[intCnt].strNumDoc = strNumDoc) And
       (FArrayDocFinPen[intCnt].strEspDoc = strEspDoc) And
       (FArrayDocFinPen[intCnt].strCodEmp = strCodEmp) And
       (FArrayDocFinPen[intCnt].strCodCli = strCodCli) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TVendaBaseTrocaRecebimento.fEmitirDocumentoRB: Boolean;
var
  blnTransacaoIniciada: Boolean;
begin
  blnTransacaoIniciada := frmModulo.GetCurrentConnection.InTransaction;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      cdsVenda.EmptyDataSet;

      FObjfatVenda.strOpcDocTrue := 'OE';
      FObjFatVenda.strEspDoc := FEspRec;
      FObjFatVenda.strTipFat := 'Recebimento';
      FObjfatVenda.blnVerEstOrc  := False;
      FObjfatVenda.strNomeForm   := 'frmFatVendas';
      FObjfatVenda.strEspDoc := FEspRec;
      FObjfatVenda.strMen001 := 'Documento de Recebimento Base Troca' ;
      FObjfatVenda.strMen002 := '';
      FObjfatVenda.strOriDoc := 'V';
      FObjfatVenda.strCodVen := strLoginUsuarioLogado;
      FObjfatVenda.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);
      FObjFatVenda.strConPag := '01000';

      FObjFatVenda.fGravaInfoFora := fGravaDadosDocumentoComRecebimento;
      FObjfatVenda.pCarregaDadosClienteBaixa(FCodCli);

      If Not fIncluiItensDocumento() Then
      Begin
        FMsgRet := 'Não foi possível adicionar os itens ao documento.';
        Exit(False);
      End;

      If Not fEmptyStr(FDocumento) Then
      Begin
        Delete(FDocumento,1,2);
        FObjfatVenda.strMen001 := FObjfatVenda.strMen001 + ': ' + FDocumento;
      End;

      FObjFatVenda.pPreencheMatrizFechamento;
      FObjFatVenda.pCalculaPesBruLiq;
      FObjFatVenda.pCalculaTotGer(False, False, Nil, False);
      FObjFatVenda.strDesCla := fRetDesCla(FObjFatVenda.strClaFis);
      pZeraImpostos();
      FObjFatVenda.pRateiaValores;

      If Not blnTransacaoIniciada Then
        fStartTransaction;

      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjFatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Documento...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FDocRec := FObjFatVenda.strNumDoc;
        FEspRec := FObjFatVenda.strEspDoc;
        FEmpRec := FObjFatVenda.strEmpDoc;
      End;

      If (Not blnTransacaoIniciada) And (Result) Then
      Begin
        fCommit;
      End
      Else
      Begin
        If Not blnTransacaoIniciada Then
          fRollBack;
      End;

    Except
      On E: Exception Do
      Begin
        If Not blnTransacaoIniciada Then
          fRollBack;

        pMensagensErro(E.Message, '[TVendaBaseTrocaRecebimento.fEmitirDocumentoRB]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;



function TVendaBaseTrocaRecebimento.fGravaCadRecDocumentoPendente: Boolean;
var
  intCnt: Integer;
Begin
  Result := True;
  For intCnt:= 0 To Length(FArrayDocFinPen)-1 Do
  Begin
    Result := Result And fGravaCadRecDocumentoPendenteInterno(FArrayDocFinPen[intCnt].strNumDoc,
                                                              FArrayDocFinPen[intCnt].strEspDoc,
                                                              FArrayDocFinPen[intCnt].strCodEmp,
                                                              FArrayDocFinPen[intCnt].strCodCli
                                                              );
  End;
End;

function TVendaBaseTrocaRecebimento.fGravaCadRecDocumentoPendenteInterno(
  const strNumDoc, strEspDoc, strEmpDoc, strCodCli: String): Boolean;
var
  strNumDupVB: String;
  strHistorico: String;
  intRcxCon: Integer;
  strAutIncDocPen: String;
  strAutIncCadRec: String;
begin
  strHistorico := 'REFERENTE A ROTINA DE VENDAS A BASE DE TROCA: '+Concat(strNumDoc,'-',strEspDoc,'-',strEmpDoc)+'';
  strNumDupVB := fRetSequencial('SEQVBT', strEmpDoc, fTamDocCadRec);
  intRcxCon := StrToInt(untFuncoes.fRetRcxCon(strEmpDoc));
  strAutIncDocPen := fCampoTabela('AUTOINCREM','FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                                  [strNumDoc,strEspDoc,strEmpDoc,strCodCli],False);

  Result := fGravaCadRec('Faturamento.Classes.VendaBaseTrocaRecebimento',
                         'INCLUSÃO',
                         strNumDupVB,
                         'A',
                         0,
                         'VB',
                         strCodCli,
                         strEmpDoc,
                         fCampoTabela('FGO_CODVEN','FATGOR',['AUTOINCREM'],[strAutIncDocPen],False),
                         fCampoTabela('FGO_CODDIG','FATGOR',['AUTOINCREM'],[strAutIncDocPen],False),
                         fCfgSis('PORCON', varString),
                         fRetDataServidor,
                         fRetDataServidor,
                         FTotRec,
                         FTotRec,
                         0.0,
                         'N',
                         strHistorico,
                         '',
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0,
                         'N',
                         '',
                         '',
                         '',
                         '',
                         False,
                         '',
                         intRcxCon,
                         0,
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         VS_strCodEmp);

  strAutIncCadRec := fCampoTabela('AUTOINCREM','CADREC',['CTR_NUMDUP','CTR_ESPDOC','CTR_CODEMP','CTR_CODCLI'],
                         [strNumDupVB,'VB',strEmpDoc,strCodCli],False);

  Result := Result And fVinculaCadRecVBComPedido(strAutIncDocPen, strAutIncCadRec);
end;

function TVendaBaseTrocaRecebimento.fGravaDadosDocumentoComRecebimento: Boolean;
var
  intCnt,
  intCont: Integer;
begin
  FStatus := 'R';

  For intCont:= 0 To FLstIte.Count-1 Do
  Begin
    If Not FLstIte[intCont].blnEmitirDoc Then
      Continue;

    If Not FLstIte[intCont].blnAvulso Then
    Begin
      If Not blnEhFinaceiroPendente Then
      Begin
        fAtualizarDocumentoComRecebimento(FLstIte[intCont].strAutInc);

        For intCnt:= 0 To FLstIte[intCont].ProdutosBkp.Count-1 Do
        Begin
          if not FLstIte[intCont].Produtos.Contains(FLstIte[intCont].ProdutosBkp[intCnt]) then
            FLstIte[intCont].ProdutosBkp[intCnt].pExcluiDocumentoRecebido;
        End;
      End;


      For intCnt:= 0  To FLstIte[intCont].Produtos.Count-1 Do
      Begin
        If blnEhFinaceiroPendente Then
          FLstIte[intCont].Produtos[intCnt].fGravarDocumentoRecebidoPendente
        Else
        Begin
          If FLstIte[intCont].Produtos[intCnt].blnEhAlteracao Then
            FLstIte[intCont].Produtos[intCnt].fAlteraDocumentoRecebido
          Else
            FLstIte[intCont].Produtos[intCnt].fGravarDocumentoRecebido;
        End;
      End;
    End;
  End;

  Result := True;

  If Not Result Then
    FStatus := 'P';

end;

function TVendaBaseTrocaRecebimento.fGravaDadosDocumentoSemRecebimento: Boolean;
var
  qryUpdate: TUniQuery;
  intCnt: Integer;
begin
  FStatus := 'B';

  qryUpdate := fCriaQuery;
  Try

    For intCnt:= 0 To FLstIte.Count-1 Do
    Begin
      If Not FLstIte[intCnt].blnEmitirDoc Then
        Continue;

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE PENREC SET                ');
      qryUpdate.SQL.Add('  PEN_STATUS = :PEN_STATUS,      ');
      qryUpdate.SQL.Add('  PEN_MOTBAI = :PEN_MOTBAI       ');
      qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM   ');
      qryUpdate.ParamByName('PEN_STATUS').AsString := FStatus;
      qryUpdate.ParamByName('PEN_MOTBAI').AsString := FMotBai;
      qryUpdate.ParamByName('AUTOINCREM').AsString := FLstIte[intCnt].strAutInc;
      qryUpdate.ExecSQL;
    End;

    Result := True;

  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TVendaBaseTrocaRecebimento.fGravaITERECPendente: Boolean;
begin
  Result := fGravaDadosDocumentoComRecebimento;
  Result := Result And fGravaCadRecDocumentoPendente;
end;

function TVendaBaseTrocaRecebimento.fImprimirDocumentoRB: Boolean;
var
  strLayPadrao: String;
  objImpressao: TEditorFastImpressao;
begin
  strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],
     [ARR_TIPO_LAYOUT[tpeRB], VS_strCodEmp, 'S']);

  If fEmptyStr(strLayPadrao) Then
  Begin
    FMsgRet := 'Não há layout disponível para impressão!';
    Result := False;
    Exit;
  End;

  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    objImpressao.recDocume.strNumDoc       := FDocRec;
    objImpressao.recDocume.strCodEmp       := FEmpRec;
    objImpressao.recDocume.strEspDoc       := FEspRec;
    objImpressao.recDocume.strCodCli       := FCodCli;
    objImpressao.recDocume.strTipFc        := 'C';
    objImpressao.recDocume.strTipImp       := 'V';
    objImpressao.tpeTipoEtiqueta           := tpeRB;
    Result := objImpressao.fImprimeDocumento;
  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TVendaBaseTrocaRecebimento.fIncluiItensDocumento: Boolean;
Var
  intCnt,
  intCont: Integer;
  strClaFis: String;
  recForTin   : TForTin;
  recMadeira  : TDadosMadeira;
Begin
  Try
    strClaFis := fRetornaClaFisEntrada(FObjFatVenda.fDentroDoEstadoCFOP);
    FDocumento := EmptyStr;

    For intCnt:= 0 to FLstIte.Count-1 Do
    Begin

      If Not FLstIte[intCnt].blnEmitirDoc Then
        Continue;

      If Pos(FLstIte[intCnt].strNumDoc, FDocumento) <= 0 Then
        FDocumento := FDocumento + ', '+FLstIte[intCnt].strNumDoc+'-'+FLstIte[intCnt].strEspDoc+'';

      For intCont:= 0  To FLstIte[intCnt].Produtos.Count-1 Do
      Begin
        FLstIte[intCnt].Produtos[intCont].pCarregarDadosFiscais;
        FObjFatVenda.pAdicionaRegistroTemporaria(cdsVenda,                                                     // cdsDados
                                                 Nil,                                                          // btnAdicionar
                                                 'NOR',                                                        // strIdePro
                                                 FLstIte[intCnt].Produtos[intCont].strCodGru,                               // strCodGru
                                                 FLstIte[intCnt].Produtos[intCont].strCodIte,                               // strCodIte
                                                 FLstIte[intCnt].Produtos[intCont].strDesIte,                               // strDesOri
                                                 FLstIte[intCnt].Produtos[intCont].strIteDes,                               // strDesIte
                                                 FLstIte[intCnt].Produtos[intCont].strDesFab,                               // strDesFab
                                                 FLstIte[intCnt].Produtos[intCont].strUnidad,                               // strUnidad
                                                 FLstIte[intCnt].Produtos[intCont].strCodUni,                               // strCodUni
                                                 FLstIte[intCnt].Produtos[intCont].strCodMar,                               // strCodMar
                                                 FLstIte[intCnt].Produtos[intCont].strCodFor,                               // strCodFor
                                                 FLstIte[intCnt].Produtos[intCont].strRefere,                               // strRefere
                                                 FLstIte[intCnt].Produtos[intCont].fltUniOri,                               // fltUniOri
                                                 FLstIte[intCnt].Produtos[intCont].fltUniVis,                               // fltUniVis
                                                 FLstIte[intCnt].Produtos[intCont].fltUniTar,                               // fltUniTar
                                                 0.0,                                                          // fltUniTmp
                                                 0.0,                                                          // fltDesCon
                                                 FLstIte[intCnt].Produtos[intCont].fltQtdIte,                               // fltQtdIte
                                                 FLstIte[intCnt].Produtos[intCont].fltTotIte,                               // fltTotIte
                                                 'E',                                                          // strEntSai
                                                 FLstIte[intCnt].Produtos[intCont].fltPreCus,                               // fltPreCus
                                                 FLstIte[intCnt].Produtos[intCont].fltTotCus,                               // fltTotCus
                                                 FLstIte[intCnt].Produtos[intCont].strComLub,                               // strComLub
                                                 FLstIte[intCnt].Produtos[intCont].fltIpiSai,                               // fltIpiSai
                                                 FLstIte[intCnt].Produtos[intCont].fltDesMax,                               // fltDesMax
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe1,                               // fltPreVe1
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe2,                               // fltPreVe2
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe3,                               // fltPreVe3
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe4,                               // fltPreVe4
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe5,                               // fltPreVe5
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe6,                               // fltPreVe6
                                                 FLstIte[intCnt].Produtos[intCont].fltPreVe7,                               // fltPreVe7
                                                 0.0,                                                          // fltMarLuc
                                                 FLstIte[intCnt].Produtos[intCont].fltSaldos,                               // fltSaldos
                                                 'N',                                                          // strIncPis
                                                 FLstIte[intCnt].Produtos[intCont].fltComVar,                               // fltComVar
                                                 FLstIte[intCnt].Produtos[intCont].fltComAta,                               // fltComAta
                                                 FLstIte[intCnt].Produtos[intCont].fltComDis,                               // fltComDis
                                                 '',                                                           // strDocDev
                                                 '',                                                           // strEspDev
                                                 '',                                                           // strEmpDev
                                                 0.0,                                                          // fltQtdDev
                                                 0.0,                                                          // fltUniDev
                                                 '',                                                           // strIncDev
                                                 FLstIte[intCnt].Produtos[intCont].fltTotUlt,                               // fltTotUlt
                                                 FLstIte[intCnt].Produtos[intCont].fltImpUlt,                               // fltImpUlt
                                                 FLstIte[intCnt].Produtos[intCont].fltPreUlt,                               // fltPreUlt
                                                 FLstIte[intCnt].Produtos[intCont].fltPreMed,                               // fltPreMed
                                                 FLstIte[intCnt].Produtos[intCont].strClaIpi,                               // strClaIpi
                                                 '',                                                           // strIteCha
                                                 '',                                                           // strIteTin
                                                 '',                                                           // strDesCor
                                                 '',                                                           // strTipPre
                                                 0,                                                            // intLazQua
                                                 '',                                                           // strTipEmb
                                                 0.0,                                                          // fltQtdEmb
                                                 0.0,                                                          // fltPreEmb
                                                 0.0,                                                          // fltPrvTin
                                                 0.0,                                                          // fltPrcTin
                                                 0.0,                                                          // fltFatTin
                                                 'N',                                                          // strProEmb
                                                 '',                                                           // strIteEmb
                                                 0.0,                                                          // fltUniEmb
                                                 0.0,                                                          // fltEmbAnt
                                                 FLstIte[intCnt].Produtos[intCont].strCodAbf,                               // strCodAbf
                                                 FLstIte[intCnt].Produtos[intCont].fltPesoIt,                               // fltPesoIt
                                                 FLstIte[intCnt].Produtos[intCont].fltPesLiq,                               // fltPesLiq
                                                 'N',                                                          // strPromoc
                                                 0.0,                                                          // fltProPreCus
                                                 0.0,                                                          // fltProPreVen
                                                 0.0,                                                          // fltProComVar
                                                 0.0,                                                          // fltProDesF07
                                                 '',                                                           // strTipTin
                                                 FObjFatVenda.fRetPerComGrupo(FLstIte[intCnt].Produtos[intCont].strCodGru), // fltGPeCom
                                                 FLstIte[intCnt].Produtos[intCont].strCodFab,                               // strCodFab
                                                 -1,                                                           // intSeqInd
                                                 0.0,                                                          // fltQtdBai
                                                 '',                                                           // strNumOrc
                                                 '',                                                           // strEspOrc
                                                 '',                                                           // strEmpOrc
                                                 FLstIte[intCnt].Produtos[intCont].fltMarMin,                               // fltMarMin
                                                 FLstIte[intCnt].Produtos[intCont].fltMarMSG,                               // fltMarMSG
                                                 FLstIte[intCnt].Produtos[intCont].fltMarMGe,                               // fltMarMGe
                                                 fRetNomMarca(FLstIte[intCnt].Produtos[intCont].strCodMar),                 // strMarca
                                                 '',                                                           // strStatus
                                                 0.0,                                                          // fltComDev
                                                 0.0,                                                          // fltDesDev
                                                 '',                                                           // strSeqDet
                                                 '',                                                           // strCatali
                                                 '',                                                           // strLinTin
                                                 0.0,                                                          // fltEmbala
                                                 '',                                                           // strDesNes
                                                 '',                                                           // strSemEst
                                                 '',                                                           // strLibEst
                                                 FLstIte[intCnt].Produtos[intCont].fltPreCom,                               // fltPreCom
                                                 FLstIte[intCnt].Produtos[intCont].fltUniDig,                               // fltUniDig
                                                 FLstIte[intCnt].Produtos[intCont].fltQtdPon,                               // fltQtdPon
                                                 '',                                                           // strComple
                                                 '',                                                           // strDivDev
                                                 FLstIte[intCnt].Produtos[intCont].strObrCpf,                               // strObrCpf
                                                 '',                                                           // strMontad
                                                 '',                                                           // strA_n_o_
                                                 FLstIte[intCnt].Produtos[intCont].strSigUni,                               // strSigUni
                                                 0.0,                                                          // fltVolPro
                                                 intCont+1,                                                    // intOrdite
                                                 '',                                                           // strChaFor
                                                 '',                                                           // strCodAca
                                                 '',                                                           // strEmpAca
                                                 False,                                                        // blnProAca
                                                 '',                                                           // strEspFut
                                                 '',                                                           // strDocFut
                                                 '',                                                           // strEmpFut
                                                 0.0,                                                          // fltOutVal
                                                 0.0,                                                          // fltComTbl
                                                 0.0,                                                          // fltDesOpe
                                                 0.0,                                                          // fltICMSai
                                                 0.0,                                                          // fltImpFed
                                                 0.0,                                                          // fltDesMge
                                                 '',                                                           // strDocCnf
                                                 '',                                                           // strEspCnf
                                                 '',                                                           // strEmpCnf
                                                 '1',                                                          // strTabPre
                                                 FLstIte[intCnt].Produtos[intCont].fltIpiEnt,                               // fltIpiEnt
                                                 FLstIte[intCnt].Produtos[intCont].fltFreEnt,                               // fltFreEnt
                                                 '',                                                           // strCodDil
                                                 0.0,                                                          // fltPorDil
                                                 '',                                                           // strDilCon
                                                 0.0,                                                          // fltPorCat
                                                 'R',                                                          // strEntRet
                                                 '',                                                           // strLocRet
                                                 'N',                                                          // strEntFut
                                                 '',                                                           // strMotFut
                                                 0,                                                            // dtaDtaEnt
                                                 1.0,                                                          // fltQtdOri
                                                 0.0,                                                          // fltDesEsp
                                                 0.0,                                                          // fltDesBai
                                                 FLstIte[intCnt].Produtos[intCont].strImpDir,                               // strImpDir
                                                 '',                                                           // strLocFis
                                                 0.0,                                                          // fltPreCu2
                                                 0.0,                                                          // fltTotCu2
                                                 0.0,                                                          // fltProComAta
                                                 0.0,                                                          // fltProComDis
                                                 0.0,                                                          // fltTotPed
                                                 0.0,                                                          // fltPanUti
                                                 0.0,                                                          // fltTotDes
                                                 0.0,                                                          // ftlTotFre
                                                 recForTin,                                                    // recForTin
                                                 '',                                                           // strKey_EP
                                                 '',                                                           // strLotAnt
                                                 FLstIte[intCnt].Produtos[intCont].strNumLot,                               // strNumLot
                                                 '',                                                           // strEmpPrd
                                                 '',                                                           // strVenCnf
                                                 False,                                                        // blnBxSbIt
                                                 'N',                                                          // strPigBas
                                                 'NOR',                                                        // strIdeDev
                                                 0.0,                                                          // fltQtdDet
                                                 '',                                                           // strTabDev
                                                 FLstIte[intCnt].Produtos[intCont].strCodBar,                               // strCodBar
                                                 '',                                                           // strTipFin
                                                 0.0,                                                          // fltDesFin
                                                 0.0,                                                          // fltPreLot
                                                 0.0,                                                          // fltCoDvRp
                                                 '',                                                           // strEmpIte
                                                 1.0,                                                          // fltFatAce
                                                 True,                                                         // blnPodAlt
                                                 '',                                                           // strEmpSol
                                                 '',                                                           // strCndDev
                                                 '',                                                           // strCCndDv
                                                 0,                                                            // dtaEmiDev
                                                 FLstIte[intCnt].Produtos[intCont].fltCusIte,                               // fltCusIte
                                                 '',                                                           // strDesSim
                                                 '',                                                           // strOrdPro
                                                 recMadeira,                                                   // recMadeira
                                                 FLstIte[intCnt].Produtos[intCont].fltTotImp,                               // fltTotImp
                                                 0.0,                                                          // fltVal_RT
                                                 0.0,                                                          // fltTaxJur
                                                 '',                                                           // strSeqGad
                                                 0.0,                                                          // fltQtdExp
                                                 '',                                                           // strBarEmb
                                                 '',                                                           // strNumCmp
                                                 0,                                                            // intNItCmp
                                                 0.0,                                                          // fltDeDVCf
                                                 '',                                                           // strCodMec
                                                 '',                                                           // strSeqRcd
                                                 0,                                                            // intSeqInc
                                                 '',                                                           // strCodVenIte
                                                 'N',                                                          // strAltPCoIte
                                                 0.0,                                                          // fltPerComIte
                                                 0.0,                                                          // fltFreDev
                                                 0.0,                                                          // fltDeADev
                                                 False,                                                        // blnAlterandoPDORCarregado
                                                 False,                                                        // blnInserindoPDORCarregado
                                                 'N',                                                          // strCliBus
                                                 '',                                                           // strTurEnt
                                                 0,                                                            // intSeqCcr
                                                 0.0,                                                          // fltDopTin
                                                 '',                                                           // strCodVe2Ite
                                                 'N',                                                          // strLibUni
                                                 0.0,                                                          // fltValDif
                                                 '',                                                           // strLotAba
                                                 '',                                                           // strIncFut
                                                 '',                                                           // strSepExp
                                                 '',                                                           // strTabPreEmb
                                                 '',                                                           // strExcIpi
                                                 0.0,                                                          // fltDesMSu
                                                 '',                                                           // strAiDvOr
                                                 strClaFis);                                                   // strClaFis


      End;
    End;

    Result :=  cdsVenda.RecordCount > 0;
  Except
    Result := False;
  End;
End;

function TVendaBaseTrocaRecebimento.fInformarMotivo: Boolean;
var
  intResult: Integer;
begin
  repeat
    FMotBai := fInputDialog(intResult, 'Motivo', 'Informe o assunto da baixa sem recebimento.');

    Result := Not fEmptyStr(FMotBai);

    If Not Result And (intResult = 1) Then
    Begin
      fMensagem('ATENÇÃO!', 'O assunto da baixa sem recebimento deve ser preenchido!', ['&Ok']);
    End;

  until Result or (intResult = 2);
end;

function TVendaBaseTrocaRecebimento.fLiberaEmissaoBaixaSemRecebimento: Boolean;
var
  objLiberacao : TLiberacao;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  intCnt: Integer;
begin
  objLiberacao := TLiberacao.Create;
  Try
    pCarregarDadosCliente;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Baixar Pendente Sem Gerar Recebimento', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FCodCli + '-' + FNomCli, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Cpf/Cnpj: ' + FCpfCgc, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Nome Fantasia: ' + FNomFan , alEsquerda, teAmbos, '', 99);


    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'Documento'      , 20 , alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'Data'           , 12 , alDireita, teAutcom);
    objLinha.pAddColuna('', 'Produto Venda'  , 50 , alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'Vlr.Total'      , 14 , alDireita, teAutcom);

    objTabela.lstLinhas.Add(objLinha);
    For intCnt := 0 To FLstIte.Count-1 Do
    Begin
      If  FLstIte[intCnt].blnEmitirDoc Then
      Begin
        objLinha              := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Documento'   , FLstIte[intCnt].strNumDoc + '-' +
                                            FLstIte[intCnt].strEspDoc + '-' +
                                            FLstIte[intCnt].strCodEmp, 20 , alEsquerda, teAmbos);
        objLinha.pAddColuna('Data'        , FormatDateTime('dd/mm/yyyy', FLstIte[intCnt].DtaEnt), 12 , alCentro  , teAmbos);
        objLinha.pAddColuna('Produto Venda', FLstIte[intCnt].strCodIte + '-' + FLstIte[intCnt].strDesIte, 50, alEsquerda, teAmbos);
        objLinha.pAddColuna('Vlr.Total', FormatFloat('###,###,##0.00', FLstIte[intCnt].fltTotIte), 14 , alDireita , teAmbos);

        objTabela.lstLinhas.Add(objLinha);
      End;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce    := 'VBTBAI';

    objLiberacao.strMsgSen := 'Baixar Pendente Sem Gerar Recebimento.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
End;

function TVendaBaseTrocaRecebimento.fLiberaEmissaoDocumentoAvulso: Boolean;
var
  objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Realizar Recebimento Avulso', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.strDirAce    := 'VBTAVU';

    objLiberacao.strMsgSen := 'Realizar Recebimento Avulso.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
End;

function TVendaBaseTrocaRecebimento.fPossuiUnicoDocumentoPendente: Boolean;
begin
  Result := Length(FArrayDocFinPen) = 1;
end;

function TVendaBaseTrocaRecebimento.fRealizarBaixaSemRecebimento: Boolean;
begin

  If Not fVerificaPodeRealizarBaixaSemRecebimento Then
    Exit(False);

  Result := fGravaDadosDocumentoSemRecebimento;
end;

function TVendaBaseTrocaRecebimento.fRealizarEntradaSemVinculo: Boolean;
begin
  Result := fEmitirDocumentoRB;
end;

function TVendaBaseTrocaRecebimento.fRetornaClaFisEntrada(
  blnDentroEstado: Boolean): String;
var
  strCFOP: String;
Begin
  strCFOP := fCfgSis('CLAFRB', VarString);

  If fEmptyStr(strCFOP) Then
    strCFOP := '949';

  If (blnDentroEstado) Then
    Result := '1' + strCFOP
  Else
    Result := '2' + strCFOP;
End;

function TVendaBaseTrocaRecebimento.fRetornaItemRecebimento(const strAutInc: String): TItemRecebimento;
var
  intCnt: Integer;
begin
  Result := Nil;
  For intCnt := 0 To FLstIte.Count-1 Do
  Begin
    If FLstIte[intCnt].strAutInc = strAutInc Then
    Begin
      Result := FLstIte[intCnt];
      Break;
    End;
  End;
end;

function TVendaBaseTrocaRecebimento.fSQLPendenciaFinanceira: String;
var
  strSQL: String;
  intCnt: Integer;
  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodCli: String;
begin
  strSQL := strSQL + 'SELECT PENREC.* ,  ';
  strSQL := strSQL + '       ITE_DESITE, ';
  strSQL := strSQL + '       CLI_NOMCLI  ';
  strSQL := strSQL + 'FROM PENREC        ';
  strSQL := strSQL + 'INNER JOIN CADITE ON PEN_CODITE = ITE_CODITE  ';
  strSQL := strSQL + 'INNER JOIN CADCLI ON PEN_CODCLI = CLI_CODCLI  ';
  strSQL := strSQL + 'WHERE PEN_STATUS = "P"     ';

  If Length(FArrayDocFinPen) > 0 Then
  Begin
     strNumDoc := strNumDoc + '  AND PEN_NUMDOC IN (';
     strEspDoc := strEspDoc + '  AND PEN_ESPDOC IN (';
     strCodEmp := strCodEmp + '  AND PEN_CODEMP IN (';
     strCodCli := strCodCli + '  AND PEN_CODCLI IN (';
     For intCnt:= 0 To  Length(FArrayDocFinPen)-1 do
     Begin
       strNumDoc := strNumDoc + IIF(intCnt = 0, '', ',') + QuotedStr(FArrayDocFinPen[intCnt].strNumDoc);
       strEspDoc := strEspDoc + IIF(intCnt = 0, '', ',') + QuotedStr(FArrayDocFinPen[intCnt].strEspDoc);
       strCodEmp := strCodEmp + IIF(intCnt = 0, '', ',') + QuotedStr(FArrayDocFinPen[intCnt].strCodEmp);
       strCodCli := strCodCli + IIF(intCnt = 0, '', ',') + QuotedStr(FArrayDocFinPen[intCnt].strCodCli);

     End;
     strNumDoc := strNumDoc + '  ) ';
     strEspDoc := strEspDoc + '  ) ';
     strCodEmp := strCodEmp + '  ) ';
     strCodCli := strCodCli + '  ) ';
  End;
  Result := strSQL + strNumDoc + strEspDoc + strCodEmp + strCodCli;
end;

function TVendaBaseTrocaRecebimento.fVerificaItemAvulsoSelecionado: Boolean;
var
  intCnt: Integer;
  QtdSel: Integer;
begin
  QtdSel := 0;
  For intCnt := 0 To FLstIte.Count-1 Do
  Begin
    If FLstIte[intCnt].blnEmitirDoc And FLstIte[intCnt].blnAvulso Then
    Begin
      inc(QtdSel);
    End;
  End;

  Result := QtdSel > 0;
end;

function TVendaBaseTrocaRecebimento.fVerificaItensSelecionados: Boolean;
var
  intCnt: Integer;
  QtdSel: Integer;
begin
  QtdSel := 0;
  For intCnt := 0 To FLstIte.Count-1 Do
  Begin
    If FLstIte[intCnt].blnEmitirDoc Then
    Begin
      inc(QtdSel);
    End;
  End;

  Result := QtdSel > 0;
end;

function TVendaBaseTrocaRecebimento.fVerificaPodeRealizarBaixaSemRecebimento: Boolean;
begin
  Result := True;

  If fEmptyStr(FCodCli) Then
  Begin
    FMsgRet := 'O cliente não foi informado.';
    Exit(False);
  End;

  If Not fVerificaItensSelecionados Then
  Begin
    FMsgRet := 'Não exitem itens marcados para realizar a operação. Verifique.';
    Exit(False);
  End;

  If Not fLiberaEmissaoBaixaSemRecebimento Then
  Begin
    FMsgRet := 'Usuário não possui o direito de acesso liberado para esta rotina.';
    Exit(False);
  End;

  If Not fInformarMotivo Then
  Begin
    FMsgRet := 'O motivo não foi informado.';
    Exit(False);
  End;

end;

function TVendaBaseTrocaRecebimento.fVerificaPodeRealizarBaixaSemVinculo: Boolean;
begin
  Result := True;

  If fEmptyStr(FCodCli) Then
  Begin
    FMsgRet := 'Cliente não foi informado, verifique.';
    Exit(False);
  End;

  If Not fLiberaEmissaoDocumentoAvulso Then
  Begin
    FMsgRet := 'Usuário não possui o direito de acesso liberado para esta rotina.';
    Exit(False);
  End;
End;

function TVendaBaseTrocaRecebimento.fVinculaCadRecVBComPedido(strAutIncPed,
  strIncCadRec: String): Boolean;
var
  qryVincula: TUniQuery;
begin
  qryVincula := fCriaQuery;

  try
    Result := False;

    qryVincula.Close;
    qryVincula.SQL.Clear;
    qryVincula.SQL.Add('UPDATE EXTGOR');
    qryVincula.SQL.Add('SET FGO_SEQDVB = :SEQDVB');
    qryVincula.SQL.Add('WHERE FGO_SEQFGO = :SEQFGO');

    qryVincula.ParamByName('SEQDVB').AsString := strIncCadRec;
    qryVincula.ParamByName('SEQFGO').AsString := strAutIncPed;

    qryVincula.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryVincula);
  end;
end;

function TVendaBaseTrocaRecebimento.GetCodCli: String;
begin
  Result := FCodCli;
end;

function TVendaBaseTrocaRecebimento.GetCpfCgc: String;
begin
  Result := FCpfCgc;
end;

function TVendaBaseTrocaRecebimento.GetDocRec: String;
begin
  Result := FDocRec;
end;

function TVendaBaseTrocaRecebimento.GetEhFinaceiroPendente: Boolean;
begin
  Result := FEhFinaceiroPendente;
end;

function TVendaBaseTrocaRecebimento.GetEmpRec: String;
begin
  Result := FEmpRec;
end;

function TVendaBaseTrocaRecebimento.GetEspRec: String;
begin
  Result := FEspRec;
end;

function TVendaBaseTrocaRecebimento.GetLstIte: TList<TItemRecebimento>;
begin
  Result := FLstIte;
end;

function TVendaBaseTrocaRecebimento.GetMsgRet: String;
begin
  Result := FMsgRet;
end;

function TVendaBaseTrocaRecebimento.GetNomCli: String;
begin
  Result := FNomCli;
end;

function TVendaBaseTrocaRecebimento.GetNomFan: String;
begin
  Result := FNomFan;
end;

function TVendaBaseTrocaRecebimento.GetObjFatVnd: TFatVenda;
begin
  Result := FObjfatVenda;
end;

function TVendaBaseTrocaRecebimento.GetTotRec: Double;
begin
  Result := FTotRec;
end;

procedure TVendaBaseTrocaRecebimento.pCalcularTotais;
var
  intCnt: Integer;
begin
  FTotRec := 0;

  For intCnt:= 0 To FLstIte.Count-1 Do
  Begin
    FLstIte[intCnt].pCalcularTotais;
    If FLstIte[intCnt].blnEmitirDoc Then
      FTotRec := FTotRec + FLstIte[intCnt].fltTotRec;
  End;
end;

procedure TVendaBaseTrocaRecebimento.pCarregarDadosCliente;
var
  qrySelect: TUniQuery;
begin
  If fEmptyStr(FCodCli) Then
    Exit;

  qrySelect :=  fCriaQuery();
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT CLI_NOMCLI,             ');
    qrySelect.SQL.Add('       CLI_FANSOB,             ');
    qrySelect.SQL.Add('       CLI_CGCCPF,             ');
    qrySelect.SQL.Add('       CLI_C_G_C_              ');
    qrySelect.SQL.Add('FROM CADCLI                    ');
    qrySelect.SQL.Add('WHERE CLI_CODCLI = :CLI_CODCLI ');
    qrySelect.ParamByName('CLI_CODCLI').AsString := FCodCli;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      FNomCli := qrySelect.FieldByName('CLI_NOMCLI').AsString;
      If qrySelect.FieldByName('CLI_CGCCPF').AsString = '1' Then
        FCpfCgc := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), qrySelect.FieldByName('CLI_C_G_C_').AsString)
      Else
        FCpfCgc := qrySelect.FieldByName('CLI_C_G_C_').AsString;
      FNomFan := qrySelect.FieldByName('CLI_FANSOB').AsString;
    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

procedure TVendaBaseTrocaRecebimento.pImprimeFormularioDoc;
var
  intCnt: Integer;
Begin
  For intCnt:= 0 To Length(FArrayDocFinPen)-1 Do
  Begin
    TImpPedidoTrocaRecebimento.pImprimeFormularioDoc(FArrayDocFinPen[intCnt].strNumDoc,
                                                     FArrayDocFinPen[intCnt].strEspDoc,
                                                     FArrayDocFinPen[intCnt].strCodEmp,
                                                     FArrayDocFinPen[intCnt].strCodCli);
    
  End;
End;

procedure TVendaBaseTrocaRecebimento.pLimpar;
begin
  FLstIte.Clear;

  FCodCli := EmptyStr;
  FNomCli := EmptyStr;
  FDocRec := EmptyStr;
  FEspRec := EmptyStr;
  FEmpRec := EmptyStr;
  FMotBai := EmptyStr;
  FCpfCgc := EmptyStr;
  FNomFan := EmptyStr;
end;

procedure TVendaBaseTrocaRecebimento.pLimparItens;
begin
  FLstIte.Clear;
end;

procedure TVendaBaseTrocaRecebimento.pZeraImpostos;
var
  intCnt: Integer;
Begin
  If Not Assigned(FObjFatVenda) Then
    Exit;

  For intCnt := 0 To Length(FObjFatVenda.arrMatItens)-1 Do
  Begin
    FObjFatVenda.pZerarDadosIcmsMatrizItens(false, intCnt);
    FObjFatVenda.pZerarDadosIpiMatrizItens(True, intCnt);
    FObjFatVenda.pZerarDadosStMatrizItens(intCnt);
  End;

  FObjFatVenda.fltBasIcm := 0;
  FObjFatVenda.fltTotIcm := 0;
  FObjFatVenda.fltBasIpi := 0;
  FObjFatVenda.fltTotIpi := 0;
  FObjFatVenda.fltBasRet := 0;
  FObjFatVenda.fltTotRet := 0;
End;

procedure TVendaBaseTrocaRecebimento.SetCodCli(const Value: String);
begin
  FCodCli := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetCpfCgc(const Value: String);
begin
  FCpfCgc := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetDocRec(const Value: String);
begin
  FDocRec := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetEhFinaceiroPendente(
  const Value: Boolean);
begin
  FEhFinaceiroPendente := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetEmpRec(const Value: String);
begin
  FEmpRec := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetEspRec(const Value: String);
begin
  FEspRec := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetNomCli(const Value: String);
begin
  FNomCli := Value;
end;

procedure TVendaBaseTrocaRecebimento.SetNomFan(const Value: String);
begin
  FNomFan := Value;
end;

{ TItemRecebimento }

constructor TItemRecebimento.Create(Owner: TVendaBaseTrocaRecebimento);
begin
  FObjRec := Owner;
  FLstPro := TList<TItemRecebido>.Create;
  FLstProBkp := TList<TItemRecebido>.Create;
  pLimpar;
end;

destructor TItemRecebimento.Destroy;
begin
  If Assigned(FLstPro) Then
    FreeAndNil(FLstPro);

  inherited;
end;

function TItemRecebimento.fAddProdutoRecebido: TItemRecebido;
var
  intCont: Integer;
begin
  FLstPro.add(TItemRecebido.Create(Self));
  intCont := FLstPro.Count -1;
  Result  := FLstPro[intCont];
end;

function TItemRecebimento.fRemoveItem(const strCodIte: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;

  For intCnt:= 0 To FLstPro.Count-1 Do
  Begin
    If FLstPro[intCnt].strCodIte = strCodIte Then
    Begin
      FLstPro.Delete(intCnt);
      Result := True;
      Break;
    End;
  End;

  pCalcularTotais;
end;

function TItemRecebimento.fVerificaPodeIncluirProduto(
  const strCodIteParam: String): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  For intCnt:= 0 To FLstPro.Count-1 Do
  Begin
    If FLstPro[intCnt].strCodIte = strCodIteParam Then
    Begin
      Result := False;
      FMsgRet := 'Item já incluído na lista.';
      Break;
    End;
  End;
end;

function TItemRecebimento.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TItemRecebimento.GetBlnAvl: Boolean;
begin
  Result := FblnAvl;
end;

function TItemRecebimento.GetblnEmi: Boolean;
begin
  Result := FblnEmi;
end;

function TItemRecebimento.GetCodEmp: String;
begin
  Result := FCodEmp;
end;

function TItemRecebimento.GetCodIte: String;
begin
  Result := FCodIte;
end;

function TItemRecebimento.GetDesIte: String;
begin
  Result := FDesIte;
end;

function TItemRecebimento.GetDtaEnt: TDateTime;
begin
  Result := FDtaEnt;
end;

function TItemRecebimento.GetEspDoc: String;
begin
  Result := FEspDoc;
end;

function TItemRecebimento.GetHorEnt: TDateTime;
begin
  Result := FHorEnt;
end;

function TItemRecebimento.GetLstPro: TList<TItemRecebido>;
begin
  Result := FLstPro;
end;

function TItemRecebimento.GetLstProBkp: TList<TItemRecebido>;
begin
  Result := FLstProBkp;
end;

function TItemRecebimento.GetMsgRet: String;
begin
  Result := FMsgRet;
end;

function TItemRecebimento.GetNumDoc: String;
begin
  Result := FNumDoc;
end;

function TItemRecebimento.GetStatus: String;
begin
  Result := FStatus;
end;

function TItemRecebimento.GetTotIte: Double;
begin
  Result := FTotIte;
end;

function TItemRecebimento.GetTotRec: Double;
begin
  Result := FTotRec;
end;

function TItemRecebimento.GetVndBasTrc: TVendaBaseTrocaRecebimento;
begin
  Result := FObjRec;
end;

procedure TItemRecebimento.pCalcularTotais;
var
  intCnt: Integer;
begin
  FTotRec := 0;

  For intCnt := 0 To FLstPro.Count-1 Do
  Begin
    FLstPro[intCnt].pCalcularTotais;
    FTotRec := FTotRec + FLstPro[intCnt].fltVlrTot;
  End;
end;

procedure TItemRecebimento.pLimpar;
begin
  FAutInc := EmptyStr;
  FDtaEnt := 0;
  FHorEnt := 0;
  FNumDoc := EmptyStr;
  FEspDoc := EmptyStr;
  FCodEmp := EmptyStr;
  FCodIte := EmptyStr;
  FTotIte := 0;
  FStatus := EmptyStr;
  FblnAvl := False;
  FLstPro.Clear;
end;

procedure TItemRecebimento.pLimparProdutosRecebidos;
begin
  FLstPro.Clear;
end;

procedure TItemRecebimento.SetAutInc(const Value: String);
begin
  FAutInc := Value;
end;

procedure TItemRecebimento.SetbBlnAvl(const Value: Boolean);
begin
  FblnAvl := Value;
end;

procedure TItemRecebimento.SetblnEmi(const Value: Boolean);
begin
  FblnEmi := Value;
end;

procedure TItemRecebimento.SetCodEmp(const Value: String);
begin
  FCodEmp := Value;
end;

procedure TItemRecebimento.SetCodIte(const Value: String);
begin
  FCodIte := Value;
end;

procedure TItemRecebimento.SetDesIte(const Value: String);
begin
  FDesIte := Value;
end;

procedure TItemRecebimento.SetDtaEnt(const Value: TDateTime);
begin
  FDtaEnt := Value;
end;

procedure TItemRecebimento.SetEspDoc(const Value: String);
begin
  FEspDoc := Value;
end;

procedure TItemRecebimento.SetHorEnt(const Value: TDateTime);
begin
  FHorEnt := Value;
end;

procedure TItemRecebimento.SetLstProBkp(const Value: TList<TItemRecebido>);
begin
  FLstProBkp := Value;
end;

procedure TItemRecebimento.SetNumDoc(const Value: String);
begin
  FNumDoc := Value;
end;

procedure TItemRecebimento.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TItemRecebimento.SetTotIte(const Value: Double);
begin
  FTotIte := Value;
end;

{ TItemRecebido }

constructor TItemRecebido.Create(Owner: TItemRecebimento);
begin
  FObjItem := Owner;
  FSLEquipamentoArmazem := TStringList.Create;
  pLimpar;
end;

destructor TItemRecebido.Destroy;
begin

  FreeAndNil(FSLEquipamentoArmazem);

  inherited;
end;

function TItemRecebido.fAlteraDocumentoRecebido: Boolean;
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;

  Try
    Result := False;

    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE ITEREC SET IRC_DOCREC = :DOCREC,');
    qryUpdate.SQL.Add(' IRC_ESPREC = :ESPREC,');
    qryUpdate.SQL.Add(' IRC_EMPREC = :EMPREC,');
    qryUpdate.SQL.Add(' IRC_CODITE = :CODITE,');
    qryUpdate.SQL.Add(' IRC_TIPREC = :TIPREC,');
    qryUpdate.SQL.Add(' IRC_QTDITE = :QTDITE,');
    qryUpdate.SQL.Add(' IRC_UNITAR = :UNITAR,');
    qryUpdate.SQL.Add(' IRC_TOTITE = :TOTITE ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryUpdate.ParamByName('DOCREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strNumDoc;
    qryUpdate.ParamByName('ESPREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strEspDoc;
    qryUpdate.ParamByName('EMPREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strEmpDoc;
    qryUpdate.ParamByName('CODITE').AsString := FCodIte;
    qryUpdate.ParamByName('TIPREC').AsString := arrTipoRecebido[FTipRec];
    qryUpdate.ParamByName('QTDITE').AsFloat  := FQtdIte;
    qryUpdate.ParamByName('UNITAR').AsFloat  := FVlrUni;
    qryUpdate.ParamByName('TOTITE').AsFloat  := FVlrTot;
    qryUpdate.ParamByName('AUTINC').AsString := FAutInc;
    qryUpdate.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TItemRecebido.fGravarDocumentoRecebido: Boolean;
var
  qryUpdate: TUniQuery;
begin

  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('INSERT INTO ITEREC( AUTOINCREM, IRC_SEQGER, IRC_DOCREC,');
    qryUpdate.SQL.Add('                    IRC_ESPREC, IRC_EMPREC, IRC_CODITE,');
    qryUpdate.SQL.Add('                    IRC_TIPREC, IRC_QTDITE, IRC_UNITAR,');
    qryUpdate.SQL.Add('                    IRC_TOTITE )');
    qryUpdate.SQL.Add('VALUE ( :AUTOINCREM, :IRC_SEQGER, :IRC_DOCREC,');
    qryUpdate.SQL.Add('        :IRC_ESPREC, :IRC_EMPREC, :IRC_CODITE,');
    qryUpdate.SQL.Add('        :IRC_TIPREC, :IRC_QTDITE, :IRC_UNITAR,');
    qryUpdate.SQL.Add('        :IRC_TOTITE )');

    FAutInc := fRetAutoIncrem('ITEREC', VS_strCodEmp);

    qryUpdate.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryUpdate.ParamByName('IRC_SEQGER').AsString := FObjItem.strAutInc;
    qryUpdate.ParamByName('IRC_DOCREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strNumDoc;
    qryUpdate.ParamByName('IRC_ESPREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strEspDoc;
    qryUpdate.ParamByName('IRC_EMPREC').AsString := FObjItem.objVendaBaseTroca.objFatVenda.strEmpDoc;
    qryUpdate.ParamByName('IRC_CODITE').AsString := FCodIte;
    qryUpdate.ParamByName('IRC_TIPREC').AsString := arrTipoRecebido[FTipRec];
    qryUpdate.ParamByName('IRC_QTDITE').AsFloat  := FQtdIte;
    qryUpdate.ParamByName('IRC_UNITAR').AsFloat  := FVlrUni;
    qryUpdate.ParamByName('IRC_TOTITE').AsFloat  := FVlrTot;
    qryUpdate.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TItemRecebido.fGravarDocumentoRecebidoPendente: Boolean;
var
  qryInsert: TUniQuery;
begin

  qryInsert := fCriaQuery;
  Try
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO ITEREC( AUTOINCREM, IRC_SEQGER, IRC_ITEPEN,');
    qryInsert.SQL.Add('                    IRC_TIPPEN, IRC_QTDPEN, IRC_UNIPEN,');
    qryInsert.SQL.Add('                    IRC_TOTPEN )');
    qryInsert.SQL.Add('VALUE ( :AUTOINCREM, :IRC_SEQGER, :IRC_ITEPEN,');
    qryInsert.SQL.Add('        :IRC_TIPPEN, :IRC_QTDPEN, :IRC_UNIPEN,');
    qryInsert.SQL.Add('        :IRC_TOTPEN )');

    FAutInc := fRetAutoIncrem('ITEREC', VS_strCodEmp);

    qryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryInsert.ParamByName('IRC_SEQGER').AsString := FObjItem.strAutInc;
    qryInsert.ParamByName('IRC_ITEPEN').AsString := FCodIte;
    qryInsert.ParamByName('IRC_TIPPEN').AsString := arrTipoRecebido[FTipRec];
    qryInsert.ParamByName('IRC_QTDPEN').AsFloat  := FQtdIte;
    qryInsert.ParamByName('IRC_UNIPEN').AsFloat  := FVlrUni;
    qryInsert.ParamByName('IRC_TOTPEN').AsFloat  := FVlrTot;
    qryInsert.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

function TItemRecebido.fRetornaNumLote(const strCodIte: String): String;
var
  objCadLot : TCadLot;
begin
  Result := '';

  objCadLot := TCadLot.Create(Nil);
  Try
    If (objCadLot.tplTipLot = tplArmazem) Then
    Begin
      Result := objCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(strCodIte);
      If fEmptyStr(Result) Then
      Begin
        FSLEquipamentoArmazem.Add(strCodIte);
      End;
    End;
  Finally
    FreeAndNil(objCadLot);
  End;
end;

class function TItemRecebido.fstrToTipRec(const strTipRec: String): TTipoRecebido;
begin
  Case AnsiIndexStr(AnsiUppercase(strTipRec), arrTipoRecebido) Of
    0 : Result := tpPeso
    Else
      Result := tpUnitario;
  End;
end;

function TItemRecebido.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TItemRecebido.GetCodIte: String;
begin
  Result := FCodIte;
end;

function TItemRecebido.GetDesIte: String;
begin
  Result := FDesIte;
end;

function TItemRecebido.GetEhAlteracao: Boolean;
begin
  Result := FEhAlteracao;
end;

function TItemRecebido.GetQtdIte: Double;
begin
  Result := FQtdIte;
end;

function TItemRecebido.GetstrTipRec: String;
begin
  Result := arrStrTipoRecebido[FTipRec];
end;

function TItemRecebido.GetTipRec: TTipoRecebido;
begin
  Result := FTipRec;
end;

function TItemRecebido.GetVlrTot: Double;
begin
  Result := FVlrTot;
end;

function TItemRecebido.GetVlrUni: Double;
begin
  Result := FVlrUni;
end;

procedure TItemRecebido.pCalcularTotais;
begin
  FVlrTot := FQtdIte * FVlrUni;
end;

procedure TItemRecebido.pCarregarDadosFiscais;
var
  strSQL: String;
  qryDet: TUniQuery;
  strIteDesAux: String;
  blnAbfIcms: Boolean;
begin
  blnAbfIcms := fCfgSis('TIPABF', VarString, VS_strCodEmp) = '1';

  qryDet := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                                    ';
    strSQL := strSQL + '  I.ITE_CODITE,                           ';
    strSQL := strSQL + '  I.ITE_CODGRU,                           ';
    strSQL := strSQL + '  I.ITE_DESITE,                           ';
    strSQL := strSQL + '  I.ITE_REFERE,                           ';
    strSQL := strSQL + '  I.ITE_CODFAB,                           ';
    strSQL := strSQL + '  I.ITE_DESFAB,                           ';
    strSQL := strSQL + '  U.UNI_CODUNI,                           ';
    strSQL := strSQL + '  U.UNI_SIGUNI,                           ';
    strSQL := strSQL + '  I.ITE_CODMAR,                           ';
    strSQL := strSQL + '  I.ITE_CODFOR,                           ';
    strSQL := strSQL + '  G.ITE_PRECUS,                           ';
    strSQL := strSQL + '  I.ITE_COMLUB,                           ';
    strSQL := strSQL + '  G.ITE_IPISAI,                           ';
    strSQL := strSQL + '  G.ITE_DESMAX,                           ';
    strSQL := strSQL + '  G.ITE_PREVE1,                           ';
    strSQL := strSQL + '  G.ITE_PREVE2,                           ';
    strSQL := strSQL + '  G.ITE_PREVE3,                           ';
    strSQL := strSQL + '  G.ITE_PREVE4,                           ';
    strSQL := strSQL + '  G.ITE_PREVE5,                           ';
    strSQL := strSQL + '  G.ITE_PREVE6,                           ';
    strSQL := strSQL + '  G.ITE_PREVE7,                           ';
    strSQL := strSQL + '  G.ITE_SALDOS,                           ';
    strSQL := strSQL + '  G.ITE_COMVAR,                           ';
    strSQL := strSQL + '  G.ITE_COMATA,                           ';
    strSQL := strSQL + '  G.ITE_COMDIS,                           ';
    strSQL := strSQL + '  G.ITE_PREULT,                           ';
    strSQL := strSQL + '  G.ITE_IMPULT,                           ';
    strSQL := strSQL + '  G.ITE_PREMED,                           ';
    strSQL := strSQL + '  I.ITE_CLAIPI,                           ';
    strSQL := strSQL + IIF(blnAbfIcms, '  I.ITE_CODABF, ',  'G.ITE_CODABF, ');
    strSQL := strSQL + '  I.ITE_PESOIT,                           ';
    strSQL := strSQL + '  I.ITE_PESLIQ,                           ';
    strSQL := strSQL + '  I.ITE_CODFAB,                           ';
    strSQL := strSQL + '  G.ITE_MARMIN,                           ';
    strSQL := strSQL + '  G.ITE_MARMSG,                           ';
    strSQL := strSQL + '  G.ITE_MARMGE,                           ';
    strSQL := strSQL + '  G.ITE_PRECOM,                           ';
    strSQL := strSQL + '  G.ITE_QTPPRO,                           ';
    strSQL := strSQL + '  I.ITE_OBRCPF,                           ';
    strSQL := strSQL + '  G.ITE_IPIENT,                           ';
    strSQL := strSQL + '  G.ITE_FREENT,                           ';
    strSQL := strSQL + '  I.ITE_IMPDIR,                           ';
    strSQL := strSQL + '  I.ITE_CODBAR,                           ';
    strSQL := strSQL + '  G.ITE_IMPULT,                           ';
    strSQL := strSQL + '  G.ITE_DESF01,                           ';
    strSQL := strSQL + '  G.ITE_DESF02,                           ';
    strSQL := strSQL + '  G.ITE_DESF03,                           ';
    strSQL := strSQL + '  G.ITE_DESF04,                           ';
    strSQL := strSQL + '  G.ITE_DESF05,                           ';
    strSQL := strSQL + '  G.ITE_DESF06                            ';
    strSQL := strSQL + 'FROM                                      ';
    strSQL := strSQL + '  CADITE I                                ';
    strSQL := strSQL + 'INNER JOIN CADUNI U                       ';
    strSQL := strSQL + '  ON U.UNI_CODUNI = I.ITE_CODUNI          ';
    strSQL := strSQL + 'INNER JOIN ITEGER G                       ';
    strSQL := strSQL + '  ON (G.ITE_CODITE = I.ITE_CODITE         ';
    strSQL := strSQL + '  AND G.ITE_CODEMP = :CODEMP)             ';
    strSQL := strSQL + 'WHERE I.ITE_CODITE = :CODITE              ';

    qryDet.Close;
    qryDet.SQL.Text := strSQL;
    qryDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDet.ParamByName('CODITE').AsString := FCodIte;

    qryDet.Open;

    If Not qryDet.IsEmpty Then
    Begin
      FstrDescri := qryDet.FieldByName('ITE_DESITE').AsString;
      FstrIteDes := qryDet.FieldByName('ITE_DESITE').AsString;

      strIteDesAux :=IIF((fCfgSis('MONDES', varString) = '1'),
                          FstrDescri +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_REFERE').AsString),' ' + qryDet.FieldByName('ITE_REFERE').AsString, '') +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_CODFAB').AsString),' ' + qryDet.FieldByName('ITE_CODFAB').AsString, ''),
                          //Else
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_CODFAB').AsString),qryDet.FieldByName('ITE_CODFAB').AsString + ' ', '') +
                          IIF(Not fEmptyStr(qryDet.FieldByName('ITE_REFERE').AsString),qryDet.FieldByName('ITE_REFERE').AsString + ' ', '') +
                          FstrDescri);

      FstrIteDes := IIF((fCfgSis('IMPREF', varBoolean)), strIteDesAux, FstrIteDes);
      FstrNumLot := fRetornaNumLote(qryDet.FieldByName('ITE_CODITE').AsString);
      FstrCodGru := qryDet.FieldByName('ITE_CODGRU').AsString;
      FstrDesFab := qryDet.FieldByName('ITE_DESFAB').AsString;
      FstrUnidad := qryDet.FieldByName('UNI_CODUNI').AsString;
      FstrCodUni := qryDet.FieldByName('UNI_CODUNI').AsString;
      FstrCodMar := qryDet.FieldByName('ITE_CODMAR').AsString;
      FstrCodFor := qryDet.FieldByName('ITE_CODFOR').AsString;
      FstrRefere := qryDet.FieldByName('ITE_REFERE').AsString;

      FfltUniOri := FVlrUni;
      FfltUniVis := FVlrUni;
      FfltUniTar := FVlrUni;
      FfltUniDig := FVlrUni;
      FfltTotIte := FVlrTot;

      FfltPreCus := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FfltTotCus := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FstrComLub := qryDet.FieldByName('ITE_COMLUB').AsString;
      FfltIpiSai := qryDet.FieldByName('ITE_IPISAI').AsFloat;
      FfltDesMax := qryDet.FieldByName('ITE_DESMAX').AsFloat;
      FfltPreVe1 := qryDet.FieldByName('ITE_PREVE1').AsFloat;
      FfltPreVe2 := qryDet.FieldByName('ITE_PREVE2').AsFloat;
      FfltPreVe3 := qryDet.FieldByName('ITE_PREVE3').AsFloat;
      FfltPreVe4 := qryDet.FieldByName('ITE_PREVE4').AsFloat;
      FfltPreVe5 := qryDet.FieldByName('ITE_PREVE5').AsFloat;
      FfltPreVe6 := qryDet.FieldByName('ITE_PREVE6').AsFloat;
      FfltPreVe7 := qryDet.FieldByName('ITE_PREVE7').AsFloat;
      FfltSaldos := qryDet.FieldByName('ITE_SALDOS').AsFloat;
      FfltComVar := qryDet.FieldByName('ITE_COMVAR').AsFloat;
      FfltComAta := qryDet.FieldByName('ITE_COMATA').AsFloat;
      FfltComDis := qryDet.FieldByName('ITE_COMDIS').AsFloat;
      FfltTotUlt := qryDet.FieldByName('ITE_PREULT').AsFloat;
      FfltImpUlt := qryDet.FieldByName('ITE_IMPULT').AsFloat;
      FfltPreUlt := qryDet.FieldByName('ITE_PREULT').AsFloat;
      FfltPreMed := qryDet.FieldByName('ITE_PREMED').AsFloat;
      FstrClaIpi := qryDet.FieldByName('ITE_CLAIPI').AsString;
      FstrCodAbf := qryDet.FieldByName('ITE_CODABF').AsString;
      FfltPesoIt := qryDet.FieldByName('ITE_PESOIT').AsFloat;
      FfltPesLiq := qryDet.FieldByName('ITE_PESLIQ').AsFloat;
      FstrCodFab := qryDet.FieldByName('ITE_CODFAB').AsString;
      FfltMarMin := qryDet.FieldByName('ITE_MARMIN').AsFloat;
      FfltMarMSG := qryDet.FieldByName('ITE_MARMSG').AsFloat;
      FfltMarMGe := qryDet.FieldByName('ITE_MARMGE').AsFloat;
      FfltPreCom := qryDet.FieldByName('ITE_PRECOM').AsFloat;
      FfltQtdPon := qryDet.FieldByName('ITE_QTPPRO').AsFloat;
      FstrObrCpf := qryDet.FieldByName('ITE_OBRCPF').AsString;
      FstrSigUni := qryDet.FieldByName('UNI_SIGUNI').AsString;
      FfltIpiEnt := qryDet.FieldByName('ITE_IPIENT').AsFloat;
      FfltFreEnt := qryDet.FieldByName('ITE_FREENT').AsFloat;
      FstrImpDir := qryDet.FieldByName('ITE_IMPDIR').AsString;
      FstrCodBar := qryDet.FieldByName('ITE_CODBAR').AsString;
      FfltCusIte := qryDet.FieldByName('ITE_PRECUS').AsFloat;
      FfltTotImp := qryDet.FieldByName('ITE_IMPULT').AsFloat;
    End;
  Finally
    FreeAndNil(qryDet);
  End;
end;

procedure TItemRecebido.pExcluiDocumentoRecebido;
var
  qryExclui: TUniQuery;
begin
  qryExclui := fCriaQuery;

  try
    qryExclui.Close;
    qryExclui.SQL.Clear;
    qryExclui.SQL.Add('DELETE FROM ITEREC');
    qryExclui.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryExclui.ParamByName('AUTINC').AsString := FAutInc;
    qryExclui.ExecSQL;
  finally
    FreeAndNil(qryExclui);
  end;
end;

procedure TItemRecebido.pLimpar;
begin
  FAutInc := EmptyStr;
  FCodIte := EmptyStr;
  FDesIte := EmptyStr;
  FstrTipRec  := EmptyStr;
  FQtdIte := 0;
  FVlrUni := 0;
  FVlrTot := 0;
  FEhAlteracao := False;
end;

procedure TItemRecebido.SetAutInc(const Value: String);
begin
  FAutInc := Value;
end;

procedure TItemRecebido.SetCodIte(const Value: String);
begin
  FCodIte := Value;
end;

procedure TItemRecebido.SetDesIte(const Value: String);
begin
  FDesIte := Value;
end;

procedure TItemRecebido.SetEhAlteracao(const Value: Boolean);
begin
  FEhAlteracao := Value;
end;

procedure TItemRecebido.SetQtdIte(const Value: Double);
begin
  FQtdIte := Value;
end;

procedure TItemRecebido.SetTipRec(const Value: TTipoRecebido);
begin
  FTipRec := Value;
end;

procedure TItemRecebido.SetVlrTot(const Value: Double);
begin
  FVlrTot := Value;
end;

procedure TItemRecebido.SetVlrUni(const Value: Double);
begin
  FVlrUni := Value;
end;

end.
