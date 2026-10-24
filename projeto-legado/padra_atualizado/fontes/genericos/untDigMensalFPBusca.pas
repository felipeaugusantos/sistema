unit untDigMensalFPBusca;

interface

uses
  Controls, Forms,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigMensalFPBusca = class(TfrmPaiSimples)
    edtNomFun: TEditFocus;
    Label1: TLabel;
    pnlFundo: TPanel;
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
    strTipGer     : String;
  end;

var
  frmDigMensalFPBusca: TfrmDigMensalFPBusca;

implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmDigMensalFPBusca }

function TfrmDigMensalFPBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNomFun) Then
    Begin

      If Not fEmptyStr(edtNomFun.Text) Then
      Begin
        strCampoFiltro := 'FUN_NOMFUN';
        strValorFiltro := edtNomFun.Text;
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

procedure TfrmDigMensalFPBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigMensalFPBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

end.


