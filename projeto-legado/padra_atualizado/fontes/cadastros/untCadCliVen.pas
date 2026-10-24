unit untCadCliVen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, DBClient, Provider, BitBtnLockedIncrem, DBCtrls,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, DBEditFocus, UniClientDataSet,
  UniDataSetProvider, MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, Vcl.Buttons,
  frxExportCSVTestabilidade, MaskEditFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  untLiberacao;

type
  TfrmCadCliVen = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlDados: TPanel;
    btnGravar: TBitBtnLocked;
    Label4: TLabel;
    edtNomSup: TEditFocus;
    Label2: TLabel;
    edtNomVen: TEditFocus;
    Label3: TLabel;
    edtNomPro: TEditFocus;
    edtCodPro: TEditFocus;
    edtCodVen: TEditFocus;
    edtCodSup: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    intMaxInc: Integer;
    strCodVenAnt : String;
    objLiberacao : TLiberacao;

    procedure pCarregaItens;
    procedure pLimpaTela;
    procedure pLimpaDados;
    procedure pSequencial;
    procedure pGravaDadosCliente;

    function fTravaVendedor(Sender: TObject): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pEscapePressed; Override;
  public
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncFat;

{$R *.dfm}

function TfrmCadCliVen.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('', 'Digite o Código do Cliente!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomCli.Text :=  fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('', 'Código de Cliente Inválido!', ['&Ok']);
          Result := False;
        End;
      End;

      If blnBuscaPorChave And Result Then
        pCarregaItens;
    End

    Else
    If (Sender = edtCodSup) Then
    Begin
      If Not fEmptyStr(edtCodSup.Text) Then
      Begin
        edtNomSup.Text := fRetNomeOperador(edtCodSup.Text);
        If fEmptyStr(edtNomSup.Text) Then
        Begin
          fMensagem('', 'Código do Supervisor Inválido!', ['&Ok']);
          Result := False;
        End;

      End
      Else
        edtNomSup.Clear;
    End

    Else
    If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('', 'Digite o Código do Vendedor!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('','Código do Vendedor Inválido!', ['&Ok']);
          Result := False;
        End;

      End;

      If blnBuscaPorChave And Result Then
      Begin
        If (cdsConsulta.Active) And
           (cdsConsulta.RecordCount > 0) And
           (btnAdicionar.Tag = 0) And
           (cdsConsulta.Locate('CODVEN', edtCodVen.Text, [])) Then
        Begin
          fMensagem('', 'Esse vendedor já foi incluido!', ['&OK']);
          Result := False;
        End;

        Result := Result And fTravaVendedor(Sender);
      End;
    End

    Else
    If (Sender = edtCodPro) Then
    Begin
      If not fEmptyStr(edtCodPro.Text) Then
      Begin
        edtNomPro.Text := fRetNomeOperador(edtCodPro.Text);
        If fEmptyStr(edtNomPro.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Código do Repositor Inválido!', ['&Ok']);
        End;
      End
      Else
        edtNomPro.Clear;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadCliVen.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT                     ';
  Result := Result + '   CVN_CODSUP AS CODSUP,    ';
  Result := Result + '   CVN_CODVEN AS CODVEN,    ';
  Result := Result + '   CVN_CODPRO AS CODPRO,    ';
  Result := Result + '   CVN_IDENTI AS IDENTI,    ';
  Result := Result + '   CVN_IDENTI AS AUTINC,    ';
  Result := Result + '   (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = CVN_CODSUP) AS NOMSUP,  ';
  Result := Result + '   (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = CVN_CODVEN) AS NOMVEN,  ';
  Result := Result + '   (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = CVN_CODPRO) AS NOMPRO   ';
  Result := Result + ' FROM        ';
  Result := Result + '   VENCLI    ';
  Result := Result + ' WHERE       ';
  Result := Result + '   CVN_CODCLI = ' + QuotedStr(edtCodCli.Text) + ' ';
end;

procedure TfrmCadCliVen.pCarregaItens;
begin
  pnlHeader.Enabled := False;
  pnlDados.Enabled  := True;
  btnGravar.Enabled := True;
  fAbreConsulta(False);
  pLimpaDados;
  pSetFocus(edtCodSup);

  With cdsConsulta Do
  Begin
    Last;
    intMaxInc := FieldByName('AUTINC').AsInteger;
    First;
  End;

end;


procedure TfrmCadCliVen.pLimpaDados;
  Var
    intCont: Integer;
begin
  For intCont := 0 To pnlDados.ControlCount -1 Do
    If pnlDados.Controls[intCont] Is TEditFocus Then
      TEditFocus(pnlDados.Controls[intCont]).Clear;

  btnAdicionar.Tag := 0;
  strCodVenAnt := '';

  cdsConsulta.Cancel;
end;

procedure TfrmCadCliVen.pLimpaTela;
begin
  cdsConsulta.Close;
  edtCodCli.Clear;
  edtNomCli.Clear;
  pnlHeader.Enabled  := True;
  pnlDados.Enabled := False;
  btnGravar.Enabled  := False;
  pLimpaDados;
  pSetFocus(edtCodCli);
end;

procedure TfrmCadCliVen.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmCadCliVen.btnAdicionarClick(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  If fValidaPanel(pnlDados, False) Then
  Begin

    With cdsConsulta Do
    Begin
      If (cdsConsulta.Locate('CODVEN', edtCodVen.Text, [])) Or
         (btnAdicionar.Tag = 1) Then
        Edit
      Else
      Begin
        Append;
        Inc(intMaxInc);
        FieldByName('AUTINC').AsInteger := intMaxInc;
        FieldByName('IDENTI').AsInteger := 999;        
      End;

      For intCont := 0 To pnlDados.ControlCount -1 Do
      Begin
        If (pnlDados.Controls[intCont] Is TEditFocus) And
           (FindField(TEditFocus(pnlDados.Controls[intCont]).Hint) <> Nil) Then
        Begin
          FieldByName(TEditFocus(pnlDados.Controls[intCont]).Hint).AsString := TEditFocus(pnlDados.Controls[intCont]).Text;
        End;
      End;

      Post;
      pSequencial;
      pRefresh;
      pLimpaDados;
      pSetFocus(edtCodSup);

    End;

  End;

end;

procedure TfrmCadCliVen.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemSelecao       := False;
  blnSempreRelerBanco := False;
  cdsConsulta.Tag     := 1;
  objLiberacao := TLiberacao.Create;

end;

procedure TfrmCadCliVen.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmCadCliVen.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE: If (Not cdsConsulta.IsEmpty) And
                  (fMensagem('','Deseja excluir o item?', ['&SIM','&NÃO']) = 1) Then
               Begin
                 If cdsConsulta.FieldByName('IDENTI').AsInteger = 1 Then
                 Begin
                   fMensagem('','Não é permitido excluir o registro com identificação "1", '+
                                'pois o mesmo possui obrigatoriedade no cadastro!', ['&Ok']);
                 End
                 Else
                 Begin
                   cdsConsulta.Delete;
                   pSequencial;
                 End;
               End;

  End;
end;

procedure TfrmCadCliVen.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSel ) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      pSetFocus(edtCodSup);
  End;
end;

procedure TfrmCadCliVen.edtCodProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodPro, edtNomPro, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCliVen.edtCodSupKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodSup, edtNomSup, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodSup, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCliVen.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCliVen.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

procedure TfrmCadCliVen.pEscapePressed;
begin

  If (Not pnlPesquisa.Visible) Then
  Begin
    If (Assigned(ActiveControl)) And (ActiveControl.Parent = pnlDados) Then
    Begin
       pLimpaTela;
    End
    Else If (Assigned(ActiveControl)) And (dbgConsulta.Focused) Then
    Begin
      pLimpaDados;
    End
    Else
      Inherited;
  End
  Else
    Inherited;

end;

procedure TfrmCadCliVen.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    pEscapePressed;
  End
  Else
    inherited;

  Case Key Of
    VK_F3 : pSetFocus(dbgConsulta);
    VK_F10: Begin
              Key := 0;
              btnGravar.Click;
            End;
  End;

end;

procedure TfrmCadCliVen.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgConsulta);
end;

procedure TfrmCadCliVen.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not btnGravar.Enabled Then
    Exit;

  If cdsConsulta.IsEmpty Then
    fMensagem('','Necessário informar ao menos um registro para o cliente!',['&OK'])
  Else
    pGravaDadosCliente;
    
end;

procedure TfrmCadCliVen.pGravaDadosCliente;
  Var
    qryCliVen: TUniQuery;
    strCodVen: String;

    procedure pSetParam(strCampo: String);
    begin
      If fEmptyStr(cdsConsulta.FieldByName(strCampo).AsString) Then
        qryCliVen.ParamByName(strCampo).Value    := Null
      Else
        qryCliVen.ParamByName(strCampo).AsString := cdsConsulta.FieldByName(strCampo).AsString;
    end;

begin
  qryCliVen := fCriaQuery(Nil);
  pnlInfo.Caption := 'Aguarde, Gravando Arquivo...';
  Self.Enabled    := False;

  cdsConsulta.Filter   := '';
  cdsConsulta.Filtered := False;

  With qryCliVen Do
  Begin
    Try
      fStartTransaction;

      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM VENCLI WHERE CVN_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := edtCodCli.Text;
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO VENCLI (');
      SQL.Add('   CVN_CODCLI,       ');
      SQL.Add('   CVN_CODSUP,       ');
      SQL.Add('   CVN_CODVEN,       ');
      SQL.Add('   CVN_CODPRO,       ');
      SQL.Add('   CVN_CODEMP,       ');
      SQL.Add('   CVN_IDENTI,       ');
      SQL.Add('   AUTOINCREM)       ');
      SQL.Add(' VALUES (            ');
      SQL.Add('   :CODCLI,          ');
      SQL.Add('   :CODSUP,          ');
      SQL.Add('   :CODVEN,          ');
      SQL.Add('   :CODPRO,          ');
      SQL.Add('   :CODEMP,          ');
      SQL.Add('   :IDENTI,          ');
      SQL.Add('   :AUTINC)          ');

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        pSetParam('CODSUP');
        pSetParam('CODVEN');
        pSetParam('CODPRO');
        pSetParam('IDENTI');

        ParamByName('CODCLI').AsString := edtCodCli.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('VENCLI', VS_strCodEmp);
        ExecSQL;

        If cdsConsulta.FieldByName('IDENTI').AsInteger = 1 Then
          strCodVen := cdsConsulta.FieldByName('CODVEN').AsString;

        cdsConsulta.Next;
      End;

      If Not fEmptyStr(strCodVen) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE CADCLI SET CLI_CODVEN = :CODVEN WHERE CLI_CODCLI = :CODCLI ');
        ParamByName('CODCLI').AsString := edtCodCli.Text;
        ParamByName('CODVEN').AsString := strCodVen;
        ExecSQL;
      End;

      fCommit;
      fMensagem('','Gravação efetuada com sucesso!',['&OK']);

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[Ocorreu um erro ao tentar gravar os produtos]');
      End;
    End;
  End;

  FreeAndNil(qryCliVen);
  pnlInfo.Caption := '';
  Self.Enabled    := True;
  pLimpaTela;

end;

procedure TfrmCadCliVen.cdsConsultaAfterScroll(DataSet: TDataSet);
  Var
    intCont: Integer;
    edtTemp: TEditFocus;
begin
  inherited;

  If (DataSet.State = dsInsert) Or (Not DataSet.Active) Or (Dataset.IsEmpty) Or (Not dbgConsulta.Focused) Then
    Exit;

  btnAdicionar.Tag := 1;
  strCodVenAnt := DataSet.FieldByName('CODVEN').AsString;

  For IntCont := 0 To pnlDados.ControlCount -1 Do
    If pnlDados.Controls[intCont] Is TEditFocus Then
    Begin
      edtTemp := TEditFocus(pnlDados.Controls[intCont]);
      edtTemp.Text := cdsConsulta.FieldByName(edtTemp.Hint).AsString;
    End;

end;

procedure TfrmCadCliVen.pSequencial;
  Var
    intRecNo: Integer;
    strIndex: String;
begin
  With cdsConsulta Do
  Begin
    DisableControls;
    strIndex := IndexFieldNames;
    intRecNo := RecNo;
    IndexFieldNames := 'AUTINC';
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('IDENTI').AsInteger := RecNo;
      Post;
      Next;
    End;
    IndexFieldNames := strIndex;
    RecNo := intRecNo;
    EnableControls;
  End;
end;

procedure TfrmCadCliVen.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  cdsConsultaAfterScroll(cdsConsulta);
end;


function TfrmCadCliVen.fTravaVendedor(Sender: TObject): Boolean;
begin
  Result := True;

  If (Sender = edtCodVen) And (btnAdicionar.Tag = 1) And (strCodVenAnt <> edtCodVen.Text) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Troca de Vendedor.');

    objLiberacao.strDirAce  := 'ALTVCL';
    objLiberacao.strSenLib  := fCfgSis('SENVEN');
    objLiberacao.strMsgSen  := 'Vendedor';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;
    objLiberacao.strCodDig  := strLoginUsuarioLogado;
    objLiberacao.strCliente := (edtCodCli.Text + '-' + edtNomCli.Text);

    If objLiberacao.fLibera Then
    Begin
      strCodVenAnt := edtCodVen.Text;
      Result := False;
    End
    Else
    Begin
      edtCodVen.Text := strCodVenAnt;
      Result := True;
    End;

  End;

end;

end.
