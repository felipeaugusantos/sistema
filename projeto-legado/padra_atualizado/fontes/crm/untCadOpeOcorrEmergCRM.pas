unit untCadOpeOcorrEmergCRM;

interface

uses
  Windows, Classes, Controls, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, CheckLst, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmCadOpeOcorrEmergCRM = class(TfrmPaiEdit)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cklLojas: TCheckListBox;
    cklGrupos: TCheckListBox;
    cklUsuarios: TCheckListBox;
    btnConfirmar: TBitBtnLocked;
    btnLojas: TBitBtnLocked;
    btnGrupos: TBitBtnLocked;
    btnUsuarios: TBitBtnLocked;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLojasClick(Sender: TObject);
    procedure btnGruposClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure cklLojasClickCheck(Sender: TObject);
    procedure cklGruposClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    function fSelecionou(cklLista: TCheckListBox): Boolean;
    function fGetEmpresas(cklLojas: TCheckListBox): Boolean;
    function fGetGrupos(cklGrupos: TCheckListBox): Boolean;
    function fSetaUsuarios(strCodEmp, strNomGru: String; cklUsuarios: TCheckListBox): Boolean;
    function fGetSelecao(cklLista: TCheckListBox; intTamCam: Integer = 3): String;

    procedure pMarcaTodos(cklLista: TCheckListBox; blnMarca: Boolean);
    procedure pSetaOpeResp(blnChamarMarcaTodos: Boolean);
    procedure pSetaOpeOcoEmergenciais;
  public
    { Public declarations }
    arrOpe: TStringArray;
    strOpeResp: String;
    strCodOco: String;
    strCodEmp: String;
    blnInsert: Boolean;
  end;

implementation

{$R *.dfm}

uses SysUtils, StrUtils, Forms, untFuncoesSimples;

procedure TfrmCadOpeOcorrEmergCRM.btnConfirmarClick(Sender: TObject);
  Var
    intIndex : Integer;
    intCont  : Integer;
begin
  inherited;

  intCont := 0;

  If Not fSelecionou(cklUsuarios) Then
  Begin
    fMensagem('', 'Selecione pelo menos um usuário!', ['&Ok']);
    Exit;
  End;

  With cklusuarios Do
  Begin
    SetLength(arrOpe,fQtdeChecados(cklusuarios));
    For intIndex := 0 to Count - 1 Do
      If Checked[intIndex] Then
      Begin
        arrOpe[intCont] := LeftStr(Items[intIndex],3);
        intCont := intCont + 1;
      End;
    Close;      
  End;
end;

procedure TfrmCadOpeOcorrEmergCRM.btnGruposClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos(cklGrupos,Not fSelecionou(cklGrupos));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios)
end;

procedure TfrmCadOpeOcorrEmergCRM.btnLojasClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos(cklLojas,Not fSelecionou(cklLojas));
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCadOpeOcorrEmergCRM.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadOpeOcorrEmergCRM.btnUsuariosClick(Sender: TObject);
begin
  inherited;
  pMarcaTodos(cklUsuarios,Not fSelecionou(cklUsuarios));
end;

procedure TfrmCadOpeOcorrEmergCRM.cklGruposClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

procedure TfrmCadOpeOcorrEmergCRM.cklLojasClickCheck(Sender: TObject);
begin
  inherited;
  fSetaUsuarios(fGetSelecao(cklLojas),fGetSelecao(cklGrupos,0),cklUsuarios);
end;

function TfrmCadOpeOcorrEmergCRM.fGetEmpresas(cklLojas: TCheckListBox): Boolean;
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

  Except
    On E : Exception Do
    Begin
      Result := FALSE;
			pMensagensErro(E.Message,'[TfrmCadMsgEnv.fGetEmpresas]');
    End;
  End;
end;

function TfrmCadOpeOcorrEmergCRM.fGetGrupos(cklGrupos: TCheckListBox): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  cklGrupos.Clear;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                 ';
    strSQL := strSQL + '   GPO_DESCRI AS GRUPO  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADGPO      ';

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

  Except
    On E : Exception Do
    Begin
      Result := FALSE;
			pMensagensErro(E.Message,'[TfrmCadMsgEnv.fGetGrupos]');
    End;
  End;
end;

