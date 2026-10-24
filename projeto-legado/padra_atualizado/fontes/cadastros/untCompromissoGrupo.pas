unit untCompromissoGrupo;

interface

uses
  Windows, Classes, Controls, untPaiEdit, Menus, StdCtrls, Buttons, ExtCtrls,
  CheckLst, Uni, MemoFocus, EditFocus, AppEvnts, frxClass, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, Data.DB, Vcl.Samples.Spin, Vcl.Mask, MaskEditFocus,
  Datasnap.DBClient, UniClientDataSet, SysUtils, untTypesSistema;


type
  TfrmCompromissoGrupo = class(TfrmPaiEdit)
    Panel1: TPanel;
    Label1: TLabel;
    cklLojas: TCheckListBox;
    Label2: TLabel;
    cklGrupos: TCheckListBox;
    Label3: TLabel;
    cklUsuarios: TCheckListBox;
    btnGravar: TBitBtnLocked;
    btnLojas: TBitBtnLocked;
    btnGrupos: TBitBtnLocked;
    btnUsuarios: TBitBtnLocked;
    Panel2: TPanel;
    FlowPanel1: TFlowPanel;
    BitBtnLocked1: TBitBtnLocked;
    pnlTitulo: TPanel;
    pnl1: TPanel;
    pnlInf: TPanel;
    lblDescricao: TLabel;
    grpReplica: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    chkReplic: TCheckBox;
    edtDtaIni: TMaskEditFocus;
    edtDtaFin: TMaskEditFocus;
    chkDesSab: TCheckBox;
    chkDesDom: TCheckBox;
    edtPeriod: TSpinEdit;
    mmoDesCom: TMemoFocus;
    pnlSales: TPanel;
    lblCliente: TLabel;
    lblObserv: TLabel;
    edtNomCli: TEditFocus;
    mmoObserv: TMemoFocus;
    rdgCatego: TRadioGroup;
    edtCodCli: TEditFocus;
    pnlSup: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblPreVis: TLabel;
    edtDtaCom: TMaskEditFocus;
    edtHorCom: TMaskEditFocus;
    edtTitCom: TEditFocus;
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
    procedure chkReplicClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strSelecaoLojaOri: string;
    strSelecaoGrupoOri: string;
    strSelecaoUsuarioOri: string;

    procedure pRolaPosicionaPrimeiroItem(cklLista: TCheckListBox);

    Procedure pMarcaTodos(cklLista: TCheckListBox; blnMarca: Boolean);
    procedure pAjustarLayoutSales;

    Function fGetSelecao(cklLista: TCheckListBox; intTamCam: Integer = 3): String;
    Function fGetEmpresas(cklLojas: TCheckListBox): Boolean;
    Function fGetGrupos(cklGrupos: TCheckListBox): Boolean;
    Function fSetaUsuarios(strCodEmp, strNomGru: String; cklUsuarios: TCheckListBox): Boolean;
    Function fSelecionou(cklLista: TCheckListBox): Boolean;

  public

    strOpeResp: String;
    strAssuntoResp: String;
    strDtaOri : String;
    strHorOri : String;

    arrUsuarios : array of string;

    procedure pSetaOpeResp;
    function fRetCategoria: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;


implementation

uses                            
  untFuncoesSimples, StrUtils, untConsultas;

{$R *.dfm}

Function TfrmCompromissoGrupo.fGetSelecao(cklLista: TCheckListBox; intTamCam: Integer = 3): String;
  Var
    intIndex: Integer;
Begin
  Result := '';
  For intIndex := 0 To cklLista.Count - 1 Do
    If cklLista.Checked[intIndex] Then
      If intTamCam > 0 Then
        Result := Result + ',' + QuotedStr(LeftStr(cklLista.Items[intIndex],intTamCam))
      Else
        Result := Result + ',' + QuotedStr(cklLista.Items[intIndex]);

  If Length(Result) > 0 Then
    Delete(Result,1,1);
End;

Function TfrmCompromissoGrupo.fGetEmpresas(cklLojas: TCheckListBox): Boolean;
  Var
    strSQL  : String;
    qryGen  : TUniQuery;
    intIndex: Integer;
Begin
  cklLojas.Clear;
  qryGen := fCriaQuery;

  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT                                            ';
      strSQL := strSQL + '   CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA ';
      strSQL := strSQL + ' FROM       ';
      strSQL := strSQL + '   CADEMP   ';

      qryGen.SQL.Text := strSQL;
      qryGen.Open;

      intIndex := 0;
      qryGen.First;

      While Not qryGen.Eof do
      Begin
        cklLojas.Items.Add(qryGen.FieldByName('EMPRESA').AsString);
        cklLojas.Checked[intIndex] := True;
        inc(intIndex);
        qryGen.Next;
      End;

      fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

      qryGen.Close;
      Result := TRUE;
    Finally
      FreeAndNil(qryGen);
      pRolaPosicionaPrimeiroItem(cklLojas);
    End;
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCompromissoGrupo.fGetEmpresas]');
    End;
  End;
