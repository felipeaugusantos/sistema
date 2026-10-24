unit untCadTiposIntegracaoWS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, QColorLabel, Data.DB, Uni;

type
  TfrmCadTiposIntegracaoWS = class(TfrmPaiCad)
    pnlFundo: TPanel;
    lblDescricao: TLabel;
    lblCodigo: TLabel;
    lblSituacao: TLabel;
    ColorLabel1: TColorLabel;
    lblCodigoOriginal: TLabel;
    lblSiglaNumPok: TLabel;
    dbeDescricao: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    dbeCodOri: TDBEditFocus;
    dbeSiglaNumPok: TDBEditFocus;
    dtsCadTip: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeStatusEnter(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodOriKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadTiposIntegracaoWS: TfrmCadTiposIntegracaoWS;

implementation

uses
  untFuncoes,
  untFuncoesSimples,
  untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadTiposIntegracaoWS.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadTiposIntegracaoWS.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadTiposIntegracaoWS.btnExcluirClick]');
      End;
    End;
  Finally
    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadTiposIntegracaoWS.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    Try
      If (qryTabela.State = dsInsert) Then
        qryTabela.FieldByName('SIS_CODSIS').AsString := fAtualizaProcod('CONECTA_SISEXT', 'SIS_CODSIS'); //fRetornaProximoCodigo;

      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadTiposIntegracaoWS.btnGravarClick]');
      End;
    End;
  Finally
    If blnGravou Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadTiposIntegracaoWS.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescricao, False);
  qryTabela.FieldByName('SIS_ATIVO_').AsString := 'A';
  pSetFocus(dbeDescricao);
end;

procedure TfrmCadTiposIntegracaoWS.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoIntegracaoWS(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTiposIntegracaoWS.dbeCodOriKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
    qryConOri : TUniQuery;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    qryConOri := fCriaQuery(Self);
    Try
      if fPesqOrigemPedidoVenda(Self, dbeCodOri, Nil, qryConOri, Key, arrSel, True) then
      Begin
        If (fValidaCampos(dbeCodOri, True)) Then
          SelectNext(ActiveControl, True, True);
      End;
    Finally
      FreeAndNil(qryConOri);
    End;
  End;
end;

procedure TfrmCadTiposIntegracaoWS.dbeStatusEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeStatus.Text) Then
    dbeStatus.Text := 'A';
end;

procedure TfrmCadTiposIntegracaoWS.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CONECTA_SISEXT';
  strNomeCampo      := 'SIS_CODSIS';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  blnUsaProCodigo := True;
end;

procedure TfrmCadTiposIntegracaoWS.FormShow(Sender: TObject);
begin
  qryTabela         := fCriarQuery('SELECT * FROM CONECTA_SISEXT WHERE FALSE', Self);
  inherited;

  dtsCadTip.DataSet := qryTabela;
  qryTabela.Open;
end;

function TfrmCadTiposIntegracaoWS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Descrição" deve ser preenchido!', ['&Ok']);
      End;
    End
    Else If Sender = dbeStatus Then
    Begin
      If fEmptyStr(dbeStatus.Text) Or (Not MatchStr(dbeStatus.Text, ['A', 'I'])) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Situação" deve ser preenchido com "A" ou "I"!', ['&Ok']);
      End;
    End
    Else If Sender = dbeCodOri Then
    Begin
      If Not fEmptyStr(dbeCodOri.Text) Then
      Begin
        If fEmptyStr(fRetOrigemPedidoVenda(dbeCodOri.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código Original não encontrado!', ['&Ok']);
          Result := False;
        End
      End;
    End
    Else If Sender = dbeSiglaNumPok Then
    Begin
      If fEmptyStr(dbeSiglaNumPok.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Campo "Sigla NUMPOK" deve ser preenchido!', ['&Ok']);
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTiposIntegracaoWS.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SIS_SISEXT');
  stlCampos.Add('SIS_CODSIS');

  stlCamInd.Add('SIS_SISEXT');
  stlCamInd.Add('SIS_CODSIS');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
