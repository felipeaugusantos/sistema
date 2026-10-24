unit untThreadEnviaEmail;

interface

uses
  Classes, Uni, SysUtils, Dialogs, untTEnvioEmail, Winapi.Windows,
  untTypesSistema, untDisparaEmailAut, untThreadUtils, MemData;

type
  TThreadEnviaEmail = class(TSafeThread)
  private
    strOperad: String;
    strNomOpe: String;
    strAssunt: String;
    strCodCli: String;
    strAutInc: String;
    strIncCon: String;
    intCodEma: Int64;
    staDestin: TStringArray;
    staCorpoM: TStringArray;
    staAnexos: TStringArray;

    strSenha : String;
    strEmail : String;
    strLogin : String;
    strRemete: String;
    intCodPrv: Integer;
    intPorSmt: Integer;
    intPorIma: Integer;
    strSerSmt: String;
    strSerIma: String;
    intLimArq: Integer;
    blnImgAss: Boolean;
    strTxtAss: String;
    strImgCor: String;
    blnSSLSai: Boolean;
    blnSSLEnt: Boolean;
    blnEnvAutCob: Boolean;
    strGravaPastaEnviados: String;
    mmsImaAss: TMemoryStream;
    FAbrirEditorAntesEnvio : Boolean;
    FOnThread : Boolean;
    DuplicatasEnvio : TArrDupTabelaEmail;

    FEmailEnviado: Boolean;
    FblnGravarAnexos: Boolean;
    FblnExcluirAposEnvio: Boolean;
    strArquivExclusao: String;

    strAutIncNotfic: String;

    FCodigoGrupoModelo,
    FCodigoModelo: String;

    FCopiaOculta: TStringArray;

    function fGetCorpoMsg    : TStringArray;
    function fGetAnexos      : TStringArray;
    function fGetAssunto     : String;
    function fGetCodCli      : String;
    function fGetAutInc      : String;
    function fGetIncCon      : String;
    function fGetCodEma      : Int64;
    function fGetDestinatario: TStringArray;
    function fGetCopiaOculta : TStringArray;
    function fGetOperador    : String;
    function fGetImgCorpo    : String;
    function fGetSSLSai      : Boolean;
    function fGetSSLEnt      : Boolean;
    function fGetEnvAutCob   : String;
    function fGetGravaPastaEnviados : String;
    function fGetDuplicatasEnvio : TArrDupTabelaEmail;
    function fGetAutIncNotFic : String;

    procedure pEnviaEmail;
    procedure pMarcaNotFicPendenteDeEnvio;

    function fDiretorioVazio(const strDiretorio: String): Boolean;
  protected
    procedure Execute; override;
  public
    property EmailEnviado: Boolean read FEmailEnviado;

    procedure ExecuteModal;
    procedure pSetOperad(Value: String);
    procedure pSetNomOpe(Value: String);
    procedure pSetAssunt(Value: String);
    procedure pSetCodCli(Value: String);
    procedure pSetAutInc(Value: String);
    procedure pSetIncCon(Value: String);
    procedure pSetCodEma(Value: Int64);
    procedure pSetDestin(Value: TStringArray);
    procedure pSetCopiaOculta(Value: TStringArray);
    procedure pSetCorpoM(Value: TStringArray);
    procedure pSetAnexos(Value: TStringArray);
    procedure pSetImgCorpo(Value: String);

    procedure pSetSenha(Value: String);
    procedure pSetEmail(Value: String);
    procedure pSetLogin(Value: String);
    procedure pSetRemete(Value: String);
    procedure pSetCodPrv(Value: Integer);
    procedure pSetPorSmt(Value: Integer);
    procedure pSetPorIma(Value: Integer);
    procedure pSetSerSmt(Value: String);
    procedure pSetSerIma(Value: String);
    procedure pSetLimArq(Value: Integer);
    procedure pSetImgAss(Value: Boolean);
    procedure pSetImaAss(Value: TMemoryStream);
    procedure pSetTxtAss(Value: String);
    procedure pSetSSLSai(Value: Boolean);
    procedure pSetSSLEnt(Value: Boolean);
    procedure pSetEnvAutCob(Value: Boolean);
    procedure pSetGravaPastaEnviados(Value: String);
    procedure pSetAbrirEditorAntesEnvio(Value: Boolean);
    procedure pSetDuplicatasEnvio(Value: TArrDupTabelaEmail);
    procedure pSetGravarAnexos(Value: Boolean);
    procedure pSetExcluirAposEnvio(Value: Boolean);
    procedure pSetArquivoExclusao(Value: String);
    procedure pSetAutIncNotFic(Value: String);

    procedure SetCodigoGrupoModelo(AValor: String);
    procedure SetCodigoModelo(AValor: String);

    constructor create;
    destructor Destroy; Override;

  end;

