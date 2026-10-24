unit Contabilidade.Classes.TImportacaoDadosContabeisHispad;

interface

uses Uni, UniClientDataSet, cxProgressBar, Classes, Data.DB, System.Generics.Collections,
     Contabilidade.Classes.TImportacaoDadosContabeis, Contabilidade.Interfaces,
     Contabilidade.Classes.TValidaProcessoHistoricoPadrao,
     Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisHispad = Class(TImportacaoDadosContabeisBase)
  private
    FarrHispad : array of THispadInfo ;
    FblnHisTpl: Boolean;
    FstrTplaco: string;
    FintTamCam: Integer;
    FdctMapaCodigosImportados: TDictMapaCodigosHispad;
    function fConverteEstruturaParaValidacao(const AArr: array of THispadInfo):TList<TDadosValidacaoHistoricoPadrao> ;
    function fProximoCodigo: string;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetSqlDelete: string;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados:boolean; override;
    function fGetMapaCodigosImportados: TDictMapaCodigosHispad;

    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;


implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, strUtils,
     Contabilidade.Funcoes, Contabilidade.Classes.ProximoCodigoTPlaco;

{ TImportacaoDadosContabeisHispad }

function TImportacaoDadosContabeisHispad.fGetNomeTabela: string;
begin
  Result := 'HISPAD';
end;

constructor TImportacaoDadosContabeisHispad.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil) ;

  FdctMapaCodigosImportados := TDictMapaCodigosHispad.Create;
  FblnHisTpl := FCfgContabil.fCfgSisBoolean('HISTPL');
  FstrTplaco := fRetTplacoEmpresaLogada('', True);
  FintTamCam := fRetTamCampo('HISPAD');
  if FintTamCam <= 0 then
    FintTamCam := 12 ;
end;

destructor TImportacaoDadosContabeisHispad.Destroy;
begin
  FreeAndNil(FdctMapaCodigosImportados);
  inherited;
end;

function TImportacaoDadosContabeisHispad.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  intQtdLinhas : Integer ;
  LDadosValidacao: TList<TDadosValidacaoHistoricoPadrao> ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Histórico Padrão');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  SetLength(FarrHispad,0);

  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrHispad,Length(FarrHispad)+1);
    intUltimo := High(FarrHispad) ;

    FarrHispad[intUltimo].intPAD_CODIGO := fGetDadosCelula(0, intConLin, tdcInt);
    FarrHispad[intUltimo].strPAD_DESCRI := copy(fGetDadosCelula(1, intConLin, tdcStr), 1, 40) ;
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
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrHispad) ;
  try
    if not TValidaProcessoHistoricoPadrao.fValidaHistoricoPadraoBloco(LDadosValidacao, AprocErros, FCfgContabil) then
    begin
      exit ;
    end;
  finally
    FreeAndNil(LDadosValidacao) ;
  end;

  result := True ;
end;

function TImportacaoDadosContabeisHispad.fGetSqlInsert: string;
begin
  result := 'INSERT INTO HISPAD ' ;
  result := result + '( ' ;
  result := result + 'AUTOINCREM, ' ;
  result := result + 'PAD_CODIGO, ' ;
  result := result + 'PAD_DESCRI, ' ;
  result := result + 'PAD_TPLACO ' ;
  result := result + ') ' ;
  result := result + 'VALUES ' ;
  result := result + '( ' ;
  result := result + ':AUTOINCREM, ' ;
  result := result + ':CODIGO, ' ;
  result := result + ':DESCRI, ' ;
  result := result + ':TPLACO ' ;
  result := result + ') ;' ;
end;

function TImportacaoDadosContabeisHispad.fConverteEstruturaParaValidacao(
  const AArr: array of THispadInfo): TList<TDadosValidacaoHistoricoPadrao>;
var
  intCnt: Integer ;
  regItem: TDadosValidacaoHistoricoPadrao;
