unit untLogCancelamento;

interface

uses untTypesSistema, System.Generics.Collections, untMsgGridGenerica;

type
  TDocCancelamento = record
    Documento : String;
    Especie : String;
    CodigoCliente : String;
    NomeCliente : String;
    TipoClienteFornecedor : String;
    SerieFiscal : String;
    OpcaoDeCancelamento : String;
  End;

  TMotivoCancelamento = record
    CodigoMotivo : String;
    DescricaoMotivo : String;
    ComplementoDoHistorico : String;
    OperadorCancelamento : String;
  End;

  TLogCancelamento = class
  private
    FDocumentos : TList<TDocCancelamento>;
    function DocumentoExiste(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATipFc : String) : Boolean;
    function GetColunasPendencia: TArrRecordFields;
    procedure VerificarSeDocumentoJaFoiCanceladoAutcom(const ACodEmp : String; var ATemDocumentos : Boolean);
    procedure VerificarSeDocumentoJaFoiCanceladoFit(const ACodEmp : String; var ATemDocumentos : Boolean);
    procedure AtualizaLogDeCancelamentoFit(const AAutInc: String);
    procedure AtualizaLogDeCancelamentoAutcom(const AAutInc: String);
    procedure AtualizaLogDeCancelamentoCompleto(const AAutInc: String);
    procedure AtualizaLogDeCancelamentoHistorico(const AAutInc: String; ATemErr: Boolean; AMsgCan: String);
    function EmProcessoDeCancelamento(const AStatus : String) : Boolean;
    function StatusContemAlgumDosValores(const ATextoStatus : String; const AValoresPossiveis : TArray<String>) : Boolean;
  public
    function GravaLogDeCancelamento(var AAutInc: String; const ANumDoc, AEspDoc, ACodEmp, ASerie_, AForCli, ATip_FC: String; const AMotivoCancelamento : TMotivoCancelamento; const AOpcDel : String): Boolean;
    procedure AtualizaLogDeCancelamento(const AAutInc: String; ACanFit, ACanAut, ACanCon, ATemErr: Boolean; AMsgCan: String);
    function GetMotivoCancelamento(const ANumDoc, AEspDoc, ACodEmp, ACliFor, ATipFc, ASerieCan : String) : TMotivoCancelamento;
    function EscolherPendencia(const ACodEmp : String; var ATemDocumento : Boolean) : TDocCancelamento;
    function ExistePendenciaDeCancelamento(const ACodEmp : String) : Boolean;
    procedure VerificarSeDocumentoJaFoiCancelado(const ACodEmp : String; var ATemDocumentos : Boolean);
    function EhDocumentoPendente(const ANumDoc, AForCli : String) : Boolean;
    function ValidouIntegridadeDocumentos(const strAutIncLogCan, strMensagens : String; const strCodEmp : String = '') : Boolean;
    function fExisteCancelamentoPendentePorChaveAcesso(const AChaveAcesso: String): Boolean;
    class function ExistePendenciaParaCanceladorAutomatico(const ACodEmp : String; const AMinutosDeVida : Integer) : Boolean;
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses System.SysUtils, untFuncoesSimples, Uni, untLibNfe, untLiberacao, System.StrUtils;

{ TLogCancelamento }

function TLogCancelamento.EmProcessoDeCancelamento(const AStatus: String): Boolean;
begin
  Result := AStatus.Contains('990-') or AnsiLowerCase(AStatus).Contains('processando cancelamento')
end;

function TLogCancelamento.StatusContemAlgumDosValores(const ATextoStatus: String; const AValoresPossiveis: TArray<String>): Boolean;
  Var
    LTextoNormalizado : String;
    LValor : String;
begin
  Result := False;
  LTextoNormalizado := fRemoveAcento(AnsiLowerCase(ATextoStatus));
  For LValor In AValoresPossiveis Do
  Begin
    If LTextoNormalizado.Contains(LValor) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TLogCancelamento.GravaLogDeCancelamento(var AAutInc: String; const ANumDoc, AEspDoc, ACodEmp, ASerie_, AForCli, ATip_FC: String; const AMotivoCancelamento : TMotivoCancelamento; const AOpcDel : String): Boolean;
  Var
    LLogCan : TUniQuery;
    LDocumento : TDocCancelamento;

    procedure AcrescentarDocumento;
    begin
      LDocumento := Default(TDocCancelamento);
      LDocumento.Documento := ANumDoc;
      LDocumento.Especie := AEspDoc;
      LDocumento.CodigoCliente := AForCli;
      LDocumento.TipoClienteFornecedor := ATip_FC;
      LDocumento.SerieFiscal := ASerie_;
      LDocumento.OpcaoDeCancelamento := AOpcDel;
      If (ATip_FC = 'C') Then
        LDocumento.NomeCliente := fRetNomCliente(AForCli)
      Else
        LDocumento.NomeCliente := fRetNomFornecedor(AForCli);
      FDocumentos.Clear;
      FDocumentos.Add(LDocumento);
    end;

