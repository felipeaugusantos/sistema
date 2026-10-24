unit untFiltroEtiFuncionarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls;

type
  TfrmFiltroEtiFuncionarios = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    edtNomIni: TEditFocus;
    edtNomFin: TEditFocus;
    edtQtdEti: TEditFocus;
    chkMosFil: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;

    strNomIni: String;
    strNomFin: String;
    intQtdEti: Integer;
  end;

var
  frmFiltroEtiFuncionarios: TfrmFiltroEtiFuncionarios;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFiltroEtiFuncionarios.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  
end;

function TfrmFiltroEtiFuncionarios.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*****************************************}
    {* VALIDA O NOME INICIAL                 *}
    {**************************************MV*}
    If (Sender = edtNomIni) Then
    Begin
      If fEmptyStr(edtNomIni.Text) Then
      Begin
        edtNomFin.Enabled := False;
      End
      Else
      Begin
        edtNomFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O NOME FINAL                   *}
    {**************************************MV*}
    Else If (Sender = edtNomFin) Then
    Begin

      If edtNomIni.Text > edtNomFin.Text Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MV*}
    Else If (Sender = edtQtdEti) Then
    Begin

      If fEmptyStr(edtQtdEti.Text) Then
      Begin
        Result := False;
      End
      Else
      Begin
        If fMensagem('', 'Confirma dados do filtro?', ['&Sim', '&Não']) = 1 Then
        Begin
          blnConfirma := True;

          strNomIni := edtNomIni.Text;
          strNomFin := edtNomFin.Text;
          intQtdEti := StrToInt(edtQtdEti.Text);

          Close;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
