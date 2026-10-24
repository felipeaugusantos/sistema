unit Contabilidade.Classes.TImportacaoDadosContabeis;

interface

uses cxProgressBar, Classes, Contabilidade.Interfaces, untExcel,
     System.SysUtils, System.Generics.Collections, Uni, Data.DB, UniClientDataset,
     Contabilidade.Classes.CfgContabil;

type
  TStringArrayTitulosImportacao = array of string;

  TImportacaoDadosContabeis = (tidcPlanoContas, tidcHistoricoPadrao, tidcPlanoReferencial, tidcDemonstrativoECF, tidcLancamentosContabeis, tidcSaldosIniciais, tidcTransfSaldosPlanco, tidcSaldosIniciaisSubconta, tidcParametrosContabilizacao, tidcConfiguracoes) ;
  TTipoDadosContabeis = (tdcInt, tdcStr, tdcDate, tdcFloat) ;

  TInfoColunaDadosContabeis = class
  private
    FblnObrigatoria: Boolean ;
    FstrDescricao: String ;
  public
    property Obrigatoria: Boolean read FblnObrigatoria write FblnObrigatoria ;
    property Descricao: String read FstrDescricao write FstrDescricao  ;
  end ;

  TListInfoColunaDadosContabeis = TObjectList<TInfoColunaDadosContabeis> ;

  TLanConInfo = class
  strict private
    strCON_EMPLAN : string ;
    dtaCON_DTALAN : TDateTime ;
    strCON_CONCRE : string ;
    strCON_CONDEB : string ;
    intCON_HISPAD : Integer ;
    strCON_HISTOR : string ;
    fltCON_VALLAN : double ;
    strCON_CCUSTO : string ;
    strCON_CCUSCR : string ;
    strCON_INCDOC : string ;
    FstrCON_CLIFOR : string ;
    FstrCON_TIP_FC : string ;
    FstrLINHA : string ;
  public
    property CON_EMPLAN : string read strCON_EMPLAN write strCON_EMPLAN ;
    property CON_DTALAN : TDateTime read dtaCON_DTALAN write dtaCON_DTALAN ;
    property CON_CONCRE : string read strCON_CONCRE write strCON_CONCRE ;
    property CON_CONDEB : string read strCON_CONDEB write strCON_CONDEB ;
    property CON_HISPAD : Integer read intCON_HISPAD write intCON_HISPAD ;
    property CON_HISTOR : string read strCON_HISTOR write strCON_HISTOR ;
    property CON_VALLAN : double read fltCON_VALLAN write fltCON_VALLAN ;
    property CON_CCUSTO : string read strCON_CCUSTO write strCON_CCUSTO ;
    property CON_CCUSCR : string read strCON_CCUSCR write strCON_CCUSCR ;
    property CON_INCDOC : string read strCON_INCDOC write strCON_INCDOC ;
    property CON_CLIFOR : string read FstrCON_CLIFOR write FstrCON_CLIFOR ;
    property CON_TIP_FC : string read FstrCON_TIP_FC write FstrCON_TIP_FC ;
    property LINHA      : string read FstrLINHA write FstrLINHA ;
  end;

  TPlancoInfo = record
    strNCO_CODCON : string ;
    strNCO_DESCRI : string ;
    strNCO_CONRED : string ;
    strNCO_TPLACO : string ;
    intNCO_APURAC : integer ;
    strNCO_NATURE : string ;
    strNCO_FINALI : string ;
    strNCO_CTAREF : string ;
    strNCO_REDUTO : string ;
    strNCO_PATRIM : string ;
  end;

  THispadInfo = record
    intPAD_CODIGO : integer ;
    strPAD_DESCRI : string ;
  end;

  TTspCoaInfo = record
    strCOA_CODEMP : string ;
    strCOA_COMPET : string ;
    strCOA_PLAANT : string ;
    strCOA_PLANOV : string ;
    strCOA_INDSIT : string ;
    fltCOA_VALLAN : double ;
  end;

  TPlaIniInfo = record
    strINI_CODEMP : String ;
    strINI_EXERCI : String ;
    strINI_CODCON : String ;
    fltINI_SALINI : double ;
    strINI_CREDEB : String ;
    strINI_CCUSTO : String ;
  end;

  TDprIniInfo = record
    strINI_CODEMP : String ;
    strINI_EXERCI : String ;
    strINI_CODCON : String ;
    fltINI_SALINI : double ;
    strINI_CREDEB : String ;
    strINI_CLIFOR : String ;
    strINI_TIP_FC : String ;
  end;

  TCmpParInfo = record
    strPAR_SEQPAR : string ;
    strPAR_MD5KEY : string ;
    strPAR_COMPLE : string ;
  end;

  TParNcoInfo = record
    strNCO_CODEMP : string ;
    strNCO_CREDEB : string ;
    strNCO_MD5KEY : string ;
    strCON_SEQPAR : string ;
    strNCO_CODCON : string ;
  end;

  TParConInfo = record
    strCON_SEQPAR : string ;
    strCON_TIPLAN : string ;
    strCON_FORPGO : string ;
    strCON_NATOPE : string ;
    strCON_DESVAL : string ;
    strCON_CLAFIS : string ;
    strCON_CONCRE : string ;
    intCON_CFCRED : Integer ;
    intCON_PORCRE : Integer ;
    intCON_HISCRE : Integer ;
    strCON_CONDEB : string ;
    intCON_CFDEBI : Integer ;
    intCON_PORDEB : Integer ;
    intCON_PCCRED : Integer ;
    intCON_PCDEBI : Integer ;
    strCON_NATCFO : string ;
    strCON_NATCFO_AUTOINCREM : string ;
    strCON_PAGAME : string ;
    strCON_ORIGEM : string ;
    strCON_TIPPCD : string ;
    strCON_TIPPCC : string ;
    intCON_BANDEB : Integer ;
    intCON_BANCRE : Integer ;
    intCON_ABFDEB : Integer ;
    intCON_ABFCRE : Integer ;
    strCON_PAGANT : string ;
    strCON_TITPDD : string ;
    strCON_CODTRI : string ;
    strCON_CODORI : string ;
    strCON_VIGINI : string ;
    strCON_VIGFIN : string ;
    strCON_CODGRU : string ;
    strCON_ORICPC : string ;
    strCON_MD5CLA : string;
    strCON_CODEMP : string;
  end;

  TCfgSisInfo = record
    strSIS_CODCFG : string ;
    strSIS_VALCFG : string ;
  end;

  TPlanreInfo = record
    strNRE_CODREF : string ;
    strNRE_DESCRI : string ;
    dtaNRE_DTAINI : TDate ;
    dtaNRE_DTAFIN : TDate ;
    strNRE_TIPCTA : string ;
    strNRE_CTASUP : string ;
    intNRE_NIVEL_ : integer ;
    intNRE_NATURE : integer ;
    strNRE_ORIENT : string ;
  end;

  TEcfDemGrupo01 = record
    strDEM_CODDEM : string ;
    strDEM_DESCRI : string ;
    dtaDEM_DTAINI : TDate ;
    dtaDEM_DTAFIN : TDate ;
    strDEM_TIPDEM : string ;
    strDEM_FMTDEM : string ;
    strDEM_ORIENT : string ;
  end;

  TEcfDemGrupo02 = record
    strDEM_CODDEM : string ;
    strDEM_DESCRI : string ;
    dtaDEM_DTAINI : TDate ;
    dtaDEM_DTAFIN : TDate ;
    strDEM_TIPDEM : string ;
    strDEM_FMTDEM : string ;
    strDEM_TIPLAN : string ;
    strDEM_ORIENT : string ;
    strDEM_RELACI : string ;
  end;

  TEcfDemGrupo03 = record
    strDEM_CODDEM : string ;
    strDEM_DESCRI : string ;
    dtaDEM_DTAINI : TDate ;
    dtaDEM_DTAFIN : TDate ;
    strDEM_TIPDEM : string ;
    strDEM_FMTDEM : string ;
    strDEM_TIPLAN : string ;
    strDEM_RELACI : string ;
  end;

  TEcfDemGrupo04 = record
    strDEM_CODDEM : string ;
    strDEM_DESCRI : string ;
    dtaDEM_DTAINI : TDate ;
    dtaDEM_DTAFIN : TDate ;
    strDEM_TIPDEM : string ;
    strDEM_FMTDEM : string ;
  end;

  TEcfDemGrupo05 = record
    strDEM_CODDEM : string ;
    strDEM_DESCRI : string ;
    dtaDEM_DTAINI : TDate ;
    dtaDEM_DTAFIN : TDate ;
    strDEM_ORDEM_ : string ;
    strDEM_TIPDEM : string ;
    strDEM_FMTDEM : string ;
  end;

  IImportacaoDadosContabeis = Interface
    ['{4100B0AD-B59E-46E2-AAED-36062366895A}']
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean ;
    function fPersisteDados:boolean ;
    function fColunas:TListInfoColunaDadosContabeis ;
    function fGetErrosCarregamento: TUniClientDataSet;
  End;

  IImportacaoDadosContabeisFonte = interface
    ['{4BBADB03-2AEF-4AF7-A9F2-79F176563C76}']
    function fQntLinhas: Integer; //incluindo cabecalho, se tiver
    function fQntColunas: Integer;
    function fTemCabecalho: Boolean;
    function fGetDadosCelula(const AintCol, AintRow: Integer; out AstrCelula: string): string; //coluna e linha sempre 0-based
  end;

  EImportacaoDadosContabeis = class(Exception);
  EImportacaoDadosContabeisExcel = class(EImportacaoDadosContabeis);

  TDictFontesComplementares = TDictionary<string, IImportacaoDadosContabeisFonte>;
  TDictMapaCodigosHispad = TDictionary<Integer, Integer>;

  IImportacaoDadosContabeisFactory = interface
    ['{6C1D3CCB-5430-47C3-9900-D8F3EBC0585E}']
    function fImportacao(idcTipImp: TImportacaoDadosContabeis; pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const strRegistro: string = ''; const strBloco: string = ''; const strTipLan: string = ''; cdsPlanco: TUniClientDataset = nil; AFontesComplementares: TDictFontesComplementares = nil; ACfgContabil: ICfgContabil = nil; AblnControlaTransacaoLocal: Boolean = True; AMapaCodigosHispad: TDictMapaCodigosHispad = nil): IImportacaoDadosContabeis; overload;
    function fImportacao(idcTipImp: TImportacaoDadosContabeis; pgbProgresso: TcxProgressBar; excExcel: TExcel; blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco, strTipLan: string; cdsPlanco: TUniClientDataset): IImportacaoDadosContabeis; overload;
  end;

  TMensagemErroDadosContabeis = class
  private
    FlstMensagensErros : TStringList ;
    FlstLinhasErros : TStringList ;
    FblnSuprimirDialogoFinal: Boolean;
  public
    procedure pRegistraMensagemErro(Const strMensagem:string; Const intLinha:integer=-1) ;
    function fTemMensagemErro: boolean ;
    function fTemLinhaComErro(Const intLinhaArray: integer):boolean ;
    procedure pMostraMensagemErro(Const blnAbortado: boolean; const AblnForcar: Boolean = False) ;
    procedure pSetSuprimirDialogoFinal(const AblnSuprimirDialogoFinal: Boolean);
    function fGetComoDataSet(const AstrTabela: string): TUniClientDataSet;
    constructor Create;
    destructor Destroy; override;
  end;

  TCriaColunaDadosContabeis = class
  public
    class function fColuna(const AstrDescricao: String; const AblnObrigatoria: Boolean): TInfoColunaDadosContabeis ;
  end ;

  TImportacaoDadosContabeisBase = Class(TInterfacedObject, IImportacaoDadosContabeis)
  private
    function fValidaDadosInt(Const strValor, strCelula: string):integer ;
    function fValidaDadosDate(Const strValor, strCelula: string):TDate ;
    function fValidaDadosFloat(Const strValor, strCelula: string): double;
  protected
    FblnIgnorarErrosImportacao : boolean ;
    FblnControlaTransacaoLocal: Boolean;
    FblnImportacaoOrquestrada: Boolean;
    FMensagemErroDadosContabeis : TMensagemErroDadosContabeis ;
    FqryExec : TUniQuery ;
    FFonte: IImportacaoDadosContabeisFonte;
    FCfgContabil: ICfgContabil;
    pgbProgresso : TcxProgressBar;
    FListInfoColunaDadosContabeis : TListInfoColunaDadosContabeis ;
    procedure pCarregaInfoColunas; virtual; abstract ;
    procedure pMensagemSucesso ;
    function fGetDadosCelula(const intCol,intLinha:integer; tdcTipo: TTipoDadosContabeis = tdcStr; const AblnNormalizaMaiusculo: Boolean = True): variant ;
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pStartTransactionImportacao ;
    procedure pRollbackImportacao ;
    procedure pCommitImportacao ;
    function fValidaCabecalho: boolean ;
    function fGetSqlInsert:string; virtual; abstract ;
    function fIndicePrimeiroRegistro: Integer;
    function fGetNomeTabela: string; virtual;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; virtual; abstract ;
    function fPersisteDados:boolean; virtual; abstract ;
    function fColunas:TListInfoColunaDadosContabeis;
    function fQtdLinhas(var AintQtdLinhas: Integer): Boolean ;
    procedure pSetControlaTransacaoLocal(const AblnControlaTransacaoLocal: Boolean);
    function fGetControlaTransacaoLocal: Boolean;
    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
    function fGetErrosCarregamento: TUniClientDataSet;
  end ;

