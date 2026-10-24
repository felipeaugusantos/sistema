unit untManClubeFidelidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  untClubeFidelidade, DB, Mask, DBCtrls, DBEditFocus, EditFocus,
  QColorLabel, DBMemoFocus, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untMsgLiberacao, untLiberacao,
  untFatBaixaClubeFidelidade;

type
  TfrmManClubeFidelidade = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbeCodFid: TDBEditFocus;
    dtsCluFid: TDataSource;
    dbeDtaCad: TDBEditFocus;
    lblCodigo: TLabel;
    lblDtaCad: TLabel;
    bvlLinha: TBevel;
    dbeCodCli: TDBEditFocus;
    lblCliente: TLabel;
    edtDesCliente: TEditFocus;
    dbeNumDoc: TDBEditFocus;
    Label1: TLabel;
    dbeEspDoc: TDBEditFocus;
    Label2: TLabel;
    dbeCodEmp: TDBEditFocus;
    Label3: TLabel;
    edtDesEmpresa: TEditFocus;
    dbeCreDeb: TDBEditFocus;
    ColorLabel1: TColorLabel;
    dbeQtdPto: TDBEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    dbeObserv001: TDBMemoFocus;
    grpDadosBaixa: TGroupBox;
    Label6: TLabel;
    dbeDtaBai: TDBEditFocus;
    Label7: TLabel;
    dbeHraBai: TDBEditFocus;
    Label8: TLabel;
    dbeCodOpe: TDBEditFocus;
    btnBaixar: TBitBtnLocked;
    btnCancelaBaixa: TBitBtnLocked;
    edtNomeOperador: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeObserv001KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnCancelaBaixaClick(Sender: TObject);
  private
    { Private declarations }
    objCluFid         : TCluFid;
    FFltPontosAntigos : Double;

    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pAfterScroll(DataSet: TDataset);

    procedure montaLiberacaoQuantidadePontos(const AMsg: TMensagemLiberacao);
    procedure pCarregaOperador;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;


implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema;


{$R *.dfm}

procedure TfrmManClubeFidelidade.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmManClubeFidelidade.FormCreate(Sender: TObject);
begin
  inherited;

  objCluFid := TCluFid.Create(Self);
  objCluFid.qryCluFid.AfterScroll := pAfterScroll;
  
  dtsCluFid.DataSet := objCluFid.qryCluFid;

  strNomeCampo  := 'FID_CODFID';
  strNomeTabela := 'CLUFID';
  qryTabela     := objCluFid.qryCluFid;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFid;

  FFltPontosAntigos := 0;
end;

procedure TfrmManClubeFidelidade.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManClubeFidelidade.pCarregaEmpresa;
Begin
  edtDesEmpresa.Text := fRetNomeEmpresa(dbeCodEmp.Text);
End;

procedure TfrmManClubeFidelidade.pCarregaOperador;
Begin
  edtNomeOperador.Text := fRetNomeOperador(dbeCodOpe.Text);
End;

procedure TfrmManClubeFidelidade.pCarregaCliente;
Begin
  edtDesCliente.Text := fRetNomCliente(dbeCodCli.Text);
End;

procedure TfrmManClubeFidelidade.pAfterScroll(DataSet: TDataset);
Begin
  pCarregaEmpresa;
  pCarregaCliente;
  pCarregaOperador;
  FFltPontosAntigos := DataSet.FieldByName('FID_QTDPTO').AsFloat;
End;

procedure TfrmManClubeFidelidade.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManClubeFidelidade.dbeObserv001KeyPress(Sender: TObject; var Key: Char);
  Var
    strKey: String;
begin
  inherited;

  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];

end;

