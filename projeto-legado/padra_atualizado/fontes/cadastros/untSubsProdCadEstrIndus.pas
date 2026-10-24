unit untSubsProdCadEstrIndus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Uni, EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmSubsProdCadEstrIndus = class(TfrmPai)
    pnlGeral: TPanel;
    grbProdSel: TGroupBox;
    grbProdSubs: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtProSubRef: TEditFocus;
    edtProSubUni: TEditFocus;
    Label4: TLabel;
    edtProSel: TEditFocus;
    edtDesProSel: TEditFocus;
    edtProSub: TEditFocus;
    edtDesProSub: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtProSubKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryConIte:TUniQuery;

    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

implementation

uses untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;

{$R *.dfm}

procedure TfrmSubsProdCadEstrIndus.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmSubsProdCadEstrIndus.edtProSubKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtProSub, edtDesProSub, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False,False,'',True) then
      Begin
//        SelectNext(ActiveControl, True, True);
//        pCarregaSubProduto(qryConIte);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmSubsProdCadEstrIndus.edtProSubKeyPress]');
      End;
    End;
  End;
end;

procedure TfrmSubsProdCadEstrIndus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConIte);
end;

procedure TfrmSubsProdCadEstrIndus.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProSub);
  blnConfirma := False;
end;

procedure TfrmSubsProdCadEstrIndus.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If btnConfirma.Enabled Then
    Case Key Of
      VK_F10:btnConfirma.Click;
    End;
end;

procedure TfrmSubsProdCadEstrIndus.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  psetfocus(edtProSub);
end;

function TfrmSubsProdCadEstrIndus.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtProSub) Then
    Begin

      If fEmptyStr(edtProSub.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o código do produto para substituição!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaSubProduto(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do produto para substituição não encontrado!',['&O K']);
          Result := False;
        End
        Else
          btnConfirma.Enabled := Not fEmptyStr(edtProSub.Text);
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmSubsProdCadEstrIndus.pCarregaSubProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProSub.Text, '', False, False, True, True, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProSub.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtProSubRef.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtProSubUni.Text := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;
end;

end.