implementation

uses
  untFuncoesSimples, untConstantes, untModulo;

{ TThreadEnviaEmail }

constructor TThreadEnviaEmail.create;
begin
  FOnThread := False;
  inherited create(True);

  mmsImaAss  := TMemoryStream.create;
  FAbrirEditorAntesEnvio := False;

  FEmailEnviado := False;
end;

procedure TThreadEnviaEmail.ExecuteModal;
begin
  pEnviaEmail;
end;

destructor TThreadEnviaEmail.Destroy;
begin
  inherited;
end;

procedure TThreadEnviaEmail.Execute;
begin
  FOnThread := True;
  pEnviaEmail;
end;

function TThreadEnviaEmail.fDiretorioVazio(const strDiretorio: String): Boolean;
var
  SR     : TSearchRec;
  intCnt : Integer;
begin
  Result := False;
  FindFirst(IncludeTrailingPathDelimiter(strDiretorio)+'*', faAnyFile, SR);
  For intCnt := 1 To 2 Do
  Begin
    If (SR.Name = '.') Or (SR.Name = '..') Then
      Result := FindNext(SR) <> 0;
  End;

  SysUtils.FindClose(SR);
end;

function TThreadEnviaEmail.fGetAnexos: TStringArray;
begin
  Result := staAnexos;
end;

function TThreadEnviaEmail.fGetAssunto: String;
begin
  Result := strAssunt;
end;

function TThreadEnviaEmail.fGetAutInc: String;
begin
  Result := strAutInc;
end;

function TThreadEnviaEmail.fGetAutIncNotFic: String;
begin
  Result := strAutIncNotFic;
end;

function TThreadEnviaEmail.fGetCodCli: String;
begin
  Result := strCodCli;
end;

function TThreadEnviaEmail.fGetCodEma: Int64;
begin
  Result := intCodEma;
end;

function TThreadEnviaEmail.fGetCopiaOculta: TStringArray;
begin
  Result := FCopiaOculta;
end;

function TThreadEnviaEmail.fGetCorpoMsg: TStringArray;
begin
  Result := staCorpoM;
end;

function TThreadEnviaEmail.fGetDestinatario: TStringArray;
begin
  Result := staDestin;
end;

function TThreadEnviaEmail.fGetDuplicatasEnvio: TArrDupTabelaEmail;
begin
  If Assigned(DuplicatasEnvio) Then
    Result := DuplicatasEnvio;
end;

function TThreadEnviaEmail.fGetImgCorpo: String;
begin
  Result := strImgCor;
end;

function TThreadEnviaEmail.fGetIncCon: String;
begin
  Result := strIncCon;
end;

function TThreadEnviaEmail.fGetOperador: String;
begin
  Result := strOperad;
end;

function TThreadEnviaEmail.fGetSSLEnt: Boolean;
begin
  Result := blnSSLEnt;
end;

function TThreadEnviaEmail.fGetSSLSai: Boolean;
begin
  Result := blnSSLSai;
end;

procedure TThreadEnviaEmail.pEnviaEmail;

  function fDadosPreenchidos: Boolean;
  begin
    Result := (not strEmail.IsEmpty) and (intPorSmt > 0) and (intPorIma >= 0)
          and (not strSerSmt.IsEmpty) and (intLimArq > 0) and
          ((not strSenha.IsEmpty) Or (fCampoTabela('PRV_USAOA2', 'CADPRV', ['PRV_CODPRV'], [intCodPrv]) = 'S'));
  end;

var
  strArquivoRemover  : String;
  sltArquivosRemover : TStrings;
  intContador: Integer;