begin
  Result := True;

  LLogCan := fCriaQuery(Nil);
  Try
    Try
      LLogCan.Close;
      LLogCan.SQL.Clear;
      LLogCan.SQL.Add(' SELECT AUTOINCREM, LOG_MOTDEL, LOG_DESMOT, LOG_HISCOM, LOG_OPCDEL ');
      LLogCan.SQL.Add('   FROM LOGCAN ');
      LLogCan.SQL.Add('  WHERE LOG_NUMDOC = :NUMDOC ');
      LLogCan.SQL.Add('    AND LOG_ESPDOC = :ESPDOC ');
      LLogCan.SQL.Add('    AND LOG_CODEMP = :CODEMP ');
      LLogCan.SQL.Add('    AND LOG_FORCLI = :FORCLI ');
      LLogCan.SQL.Add('    AND LOG_TIP_FC = :TIP_FC ');
      LLogCan.SQL.Add('    AND LOG_SERIE_ = :SERIE_ ');
      LLogCan.SQL.Add('    AND LOG_PENCAN = "S" ');
      LLogCan.SQL.Add('    AND LOG_CANCOM = "N" ');
      LLogCan.SQL.Add('    AND LOG_LIBCAN = "N" ');
      LLogCan.ParamByName('NUMDOC').AsString := ANumDoc;
      LLogCan.ParamByName('ESPDOC').AsString := AEspDoc;
      LLogCan.ParamByName('CODEMP').AsString := ACodEmp;
      LLogCan.ParamByName('FORCLI').AsString := AForCli;
      LLogCan.ParamByName('TIP_FC').AsString := ATip_FC;
      LLogCan.ParamByName('SERIE_').AsString := ASerie_;
      LLogCan.Open;

      If Not LLogCan.IsEmpty Then
      Begin
        AAutInc := LLogCan.FieldByName('AUTOINCREM').AsString;
        LLogCan.Edit;
        LLogCan.FieldByName('LOG_MOTDEL').AsString := AMotivoCancelamento.CodigoMotivo;
        LLogCan.FieldByName('LOG_DESMOT').AsString := AMotivoCancelamento.DescricaoMotivo;
        LLogCan.FieldByName('LOG_HISCOM').AsString := AMotivoCancelamento.ComplementoDoHistorico;
        LLogCan.FieldByName('LOG_OPCDEL').AsString := AOpcDel;
        LLogCan.Post;
        AcrescentarDocumento;
        Exit;
      End;

      LLogCan.Close;
      LLogCan.SQL.Clear;
      LLogCan.SQL.Add(' INSERT INTO LOGCAN ');
      LLogCan.SQL.Add('    (AUTOINCREM, ');
      LLogCan.SQL.Add('     LOG_NUMDOC, ');
      LLogCan.SQL.Add('     LOG_ESPDOC, ');
      LLogCan.SQL.Add('     LOG_CODEMP, ');
      LLogCan.SQL.Add('     LOG_FORCLI, ');
      LLogCan.SQL.Add('     LOG_TIP_FC, ');
      LLogCan.SQL.Add('     LOG_SERIE_, ');
      LLogCan.SQL.Add('     LOG_ACESSO, ');
      LLogCan.SQL.Add('     LOG_DTAENT, ');
      LLogCan.SQL.Add('     LOG_MOTDEL, ');
      LLogCan.SQL.Add('     LOG_DESMOT, ');
      LLogCan.SQL.Add('     LOG_DTACAN, ');
      LLogCan.SQL.Add('     LOG_HORCAN, ');
      LLogCan.SQL.Add('     LOG_LOGOPE, ');
      LLogCan.SQL.Add('     LOG_OPCDEL, ');
      LLogCan.SQL.Add('     LOG_HISCOM) ');
      LLogCan.SQL.Add('  VALUES ');
      LLogCan.SQL.Add('    (:AUTINC, ');
      LLogCan.SQL.Add('     :NUMDOC, ');
      LLogCan.SQL.Add('     :ESPDOC, ');
      LLogCan.SQL.Add('     :CODEMP, ');
      LLogCan.SQL.Add('     :FORCLI, ');
      LLogCan.SQL.Add('     :TIP_FC, ');
      LLogCan.SQL.Add('     :SERIE_, ');
      LLogCan.SQL.Add('     :ACESSO, ');
      LLogCan.SQL.Add('     :DTAENT, ');
      LLogCan.SQL.Add('     :MOTDEL, ');
      LLogCan.SQL.Add('     :DESMOT, ');
      LLogCan.SQL.Add('     :DTACAN, ');
      LLogCan.SQL.Add('     :HORCAN, ');
      LLogCan.SQL.Add('     :LOGOPE, ');
      LLogCan.SQL.Add('     :OPCDEL, ');
      LLogCan.SQL.Add('     :HISCOM) ');

      AAutInc := fRetAutoIncrem('LOGCAN', ACodEmp);
      LLogCan.ParamByName('AUTINC').AsString := AAutInc;
      LLogCan.ParamByName('NUMDOC').AsString := ANumDoc;
      LLogCan.ParamByName('ESPDOC').AsString := AEspDoc;
      LLogCan.ParamByName('CODEMP').AsString := ACodEmp;
      LLogCan.ParamByName('FORCLI').AsString := AForCli;
      LLogCan.ParamByName('TIP_FC').AsString := ATip_FC;
      LLogCan.ParamByName('SERIE_').AsString := ASerie_;
      LLogCan.ParamByName('ACESSO').AsString := fCampoTabela('FIS_ACESSO', 'CADFIS',
                                                               ['FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_CODEMP', 'FIS_TIP_FC', 'FIS_FORCLI', 'FIS_SERIE_'],
                                                               [ANumDoc, AEspDoc, ACodEmp, ATip_FC, AForCli, ASerie_]);
      LLogCan.ParamByName('DTAENT').AsDateTime := fNow;
      LLogCan.ParamByName('MOTDEL').AsString := AMotivoCancelamento.CodigoMotivo;
      LLogCan.ParamByName('DESMOT').AsString := AMotivoCancelamento.DescricaoMotivo;
      LLogCan.ParamByName('HISCOM').AsString := AMotivoCancelamento.ComplementoDoHistorico;
      LLogCan.ParamByName('DTACAN').AsDateTime := VS_Date;
      LLogCan.ParamByName('HORCAN').AsDateTime := fTime;
      LLogCan.ParamByName('LOGOPE').AsString := strLoginUsuarioLogado;
      LLogCan.ParamByName('OPCDEL').AsString := AOpcDel;
      LLogCan.ExecSQL;

      AcrescentarDocumento;
    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TLogCancelamento.GravaLogDeCancelamento]');
      End;
    End;
  Finally
    FreeAndNil(LLogCan);
  End;
