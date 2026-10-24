unit Contabilidade.FuncoesFormPai;

interface

uses Data.DB, Uni, System.Classes, SysUtils, StrUtils, Contabilidade.InterfaceTrace;

procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');
procedure pGravaLogTransacao(objConexao     : TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
function fConexaoAtiva(): Boolean;
function fGetNomeFormularios: String;

var
  VS_strTituloVersao: String;
  VS_objTraceViewerContabilidade: ITraceViewerContabilidade;
  VS_TraceContabilidade: ISQLTraceContabilidade;

implementation

uses untFuncoesSimples, Contabilidade.Interfaces, vcl.Forms, untModulo, vcl.stdCtrls,
     Contabilidade.View.LogTrace, untTypesSistema ;

const
  CNS_TRA_EM_MSG = '<TRA_EM_MSG>';

function fMensagemDeveSerRegistrada(const ATextoComplementar: string): Boolean;
begin
  Result := (Not AnsiUpperCase(ATextoComplementar).Contains('DOCUMENTO EMITIDO EM AMBIENTE DE HOMOLOGAÇÃO'));
end;

procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');
begin
  If (Not strLoginUsuarioLogado.IsEmpty) Then
  Begin
    Try
      If Assigned(objConexao) Then
      Begin
        If fInTransaction(objConexao) Then
          If fMensagemDeveSerRegistrada(strTextoComplementarAoCallStack) Then
            pGravaLogTransacao(objConexao, CNS_TRA_EM_MSG, strTextoComplementarAoCallStack);
      End
      Else
      Begin
        If fConexaoAtiva Then
          If fInTransaction Then
            If fMensagemDeveSerRegistrada(strTextoComplementarAoCallStack) Then
              pGravaLogTransacao(Nil, CNS_TRA_EM_MSG, strTextoComplementarAoCallStack);
      End;
    Except
      //
    End;
  End;
end;

procedure pGravaLogTransacao(objConexao: TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
  Var
    qryAux: TUniQuery;
    strTransacao: String;
    tmrStart: TDateTime;
begin
  if not fTabelaExiste('TRANSACOES') then
  begin
    exit ;
  end;

  qryAux := fCriaQuery(Nil, objConexao);
  Try
    Try
      tmrStart := fNow();
      qryAux.SQL.Text := 'SELECT * FROM TRANSACOES WHERE FALSE';
      qryAux.Open;

      If (strIdenti.IsEmpty) Then
      Begin
        strTransacao := FormatDateTime('dd/mm/yyyy hh:nn:ss', tmrStart);
        VS_dtaIdentiTransacao.Add(strTransacao);

        qryAux.Append;
        qryAux.FieldByName('TRA_CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.FieldByName('TRA_IDENTI').AsString := strTransacao;
        qryAux.FieldByName('TRA_STACK_').AsString := fGetNomeFormularios;//fRetornaStack;
        qryAux.FieldByName('TRA_ID_CON').AsString := fGetConnectionID(objConexao);
        qryAux.FieldByName('TRA_HORSTA').AsDateTime := tmrStart;

        if qryAux.FindField('TRA_MODULE') <> nil then
          qryAux.FieldByName('TRA_MODULE').AsString := ExtractFileName(GetModuleName(HInstance));

        if qryAux.FindField('TRA_NOMMAQ') <> nil then
          qryAux.FieldByName('TRA_NOMMAQ').AsString := VS_ComputerNetName;

        if qryAux.FindField('TRA_NOMUSU') <> nil then
          qryAux.FieldByName('TRA_NOMUSU').AsString := VS_UserFromWindows;

        qryAux.Post;

        VS_TimerTransacao.Enabled := True;
      End
      Else
      Begin
        If (strIdenti.Contains(CNS_TRA_EM_MSG)) Then
        Begin
          strTextoComplementarAoCallStack :=
              strTextoComplementarAoCallStack + #10#13 +
              'Versão Arquivo: '  + fRetornaVersao(Application.ExeName, False) + #13 +
              'Versão Produto: '  + fRetornaVersao(Application.ExeName, True)  + #13 +
              'Path do Arquivo: ' + ExtractFilePath(Application.ExeName);
        End;

        qryAux.Append;
        qryAux.ParamByName('TRA_CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.ParamByName('TRA_IDENTI').AsString := strIdenti;
        qryAux.ParamByName('TRA_STACK_').AsString := strTextoComplementarAoCallStack + #10#13 + fGetNomeFormularios + #10#13 + fRetornaStack;
        qryAux.ParamByName('TRA_ID_CON').AsString := fGetConnectionID(objConexao);
        qryAux.ParamByName('TRA_HORSTA').AsDateTime := tmrStart;

        if qryAux.FindField('TRA_MODULE') <> nil then
          qryAux.FieldByName('TRA_MODULE').AsString := ExtractFileName(GetModuleName(HInstance));

        if qryAux.FindField('TRA_NOMMAQ') <> nil then
          qryAux.FieldByName('TRA_NOMMAQ').AsString := VS_ComputerNetName;

        if qryAux.FindField('TRA_NOMUSU') <> nil then
          qryAux.FieldByName('TRA_NOMUSU').AsString := VS_UserFromWindows;

        qryAux.Post;
      End;

    Except
      //
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
begin
  If Assigned(objConexao) Then
    Result := objConexao.InTransaction
  else
    Result := frmModulo.Database.InTransaction;
end;

function fConexaoAtiva(): Boolean;
begin
  Result := Assigned(frmModulo) And frmModulo.Database.Connected;
end;

function fGetNomeFormularios: String;
  Var
    intIdx: Integer;
    intRec: Integer;
    LblMensagem : TComponent;
begin
  Result := '';
  intRec := 0;
  For intIdx := Screen.FormCount -1 Downto 0 Do
  Begin
    If (Screen.Forms[intIdx].Name <> '') Then
    Begin
      Result := Result + StringOfChar(' ',intRec) + Screen.Forms[intIdx].Name + ' (' + Screen.Forms[intIdx].Caption + ')';

      If Pos('frmGravando', Screen.Forms[intIdx].Name) > 0 Then
      Begin
        LblMensagem := Screen.Forms[intIdx].FindComponent('lblGravando');

        If (LblMensagem <> Nil) And (LblMensagem Is TLabel) Then
          Result := Result + ' (' + (TLabel(LblMensagem).Caption) + ')';
      End;

      Inc(intRec);

      Result := Result + #13#10;
    End;
  End;
end;

initialization
  VS_objTraceViewerContabilidade := Nil;
  VS_TraceContabilidade := Nil ;

finalization
  VS_objTraceViewerContabilidade := Nil;
  VS_TraceContabilidade := Nil ;

end.
