unit untRelDigDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, Uni, BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade;

type
  TfrmRelDigDocumento = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlDados: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strAutInc: String;
    strNumDoc: String;
    strEspDoc: String;
    blnConfirma : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

function TfrmRelDigDocumento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEspDoc) Then
    Begin

      If fEmptyStr(edtEspDoc.Text) Or (Pos(edtEspDoc.Text, 'OR_PD_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ser OR ou PD!', ['&O k']);
        Result := False;
      End

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelDigDocumento.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelDigDocumento.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryFatGor: TUniQuery;
    arrDoc: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    {*******************************}
    {* NOVA CONSULTA DE DOCUMENTOS *}
    {****************************RV*}

    qryFatGor := fCriaQuery(Self);

    If fPesqPedOrc(conPedDigDoc, Self, edtEspDoc.Text, edtEspDoc.Text, VS_strCodEmp, edtNumDoc, Nil, Nil, qryFatGor, Key, arrDoc) Then
    Begin
      strAutInc := qryFatGor.FieldByName('AUTOINCREM').AsString;
      If fValidaCampos(edtNumDoc, True) Then
        SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryFatGor);
  End;
end;

procedure TfrmRelDigDocumento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNumDoc.Text) Then
  Begin
    fMensagem('', 'Escolha um Documento para alterar!', ['&O k']);
    pSetFocus(edtNumDoc);
  End
  Else
  Begin
    strNumDoc   := edtNumDoc.Text;
    strEspDoc   := edtEspDoc.Text;
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmRelDigDocumento.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmRelDigDocumento.FormShow(Sender: TObject);
begin
  inherited;
  strAutInc   := EmptyStr;
  strNumDoc   := EmptyStr;
  strEspDoc   := EmptyStr;
  blnConfirma := False;

  pSetFocus(edtNumDoc);
end;

end.
