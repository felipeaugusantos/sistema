unit untHerancaOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni;

type
  TfrmHerancaOperador = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirmar: TBitBtnLocked;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    lblOperador: TLabel;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryCadOpe: TUniQuery;
    procedure pCarregaDados;
    { Private declarations }
  public
    { Public declarations }
    function getQryCadOpe: TUniQuery;
    function getCodOpe: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmHerancaOperador.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  ModalResult := mrOk;
end;

procedure TfrmHerancaOperador.pCarregaDados;
begin
  If (Not fValidaCampos(edtCodOpe)) Then
    Exit;

  qryCadOpe.Close;
  qryCadOpe.SQL.Clear;
  qryCadOpe.SQL.Text := ' SELECT * FROM CADOPE WHERE OPE_CODOPE = :CODOPE ';
  qryCadOpe.ParamByName('CODOPE').AsString := edtCodOpe.Text;
  qryCadOpe.Open;
end;

procedure TfrmHerancaOperador.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodOpe: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrCodOpe) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmHerancaOperador.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtCodOpe Then
  Begin
    If fEmptyStr(edtCodOpe.Text) Then
      edtNomOpe.Clear
    Else
    Begin
      edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);

      If fEmptyStr(edtNomOpe.Text) Then
      Begin
        pMensagemOk('Operador não encontrado!');
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmHerancaOperador.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadOpe := fCriaQuery(Self);
end;

procedure TfrmHerancaOperador.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadOpe);
end;

function TfrmHerancaOperador.getCodOpe: String;
begin
  Result := '';

  If (Assigned(qryCadOpe)) And (Not qryCadOpe.IsEmpty) Then
    Result := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
end;

function TfrmHerancaOperador.getQryCadOpe: TUniQuery;
begin
  Result := qryCadOpe;
end;

end.
