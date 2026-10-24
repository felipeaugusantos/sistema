unit untIncluiPedidoRotasRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, Uni;

type
  TfrmIncluiPedidoRotasRegiao = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblPedido: TLabel;
    lblCliente: TLabel;
    lblDtEmissao: TLabel;
    lblCondPagto: TLabel;
    lblVendedor: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    mskDtaEmi: TMaskEditFocus;
    mskCndPag: TMaskEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblDtPrevisao: TLabel;
    mskPrevis: TMaskEditFocus;
    edtVlrCon: TEditFocus;
    lblValor: TLabel;
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FNumDoc: String;
    FCodEmp: String;
    FSeqFgo: String;
    FCodDig: String;
    FCodCid: String;
    FCliCep: String;
    FPesBru: Double;
    FTotPro: Double;
    procedure pCarregaTela;
    procedure pLimparTela;
    procedure pAtualizaSeqRota;
    function fValidaRota: Boolean;
    function fValidaTravas: Boolean;
  public
    { Public declarations }
    strCodRot: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation

uses
  untConsultas, untFuncoesSimples, untTypesSistema, untValidacoesRotasRegiao;

{$R *.dfm}

procedure TfrmIncluiPedidoRotasRegiao.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;

  if (not fValidaRota) then
  begin
    fMensagem('', 'O pedido informado não atende a rota!' , ['&Ok']);
    Exit;
  end;

  if (not fValidaTravas) then
    Exit;

  pAtualizaSeqRota;

  inherited;
end;

procedure TfrmIncluiPedidoRotasRegiao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmIncluiPedidoRotasRegiao.edtNumDocExit(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(edtNumDoc.Text)) then
    fValidaCampos(edtNumDoc);
end;

procedure TfrmIncluiPedidoRotasRegiao.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  LQry: TUniQuery;
  LPedido: TConsultasArray;
begin
  inherited;
  LQry := fCriaQuery(nil);

  try
    if fPesqPedOrc(conPedSimpMultEmp, Self, 'PD', '', '' , edtNumDoc, edtEspDoc, edtCodEmp, LQry, Key, LPedido) then
    begin
      edtNumDoc.Text := LQry.FieldByName('FGO_NUMDOC').AsString;
      fValidaCampos(edtNumDoc);
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmIncluiPedidoRotasRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  strCodRot := EmptyStr;
end;

procedure TfrmIncluiPedidoRotasRegiao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

function TfrmIncluiPedidoRotasRegiao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtNumDoc) and edtNumDoc.Enabled and blnBuscaPorChave then
  begin
    if fEmptyStr(edtNumDoc.Text) then
    begin
      pLimparTela;
      Result := False;
    end
    else
    begin
      edtNumDoc.Text := fStrZero(edtNumDoc.Text, 12);
      pCarregaTela;
    end;
  end
  Else If (Sender = edtCodEmp) Then
  Begin
    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
      If (fEmptyStr(edtDesEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhuma empresa encontrada com esse código!', ['&Ok']);
        edtCodEmp.Clear;
        Result := False;
      End 
      Else If (Not fEmptyStr(FNumDoc)) And (FCodEmp <> edtCodEmp.Text) Then
      Begin
        pSetFocus(edtNumDoc);
      End;
    End;
  End;

  if (not Result) then
    pSetFocus(Sender);
end;

function TfrmIncluiPedidoRotasRegiao.fValidaRota: Boolean;
const
  LSQL = 'SELECT ENT_CODIGO ' +
         'FROM ENTREG ' +
         'INNER JOIN CADREG ON REG_CODREG = ENT_CODREG ' +
         'INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG ' +
         'INNER JOIN ROTREC ON REC_CODREG = ROT_CODREG ' +
         'LEFT  JOIN bairro ON id_bairro = REC_CODBAI ' +
         'LEFT  JOIN endereco ON endereco.id_bairro = bairro.id_bairro ' +
         'WHERE ENT_STATUS = "A" ' +
         '  AND ENT_CODIGO = :SEQROT ' +
         '  AND ENT_DTAENT >= :DTAENT ' +
         '  AND ((endereco.cep = :CEPCLI) ' +
         '   OR ((REC_CODCID = :CODCID) AND (REC_CODBAI = 0))) ';
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Text := LSQL;
    LQry.ParamByName('SEQROT').AsString := strCodRot;
    LQry.ParamByName('DTAENT').AsDatetime := VS_Date;
    LQry.ParamByName('CEPCLI').AsString := FCliCep;
    LQry.ParamByName('CODCID').AsString := FCodCid;
    LQry.Open;

    Result := (not LQry.IsEmpty);
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmIncluiPedidoRotasRegiao.fValidaTravas: Boolean;
var
  LRotReg: TRotReg;
begin
  LRotReg := TRotReg.Create(Self);

  try
    try
      LRotReg.strCodRot := strCodRot;
      LRotReg.fltPesBru := FPesBru;
      LRotReg.fltTotPro := FTotPro;
      LRotReg.strCodVen := edtCodVen.Text;
      LRotReg.strCodDig := FCodDig;
      LRotReg.strNumOrc := edtNumDoc.Text + '-' + edtEspDoc.Text + '-' + edtCodEmp.Text;
      LRotReg.strCodCli := edtCodCli.Text;
      LRotReg.strSeqFgo := FSeqFgo;
      LRotReg.strEspDoc := edtEspDoc.Text;

      Result := LRotReg.fIniciaValidacoes;
    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fValidaRota]');
      end;
    end;
  finally
    FreeAndNil(LRotReg);
  end;
end;

procedure TfrmIncluiPedidoRotasRegiao.pAtualizaSeqRota;
const
  LSQL = 'UPDATE EXTGOR SET FGO_CODROT = :SEQROT WHERE FGO_SEQFGO = :SEQFGO';
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    fStartTransaction;

    try
      LQry.SQL.Text := LSQL;
      LQry.ParamByName('SEQFGO').AsString := FSeqFgo;
      LQry.ParamByName('SEQROT').AsString := strCodRot;
      LQry.ExecSQL;

      fCommit;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, '[pAtualizaSeqRota]');
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmIncluiPedidoRotasRegiao.pCarregaTela;
const
  LSQL = 'SELECT F.AUTOINCREM AS SEQFGO, FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, ' +
         '  FGO_CODCLI, CLI_NOMCLI, FGO_DTAENT, FGO_VLRCON, FGO_DTENTR, FGO_CONPAG, ' +
         '  FGO_CODVEN, OPE_NOMOPE, FGO_CODROT, FGO_PESBRU, FGO_TOTPRO, FGO_CODDIG, ' +
         '  IFNULL(ETC_CIDENT, FGO_CIDCON) AS CODCID, IFNULL(ETC_CEPENT, FGO_CEPCON) AS CLICEP ' +
         'FROM FATGOR F ' +
         'INNER JOIN EXTGOR E ON F.AUTOINCREM = E.FGO_SEQFGO ' +
         'INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI ' +
         'INNER JOIN CADOPE O ON F.FGO_CODVEN = O.OPE_CODOPE ' +
         'LEFT JOIN AUXGOR  A ON F.AUTOINCREM = A.AUX_SEQGER ' +
         'LEFT JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM ' +
         'WHERE FGO_NUMDOC = :NUMDOC ' +
         '  AND FGO_ESPDOC = :ESPDOC ' +
         '  AND FGO_CODEMP = :CODEMP ';