const
  DES_IMPORTACAODADOSCONTABEIS : Array[TImportacaoDadosContabeis] Of String = ('PLANCO',
                                                                               'HISPAD',
                                                                               'PLANRE',
                                                                               'ECFDEM',
                                                                               'LANCON',
                                                                               'PLAINI',
                                                                               'TSPCOA',
                                                                               'DPRINI',
                                                                               'PARCON',
                                                                               'CFGSIS');

implementation

uses untFuncoesSimples,
Contabilidade.Funcoes, Contabilidade.View.ImportacaoDadosContabeisMensagem, strUtils, Vcl.StdCtrls,
Vcl.Forms ;

{ TMensagemErroDadosContabeis }

constructor TMensagemErroDadosContabeis.Create;
begin
  inherited;
  FlstMensagensErros := TStringList.Create ;
  FlstLinhasErros  := TStringList.Create ;
  FlstLinhasErros.Sorted := True ;
  FblnSuprimirDialogoFinal := False;
end;

destructor TMensagemErroDadosContabeis.Destroy;
begin
  FreeAndNil(FlstMensagensErros) ;
  FreeAndNil(FlstLinhasErros) ;
  inherited;
end;

function TMensagemErroDadosContabeis.fTemLinhaComErro(
  const intLinhaArray: integer): boolean;
