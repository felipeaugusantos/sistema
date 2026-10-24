unit Contabilidade.Classes.TImportacaoDadosContabeisEcfDem;


interface

uses Uni, cxProgressBar, Classes, Data.DB,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     Datasnap.DBClient, UniClientDataSet, Contabilidade.Interfaces, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisEcfDem = Class(TImportacaoDadosContabeisBase)
  private
    FCdsDataSet: TUniClientDataSet ;
    FarrGrupo01 : array of TEcfDemGrupo01 ;
    FarrGrupo02 : array of TEcfDemGrupo02 ;
    FarrGrupo03 : array of TEcfDemGrupo03 ;
    FarrGrupo04 : array of TEcfDemGrupo04 ;
    FarrGrupo05 : array of TEcfDemGrupo05 ;
    FstrRegistro: string ;
    FstrBloco: string ;
    function fGetSqlUpdate:string ;
    procedure pCarregaDataSet ;
    function fGetBloco:string ;
    procedure pInicializaArrPeloBloco ;
    procedure pCarregaArrPeloBloco(const intConLin: integer) ;
    function fPersisteDadosPeloBloco(var blnAbortado:boolean):boolean ;
    function fPersisteDadosGrupo01(var blnAbortado:boolean):boolean ;
    function fPersisteDadosGrupo02(var blnAbortado:boolean):boolean ;
    function fPersisteDadosGrupo03(var blnAbortado:boolean):boolean ;
    function fPersisteDadosGrupo04(var blnAbortado:boolean):boolean ;
    function fPersisteDadosGrupo05(var blnAbortado:boolean):boolean ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean ; override;
    function fPersisteDados:boolean ; override;
    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco: string; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;


implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls, StrUtils,
     Contabilidade.Funcoes, DateUtils;

{ TImportacaoDadosContabeisEcfDem }

function TImportacaoDadosContabeisEcfDem.fGetNomeTabela: string;
begin
  Result := 'ECFDEM';
end;

constructor TImportacaoDadosContabeisEcfDem.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco: string;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil) ;
  FstrRegistro := strRegistro ;
  FstrBloco := strBloco ;
  pCarregaDataSet ;
end;

destructor TImportacaoDadosContabeisEcfDem.Destroy;
begin
  FreeAndNil(FCdsDataSet) ;
  inherited;
end;

function TImportacaoDadosContabeisEcfDem.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  intConLin : integer ;
  intQtdLinhas : integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Demonstrativo ECF');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(intQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := intQtdLinhas-1;

  pInicializaArrPeloBloco;
  For intConLin := fIndicePrimeiroRegistro To intQtdLinhas-1 Do
  Begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    pCarregaArrPeloBloco(intConLin) ;
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

function TImportacaoDadosContabeisEcfDem.fGetBloco: string;
begin
  result := FstrBloco+FstrRegistro ;
end;

function TImportacaoDadosContabeisEcfDem.fGetSqlInsert: string;
var
  LBloco : string ;
begin
  LBloco := fGetBloco ;
  result := 'INSERT INTO ECFDEM ' ;
  result := result + '( ' ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_ORIENT,  ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':ORIENT,  ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_TIPLAN, ' ;
    result := result + 'DEM_ORIENT, ' ;
    result := result + 'DEM_RELACI, ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':TIPLAN, ' ;
    result := result + ':ORIENT, ' ;
    result := result + ':RELACI, ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_TIPLAN, ' ;
    result := result + 'DEM_RELACI, ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':TIPLAN, ' ;
    result := result + ':RELACI, ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_ORDEM_, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':ORDEM_, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end
  else ////se nenhum bloco for classificado usará os campos do grupo01
  begin
    result := result + 'DEM_CODDEM, ' ;
    result := result + 'DEM_DESCRI, ' ;
    result := result + 'DEM_DTAINI, ' ;
    result := result + 'DEM_DTAFIN, ' ;
    result := result + 'DEM_TIPDEM, ' ;
    result := result + 'DEM_FMTDEM, ' ;
    result := result + 'DEM_ORIENT,  ' ;
    result := result + 'DEM_BLCECF, ' ;
    result := result + 'DEM_REGECF ' ;
    result := result + ') ' ;
    result := result + 'VALUES ' ;
    result := result + '( ' ;
    result := result + ':CODDEM, ' ;
    result := result + ':DESCRI, ' ;
    result := result + ':DTAINI, ' ;
    result := result + ':DTAFIN, ' ;
    result := result + ':TIPDEM, ' ;
    result := result + ':FMTDEM, ' ;
    result := result + ':ORIENT, ' ;
    result := result + ':BLCECF, ' ;
    result := result + ':REGECF ' ;
  end;
  result := result + ') ; ' ;
