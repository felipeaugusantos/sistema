unit Contabilidade.Classes.TImportacaoDadosContabeisPlanre;


interface

uses Uni, cxProgressBar, Classes, Data.DB,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     Datasnap.DBClient, UniClientDataSet, Contabilidade.Interfaces, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisPlanre = Class(TImportacaoDadosContabeisBase)
  private
    FarrPlanre : array of TPlanreInfo ;
    FstrRegistro: string ;
    FstrBloco: string ;
    FCdsDataSet: TUniClientDataset ;
    function fGetSqlUpdate:string ;
    procedure pCarregaDataSet ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados:boolean; override;
    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco: string; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;


implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, StrUtils, Contabilidade.Funcoes;

{ TImportacaoDadosContabeisPlanre }

function TImportacaoDadosContabeisPlanre.fGetNomeTabela: string;
begin
  Result := 'PLANRE';
end;

constructor TImportacaoDadosContabeisPlanre.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco: string;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil) ;
  FstrRegistro := strRegistro ;
  FstrBloco := strBloco ;
  pCarregaDataSet ;
end;

destructor TImportacaoDadosContabeisPlanre.Destroy;
begin
  FreeAndNil(FCdsDataSet) ;
  inherited;
end;

function TImportacaoDadosContabeisPlanre.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  intQtdLinhas : integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Plano Referencial');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  SetLength(FarrPlanre,0);
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrPlanre,Length(FarrPlanre)+1);
    intUltimo := High(FarrPlanre) ;
    FarrPlanre[intUltimo].strNRE_CODREF := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrPlanre[intUltimo].strNRE_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrPlanre[intUltimo].dtaNRE_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrPlanre[intUltimo].dtaNRE_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrPlanre[intUltimo].strNRE_TIPCTA := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrPlanre[intUltimo].strNRE_CTASUP := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 20) ;
    FarrPlanre[intUltimo].intNRE_NIVEL_ := fGetDadosCelula(6, intConLin, tdcInt);
    FarrPlanre[intUltimo].intNRE_NATURE := fGetDadosCelula(7, intConLin, tdcInt);
    FarrPlanre[intUltimo].strNRE_ORIENT := fGetDadosCelula(8, intConLin, tdcStr) ;
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

  result := True ;
end;

function TImportacaoDadosContabeisPlanre.fGetSqlInsert: string;
begin
  result := 'INSERT INTO PLANRE ' ;
  result := result + '( ' ;
  result := result + 'NRE_CODREF, ' ;
  result := result + 'NRE_DESCRI, ' ;
  result := result + 'NRE_DTAINI, ' ;
  result := result + 'NRE_DTAFIN, ' ;
  result := result + 'NRE_TIPCTA, ' ;
  result := result + 'NRE_CTASUP, ' ;
  result := result + 'NRE_NIVEL_, ' ;
  result := result + 'NRE_NATURE, ' ;
  result := result + 'NRE_ORIENT, ' ;
  result := result + 'NRE_BLCECF, ' ;
  result := result + 'NRE_REGECF ' ;
  result := result + ') ' ;
  result := result + 'VALUES ' ;
  result := result + '( ' ;
  result := result + ':CODREF, ' ;
  result := result + ':DESCRI, ' ;
  result := result + ':DTAINI, ' ;
  result := result + ':DTAFIN, ' ;
  result := result + ':TIPCTA, ' ;
  result := result + ':CTASUP, ' ;
  result := result + ':NIVEL_, ' ;
  result := result + ':NATURE, ' ;
  result := result + ':ORIENT, ' ;
  result := result + ':BLCECF, ' ;
  result := result + ':REGECF ' ;
  result := result + ') ; ' ;
end;