begin
  //// 2 Incluir o Indice do Titulo
  result := FlstLinhasErros.IndexOf(IntToStr(intLinhaArray+2)) <> -1 ;
end;

function TMensagemErroDadosContabeis.fTemMensagemErro: boolean;
begin
  result := FlstMensagensErros.Count > 0 ;
end;

procedure TMensagemErroDadosContabeis.pMostraMensagemErro(Const blnAbortado: boolean; const AblnForcar: Boolean = False);
var
  frmImportacoesContabeisMensagem : TfrmImportacoesContabeisMensagem ;
  strAux : string ;
begin
  if FblnSuprimirDialogoFinal and (not AblnForcar) then
    Exit;

  pCriarFormularios(TfrmImportacoesContabeisMensagem, frmImportacoesContabeisMensagem);
  try
    if blnAbortado then
      strAux := 'Importação abortada!'
    else
      strAux := 'Importação concluida com sucesso, porém algumas linhas foram ignoradas!' ;

    frmImportacoesContabeisMensagem.strMensagem := strAux + #13#10 + FlstMensagensErros.Text ;
    frmImportacoesContabeisMensagem.ShowModal ;
  finally
    pFreeAndNil(frmImportacoesContabeisMensagem);
  end;
end;

procedure TMensagemErroDadosContabeis.pRegistraMensagemErro(
  const strMensagem: string; const intLinha: integer);