end;

function TImportacaoDadosContabeisEcfDem.fGetSqlUpdate: string;
var
  LBloco : string ;
begin
  LBloco := fGetBloco ;
  result := 'UPDATE ECFDEM ' ;
  result := result + 'SET ' ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_ORIENT = :ORIENT, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  ' ;
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_TIPLAN = :TIPLAN, ' ;
    result := result + 'DEM_ORIENT = :ORIENT, ' ;
    result := result + 'DEM_RELACI = :RELACI, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  '  ;
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_TIPLAN = :TIPLAN, ' ;
    result := result + 'DEM_RELACI = :RELACI, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  ' ;
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  '  ;
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_ORDEM_ = :ORDEM_, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  ' ;
  end
  else ////se nenhum bloco for classificado usará os campos do grupo01
  begin
    result := result + 'DEM_CODDEM = :CODDEM, ' ;
    result := result + 'DEM_DESCRI = :DESCRI, ' ;
    result := result + 'DEM_DTAINI = :DTAINI, ' ;
    result := result + 'DEM_DTAFIN = :DTAFIN, ' ;
    result := result + 'DEM_TIPDEM = :TIPDEM, ' ;
    result := result + 'DEM_FMTDEM = :FMTDEM, ' ;
    result := result + 'DEM_ORIENT = :ORIENT, ' ;
    result := result + 'DEM_BLCECF = :BLCECF, ' ;
    result := result + 'DEM_REGECF = :REGECF  ' ;
  end;
  result := result + 'WHERE ' ;
  result := result + ' DEM_CODDEM = :CODDEM ' ;
  //result := result + ' AND COALESCE(DEM_RELPOS,"") = COALESCE(:RELPOS,"") ' ;
  result := result + ' AND DEM_BLCECF = :BLCECF ' ;
  result := result + ' AND DEM_REGECF = :REGECF ' ;
  result := result + ' AND DEM_DTAINI = :DTAINI ' ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDados: boolean;
var
  blnAbortado : boolean ;
begin
  result := false ;
  blnAbortado := False ;

  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Demonstrativo ECF ');

  pStartTransactionImportacao ;
  try
    result := fPersisteDadosPeloBloco(blnAbortado) ;
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

function TImportacaoDadosContabeisEcfDem.fPersisteDadosGrupo01(
  var blnAbortado: boolean): boolean;
var
  intCnt : integer ;
  strMensagemErro : string;
