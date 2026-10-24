unit untCadFasApontamento;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadFasApontamento = class(TfrmPaiCad)
    pnlFundo: TPanel;
    lblDescri: TLabel;
    lblCodigo: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodApo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadApo: TUniQuery;
    dtsDados : TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

{ TfrmCadFasApontamento }

procedure TfrmCadFasApontamento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodApo, dbeDescri, False)
end;

procedure TfrmCadFasApontamento.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFasApontamento.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFasApontamento.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFasApontamento.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFasApontamento.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodApo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodApo, dbeCodApo, True);
end;

procedure TfrmCadFasApontamento.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrFasApontamento: TConsultasArray;
begin
  {*****************************************}
  {* NOVA CONSULTA DE FASE DE APONTAMENTOS *}
  {**************************************DH*}
  chrKey := '/';
  If fPesqFasApontamento(Self, Nil, Nil, qryTabela, chrKey, arrFasApontamento) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFasApontamento.FormCreate(Sender: TObject);
var
  intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADAPO';
  strNomeCampo  := 'APO_CODAPO';
  qryCadApo     := fCriarQuery('SELECT * FROM CADAPO', Self);

  qryCadApo.FieldByName('APO_CODAPO').DisplayLabel := 'Código';
  qryCadApo.FieldbyName('APO_DESCRI').DisplayLabel := 'Descrição';

  qryCadApo.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryCadApo);
  qryTabela := qryCadApo;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodApo;
end;

function TfrmCadFasApontamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodApo) Then
    Begin
      If (fEmptyStr(dbeCodApo.Text)) And (dbeCodApo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Fase do Apontamento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da Fase do Apontamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadFasApontamento.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('APO_CODAPO');
  stlCampos.Add('APO_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('APO_DESCRI');
  stlCamInd.Add('APO_CODAPO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

end.
