unit untCadDepartamentos;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, System.SysUtils;

type
  TfrmCadDepartamentos = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    chkProAca: TDBCheckBox;
    chkProEmb: TDBCheckBox;
    chkProMaP: TDBCheckBox;
    chkProGra: TDBCheckBox;
    rdgSABUTI: TRadioGroup;
    dtsTabela: TDataSource;
    rdgDOMUTI: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
  private
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untPai, Forms, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadDepartamentos.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADDEP';
  strNomeCampo  := 'DEP_CODIGO';

  qryTabela := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


procedure TfrmCadDepartamentos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  inherited;
end;

function TfrmCadDepartamentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do departamento deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A Descrição do departamento deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadDepartamentos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DEP_CODIGO');
  stlCampos.Add('DEP_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DEP_DESCRI');
  stlCamInd.Add('DEP_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Grupo');
end;

procedure TfrmCadDepartamentos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If fCfgSis('UTIIND', varBoolean) Then
  Begin
    chkProAca.Visible := True;
    chkProEmb.Visible := True;
    chkProMaP.Visible := True;
    chkProGra.Visible := True;
  End
  Else
  Begin
    Self.Height := Self.Height - 22;
    rdgSABUTI.Top := chkProAca.Top;
    rdgDOMUTI.Top := chkProAca.Top;
  End;

  rdgSABUTI.Visible := fCfgSis('DUTIDP', varBoolean);
  rdgDOMUTI.Visible := fCfgSis('DUTIDP', varBoolean);

  If (Not rdgSABUTI.Visible) Then
    Self.Height := Self.Height - rdgSABUTI.Height;
end;


procedure TfrmCadDepartamentos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDepartamentos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  rdgSABUTI.ItemIndex := -1;
  rdgDOMUTI.ItemIndex := -1;
end;

procedure TfrmCadDepartamentos.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('DEP_SABUTI').AsInteger := rdgSABUTI.ItemIndex;
  qryTabela.FieldByName('DEP_DOMUTI').AsInteger := rdgDOMUTI.ItemIndex;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDepartamentos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadDepartamentos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  qryTabela.FieldByName('DEP_PROACA').AsString := 'N';
  qryTabela.FieldByName('DEP_PROEMB').AsString := 'N';
  qryTabela.FieldByName('DEP_PROMAP').AsString := 'N';
  qryTabela.FieldByName('DEP_PROGRA').AsString := 'N';

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadDepartamentos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrDep: TConsultasArray;
begin
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  chrKey := '/';
  If fPesqDepartamento(Self, Nil, Nil, qryTabela, chrKey, arrDep) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadDepartamentos.dtsTabelaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  If (Not (dtsTabela.DataSet.State in dsEditModes)) Then
  Begin
    rdgSABUTI.ItemIndex := qryTabela.FieldByName('DEP_SABUTI').AsInteger;
    rdgDOMUTI.ItemIndex := qryTabela.FieldByName('DEP_DOMUTI').AsInteger;
  End;
end;

procedure TfrmCadDepartamentos.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  rdgSABUTI.Enabled := (dtsTabela.DataSet.State In dsEditModes);
  rdgDOMUTI.Enabled := (dtsTabela.DataSet.State In dsEditModes);

  If (Not rdgSABUTI.Enabled) Then
    rdgSABUTI.ItemIndex := -1;

  If (Not rdgDOMUTI.Enabled) Then
    rdgDOMUTI.ItemIndex := -1;
end;

procedure TfrmCadDepartamentos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

end.
