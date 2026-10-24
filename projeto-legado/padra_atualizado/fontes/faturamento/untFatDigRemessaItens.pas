unit untFatDigRemessaItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus,
  EditFocus;

type
  TfrmFatDigRemessaItens = class(TfrmPaiSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    FlowPanel1: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    edtNumDoc: TEditFocus;
    Label4: TLabel;
    edtDesCliente: TEditFocus;
    edtCodCliente: TEditFocus;
    Label1: TLabel;
    mskDtaFin: TMaskEditFocus;
    lbl3: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl1: TLabel;
    edtDesVen: TEditFocus;
    edtCodVen: TEditFocus;
    Label2: TLabel;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraExit(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmFatDigRemessaItens.btnConfirmaClick(Sender: TObject);
begin
  if fValidaCampos(mskDtaIni, True) then
    if fValidaCampos(mskDtaFin, True) then
      ModalResult := mrOk;
end;

procedure TfrmFatDigRemessaItens.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  if fValidaCampos(edtCodCliente, True) then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatDigRemessaItens.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    if fValidaCampos(edtCodCliente, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigRemessaItens.edtCodTraExit(Sender: TObject);
Var
  arrTra: TConsultasArray;
begin
  inherited;

  pEdtCodSelectExit(edtCodTra, edtNomTra, arrTra, fRetNomTransportadora, Nil, 'da transportadora', 6);

  If fEmptyStr(edtCodTra.Text) Then
    edtNomTra.Clear;
end;

procedure TfrmFatDigRemessaItens.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrTransp : TConsultasArray;
begin
  inherited;

  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigRemessaItens.edtCodVenExit(Sender: TObject);
begin
  inherited;
  if fValidaCampos(edtCodVen, True) then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatDigRemessaItens.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrVendedores: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVendedores) Then
  Begin
    if fValidaCampos(edtCodVen, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigRemessaItens.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

function TfrmFatDigRemessaItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If not fEmptyStr(edtCodCliente.Text) Then
      Begin
        edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);
        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End;
      End;

    End

    Else If (Sender = edtCodVen) Then
    Begin

      If not fEmptyStr(edtCodVen.Text) Then
      Begin
        edtDesVen.Text := fRetNomeOperador(edtCodVen.Text);
        If fEmptyStr(edtDesVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Vendedor não cadastrado!', ['&Ok']);
          Result := FALSE;
        End;
      End;

    End

    Else If (Sender = edtCodTra) Then
    Begin

      If Not fEmptyStr(edtCodTra.Text) Then
      Begin
        edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
        If fEmptyStr(edtNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transportadora não cadastrada!', ['&Ok']);
          Result := FALSE;
        End;
      End;

    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
