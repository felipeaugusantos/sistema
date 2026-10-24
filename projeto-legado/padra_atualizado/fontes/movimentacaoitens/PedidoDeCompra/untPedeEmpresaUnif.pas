unit untPedeEmpresaUnif;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, EditFocus,
  untTypesSistema, untConsultas, untFuncoesConsulta;

type
  TfrmPedeEmpresaUnif = class(TfrmPaiConfirma)
    DBGridCitel1: TDBGridCitel;
    Panel1: TPanel;
    lbl1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    dtsCadEmp: TDataSource;
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrEmpresa: TConsultasArray;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPedeEmpresaUnif: TfrmPedeEmpresaUnif;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmPedeEmpresaUnif.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmPedeEmpresaUnif.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPedeEmpresaUnif.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not fVerificaCampos Then
      Action := caNone;

  End;

end;

procedure TfrmPedeEmpresaUnif.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodEmp);
end;

function TfrmPedeEmpresaUnif.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        pMensagemOk('Informe o código da empresa destino!');
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
