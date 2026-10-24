unit untCadMovFlex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, untPaiCad, AppEvnts,
  Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, untMovFlex,
  EditFocus, QColorLabel,  DBMemoFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadMovFlex = class(TfrmPaiCad)
    pnlFundo    : TPanel;
    Label6      : TLabel;
    Label4      : TLabel;
    dbeCreDeb   : TDBEditFocus;
    Label3      : TLabel;
    dbeNumDoc   : TDBEditFocus;
    Label2      : TLabel;
    dbeDtaLan   : TDBEditFocus;
    dbeCodSeq   : TDBEditFocus;
    Label1      : TLabel;
    dbeValLan   : TDBEditFocus;
    Label9      : TLabel;
    dbeCodVen   : TDBEditFocus;
    edtNomVen   : TEditFocus;
    Label10     : TLabel;
    dbeCodCli   : TDBEditFocus;
    edtNomCli   : TEditFocus;
    Label12     : TLabel;
    dbeCodPro   : TDBEditFocus;
    edtNomPro   : TEditFocus;
    Label13     : TLabel;
    ColorLabel2 : TColorLabel;
    Label15     : TLabel;
    dbeEspDoc   : TDBEditFocus;
    dbeHistor   : TDBMemoFocus;
    Label5: TLabel;
    dbeOrigem: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label7: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    Label8: TLabel;
    dbeCodSup: TDBEditFocus;
    edtNomSup: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    Label11: TLabel;
    edtNomEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeHistorKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodSupKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objMovFlex : TMovFlex;
    procedure pSetarControles(blnHabilita: Boolean);
  protected
    procedure pAtualizarEdits;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMovFlex }

procedure TfrmCadMovFlex.FormCreate(Sender: TObject);
  Var
    intCont : Integer;
begin
  inherited;
  strNomeTabela := 'MOVFLE';
  strNomeCampo  := 'FLE_CODSEQ';

  objMovFlex         := TMovFlex.Create(Self);
  objMovFlex.pScroll := pAtualizarEdits;
  objMovFlex.pAbreQueryCadastro;

  qryTabela := objMovFlex.qryMovFle;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := objMovFlex.dtsDtaFle;
    End;
  End;

  dbeHistor.DataSource := objMovFlex.dtsDtaFle;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodSeq;
end;

procedure TfrmCadMovFlex.FormShow(Sender: TObject);
begin
  inherited;

  pSetaCodIte( dbeCodPro );

end;

function TfrmCadMovFlex.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    objMovFlex.blnValidarCampos := True;
    objMovFlex.blnPermitirEmBranco := fEmptyStr(dbeNumDoc.Text);
    pSetarControles(Not fEmptyStr(dbeNumDoc.Text));

    Try
      If (Sender = dbeDtaLan) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(dbeDtaLan.Text)) Then
          objMovFlex.dtaDtaLan := StrToDate(dbeDtaLan.Text)
        Else
          objMovFlex.dtaDtaLan := 0;
      End;

      If (Sender = dbeNumDoc) Then
      Begin
        objMovFlex.strNumDoc := dbeNumDoc.Text;
      End;

      If (Sender = dbeEspDoc) Then
      Begin
        objMovFlex.strEspDoc := dbeEspDoc.Text;
      End;

      If (Sender = dbeCreDeb) Then
      Begin
        objMovFlex.strCreDeb := dbeCreDeb.Text;
      End;

      If (Sender = dbeValLan) Then
      Begin
        objMovFlex.fltValLan := fStrToFloat(dbeValLan.Text);
      End;

      If (Sender = dbeCodVen) Then
      Begin
        objMovFlex.strCodVen := dbeCodVen.Text;
      End;

      If (Sender = dbeCodCli) Then
      Begin
        objMovFlex.strCodCli := dbeCodCli.Text;
      End;

      If (Sender = dbeCodFor) Then
      Begin
        objMovFlex.strCodFor := dbeCodFor.Text;
      End;

      If (Sender = dbeCodPro) Then
      Begin
        objMovFlex.strCodIte := dbeCodPro.Text;
      End;

      If (Sender = dbeOrigem) Then
      Begin
        objMovFlex.strOrigem := dbeOrigem.Text;
      End;

      If (Sender = dbeCodSup) Then
      Begin
        objMovFlex.strCodSup := dbeCodSup.Text;
      End;

      If (Sender = dbeCodEmp) Then
      Begin
        objMovFlex.strCodEmp := dbeCodEmp.Text;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fMensagemTratada(E);
      End;
    End;

    objMovFlex.blnValidarCampos := False;
    pAtualizarEdits;
  End;

  If Not Result Then
    pSetFocus(Sender);    
