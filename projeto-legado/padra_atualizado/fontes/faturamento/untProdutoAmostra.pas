unit untProdutoAmostra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, MemoFocus, Uni, untFuncoesSimples, Data.DB;

type
  TfrmProdutoAmostra = class(TfrmPaiConfirma)
    pnlTexto: TPanel;
    memDescricao: TMemoFocus;
    lblDescricao: TLabel;
    edtNome: TEditFocus;
    lblNome: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function fValidaCamposInterna(Sender: TWinControl): Boolean;
  public
    { Public declarations }
    strSeqGer: String;
    strNomCli: String;
    strDesAmo: String;
    blnConfirma: Boolean;
  end;

implementation

{$R *.dfm}

uses untFatVendas;


procedure TfrmProdutoAmostra.btnConfirmaClick(Sender: TObject);
begin
  strDesAmo := memDescricao.text;
  strNomCli := edtNome.text;


  If (fMensagem('', 'Confirma recebimento de amostra?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnConfirma := True;
    ModalResult := mrOK;
  End
  Else
    ModalResult := mrCancel;

//  inherited;
end;

procedure TfrmProdutoAmostra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If modalResult = mrOk Then
  Begin

    If Not fValidaCamposInterna(memDescricao) Then
    Begin
      action := caNone;
      Exit;
    End;

    If Not fValidaCamposInterna(edtNome) Then
    Begin
      action := caNone;
      Exit;
    End;

  End;
end;

procedure TfrmProdutoAmostra.FormCreate(Sender: TObject);
var
  qryTabela: TUniQuery;
begin
  inherited;

  strDesAmo := '';
  strNomCli := '';

  qryTabela := fCriaQuery;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT PRD_DESAMO, PRD_NOMCLI FROM PRDAMO');
  qryTabela.SQL.Add('WHERE PRD_SEQGER = :SEQGER');
  qryTabela.ParamByName('SEQGER').AsString := frmFatVendas.qryFatGor.FieldByName('AUTOINCREM').AsString;
  qryTabela.Open;

  If Not qryTabela.isEmpty Then
  Begin
    memDescricao.text := qryTabela.FieldByName('PRD_DESAMO').AsString;
    edtNome.text      := qryTabela.FieldByName('PRD_NOMCLI').AsString;
    strDesAmo := memDescricao.text;
    strNomCli := edtNome.text;
  End;
end;


function TfrmProdutoAmostra.fValidaCamposInterna(Sender: TWinControl): Boolean;
begin
  Result := True;
//  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (sender = memDescricao) Then
    Begin
      If fEmptyStr(memDescricao.Texto) Then
      Begin
        pMensagemOk('A descrição da amostra deve ser preenchida.');
        Result := False;
      End;
    End
    Else If (sender = edtNome) Then
    Begin
      If fEmptyStr(edtNome.Text) Then
      Begin
        pMensagemOk('O nome do responsável por trazer a amostra deve ser preenchido.');
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

end.
