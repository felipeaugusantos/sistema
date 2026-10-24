unit untCadMsgEnv;

interface

uses
  Windows, Classes, Controls, untPaiEdit, Menus, StdCtrls, Buttons, ExtCtrls,
  CheckLst, Uni, MemoFocus, EditFocus, AppEvnts, frxClass, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, Data.DB;

type
  TfrmCadMsgEnv = class(TfrmPaiEdit)
    Panel1: TPanel;
    Label1: TLabel;
    cklLojas: TCheckListBox;
    Label2: TLabel;
    cklGrupos: TCheckListBox;
    Label3: TLabel;
    cklUsuarios: TCheckListBox;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtAssunto: TEditFocus;
    mmoMsg: TMemoFocus;
    btnGravar: TBitBtnLocked;
    btnLojas: TBitBtnLocked;
    btnGrupos: TBitBtnLocked;
    btnUsuarios: TBitBtnLocked;
    pnlRodape: TPanel;
    ckbMsgAll: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLojasClick(Sender: TObject);
    procedure btnGruposClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure cklLojasClickCheck(Sender: TObject);
    procedure cklGruposClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ckbMsgAllClick(Sender: TObject);
  private
    { Private declarations }
    stlMensagem: TStringList;
    strSelecaoLojaOri: string;
    strSelecaoGrupoOri: string;
    strSelecaoUsuarioOri: string;

    procedure pRolaPosicionaPrimeiroItem(cklLista: TCheckListBox);

    Procedure pMarcaTodos(cklLista: TCheckListBox; blnMarca: Boolean);

    Function fGetSelecao(cklLista: TCheckListBox; intTamCam: Integer = 3): String;
    Function fGetEmpresas(cklLojas: TCheckListBox): Boolean;
    Function fGetGrupos(cklGrupos: TCheckListBox): Boolean;
    Function fSetaUsuarios(strCodEmp, strNomGru: String; cklUsuarios: TCheckListBox): Boolean;
    Function fSelecionou(cklLista: TCheckListBox): Boolean;
    procedure pSelecionaUsuariosMsgOriginal(blnSeleciona: Boolean);
    procedure pRetornaOperadorMsgOri(var strLojaEnv: string; var strGrupoEnv: string; var strUsuarioEnv: string; intIdMensagem: integer);

  public
    strOpeResp: String;
    strAssuntoResp: String;
    strSeqMsg : String;
    strMsgOri : String;
    strDtaOri : String;
    strHorOri : String;

    blnUnicaMsg  : Boolean;
    strAutIncMsg : String;
    blnVaiResponderTodos: Boolean;
    intIdMensagem: integer;

    procedure pSetaOpeResp;
    procedure pConcatenaMensagemOriginal;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

//var
//  frmCadMsgEnv: TfrmCadMsgEnv;

implementation

uses                            
  SysUtils, StrUtils, Forms, untPai, untMsgInterna, untFuncoesSimples,
  untAtualizaOcorrenciasCRM, untFuncoesCRM, untTypesCRM, untImpMsgEnv;

{$R *.dfm}

Function TfrmCadMsgEnv.fGetSelecao(cklLista: TCheckListBox; intTamCam: Integer = 3): String;
  Var
    intIndex: Integer;
Begin
  Result := '';
  With cklLista Do
  For intIndex := 0 To Count - 1 Do
    If Checked[intIndex] Then
      If intTamCam > 0 Then
        Result := Result + ',' + QuotedStr(LeftStr(Items[intIndex],intTamCam))
      Else
        Result := Result + ',' + QuotedStr(Items[intIndex]);

  If Length(Result) > 0 Then
    Delete(Result,1,1);
End;

Function TfrmCadMsgEnv.fGetEmpresas(cklLojas: TCheckListBox): Boolean;
  Var
    strSQL  : String;
    qryGen  : TUniQuery;
    intIndex: Integer;
