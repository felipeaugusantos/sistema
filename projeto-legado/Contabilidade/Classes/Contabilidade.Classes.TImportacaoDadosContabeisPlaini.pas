unit Contabilidade.Classes.TImportacaoDadosContabeisPlaini;
interface

uses Uni, cxProgressBar, Classes, Data.DB, strUtils, System.Generics.Collections,
     Contabilidade.Classes.TImportacaoDadosContabeis, Contabilidade.Interfaces,
     Contabilidade.Classes.TValidaProcessoSaldoInicial, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisPlaIni = Class(TImportacaoDadosContabeisBase)
  private
    FarrPlaIni : array of TPlaIniInfo ;
    function fConverteEstruturaParaValidacao(const AArr: array of TPlaIniInfo):TList<TDadosValidacaoSaldoInicial> ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    procedure pApagaPlainiAnterior(const AstrCodemp, AstrExerci: String) ;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean ; override;
    function fPersisteDados:boolean ; override;

    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;

implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, Contabilidade.Funcoes;

{ TImportacaoDadosContabeisPlaIni }

function TImportacaoDadosContabeisPlaIni.fGetNomeTabela: string;
begin
  Result := 'PLAINI';
end;

constructor TImportacaoDadosContabeisPlaIni.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil) ;
end;

destructor TImportacaoDadosContabeisPlaIni.Destroy;
begin
  inherited;
end;

function TImportacaoDadosContabeisPlaIni.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  intQtdLinhas : integer ;
  LDadosValidacao: TList<TDadosValidacaoSaldoInicial> ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Saldos Iniciais');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;
  SetLength(FarrPlaIni,0);
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrPlaIni,Length(FarrPlaIni)+1);
    intUltimo := High(FarrPlaIni) ;

    FarrPlaIni[intUltimo].strINI_CODEMP := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 3) ;
    FarrPlaIni[intUltimo].strINI_EXERCI := copy(fGetDadosCelula(1, intConLin, tdcStr), 1, 4) ;
    FarrPlaIni[intUltimo].strINI_CODCON := copy(fSemMascaraPlaNco(fGetDadosCelula(2, intConLin, tdcStr)), 1, 20) ;
    FarrPlaIni[intUltimo].fltINI_SALINI := fGetDadosCelula(3, intConLin, tdcFloat) ;
    FarrPlaIni[intUltimo].strINI_CREDEB := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 1) ;
    FarrPlaIni[intUltimo].strINI_CCUSTO := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;

  End;

  if not FblnIgnorarErrosImportacao then
  begin
    if FMensagemErroDadosContabeis.fTemMensagemErro then
    begin
      if not FblnImportacaoOrquestrada then
        FMensagemErroDadosContabeis.pMostraMensagemErro(True) ;
      exit ;
    end;
  end;

  ///valida as informações carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrPlaIni) ;
  try
    if not TValidaProcessoSaldoInicial.fValidaSaldoInicialBloco(LDadosValidacao, AprocErros) then
    begin
      exit ;
    end;
  finally
    FreeAndNil(LDadosValidacao) ;
  end;

  result := True ;
end;

function TImportacaoDadosContabeisPlaIni.fConverteEstruturaParaValidacao(
  const AArr: array of TPlaIniInfo): TList<TDadosValidacaoSaldoInicial>;
var
  intCnt: Integer ;
  regItem: TDadosValidacaoSaldoInicial;
begin
  Result := TList<TDadosValidacaoSaldoInicial>.Create;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.AConta := AArr[intCnt].strINI_CODCON;
    regItem.AEmpresa := AArr[intCnt].strINI_CODEMP;
    regItem.AExercicio := AArr[intCnt].strINI_EXERCI;
    regItem.AValor := AArr[intCnt].fltINI_SALINI;
    regItem.ACreDeb := AArr[intCnt].strINI_CREDEB[1];
    regItem.ACCusto := AArr[intCnt].strINI_CCUSTO;

    Result.Add(regItem);
  end;
end;