end;

procedure TLogCancelamento.AtualizaLogDeCancelamentoFit(const AAutInc: String);
Var
  LLogCan : TUniQuery;
begin

  LLogCan := fCriaQuery(Nil);

  Try
    LLogCan.Close;
    LLogCan.SQL.Clear;
    LLogCan.SQL.Add('UPDATE LOGCAN SET LOG_CANFIT = :CANFIT, LOG_DTAFIT = :DTAFIT, LOG_HORFIT = :HORFIT WHERE AUTOINCREM = :AUTINC ');
    LLogCan.ParamByName('CANFIT').AsString   := 'S';
    LLogCan.ParamByName('DTAFIT').AsDateTime := VS_Date;
    LLogCan.ParamByName('HORFIT').AsDateTime := fTime;
    LLogCan.ParamByName('AUTINC').AsString   := AAutInc;
    LLogCan.ExecSQL;
  Finally
    FreeAndNil(LLogCan);
  End;

end;

procedure TLogCancelamento.AtualizaLogDeCancelamentoAutcom(const AAutInc: String);
Var
  LLogCan : TUniQuery;
begin

  LLogCan := fCriaQuery(Nil);

  Try
    LLogCan.Close;
    LLogCan.SQL.Clear;
    LLogCan.SQL.Add('UPDATE LOGCAN SET LOG_CANAUT = :CANAUT, LOG_DTAAUT = :DTAAUT, LOG_HORAUT = :HORAUT WHERE AUTOINCREM = :AUTINC ');
    LLogCan.ParamByName('CANAUT').AsString   := 'S';
    LLogCan.ParamByName('DTAAUT').AsDateTime := VS_Date;
    LLogCan.ParamByName('HORAUT').AsDateTime := fTime;
    LLogCan.ParamByName('AUTINC').AsString   := AAutInc;
    LLogCan.ExecSQL;
  Finally
    FreeAndNil(LLogCan);
  End;

end;

procedure TLogCancelamento.AtualizaLogDeCancelamentoCompleto(const AAutInc: String);
Var
  LLogCan : TUniQuery;
begin

  LLogCan := fCriaQuery(Nil);

  Try
    LLogCan.Close;
    LLogCan.SQL.Clear;
    LLogCan.SQL.Add('UPDATE LOGCAN SET LOG_PENCAN = :PENCAN, LOG_CANCOM = :CANCOM WHERE AUTOINCREM = :AUTINC ');
    LLogCan.ParamByName('PENCAN').AsString := 'N';
    LLogCan.ParamByName('CANCOM').AsString := 'S';
    LLogCan.ParamByName('AUTINC').AsString   := AAutInc;
    LLogCan.ExecSQL;
  Finally
    FreeAndNil(LLogCan);
  End;

end;

procedure TLogCancelamento.AtualizaLogDeCancelamentoHistorico(const AAutInc: String; ATemErr: Boolean; AMsgCan: String);
Var
  LLogCan: TUniQuery;
  LMsgCan: String;