function TImportacaoDadosContabeisPlanre.fGetSqlUpdate: string;
begin
  result := 'UPDATE PLANRE ' ;
  result := result + 'SET ' ;
  result := result + 'NRE_CODREF = :CODREF, ' ;
  result := result + 'NRE_DESCRI = :DESCRI, ' ;
  result := result + 'NRE_DTAINI = :DTAINI, ' ;
  result := result + 'NRE_DTAFIN = :DTAFIN, ' ;
  result := result + 'NRE_TIPCTA = :TIPCTA, ' ;
  result := result + 'NRE_CTASUP = :CTASUP, ' ;
  result := result + 'NRE_NIVEL_ = :NIVEL_, ' ;
  result := result + 'NRE_NATURE = :NATURE, ' ;
  result := result + 'NRE_ORIENT = :ORIENT, ' ;
  result := result + 'NRE_BLCECF = :BLCECF, ' ;
  result := result + 'NRE_REGECF = :REGECF ' ;
  result := result + 'WHERE ' ;
  result := result + 'NRE_CODREF = :CODREF AND ' ;
  result := result + 'NRE_DTAINI = :DTAINI AND ' ;
  result := result + 'NRE_BLCECF = :BLCECF AND ' ;
  result := result + 'NRE_REGECF = :REGECF ' ;
end;

function TImportacaoDadosContabeisPlanre.fPersisteDados: boolean;
var
  intCnt : integer ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Plano Referencial');
  pgbProgresso.Properties.Max := Length(FarrPlanre);

  pStartTransactionImportacao ;
  try
    for intCnt := Low(FarrPlanre) to High(FarrPlanre) do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;
        FqryExec.Close ;
        FqryExec.SQL.Clear ;
        if FCdsDataSet.FindKey([FarrPlanre[intCnt].strNRE_CODREF, FstrBloco, FstrRegistro, FarrPlanre[intCnt].dtaNRE_DTAINI]) then
        begin
          FqryExec.SQL.Text := fGetSqlUpdate ;
        end
        else
        begin
          FqryExec.SQL.Text := fGetSqlInsert ;
        end;
        FqryExec.ParamByName('CODREF').AsString := FarrPlanre[intCnt].strNRE_CODREF;
        FqryExec.ParamByName('DESCRI').AsString := FarrPlanre[intCnt].strNRE_DESCRI;
        FqryExec.ParamByName('DTAINI').AsDateTime := FarrPlanre[intCnt].dtaNRE_DTAINI;
        if FarrPlanre[intCnt].dtaNRE_DTAFIN > 0 then
          FqryExec.ParamByName('DTAFIN').AsDateTime := FarrPlanre[intCnt].dtaNRE_DTAFIN
        else
          FqryExec.ParamByName('DTAFIN').Clear;
        FqryExec.ParamByName('TIPCTA').AsString := FarrPlanre[intCnt].strNRE_TIPCTA;
        FqryExec.ParamByName('CTASUP').AsString := FarrPlanre[intCnt].strNRE_CTASUP;
        FqryExec.ParamByName('NIVEL_').AsInteger := FarrPlanre[intCnt].intNRE_NIVEL_;
        FqryExec.ParamByName('NATURE').AsInteger := FarrPlanre[intCnt].intNRE_NATURE;
        FqryExec.ParamByName('ORIENT').AsString := FarrPlanre[intCnt].strNRE_ORIENT;
        FqryExec.ParamByName('BLCECF').AsString := FstrBloco ;
        FqryExec.ParamByName('REGECF').AsString := FstrRegistro ;
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

procedure TImportacaoDadosContabeisPlanre.pCarregaDataSet;
var
  qryCarrega : TUniQuery ;
begin
  qryCarrega := fCriaQuery() ;
  try
    qryCarrega.Close ;
    qryCarrega.SQL.Clear ;
    qryCarrega.SQL.Add('SELECT NRE_CODREF, NRE_BLCECF, NRE_REGECF, NRE_DTAINI FROM PLANRE') ;
    qryCarrega.Open ;

    FCdsDataSet := fCriaClientDatset(qryCarrega) ;
    FCdsDataSet.IndexFieldNames := 'NRE_CODREF;NRE_BLCECF;NRE_REGECF;NRE_DTAINI' ;

  finally
    FreeAndNil(qryCarrega) ;
  end;
end;

procedure TImportacaoDadosContabeisPlanre.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_CODREF*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_DESCRI*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_DTAINI*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_DTAFIN', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_TIPCTA*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_CTASUP*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_NIVEL_*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_NATURE*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('NRE_ORIENT*', True));
end;

end.