Begin
  cklLojas.Clear;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                                            ';
    strSQL := strSQL + '   CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA ';
    strSQL := strSQL + ' FROM       ';
    strSQL := strSQL + '   CADEMP   ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := strSQL;
      Open;

      intIndex := 0;
      First;
      While Not Eof Do
      Begin
        cklLojas.Items.Add(FieldByName('EMPRESA').AsString);
        cklLojas.Checked[intIndex] := True;
        inc(intIndex);
        Next;
      End;

      fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

      Close;
    End;
    Result := TRUE;
    FreeAndNil(qryGen);

    pRolaPosicionaPrimeiroItem(cklLojas);
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCadMsgEnv.fGetEmpresas]');
    End;
  End;
End;

Function TfrmCadMsgEnv.fGetGrupos(cklGrupos: TCheckListBox): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  cklGrupos.Clear;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT GPO_DESCRI AS GRUPO  ';
    strSQL := strSQL + ' FROM CADGPO                 ';
    strSQL := strSQL + ' ORDER BY GPO_DESCRI         ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := strSQL;
      Open;

      First;
      While Not Eof Do
      Begin
        cklGrupos.Items.Add(FieldByName('GRUPO').AsString);
        Next;
      End;

      Close;
    End;
    Result := TRUE;
    FreeAndNil(qryGen);

    pRolaPosicionaPrimeiroItem(cklGrupos);
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCadMsgEnv.fGetGrupos]');
    End;
  End;
End;

Function TfrmCadMsgEnv.fSetaUsuarios(strCodEmp, strNomGru: String; cklUsuarios: TCheckListBox): Boolean;
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
    intIndex : Integer;
Begin
  Result := TRUE;
  cklUsuarios.Clear;

  If fEmptyStr(strCodEmp) Then
    Exit;

  Try

    If fEmptyStr(strNomGru) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT                                             ';
      strSQL := strSQL + '   CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS USUARIO ';
      strSQL := strSQL + ' FROM                      ';
      strSQL := strSQL + '   CADOPE                  ';
      strSQL := strSQL + ' WHERE                     ';
      strSQL := strSQL + '   OPE_CODEMP IN (' +  strCodEmp + ') AND ';
      strSQL := strSQL + '   OPE_STATUS <> "I"           ';
      strSQL := strSQL + ' ORDER BY                  ';
      strSQL := strSQL + '   OPE_NOMOPE              ';
    End Else
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT DISTINCT                                         ';
      strSQL := strSQL + '   CONCAT(O.OPE_CODOPE, " - ", O.OPE_NOMOPE) AS USUARIO  ';
      strSQL := strSQL + ' FROM                                  ';
      strSQL := strSQL + '   OPEGPO G                            ';
      strSQL := strSQL + ' INNER JOIN CADOPE O ON                ';
      strSQL := strSQL + '   O.OPE_CODOPE = G.OPE_CODOPE AND     ';
      strSQL := strSQL + '   O.OPE_STATUS <> "I"                 ';
      strSQL := strSQL + ' INNER JOIN CADGPO C ON                ';
      strSQL := strSQL + '   C.GPO_CODGPO = G.GPO_CODGPO AND     ';
      strSQL := strSQL + '   C.GPO_DESCRI IN (' + strNomGru + ') ';
      strSQL := strSQL + ' WHERE                                 ';
      strSQL := strSQL + '   O.OPE_CODEMP IN (' + strCodEmp + ') ';
      strSQL := strSQL + ' ORDER BY                              ';
      strSQL := strSQL + '   O.OPE_CODOPE                        ';
    End;


    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := strSQL;

      Open;

      First;

      intIndex := 0;

      While Not Eof Do
      Begin
        cklUsuarios.Items.Add(FieldByName('USUARIO').AsString);
        cklUsuarios.Checked[intIndex] := False;
        inc(intIndex);
        Next;
      End;


      Close;
    End;
    FreeAndNil(qryGen);

    pRolaPosicionaPrimeiroItem(cklUsuarios);
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCadMsgEnv.fSetaUsuarios]');
    End;
  End;
End;

procedure TfrmCadMsgEnv.pMarcaTodos(cklLista: TCheckListBox; blnMarca: Boolean);
  Var
    intIndex: Integer;
Begin
  For intIndex := 0 To cklLista.Count - 1 Do
    cklLista.Checked[intIndex] := blnMarca;
End;