begin
  pgbProgresso.Properties.Max := Length(FarrGrupo01);
  for intCnt := Low(FarrGrupo01) to High(FarrGrupo01) do
  begin
    try
      pgbProgresso.Position := intCnt+1;
      Application.ProcessMessages;
      FqryExec.Close ;
      FqryExec.SQL.Clear ;
      if FCdsDataSet.FindKey([FarrGrupo01[intCnt].strDEM_CODDEM, FstrBloco, FstrRegistro, FarrGrupo01[intCnt].dtaDEM_DTAINI]) then
      begin
        FqryExec.SQL.Text := fGetSqlUpdate ;
      end
      else
      begin
        FqryExec.SQL.Text := fGetSqlInsert ;
      end;
      FqryExec.ParamByName('CODDEM').AsString := FarrGrupo01[intCnt].strDEM_CODDEM;
      FqryExec.ParamByName('DESCRI').AsString := FarrGrupo01[intCnt].strDEM_DESCRI;
      FqryExec.ParamByName('DTAINI').AsDateTime := FarrGrupo01[intCnt].dtaDEM_DTAINI;
      if FarrGrupo01[intCnt].dtaDEM_DTAFIN > 0 then
        FqryExec.ParamByName('DTAFIN').AsDateTime := FarrGrupo01[intCnt].dtaDEM_DTAFIN
      else
        FqryExec.ParamByName('DTAFIN').Clear;
      FqryExec.ParamByName('TIPDEM').AsString := FarrGrupo01[intCnt].strDEM_TIPDEM;
      FqryExec.ParamByName('FMTDEM').AsString := FarrGrupo01[intCnt].strDEM_FMTDEM;
      FqryExec.ParamByName('ORIENT').AsString := FarrGrupo01[intCnt].strDEM_ORIENT;
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
  result := true ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDadosGrupo02(
  var blnAbortado: boolean): boolean;
var
  intCnt : integer ;
  strMensagemErro : string;
begin
  pgbProgresso.Properties.Max := Length(FarrGrupo02);
  for intCnt := Low(FarrGrupo02) to High(FarrGrupo02) do
  begin
    try
      pgbProgresso.Position := intCnt+1;
      Application.ProcessMessages;
      FqryExec.Close ;
      FqryExec.SQL.Clear ;
      if FCdsDataSet.FindKey([FarrGrupo02[intCnt].strDEM_CODDEM, FstrBloco, FstrRegistro, FarrGrupo02[intCnt].dtaDEM_DTAINI]) then
      begin
        FqryExec.SQL.Text := fGetSqlUpdate ;
      end
      else
      begin
        FqryExec.SQL.Text := fGetSqlInsert ;
      end;
      FqryExec.ParamByName('CODDEM').AsString := FarrGrupo02[intCnt].strDEM_CODDEM;
      FqryExec.ParamByName('DESCRI').AsString := FarrGrupo02[intCnt].strDEM_DESCRI;
      FqryExec.ParamByName('DTAINI').AsDateTime := FarrGrupo02[intCnt].dtaDEM_DTAINI;
      if FarrGrupo02[intCnt].dtaDEM_DTAFIN > 0 then
        FqryExec.ParamByName('DTAFIN').AsDateTime := FarrGrupo02[intCnt].dtaDEM_DTAFIN
      else
        FqryExec.ParamByName('DTAFIN').Clear;
      FqryExec.ParamByName('TIPDEM').AsString := FarrGrupo02[intCnt].strDEM_TIPDEM;
      FqryExec.ParamByName('FMTDEM').AsString := FarrGrupo02[intCnt].strDEM_FMTDEM;
      FqryExec.ParamByName('TIPLAN').AsString := FarrGrupo02[intCnt].strDEM_TIPLAN;
      FqryExec.ParamByName('ORIENT').AsString := FarrGrupo02[intCnt].strDEM_ORIENT;
      FqryExec.ParamByName('RELACI').AsString := FarrGrupo02[intCnt].strDEM_RELACI;
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
  result := true ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDadosGrupo03(
  var blnAbortado: boolean): boolean;
var
  intCnt : integer ;
  strMensagemErro : string;
