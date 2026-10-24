{***************************}
{* qryConIte -> CADITE     *}
{************************JB*}
unit untImpEstrutura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmImpEstrutura = class(TfrmPai)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConIte: TUniQuery;

  public
    { Public declarations }
    strCodIte: String;
    blnConfirma: Boolean;
  end;

var
  frmImpEstrutura: TfrmImpEstrutura;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmImpEstrutura.FormCreate(Sender: TObject);
begin
  inherited;

  strCodIte := '';
  blnConfirma := False;

end;

procedure TfrmImpEstrutura.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodIte );
end;

procedure TfrmImpEstrutura.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;


procedure TfrmImpEstrutura.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  blnConfirma := True;
  strCodIte := edtCodIte.Text;
  Close;

end;

end.

