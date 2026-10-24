unit untRcxConfCupomBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, StrUtils, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxConfCupomBusca = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    mskDtaEnt: TMaskEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtNomCli: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma   : Boolean;
    strValorFiltro: String;
    strCampoFiltro: String;
  end;

var
  frmRcxConfCupomBusca: TfrmRcxConfCupomBusca;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmRcxConfCupomBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  strValorFiltro := '';
  strCampoFiltro := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O DOCUMENTO                    *}
    {**************************************MV*}
    If (Sender = edtNumDoc) Then
    Begin

      If Not fEmptyStr(edtNumDoc.Text) Then
      Begin
        strCampoFiltro := 'GER_NUMDOC';
        strValorFiltro := edtNumDoc.Text;
        blnConfirma := True;
        Close;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA DE ENTRADA              *}
    {**************************************MV*}
    Else If (Sender = mskDtaEnt) Then
    Begin

      If Not fEmptyStr( Trim( AnsiReplaceStr( mskDtaEnt.Text, '/', '' ) ) ) Then
      Begin
        strCampoFiltro := 'GER_DTAENT';
        strValorFiltro := mskDtaEnt.Text;
        blnConfirma := True;
        Close;
      End;

    End

    {*****************************************}
    {* VALIDA NOME DO CLIENTE                *}
    {**************************************MV*}
    Else If (Sender = edtNomCli) Then
    Begin

      If Not fEmptyStr(edtNomCli.Text) Then
      Begin
        strCampoFiltro := 'GER_NOMCLI';
        strValorFiltro := edtNomCli.Text;
        blnConfirma := True;
        Close;
      End;

    End

  End;

end;

procedure TfrmRcxConfCupomBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

end;

procedure TfrmRcxConfCupomBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;

end;

procedure TfrmRcxConfCupomBusca.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);

end;

procedure TfrmRcxConfCupomBusca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    blnConfirma := False;
    frmRcxConfCupomBusca.Close;

  End;

end;

end.

