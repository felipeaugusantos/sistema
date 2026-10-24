unit untDigEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, StdCtrls, ComCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, EditFocus, Uni;

type
  TfrmDigEmpresa = class(TfrmPaiSimples)
    Panel1: TPanel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaEmpresa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strEmpresasFiltro: String;
    strEmpresaResultado: String;
  end;

var
  frmDigEmpresa: TfrmDigEmpresa;

implementation

uses untPesqAux, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmDigEmpresa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    strEmpresaResultado := edtCodEmp.Text;
    Close;
  End;
end;

procedure TfrmDigEmpresa.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, False, strEmpresasFiltro) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
//      pSetFocus(btnConfirma);
  End;
end;

procedure TfrmDigEmpresa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmDigEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (key = VK_ESCAPE) then
    Key := 0
  Else  
    inherited;
end;

function TfrmDigEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodEmp) Then
  Begin

    If (fEmptyStr(edtCodEmp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Empresa deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If Pos(edtCodEmp.Text,strEmpresasFiltro) > 0 Then
      Begin
        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada para produção da tinta!' + #13#10 +
                              'As empresas cadastradas são : ' + strEmpresasFiltro, ['&Ok']);
        Result := False;
      End;
    End;

  End;

end;

procedure TfrmDigEmpresa.pCarregaEmpresa;
var
  qryConEmp: TUniQuery;
begin
  Try
    qryConEmp := fCriaQuery;

    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
    With qryConEmp Do
    Begin
      edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
    End;
  Finally
    FreeAndNil(qryConEmp);
  End;
end;

end.
