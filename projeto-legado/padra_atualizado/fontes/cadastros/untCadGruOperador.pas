unit untCadGruOperador;

interface

uses
  Classes, Forms, untPaiCad, DBEditFocus, Grids, DBGridCitel, DBGrids, StdCtrls, Mask,
  DBCtrls, Controls, ComCtrls, Buttons, ExtCtrls, Menus, DB, AppEvnts, Uni,
  BitBtnLockedIncrem;

type
  TfrmCadGruOperador = class(TfrmPaiCad)
    pnlCab: TPanel;
    pnlDependentes: TPanel;
    dbgOperador: TDBGridCitel;
    Label2: TLabel;
    lblDescricao: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    Label1: TLabel;
    dbeDtaCad: TDBEditFocus;
    pnlFundo: TPanel;
    btnInsOperador: TBitBtnLocked;
    btnRemOperador: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnInsOperadorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnRemOperadorClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadGruOperador: TfrmCadGruOperador;

implementation

uses untModulo, untFuncoes, untfuncoesSimples, untPai, untInsOpeGruOpe, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadGruOperador.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModulo.qryCadGpo;
  strNomeTabela := 'CADGPO';
  strNomeCampo  := 'GPO_CODGPO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  btnInsOperador.Enabled := False;
  btnRemOperador.Enabled := False;  
end;

procedure TfrmCadGruOperador.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo,dbeDescricao,False);
  btnInsOperador.Enabled := True;
  btnRemOperador.Enabled := True;
end;

procedure TfrmCadGruOperador.btnInsOperadorClick(Sender: TObject);
begin
  inherited;
  If fIsEmpty('CADOPE') Then
  Begin
    fMensagem('AVISO', 'Tabela de Operadores esta vazia.', ['&Ok']);
  End
  Else
  Begin

		pCriarForm(TfrmInsOpeGruOpe, frmInsOpeGruOpe);

		If Not frmModulo.tblGruOpe.Active Then
      frmModulo.tblGruOpe.Open;
    frmModulo.tblGruOpe.Refresh;

  End;
end;

procedure TfrmCadGruOperador.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadGruOperador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmModulo.tblGruOpe.Close;
end;

procedure TfrmCadGruOperador.FormShow(Sender: TObject);
begin
  inherited;

	frmModulo.tblGruOpe.Open;
  
end;

procedure TfrmCadGruOperador.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GPO_DESCRI');
  stlCampos.Add('GPO_CODGPO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GPO_DESCRI');
  stlCamInd.Add('GPO_CODGPO');

  stlDesInd.Add('Nome do Grupo');
  stlDesInd.Add('Cód. Grupo');

end;

function TfrmCadGruOperador.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescricao) Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Descrição deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadGruOperador.btnIncluirClick(Sender: TObject);
begin
  strNomeCampo := 'GPO_CODGPO';
  inherited;
	If blnUsaProCodigo Then
  	pHabilitaCodigo(dbeCodigo, dbeDescricao, False)
	Else
  	pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  btnInsOperador.Enabled := True;
  btnRemOperador.Enabled := True;
end;

procedure TfrmCadGruOperador.btnGravarClick(Sender: TObject);
begin
  If (qryTabela.State = dsInsert) Then
    qryTabela.FieldByName('GPO_DTACAD').AsDateTime := VS_Date;

  qryTabela.FieldByName('GPO_CODEMP').AsString := VS_strCodEmp;
  fStartTransaction;
  inherited;
  If blnGravou Then
    fCommit
  Else
    fRollback;

  blnGravou := False;
  btnInsOperador.Enabled := False;
  btnRemOperador.Enabled := False;
end;

procedure TfrmCadGruOperador.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnInsOperador.Enabled := False;
  btnRemOperador.Enabled := False;
end;

procedure TfrmCadGruOperador.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA DE GRUPO DE OPERADOR *}
  {***********************************RV*}
  chrKey := '/';
  If fPesqGrupoOperador(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadGruOperador.btnRemOperadorClick(Sender: TObject);
begin
  inherited;
  If Not frmModulo.tblGruOpe.IsEmpty Then
  Begin
    frmModulo.tblGruOpe.Delete;
  End;
end;

end.

