unit untLibCartoesFramePlanoDeContasMaskEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus, untLibCartoesPai,
  Vcl.Mask,

  untTLibCartoesFuncoes, untLibCartoesInterfacesTipos;

type
  {********************************************************************}
  {* apenas para acessar o método fValidaCampos do frmPai (protected) *}
  {*****************************************************************RP*}
  THackfrmPai = class(TfrmPai)
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  TfraPlanoDeContasMskEdit = class(TFrame)
    edtDesCta: TEditFocus;
    lblPlaContas: TLabel;
    MskCodCta: TMaskEdit;
    procedure MskCodCtaExit(Sender: TObject);
    procedure MskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure MskCodCtaEnter(Sender: TObject);
    procedure MskCodCtaChange(Sender: TObject);
    function fGetApenasNumeros(strTexto: String) : String;
  private
    { Private declarations }
    arrPlaContas: TConsultasArray;
    blnTrocouOnKeyDown : Boolean;
    procedure OnKeyDownPlaCta(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TfraPlanoDeContasMskEdit.fGetApenasNumeros(strTexto: String): String;
Var
  i : Integer;
Begin
  for i := Length(strTexto) downto 1 do
    if not CharInSet(strTexto[i], ['0'..'9']) then
      Delete(strTexto,i,1);
  Result := strTexto;
end;

procedure TfraPlanoDeContasMskEdit.MskCodCtaChange(Sender: TObject);
begin
  MskCodCta.Text := fGetApenasNumeros(MskCodCta.Text)
end;

procedure TfraPlanoDeContasMskEdit.MskCodCtaEnter(Sender: TObject);
begin
  MskCodCta.EditMask := '';
  If Not blnTrocouOnKeyDown Then
  Begin
    MskCodCta.OnKeyDown := OnKeyDownPlaCta;
    blnTrocouOnKeyDown := True;
  End;
  MskCodCta.MaxLength := 7;
end;

procedure TfraPlanoDeContasMskEdit.MskCodCtaExit(Sender: TObject);
begin
  If (Length(Trim(MskCodCta.Text)) < 7) Then
    MskCodCta.EditMask := ''
  Else
    MskCodCta.EditMask := '99.99.999;0;_'
end;

procedure TfraPlanoDeContasMskEdit.MskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  If VS_FuncoesExternas.fiPesqCentroCusto(TForm(Self.Owner), MskCodCta, edtDesCta, Nil, Key, arrPlaContas, True) Then
  Begin
    If THackfrmPai(Self.Owner).fValidaCampos(MskCodCta, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End;
end;

{ THackfrmPai }

function THackfrmPai.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited;
end;

procedure TfraPlanoDeContasMskEdit.OnKeyDownPlaCta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
  Begin
    MskCodCta.Text := TLibCartoesFuncoes.IIF(TLibCartoesFuncoes.fEmptyStr(MskCodCta.Text),MskCodCta.Text,TLibCartoesFuncoes.fGetPlanoDeContas(MskCodCta.Text));
    If THackfrmPai(Self.Owner).fValidaCampos(MskCodCta, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End
  Else If (KEY = VK_ESCAPE) Then
    THackfrmPai(Self.Owner).btnSair.Click;
end;

end.
