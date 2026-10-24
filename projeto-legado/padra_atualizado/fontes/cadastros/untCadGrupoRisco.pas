unit untCadGrupoRisco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  Data.DB, Uni;

type
  TfrmCadGrupoRisco = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodGru: TDBEditFocus;
    Label2: TLabel;
    dbeDesGru: TDBEditFocus;
    Label3: TLabel;
    dbeAtrMax: TDBEditFocus;
    dtsCadGrr: TDataSource;
    btnAcesso: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnAcessoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untDirAcessoTotal,
  untTAcessoGrupoRisco;

procedure TfrmCadGrupoRisco.btnAcessoClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotal;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotal, frmDirAcessoTotal);
  Try
    frmDirAcessoTotal.blnMostraGrupo := True;
    frmDirAcessoTotal.objAceTot := TAcessoGrupoRisco.Create(qryTabela.FieldByName('AUTOINCREM').AsString);

    frmDirAcessoTotal.showModal;
  Finally
    pFreeAndNil(frmDirAcessoTotal);
  End;
end;

procedure TfrmCadGrupoRisco.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGru, dbeDesGru, False);
  btnAcesso.Enabled := False;
end;

procedure TfrmCadGrupoRisco.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnAcesso.Enabled := Not qryTabela.IsEmpty;
end;

procedure TfrmCadGrupoRisco.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoRisco.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  btnAcesso.Enabled := Not qryTabela.IsEmpty;
end;

procedure TfrmCadGrupoRisco.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGrupoRisco.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnAcesso.Enabled := True;
end;

procedure TfrmCadGrupoRisco.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGru, dbeDesGru, Not blnUsaProCodigo);
  btnAcesso.Enabled := False;
end;

procedure TfrmCadGrupoRisco.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqGrupoRisco(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
    pSetFocus(btnAlterar);
  btnAcesso.Enabled := Not qryTabela.IsEmpty;
end;

procedure TfrmCadGrupoRisco.btnSairClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCadGrupoRisco.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela         := fCriarQuery('SELECT * FROM GRURIS WHERE FALSE', Self);
  dtsCadGrr.DataSet := qryTabela;

  strNomeTabela := 'GRURIS';
  strNomeCampo  := 'GRR_CODIGO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGru;
end;

procedure TfrmCadGrupoRisco.FormShow(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('GRR_CODIGO').DisplayLabel := 'Código';
  qryTabela.FieldByName('GRR_DESCRI').DisplayLabel := 'Descrição';
  qryTabela.FieldByName('GRR_ATRMAX').DisplayLabel := 'Atraso máx.';
  pSetFocus(btnIncluir);
end;

function TfrmCadGrupoRisco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Not blnUsaProCodigo) And (Sender = dbeCodGru) Then
    Begin

      If fEmptyStr(dbeCodGru.Text) Then
      Begin
        fMensagem('','O código do grupo de risco deve ser informado!',['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = dbeDesGru) Then
    Begin

      If fEmptyStr(dbeDesGru.Text) Then
      Begin
        fMensagem('','A descrição do grupo de risco deve ser informada!',['&OK']);
        Result := False;
      End;

    End
    Else If (Sender = dbeAtrMax) Then
    Begin

      If fEmptyStr(dbeAtrMax.Text) Then
      Begin
        fMensagem('','A quantidade de dias de atraso máximo deve ser informada!',['&OK']);
        Result := False;
      End
      Else If StrToInt(dbeAtrMax.Text) <= 0 Then
      Begin
        fMensagem('','A quantidade de dias de atraso máximo deve ser maior que zero!',['&OK']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadGrupoRisco.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('GRR_CODIGO');
  stlCamInd.Add('GRR_DESCRI');
  stlCamInd.Add('GRR_ATRMAX');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Atraso máx.');
end;

end.
