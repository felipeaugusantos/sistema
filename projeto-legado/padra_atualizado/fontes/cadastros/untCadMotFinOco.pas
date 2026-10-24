unit untCadMotFinOco;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils, Forms, EditFocus;

type
  TfrmCadMotFinOco = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbeCodigo: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    dbeDescri: TDBEditFocus;
    dbcUsaStatus_D: TDBCheckBox;
    dbcUsaStatus_I: TDBCheckBox;
    lblTrocarCat: TLabel;
    dbeCodCat: TDBEditFocus;
    edtDesCat: TEditFocus;
    dbcUsaStatus_A: TDBCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure dbcUsaStatus_DClick(Sender: TObject);
    procedure dbcUsaStatus_IClick(Sender: TObject);
    procedure dbcUsaStatus_AClick(Sender: TObject);
  private
    dtsDados: TDataSource;
    { Private declarations }
    procedure pCarregarCategoria;
    function fVerificaPodeSelecionar(Sender: TWinControl): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadMotFinOco.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'MOTOCO';
  strNomeCampo  := 'MOT_CODIGO';
  qryTabela     := fCriarQuery('SELECT * FROM MOTOCO', Self);

  dtsDados  := fCriaDataSource(qryTabela);

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End
    Else If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


function TfrmCadMotFinOco.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Motivo deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'O motivo da finalização da ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCat) Then
    Begin
      pCarregarCategoria;
      If fEmptyStr(edtDesCat.Text) And  (Not fEmptyStr(dbeCodCat.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta Categoria não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbcUsaStatus_D) Then
    Begin
      If dbcUsaStatus_D.Checked And dbcUsaStatus_I.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [I] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_D.Checked := False;
        Result := False;
      End

      Else If dbcUsaStatus_D.Checked And dbcUsaStatus_A.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [A] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_D.Checked := False;
        Result := False;
      End;
    End

    Else If (Sender = dbcUsaStatus_I) Then
    Begin
      If dbcUsaStatus_D.Checked And dbcUsaStatus_I.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [D] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_I.Checked := False;
        Result := False;
      End
      Else If dbcUsaStatus_D.Checked And dbcUsaStatus_I.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [A] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_I.Checked := False;
        Result := False;
      End;
    End

    Else If (Sender = dbcUsaStatus_A) Then
    Begin
      If dbcUsaStatus_D.Checked And dbcUsaStatus_A.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [D] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_A.Checked := False;
        Result := False;
      End
      Else If dbcUsaStatus_A.Checked And dbcUsaStatus_I.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo de finalização já está configurado para "Atribuir o Status [I] para o Prospecto". Verifique!', ['&Ok']);
        dbcUsaStatus_A.Checked := False;
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadMotFinOco.fVerificaPodeSelecionar(Sender: TWinControl): Boolean;
begin
  Result := fValidaCampos(Sender);
end;

procedure TfrmCadMotFinOco.pCarregarCategoria;
begin
  edtDesCat.Clear;

  If fEmptyStr(dbeCodCat.Text) Then
    Exit;

  edtDesCat.Text := fRetDesCrmCat(dbeCodCat.Text);
end;

procedure TfrmCadMotFinOco.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MOT_CODIGO');
  stlCampos.Add('MOT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MOT_DESCRI');
  stlCamInd.Add('MOT_CODIGO');

  stlDesInd.Add('Motivo de Finalizacao de Ocorrência');
  stlDesInd.Add('Código Motivo');
end;

procedure TfrmCadMotFinOco.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadMotFinOco.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMotFinOco.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMotFinOco.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('MOT_STAT_D').AsString := 'N';
  qryTabela.FieldByName('MOT_STAT_I').AsString := 'N';
  qryTabela.FieldByName('MOT_STAT_A').AsString := 'N';

end;

procedure TfrmCadMotFinOco.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrMotivo: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMotFinOco(Self, Nil, Nil, qryTabela, chrKey, arrMotivo) Then
  Begin
    If fValidaCampos(dbeCodCat, True) Then
      pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadMotFinOco.dbcUsaStatus_AClick(Sender: TObject);
begin

  If Not fVerificaPodeSelecionar(TWinControl(Sender)) Then
    Exit;

  inherited;

end;

procedure TfrmCadMotFinOco.dbcUsaStatus_DClick(Sender: TObject);
begin
  If Not fVerificaPodeSelecionar(TWinControl(Sender)) Then
    Exit;

  inherited;

end;

procedure TfrmCadMotFinOco.dbcUsaStatus_IClick(Sender: TObject);
begin
  If Not fVerificaPodeSelecionar(TWinControl(Sender)) Then
    Exit;

  inherited;

end;

procedure TfrmCadMotFinOco.dbeCodCatKeyPress(Sender: TObject; var Key: Char);
Var
  arrCateg: TConsultasArray;
begin
  inherited;

  If fPesqCategoriaCRM(Self, dbeCodCat, edtDesCat, nil, Key, arrCateg) Then
  Begin
    If fValidaCampos(dbeCodCat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMotFinOco.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

end.
