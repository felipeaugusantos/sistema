unit untDigInformacoesRPA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Uni, BitBtnLockedIncrem;

type
  TfrmDigInformacoesRPA = class(TfrmPai)
    lblDigita: TLabel;
    edtSenOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    mmoHisRec: TMemo;
    lbl1: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmoHisRecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    strCodOpe: String;
    strNomOpe: String;
    qryConOpe: TUniQuery;

    procedure pCarregaOperador;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigInformacoesRPA: TfrmDigInformacoesRPA;

implementation

uses untFuncoesSimples, untPesqAux;

{$R *.dfm}

{ TfrmDigInformacoesRPA }

procedure TfrmDigInformacoesRPA.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConOpe);
end;

procedure TfrmDigInformacoesRPA.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

function TfrmDigInformacoesRPA.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtSenOpe) Then
    Begin
      If fEmptyStr(edtSenOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Operador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaOperador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Operador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Operador está inativo!', ['&O k']);
          Result := False;
        End;
      End;
    End
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigInformacoesRPA.mmoHisRecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pSetFocus(btnConfirma);
end;

procedure TfrmDigInformacoesRPA.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenOpe.Text, True);
  With qryConOpe Do
  Begin
    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
    strCodOpe      := FieldByName('OPE_CODOPE').AsString;
    strNomOpe      := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

end.

