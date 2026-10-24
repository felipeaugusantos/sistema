unit GatilhosImediatos.Classes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  dxCore,
  untUtilMonitor,
  untModulo,
  untModuloSPR,
  untModuloReplicacao,
  untFuncoesSimples,
  untLogForm,
{$ENDIF LINUX}
  System.Classes,
  System.SysUtils,
  Uni,
  untDllGatImeParametros,
  GatilhosImediatos.Interfaces,
  untProcessaGatilhosImediatos,
  untTypesSistema,
  untBucketCitel,
  untDadosEnviaWhatsapp,
  untFuncoesGenerica;

{$REGION 'Funcoes de Inicialização da DLL/SO'}
function fCarregarDll(prmDll: Pointer): IGatIme; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF LINUX};

{$IFNDEF LINUX}
  function fSVN_RevisionGatIme: PAnsiChar; stdcall;
  Procedure pLiberaModulos;
{$ENDIF LINUX}
{$ENDREGION}

type
  TGatIme = class(TInterfacedObject, IGatIme)
  private
    function fEhArquivoBase64(const AstrArquivo: String): Boolean;
    procedure pRevisarExtensaoArquivos(var AArquivos: TArray<TRecArquivosGatilhos>);
  public
    function fMonitorar(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX};
    function fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;
  end;

implementation

uses
  untDadosEnviaGatilhoEmail;

{ TGatIme }

function TGatIme.fMonitorar(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX};
begin
  {$IFNDEF LINUX}
  VS_AutcomIniciadoModoRobo := True;
  {$ENDIF LINUX}
  Result := TGatilhosImediatosMonitor.Create(AstrFluxo);
end;

function TGatIme.fEhArquivoBase64(const AstrArquivo: String): Boolean;
begin
  Result := fEmptyStr(ExtractFileExt(AstrArquivo));
end;

{$IFNDEF LINUX}
procedure pValidaProCodDasTabelasEnvolvidas;
begin
  pValidaProCod('GATIME_WPPEMA');
  pValidaProCod('GATIME_WPPEMA_ARQUIVO');
  pValidaProCod('GATIME_WPPEMA_MIMETYPE');
end;
{$ENDIF LINUX}

procedure TGatIme.pRevisarExtensaoArquivos(var AArquivos: TArray<TRecArquivosGatilhos>);
var
  intCount: Integer;
  TipoArquivo:  TTipoArquivo;
begin
  for intCount := 0 to High(AArquivos) do
  begin
    if fEhArquivoBase64(AArquivos[intCount].Arquivo) then
      Continue;

    TipoArquivo := fGetTipoArquivo(AArquivos[intCount].Arquivo);
    if TipoArquivo <> AArquivos[intCount].TipoArquivo then
      AArquivos[intCount].TipoArquivo := TipoArquivo;
  end;
end;

function TGatIme.fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;
var
  qryGat: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  qryArq: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  strSQL: String;
  strAutIncWppEma: String;
  strArquivoBucket: String;
  strArquivoBase64: String;
  intCount: Integer;
