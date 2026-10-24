unit untBaixaBusca;

interface

uses
  Controls, Forms,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmBaixaBusca = class(TfrmPaiSimples)
    edtNumDup: TEditFocus;
    Label1: TLabel;
    edtNosNum: TEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    Label3: TLabel;
    edtCodVel: TEditFocus;
    lblCliFor: TLabel;
    edtCliFor: TEditFocus;
    lbl1: TLabel;
    edtValDup: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtValDupExit(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
    strTipGer     : String;
  end;


implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaBusca }

function TfrmBaixaBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A DUPLICATA                    *}
    {**************************************MV*}
    If (Sender = edtNumDup) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O NOSSO NUMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtNosNum) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O NUMERO ANTIGO DA DUPL        *}
    {**************************************MV*}
    Else If (Sender = edtCodVel) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O COD DO CLIENTE/FORNECEDOR    *}
    {**************************************MV*}
    Else If (Sender = edtCliFor) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O VALOR DA DUPLICATA           *}
    {**************************************MV*}
    Else If (Sender = edtValDup) Then
    Begin

      If Not fEmptyStr(edtNosNum.Text) Then
      Begin
        strCampoFiltro := 'CTR_NOSNUM';
        strValorFiltro := edtNosNum.Text;
      End
      Else If Not fEmptyStr(edtNumDup.Text) Then
      Begin
        If strTipGer = 'P' Then
          strCampoFiltro := 'CTP_NUMDUP'
        Else
          strCampoFiltro := 'CTR_NUMDUP';

        strValorFiltro := edtNumDup.Text;
      End
      Else If Not fEmptyStr(edtCodVel.Text) Then
      Begin
        If strTipGer = 'P' Then
          strCampoFiltro := 'CTP_CODVEL'
        Else
          strCampoFiltro := 'CTR_CODVEL';

        strValorFiltro := edtCodVel.Text;
      End
      Else If Not fEmptyStr(edtCliFor.Text) Then
      Begin
        If strTipGer = 'P' Then
          strCampoFiltro := 'CTP_CODFOR'
        Else
          strCampoFiltro := 'CTR_CODCLI';

        strValorFiltro := edtCliFor.Text;
      End
      Else If Not fEmptyStr(edtValDup.Text) Then
      Begin
        If strTipGer = 'P' Then
          strCampoFiltro := 'CTP_VALDUP'
        Else
          strCampoFiltro := 'CTR_VALDUP';

        strValorFiltro := edtValDup.Text;
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

procedure TfrmBaixaBusca.edtValDupExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtValDup.Text) Then
    edtValDup.Text := FormatFloat('#,##0.00', fStrToFloat(edtValDup.Text));
end;

procedure TfrmBaixaBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmBaixaBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TfrmBaixaBusca.FormShow(Sender: TObject);
begin
  inherited;

  If strTipGer = 'P' Then
  Begin
    lblCliFor.Caption := 'Fornecedor';
    edtNosNum.Enabled := FALSE;
  End Else
    lblCliFor.Caption := 'Cliente';


end;

end.


