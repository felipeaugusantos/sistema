unit untHerancaNegociacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus, Uni, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Data.DB,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesConsulta;

type
  TfrmHerancaNegociacao = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDesNeg: TEditFocus;
    edtCodNeg: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodNegKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure pLoadNegociacao(strCodNeg: String);
  public
    { Public declarations }
    qryGenNeg: TUniQuery;
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmHerancaNegociacao: TfrmHerancaNegociacao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas;

procedure TfrmHerancaNegociacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  blnConfirma := True;
  Close;
end;

procedure TfrmHerancaNegociacao.edtCodNegKeyPress(Sender: TObject;
  var Key: Char);
  Var
    chrKey: Char;
    arrNegociacao: TConsultasArray;
begin
  chrKey := Key;

  If fPesqNegociacao(Self, edtCodNeg, Nil, qryGenNeg, chrKey, arrNegociacao) Then
    pLoadNegociacao(qryGenNeg.FieldByName('NEG_CODNEG').asString);
end;

procedure TfrmHerancaNegociacao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodNeg);
end;

procedure TfrmHerancaNegociacao.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(qryGenNeg) Then
    FreeAndNil(qryGenNeg);
end;

procedure TfrmHerancaNegociacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSairClick(Sender);
  End;
end;

procedure TfrmHerancaNegociacao.FormShow(Sender: TObject);
begin
  inherited;
  edtCodNeg.Clear;
  edtDesNeg.Clear;

  qryGenNeg := fCriaQuery(Self);
end;

function TfrmHerancaNegociacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodNeg) Then
  Begin
    If (fEmptyStr(edtCodNeg.Text)) Then
    Begin
      fMensagem('ATENÇÃO','O Campo Código da Negociação deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      pLoadNegociacao(edtCodNeg.Text);

      If fEmptyStr(edtDesNeg.Text) Then
      Begin
        fMensagem('ATENÇÃO','Código da Negociação não encontrado!',['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmHerancaNegociacao.pLoadNegociacao(strCodNeg: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADNEG ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   NEG_CODNEG = :CODNEG AND ';
  strSQL := strSQL + '   NEG_STATUS = "A"         ';

  With qryGenNeg Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODNEG').AsString := strCodNeg;
    Open;
  End;

  If (Not qryGenNeg.IsEmpty) Then
  Begin
    If Not fEmptyStr(qryGenNeg.FieldByName('NEG_CODNEG').AsString) Then
    Begin
      edtCodNeg.Text := qryGenNeg.FieldByName('NEG_CODNEG').AsString;
      edtDesNeg.Text := qryGenNeg.FieldByName('NEG_DESCRI').AsString;
    End
    Else
    Begin
      edtCodNeg.Clear;
      edtDesNeg.Clear;
      pSetFocus(edtCodNeg);
    End;
  End
  Else
  Begin
    edtCodNeg.Clear;
    edtDesNeg.Clear;
    pSetFocus(edtCodNeg);
  End;
end;

end.
