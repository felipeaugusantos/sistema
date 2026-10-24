unit Contabilidade.View.ApuracaoLucroRealLalurLacsPesqCtaCon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Contabilidade.Interfaces;

type
  TfrmApuracaoLucroRealLalurLacsPesqCtaCon = class(TfrmPaiConfirmaContabilidade)
    Label1: TLabel;
    edtCtaCon: TEditFocus;
    edtNomCon: TEditFocus;
    procedure edtCtaConKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FstrContaControlada: string ;
    FllTipo: TLacsLalur ;
  public
    { Public declarations }
    property CodigoContaControlada: string read FstrContaControlada ;
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untTypesSistema, untConsultas ;

{$R *.dfm}

procedure TfrmApuracaoLucroRealLalurLacsPesqCtaCon.btnConfirmaClick(
  Sender: TObject);
begin
  if fEmptyStr(edtCtaCon.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Conta controlada inválida!', ['&Ok']);
    pSetFocus(edtCtaCon);
    exit ;
  end;

  FstrContaControlada := edtCtaCon.Text ;
  inherited;

end;

procedure TfrmApuracaoLucroRealLalurLacsPesqCtaCon.edtCtaConKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCons: TConsultasArray;
  LstrValorTabelaDinamica: string;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    LstrValorTabelaDinamica := iif(FllTipo = llLacs, COD_BASE_CALCULO_NEGATIVA_CSLL, COD_PREJUIZO_FISCAL_OPERACIONAL) ;
    If fPesqContaControlada(Self, edtCtaCon, Nil, Nil, Key, arrCons, True, FllTipo, LstrValorTabelaDinamica) Then
    Begin
      If fValidaCampos(edtCtaCon) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmApuracaoLucroRealLalurLacsPesqCtaCon.FormCreate(Sender: TObject);
begin
  inherited;
  FstrContaControlada := '' ;
end;

procedure TfrmApuracaoLucroRealLalurLacsPesqCtaCon.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Informe uma conta controlada - ' + iif(FllTipo = llLacs, 'LACS', 'LAIR') ;
end;

function TfrmApuracaoLucroRealLalurLacsPesqCtaCon.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  LstrCampoLalurLacs: string ;
  LstrCampoTabelaDinamica, LstrValorTabelaDinamica: string ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCtaCon) Then
    Begin
      if fEmptyStr(edtCtaCon.Text) then
      begin
        edtNomCon.Clear;
        Result := True;
      end
      else
      Begin
        LstrCampoTabelaDinamica := iif(FllTipo = llLacs, 'CTA_TBDBLA', 'CTA_TBDBLU') ;
        LstrValorTabelaDinamica := iif(FllTipo = llLacs, COD_BASE_CALCULO_NEGATIVA_CSLL, COD_PREJUIZO_FISCAL_OPERACIONAL) ;
        LstrCampoLalurLacs := iif(FllTipo = llLacs, 'CTA_GRLACS', 'CTA_GRLALU') ;
        edtNomCon.Text := fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON', LstrCampoLalurLacs, LstrCampoTabelaDinamica], [edtCtaCon.Text, 'S', LstrValorTabelaDinamica], False);
        If (fEmptyStr(edtNomCon.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa conta controlada não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