function TfrmManClubeFidelidade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  FObjLiberacao: TLiberacao;
begin

  Result := True;

  If (Sender = dbeCodCli) Then
  Begin

    If fEmptyStr(dbeCodCli.Text) Then
    Begin
      fMensagem('','O Cliente deve ser preenchido!',['&OK']);
      Result := False;
    End

    Else
    Begin
      pCarregaCliente;

      If fEmptyStr(edtDesCliente.Text) Then
      Begin
        fMensagem('','Cliente não encontrado!',['&OK']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = dbeCodEmp) Then
  Begin

    If fEmptyStr(dbeCodEmp.Text) Then
    Begin
      fMensagem('','A Empresa deve ser preenchida!',['&OK']);
      Result := False;
    End

    Else
    Begin
      pCarregaEmpresa;

      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('','Empresa não encontrada!',['&OK']);
        Result := False;
      End;

    End;
    
  End

  Else If (Sender = dbeCreDeb) Then
  Begin

    If Pos(dbeCreDeb.Text,'CD') <= 0 Then
    Begin
      fMensagem('','O Campo crédito/débito deve ser C ou D!',['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = dbeQtdPto) Then
  Begin

    If fStrToFloat(dbeQtdPto.Text) <= 0 Then
    Begin
      fMensagem('','O Campo qtd de pontos deve ser maior que zero!',['&OK']);
      Result := False;
    End;

    if (fStrToFloat(dbeQtdPto.Text) > FFltPontosAntigos) and
       (not fEmptyStr(dbeCodFid.Text)) and (blnBuscaPorChave) then
    begin
      try
        FObjLiberacao := TLiberacao.Create;
        FObjLiberacao.strDirAce := 'CFDPNT';
        FObjLiberacao.strMsgSen := 'Quantidade maior do que está gravado.';
        FObjLiberacao.strCodOpe := strLoginUsuarioLogado;
        montaLiberacaoQuantidadePontos(FObjLiberacao.objMsgLibera);

        if not FObjLiberacao.fLibera then
        begin
          blnMudarFoco := False;
          Result       := False;
        end;
      finally
        FreeAndNil(FObjLiberacao);
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmManClubeFidelidade.montaLiberacaoQuantidadePontos(
  const AMsg: TMensagemLiberacao);
const
  TAMANHO = 91;

var
  LIndice   : Integer;
  LTextoObs : TStrings;
  LLinha    : String;
begin
  try
    LTextoObs := TStringList.Create;
    LTextoObs.Text := dbeObserv001.Text;

    AMsg.pAddTexto('---------------------------------------------------------------------------------------------');
    AMsg.pAddTexto('       ALTERACAO DA QUANTIDADE DE PONTOS DO CLUBE FIDELIDADE PARA QUANTIDADE MAIOR');
    AMsg.pAddTexto('---------------------------------------------------------------------------------------------');

    if not fEmptyStr(dbeNumDoc.Text) then
      AMsg.pAddTexto('Documento        : '+dbeNumDoc.Text+' - Espécie: '+dbeEspDoc.Text+' - Empresa: '+dbeCodEmp.Text+'-'+Copy(edtDesEmpresa.Text,1,32));

    AMsg.pAddTexto('Cliente          : '+dbeCodCli.Text+'     - '+Copy(edtDesCliente.Text,1,59));
    AMsg.pAddTexto('D/C              : '+dbeCreDeb.Text);
    AMsg.pAddTexto('---------------------------------------------------------------------------------------------');
    AMsg.pAddTexto('Qtd Pontos Atual : '+FormatFloat('00000', FFltPontosAntigos));
    AMsg.pAddTexto('Nova Qtd Pontos  : '+FormatFloat('00000', StrToIntDef(dbeQtdPto.Text,0)));
    AMsg.pAddTexto('---------------------------------------------------------------------------------------------');
    AMsg.pAddTexto('Obs');

    for LLinha in LTextoObs do
    begin
      if LLinha.Length <= TAMANHO then
        AMsg.pAddTexto(LLinha)
      else
      begin
        LIndice := 1;
        while LIndice <= LLinha.Length do
        begin
          AMsg.pAddTexto(Copy(LLinha, LIndice, TAMANHO));
          LIndice := LIndice
                   + TAMANHO;
        end;
      end;
    end;
    AMsg.pAddTexto('---------------------------------------------------------------------------------------------');
  finally
    FreeAndNil(LTextoObs);
  end;
end;

procedure TfrmManClubeFidelidade.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('FID_CODFID');
  stlCamInd.Add('FID_NUMDOC');
  stlCamInd.Add('FID_CODCLI');
  stlCamInd.Add('CLI_NOMCLI');
  stlCamInd.Add('FID_DTACAD');

  stlDesInd.Add('Código');
  stlDesInd.Add('Documento');
  stlDesInd.Add('Cod.Cliente');
  stlDesInd.Add('Nome Cliente');
  stlDesInd.Add('Dta Cadastro');

end;

procedure TfrmManClubeFidelidade.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrClube: TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE CLUBE FIDELIDADE *}
  {**********************************RV*}
  chrKey := '/';
  If fPesqFidelidade(Self, Nil, qryTabela, chrKey, arrClube) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmManClubeFidelidade.btnBaixarClick(Sender: TObject);
  var
    frmFatBaixaClubeFidelidade : TfrmFatBaixaClubeFidelidade;
begin
  inherited;
  pCriarFormularios(TfrmFatBaixaClubeFidelidade, frmFatBaixaClubeFidelidade);
  Try
    frmFatBaixaClubeFidelidade.blnBaixa := True;
    frmFatBaixaClubeFidelidade.showModal;
  Finally
    pFreeAndNil(frmFatBaixaClubeFidelidade);
  End;
end;

procedure TfrmManClubeFidelidade.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManClubeFidelidade.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmManClubeFidelidade.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmManClubeFidelidade.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  begin
    fCommit;
    FFltPontosAntigos := StrToFloatDef(dbeQtdPto.Text,0);
  end
  Else
    fRollBack;
end;

procedure TfrmManClubeFidelidade.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    dbeDtaCad.Field.Value := VS_Date;
    dbeCodEmp.Field.Value := VS_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresa;
    dbeQtdPto.Field.Value := 0;

    If blnUsaProCodigo Then
      pHabilitaCodigo(dbeCodFid, dbeCodEmp, False)
    Else
      pHabilitaCodigo(dbeCodFid, dbeCodFid, True);
  End;

end;

procedure TfrmManClubeFidelidade.btnCancelaBaixaClick(Sender: TObject);
  var
    frmFatBaixaClubeFidelidade : TfrmFatBaixaClubeFidelidade;
begin
  inherited;
  pCriarFormularios(TfrmFatBaixaClubeFidelidade, frmFatBaixaClubeFidelidade);
  Try
    frmFatBaixaClubeFidelidade.blnBaixa := False;
    frmFatBaixaClubeFidelidade.strEmpresa := dbeCodEmp.Text;
    frmFatBaixaClubeFidelidade.strCodigo  := dbeCodFid.Text;
    frmFatBaixaClubeFidelidade.strCliente := dbeCodCli.Text;
    frmFatBaixaClubeFidelidade.ShowModal;
  Finally
    pFreeAndNil(frmFatBaixaClubeFidelidade);
  End;

  qryTabela.Refresh;

end;

procedure TfrmManClubeFidelidade.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsEdit Then
  Begin
    dbeCodEmp.Enabled := False;
    pHabilitaCodigo(dbeCodFid, dbeCodCli, False);
  End;

end;

end.

