unit untCadRecursosProjeto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus,Uni,untPesqAux;

type
  TfrmCadRecursosProjeto = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    pnlTopGeral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label17: TLabel;
    ColorLabel2: TColorLabel;
    dbeCodRep: TDBEditFocus;
    dbeNomRep: TDBEditFocus;
    dbeTipRep: TDBEditFocus;
    pnlTopGeral2: TPanel;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    dbeTipCap: TDBEditFocus;
    dbeValCus: TDBEditFocus;
    pnlTopCliente: TPanel;
    lblCndPag: TLabel;
    dbeCodOpe: TDBEditFocus;
    edtNomOpe: TEditFocus;
    ColorLabel3: TColorLabel;
    dbeSituac: TDBEditFocus;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeTipRepExit(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
    procedure pPreparaForm;
    procedure pCarregaOperador;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pQueryAfterOpen(DataSet: TDataSet);
    procedure pInicializaIndices; override;
  end;


implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas;

{ TfrmCadRecursosProjeto }

procedure TfrmCadRecursosProjeto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodRep, dbeNomRep, False);
end;

procedure TfrmCadRecursosProjeto.btnCancelaClick(Sender: TObject);
begin
  inherited;
 pPreparaForm;
end;

procedure TfrmCadRecursosProjeto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRecursosProjeto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    pPreparaForm;
  End
  Else
    fRollBack;

end;

procedure TfrmCadRecursosProjeto.btnGravarClick(Sender: TObject);
begin
  If fEmptyStr(dbeCodOpe.Text) Then
    qryTabela.FieldByName('REP_CODOPE').Value := Null;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRecursosProjeto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadRecursosProjeto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodRep, dbeNomRep, False)
  Else
    pHabilitaCodigo(dbeCodRep, dbeCodRep, True);
  pPreparaForm;
end;

procedure TfrmCadRecursosProjeto.btnPesquisaClick(Sender: TObject);
  Var
    arrRec : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqRecursoProjeto(Self, Nil, Nil, qryTabela, chrKey, arrRec) Then
  Begin
    pSetFocus(btnAlterar);
    pPreparaForm;
    pCarregaOperador;
  End;
end;

procedure TfrmCadRecursosProjeto.dbeCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodOpe, edtNomOpe, qryConOpe, Key, arrSel) then
  Begin
    If fValidaCampos(dbeCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadRecursosProjeto.dbeTipRepExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeTipRep, False);
end;

procedure TfrmCadRecursosProjeto.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadRecursosProjeto.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CADREP';
  strNomeCampo        := 'REP_CODREP';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;
  qryTabela.AfterOpen := pQueryAfterOpen;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodRep;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

function TfrmCadRecursosProjeto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodRep) Then
    Begin
      If (fEmptyStr(dbeCodRep.Text)) And (dbeCodRep.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do recurso de projeto deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeNomRep) Then
    Begin
      If fEmptyStr(dbeNomRep.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O nome do recurso de projeto deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeTipRep) Then
    Begin
      If (Pos(dbeTipRep.Text, 'C_F_V_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de recurso de projeto deve ser C, F ou V!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        pPreparaForm;
      End;
    End

    Else If (Sender = dbeSituac) Then
    Begin
      If (Pos(dbeSituac.Text, 'I_A_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Situação deve ser A ou I!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeTipCap) Then
    Begin
      If Not fValidaCampos(dbeTipRep, True) Then
        Result := False
      Else
      If (Pos(dbeTipRep.Text, 'C_F_') > 0) And (Pos(dbeTipCap.Text, 'H_D_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o Tipo de recurso for "Colaborador" ou "Ferramenta", ' +
                              'o tipo de controle deve ser (H)ora ou (D)iária!', ['&OK']);
        Result := False;
      End
      Else
      If (Pos(dbeTipRep.Text, 'V_') > 0) And (Pos(dbeTipCap.Text, 'K_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o Tipo de recurso for "Veículo", ' +
                              'o tipo de controle deve ser (K)m!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = dbeValCus) Then
    Begin
      If fStrToFloat(dbeValCus.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO VENDEDOR           *}
    {**************************************MV*}
    Else If (Sender = dbeCodOpe) And (pnlTopCliente.Visible) Then
    Begin
      If Not fEmptyStr(dbeCodOpe.Text) Then
      Begin
        pCarregaOperador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Operador não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadRecursosProjeto.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, dbeCodOpe.Text);
  With qryConOpe Do
  Begin
    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadRecursosProjeto.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('REP_CODREP');
  stlCampos.Add('REP_NOMREP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REP_NOMREP');
  stlCamInd.Add('REP_CODREP');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmCadRecursosProjeto.pQueryAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TFloatField(qryTabela.FieldByName('REP_VALCUS')).DisplayFormat := '###,#0.00';
  End;
end;

procedure TfrmCadRecursosProjeto.pPreparaForm;
begin
  pnlTopCliente.Visible := (dbeTipRep.Text = 'C');
  If Not pnlTopCliente.Visible Then
  Begin
    dbeCodOpe.Clear;
    edtNomOpe.Clear;
  End;
end;

end.