begin
  pgbProgresso.Properties.Max := Length(FarrGrupo03);
  for intCnt := Low(FarrGrupo03) to High(FarrGrupo03) do
  begin
    try
      pgbProgresso.Position := intCnt+1;
      Application.ProcessMessages;
      FqryExec.Close ;
      FqryExec.SQL.Clear ;
      if FCdsDataSet.FindKey([FarrGrupo03[intCnt].strDEM_CODDEM, FstrBloco, FstrRegistro, FarrGrupo03[intCnt].dtaDEM_DTAINI]) then
      begin
        FqryExec.SQL.Text := fGetSqlUpdate ;
      end
      else
      begin
        FqryExec.SQL.Text := fGetSqlInsert ;
      end;

      FqryExec.ParamByName('CODDEM').AsString := FarrGrupo03[intCnt].strDEM_CODDEM;
      FqryExec.ParamByName('DESCRI').AsString := FarrGrupo03[intCnt].strDEM_DESCRI;
      FqryExec.ParamByName('DTAINI').AsDateTime := FarrGrupo03[intCnt].dtaDEM_DTAINI;
      if FarrGrupo03[intCnt].dtaDEM_DTAFIN > 0 then
        FqryExec.ParamByName('DTAFIN').AsDateTime := FarrGrupo03[intCnt].dtaDEM_DTAFIN
      else
        FqryExec.ParamByName('DTAFIN').Clear;
      FqryExec.ParamByName('TIPDEM').AsString := FarrGrupo03[intCnt].strDEM_TIPDEM;
      FqryExec.ParamByName('FMTDEM').AsString := FarrGrupo03[intCnt].strDEM_FMTDEM;
      FqryExec.ParamByName('TIPLAN').AsString := FarrGrupo03[intCnt].strDEM_TIPLAN;
      FqryExec.ParamByName('RELACI').AsString := FarrGrupo03[intCnt].strDEM_RELACI;
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
  result := true ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDadosGrupo04(
  var blnAbortado: boolean): boolean;
var
  intCnt : integer ;
  strMensagemErro : string;
begin
  pgbProgresso.Properties.Max := Length(FarrGrupo04);
  for intCnt := Low(FarrGrupo04) to High(FarrGrupo04) do
  begin
    try
      pgbProgresso.Position := intCnt+1;
      Application.ProcessMessages;
      FqryExec.Close ;
      FqryExec.SQL.Clear ;
      if FCdsDataSet.FindKey([FarrGrupo04[intCnt].strDEM_CODDEM, FstrBloco, FstrRegistro, FarrGrupo04[intCnt].dtaDEM_DTAINI]) then
      begin
        FqryExec.SQL.Text := fGetSqlUpdate ;
      end
      else
      begin
        FqryExec.SQL.Text := fGetSqlInsert ;
      end;
      FqryExec.ParamByName('CODDEM').AsString := FarrGrupo04[intCnt].strDEM_CODDEM;
      FqryExec.ParamByName('DESCRI').AsString := FarrGrupo04[intCnt].strDEM_DESCRI;
      FqryExec.ParamByName('DTAINI').AsDateTime := FarrGrupo04[intCnt].dtaDEM_DTAINI;
      if FarrGrupo04[intCnt].dtaDEM_DTAFIN > 0 then
        FqryExec.ParamByName('DTAFIN').AsDateTime := FarrGrupo04[intCnt].dtaDEM_DTAFIN
      else
        FqryExec.ParamByName('DTAFIN').Clear;
      FqryExec.ParamByName('TIPDEM').AsString := FarrGrupo04[intCnt].strDEM_TIPDEM;
      FqryExec.ParamByName('FMTDEM').AsString := FarrGrupo04[intCnt].strDEM_FMTDEM;
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
  result := true ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDadosGrupo05(
  var blnAbortado: boolean): boolean;
var
  intCnt : integer ;
  strMensagemErro : string;
