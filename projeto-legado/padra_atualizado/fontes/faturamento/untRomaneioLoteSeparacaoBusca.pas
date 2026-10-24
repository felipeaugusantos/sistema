unit untRomaneioLoteSeparacaoBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons;

type
  TfrmRomaneioLoteSeparacaoBusca = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lblDocum: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    intTamDoc : Integer;
    { Private declarations }
  public
    blnConfirma     : Boolean;
    strFiltroNumDoc : String;
    strFiltroEspDoc : String;

    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}


function TfrmRomaneioLoteSeparacaoBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  procedure pFecharTela;
  begin
    strFiltroNumDoc := edtNumDoc.Text;
    strFiltroEspDoc := edtEspDoc.Text;

    blnConfirma := True;
    Close;
  end;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O DOCUMENTO                    *}
    {**************************************JC*}
    If (Sender = edtNumDoc) Then
    Begin
      If (Not fEmptyStr(edtNumDoc.Text)) And (Length(edtNumDoc.Text) >= intTamDoc+3) Then
      Begin
        If (fEhLetra(edtNumDoc.Text[intTamDoc+2])) And
           (fEhLetra(edtNumDoc.Text[intTamDoc+3])) Then
        Begin
          edtEspDoc.Text := Copy(edtNumDoc.Text, intTamDoc+2, 2);
          edtNumDoc.Text := Copy(edtNumDoc.Text, 1, intTamDoc);
          pFecharTela;
        End;
      End
      Else
      If (Not fEmptyStr(edtNumDoc.Text)) Then
        edtNumDoc.Text := fStrZero(edtNumDoc.Text,12);

    End

    {*****************************************}
    {* VALIDA A ESPECIE                      *}
    {**************************************JC*}
    Else If (Sender = edtEspDoc) Then
    Begin
      If (Not fEmptyStr(edtNumDoc.Text)) and (Not fEmptyStr(edtEspDoc.Text)) then
        pFecharTela;
    End;

  End;
end;

procedure TfrmRomaneioLoteSeparacaoBusca.FormCreate(Sender: TObject);
begin
  inherited;
  intTamDoc := fTamDocCadRec;
end;

procedure TfrmRomaneioLoteSeparacaoBusca.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Keybd_Event(VK_F2, 0, 0, 0);

  edtNumDoc.Clear;
  edtEspDoc.Clear;

  pSetFocus(edtNumDoc);

end;

procedure TfrmRomaneioLoteSeparacaoBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strFiltroNumDoc := '';
    strFiltroEspDoc := '';
  End;
end;

end.