procedure TfrmCadMsgEnv.pRetornaOperadorMsgOri(var strLojaEnv, strGrupoEnv,
  strUsuarioEnv: string; intIdMensagem: integer);
var
  qryMsgEnv: TUniQuery;
  strOpeEnv: string;
begin
  qryMsgEnv := fCriaQuery;

  try
    strOpeEnv := EmptyStr;
    strLojaEnv := EmptyStr;
    strGrupoEnv := EmptyStr;
    strUsuarioEnv := EmptyStr;

    qryMsgEnv.Close;
    qryMsgEnv.SQL.Clear;
    qryMsgEnv.SQL.Add('SELECT MSG_OPEREC, MSG_OPEENV');
    qryMsgEnv.SQL.Add('FROM CADMSG');
    qryMsgEnv.SQL.Add('WHERE MSG_IDMSG_ = :IDMSG');

    qryMsgEnv.ParamByName('IDMSG').AsInteger := intIdMensagem;

    qryMsgEnv.Open;

    if qryMsgEnv.IsEmpty then
      Exit;

    If Not fEmptyStr(qryMsgEnv.FieldByName('MSG_OPEENV').AsString) Then
    Begin
      If (strLoginUsuarioLogado <> qryMsgEnv.FieldByName('MSG_OPEENV').AsString) Then
      Begin
        If fEmptyStr(strOpeEnv) Then
          strOpeEnv := QuotedStr(qryMsgEnv.FieldByName('MSG_OPEENV').AsString)
        Else
          strOpeEnv := strOpeEnv + ',' + QuotedStr(qryMsgEnv.FieldByName('MSG_OPEENV').AsString);
      End;
    End;

    while not qryMsgEnv.Eof do
    begin
      If Not fEmptyStr(qryMsgEnv.FieldByName('MSG_OPEREC').AsString) Then
      Begin
        If (strLoginUsuarioLogado) <> (qryMsgEnv.FieldByName('MSG_OPEREC').AsString) Then
        Begin
          If fEmptyStr(strOpeEnv) Then
            strOpeEnv := QuotedStr(qryMsgEnv.FieldByName('MSG_OPEREC').AsString)
          Else
            strOpeEnv := strOpeEnv + ',' + QuotedStr(qryMsgEnv.FieldByName('MSG_OPEREC').AsString);
        End;
      End;

      qryMsgEnv.Next;
    end;

    if fEmptyStr(strOpeEnv) then
      Exit;

    qryMsgEnv.Close;
    qryMsgEnv.SQL.Clear;
    qryMsgEnv.SQL.Add('SELECT OP.OPE_CODOPE, OP.OPE_CODEMP, GR.GPO_DESCRI');
    qryMsgEnv.SQL.Add('FROM CADOPE OP');
    qryMsgEnv.SQL.Add('LEFT JOIN OPEGPO OG');
    qryMsgEnv.SQL.Add('ON(OP.OPE_CODOPE = OG.OPE_CODOPE)');
    qryMsgEnv.SQL.Add('LEFT JOIN CADGPO GR');
    qryMsgEnv.SQL.Add('ON(OG.GPO_CODGPO = GR.GPO_CODGPO)');
    qryMsgEnv.SQL.Add('WHERE OP.OPE_CODOPE IN('+strOpeEnv+')');
    qryMsgEnv.Open;

    if qryMsgEnv.IsEmpty then
      Exit;

    while not qryMsgEnv.Eof do
    begin
      if (not fEmptyStr(qryMsgEnv.FieldByName('OPE_CODEMP').AsString)) and (not strLojaEnv.Contains(qryMsgEnv.FieldByName('OPE_CODEMP').AsString)) Then
        strLojaEnv := strLojaEnv + ',' + qryMsgEnv.FieldByName('OPE_CODEMP').AsString;

      if (not fEmptyStr(qryMsgEnv.FieldByName('GPO_DESCRI').AsString)) and (not strGrupoEnv.Contains(qryMsgEnv.FieldByName('GPO_DESCRI').AsString)) Then
        strGrupoEnv := strGrupoEnv + ',' + qryMsgEnv.FieldByName('GPO_DESCRI').AsString;

      if (not fEmptyStr(qryMsgEnv.FieldByName('OPE_CODOPE').AsString)) and (not strUsuarioEnv.Contains(qryMsgEnv.FieldByName('OPE_CODOPE').AsString)) Then
        strUsuarioEnv := strUsuarioEnv + ',' + qryMsgEnv.FieldByName('OPE_CODOPE').AsString;

      qryMsgEnv.Next;
    end;

    if not fEmptyStr(strLojaEnv) then
      Delete(strLojaEnv,1,1);

    if not fEmptyStr(strGrupoEnv) then
      Delete(strGrupoEnv,1,1);

    if not fEmptyStr(strUsuarioEnv) then
      Delete(strUsuarioEnv,1,1);

  finally
    FreeAndNil(qryMsgEnv);
  end;
