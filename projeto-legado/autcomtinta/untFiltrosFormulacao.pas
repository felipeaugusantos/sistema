unit untFiltrosFormulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, ComboBoxFocus, untTypesSistema;

type
  TfrmFiltrosFormulacao = class(TfrmPaiConfirma)
    pnlOpcoes: TPanel;
    pnlFundo: TPanel;
    Label4: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    lblDocFat: TLabel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtNumDoc: TEditFocus;
    edtDocFat: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    arrSelIte: TConsultasArray;
    arrCodCli: TConsultasArray;
    FCodCli,
    FCodIte,
    FNumDoc,
    FDocFat,
    FDtaIni: String;
    blnDocFat: Boolean;
  end;

var
  frmFiltrosFormulacao: TfrmFiltrosFormulacao;

implementation

{$R *.dfm}

uses untObservacao, untFuncoesSimples, untConsultas, untFuncoes,
  untFuncoesConsulta;

{ TfrmFiltrosFormulacao }

procedure TfrmFiltrosFormulacao.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrSelIte, nil, fRetNomProduto,'do Produto');
end;

procedure TfrmFiltrosFormulacao.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSelIte, False, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFiltrosFormulacao.btnConfirmaClick(Sender: TObject);
begin
  FCodCli := edtCodCli.Text;
  FCodIte := edtCodIte.Text;
  FNumDoc := edtNumDoc.Text;
  FDocFat := edtDocFat.Text;
  FDtaIni := mskDtaIni.Text;
  modalResult := mrOk;
  inherited;
end;


procedure TfrmFiltrosFormulacao.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, nil, fRetNomCliente, 'do cliente' )
end;

procedure TfrmFiltrosFormulacao.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, Nil, Nil, Key, arrCodCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFiltrosFormulacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

procedure TfrmFiltrosFormulacao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  FCodCli := '';
  FCodIte := '';
  FNumDoc := '';
  FDocFat := '';
  FDtaIni := '';
  blnDocFat := True;
end;

procedure TfrmFiltrosFormulacao.FormShow(Sender: TObject);
begin
  inherited;
  lblDocFat.Visible := blnDocFat;
  edtDocFat.Visible := blnDocFat;
  pSetaCodIte(edtCodIte);
end;

function TfrmFiltrosFormulacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      pDesmarcaLista(edtCodIte,arrSelIte);
    End

    Else If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCodCli);
    End

    Else If (Sender = mskDtaIni) Then
    Begin
      If Not fEmptyDate(mskDtaIni.Text) Then
      Begin
        mskDtaIni.Text := DateToStr(StrToDateDef(mskDtaIni.Text, 0 ));
        If StrToDateDef(mskDtaIni.Text, 0 ) <= 0 Then
          mskDtaIni.Clear;
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


end.