begin
  FlstMensagensErros.Add(strMensagem) ;
  FlstLinhasErros.Add(inttostr(intLinha)) ;
end;

procedure TMensagemErroDadosContabeis.pSetSuprimirDialogoFinal(
  const AblnSuprimirDialogoFinal: Boolean);
begin
  FblnSuprimirDialogoFinal := AblnSuprimirDialogoFinal;
end;

{ TCriaColunaDadosContabeis }

class function TCriaColunaDadosContabeis.fColuna(const AstrDescricao: String;
  const AblnObrigatoria: Boolean): TInfoColunaDadosContabeis;
begin
  Result := TInfoColunaDadosContabeis.Create ;
  Result.Obrigatoria := AblnObrigatoria ;
  Result.Descricao := AstrDescricao ;
end;

{ TImportacaoDadosContabeisBase }

constructor TImportacaoDadosContabeisBase.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  ACfgContabil: ICfgContabil);
begin
  FqryExec := fCriaQuery(Nil);
  FMensagemErroDadosContabeis := TMensagemErroDadosContabeis.Create ;
  Self.pgbProgresso := pgbProgresso;
  FFonte := AFonte;
  FblnIgnorarErrosImportacao := blnIgnorarErrosImportacao ;
  FblnControlaTransacaoLocal := True;
  FblnImportacaoOrquestrada := False;
  if Assigned(ACfgContabil) then
    FCfgContabil := ACfgContabil
  else
    FCfgContabil := TCfgContabilDefault.New;
  FListInfoColunaDadosContabeis := TListInfoColunaDadosContabeis.Create ;
  pCarregaInfoColunas ;
