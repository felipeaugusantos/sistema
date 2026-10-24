unit untLiberacaoCliente;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, DateUtils, untFuncoesSimples, Menus, StrUtils,
  AppEvnts, BitBtnLockedIncrem, UniClientDataSet, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, untConstantes, untMsgInterna, dxGDIPlusClasses;

type
  TfrmLiberacaoCliente = class(TfrmPaiSimples)
    pnlRodape: TPanel;
    tmrLibera: TTimer;
    pnlCabecalho: TPanel;
    edtNumLib: TEditFocus;
    edtSenLib: TEditFocus;
    lblNumLib: TLabel;
    lblSenLib: TLabel;
    btnTipSenha: TSpeedButton;
    edtTraTel: TEditFocus;
    MemObs: TMemo;
    btnLibera: TSpeedButton;
    imgAnalise: TImage;
    lblAnalise: TLabel;
    lblAnalisePor: TLabel;
    imgAguardando: TImage;
    lblAguardando: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLiberaClick(Sender: TObject);
    procedure tmrLiberaTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    function fGeraNumLiberacao: String;
    function fRetTagDir : Integer;
    procedure pEnviaMsgLiberacao;
    function fMsgLiberacaoJaAnalisando(var strOpeAnalise: String): Boolean;
    procedure pMostrarStatusAguardando(blnMostrar: Boolean);
    procedure pMostrarStatusEmAnalise(blnMostrar: Boolean);
    function fVerificaLiberacao(strNumLib: String): Boolean;
    function fMsgLiberacaoJaLida(var strMsgLib: String): Boolean;
    function fGravaLogVar(strNumLib, strInfLog, strCodOpe, strCodDig: String): Boolean;
    procedure pGravarJustificativa(strNumLib, strJustif: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strTagLiberacao  : String;
    strMessageHeader : String;
    strOpeAnalise    : String;
    blnConfirma : Boolean;
  end;

var
  frmLiberacaoCliente: TfrmLiberacaoCliente;

implementation

 uses Data.DB{, untFuncTinta};

{$R *.dfm}

{ TfrmLiberacaoCliente }

function TfrmLiberacaoCliente.fRetTagDir: Integer;
Var
  qryAux : TUniQuery;
Begin
  Try
    qryAux := fCriaQuery;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT TAG_NUMTAG '+
                       '  FROM TAGDIR '+
                       ' WHERE TAG_DESHIN = "'+ IIF(fEmptyStr(strTagLiberacao), 'BASITE', strTagLiberacao) + '"';;
    qryAux.Open;

    Result := qryAux.Fields[0].AsInteger;

  Finally
    FreeAndNil(qryAux);
  End;
End;

function TfrmLiberacaoCliente.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
Var
  strOperador : String;
begin
  Result := True;

  If (Sender = edtSenLib) And (Not edtSenLib.ReadOnly) Then
  Begin
    If fEmptyStr(edtSenLib.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A senha de liberação deve ser preenchida!', ['&O k']);
      Result := False;
      Exit;
    End;

    strOperador := fRetCodVendedor(edtSenLib.Text);

    If (Not fEmptyStr(strOperador)) Then
    Begin
      If (Not fVerificaAcessoSistema(IIF(fEmptyStr(strTagLiberacao), 'BASITE', strTagLiberacao), strOperador)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&O k']);
        Result := False;
      End
      Else If (fRetornaStatusCadastro(strOperador, 'OPE', 'CADOPE', 'OPE_CODOPE') = 'I') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Usuário está inativo!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        {**********************}
        {* GERA LOG LIBERACAO *}
        {*******************AF*}
        //pGeraMatrizLiberacao(strOperador, strLoginUsuarioLogado, strMensagem, strDirAce, strCodIte, fltPreUni, '', strInfBlo);
        Close;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&O k']);
      Result := False;
    End;
  End;

  VS_blnResult := Result;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmLiberacaoCliente.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumLib.text := fGeraNumLiberacao;
  VS_blnResult    := false;

  If fCfgSis('HABREM', varBoolean) Then
  Begin
    btnLibera.Visible := True;
    btnLibera.Enabled := True;
  End;

end;

procedure TfrmLiberacaoCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F8) And btnLibera.Visible And btnLibera.Enabled Then
    btnLibera.Click
end;

procedure TfrmLiberacaoCliente.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strMessageHeader) Then
    edtTraTel.Text := strMessageHeader;
end;

procedure TfrmLiberacaoCliente.btnLiberaClick(Sender: TObject);
begin
  inherited;
  pEnviaMsgLiberacao;
  tmrLibera.Enabled := True;
  btnLibera.Enabled := False;
end;

procedure TfrmLiberacaoCliente.pGravarJustificativa(strNumLib, strJustif: String);
  Var
    qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' UPDATE LOGVAR ');
    qryGen.SQL.Add('    SET LOG_JUSTIF = :JUSTIF ');
    qryGen.SQL.Add('  WHERE LOG_NROLIB = :NROLIB ');
    qryGen.SQL.Add('    AND LOG_CODEMP = :CODEMP ');
    qryGen.ParamByName('JUSTIF').AsString := strJustif;
    qryGen.ParamByName('NROLIB').AsString := strNumLib;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ExecSQL;

  Finally
    FreeAndNil(qryGen);
  End;
