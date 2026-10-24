unit Contabilidade.Classes.TImportacaoDadosContabeisPlanco;

interface

uses Uni, cxProgressBar, Classes, Data.DB,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     Contabilidade.Classes.TValidaProcessoContaContabil,
     System.Generics.Collections, Contabilidade.Interfaces,
     Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisPlanco = Class(TImportacaoDadosContabeisBase)
  private
    FarrPlanco : array of TPlancoInfo ;
    function fContaReduzidaAutomatica: boolean;
    function fgetNovaContaReduzida: string;
    function fIsContaReduzidaAutomatica(Const strNCO_CONRED : string):boolean ;
    function fConverteEstruturaParaValidacao(const AArr: array of TPlancoInfo):TList<TDadosValidacaoContaContabil> ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados:boolean; override;
  End;


implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls,
     StrUtils, Contabilidade.Funcoes;

{ TImportacaoDadosContabeisPlanco }

function TImportacaoDadosContabeisPlanco.fGetNomeTabela: string;
begin
  Result := 'PLANCO';
end;

function TImportacaoDadosContabeisPlanco.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  LDadosValidacao: TList<TDadosValidacaoContaContabil> ;
  LstrCodCon: String ;
  intQtdLinhas: integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Plano de Contas');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  SetLength(FarrPlanco,0);
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;
    LstrCodCon := copy(fSemMascaraPlaNco(fGetDadosCelula(0, intConLin, tdcStr)), 1, 20) ;
    if fEmptyStr(LstrCodCon) then
      Continue ;

    SetLength(FarrPlanco,Length(FarrPlanco)+1);
    intUltimo := High(FarrPlanco) ;
    FarrPlanco[intUltimo].strNCO_CODCON := LstrCodCon ;
    FarrPlanco[intUltimo].strNCO_DESCRI := copy(fGetDadosCelula(1, intConLin, tdcStr), 1, 100) ;
    FarrPlanco[intUltimo].strNCO_CONRED := copy(fGetDadosCelula(2, intConLin, tdcStr), 1, 20) ;
    FarrPlanco[intUltimo].strNCO_TPLACO := fStrZero(copy(fGetDadosCelula(3, intConLin, tdcStr), 1, 6), 6) ;
    FarrPlanco[intUltimo].intNCO_APURAC := fGetDadosCelula(4, intConLin, tdcInt);
    FarrPlanco[intUltimo].strNCO_NATURE := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 1) ;
    FarrPlanco[intUltimo].strNCO_FINALI := copy(fGetDadosCelula(6, intConLin, tdcStr), 1, 1) ;
    FarrPlanco[intUltimo].strNCO_CTAREF := copy(fGetDadosCelula(7, intConLin, tdcStr), 1, 20) ;
    FarrPlanco[intUltimo].strNCO_REDUTO := copy(fGetDadosCelula(8, intConLin, tdcStr), 1, 1) ;
    FarrPlanco[intUltimo].strNCO_PATRIM := copy(fGetDadosCelula(9, intConLin, tdcStr), 1, 1) ;
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

  ///valida as informa寤es carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrPlanco) ;
  try
    if not TValidaProcessoContaContabil.fValidaPlanoContasBloco(LDadosValidacao, AprocErros, '', False, FCfgContabil) then
    begin
      exit ;
    end;
  finally
    FreeAndNil(LDadosValidacao) ;
  end;

  result := True ;
end;

function TImportacaoDadosContabeisPlanco.fGetSqlInsert: string;
begin
  result := 'INSERT INTO PLANCO ' ;
  result := result + '( ' ;
  result := result + 'AUTOINCREM, ' ;
  result := result + 'NCO_CODCON, ' ;
  result := result + 'NCO_DESCRI, ' ;
  result := result + 'NCO_CONRED, ' ;
  result := result + 'NCO_TPLACO, ' ;
  result := result + 'NCO_APURAC, ' ;
  result := result + 'NCO_NATURE, ' ;
  result := result + 'NCO_FINALI, ' ;
  result := result + 'NCO_CTAREF, ' ;
  result := result + 'NCO_REDUTO, ' ;
  result := result + 'NCO_PATRIM ' ;
  result := result + ') ' ;
  result := result + 'VALUES ' ;
  result := result + '( ' ;
  result := result + ':AUTOINCREM, ' ;
  result := result + ':CODCON, ' ;
  result := result + ':DESCRI, ' ;
  result := result + ':CONRED, ' ;
  result := result + ':TPLACO, ' ;
  result := result + ':APURAC, ' ;
  result := result + ':NATURE, ' ;
  result := result + ':FINALI, ' ;
  result := result + ':CTAREF, ' ;
  result := result + ':REDUTO, ' ;
  result := result + ':PATRIM ' ;
  result := result + ') ;' ;
