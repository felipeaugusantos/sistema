unit untBuscaCheques;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, MaskEditFocus, AppEvnts, BitBtnLockedIncrem, Mask, frxClass,
  frxExportCSVTestabilidade;

type
  TFrmBuscaCheques = class(TfrmPai)
    pnlFundo: TPanel;
    lblDtaFil: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    edtNumCheque: TEditFocus;
    edtValorCheque: TEditFocus;
    edtDtaCad: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtValorChequeExit(Sender: TObject);
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


implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}
function TfrmBuscaCheques.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A DUPLICATA                    *}
    {**************************************MV*}
    If (Sender = edtNumCheque) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O NOSSO NUMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtDtaCad) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O NOSSO NUMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtValorCheque) Then
    Begin
      If Not fEmptyStr(edtNumCheque.Text) Then
      Begin
        strCampoFiltro := 'CHQ_NUMCHQ';
        strValorFiltro := edtNumCheque.Text;
      End
      Else If Not fEmptyStr(fTiraCaracEspeciais(edtDtaCad.Text)) Then
      Begin
        strCampoFiltro := 'CHQ_DTACAD';
        strValorFiltro := FormatDateTime('dd/mm/yyyy',StrToDate(edtDtaCad.Text));
      End
      Else If Not fEmptyStr(edtValorCheque.Text) Then
      Begin
        strCampoFiltro := 'CHQ_VALCHQ';
        strValorFiltro := edtValorCheque.Text;
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

procedure TFrmBuscaCheques.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

end;

procedure TFrmBuscaCheques.edtValorChequeExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtValorCheque.Text) Then
    edtValorCheque.Text := FormatFloat('#,##0.00', fStrToFloat(edtValorCheque.Text));
end;

procedure TFrmBuscaCheques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TFrmBuscaCheques.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumCheque);
end;

end.