end;

procedure TfrmCadMsgEnv.pRolaPosicionaPrimeiroItem(cklLista: TCheckListBox);
begin
  If (cklLista.Enabled) And (cklLista.Items.Count > 0) Then
  Begin
    cklLista.ItemIndex := cklLista.Items.Count-1;
    cklLista.ItemIndex :=  0;
    cklLista.ItemIndex := -1;
  End;
end;

procedure TfrmCadMsgEnv.pConcatenaMensagemOriginal;
begin
  If fEmptyStr(strMsgOri) Then
    Exit;

  stlMensagem.Add('');
  stlMensagem.Add('---------------------------------------------------------');
  stlMensagem.Add(Concat('Por: ', strOpeResp, ' - ', fRetNomeOperador(strOpeResp)));
  stlMensagem.Add(Concat('Em: ', strDtaOri, ' ', strHorOri));
  stlMensagem.Add(strMsgOri);
end;

Function TfrmCadMsgEnv.fSelecionou(cklLista: TCheckListBox): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FALSE;
  For intIndex := 0 To cklLista.Count - 1 Do
    If cklLista.Checked[intIndex] Then
    Begin
      Result := TRUE;
      Exit;
    End;
End;

procedure TfrmCadMsgEnv.btnGravarClick(Sender: TObject);
  Var
    msgInterna: TMsgInterna;
    intIndex  : Integer;
    blnImprime: Boolean;
    qryMsgOco : TUniQuery;
    objOcoCrm : TAtuOcoCrm;
    strOpeDes : String;
    strCodOcoS: String;
    strCodEmpS: String;
    strCodTocS: String;
    strCodCliS: String;
    strMessage: String;
    intIdMensagem: integer;
    frmImpMsgEnv: TfrmImpMsgEnv;
