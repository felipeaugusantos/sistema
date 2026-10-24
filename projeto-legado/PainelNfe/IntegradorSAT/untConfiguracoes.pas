unit untConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, ExtCtrls, Buttons;

type
  TfrmConfiguracoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    btnConfirma: TBitBtn;
    Label6: TLabel;
    edtPatSat: TEditFocus;
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses untUtil;

{$R *.dfm}

procedure TfrmConfiguracoes.btnConfirmaClick(Sender: TObject);
begin

  If (fEmptyStr(edtCodEmp.Text)) Then
  Begin
    pMensagemOk('A empresa deve ser preenchida!');
    edtCodEmp.SetFocus;
    Exit;
  End;

  fArqIni(1, 'GERAL', 'EMPSAT', edtCodEmp.Text, 'opcoes_integrador_sat.ini');
  fArqIni(1, 'GERAL', 'PATSAT', edtPatSat.Text, 'opcoes_integrador_sat.ini');

  ModalResult := mrOk;

end;

procedure TfrmConfiguracoes.edtCodEmpExit(Sender: TObject);
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
    edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3);
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  edtCodEmp.Text := fArqIni(0, 'GERAL', 'EMPSAT', '', 'opcoes_integrador_sat.ini');
  edtPatSat.Text := fArqIni(0, 'GERAL', 'PATSAT', '', 'opcoes_integrador_sat.ini');
end;

end.