function TImportacaoDadosContabeisPlaIni.fGetSqlInsert: string;
begin
  result := 'INSERT INTO PLAINI ' ;
  result := result + '( ' ;
  result := result + 'AUTOINCREM, ' ;
  result := result + 'INI_CODEMP, ' ;
  result := result + 'INI_EXERCI, ' ;
  result := result + 'INI_CODCON, ' ;
  result := result + 'INI_SALINI, ' ;
  result := result + 'INI_CREDEB, ' ;
  result := result + 'INI_CCUSTO, ' ;
  result := result + 'INI_DTAALT, ' ;
  result := result + 'INI_OPEALT  ' ;
  result := result + ') ' ;
  result := result + 'VALUES ' ;
  result := result + '( ' ;
  result := result + ':AUTOINCREM, ' ;
  result := result + ':CODEMP, ' ;
  result := result + ':EXERCI, ' ;
  result := result + ':CODCON, ' ;
  result := result + ':SALINI, ' ;
  result := result + ':CREDEB, ' ;
  result := result + ':CCUSTO, ' ;
  result := result + ':DTAALT, ' ;
  result := result + ':OPEALT  ' ;
  result := result + ') ;' ;
end;

function TImportacaoDadosContabeisPlaIni.fPersisteDados: boolean;
var
  intCnt : integer ;
  strAutoInc : string ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Saldos Iniciais');
  pgbProgresso.Properties.Max := Length(FarrPlaIni);

  pStartTransactionImportacao ;

  try

    if Length(FarrPlaIni) > 0 then
      pApagaPlainiAnterior(FarrPlaIni[0].strINI_CODEMP, FarrPlaIni[0].strINI_EXERCI) ;

    FqryExec.Close ;
    FqryExec.SQL.Clear ;
    FqryExec.SQL.Text := fGetSqlInsert ;
    for intCnt := Low(FarrPlaIni) to High(FarrPlaIni) do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;
        //ignora a linha caso tenha dado problema na validação da planilha
        if not FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
        begin
          strAutoInc := fRetAutoIncrem('PLAINI', VS_strCodEmp) ;
          FqryExec.ParamByName('AUTOINCREM').AsString := strAutoInc;
          FqryExec.ParamByName('CODEMP').AsString := FarrPlaIni[intCnt].strINI_CODEMP ;
          FqryExec.ParamByName('EXERCI').AsString := FarrPlaIni[intCnt].strINI_EXERCI ;
          FqryExec.ParamByName('CODCON').AsString := FarrPlaIni[intCnt].strINI_CODCON ;
          FqryExec.ParamByName('SALINI').AsFloat := FarrPlaIni[intCnt].fltINI_SALINI ;
          FqryExec.ParamByName('CREDEB').AsString := FarrPlaIni[intCnt].strINI_CREDEB ;
          FqryExec.ParamByName('CCUSTO').AsString := FarrPlaIni[intCnt].strINI_CCUSTO ;
          FqryExec.ParamByName('DTAALT').AsDateTime := fNow() ;
          FqryExec.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
          FqryExec.ExecSQL ;
        end;
      except
        on E1: Exception Do
        begin
          strMensagemErro := 'Problemas ao importar a linha '+inttostr(intCnt+2)+', erro: '+E1.Message ;
          if not FblnIgnorarErrosImportacao then
          begin
            blnAbortado := True ;
            raise Exception.Create(strMensagemErro);
          end
          else
          begin
            blnAbortado := False ;
            FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro) ;
          end;
        end;
      end;
    end;

    pCommitImportacao ;

  Except
    On E2: Exception Do
    Begin
      pRollbackImportacao ;
      FMensagemErroDadosContabeis.pRegistraMensagemErro(E2.Message) ;
    End;
  End;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada) ;
    exit ;
  end;

  pMensagemSucesso ;

  result := true ;
end;

procedure TImportacaoDadosContabeisPlaIni.pApagaPlainiAnterior(const AstrCodemp,
  AstrExerci: String);
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('SELECT * FROM PLAINI WHERE INI_CODEMP = :CODEMP AND INI_EXERCI = :EXERCI') ;
    LqryExec.ParamByName('CODEMP').AsString := AstrCodemp ;
    LqryExec.ParamByName('EXERCI').AsString := AstrExerci ;
    LqryExec.Open ;
    LqryExec.First ;

    while not LqryExec.Eof do
    begin
      fVerificaIntegridade('Contabilidade.Classes.TImportacaoDadosContabeisPlaini', 'PLAINI', LqryExec);
      LqryExec.Delete;
    end ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
end;

procedure TImportacaoDadosContabeisPlaIni.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('EMPRESA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('EXERCICIO*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA CONTABIL*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('SALDOS*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('D/C*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CENTRO DE CUSTO', False)) ;
end;

end.
