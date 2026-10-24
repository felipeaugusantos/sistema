unit untConfOrdProdFiltros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, DateUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, untTypesSistema;

type
  TfrmConfOrdProdFiltros = class(TfrmPai)
    lblCodBar: TLabel;
    lblDtaCad: TLabel;
    lblCodIte: TLabel;
    lblCodCor: TLabel;
    lblPedRes: TLabel;
    edtCodBar: TEditFocus;
    mskDtaCad: TMaskEditFocus;
    edtCodCor: TEditFocus;
    edtDesCor: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtPedRes: TEditFocus;
    btnConfirma: TBitBtnLocked;
    shpMultSel: TShape;
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCorExit(Sender: TObject);
    procedure edtCodCorKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodBarExit(Sender: TObject);
  private
    { Private declarations }
    arrCodIte : TConsultasArray;
    arrCodCor : TConsultasArray;

    procedure pInicializarVarFiltros;
    procedure pLimparVarFiltros;
  public
    { Public declarations }
    strCodBar: String;
    strCodIte: String;
    strCodCor: String;
    strPedRes: String;
    dteDtaCad: TDateTime;

    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean; override;
  end;

var
  frmConfOrdProdFiltros: TfrmConfOrdProdFiltros;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFuncoesConsulta;

procedure TfrmConfOrdProdFiltros.btnSairClick(Sender: TObject);
begin
  inherited;

  pInicializarVarFiltros();

  btnSair.Click();
end;

procedure TfrmConfOrdProdFiltros.edtCodBarExit(Sender: TObject);
  Var
    strTemp: String;
begin
  inherited;

  If (Not fEmptyStr(edtCodBar.Text)) Then Begin
    strTemp := fCampoTabela('AUTOINCREM', 'ORDGER', ['ORD_CODBAR'], [edtCodBar.Text]);

    If (Not fEmptyStr(strTemp)) Then Begin
      pInicializarVarFiltros();

      mskDtaCad.Text := '  /  /    ';
      edtCodIte.Text := '';
      edtDesIte.Text := '';
      edtCodCor.Text := '';
      edtDesCor.Text := '';
      edtPedRes.Text := '';

      btnSair.Click();
    End Else Begin
      fMensagem('ATENÇÃO!', 'Código de barras é inválido!', ['&OK']);
      pSetFocus(edtCodBar);
    End;
  End;
end;

procedure TfrmConfOrdProdFiltros.edtCodCorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCor, edtDesCor, arrCodCor, fRetNomCor, Nil, 'da Cor');
end;

procedure TfrmConfOrdProdFiltros.edtCodCorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCores(Self, edtCodCor, edtDesCor, Nil, Key, arrCodCor, False) Then Begin
    If fValidaCampos(edtCodCor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfOrdProdFiltros.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrCodIte, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmConfOrdProdFiltros.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrCodite, False, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfOrdProdFiltros.FormCreate(Sender: TObject);
begin
  inherited;

  pLimparVarFiltros();
end;

procedure TfrmConfOrdProdFiltros.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodBar);
end;

function TfrmConfOrdProdFiltros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If Sender = edtCodIte Then Begin
      pDesmarcaLista(edtCodIte, arrCodIte);
    End

    Else If Sender = edtCodCor Then Begin
      pDesmarcaLista(edtCodCor, arrCodCor);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfOrdProdFiltros.pInicializarVarFiltros;
  Var
    i: Integer;
begin
  pLimparVarFiltros();

  blnConfirma := True;

  strCodBar := edtCodBar.Text;
  strPedRes := edtPedRes.Text;

  For i := 0 To Length(arrCodIte) - 1 Do Begin
    strCodIte := strCodIte + arrCodIte[i].strCodigo + ', ';
  End;

  For i := 0 To Length(arrCodCor) - 1 Do Begin
    strCodCor := strCodCor + arrCodCor[i].strCodigo + ', ';
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCad.Text))) Then
    dteDtaCad := StrToDate(mskDtaCad.Text);
end;

procedure TfrmConfOrdProdFiltros.pLimparVarFiltros;
begin
  blnConfirma := False;
  strCodBar   := '';
  strCodIte   := '';
  strCodCor   := '';
  strPedRes   := '';
  dteDtaCad   := 0;
end;

end.