begin

  LLogCan := fCriaQuery(Nil);

  Try
    LLogCan.Close;
    LLogCan.SQL.Clear;
    LLogCan.SQL.Add('SELECT * FROM LOGCAN ');
    LLogCan.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    LLogCan.ParamByName('AUTINC').AsString := AAutInc;
    LLogCan.Open;

    If (LLogCan.RecordCount > 0) Then
    Begin
      LMsgCan := 'Data: ' + FormatDateTime('dd-mm-yyyy', VS_Date) + ' Hora: ' + FormatDateTime('hh:mm:ss', fTime) + ' - ' + AMsgCan;

      LLogCan.Edit;
      If fEmptyStr(LLogCan.FieldByName('LOG_HISCAN').AsString) Then
        LLogCan.FieldByName('LOG_HISCAN').AsString := LMsgCan
      Else
        LLogCan.FieldByName('LOG_HISCAN').AsString := LLogCan.FieldByName('LOG_HISCAN').AsString + #13+ LMsgCan;
      LLogCan.Post;
    End;

  Finally
    FreeAndNil(LLogCan);
  End;

end;

procedure TLogCancelamento.AtualizaLogDeCancelamento(const AAutInc: String; ACanFit, ACanAut, ACanCon, ATemErr: Boolean; AMsgCan: String);
var
  LMsgCan: String;
begin
  If fEmptyStr(AAutInc) Then
    Exit;

  If ACanFit Then
    AtualizaLogDeCancelamentoFit(AAutInc);

  If ACanAut Then
    AtualizaLogDeCancelamentoAutcom(AAutInc);

  If ACanCon Then
    AtualizaLogDeCancelamentoCompleto(AAutInc);

  LMsgCan := AMsgCan;

  If ATemErr Then
    LMsgCan := 'Erro: ' + AMsgCan;

  AtualizaLogDeCancelamentoHistorico(AAutInc, ATemErr, LMsgCan);
end;

constructor TLogCancelamento.Create;
begin
  FDocumentos := TList<TDocCancelamento>.Create;
end;

destructor TLogCancelamento.Destroy;
begin
  FreeAndNil(FDocumentos);
  inherited;
end;

function TLogCancelamento.GetMotivoCancelamento(const ANumDoc, AEspDoc, ACodEmp, ACliFor, ATipFc, ASerieCan : String) : TMotivoCancelamento;
  Var
    LLogCan : TUniQuery;
