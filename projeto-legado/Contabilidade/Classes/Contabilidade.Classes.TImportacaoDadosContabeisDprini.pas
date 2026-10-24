unit Contabilidade.Classes.TImportacaoDadosContabeisDprini;

interface

uses Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet, System.Generics.Collections,
     Contabilidade.Classes.TImportacaoDadosContabeis, Contabilidade.Interfaces,
     Contabilidade.Classes.TValidaProcessoSaldoInicialSubconta, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisDprIni = Class(TImportacaoDadosContabeisBase)
  private
    FarrDprIni : array of TDprIniInfo ;
    FCdsDprIni: TUniClientDataSet;
    [weak] FCdsPlanco: TUniClientDataset;
    FblnDPRDET: boolean;
    function fGetSeqDelDet: string;
    function fGetSqlUpdate:string ;
    procedure pCarregaDataSetDprIni ;
    function fConverteEstruturaParaValidacao(const AArr: array of TDprIniInfo):TList<TDadosValidacaoSaldoInicialSub> ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados:boolean; override;
    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; cdsPlanco: TUniClientDataset; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;

implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, strUtils, Contabilidade.Funcoes;

{ TImportacaoDadosContabeisDprIni }

function TImportacaoDadosContabeisDprIni.fGetNomeTabela: string;
begin
  Result := 'DPRINI';
end;

constructor TImportacaoDadosContabeisDprIni.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean; cdsPlanco: TUniClientDataset;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil) ;
  pCarregaDataSetDprIni ;
  FCdsPlanco := cdsPlanco;
  FblnDPRDET := fTabelaExiste('DPRDET');
end;

destructor TImportacaoDadosContabeisDprIni.Destroy;
begin
  FreeAndNil(FCdsDprIni) ;
  inherited;
end;

function TImportacaoDadosContabeisDprIni.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intUltimo : integer ;
  intQtdLinhas : integer ;
  LDadosValidacao: TList<TDadosValidacaoSaldoInicialSub>;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Saldos Iniciais - Subconta');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  SetLength(FarrDprIni,0);
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrDprIni,Length(FarrDprIni)+1);
    intUltimo := High(FarrDprIni) ;

    FarrDprIni[intUltimo].strINI_CODEMP := fStrZero(copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 3), 3) ;
    FarrDprIni[intUltimo].strINI_EXERCI := copy(fGetDadosCelula(1, intConLin, tdcStr), 1, 4) ;
    FarrDprIni[intUltimo].strINI_CODCON := copy(fSemMascaraPlaNco(fGetDadosCelula(2, intConLin, tdcStr)), 1, 20) ;
    FarrDprIni[intUltimo].strINI_CLIFOR := fStrZero(copy(fGetDadosCelula(3, intConLin, tdcStr), 1, 8) , 8);
    FarrDprIni[intUltimo].strINI_TIP_FC := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 1) ;
    FarrDprIni[intUltimo].fltINI_SALINI := fGetDadosCelula(5, intConLin, tdcFloat) ;
    FarrDprIni[intUltimo].strINI_CREDEB := copy(fGetDadosCelula(6, intConLin, tdcStr), 1, 1) ;
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
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrDprIni) ;
  try
    if not TValidaProcessoSaldoInicialSubconta.fValidaSaldoInicialSubcontasBloco(LDadosValidacao, AprocErros, FCdsPlanco) then
    begin
      exit ;
    end;
  finally
    FreeAndNil(LDadosValidacao) ;
  end;

  result := True ;
end;

function TImportacaoDadosContabeisDprIni.fConverteEstruturaParaValidacao(
  const AArr: array of TDprIniInfo): TList<TDadosValidacaoSaldoInicialSub>;
var
  intCnt: Integer ;
  regItem: TDadosValidacaoSaldoInicialSub;
begin
  Result := TList<TDadosValidacaoSaldoInicialSub>.Create;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.AConta := AArr[intCnt].strINI_CODCON;
    regItem.AEmpresa := AArr[intCnt].strINI_CODEMP;
    regItem.AExercicio := AArr[intCnt].strINI_EXERCI;
    regItem.AValor := AArr[intCnt].fltINI_SALINI;
    regItem.ACreDeb := AArr[intCnt].strINI_CREDEB[1];
    regItem.ATipFC := AArr[intCnt].strINI_TIP_FC[1];
    regItem.ACliFor := AArr[intCnt].strINI_CLIFOR;

    Result.Add(regItem);
  end;
end;

function TImportacaoDadosContabeisDprIni.fGetSeqDelDet: string;
begin
  result := 'DELETE FROM DPRDET ';
  result := result + 'WHERE TRUE ';
  result := result + ' AND DET_CODCON = :CODCON';
  result := result + ' AND DET_EXERCI = :EXERCI';
  result := result + ' AND DET_CODEMP = :CODEMP';
  result := result + ' AND DET_CLIFOR = :CLIFOR';
  result := result + ' AND DET_TIP_FC = :TIP_FC';
end;