begin
  inherited;

  If Not fSelecionou(cklUsuarios) Then
  Begin
    fMensagem('', 'Selecione pelo menos um usuário!', ['&Ok']);
    Exit;
  End;

  If fVerificaCampos Then
  Begin

    If fVerificaAcessoSistema('PIMPME') Then
      blnImprime := (fMensagem('','Deseja Imprimir Mensagem(s) Enviada(s) ?',['&SIM', '&NÃO'], 2) = 1)
    Else
      blnImprime := False;

    msgInterna := TMsgInterna.Create(self);
    strOpeDes  := '';

    stlMensagem.Clear();
    stlMensagem.Add(mmoMsg.Texto);
    pConcatenaMensagemOriginal();
    strMessage := StringReplace(stlMensagem.Text, #$D#$A, STRING_QUEBRA, [rfReplaceAll]);

    With msgInterna, cklusuarios Do
    Begin

      fStartTransaction;

      Try
        intIdMensagem := fCampoTabela('MSG_IDMSG_', 'CADMSG', [], [], False, '', Nil, True) + 1;
        For intIndex := 0 to Count - 1 Do
        Begin

          If Checked[intIndex] Then
          Begin

            If Not fEnviaMensagemAutInc(edtAssunto.Text, strMessage, strLoginUsuarioLogado, LeftStr(Items[intIndex],3), 'N', '', strAutIncMsg, '', intIdMensagem) Then
            Begin
              FreeAndNil(msgInterna);
              exit;
            End;

            strOpeDes := strOpeDes + LeftStr(Items[intIndex],3) + ', ';

          End;

        End;

        strOpeDes := Copy(strOpeDes, 1, Length(strOpeDes)-2);

        If VS_strHabilitarCRM And (not fEmptyStr(strSeqMsg)) Then
        Begin
          Try
            qryMsgOco := fCriaQuery;
            With qryMsgOco, SQL Do
            Begin
              Close;
              Clear;
              Add(' SELECT *                                     ');
              Add(' FROM MSGOCO                                  ');
              Add(' INNER JOIN MOVOCO ON MSO_CODOCO = OCO_CODOCO ');
              Add('                  AND MSO_CODEMP = OCO_CODEMP ');
              Add('                  AND MSO_CODTOC = OCO_CODTOC ');
              Add('                  AND MSO_CODCLI = OCO_CODCLI ');
              Add(' WHERE MSO_SEQMSG = :SEQMSG                   ');

              ParamByName('SEQMSG').AsString := strSeqMsg;
              Open;

              If Not IsEmpty Then
              Begin
                objOcoCrm := fAtualizaInformacoesCRM('',
                                                     '',
                                                     VS_strCodEmp,
                                                     FieldByName('MSO_CODCLI').AsString,
                                                     '',
                                                     '',
                                                     strLoginUsuarioLogado,
                                                     afcNenhum);

                objOcoCrm.strCodToc := FieldByName('OCO_CODTOC').AsString;
                objOcoCrm.strCodOco := FieldByName('OCO_CODOCO').AsString;
                objOcoCrm.strDtaInc := VS_Date;
                objOcoCrm.strHorInc := fRetHoraServidor();
                objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
                objOcoCrm.strHorAge := objOcoCrm.strHorInc;
                objOcoCrm.strOpeHis := strLoginUsuarioLogado;
                objOcoCrm.strCodOpe := strOpeDes;
                objOcoCrm.strDtaCon := FieldByName('OCO_DTACON').AsDateTime;
                objOcoCrm.strHorCon := FieldByName('OCO_HORCON').AsDateTime;;
                objOcoCrm.strDescri := 'Mensagem Respondida<<csq>>' +
                                       mmoMsg.Texto + '<<csq>>' +
                                       'Destinatário(s): ' + strOpeDes +
                                       '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                        DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

                objOcoCrm.strNomFrm := Self.Name;
                objOcoCrm.pInsereHistoricoOcorrencia;
                objOcoCrm.pAtualizaOcorrencia;

                strCodOcoS := FieldByName('OCO_CODOCO').AsString;
                strCodEmpS := FieldByName('OCO_CODEMP').AsString;
                strCodTocS := FieldByName('OCO_CODTOC').AsString;
                strCodCliS := FieldByName('OCO_CODCLI').AsString;

                Close;
                Clear;
                Add(' INSERT INTO MSGOCO ( MSO_SEQMSG,            ');
                Add('                      MSO_CODOCO,            ');
                Add('                      MSO_CODEMP,            ');
                Add('                      MSO_CODTOC,            ');
                Add('                      MSO_CODCLI)            ');
                Add(' SELECT AUTOINCREM,                          ');
                Add('        :CODOCO,                             ');
                Add('        :CODEMP,                             ');
                Add('        :CODTOC,                             ');
                Add('        :CODCLI                              ');
                Add(' FROM CADMSG                                 ');
                Add(' WHERE AUTOINCREM IN ( ' + strAutIncMsg + ') ');

                ParamByName('CODOCO').AsString := strCodOcoS;
                ParamByName('CODEMP').AsString := strCodEmpS;
                ParamByName('CODTOC').AsString := strCodTocS;
                ParamByName('CODCLI').AsString := strCodCliS;

                ExecSQL;

                blnUnicaMsg := True;

              End;
            End;

          Finally
            FreeAndNil(qryMsgOco);
            If Assigned(objOcoCrm) Then
              FreeAndNil(objOcoCrm);
          End;

        End;

        fCommit;

        {Impressão deve ser após o "Commit"}
        If blnImprime Then
        Begin

          For intIndex := 0 to Count - 1 Do
          Begin

            If Checked[intIndex] Then
            Begin
              pCriarFormularios(TfrmImpMsgEnv, frmImpMsgEnv);
              try
                frmImpMsgEnv.pImprimeMsg(msgInterna.strCodMsg,
                                         strLoginUsuarioLogado,
                                         LeftStr(Items[intIndex],3),
                                         FormatDateTime('dd/mm/yyyy', VS_Date),
                                         FormatDateTime('hh:mm:ss', fTime()),
                                         edtAssunto.Text,
                                         mmoMsg.Lines.Text,
                                         Self.Name);

              finally
                pFreeAndNil(frmImpMsgEnv);
              end;
            End;
          End;
        End;

        mmoMsg.Clear;
        stlMensagem.Clear;
        edtAssunto.Clear;
        fMensagem('', 'Mensagem enviada com sucesso!', ['&Ok']);

        If blnUnicaMsg Then
          ModalResult := mrOk;

      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[btnGravarClick]');
        end;
      end;
    End;

    FreeAndNil(msgInterna);
  End;
end;

procedure TfrmCadMsgEnv.FormShow(Sender: TObject);
begin
  inherited;
  strSelecaoLojaOri := EmptyStr;
  strSelecaoGrupoOri := EmptyStr;
  strSelecaoUsuarioOri := EmptyStr;

  fGetEmpresas(cklLojas);
  fGetGrupos(cklGrupos);

  pSetaOpeResp();

  ckbMsgAll.Visible := (blnVaiResponderTodos) and (intIdMensagem > 0);

  pRolaPosicionaPrimeiroItem(cklLojas);
  pRolaPosicionaPrimeiroItem(cklGrupos);
  pRolaPosicionaPrimeiroItem(cklUsuarios);
end;

procedure TfrmCadMsgEnv.btnLojasClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklLojas,Not fSelecionou(cklLojas));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