end;

function TImportacaoDadosContabeisPlanco.fPersisteDados: boolean;
var
  intCnt : integer ;
  strAutoInc : string ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Plano de Contas');
  pgbProgresso.Properties.Max := Length(FarrPlanco);

  pStartTransactionImportacao ;
  try
    FqryExec.Close ;
    FqryExec.SQL.Text := fGetSqlInsert ;
    for intCnt := Low(FarrPlanco) to High(FarrPlanco) do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;

        strAutoInc := fRetAutoIncrem('PLANCO', VS_strCodEmp) ;
        FqryExec.ParamByName('AUTOINCREM').AsString := strAutoInc;
        FqryExec.ParamByName('CODCON').AsString := FarrPlanco[intCnt].strNCO_CODCON;
        FqryExec.ParamByName('DESCRI').AsString := FarrPlanco[intCnt].strNCO_DESCRI;
        if fIsContaReduzidaAutomatica(FarrPlanco[intCnt].strNCO_CONRED) then
          FqryExec.ParamByName('CONRED').AsString := fgetNovaContaReduzida
        else
          FqryExec.ParamByName('CONRED').AsString := FarrPlanco[intCnt].strNCO_CONRED;
        FqryExec.ParamByName('TPLACO').AsString := FarrPlanco[intCnt].strNCO_TPLACO;
        FqryExec.ParamByName('APURAC').AsInteger := FarrPlanco[intCnt].intNCO_APURAC;
        FqryExec.ParamByName('NATURE').AsString := FarrPlanco[intCnt].strNCO_NATURE;
        FqryExec.ParamByName('FINALI').AsString := FarrPlanco[intCnt].strNCO_FINALI;
        FqryExec.ParamByName('CTAREF').AsString := FarrPlanco[intCnt].strNCO_CTAREF;
        FqryExec.ParamByName('REDUTO').AsString := FarrPlanco[intCnt].strNCO_REDUTO;
        FqryExec.ParamByName('PATRIM').AsString := FarrPlanco[intCnt].strNCO_PATRIM;
        FqryExec.ExecSQL ;
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

procedure TImportacaoDadosContabeisPlanco.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CLASSIFICA플O CONT핦IL*', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRI플O DA CONTA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA REDUZIDA', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO DO PLANO CONT핦IL*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('APURA플O', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NATUREZA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FINALIDADE*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA REFERENCIAL', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('REDUTORA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('PATRIMONIAL*', True)) ;
end;

function TImportacaoDadosContabeisPlanco.fIsContaReduzidaAutomatica(
  const strNCO_CONRED: string): boolean;
begin
  result := False ;
  if not fEmptyStr(strNCO_CONRED) then
    exit ;

  if not fContaReduzidaAutomatica then
    exit ;
  result := True ;
end;

function TImportacaoDadosContabeisPlanco.fContaReduzidaAutomatica: boolean;
begin
  Result := False;

  if (FCfgContabil.fCfgSis('CRDCON') = '1') then
  begin
    Result := True;
  end;
end;

function TImportacaoDadosContabeisPlanco.fConverteEstruturaParaValidacao(
  const AArr: array of TPlancoInfo): TList<TDadosValidacaoContaContabil>;
var
  intCnt: integer ;
  regItem: TDadosValidacaoContaContabil;
  intAutoInc: Integer ;
begin
  Result := TList<TDadosValidacaoContaContabil>.Create();
  intAutoInc := 0;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    inc(intAutoInc) ;
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.AContaContabil := AArr[intCnt].strNCO_CODCON;
    regItem.ATpLaco := AArr[intCnt].strNCO_TPLACO;
    regItem.AInicio := Default(TDate);
    regItem.AFinal := Default(TDate);
    regItem.AAutoInc := IntToStr(intAutoInc) ;
    regItem.AApurac := '0';
    regItem.AContaRef := AArr[intCnt].strNCO_CTAREF ;
    regItem.ADescricaoConta := AArr[intCnt].strNCO_DESCRI ;
    regItem.ANatureza := AArr[intCnt].strNCO_NATURE ;
    regItem.AFinalidade := AArr[intCnt].strNCO_FINALI ;
    regItem.ARedutora := AArr[intCnt].strNCO_REDUTO ;
    regItem.ANatAju := '' ;
    regItem.AAjuLiq := 'N' ;
    regItem.APatrimonial := AArr[intCnt].strNCO_PATRIM ;
    regItem.AContaReduzida := AArr[intCnt].strNCO_CONRED ;
    Result.Add(regItem) ;
  end;
end;

function TImportacaoDadosContabeisPlanco.fgetNovaContaReduzida: string;
begin
  Result := fRetSequencial('CRDSEQ', VS_strCodEmp, FCfgContabil.fCfgSis('CRDTAM', varInteger));
end;

end.
