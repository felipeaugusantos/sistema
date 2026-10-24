unit untCadGruCompras;

interface

uses
  Windows, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Classes,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus, BitBtnLockedIncrem, SysUtils;

type
  TfrmCadGruCompras = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    dbeCodGru: TDBEditFocus;
    dbeDesGru: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtNomRes: TEditFocus;
    dbeOpeRes: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeOpeResKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCadGru: TUniQuery;
    dtsCadGru: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pAfterScrool(DataSet: TDataSet);
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Variants, Forms, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadGruCompras }

procedure TfrmCadGruCompras.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}
  qryCadGru := fCriarQuery('SELECT * FROM GRU_COMPRA', Self);

  qryCadGru.FieldByName('GRU_CODIGO').DisplayLabel := 'Código';
  qryCadGru.FieldbyName('GRU_DESCRI').DisplayLabel := 'Descrição';

  qryCadGru.FieldbyName('GRU_OPERES').Visible := False;
  qryCadGru.FieldByName('GRU_CODEMP').Visible := False;
  qryCadGru.FieldByName('AUTOINCREM').Visible := False;

  dtsCadGru := fCriaDataSource(qryCadGru);

  qryCadGru.AfterScroll := pAfterScrool;
end;

procedure TfrmCadGruCompras.pLigaDataSets;
  Var
    intCont: Integer;
begin
  {***********************************************************}
  {* LIGA TODOS OS DBEDITS NO DATASOUCE CRIADO DINAMICAMENTE *}
  {********************************************************PH*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadGru;
    End;
  End;

  {**************************************}
  {* LIGA OS DBEDITS NOS DEVIDOS CAMPOS *}
  {***********************************PH*}
  dbeCodGru.DataField := 'GRU_CODIGO';
  dbeDesGru.DataField := 'GRU_DESCRI';
  dbeOpeRes.DataField := 'GRU_OPERES';  

  qryTabela := qryCadGru;
  strNomeTabela := 'GRU_COMPRA';
  strNomeCampo  := 'GRU_CODIGO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGru;

end;

procedure TfrmCadGruCompras.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;
end;

function TfrmCadGruCompras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDesGru Then
    Begin
      If fEmptyStr(dbeDesGru.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
      End;
    End

    Else If (Sender = dbeOpeRes) Then
    Begin
      If fEmptyStr(dbeOpeRes.Text) Then
      Begin
        edtNomRes.Clear;
        dbeOpeRes.Field.Value := Null;
      End
      Else
      Begin
        edtNomRes.Text := fRetNomVendRep(dbeOpeRes.Text);
        If fEmptyStr(edtNomRes.Text) Then
        Begin
          pMensagemOk('Responsável não cadastrado!');
          Result := False;
        End;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadGruCompras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GRU_CODIGO');
  stlCampos.Add('GRU_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GRU_DESCRI');
  stlCamInd.Add('GRU_CODIGO');
  stlCamInd.Add('AUTOINCREM');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadGruCompras.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGruCompras.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGruCompras.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGruCompras.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGruCompras.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodGru, dbeDesGru, False)
  Else
    pHabilitaCodigo(dbeCodGru, dbeCodGru, True);
end;

procedure TfrmCadGruCompras.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoCompra(Self, Nil, Nil, qryTabela, chrKey, arrGrupo) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadGruCompras.dbeOpeResKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeOpeRes, edtNomRes,nil, Key, arrSel) then
  Begin
    fValidaCampos(dbeOpeRes, True);
		Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadGruCompras.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodGru, dbeDesGru, False);
end;

procedure TfrmCadGruCompras.pAfterScrool(DataSet: TDataSet);
begin
  If DataSet.Active Then
    edtNomRes.Text := fRetNomeOperador(DataSet.FieldByName('GRU_OPERES').AsString);
end;

end.