end;

procedure TfrmCadMsgEnv.btnGruposClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklGrupos,Not fSelecionou(cklGrupos));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

end;

procedure TfrmCadMsgEnv.btnUsuariosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklUsuarios,Not fSelecionou(cklUsuarios));
end;

function TfrmCadMsgEnv.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtAssunto) Then
    Begin
      If fEmptyStr(edtAssunto.Text) Then
      Begin
        Result := FALSE;
        fMensagem('', 'Assunto em branco!', ['&Ok']);
      End;
    End

    Else If (Sender = mmoMsg) Then
    Begin
      If fEmptyStr(Trim(mmoMsg.Lines.Text)) Then
      Begin
        Result := FALSE;
        fMensagem('', 'Mensagem em branco!', ['&Ok']);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmCadMsgEnv.cklLojasClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCadMsgEnv.ckbMsgAllClick(Sender: TObject);
begin
  inherited;
  pSelecionaUsuariosMsgOriginal(ckbMsgAll.Checked);
end;

procedure TfrmCadMsgEnv.cklGruposClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCadMsgEnv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3 : btnLojas.Click;
    VK_F4 : btnGrupos.Click;
    VK_F5 : btnUsuarios.Click;
    VK_F10: btnGravar.Click;
  End;
end;

procedure TfrmCadMsgEnv.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cklLojas);
end;

procedure TfrmCadMsgEnv.FormCreate(Sender: TObject);
begin
  inherited;
  strOpeResp  := '';
  strAutIncMsg:= '';
  strMsgOri   := '';
  strDtaOri   := '';
  strHorOri   := '';
  stlMensagem := TStringList.Create;
  blnVaiResponderTodos := False;
  intIdMensagem := 0;
end;

procedure TfrmCadMsgEnv.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlMensagem);
  inherited;
end;

procedure TfrmCadMsgEnv.pSelecionaUsuariosMsgOriginal(blnSeleciona: Boolean);
var
  intContador: integer;
  strLojaEnv: string;
  strGrupoEnv: string;
  strUsuarioEnv: string;