begin
  Try
    if (FOnThread) and (not fDadosPreenchidos) then
      Exit;

    for intContador := 0 to Length(staAnexos)-1 do
    begin
      if not fArquivoExisteNoDiretorio(staAnexos[intContador], 40, 2000) then
      begin
        FEmailEnviado := False;
        Exit;
      end;
    end;

    TEnvioEmail.FCodigoGrupoModelo := FCodigoGrupoModelo;
    TEnvioEmail.FCodigoModelo := FCodigoModelo;

    FEmailEnviado := TEnvioEmail.EnviarEmail(Nil, fGetOperador(), fGetAssunto(), fGetDestinatario(), [], fGetCopiaOculta(), fGetCorpoMsg(),
                            fGetAnexos(), FAbrirEditorAntesEnvio, False, fGetAutInc(), fGetIncCon(), fGetCodEma(), True, strSenha,
                            strEmail, strLogin, strRemete, intCodPrv, intPorSmt, intPorIma, strSerSmt, strSerIma,
                            intLimArq, blnImgAss, strTxtAss, mmsImaAss, strNomOpe, fGetImgCorpo(),
                            fGetSSLSai(), fGetSSLEnt(), fGetGravaPastaEnviados(), fGetEnvAutCob(),fGetCodCli(),'',true,true,true,
                            fGetDuplicatasEnvio, FblnGravarAnexos, False, EmptyStr, fGetAutIncNotFic);


    If FblnExcluirAposEnvio Then
    Begin
      sltArquivosRemover := TStringList.Create;
      Try
        sltArquivosRemover.Delimiter       := ';';
        sltArquivosRemover.StrictDelimiter := True;
        sltArquivosRemover.DelimitedText   := strArquivExclusao;

        For strArquivoRemover in sltArquivosRemover Do
        Begin
          If FileExists(strArquivoRemover) Then
            SysUtils.DeleteFile(strArquivoRemover);

          If (DirectoryExists(ExtractFilePath(strArquivoRemover))) And
             (fDiretorioVazio(ExtractFilePath(strArquivoRemover))) Then
            RemoveDir(ExtractFilePath(strArquivoRemover));
        End;
      Finally
        FreeAndNil(sltArquivosRemover);
      End;
    End;

  Finally
    if (not FEmailEnviado) and (not fEmptyStr(fGetAutIncNotFic)) then
      pMarcaNotFicPendenteDeEnvio;

    mmsImaAss.Free;
  End;
end;

procedure TThreadEnviaEmail.pMarcaNotFicPendenteDeEnvio;
var
  qryMarEnv: TUniQuery;
begin
  qryMarEnv := fCriaQuery(nil);
  try
    qryMarEnv.Close;
    qryMarEnv.SQL.Text :=
    ' UPDATE '+
    '   NOTFIC '+
    ' LEFT JOIN EMAENV '+
    '   ON NOTFIC.AUTOINCREM = ENV_SEQNOT '+
    ' SET '+
    '   NOT_NOTENV = IF(DATE(NOT_DTAHOR) < CURRENT_DATE, "X", "N"), ' +
    '   NOT_ENVEMA = "S" '+
    ' WHERE '+
    '   NOTFIC.AUTOINCREM = :AUTINC AND '+
    '   ENV_SEQNOT IS NULL ';

    qryMarEnv.ParamByName('AUTINC').AsString := fGetAutIncNotFic;
    qryMarEnv.ExecSQL;
  finally
    FreeAndNil(qryMarEnv);
  end;
end;

function TThreadEnviaEmail.fGetGravaPastaEnviados: String;
begin
  If ((strGravaPastaEnviados = 'S') Or (strGravaPastaEnviados.IsEmpty)) Then
    Result := 'S'
  Else  
    Result := 'N'
end;

procedure TThreadEnviaEmail.pSetAbrirEditorAntesEnvio(Value: Boolean);
begin
  FAbrirEditorAntesEnvio := Value;
end;

procedure TThreadEnviaEmail.pSetAnexos(Value: TStringArray);
Var
  intContador: Integer;
begin
  SetLength(staAnexos, Length(Value));

  For intContador := low(Value) To High(Value) Do
    staAnexos[intContador] := Value[intContador];
end;

procedure TThreadEnviaEmail.pSetArquivoExclusao(Value: String);
begin
  strArquivExclusao := Value;
end;

procedure TThreadEnviaEmail.pSetAssunt(Value: String);
begin
  strAssunt := Value;
end;

procedure TThreadEnviaEmail.pSetAutInc(Value: String);
begin
  strAutInc := Value;
end;

procedure TThreadEnviaEmail.pSetAutIncNotFic(Value: String);
begin
  strAutIncNotFic := Value;
end;

procedure TThreadEnviaEmail.pSetCodCli(Value: String);
begin
  strCodCli := Value;
