unit untConsultaOcorrenciaCrmBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, BitBtnLockedIncrem;

type
  TfrmConsultaOcorrenciaCrmBusca = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    edtCodGoc: TEditFocus;
    edtCodToc: TEditFocus;
    edtProtoc: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDtaOco: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
  end;

var
  frmConsultaOcorrenciaCrmBusca: TfrmConsultaOcorrenciaCrmBusca;

implementation

uses  untFuncoesSimples; 

{$R *.dfm}

{ TfrmConsultaOcorrenciaCrmBusca }

procedure TfrmConsultaOcorrenciaCrmBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TfrmConsultaOcorrenciaCrmBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pSetFocus(edtCodGoc);
end;

function TfrmConsultaOcorrenciaCrmBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O GRUPO DA OCORRÊNCIA          *}
    {**************************************MV*}
    If (Sender = edtCodGoc) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O TIPO DA OCORRÊNCIA           *}
    {**************************************MV*}
    Else If (Sender = edtCodToc) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O PROTOCOLO DA OCORRÊNCIA      *}
    {**************************************MV*}
    Else If (Sender = edtProtoc) Then
    Begin

    End

    {*****************************************}
    {* VALIDA A DATA DA OCORRÊNCIA           *}
    {**************************************MV*}
    Else If (Sender = edtDtaOco) Then
    Begin

      If Not fEmptyStr(edtCodGoc.Text) Then
      Begin
        strCampoFiltro := 'GOC_CODGOC';
        strValorFiltro := edtCodGoc.Text;
      End
      Else If Not fEmptyStr(edtCodToc.Text) Then
      Begin
        strCampoFiltro := 'OCO_CODTOC';
        strValorFiltro := edtCodToc.Text;
      End
      Else If Not fEmptyStr(edtProtoc.Text) Then
      Begin
        strCampoFiltro := 'OCO_PROTOC';
        strValorFiltro := edtProtoc.Text;
      End
      Else If Not fEmptyStr(edtDtaOco.Text) Then
      Begin
        strCampoFiltro := 'OCO_DTAINC';
        strValorFiltro := edtDtaOco.Text;
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
end;

end.