end;

destructor TImportacaoDadosContabeisBase.Destroy;
begin
  FreeAndNil(FqryExec) ;
  FreeAndNil(FMensagemErroDadosContabeis) ;
  FreeAndNil(FListInfoColunaDadosContabeis) ;
  inherited;
end;

function TImportacaoDadosContabeisBase.fColunas: TListInfoColunaDadosContabeis;
begin
  result := FListInfoColunaDadosContabeis ;
end;

function TImportacaoDadosContabeisBase.fGetDadosCelula(const intCol,
  intLinha: integer; tdcTipo: TTipoDadosContabeis;
  const AblnNormalizaMaiusculo: Boolean): variant;
var
  strAux, strCelula : string ;
begin
  strCelula := '(' + IntToStr(intCol) + ',' + IntToStr(intLinha) + ')';
  try
    strAux := FFonte.fGetDadosCelula(intCol, intLinha, strCelula);
  except
    on E: EImportacaoDadosContabeis do
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro(
        'Problemas ao ler a célula ' + strCelula + ': ' + E.Message,
        intLinha + 2
      );
      strAux := '';
    end;
    on E: Exception do
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro(
        'Erro interno ao ler a célula ' + strCelula + ': ' + E.Message,
        intLinha + 2
      );
      strAux := '';
    end;
  end;

  if fEmptyStr(strAux) then
  begin
    if FListInfoColunaDadosContabeis.Items[intCol].Obrigatoria then
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro('Valor obrigatório: Verifique a célula '+strCelula, intLinha);
    end;
  end;

  if tdcTipo = tdcInt then
  begin
    result := fValidaDadosInt(strAux, strCelula) ;
  end
  else if tdcTipo = tdcDate then
  begin
    result := fValidaDadosDate(strAux, strCelula) ;
  end
  else if tdcTipo = tdcFloat then
  begin
    result := fValidaDadosFloat(strAux, strCelula) ;
  end
  else /////string
  begin
    if AblnNormalizaMaiusculo then
      result := ReplaceStr(AnsiUpperCase(strAux),#39,'')
    else
      result := ReplaceStr(strAux,#39,'');
  end;
end;

function TImportacaoDadosContabeisBase.fIndicePrimeiroRegistro: Integer;
begin
  if FFonte.fTemCabecalho then
    Result := 1
  else
    Result := 0;
end;

function TImportacaoDadosContabeisBase.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TImportacaoDadosContabeisBase.fQtdLinhas(
  var AintQtdLinhas: Integer): Boolean;
var
  LstrMensagemErro: String ;
begin
  try
    AintQtdLinhas := FFonte.fQntLinhas ;
  except
    on EEx: EImportacaoDadosContabeisExcel do
    begin
      Result := False ;
      LstrMensagemErro := 'Problemas ao carregar planilha de dados:'+
                          #13+ '1) Verifique se o Microsoft Excel/LibreOffice Calc está instalado'+
                          #13+ '2) Verifique se há algum processo do Microsoft Excel/LibreOffice Calc no gerenciador de tarefas do windows e finalize-os'+
                          #13+ 'Problema Retornado:' + EEx.Message ;
      fMensagem('ATENÇÃO', LstrMensagemErro, ['&OK']);
      exit ;
    end;

    on EI: EImportacaoDadosContabeis do
    begin
      Result := False;
      fMensagem('ATENÇÃO', 'Erro ao ler importação: ' + EI.Message, ['&OK']);
      exit;
    end;

    on E: Exception do
    begin
      Result := False;
      fMensagem('ATENÇÃO', 'Erro interno: ' + E.Message, ['&OK']);
      exit;
    end;
  end;
  Result := True ;
end;

function TImportacaoDadosContabeisBase.fValidaCabecalho: boolean;
var
  intCol : integer ;
  strDadosCelula, strCelula, strMensagem: string ;
begin
  if not FFonte.fTemCabecalho then
  begin
    Result := True;
    Exit;
  end;

  Result := False;
  for intCol := 0 to FListInfoColunaDadosContabeis.Count-1 do
  begin
    strDadosCelula := FFonte.fGetDadosCelula(intCol, 0, strCelula);
    if trim(strDadosCelula) <> trim(FListInfoColunaDadosContabeis.Items[intCol].Descricao) then
    begin
      strMensagem := 'Problemas ao validar cabeçalho!'+#13+#10+'Na célula ('+strCelula+') esperado ['+FListInfoColunaDadosContabeis.Items[intCol].Descricao+'] encontrado ['+strDadosCelula+']' ;
      fMensagem('ATENÇÃO',strMensagem,['&OK']);
      exit ;
    end;
  end;
  result := True ;
end;

function TImportacaoDadosContabeisBase.fValidaDadosDate(Const strValor, strCelula: string): TDate;
begin
  result := 0 ;
  if fEmptyStr(strValor) then
  begin
    exit ;
  end;

  try
    if pos('/', strValor) > 0 then
      result := strToDate(ReplaceStr(strValor,#39,''))
    else
      result := FloatToDateTime(strTofloat(ReplaceStr(strValor,#39,''))) ;
  except
    on E : Exception do
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro(Format('Problemas ao converter o valor da posição %s em data!', [strCelula]));
    end;
  end;

end;

function TImportacaoDadosContabeisBase.fValidaDadosFloat(Const strValor, strCelula: string): double;
begin
  result := 0 ;
  if fEmptyStr(strValor) then
  begin
    exit ;
  end;

  try
    result := strTofloat(ReplaceStr(ReplaceStr(strValor,#39,''),'.',',')) ;
  except
    on E : Exception do
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro(Format('Problemas ao converter o valor da posição %s em número!', [strCelula]));
    end;
  end;
end;

function TImportacaoDadosContabeisBase.fValidaDadosInt(Const strValor, strCelula: string): integer;
begin
  result := 0 ;
  if fEmptyStr(strValor) then
  begin
    exit ;
  end;
  try
    result := strToint(ReplaceStr(strValor,#39,'')) ;
  except
    on E : Exception do
    begin
      FMensagemErroDadosContabeis.pRegistraMensagemErro(Format('Problemas ao converter o valor da posição %s em número!', [strCelula]));
    end;
  end;
end;

procedure TImportacaoDadosContabeisBase.pCommitImportacao;
begin
  if (not FblnIgnorarErrosImportacao) and FblnControlaTransacaoLocal then
    fCommit;
end;

function TImportacaoDadosContabeisBase.fGetControlaTransacaoLocal: Boolean;
begin
  Result := FblnControlaTransacaoLocal;
end;

procedure TImportacaoDadosContabeisBase.pMensagemSucesso;
begin
  if FblnImportacaoOrquestrada then
    Exit;

  fMensagem('ATENÇÃO','Arquivo importado com sucesso!',['&OK']);
end;

procedure TImportacaoDadosContabeisBase.pRollbackImportacao;
begin
  if (not FblnIgnorarErrosImportacao) and FblnControlaTransacaoLocal then
    fRollBack ;
end;

procedure TImportacaoDadosContabeisBase.pSetControlaTransacaoLocal(
  const AblnControlaTransacaoLocal: Boolean);
begin
  FblnControlaTransacaoLocal := AblnControlaTransacaoLocal;
  FblnImportacaoOrquestrada := not AblnControlaTransacaoLocal;
  FMensagemErroDadosContabeis.pSetSuprimirDialogoFinal(FblnImportacaoOrquestrada);
end;


procedure TImportacaoDadosContabeisBase.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TImportacaoDadosContabeisBase.pStartTransactionImportacao;
begin
  if (not FblnIgnorarErrosImportacao) and FblnControlaTransacaoLocal then
    fStartTransaction;
end;

function TImportacaoDadosContabeisBase.fGetNomeTabela: string;
begin
  Result := '';
end;

function TImportacaoDadosContabeisBase.fGetErrosCarregamento: TUniClientDataSet;
begin
  Result := FMensagemErroDadosContabeis.fGetComoDataSet(fGetNomeTabela);
end;

{ TMensagemErroDadosContabeis - fGetComoDataSet }

function TMensagemErroDadosContabeis.fGetComoDataSet(const AstrTabela: string): TUniClientDataSet;
var
  intCnt: Integer;
begin
  Result := fCriarDataSetErros;
  for intCnt := 0 to FlstMensagensErros.Count - 1 do
  begin
    Result.Insert;
    Result.FieldByName('ERR_STATUS').AsString := 'EE';
    Result.FieldByName('ERR_CHVDOC').AsString := AstrTabela;
    Result.FieldByName('ERR_MOTIVO').AsString := FlstMensagensErros[intCnt];
    Result.FieldByName('ERR_TABELA').AsString := AstrTabela;
    Result.Post;
  end;
end;

end.