end;

procedure TThreadEnviaEmail.pSetCodEma(Value: Int64);
begin
  intCodEma := Value;
end;

procedure TThreadEnviaEmail.pSetCorpoM(Value: TStringArray);
begin
  staCorpoM := Value;
end;

procedure TThreadEnviaEmail.pSetDestin(Value: TStringArray);
Var
  intContador: Integer;
begin
  SetLength(staDestin, Length(Value));

  For intContador := low(Value) To High(Value) Do
    staDestin[intContador] := Value[intContador];
end;

procedure TThreadEnviaEmail.pSetDuplicatasEnvio(Value: TArrDupTabelaEmail);
begin
  If Assigned(Value) Then
    DuplicatasEnvio := Value;
end;

procedure TThreadEnviaEmail.pSetEmail(Value: String);
begin
  strEmail := Value;
end;

procedure TThreadEnviaEmail.pSetGravaPastaEnviados(Value: String);
begin
  strGravaPastaEnviados := Value;
end;

procedure TThreadEnviaEmail.pSetGravarAnexos(Value: Boolean);
begin
  FblnGravarAnexos := Value;
end;

procedure TThreadEnviaEmail.pSetImaAss(Value: TMemoryStream);
begin
  mmsImaAss.LoadFromStream(Value);
end;

procedure TThreadEnviaEmail.pSetImgAss(Value: Boolean);
begin
  blnImgAss := Value;
end;

procedure TThreadEnviaEmail.pSetImgCorpo(Value: String);
begin
  strImgCor := Value;
end;

procedure TThreadEnviaEmail.pSetIncCon(Value: String);
begin
  strIncCon := Value;
end;

procedure TThreadEnviaEmail.pSetLimArq(Value: Integer);
begin
  intLimArq := Value;
end;

procedure TThreadEnviaEmail.pSetLogin(Value: String);
begin
  strLogin := Value;
end;

procedure TThreadEnviaEmail.pSetNomOpe(Value: String);
begin
  strNomOpe := Value;
end;

procedure TThreadEnviaEmail.pSetOperad(Value: String);
begin
  strOperad := Value;
end;

procedure TThreadEnviaEmail.pSetPorIma(Value: Integer);
begin
  intPorIma := Value;
end;

procedure TThreadEnviaEmail.pSetPorSmt(Value: Integer);
begin
  intPorSmt := Value;
end;

procedure TThreadEnviaEmail.pSetCodPrv(Value: Integer);
begin
  intCodPrv := Value;
end;

procedure TThreadEnviaEmail.pSetCopiaOculta(Value: TStringArray);
Var
  intContador: Integer;
begin
  SetLength(FCopiaOculta, Length(Value));

  For intContador := low(Value) To High(Value) Do
    FCopiaOculta[intContador] := Value[intContador];
end;

procedure TThreadEnviaEmail.pSetRemete(Value: String);
begin
  strRemete := Value;
end;

procedure TThreadEnviaEmail.pSetSenha(Value: String);
begin
  strSenha := Value;
end;

procedure TThreadEnviaEmail.pSetSerIma(Value: String);
begin
  strSerIma := Value;
end;

procedure TThreadEnviaEmail.pSetSerSmt(Value: String);
begin
  strSerSmt := Value;
end;

procedure TThreadEnviaEmail.pSetSSLEnt(Value: Boolean);
begin
  blnSSLEnt := Value;
end;

procedure TThreadEnviaEmail.pSetSSLSai(Value: Boolean);
begin
  blnSSLSai := Value;
end;

procedure TThreadEnviaEmail.pSetTxtAss(Value: String);
begin
  strTxtAss := Value;
end;

procedure TThreadEnviaEmail.SetCodigoGrupoModelo(AValor: String);
begin
  FCodigoGrupoModelo := AValor;
end;

procedure TThreadEnviaEmail.SetCodigoModelo(AValor: String);
begin
  FCodigoModelo := AValor;
end;

function TThreadEnviaEmail.fGetEnvAutCob: String;
begin
  If blnEnvAutCob Then
    Result := 'S'
  Else
    Result := 'N';
end;

procedure TThreadEnviaEmail.pSetEnvAutCob(Value: Boolean);
begin
  blnEnvAutCob := Value;
end;

procedure TThreadEnviaEmail.pSetExcluirAposEnvio(Value: Boolean);
begin
  FblnExcluirAposEnvio := Value;
end;

end.