End;

Function TfrmCompromissoGrupo.fGetGrupos(cklGrupos: TCheckListBox): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  cklGrupos.Clear;
  qryGen := fCriaQuery;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT GPO_DESCRI AS GRUPO  ';
      strSQL := strSQL + ' FROM CADGPO                 ';
      strSQL := strSQL + ' ORDER BY GPO_DESCRI         ';

      qryGen.SQL.Text := strSQL;
      qryGen.Open;

      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        cklGrupos.Items.Add(qryGen.FieldByName('GRUPO').AsString);
        qryGen.Next;
      End;

      qryGen.Close;

      Result := TRUE;
    Finally
      FreeAndNil(qryGen);
      pRolaPosicionaPrimeiroItem(cklGrupos);
    End;
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCompromissoGrupo.fGetGrupos]');
    End;
  End;
End;

Function TfrmCompromissoGrupo.fSetaUsuarios(strCodEmp, strNomGru: String; cklUsuarios: TCheckListBox): Boolean;
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
    intIndex : Integer;
Begin
  Result := TRUE;
  cklUsuarios.Clear;

  If fEmptyStr(strCodEmp) Then
    Exit;

  qryGen := fCriaQuery;

  Try

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

      qryGen.SQL.Text := strSQL;

      qryGen.Open;

      qryGen.First;

      intIndex := 0;

      While Not qryGen.Eof Do
      Begin
        cklUsuarios.Items.Add(qryGen.FieldByName('USUARIO').AsString);
        cklUsuarios.Checked[intIndex] := False;
        inc(intIndex);
        qryGen.Next;
      End;

      qryGen.Close;
    Finally
      FreeAndNil(qryGen);
      pRolaPosicionaPrimeiroItem(cklUsuarios);
    End;
  Except
    On E : Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message,'[TfrmCompromissoGrupo.fSetaUsuarios]');
    End;
  End;
End;

procedure TfrmCompromissoGrupo.pAjustarLayoutSales;
begin
  if not fCfgSis('APPSAL', varBoolean) then
  begin
    Height := Height - pnlSales.Height;
    pnlSales.Visible := False;
  end;
end;

procedure TfrmCompromissoGrupo.pMarcaTodos(cklLista: TCheckListBox; blnMarca: Boolean);
  Var
    intIndex: Integer;
Begin
  For intIndex := 0 To cklLista.Count - 1 Do
    cklLista.Checked[intIndex] := blnMarca;
End;

procedure TfrmCompromissoGrupo.pRolaPosicionaPrimeiroItem(cklLista: TCheckListBox);
begin
  If (cklLista.Enabled) And (cklLista.Items.Count > 0) Then
  Begin
    cklLista.ItemIndex := cklLista.Items.Count-1;
    cklLista.ItemIndex :=  0;
    cklLista.ItemIndex := -1;
  End;
end;

function TfrmCompromissoGrupo.fRetCategoria: String;
begin
  Result := '';

  case rdgCatego.ItemIndex of
    0: Result := 'V';
    1: Result := 'L';
    2: Result := 'E';
    3: Result := 'W';
    4: Result := 'O';
  end;
end;

Function TfrmCompromissoGrupo.fSelecionou(cklLista: TCheckListBox): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FALSE;
  For intIndex := 0 To cklLista.Count - 1 Do
  Begin
    If cklLista.Checked[intIndex] Then
    Begin
      Result := TRUE;
      Exit;
    End;
  End;
End;

procedure TfrmCompromissoGrupo.btnGravarClick(Sender: TObject);
 var
   intContaUsuarios : integer;
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  if fCfgSis('APPSAL', varBoolean) then
  begin
    if fEmptyStr(edtCodCli.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);
      pSetFocus(edtCodCli);
      Exit;
    end;

    if rdgCatego.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'A Categoria deve ser preenchida!', ['&Ok']);
      pSetFocus(rdgCatego);
      Exit;
    end;
  end;

  For intContaUsuarios := 0 to cklUsuarios.Count - 1 Do
  Begin
    If (cklUsuarios.Checked[intContaUsuarios]) Then
    Begin
      SetLength(arrUsuarios, length(arrUsuarios) +1);
      arrUsuarios[length(arrUsuarios)-1] := LeftStr(cklUsuarios.Items[intContaUsuarios], 3);
    End;
  End;

  If (Length(arrUsuarios) = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione pelo menos um usuário antes de prosseguir!', ['&Ok']);
    Exit;
  End;
  ModalResult := mrOk;
  inherited;
end;

procedure TfrmCompromissoGrupo.FormShow(Sender: TObject);
begin
  inherited;
  strSelecaoLojaOri := EmptyStr;
  strSelecaoGrupoOri := EmptyStr;
  strSelecaoUsuarioOri := EmptyStr;

  chkReplic.Checked := False;
  chkReplicClick(chkReplic);

  fGetEmpresas(cklLojas);
  fGetGrupos(cklGrupos);

  pSetaOpeResp();

  pRolaPosicionaPrimeiroItem(cklLojas);
  pRolaPosicionaPrimeiroItem(cklGrupos);
  pRolaPosicionaPrimeiroItem(cklUsuarios);

  rdgCatego.ItemIndex := -1;
  pAjustarLayoutSales;
end;

procedure TfrmCompromissoGrupo.btnLojasClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklLojas,Not fSelecionou(cklLojas));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