function TImportacaoDadosContabeisDprIni.fGetSqlInsert: string;
begin
  result := 'INSERT INTO DPRINI ' ;
  result := result + '( ' ;
  result := result + 'INI_CODCON, ' ;
  result := result + 'INI_EXERCI, ' ;
  result := result + 'INI_CODEMP, ' ;
  result := result + 'INI_SALINI, ' ;
  result := result + 'INI_CREDEB, ' ;
  result := result + 'INI_CLIFOR, ' ;
  result := result + 'INI_TIP_FC, ' ;
  result := result + 'INI_DTAALT, ' ;
  result := result + 'INI_OPEALT  ' ;
  result := result + ') ' ;
  result := result + 'VALUES ' ;
  result := result + '( ' ;
  result := result + ':CODCON, ' ;
  result := result + ':EXERCI, ' ;
  result := result + ':CODEMP, ' ;
  result := result + ':SALINI, ' ;
  result := result + ':CREDEB, ' ;
  result := result + ':CLIFOR, ' ;
  result := result + ':TIP_FC, ' ;
  result := result + ':DTAALT, ' ;
  result := result + ':OPEALT  ' ;
  result := result + ') ;' ;
end;

function TImportacaoDadosContabeisDprIni.fGetSqlUpdate: string;
begin
  result := 'UPDATE DPRINI SET ' ;
  result := result + ' INI_SALINI = :SALINI, ' ;
  result := result + ' INI_CREDEB = :CREDEB, ' ;
  result := result + ' INI_DTAALT = :DTAALT, ' ;
  result := result + ' INI_OPEALT = :OPEALT  ' ;
  result := result + 'WHERE TRUE ';
  result := result + ' AND INI_CODCON = :CODCON';
  result := result + ' AND INI_EXERCI = :EXERCI';
  result := result + ' AND INI_CODEMP = :CODEMP';
  result := result + ' AND INI_CLIFOR = :CLIFOR';
  result := result + ' AND INI_TIP_FC = :TIP_FC';
end;

function TImportacaoDadosContabeisDprIni.fPersisteDados: boolean;
var
  intCnt : integer ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
  LqryDelDet: TUniQuery;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Saldos Iniciais - Subconta');
  pgbProgresso.Properties.Max := Length(FarrDprIni);

  pStartTransactionImportacao ;

  LqryDelDet := fCriaQuery();
  try
    try
      LqryDelDet.SQL.Text := fGetSeqDelDet;
      FqryExec.Close ;

      for intCnt := Low(FarrDprIni) to High(FarrDprIni) do
      begin
        try
          pgbProgresso.Position := intCnt+1;
          Application.ProcessMessages;

          //ignora a linha caso tenha dado problema na validação da planilha
          if not FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
          begin
            if FCdsDprIni.FindKey([FarrDprIni[intCnt].strINI_CODCON, FarrDprIni[intCnt].strINI_EXERCI, FarrDprIni[intCnt].strINI_CLIFOR, FarrDprIni[intCnt].strINI_TIP_FC, FarrDprIni[intCnt].strINI_CODEMP]) then
            begin
              if FblnDPRDET then
              begin
                LqryDelDet.ParamByName('CODEMP').AsString := FarrDprIni[intCnt].strINI_CODEMP ;
                LqryDelDet.ParamByName('EXERCI').AsString := FarrDprIni[intCnt].strINI_EXERCI ;
                LqryDelDet.ParamByName('CODCON').AsString := FarrDprIni[intCnt].strINI_CODCON ;
                LqryDelDet.ParamByName('CLIFOR').AsString := FarrDprIni[intCnt].strINI_CLIFOR ;
                LqryDelDet.ParamByName('TIP_FC').AsString := FarrDprIni[intCnt].strINI_TIP_FC ;
                LqryDelDet.ExecSQL ;
              end;

              FqryExec.SQL.Text := fGetSqlUpdate
            end
            else
              FqryExec.SQL.Text := fGetSqlInsert ;

            FqryExec.ParamByName('CODEMP').AsString := FarrDprIni[intCnt].strINI_CODEMP ;
            FqryExec.ParamByName('EXERCI').AsString := FarrDprIni[intCnt].strINI_EXERCI ;
            FqryExec.ParamByName('CODCON').AsString := FarrDprIni[intCnt].strINI_CODCON ;
            FqryExec.ParamByName('SALINI').AsFloat  := FarrDprIni[intCnt].fltINI_SALINI ;
            FqryExec.ParamByName('CREDEB').AsString := FarrDprIni[intCnt].strINI_CREDEB ;
            FqryExec.ParamByName('CLIFOR').AsString := FarrDprIni[intCnt].strINI_CLIFOR ;
            FqryExec.ParamByName('TIP_FC').AsString := FarrDprIni[intCnt].strINI_TIP_FC ;
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
  finally
    FreeAndNil(LqryDelDet);
  end;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada) ;
    exit ;
  end;

  pMensagemSucesso ;

  result := true ;
end;

procedure TImportacaoDadosContabeisDprIni.pCarregaDataSetDprIni;
var
  qryAux: TUniQuery;
begin
  if Assigned(FCdsDprIni) then
    FreeAndNil(FCdsDprIni);

  qryAux := fCriaQuery();
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('INI_CODCON, INI_EXERCI, INI_CLIFOR, INI_TIP_FC, INI_CODEMP ');
    qryAux.SQL.Add('FROM DPRINI ');
    qryAux.Open;

    FCdsDprIni := fCriaClientDatset(qryAux);
    FCdsDprIni.IndexFieldNames := 'INI_CODCON;INI_EXERCI;INI_CLIFOR;INI_TIP_FC;INI_CODEMP';
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TImportacaoDadosContabeisDprIni.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('EMPRESA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('EXERCICIO*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA CONTABIL*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CLIENTE/FORNECEDOR*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO(C)/(F)*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('SALDO INICIAL*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DÉBITO(D)/CRÉDITO(C)*', True)) ;
end;

end.
