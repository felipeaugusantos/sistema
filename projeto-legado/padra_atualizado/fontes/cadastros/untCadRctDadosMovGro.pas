unit untCadRctDadosMovGro;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Uni, BitBtnLockedIncrem, frxClass, SysUtils,
  frxExportCSVTestabilidade, untFuncFatTypes, Faturamento.Classes.TFatVendaBase;

type
  TfrmCadRctDadosMovGro = class(TfrmPai)
    pnlGeral: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    lbl1: TLabel;
    edtNotFis: TEditFocus;
    mskDtaNot: TMaskEditFocus;
    lbl2: TLabel;
    lbl3: TLabel;
    edtNroRec: TEditFocus;
    lbl4: TLabel;
    edtCodRes: TEditFocus;
    edtNomRes: TEditFocus;
    lbl5: TLabel;
    mskDtaEmi: TMaskEditFocus;
    edtInfAdd: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    pnlDadosFazenda: TPanel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodResKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtNotFisExit(Sender: TObject);
  private
    function fSelecionarFazendaCliente(strCodCliente: String): Boolean;
    procedure pMostrarDadosFazendaRodape(blnExibir: Boolean);
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objFazenda: TDadosFazenda;
  end;


implementation

uses untFuncoesSimples, Forms, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadRctDadosMovGro.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmCadRctDadosMovGro.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If Not fSelecionarFazendaCliente(edtCodCli.Text) Then
    pSetFocus(edtCodCli);
end;

procedure TfrmCadRctDadosMovGro.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCliente: TConsultasArray;
Begin
  {****************************}
  {* NOVA CONSULTA DE CLIENTE *}
  {*************************IV*}
  If fEntraCons(Key) Then
  Begin
    If fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadRctDadosMovGro.edtCodResKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrResp: TConsultasArray;
Begin
  {****************************}
  {* NOVA CONSULTA DE RESPONS *}
  {*************************IV*}
  If fEntraCons(Key) Then
  Begin
    If fPesqDiversos(Self, edtCodRes, edtNomRes, Nil, Key, arrResp) Then
    Begin
      If fValidaCampos(edtCodRes, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadRctDadosMovGro.edtNotFisExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtNotFis.Text)) Then
    edtNotFis.Text := fStrZero(edtNotFis.Text, edtNotFis.TamCampo);
end;

procedure TfrmCadRctDadosMovGro.FormCreate(Sender: TObject);
begin
  inherited;
  objFazenda := TDadosFazenda.Create;
  objFazenda.pLimparDadosFazenda;
  pMostrarDadosFazendaRodape(False);
end;

procedure TfrmCadRctDadosMovGro.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objFazenda) Then
     FreeAndNil(objFazenda);
end;

function TfrmCadRctDadosMovGro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodCli) Then
  Begin

    If fEmptyStr(edtCodCli.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o cliente!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este cliente não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = edtCodRes) Then
  Begin

    If fEmptyStr(edtCodRes.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o responsável!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      edtNomRes.Text := fRetNomDiversos(edtCodRes.Text);
      If fEmptyStr(edtNomRes.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este responsável não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = edtNotFis) Then
  Begin

    If fEmptyStr(edtNotFis.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar o número da Nota Fiscal!', ['&O k']);
      Result := False;
    End;

  End
  Else If (Sender = mskDtaNot) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaNot.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar a Data da Nota Fiscal!', ['&O k']);
      Result := False;
    End;

    If Result Then
      Try
        mskDtaNot.Text := DateToStr(StrToDate(mskDtaNot.Text));
      Except
      End;

  End
  Else If (Sender = mskDtaEmi) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaEmi.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar a Data de Emissão!', ['&O k']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadRctDadosMovGro.fSelecionarFazendaCliente(strCodCliente: String): Boolean;
begin
  Result := True;

  objFazenda.strCodCli := strCodCliente;

  If objFazenda.fClientePossuiFazendas And fCfgSis('CADFAZ', VarBoolean) Then
  Begin
    Result := objFazenda.fSelecionarFazenda;

    If Not Result Then
      objFazenda.pLimparDadosFazenda;
  End
  Else
    objFazenda.pLimparDadosFazenda;

  pMostrarDadosFazendaRodape(Result);
end;

procedure TfrmCadRctDadosMovGro.pMostrarDadosFazendaRodape(blnExibir: Boolean);
begin
  blnExibir := blnExibir And Not fEmptyStr(objFazenda.strCodFaz);

  If Not blnExibir Then
  Begin
    pnlDadosFazenda.Visible := False;
    pnlDadosFazenda.Caption := '';
  End
  Else
  Begin
    pnlDadosFazenda.Visible := True;
    pnlDadosFazenda.Caption := 'FAZENDA: ' + objFazenda.strCodFaz  + ' - ' +
                                             objFazenda.strNomFaz  + ' - ' +
                                        Trim(objFazenda.strEndere  + ' '   +
                                             objFazenda.strEndNum  + ' '   +
                                             objFazenda.strEndCom) + ' - ' +
                                             objFazenda.strBairro  + ' - ' +
                                             objFazenda.strNomCid  + ' - ' +
                                             objFazenda.strEstado  ;
  End;

end;

end.
