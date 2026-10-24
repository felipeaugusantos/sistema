unit untSelItensVendasParaPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, Vcl.Mask, DB,
  MaskEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untConsultas,
  untTypesSistema, untFuncoesConsulta,untFuncoesSimples, Uni,untZClient;

type
  TfrmSelItensVendasParaPedidoCompra = class(TfrmPaiConfirma)
    mskDtaEntIni: TMaskEditFocus;
    Label12: TLabel;
    mskDtaEntFin: TMaskEditFocus;
    Label13: TLabel;
    Label10: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    lblEmpresa: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label1: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label2: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label15: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    arrLinFor,
    arrLinGru,
    arrClientes,
    arrVended,
    arrGruCmp,
    arrLinMar,
    arrEmpresas: TConsultasArray;

    strLinVen,
    strLinFor,
    strLinMar,
    strLinGru,
    strGruCmp,
    strLinCli,
    strCodEmp: String;

    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fGetSQL(qryDados: TUniQuery): String;

  public
    { Public declarations }
    cdsItens: TZClient;
    blnConfirma: Boolean;
    class function fSelecionaItens: TfrmSelItensVendasParaPedidoCompra;
  end;

var
  frmSelItensVendasParaPedidoCompra: TfrmSelItensVendasParaPedidoCompra;

implementation

{$R *.dfm}

{ TfrmPaiConfirma1 }

procedure TfrmSelItensVendasParaPedidoCompra.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
    blnConfirma := True;

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresas, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresas, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do Cliente');

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    fValidaCampos(edtCodCliente, True);
    SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVended, fRetNomeOperador, Nil, 'do Vendedor');

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqOperador(Self, edtCodVen, edtDesVen, nil, Key, arrVended, False) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin

  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca');

end;

procedure TfrmSelItensVendasParaPedidoCompra.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmSelItensVendasParaPedidoCompra.fGetSQL(qryDados: TUniQuery): String;
begin
{}
  qryDados.SQL.Clear;
  qryDados.SQL.Add('SELECT DET_CODITE, SUM(DET_QTDITE) AS DET_QTDITE FROM MOVDET');
  qryDados.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ');
  qryDados.SQL.Add(' WHERE DET_ORIDOC = "V" ');
  qryDados.SQL.Add('   AND DET_CLAFIS > "5000" ');
  qryDados.SQL.Add('   AND DET_TIP_FC = "C" ');
  qryDados.SQL.Add('   AND LOCATE(DET_CLAFIS, "' + VS_strClaVen + '") > 0 ');
  qryDados.SQL.Add('   AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ');
  qryDados.SQL.Add('   AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ');
  qryDados.SQL.Add(fStrLocate(edtCodEmp,     arrEmpresas, 'DET_CODEMP',   'CODEMP'));
  qryDados.SQL.Add(fStrLocate(edtCodCliente, arrClientes, 'DET_CODCLI',   'CODCLI'));
  qryDados.SQL.Add(fStrLocate(edtGruCmp,     arrGruCmp,   'I.ITE_GRUCMP', 'GRUCMP'));
  qryDados.SQL.Add(fStrLocate(edtCodVen,     arrVended,   'DET_CODVEN',   'CODVEN'));
  qryDados.SQL.Add(fStrLocate(edtFornecedor, arrLinFor,   'I.ITE_CODFOR', 'CODFOR'));
  qryDados.SQL.Add(fStrLocate(edtMarca,      arrLinMar,   'I.ITE_CODMAR', 'CODMAR'));
  If Not fEmptyStr(mskLinhaGrupo.Text) Then
    qryDados.SQL.Add(fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU','CODGRU'));
  qryDados.SQL.Add('GROUP BY DET_CODITE');
  pSetaParam(edtCodEmp.Text,     arrEmpresas, strCodEmp, 'CODEMP', qryDados);
  pSetaParam(edtCodCliente.Text, arrClientes, strLinCli, 'CODCLI', qryDados);
  pSetaParam(edtCodVen.Text,     arrVended,   strLinVen, 'CODVEN', qryDados);
  pSetaParam(edtFornecedor.Text, arrLinFor,   strLinFor, 'CODFOR', qryDados);
  pSetaParam(edtMarca.Text,      arrLinMar,   strLinMar, 'CODMAR', qryDados);
  pSetaParam(mskLinhaGrupo.Text, arrLinGru,   strLinGru, 'CODGRU', qryDados);
  pSetaParam(edtGruCmp.Text,     arrGruCmp,   strGruCmp, 'GRUCMP', qryDados);
  qryDados.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaEntIni.Text);
  qryDados.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaEntFin.Text);
end;

procedure TfrmSelItensVendasParaPedidoCompra.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsItens);
  inherited;

end;

procedure TfrmSelItensVendasParaPedidoCompra.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_StrCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
end;

class function TfrmSelItensVendasParaPedidoCompra.fSelecionaItens: TfrmSelItensVendasParaPedidoCompra;
begin
  pCriarFormularios(TfrmSelItensVendasParaPedidoCompra, frmSelItensVendasParaPedidoCompra);
  Result := frmSelItensVendasParaPedidoCompra;
  frmSelItensVendasParaPedidoCompra.blnConfirma := False;
  frmSelItensVendasParaPedidoCompra.Showmodal;
  frmSelItensVendasParaPedidoCompra.cdsItens:= TZClient.Create(nil, '');
  If frmSelItensVendasParaPedidoCompra.blnConfirma then
  Begin
    frmSelItensVendasParaPedidoCompra.fGetSQL(frmSelItensVendasParaPedidoCompra.cdsItens.qryQuery);
    frmSelItensVendasParaPedidoCompra.cdsItens.fAbreClient(False, '[TfrmSelItensVendasParaPedidoCompra.fSelecionaItens]');
    If frmSelItensVendasParaPedidoCompra.cdsItens.IsEmpty Then
    Begin
      pMensagemOk('Não foi encontrado itens.');
      frmSelItensVendasParaPedidoCompra.blnConfirma := false;
    End;
  End;
end;

function TfrmSelItensVendasParaPedidoCompra.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If  (Sender = mskDtaEntIni) And fEmptyDate(mskDtaEntIni.Text) Then
    Begin
      pMensagemOk('Data Inicial Deve ser preenchida!');
      Result := False;
    End

    Else If  (Sender = mskDtaEntFin) And fEmptyDate(mskDtaEntFin.Text) Then
    Begin
      pMensagemOk('Data Final Deve ser preenchida!');
      Result := False;
    End

    Else if (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial Inválida!');
        Result := False;
      End;
    End
    Else
    if (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final Inválida!');
        Result := False;
      End;
      If Result Then
      Begin
        If StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
          Result := False;
        End;
      End;
    End;
  End;

  If not Result Then
    pSetFocus(Sender);
end;

procedure TfrmSelItensVendasParaPedidoCompra.mskLinhaGrupoExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);

end;

procedure TfrmSelItensVendasParaPedidoCompra.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.