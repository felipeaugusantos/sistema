unit untBuscaCodFabrica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TFrmBuscaCodFabrica = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodFab: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strValorFiltro: String;
    strCampoFiltro: String;
    { Public declarations }
  end;

var
  FrmBuscaCodFabrica: TFrmBuscaCodFabrica;

implementation

uses untfuncoesSimples;

{$R *.dfm}
function TFrmBuscaCodFabrica.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NOSSO NUMERO                 *}
    {**************************************JB*}
    If (Sender = edtCodFab) Then
    Begin
      If Not fEmptyStr(edtCodFab.Text) Then
      Begin
        strCampoFiltro := 'ITE_CODFAB';
        strValorFiltro := edtCodFab.Text;
      End
      Else
      Begin
        strValorFiltro := '';
        strCampoFiltro := '';
      End;
      blnConfirma := True;
      Close;
    End

  End;
End;

procedure TFrmBuscaCodFabrica.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

end;

procedure TFrmBuscaCodFabrica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TFrmBuscaCodFabrica.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodFab);
end;

end.


