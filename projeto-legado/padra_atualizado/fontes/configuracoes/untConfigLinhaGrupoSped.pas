unit untConfigLinhaGrupoSped;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, BitBtnLockedIncrem, StdCtrls, EditFocus, Mask, MaskEditFocus,
  Grids, DBGrids, DBGridCitel, AppEvnts, Buttons, ExtCtrls, DB, Uni, untFuncoes, madExcept,
  frxClass, frxExportCSVTestabilidade, Vcl.Menus, untTypesSistema;

type
  TfrmConfigLinhaGrupoSped = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnl1: TPanel;
    pnl2: TPanel;
    Label9: TLabel;
    edtDesGrupo: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    dsAux: TDataSource;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    dbgrd: TDBGridCitel;
    cmbTipExp: TComboBox;
    Label1: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    qryLinhaGrupo: TUniQuery;

    arrLinGru,
    arrEmpresa: TConsultasArray;

    function fRetTipExp: String;
    procedure pLimpaCampos;
  public
    { Public declarations }
    blnFiscal: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmConfigLinhaGrupoSped: TfrmConfigLinhaGrupoSped;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFuncoesConsulta;

function TfrmConfigLinhaGrupoSped.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    if (Sender = mskLinhaGrupo) Then
    Begin
      pDesmarcaLista(mskLinhaGrupo, arrLinGru, '', 6);
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp, arrEmpresa, '', 3);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfigLinhaGrupoSped.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    fMensagem('Aviso', 'Favor informar uma linha/grupo válido!', ['OK']);
    pSetFocus(mskLinhaGrupo);
    Exit;
  End
  Else
  Begin
    Try
      dsAux.DataSet.Append;
      dsAux.DataSet.FieldByName('LGS_CODGRU').AsString := mskLinhaGrupo.Text;
      dsAux.DataSet.FieldByName('LGS_DESGRU').AsString := edtDesGrupo.Text;
      dsAux.DataSet.FieldByName('LGS_CODEMP').AsString := edtCodEmp.Text;
      dsAux.DataSet.FieldByName('LGS_TIPEXP').AsString := fRetTipExp;
      dsAux.DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CONLGS', VS_strCodEmp);
      dsAux.DataSet.Post;

      pLimpaCampos;
    Except
      HandleException;
    End;
  End;
end;

procedure TfrmConfigLinhaGrupoSped.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  btnSairClick(Sender);
end;

procedure TfrmConfigLinhaGrupoSped.btnRemoverClick(Sender: TObject);
begin
  inherited;
  dsAux.DataSet.Delete;
end;

procedure TfrmConfigLinhaGrupoSped.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, fRetNomeEmpresa, nil, 'da empresa', 3);
end;

procedure TfrmConfigLinhaGrupoSped.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa) then
  begin
    if fValidaCampos(edtCodEmp,False) then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigLinhaGrupoSped.FormCreate(Sender: TObject);
begin
  inherited;

  blnFiscal := True;

  qryLinhaGrupo := fCriaQuery(Nil);
  Try
    qryLinhaGrupo.SQL.Clear;
    qryLinhaGrupo.Close;
    qryLinhaGrupo.SQL.Text := 'SELECT LGS_CODGRU, LGS_DESGRU, LGS_CODEMP, LGS_TIPEXP, AUTOINCREM FROM CONLGS';
    qryLinhaGrupo.Open;

    dsAux.DataSet := qryLinhaGrupo;
  Except
    HandleException;
  End;
end;

procedure TfrmConfigLinhaGrupoSped.FormShow(Sender: TObject);
begin
  inherited;
  dsAux.DataSet.Open;
  cmbTipExp.ItemIndex := IIF(blnFiscal, 0, 5);
end;

function TfrmConfigLinhaGrupoSped.fRetTipExp: String;
begin
  Result := IntToStr(cmbTipExp.ItemIndex + 1);
end;

procedure TfrmConfigLinhaGrupoSped.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmConfigLinhaGrupoSped.mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru) then
  begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigLinhaGrupoSped.pLimpaCampos;
begin
  mskLinhaGrupo.Clear;
  edtDesGrupo.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  cmbTipExp.ItemIndex := IIF(blnFiscal, 0, 5);
end;

end.