var
  LQry: TUniQuery;
begin
  If (FNumDoc = edtNumDoc.Text) And (FCodEmp = edtCodEmp.Text) Then
    Exit;

  LQry := fCriaQuery;

  try
    LQry.SQL.Text := LSQL;
    LQry.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    LQry.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    LQry.ParamByName('CODEMP').AsString := IIF(fEmptyStr(edtCodEmp.Text), VS_strCodEmp, edtCodEmp.Text);
    LQry.Open;

    if LQry.IsEmpty then
    begin
      fMensagem('', 'Pedido não encontrado!' , ['&Ok']);
      pLimparTela;
      Exit;
    end;

    if (not fEmptyStr(LQry.FieldByName('FGO_CODROT').AsString)) then
    begin
      fMensagem('', 'O Pedido informado já possui rota!' , ['&Ok']);
      pLimparTela;
      Exit;
    end;

    edtCodEmp.Text := LQry.FieldByName('FGO_CODEMP').AsString;
    edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    edtCodCli.Text := LQry.FieldByName('FGO_CODCLI').AsString;
    edtNomCli.Text := LQry.FieldByName('CLI_NOMCLI').AsString;
    mskDtaEmi.Text := LQry.FieldByName('FGO_DTAENT').AsString;
    edtVlrCon.Text := FormatFloat('#,##0.00', LQry.FieldByName('FGO_VLRCON').AsFloat);
    mskPrevis.Text := DateToStr(LQry.FieldByName('FGO_DTENTR').AsDateTime);
    mskCndPag.Text := LQry.FieldByName('FGO_CONPAG').AsString;
    edtCodVen.Text := LQry.FieldByName('FGO_CODVEN').AsString;
    edtNomVen.Text := LQry.FieldByName('OPE_NOMOPE').AsString;

    FSeqFgo := LQry.FieldByName('SEQFGO').AsString;
    FCodCid := LQry.FieldByName('CODCID').AsString;
    FCliCep := LQry.FieldByName('CLICEP').AsString;
    FCodDig := LQry.FieldByName('FGO_CODDIG').AsString;
    FPesBru := LQry.FieldByName('FGO_PESBRU').AsFloat;
    FTotPro := LQry.FieldByName('FGO_TOTPRO').AsFloat;

    FNumDoc := edtNumDoc.Text;
    FCodEmp := edtCodEmp.Text;
    pSetFocus(btnConfirma);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmIncluiPedidoRotasRegiao.pLimparTela;
begin
  FNumDoc := '';
  FCodEmp := '';
  edtNumDoc.Clear;
  edtEspDoc.Text := 'PD';
  edtCodCli.Clear;
  edtNomCli.Clear;
  mskDtaEmi.Clear;
  mskCndPag.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  mskPrevis.Clear;
  edtVlrCon.Clear;
end;

end.