begin
  pgbProgresso.Properties.Max := Length(FarrGrupo05);
  for intCnt := Low(FarrGrupo05) to High(FarrGrupo05) do
  begin
    try
      pgbProgresso.Position := intCnt+1;
      Application.ProcessMessages;
      FqryExec.Close ;
      FqryExec.SQL.Clear ;
      if FCdsDataSet.FindKey([FarrGrupo05[intCnt].strDEM_CODDEM, FstrBloco, FstrRegistro, FarrGrupo05[intCnt].dtaDEM_DTAINI]) then
      begin
        FqryExec.SQL.Text := fGetSqlUpdate ;
      end
      else
      begin
        FqryExec.SQL.Text := fGetSqlInsert ;
      end;
      FqryExec.ParamByName('CODDEM').AsString := FarrGrupo05[intCnt].strDEM_CODDEM;
      FqryExec.ParamByName('DESCRI').AsString := FarrGrupo05[intCnt].strDEM_DESCRI;
      FqryExec.ParamByName('DTAINI').AsDateTime := FarrGrupo05[intCnt].dtaDEM_DTAINI;
      if FarrGrupo05[intCnt].dtaDEM_DTAFIN > 0 then
        FqryExec.ParamByName('DTAFIN').AsDateTime := FarrGrupo05[intCnt].dtaDEM_DTAFIN
      else
        FqryExec.ParamByName('DTAFIN').Clear;
      FqryExec.ParamByName('ORDEM_').AsString := FarrGrupo05[intCnt].strDEM_ORDEM_;
      FqryExec.ParamByName('TIPDEM').AsString := FarrGrupo05[intCnt].strDEM_TIPDEM;
      FqryExec.ParamByName('FMTDEM').AsString := FarrGrupo05[intCnt].strDEM_FMTDEM;
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
  result := true ;
end;

function TImportacaoDadosContabeisEcfDem.fPersisteDadosPeloBloco(var blnAbortado:boolean): boolean;
var
  LBloco : string ;
begin
  LBloco := fGetBloco ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    result := fPersisteDadosGrupo01(blnAbortado) ;
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    result := fPersisteDadosGrupo02(blnAbortado) ;
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    result := fPersisteDadosGrupo03(blnAbortado) ;
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    result := fPersisteDadosGrupo04(blnAbortado) ;
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    result := fPersisteDadosGrupo05(blnAbortado) ;
  end
  else
  begin
    result := fPersisteDadosGrupo01(blnAbortado) ;
  end;
end;

procedure TImportacaoDadosContabeisEcfDem.pCarregaArrPeloBloco(const intConLin: integer);
var
  LBloco : string ;
  intUltimo : integer ;