Begin
  Result := False;
  strArquivoBucket := EmptyStr;
  strArquivoBase64 := EmptyStr;

  {$IFNDEF LINUX}
  pValidaProCodDasTabelasEnvolvidas;
  {$ENDIF LINUX}

  if (fEmptyStr(RecGatilhoImediato.NumeroWhatsapp)) And (fEmptyStr(RecGatilhoImediato.Email)) then
    Exit;

  if fEmptyStr(RecGatilhoImediato.OperadorEnvio) then
    RecGatilhoImediato.OperadorEnvio := fCfgSis('GATOPE');

  if (fCfgSis('GATEDT', varBoolean)) or (fEmptyStr(RecGatilhoImediato.OperadorEnvio)) then
    RecGatilhoImediato.OperadorEnvio := strLoginUsuarioLogado;

  qryGat := fCriaQuery;
  qryArq := fCriaQuery;
  try
    try
      if Length(RecGatilhoImediato.Arquivos) > 0 then
      begin
        pRevisarExtensaoArquivos(RecGatilhoImediato.Arquivos);

        if RecGatilhoImediato.Arquivos[0].ArmazenadoNoBucket then
          strArquivoBucket := RecGatilhoImediato.Arquivos[0].Arquivo
        else
          strArquivoBucket := TBucketCitel
                                .Instance
                                .fUploadFile(RecGatilhoImediato.Arquivos[0],
                                             'WHATSAPP',
                                             'GATIME_' + FormatDateTime('yyyyMMddhhmmsszzz', fNow));
      end;

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO GATIME_WPPEMA (';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  GAT_OPEENV, ';
      strSQL := strSQL + '  GAT_DTAOCO, ';
      strSQL := strSQL + '  GAT_HOROCO, ';

      if not fEmptyStr(RecGatilhoImediato.NumeroWhatsapp) then
        strSQL := strSQL + '  GAT_NUMWPP, ';

      if not fEmptyStr(RecGatilhoImediato.Email) then
        strSQL := strSQL + '  GAT_EMAIL_, ';

      strSQL := strSQL + '  GAT_ASSUNT, ';
      strSQL := strSQL + '  GAT_TEXINI, ';
      strSQL := strSQL + '  GAT_LIBENV, ';
      strSQL := strSQL +  ' GAT_ARQBCK, ';
      strSQL := strSQL + '  GAT_INFJSN, ';
      strSQL := strSQL + '  GAT_NOMARQ, ';
      strSQL := strSQL + '  GAT_CODEMP ';

      strSQL := strSQL + ') VALUES (';
      strSQL := strSQL + '  :AUTOINC, ';
      strSQL := strSQL + '  :OPEENV, ';
      strSQL := strSQL + '  CURRENT_DATE, ';
      strSQL := strSQL + '  CURRENT_TIME, ';

      if not fEmptyStr(RecGatilhoImediato.NumeroWhatsapp) then
        strSQL := strSQL + '  :NUMWPP, ';

      if not fEmptyStr(RecGatilhoImediato.Email) then
       strSQL := strSQL + '  :EMAIL_, ';

      strSQL := strSQL + '  :ASSUNT, ';
      strSQL := strSQL + '  :TEXINI, ';
      strSQL := strSQL + '  :LIBENV, ';
      strSQL := strSQL + '  :ARQBCK, ';
      strSQL := strSQL + '  :INFJSN, ';
      strSQL := strSQL + '  :NOMARQ, ';
      strSQL := strSQL + '  :CODEMP ';
      strSQL := strSQL + ')';

      qryGat.SQL.Text := strSQL;

      strAutIncWppEma := fRetAutoIncrem('GATIME_WPPEMA', VS_strCodEmp);

      qryGat.ParamByName('AUTOINC').AsString := strAutIncWppEma;
      qryGat.ParamByName('OPEENV').AsString := RecGatilhoImediato.OperadorEnvio;

      if not fEmptyStr(RecGatilhoImediato.NumeroWhatsapp) then
        qryGat.ParamByName('NUMWPP').AsString := fTiraCaracEspeciais(RecGatilhoImediato.NumeroWhatsapp,
                                                                     True,
                                                                     True,
                                                                     True,
                                                                     True,
                                                                     True,
                                                                     True,
                                                                     True);

      if not fEmptyStr(RecGatilhoImediato.Email) then
        qryGat.ParamByName('EMAIL_').AsString := RecGatilhoImediato.Email;

      qryGat.ParamByName('ASSUNT').AsString := RecGatilhoImediato.Assunto;
      qryGat.ParamByName('TEXINI').AsString := RecGatilhoImediato.Mensagem;
      qryGat.ParamByName('LIBENV').AsString := 'P';

      qryGat.ParamByName('ARQBCK').AsString := EmptyStr;
      if not fEmptyStr(strArquivoBucket) then
        qryGat.ParamByName('ARQBCK').AsString := strArquivoBucket;

      qryGat.ParamByName('INFJSN').AsString := RecGatilhoImediato.Json;

      qryGat.ParamByName('NOMARQ').AsString := EmptyStr;
      if (not fEmptyStr(strArquivoBucket)) and (Length(RecGatilhoImediato.Arquivos) > 0) then
        qryGat.ParamByName('NOMARQ').AsString := RecGatilhoImediato.Arquivos[0].Titulo + fGetExtensaoArquivo(RecGatilhoImediato.Arquivos[0].TipoArquivo);

      qryGat.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGat.ExecSQL;

      for intCount := 0 to High(RecGatilhoImediato.Arquivos) do
      begin
        if intCount = 0 then
        begin
          if not fEmptyStr(strArquivoBucket) then
          begin
            strArquivoBucket := EmptyStr;
            Continue;
          end;

        end;

        if intCount > 0 then
        begin
          if RecGatilhoImediato.Arquivos[intCount].ArmazenadoNoBucket then
            strArquivoBucket := RecGatilhoImediato.Arquivos[intCount].Arquivo
          else
            strArquivoBucket := TBucketCitel
                                  .Instance
                                  .fUploadFile(RecGatilhoImediato.Arquivos[intCount],
                                               'WHATSAPP',
                                               'GATIME_' + FormatDateTime('yyyyMMddhhmmsszzz', fNow));
        end;

        qryArq.Close;
        qryArq.SQL.Text :=
        ' INSERT INTO GATIME_WPPEMA_ARQUIVO ('+
        '   AUTOINCREM, '+
        '   GAT_SEQGER, '+
        IIF(not fEmptyStr(strArquivoBucket), ' GAT_ARQBCK, ', ' GAT_ARQB64, ')+
        '   GAT_NOMARQ '+

        ' ) VALUES ( '+

        '   :AUTINC, '+
        '   :SEQGER, '+
        '   :ARQUIV, '+
        '   :NOMARQ  '+
        ' ) ';

        qryArq.ParamByName('AUTINC').AsString := fRetAutoIncrem('GATIME_WPPEMA_ARQUIVO', VS_strCodEmp);
        qryArq.ParamByName('SEQGER').AsString := strAutIncWppEma;

        if fEmptyStr(strArquivoBucket) then
        begin
          strArquivoBase64 := RecGatilhoImediato.Arquivos[intCount].Arquivo;
          if not fEhArquivoBase64(strArquivoBase64) then
            strArquivoBase64 := fRetornarArquivoBase64(RecGatilhoImediato.Arquivos[intCount].Arquivo);

          qryArq.ParamByName('ARQUIV').AsString := strArquivoBase64;
        end
        else
          qryArq.ParamByName('ARQUIV').AsString := strArquivoBucket;

        qryArq.ParamByName('NOMARQ').AsString := RecGatilhoImediato.Arquivos[intCount].Titulo + fGetExtensaoArquivo(RecGatilhoImediato.Arquivos[intCount].TipoArquivo);

        strArquivoBase64 := EmptyStr;
        strArquivoBucket := EmptyStr;

        qryArq.ExecSQL;
      end;

      qryGat.Close;
      qryGat.SQL.Text :=
      ' UPDATE '+
      '   GATIME_WPPEMA '+
      ' SET '+
      '   GAT_LIBENV = "S" '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC ';

      qryGat.ParamByName('AUTINC').AsString := strAutIncWppEma;
      qryGat.ExecSQL;

      Result := True;
    except
      on E: Exception do
      begin
        pGravarErro(True, 'fGravarGatilhoImediato', E.message);
      end;
    end;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryGat);
    FreeAndNil(qryArq);
    {$ENDIF LINUX}
  end;