end;

procedure TfrmCompromissoGrupo.btnGruposClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklGrupos,Not fSelecionou(cklGrupos));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);

end;

procedure TfrmCompromissoGrupo.btnUsuariosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(cklUsuarios,Not fSelecionou(cklUsuarios));
end;

procedure TfrmCompromissoGrupo.cklLojasClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCompromissoGrupo.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  LClientes: TConsultasArray;
begin
  try
    if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli,
      Nil, Key, LClientes) then
    begin
      if fValidaCampos(edtCodCli, True) then
        SelectNext(ActiveControl, True, True);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '');
  end;
end;

procedure TfrmCompromissoGrupo.chkReplicClick(Sender: TObject);
begin
  inherited;
  edtDtaIni.Text    := IIF(chkReplic.Checked, edtDtaCom.Text, EmptyStr);
  edtDtaFin.Enabled := False;
  edtDtaFin.Enabled := chkReplic.Checked;
  edtPeriod.Enabled := chkReplic.Checked;
  chkDesSab.Enabled := chkReplic.Checked;
  chkDesDom.Enabled := chkReplic.Checked;
end;

procedure TfrmCompromissoGrupo.cklGruposClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCompromissoGrupo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3 : btnLojas.Click;
    VK_F4 : btnGrupos.Click;
    VK_F5 : btnUsuarios.Click;
    VK_F10: btnGravar.Click;
  End;

  If (Key = VK_Return) Then
  Begin
    If ((ActiveControl) Is TSpinEdit) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCompromissoGrupo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cklLojas);
end;

procedure TfrmCompromissoGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  strOpeResp  := '';
  strDtaOri   := '';
  strHorOri   := '';
end;

procedure TfrmCompromissoGrupo.pSetaOpeResp;
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

  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  OPE_CODEMP ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADOPE ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  OPE_CODOPE = :CODOPE ');

    qryAux.ParamByName('CODOPE').AsString := strOpeResp;
    qryAux.Open;

    strEmpOpeResp := qryAux.FieldByName('OPE_CODEMP').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

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

  cklLojas.Enabled    := False;
  cklGrupos.Enabled   := False;
  cklUsuarios.Enabled := False;

  btnLojas.Enabled    := False;
  btnGrupos.Enabled   := False;
  btnUsuarios.Enabled := False;

end;

function TfrmCompromissoGrupo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      If (Sender = edtDtaCom) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(edtDtaCom.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data do Compromisso deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (StrToDate(edtDtaCom.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma data maior que a data atual (' + DateToStr(VS_Date) + ')!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtHorCom) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(edtHorCom.Text, True, False, False, True))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Hora do Compromisso deve ser preenchida!', ['&Ok']);
          Result := False;
        End
        Else If (StrToDate(edtDtaCom.Text) = VS_Date) And (StrToTime(edtHorCom.Text) < fTime()) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma hora maior que a hora atual (' + TimeToStr(fTime()) + ')!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtTitCom) Then
      Begin
        If fEmptyStr(edtTitCom.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Título do Compromisso deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtPeriod) Then
      Begin
        If edtPeriod.Value <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A periodicidade da replicação deve ser maior que zero!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = edtDtaFin) Then
      Begin
        If chkReplic.Checked Then
        Begin
          If (fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text))) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final da replicação deve ser preenchida!', ['&Ok']);
            Result := False;
          End
          Else If StrToDate(edtDtaFin.Text) < StrToDate(edtDtaIni.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A data final da replicação não pode ser menor que a data inicial!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtCodCli) Then
      Begin
        If fCfgSis('APPSAL', varBoolean) Then
        Begin
          If Not fEmptyStr(edtCodCli.Text) Then
          Begin
            edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
            If fEmptyStr(edtNomCli.Text) Then
            Begin
              pMensagemOk('Nenhum cliente encontrado com este código!');
              Result := False;
            End;
          End
          else
          Begin
            fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Not (Result) Then
    pSetFocus(Sender);
end;

end.