begin
  LBloco := fGetBloco ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    SetLength(FarrGrupo01,Length(FarrGrupo01)+1);
    intUltimo := High(FarrGrupo01) ;
    FarrGrupo01[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo01[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo01[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo01[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo01[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrGrupo01[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
    FarrGrupo01[intUltimo].strDEM_ORIENT := fGetDadosCelula(6, intConLin, tdcStr);
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    SetLength(FarrGrupo02,Length(FarrGrupo02)+1);
    intUltimo := High(FarrGrupo02) ;
    FarrGrupo02[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo02[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo02[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo02[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo02[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrGrupo02[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
    FarrGrupo02[intUltimo].strDEM_TIPLAN := copy(fGetDadosCelula(6, intConLin, tdcStr), 1, 5) ;
    FarrGrupo02[intUltimo].strDEM_ORIENT := fGetDadosCelula(7, intConLin, tdcStr);
    FarrGrupo02[intUltimo].strDEM_RELACI := copy(fGetDadosCelula(8, intConLin, tdcStr),1, 10) ;
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    SetLength(FarrGrupo03,Length(FarrGrupo03)+1);
    intUltimo := High(FarrGrupo03) ;
    FarrGrupo03[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo03[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo03[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo03[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo03[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrGrupo03[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
    FarrGrupo03[intUltimo].strDEM_TIPLAN := copy(fGetDadosCelula(6, intConLin, tdcStr), 1, 5) ;
    FarrGrupo03[intUltimo].strDEM_RELACI := copy(fGetDadosCelula(7, intConLin, tdcStr),1, 10) ;
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    SetLength(FarrGrupo04,Length(FarrGrupo04)+1);
    intUltimo := High(FarrGrupo04) ;
    FarrGrupo04[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo04[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo04[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo04[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo04[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrGrupo04[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    SetLength(FarrGrupo05,Length(FarrGrupo05)+1);
    intUltimo := High(FarrGrupo05) ;
    FarrGrupo05[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo05[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo05[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo05[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo05[intUltimo].strDEM_ORDEM_ := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 2) ;
    FarrGrupo05[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
    FarrGrupo05[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(6, intConLin, tdcStr), 1, 5) ;
  end
  else
  begin
    SetLength(FarrGrupo01,Length(FarrGrupo01)+1);
    intUltimo := High(FarrGrupo01) ;
    FarrGrupo01[intUltimo].strDEM_CODDEM := copy(fGetDadosCelula(0, intConLin, tdcStr), 1, 20) ;
    FarrGrupo01[intUltimo].strDEM_DESCRI := fGetDadosCelula(1, intConLin, tdcStr) ;
    FarrGrupo01[intUltimo].dtaDEM_DTAINI := fGetDadosCelula(2, intConLin, tdcDate);
    FarrGrupo01[intUltimo].dtaDEM_DTAFIN := fGetDadosCelula(3, intConLin, tdcDate);
    FarrGrupo01[intUltimo].strDEM_TIPDEM := copy(fGetDadosCelula(4, intConLin, tdcStr), 1, 5) ;
    FarrGrupo01[intUltimo].strDEM_FMTDEM := copy(fGetDadosCelula(5, intConLin, tdcStr), 1, 5) ;
    FarrGrupo01[intUltimo].strDEM_ORIENT := fGetDadosCelula(6, intConLin, tdcStr);
  end;
end;

procedure TImportacaoDadosContabeisEcfDem.pCarregaDataSet;
var
  qryCarrega : TUniQuery ;
begin
  qryCarrega := fCriaQuery() ;
  try
    qryCarrega.Close ;
    qryCarrega.SQL.Clear ;
    qryCarrega.SQL.Add('SELECT DEM_CODDEM, DEM_RELPOS, DEM_BLCECF, DEM_REGECF, DEM_DTAINI FROM ECFDEM') ;
    qryCarrega.Open ;

    FCdsDataSet := fCriaClientDatset(qryCarrega) ;
    ////se vier importação LACs configure a seguinte chave primaria ///DEM_CODDEM;DEM_RELPOS;DEM_BLCECF;DEM_REGECF;DEM_DTAINI
    FCdsDataSet.IndexFieldNames := 'DEM_CODDEM;DEM_BLCECF;DEM_REGECF;DEM_DTAINI' ;

  finally
    FreeAndNil(qryCarrega) ;
  end;
end;

procedure TImportacaoDadosContabeisEcfDem.pCarregaInfoColunas;
var
  LBloco : string ;
begin
  LBloco := fGetBloco ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('ORIENTAÇÕES', False));
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO LANÇ', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('ORIENTAÇÕES', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('RELAC', False));
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO LANC', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('RELAC', False));
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('ORDEM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
  end
  else
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DESCRIÇÃO*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_INI*', True));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DT_FIM', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('TIPO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('FORMATO', False));
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('ORIENTAÇÕES', False));
  end;
end;

procedure TImportacaoDadosContabeisEcfDem.pInicializaArrPeloBloco;
var
  LBloco : string ;
begin
  LBloco := fGetBloco ;
  if fDemonstrativoEcfGrupo01(LBloco) then
  begin
    SetLength(FarrGrupo01, 0);
  end
  else if fDemonstrativoEcfGrupo02(LBloco) then
  begin
    SetLength(FarrGrupo02, 0);
  end
  else if fDemonstrativoEcfGrupo03(LBloco) then
  begin
    SetLength(FarrGrupo03, 0);
  end
  else if fDemonstrativoEcfGrupo04(LBloco) then
  begin
    SetLength(FarrGrupo04, 0);
  end
  else if fDemonstrativoEcfGrupo05(LBloco) then
  begin
    SetLength(FarrGrupo05, 0);
  end
  else
  begin
    SetLength(FarrGrupo01, 0);
  end;
end;

end.