function TfrmCadOpeOcorrEmergCRM.fGetSelecao(cklLista: TCheckListBox;
  intTamCam: Integer): String;
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
end;

procedure TfrmCadOpeOcorrEmergCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strOpeResp := '';
  strCodOco  := '';
  strCodEmp  := '';
  blnInsert  := False;
end;

procedure TfrmCadOpeOcorrEmergCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3 : btnLojas.Click;
    VK_F4 : btnGrupos.Click;
    VK_F5 : btnUsuarios.Click;
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmCadOpeOcorrEmergCRM.FormShow(Sender: TObject);
begin
  inherited;
  fGetEmpresas(cklLojas);
  fGetGrupos(cklGrupos);
  If blnInsert Then
    pSetaOpeResp(True)
  Else
    pSetaOpeOcoEmergenciais;
End;

function TfrmCadOpeOcorrEmergCRM.fSelecionou(cklLista: TCheckListBox): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := False;
  For intIndex := 0 To cklLista.Count - 1 Do
    If cklLista.Checked[intIndex] Then
    Begin
      Result := True;
      Exit;
    End;
end;

function TfrmCadOpeOcorrEmergCRM.fSetaUsuarios(strCodEmp, strNomGru: String;
  cklUsuarios: TCheckListBox): Boolean;
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

  Except
    On E : Exception Do
    Begin
      Result := FALSE;
			pMensagensErro(E.Message,'[TfrmCadMsgEnv.fSetaUsuarios]');
    End;
  End;
end;

procedure TfrmCadOpeOcorrEmergCRM.pMarcaTodos(cklLista: TCheckListBox;
  blnMarca: Boolean);
  Var
    intIndex: Integer;
Begin
  For intIndex := 0 To cklLista.Count - 1 Do
    cklLista.Checked[intIndex] := blnMarca;
end;

procedure TfrmCadOpeOcorrEmergCRM.pSetaOpeOcoEmergenciais;
var
  qryOpeEme: TUniQuery;
begin
  Try
    Try
      qryOpeEme := fCriaQuery(Self);
      qryOpeEme.Close;
      qryOpeEme.SQL.Add(' SELECT CONCAT(EME_CODOPE," - ",OPE_NOMOPE) AS OPERADOR, ');
      qryOpeEme.SQL.Add('        EME_CODOPE                                       ');
      qryOpeEme.SQL.Add('   FROM OCOEME                                           ');
      qryOpeEme.SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = EME_CODOPE           ');
      qryOpeEme.SQL.Add('  WHERE EME_CODOCO = :CODOCO                             ');
      qryOpeEme.SQL.Add('    AND EME_CODEMP = :CODEMP                             ');
      qryOpeEme.SQL.Add('  ORDER BY OPE_NOMOPE                                    ');
      qryOpeEme.ParamByName('CODOCO').AsString := strCodOco;
      qryOpeEme.ParamByName('CODEMP').AsString := strCodEmp;
      qryOpeEme.Open;
      
      qryOpeEme.First;
      while not qryOpeEme.Eof do
      begin
        strOpeResp := qryOpeEme.FieldByName('EME_CODOPE').AsString;
        pSetaOpeResp(False);
        qryOpeEme.Next;
      end;

    Except
      On E: Exception Do
      Begin
   			pMensagensErro(E.Message,'[TfrmCadMsgEnv.pSetaOpeOcoEmergenciais]');
      End;
    End;
  Finally
    FreeAndNil(qryOpeEme);
  End;                            
end;

procedure TfrmCadOpeOcorrEmergCRM.pSetaOpeResp(blnChamarMarcaTodos: Boolean);
  Var
    qryAux: TUniQuery;
    strEmpOpeResp: String;
    intContador: Integer;
begin

  If fEmptyStr(strOpeResp) Then
    Exit;

  If blnChamarMarcaTodos Then
  Begin
    pMarcaTodos(cklLojas, False);
    pMarcaTodos(cklGrupos, False);
    pMarcaTodos(cklUsuarios, False);
  End;

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
{
  cklLojas.Enabled    := False;
  cklGrupos.Enabled   := False;
  cklUsuarios.Enabled := False;

  btnLojas.Enabled    := False;
  btnGrupos.Enabled   := False;
  btnUsuarios.Enabled := False;
}  
end;

end.
