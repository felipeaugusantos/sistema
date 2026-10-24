unit untLiberacaoPedidosExternosObs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, MemoFocus, EditFocus,
  dxGDIPlusClasses, QColorLabel, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmLiberacaoPedidosExternosObs = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlRodape: TPanel;
    btnConfirma: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    pnlTopo: TPanel;
    lblDigita: TLabel;
    lblObs: TColorLabel;
    imgSetaBaixo: TImage;
    Image1: TImage;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    rdbNega: TRadioButton;
    rdbLibera: TRadioButton;
    pnlObsAnt: TPanel;
    ColorLabel1: TColorLabel;
    memObsAnt: TMemoFocus;
    memObs: TMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    qryConOpe : TUniQuery;
    procedure pCarregaDigitador;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma : Boolean;
    strCodDig   : String;
    strNomDig   : String;
  end;

var
  frmLiberacaoPedidosExternosObs: TfrmLiberacaoPedidosExternosObs;

implementation

uses
  untFuncoesSimples, untPesqAux;

{$R *.dfm}

{ TfrmLiberacaoPedidosExternosObs }

procedure TfrmLiberacaoPedidosExternosObs.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmLiberacaoPedidosExternosObs.btnConfirmaClick(Sender: TObject);
begin

  inherited;

  If (Not fValidaCampos(edtSenDig, True)) Then
  Begin
    Exit;
  End;

  blnConfirma := True;
  Close;

end;

procedure TfrmLiberacaoPedidosExternosObs.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma       := False;
  rdbLibera.Checked := True;
end;

procedure TfrmLiberacaoPedidosExternosObs.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else
  If (Key = VK_ESCAPE) Then
  Begin
    btnCancela.Click;
  End;

end;

procedure TfrmLiberacaoPedidosExternosObs.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(memObs);
end;

function TfrmLiberacaoPedidosExternosObs.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) And (edtSenDig.Enabled) Then
    Begin

      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
        pCarregaDigitador;

        If qryConOpe.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End;

    End

  End;

end;

procedure TfrmLiberacaoPedidosExternosObs.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);
  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
    strCodDig := FieldByName('OPE_CODOPE').AsString;
    strNomDig := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

end.