begin
  LLogCan := fCriaQuery(Nil);
  Try
    FillChar(Result, SizeOf(Result), #0);
    LLogCan.Close;
    LLogCan.SQL.Add(' SELECT LOG_MOTDEL, LOG_DESMOT, LOG_HISCOM, LOG_LOGOPE ');
    LLogCan.SQL.Add('   FROM LOGCAN ');
    LLogCan.SQL.Add('  WHERE LOG_NUMDOC = :NUMDOC ');
    LLogCan.SQL.Add('    AND LOG_ESPDOC = :ESPDOC ');
    LLogCan.SQL.Add('    AND LOG_CODEMP = :CODEMP ');
    LLogCan.SQL.Add('    AND LOG_FORCLI = :FORCLI ');
    LLogCan.SQL.Add('    AND LOG_TIP_FC = :TIP_FC ');
    LLogCan.SQL.Add('    AND LOG_SERIE_ = :SERIE_ ');
    LLogCan.ParamByName('NUMDOC').AsString := ANumDoc;
    LLogCan.ParamByName('ESPDOC').AsString := AEspDoc;
    LLogCan.ParamByName('CODEMP').AsString := ACodEmp;
    LLogCan.ParamByName('FORCLI').AsString := ACliFor;
    LLogCan.ParamByName('TIP_FC').AsString := ATipFc;
    LLogCan.ParamByName('SERIE_').AsString := ASerieCan;
    LLogCan.Open;
    If LLogCan.IsEmpty Then
      Exit;
    Result.CodigoMotivo := LLogCan.FieldByName('LOG_MOTDEL').AsString;
    Result.DescricaoMotivo := LLogCan.FieldByName('LOG_DESMOT').AsString;
    Result.ComplementoDoHistorico := LLogCan.FieldByName('LOG_HISCOM').AsString;
    Result.OperadorCancelamento := LLogCan.FieldByName('LOG_LOGOPE').AsString;
    If (fEmptyStr(Result.DescricaoMotivo)) Then
      Result.DescricaoMotivo := 'CANCELAMENTO LOGCAN';
  Finally
    FreeAndNil(LLogCan);
  End;
end;

procedure TLogCancelamento.VerificarSeDocumentoJaFoiCancelado(const ACodEmp : String; var ATemDocumentos : Boolean);
begin
  VerificarSeDocumentoJaFoiCanceladoAutcom(ACodEmp, ATemDocumentos);
  VerificarSeDocumentoJaFoiCanceladoFit(ACodEmp, ATemDocumentos);
end;

function TLogCancelamento.DocumentoExiste(const ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATipFc : String) : Boolean;
  Var
    LAutInc : String;
    LCampoCliFor : String;
begin
  If (ATipFc = 'F') Then
    LCampoCliFor := 'GER_CODFOR'
  Else
    LCampoCliFor := 'GER_CODCLI';

  LAutInc := fCampoTabela('AUTOINCREM',
                          'MOVGER',
                          ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', LCampoCliFor, 'GER_SERIE_', 'GER_TIP_FC'],
                          [ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATipFc]);
  If fEmptyStr(LAutInc) Then
    LAutInc := fCampoTabela('AUTOINCREM',
                            'NOTGER',
                            ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', LCampoCliFor, 'GER_SERIE_', 'GER_TIP_FC'],
                            [ANumDoc, AEspDoc, ACodEmp, AForCli, ASerie, ATipFc]);
  Result := (Not fEmptyStr(LAutInc));
end;

function TLogCancelamento.EhDocumentoPendente(const ANumDoc,
  AForCli: String): Boolean;
 Var
    LDocumento : TDocCancelamento;
begin
  Result := False;
  For LDocumento In FDocumentos Do
  Begin
    If (LDocumento.Documento = ANumDoc) And
       (LDocumento.CodigoCliente = AForCli) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TLogCancelamento.EscolherPendencia(const ACodEmp : String; var ATemDocumento : Boolean): TDocCancelamento;
  Var
    LRecordFields : TArrRecordFields;
    LPendencias : TUniQuery;
begin
  ATemDocumento := False;
  Result := Default(TDocCancelamento);
  VerificarSeDocumentoJaFoiCancelado(ACodEmp, ATemDocumento);
  If (Not ATemDocumento) Then
    Exit;
  LPendencias := fCriaQuery(Nil);
  Try
    LRecordFields := GetColunasPendencia;
    LPendencias.SQL.Add(' SELECT LOGCAN.AUTOINCREM AS AUTINC, LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, LOG_SERIE_, LOG_FORCLI, LOG_TIP_FC, ');
    LPendencias.SQL.Add('        LOG_MOTDEL, LOG_DESMOT, LOG_HISCOM, IFNULL(CLI_NOMCLI, FOR_NOMFOR) AS NOME_CLIENTE, LOG_LOGOPE, LOG_OPCDEL, ');
    LPendencias.SQL.Add('        LOG_ACESSO ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = IF(LOG_TIP_FC = "C", LOG_FORCLI, NULL) ');
    LPendencias.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = IF(LOG_TIP_FC = "F", LOG_FORCLI, NULL) ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    LPendencias.ParamByName('CODEMP').AsString := ACodEmp;
    LPendencias.Open;
    If (LPendencias.IsEmpty) Then
      Exit;
    If (Not TfrmMsgGridGenerica.fMontaGridGenerico(LRecordFields, LPendencias, 'Pendências de Cancelamento | Selecione e confirme para cancelar!', True, True, '&Confirma', '&Sair')) Then
      Exit;
    Result.Documento := LPendencias.FieldByName('LOG_NUMDOC').AsString;
    Result.Especie := LPendencias.FieldByName('LOG_ESPDOC').AsString;
    Result.CodigoCliente := LPendencias.FieldByName('LOG_FORCLI').AsString;
    Result.NomeCliente := LPendencias.FieldByName('NOME_CLIENTE').AsString;
    Result.TipoClienteFornecedor := LPendencias.FieldByName('LOG_TIP_FC').AsString;
    Result.SerieFiscal := LPendencias.FieldByName('LOG_SERIE_').AsString;
    Result.OpcaoDeCancelamento := LPendencias.FieldByName('LOG_OPCDEL').AsString;
  Finally
    FreeAndNil(LPendencias);
  End;
end;

function TLogCancelamento.ExistePendenciaDeCancelamento(const ACodEmp : String): Boolean;
  Var
    LPendencias : TUniQuery;
    LDocumento : TDocCancelamento;
begin
  LPendencias := fCriaQuery();
  Try
    LPendencias.SQL.Add(' SELECT LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, LOG_FORCLI, LOG_SERIE_, LOG_TIP_FC, LOG_OPCDEL, IFNULL(CLI_NOMCLI, FOR_NOMFOR) AS NOME_CLIENTE ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('   LEFT JOIN CADCLI ON CLI_CODCLI = IF(LOG_TIP_FC = "C", LOG_FORCLI, NULL) ');
    LPendencias.SQL.Add('   LEFT JOIN CADFOR ON FOR_CODFOR = IF(LOG_TIP_FC = "F", LOG_FORCLI, NULL) ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    LPendencias.ParamByName('CODEMP').AsString := ACodEmp;
    LPendencias.Open;
    FDocumentos.Clear;
    LPendencias.First;
    While Not LPendencias.Eof Do
    Begin
      FillChar(LDocumento, SizeOf(LDocumento), #0);
      LDocumento.Documento := LPendencias.FieldByName('LOG_NUMDOC').AsString;
      LDocumento.Especie := LPendencias.FieldByName('LOG_ESPDOC').AsString;
      LDocumento.CodigoCliente := LPendencias.FieldByName('LOG_FORCLI').AsString;
      LDocumento.TipoClienteFornecedor := LPendencias.FieldByName('LOG_TIP_FC').AsString;
      LDocumento.SerieFiscal := LPendencias.FieldByName('LOG_SERIE_').AsString;
      LDocumento.OpcaoDeCancelamento := LPendencias.FieldByName('LOG_OPCDEL').AsString;
      LDocumento.NomeCliente := LPendencias.FieldByName('NOME_CLIENTE').AsString;
      FDocumentos.Add(LDocumento);
      LPendencias.Next;
    End;
    Result := (FDocumentos.Count > 0);
  Finally
    FreeAndNil(LPendencias);
  End;
end;

function TLogCancelamento.GetColunasPendencia: TArrRecordFields;
begin
  SetLength(Result, 8);
  Result[0].strFieldName := 'LOG_NUMDOC';
  Result[0].strFieldCaption := 'Número Documento';
  Result[1].strFieldName := 'LOG_ESPDOC';
  Result[1].strFieldCaption := 'Espécie';
  Result[2].strFieldName := 'LOG_CODEMP';
  Result[2].strFieldCaption := 'Empresa';
  Result[3].strFieldName := 'LOG_SERIE_';
  Result[3].strFieldCaption := 'Série';
  Result[4].strFieldName := 'LOG_FORCLI';
  Result[4].strFieldCaption := 'Código Cliente/Fornecedor';
  Result[5].strFieldName := 'LOG_TIP_FC';
  Result[5].strFieldCaption := 'Tipo';
  Result[6].strFieldName := 'NOME_CLIENTE';
  Result[6].strFieldCaption := 'Nome Cliente/Fornecedor';
  Result[7].strFieldName := 'LOG_LOGOPE';
  Result[7].strFieldCaption := 'Operador';
end;

procedure TLogCancelamento.VerificarSeDocumentoJaFoiCanceladoAutcom(
  const ACodEmp: String; var ATemDocumentos: Boolean);
  Var
    LPendencias : TUniQuery;
begin
  LPendencias := fCriaQuery(Nil);
  Try
    ATemDocumentos := False;
    LPendencias.SQL.Add(' SELECT AUTOINCREM, LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, LOG_FORCLI, LOG_SERIE_, LOG_TIP_FC, LOG_MOTDEL, LOG_OPCDEL ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    LPendencias.ParamByName('CODEMP').AsString := ACodEmp;
    LPendencias.Open;
    If (LPendencias.IsEmpty) Then
      Exit;
    ATemDocumentos := True;
    LPendencias.First;
    While Not LPendencias.Eof Do
    Begin
      If (fEmptyStr(LPendencias.FieldByName('LOG_MOTDEL').AsString)) Or
         (fEmptyStr(LPendencias.FieldByName('LOG_OPCDEL').AsString)) Then
      Begin
        AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
        LPendencias.Next;
        Continue;
      End;
      If (Not DocumentoExiste(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                              LPendencias.FieldByName('LOG_ESPDOC').AsString,
                              LPendencias.FieldByName('LOG_CODEMP').AsString,
                              LPendencias.FieldByName('LOG_FORCLI').AsString,
                              LPendencias.FieldByName('LOG_SERIE_').AsString,
                              LPendencias.FieldByName('LOG_TIP_FC').AsString)) Then
      Begin
        AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
        LPendencias.Next;
        Continue;
      End;
      LPendencias.Next;
    End;
  Finally
    FreeAndNil(LPendencias);
  End;
end;

procedure TLogCancelamento.VerificarSeDocumentoJaFoiCanceladoFit(
  const ACodEmp: String; var ATemDocumentos: Boolean);
  Var
    LPendencias : TUniQuery;
    LStatusDfe : String;
begin
  LPendencias := fCriaQuery(Nil);
  Try
    ATemDocumentos := False;
    LPendencias.SQL.Add(' SELECT AUTOINCREM, LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, LOG_FORCLI, LOG_SERIE_, LOG_TIP_FC, LOG_ACESSO ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    LPendencias.ParamByName('CODEMP').AsString := ACodEmp;
    LPendencias.Open;
    If (LPendencias.IsEmpty) Then
      Exit;
    ATemDocumentos := True;
    LPendencias.First;
    While Not LPendencias.Eof Do
    Begin
      LStatusDfe := fConsultaStatusDFe(LPendencias.FieldByName('LOG_ACESSO').AsString,
                                       LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                       LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                       LPendencias.FieldByName('LOG_CODEMP').AsString,
                                       LPendencias.FieldByName('LOG_SERIE_').AsString,
                                       LPendencias.FieldByName('LOG_FORCLI').AsString,
                                       LPendencias.FieldByName('LOG_TIP_FC').AsString);
      If (LStatusDfe <> 'Cancelada') Then
      Begin
        AtualizaLogDeCancelamentoFit(LPendencias.FieldByName('AUTOINCREM').AsString);
        LPendencias.Next;
        Continue;
      End;
      LPendencias.Next;
    End;
  Finally
    FreeAndNil(LPendencias);
  End;
end;

function TLogCancelamento.ValidouIntegridadeDocumentos(const strAutIncLogCan, strMensagens : String; const strCodEmp : String = '') : Boolean;
  Var
    LPendencias : TUniQuery;
    LStatusDfe : String;
    LDocumentoExiste : Boolean;
    LErroTimeOut : Boolean;
    LCodigoEmpresa : String;
    LStatusCancelamento : String;
    LEmProcessoDeCancelamento : Boolean;
begin
  LPendencias := fCriaQuery(Nil);
  Try
    LCodigoEmpresa := strCodEmp;
    If fEmptyStr(LCodigoEmpresa) Then
      LCodigoEmpresa := VS_strCodEmp;

    Result := False;

    LPendencias.SQL.Add(' SELECT AUTOINCREM, LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, LOG_FORCLI, LOG_SERIE_, LOG_TIP_FC, LOG_ACESSO ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    If (Not fEmptyStr(strAutIncLogCan)) Then
    Begin
      LPendencias.SQL.Add('  AND LOGCAN.AUTOINCREM = :AUTINC ');
      LPendencias.ParamByName('AUTINC').AsString := strAutIncLogCan;
    End;
    LPendencias.ParamByName('CODEMP').AsString := LCodigoEmpresa;
    LPendencias.Open;
    If (LPendencias.IsEmpty) Then
      Exit;
    LPendencias.First;
    While Not LPendencias.Eof Do
    Begin
      If fEmptyStr(LPendencias.FieldByName('LOG_ACESSO').AsString) Then
      Begin
        LStatusDfe := fConsultaStatusInutilizado(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [LPendencias.FieldByName('LOG_CODEMP').AsString], False),
                                                 LPendencias.FieldByName('LOG_SERIE_').AsString,
                                                 LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                                 LPendencias.FieldByName('LOG_CODEMP').AsString,
                                                 LPendencias.FieldByName('LOG_FORCLI').AsString,
                                                 LPendencias.FieldByName('LOG_TIP_FC').AsString,
                                                 IIF(LPendencias.FieldByName('LOG_ESPDOC').AsString = 'IF', '65', '55'));

        LEmProcessoDeCancelamento := False;
        LStatusCancelamento := '';

        If LStatusDfe <> 'Inutilizado' Then
        Begin
          LStatusCancelamento := fConsultaStatusCancelamento(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                                             LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                                             LPendencias.FieldByName('LOG_CODEMP').AsString,
                                                             LPendencias.FieldByName('LOG_SERIE_').AsString,
                                                             LPendencias.FieldByName('LOG_FORCLI').AsString,
                                                             LPendencias.FieldByName('LOG_TIP_FC').AsString);
          LEmProcessoDeCancelamento := EmProcessoDeCancelamento(LStatusCancelamento);
        End;

        LDocumentoExiste := DocumentoExiste(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                            LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                            LPendencias.FieldByName('LOG_CODEMP').AsString,
                                            LPendencias.FieldByName('LOG_FORCLI').AsString,
                                            LPendencias.FieldByName('LOG_SERIE_').AsString,
                                            LPendencias.FieldByName('LOG_TIP_FC').AsString);

        If (LStatusDfe = 'Inutilizado') Then
        Begin
          If (Not LDocumentoExiste) Then
          Begin
            AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
            AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento foi inutilizado na FIT e foi inutilizado no AUTCOM, LOGCAN será baixada.');
            Result := True;
          End
          Else
          Begin
            LPendencias.Next; // > Pendência deve continuar porque o documento foi inutilizado e ainda existe no AUTCOM!
            Continue;
          End;
        End
        Else If (LEmProcessoDeCancelamento) Then
        Begin
          AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento em processo de cancelamento, aguardar resposta definitiva da SEFAZ.');
          LPendencias.Next; // > Pendência deve continuar porque não temos a resposta definitiva da SEFAZ se o documento foi cancelado
          Continue;
        End
        Else If StatusContemAlgumDosValores(LStatusCancelamento, ['nf-e nao encontrada', 'nfc-e nao encontrada']) then
        Begin
          AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
          AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento não foi encontrado na fit: "' + LStatusCancelamento + '", e ' + IIF(LDocumentoExiste, 'foi', 'não foi') + ' encontrado no AUTCOM, LOGCAN será baixada.');
          Result := True;
        end
        else if StatusContemAlgumDosValores(LStatusCancelamento, ['evento nao encontrada', 'evento nao encontrado']) then
        begin
          If LDocumentoExiste Then
          Begin
            AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
            AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento autorizado na fit e encontrado no AUTCOM, LOGCAN será baixada.');
            Result := True;
          End;
        end;

        LPendencias.Next;
        Continue;
      End;

      LStatusDfe := fConsultaStatusDFe(LPendencias.FieldByName('LOG_ACESSO').AsString,
                                       LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                       LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                       LPendencias.FieldByName('LOG_CODEMP').AsString,
                                       LPendencias.FieldByName('LOG_SERIE_').AsString,
                                       LPendencias.FieldByName('LOG_FORCLI').AsString,
                                       LPendencias.FieldByName('LOG_TIP_FC').AsString);
      If (LStatusDfe = 'Autorizada') Then
      Begin
        LStatusCancelamento := fConsultaStatusCancelamento(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                                           LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                                           LPendencias.FieldByName('LOG_CODEMP').AsString,
                                                           LPendencias.FieldByName('LOG_SERIE_').AsString,
                                                           LPendencias.FieldByName('LOG_FORCLI').AsString,
                                                           LPendencias.FieldByName('LOG_TIP_FC').AsString);

        If EmProcessoDeCancelamento(LStatusCancelamento) Then
        Begin
          LPendencias.Next;
          Continue;
        End;

        LDocumentoExiste := DocumentoExiste(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                            LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                            LPendencias.FieldByName('LOG_CODEMP').AsString,
                                            LPendencias.FieldByName('LOG_FORCLI').AsString,
                                            LPendencias.FieldByName('LOG_SERIE_').AsString,
                                            LPendencias.FieldByName('LOG_TIP_FC').AsString);

        LErroTimeOut := (Not fEmptyStr(strMensagens)) And (strMensagens.Contains('Time-out'));

        If (LDocumentoExiste) Then
        Begin
          If (LErroTimeOut) Then
            AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, strMensagens)
          Else
          Begin
            AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
            If (Not fEmptyStr(strMensagens)) Then
              AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, strMensagens);
            AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento não foi cancelado na FIT e não foi cancelado no AUTCOM, LOGCAN será baixada.');
          End;
          Result := True;
        End;
      End
      Else If (LStatusDfe = 'Cancelada') Then
      Begin
        LDocumentoExiste := DocumentoExiste(LPendencias.FieldByName('LOG_NUMDOC').AsString,
                                            LPendencias.FieldByName('LOG_ESPDOC').AsString,
                                            LPendencias.FieldByName('LOG_CODEMP').AsString,
                                            LPendencias.FieldByName('LOG_FORCLI').AsString,
                                            LPendencias.FieldByName('LOG_SERIE_').AsString,
                                            LPendencias.FieldByName('LOG_TIP_FC').AsString);
        If (Not LDocumentoExiste) Then
        Begin
          AtualizaLogDeCancelamentoCompleto(LPendencias.FieldByName('AUTOINCREM').AsString);
          AtualizaLogDeCancelamentoHistorico(LPendencias.FieldByName('AUTOINCREM').AsString, False, 'Documento foi cancelado na FIT e foi cancelado no AUTCOM, LOGCAN será baixada.');
          Result := True;
        End;
      End;

      LPendencias.Next;
    End;
  Finally
    FreeAndNil(LPendencias);
  End;
end;

function TLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(const AChaveAcesso: String): Boolean;
  Var
    qryAux : TUniQuery;
begin
  Result := False;
  If fEmptyStr(AChaveAcesso) Then
    Exit;
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(' SELECT AUTOINCREM ');
    qryAux.SQL.Add('   FROM LOGCAN ');
    qryAux.SQL.Add('  WHERE LOG_ACESSO = :ACESSO ');
    qryAux.SQL.Add('    AND LOG_PENCAN = "S" ');
    qryAux.SQL.Add('    AND LOG_CANCOM = "N" ');
    qryAux.SQL.Add('    AND LOG_LIBCAN = "N" ');
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;
    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

class function TLogCancelamento.ExistePendenciaParaCanceladorAutomatico(const ACodEmp : String; const AMinutosDeVida : Integer) : Boolean;
  Var
    LPendencias : TUniQuery;
begin
  LPendencias := fCriaQuery(Nil);
  Try
    LPendencias.SQL.Add(' SELECT 1 ');
    LPendencias.SQL.Add('   FROM LOGCAN ');
    LPendencias.SQL.Add('  WHERE LOG_CODEMP = :CODEMP ');
    LPendencias.SQL.Add('    AND LOG_PENCAN = "S" ');
    LPendencias.SQL.Add('    AND LOG_CANCOM = "N" ');
    LPendencias.SQL.Add('    AND LOG_LIBCAN = "N" ');
    // Filtra so o tempo de vida; tentativas e prazo ficam com o pExecuteAll.
    // DTACAN/HORCAN vem do relogio da estacao e o pExecuteAll compara em valor absoluto: nula ou futura conta como pendente
    LPendencias.SQL.Add('    AND ((TIMESTAMP(LOG_DTACAN, LOG_HORCAN) IS NULL) ');
    LPendencias.SQL.Add('      OR (TIMESTAMP(LOG_DTACAN, LOG_HORCAN) > NOW()) ');
    LPendencias.SQL.Add('      OR (TIMESTAMP(LOG_DTACAN, LOG_HORCAN) <= NOW() - INTERVAL :MINVID MINUTE)) ');
    LPendencias.SQL.Add('  LIMIT 1 ');
    LPendencias.ParamByName('CODEMP').AsString := ACodEmp;
    // +1: o pExecuteAll compara com MinutesBetween > X, que so passa com X + 1 minutos inteiros
    LPendencias.ParamByName('MINVID').AsInteger := AMinutosDeVida + 1;
    LPendencias.Open;
    Result := Not LPendencias.IsEmpty;
  Finally
    FreeAndNil(LPendencias);
  End;
end;

end.
