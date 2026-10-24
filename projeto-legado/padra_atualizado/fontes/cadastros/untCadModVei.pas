unit untCadModVei;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  EditFocus, frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadModVei = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesMod: TDBEditFocus;
    dbeCodMod: TDBEditFocus;
    lbl5: TLabel;
    dbeCodMar: TDBEditFocus;
    edtDesMar: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodMarChamaCadastro(Key: Word): string;
    procedure dbeCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryModVei: TUniQuery;
    dtsDados: TDataSource;
    procedure pAfterScroll(DataSet: TDataSet);
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untFuncIns, untTypesSistema;

{$R *.dfm}

procedure TfrmCadModVei.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'MODVEI';
  strNomeCampo  := 'MOD_CODMOD';
  qryModVei      := fCriarQuery('SELECT * FROM MODVEI', Self);

  qryModVei.FieldByName('MOD_CODMOD').DisplayLabel := 'Código';
  qryModVei.FieldbyName('MOD_DESMOD').DisplayLabel := 'Descrição';
  qryModVei.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryModVei);
  qryTabela := qryModVei;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMod;
end;


function TfrmCadModVei.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodMod) Then
    Begin
      If (fEmptyStr(dbeCodMod.Text)) And (dbeCodMod.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Modelo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesMod) Then
    Begin
      If fEmptyStr(dbeDesMod.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Modelo deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodMar) Then
    Begin
      If Not fEmptyStr(dbeCodMar.Text) Then
      Begin
        edtDesMar.Text := fRetDesMarcaVeic(dbeCodMar.Text);
        If fEmptyStr(edtDesMar.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Marca de veículo não cadastrada!', ['&O k']);
          Result := False;
        End
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'A Marca de veículo deve ser informada!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadModVei.pAfterScroll(DataSet: TDataSet);
begin
  edtDesMar.Text := fRetDesMarcaVeic(dbeCodMar.Text);
end;

procedure TfrmCadModVei.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MOD_CODMOD');
  stlCampos.Add('MOD_DESMOD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MOD_DESMOD');
  stlCamInd.Add('MOD_CODMOD');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Modelo');
end;

procedure TfrmCadModVei.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadModVei.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadModVei.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadModVei.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadModVei.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMod, dbeDesMod, False)
  Else
    pHabilitaCodigo(dbeCodMod, dbeCodMod, True);

end;

procedure TfrmCadModVei.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrModelo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqModeloVeiculo(Self, Nil, Nil, qryTabela, chrKey, arrModelo, True, '', True) Then
    pSetFocus(btnAlterar);
end;

function TfrmCadModVei.dbeCodMarChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaMarVei(Key);
end;

procedure TfrmCadModVei.dbeCodMarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMarca: TConsultasArray;
begin
  If fPesqMarcaVeiculo(Self, dbeCodMar, edtDesMar, nil, Key, arrMarca) Then
    If fValidaCampos(dbeCodMar) Then
      SelectNext(dbeCodMar, True, True);
end;

procedure TfrmCadModVei.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMod, dbeDesMod, False);
end;

end.