begin
  Result := TList<TDadosValidacaoHistoricoPadrao>.Create;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.ACodigo := AArr[intCnt].intPAD_CODIGO;
    regItem.ADescricao := AArr[intCnt].strPAD_DESCRI;
    Result.Add(regItem);
  end;
end;

function TImportacaoDadosContabeisHispad.fGetSqlDelete: string;
begin
  if FblnHisTpl then
    Result := 'DELETE FROM HISPAD WHERE IFNULL(PAD_TPLACO, "") = ' + FstrTplaco.QuotedString
  else
    Result := 'DELETE FROM HISPAD WHERE IFNULL(PAD_TPLACO, "") = ""';
end;

function TImportacaoDadosContabeisHispad.fPersisteDados: boolean;
var
  intCnt : integer ;
  intCodigoNovo: Integer;
  strAutoInc : string ;
  strCodigoNovo: string;
  strMensagemErro : string ;
  blnAbortado : boolean ;
  blnUsaProCod : boolean ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Histórico Padrão');
  pgbProgresso.Properties.Max := Length(FarrHispad);

  pStartTransactionImportacao ;

  try
    FqryExec.Close ;
    FqryExec.SQL.Clear ;
    FqryExec.SQL.Text := fGetSqlDelete;
    FqryExec.ExecSQL;

    FqryExec.SQL.Text := fGetSqlInsert ;
    blnUsaProCod := fUsaProCodigo('HISPAD') ;
    FdctMapaCodigosImportados.Clear;

    if blnUsaProCod then
      TProximoCodigoTPlaco.pGravar(0, 'HISPAD', FstrTplaco);

    for intCnt := Low(FarrHispad) to High(FarrHispad) do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;
        //ignora a linha caso tenha dado problema na validação da planilha
        if not FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
        begin
          strAutoInc := fRetAutoIncrem('HISPAD', VS_strCodEmp) ;
          FqryExec.ParamByName('AUTOINCREM').AsString := strAutoInc;
          if blnUsaProCod then
          begin
            strCodigoNovo := fProximoCodigo;
            FqryExec.ParamByName('CODIGO').AsString := strCodigoNovo;
            intCodigoNovo := StrToIntDef(strCodigoNovo, FarrHispad[intCnt].intPAD_CODIGO);
          end
          else
          begin
            FqryExec.ParamByName('CODIGO').AsInteger := FarrHispad[intCnt].intPAD_CODIGO ;
            intCodigoNovo := FarrHispad[intCnt].intPAD_CODIGO;
          end;
          FqryExec.ParamByName('DESCRI').AsString := FarrHispad[intCnt].strPAD_DESCRI ;

          if FblnHisTpl then
            FqryExec.ParamByName('TPLACO').AsString := FstrTplaco
          else
            FqryExec.ParamByName('TPLACO').Clear;
          FqryExec.ExecSQL ;

          FdctMapaCodigosImportados.AddOrSetValue(
            FarrHispad[intCnt].intPAD_CODIGO,
            intCodigoNovo
          );
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
      if FblnImportacaoOrquestrada then
        Raise;
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

function TImportacaoDadosContabeisHispad.fGetMapaCodigosImportados: TDictMapaCodigosHispad;
begin
  Result := FdctMapaCodigosImportados;
end;

function TImportacaoDadosContabeisHispad.fProximoCodigo: string;
var
  LstrCodigo: string;
begin
  if FblnHisTpl then
  begin
    LstrCodigo := TProximoCodigoTPlaco.fObterEGravar('HISPAD', FstrTplaco).ToString;
    Result := fPadL(LstrCodigo, FintTamCam, '0');
  end
  else
  begin
    LstrCodigo := fAtualizaProCod('HISPAD', 'PAD_CODIGO', '', 1, Nil,
      function (const AValue: String) : String
      begin
        Result := fPadL(AValue, FintTamCam, '0');
      end
    );
    Result := LstrCodigo;
  end;
end;

procedure TImportacaoDadosContabeisHispad.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True)) ;
end;

end.
