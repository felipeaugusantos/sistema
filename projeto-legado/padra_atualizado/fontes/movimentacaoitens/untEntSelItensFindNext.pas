unit untEntSelItensFindNext;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmEntSelItensFindNext = class(TfrmPaiConfirma)
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    edtRefere: TEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmEntSelItensFindNext: TfrmEntSelItensFindNext;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmEntSelItensFindNext.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key,
               arrSel, False, nil, 'Consulta de Itens', '1') And
     fValidaCampos(edtCodIte, True) Then;
end;

procedure TfrmEntSelItensFindNext.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin
    If fVerificaCampos Then
    Begin
    
    End

    Else Action := caNone;
  End;
end;

procedure TfrmEntSelItensFindNext.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodIte );
  pSetFocus(edtCodIte);
end;

function TfrmEntSelItensFindNext.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If Not fEmptyStr(edtCodIte.Text) Then
      Begin

        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('Produto não encontrado!');
          Result := False;
        End Else
        Begin
          strCampoFiltro := 'ENT_CODITE';
          strValorFiltro := edtCodIte.Text;
        End;

        If Result Then
        Begin
          edtRefere.Clear;
          blnMudarFoco := False;
          pSetFocus(btnConfirma);
        End;
      End

      Else edtDesIte.Clear;

    End

    Else If (Sender = edtRefere) Then
    Begin

      If Not fEmptyStr(edtRefere.Text) Then
      Begin
        edtCodIte.Clear;
        edtDesIte.Clear;

        strCampoFiltro := 'ENT_REFERE';
        strValorFiltro := edtRefere.Text;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

