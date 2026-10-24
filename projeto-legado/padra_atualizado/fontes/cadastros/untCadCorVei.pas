unit untCadCorVei;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask,DBEditFocus, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem, DBCtrls,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadCorVei = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesCor: TDBEditFocus;
    dbeCodCor: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCorVei: TUniQuery;
    dtsDados: TDataSource;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadCorVei.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CORVEI';
  strNomeCampo  := 'COR_CODCOR';
  qryCorVei      := fCriarQuery('SELECT * FROM CORVEI', Self);

  qryCorVei.FieldByName('COR_CODCOR').DisplayLabel := 'Código';
  qryCorVei.FieldbyName('COR_DESCOR').DisplayLabel := 'Descrição';
  qryCorVei.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryCorVei);
  qryTabela := qryCorVei;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCor;
end;


function TfrmCadCorVei.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodCor) Then
    Begin
      If (fEmptyStr(dbeCodCor.Text)) And (dbeCodCor.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Cor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesCor) Then
    Begin
      If fEmptyStr(dbeDesCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Cor deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCorVei.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COR_CODCOR');
  stlCampos.Add('COR_DESCOR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COR_DESCOR');
  stlCamInd.Add('COR_CODCOR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Cor');
end;

procedure TfrmCadCorVei.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCorVei.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCorVei.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadCorVei.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCorVei.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCor, dbeDesCor, False)
  Else
    pHabilitaCodigo(dbeCodCor, dbeCodCor, True);

end;

procedure TfrmCadCorVei.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCor: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCorVeiculo(Self, Nil, Nil, qryTabela, chrKey, arrCor) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCorVei.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCor, dbeDesCor, False);
end;

end.
