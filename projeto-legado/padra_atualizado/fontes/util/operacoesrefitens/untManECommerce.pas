unit untManECommerce;

interface

uses
  Uni, untPanelDadosECommerce,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, clipBrd, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmManECommerce = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    pnlDadosECommerce: TPanel;
    btnConfirma: TBitBtnLocked;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    qryCadIte: TUniQuery;
    qryDesSit: TUniQuery;

    FPanelDadosECommerce: TfrmPanelDadosECommerce;

    procedure pCriafrmPanelDadosECommerce;

    function fCarregaItem(strCodIte : String) : Boolean;
    procedure pLimpaCampos;
    procedure pOnValidouUltimoCampo;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmManECommerce: TfrmManECommerce;

implementation

uses untFuncoesSimples, DB, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmManECommerce.fCarregaItem(strCodIte : String) : Boolean;
  Var
    strSQL: String;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  *      ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE    ';

  If Length(strCodIte) <= fTamCodIte Then
  Begin
    strSQL    := strSQL + '  ITE_CODITE = :CODITE ';
    strCodIte := fStrZero(strCodIte, fTamCodIte);
  End
  Else
  Begin
    strSQL := strSQL + '  (ITE_CODBAR = :CODITE OR ';
    strSQL := strSQL + '   ITE_BAREMB = :CODITE )  ';
  End;

  strSQL := strSQL + '  LIMIT 1 ';

  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If Not IsEmpty Then
      Result := True;

    edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString + ' - ' + FieldByName('ITE_REFERE').AsString;

    FPanelDadosECommerce.pCarregaUrlImagens(FieldByName('ITE_CODITE').AsString);
  end;
end;

procedure TfrmManECommerce.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin
    fPesqItem(conIteSimples, Self, edtCodIte, nil, nil, Key, arrSel,  True, nil, 'Consulta de Itens', '1');
  End;
end;


procedure TfrmManECommerce.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryDesSit := fCriarQuery('SELECT * FROM DESSIT WHERE FALSE', Self);
  pCriafrmPanelDadosECommerce;
end;

procedure TfrmManECommerce.FormDestroy(Sender: TObject);
begin
  inherited;
  pFreeAndNil(FPanelDadosECommerce);
  FreeAndNil(qryCadIte);
  FreeAndNil(qryDesSit);
end;

procedure TfrmManECommerce.edtCodIteExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodIte.Text) Then
  Begin
    If fCarregaItem(edtCodIte.Text) Then
    Begin
      qryCadIte.Edit;
      FPanelDadosECommerce.pCarregaDadosECommerce;
      btnConfirma.Enabled := True;
      blnMudarFoco := False;
      pSetFocus(FPanelDadosECommerce.dbeExpSit);
    End
    Else
    Begin
      fMensagem('AVISO','Não Foi encontrado nenhum item!',['&O K']);

      FPanelDadosECommerce.pCarregaDadosECommerce;
      btnConfirma.Enabled := False;
      pSetFocus(edtCodIte);
    End;
  End
  Else
    pLimpaCampos;

end;

procedure TfrmManECommerce.pLimpaCampos;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  btnConfirma.Enabled := False;
  FPanelDadosECommerce.pLimparCampos;
  FPanelDadosECommerce.pHabilitaEdicao(False);
end;

procedure TfrmManECommerce.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If Not FPanelDadosECommerce.fValidarDadosECommerce Then
  Begin
    Exit;
  End;

  Try
    fStartTransaction;
    FPanelDadosECommerce.pGravaDadosECommerce;
	
    if qryCadIte.State = dsEdit then
      qryCadIte.Post;

    fCommit;

    pSetFocus(edtCodIte);

    pLimpaCampos;

    qryCadIte.Close;


  Except

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManECommerce.btnConfirmaClick]');
    End;

  End;

end;

procedure TfrmManECommerce.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmManECommerce.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) And (btnConfirma.Enabled) Then
  Begin
    btnConfirma.Click;
  End;
end;

function TfrmManECommerce.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmManECommerce.pCriafrmPanelDadosECommerce;
Begin
  Application.CreateForm(TfrmPanelDadosECommerce, FPanelDadosECommerce);
  FPanelDadosECommerce.qryCadIte := qryCadIte;
  FPanelDadosECommerce.qryDesSit := qryDesSit;
  FPanelDadosECommerce.pOnValidouUltimoCampo := pOnValidouUltimoCampo;
  FPanelDadosECommerce.Align := alClient;
  FPanelDadosECommerce.Dock(pnlDadosECommerce, pnlDadosECommerce.BoundsRect);
  FPanelDadosECommerce.show;
End;

procedure TfrmManECommerce.pOnValidouUltimoCampo;
begin
  btnConfirma.Click;
end;

end.