begin
  cklLojas.Enabled    := blnSeleciona;
  cklGrupos.Enabled   := blnSeleciona;
  cklUsuarios.Enabled := blnSeleciona;

  pMarcaTodos(cklLojas, False);
  pMarcaTodos(cklGrupos, False);
  pMarcaTodos(cklUsuarios, False);

  pRetornaOperadorMsgOri(strLojaEnv, strGrupoEnv, strUsuarioEnv, intIdMensagem);

  if blnSeleciona then // Marca somente os operadores envolvidos na mensagem original
  begin
    for intContador := 0 to cklLojas.Count - 1 do
    begin
      if (strLojaEnv.Contains(LeftStr(cklLojas.Items[intContador],3))) then
        cklLojas.Checked[intContador] := True;

      cklLojas.ItemEnabled[intContador] := False;
    end;

    for intContador := 0 to cklGrupos.Count - 1 do
    begin
      if (strGrupoEnv.Contains(cklGrupos.Items[intContador])) then
        cklGrupos.Checked[intContador] := True;

      cklGrupos.ItemEnabled[intContador] := False;
    end;

    for intContador := 0 to cklUsuarios.Count - 1 do
    begin
      if (strUsuarioEnv.Contains(LeftStr(cklUsuarios.Items[intContador],3))) then
        cklUsuarios.Checked[intContador] := True;

      cklUsuarios.ItemEnabled[intContador] := False;
    end;
  end
  else
  begin  // Marca os que já estavam marcados originalmente sem utilizar esta funcionalidade
    for intContador := 0 to cklLojas.Count - 1 do
    begin
      if (strSelecaoLojaOri.Contains(LeftStr(cklLojas.Items[intContador],3))) then
        cklLojas.Checked[intContador] := True;

      cklLojas.ItemEnabled[intContador] := True;
    end;

    for intContador := 0 to cklGrupos.Count - 1 do
    begin
      if (strSelecaoGrupoOri.Contains(cklGrupos.Items[intContador])) then
        cklGrupos.Checked[intContador] := True;

      cklGrupos.ItemEnabled[intContador] := True;
    end;

    for intContador := 0 to cklUsuarios.Count - 1 do
    begin
      if (strSelecaoUsuarioOri.Contains(LeftStr(cklUsuarios.Items[intContador],3))) then
        cklUsuarios.Checked[intContador] := True;

      cklUsuarios.ItemEnabled[intContador] := True;
    end;
  end;

  pRolaPosicionaPrimeiroItem(cklLojas);
  pRolaPosicionaPrimeiroItem(cklGrupos);
  pRolaPosicionaPrimeiroItem(cklUsuarios);
end;

procedure TfrmCadMsgEnv.pSetaOpeResp;
  Var
    qryAux: TUniQuery;
    strEmpOpeResp: String;
    intContador: Integer;
begin

  If fEmptyStr(strOpeResp) Then
    Exit;

  pMarcaTodos(cklLojas, False);
  pMarcaTodos(cklGrupos, False);
  pMarcaTodos(cklUsuarios, False);

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  OPE_CODEMP ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADOPE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  OPE_CODOPE = :CODOPE ');

  qryAux.ParamByName('CODOPE').AsString := strOpeResp;
  qryAux.Open;

  strEmpOpeResp := qryAux.FieldByName('OPE_CODEMP').AsString;

  FreeAndNil(qryAux);

  For intContador := 0 To cklLojas.Count -1 Do
  Begin
    If LeftStr(cklLojas.Items[intContador], 3) = strEmpOpeResp Then
    Begin
      cklLojas.Checked[intContador] := True;
      Break;
    End;
  End;

  For intContador := 0 To cklUsuarios.Count -1 Do
  Begin
    If LeftStr(cklUsuarios.Items[intContador], 3) = strOpeResp Then
    Begin
      cklUsuarios.ItemIndex := intContador;
      cklUsuarios.Checked[intContador] := True;
      Break;
    End;
  End;

  if blnVaiResponderTodos then
  begin
    strSelecaoLojaOri := fGetSelecao(cklLojas);
    strSelecaoGrupoOri := fGetSelecao(cklGrupos, 0);
    strSelecaoUsuarioOri := fGetSelecao(cklUsuarios);
  end;

  edtAssunto.Text := 'RE: ' + strAssuntoResp;
  pSetFocus(mmoMsg);

  cklLojas.Enabled    := False;
  cklGrupos.Enabled   := False;
  cklUsuarios.Enabled := False;

  btnLojas.Enabled    := False;
  btnGrupos.Enabled   := False;
  btnUsuarios.Enabled := False;

end;

end.

