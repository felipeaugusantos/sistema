{***************************}
{* qryConOpe -> CADOPE     *}
{************************JB*}

unit untInsOpeGruOpe;

interface

uses
  SysUtils, Variants, Classes, Graphics, Forms,
  Dialogs, untPaiCad, DBEditFocus, DBLookupComboBoxFocus, EditFocus,
  {QTypes,} ExtCtrls, StdCtrls, Mask, DBCtrls, ComCtrls, Buttons,
  Controls, Uni, Menus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmInsOpeGruOpe = class(TfrmPaiCad)
    dbeGrupo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodOpe: TDBEditFocus;
    edtDesOperador: TEditFocus;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pCarregaOperadores;
    procedure pTodosOperadores;
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaOperador(qryConsulta: TUniQuery; edtOperador: TEdit;
              dbeOperador: TDBEditFocus);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodOpeChange(Sender: TObject);
  private
    { Private declarations }
    qryGenOpe: TUniQuery;
    qryConOpe: TUniQuery;
    function fGrupoOperador: String;
    function fOperadorJaInserido: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmInsOpeGruOpe: TfrmInsOpeGruOpe;

implementation

uses untModulo, untfuncoesSimples, DB, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmInsOpeGruOpe.FormCreate(Sender: TObject);
begin
  inherited;

  qryGenOpe := fCriaQuery(Self);

  strNomeTabela := 'OPEGPO';
  strNomeCampo  := 'GPO_CODGPO';

  qryTabela := frmModulo.qryOpeGpo;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

end;

procedure TfrmInsOpeGruOpe.FormShow(Sender: TObject);
begin
  blnUsaAutInc := False;
  inherited;
	fAbrirTabela(qryConOpe);
  pTodosOperadores;

  With qryTabela, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM OPEGPO WHERE FALSE');
    Open;
  End;

end;

procedure TfrmInsOpeGruOpe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
	fFecharTabela(qryConOpe);
	fFecharTabela(qryGenOpe);
end;


procedure TfrmInsOpeGruOpe.pCarregaOperadores;
	Var
  	strSQL : String;
begin
  {*********************************************}
  {* OPERADORES QUE NAO FAZEM PARTE DO GRUPO   *}
  {******************************************DV*}
  With qryGenOpe Do
  Begin
  	strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADOPE  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '   OPE_CODOPE NOT IN (SELECT OPE_CODOPE FROM OPEGPO WHERE GPO_CODGPO = :CODGPO)';
		Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODGPO').AsInteger := frmModulo.qryCadGpo.FieldByName('GPO_CODGPO').AsInteger;
    Open;
    If IsEmpty Then
    Begin
    	fMensagem('AVISO','Todos os Operadores já pertencem a esse Grupo.',['&O k']);
      btnCancela.Click;
    End;

  End;

end;

procedure TfrmInsOpeGruOpe.pTodosOperadores;
begin
  With qryGenOpe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADOPE');
    Open;

  End;

end;

procedure TfrmInsOpeGruOpe.btnAlterarClick(Sender: TObject);
begin
  inherited;
	pCarregaOperadores;
end;

procedure TfrmInsOpeGruOpe.pInicializaIndices;
begin
  inherited;
  //
end;

function TfrmInsOpeGruOpe.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strGrupoOpe: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodOpe) Then
    Begin
      If fEmptyStr(dbeCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Campo Operador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fOperadorJaInserido Then
        Begin
          fMensagem('ATENÇÃO', 'Esse operador já está neste grupo', ['Ok']);
          Result := False;
        End
        Else
        Begin
          strGrupoOpe := fGrupoOperador;

          If Not fEmptyStr(strGrupoOpe) And blnBuscaPorChave Then
          Begin
            fMensagem('ATENÇÃO', 'Esse operador já está em outro grupo (' + strGrupoOpe + ').', ['Ok']);
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmInsOpeGruOpe.dbeCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  Try
    If fEntraCons(Key) Then
    Begin
      if fPesqOperador(Self, dbeCodOpe, edtDesOperador, qryConOpe, Key, arrSel) then
      Begin
        dbeCodOpe.Text := qryConOpe.FieldByName('OPE_CODOPE').AsString;
        Self.SelectNext(ActiveControl, True, True);
      End;
    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmInsOpeGruOpe.dbeCodOpeKeyPress]');
    End;
  End;
end;

procedure TfrmInsOpeGruOpe.pCarregaOperador(qryConsulta: TUniQuery; edtOperador: TEdit;
    dbeOperador: TDBEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConsulta, dbeCodOpe.Text);
  With qryConsulta Do
  Begin
    edtOperador.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmInsOpeGruOpe.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('GPO_CODGPO').AsInteger := frmModulo.qryCadGpo.FieldByName('GPO_CODGPO').AsInteger;
  fStartTransaction;
  blnUsaProCodigo := False;
  inherited;
  If blnGravou Then
    fCommit
  Else
    fRollback;

  blnGravou := False;
	pTodosOperadores;
end;

procedure TfrmInsOpeGruOpe.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pCarregaOperadores;
  If (qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert) Then
    pSetFocus(dbeCodOpe);
end;

procedure TfrmInsOpeGruOpe.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pTodosOperadores;
end;

procedure TfrmInsOpeGruOpe.dbeCodOpeChange(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCodOpe.Text) Then
    edtDesOperador.Clear
  Else
    edtDesOperador.Text := fRetNomeOperador(dbeCodOpe.Text);
end;

function TfrmInsOpeGruOpe.fGrupoOperador: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GROUP_CONCAT(GPO_DESCRI) AS GPO_DESCRI ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  OPEGPO ');
  qryAux.SQL.Add('JOIN CADGPO ON CADGPO.GPO_CODGPO = OPEGPO.GPO_CODGPO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  OPEGPO.OPE_CODOPE  = :CODOPE AND ');
  qryAux.SQL.Add('  OPEGPO.GPO_CODGPO <> :CODGPO ');

  qryAux.ParamByName('CODOPE').AsString := dbeCodOpe.Text;
  qryAux.ParamByName('CODGPO').AsString := frmModulo.qryCadGpo.FieldByName('GPO_CODGPO').AsString;

  qryAux.Open;

  Result := qryAux.FieldByName('GPO_DESCRI').AsString;

  FreeAndNil(qryAux);
end;

function TfrmInsOpeGruOpe.fOperadorJaInserido: Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GPO_DESCRI ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  OPEGPO ');
  qryAux.SQL.Add('JOIN CADGPO ON CADGPO.GPO_CODGPO = OPEGPO.GPO_CODGPO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  OPEGPO.OPE_CODOPE = :CODOPE AND ');
  qryAux.SQL.Add('  OPEGPO.GPO_CODGPO = :CODGPO ');

  qryAux.ParamByName('CODOPE').AsString := dbeCodOpe.Text;
  qryAux.ParamByName('CODGPO').AsString := frmModulo.qryCadGpo.FieldByName('GPO_CODGPO').AsString;

  qryAux.Open;

  Result := Not qryAux.IsEmpty;

  FreeAndNil(qryAux);
end;

end.