end;

Function TfrmLiberacaoCliente.fGravaLogVar(strNumLib, strInfLog, strCodOpe, strCodDig: String): Boolean;
  Var
    qryGen: TUniQuery;
    strAutInc : String;

Begin
  Result := True;
  qryGen := fCriaQuery;

  strInfLog := fLimpaTagMsgOculta(strInfLog);
  Try

    fStartTransaction;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO LOGVAR (');
    qryGen.SQL.Add('  AUTOINCREM,');
    qryGen.SQL.Add('  LOG_NROLIB,');
    qryGen.SQL.Add('  LOG_INFORM,');
    qryGen.SQL.Add('  LOG_CODVEN,');
    qryGen.SQL.Add('  LOG_CODDIG,');
    qryGen.SQL.Add('  LOG_CODEMP,');
    qryGen.SQL.Add('  LOG_DTAPED,');
    qryGen.SQL.Add('  LOG_HORPED ');
    qryGen.SQL.Add(') VALUES (');
    qryGen.SQL.Add('  :AUTOIN,');
    qryGen.SQL.Add('  :NROLIB,');
    qryGen.SQL.Add('  :INFORM,');
    qryGen.SQL.Add('  :CODVEN,');
    qryGen.SQL.Add('  :CODDIG,');
    qryGen.SQL.Add('  :CODEMP,');
    qryGen.SQL.Add('  :DTAPED,');
    qryGen.SQL.Add('  :HORPED ');
    qryGen.SQL.Add(')');

    strAutInc := fRetAutoIncrem('LOGVAR',VS_strCodEmp);

    qryGen.ParamByName('AUTOIN').AsString := strAutInc;
    qryGen.ParamByName('NROLIB').AsString := strNumLib;
    qryGen.ParamByName('INFORM').AsString := strInfLog;

    If Not fEmptyStr(strCodOpe) Then
      qryGen.ParamByName('CODVEN').AsString := strCodOpe;

    If Not fEmptyStr(strCodDig) Then
      qryGen.ParamByName('CODDIG').AsString := strCodDig;

    If fEmptyStr(strCodDig) Or (Not fCfgSis('USADIG', varBoolean)) Then
      qryGen.ParamByName('CODDIG').Clear;

    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DTAPED').AsDate   := VS_Date;
    qryGen.ParamByName('HORPED').AsTime   := fTime();


    Try
      qryGen.ExecSQL;

      If qryGen.RowsAffected = 0 Then
      Begin
        fRollBack;
        Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.');
      End;

      Result := qryGen.RowsAffected > 0;
    Except
      fRollBack;
      Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.');
    End;

  Finally

    FreeAndNil(qryGen);

    If Result Then
      fCommit();
  End;
End;

procedure TfrmLiberacaoCliente.pEnviaMsgLiberacao;
  Var
    strSQL    : String;
    qryCadOpe : TUniQuery;
    msgInterna: TMsgInterna;
    strMensagem: String;
//    strMensagemJson : String;
    strJustificativa: String;

begin

  fGravaLogVar(edtNumLib.Text, MemObs.Text, strLoginUsuarioLogado, '');

  strSQL := '';
  strSQL := strSQL + ' SELECT                      ';
  strSQL := strSQL + '   OPE_CODOPE                ';
  strSQL := strSQL + ' FROM                        ';
  strSQL := strSQL + '   CADOPE                    ';
  strSQL := strSQL + ' WHERE                       ';
  strSQL := strSQL + '   OPE_CODOPE <> :CODOPE AND ';
  strSQL := strSQL + '   LOCATE(:CODEMP, OPE_EMPLIB) > 0 AND ';//Feito para operadores que podem acessar a empresa para fazer vendas mas não podem liberar travas daquela empresa.

  strSQL := strSQL + '   OPE_MSGLIB  = "S"     AND ';
  strSQL := strSQL + '   OPE_STATUS <> "I"         ';

  strSQL := strSQL + ' ORDER BY                    ';
  strSQL := strSQL + '   OPE_CODOPE                ';

  strJustificativa := '';

  If fMensagem('', 'Deseja digitar uma justificativa para a solicitação de liberação?', ['','']) = 1 Then
  Begin
    While (fEmptyStr(strJustificativa)) Do
    Begin
       If not InputQuery('Justificativa de Liberação', 'Digite a justificativa para esta liberação:', strJustificativa) then
         break;
    End;

    pGravarJustificativa(edtNumLib.Text, strJustificativa);
  End;

  strMensagem := MemObs.Text;

  strMensagem    := AnsiReplaceStr(strMensagem, #13#10, STRING_QUEBRA);

  If Not (fVerificaAcessoSistema('PVISPF')) Then
  Begin
    strMensagem := AnsiReplaceStr(strMensagem, '@(', '');
    strMensagem := AnsiReplaceStr(strMensagem, ')@', '');
  End;

  msgInterna := TMsgInterna.Create(Self);
  qryCadOpe := fCriaQuery;

  Try
    qryCadOpe.Close;
    qryCadOpe.SQL.Text := strSQL;
    qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCadOpe.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCadOpe.Open;
    qryCadOpe.First;

    fStartTransaction();

    Try
      While Not qryCadOpe.Eof Do
      Begin
        If (fVerificaAcessoSistema('TRODIR', qryCadOpe.FieldByName('OPE_CODOPE').AsString)) Then
        Begin
          If Not msgInterna.fEnviaMensagem( 'Troca de Tintas',
                                            strMensagem,
                                            strLoginUsuarioLogado,
                                            qryCadOpe.FieldByName('OPE_CODOPE').AsString,
                                            'S',
                                            edtNumLib.Text ) Then
          Begin
            fRollBack();
            Exit;
          End;
        End;

        qryCadOpe.Next;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro('Erro: ' + E.Message,'[pEnviaMsgLiberacao]');
      End;
    End;

    fCommit();

  Finally

    FreeAndNil(msgInterna);

    FreeAndNil(qryCadOpe);
  End;
end;

function TfrmLiberacaoCliente.fMsgLiberacaoJaAnalisando(var strOpeAnalise: String): Boolean;
var
  qryMsg: TUniQuery;
begin

  qryMsg := fCriaQuery(nil);

  Try
    qryMsg.Close;
    qryMsg.SQL.Clear;

    qryMsg.SQL.Add('SELECT SQL_NO_CACHE ');
    qryMsg.SQL.Add('  MSG_OPELIB ');
    qryMsg.SQL.Add('FROM ');
    qryMsg.SQL.Add('  CADMSG ');
    qryMsg.SQL.Add('WHERE ');
    qryMsg.SQL.Add('  MSG_OPEENV = :OPEENV AND ');
    qryMsg.SQL.Add('  MSG_NUMLIB = :NUMLIB AND ');
    qryMsg.SQL.Add('  ((MSG_OPELIB IS NOT NULL) AND (MSG_OPELIB <> "")) ');

    qryMsg.ParamByName('OPEENV').AsString := strLoginUsuarioLogado;
    qryMsg.ParamByName('NUMLIB').AsString := edtNumLib.Text;

    qryMsg.Open;

    Result := (Not qryMsg.IsEmpty);

    strOpeAnalise := '';

    If Result Then
      strOpeAnalise := qryMsg.FieldByName('MSG_OPELIB').AsString;

  Finally
    FreeAndNil(qryMsg);
  End;

end;

procedure TfrmLiberacaoCliente.pMostrarStatusAguardando(blnMostrar: Boolean);
begin
  imgAguardando.Visible := blnMostrar;
  lblAguardando.Visible := blnMostrar;

  {Posicionar a frente do [F8]}
  imgAguardando.Top := imgAnalise.Top;
  lblAguardando.Top := imgAnalise.Top;
end;

procedure TfrmLiberacaoCliente.pMostrarStatusEmAnalise(blnMostrar: Boolean);
begin
  imgAnalise.Visible    := blnMostrar;
  lblAnalise.Visible    := blnMostrar;
  lblAnalisePor.Visible := blnMostrar;
end;

function TfrmLiberacaoCliente.fMsgLiberacaoJaLida(var strMsgLib: String): Boolean;
  var
    qryMsg: TUniQuery;
begin
  qryMsg := fCriaQuery(nil);

  try
    qryMsg.Close;
    qryMsg.SQL.Clear;
    qryMsg.SQL.Add('SELECT SQL_NO_CACHE ');
    qryMsg.SQL.Add('  MSG_MSGLIB ');
    qryMsg.SQL.Add('FROM ');
    qryMsg.SQL.Add('  CADMSG ');
    qryMsg.SQL.Add('WHERE ');
    qryMsg.SQL.Add('  MSG_OPEENV = :OPEENV AND ');
    qryMsg.SQL.Add('  MSG_NUMLIB = :NUMLIB AND ');
    qryMsg.SQL.Add('  MSG_LIDA__ = "S" ');

    qryMsg.ParamByName('OPEENV').AsString := strLoginUsuarioLogado;
    qryMsg.ParamByName('NUMLIB').AsString := edtNumLib.Text;

    qryMsg.Open;

    Result := (Not qryMsg.IsEmpty);

    strMsgLib := '';

    If Result Then
      strMsgLib := qryMsg.FieldByName('MSG_MSGLIB').AsString;

  Finally
    FreeAndNil(qryMsg);
  End;
end;

procedure TfrmLiberacaoCliente.tmrLiberaTimer(Sender: TObject);
Var
  strMsgLib     : String;
  strOpeAnalise : String;
begin

  inherited;

  If Not btnLibera.Enabled Then
  Begin

    If fMsgLiberacaoJaAnalisando(strOpeAnalise) Then
    Begin
      If Not fEmptyStr(strOpeAnalise) Then
      Begin
        lblAnalisePor.Caption := 'Por: ' + strOpeAnalise + '-' + fRetNomeOperador(strOpeAnalise);
        pMostrarStatusEmAnalise(True);
        pMostrarStatusAguardando(False);
      End;
    End
    Else
    Begin
      pMostrarStatusEmAnalise(False);
      pMostrarStatusAguardando(True);
    End;

  End;

  If fVerificaLiberacao(edtNumLib.Text) Then
  Begin
    If fCfgSis('JUSLIB', varBoolean) Then
    begin
      While Not fMsgLiberacaoJaLida(strMsgLib) Do
      Begin
        Continue;
      End;

      If Not fEmptyStr(strMsgLib) Then
      Begin
        strMsgLib := sLineBreak + 'Justificativa de Liberação: ' + strMsgLib;
      End;
    End;

    VS_blnResult := True;
    Close;
  End
  Else If fMsgLiberacaoJaLida(strMsgLib) Then
  Begin
    tmrLibera.Enabled := False;
    If Not fEmptyStr(strMsgLib) Then
      strMsgLib := #13#10 + 'Justificativa: ' + strMsgLib;

    fMensagem('', 'A sua solicitação de liberação foi Negada!' + strMsgLib, ['&Ok']);
  End;

end;

function TfrmLiberacaoCliente.fVerificaLiberacao(strNumLib: String) : Boolean;
  Var
    strSQL   : String;
    qryLogVar: TUniQuery;
begin
  Result := False;
  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   LOG_OPELIB               ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   LOGVAR                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   LOG_NROLIB = :NROLIB AND ';
  strSQL := strSQL + '   LOG_OPELIB IS NOT NULL   ';
  qryLogVar := fCriaQuery;
  Try
    qryLogVar.Close;
    qryLogVar.SQL.Text := strSQL;
    qryLogVar.ParamByName('NROLIB').AsString := strNumLib;
    qryLogVar.Open;
    If Not qryLogVar.IsEmpty Then
    Begin
      Result := True;
    End;
  Finally
    FreeAndNil(qryLogVar);
  End;
end;

function TfrmLiberacaoCliente.fGeraNumLiberacao: String;
  Var
    qryGenVar: TUniQuery;
Begin
  qryGenVar := fCriaQuery;

  Try

    Repeat
      Result := fStrZero(IntToStr(SecondOfTheDay(VS_Date + fTime())),5);

      Result := Result + IntToStr(StrToInt(RightStr(Result,2)) * fRetTagDir);

      qryGenVar.Close;
      qryGenVar.SQL.Clear;

      qryGenVar.SQL.Add('SELECT                  ');
      qryGenVar.SQL.Add('  LOG_NROLIB AS NROLIB  ');
      qryGenVar.SQL.Add('FROM                    ');
      qryGenVar.SQL.Add('  LOGVAR                ');
      qryGenVar.SQL.Add('WHERE                   ');
      qryGenVar.SQL.Add('  LOG_NROLIB = :NROLIB  ');

      qryGenVar.ParamByName('NROLIB').AsString := Result;
      qryGenVar.Open;

      If SameText(qryGenVar.FieldByName('NROLIB').AsString, Result) Then
        Sleep(1000);

    Until (Not SameText(qryGenVar.FieldByName('NROLIB').AsString, Result));

  Finally

    FreeAndNil(qryGenVar);
  End;

End;


end.