end;

procedure TfrmCadMovFlex.btnPesquisaClick(Sender: TObject);
  Var
    chrKey : Char;
    intOpc : Integer;
    arrMov : TConsultasArray;
begin
  chrKey := '?';
  intOpc := fMensagem('','Somente créditos, débitos ou todos?',['&Créditos','&Débitos','&Todos']);

  If fPesqMovFlex(Self, Nil, qryTabela, chrKey, arrMov, True, intOpc) Then
  Begin
    pAtualizarEdits;  
    If btnAlterar.CanFocus Then
      pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMovFlex.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMovFlex.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMovFlex.btnGravarClick(Sender: TObject);
begin
  If qryTabela.State in [dsInsert, dsEdit] Then
  Begin
    If fEmptyStr(dbeCodCli.Text) Then
      dbeCodCli.Field.Value := Null;

    If fEmptyStr(dbeCodFor.Text) Then
      dbeCodFor.Field.Value := Null;

    If fEmptyStr(dbeCodPro.Text) Then
      dbeCodPro.Field.Value := Null;

    If fEmptyStr(dbeCodSup.Text) Then
      dbeCodSup.Field.Value := Null;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMovFlex.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMovFlex.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeDtaLan.Field.AsDateTime := VS_Date;

  With objMovFlex, qryMovFle Do
  Begin
    strCodEmp := VS_strCodEmp; //USADO PARA VALIDAR DOCUMENTO
    FieldByName('FLE_CODEMP').AsString   := VS_strCodEmp;
  End;
  pAtualizarEdits;
  pSetFocus(dbeDtaLan);
end;

procedure TfrmCadMovFlex.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
    pSetFocus(dbeDtaLan);
end;

procedure TfrmCadMovFlex.pAtualizarEdits;
begin
  inherited;
  edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
  edtNomPro.Text := fRetNomProduto(dbeCodPro.Text);
  edtNomVen.Text := fRetNomeOperador(dbeCodVen.Text);
  edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
  edtNomSup.Text := fRetNomeOperador(dbeCodSup.Text);
  edtNomEmp.Text := fRetNomeEmpresa(dbeCodEmp.Text);
end;

procedure TfrmCadMovFlex.dbeCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVen : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, dbeCodVen, edtNomVen, nil, Key, arrVen) Then
  Begin
    If fValidaCampos(dbeCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes : TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCLi, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmpresa: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeCodProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPro: TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, dbeCodPro, edtNomPro, nil, Key, arrPro, False, nil, 'Consulta de Itens', '1') then
  Begin
    if fValidaCampos(dbeCodPro,False) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeCodSupKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSup : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, dbeCodSup, edtNomSup, nil, Key, arrSup) Then
  Begin
    If fValidaCampos(dbeCodSup, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.dbeHistorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And fEmptyStr(dbeHistor.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovFlex.pInicializaIndices;
begin
  //...
end;

procedure TfrmCadMovFlex.pSetarControles(blnHabilita: Boolean);
begin
  dbeEspDoc.Enabled := blnHabilita;

  If (dbeOrigem.Text = 'F') Then
  Begin
    dbeCodCli.Enabled := blnHabilita;
    dbeCodPro.Enabled := blnHabilita;
  End
  Else
  Begin
    dbeCodCli.Enabled := True;
    dbeCodPro.Enabled := True;
  End;

  If (Not blnHabilita) Then
  Begin
    dbeEspDoc.Clear;

    If (dbeOrigem.Text = 'F') Then
    Begin
      dbeCodCli.Clear;
      dbeCodPro.Clear;
    End;

    If (qryTabela.State In [dsInsert, dsEdit]) Then
    Begin
      dbeEspDoc.Field.AsString := '';

      If (dbeOrigem.Text = 'F') Then
      Begin
        dbeCodCli.Field.Clear;
        dbeCodPro.Field.Clear;
      End;
    End;
  End;
end;

end.