end;

{$REGION 'Inicialização da DLL/SO'}

{$REGION 'Seta Parâmetros - WINDOWS'}
{$IFNDEF LINUX}
procedure pSetaPrametrosWindows(objDllGatIme: TparamGatIme);
var
  intIndex: Integer;
begin
  frmModulo := TfrmModulo.CreateInstance(Nil, False);
  frmModulo.Database.AssignConnect(objDllGatIme.modRecMod.Banco);

  VS_Date                   := objDllGatIme.varRecVar.dtaVSDate;
  strLoginUsuarioLogado     := String(objDllGatIme.varRecVar.strLogUsu);
  strDescriUsuarioLogado    := String(objDllGatIme.varRecVar.strDesUsu);
  strEmpAcessoUsuarioLogado := String(objDllGatIme.varRecVar.strEmpUsu);
  strEmpEstUsuarioLogado    := String(objDllGatIme.varRecVar.strEmpEst);

  pSetaEmpresaLogada(String(objDllGatIme.varRecVar.strEmpCod));

  pCriarModulo(TfrmModuloSPR,        TDataModule(frmModuloSPR));
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

  For intIndex := 0 To frmModuloSPR.ComponentCount - 1 Do
    If frmModuloSPR.Components[intIndex] Is TUniQuery Then
      (frmModuloSPR.Components[intIndex] As TUniQuery).Connection := frmModulo.GetCurrentConnection;

  pVerificaProCod;

  pAtuVarGlobaisSimples;

  pIniciaLogLeak(objDllGatIme.intDebugH, 'libGatIme');

  TLogForm.strCodEmp := VS_strCodEmp;
  TLogForm.strCodOpe := strLoginUsuarioLogado;
  TLogForm.dtaDtaLog := VS_Date;
  TLogForm.fncCriaQuery := fCriaQuery;
  TLogForm.fncTime := fTime;
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM');
end;
{$ENDIF LINUX}
{$ENDREGION}

{$REGION 'Seta Parâmetros - LINUX'}
{$IFDEF LINUX}
procedure pSetaPrametrosLinux(objDllGatIme: TparamGatIme);
begin
  objConnectionsManager := objDllGatIme.modRecMod.ConnectionManager;
  Application := objDllGatIme.Application;

  pSetaEmpresaLogada(String(objDllGatIme.varRecVar.strEmpCod));
  pDefinirUsuario(String(objDllGatIme.varRecVar.strLogUsu));

  pIniciarVariaveis;
end;
{$ENDIF LINUX}
{$ENDREGION}

function fCarregarDll(prmDll: Pointer): IGatIme; {$IFNDEF LINUX} stdcall {$ELSE} cdecl {$ENDIF LINUX};
var
  objDllGatIme : TparamGatIme;
begin
  Try
    objDllGatIme := prmDll;
    {$IFNDEF LINUX}
    pSetaPrametrosWindows(objDllGatIme);
    {$ELSE }
    pSetaPrametrosLinux(objDllGatIme);
    {$ENDIF LINUX}
    Result := TGatIme.Create;
  Except
    On E: Exception Do
    Begin
    {$IFNDEF LINUX}
      pMensagensErro(E.Message, '[fCarregarDll]');
    {$ENDIF LINUX}
    End;
  End;
end;

{$IFNDEF LINUX}
function fSVN_RevisionGatIme: PAnsiChar; stdcall;
{$I rev.inc}
begin
  Result := SVN_REVISION;
end;
{$ENDIF LINUX}

{$IFNDEF LINUX}
Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

procedure dxFinalizeOrp;
Begin
  pLiberaModulos;
  dxFinalize;
End;

Initialization

  dxInitialize;

Finalization

  dxFinalizeOrp;

{$ENDIF LINUX}

{$ENDREGION}

end.
