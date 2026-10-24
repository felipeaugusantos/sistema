unit untSelEmpPrecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, untFuncoesSimples, untConsultas, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCustomListBox, cxCheckListBox,
  untTabelaPreco, Vcl.CheckLst;

Type
  TfrmSelEmpPrecos = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    lbl1: TLabel;
    edtEmpOri: TEditFocus;
    edtNomOri: TEditFocus;
    lbl2: TLabel;
    edtEmpDes: TEditFocus;
    edtNomDes: TEditFocus;
    Label1: TLabel;
    cklCampos: TCheckListBox;
    procedure edtEmpOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpOriExit(Sender: TObject);
    procedure edtEmpDesExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrEmpOri : TConsultasArray;

    procedure pInicializaListaCampos;
    Function fTemCamposMarcados: Boolean;
    procedure pMarcaCamposParaCopiar;
    Function fGetCampoDaLista(strDescricao: String): String;

  public
    { Public declarations }
    arrEmpDes : TConsultasArray;
    objTabPre: TTabelaPreco;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmSelEmpPrecos: TfrmSelEmpPrecos;

implementation

{$R *.dfm}

Uses
  untFuncoesConsulta;

procedure TfrmSelEmpPrecos.edtEmpDesExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtEmpDes, edtNomDes, arrEmpDes, Nil, fRetNomeEmpresaSelec, 'da empresa destino');

end;

procedure TfrmSelEmpPrecos.edtEmpDesKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtEmpDes, edtNomDes, Nil, Key, arrEmpDes, False) Then
  Begin
    If fValidaCampos(edtEmpDes) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelEmpPrecos.edtEmpOriExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtEmpOri, edtNomOri, arrEmpOri, Nil, fRetNomeEmpresaSelec, 'da empresa origem');

end;

procedure TfrmSelEmpPrecos.edtEmpOriKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtEmpOri, edtNomOri, Nil, Key, arrEmpOri) Then
  Begin
    If fValidaCampos(edtEmpOri) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelEmpPrecos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If (Not fVerificaCampos) Or
       (Not fTemCamposMarcados) Then
    Begin
      Action := caNone;
      Exit;
    End;

    pMarcaCamposParaCopiar;
  End;

end;

Function TfrmSelEmpPrecos.fTemCamposMarcados: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;
  For intContador := 0 To cklCampos.Count - 1 Do
    If cklCampos.Checked[intContador] Then
    Begin
      Result := True;
      Break;
    End;

  If Not Result Then
    pMensagemOk('Selecione os campos que deseja copiar!');
End;

procedure TfrmSelEmpPrecos.pMarcaCamposParaCopiar;
  Var
    intContador: Integer;
Begin
  objTabPre.stlCamposParaCopiar.Clear;

  For intContador := 0 To cklCampos.Count - 1 Do
    If cklCampos.Checked[intContador] Then
      objTabPre.stlCamposParaCopiar.Add(fGetCampoDaLista(cklCampos.Items[intContador]));
End;

Function TfrmSelEmpPrecos.fGetCampoDaLista(strDescricao: String): String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := Low(objTabPre.arrDisplayRecPrecos) To High(objTabPre.arrDisplayRecPrecos) Do
    If SameText(objTabPre.arrDisplayRecPrecos[intContador], strDescricao) Then
    Begin
      Result := TArrCamposRecPrecos[intContador];
      Break;
    End;

End;

procedure TfrmSelEmpPrecos.FormShow(Sender: TObject);
begin
  inherited;

  pInicializaListaCampos;

  pSetFocus(edtEmpOri);
end;

procedure TfrmSelEmpPrecos.pInicializaListaCampos;
  Var
    intContador: Integer;
Begin
  For intContador := Low(objTabPre.arrDisplayRecPrecos) To High(objTabPre.arrDisplayRecPrecos) Do
    If (Pos(TArrCamposRecPrecos[intContador], 'ITE_TCIFCU-ITE_TSCUST-ITE_DEPICP-ITE_DEICMS-ITE_FATREG') > 0) Then
    Begin
      If objTabPre.blnSufram And (objTabPre.strFrmCus = '4') Then
        cklCampos.Items.Add(objTabPre.arrDisplayRecPrecos[intContador]);
    End
    Else
      cklCampos.Items.Add(objTabPre.arrDisplayRecPrecos[intContador]);

  cklCampos.CheckAll(cbChecked);
End;

function TfrmSelEmpPrecos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEmpOri) Then
    Begin

      If (fEmptyStr(edtEmpOri.Text)) Then
      Begin
        edtNomOri.Clear;
        pMensagemOk('Informe o código da empresa origem!');
        Result := False;
      End Else
      Begin
        edtNomOri.Text := fRetNomeEmpresaSelec(edtEmpOri.Text);
        If fEmptyStr(edtNomOri.Text) Then
        Begin
          pMensagemOk('Empresa não encontrada!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtEmpDes) Then
    Begin

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
